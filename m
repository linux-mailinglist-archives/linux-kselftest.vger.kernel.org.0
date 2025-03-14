Return-Path: <linux-kselftest+bounces-29088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E604A61EC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921FE8857F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833D20F08A;
	Fri, 14 Mar 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MqvbFavk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D620E6EE
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988404; cv=none; b=j4B/Qr9Q/aBflcLGW/CQfPCTpizsExd82YTq1QNuUMOZu32WCt4VeO+6mhLHix4k36FC/ZKlhahmIinOO9+qygfa/WiiqaOsTWMl9+vL2+KKi69U4DXYfw3d29qZeHWOrLoMa7SzEeIl8830Nc5K5ijCjoVoiEO8xnXwIsn2IxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988404; c=relaxed/simple;
	bh=y6g0Loy42MIeRr+HIhQBejsC1tcFvtMst2mcrTFR88U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlYJXVv3pveM7rrUF//FD2HKNCKhEK1lx95Wju1vdC9Dl0u/Lx8onWbZtq8S4scEPosrWruXTANwLlimdLu9Oi4uC8BABwWBBw3BfRCWbNaHG77k4qSadS85PIGgmoP0PfusAKxS8yazzySLIjSZdKbo3eSAvPXUNP53kKrM7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MqvbFavk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2241053582dso61487955ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988401; x=1742593201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onO6gV+gwl07vxhB4is21Yez1q3KjrVLviDZSIMIBso=;
        b=MqvbFavkja0AKdupI9nBL4L+eFEaxj2ZPRgj+p7hH7Ne07jvnUjw9k/oUy+7oPTxY+
         2CePiiknaUtLLYNpBKJ4I+TRgcU6OAEaHqyMPgiVO6ceOKyoTn5+X1kh3SfY/985vmWo
         hpri8n6k71y1Hk2YImWZyez78P+2yVlUxqxDt4Pple4P7LtJsQJLMYIHRDPO0OhtS4H5
         OD+/+tuNY7B2EqbVFBtZWASH7PEt+jzvNMFtcMJtYoWwRjxp974m4XNve1F7ZSRPQ/r6
         21MB86vl4fhnnTPk+CkLlPH3ZPTARO/im4PWe09MV3GEfPCFBTCTtLwLbf5DXFEdVthy
         /eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988401; x=1742593201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onO6gV+gwl07vxhB4is21Yez1q3KjrVLviDZSIMIBso=;
        b=TglMeaLTTeGqTCUyoHVAOxDDWkEIG3x7x9DKwbobvhgi1nmxmkRmwLQsKIoC9jwJ4i
         3qU37XYQ1h8XAlh2BCcGkJjhLTycbnHChCmAfCD2heeCgN4EGd6pa6lds1CkWrylZUgA
         /21PPRR0DZPjqn2dcGxOv6wg4BZoaQPM0toOQm/xEhUVDbooOPv+Rq8AWn3xlRDXGN3D
         MPndD1W8tz/2kjNczeWZ+Qlk5BQLDhDJ3/J3lLuCsb+iYs3G56FM0UuFOV2Yy/lDuVY/
         z0tS6IIwz/4wT8B8BNuymJNMb3DzSSmk0adc9t4hpKsNIpxNFr/+RXaeoUT9f5Ek0LQq
         0g6A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7J3smqlJvfHFokWcisiNLl/72lydb8+YlUUM/oyM3A/t2pHH1qbvwLLLXexPGQdiXNOY0Ycf7mWAXkKFLlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGo7s8LAQNFWTrAbczC0Nb09nUdHG7ZyKqHWwPe/NvDkA3y+ly
	0+Tk1N1OpkX/IPsxcOGyD+LEv6gnfMWx+WVUdZy66/XlENFf3zwOEuVWm5y7fTA=
X-Gm-Gg: ASbGncuq+yO5lufS/4/Lfr1ZdEfp0i++qmJaiyV+QLcaA8v0/y49WgAfkZ3CO/4ZHXK
	zCMsB0yWjdMUWzHfzYen6xZ1/t7YlQrEuxkygyNlGVFK4lDaxm5HpACvE4Wozpx0bBskuzQkHP8
	PkTvVv8X8AR5VC5tmlN4xCKvL0PvvycCh5ItjjIeZECMBK5phZ5JyUoIuUYfq70PEWEkpjGk77H
	NAvkNzdLg70Z4wHT2BmSmomgAWe+bRjuOxKbWIpH0xx0o2T4zBMSAHzhh3FJjwsBySb1rD4bWTP
	3skYvyG5J8wEOZFxyXBdR2VTRXl9lC/aQzbueFHqdb18+ZjrMh1UDR0=
X-Google-Smtp-Source: AGHT+IFRRNpqWVi1Ekf4KJDdZ9UetFfwRyekdTeabqYxkLE9P/UbVTlwOASvnLTEKfIF4erNHXNXJQ==
X-Received: by 2002:a17:902:ef51:b0:220:c143:90a0 with SMTP id d9443c01a7336-225e0aaf01dmr67336755ad.24.1741988401012;
        Fri, 14 Mar 2025 14:40:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:40:00 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:32 -0700
Subject: [PATCH v12 13/28] prctl: arch-agnostic prctl for indirect branch
 tracking
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-13-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 include/linux/cpu.h        |  4 ++++
 include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6a0a8f1c7c90..fb0c394430c6 100644
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
index 5c6080680cb2..6cd90460cbad 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -353,4 +353,31 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
 
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      77
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
+#define PR_SET_INDIR_BR_LP_STATUS      78
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      79
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index cb366ff8703a..f347f3518d0b 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2336,6 +2336,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
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
@@ -2811,6 +2826,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
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
2.34.1


