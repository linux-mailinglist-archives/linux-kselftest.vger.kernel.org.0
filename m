Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C9E6263DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiKKVwB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiKKVvf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848273769
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0107F62103
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA5FC433D6;
        Fri, 11 Nov 2022 21:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203493;
        bh=zqkOAhenCAUz/pr+kao3s+tImHaUhiiOv81se6Arx3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S02E89M2A/TXrP/MZxeLXlmZfC4pwd+ipQMbaju4HeYuQNJPBb+P7O7CPKx+N9kFx
         h8o0BqvARllTqbZYBLCC130LoMEf2TvLgqJ/5pUzTEHv1yKfomwWNi6aHNxnUyE+oT
         Ew3GkI1FKrjH+NXnW3PfBU7YBDHCT1SGHz1iGNQqsnFHFWZ6RF9fq0zy+uEh/5CAXW
         F1QcYGqu3qodp89Xnm9w/SC+e30AsmirjUkd3pWEaSfkTSPkJJYk1MkFeq8St2liA4
         R6M+YErvhJgv5RrQ/EK+gClB7yCzAT7xBOEiRbEZUu8/jkgEMhl04l8Kn4XeMlV/gY
         pUCG/dK7OPrgg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 15/21] kselftest/arm64: Cover ZT in the FP stress test
Date:   Fri, 11 Nov 2022 21:50:20 +0000
Message-Id: <20221111215026.813348-16-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=broonie@kernel.org; h=from:subject; bh=zqkOAhenCAUz/pr+kao3s+tImHaUhiiOv81se6Arx3U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsObkTT9WgLFS1V0pEZsK+z22NxdqOJDGueqkO+F 4kFPcaqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DmwAKCRAk1otyXVSH0J7DB/ 9h9WO8eV+XBiVtxvz4Ug+11uXr4PBe6V50JvnkS5iLVS4JZTcsJICIefiJT/Ft2MsNmocqIGsb2IRU id5qmeKMjwZwjjmhwt4aW3HSix4mfy8IL94OTDtVNzKN/e1ppowYRnfGZaBfQTAlZmKDBvy2WT9skr +709Kq+SYubZYCZ8tmrLKVwC41jfeZUiQeBxDLTslwLcxUI38n8x/zEa9gCOWtmkE4yFTmfPeDZSuf 92kNoTaoLRycFb7A6l/J7yzf5HnnvDvWr5chpaqj1m5poZBiau5+Jo31Lni+ezVseaB+6HSs/13Qc9 mJOi4Xxqr+etM4qPB4dDdvAbZfpst8
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hook up the newly added zt-test program in the FPSIMD stress tests, start
a copy per CPU when SME2 is supported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 29 ++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 4e62a9199f97..7f4eef8717ad 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -350,6 +350,19 @@ static void start_za(struct child_data *child, int vl, int cpu)
 	ksft_print_msg("Started %s\n", child->name);
 }
 
+static void start_zt(struct child_data *child, int cpu)
+{
+	int ret;
+
+	child_start(child, "./zt-test");
+
+	ret = asprintf(&child->name, "ZT-%d", cpu);
+	if (ret == -1)
+		ksft_exit_fail_msg("asprintf() failed\n");
+
+	ksft_print_msg("Started %s\n", child->name);
+}
+
 static void probe_vls(int vls[], int *vl_count, int set_vl)
 {
 	unsigned int vq;
@@ -404,6 +417,7 @@ int main(int argc, char **argv)
 	int cpus, tests, i, j, c;
 	int sve_vl_count, sme_vl_count, fpsimd_per_cpu;
 	int sve_vls[MAX_VLS], sme_vls[MAX_VLS];
+	bool have_sme2;
 	struct epoll_event ev;
 	struct sigaction sa;
 
@@ -437,6 +451,13 @@ int main(int argc, char **argv)
 		sme_vl_count = 0;
 	}
 
+	if (getauxval(AT_HWCAP2) & HWCAP2_SME2) {
+		tests += cpus;
+		have_sme2 = true;
+	} else {
+		have_sme2 = false;
+	}
+
 	/* Force context switching if we only have FPSIMD */
 	if (!sve_vl_count && !sme_vl_count)
 		fpsimd_per_cpu = 2;
@@ -447,8 +468,9 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(tests);
 
-	ksft_print_msg("%d CPUs, %d SVE VLs, %d SME VLs\n",
-		       cpus, sve_vl_count, sme_vl_count);
+	ksft_print_msg("%d CPUs, %d SVE VLs, %d SME VLs, SME2 %s\n",
+		       cpus, sve_vl_count, sme_vl_count,
+		       have_sme2 ? "present" : "absent");
 
 	if (timeout > 0)
 		ksft_print_msg("Will run for %ds\n", timeout);
@@ -495,6 +517,9 @@ int main(int argc, char **argv)
 			start_ssve(&children[num_children++], sme_vls[j], i);
 			start_za(&children[num_children++], sme_vls[j], i);
 		}
+
+		if (have_sme2)
+			start_zt(&children[num_children++], i);
 	}
 
 	for (;;) {
-- 
2.30.2

