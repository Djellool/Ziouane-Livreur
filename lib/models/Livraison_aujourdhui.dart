// ignore: camel_case_types
class Livraison_aujourdhui {
  int livraisons;
  int distanceTotale;
  double CA_aujourdhui;
  double benifice_aujourdhui;
  String prix;
  double evaluationMoyenne;

  Livraison_aujourdhui(
      {this.livraisons,
      this.distanceTotale,
      this.CA_aujourdhui,
      this.benifice_aujourdhui,
      this.evaluationMoyenne});

  Livraison_aujourdhui.fromJson(Map<String, dynamic> json) {
    livraisons = json['livraisons'];
    distanceTotale = json['distance_totale'];
    prix = json['prix'];
    evaluationMoyenne = double.parse(json['evaluation'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['livraisons'] = this.livraisons;
    data['distance_totale'] = this.distanceTotale;
    data['prix'] = this.prix;
    data['evaluation'] = this.evaluationMoyenne;
    return data;
  }
}
