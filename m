Return-Path: <linux-kselftest+bounces-32004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD98FAA3F9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968619C5561
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E55298405;
	Wed, 30 Apr 2025 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="j5FxAUTm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F593296FCD
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972338; cv=none; b=FwJkkcezMvORu8cxSIEuDn33B5+vo4pGzbkMlaHoZpA7hxUaAv0/l7K1ZRHfQ/j1WIHEQVHmBrnzj1zyoiQEAf7IvGj6WIySE/wFcYbVUO/D3IUSs+U2avkkrB+vUG3JTQEK2JlZ66j9leBBvavoxI4ieh5ayANY/BZcFolmlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972338; c=relaxed/simple;
	bh=4i9s3BZ04Xaul4JIJaZ1jBsAtPDXHoSG+D3zfdaYIkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jalaRF8TDphD3yHykt9aYxHQIqd+1+0KiHheISS1LoApCmMDm5hHqtQqud6F/7aePJcUSL+VE3DJ04Cupfqb3p73K2LVuxzSlU877Db0JXTvBBN6n1iNsb6Y//4u3fl6Wv7C5OoneiDM85GQ8mLoD2LDO501ooqXN+VKS0MbDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=j5FxAUTm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73c17c770a7so8973318b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972336; x=1746577136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8YO5iKhPcWfVDqBOx8UCOEpbW1W4oCDkW5wQpoY+ec=;
        b=j5FxAUTmwf++s4QJ49lnJbUAN2FQHcu3NmSayHcZyWPfepT5nD2RUIz0SbLcriWbTD
         D01NC+snQUE91GI0IJpQge1AIPZ0ZH7jVjyvlSI2DZ7fA4CidjbozpuVcTYjNmcp/xHq
         haRHwDOt2A9zasp2VuheFtNgnJWUKap37RDDAPs7SxPgLor8JOi/inbPi0pDgQsBMyFU
         omgpXUQeu0bdW39R6rp2GmkUkj04j91oMBbHKkSPqKBdlzVX65GoVwYnQ6jQRtg9CFaS
         pb4d0u05RJL5Qu5PHUsnYUug4dyNwAOAqlkmZscxfqQXUJT34oXCZqEENXpJvzGm11Bw
         u3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972336; x=1746577136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8YO5iKhPcWfVDqBOx8UCOEpbW1W4oCDkW5wQpoY+ec=;
        b=JwWz7sBQWh2Q9m0UHOFoFZyZHOMOn51vJSMjyCwY87lq16lTdvrXDaiXpHi5vX5oFp
         8vL5W921XDh0GId/kmYgiy6qWk85pYVwGzKWKk3Wt2lwCyS64MzJy/H+mLANrWFMR6Xi
         DSRaObUBx+QPZMiErTzUeDkerTVdwPp8EVrkG8ClwfyinihPxdWxCy6HVPLZUWSNLilS
         hBXSqmH9BlnHMFomdKzTDSUHT4Zqipk370DTHAqzxDoeJKdggCCyuPsIKnalln/rKMrD
         fUtkacXUL0+5BaDoFmP+N42G7oBoXL4fLGUuWLSX2WrC6PEYgvAf0R2AIKpZOeeTcHob
         mDmA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4iTnSjlfzWuex5yyV5FbUBOeoXB0KHaKUn644nJMCwdfhLQYpJC8hBJ3kauHlJ4mOWb44og1JTtIm5wyRR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXQMylmBFmBuKIXd1cxdTV1H7+zACNv/o00G3Z83tGO9wqZ1S
	O71pOjbdUFGPEDFiyvVqsLLpLqqlFjCE2KvtYE1rNCPI5lyBj4PoOfAxK7kcqkU=
X-Gm-Gg: ASbGncsYkWanCwVooMZV6bK/+VlrtI4pF/7XFqpGfWoo47qgY/OJclqX/TPTfXjK74c
	S5fxOBkwDNBjIbTrbkKUPmzy8vgQXBXhhCXslWNpblUqGH+q3QWop2O5ol7ZJbskUzSodsINvMB
	LCeJ2/Y8bHuTG1pQmP9HKDCikKFG2RXmU4JLsJVnRspHK0DvWgvauShlzAFaM0nLelzSpqm/UR2
	YLERhNv20J3nWygEzrPuMx6suuoA1IIk++Fgku5RgjaIfqnBfubCPrQxYlg6abMW7CSzwG4UZDO
	FOzaqcmmYrk394/Ik0TZ3UC+2Evqz39+oRqN9YL2B5hMF7jur5/HtCAifilO6rRn
X-Google-Smtp-Source: AGHT+IFUQqkif7tyNajsLjY+g5KMuuCrLYrLd3gjDVZ022YnGAyiTdCKbHlRtIL/fogtzKbEqXLS2Q==
X-Received: by 2002:a05:6a21:9104:b0:1f5:7d57:830f with SMTP id adf61e73a8af0-20a8931b12dmr1346023637.33.1745972335680;
        Tue, 29 Apr 2025 17:18:55 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1f68988ca4sm1907790a12.74.2025.04.29.17.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:18:55 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 29 Apr 2025 17:18:47 -0700
Subject: [PATCH v2 3/3] KVM: riscv: selftests: Add vector extension tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-kvm_selftest_improve-v2-3-51713f91e04a@rivosinc.com>
References: <20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com>
In-Reply-To: <20250429-kvm_selftest_improve-v2-0-51713f91e04a@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

Add vector related tests with the ISA extension standard template.
However, the vector registers are bit tricky as the register length is
variable based on vlenb value of the system. That's why the macros are
defined with a default and overidden with actual value at runtime.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 133 +++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 569f2d67c9b8..814dd981ce0b 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -17,6 +17,15 @@ enum {
 	VCPU_FEATURE_SBI_EXT,
 };
 
+enum {
+	KVM_RISC_V_REG_OFFSET_VSTART = 0,
+	KVM_RISC_V_REG_OFFSET_VL,
+	KVM_RISC_V_REG_OFFSET_VTYPE,
+	KVM_RISC_V_REG_OFFSET_VCSR,
+	KVM_RISC_V_REG_OFFSET_VLENB,
+	KVM_RISC_V_REG_OFFSET_MAX,
+};
+
 static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
 
 bool filter_reg(__u64 reg)
@@ -143,6 +152,39 @@ bool check_reject_set(int err)
 	return err == EINVAL;
 }
 
+static int override_vector_reg_size(struct kvm_vcpu *vcpu, struct vcpu_reg_sublist *s,
+				    uint64_t feature)
+{
+	unsigned long vlenb_reg = 0;
+	int rc;
+	u64 reg, size;
+
+	/* Enable V extension so that we can get the vlenb register */
+	rc = __vcpu_set_reg(vcpu, feature, 1);
+	if (rc)
+		return rc;
+
+	__vcpu_get_reg(vcpu, s->regs[KVM_RISC_V_REG_OFFSET_VLENB], &vlenb_reg);
+
+	if (!vlenb_reg) {
+		TEST_FAIL("Can't compute vector register size from zero vlenb\n");
+		return -EPERM;
+	}
+
+	size = __builtin_ctzl(vlenb_reg);
+	size <<= KVM_REG_SIZE_SHIFT;
+
+	for (int i = 0; i < 32; i++) {
+		reg = KVM_REG_RISCV | KVM_REG_RISCV_VECTOR | size | KVM_REG_RISCV_VECTOR_REG(i);
+		s->regs[KVM_RISC_V_REG_OFFSET_MAX + i] = reg;
+	}
+
+	/* We should assert if disabling failed here while enabling succeeded before */
+	vcpu_set_reg(vcpu, feature, 0);
+
+	return 0;
+}
+
 void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 {
 	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
@@ -172,6 +214,13 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 		if (!s->feature)
 			continue;
 
+		if (s->feature == KVM_RISCV_ISA_EXT_V) {
+			feature = RISCV_ISA_EXT_REG(s->feature);
+			rc = override_vector_reg_size(vcpu, s, feature);
+			if (rc)
+				goto skip;
+		}
+
 		switch (s->feature_type) {
 		case VCPU_FEATURE_ISA_EXT:
 			feature = RISCV_ISA_EXT_REG(s->feature);
@@ -186,6 +235,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 		/* Try to enable the desired extension */
 		__vcpu_set_reg(vcpu, feature, 1);
 
+skip:
 		/* Double check whether the desired extension was enabled */
 		__TEST_REQUIRE(__vcpu_has_ext(vcpu, feature),
 			       "%s not available, skipping tests", s->name);
@@ -410,6 +460,35 @@ static const char *fp_d_id_to_str(const char *prefix, __u64 id)
 	return strdup_printf("%lld /* UNKNOWN */", reg_off);
 }
 
+static const char *vector_id_to_str(const char *prefix, __u64 id)
+{
+	/* reg_off is the offset into struct __riscv_v_ext_state */
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_VECTOR);
+	int reg_index = 0;
+
+	assert((id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_VECTOR);
+
+	if (reg_off >= KVM_REG_RISCV_VECTOR_REG(0))
+		reg_index = reg_off -  KVM_REG_RISCV_VECTOR_REG(0);
+	switch (reg_off) {
+	case KVM_REG_RISCV_VECTOR_REG(0) ...
+	     KVM_REG_RISCV_VECTOR_REG(31):
+		return strdup_printf("KVM_REG_RISCV_VECTOR_REG(%d)", reg_index);
+	case KVM_REG_RISCV_VECTOR_CSR_REG(vstart):
+		return "KVM_REG_RISCV_VECTOR_CSR_REG(vstart)";
+	case KVM_REG_RISCV_VECTOR_CSR_REG(vl):
+		return "KVM_REG_RISCV_VECTOR_CSR_REG(vl)";
+	case KVM_REG_RISCV_VECTOR_CSR_REG(vtype):
+		return "KVM_REG_RISCV_VECTOR_CSR_REG(vtype)";
+	case KVM_REG_RISCV_VECTOR_CSR_REG(vcsr):
+		return "KVM_REG_RISCV_VECTOR_CSR_REG(vcsr)";
+	case KVM_REG_RISCV_VECTOR_CSR_REG(vlenb):
+		return "KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)";
+	}
+
+	return strdup_printf("%lld /* UNKNOWN */", reg_off);
+}
+
 #define KVM_ISA_EXT_ARR(ext)		\
 [KVM_RISCV_ISA_EXT_##ext] = "KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_" #ext
 
@@ -639,6 +718,9 @@ void print_reg(const char *prefix, __u64 id)
 	case KVM_REG_SIZE_U128:
 		reg_size = "KVM_REG_SIZE_U128";
 		break;
+	case KVM_REG_SIZE_U256:
+		reg_size = "KVM_REG_SIZE_U256";
+		break;
 	default:
 		printf("\tKVM_REG_RISCV | (%lld << KVM_REG_SIZE_SHIFT) | 0x%llx /* UNKNOWN */,\n",
 		       (id & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT, id & ~REG_MASK);
@@ -670,6 +752,10 @@ void print_reg(const char *prefix, __u64 id)
 		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_D | %s,\n",
 				reg_size, fp_d_id_to_str(prefix, id));
 		break;
+	case KVM_REG_RISCV_VECTOR:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_VECTOR | %s,\n",
+		       reg_size, vector_id_to_str(prefix, id));
+		break;
 	case KVM_REG_RISCV_ISA_EXT:
 		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_ISA_EXT | %s,\n",
 				reg_size, isa_ext_id_to_str(prefix, id));
@@ -874,6 +960,48 @@ static __u64 fp_d_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_D,
 };
 
+/* Define a default vector registers with length. This will be overwritten at runtime */
+static __u64 vector_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vstart),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vl),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vtype),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vcsr),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_CSR_REG(vlenb),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(0),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(1),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(2),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(3),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(4),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(5),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(6),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(7),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(8),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(9),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(10),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(11),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(12),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(13),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(14),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(15),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(16),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(17),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(18),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(19),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(20),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(21),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(22),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(23),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(24),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(25),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(26),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(27),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(28),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(29),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(30),
+	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(31),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_V,
+};
+
 #define SUBLIST_BASE \
 	{"base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), \
 	 .skips_set = base_skips_set, .skips_set_n = ARRAY_SIZE(base_skips_set),}
@@ -898,6 +1026,9 @@ static __u64 fp_d_regs[] = {
 	{"fp_d", .feature = KVM_RISCV_ISA_EXT_D, .regs = fp_d_regs, \
 		.regs_n = ARRAY_SIZE(fp_d_regs),}
 
+#define SUBLIST_V \
+	{"v", .feature = KVM_RISCV_ISA_EXT_V, .regs = vector_regs, .regs_n = ARRAY_SIZE(vector_regs),}
+
 #define KVM_ISA_EXT_SIMPLE_CONFIG(ext, extu)			\
 static __u64 regs_##ext[] = {					\
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG |			\
@@ -966,6 +1097,7 @@ KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
 KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
+KVM_ISA_EXT_SUBLIST_CONFIG(v, V);
 KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
 KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
@@ -1040,6 +1172,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_fp_f,
 	&config_fp_d,
 	&config_h,
+	&config_v,
 	&config_smnpm,
 	&config_smstateen,
 	&config_sscofpmf,

-- 
2.43.0


