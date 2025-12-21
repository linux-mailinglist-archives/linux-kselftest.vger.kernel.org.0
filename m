Return-Path: <linux-kselftest+bounces-47795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7297CD3E19
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 10:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A38653004C88
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59427257459;
	Sun, 21 Dec 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V04umGEW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31079231830;
	Sun, 21 Dec 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766310563; cv=none; b=r9d4Dess6nS5vXXWNAzd+sidVDSFuFF+lsOyRQORKnrWTzkF9sAtEUcMfn0UgneCekvS1dUNHtsn+D6WS/Ni7h1wtUKb5QCh03R03YowzAvPNZGqY2niGnCN7b1wDYB4dCdB34RBvXW47w5RZ5BgRB3zb18KWljaKHVAE52eT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766310563; c=relaxed/simple;
	bh=tsj0Y9TsuBsyw04bXuGsZP/6xPjK8Tcxqhyw9abf304=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8RPn9+ASX0TXCnlOOLG/i0bHLt8WAXVYUlFNoA0caFOpbqTG+t8aPRrK82vyDWbkQmo+Yej5qbzndgSY5jQaP1JwjrkPrLG2nL/72dhlDthePOissBvFqzB9D6ODnFZRDu6QCXnD/LnhneMGcVlgoWYjKU36smtqQSlx3dW9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V04umGEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AFDC4CEFB;
	Sun, 21 Dec 2025 09:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766310562;
	bh=tsj0Y9TsuBsyw04bXuGsZP/6xPjK8Tcxqhyw9abf304=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V04umGEWs1079s0RySfXElGgYq7u0L01Piv/Ll9FUuBkNTe7ru14oQDeU5DCCIUPo
	 f+x4HOb2YQMqzKHd8oFMA/sW/C88DbVa50alSOhF7TvRWcHFG7k5TGGhHfGe2uRe2p
	 R1ifo+skhV+wl3EMmFfKkp1i01b+NQM0gxZxHdUYIlfEUTZhUuqzLi+rcnjt+IIIwl
	 2/Ka5ruUdGsy/oiCbSQsTnMA8Pryp1Ek6Qi/WtzXg4ZqK8tt5uDemihfKlccNt4Vmy
	 HNj+Jy1tF1VQFWxd5H9bxyrLfrkUGgJQh3edbHXAUe38uJ4A91K4V4ekbcHSofJGms
	 5EggwqIO6gS7w==
Message-ID: <30a75bb5-7edd-42b1-9a94-8ffe017bdb0b@kernel.org>
Date: Sun, 21 Dec 2025 10:49:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/mm/charge_reserved_hugetlb: fix
 hugetlbfs mount size for large hugepages
To: Li Wang <liwang@redhat.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Waiman Long <longman@redhat.com>
References: <20251221085810.3163919-1-liwang@redhat.com>
 <20251221085810.3163919-4-liwang@redhat.com>
 <970fa015-9ec8-4903-8e2f-f3e847d550d1@kernel.org>
 <CAEemH2f67p=wqGrwYnoVCP1fR82xxwJv1xfbMmFrvNaP7LZJog@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <CAEemH2f67p=wqGrwYnoVCP1fR82xxwJv1xfbMmFrvNaP7LZJog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 10:44, Li Wang wrote:
> David Hildenbrand (Red Hat) <david@kernel.org> wrote:
>> On 12/21/25 09:58, Li Wang wrote:
>>> charge_reserved_hugetlb.sh mounts a hugetlbfs instance at /mnt/huge with
>>> a fixed size of 256M. On systems with large base hugepages (e.g. 512MB),
>>> this is smaller than a single hugepage, so the hugetlbfs mount ends up
>>> with effectively zero capacity (often visible as size=0 in mount output).
>>>
>>> As a result, write_to_hugetlbfs fails with ENOMEM and the test can hang
>>> waiting for progress.
>>
>> I'm curious, what's the history of using "256MB" in the first place (or
>> specifying any size?).
> 
> Seems the script initializes it with "256MB" from:
> 
> commit 29750f71a9b4cfae57cdddfbd8ca287eddca5503
> Author: Mina Almasry <almasrymina@google.com>
> Date:   Wed Apr 1 21:11:38 2020 -0700
> 
>      hugetlb_cgroup: add hugetlb_cgroup reservation tests

What would happen if we don't specify a size at all?

-- 
Cheers

David

