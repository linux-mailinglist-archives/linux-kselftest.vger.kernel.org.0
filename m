Return-Path: <linux-kselftest+bounces-44946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747DC3A8B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE4E34FAE88
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F4038DE1;
	Thu,  6 Nov 2025 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvia0hXf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA612E0413;
	Thu,  6 Nov 2025 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427943; cv=none; b=hEXSr6czCGWFygpFVefXjnRFhRQWEAW0j6l+1RhnB+plgWFQzHbMAJgXDW92Pq5LomNH9M0Jj7BJe9agvxgSPXOyvqcjMTj0+FTaStJp68mRJbOnKLHSxD4kLoonbpe7FEdNXikI5uID9/p8UV5/XjC7BTYJ/fsraBDLrWpxfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427943; c=relaxed/simple;
	bh=uImHPwXYfgO1OsgDjUhpotL5RTPQMGjlax5/2LxDgoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D34FjS4d4UQO8J8i2M4u7ChGjQZd+UeN+y22Qqm70CNtYx/m4yD71s9OC+NPbXe/ig6UunYPLjv13wwZ/6fhvwlf2qSimkO/yq2wJTN5LfewagdtrHgH8J6xL/VCn2fNMT3arCYRVdfrtL73qXfD4Vi0KKskoqroTt14QB50/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvia0hXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C2BC116C6;
	Thu,  6 Nov 2025 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762427942;
	bh=uImHPwXYfgO1OsgDjUhpotL5RTPQMGjlax5/2LxDgoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bvia0hXfwFamS3dGiFgQBaoMMG5MmqEThD5KdGn9o8KcIojUqXbnUEfhwSP3SDXCd
	 PczjxFlmYVUgjZVjsEhx3x0/M+Jvun0vI8752K6yBV/jqR/WxMxR/q8cR3srOo+pRI
	 dyV9en4CtAGWtl777bKKjxwTivN8Go+7/3LZRyvUVsonZO5OyY8k32H72oNsWAUqAL
	 zg/Uhu66tqP0Uyugrk5R9z8FjVKfJAwBDxMxcmDjE68w7b4OmppwUofAM7OQReutkd
	 OT2YA4Bg7/J5ZOPNvxfZrJ8lQcygIWTaqe7KANgdrbEXRfVyBMyaU0zMLV+4P2RwSu
	 HC0A5l+qjwJNA==
Message-ID: <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>
Date: Thu, 6 Nov 2025 12:18:57 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.11.25 11:49, Ankit Khushwaha wrote:
> Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
> triggers following warning:
> 
> mremap_test.c:1035:31: warning: pointer comparison always evaluates to
> false [-Wtautological-compare]
>   1035 |                 if (addr + c.dest_alignment < addr) {
>        |                                             ^
> 
> typecasting 'addr' to 'unsigned long long' to fix pointer comparison.

With which compiler are you seeing this?

-- 
Cheers

David

