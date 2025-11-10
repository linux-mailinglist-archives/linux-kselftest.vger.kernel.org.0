Return-Path: <linux-kselftest+bounces-45271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6907C49A8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9651B1889DD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55A2FBDE1;
	Mon, 10 Nov 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Js2CGMC2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD32D8DD0
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815251; cv=none; b=DVKSKO/CrHHZoQOb5ziAg7WZk/R8Y9U3TZHM00jcgCFme31MK2yebEeqmVZdjqOYoz34t2GWMesQhdA3SYFBbP4lT0Yf+Iyj1VKs7qtul41hJoBQVKHyrClH8AWiRfncGK/kSwN5Na49pI8GNqVNCKFjOcd9N6es4ALiIP4jY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815251; c=relaxed/simple;
	bh=mK+fSh/Yc5eOCDCkfyEsx79tNEU9q1FMyc5S01jpivU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azx97rx20ByJ6urFoLJIIkk3yB92UNoaNdlwkCpuqCuiwcSQxXUAIIXIGtM94CxXv+dQHAFQyrUZfM4KiwOI1yF+qtLSqWQwLMMedkQzODjRWIZQYiuUB2ZRS10Uozmic4gYQrwfZagBLp2a3yq4amBor/ttrbAo6L84u9Xygp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Js2CGMC2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso2973427b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 14:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762815249; x=1763420049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+VX1zphnZ/zMOL9kv7NerQkODWHjabw8KtnTmCUCZ1s=;
        b=Js2CGMC2yKnVg6TDM6Fqr0b3FwYo+ChMxHFgOovsCzw1xMgT8d/ovA5YcJqP3fd5Cs
         vDWWT8Z5KCwW7Oz90m1LgHPOYMpNZ3GTvEipDCcKbKzeQXQY0+z6nKa3JAik6ffH776e
         yPFdK0LI/e+WOfC0nF+w3c8ATfyyg1J3DUVTyOqLyNZhoW7n3R12ZSDyYFLpeY5DRM6K
         xRbl3e9uUtjDVOs1Ctj9drqkX7RdzAA++V+pei6uAjGOjTr206ZB91Fe4hgtLPWTBJFh
         9o56VVaieM6RZ+SamGGAU4fYrC7bF7+EH8Bfekv4YgWFikA4UbBZm0UCXEFXVS1UvuiU
         HpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762815249; x=1763420049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VX1zphnZ/zMOL9kv7NerQkODWHjabw8KtnTmCUCZ1s=;
        b=V9hHQ3kLKTKXlc06TVKdKURpbVgkz4W83rsJNaoCKSepxvWDWmoiq6DZWp/N+Czn/A
         gXDA3EFGcH6G4+XAh8fHo8/G3ectKjnSaszl+9fljFkmslyro+YnjtPxwUYdbhI1iTyW
         bkCd1pePgyClZTbfeJ7fmzIF3W5BtLNwR9kDRzu/ztXQ/nV4Pf4opah63U/KaazZBx/I
         vI/UvrU2DXttNT463B3HYAaGIKuKnNR0cjWzplFv5W6eHXvpX2lwQv0xfn9NLDiLzb0A
         J7jTCjNASwJ0EaeK2XrquKzxWafx5r9JxmAjEtTLTnZV92N5ynTX5J1yJo4hEWVJ0Kh9
         KFTg==
X-Forwarded-Encrypted: i=1; AJvYcCWFcP+ISxFSxJQWPChcYFUo9W6ZGK06ADn9z6aTbsoALrISP13lQfqAP18ulIGN6hjcNz9oX4GxizZzaOifdVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCcmVQ5P/fZjOeFP/Cgb6MybtWBZOfSlzvipBrO18fTAKfLJ5
	txllkIDABbxqn93GtMUI/3fMJcqvJyXL4xrIaE2a9QnTpSryhglGM2PtXpDMlUXo2Q==
X-Gm-Gg: ASbGncsQ9P57UYo8XcptXdlW9y2JKVSZQ/qoraG4ZYLiRhRaG2yfVnuLnS4g1TtYhPA
	EijBd87V7ilGlgquJabYz7J4r4h5j0vvB9UpuB3wgsH5blaDKRe3EfrI7bQ0lqdhFY8FKgI9FsK
	9anhsEBcDAKzNjMe5FHeJxap2jZkPP9GWrvuKyDGIBaM/v/GAFfgBnq1zBUrojFTQG1bOKVLKGZ
	fd5e/rer5Kh1gaJBzIiosGuIpEedVuErrScJgHA9sPXr2wWlF77fkGux0533Q9/Q6v06cByKKXs
	AX6sxZG4OTs0V85uAUv+xYMKvUFFZIATHfHZwf0ido2Wdqf1a0JnXuvZbREX769cMoAHbSETwz8
	DpRNPizQajEDrtGTnfEYrPjqU7drw5gW5aX4MHwDQtHpGRZ26GVETfKvycMfISszJf1gXzcdl55
	1drkQqc2GjrmoaHB8cgOp3OT7kVQ/aofy5mqjlr6G9eT9g40lePzU3
X-Google-Smtp-Source: AGHT+IHDKP6DixwXgQe+3gJY+N21SMec1QGPnnrV7i41y0UjnEeEqkVpXmY7sguGQFufmZEQYM7P7w==
X-Received: by 2002:a05:6a21:3286:b0:34f:d380:5f2b with SMTP id adf61e73a8af0-353a18e5b2emr13557425637.17.1762815248813;
        Mon, 10 Nov 2025 14:54:08 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff8538sm13061183b3a.28.2025.11.10.14.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:54:08 -0800 (PST)
Date: Mon, 10 Nov 2025 22:54:04 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/4] vfio: selftests: add iova allocator
Message-ID: <aRJtDHJZ6yAW2xIj@google.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
 <20251110-iova-ranges-v1-3-4d441cf5bf6d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-iova-ranges-v1-3-4d441cf5bf6d@fb.com>

On 2025-11-10 01:10 PM, Alex Mastro wrote:
> Add struct iova_allocator, which gives tests a convenient way to generate
> legally-accessible IOVAs to map.
> 
> This is based on Alex Williamson's patch series for adding an IOVA
> allocator [1].
> 
> [1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
>  .../testing/selftests/vfio/lib/include/vfio_util.h | 14 +++++
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 65 +++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> index fb5efec52316..bb1e7d39dfb9 100644
> --- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
> +++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> @@ -13,6 +13,8 @@
>  
>  #include "../../../kselftest.h"
>  
> +#define ALIGN(x, a)	(((x) + (a - 1)) & (~((a) - 1)))

Please name this ALIGN_UP() so that it is clear it aligns x up and not
down.

> +
>  #define VFIO_LOG_AND_EXIT(...) do {		\
>  	fprintf(stderr, "  " __VA_ARGS__);	\
>  	fprintf(stderr, "\n");			\
> @@ -188,6 +190,13 @@ struct vfio_pci_device {
>  	struct vfio_pci_driver driver;
>  };
>  
> +struct iova_allocator {
> +	struct iommu_iova_range *ranges;
> +	size_t nranges;
> +	size_t range_idx;
> +	iova_t iova_next;
> +};
> +
>  /*
>   * Return the BDF string of the device that the test should use.
>   *
> @@ -212,6 +221,11 @@ void vfio_pci_device_reset(struct vfio_pci_device *device);
>  struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
>  					      size_t *nranges);
>  
> +int iova_allocator_init(struct vfio_pci_device *device,
> +			    struct iova_allocator *allocator);
> +void iova_allocator_deinit(struct iova_allocator *allocator);
> +iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
> +
>  int __vfio_pci_dma_map(struct vfio_pci_device *device,
>  		       struct vfio_dma_region *region);
>  int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 6bedbe65f0a1..a634feb1d378 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -12,11 +12,12 @@
>  #include <sys/mman.h>
>  
>  #include <uapi/linux/types.h>
> +#include <linux/iommufd.h>
>  #include <linux/limits.h>
>  #include <linux/mman.h>
> +#include <linux/overflow.h>
>  #include <linux/types.h>
>  #include <linux/vfio.h>
> -#include <linux/iommufd.h>
>  
>  #include "../../../kselftest.h"
>  #include <vfio_util.h>
> @@ -190,6 +191,68 @@ struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
>  	return ranges;
>  }
>  
> +int iova_allocator_init(struct vfio_pci_device *device,
> +			struct iova_allocator *allocator)
> +{
> +	struct iommu_iova_range *ranges;
> +	size_t nranges;
> +
> +	memset(allocator, 0, sizeof(*allocator));
> +
> +	ranges = vfio_pci_iova_ranges(device, &nranges);
> +	if (!ranges)
> +		return -ENOENT;
> +
> +	*allocator = (struct iova_allocator){
> +		.ranges = ranges,
> +		.nranges = nranges,
> +		.range_idx = 0,
> +		.iova_next = 0,
> +	};
> +
> +	return 0;
> +}
> +
> +void iova_allocator_deinit(struct iova_allocator *allocator)
> +{
> +	free(allocator->ranges);
> +}

I think it would be good to be consistent about how the library hands
out and initializes objects. e.g. For devices we have:

  device = vfio_pci_device_init(...);
  vfio_pci_device_cleanup(device);

So for allocator it would be:

  allocator = iova_allocator_init();
  iova_allocator_cleanup(allocator);

It's a small thing, but this way users of the library can always work
with pointers allocated by the library, there is a consistent meaning of
*_init() functions, and one doesn't have to distinguish between
*_deinit() and *_cleanup().

Forcing dynamic memory allocation is less efficient, but I think
simplicity and consistency matters more when it comes to tests.

> +
> +iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
> +{
> +	int idx = allocator->range_idx;
> +	struct iommu_iova_range *range = &allocator->ranges[idx];
> +
> +	VFIO_ASSERT_LT(idx, allocator->nranges, "IOVA allocator out of space\n");
> +	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> +	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");

ALIGN() is what requires size to be a power of 2, so the assert should
probably go inside that macro.

> +
> +	for (;;) {
> +		iova_t iova, last;
> +
> +		iova = ALIGN(allocator->iova_next, size);
> +
> +		if (iova < allocator->iova_next || iova > range->last ||
> +		    check_add_overflow(iova, size - 1, &last) ||
> +		    last > range->last) {
> +			allocator->range_idx = ++idx;
> +			VFIO_ASSERT_LT(idx, allocator->nranges,
> +				       "Out of ranges for allocation\n");
> +			allocator->iova_next = (++range)->start;
> +			continue;
> +		}
> +
> +		if (check_add_overflow(last, (iova_t)1, &allocator->iova_next) ||
> +		    allocator->iova_next > range->last) {
> +			allocator->range_idx = ++idx;
> +			if (idx < allocator->nranges)
> +				allocator->iova_next = (++range)->start;
> +		}
> +
> +		return iova;
> +	}

I found this loop a bit hard to read. The if statements have 3-4
statements, and idx and range are managed deep in the loop. What about
something like this? It also avoids the need to check for overflow
(unless I missed something :).

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index bb1e7d39dfb9..63fce0ffe287 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -193,8 +193,10 @@ struct vfio_pci_device {
 struct iova_allocator {
 	struct iommu_iova_range *ranges;
 	size_t nranges;
+
+	/* The next range, and offset within it, from which to allocate. */
 	size_t range_idx;
-	iova_t iova_next;
+	iova_t range_offset;
 };

 /*
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index a634feb1d378..5b85005c4544 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -207,7 +207,7 @@ int iova_allocator_init(struct vfio_pci_device *device,
 		.ranges = ranges,
 		.nranges = nranges,
 		.range_idx = 0,
-		.iova_next = 0,
+		.range_offset = 0,
 	};

 	return 0;
@@ -220,37 +220,41 @@ void iova_allocator_deinit(struct iova_allocator *allocator)

 iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
 {
-	int idx = allocator->range_idx;
-	struct iommu_iova_range *range = &allocator->ranges[idx];
+	int idx;

-	VFIO_ASSERT_LT(idx, allocator->nranges, "IOVA allocator out of space\n");
 	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
 	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");

-	for (;;) {
+	for (idx = allocator->range_idx; idx < allocator->nranges; idx++) {
+		struct iommu_iova_range *range = &allocator->ranges[idx];
 		iova_t iova, last;

-		iova = ALIGN(allocator->iova_next, size);
+		if (idx == allocator->range_idx)
+			iova = ALIGN(range->start + allocator->range_offset, size);
+		else
+			iova = ALIGN(range->start, size);

-		if (iova < allocator->iova_next || iova > range->last ||
-		    check_add_overflow(iova, size - 1, &last) ||
-		    last > range->last) {
-			allocator->range_idx = ++idx;
-			VFIO_ASSERT_LT(idx, allocator->nranges,
-				       "Out of ranges for allocation\n");
-			allocator->iova_next = (++range)->start;
+		if (range->last - iova + 1 < size)
 			continue;
-		}

-		if (check_add_overflow(last, (iova_t)1, &allocator->iova_next) ||
-		    allocator->iova_next > range->last) {
-			allocator->range_idx = ++idx;
-			if (idx < allocator->nranges)
-				allocator->iova_next = (++range)->start;
+		/*
+		 * Found a range to hold the allocation. Update the allocator
+		 * for the next allocation.
+		 */
+		last = iova + (size - 1);
+
+		if (last < range->last) {
+			allocator->range_idx = idx;
+			allocator->range_offset = last - range->start + 1;
+		} else {
+			allocator->range_idx = idx + 1;
+			allocator->range_offset = 0;
 		}

 		return iova;
 	}
+
+	VFIO_FAIL("Failed to iova range of size 0x%lx\n", size);
 }

 iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)

> +}
> +
>  iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
>  {
>  	struct vfio_dma_region *region;
> 
> -- 
> 2.47.3
> 

