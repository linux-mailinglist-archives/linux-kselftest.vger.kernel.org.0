Return-Path: <linux-kselftest+bounces-11465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D109900F8A
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 06:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5D21F22196
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 04:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF0FC19;
	Sat,  8 Jun 2024 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nWCE2ohU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0A3D68;
	Sat,  8 Jun 2024 04:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717821578; cv=none; b=YgsnoPdDkGrp3OXyHPn3A512PuLHnVv6HTazvuicOUthJoW4B7rPhC5+VSnH3nfe/eYwvY2tXq3TSjkqPuYRO1+3/jZ8NZ3PV0UBWrMg+vMwNkYKKQS3DTi4rmNmFiTJP/to2ykXj331kWUODv0NqoxlK6z/16Z5mvyas1eljY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717821578; c=relaxed/simple;
	bh=0SEMGfwmVBBa9SW6qjrXV4oYQIyBf9H49FvAj7GthAY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eWn4mJ0HZgeLV5STti2Ao+IstFCZv8EncUkd9i0mCYWlan45i5x2+qbxGnpLdVpaG8/3PsOvJnbSMXO4bfQf8XnrOsU0skfHX1q7RzRpbIRe/M4RuMM/85/Uw163Mu4QzHXZPuIMC2HGBg8MjrzJR9Bn+vPg4gMynJqIUyzxweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nWCE2ohU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6873DC2BD11;
	Sat,  8 Jun 2024 04:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717821577;
	bh=0SEMGfwmVBBa9SW6qjrXV4oYQIyBf9H49FvAj7GthAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nWCE2ohU0p5JfW06/Z6E8d6Ezt4RMf1Y7XdlACppk1QWxGvyts1ndltbyeYQu8gJo
	 hIL/OPYc3jTeB5LDlYc5NShzW29jHIQ2ZI2wHYwHsFDfyzOVpIfaexxO65T2w7JYXv
	 Hx5bKG6I5WZk4V1iij+5PkKR9q2ey9K89F6U13B4=
Date: Fri, 7 Jun 2024 21:39:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, gost.dev@samsung.com,
 David Hildenbrand <david@redhat.com>, willy@infradead.org,
 mcgrof@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zi Yan <zi.yan@sent.com>, Pankaj Raghav
 <p.raghav@samsung.com>
Subject: Re: [PATCH v3] selftests/mm: use asm volatile to not optimize mmap
 read variable
Message-Id: <20240607213936.a58028617aacdbf6913d3735@linux-foundation.org>
In-Reply-To: <20240606203619.677276-1-kernel@pankajraghav.com>
References: <20240606203619.677276-1-kernel@pankajraghav.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 20:36:19 +0000 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> create_pagecache_thp_and_fd() in split_huge_page_test.c used the
> variable dummy to perform mmap read.
> 
> However, this test was skipped even on XFS which has large folio
> support. The issue was compiler (gcc 13.2.0) was optimizing out the
> dummy variable, therefore, not creating huge page in the page cache.
> 
> Use asm volatile() trick to force the compiler not to optimize out
> the loop where we read from the mmaped addr. This is similar to what is
> being done in other tests (cow.c, etc)
> 
> As the variable is now used in the asm statement, remove the unused
> attribute.
> 

What are the runtime effects of this change?  An inappropriate test
failure?  If so, shouldn't we fix 6.9.x kernels also?  And is
fc4d182316bd ("mm: huge_memory: enable debugfs to split huge pages to
any order") an appropriate Fixes: target?


