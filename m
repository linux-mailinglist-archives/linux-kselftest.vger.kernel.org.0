Return-Path: <linux-kselftest+bounces-3051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC5682E4AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 01:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016C8B23074
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 00:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB581B7E2;
	Tue, 16 Jan 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noflotDk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1DD1D69C;
	Tue, 16 Jan 2024 00:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEF9C43390;
	Tue, 16 Jan 2024 00:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364041;
	bh=ZO2PWE9bECNpGOyQt9OHBLtp54IKPBgy6OU+PB87aK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=noflotDkJKKvxwQAAIvwwRi9Siy4ygyLWgnXFbpu9cctrpOna1XaA//zwlDoqF9QL
	 o+I+j+XMyMXfT5poq3y7aJA1El3PWFnXT2jiRrcIsK6xLW79F6fpRktR3pFskL+3YR
	 U6VuNngcyQsEUuXHFoGkrQXDWRXs5qB55H4FIR6gvy5GHXC/1aGk8koWx0udtbBu3r
	 RrPPTrNReC0CUOKD7ufU5JYvShIpBDV9iHR1BQkHA32N2zZSghqCeNP/LDRqKS9ZRQ
	 wcx+4pzthQZFQRkOPRnQLy7AnFNe0eMvxjdvPT58fvjdKVl5bJo2LA3P8hBLPQYrhD
	 3CjVlz4vfSHFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/14] selftests/nolibc: use EFI -bios for LoongArch qemu
Date: Mon, 15 Jan 2024 19:13:34 -0500
Message-ID: <20240116001347.213328-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001347.213328-1-sashal@kernel.org>
References: <20240116001347.213328-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index dfe66776a331..be7711014ade 100644
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


