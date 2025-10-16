Return-Path: <linux-kselftest+bounces-43287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E55BE19E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 08:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F7748465E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 06:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D0253F1A;
	Thu, 16 Oct 2025 06:00:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAD2566E9;
	Thu, 16 Oct 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594420; cv=none; b=iiRdCEX3R5y7bOLxnBv6KPBK8jCsnTx853N7PnH8OCZ6n/4HzcpBvwWZ0RYbFafQZdZmmYSBVIKt6OfanetsJteEEz/dAlBpLT63SZjYRMamIg6914sHT+ynphLQkek8pkktmQ9EPn1+zLsKppFgXf07/L2BauCaAcmW+W1gBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594420; c=relaxed/simple;
	bh=zL3WvO3665EouwcoDa/nbIqn/ahEBMnS/1uR2CNyfWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a0dDLib8uZvWIw5wNIDCNeThEV2vqfZZUb3FnbCxZmmCPCJoIvP4NSXKgoZbwx2y1qtHMJ0gmDBO96TfHFD4ZPdeX2Q5lB/DPbDGutfM7JahdtxpjdZbi/6IA6Xg8fwcGAl5mJ4ADrXO78mPAxhRrYFZbASA8WxlX2u3dVqA6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Lance Yang <lance.yang@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "wireguard@lists.zx2c4.com"
	<wireguard@lists.zx2c4.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Hildenbrand
	<david@redhat.com>, Florian Wesphal <fw@strlen.de>, Jakub Kacinski
	<kuba@kernel.org>, "Jason A . Donenfeld" <jason@zx2c4.com>, Joel Granados
	<joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Liam Howlett
	<liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Petr Mladek <pmladek@suse.com>, "Phil
 Auld" <pauld@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Russell King
	<linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt
	<rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW3Y0XSBodW5nX3Rhc2s6?=
 =?utf-8?B?IFBhbmljIHdoZW4gdGhlcmUgYXJlIG1vcmUgdGhhbiBOIGh1bmcgdGFza3Mg?=
 =?utf-8?Q?at_the_same_time?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bdjRdIGh1bmdfdGFzazogUGFu?=
 =?utf-8?B?aWMgd2hlbiB0aGVyZSBhcmUgbW9yZSB0aGFuIE4gaHVuZyB0YXNrcyBhdCB0?=
 =?utf-8?Q?he_same_time?=
Thread-Index: AQHcPZ4O/k3Wsx0bHk6g9O8K49+CJbTDtCqAgACThiA=
Date: Thu, 16 Oct 2025 05:57:34 +0000
Message-ID: <bb443552b6db40548a4fae98d1f63c80@baidu.com>
References: <20251015063615.2632-1-lirongqing@baidu.com>
 <4db3bd26-1f74-4096-84fd-f652ec9a4d27@linux.dev>
In-Reply-To: <4db3bd26-1f74-4096-84fd-f652ec9a4d27@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IExHVE0uIEl0IHdvcmtzIGFzIGV4cGVjdGVkLCB0aGFua3MhDQo+IA0KPiBPbiAyMDI1LzEw
LzE1IDE0OjM2LCBsaXJvbmdxaW5nIHdyb3RlOg0KPiA+IEZyb206IExpIFJvbmdRaW5nIDxsaXJv
bmdxaW5nQGJhaWR1LmNvbT4NCj4gDQo+IEZvciB0aGUgY29tbWl0IG1lc3NhZ2UsIEknZCBzdWdn
ZXN0IHRoZSBmb2xsb3dpbmcgZm9yIGJldHRlciBjbGFyaXR5Og0KPiANCj4gYGBgDQo+IFRoZSBo
dW5nX3Rhc2tfcGFuaWMgc3lzY3RsIGlzIGN1cnJlbnRseSBhIGJsdW50IGluc3RydW1lbnQ6IGl0
J3MgYWxsIG9yIG5vdGhpbmcuDQo+IA0KPiBQYW5pY2tpbmcgb24gYSBzaW5nbGUgaHVuZyB0YXNr
IGNhbiBiZSBhbiBvdmVycmVhY3Rpb24gdG8gYSB0cmFuc2llbnQgZ2xpdGNoLiBBDQo+IG1vcmUg
cmVsaWFibGUgaW5kaWNhdG9yIG9mIGEgc3lzdGVtaWMgcHJvYmxlbSBpcyB3aGVuIG11bHRpcGxl
IHRhc2tzIGhhbmcNCj4gc2ltdWx0YW5lb3VzbHkuDQo+IA0KPiBFeHRlbmQgaHVuZ190YXNrX3Bh
bmljIHRvIGFjY2VwdCBhbiBpbnRlZ2VyIHRocmVzaG9sZCwgYWxsb3dpbmcgdGhlIGtlcm5lbA0K
PiB0byBwYW5pYyBvbmx5IHdoZW4gTiBodW5nIHRhc2tzIGFyZSBkZXRlY3RlZCBpbiBhIHNpbmds
ZSBzY2FuLiBUaGlzIHByb3ZpZGVzDQo+IGZpbmVyIGNvbnRyb2wgdG8gZGlzdGluZ3Vpc2ggYmV0
d2VlbiBpc29sYXRlZCBpbmNpZGVudHMgYW5kIHN5c3RlbS13aWRlDQo+IGZhaWx1cmVzLg0KPiAN
Cj4gVGhlIGFjY2VwdGVkIHZhbHVlcyBhcmU6DQo+IC0gMDogRG9uJ3QgcGFuaWMgKHVuY2hhbmdl
ZCkNCj4gLSAxOiBQYW5pYyBvbiB0aGUgZmlyc3QgaHVuZyB0YXNrICh1bmNoYW5nZWQpDQo+IC0g
TiA+IDE6IFBhbmljIGFmdGVyIE4gaHVuZyB0YXNrcyBhcmUgZGV0ZWN0ZWQgaW4gYSBzaW5nbGUg
c2Nhbg0KPiANCj4gVGhlIG9yaWdpbmFsIGJlaGF2aW9yIGlzIHByZXNlcnZlZCBmb3IgdmFsdWVz
IDAgYW5kIDEsIG1haW50YWluaW5nIGZ1bGwNCj4gYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4g
YGBgDQo+IA0KPiBJZiB5b3UgYWdyZWUsIGxpa2VseSBubyBuZWVkIHRvIHJlc2VuZCAtIEFuZHJl
dyBjb3VsZCBwaWNrIGl0IHVwIGRpcmVjdGx5IHdoZW4NCj4gYXBwbHlpbmcgOikNCj4gDQoNClRo
aXMgaXMgYmV0dGVyOw0KDQpBbmRyZXcsIGNvdWxkIHlvdSBwaWNrIGl0IHVwIGRpcmVjdGx5DQoN
ClRoYW5rcw0KDQotTGkNCg0KPiA+DQo+ID4gQ3VycmVudGx5LCB3aGVuICdodW5nX3Rhc2tfcGFu
aWMnIGlzIGVuYWJsZWQsIHRoZSBrZXJuZWwgcGFuaWNzDQo+ID4gaW1tZWRpYXRlbHkgdXBvbiBk
ZXRlY3RpbmcgdGhlIGZpcnN0IGh1bmcgdGFzay4gSG93ZXZlciwgc29tZSBodW5nDQo+ID4gdGFz
a3MgYXJlIHRyYW5zaWVudCBhbmQgYWxsb3cgc3lzdGVtIHJlY292ZXJ5LCB3aGlsZSBwZXJzaXN0
ZW50IGhhbmdzDQo+ID4gc2hvdWxkIHRyaWdnZXIgYSBwYW5pYyB3aGVuIGFjY3VtdWxhdGluZyBi
ZXlvbmQgYSB0aHJlc2hvbGQuDQo+ID4NCj4gPiBFeHRlbmQgdGhlICdodW5nX3Rhc2tfcGFuaWMn
IHN5c2N0bCB0byBhY2NlcHQgYSB0aHJlc2hvbGQgdmFsdWUNCj4gPiBzcGVjaWZ5aW5nIHRoZSBu
dW1iZXIgb2YgaHVuZyB0YXNrcyB0aGF0IG11c3QgYmUgZGV0ZWN0ZWQgYmVmb3JlDQo+ID4gdHJp
Z2dlcmluZyBhIGtlcm5lbCBwYW5pYy4gVGhpcyBwcm92aWRlcyBmaW5lciBjb250cm9sIGZvcg0K
PiA+IGVudmlyb25tZW50cyB3aGVyZSB0cmFuc2llbnQgaGFuZ3MgbWF5IG9jY3VyIGJ1dCBwZXJz
aXN0ZW50IGhhbmdzDQo+IHNob3VsZCBiZSBmYXRhbC4NCj4gPg0KPiA+IFRoZSBzeXNjdGwgbm93
IGFjY2VwdHM6DQo+ID4gLSAwOiBkb24ndCBwYW5pYyAobWFpbnRhaW5zIG9yaWdpbmFsIGJlaGF2
aW9yKQ0KPiA+IC0gMTogcGFuaWMgb24gZmlyc3QgaHVuZyB0YXNrIChtYWludGFpbnMgb3JpZ2lu
YWwgYmVoYXZpb3IpDQo+ID4gLSBOID4gMTogcGFuaWMgYWZ0ZXIgTiBodW5nIHRhc2tzIGFyZSBk
ZXRlY3RlZCBpbiBhIHNpbmdsZSBzY2FuDQo+ID4NCj4gPiBUaGlzIG1haW50YWlucyBiYWNrd2Fy
ZCBjb21wYXRpYmlsaXR5IHdoaWxlIHByb3ZpZGluZyBmbGV4aWJpbGl0eSBmb3INCj4gPiBkaWZm
ZXJlbnQgaGFuZyBzY2VuYXJpb3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBSb25nUWlu
ZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gQ2M6IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdA
Y29kZWNvbnN0cnVjdC5jb20uYXU+DQo+ID4gQ2M6IEFuc2h1bWFuIEtoYW5kdWFsIDxhbnNodW1h
bi5raGFuZHVhbEBhcm0uY29tPg0KPiA+IENjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRl
Pg0KPiA+IENjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPiBDYzog
RmxvcmlhbiBXZXNwaGFsIDxmd0BzdHJsZW4uZGU+DQo+ID4gQ2M6IEpha3ViIEthY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IEphc29uIEEuIERvbmVuZmVsZCA8amFzb25AengyYzQu
Y29tPg0KPiA+IENjOiBKb2VsIEdyYW5hZG9zIDxqb2VsLmdyYW5hZG9zQGtlcm5lbC5vcmc+DQo+
ID4gQ2M6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+DQo+ID4gQ2M6IEpvbmF0aGFuIENv
cmJldCA8Y29yYmV0QGx3bi5uZXQ+DQo+ID4gQ2M6IEtlZXMgQ29vayA8a2Vlc0BrZXJuZWwub3Jn
Pg0KPiA+IENjOiBMYW5jZSBZYW5nIDxsYW5jZS55YW5nQGxpbnV4LmRldj4NCj4gPiBDYzogTGlh
bSBIb3dsZXR0IDxsaWFtLmhvd2xldHRAb3JhY2xlLmNvbT4NCj4gPiBDYzogTG9yZW56byBTdG9h
a2VzIDxsb3JlbnpvLnN0b2FrZXNAb3JhY2xlLmNvbT4NCj4gPiBDYzogIk1hc2FtaSBIaXJhbWF0
c3UgKEdvb2dsZSkiIDxtaGlyYW1hdEBrZXJuZWwub3JnPg0KPiA+IENjOiAiUGF1bCBFIC4gTWNL
ZW5uZXkiIDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFBhd2FuIEd1cHRhIDxwYXdhbi5r
dW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFBldHIgTWxhZGVrIDxwbWxhZGVr
QHN1c2UuY29tPg0KPiA+IENjOiBQaGlsIEF1bGQgPHBhdWxkQHJlZGhhdC5jb20+DQo+ID4gQ2M6
IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+IENjOiBSdXNzZWxsIEtp
bmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gPiBDYzogU2h1YWggS2hhbiA8c2h1YWhAa2Vy
bmVsLm9yZz4NCj4gPiBDYzogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiA+IENj
OiBTdGFuaXNsYXYgRm9taWNoZXYgPHNkZkBmb21pY2hldi5tZT4NCj4gPiBDYzogU3RldmVuIFJv
c3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+ID4gLS0tDQo+IA0KPiBTbzoNCj4gDQo+IFJl
dmlld2VkLWJ5OiBMYW5jZSBZYW5nIDxsYW5jZS55YW5nQGxpbnV4LmRldj4NCj4gVGVzdGVkLWJ5
OiBMYW5jZSBZYW5nIDxsYW5jZS55YW5nQGxpbnV4LmRldj4NCj4gDQo+IENoZWVycywNCj4gTGFu
Y2UNCg0K

