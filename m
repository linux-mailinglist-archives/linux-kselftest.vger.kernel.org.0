Return-Path: <linux-kselftest+bounces-25913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F21A2A7A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059BB1664AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8922C327;
	Thu,  6 Feb 2025 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgxi0nIw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB8228CA2;
	Thu,  6 Feb 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842018; cv=none; b=MXVLdaEazqeDxSihJ3bvc6XWWD/VQnh61YmB1p1Xp47CW5UirktG0UG6s7k1tiX5xa4XnhNTJl8o8V7GZDdkNH2WOs77JXDHP4/+oMqGfXmypuTaPQbpIBfpqZG61npcw2gb4g194nb/a3nW5gSHG9bHrNoMhYyLSVXQC2Cz/gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842018; c=relaxed/simple;
	bh=DlNOYnxspap0qJgmVc/Gm5yAn5fxbHqq9onb8IXtjac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtVUtHaV7xbsbM9VlH93wCv8AM30+ZRHHqXaFDFhTAFb8tnw+6hcLg7+9nFArujT/voisSCUp8sPljr01890/WYMZcLavVY3lDbFDxqIgu+S2jzk97buuMzfe9rnwZh9sPuPFdwjO5kYIcd3czUKOQNjbe/fkS1i0Qaox7AzbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgxi0nIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8143EC4CEE6;
	Thu,  6 Feb 2025 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842017;
	bh=DlNOYnxspap0qJgmVc/Gm5yAn5fxbHqq9onb8IXtjac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dgxi0nIwDdKrVkQofEEMxMlscerl5Nw6DPXyOwRRJuBy/nDPNnqqQxM0sLclTC9+r
	 gCEEQHDHDwMB6TLNTVFfOySFgDlff1Uwjc4GvW10oEc/ErirLOs9yqBXmBks0WMRVf
	 qbAcPotNiic38h4a/buIfXd3vWXt05qfhRZbm+DmUX0zurLRrhHzp+2D645xdwdmvt
	 iI9N2wAuo+vsMpjaR08Sid90pybFh5AbnmhZa8xR6jsa31dquNZGTTZZOYg2E9Cldq
	 mdoWkje2mn1yKEbpkHQahWX+Xmre+Oe30qC7lO9oHn+PzSS+P+CNz3/X/+XFda0Mcx
	 uLMsvOigN/Lzw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 06 Feb 2025 11:38:03 +0000
Subject: [PATCH RFT v14 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-clone3-shadow-stack-v14-1-805b53af73b9@kernel.org>
References: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
In-Reply-To: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DlNOYnxspap0qJgmVc/Gm5yAn5fxbHqq9onb8IXtjac=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnpJ+OQvnyT0+rhQer5acV2/sCH1Pqlw7zB3Ip1695
 PKG7w+iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6SfjgAKCRAk1otyXVSH0KSKB/
 9sobupBvBfI999rxOHq6tTLahomeXanOvhTzdw4gSh/sB6fuvkKpJMWd+jUR3C6GAiOUjpkKOoLbjE
 Unywjx8DzIxE/UGAzt1muyCgt2SeMLtQq5PK3QMxGWjxpcC0/jeePol5GGMrnrJVfR9tgJH5SF2g9M
 5+GORuAedV51e40Wi0l3Hv+irACfpR+CLYRmS6g8bGBT079TuXunFUjDKjozJNr75JFNXSmkearAgi
 VmOw9VCDWV2fUtespMpnhfHBGa8xJt2BTxjyEYfAlh+IS6K7zn/eUMws8Tw26mUg/oxM7/56+AThUF
 yGcTqpY4DvMWMkYctHTNTX0ix7zGlf
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
index f50660603ecf5dc09a92740062df3a089b02b219..d8923b5f03b776252aca76ce316ef57399d71fa9 100644
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
@@ -91,8 +91,8 @@ static inline bool task_gcs_el0_enabled(struct task_struct *task)
 static inline void gcs_set_el0_mode(struct task_struct *task) { }
 static inline void gcs_free(struct task_struct *task) { }
 static inline void gcs_preserve_current_state(void) { }
-static inline unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
-						   const struct kernel_clone_args *args)
+static inline int gcs_alloc_thread_stack(struct task_struct *tsk,
+					 const struct kernel_clone_args *args)
 {
 	return -ENOTSUPP;
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 42faebb7b712328a8bebd25c47b01f09daae3861..45130ea7ea6e8090f09297a32fa71fe86e6532b9 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -297,7 +297,7 @@ static void flush_gcs(void)
 static int copy_thread_gcs(struct task_struct *p,
 			   const struct kernel_clone_args *args)
 {
-	unsigned long gcs;
+	int ret;
 
 	if (!system_supports_gcs())
 		return 0;
@@ -305,9 +305,9 @@ static int copy_thread_gcs(struct task_struct *p,
 	p->thread.gcs_base = 0;
 	p->thread.gcs_size = 0;
 
-	gcs = gcs_alloc_thread_stack(p, args);
-	if (IS_ERR_VALUE(gcs))
-		return PTR_ERR((void *)gcs);
+	ret = gcs_alloc_thread_stack(p, args);
+	if (ret != 0)
+		return ret;
 
 	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;
 	p->thread.gcs_el0_locked = current->thread.gcs_el0_locked;
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 5c46ec527b1cdaa8f52cff445d70ba0f8509d086..1f633a482558b59aac5427963d42b37fce08c8a6 100644
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
2.39.5


