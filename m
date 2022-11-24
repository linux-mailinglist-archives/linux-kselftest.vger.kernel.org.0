Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A2637896
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 13:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKXMIT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 07:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXMIL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 07:08:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB775CD10
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 04:08:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0C35B827AC
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 12:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F709C433D6;
        Thu, 24 Nov 2022 12:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669291686;
        bh=ieVspCUhpwOJIoUXnwtQwi7eMzbUNqAvaTqk+J+xYK4=;
        h=From:To:Cc:Subject:Date:From;
        b=FZEQkzd7mah8oajN0ZPDUPvKH+aC2BLWXwWIfq1qIs9BkbfHD2zcc3NJZR5Di/Xac
         wzdr3DBXW+QBU1EEvkQyuPIosOA4DHMnSRJiBgx5fuvLyloE1QKS93C62vYOOH2NmN
         nA6Wv5PVdVZBYOjXYDB1bGgg07bICn+S1F8lXSLipGlYb++XHMPuhU/g/JMalb3cDf
         7Aqr/HvmSt3P3VH8XETVlw1yziy6oz1NhwMohlabXYy9Yg4pZ7e+dSs25fMDOKWIgA
         ab5EO/zG9GTrbMP+mOuZX84nX03we/2IsqNCPuGKvav+yI52e0oaMVtRl8gsO8PAbb
         D6KHBPOAI2yEw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] kselftest/arm64: Set test names prior to starting children
Date:   Thu, 24 Nov 2022 12:07:22 +0000
Message-Id: <20221124120722.150988-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544; i=broonie@kernel.org; h=from:subject; bh=ieVspCUhpwOJIoUXnwtQwi7eMzbUNqAvaTqk+J+xYK4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjf155pqIvt/R3DYsleI5+PbQjT540dDpdmu4LgwsU JIPv5xCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY39eeQAKCRAk1otyXVSH0HQHB/ 9lFd0rM5nvz0KfEBWh8qZiHuV9Kv4dDF6QqrEsU4qDuePMWiryiD7QUct8PVvr4yvOEjL0WXTEkl6c Zl8yRWpz6KQi23VyAp59fYDFSYhXeiKpP/gTbbcD11EWe6Ir9Z3mAaKcXR13Srei/KgH5z97NFJ4oU QuQJdH5EVIPSUD8kkyzFX1yrnRB21UGE7FdBT8NDZc03gJdN8gM2J12KDx1lE1qVmrXrwqlT6oOYDs flWRLkOp/EyfT0J857V0sj3KCAKwad93cwDtDHwMr80Imaq9x2UCiKX2Q2gBMjzXIrUgcu2CaNGrSM I8DxKZBWPxgZTmwqpcA74JYwK+4Guj
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

Since we now flush output immediately on starting children we should ensure
that the child name is set beforehand so that any output that does get
flushed from the newly created child has the name of the child attached.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 4e62a9199f97..97996adeb29a 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -290,12 +290,12 @@ static void start_fpsimd(struct child_data *child, int cpu, int copy)
 {
 	int ret;
 
-	child_start(child, "./fpsimd-test");
-
 	ret = asprintf(&child->name, "FPSIMD-%d-%d", cpu, copy);
 	if (ret == -1)
 		ksft_exit_fail_msg("asprintf() failed\n");
 
+	child_start(child, "./fpsimd-test");
+
 	ksft_print_msg("Started %s\n", child->name);
 }
 
@@ -307,12 +307,12 @@ static void start_sve(struct child_data *child, int vl, int cpu)
 	if (ret < 0)
 		ksft_exit_fail_msg("Failed to set SVE VL %d\n", vl);
 
-	child_start(child, "./sve-test");
-
 	ret = asprintf(&child->name, "SVE-VL-%d-%d", vl, cpu);
 	if (ret == -1)
 		ksft_exit_fail_msg("asprintf() failed\n");
 
+	child_start(child, "./sve-test");
+
 	ksft_print_msg("Started %s\n", child->name);
 }
 
@@ -320,16 +320,16 @@ static void start_ssve(struct child_data *child, int vl, int cpu)
 {
 	int ret;
 
+	ret = asprintf(&child->name, "SSVE-VL-%d-%d", vl, cpu);
+	if (ret == -1)
+		ksft_exit_fail_msg("asprintf() failed\n");
+
 	ret = prctl(PR_SME_SET_VL, vl | PR_SME_VL_INHERIT);
 	if (ret < 0)
 		ksft_exit_fail_msg("Failed to set SME VL %d\n", ret);
 
 	child_start(child, "./ssve-test");
 
-	ret = asprintf(&child->name, "SSVE-VL-%d-%d", vl, cpu);
-	if (ret == -1)
-		ksft_exit_fail_msg("asprintf() failed\n");
-
 	ksft_print_msg("Started %s\n", child->name);
 }
 
@@ -341,12 +341,12 @@ static void start_za(struct child_data *child, int vl, int cpu)
 	if (ret < 0)
 		ksft_exit_fail_msg("Failed to set SME VL %d\n", ret);
 
-	child_start(child, "./za-test");
-
 	ret = asprintf(&child->name, "ZA-VL-%d-%d", vl, cpu);
 	if (ret == -1)
 		ksft_exit_fail_msg("asprintf() failed\n");
 
+	child_start(child, "./za-test");
+
 	ksft_print_msg("Started %s\n", child->name);
 }
 

base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
-- 
2.30.2

