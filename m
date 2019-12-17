Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2849A123AA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2019 00:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLQXQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Dec 2019 18:16:36 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37587 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLQXQf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Dec 2019 18:16:35 -0500
Received: by mail-pl1-f201.google.com with SMTP id t21so53029plo.4
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2019 15:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XOpHAnK1+dAZjuLBdbBF9W12i1a1YTvW7EqqleXNcbA=;
        b=Vz3pLHyYNEJUNL1lFGThUjYFGSVavjY44GfcdHCVCgoP5L6hZ74TSyqMkg5HoNX5sR
         fpUlxm2N7jYp7dFzdYo5mdxWRyuZtpWot7GHzkdX+rYSNjIEwRv5f2dOXASC1V+Fg3QQ
         kQV2yUDQV7FVbAoNxGgAXC2nCjkhnOy7Yhr2eIbem/kn6DwasxamqgzVavJlJOpZ8sqP
         W/EzC+guyCr9N/k52KJL7YU24s07bCRzNYJgaMKCgJznTbgZIzLfikn411iRAiION3UL
         6zyGwPeK54rBP1TZlZOFVxq2Sm9MH5mg4d5bWidxitNFm+xLrpCczfQzJjYfHT8ppuMQ
         06tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XOpHAnK1+dAZjuLBdbBF9W12i1a1YTvW7EqqleXNcbA=;
        b=CzgPVGaaQbI6ZX7Okb/GpfNtjp2J2w1J81kAtucdvPaykytwBLr7iAdKr13Gpa1aE7
         d0jKv7IkH+lxwLUpjvPuX02itN2jlDBRFgcaOu8+68Ckuqk5OkwYWsvmyiVuBMcIhhDh
         Bn0wAuSRV3J5ezOn1FkmEyK4YvN/0ib1n68OlXZIyS8/KpHSKPC/SzP6zhskkHikM6mY
         LwQTIy52IwRLTeDcrM5TB8iXmkIErhoD7+5QD+oZcSxRugGK6eRCsk2KVLDGFljhZUvV
         wg7Hjk1LFE9OEOURL0/2KRQVxmck0F5m/vQTbiJIO5ppRtKC23CcCItskVcbv0GO2MB8
         xNNg==
X-Gm-Message-State: APjAAAWR6fUt4FMkunC0JV4vROygbEEKRUuElhzwUH+pPuYxBoQAN/S/
        x2KarZalDbOpOOGSN+pexuxJrPcU6IVh8j1+mw==
X-Google-Smtp-Source: APXvYqz2bu0BNO8AQ7AfME2s5xlowtdhGuUT6Ce8UGABbBTWxyMg8D56nle8239Lv5HwSoB0glgUk3h/rZwiehtZFg==
X-Received: by 2002:a63:8948:: with SMTP id v69mr425551pgd.86.1576624593953;
 Tue, 17 Dec 2019 15:16:33 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:16:14 -0800
In-Reply-To: <20191217231615.164161-1-almasrymina@google.com>
Message-Id: <20191217231615.164161-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v9 7/8] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The tests use both shared and private mapped hugetlb memory, and
monitors the hugetlb usage counter as well as the hugetlb reservation
counter. They test different configurations such as hugetlb memory usage
via hugetlbfs, or MAP_HUGETLB, or shmget/shmat, and with and without
MAP_POPULATE.

Also add test for hugetlb reservation reparenting, since this is
a subtle issue.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v9:
- Added tests for hugetlb reparenting.
- Make tests explicitly support cgroup v1 and v2 via script argument.
Changes in v6:
- Updates tests for cgroups-v2 and NORESERVE allocations.

---
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   1 +
 .../selftests/vm/charge_reserved_hugetlb.sh   | 557 ++++++++++++++++++
 .../selftests/vm/hugetlb_reparenting_test.sh  | 235 ++++++++
 .../selftests/vm/write_hugetlb_memory.sh      |  23 +
 .../testing/selftests/vm/write_to_hugetlbfs.c | 261 ++++++++
 6 files changed, 1078 insertions(+)
 create mode 100755 tools/testing/selftests/vm/charge_reserved_hugetlb.sh
 create mode 100755 tools/testing/selftests/vm/hugetlb_reparenting_test.sh
 create mode 100644 tools/testing/selftests/vm/write_hugetlb_memory.sh
 create mode 100644 tools/testing/selftests/vm/write_to_hugetlbfs.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 31b3c98b6d34d..d3bed9407773c 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -14,3 +14,4 @@ virtual_address_range
 gup_benchmark
 va_128TBswitch
 map_fixed_noreplace
+write_to_hugetlbfs
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 7f9a8a8c31da9..662bb95e84c5d 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -22,6 +22,7 @@ TEST_GEN_FILES += userfaultfd
 ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
 TEST_GEN_FILES += va_128TBswitch
 TEST_GEN_FILES += virtual_address_range
+TEST_GEN_FILES += write_to_hugetlbfs
 endif

 TEST_PROGS := run_vmtests
diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
new file mode 100755
index 0000000000000..cdb4b5fe09d01
--- /dev/null
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -0,0 +1,557 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+if [[ $(id -u) -ne 0 ]]; then
+  echo "This test must be run as root. Skipping..."
+  exit 0
+fi
+
+fault_limit_file=limit_in_bytes
+reservation_limit_file=reservation_limit_in_bytes
+fault_usage_file=usage_in_bytes
+reservation_usage_file=reservation_usage_in_bytes
+
+if [[ "$1" == "-cgroup-v2" ]]; then
+  cgroup2=1
+  fault_limit_file=max
+  reservation_limit_file=reservation_max
+  fault_usage_file=current
+  reservation_usage_file=reservation_current
+fi
+
+cgroup_path=/dev/cgroup/memory
+if [[ ! -e $cgroup_path ]]; then
+  mkdir -p $cgroup_path
+  if [[ $cgroup2 ]]; then
+    mount -t cgroup2 none $cgroup_path
+  else
+    mount -t cgroup memory,hugetlb $cgroup_path
+  fi
+fi
+
+if [[ $cgroup2 ]]; then
+  echo "+hugetlb" >/dev/cgroup/memory/cgroup.subtree_control
+fi
+
+cleanup() {
+  if [[ $cgroup2 ]]; then
+    echo $$ >$cgroup_path/cgroup.procs
+  else
+    echo $$ >$cgroup_path/tasks
+  fi
+
+  if [[ -e /mnt/huge ]]; then
+    rm -rf /mnt/huge/*
+    umount /mnt/huge || echo error
+    rmdir /mnt/huge
+  fi
+  if [[ -e $cgroup_path/hugetlb_cgroup_test ]]; then
+    rmdir $cgroup_path/hugetlb_cgroup_test
+  fi
+  if [[ -e $cgroup_path/hugetlb_cgroup_test1 ]]; then
+    rmdir $cgroup_path/hugetlb_cgroup_test1
+  fi
+  if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
+    rmdir $cgroup_path/hugetlb_cgroup_test2
+  fi
+  echo 0 >/proc/sys/vm/nr_hugepages
+  echo CLEANUP DONE
+}
+
+function expect_equal() {
+  local expected="$1"
+  local actual="$2"
+  local error="$3"
+
+  if [[ "$expected" != "$actual" ]]; then
+    echo "expected ($expected) != actual ($actual): $3"
+    cleanup
+    exit 1
+  fi
+}
+
+function setup_cgroup() {
+  local name="$1"
+  local cgroup_limit="$2"
+  local reservation_limit="$3"
+
+  mkdir $cgroup_path/$name
+
+  echo writing cgroup limit: "$cgroup_limit"
+  echo "$cgroup_limit" >$cgroup_path/$name/hugetlb.2MB.$fault_limit_file
+
+  echo writing reseravation limit: "$reservation_limit"
+  echo "$reservation_limit" > \
+    $cgroup_path/$name/hugetlb.2MB.$reservation_limit_file
+
+  if [ -e "$cgroup_path/$name/cpuset.cpus" ]; then
+    echo 0 >$cgroup_path/$name/cpuset.cpus
+  fi
+  if [ -e "$cgroup_path/$name/cpuset.mems" ]; then
+    echo 0 >$cgroup_path/$name/cpuset.mems
+  fi
+}
+
+function wait_for_hugetlb_memory_to_get_depleted() {
+  local cgroup="$1"
+  local path="/dev/cgroup/memory/$cgroup/hugetlb.2MB.$reservation_usage_file"
+  # Wait for hugetlbfs memory to get depleted.
+  while [ $(cat $path) != 0 ]; do
+    echo Waiting for hugetlb memory to get depleted.
+    cat $path
+    sleep 0.5
+  done
+}
+
+function wait_for_hugetlb_memory_to_get_reserved() {
+  local cgroup="$1"
+  local size="$2"
+
+  local path="/dev/cgroup/memory/$cgroup/hugetlb.2MB.$reservation_usage_file"
+  # Wait for hugetlbfs memory to get written.
+  while [ $(cat $path) != $size ]; do
+    echo Waiting for hugetlb memory reservation to reach size $size.
+    cat $path
+    sleep 0.5
+  done
+}
+
+function wait_for_hugetlb_memory_to_get_written() {
+  local cgroup="$1"
+  local size="$2"
+
+  local path="/dev/cgroup/memory/$cgroup/hugetlb.2MB.$fault_usage_file"
+  # Wait for hugetlbfs memory to get written.
+  while [ $(cat $path) != $size ]; do
+    echo Waiting for hugetlb memory to reach size $size.
+    cat $path
+    sleep 0.5
+  done
+}
+
+function write_hugetlbfs_and_get_usage() {
+  local cgroup="$1"
+  local size="$2"
+  local populate="$3"
+  local write="$4"
+  local path="$5"
+  local method="$6"
+  local private="$7"
+  local expect_failure="$8"
+  local reserve="$9"
+
+  # Function return values.
+  reservation_failed=0
+  oom_killed=0
+  hugetlb_difference=0
+  reserved_difference=0
+
+  local hugetlb_usage=$cgroup_path/$cgroup/hugetlb.2MB.$fault_usage_file
+  local reserved_usage=$cgroup_path/$cgroup/hugetlb.2MB.$reservation_usage_file
+
+  local hugetlb_before=$(cat $hugetlb_usage)
+  local reserved_before=$(cat $reserved_usage)
+
+  echo
+  echo Starting:
+  echo hugetlb_usage="$hugetlb_before"
+  echo reserved_usage="$reserved_before"
+  echo expect_failure is "$expect_failure"
+
+  set +e
+  if [[ "$method" == "1" ]] || [[ "$method" == 2 ]] ||
+    [[ "$private" == "-r" ]] && [[ "$expect_failure" != 1 ]]; then
+
+    bash write_hugetlb_memory.sh "$size" "$populate" "$write" \
+      "$cgroup" "$path" "$method" "$private" "-l" "$reserve" &
+
+    local write_result=$?
+
+    if [[ "$reserve" != "-n" ]]; then
+      wait_for_hugetlb_memory_to_get_reserved "$cgroup" "$size"
+    elif [[ "$populate" == "-o" ]] || [[ "$write" == "-w" ]]; then
+      wait_for_hugetlb_memory_to_get_written "$cgroup" "$size"
+    else
+      # This case doesn't produce visible effects, but we still have
+      # to wait for the async process to start and execute...
+      sleep 0.5
+    fi
+
+    echo write_result is $write_result
+  else
+    bash write_hugetlb_memory.sh "$size" "$populate" "$write" \
+      "$cgroup" "$path" "$method" "$private" "$reserve"
+    local write_result=$?
+
+    if [[ "$reserve" != "-n" ]]; then
+      wait_for_hugetlb_memory_to_get_reserved "$cgroup" "$size"
+    fi
+  fi
+  set -e
+
+  if [[ "$write_result" == 1 ]]; then
+    reservation_failed=1
+  fi
+
+  # On linus/master, the above process gets SIGBUS'd on oomkill, with
+  # return code 135. On earlier kernels, it gets actual oomkill, with return
+  # code 137, so just check for both conditions in case we're testing
+  # against an earlier kernel.
+  if [[ "$write_result" == 135 ]] || [[ "$write_result" == 137 ]]; then
+    oom_killed=1
+  fi
+
+  local hugetlb_after=$(cat $hugetlb_usage)
+  local reserved_after=$(cat $reserved_usage)
+
+  echo After write:
+  echo hugetlb_usage="$hugetlb_after"
+  echo reserved_usage="$reserved_after"
+
+  hugetlb_difference=$(($hugetlb_after - $hugetlb_before))
+  reserved_difference=$(($reserved_after - $reserved_before))
+}
+
+function cleanup_hugetlb_memory() {
+  set +e
+  local cgroup="$1"
+  if [[ "$(pgrep write_to_hugetlbfs)" != "" ]]; then
+    echo kiling write_to_hugetlbfs
+    killall -2 write_to_hugetlbfs
+    wait_for_hugetlb_memory_to_get_depleted $cgroup
+  fi
+  set -e
+
+  if [[ -e /mnt/huge ]]; then
+    rm -rf /mnt/huge/*
+    umount /mnt/huge
+    rmdir /mnt/huge
+  fi
+}
+
+function run_test() {
+  local size="$1"
+  local populate="$2"
+  local write="$3"
+  local cgroup_limit="$4"
+  local reservation_limit="$5"
+  local nr_hugepages="$6"
+  local method="$7"
+  local private="$8"
+  local expect_failure="$9"
+  local reserve="${10}"
+
+  # Function return values.
+  hugetlb_difference=0
+  reserved_difference=0
+  reservation_failed=0
+  oom_killed=0
+
+  echo nr hugepages = "$nr_hugepages"
+  echo "$nr_hugepages" >/proc/sys/vm/nr_hugepages
+
+  setup_cgroup "hugetlb_cgroup_test" "$cgroup_limit" "$reservation_limit"
+
+  mkdir -p /mnt/huge
+  mount -t hugetlbfs \
+    -o pagesize=2M,size=256M none /mnt/huge
+
+  write_hugetlbfs_and_get_usage "hugetlb_cgroup_test" "$size" "$populate" \
+    "$write" "/mnt/huge/test" "$method" "$private" "$expect_failure" \
+    "$reserve"
+
+  cleanup_hugetlb_memory "hugetlb_cgroup_test"
+
+  local final_hugetlb=$(cat $cgroup_path/hugetlb_cgroup_test/hugetlb.2MB.$fault_usage_file)
+  local final_reservation=$(cat $cgroup_path/hugetlb_cgroup_test/hugetlb.2MB.$reservation_usage_file)
+
+  echo $hugetlb_difference
+  echo $reserved_difference
+  expect_equal "0" "$final_hugetlb" "final hugetlb is not zero"
+  expect_equal "0" "$final_reservation" "final reservation is not zero"
+}
+
+function run_multiple_cgroup_test() {
+  local size1="$1"
+  local populate1="$2"
+  local write1="$3"
+  local cgroup_limit1="$4"
+  local reservation_limit1="$5"
+
+  local size2="$6"
+  local populate2="$7"
+  local write2="$8"
+  local cgroup_limit2="$9"
+  local reservation_limit2="${10}"
+
+  local nr_hugepages="${11}"
+  local method="${12}"
+  local private="${13}"
+  local expect_failure="${14}"
+  local reserve="${15}"
+
+  # Function return values.
+  hugetlb_difference1=0
+  reserved_difference1=0
+  reservation_failed1=0
+  oom_killed1=0
+
+  hugetlb_difference2=0
+  reserved_difference2=0
+  reservation_failed2=0
+  oom_killed2=0
+
+  echo nr hugepages = "$nr_hugepages"
+  echo "$nr_hugepages" >/proc/sys/vm/nr_hugepages
+
+  setup_cgroup "hugetlb_cgroup_test1" "$cgroup_limit1" "$reservation_limit1"
+  setup_cgroup "hugetlb_cgroup_test2" "$cgroup_limit2" "$reservation_limit2"
+
+  mkdir -p /mnt/huge
+  mount -t hugetlbfs \
+    -o pagesize=2M,size=256M none /mnt/huge
+
+  write_hugetlbfs_and_get_usage "hugetlb_cgroup_test1" "$size1" \
+    "$populate1" "$write1" "/mnt/huge/test1" "$method" "$private" \
+    "$expect_failure" "$reserve"
+
+  hugetlb_difference1=$hugetlb_difference
+  reserved_difference1=$reserved_difference
+  reservation_failed1=$reservation_failed
+  oom_killed1=$oom_killed
+
+  local cgroup1_hugetlb_usage=$cgroup_path/hugetlb_cgroup_test1/hugetlb.2MB.$fault_usage_file
+  local cgroup1_reservation_usage=$cgroup_path/hugetlb_cgroup_test1/hugetlb.2MB.$reservation_usage_file
+  local cgroup2_hugetlb_usage=$cgroup_path/hugetlb_cgroup_test2/hugetlb.2MB.$fault_usage_file
+  local cgroup2_reservation_usage=$cgroup_path/hugetlb_cgroup_test2/hugetlb.2MB.$reservation_usage_file
+
+  local usage_before_second_write=$(cat $cgroup1_hugetlb_usage)
+  local reservation_usage_before_second_write=$(cat \
+    $cgroup1_reservation_usage)
+
+  write_hugetlbfs_and_get_usage "hugetlb_cgroup_test2" "$size2" \
+    "$populate2" "$write2" "/mnt/huge/test2" "$method" "$private" \
+    "$expect_failure" "$reserve"
+
+  hugetlb_difference2=$hugetlb_difference
+  reserved_difference2=$reserved_difference
+  reservation_failed2=$reservation_failed
+  oom_killed2=$oom_killed
+
+  expect_equal "$usage_before_second_write" \
+    "$(cat $cgroup1_hugetlb_usage)" "Usage changed."
+  expect_equal "$reservation_usage_before_second_write" \
+    "$(cat $cgroup1_reservation_usage)" "Reservation usage changed."
+
+  cleanup_hugetlb_memory
+
+  local final_hugetlb=$(cat $cgroup1_hugetlb_usage)
+  local final_reservation=$(cat $cgroup1_reservation_usage)
+
+  expect_equal "0" "$final_hugetlb" \
+    "hugetlbt_cgroup_test1 final hugetlb is not zero"
+  expect_equal "0" "$final_reservation" \
+    "hugetlbt_cgroup_test1 final reservation is not zero"
+
+  local final_hugetlb=$(cat $cgroup2_hugetlb_usage)
+  local final_reservation=$(cat $cgroup2_reservation_usage)
+
+  expect_equal "0" "$final_hugetlb" \
+    "hugetlb_cgroup_test2 final hugetlb is not zero"
+  expect_equal "0" "$final_reservation" \
+    "hugetlb_cgroup_test2 final reservation is not zero"
+}
+
+cleanup
+
+for populate in "" "-o"; do
+  for method in 0 1 2; do
+    for private in "" "-r"; do
+      for reserve in "" "-n"; do
+
+        # Skip mmap(MAP_HUGETLB | MAP_SHARED). Doesn't seem to be supported.
+        if [[ "$method" == 1 ]] && [[ "$private" == "" ]]; then
+          continue
+        fi
+
+        # Skip populated shmem tests. Doesn't seem to be supported.
+        if [[ "$method" == 2"" ]] && [[ "$populate" == "-o" ]]; then
+          continue
+        fi
+
+        if [[ "$method" == 2"" ]] && [[ "$reserve" == "-n" ]]; then
+          continue
+        fi
+
+        cleanup
+        echo
+        echo
+        echo
+        echo Test normal case.
+        echo private=$private, populate=$populate, method=$method, reserve=$reserve
+        run_test $((10 * 1024 * 1024)) "$populate" "" $((20 * 1024 * 1024)) \
+          $((20 * 1024 * 1024)) 10 "$method" "$private" "0" "$reserve"
+
+        echo Memory charged to hugtlb=$hugetlb_difference
+        echo Memory charged to reservation=$reserved_difference
+
+        if [[ "$populate" == "-o" ]]; then
+          expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference" \
+            "Reserved memory charged to hugetlb cgroup."
+        else
+          expect_equal "0" "$hugetlb_difference" \
+            "Reserved memory charged to hugetlb cgroup."
+        fi
+
+        if [[ "$reserve" != "-n" ]] || [[ "$populate" == "-o" ]]; then
+          expect_equal "$((10 * 1024 * 1024))" "$reserved_difference" \
+            "Reserved memory not charged to reservation usage."
+        else
+          expect_equal "0" "$reserved_difference" \
+            "Reserved memory not charged to reservation usage."
+        fi
+
+        echo 'PASS'
+
+        cleanup
+        echo
+        echo
+        echo
+        echo Test normal case with write.
+        echo private=$private, populate=$populate, method=$method, reserve=$reserve
+        run_test $((10 * 1024 * 1024)) "$populate" '-w' $((20 * 1024 * 1024)) \
+          $((20 * 1024 * 1024)) 10 "$method" "$private" "0" "$reserve"
+
+        echo Memory charged to hugtlb=$hugetlb_difference
+        echo Memory charged to reservation=$reserved_difference
+
+        expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference" \
+          "Reserved memory charged to hugetlb cgroup."
+
+        expect_equal "$((10 * 1024 * 1024))" "$reserved_difference" \
+          "Reserved memory not charged to reservation usage."
+
+        echo 'PASS'
+
+        cleanup
+        continue
+        echo
+        echo
+        echo
+        echo Test more than reservation case.
+        echo private=$private, populate=$populate, method=$method, reserve=$reserve
+
+        if [ "$reserve" != "-n" ]; then
+          run_test "$((10 * 1024 * 1024))" "$populate" '' "$((20 * 1024 * 1024))" \
+            "$((5 * 1024 * 1024))" "10" "$method" "$private" "1" "$reserve"
+
+          expect_equal "1" "$reservation_failed" "Reservation succeeded."
+        fi
+
+        echo 'PASS'
+
+        cleanup
+
+        echo
+        echo
+        echo
+        echo Test more than cgroup limit case.
+        echo private=$private, populate=$populate, method=$method, reserve=$reserve
+
+        # Not sure if shm memory can be cleaned up when the process gets sigbus'd.
+        if [[ "$method" != 2 ]]; then
+          run_test $((10 * 1024 * 1024)) "$populate" "-w" $((5 * 1024 * 1024)) \
+            $((20 * 1024 * 1024)) 10 "$method" "$private" "1" "$reserve"
+
+          expect_equal "1" "$oom_killed" "Not oom killed."
+        fi
+        echo 'PASS'
+
+        cleanup
+
+        echo
+        echo
+        echo
+        echo Test normal case, multiple cgroups.
+        echo private=$private, populate=$populate, method=$method, reserve=$reserve
+        run_multiple_cgroup_test "$((6 * 1024 * 1024))" "$populate" "" \
+          "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "$((10 * 1024 * 1024))" \
+          "$populate" "" "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "10" \
+          "$method" "$private" "0" "$reserve"
+
+        echo Memory charged to hugtlb1=$hugetlb_difference1
+        echo Memory charged to reservation1=$reserved_difference1
+        echo Memory charged to hugtlb2=$hugetlb_difference2
+        echo Memory charged to reservation2=$reserved_difference2
+
+        if [[ "$reserve" != "-n" ]] || [[ "$populate" == "-o" ]]; then
+          expect_equal "$((6 * 1024 * 1024))" "$reserved_difference1" \
+            "Incorrect reservations charged to cgroup 1."
+
+          expect_equal "$((10 * 1024 * 1024))" "$reserved_difference2" \
+            "Incorrect reservation charged to cgroup 2."
+
+        else
+          expect_equal "0" "$reserved_difference1" \
+            "Incorrect reservations charged to cgroup 1."
+
+          expect_equal "0" "$reserved_difference2" \
+            "Incorrect reservation charged to cgroup 2."
+        fi
+
+        if [[ "$populate" == "-o" ]]; then
+          expect_equal "$((6 * 1024 * 1024))" "$hugetlb_difference1" \
+            "Incorrect hugetlb charged to cgroup 1."
+
+          expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference2" \
+            "Incorrect hugetlb charged to cgroup 2."
+
+        else
+          expect_equal "0" "$hugetlb_difference1" \
+            "Incorrect hugetlb charged to cgroup 1."
+
+          expect_equal "0" "$hugetlb_difference2" \
+            "Incorrect hugetlb charged to cgroup 2."
+        fi
+        echo 'PASS'
+
+        cleanup
+        echo
+        echo
+        echo
+        echo Test normal case with write, multiple cgroups.
+        echo private=$private, populate=$populate, method=$method, reserve=$reserve
+        run_multiple_cgroup_test "$((6 * 1024 * 1024))" "$populate" "-w" \
+          "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "$((10 * 1024 * 1024))" \
+          "$populate" "-w" "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "10" \
+          "$method" "$private" "0" "$reserve"
+
+        echo Memory charged to hugtlb1=$hugetlb_difference1
+        echo Memory charged to reservation1=$reserved_difference1
+        echo Memory charged to hugtlb2=$hugetlb_difference2
+        echo Memory charged to reservation2=$reserved_difference2
+
+        expect_equal "$((6 * 1024 * 1024))" "$hugetlb_difference1" \
+          "Incorrect hugetlb charged to cgroup 1."
+
+        expect_equal "$((6 * 1024 * 1024))" "$reserved_difference1" \
+          "Incorrect reservation charged to cgroup 1."
+
+        expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference2" \
+          "Incorrect hugetlb charged to cgroup 2."
+
+        expect_equal "$((10 * 1024 * 1024))" "$reserved_difference2" \
+          "Incorrected reservation charged to cgroup 2."
+        echo 'PASS'
+
+        cleanup
+
+      done # reserve
+    done   # private
+  done     # populate
+done       # method
+
+umount $cgroup_path
+rmdir $cgroup_path
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
new file mode 100755
index 0000000000000..2be672c2b311a
--- /dev/null
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -0,0 +1,235 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+if [[ $(id -u) -ne 0 ]]; then
+  echo "This test must be run as root. Skipping..."
+  exit 0
+fi
+
+usage_file=usage_in_bytes
+
+if [[ "$1" == "-cgroup-v2" ]]; then
+  cgroup2=1
+  usage_file=current
+fi
+
+CGROUP_ROOT='/dev/cgroup/memory'
+MNT='/mnt/huge/'
+
+if [[ ! -e $CGROUP_ROOT ]]; then
+  mkdir -p $CGROUP_ROOT
+  if [[ $cgroup2 ]]; then
+    mount -t cgroup2 none $CGROUP_ROOT
+    sleep 1
+    echo "+hugetlb +memory" >$CGROUP_ROOT/cgroup.subtree_control
+  else
+    mount -t cgroup memory,hugetlb $CGROUP_ROOT
+  fi
+fi
+
+function cleanup() {
+  echo cleanup
+  set +e
+  rm -rf "$MNT"/* 2>/dev/null
+  umount "$MNT" 2>/dev/null
+  rmdir "$MNT" 2>/dev/null
+  rmdir "$CGROUP_ROOT"/a/b 2>/dev/null
+  rmdir "$CGROUP_ROOT"/a 2>/dev/null
+  rmdir "$CGROUP_ROOT"/test1 2>/dev/null
+  echo 0 >/proc/sys/vm/nr_hugepages
+  set -e
+}
+
+function assert_state() {
+  local expected_a="$1"
+  local expected_a_hugetlb="$2"
+  local expected_b=""
+  local expected_b_hugetlb=""
+
+  if [ ! -z ${3:-} ] && [ ! -z ${4:-} ]; then
+    expected_b="$3"
+    expected_b_hugetlb="$4"
+  fi
+  local tolerance=$((5 * 1024 * 1024))
+
+  local actual_a
+  actual_a="$(cat "$CGROUP_ROOT"/a/memory.$usage_file)"
+  if [[ $actual_a -lt $(($expected_a - $tolerance)) ]] ||
+    [[ $actual_a -gt $(($expected_a + $tolerance)) ]]; then
+    echo actual a = $((${actual_a%% *} / 1024 / 1024)) MB
+    echo expected a = $((${expected_a%% *} / 1024 / 1024)) MB
+    echo fail
+
+    cleanup
+    exit 1
+  fi
+
+  local actual_a_hugetlb
+  actual_a_hugetlb="$(cat "$CGROUP_ROOT"/a/hugetlb.2MB.$usage_file)"
+  if [[ $actual_a_hugetlb -lt $(($expected_a_hugetlb - $tolerance)) ]] ||
+    [[ $actual_a_hugetlb -gt $(($expected_a_hugetlb + $tolerance)) ]]; then
+    echo actual a hugetlb = $((${actual_a_hugetlb%% *} / 1024 / 1024)) MB
+    echo expected a hugetlb = $((${expected_a_hugetlb%% *} / 1024 / 1024)) MB
+    echo fail
+
+    cleanup
+    exit 1
+  fi
+
+  if [[ -z "$expected_b" || -z "$expected_b_hugetlb" ]]; then
+    return
+  fi
+
+  local actual_b
+  actual_b="$(cat "$CGROUP_ROOT"/a/b/memory.$usage_file)"
+  if [[ $actual_b -lt $(($expected_b - $tolerance)) ]] ||
+    [[ $actual_b -gt $(($expected_b + $tolerance)) ]]; then
+    echo actual b = $((${actual_b%% *} / 1024 / 1024)) MB
+    echo expected b = $((${expected_b%% *} / 1024 / 1024)) MB
+    echo fail
+
+    cleanup
+    exit 1
+  fi
+
+  local actual_b_hugetlb
+  actual_b_hugetlb="$(cat "$CGROUP_ROOT"/a/b/hugetlb.2MB.$usage_file)"
+  if [[ $actual_b_hugetlb -lt $(($expected_b_hugetlb - $tolerance)) ]] ||
+    [[ $actual_b_hugetlb -gt $(($expected_b_hugetlb + $tolerance)) ]]; then
+    echo actual b hugetlb = $((${actual_b_hugetlb%% *} / 1024 / 1024)) MB
+    echo expected b hugetlb = $((${expected_b_hugetlb%% *} / 1024 / 1024)) MB
+    echo fail
+
+    cleanup
+    exit 1
+  fi
+}
+
+function setup() {
+  echo 100 >/proc/sys/vm/nr_hugepages
+  mkdir "$CGROUP_ROOT"/a
+  sleep 1
+  if [[ $cgroup2 ]]; then
+    echo "+hugetlb +memory" >$CGROUP_ROOT/a/cgroup.subtree_control
+  else
+    echo 0 >$CGROUP_ROOT/a/cpuset.mems
+    echo 0 >$CGROUP_ROOT/a/cpuset.cpus
+  fi
+
+  mkdir "$CGROUP_ROOT"/a/b
+
+  if [[ ! $cgroup2 ]]; then
+    echo 0 >$CGROUP_ROOT/a/b/cpuset.mems
+    echo 0 >$CGROUP_ROOT/a/b/cpuset.cpus
+  fi
+
+  mkdir -p "$MNT"
+  mount -t hugetlbfs none "$MNT"
+}
+
+write_hugetlbfs() {
+  local cgroup="$1"
+  local path="$2"
+  local size="$3"
+
+  if [[ $cgroup2 ]]; then
+    echo $$ >$CGROUP_ROOT/$cgroup/cgroup.procs
+  else
+    echo 0 >$CGROUP_ROOT/$cgroup/cpuset.mems
+    echo 0 >$CGROUP_ROOT/$cgroup/cpuset.cpus
+    echo $$ >"$CGROUP_ROOT/$cgroup/tasks"
+  fi
+  ./write_to_hugetlbfs -p "$path" -s "$size" -m 0 -o
+  if [[ $cgroup2 ]]; then
+    echo $$ >$CGROUP_ROOT/cgroup.procs
+  else
+    echo $$ >"$CGROUP_ROOT/tasks"
+  fi
+  echo
+}
+
+set -e
+
+size=$((2 * 1024 * 1024 * 25)) # 50MB = 25 * 2MB hugepages.
+
+cleanup
+
+echo
+echo
+echo Test charge, rmdir, uncharge
+setup
+echo mkdir
+mkdir $CGROUP_ROOT/test1
+
+echo write
+write_hugetlbfs test1 "$MNT"/test $size
+
+echo rmdir
+rmdir $CGROUP_ROOT/test1
+mkdir $CGROUP_ROOT/test1
+
+echo uncharge
+rm -rf /mnt/huge/*
+
+cleanup
+
+echo done
+echo
+echo
+if [[ ! $cgroup2 ]]; then
+  echo "Test parent and child hugetlb usage"
+  setup
+
+  echo write
+  write_hugetlbfs a "$MNT"/test $size
+
+  echo Assert memory charged correctly for parent use.
+  assert_state 0 $size 0 0
+
+  write_hugetlbfs a/b "$MNT"/test2 $size
+
+  echo Assert memory charged correctly for child use.
+  assert_state 0 $(($size * 2)) 0 $size
+
+  rmdir "$CGROUP_ROOT"/a/b
+  sleep 5
+  echo Assert memory reparent correctly.
+  assert_state 0 $(($size * 2))
+
+  rm -rf "$MNT"/*
+  umount "$MNT"
+  echo Assert memory uncharged correctly.
+  assert_state 0 0
+
+  cleanup
+fi
+
+echo
+echo
+echo "Test child only hugetlb usage"
+echo setup
+setup
+
+echo write
+write_hugetlbfs a/b "$MNT"/test2 $size
+
+echo Assert memory charged correctly for child only use.
+assert_state 0 $(($size)) 0 $size
+
+rmdir "$CGROUP_ROOT"/a/b
+echo Assert memory reparent correctly.
+assert_state 0 $size
+
+rm -rf "$MNT"/*
+umount "$MNT"
+echo Assert memory uncharged correctly.
+assert_state 0 0
+
+cleanup
+
+echo ALL PASS
+
+umount $CGROUP_ROOT
+rm -rf $CGROUP_ROOT
diff --git a/tools/testing/selftests/vm/write_hugetlb_memory.sh b/tools/testing/selftests/vm/write_hugetlb_memory.sh
new file mode 100644
index 0000000000000..d3d0d108924d4
--- /dev/null
+++ b/tools/testing/selftests/vm/write_hugetlb_memory.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+size=$1
+populate=$2
+write=$3
+cgroup=$4
+path=$5
+method=$6
+private=$7
+want_sleep=$8
+reserve=$9
+
+echo "Putting task in cgroup '$cgroup'"
+echo $$ > /dev/cgroup/memory/"$cgroup"/cgroup.procs
+
+echo "Method is $method"
+
+set +e
+./write_to_hugetlbfs -p "$path" -s "$size" "$write" "$populate" -m "$method" \
+      "$private" "$want_sleep" "$reserve"
diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/testing/selftests/vm/write_to_hugetlbfs.c
new file mode 100644
index 0000000000000..85811c3384a10
--- /dev/null
+++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This program reserves and uses hugetlb memory, supporting a bunch of
+ * scenarios needed by the charged_reserved_hugetlb.sh test.
+ */
+
+#include <err.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/shm.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+/* Global definitions. */
+enum method {
+	HUGETLBFS,
+	MMAP_MAP_HUGETLB,
+	SHM,
+	MAX_METHOD
+};
+
+
+/* Global variables. */
+static const char *self;
+static char *shmaddr;
+static int shmid;
+
+/*
+ * Show usage and exit.
+ */
+static void exit_usage(void)
+{
+	printf("Usage: %s -p <path to hugetlbfs file> -s <size to map> "
+	       "[-m <0=hugetlbfs | 1=mmap(MAP_HUGETLB)>] [-l] [-r] "
+	       "[-o] [-w] [-n]\n",
+	       self);
+	exit(EXIT_FAILURE);
+}
+
+void sig_handler(int signo)
+{
+	printf("Received %d.\n", signo);
+	if (signo == SIGINT) {
+		printf("Deleting the memory\n");
+		if (shmdt((const void *)shmaddr) != 0) {
+			perror("Detach failure");
+			shmctl(shmid, IPC_RMID, NULL);
+			exit(4);
+		}
+
+		shmctl(shmid, IPC_RMID, NULL);
+		printf("Done deleting the memory\n");
+	}
+	exit(2);
+}
+
+int main(int argc, char **argv)
+{
+	int fd = 0;
+	int key = 0;
+	int *ptr = NULL;
+	int c = 0;
+	int size = 0;
+	char path[256] = "";
+	enum method method = MAX_METHOD;
+	int want_sleep = 0, private = 0;
+	int populate = 0;
+	int write = 0;
+	int reserve = 1;
+
+	unsigned long i;
+
+	if (signal(SIGINT, sig_handler) == SIG_ERR)
+		err(1, "\ncan't catch SIGINT\n");
+
+	/* Parse command-line arguments. */
+	setvbuf(stdout, NULL, _IONBF, 0);
+	self = argv[0];
+
+	while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
+		switch (c) {
+		case 's':
+			size = atoi(optarg);
+			break;
+		case 'p':
+			strncpy(path, optarg, sizeof(path));
+			break;
+		case 'm':
+			if (atoi(optarg) >= MAX_METHOD) {
+				errno = EINVAL;
+				perror("Invalid -m.");
+				exit_usage();
+			}
+			method = atoi(optarg);
+			break;
+		case 'o':
+			populate = 1;
+			break;
+		case 'w':
+			write = 1;
+			break;
+		case 'l':
+			want_sleep = 1;
+			break;
+		case 'r':
+		    private
+			= 1;
+			break;
+		case 'n':
+			reserve = 0;
+			break;
+		default:
+			errno = EINVAL;
+			perror("Invalid arg");
+			exit_usage();
+		}
+	}
+
+	if (strncmp(path, "", sizeof(path)) != 0) {
+		printf("Writing to this path: %s\n", path);
+	} else {
+		errno = EINVAL;
+		perror("path not found");
+		exit_usage();
+	}
+
+	if (size != 0) {
+		printf("Writing this size: %d\n", size);
+	} else {
+		errno = EINVAL;
+		perror("size not found");
+		exit_usage();
+	}
+
+	if (!populate)
+		printf("Not populating.\n");
+	else
+		printf("Populating.\n");
+
+	if (!write)
+		printf("Not writing to memory.\n");
+
+	if (method == MAX_METHOD) {
+		errno = EINVAL;
+		perror("-m Invalid");
+		exit_usage();
+	} else
+		printf("Using method=%d\n", method);
+
+	if (!private)
+		printf("Shared mapping.\n");
+	else
+		printf("Private mapping.\n");
+
+	if (!reserve)
+		printf("NO_RESERVE mapping.\n");
+	else
+		printf("RESERVE mapping.\n");
+
+	switch (method) {
+	case HUGETLBFS:
+		printf("Allocating using HUGETLBFS.\n");
+		fd = open(path, O_CREAT | O_RDWR, 0777);
+		if (fd == -1)
+			err(1, "Failed to open file.");
+
+		ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			   (private ? MAP_PRIVATE : MAP_SHARED) |
+				   (populate ? MAP_POPULATE : 0) |
+				   (reserve ? 0 : MAP_NORESERVE),
+			   fd, 0);
+
+		if (ptr == MAP_FAILED) {
+			close(fd);
+			err(1, "Error mapping the file");
+		}
+		break;
+	case MMAP_MAP_HUGETLB:
+		printf("Allocating using MAP_HUGETLB.\n");
+		ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			   (private ? (MAP_PRIVATE | MAP_ANONYMOUS) :
+				      MAP_SHARED) |
+				   MAP_HUGETLB | (populate ? MAP_POPULATE : 0) |
+				   (reserve ? 0 : MAP_NORESERVE),
+			   -1, 0);
+
+		if (ptr == MAP_FAILED)
+			err(1, "mmap");
+
+		printf("Returned address is %p\n", ptr);
+		break;
+	case SHM:
+		printf("Allocating using SHM.\n");
+		shmid = shmget(key, size,
+			       SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
+		if (shmid < 0) {
+			shmid = shmget(++key, size,
+				       SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
+			if (shmid < 0)
+				err(1, "shmget");
+		}
+		printf("shmid: 0x%x, shmget key:%d\n", shmid, key);
+
+		shmaddr = shmat(shmid, NULL, 0);
+		if (shmaddr == (char *)-1) {
+			perror("Shared memory attach failure");
+			shmctl(shmid, IPC_RMID, NULL);
+			exit(2);
+		}
+		printf("shmaddr: %p\n", shmaddr);
+
+		break;
+	default:
+		errno = EINVAL;
+		err(1, "Invalid method.");
+	}
+
+	if (write) {
+		printf("Writing to memory.\n");
+		if (method != SHM) {
+			memset(ptr, 1, size);
+		} else {
+			printf("Starting the writes:\n");
+			for (i = 0; i < size; i++) {
+				shmaddr[i] = (char)(i);
+				if (!(i % (1024 * 1024)))
+					printf(".");
+			}
+			printf("\n");
+
+			printf("Starting the Check...");
+			for (i = 0; i < size; i++)
+				if (shmaddr[i] != (char)i) {
+					printf("\nIndex %lu mismatched\n", i);
+					exit(3);
+				}
+			printf("Done.\n");
+		}
+	}
+
+	if (want_sleep) {
+		/* Signal to caller that we're done. */
+		printf("DONE\n");
+
+		/* Hold memory until external kill signal is delivered. */
+		while (1)
+			sleep(100);
+	}
+
+	switch (method == HUGETLBFS) {
+		close(fd);
+	}
+
+	return 0;
+}
--
2.24.1.735.g03f4e72817-goog
