Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F787A88D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjITPqo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbjITPqn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 11:46:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C430AF2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:46:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf5c314a57so52228885ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695224796; x=1695829596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2F/KgrFF+qMw0t/vo/nHoae6ojEjBo+38MWpMzETGM=;
        b=aphcHNEYE9ugS5WxInUNPK57lD1LVfdK1vEuXA+cxVdyeG/n9mfMEjqQt3G3u1vjC4
         qWbd/6FHBoC3Tehd/se8UwIJXbs42U0SnQU+T53LHxe+Y7M9kWI2ixCRHU9xVml+iqHH
         cCIbPJWLqcBd+xdhoQ1JV+r+cyUBSSM9vgzyjwCQl4+7DsLpWA2mKrjSVOMYbHcrQNpU
         bNbruB+cRMa25kDBgfmngnNhts5N39mngDE6U6Y7qUXPwmYdFvjiALLUAY9vAxvFvU/w
         3qatYivghlkYaxLjMbstjejxzOb28Vtr5ClA82dmGM5xss9EG1BAYyZNMQHiR74wIMiw
         AQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224796; x=1695829596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2F/KgrFF+qMw0t/vo/nHoae6ojEjBo+38MWpMzETGM=;
        b=J0d7oTEMg0CPDlDXVo5tNGNSPvzxj2YmO0ctUFnMiF/Rb2W5UXD3SzV2IvQKNfCFfe
         AeEfJemMtfAp8FbxiZ8Qx4+TGizAUU4v8hdNudXK80W2icftTVA03JPZer6uPUpi2ddc
         YLadqnnA5UNMXeteQZHCrGR+Jjfv+jQxp+0oylvdC4YGaTIuEu1BFimTNati0pPhBDfF
         8kzdLe/acaXUAsY5YPXK1nh/5W5soqWANz/w37TOHUaXc9LB/5vw1mAIdXlcdQ2G99bq
         LeJpI9KAQd1YbKP5gAbfow18gMyZaktQcP1GrhC8SxR4dqxLUKbWZ9erNxnXcgRh4xMC
         3Caw==
X-Gm-Message-State: AOJu0YynBmpYCtPWE0Hk+zYDgODnAxmGScc/6xOEHuunlI8TDmveYP4j
        IrpTtlzxcbInr/gcm9FApryxX+/QGcDX36o7isc=
X-Google-Smtp-Source: AGHT+IH9dE6XgdEjbTHz0tN9LTknxHD8yqClu0FhyBqM2fR5f+soDqQA7pdOMREOsEb4mM857vnN/Q==
X-Received: by 2002:a17:902:e5cd:b0:1b8:8b72:fa28 with SMTP id u13-20020a170902e5cd00b001b88b72fa28mr3370588plf.58.1695224796022;
        Wed, 20 Sep 2023 08:46:36 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b001c0de73564dsm11995153plx.205.2023.09.20.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:46:35 -0700 (PDT)
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
Subject: [PATCH v2 3/4] KVM: riscv: selftests: Fix ISA_EXT register handling in get-reg-list
Date:   Wed, 20 Sep 2023 21:16:07 +0530
Message-Id: <20230920154608.1447057-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920154608.1447057-1-apatel@ventanamicro.com>
References: <20230920154608.1447057-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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

