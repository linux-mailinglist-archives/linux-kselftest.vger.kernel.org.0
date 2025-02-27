Return-Path: <linux-kselftest+bounces-27711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E7A47434
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 05:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6755F16F2D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 04:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E0AC2FB;
	Thu, 27 Feb 2025 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWd8fN+/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE77188006
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 04:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629738; cv=none; b=Chi1dXqvBUGwzeH6AOYW8YDHzpLs0lthRCL8rrvSje+9K5LvLt1Z1Agog6oebSJGrpBeE0pFSQ4ltHCX7uyIK9+A1pkx+YMWrA1Rf4ylVpHh8++CLLzCpAibuM8+pbp6MBot6hR+6532LjZLsxePvBHKZ8iMJISb9XjFLTRH6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629738; c=relaxed/simple;
	bh=i0P3oKURB+E0lUIrcY5OeJO3AwVoYL0kp6OuxUk1Ptw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=brNUXTy1dzPHZv0ogLmczprl4hqtMruACcQt6aim9Gj5Mv52nbyIrY18ksw8IjXIPesvBDbVjyBWcQzjWSNmpWVt96b04KvZ6yNGWLbMcSX3yjn4MfaxUAINR4nct9e8DY0xvrpdglhJtUAwmmqfiSHsR8KV8U8ndRL+1NJSP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWd8fN+/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740629735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LzMafZg7Owg9vjJaHS40UzrgTQRclUEj2q21FtbKF/A=;
	b=NWd8fN+/1UBgBjXfptzlyTqaLXbQpuyk+8/nt/zcTq5Ut7iBraKCA4yvUjXYIGbFgRp1hL
	nbHKBXQTYuRIys9uq+ZfT2aUtkp44UHRqkyRVG4GG39o/g1cRSnf6eJoASlyzi+2CjPVbG
	iW28Q/zH0Yp/466/lecpY9wDBzzKWyU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-WVLY5IonPhKzJ87A7qlsJw-1; Wed,
 26 Feb 2025 23:15:31 -0500
X-MC-Unique: WVLY5IonPhKzJ87A7qlsJw-1
X-Mimecast-MFC-AGG-ID: WVLY5IonPhKzJ87A7qlsJw_1740629729
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F211119560B9;
	Thu, 27 Feb 2025 04:15:25 +0000 (UTC)
Received: from starship.lan (unknown [10.2.18.180])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F5DF180035E;
	Thu, 27 Feb 2025 04:15:23 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	James Houghton <jthoughton@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Anup Patel <anup@brainfault.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH] KVM: selftests: access_tracking_perf_test: add option to skip the sanity check
Date: Wed, 26 Feb 2025 23:15:22 -0500
Message-Id: <20250227041522.1734260-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add an option to skip sanity check of number of still idle pages,
and force it on, in case hypervisor or NUMA balancing
is detected.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../selftests/kvm/access_tracking_perf_test.c | 23 +++++++++++++++++--
 .../testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 3c7defd34f56..eafaecf086c4 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -65,6 +65,8 @@ static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
 /* Whether to overlap the regions of memory vCPUs access. */
 static bool overlap_memory_access;
 
+static bool skip_sanity_check;
+
 struct test_params {
 	/* The backing source for the region of memory. */
 	enum vm_mem_backing_src_type backing_src;
@@ -185,7 +187,7 @@ static void mark_vcpu_memory_idle(struct kvm_vm *vm,
 	 */
 	if (still_idle >= pages / 10) {
 #ifdef __x86_64__
-		TEST_ASSERT(this_cpu_has(X86_FEATURE_HYPERVISOR),
+		TEST_ASSERT(skip_sanity_check,
 			    "vCPU%d: Too many pages still idle (%lu out of %lu)",
 			    vcpu_idx, still_idle, pages);
 #endif
@@ -342,6 +344,8 @@ static void help(char *name)
 	printf(" -v: specify the number of vCPUs to run.\n");
 	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
 	       "     them into a separate region of memory for each vCPU.\n");
+	printf(" -u: Skip check that after dirtying the guest memory, most (90%%) of\n"
+	       "it is reported as dirty again");
 	backing_src_help("-s");
 	puts("");
 	exit(0);
@@ -359,7 +363,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hm:b:v:os:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:b:v:os:u")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -376,6 +380,9 @@ int main(int argc, char *argv[])
 		case 's':
 			params.backing_src = parse_backing_src_type(optarg);
 			break;
+		case 'u':
+			skip_sanity_check = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -386,6 +393,18 @@ int main(int argc, char *argv[])
 	page_idle_fd = open("/sys/kernel/mm/page_idle/bitmap", O_RDWR);
 	__TEST_REQUIRE(page_idle_fd >= 0,
 		       "CONFIG_IDLE_PAGE_TRACKING is not enabled");
+
+
+	if (skip_sanity_check == false) {
+		if (this_cpu_has(X86_FEATURE_HYPERVISOR)) {
+			printf("Skipping idle page count sanity check, because the test is run nested\n");
+			skip_sanity_check = true;
+		} else if (is_numa_balancing_enabled()) {
+			printf("Skipping idle page count sanity check, because NUMA balance is enabled\n");
+			skip_sanity_check = true;
+		}
+	}
+
 	close(page_idle_fd);
 
 	for_each_guest_mode(run_test, &params);
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 3e473058849f..1bc9b0a92427 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -153,6 +153,7 @@ bool is_backing_src_hugetlb(uint32_t i);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
 long get_run_delay(void);
+bool is_numa_balancing_enabled(void);
 
 /*
  * Whether or not the given source type is shared memory (as opposed to
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 8ed0b74ae837..1271863613fa 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -163,6 +163,28 @@ size_t get_trans_hugepagesz(void)
 	return size;
 }
 
+
+bool is_numa_balancing_enabled(void)
+{
+	int ret;
+	int val;
+	struct stat statbuf;
+	FILE *f;
+
+	ret = stat("/proc/sys/kernel/numa_balancing", &statbuf);
+	TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
+			"Error in stating /proc/sys/kernel/numa_balancing");
+
+	if (ret != 0)
+		return false;
+
+	f = fopen("/proc/sys/kernel/numa_balancing", "r");
+	ret = fscanf(f, "%d", &val);
+
+	TEST_ASSERT(val == 0 || val == 1, "Unexpected value in /proc/sys/kernel/numa_balancing");
+	return val == 1;
+}
+
 size_t get_def_hugetlb_pagesz(void)
 {
 	char buf[64];
-- 
2.26.3


