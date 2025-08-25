Return-Path: <linux-kselftest+bounces-39825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864CAB3378F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 09:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615A416FF76
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 07:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA52882DE;
	Mon, 25 Aug 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kK2qjz9J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224262877DA;
	Mon, 25 Aug 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106104; cv=none; b=fE/7b7XeKev/oV6xM4AG03ZI6kp35nD//fS12jKMGuzWjCGnxg8KWdfLUssEvHg86l07cyMEu38Rkr1ItTloJLtNXVpS2GpnDvttjSbznSne7cQdPdaphbv5u4145xiGKAij9XJ2W71nM1XK6/EivnJAR1PWuYGqFBHSWyANS/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106104; c=relaxed/simple;
	bh=eMGy4y29o/Xaojr66YRlL+mqETiAilNKbdnWyHcteLs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fqQG7O6fVrqIpdZPkqundlUbEdtwjf2xMvGlobW4jjEtg82xiy6Wm8zLzf2iYa5cPBF+1R//s5TxeI70fda+wKyXuEdG8pkYvD/KAtZCx6XXRyI90yjFe/FBjerueskjcZps7ztFkpoTslMma7A+KsIZnepgLm5mrHHkNRRo9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kK2qjz9J; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756106099;
	bh=eMGy4y29o/Xaojr66YRlL+mqETiAilNKbdnWyHcteLs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kK2qjz9JmVvoqJbD+9Z2wBdusaJYnGDPmASxy0tVLx+dYO/BpufQRmUxwhZILWCGY
	 XU7mzb/j2AgGn1PT4XVSPU+WLEmogXtQTIhUHJeQTMSGvGOW693yIzmaJ8fLbcQ2Zf
	 TtLcR1DvxIjOI25VfZOtzLhyh5PbZpRcJmPZA0J5UYkPteGoxeZ11nGAd3eblYsxGn
	 CDxzTf7MJZlv465pIZzrgFXb+3uRDM3YhN8OyMms1PvrN27kVTFD9rtaPOTLuGQWYG
	 GHZjSthrN1HEe05yGba1hjLeFocUYqA1NAs9tDD3OFNtWA2AqIzacsZK0dwrzg9e4S
	 3xOUmfKuPc9oQ==
Received: from [192.168.100.175] (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 08E4B17E110D;
	Mon, 25 Aug 2025 09:14:53 +0200 (CEST)
Message-ID: <a3928ec4-8c2f-4f04-bab4-9ef5c87c57de@collabora.com>
Date: Mon, 25 Aug 2025 12:14:52 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kevin.brodsky@arm.com, kernel@collabora.com
Subject: Re: [PATCH v3 0/8] selftests/mm: Add compiler flags and fix found
 warnings
To: Andrew Morton <akpm@linux-foundation.org>
References: <20250822082145.4145617-1-usama.anjum@collabora.com>
 <20250822174259.bf4ed76a0da7d0d6f80ba2c1@linux-foundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250822174259.bf4ed76a0da7d0d6f80ba2c1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/25 5:42 AM, Andrew Morton wrote:
> On Fri, 22 Aug 2025 13:20:57 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> 
>> Recently, I reviewed a patch on the mm/kselftest mailing list about a
>> test which had obvious type mismatch fix in it. It was strange why that
>> wasn't caught during development and when patch was accepted. This led
>> me to discover that those extra compiler options to catch these warnings
>> aren't being used. When I added them, I found tens of warnings in just
>> mm suite.
>>
>> In this series, I'm adding these flags and fixing those warnings. In the
>> last try several months ago [1], I'd patches for individual tests. I've
>> made patches better by grouping the same type of fixes together. Hence
>> there is no changelog for individual patches.
> 
> I think it would be best to avoid adding warnings to selftests which
> aren't present in the main kernel code.  If only to avoid surprising
> people over what isn't permissible in selftests/.
> 
> In particular, there's an expectation that we can do
> 
> #else
> static inline int some_stub(type1 arg1, type2 arg2)
> {
> }
> #endif
> 
> without warning.  We do this extensively.

I'm only adding -Wunreachable-code -Wunused flags now. The above shouldn't
cause any warnings. I'll double check again in next series.

> 
> Also, please be aware that there's already a patch in mm-new which
> centralizes selftests' __maybe_unused definition.
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftests-centralise-maybe-unused-definition-in-kselftesth.patch
I'll rebase on top of it and send again.


-- 
---
Thanks,
Usama

