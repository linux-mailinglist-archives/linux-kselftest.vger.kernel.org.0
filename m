Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2746512925
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 03:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiD1B7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 21:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiD1B7g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 21:59:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0946651
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 18:56:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d15so3068316pll.10
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEcNSiaDgqCQTOD0WHJ5CmXveRjV7YkdAup8UYWATQA=;
        b=CQ81ynmmkryn0ZoG2mZWOm/YOBgsz/sPSKCuZXy2qvyQj1AvsNu7edzdJudne1VcOu
         U5ZvctWsFrJ5LuwflBMasuGCA8ftt8drTqHu0m7BAgMfuAl50CORS2VbQxc+E4nb2izY
         fJY+n8GhNnbdZyhjA4H64Ir8RqAmYZ+iKgkb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEcNSiaDgqCQTOD0WHJ5CmXveRjV7YkdAup8UYWATQA=;
        b=b9s/FWG1W/waOXvhjdeyFnIgih5m4VwWyLFgBOnq54kHmD/4/R3aVoH3VuYsd8nVUm
         n54VeuuqPEObAAwWF7uApWuOWCcXQ4zSGmEb3qWm79noJJlmknlzI8EchA2DIY6/lXiD
         gnWLKfR6YznE0So3/oqu9tOabWMjiqRFavR+SmCAAjUXwPSEjX1l1UXPkAW6MKPhvrhi
         nM1VcH7KM5guofn2//FN+GUbh42xlbxo2AcZiTjDgxT/Ei93pmdXnUu2h82kKfR4TGO2
         F60uPLHLg6fBAjTlo+wJV/Oo+JAnf2jZDDXzvXrzm37esbV7/b5hKev0d7TqIYH2P6yc
         FyLA==
X-Gm-Message-State: AOAM530+ZFo6RslD0PZkVvTsHcGBLD8N/fj174TPV4zHi6oSKm2uqAbh
        Y5IcZClvXNw5eXrmguqZJWkpc5iPpLbj7Q==
X-Google-Smtp-Source: ABdhPJzNlSkO0bLLdXqTAvV5hz+K17mPaE7qeYxp98oB1k3Q3mQ9gBDW2JIwev81mmEJuZH8FLShew==
X-Received: by 2002:a17:903:20f:b0:158:d86a:f473 with SMTP id r15-20020a170903020f00b00158d86af473mr31568087plh.92.1651110981954;
        Wed, 27 Apr 2022 18:56:21 -0700 (PDT)
Received: from localhost.localdomain ([69.53.254.5])
        by smtp.gmail.com with ESMTPSA id y14-20020a63ce0e000000b003c14af505edsm637814pgf.5.2022.04.27.18.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 18:56:20 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/seccomp: Ensure that notifications come in FIFO order
Date:   Wed, 27 Apr 2022 18:54:47 -0700
Message-Id: <20220428015447.13661-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428015447.13661-1-sargun@sargun.me>
References: <20220428015447.13661-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When multiple notifications are waiting, ensure they show up in order, as
defined by the (predictable) seccomp notification ID. This ensures FIFO
ordering of notification delivery as notification ids are monitonic and
decided when the notification is generated (as opposed to received).

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 9d126d7fabdb..33fb3d0c3347 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4231,6 +4231,115 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+static char get_proc_stat(int pid)
+{
+	char proc_path[100] = {0};
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	char status;
+	FILE *f;
+	int i;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
+	f = fopen(proc_path, "r");
+	if (f == NULL)
+		ksft_exit_fail_msg("%s - Could not open %s\n",
+				   strerror(errno), proc_path);
+
+	for (i = 0; i < 3; i++) {
+		nread = getdelim(&line, &len, ' ', f);
+		if (nread <= 0)
+			ksft_exit_fail_msg("Failed to read status: %s\n",
+					   strerror(errno));
+	}
+
+	status = *line;
+	free(line);
+	fclose(f);
+
+	return status;
+}
+
+TEST(user_notification_fifo)
+{
+	struct seccomp_notif_resp resp = {};
+	struct seccomp_notif req = {};
+	int i, status, listener;
+	pid_t pid, pids[3];
+	__u64 baseid;
+	long ret;
+	/* 100 ms */
+	struct timespec delay = { .tv_nsec = 100000000 };
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Setup a listener */
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = syscall(__NR_getppid);
+		exit(ret != USER_NOTIF_MAGIC);
+	}
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	baseid = req.id + 1;
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	/* check that we make sure flags == 0 */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* Start children, and them generate notifications */
+	for (i = 0; i < ARRAY_SIZE(pids); i++) {
+		pid = fork();
+		if (pid == 0) {
+			ret = syscall(__NR_getppid);
+			exit(ret != USER_NOTIF_MAGIC);
+		}
+		pids[i] = pid;
+	}
+
+	/* This spins until all of the children are sleeping */
+restart_wait:
+	for (i = 0; i < ARRAY_SIZE(pids); i++) {
+		if (get_proc_stat(pids[i]) != 'S') {
+			nanosleep(&delay, NULL);
+			goto restart_wait;
+		}
+	}
+
+	/* Read the notifications in order (and respond) */
+	for (i = 0; i < ARRAY_SIZE(pids); i++) {
+		memset(&req, 0, sizeof(req));
+		EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+		EXPECT_EQ(req.id, baseid + i);
+		resp.id = req.id;
+		EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+	}
+
+	/* Make sure notifications were received */
+	for (i = 0; i < ARRAY_SIZE(pids); i++) {
+		EXPECT_EQ(waitpid(pids[i], &status, 0), pids[i]);
+		EXPECT_EQ(true, WIFEXITED(status));
+		EXPECT_EQ(0, WEXITSTATUS(status));
+	}
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.25.1

