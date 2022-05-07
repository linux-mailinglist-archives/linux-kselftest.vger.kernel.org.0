Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2551E808
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 May 2022 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385643AbiEGPNt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 May 2022 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354601AbiEGPNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 May 2022 11:13:48 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D624BDF;
        Sat,  7 May 2022 08:10:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a191so8456895pge.2;
        Sat, 07 May 2022 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYQzIWQ2NAfONhuZylugDVT6IAuYpsbZNehqWxZKwgQ=;
        b=C3GtC8Od1fj3sccJEJKc/tP+2ADQeyk0ch3PFrrU7NxSyiQx6RMdPXKAslG6gHqKmO
         9096uLOdn0HN54FtG5kEWKr7yn6msgNcMPZ61gIm1FytUwlzKsUzA92aFkUrAtLW7anu
         7IoE7PmSK6e1g5JF/fe2md4WHDix85BndUhdIhRtSXscBWf7MtzZ9QRSQ5f5T6I1krQT
         MC5NLb8hAWhgncjfVp3Nk7ooQ/j3r8NWF/aZeLpqNwg4Wg4zJo9Ex5KhwrJB76scVnuX
         8hK8Z8TmDMB+kfnAwQJdtz+6eI5XS3n2H8uygHywRwrUqI2THYDv5CICJOEsXpQmlQj4
         Kjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYQzIWQ2NAfONhuZylugDVT6IAuYpsbZNehqWxZKwgQ=;
        b=saCoTF1iZtkKocCVkSE2QRbU8a+T+cNMzm1bhUyJ9+bOEjJxJm9IZV1JvzjUjZCvgJ
         iyIBoy/yGPKI76n7a9GW4TdWojUhl3C8ttH/IrYZ1LWDrilJItnKzSMH9Smsre79nvde
         scJtSCe3lg22/oCvuNonxbBqE7i3/4MKe1qHycsSB9vLr1AptCbcLGkZNkhRc6yKbKMG
         WO/Vp6nTvECxgF5goqFcoATKuSR5swAFDUPbbS/htWdqDcVAfI9/W1q5Mta/a86H9sr3
         uTS307yqiW3O3bRSwZd1eokY8a5r5BiK8IwoGa9CLpTrD7PP+DOrGz5Usj4Ab5o4ZVh/
         Ltyw==
X-Gm-Message-State: AOAM531J3IU8er1rySI3OnSbWQS/hXJbRcULjKgHTdPthuMwuzEM6sNL
        ttP/aG7m+AJnUZ1Lii7Q/XxQpfpcObgLb+8E
X-Google-Smtp-Source: ABdhPJw8W5HoQYr5RDKWnMRa85QzuvzlK9J87OAO4Mre3rLxmytEnZKqgA2kufvP1kuRqKOIjUKgcA==
X-Received: by 2002:a05:6a00:179f:b0:50d:e311:7d5 with SMTP id s31-20020a056a00179f00b0050de31107d5mr8102406pfg.64.1651936199598;
        Sat, 07 May 2022 08:09:59 -0700 (PDT)
Received: from localhost.localdomain ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78748000000b0050dc762817bsm5355707pfo.85.2022.05.07.08.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 08:09:58 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Improve the readability of test results messages in cgroup
Date:   Sat,  7 May 2022 20:30:46 +0530
Message-Id: <20220507150046.109741-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Improve the readability of status messages that indicate whether the
kselftest passed or failed. 

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 tools/testing/selftests/kselftest.h         | 12 ++++++------
 tools/testing/selftests/kselftest/runner.sh | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index b8f248018174..a38f20f376b3 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -137,7 +137,7 @@ static inline void ksft_test_result_pass(const char *msg, ...)
 	ksft_cnt.ksft_pass++;
 
 	va_start(args, msg);
-	printf("ok %d ", ksft_test_num());
+	printf("Test %d ok - ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -151,7 +151,7 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 	ksft_cnt.ksft_fail++;
 
 	va_start(args, msg);
-	printf("not ok %d ", ksft_test_num());
+	printf("Test %d not ok - ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -177,7 +177,7 @@ static inline void ksft_test_result_xfail(const char *msg, ...)
 	ksft_cnt.ksft_xfail++;
 
 	va_start(args, msg);
-	printf("ok %d # XFAIL ", ksft_test_num());
+	printf("Test %d ok # XFAIL ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -191,7 +191,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	ksft_cnt.ksft_xskip++;
 
 	va_start(args, msg);
-	printf("ok %d # SKIP ", ksft_test_num());
+	printf("Test %d ok # SKIP ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -206,7 +206,7 @@ static inline void ksft_test_result_error(const char *msg, ...)
 	ksft_cnt.ksft_error++;
 
 	va_start(args, msg);
-	printf("not ok %d # error ", ksft_test_num());
+	printf("Test %d not ok # error ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -287,7 +287,7 @@ static inline int ksft_exit_skip(const char *msg, ...)
 	 */
 	if (ksft_plan || ksft_test_num()) {
 		ksft_cnt.ksft_xskip++;
-		printf("ok %d # SKIP ", 1 + ksft_test_num());
+		printf("Test %d ok # SKIP ", 1 + ksft_test_num());
 	} else {
 		printf("1..0 # SKIP ");
 	}
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 294619ade49f..6d95a1e96ea8 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -94,7 +94,7 @@ run_one()
 	echo "# $TEST_HDR_MSG"
 	if [ ! -e "$TEST" ]; then
 		echo "# Warning: file $TEST is missing!"
-		echo "not ok $test_num $TEST_HDR_MSG"
+		echo "Test $test_num not ok - $TEST_HDR_MSG"
 	else
 		eval kselftest_cmd_args="\$${kselftest_cmd_args_ref:-}"
 		cmd="./$BASENAME_TEST $kselftest_cmd_args"
@@ -106,7 +106,7 @@ run_one()
 				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
 				cmd="$interpreter ./$BASENAME_TEST"
 			else
-				echo "not ok $test_num $TEST_HDR_MSG"
+				echo "Test $test_num not ok - $TEST_HDR_MSG"
 				return
 			fi
 		fi
@@ -114,15 +114,15 @@ run_one()
 		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
-		echo "ok $test_num $TEST_HDR_MSG") ||
+		echo "Test $test_num ok - $TEST_HDR_MSG") ||
 		(rc=$?;	\
 		if [ $rc -eq $skip_rc ]; then	\
-			echo "ok $test_num $TEST_HDR_MSG # SKIP"
+			echo "Test $test_num ok - $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
 			echo "#"
-			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
+			echo "Test $test_num not ok - $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
 		else
-			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
+			echo "Test $test_num not ok - $TEST_HDR_MSG # exit=$rc"
 		fi)
 		cd - >/dev/null
 	fi
-- 
2.25.1

