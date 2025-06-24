Return-Path: <linux-kselftest+bounces-35665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2696CAE5B7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 06:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15867AA5B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 04:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0502253E9;
	Tue, 24 Jun 2025 04:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjnSynLh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D0A1DB148
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750739077; cv=none; b=YTAHZ483YPqfCyKtDLobQV0R0jkFE2vXDvtdhXOmy2yoG/sOq0MVGiPVagRPdGO10Drjg32R3qjzPQ1Vj2odUL6q2s1v5RbMDdWpZ6t2xoKzxFFAjrwY+IAFUnpD2qCY7zFDkyrazz/o9S7Sf4XzvkRw7caY7GIETy5F+G7qgrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750739077; c=relaxed/simple;
	bh=SdZAFXCVCSUefO2MM2Pu2MJdZLg2ZXG8KCxW3oEqo+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgHMjirnMj5D5jX8XDf3mnozcitrBP+Ys/GYhf8SWzB8PdZpkx1vA0fU+FHqS0XnLMdOqqVBoaaB87Yq6A2bey1O5tTvOIfbPN2cq5bxEysypRC6ZG8+LljXGqM6lPUPNLHHWJmJSKrBzS4T9tqdirn5bH/uZTvSTMpEE3270ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjnSynLh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750739074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPBeA/mE6tOBwRnlyiHyMiUuyxIPQVV8SBssXad99gU=;
	b=NjnSynLhpx2+kNvrhUaeA6tPonuuYtr8T5ehHB77R55VLzJYvZn1kPUSic7vpjAXL981j4
	p9SIHZpSoVvvr5zqz1rBq5OXKtROPHWo3DSBGapXYOGi5TXEnGfOnr4C74KA4b0ntvJyLU
	wdfUNY1rHKAEKCLGe9SOwfgEsNYWvM8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-X91ThBiuNuuWH4MFPuSUfg-1; Tue,
 24 Jun 2025 00:24:27 -0400
X-MC-Unique: X91ThBiuNuuWH4MFPuSUfg-1
X-Mimecast-MFC-AGG-ID: X91ThBiuNuuWH4MFPuSUfg_1750739065
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E6DA180034E;
	Tue, 24 Jun 2025 04:24:24 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0084B18003FC;
	Tue, 24 Jun 2025 04:24:16 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Keith Lucas <keith.lucas@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2] selftests/mm: Fix UFFDIO_API usage with proper two-step feature negotiation
Date: Tue, 24 Jun 2025 12:24:11 +0800
Message-ID: <20250624042411.395285-1-liwang@redhat.com>
In-Reply-To: <20250622081035.378164-1-liwang@redhat.com>
References: <20250622081035.378164-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
---

Notes:
    v1 --> v2:
    	* Close the original userfaultfd and open a new one before enabling features
    	* Reworked UFFDIO_API negotiation to follow the official two-step handshake

 .../selftests/mm/ksm_functional_tests.c       | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index b61803e36d1c..19e5b741893a 100644
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
+		ksft_test_result_skip("__NR_userfaultfd failed\n");
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


