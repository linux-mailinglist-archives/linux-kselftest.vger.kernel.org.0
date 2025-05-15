Return-Path: <linux-kselftest+bounces-33013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F291AB7C5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00739861EE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10906290BA6;
	Thu, 15 May 2025 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrCZjWDU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A10A286423
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280408; cv=none; b=Mwsf7mssgDkFxtxjsrMobisXUlcAN0vzV+5oit9BVTuA0zxo1JN/SNvs22WaQMqvZ7KVoipavQGFPELkeCBCN8uz0a3Z44nd2nJc3MT96AFI9Nzi5n7v7CWnaZmkW9/lGXnWBKzn0mKZ/r9W0gMSmv9yP1qZ8+MREeHnUGbNp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280408; c=relaxed/simple;
	bh=wm+P6eF/Tb2F6jKCjfMYwZ5NuAGurGxLdAK3FwkVMfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmPRlNRrb16dSvlkjSM3VzxELGTVPJEtvatLa/PcHpWRfJxN5EpUeoDiHe6D3l6+DhwUL34hoss/GNc/wyN39BUCfZKcljkW9cT97t3jRNE0iiJ1j2A90Gszahp24jN7VGgzQ2JAAoBebaoOfDLfxgLIOklRj4d1sgqcggZ9WYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrCZjWDU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747280405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=illy9a0IaRLRjpyollQHr/drUNF4chj8Y2TZlHp92rI=;
	b=PrCZjWDUuh9KkgNQK5XVQsX9DvoMecgL+lHOzEoxW7IOVdfxlWNeAJ1Qa/+fRiCa5RXHGO
	9kdQ0nR2KCfiuxOaWAR+ej6SOkaPU982u3MLb98/Rh6PyS1Enmi3Oh0p//W4LAZJMAjmcA
	XY6T7h6QLljarv+slMjvKqkE/gPesAs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-vUokHE6TMzmJBnlO53tfIg-1; Wed,
 14 May 2025 23:40:00 -0400
X-MC-Unique: vUokHE6TMzmJBnlO53tfIg-1
X-Mimecast-MFC-AGG-ID: vUokHE6TMzmJBnlO53tfIg_1747280396
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39AE21956095;
	Thu, 15 May 2025 03:39:55 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.116])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E95E1955F24;
	Thu, 15 May 2025 03:39:38 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com,
	hannes@cmpxchg.org,
	lorenzo.stoakes@oracle.com,
	rdunlap@infradead.org,
	mhocko@suse.com,
	Liam.Howlett@oracle.com,
	zokeefe@google.com,
	surenb@google.com,
	jglisse@google.com,
	cl@gentwo.org,
	jack@suse.cz,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	tiwai@suse.de,
	catalin.marinas@arm.com,
	anshuman.khandual@arm.com,
	dev.jain@arm.com,
	raquini@redhat.com,
	aarcange@redhat.com,
	kirill.shutemov@linux.intel.com,
	yang@os.amperecomputing.com,
	thomas.hellstrom@linux.intel.com,
	vishal.moola@gmail.com,
	sunnanyong@huawei.com,
	usamaarif642@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	shuah@kernel.org,
	peterx@redhat.com,
	willy@infradead.org,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	david@redhat.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	npache@redhat.com,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v6 2/4] mm: document (m)THP defer usage
Date: Wed, 14 May 2025 21:38:55 -0600
Message-ID: <20250515033857.132535-3-npache@redhat.com>
In-Reply-To: <20250515033857.132535-1-npache@redhat.com>
References: <20250515033857.132535-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The new defer option for (m)THPs allows for a more conservative
approach to (m)THPs. Document its usage in the transhuge admin-guide.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 31 ++++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 5c63fe51b3ad..7e87ef317add 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -88,8 +88,9 @@ In certain cases when hugepages are enabled system wide, application
 may end up allocating more memory resources. An application may mmap a
 large region but only touch 1 byte of it, in that case a 2M page might
 be allocated instead of a 4k page for no good. This is why it's
-possible to disable hugepages system-wide and to only have them inside
-MADV_HUGEPAGE madvise regions.
+possible to disable hugepages system-wide, only have them inside
+MADV_HUGEPAGE madvise regions, or defer them away from the page fault
+handler to khugepaged.
 
 Embedded systems should enable hugepages only inside madvise regions
 to eliminate any risk of wasting any precious byte of memory and to
@@ -99,6 +100,15 @@ Applications that gets a lot of benefit from hugepages and that don't
 risk to lose memory by using hugepages, should use
 madvise(MADV_HUGEPAGE) on their critical mmapped regions.
 
+Applications that would like to benefit from THPs but would still like a
+more memory conservative approach can choose 'defer'. This avoids
+inserting THPs at the page fault handler unless they are MADV_HUGEPAGE.
+Khugepaged will then scan all mappings, even those not explicitly marked
+with MADV_HUGEPAGE, for potential collapses into (m)THPs. Admins using
+this the 'defer' setting should consider tweaking max_ptes_none. The
+current default of 511 may aggressively collapse your PTEs into PMDs.
+Lower this value to conserve more memory (i.e., max_ptes_none=64).
+
 .. _thp_sysfs:
 
 sysfs
@@ -109,11 +119,14 @@ Global THP controls
 
 Transparent Hugepage Support for anonymous memory can be entirely disabled
 (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
-regions (to avoid the risk of consuming more memory resources) or enabled
-system wide. This can be achieved per-supported-THP-size with one of::
+regions (to avoid the risk of consuming more memory resources), deferred to
+khugepaged, or enabled system wide.
+
+This can be achieved per-supported-THP-size with one of::
 
 	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
 	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
+	echo defer >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
 	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
 
 where <size> is the hugepage size being addressed, the available sizes
@@ -136,6 +149,7 @@ The top-level setting (for use with "inherit") can be set by issuing
 one of the following commands::
 
 	echo always >/sys/kernel/mm/transparent_hugepage/enabled
+	echo defer >/sys/kernel/mm/transparent_hugepage/enabled
 	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
 	echo never >/sys/kernel/mm/transparent_hugepage/enabled
 
@@ -286,7 +300,8 @@ of small pages into one large page::
 A higher value leads to use additional memory for programs.
 A lower value leads to gain less thp performance. Value of
 max_ptes_none can waste cpu time very little, you can
-ignore it.
+ignore it. Consider lowering this value when using
+``transparent_hugepage=defer``
 
 ``max_ptes_swap`` specifies how many pages can be brought in from
 swap when collapsing a group of pages into a transparent huge page::
@@ -311,14 +326,14 @@ Boot parameters
 
 You can change the sysfs boot time default for the top-level "enabled"
 control by passing the parameter ``transparent_hugepage=always`` or
-``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
-kernel command line.
+``transparent_hugepage=madvise`` or ``transparent_hugepage=defer`` or
+``transparent_hugepage=never`` to the kernel command line.
 
 Alternatively, each supported anonymous THP size can be controlled by
 passing ``thp_anon=<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size>[KMG]:<state>``,
 where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
 supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvise``,
-``never`` or ``inherit``.
+``defer``, ``never`` or ``inherit``.
 
 For example, the following will set 16K, 32K, 64K THP to ``always``,
 set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
-- 
2.49.0


