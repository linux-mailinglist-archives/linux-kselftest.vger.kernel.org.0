Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31DC6B0FEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 18:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCHRNJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 12:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCHRNI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 12:13:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF98230F5;
        Wed,  8 Mar 2023 09:13:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D16361821;
        Wed,  8 Mar 2023 17:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD24C433EF;
        Wed,  8 Mar 2023 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678295584;
        bh=4abKDXUXrcBnjplNlM02Y2pkvSUnr8M2xOSnhiOF+4w=;
        h=From:Date:Subject:To:Cc:From;
        b=SKazW3+4dMsLG9TsDqDISqqZCmq1mprE0nxsYqwO/xNTOAKOaGkGk1hsBzBe8YPoS
         aMS5PWBJC0sktG5TCVt2pMv+QsHnS1Z3pXFhDwEnd6lDQF+ITU7fSgUhORzGoovJvW
         Irx9DkRBUXYQ5rom70qMtlcCfyxmWdo9bMqL/ni8cVxx83khiTrHc0WSRK5wTsSG5w
         dsXXrnWW54NNoXPjwR4aK/OfX6qem0cBlgdLDPZ4o/ApielH8OyC8To7GUDzZzcjRG
         reIozU2w9NidwQxNOPQIYgS58Vg2A76RthiJ0I9Zs9rZPwTDH1ak+x9QoEOiIxdgNg
         /W98+CjsplE2w==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 08 Mar 2023 17:12:26 +0000
Subject: [PATCH] KVM: selftests: Add coverage of MTE system registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-kvm-arm64-test-mte-regs-v1-1-f92a377e486f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPnBCGQC/x2N0QqDMAwAf0XyvECrInO/MvaQuqhBWkdSdCD++
 +oe7+C4A4xV2OBRHaC8icmaCvhbBcNMaWKUd2GoXd24xt1x2SKSxq7FzJYxZkblydAH3wcKntq
 eoNSBjDEopWG++n3V5dIf5VG+/+HzdZ4/UF9DzYAAAAA=
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=2966; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4abKDXUXrcBnjplNlM02Y2pkvSUnr8M2xOSnhiOF+4w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkCMIcCJYOwshpHBK0Xp3xi+ZzsTsrduIPfDV2xb5y
 BgIULHmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAjCHAAKCRAk1otyXVSH0LGMB/
 9MAUCmKcldKMqQRV7kne9erzAx3k1agPMQz1SkqF8kIZLseLm+1ad1YOTVN0Cmod53gXxw/MpnIDiR
 7FnKBV6/8/IQc9BfusZ8H9pI9tZ6gFenaSjkTV8JnEpwOS3Q5ZNYapYZGvz3W85Qg1sjMyctrJHcQ/
 n0J1VteNLF40gRzXLkKSw57MzcYTkLO+vmeeyiKmTUwTREooJeUIiXMFrFXsQXXi5pBsdQQx0mQ7I0
 xJtqiJR79nrGSUeJVNJZtTzNWiMz8gwXiAFwlAgJKYRmZ1U+78kwiJRtECTPXh1ApRQzAnrc50m1gl
 CRtLrPwpXmxy6+zOoKknMD/9HVfFVJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Verify that a guest with MTE has access to the MTE registers. Since MTE is
enabled as a VM wide capability we need to add support for doing that in
the process.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index d287dd2cac0a..63d6a9046702 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -42,6 +42,7 @@ struct reg_sublist {
 	long capability;
 	int feature;
 	bool finalize;
+	bool enable_capability;
 	__u64 *regs;
 	__u64 regs_n;
 	__u64 *rejects_set;
@@ -404,6 +405,18 @@ static void check_supported(struct vcpu_config *c)
 	}
 }
 
+static void enable_capabilities(struct kvm_vm *vm, struct vcpu_config *c)
+{
+	struct reg_sublist *s;
+
+	for_each_sublist(c, s) {
+		if (!s->enable_capability)
+			continue;
+
+		vm_enable_cap(vm, s->capability, 1);
+	}
+}
+
 static bool print_list;
 static bool print_filtered;
 static bool fixup_core_regs;
@@ -420,6 +433,7 @@ static void run_test(struct vcpu_config *c)
 	check_supported(c);
 
 	vm = vm_create_barebones();
+	enable_capabilities(vm, c);
 	prepare_vcpu_init(c, &init);
 	vcpu = __vm_vcpu_add(vm, 0);
 	aarch64_vcpu_setup(vcpu, &init);
@@ -1049,6 +1063,13 @@ static __u64 pauth_generic_regs[] = {
 	ARM64_SYS_REG(3, 0, 2, 3, 1),	/* APGAKEYHI_EL1 */
 };
 
+static __u64 mte_regs[] = {
+	ARM64_SYS_REG(3, 0, 1, 0, 5),	/* RGSR_EL1 */
+	ARM64_SYS_REG(3, 0, 1, 0, 6),	/* GCR_EL1 */
+	ARM64_SYS_REG(3, 0, 5, 6, 0),	/* TFSR_EL1 */
+	ARM64_SYS_REG(3, 0, 5, 6, 1),	/* TFSRE0_EL1 */
+};
+
 #define BASE_SUBLIST \
 	{ "base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), }
 #define VREGS_SUBLIST \
@@ -1075,6 +1096,9 @@ static __u64 pauth_generic_regs[] = {
 		.regs		= pauth_generic_regs,			\
 		.regs_n		= ARRAY_SIZE(pauth_generic_regs),	\
 	}
+#define MTE_SUBLIST \
+	{ "mte", .capability = KVM_CAP_ARM_MTE, .enable_capability = true,  \
+	  .regs = mte_regs, .regs_n = ARRAY_SIZE(mte_regs), }
 
 static struct vcpu_config vregs_config = {
 	.sublists = {
@@ -1123,6 +1147,14 @@ static struct vcpu_config pauth_pmu_config = {
 	{0},
 	},
 };
+static struct vcpu_config mte_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	VREGS_SUBLIST,
+	MTE_SUBLIST,
+	{0},
+	},
+};
 
 static struct vcpu_config *vcpu_configs[] = {
 	&vregs_config,
@@ -1131,5 +1163,6 @@ static struct vcpu_config *vcpu_configs[] = {
 	&sve_pmu_config,
 	&pauth_config,
 	&pauth_pmu_config,
+	&mte_config,
 };
 static int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230308-kvm-arm64-test-mte-regs-1b19bab1a49a

Best regards,
-- 
Mark Brown <broonie@kernel.org>

