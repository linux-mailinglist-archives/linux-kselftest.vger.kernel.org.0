Return-Path: <linux-kselftest+bounces-47658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C80CC6F4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 11:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6363302034F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6705A346FB8;
	Wed, 17 Dec 2025 09:58:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C533ADB4;
	Wed, 17 Dec 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965536; cv=none; b=WCkziEOQk3XqXXbcvgs6nFK9oY5am9J4jSOZVT7nAoNkwjqj0cQ98pk9O9Whw0rLKmLRM+RXEVw2CxIuMTrxJYjpnPGUoI3zDSxtPdviemZR6gqsaS3SKtNWSlEbMlvo4792Q8v9A2LCPb9ACJqPfGC8k16vKygRIqc/cXifG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965536; c=relaxed/simple;
	bh=OATvUezWcwn2SPkaKqyVJ5IFoBchjNJmzx7gvYOlEac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBajAikIMkr9F5VwNZ/iqNwFwvFdW7LiJvvoBj/WenAdHnpdDJaFKMPW9wsdxrLl2f5B0AgkOZalp+c7M//x477mPNax7VmEK+YDoOAf3qTaV4937a2ul4hDP9vz6ZUa2zNVSG8XIqRZrwGN9pVs5L8ciP675uKnnp6bwjUKKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8038C14BF;
	Wed, 17 Dec 2025 01:58:46 -0800 (PST)
Received: from [10.57.47.3] (unknown [10.57.47.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D2E43F73B;
	Wed, 17 Dec 2025 01:58:51 -0800 (PST)
Message-ID: <c59eb8d7-c6bb-4618-b7d4-2ce5df88b5f1@arm.com>
Date: Wed, 17 Dec 2025 10:58:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests/mm: remove flaky header check
To: Yunsheng Lin <linyunsheng@huawei.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <shuah@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-2-kevin.brodsky@arm.com>
 <b62c18a2-7036-4cca-a3e6-8a873a2ca832@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <b62c18a2-7036-4cca-a3e6-8a873a2ca832@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 04:18, Yunsheng Lin wrote:
> On 2025/12/16 22:26, Kevin Brodsky wrote:
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
> As some commercial OS still uses v6.6, I am wondering if we need that

Fair point, I hadn't considered that kselftests are supposed to be
buildable against older stable kernels.

> check for a little longer, is it possible to do something like below to
> avoid the flaky check?
>
> @@ -46,7 +46,8 @@ CFLAGS += -U_FORTIFY_SOURCE
>
>  KDIR ?= /lib/modules/$(shell uname -r)/build
>  ifneq (,$(wildcard $(KDIR)/Module.symvers))
> -ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
> +KSRC := $(shell readlink -f $(KDIR)/source 2>/dev/null || echo $(KDIR))
> +ifneq (,$(wildcard $(KSRC)/include/linux/page_frag_cache.h))
>  TEST_GEN_MODS_DIR := page_frag
>  else
>  PAGE_FRAG_WARNING = "missing page_frag_cache.h, please use a newer kernel"

That seems reasonable, and it works for my out-of-tree setup.

Will do that in v2, shall I add your Suggested-by, or maybe Co-developed-by?

- Kevin

