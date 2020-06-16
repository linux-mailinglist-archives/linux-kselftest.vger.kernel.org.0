Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F661FC014
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFPUhX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 16:37:23 -0400
Received: from mail-co1nam11on2133.outbound.protection.outlook.com ([40.107.220.133]:51009
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbgFPUhX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 16:37:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv2+tUavI5AIst1f9rtG8FMc7lvseuGWBCCAoF3znqqvZnOZ8loB3tvOaH0jX0aSQa+HruC9Q5eQEAIDUhSrTPgxtHTYc74dc/YWaVbCUWtwqjO/9vZkLo/IU0cLCOqn7G8Rsm4RlWfS4QcS7lybwDp/nfd3UFEewWdXyJVPSPQmfsOIxvp1iqQWzg6XSBCXLKa1TA/3HkvAj0+LF5sH7ysUC/bfeWb+TpgOP9Se8VFmUUClvnnZLbphmUx0TfyQr1HjPmqw7DFjoB2EpV0PxozajepFvO0K8ap2QylsETRvWzoFyw3SmhYRHGjER08+PDhcTz8x9o1e/7sBQbKg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13V2XK73ryX3aC/VAs4NEjueQCRq2x5JJiZQnABi+5c=;
 b=bNfzAXU2XUmdhcCOqKq2rrzYL72D/DtAcc2bxtPT+iCrQgYtDZ+ta+Z9ZmpLvtDNPPyQgI7bu4hhaHTjsFYuvoScIB2K4OcIuoB1qu1gNFb+LEq1HlAMbnEw0dkEBmxTSnORxkHj15QHfElaF/E72yoSx/Sk0Bt4BOLmxQRTVcNlE0tfoPl4UUtPD6Wwq4qn8GQm18bx85zPQ6kzMVCTJOy12/VM3cFRFZaBSlcKsru9rnKxJkiS4WFNPmx7DMxwTKstr6V+NLVMa16jRqqiNYvz1J9qXgroWbpwBSsyzidRfePvJBveV8UQdA1EX/PptSq0ET/uwp1cfxgFm7U8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13V2XK73ryX3aC/VAs4NEjueQCRq2x5JJiZQnABi+5c=;
 b=TwZPZPeTIjGL24/D9gJdRYYMNlsw5aLUGQGAXaWpxGQ70nFfBgH/TvcZqY4Lxn2WRsocTtrFyUf6M8L3Sza/rRX8Bu1u32i38IImVed/V1N6EdJ+02TYUTS0nMDPVyHioCkLhpB+DJh3HdSbL9J5XpO98PpvUKD4VR5WxyqCt8Q=
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR1301MB2021.namprd13.prod.outlook.com (2603:10b6:910:47::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.13; Tue, 16 Jun
 2020 20:37:19 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3109.018; Tue, 16 Jun 2020
 20:37:19 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     David Gow <davidgow@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: RFC - kernel selftest result documentation (KTAP)
Thread-Topic: RFC - kernel selftest result documentation (KTAP)
Thread-Index: AdY/UfZiI2pZQBRwRN+1JBazpeVQogB7ogeAAH33pXAAODiLAAAANTzA
Date:   Tue, 16 Jun 2020 20:37:18 +0000
Message-ID: <CY4PR13MB1175CB6221D5859AAC9920C6FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CABVgOSkrKHs_uWLZ++_fBC_mfe3RgDxmCvnkcyn1P_wjXTV9Og@mail.gmail.com>
 <CY4PR13MB11756803217A9D20456E826FFD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g458XTDftQAOm-K4Squ5-ZuZnZcFdVUG0JtUWF56cODOVg@mail.gmail.com>
In-Reply-To: <CAFd5g458XTDftQAOm-K4Squ5-ZuZnZcFdVUG0JtUWF56cODOVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 036d4208-4c72-45b3-01d4-08d81235105d
x-ms-traffictypediagnostic: CY4PR1301MB2021:
x-microsoft-antispam-prvs: <CY4PR1301MB2021A5E105F414E3FABE9D9DFD9D0@CY4PR1301MB2021.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgUxPxbdAMVXVhBc+PV6x67hq7nzZZmSKhzGJMbmF+t0r2Uc9lVnhfTFWYD00CKaCpzJ1+uqefxSPXEARBDFutv1lQjsNCWCavxKRtzyOgZqY5+HH/xftkTRT0hpKxiJzs5aU7pyRE02eYnZTuMmxbbFX90/6M0VDb5ZTXCZ3lYOAv//k4+y3nuRWfAyJfUrs1TUNPNuhzYyG7TCsrYqQEGy5eEIJoP5tuhaDzU4OI6/lfQl7NvYadh25HRtzDQd6behGGd+1QQZFxiy8LgjkJfThtTRxLZvqsTblSV/3whoHzcFs8L7h6xvnz20lwHLSnUrFfrcQELJsH9pYNUpxmCpKUFeFnwSKCkRd8DLY9xCng/xFReh3POLBEImurzU7V5jeOS1231+knFWjaFWew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(52536014)(5660300002)(86362001)(2906002)(8676002)(76116006)(54906003)(8936002)(6916009)(66946007)(7696005)(316002)(66556008)(66476007)(33656002)(64756008)(66446008)(4326008)(53546011)(966005)(55016002)(186003)(26005)(83380400001)(6506007)(478600001)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /v+NS3a1Zxt5ayWK3SL4YR4L0VhGgaAG/A8BvCpt7SilVpad7l8uL3eDY/VnQ1pWnHj9EYM3r84QmGbAM3cTS1DWjFS7hZtLUY0ZljujEOmpkl9m16H494QkEA+w4XpsrPhn1Ovb7Blakd4EyrYs7g5jNY2RimhdYztF17Qz4yITqX3pEX+OKn9qlWzHEi17vKldQOJzoaFAGaNozzmnu9+8qhauLMU4ddyEpO7mw0SFUam/Zk0pPnROAzQCjztOYg4QNXIkACXIbeUSgYvDrwPicKXJrR31SZh2+s+90Npc0Au8KRydcFJ/pn9QpDk2QnntgtRmi4mFfI2NstVQWsrjX5QobxNTkCw/b5IBJzPJtk4fYqbJ9O9mz5u5zT96kYDoUcSK9UEkXOQwzR52FtTNdF6zIci2HQN4F1o1FveAME/+unN6agbM4NOPm7WwIgd1fTneYziqPPsbphU5skzlq8Q9oTiTmAQMnUcxPZw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036d4208-4c72-45b3-01d4-08d81235105d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 20:37:18.8963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBeM+BKCaPMul+5OZkstWw1tdCGgdhHuem4DMV9RVmst7BAfcQZ6J2xRKwezPHKF90cWBp+vG+zo4JsJnTAXgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2021
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVuZGFuIEhpZ2dpbnMgPGJy
ZW5kYW5oaWdnaW5zQGdvb2dsZS5jb20+DQo+IA0KPiBPbiBNb24sIEp1biAxNSwgMjAyMCBhdCAx
MDozNCBBTSBCaXJkLCBUaW0gPFRpbS5CaXJkQHNvbnkuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IERhdmlkIEdvdyA8ZGF2aWRn
b3dAZ29vZ2xlLmNvbT4NCj4gPiA+DQo+ID4gPiBPbiBUaHUsIEp1biAxMSwgMjAyMCBhdCAyOjEx
IEFNIEJpcmQsIFRpbSA8VGltLkJpcmRAc29ueS5jb20+IHdyb3RlOg0KPiBbLi4uXQ0KPiA+ID4g
S1VuaXQgaXMgY3VycmVudGx5IG91dHB1dHRpbmcgIlRBUCB2ZXJzaW9uIDE0IiwgYXMgd2Ugd2Vy
ZSBob3Bpbmcgc29tZQ0KPiA+ID4gb2Ygb3VyIGNoYW5nZXMgd291bGQgZ2V0IGludG8gdGhlIFRB
UDE0IHNwZWMuIChBbnkgY29tbWVudHMsIEJyZW5kYW4/KQ0KPiA+ID4gTWF5YmUgdGhpcyBzaG91
bGQgZW5kIHVwIHNheWluZyAiS1RBUCB2ZXJzaW9uIDEiIG9yIHNvbWV0aGluZz8NCj4gPg0KPiA+
IEkgZG9uJ3Qga25vdyBpZiB0aGlzIHdpbGwgYnJlYWsgYW55IGV4aXN0aW5nIHJlc3VsdHMgcGFy
c2VycyBvciBub3QuDQo+ID4gSSBoZXNpdGF0ZSB0byB1c2UgIlRBUCB2ZXJzaW9uIDE0IiwgYXMg
VEFQIGFwcGVhcnMgdG8gYmUgYSBkb3JtYW50DQo+ID4gaW5pdGlhdGl2ZSBhdCB0aGUgbW9tZW50
LCBhbmQgdGhlcmUncyBubyBndWFyYW50ZWUgdGhhdCB0aGUga2VybmVsJ3MNCj4gPiBjaGFuZ2Vz
IHdpbGwgZ2V0IGFkb3B0ZWQgaW50byBhbiBvZmZpY2lhbCBzcGVjLg0KPiANCj4gV2Ugd2VyZSB1
c2luZyAiVEFQIHZlcnNpb24gMTQiIHNpbmNlIHRoZSAiZXh0ZW5zaW9ucyIgd2UgYXJlIHVzaW5n
DQo+IHdlcmUgYWxsIHByb3Bvc2VkIGFtb25nIHRoZSBUQVAgcGVvcGxlIHRvIGdvIGludG8gdGhl
IG5leHQgdmVyc2lvbiBvZg0KPiBUQVAuIEJhc2VkIG9uIGRpc2N1c3Npb25zIGFtb25nIHRoZW0g
dGhleSBzZWVtIHRvIGxpa2UgdGhlIHN1YnRlc3QNCj4gc3R1ZmY6DQo+IA0KPiBodHRwczovL2dp
dGh1Yi5jb20vVGVzdEFueXRoaW5nL3Rlc3Rhbnl0aGluZy5naXRodWIuaW8vcHVsbC8zNg0KPiAN
Cj4gQW55d2F5LCBJIGNhbiBzdGlsbCBhcHByZWNpYXRlIHRoYXQgdGhleSBtaWdodCBjaGFuZ2Ug
dGhlaXIgbWluZHMuDQpJIGRvbid0IGtub3cgaWYgdGhlcmUncyBhbnlvbmUgbGVmdCBhcm91bmQg
dG8gY2hhbmdlIHRoZWlyIG1pbmQuDQoNCkkgaGF2ZSB0byBhZ3JlZSB3aXRoIGlzYWFjcyAod2hv
IHByb3Bvc2VkIFRBUDE0IDUgeWVhcnMgYWdvKSwNCnRoYXQgdGhlIFRBUCBzcGVjaWZpY2F0aW9u
IGlzIGluIGEgd2VpcmQgc3RhdGUuDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9UZXN0QW55dGhpbmcv
dGVzdGFueXRoaW5nLmdpdGh1Yi5pby9wdWxsLzM2I2lzc3VlY29tbWVudC01NjYzMjE2MzMNCg0K
VGhlcmUgaGF2ZSBiZWVuIGNvbW1pdHMgdG8gdGhlIGdpdGh1YiByZXNwb3NpdG9yeSBieSBhIGZl
dyBkaWZmZXJlbnQNCnBlb3BsZSByZWNlbnRseSAoMyBjb21taXRzIGluIHRoZSBsYXN0IDkgbW9u
dGhzKS4gIEJ1dCB0aGVyZSdzIG5vIGJvZHkgdG8gYXBwcm92ZSBvcg0KZGlzYXBwcm92ZSBvZiBh
IG5ldyBzcGVjLg0KDQo+IA0KPiA+IElmIHdlIGFyZSBhIHN0cmljdCBzdXBlci1zZXQgb2YgVEFQ
LCB0aGVuIEkgc3VwcG9zZSB3ZSBjb3VsZCBqdXN0DQo+ID4gc3RhcnQgdXNpbmcgVEFQIHZlcnNp
b24gMTQsIGFuZCB1bmlsYXRlcmFsbHkgZGVjbGFyZSB0aGF0IG91ciBjaGFuZ2VzDQo+ID4gbWFr
ZSBhIG5ldyBzcGVjLiAgQnV0IHNpbmNlIHdlIGRvbid0IGNvbnRyb2wgdGhlIHdlYiBzaXRlIHRo
aXMgZmVlbHMNCj4gPiBsaWtlIGEgaG9zdGlsZSB0YWtlb3Zlci4NCj4gDQo+IEkganVzdCB0aG91
Z2h0IGl0IHdhcyBva2F5IGJlY2F1c2UgaXQgd2FzIGFscmVhZHkgaW4gdGhlaXIgcHJvcG9zZWQN
Cj4gVEFQMTQgc3BlYywgYnV0IHllYWgsIGlmIHdlIGp1c3QgZGVjaWRlIGFtb25nc3Qgb3Vyc2Vs
dmVzIHRvIHVzZSBpdCwNCj4gd2Ugc2hvdWxkIHByb2JhYmx5IGRvIHNvbWV0aGluZyBlbHNlLg0K
PiANCj4gPiBJJ20gbW9zdCBjb21mb3J0YWJsZSB3aXRoIGNhbGxpbmcgb3VyIHRoaW5nIEtUQVAs
IGFuZCBqdXN0DQo+ID4gcmVmZXJlbmNpbmcgVEFQIGFzIGluc3BpcmF0aW9uLiAgSSBkb24ndCBo
YXZlIGEgc3Ryb25nIG9waW5pb24gb24NCj4gDQo+IEkgYW0gY29vbCB3aXRoIHRoYXQuDQpJIGhh
dGUgZm9ya3MsIGJ1dCBpZiB3ZSBkbyBnbyB3aXRoIGRlY2xhcmluZyBvdXIgb3duIGZvcmsgYXMg
S1RBUCwNCnRoZW4gd2Ugc2hvdWxkIHByb2JhYmx5IHB1bGwgaW4gdGhlIFRBUDE0IHNwZWMgYXMg
YSBzdGFydGluZyBwb2ludC4NClNpbmNlIGl0IGhhcyBubyBob21lIG90aGVyIHRoYW4gaW4gYSBw
dWxsIHJlcXVlc3QsIGl0IHNlZW1zIGEgYml0IHRlbnRhdGl2ZS4NCldlIG1heSBuZWVkIHRvIHB1
dCB0aGUgc3BlYyBpbiB0aGUga2VybmVsIHNvdXJjZSBvciBzb21ldGhpbmcuDQoNCkkgdGhpbmsg
d2UncmUgZGVmaW5pdGVseSBub3QgZG9pbmcgYW55dGhpbmcgd2l0aCB0aGUgeWFtbCBibG9ja3Mg
YXQNCnRoZSBtb21lbnQgKG9yIG1heWJlIGV2ZXIpLCBzbyB0aGVyZSdzIG9uZSBiaWcgcG9pbnQg
b2YgZGVwYXJ0dXJlLg0KDQo+IA0KPiA+IEtUQVAgdnMgVEFQLCBidXQgSSBkbyBmZWVsIHN0cm9u
Z2x5IHRoYXQga3NlbGZ0ZXN0IGFuZCBrdW5pdCBzaG91bGQgdXNlIHRoZQ0KPiA+IHNhbWUgdmVy
c2lvbiBsaW5lIChpZiB3ZSBjYW4gZ2V0IHRoZW0gdG8gdXNlIHRoZSBzYW1lIGNvbnZlbnRpb25z
KS4NCj4gDQo+IFllYWgsIEkgYWdyZWU6IGl0IHdvdWxkIGJlIGJldHRlciBpZiB0aGVyZSB3YXMg
anVzdCBvbmUgdmVyc2lvbiBvZg0KPiAoSylUQVAgaW4gdGhlIGtlcm5lbC4NCg0KT25lIHRoaW5n
IHRoYXQgbmVlZHMgdG8gYmUgcmF0aW9uYWxpemVkIGJldHdlZW4gS1VuaXQgYW5kIHNlbGZ0ZXN0
DQppcyB0aGUgc3ludGF4IGZvciBzdWJ0ZXN0cy4gIEtVbml0IGZvbGxvd3MgdGhlIFRBUDE0IHNw
ZWMsIGFuZCBzdGFydHMNCnN1YnRlc3RzIHdpdGggaW5kZW50ZWQgIiMgU3VidGVzdDogbmFtZSBv
ZiB0aGUgY2hpbGQgdGVzdCINCmFuZCBzZWxmdGVzdHMganVzdCBpbmRlbnRzIHRoZSBvdXRwdXQg
ZnJvbSB0aGUgY2hpbGQgdGVzdCwgc28gaXQNCnN0YXJ0cyB3aXRoIGluZGVudGVkICJUQVAgdmVy
c2lvbiAxMyIuICBPbmUgaXNzdWUgSSBoYXZlIHdpdGggdGhlDQpUQVAxNC9LVW5pdCBhcHByb2Fj
aCBpcyB0aGF0IHRoZSBvdXRwdXQgZnJvbSB0aGUgY2hpbGQgaXMgZGlmZmVyZW50DQpkZXBlbmRp
bmcgb24gd2hldGhlciB0aGUgdGVzdCBpcyBjYWxsZWQgaW4gdGhlIGNvbnRleHQgb2YgYW5vdGhl
cg0KdGVzdCBvciBub3QuDQoNCkluIEtVbml0LCBpcyBpdCB0aGUgcGFyZW50IHRlc3Qgb3IgdGhl
IGNoaWxkIHRlc3QgdGhhdCBwcmludHMgb3V0IHRoZQ0KIiMgU3VidGVzdDogLi4uIiBsaW5lPw0K
IC0tIFRpbQ0KDQoNCj4gDQo+ID4gPiA+IFRlc3QgcGxhbiBsaW5lDQo+ID4gPiA+IC0tLS0tLS0t
LS0tLS0tDQo+ID4gPiA+IFRoZSB0ZXN0IHBsYW4gaW5kaWNhdGVzIHRoZSBudW1iZXIgb2YgaW5k
aXZpZHVhbCB0ZXN0IGNhc2VzIGludGVuZGVkIHRvDQo+ID4gPiA+IGJlIGV4ZWN1dGVkIGJ5IHRo
ZSB0ZXN0LiBJdCBhbHdheXMgc3RhcnRzIHdpdGggIjEuLiIgYW5kIGlzIGZvbGxvd2VkDQo+ID4g
PiA+IGJ5IHRoZSBudW1iZXIgb2YgdGVzdHMgY2FzZXMuICBJbiB0aGUgZXhhbXBsZSBhYm92ZSwg
MS4uMSIsIGluZGljYXRlcw0KPiA+ID4gPiB0aGF0IHRoaXMgdGVzdCByZXBvcnRzIG9ubHkgMSB0
ZXN0IGNhc2UuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSB0ZXN0IHBsYW4gbGluZSBjYW4gYmUgcGxh
Y2VkIGluIHR3byBsb2NhdGlvbnM6DQo+ID4gPiA+ICAqIHRoZSBzZWNvbmQgbGluZSBvZiB0ZXN0
IG91dHB1dCwgd2hlbiB0aGUgbnVtYmVyIG9mIHRlc3QgY2FzZXMgaXMga25vd24NCj4gPiA+ID4g
ICAgaW4gYWR2YW5jZQ0KPiA+ID4gPiAgKiBhcyB0aGUgbGFzdCBsaW5lIG9mIHRlc3Qgb3V0cHV0
LCB3aGVuIHRoZSBudW1iZXIgb2YgdGVzdCBjYXNlcyBpcyBub3QNCj4gPiA+ID4gICAga25vd24g
aW4gYWR2YW5jZS4NCj4gPiA+ID4NCj4gPiA+ID4gTW9zdCBvZnRlbiwgdGhlIG51bWJlciBvZiB0
ZXN0IGNhc2VzIGlzIGtub3duIGluIGFkdmFuY2UsIGFuZCB0aGUgdGVzdCBwbGFuDQo+ID4gPiA+
IGxpbmUgYXBwZWFycyBhcyB0aGUgc2Vjb25kIGxpbmUgb2YgdGVzdCBvdXRwdXQsIGltbWVkaWF0
ZWx5IGZvbGxvd2luZw0KPiA+ID4gPiB0aGUgb3V0cHV0IHZlcnNpb24gbGluZS4gIFRoZSBudW1i
ZXIgb2YgdGVzdCBjYXNlcyBtaWdodCBub3QgYmUga25vd24NCj4gPiA+ID4gaW4gYWR2YW5jZSBp
ZiB0aGUgbnVtYmVyIG9mIHRlc3RzIGlzIGNhbGN1bGF0ZWQgZnJvbSBydW50aW1lIGRhdGEuDQo+
ID4gPiA+IEluIHRoaXMgY2FzZSwgdGhlIHRlc3QgcGxhbiBsaW5lIGlzIGVtaXR0ZWQgYXMgdGhl
IGxhc3QgbGluZSBvZiB0ZXN0DQo+ID4gPiA+IG91dHB1dC4NCj4gPiA+DQo+ID4gPiBLVW5pdCBp
cyBjdXJyZW50bHkgaW5jbHVkaW5nIHRoZSB0ZXN0IHBsYW4gbGluZSBvbmx5IGZvciBzdWJ0ZXN0
cywgYXMNCj4gPiA+IHRoZSBjdXJyZW50IHZlcnNpb24gZG9lc24ndCBhY3R1YWxseSBrbm93IGhv
dyBtYW55IHRlc3Qgc3VpdGVzIHdpbGwNCj4gPiA+IHJ1biBpbiBhZHZhbmNlLg0KPiA+ID4gVGhp
cyBpcyBzb21ldGhpbmcgdGhlcmUncyB3b3JrIHVuZGVyd2F5IHRvIGZpeCwgdGhvdWdoLg0KPiA+
IFNvdW5kcyBnb29kLiAgWW91IGNhbiBqdXN0IHB1dCB0aGUgbGluZSBhdCB0aGUgYm90dG9tIGlm
IGl0J3MNCj4gPiBvYm5veGlvdXMgdG8gY2FsY3VsYXRlIGFoZWFkIG9mIHRpbWUuDQo+IA0KPiBJ
IHRob3VnaHQgdGhhdCBpcyBub3QgaW4gdGhlIFRBUCBzcGVjPw0KPiANCj4gSSBraW5kIG9mIGxp
a2UgcHJpbnRpbmcgb3V0IGFoZWFkIG9mIHRpbWUgaG93IG1hbnkgdGVzdHMgd2UgZXhwZWN0IHRv
DQo+IHJ1biwgc28gaWYgd2UgY3Jhc2ggd2Uga25vdyBob3cgbWFueSB0ZXN0cyB3ZXJlbid0IHJ1
bi4NCj4gDQo+IEluIGFueSBjYXNlLCB1bnRpbCB3ZSBnZXQgdGhlIGNoYW5nZSBpbiB0aGF0IERh
dmlkIGlzIHJlZmVyZW5jaW5nLCB3ZQ0KPiBjYW5ub3QgcHJpbnQgb3V0IHRoZSB0ZXN0IHBsYW4g
Zm9yIHRoZSAic3VwZXIgdGVzdCIgYmVmb3JlIG9yIGFmdGVyDQo+IGJlY2F1c2UgS1VuaXQgZG9l
c24ndCBrbm93IHdoZW4gaXQgaXMgImRvbmUiLiBTbyBtb3ZpbmcgaXQgdG8gdGhlDQo+IGJvdHRv
bSBkb2Vzbid0IHJlYWxseSBoZWxwIHVzLg0KPiANCj4gPiBEb2VzIHRoaXMgbWVhbiB0aGF0IEtV
bml0IHRyZWF0cyBlYWNoIHN1Yi10ZXN0IGFzIGFuIGluZGl2aWR1YWwgdGVzdCBjYXNlDQo+ID4g
b2YgdGhlICJzdXBlci10ZXN0Ij8NCj4gDQo+IFllcy4NCj4gDQo+IEF0IHRoZSB0b3AgbGV2ZWws
IHdlIGhhdmUgYWxsIHRlc3Qgc3VpdGVzLiBFYWNoIHN1YnRlc3QgaW4gVEFQIGlzIGENCj4gdGVz
dCBzdWl0ZSBpbiBLVW5pdC4gRWFjaCBjYXNlIGluIGVhY2ggc3VidGVzdCBpbiBUQVAgaXMgYSB0
ZXN0IGNhc2UNCj4gaW4gS1VuaXQuDQo+IA0KPiA+IEluIHJlc3VsdHMgc3VtbWFyaWVzIGZvciBh
IHN1cGVyLXRlc3QsIGFyZSBhbGwgc3ViLXRlc3QgY2FzZXMgY291bnRlZCwNCj4gPiBvciBqdXN0
IHRoZSBsaXN0IG9mIHN1Yi10ZXN0cz8NCj4gDQo+IEp1c3QgdGhlIHN1Yi10ZXN0cy4gRWFjaCBz
dWJ0ZXN0IGlzIHJlc3BvbnNpYmxlIGZvciBjb3VudGluZyBpdCdzIG93biBjYXNlczoNCj4gDQo+
IGh0dHBzOi8vZ2l0aHViLmNvbS9pc2FhY3MvdGVzdGFueXRoaW5nLmdpdGh1Yi5pby9ibG9iL3Rh
cDE0L3RhcC12ZXJzaW9uLTE0LXNwZWNpZmljYXRpb24ubWQjc3VidGVzdHMNCj4gDQo+IENoZWVy
cw0K
