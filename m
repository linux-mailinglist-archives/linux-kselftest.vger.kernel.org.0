Return-Path: <linux-kselftest+bounces-31814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDB7A9F91F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 21:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA454654F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D5296D31;
	Mon, 28 Apr 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IatgPgZc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF4296D28
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866976; cv=none; b=iZ9yBcBxZowSxxlH57XQNS8sD1d/i8T3Ru3LrGOFkw0jk+gMrYeqbilumlSP3DT8P7UR80OHYb00B+mmpw5OBwyU6o6t553Onka6jrZtErYpbByY8IaUM7Vw6CVERDOIUEZ4ILlQP27SGzjsfDt0fqp7jciwRseGKqudrdzJHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866976; c=relaxed/simple;
	bh=81G08v+RqUNeKeO9J3EQnr/p4nVDb1PF8OFcGNlg19g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9gSM0HcrEnEY80PlC+zPb/JNYgCfzYPqBvaaxMhFeKznhhRlR5WhVXuao7AtRk4K9iJGTXeMqPSvMgrV6qAGOU9pLCB9dQ4T1caImeS4LLr9G+plueUP1uAOgsoA7izSfnMXJs7k/q/PkQnnzIdecJRv3sQHf7LVBjpCtAYZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IatgPgZc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2263428c8baso25005ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745866974; x=1746471774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYyPt2jR26wCNvi6PxzFs+Tv2/OybZasQ+Gm5GQ685c=;
        b=IatgPgZcpx9LGQO7xF0DFR9STLGpf1zp1BD1GOElpq0WBOrId31gxfAbI5zwFGeKch
         NuWo6JsH29yFGxzR3AH/UBYh2Z/sF2/D/4X5DZM2GKa/pzVv6GcbrjTwcckOAqC/Fxrn
         0235kUOh+hERRW8OUetA3YcpTn3S1YEJzQomScKiM+N7fK4wseiTTs7Rtkbam7vpmGLW
         Kc9l6RF0SDeolNajlGcauQRGN4GCtKTUa2/w13+lO/MoX5KrWoHRZk4riqCuWIaNesM1
         fbtIVSyFKn/U3l98jJ8q9GJmbFmfNqwrqMl/cmoNCeHR/wVy7IcOu52/DkE3FCyUjuUJ
         65VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866974; x=1746471774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYyPt2jR26wCNvi6PxzFs+Tv2/OybZasQ+Gm5GQ685c=;
        b=jTNZ6d1lXPV6zVglBhT5yWlm+2G/9RZxoet57imWXbJpEunYGmuY6H7fhEjqeUzVyB
         jn1pcits+zBvDZajlGMEWYtduu7sVK9QBOWaxBzrF6GtHsiPU7nf+qelgUnsWIAeqtDm
         GdIFiQk47DGf5Gq99QHijmwNHOnM7ABBYTA7CBtvwEzKs8U/M7MJETEe0o8AtdMakPos
         o1U8ipe49hDpruV9wRaTGnm5MFiUCxwdcb64UhdVU2qpiBgLUgmBQtIuu3rlAP9U2HpI
         pAbXBz/5udEmNQs6Fdkeug5MIPIKd+lKciLRiSrofuL9jxgZWQdXWO7/L6Fa9CJSlWmh
         W+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWZDsEPSGPtpBulYf66TnZvBa7wDUB7IQgeQRfBI6IKv5rOBr43S3ZPTPVzS+gHZSa2xpCQsHMW6SJuT6UUGHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1RbUI1YPZYPRyHKm6QhXWRk0NfQ0Pd0oOoMB3eg1OcEpwAFC
	ZFYL8m7dRPS50dIqaI+8S2ozFeIsGQ2DVaU4yYAGwKOrjAeqlddwomrsxPGhkg==
X-Gm-Gg: ASbGncuTpcwSvrzDRSkkBemvbqcR3HwERoNdw/91HR2V5jt2buV+hndNIgPHCqDqY/z
	wfLUnOJdw2uvyT97xpZL3A7FqkFb0riXCsf4FPVoMfUYThBc2NqxDsHaM8LahYnUkcAk4i3JTii
	M/8RbtQHETptXkJHjNA58XjdaQLCxORKLVR2odNYl/xNiMLaFruTgja+S7GbkNRT1/wy2G4/dI7
	/q/qY+vDQxEIrU9VtLZ0ARLWR+/Af6xHcMIG1s3TroAK4t1fgHE7hZRCflYt6C1mMcqA5TPsdoq
	S7H8P0gh6vBrQWqlUHlKM6QXfyCW2hZF83ojsGWy3Vik62BAswdBRfniadbLCPora50U5MHx
X-Google-Smtp-Source: AGHT+IEJGsiJDrtJlEO2nY+Xes9iIUQJtfbQGQMK+W7yiK5m4Ms2rwNKriCBn3CEAxNgqNLQt8mwbw==
X-Received: by 2002:a17:903:32cc:b0:21f:3f5c:d24c with SMTP id d9443c01a7336-22de6bc7c32mr473905ad.0.1745866973500;
        Mon, 28 Apr 2025 12:02:53 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309eef7cc58sm9392543a91.0.2025.04.28.12.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 12:02:52 -0700 (PDT)
Date: Mon, 28 Apr 2025 19:02:42 +0000
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
Subject: Re: [PATCH v2 07/22] iommufd/selftest: Add covearge for viommu data
Message-ID: <aA_Q0o74AySmRM2G@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <acb47bf56f1b03df9f6fca26f511529354be3caa.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb47bf56f1b03df9f6fca26f511529354be3caa.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:02PM -0700, Nicolin Chen wrote:
> Extend the existing test_cmd/err_viommu_alloc helpers to accept optional
> user data. And add a TEST_F for a loopback test.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++-----
>  tools/testing/selftests/iommu/iommufd.c       | 29 +++++++++++++++----
>  .../selftests/iommu/iommufd_fail_nth.c        |  5 ++--
>  3 files changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 72f6636e5d90..a5d4cbd089ba 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -897,7 +897,8 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 pasid,
>  					    pasid, fault_fd))
>  
>  static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
> -				  __u32 type, __u32 flags, __u32 *viommu_id)
> +				  __u32 flags, __u32 type, void *data,
> +				  __u32 data_len, __u32 *viommu_id)
>  {
>  	struct iommu_viommu_alloc cmd = {
>  		.size = sizeof(cmd),
> @@ -905,6 +906,8 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
>  		.type = type,
>  		.dev_id = device_id,
>  		.hwpt_id = hwpt_id,
> +		.data_uptr = (uint64_t)data,
> +		.data_len = data_len,
>  	};
>  	int ret;
>  
> @@ -916,13 +919,15 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
>  	return 0;
>  }
>  
> -#define test_cmd_viommu_alloc(device_id, hwpt_id, type, viommu_id)        \
> -	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, \
> -					    type, 0, viommu_id))
> -#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, viommu_id) \
> -	EXPECT_ERRNO(_errno,                                               \
> -		     _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id,  \
> -					    type, 0, viommu_id))
> +#define test_cmd_viommu_alloc(device_id, hwpt_id, type, data, data_len,      \
> +			      viommu_id)                                     \
> +	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, 0, \
> +					    type, data, data_len, viommu_id))
> +#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, data,        \
> +			      data_len, viommu_id)                           \
> +	EXPECT_ERRNO(_errno,                                                 \
> +		     _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, 0, \
> +					    type, data, data_len, viommu_id))
>  
>  static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
>  				   __u64 virt_id, __u32 *vdev_id)
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 1a8e85afe9aa..8ebbb7fda02d 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -2688,7 +2688,7 @@ FIXTURE_SETUP(iommufd_viommu)
>  
>  		/* Allocate a vIOMMU taking refcount of the parent hwpt */
>  		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
> -				      IOMMU_VIOMMU_TYPE_SELFTEST,
> +				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
>  				      &self->viommu_id);
>  
>  		/* Allocate a regular nested hwpt */
> @@ -2727,24 +2727,27 @@ TEST_F(iommufd_viommu, viommu_negative_tests)
>  	if (self->device_id) {
>  		/* Negative test -- invalid hwpt (hwpt_id=0) */
>  		test_err_viommu_alloc(ENOENT, device_id, 0,
> -				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
> +				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
> +				      NULL);
>  
>  		/* Negative test -- not a nesting parent hwpt */
>  		test_cmd_hwpt_alloc(device_id, ioas_id, 0, &hwpt_id);
>  		test_err_viommu_alloc(EINVAL, device_id, hwpt_id,
> -				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
> +				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
> +				      NULL);
>  		test_ioctl_destroy(hwpt_id);
>  
>  		/* Negative test -- unsupported viommu type */
>  		test_err_viommu_alloc(EOPNOTSUPP, device_id, self->hwpt_id,
> -				      0xdead, NULL);
> +				      0xdead, NULL, 0, NULL);
>  		EXPECT_ERRNO(EBUSY,
>  			     _test_ioctl_destroy(self->fd, self->hwpt_id));
>  		EXPECT_ERRNO(EBUSY,
>  			     _test_ioctl_destroy(self->fd, self->viommu_id));
>  	} else {
>  		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
> -				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
> +				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
> +				      NULL);
>  	}
>  }
>  
> @@ -2791,6 +2794,20 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
>  	}
>  }
>  
> +TEST_F(iommufd_viommu, viommu_alloc_with_data)
> +{
> +	struct iommu_viommu_selftest data = {
> +		.in_data = 0xbeef,
> +	};
> +
> +	if (self->device_id) {
> +		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
> +				      IOMMU_VIOMMU_TYPE_SELFTEST, &data,
> +				      sizeof(data), &self->viommu_id);
> +		assert(data.out_data == data.in_data);
> +	}
> +}
> +
>  TEST_F(iommufd_viommu, vdevice_alloc)
>  {
>  	uint32_t viommu_id = self->viommu_id;
> @@ -3105,7 +3122,7 @@ TEST_F(iommufd_device_pasid, pasid_attach)
>  
>  	/* Allocate a regular nested hwpt based on viommu */
>  	test_cmd_viommu_alloc(self->device_id, parent_hwpt_id,
> -			      IOMMU_VIOMMU_TYPE_SELFTEST,
> +			      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
>  			      &viommu_id);
>  	test_cmd_hwpt_alloc_nested(self->device_id, viommu_id,
>  				   IOMMU_HWPT_ALLOC_PASID,
> diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> index e11ec4b121fc..f7ccf1822108 100644
> --- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
> +++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
> @@ -688,8 +688,9 @@ TEST_FAIL_NTH(basic_fail_nth, device)
>  				 IOMMU_HWPT_DATA_NONE, 0, 0))
>  		return -1;
>  
> -	if (_test_cmd_viommu_alloc(self->fd, idev_id, hwpt_id,
> -				   IOMMU_VIOMMU_TYPE_SELFTEST, 0, &viommu_id))
> +	if (_test_cmd_viommu_alloc(self->fd, idev_id, hwpt_id, 0,
> +				   IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
> +				   &viommu_id))
>  		return -1;
>  
>  	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
> -- 
> 2.43.0
> 

