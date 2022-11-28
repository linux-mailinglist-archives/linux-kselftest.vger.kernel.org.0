Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4663A678
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 11:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiK1K4w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 05:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiK1K4u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 05:56:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03010175A3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 02:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669632952;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhYdHOX1qbSelyQF1n2caoyOhYaSnNc+Zc/+zPUkQ+s=;
        b=MnCTK51D2Qu5jJ4sTWWnbYgG+caEDus01LKnlaI1AlEWeQsVuE3KchFdsMKPre3JweFq9u
        MfNtAurs/hMl4LNUBj9PAuLwydFB/jiPckxrzJtMEWYq3140ofXRiUwR56e6Hly5wxN/2J
        eJe4nu+ydocXBU6Zi7NCwOqcCgTPOR0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-144-7RrhW3FtOBmqhbM2SZRIRg-1; Mon, 28 Nov 2022 05:55:51 -0500
X-MC-Unique: 7RrhW3FtOBmqhbM2SZRIRg-1
Received: by mail-qv1-f69.google.com with SMTP id p17-20020a05621415d100b004c6a488c925so12879074qvz.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 02:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhYdHOX1qbSelyQF1n2caoyOhYaSnNc+Zc/+zPUkQ+s=;
        b=lCJylYbU/hZnvKuld1rxSZt3I27MEn94VvzB6TTPtIud++hlf1YE+Iqzoxwdhl7C2W
         FjzrMvXzUGX4BNx2zT3BUqJmwCP7L0CtsUlwADmeqo7YbE+X5d5IKbBKVPTBbL3u2iK1
         IEdndXxt3E49gGaERXGroEnqy9S1978l0kIQA8xU6PSzMdPC0vTXcce6SjBRhra18sBY
         jedMv7UKD8RZHk1q2yrs/UIjIA9FHkgP8ALX66ZguZ5u4pVFVFkvs/nnD+SbQlpYOCVp
         ugFsUD1GS2QEo5QXYnoAmT1hIjpC2Q8h6nd+cdIOD22t0gHGom9Rv9VM6h1Xt5peitLk
         0n5Q==
X-Gm-Message-State: ANoB5pnbSG6GRg2T9Er3PIayuG7TSasdBAg/hqi8j9gy2AaPWFRvcygk
        w+oPnHviMqXlaksEfmfblLaMrcuX2yFtZrh52j+/v0XVH7QXMKJy6mssPm0ay0Xx4tPiNI2r/1n
        PeAi0/3jRDvvP/0TNu1jdy4ajXaWX
X-Received: by 2002:a05:6214:5504:b0:4c6:9399:9335 with SMTP id mb4-20020a056214550400b004c693999335mr41468324qvb.12.1669632950432;
        Mon, 28 Nov 2022 02:55:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6R1JyULPFe65HEgSq/X9lfxRMMZgXu5jvkRqbYJFnB6yxrk1GeFdc2izLM+ws6kfHPBGer7g==
X-Received: by 2002:a05:6214:5504:b0:4c6:9399:9335 with SMTP id mb4-20020a056214550400b004c693999335mr41468274qvb.12.1669632950103;
        Mon, 28 Nov 2022 02:55:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id z1-20020ac84541000000b003a530a32f67sm6703684qtn.65.2022.11.28.02.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 02:55:49 -0800 (PST)
Message-ID: <94e6034a-c4c1-be0a-ea8c-f5934dbadd4c@redhat.com>
Date:   Mon, 28 Nov 2022 11:55:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 13/19] iommufd: Add kAPI toward external drivers for
 physical devices
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <13-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <4c429c36-146e-e2b2-0cb4-d256ca659280@redhat.com>
 <Y4P9VzpCv/DyHeaD@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Y4P9VzpCv/DyHeaD@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jason,

On 11/28/22 01:14, Jason Gunthorpe wrote:
> On Sun, Nov 27, 2022 at 10:13:55PM +0100, Eric Auger wrote:
>>> +static int iommufd_device_setup_msi(struct iommufd_device *idev,
>>> +				    struct iommufd_hw_pagetable *hwpt,
>>> +				    phys_addr_t sw_msi_start,
>>> +				    unsigned int flags)
>>> +{
>>> +	int rc;
>>> +
>>> +	/*
>>> +	 * IOMMU_CAP_INTR_REMAP means that the platform is isolating MSI, and it
>> rather means that the *IOMMU* implements IRQ remapping.
> Not really. The name is a mess, but as it is implemented, it means the
> platform is implementing MSI security. How exactly that is done is not
> really defined, and it doesn't really belong as an iommu property.
> However the security is being created is done in a way that is
> transparent to the iommu_domain user.
Some 'ARM platforms' implement what you call MSI security but they do
not advertise IOMMU_CAP_INTR_REMAP

Besides refering to include/linux/iommu.h:
IOMMU_CAP_INTR_REMAP,           /* IOMMU supports interrupt isolation */

>
> MSI security means that the originating device (eg the RID for PCI) is
> validated when the MSI is processed. RIDs can only use MSIs they are
> authorized to use.
agreed this is what I described below.
>
> It doesn't matter how it is done, if it remapping HW, fancy
> iommu_domain tricks, or built into the MSI controller. Set this flag
> if the platform is secure and doesn't need the code triggered by
> irq_domain_check_msi_remap().
this is not what is implemented as of now. If the IOMMU does support
interrupt isolation, it advertises IOMMU_CAP_INTR_REMAP. On ARM this
feature is implemented by the ITS MSI controller instead and the only
way to retrieve the info whether the device MSIs are directed to that
kind of MSI controller is to use irq_domain_check_msi_remap().
>
>> irq_domain_check_msi_remap() instead means the MSI controller
>> implements that functionality (a given device id is able to trigger
> Not quite, it means that MSI isolation is available, however it is not
> transparent and the iommu_domain user must do the little dance that
> follows.
No I do not agree on that point. The 'little dance' is needed because
the SMMU does not bypass MSI writes as done on Intel. And someone must
take care of the MSI transaction mapping. This is the role of the MSI
cookie stuff. To me this is independent on the above discussion whether
MSI isolation is implemented.
>
> It does not mean the MSI controller implements the security
> functionality because it is not set on x86.
>
> Logically on x86 we should consider the remapping logic as part of the
> MSI controller even if x86 makes them separated for historical
> reasons.
>
>> MSI #n and this #n gets translated into actual MSI #m) So what you
>> want is to prevent an assigned device from being able to DMA into an
>> MSI doorbell that is not protected by either the IOMMU or the MSI
>> controller. If this happens this means the DMA can generate any kind
>> of MSI traffic that can jeopardize the host or other VMs
> I don't know of any real systems that work like this. ARM standard GIC
> uses a shared ITS page, the IOMMU does nothing to provide MSI
> security. MSI security is built into the GIC because it validates the
> device ID as part of processing the MSI. The IOMMU is only involved
> to grant access to the shared ITS page.

?? Yeah that's what I said. The SMMU does nothing about MSI security.
The ITS does.
>
> Intel is similar, it provides security through the MSI controller's
> remapping logic, the only difference is that on Intel the MSI window
> is always present in every iommu_domain (becuase it occures before the
> IOMMU), and in ARM you have to do the little dance.
On Intel the MSI window [FEE0_0000h - FEF0_000h] is bypassed by the
IOMMU. On ARM MSI transactions are translated except in case of HW MSI
RESV regions (I think).
>
> Even if the iommu is to be involved it is all hidden from this layer.
>
>> and afterwards resv_msi is checked to see if we need to create the
>> so-called msi cookie.  This msi cookie tells the MSI writes are
>> translated by the IOMMU and somebody must create a mapping for those
>> transactions.
> The cookie is always necessary if we are going to use the
> non-transparent mode. That is what makes it the non transparent
> mode. We have to supply the reserved IOVA range from one part of the
> iommu driver to another part.
>
>>> +	 * creates the MSI window by default in the iommu domain. Nothing
>>> +	 * further to do.
>>> +	 */
>>> +	if (device_iommu_capable(idev->dev, IOMMU_CAP_INTR_REMAP))
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * On ARM systems that set the global IRQ_DOMAIN_FLAG_MSI_REMAP every
>>> +	 * allocated iommu_domain will block interrupts by default and this
>> It sounds there is a confusion between IRQ remapping and the fact MSI
>> writes are not bypassed by the IOMMU.
> I don't think I'm confused :)
As soon as there is an SW MSI_RESV region and only in that case you need
to put in place the msi cookie (because it indicates the IOMMU
translates MSI transactions).

The fact the platform provides MSI security (through IOMMU or MSI
controller) looks orthogonal to me.
>
>>> +static int iommufd_device_do_attach(struct iommufd_device *idev,
>>> +				    struct iommufd_hw_pagetable *hwpt,
>>> +				    unsigned int flags)
>>> +{
>>> +	phys_addr_t sw_msi_start = 0;
>>> +	int rc;
>>> +
>>> +	mutex_lock(&hwpt->devices_lock);
>>> +
>>> +	/*
>>> +	 * Try to upgrade the domain we have, it is an iommu driver bug to
>>> +	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
>>> +	 * enforce_cache_coherency when there are no devices attached to the
>>> +	 * domain.
>>> +	 */
>>> +	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
>>> +		if (hwpt->domain->ops->enforce_cache_coherency)
>>> +			hwpt->enforce_cache_coherency =
>>> +				hwpt->domain->ops->enforce_cache_coherency(
>>> +					hwpt->domain);
>>> +		if (!hwpt->enforce_cache_coherency) {
>>> +			WARN_ON(list_empty(&hwpt->devices));
>>> +			rc = -EINVAL;
>>> +			goto out_unlock;
>>> +		}
>>> +	}
>>> +
>>> +	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
>>> +						   idev->group, &sw_msi_start);
>>> +	if (rc)
>>> +		goto out_unlock;
>>> +
>> so in the case of any IOMMU_RESV_MSI, iommufd_device_setup_msi() will be
>> called with *sw_msi_start = 0 which will return -EPERM?
>> I don't think this is what we want. In that case I think we want the
>> RESV_MSI region to be taken into account as a RESV region but we don't
>> need the MSI cookie.
> This was sort of sloppy copied from VFIO - we should just delete
> it. The is no driver that sets both, and once the platform asserts
> irq_domain_check_msi_remap() it is going down the non-transparent path
> anyhow and must set a cookie to work. [again the names doesn't make
> any sense for the functionality]
>
> Failing with EPERM is probably not so bad since the platform is using
> an invalid configuration. I'm kind of inclined to leave this for right
I don't understand why it is invalid? HW MSI RESV region is a valid
config and not sure you tested with that kind of setup, did you?
> now since it has all be tested and I don't want to make a
> regression. But I can try to send a patch to tidy it a bit more, maybe
> add an appropriate WARN_ON.
>
> The whole thing is actually backwards. The IOMMU_CAP_INTR_REMAP should
> have been some global irq_has_secure_msi() and everything with
> interrupt remapping, and ARM should set it.
You are revisiting this IOMMU_CAP_INTR_REMAP definition ... this is not
what is documented in the header file.

>
> Then the domain should have had a domain cap
> IOMUU_CAP_REQUIRE_MSI_WINDOW_SETUP to do the little dance ARM drivers
> need.
>
> And even better would have been to not have the little dance in the
> first place, as we don't really need the iommu_domain user to convey
> the fixed MSI window from one part of the iommu driver to another.
>
> We may try to fix this up when we get to doing nesting on ARM, or
> maybe just leave the confusing sort of working thing as-is. I don't
> know.
>
> Jason
>
Eric

