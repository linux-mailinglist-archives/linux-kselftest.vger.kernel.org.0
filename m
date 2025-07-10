Return-Path: <linux-kselftest+bounces-36954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97263B0004E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F10D1C82AD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9412D2E4246;
	Thu, 10 Jul 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7Mla/ii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD728D849
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146079; cv=none; b=lgRDdttmBa4MXtIqXo8DrVCt0M0i53WDhCtloM1KX4zecUU1GnvAyleK94FY3oj3aBEQD5NbMrXExhOqcjJcqtzjzyptbHcq+0ZYgf9goqTqVaKOobVE7wUoriu5rRTrCqrZtjFkk4TWkrlFIiyvoaC0vKq83XydZouyzqi8qiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146079; c=relaxed/simple;
	bh=ZVMrkGCRz0vGzBuWsVUOSvsef7nfEi4IoGFuJQ8NY0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYxYKuY2Oqcs0a6eZOFOumt5e9QRuOvZcDwv8iIsazTXpO9Op3pC+mSH6H9C9EUHAE2K7Owt9AxNJNYWnZa8GBQ6JW2pPC46vzvpoUQqTgMVWwLBl+Rx5MS3dRUCXJTNHW6v1BJW/cRMkVjODRPFR/ZL+H2Lp8yc9UsBIDR1yVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7Mla/ii; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2357c61cda7so115665ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 04:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752146075; x=1752750875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgBpvBKNceadcIlK+jQ2H7nSb6VN21Y6ASF39ITBcCM=;
        b=y7Mla/iiZ9RpJ85SOqUc+fXDrcOK+lANDtMy1AAAOIuUewmrS9YiiWl+sQYAIhTHd/
         MpNZWUWnxzrktK34jQnCQfMHWbDcg9R1y9dPUhf7zfGZYv9cnTcvu8p92LOZJCFnZg/K
         DnBumFlbNZFLpXgDBgEOe2+T6xIGMOqDl+mYnTxRrlu5wtsDszYPdDB0SM9U6xJy5kzJ
         ENvLjM8jsjwalUKkKTpDW/XdahiC/7B2us/E+OxBW843krp/uOv+rfqs4eMFf5kohf7b
         PQAzE7uPaWbVej4fICw4rtdgkCye5j5YoJ9FbASJyWKqkgXVDkjknkRGD3Ki46qn/ZEw
         jrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752146075; x=1752750875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgBpvBKNceadcIlK+jQ2H7nSb6VN21Y6ASF39ITBcCM=;
        b=PZHFsDNavaKtgAkOcElanycyKsEm7l9slp+zBuUbWS9K5FMZQkFidguSX4rMDY09Dd
         NYDWtzotYOxlohOuqpDfWQQjs9v2ehoarmOeajoUSfiuKd972IZCsyXXZqpFdq9952O2
         15PedGFboPGJLAzs8idFRUfxsK0jT0dNDf99T9O1XDt0Qq/9ljY+lXf2fw1COafHOOhE
         zi6fYajMXeM8jnJFGAqTACxXwWa8HAr6q6C7Iw8SSTsn4tp/ttUO4f8AZq69dCSMx6To
         QvCU+g22zmqGs0VzT65OIdqqCK/lyQZWD78ULhemfR1yNOmYCN26+F3fwsT7soY7UEo4
         2++Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqvOla1wRg9aE8IZfXUX/Nu1jo+kPrFNwXFqYZoJn4sNCDa/RnlxNeAdnpImslwmZJFnf6oRZbDq/IMFSZWJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJx9hVb8TPbizbqIvfdm7ZlbqRsDitE3uG5gkC4gyCaRhr+ZUb
	/obhA9oKAu/ym+/BrYv/YZnYFZ2jEh+6ItHqJ2t+AiMys77Eta92Xa10yQ7st5wyjA==
X-Gm-Gg: ASbGncttGaTxWedHjWlHtWgQGM6DOYJplPRhl4PD9kj13NK3S2UJmX/LIzONMfY+Fks
	F4K+KN+UluvyuHonj7uqOpT83132n9TYo3UUaisoli2NmS21GtZV2K63wvn8uMY0Hqd/xx1zeXy
	m6l8SEq/JBngPbLEMh6NaPjJpKs1KR+NvDPUG8V6olKVQJPfqCztn81nnZo9XCgSDXLYexwxDtF
	an6Ycnbdy88mA/1+y6jKFaJXano9Ls5Z5bUiqef15i33o/wJ0mqhne9Vc3jj1earTOT/zYmix0V
	8EUk/h0Q7gOUieVXr6tLxL+uVkxDlMuN2S5LpDV8zgUPODMAx/HiYRGtujXSm6ajbmf0wS8y08C
	ulRwdEx8QoXjkPq8csYpu
X-Google-Smtp-Source: AGHT+IFecBQHKG/ADcdq4eQ6HjOLMsTP4bdCQ53xMQ7WEkYQDG2G5iyvFIgwZFKNsIRqwMRxh8GaYQ==
X-Received: by 2002:a17:903:3b8e:b0:234:c37:85a with SMTP id d9443c01a7336-23de38106e0mr3159625ad.24.1752146074745;
        Thu, 10 Jul 2025 04:14:34 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4366698sm18961295ad.246.2025.07.10.04.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:14:34 -0700 (PDT)
Date: Thu, 10 Jul 2025 11:14:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net,
	bagasdotme@gmail.com, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
	nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
	mshavit@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 18/29] iommufd/selftest: Add coverage for the new mmap
 interface
Message-ID: <aG-gkXOZExtzUGxe@google.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <b02b1220c955c3cf9ea5dd9fe9349ab1b4f8e20b.1752126748.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b02b1220c955c3cf9ea5dd9fe9349ab1b4f8e20b.1752126748.git.nicolinc@nvidia.com>

On Wed, Jul 09, 2025 at 10:59:10PM -0700, Nicolin Chen wrote:
> Extend the loopback test to a new mmap page.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> ---
>  drivers/iommu/iommufd/iommufd_test.h          |  4 +++
>  tools/testing/selftests/iommu/iommufd_utils.h |  4 +++
>  drivers/iommu/iommufd/selftest.c              | 33 ++++++++++++++++++-
>  tools/testing/selftests/iommu/iommufd.c       | 19 +++++++++++
>  4 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
> index 51cd744a354f..8fc618b2bcf9 100644
> --- a/drivers/iommu/iommufd/iommufd_test.h
> +++ b/drivers/iommu/iommufd/iommufd_test.h
> @@ -232,12 +232,16 @@ struct iommu_hwpt_invalidate_selftest {
>   *                                (IOMMU_VIOMMU_TYPE_SELFTEST)
>   * @in_data: Input random data from user space
>   * @out_data: Output data (matching @in_data) to user space
> + * @out_mmap_offset: The offset argument for mmap syscall
> + * @out_mmap_length: The length argument for mmap syscall
>   *
>   * Simply set @out_data=@in_data for a loopback test
>   */
>  struct iommu_viommu_selftest {
>  	__u32 in_data;
>  	__u32 out_data;
> +	__aligned_u64 out_mmap_offset;
> +	__aligned_u64 out_mmap_length;
>  };
>  
>  /* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 9a556f99d992..4a1b2bade018 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -56,6 +56,10 @@ static unsigned long PAGE_SIZE;
>  #define offsetofend(TYPE, MEMBER) \
>  	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>  
> +#define test_err_mmap(_errno, length, offset)                                 \
> +	EXPECT_ERRNO(_errno, (long)mmap(NULL, length, PROT_READ | PROT_WRITE, \
> +					MAP_SHARED, self->fd, offset))
> +
>  static inline void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
>  {
>  	int mfd_flags = (flags & MAP_HUGETLB) ? MFD_HUGETLB : 0;
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 2189e9b119ee..8b2c44b32530 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -152,6 +152,9 @@ struct mock_viommu {
>  	struct mock_iommu_domain *s2_parent;
>  	struct mock_hw_queue *hw_queue[IOMMU_TEST_HW_QUEUE_MAX];
>  	struct mutex queue_mutex;
> +
> +	unsigned long mmap_offset;
> +	u32 *page; /* Mmap page to test u32 type of in_data */
>  };
>  
>  static inline struct mock_viommu *to_mock_viommu(struct iommufd_viommu *viommu)
> @@ -689,6 +692,10 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
>  
>  	if (refcount_dec_and_test(&mock_iommu->users))
>  		complete(&mock_iommu->complete);
> +	if (mock_viommu->mmap_offset)
> +		iommufd_viommu_destroy_mmap(&mock_viommu->core,
> +					    mock_viommu->mmap_offset);
> +	free_page((unsigned long)mock_viommu->page);
>  	mutex_destroy(&mock_viommu->queue_mutex);
>  
>  	/* iommufd core frees mock_viommu and viommu */
> @@ -887,11 +894,28 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
>  		if (rc)
>  			return rc;
>  
> +		/* Allocate two pages */
> +		mock_viommu->page =
> +			(u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
> +		if (!mock_viommu->page)
> +			return -ENOMEM;
> +
> +		rc = iommufd_viommu_alloc_mmap(&mock_viommu->core,
> +					       __pa(mock_viommu->page),
> +					       PAGE_SIZE * 2,
> +					       &mock_viommu->mmap_offset);
> +		if (rc)
> +			goto err_free_page;
> +
> +		/* For loopback tests on both the page and out_data */
> +		*mock_viommu->page = data.in_data;
>  		data.out_data = data.in_data;
> +		data.out_mmap_length = PAGE_SIZE * 2;
> +		data.out_mmap_offset = mock_viommu->mmap_offset;
>  		rc = iommu_copy_struct_to_user(
>  			user_data, &data, IOMMU_VIOMMU_TYPE_SELFTEST, out_data);
>  		if (rc)
> -			return rc;
> +			goto err_destroy_mmap;
>  	}
>  
>  	refcount_inc(&mock_iommu->users);
> @@ -900,6 +924,13 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
>  
>  	viommu->ops = &mock_viommu_ops;
>  	return 0;
> +
> +err_destroy_mmap:
> +	iommufd_viommu_destroy_mmap(&mock_viommu->core,
> +				    mock_viommu->mmap_offset);
> +err_free_page:
> +	free_page((unsigned long)mock_viommu->page);
> +	return rc;
>  }
>  
>  static const struct iommu_ops mock_ops = {
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 73426de77675..0b21c095ca5e 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -2799,6 +2799,7 @@ TEST_F(iommufd_viommu, viommu_alloc_with_data)
>  	struct iommu_viommu_selftest data = {
>  		.in_data = 0xbeef,
>  	};
> +	uint32_t *test;
>  
>  	if (!self->device_id)
>  		SKIP(return, "Skipping test for variant no_viommu");
> @@ -2807,6 +2808,24 @@ TEST_F(iommufd_viommu, viommu_alloc_with_data)
>  			      IOMMU_VIOMMU_TYPE_SELFTEST, &data, sizeof(data),
>  			      &self->viommu_id);
>  	ASSERT_EQ(data.out_data, data.in_data);
> +
> +	/* Negative mmap tests -- offset and length cannot be changed */
> +	test_err_mmap(ENXIO, data.out_mmap_length,
> +		      data.out_mmap_offset + PAGE_SIZE);
> +	test_err_mmap(ENXIO, data.out_mmap_length,
> +		      data.out_mmap_offset + PAGE_SIZE * 2);
> +	test_err_mmap(ENXIO, data.out_mmap_length / 2, data.out_mmap_offset);
> +	test_err_mmap(ENXIO, data.out_mmap_length * 2, data.out_mmap_offset);
> +
> +	/* Now do a correct mmap for a loopback test */
> +	test = mmap(NULL, data.out_mmap_length, PROT_READ | PROT_WRITE,
> +		    MAP_SHARED, self->fd, data.out_mmap_offset);
> +	ASSERT_NE(MAP_FAILED, test);
> +	ASSERT_EQ(data.in_data, *test);
> +
> +	/* The owner of the mmap region should be blocked */
> +	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, self->viommu_id));
> +	munmap(test, data.out_mmap_length);
>  }
>  
>  TEST_F(iommufd_viommu, vdevice_alloc)
> -- 
> 2.43.0
> 

