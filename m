Return-Path: <linux-kselftest+bounces-17351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ABA96E8B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 06:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD891F24ED3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 04:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3846D4594A;
	Fri,  6 Sep 2024 04:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dESkhuwq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08F18B04;
	Fri,  6 Sep 2024 04:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725597462; cv=none; b=UzhvP+I4i4tCTDOz2HfwuAGqQ0GWgXIgU7DsUojYXxd3s2geWThOJAxA9ZOkCGKZQmxrZJBJBVFETzRgLxSWTUXItG5jF8d1allKBu517jHhHQIvQaKk86jEvPFufzmiBGRlY4y73lGcdD8YrZnlycpOciaMzAtUP3BnxO2oAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725597462; c=relaxed/simple;
	bh=/jvEvJRE/jLwZ1UTZPXHXIUGmiEbzhw4zt2ok3NX4b4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AoWeRrcEV4Elv3Ca0VlCVt9WUd+b+TtMH8x+pThPmf9mf5+wyZQUio/V7VyhH6bgxQ4Dlg170V1L916qkMOuUBs8pcDGzwmWzjFwurwcjh1aEzY590TtgWT4i3S7qops+M2CtiTSNbCiUnc84aFfEG5efHwYKsqPh0bssjA9KwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dESkhuwq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725597459; x=1757133459;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/jvEvJRE/jLwZ1UTZPXHXIUGmiEbzhw4zt2ok3NX4b4=;
  b=dESkhuwqXi3tbZes6l2VNZModHB+SQj72SAuIOSYZWObCzviLHVhh6va
   vSx4/47JH+F1t7V6BY0Fi65/fRevf1aeEW4sM0N+zdu/au48fOUmcimG0
   FiWVthHE+ks0Yc+Xw486vWEZBY1irilYVFExRJngr4C0FV1xVxgDJdrwU
   4bmfnO4ThRuYT+E1rYX2i6QRn6cGUB/r42Q0I9e7RCzd24OgnBx5TZi3W
   XN3hRhAtVYUMkW4EUBZRQwkJaVWrOQHZ2+TQ966EjYIxXVIp16jFnieMs
   11sy1Gzl/Z+RzTMUGfubXR6YtoVYe73Eq+jRLzyerc+D/STNuBwT8ldkb
   Q==;
X-CSE-ConnectionGUID: pNGKJ/8fTRaUz2QW8HZSpg==
X-CSE-MsgGUID: PuvjHS+ZSsGYwt56GlJ6nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="23851821"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="23851821"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 21:37:38 -0700
X-CSE-ConnectionGUID: wAEC3Ex0TdSAeSMujkgODg==
X-CSE-MsgGUID: ybrDQfa7QdaHju2NeDDhDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="89097928"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa002.fm.intel.com with ESMTP; 05 Sep 2024 21:37:34 -0700
Message-ID: <456e9b67-aa20-4259-b8e1-9f20d4fa03af@linux.intel.com>
Date: Fri, 6 Sep 2024 12:33:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] iommu: Introduce a replace API for device pasid
To: Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
 <20240628090557.50898-2-yi.l.liu@intel.com>
 <BN9PR11MB5276B4AF6321A083C3C2D2648CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1a825f1b-be9d-4de1-948a-be0cce3175be@intel.com>
 <20240816130202.GB2032816@nvidia.com>
 <7b8f09b1-5e0a-48d8-8585-27e4a69ef75d@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7b8f09b1-5e0a-48d8-8585-27e4a69ef75d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/24 12:21 PM, Yi Liu wrote:
> On 2024/8/16 21:02, Jason Gunthorpe wrote:
>> On Fri, Aug 16, 2024 at 05:43:18PM +0800, Yi Liu wrote:
>>> On 2024/7/18 16:27, Tian, Kevin wrote:
>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>> Sent: Friday, June 28, 2024 5:06 PM
>>>>>
>>>>> @@ -3289,7 +3290,20 @@ static int __iommu_set_group_pasid(struct
>>>>> iommu_domain *domain,
>>>>>
>>>>>            if (device == last_gdev)
>>>>>                break;
>>>>> -        ops->remove_dev_pasid(device->dev, pasid, domain);
>>>>> +        /* If no old domain, undo the succeeded devices/pasid */
>>>>> +        if (!old) {
>>>>> +            ops->remove_dev_pasid(device->dev, pasid, domain);
>>>>> +            continue;
>>>>> +        }
>>>>> +
>>>>> +        /*
>>>>> +         * Rollback the succeeded devices/pasid to the old domain.
>>>>> +         * And it is a driver bug to fail attaching with a previously
>>>>> +         * good domain.
>>>>> +         */
>>>>> +        if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
>>>>> +                            pasid, domain)))
>>>>> +            ops->remove_dev_pasid(device->dev, pasid, domain);
>>>>
>>>> I wonder whether @remove_dev_pasid() can be replaced by having
>>>> blocking_domain support @set_dev_pasid?
>>>
>>> how about your thought, @Jason?
>>
>> I think we talked about doing that once before, I forget why it was
>> not done. Maybe there was an issue?
>>
>> But it seems worth trying.
> 
> Since remove_dev_pasid() does not return a result, so caller does not
> need to check the result of it. If we want to replace it with the
> blocked_domain->ops->set_dev_pasid(), shall we enforce that the
> set_dev_pasid() op of blocked_domain to be always success. Is it?

Yes. The semantics of blocking domain is that the iommu driver must
ensure successful completion.

Thanks,
baolu

