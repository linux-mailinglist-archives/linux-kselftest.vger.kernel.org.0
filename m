Return-Path: <linux-kselftest+bounces-35043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A363EADA808
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 08:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B034D3B0218
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 06:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A12F1DDC33;
	Mon, 16 Jun 2025 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRi174Av"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC58433AC;
	Mon, 16 Jun 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054392; cv=none; b=o4Y8BPkuWVa9QnA5MMnuqMHCTsJIMv0gtMGAd2Baj7T+k/y1h76Q2VtsWtPXhAAGoiEcMJEAOLcrMe25r6dd2L8VC+qWM4VWGZXXbIrbk49txtFwYJFNJyWxcrCcMFciVlsVog4nBB3l85ww+0tbm7oscY6/9NCQb1Hri9/Q3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054392; c=relaxed/simple;
	bh=iUtofJ2lBJJnR0k38D5Yh0JcJemRL1qcI7UtvYgj9UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+n7J38yyZZdoxNibFHeiGmEynfrkdu8gXqGDU3vWl5dEUchObSlInboKSeRfbBkqkIBc4vN+FcB5YRuStLLgiY3+Q34xKaqMCNw4vuhws3zINtr3ayEoBPKXRcAezw/C63Cb5jpW+ir7A/BXOAtMQkKNqkxj8J/X7VfunLp0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRi174Av; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750054391; x=1781590391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iUtofJ2lBJJnR0k38D5Yh0JcJemRL1qcI7UtvYgj9UM=;
  b=SRi174AvaoftgfxfRtFzfudM+D82kgn/S3ioPm8DFwpwq6YzanWNbeYM
   7P+MFULmGWJWEWAE1wguBaUaHoWqVyo69s7SfOxmBA/ZmEQD4Hkov+U7o
   aq6BvsdMExgxLEGMIEEpZncL4BNWVSrcCu7b1eVXOdi6VPDA5uZqhLlYG
   Illqlngz2mcPchd0llbYOoe10nE/WR8KXzHrvmxrTAWrUxth2xRQizhIf
   MhUe2K66+bKhTWZbhuGib+cV6Mjs8iCHInaCC9m6kFlcaYXLQq7Pqf9jd
   9/2PZPuwi/ZrzEqsF6ZrHRV8bDB5OIdcp8n2Mak7Qkaecm3AeYnfjF1kK
   w==;
X-CSE-ConnectionGUID: rdcN2kWSQcW+IfKLFio47A==
X-CSE-MsgGUID: niES7qcuR7mj/mEBY+oYBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52106665"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52106665"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:13:10 -0700
X-CSE-ConnectionGUID: sd2pUJD5S46jXmmHW640QQ==
X-CSE-MsgGUID: P6HgX+1BTxazlc+ar7+jBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="171591560"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:13:04 -0700
Message-ID: <1ab8030b-8d2f-4ebe-a280-6d0e4e1d17c7@linux.intel.com>
Date: Mon, 16 Jun 2025 14:12:04 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com, dwmw2@infradead.org
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/25 15:14, Nicolin Chen wrote:
> Introduce a new IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl for user space to allocate
> a HW QUEUE object for a vIOMMU specific HW-accelerated queue, e.g.:
>   - NVIDIA's Virtual Command Queue
>   - AMD vIOMMU's Command Buffer, Event Log Buffers, and PPR Log Buffers
> 
> Since this is introduced with NVIDIA's VCMDQs that access the guest memory
> in the physical address space, add an iommufd_hw_queue_alloc_phys() helper
> that will create an access object to the queue memory in the IOAS, to avoid
> the mappings of the guest memory from being unmapped, during the life cycle
> of the HW queue object.
> 
> Reviewed-by: Pranjal Shrivastava<praan@google.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/iommufd_private.h |   2 +
>   include/linux/iommufd.h                 |   1 +
>   include/uapi/linux/iommufd.h            |  33 +++++
>   drivers/iommu/iommufd/main.c            |   6 +
>   drivers/iommu/iommufd/viommu.c          | 184 ++++++++++++++++++++++++
>   5 files changed, 226 insertions(+)
> 

[...]

> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 28ea5d026222..506479ece826 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -201,3 +201,187 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	iommufd_put_object(ucmd->ictx, &viommu->obj);
>   	return rc;
>   }
> +
> +static void iommufd_hw_queue_destroy_access(struct iommufd_ctx *ictx,
> +					    struct iommufd_access *access,
> +					    u64 base_iova, size_t length)
> +{
> +	iommufd_access_unpin_pages(access, base_iova, length);
> +	iommufd_access_detach_internal(access);
> +	iommufd_access_destroy_internal(ictx, access);
> +}
> +
> +void iommufd_hw_queue_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_hw_queue *hw_queue =
> +		container_of(obj, struct iommufd_hw_queue, obj);
> +	struct iommufd_viommu *viommu = hw_queue->viommu;
> +
> +	if (hw_queue->destroy)
> +		hw_queue->destroy(hw_queue);
> +	if (hw_queue->access)
> +		iommufd_hw_queue_destroy_access(viommu->ictx, hw_queue->access,
> +						hw_queue->base_addr,
> +						hw_queue->length);
> +	refcount_dec(&viommu->obj.users);
> +}
> +
> +/*
> + * When the HW accesses the guest queue via physical addresses, the underlying
> + * physical pages of the guest queue must be contiguous. Also, for the security
> + * concern that IOMMUFD_CMD_IOAS_UNMAP could potentially remove the mappings of
> + * the guest queue from the nesting parent iopt while the HW is still accessing
> + * the guest queue memory physically, such a HW queue must require an access to
> + * pin the underlying pages and prevent that from happening.
> + */
> +static struct iommufd_access *
> +iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
> +			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
> +{
> +	struct iommufd_access *access;
> +	struct page **pages;
> +	int max_npages, i;
> +	u64 offset;
> +	int rc;
> +
> +	offset =
> +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> +	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
> +
> +	/*
> +	 * FIXME allocation may fail when sizeof(*pages) * max_npages is
> +	 * larger than PAGE_SIZE. This might need a new API returning a
> +	 * bio_vec or something more efficient.
> +	 */
> +	pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return ERR_PTR(-ENOMEM);
> +
> +	access = iommufd_access_create_internal(viommu->ictx);
> +	if (IS_ERR(access)) {
> +		rc = PTR_ERR(access);
> +		goto out_free;
> +	}
> +
> +	rc = iommufd_access_attach_internal(access, viommu->hwpt->ioas);
> +	if (rc)
> +		goto out_destroy;
> +
> +	rc = iommufd_access_pin_pages(access, cmd->nesting_parent_iova,
> +				      cmd->length, pages, 0);
> +	if (rc)
> +		goto out_detach;
> +
> +	/* Validate if the underlying physical pages are contiguous */
> +	for (i = 1; i < max_npages; i++) {
> +		if (page_to_pfn(pages[i]) == page_to_pfn(pages[i - 1]) + 1)
> +			continue;
> +		rc = -EFAULT;
> +		goto out_unpin;
> +	}
> +
> +	*base_pa = page_to_pfn(pages[0]) << PAGE_SHIFT;
> +	kfree(pages);
> +	return access;
> +
> +out_unpin:
> +	iommufd_access_unpin_pages(access, cmd->nesting_parent_iova,
> +				   cmd->length);
> +out_detach:
> +	iommufd_access_detach_internal(access);
> +out_destroy:
> +	iommufd_access_destroy_internal(viommu->ictx, access);
> +out_free:
> +	kfree(pages);
> +	return ERR_PTR(rc);
> +}
> +
> +int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hw_queue *hw_queue;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_access *access;
> +	size_t hw_queue_size;
> +	phys_addr_t base_pa;
> +	u64 last;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +	if (!cmd->length)
> +		return -EINVAL;
> +	if (check_add_overflow(cmd->nesting_parent_iova, cmd->length - 1,
> +			       &last))
> +		return -EOVERFLOW;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
> +	    !viommu->ops->hw_queue_init_phys) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	/*
> +	 * FIXME once ops->hw_queue_init is introduced, a WARN_ON_ONCE will be
> +	 * required, if hw_queue_init and hw_queue_init_phys both exist, since
> +	 * they should be mutually exclusive
> +	 */
> +
> +	hw_queue_size = viommu->ops->get_hw_queue_size(viommu, cmd->type);
> +	if (!hw_queue_size) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	/*
> +	 * It is a driver bug for providing a hw_queue_size smaller than the
> +	 * core HW queue structure size
> +	 */
> +	if (WARN_ON_ONCE(hw_queue_size < sizeof(*hw_queue))) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	/*
> +	 * FIXME once ops->hw_queue_init is introduced, this should check "if
> +	 * ops->hw_queue_init_phys". And "access" should be initialized to NULL.
> +	 */

I just don't follow here. Up until now, only viommu->ops->
hw_queue_init_phys has been added, which means the current code only
supports hardware queues that access guest memory using physical
addresses. The access object is not needed for the other type of
hardware queue that uses guest IOVA.

So, why not just abort here if ops->hw_queue_init_phys is not supported
by the IOMMU driver? Leave other logics to the patches that introduce
ops->hw_queue_init? I guess that would make this patch more readible.

> +	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
> +	if (IS_ERR(access)) {
> +		rc = PTR_ERR(access);
> +		goto out_put_viommu;
> +	}

Thanks,
baolu

