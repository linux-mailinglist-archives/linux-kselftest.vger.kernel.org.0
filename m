Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB682714245
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 05:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjE2DVK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 23:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjE2DVJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 23:21:09 -0400
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B0B1;
        Sun, 28 May 2023 20:21:07 -0700 (PDT)
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1b0236ee816so12012445ad.1;
        Sun, 28 May 2023 20:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685330467; x=1687922467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4P7WeN5KQdMR5j63wqiGQQE4xifYy2/Pv0geGlldDZQ=;
        b=QzkolDpQ5uDt7iU73UZg/FlNZquAtm2r+udHpCNRbvR7zb7KAKlzx0//H/j8hgVg5g
         GSryfiPSKcjdOUDhvVLw+Q/I1cbVA03VqxA7lfGh3L0HLsI8UiuHNVjhTcHQMA4zPDwV
         hCHjSMbN82NjZLOzhfgL+Ll/CoiNMtCWmrQlKx/7H8707z4wHkdKQr9XUCry45+Y4CFq
         od6dpGxzPfe2rIA1j4vSCSO8d6V4dzNhO0ANCWfvqNOYiWM3gkmYRuW7rOR/89JU0Iwn
         pi0diVZHrJapY6EWKDRsP9KV/ufiGs+4jtQqjz29eo4mmz1GRDGgouJZq51p6a8fm21x
         XcrA==
X-Gm-Message-State: AC+VfDzMtu0pzNLn6iTNbicTZ1L4m4wXyMCN9fFm9+qq/wO399BLFNzY
        4rwAVYZwg07tYts5iwM4ew==
X-Google-Smtp-Source: ACHHUZ7KbZ5y2GcO7mQJo8WOqG4gdj1JXDA44XcB/CfyTeatvk0aZo1hZ0W4/oo0C/DvMHQavQ4OJQ==
X-Received: by 2002:a17:903:18a:b0:1ad:e2b6:d2a0 with SMTP id z10-20020a170903018a00b001ade2b6d2a0mr7625869plg.11.1685330467048;
        Sun, 28 May 2023 20:21:07 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b001b04772d33esm417634plb.165.2023.05.28.20.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 20:21:06 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, beaub@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH V3] tracing/user_events: Prevent same name but different args event
Date:   Mon, 29 May 2023 11:21:00 +0800
Message-Id: <20230529032100.286534-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

User processes register name_args for events. If the same name but different
args event are registered. The trace outputs of second event are printed
as the first event. This is incorrect.

Return EADDRINUSE back to the user process if the same name but different args
event has being registered.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c              | 36 +++++++++++++++----
 .../selftests/user_events/ftrace_test.c       |  6 ++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..e90161294698 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1753,6 +1753,8 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	int ret;
 	u32 key;
 	struct user_event *user;
+	int argc = 0;
+	char **argv;
 
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
@@ -1760,13 +1762,35 @@ static int user_event_parse(struct user_event_group *group, char *name,
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
 
 	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 7c99cef94a65..6e8c4b47281c 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -228,6 +228,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
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
2.25.1

