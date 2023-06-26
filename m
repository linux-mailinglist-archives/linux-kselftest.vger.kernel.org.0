Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1597073E92F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 20:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjFZSdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 14:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjFZSdV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 14:33:21 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D61E8
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 11:33:20 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-45739737afcso990146e0c.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687804399; x=1690396399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Llh4gIlToO5IIgOre9UJS/YUO0ldCTUXip1sWklWSMQ=;
        b=JVUAS6Mwd4CGVgbTg2A/4nZBcOTwKzPyRt4TC3yOvNM2+tIbS6xPD0y0D61ppUoIqP
         kZrkBWOA7Ql4ra0BfHP6nORKavSIwwHUciNKkQa/xmCuLHQQU0FKrjqNuDpFFUV2WhAs
         bj0vBswCZ/jeImDakg37V6RL9mG+1bVuMZuVcmiIwOAR2fw7RzomjAA6nEM2czoRF5T3
         UfxPt3ZwyqtBl2AfZC59Q6h21ylliaEpNdI5EVodei9o/wAyUMzWRcPPeO/chWAPw5Vz
         /ewQOBhvCVgbaU8C2DAN4F+GwhoddBQvjmntOXBFEFx01mMP8Ky6gACQ9gm16ROU2eWf
         tjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687804399; x=1690396399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Llh4gIlToO5IIgOre9UJS/YUO0ldCTUXip1sWklWSMQ=;
        b=TcmuN+BmG4q1GbYSNkW7tGKJQfrBS/RN91wy1EgoJZnbITA+ouRkEIslS/sy+U+kKu
         DKk6+r/OkZdmSrs456eHwY960f3KaB5At+OFSJYyKr5xbkibI9LUVkmOnFsOsoY+uD44
         pNXhNclutPLbiuUb4C8LDl/LtdxxnlVVyHAwRK8xRKlmkMk2XEvm7Pa1WLsoyFWBK+V9
         WwLhExgMPECFG9Go+bMi+/oHEfBzQHs5zPoMS7iosOwTTmgeCty3dB/XCXGLMdJ9jdY5
         7ldIBAeMryltl0rE+ASqbXHZKG8ViXGR0WDpVXCvPc6hU9en5aM3KNx0gu7XyI1PbcOt
         bG/g==
X-Gm-Message-State: AC+VfDzTdv5xlg2PylvisUE73MQwt8BXb6mnkxOZ+sb4hE2UNzbfLxb/
        efEa/x5zAGgIaR0Bp1qfUmmaIFTJyd2/UfriTFo=
X-Google-Smtp-Source: ACHHUZ71l/DblDrK7Oyn3lB5D1oIYfT7tQ+BssB+t+iwqPFJMSrWpCc/dst5XGo0zmyM+elBVv+q6Q==
X-Received: by 2002:a1f:3fca:0:b0:471:5939:f4f2 with SMTP id m193-20020a1f3fca000000b004715939f4f2mr9532857vka.8.1687804399118;
        Mon, 26 Jun 2023 11:33:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id z24-20020ac875d8000000b003fddd8e7bbasm3348807qtq.30.2023.06.26.11.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:33:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qDr1Z-008pJc-JP;
        Mon, 26 Jun 2023 15:33:17 -0300
Date:   Mon, 26 Jun 2023 15:33:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJnZ7bEIZHsqmyAG@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
 <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 25, 2023 at 02:30:46PM +0800, Baolu Lu wrote:

> Agreed. We should avoid workqueue in sva iopf framework. Perhaps we
> could go ahead with below code? It will be registered to device with
> iommu_register_device_fault_handler() in IOMMU_DEV_FEAT_IOPF enabling
> path. Un-registering in the disable path of cause.

This maze needs to be undone as well.

It makes no sense that all the drivers are calling 

 iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);

The driver should RX a PRI fault and deliver it to some core code
function, this looks like a good start:

> static int io_pgfault_handler(struct iommu_fault *fault, void *cookie)
> {
>         ioasid_t pasid = fault->prm.pasid;
>         struct device *dev = cookie;
>         struct iommu_domain *domain;
> 
>         if (fault->type != IOMMU_FAULT_PAGE_REQ)
>                 return -EOPNOTSUPP;
> 
>         if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
>                 domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>         else
>                 domain = iommu_get_domain_for_dev(dev);
> 
>         if (!domain || !domain->iopf_handler)
>                 return -ENODEV;
> 
>         if (domain->type == IOMMU_DOMAIN_SVA)
>                 return iommu_queue_iopf(fault, cookie);
> 
>         return domain->iopf_handler(fault, dev, domain->fault_data);

Then we find the domain that owns the translation and invoke its
domain->ops->iopf_handler()

If the driver created a SVA domain then the op should point to some
generic 'handle sva fault' function. There shouldn't be weird SVA
stuff in the core code.

The weird SVA stuff is really just a generic per-device workqueue
dispatcher, so if we think that is valuable then it should be
integrated into the iommu_domain (domain->ops->use_iopf_workqueue =
true for instance). Then it could route the fault through the
workqueue and still invoke domain->ops->iopf_handler.

The word "SVA" should not appear in any of this.

Not sure what iommu_register_device_fault_handler() has to do with all
of this.. Setting up the dev_iommu stuff to allow for the workqueue
should happen dynamically during domain attach, ideally in the core
code before calling to the driver.

Also, I can understand there is a need to turn on PRI support really
early, and it can make sense to have some IOMMU_DEV_FEAT_IOPF/SVA to
ask to turn it on.. But that should really only be needed if the HW
cannot turn it on dynamically during domain attach of a PRI enabled
domain.

It needs cleaning up..

Jason
