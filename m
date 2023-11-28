Return-Path: <linux-kselftest+bounces-712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F2F7FBD59
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB79B21D1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F695C07F;
	Tue, 28 Nov 2023 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cBVZzjOX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A59C1BFE
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cf856663a4so38698325ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183273; x=1701788073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcHeZCCZuGmWk0VDihN7K+RMJm1jmcttzitsZzTnM4Y=;
        b=cBVZzjOX2tAnXQEx+s0W5xX+qp5fXAQmqwnwZTnpDkVqBna7J94gIu3ZtTeOrXmqSj
         0nWo2PeN63Qmnl8TQ9LgVUs+wu03O6ZVb5dMmAusQC6IVNUuVHx32GVM8NYKR/IfDx7k
         lr09QHK6Av2+KE93SJdYd9UnwfrVtX+7fQey2UuvczG7aNgqfNxF8U7R1U3UNRsBG2r1
         EltYDVmyw1giBWthse21n7cIdn1CAfLsM9pD+DFel+aeDZhXLmz4Szc8o/oXDhwFYRSQ
         qOUTb8z6rYPVkNHVzHvSHWf7wVRuuLZmZHJukZh/d5VJjB0luzTUhMFhtbFk3RJTCrlM
         yQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183273; x=1701788073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcHeZCCZuGmWk0VDihN7K+RMJm1jmcttzitsZzTnM4Y=;
        b=Vu+qfi8EkRT0hzMQdV2j5p9CCXNCwjX2COvo5qE/PhQdo03Lr+M8LRUsUIpzC1XN82
         hw7az9R64LXgrw8jlN5Qo6RBvW3IGBpKav4HeTLmHc4k8ihshhQu8uIiqnaPdZ5+go6o
         s3j3G5BGYD/ciQn0TMKiF6DZ/lyW7yLn25heaXz59QB+6oBzgjE7oG81tTEt7swNUDpe
         2liRWDLgetKOznHrNDPeUjNutwykMQvVu29RZQmQRFReUu1MOyNW2rWbJ19xAeSLSQag
         ARbLbPChXXEUosKSNobbsIuSwGEnpcGp0rBDxR6ZbaT+CbHJqVdFkZ61JrAzNWuOI5aZ
         RRoQ==
X-Gm-Message-State: AOJu0Yx/DhjqE/9rBLBR/gluLxI5ZItK5rmvwVozxy0CAb/juNg4xHYr
	WIhDjKlp/xYmXSNB+TPS9I6L5g==
X-Google-Smtp-Source: AGHT+IG3rh/n5LIwPOXeioV29umEzG/6UEmBsnjYv9Xdltm19th+jgin03EX77B7GOr1xHQnvGTJDQ==
X-Received: by 2002:a17:903:11d1:b0:1cf:66a3:16c with SMTP id q17-20020a17090311d100b001cf66a3016cmr16237259plh.21.1701183273418;
        Tue, 28 Nov 2023 06:54:33 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:33 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 05/15] KVM: riscv: selftests: Add scaler crypto extensions to get-reg-list test
Date: Tue, 28 Nov 2023 20:23:47 +0530
Message-Id: <20231128145357.413321-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows scaler crypto extensions for Guest/VM so let us
add these extensions to get-reg-list test. This includes extensions
Zbkb, Zbkc, Zbkx, Zknd, Zkne, Zknh, Zkr, Zksed, Zksh, and Zkt.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 4b75b011f2d8..aabc05e4b02b 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -45,6 +45,9 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBC:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKB:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKC:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
@@ -54,6 +57,13 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKND:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKNE:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKNH:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKR:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKSED:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKSH:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKT:
 		return true;
 	/* AIA registers are always available when Ssaia can't be disabled */
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
@@ -363,6 +373,9 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(ZBA),
 		KVM_ISA_EXT_ARR(ZBB),
 		KVM_ISA_EXT_ARR(ZBC),
+		KVM_ISA_EXT_ARR(ZBKB),
+		KVM_ISA_EXT_ARR(ZBKC),
+		KVM_ISA_EXT_ARR(ZBKX),
 		KVM_ISA_EXT_ARR(ZBS),
 		KVM_ISA_EXT_ARR(ZICBOM),
 		KVM_ISA_EXT_ARR(ZICBOZ),
@@ -372,6 +385,13 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(ZIFENCEI),
 		KVM_ISA_EXT_ARR(ZIHINTPAUSE),
 		KVM_ISA_EXT_ARR(ZIHPM),
+		KVM_ISA_EXT_ARR(ZKND),
+		KVM_ISA_EXT_ARR(ZKNE),
+		KVM_ISA_EXT_ARR(ZKNH),
+		KVM_ISA_EXT_ARR(ZKR),
+		KVM_ISA_EXT_ARR(ZKSED),
+		KVM_ISA_EXT_ARR(ZKSH),
+		KVM_ISA_EXT_ARR(ZKT),
 	};
 
 	if (reg_off >= ARRAY_SIZE(kvm_isa_ext_reg_name))
@@ -742,6 +762,9 @@ KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
 KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbc, ZBC);
+KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
+KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
+KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
@@ -751,6 +774,13 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zicsr, ZICSR);
 KVM_ISA_EXT_SIMPLE_CONFIG(zifencei, ZIFENCEI);
 KVM_ISA_EXT_SIMPLE_CONFIG(zihintpause, ZIHINTPAUSE);
 KVM_ISA_EXT_SIMPLE_CONFIG(zihpm, ZIHPM);
+KVM_ISA_EXT_SIMPLE_CONFIG(zknd, ZKND);
+KVM_ISA_EXT_SIMPLE_CONFIG(zkne, ZKNE);
+KVM_ISA_EXT_SIMPLE_CONFIG(zknh, ZKNH);
+KVM_ISA_EXT_SIMPLE_CONFIG(zkr, ZKR);
+KVM_ISA_EXT_SIMPLE_CONFIG(zksed, ZKSED);
+KVM_ISA_EXT_SIMPLE_CONFIG(zksh, ZKSH);
+KVM_ISA_EXT_SIMPLE_CONFIG(zkt, ZKT);
 
 struct vcpu_reg_list *vcpu_configs[] = {
 	&config_aia,
@@ -765,6 +795,9 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zba,
 	&config_zbb,
 	&config_zbc,
+	&config_zbkb,
+	&config_zbkc,
+	&config_zbkx,
 	&config_zbs,
 	&config_zicbom,
 	&config_zicboz,
@@ -774,5 +807,12 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zifencei,
 	&config_zihintpause,
 	&config_zihpm,
+	&config_zknd,
+	&config_zkne,
+	&config_zknh,
+	&config_zkr,
+	&config_zksed,
+	&config_zksh,
+	&config_zkt,
 };
 int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
-- 
2.34.1


