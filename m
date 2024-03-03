Return-Path: <linux-kselftest+bounces-5800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7086F500
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 14:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11251F21546
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B9B673;
	Sun,  3 Mar 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="sv+TsEdx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C11CA73;
	Sun,  3 Mar 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471476; cv=none; b=T3C7xibDzFBuUuUxxuKHJVnGl0FGS103eUw3uQB8aOYeBlUbEelswcteNdbbe1ITruo6kCE8N3Cv5CF885jst3oZc+CIvK2RuFQutzp0vA9j1RDEUi7ohBHXCCA9pXXQzT8dl39WQh1ZCrVcBdr2N8r5V+O2iZ4iGvk2XHckDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471476; c=relaxed/simple;
	bh=PYafNNhjJMBNjwpI8k3yoMSKo6rMOK3JKkJ6SSwHO/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cDfuEZAjRYsaCsgUk7n02O7ePGL0/OlfVvK4h9K4WQswt8cseZlyGNPF2fz8eANGMYCH/hiFD2xkvuQaUwxKAXVumXZMWoKpgfN6NGDPy80HcOJwa++y3t7OXsidMhwuMQ9Rstt7yPZVlSjPOjzDJysM1aJ/mjhVOBxDPqpZtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=sv+TsEdx; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1709471466; x=1710076266; i=kernel@valentinobst.de;
	bh=PYafNNhjJMBNjwpI8k3yoMSKo6rMOK3JKkJ6SSwHO/c=;
	h=X-UI-Sender-Class:From:Date:Subject:To:Cc;
	b=sv+TsEdxulpP6xxBh3w2qqlA/lfQr9iE+QyomVvKB9E9gm4XPQpo5dJ/Nmx0XTaO
	 qMIHS2fm/+wT4ramoa1MW6Zii10EdHYDCDyiysaqZNdZ4NIxEhIdOPdN2e51Q0bh9
	 Rrbo9kIqPwEpeFlBAMmkWPpr95zUBzVawsWaJQ4Ys71MzL0dbwvAOneA+lHlkSsgW
	 e2k+FNTLV/t0DZeEU0/FLXxpg9+C1b/Zf8m/4H++5RmlIdgVab4dBhpwFat46B09u
	 N5ynokZbx6ZFroKpEqTeV5LT6ESqQU1jTIYUHFWzRXdYgVA/H4M+hbnW5hDwKLzvb
	 Wzkbp7Oz7l8/AdBV6w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.2.229] ([80.133.137.1]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MWAay-1rNOzJ37xi-00XgKM; Sun, 03 Mar 2024 13:44:59 +0100
From: Valentin Obst <kernel@valentinobst.de>
Date: Sun, 03 Mar 2024 13:44:36 +0100
Subject: [PATCH RFC] selftests: default to host arch for LLVM builds
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240303-selftests-libmk-llvm-rfc-v1-1-9ab53e365e31@valentinobst.de>
X-B4-Tracking: v=1; b=H4sIALNw5GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNj3eLUnLSS1OKSYt2czKTcbN2cnLJc3aK0ZF3TtFTj5LREyzQDSxM
 loPaCotS0zAqw0dFKQW7OSrG1tQA8nkx2bwAAAA==
To: Shuah Khan <shuah@kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, 
 Benjamin Poirier <bpoirier@nvidia.com>, 
 Guillaume Tucker <guillaume.tucker@collabora.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 Marcos Paulo de Souza <mpdesouza@suse.com>, Mark Brown <broonie@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Valentin Obst <kernel@valentinobst.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709469899; l=4000;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=yZzV08YOvoeLyJJ85Mn+deJxF5jyLGkheHCV3AY3Ufs=;
 b=TSN9jyLjY6bKdK+NLS7g1B8qOvrNCSBg8JOwMdTGuEH/NmHm11YJWG+eHr+U7CQMkaHgHO8id
 5nbK2BFfjh8ABJuP+6uaorPV+sBQssX/76EHtCTvre8y/PTwgfmYMvs
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Provags-ID: V03:K1:Sz5F4HnDlLJMIKupiDJCbYrM2nc8zUpYRbGOYYRMiddrKjStcw/
 7V1Vf7oZPMHDJla9MJDzF50E2SsmkBk8MyFa51I8SIkUHNjyfTUIbiyOjYKlXSmfZs6+4i+
 J9bGyVj07bHh7iqUEIXrXQvsJhufztJxHDS5uA8tOykeY7LZ9RkI+wEOBOmh7YUsT/7tyxz
 Z19I4Xx70anfa2xxF7+BA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/CEI+nyxZus=;PvNMHw0P8TdM9bclnRLsNCwmtWm
 qzi2i0QYj3wTVzmHuEm3Jws0S1FtDwbYkByzou1DMeLFGHYdXFXyTQ1P+OTBNcj6nDYIwiIVV
 oqVFJjzCU6ZwVjVvTsUP7FRASskasGhy0K4z8jrmf9bKE/XzhQcz2GYPD00l1AfMD0TsB9BSR
 Vviu0/MFFQ0AvTuoxEGneDrf5ffFF7GEXkYewC59V4ALVqY/cC29FtC3ILu7dK71P6rnWTLpG
 JHDCQHz+zBeEqKphOJaYBIXRNC0rykQ0vbu3x+4B2o2GWWd+Le3fBzYn+0Mc0dD6nLVCXWriQ
 K9PKOFqNT2jUlgDZGqiPRytgMH4Syvrw60bdMl/cqlnRToPH8ZHvEOLF3dScr6foGxGVwbRAM
 n5hlv7Or+wrrYefzxXVtoqMCleJ4ZOW1AFUOFhM6fD7+k0/iebjx+Jv4XPJQ2Phh+nyYApBHP
 u3rsrfgHLMa8Hx1XFEaT6Pi83jHazAC39TaPSglzekwassWue8S8dgb+kxW7Ss33VZFeF1O02
 fnF6UGnWbRjvuNeOGiKR0DuG/MHtULGix0X/uH/fTH8a9kwUM32SV1kryzCUJDu4oiLbPDlvX
 mkulJZOQvzYBTbSChQIIQGZbUuZQyppPjBFiAdU7fBMyPGcnK2bfJcbG8xEz2C1hYBZ1dY8gu
 B+6hC2lU30bYXm071ALFt7AwdatS81m4z7UYiYzr2dRan5IY+y5YJmZeglFSZe99Lu4vev9Vc
 t/DpYFPrhVkZWKs5CNZ55UBjw8b3bKtG+Q2axAb1Eno0VWVCfdeJCo=

When using gcc without cross compiling, i.e., `CROSS_COMPILE` unset or
empty, the selftests build defaults to the host architecture, i.e., it use=
s
plain gcc. However, when compiling with clang an unset `ARCH` variable in
combination with an unset `CROSS_COMPILE` variable, i.e., compiling for
the host architecture, leads to compilation failures since `lib.mk` can
not determine the clang target triple. In this case, the following error
message is displayed for each subsystem that does not set `ARCH` in its
own Makefile before including `lib.mk` (lines wrapped at 75 chrs):

  make[1]: Entering directory '/mnt/build/linux/tools/testing/selftests/
   sysctl'
  ../lib.mk:33: *** Specify CROSS_COMPILE or add '--target=3D' option to
   lib.mk.  Stop.
  make[1]: Leaving directory '/mnt/build/linux/tools/testing/selftests/
   sysctl'

Align the behavior for gcc and clang builds by interpreting unset
`ARCH` and `CROSS_COMPILE` variables in `LLVM` builds as a sign that the
user wants to build for the host architecture.

This preserves the property that setting the `ARCH` variable to an
unknown value will trigger an error that complains about insufficient
information.

RFC since I am not entirely sure if this behavior is in fact known and
intended, and whether the way to obtain the host target triple is
sufficiently general. (The flag was introduced in llvm-8 with [1], it
will be an error for older clang versions, however, currently 13.0.1 is th=
e
minimal version required to build the kernel. For some clang binaries it
prints the 'unknown' instead of the 'linux' version of the target, e.g.,
mips [2]). An alternative could be to simply do:

  ARCH ?=3D $(shell uname -m)

before using it to select the target. Possibly with some post processing,
but at that point we would likely be replicating `scripts/subarch.include`=
.

Also unsure if it needs a 'Fixes: 795285ef2425 ("selftests: Fix clang
cross compilation")'. Furthermore, this change might make it possible to
remove the explicit setting of `ARCH` from the few subsystem Makefiles
that do it.

Would be happy to get some feedback on those points. If it looks OK I
can also send it as a patch.

Link: https://reviews.llvm.org/D50755 [1]
Link: https://godbolt.org/z/r7Gn9bvv1 [2]
Signed-off-by: Valentin Obst <kernel@valentinobst.de>
=2D--
 tools/testing/selftests/lib.mk | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.=
mk
index aa646e0661f3..a8f0442a36bc 100644
=2D-- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -7,6 +7,8 @@ else ifneq ($(filter -%,$(LLVM)),)
 LLVM_SUFFIX :=3D $(LLVM)
 endif

+CLANG :=3D $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+
 CLANG_TARGET_FLAGS_arm          :=3D arm-linux-gnueabi
 CLANG_TARGET_FLAGS_arm64        :=3D aarch64-linux-gnu
 CLANG_TARGET_FLAGS_hexagon      :=3D hexagon-linux-musl
@@ -18,7 +20,13 @@ CLANG_TARGET_FLAGS_riscv        :=3D riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390         :=3D s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86          :=3D x86_64-linux-gnu
 CLANG_TARGET_FLAGS_x86_64       :=3D x86_64-linux-gnu
-CLANG_TARGET_FLAGS              :=3D $(CLANG_TARGET_FLAGS_$(ARCH))
+
+# Default to host architecture if ARCH is not explicitly given.
+ifeq ($(ARCH),)
+CLANG_TARGET_FLAGS :=3D $(shell $(CLANG) -print-target-triple)
+else
+CLANG_TARGET_FLAGS :=3D $(CLANG_TARGET_FLAGS_$(ARCH))
+endif

 ifeq ($(CROSS_COMPILE),)
 ifeq ($(CLANG_TARGET_FLAGS),)
@@ -30,7 +38,7 @@ else
 CLANG_FLAGS     +=3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
 endif # CROSS_COMPILE

-CC :=3D $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
+CC :=3D $(CLANG) $(CLANG_FLAGS) -fintegrated-as
 else
 CC :=3D $(CROSS_COMPILE)gcc
 endif # LLVM

=2D--
base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
change-id: 20240303-selftests-libmk-llvm-rfc-5fe3cfa9f094

Best regards,
=2D-
Valentin Obst <kernel@valentinobst.de>


