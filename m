Return-Path: <linux-kselftest+bounces-39476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D03B2F588
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 12:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390601CC5B3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 10:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E43054E3;
	Thu, 21 Aug 2025 10:43:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7A72DC331;
	Thu, 21 Aug 2025 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773005; cv=none; b=i+hL7VER3zPrMNnacymLRxuPefrfa1USNpm+HcfHg2KL6up+S0HE74gmIw7bK2uO6glqnGw6qLpU4dUgGXoHGN50pjsgLZnttbps0vIOUhAefKHKx9YXAfy6y2alODumf398WyEYtTlEV386EGf/mhM5lWidx9wy3HChl79LIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773005; c=relaxed/simple;
	bh=xA5z4QGiRT8EMnfJu0zYHYDYsBX5hfHAvWyffpSGsoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqHqmGNEnjF3qcNDRq5/8lJjgHQMzMGtidevi+/QYi1yt2LbcYwbdfOzmZLjNcptUeHtMcW3yfvudilBbXKIw+884kGhjsVEHiYBbfZ9WZuO/7n1RngeK5V9R5zBUHlVgNmXxuwP0JYhlAcppXwCSjR1vna1ONkszuGGMwh03As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51F9D152B;
	Thu, 21 Aug 2025 03:43:14 -0700 (PDT)
Received: from [10.57.91.188] (unknown [10.57.91.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298EB3F63F;
	Thu, 21 Aug 2025 03:43:14 -0700 (PDT)
Message-ID: <88ea592c-c6ff-4a19-a366-eadeca66b039@arm.com>
Date: Thu, 21 Aug 2025 12:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] selftests/mm: Add -Wunused family of flags
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 linux-riscv@lists.infradead.org, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-5-usama.anjum@collabora.com>
 <57c816d6-a9ba-47c9-8f40-3978580b7f67@arm.com>
 <8e9d7c59-46b4-4e1b-8a55-1898302f5080@collabora.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <8e9d7c59-46b4-4e1b-8a55-1898302f5080@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/08/2025 08:28, Muhammad Usama Anjum wrote:
>> As to -Wunused-parameter I am frankly not convinced it's worth the
>> hassle. We're getting 90 lines changed in patch 6-8 just to mark
>> parameters as unused, in other words noise to keep the compiler happy.
>> It is not enabled by default in the kernel proper precisely because it
>> is so noisy when callbacks are involved.
>>
>> Patch 5 is clearly an improvement, but I'd rather take it without
>> actually enabling -Wunused-parameter. The rest of this patch isn't that
>> useful either IMHO.
> Patch 5 removes genuinely unused parameters flagged by the compiler. If we
> drop the -Wunused-parameter option, however, new unused parameters will
> continue to creep in with future patches. The goal of enabling this warning
> is to surface such issues early so developers can address them during
> development, rather than later during review or debugging.
>
> Long term, I’d like us to rely more on compiler and static analysis just like
> kernel to catch these kinds of problems proactively, instead of waiting until
> they’re reported or someone fixes them later. While it may feel like noise
> initially, this is largely a one-time cleanup—once done, developers will
> simply fix warnings as they arise, keeping the codebase cleaner going forward.

Agreed on the general principle, but I think the hassle is just too big
for what we're getting in return here (see also Andrew's reply). New
code may also introduce a bunch of unused parameters for legitimate
reasons and it's easy to imagine contributors ignoring such seemingly
harmless/irrelevant warnings instead of sprinkling __unused all over. My
feeling is that unused parameters are expected to be allowed in the
kernel and it isn't helpful to go against that expectation in just a
small subset of kselftests.

- Kevin

