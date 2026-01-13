Return-Path: <linux-kselftest+bounces-48819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCDBD1617C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B4C301D0EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C3823314B;
	Tue, 13 Jan 2026 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCMcADjS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D4163;
	Tue, 13 Jan 2026 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265738; cv=none; b=UuBXgF4MMlOiPLFy9wkZYjLhXuARcF6jMcPrRsw8TasJhCM24yrLbK68ANkOzkjVLOvvbfLdYfP8UhFrOq0rgRtMZ6PuUe4Of2KIDIrdMZPJZIUN+fAiFdYfT6+CVeP1Aijz/XrZVIBCtk9kwtFZHcf8x3m4jbENk22D9wX+fzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265738; c=relaxed/simple;
	bh=3LvNuOICCCHw8CTVsMV6TZmC/0QdeBlW1az1MITCPZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wcjn/p+MMDg8snUw9NFDTBquA643YlNzpLGTS1kd1wC3m8VgFcZB2tJXrMCcDInrEM7dHyz3LfuPgZ7lr56TvWesKx31oh6Mpf4rqMH4AyBFux6RVzhSzZ8ABH7lrVy5QzdWuI7nmfTOCYJ53iCedWelSn1OgEF0yIDPMukU1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCMcADjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B84C116D0;
	Tue, 13 Jan 2026 00:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768265737;
	bh=3LvNuOICCCHw8CTVsMV6TZmC/0QdeBlW1az1MITCPZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCMcADjSLPpfUz0wKUSqyDnBWj7xSrzlcrrAbUqCguD/fDiPKTzQMbPKQvj32P6S1
	 pTg36BIEIm6C0U3/yY23Wp/BOmg9xuW8KMPYsMJjJLdnWx3I3fNBN8VwznKIESGSTF
	 Z7NJ3lzCIJfv/6BojwpA3WafvpcyfuDT4IE/d+AHNEDPRlkA1ix/prtRo91R+fMKE+
	 5+UJ95BkWxMv/5onpZL6VlbVsJBNL9GDG+YDGoCBM8jF6Q70OEDug/pmokhnGnGpsE
	 6r26Au+MjkWOLokrbbnX7AyGhW2XHCtBtdCb+F7CVCdlOvFNjRHCJBPOONysdBWMQK
	 7FsfC1q7XgzLQ==
From: SeongJae Park <sj@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 5/8] selftests/mm: introduce helper to read every page in range
Date: Mon, 12 Jan 2026 16:55:29 -0800
Message-ID: <20260113005530.101000-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b785754d-ba6f-42db-9e44-66fd377aad03@arm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 Jan 2026 10:37:26 +0100 Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> On 09/01/2026 02:30, SeongJae Park wrote:
> > On Wed,  7 Jan 2026 16:48:39 +0000 Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> >
> >> FORCE_READ(*addr) ensures that the compiler will emit a load from
> >> addr. Several tests need to trigger such a load for every page in
> >> the range [addr, addr + len), ensuring that every page is faulted
> >> in, if it wasn't already.
> >>
> >> Introduce a new helper force_read_pages_in_range() that does exactly
> >> that and replace existing loops with a call to it.
> > Seems like a good cleanup to me.
> 
> Thanks for having a look at this series!

My pleasure!

> 
> >> Some of those
> >> loops have a different step size, but reading from every page is
> >> appropriate in all cases.
> > So the test program's behavior is slightly be changed.  I believe that
> > shouldn't be problem, but I'm not that familiar with the test code, so not very
> > sure.  I'd like to listen voices from people more familiar with those.
> >
> > Meanwhile, I'm curious what do you think about making the helper function
> > receives the step size together, and let the callers just pass their current
> > step size.
> 
> That's what I initially considered, but considering this discussion on
> v1 [1] this doesn't seem to be justified. In hugetlb-madvise, reading
> every page instead of every hugepage is unnecessary but still correct
> and the overhead should be negligible. In split_huge_page_test, I don't
> think there's any justification for reading every byte - the intention
> is to fault in pages, like all the other cases this patch touches.
> 
> - Kevin
> 
> [1]
> https://lore.kernel.org/all/a3ca6293-8f85-4489-a48e-eb8d0d3792c5@kernel.org/

Makes sense, thank you for the link!

Please feel free to add

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

