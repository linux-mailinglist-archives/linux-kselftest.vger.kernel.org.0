Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE90E1B7CBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 19:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgDXR3D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 13:29:03 -0400
Received: from mail-dm6nam10on2118.outbound.protection.outlook.com ([40.107.93.118]:59617
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728508AbgDXR3C (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 13:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0WHyVebHZb5gbh+uUlzxlNEWtzK8cGAmuPth3QLJP3YxGVZIwgnXLbrQnR3gjKyKnaxVVFoTeYi6yrqMe1SCTMFQaNXDC7LFRkuMDrugeje7MQoeShiehKNE/rd5pnJKAQSBrbl24YRTbtwcZzGxcCZPh5FJkOmaSoDmgEZPWS+arGCKFrMfTtyqrx0EnpaBNrGyOwAuzTEKOD7PI2sGz+TJUizbuSVm1J63b5R/5KJPuiwtOy2N6Fp6+bD0UwV5Edw2EMoaKwe8GCxZkh1Q6EUvTJZzNfH08pEAF4dff3P24RV4JLQtdnEMKtC1bvq+bCm3kYVF6IZ/Xpoqz5WIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeWAWRmzQaEZBsv0+FqXMqMMLVgRnev9rD44bFmXtOM=;
 b=oPrgVqxKoC1yoUKwAd/oK5qIFpPVkoF7iG3ZlvrxORA1v4Z+j54OElNa1ELrrO8nAkjl9+ubtPBpu7dtJU2syzDo2UouOOkNSsLy3V/Frt6BUxfuhZQB+sumAxr1zBXRBomqQ984iBD/Bux+Iv2ayddVzMrWnAR6NAlibY4ZIDmqxmgQ5LVY3xkCmuB+Px9Z3qbgwyZzij61ZAaThBkPSXHj1XHUvmXtImxxusaun93Xp5KYf5ZXfB+YeZVFNvqzQ5mbVgLTlg29qm4qh2XKaOllFf/7NnikvpUbuLw3NFxHmQmd1TWSVR2riPcfZUOBUQuTkWnvDuPYZjJ7hYBPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeWAWRmzQaEZBsv0+FqXMqMMLVgRnev9rD44bFmXtOM=;
 b=ZdVYdbnETXWqAUsIusKEaMQq/8IG+bi9OfS9eao8CBboibgv8bNjzqc/QY1B8XdUir0UNAujrEjt7nGRzIx5bg0kdwc/SAptKSYDSAmRHJkvZw30rm8YUYYLMe3bqwFRjyFuysvER/BqXZd1x+xxi9CYqL+cqZRoreTwlch86zY=
Received: from CY4PR13MB1527.namprd13.prod.outlook.com (2603:10b6:903:12f::23)
 by CY4PR13MB1400.namprd13.prod.outlook.com (2603:10b6:903:13c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Fri, 24 Apr
 2020 17:28:58 +0000
Received: from CY4PR13MB1527.namprd13.prod.outlook.com
 ([fe80::d0e0:9b39:db76:e937]) by CY4PR13MB1527.namprd13.prod.outlook.com
 ([fe80::d0e0:9b39:db76:e937%11]) with mapi id 15.20.2937.020; Fri, 24 Apr
 2020 17:28:58 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bamv2005@gmail.com" <bamv2005@gmail.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] selftests: add build/cross-build dependency check script
Thread-Topic: [PATCH] selftests: add build/cross-build dependency check script
Thread-Index: AQHWEqMAvlNnDYZ/6UC2UwGnLr03bqiHqroAgADnlKA=
Date:   Fri, 24 Apr 2020 17:28:57 +0000
Message-ID: <CY4PR13MB1527A6A6F9BCEADAF14A3C6BFDD00@CY4PR13MB1527.namprd13.prod.outlook.com>
References: <20200414212208.21667-1-skhan@linuxfoundation.org>
 <374866ac-4519-f367-bdc6-ec8d0c1b6347@infradead.org>
In-Reply-To: <374866ac-4519-f367-bdc6-ec8d0c1b6347@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.66.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f0ecb8b-f953-4e19-52fc-08d7e874f89e
x-ms-traffictypediagnostic: CY4PR13MB1400:
x-microsoft-antispam-prvs: <CY4PR13MB14001A1889CFD5B5A45717BCFDD00@CY4PR13MB1400.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1527.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(66446008)(6506007)(8936002)(26005)(2906002)(54906003)(81156014)(8676002)(53546011)(9686003)(52536014)(110136005)(316002)(5660300002)(478600001)(7696005)(86362001)(66556008)(66476007)(4326008)(186003)(64756008)(66946007)(55016002)(71200400001)(33656002)(76116006);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0SiRgy/YBOz8sQg2reV/yDUzzPF4cpUjSSOgcFgDdGf0U2gGlTvRbNbX7lbU5vMNxPoDr6IAABqMD2THQ1LZdtFLhhliPE3D5kxPgyVks5iVu7UgH9qxST1+9yJJ+Adq7H3vIaJi+2NUGarV8frE4Isw8Gknny7Cky4A42ok/qtEQ9MDECvtCNLHq89oRSFeVr3pMvjAeM6sfCSXBTbTjn7NMqtLgGFSfzSo6/un0eQm2Y6u3OtYxkbST1B2FGhuUB8fXFleZKf8AAJE3reqwBgMxKcYRUr/e/bHgjQB92Zb8cDmUHwfi61gXSXhYP+fuztJihdBuKwnwyaf0QPQipUI/Ha2MHachVu3zX2RaMqyelBWLHflQQ0KT+RoKBQRYdueuhsH0+EKWu6ZaQeMZ8tZ/0/xejdhi/jGNzFUm9Ao1p8yPhXkzBC9+IbaPsk6
x-ms-exchange-antispam-messagedata: D66accd7WPTq04ulU8OiIacAIBd2S0yoyCXHG31PBwccohZkivy9wOxYCzvqvLq+4WQ+dU0yWslxw+aWB5YpayXisLgjezr4e5U99124rzBe14HqsCTLs/7b5hojbxlKFXAqY5ggYRkD+X0+hG8rTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0ecb8b-f953-4e19-52fc-08d7e874f89e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 17:28:57.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKsHtMA6LaLPrsPGOSGVpnlN1SU578fKyHT6TZHOLtuo02DIkL4jh7POKRwnMIs7yXn2wAlqOshMN4wteqDO8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1400
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1rc2VsZnRlc3Qtb3du
ZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rc2VsZnRlc3Qtb3duZXJAdmdlci5rZXJuZWwub3Jn
PiBPbiBCZWhhbGYgT2YgUmFuZHkgRHVubGFwDQo+IA0KPiBPbiA0LzE0LzIwIDI6MjIgUE0sIFNo
dWFoIEtoYW4gd3JvdGU6DQo+ID4gLUNGTEFHUyArPSAtTzIgLWcgLXN0ZD1nbnU5OSAtV2FsbCAt
SS4uLy4uLy4uLy4uL3Vzci9pbmNsdWRlLyAkKE1PVU5UX0NGTEFHUykNCj4gPiAtTERMSUJTICs9
ICQoTU9VTlRfTERMSUJTKQ0KPiA+ICtDRkxBR1MgKz0gLU8yIC1nIC1zdGQ9Z251OTkgLVdhbGwg
LUkuLi8uLi8uLi8uLi91c3IvaW5jbHVkZS8gJChWQVJfQ0ZMQUdTKQ0KPiA+ICtMRExJQlMgKz0g
JChWQVJfTERMSUJTKQ0KPiANCj4gDQo+ICgxKSBDYW4gdGhhdCBzZXJpZXMgb2YgLi4vLi4vLi4v
Li4gYmUgcmVwbGFjZWQgYnkgJChvYmp0cmVlKT8NCj4gSWYgc28sIHRoYXQgd291bGQgYmUgbXVj
aCBjbGVhbmVyIElNTy4NCg0Ka3NlbGZ0ZXN0cyBkb2Vzbid0IHNldCAkKG9ianRyZWUpIHdoZW4g
aXQgaXMgcnVuIGRpcmVjdGx5DQooaWUgbWFrZSAtQyB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cykN
Cg0KSSBoYWQgbXkgb3duIHNvbHV0aW9uIHdoaWNoIHdhcyB0byB1c2UgS0JVSUxEX09VVFBVVCwg
bGlrZSBzbzoNClRoaXMgd2FzIGEgcGF0Y2ggaW4gbXkgcXVldWUsIHRoYXQgSSBkaWRuJ3Qgc2Vu
ZCBpbiBiZWNhdXNlIEkgd2Fzbid0DQp2ZXJ5IGhhcHB5IHdpdGggaXQuICBJIHdhcyBzdGlsbCBj
b25zaWRlcmluZyBhbHRlcm5hdGl2ZXMuDQoNCi0tLS0tLS0tLS0tLS0tLS0gKHBhdGNoKQ0KU3Vi
amVjdDogW1BBVENIXSBzZWxmdGVzdHMvdm06IHVzZSBpbmNsdWRlcyBmcm9tIEtCVUlMRF9PVVRQ
VVQgZGlyZWN0b3J5DQoNClRoZSBNYWtlZmlsZSBmb3IgdGhlIHZtIHRlc3RzIHdhcyBzcGVjaWZ5
aW5nIGEgcmVsYXRpdmUgcGF0aA0KKGluIHRoZSBzb3VyY2UgZGlyZWN0b3J5KSBmb3IgYWNjZXNz
aW5nIGluY2x1ZGUgZmlsZXMuICBUaGlzDQpkb2Vzbid0IHdvcmsgd2hlbiB0aGUgaGVhZGVycyBm
aWxlcyBhcmUgcGxhY2VkIGluIGFub3RoZXINCmRpcmVjdG9yeSAod2l0aCBPPSBvciBLQlVJTERf
T1VUUFVUKS4gIEl0IG1heSBhcHBlYXIgdG8gd29yaywNCmJ1dCBlbmRzIHVwIHVzaW5nIGluY2x1
ZGVzIGZyb20gdGhlIGhvc3QgbWFjaGluZSwgd2hpY2ggbWF5DQpub3QgbWF0Y2ggdGhlIGtlcm5l
bCBzb3VyY2UgYmVpbmcgY29tcGlsZWQgYWdhaW5zdC4NCg0KV2l0aG91dCB0aGlzIGNoYW5nZSwg
d2hlbiB0aGUgcHJvZ3JhbSB1c2VyZmF1bHRmZC5jIHdhcw0KY29tcGlsZWQsIGl0IGdlbmVyYXRl
ZCBlcnJvcnMgbGlrZSB0aGUgZm9sbG93aW5nOg0KDQogICAgdXNlcmZhdWx0ZmQuYzoyNjc6MjE6
IGVycm9yOiAnVUZGRF9BUElfUkFOR0VfSU9DVExTX0JBU0lDJyB1bmRlY2xhcmVkDQogICAgaGVy
ZSAobm90IGluIGEgZnVuY3Rpb24pDQogICAgICAuZXhwZWN0ZWRfaW9jdGxzID0gVUZGRF9BUElf
UkFOR0VfSU9DVExTX0JBU0lDLA0KICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KICAgIHVzZXJmYXVsdGZkLmM6IEluIGZ1bmN0aW9uICd1ZmZkX3Bv
bGxfdGhyZWFkJzoNCiAgICB1c2VyZmF1bHRmZC5jOjUyOTo4OiBlcnJvcjogJ1VGRkRfRVZFTlRf
Rk9SSycgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluDQogICAgdGhpcyBmdW5jdGlvbikNCiAgICAg
ICBjYXNlIFVGRkRfRVZFTlRfRk9SSzoNCiAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fg0KICAg
IHVzZXJmYXVsdGZkLmM6NTI5Ojg6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlz
IHJlcG9ydGVkIG9ubHkNCiAgICBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4N
CiAgICB1c2VyZmF1bHRmZC5jOjUzMToxODogZXJyb3I6ICd1bmlvbiA8YW5vbnltb3VzPicgaGFz
IG5vIG1lbWJlciBuYW1lZA0KICAgICdmb3JrJw0KICAgICAgICB1ZmZkID0gbXNnLmFyZy5mb3Jr
LnVmZDsNCiAgICAgICAgICAgICAgICAgICAgICBeDQoNCkNoYW5nZSB0aGUgQ0ZMQUdTIGRlZmlu
aXRpb24gaW4gdGhlIE1ha2VmaWxlIHRvIHJlZmVyZW5jZQ0KS0JVSUxEX09VVFBVVC4NCg0KU2ln
bmVkLW9mZi1ieTogVGltIEJpcmQgPHRpbS5iaXJkQHNvbnkuY29tPg0KLS0tDQogdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdm0vTWFrZWZpbGUgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy92bS9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZtL01ha2VmaWxl
DQppbmRleCA3ZjlhOGE4Li4wMjA4NjU5IDEwMDY0NA0KLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvdm0vTWFrZWZpbGUNCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZtL01ha2Vm
aWxlDQpAQCAtMyw3ICszLDcgQEANCiB1bmFtZV9NIDo9ICQoc2hlbGwgdW5hbWUgLW0gMj4vZGV2
L251bGwgfHwgZWNobyBub3QpDQogQVJDSCA/PSAkKHNoZWxsIGVjaG8gJCh1bmFtZV9NKSB8IHNl
ZCAtZSAncy9hYXJjaDY0LiovYXJtNjQvJykNCiANCi1DRkxBR1MgPSAtV2FsbCAtSSAuLi8uLi8u
Li8uLi91c3IvaW5jbHVkZSAkKEVYVFJBX0NGTEFHUykNCitDRkxBR1MgPSAtV2FsbCAtSSAkKEtC
VUlMRF9PVVRQVVQpL3Vzci9pbmNsdWRlICQoRVhUUkFfQ0ZMQUdTKQ0KIExETElCUyA9IC1scnQN
CiBURVNUX0dFTl9GSUxFUyA9IGNvbXBhY3Rpb25fdGVzdA0KIFRFU1RfR0VOX0ZJTEVTICs9IGd1
cF9iZW5jaG1hcmsNCi0tIA0KMi4xLjQNCi0tLS0tLS0tIChlbmQgcGF0Y2gpDQoNClRoZSByZWFz
b24gSSB3YXNuJ3QgaGFwcHkgaXMgdGhhdCB0aGlzIHJlcXVpcmVkIGFub3RoZXIgcGF0Y2ggdG8N
CnRvb2xzL3Rlc3RpbmcvTWFrZWZpbGUgdG8gbWFrZSBzdXJlIEtCVUlMRF9PVVRQVVQgd2FzIGFs
d2F5cw0Kc2V0LiAgSSBnb3Qgc2lkZXRyYWNrZWQgb24gdGhlIG1ha2UgaGVhZGVyc19pbnN0YWxs
IGlzc3VlLCBhbmQgZGlkbid0DQpmaW5pc2ggdGhpcyB1cC4gIFNvcnJ5IGFib3V0IHRoYXQuIChT
ZWUgYmVsb3cgZm9yIHRoZSBoZWFkZXJzX2luc3RhbGwgaXNzdWUpLg0KDQo+IA0KPiAoMikgSSBj
YW4ndCBmaW5kIGFueXRoaW5nIHRoYXQgY2hlY2tzIHRoYXQgLi4vLi4vLi4vLi4vdXNyL2luY2x1
ZGUgZXhpc3RzDQo+IChvciBoYXMgYmVlbiBpbnN0YWxsZWQgdmlhICdtYWtlIGhlYWRlcnNfaW5z
dGFsbCcpLiAgT3IgYW55dGhpbmcgdGhhdA0KPiByZXF1aXJlcyB0aGF0IENPTkZJR19IRUFERVJT
X0lOU1RBTEwgYmUgc2V0L2VuYWJsZWQuICBXZWxsLCBvdGhlciB0aGFuDQo+IGEgTWFrZWZpbGUg
ZXJyb3IsIGJ1dCB0aGF0J3Mgbm90IGEgbmljZSB3YXkgdG8gZmluZCBvdXQuDQoNClRoZSBrc2Vs
ZnRlc3QgaGFuZGxpbmcgb2YgaGVhZGVyc19pbnN0YWxsIGlzIHF1aXRlIGNvbmZ1c2luZy4gIFRo
ZXJlIGlzIGENCmRlcGVuZGVuY3kgaW4gdGhlIHRvcC1sZXZlbCBNYWtlZmlsZSB0aGF0IGVuZHMg
dXAgY2F1c2luZyBhIHZtbGludXggYnVpbGQsDQpldmVuIGlmIHlvdSBqdXN0IGZpbmlzaGVkIGRv
aW5nIGEgaGVhZGVyc19pbnN0YWxsIHJlY2VudGx5IChhdCBsZWFzdCB0aGUgd2F5DQp0aGF0IGl0
IGlzIGNhbGxlZCBieSBrc2VsZnRlc3QsIGFuZCBpbiBjZXJ0YWluIGJ1aWxkIGNvbmZpZ3VyYXRp
b25zIHRoYXQgSSBhbSBzZWVpbmcNCndpdGggbXkgdGVzdGluZy4pDQoNCkkgc3VzcGVjdCB0aGF0
IHdlIGRvbid0IGhhdmUgY2xlYW4gc2VwYXJhdGlvbiBvZiBrZXJuZWwgaGVhZGVycyBmb3IgdGhl
DQprZXJuZWwgdW5kZXIgdGVzdCwgZnJvbSB0aGUgaG9zdCBtYWNoaW5lJ3Mga2VybmVsIGhlYWRl
ciBmaWxlcywgZm9yIGJ1aWxkcw0Kb2Yga3NlbGZ0ZXN0IHByb2dyYW1zLiAgQnV0IEkgcmFuIG91
dCBvZiB0aW1lIHRvIHRlYXNlIHRoaXMgb3V0Lg0KICAtLSBUaW0NCg0KPiANCj4gUHJlZmVyYWJs
eSB3ZSB3b3VsZCBoYXZlIHNvbWUgS2NvbmZpZyBjaGVjay9lbmZvcmNlbWVudCBvciBhdCBsZWFz
dCBzb21lDQo+IGRvY3VtZW50YXRpb24uDQo+IA0KPiBUaG91Z2h0cz8NCj4gDQo+IHRoYW5rcy4N
Cj4gLS0NCj4gflJhbmR5DQoNCg==
