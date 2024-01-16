Return-Path: <linux-kselftest+bounces-3047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E77DB82E473
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 01:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A482B229BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 00:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AD3882D;
	Tue, 16 Jan 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzrUsXun"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715712B9B;
	Tue, 16 Jan 2024 00:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137BBC433C7;
	Tue, 16 Jan 2024 00:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364003;
	bh=Yl9Yg6F6se3dWnQow9MVEEPk2UXoqmeIobF4J1TIbr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FzrUsXunQjRCSns/CHlZzQrt8tJehnYIALFv6Oimn/C+WUMu2gcqLs8+FYXbLBaAI
	 f8gScFuR99BM8zZ8kXIzVzR6wZ7McEtA/WS3W42tNb0w8rmfuMxvpXsQF+kSEWo/k9
	 ECE4QPBVpxYv0OK0KFO3HBP8OxUqo397Mmkv62OH7pnpylw/eY+BOPynoxLUwka/e2
	 ajjEKhElSmC47Z8AnZmC/uEdHMOkJ9ZzqHbNrAhDoLDuMBVllo5MYFysrlxDisR0oL
	 +x10tS9SqKtm2toXI0+rswc2LRFCX/35WOTn2DpM3kstGbCpVySmR6hzuYAftdsI3A
	 uvay2eskiBk9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 09/18] selftests/nolibc: use EFI -bios for LoongArch qemu
Date: Mon, 15 Jan 2024 19:12:51 -0500
Message-ID: <20240116001308.212917-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001308.212917-1-sashal@kernel.org>
References: <20240116001308.212917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit bdeeeaba83682225a7bf5f100fe8652a59590d33 ]

qemu for LoongArch does not work properly with direct kernel boot.
The kernel will panic during initialization and hang without any output.

When booting in EFI mode everything work correctly.

While users most likely don't have the LoongArch EFI binary installed at
least an explicit error about 'file not found' is better than a hanging
test without output that can never succeed.

Link: https://lore.kernel.org/loongarch/1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20231031-nolibc-out-of-tree-v1-1-47c92f73590a@weissschuh.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/nolibc/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index a0fc07253baf..eb258ae1d948 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -88,6 +88,13 @@ QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
+QEMU_BIOS_DIR = /usr/share/edk2/
+QEMU_BIOS_loongarch = $(QEMU_BIOS_DIR)/loongarch64/OVMF_CODE.fd
+
+ifneq ($(QEMU_BIOS_$(XARCH)),)
+QEMU_ARGS_BIOS = -bios $(QEMU_BIOS_$(XARCH))
+endif
+
 # QEMU_ARGS : some arch-specific args to pass to qemu
 QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -101,7 +108,7 @@ QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
+QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
-- 
2.43.0


