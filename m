Return-Path: <linux-kselftest+bounces-34403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D91ACF8D0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 22:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACA1189B154
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C127C854;
	Thu,  5 Jun 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="usHxWW55"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AD27A127;
	Thu,  5 Jun 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155545; cv=none; b=RVh2wKmI7fGAAmYj8lrHYAIAbpHj30eh1VSQ2gjBv/8jn005gQKSQtmctciQ5VVwNSvjQszx7tL9a+Eb+4e2e5QQG1byzYRLLAqP1jAn3WTa9+anIv4+BtlSz9ncfmHq6JHy0tBadltkY3iBMV/br7HoFXwHG/NpG6kRT4HZKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155545; c=relaxed/simple;
	bh=wP6XVkaHObG7XcxFBVXGDerkmspfQUb/leD1YX3jPWg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OTraPF6qIbOyS0gCIrFFkYi6cBoQOZS5F+q3cpw1dGumdDfCLnQDvYN5ZfdoBccCQG4Y3hxWnmjmN7J1JxZA2pRnCNF8vLAu/7FQ5Mx5/Md/+RyAA0LOd2UcFsdQrIlJaslU86Wpn0iuhF4U9TnR9B8boJmX+64jw/SqAQJWm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=usHxWW55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EC3C4CEE7;
	Thu,  5 Jun 2025 20:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749155545;
	bh=wP6XVkaHObG7XcxFBVXGDerkmspfQUb/leD1YX3jPWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=usHxWW557DGED5/uOM0nk0pWI+9x37l1D9bV8g9oHXEDSYfeXAl6SghVYVJfbnN2C
	 LxRKlquIGFUCu84LjBhB07hHkpFx1IToM1/PGDjSKe9ivK+yg5g12GOAfr88oLwk67
	 QrqUecrHmW/tggK5Wu9b0yqoYssf6pMhoGOq8dkw=
Date: Thu, 5 Jun 2025 13:32:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-Id: <20250605133224.0462266f98407513b4ba93d1@linux-foundation.org>
In-Reply-To: <65862fd7-16ca-4d3b-a589-4389d8df324e@redhat.com>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
	<20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
	<a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
	<722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
	<65862fd7-16ca-4d3b-a589-4389d8df324e@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 18:48:49 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 05.06.25 18:15, Mark Brown wrote:
> > On Thu, Jun 05, 2025 at 05:00:49PM +0100, Lorenzo Stoakes wrote:
> > 
> >> This seems to be causing tests to fail rather than be skipped if hugetlb
> >> isn't configured. I bisected the problem to this patch so it's definitely
> >> changed how things are handled (though of course it might just be
> >> _revealing_ some previously existing bug in this test...).
> > 
> >> Using a couple of tests as an example:
> > 
> >> Before this patch:
> > 
> >> # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
> >> # memfd_create() failed (Cannot allocate memory)
> >> not ok 39 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
> >> # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
> >> # memfd_create() failed (Cannot allocate memory)
> >> not ok 40 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
> > 
> > That's the thing with memfd being special and skipping on setup failure
> > that David mentioned, I've got a patch as part of the formatting series
> > I was going to send after the merge window.
> 
> @Andew, why did this series get merged already?

Late merge window hastiness :(  And I saw nothing worrisome in the review.

