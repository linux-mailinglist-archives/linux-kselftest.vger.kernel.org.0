Return-Path: <linux-kselftest+bounces-47570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB574CBBD7E
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B7313006E36
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE632D6E55;
	Sun, 14 Dec 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P704Pcd5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D182DFA25
	for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730161; cv=none; b=uge60uNXMoGo4O9LojVuQxArAC82k3wJnnxAQA7Y95MeaiWGDzr1t4cL68xSMjNWzNRyuAB8SeXVdHpPOp1Qczkzh2SGH/+cnsktKNTlpg3/Y9mY9uJLHlrvP+9kL3PaknS8dg9cosvLgZY/jioYcZv74VIFb483h5zWcojz0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730161; c=relaxed/simple;
	bh=mu890xecCRo8W5w6MXFE4GMZMj6+R534p0jPUqy6CZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnUuVeXiw2a104ULk5t2i+S3CzW3guTriYIZaKbKDNDg9NKlEU8y7apyzd5meKNB4D6Cb5ap9Dsup5m7xsXb5PUtyFSx2S9WWCTGrpQob1NLR2clUknB66mqSUrrVVGs+0MAWyGXd3hYeeA5kgiDqDWgnFKD10CSx+uPJ1XdBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P704Pcd5; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-596ba05aaecso3150169e87.0
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Dec 2025 08:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730157; x=1766334957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCjNPmJLrpJn3Ut2d1Tu4Faw1b2CRzQ8noRKY714zGA=;
        b=P704Pcd5R1dqJ36EvnqtexDcJM61QlHqvI7N/E7TmQoE6cPnQpvcYndmr3LZx/WiF1
         CJl1Tm4LGi6HFEvHXAVlDR3jIPQp8VTb2uwATvHn/qlhAj9XQxAZQISGAPOhUdk09oDl
         QiqTyVftjpviBmE7Hktsf/1EXh0uBAJerg1YZMhCLlCQnxE0H9Jv17N9Vgr2rSISFNrv
         JCAie7fakhfx4JjFq8U0M6qTPuTlQBdvhJ+oqMN92/C80Jr7BupmKeTlDcp0OevEnH0I
         OVHfppItn33SZKgXornf3er2HmIi8t05Avm+gY1ZbxpJxMZ01qtufSMEunM0bJkPZMk0
         /OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730157; x=1766334957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCjNPmJLrpJn3Ut2d1Tu4Faw1b2CRzQ8noRKY714zGA=;
        b=vF/rEXKaXYI1SFPQdOkPFBhw3UlcdfgoU3Ss6g8DqYvLiNvQn0I++cQx/4x37yX5Vc
         pAlpiSXPXjQh+KT492Rhd+nLUiJt9www8I71ajpKw/VJFM52GFhdLeVPh2ylWztZTTUS
         41+mL4NNfMC/9lSsfp6O3/dfD0ta8hB0mt06p8qodQtBchw/CvTYdSNHm9d5kuo56ZHh
         VPcTvhK/8MvxpMX3Ira+qAE+6KuolYNA6sQFwkz8D7yPnaeDpzUFadHkS7lcahVGSB2D
         C0WJKAeBpdjEdEElSNDcXEumiHmejgeHRYvUosNm7rMYyk7D7Gr9y2n7D3UV35cZK6gG
         nLTA==
X-Forwarded-Encrypted: i=1; AJvYcCXnYEYsKeg01kJqhTRRMsnI+i8O4oAF6phv9+FgIlnCcZOTS/+lkPWiCeJPPzTY2/GNtECkQmQRUAEU2vnCCb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJ/itsT3N242n+QqJCFO5ZQSVJpshu7smUhIAGl0Gz8iS9Fer
	/3dlHSyqGeTWkYR7YtOA/3iWVEo8p0IsTKWBiqyoW8/iPb3Sr3iJre4r
X-Gm-Gg: AY/fxX7eXKWcDWRVmo5OuFnyPx47FPBlkCr+E9j/1MFjWGw5JXK2+DEJfS/jPV28KA6
	qs3MQbdly9jQxyo9JC0ncLFzB2ok4Gd+C+q7Jk8zpu+Z9adVosXDceIaaT8ROu7lOACpHRjLuFQ
	0vparS4u4JuHzW1B1H5uC5npKKUQB8PFZaDOd0ZgFFzna75Ps4o9cWEsCqvSKORl2EXANlaeZUu
	mxZUGMk8xCk1/9I01FYwRutFcgZlBArehXQ5/c2S5A0kp1f9c8LVyIJU7drwKziupvJk7yGZFZI
	YFw7Gq665zoqSWMy4sl9Kjm1/m+zMFd4tm2Et6PZ397XKtQfavII2nwWPAuJb2yZSonlq/mO1oo
	IVfYwBX08c7HKrsn8JBdcd6BaArUbbupBDsfYTaUzChCgk6YC4afo8kl+OKV3nLpEEdLJYiLkXs
	tLGw==
X-Google-Smtp-Source: AGHT+IGRHdWeURxKMpbmL/T6K5rtF0X2VXcD24R+7mw/s+BE8VCrIbvP8MMR8nJUBe8utmaTLEJ33Q==
X-Received: by 2002:a05:6512:3f26:b0:595:9195:3390 with SMTP id 2adb3069b0e04-598faa1499bmr2813865e87.5.1765730157035;
        Sun, 14 Dec 2025 08:35:57 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-598f7717b79sm3789618e87.60.2025.12.14.08.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:35:56 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v5 6/9] selftests: riscv: verify initial vector state with ptrace
Date: Sun, 14 Dec 2025 19:35:10 +0300
Message-ID: <20251214163537.1054292-7-geomatsi@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251214163537.1054292-1-geomatsi@gmail.com>
References: <20251214163537.1054292-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case that attaches to a traced process immediately after its
first executed vector instructions to verify the initial vector context.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../riscv/vector/validate_v_ptrace.c          | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/validate_v_ptrace.c b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
index b64986b42270..a8d64d351edd 100644
--- a/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/validate_v_ptrace.c
@@ -13,6 +13,9 @@
 #include "kselftest_harness.h"
 #include "v_helpers.h"
 
+#define SR_FS_DIRTY	0x00006000UL
+#define CSR_VXRM_SHIFT	1
+
 volatile unsigned long chld_lock;
 
 TEST(ptrace_v_not_enabled)
@@ -77,4 +80,136 @@ TEST(ptrace_v_not_enabled)
 	}
 }
 
+TEST(ptrace_v_early_debug)
+{
+	static volatile unsigned long vstart;
+	static volatile unsigned long vtype;
+	static volatile unsigned long vlenb;
+	static volatile unsigned long vcsr;
+	static volatile unsigned long vl;
+	bool xtheadvector;
+	pid_t pid;
+
+	if (!(is_vector_supported() || is_xtheadvector_supported()))
+		SKIP(return, "Vector not supported");
+
+	xtheadvector = is_xtheadvector_supported();
+
+	chld_lock = 1;
+	pid = fork();
+	ASSERT_LE(0, pid)
+		TH_LOG("fork: %m");
+
+	if (pid == 0) {
+		unsigned long vxsat, vxrm;
+
+		vlenb = get_vr_len();
+
+		while (chld_lock == 1)
+			asm volatile ("" : : "g"(chld_lock) : "memory");
+
+		asm volatile (
+			"csrr %[vstart], vstart\n"
+			"csrr %[vtype], vtype\n"
+			"csrr %[vl], vl\n"
+			: [vtype] "=r"(vtype), [vstart] "=r"(vstart), [vl] "=r"(vl)
+			:
+			: "memory");
+
+		/* no 'is_xtheadvector_supported()' here to avoid clobbering v-state by syscall */
+		if (xtheadvector) {
+			asm volatile (
+				"csrs sstatus, %[bit]\n"
+				"csrr %[vxsat], vxsat\n"
+				"csrr %[vxrm], vxrm\n"
+				: [vxsat] "=r"(vxsat), [vxrm] "=r"(vxrm)
+				: [bit] "r" (SR_FS_DIRTY)
+				: "memory");
+			vcsr = vxsat | vxrm << CSR_VXRM_SHIFT;
+		} else {
+			asm volatile (
+				"csrr %[vcsr], vcsr\n"
+				: [vcsr] "=r"(vcsr)
+				:
+				: "memory");
+		}
+
+		asm volatile (
+			".option push\n"
+			".option norvc\n"
+			"ebreak\n"
+			".option pop\n");
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		unsigned long vstart_csr;
+		unsigned long vlenb_csr;
+		unsigned long vtype_csr;
+		unsigned long vcsr_csr;
+		unsigned long vl_csr;
+		size_t regset_size;
+		struct iovec iov;
+		int status;
+
+		/* attach */
+
+		ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* unlock */
+
+		ASSERT_EQ(0, ptrace(PTRACE_POKEDATA, pid, &chld_lock, 0));
+
+		/* resume and wait for ebreak */
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vector csr regs using ptrace PEEKDATA */
+
+		errno = 0;
+		vstart_csr = ptrace(PTRACE_PEEKDATA, pid, &vstart, NULL);
+		ASSERT_FALSE((errno != 0) && (vstart_csr == -1));
+
+		errno = 0;
+		vl_csr = ptrace(PTRACE_PEEKDATA, pid, &vl, NULL);
+		ASSERT_FALSE((errno != 0) && (vl_csr == -1));
+
+		errno = 0;
+		vtype_csr = ptrace(PTRACE_PEEKDATA, pid, &vtype, NULL);
+		ASSERT_FALSE((errno != 0) && (vtype_csr == -1));
+
+		errno = 0;
+		vcsr_csr = ptrace(PTRACE_PEEKDATA, pid, &vcsr, NULL);
+		ASSERT_FALSE((errno != 0) && (vcsr_csr == -1));
+
+		errno = 0;
+		vlenb_csr = ptrace(PTRACE_PEEKDATA, pid, &vlenb, NULL);
+		ASSERT_FALSE((errno != 0) && (vlenb_csr == -1));
+
+		/* read tracee csr regs using ptrace GETREGSET */
+
+		regset_size = sizeof(*regset_data) + vlenb_csr * 32;
+		regset_data = calloc(1, regset_size);
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* compare */
+
+		EXPECT_EQ(vstart_csr, regset_data->vstart);
+		EXPECT_EQ(vtype_csr, regset_data->vtype);
+		EXPECT_EQ(vlenb_csr, regset_data->vlenb);
+		EXPECT_EQ(vcsr_csr, regset_data->vcsr);
+		EXPECT_EQ(vl_csr, regset_data->vl);
+
+		/* cleanup */
+
+		ASSERT_EQ(0, kill(pid, SIGKILL));
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0


