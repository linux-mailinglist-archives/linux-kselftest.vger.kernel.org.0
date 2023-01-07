Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2C266127D
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 00:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjAGXGv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Jan 2023 18:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGXGu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Jan 2023 18:06:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE52271A2;
        Sat,  7 Jan 2023 15:06:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CBD4BCE0AC8;
        Sat,  7 Jan 2023 23:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BB7C433EF;
        Sat,  7 Jan 2023 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673132806;
        bh=Lludlr5axsj3b5IQ+wjvPk4q6BAf6EJEp6FTXWpxkXI=;
        h=From:To:Cc:Subject:Date:From;
        b=NAJGOpjYDPqzh7Gg3BmBmrTG9L24/44l281SMa6bqXcWeFm0ASTVuFBVQXMrvue8z
         PxxW4QiH9FE+U33YPPpn9WuWBMAm/cFyURtoKTO2gR4xT7fu6gRbWdTGbyYKhjWpbh
         gPn8nLpb1ixsg/q6BxVxy42D2a/cCXJZLlKDSVJXIzb+86NWpG3xOpAtpeQQ9o9TKR
         yw0dn9VjL57Vx1lqlOLkEOGylpwKUglCC0l5LPPshugs//3JEJcOn0IixNjDWiLZ0e
         /e0qQRqxxNsKGauntNZBa5v3ByX4CVrzPVuE9xeI+2k/JN/EJVIpXi6huxHsREkYg8
         Chg/MQ+YTG48A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH mm-unstable] selftests/mm: convert missing vm->mm changes
Date:   Sat,  7 Jan 2023 23:06:43 +0000
Message-Id: <20230107230643.252273-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 6b380799d251 ("selftests/vm: rename selftests/vm to
selftests/mm") in mm-unstable is missing some files that need to be
updated for the renaming.  This commit adds the changes.

Fixes: 6b380799d251 ("selftests/vm: rename selftests/vm to selftests/mm") in mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/Makefile          | 2 +-
 tools/testing/selftests/kselftest_deps.sh | 6 +++---
 tools/testing/selftests/mm/Makefile       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 41b649452560..56a29f2de8e6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -85,7 +85,7 @@ TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += user
 TARGETS += vDSO
-TARGETS += vm
+TARGETS += mm
 TARGETS += x86
 TARGETS += zram
 #Please keep the TARGETS list alphabetically sorted
diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index 7424a1f5babc..4bc14d9e8ff1 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -12,9 +12,9 @@ usage()
 
 echo -e "Usage: $0 -[p] <compiler> [test_name]\n"
 echo -e "\tkselftest_deps.sh [-p] gcc"
-echo -e "\tkselftest_deps.sh [-p] gcc vm"
+echo -e "\tkselftest_deps.sh [-p] gcc mm"
 echo -e "\tkselftest_deps.sh [-p] aarch64-linux-gnu-gcc"
-echo -e "\tkselftest_deps.sh [-p] aarch64-linux-gnu-gcc vm\n"
+echo -e "\tkselftest_deps.sh [-p] aarch64-linux-gnu-gcc mm\n"
 echo "- Should be run in selftests directory in the kernel repo."
 echo "- Checks if Kselftests can be built/cross-built on a system."
 echo "- Parses all test/sub-test Makefile to find library dependencies."
@@ -120,7 +120,7 @@ l1_tests=$(grep -r --include=Makefile "^LDLIBS" | \
 # Level 2
 # Some tests have multiple valid LDLIBS lines for individual sub-tests
 # that need dependency checks. Find them and append them to the tests
-# e.g: vm/Makefile:$(OUTPUT)/userfaultfd: LDLIBS += -lpthread
+# e.g: mm/Makefile:$(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 # Filter out VAR_LDLIBS to discard the following:
 # 	memfd/Makefile:$(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
 # Append space at the end of the list to append more tests.
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 89c14e41bd43..6a4b639b2b2b 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-# Makefile for vm selftests
+# Makefile for mm selftests
 
-LOCAL_HDRS += $(selfdir)/vm/local_config.h $(top_srcdir)/mm/gup_test.h
+LOCAL_HDRS += $(selfdir)/mm/local_config.h $(top_srcdir)/mm/gup_test.h
 
 include local_config.mk
 
-- 
2.25.1

