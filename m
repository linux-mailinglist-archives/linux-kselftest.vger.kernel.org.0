Return-Path: <linux-kselftest+bounces-2956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3E82D2F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 02:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3C51C20946
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D317415B3;
	Mon, 15 Jan 2024 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuDXEtqB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E315A8;
	Mon, 15 Jan 2024 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705282250; x=1736818250;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FYm/uYLEot1cwBUToB4S5iqxG0QfXYPebBZ4he6s0Dk=;
  b=AuDXEtqBsoux0NP7/3hZOMyNu+W2BshPASe36c4eRuE6HaX6muaNpBoh
   jzCoxOp2ItVjQSfFk7HT6aLKTu8LV+g5AGlD2kAQGkY9ZaLwH64XRhYTu
   4ZZ0UZw7KIwZTFH57oqqaXTbSYyIG3ZNRB7sOHzkzlTFTskwS+kpgwgWO
   TmDLgTXQnaCcN3XQ/yDtvml9QTEa9DhdveIoRumykUgQXHpvwfi01My0K
   r0JmL+hUozEeTk1MzohlB23AX4O7BuWfSW4920VtXxI381kQksGsuSmz5
   XijNkPCQWua7dd6Ewk5FRhfoW3yTOZRHW4PsOci0XkutkI0QcBeqOV0qA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="465890558"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="465890558"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 17:30:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="786936902"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="786936902"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jan 2024 17:30:45 -0800
Message-ID: <0e305e0e-ae8b-4a2c-9f69-a5f8ccfc5adf@linux.intel.com>
Date: Mon, 15 Jan 2024 09:25:24 +0800
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
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6@eucas1p1.samsung.com>
 <20240112215606.36sth724y6zcj43k@localhost>
 <293a5643-ef36-4a34-9b6b-0f5b47061c2e@linux.intel.com>
 <20240114171850.mwcoutrrjxn7ltlf@localhost>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240114171850.mwcoutrrjxn7ltlf@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/24 1:18 AM, Joel Granados wrote:
> On Sun, Jan 14, 2024 at 09:13:19PM +0800, Baolu Lu wrote:
>> On 2024/1/13 5:56, Joel Granados wrote:
>>> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
>>>> Hi folks,
>>>>
>>>> This series implements the functionality of delivering IO page faults to
>>>> user space through the IOMMUFD framework for nested translation. Nested
>>>> translation is a hardware feature that supports two-stage translation
>>>> tables for IOMMU. The second-stage translation table is managed by the
>>>> host VMM, while the first-stage translation table is owned by user
>>>> space. This allows user space to control the IOMMU mappings for its
>>>> devices.
>>>>
>>>> When an IO page fault occurs on the first-stage translation table, the
>>>> IOMMU hardware can deliver the page fault to user space through the
>>>> IOMMUFD framework. User space can then handle the page fault and respond
>>>> to the device top-down through the IOMMUFD. This allows user space to
>>>> implement its own IO page fault handling policies.
>>>>
>>>> User space indicates its capability of handling IO page faults by
>>>> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
>>>> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
>>>> for page fault delivery. On a successful return of HWPT allocation, the
>>>> user can retrieve and respond to page faults by reading and writing to
>>>> the file descriptor (FD) returned in out_fault_fd.
>>>>
>>>> The iommu selftest framework has been updated to test the IO page fault
>>>> delivery and response functionality.
>>>>
>>>> This series is based on the latest implementation of nested translation
>>>> under discussion [1] and the page fault handling framework refactoring in
>>>> the IOMMU core [2].
>>>>
>>>> The series and related patches are available on GitHub: [3]
>>>>
>>>> [1]https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@intel.com/
>>>> [2]https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@linux.intel.com/
>>>> [3]https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v2
>>> I was working with this branch that included Yi Liu's
>>> wip/iommufd_nesting branch. Now Yi Lui has updated his work in this post
>>> https://lore.kernel.org/all/20240102143834.146165-1-yi.l.liu@intel.com.
>>> Is there an updated version of the page fault work that is rebased on
>>> top of Liu's new version?
>> Yes. I am preparing the new version and will post it for discussion
>> after the merge window.
> Great to hear and thx for getting back to me.
> 
> I'll be on the look out for your post. Would it be possible for you to
> add me to the CC when you send it?

Sure.

Best regards,
baolu

