Return-Path: <linux-kselftest+bounces-14332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFB293E464
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C561C20C91
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE412C859;
	Sun, 28 Jul 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="s1hwEqD6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0321342;
	Sun, 28 Jul 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161418; cv=none; b=TvtL1ICxkmuzO1FSwE9RnkQ/tyKY+osdHFmVwvh/UO2/WE/XrYZSvyOzAw7KzRkjdduLH1aGcJcHyHRQT04OC10zur66+cQZvG2dRQpwI2oH8CxvEOOvvkeKzKnslxhntFtNW+qWBTUx5WBhXwfeCwWMz5bg9pRCU2CicDanm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161418; c=relaxed/simple;
	bh=x0bBD9VMDQBhEWwLY3QCg17KVE+zIpFt5v2/PoyQ0k0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DnCwHw9tzrXVb7C574YPDtEXxtnqIEXLLi4J2VecJqnfW+i8cDAmjpyJHuiq4v7df/YclwASmD8OtkLQMR/mhnlsRWAswyvFjFSiJwZjnYF6jiC1fGl4ZAQPSSOOjEcQCUvQMajwX7hk7tTpiDkouaMyfUYcDignnYnBsyQrUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=s1hwEqD6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=x0bBD9VMDQBhEWwLY3QCg17KVE+zIpFt5v2/PoyQ0k0=;
	h=From:Subject:Date:To:Cc:From;
	b=s1hwEqD6MmUPasGnt5gY/2nk0/CuESSIIMEMTkY0MmMZlqFAWGUFr848IUmeuoz2M
	 gC8Ri6E96snDE0ODg95RMpjWGNlcIszByZ4CcO8a0lic+sLvy71A4IaajGxIQJNgju
	 smwxMnSTyaw+BSW8/0eVri3LTKo0ep/wRRjDy2OU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 00/12] tools/nolibc: improve LLVM/clang support
Date: Sun, 28 Jul 2024 12:09:54 +0200
Message-Id: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPIYpmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNz3bz8nMykZN2cnLJcXeO0xBQzC1NLgxSTZCWgjoKi1LTMCrBp0bG
 1tQDPUqwAXQAAAA==
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=2200;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=x0bBD9VMDQBhEWwLY3QCg17KVE+zIpFt5v2/PoyQ0k0=;
 b=V8IOWfC++1JtxVFue3jJ6NdCthJ0k5Vn7r8Is23DKBP56CfLiqlo1Ir9ZErzISRcmESJ91wvz
 0vaV5J38jMuD8HZQTKhnfCLr79ZGXcTS3I2NYoNweGxwWu51nDqxnby
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The current support for LLVM and clang in nolibc and its testsuite is
very limited.

* Various architectures plain do not compile
* The user *has* to specify "-Os" otherwise the program crashes
* Cross-compilation of the tests does not work
* Using clang is not wired up in run-tests.sh

This series extends this support.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (12):
      tools/nolibc: use clang-compatible asm syntax in arch-arm.h
      tools/nolibc: limit powerpc stack-protector workaround to GCC
      tools/nolibc: move entrypoint specifics to compiler.h
      tools/nolibc: use attribute((naked)) if available
      selftests/nolibc: report failure if no testcase passed
      selftests/nolibc: avoid passing NULL to printf("%s")
      selftests/nolibc: determine $(srctree) first
      selftests/nolibc: setup objtree without Makefile.include
      selftests/nolibc: add support for LLVM= parameter
      selftests/nolibc: add cc-option compatible with clang cross builds
      selftests/nolibc: run-tests.sh: avoid overwriting CFLAGS_EXTRA
      selftests/nolibc: run-tests.sh: allow building through LLVM

 tools/include/nolibc/arch-aarch64.h          |  4 ++--
 tools/include/nolibc/arch-arm.h              |  8 ++++----
 tools/include/nolibc/arch-i386.h             |  4 ++--
 tools/include/nolibc/arch-loongarch.h        |  4 ++--
 tools/include/nolibc/arch-mips.h             |  4 ++--
 tools/include/nolibc/arch-powerpc.h          |  6 +++---
 tools/include/nolibc/arch-riscv.h            |  4 ++--
 tools/include/nolibc/arch-s390.h             |  4 ++--
 tools/include/nolibc/arch-x86_64.h           |  4 ++--
 tools/include/nolibc/compiler.h              | 12 ++++++++++++
 tools/testing/selftests/nolibc/Makefile      | 27 ++++++++++++++++-----------
 tools/testing/selftests/nolibc/nolibc-test.c |  4 ++--
 tools/testing/selftests/nolibc/run-tests.sh  | 20 ++++++++++++++++----
 13 files changed, 67 insertions(+), 38 deletions(-)
---
base-commit: 0db287736bc586fcd5a2925518ef09eec6924803
change-id: 20240727-nolibc-llvm-3fad68590d4c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


