Return-Path: <linux-kselftest+bounces-48231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D570CF5335
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 19:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0453F308624F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F773339B24;
	Mon,  5 Jan 2026 18:13:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE40321434;
	Mon,  5 Jan 2026 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636804; cv=none; b=LA/sGxS5AGLUjNYxYkrkwfUvo2gebY6MocK5+V6fWvYI5g6Wxrg5JQwZXv5zqKkZ4oc67miPnT7/AMZ8dVT1uDw5DwIjBCULioMQqyQyhWfXyGT1siP++73ZUt3VaRg9lvJ43wViCg2oEHwa2iWrvXy+GTutYuh+8H+yaDN+IQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636804; c=relaxed/simple;
	bh=f/inY4Rq4m8bq2vUcsq03gaYBYuom2rNf6fvlA2/WYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKdRcZJv+GCltBsOgSTqZ5/jnOukHDqTowVM1Xi00Af+uDselezyLfV44kfj/zjxWmKMp2qOQN4TaRaP9ZBr/6k8tqHqROXpJvWoPqwW5mok3cw6T/oEr+Tz3B2tPJRrNokvYIxhuJdfvqLkKnBXv3/3NJ89MRM2bOyyZnW44qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB8A339;
	Mon,  5 Jan 2026 10:13:13 -0800 (PST)
Received: from [10.57.47.111] (unknown [10.57.47.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D61093F6A8;
	Mon,  5 Jan 2026 10:13:18 -0800 (PST)
Message-ID: <4ad1bc4e-b1dc-46a3-845b-e648e4304ad4@arm.com>
Date: Mon, 5 Jan 2026 19:13:16 +0100
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
 <9c97ac9c-b0df-42e7-84fc-7e0d986c7324@arm.com>
 <2bc4e09a-045a-4d33-8857-1bdfe3281da2@sirena.org.uk>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <2bc4e09a-045a-4d33-8857-1bdfe3281da2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/01/2026 13:46, Mark Brown wrote:
> On Mon, Dec 29, 2025 at 04:40:26PM +0100, Kevin Brodsky wrote:
>> On 18/12/2025 15:25, Mark Brown wrote:
>>> Well, there's also the selection of KDIR which for some reason defaults
>>> to the installed kernel so we get:
>> Overall the kselftests tend to assume that we're building on the same
>> machine we'll run them, so at least that feels consistent. The same
>> default is used for most other out-of-tree kselftests modules
>> (livepatch, net/bench).
> That's really not the expected usage pattern, I'd be surprised if a
> non-trivial propoprtion of kselftest builds were intended to be run on
> the system they're built on - a lot of people test interactively in VMs,
> or on some other target hardware, and automated systems are going to be
> building separately.  The two you've identified look like special
> snowflakes TBH (livepatch in particular has a bunch of other issues due
> to what it's trying to do).
>
>> Maybe the documentation should be updated to recommend setting KDIR
>> explicitly? Or maybe it could default to KDIR=$PWD or $(abspath
>> $(KBUILD_OUTPUT)) when cross-compiling?
> I think defaulting to something related to the current kernel build is
> more sensible here.

Fair enough, fine by me. Then I'll change the default to the output
directory and remove the header check.

- Kevin

