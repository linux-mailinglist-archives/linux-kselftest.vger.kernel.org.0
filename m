Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B314656B3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 14:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiL0NHW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 08:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiL0NG7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 08:06:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ABA277;
        Tue, 27 Dec 2022 05:06:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B31FB81012;
        Tue, 27 Dec 2022 13:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54384C433F2;
        Tue, 27 Dec 2022 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672146415;
        bh=VJMEgISdhkuI2X6kuXk2S8aABLEH627CtkUAogZE4Tc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mJKk0UNx/OIdNPYM8GRw/WPOppSiVJa2OVohLyHudDPLNYvjkINjpiwUHag2KOtrw
         tzas5cjFO+8VmMBL9umYsngakpDdhJBlJJahSYX91NtpqDobzUCF2w7UwKjSGU3YY5
         4HtuXvyA7hm1AUq5WMgRpfWMHd8aPr/XjioMnsA/RTclQiINW9WIbtpcmxeYzXzYNg
         ++2yMgpFHdgHaREROSKccjyttcyAoRzlrVaPaAekUNZvb82cNklUTToPNTbYcn5YHs
         9EAydbHuFVtQjnVXu6gSVy/2z0Si8QwYHc5QrQ6sJ8AS/Oxv6GKuRwSI0pAuMAWYfv
         pbiYpKfPsdJfg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 13:06:36 +0000
Subject: [PATCH 2/4] kselftest/arm64: Only enumerate VLs once in syscall-abi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221223-arm64-syscall-abi-sme-only-v1-2-4fabfbd62087@kernel.org>
References: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
In-Reply-To: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=5137; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VJMEgISdhkuI2X6kuXk2S8aABLEH627CtkUAogZE4Tc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqu3mz61xaauKwvQgXATjyBywjrmusGIaI+bDH6jL
 jEOhnDiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6rt5gAKCRAk1otyXVSH0FF9CA
 CC3vEIBMBUUVp08i5MrWy8tU+OyNRXzWG9ap5fvvDNhpEXmB66OPzHcCfWaCvUJLQp1Y2C+MNDcIrs
 eCFo8S4e32X1hXD+wo67LS6jF4vxIFq0vuarnOujWOIQEg254dA2ANvjD6XXia6EJ3Q70mqWZmPbRY
 i1mxyqLXplzcFIDnkp/dEk5J+k3mCmiBNo7QhDyTOYUV9okDkay1AnLNsRdUNLTKbV1/3xYpQCitGS
 kQfNCLva+cnuSsz1apSmtodvMpA4PzV2Sw0fMe8ZnZ9CK3W8tp1IWQJNTg0NtA93a1WNS1QtACJnNo
 ILlw6LFQshMJMD/cwqiJBGM6AlKKcy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently syscall-abi not only enumerates the SVE VLs twice while working
out how many tests are planned, it also repeats the enumeration process
while doing the actual tests. Record the VLs when we enumerate and use that
list when we are performing the tests, removing some duplicated logic.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 95 +++++++++++--------------
 1 file changed, 41 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index ffe719b50c21..45fdcbe3e909 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -24,6 +24,11 @@
 
 static int default_sme_vl;
 
+static int sve_vl_count;
+static unsigned int sve_vls[SVE_VQ_MAX];
+static int sme_vl_count;
+static unsigned int sme_vls[SVE_VQ_MAX];
+
 extern void do_syscall(int sve_vl, int sme_vl);
 
 static void fill_random(void *buf, size_t size)
@@ -355,72 +360,55 @@ static bool do_test(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 
 static void test_one_syscall(struct syscall_cfg *cfg)
 {
-	int sve_vq, sve_vl;
-	int sme_vq, sme_vl;
+	int sve, sme;
+	int ret;
 
 	/* FPSIMD only case */
 	ksft_test_result(do_test(cfg, 0, default_sme_vl, 0),
 			 "%s FPSIMD\n", cfg->name);
 
-	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
-		return;
-
-	for (sve_vq = SVE_VQ_MAX; sve_vq > 0; --sve_vq) {
-		sve_vl = prctl(PR_SVE_SET_VL, sve_vq * 16);
-		if (sve_vl == -1)
+	for (sve = 0; sve < sve_vl_count; sve++) {
+		ret = prctl(PR_SVE_SET_VL, sve_vls[sve]);
+		if (ret == -1)
 			ksft_exit_fail_msg("PR_SVE_SET_VL failed: %s (%d)\n",
 					   strerror(errno), errno);
 
-		sve_vl &= PR_SVE_VL_LEN_MASK;
-
-		if (sve_vq != sve_vq_from_vl(sve_vl))
-			sve_vq = sve_vq_from_vl(sve_vl);
+		ksft_test_result(do_test(cfg, sve_vls[sve], default_sme_vl, 0),
+				 "%s SVE VL %d\n", cfg->name, sve_vls[sve]);
 
-		ksft_test_result(do_test(cfg, sve_vl, default_sme_vl, 0),
-				 "%s SVE VL %d\n", cfg->name, sve_vl);
-
-		if (!(getauxval(AT_HWCAP2) & HWCAP2_SME))
-			continue;
-
-		for (sme_vq = SVE_VQ_MAX; sme_vq > 0; --sme_vq) {
-			sme_vl = prctl(PR_SME_SET_VL, sme_vq * 16);
-			if (sme_vl == -1)
+		for (sme = 0; sme < sme_vl_count; sme++) {
+			ret = prctl(PR_SME_SET_VL, sme_vls[sme]);
+			if (ret == -1)
 				ksft_exit_fail_msg("PR_SME_SET_VL failed: %s (%d)\n",
 						   strerror(errno), errno);
 
-			sme_vl &= PR_SME_VL_LEN_MASK;
-
-			/* Found lowest VL */
-			if (sve_vq_from_vl(sme_vl) > sme_vq)
-				break;
-
-			if (sme_vq != sve_vq_from_vl(sme_vl))
-				sme_vq = sve_vq_from_vl(sme_vl);
-
-			ksft_test_result(do_test(cfg, sve_vl, sme_vl,
+			ksft_test_result(do_test(cfg, sve_vls[sve],
+						 sme_vls[sme],
 						 SVCR_ZA_MASK | SVCR_SM_MASK),
 					 "%s SVE VL %d/SME VL %d SM+ZA\n",
-					 cfg->name, sve_vl, sme_vl);
-			ksft_test_result(do_test(cfg, sve_vl, sme_vl,
-						 SVCR_SM_MASK),
+					 cfg->name, sve_vls[sve],
+					 sme_vls[sme]);
+			ksft_test_result(do_test(cfg, sve_vls[sve],
+						 sme_vls[sme], SVCR_SM_MASK),
 					 "%s SVE VL %d/SME VL %d SM\n",
-					 cfg->name, sve_vl, sme_vl);
-			ksft_test_result(do_test(cfg, sve_vl, sme_vl,
-						 SVCR_ZA_MASK),
+					 cfg->name, sve_vls[sve],
+					 sme_vls[sme]);
+			ksft_test_result(do_test(cfg, sve_vls[sve],
+						 sme_vls[sme], SVCR_ZA_MASK),
 					 "%s SVE VL %d/SME VL %d ZA\n",
-					 cfg->name, sve_vl, sme_vl);
+					 cfg->name, sve_vls[sve],
+					 sme_vls[sme]);
 		}
 	}
 }
 
-int sve_count_vls(void)
+void sve_count_vls(void)
 {
 	unsigned int vq;
-	int vl_count = 0;
 	int vl;
 
 	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
-		return 0;
+		return;
 
 	/*
 	 * Enumerate up to SVE_VQ_MAX vector lengths
@@ -436,23 +424,17 @@ int sve_count_vls(void)
 		if (vq != sve_vq_from_vl(vl))
 			vq = sve_vq_from_vl(vl);
 
-		vl_count++;
+		sve_vls[sve_vl_count++] = vl;
 	}
-
-	return vl_count;
 }
 
-int sme_count_vls(void)
+void sme_count_vls(void)
 {
 	unsigned int vq;
-	int vl_count = 0;
 	int vl;
 
 	if (!(getauxval(AT_HWCAP2) & HWCAP2_SME))
-		return 0;
-
-	/* Ensure we configure a SME VL, used to flag if SVCR is set */
-	default_sme_vl = 16;
+		return;
 
 	/*
 	 * Enumerate up to SVE_VQ_MAX vector lengths
@@ -472,10 +454,11 @@ int sme_count_vls(void)
 		if (vq != sve_vq_from_vl(vl))
 			vq = sve_vq_from_vl(vl);
 
-		vl_count++;
+		sme_vls[sme_vl_count++] = vl;
 	}
 
-	return vl_count;
+	/* Ensure we configure a SME VL, used to flag if SVCR is set */
+	default_sme_vl = sme_vls[0];
 }
 
 int main(void)
@@ -486,8 +469,12 @@ int main(void)
 	srandom(getpid());
 
 	ksft_print_header();
-	tests += sve_count_vls();
-	tests += (sve_count_vls() * sme_count_vls()) * 3;
+
+	sve_count_vls();
+	sme_count_vls();
+
+	tests += sve_vl_count;
+	tests += (sve_vl_count * sme_vl_count) * 3;
 	ksft_set_plan(ARRAY_SIZE(syscalls) * tests);
 
 	if (getauxval(AT_HWCAP2) & HWCAP2_SME_FA64)

-- 
2.30.2
