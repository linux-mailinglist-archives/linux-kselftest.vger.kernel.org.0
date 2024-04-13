Return-Path: <linux-kselftest+bounces-7906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A37D8A3B23
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 07:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99026284511
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C81C6A7;
	Sat, 13 Apr 2024 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTSYxxJM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD091B964
	for <linux-kselftest@vger.kernel.org>; Sat, 13 Apr 2024 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712986677; cv=none; b=TVgkuehumgkZBWFZoH+uKufsaWW/2c5c3IhUtjTXVr8m57+bXrqgxzRnd8uaePwBFrF0Copdshwt1gYZczaBYu7zIHnPJYG64Gsagss/YFxhQMHIj+tmR8Il91jp+BKv2CINhJfhg4/XI8Ivd11aXK3NryLlr7XGJ4va2GN5bxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712986677; c=relaxed/simple;
	bh=rVL1xQVoKy4gk8vO+651RDr6vF77+SEbo9DiR69GE4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LfTyjPD+ujiRY86LB0vAXiPXF9bVAcoy7hxS9b4uZuPKqzycsdsm7ckHDHlYuvLLB2chVLx8IGvpOjdG8fdqy6XLOXoENbUb5n5c6ImUil7PBe3UXZWBcuq8j1IGrlze33tMy/zEu4SyiYUaZLX488Uwsx8cYRT5iRId/rMUJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTSYxxJM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712986676; x=1744522676;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rVL1xQVoKy4gk8vO+651RDr6vF77+SEbo9DiR69GE4w=;
  b=aTSYxxJMLyAMrZFRmHZwub9YRNJBr10rLdRZDdwZrh+0hfbzowceyCF9
   ObDcvA/cAlLIW/D8SahSwHKD4apasW2vqRaThS4WkA8+JD9ny+llgCEfq
   hg+7L5czK0s821P7oFENVmtX4HprylLdtZ8OKeFjVeFcDZj3xgxyqhyPf
   YL8XUSOJlVvPxxIa6mLn7UswI5S5Lz7nqxkES5UYDditWmCC9SOj2JgrG
   OMS6JI69v43deesjOIEzX4k1LV4AuzST/jJcsxeLKHDEM11hfXBDaKY4N
   k8I8L2OrMPPhLHl907b5J5NVoWxaglEB9ePVKQ2PmlLoVNEIHCrspyS9N
   w==;
X-CSE-ConnectionGUID: 3+k308VWTV+wvCtmrj4aAA==
X-CSE-MsgGUID: ODLY7K8QTU2r+bsVkfVmnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19052359"
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="19052359"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 22:37:55 -0700
X-CSE-ConnectionGUID: 8Fba70xsQJqmqginSYuxJg==
X-CSE-MsgGUID: RWLtwk9PQzKPU+QJJH5tTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="26213759"
Received: from 984fee00c67b.jf.intel.com ([10.23.0.114])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 22:37:54 -0700
From: Zide Chen <zide.chen@intel.com>
To: linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2] KVM: selftests: Take large C-state exit latency into consideration
Date: Fri, 12 Apr 2024 22:37:49 -0700
Message-Id: <20240413053749.74313-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the migration worker delays 1-10 us, assuming that one
KVM_RUN iteration only takes a few microseconds.  But if C-state exit
latencies are large enough, for example, hundreds or even thousands
of microseconds on server CPUs, it may happen that it's not able to
bring the target CPU out of C-state before the migration worker starts
to migrate it to the next CPU.

If the system workload is light, most CPUs could be at a certain level
of C-state, which may result in less successful migrations and fail the
migration/KVM_RUN ratio sanity check.

This patch adds a command line option to skip the sanity check in
this case.

Additionally, seems it's reasonable to randomize the length of usleep(),
other than delay in a fixed pattern.

V2:
- removed the busy loop implementation
- add the new "-s" option

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 37 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 28f97fb52044..515cfa32a925 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -150,7 +150,7 @@ static void *migration_worker(void *__rseq_tid)
 		 * Use usleep() for simplicity and to avoid unnecessary kernel
 		 * dependencies.
 		 */
-		usleep((i % 10) + 1);
+		usleep((rand() % 10) + 1);
 	}
 	done = true;
 	return NULL;
@@ -186,12 +186,35 @@ static void calc_min_max_cpu(void)
 		       "Only one usable CPU, task migration not possible");
 }
 
+static void usage(const char *name)
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
+			usage(argv[0]);
+			break;
+		}
+	}
 
 	r = sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
 	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)", errno,
@@ -199,6 +222,8 @@ int main(int argc, char *argv[])
 
 	calc_min_max_cpu();
 
+	srand(time(NULL));
+
 	r = rseq_register_current_thread();
 	TEST_ASSERT(!r, "rseq_register_current_thread failed, errno = %d (%s)",
 		    errno, strerror(errno));
@@ -254,9 +279,15 @@ int main(int argc, char *argv[])
 	 * getcpu() to stabilize.  A 2:1 migration:KVM_RUN ratio is a fairly
 	 * conservative ratio on x86-64, which can do _more_ KVM_RUNs than
 	 * migrations given the 1us+ delay in the migration task.
+	 *
+	 * Another reason why it may have small migration:KVM_RUN ratio is that,
+	 * on systems with large C-state exit latency, it may happen quite often
+	 * that the scheduler is not able to wake up the target CPU before the
+	 * vCPU thread is scheduled to another CPU.
 	 */
-	TEST_ASSERT(i > (NR_TASK_MIGRATIONS / 2),
-		    "Only performed %d KVM_RUNs, task stalled too much?", i);
+	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 2),
+		    "Only performed %d KVM_RUNs, task stalled too much? "
+		    "Try to turn off C-states or run it with the -s option", i);
 
 	pthread_join(migration_thread, NULL);
 
-- 
2.34.1


