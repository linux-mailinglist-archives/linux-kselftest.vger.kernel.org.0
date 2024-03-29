Return-Path: <linux-kselftest+bounces-6870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900CC89170F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 11:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A85C1F2181B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9E69D3C;
	Fri, 29 Mar 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="lIJa8aUf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60413FBB5;
	Fri, 29 Mar 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709417; cv=none; b=mg84oNIoQ/X8TMlF6vBJP7mOIfDMZazJ+O0YMNK4sFBKgtkJkqX+yhOancy7M1IB84gSBPoM6GMcsiYyX5QuV3duIlrT/zKUR1n2YG1W4NXG+ZeVt82JncL6LvBN5yo3GWD2fZCAwbWzDaLC+2FkGI+54ZAutW8mmn3vdwibxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709417; c=relaxed/simple;
	bh=MTcqBDnoNq69j9KL+QdmIuWFQZGkn+znOcDB6jcaeO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XhFqadnRDvvue2+WbDPIp3ZS7xRxrCypT3ioi/NM+tzIA9tGG0pBrjJaAlJTxRctkevpiNJXnpl9+U2wNpvvSzJ7nspZ2UR12snRr5Lo1kwftwrzUUm2c5JJR2Hw8f1c3CGSEeoKmfx+1X75C0R0q2ZTlSZFOfR0+qVwzAvijYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=lIJa8aUf; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1711709399; x=1712314199; i=kernel@valentinobst.de;
	bh=bHTq2JJD1FgvG/dzjWao8FpwbpagOQFfmzkKyGo1LrM=;
	h=X-UI-Sender-Class:From:Date:Subject:To:Cc;
	b=lIJa8aUf+NdDIX71+DH0TFeQuR+9DdyG+i19ZiycHOwOmSYv3Gd9K+uJBhu/WO+t
	 qBNgJJdgywOSFkJLbOcl9zIIrE/O70xZhYY87ySywvW8jDvfRhlHbETfZtOCSUp3p
	 nlltPgodgUaaOKY3LHDgwTJSB9zM8xxibrmiPobDFULo2NGbKkEK/vgOb84i6VwJM
	 O0AsgcEXuc4mRoeNv+9VVOiLaZSFPKySljglNePLkOPxljw0+M2tDgHLPn99ZzXCJ
	 ihVkRGE9SBUbRPuzoz1T+a2JKVndtMvFH3rl+Vll3qmMShEmTsIu27v0f0lzEjIbE
	 frbXHDUUnkZEIdJzEQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.77.77.61] ([217.249.70.154]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mq1GE-1sbsxh1zmc-00nBII; Fri, 29 Mar 2024 11:49:59 +0100
From: Valentin Obst <kernel@valentinobst.de>
Date: Fri, 29 Mar 2024 11:49:43 +0100
Subject: [PATCH] selftests: default to host arch for LLVM builds
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de>
X-B4-Tracking: v=1; b=H4sIAMacBmYC/42NQQ6CMBBFr0Jm7ZiWggmuvIdhUWAqE0sxnabRE
 O5u5QQu30v++xsIRSaBa7VBpMzCayigTxWMsw0PQp4KQ63qRhllUMi7RJIEPQ/LE73PC0Y3Yuv
 IjM52TnUNlPkrkuP3kb73hWeWtMbP8ZT1z/4RzRo1dnZoDZlLS0bfsvUUEod1kHSeCPp9378r7
 +m5xgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711709399; l=4372;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=xPQAgRbQujiRbGpyo0ekkcMaHGYfLJaSTwW9VcXklhw=;
 b=rkvYX+nln2570h3UNIbtZodY8Im6XIGOae+bjXTAzQ7zjQ80NjdGctGvX4iUi21I+HCauzdIv
 dJX0CCPwHtyBNw1TWH1VnEUnG5YrH+R+hszuPy8KKWk4zW119i9Gf4k
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Provags-ID: V03:K1:Kffi7zvnvpbhmyBUeyAvNfL2Hr6GaaeKBVl9l5ESJMsMYxxS5AH
 Wu8/guwXU/XvdPWCJIQU8U/L26LtaDnYOrm8ldwmF6w9XpAvBU8xKNkgcnMxHqI7iSw+iwD
 a99YRBbShpM8Jhrvu+uqRLHWJzmiy7p+6FrVqTIKAgFnA7oIxnOMiEKo1GToaCDQ/mRfvLl
 oQROwSrlT7yDfzl1AHTtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AgfD508H+Fo=;siKZkViJ4T0o9Tfokk2cE9yZ9wx
 chgr+6sz5Ik5m9a+AMHYkZokSrXM7/OmLAh3LZ+UtUvTyqB7DyqIQNP5IccozyWUXB9VsCIWn
 eNIV4XucR0M30OEDWvvDHL0oc0CrBm79VALsjGAIFR4vF1ulKg1rGmVy+D6hz6bIgxtXu537B
 usxu/Aim7TwZC2h8Tgo3kX3V/vLfl34Fox+w2p1HmfPRKD5XKRssPo73MUBjg3+Jk/4xvLmlm
 B1pRExnGFtCc7EW9MACRhnXgHlUC0RskXZqbb/+6cWz6m7/JhsXl1Z09eanhnQfiymctIvXLG
 v20dq4Ta+h2X5sE32c/ru1TshJRlzlUE8wsA1Wq6Agf4TTNtIni9HKeI5ZBtkiZQ73Kk/IDqz
 V0y3yCs0yXKrE9bKgi7W6/vh3b+0vF3Bq6Ej/3H/OnsYrC6OPYkFBsrC6kbNvR9J6GwUDq4Te
 929E1odb1SlTmSM+LubVNpX//h8n+i7LbtjjDZmFmC2AZFZO3Sud8CCVa5tQBT7MIY42Q+s+A
 F7UYyO47pDPXV6UQXx9J2jGJ4cPoXmw2IdmBYENcPuB05llYzde+EvvcUDwS3fqcT0YDPn0sx
 tTiEJmCekeko44kYruE9RH3qQ8cE+IiOeaUCtIJKyg9PTtUqCEr0vgxs4wW+Og+SLZ+Zzps7A
 R6KxTVeMralKj2GsuJf4LMhJD16P2GRP5tqszpdZeSomxg6p9vcR0YHHjlJ18PsoRAtREStHd
 HiZyILw1s1SemEGKLJQg2E0z4tpYB2zpE1EGPWmsbGODlSRjpE3vyA=

Align the behavior for gcc and clang builds by interpreting unset
`ARCH` and `CROSS_COMPILE` variables in `LLVM` builds as a sign that the
user wants to build for the host architecture.

This patch preserves the properties that setting the `ARCH` variable to an
unknown value will trigger an error that complains about insufficient
information, and that a set `CROSS_COMPILE` variable will override the
target triple that is determined based on presence/absence of `ARCH`.

When compiling with clang, i.e., `LLVM` is set, an unset `ARCH` variable i=
n
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

In the same scenario a gcc build would default to the host architecture,
i.e., it would use plain `gcc`.

Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Valentin Obst <kernel@valentinobst.de>
=2D--
I am not entirely sure whether this behavior is in fact known and intended
and whether the way to obtain the host target triple is sufficiently
general. The flag was introduced in llvm-8 with [1], it will be an error i=
n
older clang versions.

The target triple you get with `-print-target-triple` may not be the
same that you would get when explicitly setting ARCH to you host
architecture. For example on my x86_64 system it get
`x86_64-pc-linux-gnu` instead of `x86_64-linux-gnu`, similar deviations
were observed when testing other clang binaries on compiler-explorer,
e.g., [2].

An alternative could be to simply do:

      ARCH ?=3D $(shell uname -m)

before using it to select the target. Possibly with some post processing,
but at that point we would likely be replicating `scripts/subarch.include`=
.
This is what some subsystem Makefiles do before including `lib.mk`. This
change might make it possible to remove the explicit setting of `ARCH` fro=
m
the few subsystem Makefiles that do it.

[1]: https://reviews.llvm.org/D50755
[2]: https://godbolt.org/z/r7Gn9bvv1

Changes in v1:
- Shortened commit message.
- Link to RFC: https://lore.kernel.org/r/20240303-selftests-libmk-llvm-rfc=
-v1-1-9ab53e365e31@valentinobst.de
=2D--
 tools/testing/selftests/lib.mk | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.=
mk
index da2cade3bab0..8ae203d8ed7f 100644
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
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240303-selftests-libmk-llvm-rfc-5fe3cfa9f094

Best regards,
=2D-
Valentin Obst <kernel@valentinobst.de>


