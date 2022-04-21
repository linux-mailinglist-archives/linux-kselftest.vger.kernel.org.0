Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4250ABA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392175AbiDUWwy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 18:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiDUWw3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 18:52:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AFE4665E
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 15:49:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f198b4e2d1so55828277b3.14
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jRWNqLhw2w7ZAHaPR+8B2mIeeXgTNSCrfvXV9epbNjA=;
        b=q7YY2SxW0goK5iTXXzkjQdvW5XDzxRBkqacSAKIwlHbp4Mth/fn7iWqLglCOKhV1oC
         IVQGYIkUd2UoVWfZOFA4R1Ttkslwk0/pk45OnOX0+3JT1JCeha83uWvs8/md+E6AVFUG
         wyFqz19lQbI3ky1HSQS++ZmtWv//QWq9hoDHulh1gVxci766MuCZDqCMpGybvcncmxr6
         EH9xvzTM7orYyIQDPBSOMqAJ0AUoD6kVEW9f3uHiw6dwMu+IpSiJuehExsn+6aCm+qIZ
         0lvm+rtan7RX32IAYF+op7UNF0k+MpNdosrByClXsKVeDodqgIpHSjiGdlyvpa5iKsbY
         EB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jRWNqLhw2w7ZAHaPR+8B2mIeeXgTNSCrfvXV9epbNjA=;
        b=elpx0K1HFzo6wIH9phx8lNiq9frFtWPSi0gBRckbICB49EQSVp/0pnWc/1i8LCtvda
         wrmmjzWfzYChVu9+hKQ8uKqs4kpK6B2BBxN2mrdzA/77IC0bqe9qNdPNCXpsfWS2YYL9
         ldLB3YRsmX7K+gdjQ7tBGwpJFxaM7KyNIaV89Kw5hNIsWDSh1OS9M0hcfcuXi+YbRf9C
         A1AiKyujSeyapX79SwssbZseFz8CBPy+qs9nxbWBBL35+BQ4Hiaqrv/IiIww7UJh3Rqc
         fsFTSbDwI9o1atCY7vfdk6xCalx+v/g6xA7QdO8KjS/l8ADpG8Ldi1Z3muknwux4Pdsk
         eJEw==
X-Gm-Message-State: AOAM530EtDlYIWczWfNAdeafdlGu0C/cF84eojCMT2TqnslcA/hiLPxf
        guijfSnZ3MWtd4u8lYMwzph1byFpkj365N3h0CqE
X-Google-Smtp-Source: ABdhPJwPdlv8Tni9uH0IrSxEybwjwaLW0eucPOnBd8tV28fysDg/FOdBgy7SlxGFTAabdsWuTX09wAOCkKH/ogXFmvD1
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:1cc4:3b55:a67d:61fa])
 (user=axelrasmussen job=sendgmr) by 2002:a0d:d9cf:0:b0:2ef:5421:430f with
 SMTP id b198-20020a0dd9cf000000b002ef5421430fmr2078403ywe.312.1650581376051;
 Thu, 21 Apr 2022 15:49:36 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:49:27 -0700
Message-Id: <20220421224928.1848230-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 1/2] selftests: vm: refactor run_vmtests.sh to reduce boilerplate
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

Previously, each test printed out its own header, dealt with its own
return code, etc. By just putting this standard stuff in a function, we
can delete > 300 lines from the script.

This also makes adding future tests easier. And, it gets rid of various
inconsistencies that already exist:

- Some tests correctly deal with ksft_skip, but others don't.
- Some tests just print the executable name, others print arguments, and
  yet others print some comment in the header.
- Most tests print out a header with two separator lines, but not the
  HMM smoke test or the memfd_secret test, which only print one.
- We had a redundant "exit" at the end, with all the boilerplate it's an
  easy oversight.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 459 +++-------------------
 1 file changed, 64 insertions(+), 395 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 3b265f140c25..2d5a3da42cbe 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -66,447 +66,116 @@ fi
 VADDR64=0
 echo "$ARCH64STR" | grep $ARCH && VADDR64=1
 
+# Usage: run_test [test binary] [arbitrary test arguments...]
+run_test() {
+	local title="running $*"
+	local sep=$(echo -n "$title" | tr "[:graph:][:space:]" -)
+	printf "%s\n%s\n%s\n" "$sep" "$title" "$sep"
+
+	"$@"
+	local ret=$?
+	if [ $ret -eq 0 ]; then
+		echo "[PASS]"
+	elif [ $ret -eq $ksft_skip ]; then
+		echo "[SKIP]"
+		exitcode=$ksft_skip
+	else
+		echo "[FAIL]"
+		exitcode=1
+	fi
+}
+
 mkdir $mnt
 mount -t hugetlbfs none $mnt
 
-echo "---------------------"
-echo "running hugepage-mmap"
-echo "---------------------"
-./hugepage-mmap
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./hugepage-mmap
 
 shmmax=`cat /proc/sys/kernel/shmmax`
 shmall=`cat /proc/sys/kernel/shmall`
 echo 268435456 > /proc/sys/kernel/shmmax
 echo 4194304 > /proc/sys/kernel/shmall
-echo "--------------------"
-echo "running hugepage-shm"
-echo "--------------------"
-./hugepage-shm
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./hugepage-shm
 echo $shmmax > /proc/sys/kernel/shmmax
 echo $shmall > /proc/sys/kernel/shmall
 
-echo "-------------------"
-echo "running map_hugetlb"
-echo "-------------------"
-./map_hugetlb
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./map_hugetlb
 
-echo "-----------------------"
-echo "running hugepage-mremap"
-echo "-----------------------"
-./hugepage-mremap $mnt/huge_mremap
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./hugepage-mremap $mnt/huge_mremap
 rm -f $mnt/huge_mremap
 
-echo "------------------------"
-echo "running hugepage-vmemmap"
-echo "------------------------"
-./hugepage-vmemmap
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./hugepage-vmemmap
 
-echo "-----------------------"
-echo "running hugetlb-madvise"
-echo "-----------------------"
-./hugetlb-madvise $mnt/madvise-test
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./hugetlb-madvise $mnt/madvise-test
 rm -f $mnt/madvise-test
 
 echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
 echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
 echo "      hugetlb regression testing."
 
-echo "---------------------------"
-echo "running map_fixed_noreplace"
-echo "---------------------------"
-./map_fixed_noreplace
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
-
-echo "------------------------------------------------------"
-echo "running: gup_test -u # get_user_pages_fast() benchmark"
-echo "------------------------------------------------------"
-./gup_test -u
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./map_fixed_noreplace
 
-echo "------------------------------------------------------"
-echo "running: gup_test -a # pin_user_pages_fast() benchmark"
-echo "------------------------------------------------------"
-./gup_test -a
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+# get_user_pages_fast() benchmark
+run_test ./gup_test -u
+# pin_user_pages_fast() benchmark
+run_test ./gup_test -a
+# Dump pages 0, 19, and 4096, using pin_user_pages:
+run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
-echo "------------------------------------------------------------"
-echo "# Dump pages 0, 19, and 4096, using pin_user_pages:"
-echo "running: gup_test -ct -F 0x1 0 19 0x1000 # dump_page() test"
-echo "------------------------------------------------------------"
-./gup_test -ct -F 0x1 0 19 0x1000
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
-
-echo "-------------------"
-echo "running userfaultfd"
-echo "-------------------"
-./userfaultfd anon 20 16
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
-
-echo "---------------------------"
-echo "running userfaultfd_hugetlb"
-echo "---------------------------"
+run_test ./userfaultfd anon 20 16
 # Test requires source and destination huge pages.  Size of source
 # (half_ufd_size_MB) is passed as argument to test.
-./userfaultfd hugetlb $half_ufd_size_MB 32
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
-
-echo "-------------------------"
-echo "running userfaultfd_shmem"
-echo "-------------------------"
-./userfaultfd shmem 20 16
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./userfaultfd hugetlb $half_ufd_size_MB 32
+run_test ./userfaultfd shmem 20 16
 
 #cleanup
 umount $mnt
 rm -rf $mnt
 echo $nr_hugepgs > /proc/sys/vm/nr_hugepages
 
-echo "-----------------------"
-echo "running compaction_test"
-echo "-----------------------"
-./compaction_test
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./compaction_test
 
-echo "----------------------"
-echo "running on-fault-limit"
-echo "----------------------"
-sudo -u nobody ./on-fault-limit
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test sudo -u nobody ./on-fault-limit
 
-echo "--------------------"
-echo "running map_populate"
-echo "--------------------"
-./map_populate
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./map_populate
 
-echo "-------------------------"
-echo "running mlock-random-test"
-echo "-------------------------"
-./mlock-random-test
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./mlock-random-test
 
-echo "--------------------"
-echo "running mlock2-tests"
-echo "--------------------"
-./mlock2-tests
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./mlock2-tests
 
-echo "-------------------"
-echo "running mremap_test"
-echo "-------------------"
-./mremap_test
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./mremap_test
 
-echo "-----------------"
-echo "running thuge-gen"
-echo "-----------------"
-./thuge-gen
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+run_test ./thuge-gen
 
 if [ $VADDR64 -ne 0 ]; then
-echo "-----------------------------"
-echo "running virtual_address_range"
-echo "-----------------------------"
-./virtual_address_range
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	exitcode=1
-else
-	echo "[PASS]"
-fi
+	run_test ./virtual_address_range
 
-echo "-----------------------------"
-echo "running virtual address 128TB switch test"
-echo "-----------------------------"
-./va_128TBswitch
-if [ $? -ne 0 ]; then
-    echo "[FAIL]"
-    exitcode=1
-else
-    echo "[PASS]"
-fi
+	# virtual address 128TB switch test
+	run_test ./va_128TBswitch
 fi # VADDR64
 
-echo "------------------------------------"
-echo "running vmalloc stability smoke test"
-echo "------------------------------------"
-./test_vmalloc.sh smoke
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
-
-echo "------------------------------------"
-echo "running MREMAP_DONTUNMAP smoke test"
-echo "------------------------------------"
-./mremap_dontunmap
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
-
-echo "running HMM smoke test"
-echo "------------------------------------"
-./test_hmm.sh smoke
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	echo "[SKIP]"
-	exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
-
-echo "--------------------------------------------------------"
-echo "running MADV_POPULATE_READ and MADV_POPULATE_WRITE tests"
-echo "--------------------------------------------------------"
-./madv_populate
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	echo "[SKIP]"
-	exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
-
-echo "running memfd_secret test"
-echo "------------------------------------"
-./memfd_secret
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	echo "[SKIP]"
-	exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
-
-echo "-------------------------------------------------------"
-echo "running KSM MADV_MERGEABLE test with 10 identical pages"
-echo "-------------------------------------------------------"
-./ksm_tests -M -p 10
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
-
-echo "------------------------"
-echo "running KSM unmerge test"
-echo "------------------------"
-./ksm_tests -U
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
+# vmalloc stability smoke test
+run_test ./test_vmalloc.sh smoke
 
-echo "----------------------------------------------------------"
-echo "running KSM test with 10 zero pages and use_zero_pages = 0"
-echo "----------------------------------------------------------"
-./ksm_tests -Z -p 10 -z 0
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
+run_test ./mremap_dontunmap
 
-echo "----------------------------------------------------------"
-echo "running KSM test with 10 zero pages and use_zero_pages = 1"
-echo "----------------------------------------------------------"
-./ksm_tests -Z -p 10 -z 1
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
+run_test ./test_hmm.sh smoke
 
-echo "-------------------------------------------------------------"
-echo "running KSM test with 2 NUMA nodes and merge_across_nodes = 1"
-echo "-------------------------------------------------------------"
-./ksm_tests -N -m 1
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
+# MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
+run_test ./madv_populate
 
-echo "-------------------------------------------------------------"
-echo "running KSM test with 2 NUMA nodes and merge_across_nodes = 0"
-echo "-------------------------------------------------------------"
-./ksm_tests -N -m 0
-ret_val=$?
-
-if [ $ret_val -eq 0 ]; then
-	echo "[PASS]"
-elif [ $ret_val -eq $ksft_skip ]; then
-	 echo "[SKIP]"
-	 exitcode=$ksft_skip
-else
-	echo "[FAIL]"
-	exitcode=1
-fi
+run_test ./memfd_secret
 
-exit $exitcode
+# KSM MADV_MERGEABLE test with 10 identical pages
+run_test ./ksm_tests -M -p 10
+# KSM unmerge test
+run_test ./ksm_tests -U
+# KSM test with 10 zero pages and use_zero_pages = 0
+run_test ./ksm_tests -Z -p 10 -z 0
+# KSM test with 10 zero pages and use_zero_pages = 1
+run_test ./ksm_tests -Z -p 10 -z 1
+# KSM test with 2 NUMA nodes and merge_across_nodes = 1
+run_test ./ksm_tests -N -m 1
+# KSM test with 2 NUMA nodes and merge_across_nodes = 0
+run_test ./ksm_tests -N -m 0
 
 exit $exitcode
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

