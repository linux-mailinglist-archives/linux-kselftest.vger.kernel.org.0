Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DC67411A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 14:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjF1MuH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjF1Mtf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 08:49:35 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B119B1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 05:49:33 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-635de6776bdso27554446d6.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687956573; x=1690548573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfOsXJab4slJjnxwoDTS70GHD4a6XTLVcr8PMnR6dnU=;
        b=YkH3CQCpfgI7DsqXU/4gxSJnl/4Dx066SB/wOKx9jGovBXVNkQBpWrEiGpN14LRKGU
         XJdhd7gGhYYd2s8IlI5dlCV4sELnIWiL8LaNznLp/7rtjVBvIvDWkFfBP1BlP3guCvuS
         p8nBvCP6GX0qCxnAroaDo6uG9CstSg8xDAbARHcTTQu+CzYNQXPJD5dYMIcRagx5/XGl
         p1L2WSGYR1JaI8+wmV+sB41Ur9L9jeH54uCsAXjrgdC1cEzSTeAtajjtMHM6lUKraVEi
         FVicyhQPFGsP0rGMpltdkb2EwsYwRVpqjUG9sFmBfxBClAxh1Rq3zrKsK68ysEZeRw33
         tEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687956573; x=1690548573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfOsXJab4slJjnxwoDTS70GHD4a6XTLVcr8PMnR6dnU=;
        b=LQcWd2LpJAKBNX0RJOSsnpYfLa9KBLjsMn/UzOywrNKMnTSYx67Eg8y0LwojP0VhmY
         zk0GFzWtv2YRfKNFYzHYLli4WoH0pAE4zLiHKBtEhDYaof8czi3fg+Vrhr4ROTS/9DrX
         pQpdwl2j6TfeZ1l5lB2x0FbUFfHhcmff0mTwaUzo7GQpi2GHejFQF+pm9iew7VrmpwhR
         jD3V1edPaqzJc81KY8MHO+LwhSR26fWGQwnyvE5WZZZWofv044HYr3Yt/9Lny3mAqZM3
         Xwo1+PipNLZNxfUQ+e4uHfeT34XbvI5W6PbWrO4fzmeZmvRPSTbQHLPpxlTu1wQppHnr
         qKBg==
X-Gm-Message-State: AC+VfDzNrisH52B/lDwYhmtKpAy7D0pCIaaDZEU9zDjTTHH8SEKwtQMy
        1RPuSc8Kgwk5pk0L2WyRm6IYnQ==
X-Google-Smtp-Source: ACHHUZ5VTYEuYZ18Yx3pf3BTkEN/W0B1f5+DHaQ0fxgwOjq0lP8R3ZMqT/sYgn+dLBdwLJd9PlzH/w==
X-Received: by 2002:a05:6214:f08:b0:623:6b1a:c5f1 with SMTP id gw8-20020a0562140f0800b006236b1ac5f1mr44056481qvb.4.1687956572852;
        Wed, 28 Jun 2023 05:49:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a141300b007653a7977e6sm5003782qkj.97.2023.06.28.05.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 05:49:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qEUbz-009DhQ-F5;
        Wed, 28 Jun 2023 09:49:31 -0300
Date:   Wed, 28 Jun 2023 09:49:31 -0300
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
Message-ID: <ZJwsW3eFy0bMhkOt@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
 <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
 <ZJnZ7bEIZHsqmyAG@ziepe.ca>
 <26b97776-7ce5-51f6-77b7-0ce837aa7cca@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b97776-7ce5-51f6-77b7-0ce837aa7cca@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 10:00:56AM +0800, Baolu Lu wrote:
> > If the driver created a SVA domain then the op should point to some
> > generic 'handle sva fault' function. There shouldn't be weird SVA
> > stuff in the core code.
> > 
> > The weird SVA stuff is really just a generic per-device workqueue
> > dispatcher, so if we think that is valuable then it should be
> > integrated into the iommu_domain (domain->ops->use_iopf_workqueue =
> > true for instance). Then it could route the fault through the
> > workqueue and still invoke domain->ops->iopf_handler.
> > 
> > The word "SVA" should not appear in any of this.
> 
> Yes. We should make it generic. The domain->use_iopf_workqueue flag
> denotes that the page faults of a fault group should be put together and
> then be handled and responded in a workqueue. Otherwise, the page fault
> is dispatched to domain->iopf_handler directly.

It might be better to have iopf_handler and
iopf_handler_work function pointers to distinguish to two cases.

> > Not sure what iommu_register_device_fault_handler() has to do with all
> > of this.. Setting up the dev_iommu stuff to allow for the workqueue
> > should happen dynamically during domain attach, ideally in the core
> > code before calling to the driver.
> 
> There are two pointers under struct dev_iommu for fault handling.
> 
> /**
>  * struct dev_iommu - Collection of per-device IOMMU data
>  *
>  * @fault_param: IOMMU detected device fault reporting data
>  * @iopf_param:  I/O Page Fault queue and data
> 
> [...]
> 
> struct dev_iommu {
>         struct mutex lock;
>         struct iommu_fault_param        *fault_param;
>         struct iopf_device_param        *iopf_param;
> 
> My understanding is that @fault_param is a place holder for generic
> things, while @iopf_param is workqueue specific.

Well, lets look

struct iommu_fault_param {
	iommu_dev_fault_handler_t handler;
	void *data;

These two make no sense now. handler is always iommu_queue_iopf. Given
our domain centric design we want the function pointer in the domain,
not in the device. So delete it.

	struct list_head faults;
	struct mutex lock;

Queue of unhandled/unacked faults? Seems sort of reasonable

> @iopf_param could be allocated on demand. (perhaps renaming it to a more
> meaningful one?) It happens before a domain with use_iopf_workqueue flag
> set attaches to a device. iopf_param keeps alive until device_release.

Yes

Do this for the iommu_fault_param as well, in fact, probably just put
the two things together in one allocation and allocate if we attach a
PRI using domain. I don't think we need to micro optimze further..
 
Jason
