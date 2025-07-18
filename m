Return-Path: <linux-kselftest+bounces-37585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C22AB0AA16
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C1B1C80878
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 18:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921DA2E6D09;
	Fri, 18 Jul 2025 18:23:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19811E98FB;
	Fri, 18 Jul 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863013; cv=none; b=i17uXIQvogFNUnwM+2nhg3wn1eatRREUZnWS6u0Ex+lgcz8aSwT+Vt2dubLfc+q1Hp5YClXA71GJTgUZcD1VcugG1+D0hJymFSPVd47HSh+VkSTCobYiaOL9gQsE4dT+fETqscyb+iSZr5TVSwSTW0M8xwqBJyCih7n+c4rnIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863013; c=relaxed/simple;
	bh=a/QvL04iyKWo+Racf1Cybelb9RFnWSVaLj/BWzBAs6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4Pfhsd4fA7bKc9Lkwsw3Sh7G0genkJyDn6r27pcONLpqqaT6O9qz6QzSIBacc7APIaumu6SyertfDU2SP9/TtlrHiRdGngJGxBgRXGftstsd5jRHr9NrUO7CRYt/AqJJp/vGREiJ98yI07AwcltVWnneJvGInhYf0465MhD174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF45516A3;
	Fri, 18 Jul 2025 11:23:23 -0700 (PDT)
Received: from [10.57.1.4] (unknown [10.57.1.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 376B13F694;
	Fri, 18 Jul 2025 11:23:28 -0700 (PDT)
Message-ID: <d18d7013-e82e-456a-87da-8acffc90d8db@arm.com>
Date: Fri, 18 Jul 2025 19:23:25 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommufd/selftest: Test reserved regions near
 ULONG_MAX
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, patches@lists.linux.dev, stable@vger.kernel.org,
 syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com,
 Yi Liu <yi.l.liu@intel.com>
References: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <aHm1WRAGgk/6HZMC@Asurada-Nvidia> <aHoCOnOAlwpoiDNe@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aHoCOnOAlwpoiDNe@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-18 9:13 am, Nicolin Chen wrote:
> On Thu, Jul 17, 2025 at 07:45:51PM -0700, Nicolin Chen wrote:
>> On Thu, Jul 17, 2025 at 04:15:09PM -0300, Jason Gunthorpe wrote:
>>
>>> +TEST_F(iommufd_ioas, reserved_overflow)
>>> +{
>>> +	struct iommu_test_cmd test_cmd = {
>>> +		.size = sizeof(test_cmd),
>>> +		.op = IOMMU_TEST_OP_ADD_RESERVED,
>>> +		.id = self->ioas_id,
>>> +		.add_reserved = { .start = 6,
>>> +				  .length = 0xffffffffffff8001 },
>>> +	};
>>> +	__u64 iova;
>>> +
>>> +	ASSERT_EQ(0,
>>> +		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
>>> +			&test_cmd));
>>> +	test_err_ioctl_ioas_map(ENOSPC, buffer, 0x5000, &iova);
>>
>> When:
>> PAGE_SIZE=SZ_64K = 0x10000
>> MOCK_PAGE_SIZE = PAGE_SIZE / 2 = 0x8000
>>
>> This likely fails the alignment test, returning -EINVAL instead:
>>
>> # iommufd.c:988:reserved_overflow:Expected 28 (28) == errno (22)
>> # reserved_overflow: Test failed
>> #          FAIL  iommufd_ioas.mock_domain_limit.reserved_overflow
>>
>> So, I think we'd have to pick a number aligned to MOCK_PAGE_SIZE?
>> e.g. changing to 0x18000 for example can pass.
> 
> I realized that we can't change the number as it won't reproduce
> on PAGE_SIZE=4K. So, perhaps it should just SKIP other page sizes
> than 4K.

Shouldn't it work to parametrise both numbers accordingly, e.g. (if my 
Friday-evening maths holds up) reserve "1UL - MOCK_PAGE_SIZE * 16" then 
map "MOCK_PAGE_SIZE * 10"?

Robin.

