Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84C43BF17
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 03:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbhJ0Bjj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 21:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbhJ0Bjj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 21:39:39 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E8C061745
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:37:14 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id p28-20020a637f5c000000b002a3c58b5917so659101pgn.23
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zdnP+CcH+cj0gO5XtMfjV6pCIZrG8LN0fjsgBOUCOoc=;
        b=b92pU0ZPZUKilkgCeq0jDth2ifnAa83QiCk+5MfUApUiPVy9/uv1rEJVPOPooi3Ye3
         YfCUuvbWmOHiEC2kiFUgckBwDx8ENqtu1wYm9f8ZZzOF6ZWP2R2VWrtb4/OJA5Qh7kHC
         ockwapbrUmbsiLTmpcJfHXvND0KHLx3uk/mBv9dAkylFjmtjylw30n9ZsqovaSunDOyL
         CC79OcNdjexhtkkPeny6kbLhIxQVyLc1U66yYRui05WVAQJLHWN1ZjSZhaqkKwCfncbx
         al3w5JaVx8c3mYiPY1ySJmX5e6/pHOd69OcroHkmgDbIdSi9ygOfZOtNrWZjNHMBtRxR
         fsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zdnP+CcH+cj0gO5XtMfjV6pCIZrG8LN0fjsgBOUCOoc=;
        b=Ay6y6/Ix+SPPuM2aZ1tNK2KUC6YB5Lgf8v/Hp3HmqEz+9DReLSNJv+uWnX1AFN7M55
         mzuXf6BKmsroMwCAOeIm/e93xejWiBAhUKQgxSKeh6pjjuEMgzqFFaqKkzZt+y03EArD
         6pneSh853Tcj4cHIuuNRBbxfGQTlY/Texxtv5WCbxa1WHIYXGqxo1xskUFN0WWo9EoGA
         0Kp6zNEJRa7h80xVIzbKYkXQihBl1APDt58P2i3755romvn4/Bs1tBnku4rvMOTMq+yl
         riu7F9Z8kQo2MMynGKtd5iYpTPJ55lTBqyqzIL13aRitK44q2fas2CsjaGy4LR/Q/kLS
         Ftkg==
X-Gm-Message-State: AOAM53281zyNkoUBnn7p8+1cEQKbM0w51hM3V0JlEerfpomn6OnTA+83
        RXsh/ONKQ32WKAcBmA18kKEZTzMIwWI9zQ==
X-Google-Smtp-Source: ABdhPJwg2vr2nzlms3KujpRdCOHHVuWmWK5Bzr5xe8wdyiH+1BuM42b6Pjw14dOKIyYClEOzMDsPm2olcO1xAQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:c628:e925:d58d:6232])
 (user=davidgow job=sendgmr) by 2002:a17:902:ed87:b0:141:5fe1:e794 with SMTP
 id e7-20020a170902ed8700b001415fe1e794mr4334276plj.77.1635298634290; Tue, 26
 Oct 2021 18:37:14 -0700 (PDT)
Date:   Tue, 26 Oct 2021 18:37:01 -0700
In-Reply-To: <20211027013702.2039566-1-davidgow@google.com>
Message-Id: <20211027013702.2039566-3-davidgow@google.com>
Mime-Version: 1.0
References: <20211027013702.2039566-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 3/4] kunit: Don't crash if no parameters are generated
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

It's possible that a parameterised test could end up with zero
parameters. At the moment, the test function will nevertheless be called
with NULL as the parameter. Instead, don't try to run the test code, and
just mark the test as SKIPped.

Reported-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bd741e50a2d..e028d98e4f5b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -500,7 +500,10 @@ int kunit_run_tests(struct kunit_suite *suite)
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-		struct kunit test = { .param_value = NULL, .param_index = 0 };
+		/* The initial param value is nonzero, as we want
+		 * non-parametrised tests to run once.
+		 */
+		struct kunit test = { .param_value = (void *)-1, .param_index = 0 };
 		struct kunit_result_stats param_stats = { 0 };
 		test_case->status = KUNIT_SKIPPED;
 
@@ -510,7 +513,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			test.param_value = test_case->generate_params(NULL, param_desc);
 		}
 
-		do {
+		while (test.param_value) {
 			kunit_run_case_catch_errors(suite, test_case, &test);
 
 			if (test_case->generate_params) {
@@ -530,11 +533,12 @@ int kunit_run_tests(struct kunit_suite *suite)
 				param_desc[0] = '\0';
 				test.param_value = test_case->generate_params(test.param_value, param_desc);
 				test.param_index++;
-			}
+			} else
+				test.param_value = NULL;
 
 			kunit_update_stats(&param_stats, test.status);
 
-		} while (test.param_value);
+		}
 
 		kunit_print_test_stats(&test, param_stats);
 
-- 
2.33.0.1079.g6e70778dc9-goog

