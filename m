Return-Path: <linux-kselftest+bounces-43386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E404ABEADC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B145C9625A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E23328E1;
	Fri, 17 Oct 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="osHI1KM9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42253328E8
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716783; cv=none; b=BDgzv48/BEUtUmeYSPCUURvofMY2er49BjeMVmQRZxcr6e6T/BRVjIabwdM+CZ8Rwp774RbvyidwRHXNe+wnBy9LnBmUIzRuH8LZwJVdQEHigZ9ATvo/MNq2tDB1HFnMYsVp0X5Dq7J5NSTs6Eyy9Dvzmd5+23Gs/sJd1hs6Vv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716783; c=relaxed/simple;
	bh=GCIigDkB0pF7cxSdTRy9b39VCRd68OawhY8FjD+BNB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrI4qXzXkpZeNHQVBEXMZtSJPjzXxrFcUw1dm63gIBtydkmsqhkYWV5A6o1p97mI4QPLLbHDlVVVP4hCwACbxL+y/ApS7cl545f96v5YEbodA7Z4XGCOv71NyC7GYPqf4Rd5pjBBcFodhbrlpb7Hkf/4pxVJUy5jt3GVEhZBJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=osHI1KM9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so2048326b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760716781; x=1761321581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w5xDGLO7hW3hS92oDJ9fb7AKUAHlmH+03Jt/Z8OfK8=;
        b=osHI1KM9F7gJPK5qFebbSWBvxqXX3WvPjAejjt9vHu5+lmNIKayhyDGOYvrxzaiABC
         hEX2FOekIRfbssBO4j4Yf7sljGDPXtoQdcdK6UQvmWQ5qvy3Yrm0mmeufQ1zm7noJHrv
         L8Lv+uSLjEosxRLgSzJ3Q2wkwUbymbFbUNdMVbfUxhjUS+xKXW/u0GRePkBoFeZ2zSP5
         /x8B9d8Jh2C+Hz1TyCT+aRjHH6TqTByczkp1s3ZpY5NE70j/RUrrFuGiswC6my0czlvg
         QuvEjZUAcKUEiLr1T82kT6CZJgQn34EJibwDbd/e0XRAF70yzktIDbbpOfGYjIbdeSAI
         /f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716781; x=1761321581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w5xDGLO7hW3hS92oDJ9fb7AKUAHlmH+03Jt/Z8OfK8=;
        b=joFrEutHHPWcYd8CNcCXZJU+ORq7A/EBkDmEb68HPlTyK/F+XXY65eVLsZSofGs67F
         Iy+InoCGCP6vX3fALQT2SZltDBOF0QP2c/ErESbuk/PKApH51rnDLaLWgIgYpo0Cda9E
         +A8XT1EAL6cobj2Mb6+FW5RRhgdSUrA6CX9cAAz0gOqM3Abs3gY5AZd4Z4H/SV9sv3Lq
         lAARNhlzpUSSFIM/Y58G61r2h3kxYAr/UI/FjzSuoon3gRGSfd8RsT62NhaLX79PRv4d
         BxK0Vb4TLspRUIXbwYt6IkO1rt6+FdBVWrmnysuem8bwXvDtVjqsWK3Z15k0Y9jSNJVV
         M14g==
X-Forwarded-Encrypted: i=1; AJvYcCU9+aVQ01whaedMa6PHStZbvLOElmDIEbiqQzHXAHdBJTaOnCqdxfEe94fF7NfBUT9w+JjHK9HUdFS4XIrNA/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwawUFb18i1G5K1pKZfGc95ugphjzwxARcfWgCWgONprahZxUuL
	UE56UcdcJ80LuIfwEhTI84GLnuh47cUBuMQ3+3QIgsIfHBU6Y/zWl8NbZIPRC1pc7mg=
X-Gm-Gg: ASbGncvgLkYVZwCRrCTGTGjxLGKS/m+9fMFPZjM/BQMIpVlyLNil9jH/eTJpxpjPUh6
	aFWdCYbrYV+GOQCObnk0xgq1D9b3DVSJNbleDaHfMQ5PIw8MG0rZI2v2eQpxpQJgFfywotKt1oS
	FhqM5LqaQI4hj4cCODCaT3X/6mFSRP4SaxWPMOP1HIY0eM7dMI3fo3EFMWD4Rma4kX1DTtLgPio
	/4IOUpPfqmioQ68kP1R8VSkDExAFkvOfKBhmLxFE9Enr3om4W0fNK+v6wAJDHssHyTeJR3SLhVn
	IGWxiW6MAu8rBPpc4zltRLzebb+mLmcaSImZflePRFaedK21sBs4PxV/RBb7xU1Qx/Wux/2MHB1
	gc2G0Tnr3Ffx9sGwGohy6BPIrp+NwJEmX0quuBynOwT3iEP/phYGSMXUph4FhJ2d79UMkamuvpu
	opEPjiu9+vMB7jSJY/4ISQCfl6BhXd8Fno
X-Google-Smtp-Source: AGHT+IHNbVvYJz+rYfwfI4m+3NraggPiuTL6qpx95XEifxO4NBe/kLmHp3qJst7WcfaiUNvQG99/Qw==
X-Received: by 2002:a05:6a21:71c7:b0:334:b734:eed2 with SMTP id adf61e73a8af0-334b734eeedmr685727637.42.1760716780898;
        Fri, 17 Oct 2025 08:59:40 -0700 (PDT)
Received: from localhost.localdomain ([122.171.18.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm151067a12.18.2025.10.17.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:59:40 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/4] RISC-V: KVM: Convert kvm_riscv_vcpu_sbi_forward() into extension handler
Date: Fri, 17 Oct 2025 21:29:22 +0530
Message-ID: <20251017155925.361560-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017155925.361560-1-apatel@ventanamicro.com>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All uses of kvm_riscv_vcpu_sbi_forward() also updates retdata->uexit so
to further reduce code duplication move retdata->uexit assignment to
kvm_riscv_vcpu_sbi_forward() and convert it into SBI extension handler.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 +++-
 arch/riscv/kvm/vcpu_sbi.c             |  6 +++++-
 arch/riscv/kvm/vcpu_sbi_base.c        | 20 +++-----------------
 arch/riscv/kvm/vcpu_sbi_replace.c     | 27 +--------------------------
 arch/riscv/kvm/vcpu_sbi_system.c      |  4 +---
 arch/riscv/kvm/vcpu_sbi_v01.c         |  3 +--
 6 files changed, 14 insertions(+), 50 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 3497489e04db..446f4a8eb3cd 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -69,7 +69,9 @@ struct kvm_vcpu_sbi_extension {
 			     unsigned long reg_size, const void *reg_val);
 };
 
-void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_riscv_vcpu_sbi_forward_handler(struct kvm_vcpu *vcpu,
+				       struct kvm_run *run,
+				       struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
 				     struct kvm_run *run,
 				     u32 type, u64 flags);
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 1b13623380e1..fd4106c276d8 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -120,7 +120,9 @@ static bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx)
 	return sext && scontext->ext_status[sext->ext_idx] != KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
 }
 
-void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
+int kvm_riscv_vcpu_sbi_forward_handler(struct kvm_vcpu *vcpu,
+				       struct kvm_run *run,
+				       struct kvm_vcpu_sbi_return *retdata)
 {
 	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
 
@@ -137,6 +139,8 @@ void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	run->riscv_sbi.args[5] = cp->a5;
 	run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
 	run->riscv_sbi.ret[1] = 0;
+	retdata->uexit = true;
+	return 0;
 }
 
 void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
index 5bc570b984f4..ca489f2dfbdf 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -41,8 +41,7 @@ static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 			 * For experimental/vendor extensions
 			 * forward it to the userspace
 			 */
-			kvm_riscv_vcpu_sbi_forward(vcpu, run);
-			retdata->uexit = true;
+			return kvm_riscv_vcpu_sbi_forward_handler(vcpu, run, retdata);
 		} else {
 			sbi_ext = kvm_vcpu_sbi_find_ext(vcpu, cp->a0);
 			*out_val = sbi_ext && sbi_ext->probe ?
@@ -72,27 +71,14 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base = {
 	.handler = kvm_sbi_ext_base_handler,
 };
 
-static int kvm_sbi_ext_forward_handler(struct kvm_vcpu *vcpu,
-				       struct kvm_run *run,
-				       struct kvm_vcpu_sbi_return *retdata)
-{
-	/*
-	 * Both SBI experimental and vendor extensions are
-	 * unconditionally forwarded to userspace.
-	 */
-	kvm_riscv_vcpu_sbi_forward(vcpu, run);
-	retdata->uexit = true;
-	return 0;
-}
-
 const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental = {
 	.extid_start = SBI_EXT_EXPERIMENTAL_START,
 	.extid_end = SBI_EXT_EXPERIMENTAL_END,
-	.handler = kvm_sbi_ext_forward_handler,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
 };
 
 const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
 	.extid_start = SBI_EXT_VENDOR_START,
 	.extid_end = SBI_EXT_VENDOR_END,
-	.handler = kvm_sbi_ext_forward_handler,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
 };
diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index b490ed1428a6..2c456e26f6ca 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -186,34 +186,9 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst = {
 	.handler = kvm_sbi_ext_srst_handler,
 };
 
-static int kvm_sbi_ext_dbcn_handler(struct kvm_vcpu *vcpu,
-				    struct kvm_run *run,
-				    struct kvm_vcpu_sbi_return *retdata)
-{
-	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
-	unsigned long funcid = cp->a6;
-
-	switch (funcid) {
-	case SBI_EXT_DBCN_CONSOLE_WRITE:
-	case SBI_EXT_DBCN_CONSOLE_READ:
-	case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
-		/*
-		 * The SBI debug console functions are unconditionally
-		 * forwarded to the userspace.
-		 */
-		kvm_riscv_vcpu_sbi_forward(vcpu, run);
-		retdata->uexit = true;
-		break;
-	default:
-		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
-	}
-
-	return 0;
-}
-
 const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn = {
 	.extid_start = SBI_EXT_DBCN,
 	.extid_end = SBI_EXT_DBCN,
 	.default_disabled = true,
-	.handler = kvm_sbi_ext_dbcn_handler,
+	.handler = kvm_riscv_vcpu_sbi_forward_handler,
 };
diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_system.c
index 359be90b0fc5..c6f7e609ac79 100644
--- a/arch/riscv/kvm/vcpu_sbi_system.c
+++ b/arch/riscv/kvm/vcpu_sbi_system.c
@@ -47,9 +47,7 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		kvm_riscv_vcpu_sbi_request_reset(vcpu, cp->a1, cp->a2);
 
 		/* userspace provides the suspend implementation */
-		kvm_riscv_vcpu_sbi_forward(vcpu, run);
-		retdata->uexit = true;
-		break;
+		return kvm_riscv_vcpu_sbi_forward_handler(vcpu, run, retdata);
 	default:
 		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 		break;
diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.c
index 368dfddd23d9..188d5ea5b3b8 100644
--- a/arch/riscv/kvm/vcpu_sbi_v01.c
+++ b/arch/riscv/kvm/vcpu_sbi_v01.c
@@ -32,8 +32,7 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		 * The CONSOLE_GETCHAR/CONSOLE_PUTCHAR SBI calls cannot be
 		 * handled in kernel so we forward these to user-space
 		 */
-		kvm_riscv_vcpu_sbi_forward(vcpu, run);
-		retdata->uexit = true;
+		ret = kvm_riscv_vcpu_sbi_forward_handler(vcpu, run, retdata);
 		break;
 	case SBI_EXT_0_1_SET_TIMER:
 #if __riscv_xlen == 32
-- 
2.43.0


