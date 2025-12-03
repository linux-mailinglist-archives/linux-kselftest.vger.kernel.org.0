Return-Path: <linux-kselftest+bounces-46923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 445F5C9D636
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 01:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74DA9349F4B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 00:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93977F4F1;
	Wed,  3 Dec 2025 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O7FYb/gT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF2DDA9
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764720565; cv=none; b=HUqRb0RbpZd2T2nFLtxNQIoXAvvFfjeVHXdVIkId1hcPZBaOVrCy3Nfe0sxqcGGn7/uiFSDNsoFI45r9SWx0ckiCyTKSC9t/JxToOanwkAKo7ZVo+ceF4V6NVCosf3ex8y3yghyF4KqUfd142FlI+C42ZHSStTGfyH2oFE7sOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764720565; c=relaxed/simple;
	bh=xeKqt9Dq2ymyV3JhniKfMNQG0mC4Te9nx3Jm7TvcMzw=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=jizXQFgIAg0q8m94/PIeRo0WQKVWo9Ohzw9M/Zi7BFJjMD0EVke9dQr4t1F81Gcdg2rAHj99YDXBG8MsfBaCzW5k6i2MP+mkdR59aBgW82eqPvyyRpJo8sP9VbAmCD+wdiWfip9s/CuF+Lp5rJlgN3HTpOyKvb2LFVqmu6oK0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O7FYb/gT; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-657a6028fbbso2538643eaf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764720562; x=1765325362; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GhwfpKLYGKS6ru5im0OBhvip0NHp3jvO5HelP2bLo5Q=;
        b=O7FYb/gTh/s68QyCrflwNoUOLzxN7wuZUIfMYVTdT0KWgnf4cxBM9ZsFolQZPyeN5u
         nfpcKFKvlPYqkHMG0FC0PiQ5VpjsFg5bmf6RcvG8w/p9N3CUuwTeHWUdLJIIngvqv/wB
         ZbkFbJDHGGCACppAneQR5n/F2puv/2vNoCkQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764720562; x=1765325362;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhwfpKLYGKS6ru5im0OBhvip0NHp3jvO5HelP2bLo5Q=;
        b=eV1Q+gPJmX50WH1ot/+LAj7MU+FzhQCdS4rXSNXPvX/le2QGBdAOOV3rU5/j2hipOv
         xyQAsD8yG25F+QPW3raYN/LZbJp4NLYiJszkCQ/WT5MhzxSeDfn512fuKAoWCTXUPUBG
         u2XTZQtnyoKCM6U3ZFzcbzEhxot7os1Ih4Ugvfs1UnYrKfgsZxdSABJ9bip8PuaYYwx8
         WPBQKn/N8XVTUNQOzJrhUK22fEL4fFdMcihfOqwwaQWZ07DEImC50wcYkcpEnFXGRRVo
         R55RazBgoj7JNy7CMmAp5GVnHKXZONf9NnLc/klps9lUurklt6dGZLagpRY2jrvEWC+K
         Oung==
X-Forwarded-Encrypted: i=1; AJvYcCVu9FLvIK2L5jYai/bg3PEVXQn4iw8t+I7luNC655DPR6NSr0nQOKkm37cYUl5EfJ9Dta4fBZsWzk8et4mFLTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6UOJVVFcXFk/dgzEzAV4rt46X9x09iqImqpJZ4inmR/n3KKy
	MZNmGEzsq0yWm9UWnGb903YVLXEk0cRzEvp3k0q/0d6RVhRuc5chIIO1WwNm+nA/b2E=
X-Gm-Gg: ASbGncufQDmmOV2/jghVEFoF8engOTZf0wPO+vlVIIG1iwfj3uR5eq/ewvVRnFTe1M8
	cmkOgc/8xur8g873ezcCxEkpVRudgdaMh6Lpx8GlNG99mW1akA2i7jPMngx3eWhMZRP2ygcPEfF
	3X+FbnNs2E1lJtmw50byDzEv9ejjZ6ukSs1nZYaecLeM1k1Zhb0fd9OUZtUuvJVCMc0LHxNR6EY
	/G77F9Fdruf/Y/9+loK0zAB6rSC+k77aIvNY6AteHmFOf/Z7xlcbvFC1EjCcSicYz9u+NT14v9U
	CNWLIqvAAvScgjVgIE6Gqe5+r1E+I41z5J3UppAH9a6rtkWLL2wq2k0PEWKOHCfUBdnwK0+GFtF
	XOLQnfS1SiYNaELCAZJMpbQu5kSO6EZgu06Pd5ZnI86F54YxKTPhvB14sNBXCayeCo9CabFcs1J
	vZyAYQX2a+zWbhp1qJOu+acZ8=
X-Google-Smtp-Source: AGHT+IG6YQP3Sj4Eiuhe3R+4v129Wr9Ib5mkU2m6kgymoTk4RK08ZpmV9kcWeIW4nhNiPoekvCzkvg==
X-Received: by 2002:a05:6820:1841:b0:657:5e6f:b9d7 with SMTP id 006d021491bc7-6597273875cmr318276eaf.6.1764720562372;
        Tue, 02 Dec 2025 16:09:22 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc3fb2sm4906921eaf.11.2025.12.02.16.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 16:09:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------AyD4x0IEd8dL6Ja01LztaufB"
Message-ID: <f2b2697b-3885-4631-8498-f07ac90d1485@linuxfoundation.org>
Date: Tue, 2 Dec 2025 17:09:20 -0700
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
 David Gow <davidgow@google.com>, Brendan Higgins
 <brendan.higgins@linux.dev>, raemoar63@gmail.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kunit next update for Linux 6.19-rc1

This is a multi-part message in MIME format.
--------------AyD4x0IEd8dL6Ja01LztaufB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following kunit next update for Linux 6.19-rc1.

Makes filter parameters configurable via Kconfig.
Adds description of kunit.enable parameter documentation.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.19-rc1

for you to fetch changes up to 7bc16e72ddb993d706f698c2f6cee694e485f557:

   kunit: Make filter parameters configurable via Kconfig (2025-11-14 11:02:34 -0700)

----------------------------------------------------------------
linux_kselftest-kunit-6.19-rc1

Makes filter parameters configurable via Kconfig.
Adds description of kunit.enable parameter documentation.

----------------------------------------------------------------
Thomas Weißschuh (1):
       kunit: Make filter parameters configurable via Kconfig

Yuya Ishikawa (1):
       Documentation: kunit: add description of kunit.enable parameter

  Documentation/dev-tools/kunit/run_manual.rst |  6 ++++++
  lib/kunit/Kconfig                            | 24 ++++++++++++++++++++++++
  lib/kunit/executor.c                         |  8 +++++---
  3 files changed, 35 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------AyD4x0IEd8dL6Ja01LztaufB
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-6.19-rc1.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-6.19-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3J1bl9tYW51YWwu
cnN0IGIvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvcnVuX21hbnVhbC5yc3QKaW5k
ZXggNjk5ZDkyODg1MDc1Li45OGU4ZDViMjg4MDggMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRp
b24vZGV2LXRvb2xzL2t1bml0L3J1bl9tYW51YWwucnN0CisrKyBiL0RvY3VtZW50YXRpb24v
ZGV2LXRvb2xzL2t1bml0L3J1bl9tYW51YWwucnN0CkBAIC0zNSw2ICszNSwxMiBAQCBvciBi
ZSBidWlsdCBpbnRvIHRoZSBrZXJuZWwuCiAJYSBnb29kIHdheSBvZiBxdWlja2x5IHRlc3Rp
bmcgZXZlcnl0aGluZyBhcHBsaWNhYmxlIHRvIHRoZSBjdXJyZW50CiAJY29uZmlnLgogCisJ
S1VuaXQgY2FuIGJlIGVuYWJsZWQgb3IgZGlzYWJsZWQgYXQgYm9vdCB0aW1lLCBhbmQgdGhp
cyBiZWhhdmlvciBpcworCWNvbnRyb2xsZWQgYnkgdGhlIGt1bml0LmVuYWJsZSBrZXJuZWwg
cGFyYW1ldGVyLgorCUJ5IGRlZmF1bHQsIGt1bml0LmVuYWJsZSBpcyBzZXQgdG8gMSBiZWNh
dXNlIEtVTklUX0RFRkFVTFRfRU5BQkxFRCBpcworCWVuYWJsZWQgYnkgZGVmYXVsdC4gVG8g
ZW5zdXJlIHRoYXQgdGVzdHMgYXJlIGV4ZWN1dGVkIGFzIGV4cGVjdGVkLAorCXZlcmlmeSB0
aGF0IGt1bml0LmVuYWJsZT0xIGF0IGJvb3QgdGltZS4KKwogT25jZSB3ZSBoYXZlIGJ1aWx0
IG91ciBrZXJuZWwgKGFuZC9vciBtb2R1bGVzKSwgaXQgaXMgc2ltcGxlIHRvIHJ1bgogdGhl
IHRlc3RzLiBJZiB0aGUgdGVzdHMgYXJlIGJ1aWx0LWluLCB0aGV5IHdpbGwgcnVuIGF1dG9t
YXRpY2FsbHkgb24gdGhlCiBrZXJuZWwgYm9vdC4gVGhlIHJlc3VsdHMgd2lsbCBiZSB3cml0
dGVuIHRvIHRoZSBrZXJuZWwgbG9nIChgYGRtZXNnYGApCmRpZmYgLS1naXQgYS9saWIva3Vu
aXQvS2NvbmZpZyBiL2xpYi9rdW5pdC9LY29uZmlnCmluZGV4IDdhNmFmMzYxZDJmYy4uNTBl
Y2Y1NWQyYjljIDEwMDY0NAotLS0gYS9saWIva3VuaXQvS2NvbmZpZworKysgYi9saWIva3Vu
aXQvS2NvbmZpZwpAQCAtOTMsNiArOTMsMzAgQEAgY29uZmlnIEtVTklUX0FVVE9SVU5fRU5B
QkxFRAogCSAgSW4gbW9zdCBjYXNlcyB0aGlzIHNob3VsZCBiZSBsZWZ0IGFzIFkuIE9ubHkg
aWYgYWRkaXRpb25hbCBvcHQtaW4KIAkgIGJlaGF2aW9yIGlzIG5lZWRlZCBzaG91bGQgdGhp
cyBiZSBzZXQgdG8gTi4KIAorY29uZmlnIEtVTklUX0RFRkFVTFRfRklMVEVSX0dMT0IKKwlz
dHJpbmcgIkRlZmF1bHQgdmFsdWUgb2YgdGhlIGZpbHRlcl9nbG9iIG1vZHVsZSBwYXJhbWV0
ZXIiCisJaGVscAorCSAgU2V0cyB0aGUgZGVmYXVsdCB2YWx1ZSBvZiBrdW5pdC5maWx0ZXJf
Z2xvYi4gSWYgc2V0IHRvIGEgbm9uLWVtcHR5CisJICBzdHJpbmcgb25seSBtYXRjaGluZyB0
ZXN0cyBhcmUgZXhlY3V0ZWQuCisKKwkgIElmIHVuc3VyZSwgbGVhdmUgZW1wdHkgc28gYWxs
IHRlc3RzIGFyZSBleGVjdXRlZC4KKworY29uZmlnIEtVTklUX0RFRkFVTFRfRklMVEVSCisJ
c3RyaW5nICJEZWZhdWx0IHZhbHVlIG9mIHRoZSBmaWx0ZXIgbW9kdWxlIHBhcmFtZXRlciIK
KwloZWxwCisJICBTZXRzIHRoZSBkZWZhdWx0IHZhbHVlIG9mIGt1bml0LmZpbHRlci4gSWYg
c2V0IHRvIGEgbm9uLWVtcHR5CisJICBzdHJpbmcgb25seSBtYXRjaGluZyB0ZXN0cyBhcmUg
ZXhlY3V0ZWQuCisKKwkgIElmIHVuc3VyZSwgbGVhdmUgZW1wdHkgc28gYWxsIHRlc3RzIGFy
ZSBleGVjdXRlZC4KKworY29uZmlnIEtVTklUX0RFRkFVTFRfRklMVEVSX0FDVElPTgorCXN0
cmluZyAiRGVmYXVsdCB2YWx1ZSBvZiB0aGUgZmlsdGVyX2FjdGlvbiBtb2R1bGUgcGFyYW1l
dGVyIgorCWhlbHAKKwkgIFNldHMgdGhlIGRlZmF1bHQgdmFsdWUgb2Yga3VuaXQuZmlsdGVy
X2FjdGlvbi4gSWYgc2V0IHRvIGEgbm9uLWVtcHR5CisJICBzdHJpbmcgb25seSBtYXRjaGlu
ZyB0ZXN0cyBhcmUgZXhlY3V0ZWQuCisKKwkgIElmIHVuc3VyZSwgbGVhdmUgZW1wdHkgc28g
YWxsIHRlc3RzIGFyZSBleGVjdXRlZC4KKwogY29uZmlnIEtVTklUX0RFRkFVTFRfVElNRU9V
VAogCWludCAiRGVmYXVsdCB2YWx1ZSBvZiB0aGUgdGltZW91dCBtb2R1bGUgcGFyYW1ldGVy
IgogCWRlZmF1bHQgMzAwCmRpZmYgLS1naXQgYS9saWIva3VuaXQvZXhlY3V0b3IuYyBiL2xp
Yi9rdW5pdC9leGVjdXRvci5jCmluZGV4IDAwNjFkNGM3ZTM1MS4uMDJmZjM4MGFiNzkzIDEw
MDY0NAotLS0gYS9saWIva3VuaXQvZXhlY3V0b3IuYworKysgYi9saWIva3VuaXQvZXhlY3V0
b3IuYwpAQCAtNDUsOSArNDUsMTEgQEAgYm9vbCBrdW5pdF9hdXRvcnVuKHZvaWQpCiAJcmV0
dXJuIGF1dG9ydW5fcGFyYW07CiB9CiAKLXN0YXRpYyBjaGFyICpmaWx0ZXJfZ2xvYl9wYXJh
bTsKLXN0YXRpYyBjaGFyICpmaWx0ZXJfcGFyYW07Ci1zdGF0aWMgY2hhciAqZmlsdGVyX2Fj
dGlvbl9wYXJhbTsKKyNkZWZpbmUgUEFSQU1fRlJPTV9DT05GSUcoY29uZmlnKSAoY29uZmln
WzBdID8gY29uZmlnIDogTlVMTCkKKworc3RhdGljIGNoYXIgKmZpbHRlcl9nbG9iX3BhcmFt
ID0gUEFSQU1fRlJPTV9DT05GSUcoQ09ORklHX0tVTklUX0RFRkFVTFRfRklMVEVSX0dMT0Ip
Oworc3RhdGljIGNoYXIgKmZpbHRlcl9wYXJhbSA9IFBBUkFNX0ZST01fQ09ORklHKENPTkZJ
R19LVU5JVF9ERUZBVUxUX0ZJTFRFUik7CitzdGF0aWMgY2hhciAqZmlsdGVyX2FjdGlvbl9w
YXJhbSA9IFBBUkFNX0ZST01fQ09ORklHKENPTkZJR19LVU5JVF9ERUZBVUxUX0ZJTFRFUl9B
Q1RJT04pOwogCiBtb2R1bGVfcGFyYW1fbmFtZWQoZmlsdGVyX2dsb2IsIGZpbHRlcl9nbG9i
X3BhcmFtLCBjaGFycCwgMDYwMCk7CiBNT0RVTEVfUEFSTV9ERVNDKGZpbHRlcl9nbG9iLAo=


--------------AyD4x0IEd8dL6Ja01LztaufB--

