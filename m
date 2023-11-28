Return-Path: <linux-kselftest+bounces-716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012D87FBD64
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9835BB21D97
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A2E5C07F;
	Tue, 28 Nov 2023 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TPayRs9w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74EC1FE8
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:55 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d00689f5c8so3346715ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183295; x=1701788095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hci+9UDHQawot6/zMSxnmVJawqM8CfBCCGrmHWBS6oU=;
        b=TPayRs9whr3uuBaSuUDfkKGmADZDwNbp1WsrOGt+sBJEPDcZX20OkJDROXx6TGhDFb
         GCTh2QDhTznTXxDFo8xTeF253YzQIXaLsEBdz7hTlX6Fz87og2Bnu2KHyIsQdO0VE5cd
         hCIGVVunV2bYNFA64VEkhPiO10ISP8HvwZiB2DQbS7GXwpemN5RM6fqTLAnhBzZZn992
         tIsEhWxCkLjtKNeqJtrnREYhPG5TluaCLDFn+kkiU/0GTZheA5AnB68Lvslo/Wvq4gxG
         h49nA5D0OBNtMd6aN3pQUM51QCuQXrHVMNhaGlEv1+x/RFkSjrgNr6tVK7vVgc/n9y+t
         udMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183295; x=1701788095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hci+9UDHQawot6/zMSxnmVJawqM8CfBCCGrmHWBS6oU=;
        b=EJza4SY3FwiXPimC/5vH30uewxxy+b5a52RRX7wTMz5Odl1QF08QvdbQ9EJLWyRyBF
         5cnqd6c7jkT1zlU5JOYqEm3CEZsY2cyxVJ8I11/qcI6Fz14soyJ/Dcgv6zQ5BdRDAZHO
         54IBWV2Lrfnxj7F/8xHuM6LfFaWYyyWTyuyxwkPgr4bIuUtuPG9cTJWocrTNs/lDXvc1
         R5f12no8QW9dicl3TU6kH9noGgmwQy9+QuvA8liwABsRU5Myihe2ZBZIQ8E3F+wQDOm+
         sU1rpbwtw8VX0yCRPo2ImX+vxXozY4GWL3SH/pMBgccnkyALiWnOYtREWlkW+JBND+7N
         tXkQ==
X-Gm-Message-State: AOJu0Yzui+gkCTQOFZ4wXSBNVh9QkIdMqSdRNaIJ4C9BEjGrn9OrXHLs
	9LFIPo32uSXh7npDhcv+CAZpQPED1uqrN6dx4oE=
X-Google-Smtp-Source: AGHT+IHnloDLnCJ3p0XiWdFIxCZ3S8kJNR5OplVR8qRnvg9ozpD5v57Rnc9CKkPkmm+OJT2ekALH/g==
X-Received: by 2002:a17:902:e5c7:b0:1cf:a4e8:d2be with SMTP id u7-20020a170902e5c700b001cfa4e8d2bemr18008232plf.12.1701183295332;
        Tue, 28 Nov 2023 06:54:55 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:55 -0800 (PST)
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
Subject: [PATCH 09/15] KVM: riscv: selftests: Add Zfh[min] extensions to get-reg-list test
Date: Tue, 28 Nov 2023 20:23:51 +0530
Message-Id: <20231128145357.413321-10-apatel@ventanamicro.com>
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

The KVM RISC-V allows Zfh[min] extensions for Guest/VM so let us
add these extensions to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 04ff8836c474..4af0f9a750e8 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -49,6 +49,8 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFH:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFHMIN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR:
@@ -387,6 +389,8 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(ZBKC),
 		KVM_ISA_EXT_ARR(ZBKX),
 		KVM_ISA_EXT_ARR(ZBS),
+		KVM_ISA_EXT_ARR(ZFH),
+		KVM_ISA_EXT_ARR(ZFHMIN),
 		KVM_ISA_EXT_ARR(ZICBOM),
 		KVM_ISA_EXT_ARR(ZICBOZ),
 		KVM_ISA_EXT_ARR(ZICNTR),
@@ -786,6 +790,8 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
+KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
 KVM_ISA_EXT_SIMPLE_CONFIG(zicntr, ZICNTR);
@@ -829,6 +835,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zbkc,
 	&config_zbkx,
 	&config_zbs,
+	&config_zfh,
+	&config_zfhmin,
 	&config_zicbom,
 	&config_zicboz,
 	&config_zicntr,
-- 
2.34.1


