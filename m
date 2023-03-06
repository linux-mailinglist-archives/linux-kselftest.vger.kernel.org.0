Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23C56AC791
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 17:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCFQT3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 11:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjCFQTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 11:19:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323824E5EC;
        Mon,  6 Mar 2023 08:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0FD25CE13A3;
        Mon,  6 Mar 2023 16:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80115C433EF;
        Mon,  6 Mar 2023 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678119316;
        bh=9a3UZUAnwjQQhgCgDJ7MKuT6/Sf1dQsHXr9Zku6OsNY=;
        h=From:Date:Subject:To:Cc:From;
        b=k4iNlWOLOaOPbJBQZByspHrjv0TPajRL00imAcrw5uz7ZihtZ19wt8gepaS6SN7M5
         VPzGJuSRg83f0B5QlDSkpQDDt6m1GGiTATtuvcxF8RCwew2M1pf5X6dPL4EN+0Okdp
         KIRTqoFFKdBiDdeuJvyUE+Xh2MXOHmjSNe9ID7Q3XuSom/VQP5+46V9+3qYoDi109e
         RfYkqp9NCN8IXHrCnYBQN40HZbdescJie7T5nwZHzg+biBZJAGrJmWPrZfz7xA8Gp3
         tGM7ZvnwJnbW/GrgkMoxTTNrSYwxShi46sTl6SocSB/7ushtCEerj0rEr1HS4AjgjZ
         ZwfL0j657IqNg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 06 Mar 2023 16:15:07 +0000
Subject: [PATCH] KVM: selftests: Comment newly defined aarch64 ID registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230210-kvm-arm64-getreg-comments-v1-1-a16c73be5ab4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIoRBmQC/x2NywqDMBBFf0Vm3YEY2/TxK6WLGMc4SJIyI7Yg/
 ntjl+fCuWcDJWFSeDQbCK2sXHKF9tRAmHyOhDxUBmtsZ2xrcF4TeknujJEWoYihpER5UTTXm7l
 3zrlxuED1e6+EvfgcpuPhU2Q+5rfQyN9/8vna9x8Kf5ivggAAAA==
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9a3UZUAnwjQQhgCgDJ7MKuT6/Sf1dQsHXr9Zku6OsNY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBhGQou3gS/eCqhQJI1oy3yDoWgiJU61dH1a0K++y
 wR+MAHyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAYRkAAKCRAk1otyXVSH0DC3CA
 CDAlrk7iMJb+P1P7II5kQl9iLm3JOqbxtT4U0hX2XoMPNi/rCRv8G+lF50in82+/4HmuJTc6kjNdrn
 Kr0CNdsdXI6DT9Q+fXgjU+n9PWBjxopbldbl0XbK0uYD2a2HhmMgJwh5+N4NkMNqKiXrKW6J3WCNdY
 +9vyBZLSSIMEbKMaV5SD4OMm+2fJEizZQZhcnmb0sqwVfqGi9ZIxo2C2paxi1T4y8wuukZmXsHItWy
 Rm1qiT5g31+3SSpFo96WgFJ0iQmK0/1K2G/K8kXJnYLY1FXQsqEIvmO2NNvS5PyGbJ8PORTjiM8HCt
 I94yCVBxTAqZ2k5G6P1Ier927x7PJa
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

All otherwise unspecified aarch64 ID registers should be read as zero so
we cover the whole ID register space in the get-reg-list test but we've
added comments for those that have been named. Add comments for
ID_AA64PFR2_EL1, ID_AA64SMFR0_EL1, ID_AA64ISAR2_EL1, ID_AA64MMFR3_EL1
and ID_AA64MMFR4_EL1 which have been defined since the comments were
added so someone looking for them will see that they are covered.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index d287dd2cac0a..df8a8afca4fc 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -807,10 +807,10 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 0, 3, 7),
 	ARM64_SYS_REG(3, 0, 0, 4, 0),	/* ID_AA64PFR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 4, 2),
+	ARM64_SYS_REG(3, 0, 0, 4, 2),	/* ID_AA64PFR2_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 4, 3),
 	ARM64_SYS_REG(3, 0, 0, 4, 4),	/* ID_AA64ZFR0_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 4, 5),
+	ARM64_SYS_REG(3, 0, 0, 4, 5),	/* ID_AA64SMFR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 4, 6),
 	ARM64_SYS_REG(3, 0, 0, 4, 7),
 	ARM64_SYS_REG(3, 0, 0, 5, 0),	/* ID_AA64DFR0_EL1 */
@@ -823,7 +823,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 0, 5, 7),
 	ARM64_SYS_REG(3, 0, 0, 6, 0),	/* ID_AA64ISAR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 6, 1),	/* ID_AA64ISAR1_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 6, 2),
+	ARM64_SYS_REG(3, 0, 0, 6, 2),	/* ID_AA64ISAR2_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 6, 3),
 	ARM64_SYS_REG(3, 0, 0, 6, 4),
 	ARM64_SYS_REG(3, 0, 0, 6, 5),
@@ -832,8 +832,8 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 0, 7, 0),	/* ID_AA64MMFR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 7, 1),	/* ID_AA64MMFR1_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 7, 2),	/* ID_AA64MMFR2_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 7, 3),
-	ARM64_SYS_REG(3, 0, 0, 7, 4),
+	ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
+	ARM64_SYS_REG(3, 0, 0, 7, 4),	/* ID_AA64MMFR4_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 7, 5),
 	ARM64_SYS_REG(3, 0, 0, 7, 6),
 	ARM64_SYS_REG(3, 0, 0, 7, 7),

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230210-kvm-arm64-getreg-comments-078093666fd5

Best regards,
-- 
Mark Brown <broonie@kernel.org>

