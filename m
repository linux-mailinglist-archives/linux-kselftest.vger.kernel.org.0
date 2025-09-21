Return-Path: <linux-kselftest+bounces-42020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09575B8DBB8
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE70189C099
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97EF2D77F6;
	Sun, 21 Sep 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LELg0SYP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0C1863E;
	Sun, 21 Sep 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461116; cv=none; b=QrxPPlhEo0ENw9j2T5YZnO+7SZrrjZ6K8T18NAOhmb+5Q5M8dxRGI+jcESNcE4c1jB5NTHm0IEp43Q95dSzhQWqSHRzv37BJSVJVeCO1FHf5c6VRIbO7hug45f1ymFrrWyvE7/lHJMi0QF9A78c6pT4o7ytXWMwnmX/orZxAPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461116; c=relaxed/simple;
	bh=3qNbncmT90BPzEJJHaLs2HVYvULpPXQpoFHOrv1erBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqa/3CFILxkdT8Aavo3Zyj+2mpYt+pLlSbnBNvHoYVY5mb3dZkmU3Bml/FojyXsEnVXTicDOUFavObiAT5RYOPWT9vgshUqwvvbhCpb+8gElZRTiW5aj1RJlY7+pPGeUZBRVI41nF7npWguiLzrdqIToh8U/On2f+MS6AC457a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LELg0SYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30C5C4CEE7;
	Sun, 21 Sep 2025 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461116;
	bh=3qNbncmT90BPzEJJHaLs2HVYvULpPXQpoFHOrv1erBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LELg0SYPD4AnIDaWLAu7E81AxissJD842S6MuNVrG1RFsyPlCbT2Ikp9npXmc3zS4
	 APgEQFsJdTfs0Xem42FH0e6T3dJgH54tBLpN/ik4OSFIx7jhvw0+bAkA0q+0F/qnqX
	 HJhYX9W8EDUlsAhRXwZF1zReLBAzJFY20RRI5QT5lLWfgMT38DO460BPTDJxvRN2oM
	 TrKd3a4xu8iEx27dZsTRTL2odEMNjeldVunfaK42YRy9B5EGKlQ5WlYLYEJbxnH3pi
	 HOGXJTKhxezIYbL4/T9/XBXpi8ThZFezQNA6ELX1McasStH9dEJiXfqPKnR0FYaV+b
	 ECQXzrJFfGSGA==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 21 Sep 2025 14:21:35 +0100
Subject: [PATCH RFC 1/3] arm64/gcs: Support reuse of GCS for exited threads
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-arm64-gcs-exit-token-v1-1-45cf64e648d5@kernel.org>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
In-Reply-To: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Christian Brauner <brauner@kernel.org>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 Carlos O'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Szabolcs Nagy <nsz@port70.net>, Rich Felker <dalias@libc.org>, 
 libc-alpha@sourceware.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=3650; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3qNbncmT90BPzEJJHaLs2HVYvULpPXQpoFHOrv1erBo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoz/yzTrIqPApQZ0OfMN2FYRkkN4DO788ZCG5kU
 PVriIJMj4CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaM/8swAKCRAk1otyXVSH
 0NHRB/4k36acdvvxC+SKXrPfjdAtzk1eCyj6iuuVO5LAxs4zrxRm6LUg9s4WJ07cPKb3T3N5ZrY
 F5vo4dKHb2F3EndagY7KQOHPaGje9/F1AJ8tt+1wyi1xjZD/F90TZjcft12SK3g4JIjmUu/2aLZ
 07mEKDHO6Q0OUznBkfTP9bwgxcyart2aD/YrHd6zpBMMNlXmV9BzEmC6Bk+6EfbFT9QkQkDwYSX
 30skzdWJVYBR8D9zfh/yAYi7fUnIIS7IfkenPzWzTedNh5i1QNfXBdHO4lu1B64ueOQPVRg+X9R
 NAWweJWKOPneipsyzmQWfGkPxQxVZqC7a/S/hJhXjqSlCy5J
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently when a thread with a userspace allocated stack exits it is not
possible for the GCS that was in use by the thread to be reused since no
stack switch token will be left on the stack, preventing use with
clone3() or userspace stack switching. The only thing userspace can
realistically do with the GCS is inspect it or unmap it which is not
ideal.

Enable reuse by modelling thread exit like pivoting in userspace with
the stack pivot instructions, writing a stack switch token at the top
entry of the GCS of the exiting thread.  This allows userspace to switch
back to the GCS in future, the use of the current stack location should
work well with glibc's current behaviour of fully uwninding the stack of
threads that exit cleanly.

This patch is an RFC and should not be applied as-is. Currently the
token will only be written for the current thread, but will be written
regardless of the reason the thread is exiting. This version of the
patch does not handle scheduling during exit() at all, the code is racy.

The feature is gated behind a new GCS mode flag PR_SHADOW_STACK_EXIT_TOKEN
to ensure that userspace that does not wish to use the tokens never has
to see them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h |  3 ++-
 arch/arm64/mm/gcs.c          | 25 ++++++++++++++++++++++++-
 include/uapi/linux/prctl.h   |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index b4bbec9382a1..1ec359d0ad51 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -52,7 +52,8 @@ static inline u64 gcsss2(void)
 }
 
 #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK \
-	(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE | PR_SHADOW_STACK_PUSH)
+	(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE | \
+	 PR_SHADOW_STACK_PUSH | PR_SHADOW_STACK_EXIT_TOKEN)
 
 #ifdef CONFIG_ARM64_GCS
 
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index fd1d5a6655de..4649c2b107a7 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -199,14 +199,37 @@ void gcs_set_el0_mode(struct task_struct *task)
 
 void gcs_free(struct task_struct *task)
 {
+	unsigned long __user *cap_ptr;
+	unsigned long cap_val;
+	int ret;
+
 	if (!system_supports_gcs())
 		return;
 
 	if (!task->mm || task->mm != current->mm)
 		return;
 
-	if (task->thread.gcs_base)
+	if (task->thread.gcs_base) {
 		vm_munmap(task->thread.gcs_base, task->thread.gcs_size);
+	} else if (task == current &&
+		   task->thread.gcs_el0_mode & PR_SHADOW_STACK_EXIT_TOKEN) {
+		cap_ptr = (unsigned long __user *)read_sysreg_s(SYS_GCSPR_EL0);
+		cap_ptr--;
+		cap_val = GCS_CAP(cap_ptr);
+
+		/*
+		 * We can't do anything constructive if this fails,
+		 * and the thread might be exiting due to being in a
+		 * bad state anyway.
+		 */
+		put_user_gcs(cap_val, cap_ptr, &ret);
+
+		/*
+		 * Ensure the new cap is ordered before standard
+		 * memory accesses to the same location.
+		 */
+		gcsb_dsync();
+	}
 
 	task->thread.gcspr_el0 = 0;
 	task->thread.gcs_base = 0;
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index ed3aed264aeb..c3c37c39639f 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -352,6 +352,7 @@ struct prctl_mm_map {
 # define PR_SHADOW_STACK_ENABLE         (1UL << 0)
 # define PR_SHADOW_STACK_WRITE		(1UL << 1)
 # define PR_SHADOW_STACK_PUSH		(1UL << 2)
+# define PR_SHADOW_STACK_EXIT_TOKEN	(1UL << 3)
 
 /*
  * Prevent further changes to the specified shadow stack

-- 
2.47.2


