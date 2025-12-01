Return-Path: <linux-kselftest+bounces-46837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5883C98B08
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 19:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99EDD3433D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1C338912;
	Mon,  1 Dec 2025 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjKhYWLF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E3338596
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613142; cv=none; b=SIcNScTTsxi7axmzAw/SRBSGPOLA9g4+43yYc/W7CgN6zwXPG9dWlai2M5KjBPUK+HxxbgMA3pthNS07bNAg6OnopajMvfQluDBGMjiA5ojjehZkqgC53Ri9H6+kURQujRw4gYjnvbiXlG0Xr7n9CE8RvHEA7tsCg5eWLrKxyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613142; c=relaxed/simple;
	bh=VjOepyWc0elUq0jCwl2/wd3zvv5o2V5a6ZJwaWPJlO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ts0xrF6TGfm10lIYE91Ko4h41vjz1V300QVaAlOTM1LzqosVmzm2+yx7PvseIz5/IM+UbO+39os8Qb31aqaboMgF77+GPRL7pD4bqTYNJCKb1LQUnlb91WGvACAQrMJp+fb/vSAh5BmazJbwh1/d9tr0pXlWAStW7CHhKHFKAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjKhYWLF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764613139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=blQqdapcXTSPJCxD7giptBV8MOZKLLZchAntN5zGTII=;
	b=fjKhYWLFpZtQGEaOc2yjYM2mJhMk2QVkYOH30zPYSvF1xmFmf1mLyPMgyNdQt8wnRBbOlU
	eqfPRGeJmSsJxT/G5tAmOFjWlnuqov5Y52KxS5d+4IMoJw2VD/5ZtB3c5drSg2gKiLmyK/
	58DNnD0W8dLx2e86Oh5/lr5e5mKdiz8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-EE7U_QUePPmhg0hqYqD6fg-1; Mon,
 01 Dec 2025 13:18:55 -0500
X-MC-Unique: EE7U_QUePPmhg0hqYqD6fg-1
X-Mimecast-MFC-AGG-ID: EE7U_QUePPmhg0hqYqD6fg_1764613133
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86C70195608D;
	Mon,  1 Dec 2025 18:18:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8C241800451;
	Mon,  1 Dec 2025 18:18:50 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	surenb@google.com,
	rppt@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	david@kernel.org,
	urezki@gmail.com,
	raquini@redhat.com,
	akpm@linux-foundation.org
Subject: [PATCH] lib/test_vmalloc.c: Minor fixes to test_vmalloc.c
Date: Mon,  1 Dec 2025 13:18:48 -0500
Message-ID: <20251201181848.1216197-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

If PAGE_SIZE is larger than 4k and if you have a system with a
large number of CPUs, this test can require a very large amount
of memory leading to oom-killer firing. Given the type of allocation,
the kernel won't have anything to kill, causing the system to
stall. Add a parameter to the test_vmalloc driver to represent the
number of times a percpu object will be allocated. Calculate this
in test_vmalloc.sh to be 90% of available memory or the current
default of 35000, whichever is smaller.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 lib/test_vmalloc.c                         | 11 +++++---
 tools/testing/selftests/mm/test_vmalloc.sh | 31 +++++++++++++++++++---
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 2815658ccc37..67e53cd6b619 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -57,6 +57,9 @@ __param(int, run_test_mask, 7,
 		/* Add a new test case description here. */
 );
 
+__param(int, nr_pcpu_objects, 35000,
+	"Number of pcpu objects to allocate for pcpu_alloc_test");
+
 /*
  * This is for synchronization of setup phase.
  */
@@ -292,24 +295,24 @@ pcpu_alloc_test(void)
 	size_t size, align;
 	int i;
 
-	pcpu = vmalloc(sizeof(void __percpu *) * 35000);
+	pcpu = vmalloc(sizeof(void __percpu *) * nr_pcpu_objects);
 	if (!pcpu)
 		return -1;
 
-	for (i = 0; i < 35000; i++) {
+	for (i = 0; i < nr_pcpu_objects; i++) {
 		size = get_random_u32_inclusive(1, PAGE_SIZE / 4);
 
 		/*
 		 * Maximum PAGE_SIZE
 		 */
-		align = 1 << get_random_u32_inclusive(1, 11);
+		align = 1 << get_random_u32_inclusive(1, PAGE_SHIFT - 1);
 
 		pcpu[i] = __alloc_percpu(size, align);
 		if (!pcpu[i])
 			rv = -1;
 	}
 
-	for (i = 0; i < 35000; i++)
+	for (i = 0; i < nr_pcpu_objects; i++)
 		free_percpu(pcpu[i]);
 
 	vfree(pcpu);
diff --git a/tools/testing/selftests/mm/test_vmalloc.sh b/tools/testing/selftests/mm/test_vmalloc.sh
index d39096723fca..b23d705bf570 100755
--- a/tools/testing/selftests/mm/test_vmalloc.sh
+++ b/tools/testing/selftests/mm/test_vmalloc.sh
@@ -13,6 +13,9 @@ TEST_NAME="vmalloc"
 DRIVER="test_${TEST_NAME}"
 NUM_CPUS=`grep -c ^processor /proc/cpuinfo`
 
+# Default number of times we allocate percpu objects:
+NR_PCPU_OBJECTS=35000
+
 # 1 if fails
 exitcode=1
 
@@ -27,6 +30,8 @@ PERF_PARAM="sequential_test_order=1 test_repeat_count=3"
 SMOKE_PARAM="test_loop_count=10000 test_repeat_count=10"
 STRESS_PARAM="nr_threads=$NUM_CPUS test_repeat_count=20"
 
+PCPU_OBJ_PARAM="nr_pcpu_objects=$NR_PCPU_OBJECTS"
+
 check_test_requirements()
 {
 	uid=$(id -u)
@@ -47,12 +52,30 @@ check_test_requirements()
 	fi
 }
 
+check_memory_requirement()
+{
+	# The pcpu_alloc_test allocates nr_pcpu_objects per cpu. If the
+	# PAGE_SIZE is on the larger side it is easier to set a value
+	# that can cause oom events during testing. Since we are
+	# testing the functionality of vmalloc and not the oom-killer,
+	# calculate what is 90% of available memory and divide it by
+	# the number of online CPUs.
+	pages=$(($(getconf _AVPHYS_PAGES) * 90 / 100 / $NUM_CPUS))
+
+	if (($pages < $NR_PCPU_OBJECTS)); then
+		echo "Updated nr_pcpu_objects to 90% of available memory."
+		echo "nr_pcpu_objects is now set to: $pages."
+		PCPU_OBJ_PARAM="nr_pcpu_objects=$pages"
+	fi
+}
+
 run_performance_check()
 {
 	echo "Run performance tests to evaluate how fast vmalloc allocation is."
 	echo "It runs all test cases on one single CPU with sequential order."
 
-	modprobe $DRIVER $PERF_PARAM > /dev/null 2>&1
+	check_memory_requirement
+	modprobe $DRIVER $PERF_PARAM $PCPU_OBJ_PARAM > /dev/null 2>&1
 	echo "Done."
 	echo "Check the kernel message buffer to see the summary."
 }
@@ -63,7 +86,8 @@ run_stability_check()
 	echo "available test cases are run by NUM_CPUS workers simultaneously."
 	echo "It will take time, so be patient."
 
-	modprobe $DRIVER $STRESS_PARAM > /dev/null 2>&1
+	check_memory_requirement
+	modprobe $DRIVER $STRESS_PARAM $PCPU_OBJ_PARAM > /dev/null 2>&1
 	echo "Done."
 	echo "Check the kernel ring buffer to see the summary."
 }
@@ -74,7 +98,8 @@ run_smoke_check()
 	echo "Please check $0 output how it can be used"
 	echo "for deep performance analysis as well as stress testing."
 
-	modprobe $DRIVER $SMOKE_PARAM > /dev/null 2>&1
+	check_memory_requirement
+	modprobe $DRIVER $SMOKE_PARAM $PCPU_OBJ_PARAM > /dev/null 2>&1
 	echo "Done."
 	echo "Check the kernel ring buffer to see the summary."
 }
-- 
2.51.0


