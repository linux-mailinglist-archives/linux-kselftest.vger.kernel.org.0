Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B407D66C5EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjAPQMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjAPQLv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:11:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147E82A99A;
        Mon, 16 Jan 2023 08:07:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BDFD61042;
        Mon, 16 Jan 2023 16:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF73C433F1;
        Mon, 16 Jan 2023 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885243;
        bh=xpcRdOSI+pWh8Dd/1fKmTFXFGXs6RJ+tO7G27BvpNB4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=m+yVHILyiM2wWlouFfPoPMMp09Rmsal++vlVj8jq/39tXuM/U8ti8zdRICC6P0w6Y
         7HN0f2ZjtEN2u6roR4oE1GJx/y28h9zvEjVYshxjrHDKbyTPA6xEEsakS+auGNLZj2
         mv/qFsGJiMUjgvSjlTnDAV1Vx2ULyNCUBpmw96TB9c1lqwFS+4dGKZIYThvWGhPos+
         mU6DuoyEI9+j4g6r7zNJNXtuYMTsHIfbZMUBE/3fphT8lUJRy4L4zPS92W9TdqOr0M
         kKonQ6o2WmpHpFdrdVORtnKyLER+riqIStV3CkC2uVdSXMETfTSjhaE9qJwHzcs2nh
         hj59WMTKBvogQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:50 +0000
Subject: [PATCH v4 15/21] kselftest/arm64: Cover ZT in the FP stress test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-15-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xpcRdOSI+pWh8Dd/1fKmTFXFGXs6RJ+tO7G27BvpNB4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWtbVjxf1gZ0eV1w6e0S9q/gTJan4sO2TTdJpgr
 Zw6BZiKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1rQAKCRAk1otyXVSH0LnzB/
 4tcQS5JmXayBZpensegs1akP8qRB8v29rUjWRoflzE33IGuPIeuQdlYl3H/LssIkEZgxub0kbPMAnb
 CgaqYDLQl8Ra2TOUeK4lIBGssfB1BS1oVaJBtYFQbLc0+x7ZpUOAn3susvIucSgbS1MurdQRs/kHDV
 N0xWLsRTyW7GEso4zn+FibOps6HwbVS1UoYs30gZF+dqHwQ1B23VpvObb4eBnmSBwi9ax0BRItJWAP
 D849ePFXgyHC8pwCrBAwr0ZFdaViDtudbKeCc5UZXtFQR4iskt1SEfbY1ZJZl7o4h6Xy0BJT9Rolp4
 n26MJgEFNz9szmZp+RdxqQ/AOaqlSa
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

Hook up the newly added zt-test program in the FPSIMD stress tests, start
a copy per CPU when SME2 is supported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 29 ++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index f8b2f41aac36..520385fcfede 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -370,6 +370,19 @@ static void start_za(struct child_data *child, int vl, int cpu)
 	ksft_print_msg("Started %s\n", child->name);
 }
 
+static void start_zt(struct child_data *child, int cpu)
+{
+	int ret;
+
+	ret = asprintf(&child->name, "ZT-%d", cpu);
+	if (ret == -1)
+		ksft_exit_fail_msg("asprintf() failed\n");
+
+	child_start(child, "./zt-test");
+
+	ksft_print_msg("Started %s\n", child->name);
+}
+
 static void probe_vls(int vls[], int *vl_count, int set_vl)
 {
 	unsigned int vq;
@@ -426,6 +439,7 @@ int main(int argc, char **argv)
 	bool all_children_started = false;
 	int seen_children;
 	int sve_vls[MAX_VLS], sme_vls[MAX_VLS];
+	bool have_sme2;
 	struct sigaction sa;
 
 	while ((c = getopt_long(argc, argv, "t:", options, NULL)) != -1) {
@@ -458,6 +472,13 @@ int main(int argc, char **argv)
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
@@ -468,8 +489,9 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(tests);
 
-	ksft_print_msg("%d CPUs, %d SVE VLs, %d SME VLs\n",
-		       cpus, sve_vl_count, sme_vl_count);
+	ksft_print_msg("%d CPUs, %d SVE VLs, %d SME VLs, SME2 %s\n",
+		       cpus, sve_vl_count, sme_vl_count,
+		       have_sme2 ? "present" : "absent");
 
 	if (timeout > 0)
 		ksft_print_msg("Will run for %ds\n", timeout);
@@ -527,6 +549,9 @@ int main(int argc, char **argv)
 			start_ssve(&children[num_children++], sme_vls[j], i);
 			start_za(&children[num_children++], sme_vls[j], i);
 		}
+
+		if (have_sme2)
+			start_zt(&children[num_children++], i);
 	}
 
 	/*

-- 
2.34.1

