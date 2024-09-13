Return-Path: <linux-kselftest+bounces-17906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC4D9776A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 03:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C83A1C24263
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 01:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498537441A;
	Fri, 13 Sep 2024 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SeSOHrhy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1766F2F9
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 01:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192580; cv=none; b=h6qs4X2ZVNPyWb7NvN7gwXZ9lG0BOzX2gMh3hfUhBgjMlsiLbqZdP/adByA+qsX0LG87qjzLeAWeeIyoBA3mctdr6QB6kOQMJNrbtBiPmwGI1JABmBkhpDsYJmuTC6bAd2+eYUqHpMqt1a1PRQtqETKOLB5L2iULnjIkoChuc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192580; c=relaxed/simple;
	bh=tSf1MQou0r6lgoHQyGlAZ2uB9RrvMtH+zzCK9JPkimA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gpTKZHFf3SHVH9SEcU6cweX8hDjo7KTS/MpC4o8b3TlnKT6SMohZQzxS7Qy0E2rDWsAwH/zqBJMFeUKgh9kyJ111H2A2ffeEGvskfEMoZPtblABX7ga/DeyiDGe5Y8I9UHoBeo3BqBTxJYJu5hqcGZb9lWHM+WzwandFionA6LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SeSOHrhy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726192579; x=1757728579;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tSf1MQou0r6lgoHQyGlAZ2uB9RrvMtH+zzCK9JPkimA=;
  b=SeSOHrhyLX6dCCYm693+guwgxo5MSsNPy89fhQ89IGZuH2okKDzaUZKN
   QFSRCX/DFH94ajfB6Qm7w2SakMuefF7xxspjHlTWKpkOAifdPphL0CTvJ
   zo8W71GddhGwc86YSt0ep8S8f5OQuZtxOzgAZUypnSwB6hpJy6UdfYtu8
   wsMLywT81+/jGfqatWsTgqFl1CdV5RNdoidRcwEarPxLXCYuEg2R1nTtp
   +e87cf2E/W0mfzDaoMB66PNSAJuOJMGJNpDKOLH6Ii73jia8b/S13snCn
   HWPoA28imRK2YsxQ1WDbQqfJ/rQhRBtLCYbUuf0PD4SrZx2pEIf9vjpi2
   g==;
X-CSE-ConnectionGUID: cjK0jnjeQamXchgC6XN6zw==
X-CSE-MsgGUID: WDbrNc1SQp+fplLYSZaeNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="50496032"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="50496032"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 18:56:18 -0700
X-CSE-ConnectionGUID: yfPn0s/fTsWcVWR0yCzzIg==
X-CSE-MsgGUID: hRft0uaPQU2ZY2uoWV1SPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="98593348"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 12 Sep 2024 18:56:15 -0700
Message-ID: <5df26703-012a-4c06-af59-0ccc193d250f@linux.intel.com>
Date: Fri, 13 Sep 2024 09:52:09 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, zhenzhong.duan@intel.com,
 linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-5-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240912130427.10119-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 9:04 PM, Yi Liu wrote:
> @@ -4299,7 +4304,12 @@ domain_prepare_dev_pasid(struct iommu_domain *domain,
>   	unsigned long flags;
>   	int ret;
>   
> -	ret = prepare_domain_attach_device(domain, dev);
> +	/* Nested type domain should prepare its parent domain */
> +	if (domain_type_is_nested(dmar_domain))
> +		ret = prepare_domain_attach_device(
> +				&dmar_domain->s2_domain->domain, dev);
> +	else
> +		ret = prepare_domain_attach_device(domain, dev);
>   	if (ret)
>   		return ERR_PTR(ret);
>   

'prepare' is a bit confusing in this context. It actually means checking
whether a domain is compatible with the hardware capabilities of RID or
PASID. Or not?

I know this confusion comes from the naming of
prepare_domain_attach_device(). Hence, do you mind renaming this helper
in a small patch?

Thanks,
baolu

