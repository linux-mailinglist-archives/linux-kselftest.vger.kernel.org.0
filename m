Return-Path: <linux-kselftest+bounces-45628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC4C5BE60
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 09:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61DD9345092
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41102F4A1B;
	Fri, 14 Nov 2025 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT9IHfhL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7206275AE4;
	Fri, 14 Nov 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107908; cv=none; b=KslehChCVHrbW9G2P44D3GXRuhpjodyd/DOVNF9CfaHrE7FdtRZjVYK6Zy05XiHRK/dcpz/+GBeTWnqiJmyHVgEgF4HW/+UyS/qCwvsIFU1euIv9GXqtOGOaKZWn8enjiaU1FIMwjDXIVW2Cqf8GspXS4e9r2RjEIk5p9k7IcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107908; c=relaxed/simple;
	bh=OhGJvBDuLbsZuOLjHyEX6xIRl+rLMcdKrk/4+J4TeoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8eyIBzMIPsFbvi6ZMlUEoTMRcvTCoDATCXTmwQUCdUextFb5Eq71/9i5UbgRLpn9xTHWdK/CKvZERA9C2fjnGhOR9ZtGf33PBns2p9nhRWiRZ64GUFlxb+uwwlvIFXSCIN3F7sDFh3hvQTM2yO6eHMGnSrFZjpz2DJWS3GuWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT9IHfhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39037C19421;
	Fri, 14 Nov 2025 08:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763107906;
	bh=OhGJvBDuLbsZuOLjHyEX6xIRl+rLMcdKrk/4+J4TeoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MT9IHfhLgZNygWpWG+dIRg6p7RUMUEJnK40W4JZjMG0Yi6v+emGp8fU39Dv5V938i
	 RfBl//v9Ge3H/xItQ2DqNjBiq9ZOnM4UIPaxoDcfBXafM4kkEDITA9SSqc2sSdXGVq
	 o7Hu4mvfGFxlFKsWc/nNdJvQQlg9sWoXCT9DHE3oYDYq6WZMkCe7PG6unlXomQBHHk
	 UaXZwAnG6UHtepYc44yd4I52ghf1b8H64CrQCGiRPzXDn9UGEQmvBdJZMaPf1ClPot
	 aPgBmOUnsHTiqmRoTeu8rOVEFVk+Rd+smmC0ATKdv/AoT0lOdj+uCLIh1F+0T5pdCu
	 oCyn+0Y2SCsIw==
Message-ID: <9d30836b-9ddb-4432-aa39-85e32c2ea645@kernel.org>
Date: Fri, 14 Nov 2025 09:11:40 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
To: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Carlos Llamas <cmllamas@google.com>, Peter Xu <peterx@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Ujwal Kundur <ujwal.kundur@gmail.com>,
 Brendan Jackman <jackmanb@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "open list:MEMORY MANAGEMENT - USERFAULTFD" <linux-mm@kvack.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20251113034623.3127012-1-cmllamas@google.com>
 <e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
 <4a60a703-d9c2-46a8-83b4-a7ecff7f6ba2@lucifer.local>
 <aRXyxWeh81-aTHaC@google.com>
 <b4291d0d-b913-4e61-9f9d-fbebd1eb4720@lucifer.local>
 <20251113153205.6507ecb308e7d09362905da7@linux-foundation.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251113153205.6507ecb308e7d09362905da7@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.11.25 00:32, Andrew Morton wrote:
> On Thu, 13 Nov 2025 15:03:06 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> 
>> On Thu, Nov 13, 2025 at 03:01:25PM +0000, Carlos Llamas wrote:
>>> On Thu, Nov 13, 2025 at 09:54:37AM +0000, Lorenzo Stoakes wrote:
>>>> On Thu, Nov 13, 2025 at 10:06:42AM +0100, David Hildenbrand (Red Hat) wrote:
>>>>> On 13.11.25 04:46, Carlos Llamas wrote:
>>>>>> Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
>>>>>> vars into struct") moved some of the operations previously implemented
>>>>>> in uffd_setup_environment() earlier in the main test loop.
>>>>>>
>>>>>> The calculation of nr_pages, which involves a division by page_size, now
>>>>>> occurs before checking that default_huge_page_size() returns a non-zero
>>>>>> This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.
>>>>>>
>>>>>> Fix this by relocating the non-zero page_size check before the nr_pages
>>>>>> calculation, as it was originally implemented.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>
>>>>> Do we CC stable on unit tests? From my recollection, no.
>>>>
>>>> Yeah please let's not.
>>>
>>> Oops, I keep getting confused about this Cc stable thing. Please let me
>>> know if a v2 dropping the tag is needed.
>>
>> No need, Andrew should spot the objection and drop the tag :)
> 
> I actually add cc:stable tags to selftests fixes!
> 
> Because why not.  Why leave people running known-to-be-buggy code when
> our backporting processes are so well-functioning and lightweight?
> 
> I'm not getting the objection?

I thought we were so inconsistent on that that it ends up being a wasted 
effort to even try taking care about stability of selfests in stable trees.

-- 
Cheers

David

