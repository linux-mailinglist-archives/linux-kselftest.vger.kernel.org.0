Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017303E5C7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Aug 2021 16:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhHJOFb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 10:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhHJOFa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 10:05:30 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1CC0613D3;
        Tue, 10 Aug 2021 07:05:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t66so22463310qkb.0;
        Tue, 10 Aug 2021 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=69ttibL9r/y/UWLlZYU/dvsb3ho1ANknfZxnaYGPTwI=;
        b=CJZ46BLJKnKEPx3cNCoHnWylR/I1OCHvD++LG8z/DMex1/4d+1A5f1CfvcHPy2wK4r
         R622cmamRDdsO4mGcnQoNAj9Q0LMoMZfgFxZZaWxzI/W90bILN3Y9VVSN4aZx50f4vWg
         5aPb1+qHnWx3hCLc4aGngBdN2u8kB/dX1ptZrmDYlTmH6y2nMRePBNv/oG5kq3YU/PNB
         OfCpTN0Peu5eTutsHPnRi7T7lXqc8B1db5CszlRIJB5VBPmMnGGDdvZqGjaX4bDfe8qB
         uNKcbOaIlqJy6uUpO0JtHlAjfbURLu40soWgZAo0Mse2SbdGMGBTUggjnj4CQ6CsmxW7
         54Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=69ttibL9r/y/UWLlZYU/dvsb3ho1ANknfZxnaYGPTwI=;
        b=LjINQinXnIAmaMi9CfV3lztg7jkj3Abm9+wOrxxyJSAXlsB4YmhAwIj+d5T78ctqd3
         HpohW1g9cytu7eyBgLevLx7qh5CBnCgW6lxiq/Ao3XKNByaK2P4mg6NcNu9BPO5uM38g
         nlxhxAPXRqApnZHbJBl2Kr/Ig76NvFm/bwk6394iK0migm4fW5gsI0wD1/GQoIgqTBSC
         m2/hu5ta3rQ+o9T7XYFTd9pEpErbsWKIlbR20K5/I7bP7Xl0gHbihPNxhp6LYKhsuj5e
         x251BkpP/lWW3bh6SNc+lRW6wjZUqMbqhFgPNEbfdOGVFkzLDQ3BRk6CcDyXSemapGCJ
         yz5g==
X-Gm-Message-State: AOAM531NioVVMwF6mNWD5MbfiR9AG5y+P4m2Ys5NqUoMlhack3eByWFO
        5QiGEs72uiN+faxCMCqiBgA=
X-Google-Smtp-Source: ABdhPJyLfXRzzkVHFRBzfNXlHKPiNcE1TAgx4z07mJFqt2Z9gYK7jqeeTX2fpWAe5zueSTcPsX8irA==
X-Received: by 2002:a05:620a:1998:: with SMTP id bm24mr28464979qkb.171.1628604307930;
        Tue, 10 Aug 2021 07:05:07 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id e6sm4223390qtw.35.2021.08.10.07.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 07:05:07 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] selftests/kselftest/runner/run_one(): Allow running non-executable files
Date:   Tue, 10 Aug 2021 14:04:59 +0000
Message-Id: <20210810140459.23990-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

When running a test program, 'run_one()' checks if the program has the
execution permission and fails if it doesn't.  However, it's easy to
mistakenly missing the permission, as some common tools like 'diff'
don't support the permission change well[1].  Compared to that, making
mistakes in the test program's path would only rare, as those are
explicitly listed in 'TEST_PROGS'.  Therefore, it might make more sense
to resolve the situation on our own and run the program.

For the reason, this commit makes the test program runner function to
still print the warning message but run the program after giving the
execution permission in the case.  To make nothing corrupted, it also
restores the permission after running it.

[1] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/kselftest/runner.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index cc9c846585f0..2eb31e945709 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -65,15 +65,16 @@ run_one()
 
 	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "# $TEST_HDR_MSG"
-	if [ ! -x "$TEST" ]; then
-		echo -n "# Warning: file $TEST is "
-		if [ ! -e "$TEST" ]; then
-			echo "missing!"
-		else
-			echo "not executable, correct this."
-		fi
+	if [ ! -e "$TEST" ]; then
+		echo "# Warning: file $TEST is missing!"
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
+		permission_added="false"
+		if [ ! -x "$TEST" ]; then
+			echo "# Warning: file $TEST is not executable"
+			chmod u+x "$TEST"
+			permission_added="true"
+		fi
 		cd `dirname $TEST` > /dev/null
 		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
@@ -88,6 +89,9 @@ run_one()
 		else
 			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
 		fi)
+		if [ "$permission_added" = "true" ]; then
+			chmod u-x "$TEST"
+		fi
 		cd - >/dev/null
 	fi
 }
-- 
2.17.1

