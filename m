Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A244B784BCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 23:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjHVVLp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHVVLo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 17:11:44 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F03CD7;
        Tue, 22 Aug 2023 14:11:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bd0911c95dso3761132a34.3;
        Tue, 22 Aug 2023 14:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692738702; x=1693343502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hmmfZRodgVUziWT2rRNyCsKFK03wrrtMH6RFV4QrmY=;
        b=UqUEI3OMZNGYZ1aL5oP7vcxf4qLZbnMEJSt1/rwVfbiCMKA2VKLEQaQR8VG91drnu8
         DO+0hY1KP4rcGzpP6HB/bmuKQmmwwkojJnc77G6NQGVbM5Pn967VFo6zX/D4hMZ8H001
         iCoV6JW4N+bfxNC6heqlpuCR4ir7bWmnf4fSHtFpXKB3OibDihvhvB/MVqOE0kfdBmCu
         aL3UTZ1ySL/xA//ThQBNanra/65VqllNQFfJE8qs7mR7hgJQK9odY8jikNYzK2oDL78K
         JS/ZuSVesD3Bp85htcK4H/yHuJ9X/6fAE/vZh39cuEgOpQvZdtqdhx//9NA/ZJhd+cVB
         He9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692738702; x=1693343502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hmmfZRodgVUziWT2rRNyCsKFK03wrrtMH6RFV4QrmY=;
        b=GCqbE/n2+lXpSkgbKmAQWvJiySxkvnpYvbC6WAjz64vgjMUs/N1qI7nXOJ5vRJ/l4X
         t/wsitzUhuJiynn5RfIlLv43+cp3TJCM6ulL3Ji+OfpXOCWamwPj0QbSdamPv/0mJea7
         B7Jw7XRfZL90y0oPh1dw1xIe9I9MYtOrV58qPCIpCRIBj5HhPgxPscmRvVfAlHnnft3e
         lO9DdgzO0cLQk27/why76i7TUhKeULxA2qOovUIG5WZQflFk2ZDI33fjeTodaf6fnE22
         qgf6TyllbFmfloxdbEgqANRH/mrLhpu8T0Y1iJ6z7qU2YgcWgISyim6n1au+pkj3n0Xh
         ZxMQ==
X-Gm-Message-State: AOJu0YxShVIDN6AOZ22Ds+wLFtLQFpSEDukZ8fQ6vy6iU5UyU3b5PzHQ
        8pW6MfPEN0MDeENUs8OcXuDUfR7Tx89+y+Yi
X-Google-Smtp-Source: AGHT+IFF89IwZJQid3LfAPyFwS4w8gxatZJVKm3YeRg+V0F22TVIIacK8pU8cG3Ix9jYDnnQLBgpVA==
X-Received: by 2002:a05:6830:609:b0:6b9:2b25:459c with SMTP id w9-20020a056830060900b006b92b25459cmr12099312oti.28.1692738702243;
        Tue, 22 Aug 2023 14:11:42 -0700 (PDT)
Received: from debian.lan ([168.227.196.240])
        by smtp.gmail.com with ESMTPSA id q5-20020a9d4b05000000b006b871010cb1sm5084233otf.46.2023.08.22.14.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:11:41 -0700 (PDT)
From:   "Ricardo B. Marliere" <rbmarliere@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Ricardo B. Marliere" <rbmarliere@gmail.com>
Subject: [PATCH] selftests: fix dependency checker script
Date:   Tue, 22 Aug 2023 18:09:40 -0300
Message-Id: <20230822210939.69767-1-rbmarliere@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch fixes inconsistencies in the parsing rules of the levels 1
and 2 of the kselftest_deps.sh.  It was added the levels 4 and 5 to
account for a few edge cases that are present in some tests, also some
minor identation styling have been fixed (s/    /\t/g).

Signed-off-by: Ricardo B. Marliere <rbmarliere@gmail.com>
---
 tools/testing/selftests/kselftest_deps.sh | 77 +++++++++++++++++++----
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index 4bc14d9e8ff1..de59cc8f03c3 100755
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
 targets=$(grep -E "^TARGETS +|^TARGETS =" Makefile | cut -d "=" -f2)
 
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
 # memfd and others use pkg-config to find mount and fuse libs
@@ -138,11 +144,32 @@ l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
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
@@ -164,24 +191,32 @@ all_tests()
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
 
@@ -197,6 +232,24 @@ l3_test()
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

