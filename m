Return-Path: <linux-kselftest+bounces-131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CAD7EC431
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 14:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719F21C209F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C0C1EB5B;
	Wed, 15 Nov 2023 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fxE5AZTq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F171EB3C
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 13:58:10 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2A7B3
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 05:58:08 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-421ae930545so35647571cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 05:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700056687; x=1700661487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KL+XKeTm+HS5yIv1+qB2Kl+EdYaEuM6uxRpozUNk15w=;
        b=fxE5AZTqZNA1c3pM8PnL1ZfVKuwJpxUheldfHGEsWEtAp2gEVDDCk/sQbeVIYFoPxf
         9KGVuG2GTZ61BFzp6iB80uFJEEgO+3AcP74J0XslGkuiEeomjUVANK79vYcLWKYP4xyS
         2LgGCbLrvB/pQw6jo94DnBTy0KASnx4Dq0zcgzgTmGzfAnIu0l+CQa08/nM1FfDi0klD
         8lmM/ZtEAne1zy4g4j5vifdPvxi4iYwH78y+Shm8tYEYEiDWLvvK/1pfqtmYfrkpgLuW
         6zdCfOmRw/hQ9xXIzXdRA9MhRyYweUY7Gf/m2FFpFEx2vzp/qthF0gtt7XlhbzRn9XZi
         zq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700056687; x=1700661487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL+XKeTm+HS5yIv1+qB2Kl+EdYaEuM6uxRpozUNk15w=;
        b=swhLkBxbnVb/2nXBg7+Y2bWgX56dpYBH6iZpQuEr413Wg0ta5PFK2lWHBqGLTFtX7J
         Ecs+CkwKYsDnIJ1qML3NUtVc4Jqs5Wc916YNz/PCqdLaypH+wv39ZnMsFaaEIDC9tUBP
         uj6/EHlraFp2t9QY08B6vOutEsu6abmdSJ1S5Y4kqubwXrG5wT2ZCV77Fi7XagMlj+K6
         rd1B0RN+9Zx6eoxi1/fxRRE0J4O2NLIK0uBVLzfPi4np35InYRtjBY9Xra48UBA0eZpy
         pRfF+BtYCzB5D4DxJxJyxJhoJu0Wt918p+UMNtEo0wnRxTjuAIInHtvfuKnp6vLLt2Nz
         6D/A==
X-Gm-Message-State: AOJu0Yxomv+wqsFxfXvninglFXXWxRGMuAOYGYXuOPAlsIqqC8/IwGE2
	lhKzTFqTEQZErayxu6IBGURgfA==
X-Google-Smtp-Source: AGHT+IHaKxJpp001exVovZ4EBDqBHs310q9gAHegSv6c6n8XW7Wb8GybvCcKXWJGvY9i5/iI45wjWw==
X-Received: by 2002:ac8:5dd4:0:b0:421:f8d8:e0d8 with SMTP id e20-20020ac85dd4000000b00421f8d8e0d8mr1428187qtx.38.1700056687165;
        Wed, 15 Nov 2023 05:58:07 -0800 (PST)
Received: from ziepe.ca ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id d22-20020ac86696000000b0041818df8a0dsm3553547qtp.36.2023.11.15.05.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:58:06 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r3GP8-0007bi-2i;
	Wed, 15 Nov 2023 09:58:06 -0400
Date: Wed, 15 Nov 2023 09:58:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZVTObiybC1MYlSam@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>

On Wed, Nov 15, 2023 at 01:17:06PM +0800, Liu, Jing2 wrote:

> This is the right way to approach it,
> 
>    I learned that there was discussion about using io_uring to get the
>    page fault without
> 
>    eventfd notification in [1], and I am new at io_uring and studying the
>    man page of
> 
>    liburing, but there're questions in my mind on how can QEMU get the
>    coming page fault
> 
>    with a good performance.
> 
>    Since both QEMU and Kernel don't know when comes faults, after QEMU
>    submits one
> 
>    read task to io_uring, we want kernel pending until fault comes. While
>    based on
> 
>    hwpt_fault_fops_read() in [patch v2 4/6], it just returns 0 since
>    there's now no fault,
> 
>    thus this round of read completes to CQ but it's not what we want. So
>    I'm wondering
> 
>    how kernel pending on the read until fault comes. Does fops callback
>    need special work to

Implement a fops with poll support that triggers when a new event is
pushed and everything will be fine. There are many examples in the
kernel. The ones in the mlx5 vfio driver spring to mind as a scheme I
recently looked at.

Jason

