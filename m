Return-Path: <linux-kselftest+bounces-46293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908EC7BF7A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 00:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 412814E158A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 23:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383930C607;
	Fri, 21 Nov 2025 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fuAS7cxQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4072F616C
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763769119; cv=none; b=FwOJcKtt07irxcTAUhojWQ6kjVnaa0rAXtW6fd/hZjMBd/bi0zQPDK1CEYJOsF/VadJmJWhs9XHF7Ao/O8BiLsw4DEvMEeYzmB3ipGSFTFNJ3DxMhJ8k6bm3WCD+OYng05Gx0BeuYjLJydCgOWZu6UQLDwVAUvPU/glyXOqxv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763769119; c=relaxed/simple;
	bh=qyIgkIWEPVtK3bvaf33iUXx+Lwkh8VwskyaNpGQA3FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKqTLi5sQdw/t9S/tH8xCY65w0Ub4einirbRcYmfdss4mQaNuO+bEBqolhjxWctopSOfWieHBuLIg2leZCXWebKXXAdBV3HCfHforUgc/H8VDuTaZh6vRwfZlGARhWPa25BXaYLj5fJVls+wl9m5YulFDUDVTX6XV/kMB2wTHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fuAS7cxQ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b22624bcdaso304287885a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 15:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763769115; x=1764373915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNFKsTnzS74A3YnRADAbN00lA3dVz8Z4Yjm0idBCQ+0=;
        b=fuAS7cxQFt9ywr+iq4PvAM3qLYHFzLSUoxH0IHWqVb7gqAXeEDXeiS6dfs25X9D90K
         aK976RMvnx2xdZAOkN8pUEAJnGRl+xRSne4FyJfk6GL+clZWBcgKyJiIFQjnB+DnLvlG
         Pcee2tC7/U89Eu/5F11PEXBEPN/ehPcX6SxVklI5o3tOg17JOZCTu93OxdHLQF0zmrUs
         4vAPeObxuh8SEPd6YHrKO7rS2AXr9LQ86KJCXOl8WFF9FpbsKPeAyEW7P+cEDp118VDq
         7djnXPq/uoxLE2PUMiUeOK4gLSkCwE07PmtGEKuusa1T09waM/+4PVaNKjcygk22SjpK
         cFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763769115; x=1764373915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNFKsTnzS74A3YnRADAbN00lA3dVz8Z4Yjm0idBCQ+0=;
        b=oZwKuRhMwvWUnrO8mbMr9q+lmAhkit9gjYQB6dJ+zIUD/3xX323usLAY+EUONHmqB+
         JxVKe8ycw4InC/ws+G4Zqq8seq21kjh0DTIMBY1JRkXe55tA/qzdXcxEDKA7ZqY4NJbK
         YmFj7I4PZi/sI33a4D8JrWByDhD9LJYltC25pigtkMOLnQ4ZRT9koufGixpEhDVumFs/
         hhlP5MptdoKFu4r8gpgTP5yLzEMplFzKsU+UWDu7QH6uMolHMzMOMHh3Xj5C30roIwHA
         yEbY3IhbVS9EfsXm7z4sefxacqQRrqzEp8UZDBeoDgbpLr8G4TBGi1iuc59p27rTIWJW
         QYIw==
X-Forwarded-Encrypted: i=1; AJvYcCWE/isrfjz3T3cGK4cBfrBraFsdyMsnhhiAR8qOKOhUxGtdrZurxoQ1g+66lHuS+sFMSpunfiqAO69GZsTtNm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8DiCrZNAP8v0VNnn+xCubO4KnpvXPy/w39hBtCFIcWSksbKk
	LDYzfLni9cn6UfcMRmGiQ16+FqGiA5KgcR2e7qTChTX7QglYARhkveKKfr12o2hVxY0fcGHvA4s
	r1K3l
X-Gm-Gg: ASbGncsXPHvIyjlARIFlTOfaCwfLimdtkqxc0/sXCqEZGgeNCTeC/f5MP763ZBCt1dL
	g3dTAmfaSX2GWYXK5DustAZsICL2TwpZIg3Al7s7629690xS7TNsPsKQ9TRjevaGLGnveFI3OA6
	P94mLK8ZQ0rPZ1NIflpXto2uND1Gq06J+L6Ivgd6/Pn9N3nEFRXHhuAfWXA6a6QI4QsGtS42/BN
	Ti53PxlPAGz9bLi8rkNe1T6qjaAvtYJv773sF7b4z/0NCC6sHhwZ7GK+VjqgrCbov+G5osLEoSJ
	xoZXf26M4rIs/zOrGe5ue/pyBpq6MCIK/jrPMW2Gbscl0GJnU5XzI4kA/es0v3+K/uAqMtjhxlL
	043fbjVZxW3+eYAksm8V98wEBXmPa3jsDxAmMb/b4hnZuyGllCTY9pU3qoCjpGOvC2zbU5nh1NN
	EiYsS3KsmWR+uc0Sbw3XZ8zUpCRm4AoAa9+jQm5XicHLitgbfj7fjKSKke
X-Google-Smtp-Source: AGHT+IFWPATCeCmWOiB88Xr2ysxytHvAaGgMnVOpuF76dOClmpd6DtTQfeYA8jncK9mJHMi6OC8ekA==
X-Received: by 2002:a05:620a:470d:b0:8b2:e666:713 with SMTP id af79cd13be357-8b33d476f8cmr539235785a.42.1763769115207;
        Fri, 21 Nov 2025 15:51:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db543sm457101985a.38.2025.11.21.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:51:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMauv-00000001bzu-1Ue0;
	Fri, 21 Nov 2025 19:51:53 -0400
Date: Fri, 21 Nov 2025 19:51:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/iommu: Fix array-bounds warning in get_hw_info
Message-ID: <20251121235153.GK233636@ziepe.ca>
References: <20251113200854.429515-2-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113200854.429515-2-nirbhay.lkd@gmail.com>

On Fri, Nov 14, 2025 at 01:38:55AM +0530, Nirbhay Sharma wrote:
> GCC warns about potential out-of-bounds access when the test provides
> a buffer smaller than struct iommu_test_hw_info:
> 
> iommufd_utils.h:817:37: warning: array subscript 'struct
> iommu_test_hw_info[0]' is partly outside array bounds of 'struct
> iommu_test_hw_info_buffer_smaller[1]'
> [-Warray-bounds=]
>   817 |                         assert(!info->flags);
>       |                                 ~~~~^~~~~~~
> 
> The warning occurs because 'info' is cast to a pointer to the full
> 8-byte struct at the top of the function, but the buffer_smaller test
> case passes only a 4-byte buffer. While the code correctly checks
> data_len before accessing each field, GCC's flow analysis with inlining
> doesn't recognize that the size check protects the access.
> 
> Fix this by accessing fields through appropriately-typed pointers that
> match the actual field sizes (__u32), declared only after the bounds
> check. This makes the relationship between the size check and memory
> access explicit to the compiler.
> 
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 9f472c20c190..37c1b994008c 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -770,7 +770,6 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
>  				 void *data, size_t data_len,
>  				 uint32_t *capabilities, uint8_t *max_pasid)
>  {
> -	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
>  	struct iommu_hw_info cmd = {
>  		.size = sizeof(cmd),
>  		.dev_id = device_id,
> @@ -810,11 +809,19 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
>  		}
>  	}
>  
> -	if (info) {
> -		if (data_len >= offsetofend(struct iommu_test_hw_info, test_reg))
> -			assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
> -		if (data_len >= offsetofend(struct iommu_test_hw_info, flags))
> -			assert(!info->flags);
> +	if (data) {
> +		if (data_len >= offsetofend(struct iommu_test_hw_info,
> +					    test_reg)) {
> +			__u32 *test_reg = (__u32 *)data + 1;

This seems too obfuscated, can't we keep the struct somehow and still
remove the warning?

I also feel like you have a compiler bug here, if gcc has inlined
enough to know the size of data then it surely should know the
constant value of data_len?

Failing that, how about just change the caller, maybe like this:

--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -760,6 +760,7 @@ TEST_F(iommufd_ioas, get_hw_info)
        } buffer_larger;
        struct iommu_test_hw_info_buffer_smaller {
                __u32 flags;
+               struct iommu_test_hw_info dummy;
        } buffer_smaller;
 
        if (self->device_id) {
@@ -791,9 +792,11 @@ TEST_F(iommufd_ioas, get_hw_info)
                 * Provide a user_buffer with size smaller than the exact size to check if
                 * the fields within the size range still gets updated.
                 */
-               test_cmd_get_hw_info(self->device_id,
-                                    IOMMU_HW_INFO_TYPE_DEFAULT,
-                                    &buffer_smaller, sizeof(buffer_smaller));
+               test_cmd_get_hw_info(
+                       self->device_id, IOMMU_HW_INFO_TYPE_DEFAULT,
+                       &buffer_smaller,
+                       offsetofend(struct iommu_test_hw_info_buffer_smaller,
+                                   flags));
                test_cmd_get_hw_info_pasid(self->device_id, &max_pasid);
                ASSERT_EQ(0, max_pasid);
                if (variant->pasid_capable) {

Jason

