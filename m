Return-Path: <linux-kselftest+bounces-15139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8878C94E632
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 07:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EF31F21FE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 05:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B2214D28E;
	Mon, 12 Aug 2024 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7v9bl/W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6843C0B;
	Mon, 12 Aug 2024 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441086; cv=none; b=nVT8uvuMUfF0dRUZhodpPOOAkDNuA1T9ymIw9p5ABqHemQI+wQT6rAZoyLwdIBh2U+fqkOFrE/exyJ92Ne86vYD4ITzMx4/9179VzHwy0uHaHx1tlLcRMXB0EexaPwWs34Vaann9Jfty9oudW3PVhnTPUKIWceht86HFHD/d3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441086; c=relaxed/simple;
	bh=OtNOl0fu+2Jf+rCsZgmd6Tb1x6JBNKxJW+QUDFkv8XQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HsOp+w2M25H31+49kKceyhDb4hiWfv9nVbGM6SMSGF0WezqO61OqxPN1CtbLIbhfGy90oWnp9MaK6yqRviZIgB6bzOQaPuS29ET0MuMhuUcKdv3ZWbsDpnJYNu9xhvOAN8LCk6sOsUI7ZBrpSsjuvJAqfNf/fNyTzYlILiUZGwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7v9bl/W; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723441085; x=1754977085;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OtNOl0fu+2Jf+rCsZgmd6Tb1x6JBNKxJW+QUDFkv8XQ=;
  b=C7v9bl/WlHl1M8dF6727IV2M0DbwvslawsZWC4JteM60MiSyJXUE7hln
   lxawqIFBndTJSXvmn5lek62Cn3edUUbumDNn8CcxCtKcJrzPVnoegz71c
   LQd87Bj0SdkmU1cd9mDnIIg2pneimHkdOR/dImsZJZVHlEIQHtpfj3jfs
   hdaxcOJcZqbjBvX/O3pA1/qZVUcPJIZWaE7UCMm7oZwpGjuAMUluFPZe8
   W9jXfTUkO70ZJvKHBUL5hHNlD3SBiFJdeU7U2U3Lh0os2kCSEANabVLIV
   P6HIbt3YPezjl00sUFO5a9mynraNu/ngGoOfVXwXbNwmu8ifQNDliZcNK
   A==;
X-CSE-ConnectionGUID: Zgq18pUrRuulQSz6dV0Scw==
X-CSE-MsgGUID: bB+Ujh2oRwyaWI+qzie3Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21411205"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21411205"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:38:04 -0700
X-CSE-ConnectionGUID: wV2CeHnBRbqr8vl/NfZdUg==
X-CSE-MsgGUID: 3VG6m94dT5CYRhcl1sAzZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58710648"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:37:58 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org,  shuah@kernel.org,  david@redhat.com,
  willy@infradead.org,  ryan.roberts@arm.com,  anshuman.khandual@arm.com,
  catalin.marinas@arm.com,  cl@gentwo.org,  vbabka@suse.cz,
  mhocko@suse.com,  apopple@nvidia.com,  osalvador@suse.de,
  baolin.wang@linux.alibaba.com,  dave.hansen@linux.intel.com,
  will@kernel.org,  baohua@kernel.org,  ioworker0@gmail.com,
  gshan@redhat.com,  mark.rutland@arm.com,
  kirill.shutemov@linux.intel.com,  hughd@google.com,
  aneesh.kumar@kernel.org,  yang@os.amperecomputing.com,
  peterx@redhat.com,  broonie@kernel.org,  mgorman@techsingularity.net,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
In-Reply-To: <20240809103129.365029-2-dev.jain@arm.com> (Dev Jain's message of
	"Fri, 9 Aug 2024 16:01:28 +0530")
References: <20240809103129.365029-1-dev.jain@arm.com>
	<20240809103129.365029-2-dev.jain@arm.com>
Date: Mon, 12 Aug 2024 13:34:24 +0800
Message-ID: <87frrauwwv.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Dev,

Dev Jain <dev.jain@arm.com> writes:

> As already being done in __migrate_folio(), wherein we backoff if the
> folio refcount is wrong, make this check during the unmapping phase, upon
> the failure of which, the original state of the PTEs will be restored and
> the folio lock will be dropped via migrate_folio_undo_src(), any racing
> thread will make progress and migration will be retried.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/migrate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e7296c0fb5d5..477acf996951 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>  	}
>  
>  	if (!folio_mapped(src)) {
> +		/*
> +		 * Someone may have changed the refcount and maybe sleeping
> +		 * on the folio lock. In case of refcount mismatch, bail out,
> +		 * let the system make progress and retry.
> +		 */
> +		struct address_space *mapping = folio_mapping(src);
> +
> +		if (folio_ref_count(src) != folio_expected_refs(mapping, src))
> +			goto out;
>  		__migrate_folio_record(dst, old_page_state, anon_vma);
>  		return MIGRATEPAGE_UNMAP;
>  	}

Do you have some test results for this?  For example, after applying the
patch, the migration success rate increased XX%, etc.

My understanding for this issue is that the migration success rate can
increase if we undo all changes before retrying.  This is the current
behavior for sync migration, but not for async migration.  If so, we can
use migrate_pages_sync() for async migration too to increase success
rate?  Of course, we need to change the function name and comments.

--
Best Regards,
Huang, Ying

