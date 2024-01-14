Return-Path: <linux-kselftest+bounces-2950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD6C82D0B9
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 14:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00208B215BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33088210D;
	Sun, 14 Jan 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UStKnDil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6223B9;
	Sun, 14 Jan 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705238006; x=1736774006;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H1A4/qffyCpAVBjkSooDaLmud7wmIzZtJsCV04rZkQE=;
  b=UStKnDilTLIvxyPoajOFx+Th129kBs4YYquNw0rn6Vr8ufWYuJaLc7lr
   AY0mBPF7NhIDJAfsPYHW4RJaK8yoG6Xgh2Pz/wJ+CnlClOL3gcrCnm8/v
   LWc3de5oXYpkZJDAj8Zq4Mmabnj7JBUuJYGJ+yy8cg1z5gFu6qEnAiNnr
   Kw8lDzk12TvPC3hLTkKecJYAkfanZ0O9h7bTT+zrvG1CvhkhY6xvpKt0y
   e9qNsjOn9KqH3Is2MNzwlhwb+gabOBBhZwH3TBDhm9Vw+/LVzx4V5zi6J
   MFsjGFTEtFd3X/JakHtRhSrLxmuoDxTPb5Zvqf/Wp5heyLNNQDFnNe7j2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="20936356"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="20936356"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 05:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="786838999"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="786838999"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.17]) ([10.254.215.17])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 05:13:22 -0800
Message-ID: <293a5643-ef36-4a34-9b6b-0f5b47061c2e@linux.intel.com>
Date: Sun, 14 Jan 2024 21:13:19 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
To: Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6@eucas1p1.samsung.com>
 <20240112215606.36sth724y6zcj43k@localhost>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240112215606.36sth724y6zcj43k@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/13 5:56, Joel Granados wrote:
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
>> Hi folks,
>>
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework for nested translation. Nested
>> translation is a hardware feature that supports two-stage translation
>> tables for IOMMU. The second-stage translation table is managed by the
>> host VMM, while the first-stage translation table is owned by user
>> space. This allows user space to control the IOMMU mappings for its
>> devices.
>>
>> When an IO page fault occurs on the first-stage translation table, the
>> IOMMU hardware can deliver the page fault to user space through the
>> IOMMUFD framework. User space can then handle the page fault and respond
>> to the device top-down through the IOMMUFD. This allows user space to
>> implement its own IO page fault handling policies.
>>
>> User space indicates its capability of handling IO page faults by
>> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
>> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
>> for page fault delivery. On a successful return of HWPT allocation, the
>> user can retrieve and respond to page faults by reading and writing to
>> the file descriptor (FD) returned in out_fault_fd.
>>
>> The iommu selftest framework has been updated to test the IO page fault
>> delivery and response functionality.
>>
>> This series is based on the latest implementation of nested translation
>> under discussion [1] and the page fault handling framework refactoring in
>> the IOMMU core [2].
>>
>> The series and related patches are available on GitHub: [3]
>>
>> [1]https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@intel.com/
>> [2]https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@linux.intel.com/
>> [3]https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v2
> I was working with this branch that included Yi Liu's
> wip/iommufd_nesting branch. Now Yi Lui has updated his work in this post
> https://lore.kernel.org/all/20240102143834.146165-1-yi.l.liu@intel.com.
> Is there an updated version of the page fault work that is rebased on
> top of Liu's new version?

Yes. I am preparing the new version and will post it for discussion
after the merge window.

Best regards,
baolu

