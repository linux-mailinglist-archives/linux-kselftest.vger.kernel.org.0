Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E598317EBF0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 23:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCIWXA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 18:23:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:12620 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCIWXA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 18:23:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 15:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="321577304"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2020 15:22:59 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.192]) with mapi id 14.03.0439.000;
 Mon, 9 Mar 2020 15:22:57 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 01/13] selftests/resctrl: Fix feature detection
Thread-Topic: [PATCH V1 01/13] selftests/resctrl: Fix feature detection
Thread-Index: AQHV9DL72y2lBowYF0OswuZ3RsHuuahBROGA//+RIaA=
Date:   Mon, 9 Mar 2020 22:22:56 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F57307F89@ORSMSX114.amr.corp.intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <7e3e4b91f5786a489e68eecda21e1d8049b60181.1583657204.git.sai.praneeth.prakhya@intel.com>
 <a7407b0d-4e4d-d0cf-621c-769d218fdace@intel.com>
In-Reply-To: <a7407b0d-4e4d-d0cf-621c-769d218fdace@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmVp
bmV0dGUgQ2hhdHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXks
IE1hcmNoIDksIDIwMjAgMjo0NSBQTQ0KPiBUbzogUHJha2h5YSwgU2FpIFByYW5lZXRoIDxzYWku
cHJhbmVldGgucHJha2h5YUBpbnRlbC5jb20+Ow0KPiBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1r
c2VsZnRlc3RAdmdlci5rZXJuZWwub3JnDQo+IENjOiB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdv
QHJlZGhhdC5jb207IGJwQGFsaWVuOC5kZTsgTHVjaywgVG9ueQ0KPiA8dG9ueS5sdWNrQGludGVs
LmNvbT47IGJhYnUubW9nZXJAYW1kLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsNCj4gU2hhbmth
ciwgUmF2aSBWIDxyYXZpLnYuc2hhbmthckBpbnRlbC5jb20+OyBZdSwgRmVuZ2h1YQ0KPiA8ZmVu
Z2h1YS55dUBpbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxIDAxLzEzXSBzZWxmdGVzdHMvcmVzY3Ry
bDogRml4IGZlYXR1cmUgZGV0ZWN0aW9uDQo+IA0KPiBIaSBTYWksDQo+IA0KPiBPbiAzLzYvMjAy
MCA3OjQwIFBNLCBTYWkgUHJhbmVldGggUHJha2h5YSB3cm90ZToNCj4gPiBGcm9tOiBSZWluZXR0
ZSBDaGF0cmUgPHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+DQo+ID4NCj4gPiBUaGUgaW50ZW50
aW9uIG9mIHRoZSByZXNjdHJsIHNlbGZ0ZXN0cyBpcyB0byBvbmx5IHJ1biB0aGUgdGVzdHMNCj4g
PiBhc3NvY2lhdGVkIHdpdGggdGhlIGZlYXR1cmUocykgc3VwcG9ydGVkIGJ5IHRoZSBwbGF0Zm9y
bS4gVGhyb3VnaA0KPiA+IHBhcnNpbmcgb2YgdGhlIGZlYXR1cmUgZmxhZ3MgZm91bmQgaW4gL3By
b2MvY3B1aW5mbyBpdCBpcyBwb3NzaWJsZSB0bw0KPiA+IGxlYXJuIHdoaWNoIGZlYXR1cmVzIGFy
ZSBzdXBwb3J0ZWQgYnkgdGhlIHBsYWZvcm0uDQo+ID4NCj4gPiBUaGVyZSBhcmUgY3VycmVudGx5
IHR3byBpc3N1ZXMgd2l0aCB0aGUgcGxhdGZvcm0gZmVhdHVyZSBkZXRlY3Rpb24NCj4gPiB0aGF0
IHRvZ2V0aGVyIHJlc3VsdCBpbiB0ZXN0cyBhbHdheXMgYmVpbmcgcnVuLCB3aGV0aGVyIHRoZSBw
bGF0Zm9ybQ0KPiA+IHN1cHBvcnRzIGEgZmVhdHVyZSBvciBub3QuIEZpcnN0LCB0aGUgcGFyc2lu
ZyBvZiB0aGUgdGhlIGZlYXR1cmUgZmxhZ3MNCj4gPiBsb2FkcyB0aGUgbGluZSBjb250YWluaW5n
IHRoZSBmbGFncyBpbiBhIGJ1ZmZlciB0aGF0IGlzIHRvbyBzbWFsbCAoMjU2DQo+ID4gYnl0ZXMp
IHRvIGFsd2F5cyBjb250YWluIGFsbCBmbGFncy4gVGhlIGNvbnNlcXVlbmNlIGlzIHRoYXQgdGhl
IGZsYWdzDQo+ID4gb2YgdGhlIGZlYXR1cmVzIGJlaW5nIHRlc3RlZCBmb3IgbWF5IG5vdCBiZSBw
cmVzZW50IGluIHRoZSBidWZmZXIuDQo+ID4gU2Vjb25kLCB0aGUgYWN0dWFsIHRlc3QgZm9yIHBy
ZXNlbmNlIG9mIGEgZmVhdHVyZSBoYXMgYW4gZXJyb3IgaW4gdGhlDQo+ID4gbG9naWMsIG5lZ2F0
aW5nIHRoZSB0ZXN0IGZvciBhIHBhcnRpY3VsYXIgZmVhdHVyZSBmbGFnIGluc3RlYWQgb2YNCj4g
PiB0ZXN0aW5nIGZvciB0aGUgcHJlc2VuY2Ugb2YgYSBwYXJ0aWN1bGFyIGZlYXR1cmUgZmxhZy4N
Cj4gPg0KPiA+IFRoZXNlIHR3byBpc3N1ZXMgY29tYmluZWQgcmVzdWx0cyBpbiBhbGwgdGVzdHMg
YmVpbmcgcnVuIG9uIGFsbA0KPiA+IHBsYXRmb3Jtcywgd2hldGhlciB0aGUgZmVhdHVyZSBpcyBz
dXBwb3J0ZWQgb3Igbm90Lg0KPiA+DQo+ID4gRml4IHRoZXNlIGlzc3VlIGJ5ICgxKSBpbmNyZWFz
aW5nIHRoZSBidWZmZXIgc2l6ZSBiZWluZyB1c2VkIHRvIHBhcnNlDQo+ID4gdGhlIGZlYXR1cmUg
ZmxhZ3MsIGFuZCAoMikgY2hhbmdlIHRoZSBsb2dpYyB0byB0ZXN0IGZvciBwcmVzZW5jZSBvZg0K
PiA+IHRoZSBmZWF0dXJlIGJlaW5nIHRlc3RlZCBmb3IuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSZWluZXR0ZSBDaGF0cmUgPHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogU2FpIFByYW5lZXRoIFByYWtoeWEgPHNhaS5wcmFuZWV0aC5wcmFraHlhQGludGVs
LmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNj
dHJsZnMuYyB8IDYgKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvcmVzY3RybC9yZXNjdHJsZnMuYw0KPiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
cmVzY3RybC9yZXNjdHJsZnMuYw0KPiA+IGluZGV4IDE5YzBlYzQwNDVhNC4uMjI2ZGQ3ZmRjZmIx
IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3Ry
bGZzLmMNCj4gPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxm
cy5jDQo+ID4gQEAgLTU5NiwxMSArNTk2LDExIEBAIGJvb2wgY2hlY2tfcmVzY3RybGZzX3N1cHBv
cnQodm9pZCkNCj4gPg0KPiA+ICBjaGFyICpmZ3JlcChGSUxFICppbmYsIGNvbnN0IGNoYXIgKnN0
cikgIHsNCj4gPiAtCWNoYXIgbGluZVsyNTZdOw0KPiA+ICAJaW50IHNsZW4gPSBzdHJsZW4oc3Ry
KTsNCj4gPiArCWNoYXIgbGluZVsyMDQ4XTsNCj4gPg0KPiA+ICAJd2hpbGUgKCFmZW9mKGluZikp
IHsNCj4gPiAtCQlpZiAoIWZnZXRzKGxpbmUsIDI1NiwgaW5mKSkNCj4gPiArCQlpZiAoIWZnZXRz
KGxpbmUsIDIwNDgsIGluZikpDQo+ID4gIAkJCWJyZWFrOw0KPiA+ICAJCWlmIChzdHJuY21wKGxp
bmUsIHN0ciwgc2xlbikpDQo+ID4gIAkJCWNvbnRpbnVlOw0KPiA+IEBAIC02MzEsNyArNjMxLDcg
QEAgYm9vbCB2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdChjaGFyDQo+ICpyZXNjdHJs
X3ZhbCkNCj4gPiAgCWlmIChyZXMpIHsNCj4gPiAgCQljaGFyICpzID0gc3RyY2hyKHJlcywgJzon
KTsNCj4gPg0KPiA+IC0JCWZvdW5kID0gcyAmJiAhc3Ryc3RyKHMsIHJlc2N0cmxfdmFsKTsNCj4g
PiArCQlmb3VuZCA9IHMgJiYgc3Ryc3RyKHMsIHJlc2N0cmxfdmFsKTsNCj4gPiAgCQlmcmVlKHJl
cyk7DQo+ID4gIAl9DQo+ID4gIAlmY2xvc2UoaW5mKTsNCj4gPg0KPiANCj4gUGxlYXNlIG5vdGUg
dGhhdCB0aGlzIGlzIG9ubHkgYSBwYXJ0aWFsIGZpeC4gVGhlIGN1cnJlbnQgZmVhdHVyZSBkZXRl
Y3Rpb24gcmVsaWVzIG9uDQo+IHRoZSBmZWF0dXJlIGZsYWdzIGZvdW5kIGluIC9wcm9jL2NwdWlu
Zm8uIFF1aXJrcyBhbmQga2VybmVsIGJvb3QgcGFyYW1ldGVycyBhcmUNCj4gbm90IHRha2VuIGlu
dG8gYWNjb3VudC4gVGhpcyBmaXggb25seSBhZGRyZXNzZXMgdGhlIHBhcnNpbmcgb2YgZmVhdHVy
ZSBmbGFncy4gSWYgYQ0KPiBmZWF0dXJlIGhhcyBiZWVuIGRpc2FibGVkIHZpYSBrZXJuZWwgYm9v
dCBwYXJhbWV0ZXIgb3IgcXVpcmsgdGhlbiB0aGUgcmVzY3RybA0KPiB0ZXN0cyB3b3VsZCBzdGls
bCBhdHRlbXB0IHRvIHJ1biB0aGUgdGVzdCBmb3IgaXQuDQoNClRoYXQncyBhIGdvb2QgcG9pbnQg
YW5kIG1ha2VzIHNlbnNlIHRvIG1lLiBJIHRoaW5rIHdlIGNvdWxkIGZpeCBpdCBpbiB0d28gd2F5
cw0KMS4gZ3JlcCBmb3Igc3RyaW5ncyBpbiBkbWVzZyBidXQgdGhhdCB3aWxsIHN0aWxsIGxlYXZl
IGFtYmlndWl0eSBpbiBkZWNpZGluZyBiL3cgbWJtIGFuZCBjcW0gYmVjYXVzZSBrZXJuZWwgcHJp
bnRzICJyZXNjdHJsOiBMMyBtb25pdG9yaW5nIGRldGVjdGVkIiBmb3IgYm90aCB0aGUgZmVhdHVy
ZXMNCjIuIENoZWNrIGluICJpbmZvIiBkaXJlY3RvcnkNCglhLiBGb3IgY2F0X2wzLCB3ZSBjb3Vs
ZCBzZWFyY2ggZm9yIGluZm8vTDMNCgliLiBGb3IgbWJhLCB3ZSBjb3VsZCBzZWFyY2ggZm9yIGlu
Zm8vTUINCgljLiBGb3IgY3FtIGFuZCBtYm0sIHdlIGNvdWxkIHNlYXJjaCBmb3Igc3BlY2lmaWVk
IHN0cmluZyBpbiBpbmZvL0wzX01PTi9tb25fZmVhdHVyZXMNCg0KSSB0aGluayBvcHRpb24gMiBt
aWdodCBiZSBiZXR0ZXIgYmVjYXVzZSBpdCBjYW4gaGFuZGxlIGFsbCBjYXNlcywgcGxlYXNlIGxl
dCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLg0KDQpSZWdhcmRzLA0KU2FpDQo=
