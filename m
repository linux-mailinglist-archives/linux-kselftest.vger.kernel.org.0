Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3D71242A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 12:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjEZKDq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbjEZKDo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 06:03:44 -0400
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6969E;
        Fri, 26 May 2023 03:03:42 -0700 (PDT)
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-53f158ecfe1so375065a12.0;
        Fri, 26 May 2023 03:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685095422; x=1687687422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnY7ZrluZEkGW0ej4AdD1ihrdQ0ygMRjBp2cq55eo6Q=;
        b=kFYWhREc5O5izIs4i+WPYE2orD6+B2c5frnBYsIVKrJlmU6ftaeuTtUmg2KQVzcTa3
         sqaARrnYkTf5B4JoAc8l4R7vlc6VK3mSA6685XerQOxdp6He4WGNLOd3Lte1UdnpU4sb
         Ym0rRoDRWlcBODwplafDZRx3rjfMeze/LxjIgm1v7jTVxvAY8uYddAUetPlS/y7+8RYv
         OJPy3lV3+lpJRq/uJ20djAPzL6z5i941hgYJ4GwPsmCfL6+o5MyHaiZmNmnBGHy/3Aji
         Q9+E0s+AdJWTfKYubMFKeHnSoiQ5FP286MfaMv16yguH/Cv8hXpyIEaZoId4iAtq+Jhn
         HyXw==
X-Gm-Message-State: AC+VfDyVxfZ4EnyB78gj5ifO9qGf3EpCkEG+Esmj5xt3IHL4QuqmjhCQ
        MhXJj2dMvMhM5i2s9mOXkQ==
X-Google-Smtp-Source: ACHHUZ7hjKQq2/mdMWJ09Ulse7m2pM6MN+XnX0EaQ4cHGBA5G6EjrNFoTMPaOE/4NmOirOhvJCOTig==
X-Received: by 2002:a17:902:740b:b0:1b0:99:a22c with SMTP id g11-20020a170902740b00b001b00099a22cmr1859061pll.34.1685095422009;
        Fri, 26 May 2023 03:03:42 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090322ce00b001a800e03cf9sm2875892plg.256.2023.05.26.03.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:03:41 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, beaub@linux.microsoft.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH V2] tracing/user_events: Prevent same name but different args event
Date:   Fri, 26 May 2023 18:03:36 +0800
Message-Id: <20230526100336.76934-1-sunliming@kylinos.cn>
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
 kernel/trace/trace_events_user.c              | 34 +++++++++++++++----
 .../selftests/user_events/ftrace_test.c       |  6 ++++
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..bd455052ccd0 100644
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
@@ -1760,13 +1762,31 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	mutex_unlock(&event_mutex);
 
 	if (user) {
-		*newuser = user;
-		/*
-		 * Name is allocated by caller, free it since it already exists.
-		 * Caller only worries about failure cases for freeing.
-		 */
-		kfree(name);
-		return 0;
+		if (args) {
+			argv = argv_split(GFP_KERNEL, args, &argc);
+			if (!argv)
+				return -ENOMEM;
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
+			ret = 0;
+		} else {
+			refcount_dec(&user->refcnt);
+			ret = -EADDRINUSE;
+		}
+
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

