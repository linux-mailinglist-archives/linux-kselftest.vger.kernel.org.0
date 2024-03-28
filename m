Return-Path: <linux-kselftest+bounces-6756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845D288FA9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 10:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2C1B276BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D955789B;
	Thu, 28 Mar 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b2FZwegd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225953FBB3;
	Thu, 28 Mar 2024 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616541; cv=none; b=WTsGgeeEcRNEe0vbzWDyP4Bp8XzRl7/y4+O9wstMRWCRFMka7cTn77UB3Jl8UrmdsGFEAYJfHunUQY7L1jbMO4nBGeOC+c5zce1FGV1DnEg3p4BfuWc56wfiYREhrFFFUCXeFWVfh8G8Je777resR9udUk0fnt9GSONvDgt60Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616541; c=relaxed/simple;
	bh=Ufh8ofbcGIpZqebBgeU63gQtywNxj6fTHPQwgJxbxWg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mFc2Uok5j88T/6LsXh53Ih5jqkpO9ejQf8l5/iRRuu207PufEHlRRoUqN86UqtPWujxeJVsvHw4fZYQdSHtoSfJIbzVktDaucrgXeoi8b7BQhyvPrONsSw6q8lTnwMxnKkPQg72dgUoiVUDEOjfxUxA48jMNYOoFCqlD0WfjLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b2FZwegd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711616533;
	bh=Ufh8ofbcGIpZqebBgeU63gQtywNxj6fTHPQwgJxbxWg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=b2FZwegdsqBcB5ZhCCFwc/bldEv6XVivywv06kdoiGWU0RcYjHt5zMCWulL3/NR1r
	 23xglYTKKi+7RS/HgMV4gOr2rj8wVGGG+UYU9fo9W+2F2WBT9t4AQbrRB1KzkiHTUK
	 F6KqIPM+KaKmq+vvh9Itvt7mlQz4i049g8DVeNZradHZ6S78T4o5/Ps+rokYDOsAP8
	 CWKuBOfTG6JfAAtFdigDMwPjBm7GVSeH5LWf+MSbxKDir8s1iEds7Ln0sAAvNLuQlG
	 qk/0S0dub42+CpvkX5ezpk4YMpKk8R+TEqF+YlyBbvl6ryPwMGUQn3ZOVkOm5pibg6
	 2HKQnaGsx/law==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6D43B3782115;
	Thu, 28 Mar 2024 09:02:09 +0000 (UTC)
Message-ID: <6d82298b-b17b-440a-beef-590177d0ff50@collabora.com>
Date: Thu, 28 Mar 2024 14:02:37 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Guillaume Tucker <gtucker@gtucker.io>
Subject: Re: [PATCH 0/2] Fix selftests/mm build without requiring "make
 headers"
Content-Language: en-US
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240328033418.203790-1-jhubbard@nvidia.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240328033418.203790-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 8:34 AM, John Hubbard wrote:
> Hi,
> 
> As mentioned in each patch, this implements the solution that we discussed in
> December 2023, in [1]. This turned out to be very clean and easy. It should also
> be quite easy to maintain.
There is another way. The headers should be built automatically by make
dependency. The topmost make file always builds headers before building
kselftest i.e., make kselftest

The tools/testing/selftests/Makefile and others Makefiles in test suites
should be updated to build the headers as well. This used to be the
behavior until there were un-resolvable bugs in the Makefiles and it was
reverted:
https://lore.kernel.org/all/cover.1657614127.git.guillaume.tucker@collabora.com/

We should come up with the revert of this series such that all the
different scenarios are covered instead of yet again a new solution;
resorting to the duplication of header files or any sort of duplication.

> 
> This should also make Peter Zijlstra happy, because it directly addresses the
> root cause of his "NAK NAK NAK" reply [2]. :)
> 
> I haven't done much build testing, because selftests are not so easy to build
> with a cross-compiler. So it's just tested on x86 64-bit so far.
> 
> [1] https://lore.kernel.org/all/783a4178-1dec-4e30-989a-5174b8176b09@redhat.com/
> [2] https://lore.kernel.org/lkml/20231103121652.GA6217@noisy.programming.kicks-ass.net/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> John Hubbard (2):
>   selftests: break the dependency upon local header files
>   selftests/mm: fix additional build errors for selftests
> 
>  tools/include/uapi/linux/memfd.h       |  39 +++
>  tools/include/uapi/linux/userfaultfd.h | 386 +++++++++++++++++++++++++
>  tools/testing/selftests/lib.mk         |   9 +
>  tools/testing/selftests/mm/Makefile    |   2 +-
>  4 files changed, 435 insertions(+), 1 deletion(-)
>  create mode 100644 tools/include/uapi/linux/memfd.h
>  create mode 100644 tools/include/uapi/linux/userfaultfd.h
> 
> 
> base-commit: 98560e9019851bf55b8a4073978a623a3bcf98c0

-- 
BR,
Muhammad Usama Anjum

