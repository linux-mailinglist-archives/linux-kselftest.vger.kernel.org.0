Return-Path: <linux-kselftest+bounces-895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198DA7FF791
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 17:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88A928183D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFA455C02;
	Thu, 30 Nov 2023 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F8OqNkGU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79583
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 08:58:40 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b37a2e6314so14069839f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701363520; x=1701968320; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kjfGUOrzOcR4VCFCR9ZAuqiy4DmfY+gNhzhv4Uomr1U=;
        b=F8OqNkGUafd5FWrSsioFV9IZrJ1u9pnpNnVr4UWnBECGKZ2jP41b9BIVe55bWrAwGn
         KMSV3xt9y738n3YnEcf2yp0edMKSD2EpxQXMc7+ftAj7H7H6X+zLSLPSG5ZH5VUrqhVm
         a/unZ30ed5vOGbSO0IXeGe0Gi0vznQZhMWgrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363520; x=1701968320;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjfGUOrzOcR4VCFCR9ZAuqiy4DmfY+gNhzhv4Uomr1U=;
        b=CFv3/2oJBom6S77XaOHvT+gtpId4rwRrHYp9haaFsJCY5GE1A+D4fwaaexpm2YkHNY
         q6aVsfL4kTe9F/9Gfn562uLwF2tKjnKXMq9DkjLkHOndkBV4RUwkIJvGIIuWHRudKGty
         WJhk6/FKJ8hM+8fAeWhgfOQ1tqRFdfqdG4vj25Z+Z/jGVcU9TMF31KCQ5T99QRcKcibI
         RFSlfsJGGPHyQnj5DQ0la0ZeS9ZG5zNllNUUfFPrKa7G7VcBecDfYGMu9dkG4lcLTS8s
         DjG3EDk3Kw3upXcT6XCqCEH5KrWQVeUt63IiznhzZl2mniaQjYG3m6SJWWXrvcTqj+mB
         N+zA==
X-Gm-Message-State: AOJu0YyGUumqLxHEkP7zrPVn8ryWsUj8nvX/gfANnvtUjbjTWdBi2kyh
	H++W934uh5u1wOakGT88hcJBPg==
X-Google-Smtp-Source: AGHT+IFSVsGsXT2IkoG9CBP+31+G7sAfiES8qJIDWWX0VAYPQbMR17+QOR56yYT2iZGtf5zDVFwFAw==
X-Received: by 2002:a05:6e02:b4a:b0:35c:baec:750c with SMTP id f10-20020a056e020b4a00b0035cbaec750cmr2483295ilu.1.1701363520298;
        Thu, 30 Nov 2023 08:58:40 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d15-20020a056e021c4f00b0035c8c6045cfsm213266ilg.72.2023.11.30.08.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 08:58:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------6IEXtfpLNI6JnAsB035VsGjN"
Message-ID: <c26192e6-df1e-450a-ac2d-e18fc0d77fe9@linuxfoundation.org>
Date: Thu, 30 Nov 2023 09:58:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.7-rc4

This is a multi-part message in MIME format.
--------------6IEXtfpLNI6JnAsB035VsGjN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.7-rc4.

This KUnit fixes update for Linux 6.7-rc4 consists of three fixes to
warnings and run-time test behavior. With these fixes, test suite
counter will be reset correctly before running tests, kunit will warn
if tests are too slow, and eliminate warning when kfree() as an action.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.7-rc4

for you to fetch changes up to 1bddcf77ce6668692fc15e968fd0870d5524d112:

   kunit: test: Avoid cast warning when adding kfree() as an action (2023-11-14 13:01:57 -0700)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.7-rc4

This KUnit fixes update for Linux 6.7-rc4 consists of three fixes to
warnings and run-time test behavior. With these fixes, test suite
counter will be reset correctly before running tests, kunit will warn
if tests are too slow, and eliminate warning when kfree() as an action.

----------------------------------------------------------------
Maxime Ripard (1):
       kunit: Warn if tests are slow

Michal Wajdeczko (1):
       kunit: Reset suite counter right before running tests

Richard Fitzgerald (1):
       kunit: test: Avoid cast warning when adding kfree() as an action

  lib/kunit/kunit-test.c |  2 +-
  lib/kunit/test.c       | 42 ++++++++++++++++++++++++++++++++++++++++--
  2 files changed, 41 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------6IEXtfpLNI6JnAsB035VsGjN
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.7-rc4.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.7-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9rdW5pdC10ZXN0LmMgYi9saWIva3VuaXQva3VuaXQt
dGVzdC5jCmluZGV4IDk5ZDJhM2E1MjhlMS4uZGUyMTEzYTU4ZmEwIDEwMDY0NAotLS0gYS9s
aWIva3VuaXQva3VuaXQtdGVzdC5jCisrKyBiL2xpYi9rdW5pdC9rdW5pdC10ZXN0LmMKQEAg
LTU2Miw3ICs1NjIsNyBAQCBzdGF0aWMgdm9pZCBrdW5pdF9sb2dfdGVzdChzdHJ1Y3Qga3Vu
aXQgKnRlc3QpCiAJS1VOSVRfRVhQRUNUX1RSVUUodGVzdCwgdGVzdC0+bG9nLT5hcHBlbmRf
bmV3bGluZXMpOwogCiAJZnVsbF9sb2cgPSBzdHJpbmdfc3RyZWFtX2dldF9zdHJpbmcodGVz
dC0+bG9nKTsKLQlrdW5pdF9hZGRfYWN0aW9uKHRlc3QsIChrdW5pdF9hY3Rpb25fdCAqKWtm
cmVlLCBmdWxsX2xvZyk7CisJa3VuaXRfYWRkX2FjdGlvbih0ZXN0LCBrZnJlZV93cmFwcGVy
LCBmdWxsX2xvZyk7CiAJS1VOSVRfRVhQRUNUX05PVF9FUlJfT1JfTlVMTCh0ZXN0LAogCQkJ
CSAgICAgc3Ryc3RyKGZ1bGxfbG9nLCAicHV0IHRoaXMgaW4gbG9nLiIpKTsKIAlLVU5JVF9F
WFBFQ1RfTk9UX0VSUl9PUl9OVUxMKHRlc3QsCmRpZmYgLS1naXQgYS9saWIva3VuaXQvdGVz
dC5jIGIvbGliL2t1bml0L3Rlc3QuYwppbmRleCBmMmViNzFmMWE2NmMuLjdhY2ViMDdhMWFm
OSAxMDA2NDQKLS0tIGEvbGliL2t1bml0L3Rlc3QuYworKysgYi9saWIva3VuaXQvdGVzdC5j
CkBAIC0zMzgsNiArMzM4LDM2IEBAIHZvaWQga3VuaXRfaW5pdF90ZXN0KHN0cnVjdCBrdW5p
dCAqdGVzdCwgY29uc3QgY2hhciAqbmFtZSwgc3RydWN0IHN0cmluZ19zdHJlYW0KIH0KIEVY
UE9SVF9TWU1CT0xfR1BMKGt1bml0X2luaXRfdGVzdCk7CiAKKy8qIE9ubHkgd2FybiB3aGVu
IGEgdGVzdCB0YWtlcyBtb3JlIHRoYW4gdHdpY2UgdGhlIHRocmVzaG9sZCAqLworI2RlZmlu
ZSBLVU5JVF9TUEVFRF9XQVJOSU5HX01VTFRJUExJRVIJMgorCisvKiBTbG93IHRlc3RzIGFy
ZSBkZWZpbmVkIGFzIHRha2luZyBtb3JlIHRoYW4gMXMgKi8KKyNkZWZpbmUgS1VOSVRfU1BF
RURfU0xPV19USFJFU0hPTERfUwkxCisKKyNkZWZpbmUgS1VOSVRfU1BFRURfU0xPV19XQVJO
SU5HX1RIUkVTSE9MRF9TCVwKKwkoS1VOSVRfU1BFRURfV0FSTklOR19NVUxUSVBMSUVSICog
S1VOSVRfU1BFRURfU0xPV19USFJFU0hPTERfUykKKworI2RlZmluZSBzX3RvX3RpbWVzcGVj
NjQocykgbnNfdG9fdGltZXNwZWM2NCgocykgKiBOU0VDX1BFUl9TRUMpCisKK3N0YXRpYyB2
b2lkIGt1bml0X3J1bl9jYXNlX2NoZWNrX3NwZWVkKHN0cnVjdCBrdW5pdCAqdGVzdCwKKwkJ
CQkgICAgICAgc3RydWN0IGt1bml0X2Nhc2UgKnRlc3RfY2FzZSwKKwkJCQkgICAgICAgc3Ry
dWN0IHRpbWVzcGVjNjQgZHVyYXRpb24pCit7CisJc3RydWN0IHRpbWVzcGVjNjQgc2xvd190
aHIgPQorCQlzX3RvX3RpbWVzcGVjNjQoS1VOSVRfU1BFRURfU0xPV19XQVJOSU5HX1RIUkVT
SE9MRF9TKTsKKwllbnVtIGt1bml0X3NwZWVkIHNwZWVkID0gdGVzdF9jYXNlLT5hdHRyLnNw
ZWVkOworCisJaWYgKHRpbWVzcGVjNjRfY29tcGFyZSgmZHVyYXRpb24sICZzbG93X3Rocikg
PCAwKQorCQlyZXR1cm47CisKKwlpZiAoc3BlZWQgPT0gS1VOSVRfU1BFRURfVkVSWV9TTE9X
IHx8IHNwZWVkID09IEtVTklUX1NQRUVEX1NMT1cpCisJCXJldHVybjsKKworCWt1bml0X3dh
cm4odGVzdCwKKwkJICAgIlRlc3Qgc2hvdWxkIGJlIG1hcmtlZCBzbG93IChydW50aW1lOiAl
bGxkLiUwOWxkcykiLAorCQkgICBkdXJhdGlvbi50dl9zZWMsIGR1cmF0aW9uLnR2X25zZWMp
OworfQorCiAvKgogICogSW5pdGlhbGl6ZXMgYW5kIHJ1bnMgdGVzdCBjYXNlLiBEb2VzIG5v
dCBjbGVhbiB1cCBvciBkbyBwb3N0IHZhbGlkYXRpb25zLgogICovCkBAIC0zNDUsNiArMzc1
LDggQEAgc3RhdGljIHZvaWQga3VuaXRfcnVuX2Nhc2VfaW50ZXJuYWwoc3RydWN0IGt1bml0
ICp0ZXN0LAogCQkJCSAgICBzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1aXRlLAogCQkJCSAgICBz
dHJ1Y3Qga3VuaXRfY2FzZSAqdGVzdF9jYXNlKQogeworCXN0cnVjdCB0aW1lc3BlYzY0IHN0
YXJ0LCBlbmQ7CisKIAlpZiAoc3VpdGUtPmluaXQpIHsKIAkJaW50IHJldDsKIApAQCAtMzU2
LDcgKzM4OCwxMyBAQCBzdGF0aWMgdm9pZCBrdW5pdF9ydW5fY2FzZV9pbnRlcm5hbChzdHJ1
Y3Qga3VuaXQgKnRlc3QsCiAJCX0KIAl9CiAKKwlrdGltZV9nZXRfdHM2NCgmc3RhcnQpOwor
CiAJdGVzdF9jYXNlLT5ydW5fY2FzZSh0ZXN0KTsKKworCWt0aW1lX2dldF90czY0KCZlbmQp
OworCisJa3VuaXRfcnVuX2Nhc2VfY2hlY2tfc3BlZWQodGVzdCwgdGVzdF9jYXNlLCB0aW1l
c3BlYzY0X3N1YihlbmQsIHN0YXJ0KSk7CiB9CiAKIHN0YXRpYyB2b2lkIGt1bml0X2Nhc2Vf
aW50ZXJuYWxfY2xlYW51cChzdHJ1Y3Qga3VuaXQgKnRlc3QpCkBAIC02NzAsNiArNzA4LDgg
QEAgaW50IF9fa3VuaXRfdGVzdF9zdWl0ZXNfaW5pdChzdHJ1Y3Qga3VuaXRfc3VpdGUgKiBj
b25zdCAqIGNvbnN0IHN1aXRlcywgaW50IG51bV8KIAkJcmV0dXJuIDA7CiAJfQogCisJa3Vu
aXRfc3VpdGVfY291bnRlciA9IDE7CisKIAlzdGF0aWNfYnJhbmNoX2luYygma3VuaXRfcnVu
bmluZyk7CiAKIAlmb3IgKGkgPSAwOyBpIDwgbnVtX3N1aXRlczsgaSsrKSB7CkBAIC02OTYs
OCArNzM2LDYgQEAgdm9pZCBfX2t1bml0X3Rlc3Rfc3VpdGVzX2V4aXQoc3RydWN0IGt1bml0
X3N1aXRlICoqc3VpdGVzLCBpbnQgbnVtX3N1aXRlcykKIAogCWZvciAoaSA9IDA7IGkgPCBu
dW1fc3VpdGVzOyBpKyspCiAJCWt1bml0X2V4aXRfc3VpdGUoc3VpdGVzW2ldKTsKLQotCWt1
bml0X3N1aXRlX2NvdW50ZXIgPSAxOwogfQogRVhQT1JUX1NZTUJPTF9HUEwoX19rdW5pdF90
ZXN0X3N1aXRlc19leGl0KTsKIAo=

--------------6IEXtfpLNI6JnAsB035VsGjN--

