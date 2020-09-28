Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A939E27B63D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgI1U1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgI1U0z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 16:26:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CAEC0613D3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:26:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so2178178pfp.11
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzRblziNDCaC7keBvDiohhrFtalx1DXB9TPgmLszZrA=;
        b=e9JuINGPJVrbQYKx7vuqE1Loo2OssneXzQmGiy4MVvC7Kr42QHsB4ujyYE3sThJClK
         eyB3VynG+2YNjxnCFf54brvGq1UAcCaEzzn8XYUwVZJfWgYnFd0mf7pKZMQf5XmutkrW
         EwMA/bmLqy5rsMsw501J+eXLKTtB/3DeH+SsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzRblziNDCaC7keBvDiohhrFtalx1DXB9TPgmLszZrA=;
        b=Qqngfv1Gs5P6tvrzcnMEsQJF2D5FALPR0ul2qDHBMgag42s3zthYO9VGUadSTiUo78
         yuEGfTKXL8hiaFGe/JCkr6QWlpjtmSjxlWh+6xHb+pBdIvKf/E/c2o8QmJbg6hpFRYee
         qXEwpY36ohlIRCytA9PPmEWQi3j4BlEm4hkDz8VR1XA/wXt8GpW3dkQ2xmtRnO+aXJsT
         Bjb6EMruiKxkbODTmOaNnZKM/FhqT0sEhCuOZvihz5OmcqxkPDqiFIBldUFZlxSrEr4m
         OvNNqOvDv5W2Z9qpYJBIFEUQI+AfI+Yjum/niFkNd2fzwaNWGIkm34s8MATuddhW0u79
         WLpw==
X-Gm-Message-State: AOAM530auxg4Ms4UftFa2ZZ90bQ47AXKdU4MaT7mcGto2p4gNpbImFvL
        4EgGH7ZCO+7j2nO5ePwkK/m1Xw==
X-Google-Smtp-Source: ABdhPJw9/nkVGUaCF6L4XFEYdzCOxCettpuRg4CZXwXCSjvmtNORVnNbFu6HTgjWfkWiVu1RK/mdLQ==
X-Received: by 2002:a62:6845:0:b029:13e:dcd:75bd with SMTP id d66-20020a6268450000b029013e0dcd75bdmr1112623pfc.12.1601324814948;
        Mon, 28 Sep 2020 13:26:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bx18sm2214323pjb.6.2020.09.28.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 13:26:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/3] selftests/run_kselftest.sh: Make each test individually selectable
Date:   Mon, 28 Sep 2020 13:26:49 -0700
Message-Id: <20200928202650.2530280-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928202650.2530280-1-keescook@chromium.org>
References: <20200928202650.2530280-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently with run_kselftest.sh there is no way to choose which test
we could run. All the tests listed in kselftest-list.txt are all run
every time. This patch enhanced the run_kselftest.sh to make the test
collections (or tests) individually selectable. e.g.:

$ ./run_kselftest.sh -c seccomp -t timers:posix_timers -t timers:nanosleep

Additionally adds a way to list all known tests with "-l", usage
with "-h", and perform a dry run without running tests with "-n".

Co-developed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/run_kselftest.sh | 77 ++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 8b0ad4766d78..609a4ef9300e 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -8,21 +8,86 @@ cd $BASE_DIR
 TESTS="$BASE_DIR"/kselftest-list.txt
 if [ ! -r "$TESTS" ] ; then
 	echo "$0: Could not find list of tests to run ($TESTS)" >&2
-	exit 1
+	available=""
+else
+	available="$(cat "$TESTS")"
 fi
-available="$(cat "$TESTS")"
 
 . ./kselftest/runner.sh
 ROOT=$PWD
 
-if [ "$1" = "--summary" ] ; then
-	logfile="$BASE_DIR"/output.log
-	cat /dev/null > $logfile
+usage()
+{
+	cat <<EOF
+Usage: $0 [OPTIONS]
+  -s | --summary		Print summary with detailed log in output.log
+  -t | --test COLLECTION:TEST	Run TEST from COLLECTION
+  -c | --collection COLLECTION	Run all tests from COLLECTION
+  -l | --list			List the available collection:test entries
+  -d | --dry-run		Don't actually run any tests
+  -h | --help			Show this usage info
+EOF
+	exit $1
+}
+
+COLLECTIONS=""
+TESTS=""
+dryrun=""
+while true; do
+	case "$1" in
+		-s | --summary)
+			logfile="$BASE_DIR"/output.log
+			cat /dev/null > $logfile
+			shift ;;
+		-t | --test)
+			TESTS="$TESTS $2"
+			shift 2 ;;
+		-c | --collection)
+			COLLECTIONS="$COLLECTIONS $2"
+			shift 2 ;;
+		-l | --list)
+			echo "$available"
+			exit 0 ;;
+		-n | --dry-run)
+			dryrun="echo"
+			shift ;;
+		-h | --help)
+			usage 0 ;;
+		"")
+			break ;;
+		*)
+			usage 1 ;;
+	esac
+done
+
+# Add all selected collections to the explicit test list.
+if [ -n "$COLLECTIONS" ]; then
+	for collection in $COLLECTIONS ; do
+		found="$(echo "$available" | grep "^$collection:")"
+		if [ -z "$found" ] ; then
+			echo "No such collection '$collection'" >&2
+			exit 1
+		fi
+		TESTS="$TESTS $found"
+	done
+fi
+# Replace available test list with explicitly selected tests.
+if [ -n "$TESTS" ]; then
+	valid=""
+	for test in $TESTS ; do
+		found="$(echo "$available" | grep "^${test}$")"
+		if [ -z "$found" ] ; then
+			echo "No such test '$test'" >&2
+			exit 1
+		fi
+		valid="$valid $found"
+	done
+	available="$(echo "$valid" | sed -e 's/ /\n/g')"
 fi
 
 collections=$(echo "$available" | cut -d: -f1 | uniq)
 for collection in $collections ; do
 	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
 	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
-	(cd "$collection" && run_many $tests)
+	($dryrun cd "$collection" && $dryrun run_many $tests)
 done
-- 
2.25.1

