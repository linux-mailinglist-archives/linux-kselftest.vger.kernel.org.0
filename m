Return-Path: <linux-kselftest+bounces-32053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C199AA57B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 23:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685361BA3AFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 21:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CEF221F18;
	Wed, 30 Apr 2025 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlga4bvH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59686219A93
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050369; cv=none; b=N905o9J28LJj3NV15AUqtYlLUec8wseD5CIOqrfk1OjAOCuPDg8zJVaThFA3gEljqV2UIpYLXXcO21pc9nttEOBp8pJlnipclOGJXI4WK6ne9RGKFooMDpEvMt+GRdRUitph36pbnYkyvMiK9+c05DgyZ3+yBENuewjiu9QYgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050369; c=relaxed/simple;
	bh=tO5TKeOk9pMSeyngdLH2VO19Jzb6plJzfCSMP/ye6zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKaEExBa6EPJ/85/1lAiIld3i73HiOsWyyhp1HlMEnCUcXjZ+tIBBsksTtnONqi00Wn1JAzhEQ5kkNFmhY8CNkP1SoG0Lu9dwPy4JiNi0/ZDXD/L/wwkDh/ew+78+R340EI51qGL7oslqpWIuiHOzPWfuazzlKTEQCjFHOpEoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlga4bvH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so22025ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746050365; x=1746655165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2L1JtxKV5xyZASMlAKF+FVRetR7mqhJ23bXGpwf3hA=;
        b=jlga4bvHysh1x9sR8ZRMYShXrlKykf5eFBRaEL58KHY+oEcbyNlts6Xh2MPvnKZnLf
         B9oDxgpcospbsFXwVmcNMl4y47MrqL2MTngYjdONPUvhuO7La7pqZiAOJWkWWLJtuPUT
         ZqfmMtDSwj8lJUhm04guifqf9S68qoOaUHKgAVTfLUEKHLbxf6cnoqiIwCoB2EPSe+xR
         T8fQaPeoFv9x+ORzd7yGmB2Va0qGt8GJPjqlHNVW1yUt60kDkh7vZc7WHqO7uQNyOwfQ
         sDkBcJBUzwXU9RYPuT7iocBJ3CTzudAaVNa79F3zfHTb6cvKzek39RvrAtb8J35GBAFg
         GcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746050365; x=1746655165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2L1JtxKV5xyZASMlAKF+FVRetR7mqhJ23bXGpwf3hA=;
        b=gdJkk64cO0P5ve+VsaQQAeqI9/QiO9OGk3yrh8IL9xC1lg4z5Nguum+hxRTyvKXmkK
         BhfHFiuMbEqPOT8zZBkbLT2LEeShTnDYFWTjnaQNWKynzpkf+sOQA4ANKdghlzazjaqf
         aWy56pz3RMqaxtrLXe3fbtazB6HBD4gB8pD9RuBvDMJBvYOVOWkD7h8HzjuLBw5ravMA
         irv28bgRnBVXj2GaZenfgxPzzozdR6KEszqpFvqGA8XY7JbYTIYbShPTHUDrJ3ugQb70
         6fMROqhv8qZUtuM1nL8uhiDmBDX9X2ftVS/H911LGxqAkIUzDtBHYzVeyFSFi3W6SdF1
         K4vg==
X-Forwarded-Encrypted: i=1; AJvYcCU59aVZXu/cJxDY2ghLHuLCLn0YLW5l5XBow5mGIGdT/526ZIFpbmdaCznGdKs1g8/ykXGO8LklMG0qF8NT6Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpYFT+eYC6AdflDWx10NkBVcMgqyj+QSZf4v/iJ+Pq4F9II9+
	GtWlxnKyn/uHoidZfE5g1UW180N21NEG96MIpPPNVdZog9AmMKLkp/Gsnp7Ydw==
X-Gm-Gg: ASbGnctCuVQ2t+0J+YcWsgnylO+/0BsgxL0bp9ykzbej5oH44c6VzT/BE/PJHugEY+B
	xlUD6IOxcI4enZZKd8nLbd/ddMFkz/zfMjjDVu892p0aC8FkiKsYJvskHQawukFP8a9gK2gBITR
	4e/qvQvSabC8o6Y2p3bpRjVIYdor0bmzeTTdXrehCR/r/jBLSFLwYdDapFvbxkeX5c7phtDSJsM
	FMnw3TJC82L6WTQPt2+5wARTaJUU5Nar9VzhuupQycbvF30o0zQY9AQsxYsXb78hq35f1yUEc3v
	asMnMJrjem17wnI/vXYUhoTrGk2IRg1MAo2aVRZ5/yusiFjJHsycX6ribfgNUZxF8pvMYZ+e
X-Google-Smtp-Source: AGHT+IEIS7iOGZQKq+NLnBgh3Z77rP4uHEJ0msSqnsLfKUumDUWg5G2IGbS0g0aYdbr36LRET7yUwA==
X-Received: by 2002:a17:903:1acf:b0:216:27f5:9dd7 with SMTP id d9443c01a7336-22e0797c820mr384205ad.11.1746050364997;
        Wed, 30 Apr 2025 14:59:24 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c13sm127809385ad.162.2025.04.30.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:59:24 -0700 (PDT)
Date: Wed, 30 Apr 2025 21:59:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 21/22] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aBKdMaFLPFJYegIS@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:16PM -0700, Nicolin Chen wrote:
> The CMDQV HW supports a user-space use for virtualization cases. It allows
> the VM to issue guest-level TLBI or ATC_INV commands directly to the queue
> and executes them without a VMEXIT, as HW will replace the VMID field in a
> TLBI command and the SID field in an ATC_INV command with the preset VMID
> and SID.
> 
> This is built upon the vIOMMU infrastructure by allowing VMM to allocate a
> VINTF (as a vIOMMU object) and assign VCMDQs (vCMDQ objects) to the VINTF.
> 
> So firstly, replace the standard vSMMU model with the VINTF implementation
> but reuse the standard cache_invalidate op (for unsupported commands) and
> the standard alloc_domain_nested op (for standard nested STE).
> 
> Each VINTF has two 64KB MMIO pages (128B per logical vCMDQ):
>  - Page0 (directly accessed by guest) has all the control and status bits.
>  - Page1 (trapped by VMM) has guest-owned queue memory location/size info.
> 
> VMM should trap the emulated VINTF0's page1 of the guest VM for the guest-
> level VCMDQ location/size info and forward that to the kernel to translate
> to a physical memory location to program the VCMDQ HW during an allocation
> call. Then, it should mmap the assigned VINTF's page0 to the VINTF0 page0
> of the guest VM. This allows the guest OS to read and write the guest-own
> VINTF's page0 for direct control of the VCMDQ HW.
> 
> For ATC invalidation commands that hold an SID, it requires all devices to
> register their virtual SIDs to the SID_MATCH registers and their physical
> SIDs to the pairing SID_REPLACE registers, so that HW can use those as a
> lookup table to replace those virtual SIDs with the correct physical SIDs.
> Thus, implement the driver-allocated vDEVICE op with a tegra241_vintf_sid
> structure to allocate SID_REPLACE and to program the SIDs accordingly.
> 
> This enables the HW accelerated feature for NVIDIA Grace CPU. Compared to
> the standard SMMUv3 operating in the nested translation mode trapping CMDQ
> for TLBI and ATC_INV commands, this gives a huge performance improvement:
> 70% to 90% reductions of invalidation time were measured by various DMA
> unmap tests running in a guest OS.
> 

The write-up is super helpful to understand how the HW works from a high
level. Thanks for explaining this well! :) 

I'm curious to know the DMA unmap tests that were run for perf?

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  15 +
>  include/uapi/linux/iommufd.h                  |  49 ++-
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   6 +-
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 374 +++++++++++++++++-
>  4 files changed, 435 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index bab7a9ce1283..d3f18a286447 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1000,6 +1000,14 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
>  				bool sync);
>  
> +static inline phys_addr_t
> +arm_smmu_domain_ipa_to_pa(struct arm_smmu_domain *smmu_domain, u64 ipa)
> +{
> +	if (WARN_ON_ONCE(smmu_domain->stage != ARM_SMMU_DOMAIN_S2))
> +		return 0;
> +	return iommu_iova_to_phys(&smmu_domain->domain, ipa);
> +}
> +
>  #ifdef CONFIG_ARM_SMMU_V3_SVA
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
>  bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
> @@ -1076,9 +1084,16 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
>  void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
>  int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
> +struct iommu_domain *
> +arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
> +			      const struct iommu_user_data *user_data);
> +int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
> +			       struct iommu_user_data_array *array);
>  #else
>  #define arm_smmu_hw_info NULL
>  #define arm_vsmmu_alloc NULL
> +#define arm_vsmmu_alloc_domain_nested NULL
> +#define arm_vsmmu_cache_invalidate NULL
>  
>  static inline int
>  arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index b2614f0f1547..d69e7c1d39ea 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -549,12 +549,25 @@ struct iommu_hw_info_vtd {
>  	__aligned_u64 ecap_reg;
>  };
>  
> +/**
> + * enum iommu_hw_info_arm_smmuv3_flags - Flags for ARM SMMUv3 hw_info
> + * @IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV: Tegra241 implementation with
> + *                                               CMDQV support; @impl is valid
> + */
> +enum iommu_hw_info_arm_smmuv3_flags {
> +	IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV = 1 << 0,
> +};
> +
>  /**
>   * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware information
>   *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
>   *
> - * @flags: Must be set to 0
> - * @impl: Must be 0
> + * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
> + * @impl: Implementation-defined bits when the following flags are set:
> + *        - IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV
> + *          Bits[15:12] - Log2 of the total number of SID replacements
> + *          Bits[07:04] - Log2 of the total number of vCMDQs per vIOMMU
> + *          Bits[03:00] - Version number for the CMDQ-V HW

Nit: It seems that we deliberately chose not to reveal `NUM_VINTF_LOG2`
to the user-space. If so, maybe we shall mark those bitfields as unused
or reserved for clarity? Bits[11:08] - Reserved / Unused (even 31:16).

>   * @idr: Implemented features for ARM SMMU Non-secure programming interface
>   * @iidr: Information about the implementation and implementer of ARM SMMU,
>   *        and architecture version supported
> @@ -952,10 +965,28 @@ struct iommu_fault_alloc {
>   * enum iommu_viommu_type - Virtual IOMMU Type
>   * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
>   * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
> + * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
>   */
>  enum iommu_viommu_type {
>  	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
>  	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
> +	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
> +};

This is a little confusing.. I understand that we need a new viommu type
to copy the new struct iommu_viommu_tegra241_cmdqv b/w the user & kernel

But, in a previous patch (Add vsmmu_alloc impl op), we add a check to
fallback to the standard type SMMUv3, if the impl_ops->vsmmu_alloc 
returns -EOPNOTSUPP:

	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
			master->smmu, s2_parent, ictx, viommu_type, user_data);
	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
		if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
			return ERR_PTR(-EOPNOTSUPP);
		/* Fallback to standard SMMUv3 type if viommu_type matches */
		vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
					     &arm_vsmmu_ops);

Now, if we'll ALWAYS try to allocate an impl-specified vsmmu first, even
when the viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we are anyways
going to return back from the impl_ops->vsmmu_alloc with -EOPNOTSUPP.
Then we'll again check if the retval was -EOPNOTSUPP and re-check the
viommu_type requested.. which seems a little counter intuitive.

Instead, I'd suggest to simply call the impl_ops->vsmmu_alloc if the
viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3, in case the type isn't
supported, the impl_op->vsmmu_alloc would return with error anyway.

Thus, the snippet from arm_vsmmu_alloc could look like:

	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3) {
		if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
			vsmmu = master->smmu->impl_ops->vsmmu_alloc(
				master->smmu, s2_parent, ictx, viommu_type, user_data);
			if (IS_ERR(vsmmu))
				return return ERR_CAST(vsmmu);
	} else {
		/* Fallback to standard SMMUv3 type */
		vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
					     &arm_vsmmu_ops);
	}

> +
> +/**
> + * struct iommu_viommu_tegra241_cmdqv - NVIDIA Tegra241 CMDQV Virtual Interface
> + *                                      (IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
> + * @out_vintf_page0_pgoff: Offset of the VINTF page0 for mmap syscall
> + * @out_vintf_page0_pgsz: Size of the VINTF page0 for mmap syscall
> + *
> + * Both @out_vintf_page0_pgoff and @out_vintf_page0_pgsz are given by the kernel
> + * for user space to mmap the VINTF page0 from the host physical address space
> + * to the guest physical address space so that a guest kernel can directly R/W
> + * access to the VINTF page0 in order to control its virtual comamnd queues.
> + */
> +struct iommu_viommu_tegra241_cmdqv {
> +	__aligned_u64 out_vintf_page0_pgoff;
> +	__aligned_u64 out_vintf_page0_pgsz;
>  };
>  
>  /**
> @@ -1152,9 +1183,23 @@ struct iommu_veventq_alloc {
>  /**
>   * enum iommu_vcmdq_type - Virtual Command Queue Type
>   * @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use
> + * @IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
>   */
>  enum iommu_vcmdq_type {
>  	IOMMU_VCMDQ_TYPE_DEFAULT = 0,
> +	/*
> +	 * TEGRA241_CMDQV requirements (otherwise it will fail)
> +	 * - alloc starts from the lowest @index=0 in ascending order
> +	 * - destroy starts from the last allocated @index in descending order
> +	 * - @addr must be aligned to @length in bytes and be mmapped in IOAS
> +	 * - @length must be a power of 2, with a minimum 32 bytes and a maximum
> +	 *   1 ^ idr[1].CMDQS x 16 bytes (do GET_HW_INFO call to read idr[1] in
> +	 *   struct iommu_hw_info_arm_smmuv3)
> +	 * - suggest to back the queue memory with contiguous physical pages or
> +	 *   a single huge page with alignment of the queue size, limit vSMMU's
> +	 *   IDR1.CMDQS to the huge page size divided by 16 bytes
> +	 */
> +	IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV = 1,
>  };
>  
>  /**
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 63861c60b615..40246cd04656 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -226,7 +226,7 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg,
>  	return 0;
>  }
>  
> -static struct iommu_domain *
> +struct iommu_domain *
>  arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  			      const struct iommu_user_data *user_data)
>  {
> @@ -337,8 +337,8 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
>  	return 0;
>  }
>  
> -static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
> -				      struct iommu_user_data_array *array)
> +int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
> +			       struct iommu_user_data_array *array)
>  {
>  	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
>  	struct arm_smmu_device *smmu = vsmmu->smmu;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 869c90b660c1..88e2b6506b3a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -8,7 +8,9 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/iommu.h>
> +#include <linux/iommufd.h>
>  #include <linux/iopoll.h>
> +#include <uapi/linux/iommufd.h>
>  
>  #include <acpi/acpixf.h>
>  
> @@ -26,8 +28,10 @@
>  #define  CMDQV_EN			BIT(0)
>  
>  #define TEGRA241_CMDQV_PARAM		0x0004
> +#define  CMDQV_NUM_SID_PER_VM_LOG2	GENMASK(15, 12)
>  #define  CMDQV_NUM_VINTF_LOG2		GENMASK(11, 8)
>  #define  CMDQV_NUM_VCMDQ_LOG2		GENMASK(7, 4)
> +#define  CMDQV_VER			GENMASK(3, 0)
>  
>  #define TEGRA241_CMDQV_STATUS		0x0008
>  #define  CMDQV_ENABLED			BIT(0)
> @@ -53,6 +57,9 @@
>  #define  VINTF_STATUS			GENMASK(3, 1)
>  #define  VINTF_ENABLED			BIT(0)
>  
> +#define TEGRA241_VINTF_SID_MATCH(s)	(0x0040 + 0x4*(s))
> +#define TEGRA241_VINTF_SID_REPLACE(s)	(0x0080 + 0x4*(s))
> +
>  #define TEGRA241_VINTF_LVCMDQ_ERR_MAP_64(m) \
>  					(0x00C0 + 0x8*(m))
>  #define  LVCMDQ_ERR_MAP_NUM_64		2
> @@ -114,16 +121,20 @@ MODULE_PARM_DESC(bypass_vcmdq,
>  
>  /**
>   * struct tegra241_vcmdq - Virtual Command Queue
> + * @core: Embedded iommufd_vcmdq structure
>   * @idx: Global index in the CMDQV
>   * @lidx: Local index in the VINTF
>   * @enabled: Enable status
>   * @cmdqv: Parent CMDQV pointer
>   * @vintf: Parent VINTF pointer
> + * @prev: Previous LVCMDQ to depend on
>   * @cmdq: Command Queue struct
>   * @page0: MMIO Page0 base address
>   * @page1: MMIO Page1 base address
>   */
>  struct tegra241_vcmdq {
> +	struct iommufd_vcmdq core;
> +
>  	u16 idx;
>  	u16 lidx;
>  
> @@ -131,22 +142,29 @@ struct tegra241_vcmdq {
>  
>  	struct tegra241_cmdqv *cmdqv;
>  	struct tegra241_vintf *vintf;
> +	struct tegra241_vcmdq *prev;
>  	struct arm_smmu_cmdq cmdq;
>  
>  	void __iomem *page0;
>  	void __iomem *page1;
>  };
> +#define core_to_vcmdq(v) container_of(v, struct tegra241_vcmdq, core)
>  
>  /**
>   * struct tegra241_vintf - Virtual Interface
> + * @vsmmu: Embedded arm_vsmmu structure
>   * @idx: Global index in the CMDQV
>   * @enabled: Enable status
>   * @hyp_own: Owned by hypervisor (in-kernel)
>   * @cmdqv: Parent CMDQV pointer
>   * @lvcmdqs: List of logical VCMDQ pointers
>   * @base: MMIO base address
> + * @immap_id: Allocated immap_id ID for mmap() call
> + * @sids: Stream ID replacement resources
>   */
>  struct tegra241_vintf {
> +	struct arm_vsmmu vsmmu;
> +
>  	u16 idx;
>  
>  	bool enabled;
> @@ -156,6 +174,24 @@ struct tegra241_vintf {
>  	struct tegra241_vcmdq **lvcmdqs;
>  
>  	void __iomem *base;
> +	unsigned long immap_id;
> +
> +	struct ida sids;
> +};
> +#define viommu_to_vintf(v) container_of(v, struct tegra241_vintf, vsmmu.core)
> +
> +/**
> + * struct tegra241_vintf_sid - Virtual Interface Stream ID Replacement
> + * @core: Embedded iommufd_vdevice structure, holding virtual Stream ID
> + * @vintf: Parent VINTF pointer
> + * @sid: Physical Stream ID
> + * @id: Slot index in the VINTF
> + */
> +struct tegra241_vintf_sid {
> +	struct iommufd_vdevice core;
> +	struct tegra241_vintf *vintf;
> +	u32 sid;
> +	u8 idx;
>  };
>  
>  /**
> @@ -163,10 +199,12 @@ struct tegra241_vintf {
>   * @smmu: SMMUv3 device
>   * @dev: CMDQV device
>   * @base: MMIO base address
> + * @base_phys: MMIO physical base address, for mmap
>   * @irq: IRQ number
>   * @num_vintfs: Total number of VINTFs
>   * @num_vcmdqs: Total number of VCMDQs
>   * @num_lvcmdqs_per_vintf: Number of logical VCMDQs per VINTF
> + * @num_sids_per_vintf: Total number of SID replacements per VINTF
>   * @vintf_ids: VINTF id allocator
>   * @vintfs: List of VINTFs
>   */
> @@ -175,12 +213,14 @@ struct tegra241_cmdqv {
>  	struct device *dev;
>  
>  	void __iomem *base;
> +	phys_addr_t base_phys;
>  	int irq;
>  
>  	/* CMDQV Hardware Params */
>  	u16 num_vintfs;
>  	u16 num_vcmdqs;
>  	u16 num_lvcmdqs_per_vintf;
> +	u16 num_sids_per_vintf;
>  
>  	struct ida vintf_ids;
>  
> @@ -380,6 +420,12 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
>  	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
>  }
>  
> +/* This function is for LVCMDQ, so @vcmdq must be mapped prior */
> +static void _tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
> +{
> +	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
> +}
> +
>  /* This function is for LVCMDQ, so @vcmdq must be mapped prior */
>  static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
>  {
> @@ -390,7 +436,7 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
>  	tegra241_vcmdq_hw_deinit(vcmdq);
>  
>  	/* Configure and enable VCMDQ */
> -	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
> +	_tegra241_vcmdq_hw_init(vcmdq);
>  
>  	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
>  	if (ret) {
> @@ -420,6 +466,7 @@ static void tegra241_vcmdq_unmap_lvcmdq(struct tegra241_vcmdq *vcmdq)
>  static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
>  {
>  	u16 lidx = vintf->cmdqv->num_lvcmdqs_per_vintf;
> +	int sidx;
>  
>  	/* HW requires to unmap LVCMDQs in descending order */
>  	while (lidx--) {
> @@ -429,6 +476,10 @@ static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
>  		}
>  	}
>  	vintf_write_config(vintf, 0);
> +	for (sidx = 0; sidx < vintf->cmdqv->num_sids_per_vintf; sidx++) {
> +		writel_relaxed(0, REG_VINTF(vintf, SID_REPLACE(sidx)));
> +		writel_relaxed(0, REG_VINTF(vintf, SID_MATCH(sidx)));
> +	}
>  }
>  
>  /* Map a global VCMDQ to the pre-assigned LVCMDQ */
> @@ -457,7 +508,8 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
>  	 * whether enabling it here or not, as !HYP_OWN cmdq HWs only support a
>  	 * restricted set of supported commands.
>  	 */
> -	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own);
> +	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own) |
> +		 FIELD_PREP(VINTF_VMID, vintf->vsmmu.vmid);
>  	writel(regval, REG_VINTF(vintf, CONFIG));
>  
>  	ret = vintf_write_config(vintf, regval | VINTF_EN);
> @@ -584,7 +636,9 @@ static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
>  
>  	dev_dbg(vintf->cmdqv->dev,
>  		"%sdeallocated\n", lvcmdq_error_header(vcmdq, header, 64));
> -	kfree(vcmdq);
> +	/* Guest-owned VCMDQ is free-ed with vcmdq by iommufd core */
> +	if (vcmdq->vintf->hyp_own)
> +		kfree(vcmdq);
>  }
>  
>  static struct tegra241_vcmdq *
> @@ -623,6 +677,9 @@ tegra241_vintf_alloc_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
>  
>  static void tegra241_cmdqv_deinit_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
>  {
> +	if (cmdqv->vintfs[idx]->immap_id)
> +		iommufd_ctx_free_mmap(cmdqv->vintfs[idx]->vsmmu.core.ictx,
> +				      cmdqv->vintfs[idx]->immap_id);
>  	kfree(cmdqv->vintfs[idx]->lvcmdqs);
>  	ida_free(&cmdqv->vintf_ids, idx);
>  	cmdqv->vintfs[idx] = NULL;
> @@ -671,7 +728,11 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
>  
>  	dev_dbg(cmdqv->dev, "VINTF%u: deallocated\n", vintf->idx);
>  	tegra241_cmdqv_deinit_vintf(cmdqv, idx);
> -	kfree(vintf);
> +	if (!vintf->hyp_own)
> +		ida_destroy(&vintf->sids);
> +	/* Guest-owned VINTF is free-ed with viommu by iommufd core */
> +	if (vintf->hyp_own)
> +		kfree(vintf);
>  }
>  
>  static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
> @@ -699,10 +760,32 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
>  	put_device(cmdqv->dev); /* smmu->impl_dev */
>  }
>  
> +static struct arm_vsmmu *
> +tegra241_cmdqv_vsmmu_alloc(struct arm_smmu_device *smmu,
> +			   struct arm_smmu_domain *smmu_domain,
> +			   struct iommufd_ctx *ictx, unsigned int viommu_type,
> +			   const struct iommu_user_data *user_data);
> +
> +static u32 tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu, u32 *impl)
> +{
> +	struct tegra241_cmdqv *cmdqv =
> +		container_of(smmu, struct tegra241_cmdqv, smmu);
> +	u32 regval = readl_relaxed(REG_CMDQV(cmdqv, PARAM));
> +
> +	*impl = FIELD_GET(CMDQV_VER, regval);
> +	*impl |= FIELD_PREP(CMDQV_NUM_VCMDQ_LOG2,
> +			    ilog2(cmdqv->num_lvcmdqs_per_vintf));
> +	*impl |= FIELD_PREP(CMDQV_NUM_SID_PER_VM_LOG2,
> +			   ilog2(cmdqv->num_sids_per_vintf));
> +	return IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV;
> +}
> +
>  static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
>  	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
>  	.device_reset = tegra241_cmdqv_hw_reset,
>  	.device_remove = tegra241_cmdqv_remove,
> +	.vsmmu_alloc = tegra241_cmdqv_vsmmu_alloc,
> +	.hw_info = tegra241_cmdqv_hw_info,
>  };
>  
>  /* Probe Functions */
> @@ -844,6 +927,7 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
>  	cmdqv->irq = irq;
>  	cmdqv->base = base;
>  	cmdqv->dev = smmu->impl_dev;
> +	cmdqv->base_phys = res->start;
>  
>  	if (cmdqv->irq > 0) {
>  		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
> @@ -860,6 +944,8 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
>  	cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
>  	cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
>  	cmdqv->num_lvcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;
> +	cmdqv->num_sids_per_vintf =
> +		1 << FIELD_GET(CMDQV_NUM_SID_PER_VM_LOG2, regval);
>  
>  	cmdqv->vintfs =
>  		kcalloc(cmdqv->num_vintfs, sizeof(*cmdqv->vintfs), GFP_KERNEL);
> @@ -913,3 +999,283 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
>  	put_device(smmu->impl_dev);
>  	return ERR_PTR(-ENODEV);
>  }
> +
> +/* User-space vIOMMU and vCMDQ Functions */
> +
> +static int tegra241_vcmdq_hw_init_user(struct tegra241_vcmdq *vcmdq)
> +{
> +	char header[64];
> +
> +	/* Configure the vcmdq only; User space does the enabling */
> +	_tegra241_vcmdq_hw_init(vcmdq);
> +
> +	dev_dbg(vcmdq->cmdqv->dev, "%sinited at host PA 0x%llx size 0x%lx\n",
> +		lvcmdq_error_header(vcmdq, header, 64),
> +		vcmdq->cmdq.q.q_base & VCMDQ_ADDR,
> +		1UL << (vcmdq->cmdq.q.q_base & VCMDQ_LOG2SIZE));
> +	return 0;
> +}
> +
> +static struct iommufd_vcmdq *
> +tegra241_vintf_alloc_lvcmdq_user(struct iommufd_viommu *viommu,
> +				 unsigned int type, u32 index, dma_addr_t addr,
> +				 size_t length)
> +{
> +	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
> +	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
> +	struct arm_smmu_device *smmu = &cmdqv->smmu;
> +	struct tegra241_vcmdq *vcmdq, *prev = NULL;
> +	u32 log2size, max_n_shift;
> +	phys_addr_t q_base;
> +	char header[64];
> +	int ret;
> +
> +	if (type != IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV)
> +		return ERR_PTR(-EOPNOTSUPP);
> +	if (index >= cmdqv->num_lvcmdqs_per_vintf)
> +		return ERR_PTR(-EINVAL);
> +	if (vintf->lvcmdqs[index])
> +		return ERR_PTR(-EEXIST);
> +	/*
> +	 * HW requires to map LVCMDQs in ascending order, so reject if the
> +	 * previous lvcmdqs is not allocated yet.
> +	 */
> +	if (index) {
> +		prev = vintf->lvcmdqs[index - 1];
> +		if (!prev)
> +			return ERR_PTR(-EIO);
> +	}
> +	/*
> +	 * @length must be a power of 2, in range of
> +	 *   [ 32, 1 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) ]
> +	 */

Nit: 2 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) to match the comment in uapi

> +	max_n_shift = FIELD_GET(IDR1_CMDQS,
> +				readl_relaxed(smmu->base + ARM_SMMU_IDR1));
> +	if (!is_power_of_2(length) || length < 32 ||
> +	    length > (1 << (max_n_shift + CMDQ_ENT_SZ_SHIFT)))
> +		return ERR_PTR(-EINVAL);
> +	log2size = ilog2(length) - CMDQ_ENT_SZ_SHIFT;
> +
> +	/* @addr must be aligned to @length and be mapped in s2_parent domain */
> +	if (addr & ~VCMDQ_ADDR || addr & (length - 1))
> +		return ERR_PTR(-EINVAL);
> +	q_base = arm_smmu_domain_ipa_to_pa(vintf->vsmmu.s2_parent, addr);
> +	if (!q_base)
> +		return ERR_PTR(-ENXIO);
> +
> +	vcmdq = iommufd_vcmdq_alloc(viommu, struct tegra241_vcmdq, core);
> +	if (!vcmdq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * HW requires to unmap LVCMDQs in descending order, so destroy() must
> +	 * follow this rule. Set a dependency on its previous LVCMDQ so iommufd
> +	 * core will help enforce it.
> +	 */
> +	if (prev) {
> +		ret = iommufd_vcmdq_depend(vcmdq, prev, core);
> +		if (ret)
> +			goto free_vcmdq;
> +	}
> +	vcmdq->prev = prev;
> +
> +	ret = tegra241_vintf_init_lvcmdq(vintf, index, vcmdq);
> +	if (ret)
> +		goto free_vcmdq;
> +
> +	dev_dbg(cmdqv->dev, "%sallocated\n",
> +		lvcmdq_error_header(vcmdq, header, 64));
> +
> +	tegra241_vcmdq_map_lvcmdq(vcmdq);
> +
> +	vcmdq->cmdq.q.q_base = q_base & VCMDQ_ADDR;
> +	vcmdq->cmdq.q.q_base |= log2size;
> +
> +	ret = tegra241_vcmdq_hw_init_user(vcmdq);
> +	if (ret)
> +		goto free_vcmdq;
> +	vintf->lvcmdqs[index] = vcmdq;
> +
> +	return &vcmdq->core;
> +free_vcmdq:
> +	iommufd_struct_destroy(viommu->ictx, vcmdq, core);
> +	return ERR_PTR(ret);

Are we missing an undepend here?

     if (vcmdq->prev)
     	iommufd_vcmdq_undepend(vcmdq, vcmdq->prev, core);

> +}
> +
> +static void tegra241_vintf_destroy_lvcmdq_user(struct iommufd_vcmdq *core)
> +{
> +	struct tegra241_vcmdq *vcmdq = core_to_vcmdq(core);
> +
> +	tegra241_vcmdq_hw_deinit(vcmdq);
> +	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
> +	tegra241_vintf_free_lvcmdq(vcmdq->vintf, vcmdq->lidx);
> +	if (vcmdq->prev)
> +		iommufd_vcmdq_undepend(vcmdq, vcmdq->prev, core);
> +
> +	/* IOMMUFD core frees the memory of vcmdq and vcmdq */
> +}
> +
> +static void tegra241_cmdqv_destroy_vintf_user(struct iommufd_viommu *viommu)
> +{
> +	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
> +
> +	tegra241_cmdqv_remove_vintf(vintf->cmdqv, vintf->idx);
> +
> +	/* IOMMUFD core frees the memory of vintf and viommu */
> +}
> +
> +static struct iommufd_vdevice *
> +tegra241_vintf_alloc_vdevice(struct iommufd_viommu *viommu, struct device *dev,
> +			     u64 dev_id)
> +{
> +	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_stream *stream = &master->streams[0];
> +	struct tegra241_vintf_sid *vsid;
> +	int sidx;
> +
> +	if (dev_id > UINT_MAX)
> +		return ERR_PTR(-EINVAL);
> +
> +	vsid = iommufd_vdevice_alloc(viommu, struct tegra241_vintf_sid, core);
> +	if (!vsid)
> +		return ERR_PTR(-ENOMEM);
> +
> +	WARN_ON_ONCE(master->num_streams != 1);
> +
> +	/* Find an empty pair of SID_REPLACE and SID_MATCH */
> +	sidx = ida_alloc_max(&vintf->sids, vintf->cmdqv->num_sids_per_vintf - 1,
> +			     GFP_KERNEL);
> +	if (sidx < 0) {
> +		iommufd_struct_destroy(viommu->ictx, vsid, core);
> +		return ERR_PTR(sidx);
> +	}
> +
> +	writel_relaxed(stream->id, REG_VINTF(vintf, SID_REPLACE(sidx)));
> +	writel_relaxed(dev_id << 1 | 0x1, REG_VINTF(vintf, SID_MATCH(sidx)));
> +	dev_dbg(vintf->cmdqv->dev,
> +		"VINTF%u: allocated SID_REPLACE%d for pSID=%x, vSID=%x\n",
> +		vintf->idx, sidx, stream->id, (u32)dev_id);
> +
> +	vsid->idx = sidx;
> +	vsid->vintf = vintf;
> +	vsid->sid = stream->id;
> +
> +	return &vsid->core;
> +}
> +
> +static void tegra241_vintf_destroy_vdevice(struct iommufd_vdevice *vdev)
> +{
> +	struct tegra241_vintf_sid *vsid =
> +		container_of(vdev, struct tegra241_vintf_sid, core);
> +	struct tegra241_vintf *vintf = vsid->vintf;
> +
> +	writel_relaxed(0, REG_VINTF(vintf, SID_REPLACE(vsid->idx)));
> +	writel_relaxed(0, REG_VINTF(vintf, SID_MATCH(vsid->idx)));

Just a thought: Should these be writel to avoid races?
Although I believe all user-queues would be free-d by this point?

> +	ida_free(&vintf->sids, vsid->idx);
> +	dev_dbg(vintf->cmdqv->dev,
> +		"VINTF%u: deallocated SID_REPLACE%d for pSID=%x\n", vintf->idx,
> +		vsid->idx, vsid->sid);
> +
> +	/* IOMMUFD core frees the memory of vsid and vdev */
> +}
> +
> +static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
> +	.destroy = tegra241_cmdqv_destroy_vintf_user,
> +	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
> +	.cache_invalidate = arm_vsmmu_cache_invalidate,
> +	.vdevice_alloc = tegra241_vintf_alloc_vdevice,
> +	.vdevice_destroy = tegra241_vintf_destroy_vdevice,
> +	.vcmdq_alloc = tegra241_vintf_alloc_lvcmdq_user,
> +	.vcmdq_destroy = tegra241_vintf_destroy_lvcmdq_user,
> +};
> +
> +static struct arm_vsmmu *
> +tegra241_cmdqv_vsmmu_alloc(struct arm_smmu_device *smmu,
> +			   struct arm_smmu_domain *s2_parent,
> +			   struct iommufd_ctx *ictx, unsigned int viommu_type,
> +			   const struct iommu_user_data *user_data)
> +{
> +	struct tegra241_cmdqv *cmdqv =
> +		container_of(smmu, struct tegra241_cmdqv, smmu);
> +	struct iommu_viommu_tegra241_cmdqv data;
> +	struct tegra241_vintf *vintf;
> +	phys_addr_t page0_base;
> +	int ret;
> +
> +	if (viommu_type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
> +		return ERR_PTR(-EOPNOTSUPP);
> +	if (!user_data)
> +		return ERR_PTR(-EINVAL);
> +
> +	ret = iommu_copy_struct_from_user(&data, user_data,
> +					  IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> +					  out_vintf_page0_pgsz);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	vintf = iommufd_viommu_alloc(ictx, struct tegra241_vintf, vsmmu.core,
> +				     &tegra241_cmdqv_viommu_ops);
> +	if (!vintf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = tegra241_cmdqv_init_vintf(cmdqv, cmdqv->num_vintfs - 1, vintf);
> +	if (ret < 0) {
> +		dev_err(cmdqv->dev, "no more available vintf\n");
> +		goto free_vintf;
> +	}
> +
> +	vintf->vsmmu.smmu = smmu;
> +	vintf->vsmmu.s2_parent = s2_parent;
> +	/* FIXME Move VMID allocation from the S2 domain allocation to here */
> +	vintf->vsmmu.vmid = s2_parent->s2_cfg.vmid;
> +
> +	/*
> +	 * Initialize the user-owned VINTF without a LVCMDQ, because it has to
> +	 * wait for the allocation of a user-owned LVCMDQ, for security reason.
> +	 * It is different than the kernel-owned VINTF0, which had pre-assigned
> +	 * and pre-allocated global VCMDQs that would be mapped to the LVCMDQs
> +	 * by the tegra241_vintf_hw_init() call.
> +	 */
> +	ret = tegra241_vintf_hw_init(vintf, false);
> +	if (ret)
> +		goto deinit_vintf;
> +
> +	vintf->lvcmdqs = kcalloc(cmdqv->num_lvcmdqs_per_vintf,
> +				 sizeof(*vintf->lvcmdqs), GFP_KERNEL);
> +	if (!vintf->lvcmdqs) {
> +		ret = -ENOMEM;
> +		goto hw_deinit_vintf;
> +	}
> +
> +	page0_base = cmdqv->base_phys + TEGRA241_VINTFi_PAGE0(vintf->idx);
> +	ret = iommufd_ctx_alloc_mmap(ictx, page0_base, SZ_64K,
> +				     &vintf->immap_id);
> +	if (ret)
> +		goto hw_deinit_vintf;
> +
> +	data.out_vintf_page0_pgsz = SZ_64K;
> +	data.out_vintf_page0_pgoff = vintf->immap_id;
> +	ret = iommu_copy_struct_to_user(user_data, &data,
> +					IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> +					out_vintf_page0_pgsz);
> +	if (ret)
> +		goto free_mmap;
> +
> +	ida_init(&vintf->sids);
> +
> +	dev_dbg(cmdqv->dev, "VINTF%u: allocated with vmid (%d)\n", vintf->idx,
> +		vintf->vsmmu.vmid);
> +
> +	return &vintf->vsmmu;
> +
> +free_mmap:
> +	iommufd_ctx_free_mmap(ictx, vintf->immap_id);
> +hw_deinit_vintf:
> +	tegra241_vintf_hw_deinit(vintf);
> +deinit_vintf:
> +	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
> +free_vintf:
> +	iommufd_struct_destroy(ictx, vintf, vsmmu.core);
> +	return ERR_PTR(ret);
> +}

Thanks,
Praan

> -- 
> 2.43.0
> 

