Return-Path: <linux-kselftest+bounces-40943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA992B48E09
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5B264E1AD0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD4A305955;
	Mon,  8 Sep 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9eY9XDF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE97303A00
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335699; cv=none; b=Rx+P0A+KSLpdi4wYj6epCyS6hqflEjHuO0noZZ1WQLJJO7p96OCoNEvemb6K4EnD05HA9ivdh1BvCASM4MO55h6MQc5b15Qi/81qa0L6DdQkX+428iwuUtLHEt2pLynehBfhq0Lr/5Xxratal1YltofR4IGMRPr2F3ptWO5Tsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335699; c=relaxed/simple;
	bh=X6xhglahevnhZRx7A+DO+5AgaPDVE6AJOdFfTLsCHig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEO9q+mv+U8l4gx1mBXlOeHz+S5qTA+Cwfg8NK79WpBkA17npIOM5WAn1IXgTL+fwDp1YqDQX9TydPcH52m3HiWa9C1ebZxHzzp/I8AseuUuRf7i1VZTmkADOQbPR4gZ+k8zarxBJE2AnE32ZZZZoy1vrwlXanstZHcbqkdEPDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9eY9XDF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757335695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1wY981ud5Z3idUNSxCEbfzkX8eAnGBWH4r/ijktaZU=;
	b=O9eY9XDFFBQ7fdTYmScPglUfYinWGCDrZwmb0/nr2Abaez/DRshJLgl3EYc7uqVH9TnKHU
	PndaSovt9ZYa2dOEM8/v+STqsnAShEcVd4ln35KsDSBk0O1LrkBUigJvwtKvnVk13Mub1C
	HRbj7VpJETwLkD0IzbHbmawxpLdX+AA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-bEnPIl8DNjOC7LI3ZP-KAg-1; Mon,
 08 Sep 2025 08:48:12 -0400
X-MC-Unique: bEnPIl8DNjOC7LI3ZP-KAg-1
X-Mimecast-MFC-AGG-ID: bEnPIl8DNjOC7LI3ZP-KAg_1757335690
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5675F1955F27;
	Mon,  8 Sep 2025 12:48:10 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB92E300018D;
	Mon,  8 Sep 2025 12:48:04 +0000 (UTC)
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
Subject: [PATCH v2 3/3] selftests/mm: fix va_high_addr_switch.sh failure on x86_64
Date: Mon,  8 Sep 2025 20:47:39 +0800
Message-ID: <20250908124740.2946005-4-chuhu@redhat.com>
In-Reply-To: <20250908124740.2946005-3-chuhu@redhat.com>
References: <20250908124740.2946005-1-chuhu@redhat.com>
 <20250908124740.2946005-2-chuhu@redhat.com>
 <20250908124740.2946005-3-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
addr + len is above the DFEFAULT_MAP_WINDOW, make the addr hint one
hugepage lower, so that after the align it's still within DEFAULT_MAP_WINDOW,
and the addr + len (2 hugepages) will be above DEFAULT_MAP_WINDOW.

Fixes: cc92882ee218 ("mm: drop hugetlb_get_unmapped_area{_*} functions")
Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 tools/testing/selftests/mm/va_high_addr_switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
index 896b3f73fc53..bd96dc3b5931 100644
--- a/tools/testing/selftests/mm/va_high_addr_switch.c
+++ b/tools/testing/selftests/mm/va_high_addr_switch.c
@@ -230,10 +230,10 @@ void testcases_init(void)
 			.msg = "mmap(-1, MAP_HUGETLB) again",
 		},
 		{
-			.addr = (void *)(addr_switch_hint - pagesize),
+			.addr = (void *)(addr_switch_hint - pagesize - hugepagesize),
 			.size = 2 * hugepagesize,
 			.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
-			.msg = "mmap(addr_switch_hint - pagesize, 2*hugepagesize, MAP_HUGETLB)",
+			.msg = "mmap(addr_switch_hint - pagesize - hugepagesize, 2*hugepagesize, MAP_HUGETLB)",
 			.low_addr_required = 1,
 			.keep_mapped = 1,
 		},
-- 
2.49.0


