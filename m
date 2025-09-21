Return-Path: <linux-kselftest+bounces-42018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF8B8DA51
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8222175045
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2AC2C026F;
	Sun, 21 Sep 2025 11:36:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5413B284;
	Sun, 21 Sep 2025 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454605; cv=none; b=V6qPtUNd+xEFKXZ9O+QZlz3EKW1q2iJtRsJpH4Ngg2mkhdiUx5kHqDTRfHv14HD19ooz7CU28ouRsfreS2XhguZOdj07dTZVLLMFiVfv0cxzKrViNveETXJJ9IKEv7lLSJmWXNmkLTig9aYlrcWaO6DQvTyL+kfrCBM2G+wQ0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454605; c=relaxed/simple;
	bh=EbZ3OCi/hMLuq+oBfBAnd/ax0RrvhbAfY4A9GdOgyeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihAqJ8Ykl6k3HB3OVrowOEJf2IlXDmN/HEHOSQ5yVpluHP3mo4ccAPvDc/G1ubY5moerQIU8Ceu87rX/tVmTzK5RizWBv9GR1lwncEVzCiYo9MTDY03O0pz9FZCxyBbNVmiTCZbW6z2YLXq0C0eXajP1KxSv1e82HAwL91nSR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E54B1516;
	Sun, 21 Sep 2025 04:36:35 -0700 (PDT)
Received: from [10.163.39.139] (unknown [10.163.39.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8DCA3F673;
	Sun, 21 Sep 2025 04:36:34 -0700 (PDT)
Message-ID: <4d2e8686-8810-4901-8483-9b5eb040d489@arm.com>
Date: Sun, 21 Sep 2025 17:06:31 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: "Luck, Tony" <tony.luck@intel.com>, Jiaqi Yan <jiaqiyan@google.com>
Cc: David Hildenbrand <david@redhat.com>, Kyle Meyer <kyle.meyer@hpe.com>,
 akpm@linux-foundation.org, corbet@lwn.net, linmiaohe@huawei.com,
 shuah@kernel.org, jane.chu@oracle.com, Liam.Howlett@oracle.com,
 bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org,
 laoar.shao@gmail.com, lorenzo.stoakes@oracle.com, mclapinski@google.com,
 mhocko@suse.com, nao.horiguchi@gmail.com, osalvador@suse.de,
 rafael.j.wysocki@intel.com, rppt@kernel.org, russ.anderson@hpe.com,
 shawn.fan@intel.com, surenb@google.com, vbabka@suse.cz,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
 <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com> <aMsDJ3EU1zVJ00cX@hpe.com>
 <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com>
 <CACw3F52p45t3iSZPjx_Lq9kBn1ZGTDZsxk+iQ-xFA1zdvdqqrw@mail.gmail.com>
 <aMsR4Tr9ov1pfucC@agluck-desk3>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aMsR4Tr9ov1pfucC@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/09/25 1:24 AM, Luck, Tony wrote:
> On Wed, Sep 17, 2025 at 12:32:47PM -0700, Jiaqi Yan wrote:
>> +1. Given /proc/sys/vm/enable_soft_offline is extensible, I would
>> prefer a compact userspace API.
>>
>>> would create a new file, and the file has weird semantics such that it
>>> has no meaning when enable_soft_offline=0.
> 
> So the expand the bitmask idea from earlier in this thread?
> 
> Bit0	0 = soft offline disabled. 1 = Enabled (but see other bits)
> Bit1	0 = allow offline of 4K pages, 1 = suppress 4K offline
> Bit2	0 = allow offline of hugetlb, 1 = suppress hugetlb offline
> Bit3	0 = allow breakup of transparent huge pages to just offline 4K, 1 = suppress transparent breakup
> Bit4+	Reserved for suppressing other page types we invent in the future
> 
> Values 0 and 1 keep their original meaning.
> 
> Value 5 means: offline 4K, keep hugetlb, breakup transparent huge pages.

This disable bitmask (but when generally enabled via bit[0] = 1) method
seems much better. But I am not sure about page size being a valid page
type classification though. Just to start with, defining first two bits
in this bitmask should be good enough, which will atleast help document
and validate this new interface properly.

Bit1	0 = allow offline of hugetlb, 1 = suppress hugetlb offline
Bit2	0 = allow breakup of transparent huge pages to just offline base pages, 1 = suppress transparent breakup
Bit3+	Reserved for suppressing other page types we invent in the future

