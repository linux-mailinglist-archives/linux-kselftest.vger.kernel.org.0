Return-Path: <linux-kselftest+bounces-47790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C5CD3D50
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 10:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C66E300B9A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06763219E8C;
	Sun, 21 Dec 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPUnUVwX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34561487E9;
	Sun, 21 Dec 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766307668; cv=none; b=gQqnbyN8GTI1rO7C3K0bxHRiYw1c1QxtKJX9jWO/atuThBCR1QWkURhlOr+O62hvtHJsSxLPIK4fmoUwwATTVQp6zWHtWd+25h47acZLhMtTNMHgP9BcaqxiVhUETf1IMSUL5R+Okzjhyh4rYaLqrJTf+7ZKb/oUKaEaGyQMge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766307668; c=relaxed/simple;
	bh=H4zT5BMxyg2XWDEXjZIIYKZGybtJExTbNVzBDE+GsgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o44IAj9yWSuPAGJBJFhnpRhXGzbGio6V5ATE4FOUh0XJ/nOXISAVRUKd82+5ruS9l0IHppSfiz9UMbVVWuj7IR0AG5wNmh1qoMxEdfww7WWyqcle8OcAAryelLAcmfoE9nW7d2nCjoBRtbml+9XL45TN/I2CFn8s2/wGFCdlXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPUnUVwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B278C4CEFB;
	Sun, 21 Dec 2025 09:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766307668;
	bh=H4zT5BMxyg2XWDEXjZIIYKZGybtJExTbNVzBDE+GsgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SPUnUVwXeTyFjPn/Zt7TBk1aIPrsWIGwZafaKseveX/KK7wwBjHeJFEslqlIFVcez
	 K8z3vouojilitnf1ShJsmfRewFa4H9dK+tcyDfb7j3gCv40SgOXkZD2z6/gDBQ6zDo
	 1LDgnhaj1F+XR8yTjWPSiNkpR9Rd1j46lD33+J+gDSqNpsLmxbVNs26U30WGTVtK53
	 OYeNRP5VX+RF+ILOqBAbhBaKiZxyOKiHlBeBqMBUdNSYS22YeTj0AKeddbvccafVCj
	 EN3M6ELK1do2+Hyw60vOixi5yKeWBhboqM/P4mptGT5Lud20vQtkcRsNXXFN2xu0+n
	 fnIbNR8QqxDwQ==
Message-ID: <60b8a0da-7f82-41dc-9746-657d89e88b69@kernel.org>
Date: Sun, 21 Dec 2025 10:01:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/mm/write_to_hugetlbfs: parse -s as
 size_t
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Waiman Long <longman@redhat.com>
References: <20251221085810.3163919-1-liwang@redhat.com>
 <20251221085810.3163919-2-liwang@redhat.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251221085810.3163919-2-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 09:58, Li Wang wrote:
> write_to_hugetlbfs currently parses the -s size argument with atoi()
> into an int. This silently accepts malformed input, cannot report overflow,
> and can truncate large sizes.
> 
> --- Error log ---
>   # uname -r
>   6.12.0-xxx.el10.aarch64+64k
> 
>   # ls /sys/kernel/mm/hugepages/hugepages-*
>   hugepages-16777216kB/  hugepages-2048kB/  hugepages-524288kB/
> 
>   #./charge_reserved_hugetlb.sh -cgroup-v2
>   # -----------------------------------------
>   ...
>   # nr hugepages = 10
>   # writing cgroup limit: 5368709120
>   # writing reseravation limit: 5368709120
>   ...
>   # Writing to this path: /mnt/huge/test
>   # Writing this size: -1610612736        <--------


I mean, whoever does that should not expect anything reasonable to 
happen with these selftests ... so I don't think Fixes: should be added.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

