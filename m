Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358AD3FAEBA
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Aug 2021 23:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhH2VbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Aug 2021 17:31:06 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:41490 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhH2VbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Aug 2021 17:31:05 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 49590891B0;
        Mon, 30 Aug 2021 09:30:11 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1630272611;
        bh=2VxG7jeNFChVfsChtYBBq/RBtzAnAohYANiuBqfFPm0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=FQSanCDh1L4izFEHExcF8Vf1vgA7Si6pqaxlFVckOESjn7qV0/VXMz/KLDdGSxTS8
         7BshKstbLbwkymDTYEeTDYl0tnZf1t4F7ZMrAkk3cu5EESKteE1tawTdgBcIpQFUuY
         pGvYUR5J1acqdHUoGxsScHY0lB4tjBZeK09lCHJMjY9RGogSaduO/e2qtu0D5ynmmK
         qpV3uG2VEV5THjKYvjEJzxs6N4pikKlyiHTshc8EKlsDd4TSmONSdLt5UYgAdKKW0L
         JLUSqjfI+okCfx13eZ++eNnFZNzh8SQevoAVH5P8FcfdnfmktQFfqubQ6JX8dLg7HS
         TjpZg7xkLq6Wg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B612bfc630001>; Mon, 30 Aug 2021 09:30:11 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 30 Aug 2021 09:30:10 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.023; Mon, 30 Aug 2021 09:30:10 +1200
From:   Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>
To:     Blair Steven <Blair.Steven@alliedtelesis.co.nz>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Anthony Lineham <Anthony.Lineham@alliedtelesis.co.nz>,
        "pablo@netfilter.org" <pablo@netfilter.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        Scott Parlane <Scott.Parlane@alliedtelesis.co.nz>,
        "kadlec@netfilter.org" <kadlec@netfilter.org>,
        "kuba@kernel.org" <kuba@kernel.org>, "fw@strlen.de" <fw@strlen.de>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: netfilter: Add RFC-7597 Section 5.1
 PSID support
Thread-Topic: [PATCH net-next 2/3] net: netfilter: Add RFC-7597 Section 5.1
 PSID support
Thread-Index: AQHXjNSPAbFBOAqLzky9ZULw/uETIquDw/yAgAaTRYA=
Date:   Sun, 29 Aug 2021 21:30:09 +0000
Message-ID: <70b525555d44fc5c01dc70d59be9f2dd99da01e9.camel@alliedtelesis.co.nz>
References: <20210726143729.GN9904@breakpoint.cc>
         <20210809041037.29969-1-Cole.Dishington@alliedtelesis.co.nz>
         <20210809041037.29969-3-Cole.Dishington@alliedtelesis.co.nz>
         <20210825170529.GA31115@salvia>
In-Reply-To: <20210825170529.GA31115@salvia>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D56C90812D124F44A227EA5DD16F0C56@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=MhDmnRu9jo8A:10 a=62ntRvTiAAAA:8 a=voM4FWlXAAAA:8 a=4JOCHWQC07SENwxl1fgA:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=IC2XNlieTeVoXbcui8wp:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGVsbG8sDQoNClRoYW5rcyBmb3IgeW91ciB0aW1lIHJldmlld2luZyENCg0KT24gV2VkLCAyMDIx
LTA4LTI1IGF0IDE5OjA1ICswMjAwLCBQYWJsbyBOZWlyYSBBeXVzbyB3cm90ZToNCj4gSGksDQo+
IA0KPiBPbiBNb24sIEF1ZyAwOSwgMjAyMSBhdCAwNDoxMDozNlBNICsxMjAwLCBDb2xlIERpc2hp
bmd0b24gd3JvdGU6DQo+ID4gQWRkcyBzdXBwb3J0IGZvciBtYXNxdWVyYWRpbmcgaW50byBhIHNt
YWxsZXIgc3Vic2V0IG9mIHBvcnRzIC0NCj4gPiBkZWZpbmVkIGJ5IHRoZSBQU0lEIHZhbHVlcyBm
cm9tIFJGQy03NTk3IFNlY3Rpb24gNS4xLiBUaGlzIGlzIHBhcnQgb2YNCj4gPiB0aGUgc3VwcG9y
dCBmb3IgTUFQLUUgYW5kIExpZ2h0d2VpZ2h0IDRvdmVyNiwgd2hpY2ggYWxsb3dzIG11bHRpcGxl
DQo+ID4gZGV2aWNlcyB0byBzaGFyZSBhbiBJUHY0IGFkZHJlc3MgYnkgc3BsaXR0aW5nIHRoZSBM
NCBwb3J0IC8gaWQgaW50bw0KPiA+IHJhbmdlcy4NCj4gPiANCj4gPiBDby1kZXZlbG9wZWQtYnk6
IEFudGhvbnkgTGluZWhhbSA8YW50aG9ueS5saW5laGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQW50aG9ueSBMaW5laGFtIDxhbnRob255LmxpbmVoYW1AYWxsaWVk
dGVsZXNpcy5jby5uej4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IFNjb3R0IFBhcmxhbmUgPHNjb3R0
LnBhcmxhbmVAYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTY290dCBQ
YXJsYW5lIDxzY290dC5wYXJsYW5lQGFsbGllZHRlbGVzaXMuY28ubno+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQmxhaXIgU3RldmVuIDxibGFpci5zdGV2ZW5AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDb2xlIERpc2hpbmd0b24gPENvbGUuRGlzaGluZ3RvbkBhbGxpZWR0
ZWxlc2lzLmNvLm56Pg0KPiA+IFJldmlld2VkLWJ5OiBGbG9yaWFuIFdlc3RwaGFsIDxmd0BzdHJs
ZW4uZGU+DQo+IFsuLi5dDQo+IA0KPiBMb29raW5nIGF0IHRoZSB1c2Vyc3BhY2UgbG9naWM6DQo+
IA0KPiBodHRwczovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD02dmltNGZjVkxq
UGtJYkxVRHF6M1RqMlc0Z1hXTkNrWWE1bGxXZ2dCakEmdT1odHRwcyUzYSUyZiUyZnBhdGNod29y
ayUyZW96bGFicyUyZW9yZyUyZnByb2plY3QlMmZuZXRmaWx0ZXItZGV2ZWwlMmZwYXRjaCUyZjIw
MjEwNzE2MDAyMjE5JTJlMzAxOTMtMS1Db2xlJTJlRGlzaGluZ3RvbiU0MGFsbGllZHRlbGVzaXMl
MmVjbyUyZW56JTJmDQo+IA0KPiBDaHVuayBleHRyYWN0ZWQgZnJvbSB2b2lkIHBhcnNlX3BzaWQo
Li4uKQ0KPiANCj4gPiAgICAgICAgb2Zmc2V0ID0gKDEgPDwgKDE2IC0gb2Zmc2V0X2xlbikpOw0K
PiANCj4gQXNzdW1pbmcgb2Zmc2V0X2xlbiA9IDYsIHRoZW4geW91IHNraXAgMC0xMDIzIHBvcnRz
LCBPSy4NCj4gDQo+ID4gICAgICAgIHBzaWQgPSBwc2lkIDw8ICgxNiAtIG9mZnNldF9sZW4gLSBw
c2lkX2xlbik7DQo+IA0KPiBUaGlzIHBzaWQgY2FsY3VsYXRpb24gaXMgY29ycmVjdD8gTWF5YmU6
DQo+IA0KPiAgICAgICAgIHBzaWQgPSBwc2lkIDw8ICgxNiAtIG9mZnNldF9sZW4pOw0KDQpQU0lE
IHBvcnQgbnVtYmVycyBoYXZlIHRoZSBmb3JtDQpbb2Zmc2V0fFBTSUR8al0NCmFuZA0KMTYgPSBv
ZmZzZXRfbGVuZ3RoICsgUFNJRF9sZW5ndGggKyBqX2xlbmd0aC4NClRoZSBQU0lEIGNhbGN1bGF0
aW9uIGFib3ZlIGlzIGJpdCBzaGlmdGluZyB0aGUgcGFzc2VkIHBzaWQgdXAgal9sZW5ndGguDQoN
ClRoZSB1c2Vyc3BhY2UgdG9vbCBhY2NlcHRzIHRoZSB1bnNoaWZ0ZWQgcHNpZCB0byBiZSBjb25z
aXN0ZW50IHdpdGggaG93IFJGQzc1OTcgc3BlY2lmaWVkIGl0IChzZWUgUkZDNzU5NyBBcHBlbmRp
eCBBLiBFeGFtcGxlcykuDQoNCj4gDQo+IGluc3RlYWQ/DQo+IA0KPiAgICAgICAgIHBzaWQ9MCAg
PT4gICAgICAwIDw8ICgxNiAtIDYpID0gMTAyNA0KPiAgICAgICAgIHBzaWQ9MSAgPT4gICAgICAx
IDw8ICgxNiAtIDYpID0gMjA0OA0KPiANCj4gVGhpcyBpcyBpbXBsaWNpdGx5IGFzc3VtaW5nIHRo
YXQgNjQgUFNJRHMgYXJlIGF2YWlsYWJsZSwgZWFjaCBvZiB0aGVtDQo+IHRha2luZyAxMDI0IHBv
cnRzLCBpZS4gcHNpZF9sZW4gaXMgNiBiaXRzLiBCdXQgd2h5IGFyZSB5b3Ugc3VidHJhY3RpbmcN
Cj4gdGhlIHBzaWRfbGVuIGFib3ZlPw0KPiANCj4gPiAgICAgICAgLyogSGFuZGxlIHRoZSBzcGVj
aWFsIGNhc2Ugb2Ygbm8gb2Zmc2V0IGJpdHMgKGE9MCksIHNvIG9mZnNldCBsb29wcyAqLw0KPiA+
ICAgICAgICBtaW4gPSBwc2lkOw0KPiANCj4gT0ssIHRoaXMgbGluZSBhYm92ZSBpcyB0aGUgbWlu
aW1hbCBwb3J0IGluIHRoZSByYW5nZQ0KPiANCj4gPiAgICAgICAgaWYgKG9mZnNldCkNCj4gPiAg
ICAgICAgICAgICAgICBtaW4gKz0gb2Zmc2V0Ow0KPiANCj4gLi4uIHdoaWNoIGlzIGluY3JlbWVu
dGVkIGJ5IHRoZSBvZmZzZXQgKHRvIHNraXAgdGhlIDAtMTAyMyBwb3J0cykuDQo+IA0KPiA+ICAg
ICAgIHItPm1pbl9wcm90by5hbGwgPSBodG9ucyhtaW4pOw0KPiA+ICAgICAgIHItPm1heF9wcm90
by5hbGwgPSBodG9ucyhtaW4gKyAoKDEgPDwgKDE2IC0gb2Zmc2V0X2xlbiAtIHBzaWRfbGVuKSkg
LSAxKSk7DQo+IA0KPiBIZXJlLCB5b3Ugc3VidHJhY3QgcHNpZF9sZW4gYWdhaW4sIG5vdCBzdXJl
IHdoeS4NCg0KRWFjaCBQU0lEIHBvcnQgcmFuZ2UgaXMgbWFkZSB1cCBvZiBtYW55IHNtYWxsZXIg
Y29udGlndW91cyBwb3J0IHN1Yi1yYW5nZXMgIChleGNlcHQgZm9yIHRoZSBzcGVjaWFsIGNhc2Ug
b2Ygb2Zmc2V0X2xlbiA9IDApIGUuZy4gZm9yIFBTSUQ9MHgzNCxwc2lkX2xlbmd0aD04LHBzaWRf
b2Zmc2V0PTYgdGhlIHJhbmdlcyBhcmUgMTIzMi0xMjM1LCAyMjU2LTIyNTksIC4uLiwgNjM2OTYt
NjM2OTksIDY0NzIwLTY0NzIzIChUYWtlbiBmcm9tIHJmYzc1OTcgQXBwZW5kaXggQS4gRXhhbXBs
ZXMpLg0KVGhlIGFib3ZlIGNhbGN1bGF0aW9uIGlzIHNlbGVjdGluZyB0aGUgZmlyc3Qgc3ViLXJh
bmdlLiBNYXggaXMgY29tcHV0ZWQgYnkgZmluZGluZyBqX2xlbmd0aCBhbmQgZmlsbGluZyBpdCB3
aXRoIDEncy4NCg0KPiANCj4gPiAgICAgICByLT5iYXNlX3Byb3RvLmFsbCA9IGh0b25zKG9mZnNl
dCk7DQo+IA0KPiBiYXNlIGlzIHNldCB0byBvZmZzZXQsIGllLiAxMDI0Lg0KPiANCj4gPiAgICAg
ICByLT5mbGFncyB8PSBORl9OQVRfUkFOR0VfUFNJRDsNCj4gPiAgICAgICByLT5mbGFncyB8PSBO
Rl9OQVRfUkFOR0VfUFJPVE9fU1BFQ0lGSUVEOw0KPiANCj4gTm93IGxvb2tpbmcgYXQgdGhlIGtl
cm5lbCBzaWRlLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L25ldGZpbHRlci9uZl9uYXRfbWFz
cXVlcmFkZS5jIGIvbmV0L25ldGZpbHRlci9uZl9uYXRfbWFzcXVlcmFkZS5jDQo+ID4gaW5kZXgg
OGU4YTY1ZDQ2MzQ1Li4xOWE0NzU0Y2RhNzYgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L25ldGZpbHRl
ci9uZl9uYXRfbWFzcXVlcmFkZS5jDQo+ID4gKysrIGIvbmV0L25ldGZpbHRlci9uZl9uYXRfbWFz
cXVlcmFkZS5jDQo+ID4gQEAgLTU1LDggKzU1LDMxIEBAIG5mX25hdF9tYXNxdWVyYWRlX2lwdjQo
c3RydWN0IHNrX2J1ZmYgKnNrYiwgdW5zaWduZWQgaW50IGhvb2tudW0sDQo+ID4gIAluZXdyYW5n
ZS5mbGFncyAgICAgICA9IHJhbmdlLT5mbGFncyB8IE5GX05BVF9SQU5HRV9NQVBfSVBTOw0KPiA+
ICAJbmV3cmFuZ2UubWluX2FkZHIuaXAgPSBuZXdzcmM7DQo+ID4gIAluZXdyYW5nZS5tYXhfYWRk
ci5pcCA9IG5ld3NyYzsNCj4gPiAtCW5ld3JhbmdlLm1pbl9wcm90byAgID0gcmFuZ2UtPm1pbl9w
cm90bzsNCj4gPiAtCW5ld3JhbmdlLm1heF9wcm90byAgID0gcmFuZ2UtPm1heF9wcm90bzsNCj4g
PiArDQo+ID4gKwlpZiAocmFuZ2UtPmZsYWdzICYgTkZfTkFUX1JBTkdFX1BTSUQpIHsNCj4gPiAr
CQl1MTYgYmFzZSA9IG50b2hzKHJhbmdlLT5iYXNlX3Byb3RvLmFsbCk7DQo+ID4gKwkJdTE2IG1p
biA9ICBudG9ocyhyYW5nZS0+bWluX3Byb3RvLmFsbCk7DQo+ID4gKwkJdTE2IG9mZiA9IDA7DQo+
ID4gKw0KPiA+ICsJCS8qIHh0YWJsZXMgc2hvdWxkIHN0b3AgYmFzZSA+IDJeMTUgYnkgZW5mb3Jj
ZW1lbnQgb2YNCj4gPiArCQkgKiAwIDw9IG9mZnNldF9sZW4gPCAxNiBhcmd1bWVudCwgd2l0aCBv
ZmZzZXRfbGVuPTANCj4gPiArCQkgKiBhcyBhIHNwZWNpYWwgY2FzZSBpbndoaWNoIGJhc2U9MC4N
Cj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzIGNvbW1lbnQuDQoNClRoaXMgaXMgYSBzYW5p
dHkgY2hlY2suIFRoZSB1c2Vyc3BhY2UgdG9vbCByZXN0cmljdHMgb2Zmc2V0X2xlbiB0byB0aGUg
c3BlY2lmaWVkIHJhbmdlIGFuZCBzaW5jZSBiYXNlID0gMl4oMTYgLSBvZmZzZXRfbGVuKSAob3Ig
YmFzZSA9IDAgZm9yIHRoZSBzcGVjaWFsIGNhc2Ugb2Ygb2Zmc2V0X2xlbiA9IDE2KSB0aGUgYmVs
b3cgY29uZGl0aW9uIHNob3VsZCBuZXZlciBiZSB0cnVlLg0KSG93ZXZlciwgaWYgYmFzZSBncmVh
dGVyIHRoYW4gMTw8MTUgd2FzIGFsbG93ZWQsIGEgZGl2aWRlIGJ5IHplcm8gZXJyb3Igd291bGQg
b2NjdXIgb24gdGhlIGJsb2NrIGJlbG93Lg0KDQo+IA0KPiA+ICsJCSAqLw0KPiA+ICsJCWlmIChX
QVJOX09OX09OQ0UoYmFzZSA+ICgxIDw8IDE1KSkpDQo+ID4gKwkJCXJldHVybiBORl9EUk9QOw0K
PiA+ICsNCj4gPiArCQkvKiBJZiBvZmZzZXQ9MCwgcG9ydCByYW5nZSBpcyBpbiBvbmUgY29udGln
dW91cyBibG9jayAqLw0KPiA+ICsJCWlmIChiYXNlKQ0KPiA+ICsJCQlvZmYgPSBwcmFuZG9tX3Uz
Ml9tYXgoKCgxIDw8IDE2KSAvIGJhc2UpIC0gMSk7DQo+IA0KPiBBc3N1bWluZyB0aGUgZXhhbXBs
ZSBhYm92ZSwgYmFzZSBpcyBzZXQgdG8gMTAyNC4gVGhlbiwgb2ZmIGlzIGEgcmFuZG9tDQo+IHZh
bHVlIGJldHdlZW4gVUlOVDE2X01BWCAoeW91IGV4cHJlc3NlZCB0aGlzIGFzIDEgPDwgMTYpIGFu
ZCB0aGUgYmFzZQ0KPiB3aGljaCBpcyAxMDI0IG1pbnVzIDEuDQo+IA0KPiBTbyB0aGlzIGlzIHBp
Y2tpbmcgYSByYW5kb20gb2ZmIChhY3R1YWxseSB0aGUgUFNJRD8pIGJldHdlZW4gMCBhbmQgNjMu
DQo+IFdoYXQgYWJvdXQgY2xhc2hlcz8gSSBtZWFuLCB0d28gZGlmZmVyZW50IG1hY2hpbmVzIGJl
aGluZCB0aGUgTkFUDQo+IG1pZ2h0IGdldCB0aGUgc2FtZSBvZmYuDQo+IA0KPiA+ICsJCW5ld3Jh
bmdlLm1pbl9wcm90by5hbGwgICA9IGh0b25zKG1pbiArIGJhc2UgKiBvZmYpOw0KPiANCj4gbWlu
IGNvdWxkIGJlIDEwMjQsIDIwNDgsIDMwNzIuLi4geW91IGFkZCBiYXNlIHdoaWNoIGlzIDEwMjQg
KiBvZmYuDQo+IA0KPiBJcyB0aGlzIGR1cGxpY2F0ZWQ/IEJvdGggY2FsY3VsYXRlZCBpbiB1c2Vy
IGFuZCBrZXJuZWwgc3BhY2U/DQoNCkVhY2ggUFNJRCB2YWx1ZSBkZWZpbmVzIG1hbnkgY29udGln
dW91cyBwb3J0IHN1Yi1yYW5nZXMuIFRoZSByYW5kb21seSBjaG9zZW4gb2ZmIHNlbGVjdHMgdGhl
IGl0aCBzdWItcmFuZ2UgZm9yIGEgZ2l2ZW4gUFNJRCBlLmcuIG9mZj0xIHdvdWxkIHNlbGVjdCAy
MjU2LTIyNTkgZm9yIHJmYzc1OTcgQXBwZW5kaXggQS4gRXhhbXBsZXMuDQoNClRoZSB1c2Vyc3Bh
Y2UgdG9vbCBjYWxjdWxhdGVzIHRoZSBtaW4gYW5kIG1heCBvZiB0aGUgZmlyc3Qgc3ViLXJhbmdl
IGZvciBhIGdpdmVuIHBzaWQsIHdoZXJlYXMgdGhlIGFib3ZlIHJhbmRvbWx5IHNlbGVjdHMgb25l
IG9mIHRoZSBzdWItcmFuZ2VzIGZvciBhIGdpdmVuIHBzaWQuDQoNCmpfbGVuZ3RoIGRldGVybWlu
ZXMgaG93IGxhcmdlIGVhY2ggc3ViLXJhbmdlIHdpbGwgYmUsIHNvIGZvciBzbWFsbCBqX2xlbmd0
aCB2YWx1ZXMgdGhlcmUgc3RpbGwgaXMgdGhlIHJpc2sgdGhlIGNob3NlbiBzdWItcmFuZ2Ugd2ls
bCBiZSBleGhhdXN0ZWQuDQoNCj4gDQo+ID4gKwkJbmV3cmFuZ2UubWF4X3Byb3RvLmFsbCAgID0g
aHRvbnMobnRvaHMobmV3cmFuZ2UubWluX3Byb3RvLmFsbCkgKyBudG9ocyhyYW5nZS0+bWF4X3By
b3RvLmFsbCkgLSBtaW4pOw0KPiANCj4gSSdtIHN0b3BwaW5nIGhlcmUsIEknbSBnZXR0aW5nIGxv
c3QuDQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIGFib3V0IHRoaXMgUkZDIGlzIHRoYXQgeW91IHdv
dWxkIGxpa2UgdG8gc3BsaXQgdGhlDQo+IDE2LWJpdCBwb3J0cyBpbiByYW5nZXMgdG8gdW5pcXVl
bHkgaWRlbnRpZnkgdGhlIGhvc3QgYmVoaW5kIHRoZSBOQVQuDQo+IA0KPiBXaHkgZG9uJ3QgeW91
IGp1c3QgeW91IGp1c3Qgc2VsZWN0IHRoZSBwb3J0IHJhbmdlIGZyb20gdXNlcnNwYWNlDQo+IHV0
aWxpemluZyB0aGUgZXhpc3RpbmcgaW5mcmFzdHJ1Y3R1cmU/IEkgbWVhbiwgd2h5IGRvIHlvdSBu
ZWVkIHRoaXMNCj4ga2VybmVsIHBhdGNoPw0KDQpJZiB1dGlsaXppbmcgZXhpc3RpbmcgaW5mcmFz
dHJ1dHVyZSB0byBpbnN0YWxsIFBTSUQgcG9ydCByYW5nZXMgYSBsb3Qgb2YgcnVsZXMgd291bGQg
YmUgcmVxdWlyZWQgYXMgZWFjaCBQU0lEIHBvcnQgcmFuZ2UgaXMgbWFkZSB1cCBvZiBtYW55IHNt
YWxsZXIgc3ViLXJhbmdlcy4NCg0KZS5nLiAoZnJvbSByZmM3NTk3IEFwcGVuZGl4IEEuIEV4YW1w
bGVzKQ0KZm9yIHBzaWRfbGVuZ3RoPTgsb2Zmc2V0X2xlbmd0aD02IGVhY2ggUFNJRCB3b3VsZCBu
ZWVkIDYzIE5GX05BVF9SQU5HRV9QUk9UT19TUEVDSUZJRUQgcnVsZXMsIGhlbmNlIGEgdG90YWwg
b2YgMTYxMjggcnVsZXMgaWYgYWxsIHRoZSBQU0lEcyB3ZXJlIGFsbG9jYXRlZC4NCg0KPiANCj4g
RmxvcmlhbiBhbHJlYWR5IHN1Z2dlc3RlZDoNCj4gDQo+ID4gSXMgaXQgcmVhbGx5IG5lZWRlZCB0
byBwbGFjZSBhbGwgb2YgdGhpcyBpbiB0aGUgbmF0IGNvcmU/DQo+ID4gDQo+ID4gVGhlIG9ubHkg
dGhpbmcgdGhhdCBoYXMgdG8gYmUgZG9uZSBpbiB0aGUgTkFUIGNvcmUsIGFmYWljcywgaXMgdG8N
Cj4gPiBzdXBwcmVzcyBwb3J0IHJlYWxsb2NhdGlvbiBhdHRtZXB0cyB3aGVuIE5GX05BVF9SQU5H
RV9QU0lEIGlzIHNldC4NCj4gPiANCj4gPiBJcyB0aGVyZSBhIHJlYXNvbiB3aHkgbmZfbmF0X21h
c3F1ZXJhZGVfaXB2NC82IGNhbid0IGJlIGNoYW5nZWQgaW5zdGVhZA0KPiA+IHRvIGRvIHdoYXQg
eW91IHdhbnQ/DQo+ID4gDQo+ID4gQUZBSUNTIGl0cyBlbm91Z2ggdG8gc2V0IE5GX05BVF9SQU5H
RV9QUk9UT19TUEVDSUZJRUQgYW5kIGluaXQgdGhlDQo+ID4gdXBwZXIvbG93ZXIgYm91bmRhcmll
cywgaS5lLiBjaGFuZ2UgaW5wdXQgZ2l2ZW4gdG8gbmZfbmF0X3NldHVwX2luZm8oKS4NCj4gDQo+
IGV4dHJhY3RlZCBmcm9tOg0KPiANCj4gaHR0cHM6Ly9zY2FubWFpbC50cnVzdHdhdmUuY29tLz9j
PTIwOTg4JmQ9NnZpbTRmY1ZMalBrSWJMVURxejNUajJXNGdYV05Da1lhNXMwQmc4SmpBJnU9aHR0
cHMlM2ElMmYlMmZwYXRjaHdvcmslMmVvemxhYnMlMmVvcmclMmZwcm9qZWN0JTJmbmV0ZmlsdGVy
LWRldmVsJTJmcGF0Y2glMmYyMDIxMDQyMjAyMzUwNiUyZTQ2NTEtMS1Db2xlJTJlRGlzaGluZ3Rv
biU0MGFsbGllZHRlbGVzaXMlMmVjbyUyZW56JTJmDQoNCg0KDQoNCg0KDQo=
