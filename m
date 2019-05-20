Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A503F24382
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 00:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfETWh6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 18:37:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34536 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfETWhz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 18:37:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so7949077pfa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2019 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b/l6/l1AufDmAUhOF8a8fB1k+gtCOVC+NAsFR62B7O4=;
        b=lM9DNJTWH85cRnnnhYNlNE4dONDsqscTxOvmcDJZkUQMxfPIkPfqFVqwqmWeS1s83s
         7FPYMkTDzEXgbnfwPGoDUxMZjKIxcH4HtAA383GqAxsmmLNqQhfbzNSBB5FREwUM0rUG
         mJDxn1C72biDV0qWD3tjfPuPU+UlxLDhRylG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b/l6/l1AufDmAUhOF8a8fB1k+gtCOVC+NAsFR62B7O4=;
        b=E2wTgLXAl4enJ46bZttUms8RC+DsqC30cFOG/zH2N9W3KLxHTw+MyANjE3fkizCtoP
         Vqw/mb+MQCKvawVt/qe+Irbc47COde/e/CAv7+wsNBEPFd6E1NN81Ux7JTzCWxg0qDlU
         Cw3+ZIZAajagp7Zsy3wtPlzV4gVxivLadUKq1yk7UAy1tNZI2EebMfTSAPRve0fu5pge
         Iz9RGWM7+KtyDoYpJJFOeoBZySGoVwYvjcVB/MSQRNLW/roIplGsGJ8jOCD9aLzLcwzm
         fVF5LJhRcviGfOnu1n8YT4GA8W3mspeX+JT1/uE+ClNO/JmPMoryRKG7NXQDp03Oo3z3
         b4ew==
X-Gm-Message-State: APjAAAVcdxIIjjkfemLr76mkovHgNP7DTfhs4pXP3ZACgaPBTqaUFRAF
        YCA0z84bhxDP8u3Pc5WzdyeDmQ==
X-Google-Smtp-Source: APXvYqwdArVBUdcsrTAzbAI9s4ufhvYl5Cl3+PNwtEVoHWzW6BMlxMtoR5cxjMvx02W7l7FfZKwc/g==
X-Received: by 2002:a62:2805:: with SMTP id o5mr82848917pfo.256.1558391874087;
        Mon, 20 May 2019 15:37:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t5sm20808766pgn.80.2019.05.20.15.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 15:37:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: Remove forced unbuffering for test running
Date:   Mon, 20 May 2019 15:37:48 -0700
Message-Id: <20190520223749.13476-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520223749.13476-1-keescook@chromium.org>
References: <20190520223749.13476-1-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As it turns out, the "stdbuf" command will actually force all
subprocesses into unbuffered output, and some implementations of "echo"
turn into single-character writes, which utterly wrecks writes to /sys
and /proc files.

Instead, drop the "stdbuf" usage, and for any tests that want explicit
flushing between newlines, they'll have to add "fflush(stdout);" as
needed.

Reported-by: Takashi Iwai <tiwai@suse.de>
Fixes: 5c069b6dedef ("selftests: Move test output to diagnostic lines")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest/runner.sh | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index eff3ee303d0d..00c9020bdda8 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -24,16 +24,6 @@ tap_prefix()
 	fi
 }
 
-# If stdbuf is unavailable, we must fall back to line-at-a-time piping.
-tap_unbuffer()
-{
-	if ! which stdbuf >/dev/null ; then
-		"$@"
-	else
-		stdbuf -i0 -o0 -e0 "$@"
-	fi
-}
-
 run_one()
 {
 	DIR="$1"
@@ -54,7 +44,7 @@ run_one()
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
 		cd `dirname $TEST` > /dev/null
-		(((((tap_unbuffer ./$BASENAME_TEST 2>&1; echo $? >&3) |
+		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
-- 
2.17.1

