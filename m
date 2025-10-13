Return-Path: <linux-kselftest+bounces-42987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D90CCBD2387
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06D284EB8F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F02FB978;
	Mon, 13 Oct 2025 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DL+q8Czd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2151BDCF
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346813; cv=none; b=X71WTtnhtDDl/n2vy6N7eP+/jH5CV7EVxWCM9aXhSCnLWWhyDN3ezaXuQ/1ni6+nTVhNbjSalw0JkACxOdQtmn1ja2j1K9Plbrkk+5KGm88oRtiVwmd+lCtmNIOHvQwkfF+kBocCszNwYhN/YT4NYgWfXNZF1KvrDjIQYRQvLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346813; c=relaxed/simple;
	bh=qSWrxNVvK5O9D9jD1MXkG9Dpx7QjubRRK8pdKRIn+3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWbcF5UwYuD2e4Ym+Fak+o5oQ86OZgcoILMKN3nsMNdN4B92TavBCnQJ4AiTT7E3D3tNlmaBcXCN/rOA+cAkubr8V5vFNyEBcz5qGmXOCd/o2n9yx6VlwKXCtvHGePwbwnRuSR5GKaXRQmTSRjaM6ZttCNC8IWwNL+ORvs70b0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DL+q8Czd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so3491195a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760346811; x=1760951611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8Y70FtM73eem1DqR0aER86RyTdB5RacsbefhqzztUc=;
        b=DL+q8Czd7lxOGQ5+uJtNLL6/3RwGUC+16ttjYF5vCztgfoRp/gKLiwyuLF+PWnjutC
         rz5Qeetig32kPD7iIwk/oac8G4A3G7PNXneLcGyeEtFpcWmmJTgLxMAdicJtr9q7Qkre
         kNeXltuERW+7O6IP9d48VTWhU2nQXZsFCifASsHvxsbPDq5RoGDgg7+1FN82jhDLSRFR
         lUPu3M/5zg4U5CyyeO5FyBasASqx9epEgBQWtL3ESvnHFXwBpmudZEZL1u1vW2pFAKmU
         k2LuGnZMDnox6sGvhksaledYdItCA2l/uTAb81zhm2N0hHyl5ruUVGb9vkifQvdxkKkQ
         nlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760346811; x=1760951611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8Y70FtM73eem1DqR0aER86RyTdB5RacsbefhqzztUc=;
        b=bKMlZ34PzPksUmv7o3uBrzaus/lY+8x0P8O93/b/LOsDAObDfehkHYSLBWZEcQIHuE
         bbBYLvPtCmLPApx45U9CAJirFFcPEe3E29a5DxD62cL3nwkUta7ZvJr9z/WtQHCGq5ud
         G5Mj1hBS6T+sKonb8rZDt+R8aiKurkZ5F407u9LaQ2b7io0zS1zr81b7JwvGLlcSIjUa
         AgAeD+JudZpqy5IX31q/8f0PIdTd05QdjCxVNf36VR2Vj2+A2yAjkV7egKtzTTtJNZdm
         QmNKSvznPUxpz87C/CiwMq3vZLPY8+Dg5PW1pCVnEtjoEzgg/ghxI7g0gRJagFtYxBLv
         brKw==
X-Forwarded-Encrypted: i=1; AJvYcCX9YEJ+rVtZI1O8G8Co6qzgRl4N8mKugjxSR41OkzMxYkMW8+18VFU7tcFWiGpZ9T37VoqTd6ajOZy6BVbrwGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEQltD4lbQ/95xSHDL4bC0URPXgKhuNMwoeI/IoTbo3VHYkTx
	unXE5+TrVgThGfZn/yuxuFLBDNCECLfud6Ap7F6zfKYWbdIS6Jv65SWdFGEFrlNvdmI=
X-Gm-Gg: ASbGncsZV8uFd6RtBTpY4g/GDSP3hxiI4Ud9qzrF0j3y/fuXb1X/8ZQ3gzHFo+Dnl7v
	bPu6T6eaG4KbXQb4XPRle68ldBUmIb9MtOrs2YuXlICFnyGnTj98wvRYnEhRCLleYoE/7UdOBX9
	1phaaoapbJjgNvA84NldZd0qfVQGiSDpRAfB+haAoBLNTrECmkSUwse0uAPnCa2UQweew5kFVhJ
	yQkhxNN2MDvO3e391w5B27sFqLVvSCtZ2hAiN7l/aR0Lf2gErnymkX03VPy2sCurCYkNGSCQI6x
	C/dqQQD7NgDJ7B2W91uybEIq0ChJ2V0V7T7t7N9zE2v2ICj4Fu/e5W/r8qFI81V9ryl1JX71+6O
	8/wa1vDoYLSTGgFviLs6XGgPn1el7L6HHxatK5RSvO3aF5qBOi0hlnMPEn2piAOF2QtSRUCA=
X-Google-Smtp-Source: AGHT+IGE6p2GX8nv0LK6w4qN/cEZpc/XaGzoZf/flFr9L0xcubk7H6sKJW7BAPJLpx7bcAcNWpCDXw==
X-Received: by 2002:a17:90b:4a84:b0:32e:a10b:ce48 with SMTP id 98e67ed59e1d1-33b51114f9emr30667288a91.12.1760346810709;
        Mon, 13 Oct 2025 02:13:30 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cc0dsm11727220a91.9.2025.10.13.02.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:13:30 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Joel Granados <joel.granados@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>
Subject: [PATCH v2 1/2] riscv: ptrace: Optimize the allocation of vector regset
Date: Mon, 13 Oct 2025 17:12:31 +0800
Message-ID: <20251013091318.467864-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013091318.467864-1-yongxuan.wang@sifive.com>
References: <20251013091318.467864-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vector regset uses the maximum possible vlen value to estimate the
.n field. But not all the hardwares support the maximum vlen. Linux
might wastes time to prepare a large memory buffer(about 2^6 pages) for
the vector regset.

The regset can only copy vector registers when the process are using
vector. Add .active callback and determine the n field of vector regset
in riscv_v_setup_ctx_cache() doesn't affect the ptrace syscall and
coredump. It can avoid oversized allocations and better matches real
hardware limits.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Andy Chiu <andybnac@gmail.com>
---
 arch/riscv/include/asm/vector.h |  1 +
 arch/riscv/kernel/ptrace.c      | 24 +++++++++++++++++++++---
 arch/riscv/kernel/vector.c      |  2 ++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index b61786d43c20..e7aa449368ad 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -51,6 +51,7 @@ void put_cpu_vector_context(void);
 void riscv_v_thread_free(struct task_struct *tsk);
 void __init riscv_v_setup_ctx_cache(void);
 void riscv_v_thread_alloc(struct task_struct *tsk);
+void __init update_regset_vector_info(unsigned long size);
 
 static inline u32 riscv_v_flags(void)
 {
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 8e86305831ea..e6272d74572f 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -153,6 +153,17 @@ static int riscv_vr_set(struct task_struct *target,
 				 0, riscv_v_vsize);
 	return ret;
 }
+
+static int riscv_vr_active(struct task_struct *target, const struct user_regset *regset)
+{
+	if (!(has_vector() || has_xtheadvector()))
+		return -ENODEV;
+
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return 0;
+
+	return regset->n;
+}
 #endif
 
 #ifdef CONFIG_RISCV_ISA_SUPM
@@ -184,7 +195,7 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
 }
 #endif
 
-static const struct user_regset riscv_user_regset[] = {
+static struct user_regset riscv_user_regset[] __ro_after_init = {
 	[REGSET_X] = {
 		USER_REGSET_NOTE_TYPE(PRSTATUS),
 		.n = ELF_NGREG,
@@ -207,11 +218,10 @@ static const struct user_regset riscv_user_regset[] = {
 	[REGSET_V] = {
 		USER_REGSET_NOTE_TYPE(RISCV_VECTOR),
 		.align = 16,
-		.n = ((32 * RISCV_MAX_VLENB) +
-		      sizeof(struct __riscv_v_regset_state)) / sizeof(__u32),
 		.size = sizeof(__u32),
 		.regset_get = riscv_vr_get,
 		.set = riscv_vr_set,
+		.active = riscv_vr_active,
 	},
 #endif
 #ifdef CONFIG_RISCV_ISA_SUPM
@@ -233,6 +243,14 @@ static const struct user_regset_view riscv_user_native_view = {
 	.n = ARRAY_SIZE(riscv_user_regset),
 };
 
+#ifdef CONFIG_RISCV_ISA_V
+void __init update_regset_vector_info(unsigned long size)
+{
+	riscv_user_regset[REGSET_V].n = (size + sizeof(struct __riscv_v_regset_state)) /
+					sizeof(__u32);
+}
+#endif
+
 struct pt_regs_offset {
 	const char *name;
 	int offset;
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 901e67adf576..3ed071dab9d8 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -66,6 +66,8 @@ void __init riscv_v_setup_ctx_cache(void)
 	if (!(has_vector() || has_xtheadvector()))
 		return;
 
+	update_regset_vector_info(riscv_v_vsize);
+
 	riscv_v_user_cachep = kmem_cache_create_usercopy("riscv_vector_ctx",
 							 riscv_v_vsize, 16, SLAB_PANIC,
 							 0, riscv_v_vsize, NULL);
-- 
2.43.0


