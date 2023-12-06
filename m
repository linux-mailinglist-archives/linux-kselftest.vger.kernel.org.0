Return-Path: <linux-kselftest+bounces-1256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7821806C0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C531F211B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17451B29C;
	Wed,  6 Dec 2023 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uyj4DEJD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEC12F
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 02:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701858965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WQ7x2ePi4wPqgcy9UtrNKCA+HmaOdfg4ZJ2pa42/YJE=;
	b=Uyj4DEJDTWnXIUb96iYxXRbGZzvqQQpKI1LX/7lVfCT4d4Nt2YtAuNSf1TPX9R35nZTLsg
	rgGEZCrNahWnZripPYrleo5W6K9ajwZs8CsRUcRKr8QP8ouCH66BVagmgMXTreWNXVVZJs
	n0KpORhjowKF9EtCe2tLrVRDM7V1xS8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-G62fAps4PdW2LwnnG9nc_w-1; Wed,
 06 Dec 2023 05:36:01 -0500
X-MC-Unique: G62fAps4PdW2LwnnG9nc_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45FE23C0F363;
	Wed,  6 Dec 2023 10:36:01 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA69740C6EB9;
	Wed,  6 Dec 2023 10:35:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Nico Pache <npache@redhat.com>
Subject: [PATCH v1] selftests/mm: cow: print ksft header before printing anything else
Date: Wed,  6 Dec 2023 11:35:58 +0100
Message-ID: <20231206103558.38040-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Doing a ksft_print_msg() before the ksft_print_header() seems to confuse
the ksft framework in a strange way: running the test on the cmdline
results in the expected output.

But piping the output somewhere else, results in some odd output,
whereby we repeatedly get the same info printed:
	# [INFO] detected THP size: 2048 KiB
	# [INFO] detected hugetlb page size: 2048 KiB
	# [INFO] detected hugetlb page size: 1048576 KiB
	# [INFO] huge zeropage is enabled
	TAP version 13
	1..190
	# [INFO] Anonymous memory tests in private mappings
	# [RUN] Basic COW after fork() ... with base page
	# [INFO] detected THP size: 2048 KiB
	# [INFO] detected hugetlb page size: 2048 KiB
	# [INFO] detected hugetlb page size: 1048576 KiB
	# [INFO] huge zeropage is enabled
	TAP version 13
	1..190
	# [INFO] Anonymous memory tests in private mappings
	# [RUN] Basic COW after fork() ... with base page
	ok 1 No leak from parent into child
	# [RUN] Basic COW after fork() ... with swapped out base page
	# [INFO] detected THP size: 2048 KiB
	# [INFO] detected hugetlb page size: 2048 KiB
	# [INFO] detected hugetlb page size: 1048576 KiB
	# [INFO] huge zeropage is enabled

Doing the ksft_print_header() first seems to resolve that and gives us
the output we expect:
	TAP version 13
	# [INFO] detected THP size: 2048 KiB
	# [INFO] detected hugetlb page size: 2048 KiB
	# [INFO] detected hugetlb page size: 1048576 KiB
	# [INFO] huge zeropage is enabled
	1..190
	# [INFO] Anonymous memory tests in private mappings
	# [RUN] Basic COW after fork() ... with base page
	ok 1 No leak from parent into child
	# [RUN] Basic COW after fork() ... with swapped out base page
	ok 2 No leak from parent into child
	# [RUN] Basic COW after fork() ... with THP
	ok 3 No leak from parent into child
	# [RUN] Basic COW after fork() ... with swapped-out THP
	ok 4 No leak from parent into child
	# [RUN] Basic COW after fork() ... with PTE-mapped THP
	ok 5 No leak from parent into child

Reported-by: Nico Pache <npache@redhat.com>
Fixes: f4b5fd6946e2 ("selftests/vm: anon_cow: THP tests")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/cow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 7324ce5363c0c..6f2f839904416 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1680,6 +1680,8 @@ int main(int argc, char **argv)
 {
 	int err;
 
+	ksft_print_header();
+
 	pagesize = getpagesize();
 	thpsize = read_pmd_pagesize();
 	if (thpsize)
@@ -1689,7 +1691,6 @@ int main(int argc, char **argv)
 						    ARRAY_SIZE(hugetlbsizes));
 	detect_huge_zeropage();
 
-	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(anon_test_cases) * tests_per_anon_test_case() +
 		      ARRAY_SIZE(anon_thp_test_cases) * tests_per_anon_thp_test_case() +
 		      ARRAY_SIZE(non_anon_test_cases) * tests_per_non_anon_test_case());
-- 
2.41.0


