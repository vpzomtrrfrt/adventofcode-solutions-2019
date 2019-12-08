; AAAAAAAAA
; WHAT AM I DOING
; THIS TOOK MANY HOURS

(require 'clojure.set)

(defn manhattan
  [pos]
  (+ (Math/abs (:x pos)) (Math/abs (:y pos))))

(defn move
  [pos direction]
  (case direction
    \U {:x (:x pos), :y (- (:y pos) 1)}
    \D {:x (:x pos), :y (+ (:y pos) 1)}
    \L {:x (- (:x pos) 1), :y (:y pos)}
    \R {:x (+ (:x pos) 1), :y (:y pos)}))

(defn wireStepInner
  [[board pos direction] _]
  (let [newPos (move pos direction)]
      [(conj board newPos) newPos direction]))

(defn wireStep
  [[board pos] step]
  (let [
        direction (get step 0)
        distance (Integer/parseInt (subs step 1))
        ]
    (let [
          [newBoard newPos _] (reduce wireStepInner [board pos direction] (range 0 distance))
          ] [newBoard newPos])))

(defn getWirePath
  [wire]
  (let [
        [board _] (reduce wireStep [#{} {:x 0, :y 0}] wire)
        ] board))

(println (apply min (map manhattan (apply clojure.set/intersection (map
                      getWirePath
  (map #(clojure.string/split % #",") (clojure.string/split-lines (slurp *in*))))))))
