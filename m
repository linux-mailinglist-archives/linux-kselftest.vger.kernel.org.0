Return-Path: <linux-kselftest+bounces-31986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65541AA3F2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D868D188DD0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312682609E8;
	Wed, 30 Apr 2025 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xOAnbh4L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225602609CD
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972230; cv=none; b=J2Ut/Q2GuxXeYfl5e+KddQHE8v0dWy8l9/4UkpBAtQ3oJMqmXWEVbG0BiNLpyoJnUCWN2OGcXSECEWn24dbQ14IQyQFKJ/UNJMgQgAeIwdx/G7UvupaWiecCsMAxiGtlQVqvRLO/Cd7pXMysEdt8al78EpdFWjjJJHaapnvSAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972230; c=relaxed/simple;
	bh=4V/vc+IGuEXLJLSMGAlz1mzVikhLjzrFyJ0kt0SiHdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fg2jihars5dQa9HMCgNk8UkyBgrA83xajxBJZqY0I/GeqnYvBCm9BIbNYGRiia+A+DNQEFElHeFCrEd5jYLLbU1fig6M5UtoIH0J+Bw2DarDMwn1MmiLoMBfYUeRTzDyY4Bv+kGeAsC9FUyb2pI58jb648YC1tGveseCY1NFhvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xOAnbh4L; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33ac23edso61521765ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972227; x=1746577027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqa+EnEmqD/WcxsFXdACBzGsJGhuUJWdKCVGNJwyc08=;
        b=xOAnbh4L4jFlBiCPu+/FlZJCwc0JLiVSzF3TxIHj2ISzRc8R/xaMq2jWRjWxyBSIvJ
         l+3Ru1kihn3EtzzDpTFHE4aDzaHxFzLOgdVaHm/f5CvpODglhPOBLOdPxFrItPKVg/9D
         6vzZN/Oh7OWzeaXGAgWjsWgxwEg2X05zCoFxhQnJMhMYWaHyR0jLiCo2iC4WzxHMK8YI
         BHs/FuYDA2WGIb3/65olA4YnZGyrHOdmMFntuOznGKalYEly2uVXd+M5vZpnuf9cTN08
         kMPXyvkcdb5TVQjZJFrlLJPtz26JIZ4H9kkKcvXBlqIFI3AV3yaZ7sqrEZJhrYWKl5tV
         3/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972227; x=1746577027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqa+EnEmqD/WcxsFXdACBzGsJGhuUJWdKCVGNJwyc08=;
        b=UJCahaAoVaQDKrUE/vhZoGBxHNXUCsNdSG+MtIpeqyDhc+pBdlJobbdJYKnO4zwT8T
         mXj9MtDwK57rDF7F3bH2p71Vmstrg5Nx5Ywo72t0kb7i0+HeRN73qoNbau3R9cwEJy2K
         oWuiqONlFL3D8o/JPQZejbKKIVzQnPbcJjJPZjt3rI9e63NPcDliTZIaguZAWqtU+Lsn
         8r2dfBWpPeVmoxoMN5p6cRBSgR2PT8bA/WXm03+G20ereMSuWMnlrC1y56jgKPKrvegh
         h5Ihygmtj33ABLdQg2Jwf0mBQtMu1tvqAXyqe0LxfU1lPAjkOPYCt4+BHzCQFM/Ok6ls
         5o4A==
X-Forwarded-Encrypted: i=1; AJvYcCVCHfIMUDNucQrywcUzRaDixMct7rkNNfIQpscMgw3GpUOHtxa5L4QnorSvMnPa3CjnllsVdIYYf2REFUkKF9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0hRuiV/By5ZvJmLKHcJ6ZaeyQagTwMtt7akz509IUfHEz+2d
	xmmx8pGJRUKRrNhuWxXp5y1gcxahmGbrAicvzvn5N7hEk69POb8djTalI/52LYY=
X-Gm-Gg: ASbGncuEgZVMq5x9CERS3twng/vzG+e0E/6PG/EDgC8/gbykk8XEhL8CZopDrQoqU/H
	yyCZJbbcGWXP2lsobSqXzJLZ9FZAVk/d3ncxq/N/7yQog5ygg9/MxWpGif8UAqfirlsYLx7K5WG
	t7kh3s4vswJk9p8QOtg9X2l/B2mCkdsTQxGaRgH4DvBYZcq3bvnCesMmzk17x73wQF0K6QNynoZ
	+S+uVEqcQrvyBEOSXsDj0tQNKMgqBTJ1HfbXvmemjzdJXBGUZA1RTLJjBpVRkNnOE0v6GYPCnQf
	fY8kWxK0de9g5cBDOPS0g1PXb5Z5KFekJALpKE45i+HgnZQwqXk=
X-Google-Smtp-Source: AGHT+IHQiHW6ihtjUTT0DTqmkuWcAmVo/rllEq5v8YlabaxyEntdh+cJYjoV0mkSuSPow8vsrYIpLg==
X-Received: by 2002:a17:902:d4d1:b0:223:669f:ca2d with SMTP id d9443c01a7336-22df356d961mr20640625ad.35.1745972227361;
        Tue, 29 Apr 2025 17:17:07 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:17:07 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:30 -0700
Subject: [PATCH v14 13/27] prctl: arch-agnostic prctl for indirect branch
 tracking
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-13-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Three architectures (x86, aarch64, riscv) have support for indirect branch
tracking feature in a very similar fashion. On a very high level, indirect
branch tracking is a CPU feature where CPU tracks branches which uses
memory operand to perform control transfer in program. As part of this
tracking on indirect branches, CPU goes in a state where it expects a
landing pad instr on target and if not found then CPU raises some fault
(architecture dependent)

x86 landing pad instr - `ENDBRANCH`
arch64 landing pad instr - `BTI`
riscv landing instr - `lpad`

Given that three major arches have support for indirect branch tracking,
This patch makes `prctl` for indirect branch tracking arch agnostic.

To allow userspace to enable this feature for itself, following prtcls are
defined:
 - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect
   branch tracking.
 - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch
   tracking.
   Following status options are allowed
       - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
         thread.
       - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
         thread.
 - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
   tracking for user thread.

Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/cpu.h        |  4 ++++
 include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index e3049543008b..ea8b351b5bc5 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -204,4 +204,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
 }
 #endif
 
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status);
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status);
+int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 15c18ef4eb11..2e09b19317a3 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -364,4 +364,31 @@ struct prctl_mm_map {
 # define PR_TIMER_CREATE_RESTORE_IDS_ON		1
 # define PR_TIMER_CREATE_RESTORE_IDS_GET	2
 
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      78
+
+/*
+ * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE will
+ * enable cpu feature for user thread, to track all indirect branches and ensure
+ * they land on arch defined landing pad instruction.
+ * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruction.
+ * arch64 - If enabled, an indirect branch must land on `BTI` instruction.
+ * riscv - If enabled, an indirect branch must land on `lpad` instruction.
+ * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indirect
+ * branches will no more be tracked by cpu to land on arch defined landing pad
+ * instruction.
+ */
+#define PR_SET_INDIR_BR_LP_STATUS      79
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      80
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index c434968e9f5d..91a1dc093c2a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2340,6 +2340,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
 	return -EINVAL;
 }
 
+int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2820,6 +2835,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = posixtimer_create_prctl(arg2);
 		break;
+	case PR_GET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_indir_br_lp_status(me, (unsigned long __user *)arg2);
+		break;
+	case PR_SET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_indir_br_lp_status(me, arg2);
+		break;
+	case PR_LOCK_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_lock_indir_br_lp_status(me, arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;

-- 
2.43.0


