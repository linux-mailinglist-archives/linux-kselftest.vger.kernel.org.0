Return-Path: <linux-kselftest+bounces-15064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E7894CEAE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 12:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C14283004
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19D1922DF;
	Fri,  9 Aug 2024 10:32:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AA0166F14;
	Fri,  9 Aug 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199543; cv=none; b=G4eQXgj6UEjHOr+Uon71tjyYu044e64t/eHswaudIbNazYgEajotrH5DRU9pfIx7QSQx/+s7lZEP+kNUIysfLGynCzWb8L6CqXiNm2OViws+j5Y8qCJMLqJIbtBNo/HAM5rFtbA9fGw5y4QezTaVs/Pzw4cGRpXoMTSW3XGwCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199543; c=relaxed/simple;
	bh=ev/EK1AR6F6ZUr2IjZuvFJmQ7zyf0HVKj/yvMRngDaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7sKu8k2RMJvFduqnUJggBPtkFW8BFEkIkNuKhtocVV9yOTutOLvXsmdZyo9qu875OreJH95dglRRNmvBWtsMiq9Xogk03UrODh8WSU13wajK8Q8lRzgDzM9DfAi4fRyRKVESo0pasXdnMS42H80fBxwFHudE8XUqacy9eoYxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D281E13D5;
	Fri,  9 Aug 2024 03:32:46 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2551F3F766;
	Fri,  9 Aug 2024 03:31:58 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	david@redhat.com,
	willy@infradead.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	osalvador@suse.de,
	baolin.wang@linux.alibaba.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	ioworker0@gmail.com,
	gshan@redhat.com,
	mark.rutland@arm.com,
	kirill.shutemov@linux.intel.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	broonie@kernel.org,
	mgorman@techsingularity.net,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
Date: Fri,  9 Aug 2024 16:01:28 +0530
Message-Id: <20240809103129.365029-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809103129.365029-1-dev.jain@arm.com>
References: <20240809103129.365029-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As already being done in __migrate_folio(), wherein we backoff if the
folio refcount is wrong, make this check during the unmapping phase, upon
the failure of which, the original state of the PTEs will be restored and
the folio lock will be dropped via migrate_folio_undo_src(), any racing
thread will make progress and migration will be retried.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/migrate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index e7296c0fb5d5..477acf996951 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	}
 
 	if (!folio_mapped(src)) {
+		/*
+		 * Someone may have changed the refcount and maybe sleeping
+		 * on the folio lock. In case of refcount mismatch, bail out,
+		 * let the system make progress and retry.
+		 */
+		struct address_space *mapping = folio_mapping(src);
+
+		if (folio_ref_count(src) != folio_expected_refs(mapping, src))
+			goto out;
 		__migrate_folio_record(dst, old_page_state, anon_vma);
 		return MIGRATEPAGE_UNMAP;
 	}
-- 
2.30.2


