Return-Path: <linux-kselftest+bounces-188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBF7ED8F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 02:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744EF1F22BB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 01:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92110F0;
	Thu, 16 Nov 2023 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGWHtMom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E2B98;
	Wed, 15 Nov 2023 17:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700098951; x=1731634951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8V9GxQGhmWnHBzLUfmWUpWRTkqOnn/65G7sZH4jO9eQ=;
  b=NGWHtMomKc5i9YycJyNQNsCjUjg+VkJZyUANLp0svvscVsOfFvvbonWM
   TwGTKN+9b0feVx9JWWahfntGE/UCgpMYwg1+cvqS/CiP/AhI3+yk3xvW0
   jQTCrJj3cyui1mlaiTHYPGWi3Tib1cNIzTFBFb0PE2lF0PfzFZRC0YYT/
   AoBJI8wwwppY+x0V4IZ4WoLkIoYX5v7a3XxlFjoIDFld8Xe5g7YBnFB+P
   vXwWueRlj8tfkaVxaoXZqzWd+NWChWc+Bxa5h5Yf6vfq4b46TTxvEPOk+
   i8k+ZxqnLqwTn1VYUWLITHEKid6YnfbrLSFxagr17q0cmLaIgF6sKhFib
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422084504"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="422084504"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="908957353"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="908957353"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:42:30 -0800
Received: from [10.93.24.3] (liujing-mobl1.ccr.corp.intel.com [10.93.24.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0E2F2580D77;
	Wed, 15 Nov 2023 17:42:25 -0800 (PST)
Message-ID: <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>
Date: Thu, 16 Nov 2023 09:42:23 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
 <ZVTObiybC1MYlSam@ziepe.ca>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
In-Reply-To: <ZVTObiybC1MYlSam@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/15/2023 9:58 PM, Jason Gunthorpe wrote:
> On Wed, Nov 15, 2023 at 01:17:06PM +0800, Liu, Jing2 wrote:
>
>> This is the right way to approach it,
>>
>>     I learned that there was discussion about using io_uring to get the
>>     page fault without
>>
>>     eventfd notification in [1], and I am new at io_uring and studying the
>>     man page of
>>
>>     liburing, but there're questions in my mind on how can QEMU get the
>>     coming page fault
>>
>>     with a good performance.
>>
>>     Since both QEMU and Kernel don't know when comes faults, after QEMU
>>     submits one
>>
>>     read task to io_uring, we want kernel pending until fault comes. While
>>     based on
>>
>>     hwpt_fault_fops_read() in [patch v2 4/6], it just returns 0 since
>>     there's now no fault,
>>
>>     thus this round of read completes to CQ but it's not what we want. So
>>     I'm wondering
>>
>>     how kernel pending on the read until fault comes. Does fops callback
>>     need special work to
> Implement a fops with poll support that triggers when a new event is
> pushed and everything will be fine.

Does userspace need also setup a POLL flag to let io_uring go into poll, 
or io_uring

always try to poll?

> There are many examples in the
> kernel. The ones in the mlx5 vfio driver spring to mind as a scheme I
> recently looked at.

Thank you very much for guiding the way. We will study the example to 
understand

more.

BRs,

Jing

> Jason

