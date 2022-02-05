Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4924AA712
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Feb 2022 07:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351751AbiBEGQ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Feb 2022 01:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351914AbiBEGQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Feb 2022 01:16:26 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C54FC061348
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Feb 2022 22:16:11 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id u24-20020a656718000000b0035e911d79edso3884861pgf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Feb 2022 22:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tmuYmC0m8mvbfJAxQIBdx9zkbWIC9B6I2Z9WuJhYmSE=;
        b=ITilSpV3LDAPKoHX4WCaVmDBD0RUDgc9gX30+niTgT6rdP6U6Hfi7J9r5kWQDJgSSx
         rTlShTgwa8Vr/bzieViJX5pXG4hD/ZFg/vJNbLwsF/EPHo1tIpdTh3Utl72TIH6I7ZXl
         KYFxYXoMdfMtCetm5wReVbMZbcDu+3Mk2YGA3qpA5CX2jB6rN08eNuiWuwZk/D8qTNmd
         y4N8cn9NZFJnuOrmleShnpS0ULwYOPlAB/jEduI96iqwGLm/bXA5aSUPRAMJK6ReJTZJ
         ldgW6OSsT64DcpUjZpyzgqenczLys15ImiJGE1MPitfk085VVEBfg1CblwY9ziPIY8ww
         5BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tmuYmC0m8mvbfJAxQIBdx9zkbWIC9B6I2Z9WuJhYmSE=;
        b=WLNEwzXIcrL7mzwz0be+0ir/SifhqENJSKJa5phJGnLWGj11HJsklE/Kb/Cq3Bf53f
         5CNMPlF2eB7jHbCZpuPThyutBhwVyY42lLCfMCDtTDZomnx8IRcR7OK4W8aGrQywCjAA
         Z8T4bS+So2ImUyuNGI4JFO2ObOzcIsw5Ry53Cy7VgViijLq1NLja5eb8ZQYJkbPTpJ7s
         6kWC9bRbXFBygl4W08+iG6vD7t9uDzinuYbNyRsfiEnQUBqxHdSJbKui1MuTO/ujhJKl
         rEx3+iHx8ttudL8IFFwOmgNolBwQTSvJEt8UgyRCb9hgFeGgQQ+5aouWTO0BzzqlYQLX
         oWHw==
X-Gm-Message-State: AOAM532PPLLmqyPMvptdMEvVy21wvwANMrHm5UvAhPnfyPPkcEveNNHb
        HaBM7shyKHDDDWIiQajj372hWSZZbHHuSA==
X-Google-Smtp-Source: ABdhPJyBaPKfYTmrgkAQA/OZ1IQkSPEDinSUL3sEOCbMICLR3KqVHBu0JlUWx3tgTkdOfuy12G6K7r+jCwP/NQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:70ca:: with SMTP id
 l10mr6667232plt.174.1644041770536; Fri, 04 Feb 2022 22:16:10 -0800 (PST)
Date:   Sat,  5 Feb 2022 14:15:37 +0800
In-Reply-To: <20220205061539.273330-1-davidgow@google.com>
Message-Id: <20220205061539.273330-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220205061539.273330-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 2/3] list: test: Add a test for list_is_head()
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

list_is_head() was added recently[1], and didn't have a KUnit test. The
implementation is trivial, so it's not a particularly exciting test, but
it'd be nice to get back to full coverage of the list functions.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/list.h?id=0425473037db40d9e322631f2d4dc6ef51f97e88

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/list-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 976e9ae1f3c5..7ce7eaebe060 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -252,6 +252,15 @@ static void list_test_list_bulk_move_tail(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, i, 2);
 }
 
+static void list_test_list_is_head(struct kunit *test)
+{
+	struct list_head a, b;
+
+	KUNIT_EXPECT_TRUE(test, list_is_head(&a, &a));
+	KUNIT_EXPECT_FALSE(test, list_is_head(&a, &b));
+}
+
+
 static void list_test_list_is_first(struct kunit *test)
 {
 	struct list_head a, b;
@@ -729,6 +738,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
+	KUNIT_CASE(list_test_list_is_head),
 	KUNIT_CASE(list_test_list_is_first),
 	KUNIT_CASE(list_test_list_is_last),
 	KUNIT_CASE(list_test_list_empty),
-- 
2.35.0.263.gb82422642f-goog

