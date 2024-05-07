Return-Path: <linux-kselftest+bounces-9658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 610DE8BF09E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 01:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF182B24240
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 23:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B02135A57;
	Tue,  7 May 2024 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQWDrCIC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1F135A4D;
	Tue,  7 May 2024 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122811; cv=none; b=O2Mw3aRtSOdMiwUp8eiBBlJ+5WH6rUTMnhh2ynamll28wC0IpgqxYg1E0RPH1j+ctiCbvaPa4KGOiHZ3lPpnZhszSCq7DtqiX5imfk0kShYwBn+4PuL3LHjGoZVq49djL4P64qOZgsEBCTM6I5L2XIPxmPlftuQW7X8JaBYixOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122811; c=relaxed/simple;
	bh=+c40Uhf6KzmTtn+fKaywtRA/07JP5WBu9P0At09HAK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPRejgAePhrIvYk2Np+/PhxY+lc+/mB3xiIj0pkvoasxS0ypQmttaUJsNnbyWiVRUL2gfEgwj0cbhJH52aHhpemMTclSBeeGy5OugoEACfV1CrKuWPhUJZUMipoOiasWvxc6kcknjn6IngJ9mvM44irKPw7CJRFWFA906LLLXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQWDrCIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B72AC2BBFC;
	Tue,  7 May 2024 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122811;
	bh=+c40Uhf6KzmTtn+fKaywtRA/07JP5WBu9P0At09HAK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQWDrCICenpho1cbg1yyMm2xbo9LJhZRahvfkzGxO/ned9oRRVm5Ztpe/qY5nzBsr
	 4PeWELTBy0TFdjTqY4fH7e+V1HDTXGtTkOBHjdkiw2ERx095++p+ujRSAm4TWlaTih
	 LO+6EYziWcrE3j/08kQ3DwgszSEfsQO/YNeCkOFd9fhNFcmpbexsjWJxiRG4k/x3Kj
	 eAykwGRclA/z5xbFkgVR4gW9l2MFhGngfwZpkd0Xj8op29MoCXp3hU8t/J6V2uNzcK
	 p3RssMoY96qZ2Spnejp7FCd9fQC06F2KP3fXgxtgMDtbRFDSXRhG5eCBfu7F0sEAsd
	 35oiSZlumcCSg==
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
Subject: [PATCH AUTOSEL 6.6 18/19] selftests: sud_test: return correct emulated syscall value on RISC-V
Date: Tue,  7 May 2024 18:58:40 -0400
Message-ID: <20240507225910.390914-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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


