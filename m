Return-Path: <linux-kselftest+bounces-41276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04723B53FF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 03:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF11F7C0BF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 01:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479321991D4;
	Fri, 12 Sep 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6oS1ctG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767717A2E6
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641070; cv=none; b=Q8UJC4TdJ8IVVtzcpEygmPJAGwGuAAd7qXxNcnvCheEIT99wMsGaz1DJZVxcMEKfMYceJD/TYnYRNtnaFbfn/L6JjQCG1QjNbsYkPEVdOcnoxuTqCuBcIcC1X3by4AreAjmGmfUj1AjWoy84dw+WUMr2vHRcwrlHNq87OpncXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641070; c=relaxed/simple;
	bh=bp0U7YdJ9G9ovtdDdz6jrw8/OE9W6Ji5ywTshcRRp0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg4/+3hugeUlpiiBwqn9oo96peGOP38F41/jrqkIonzlKMqEz8x25EjCQq8XzJPovPnrRTjjH3RjZKibZ1MDFoGsQHmvEg4onDoue67eISVt/ppkzeGjIa3DB4L1S2iamwGLtebtbjFoaUJO0FJav93BIbzrnJ0BLpbKGXYSRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6oS1ctG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757641067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+D1zQTiTnlEZqnFCgmfLcL4sMppDPwHxOoeZoJwx6to=;
	b=d6oS1ctG2WpsHfn2jUxL/AfvOL9eGA1nHThlNy0g1u1uc1EypktE7x8ob2ighapjFXf/Ok
	L+V4UKKHIT6XBF1sCMintmTyn2Bmq5c51WIWE3nvF9DVeFEpj47vEM8qE91UHWzrR9DBzM
	iOgaJ8vvfYnnJFYBnfrg+D9mig9mbYA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-1IyLpvnVOwmbrj65fPzDkQ-1; Thu,
 11 Sep 2025 21:37:43 -0400
X-MC-Unique: 1IyLpvnVOwmbrj65fPzDkQ-1
X-Mimecast-MFC-AGG-ID: 1IyLpvnVOwmbrj65fPzDkQ_1757641062
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31BFA1955EA8;
	Fri, 12 Sep 2025 01:37:42 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A15B1800452;
	Fri, 12 Sep 2025 01:37:36 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org,
	linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	chuhu@redhat.com
Subject: [PATCH v3 3/3] selftests/mm: fix va_high_addr_switch.sh failure on x86_64
Date: Fri, 12 Sep 2025 09:37:11 +0800
Message-ID: <20250912013711.3002969-4-chuhu@redhat.com>
In-Reply-To: <20250912013711.3002969-3-chuhu@redhat.com>
References: <20250912013711.3002969-1-chuhu@redhat.com>
 <20250912013711.3002969-2-chuhu@redhat.com>
 <20250912013711.3002969-3-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The test will fail as below on x86_64 with cpu la57 support (will skip if
no la57 support). Note, the test requries nr_hugepages to be set first.

  # running bash ./va_high_addr_switch.sh
  # -------------------------------------
  # mmap(addr_switch_hint - pagesize, pagesize): 0x7f55b60fa000 - OK
  # mmap(addr_switch_hint - pagesize, (2 * pagesize)): 0x7f55b60f9000 - OK
  # mmap(addr_switch_hint, pagesize): 0x800000000000 - OK
  # mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0x800000000000 - OK
  # mmap(NULL): 0x7f55b60f9000 - OK
  # mmap(low_addr): 0x40000000 - OK
  # mmap(high_addr): 0x1000000000000 - OK
  # mmap(high_addr) again: 0xffff55b6136000 - OK
  # mmap(high_addr, MAP_FIXED): 0x1000000000000 - OK
  # mmap(-1): 0xffff55b6134000 - OK
  # mmap(-1) again: 0xffff55b6132000 - OK
  # mmap(addr_switch_hint - pagesize, pagesize): 0x7f55b60fa000 - OK
  # mmap(addr_switch_hint - pagesize, 2 * pagesize): 0x7f55b60f9000 - OK
  # mmap(addr_switch_hint - pagesize/2 , 2 * pagesize): 0x7f55b60f7000 - OK
  # mmap(addr_switch_hint, pagesize): 0x800000000000 - OK
  # mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0x800000000000 - OK
  # mmap(NULL, MAP_HUGETLB): 0x7f55b5c00000 - OK
  # mmap(low_addr, MAP_HUGETLB): 0x40000000 - OK
  # mmap(high_addr, MAP_HUGETLB): 0x1000000000000 - OK
  # mmap(high_addr, MAP_HUGETLB) again: 0xffff55b5e00000 - OK
  # mmap(high_addr, MAP_FIXED | MAP_HUGETLB): 0x1000000000000 - OK
  # mmap(-1, MAP_HUGETLB): 0x7f55b5c00000 - OK
  # mmap(-1, MAP_HUGETLB) again: 0x7f55b5a00000 - OK
  # mmap(addr_switch_hint - pagesize, 2*hugepagesize, MAP_HUGETLB): 0x800000000000 - FAILED
  # mmap(addr_switch_hint , 2*hugepagesize, MAP_FIXED | MAP_HUGETLB): 0x800000000000 - OK
  # [FAIL]

addr_switch_hint is defined as DFEFAULT_MAP_WINDOW in the failed test (for
x86_64, DFEFAULT_MAP_WINDOW is defined as (1UL<<47) - pagesize) in 64 bit.

Before commit cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*}
functions"), for x86_64 hugetlb_get_unmapped_area() is handled in arch code
arch/x86/mm/hugetlbpage.c and addr is checked with map_address_hint_valid()
after align with 'addr &= huge_page_mask(h)' which is a round down way, and
it will fail the check because the addr is within the DEFAULT_MAP_WINDOW but
(addr + len) is above the DFEFAULT_MAP_WINDOW. So it wil go through the
hugetlb_get_unmmaped_area_top_down() to find an area within the
DFEFAULT_MAP_WINDOW.

After commit cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*}
functions").  The addr hint for hugetlb_get_unmmaped_area() will be rounded
up and aligned to hugepage size with ALIGN() for all arches.  And after the
align, the addr will be above the default MAP_DEFAULT_WINDOW, and the
map_addresshint_valid() check will pass because both aligned addr (addr0)
and (addr + len) are above the DEFAULT_MAP_WINDOW, and the aligned hint
address (0x800000000000) is returned as an suitable gap is found there,
in arch_get_unmapped_area_topdown().

To still cover the case that addr is within the DEFAULT_MAP_WINDOW, and
addr + len is above the DFEFAULT_MAP_WINDOW, change to choose the last
hugepage aligned address within the DEFAULT_MAP_WINDOW as the hint addr,
and the addr + len (2 hugepages) will be one hugepage above the
DEFAULT_MAP_WINDOW.  An aligned address won't be affected by the page
round up or round down from kernel, so it's determistic.

Fixes: cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*} functions")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 tools/testing/selftests/mm/va_high_addr_switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
index 896b3f73fc53..306eba825107 100644
--- a/tools/testing/selftests/mm/va_high_addr_switch.c
+++ b/tools/testing/selftests/mm/va_high_addr_switch.c
@@ -230,10 +230,10 @@ void testcases_init(void)
 			.msg = "mmap(-1, MAP_HUGETLB) again",
 		},
 		{
-			.addr = (void *)(addr_switch_hint - pagesize),
+			.addr = (void *)(addr_switch_hint - hugepagesize),
 			.size = 2 * hugepagesize,
 			.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
-			.msg = "mmap(addr_switch_hint - pagesize, 2*hugepagesize, MAP_HUGETLB)",
+			.msg = "mmap(addr_switch_hint - hugepagesize, 2*hugepagesize, MAP_HUGETLB)",
 			.low_addr_required = 1,
 			.keep_mapped = 1,
 		},
-- 
2.49.0


