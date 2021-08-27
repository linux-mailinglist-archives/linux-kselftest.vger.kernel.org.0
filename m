Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08353FA1A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Aug 2021 00:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhH0W7N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 18:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhH0W7N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 18:59:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ABEC0613D9
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 15:58:23 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k21-20020a056a001695b0290329e718b5a3so13307pfc.15
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5kt2Hs53YExhNYpfPSX+vfaUKXrkgz5zWfnPb9H9C5o=;
        b=CwVuEzd0fS3U5i7hEYs6kt8YGwK1Q+B0CA8MKQ0HFuUN7KjKITVZBmOAj9+61B/xUL
         H5eS7kjXwCW2Opax4eWgDUdycDVagLubSWmiM2uugcT5KVFWpajGG8X15tmzZe3VoaXG
         +236OKR3PaEC7xQONOBiLikYG6tNnLB2eA05KVSwgFn2uOYSOvyKMWfSoElbzwSHWeLO
         AMAUbEirs+E7hRG5UhbEizrS27gT89Dv0LCRFDz5Pr/VSfOURlAlsPHH7NhqBm26EGRD
         elIhr8IQWl3ZOni+DMR8RNbD+H/fFGRSGsTX79XayMd42lQGs3GKxcDCTXWzXGdbmLvs
         lWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5kt2Hs53YExhNYpfPSX+vfaUKXrkgz5zWfnPb9H9C5o=;
        b=orVtRAZYSX3FHr7AVbaa4p8E4pH4S6T+A58rqsO5pmxf/zcQgwahO2ciEklHXf1p2F
         E5k/xvfJVEnUArqn6J6ELAd8b9M4oHC8ndNaZA1KuTtzuwOwbskQQCtgfaql8m5P7swT
         gCfOjb1tRk0fRsEYBqGPg+18WDJdw3zuG13tfF+qQG6SfbS5x3DvEZxizr1Wh/22Izcn
         lu3qraX7Y2Auzu+gp2y38yGJCSPI1GJqeffw9WzGntvnbnJnFqeRZDrQolQXwgd3vAxC
         P+Y+k6+3PjGqR2OMRY3GuC+SsV5kg/V6GZ8IwugfASTpVIdRIOZqzLPozfQVB1WjWd7I
         SCPQ==
X-Gm-Message-State: AOAM532GOiFVWzyn6sFHg6gDWvssG3/tMehr3Y/s1GCJLkoCwy+9S+VI
        YPWiNxw24k2WurPKfWJdPCD3wAvwpQ==
X-Google-Smtp-Source: ABdhPJwuGZHQKI3Z4ubJeC6jgqz/RDnR26QtINCQ0T5nhoUDIbS6Tb/DK4aJEaBXwMqbuAjIIzLy/idWhQ==
X-Received: from sunrae.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2814])
 (user=rmoar job=sendgmr) by 2002:a17:90b:1182:: with SMTP id
 gk2mr285811pjb.109.1630105102801; Fri, 27 Aug 2021 15:58:22 -0700 (PDT)
Date:   Fri, 27 Aug 2021 22:58:11 +0000
In-Reply-To: <20210827225812.3247919-1-rmoar@google.com>
Message-Id: <20210827225812.3247919-2-rmoar@google.com>
Mime-Version: 1.0
References: <20210827225812.3247919-1-rmoar@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH 1/2] selftests: tool: Add subtest header line and change
 indentation format in TAP results
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, keescook@chromium.org, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch is part of a series to alter the format of kselftest TAP
results to improve compatibility with proposed KTAP specification
(https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/).

Two changes:
- Change from "# " to "  " for indentation of nested tests
- Add subtest header line at start of tests with subtests. Line format
is "# Subtest: [name of test]".

An example of the new format:

Old format:

 TAP version 13
 1..1
 # TAP version 13
 # 1..1
 # # Starting 1 tests from 1 test cases.
 # #  RUN           global.get_syscall_info ...
 # #            OK  global.get_syscall_info
 # ok 1 global.get_syscall_info
 # # PASSED: 1 / 1 tests passed.
 # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: ptrace: get_syscall_info

New format:

TAP version 13
1..1
  # Subtest: selftests: ptrace: get_syscall_info
  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           global.get_syscall_info ...
  #            OK  global.get_syscall_info
  ok 1 global.get_syscall_info
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ptrace: get_syscall_info

Signed-off-by: Rae Moar <rmoar@google.com>
Change-Id: I139774745310ad2cd6dc5d7740254e48d8226241
---
 tools/testing/selftests/kselftest/prefix.pl | 2 +-
 tools/testing/selftests/kselftest/runner.sh | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest/prefix.pl b/tools/testing/selftests/kselftest/prefix.pl
index 12a7f4ca2684..e59374b62603 100755
--- a/tools/testing/selftests/kselftest/prefix.pl
+++ b/tools/testing/selftests/kselftest/prefix.pl
@@ -16,7 +16,7 @@ while (1) {
 	my $bytes = sysread(STDIN, $char, 1);
 	exit 0 if ($bytes == 0);
 	if ($needed) {
-		print "# ";
+		print "  ";
 		$needed = 0;
 	}
 	print $char;
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index cc9c846585f0..9b04aeb26d3a 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -23,7 +23,7 @@ fi
 tap_prefix()
 {
 	if [ ! -x /usr/bin/perl ]; then
-		sed -e 's/^/# /'
+		sed -e 's/^/  /'
 	else
 		"$BASE_DIR"/kselftest/prefix.pl
 	fi
@@ -75,7 +75,8 @@ run_one()
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
 		cd `dirname $TEST` > /dev/null
-		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
+		(echo "  # Subtest: selftests: $DIR: $BASENAME_TEST" &&
+		(((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
@@ -83,7 +84,6 @@ run_one()
 		if [ $rc -eq $skip_rc ]; then	\
 			echo "ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
-			echo "#"
 			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
 		else
 			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
-- 
2.33.0.259.gc128427fd7-goog

