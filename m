Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1E250ABAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiDUWwy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 18:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391913AbiDUWwb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 18:52:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302B46B09
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 15:49:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4dc56af69so21195687b3.6
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 15:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xa3gPtQxiIaZQi4cOdGfuCjGLSoIDga5By+KnB16kpE=;
        b=WDlmKDHDZdMB81vcHg2wWwoZSgM+ke7xK/5wdN1pMuGhi2snEtkLZRZojK+iBRPim8
         j2+0mQW+4OmahwojdP5OQ9Bbj8QhExOsbr3qCM3HO4JesmgSTyiqJqnaQUlk1fxXIYDq
         eMtNdpAESyzwOwHEP01uBBXFslQy4/EPjk5FrJQ5z86PhWDSqoOA5OyfI7wyu0Iwd0Z2
         CZIB3lS9ph+NQvfYLwZ0w4NhZI6PRNorTGePhPTk9SpAoDEysEFQOYIvUYIjI5yH02dF
         0qQfaKFYxHfeKQk035UW+lrYG5/G2ok2BQt4OI3iVW5xNSv67TCS8nig7Ddiqn9vC776
         +fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xa3gPtQxiIaZQi4cOdGfuCjGLSoIDga5By+KnB16kpE=;
        b=z9rw2n9qNKvr+8ZDuxJ3XOE2qmmqP/5RzxXMJLyRyITLo1aIE/tQ4n+JvhRccUoEix
         6WwKGMw+Au4xE2rPPCKIwCE01gxoPdjfrYSLwwS7cmdI6Rvzdj2Zw0pRuT/6clxVTDSa
         6z9OVQQCayEQozXipB7FVDaa7QpOpAMWusyoXPpUqH8hh5YsjvwPT62OBnKjQHIpLJo0
         WheO885N02DRpSUjcEupcMBp3aHZ8UmcFnFe/lJDMyplQ6p6QkQy2QJIMjUiHAw0dUxN
         CxDtoF0ybf3vJs04X1+H5NlqiKUZp4eiD2o4pZpCA9D47Sk7c7ydgErMUPdX38S3HI0T
         p9nw==
X-Gm-Message-State: AOAM530xtdaCVQimbZfPwm11IhGIl735AWiu5USzN+Jk/gUHZCHFrvi8
        Ry90iBeqN92OBra7Jr/YY/WruJmP9/XEEvpQnsX2
X-Google-Smtp-Source: ABdhPJyTTCf2svggIwr9nVzNCUTwcDrim/NzWmwq3A8at+Bmgx+n1PF/K5eXW8gfPrSMeg8bcOnzbQUvmcRh2a6eONb+
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1cc4:3b55:a67d:61fa])
 (user=axelrasmussen job=sendgmr) by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP
 id g14-20020a5b024e000000b0063dcba03d55mr1880487ybp.613.1650581378449; Thu,
 21 Apr 2022 15:49:38 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:49:28 -0700
In-Reply-To: <20220421224928.1848230-1-axelrasmussen@google.com>
Message-Id: <20220421224928.1848230-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220421224928.1848230-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 2/2] selftests: vm: fix shellcheck warnings in run_vmtests.sh
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These might not be issues yet, but they make the script more fragile.
Also by fixing them we give a better example to future readers, who
might copy/paste or otherwise re-use snippets from our script.

- Use "read -r", since we don't ever want read to be interpreting '\'
  characters as escape sequences...
- Quote variables, to deal with spaces properly.
- Use $() instead of the older and harder-to-nest ``.
- Get rid of superfluous "$" prefixes inside arithmetic $(()).

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 55 +++++++++++------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 2d5a3da42cbe..a2302b5faaf2 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -9,12 +9,12 @@ mnt=./huge
 exitcode=0
 
 #get huge pagesize and freepages from /proc/meminfo
-while read name size unit; do
+while read -r name size unit; do
 	if [ "$name" = "HugePages_Free:" ]; then
-		freepgs=$size
+		freepgs="$size"
 	fi
 	if [ "$name" = "Hugepagesize:" ]; then
-		hpgsize_KB=$size
+		hpgsize_KB="$size"
 	fi
 done < /proc/meminfo
 
@@ -30,27 +30,26 @@ needmem_KB=$((half_ufd_size_MB * 2 * 1024))
 
 #set proper nr_hugepages
 if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
-	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
+	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
 	needpgs=$((needmem_KB / hpgsize_KB))
 	tries=2
-	while [ $tries -gt 0 ] && [ $freepgs -lt $needpgs ]; do
-		lackpgs=$(( $needpgs - $freepgs ))
+	while [ "$tries" -gt 0 ] && [ "$freepgs" -lt "$needpgs" ]; do
+		lackpgs=$((needpgs - freepgs))
 		echo 3 > /proc/sys/vm/drop_caches
-		echo $(( $lackpgs + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
-		if [ $? -ne 0 ]; then
+		if ! echo $((lackpgs + nr_hugepgs)) > /proc/sys/vm/nr_hugepages; then
 			echo "Please run this test as root"
 			exit $ksft_skip
 		fi
-		while read name size unit; do
+		while read -r name size unit; do
 			if [ "$name" = "HugePages_Free:" ]; then
 				freepgs=$size
 			fi
 		done < /proc/meminfo
 		tries=$((tries - 1))
 	done
-	if [ $freepgs -lt $needpgs ]; then
+	if [ "$freepgs" -lt "$needpgs" ]; then
 		printf "Not enough huge pages available (%d < %d)\n" \
-		       $freepgs $needpgs
+		       "$freepgs" "$needpgs"
 		exit 1
 	fi
 else
@@ -60,11 +59,11 @@ fi
 
 #filter 64bit architectures
 ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64"
-if [ -z $ARCH ]; then
-  ARCH=`uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/'`
+if [ -z "$ARCH" ]; then
+	ARCH=$(uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/')
 fi
 VADDR64=0
-echo "$ARCH64STR" | grep $ARCH && VADDR64=1
+echo "$ARCH64STR" | grep "$ARCH" && VADDR64=1
 
 # Usage: run_test [test binary] [arbitrary test arguments...]
 run_test() {
@@ -85,28 +84,28 @@ run_test() {
 	fi
 }
 
-mkdir $mnt
-mount -t hugetlbfs none $mnt
+mkdir "$mnt"
+mount -t hugetlbfs none "$mnt"
 
 run_test ./hugepage-mmap
 
-shmmax=`cat /proc/sys/kernel/shmmax`
-shmall=`cat /proc/sys/kernel/shmall`
+shmmax=$(cat /proc/sys/kernel/shmmax)
+shmall=$(cat /proc/sys/kernel/shmall)
 echo 268435456 > /proc/sys/kernel/shmmax
 echo 4194304 > /proc/sys/kernel/shmall
 run_test ./hugepage-shm
-echo $shmmax > /proc/sys/kernel/shmmax
-echo $shmall > /proc/sys/kernel/shmall
+echo "$shmmax" > /proc/sys/kernel/shmmax
+echo "$shmall" > /proc/sys/kernel/shmall
 
 run_test ./map_hugetlb
 
-run_test ./hugepage-mremap $mnt/huge_mremap
-rm -f $mnt/huge_mremap
+run_test ./hugepage-mremap "$mnt"/huge_mremap
+rm -f "$mnt"/huge_mremap
 
 run_test ./hugepage-vmemmap
 
-run_test ./hugetlb-madvise $mnt/madvise-test
-rm -f $mnt/madvise-test
+run_test ./hugetlb-madvise "$mnt"/madvise-test
+rm -f "$mnt"/madvise-test
 
 echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
 echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
@@ -124,13 +123,13 @@ run_test ./gup_test -ct -F 0x1 0 19 0x1000
 run_test ./userfaultfd anon 20 16
 # Test requires source and destination huge pages.  Size of source
 # (half_ufd_size_MB) is passed as argument to test.
-run_test ./userfaultfd hugetlb $half_ufd_size_MB 32
+run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
 run_test ./userfaultfd shmem 20 16
 
 #cleanup
-umount $mnt
-rm -rf $mnt
-echo $nr_hugepgs > /proc/sys/vm/nr_hugepages
+umount "$mnt"
+rm -rf "$mnt"
+echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 run_test ./compaction_test
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

