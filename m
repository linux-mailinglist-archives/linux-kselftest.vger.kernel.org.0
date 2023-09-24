Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB39B7AC990
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Sep 2023 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjIXNcj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Sep 2023 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjIXNcI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Sep 2023 09:32:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C8349CE;
        Sun, 24 Sep 2023 06:20:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2CDC433D9;
        Sun, 24 Sep 2023 13:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561605;
        bh=PC4z+wf7F1uuG0RUwmXVtrKutdbhW/2g+iCqU0SAxg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8+aGf7lDFBDQQwR5HHq8hDTJdBQBZXw9mSlw2rjI+evbrQPCisWlO3KKXIBaZZTl
         /egVAyJEWmowlr8rf4I0gKcz9vA7HeIimYa3dLOTR3OPn75Oyo/70c9n/1JlkBImz5
         FPmS8kEURPnV8PK8GsLiYYO8d0+fglWTSKAhgJKyh9Psf0xemJOnOOgCHioZTtuM/m
         AglBC34q8dhFrUf5q1qskYhkT735KjIPTakGn4DBkQrqdk6Ed/UOC1kFxk21KKLOFL
         5CB82nKAWe+UfCx/h5nUbRjHlRuRHwRy3Okw2Xkmxv7Tv/4Mq7I1VjFg6GFtHbn+rO
         Cmi0E6hOPXt6w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Ricardo B. Marliere" <rbmarliere@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/13] selftests: fix dependency checker script
Date:   Sun, 24 Sep 2023 09:19:38 -0400
Message-Id: <20230924131945.1276562-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131945.1276562-1-sashal@kernel.org>
References: <20230924131945.1276562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.197
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Ricardo B. Marliere" <rbmarliere@gmail.com>

[ Upstream commit 5f9dd2e896a91bfca90f8463eb6808c03d535d8a ]

This patch fixes inconsistencies in the parsing rules of the levels 1
and 2 of the kselftest_deps.sh.  It was added the levels 4 and 5 to
account for a few edge cases that are present in some tests, also some
minor identation styling have been fixed (s/    /\t/g).

Signed-off-by: Ricardo B. Marliere <rbmarliere@gmail.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kselftest_deps.sh | 77 +++++++++++++++++++----
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index bbc04646346b2..e6010de678200 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -46,11 +46,11 @@ fi
 print_targets=0
 
 while getopts "p" arg; do
-    case $arg in
-        p)
+	case $arg in
+		p)
 		print_targets=1
 	shift;;
-    esac
+	esac
 done
 
 if [ $# -eq 0 ]
@@ -92,6 +92,10 @@ pass_cnt=0
 # Get all TARGETS from selftests Makefile
 targets=$(egrep "^TARGETS +|^TARGETS =" Makefile | cut -d "=" -f2)
 
+# Initially, in LDLIBS related lines, the dep checker needs
+# to ignore lines containing the following strings:
+filter="\$(VAR_LDLIBS)\|pkg-config\|PKG_CONFIG\|IOURING_EXTRA_LIBS"
+
 # Single test case
 if [ $# -eq 2 ]
 then
@@ -100,6 +104,8 @@ then
 	l1_test $test
 	l2_test $test
 	l3_test $test
+	l4_test $test
+	l5_test $test
 
 	print_results $1 $2
 	exit $?
@@ -113,7 +119,7 @@ fi
 # Append space at the end of the list to append more tests.
 
 l1_tests=$(grep -r --include=Makefile "^LDLIBS" | \
-		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+		grep -v "$filter" | awk -F: '{print $1}' | uniq)
 
 # Level 2: LDLIBS set dynamically.
 #
@@ -126,7 +132,7 @@ l1_tests=$(grep -r --include=Makefile "^LDLIBS" | \
 # Append space at the end of the list to append more tests.
 
 l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
-		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+		grep -v "$filter" | awk -F: '{print $1}' | uniq)
 
 # Level 3
 # gpio,  memfd and others use pkg-config to find mount and fuse libs
@@ -140,11 +146,32 @@ l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
 #	VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
 
 l3_tests=$(grep -r --include=Makefile "^VAR_LDLIBS" | \
-		grep -v "pkg-config" | awk -F: '{print $1}')
+		grep -v "pkg-config\|PKG_CONFIG" | awk -F: '{print $1}' | uniq)
 
-#echo $l1_tests
-#echo $l2_1_tests
-#echo $l3_tests
+# Level 4
+# some tests may fall back to default using `|| echo -l<libname>`
+# if pkg-config doesn't find the libs, instead of using VAR_LDLIBS
+# as per level 3 checks.
+# e.g:
+# netfilter/Makefile
+#	LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
+l4_tests=$(grep -r --include=Makefile "^LDLIBS" | \
+		grep "pkg-config\|PKG_CONFIG" | awk -F: '{print $1}' | uniq)
+
+# Level 5
+# some tests may use IOURING_EXTRA_LIBS to add extra libs to LDLIBS,
+# which in turn may be defined in a sub-Makefile
+# e.g.:
+# mm/Makefile
+#	$(OUTPUT)/gup_longterm: LDLIBS += $(IOURING_EXTRA_LIBS)
+l5_tests=$(grep -r --include=Makefile "LDLIBS +=.*\$(IOURING_EXTRA_LIBS)" | \
+	awk -F: '{print $1}' | uniq)
+
+#echo l1_tests $l1_tests
+#echo l2_tests $l2_tests
+#echo l3_tests $l3_tests
+#echo l4_tests $l4_tests
+#echo l5_tests $l5_tests
 
 all_tests
 print_results $1 $2
@@ -166,24 +193,32 @@ all_tests()
 	for test in $l3_tests; do
 		l3_test $test
 	done
+
+	for test in $l4_tests; do
+		l4_test $test
+	done
+
+	for test in $l5_tests; do
+		l5_test $test
+	done
 }
 
 # Use same parsing used for l1_tests and pick libraries this time.
 l1_test()
 {
 	test_libs=$(grep --include=Makefile "^LDLIBS" $test | \
-			grep -v "VAR_LDLIBS" | \
+			grep -v "$filter" | \
 			sed -e 's/\:/ /' | \
 			sed -e 's/+/ /' | cut -d "=" -f 2)
 
 	check_libs $test $test_libs
 }
 
-# Use same parsing used for l2__tests and pick libraries this time.
+# Use same parsing used for l2_tests and pick libraries this time.
 l2_test()
 {
 	test_libs=$(grep --include=Makefile ": LDLIBS" $test | \
-			grep -v "VAR_LDLIBS" | \
+			grep -v "$filter" | \
 			sed -e 's/\:/ /' | sed -e 's/+/ /' | \
 			cut -d "=" -f 2)
 
@@ -199,6 +234,24 @@ l3_test()
 	check_libs $test $test_libs
 }
 
+l4_test()
+{
+	test_libs=$(grep --include=Makefile "^VAR_LDLIBS\|^LDLIBS" $test | \
+			grep "\(pkg-config\|PKG_CONFIG\).*|| echo " | \
+			sed -e 's/.*|| echo //' | sed -e 's/)$//')
+
+	check_libs $test $test_libs
+}
+
+l5_test()
+{
+	tests=$(find $(dirname "$test") -type f -name "*.mk")
+	test_libs=$(grep "^IOURING_EXTRA_LIBS +\?=" $tests | \
+			cut -d "=" -f 2)
+
+	check_libs $test $test_libs
+}
+
 check_libs()
 {
 
-- 
2.40.1

