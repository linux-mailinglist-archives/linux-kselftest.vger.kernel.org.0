Return-Path: <linux-kselftest+bounces-354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F647F2205
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 01:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B201C217F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 00:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090B17FB;
	Tue, 21 Nov 2023 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UOGvAkMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD385AB
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 16:14:54 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58a42c3cbb8so2838037eaf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700525694; x=1701130494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cM4nXDiFJOID9V8g8m4rSnX0D2eYIgzoLqQUP7X4x5w=;
        b=UOGvAkMzHSUdsL6VXs/dSpIWDQFNn3S7Ovaghpcz3SKOanJvWPiwH/Ec1KleH4CsPU
         hnCnm+6LNvzNIRiMbR+NnVoDlAOVbV0Rzrapyqk5tnU2XscX3psiwhMaGvNYnnQ4ur1V
         25tNQ0e1L5h40ej1tX4yKBOnKDx+vogOKG/Xhb8dEXglLx/olfQTNHgxP3OiG/2LtlMr
         ToyHsFK73VB7v4nyQLysCoRSsT2Zw/Yzmnw8yzgHssby01ENKcJQ+ENx2cv+7ia2wi4w
         aU9d9lSKWmJcPV06R4/lUXO6HwFlUipPNNtJHSi3b1w+/0x25lnuIoQOXWFqX90v2cc9
         RGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700525694; x=1701130494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM4nXDiFJOID9V8g8m4rSnX0D2eYIgzoLqQUP7X4x5w=;
        b=GnXlmRtc/hW2BYc6ExghKdTZK+/kurDIwwTn1HrhW8sE+3/QzsWIII52yCPmdCx7QR
         3HjAwcOZbnGI6Mg+6Tl2YGDaEzqXMq455bh7mFNc8yFwjEUJKKv7w8i17E45HJBb3ZZQ
         co0ikKaDxEtLN+NtKAcKL2CIQS0smm+uJ91rtp+bXOrQDze3X57NdE2EYV3VSY9LXWWG
         gpSP6hWWRRnhiTcFDVzvNXiUNb+pOtmt2Yrs+3b1oBPQBY5V1w63/1+Z6/b5dqJ4BBMc
         cR+XDueoRJo6y3DXiIYbCACH2iy/dzSGB/q3X/aqqs29VaXXnRIKqOEXrHvJNJ1PHJof
         YFSA==
X-Gm-Message-State: AOJu0YzIkiSU4unHLcNehwSFgd0O2geBmSTbU/nGnPq2tZv7h3bDu9ku
	r4m5cD/pQFic1g0/WY/pvO2Jyw==
X-Google-Smtp-Source: AGHT+IHCW/gnwvCFARN/IZLYIino35BqbfjASz8DDrzzSvjMWgTO3xenCZoSHE50H7LZjgQneLoOoA==
X-Received: by 2002:a05:6820:1628:b0:581:ed12:98c6 with SMTP id bb40-20020a056820162800b00581ed1298c6mr10069537oob.4.1700525694024;
        Mon, 20 Nov 2023 16:14:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id w9-20020a4aaf09000000b005840b5783a1sm1569061oon.43.2023.11.20.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:14:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r5EPk-0019u1-1E;
	Mon, 20 Nov 2023 20:14:52 -0400
Date: Mon, 20 Nov 2023 20:14:52 -0400
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
Message-ID: <20231121001452.GF10140@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
 <ZVTObiybC1MYlSam@ziepe.ca>
 <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f24918e-aa57-4160-902a-58d10021246e@linux.intel.com>

On Thu, Nov 16, 2023 at 09:42:23AM +0800, Liu, Jing2 wrote:
> Hi Jason,
> 
> On 11/15/2023 9:58 PM, Jason Gunthorpe wrote:
> > On Wed, Nov 15, 2023 at 01:17:06PM +0800, Liu, Jing2 wrote:
> > 
> > > This is the right way to approach it,
> > > 
> > >     I learned that there was discussion about using io_uring to get the
> > >     page fault without
> > > 
> > >     eventfd notification in [1], and I am new at io_uring and studying the
> > >     man page of
> > > 
> > >     liburing, but there're questions in my mind on how can QEMU get the
> > >     coming page fault
> > > 
> > >     with a good performance.
> > > 
> > >     Since both QEMU and Kernel don't know when comes faults, after QEMU
> > >     submits one
> > > 
> > >     read task to io_uring, we want kernel pending until fault comes. While
> > >     based on
> > > 
> > >     hwpt_fault_fops_read() in [patch v2 4/6], it just returns 0 since
> > >     there's now no fault,
> > > 
> > >     thus this round of read completes to CQ but it's not what we want. So
> > >     I'm wondering
> > > 
> > >     how kernel pending on the read until fault comes. Does fops callback
> > >     need special work to
> > Implement a fops with poll support that triggers when a new event is
> > pushed and everything will be fine.
> 
> Does userspace need also setup a POLL flag to let io_uring go into poll, or
> io_uring always try to poll?

io_uring can trigger poll and use other approaches, it is flexible the
driver can scale this in different ways.

Jason

