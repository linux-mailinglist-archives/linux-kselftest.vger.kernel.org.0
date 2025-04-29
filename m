Return-Path: <linux-kselftest+bounces-31897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A61AA0BD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CC71B64CA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669222C17B1;
	Tue, 29 Apr 2025 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBmG+n5Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B22C1799
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930422; cv=none; b=Jhe4hE9ISfsPYY16jpYVor55BYR98rCZCEYy/ozUEsaZGjaDkw89fIhdvLFgzKu4f8Ucqgwt0nto2B7erMQ0tfA+1hNmdqeH5SkAdjADY7CjaCx3VUUmZoyHE6DdrbU5MwST16wVZsYHOQ91zmnL6YjCmPtvaF+E0z1fOd2z0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930422; c=relaxed/simple;
	bh=ip7eQAl3OkyTGCrq0cmjZ9WKSDXUMl/2DdneuAGxbWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR16j0a2fEEPN8vsBu8tS7dISMLUsDRYQMbu8LyAIhGUiO51jNZ0Wrj3zO8pYNyfUF9dNbhYwUFGjbBo7rYav00mGClit8yZ+JxXTKFxGA3jbXxM2rcjFWwi/cUrKLccO+ZRoj9yf9aek4LOHe8sTwqig6MN0kVGMZd4dQtgFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBmG+n5Y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2263428c8baso91275ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745930419; x=1746535219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hhyBzxR8NyUZrkIJH4pc7IFsAn1vSN/LWAh25/3km3g=;
        b=bBmG+n5Y3bEvP/BZpXHfXRTxVWyVaZVuWrmxEIPNe9ATbFH3mYd+M3cQz9ANRRE4jY
         pes7hxhgYzsmWpXjB7It7K/6GMCDEJdBQveachJZyJglH8DXN44Uvuec/3MEMgvU6VQe
         KLGuz88efFS2C7iyYFCpetv8goU0cMHVvj2N+enyxc8x6YbVW9FBUV6VzO9WJwKFHv5t
         PCSYGmODyT1R6mY6YFjEpdMuxFRBX9LKY6ft2BcIJJX5xzxzpI9X1w8hOXPmewQzJOJ9
         ly4QsShK+4+R9eBxwSysaegJz+VT5OEy35pBcppLYfzCIOb9FJOqop0nn5gPPjLjGOLl
         a8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745930419; x=1746535219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhyBzxR8NyUZrkIJH4pc7IFsAn1vSN/LWAh25/3km3g=;
        b=kNK3vTaY+xygFJmOH1pyoaM4v9NDuvEE8Dv8LzeIC+fc+IDOuzdhu+w2T2ldnuyiDc
         ukUkVJaOjnB0zyjammueu1IgQKwWEVQ5rr7iehJyLI7rjgk0pU8pUGYExlPXOtP3qvhz
         QTD5Kyy0AlgUf4ArMYU7aOq/c6wwC1Yn5jMtYf9DIYfLdHeOcSusaNdR9jEsRZOwIwxu
         hsqlpqpVGoSxCbOW86S3li2/821fdmNF55u2eS/4gytqa+UfTn+C62+nAW+vHyuquUB6
         5AhQB9PHRYp+7BTVETecPtJka1f1TIlRtxsNVURnYjGu5P+iPd/E26EaEIganuJlLduL
         MUuw==
X-Forwarded-Encrypted: i=1; AJvYcCWXFSj6JTzIC2j9PnOF+Ybl2M/vrk7arquMxiyy5fbFmF8vKWOy+/b/b7jAtWMzhdozJwOBF6iFsnTfRZ5VrBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwIRhGOMChiRwk/4foixP8V8QYKWKa5aRvi7PzSYlHbnVSDpE
	xz0/8Z7gEAn0gkUiPiLLlcaA2UTSy4c5hQvfqIx1b6m0HnLPTtiRdaBWWCmg9g==
X-Gm-Gg: ASbGncsYzMn+AwDsapKkqm3ABOjTQyJT2wX+YK9c7kAlTlUyN+rlxCxEcUMXVrZfoOM
	4yDgHFtnrR5iaK8rP80IXsbJ0O/FeK4F/m3eqrdv+U82JcQbsRzwiCwe3p/OZAqVnlNR5GwEjW/
	9oTfPwapPuI8BCX0DGWYOVBU1m9SRLzOSVvUm8ogTjkV0ExrKB3xop9w+GrRoP+S//at6S/kzZg
	xkEouSclRb/ZoVbaaMXNUdIPK1DoV0DIFWNTnWO38wxtFErBNvi60xsm/6Yr/+yGmaQgyrbaYo8
	K4Ir48jhZ3+GUJ7WsK8WgXS6xq6damX79o2q0d/n6gEBTjQvMfYPz5XTaSzRVzxxFxPUmzLA
X-Google-Smtp-Source: AGHT+IH/V/T2eUYQJIXG2EPtw/1cOV7MQT9tuyQOLSioTulIDCv1mtnsV9bjGKGjf9rlwz1NRxgL8g==
X-Received: by 2002:a17:902:e786:b0:216:201e:1b63 with SMTP id d9443c01a7336-22de85f23admr2173255ad.11.1745930418710;
        Tue, 29 Apr 2025 05:40:18 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25acd2fcsm10065488b3a.179.2025.04.29.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 05:40:18 -0700 (PDT)
Date: Tue, 29 Apr 2025 12:40:07 +0000
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
Subject: Re: [PATCH v2 11/22] iommufd: Add for-driver helpers
 iommufd_vcmdq_depend/undepend()
Message-ID: <aBDIpz7w8wxIn_AF@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:06PM -0700, Nicolin Chen wrote:
> NVIDIA Virtual Command Queue is one of the iommufd users exposing vIOMMU
> features to user space VMs. Its hardware has a strict rule when mapping
> and unmapping multiple global CMDQVs to/from a VM-owned VINTF, requiring
> mappings in ascending order and unmappings in descending order.
> 
> The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
> allocation handler, however it can't do the same for an unmapping since
> the destroy op returns void.
> 
> Add iommufd_vcmdq_depend/undepend() for-driver helpers, allowing LVCMDQ
> allocator to refcount_inc() a sibling LVCMDQ object and LVCMDQ destroyer
> to refcount_dec().
> 
> This is a bit of compromise, because a driver might end up with abusing
> the API that deadlocks the objects. So restrict the API to a dependency
> between two driver-allocated objects of the same type, as iommufd would
> unlikely build any core-level dependency in this case.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h        | 47 ++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommufd/driver.c | 28 ++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index e91381aaec5a..5dff154e8ce1 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -232,6 +232,10 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
>  					     size_t size,
>  					     enum iommufd_object_type type);
>  void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
> +int iommufd_object_depend(struct iommufd_object *obj_dependent,
> +			  struct iommufd_object *obj_depended);
> +void iommufd_object_undepend(struct iommufd_object *obj_dependent,
> +			     struct iommufd_object *obj_depended);
>  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>  				       unsigned long vdev_id);
>  int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
> @@ -252,6 +256,17 @@ static inline void iommufd_object_abort(struct iommufd_ctx *ictx,
>  {
>  }
>  
> +static inline int iommufd_object_depend(struct iommufd_object *obj_dependent,
> +					struct iommufd_object *obj_depended)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommufd_object_undepend(struct iommufd_object *obj_dependent,
> +					   struct iommufd_object *obj_depended)
> +{
> +}
> +
>  static inline struct device *
>  iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
>  {
> @@ -329,4 +344,36 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
>  		static_assert(offsetof(typeof(*drv_struct), member.obj) == 0); \
>  		iommufd_object_abort(ictx, &drv_struct->member.obj);           \
>  	})
> +
> +/*
> + * Helpers for IOMMU driver to build/destroy a dependency between two sibling
> + * structures created by one of the allocators above
> + */
> +#define iommufd_vcmdq_depend(vcmdq_dependent, vcmdq_depended, member)          \
> +	({                                                                     \
> +		static_assert(__same_type(struct iommufd_object,               \
> +					  vcmdq_dependent->member.obj));       \
> +		static_assert(offsetof(typeof(*vcmdq_dependent),               \
> +					      member.obj) == 0);               \
> +		static_assert(__same_type(struct iommufd_object,               \
> +					  vcmdq_depended->member.obj));        \
> +		static_assert(offsetof(typeof(*vcmdq_depended),                \
> +					      member.obj) == 0);               \
> +		iommufd_object_depend(&vcmdq_dependent->member.obj,            \
> +				      &vcmdq_depended->member.obj);            \
> +	})
> +
> +#define iommufd_vcmdq_undepend(vcmdq_dependent, vcmdq_depended, member)        \
> +	({                                                                     \
> +		static_assert(__same_type(struct iommufd_object,               \
> +					  vcmdq_dependent->member.obj));       \
> +		static_assert(offsetof(typeof(*vcmdq_dependent),               \
> +					      member.obj) == 0);               \
> +		static_assert(__same_type(struct iommufd_object,               \
> +					  vcmdq_depended->member.obj));        \
> +		static_assert(offsetof(typeof(*vcmdq_depended),                \
> +					      member.obj) == 0);               \
> +		iommufd_object_undepend(&vcmdq_dependent->member.obj,          \
> +					&vcmdq_depended->member.obj);          \
> +	})
>  #endif
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index 7980a09761c2..fb7f8fe40f95 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -50,6 +50,34 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_object_abort, "IOMMUFD");
>  
> +/* A per-structure helper is available in include/linux/iommufd.h */
> +int iommufd_object_depend(struct iommufd_object *obj_dependent,
> +			  struct iommufd_object *obj_depended)
> +{
> +	/* Reject self dependency that dead locks */
> +	if (obj_dependent == obj_depended)
> +		return -EINVAL;
> +	/* Only support dependency between two objects of the same type */
> +	if (obj_dependent->type != obj_depended->type)
> +		return -EINVAL;
> +
> +	refcount_inc(&obj_depended->users);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_object_depend, "IOMMUFD");
> +
> +/* A per-structure helper is available in include/linux/iommufd.h */
> +void iommufd_object_undepend(struct iommufd_object *obj_dependent,
> +			     struct iommufd_object *obj_depended)
> +{
> +	if (WARN_ON_ONCE(obj_dependent == obj_depended ||
> +			 obj_dependent->type != obj_depended->type))
> +		return;
> +
> +	refcount_dec(&obj_depended->users);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_object_undepend, "IOMMUFD");
> +
>  /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
>  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>  				       unsigned long vdev_id)

If I'm getting this right, I think we are setting up dependencies like:
vcmdq[2] -> vcmdq[1] -> vcmdq[0] based on refcounts of each object,
which ensures that the unmaps happen in descending order..

If that's right, Is it fair to have iommufd_vcmdq_depend/undepend in the
core code itself? Since it's a driver-level limitation, I think we
should just have iommufd_object_depend/undepend in the core code and the
iommufd_vcmdq_depend/undepend can move into the CMDQV driver?

> -- 
> 2.43.0
> 

Thanks,
Praan

