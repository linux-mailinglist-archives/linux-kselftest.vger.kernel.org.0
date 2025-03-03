Return-Path: <linux-kselftest+bounces-28021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E58FEA4BBDF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 11:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BCE16E49C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DEE1EEA49;
	Mon,  3 Mar 2025 10:18:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08A1EC01D;
	Mon,  3 Mar 2025 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997126; cv=none; b=hHTTxBNcXmuyPfRtgYnDOLaAYMxI/23Er/XL+wUD4Mpxk2FMuAtIM2N0QjybwbvgAti/Dp86a2ArZbGyMczJVfIUg7/TSJPtZEfPJ9uNq2fJ0zGLLHc2CgCPM4VeqNWG0DddKZVzq2LmLkdVUm+OLLdJg5VnC6xTVu7QCSCeFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997126; c=relaxed/simple;
	bh=4WWNAHQh+XvY80gXEnh5L9romOWeq5HbCjAs1NzKAIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2CnxNgQ+5XKcTdiwlTkxuYvLyDrHa2sg7m+xo9lI0gj8XcbvM5qB70K0PrPM4hhnbMGMu242/iSXZ0PwCl+bwrX0dzHwSmpA4PcHWihjiVWxQ1bFAMAelML96IGuszkdkCTydmit/Gc4jsqm54XzlkH0SV4Dg7/gsCKoDfwO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F2E812FC;
	Mon,  3 Mar 2025 02:18:58 -0800 (PST)
Received: from [10.163.38.109] (unknown [10.163.38.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C17CC3F66E;
	Mon,  3 Mar 2025 02:18:41 -0800 (PST)
Message-ID: <18ea9794-3901-4802-875c-b0327984a9d6@arm.com>
Date: Mon, 3 Mar 2025 15:48:38 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] selftests/mm/uffd: Rename nr_cpus -> nr_threads
To: Brendan Jackman <jackmanb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-4-958e3b6f0203@google.com>
 <b5b1e43d-0298-4772-ba0d-acec63a05149@arm.com> <Z8V6xYvqqkPxULgN@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Z8V6xYvqqkPxULgN@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/03/25 3:17 pm, Brendan Jackman wrote:
> On Fri, Feb 28, 2025 at 11:06:35PM +0530, Dev Jain wrote:
>> Taking a cursory look at the test, it creates three threads for each cpu.
>> The bounding of the variable is fine but that being the reason to rename the
>> variable is not making sense to me.
> 
> Hmm yeah the name needs to be more abstract. Do you think nr_workers
> would be confusing? Or even just "parallelism" or nr_parallel? Or any
> other ideas?
> 
> FWIW I briefly looked at just cleaning this up to remove the global
> variable but that's a bigger time investment than I can afford here I
> think. (The local variable in stress() would still need a better name
> anyway).
> 
> Thanks for the review BTW!

Your welcome.

I personally prefer leaving it as is; unless someone comes up and 
completely cleans up the structure, let us save our collective brain 
cycles for more meaningful battles than renaming variables :)

