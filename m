Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0895DEA91
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 20:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIUSRo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 14:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiIUSRn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 14:17:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E22A3450
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 11:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC852B82257
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 18:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77A4C433D6;
        Wed, 21 Sep 2022 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663784259;
        bh=/kCtptTTWEb3AePTiK49kvfDAIqsfjXBgTxkdXkZuoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvyy+vdYMjjKMP/ZKpA9BIKOVeCiSgIvyqopDWASdkyslBAgg35WzcHJzntlWMr+v
         9RYMSwGN7y8/8jHpL9vcVlWRsutyAxFAclbR9uYI5PFJL+LmhA5Jzg/wxItTiCoxua
         mYIBMlDnQWnjW7ortqQfKxsIVdahKDlPEHCjIK/hcq5F2eDz31GdO9P3zipCgkMX3n
         kanxN2sPZdNcPFSIXR9I5ziCZMi3TCDCW/BL7y7jGkkygWrN+6I05mVAO80hUaTlwy
         W/EaMTCu3G9Q3TeP9/80ESH3xT8M0OAh/OZGALVH6mbzjF0FKpQg/xg3tlvatzmecY
         W8DR6kZ4lnfBw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/3] kselftest/arm64: Handle EINTR while reading data from children
Date:   Wed, 21 Sep 2022 19:13:45 +0100
Message-Id: <20220921181345.618085-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921181345.618085-1-broonie@kernel.org>
References: <20220921181345.618085-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3556; i=broonie@kernel.org; h=from:subject; bh=/kCtptTTWEb3AePTiK49kvfDAIqsfjXBgTxkdXkZuoQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjK1RYELy0MkuqmGPtQHXduRGLPKoxcv4c1Lgvf7bt WOAbetaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYytUWAAKCRAk1otyXVSH0Pv2B/ 0SmfKAEzq2JtcU4oidByx+8xgLBDKk0Eg1QBbmdkA2+8CH17qO/NCZ7nLAeFV4mEOYn4XDaJKyZTmM 8GBUABCCKz/euC0kdGosBaiwMQZiMDsDnJ1+yH2yuulXB9gtU7fsuIifBB2rEn3mKcf3BrzYdkyk3i J2HBRl9WRlQkVxBGslEZyCNj38ybbs/NdQ0VnM4+JFnUdsJAARgg2Syib/+0oItgFnKaXNcWVFcNAj b6L63a5JixdXQmM4BIOQAZklXPB6RSalZ8HADcSEDedxqQDY5WOxk01cEig0n5BqSud02KzRlmUT5F Wb4Qezf/hM+I7AQ6jvBrxm9Hz+YNUC
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

Currently we treat any error when reading from the child as a failure and
don't read any more output from that child as a result. This ignores the
fact that it is valid for read() to return EINTR as the error code if there
is a signal pending so we could stop handling the output of children,
especially during exit when we will get some SIGCHLD signals delivered to
us. Fix this by pulling the read handling out into a separate function
which returns a flag if reads should be continued and wrapping it in a
loop.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 85 ++++++++++++--------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 03ce3936220a..4e62a9199f97 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -121,55 +121,70 @@ static void child_start(struct child_data *child, const char *program)
 	}
 }
 
-static void child_output(struct child_data *child, uint32_t events,
-			 bool flush)
+static bool child_output_read(struct child_data *child)
 {
 	char read_data[1024];
 	char work[1024];
 	int ret, len, cur_work, cur_read;
 
-	if (events & EPOLLIN) {
-		ret = read(child->stdout, read_data, sizeof(read_data));
-		if (ret < 0) {
-			ksft_print_msg("%s: read() failed: %s (%d)\n",
-				       child->name, strerror(errno), errno);
-			return;
-		}
-		len = ret;
+	ret = read(child->stdout, read_data, sizeof(read_data));
+	if (ret < 0) {
+		if (errno == EINTR)
+			return true;
 
-		child->output_seen = true;
+		ksft_print_msg("%s: read() failed: %s (%d)\n",
+			       child->name, strerror(errno),
+			       errno);
+		return false;
+	}
+	len = ret;
 
-		/* Pick up any partial read */
-		if (child->output) {
-			strncpy(work, child->output, sizeof(work) - 1);
-			cur_work = strnlen(work, sizeof(work));
-			free(child->output);
-			child->output = NULL;
-		} else {
-			cur_work = 0;
-		}
+	child->output_seen = true;
 
-		cur_read = 0;
-		while (cur_read < len) {
-			work[cur_work] = read_data[cur_read++];
+	/* Pick up any partial read */
+	if (child->output) {
+		strncpy(work, child->output, sizeof(work) - 1);
+		cur_work = strnlen(work, sizeof(work));
+		free(child->output);
+		child->output = NULL;
+	} else {
+		cur_work = 0;
+	}
 
-			if (work[cur_work] == '\n') {
-				work[cur_work] = '\0';
-				ksft_print_msg("%s: %s\n", child->name, work);
-				cur_work = 0;
-			} else {
-				cur_work++;
-			}
-		}
+	cur_read = 0;
+	while (cur_read < len) {
+		work[cur_work] = read_data[cur_read++];
 
-		if (cur_work) {
+		if (work[cur_work] == '\n') {
 			work[cur_work] = '\0';
-			ret = asprintf(&child->output, "%s", work);
-			if (ret == -1)
-				ksft_exit_fail_msg("Out of memory\n");
+			ksft_print_msg("%s: %s\n", child->name, work);
+			cur_work = 0;
+		} else {
+			cur_work++;
 		}
 	}
 
+	if (cur_work) {
+		work[cur_work] = '\0';
+		ret = asprintf(&child->output, "%s", work);
+		if (ret == -1)
+			ksft_exit_fail_msg("Out of memory\n");
+	}
+
+	return false;
+}
+
+static void child_output(struct child_data *child, uint32_t events,
+			 bool flush)
+{
+	bool read_more;
+
+	if (events & EPOLLIN) {
+		do {
+			read_more = child_output_read(child);
+		} while (read_more);
+	}
+
 	if (events & EPOLLHUP) {
 		close(child->stdout);
 		child->stdout = -1;
-- 
2.30.2

