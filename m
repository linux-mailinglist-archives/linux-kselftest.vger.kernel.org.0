Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A5637FE30
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 21:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhEMThS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEMThS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 15:37:18 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B3C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:07 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id b24-20020a0cb3d80000b02901e78b82d74aso12041417qvf.20
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BiTwevY2BijktUFqvfOK9eJ6VmJRYnptZuS8mDsZYKo=;
        b=LasTf1nY4+b5yUEfOYSE5Kj0qvBWH1MILz6JaDyx+q45/xfqv50Ku6rV8lP2Cci/mt
         5xCaADseUt1Sv6TJOa1pyB0U4fZyJUjItpSzpEhJJY/pKRwPYHLQkPypJnUrOxBwkxjl
         oMHIWw/ZZRw2KyiOs8R/h/D7wgbtc3dM5zuMVg5hDI7XnHCj0dwLXzPoMNfiCswGfqJS
         7R4qEYcoDvgvAcL9yBNg76nYlyZ9k46xRtr0LrHyyqcBm78F4mgFRg0XX1j0PHnPoahV
         be6PMEuT48BtaRvQzuTFVtqRdjPP37Idayy4h/C5p+j/YR74fYwG5Yx4jOWDqbsQfaxL
         jRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BiTwevY2BijktUFqvfOK9eJ6VmJRYnptZuS8mDsZYKo=;
        b=jnSrJBwCcAu/BFZSkHaBVGKrt7LRtRJxU5ZfVe9dmfCrlSoic+oJGD/9EgHDjTVrLN
         ZYnMH3u/SEHuYNSinuheQEs7CXZlQB5RpuZFyr0XONRyghcLl181ZjGNn3rsgu+Zenhp
         Ed3Z8kaZVtC27W56OTiBEA5gfTq934rZRWB07yez9czuBnxqIwVZJzjjRCSPsU62bkL3
         aASpuxjdnYOfrERaVQMDt/pEJZfPqhFHpflCNVyJ9kZEw6LdSwzV0BrJpE5bBN/ezdmN
         Tf/MfohinKEoNHBfxVs+X7KduL3/W7YGcumEe1b4OwgExbiISjMEJzyZwHq7fr7T/5Wp
         12aA==
X-Gm-Message-State: AOAM533bOJZ7W6YbGXrBfuwVxWnZJhuE467icB64kBG87uw6IHvU6DlV
        alxiUzqbjshMIumekue7Qh9sV5QvfB01LQ==
X-Google-Smtp-Source: ABdhPJyR64VzZ5dzEuRrPPWp50TK6bKpzKa8OAJQymtp2HWAudczxHJpzY45ad+idq1r8zu7myy7Tbr1YTO3bw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:5f61:8ca4:879b:809e])
 (user=davidgow job=sendgmr) by 2002:ad4:5ae6:: with SMTP id
 c6mr3662248qvh.42.1620934567050; Thu, 13 May 2021 12:36:07 -0700 (PDT)
Date:   Thu, 13 May 2021 12:31:57 -0700
In-Reply-To: <20210513193204.816681-1-davidgow@google.com>
Message-Id: <20210513193204.816681-3-davidgow@google.com>
Mime-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 03/10] Documentation: kunit: Clean up some string casts in examples
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the type checking is no longer excessively strict, get rid of the
unsightly (char*) casts -- and comment discussing them -- from the KUnit
usage page.

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 650f99590df5..756747417a19 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -465,10 +465,9 @@ fictitious example for ``sha1sum(1)``
 
 .. code-block:: c
 
-	/* Note: the cast is to satisfy overly strict type-checking. */
 	#define TEST_SHA1(in, want) \
 		sha1sum(in, out); \
-		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, want, "sha1sum(%s)", in);
+		KUNIT_EXPECT_STREQ_MSG(test, out, want, "sha1sum(%s)", in);
 
 	char out[40];
 	TEST_SHA1("hello world",  "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed");
@@ -507,7 +506,7 @@ In some cases, it can be helpful to write a *table-driven test* instead, e.g.
 	};
 	for (i = 0; i < ARRAY_SIZE(cases); ++i) {
 		sha1sum(cases[i].str, out);
-		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, cases[i].sha1,
+		KUNIT_EXPECT_STREQ_MSG(test, out, cases[i].sha1,
 		                      "sha1sum(%s)", cases[i].str);
 	}
 
@@ -568,7 +567,7 @@ Reusing the same ``cases`` array from above, we can write the test as a
 		struct sha1_test_case *test_param = (struct sha1_test_case *)(test->param_value);
 
 		sha1sum(test_param->str, out);
-		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, test_param->sha1,
+		KUNIT_EXPECT_STREQ_MSG(test, out, test_param->sha1,
 				      "sha1sum(%s)", test_param->str);
 	}
 
-- 
2.31.1.751.gd2f1c929bd-goog

