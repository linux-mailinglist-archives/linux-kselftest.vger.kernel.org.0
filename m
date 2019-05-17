Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F314213F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2019 09:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfEQHC0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 May 2019 03:02:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:27653 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfEQHC0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 May 2019 03:02:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 00:02:24 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2019 00:02:24 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 17 May 2019 00:02:16 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 17 May 2019 00:02:16 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.249]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.213]) with mapi id 14.03.0415.000;
 Fri, 17 May 2019 15:02:14 +0800
From:   "Tong, Bo" <bo.tong@intel.com>
To:     shuah <shuah@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Subject: RE: [PATCH v3] selftests/x86: Support Atom for syscall_arg_fault
 test
Thread-Topic: [PATCH v3] selftests/x86: Support Atom for syscall_arg_fault
 test
Thread-Index: AQHU9n69DeeDO5l0dUWiD93e9LhDvqZC/omAgCwP6PA=
Date:   Fri, 17 May 2019 07:02:14 +0000
Message-ID: <D6542591582C6645851595B3517A02963F16F195@shsmsx102.ccr.corp.intel.com>
References: <1555657855-31855-1-git-send-email-bo.tong@intel.com>
 <263afb6f-48dc-fbe7-5b13-13ce3f322ecc@kernel.org>
In-Reply-To: <263afb6f-48dc-fbe7-5b13-13ce3f322ecc@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWJkMzcwYjUtN2E0NS00MGQ1LWI0NTEtM2RiYTUwMGY4MGZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWFAwOGE3Nkp2MTVGTElvSVpFcXR4NXZmaXM1S0NCK3c0OGgyckFrdWFwZ3RGQW84YzBva1c4SWJKMlpXUlZ3SCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SXMgdGhpcyBwYXRjaCBnb2luZyB0byBiZSBtZXJnZWQ/IE9yIHN0aWxsIGFueSBibG9ja2luZyBp
c3N1ZSB0aGVyZT8NCg0KVGhhbmtzLA0KQm8NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IHNodWFoIFttYWlsdG86c2h1YWhAa2VybmVsLm9yZ10gDQpTZW50OiBGcmlkYXksIEFw
cmlsIDE5LCAyMDE5IDEwOjA1IFBNDQpUbzogVG9uZywgQm8gPGJvLnRvbmdAaW50ZWwuY29tPjsg
bHV0b0BrZXJuZWwub3JnOyB4ODZAa2VybmVsLm9yZw0KQ2M6IGxpbnV4LWtzZWxmdGVzdEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHNraGFuQGxpbnV4Zm91
bmRhdGlvbi5vcmc7IHNodWFoQGtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIHNl
bGZ0ZXN0cy94ODY6IFN1cHBvcnQgQXRvbSBmb3Igc3lzY2FsbF9hcmdfZmF1bHQgdGVzdA0KDQpP
biA0LzE5LzE5IDE6MTAgQU0sIFRvbmcgQm8gd3JvdGU6DQo+IEF0b20tYmFzZWQgQ1BVcyB0cmln
Z2VyIHN0YWNrIGZhdWx0IHdoZW4gaW52b2tlIDMyLWJpdCBTWVNFTlRFUiANCj4gaW5zdHJ1Y3Rp
b24gd2l0aCBpbnZhbGlkIHJlZ2lzdGVyIHZhbHVlcy4gU28gd2UgYWxzbyBuZWVkIFNJR0JVUyBo
YW5kbGluZyBpbiB0aGlzIGNhc2UuDQo+IA0KPiBGb2xsb3dpbmcgaXMgYXNzZW1ibHkgd2hlbiB0
aGUgZmF1bHQgZXhjZXB0aW9uIGhhcHBlbnMuDQo+IA0KPiAoZ2RiKSBkaXNhc3NlbWJsZSAkZWlw
DQo+IER1bXAgb2YgYXNzZW1ibGVyIGNvZGUgZm9yIGZ1bmN0aW9uIF9fa2VybmVsX3ZzeXNjYWxs
Og0KPiAgICAgMHhmN2ZkOGZlMCA8KzA+OiAgICAgcHVzaCAgICVlY3gNCj4gICAgIDB4ZjdmZDhm
ZTEgPCsxPjogICAgIHB1c2ggICAlZWR4DQo+ICAgICAweGY3ZmQ4ZmUyIDwrMj46ICAgICBwdXNo
ICAgJWVicA0KPiAgICAgMHhmN2ZkOGZlMyA8KzM+OiAgICAgbW92ICAgICVlc3AsJWVicA0KPiAg
ICAgMHhmN2ZkOGZlNSA8KzU+OiAgICAgc3lzZW50ZXINCj4gICAgIDB4ZjdmZDhmZTcgPCs3Pjog
ICAgIGludCAgICAkMHg4MA0KPiA9PiAweGY3ZmQ4ZmU5IDwrOT46ICAgICBwb3AgICAgJWVicA0K
PiAgICAgMHhmN2ZkOGZlYSA8KzEwPjogICAgcG9wICAgICVlZHgNCj4gICAgIDB4ZjdmZDhmZWIg
PCsxMT46ICAgIHBvcCAgICAlZWN4DQo+ICAgICAweGY3ZmQ4ZmVjIDwrMTI+OiAgICByZXQNCj4g
RW5kIG9mIGFzc2VtYmxlciBkdW1wLg0KPiANCj4gQWNjb3JkaW5nIHRvIEludGVsIFNETSwgdGhp
cyBjb3VsZCBhbHNvIGJlIGEgU3RhY2sgU2VnbWVudCBGYXVsdCgjU1MsIA0KPiAxMiksIGV4Y2Vw
dCBhIG5vcm1hbCBQYWdlIEZhdWx0KCNQRiwgMTQpLiBFc3BlY2lhbGx5LCBpbiBzZWN0aW9uIDYu
OSANCj4gb2YgVm9sLjNBLCBib3RoIHN0YWNrIGFuZCBwYWdlIGZhdWx0cyBhcmUgd2l0aGluIHRo
ZSAxMHRoKGxvd2VzdCANCj4gcHJpb3JpdHkpIGNsYXNzLCBhbmQgYXMgaXQgc2FpZCwgImV4Y2Vw
dGlvbnMgd2l0aGluIGVhY2ggY2xhc3MgYXJlIA0KPiBpbXBsZW1lbnRhdGlvbi1kZXBlbmRlbnQg
YW5kIG1heSB2YXJ5IGZyb20gcHJvY2Vzc29yIHRvIHByb2Nlc3NvciIuIA0KPiBJdCdzIGV4cGVj
dGVkIGZvciBwcm9jZXNzb3JzIGxpa2UgSW50ZWwgQXRvbSB0byB0cmlnZ2VyIHN0YWNrIA0KPiBm
YXVsdChTSUdCVVMpLCB3aGlsZSB3ZSBnZXQgcGFnZSBmYXVsdChTSUdTRUdWKSBmcm9tIGNvbW1v
biBDb3JlIHByb2Nlc3NvcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUb25nIEJvIDxiby50b25n
QGludGVsLmNvbT4NCj4gQWNrZWQtYnk6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3Jn
Pg0KPiAtLS0NCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvc3lzY2FsbF9hcmdfZmF1
bHQuYyB8IDEwICsrKysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3g4Ni9zeXNjYWxsX2FyZ19mYXVsdC5jIA0KPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3g4Ni9zeXNjYWxsX2FyZ19mYXVsdC5jDQo+IGluZGV4IDdkYjRmYzkuLmQyNTQ4NDAxIDEwMDY0
NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvc3lzY2FsbF9hcmdfZmF1bHQu
Yw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvc3lzY2FsbF9hcmdfZmF1bHQu
Yw0KPiBAQCAtNDMsNyArNDMsNyBAQCBzdGF0aWMgc2lnam1wX2J1ZiBqbXBidWY7DQo+ICAgDQo+
ICAgc3RhdGljIHZvbGF0aWxlIHNpZ19hdG9taWNfdCBuX2VycnM7DQo+ICAgDQo+IC1zdGF0aWMg
dm9pZCBzaWdzZWd2KGludCBzaWcsIHNpZ2luZm9fdCAqaW5mbywgdm9pZCAqY3R4X3ZvaWQpDQo+
ICtzdGF0aWMgdm9pZCBzaWdzZWd2X29yX3NpZ2J1cyhpbnQgc2lnLCBzaWdpbmZvX3QgKmluZm8s
IHZvaWQgDQo+ICsqY3R4X3ZvaWQpDQo+ICAgew0KPiAgIAl1Y29udGV4dF90ICpjdHggPSAodWNv
bnRleHRfdCopY3R4X3ZvaWQ7DQo+ICAgDQo+IEBAIC03Myw3ICs3MywxMyBAQCBpbnQgbWFpbigp
DQo+ICAgCWlmIChzaWdhbHRzdGFjaygmc3RhY2ssIE5VTEwpICE9IDApDQo+ICAgCQllcnIoMSwg
InNpZ2FsdHN0YWNrIik7DQo+ICAgDQo+IC0Jc2V0aGFuZGxlcihTSUdTRUdWLCBzaWdzZWd2LCBT
QV9PTlNUQUNLKTsNCj4gKwlzZXRoYW5kbGVyKFNJR1NFR1YsIHNpZ3NlZ3Zfb3Jfc2lnYnVzLCBT
QV9PTlNUQUNLKTsNCj4gKwkvKg0KPiArCSAqIFRoZSBhY3R1YWwgZXhjZXB0aW9uIGNhbiB2YXJ5
LiAgT24gQXRvbSBDUFVzLCB3ZSBnZXQgI1NTDQo+ICsJICogaW5zdGVhZCBvZiAjUEYgd2hlbiB0
aGUgdkRTTyBmYWlscyB0byBhY2Nlc3MgdGhlIHN0YWNrIHdoZW4NCj4gKwkgKiBFU1AgaXMgdG9v
IGNsb3NlIHRvIDJeMzIsIGFuZCAjU1MgY2F1c2VzIFNJR0JVUy4NCj4gKwkgKi8NCj4gKwlzZXRo
YW5kbGVyKFNJR0JVUywgc2lnc2Vndl9vcl9zaWdidXMsIFNBX09OU1RBQ0spOw0KPiAgIAlzZXRo
YW5kbGVyKFNJR0lMTCwgc2lnaWxsLCBTQV9PTlNUQUNLKTsNCj4gICANCj4gICAJLyoNCj4gDQoN
CkluIGNhc2UgdGhlcmUgaXMgYSBkZXBlbmRlbmN5IG9uIHg4NiB0cmVlLCBoZXJlIGlzIG15IEFj
aw0KDQpBY2tlZC1ieTogU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4NCg0K
dGhhbmtzLA0KLS0gU2h1YWgNCg==
