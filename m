Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35877E479E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjKGRyK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Nov 2023 12:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjKGRyJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Nov 2023 12:54:09 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CFF8F
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Nov 2023 09:54:07 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41e1921da84so37437211cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Nov 2023 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699379647; x=1699984447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FW0RbAVGUFb+xdBElnhNAHeQGgYiHAEYAyCOW53R3XU=;
        b=NVYzjpB2o11B3HYLoQlgJY/f94KtpDWJKcf8D8LrVddPiy3cpoyKX3aNwiVcJjvP7X
         0cIidQr+8Cz4ZQSDWLY8VGrxEOZgd45fZ+NsNoGvl1W+Ncq9bQbAY6ZoPDhsc3k1E0G2
         rr7kFDpsJrddm+sVvebFAZo9fNQkbGD8JplKfablwxT+bCJovhorOL+wVr6a6pGenSpH
         3jBloraUEFoVvCyyvufJM6nh4oCnMgbyHIHFznSwOaovnK3jzjivInedaYaHud9bLMvD
         eprfEroTScPn5f6hgrlhLxLQv2XyUcRskwWKR4priuYcBVcfDkaJc5Ac8F2OIA+JWd21
         Rc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379647; x=1699984447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW0RbAVGUFb+xdBElnhNAHeQGgYiHAEYAyCOW53R3XU=;
        b=ZW6vr3qQ3BcoTN4yzRRWe6g7D8b7qu/ZFAE5EZ9P9Yt2mp3wgCgHAJU68eTtH5ksf1
         54MANB6Xu8Ps8ZNdu3WzddEbwhI68CStxgEpZS10GoZFbslm2N6MgVe5U36zx95nVoXA
         GLg5JXtxyi5LO72d5VGA9wXFz2dnCsl0gEJ8rfoOYWii7dPuwZzRC4ALQULdsHrLGHeo
         MPTXpz2JhH9OIvvWZ9r7k1/9mYMYzy44bXsYcqjgKV3NUsj3GveUFyUHf+UKh/3mrAhG
         1y9j3gbVqhOPe5RobYLykbUWUKE1829FrRjJrd1/hTqJB7SUAJzbx9cZHFmnwVWowvmE
         HTXA==
X-Gm-Message-State: AOJu0YzFf//mtrsga6qPXWGwM+QD9uohVGsT5FffipjSHja01g/EuAXy
        yUh2gybOIHRHUamkVoCLLj/LDA==
X-Google-Smtp-Source: AGHT+IGQ+nRQt1M3ckW/OiQMHeS7z9x+pfYfws+XnYXuooXgVjVCkYIWxzYut+7AHyoqub3WHSQdKw==
X-Received: by 2002:a05:622a:d2:b0:41c:e76e:87f8 with SMTP id p18-20020a05622a00d200b0041ce76e87f8mr38242554qtw.34.1699379646766;
        Tue, 07 Nov 2023 09:54:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id a10-20020ac8720a000000b004181d77e08fsm107696qtp.85.2023.11.07.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:54:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r0QH7-001YR3-Ob;
        Tue, 07 Nov 2023 13:54:05 -0400
Date:   Tue, 7 Nov 2023 13:54:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231107175405.GD4634@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 07, 2023 at 08:35:10AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, November 2, 2023 8:48 PM
> >
> > On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > > Hi folks,
> > >
> > > This series implements the functionality of delivering IO page faults to
> > > user space through the IOMMUFD framework for nested translation.
> > Nested
> > > translation is a hardware feature that supports two-stage translation
> > > tables for IOMMU. The second-stage translation table is managed by the
> > > host VMM, while the first-stage translation table is owned by user
> > > space. This allows user space to control the IOMMU mappings for its
> > > devices.
> > 
> > Having now looked more closely at the ARM requirements it seems we
> > will need generic events, not just page fault events to have a
> > complete emulation.
> 
> Can you elaborate?

There are many events related to object in guest memory or controlled
by the guest, eg C_BAD_CD and C_BAD_STE. These should be relayed or
the emulation is not working well.

> > > User space indicates its capability of handling IO page faults by
> > > setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> > > hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> > > for page fault delivery. On a successful return of HWPT allocation, the
> > > user can retrieve and respond to page faults by reading and writing to
> > > the file descriptor (FD) returned in out_fault_fd.
> > 
> > This is the right way to approach it, and more broadly this shouldn't
> > be an iommufd specific thing. Kernel drivers will also need to create
> > fault capable PAGING iommu domains.
> 
> Are you suggesting a common interface used by both iommufd and
> kernel drivers?

Yes
 
> but I didn't get the last piece. If those domains are created by kernel
> drivers why would they require a uAPI for userspace to specify fault
> capable?

Not to userspace, but a kapi to request a fault capable domain and to
supply the fault handler. Eg:

 iommu_domain_alloc_faultable(dev, handler);

Jason
