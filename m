Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE563CADF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 23:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiK2WAK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 17:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiK2V7l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 16:59:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC8C6F0EB
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:59:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCFE5B81982
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 21:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A31C433D6;
        Tue, 29 Nov 2022 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669759177;
        bh=ljBbwXbpFXylIv5/T0HUheeXkTvpejFf0PIQp2UDE54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjqEg0MFHoe2NRdlYELnD55gyH5YlG+KHhReuPjnTS1om0cBDp4S6rCedAkYY0Fjz
         D0NaesqX4kUbJqfyyVlaQUx/zyuxS4C8HnhyqWn9+sn5/WjeuNldmKrc7a87FWwkCQ
         eR1wnAIBht6423NP2cX6NT0ELUvA62wk0Ynw2pDilkoyOdKDUKRr+VzDs1rBOtAZr/
         q9xz2Ai7hV3Z7D3znA0CXK6f0+7JjYvQe7uBjk4BnKRRylXxX8X1wRv5RW+u5ouKH/
         YiLLwnrsIIh/XLz/49oRG5SpVnHEW0TZPyZ4pn+ps899IhsicpV1TH/yfBR3+jdI7p
         dVI9oqSHwhMqA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] kselftest/arm64: Allow epoll_wait() to return more than one result
Date:   Tue, 29 Nov 2022 21:59:25 +0000
Message-Id: <20221129215926.442895-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129215926.442895-1-broonie@kernel.org>
References: <20221129215926.442895-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3405; i=broonie@kernel.org; h=from:subject; bh=ljBbwXbpFXylIv5/T0HUheeXkTvpejFf0PIQp2UDE54=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhoC9A5hGVU7vrA26t1EofYEAYFWU+d06yuxERowW NHf5mnOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aAvQAKCRAk1otyXVSH0HutB/ 9EtlLjCLWE6479Xq7SRHRmkOeZHGiW8VuS2J1o1KWRgT4ApriYUULxzrOrEHfPK4zTlKXngz36MAYt SMp0guIKlf/BbM/ZTtbqSyfkQJcxVT5o0edBS69yO0PIcR4D5OOZTAcJ4fZKuzB2yqp2U+pP6FVk2e gdgquW/u5YIFceUL1ycSd9FdjyaoNpeh5AhlusBjx6SxRHQQ/iHDdtCpvHdv3uWx+VozhwtvqW87eU FMx3zEdfRT/hfXVmCDMyWqrfsRQPV0qaV4PIWUYiQws+eLWWEKhuh4tHQexzOLnNjdNDkpJt5ASrJE Rael97M7oOifNEO8oUT0uaAmNshYBv
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

When everything is starting up we are likely to have a lot of child
processes producing output at once.  This means that we can reduce
overhead a bit by allowing epoll_wait() to return more than one
descriptor at once, it cuts down on the number of system calls we need
to do which on virtual platforms where the syscall overhead is a bit
more noticable and we're likely to have a lot more children active can
make a small but noticable difference.

On physical platforms the relatively small number of processes being run
and vastly improved speeds push the effects of this change into the
noise.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 27 +++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index b3bbfe8d9f56..f8b2f41aac36 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -39,6 +39,8 @@ struct child_data {
 
 static int epoll_fd;
 static struct child_data *children;
+static struct epoll_event *evs;
+static int tests;
 static int num_children;
 static bool terminate;
 
@@ -393,11 +395,11 @@ static void probe_vls(int vls[], int *vl_count, int set_vl)
 /* Handle any pending output without blocking */
 static void drain_output(bool flush)
 {
-	struct epoll_event ev;
 	int ret = 1;
+	int i;
 
 	while (ret > 0) {
-		ret = epoll_wait(epoll_fd, &ev, 1, 0);
+		ret = epoll_wait(epoll_fd, evs, tests, 0);
 		if (ret < 0) {
 			if (errno == EINTR)
 				continue;
@@ -405,8 +407,8 @@ static void drain_output(bool flush)
 				       strerror(errno), errno);
 		}
 
-		if (ret == 1)
-			child_output(ev.data.ptr, ev.events, flush);
+		for (i = 0; i < ret; i++)
+			child_output(evs[i].data.ptr, evs[i].events, flush);
 	}
 }
 
@@ -419,12 +421,11 @@ int main(int argc, char **argv)
 {
 	int ret;
 	int timeout = 10;
-	int cpus, tests, i, j, c;
+	int cpus, i, j, c;
 	int sve_vl_count, sme_vl_count, fpsimd_per_cpu;
 	bool all_children_started = false;
 	int seen_children;
 	int sve_vls[MAX_VLS], sme_vls[MAX_VLS];
-	struct epoll_event ev;
 	struct sigaction sa;
 
 	while ((c = getopt_long(argc, argv, "t:", options, NULL)) != -1) {
@@ -510,6 +511,11 @@ int main(int argc, char **argv)
 		ksft_print_msg("Failed to install SIGCHLD handler: %s (%d)\n",
 			       strerror(errno), errno);
 
+	evs = calloc(tests, sizeof(*evs));
+	if (!evs)
+		ksft_exit_fail_msg("Failed to allocated %d epoll events\n",
+				   tests);
+
 	for (i = 0; i < cpus; i++) {
 		for (j = 0; j < fpsimd_per_cpu; j++)
 			start_fpsimd(&children[num_children++], i, j);
@@ -543,7 +549,7 @@ int main(int argc, char **argv)
 		 * useful in emulation where we will both be slow and
 		 * likely to have a large set of VLs.
 		 */
-		ret = epoll_wait(epoll_fd, &ev, 1, 1000);
+		ret = epoll_wait(epoll_fd, evs, tests, 1000);
 		if (ret < 0) {
 			if (errno == EINTR)
 				continue;
@@ -552,8 +558,11 @@ int main(int argc, char **argv)
 		}
 
 		/* Output? */
-		if (ret == 1) {
-			child_output(ev.data.ptr, ev.events, false);
+		if (ret > 0) {
+			for (i = 0; i < ret; i++) {
+				child_output(evs[i].data.ptr, evs[i].events,
+					     false);
+			}
 			continue;
 		}
 
-- 
2.30.2

