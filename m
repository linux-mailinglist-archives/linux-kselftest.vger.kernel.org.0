Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF74AE964
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 06:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiBIFiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 00:38:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiBIF21 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 00:28:27 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B6EC03544D
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 21:28:30 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id a9-20020a170902710900b0014c8132e8b8so1019239pll.10
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 21:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HnCcKGZHmANVeTKSqjJ8fr7e3oS/Q8scdOC+KonXnFM=;
        b=p7SepyAYaSxapPXJoJyxkPrvHpAKiJ50CdTEXTRhsjMOCggG/qbZWXbSYEcjHJwJSm
         NUpKEP8rmA34ubXBsZEdkxYguJ0pceqIUmM/vZb9BBc9+5JlxoRQIIR88CWE0LlDKvbk
         9BtotfJ3dIAoquSf3xA1fK2vjDn1QL+oQzojovHEnMF7253yQFApGMi8C5lfCfG2Z/xc
         GeQunm2jEmxrQon1vvh5Cft+AuEi+ydkyYErWk01UqwyGDbe6wX7uosqcjS5oavD5cAi
         PtBFXfH8pjn0xzwkQdUZZQ8OLuKaSPCRTsoVRqU970ssWPCqucVE7DTER984auzhxcNn
         obYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HnCcKGZHmANVeTKSqjJ8fr7e3oS/Q8scdOC+KonXnFM=;
        b=3wI0qtj+JLPNHqk9FGXUa3jWVGx5l/w3nPW7kgpjVV4z/iSEU/HqnIeR7sptGBhl/K
         pmOfVca1H6rrhjDtsuf1xflDMnG5bzzY4Z2fmSWuMvgvqm9PvA1rVWOzu/fMpydsHEvZ
         Uy0B/jBVIBtSgM2tKRTEDSHOwJZShhIXE8Ei8ItlaDIoDPiU3DJNiQj9P2TsWDPhcYaJ
         p+U5dB0Q+Oh01sBV2wbrd0I5hqzBEx3qaEqMlWM6Cz96fihaSy10MeTyNY0i34zi07zd
         CjneLa5dQcFL7JhjwM1IlZhSXTXOVCYGnI2gZwDTSOd7jmu/drObk1vLq7xI77VjPqEG
         TtlQ==
X-Gm-Message-State: AOAM533LTJB0bAIxVcMab/h7aIhOCd6joGmeqVzqJRzPj0UIufZ0Lgyu
        Dz1gBC+dG9btb7HJ5GlSaRmgbXTppPYoXw==
X-Google-Smtp-Source: ABdhPJzECr248U9TepR8lY3SYNo34GWVugZSFlCvDHeAmMP8L+MucgM9IaNdruspg2yOuPa6IUhaWa5JLvzXhA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:5d01:: with SMTP id
 s1mr739055pji.154.1644384509868; Tue, 08 Feb 2022 21:28:29 -0800 (PST)
Date:   Wed,  9 Feb 2022 13:28:13 +0800
In-Reply-To: <20220209052813.854014-1-davidgow@google.com>
Message-Id: <20220209052813.854014-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220209052813.854014-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v3 3/3] list: test: Add a test for list_entry_is_head()
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
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
---

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220208040122.695258-3-davidgow@google.com/
- Use the _MSG variants of the assert macros, as suggested by Daniel
  Latypov.
Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-3-davidgow@google.com/
- Rework the test entirely to better match the improved list_is_head()
  test.

---
 lib/list-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 19f13059439b..869caae14b10 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -548,6 +548,26 @@ static void list_test_list_entry(struct kunit *test)
 				struct list_test_struct, list));
 }
 
+static void list_test_list_entry_is_head(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2, test_struct3;
+
+	INIT_LIST_HEAD(&test_struct1.list);
+	INIT_LIST_HEAD(&test_struct3.list);
+
+	list_add_tail(&test_struct2.list, &test_struct1.list);
+
+	KUNIT_EXPECT_TRUE_MSG(test,
+		list_entry_is_head((&test_struct1), &test_struct1.list, list),
+		"Head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test,
+		list_entry_is_head((&test_struct2), &test_struct1.list, list),
+		"Non-head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test,
+		list_entry_is_head((&test_struct3), &test_struct1.list, list),
+		"Head element of different list");
+}
+
 static void list_test_list_first_entry(struct kunit *test)
 {
 	struct list_test_struct test_struct1, test_struct2;
@@ -763,6 +783,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_splice_init),
 	KUNIT_CASE(list_test_list_splice_tail_init),
 	KUNIT_CASE(list_test_list_entry),
+	KUNIT_CASE(list_test_list_entry_is_head),
 	KUNIT_CASE(list_test_list_first_entry),
 	KUNIT_CASE(list_test_list_last_entry),
 	KUNIT_CASE(list_test_list_first_entry_or_null),
-- 
2.35.0.263.gb82422642f-goog

