Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D881B4AA710
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Feb 2022 07:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352862AbiBEGQ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Feb 2022 01:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351460AbiBEGQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Feb 2022 01:16:26 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616C0C06109E
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Feb 2022 22:16:15 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 68-20020a621547000000b004c74bbd2819so4143782pfv.18
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Feb 2022 22:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gl5quSdllNcUacMKlmR/GX6m0ySmM7gXrjH2h0fLFis=;
        b=k4s/EOHI5SkfQ/d0UUqb8GX2z6Ce6Lhbe9VyYzflbUbVqkEcqKoIT405legl1l1G9H
         0LtiZ9GVVpmNS/bzvqhj36O0+XomRL5lESVXo9g2luEU8fxWuqsYZO0z5l5h0uB3TktM
         4vzjLaKiw/asf0HjqXXSXxm38k9CL7AHnB1ZE15f2KH39fBh9jNLns6IulaaXt/QqpIj
         BlOHRTrGfPG+kR3ZGqZhVnUQ2YRRASX9unJPA+RKruvP7V2Rf4YnC6Zzeq4jHfT9kuiF
         g1jInl0XsUPMOLmiaZpVLGSwaEYZyuzFV/rkdPUpYIAk9KuepjkCgGqyy4IPzjLx298r
         79Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gl5quSdllNcUacMKlmR/GX6m0ySmM7gXrjH2h0fLFis=;
        b=iDCOzFLyFYzBM1+ccFSIXs4v8IjyZPWVnfnK+e+EJrbDE86sL+qAL3U42j/exYeAMW
         pRsJMs+sM1S0BRT9D6fMWIXrUOXLZLvpHfJPzc0VtkZdCTM0Nt649fwc1xSOnZaJiv5u
         gHv6x+6TIYWEiYt84xhKqfAFv6K6eICDOKqmP2zv3GYQJCBaS377O5QgQAxtqW4Cmkms
         bZF6RlSDL09KBXeumKn7gxrgnUPRC31qV4Q2b9b72smrUOOINNPGUuAL/pEqZX3LAwbj
         ZR9tXZFBz/USvJBSI3nksVsv2aN7x7IGemrhvh6QqQviQq7Ygi/7jJW4yg2LNx7iHRht
         QLJg==
X-Gm-Message-State: AOAM533auWfa70H6J9kJ2ho9DdcG8NT8GgsOdvVQgyeRS/oYH5IUs3Yg
        HLxyQTNrSNtD2mRmjcR3wsmKq7N3PwDENg==
X-Google-Smtp-Source: ABdhPJx2m8RdzEoyIpk9k4NiaQjQnuEukVSy4CM20gGV0C+JQh7BvtxJaH7Z1ADicaL/uNmztUFBbprPwjYXZA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a62:8c14:: with SMTP id
 m20mr6528807pfd.6.1644041774840; Fri, 04 Feb 2022 22:16:14 -0800 (PST)
Date:   Sat,  5 Feb 2022 14:15:38 +0800
In-Reply-To: <20220205061539.273330-1-davidgow@google.com>
Message-Id: <20220205061539.273330-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220205061539.273330-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 3/3] list: test: Add a test for list_entry_is_head()
From:   David Gow <davidgow@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The list_entry_is_head() macro was added[1] after the list KUnit tests,
so wasn't tested. Add a new KUnit test to complete the set.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e130816164e244b692921de49771eeb28205152d

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/list-test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 7ce7eaebe060..4cd06a9fc73c 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -538,6 +538,18 @@ static void list_test_list_entry(struct kunit *test)
 				struct list_test_struct, list));
 }
 
+static void list_test_list_entry_is_head(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+	KUNIT_EXPECT_FALSE(test, list_entry_is_head((&test_struct1), &list, list));
+	KUNIT_EXPECT_FALSE(test, list_entry_is_head((&test_struct2), &list, list));
+}
+
 static void list_test_list_first_entry(struct kunit *test)
 {
 	struct list_test_struct test_struct1, test_struct2;
@@ -753,6 +765,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_splice_init),
 	KUNIT_CASE(list_test_list_splice_tail_init),
 	KUNIT_CASE(list_test_list_entry),
+	KUNIT_CASE(list_test_list_entry_is_head),
 	KUNIT_CASE(list_test_list_first_entry),
 	KUNIT_CASE(list_test_list_last_entry),
 	KUNIT_CASE(list_test_list_first_entry_or_null),
-- 
2.35.0.263.gb82422642f-goog

