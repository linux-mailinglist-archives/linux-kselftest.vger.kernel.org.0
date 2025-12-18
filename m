Return-Path: <linux-kselftest+bounces-47709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F88ECCC071
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 14:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93A9830A9C92
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461C33A01C;
	Thu, 18 Dec 2025 13:24:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0D33A038;
	Thu, 18 Dec 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064259; cv=none; b=oBMeCMd+1+uHUgQLydjQPh1mQJ07nQmN1tIob2g/KSQp8OTMMwEfdIGsQ+ZW78KqWZovhLXdLz8BLA84mxyuexlkOZSsb32hWhp0gxHkru3+cVgX+FLDUlHVTY25xB8OopOClSdmhpAxQQhU5ItHphM4nIZU4ZdHUmtGk3DA6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064259; c=relaxed/simple;
	bh=DlCDfZgm5JsmTafpliNDNHYQsLVdY8Jj7Nu3gUmzK2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tufLkujP4D14ZHakJ6LK9OUs/OiJzIerw+QNuv7MJ3SYBiJtHcqQ3Z+oy1mKE+hep2l3SZhGQoeYl7CkPjuLXgnq5B6NH7uUdDUp3t+34aVUto7ntunYbTZywE16emomzZ6fELGROfQjuRKkbuK0y+p45wDZUQNzr7gX/PY38mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98AE0FEC;
	Thu, 18 Dec 2025 05:24:08 -0800 (PST)
Received: from [10.57.45.71] (unknown [10.57.45.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B5F13F73F;
	Thu, 18 Dec 2025 05:24:13 -0800 (PST)
Message-ID: <e971e44e-5539-4fc4-8128-0ce9c3d10a38@arm.com>
Date: Thu, 18 Dec 2025 14:24:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests/mm: remove flaky header check
To: Mark Brown <broonie@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-2-kevin.brodsky@arm.com>
 <5f866c1a-c8cd-4dc6-b312-9017cef89920@sirena.org.uk>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <5f866c1a-c8cd-4dc6-b312-9017cef89920@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 11:04, Mark Brown wrote:
> On Tue, Dec 16, 2025 at 02:26:30PM +0000, Kevin Brodsky wrote:
>> Commit 96ed62ea0298 ("mm: page_frag: fix a compile error when kernel
>> is not compiled") introduced a check to avoid attempting to build
>> the page_frag module if <linux/page_frag_cache.h> is missing.
>>
>> Unfortunately this check only works if KDIR points to
>> /lib/modules/... or an in-tree kernel build. It always fails if KDIR
>> points to an out-of-tree build (i.e. when the kernel was built with
>> O=$KDIR make) because only generated headers are present under
>> $KDIR/include/ in that case.
>>
>> <linux/page_frag_cache.h> was added more than a year ago (v6.13) so
>> we can probably live without that check.
> More generally building selftests with random older kernel versions
> isn't really something that's expected to be robust:

I suppose that Documentation/dev-tools/kselftest.rst talks about
*running* against older kernels, not *building* against them. That said,
we are dealing with an out-of-tree kernel module here, so the two are
essentially the same... Yunsheng suggested an updated check that I think
is reasonable, maybe it is a reasonable compromise?

- Kevin

