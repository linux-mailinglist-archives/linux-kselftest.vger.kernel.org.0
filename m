Return-Path: <linux-kselftest+bounces-47822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3EACD56F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB0F43009FF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB130C60B;
	Mon, 22 Dec 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVjoBzrz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B624280A5A;
	Mon, 22 Dec 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766397681; cv=none; b=JDktp9DfRtlFfz42EUR9x5nLbFYUqf7f+g2GWXcRlshW8q76FzU6Sff86phmZnsS1JPFcbATpDUpSa/xSoDGYUItliRIiitGT2z4tCq94Xg6jJ8WSm3+3vYF/cbWc9jKg46C/8z9p7ZMDiFeFT5EovpTEmaYRWhKOGWFhRXtgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766397681; c=relaxed/simple;
	bh=UZ4P5M3gSargbfZbWlgwDbORLDGuoxCS7PlKczHNQeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxyvMoHJm6dSkzcgv/x8raEKLI4Ui8i91OQJzPjB5drnnaUneWe3y79F697osCsBPu+k1izJkXHuKUV0BSbe7tYZPnD7xqIc4S/QEEaHE+/hZnsrCp8WrlUsxcv2NccJ/YhRP1SsYz8JucC5NvOI0p8qWJjfWy/u17+JF/gvCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVjoBzrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC0C4CEF1;
	Mon, 22 Dec 2025 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766397680;
	bh=UZ4P5M3gSargbfZbWlgwDbORLDGuoxCS7PlKczHNQeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LVjoBzrztNA4FDbA8DYzzhbUKtp7wwKmAN0wGhk+A7PwO20p8fHNzg7phwwNdmoBx
	 N4WWaLh8wjVuMBW4ErbmhKLRO5YCHdmN8ulX7vcdMZHEi2LQkygJDDiJw8CY6WNlv7
	 s6EbW8MjY7/Wy3FDAbe5+5dWbFUk0rGMdwa0x2UaiL3iGDpXlVe87A3OHlWY7uA82x
	 p0GRBcd1YUfrnxkf+sW0+Af8cDYh/BTzPziOGknaRoc4MBGIWnTJSppq2G4/UkTmbt
	 /mSCec2n0NyCpalqJhly6TObP6J4iYBxLap8EZfFGGwErKJ/nztdPHSGx8BN8rrzqv
	 UBW6OvzgYRgvg==
Message-ID: <53e302a7-1c78-4b76-87e8-1cc10c76535d@kernel.org>
Date: Mon, 22 Dec 2025 11:01:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] selftests/mm/charge_reserved_hugetlb: drop mount
 size for hugetlbfs
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Waiman Long <longman@redhat.com>
References: <20251221122639.3168038-1-liwang@redhat.com>
 <20251221122639.3168038-3-liwang@redhat.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251221122639.3168038-3-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 13:26, Li Wang wrote:
> charge_reserved_hugetlb.sh mounts a hugetlbfs instance at /mnt/huge with
> a fixed size of 256M. On systems with large base hugepages (e.g. 512MB),
> this is smaller than a single hugepage, so the hugetlbfs mount ends up
> with zero capacity (often visible as size=0 in mount output).
> 
> As a result, write_to_hugetlbfs fails with ENOMEM and the test can hang
> waiting for progress.
> 
> --- Error log ---
>    # uname -r
>    6.12.0-xxx.el10.aarch64+64k
> 
>    #./charge_reserved_hugetlb.sh -cgroup-v2
>    # -----------------------------------------
>    ...
>    # nr hugepages = 10
>    # writing cgroup limit: 5368709120
>    # writing reseravation limit: 5368709120
>    ...
>    # write_to_hugetlbfs: Error mapping the file: Cannot allocate memory
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    ...
> 
>    # mount |grep /mnt/huge
>    none on /mnt/huge type hugetlbfs (rw,relatime,seclabel,pagesize=512M,size=0)
> 
>    # grep -i huge /proc/meminfo
>    ...
>    HugePages_Total:      10
>    HugePages_Free:       10
>    HugePages_Rsvd:        0
>    HugePages_Surp:        0
>    Hugepagesize:     524288 kB
>    Hugetlb:         5242880 kB
> 
> Drop the mount args with 'size=256M', so the filesystem capacity is sufficient
> regardless of HugeTLB page size.
> 
> Fixes: 29750f71a9 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")

Likely Andrew should add a CC of stable

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

