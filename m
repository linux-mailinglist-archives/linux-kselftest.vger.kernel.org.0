Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3E7A51A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjIRSHa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 14:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjIRSHV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 14:07:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E7FB
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 11:07:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso37325495ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695060431; x=1695665231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q85pLC4CWOSNTpoPb1PgDLYa3KXzAnUZu4/HImowDuQ=;
        b=lCRH4Mm93v6Q29ciEEoh+WGOCMHjvH1RwQsfbsXpiI42eLuAq6T/k2LDZZkUswvZPk
         pVpI0UE2ZQr4CBDW89VEP8xNSGsGD6k2NbtbnI5e1hZen2nga8fmXzTa5SBQvYvxY2QW
         ZJpyoEJxiLgSvlIQOpM9uzIxgEC7oaLw3pJMi+QLhekRSydJM94P7exxjknZ+T/KmvLa
         n9QBzX+kHZJZmkdRQOluIv/0WQskAYKTl9hZw8MgBe2p9/BWvErs+Zk4AcWxmqNdZF1S
         yGxL3WsDyFb42A7pV8xNJ+/RinIkRMmb2m00OQHSUecXtBHTqLrNpWC2khvgkM9O7eQa
         Qxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060431; x=1695665231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q85pLC4CWOSNTpoPb1PgDLYa3KXzAnUZu4/HImowDuQ=;
        b=aMDMVCU+kqASk4DkaXUdPuYM51QcBppqT8R5so1dhjZMQiJf1AdsY8Tzn6c8A7as+A
         cSeGq+hQAmLozBjjL6FPOBvgxPPusDSwul+tReJ91AAlmuNXLqWh7S0BU+aYkWCmEtKD
         L7kduAxOwAH9/XdQLjwWUjsCkHYr+HsD2I05WE6vFZ/EVa2khhHRHnIorqZGIOdg+pwp
         SR1gDyau3/lKRqgQsxWBIydV6tv3BZLwape0MHcMOP1FdpOLJUVLdm9bgUMWBlasjSfw
         2kig8ndkdZIM4q03e5NXpsl0MOtEv6jra8yeb2dIzTAYg7C4vzsBfVdJoYc0z6r/d8y6
         c2Nw==
X-Gm-Message-State: AOJu0Yzbxi9/+yTOj1swbeKz2kNTJKAuTj0mNpEJbg0LXrOVqHfMMd0P
        Uz2souSgteGAoGKnEGdd/6lXsQ==
X-Google-Smtp-Source: AGHT+IEbTMHUWCZuGNdKxBd5I66qIPiIr0OhjMBF5c9waakK0d252e8ysU5y9WDuV2qqSoMPyzw6gA==
X-Received: by 2002:a17:902:74cc:b0:1bf:78d:5cde with SMTP id f12-20020a17090274cc00b001bf078d5cdemr8797952plt.59.1695060430928;
        Mon, 18 Sep 2023 11:07:10 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902704700b001aaf2e8b1eesm8556720plt.248.2023.09.18.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:07:10 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 3/4] KVM: riscv: selftests: Fix ISA_EXT register handling in get-reg-list
Date:   Mon, 18 Sep 2023 23:36:45 +0530
Message-Id: <20230918180646.1398384-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918180646.1398384-1-apatel@ventanamicro.com>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Same set of ISA_EXT registers are not present on all host because
ISA_EXT registers are visible to the KVM user space based on the
ISA extensions available on the host. Also, disabling an ISA
extension using corresponding ISA_EXT register does not affect
the visibility of the ISA_EXT register itself.

Based on the above, we should filter-out all ISA_EXT registers.

Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 35 +++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index d8ecacd03ecf..76c0ad11e423 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -14,17 +14,33 @@
 
 bool filter_reg(__u64 reg)
 {
+	switch (reg & ~REG_MASK) {
 	/*
-	 * Some ISA extensions are optional and not present on all host,
-	 * but they can't be disabled through ISA_EXT registers when present.
-	 * So, to make life easy, just filtering out these kind of registers.
+	 * Same set of ISA_EXT registers are not present on all host because
+	 * ISA_EXT registers are visible to the KVM user space based on the
+	 * ISA extensions available on the host. Also, disabling an ISA
+	 * extension using corresponding ISA_EXT register does not affect
+	 * the visibility of the ISA_EXT register itself.
+	 *
+	 * Based on above, we should filter-out all ISA_EXT registers.
 	 */
-	switch (reg & ~REG_MASK) {
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_A:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_C:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_F:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_H:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSAIA:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_V:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR:
@@ -50,12 +66,7 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
 	unsigned long value;
 
 	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
-	if (ret) {
-		printf("Failed to get ext %d", ext);
-		return false;
-	}
-
-	return !!value;
+	return (ret) ? false : !!value;
 }
 
 void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
@@ -506,10 +517,6 @@ static __u64 base_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(time),
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(compare),
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(state),
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_A,
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_C,
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I,
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M,
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_V01,
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_TIME,
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_IPI,
-- 
2.34.1

