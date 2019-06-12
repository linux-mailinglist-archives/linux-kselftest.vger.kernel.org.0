Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F97D42C84
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfFLQlw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 12:41:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47063 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfFLQlw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 12:41:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so9999361lfh.13
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LY3Zum7EcZySh9JV2QeSI4VbZdzqoIew45sk+wZcJEo=;
        b=TQAI2LebuM1+ynuvr8g3h6TzCBLzN9uyrGj9oAFp954KLiKbjPYhrSn57VkSeKB+GO
         1TW+f4ABv+jfBF6kJmcvyEPYpAqWhUV7KKkGG25p5Ch89K1ScHW4B38jh0c2ATAddfGS
         4fBSYPmsKHNZe5wWpX7BclI9vv1TkSNAWFKFkWoXO1lYGhXE8J3yio5cqepODBt6/cgB
         CkPCGcFH8TZQwlafoEQusXPdb/4zMFhN08uJlURhN5Nve4wRP23WkP68wVO6GkKbM5pC
         lo3Spo91KZ86EtKpKSrGUKvhSmidkLNStcQVFn0BeVFXbh8rfU5ufN4sn0qOUdNEIG+8
         9pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LY3Zum7EcZySh9JV2QeSI4VbZdzqoIew45sk+wZcJEo=;
        b=ppC9W5abVOr3dFiNR8bq/mmD6C4bcseImCDfCXcFPawz4a3dHbIaHh01q7+4LGa+BE
         RM40B/F/34p8o20NV7EYwqSycMX2RJJ0zB70gFqRTMetBV4HXWvQWrQ4zZodmvEZboxx
         0jbkOEa63WzcYHt29tNSPYZGgI3F3s8IixSDDbc4PDsOyJDTziqLotBq30ogCRsG4Ptq
         o+4Ve5+wJDT4qw6a0UyPTLnTacRVNpzD6P1DTYby0H+bw8jdv3YeNZLdP7CQnCSjDu0W
         Nmip0Mt/4ikPqVHj0YmtjGs3WSddQXNwBvuCWYE+duy0LEMXgsLm3lDd2a0+Dn/8tiXI
         69bA==
X-Gm-Message-State: APjAAAVDRmUU3A2lIGQ1iiALPgk+q6+/6CLYvi5PWlPE6GolVqkAA0O6
        JCdKbMPrfgMhBE2RF4xUXozEIw==
X-Google-Smtp-Source: APXvYqz6QDOJM5JIGBo3oUBwIo24eGlCYtbosVQp04IUzpddt+vXBwhkPiBIsXgkOa0hXozn07Ho1Q==
X-Received: by 2002:a19:9152:: with SMTP id y18mr1312743lfj.128.1560357710141;
        Wed, 12 Jun 2019 09:41:50 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id l25sm65239lfk.57.2019.06.12.09.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 09:41:49 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, keescook@chromium.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/kselftest/runner.sh: Add 30 second timeout per test
Date:   Wed, 12 Jun 2019 18:41:46 +0200
Message-Id: <20190612164146.25280-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
test") solves that binary tests doesn't hang forever. However, scripts
can still hang forever, this adds an timeout to each test script run. This
assumes that an individual test doesn't take longer than 30 seconds.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/kselftest/runner.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 00c9020bdda8..cff7d2d83648 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -5,6 +5,7 @@
 export skip_rc=4
 export logfile=/dev/stdout
 export per_test_logging=
+export TEST_TIMEOUT_DEFAULT=30
 
 # There isn't a shell-agnostic way to find the path of a sourced file,
 # so we must rely on BASE_DIR being set to find other tools.
@@ -24,6 +25,14 @@ tap_prefix()
 	fi
 }
 
+tap_timeout()
+{
+	if [ -x /usr/bin/timeout ] && [ -x "$BASENAME_TEST" ] \
+		&& file $BASENAME_TEST |grep -q "shell script"; then
+		echo -n "timeout $TEST_TIMEOUT_DEFAULT"
+	fi
+}
+
 run_one()
 {
 	DIR="$1"
@@ -44,7 +53,7 @@ run_one()
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
 		cd `dirname $TEST` > /dev/null
-		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
+		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
-- 
2.11.0

