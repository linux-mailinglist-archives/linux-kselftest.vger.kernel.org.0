Return-Path: <linux-kselftest+bounces-47992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF91CE73D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED45302BD08
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4C329E4C;
	Mon, 29 Dec 2025 15:40:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51B2FB093;
	Mon, 29 Dec 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022834; cv=none; b=cf0FUGzqwBKWCq1KVdJwj4MvcCRcNbM22DfbAEeM1Eba9sohbTUi0XTjZDnlq0MHbdNat0ngOTofaQteHZduEwG5FdaTsUYNk32k1eTLnBHrZoOaw7FF3mLM6PKpUUDQHPySsp04sOe8qXC+9GVx02n3WRS9Wcjp8lczXYbsnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022834; c=relaxed/simple;
	bh=cmb/2mPKVT+NXGQPjmCUwLkIrh+sh+1dgDr17I29+YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtx75HKVCvSr5RPfK90cqCs1DC0EGhSfdTrF5pmXbWVbYjlCBIzu8fKsQDlFFJUCePLtq6fO35umPUpdZdIoedlLdVNRsv1c9q2mmE3tucyOZKpT+wWKzoJOgqINziN4qverMw+4jX/tzH+727DSaD3HNAq6oiZ5pKaw+yIEym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A886339;
	Mon, 29 Dec 2025 07:40:24 -0800 (PST)
Received: from [10.57.45.222] (unknown [10.57.45.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DBE13F5A1;
	Mon, 29 Dec 2025 07:40:29 -0800 (PST)
Message-ID: <9c97ac9c-b0df-42e7-84fc-7e0d986c7324@arm.com>
Date: Mon, 29 Dec 2025 16:40:26 +0100
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
 <e971e44e-5539-4fc4-8128-0ce9c3d10a38@arm.com>
 <682f64d0-353c-47bb-808b-eacc2d4d6c00@sirena.org.uk>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <682f64d0-353c-47bb-808b-eacc2d4d6c00@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2025 15:25, Mark Brown wrote:
> On Thu, Dec 18, 2025 at 02:24:10PM +0100, Kevin Brodsky wrote:
>> On 17/12/2025 11:04, Mark Brown wrote:
>>> More generally building selftests with random older kernel versions
>>> isn't really something that's expected to be robust:
>> I suppose that Documentation/dev-tools/kselftest.rst talks about
>> *running* against older kernels, not *building* against them. That said,
> Yeah, running is fairly normal but huge swathes of the selftests won't
> build without current kernel headers and it's not an especially useful
> use of time to support that.
>
>> we are dealing with an out-of-tree kernel module here, so the two are
>> essentially the same... Yunsheng suggested an updated check that I think
>> is reasonable, maybe it is a reasonable compromise?
> Well, there's also the selection of KDIR which for some reason defaults
> to the installed kernel so we get:

Overall the kselftests tend to assume that we're building on the same
machine we'll run them, so at least that feels consistent. The same
default is used for most other out-of-tree kselftests modules
(livepatch, net/bench).

>   $ make -C tools/testing/selftests LLVM=1 ARCH=arm64 TARGETS=mm
>
>   Warning: missing page_frag_cache.h, please use a newer kernel. page_frag test will be skipped.

But yes if cross-compiling the default makes no sense and KDIR has to be
set explicitly.

> Your changelog says it'll work for an in tree build but I can't figure
> out how to do that (using the top level Makefile to recurse doesn't seem
> to DTRT either).  Having looked at this more I think the problem here is
> that the selection of KDIR is wrong, not the check.

I use KBUILD_OUTPUT=out and KDIR needs to be absolute, so:
KDIR=$PWD/out. I suppose for an in-tree build KDIR=$PWD would do the
right thing. But yes it's all very wonky.

Maybe the documentation should be updated to recommend setting KDIR
explicitly? Or maybe it could default to KDIR=$PWD or $(abspath
$(KBUILD_OUTPUT)) when cross-compiling?

- Kevin

