Return-Path: <linux-kselftest+bounces-35570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6318AE2ED1
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 10:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AAE3B439F
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0083519D09C;
	Sun, 22 Jun 2025 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNfH/OKu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27719C13D
	for <linux-kselftest@vger.kernel.org>; Sun, 22 Jun 2025 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750579859; cv=none; b=iYk0gMd48JdaD2Y/8w7XjaPFi84HAyLpLu5eqfF7PA3TP+2SeKdo9MG96x6MuFOXn6HLP6fgan0bQyLv9OQsGlEBCD79/rLoun4u1hvWWGMmNkyPBfIR+PgKHW411hD9LwP+GK9ZdYilQQrCtecvBBgCcxyI221citfIbRfbv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750579859; c=relaxed/simple;
	bh=UjUkialeHhsKRtYdJ+ntVpN4THoYDB4Ztuo/IR/1obg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGsuX5/XhS9iK2n4E957tAcqYhlnTfZOSgwomURlLxxeSuJK7KrUsaUx0uK8RmtQDgaKzViTVMciZQnWLHzEfYtECBsQ4zK+J10i8nEkl/Cr4Qsn8PcAJjxBFebqyDu0Sl8Nsy/yP80zNs6cs/pNHF7KgpuIVEmF9HGELKzX5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNfH/OKu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750579854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q8/rI4IAgVs+NRa+vTa1gDWf15Ja/4IU/WEAKTpWEJ0=;
	b=bNfH/OKulPlIDU0JmjDnl4Qb07+gl88XnhPPqabMK+zTqWoS9Xg0x5sLVTUMG+gUNDzmiy
	OFGj4oQyZWlw0KpFw1l9PeIzufYLIbEAdICzsMbILXnH0B5RqXeT5mHmPp+YP6QROeXFIJ
	pKM5PD3j0HjZViTfvS/H7Smko5SbqzY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-j_PRBuV7P26oHEuAD19uDA-1; Sun,
 22 Jun 2025 04:10:50 -0400
X-MC-Unique: j_PRBuV7P26oHEuAD19uDA-1
X-Mimecast-MFC-AGG-ID: j_PRBuV7P26oHEuAD19uDA_1750579848
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C794C180034E;
	Sun, 22 Jun 2025 08:10:47 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D36F9195608D;
	Sun, 22 Jun 2025 08:10:40 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Keith Lucas <keith.lucas@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] mm/selftests: improve UFFD-WP feature detection in KSM test
Date: Sun, 22 Jun 2025 16:10:35 +0800
Message-ID: <20250622081035.378164-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

This patch improves compatibility and error handling by:

1. Changes the feature check to first query supported features (features=0)
   rather than specifically requesting WP support.

2. Gracefully skipping the test if:
   - UFFDIO_API fails with EINVAL (feature not supported), or
   - UFFD_FEATURE_PAGEFAULT_FLAG_WP is not advertised by the kernel.

3. Providing better diagnostics by distinguishing expected failures (e.g.,
   EINVAL) from unexpected ones and reporting them using strerror().

The updated logic makes the test more robust across different kernel versions
and configurations, while preserving existing behavior on systems that do
support UFFD-WP.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/mm/ksm_functional_tests.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index b61803e36d1c..f3db257dc555 100644
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
+			ksft_test_result_skip("UFFDIO_API not supported (EINVAL)\n");
+		else
+			ksft_test_result_fail("UFFDIO_API failed: %s\n", strerror(errno));
+
 		goto close_uffd;
 	}
 	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
-- 
2.49.0


