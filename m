Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304A663B640
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 01:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiK2AE2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 19:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiK2AE0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 19:04:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493801AD92
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 16:04:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D954B61516
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 00:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7244C43141;
        Tue, 29 Nov 2022 00:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669680265;
        bh=Y43qJ/bNGK9Ddo25ogKXBarnhJnlJyovlWA7DkFzBLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7TjS4Ihh0OtWz32ArdI3FbEP9c/5tx+0f1FrR3O/fm0U/F9maIjVrCg4XZzrjADc
         g9QrOJdtQj58hg3lH6RpChyJpmZ06qWKwBu56daQbuweWGvMn2CrEXp29i3L8AAE5B
         fMycNHEDbCEihMhICWVYjvi2hBnW14hc8P/J5DTU3RIzGvl1XEYzhzRkTLP4wLwvXc
         j/J6vSkm+mWFgMK5pLd2LqXOKQa/4z8/pScnAgSFRRvtW8hhVoesCK+kjOulPEX/Ul
         sniDrlqKMrKk3joAmmwIKpV8eiX+5GRCbuuDbXYJbZ6xGN8jzxrIK1Wrtr/06fTssa
         EhLuZ0BmCYtpw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/3] kselftest/arm64: Allow epoll_wait() to return more than one result
Date:   Tue, 29 Nov 2022 00:03:55 +0000
Message-Id: <20221129000355.812425-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129000355.812425-1-broonie@kernel.org>
References: <20221129000355.812425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3344; i=broonie@kernel.org; h=from:subject; bh=Y43qJ/bNGK9Ddo25ogKXBarnhJnlJyovlWA7DkFzBLE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhUxqhIIw+/0qMtilo7qwuKBAbrQGk/zdnqtiunQb UH+OizmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4VMagAKCRAk1otyXVSH0BUgB/ 9/acYMk3PSV+yuqpG5TG1+9R2clCgHlt/XdScreju0VnajaqncYZjjCgK09lMvWJU2URpIOeQaYAEz K0ALu8kKxKdvxKzBNndRWyVZAi+GhWvl31EhlmQkCuRj56vFVGy4/g6Gu59CeYcLO4wp5f9wxL5iE0 qEWi6hRN+Q1TwBJM6g0YsfQ6qKeeyocB8QhD0VK1FPk2H4pYsUl/sk+m+SRndEMNbC21ygg1hLcjZD 046yZfje1ZnDHyU9wWb8d/DllyFqnGPUIiRVH2awAW6Ym434ptFzCSBppNszx1ZjypUjbKrphx4MPR V6KKjEPUvr8yFJ8yGu2vDJISdMKwKd
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
index 65262cf30b09..d22f6e356440 100644
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
 
@@ -419,10 +421,9 @@ int main(int argc, char **argv)
 {
 	int ret;
 	int timeout = 10;
-	int cpus, tests, i, j, c;
+	int cpus, i, j, c;
 	int sve_vl_count, sme_vl_count, fpsimd_per_cpu;
 	int sve_vls[MAX_VLS], sme_vls[MAX_VLS];
-	struct epoll_event ev;
 	struct sigaction sa;
 
 	while ((c = getopt_long(argc, argv, "t:", options, NULL)) != -1) {
@@ -508,6 +509,11 @@ int main(int argc, char **argv)
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
@@ -541,7 +547,7 @@ int main(int argc, char **argv)
 		 * useful in emulation where we will both be slow and
 		 * likely to have a large set of VLs.
 		 */
-		ret = epoll_wait(epoll_fd, &ev, 1, 1000);
+		ret = epoll_wait(epoll_fd, evs, tests, 1000);
 		if (ret < 0) {
 			if (errno == EINTR)
 				continue;
@@ -550,8 +556,11 @@ int main(int argc, char **argv)
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

