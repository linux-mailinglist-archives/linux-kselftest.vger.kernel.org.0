Return-Path: <linux-kselftest+bounces-41453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB8B57130
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D91B189C400
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 07:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C42D5C91;
	Mon, 15 Sep 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aFWdyqAk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741952D46BB;
	Mon, 15 Sep 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920927; cv=none; b=usHI52CPYhJTgiN7+TVRqr7rvC15q6PNWeFH7KgVOKFZTspJyNiiRExrU+vc4gUslXfLDjU3G1E31ciVmzlZRCeE+zMnAnTMO8IkMuzBkL8q1TlpFkm2o81vOiG+4Qkek0+IlsThGhblFjOLAfPj/dkSu7DC5abmtydckHHYOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920927; c=relaxed/simple;
	bh=5zo6GFc4izq4L/TOFgQ8My2XBCCoU7RHkkhmBxTMRvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sn6rkTEo2nZEd3VCHlusr9hf0cSS3IcEXEk5zzzF2VB0Vh9k9neDrYStdGdaTPwbDAV6yIh19IfGJ2l10l/Hwx64kEA/tctVNIayBcU69CqpjcPKFQbcC6wXySJXES6ZGltvO+RxDjVKKwVaALkb3DlGS+v92a5ia3GJroc7+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aFWdyqAk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=x19kbUYL2Cg9MV223qYaCq31NCabilripCrs7bHYZWA=; t=1757920924; x=1759130524; 
	b=aFWdyqAkF8rSnhzMNpYiNQ8vjDhG6jD8MoBO5t7YtgcPtTCGuw5ZrJVzW9/yWxgMjtUU5ENWRqs
	U5QCjt2DT8dY1691tWgsf7wMAEhS3A+XpuRIKjumKb3cRApsOSLldptTuoKwSkllSPdtkmOe/IB3B
	k4F8U5OuRsEt1N6USLuZvBfqq3O74bgg2z/xVM0Yx/dW8z7hBmAHG+7jV+yS2XXY8zU5tfqCWhqbX
	dGE/5vsdeYTRimx9aQ1+tYCT2tC32Jo0+WvLw4rSEn4Oiy77yrF11mMt8aadeEHYyiAvh9u/CW7Mm
	X6ebzQNmRHzZ7NWYisesOYmBelAbKi30ln9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XC-00000005w6o-3hKR;
	Mon, 15 Sep 2025 09:21:59 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/9] Start porting UML to nolibc
Date: Mon, 15 Sep 2025 09:11:06 +0200
Message-ID: <20250915071115.1429196-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

For a while now, we have discussed that it may be better to avoid using
libc inside UML as it may be interfering in unexpected ways with kernel
functionality. A major point of concern is that there is no guarantee
that the libc is not using any address space that may conflict with
kernel addresses.

This patchset is an attempt to start a nolibc port of UML. The goal is
to port UML to use nolibc in smaller chunks to make the switch more
manageable.

There are three parts to this patchset:
 * Two patches to use tools/include headers instead of kernel headers
   for userspace files.
 * A few nolibc fixes and a new NOLIBC_NO_STARTCODE compile flag for it
 * Finally nolibc build support for UML and switching two files

The first two parts could be merged independently. The last step to use
nolibc inside UML obviously depends on the first two.

Benjamin

Benjamin Berg (9):
  tools compiler.h: fix __used definition
  um: use tools/include for user files
  tools/nolibc/stdio: remove perror if NOLIBC_IGNORE_ERRNO is set
  tools/nolibc/dirent: avoid errno in readdir_r
  tools/nolibc: use __fallthrough__ rather than fallthrough
  tools/nolibc: add option to disable startup code
  um: add infrastructure to build files using nolibc
  um: use nolibc for the --showconfig implementation
  um: switch ptrace FP register access to nolibc

 arch/um/Makefile                              | 32 ++++++++++++++++---
 .../um/include/shared/generated/asm-offsets.h |  1 +
 .../include/shared/generated/user_constants.h |  1 +
 arch/um/include/shared/init.h                 |  2 +-
 arch/um/include/shared/os.h                   |  2 ++
 arch/um/include/shared/user.h                 |  5 ---
 arch/um/kernel/Makefile                       |  2 +-
 arch/um/kernel/skas/stub.c                    |  1 +
 arch/um/kernel/skas/stub_exe.c                |  4 +--
 arch/um/os-Linux/skas/process.c               |  6 ++--
 arch/um/os-Linux/start_up.c                   |  4 +--
 arch/um/scripts/Makefile.rules                | 10 ++++--
 arch/x86/um/Makefile                          |  6 ++--
 arch/x86/um/os-Linux/Makefile                 |  5 ++-
 arch/x86/um/os-Linux/registers.c              | 22 +++++--------
 arch/x86/um/user-offsets.c                    |  1 -
 tools/include/linux/compiler.h                |  2 +-
 tools/include/nolibc/arch-arm.h               |  2 ++
 tools/include/nolibc/arch-arm64.h             |  2 ++
 tools/include/nolibc/arch-loongarch.h         |  2 ++
 tools/include/nolibc/arch-m68k.h              |  2 ++
 tools/include/nolibc/arch-mips.h              |  2 ++
 tools/include/nolibc/arch-powerpc.h           |  2 ++
 tools/include/nolibc/arch-riscv.h             |  2 ++
 tools/include/nolibc/arch-s390.h              |  2 ++
 tools/include/nolibc/arch-sh.h                |  2 ++
 tools/include/nolibc/arch-sparc.h             |  2 ++
 tools/include/nolibc/arch-x86.h               |  4 +++
 tools/include/nolibc/compiler.h               |  4 +--
 tools/include/nolibc/crt.h                    |  3 ++
 tools/include/nolibc/dirent.h                 |  6 ++--
 tools/include/nolibc/stackprotector.h         |  2 ++
 tools/include/nolibc/stdio.h                  |  2 ++
 tools/include/nolibc/stdlib.h                 |  2 ++
 tools/include/nolibc/sys.h                    |  3 +-
 tools/include/nolibc/sys/auxv.h               |  3 ++
 36 files changed, 108 insertions(+), 47 deletions(-)
 create mode 120000 arch/um/include/shared/generated/asm-offsets.h
 create mode 120000 arch/um/include/shared/generated/user_constants.h

-- 
2.51.0


