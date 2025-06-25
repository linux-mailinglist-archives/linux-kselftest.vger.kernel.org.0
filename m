Return-Path: <linux-kselftest+bounces-35722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FADAE73EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 02:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9BB16EA64
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 00:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379607261E;
	Wed, 25 Jun 2025 00:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCBYjbEZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396881EEE6
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750812429; cv=none; b=jQdAmp1ez/99zyuk79cpIhoHplYlxiRlsqlsCfbdS76LMeuFIz3ZUxT/VhQrHhkKHa4TlRVVOD7ztug12THsvlMDixxKclVBlmW0dLbMtzr2ZHWfP2QMYNsDKS9yveckIRud1fJMo+5tTFfFjbIn97vNnJKmm5LUcPzPhgcBG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750812429; c=relaxed/simple;
	bh=A8YuiuYypENiIhwpCV2AZRqV1+TQMWXQbHQCPTi07p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMmOsVe5hQYnBNcg8Kln/3fXdLh4YP3U4+Fz9yWdgE/kkW9FtG633JEveNuN9NSaRbOlfZp9HNP33ZrNt5j0BypwbQi3PXUhn1TGbnQOaAqV+W/6tyQtDbfk8h3G0GZPDQNwgkdUQ+cGpQmDdtzVgMnffyY5PvsxMuZ3SAbWm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCBYjbEZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750812425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BVL90qI0uVy/+Q1mB+nKSY/ZtMcZOndhwt5gwwgQpzk=;
	b=UCBYjbEZhSWiM4WO8tvz3K/SvDtYOlpJQHgCRPnfGM6Qi6h3u7XdjwesowxXHSM3f6kk8y
	wfWqxSBv+6TM21NgXTlw3ITnzVpKpRKkqsn6cBmnM06PajilW6FPE3ZhzzgdNsbQ1O0MWf
	/dR3eQZNhy8wChre+OC+k4x9mrpIuOM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-RtPIR-3xNLaq7N9N4sbElg-1; Tue,
 24 Jun 2025 20:47:02 -0400
X-MC-Unique: RtPIR-3xNLaq7N9N4sbElg-1
X-Mimecast-MFC-AGG-ID: RtPIR-3xNLaq7N9N4sbElg_1750812420
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 739E6180028D;
	Wed, 25 Jun 2025 00:46:59 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8D5C19560A3;
	Wed, 25 Jun 2025 00:46:50 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	peterx@redhat.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Nadav Amit <nadav.amit@gmail.com>,
	Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Keith Lucas <keith.lucas@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v3] selftests/mm: Fix UFFDIO_API usage with proper two-step feature negotiation
Date: Wed, 25 Jun 2025 08:46:45 +0800
Message-ID: <20250625004645.400520-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The current implementation of test_unmerge_uffd_wp() explicitly sets
`uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP` before calling
UFFDIO_API. This can cause the ioctl() call to fail with EINVAL on kernels
that do not support UFFD-WP, leading the test to fail unnecessarily:

  # ------------------------------
  # running ./ksm_functional_tests
  # ------------------------------
  # TAP version 13
  # 1..9
  # # [RUN] test_unmerge
  # ok 1 Pages were unmerged
  # # [RUN] test_unmerge_zero_pages
  # ok 2 KSM zero pages were unmerged
  # # [RUN] test_unmerge_discarded
  # ok 3 Pages were unmerged
  # # [RUN] test_unmerge_uffd_wp
  # not ok 4 UFFDIO_API failed     <-----
  # # [RUN] test_prot_none
  # ok 5 Pages were unmerged
  # # [RUN] test_prctl
  # ok 6 Setting/clearing PR_SET_MEMORY_MERGE works
  # # [RUN] test_prctl_fork
  # # No pages got merged
  # # [RUN] test_prctl_fork_exec
  # ok 7 PR_SET_MEMORY_MERGE value is inherited
  # # [RUN] test_prctl_unmerge
  # ok 8 Pages were unmerged
  # Bail out! 1 out of 8 tests failed
  # # Planned tests != run tests (9 != 8)
  # # Totals: pass:7 fail:1 xfail:0 xpass:0 skip:0 error:0
  # [FAIL]

This patch improves compatibility and robustness of the UFFD-WP test
(test_unmerge_uffd_wp) by correctly implementing the UFFDIO_API
two-step handshake as recommended by the userfaultfd(2) man page.

Key changes:

1. Use features=0 in the initial UFFDIO_API call to query supported
   feature bits, rather than immediately requesting WP support.

2. Skip the test gracefully if:
   - UFFDIO_API fails with EINVAL (e.g. unsupported API version), or
   - UFFD_FEATURE_PAGEFAULT_FLAG_WP is not advertised by the kernel.

3. Close the initial userfaultfd and create a new one before enabling
   the required feature, since UFFDIO_API can only be called once per fd.

4. Improve diagnostics by distinguishing between expected and unexpected
   failures, using strerror() to report errors.

This ensures the test behaves correctly across a wider range of kernel
versions and configurations, while preserving the intended behavior on
kernels that support UFFD-WP.

Suggestted-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index b61803e36d1c..d8bd1911dfc0 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -393,9 +393,13 @@ static void test_unmerge_uffd_wp(void)
 
 	/* See if UFFD-WP is around. */
 	uffdio_api.api = UFFD_API;
-	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+	uffdio_api.features = 0;
 	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
-		ksft_test_result_fail("UFFDIO_API failed\n");
+		if (errno == EINVAL)
+			ksft_test_result_skip("The API version requested is not supported\n");
+		else
+			ksft_test_result_fail("UFFDIO_API failed: %s\n", strerror(errno));
+
 		goto close_uffd;
 	}
 	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
@@ -403,6 +407,26 @@ static void test_unmerge_uffd_wp(void)
 		goto close_uffd;
 	}
 
+	/*
+	 * UFFDIO_API must only be called once to enable features.
+	 * So we close the old userfaultfd and create a new one to
+	 * actually enable UFFD_FEATURE_PAGEFAULT_FLAG_WP.
+	 */
+	close(uffd);
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0) {
+		ksft_test_result_fail("__NR_userfaultfd failed\n");
+		goto unmap;
+	}
+
+	/* Now, enable it ("two-step handshake") */
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
+		ksft_test_result_fail("UFFDIO_API failed: %s\n", strerror(errno));
+		goto close_uffd;
+	}
+
 	/* Register UFFD-WP, no need for an actual handler. */
 	if (uffd_register(uffd, map, size, false, true, false)) {
 		ksft_test_result_fail("UFFDIO_REGISTER_MODE_WP failed\n");
-- 
2.49.0


