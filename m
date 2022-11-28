Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0283063AAB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 15:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiK1OSk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 09:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiK1OSh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 09:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28052188C
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 06:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669645046;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCazpTTy+F7fa4dxFepBnOElkUnDE1h7gUS6HgFedPY=;
        b=X+pauQrhxgpQjZZUtIsu7zJKZF43Ah6M81FUCQxauiqRC1SSgSoMTYF50YAMn7WBKUqV76
        dFiE0qcmM1eL6+O7ComM1CgYrgqIp1QMVsq19X2SNkbCGWUI2fOTwhfNv0mJVnQxIklWjW
        oMen7YPQ5Q+IWvagnvMlPtXnP8ikwTo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-kdstuUIrMgyIqWV3DbOkGQ-1; Mon, 28 Nov 2022 09:17:21 -0500
X-MC-Unique: kdstuUIrMgyIqWV3DbOkGQ-1
Received: by mail-qk1-f198.google.com with SMTP id x2-20020a05620a448200b006fa7dad5c1cso20324720qkp.10
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 06:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCazpTTy+F7fa4dxFepBnOElkUnDE1h7gUS6HgFedPY=;
        b=vUoAErrciU+ZPaB5DsDLfhfv6lIv+CjQFYFNPpDAIdVaytG2ZzmdoDpYB3Y5yz5nFn
         rkZSB4bS53e60vqC4+Uutn1mhk5qyT4u6X5Z4Jn9pepgaKg1SZXOAyNGDFksWzDLd/Gr
         VmuvkkTH8XrIE87KvTrJPUfoYb3gilaVQdt8Ykeofto2eboXt6a1gb+LAiKE/mlUQk2V
         mjEZnZ/dkFrkcfenqPZdB8rHg9U6ihC9Stpmyxbw2YC2P++SHkEemvXEKca8I7Hq3wdL
         39B539RA8eWt0UXbaTykwm+32nFb8MZWMU9ja3X2nBoNePGJTZD/YzH4w3cX2lj12KaS
         mZyw==
X-Gm-Message-State: ANoB5pkFkCRwQTRQsNBe+yzSC24JZOU6PLLB5zC9VsS13LGK7bnQsiTO
        hN0nRJYnOYQ3sqUzEbBlSkLEEZTtdnSDNyd2tqEWtS4vVbmtm1sfST2ZwMN+Al6UXpgyrcnW7dI
        AlhLY5y2ifDtPqrC5nRd6mWYQeW15
X-Received: by 2002:a05:620a:15f4:b0:6fc:5e75:8452 with SMTP id p20-20020a05620a15f400b006fc5e758452mr12348134qkm.565.1669645038419;
        Mon, 28 Nov 2022 06:17:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7v1fq7/cmmRa8boL0KEKgHvn1ntFy91sfTcqo+21QKxMb9e0oyQ5n2B68KMni02H2rUIIZ6Q==
X-Received: by 2002:a05:620a:15f4:b0:6fc:5e75:8452 with SMTP id p20-20020a05620a15f400b006fc5e758452mr12348062qkm.565.1669645038027;
        Mon, 28 Nov 2022 06:17:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a254600b006cbc6e1478csm8423957qko.57.2022.11.28.06.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:17:17 -0800 (PST)
Message-ID: <722b8767-daf9-f5b8-8ad7-0d9cb22d4b7d@redhat.com>
Date:   Mon, 28 Nov 2022 15:17:09 +0100
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
 <94e6034a-c4c1-be0a-ea8c-f5934dbadd4c@redhat.com>
 <Y4S1hYFm9HaP0KdR@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Y4S1hYFm9HaP0KdR@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/28/22 14:20, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 11:55:41AM +0100, Eric Auger wrote:
>
>>> Not really. The name is a mess, but as it is implemented, it means the
>>> platform is implementing MSI security. How exactly that is done is not
>>> really defined, and it doesn't really belong as an iommu property.
>>> However the security is being created is done in a way that is
>>> transparent to the iommu_domain user.
>> Some 'ARM platforms' implement what you call MSI security but they do
>> not advertise IOMMU_CAP_INTR_REMAP
> Sounds like a bug.
>  
>> Besides refering to include/linux/iommu.h:
>> IOMMU_CAP_INTR_REMAP,           /* IOMMU supports interrupt isolation */
> Documentation doesn't match code.
>
>>> It doesn't matter how it is done, if it remapping HW, fancy
>>> iommu_domain tricks, or built into the MSI controller. Set this flag
>>> if the platform is secure and doesn't need the code triggered by
>>> irq_domain_check_msi_remap().
>> this is not what is implemented as of now. If the IOMMU does support
>> interrupt isolation, it advertises IOMMU_CAP_INTR_REMAP. On ARM this
>> feature is implemented by the ITS MSI controller instead and the only
>> way to retrieve the info whether the device MSIs are directed to that
>> kind of MSI controller is to use irq_domain_check_msi_remap().
> It is important to keep the Linux design seperated from what the
> architecture papers describes. In Linux the IOMMU is represented by
> the iommu_domain and the iommu_ops. On x86 neither of these objects
> play any role in interrupt delivery. Yes, the x86 architecture papers
> place some of the interrupt logic inside what they consider the iommu
> block, but that is just some historical stuff and shouldn't impact the
> SW design.
>
> If we had put the IRTE bits inside the irqchip layer instead of in the
> iommu driver, it would have made a lot more sense.
>
> The fact that ARM was allowed to be different (or rather the x86 mess
> wasn't cleaned up before the ARM mess was overlayed on top) is why
> this is so confusing. They are doing the same things, just in
> unnecessarily different ways.

fair enough. But that's a separate discussion that needs to happen with
iommu and irqchip maintainers I think. At the moment things are
implemented that way.
>
>>>> irq_domain_check_msi_remap() instead means the MSI controller
>>>> implements that functionality (a given device id is able to trigger
>>> Not quite, it means that MSI isolation is available, however it is not
>>> transparent and the iommu_domain user must do the little dance that
>>> follows.
>> No I do not agree on that point. The 'little dance' is needed because
>> the SMMU does not bypass MSI writes as done on Intel. And someone must
>> take care of the MSI transaction mapping. This is the role of the MSI
>> cookie stuff. To me this is independent on the above discussion whether
>> MSI isolation is implemented.
> OK, so you are worried about someone who sets
> allow_unsafe_interrupts=1 they will not get the iommu_get_msi_cookie()
> call done even though they still need it? That does seem wrong.
yes
>
>>> This was sort of sloppy copied from VFIO - we should just delete
>>> it. The is no driver that sets both, and once the platform asserts
>>> irq_domain_check_msi_remap() it is going down the non-transparent path
>>> anyhow and must set a cookie to work. [again the names doesn't make
>>> any sense for the functionality]
>>>
>>> Failing with EPERM is probably not so bad since the platform is using
>>> an invalid configuration. I'm kind of inclined to leave this for
>>> right
>> I don't understand why it is invalid? HW MSI RESV region is a valid
>> config and not sure you tested with that kind of setup, did you?
> Why would it be a valid config? No driver sets both..
>
> HW MSI RESV should set IOMMU_CAP_INTR_REMAP like Intel does.
>
> irq_domain_check_msi_remap() is only for SW MSI RESV regions.
In theory no. Nothing prevents from having an MSI isolation capable
controller (such as the ITS) with an IOMMU HW which wouldn't translate
MSIs. In the past there has been such kind of problematic I think for
HiSilicon HW
https://lore.kernel.org/all/20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com/
This was eventually addressed differently but Shameer may precise ... 

Eric

>
> This is what the code implements, and yes it makes no sense.
>
> Jason
>

