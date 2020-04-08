Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF1D1A2934
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 21:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgDHTNc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 15:13:32 -0400
Received: from mail-mw2nam10on2094.outbound.protection.outlook.com ([40.107.94.94]:3363
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728195AbgDHTNc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 15:13:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLeXMN6tf35G8H97mHk978uVLWqg2AiJn0FdAGjM0cwX7lVoYk7an1nZFfQStLmmvY10A8qom9BHfnXMKBMKIoTZsCqX4cW0FwBOz4dLQ316T1nPm5H/v40s195jGrw0VAONmxgvxvog0md04WGxWd36mNTFb3tfJpkSxeQTuroZl1G3AxPKKpCvZUZtEFqmPMxsuhn8U5DB+kP5FSyC/gdfH3LOYAa5Mah2N5ZQosTnjMxc8wTkJPUWMeWiXRsqS2l6vmH0a4M3c8XRtyOJteQqePAfIh4jCBuWhkH0BnxTDsF3CcG+0wUpIkPQijjqnPw1LSrwS9aqlFC3pBLpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxSQ/x1AVOqCuPuxzfUHjtoi4MkWizjnTc7iKlf0d5k=;
 b=OPxxv4t8l0WwGqGfoxubiku2sWX6kREpUST4s42lNlvYsKfYcIPUHsfWfldUQGL6wLujcUNTyTKqq8GtudefJK/grDOONWH3DC77s92Qt/XBvBxQmJ+8a8ZWNzymvkqiwZz2t1jCSNHXPBxmV88NNQChScp0uHhOknrlZs/TTNN9U9UKbnUDrAuVWwPWXSe9vy/Ttc8Xy1job4g8Jg1LEcC1Ti02w7mjIIMH4XAQMeSjfuJDRF6LsD1PyB38amy/9U9zGEIeIJ1l0ZllcK4IvYunz8qsqIRtjUJTf97fnOhQbVyfy5SvXali7L9y9K79XFmQhUnJGnuezVQNo5cd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxSQ/x1AVOqCuPuxzfUHjtoi4MkWizjnTc7iKlf0d5k=;
 b=r0+A24z3QdO5ORY/9uRlRJl233NSjjW1k0LCpBOFWGwnYBKWVg/cR75TQYq4p6lrHhFlu+cyZgzsB8ISGSsSiF1CXIdExhCW94dmt9wRWpZ/+NyKJQk/VzJLkFHfuFpnGu7Gvyyec3oet0iTJH+fin9kK+5L/ZxxNILT36Px2PY=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (2603:10b6:300:2::27)
 by MWHPR13MB1791.namprd13.prod.outlook.com (2603:10b6:300:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.14; Wed, 8 Apr
 2020 19:13:24 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7c:8ba0:7659:de57]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7c:8ba0:7659:de57%7]) with mapi id 15.20.2900.012; Wed, 8 Apr 2020
 19:13:24 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     shuah <shuah@kernel.org>, "tbird20d@gmail.com" <tbird20d@gmail.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] selftests: add 'show_targets' make target
Thread-Topic: [PATCH] selftests: add 'show_targets' make target
Thread-Index: AQHWDTMVVCaYxjraQkm2jQCoGGE666hvlniA
Date:   Wed, 8 Apr 2020 19:13:24 +0000
Message-ID: <MWHPR13MB08956A9CCDC35F33AA36BCC6FDC00@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <1584138204-12238-1-git-send-email-tim.bird@sony.com>
 <03793337-65b3-7b7a-3822-ee32f7d6943f@kernel.org>
In-Reply-To: <03793337-65b3-7b7a-3822-ee32f7d6943f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.66.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b80436e2-dcaf-4777-de14-08d7dbf0e934
x-ms-traffictypediagnostic: MWHPR13MB1791:
x-microsoft-antispam-prvs: <MWHPR13MB1791D23EA1C3E824FDD75FB3FDC00@MWHPR13MB1791.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR13MB0895.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(7696005)(54906003)(71200400001)(316002)(33656002)(53546011)(81166007)(8936002)(9686003)(110136005)(478600001)(55016002)(64756008)(6506007)(66946007)(66446008)(2906002)(66476007)(4326008)(86362001)(5660300002)(8676002)(26005)(66556008)(52536014)(76116006)(186003)(81156014);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JjSRG+vjG3ZAIo8ILjuupaZPb1RVxzjD00bAWxAEpBaF7arEIojCX4cK8MlB4ks1vJLEK3JBSb3BTUq+pX08VcZErHrC3iIQSQ07ZcAmd2NaEb2oCa6wEEduH1JQiqXFv5oDXtxZfE2DDg7MuDn+pGT09MOq1lb4isEjlHYZYlWlfkUK7Me4wvkeY4v5kZHElqNNmiOfw84CFEv75O2jf7SwZon/Nq/9H1gApRKB2KPfoCefiLTCoF+YfnrEWLqBTdo3UzwF2/Nku23J2oeK8eWO0HkN3A13WoStMIyak/zXJUWhhkWNm8ER8FPArcwhB9BWrAkbGSMNIXf6Iprrgt6EnPYqatw8ABO8Lp4cPhtR5vWe+N3vmEmsGrlT3Ywy5zcsxx/2YwRvVfB/lOaHW/1oiNPHbO1i1LIKlXkMPI+cvQdAfwaFjSARrFZ3XzTc
x-ms-exchange-antispam-messagedata: 4+ZXJAgxIQ6WpvQUY9YCemLy8GRni0J4ztyKL0xDZyARBzJVpCaGTdmOd0Olv1heSp23XP0FBnronuJRccjfp17ueGe+8KUIVQJI7/eHCG5jw0ZBA6+jrll/WIi0Ife97rV654SYQ5uTGEefKd3aeQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80436e2-dcaf-4777-de14-08d7dbf0e934
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 19:13:24.7064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUf7+dsZw4Ck5pez/9ZU74kFEkaleWsAvLKFqxaaDqz27V2RfgJEVF0eFjPcvn191iUG/hmguXU8GBXe41Hwfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1791
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2h1YWggPHNodWFoQGtl
cm5lbC5vcmc+DQo+IA0KPiBPbiAzLzEzLzIwIDQ6MjMgUE0sIHRiaXJkMjBkQGdtYWlsLmNvbSB3
cm90ZToNCj4gPiBGcm9tOiBUaW0gQmlyZCA8dGltLmJpcmRAc29ueS5jb20+DQo+ID4NCj4gPiBJ
dCBpcyB1c2VmdWwgZm9yIENJIHN5c3RlbXMgdG8gYmUgYWJsZSB0byBxdWVyeSB0aGUgbGlzdA0K
PiA+IG9mIHRhcmdldHMgcHJvdmlkZWQgYnkga3NlbGZ0ZXN0IGJ5IGRlZmF1bHQsIHNvIHRoYXQg
dGhleQ0KPiA+IGNhbiBjb25zdHJ1Y3QgdGhlaXIgb3duIGxvb3Agb3ZlciB0aGUgdGFyZ2V0cyBp
ZiBkZXNpcmVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGltIEJpcmQgPHRpbS5iaXJkQHNv
bnkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvTWFrZWZpbGUg
fCAzICsrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvTWFrZWZpbGUNCj4gPiBpbmRleCA2MzQzMGUyLi45OTU1ZTcxIDEwMDY0
NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlDQo+ID4gKysrIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvTWFrZWZpbGUNCj4gPiBAQCAtMjQ2LDQgKzI0Niw3IEBA
IGNsZWFuOg0KPiA+ICAgCQkkKE1BS0UpIE9VVFBVVD0kJEJVSUxEX1RBUkdFVCAtQyAkJFRBUkdF
VCBjbGVhbjtcDQo+ID4gICAJZG9uZTsNCj4gPg0KPiA+ICtzaG93X3RhcmdldHM6DQo+ID4gKwlA
ZWNobyAkKFRBUkdFVFMpDQo+ID4gKw0KPiA+ICAgLlBIT05ZOiBraGRyIGFsbCBydW5fdGVzdHMg
aG90cGx1ZyBydW5faG90cGx1ZyBjbGVhbl9ob3RwbHVnIHJ1bl9wc3RvcmVfY3Jhc2ggaW5zdGFs
bCBjbGVhbg0KPiA+DQo+IA0KPiBIaSBUaW0sDQo+IA0KPiBJdCBpcyB1c2VmdWwgYWRkaXRpb24u
IE91dHB1dCBpcyBoYXJkIHRvIHJlYWQgdGhvdWdoLiBJdCB3b3VsZA0KPiBiZSBoZWxwZnVsIHRv
IGltcHJvdmUgdGhlIHByaW50aW5nIHRhcmdldHMuDQo+DQo+IG1ha2UgLUMgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvIHNob3dfdGFyZ2V0cw0KPiBtYWtlOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9s
a21sL2xpbnV4XzUuNy90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cycNCj4gYW5kcm9pZCBhcm02NCBi
cGYgYnJlYWtwb2ludHMgY2FwYWJpbGl0aWVzIGNncm91cCBjbG9uZTMgY3B1ZnJlcQ0KPiBjcHUt
aG90cGx1ZyBkcml2ZXJzL2RtYS1idWYgZWZpdmFyZnMgZXhlYyBmaWxlc3lzdGVtcw0KPiBmaWxl
c3lzdGVtcy9iaW5kZXJmcyBmaWxlc3lzdGVtcy9lcG9sbCBmaXJtd2FyZSBmdHJhY2UgZnV0ZXgg
Z3Bpbw0KPiBpbnRlbF9wc3RhdGUgaXBjIGlyIGtjbXAga2V4ZWMga3ZtIGxpYiBsaXZlcGF0Y2gg
bGtkdG0gbWVtYmFycmllciBtZW1mZA0KPiBtZW1vcnktaG90cGx1ZyBtb3VudCBtcXVldWUgbmV0
IG5ldC9mb3J3YXJkaW5nIG5ldC9tcHRjcCBuZXRmaWx0ZXIgbnNmcw0KPiBwaWRmZCBwaWRfbmFt
ZXNwYWNlIHBvd2VycGMgcHJvYyBwc3RvcmUgcHRyYWNlIG9wZW5hdDIgcnNlcSBydGMgc2VjY29t
cA0KPiBzaWdhbHRzdGFjayBzaXplIHNwYXJjNjQgc3BsaWNlIHN0YXRpY19rZXlzIHN5bmMgc3lz
Y3RsIHRpbWVucyB0aW1lcnMNCj4gdG1wZnMgdHBtMiB1c2VyIHZtIHg4NiB6cmFtDQo+IA0KPiB0
aGFua3MsDQo+IC0tIFNodWFoDQoNCk9LLiAgSSBkaWQgdGhpcyBtYWlubHkgZm9yIHRlc3QgYXV0
b21hdGlvbiwgc28gSSB3YXMgb25seQ0KY29uY2VybmVkIGFib3V0IG1hY2hpbmUgcmVhZGFiaWxp
dHkuICBJIGhhdmUgY29kZSB0aGF0IGxvb2tzDQpsaWtlIHRoaXM6DQoNClRBUkdFVF9MSVNUPSQo
bWFrZSAtLW5vLXByaW50LWRpcmVjdG9yeSAtcyAtQyB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cyBz
aG93X3RhcmdldHMpDQoNCkhvd2V2ZXIsIEknZCBhZ3JlZSB0aGF0IHRoZSBvdXRwdXQgaXMgbm90
IGdyZWF0IGZvciBodW1hbnMuDQoNCkhvdyB3b3VsZCB5b3UgbGlrZSBpdCBpbXByb3ZlZD8gIFdv
dWxkIHlvdSBsaWtlIGl0IHNob3duIGFzIGEgc2luZ2xlIGNvbHVtbj8NCk9yIGluZGVudGVkPyAg
T3IgdXNpbmcgc29tZSBvcmdhbml6YXRpb24gYmVzaWRlcyBhbHBoYWJldGljYWw/DQoNCkxldCBt
ZSBrbm93IGFuZCBJJ2xsIGltcGxlbWVudCBzb21ldGhpbmcuDQogLS0gVGltDQoNCg==
