Return-Path: <linux-kselftest+bounces-9290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276FA8BA290
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 23:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17EA28E5A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC757CA9;
	Thu,  2 May 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="To3tSKQ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFB57CAE
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685980; cv=none; b=jaQzgDnqZRDKCbXlRhNJmP+cqcNEp2/SACJStrVBfO2WEssTztEeairIGhSqYycXn2hq2OMtjG+4dzvmpf8pwYNax8ZrXG69BJ2CDLq2TbMNI+TOu4NOA1ioztSrZxRCFHgN7ca0whRgT+5c2hWn5z9Q3kOcdXvokCMgipCwMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685980; c=relaxed/simple;
	bh=sJQM6x+sz22sSNpjz61ngRTRoD++56JH2KqYRj7Tz2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nlpf+203V1Nzy/nyUpyroB9VlANAYEbGG5tnpvQldIlETZXJqy85KvvTMybuOX1luVHgKCAFP8TUDHsBwUgO7XE5ns7S6RdBMt9l55hSeyw1gT0JoO/5T28WWkZz3nvdxqdMu7ofeWtixZbRPu2oW9C/sgmeYIHkhgnlJAIMThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=To3tSKQ7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714685978; x=1746221978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sJQM6x+sz22sSNpjz61ngRTRoD++56JH2KqYRj7Tz2g=;
  b=To3tSKQ7MCp9+Ei4C1V0XyriUiHr7JkunzhjSp8cGbLjV44v9Y2Hij0p
   /luNKZvGxBxYGARBg2tNwymQMbFUanwpM7cXQBiRwsA3/pMpnTcY9/+j2
   1inuOyFOAk/45eD0IM0VDxSaE63Dv/5nOr5UHQzvPpLvkaZxwPsjPJfRH
   WP7vVbIYqabuoYXkS+tx/kH5uB4Bv2YVxbkMsEiaLr4IqtY+NtVWIvDae
   9LiFF4+qdfJZFhxX60ewVZ33d1WGfhCdLaCS33IxdhhuC+3LBCQJccujs
   AriwwZIi4LlAGAPlAQoQn0Ba29ffNwsn/5/5vSF4XC5xjQ9cU410oXZc5
   Q==;
X-CSE-ConnectionGUID: wlXeQRiSQhqv5AB63c9BAg==
X-CSE-MsgGUID: 0jVZ6bRwREKk6PM7ldCz3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10607574"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10607574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 14:39:38 -0700
X-CSE-ConnectionGUID: Q5BtfJpUSiemUGWRuOwMfQ==
X-CSE-MsgGUID: wPP60S+TQIqVl7ov7jrxHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27279426"
Received: from 984fee00c67b.jf.intel.com ([10.23.0.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 14:39:37 -0700
From: Zide Chen <zide.chen@intel.com>
To: linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	Zide Chen <zide.chen@intel.com>,
	Dongsheng Zhang <dongsheng.x.zhang@intel.com>
Subject: [PATCH V5] KVM: selftests: Add a new option to rseq_test
Date: Thu,  2 May 2024 14:39:36 -0700
Message-Id: <20240502213936.27619-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the migration worker delays 1-10 us, assuming that one
KVM_RUN iteration only takes a few microseconds.  But if the CPU low
power wakeup latency is large enough, for example, hundreds or even
thousands of microseconds deep C-state exit latencies on x86 server
CPUs, it may happen that it's not able to wakeup the target CPU before
the migration worker starts to migrate the vCPU thread to the next CPU.

If the system workload is light, most CPUs could be at a certain low
power state, which may result in less successful migrations and fail the
migration/KVM_RUN ratio sanity check.  But this is not supposed to be
deemed a test failure.

This patch adds a command line option to skip the sanity check in
this case.

Co-developed-by: Dongsheng Zhang <dongsheng.x.zhang@intel.com>
Signed-off-by: Dongsheng Zhang <dongsheng.x.zhang@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---

V2:
- removed the busy loop implementation
- add the new "-s" option

V3:
- drop the usleep randomization code
- removed the term C-state for less confusion for non-x86 archetectures
- changed patch subject

v4:
- replaced Signed-off-by with Co-developed-by
- changed command line option from "-s" to "-u"
- Adopted the much clearer assertion error messages provided by Sean.

V5:
- Fixed the missing SoB
---
 tools/testing/selftests/kvm/rseq_test.c | 35 +++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 28f97fb52044..ad418a5c59dd 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -186,12 +186,35 @@ static void calc_min_max_cpu(void)
 		       "Only one usable CPU, task migration not possible");
 }
 
+static void help(const char *name)
+{
+	puts("");
+	printf("usage: %s [-h] [-u]\n", name);
+	printf(" -u: Don't sanity check the number of successful KVM_RUNs\n");
+	puts("");
+	exit(0);
+}
+
 int main(int argc, char *argv[])
 {
 	int r, i, snapshot;
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
 	u32 cpu, rseq_cpu;
+	bool skip_sanity_check = false;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "hu")) != -1) {
+		switch (opt) {
+		case 'u':
+			skip_sanity_check = true;
+			break;
+		case 'h':
+		default:
+			help(argv[0]);
+			break;
+		}
+	}
 
 	r = sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
 	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)", errno,
@@ -254,9 +277,17 @@ int main(int argc, char *argv[])
 	 * getcpu() to stabilize.  A 2:1 migration:KVM_RUN ratio is a fairly
 	 * conservative ratio on x86-64, which can do _more_ KVM_RUNs than
 	 * migrations given the 1us+ delay in the migration task.
+	 *
+	 * Another reason why it may have small migration:KVM_RUN ratio is that,
+	 * on systems with large low power mode wakeup latency, it may happen
+	 * quite often that the scheduler is not able to wake up the target CPU
+	 * before the vCPU thread is scheduled to another CPU.
 	 */
-	TEST_ASSERT(i > (NR_TASK_MIGRATIONS / 2),
-		    "Only performed %d KVM_RUNs, task stalled too much?", i);
+	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 2),
+		    "Only performed %d KVM_RUNs, task stalled too much? \n"
+		    "  Try disabling deep sleep states to reduce CPU wakeup latency,\n"
+		    "  e.g. via cpuidle.off=1 or setting /dev/cpu_dma_latency to '0',\n"
+		    "  or run with -u to disable this sanity check.", i);
 
 	pthread_join(migration_thread, NULL);
 
-- 
2.34.1


