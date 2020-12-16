Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883332DB7C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 01:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLPAYF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 19:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgLPAX7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 19:23:59 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8075AC061793
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 16:23:19 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id hg11so522883pjb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 16:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=NldisNtyKDZkpWuNU4L0OQjMrO2hlrQAL2PRPxrtX6A=;
        b=J5mnM7lVskfzO/TiL8JO8rOh9edruYozjmmO+VhEnaY/kIBOpmfhI1dkNW4m6V0A4G
         3g/oxJzm5KfCvfRGhSv95kFGzvsZXKgzbQ1PqAjiYa7RAr7nVDqjrReO8OaD6duCUImv
         co4QWcXpV9daHa1Kfl32lySTGL+2kg/ToRmn83aBM6l/+D9Yy9yHRklFq+6ca4Kiqcsq
         hPGDDA5l7TY2JkOSHUHoxiGmfRIiqNW5VLBviv+ScyRVdl6HSmUrfLvXIWadaHJYDxvD
         JCXl6WIUQCsCCOwoEbSM7swZUosuUNPxXjlnKIHTRIX/+TpA7BNrqIeijf9afdJx+RTD
         9IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=NldisNtyKDZkpWuNU4L0OQjMrO2hlrQAL2PRPxrtX6A=;
        b=B6jN1xJ/QR4tYBmtBu4+2cPEUE61Sy5nAJ5/I+SlMsDxaQh9jf6nmggJ65P0jo6SvZ
         2P4nrIuGKmMrrVZzkr5ZBHRxHvK9FYXHFAKxoNfQ8g3CYRQTyLKxFFsk2/8BZlf8K5g1
         NLSsg+ojPF5jciv1tER0inBfbFY3Yf2ueoeNXAGbmq0/EbQRcA/EdA9vP0GNbA9XArLF
         nH547xgNATLi1UMwQ8jLDhsUISzEy/IQzptBDOzCNijcc9a3Jg1+0XCMp14DAlUsYhvY
         UKTK42faKLq6Dxim1m1UPmO2gOSoafBSYjaEmy/peRLM+s43Pf93Tl0jGWNhxOXZsDHw
         kHyw==
X-Gm-Message-State: AOAM532yQdcY4+a7VvEtbFFRYPVjW6aVyhhqwtjZvj1dOrxpA+J+yHau
        zjI/6FjfH3cuq98VEjJSnVh5v/Y6XiqYGQ==
X-Google-Smtp-Source: ABdhPJxXgM45sPXTYHJabH46VueKuzZGwYP1kBcW5DLNGE49xW53pHsLHbDprPXcGIZnh/bOR/mpyY0VCKCL7g==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a62:2cc3:0:b029:197:dda8:476a with SMTP
 id s186-20020a622cc30000b0290197dda8476amr2336689pfs.37.1608078198857; Tue,
 15 Dec 2020 16:23:18 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:22:46 -0800
Message-Id: <20201216002246.3580422-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH] Documentation: kunit: include example of a parameterized test
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com, brendanhiggins@google.com
Cc:     elver@google.com, 98.arpi@gmail.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit fadb08e7c750 ("kunit: Support for Parameterized Testing")
introduced support but lacks documentation for how to use it.

This patch builds on commit 1f0e943df68a ("Documentation: kunit: provide
guidance for testing many inputs") to show a minimal example of the new
feature.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index d9fdc14f0677..650f99590df5 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -522,6 +522,63 @@ There's more boilerplate involved, but it can:
   * E.g. if we wanted to also test ``sha256sum``, we could add a ``sha256``
     field and reuse ``cases``.
 
+* be converted to a "parameterized test", see below.
+
+Parameterized Testing
+~~~~~~~~~~~~~~~~~~~~~
+
+The table-driven testing pattern is common enough that KUnit has special
+support for it.
+
+Reusing the same ``cases`` array from above, we can write the test as a
+"parameterized test" with the following.
+
+.. code-block:: c
+
+	// This is copy-pasted from above.
+	struct sha1_test_case {
+		const char *str;
+		const char *sha1;
+	};
+	struct sha1_test_case cases[] = {
+		{
+			.str = "hello world",
+			.sha1 = "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed",
+		},
+		{
+			.str = "hello world!",
+			.sha1 = "430ce34d020724ed75a196dfc2ad67c77772d169",
+		},
+	};
+
+	// Need a helper function to generate a name for each test case.
+	static void case_to_desc(const struct sha1_test_case *t, char *desc)
+	{
+		strcpy(desc, t->str);
+	}
+	// Creates `sha1_gen_params()` to iterate over `cases`.
+	KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
+
+	// Looks no different from a normal test.
+	static void sha1_test(struct kunit *test)
+	{
+		// This function can just contain the body of the for-loop.
+		// The former `cases[i]` is accessible under test->param_value.
+		char out[40];
+		struct sha1_test_case *test_param = (struct sha1_test_case *)(test->param_value);
+
+		sha1sum(test_param->str, out);
+		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, test_param->sha1,
+				      "sha1sum(%s)", test_param->str);
+	}
+
+	// Instead of KUNIT_CASE, we use KUNIT_CASE_PARAM and pass in the
+	// function declared by KUNIT_ARRAY_PARAM.
+	static struct kunit_case sha1_test_cases[] = {
+		KUNIT_CASE_PARAM(sha1_test, sha1_gen_params),
+		{}
+	};
+
 .. _kunit-on-non-uml:
 
 KUnit on non-UML architectures

base-commit: 5f6b99d0287de2c2d0b5e7abcb0092d553ad804a
-- 
2.29.2.684.gfbc64c5ab5-goog

