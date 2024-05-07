Return-Path: <linux-kselftest+bounces-9660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D48BF115
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 01:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23FBB222BC
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAA113BC37;
	Tue,  7 May 2024 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5cIlWao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423B13BC33;
	Tue,  7 May 2024 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122890; cv=none; b=tuPS+nxsXusKCEbf/OcCT6Gzvzpt6wrnetZ6Djhyzakg91XqInmcRs2EfyGefbNA1fFvildhi3TnC1YSuPFQOwXo4wpRTRARncMgdrpdNWoG1AUXh/LTGClkU9QnovKN8l+u4Pqt7Wxw35pZf3ab9QFej5PZUZFLwEWhlxacIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122890; c=relaxed/simple;
	bh=+c40Uhf6KzmTtn+fKaywtRA/07JP5WBu9P0At09HAK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cneTdr9B911xZfySRmeupHkO7b8+mk2w+3+YQ52B0xj942yjGVie9i6XxsTskC0QsnVgZugHRhLSkq+ZUwmfFkixa50FVUHBSVcJj4e4phYt2t5O8hdbncS8hLhqtmBHdLeX8Psyvur/HeyNw6pF1ns5/SdsVEGz538KXfQBy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5cIlWao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEEBC2BBFC;
	Tue,  7 May 2024 23:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122890;
	bh=+c40Uhf6KzmTtn+fKaywtRA/07JP5WBu9P0At09HAK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5cIlWaoOyk+pWZMz21NjhhRHibSOAvRkU9dUKLaR9nFDuyU0AHluFcm49F+9Wyl9
	 LFgLUCkJZ/UryuxaVrMSVZNNkmxdPnK/QppE+2bzYNb8KbZlW5ohKwggZYwptdSKR0
	 zyOZlKfedKT/ZVvMBu6EadHNQVmXdH2b47bh+7yIIXtnknfKeGTIP3cxidAmEJojVM
	 l5Sj/5LJnTY1E2883GuapLI4r0GnCJGsMLX3EpveE8v0FWl6oK7dfmaGrhhDy3SH7W
	 URLOAX/Mundj8SqRp/qJH8GBN8xuNswAwHMtMWiWSglB0uD/Zv5/fqNh4zhCVVMeLL
	 pNrvX5nN9btvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 5/5] selftests: sud_test: return correct emulated syscall value on RISC-V
Date: Tue,  7 May 2024 19:01:09 -0400
Message-ID: <20240507230115.391725-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230115.391725-1-sashal@kernel.org>
References: <20240507230115.391725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
Content-Transfer-Encoding: 8bit

From: Clément Léger <cleger@rivosinc.com>

[ Upstream commit 17c67ed752d6a456602b3dbb25c5ae4d3de5deab ]

Currently, the sud_test expects the emulated syscall to return the
emulated syscall number. This assumption only works on architectures
were the syscall calling convention use the same register for syscall
number/syscall return value. This is not the case for RISC-V and thus
the return value must be also emulated using the provided ucontext.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20231206134438.473166-1-cleger@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/syscall_user_dispatch/sud_test.c     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b5d592d4099e8..d975a67673299 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -158,6 +158,20 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 
 	/* In preparation for sigreturn. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	/*
+	 * The tests for argument handling assume that `syscall(x) == x`. This
+	 * is a NOP on x86 because the syscall number is passed in %rax, which
+	 * happens to also be the function ABI return register.  Other
+	 * architectures may need to swizzle the arguments around.
+	 */
+#if defined(__riscv)
+/* REG_A7 is not defined in libc headers */
+# define REG_A7 (REG_A0 + 7)
+
+	((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A0] =
+			((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A7];
+#endif
 }
 
 TEST(dispatch_and_return)
-- 
2.43.0


