Return-Path: <linux-kselftest+bounces-30993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA97A9101D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C304C7AEC89
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175AA78F5B;
	Thu, 17 Apr 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCJcIVro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624CA23AD
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849208; cv=none; b=VE2QW6EgOAEUIcgQ/rTLDOnjajXGrKgvxT6jTGAHbJ2MMFrNPTvXrK6VaqqA+4QqCPb+dmAg0mMxb3JKZdLBGZIMN1QPsiMgmNzvfBkuzc3LFbi9VgD+1a1ghc1oqja92stSGsg8s4/4VF/LmIaQPm5EuAqFycEcOlGdtirfUK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849208; c=relaxed/simple;
	bh=cofQXT3z3Mwr5nPA9bW8cMfDUEu36bkQcINug2a+CJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpMajqELanv7WkY1x9AQ9ygqoK5nSn0zakJEKPPtWz9ynFqpblwq7ahUhnn4svapgTcP3bwrtpcIaYA7k9Ny1EIGFgUsFwl/m9MvANNiHt9gQPkD6LjExL+njETLOnU3CyUSmY6qaGDHSeqnX5vDAZUPvqq9CKsUB7sPBFZmt6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCJcIVro; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744849205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T90LCrJZAPUEyLfMWog/+6biSrJXKfE1zcoM8kFo7hQ=;
	b=HCJcIVrob9tBZsJpTcocTKw/6SpSTkheZzDH7jnvn3QQPQ8S7pRI6y/fXhWylvMkoIm9cD
	4sq3b5bFdCCQLcqafYRT5UqEyFu67tXXC6Y2bktN6zercjTuJgY4llhwZfDcFuwnUWpIg/
	qxVwU/vU9+3fzyYmZfE+vTY2nrnWYZI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-wmrC2r89NbChm7BLbFOqFA-1; Wed,
 16 Apr 2025 20:20:01 -0400
X-MC-Unique: wmrC2r89NbChm7BLbFOqFA-1
X-Mimecast-MFC-AGG-ID: wmrC2r89NbChm7BLbFOqFA_1744849198
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B223195609F;
	Thu, 17 Apr 2025 00:19:57 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.34])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06E0C19560A3;
	Thu, 17 Apr 2025 00:19:47 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@redhat.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	willy@infradead.org,
	peterx@redhat.com,
	shuah@kernel.org,
	ziy@nvidia.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org
Subject: [PATCH v4 2/4] mm: document (m)THP defer usage
Date: Wed, 16 Apr 2025 18:18:44 -0600
Message-ID: <20250417001846.81480-3-npache@redhat.com>
In-Reply-To: <20250417001846.81480-1-npache@redhat.com>
References: <20250417001846.81480-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The new defer option for (m)THPs allows for a more conservative
approach to (m)THPs. Document its usage in the transhuge admin-guide.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 31 ++++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 06814e05e1d5..38e1778d9eaa 100644
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
+Khugepaged will then scan the mappings for potential collapses into (m)THP
+pages. Admins using this the 'defer' setting should consider
+tweaking khugepaged/max_ptes_none. The current default of 511 may
+aggressively collapse your PTEs into PMDs. Lower this value to conserve
+more memory (i.e., max_ptes_none=64).
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
 
@@ -282,7 +296,8 @@ of small pages into one large page::
 A higher value leads to use additional memory for programs.
 A lower value leads to gain less thp performance. Value of
 max_ptes_none can waste cpu time very little, you can
-ignore it.
+ignore it. Consider lowering this value when using
+``transparent_hugepage=defer``
 
 ``max_ptes_swap`` specifies how many pages can be brought in from
 swap when collapsing a group of pages into a transparent huge page::
@@ -307,14 +322,14 @@ Boot parameters
 
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
2.48.1


