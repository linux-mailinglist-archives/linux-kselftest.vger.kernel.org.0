Return-Path: <linux-kselftest+bounces-14979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5394B258
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510FA1F228E6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524FA1534EC;
	Wed,  7 Aug 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sbKN5d3R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5012C460;
	Wed,  7 Aug 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067521; cv=none; b=QP3fFM0QUVCtA80IwNmjnBz6QP4AdUU0HE8TDLT8RuuPM4ijZfoFyjzjTMfJ0yYx1ojiQGJbbB41/KWvKpzqlZAwlOrozc6fw6Jm6mnVKRKzeyiGDouja2tJjJX3VxkR5Nm0OsT1MF30CDC44aEVPV9p1azzz1CqcOpc4IQY5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067521; c=relaxed/simple;
	bh=DWk4QStzvwvvileYzPNCMjzVKAi3JRwYlluajezX9sc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GE54oPW5G87rOsYg4YUJYW3VGfQ3kv2e4kEA+XgYam3VWkVp1KsEjHkj31+i/MQQ1fWKTasCw2p0hOHv8qRfF5iMwW5nVFEtgx9prowymOlUFLvph6YgnOUgehtmReKiRLgZFYh9i2TnWWDJB0lGcOnD89AvgHLXxJnOgWo4zUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sbKN5d3R; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067510;
	bh=DWk4QStzvwvvileYzPNCMjzVKAi3JRwYlluajezX9sc=;
	h=From:Subject:Date:To:Cc:From;
	b=sbKN5d3Rdu1lXZVMwYRs1EQVQcDbYj/BJLLy7ggJ0+lofbpxyCA6/9NVOzwvRMbPM
	 BTvg8J61rCLah63wxaffPGdLB+8TZs/rxb44vusFvntO5BlwZ70R8XX8pyG+WARsxN
	 P06LIJfeVSKMczMJLLu0iaJhu21343u0c8kz5I6Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 00/15] tools/nolibc: improve LLVM/clang support
Date: Wed, 07 Aug 2024 23:51:36 +0200
Message-Id: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGjss2YC/1XMTQ6CMBCG4auQWVtTSvlz5T0MC2gHOwkW08GqI
 dzdSuLC1eSd5HtWYAyEDKdshYCRmGafQh0yMK73VxRkU4OSSsta1cLPEw1GTFO8iWLsbdWUrbT
 aQFrcA4702rVLl9oRL3N473jMv9+f0/w5MRdSDKZotKradMvzE4mZjXu4o8cFum3bPj0mj7urA
 AAA
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=2813;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DWk4QStzvwvvileYzPNCMjzVKAi3JRwYlluajezX9sc=;
 b=VSenKD0tOgBuQwPO/yE6gA79UStMMZd2MMyW9gIJSY3FYoGgEznQTbOHXRAOiaaJ8OGpJeSkO
 CT0WpTaC3wvCU0bYF1K0+y3d+ymlCZmcc92EzC4zLw5eVeDOR1s+lN6
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
Changes in v2:
- Add support for all architectures
  - powerpc: "selftests/nolibc: don't use libgcc when building with clang"
  - mips: "tools/nolibc: mips: load current function to $t9"
  - s390: "selftests/nolibc: use correct clang target for s390/powerz"
- Expand commit messages
- Use __nolibc_ prefix for custom macros
- Link to v1: https://lore.kernel.org/r/20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net

---
Thomas Weißschuh (15):
      tools/nolibc: arm: use clang-compatible asm syntax
      tools/nolibc: mips: load current function to $t9
      tools/nolibc: powerpc: limit stack-protector workaround to GCC
      tools/nolibc: compiler: introduce __nolibc_has_attribute()
      tools/nolibc: move entrypoint specifics to compiler.h
      tools/nolibc: compiler: use attribute((naked)) if available
      selftests/nolibc: report failure if no testcase passed
      selftests/nolibc: avoid passing NULL to printf("%s")
      selftests/nolibc: determine $(srctree) first
      selftests/nolibc: add support for LLVM= parameter
      selftests/nolibc: add cc-option compatible with clang cross builds
      selftests/nolibc: run-tests.sh: avoid overwriting CFLAGS_EXTRA
      selftests/nolibc: don't use libgcc when building with clang
      selftests/nolibc: use correct clang target for s390/powerz
      selftests/nolibc: run-tests.sh: allow building through LLVM

 tools/include/nolibc/arch-aarch64.h          |  4 +--
 tools/include/nolibc/arch-arm.h              |  8 +++---
 tools/include/nolibc/arch-i386.h             |  4 +--
 tools/include/nolibc/arch-loongarch.h        |  4 +--
 tools/include/nolibc/arch-mips.h             |  8 ++++--
 tools/include/nolibc/arch-powerpc.h          |  6 ++--
 tools/include/nolibc/arch-riscv.h            |  4 +--
 tools/include/nolibc/arch-s390.h             |  4 +--
 tools/include/nolibc/arch-x86_64.h           |  4 +--
 tools/include/nolibc/compiler.h              | 24 +++++++++++-----
 tools/testing/selftests/nolibc/Makefile      | 41 +++++++++++++++++++---------
 tools/testing/selftests/nolibc/nolibc-test.c |  4 +--
 tools/testing/selftests/nolibc/run-tests.sh  | 16 ++++++++---
 13 files changed, 83 insertions(+), 48 deletions(-)
---
base-commit: ae1f550efc11eaf1496c431d9c6e784cb49124c5
change-id: 20240727-nolibc-llvm-3fad68590d4c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


