Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EAF727EE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjFHLem (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 07:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjFHLel (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 07:34:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F5583;
        Thu,  8 Jun 2023 04:34:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1b24ff03400so2258205ad.3;
        Thu, 08 Jun 2023 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686224079; x=1688816079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxviogz62WRh4UdCAHRdGMDNc2EolqwlGW0uyOFKQOw=;
        b=jaKqKAvGtxaPuZtmYEGIqoY8AjqKJwG64gGMIYr+NIW0KP6ffbiNFNWuecsrYjvjKB
         u+8bAWp1+2IUHU/tKlSk/hwxm4+d98JLEPV53NzOD4Mt5hNa3o8OLwggdAkaZT6+GQrp
         OrxlNpPbRLseaMu/r4IBgy1NqnOVlyNlCtHV9lt1a+HLGThFw8I7z5ih+LAX5yi3QitQ
         Shl+/t4E2xGpbQD+StoC+ef3PJ4liN/uYKxnn6dgIYJvezfqjsvctkhr+unJ0NHpbVQv
         DoJQKzJOEhLBHY/BgjnfcqRxI0M3G6fgqWOrr03sKk9GRJLvwXJv/WAD2mfDH3uRrITR
         W4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686224079; x=1688816079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxviogz62WRh4UdCAHRdGMDNc2EolqwlGW0uyOFKQOw=;
        b=O5LqWKe4mRizibQSxTu3ej4B/SepmP2Z68kdMCv5t6Upp5EijsWcY656ZUTeXeX5O4
         CWf3mFfhsxSnpPW04lJZI6Qfnq8bHVLMy6mS/7pISgdWS0VJKV/XTduVjVj3jih6HRfF
         nmIJWx1+uE1/owLlRFM34fDVq041l4DtiRIYt4+1M6A+hkAD9i+nF1hHH/FchGxIXfGr
         1Z0Bc/jrWOdQ2VTU1FR3uPFF5KJtFLIv1zCwiyH2zxKC/Qcqc7pg9u4cdbnQwYIsA4zM
         Y+7+nCBIzNlfXRhfqKaQbtI/Z9eAdY4h9uAlD2qPaqMLApO15daa0qsjqfaoF50u6zTj
         X9zA==
X-Gm-Message-State: AC+VfDwerAzEbYPTiRj1K109DI+SAoODRu1uZbSwvJ5GltIf330dGcVg
        SYPRGwldI4GigEAS1eai9NU=
X-Google-Smtp-Source: ACHHUZ7RQ9uZYrw/RqUDp/wWMVX0LPzJ/GPFPegXOQi5ILGbE0uuxNfyyV+n/ZKwuMjRp62sdsm6hQ==
X-Received: by 2002:a17:902:9888:b0:1af:ffda:855a with SMTP id s8-20020a170902988800b001afffda855amr4251022plp.9.1686224079376;
        Thu, 08 Jun 2023 04:34:39 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id qa2-20020a17090b4fc200b002310ed024adsm2900456pjb.12.2023.06.08.04.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 04:34:39 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: Add PEBS test for MSR_IA32_PERF_CAPABILITIES
Date:   Thu,  8 Jun 2023 19:34:20 +0800
Message-Id: <20230608113420.14695-3-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608113420.14695-1-cloudliang@tencent.com>
References: <20230608113420.14695-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

This commit adds a PEBS test that verifies all possible combinations
of PEBS-related bits in MSR_IA32_PERF_CAPABILITIES. This comprehensive
test ensures the accuracy of the PEBS feature.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 02903084598f..c1b1ba44bc26 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -21,6 +21,12 @@
 
 #define MAX_LINEAR_ADDR_MASK		GENMASK_ULL(15, 8)
 #define ADDR_OFS_BIT			8
+#define PMU_CAP_LBR_FMT		0x3f
+#define PMU_CAP_SMM_FREEZE		BIT_ULL(12)
+#define PMU_CAP_FW_WRITES		BIT_ULL(13)
+#define PMU_CAP_PERF_METRICS_AVAILABLE	BIT_ULL(PERF_CAP_METRICS_IDX)
+#define PMU_CAP_PEBS_OUTPUT_PT_AVAIL	BIT_ULL(PERF_CAP_PT_IDX)
+#define PMU_CAP_PEBS_ALL		(PERF_CAP_PEBS_MASK | PMU_CAP_PEBS_OUTPUT_PT_AVAIL)
 
 union perf_capabilities {
 	struct {
@@ -331,6 +337,70 @@ static void test_ds_area_noncanonical_address(union perf_capabilities host_cap)
 	kvm_vm_free(vm);
 }
 
+static void test_pebs_bit_combinations(union perf_capabilities host_cap)
+{
+	int ret;
+	uint64_t pebs_val, val;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
+
+	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 1);
+	TEST_REQUIRE(host_cap.capabilities & PERF_CAP_PEBS_FORMAT);
+	TEST_REQUIRE(vcpu_get_msr(vcpu, MSR_IA32_MISC_ENABLE) &
+		     MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL);
+
+	/*
+	 * Test if PEBS_REC_FMT is set and the value is the same as host,
+	 * the other PEBS bits are allowed to be set only if they are the
+	 * same as host.
+	 */
+	pebs_val = host_cap.capabilities & PMU_CAP_PEBS_ALL;
+
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, pebs_val);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES),
+		  (u64)pebs_val);
+
+	/* Test all PEBS bit combinations. */
+	for (val = 0x0; val <= (~0ul & PMU_CAP_PEBS_ALL); val++) {
+		/* Skips values that are not related to PEBS. */
+		if (val & (PMU_CAP_LBR_FMT | PMU_CAP_SMM_FREEZE |
+		    PMU_CAP_FW_WRITES | PMU_CAP_PERF_METRICS_AVAILABLE))
+			continue;
+
+		/*
+		 * Test that value of PEBS is rejected when the KVM doesn't
+		 * supports Intel PT.
+		 */
+		if ((val & PMU_CAP_PEBS_OUTPUT_PT_AVAIL) &&
+		    (!(host_cap.capabilities & PMU_CAP_PEBS_OUTPUT_PT_AVAIL))) {
+			ret = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
+			TEST_ASSERT(!ret, "Bad PEBS auxiliary bits = 0x%lx didn't fail", val);
+
+			continue;
+		}
+
+		/*
+		 * Test that value of PEBS is rejected when carrying
+		 * PEBS_REC_FMT if the value of PEBS is not equal to host.
+		 */
+		if ((val & PERF_CAP_PEBS_FORMAT) && val != pebs_val) {
+			ret = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
+			TEST_ASSERT(!ret, "Bad PEBS auxiliary bits = 0x%lx didn't fail", val);
+
+			continue;
+		}
+
+		/*
+		 * Test that PEBS bits can be written simultaneously or
+		 * independently if PEBS_REC_FMT is not carried.
+		 */
+		vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
+		ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), val);
+	}
+
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 	union perf_capabilities host_cap;
@@ -352,4 +422,5 @@ int main(int argc, char *argv[])
 	test_guest_wrmsr_perf_capabilities(host_cap);
 	test_lbr_perf_capabilities(host_cap);
 	test_ds_area_noncanonical_address(host_cap);
+	test_pebs_bit_combinations(host_cap);
 }
-- 
2.31.1

