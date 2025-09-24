Return-Path: <linux-kselftest+bounces-42179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C601B9A35C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8FD19C69CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0292306499;
	Wed, 24 Sep 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ddDCWTMi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415B305E3A;
	Wed, 24 Sep 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723714; cv=none; b=Gq4LblpGs/ArWKZCkIwpxQ5Vl2U9p8dMsq/jv6pw1qgFoduvC5CfIjGYkFgihy34w25EzxTvtf1WzQJ1LlZb22WwQIVlipUKUCIESSQ4M5dtm0QoY8eq/oYB78jL5vWiXM+YT8zMN1QZej940DAi4UiPu+bBKb85FQWrq8yzp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723714; c=relaxed/simple;
	bh=6RfkZxt9SVt0gkx84vMWHoTwWf/1relJ7CYJsChwbpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NTt3OpOOBhrfakCy+vlLQ4580RXaeSw1Hs5s8yuAGjjL8gx6K8mJhFgzXSlpXyo7C7lx/FQqWdn0oTzb9knw6kQkwPwOEzZsPHz2VKjpN8RHcOLwlFJ5nCtfUiStfVPcI01pfYJNNYSeqXYOVObYEl73eGcj7R+rwwYDMCbXT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ddDCWTMi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=yTv1BdIbryTeAGyOFxkWnnUwAIwyWmkYx+MS7rF1kYc=; t=1758723713; x=1759933313; 
	b=ddDCWTMiVVobHcmysI2wIM577KBMgZHrNuNOM/sdxNHsbGyKwicwVQnzNm2deC3otO/4PUkZoO8
	p0ypIBknXdpRnkJxjXNuSTN3DoLmM6QHj441qpSAhSQYPxJhVtcIswx79hgGsvPH2q24geDsBqmud
	F2Oh3e8iEVnH2LJ6R64rAqilCdVEv/dpgxOz836oKSopnK6YlUwrMlF/QbRYekISjrRWMdR2Cr7CJ
	rocjVxKthoohHAZ4TnbBF8gLVSFtxyRTa1u6SZkS+dsuQyzkUnaJo09XDC/bfwJvYGKwHyN43H66i
	L2pPmdB/XVwpPXXAy6MuH5CP0H2xwG+5U61g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNP-000000090Bz-2xkC;
	Wed, 24 Sep 2025 16:21:47 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 00/12] Start porting UML to nolibc
Date: Wed, 24 Sep 2025 16:20:47 +0200
Message-ID: <20250924142059.527768-1-benjamin@sipsolutions.net>
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

Using nolibc has the advantage that it is a smaller runtime and it
allows us to be in full control about all memory mappings that are done.
Another libc on the other hand might map memory unaware of UML, causing
collisions with the UML memory layout. Such mappings could even happen
before UML has fully initialized (e.g. rseq being mapped into the
physical or vmalloc memory areas).

There are three parts to this patchset:
 * Two patches to use tools/include headers instead of kernel headers
   for userspace files.
 * A few nolibc fixes and a new NOLIBC_NO_RUNTIME compile flag for it
 * Finally nolibc build support for UML and switching two files while
   adding the appropriate support in nolibc itself.

v1 of this patchset was
  https://lore.kernel.org/all/20250915071115.1429196-1-benjamin@sipsolutions.net

v2:
  https://lore.kernel.org/all/20250919153420.727385-1-benjamin@sipsolutions.net

Changes in v3:
- sys_ptrace is now not a varadic function
- improve printf %m implementation
- keep perror as function available with NOLIBC_IGNORE_ERRNO
- change syscall guard and fix i386 build

Changes in v2:
- add sys/uio.h and sys/ptrace.h to nolibc
- Use NOLIBC_NO_RUNTIME to disable nolibc startup code
- Fix out-of-tree build
- various small improvements and cleanups

Benjamin

Benjamin Berg (12):
  tools compiler.h: fix __used definition
  um: use tools/include for user files
  tools/nolibc/stdio: let perror work when NOLIBC_IGNORE_ERRNO is set
  tools/nolibc/dirent: avoid errno in readdir_r
  tools/nolibc: implement %m if errno is not defined
  tools/nolibc: use __fallthrough__ rather than fallthrough
  tools/nolibc: add option to disable runtime
  um: add infrastructure to build files using nolibc
  um: use nolibc for the --showconfig implementation
  tools/nolibc: add uio.h with readv and writev
  tools/nolibc: add ptrace support
  um: switch ptrace FP register access to nolibc

 arch/um/Makefile                             | 38 ++++++++++++---
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
 arch/x86/um/os-Linux/registers.c             | 20 ++------
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
 tools/include/nolibc/stdio.h                 | 10 +++-
 tools/include/nolibc/stdlib.h                |  2 +
 tools/include/nolibc/sys.h                   |  3 +-
 tools/include/nolibc/sys/auxv.h              |  3 ++
 tools/include/nolibc/sys/ptrace.h            | 44 ++++++++++++++++++
 tools/include/nolibc/sys/uio.h               | 49 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 11 +++++
 39 files changed, 221 insertions(+), 53 deletions(-)
 create mode 100644 tools/include/nolibc/sys/ptrace.h
 create mode 100644 tools/include/nolibc/sys/uio.h

-- 
2.51.0


