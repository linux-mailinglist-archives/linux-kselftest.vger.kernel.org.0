Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE0643BF19
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 03:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhJ0Bjn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 21:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbhJ0Bjl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 21:39:41 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01D1C061745
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:37:16 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d14-20020a17090a2a4e00b001a2955e1247so296328pjg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7J7hXEZYHRVzHQmivzMp4k5hS/Z1urfbfNYVR0nOOIk=;
        b=W+jH/TV8ffRFIZYHg3pvL/VMZ8Z391aQ0OipQqW6+SKlDH1rDYEmqGeIV0T6IKGJMh
         pZNgdbdBThDYpPNomeKbMXwnyP4fjZ90r/hKw2bcZOEyVedQvLydxUw6Ou3onVTmL2uS
         1YXM8ythHyylYJjWnRVLGJY0cLDw7Rzjv/3TigU/N7zYZz4L4RjAiynaEgR9p5QOJBJ2
         wyM3RYH0blVpXuiXWstvYW6zuYt4gYjGDcTIwAoXYoZksETyoA1Kx4kEjn79QOa2pr2n
         gJHKcic4NA6xtarDLxUQYRuDrrKjWIQYCBh0vQlLCM0dcqMx5FHuilQkX6RcEDkX+cX1
         k9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7J7hXEZYHRVzHQmivzMp4k5hS/Z1urfbfNYVR0nOOIk=;
        b=YV9gJ7f3FbqbIUR/2IkO3kvL1p8V3wEh1wQ/gsutO7tke+NL2is/6HjJTYx/nuG10s
         5l3epJ/1W7nTmHLhdtPaOVWCplCoohT9Syg6ke0M2HDuC3Tiz9Kq1Q6QwVn6LNjDVGVd
         Ioexd0JbOFwCGnWVC8qxlIIPzLvrgkDfHHG4LxSW448e2GIS4TTlF7cvahTHCGHRZgBi
         ndR8tIzHTdP6PeZXtThPxHJhXh0JhAYrD+KBAfGmX4Te/tDJLYeci5vcium6BQngnfLf
         +Hi0lTP8aIIP1K99hjLo2gwaqetVFPora2h3O+lVdqCvyl2Xm8iDY20VE5lX8DXuh3Ur
         AKZA==
X-Gm-Message-State: AOAM533StQej6jbSYZTdUvoRALIhRQ1sqZLsRbPF6TiPkmscWnwjN52I
        FzXUR68EKPXKpGCHaX7KcV2tw+Adr8PgGQ==
X-Google-Smtp-Source: ABdhPJxxHWq6OxvqmxnsH7pPvAGClrg/VRxmiCxws1pwjgP5B9Z2euyjsEbMnndi3o7+1pA7Zv9bpwNxTx/bMg==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:c628:e925:d58d:6232])
 (user=davidgow job=sendgmr) by 2002:a17:90b:149:: with SMTP id
 em9mr2506857pjb.133.1635298636276; Tue, 26 Oct 2021 18:37:16 -0700 (PDT)
Date:   Tue, 26 Oct 2021 18:37:02 -0700
In-Reply-To: <20211027013702.2039566-1-davidgow@google.com>
Message-Id: <20211027013702.2039566-4-davidgow@google.com>
Mime-Version: 1.0
References: <20211027013702.2039566-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 4/4] kunit: Report test parameter results as (K)TAP subtests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, the results for individial parameters in a parameterised test
are simply output as (K)TAP diagnostic lines.

As kunit_tool now supports nested subtests, report each parameter as its
own subtest.

For example, here's what the output now looks like:
	# Subtest: inode_test_xtimestamp_decoding
	ok 1 - 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
	ok 2 - 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
	ok 3 - 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
	ok 4 - 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
	ok 5 - 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
	ok 6 - 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
	ok 7 - 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
	ok 8 - 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
	ok 9 - 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
	ok 10 - 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
	ok 11 - 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
	ok 12 - 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
	ok 13 - 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
	ok 14 - 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
	ok 15 - 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
	ok 16 - 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
	# inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
	ok 1 - inode_test_xtimestamp_decoding

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e028d98e4f5b..fe2ab31b5949 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -511,6 +511,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			test.param_value = test_case->generate_params(NULL, param_desc);
+			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+				  "# Subtest: %s", test_case->name);
 		}
 
 		while (test.param_value) {
@@ -523,9 +525,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 				}
 
 				kunit_log(KERN_INFO, &test,
-					  KUNIT_SUBTEST_INDENT
-					  "# %s: %s %d - %s",
-					  test_case->name,
+					  KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+					  "%s %d - %s",
 					  kunit_status_to_ok_not_ok(test.status),
 					  test.param_index + 1, param_desc);
 
-- 
2.33.0.1079.g6e70778dc9-goog

