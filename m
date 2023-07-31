Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3506676966F
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGaMfn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGaMfm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 08:35:42 -0400
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7A21AC;
        Mon, 31 Jul 2023 05:35:39 -0700 (PDT)
X-QQ-mid: bizesmtp78t1690806930tiig1bsc
Received: from [172.18.158.193] ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 20:35:28 +0800 (CST)
X-QQ-SSF: 01200000000000705000000A0000000
X-QQ-FEAT: dKvkn8qoLrEj/D0hXLxxIoD1naz/LBJ23ThnpzmwPysYdggnMzUkoSQZ682Vb
        JJhIDDPdzNi5tcw/+i2VCHr8TY7iv7nkfpMBJBwCW0PXoSwu80aBHHgYhKLn6cfGZKNrWbY
        Prt/3AsdJ42srKaEnccJBdMuRvv7UlB6YCAV9MiZM3oDW8URZtyAm7JwLgwvRo1tXFAP5/i
        330YNrzwiOkDsMVt/zsTifoEwrwlnzy/XHnEMgJP2g6eWC0qXrULJI3KYAH0a529XgKpSTg
        4WXBiIEP2kkYX3y+GmiePMO89v7TqSK/WJX5qnckRqDwaufKFK0zvVCXNqF9NDZd9zJEBOg
        hmskshuQ9wWsj0fvEpM40Ga5b5ocyTDCFAijkge6ZB/0V03uOhrGx4U4GinZS8rh693V5Je
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2937943908816108292
Message-ID: <C3AF612281F87D1A+733ce5c0d1efe1f81423e6885203d92cdb4eaee7.camel@tinylab.org>
Subject: Re: [PATCH v2 2/2] selftests/nolibc: add testcase for pipe
From:   Yuan Tan <tanyuan@tinylab.org>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Date:   Mon, 31 Jul 2023 20:35:28 +0800
In-Reply-To: <a4899657-7d7b-4786-8903-8f51e438535d@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
         <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org>
         <a4899657-7d7b-4786-8903-8f51e438535d@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgVGhvbWFzLAoKT24gTW9uLCAyMDIzLTA3LTMxIGF0IDA4OjEwICswMjAwLCBUaG9tYXMgV2Vp
w59zY2h1aCB3cm90ZToKPiBPbiAyMDIzLTA3LTMxIDEzOjUxOjAwKzA4MDAsIFl1YW4gVGFuIHdy
b3RlOgo+ID4gQWRkIGEgdGVzdGNhc2Ugb2YgcGlwZSB0aGF0IGNoaWxkIHByb2Nlc3Mgc2VuZHMg
bWVzc2FnZSB0byBwYXJlbnQKPiA+IHByb2Nlc3MuCj4gCj4gVGhpbmtpbmcgYWJvdXQgaXQgc29t
ZSBtb3JlOgo+IAo+IFdoYXQncyB0aGUgYWR2YW50YWdlIG9mIGdvaW5nIHZpYSBhIGNoaWxkIHBy
b2Nlc3M/Cj4gVGhlIHBpcGUgc2hvdWxkIHdvcmsgdGhlIHNhbWUgd2l0aGluIHRoZSBzYW1lIHBy
b2Nlc3MuCj4gCgpUaGUgcGlwZSBpcyBjb21tb25seSB1c2VkIGZvciBwcm9jZXNzIGNvbW11bmlj
YXRpb24sIGFuZCBJIHRoaW5rIGFzIGEKdGVzdCBjYXNlIGl0IGlzIHN1cHBvc2VkIHRvIGNvdmVy
IHRoZSBtb3N0IGNvbW1vbiBzY2VuYXJpb3MuCgo+ID4gSGVyZSB3ZSB1c2UgbWVtY21wKCkgdG8g
YXZvaWQgdGhlIG91dHB1dCBidWZmZXIgaXNzdWUuCj4gCj4gVGhpcyBzZW50ZW5jZSBpcyBtZWFu
aW5nbGVzcyB3aXRob3V0IHRoZSBiYWNrZ3JvdW5kIGZyb20gdjEuCj4gWW91IGNhbiBkcm9wIGl0
Lgo+IAoKR290IGl0LgoKPiA+IFN1Z2dlc3RlZC1ieTogVGhvbWFzIFdlacOfc2NodWggPHRob21h
c0B0LThjaC5kZT4KPiA+IFN1Z2dlc3RlZC1ieTogV2lsbHkgVGFycmVhdSA8d0Axd3QuZXU+Cj4g
PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYzVkZTJkMTMtMzc1Mi00ZTFiLTkw
ZDktZjU4Y2NhOTljNzAyQHQtOGNoLmRlLwo+ID4gU2lnbmVkLW9mZi1ieTogWXVhbiBUYW4gPHRh
bnl1YW5AdGlueWxhYi5vcmc+Cj4gPiAtLS0KPiA+IMKgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bm9saWJjL25vbGliYy10ZXN0LmMgfCAzNSArKysrKysrKysrKysrKysrKysrKwo+ID4gwqAxIGZp
bGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbm9saWJjL25vbGliYy10ZXN0LmMgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9ub2xpYmMvbm9saWJjLXRlc3QuYwo+ID4gaW5kZXggMDNiMWQzMGY1NTA3Li4yNjUz
YWI4ZDUxMjQgMTAwNjQ0Cj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ub2xpYmMv
bm9saWJjLXRlc3QuYwo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbm9saWJjL25v
bGliYy10ZXN0LmMKPiA+IEBAIC03NjcsNiArNzY3LDQxIEBAIGludCB0ZXN0X21tYXBfbXVubWFw
KHZvaWQpCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiA+IMKgfQo+ID4gwqAKPiA+
ICtpbnQgdGVzdF9waXBlKHZvaWQpCj4gCj4gU2hvdWxkIGJlIHN0YXRpYyBhbmQgYWN0dWFsbHkg
Z2V0IGNhbGxlZCA6LSkKPiAKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBjb25zdCBjaGFyICpj
b25zdCBtc2cgPSAiaGVsbG8sIG5vbGliYyI7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcGlwZWZk
WzJdOwo+ID4gK8KgwqDCoMKgwqDCoMKgY2hhciBidWZbMzJdOwo+ID4gK8KgwqDCoMKgwqDCoMKg
cGlkX3QgcGlkOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3NpemVfdCBsZW47Cj4gPiArCj4gPiArwqDC
oMKgwqDCoMKgwqBpZiAocGlwZShwaXBlZmQpID09IC0xKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAxOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcGlkID0gZm9y
aygpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgc3dpdGNoIChwaWQpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoGNhc2UgLTE6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IDE7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIDA6Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY2xvc2UocGlwZWZkWzBdKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB3cml0ZShwaXBlZmRbMV0sIG1zZywgc3RybGVuKG1zZykpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb3NlKHBpcGVmZFsxXSk7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZXhpdChFWElUX1NVQ0NFU1MpOwo+ID4gKwo+ID4gK8KgwqDC
oMKgwqDCoMKgZGVmYXVsdDoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9z
ZShwaXBlZmRbMV0pOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxlbiA9IHJl
YWQocGlwZWZkWzBdLCBidWYsIHNpemVvZihidWYpKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjbG9zZShwaXBlZmRbMF0pOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHdhaXRwaWQocGlkLCBOVUxMLCAwKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAobGVuICE9IHN0cmxlbihtc2cpKQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMTsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gISFtZW1jbXAoYnVmLCBtc2csIGxlbik7Cj4gPiAr
wqDCoMKgwqDCoMKgwqB9Cj4gPiArfQo+ID4gKwo+ID4gwqAKPiA+IMKgLyogUnVuIHN5c2NhbGwg
dGVzdHMgYmV0d2VlbiBJRHMgPG1pbj4gYW5kIDxtYXg+Lgo+ID4gwqAgKiBSZXR1cm4gMCBvbiBz
dWNjZXNzLCBub24temVybyBvbiBmYWlsdXJlLgo+ID4gLS0gCj4gPiAyLjM0LjEKPiA+IAo+IAoK


