Return-Path: <linux-kselftest+bounces-45264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F2C4978D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5654F34B967
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E698B2E92B0;
	Mon, 10 Nov 2025 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stHaKd72"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2342D6605
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812241; cv=none; b=P0joTafJkveb6rPZSoZi7RfMKQ/MSqeNjTAQc9KnZUMV1y1bnWWOU4GiPslUbBhIcOtyezPFAGGFbQjB9n1VkVogTQGfOoywLylN3ujD7/yko2AcsuFiHjEEQd+4h8FOEMDJHplzFzec2RoiyI2QgxCv3+T7XvfX66Oy8/EWRwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812241; c=relaxed/simple;
	bh=W/+Qb13fLuIC+pUVsrfpojLJCEkS1lN/GKOP++Gtp9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqIDCfBe1i1JggPzJySS8ltIh4LRMeBJ3GwyPIB5CeF/BfoYeVXJnSpCkMHbd0M07AuAbvW//mFeyr3lJi7b6ZwcO9J9Z3lYmatXUyIhwxIeuucKxTr/9GTMBmWNXz42Oo+eA9aQ8VykYupHBEQ/ivaShIPx3DWFi8e44ps8GWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stHaKd72; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7810289cd4bso3548182b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 14:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762812240; x=1763417040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhck2YVv24x1Tq6SL/L5kEfr8DPVNBJogPUSyg2Wx54=;
        b=stHaKd72tuHrNNbXpurTuxGKhT+vEUHxd8JNi7RLepLNdj7GlLy2nfDnKWJ5i/DQY9
         mFRAHKOPZbNLR90oaFKncPo/aneOA+vaHXE6rwEIjf923vAsa4SrgnkI0TrzSx6omc3N
         x0cKiU5mgFVT5Sts4Vr0GE3KS79QQqJlUnmtCVucc5ewXRB9oJGQaG76O0JSJn3uiwoo
         ZkFSioCdM4ry/hrSko+KvJf/xkc2qp9EcFsy/ewMaLWXlOuJbZ2sdz7xikNmGxZykGGQ
         igvrRWfdoLZBDTEGsMfmU+eLicx/gd2CQjzjc7IIrHWlvMHTnJXs/v5tZqUjgaxcISHF
         jFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762812240; x=1763417040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhck2YVv24x1Tq6SL/L5kEfr8DPVNBJogPUSyg2Wx54=;
        b=BGpgPqSb3uDx7t3uiI8gJ37Gu/WeAnVbfd5Ufa/5kYHb9B/CG0P1R/0ycwo432ID4M
         cBR/hgJ5m1HIFP2Kc01Cv++Ba5D6gezuI8N1NITnbA4RG/2L4vfbj5w10mc5Ua0xKu8e
         gCNUccqTKxsHWNI7A3fnzg/ecuZ5sDEYfrPSCzkd7S468Pk4h8bx6zrcmFNFU8wIi8vT
         08Sf38pOBpWvMuseuEt07BflV6SXQ9UgtdLZ0x6ApqnKZf+OwzDIbMLUbDWh/DeMRu9L
         wYK/qymBi03gug9XBYuGnto7pXBoHKLcjsqvWe5LKE+kztQoY4dt9qfPvtsFEnRoMESM
         VYAg==
X-Forwarded-Encrypted: i=1; AJvYcCV8NJVMGe6faoyGrsMX0Z1Aof+jPBSCJxUNIwrkuipXadITwvS6aqdUdE0xKW+9WckGws5uKLUkjZplapV/GsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPsgugUsEZHQAyRbGw8sdWpfAZ/pj+8zqiWwgoDVS42+QOQ+Y
	bnxl2ByFFddd+WIf4ljZwsWuYDW74tRVu5XsV7IQxFhOazAZT3HxcX5uGfpnap4i0A==
X-Gm-Gg: ASbGncvcgAwzZUqcHbMck8pWoU2A6wUAYHeOZBkn648WZkw0pDm6F/gxiXR65CWaxKF
	O9bPSRRq3zGAJxl+iS4pEe3cEfB6ntcxDiQ610cGwux5dbX00EVHfIZt5FxbjQlPVCxRp8B2760
	IU9IjkImoRRWQnJCvJRZQl9pEvyWKHmLasogY31GklEpf5rUwUX2+I3PyOAxLjEZmvRMFF+aT+5
	LVa8osyGlDhl6dDrGEcnQnXRo1TYh4KywwpK55IjB6r9VBkdpdNR+mMCD2zXHjYQwiJtDx/F2Dz
	C5Ub62oi5SgM2mGxaI7NO/D1vhTqyPGuXKIzu4VifmhwuKs8ipBpF4a62RjsQNc32lwH1sSvZmT
	CIFbo9GGf6MaUr8LMyJR8JOHY4jzVfrtb6TwPetTJ6OtoNoWq+CEMfh0XsKMMK/riEaWesmVo/j
	f7SLRVpU+on6yIK7y/qDdyp0w1ScHwmPXruUJpY4UObsqQ2E79jGYUuI6XjmQArlw=
X-Google-Smtp-Source: AGHT+IGLIV/g6MCRKuipubTB9GVYmkpYIEQQohBhRaIhOj/Ez+CYSKMkODJsxMq554gdnbdi8bX1Mw==
X-Received: by 2002:a05:6a00:1892:b0:7ab:4fce:fa1b with SMTP id d2e1a72fcca58-7b225adc01fmr11346982b3a.4.1762812239386;
        Mon, 10 Nov 2025 14:03:59 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm12733156b3a.34.2025.11.10.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:03:58 -0800 (PST)
Date: Mon, 10 Nov 2025 22:03:54 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/4] vfio: selftests: add iova range query helpers
Message-ID: <aRJhSkj6S48G_pHI@google.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
 <20251110-iova-ranges-v1-1-4d441cf5bf6d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-iova-ranges-v1-1-4d441cf5bf6d@fb.com>

On 2025-11-10 01:10 PM, Alex Mastro wrote:
> +/*
> + * Return iova ranges for the device's container. Normalize vfio_iommu_type1 to
> + * report iommufd's iommu_iova_range. Free with free().
> + */
> +static struct iommu_iova_range *vfio_iommu_iova_ranges(struct vfio_pci_device *device,
> +						       size_t *nranges)
> +{
> +	struct vfio_iommu_type1_info_cap_iova_range *cap_range;
> +	struct vfio_iommu_type1_info *buf;

nit: Maybe name this variable `info` here and in vfio_iommu_info_buf()
and vfio_iommu_info_cap_hdr()? It is not an opaque buffer.

> +	struct vfio_info_cap_header *hdr;
> +	struct iommu_iova_range *ranges = NULL;
> +
> +	buf = vfio_iommu_info_buf(device);

nit: How about naming this vfio_iommu_get_info() since it actually
fetches the info from VFIO? (It doesn't just allocate a buffer.)

> +	VFIO_ASSERT_NOT_NULL(buf);

This assert is unnecessary.

> +
> +	hdr = vfio_iommu_info_cap_hdr(buf, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
> +	if (!hdr)
> +		goto free_buf;

Is this to account for running on old versions of VFIO? Or are there
some scenarios when VFIO can't report the list of IOVA ranges?

> +
> +	cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
> +	if (!cap_range->nr_iovas)
> +		goto free_buf;
> +
> +	ranges = malloc(cap_range->nr_iovas * sizeof(*ranges));
> +	VFIO_ASSERT_NOT_NULL(ranges);
> +
> +	for (u32 i = 0; i < cap_range->nr_iovas; i++) {
> +		ranges[i] = (struct iommu_iova_range){
> +			.start = cap_range->iova_ranges[i].start,
> +			.last = cap_range->iova_ranges[i].end,
> +		};
> +	}
> +
> +	*nranges = cap_range->nr_iovas;
> +
> +free_buf:
> +	free(buf);
> +	return ranges;
> +}
> +
> +/* Return iova ranges of the device's IOAS. Free with free() */
> +struct iommu_iova_range *iommufd_iova_ranges(struct vfio_pci_device *device,
> +					     size_t *nranges)
> +{
> +	struct iommu_iova_range *ranges;
> +	int ret;
> +
> +	struct iommu_ioas_iova_ranges query = {
> +		.size = sizeof(query),
> +		.ioas_id = device->ioas_id,
> +	};
> +
> +	ret = ioctl(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
> +	VFIO_ASSERT_EQ(ret, -1);
> +	VFIO_ASSERT_EQ(errno, EMSGSIZE);
> +	VFIO_ASSERT_GT(query.num_iovas, 0);
> +
> +	ranges = malloc(query.num_iovas * sizeof(*ranges));
> +	VFIO_ASSERT_NOT_NULL(ranges);
> +
> +	query.allowed_iovas = (uintptr_t)ranges;
> +
> +	ioctl_assert(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
> +	*nranges = query.num_iovas;
> +
> +	return ranges;
> +}
> +
> +struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
> +					      size_t *nranges)

nit: Both iommufd and VFIO represent the number of IOVA ranges as a u32.
Perhaps we should do the same in VFIO selftests?

