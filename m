Return-Path: <linux-kselftest+bounces-8232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5248A7830
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 00:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664A6281AF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E71B13777C;
	Tue, 16 Apr 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHjAjc3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F421E511
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307927; cv=none; b=ldCSrvpgH9SMqFgmzA4SpAR3dWVPmES58K+cxUR/CWp5lgsAtx5skvFqLBIPO5imj7ZZojCoy/QBC9HO1QjsxpqsGn1gK4b4Ilt9eylwZgKfXM2bFUIlba74q4WvldRHOYEVocg02BtT6g9Ev63gLfeV54uVKBxV+dLUM/4NJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307927; c=relaxed/simple;
	bh=2Y8jWdiUGsiNqRu6AKkJpOxiM1l84+sHSAxoFpAWqHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m4/KCUjxBdXOLP6Cl7cHUnnMYoAap7U/b94IO/bg6W3H+p53g15MsexWz9hqg5feD+g8pt6BrkAIUoOVXgm/JcwlhdeaLbmeNcxnkrTK4086E1XFG00vSrXcaYL4H1QWgWf2UblPavXF4iefJLM84agEbZysobC96fiYLVPZdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHjAjc3m; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713307926; x=1744843926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Y8jWdiUGsiNqRu6AKkJpOxiM1l84+sHSAxoFpAWqHA=;
  b=WHjAjc3mRsLw/8y3uWPfZEdnyP3p1uyA9HTRkz1WODkhPNv5bqeLttOR
   AmsZVEkN9wc3H2jdfGJM1C/fZGB4yBNwjK26uipiItE3ZsLXK3KYx7UUJ
   FDA/LaLzOB4r1H7+7bdr6YYaEvf/zX5SciBNpYAB3AnUEHY59nGQfTn67
   4tRKK9jOqDeQuBNcen3Lnd9sd+SrSYizFWjuZvh7h1FIRFbyKd/QtYD+8
   3DwIeJu/zQ4Byzr2zRdyed0aHYumF77KFaJByNLMdrW/gdxovJenUYaue
   TrCA/UHRi9VzoLnryPtJMq85ImeAAixFZB630lEEF1KJo6qDZtHgj7jOP
   A==;
X-CSE-ConnectionGUID: APc7pKwqSN+oyYzEgLiB/A==
X-CSE-MsgGUID: age74JoXRPqIE49/CJ1V8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20198614"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="20198614"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:52:05 -0700
X-CSE-ConnectionGUID: pNQdNi0wS3a/Y/JmtOL9OA==
X-CSE-MsgGUID: ClN9aHQuTkiSQ2K02vUFpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22285445"
Received: from 984fee00c67b.jf.intel.com ([10.23.0.114])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:52:05 -0700
From: Zide Chen <zide.chen@intel.com>
To: linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	Zide Chen <zide.chen@intel.com>,
	donsheng <dongsheng.x.zhang@intel.com>
Subject: [PATCH V3] KVM: selftests: Add a new option to rseq_test
Date: Tue, 16 Apr 2024 15:51:53 -0700
Message-Id: <20240416225153.23801-1-zide.chen@intel.com>
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
Signed-off-by: donsheng <dongsheng.x.zhang@intel.com>

V2:
- removed the busy loop implementation
- add the new "-s" option

V3:
- drop the usleep randomization code
- removed the term C-state for less confusion for non-x86 archetectures
- changed subject
---
 tools/testing/selftests/kvm/rseq_test.c | 40 +++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 28f97fb52044..1daac3f51447 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -186,12 +186,35 @@ static void calc_min_max_cpu(void)
 		       "Only one usable CPU, task migration not possible");
 }
 
+static void help(const char *name)
+{
+	puts("");
+	printf("usage: %s [-h] [-s]\n", name);
+	printf(" -s: skip the sanity check for successful KVM_RUN.\n");
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
+	while ((opt = getopt(argc, argv, "sh")) != -1) {
+		switch (opt) {
+		case 's':
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
@@ -254,9 +277,22 @@ int main(int argc, char *argv[])
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
+	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 1),
+		    "Only performed %d KVM_RUNs, task stalled too much? \n"
+		    "  Try to run it with -s option, or disable deep sleep "
+		    "states in the system,\n"
+		    "  e.g., boot the host with cpuidle.off=1 or other driver "
+		    "specific kernel options,\n"
+		    "  or do it through the PM QoS interface at runtime: \n"
+		    "    cat > /dev/cpu_dma_latency <(echo -e -n "
+		    "\"\\x0\\x0\\x0\\x0\"; sleep inf) &\n"
+		    "    PID=$! && run_the_test && kill $PID" , i);
 
 	pthread_join(migration_thread, NULL);
 
-- 
2.34.1


