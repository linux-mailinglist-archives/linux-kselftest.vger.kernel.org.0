Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67B1FA03D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 21:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgFOT2Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 15:28:24 -0400
Received: from mail-eopbgr700139.outbound.protection.outlook.com ([40.107.70.139]:33376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728506AbgFOT2Y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 15:28:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF4uQ5rTCuSHO+P8fGyotO0NxXroGbHM7ePmHWL1qm7H4wOQwEd1k0QhdnKwoXhKYL/XHbejhAEZv1mEkyA0sLiooUddzfsDCSDmPZoGbeg5mQ8Iy1bS1+zqnSlS7lXAjQ6UWe5eW7Ny0bzDhAswSwOcZhMbwNyEKm9EeWsna/06W7scfbCO4ZxrWOZzCUTk6EQLHXTdK2+omdKyNCA2r3voheYwMAUVYzGL/pgqivB/1YUFddQHlFCsGduEvs+ENxR9uE3InrEemsEzF9sDKU7QacS5lky5w4hXCnyRz+2xuwriBp+ez2HaCrQaPYNekDJ+jocc5xgwFtlnn5qA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHc9oVM51DI5GMTdLwSiopN1xpgk6QvtRKhWDc0TV3M=;
 b=kGjiQiPcuCPUWwPo0eXg9Kw8cWzYkRr5lKSHmKCRXStt6ItUhdDwRKA9DY/eyVGYodTntbGZ8uwZM4VNgXnVef7Hn7PY2GCXFw2ZCbSTnEhMMNj/EtQkNpB2xE1a8qlWylrfrQJzLWY/FWhF79O5Nzcwxhh/IL0WP1Azy9YHl9D0YRSuFFaj5D9ImjG+xywKyoRHA56/Wo/CFYAPo58mlKbeHqb7GUKL54qdfJzo+KAnezByi7yiXk/xaFu/d+47gLZXRzombhm7IWkrPJbL16KEuLOzEYtl6Y7iYnXkdvSqn7NBeCGhVXzW1T6VFvJACGZtmcw7VQeK84LgNWYHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHc9oVM51DI5GMTdLwSiopN1xpgk6QvtRKhWDc0TV3M=;
 b=rMpQz7EUGu8LqToMzRQCy1Pnhl2cnGDLQMvO7iappEtz/wl1z10ZG/0TCuz31oo2VyUqxHJnwEFqBPiS91yzXHi31To1lEDkQG6ll5U0nqXPRghuyU+g4+YXDgdkuaDff1aQFb+eSWSpJmYywbqNUoof+QhPwiF2R80RWiSDhW0=
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR1301MB2103.namprd13.prod.outlook.com (2603:10b6:910:48::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.7; Mon, 15 Jun
 2020 19:28:21 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3109.018; Mon, 15 Jun 2020
 19:28:20 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH] kselftest: runner: fix TAP output for skipped tests
Thread-Topic: [PATCH] kselftest: runner: fix TAP output for skipped tests
Thread-Index: AQHWPz4jOoN+nSyJY0qUhBN3V+N4d6jSBzeAgAAVxfCAAAzUgIAH6tuw
Date:   Mon, 15 Jun 2020 19:28:20 +0000
Message-ID: <CY4PR13MB1175401BC37C9866BE494F60FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <20200610154447.15826-1-pbonzini@redhat.com>
 <ac2c1eaa-acd7-7ac6-0666-6e6c0cbd546b@linuxfoundation.org>
 <CY4PR13MB1175A17F29B281642DF05A6DFD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <6461f067-0fea-4419-dd56-2661c44a803a@redhat.com>
In-Reply-To: <6461f067-0fea-4419-dd56-2661c44a803a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e10512c-1dae-4c81-62ed-08d811624380
x-ms-traffictypediagnostic: CY4PR1301MB2103:
x-microsoft-antispam-prvs: <CY4PR1301MB210385BF2BDD9E40C284E07BFD9C0@CY4PR1301MB2103.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zqme4lpE6JznTNh7AdO+VNVIE9Lo0tvsf4Z2XToIpUaAiBUK54KEMfM1BKNTqBWxVYTUqdSFkMNJFtBKDcMo+WYtdXjqNgbHp/8gcuGoTsZlCIufAOcTfaBh7Y+m1FaHuftyNyICcYNmlHk5edElMEbVlfiPNQPN5KCPsQTEH538MERxbwSP/iMfSZdez2oGSvoaTWSQ/VPblkqdE4StfxITgKKM6RDthXCXwJwP/N3RZ9KucIysWh3bGTxkL0s3N83Vf1H4ny1GVjH47QRBZ+1fJZRnsuEAJktRVjIsGnDnbfvrwZhEktZ/bUSPN8fN7OEfjitedglFQ+IR/pSIAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(4326008)(478600001)(83380400001)(33656002)(5660300002)(55016002)(76116006)(71200400001)(66946007)(64756008)(66556008)(86362001)(110136005)(52536014)(66476007)(9686003)(66446008)(54906003)(53546011)(2906002)(26005)(186003)(7696005)(8936002)(316002)(8676002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: r4G2XySRfJWy6UlKqWiVdc+loToqKF9FbSkhPSE3A+LBlh0GJUoVvKRHTZZmjoUugubkzoqY+0y743AhMu8oaRbNAOchadDOUdlTE01f+H6Pyeq9zRaqYnhEekTxXoBR70wW6rgCM82LVayw+7+isMJROI/4GduCaGyJRTrND6ge0OnSXHLmFd3RNlQiX6Zgu5IIwDTOt4gebzA46XiUNWZAlfl+zMtjF69wsZbngbPk66Ef0tayvL2t4MEKkS4T1w+WUc9hZFf3DPoe25PLEa5HoZTBZG7WdHoEJiy/KhkO0hbOVT2ISCm5f1j6nFu+bPV4gB7mXlAI8Ip7cEmnQX/V3d31RQRGUQThTJIw4weMnAKBgTvSq9PbE8qJhX6HRGOnhauVxBylW9IcpwPsx57713EPitqdL2szMAfPLF2fNdieeNOeKkiWnRrsGJf6WkDVMtZ3QyE2/yI6py+sxEOAOyYHDzuYjsUNy7NQrxM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e10512c-1dae-4c81-62ed-08d811624380
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 19:28:20.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkvx4MatpJyPDh6qzKiU8s4f7s1nCRtffLZLFh/zXU0pNTwTbzbFJ77aLJLtVtQunuM1Ah2n7AdbvhuNDUd61g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2103
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gDQo+IE9uIDEwLzA2LzIwIDE5OjQzLCBCaXJkLCBUaW0g
d3JvdGU6DQo+ID4+PiAgIAkJKHJjPSQ/OwlcDQo+ID4+PiAgIAkJaWYgWyAkcmMgLWVxICRza2lw
X3JjIF07IHRoZW4JXA0KPiA+Pj4gLQkJCWVjaG8gIm5vdCBvayAkdGVzdF9udW0gJFRFU1RfSERS
X01TRyAjIFNLSVAiDQo+ID4+PiArCQkJZWNobyAib2sgJHRlc3RfbnVtICRURVNUX0hEUl9NU0cg
IyBTS0lQIg0KPiA+DQo+ID4gVGhpcyBpcyBhIHByZXR0eSBiaWcgY2hhbmdlLCBhbmQgbWlnaHQg
YnJlYWsgdXBzdHJlYW0gQ0lzIHRoYXQgaGF2ZSBjb21lIHRvDQo+ID4gcmVseSBvbiBrc2VsZnRl
c3QncyBleGlzdGluZyBiZWhhdmlvci4gIEkga25vdyBpdCdzIGdvaW5nIHRvIGJyZWFrIEZ1ZWdv
J3MgcGFyc2luZw0KPiA+IG9mIHJlc3VsdHMuDQo+IA0KPiBEbyB5b3UgaGF2ZSBhIHBvaW50ZXIg
dG8gdGhpcyBjb2RlPw0KPiANCj4gPiBrc2VsZnRlc3QgaGFzIGEgZmV3IGNvbnZlbnRpb25zIHRo
YXQgYXJlIGRpZmZlcmVudCBmcm9tIHRoZSBUQVAgc3BlYywNCj4gPiBhbmQgYSBmZXcgaXRlbXMg
aXQgZG9lcyB0aGF0IGFyZSBleHRlbnNpb25zIHRvIHRoZSBUQVAgc3BlYy4NCj4gDQo+IFllcywg
dGhlcmUgYXJlIGV4dGVuc2lvbnMgdG8gZGlyZWN0aXZlcyBhcmUgbm90IGEgcHJvYmxlbSBhbmQg
cGFyc2Vycw0KPiBtaWdodCByYWlzZSBhbiBlcnJvciBvbiB0aGVtLiAgVGhhdCBjYW4gYmUgYW4g
aXNzdWUsIGJ1dCBpdCdzIGEgc2VwYXJhdGUNCj4gb25lIChhbmQgaXQncyBlYXNpZXIgdG8gaWdu
b3JlIGl0IGFzIGxvbmcgYXMgdGVzdCBwYXNzLi4uKS4NCj4gDQo+ID4gSU1ITywgdGhlIFRBUCBz
cGVjIGdvdCB0aGlzIG9uZSB3cm9uZywgYnV0IEkgY291bGQgYmUgY29udmluY2VkDQo+ID4gb3Ro
ZXJ3aXNlLg0KPiANCj4gSGVyZSB0aGUgVEFQIHNwZWMgc2F5cyB0aGF0IGEgc2tpcCBzdGFydHMg
d2l0aCAib2siIGFuZCBoYXMgYSAiU0tJUCINCj4gZGlyZWN0aXZlLCBhbmQgYW55b25lIGNhbiBw
YXJzZSBpdCB0byB0cmVhdCBhcyBpdCBhcyBhIGZhaWx1cmUgaWYNCj4gZGVzaXJhYmxlLiAgQnV0
IGRvaW5nIHNvbWV0aGluZyBlbHNlIHNob3VsZCBiZSB0cmVhdGVkIHNpbXBseSBhcyBhDQo+IHZp
b2xhdGlvbiBvZiB0aGUgc3BlYywgaXQncyBub3QgYSBtYXR0ZXIgb2YgInJpZ2h0IiBvciAid3Jv
bmciLg0KPiANCj4gU28sIGlmIHlvdSB3YW50IHRvIHVzZSAibm90IG9rIC4uLiAjIFNLSVAiLCBk
b24ndCBjYWxsIGl0IFRBUC4NCg0KV2VsbCwgZm9yIHNvbWUgdGltZSBub3cgSSd2ZSBiZWVuIGlu
IGZhdm9yIG9mIHVzIGNhbGxpbmcgdGhlDQprZXJuZWwgdGVzdHMnIGZvcm1hdCAiS1RBUCIuDQpC
dXQgSSBhZ3JlZSBpZiB0aGVyZSBhcmUgbm8gc3Ryb25nIHJlYXNvbnMgdG8gYmUgZGlmZmVyZW50
IHdlIHNob3VsZA0KaGF2ZSB0aGUgc2FtZSBjb252ZW50aW9uIGFzIFRBUCAxMy4NCg0KSSBsb29r
ZWQgYXQgRnVlZ28sIGFuZCBpdCdzIHRyaXZpYWwgdG8gY2hhbmdlIGl0J3MgcGFyc2VyIChhbmQg
SSd2ZSB3YW50ZWQNCnRvIGNvbnNvbGlkYXRlIHRoZSBrc2VsZnRlc3QgcGFyc2VyIHdpdGggb3Ro
ZXIgVEFQIHBhcnNlcnMgaW4gRnVlZ28sDQpzbyBpdCdzIHByb2JhYmx5IGJlc3QgZm9yIEZ1ZWdv
IHRvIGdvIHdpdGggdGhlIFNLSVA9Im9rIiBjb252ZW50aW9uIGFueXdheS4pDQpJIGhhdmVuJ3Qg
cmVsZWFzZWQgYW4gdXBkYXRlZCBrc2VsZnRlc3QgZm9yIEZ1ZWdvIGluIGEgd2hpbGUsIHNvIEkN
CmRvbid0IHRoaW5rIG1hbnkgb2YgRnVlZ28ncyB1c2VycyB3aWxsIGJlIGFmZmVjdGVkIGlmIEkg
c3dpdGNoLiAgUGx1cw0KSSBrbm93IG1vc3Qgb2YgdGhlbSBzbyBJIGNhbiBzbW9vdGggaXQgb3Zl
ciBpZiBpdCdzIGEgcHJvYmxlbS4gIFNLSVAgDQpyZWFsbHkgc2hvdWxkIGJlIHRyZWF0ZWQgZGlm
ZmVyZW50bHkgdGhhbiAib2siIG9yICJub3Qgb2siIGFueXdheS4NCg0KSSByYWlzZWQgdGhpcyBp
c3N1ZSBvbiBvdXIgYXV0b21hdGVkIHRlc3RpbmcgY29uZmVyZW5jZSBjYWxsIGxhc3Qgd2Vlay4N
ClRoZSBjYWxsIGhhZCBwZW9wbGUgZnJvbSB0aGUgS2VybmVsQ0ksIENLSSwgTEtGVCBhbmQgRnVl
Z28gcHJvamVjdHMsDQpzbyBhdCBsZWFzdCB0aG9zZSBwcm9qZWN0cyBoYXZlIGdvdHRlbiB0aGUg
d29yZCBhbmQgaGF2ZSBhIGNoYW5jZSB0bw0Kb2JqZWN0IGlmIHRoaXMgd2lsbCBhZmZlY3QgdGhl
aXIgcmVzdWx0cyBwYXJzZXJzLg0KDQo+IA0KPiBIb3dldmVyLCBJIG5vdGljZWQgbm93IHRoYXQg
dGhlcmUgaXMgYW5vdGhlciBpbnN0YW5jZSBvZiAibm90IG9rLipTS0lQIg0KPiBpbiB0ZXN0aW5n
L3NlbGZ0ZXN0cy9rc2VsZnRlc3QuaCAoYW5kIGFsc28gb25lIGluIGEgY29tbWVudCkuICBTbyB0
aGV5DQo+IHNob3VsZCBhbGwgYmUgZml4ZWQgYXQgdGhlIHNhbWUgdGltZSwgYW5kIEknbSBva2F5
IHdpdGggaG9sZGluZyB0aGlzIHBhdGNoLg0KDQpBZ3JlZSB0aGF0IHdlIHNob3VsZCBjaGFuZ2Ug
aXQgZXZlcnl3aGVyZSBvbmNlIHdlIGRlY2lkZS4gIE5pY2UgY2F0Y2guDQoNCkZvciBteSBwYXJ0
LCBJJ20gT0sgd2l0aCBtb3ZpbmcgdG8gdGhlICJTS0lQPW9rIiBjb252ZW50aW9uIChpbiBhZ3Jl
ZW1lbnQNCndpdGggVEFQMTMpLiAgSSBkb24ndCBrbm93IGlmIHdlIG5lZWQgdG8gd2FpdCBsb25n
ZXIgZm9yIG90aGVycyB0byBoYXZlIGEgY2hhbmNlDQp0byByZXZpZXcgdGhpcyBvciBub3QsIGJ1
dCBtYXliZSB3YWl0IGEgZmV3IGRheXMgYW5kIHRoZW4gZ28gZm9yIGl0Pw0KIC0tIFRpbQ0KDQo+
IFBhb2xvDQo+IA0KPiA+IEJ1dCBJIHRoaW5rIHdlIHNob3VsZCBkaXNjdXNzIHRoaXMgYW1vbmcg
Q0kgdXNlcnMgb2YNCj4gPiBrc2VsZnRlc3QgYmVmb3JlIG1ha2luZyB0aGUgY2hhbmdlLg0KPiA+
DQo+ID4gSSBzdGFydGVkIHdvcmsgcXVpdGUgYSB3aGlsZSBhZ28gb24gYW4gZWZmb3J0IHRvIGRv
Y3VtZW50IHRoZQ0KPiA+IGNvbnZlbnRpb25zIHVzZWQgYnkga3NlbGZ0ZXN0IChwYXJ0aWN1bGFy
bHkgd2hlcmUgaXQgZGV2aWF0ZXMNCj4gPiBmcm9tIHRoZSBUQVAgc3BlYyksICBidXQgbmV2ZXIg
c3VibWl0dGVkIGl0Lg0KPiA+DQo+ID4gSSdtIGdvaW5nIHRvIHN1Ym1pdCB3aGF0IEkndmUgZ290
IGFzIGFuIFJGQyBub3csIGZvciBkaXNjdXNzaW9uLA0KPiA+IGV2ZW4gdGhvdWdoIGl0J3Mgbm90
IGZpbmlzaGVkLiAgSSdsbCBkbyB0aGF0IGluIGEgc2VwYXJhdGUgdGhyZWFkLg0KPiA+DQo+ID4N
Cj4gPj4+ICAgCQllbGlmIFsgJHJjIC1lcSAkdGltZW91dF9yYyBdOyB0aGVuIFwNCj4gPj4+ICAg
CQkJZWNobyAiIyINCj4gPj4+ICAgCQkJZWNobyAibm90IG9rICR0ZXN0X251bSAkVEVTVF9IRFJf
TVNHICMgVElNRU9VVCINCj4gPj4+DQo+ID4+DQo+ID4+IFRoYW5rcy4gSSB3aWxsIHB1bGwgdGhp
cyBpbiBmb3IgTGludXggNS44LXJjMg0KPiA+IFNodWFoIC0gY2FuIHlvdSBob2xkIG9mZiBvbiB0
aGlzIHVudGlsIHdlIGRpc2N1c3MgaXQ/DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gIC0tIFRpbQ0K
PiA+DQoNCg==
