Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE36FD641
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 07:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbjEJFiw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 May 2023 01:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjEJFit (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 May 2023 01:38:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152182D4C
        for <linux-kselftest@vger.kernel.org>; Tue,  9 May 2023 22:38:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a776a5eb2so15399865276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 May 2023 22:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683697127; x=1686289127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tbe7DEKzQKrcYiGl9gwDjN/HIv29nyKqeYl67bnl2t4=;
        b=Batqp3PBLuZq0MPoOLnpmGf8eMXnRJVw+ue5JhqhX/o6ZwSSRmvX46Z18pKW1fSnVT
         XQht0bAdfLIFZw8Hx4Fuun2NsahncYeYTqhpD682BVs2fhfoWEX3gHn2urK3BQ6UtqTq
         4TGJ6cEVC4M4lRN7j8OJeMGaeQzXedvUkKxBxeyzM2ToJEnITg1mfP+jaFpPq7RnuVqo
         D54HXfiPXWQPqJEOcwOOTyTPq+zBacAXSP6Xa1H5hvzht/x1gfNG81/OEx3iDgHVwElE
         rOCw0Y6I/kDp7CeZc0pOcoeFTPA3MajrXOl04uOeVvkOC2bjcLO7gSpks1eJbCm23ebo
         nHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697127; x=1686289127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tbe7DEKzQKrcYiGl9gwDjN/HIv29nyKqeYl67bnl2t4=;
        b=k6eIEMeVazuiVU6ZpSeBrWvexGQAtwof1hlv9/lMPQsbbgkQnpcRm+dYVkLxqJu+cn
         OGpP1wWVPI9OjqfpV2gFJ/gq8PZ+btb+OtzQSlgysmyJoCNCOzoEpabPmZtP47SBYTJL
         uroYZgFP7NSG+BD7H9HCdVgKUbHM2qqgqdxBzlm+lmnR/cQGBQbeB7O5ELoucH4cY4Ev
         IcnDYeUmgNdAz3EiN90bB1xw+gAk0xACY/BNwPNenmCVisYqi9a5xG56xyoTSGuBKouu
         /dCHmZqc1Hp+3AwU8aeqZOU193E0Mv7P3hyKH0GrGqXbRO9AxYLa7RuKbx9eJzSCGrmS
         727Q==
X-Gm-Message-State: AC+VfDwGZ6xoj47QPKKeu/bxcliEEQPOS9/Nxo0C+aZqDHMqbcSx2pjH
        Clggfz+/a4j7cuFNjj/0dSYOpmXBo7T9Mw==
X-Google-Smtp-Source: ACHHUZ4pNuWHJlqRy36nSA4eoVUW4Wj/ws86Z3o7XvuctcNiiBD8+Xw3sqaiKFRGnD56tbXBoApPrswps0casw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d8cd:0:b0:b9a:703d:e650 with SMTP id
 p196-20020a25d8cd000000b00b9a703de650mr7478834ybg.7.1683697127356; Tue, 09
 May 2023 22:38:47 -0700 (PDT)
Date:   Wed, 10 May 2023 13:38:31 +0800
In-Reply-To: <20230510053832.438529-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230510053832.438529-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510053832.438529-3-davidgow@google.com>
Subject: [PATCH v4 3/4] Documentation: kunit: Warn that exit functions run
 even if init fails
From:   David Gow <davidgow@google.com>
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit's exit functions will run even if the corresponding init function
fails. It's easy, when writing an exit function, to assume the init
function succeeded, and (for example) access uninitialised memory or
dereference NULL pointers.

Note that this case exists and should be handled in the documentation.

Suggested-by: Benjamin Berg <benjamin@sipsolutions.net>
Link: https://lore.kernel.org/linux-kselftest/a39af0400abedb2e9b31d84c37551cecc3eed0e1.camel@sipsolutions.net/
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20230421040218.2156548-3-davidgow@google.com/
- Fix a spelling error (thanks, Sadiya)
- Add Reviewed-by tag.

No changes since v2:
https://lore.kernel.org/linux-kselftest/20230419085426.1671703-3-davidgow@google.com/

This patch was introduced in v2.

---
 Documentation/dev-tools/kunit/usage.rst | 12 ++++++++++--
 include/kunit/test.h                    |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 9f720f1317d3..46957d1cbcbb 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -166,7 +166,12 @@ many similar tests. In order to reduce duplication in these closely related
 tests, most unit testing frameworks (including KUnit) provide the concept of a
 *test suite*. A test suite is a collection of test cases for a unit of code
 with optional setup and teardown functions that run before/after the whole
-suite and/or every test case. For example:
+suite and/or every test case.
+
+.. note::
+   A test case will only run if it is associated with a test suite.
+
+For example:
 
 .. code-block:: c
 
@@ -196,7 +201,10 @@ after everything else. ``kunit_test_suite(example_test_suite)`` registers the
 test suite with the KUnit test framework.
 
 .. note::
-   A test case will only run if it is associated with a test suite.
+   The ``exit`` and ``suite_exit`` functions will run even if ``init`` or
+   ``suite_init`` fail. Make sure that they can handle any inconsistent
+   state which may result from ``init`` or ``suite_init`` encountering errors
+   or exiting early.
 
 ``kunit_test_suite(...)`` is a macro which tells the linker to put the
 specified test suite in a special linker section so that it can be run by KUnit
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 57b309c6ca27..3028a1a3fcad 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -168,6 +168,9 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * test case, similar to the notion of a *test fixture* or a *test class*
  * in other unit testing frameworks like JUnit or Googletest.
  *
+ * Note that @exit and @suite_exit will run even if @init or @suite_init
+ * fail: make sure they can handle any inconsistent state which may result.
+ *
  * Every &struct kunit_case must be associated with a kunit_suite for KUnit
  * to run it.
  */
-- 
2.40.1.521.gf1e218fcd8-goog

