(require 'clojure.set)

(defn move
  [pos direction]
  (case direction
    \U {:x (:x pos), :y (- (:y pos) 1)}
    \D {:x (:x pos), :y (+ (:y pos) 1)}
    \L {:x (- (:x pos) 1), :y (:y pos)}
    \R {:x (+ (:x pos) 1), :y (:y pos)}))

(defn wireStepInner
  [[board pos direction traveled] _]
  (let [newPos (move pos direction)]
    (let [
          newBoard (if (contains? board newPos) board (assoc board newPos traveled))
          ] [newBoard newPos direction (+ traveled 1)])))

(defn wireStep
  [[board pos traveled] step]
  (let [
        direction (get step 0)
        distance (Integer/parseInt (subs step 1))
        ]
    (let [
          [newBoard newPos _ traveled] (reduce wireStepInner [board pos direction traveled] (range 0 distance))
          ] [newBoard newPos traveled])))

(defn getWirePath
  [wire]
  (let [
        [board _] (reduce wireStep [{} {:x 0, :y 0} 1] wire)
        ] board))

(defn sum
  [src]
  (reduce + src))

(defn totalTravel
  [paths point]
  (sum (map #(get % point) paths)))

(let [
      paths (map
                      getWirePath
  (map #(clojure.string/split % #",") (clojure.string/split-lines (slurp *in*))))
      ]
  (println (apply min (map #(totalTravel paths %) (apply clojure.set/intersection (map #(apply hash-set %) (map keys paths)))))))
