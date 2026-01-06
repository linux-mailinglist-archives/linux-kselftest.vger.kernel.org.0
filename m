Return-Path: <linux-kselftest+bounces-48333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC33CFA0D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 19:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81D1D31126DA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A953559CB;
	Tue,  6 Jan 2026 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qZhADq5g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF73559C5;
	Tue,  6 Jan 2026 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720517; cv=none; b=ibhclwthhnP9uehDmQC9uiUBv+oRUTYdjpwcO/OLBD4LQPcOwY3BO+phiJu16DkIQ66bpL3ZQ1E/wqAPUMnvtbgP8CerM4xsY9amjQ6kLC/qSWDyGwj257EzZT1u8Dg4K/631bqWeDMFbzbUkSELtkISYS9RU/NMmliqOZna7t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720517; c=relaxed/simple;
	bh=n2QELpvuHwzO67j1Aajbgcgc9n/M3r4muFo8o4BFDio=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IEpyXGbcJiirW2QKpdcJxiHzd+enAZ6tvAzBY4EPeLlaAITbokX9RNKfRJef8VI6VPu39qjwYLNJp8SsMhE/wV6xkga1Oq0aOsiXOSsVBe82QL+ukkpDoW8VlEb1fUnbTopLb3J8HKwK+u1TLiS2K//igoP0vT2qvB4NbDigzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qZhADq5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32526C116C6;
	Tue,  6 Jan 2026 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767720517;
	bh=n2QELpvuHwzO67j1Aajbgcgc9n/M3r4muFo8o4BFDio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qZhADq5gT8e6zKneBRvzHQo40ypuUgdr8IIXQ365O3bGWudmTF4Hafn99ma9XthAq
	 lxndbsRwhP3IwjLimOsvCl5aH5GIdsrXCKm7PGQeGVmkm/BMCxxbaJvOnS8twNnuCu
	 PwrIHjVu6jvJQbLzVqhf7anB8Vfu/Sx2u3r0TEfU=
Date: Tue, 6 Jan 2026 09:28:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mark Brown <broonie@kernel.org>, David Hildenbrand <david@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter
 Xu <peterx@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/testing/selftests: fix gup_longterm for unknown
 fs
Message-Id: <20260106092836.d6a4fa77b755bd989d1521b9@linux-foundation.org>
In-Reply-To: <20260106154547.214907-1-lorenzo.stoakes@oracle.com>
References: <20260106154547.214907-1-lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 15:45:47 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Commit 66bce7afbaca ("selftests/mm: fix test result reporting in
> gup_longterm") introduced a small bug causing unknown filesystems to always
> result in a test failure.
> 
> This is because do_test() was updated to use a common reporting path, but
> this case appears to have been missed.
> 
> This is problematic for e.g. virtme-ng which uses an overlayfs file system,
> causing gup_longterm to appear to fail each time due to a test count
> mismatch:
> 
> 	# Planned tests != run tests (50 != 46)
> 	# Totals: pass:24 fail:0 xfail:0 xpass:0 skip:22 error:0
> 
> The fix is to simply change the return into a break.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Fixes: 66bce7afbaca ("selftests/mm: fix test result reporting in gup_longterm")

-stable users might want this?

