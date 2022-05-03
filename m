Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62E517F85
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 10:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiECIO6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiECIOp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 04:14:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8EC48
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 01:11:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g3so13481681pgg.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 May 2022 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uy1D1ynmt1IvB209RVxSGUYOS4OREreCXZ3NiChVu50=;
        b=E2y5XQowGGGTd48FMByGXrfc0z/3P9KkfNQyjB15pahPXOI1SrG4scBxsm0bITCKjU
         SGRDRdUvjyv16VM3dfDCI5156o6d2eQAdn06H7KLaVuaPfHYksWUJpkQG1/Ze2cd9Byr
         EbkuJky7ixTt25HtQq+L5eax4uYHg/qmF0Z5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uy1D1ynmt1IvB209RVxSGUYOS4OREreCXZ3NiChVu50=;
        b=6TxjyComWXvArK9ez1MkFA+vgrU+weO8wcXtdhFOgjB507EbJDfjqqwT5SQBHFI/Ht
         lN1SatvAwyBIg/T5J/M3O9EF/8PRM05JUXz6AhhX98bhY0crnuUc5TKO787ISFi+EePY
         xmQk7fUJBYCBLyIFaeGGOGJbxE1HazV4EVvubI5WRQYnprscBvohVm+Q2QULR0xUe+A0
         OlQp7dZ4/BObqsYxTaq6z4wl5oZpFXXoEIzHsihbQ1VvaaobkH7HDlAtEEkgG0fxOWOK
         2ocQoa2TTbViBSq/fGTLnWwBIAZoF72o2MsoEExRBJXkQVmHK7Lxx85yVKHEWlquHBdc
         1n5g==
X-Gm-Message-State: AOAM531c0wNkt4PTZ/cL1VVvAERyt671N9T1PsTfR0hwWfR+8xq/qXIm
        RTaP3RgCo3LSghONSRMXKxYTAw==
X-Google-Smtp-Source: ABdhPJzOC/8AW6mEMzYOaZsn4tjCI+qEc8+no77r/W35tKH7mGl1EWryWbr6xNiESXlqi83hB4k2/g==
X-Received: by 2002:a05:6a00:164c:b0:50a:472a:6b0a with SMTP id m12-20020a056a00164c00b0050a472a6b0amr15030982pfc.77.1651565473813;
        Tue, 03 May 2022 01:11:13 -0700 (PDT)
Received: from localhost.localdomain (99-0-82-137.lightspeed.sntcca.sbcglobal.net. [99.0.82.137])
        by smtp.gmail.com with ESMTPSA id h2-20020aa786c2000000b0050dc762815dsm5821069pfo.55.2022.05.03.01.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 01:11:12 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tycho Andersen <tycho@tycho.pizza>,
        Alban Crequy <alban@kinvolk.io>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/3] selftests/seccomp: Refactor get_proc_stat to split out file reading code
Date:   Tue,  3 May 2022 01:09:57 -0700
Message-Id: <20220503080958.20220-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503080958.20220-1-sargun@sargun.me>
References: <20220503080958.20220-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This splits up the get_proc_stat function to make it so we can use it as a
generic helper to read the nth field from multiple different files, versus
replicating the logic in multiple places.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 54 +++++++++++++------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index ab340c4759a3..4fb5eda89223 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4231,32 +4231,54 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
-static char get_proc_stat(int pid)
+/*
+ * gen_nth - Get the nth, space separated entry in a file.
+ *
+ * Returns the length of the read field.
+ * Throws error if field is zero-lengthed.
+ */
+static ssize_t get_nth(struct __test_metadata *_metadata, const char *path,
+		     const unsigned int position, char **entry)
 {
-	char proc_path[100] = {0};
 	char *line = NULL;
-	size_t len = 0;
+	unsigned int i;
 	ssize_t nread;
-	char status;
+	size_t len = 0;
 	FILE *f;
-	int i;
 
-	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
-	f = fopen(proc_path, "r");
-	if (f == NULL)
-		ksft_exit_fail_msg("%s - Could not open %s\n",
-				   strerror(errno), proc_path);
+	f = fopen(path, "r");
+	ASSERT_NE(f, NULL) {
+		TH_LOG("Coud not open %s: %s", path, strerror(errno));
+	}
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < position; i++) {
 		nread = getdelim(&line, &len, ' ', f);
-		if (nread <= 0)
-			ksft_exit_fail_msg("Failed to read status: %s\n",
-					   strerror(errno));
+		ASSERT_GE(nread, 0) {
+			TH_LOG("Failed to read %d entry in file %s", i, path);
+		}
 	}
+	fclose(f);
+
+	ASSERT_GT(nread, 0) {
+		TH_LOG("Entry in file %s had zero length", path);
+	}
+
+	*entry = line;
+	return nread - 1;
+}
+
+/* For a given PID, get the task state (D, R, etc...) */
+static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
+{
+	char proc_path[100] = {0};
+	char status;
+	char *line;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
+	ASSERT_EQ(get_nth(_metadata, proc_path, 3, &line), 1);
 
 	status = *line;
 	free(line);
-	fclose(f);
 
 	return status;
 }
@@ -4317,7 +4339,7 @@ TEST(user_notification_fifo)
 	/* This spins until all of the children are sleeping */
 restart_wait:
 	for (i = 0; i < ARRAY_SIZE(pids); i++) {
-		if (get_proc_stat(pids[i]) != 'S') {
+		if (get_proc_stat(_metadata, pids[i]) != 'S') {
 			nanosleep(&delay, NULL);
 			goto restart_wait;
 		}
-- 
2.25.1

