Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC63E7DC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Aug 2021 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhHJQqN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhHJQqM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 12:46:12 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C1C06179B;
        Tue, 10 Aug 2021 09:45:50 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id kl2so11237968qvb.11;
        Tue, 10 Aug 2021 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M34eDia/wYuF8zrcd5RLEymX5JCfRRmNCI+Mi4oB314=;
        b=bouY3YiApoR3gWXtfofP2An+wsm1dwTUerOsd+kHo5hCwPB/TNEZchqzxISwFr0smN
         y4E8DvaUp+HELOkpNht5eaygqa5s6ek3PKj7cb8tRqSmpiUdqI04WO5opRj7yK0qhak9
         t79OEO1vxPm3aZPYLamDW5iTh7v0659NGHoMuddzn8E+LUeullEZpWG4iy2N4SBCsTtm
         TL3yxN+OVayWIGyxMVvaCbgnHuAb4DuiRXfsWUeSoG5aqPFjj9/J0qcjlmGBgAgV5lxE
         AmHpFfmzvOkFuFQM/JrkWQSrvXQ2dpeFIai90aBcJWp2GbcXHDp+ckCBuzVBMZi6IagO
         voag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M34eDia/wYuF8zrcd5RLEymX5JCfRRmNCI+Mi4oB314=;
        b=nnHn1BS5gIbvIzzdH+vONRR0ivKNsUE1yKxU7ecgQ0EYEbeZDMEyMIOh2KVhbKzjAi
         N5PXofiNEgTe4TrTMgSgmbj0achVLWKQfyOiYX4gRvuUdfOwuKFJSZpPcnDlNKmLuQZd
         RqhjyXvpvimUf6F1GocYw/86e/kTr426jYRDP9DI0liTUd1sXNzTz1DXxS7i5T2OoxqR
         oUjUxLyDVRwEGacjHSFQ5ACo2Fhr0qThkZOtR6sYQHhcrFND5PFCrcaVPzCWAXT8hCjS
         7bkrhb1DdjFdxOrzc9Q254c56DX4+LL51U7J61xqXaD8EMBnZ96m54EWhI3OJQoaQILi
         XKzw==
X-Gm-Message-State: AOAM532Xe/xw1fY1OLZeEuQ4lRTfJmm2xlkhA7qpWKJ8Vv/0MNWzxdeQ
        jLlvHswZKwvmRNZQTZ9ywt4=
X-Google-Smtp-Source: ABdhPJzQPdwgIXeLAmzH2RKwD/WxUvy1gi6/2LZN5Qq/5UHHmhRl33xC72Us8U8MvTAW/2Bes1nFRg==
X-Received: by 2002:a05:6214:1c0f:: with SMTP id u15mr18742909qvc.17.1628613949742;
        Tue, 10 Aug 2021 09:45:49 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id i123sm11510442qkf.60.2021.08.10.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 09:45:49 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     shuah@kernel.org
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2] selftests/kselftest/runner/run_one(): Allow running non-executable files
Date:   Tue, 10 Aug 2021 16:45:34 +0000
Message-Id: <20210810164534.25902-1-sj38.park@gmail.com>
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
still print the warning message but try parsing the interpreter of the
program and explicitly run it with the interpreter, in the case.

[1] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
Changes from v1
(https://lore.kernel.org/linux-kselftest/20210810140459.23990-1-sj38.park@gmail.com/)
- Parse and use the interpreter instead of changing the file

 tools/testing/selftests/kselftest/runner.sh | 28 +++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index cc9c846585f0..a9ba782d8ca0 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -33,9 +33,9 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
+		/usr/bin/timeout --foreground "$kselftest_timeout" $1
 	else
-		"$1"
+		$1
 	fi
 }
 
@@ -65,17 +65,25 @@ run_one()
 
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
+		cmd="./$BASENAME_TEST"
+		if [ ! -x "$TEST" ]; then
+			echo "# Warning: file $TEST is not executable"
+
+			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
+			then
+				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
+				cmd="$interpreter ./$BASENAME_TEST"
+			else
+				echo "not ok $test_num $TEST_HDR_MSG"
+				return
+			fi
+		fi
 		cd `dirname $TEST` > /dev/null
-		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
+		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
-- 
2.17.1

