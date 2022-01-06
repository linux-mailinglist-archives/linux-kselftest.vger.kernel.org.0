Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29726486AF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jan 2022 21:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbiAFUOk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 15:14:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243606AbiAFUOj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 15:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641500079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dtVfK+demW4pFZUYpmMxVrK1tXyLU+OVy0JCJWGY9xE=;
        b=eijBoauBmRLJCM++FXETDuakkALq9jiPdoJdbgj+zKSvf69YLsYdCMS2Fef1xXGlXRhwlq
        /8+arcMEiZlnR8qM9e5vwBj5xfwWjmw4mDST5xTkGeB2svRZ+SRaI5mbxRtUgvSTD5Zdmg
        yxG/DQ7u5qIcvoEIDi2lqqZoxP1Ge+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-0ppgeqXNO4Wc3oOtWx-G3g-1; Thu, 06 Jan 2022 15:14:36 -0500
X-MC-Unique: 0ppgeqXNO4Wc3oOtWx-G3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A92E51898290;
        Thu,  6 Jan 2022 20:14:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 741114E2C1;
        Thu,  6 Jan 2022 20:14:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] selftests/vm: Make charge_reserved_hugetlb.sh work with existing cgroup setting
Date:   Thu,  6 Jan 2022 15:13:59 -0500
Message-Id: <20220106201359.1646575-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The hugetlb cgroup reservation test charge_reserved_hugetlb.sh assume
that no cgroup filesystems are mounted before running the test. That is
not true in many cases. As a result, the test fails to run. Fix that by
querying the current cgroup mount setting and using the existing cgroup
setup instead before attempting to freshly mount a cgroup filesystem.

Similar change is also made for hugetlb_reparenting_test.sh as well,
though it still has problem if cgroup v2 isn't used.

The patched test scripts were run on a centos 8 based system to verify
that they ran properly.

Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/vm/charge_reserved_hugetlb.sh   | 34 +++++++++++--------
 .../selftests/vm/hugetlb_reparenting_test.sh  | 21 +++++++-----
 .../selftests/vm/write_hugetlb_memory.sh      |  2 +-
 3 files changed, 34 insertions(+), 23 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/vm/charge_reserved_hugetlb.sh
 mode change 100644 => 100755 tools/testing/selftests/vm/hugetlb_reparenting_test.sh
 mode change 100644 => 100755 tools/testing/selftests/vm/write_hugetlb_memory.sh

diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
old mode 100644
new mode 100755
index fe8fcfb334e0..a5cb4b09a46c
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -24,19 +24,23 @@ if [[ "$1" == "-cgroup-v2" ]]; then
   reservation_usage_file=rsvd.current
 fi
 
-cgroup_path=/dev/cgroup/memory
-if [[ ! -e $cgroup_path ]]; then
-  mkdir -p $cgroup_path
-  if [[ $cgroup2 ]]; then
+if [[ $cgroup2 ]]; then
+  cgroup_path=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
+  if [[ -z "$cgroup_path" ]]; then
+    cgroup_path=/dev/cgroup/memory
     mount -t cgroup2 none $cgroup_path
-  else
+    do_umount=1
+  fi
+  echo "+hugetlb" >$cgroup_path/cgroup.subtree_control
+else
+  cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk -e '{print $3}')
+  if [[ -z "$cgroup_path" ]]; then
+    cgroup_path=/dev/cgroup/memory
     mount -t cgroup memory,hugetlb $cgroup_path
+    do_umount=1
   fi
 fi
-
-if [[ $cgroup2 ]]; then
-  echo "+hugetlb" >/dev/cgroup/memory/cgroup.subtree_control
-fi
+export cgroup_path
 
 function cleanup() {
   if [[ $cgroup2 ]]; then
@@ -108,7 +112,7 @@ function setup_cgroup() {
 
 function wait_for_hugetlb_memory_to_get_depleted() {
   local cgroup="$1"
-  local path="/dev/cgroup/memory/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
+  local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
   # Wait for hugetlbfs memory to get depleted.
   while [ $(cat $path) != 0 ]; do
     echo Waiting for hugetlb memory to get depleted.
@@ -121,7 +125,7 @@ function wait_for_hugetlb_memory_to_get_reserved() {
   local cgroup="$1"
   local size="$2"
 
-  local path="/dev/cgroup/memory/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
+  local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
   # Wait for hugetlbfs memory to get written.
   while [ $(cat $path) != $size ]; do
     echo Waiting for hugetlb memory reservation to reach size $size.
@@ -134,7 +138,7 @@ function wait_for_hugetlb_memory_to_get_written() {
   local cgroup="$1"
   local size="$2"
 
-  local path="/dev/cgroup/memory/$cgroup/hugetlb.${MB}MB.$fault_usage_file"
+  local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$fault_usage_file"
   # Wait for hugetlbfs memory to get written.
   while [ $(cat $path) != $size ]; do
     echo Waiting for hugetlb memory to reach size $size.
@@ -574,5 +578,7 @@ for populate in "" "-o"; do
   done     # populate
 done       # method
 
-umount $cgroup_path
-rmdir $cgroup_path
+if [[ $do_umount ]]; then
+  umount $cgroup_path
+  rmdir $cgroup_path
+fi
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
old mode 100644
new mode 100755
index 4a9a3afe9fd4..bf2d2a684edf
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -18,19 +18,24 @@ if [[ "$1" == "-cgroup-v2" ]]; then
   usage_file=current
 fi
 
-CGROUP_ROOT='/dev/cgroup/memory'
-MNT='/mnt/huge/'
 
-if [[ ! -e $CGROUP_ROOT ]]; then
-  mkdir -p $CGROUP_ROOT
-  if [[ $cgroup2 ]]; then
+if [[ $cgroup2 ]]; then
+  CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
+  if [[ -z "$CGROUP_ROOT" ]]; then
+    CGROUP_ROOT=/dev/cgroup/memory
     mount -t cgroup2 none $CGROUP_ROOT
-    sleep 1
-    echo "+hugetlb +memory" >$CGROUP_ROOT/cgroup.subtree_control
-  else
+    do_umount=1
+  fi
+  echo "+hugetlb +memory" >$CGROUP_ROOT/cgroup.subtree_control
+else
+  CGROUP_ROOT=$(mount -t cgroup | grep ",hugetlb" | awk -e '{print $3}')
+  if [[ -z "$CGROUP_ROOT" ]]; then
+    CGROUP_ROOT=/dev/cgroup/memory
     mount -t cgroup memory,hugetlb $CGROUP_ROOT
+    do_umount=1
   fi
 fi
+MNT='/mnt/huge/'
 
 function get_machine_hugepage_size() {
   hpz=$(grep -i hugepagesize /proc/meminfo)
diff --git a/tools/testing/selftests/vm/write_hugetlb_memory.sh b/tools/testing/selftests/vm/write_hugetlb_memory.sh
old mode 100644
new mode 100755
index d3d0d108924d..70a02301f4c2
--- a/tools/testing/selftests/vm/write_hugetlb_memory.sh
+++ b/tools/testing/selftests/vm/write_hugetlb_memory.sh
@@ -14,7 +14,7 @@ want_sleep=$8
 reserve=$9
 
 echo "Putting task in cgroup '$cgroup'"
-echo $$ > /dev/cgroup/memory/"$cgroup"/cgroup.procs
+echo $$ > ${cgroup_path:-/dev/cgroup/memory}/"$cgroup"/cgroup.procs
 
 echo "Method is $method"
 
-- 
2.27.0

