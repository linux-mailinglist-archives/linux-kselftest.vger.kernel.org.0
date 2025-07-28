Return-Path: <linux-kselftest+bounces-38033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A09B14373
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 22:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D58B3B34EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70B21E0BE;
	Mon, 28 Jul 2025 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LzH0f4e9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DCB1E260A
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Jul 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735205; cv=none; b=UDOyUsD4cJ3nPf6FX9sZQC+C/Idkeue8TvfMYVzFnDcYNjMWjJFHHbO2QEgqLoaNdpIXwUq640KW/HF37YcaHx7hD/8sXZsaRoOLSvSF4qP/mwvOYFutAuN5MYVDhUpzbas3fxS5J1sl1tbY0o8fArLcwVMjN4DjIups4AXYeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735205; c=relaxed/simple;
	bh=52oduIFva2cYvWbNQ7B7RwNnlDj1i/O2w6QfwrZm1wc=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=RLDJ6o3OgURg+ERvKh3EvvabKM8mugqxvg4EoSkJmeGVPe7aBikBcd306s5ktJOqMfdkQyimLsTmFSWBbnFepr5g3vsWQfNreyAj1XVlbwbFyce7Gmk4TMjC9NF19+lKdhdloxuc6IlS9aHHlzdneRQM7sh0jCpnHzqVUAUOahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LzH0f4e9; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e3c34a9b4cso50255425ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jul 2025 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753735201; x=1754340001; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eIAC0+6/+Fs8tx9/gAGcgfUW7PLeLo1EPycam2tckSw=;
        b=LzH0f4e9qrrRpN3BNPrALxJizZetvfBxkzxbrPFH9aTfq8dPEyAoHRJZxoA7vN9wEa
         sApmAViGgOrPuiLu4q5K+Ci/awwczeF9pxzUoE16siDL4TiU2Ofp2QKtOsV0JWSiOjKs
         Y5svqLoxP3nUzcSwt3Nhiw5jlhAYjThLsqqrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753735201; x=1754340001;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIAC0+6/+Fs8tx9/gAGcgfUW7PLeLo1EPycam2tckSw=;
        b=O7VGeoaWfG0IYl9+C28o81ozBSQwUyZPDtJTaFEuQFsUL4QgUrJdCUdD4rpgOkpnkX
         O72ITLRpG5wzxfSBPapZpmVQkrWbCbix0Rur622Z5a93xWJmxoqtI8NjtJ6iTgzD0x6e
         zwS8bpyyxWz0B5zA2wEjAI9iw5Z7ntqSj2yKLzMlsDzloq/98bzRd40NYmgP8YENSfZf
         LQMrBf+YGCeFGFkB36+KVOhN4NW8IRqa8O1AQtwbsVoRDcR58M9F0Ic5Lt7ioLrF4IH8
         iy33Puew0XtZhKonMeMKeZS7/KIA1K92KIthIy54f8++kkF/yao+asoNDEhxhjB1vcHU
         x31A==
X-Forwarded-Encrypted: i=1; AJvYcCX21OvjX74oeS+TQd5Jz7Ep2JDtl/dWaBxZCkIAcr9+KRE8E7K8RPPeqvG8yi6GeuyUOyn3yUD7fl++0vdSAT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgDMJxl63zvlFhvj5td3v3zlDVvXHO9xYWEjkHBR4+iCs8ZL/
	JCH6J9SljOay/uNEQ0EA+SxAGo+rSITnpt8q1KcF+zZInjwcxF4VT2j2ktp5CUs8s2Y=
X-Gm-Gg: ASbGncsUz0KVfTsu3xWcBKr704zn0fw4TR+seoBDwTvsRVWnbeWOltJEq3NrRZrvroX
	IW6MEi7R5IrOhRAgs9Ht/sEuQDDAiIXaclpJQLfIvBGenv2EWx+FWBS3qgVpdFzRMXwZNVImeEx
	OVtdNIXR4u87Vd1fpMpnF5WIwosBMBkLYb625xrLVrOsrc7u9pUIKyFbRL6PdG89HlZZn5PnwIL
	k5LuJcdYCHnS8VYNmLa3FWjI4Dn+FaCsCJvrbANIqw58KgETXdjqehlfcInQD3xeHc6Rb11lnwJ
	OTbu8tmPPMoV2hJfnK7bMLshSJ2YH2zCeOUMAV964szMX528hjIA/rvceteaVfbfH/wlU3mIuN/
	X4hE7QJXC4qketH+wrSChMy5wO+WKFpRjRAoDpmYA8VdY
X-Google-Smtp-Source: AGHT+IG53/PsKSQ1GnfAYR6peAOj6aOj2Lz1KQjefryx8o9NPP/bcR9MJQ2pnQlOLSA9xfvK0bO73A==
X-Received: by 2002:a92:cd81:0:b0:3e2:9fa7:a60a with SMTP id e9e14a558f8ab-3e3c52414bfmr246400755ab.3.1753735201310;
        Mon, 28 Jul 2025 13:40:01 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3e6f3125csm3999535ab.50.2025.07.28.13.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 13:40:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------o47LyHuuA4GgNm4uUNMXT8p0"
Message-ID: <c08408c3-a686-444c-9814-42d8c395d3ad@linuxfoundation.org>
Date: Mon, 28 Jul 2025 14:40:00 -0600
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
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kunit next update for Linux 6.17-rc1

This is a multi-part message in MIME format.
--------------o47LyHuuA4GgNm4uUNMXT8p0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following kunit next update for Linux 6.17-rc1.

Corrects MODULE_IMPORT_NS() syntax documentation, makes kunit_test timeout
configurable via a module parameter and a Kconfig option, fixes longest
symbol length test, adds a test for static stub, and adjusts kunit_test
timeout based on test_{suite,case} speed.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.17-rc1

for you to fetch changes up to 34db4fba81916a2001d7a503dfcf718c08ed5c42:

   kunit: fix longest symbol length test (2025-07-10 14:02:07 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-6.17-rc1

Corrects MODULE_IMPORT_NS() syntax documentation, makes kunit_test timeout
configurable via a module parameter and a Kconfig option, fixes longest
symbol length test, adds a test for static stub, and adjusts kunit_test
timeout based on test_{suite,case} speed.

----------------------------------------------------------------
Brian Norris (1):
       Documentation: kunit: Correct MODULE_IMPORT_NS() syntax

Marie Zhussupova (1):
       kunit: Make default kunit_test timeout configurable via both a module parameter and a Kconfig option

Sergio González Collado (1):
       kunit: fix longest symbol length test

Tzung-Bi Shih (1):
       kunit: Add test for static stub

Ujwal Jain (1):
       kunit: Adjust kunit_test timeout based on test_{suite,case} speed

  Documentation/dev-tools/kunit/usage.rst |  2 +-
  include/kunit/try-catch.h               |  1 +
  lib/Kconfig.debug                       |  1 +
  lib/kunit/Kconfig                       | 13 ++++++++
  lib/kunit/kunit-test.c                  | 55 ++++++++++++++++++++++++++++++---
  lib/kunit/test.c                        | 47 ++++++++++++++++++++++++++--
  lib/kunit/try-catch-impl.h              |  4 ++-
  lib/kunit/try-catch.c                   | 29 ++---------------
  lib/tests/longest_symbol_kunit.c        |  3 +-
  9 files changed, 118 insertions(+), 37 deletions(-)
----------------------------------------------------------------
--------------o47LyHuuA4GgNm4uUNMXT8p0
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-6.17-rc1.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-6.17-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3VzYWdlLnJzdCBi
L0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3VzYWdlLnJzdAppbmRleCAwMzhmNDgw
MDc0ZmQuLjA2NmVjZGExZGQ5OCAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9v
bHMva3VuaXQvdXNhZ2UucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0
L3VzYWdlLnJzdApAQCAtNjk5LDcgKzY5OSw3IEBAIHRoZSB0ZW1wbGF0ZSBiZWxvdy4KIAkj
aW5jbHVkZSA8a3VuaXQvdmlzaWJpbGl0eS5oPgogCSNpbmNsdWRlIDxteV9maWxlLmg+CiAJ
Li4uCi0JTU9EVUxFX0lNUE9SVF9OUyhFWFBPUlRFRF9GT1JfS1VOSVRfVEVTVElORyk7CisJ
TU9EVUxFX0lNUE9SVF9OUygiRVhQT1JURURfRk9SX0tVTklUX1RFU1RJTkciKTsKIAkuLi4K
IAkvLyBVc2UgZG9faW50ZXJlc3RpbmdfdGhpbmcoKSBpbiB0ZXN0cwogCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2t1bml0L3RyeS1jYXRjaC5oIGIvaW5jbHVkZS9rdW5pdC90cnktY2F0Y2gu
aAppbmRleCA3Yzk2NmExYWRiZDMuLmQ0ZTFhNWI5OGVkNiAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9rdW5pdC90cnktY2F0Y2guaAorKysgYi9pbmNsdWRlL2t1bml0L3RyeS1jYXRjaC5oCkBA
IC00Nyw2ICs0Nyw3IEBAIHN0cnVjdCBrdW5pdF90cnlfY2F0Y2ggewogCWludCB0cnlfcmVz
dWx0OwogCWt1bml0X3RyeV9jYXRjaF9mdW5jX3QgdHJ5OwogCWt1bml0X3RyeV9jYXRjaF9m
dW5jX3QgY2F0Y2g7CisJdW5zaWduZWQgbG9uZyB0aW1lb3V0OwogCXZvaWQgKmNvbnRleHQ7
CiB9OwogCmRpZmYgLS1naXQgYS9saWIvS2NvbmZpZy5kZWJ1ZyBiL2xpYi9LY29uZmlnLmRl
YnVnCmluZGV4IGViZTMzMTgxYjZlNi4uNGE3NWE1MjgwM2I2IDEwMDY0NAotLS0gYS9saWIv
S2NvbmZpZy5kZWJ1ZworKysgYi9saWIvS2NvbmZpZy5kZWJ1ZwpAQCAtMjg4NSw2ICsyODg1
LDcgQEAgY29uZmlnIEZPUlRJRllfS1VOSVRfVEVTVAogY29uZmlnIExPTkdFU1RfU1lNX0tV
TklUX1RFU1QKIAl0cmlzdGF0ZSAiVGVzdCB0aGUgbG9uZ2VzdCBzeW1ib2wgcG9zc2libGUi
IGlmICFLVU5JVF9BTExfVEVTVFMKIAlkZXBlbmRzIG9uIEtVTklUICYmIEtQUk9CRVMKKwlk
ZXBlbmRzIG9uICFQUkVGSVhfU1lNQk9MUyAmJiAhQ0ZJX0NMQU5HICYmICFHQ09WX0tFUk5F
TAogCWRlZmF1bHQgS1VOSVRfQUxMX1RFU1RTCiAJaGVscAogCSAgVGVzdHMgdGhlIGxvbmdl
c3Qgc3ltYm9sIHBvc3NpYmxlCmRpZmYgLS1naXQgYS9saWIva3VuaXQvS2NvbmZpZyBiL2xp
Yi9rdW5pdC9LY29uZmlnCmluZGV4IGE5Nzg5N2VkZDk2NC4uYzEwZWRlNGIxZDIyIDEwMDY0
NAotLS0gYS9saWIva3VuaXQvS2NvbmZpZworKysgYi9saWIva3VuaXQvS2NvbmZpZwpAQCAt
OTMsNCArOTMsMTcgQEAgY29uZmlnIEtVTklUX0FVVE9SVU5fRU5BQkxFRAogCSAgSW4gbW9z
dCBjYXNlcyB0aGlzIHNob3VsZCBiZSBsZWZ0IGFzIFkuIE9ubHkgaWYgYWRkaXRpb25hbCBv
cHQtaW4KIAkgIGJlaGF2aW9yIGlzIG5lZWRlZCBzaG91bGQgdGhpcyBiZSBzZXQgdG8gTi4K
IAorY29uZmlnIEtVTklUX0RFRkFVTFRfVElNRU9VVAorCWludCAiRGVmYXVsdCB2YWx1ZSBv
ZiB0aGUgdGltZW91dCBtb2R1bGUgcGFyYW1ldGVyIgorCWRlZmF1bHQgMzAwCisJaGVscAor
CSAgU2V0cyB0aGUgZGVmYXVsdCB0aW1lb3V0LCBpbiBzZWNvbmRzLCBmb3IgS3VuaXQgdGVz
dCBjYXNlcy4gVGhpcyB2YWx1ZQorCSAgaXMgZnVydGhlciBtdWx0aXBsaWVkIGJ5IGEgZmFj
dG9yIGRldGVybWluZWQgYnkgdGhlIGFzc2lnbmVkIHNwZWVkCisJICBzZXR0aW5nOiAxeCBm
b3IgYERFRkFVTFRgLCAzeCBmb3IgYEtVTklUX1NQRUVEX1NMT1dgLCBhbmQgMTJ4IGZvcgor
CSAgYEtVTklUX1NQRUVEX1ZFUllfU0xPV2AuIFRoaXMgYWxsb3dzIHNsb3dlciB0ZXN0cyBv
biBzbG93ZXIgbWFjaGluZXMKKwkgIHN1ZmZpY2llbnQgdGltZSB0byBjb21wbGV0ZS4KKwor
CSAgSWYgdW5zdXJlLCB0aGUgZGVmYXVsdCB0aW1lb3V0IG9mIDMwMCBzZWNvbmRzIGlzIHN1
aXRhYmxlIGZvciBtb3N0CisJICBjYXNlcy4KKwogZW5kaWYgIyBLVU5JVApkaWZmIC0tZ2l0
IGEvbGliL2t1bml0L2t1bml0LXRlc3QuYyBiL2xpYi9rdW5pdC9rdW5pdC10ZXN0LmMKaW5k
ZXggZDljNzgxYzg1OWZkLi44YzAxZWFiZDRlYWYgMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9r
dW5pdC10ZXN0LmMKKysrIGIvbGliL2t1bml0L2t1bml0LXRlc3QuYwpAQCAtOCw2ICs4LDcg
QEAKICNpbmNsdWRlICJsaW51eC9nZnBfdHlwZXMuaCIKICNpbmNsdWRlIDxrdW5pdC90ZXN0
Lmg+CiAjaW5jbHVkZSA8a3VuaXQvdGVzdC1idWcuaD4KKyNpbmNsdWRlIDxrdW5pdC9zdGF0
aWNfc3R1Yi5oPgogCiAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CiAjaW5jbHVkZSA8a3Vu
aXQvZGV2aWNlLmg+CkBAIC00Myw3ICs0NCw4IEBAIHN0YXRpYyB2b2lkIGt1bml0X3Rlc3Rf
dHJ5X2NhdGNoX3N1Y2Nlc3NmdWxfdHJ5X25vX2NhdGNoKHN0cnVjdCBrdW5pdCAqdGVzdCkK
IAlrdW5pdF90cnlfY2F0Y2hfaW5pdCh0cnlfY2F0Y2gsCiAJCQkgICAgIHRlc3QsCiAJCQkg
ICAgIGt1bml0X3Rlc3Rfc3VjY2Vzc2Z1bF90cnksCi0JCQkgICAgIGt1bml0X3Rlc3Rfbm9f
Y2F0Y2gpOworCQkJICAgICBrdW5pdF90ZXN0X25vX2NhdGNoLAorCQkJICAgICAzMDAgKiBt
c2Vjc190b19qaWZmaWVzKE1TRUNfUEVSX1NFQykpOwogCWt1bml0X3RyeV9jYXRjaF9ydW4o
dHJ5X2NhdGNoLCB0ZXN0KTsKIAogCUtVTklUX0VYUEVDVF9UUlVFKHRlc3QsIGN0eC0+ZnVu
Y3Rpb25fY2FsbGVkKTsKQEAgLTc1LDcgKzc3LDggQEAgc3RhdGljIHZvaWQga3VuaXRfdGVz
dF90cnlfY2F0Y2hfdW5zdWNjZXNzZnVsX3RyeV9kb2VzX2NhdGNoKHN0cnVjdCBrdW5pdCAq
dGVzdCkKIAlrdW5pdF90cnlfY2F0Y2hfaW5pdCh0cnlfY2F0Y2gsCiAJCQkgICAgIHRlc3Qs
CiAJCQkgICAgIGt1bml0X3Rlc3RfdW5zdWNjZXNzZnVsX3RyeSwKLQkJCSAgICAga3VuaXRf
dGVzdF9jYXRjaCk7CisJCQkgICAgIGt1bml0X3Rlc3RfY2F0Y2gsCisJCQkgICAgIDMwMCAq
IG1zZWNzX3RvX2ppZmZpZXMoTVNFQ19QRVJfU0VDKSk7CiAJa3VuaXRfdHJ5X2NhdGNoX3J1
bih0cnlfY2F0Y2gsIHRlc3QpOwogCiAJS1VOSVRfRVhQRUNUX1RSVUUodGVzdCwgY3R4LT5m
dW5jdGlvbl9jYWxsZWQpOwpAQCAtMTI5LDcgKzEzMiw4IEBAIHN0YXRpYyB2b2lkIGt1bml0
X3Rlc3RfZmF1bHRfbnVsbF9kZXJlZmVyZW5jZShzdHJ1Y3Qga3VuaXQgKnRlc3QpCiAJa3Vu
aXRfdHJ5X2NhdGNoX2luaXQodHJ5X2NhdGNoLAogCQkJICAgICB0ZXN0LAogCQkJICAgICBr
dW5pdF90ZXN0X251bGxfZGVyZWZlcmVuY2UsCi0JCQkgICAgIGt1bml0X3Rlc3RfY2F0Y2gp
OworCQkJICAgICBrdW5pdF90ZXN0X2NhdGNoLAorCQkJICAgICAzMDAgKiBtc2Vjc190b19q
aWZmaWVzKE1TRUNfUEVSX1NFQykpOwogCWt1bml0X3RyeV9jYXRjaF9ydW4odHJ5X2NhdGNo
LCB0ZXN0KTsKIAogCUtVTklUX0VYUEVDVF9FUSh0ZXN0LCB0cnlfY2F0Y2gtPnRyeV9yZXN1
bHQsIC1FSU5UUik7CkBAIC04NjgsMTAgKzg3Miw1MyBAQCBzdGF0aWMgc3RydWN0IGt1bml0
X3N1aXRlIGt1bml0X2N1cnJlbnRfdGVzdF9zdWl0ZSA9IHsKIAkudGVzdF9jYXNlcyA9IGt1
bml0X2N1cnJlbnRfdGVzdF9jYXNlcywKIH07CiAKK3N0YXRpYyB2b2lkIGt1bml0X3N0dWJf
dGVzdChzdHJ1Y3Qga3VuaXQgKnRlc3QpCit7CisJc3RydWN0IGt1bml0IGZha2VfdGVzdDsK
Kwljb25zdCB1bnNpZ25lZCBsb25nIGZha2VfcmVhbF9mbl9hZGRyID0gMHgxMjM0OworCWNv
bnN0IHVuc2lnbmVkIGxvbmcgZmFrZV9yZXBsYWNlbWVudF9hZGRyID0gMHg1Njc4OworCXN0
cnVjdCBrdW5pdF9yZXNvdXJjZSAqcmVzOworCXN0cnVjdCB7CisJCXZvaWQgKnJlYWxfZm5f
YWRkcjsKKwkJdm9pZCAqcmVwbGFjZW1lbnRfYWRkcjsKKwl9ICpzdHViX2N0eDsKKworCWt1
bml0X2luaXRfdGVzdCgmZmFrZV90ZXN0LCAia3VuaXRfc3R1Yl9mYWtlX3Rlc3QiLCBOVUxM
KTsKKwlLVU5JVF9BU1NFUlRfRVEodGVzdCwgZmFrZV90ZXN0LnN0YXR1cywgS1VOSVRfU1VD
Q0VTUyk7CisJS1VOSVRfQVNTRVJUX0VRKHRlc3QsIGxpc3RfY291bnRfbm9kZXMoJmZha2Vf
dGVzdC5yZXNvdXJjZXMpLCAwKTsKKworCV9fa3VuaXRfYWN0aXZhdGVfc3RhdGljX3N0dWIo
JmZha2VfdGVzdCwgKHZvaWQgKilmYWtlX3JlYWxfZm5fYWRkciwKKwkJCQkgICAgICh2b2lk
ICopZmFrZV9yZXBsYWNlbWVudF9hZGRyKTsKKwlLVU5JVF9BU1NFUlRfRVEodGVzdCwgZmFr
ZV90ZXN0LnN0YXR1cywgS1VOSVRfU1VDQ0VTUyk7CisJS1VOSVRfQVNTRVJUX0VRKHRlc3Qs
IGxpc3RfY291bnRfbm9kZXMoJmZha2VfdGVzdC5yZXNvdXJjZXMpLCAxKTsKKworCXJlcyA9
IGxpc3RfZmlyc3RfZW50cnkoJmZha2VfdGVzdC5yZXNvdXJjZXMsIHN0cnVjdCBrdW5pdF9y
ZXNvdXJjZSwgbm9kZSk7CisJS1VOSVRfRVhQRUNUX05PVF9OVUxMKHRlc3QsIHJlcyk7CisK
KwlzdHViX2N0eCA9IHJlcy0+ZGF0YTsKKwlLVU5JVF9FWFBFQ1RfTk9UX05VTEwodGVzdCwg
c3R1Yl9jdHgpOworCUtVTklUX0VYUEVDVF9FUSh0ZXN0LCAodW5zaWduZWQgbG9uZylzdHVi
X2N0eC0+cmVhbF9mbl9hZGRyLCBmYWtlX3JlYWxfZm5fYWRkcik7CisJS1VOSVRfRVhQRUNU
X0VRKHRlc3QsICh1bnNpZ25lZCBsb25nKXN0dWJfY3R4LT5yZXBsYWNlbWVudF9hZGRyLCBm
YWtlX3JlcGxhY2VtZW50X2FkZHIpOworCisJX19rdW5pdF9hY3RpdmF0ZV9zdGF0aWNfc3R1
YigmZmFrZV90ZXN0LCAodm9pZCAqKWZha2VfcmVhbF9mbl9hZGRyLCBOVUxMKTsKKwlLVU5J
VF9BU1NFUlRfRVEodGVzdCwgZmFrZV90ZXN0LnN0YXR1cywgS1VOSVRfU1VDQ0VTUyk7CisJ
S1VOSVRfQVNTRVJUX0VRKHRlc3QsIGxpc3RfY291bnRfbm9kZXMoJmZha2VfdGVzdC5yZXNv
dXJjZXMpLCAwKTsKK30KKworc3RhdGljIHN0cnVjdCBrdW5pdF9jYXNlIGt1bml0X3N0dWJf
dGVzdF9jYXNlc1tdID0geworCUtVTklUX0NBU0Uoa3VuaXRfc3R1Yl90ZXN0KSwKKwl7fQor
fTsKKworc3RhdGljIHN0cnVjdCBrdW5pdF9zdWl0ZSBrdW5pdF9zdHViX3Rlc3Rfc3VpdGUg
PSB7CisJLm5hbWUgPSAia3VuaXRfc3R1YiIsCisJLnRlc3RfY2FzZXMgPSBrdW5pdF9zdHVi
X3Rlc3RfY2FzZXMsCit9OworCiBrdW5pdF90ZXN0X3N1aXRlcygma3VuaXRfdHJ5X2NhdGNo
X3Rlc3Rfc3VpdGUsICZrdW5pdF9yZXNvdXJjZV90ZXN0X3N1aXRlLAogCQkgICZrdW5pdF9s
b2dfdGVzdF9zdWl0ZSwgJmt1bml0X3N0YXR1c190ZXN0X3N1aXRlLAogCQkgICZrdW5pdF9j
dXJyZW50X3Rlc3Rfc3VpdGUsICZrdW5pdF9kZXZpY2VfdGVzdF9zdWl0ZSwKLQkJICAma3Vu
aXRfZmF1bHRfdGVzdF9zdWl0ZSk7CisJCSAgJmt1bml0X2ZhdWx0X3Rlc3Rfc3VpdGUsICZr
dW5pdF9zdHViX3Rlc3Rfc3VpdGUpOwogCiBNT0RVTEVfREVTQ1JJUFRJT04oIktVbml0IHRl
c3QgZm9yIGNvcmUgdGVzdCBpbmZyYXN0cnVjdHVyZSIpOwogTU9EVUxFX0xJQ0VOU0UoIkdQ
TCB2MiIpOwpkaWZmIC0tZ2l0IGEvbGliL2t1bml0L3Rlc3QuYyBiL2xpYi9rdW5pdC90ZXN0
LmMKaW5kZXggMTQ2ZDFiNDhhMDk2Li5mM2M2YjExZjEyYjggMTAwNjQ0Ci0tLSBhL2xpYi9r
dW5pdC90ZXN0LmMKKysrIGIvbGliL2t1bml0L3Rlc3QuYwpAQCAtNjksNiArNjksMTMgQEAg
c3RhdGljIGJvb2wgZW5hYmxlX3BhcmFtOwogbW9kdWxlX3BhcmFtX25hbWVkKGVuYWJsZSwg
ZW5hYmxlX3BhcmFtLCBib29sLCAwKTsKIE1PRFVMRV9QQVJNX0RFU0MoZW5hYmxlLCAiRW5h
YmxlIEtVbml0IHRlc3RzIik7CiAKKy8qCisgKiBDb25maWd1cmUgdGhlIGJhc2UgdGltZW91
dC4KKyAqLworc3RhdGljIHVuc2lnbmVkIGxvbmcga3VuaXRfYmFzZV90aW1lb3V0ID0gQ09O
RklHX0tVTklUX0RFRkFVTFRfVElNRU9VVDsKK21vZHVsZV9wYXJhbV9uYW1lZCh0aW1lb3V0
LCBrdW5pdF9iYXNlX3RpbWVvdXQsIHVsb25nLCAwNjQ0KTsKK01PRFVMRV9QQVJNX0RFU0Mo
dGltZW91dCwgIlNldCB0aGUgYmFzZSB0aW1lb3V0IGZvciBLdW5pdCB0ZXN0IGNhc2VzIik7
CisKIC8qCiAgKiBLVW5pdCBzdGF0aXN0aWMgbW9kZToKICAqIDAgLSBkaXNhYmxlZApAQCAt
MzczLDYgKzM4MCw0MCBAQCBzdGF0aWMgdm9pZCBrdW5pdF9ydW5fY2FzZV9jaGVja19zcGVl
ZChzdHJ1Y3Qga3VuaXQgKnRlc3QsCiAJCSAgIGR1cmF0aW9uLnR2X3NlYywgZHVyYXRpb24u
dHZfbnNlYyk7CiB9CiAKKy8qIFJldHVybnMgdGltZW91dCBtdWx0aXBsaWVyIGJhc2VkIG9u
IHNwZWVkLgorICogREVGQVVMVDoJCSAgICAxCisgKiBLVU5JVF9TUEVFRF9TTE9XOiAgICAg
ICAgMworICogS1VOSVRfU1BFRURfVkVSWV9TTE9XOiAgIDEyCisgKi8KK3N0YXRpYyBpbnQg
a3VuaXRfdGltZW91dF9tdWx0KGVudW0ga3VuaXRfc3BlZWQgc3BlZWQpCit7CisJc3dpdGNo
IChzcGVlZCkgeworCWNhc2UgS1VOSVRfU1BFRURfU0xPVzoKKwkJcmV0dXJuIDM7CisJY2Fz
ZSBLVU5JVF9TUEVFRF9WRVJZX1NMT1c6CisJCXJldHVybiAxMjsKKwlkZWZhdWx0OgorCQly
ZXR1cm4gMTsKKwl9Cit9CisKK3N0YXRpYyB1bnNpZ25lZCBsb25nIGt1bml0X3Rlc3RfdGlt
ZW91dChzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1aXRlLCBzdHJ1Y3Qga3VuaXRfY2FzZSAqdGVz
dF9jYXNlKQoreworCWludCBtdWx0ID0gMTsKKworCS8qCisJICogVGhlIGRlZmF1bHQgdGVz
dCB0aW1lb3V0IGlzIDMwMCBzZWNvbmRzIGFuZCB3aWxsIGJlIGFkanVzdGVkIGJ5IG11bHQK
KwkgKiBiYXNlZCBvbiB0aGUgdGVzdCBzcGVlZC4gVGhlIHRlc3Qgc3BlZWQgd2lsbCBiZSBv
dmVycmlkZGVuIGJ5IHRoZQorCSAqIGlubmVybW9zdCB0ZXN0IGNvbXBvbmVudC4KKwkgKi8K
KwlpZiAoc3VpdGUtPmF0dHIuc3BlZWQgIT0gS1VOSVRfU1BFRURfVU5TRVQpCisJCW11bHQg
PSBrdW5pdF90aW1lb3V0X211bHQoc3VpdGUtPmF0dHIuc3BlZWQpOworCWlmICh0ZXN0X2Nh
c2UtPmF0dHIuc3BlZWQgIT0gS1VOSVRfU1BFRURfVU5TRVQpCisJCW11bHQgPSBrdW5pdF90
aW1lb3V0X211bHQodGVzdF9jYXNlLT5hdHRyLnNwZWVkKTsKKwlyZXR1cm4gbXVsdCAqIGt1
bml0X2Jhc2VfdGltZW91dCAqIG1zZWNzX3RvX2ppZmZpZXMoTVNFQ19QRVJfU0VDKTsKK30K
KworCiAvKgogICogSW5pdGlhbGl6ZXMgYW5kIHJ1bnMgdGVzdCBjYXNlLiBEb2VzIG5vdCBj
bGVhbiB1cCBvciBkbyBwb3N0IHZhbGlkYXRpb25zLgogICovCkBAIC01MjcsNyArNTY4LDgg
QEAgc3RhdGljIHZvaWQga3VuaXRfcnVuX2Nhc2VfY2F0Y2hfZXJyb3JzKHN0cnVjdCBrdW5p
dF9zdWl0ZSAqc3VpdGUsCiAJa3VuaXRfdHJ5X2NhdGNoX2luaXQodHJ5X2NhdGNoLAogCQkJ
ICAgICB0ZXN0LAogCQkJICAgICBrdW5pdF90cnlfcnVuX2Nhc2UsCi0JCQkgICAgIGt1bml0
X2NhdGNoX3J1bl9jYXNlKTsKKwkJCSAgICAga3VuaXRfY2F0Y2hfcnVuX2Nhc2UsCisJCQkg
ICAgIGt1bml0X3Rlc3RfdGltZW91dChzdWl0ZSwgdGVzdF9jYXNlKSk7CiAJY29udGV4dC50
ZXN0ID0gdGVzdDsKIAljb250ZXh0LnN1aXRlID0gc3VpdGU7CiAJY29udGV4dC50ZXN0X2Nh
c2UgPSB0ZXN0X2Nhc2U7CkBAIC01MzcsNyArNTc5LDggQEAgc3RhdGljIHZvaWQga3VuaXRf
cnVuX2Nhc2VfY2F0Y2hfZXJyb3JzKHN0cnVjdCBrdW5pdF9zdWl0ZSAqc3VpdGUsCiAJa3Vu
aXRfdHJ5X2NhdGNoX2luaXQodHJ5X2NhdGNoLAogCQkJICAgICB0ZXN0LAogCQkJICAgICBr
dW5pdF90cnlfcnVuX2Nhc2VfY2xlYW51cCwKLQkJCSAgICAga3VuaXRfY2F0Y2hfcnVuX2Nh
c2VfY2xlYW51cCk7CisJCQkgICAgIGt1bml0X2NhdGNoX3J1bl9jYXNlX2NsZWFudXAsCisJ
CQkgICAgIGt1bml0X3Rlc3RfdGltZW91dChzdWl0ZSwgdGVzdF9jYXNlKSk7CiAJa3VuaXRf
dHJ5X2NhdGNoX3J1bih0cnlfY2F0Y2gsICZjb250ZXh0KTsKIAogCS8qIFByb3BhZ2F0ZSB0
aGUgcGFyYW1ldGVyIHJlc3VsdCB0byB0aGUgdGVzdCBjYXNlLiAqLwpkaWZmIC0tZ2l0IGEv
bGliL2t1bml0L3RyeS1jYXRjaC1pbXBsLmggYi9saWIva3VuaXQvdHJ5LWNhdGNoLWltcGwu
aAppbmRleCAyMDNiYTZhNWU3NDAuLjZmNDAxYjk3Y2QwYiAxMDA2NDQKLS0tIGEvbGliL2t1
bml0L3RyeS1jYXRjaC1pbXBsLmgKKysrIGIvbGliL2t1bml0L3RyeS1jYXRjaC1pbXBsLmgK
QEAgLTE3LDExICsxNywxMyBAQCBzdHJ1Y3Qga3VuaXQ7CiBzdGF0aWMgaW5saW5lIHZvaWQg
a3VuaXRfdHJ5X2NhdGNoX2luaXQoc3RydWN0IGt1bml0X3RyeV9jYXRjaCAqdHJ5X2NhdGNo
LAogCQkJCQlzdHJ1Y3Qga3VuaXQgKnRlc3QsCiAJCQkJCWt1bml0X3RyeV9jYXRjaF9mdW5j
X3QgdHJ5LAotCQkJCQlrdW5pdF90cnlfY2F0Y2hfZnVuY190IGNhdGNoKQorCQkJCQlrdW5p
dF90cnlfY2F0Y2hfZnVuY190IGNhdGNoLAorCQkJCQl1bnNpZ25lZCBsb25nIHRpbWVvdXQp
CiB7CiAJdHJ5X2NhdGNoLT50ZXN0ID0gdGVzdDsKIAl0cnlfY2F0Y2gtPnRyeSA9IHRyeTsK
IAl0cnlfY2F0Y2gtPmNhdGNoID0gY2F0Y2g7CisJdHJ5X2NhdGNoLT50aW1lb3V0ID0gdGlt
ZW91dDsKIH0KIAogI2VuZGlmIC8qIF9LVU5JVF9UUllfQ0FUQ0hfSU1QTF9IICovCmRpZmYg
LS1naXQgYS9saWIva3VuaXQvdHJ5LWNhdGNoLmMgYi9saWIva3VuaXQvdHJ5LWNhdGNoLmMK
aW5kZXggNmJiZTAwMjViMDc5Li5kODRhODc5ZjBhNzggMTAwNjQ0Ci0tLSBhL2xpYi9rdW5p
dC90cnktY2F0Y2guYworKysgYi9saWIva3VuaXQvdHJ5LWNhdGNoLmMKQEAgLTM0LDMxICsz
NCw2IEBAIHN0YXRpYyBpbnQga3VuaXRfZ2VuZXJpY19ydW5fdGhyZWFkZm5fYWRhcHRlcih2
b2lkICpkYXRhKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgdW5zaWduZWQgbG9uZyBrdW5p
dF90ZXN0X3RpbWVvdXQodm9pZCkKLXsKLQkvKgotCSAqIFRPRE8oYnJlbmRhbmhpZ2dpbnNA
Z29vZ2xlLmNvbSk6IFdlIHNob3VsZCBwcm9iYWJseSBoYXZlIHNvbWUgdHlwZSBvZgotCSAq
IHZhcmlhYmxlIHRpbWVvdXQgaGVyZS4gVGhlIG9ubHkgcXVlc3Rpb24gaXMgd2hhdCB0aGF0
IHRpbWVvdXQgdmFsdWUKLQkgKiBzaG91bGQgYmUuCi0JICoKLQkgKiBUaGUgaW50ZW50aW9u
IGhhcyBhbHdheXMgYmVlbiwgYXQgc29tZSBwb2ludCwgdG8gYmUgYWJsZSB0byBsYWJlbAot
CSAqIHRlc3RzIHdpdGggc29tZSB0eXBlIG9mIHNpemUgYnVja2V0ICh1bml0L3NtYWxsLCBp
bnRlZ3JhdGlvbi9tZWRpdW0sCi0JICogbGFyZ2Uvc3lzdGVtL2VuZC10by1lbmQsIGV0Yyks
IHdoZXJlIGVhY2ggc2l6ZSBidWNrZXQgd291bGQgZ2V0IGEKLQkgKiBkZWZhdWx0IHRpbWVv
dXQgdmFsdWUga2luZCBvZiBsaWtlIHdoYXQgQmF6ZWwgZG9lczoKLQkgKiBodHRwczovL2Rv
Y3MuYmF6ZWwuYnVpbGQvdmVyc2lvbnMvbWFzdGVyL2JlL2NvbW1vbi1kZWZpbml0aW9ucy5o
dG1sI3Rlc3Quc2l6ZQotCSAqIFRoZXJlIGlzIHN0aWxsIHNvbWUgZGViYXRlIHRvIGJlIGhh
ZCBvbiBleGFjdGx5IGhvdyB3ZSBkbyB0aGlzLiAoRm9yCi0JICogb25lLCB3ZSBwcm9iYWJs
eSB3YW50IHRvIGhhdmUgc29tZSBzb3J0IG9mIHRlc3QgcnVubmVyIGxldmVsCi0JICogdGlt
ZW91dC4pCi0JICoKLQkgKiBGb3IgbW9yZSBiYWNrZ3JvdW5kIG9uIHRoaXMgdG9waWMsIHNl
ZToKLQkgKiBodHRwczovL21pa2UtYmxhbmQuY29tLzIwMTEvMTEvMDEvc21hbGwtbWVkaXVt
LWxhcmdlLmh0bWwKLQkgKgotCSAqIElmIHRlc3RzIHRpbWVvdXQgZHVlIHRvIGV4Y2VlZGlu
ZyBzeXNjdGxfaHVuZ190YXNrX3RpbWVvdXRfc2VjcywKLQkgKiB0aGUgdGFzayB3aWxsIGJl
IGtpbGxlZCBhbmQgYW4gb29wcyBnZW5lcmF0ZWQuCi0JICovCi0JcmV0dXJuIDMwMCAqIG1z
ZWNzX3RvX2ppZmZpZXMoTVNFQ19QRVJfU0VDKTsgLyogNSBtaW4gKi8KLX0KLQogdm9pZCBr
dW5pdF90cnlfY2F0Y2hfcnVuKHN0cnVjdCBrdW5pdF90cnlfY2F0Y2ggKnRyeV9jYXRjaCwg
dm9pZCAqY29udGV4dCkKIHsKIAlzdHJ1Y3Qga3VuaXQgKnRlc3QgPSB0cnlfY2F0Y2gtPnRl
c3Q7CkBAIC04NSw4ICs2MCw4IEBAIHZvaWQga3VuaXRfdHJ5X2NhdGNoX3J1bihzdHJ1Y3Qg
a3VuaXRfdHJ5X2NhdGNoICp0cnlfY2F0Y2gsIHZvaWQgKmNvbnRleHQpCiAJdGFza19kb25l
ID0gdGFza19zdHJ1Y3QtPnZmb3JrX2RvbmU7CiAJd2FrZV91cF9wcm9jZXNzKHRhc2tfc3Ry
dWN0KTsKIAotCXRpbWVfcmVtYWluaW5nID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0
KHRhc2tfZG9uZSwKLQkJCQkJCSAgICAga3VuaXRfdGVzdF90aW1lb3V0KCkpOworCXRpbWVf
cmVtYWluaW5nID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KAorCQl0YXNrX2RvbmUs
IHRyeV9jYXRjaC0+dGltZW91dCk7CiAJaWYgKHRpbWVfcmVtYWluaW5nID09IDApIHsKIAkJ
dHJ5X2NhdGNoLT50cnlfcmVzdWx0ID0gLUVUSU1FRE9VVDsKIAkJa3RocmVhZF9zdG9wKHRh
c2tfc3RydWN0KTsKZGlmZiAtLWdpdCBhL2xpYi90ZXN0cy9sb25nZXN0X3N5bWJvbF9rdW5p
dC5jIGIvbGliL3Rlc3RzL2xvbmdlc3Rfc3ltYm9sX2t1bml0LmMKaW5kZXggZTNjMjhmZjE4
MDdmLi45YjRkZTMwNTBiYTcgMTAwNjQ0Ci0tLSBhL2xpYi90ZXN0cy9sb25nZXN0X3N5bWJv
bF9rdW5pdC5jCisrKyBiL2xpYi90ZXN0cy9sb25nZXN0X3N5bWJvbF9rdW5pdC5jCkBAIC0z
LDggKzMsNyBAQAogICogVGVzdCB0aGUgbG9uZ2VzdCBzeW1ib2wgbGVuZ3RoLiBFeGVjdXRl
IHdpdGg6CiAgKiAgLi90b29scy90ZXN0aW5nL2t1bml0L2t1bml0LnB5IHJ1biBsb25nZXN0
LXN5bWJvbAogICogIC0tYXJjaD14ODZfNjQgLS1rY29uZmlnX2FkZCBDT05GSUdfS1BST0JF
Uz15IC0ta2NvbmZpZ19hZGQgQ09ORklHX01PRFVMRVM9eQotICogIC0ta2NvbmZpZ19hZGQg
Q09ORklHX1JFVFBPTElORT1uIC0ta2NvbmZpZ19hZGQgQ09ORklHX0NGSV9DTEFORz1uCi0g
KiAgLS1rY29uZmlnX2FkZCBDT05GSUdfTUlUSUdBVElPTl9SRVRQT0xJTkU9bgorICogIC0t
a2NvbmZpZ19hZGQgQ09ORklHX0NQVV9NSVRJR0FUSU9OUz1uIC0ta2NvbmZpZ19hZGQgQ09O
RklHX0dDT1ZfS0VSTkVMPW4KICAqLwogCiAjZGVmaW5lIHByX2ZtdChmbXQpIEtCVUlMRF9N
T0ROQU1FICI6ICIgZm10Cg==

--------------o47LyHuuA4GgNm4uUNMXT8p0--

