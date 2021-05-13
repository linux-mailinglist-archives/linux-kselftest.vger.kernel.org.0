Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42537FE3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 21:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhEMThd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 15:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhEMTh2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 15:37:28 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED7C06175F
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:17 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a198-20020a3766cf0000b0290320e7711ebdso4432966qkc.22
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nAjJNcbSrTVyC9xT3GK+BCC2nCovQf7Djw6rij3xpcY=;
        b=s2dk81EXLTewrXFgaIJ5Gft88QlFAOU8CxoluJsEKYnDIBm61BF58bUGSWxlTI8GFl
         e6zr5JpAjJRPsoc1fz7cYeFO7+1PDaOYhriqamRkG0sAx8fLZ/R9U0zuVegE2tANSMsy
         pBwk+Wagwh+5Z9owKl6esNIyD8BAMkHnREIxkPjjCtxZIrjz643cHruLPORYTAufSJYE
         cL9dFjHxrBZRI2b9Us8Yo0wzro7aIWWBo3XfeIl2Nr9O1LpMoni3hitD36aY8kBV0i/A
         0c7sbTP4mTa5Khn5JZSExU/HHZTZrQJ9cqvM5bicYteKNMTs21UJ6XxVb6UK0bKWAkGK
         iDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nAjJNcbSrTVyC9xT3GK+BCC2nCovQf7Djw6rij3xpcY=;
        b=ZuDXo2TjNEHB84lWR9QnwpegCXqoLPxSsb/sNQ8nUVh4uY38AtMUdYcyCOWRcc7ziE
         rVMsQEiQ9iFvEL3Jvr8I3V9j8EzfmOOi+ezv4l3cKKByE5/Dt0m8QUbtVTYL3us+M9Zd
         OA3x5FwXIlWuwQlu4FzqQBSFMrgjtkGfZIMqTiKHqfGitOaovZaFI4EJGyrrokplQj6E
         +UsnO/xUiSonL+Bem03QTfCjkzu9cqA/0Y5BejoJRm6dd2zayH1CxUNhJY4NEDic7JLy
         aJ8FXJxb6quOzshQ396tuKsdPT44UCPvP9PgU59q9HXshy8kTjsGJwnSkF2qL5zuP4JL
         FEKA==
X-Gm-Message-State: AOAM531x2yzuB/6kE+7g/Ufu6xLj7pSnLtoPQxQe4h2Qy39paVg5br+v
        K6+jqYKsBYCFy9IS5aaamqz89VjWng2HKQ==
X-Google-Smtp-Source: ABdhPJzJ2d6Iu+sR/OhwWPYcm/MzemxmYk0K+r/k0ipSW6kbqovaeEikkCXVyDONkFAbwjHR29Up7djv3tRhsw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:a05:6214:d4c:: with SMTP id
 12mr32562970qvr.2.1620934576937; Thu, 13 May 2021 12:36:16 -0700 (PDT)
Date:   Thu, 13 May 2021 12:32:02 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-8-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 08/10] kernel/sysctl-test: Remove some casts which are
 no-longer required
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With some of the stricter type checking in KUnit's EXPECT macros
removed, several casts in sysctl-test are no longer required.

Remove the unnecessary casts, making the conditions clearer.

Signed-off-by: David Gow <davidgow@google.com>
---
This should be a no-op functionality wise, and while it depends on the
first couple of patches in this series, it's otherwise independent from
the others. I think this makes the test more readable, but if you
particularly dislike it, I'm happy to drop it.

 kernel/sysctl-test.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index ccb78509f1a8..664ded05dd7a 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -49,7 +49,7 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
 					       KUNIT_PROC_READ, buffer, &len,
 					       &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 
 	/*
 	 * See above.
@@ -58,7 +58,7 @@ static void sysctl_test_api_dointvec_null_tbl_data(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&null_data_table,
 					       KUNIT_PROC_WRITE, buffer, &len,
 					       &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 }
 
 /*
@@ -95,7 +95,7 @@ static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
 					       KUNIT_PROC_READ, buffer, &len,
 					       &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 
 	/*
 	 * See previous comment.
@@ -104,7 +104,7 @@ static void sysctl_test_api_dointvec_table_maxlen_unset(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&data_maxlen_unset_table,
 					       KUNIT_PROC_WRITE, buffer, &len,
 					       &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 }
 
 /*
@@ -135,11 +135,11 @@ static void sysctl_test_api_dointvec_table_len_is_zero(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
 					       &len, &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE, buffer,
 					       &len, &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 }
 
 /*
@@ -174,7 +174,7 @@ static void sysctl_test_api_dointvec_table_read_but_position_set(
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ, buffer,
 					       &len, &pos));
-	KUNIT_EXPECT_EQ(test, (size_t)0, len);
+	KUNIT_EXPECT_EQ(test, 0, len);
 }
 
 /*
@@ -203,7 +203,7 @@ static void sysctl_test_dointvec_read_happy_single_positive(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
 					       user_buffer, &len, &pos));
-	KUNIT_ASSERT_EQ(test, (size_t)3, len);
+	KUNIT_ASSERT_EQ(test, 3, len);
 	buffer[len] = '\0';
 	/* And we read 13 back out. */
 	KUNIT_EXPECT_STREQ(test, "13\n", buffer);
@@ -233,9 +233,9 @@ static void sysctl_test_dointvec_read_happy_single_negative(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_READ,
 					       user_buffer, &len, &pos));
-	KUNIT_ASSERT_EQ(test, (size_t)4, len);
+	KUNIT_ASSERT_EQ(test, 4, len);
 	buffer[len] = '\0';
-	KUNIT_EXPECT_STREQ(test, "-16\n", (char *)buffer);
+	KUNIT_EXPECT_STREQ(test, "-16\n", buffer);
 }
 
 /*
@@ -265,7 +265,7 @@ static void sysctl_test_dointvec_write_happy_single_positive(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
 					       user_buffer, &len, &pos));
 	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
-	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
 	KUNIT_EXPECT_EQ(test, 9, *((int *)table.data));
 }
 
@@ -295,7 +295,7 @@ static void sysctl_test_dointvec_write_happy_single_negative(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, KUNIT_PROC_WRITE,
 					       user_buffer, &len, &pos));
 	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
-	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
+	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
 	KUNIT_EXPECT_EQ(test, -9, *((int *)table.data));
 }
 
-- 
2.31.1.751.gd2f1c929bd-goog

