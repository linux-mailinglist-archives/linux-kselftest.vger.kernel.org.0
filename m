Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5103A5536F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 17:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349594AbiFUP6H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 11:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353347AbiFUP5x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 11:57:53 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD02CE21;
        Tue, 21 Jun 2022 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1655827063; x=1687363063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6mIaPxRsGigk5Fmzx4C3+h9sWlkBF9gn2ObKcp08TGs=;
  b=kGIMxMAiYJRDLhLbah/sVK66LxQFKMvJt4X+WrUNWGL1V7e2/hXKQ8zn
   WUfP0lPM20apgR+5SsidjP8SNm8++WkkbkIHoxEk1UGnbfVyvveFaDuRK
   +KCtIK7pJKyEN8wrnOUQhi2Ftr0gfFbBVRJh6tRBiFlMXdRYzK46CqFM5
   8=;
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 21 Jun 2022 15:57:30 +0000
Received: from EX13D16EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com (Postfix) with ESMTPS id 6220743479;
        Tue, 21 Jun 2022 15:57:29 +0000 (UTC)
Received: from [192.168.13.50] (10.43.161.183) by EX13D16EUB003.ant.amazon.com
 (10.43.166.99) with Microsoft SMTP Server (TLS) id 15.0.1497.36; Tue, 21 Jun
 2022 15:57:20 +0000
Message-ID: <d171b002-7d24-3194-2647-267754864dd8@amazon.com>
Date:   Tue, 21 Jun 2022 18:57:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/5] nitro_enclaves: test: Use kunit_test_suite() macro
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <Paraschiv@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        <kunit-dev@googlegroups.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
        <linux-mmc@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-modules@vger.kernel.org>,
        Matt Johnston <matt@codeconstruct.com.au>
References: <20220621085345.603820-1-davidgow@google.com>
 <20220621085345.603820-5-davidgow@google.com>
From:   "Paraschiv, Andra-Irina" <andraprs@amazon.com>
In-Reply-To: <20220621085345.603820-5-davidgow@google.com>
X-Originating-IP: [10.43.161.183]
X-ClientProxiedBy: EX13D07UWB003.ant.amazon.com (10.43.161.66) To
 EX13D16EUB003.ant.amazon.com (10.43.166.99)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CgpPbiAyMS4wNi4yMDIyIDExOjUzLCBEYXZpZCBHb3cgd3JvdGU6Cj4gCj4gVGhlIGt1bml0X3Rl
c3Rfc3VpdGUoKSBtYWNybyBwcmV2aW91c2x5IGNvbmZsaWN0ZWQgd2l0aCBtb2R1bGVfaW5pdCwK
PiBtYWtpbmcgaXQgdW5zdWl0YWJsZSBmb3IgdXNlIGluIHRoZSBuaXRyb19lbmNsYXZlcyB0ZXN0
LiBOb3cgdGhhdCBpdCdzCj4gZml4ZWQsIHdlIGNhbiB1c2UgaXQgaW5zdGVhZCBvZiBhIGN1c3Rv
bSBjYWxsIGludG8gaW50ZXJuYWwgS1VuaXQKPiBmdW5jdGlvbnMgdG8gcnVuIHRoZSB0ZXN0Lgo+
IAo+IEFzIGEgc2lkZS1lZmZlY3QsIHRoaXMgbWVhbnMgdGhhdCB0aGUgdGVzdCByZXN1bHRzIGFy
ZSBwcm9wZXJseSBpbmNsdWRlZAo+IHdpdGggb3RoZXIgc3VpdGVzIHdoZW4gYnVpbHQtaW4uIFRv
IGNlbGVicmF0ZSwgZW5hYmxlIHRoZSB0ZXN0IGJ5Cj4gZGVmYXVsdCB3aGVuIEtVTklUX0FMTF9U
RVNUUyBpcyBzZXQgKGFuZCBOSVRST19FTkNMQVZFUyBlbmFibGVkKS4KPiAKPiBUaGUgbml0cm9f
ZW5jbGF2ZSB0ZXN0cyBjYW4gbm93IGJlIHJ1biB2aWEga3VuaXRfdG9vbCB3aXRoOgo+ICAgICAg
ICAgIC4vdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdC5weSBydW4gLS1hcmNoPXg4Nl82NCBcCj4g
ICAgICAgICAgLS1rY29uZmlnX2FkZCBDT05GSUdfUENJPXkgLS1rY29uZmlnX2FkZCBDT05GSUdf
U01QPXkgXAo+ICAgICAgICAgIC0ta2NvbmZpZ19hZGQgQ09ORklHX0hPVFBMVUdfQ1BVPXkgXAo+
ICAgICAgICAgIC0ta2NvbmZpZ19hZGQgQ09ORklHX1ZJUlRfRFJJVkVSUz15IFwKPiAgICAgICAg
ICAtLWtjb25maWdfYWRkIENPTkZJR19OSVRST19FTkNMQVZFUz15IFwKPiAgICAgICAgICAnbmVf
bWlzY19kZXZfdGVzdCcKPiAKPiAoVGhpcyBpcyBhIHByZXR0eSBsb25nIGNvbW1hbmQsIHNvIGl0
IG1heSBiZSB3b3J0aCBhZGRpbmcgYSAua3VuaXRjb25maWcKPiBmaWxlIGF0IHNvbWUgcG9pbnQs
IGluc3RlYWQuKQo+IAo+IEFja2VkLWJ5OiBQYXJhc2NoaXYsIEFuZHJhLUlyaW5hIDxhbmRyYXBy
c0BhbWF6b24uY29tPgo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEdvdyA8ZGF2aWRnb3dAZ29vZ2xl
LmNvbT4KPiAtLS0KPiAKPiBDaGFuZ2VzIHNpbmNlIHYxOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWtzZWxmdGVzdC8yMDIyMDYxODA5MDMxMC4xMTc0OTMyLTUtZGF2aWRnb3dAZ29v
Z2xlLmNvbS8KPiAtIE1vdmUgdGhlIG1pc3Rha2VubHktYWRkZWQgdGh1bmRlcmJvbHQgS2NvbmZp
ZyB0byB0aGUgcHJldmlvdXMgcGF0Y2gKPiAgICAoVGhhbmtzIEFuZHJhKQo+IC0gQWRkIEFuZHJh
J3MgQWNrZWQtYnkgdGFnLgo+IAo+IC0tLQo+ICAgZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVz
L0tjb25maWcgICAgICAgICAgIHwgIDUgKystLQo+ICAgZHJpdmVycy92aXJ0L25pdHJvX2VuY2xh
dmVzL25lX21pc2NfZGV2LmMgICAgIHwgMjcgLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgLi4uL3Zp
cnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY19kZXZfdGVzdC5jICAgIHwgIDUgKy0tLQo+ICAgMyBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQoKUmV2aWV3ZWQt
Ynk6IEFuZHJhIFBhcmFzY2hpdiA8YW5kcmFwcnNAYW1hem9uLmNvbT4KClRoYW5rIHlvdSwgRGF2
aWQsIGZvciB0aGUgcGF0Y2ggdXBkYXRlcy4KCkFkZGVkIEdyZWcgdG8gdGhlIGxpc3Qgb2YgbWFp
bCByZWNpcGllbnRzLCB0byBiZSBhd2FyZSBvZiB0aGlzIHBhdGNoIApjaGFuZ2VzLCBnaXZlbiB0
aGF0IHRoZSBOaXRybyBFbmNsYXZlcyBrZXJuZWwgZHJpdmVyIGlzIHRyYWNrZWQgdmlhIHRoZSAK
Y2hhci1taXNjIHRyZWUuCgpUaGFua3MsCkFuZHJhCgo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpcnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZyBiL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZl
cy9LY29uZmlnCj4gaW5kZXggMmQzZDk4MTU4MTIxLi5jZTkxYWRkODE0MDEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL0tjb25maWcKPiArKysgYi9kcml2ZXJzL3Zp
cnQvbml0cm9fZW5jbGF2ZXMvS2NvbmZpZwo+IEBAIC0xNiw4ICsxNiw5IEBAIGNvbmZpZyBOSVRS
T19FTkNMQVZFUwo+ICAgICAgICAgICAgVGhlIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBuaXRyb19l
bmNsYXZlcy4KPiAKPiAgIGNvbmZpZyBOSVRST19FTkNMQVZFU19NSVNDX0RFVl9URVNUCj4gLSAg
ICAgICBib29sICJUZXN0cyBmb3IgdGhlIG1pc2MgZGV2aWNlIGZ1bmN0aW9uYWxpdHkgb2YgdGhl
IE5pdHJvIEVuY2xhdmVzIgo+IC0gICAgICAgZGVwZW5kcyBvbiBOSVRST19FTkNMQVZFUyAmJiBL
VU5JVD15Cj4gKyAgICAgICBib29sICJUZXN0cyBmb3IgdGhlIG1pc2MgZGV2aWNlIGZ1bmN0aW9u
YWxpdHkgb2YgdGhlIE5pdHJvIEVuY2xhdmVzIiBpZiAhS1VOSVRfQUxMX1RFU1RTCj4gKyAgICAg
ICBkZXBlbmRzIG9uIE5JVFJPX0VOQ0xBVkVTICYmIEtVTklUCj4gKyAgICAgICBkZWZhdWx0IEtV
TklUX0FMTF9URVNUUwo+ICAgICAgICAgIGhlbHAKPiAgICAgICAgICAgIEVuYWJsZSBLVW5pdCB0
ZXN0cyBmb3IgdGhlIG1pc2MgZGV2aWNlIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIE5pdHJvCj4gICAg
ICAgICAgICBFbmNsYXZlcy4gU2VsZWN0IHRoaXMgb3B0aW9uIG9ubHkgaWYgeW91IHdpbGwgYm9v
dCB0aGUga2VybmVsIGZvcgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2
ZXMvbmVfbWlzY19kZXYuYyBiL2RyaXZlcnMvdmlydC9uaXRyb19lbmNsYXZlcy9uZV9taXNjX2Rl
di5jCj4gaW5kZXggMjBjODgxYjZhNGI2Li4yNDFiOTRmNjJlNTYgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfZGV2LmMKPiArKysgYi9kcml2ZXJzL3Zp
cnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY19kZXYuYwo+IEBAIC0xNzU5LDM1ICsxNzU5LDEwIEBA
IHN0YXRpYyBsb25nIG5lX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21k
LCB1bnNpZ25lZCBsb25nIGFyZykKPiAKPiAgICNpZiBkZWZpbmVkKENPTkZJR19OSVRST19FTkNM
QVZFU19NSVNDX0RFVl9URVNUKQo+ICAgI2luY2x1ZGUgIm5lX21pc2NfZGV2X3Rlc3QuYyIKPiAt
Cj4gLXN0YXRpYyBpbmxpbmUgaW50IG5lX21pc2NfZGV2X3Rlc3RfaW5pdCh2b2lkKQo+IC17Cj4g
LSAgICAgICByZXR1cm4gX19rdW5pdF90ZXN0X3N1aXRlc19pbml0KG5lX21pc2NfZGV2X3Rlc3Rf
c3VpdGVzKTsKPiAtfQo+IC0KPiAtc3RhdGljIGlubGluZSB2b2lkIG5lX21pc2NfZGV2X3Rlc3Rf
ZXhpdCh2b2lkKQo+IC17Cj4gLSAgICAgICBfX2t1bml0X3Rlc3Rfc3VpdGVzX2V4aXQobmVfbWlz
Y19kZXZfdGVzdF9zdWl0ZXMpOwo+IC19Cj4gLSNlbHNlCj4gLXN0YXRpYyBpbmxpbmUgaW50IG5l
X21pc2NfZGV2X3Rlc3RfaW5pdCh2b2lkKQo+IC17Cj4gLSAgICAgICByZXR1cm4gMDsKPiAtfQo+
IC0KPiAtc3RhdGljIGlubGluZSB2b2lkIG5lX21pc2NfZGV2X3Rlc3RfZXhpdCh2b2lkKQo+IC17
Cj4gLX0KPiAgICNlbmRpZgo+IAo+ICAgc3RhdGljIGludCBfX2luaXQgbmVfaW5pdCh2b2lkKQo+
ICAgewo+IC0gICAgICAgaW50IHJjID0gMDsKPiAtCj4gLSAgICAgICByYyA9IG5lX21pc2NfZGV2
X3Rlc3RfaW5pdCgpOwo+IC0gICAgICAgaWYgKHJjIDwgMCkKPiAtICAgICAgICAgICAgICAgcmV0
dXJuIHJjOwo+IC0KPiAgICAgICAgICBtdXRleF9pbml0KCZuZV9jcHVfcG9vbC5tdXRleCk7Cj4g
Cj4gICAgICAgICAgcmV0dXJuIHBjaV9yZWdpc3Rlcl9kcml2ZXIoJm5lX3BjaV9kcml2ZXIpOwo+
IEBAIC0xNzk4LDggKzE3NzMsNiBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgbmVfZXhpdCh2b2lkKQo+
ICAgICAgICAgIHBjaV91bnJlZ2lzdGVyX2RyaXZlcigmbmVfcGNpX2RyaXZlcik7Cj4gCj4gICAg
ICAgICAgbmVfdGVhcmRvd25fY3B1X3Bvb2woKTsKPiAtCj4gLSAgICAgICBuZV9taXNjX2Rldl90
ZXN0X2V4aXQoKTsKPiAgIH0KPiAKPiAgIG1vZHVsZV9pbml0KG5lX2luaXQpOwo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpcnQvbml0cm9fZW5jbGF2ZXMvbmVfbWlzY19kZXZfdGVzdC5jIGIvZHJp
dmVycy92aXJ0L25pdHJvX2VuY2xhdmVzL25lX21pc2NfZGV2X3Rlc3QuYwo+IGluZGV4IDI2NTc5
N2JlZDBlYS4uNzRkZjQzYjkyNWJlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydC9uaXRyb19l
bmNsYXZlcy9uZV9taXNjX2Rldl90ZXN0LmMKPiArKysgYi9kcml2ZXJzL3ZpcnQvbml0cm9fZW5j
bGF2ZXMvbmVfbWlzY19kZXZfdGVzdC5jCj4gQEAgLTE1MSw3ICsxNTEsNCBAQCBzdGF0aWMgc3Ry
dWN0IGt1bml0X3N1aXRlIG5lX21pc2NfZGV2X3Rlc3Rfc3VpdGUgPSB7Cj4gICAgICAgICAgLnRl
c3RfY2FzZXMgPSBuZV9taXNjX2Rldl90ZXN0X2Nhc2VzLAo+ICAgfTsKPiAKPiAtc3RhdGljIHN0
cnVjdCBrdW5pdF9zdWl0ZSAqbmVfbWlzY19kZXZfdGVzdF9zdWl0ZXNbXSA9IHsKPiAtICAgICAg
ICZuZV9taXNjX2Rldl90ZXN0X3N1aXRlLAo+IC0gICAgICAgTlVMTAo+IC19Owo+ICtrdW5pdF90
ZXN0X3N1aXRlKG5lX21pc2NfZGV2X3Rlc3Rfc3VpdGUpOwo+IC0tCj4gMi4zNy4wLnJjMC4xMDQu
ZzA2MTE2MTFhOTQtZ29vZwo+IAoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIChSb21hbmlh
KSBTLlIuTC4gcmVnaXN0ZXJlZCBvZmZpY2U6IDI3QSBTZi4gTGF6YXIgU3RyZWV0LCBVQkM1LCBm
bG9vciAyLCBJYXNpLCBJYXNpIENvdW50eSwgNzAwMDQ1LCBSb21hbmlhLiBSZWdpc3RlcmVkIGlu
IFJvbWFuaWEuIFJlZ2lzdHJhdGlvbiBudW1iZXIgSjIyLzI2MjEvMjAwNS4K

