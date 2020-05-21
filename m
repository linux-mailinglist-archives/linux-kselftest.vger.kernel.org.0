Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C051DD402
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgEURMW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 13:12:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:24313 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgEURMV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 13:12:21 -0400
IronPort-SDR: H4C2W5iRonoXUZdY36cWvSOh0EG/1Mbxs3McVsvAPX6mrt7boeESldDZyoipmcEHwYlm+FUk+S
 tW+eX7H4qREQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 10:12:19 -0700
IronPort-SDR: 945jnUa3R3Gx4lCH/pZ/V/Atl5F9IPZJyYeSoG08mACM1qQe1db683r7X9ujE/EgcztNiRdv/m
 g6V1doB5anJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="268709267"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2020 10:12:20 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 May 2020 10:12:20 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.205]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.25]) with mapi id 14.03.0439.000;
 Thu, 21 May 2020 10:12:20 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel" <linux-kernel@vger.kernel>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "dcb314@hotmail.com" <dcb314@hotmail.com>
Subject: RE: [PATCH V2 14/19] selftests/resctrl: Skip the test if requested
 resctrl feature is not supported
Thread-Topic: [PATCH V2 14/19] selftests/resctrl: Skip the test if requested
 resctrl feature is not supported
Thread-Index: AQHWLWGl+DZVZL5DgkKjKCK6NMr6/6iyHFgAgACuOdA=
Date:   Thu, 21 May 2020 17:12:19 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573B6697@ORSMSX114.amr.corp.intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
 <485f834d4f1188056b306263d800bffbc0c43430.1589835155.git.sai.praneeth.prakhya@intel.com>
 <6e12840d-d8fc-c8ef-cfad-eb8b514d3030@intel.com>
In-Reply-To: <6e12840d-d8fc-c8ef-cfad-eb8b514d3030@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmVp
bmV0dGUgQ2hhdHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIE1heSAyMCwgMjAyMCA0OjQ2IFBNDQo+IFRvOiBQcmFraHlhLCBTYWkgUHJhbmVldGggPHNh
aS5wcmFuZWV0aC5wcmFraHlhQGludGVsLmNvbT47DQo+IHNodWFoQGtlcm5lbC5vcmc7IHNraGFu
QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlOyBM
dWNrLCBUb255DQo+IDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgYmFidS5tb2dlckBhbWQuY29tOyBq
YW1lcy5tb3JzZUBhcm0uY29tOw0KPiBTaGFua2FyLCBSYXZpIFYgPHJhdmkudi5zaGFua2FyQGlu
dGVsLmNvbT47IFl1LCBGZW5naHVhDQo+IDxmZW5naHVhLnl1QGludGVsLmNvbT47IHg4NkBrZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWw7DQo+IGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbTsgZGNiMzE0QGhvdG1haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMTQvMTld
IHNlbGZ0ZXN0cy9yZXNjdHJsOiBTa2lwIHRoZSB0ZXN0IGlmIHJlcXVlc3RlZCByZXNjdHJsDQo+
IGZlYXR1cmUgaXMgbm90IHN1cHBvcnRlZA0KPiANCj4gSGkgU2FpLA0KDQpbU05JUF0NCg0KPiA+
IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdGVz
dHMuYw0KPiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsX3Rlc3Rz
LmMNCj4gPiBpbmRleCBmYjc3MDM0MTNiZTcuLmQ0NWFlMDA0ZWQ3NyAxMDA2NDQNCj4gPiAtLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdGVzdHMuYw0KPiA+ICsr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybF90ZXN0cy5jDQo+ID4g
QEAgLTE3MCw2ICsxNzAsMTAgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiA+
DQo+ID4gIAlpZiAoIWlzX2FtZCAmJiBtYm1fdGVzdCkgew0KPiA+ICAJCXByaW50ZigiIyBTdGFy
dGluZyBNQk0gQlcgY2hhbmdlIC4uLlxuIik7DQo+ID4gKwkJaWYgKCF2YWxpZGF0ZV9yZXNjdHJs
X2ZlYXR1cmVfcmVxdWVzdCgibWJtIikpIHsNCj4gPiArCQkJcHJpbnRmKCJvayBNQk0gIyBTS0lQ
IEhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQNCj4gTUJNIG9yIE1CTSBpcyBkaXNhYmxlZFxuIik7
DQo+ID4gKwkJCWdvdG8gdGVzdF9tYmE7DQo+ID4gKwkJfQ0KPiA+ICAJCWlmICghaGFzX2JlbikN
Cj4gPiAgCQkJc3ByaW50ZihiZW5jaG1hcmtfY21kWzVdLCAiJXMiLCAibWJhIik7DQo+ID4gIAkJ
cmVzID0gbWJtX2J3X2NoYW5nZShzcGFuLCBjcHVfbm8sIGJ3X3JlcG9ydCwNCj4gYmVuY2htYXJr
X2NtZCk7IEBADQo+ID4gLTE3OCw4ICsxODIsMTMgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KQ0KPiA+ICAJCXRlc3RzX3J1bisrOw0KPiA+ICAJfQ0KPiA+DQo+ID4gK3Rlc3RfbWJh
Og0KPiANCj4gSSB0aGluayB0aGlzIHBhcnRpY3VsYXIgdXNhZ2Ugb2YgZ290byBjb3VsZCBtYWtl
IHRoZSBmbG93IG9mIHRoZSBjb2RlIGhhcmRlciB0bw0KPiB0cmFjZS4gQ291bGQgdGhlIHRlc3Rz
IHBlcmhhcHMgYmUgbW92ZWQgdG8gZnVuY3Rpb25zIHRvIGF2b2lkIG5lZWRpbmcgdG8ganVtcA0K
PiBsaWtlIHRoaXM/IFBlcmhhcHMgdGhlcmUgY291bGQgYmUgYSBuZXcgZnVuY3Rpb24gcGVyIHRl
c3QsIGxpa2UgcnVuX21ibV90ZXN0KCksDQo+IHJ1bl9tYmFfdGVzdCgpLCBldGMuIHdpdGggZWFj
aCB0ZXN0IGNhbGxlZCB3aGVuIHJlcXVlc3RlZCBieSB1c2VyIGFuZCB3aXRoIHRoZQ0KPiB0ZXN0
IGV4aXRpbmcgY2xlYW5seSBpZiBmZWF0dXJlIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGhhcmR3
YXJlLg0KDQpNYWtlcyBzZW5zZS4gSSB3aWxsIGNoYW5nZSBpdCBhcyBzdWdnZXN0ZWQuDQoNClJl
Z2FyZHMsDQpTYWkNCg==
