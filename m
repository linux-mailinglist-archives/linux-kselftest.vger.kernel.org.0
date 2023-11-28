Return-Path: <linux-kselftest+bounces-710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A467FBD50
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF01C2104B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F25C088;
	Tue, 28 Nov 2023 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZyB5NGaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F784D62
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:23 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf8b35a6dbso41158485ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Nov 2023 06:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183263; x=1701788063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqoarEcYKPTwyPmOGP/1tRxw/l4x1unFGwuPZisXSs0=;
        b=ZyB5NGaaVVjLSIkAX4xKpip9qQ1O/BbdB1h8f1W7Wuz2wptTFHu3mzJU9cnan/cMLG
         cmR9EE5EZy4sY+1FDVgICcGnWGwpcnTb5wCqZd0Z07QnZ/mucdE0RqOmLLQJe60W2FbH
         8BSXTSU89JTXqLYTODcYFEqwJE9Z2i1253T5JED4txDyjjK1PIwQtTRiH/rxA+8JmY5u
         5rdHh2bKQS9CBjcxBv/uIgEMRN42cvGvI9sk/V5M3uR3+mDvnqtLiHmPMOWqvrv02qTq
         AsuJLZt3w0PNd0DQUZnqS7I54HWidKgoR8UcTuE6iO+hBzcfJjxA9cHlbWKINCD/JH8n
         5MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183263; x=1701788063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqoarEcYKPTwyPmOGP/1tRxw/l4x1unFGwuPZisXSs0=;
        b=vWOtuBEpMNyxoXl1ou+A3QgRhgI3IZs+fsH0AQmfwOkBm8hF6kzKPUyJW7FneNNHr7
         kBcahbljY4QuprvsPRqTf+xLS2JRlvejIggqUWUcRC7iJI2LxM/MLaQnx6uilSFjbJJd
         Mv7318FY5N3OgqHBsCRQpoW/F3odk8VkuKgkV8OVTfP2PF8kRu1kPsG82HG1Tx7sk9Tx
         IB5dSZkaJMoFL+ZymqraL6pT0aD0EOjmDl1Cg/YmwW1S5MarpdCHVKWxFJ+EcsBXyYt1
         DXYuHW1p493Brx0siUam/uDo5+4tqG+/+hcDHAu6hKItmN9SnBJgHqyUUis7PzHGpoXn
         G0fA==
X-Gm-Message-State: AOJu0YwJ22UNGawM3M4gLJ1BY0+p5uGj62U5JsqLGtX9CdzW9swtNoFt
	3vF+lbwBfCCp3lOsBIpG6PsIBw==
X-Google-Smtp-Source: AGHT+IF0goMcAklKoJKTKjWtl2nqOMf0dgEj4xslQsxSZoF9zhQ3gTvjB8b3QY0TAV4Wuuo/tXKSpA==
X-Received: by 2002:a17:902:e843:b0:1cf:c404:45dd with SMTP id t3-20020a170902e84300b001cfc40445ddmr8585604plg.57.1701183262958;
        Tue, 28 Nov 2023 06:54:22 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:22 -0800 (PST)
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
Subject: [PATCH 03/15] KVM: riscv: selftests: Add Zbc extension to get-reg-list test
Date: Tue, 28 Nov 2023 20:23:45 +0530
Message-Id: <20231128145357.413321-4-apatel@ventanamicro.com>
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

The KVM RISC-V allows Zbc extension for Guest/VM so let us add
this extension to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index b6b4b6d7dacd..4b75b011f2d8 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -44,6 +44,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
@@ -361,6 +362,7 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(SVPBMT),
 		KVM_ISA_EXT_ARR(ZBA),
 		KVM_ISA_EXT_ARR(ZBB),
+		KVM_ISA_EXT_ARR(ZBC),
 		KVM_ISA_EXT_ARR(ZBS),
 		KVM_ISA_EXT_ARR(ZICBOM),
 		KVM_ISA_EXT_ARR(ZICBOZ),
@@ -739,6 +741,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
 KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
+KVM_ISA_EXT_SIMPLE_CONFIG(zbc, ZBC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
@@ -761,6 +764,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_svpbmt,
 	&config_zba,
 	&config_zbb,
+	&config_zbc,
 	&config_zbs,
 	&config_zicbom,
 	&config_zicboz,
-- 
2.34.1


