Return-Path: <linux-kselftest+bounces-7140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77670897C6C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 01:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C921CB29B2F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79499159203;
	Wed,  3 Apr 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WkY3heJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A247158DDB
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187737; cv=none; b=dQkTSWla4rZPf4KBftJoiE7g113b4s7pav9MhGQ74YB91VtBtOe+Fw+SElRRVirzclznNrPXBP+6iIHn4RYRFxqyC3SrMvEQF257APJLHiY70aWLNXO/jmoKgPFLiyaLPXje19TPerS9mjdscEWUASbv7Nx/Ewnz15kaj3D7cAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187737; c=relaxed/simple;
	bh=NiU8bpUtwirKcyGtcof8hJsHniUKWQ5ijdJHVhwMqw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRli+5MOxlomZj8sRubd9jeE9fWR/K9zKj8MZlCeOPKojZyLgYyZftRB6GEeTIZJdTLX6/Lolf0uu3zqgo0D7x8fP9PD/Zkj9tve7BkeG+IYIoKbRgX7rmIWeHXvi1fE8LMyfQwKEIQyDqsRoTtW0Oej1nuokk4icA+4+QnBj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WkY3heJ7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2987e9d67so2186885ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187735; x=1712792535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP6SydUIEnIf7iJga0ecJJ8VROQQxV6mEOJWURQ0TH0=;
        b=WkY3heJ7qRXJ/6MELGfTs7kbALvG3chZWSOOuJzVvMYGHGyJVI7Yw5gjoI9tBQ1QVK
         QvzAJLm7G0+HUfY3+DXBjN68xpBFpqbwMHdyjxMaZH55xS9jcRepZd+y0VMoQ+IqXObJ
         W4VFNU+USjoE938NU4fLBZfudWk7b6svuAQ6QQ/NOeELA6xW5CVE+XZzN2ihZ5nlmqLd
         l+DJwWKUxEVIxCcogc6ysFQu2Tz/AbQsLigIEG/pPN9y+2d4YHW8mTvU5hDhsGbW3dCk
         sLjz6QD7RWQMCjIJQshE2SnSFRPS8zgIia4lPyIpqNXz51ugZhDA1/eKdFAapuP+Em5B
         +gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187735; x=1712792535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WP6SydUIEnIf7iJga0ecJJ8VROQQxV6mEOJWURQ0TH0=;
        b=BC+Q5aae9wpFo1//xSHy9wDFM/nqjkKh/92eQzIkPsoZf+tb34Cm9Om4D1Reo/84Uw
         mqDGJm/2HQ1Hq0e5J0Hkkx/Maehd3SnOj8E0uMsAlJlaRAo+QlHFSWyr0BjiWaxwYcgi
         lpETVTf+Szgt18uHyMfl3Mdctm/jdDqtEKQjmOSGR9rLGB2PGKUxmJNNjwQLaqG+9d6D
         yqu/HJzdNNcsOcV8CvFYNtEO1enO+Hjlo1Udxp6WIGpkQOWcg/nOfFrgXdec7M2wXFZD
         6mEOltV1CvvRf+x+2nzc4ANpAHJaY70cmvlzX01y94BPl/+auJawitgPUE8+VuSiU5Mh
         d0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqAMyHS7tictPcBKsPLstF6Wx3mDi2nPPFb7iKAaJTf3y61T/1AsR0ePFqN358QMhG3bxi9vuaJlp8ZsOZ+gTRCilNNNxe/hRZH3ZHmLH0
X-Gm-Message-State: AOJu0Ywol3ma7muTndWSUEP43E7/kpAuO/WlXNO2jtgBX35SPuZeiyHs
	6xW2X8K6x4LJD/l/HCD7MA0CoQh0x47Ck5qbsRLrz9Ihzl3IPQMC3oAZ0TFzdtg=
X-Google-Smtp-Source: AGHT+IG94ZCsKxcUmluscIk5n5e6k4tHROtb3Z4W0JVAcaXjptzg9lzBPMJPJjbNEv/0oFOKMb0Hdg==
X-Received: by 2002:a17:902:d4cb:b0:1e0:e14:b19d with SMTP id o11-20020a170902d4cb00b001e00e14b19dmr1403019plg.18.1712187734816;
        Wed, 03 Apr 2024 16:42:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:42:14 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 17/29] prctl: arch-agnostic prctl for indirect branch tracking
Date: Wed,  3 Apr 2024 16:35:05 -0700
Message-ID: <20240403234054.2020347-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three architectures (x86, aarch64, riscv) have support for indirect branch
tracking feature in a very similar fashion. On a very high level, indirect
branch tracking is a CPU feature where CPU tracks branches which uses
memory operand to perform control transfer in program. As part of this
tracking on indirect branches, CPU goes in a state where it expects a
landing pad instr on target and if not found then CPU raises some fault
(architecture dependent)

x86 landing pad instr - `ENDBRANCH`
aarch64 landing pad instr - `BTI`
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
---
 include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 3c66ed8f46d8..b7a8212a068e 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,31 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      73
 
+/*
+ * Get the current indirect branch tracking configuration for the current
+ * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
+ */
+#define PR_GET_INDIR_BR_LP_STATUS      74
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
+#define PR_SET_INDIR_BR_LP_STATUS      75
+# define PR_INDIR_BR_LP_ENABLE		   (1UL << 0)
+
+/*
+ * Prevent further changes to the specified indirect branch tracking
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_INDIR_BR_LP_STATUS      76
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 242e9f147791..c770060c3f06 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2330,6 +2330,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
 	return -EINVAL;
 }
 
+int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2787,6 +2802,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_GET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_SET_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_LOCK_INDIR_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_lock_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.43.2


