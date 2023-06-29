Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D90A742CD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjF2TDY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 15:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjF2TBu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD3C3585;
        Thu, 29 Jun 2023 12:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4C061602;
        Thu, 29 Jun 2023 19:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6366AC433CA;
        Thu, 29 Jun 2023 19:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065298;
        bh=ZY1idp9ydYLvERHUwYmAgHRcPhBlYiTuA7Tc90jpkUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZH6i9gGmxCt49EgfJTcYwmxvqvG1H+hcOwHhjzLPrDuJfroSy3/YKWjE6W+Ju/K23
         CIWSNJuVZEFsF2nuENccS81lI3grU/GTx7fLunuF+AjS8k4PcwBvj1MnUbqpmNIDtu
         1Wsa8xWBgCDW2zJpPg68VEeQhuRhIZ+hdZuTgtk7/0hbMqUqWSXRe0d0jN6ICeU107
         j3I/gP+6Jg80SP7+cp3rRSxzUJWeOjl4xgWCVu2tCUAHvx50vGuJfB8kfTqBe7HIK2
         UgSjhPAsEQaw0IcAej9o+1M+R2XslXfomT9Ajm3Ud1sF2Rut6pM/jLRY5xeSHukfgh
         uyODETDybB/RQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     sunliming <sunliming@kylinos.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        quic_mojha@quicinc.com, zwisler@google.com,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/12] tracing/user_events: Prevent same name but different args event
Date:   Thu, 29 Jun 2023 15:01:22 -0400
Message-Id: <20230629190134.907949-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190134.907949-1-sashal@kernel.org>
References: <20230629190134.907949-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

[ Upstream commit ba470eebc2f6c2f704872955a715b9555328e7d0 ]

User processes register name_args for events. If the same name but different
args event are registered. The trace outputs of second event are printed
as the first event. This is incorrect.

Return EADDRINUSE back to the user process if the same name but different args
event has being registered.

Link: https://lore.kernel.org/linux-trace-kernel/20230529032100.286534-1-sunliming@kylinos.cn

Signed-off-by: sunliming <sunliming@kylinos.cn>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_user.c              | 36 +++++++++++++++----
 .../selftests/user_events/ftrace_test.c       |  6 ++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 625cab4b9d945..774d146c2c2ca 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1274,6 +1274,8 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	int index;
 	u32 key;
 	struct user_event *user;
+	int argc = 0;
+	char **argv;
 
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
@@ -1281,13 +1283,35 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	mutex_unlock(&event_mutex);
 
 	if (user) {
-		*newuser = user;
-		/*
-		 * Name is allocated by caller, free it since it already exists.
-		 * Caller only worries about failure cases for freeing.
-		 */
-		kfree(name);
+		if (args) {
+			argv = argv_split(GFP_KERNEL, args, &argc);
+			if (!argv) {
+				ret = -ENOMEM;
+				goto error;
+			}
+
+			ret = user_fields_match(user, argc, (const char **)argv);
+			argv_free(argv);
+
+		} else
+			ret = list_empty(&user->fields);
+
+		if (ret) {
+			*newuser = user;
+			/*
+			 * Name is allocated by caller, free it since it already exists.
+			 * Caller only worries about failure cases for freeing.
+			 */
+			kfree(name);
+		} else {
+			ret = -EADDRINUSE;
+			goto error;
+		}
+
 		return 0;
+error:
+		refcount_dec(&user->refcnt);
+		return ret;
 	}
 
 	index = find_first_zero_bit(group->page_bitmap, MAX_EVENTS);
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 1bc26e6476fc3..df0e776c2cc1b 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -209,6 +209,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, reg.write_index);
 	ASSERT_NE(0, reg.status_bit);
 
+	/* Multiple registers to same name but different args should fail */
+	reg.enable_bit = 29;
+	reg.name_args = (__u64)"__test_event u32 field1;";
+	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(EADDRINUSE, errno);
+
 	/* Ensure disabled */
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, self->enable_fd);
-- 
2.39.2

