Return-Path: <linux-kselftest+bounces-15105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6074094D9BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 03:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184FC282569
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541EF3BBE5;
	Sat, 10 Aug 2024 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="dDY7XknW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1A3A8F7;
	Sat, 10 Aug 2024 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723253028; cv=none; b=WJCRJ9TTpPtW3oJ4CRpxE6BzjvwZqUZbAyCDSQjlrznAR1bOxPz0Ul7YfXKC0Azsi22y/StT8rVqmLn1S1pp2FGMpRjv2kUE7L+vmBP/H7bD3x1KAFlJe5WpIZ/i8oy7KfZmGq1vCgEIJuSZPRua9REm3YyFSUTuXna0nqzlsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723253028; c=relaxed/simple;
	bh=vQg2bI0BX9ECTdn28x4JH7g4kcPq0cvqSpJS1FF2MJo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pc0Yid0rzka3cLsAIjAcpymi6yuvkr86I/srd7Fde8igRUooOFLqmU1Uw7+935fgD+r84KXQ+rb/8huWAI1yAs8B4tV4RDUkjs7vJ5d9CEtxDhYK5VMPq8xK4zMagOwYcmsaHQGF561h3L3Bh5y4o34gDW0oshb4043iLYcOXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=dDY7XknW; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1723237750;
	bh=vQg2bI0BX9ECTdn28x4JH7g4kcPq0cvqSpJS1FF2MJo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dDY7XknWmpb3ufXCetghO7ZOm6G+oR2qD+NtSovvK7OAlUJwHXZ+GiCKcR5vKYHuy
	 7cBkVljXXd+zf5DS+LsQBBZ9gPx+EwKwR3MuMcBQmqHzgaMoGgWhCVZd39/eqgIUJz
	 4MI5erDvu77ja20k9BLVR5ZF4p5krRYrpJUUvFAs=
Received: by gentwo.org (Postfix, from userid 1003)
	id 257154040D; Fri,  9 Aug 2024 14:09:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 236B04035C;
	Fri,  9 Aug 2024 14:09:10 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:09:10 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: David Hildenbrand <david@redhat.com>
cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org, 
    willy@infradead.org, ryan.roberts@arm.com, anshuman.khandual@arm.com, 
    catalin.marinas@arm.com, vbabka@suse.cz, mhocko@suse.com, 
    apopple@nvidia.com, osalvador@suse.de, baolin.wang@linux.alibaba.com, 
    dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, 
    ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com, 
    kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org, 
    yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org, 
    mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
In-Reply-To: <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
Message-ID: <43db36cb-339c-4aa8-8940-1a197bd1001d@gentwo.org>
References: <20240809103129.365029-1-dev.jain@arm.com> <20240809103129.365029-2-dev.jain@arm.com> <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 9 Aug 2024, David Hildenbrand wrote:

>
> This really seems to be the latest point where we can "easily" back off and 
> unlock the source folio -- in this function :)
>
> I wonder if we should be smarter in the migrate_pages_batch() loop when we 
> start the actual migrations via migrate_folio_move(): if we detect that a 
> folio has unexpected references *and* it has waiters (PG_waiters), back off 
> then and retry the folio later. If it only has unexpected references, just 
> keep retrying: no waiters -> nobody is waiting for the lock to make progress.

Well just backoff ASAP if there are waiters detected anytime. A waiter 
would have increased the refcount. And a waiter will likely modify the page status soon. So 
push it to the end of the pages to be migrated to give it as much time 
as we can and check again later.

