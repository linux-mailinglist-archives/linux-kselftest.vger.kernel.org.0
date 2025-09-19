Return-Path: <linux-kselftest+bounces-41962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A05B8A527
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D293B639F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D3318153;
	Fri, 19 Sep 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NhvMMFDu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA1263F52;
	Fri, 19 Sep 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296167; cv=none; b=fQsyI9IJ4GGKP9ZbIgjj6FaMX95WQOSaxqvPKq63W/LI/oyz8IHIerLEGrh3PjqaRW1Di9Q6r6xTWQ35E2DZ6A0y1iZoMR2RM4Ox304ZLYDgWf5Q1rpyyp7SDx4xQF/RBCEW6m0zisXW5U97SsCQvIlK9feg4JMueKyVAEyz2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296167; c=relaxed/simple;
	bh=PRT07XBigAUomxauCtvGE3E/7dxDQ7qSMfDJLAMwWiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bwQGb9hx+mCH35bNcMqG6qbUOMVe1cBlxvv7YCJAjSI0iLI8w0INfccIcyXPD9JYIZPmJadQjH6mDbwk9xYLrPGwaI7k+U69hp6ddFtdtEhfFsw16hIJBIti4QYGTQntppWPegb/cZ8UWleKY9sYycljPsJG+NBnt7RG9iOm01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NhvMMFDu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2kkh21e/IwlRCoBO9MaQ5jF2MRbtUk5+kD17PYi26nM=; t=1758296163; x=1759505763; 
	b=NhvMMFDu9PjXFroQy0jvBoXRHAOJW6LjOVjQVMr+lCe2r4IqR84kQt6QOiz1hf6S8yTDuuYnaYp
	++kxr3uCsG8BywdK4k2bdL+ZIwcSiM27N5KPkOZVbCgTX6EaMI8pmvp/hv0HZn+6OoMoEXkNqu+iZ
	7rTKwGRJc2rzVqNc6nWY5AneBLvDGQi5CK6wNNb94OCGOGuYWhBtmEeIRNUzDp/wLXXkCZlWVmZ7W
	JXlgrgaYmNxzK5+HImQTDkKA/Z/MPNDGunVx8ycwXq+By3gxHQ5xPvwNoL4MpKwzEUAoosVYrykZi
	bFGZ6LLG/5uTdBClnZrKTjk9WF13QV/5Uc/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9S-0000000G6O6-33lI;
	Fri, 19 Sep 2025 17:35:58 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 00/11] Start porting UML to nolibc
Date: Fri, 19 Sep 2025 17:34:09 +0200
Message-ID: <20250919153420.727385-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Benjamin Berg <benjamin.berg@intel.com>

This patchset is an attempt to start a nolibc port of UML. The goal is
to port UML to use nolibc in smaller chunks to make the switch more
manageable.

There are three parts to this patchset:
 * Two patches to use tools/include headers instead of kernel headers
   for userspace files.
 * A few nolibc fixes and a new NOLIBC_NO_STARTCODE compile flag for it
 * Finally nolibc build support for UML and switching two files while
   adding the appropriate support in nolibc itself.

v1 of this patchset was
  https://lore.kernel.org/all/20250915071115.1429196-1-benjamin@sipsolutions.net/

Changes in v2:
- add sys/uio.h and sys/ptrace.h to nolibc
- Use NOLIBC_NO_RUNTIME to disable nolibc startup code
- Fix out-of-tree build
- various small improvements and cleanups

Should the nolibc changes be merged separately or could everything go
through the same branch?

Also, what about tools/include/linux/compiler.h? It seems that was added
for the tracing code, but it is not clear to me who might ACK that fix.

Benjamin

Benjamin Berg (11):
  tools compiler.h: fix __used definition
  um: use tools/include for user files
  tools/nolibc/stdio: remove perror if NOLIBC_IGNORE_ERRNO is set
  tools/nolibc/dirent: avoid errno in readdir_r
  tools/nolibc: use __fallthrough__ rather than fallthrough
  tools/nolibc: add option to disable runtime
  um: add infrastructure to build files using nolibc
  um: use nolibc for the --showconfig implementation
  tools/nolibc: add uio.h with readv and writev
  tools/nolibc: add ptrace support
  um: switch ptrace FP register access to nolibc

 arch/um/Makefile                             | 38 +++++++++++---
 arch/um/include/shared/init.h                |  2 +-
 arch/um/include/shared/os.h                  |  2 +
 arch/um/include/shared/user.h                |  6 ---
 arch/um/kernel/Makefile                      |  2 +-
 arch/um/kernel/skas/stub.c                   |  1 +
 arch/um/kernel/skas/stub_exe.c               |  4 +-
 arch/um/os-Linux/skas/process.c              |  6 +--
 arch/um/os-Linux/start_up.c                  |  4 +-
 arch/um/scripts/Makefile.rules               | 10 +++-
 arch/x86/um/Makefile                         |  6 ++-
 arch/x86/um/os-Linux/Makefile                |  5 +-
 arch/x86/um/os-Linux/registers.c             | 16 ++----
 arch/x86/um/user-offsets.c                   |  1 -
 tools/include/linux/compiler.h               |  2 +-
 tools/include/nolibc/Makefile                |  2 +
 tools/include/nolibc/arch-arm.h              |  2 +
 tools/include/nolibc/arch-arm64.h            |  2 +
 tools/include/nolibc/arch-loongarch.h        |  2 +
 tools/include/nolibc/arch-m68k.h             |  2 +
 tools/include/nolibc/arch-mips.h             |  2 +
 tools/include/nolibc/arch-powerpc.h          |  2 +
 tools/include/nolibc/arch-riscv.h            |  2 +
 tools/include/nolibc/arch-s390.h             |  2 +
 tools/include/nolibc/arch-sh.h               |  2 +
 tools/include/nolibc/arch-sparc.h            |  2 +
 tools/include/nolibc/arch-x86.h              |  4 ++
 tools/include/nolibc/compiler.h              |  4 +-
 tools/include/nolibc/crt.h                   |  3 ++
 tools/include/nolibc/dirent.h                |  6 +--
 tools/include/nolibc/nolibc.h                |  2 +
 tools/include/nolibc/stackprotector.h        |  2 +
 tools/include/nolibc/stdio.h                 |  2 +
 tools/include/nolibc/stdlib.h                |  2 +
 tools/include/nolibc/sys.h                   |  3 +-
 tools/include/nolibc/sys/auxv.h              |  3 ++
 tools/include/nolibc/sys/ptrace.h            | 52 ++++++++++++++++++++
 tools/include/nolibc/sys/uio.h               | 49 ++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 11 +++++
 39 files changed, 222 insertions(+), 48 deletions(-)
 create mode 100644 tools/include/nolibc/sys/ptrace.h
 create mode 100644 tools/include/nolibc/sys/uio.h

-- 
2.51.0


