Return-Path: <linux-kselftest+bounces-32054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09459AA57D0
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 00:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C4A1B67DBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57190223337;
	Wed, 30 Apr 2025 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7NZzPWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CA221F3F
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050647; cv=none; b=PW7ESGqhDH1oY7eFD1srb4l1o/Ijr3NPDhoDz7H1XeNJVehx9dtDRfOCdLCTYaUflvhA4hBWw6OVjbf5Ux7j6iWaGCWzBaeIMGsmCbVt20R0Lgm5W/VH/w+uToB2c+jUKyyagoPQjw5QU2VxQ0LysgidBI2aQPfMv1rnb6XSqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050647; c=relaxed/simple;
	bh=a6a4m8o4Fnf9b9bUx8vDZ1tnb4WXvfqXb62W3uQzEvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFzP1dUJ0terngvcyVgpi9COOKOREaZ8d+ltf8cOBSJ3YzB99TcwlNOVd85xvbfEjS6RShjDnGDi7VlxuIm//+mhETbRutzxEpvERfFwy+Mm9la6XVSQVvEegUtwVSAr/FehH7zpOwcsBitez563azTJfRub1cbvq1flHemS3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7NZzPWr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2264c9d0295so20565ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746050645; x=1746655445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVawBlGLpoSzo0dY08dmSMH05U/ahZ0t0/eytQcNdTQ=;
        b=m7NZzPWrvaIxkrXieWO8VS44wSkkS+8IoweWj45R+cGh+KsmSRFwkrDO1oWv/vIRbf
         QlJrOxgyahmmuttQyWa2V1GGL530Fjy6f0/r2Pt9gJsSTfGjrjlcDhue+bPFoWWmcpab
         SkMCX0A1rJw+Ko8pjQxk8VZor9owOqRBIo7YhFypJDkVtDGb/hSI5ePAo48MGCUckB1S
         Ku835QpK231uww3ziZs0oOEYr+OMRDjsHrIA+tqZ48Doj5mLtVCatlzzQi6yOFgTW5Wg
         rFiE9KemGS+CKZeDHq5ALzREfjowRi2y0svn15uDWvLYkiwN95eo1w1C84kTWL6serhC
         9Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746050645; x=1746655445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVawBlGLpoSzo0dY08dmSMH05U/ahZ0t0/eytQcNdTQ=;
        b=P36RvaQgbapHs3c7PpCQgAiZpabQHcHc2FQL9UAZCqzeCjDVUR7jtlmHXG9f0dUFQu
         FG2V5GOoZCaBldejR0niGI4w/EA5HbVwTJjlK8qFPSMJlNUIfKkV9fC5F8Hk4cbiN5Pd
         qcrxEZ9RQP9ODPqksCDo0qc9MeIwOKPEdevGhjwwfRez9bIIsELM++smqkvpjFILvNgZ
         NLREc6KGYsa7YKhSxgGFQYw8w8nt5pzgZgsXMBC0cTRGr0EQGMITPc8pBlyjWrSKMQ9W
         AxqLglQOu8/xpgTInP/nRnVKQFUHTbdIZfFe0CqN0sF4RbIBaFJVZ3IkLZHb0/tEDiu5
         /lDg==
X-Forwarded-Encrypted: i=1; AJvYcCWfBHfINVNP0+s7NR3Tpi7Fygv2Zwu3r93V+FE0S8UuELoRqFXoX4t+ztcGZd3GgUXkQlJFEWSZXKYfkdJNilg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaUDk/8JAlaBCYbepbU/51fcMwcRr51WKh4tCZHlM79ZJFD9b
	PQMVwkRNXmsIfWiPaIAnBOjvlu+Q9Y3JwcjcX3i0psSEvPTRg5sK2+MNQEHj/g==
X-Gm-Gg: ASbGncsLv6/Ccqjv0czQ93H3nVhM621FSCple001LT1mVtWOWRr3qDCovemVfZYOnyN
	x+PyTzR+12zzdrrFW/rhpP0gKH8cr6ZNLdw9TH+g9WQmPYG21F453zi93SR/opZqeFcYyWKIMOk
	8wAng1EjT3p2NtHNxu0IDUHdfy1uTuC40fwdAuAqXtxygND54jsjndLfda39qRinncWl01ypZ7D
	v+XpALns8SaurC9HCn0/gNVzVVVtlpG7QqatYH6GHLPJKU61P7XuxWWbgQssvcuZ0QCJqwkheQ2
	OiRUPMY5yQo8DnVbmvPX4vOC73QWS004FbWIZG6aSzBl1mw5Hbu6LxBzkb5wbl27XoWZ53sK
X-Google-Smtp-Source: AGHT+IGd4hYbbWLBFZpJCFZt3J+kQFvNTF3X43diXZZjefIRoFc4WvBq3IOD+DnYRjbMCinfwG1ReQ==
X-Received: by 2002:a17:903:17c3:b0:21f:9f4:4a03 with SMTP id d9443c01a7336-22e07a8ada1mr325415ad.21.1746050644476;
        Wed, 30 Apr 2025 15:04:04 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5104cd5sm127537775ad.199.2025.04.30.15.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 15:04:04 -0700 (PDT)
Date: Wed, 30 Apr 2025 22:03:53 +0000
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
Subject: Re: [PATCH v2 22/22] iommu/tegra241-cmdqv: Add
 IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Message-ID: <aBKeSeuPvTruzchM@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a7db1d2fe5dd43ac7ac075df662f3ab743ac6aa2.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7db1d2fe5dd43ac7ac075df662f3ab743ac6aa2.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:17PM -0700, Nicolin Chen wrote:
> Add a new vEVENTQ type for VINTFs that are assigned to the user space.
> Simply report the two 64-bit LVCMDQ_ERR_MAPs register values.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

> ---
>  include/uapi/linux/iommufd.h                  | 15 +++++++++++++
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 22 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index d69e7c1d39ea..d814b0f61fad 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -1113,10 +1113,12 @@ struct iommufd_vevent_header {
>   * enum iommu_veventq_type - Virtual Event Queue Type
>   * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
>   * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
> + * @IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension IRQ
>   */
>  enum iommu_veventq_type {
>  	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
>  	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
> +	IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV = 2,
>  };
>  
>  /**
> @@ -1140,6 +1142,19 @@ struct iommu_vevent_arm_smmuv3 {
>  	__aligned_le64 evt[4];
>  };
>  
> +/**
> + * struct iommu_vevent_tegra241_cmdqv - Tegra241 CMDQV IRQ
> + *                                      (IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV)
> + * @lvcmdq_err_map: 128-bit logical vcmdq error map, little-endian.
> + *                  (Refer to register LVCMDQ_ERR_MAPs per VINTF )
> + *
> + * The 128-bit register value from HW exclusively reflect the error bits for a
> + * Virtual Interface represented by a vIOMMU object. Read and report directly.
> + */
> +struct iommu_vevent_tegra241_cmdqv {
> +	__aligned_le64 lvcmdq_err_map[2];
> +};
> +
>  /**
>   * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
>   * @size: sizeof(struct iommu_veventq_alloc)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 88e2b6506b3a..d8830b526601 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -292,6 +292,20 @@ static inline int vcmdq_write_config(struct tegra241_vcmdq *vcmdq, u32 regval)
>  
>  /* ISR Functions */
>  
> +static void tegra241_vintf_user_handle_error(struct tegra241_vintf *vintf)
> +{
> +	struct iommufd_viommu *viommu = &vintf->vsmmu.core;
> +	struct iommu_vevent_tegra241_cmdqv vevent_data;
> +	int i;
> +
> +	for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
> +		vevent_data.lvcmdq_err_map[i] =
> +			readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
> +
> +	iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
> +				    &vevent_data, sizeof(vevent_data));
> +}
> +
>  static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
>  {
>  	int i;
> @@ -337,6 +351,14 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
>  		vintf_map &= ~BIT_ULL(0);
>  	}
>  
> +	/* Handle other user VINTFs and their LVCMDQs */
> +	while (vintf_map) {
> +		unsigned long idx = __ffs64(vintf_map);
> +
> +		tegra241_vintf_user_handle_error(cmdqv->vintfs[idx]);
> +		vintf_map &= ~BIT_ULL(idx);
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.43.0
> 

