Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBA17B5F99
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 05:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjJCDxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 23:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbjJCDxI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 23:53:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048EE136
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 20:53:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c752caeaa6so3434275ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Oct 2023 20:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696305180; x=1696909980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPmuiSFVvpuLv2dpw8j40AU0MURCdJR8iWnmtgcJS7I=;
        b=nBqT1V8Yesyrd0U06mYSOfd7mgYTFRnLheFr0ZLaZ+iNG4gFv+B4U91dDjdCh/x6be
         CFKWr6ZuiUQr+BAGD7VK7X8fxnzeuezgwqn9+q0tqW5a2x8kwTf59Vnrer5OZ7l7jG+k
         i6Dwx/63Vj0u39qBGL+vtxEeS7lPE5Uk5G9ghxEaHn7zAKjs2pUX5Tu1uK6wMmSc0JvR
         jcSAccOUinzBh9xCNWDoRfGos+YSL4o98N0bwuBtsu8b4kjsxW9gXAFM4rP1mejSgbD0
         ZsjeFRxg+1VZMClQHFY6pNvXbYcGY2PsFfoLip+g3ROk7NFcIgfosGvyuoNxd6oOPR16
         6DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696305180; x=1696909980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPmuiSFVvpuLv2dpw8j40AU0MURCdJR8iWnmtgcJS7I=;
        b=ewLQQRXm0WQQn1gCSqIvOslProf+UIN2x5v8SA/G0aoVX2FTFNjSY+/KBThaslnKLa
         QKP9DXsUgoRQJkPGaztT6M+0axk6HI5BKV8GCSXmnvl8IBPd4XcXQaGp+LevGfCv3JdD
         cuWd+ZERGcZ+yxk8BypFylEoZYQ60uRztan6hxNBtgYOJbkQezm34sR9afwPIMiSwiHG
         ICKcYclBfJbHjORmKm3vLS3emcTZowWwDM9SSx99HZTUW0+tKvwAxj+iM9KHS4XWWK9A
         qokKwxWKeONSeq7ziHHy6B7Eb1tDPeskhGG5k2JtjuT5X0JDu3KaET4Gh7OQ8WbOi8Kc
         M+8g==
X-Gm-Message-State: AOJu0YyjFjiO8biObRbwZ8gg9UZkVXCuu9qBtP7U+ZncFQWsiI33eRiT
        eduW/GuUFQLR0rNEV6jcxYTCLg==
X-Google-Smtp-Source: AGHT+IHam7uEpuZxRNzndfsTMEK/VL2fjCzPC87o5phTd4UvXj5ySMEaSTGduC8zgkkya1ayeGrlQQ==
X-Received: by 2002:a17:903:2305:b0:1c6:e4b:bbeb with SMTP id d5-20020a170903230500b001c60e4bbbebmr13020119plh.56.1696305180186;
        Mon, 02 Oct 2023 20:53:00 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.132])
        by smtp.gmail.com with ESMTPSA id ja7-20020a170902efc700b001bf846dd2d0sm277381plb.13.2023.10.02.20.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 20:52:59 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 4/6] KVM: riscv: selftests: Add senvcfg register to get-reg-list test
Date:   Tue,  3 Oct 2023 09:22:24 +0530
Message-Id: <20231003035226.1945725-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003035226.1945725-1-apatel@ventanamicro.com>
References: <20231003035226.1945725-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We have a new senvcfg register in the general CSR ONE_REG interface
so let us add it to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index a61b706a8778..6cec0ef75cc7 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -211,6 +211,8 @@ static const char *general_csr_id_to_str(__u64 reg_off)
 		return RISCV_CSR_GENERAL(satp);
 	case KVM_REG_RISCV_CSR_REG(scounteren):
 		return RISCV_CSR_GENERAL(scounteren);
+	case KVM_REG_RISCV_CSR_REG(senvcfg):
+		return RISCV_CSR_GENERAL(senvcfg);
 	}
 
 	TEST_FAIL("Unknown general csr reg: 0x%llx", reg_off);
@@ -540,6 +542,7 @@ static __u64 base_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sip),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(satp),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(scounteren),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(senvcfg),
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(frequency),
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(time),
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(compare),
-- 
2.34.1

