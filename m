Return-Path: <linux-kselftest+bounces-1371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A26808E71
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 18:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071712811DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC69D48CD3;
	Thu,  7 Dec 2023 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nxMBn2YA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E8510FC
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 09:17:44 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-425952708afso3773371cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701969463; x=1702574263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfZC4BeoCbD48i78H7pAT4Ky0OQzCC++X2uJD5yU/sg=;
        b=nxMBn2YApW5VEL1MlNnGJIIFFeWsB1ZObn77HSaA1tECBRwhpmyLiqy+OaQKS4kkQi
         pNEUeAeKBL2cqAoU4e0QjqghnX+yT8cqh/wXggRvd+EnQBzXGGvb9wUopLfVYz8ITP2C
         iKOzSu7zD4lq/oJlR8w1YwmhUIN1s8MODf81OSnttn2MO9qmOYa8j5xgGFCVZaiTN1xU
         MWhLtcXCHMr5vqa8d5M5csX7ok7z19GKdFxr6FS8Rd480ftPynXrgDcrDz9wln6Vtahv
         7LkIuUQIxVZ9mWx2hL+p4/AK2Po6sO7zlLhMoe2s48WaOEL+m9a9Lljf/2dWRUu0HTDZ
         nsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969463; x=1702574263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfZC4BeoCbD48i78H7pAT4Ky0OQzCC++X2uJD5yU/sg=;
        b=vPW2HWikc5yaHNjVUi4wJcfMZMFEm8h/93YU8SEZhIqECthIGKS2HW+jn3xJW2uoDa
         aIXQme/Ufa5AkdsBfDmLANiu8DOl/F/ruaNk5CQv/xuj1sOORhbNwacOCT/gx3p5jrKk
         timmkt+MeJNGoSNSZeg0MqrnrtnXsKc1V55zijrOybHRCmEwxyFdFH+kt0HUyW/fQG8m
         cRI1cXb/UFlZrv9P2OUSHF2HPEcIhJGOA2mYaywuB1pEwhYHshos4//rgpf+4WsRvWea
         AbL1niMiBVbOtaKD2W9SQ3136lcC21oww2pgXbNVsWMT7e1TqbldSu98OEO57jeNuwOL
         xywg==
X-Gm-Message-State: AOJu0Ywvq1oOPMQuGOT6+iU/WW5dxxpW60VgJ8xOfu/lxGY8MQ9h4IP7
	x3ddd3sdkrWCnQQyKQZo1nDFQw==
X-Google-Smtp-Source: AGHT+IFZla2NtPfquQTzU6hdOuHOkG1umIFAlj7i5uyx6faPcX4R7PtWVD+lIF+qCRz3hijffJ+Kvg==
X-Received: by 2002:ac8:4e83:0:b0:423:e097:3b14 with SMTP id 3-20020ac84e83000000b00423e0973b14mr6734973qtp.10.1701969463718;
        Thu, 07 Dec 2023 09:17:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id n2-20020a0cec42000000b0067a10672b80sm66393qvq.48.2023.12.07.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:17:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rBI0M-00C1FU-8T;
	Thu, 07 Dec 2023 13:17:42 -0400
Date: Thu, 7 Dec 2023 13:17:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231207171742.GU1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207163410.ap3w4faii6wkgwed@localhost>

On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
> > @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
> >  	WARN_ON(!list_empty(&fault->deliver));
> >  	WARN_ON(!list_empty(&fault->response));
> >  
> > +	fput(fault->fault_file);
> > +	put_unused_fd(fault->fault_fd);

> I have resolved this in a naive way by just not calling the
> put_unused_fd function.

That is correct.

put_unused_fd() should only be called on error paths prior to the
syscall return.

The design of a FD must follow this pattern

 syscall():
   fdno = get_unused_fd_flags(O_CLOEXEC);
   filep = [..]
 
   // syscall MUST succeed after this statement:
   fd_install(fdno, filep);
   return 0;

  err:
    put_unused_fd(fdno)
    return -ERRNO

Also the refcounting looks a little strange, the filep reference is
consumed by fd_install, so what is that fput pairing with in fault_free?

Jason

