Return-Path: <linux-kselftest+bounces-27589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E81CA45D70
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3203A85AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9591217677;
	Wed, 26 Feb 2025 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zmdofZKq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M2Wms+X9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5F258CDB;
	Wed, 26 Feb 2025 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570313; cv=none; b=HxRSMYw2tovUfX/MsJ4M+rBRzlqzeoX9K+wLpx70S+/DqN+KKCrc/6gOoQIyHPUaWDBEr0Bl1shgA55KrXhvb27lc8Slc/dfCAdqWe6S7hORXWKpb5/l7/oBbmuLxrm7JAPlM7AFP0BphY0SyXFzNdmMHY1Cpd+ikF7mLyvMJz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570313; c=relaxed/simple;
	bh=DsKFmSVUXHIq2lUncqo1DiHx1M4YqIuFyrpISSxzmuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VD0jOOvl6XKV2CRNpKv+wed7J683+4RVXmzV42z46U0HXarblQWcBcABGJfguP21g0QzmiN7B4YguvcSleoVpcTuJatIbP+CNb8h24QFqouomQ/olPH5pOJbKSJSTgeaqJMHmJ5r6mB24rAYGjQPFy/b5oWxVe/MBs+rPHpNVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zmdofZKq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M2Wms+X9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740570309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hPrRbYetXyN7EKcl5LmJ1P46VSZ9vvX2TwbzkjWRBsw=;
	b=zmdofZKqnF5afZoMtDDABs/s8ck4H0d6qXMrb2VK48v//E15sLebMbpam6otSiOOptNd8Z
	ovNq4+QRhb5j3MFlhrHsWX/qsPxsTPZC/zfJBOp3mMjcP5Nd4V5Vq+ZbswtF+MD2kFvVuh
	FqdQiGPuIYcFzg8t+ZVmL7j6YNIZ2hqNeB5BwJIMdxO1dSPic4Fu8esBFt1eff5LSx7rKI
	Dco0Y/41bvQw1pyKb8lUEn9k6eazDhsn8BUoDPuIOeRNpvH5Ndsy0NTAbBTX4anxNJ8Fqr
	E5Dekbt2jlXZkS4HxA91OOiwzHR7zL3hUPN+twMSV16Py/V3s7SVfmYgHcl0MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740570309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hPrRbYetXyN7EKcl5LmJ1P46VSZ9vvX2TwbzkjWRBsw=;
	b=M2Wms+X9MOl6/Gm7t1HEt3gxuX6NPlE1lbWyIQHmxqAKMwc98nEfFAUlvRgXOrUE9W00nM
	XBIj/4dU+P52F6CQ==
Subject: [PATCH v2 00/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
Date: Wed, 26 Feb 2025 12:44:39 +0100
Message-Id: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKf+vmcC/3WNywrCMBQFf6VkbSSJtWld+R9SJI8be0GSktRQK
 f130y5Fl3Ng5iwkQURI5FItJELGhMEXEIeKmEH5B1C0hYlgouaMSzqqmOCebQrUhydqQ4E1nVZ
 KOle3pHhjBIfz3rz1hQdMU4jv/SLzbd1qZ8YF+1HLnDKqnQWuu1rVhl+f6F9TDB7no4XtYLcFO
 /2zO6Mb0bRWSg1fdr+u6wcLOFkP9AAAAA==
X-Change-ID: 20241017-parse_vdso-nolibc-e069baa7ff48
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740570307; l=3393;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DsKFmSVUXHIq2lUncqo1DiHx1M4YqIuFyrpISSxzmuQ=;
 b=TC6HO3n1Fyr0Lj0hLMyg0/ixUTpUZ+35yMdWTwE8xXub343tQnGH7Rach2zk0DD5JzUBeKJ2W
 Jg6/cXXIKiDDMcUHTLoJNg25mjaT6VJ1Pl6t+TJOGHoDMKCRhY1cRzM
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For testing the functionality of the vDSO, it is necessary to build
userspace programs for multiple different architectures.
It is additional work to acquire matching userspace cross-compilers with
full C libraries and then building root images out of those.
The kernel tree already contains nolibc, a small, header-only C library.
By using it, it is possible to build userspace programs without any
additional dependencies.
For example the kernel.org crosstools or multi-target clang can be used
to build test programs for a multitude of architectures.
While nolibc is very limited, it is enough for many selftests.
With some minor adjustments it is possible to make parse_vdso.c
compatible with nolibc.
As an example, vdso_standalone_test_x86 is now built from the same C
code as the regular vdso_test_gettimeofday, while still being completely
standalone.
Also drop the dependency of parse_vdso.c on the elf.h header from libc and only
use the one from the kernel's UAPI.

While this series is useful on its own now, it will also integrate with the
kunit UAPI framework currently under development:
https://lore.kernel.org/lkml/20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Provide a limits.h header in nolibc
- Pick up Reviewed-by tags from Kees
- Link to v1: https://lore.kernel.org/r/20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de

---
Thomas Weißschuh (16):
      MAINTAINERS: Add vDSO selftests
      elf, uapi: Add definition for STN_UNDEF
      elf, uapi: Add definition for DT_GNU_HASH
      elf, uapi: Add definitions for VER_FLG_BASE and VER_FLG_WEAK
      elf, uapi: Add type ElfXX_Versym
      elf, uapi: Add types ElfXX_Verdef and ElfXX_Veraux
      tools/include: Add uapi/linux/elf.h
      selftests: Add headers target
      tools/nolibc: add limits.h shim header
      selftests: vDSO: vdso_standalone_test_x86: Use vdso_init_form_sysinfo_ehdr
      selftests: vDSO: parse_vdso: Drop vdso_init_from_auxv()
      selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers
      selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__ instead of ULONG_MAX
      selftests: vDSO: vdso_test_gettimeofday: Clean up includes
      selftests: vDSO: vdso_test_gettimeofday: Make compatible with nolibc
      selftests: vDSO: vdso_standalone_test_x86: Switch to nolibc

 MAINTAINERS                                        |   1 +
 include/uapi/linux/elf.h                           |  38 ++
 tools/include/nolibc/Makefile                      |   1 +
 tools/include/nolibc/limits.h                      |   7 +
 tools/include/uapi/linux/elf.h                     | 524 +++++++++++++++++++++
 tools/testing/selftests/lib.mk                     |   5 +-
 tools/testing/selftests/vDSO/Makefile              |  11 +-
 tools/testing/selftests/vDSO/parse_vdso.c          |  19 +-
 tools/testing/selftests/vDSO/parse_vdso.h          |   1 -
 .../selftests/vDSO/vdso_standalone_test_x86.c      | 143 +-----
 .../selftests/vDSO/vdso_test_gettimeofday.c        |   4 +-
 11 files changed, 590 insertions(+), 164 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20241017-parse_vdso-nolibc-e069baa7ff48

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


