Return-Path: <linux-kselftest+bounces-32220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30424AA79D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC089A2CBC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C721F1511;
	Fri,  2 May 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad1pf0qY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132321EF372;
	Fri,  2 May 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212493; cv=none; b=g/x0zV04ZPzyDHz7RiV9SJ60uHgAGdsc1hYFbbCsz6zt6pp1ZGt4TPOfjHZ/RB35AGjQuFDebxRcN77scZHlteWOq1xo4MrWuKnJEyfVKkDtL9Unmnsi4e2NHgvWGbHTNotn2oQU2sq8msMdjKlOetm47PuB0OEQRJy1pkjELa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212493; c=relaxed/simple;
	bh=1wZOixwKxeQr1a/J8UDK8Pi43lF4NiEy/AG7Bfq7Re4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jvLPWy+5MRVkRMf43EBNNz33qYg75iBoGIJz8vN6R5HBiR3hJjMV45vFE3LUxjGZvnNbigH0mMLHeuLIUTmIvAp0rGTlEhS7lD3uKQEarJHmxDX37swFinxTRYDg8VTQLB+rnEcNME4jt3ejsZlq52KSCuLd+sEvd+1dFV135zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad1pf0qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E94C4AF0B;
	Fri,  2 May 2025 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746212492;
	bh=1wZOixwKxeQr1a/J8UDK8Pi43lF4NiEy/AG7Bfq7Re4=;
	h=From:To:Cc:Subject:Date:From;
	b=ad1pf0qYzwltvdPY6h8Js7Wl0DIi8myWiHDbcB1cSBFmzC9mSMZIPVR3BzKgM172m
	 iNbS2PosMuTAbtnfjwddEk4KPhjyGSUg++66mDTKZrsIB5l5jfSyawi9NoRtv+9Ugr
	 9yW2VrOWsvi5+c9H0fxkfqM66iJospU3LRQ+8ichWKhhRhKOJp+Dv1OWNINvU9Ezyg
	 5sIx2RJl+l0vTrSnRFv+OwqUskys08h2ypCepqgKWFG3x7vv8krLXDTq2yxXgyHLtx
	 MK9Twz/c6du9hpjl974CokWewDDKj+Ip54dDwHTqq0tZrmsXUL9WYr1nKApR5jGYep
	 EYLuC24pH8Llg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	kasan-dev@googlegroups.com,
	llvm@lists.linux.dev
Subject: [PATCH RFC 0/4] stackleak: Support Clang stack depth tracking
Date: Fri,  2 May 2025 12:01:23 -0700
Message-Id: <20250502185834.work.560-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=kees@kernel.org; h=from:subject:message-id; bh=1wZOixwKxeQr1a/J8UDK8Pi43lF4NiEy/AG7Bfq7Re4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmiYq0zXwVaP2MzO3LzSIm1wIuVjpVbzNOfXP638PIW1 evsBc8fd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwk6QfDb9YtkgtfuS4K4mA/ bzvl+EbWn7wiUjFvVCN5Q1IPTbA6XMjI8Fxv72puDZ2kv5tVLwqtW5KzIaDc7Xzr9HCGstmZxw5 6MwEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

As part of looking at what GCC plugins could be replaced with Clang
implementations, this series uses the recently proposed stack depth
tracking callback in Clang[1] to implement the stackleak feature.

-Kees

[1] https://github.com/llvm/llvm-project/pull/138323

Kees Cook (4):
  stackleak: Rename CONFIG_GCC_PLUGIN_STACKLEAK to CONFIG_STACKLEAK
  stackleak: Rename stackleak_track_stack to __sanitizer_cov_stack_depth
  stackleak: Split STACKLEAK_CFLAGS from GCC_PLUGINS_CFLAGS
  stackleak: Support Clang stack depth tracking

 Documentation/admin-guide/sysctl/kernel.rst |  2 +-
 Documentation/security/self-protection.rst  |  2 +-
 arch/arm/boot/compressed/Makefile           |  2 +-
 arch/arm/kernel/entry-common.S              |  2 +-
 arch/arm/vdso/Makefile                      |  2 +-
 arch/arm64/kernel/entry.S                   |  2 +-
 arch/arm64/kernel/pi/Makefile               |  2 +-
 arch/arm64/kernel/vdso/Makefile             |  1 +
 arch/arm64/kvm/hyp/nvhe/Makefile            |  2 +-
 arch/riscv/kernel/entry.S                   |  2 +-
 arch/riscv/kernel/pi/Makefile               |  2 +-
 arch/riscv/purgatory/Makefile               |  2 +-
 arch/s390/kernel/entry.S                    |  2 +-
 arch/sparc/vdso/Makefile                    |  3 +-
 arch/x86/entry/calling.h                    |  4 +-
 arch/x86/entry/vdso/Makefile                |  3 +-
 arch/x86/include/asm/init.h                 |  2 +-
 arch/x86/purgatory/Makefile                 |  2 +-
 drivers/firmware/efi/libstub/Makefile       |  6 +--
 drivers/misc/lkdtm/stackleak.c              |  8 ++--
 include/linux/init.h                        |  4 +-
 include/linux/sched.h                       |  4 +-
 include/linux/stackleak.h                   |  6 +--
 kernel/Makefile                             |  4 +-
 kernel/stackleak.c                          |  4 +-
 lib/Makefile                                |  2 +-
 scripts/Makefile.gcc-plugins                | 13 +++---
 scripts/Makefile.ubsan                      | 12 +++++
 scripts/gcc-plugins/stackleak_plugin.c      | 52 ++++++++++-----------
 security/Kconfig.hardening                  | 25 ++++++----
 tools/objtool/check.c                       |  2 +-
 tools/testing/selftests/lkdtm/config        |  2 +-
 32 files changed, 105 insertions(+), 78 deletions(-)

-- 
2.34.1


