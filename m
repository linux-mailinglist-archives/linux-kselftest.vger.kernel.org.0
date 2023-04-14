Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18556E2AB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 21:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDNTiy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNTiw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 15:38:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBEE49EA;
        Fri, 14 Apr 2023 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CbWN6qJHp6Pc/X56x9EHRwm7uGLwhKUh3lgTwYDnlFA=; b=SCHVqNXhLeGLbbKmp0dlZceMfA
        qRvQjXsE6Ldl5/v8TDiRoTKvpKOJY5xc5dLRs0ThddMp7Km8v1L0X3ipoFmsbXB6UYSzqQiM6U3oG
        dgIjh/zmGsTkwxbPaybtp8/dBU8eZLciRwqnGLw4uNirHDuTm4i12t1a6SqCtN+LOFHykTiH3PwtL
        qX0gLZMeTcPJ//h9Z01G3UnXvdt2czbnK0HRWLXhEjPlc5UNIfQhMJJubv5wm+40EUH5fU5uZGUFO
        w8nuchHTqmL1v3Jh5TVoyIKJQspv0fy++z1S4Ea0I63CN3tn2uwntxb0ru7w+0d7yUc9z2XJdxtIj
        ZCO6RXIA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnPFu-00ASpr-0k;
        Fri, 14 Apr 2023 19:38:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, tiwai@suse.de, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, keescook@chromium.org,
        tweek@google.com, a.manzanares@samsung.com, dave@stgolabs.net,
        vincenzopalazzodev@gmail.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] selftests: allow runners to override the timeout
Date:   Fri, 14 Apr 2023 12:38:45 -0700
Message-Id: <20230414193845.2494120-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The default timeout for selftests tests is 45 seconds. Although
we already have 13 settings for tests of about 96 sefltests which
use a timeout greater than this, we want to try to avoid encouraging
more tests to forcing a higher test timeout as selftests strives to
run all tests quickly. Selftests also uses the timeout as a non-fatal
error. Only tests runners which have control over a system would know
if to treat a timeout as fatal or not.

To help with all this:

  o Enhance documentation to avoid future increases of insane timeouts
  o Add the option to allow overriding the default timeout with test
    runners with a command line option

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Documentation/dev-tools/kselftest.rst       | 22 +++++++++++++++++++++
 tools/testing/selftests/kselftest/runner.sh | 11 ++++++++++-
 tools/testing/selftests/run_kselftest.sh    |  5 +++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 12b575b76b20..dd214af7b7ff 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -168,6 +168,28 @@ the `-t` option for specific single tests. Either can be used multiple times::
 
 For other features see the script usage output, seen with the `-h` option.
 
+Timeout for selftests
+=====================
+
+Selftests are designed to be quick and so a default timeout is used of 45
+seconds for each test. Tests can override the default timeout by adding
+a settings file in their directory and set a timeout variable there to the
+configured a desired upper timeout for the test. Only a few tests override
+the timeout with a value higher than 45 seconds, selftests strives to keep
+it that way. Timeouts in selftests are not considered fatal because the
+system under which a test runs may change and this can also modify the
+expected time it takes to run a test. If you have control over the systems
+which will run the tests you can configure a test runner on those systems to
+use a greater or lower timeout on the command line as with the `-o` or
+the `--override-timeout` argument. For example to use 165 seconds instead
+one would use:
+
+   $ ./run_kselftest.sh --override-timeout 165
+
+You can look at the TAP output to see if you ran into the timeout. Test
+runners which know a test must run under a specific time can then optionally
+treat these timeouts then as fatal.
+
 Packaging selftests
 ===================
 
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 294619ade49f..1c952d1401d4 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -8,7 +8,8 @@ export logfile=/dev/stdout
 export per_test_logging=
 
 # Defaults for "settings" file fields:
-# "timeout" how many seconds to let each test run before failing.
+# "timeout" how many seconds to let each test run before running
+# over our soft timeout limit.
 export kselftest_default_timeout=45
 
 # There isn't a shell-agnostic way to find the path of a sourced file,
@@ -90,6 +91,14 @@ run_one()
 		done < "$settings"
 	fi
 
+	# Command line timeout overrides the settings file
+	if [ -n "$kselftest_override_timeout" ]; then
+		kselftest_timeout="$kselftest_override_timeout"
+		echo "# overriding timeout to $kselftest_timeout" >> "$logfile"
+	else
+		echo "# timeout set to $kselftest_timeout" >> "$logfile"
+	fi
+
 	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "# $TEST_HDR_MSG"
 	if [ ! -e "$TEST" ]; then
diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 97165a83df63..9a981b36bd7f 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -26,6 +26,7 @@ Usage: $0 [OPTIONS]
   -l | --list			List the available collection:test entries
   -d | --dry-run		Don't actually run any tests
   -h | --help			Show this usage info
+  -o | --override-timeout	Number of seconds after which we timeout
 EOF
 	exit $1
 }
@@ -33,6 +34,7 @@ EOF
 COLLECTIONS=""
 TESTS=""
 dryrun=""
+kselftest_override_timeout=""
 while true; do
 	case "$1" in
 		-s | --summary)
@@ -51,6 +53,9 @@ while true; do
 		-d | --dry-run)
 			dryrun="echo"
 			shift ;;
+		-o | --override-timeout)
+			kselftest_override_timeout="$2"
+			shift 2 ;;
 		-h | --help)
 			usage 0 ;;
 		"")
-- 
2.39.2

