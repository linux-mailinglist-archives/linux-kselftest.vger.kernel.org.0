Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8D2173EDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 18:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgB1Ruk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 12:50:40 -0500
Received: from mail-eopbgr690119.outbound.protection.outlook.com ([40.107.69.119]:25253
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgB1Ruk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 12:50:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVDiCJRCVPQ6welWKvULgrlF0ay1MBeUcyNPVPaokz4wvBDWmDhbqGkV9xQ9WQOBDMQ2tu6OfRs+SpKdf7tgFAIp0st/rBtrhdS/kEc6oERK0oJPOxkJYErRRX60DoF10pHp1i/y2s5WugMK219m12bgLbC2Pr9JsWwEPR1ZYRoFfYZLNudp0jmW17aJjUDC7Ou4huaG+w1CsgFecmhlwCVzO7nvLUVVZvOu4BYziUZOeaJt8IgQrqqWEtPcPPstpNPbiojRGqGqdc+3li0ByYGGPU3QNsaSSsuKs9sW01jXwlA1iFs1Ju3Gp6nQTcKwdkRvX9jqDzcRgYRMPTkzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt5siaVNUqRjf+wRM/KJSdw+qKyOKCzvS4Y684dnM1Y=;
 b=kK9276ljdxl5bQ63/CocRbHIrfVAdFKjanjuV5IH+Y17lt4jc0diBewMslRaZeIS3vkT32eWhczrZg/hNKB+Yd6tDGy+F82h6MpAfvejp1ZEZnHk568RRAkpIpCn0z52sUBSe0NwruEnGjFG8MU1KuuUClyCOR9SLzS6WmTpFmNqd6MCbCATvS3sJcDTQZHBhAuaG+r+dYCOKdut/vtn7ekxqIO9IIrmSc+GFfv9W4/T8Dj57D6Uwbs+OEDn1VEBqilCsaqVsh8VUCGZn6ZJOLmsNtl0rtu1g1SWn3wW9R6MRQFXm4YAZwFzLkL9rZqZXcr9E/t8crTi+zZjVbucyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt5siaVNUqRjf+wRM/KJSdw+qKyOKCzvS4Y684dnM1Y=;
 b=ZoynmWLV8j+Nf4RWqBZLEgcWaDnKPAPsw0ViTmSOjKjWPjfmRtXejCSfFEOv1sip0CmME/9902kfuHk6mW9ryGYra8BDfEgPzgHzQMhqpOtM2f9B8CqSTKaAdj1KA0zfWMaZGFalwfThKUKQp0UBDemZKydjg8SE+WzLjhkqOYM=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (2603:10b6:300:2::27)
 by MWHPR13MB1453.namprd13.prod.outlook.com (2603:10b6:300:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5; Fri, 28 Feb
 2020 17:50:37 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7544:fc2:b078:5dcd]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7544:fc2:b078:5dcd%3]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 17:50:37 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Kevin Hilman <khilman@baylibre.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [ANN] Kselftest integration into Kernel CI
Thread-Topic: [ANN] Kselftest integration into Kernel CI
Thread-Index: AQHV7efNY93z0dF5okyqGlwVqafDw6gw4O9g
Date:   Fri, 28 Feb 2020 17:50:36 +0000
Message-ID: <MWHPR13MB08954921D3B29D9AA824A2A0FDE80@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <3b3dc707-7ae7-955b-69fe-b9abe9ae26c5@linuxfoundation.org>
In-Reply-To: <3b3dc707-7ae7-955b-69fe-b9abe9ae26c5@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: becdf53c-a3e4-4c87-be9a-08d7bc76b7b7
x-ms-traffictypediagnostic: MWHPR13MB1453:
x-microsoft-antispam-prvs: <MWHPR13MB1453713A369F386CDEC0061AFDE80@MWHPR13MB1453.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(26005)(54906003)(110136005)(81166006)(478600001)(2906002)(316002)(4326008)(81156014)(8676002)(186003)(9686003)(33656002)(5660300002)(52536014)(7696005)(86362001)(966005)(64756008)(71200400001)(76116006)(8936002)(66446008)(66476007)(6506007)(55016002)(66556008)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1453;H:MWHPR13MB0895.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/CVffjEri7H0HtycEnAh7Gs7XC/9xCrZIEvTlnf1zEKilPaSbao5BrZjEuXLJ+IZZBvTgGb3xDxgxfurQCX3+iuEh9ogGFgnzjDe+9UFzfbabBEVIfswjPjT6W8Y3LOTPp4TB3oR5uBPAm785temVcQODtyhLYk2vY3x711oOJzGa9pyJqZzy5oi9o/Qc2WpuSlQ7rz9PWIPBVb5ktMVlbAw/Es+N7wFG7rSJ5FmI5RaSnBvdKbyqrVICcntybUvrIDeH27Bo5DIokhB53OeSOIFPC0kl8l6uJZIRZnZAckyoy0ngHmKEL5mB0KhZgob+3YyYlOpKb9fblTd68U2ZtrHgOf4HP+obUcPjEDvb5NwriDGfhUWsTcu+GAsb5US8BCaTZJ15V1/H/YRfqm3aut/31tFlwPRmMpJKyEbzV9q7uSWzwoHRqXNqFio1LtdXF1fvHto1LsdBIKmtqVdySINUDKKn4Eq99X6f4xfindPFCcFFK8N/l3h8u6ovWWJpLi2Cw4v4PE6FxCc3BiwA==
x-ms-exchange-antispam-messagedata: fwMW2rWdXRnA5EzErUHW5R15uLaCCxZzKzQKh2kqQpHIzrJqDlgM/7XJ4bhZV9rN0mIspLIFvcdb/WwkF66HNIg73IMjRyuCIgAyOR65kNXiHSV7ozwfQteisH+ymgoHfNDNCm7t+NujFNShOhH0qw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becdf53c-a3e4-4c87-be9a-08d7bc76b7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 17:50:36.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwOoM7aSWeJy77JMcXFu0/rPjhQFF6OY581/6msoMn5/VCCU+zUYg20C3O0Bc908TQ9rKXahwX96Gp64QDbi+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1453
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogIFNodWFoIEtoYW4NCj4g
DQo+IEludGVncmF0aW5nIEtzZWxmdGVzdCBpbnRvIEtlcm5lbCBDSSByaW5ncyBkZXBlbmRzIG9u
IEtzZWxmdGVzdCBidWlsZA0KPiBhbmQgaW5zdGFsbCBmcmFtZXdvcmsgdG8gc3VwcG9ydCBLZXJu
ZWwgQ0kgdXNlLWNhc2VzLiBJIGFtIGtpY2tpbmcgb2ZmDQo+IGFuIGVmZm9ydCB0byBzdXBwb3J0
IEtzZWxmdGVzdCBydW5zIGluIEtlcm5lbCBDSSByaW5ncy4gUnVubmluZyB0aGVzZQ0KPiB0ZXN0
cyBpbiBLZXJuZWwgQ0kgcmluZ3Mgd2lsbCBoZWxwIHF1YWxpdHkgb2Yga2VybmVsIHJlbGVhc2Vz
LCBib3RoDQo+IHN0YWJsZSBhbmQgbWFpbmxpbmUuDQo+IA0KPiBXaGF0IGlzIHJlcXVpcmVkIGZv
ciBmdWxsIHN1cHBvcnQ/DQo+IA0KPiAxLiBDcm9zcy1jb21waWxhdGlvbiAmIHJlbG9jYXRhYmxl
IGJ1aWxkIHN1cHBvcnQNCj4gMi4gR2VuZXJhdGVzIG9iamVjdHMgaW4gb2JqZGlyL2tzZWxmdGVz
dCB3aXRob3V0IGNsdXR0ZXJpbmcgbWFpbiBvYmpkaXINCj4gMy4gTGVhdmUgc291cmNlIGRpcmVj
dG9yeSBjbGVhbg0KPiA0LiBJbnN0YWxscyBjb3JyZWN0bHkgaW4gb2JqZGlyL2tzZWxmdGVzdC9r
c2VsZnRlc3RfaW5zdGFsbCBhbmQgYWRkcw0KPiAgICAgaXRzZWxmIHRvIHJ1bl9rc2VsZnRlc3Qu
c2ggc2NyaXB0IGdlbmVyYXRlZCBkdXJpbmcgaW5zdGFsbC4NCj4gDQo+IE5vdGUgdGhhdCBpbnN0
YWxsIHN0ZXAgaXMgbmVjZXNzYXJ5IGZvciBhbGwgZmlsZXMgdG8gYmUgaW5zdGFsbGVkIGZvcg0K
PiBydW4gdGltZSBzdXBwb3J0Lg0KPiANCj4gSSBsb29rZWQgaW50byB0aGUgY3VycmVudCBzdGF0
dXMgYW5kIGlkZW50aWZpZWQgcHJvYmxlbXMuIFRoZSB3b3JrIGlzDQo+IG1pbmltYWwgdG8gYWRk
IGZ1bGwgc3VwcG9ydC4gT3V0IG9mIDgwKyB0ZXN0cywgNyBmYWlsIHRvIGNyb3NzLWJ1aWxkDQo+
IGFuZCAxIGZhaWxzIHRvIGluc3RhbGwgY29ycmVjdGx5Lg0KPiANCj4gTGlzdCBpcyBiZWxvdzoN
Cj4gDQo+IFRlc3RzIGZhaWxzIHRvIGJ1aWxkOiBicGYsIGNhcGFiaWxpdGllcywga3ZtLCBtZW1m
ZCwgbXF1ZXVlLCB0aW1lbnMsIHZtDQo+IFRlc3RzIGZhaWwgdG8gaW5zdGFsbDogYW5kcm9pZCAo
cGFydGlhbCBmYWlsdXJlKQ0KPiBMZWF2ZXMgc291cmNlIGRpcmVjdG9yeSBkaXJ0eTogYnBmLCBz
ZWNjb21wDQo+IA0KPiBJIGhhdmUgcGF0Y2hlcyByZWFkeSBmb3IgdGhlIGZvbGxvd2luZyBpc3N1
ZXM6DQo+IA0KPiBLc2VsZnRlc3Qgb2JqZWN0cyAodGVzdCBkaXJzKSBjbHV0dGVyIHRvcCBsZXZl
bCBvYmplY3QgZGlyZWN0b3J5Lg0KPiBzZWNjb21wX2JwZiBnZW5lcmF0ZXMgb2JqZWN0cyBpbiB0
aGUgc291cmNlIGRpcmVjdG9yeS4NCj4gDQo+IEkgY3JlYXRlZCBhIHRvcGljIGJyYW5jaCB0byBj
b2xsZWN0IGFsbCB0aGUgcGF0Y2hlczoNCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3NodWFoL2xpbnV4LWtzZWxmdGVzdC5naXQvP2g9a2VybmVs
Y2kNCj4gDQo+IEkgYW0gZ29pbmcgdG8gc3RhcnQgd29ya2luZyBvbiBidWlsZCBwcm9ibGVtcy4g
SWYgYW55Ym9keSBpcw0KPiBpbnRlcmVzdGVkIGluIGhlbHBpbmcgbWUgd2l0aCB0aGlzIGVmZm9y
dCwgZG9uJ3QgaGVzaXRhdGUgdG8NCj4gY29udGFjdCBtZS4gSSBmaXJzdCBwcmlvcml0eSBpcyBm
aXhpbmcgYnVpbGQgYW5kIGluc3RhbGwgYW5kDQo+IHRoZW4gbG9vayBpbnRvIHRlc3RzIHRoYXQg
bGVhdmUgdGhlIHNvdXJjZSBkaXJlY3RvcnkgZGlydHkuDQoNCkknbSBpbnRlcmVzdGVkIGluIHRo
aXMuICBJJ2QgbGlrZSB0aGUgc2FtZSBjbGVhbnVwcyBpbiBvcmRlciB0byBydW4NCmtzZWxmdGVz
dCBpbiBGdWVnbywgYW5kIEkgY2FuIHRyeSBpdCB3aXRoIGFkZGl0aW9uYWwgdG9vbGNoYWlucw0K
YW5kIGJvYXJkcy4gIFVuZm9ydHVuYXRlbHksIGluIHRlcm1zIG9mIHJ1bm5pbmcgdGVzdHMsIGFs
bW9zdCBhbGwNCnRoZSBib2FyZHMgaW4gbXkgbGFiIGFyZSBydW5uaW5nIG9sZCBrZXJuZWxzLiAg
U28gdGhlIHRlc3RzIHJlc3VsdHMNCmFyZW4ndCB1c2VmdWwgZm9yIHVwc3RyZWFtIHdvcmsuICBC
dXQgSSBjYW4gc3RpbGwgdGVzdA0KY29tcGlsYXRpb24gYW5kIGluc3RhbGwgaXNzdWVzLCBmb3Ig
dGhlIGtzZWxmdGVzdCB0ZXN0cyB0aGVtc2VsdmVzLg0KDQo+IA0KPiBEZXRhaWxlZCByZXBvcnQg
Y2FuIGJlIGZvdW5kIGhlcmU6DQo+IA0KPiBodHRwczovL2RyaXZlLmdvb2dsZS5jb20vZmlsZS9k
LzExbm5XT0tJenpPckU0RWl1Y1pCbjQyM2x6U1VfZU5Odi92aWV3P3VzcD1zaGFyaW5nDQoNCklz
IHRoZXJlIGFueXRoaW5nIHlvdSdkIGxpa2UgbWUgdG8gbG9vayBhdCBzcGVjaWZpY2FsbHk/ICBE
byB5b3Ugd2FudCBtZSB0byBzdGFydA0KYXQgdGhlIGJvdHRvbSBvZiB0aGUgbGlzdCBhbmQgd29y
ayB1cD8gIEkgY291bGQgbG9vayBhdCAndm0nIG9yICd0aW1lbnMnLg0KDQogICAtLSBUaW0NCg0K
