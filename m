Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD09360327E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Oct 2022 20:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJRSar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Oct 2022 14:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJRSai (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Oct 2022 14:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81C39FE0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Oct 2022 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666117835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6FF6uL+/8Zb/SiyE1cZnYTZq57X/KACUjTjY7XPNvsw=;
        b=gNiOnWxkbDBB236bMVwrgI3hgHJeyck642kvQ/TVbTxpjWZSwX3jqQl7ET01bIUQKtB3s+
        NzZt1j/Ei7BV4i8yYXKmjMw2i7BTlTavrj9/5IGfD2a3XnFIal7KqZ5mvLc0/LLMy32cHX
        qf4DIGJzP8amplhY1424lB2Vsv+vYPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-1YQ1oEZ1N0SgU2_9O7Fc3w-1; Tue, 18 Oct 2022 14:30:32 -0400
X-MC-Unique: 1YQ1oEZ1N0SgU2_9O7Fc3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2385580280D;
        Tue, 18 Oct 2022 18:30:32 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.18.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C680340C2064;
        Tue, 18 Oct 2022 18:30:31 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-next@vger.kernel.org,
        Nico Pache <npache@redhat.com>
Subject: [PATCH v6] selftests/vm: enable running select groups of tests
Date:   Tue, 18 Oct 2022 14:30:21 -0400
Message-Id: <20221018183021.1832032-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Our memory management kernel CI testing at Red Hat uses the VM
selftests and we have run into two problems:

First, our LTP tests overlap with the VM selftests.

We want to avoid unhelpful redundancy in our testing practices.

Second, we have observed the current run_vmtests.sh to report overall
failure/ambiguous results in the case that a machine lacks the necessary
hardware to perform one or more of the tests. E.g. ksm tests that
require more than one numa node.

We want to be able to run the vm selftests suitable to particular hardware.

Add the ability to run one or more groups of vm tests via run_vmtests.sh
instead of simply all-or-none in order to solve these problems.

Preserve existing default behavior of running all tests when the script
is invoked with no arguments.

Documentation of test groups is included in the patch as follows:

    # ./run_vmtests.sh [ -h || --help ]

    usage: ./tools/testing/selftests/vm/run_vmtests.sh [ -h | -t "<categories>"]
      -t: specify specific categories to tests to run
      -h: display this message

    The default behavior is to run all tests.

    Alternatively, specific groups tests can be run by passing a string
    to the -t argument containing one or more of the following categories
    separated by spaces:
    - mmap
	    tests for mmap(2)
    - gup_test
	    tests for gup using gup_test interface
    - userfaultfd
	    tests for  userfaultfd(2)
    - compaction
	    a test for the patch "Allow compaction of unevictable pages"
    - mlock
	    tests for mlock(2)
    - mremap
	    tests for mremap(2)
    - hugevm
	    tests for very large virtual address space
    - vmalloc
	    vmalloc smoke tests
    - hmm
	    hmm smoke tests
    - madv_populate
	    test memadvise(2) MADV_POPULATE_{READ,WRITE} options
    - memfd_secret
	    test memfd_secret(2)
    - process_mrelease
	    test process_mrelease(2)
    - ksm
	    ksm tests that do not require >=2 NUMA nodes
    - ksm_numa
	    ksm tests that require >=2 NUMA nodes
    - pkey
	    memory protection key tests
    example: ./run_vmtests.sh -t "hmm mmap ksm"

Changes from v5:
	- rebase onto mainline master branch
	- integrate changes to pkey and userfaultfd invocation sites
Changes from v4:
	- fix imprecise checking in test_selected
	- drop conditional setup/cleanup of hugetlb

Changes from v3:
	- rename variable TEST_ITEMS as VM_TEST_ITEMS

Changes from v2:
	- rebase onto the mm-everyting branch in
	https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
	- integrate this functionality with new the tests

Changes from v1:
	- use a command line argument to pass the test categories to the
	  script instead of an environmet variable
	- remove novel prints to avoid messing with extant parsers of this
	  script
	- update the usage text

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 212 +++++++++++++++-------
 1 file changed, 144 insertions(+), 68 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e780e76c26b8..4a2f2e331105 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-#please run as root
+# Please run as root
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -8,15 +8,76 @@ ksft_skip=4
 mnt=./huge
 exitcode=0
 
-#get huge pagesize and freepages from /proc/meminfo
-while read -r name size unit; do
-	if [ "$name" = "HugePages_Free:" ]; then
-		freepgs="$size"
+usage() {
+	cat <<EOF
+usage: ${BASH_SOURCE[0]:-$0} [ -h | -t "<categories>"]
+  -t: specify specific categories to tests to run
+  -h: display this message
+
+The default behavior is to run all tests.
+
+Alternatively, specific groups tests can be run by passing a string
+to the -t argument containing one or more of the following categories
+separated by spaces:
+- mmap
+	tests for mmap(2)
+- gup_test
+	tests for gup using gup_test interface
+- userfaultfd
+	tests for  userfaultfd(2)
+- compaction
+	a test for the patch "Allow compaction of unevictable pages"
+- mlock
+	tests for mlock(2)
+- mremap
+	tests for mremap(2)
+- hugevm
+	tests for very large virtual address space
+- vmalloc
+	vmalloc smoke tests
+- hmm
+	hmm smoke tests
+- madv_populate
+	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
+- memfd_secret
+	test memfd_secret(2)
+- process_mrelease
+	test process_mrelease(2)
+- ksm
+	ksm tests that do not require >=2 NUMA nodes
+- ksm_numa
+	ksm tests that require >=2 NUMA nodes
+- pkey
+	memory protection key tests
+example: ./run_vmtests.sh -t "hmm mmap ksm"
+EOF
+	exit 0
+}
+
+
+while getopts "ht:" OPT; do
+	case ${OPT} in
+		"h") usage ;;
+		"t") VM_SELFTEST_ITEMS=${OPTARG} ;;
+	esac
+done
+shift $((OPTIND -1))
+
+# default behavior: run all tests
+VM_SELFTEST_ITEMS=${VM_SELFTEST_ITEMS:-default}
+
+test_selected() {
+	if [ "$VM_SELFTEST_ITEMS" == "default" ]; then
+		# If no VM_SELFTEST_ITEMS are specified, run all tests
+		return 0
 	fi
-	if [ "$name" = "Hugepagesize:" ]; then
-		hpgsize_KB="$size"
+	# If test selected argument is one of the test items
+	if [[ " ${VM_SELFTEST_ITEMS[*]} " =~ " ${1} " ]]; then
+	        return 0
+	else
+	        return 1
 	fi
-done < /proc/meminfo
+}
 
 # Simple hugetlbfs tests have a hardcoded minimum requirement of
 # huge pages totaling 256MB (262144KB) in size.  The userfaultfd
@@ -28,7 +89,17 @@ hpgsize_MB=$((hpgsize_KB / 1024))
 half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))
 needmem_KB=$((half_ufd_size_MB * 2 * 1024))
 
-#set proper nr_hugepages
+# get huge pagesize and freepages from /proc/meminfo
+while read -r name size unit; do
+	if [ "$name" = "HugePages_Free:" ]; then
+		freepgs="$size"
+	fi
+	if [ "$name" = "Hugepagesize:" ]; then
+		hpgsize_KB="$size"
+	fi
+done < /proc/meminfo
+
+# set proper nr_hugepages
 if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
 	needpgs=$((needmem_KB / hpgsize_KB))
@@ -57,78 +128,83 @@ else
 	exit 1
 fi
 
-#filter 64bit architectures
+# filter 64bit architectures
 ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64"
 if [ -z "$ARCH" ]; then
 	ARCH=$(uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/')
 fi
 VADDR64=0
-echo "$ARCH64STR" | grep "$ARCH" && VADDR64=1
+echo "$ARCH64STR" | grep "$ARCH" &>/dev/null && VADDR64=1
 
 # Usage: run_test [test binary] [arbitrary test arguments...]
 run_test() {
-	local title="running $*"
-	local sep=$(echo -n "$title" | tr "[:graph:][:space:]" -)
-	printf "%s\n%s\n%s\n" "$sep" "$title" "$sep"
-
-	"$@"
-	local ret=$?
-	if [ $ret -eq 0 ]; then
-		echo "[PASS]"
-	elif [ $ret -eq $ksft_skip ]; then
-		echo "[SKIP]"
-		exitcode=$ksft_skip
-	else
-		echo "[FAIL]"
-		exitcode=1
-	fi
+	if test_selected ${CATEGORY}; then
+		echo "running: $1"
+		local title="running $*"
+		local sep=$(echo -n "$title" | tr "[:graph:][:space:]" -)
+		printf "%s\n%s\n%s\n" "$sep" "$title" "$sep"
+
+		"$@"
+		local ret=$?
+		if [ $ret -eq 0 ]; then
+			echo "[PASS]"
+		elif [ $ret -eq $ksft_skip ]; then
+			echo "[SKIP]"
+			exitcode=$ksft_skip
+		else
+			echo "[FAIL]"
+			exitcode=1
+		fi
+	fi # test_selected
 }
 
 mkdir "$mnt"
 mount -t hugetlbfs none "$mnt"
 
-run_test ./hugepage-mmap
+CATEGORY="hugetlb" run_test ./hugepage-mmap
 
 shmmax=$(cat /proc/sys/kernel/shmmax)
 shmall=$(cat /proc/sys/kernel/shmall)
 echo 268435456 > /proc/sys/kernel/shmmax
 echo 4194304 > /proc/sys/kernel/shmall
-run_test ./hugepage-shm
+CATEGORY="hugetlb" run_test ./hugepage-shm
 echo "$shmmax" > /proc/sys/kernel/shmmax
 echo "$shmall" > /proc/sys/kernel/shmall
 
-run_test ./map_hugetlb
+CATEGORY="hugetlb" run_test ./map_hugetlb
 
-run_test ./hugepage-mremap "$mnt"/huge_mremap
-rm -f "$mnt"/huge_mremap
+CATEGORY="hugetlb" run_test ./hugepage-mremap "$mnt"/huge_mremap
+test_selected "hugetlb" && rm -f "$mnt"/huge_mremap
 
-run_test ./hugepage-vmemmap
+CATEGORY="hugetlb" run_test ./hugepage-vmemmap
 
-run_test ./hugetlb-madvise "$mnt"/madvise-test
-rm -f "$mnt"/madvise-test
+CATEGORY="hugetlb" run_test ./hugetlb-madvise "$mnt"/madvise-test
+test_selected "hugetlb" && rm -f "$mnt"/madvise-test
 
-echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
-echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
-echo "      hugetlb regression testing."
+if test_selected "hugetlb"; then
+	echo "NOTE: These hugetlb tests provide minimal coverage.  Use"
+	echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
+	echo "      hugetlb regression testing."
+fi
 
-run_test ./map_fixed_noreplace
+CATEGORY="mmap" run_test ./map_fixed_noreplace
 
 # get_user_pages_fast() benchmark
-run_test ./gup_test -u
+CATEGORY="gup_test" run_test ./gup_test -u
 # pin_user_pages_fast() benchmark
-run_test ./gup_test -a
+CATEGORY="gup_test" run_test ./gup_test -a
 # Dump pages 0, 19, and 4096, using pin_user_pages:
-run_test ./gup_test -ct -F 0x1 0 19 0x1000
+CATEGORY="gup_test" run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
 uffd_mods=("" ":dev")
 for mod in "${uffd_mods[@]}"; do
-	run_test ./userfaultfd anon${mod} 20 16
+	CATEGORY="userfaultfd" run_test ./userfaultfd anon${mod} 20 16
 	# Hugetlb tests require source and destination huge pages. Pass in half
 	# the size ($half_ufd_size_MB), which is used for *each*.
-	run_test ./userfaultfd hugetlb${mod} "$half_ufd_size_MB" 32
-	run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32 "$mnt"/uffd-test
+	CATEGORY="userfaultfd" run_test ./userfaultfd hugetlb${mod} "$half_ufd_size_MB" 32
+	CATEGORY="userfaultfd" run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32 "$mnt"/uffd-test
 	rm -f "$mnt"/uffd-test
-	run_test ./userfaultfd shmem${mod} 20 16
+	CATEGORY="userfaultfd" run_test ./userfaultfd shmem${mod} 20 16
 done
 
 #cleanup
@@ -136,63 +212,63 @@ umount "$mnt"
 rm -rf "$mnt"
 echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
-run_test ./compaction_test
+CATEGORY="compaction" run_test ./compaction_test
 
-run_test sudo -u nobody ./on-fault-limit
+CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
 
-run_test ./map_populate
+CATEGORY="mmap" run_test ./map_populate
 
-run_test ./mlock-random-test
+CATEGORY="mlock" run_test ./mlock-random-test
 
-run_test ./mlock2-tests
+CATEGORY="mlock" run_test ./mlock2-tests
 
-run_test ./mrelease_test
+CATEGORY="process_mrelease" run_test ./mrelease_test
 
-run_test ./mremap_test
+CATEGORY="mremap" run_test ./mremap_test
 
-run_test ./thuge-gen
+CATEGORY="hugetlb" run_test ./thuge-gen
 
 if [ $VADDR64 -ne 0 ]; then
-	run_test ./virtual_address_range
+	CATEGORY="hugevm" run_test ./virtual_address_range
 
 	# virtual address 128TB switch test
-	run_test ./va_128TBswitch.sh
+	CATEGORY="hugevm" run_test ./va_128TBswitch.sh
 fi # VADDR64
 
 # vmalloc stability smoke test
-run_test ./test_vmalloc.sh smoke
+CATEGORY="vmalloc" run_test ./test_vmalloc.sh smoke
 
-run_test ./mremap_dontunmap
+CATEGORY="mremap" run_test ./mremap_dontunmap
 
-run_test ./test_hmm.sh smoke
+CATEGORY="hmm" run_test ./test_hmm.sh smoke
 
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
-run_test ./madv_populate
+CATEGORY="madv_populate" run_test ./madv_populate
 
-run_test ./memfd_secret
+CATEGORY="memfd_secret" run_test ./memfd_secret
 
 # KSM MADV_MERGEABLE test with 10 identical pages
-run_test ./ksm_tests -M -p 10
+CATEGORY="ksm" run_test ./ksm_tests -M -p 10
 # KSM unmerge test
-run_test ./ksm_tests -U
+CATEGORY="ksm" run_test ./ksm_tests -U
 # KSM test with 10 zero pages and use_zero_pages = 0
-run_test ./ksm_tests -Z -p 10 -z 0
+CATEGORY="ksm" run_test ./ksm_tests -Z -p 10 -z 0
 # KSM test with 10 zero pages and use_zero_pages = 1
-run_test ./ksm_tests -Z -p 10 -z 1
+CATEGORY="ksm" run_test ./ksm_tests -Z -p 10 -z 1
 # KSM test with 2 NUMA nodes and merge_across_nodes = 1
-run_test ./ksm_tests -N -m 1
+CATEGORY="ksm_numa" run_test ./ksm_tests -N -m 1
 # KSM test with 2 NUMA nodes and merge_across_nodes = 0
-run_test ./ksm_tests -N -m 0
+CATEGORY="ksm_numa" run_test ./ksm_tests -N -m 0
 
 # protection_keys tests
 if [ -x ./protection_keys_32 ]
 then
-	run_test ./protection_keys_32
+	CATEGORY="pkey" run_test ./protection_keys_32
 fi
 
 if [ -x ./protection_keys_64 ]
 then
-	run_test ./protection_keys_64
+	CATEGORY="pkey" run_test ./protection_keys_64
 fi
 
 run_test ./soft-dirty
-- 
2.31.1

