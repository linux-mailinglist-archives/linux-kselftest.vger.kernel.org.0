Return-Path: <linux-kselftest+bounces-29729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D91A6E827
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 02:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2701896D28
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 01:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5463F1891AA;
	Tue, 25 Mar 2025 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6r7GxtJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AC178CF8
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867878; cv=none; b=IfR59CYZTQr+FLFZhjhrhv114C4LTSzknxAcYl7x5CytdLRlR19FDJEtzUi/H6npMaorxj288IMPR7lWVeJZh031Nzue+nHOExq+KFmRzRGhuCDVVOe3cukouFL+WuhB4wSUdylM7uWUBKmcV2agkcjE6ebzxrW7OvBS/K76XY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867878; c=relaxed/simple;
	bh=ugsMpxNkJUSFp+7lz8ioeDr01ht/xTBvE8gTxUNDI9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTkJ+qGdp4v8YJ+V2i70BDBEXf/XG3kosH/Nkf9zAkAJ2ibVZfmAKGkQF17TewQVTLDWCdNFTZZwAOTj3OXlYFT7lwlYsm63TbGLzN1ZgV9huAOBad/MS44YeINu54M0ZKDAqCS5fIjT9z0ORDzTAvGDub2JmyOgp9Gnct0WnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6r7GxtJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742867875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ8V4OG2SIBR15qRmgINunGJlllawBsHryHVXkf+1VU=;
	b=S6r7GxtJCD6/GXxcDswQl+yWPVHx+PBBbJTJtVijLyFpi9g+qprbRqsmoitwy/z2715NBJ
	B+p6SJy5/oNL6ONqZhITKDfdahCef4sTywPxoGGYabCurt09SBl8guy6D32ZFRWeznTQyA
	0QIfw1gW6Ke5g49+StdCuw0wpOETdgU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-QrdUzY6RNTiwNCnTTmx6UQ-1; Mon,
 24 Mar 2025 21:57:52 -0400
X-MC-Unique: QrdUzY6RNTiwNCnTTmx6UQ-1
X-Mimecast-MFC-AGG-ID: QrdUzY6RNTiwNCnTTmx6UQ_1742867870
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3680619560BB;
	Tue, 25 Mar 2025 01:57:50 +0000 (UTC)
Received: from starship.lan (unknown [10.22.65.191])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE190180176A;
	Tue, 25 Mar 2025 01:57:47 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	James Houghton <jthoughton@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 2/2] KVM: selftests: access_tracking_perf_test: add option to skip the sanity check
Date: Mon, 24 Mar 2025 21:57:41 -0400
Message-Id: <20250325015741.2478906-3-mlevitsk@redhat.com>
In-Reply-To: <20250325015741.2478906-1-mlevitsk@redhat.com>
References: <20250325015741.2478906-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add an option to skip sanity check of number of still idle pages,
and set it by default to skip, in case hypervisor or NUMA balancing
is detected.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../selftests/kvm/access_tracking_perf_test.c | 33 ++++++++++++++++---
 .../testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/test_util.c   |  7 ++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 3c7defd34f56..6d50c829f00c 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -65,6 +65,8 @@ static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
 /* Whether to overlap the regions of memory vCPUs access. */
 static bool overlap_memory_access;
 
+static int warn_on_too_many_idle_pages = -1;
+
 struct test_params {
 	/* The backing source for the region of memory. */
 	enum vm_mem_backing_src_type backing_src;
@@ -184,11 +186,10 @@ static void mark_vcpu_memory_idle(struct kvm_vm *vm,
 	 * are cached and the guest won't see the "idle" bit cleared.
 	 */
 	if (still_idle >= pages / 10) {
-#ifdef __x86_64__
-		TEST_ASSERT(this_cpu_has(X86_FEATURE_HYPERVISOR),
+		TEST_ASSERT(warn_on_too_many_idle_pages,
 			    "vCPU%d: Too many pages still idle (%lu out of %lu)",
 			    vcpu_idx, still_idle, pages);
-#endif
+
 		printf("WARNING: vCPU%d: Too many pages still idle (%lu out of %lu), "
 		       "this will affect performance results.\n",
 		       vcpu_idx, still_idle, pages);
@@ -342,6 +343,8 @@ static void help(char *name)
 	printf(" -v: specify the number of vCPUs to run.\n");
 	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
 	       "     them into a separate region of memory for each vCPU.\n");
+	printf(" -w: Skip or force enable the check that after dirtying the guest memory, most (90%%) of \n"
+	       "it is reported as dirty again (0/1)");
 	backing_src_help("-s");
 	puts("");
 	exit(0);
@@ -359,7 +362,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hm:b:v:os:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:b:v:os:w:")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -376,6 +379,11 @@ int main(int argc, char *argv[])
 		case 's':
 			params.backing_src = parse_backing_src_type(optarg);
 			break;
+		case 'w':
+			warn_on_too_many_idle_pages =
+				atoi_non_negative("1 - enable warning, 0 - disable",
+						  optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -386,6 +394,23 @@ int main(int argc, char *argv[])
 	page_idle_fd = open("/sys/kernel/mm/page_idle/bitmap", O_RDWR);
 	__TEST_REQUIRE(page_idle_fd >= 0,
 		       "CONFIG_IDLE_PAGE_TRACKING is not enabled");
+	if (warn_on_too_many_idle_pages == -1) {
+#ifdef __x86_64__
+		if (this_cpu_has(X86_FEATURE_HYPERVISOR)) {
+			printf("Skipping idle page count sanity check, because the test is run nested\n");
+			warn_on_too_many_idle_pages = 0;
+		} else
+#endif
+		if (is_numa_balancing_enabled()) {
+			printf("Skipping idle page count sanity check, because NUMA balance is enabled\n");
+			warn_on_too_many_idle_pages = 0;
+		} else {
+			warn_on_too_many_idle_pages = 1;
+		}
+	} else if (!warn_on_too_many_idle_pages) {
+		printf("Skipping idle page count sanity check, because this was requested by the user\n");
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
index 3dc8538f5d69..03eb99af9b8d 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -176,6 +176,13 @@ size_t get_trans_hugepagesz(void)
 	return get_sysfs_val("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size");
 }
 
+bool is_numa_balancing_enabled(void)
+{
+	if (!test_sysfs_path("/proc/sys/kernel/numa_balancing"))
+		return false;
+	return get_sysfs_val("/proc/sys/kernel/numa_balancing") == 1;
+}
+
 size_t get_def_hugetlb_pagesz(void)
 {
 	char buf[64];
-- 
2.26.3


