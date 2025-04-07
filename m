Return-Path: <linux-kselftest+bounces-30234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAABA7D83C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 10:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE8E3AD917
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A6A227599;
	Mon,  7 Apr 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj372CMk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B33226CF1
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015343; cv=none; b=Bi5+8kXbhIm/sao038m6IsBDQyFYwpG0iZ8Q3TdBEeJW/qs807nfM/D/g/f6Irt094b81X8lkjuyLX5iRp3oiBwVacDRHPrPnpwoMyQ16+40kztRb3PPIgtwMdUJZtGYJI+b8q8m4WtyKBAXnCMgWKsbUfR9Cyn/NGvNsJj0Uyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015343; c=relaxed/simple;
	bh=15WWb39rFMg02fOtz9X8hSYa4BiOQYUx+EjN+2Atdis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cn0k6N2cJa2Gsq8/2cDpQj6pPvUQsMulZoxcl4W9Mo8g1T2iFolVz73grciDLTC3fERDtDXbwKspvcM+dOa4n4zbrz+3ohJk9N50uJCX3s038FAM5lr2S5TkKo0pCYDEohkcbSycC5MpkBtmbkxyP42JmyHQTV5X842jcteiGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj372CMk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3+6tBOQqFX76msxDugyjTEa3wbr1jZTjo+PNwIN3lnY=;
	b=Oj372CMkNKmlfUcEKr5oGc9HnveVa81+Cyfo9bnYJoJPTtbNxARHk3HY0enTSj3pssEKBd
	CBov8DadmwdLJ0DPG+8jtG82Q3aTdcAnTSQlPJgdSNxm/OQV77WmeTGJckbPpcjRlQIfri
	8sCtk1aN6SiRlyM7cnt1ReBDZfC5F20=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-WgJssNW9OWaNc8BIS4cfYg-1; Mon,
 07 Apr 2025 04:42:17 -0400
X-MC-Unique: WgJssNW9OWaNc8BIS4cfYg-1
X-Mimecast-MFC-AGG-ID: WgJssNW9OWaNc8BIS4cfYg_1744015336
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E24018608D9;
	Mon,  7 Apr 2025 08:42:13 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C1891828AA8;
	Mon,  7 Apr 2025 08:42:06 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	liwang@redhat.com
Cc: Waiman Long <longman@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	"Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftest/mm: Make hugetlb_reparenting_test tolerant to async reparenting
Date: Mon,  7 Apr 2025 16:42:01 +0800
Message-ID: <20250407084201.74492-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In cgroup v2, memory and hugetlb usage reparenting is asynchronous.
This can cause test flakiness when immediately asserting usage after
deleting a child cgroup. To address this, add a helper function
`assert_with_retry()` that checks usage values with a timeout-based retry.
This improves test stability without relying on fixed sleep delays.

Also bump up the tolerance size to 7MB.

To avoid False Positives:
  ...
  # Assert memory charged correctly for child only use.
  # actual a = 11 MB
  # expected a = 0 MB
  # fail
  # cleanup
  # [FAIL]
  not ok 11 hugetlb_reparenting_test.sh -cgroup-v2 # exit=1
  # 0
  # SUMMARY: PASS=10 SKIP=0 FAIL=1

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 .../selftests/mm/hugetlb_reparenting_test.sh  | 96 ++++++++-----------
 1 file changed, 41 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 11f9bbe7dc22..1c172c6999f4 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -36,7 +36,7 @@ else
     do_umount=1
   fi
 fi
-MNT='/mnt/huge/'
+MNT='/mnt/huge'
 
 function get_machine_hugepage_size() {
   hpz=$(grep -i hugepagesize /proc/meminfo)
@@ -60,6 +60,41 @@ function cleanup() {
   set -e
 }
 
+function assert_with_retry() {
+  local actual_path="$1"
+  local expected="$2"
+  local tolerance=$((7 * 1024 * 1024))
+  local timeout=20
+  local interval=1
+  local start_time
+  local now
+  local elapsed
+  local actual
+
+  start_time=$(date +%s)
+
+  while true; do
+    actual="$(cat "$actual_path")"
+
+    if [[ $actual -ge $(($expected - $tolerance)) ]] &&
+        [[ $actual -le $(($expected + $tolerance)) ]]; then
+      return 0
+    fi
+
+    now=$(date +%s)
+    elapsed=$((now - start_time))
+
+    if [[ $elapsed -ge $timeout ]]; then
+      echo "actual = $((${actual%% *} / 1024 / 1024)) MB"
+      echo "expected = $((${expected%% *} / 1024 / 1024)) MB"
+      cleanup
+      exit 1
+    fi
+
+    sleep $interval
+  done
+}
+
 function assert_state() {
   local expected_a="$1"
   local expected_a_hugetlb="$2"
@@ -70,58 +105,13 @@ function assert_state() {
     expected_b="$3"
     expected_b_hugetlb="$4"
   fi
-  local tolerance=$((5 * 1024 * 1024))
-
-  local actual_a
-  actual_a="$(cat "$CGROUP_ROOT"/a/memory.$usage_file)"
-  if [[ $actual_a -lt $(($expected_a - $tolerance)) ]] ||
-    [[ $actual_a -gt $(($expected_a + $tolerance)) ]]; then
-    echo actual a = $((${actual_a%% *} / 1024 / 1024)) MB
-    echo expected a = $((${expected_a%% *} / 1024 / 1024)) MB
-    echo fail
-
-    cleanup
-    exit 1
-  fi
-
-  local actual_a_hugetlb
-  actual_a_hugetlb="$(cat "$CGROUP_ROOT"/a/hugetlb.${MB}MB.$usage_file)"
-  if [[ $actual_a_hugetlb -lt $(($expected_a_hugetlb - $tolerance)) ]] ||
-    [[ $actual_a_hugetlb -gt $(($expected_a_hugetlb + $tolerance)) ]]; then
-    echo actual a hugetlb = $((${actual_a_hugetlb%% *} / 1024 / 1024)) MB
-    echo expected a hugetlb = $((${expected_a_hugetlb%% *} / 1024 / 1024)) MB
-    echo fail
-
-    cleanup
-    exit 1
-  fi
-
-  if [[ -z "$expected_b" || -z "$expected_b_hugetlb" ]]; then
-    return
-  fi
-
-  local actual_b
-  actual_b="$(cat "$CGROUP_ROOT"/a/b/memory.$usage_file)"
-  if [[ $actual_b -lt $(($expected_b - $tolerance)) ]] ||
-    [[ $actual_b -gt $(($expected_b + $tolerance)) ]]; then
-    echo actual b = $((${actual_b%% *} / 1024 / 1024)) MB
-    echo expected b = $((${expected_b%% *} / 1024 / 1024)) MB
-    echo fail
-
-    cleanup
-    exit 1
-  fi
 
-  local actual_b_hugetlb
-  actual_b_hugetlb="$(cat "$CGROUP_ROOT"/a/b/hugetlb.${MB}MB.$usage_file)"
-  if [[ $actual_b_hugetlb -lt $(($expected_b_hugetlb - $tolerance)) ]] ||
-    [[ $actual_b_hugetlb -gt $(($expected_b_hugetlb + $tolerance)) ]]; then
-    echo actual b hugetlb = $((${actual_b_hugetlb%% *} / 1024 / 1024)) MB
-    echo expected b hugetlb = $((${expected_b_hugetlb%% *} / 1024 / 1024)) MB
-    echo fail
+  assert_with_retry "$CGROUP_ROOT/a/memory.$usage_file" "$expected_a"
+  assert_with_retry "$CGROUP_ROOT/a/hugetlb.${MB}MB.$usage_file" "$expected_a_hugetlb"
 
-    cleanup
-    exit 1
+  if [[ -n "$expected_b" && -n "$expected_b_hugetlb" ]]; then
+    assert_with_retry "$CGROUP_ROOT/a/b/memory.$usage_file" "$expected_b"
+    assert_with_retry "$CGROUP_ROOT/a/b/hugetlb.${MB}MB.$usage_file" "$expected_b_hugetlb"
   fi
 }
 
@@ -174,7 +164,6 @@ size=$((${MB} * 1024 * 1024 * 25)) # 50MB = 25 * 2MB hugepages.
 
 cleanup
 
-echo
 echo
 echo Test charge, rmdir, uncharge
 setup
@@ -195,7 +184,6 @@ cleanup
 
 echo done
 echo
-echo
 if [[ ! $cgroup2 ]]; then
   echo "Test parent and child hugetlb usage"
   setup
@@ -212,7 +200,6 @@ if [[ ! $cgroup2 ]]; then
   assert_state 0 $(($size * 2)) 0 $size
 
   rmdir "$CGROUP_ROOT"/a/b
-  sleep 5
   echo Assert memory reparent correctly.
   assert_state 0 $(($size * 2))
 
@@ -224,7 +211,6 @@ if [[ ! $cgroup2 ]]; then
   cleanup
 fi
 
-echo
 echo
 echo "Test child only hugetlb usage"
 echo setup
-- 
2.48.1


