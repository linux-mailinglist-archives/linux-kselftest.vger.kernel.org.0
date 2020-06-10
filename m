Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA91F5ABC
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFJRnd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 13:43:33 -0400
Received: from mail-eopbgr760124.outbound.protection.outlook.com ([40.107.76.124]:6022
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbgFJRnd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 13:43:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9GLaYxU81Hmo+jXnyZTgQjIzlf4HLZ6j7utuWoMA+PlCYajOo6a/UemZLBTXn9aMlAugsOYWyjzOCVe83Um8z/LQhTAm08qLzSjjRPoZV++uIdIF0Hj0hPCq6PXlcpMGVuxV/IC2ozktVmHn/LStctfcddl28rw0MCi6cuTX2G9SaYsdbDAnp0HV1pxwOOuj3VI4RhHaTvqE/+MjgJz2NypgB+HykU8v+2lExPBR7E8EOg39VmF0i6zOKQ+zDtiiYKiAMqB9K1Maypaxt7euYmXj4fJMKyGr2vx4Gti88DOqT+YCFg5pGXukgv6SEHJgP6yFzcba7XFIvS0EheC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XDaFYLNrjC+/O9+tidBH1zZi8YzYHptc58LfSNFNP8=;
 b=nvDSrT64Ogyq5qAwz6mav40w0Nv9940IjOI66MjENJcVU+LNVyaJl7IuMHBuGWMeKNiYeVrP8rkSZys4+vQGex4EFROgP8g+xyXfQet+MT4Sc0naqq9fZ22AwfSvfUa9XeKbAU2D+fp67Edr7emPNTKFLs7KXSHQQp/Qn4FeV03o5OAewwMFZQh8PH3krRVTLMoEIjpn+6v0aOooUwbAY7mClT2HIGwA3bQqWdSD5kCUNQfGJdR6r4ycs82WxcJ5oQnL7uLvuF3ta737GF8UsKIQFm7w1G/vqLYb4ao0Ekj9xfD96feB7KWlWkbdeQrfK3ZX5QXxKXSkvDbZdYFxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XDaFYLNrjC+/O9+tidBH1zZi8YzYHptc58LfSNFNP8=;
 b=rg5U2kqIE8mO8SmTV+5d11WJ74im2H7rRfKTJmgiZ4Yp1HQb+TYmQrIOFSAiKVfsf6OUznwJgi/e9ckwvtu4RHDVAxsF8WkTnXkxG3eNhazmxgiQsSgRbndUjc+7SrYxJ/iaWaoaN0twc9QIlikj/bz0lfzFT3hOKr+AAlX+BiI=
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR1301MB2104.namprd13.prod.outlook.com (2603:10b6:910:45::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.13; Wed, 10 Jun
 2020 17:43:27 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 17:43:27 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] kselftest: runner: fix TAP output for skipped tests
Thread-Topic: [PATCH] kselftest: runner: fix TAP output for skipped tests
Thread-Index: AQHWPz4jOoN+nSyJY0qUhBN3V+N4d6jSBzeAgAAVxfA=
Date:   Wed, 10 Jun 2020 17:43:27 +0000
Message-ID: <CY4PR13MB1175A17F29B281642DF05A6DFD830@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <20200610154447.15826-1-pbonzini@redhat.com>
 <ac2c1eaa-acd7-7ac6-0666-6e6c0cbd546b@linuxfoundation.org>
In-Reply-To: <ac2c1eaa-acd7-7ac6-0666-6e6c0cbd546b@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=sony.com;
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91188255-4df4-44bb-6c19-08d80d65c859
x-ms-traffictypediagnostic: CY4PR1301MB2104:
x-microsoft-antispam-prvs: <CY4PR1301MB21048ABF95B9480C0BE1A791FD830@CY4PR1301MB2104.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JGs9nXuulsXSjjerSMa/AeeqQFF+BLhprbvM+cHyk4+lRx/6dxglK+JraqbPlYVlcDwFeVYYRdcx3X0i0non0alvxcWaNbCuTv1pUcfmHPMbeJyJ1RDuGbyA17ex0gsITRmwhbqL9GJtR7ezfDN6q5thNoS9cJ10m8bkvhRDxYyPBnNVGbeSJOst+VcJtFdWpXtHUVNeXXQtI9J0JZ4TD4TZPs/QzsaR6kJLkTCmrQofNM64BQw0YxF9/Us5Ia6ZDniteu4rDhGqnH4GqYBN6zAla9G9Yv96rw4lpifWE65sSUDHFhyBekEWq4a0cMqLDTQePyEq0QVbkQFZOTpVLMleHvqlM61ZKUk8SRN3ZwpESquoHHxZWdIPlJ2GqkzF4fuZhE6RE4Y/QkIptulEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(478600001)(8936002)(71200400001)(86362001)(54906003)(2906002)(76116006)(66556008)(66476007)(66446008)(66946007)(33656002)(316002)(64756008)(55016002)(7696005)(4326008)(8676002)(9686003)(6506007)(53546011)(186003)(110136005)(26005)(5660300002)(83380400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JAumHO2E277lc4HGA4YB9cQUDhqwk/PtGIMSYmEDoeSkpdCCoEfy/jvhs88sz7pm6qld1ZpFuAmXD7VO3bQN/NQMXLofUY3ZXdQcQKMFoJhvamfnaP5FIs5TX/6eBeXmlREZFFeHjsWiI3ay5KMBophzcg77rLL5/8G7SVNqDUL1hhzKyCh1YTTKQmHCR419p3sXL/Av78nd5QVT+NxKm0hbNm3H76/n6rqYvLfUI8oCndBv2nz+433IWxfy2a9H81PlfU7Q7qe8Mg6t2uWvb6UYMkNuPXrffL1RIMD/zDRFLzGEApMVAG65g/FDsK61S6zc7e7yHQlUELkt0mZxsizzID39h/HeQGkvqTsp/RstCtZs/GBhMxHoBwhKQKZ0+lunAJN2K78eauoPVz2KMjam/CpEJJC8tQpo9LXTNTO+GOUZkVA2VihLCbOc2f0xdYSXHddzr0ZBhyclLd8lRWC4ynuHDTZyrYKgx4UF+BM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91188255-4df4-44bb-6c19-08d80d65c859
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 17:43:27.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbXMJNH9i6tWLDHD3jYbUhyCVJLeKup6R3gzjcsXAmw5BqynFijImGu6TZ0MA5zmJ416YQiXNeXa5lf25ca8Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2104
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta3NlbGZ0ZXN0
LW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta3NlbGZ0ZXN0LW93bmVyQHZnZXIua2VybmVs
Lm9yZz4gT24gQmVoYWxmIE9mIFNodWFoIEtoYW4NCj4gDQo+IE9uIDYvMTAvMjAgOTo0NCBBTSwg
UGFvbG8gQm9uemluaSB3cm90ZToNCj4gPiBBY2NvcmRpbmcgdG8gdGhlIFRBUCBzcGVjaWZpY2F0
aW9uLCBhIHNraXBwZWQgdGVzdCBtdXN0IGJlIG1hcmtlZCBhcyAib2siDQo+ID4gYW5kIGFubm90
YXRlZCB3aXRoIHRoZSBTS0lQIGRpcmVjdGl2ZSwgZm9yIGV4YW1wbGUNCj4gPg0KPiA+ICAgICBv
ayAyMyAjIHNraXAgSW5zdWZmaWNpZW50IGZsb2dpc3RvbiBwcmVzc3VyZS4NCj4gPiAgICAgKGh0
dHBzOi8vdGVzdGFueXRoaW5nLm9yZy90YXAtc3BlY2lmaWNhdGlvbi5odG1sKQ0KPiA+DQo+ID4g
Rml4IHRoZSBydW5uZXIgc2NyaXB0IHRvIG1hdGNoIHRoaXMuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0L3J1bm5lci5zaCB8IDIgKy0NCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC9ydW5uZXIuc2gg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3QvcnVubmVyLnNoDQo+ID4gaW5kZXgg
Njc2YjNhOGIxMTRkLi5mNDgxNWNiY2Q2MGYgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMva3NlbGZ0ZXN0L3J1bm5lci5zaA0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2tzZWxmdGVzdC9ydW5uZXIuc2gNCj4gPiBAQCAtNzcsNyArNzcsNyBAQCBydW5f
b25lKCkNCj4gPiAgIAkJZWNobyAib2sgJHRlc3RfbnVtICRURVNUX0hEUl9NU0ciKSB8fA0KPiA+
ICAgCQkocmM9JD87CVwNCj4gPiAgIAkJaWYgWyAkcmMgLWVxICRza2lwX3JjIF07IHRoZW4JXA0K
PiA+IC0JCQllY2hvICJub3Qgb2sgJHRlc3RfbnVtICRURVNUX0hEUl9NU0cgIyBTS0lQIg0KPiA+
ICsJCQllY2hvICJvayAkdGVzdF9udW0gJFRFU1RfSERSX01TRyAjIFNLSVAiDQoNClRoaXMgaXMg
YSBwcmV0dHkgYmlnIGNoYW5nZSwgYW5kIG1pZ2h0IGJyZWFrIHVwc3RyZWFtIENJcyB0aGF0IGhh
dmUgY29tZSB0bw0KcmVseSBvbiBrc2VsZnRlc3QncyBleGlzdGluZyBiZWhhdmlvci4gIEkga25v
dyBpdCdzIGdvaW5nIHRvIGJyZWFrIEZ1ZWdvJ3MgcGFyc2luZw0Kb2YgcmVzdWx0cy4NCg0Ka3Nl
bGZ0ZXN0IGhhcyBhIGZldyBjb252ZW50aW9ucyB0aGF0IGFyZSBkaWZmZXJlbnQgZnJvbSB0aGUg
VEFQIHNwZWMsIA0KYW5kIGEgZmV3IGl0ZW1zIGl0IGRvZXMgdGhhdCBhcmUgZXh0ZW5zaW9ucyB0
byB0aGUgVEFQIHNwZWMuDQpJTUhPLCB0aGUgVEFQIHNwZWMgZ290IHRoaXMgb25lIHdyb25nLCBi
dXQgSSBjb3VsZCBiZSBjb252aW5jZWQNCm90aGVyd2lzZS4gIEJ1dCBJIHRoaW5rIHdlIHNob3Vs
ZCBkaXNjdXNzIHRoaXMgYW1vbmcgQ0kgdXNlcnMgb2YNCmtzZWxmdGVzdCBiZWZvcmUgbWFraW5n
IHRoZSBjaGFuZ2UuDQoNCkkgc3RhcnRlZCB3b3JrIHF1aXRlIGEgd2hpbGUgYWdvIG9uIGFuIGVm
Zm9ydCB0byBkb2N1bWVudCB0aGUNCmNvbnZlbnRpb25zIHVzZWQgYnkga3NlbGZ0ZXN0IChwYXJ0
aWN1bGFybHkgd2hlcmUgaXQgZGV2aWF0ZXMNCmZyb20gdGhlIFRBUCBzcGVjKSwgIGJ1dCBuZXZl
ciBzdWJtaXR0ZWQgaXQuDQoNCkknbSBnb2luZyB0byBzdWJtaXQgd2hhdCBJJ3ZlIGdvdCBhcyBh
biBSRkMgbm93LCBmb3IgZGlzY3Vzc2lvbiwNCmV2ZW4gdGhvdWdoIGl0J3Mgbm90IGZpbmlzaGVk
LiAgSSdsbCBkbyB0aGF0IGluIGEgc2VwYXJhdGUgdGhyZWFkLg0KDQoNCj4gPiAgIAkJZWxpZiBb
ICRyYyAtZXEgJHRpbWVvdXRfcmMgXTsgdGhlbiBcDQo+ID4gICAJCQllY2hvICIjIg0KPiA+ICAg
CQkJZWNobyAibm90IG9rICR0ZXN0X251bSAkVEVTVF9IRFJfTVNHICMgVElNRU9VVCINCj4gPg0K
PiANCj4gVGhhbmtzLiBJIHdpbGwgcHVsbCB0aGlzIGluIGZvciBMaW51eCA1LjgtcmMyDQpTaHVh
aCAtIGNhbiB5b3UgaG9sZCBvZmYgb24gdGhpcyB1bnRpbCB3ZSBkaXNjdXNzIGl0Pw0KDQpUaGFu
a3MsDQogLS0gVGltDQoNCg==
