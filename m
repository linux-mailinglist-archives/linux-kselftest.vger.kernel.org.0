Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8614159B4CB
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiHUPDm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiHUPDl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 11:03:41 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84760D110
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 08:03:40 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id C246130F396;
        Sun, 21 Aug 2022 17:03:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661094219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pcFnGl5MhHh1Eoau9osy4Kafe7Lav1i26l8/G50GVQ=;
        b=iGJnMvtwxLOU7eWCxGX5I4QEzyMTdLrOyUZUNWut0iJc+Xdquhkd0fQBIrrS/Y3zJkDaZU
        2VNLIffeOCsSj5u0Td+NRsGwJeJchTNdNliRRZM1FufNUC30V4zjYgdkqdNdrSpY0RlhdH
        4kdTOHoOW6tHKM7eS+6hlLpwyn5awLhP8nPGcDMVphcNj3+E7SmNSN2++zRJfn3faknper
        1R3STNytTzE7pK3dPc5OXOQ+XKI0stIr35AZkTvlRMvvyvlEQnVNVhwjHKyVJjEA4XDyHm
        KID+lGxf6OfjxzUPABKf6Ty1/OV+4KAfO3DSbX4enaPOXRKHFEAGbmtm1Azg/Q==
Message-ID: <9b789751827e5432f53a6fecffdc2901cd3df0a7.camel@svanheule.net>
Subject: Re: [PATCH] kunit: fix assert_type for KUNIT_EXPECT_LE_MSG()
From:   Sander Vanheule <sander@svanheule.net>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 21 Aug 2022 17:03:37 +0200
In-Reply-To: <20220821145940.277394-1-sander@svanheule.net>
References: <20220821145940.277394-1-sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgZXZlcnlvbmUsCgpPbiBTdW4sIDIwMjItMDgtMjEgYXQgMTY6NTkgKzAyMDAsIFNhbmRlciBW
YW5oZXVsZSB3cm90ZToKPiBXaGVuIHJlcGxhY2luZyBLVU5JVF9CSU5BUllfTEVfTVNHX0FTU0VS
VElPTigpIHdpdGgKPiBLVU5JVF9CSU5BUllfSU5UX0FTU0VSVElPTigpIGZvciBLVU5JVF9FWFBF
Q1RfTEVfTVNHKCksIHRoZSBhc3NlcnRfdHlwZQo+IHBhcmFtZXRlciB3YXMgY2hhbmdlZCBmcm9t
IEtVTklUX0VYUEVDVEFUSU9OIHRvIEtVTklUX0FTU0VSVElPTi7CoCBUaGlzCj4gY2F1c2VzIEtV
TklUX0VYUEVDVF9MRV9NU0coKSBhbmQgS1VOSVRfQVNTRVJUX0xFX01TRygpIHRvIGJlaGF2ZSB0
aGUKPiBzYW1lIHdheSwgYW5kIHRlc3RzIGFmdGVyIGEgZmFpbGVkIEtVTklUX0VYUEVDVF9MRV9N
U0coKSBhcmUgbm90IHJ1bi4KPiAKPiBDYWxsIEtVTklUX0JJTkFSWV9JTlRfQVNTRVJUSU8oKSB3
aXRoIEtVTklUX0VYUEVDVEFUSU9OIGZvciBhZ2FpbiBtYXRjaAo+IHRoZSBkb2N1bWVudGVkIGJl
aGF2aW9yIGZvciBLVU5JVF9FWFBFQ1RfKiBtYWNyb3MuCj4gCj4gRml4ZXM6IDQwZjM5Nzc3Y2U0
ZiAoImt1bml0OiBkZWNyZWFzZSBtYWNybyBsYXllcmluZyBmb3IgaW50ZWdlciBhc3NlcnRzIikK
PiBTaWduZWQtb2ZmLWJ5OiBTYW5kZXIgVmFuaGV1bGUgPHNhbmRlckBzdmFuaGV1bGUubmV0Pgo+
IC0tLQoKTXkgYXBvbG9naWVzIGZvciB0aGUgc2xvcHBpbmVzcywgYnV0IEkgYWNjaWRlbnRhbGx5
IHNlbnQgb3V0IGFuIGluY29tcGxldGUKdmVyc2lvbiBvZiB0aGlzIHBhdGNoLiBQbGVhc2UgZGlz
cmVnYXJkcyB0aGlzIHBhdGNoLCB2MiBpcyBhbHJlYWR5wqBwb3N0ZWQuCgpTb3JyeSBmb3IgdGhl
IG5vaXNlIQoKQmVzdCwKU2FuZGVyCgo+IMKgaW5jbHVkZS9rdW5pdC90ZXN0LmggfCAyICstCj4g
wqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9rdW5pdC90ZXN0LmggYi9pbmNsdWRlL2t1bml0L3Rlc3QuaAo+IGlu
ZGV4IGM5NTg4NTU2ODFjYy4uNjE3ZWM5OTU2NzFkIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUva3Vu
aXQvdGVzdC5oCj4gKysrIGIvaW5jbHVkZS9rdW5pdC90ZXN0LmgKPiBAQCAtODI2LDcgKzgyNiw3
IEBAIGRvCj4ge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiDCoCBc
Cj4gwqAKPiDCoCNkZWZpbmUgS1VOSVRfRVhQRUNUX0xFX01TRyh0ZXN0LCBsZWZ0LCByaWdodCwg
Zm10LCAuLi4pwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gXAo+
IMKgwqDCoMKgwqDCoMKgwqBLVU5JVF9CSU5BUllfSU5UX0FTU0VSVElPTih0ZXN0LMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAKPiBcCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBLVU5JVF9BU1NFUlRJT04swqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gXAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgS1VOSVRfRVhQRUNUQVRJT04swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAKPiBcCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGVmdCwgPD0sIHJpZ2h0LMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IFwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBmbXQswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gXAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyNf
X1ZBX0FSR1NfXykKCg==

