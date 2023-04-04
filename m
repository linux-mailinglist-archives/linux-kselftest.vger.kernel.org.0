Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6DB6D6B01
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjDDR7K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 13:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjDDR7J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 13:59:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AA0C9;
        Tue,  4 Apr 2023 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=W30E6yJdVpvc8OvdU150EHIgwOc4jlmRCMLcYR9/+KU=;
        t=1680631148; x=1681840748; b=ryjFfh1UzIf8/oDSmK1Wlz9z5rTX4Zk/CbPcYPv4spt8wNz
        Qo9anmEOWN8VeptT5ugJiRazMDwKCN61kBEQRKSL7HgudwaTtNDPGBNCZIkgxYV5P7pOmtmbP2Kze
        PoF1mmyCnvYLKMezeVXs42AUrJMdhvN+ClW2Y5LenBx/CT69k1+xuO/xp1UUKmDnRYEOFhkXqXy1u
        sTzhf/DANTjPvGyzo0xNGhKRJIWNUwdF1+Yti0pprvg+G5ZngW9wwXoXeDhXj6kBNOzj/NsgIH4QT
        oJfzR0UhxqoUXREVtv7+0VMjtZGpKLzL2Z6h+t4jFFJcrNlu5qm60ApGuMlan6VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1pjkvr-006C1S-39;
        Tue, 04 Apr 2023 19:59:00 +0200
Message-ID: <fbfaed01ac773b72a5a79f9a514c646ac21d5583.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 3/3] kunit: kmalloc_array: Use kunit_add_action()
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Date:   Tue, 04 Apr 2023 19:58:58 +0200
In-Reply-To: <20230331080411.981038-4-davidgow@google.com>
References: <20230331080411.981038-1-davidgow@google.com>
         <20230331080411.981038-4-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGksCgpPbiBGcmksIDIwMjMtMDMtMzEgYXQgMTY6MDQgKzA4MDAsICdEYXZpZCBHb3cnIHZpYSBL
VW5pdCBEZXZlbG9wbWVudCB3cm90ZToKPiBUaGUga3VuaXRfYWRkX2FjdGlvbigpIGZ1bmN0aW9u
IGlzIG11Y2ggc2ltcGxlciBhbmQgY2xlYW5lciB0byB1c2UgdGhhdAo+IHRoZSBmdWxsIEtVbml0
IHJlc291cmNlIEFQSSBmb3Igc2ltcGxlIHRoaW5ncyBsaWtlIHRoZQo+IGt1bml0X2ttYWxsb2Nf
YXJyYXkoKSBmdW5jdGlvbmFsaXR5Lgo+IAo+IFJlcGxhY2luZyBpdCBhbGxvd3MgdXMgdG8gZ2V0
IHJpZCBvZiBhIG51bWJlciBvZiBoZWxwZXIgZnVuY3Rpb25zLCBhbmQKPiBsZWF2ZXMgdXMgd2l0
aCBubyB1c2VzIG9mIGt1bml0X2FsbG9jX3Jlc291cmNlKCksIHdoaWNoIGhhcyBzb21lCj4gdXNh
YmlsaXR5IHByb2JsZW1zIGFuZCBpcyBnb2luZyB0byBoYXZlIGl0cyBiZWhhdmlvdXIgbW9kaWZp
ZWQgaW4gYW4KPiB1cGNvbWluZyBwYXRjaC4KPiAKPiBOb3RlIHRoYXQgd2UgbmVlZCB0byB1c2Ug
a3VuaXRfZGVmZXJfdHJpZ2dlcl9hbGwoKSB0byBpbXBsZW1lbnQKPiBrdW5pdF9rZnJlZSgpLgoK
SnVzdCBhIG5pdHBpY2s6IGt1bml0X2RlZmVyX3RyaWdnZXJfYWxsIGRvZXMgbm90IGV4aXN0IGlu
IHRoZSBuZXcgcGF0Y2gKYW55bW9yZS4gSSBndWVzcyB0aGlzIHNob3VsZCBiZSBrdW5pdF9yZWxl
YXNlX2FjdGlvbi4KCkJlbmphbWluCgo+IAo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEdvdyA8ZGF2
aWRnb3dAZ29vZ2xlLmNvbT4KPiAtLS0KPiDCoGxpYi9rdW5pdC90ZXN0LmMgfCA0OCArKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9s
aWIva3VuaXQvdGVzdC5jIGIvbGliL2t1bml0L3Rlc3QuYwo+IGluZGV4IGUyOTEwYjI2MTExMi4u
ZWM0NWM4ODYzZjA0IDEwMDY0NAo+IC0tLSBhL2xpYi9rdW5pdC90ZXN0LmMKPiArKysgYi9saWIv
a3VuaXQvdGVzdC5jCj4gQEAgLTcxMiw1OCArNzEyLDI2IEBAIHN0YXRpYyBzdHJ1Y3Qgbm90aWZp
ZXJfYmxvY2sga3VuaXRfbW9kX25iID0gewo+IMKgfTsKPiDCoCNlbmRpZgo+IMKgCj4gLXN0cnVj
dCBrdW5pdF9rbWFsbG9jX2FycmF5X3BhcmFtcyB7Cj4gLcKgwqDCoMKgwqDCoMKgc2l6ZV90IG47
Cj4gLcKgwqDCoMKgwqDCoMKgc2l6ZV90IHNpemU7Cj4gLcKgwqDCoMKgwqDCoMKgZ2ZwX3QgZ2Zw
Owo+IC19Owo+IC0KPiAtc3RhdGljIGludCBrdW5pdF9rbWFsbG9jX2FycmF5X2luaXQoc3RydWN0
IGt1bml0X3Jlc291cmNlICpyZXMsIHZvaWQgKmNvbnRleHQpCj4gK3ZvaWQgKmt1bml0X2ttYWxs
b2NfYXJyYXkoc3RydWN0IGt1bml0ICp0ZXN0LCBzaXplX3Qgbiwgc2l6ZV90IHNpemUsIGdmcF90
IGdmcCkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qga3VuaXRfa21hbGxvY19hcnJheV9w
YXJhbXMgKnBhcmFtcyA9IGNvbnRleHQ7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHJlcy0+ZGF0YSA9
IGttYWxsb2NfYXJyYXkocGFyYW1zLT5uLCBwYXJhbXMtPnNpemUsIHBhcmFtcy0+Z2ZwKTsKPiAt
wqDCoMKgwqDCoMKgwqBpZiAoIXJlcy0+ZGF0YSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIC1FTk9NRU07Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IC19
Cj4gK8KgwqDCoMKgwqDCoMKgdm9pZCAqZGF0YTsKPiDCoAo+IC1zdGF0aWMgdm9pZCBrdW5pdF9r
bWFsbG9jX2FycmF5X2ZyZWUoc3RydWN0IGt1bml0X3Jlc291cmNlICpyZXMpCj4gLXsKPiAtwqDC
oMKgwqDCoMKgwqBrZnJlZShyZXMtPmRhdGEpOwo+IC19Cj4gK8KgwqDCoMKgwqDCoMKgZGF0YSA9
IGttYWxsb2NfYXJyYXkobiwgc2l6ZSwgZ2ZwKTsKPiDCoAo+IC12b2lkICprdW5pdF9rbWFsbG9j
X2FycmF5KHN0cnVjdCBrdW5pdCAqdGVzdCwgc2l6ZV90IG4sIHNpemVfdCBzaXplLCBnZnBfdCBn
ZnApCj4gLXsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qga3VuaXRfa21hbGxvY19hcnJheV9wYXJh
bXMgcGFyYW1zID0gewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc2l6ZSA9IHNp
emUsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5uID0gbiwKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgLmdmcCA9IGdmcAo+IC3CoMKgwqDCoMKgwqDCoH07Cj4gK8Kg
wqDCoMKgwqDCoMKgaWYgKCFkYXRhKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gTlVMTDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBrdW5pdF9hbGxvY19yZXNv
dXJjZSh0ZXN0LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrdW5pdF9rbWFsbG9jX2FycmF5X2luaXQsCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGt1bml0X2ttYWxsb2NfYXJyYXlfZnJlZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2ZwLAo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAmcGFyYW1zKTsKPiArwqDCoMKgwqDCoMKgwqBrdW5pdF9hZGRfYWN0aW9u
KHRlc3QsIChrdW5pdF9kZWZlcl9mdW5jdGlvbl90KWtmcmVlLCBkYXRhLCBnZnApOwo+ICvCoMKg
wqDCoMKgwqDCoHJldHVybiBkYXRhOwo+IMKgfQo+IMKgRVhQT1JUX1NZTUJPTF9HUEwoa3VuaXRf
a21hbGxvY19hcnJheSk7Cj4gwqAKPiAtc3RhdGljIGlubGluZSBib29sIGt1bml0X2tmcmVlX21h
dGNoKHN0cnVjdCBrdW5pdCAqdGVzdCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qga3VuaXRfcmVz
b3VyY2UgKnJlcywgdm9pZCAqbWF0Y2hfZGF0YSkKPiAtewo+IC3CoMKgwqDCoMKgwqDCoC8qIE9u
bHkgbWF0Y2ggcmVzb3VyY2VzIGFsbG9jYXRlZCB3aXRoIGt1bml0X2ttYWxsb2MoKSBhbmQgZnJp
ZW5kcy4gKi8KPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gcmVzLT5mcmVlID09IGt1bml0X2ttYWxs
b2NfYXJyYXlfZnJlZSAmJiByZXMtPmRhdGEgPT0gbWF0Y2hfZGF0YTsKPiAtfQo+IC0KPiDCoHZv
aWQga3VuaXRfa2ZyZWUoc3RydWN0IGt1bml0ICp0ZXN0LCBjb25zdCB2b2lkICpwdHIpCj4gwqB7
Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICghcHRyKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgaWYgKGt1bml0X2Rlc3Ryb3lfcmVz
b3VyY2UodGVzdCwga3VuaXRfa2ZyZWVfbWF0Y2gsICh2b2lkICopcHRyKSkKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgS1VOSVRfRkFJTCh0ZXN0LCAia3VuaXRfa2ZyZWU6ICVweCBh
bHJlYWR5IGZyZWVkIG9yIG5vdCBhbGxvY2F0ZWQgYnkga3VuaXQiLCBwdHIpOwo+ICvCoMKgwqDC
oMKgwqDCoGt1bml0X3JlbGVhc2VfYWN0aW9uKHRlc3QsIChrdW5pdF9kZWZlcl9mdW5jdGlvbl90
KWtmcmVlLCAodm9pZCAqKXB0cik7Cj4gwqB9Cj4gwqBFWFBPUlRfU1lNQk9MX0dQTChrdW5pdF9r
ZnJlZSk7Cj4gwqAKPiAtLSAKPiAyLjQwLjAuMzQ4LmdmOTM4YjA5MzY2LWdvb2cKPiAKCg==

