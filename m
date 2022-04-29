Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF03B515933
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 01:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381873AbiD3AAZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 20:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381894AbiD3AAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 20:00:24 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF1A3DDD9
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:58 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b6-20020a170903228600b0015d22ba49a9so4843673plh.16
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dt5qrG3wcawTErF8gAeFZK9PLafcOjd56PtZwr2P1S8=;
        b=eshRTYicZVODQxvfu2H6YO19874gPpb4JmB7SiyH+r8v88e1yy0CyzIJ6cXRpS745p
         jIC4LK42qi3w2enjgiMngcBNjQnC4475GA/6h4RvXU5asE1qcG1JZ/ZpNK1QDWihmeqB
         8q513S7+dyCzm3lHWFnB1UZkVGofAgAa5M0WfTcvSS88Q8rgBbvV2oWa5pERuT1UGP6R
         UtwNrKYpvPg91GSCyF8yOBhQcCRhRliEe62xPWYLLXIZQCJUNONCJRSXGVueGm2ok86j
         oBlI4cofJniKQVjlhPDZfGUNn8xCqsEhTGsq3Lm8EXKyVW+UXf54v4Tsu8Ao9H8KvVAK
         JN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dt5qrG3wcawTErF8gAeFZK9PLafcOjd56PtZwr2P1S8=;
        b=TSmqXUNicZwAK+zGFLNWPyLDDExEH1v20j1XMGrh3z9XKmT51RfpIMVh6zYSRjYV/k
         WWlUxb4VzlyeCAt8UtFUVZ7+lo512+FSFw+RSOUu2e5X8z3IGR6G5bnjkcE7KM0BuHup
         jQpcSveTNcnnggxMSiVKXIGcpuekCq2zyYEagrQ/iec0OQK/t0J4uE29SCOXo1gVEc9r
         9W5mHlfJHreZufxZlzWV6EfIkEE1zz3wlcVmp8NQtZO5uNPD1jdE9wlsJXw+uUfQ2x22
         m8YsZaOr6rYJrLYnCQiQRTmEcWK8TcVLgRyrYbbD9T37dPT4JMbLWpXwazJAlewl4cLT
         Wcig==
X-Gm-Message-State: AOAM533FWIPwbGzcaS82RcdjiYsqLTpW5Bun1LcQWcO/mAbN53LGTmZ8
        707Hwou8uWXOnni/oD0qZzOU8pvvFnQU+w==
X-Google-Smtp-Source: ABdhPJxvR8J99tlCFhva8S09DUJDaWOvMzz82uuZd3XNH08tRnd0NCsrWrBbHWNRE5hNnisw2+nFWNMoE+ESgA==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:c986:b0:1d9:56e7:4e83 with SMTP
 id w6-20020a17090ac98600b001d956e74e83mr470128pjt.1.1651276617250; Fri, 29
 Apr 2022 16:56:57 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:56:42 +0000
In-Reply-To: <20220429235644.697372-1-cmllamas@google.com>
Message-Id: <20220429235644.697372-4-cmllamas@google.com>
Mime-Version: 1.0
References: <20220429235644.697372-1-cmllamas@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 3/5] binderfs: add extended_error feature entry
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add extended_error to the binderfs feature list, to help userspace
determine whether the BINDER_GET_EXTENDED_ERROR ioctl is supported by
the binder driver.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e3605cdd4335..6c5e94f6cb3a 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -60,6 +60,7 @@ enum binderfs_stats_mode {
 
 struct binder_features {
 	bool oneway_spam_detection;
+	bool extended_error;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -75,6 +76,7 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
 
 static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
+	.extended_error = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -615,6 +617,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "extended_error",
+				      &binder_features_fops,
+				      &binder_features.extended_error);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 0315955ff0f4..9409bb136d95 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -64,6 +64,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
 	static const char * const binder_features[] = {
 		"oneway_spam_detection",
+		"extended_error",
 	};
 
 	change_mountns(_metadata);
-- 
2.36.0.464.gb9c8b46e94-goog

