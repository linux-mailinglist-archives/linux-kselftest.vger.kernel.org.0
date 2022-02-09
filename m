Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836284AE965
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 06:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiBIFiY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 00:38:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbiBIF2V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 00:28:21 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA2EC03324C
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 21:28:25 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s207-20020a6277d8000000b004e0300e14f7so982977pfc.23
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 21:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=36z3XIrw+2wjLy8oTFViegQpDWukcoi9C46U/6NGCkg=;
        b=q8HJ+Nks3S0Qn0OnlSvLpHmRkTK4vcod4NMS/us3rncsxEupbJ2LDkaLJ04V4sKgsx
         4Gs3NNNAd88WMVaGtUvfR24FoGsThPIfkxJV4fO9lwlfRyl8OcycT5kcfZ9DBk4RtMJ4
         fqKkRybLiBmsuV/zGjhmUxrIkNYIdRnB/RTZdZaitzKCrDRPVZntRU9pvD8Kr0HA2AfE
         mD1GfNB1xaugiHhyJiHYlWDjgCQH8j+Bla89yvKfQy0+UXeqDy5lw/2Z0An3iBESC04m
         dpmzpbx6WYykORa7+6HF9N78+sjrdszJ385TqeKY7t+u4HPzi/8FPkWJiV4UEiu6vkLm
         SM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=36z3XIrw+2wjLy8oTFViegQpDWukcoi9C46U/6NGCkg=;
        b=RgyQ9bpzeowm5FFWbFmWOgKLo+nxyQlkQ0TIp9JanSbmnq1goYueq24ttdTOV+CKdT
         CqmJwn1wS8WWyDpBbyostcwWu7tAeH+eip5abycviKNMT6pVen3t4kQ5PCfc8bE8ak++
         c4YMX8Fb+qDAUOQSnlONZ4TtxDSpjQGHVEPYRTW8odsOpZlr9BEN+nQaWLuY8op9szHj
         YO2MNf7vFgJFdBVxNRPIwbkyOMFyoY3ZfoVAZg8bRvJK46aIuL4wDDOOrlo4Hok8bEDh
         AB+ntwAjXqA/Cgp01qwBwQlpkwiuE88wcUltSFdt3snupqsjIM1SUYf/9wMlGAiU1MCx
         zzyw==
X-Gm-Message-State: AOAM531w/2bXp4ViP4vJl6RTawwykKaY1xcqqj+/kFAuW7h6K4kwK4ng
        8sv5DDEYZLSi8McwU9DO9eCzk2f1EeQOig==
X-Google-Smtp-Source: ABdhPJwEgPgaGJ6lZHG3y/lAPWiYglNFr0d4i21HEm2YLa/giqpI4sGooKqWKwbxwW8/GpORGagMe5afVCXDVg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:985:: with SMTP id
 5mr702735pjo.217.1644384505266; Tue, 08 Feb 2022 21:28:25 -0800 (PST)
Date:   Wed,  9 Feb 2022 13:28:12 +0800
In-Reply-To: <20220209052813.854014-1-davidgow@google.com>
Message-Id: <20220209052813.854014-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220209052813.854014-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v3 2/3] list: test: Add a test for list_is_head()
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
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
---

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220208040122.695258-2-davidgow@google.com/
- Use the _MSG variants of the assert macros, as suggested by Daniel
  Latypov.
Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-2-davidgow@google.com/
- Test both non-head elements of the same list and head elements of
  different lists.

---
 lib/list-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index f82a3c7788b8..19f13059439b 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -253,6 +253,24 @@ static void list_test_list_bulk_move_tail(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, i, 2);
 }
 
+static void list_test_list_is_head(struct kunit *test)
+{
+	struct list_head a, b, c;
+
+	/* Two lists: [a] -> b, [c] */
+	INIT_LIST_HEAD(&a);
+	INIT_LIST_HEAD(&c);
+	list_add_tail(&b, &a);
+
+	KUNIT_EXPECT_TRUE_MSG(test, list_is_head(&a, &a),
+		"Head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test, list_is_head(&a, &b),
+		"Non-head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test, list_is_head(&a, &c),
+		"Head element of different list");
+}
+
+
 static void list_test_list_is_first(struct kunit *test)
 {
 	struct list_head a, b;
@@ -730,6 +748,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
+	KUNIT_CASE(list_test_list_is_head),
 	KUNIT_CASE(list_test_list_is_first),
 	KUNIT_CASE(list_test_list_is_last),
 	KUNIT_CASE(list_test_list_empty),
-- 
2.35.0.263.gb82422642f-goog

