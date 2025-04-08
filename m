Return-Path: <linux-kselftest+bounces-30382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E939A8189B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 00:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627B217B213
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 22:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8925334F;
	Tue,  8 Apr 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TD1emFMc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D821ADC7
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151515; cv=none; b=LJ8RdQc4safAA7VLiDjSkD6Nq3tCGkHkKa1p0E6Z4KKT9vN2vUhzw+YxRQtIIJ/CuYNaM7rfWLooRR2k8ERIeylbChLrGaJBaRRYHGAWz8VcaGF6XqHm+vxA3G/hfY5m0LYhWwikXQfVWLp+yKJBS1X9YRuIgdeVgY0GBJWHjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151515; c=relaxed/simple;
	bh=4WOkA299ieTu7VuMb8Ojo+52kG+DAoRovBqg0oHZuHc=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=MWRJ0oZ8XoKy3GuwYd3sQXBSQNMPCrk9c8qIzkfuzD4cXYRNeBbGFxnDqus15Pxn9R28T/hmF8AboIeAaM9LVukqz6zZMIsMk7KltODxPYDZL5lkLxksMa8fCTyfWkrzAtSEUzOMy7l6DZyQ3MI1Lqn1MX/uQlJ2Oj213rxdULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TD1emFMc; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86135ad7b4cso78219939f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744151512; x=1744756312; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pAWzVkguP8Oqw2TYk2JCRWfNXIScPDbjXxeh1BiAU14=;
        b=TD1emFMc1XY5YM6vwmFWqrCXtLOoqZUwv5Nf/jAE/LIDI1szPVQN7inTDmCdDoDl1R
         sDnrTwqkJEKmI4ONIm5h2F20yDxC22qk8AOyi8nSthFX3+rvqY3S8njAQr4yQjW/zKWx
         4IGfMHDcnERFH6RMvn6dn50ll/A60CbRUFwJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744151512; x=1744756312;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAWzVkguP8Oqw2TYk2JCRWfNXIScPDbjXxeh1BiAU14=;
        b=asY5+gGCVLftock1qdWhMel2bCJuKiennhT8sXRSYQD6Q1Xu8vIvzBC22SP25b9Ivx
         a7HdnZOdQ4npbzhzxKuWZruAlKwqqXc9Kg1tTHUidyAnY38Vng1fli4+4JplMQNXE8bx
         TfR/ZYDwXptE13UpBHOPCOrHIz0K7QRkGoADcWrVexwvkqLf2avcaxJ8/CQXWUdFh/6a
         qag0ayHd3tPbVLWygN3sqyjr9cBt0WDGQ3DXUM8ug2gKPwSVg2znRpzBOCXxbJ9IgO9A
         38pGC5tZmmlJNLZWkLhGrY7zpO5dYI+pZOzPMyrzDKag4le217znkF/B+p4mEHN/kfe7
         NCrg==
X-Forwarded-Encrypted: i=1; AJvYcCWzpYthaeaV26n1ufwdkkXFjRwFY22wuDG1cFCLcHSb4krX7PEbH713DDpE+rluwnIZxgyuTU9ULBg5tC85Mpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qVou0TNZ00lMUIVjrSU1QJWVKz8Y9B0NhrE7mbYt/InC0hd1
	FrzAapB/2r80xWTjOHLSneGgheDM3c1dBCFZ+BmNjSLGE8zJgl7ZjlvxcDZp0ttmAYjriC6ocf3
	0
X-Gm-Gg: ASbGncusYHOiM0zDIekc5B25h8UhyP+jFkAmdn84ogiaxkfs2Y6A2tj8htW8mB1O5GJ
	jR+c7kCiRPWwITxPDEO9ajFcjzdhwz9cckG0goOvOh/mc1FJKIZEKUdCIehNWusi2CZxpS0fELX
	/CoyMlClUruQ0L1tjBIQe55U2tN5/qGzHsV6bIfw/QNuYGpCbfyCTC140NoLRPL9WwVY9VsgMeI
	KnOKqu6Cj34jO/Hbnhl+K1X6HnCPwtIBvgZnqk9V/8Lngrzw/BBfx9WSCNCnHn2Ww97ywGGTYjB
	MXj3N3VwVz6YGvnFPGvclz17Et6mdNGl6d7+YmD2tCis2L8CRtDFloao4DSmpJ0N5w==
X-Google-Smtp-Source: AGHT+IEfU144XCFxHWsCH0yxmIdhaFa8gc+53jrOeBtBx03pWvxKk+tMbW+YaftBfnJpMNV8mVT1+g==
X-Received: by 2002:a05:6602:29aa:b0:85e:1ee9:1c18 with SMTP id ca18e2360f4ac-86161281c7fmr113057939f.9.1744151511647;
        Tue, 08 Apr 2025 15:31:51 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f45087f8sm701807173.140.2025.04.08.15.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:31:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------MZJPVxq8LCD2OpAvMYg7TYnf"
Message-ID: <a39f11cb-a88e-4275-9fe7-8a000ccdefd7@linuxfoundation.org>
Date: Tue, 8 Apr 2025 16:31:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kunit fixes update for Linux 6.15-rc2

This is a multi-part message in MIME format.
--------------MZJPVxq8LCD2OpAvMYg7TYnf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kunit fixes update for Linux 6.15-rc2

Fixes tool to report test count in case of a late test plan when tests
are specified before the test plan. Fixes spelling error in the commit
that went into 6.15-rc1.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.15-rc2

for you to fetch changes up to d1be0cf3b8aeae75bc8fff5b7a3e01ebfe276008:

   kunit: Spelling s/slowm/slow/ (2025-04-08 14:57:24 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-6.15-rc2

Fixes tool to report test count in case of a late test plan when tests
are specified before the test plan. Fixes spelling error in the commit
that went into 6.15-rc1.

----------------------------------------------------------------
Geert Uytterhoeven (1):
       kunit: Spelling s/slowm/slow/

Rae Moar (1):
       kunit: tool: fix count of tests if late test plan

  include/kunit/test.h                   | 2 +-
  tools/testing/kunit/kunit_parser.py    | 4 ++++
  tools/testing/kunit/kunit_tool_test.py | 4 ++--
  3 files changed, 7 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------MZJPVxq8LCD2OpAvMYg7TYnf
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-6.15-rc2.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-6.15-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUva3VuaXQvdGVzdC5oIGIvaW5jbHVkZS9rdW5pdC90ZXN0
LmgKaW5kZXggMGZmYjk3Yzc4NTY2Li4zOWM3NjhmODdkYzkgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUva3VuaXQvdGVzdC5oCisrKyBiL2luY2x1ZGUva3VuaXQvdGVzdC5oCkBAIC02Nyw3ICs2
Nyw3IEBAIGVudW0ga3VuaXRfc3RhdHVzIHsKIAogLyoKICAqIFNwZWVkIEF0dHJpYnV0ZSBp
cyBzdG9yZWQgYXMgYW4gZW51bSBhbmQgc2VwYXJhdGVkIGludG8gY2F0ZWdvcmllcyBvZgot
ICogc3BlZWQ6IHZlcnlfc2xvd20sIHNsb3csIGFuZCBub3JtYWwuIFRoZXNlIHNwZWVkcyBh
cmUgcmVsYXRpdmUgdG8KKyAqIHNwZWVkOiB2ZXJ5X3Nsb3csIHNsb3csIGFuZCBub3JtYWwu
IFRoZXNlIHNwZWVkcyBhcmUgcmVsYXRpdmUgdG8KICAqIG90aGVyIEtVbml0IHRlc3RzLgog
ICoKICAqIE5vdGU6IHVuc2V0IHNwZWVkIGF0dHJpYnV0ZSBhY3RzIGFzIGRlZmF1bHQgb2Yg
S1VOSVRfU1BFRURfTk9STUFMLgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9rdW5pdC9r
dW5pdF9wYXJzZXIucHkgYi90b29scy90ZXN0aW5nL2t1bml0L2t1bml0X3BhcnNlci5weQpp
bmRleCBkYTUzYTcwOTc3M2EuLmMxNzY0ODczNTZlNiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVz
dGluZy9rdW5pdC9rdW5pdF9wYXJzZXIucHkKKysrIGIvdG9vbHMvdGVzdGluZy9rdW5pdC9r
dW5pdF9wYXJzZXIucHkKQEAgLTgwOSw2ICs4MDksMTAgQEAgZGVmIHBhcnNlX3Rlc3QobGlu
ZXM6IExpbmVTdHJlYW0sIGV4cGVjdGVkX251bTogaW50LCBsb2c6IExpc3Rbc3RyXSwgaXNf
c3VidGVzdDoKIAkJdGVzdC5sb2cuZXh0ZW5kKHBhcnNlX2RpYWdub3N0aWMobGluZXMpKQog
CQlpZiB0ZXN0Lm5hbWUgIT0gIiIgYW5kIG5vdCBwZWVrX3Rlc3RfbmFtZV9tYXRjaChsaW5l
cywgdGVzdCk6CiAJCQl0ZXN0LmFkZF9lcnJvcihwcmludGVyLCAnbWlzc2luZyBzdWJ0ZXN0
IHJlc3VsdCBsaW5lIScpCisJCWVsaWYgbm90IGxpbmVzOgorCQkJcHJpbnRfbG9nKHRlc3Qu
bG9nLCBwcmludGVyKQorCQkJdGVzdC5zdGF0dXMgPSBUZXN0U3RhdHVzLk5PX1RFU1RTCisJ
CQl0ZXN0LmFkZF9lcnJvcihwcmludGVyLCAnTm8gbW9yZSB0ZXN0IHJlc3VsdHMhJykKIAkJ
ZWxzZToKIAkJCXBhcnNlX3Rlc3RfcmVzdWx0KGxpbmVzLCB0ZXN0LCBleHBlY3RlZF9udW0s
IHByaW50ZXIpCiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXRfdG9v
bF90ZXN0LnB5IGIvdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdF90b29sX3Rlc3QucHkKaW5k
ZXggNWZmNGY2ZmZkODczLi5iYmJhOTIxZTBlYWMgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcva3VuaXQva3VuaXRfdG9vbF90ZXN0LnB5CisrKyBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQv
a3VuaXRfdG9vbF90ZXN0LnB5CkBAIC0zNzEsOCArMzcxLDggQEAgY2xhc3MgS1VuaXRQYXJz
ZXJUZXN0KHVuaXR0ZXN0LlRlc3RDYXNlKToKIAkJIiIiCiAJCXJlc3VsdCA9IGt1bml0X3Bh
cnNlci5wYXJzZV9ydW5fdGVzdHMob3V0cHV0LnNwbGl0bGluZXMoKSwgc3Rkb3V0KQogCQkj
IE1pc3NpbmcgdGVzdCByZXN1bHRzIGFmdGVyIHRlc3QgcGxhbiBzaG91bGQgYWxlcnQgYSBz
dXNwZWN0ZWQgdGVzdCBjcmFzaC4KLQkJc2VsZi5hc3NlcnRFcXVhbChrdW5pdF9wYXJzZXIu
VGVzdFN0YXR1cy5URVNUX0NSQVNIRUQsIHJlc3VsdC5zdGF0dXMpCi0JCXNlbGYuYXNzZXJ0
RXF1YWwocmVzdWx0LmNvdW50cywga3VuaXRfcGFyc2VyLlRlc3RDb3VudHMocGFzc2VkPTEs
IGNyYXNoZWQ9MSwgZXJyb3JzPTEpKQorCQlzZWxmLmFzc2VydEVxdWFsKGt1bml0X3BhcnNl
ci5UZXN0U3RhdHVzLlNVQ0NFU1MsIHJlc3VsdC5zdGF0dXMpCisJCXNlbGYuYXNzZXJ0RXF1
YWwocmVzdWx0LmNvdW50cywga3VuaXRfcGFyc2VyLlRlc3RDb3VudHMocGFzc2VkPTEsIGVy
cm9ycz0yKSkKIAogZGVmIGxpbmVfc3RyZWFtX2Zyb21fc3RycyhzdHJzOiBJdGVyYWJsZVtz
dHJdKSAtPiBrdW5pdF9wYXJzZXIuTGluZVN0cmVhbToKIAlyZXR1cm4ga3VuaXRfcGFyc2Vy
LkxpbmVTdHJlYW0oZW51bWVyYXRlKHN0cnMsIHN0YXJ0PTEpKQo=

--------------MZJPVxq8LCD2OpAvMYg7TYnf--

