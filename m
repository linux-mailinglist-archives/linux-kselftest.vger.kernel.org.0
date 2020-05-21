Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A661DD423
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgEURTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 13:19:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:13738 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgEURTf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 13:19:35 -0400
IronPort-SDR: Mj/9EtonnRHwH0oMnPwookBNjMrVlUzwtV6ac5Di1blVQ7vzgx27cyT7q2xSuoDdrz0ibUVUe8
 CgtA9uv1cXZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 10:19:35 -0700
IronPort-SDR: U9E/r+k/w0vkMUvf/3OWb0jl6X3Rsjpyho09Wd1JJMK1QHtng2j7fDqrbSKh5CSb9CVZ0rD6xu
 L4IwrWOL6vnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="265124329"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga003.jf.intel.com with ESMTP; 21 May 2020 10:19:34 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 21 May 2020 10:19:34 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.205]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.214]) with mapi id 14.03.0439.000;
 Thu, 21 May 2020 10:19:33 -0700
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
Subject: RE: [PATCH V2 15/19] selftests/resctrl: Change return type of
 umount_resctrlfs() to void
Thread-Topic: [PATCH V2 15/19] selftests/resctrl: Change return type of
 umount_resctrlfs() to void
Thread-Index: AQHWLWGmDu9yXudY90uSf8mjAaN10KiyHf0AgACtPWA=
Date:   Thu, 21 May 2020 17:19:33 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F573B66AE@ORSMSX114.amr.corp.intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
 <3c00e744acbfa67a1988638f1718cd67382a6f59.1589835155.git.sai.praneeth.prakhya@intel.com>
 <5703181d-832b-27c1-4b32-241f5cc868fd@intel.com>
In-Reply-To: <5703181d-832b-27c1-4b32-241f5cc868fd@intel.com>
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
YXksIE1heSAyMCwgMjAyMCA0OjUyIFBNDQo+IFRvOiBQcmFraHlhLCBTYWkgUHJhbmVldGggPHNh
aS5wcmFuZWV0aC5wcmFraHlhQGludGVsLmNvbT47DQo+IHNodWFoQGtlcm5lbC5vcmc7IHNraGFu
QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlOyBM
dWNrLCBUb255DQo+IDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgYmFidS5tb2dlckBhbWQuY29tOyBq
YW1lcy5tb3JzZUBhcm0uY29tOw0KPiBTaGFua2FyLCBSYXZpIFYgPHJhdmkudi5zaGFua2FyQGlu
dGVsLmNvbT47IFl1LCBGZW5naHVhDQo+IDxmZW5naHVhLnl1QGludGVsLmNvbT47IHg4NkBrZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWw7DQo+IGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbTsgZGNiMzE0QGhvdG1haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMTUvMTld
IHNlbGZ0ZXN0cy9yZXNjdHJsOiBDaGFuZ2UgcmV0dXJuIHR5cGUgb2YNCj4gdW1vdW50X3Jlc2N0
cmxmcygpIHRvIHZvaWQNCj4gDQo+IEhpIFNhaSwNCj4gDQo+IE9uIDUvMTgvMjAyMCAzOjA4IFBN
LCBTYWkgUHJhbmVldGggUHJha2h5YSB3cm90ZToNCj4gPiB1bW91bnRfcmVzY3RybGZzKCkgaXMg
dXNlZCBvbmx5IGR1cmluZyB0ZWFyIGRvd24gcGF0aCBhbmQgdGhlcmUgaXMNCj4gPiBub3RoaW5n
IG11Y2ggdG8gZG8gaWYgdW5tb3VudCBvZiByZXNjdHJsIGZpbGUgc3lzdGVtIGZhaWxzLCBzbywg
YWxsDQo+ID4gdGhlIGNhbGxlcnMgb2YgdGhpcyBmdW5jdGlvbiBhcmUgbm90IGNoZWNraW5nIGZv
ciB0aGUgcmV0dXJuIHZhbHVlLg0KPiA+IEhlbmNlLCBjaGFuZ2UgdGhlIHJldHVybiB0eXBlIG9m
IHRoaXMgZnVuY3Rpb24gZnJvbSBpbnQgdG8gdm9pZC4NCj4gDQo+IFNob3VsZCB0aGUgY2FsbGVy
cyBiZSBpZ25vcmluZyB0aGUgcmV0dXJuIHZhbHVlPyBGcm9tIHdoYXQgSSBjYW4gdGVsbCB0aGUN
Cj4gZmlsZXN5c3RlbSBpcyB1bm1vdW50ZWQgYmV0d2VlbiB0ZXN0IHJ1bnMgc28gSSB3b25kZXIg
aWYgaXQgbWF5IGhlbHAgaWYgdGhlDQo+IHJldHVybiBjb2RlIGlzIHVzZWQgYW5kIHRoZSB0ZXN0
IGV4aXRzIHdpdGggYW4gYXBwcm9wcmlhdGUgZXJyb3IgdG8gdXNlciBzcGFjZSBmb3INCj4gcG9z
c2libGUgaW52ZXN0aWdhdGlvbiBpbnN0ZWFkIG9mIGF0dGVtcHRpbmcgdG8gcnVuIGEgbmV3IHRl
c3Qgb24gdG9wIG9mIHRoZQ0KPiByZXNjdHJsIGZpbGVzeXN0ZW0gdGhhdCBjb3VsZCBwb3RlbnRp
YWxseSBiZSBoYXZpbmcgaXNzdWVzIGF0IHRoZSB0aW1lLg0KDQpNYWtlcyBzZW5zZSB0byBtZSB0
byBjaGVjayBmb3IgdGhlIHJldHVybiB2YWx1ZSBvZiB1bW91bnQoKSBhbmQgdGFrZSBhcHByb3By
aWF0ZQ0KYWN0aW9uIHJhdGhlciB0aGFuIGlnbm9yaW5nIGl0LiBCdXQsIHNpbmNlIHRoaXMgbWln
aHQgaGFwcGVuIHZlcnkgcmFyZWx5IChJIGhhdmVuJ3QNCm5vdGljZWQgdW1vdW50KCkgZmFpbGlu
ZyB0aWxsIG5vdyksIEkgYW0gdGhpbmtpbmcgdG8gcXVldWUgdGhpcyB1cCBmb3IgY2xlYW51cCBz
ZXJpZXMuDQpXaGF0IGRvIHlvdSB0aGluaz8NCg0KVGhpcyBidWcgZml4ZXMgc2VyaWVzIHdpbGwg
dGhlbiBoYXZlIHBhdGNoZXMgMTYgYW5kIDE3IGJlY2F1c2UgdGhleSBhcmUgZml4aW5nIGEgYnVn
DQp0aGF0IGNvdWxkIGJlIGVhc2lseSBub3RpY2VkLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91
IHRoaW5rIG90aGVyd2lzZS4NCg0KUmVnYXJkcywNClNhaQ0K
