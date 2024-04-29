Return-Path: <linux-kselftest+bounces-9096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4369B8B6658
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 01:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00618283920
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2689194C9B;
	Mon, 29 Apr 2024 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLaLnNPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AAA199E80
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433679; cv=none; b=SJLWbJ2qEiXS9Fvu1xfGzwDc/NG2j84rxb/+2C/JBLQ/gCrKmEcO8pW7FlmWFoLNdUTFNCEcAEGPohyJdRUHXZmbwYwHXZpxA6g16rfu9dHFHtDiKlU0qykTTsgH02TJtrXvNgL+pQ27rouFyHq9LH1N8dTiIndsTtMzqH3NTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433679; c=relaxed/simple;
	bh=lwbJyriMeKCC7kbq+9YtW2yusBZJusLxuCP1m9edtYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KHY0ywhHLU3w/VxaYsk8bibQaWlZ57coQTxxUN787mvVhH/iANFPYWw+24Dx0w6T64CfG3SMQPreQIqhfnQl0Y80yo7Lw3EMYy57aA72zdmXnReLpjA2v9pXxNLj5742KaarQ9Z7e7PzTxxc3GNxaWuDbN9NqaGsTOH75mMDS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLaLnNPF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433677; x=1745969677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lwbJyriMeKCC7kbq+9YtW2yusBZJusLxuCP1m9edtYs=;
  b=nLaLnNPF8pQUkzpbG6+v4k1qKXHBbm49kB3heovlM0qXVf87f03DK+jE
   l9tCUkyAcAvD7M0WaEDtNwMQljPgQAS8YxjP7U/VGUPs6cLbEceW3civX
   jJGpAnMthyR9LJQdXfQGoOSnPCTpPZPbHJaMKKzroUeFQV27JB6TaT3Dd
   J+5cbIFG/fgLk+M0G074RAs/CeZ3p46zzykZzdBAuec5sOFPswgQoHXqs
   g2p+IkCNgGoqLLzWrZDbP8CEDIXLJc3FMtSwbwHkBpeqLR39EFuA3Dyq7
   As5FBK0Td7kG9LphOZhim9jtpW14axpdJdq556a4D3zKpf2N3BdDHxYPZ
   Q==;
X-CSE-ConnectionGUID: WaTx00AsQa6U8OVCK0doqg==
X-CSE-MsgGUID: FIMWcnDYSw2iS4ti6usP1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20670017"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="20670017"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:34:37 -0700
X-CSE-ConnectionGUID: 8Vo4btO2T8uNQCxluH4QbQ==
X-CSE-MsgGUID: OBveummPQm6rcznHKX6gFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="30740573"
Received: from 984fee00c67b.jf.intel.com ([10.23.0.114])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:34:37 -0700
From: Zide Chen <zide.chen@intel.com>
To: linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	Zide Chen <zide.chen@intel.com>,
	donsheng <dongsheng.x.zhang@intel.com>
Subject: [PATCH V4] KVM: selftests: Add a new option to rseq_test
Date: Mon, 29 Apr 2024 16:34:35 -0700
Message-Id: <20240429233435.19003-1-zide.chen@intel.com>
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

Signed-off-by: Zide Chen <zide.chen@intel.com>
Co-developed-by: donsheng <dongsheng.x.zhang@intel.com>
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


