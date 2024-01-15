Return-Path: <linux-kselftest+bounces-3014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3845682DEBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 18:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B0C2833E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 17:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2546F18059;
	Mon, 15 Jan 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ILZGkR44"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE781804E
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7831362c9bcso729626585a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705341540; x=1705946340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wGaOr22tAz8ZsKDr+cBOsYsgD9Gp6tmTN5qVEUIqRw=;
        b=ILZGkR44NdOor92BDo3h2CNCw9AGUff2VFZN4safD0dL1Y6fqJBwGRcgfTsn0upGDf
         XOypfW1xsJK4BuNPD4oyusXyNSRXMsnMVB5hQWonegGg8IHJsDFPaoO2HtA/TlIPInMA
         zc+2Z1GCc+bhuIFSPITTPsPS8Yzma0qsDyT5IGl7uq+oE8tuJXBz/7rnNqnpyR6ImYt5
         4lmk25EL0dJ8v7JO7PwbsOHtqi9LMTzoxzsOPg4Ao8QfQMp94EkDAVaHGCCU8aitXqDn
         0cOBsqJ20RmhgCqFGo/QksyCT0lEKKOqQp0WHGvnbxZagB/bfltJyiF420khfBiPhFj8
         Ylsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705341540; x=1705946340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wGaOr22tAz8ZsKDr+cBOsYsgD9Gp6tmTN5qVEUIqRw=;
        b=gfTEJ4mVGBe7ICbQQnRw8PDjzp4odRuiDNyr10wXLM1cbWSGiZCn/Ju3YU1A3Q5kAE
         TDG0+lljcuLrvQmruz8mX8fTxjCk3AzrSX3eagSdvAqWEON1g5TK6uRI5+0eeQvgUMgZ
         I2f9+hkRgM+1h918vzawEJX0p/IMFPHLkzGQXBsNUmuNAuuErd5o+Bqchzg+54avbVdQ
         Vid8nJWzysRBMqkQwU8x2rwoW7A3odjzxM5F378VlGLJiUg6sHjzOKCa2+ngZSEkMu6/
         r5Ir53P9bpOiW9RsgNihqOjkikKIid4kOhq/Cco5Xh7qnyroB9pDBdldzwjK+ONb/WRs
         AN0A==
X-Gm-Message-State: AOJu0YwwCR6EpMhrhDVEpqLQbnShJ7qmlXxNjOxQajuEXLSIbEvg6VkC
	+b7cPA96ouJyWcQlc8XlRGf+uLxcM4LBPA==
X-Google-Smtp-Source: AGHT+IH3qvjmHpS/20mUo+xR0imhTBslJ6twopYzo9p1d1flQYlhOLrwJcWYbmGWgldNtbhvIF7Uzw==
X-Received: by 2002:a05:6214:518c:b0:67f:d236:5c0f with SMTP id kl12-20020a056214518c00b0067fd2365c0fmr7596556qvb.90.1705341540583;
        Mon, 15 Jan 2024 09:59:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d10-20020a0cfe8a000000b0067f454b5307sm3452291qvs.108.2024.01.15.09.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:59:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPREh-003u0V-Kj;
	Mon, 15 Jan 2024 13:58:59 -0400
Date: Mon, 15 Jan 2024 13:58:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20240115175859.GC50608@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <b822096cc3b441309d99832c587be25a@huawei.com>
 <20240115164723.GB50608@ziepe.ca>
 <b1663110e1ca4301834f403270357bea@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1663110e1ca4301834f403270357bea@huawei.com>

On Mon, Jan 15, 2024 at 05:44:13PM +0000, Shameerali Kolothum Thodi wrote:

> > If it is valid when userspace does read() then it should be valid when
> > userspace does write() too.
> > 
> > It is the only way the kernel can actually match request and response
> > here.
> 
> The kernel currently checks the pasid only if IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID
> is set.
> 
> https://lore.kernel.org/linux-iommu/20200616144712.748818-1-jean-philippe@linaro.org/
> 
> > So, I think you have a userspace issue to not provide the right
> > pasid??
> 
> This is not just ARM stall resume case, but for some PCI devices as well as per
> the above commit log. So do we really need to track this in userspace ?

Yes, these weird HW details should not leak into userspace.

The PASID is required on the read() side, userspace should provide it
on the write() side. It is trivial for it to do, there is no reason to
accommodate anything else.

Alternatively I'm wondering if we should supply a serial number to
userspace so it can match the request/response instead of relying on
guessing based on pasid/grpid?

Jason

