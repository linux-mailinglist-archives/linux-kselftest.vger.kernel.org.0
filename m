Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABB36E1A53
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 04:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDNC2P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 22:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDNC2P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 22:28:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED384EF3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 19:28:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f2so8587286pjs.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 19:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681439285; x=1684031285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wV0ORfeXv57jdNTZ94hzyydSs04V0lY4z8KcxEzlrGU=;
        b=LNh11wT4EHIzhimZwEgXV9BDMf7nHy+oBl6lf8qtqMoNiEz6OoQG9N1T2bGlwiCoe7
         izBspUiGU1sLSEskgQCVo7NLelLl2Ec5Fsqg+nqpkAkfvZRlAPfALKIxZsDh5hB5bByW
         Jd+YhfV2XTBYasK3IDCGRuYOotcdq44GCS8nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681439285; x=1684031285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wV0ORfeXv57jdNTZ94hzyydSs04V0lY4z8KcxEzlrGU=;
        b=bDdbMH8NnYL42hUkM3kRxpHl/Xx5Y8E0kAjMzO2bb9nVebNiYchT63fBi2S84BfOV2
         posN+BPDL9F7uXdlwYR8j6Q+xln2kTvaBFtyJX1wkjT0vttLHgKVbWu0pvvVAzvd6Fot
         OzHhqDIwNpLhMrkNJZgMx1KlqvgSubi1cgyWN7Zl60Rtb3L4TTXQDugxXQwcQULHH1yc
         xqLrxn1StGmyNuF+tfhxg0icD1M3xEdyDu2Onc3DsgvpKDtvQ5x84m46xqykru9Iu2J0
         Hb660Tve/wZ2Ozzwvq52YesoNR02gqEBgs+Tf74gFAUUorf6NekGJPOQMK0QplG3udt7
         ndLw==
X-Gm-Message-State: AAQBX9dQAN7KCsZQ+2smOakfsHaQSvEYODAcWPZ6gnhuZJd5Z7gEuRQQ
        5J7UsPRNwUg/tGHhzTnw0tcXLQ==
X-Google-Smtp-Source: AKy350YAYoawfrxXQq9o1RU60KWyzyS6aXgZpnvHFLuSmoSnnEGsr+nci58MA60iAQlgbFwQQ9A5RA==
X-Received: by 2002:a17:90a:7c0f:b0:23f:83de:7e4a with SMTP id v15-20020a17090a7c0f00b0023f83de7e4amr4082251pjf.7.1681439284753;
        Thu, 13 Apr 2023 19:28:04 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id m2-20020a17090aab0200b0024677263e36sm1972982pjq.43.2023.04.13.19.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 19:28:04 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] selftests/memfd: fix test_sysctl
Date:   Fri, 14 Apr 2023 02:28:01 +0000
Message-ID: <20230414022801.2545257-1-jeffxu@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

sysctl memfd_noexec is pid-namespaced, non-reservable,
and inherent to the child process.
Moving the inherence test from init ns to child ns, so
init ns can keep the default value.

Signed-off-by: Jeff Xu <jeffxu@google.com>
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202303312259.441e35db-yujie.liu@intel.com
---
 tools/testing/selftests/memfd/memfd_test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index ae71f15f790d..dba0e8ba002f 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -43,6 +43,9 @@
  */
 static size_t mfd_def_size = MFD_DEF_SIZE;
 static const char *memfd_str = MEMFD_STR;
+static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *));
+static int newpid_thread_fn2(void *arg);
+static void join_newpid_thread(pid_t pid);
 
 static ssize_t fd2name(int fd, char *buf, size_t bufsize)
 {
@@ -1111,6 +1114,7 @@ static void test_noexec_seal(void)
 static void test_sysctl_child(void)
 {
 	int fd;
+	int pid;
 
 	printf("%s sysctl 0\n", memfd_str);
 	sysctl_assert_write("0");
@@ -1129,6 +1133,10 @@ static void test_sysctl_child(void)
 			    mfd_def_size,
 			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
 
+	printf("%s child ns\n", memfd_str);
+	pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn2);
+	join_newpid_thread(pid);
+
 	mfd_assert_mode(fd, 0666);
 	mfd_assert_has_seals(fd, F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
@@ -1206,12 +1214,6 @@ static void test_sysctl(void)
 	int pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn);
 
 	join_newpid_thread(pid);
-
-	printf("%s child ns\n", memfd_str);
-	sysctl_assert_write("1");
-
-	pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn2);
-	join_newpid_thread(pid);
 }
 
 /*
-- 
2.40.0.577.gac1e443424-goog

