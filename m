Return-Path: <linux-kselftest+bounces-28023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B8A4BCDE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 11:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382D23ADF70
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9891F30DD;
	Mon,  3 Mar 2025 10:46:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549DE1F37B8;
	Mon,  3 Mar 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998798; cv=none; b=oD1r5ZNBZoMQB6B590NM5ou4SCp/YdtwfKlZ+atTacwFedNRVnp0TeoriwRJAa/3w+LBpTvapmkfFOasBbe5RZd3qUDPw+YLN37sNADZn2lt+v2R4K0Dpgtv98I//MhX7hBLfdk6xjXZIWQKe7bC4MuJk5KhkIpdmqfGwrN/fTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998798; c=relaxed/simple;
	bh=679jHHpJiH/QrdZhvnaAMRPukFFs582fj75sGybLgHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsE07TrPtxC6pTyxdHm4jdMkqNYJPpBN+ygi24t+HWnwr6Wqnue3Pxkq6OD1CF0SxRTuTakTimWurc44EescM42xxsUJvUkgdyPHgWNZfhJ2lZMhKsg/Xv0ykbU9Xc1yIXSe2abt79qFsHE/HViMuTQwe3UMDZQHHPpv2nlU48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BC34113E;
	Mon,  3 Mar 2025 02:46:49 -0800 (PST)
Received: from [10.163.38.109] (unknown [10.163.38.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56143F66E;
	Mon,  3 Mar 2025 02:46:32 -0800 (PST)
Message-ID: <b665b2b2-e407-4a1f-af34-02b6aeb7ff17@arm.com>
Date: Mon, 3 Mar 2025 16:16:29 +0530
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
 <18ea9794-3901-4802-875c-b0327984a9d6@arm.com> <Z8WFzISSAmtjtu3L@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Z8WFzISSAmtjtu3L@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/03/25 4:04 pm, Brendan Jackman wrote:
> On Mon, Mar 03, 2025 at 03:48:38PM +0530, Dev Jain wrote:
>>
>>
>> On 03/03/25 3:17 pm, Brendan Jackman wrote:
>>> On Fri, Feb 28, 2025 at 11:06:35PM +0530, Dev Jain wrote:
>>>> Taking a cursory look at the test, it creates three threads for each cpu.
>>>> The bounding of the variable is fine but that being the reason to rename the
>>>> variable is not making sense to me.
>>>
>>> Hmm yeah the name needs to be more abstract. Do you think nr_workers
>>> would be confusing? Or even just "parallelism" or nr_parallel? Or any
>>> other ideas?
>>>
>>> FWIW I briefly looked at just cleaning this up to remove the global
>>> variable but that's a bigger time investment than I can afford here I
>>> think. (The local variable in stress() would still need a better name
>>> anyway).
>>>
>>> Thanks for the review BTW!
>>
>> Your welcome.
>>
>> I personally prefer leaving it as is; unless someone comes up and completely
>> cleans up the structure, let us save our collective brain cycles for more
>> meaningful battles than renaming variables :)
> 
> Hmm, I think that's a false economy on brain cycles. A variable called
> nr_cpus that isn't a number of CPUs is bound to waste a bunch of
> mental energy at some point in the future.
> 
> Unless you strongly object I'll go for nr_parallel. It's not a great
> name but, well... I think that probably just suggests it's not a great
> variable, and I don't have time to fix that.

nr_parallel sounds better for sure. In case you send out a new patch:

Reviewed-by: Dev Jain <dev.jain@arm.com>


