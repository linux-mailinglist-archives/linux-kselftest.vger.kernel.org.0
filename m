Return-Path: <linux-kselftest+bounces-47688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA8CCADE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A054303C2BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7117330679;
	Thu, 18 Dec 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNDEIbmn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01E2F12CA;
	Thu, 18 Dec 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045582; cv=none; b=hDau27GV0cQy4OvvBD9KADD7WU2c8kZTzQVSpqr1gt/cxyFEpEOJ2JqXA9Zby417ou9Pa8oHpQ5remIIQFuHg4NaTkLikPNO2z6+I+FzkRNurzoMmirLNRr2ecTEfcXQa126iFsTmMefZVaSFLUIoPyacl32HnTAk0D8Sjvl4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045582; c=relaxed/simple;
	bh=kPQRcvC7WfSPYhzJwayZjYIsAWbvmKAaCwsniNqkt7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knadrPfPwmm+b6SqAJE/+lz07RedjR+JcgkgF71jkzfvzrC6RhVncY6PIGM6foBFJOZYWBaIryvNZZfWcMNYADQF39hKMTpwLo01HBGGEnxGWwQaij3uwF3e5S/ykRZCWV0UkRX01kkhJCw7prDfGONryvmuis/KUJc4nDcp+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNDEIbmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD54C113D0;
	Thu, 18 Dec 2025 08:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045581;
	bh=kPQRcvC7WfSPYhzJwayZjYIsAWbvmKAaCwsniNqkt7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jNDEIbmnWGZ5xe3caj5iK+JefJd+0K9WJ0bqjEItqZ4Ax3S0/Eg2yFSr6jzcgq3fV
	 YH9fRSNsJWYoRbDLfTTSgiLAbWWtht3osjPIBiAYw7eg73SugwJjc/SJgIPV5uls+M
	 R542E98nqWG9yc/POXovJQgzTW/EqoxK4UEtAkq77EDAeFQT5Ae5zZSHZ5sRMzRG2X
	 YUpXCnyNqVst12jP//HtBJ7kNhWgbvUmfRmCmEMx1z5T228Te/lsV2d0N/aqiWLw5s
	 b9ksT/6RHrcVd1eEu88Ao91fEYdI3joX6OJbfigDFozqQ8Y0L/7lwQ96m6FdeYmISc
	 LqwdNEntYSB+A==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Dec 2025 08:10:06 +0000
Subject: [PATCH v23 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clone3-shadow-stack-v23-1-7cb318fbb385@kernel.org>
References: <20251218-clone3-shadow-stack-v23-0-7cb318fbb385@kernel.org>
In-Reply-To: <20251218-clone3-shadow-stack-v23-0-7cb318fbb385@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 CarlosO'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Rich Felker <dalias@libc.org>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3646; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kPQRcvC7WfSPYhzJwayZjYIsAWbvmKAaCwsniNqkt7c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpQ7d6whj/pB24OzdyEDg6QA3mhXAv8CI8+PPID
 LWorYWSy7SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUO3egAKCRAk1otyXVSH
 0Ne+B/9cF0EEL56snz9RmBIdM0oxWpZPDSNILdtEK+P5nmEYgGm/jQns2le1ZJ+/0thlA+eK4jh
 aORotdpZGq1RP79sUogPG/m7fxL8dIs1El8JuNC8krTB9AtFBonCAw63OicRxDZcxL6my91lrZe
 TG7UsuDnCty01bhOrEZHJ6Twf0EylaKtcniaY26KkluIIGVg4m9eD3yRVml90Z+6E/A8YuvhgtM
 bpiwhtOhCaF4DPLfs4xJTSXmWK47k6lRs2APCVq/xK0tS0AUdoI3YvpOkTadVF6t63fqIuOOtMd
 x+dR0KqBxj4zFxMehkOFEopVJ6US0GpzDk2cf2hAXU8d3Zkb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently as a result of templating from x86 code gcs_alloc_thread_stack()
returns a pointer as an unsigned int however on arm64 we don't actually use
this pointer value as anything other than a pass/fail flag. Simplify the
interface to just return an int with 0 on success and a negative error code
on failure.

Acked-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h | 8 ++++----
 arch/arm64/kernel/process.c  | 8 ++++----
 arch/arm64/mm/gcs.c          | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 8fa0707069e8..534ea5ae9281 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -64,8 +64,8 @@ static inline bool task_gcs_el0_enabled(struct task_struct *task)
 void gcs_set_el0_mode(struct task_struct *task);
 void gcs_free(struct task_struct *task);
 void gcs_preserve_current_state(void);
-unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
-				     const struct kernel_clone_args *args);
+int gcs_alloc_thread_stack(struct task_struct *tsk,
+			   const struct kernel_clone_args *args);
 
 static inline int gcs_check_locked(struct task_struct *task,
 				   unsigned long new_val)
@@ -171,8 +171,8 @@ static inline void put_user_gcs(unsigned long val, unsigned long __user *addr,
 				int *err) { }
 static inline void push_user_gcs(unsigned long val, int *err) { }
 
-static inline unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
-						   const struct kernel_clone_args *args)
+static inline int gcs_alloc_thread_stack(struct task_struct *tsk,
+					 const struct kernel_clone_args *args)
 {
 	return -ENOTSUPP;
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index fba7ca102a8c..4dadc70df16b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -299,7 +299,7 @@ static void flush_gcs(void)
 static int copy_thread_gcs(struct task_struct *p,
 			   const struct kernel_clone_args *args)
 {
-	unsigned long gcs;
+	int ret;
 
 	if (!system_supports_gcs())
 		return 0;
@@ -310,9 +310,9 @@ static int copy_thread_gcs(struct task_struct *p,
 	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;
 	p->thread.gcs_el0_locked = current->thread.gcs_el0_locked;
 
-	gcs = gcs_alloc_thread_stack(p, args);
-	if (IS_ERR_VALUE(gcs))
-		return PTR_ERR((void *)gcs);
+	ret = gcs_alloc_thread_stack(p, args);
+	if (ret != 0)
+		return ret;
 
 	return 0;
 }
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 6e93f78de79b..3abcbf9adb5c 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -38,8 +38,8 @@ static unsigned long gcs_size(unsigned long size)
 	return max(PAGE_SIZE, size);
 }
 
-unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
-				     const struct kernel_clone_args *args)
+int gcs_alloc_thread_stack(struct task_struct *tsk,
+			   const struct kernel_clone_args *args)
 {
 	unsigned long addr, size;
 
@@ -59,13 +59,13 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 	size = gcs_size(size);
 	addr = alloc_gcs(0, size);
 	if (IS_ERR_VALUE(addr))
-		return addr;
+		return PTR_ERR((void *)addr);
 
 	tsk->thread.gcs_base = addr;
 	tsk->thread.gcs_size = size;
 	tsk->thread.gcspr_el0 = addr + size - sizeof(u64);
 
-	return addr;
+	return 0;
 }
 
 SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)

-- 
2.47.3


