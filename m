Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5F87A5827
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 05:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjISDzN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 23:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjISDzB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 23:55:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95208CFC
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 20:54:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2769920fa24so390517a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 20:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695095679; x=1695700479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8aNxqk/Fio7uz5AQcGG5V7O/R7HCZdIqvfTNBjv5gM=;
        b=R53BJzpDqdwq9Yn3bRu7+0S41nDwtisEOCg6gjrqHqMHW/D42vT3W7QBctOF27UdL6
         28F/YKFsFRiz5erDk+2Xfq9TT/fxF7gkllP2zhr2Tbh2Cte4DXMBz9NzdIDZ2nBwhDgf
         rSk7knd9TFK0h6fvHeGEkTVdNwS6ohLqE87n3K21ynnN47gcRbBtKUImSXWjrAK/+a3L
         PLZO/r1B5x/Ffk12pusWO8Y39GTLks0r5+j+T+/5K71XCdGmgD4tw5X6vEo27ZI9riIs
         EWWv5KoOd+tNasPpgtFLTVrAaZk2+HFF0ZHpikj5TbC8ig1/GUlogT84NcmlAP0zMwRR
         8wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695095679; x=1695700479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8aNxqk/Fio7uz5AQcGG5V7O/R7HCZdIqvfTNBjv5gM=;
        b=WMXrmI9rRpfsWYzGypfFCbY8g4L+XiJnKqe+9gmGBr03A0ojMw/36vSDGfeDK09PR+
         ZaMIIlme96G3WNNQcB0C06e6/Vu3RilTcMOAf5ifugJwT4/xL1k+KNLtQtUUV/IfO8Vd
         gWnLz8jqJvNEG0bHQAqryWcg59fNk1udTu2w9rTO4dsreIvNj1+n1nnmdLik6KTmiAPT
         KkT+VVC8aU7frm80skwJgXRb1Q9Ch6/8M8kmrKGE8z9CuTGEsfcpaWsyuG5st3BIuXDA
         191rhaiwE3PaU8+xzYDz/P/H9mf70/XKCJrZTS5F9mouO+PJVNQWylwzm7G57pCj6QU3
         Lo8w==
X-Gm-Message-State: AOJu0YzKisHoghEuW/M6Aa5rJ031dVR4uu0xfla8XNih0a6ZnmVMXwiR
        Oa/7tiqBzmue6iD4+kdYDmXTGg==
X-Google-Smtp-Source: AGHT+IEiYF6goUFLSD0qNIvl8mZDssbeUh0IABgs8W5u4Ug/kGe3A2Yvna7zl18arf+5N6NDqFqfWQ==
X-Received: by 2002:a17:90a:5901:b0:268:b7a2:62e8 with SMTP id k1-20020a17090a590100b00268b7a262e8mr10313711pji.7.1695095678874;
        Mon, 18 Sep 2023 20:54:38 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b00273fc850342sm4000802pjf.20.2023.09.18.20.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 20:54:38 -0700 (PDT)
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
Subject: [PATCH 7/7] KVM: riscv: selftests: Add condops extensions to get-reg-list test
Date:   Tue, 19 Sep 2023 09:23:43 +0530
Message-Id: <20230919035343.1399389-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919035343.1399389-1-apatel@ventanamicro.com>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
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

We have a new conditional operations related ISA extensions so let us add
these extensions to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 9f464c7996c6..4ad4bf87fa78 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -50,6 +50,8 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SMSTATEEN:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_XVENTANACONDOPS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICOND:
 		return true;
 	/* AIA registers are always available when Ssaia can't be disabled */
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
@@ -360,6 +362,8 @@ static const char *isa_ext_id_to_str(__u64 id)
 		"KVM_RISCV_ISA_EXT_ZIFENCEI",
 		"KVM_RISCV_ISA_EXT_ZIHPM",
 		"KVM_RISCV_ISA_EXT_SMSTATEEN",
+		"KVM_RISCV_ISA_EXT_XVENTANACONDOPS",
+		"KVM_RISCV_ISA_EXT_ZICOND",
 	};
 
 	if (reg_off >= ARRAY_SIZE(kvm_isa_ext_reg_name)) {
-- 
2.34.1

