Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8D22D114
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 23:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgGXVif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jul 2020 17:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgGXVgs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jul 2020 17:36:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B761C0619E8
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k5so6243607pjg.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/kBhrQPbzovHh41OSaPnXat9qGyJUFnv0iXtUuMMKE=;
        b=IghqIwoBfKGdBHowpyxVljQEPV4EvfpdQWYORYH5ljggyOoUB93bDQtlXhE3tkR1xG
         NqF6JhgR17Y5MKkkypz0qY7Odys1mTMmr5e+6P8C5CnGiggDf6CucxbUm93J2hL0KjhG
         WQJk6B8gXZFngzLozgAGQtzopAVTs2DRYO93s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/kBhrQPbzovHh41OSaPnXat9qGyJUFnv0iXtUuMMKE=;
        b=nelDFPxPBEKR8eN5TVNuGwCiKXZDvLoTh8JfS9xalgT7gIfmJ5sUy7uMUO/znShu8Y
         dPRv4SDNDZfd7rVyXoBPg9xA0PHc5yeRKadVyE6XpWBzTeJFalWPEEDXjwHM/A0OgtcG
         M3/3aYYQ7DDZljtrX1m06ImU1a6Pm1ryZEAU7YI7+gGLU8HRdG6gDy8cH16WufSZ8YTM
         2/ObR9WXrPMwVweDmKfSz1Y7+XhYTNeDTS7ZRI6qwIBKAcen1RtALynBbMiv9mAzGqPL
         VnF7ZKv9r4h3JWrT0y748c5ZSXXc4O/CRda0LVDrPp6ZLdn4cWS49H33eElBGvB+EGWT
         3nQQ==
X-Gm-Message-State: AOAM531Qmp6cYYJtBUylGWXIEsCXHFv/IW3J33X8HOl9IW6sgR/JkcV0
        nTlPYdKlaRUMopBQNO7sdtkm1A==
X-Google-Smtp-Source: ABdhPJzPJqhzQYIlmFMm0JvuP6Chr0PhV314mA4W5L786J7f7YtpqYDyRBviJfOTvbrBAVr9J0xosQ==
X-Received: by 2002:a17:90b:338d:: with SMTP id ke13mr7268603pjb.60.1595626607402;
        Fri, 24 Jul 2020 14:36:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x10sm7377865pfp.80.2020.07.24.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        SeongJae Park <sjpark@amazon.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, KP Singh <kpsingh@chromium.org>,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/19] selftest/firmware: Add selftest timeout in settings
Date:   Fri, 24 Jul 2020 14:36:23 -0700
Message-Id: <20200724213640.389191-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The firmware tests would always time out for me. Add a correct timeout,
including details on how the value was reached. Additionally allow the
test harness to skip comments in settings files and report how long a
given timeout was.

Reviewed-by: SeongJae Park <sjpark@amazon.de>
Acked-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/firmware/settings   | 8 ++++++++
 tools/testing/selftests/kselftest/runner.sh | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/firmware/settings

diff --git a/tools/testing/selftests/firmware/settings b/tools/testing/selftests/firmware/settings
new file mode 100644
index 000000000000..085e664ee093
--- /dev/null
+++ b/tools/testing/selftests/firmware/settings
@@ -0,0 +1,8 @@
+# The async firmware timeout is set to 1 second (but ends up being effectively
+# 2 seconds). There are 3 test configs, each done with and without firmware
+# present, each with 2 "nowait" functions tested 5 times. Expected time for a
+# normal execution should be 2 * 3 * 2 * 2 * 5 = 120 seconds for those alone.
+# Additionally, fw_fallback may take 5 seconds for internal timeouts in each
+# of the 3 configs, so at least another 15 seconds are needed. Add another
+# 10 seconds for each testing config: 120 + 15 + 30
+timeout=165
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 676b3a8b114d..cd5ddf979f15 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -53,6 +53,10 @@ run_one()
 	settings="$BASE_DIR/$DIR/settings"
 	if [ -r "$settings" ] ; then
 		while read line ; do
+			# Skip comments.
+			if echo "$line" | grep -q '^#'; then
+				continue
+			fi
 			field=$(echo "$line" | cut -d= -f1)
 			value=$(echo "$line" | cut -d= -f2-)
 			eval "kselftest_$field"="$value"
@@ -80,7 +84,7 @@ run_one()
 			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
 			echo "#"
-			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
+			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
 		else
 			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
 		fi)
-- 
2.25.1

