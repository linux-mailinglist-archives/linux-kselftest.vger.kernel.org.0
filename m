Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DBD45F76C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Nov 2021 01:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhK0AXj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 19:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbhK0AVj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 19:21:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17494C061746;
        Fri, 26 Nov 2021 16:18:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 574E9623AC;
        Sat, 27 Nov 2021 00:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BCEC004E1;
        Sat, 27 Nov 2021 00:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637972304;
        bh=EXVgZlL8UNuXBRbqLRLRQjKc/IDQaaDO3W8HG5hO5kQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pyOIZXKnkwPycdhzFMh5GerD/YXseLXI0O3dnHaJnx/I+UKhB+1wWCOYnDGNkTZpO
         2DAB+iEQW8GItA9QzdIihRuHEetcmp4E25m795nE9fCAv5vTovzQV2GikvLP8ERGHM
         Fhx7AA3rSlFwxWDgy94hk6cYFlhgB6GY1LnPPqf4rkbA2Egjo3ReqDXhkq3LkLY4P2
         9PkrZ50/ccJpLjR6uVBNu5/ZDKuczUtVPp0NEJ5HmHW2oiNaNW6S67R3op0sjQftPR
         bjCkGjCT98nBwxz3pKYx2i6IEH191jwp5lCLeT0Jdwl2oEepqTig+rGirsqMKF1gkD
         FCeuDYisK/RTQ==
Message-ID: <f5d6e6b189b46c53264bdb649e6a41589d8259bf.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] selftests: tpm2: Probe for available PCR bank
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Date:   Sat, 27 Nov 2021 02:18:21 +0200
In-Reply-To: <1189a2ef-ae31-92f2-a7a7-d60064bdde44@linux.ibm.com>
References: <20211124141314.1356338-1-stefanb@linux.ibm.com>
         <20211124141314.1356338-2-stefanb@linux.ibm.com> <YZ7QwlZ77b4A/ZbR@iki.fi>
         <1189a2ef-ae31-92f2-a7a7-d60064bdde44@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gV2VkLCAyMDIxLTExLTI0IGF0IDE5OjE1IC0wNTAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+
IAo+IE9uIDExLzI0LzIxIDE4OjU0LCBKYXJra28gU2Fra2luZW4gd3JvdGU6Cj4gPiBPbiBXZWQs
IE5vdiAyNCwgMjAyMSBhdCAwOToxMzoxMkFNIC0wNTAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+
ID4gPiBQcm9iZSBmb3IgYW4gYXZhaWxhYmxlIFBDUiBiYW5rIHRvIGFjY29tbW9kYXRlIGRldmlj
ZXMgdGhhdCBkbyBub3QgaGF2ZSBhCj4gPiA+IFNIQS0xIFBDUiBiYW5rIG9yIHdob3NlIFNIQS0x
IGJhbmsgaXMgZGVhY3RpdmF0ZWQuIFVzZSB0aGUgYmFuayB0aGF0IGNhbgo+ID4gPiBiZSB1c2Vk
IGluIHRoZSBUUE0yIGNvbW1hbmRzLiBBc3NlcnQgb24gdGhlIHByb2JpbmcgZnVuY3Rpb24gdG8g
bm90Cj4gPiA+IHJldHVybiBOb25lLgo+ID4gV2hhdCBpcyAqdGhlIGJhbmsqIHRoYXQgY2FuIGJl
IHVzZWQ/Cj4gCj4gVGhlIGJhbmsgY2FuIGJlIGVpdGhlciBTSEEtMSBvciBTSEEtMjU2IGF0IHRo
aXMgcG9pbnQuCj4gCj4gPiAKPiA+IEluIGFkZGl0aW9uLCBJIGRvbid0IHVuZGVyc3RhbmQgdGhl
IGxhc3Qgc2VudGVuY2UuCj4gCj4gCj4gSWYgdGhlIHByb2JpbmcgZnVuY3Rpb24gcmV0dXJucyBO
b25lIHRoZSB0ZXN0IGZhaWxzIGR1ZSB0byBhbiAKPiBhc3NlcnRJc05vdE5vbmUoKS4KCllvdSBz
aG91bGQgaGF2ZSBhbGwgdGhpcyB3cml0dGVuIGRvd24gdG8gdGhlIGNvbW1pdCBtZXNzYWdlLgoK
L0phcmtrbwoKPiAKPiDCoMKgwqAgc3RlZmFuCj4gCj4gPiAKPiA+IC9KYXJra28KPiA+IAo+ID4g
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGludXguaWJtLmNv
bT4KPiA+ID4gLS0tCj4gPiA+IMKgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RwbTIvdHBtMl90
ZXN0cy5weSB8IDM1ICsrKysrKysrKysrKysrKysrLS0tLS0KPiA+ID4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDI3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4gPiA+IAo+ID4gPiBkaWZmIC0t
Z2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdHBtMi90cG0yX3Rlc3RzLnB5IGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvdHBtMi90cG0yX3Rlc3RzLnB5Cj4gPiA+IGluZGV4IDlkNzY0MzA2
ODg3Yi4uNmI4OGZmMGU0N2I5IDEwMDY0NAo+ID4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy90cG0yL3RwbTJfdGVzdHMucHkKPiA+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdHBtMi90cG0yX3Rlc3RzLnB5Cj4gPiA+IEBAIC0yNyw3ICsyNywyMyBAQCBjbGFzcyBTbW9r
ZVRlc3QodW5pdHRlc3QuVGVzdENhc2UpOgo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzdWx0
ID0gc2VsZi5jbGllbnQudW5zZWFsKHNlbGYucm9vdF9rZXksIGJsb2IsIGF1dGgsIE5vbmUpCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmFzc2VydEVxdWFsKGRhdGEsIHJlc3VsdCkKPiA+
ID4gwqAgCj4gPiA+ICvCoMKgwqAgZGVmIGRldGVybWluZV9iYW5rX2FsZyhzZWxmKToKPiA+ID4g
K8KgwqDCoMKgwqDCoMKgICMgUHJvYmUgZm9yIGF2YWlsYWJsZSBQQ1IgYmFuawo+ID4gPiArwqDC
oMKgwqDCoMKgwqAgZm9yIGJhbmtfYWxnIGluIFt0cG0yLlRQTTJfQUxHX1NIQTEsIHRwbTIuVFBN
Ml9BTEdfU0hBMjU2XToKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJ5Ogo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhhbmRsZSA9IHNlbGYuY2xpZW50LnN0YXJ0
X2F1dGhfc2Vzc2lvbih0cG0yLlRQTTJfU0VfVFJJQUwpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc2VsZi5jbGllbnQucG9saWN5X3BjcihoYW5kbGUsIFsxN10sIGJhbmtf
YWxnPWJhbmtfYWxnKQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBiYW5rX2FsZwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleGNlcHQgdHBtMi5Vbmtu
b3duUENSQmFua0Vycm9yOgo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBh
c3MKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmluYWxseToKPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmNsaWVudC5mbHVzaF9jb250ZXh0KGhhbmRsZSkK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOb25lCj4gPiA+ICsKPiA+ID4gwqDCoMKgwqDC
oCBkZWYgdGVzdF9zZWFsX3dpdGhfcG9saWN5KHNlbGYpOgo+ID4gPiArwqDCoMKgwqDCoMKgwqAg
YmFua19hbGcgPSBzZWxmLmRldGVybWluZV9iYW5rX2FsZygpCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oCBzZWxmLmFzc2VydElzTm90Tm9uZShiYW5rX2FsZykKPiA+ID4gKwo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqAgaGFuZGxlID0gc2VsZi5jbGllbnQuc3RhcnRfYXV0aF9zZXNzaW9uKHRwbTIuVFBN
Ml9TRV9UUklBTCkKPiA+ID4gwqAgCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhID0gKCdY
JyAqIDY0KS5lbmNvZGUoKQo+ID4gPiBAQCAtMzUsNyArNTEsNyBAQCBjbGFzcyBTbW9rZVRlc3Qo
dW5pdHRlc3QuVGVzdENhc2UpOgo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgcGNycyA9IFsxNl0K
PiA+ID4gwqAgCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCB0cnk6Cj4gPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNlbGYuY2xpZW50LnBvbGljeV9wY3IoaGFuZGxlLCBwY3JzKQo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmNsaWVudC5wb2xpY3lfcGNyKGhhbmRsZSwgcGNy
cywgYmFua19hbGc9YmFua19hbGcpCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNl
bGYuY2xpZW50LnBvbGljeV9wYXNzd29yZChoYW5kbGUpCj4gPiA+IMKgIAo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwb2xpY3lfZGlnID0gc2VsZi5jbGllbnQuZ2V0X3BvbGljeV9k
aWdlc3QoaGFuZGxlKQo+ID4gPiBAQCAtNDcsNyArNjMsNyBAQCBjbGFzcyBTbW9rZVRlc3QodW5p
dHRlc3QuVGVzdENhc2UpOgo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgaGFuZGxlID0gc2VsZi5j
bGllbnQuc3RhcnRfYXV0aF9zZXNzaW9uKHRwbTIuVFBNMl9TRV9QT0xJQ1kpCj4gPiA+IMKgIAo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgdHJ5Ogo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzZWxmLmNsaWVudC5wb2xpY3lfcGNyKGhhbmRsZSwgcGNycykKPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc2VsZi5jbGllbnQucG9saWN5X3BjcihoYW5kbGUsIHBjcnMsIGJhbmtfYWxn
PWJhbmtfYWxnKQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmNsaWVudC5w
b2xpY3lfcGFzc3dvcmQoaGFuZGxlKQo+ID4gPiDCoCAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmVzdWx0ID0gc2VsZi5jbGllbnQudW5zZWFsKHNlbGYucm9vdF9rZXksIGJsb2Is
IGF1dGgsIGhhbmRsZSkKPiA+ID4gQEAgLTcyLDYgKzg4LDkgQEAgY2xhc3MgU21va2VUZXN0KHVu
aXR0ZXN0LlRlc3RDYXNlKToKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuYXNzZXJ0RXF1
YWwocmMsIHRwbTIuVFBNMl9SQ19BVVRIX0ZBSUwpCj4gPiA+IMKgIAo+ID4gPiDCoMKgwqDCoMKg
IGRlZiB0ZXN0X3Vuc2VhbF93aXRoX3dyb25nX3BvbGljeShzZWxmKToKPiA+ID4gK8KgwqDCoMKg
wqDCoMKgIGJhbmtfYWxnID0gc2VsZi5kZXRlcm1pbmVfYmFua19hbGcoKQo+ID4gPiArwqDCoMKg
wqDCoMKgwqAgc2VsZi5hc3NlcnRJc05vdE5vbmUoYmFua19hbGcpCj4gPiA+ICsKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgIGhhbmRsZSA9IHNlbGYuY2xpZW50LnN0YXJ0X2F1dGhfc2Vzc2lvbih0
cG0yLlRQTTJfU0VfVFJJQUwpCj4gPiA+IMKgIAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0
YSA9ICgnWCcgKiA2NCkuZW5jb2RlKCkKPiA+ID4gQEAgLTc5LDcgKzk4LDcgQEAgY2xhc3MgU21v
a2VUZXN0KHVuaXR0ZXN0LlRlc3RDYXNlKToKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHBjcnMg
PSBbMTZdCj4gPiA+IMKgIAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgdHJ5Ogo+ID4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmNsaWVudC5wb2xpY3lfcGNyKGhhbmRsZSwgcGNycykK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5jbGllbnQucG9saWN5X3BjcihoYW5k
bGUsIHBjcnMsIGJhbmtfYWxnPWJhbmtfYWxnKQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzZWxmLmNsaWVudC5wb2xpY3lfcGFzc3dvcmQoaGFuZGxlKQo+ID4gPiDCoCAKPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9saWN5X2RpZyA9IHNlbGYuY2xpZW50LmdldF9w
b2xpY3lfZGlnZXN0KGhhbmRsZSkKPiA+ID4gQEAgLTkxLDEzICsxMTAsMTMgQEAgY2xhc3MgU21v
a2VUZXN0KHVuaXR0ZXN0LlRlc3RDYXNlKToKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgICMgRXh0
ZW5kIGZpcnN0IGEgUENSIHRoYXQgaXMgbm90IHBhcnQgb2YgdGhlIHBvbGljeSBhbmQgdHJ5IHRv
IHVuc2VhbC4KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgICMgVGhpcyBzaG91bGQgc3VjY2VlZC4K
PiA+ID4gwqAgCj4gPiA+IC3CoMKgwqDCoMKgwqDCoCBkcyA9IHRwbTIuZ2V0X2RpZ2VzdF9zaXpl
KHRwbTIuVFBNMl9BTEdfU0hBMSkKPiA+ID4gLcKgwqDCoMKgwqDCoMKgIHNlbGYuY2xpZW50LmV4
dGVuZF9wY3IoMSwgKCdYJyAqIGRzKS5lbmNvZGUoKSkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGRz
ID0gdHBtMi5nZXRfZGlnZXN0X3NpemUoYmFua19hbGcpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBz
ZWxmLmNsaWVudC5leHRlbmRfcGNyKDEsICgnWCcgKiBkcykuZW5jb2RlKCksIGJhbmtfYWxnPWJh
bmtfYWxnKQo+ID4gPiDCoCAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGhhbmRsZSA9IHNlbGYu
Y2xpZW50LnN0YXJ0X2F1dGhfc2Vzc2lvbih0cG0yLlRQTTJfU0VfUE9MSUNZKQo+ID4gPiDCoCAK
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHRyeToKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2VsZi5jbGllbnQucG9saWN5X3BjcihoYW5kbGUsIHBjcnMpCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNlbGYuY2xpZW50LnBvbGljeV9wY3IoaGFuZGxlLCBwY3JzLCBiYW5rX2Fs
Zz1iYW5rX2FsZykKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5jbGllbnQu
cG9saWN5X3Bhc3N3b3JkKGhhbmRsZSkKPiA+ID4gwqAgCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJlc3VsdCA9IHNlbGYuY2xpZW50LnVuc2VhbChzZWxmLnJvb3Rfa2V5LCBibG9i
LCBhdXRoLCBoYW5kbGUpCj4gPiA+IEBAIC0xMDksMTQgKzEyOCwxNCBAQCBjbGFzcyBTbW9rZVRl
c3QodW5pdHRlc3QuVGVzdENhc2UpOgo+ID4gPiDCoCAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
ICMgVGhlbiwgZXh0ZW5kIGEgUENSIHRoYXQgaXMgcGFydCBvZiB0aGUgcG9saWN5IGFuZCB0cnkg
dG8gdW5zZWFsLgo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgIyBUaGlzIHNob3VsZCBmYWlsLgo+
ID4gPiAtwqDCoMKgwqDCoMKgwqAgc2VsZi5jbGllbnQuZXh0ZW5kX3BjcigxNiwgKCdYJyAqIGRz
KS5lbmNvZGUoKSkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHNlbGYuY2xpZW50LmV4dGVuZF9wY3Io
MTYsICgnWCcgKiBkcykuZW5jb2RlKCksIGJhbmtfYWxnPWJhbmtfYWxnKQo+ID4gPiDCoCAKPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGhhbmRsZSA9IHNlbGYuY2xpZW50LnN0YXJ0X2F1dGhfc2Vz
c2lvbih0cG0yLlRQTTJfU0VfUE9MSUNZKQo+ID4gPiDCoCAKPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgIHJjID0gMAo+ID4gPiDCoCAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHRyeToKPiA+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5jbGllbnQucG9saWN5X3BjcihoYW5kbGUsIHBj
cnMpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuY2xpZW50LnBvbGljeV9wY3Io
aGFuZGxlLCBwY3JzLCBiYW5rX2FsZz1iYW5rX2FsZykKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2VsZi5jbGllbnQucG9saWN5X3Bhc3N3b3JkKGhhbmRsZSkKPiA+ID4gwqAgCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlc3VsdCA9IHNlbGYuY2xpZW50LnVuc2Vh
bChzZWxmLnJvb3Rfa2V5LCBibG9iLCBhdXRoLCBoYW5kbGUpCj4gPiA+IC0tIAo+ID4gPiAyLjMx
LjEKPiA+ID4gCgo=

