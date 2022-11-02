Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A59F616D29
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 19:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiKBSuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiKBSt4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 14:49:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE6C01;
        Wed,  2 Nov 2022 11:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1374BB82426;
        Wed,  2 Nov 2022 18:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFD8C433C1;
        Wed,  2 Nov 2022 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414991;
        bh=A9V26abd3ofhCXzboqJszcQ8NMZJoEJqgoBj4Pi/PF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/eYUT5c1MXDySctcF4yD+cGNE9uiEyE8Yln6G6O7ESxBGrWOkD0qXBrIxP5D09tx
         rPet5rrxRJHAfe8hioWKZQ1iJusfCXAckHA7RwECS67arZyVDWKd/Y/QhKsTgKxco9
         fJcyq7ZBTJR3e2zg94+sL6bxDLT6dxqk7tFIHafdkuomMQJqTXrd+OVXW5rvQKWImI
         oxU70L8e/VzYhVf1rQFGdJuJdbFi82J56nqiMSJYPtdM3hZaUOdzHcN2Pl/6O88y+J
         /4ZlWQygHNWO8kJXUc+bgLLUB14i597HfGfy0iLluCcZoSYl5LjAUwo2LEgEWCJGVl
         WZQUaqh5TxuQw==
Date:   Wed, 2 Nov 2022 11:49:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 15/15] iommufd: Add a selftest
Message-ID: <Y2K7zMvzrHmQJ1hk@dev-arch.thelio-3990X>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <15-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <Y2GCV97lxEGwAuo6@Asurada-Nvidia>
 <Y2Jt+WxNUwROJ8fN@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Jt+WxNUwROJ8fN@nvidia.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 02, 2022 at 10:17:45AM -0300, Jason Gunthorpe wrote:
> On Tue, Nov 01, 2022 at 01:32:23PM -0700, Nicolin Chen wrote:
> > On Tue, Oct 25, 2022 at 03:12:24PM -0300, Jason Gunthorpe wrote:
> >  
> > > diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> > 
> > > +static inline struct iommufd_hw_pagetable *
> > > +get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
> > > +		 struct mock_iommu_domain **mock)
> > > +{
> > > +	struct iommufd_hw_pagetable *hwpt;
> > > +	struct iommufd_object *obj;
> > > +
> > > +	obj = iommufd_get_object(ucmd->ictx, mockpt_id,
> > > +				 IOMMUFD_OBJ_HW_PAGETABLE);
> > > +	if (IS_ERR(obj))
> > > +		return ERR_CAST(obj);
> > > +	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
> > > +	if (hwpt->domain->ops != mock_ops.default_domain_ops) {
> > > +		return ERR_PTR(-EINVAL);
> > > +		iommufd_put_object(&hwpt->obj);
> > 
> > Coverity reports that return is placed before iommufd_put_object.
> 
> I'm surprised no compiler warned about this!

clang does have -Wunreachable-code-return to try and flag issues like
this but it is not on by default nor included in -Wall:

https://clang.llvm.org/docs/DiagnosticsReference.html#wunreachable-code-return

The fact it is included in -Wunreachable-code-aggressive makes me think
that this might generate a lot of false positives around constructs such
as

    if (IS_ENABLED(CONFIG_...))
        return ...;

    return ...;

but I have not actually tested it.

> > > +static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
> > > +				     unsigned int access_id, unsigned long iova,
> > > +				     size_t length, void __user *uptr,
> > > +				     u32 flags)
> > > +{
> > > +	struct iommu_test_cmd *cmd = ucmd->cmd;
> > > +	struct selftest_access_item *item;
> > > +	struct selftest_access *staccess;
> > > +	struct page **pages;
> > > +	size_t npages;
> > > +	int rc;
> > > +
> > > +	if (flags & ~MOCK_FLAGS_ACCESS_WRITE)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	staccess = iommufd_access_get(access_id);
> > > +	if (IS_ERR(staccess))
> > > +		return PTR_ERR(staccess);
> > > +
> > > +	npages = (ALIGN(iova + length, PAGE_SIZE) -
> > > +		  ALIGN_DOWN(iova, PAGE_SIZE)) /
> > > +		 PAGE_SIZE;
> > > +	pages = kvcalloc(npages, sizeof(*pages), GFP_KERNEL_ACCOUNT);
> > > +	if (!pages) {
> > > +		rc = -ENOMEM;
> > > +		goto out_put;
> > > +	}
> > > +
> > > +	rc = iommufd_access_pin_pages(staccess->access, iova, length, pages,
> > > +				      flags & MOCK_FLAGS_ACCESS_WRITE);
> > > +	if (rc)
> > > +		goto out_free_pages;
> > > +
> > > +	rc = iommufd_test_check_pages(
> > > +		uptr - (iova - ALIGN_DOWN(iova, PAGE_SIZE)), pages, npages);
> > > +	if (rc)
> > > +		goto out_unaccess;
> > > +
> > > +	item = kzalloc(sizeof(*item), GFP_KERNEL_ACCOUNT);
> > > +	if (!item) {
> > > +		rc = -ENOMEM;
> > > +		goto out_unaccess;
> > > +	}
> > > +
> > > +	item->iova = iova;
> > > +	item->length = length;
> > > +	spin_lock(&staccess->lock);
> > > +	item->id = staccess->next_id++;
> > > +	list_add_tail(&item->items_elm, &staccess->items);
> > > +	spin_unlock(&staccess->lock);
> > > +
> > > +	cmd->access_pages.out_access_item_id = item->id;
> > > +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > > +	if (rc)
> > > +		goto out_free_item;
> > > +	goto out_free_pages;
> > > +
> > > +out_free_item:
> > > +	spin_lock(&staccess->lock);
> > > +	list_del(&item->items_elm);
> > > +	spin_unlock(&staccess->lock);
> > > +	kfree(item);
> > > +out_unaccess:
> > > +	iommufd_access_unpin_pages(staccess->access, iova, length);
> > > +out_free_pages:
> > > +	kvfree(pages);
> > 
> > Coverity reports a double free here, call trace:
> > 
> > [jumped from] rc = iommufd_access_pin_pages(..., pages, ...);
> > 	[in which] iopt_pages_add_access(..., out_pages, ...);
> > 		[then] iopt_pages_fill_xarray(..., out_pages);
> > 			[then] iopt_pages_fill_from_mm(..., out_pages);
> > 				[then] user->upages = out_pages + ...;
> > 				       pfn_reader_user_pin(user, ...);
> > 					[then] kfree(user->upages);
> > 					       return -EFAULT;
> > 
> > Should be the same potential issue in the other email.
> 
> Yes, looks like
> 
> Thanks,
> Jason
