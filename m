Return-Path: <linux-kselftest+bounces-20433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF69ABB22
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 03:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9556A1C2237B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 01:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E622B9A9;
	Wed, 23 Oct 2024 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GT4qmZ7S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330AD2FA;
	Wed, 23 Oct 2024 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648126; cv=none; b=RF1DHSJ8xLUY0gT3FSN42c8ldUYxBg1/eB3EcJBXkWw6vQR7b38kltowo+Eg+dDA7snGrAVFhNbPCuFVPNS03rj4gfD97xR7XtQn/CZWfdc92mm3ovGjTzIdak1K+78vDxont1vzSepcnCkmuIlsyHOCqM/HC3EPtzSWo24MlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648126; c=relaxed/simple;
	bh=OPsf2f9vTyNmn26NM00dQj65lrjywxxlSAM0Y4JmhPE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=czJalUAqfkC2yx9g2BQ4WCRb4SUKoXHgnBgp/i20dINM6TaCU43mTGU+D6vwAH16M2CC/l3UmspkQwZaG+FvDGqpQYqvBnBAdfJ0yfkTjOWCVvhQzcDKaeXYVODb06uMJVy7tC78dUSfMCRiRE9zuLzxP4XfUBYH5CSLz3NRJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GT4qmZ7S; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729648124; x=1761184124;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OPsf2f9vTyNmn26NM00dQj65lrjywxxlSAM0Y4JmhPE=;
  b=GT4qmZ7SKrr1CMvIqSigH+kPrjAGjdXwZXVbjztckaBRhf4Z32a+Nwum
   XXSUMZyfV+/ufwU10xVxWVWvsHpByrodTi06s48j18x/7hIujyimsAZ2m
   ZLwk5wBxmzNo/G0FN9a3vRv5wUe24w8AseKdNqwb3JyOAULx8evdG/ZEL
   D+zCOd21iyqPPJbp6PJOTvalsaog6OylnMMM8bFBKVUtIhPXpEUvknNZ+
   qOb3MklZbsXPMeIMLTXGujzBFUoMqZ43M7AVmiRLcJ5JJWd/HA6URhIFx
   UFP+xHC88bMcQHKcofUKQjYLNppu3epBBgu3DGtc+IkhMsUb0tBk3LPn2
   A==;
X-CSE-ConnectionGUID: l2H1Bl95TbyHzFWcRO25PQ==
X-CSE-MsgGUID: 5t7s10VlS9KIYdRSIE0MrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="16838940"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="16838940"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:48:43 -0700
X-CSE-ConnectionGUID: ja4EwEbFS4SiZHofiWkthg==
X-CSE-MsgGUID: FrkOTik4RQeF2TiG3rO6mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80386440"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:48:38 -0700
Message-ID: <0db7401c-ca89-49a7-a9cc-502a581af66d@linux.intel.com>
Date: Wed, 23 Oct 2024 09:48:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Nicolin Chen <nicolinc@nvidia.com>,
 kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, aik@amd.com,
 zhangfei.gao@linaro.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
To: Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <74fec8c38a7d568bd88beba9082b4a5a4bc2046f.1729553811.git.nicolinc@nvidia.com>
 <b2c75705-2998-4e51-90f4-00b8bab785f5@linux.intel.com>
 <ZxcspVGPBmABjUPu@nvidia.com>
 <dd7eb37f-13c6-4c6e-8adc-954ad9974b93@linux.intel.com>
 <20241022131554.GF13034@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241022131554.GF13034@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 21:15, Jason Gunthorpe wrote:
> On Tue, Oct 22, 2024 at 04:59:07PM +0800, Baolu Lu wrote:
> 
>> Is it feasible to make vIOMMU object more generic, rather than strictly
>> tying it to nested translation? For example, a normal paging domain that
>> translates gPAs to hPAs could also have a vIOMMU object associated with
>> it.
>>
>> While we can only support vIOMMU object allocation uAPI for S2 paging
>> domains in the context of this series, we could consider leaving the
>> option open to associate a vIOMMU object with other normal paging
>> domains that are not a nested parent?
> Why? The nested parent flavour of the domain is basically free to
> create, what reason would be to not do that?

Above addressed my question. The software using vIOMMU should allocate a
domain of nested parent type.

> 
> If the HW doesn't support it, then does the HW really need/support a
> VIOMMU?
> 
> I suppose it could be made up to the driver, but for now I think we
> should leave it as is in the core code requiring it until we have a
> reason to relax it.

Yes. In such cases, the iommu driver could always allow nested parent
domain allocation, but fails to allocate a nested domain if the hardware
is not capable of nesting translation.

Thanks,
baolu

