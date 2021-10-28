Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC2E43DB63
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhJ1Gor (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhJ1Gon (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 02:44:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC1BC061243
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 23:42:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i128-20020a252286000000b005beea522aa8so7427988ybi.17
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hV9Sk/D49Ms8sZBEaKHLIRXSQA10JjJL17+Cu699KU8=;
        b=VzPnKjwyZnii6XyqrJXnRqvZZ+Vw9DMaHfRItQUYZGQirIk5U2yaND42YceIqOA/Vc
         MHIeB2Z/5Cps7SEm7Pu+Ps+OqrmCwqT1UjZDsGT78lwHTTBLl+B0JcybpQpim1WW3FwV
         wMcWKt9e4NRzVYJUeUy/jW4dRZPHS+4XFSBfzRTKVm616visszdj7a34znifgi7EHJ63
         kqkfSZhOgsr/plDGGtZyLav/LWgo4IRdMs2JstKcBuPbSy0EWBqJfDorTLVMhSsn/Gq5
         PV4CECbtC6V9Q4LSs62a9gmz96hJqE5Nbk/7FQ/d073cebPUZwcqraq4wQw2LZld34sI
         rcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hV9Sk/D49Ms8sZBEaKHLIRXSQA10JjJL17+Cu699KU8=;
        b=gvC2fSFMDX5xEhnQoDDvIFxDeGZm8nkh+SRuqXNa0cM1EIALfEe9NBm05MSsOms7zU
         ooq5Funfq4XBK8UffQb662DQxQ+/FwwLuim8yNqeU9zuALy5hYQJsuhiarepqgNmfh8c
         MtbsYt374+eAB+Il/PcN1FxVebM+wr3ydh5y7Mp81zNqUOtf/R3ZsigtbnkgLiP0JxG/
         NlbW87AU/VBPsfy33vU8KqTycyYMFn4r8ctYGMKofDXQpzkKyXHPooi+9GuZi08drsoX
         ZPHfKz3JvGe0882scD+vU74LcWTkUDfu+AlIYX07JVHkfhBPCbDkSEkgjyNAopTAlzUa
         8P2Q==
X-Gm-Message-State: AOAM5316k1dwzdoKbLO5Qxgr0ix68KV0UWVUQD0aL82YNasuQMgwCVp+
        PZrc6lUR+fe1UkGbU9t8d2KgSow4BFhjdA==
X-Google-Smtp-Source: ABdhPJwpSgHdj764HU4HJxQ7lTzJR44lBgZlhMUCD+qfXVIbMRqNsQkGsADTHk+snIOmeORQwPsvU6TYgfH7Qw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:d8b1:a4bf:2b6f:92f9])
 (user=davidgow job=sendgmr) by 2002:a25:b45:: with SMTP id
 66mr2436928ybl.176.1635403333441; Wed, 27 Oct 2021 23:42:13 -0700 (PDT)
Date:   Wed, 27 Oct 2021 23:41:54 -0700
In-Reply-To: <20211028064154.2301049-1-davidgow@google.com>
Message-Id: <20211028064154.2301049-4-davidgow@google.com>
Mime-Version: 1.0
References: <20211028064154.2301049-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 4/4] kunit: Report test parameter results as (K)TAP subtests
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

Changes since v2:
https://lore.kernel.org/linux-kselftest/20211027013702.2039566-4-davidgow@google.com/
- No changes to this patch.


 lib/kunit/test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index dfe1127aacfd..c66fe1735054 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -520,9 +520,8 @@ int kunit_run_tests(struct kunit_suite *suite)
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

