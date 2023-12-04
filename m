Return-Path: <linux-kselftest+bounces-1072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1258038E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 16:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D97281173
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA12C857;
	Mon,  4 Dec 2023 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="altJvCMF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE1B6
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 07:32:11 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-42548f6c565so18476841cf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Dec 2023 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701703931; x=1702308731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QNErOhF1qMkgPNVpHAnyVSyCwAUX/1YSBmZDFvsm8OU=;
        b=altJvCMFqLnz0th385qoKkCef9KpcoT97a66K2T11evxL+qQgeN04sZF2sJciPhIxa
         MTCpLAlzXQ/Et3m8eJlcuazUcWUcPNwH0ennEkeVk1j/pe55zuDf4BAdLOYazfOsm/ul
         6jWn5e7ZlaEMc+SMDee03zgbkmhj7ScXWJj83JUVDYdKDCHtDxCdzZBFbB061egcWZT1
         qlYYWu+paNhGEAf6akyznZHBoEUZgESyjTDVFcJYgBtmRDRCBjy9/DLfwjCpeZZKTPT6
         OOxQOSIzAcCJOINEVcKdvFNrhOLXwom8QBrCJ3e8yNm8jfNxfqC+SGJ4O+Dc00TtsKnK
         6VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701703931; x=1702308731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNErOhF1qMkgPNVpHAnyVSyCwAUX/1YSBmZDFvsm8OU=;
        b=lXjh7+vFiQ20kX00MRX4mUYgRKxp9sh7BpoFWaJIqzole3M24wcQJtPKCeyhXBcGQr
         8iNY8W5mlwbOHBN3yi/HZwCqvAghWCA073Jp4BsQivZI6kQwp5/ewMDAMkDsZ5GB257v
         0Msu4pkb4fTkM9rU96qH3paU/D0LWzwwCNebiXOiRHSPV+fnuYSWU2nvPwOFWUMp+4Nh
         aW4sAyz1VbnRHeU72K5D/j3pWmu3ZOIgpqp9eD8o7anywU7iKtR/Rc9a019/z6YB+D9O
         WNXkfWfG3NvRByLhg6ljxAxJRq4K/BaN2JE4e/hvNw2WEwtuYXl95gO6AodoNym2ga6C
         FXVQ==
X-Gm-Message-State: AOJu0YwEJQMIQacKr8ZIGg8R3eevzVi3sljy9EjbAOuMk5ZZ3Q6pgC8L
	wPPCdKNt53uvWZbGi3OU690vow==
X-Google-Smtp-Source: AGHT+IEnloh+umt8D2CaTqj/3erJ8LZq5gKurAnArFiVByvdfAGoIgyiu/VWyqqDTZ8kj1dh4ApCGQ==
X-Received: by 2002:a05:622a:1c8:b0:425:4043:96e2 with SMTP id t8-20020a05622a01c800b00425404396e2mr6614490qtw.111.1701703930810;
        Mon, 04 Dec 2023 07:32:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id df15-20020a05622a0ecf00b00423da75b0f4sm4371928qtb.71.2023.12.04.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:32:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rAAvZ-00B2r2-ML;
	Mon, 04 Dec 2023 11:32:09 -0400
Date: Mon, 4 Dec 2023 11:32:09 -0400
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
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231204153209.GN1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a@eucas1p2.samsung.com>
 <20231204150744.db3hfpq4v55cuavn@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204150744.db3hfpq4v55cuavn@localhost>

On Mon, Dec 04, 2023 at 04:07:44PM +0100, Joel Granados wrote:
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > Hi folks,
> > 
> > This series implements the functionality of delivering IO page faults to
> > user space through the IOMMUFD framework for nested translation. Nested
> Does this mean the IOPF_CAPABLE HWPT needs to be parented by a HWPT
> created with IOMMU_HWPT_ALLOC_NEST_PARENT set?

I would expect no. Both a nested and un-nested configuration should
work.

Jason

