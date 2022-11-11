Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA0F624FE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 02:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiKKBqa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 20:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiKKBqa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 20:46:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE8256;
        Thu, 10 Nov 2022 17:46:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o7so3252179pjj.1;
        Thu, 10 Nov 2022 17:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7HdYeM1Wk/Qq62PaBBPXF+Pby5oSXzutxyUY3L3Tjw=;
        b=TQM1A9OGHyHLvekGPLggb7MJP/o+IB9VBA2JF8t0gD8FMJadtowHy09Z34JM/46b2R
         wTpH0lQ8BflS5+jG0vOKqVCGKWYnXKFlJqB89gsJmxNiiVe0DNejwjnJymvlwQyHiQoc
         g0ndwlHu2B8b6eRAU7byeaq4+rj+Aih2wwwPTdQ2nn37z6+dNSSfu1cJAi+C9dzPsB6q
         EeRg/mVH8W0JjkKEwRBFrZesLN5vRM4IwV50MOxuT7Z4S0D1DoIDPiQBzU4oGz260gNR
         M4IUr5SbLHuMTeEQFFjU67nIbtaRfrWv9VUmtgBO18Hv1FT866WPT+Ep/FVvMf6zowS0
         /v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7HdYeM1Wk/Qq62PaBBPXF+Pby5oSXzutxyUY3L3Tjw=;
        b=O291MwO3TzCFBEts0YcjYA8QJx3gkzG+6k7wlw9jj7Htsd7KrWTe1cFJAsv6QByy6A
         pG/64VCiWhXKvunnSwmwHRayh7kOflwAyeoVcXTrNNhgIWDovmP18ht8Iuv6KjcREKiX
         2LP3Rx342KwP/zXr6sTbILbcPuuEuIrbiZCWCcgbgZ2xckv78MBunpSHsKVY9UzNAZ6S
         6Uz23ECmBjXrnmkwlVJtc5w6t0f8tT1gGU8P9127jd+aQnwmqSVUA2T+5H7MHNtdca4f
         udJv2n99dCmbvS52/fT/H/mQ9H/oQb+vCeGMUYjEYUK4S7RC15901AnuRMJe7dDha++m
         zaQQ==
X-Gm-Message-State: ANoB5pngsY1o3hKP+1O7OFIK/yVnSF0IMtgqciWCGl3ISuIVh2d0md9D
        DSmOE127HCgsR2B1ABsI7to=
X-Google-Smtp-Source: AA0mqf7gp2K6uu/Cr3Sggtrh7Qn5BRbs2JbSwN7nqAEB0pxAS61IUKBc/jWB4J5JumGeCw+i9zJYfg==
X-Received: by 2002:a17:903:cd:b0:186:905e:f964 with SMTP id x13-20020a17090300cd00b00186905ef964mr207154plc.162.1668131189132;
        Thu, 10 Nov 2022 17:46:29 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056b1ecef957sm326146pfk.37.2022.11.10.17.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 17:46:28 -0800 (PST)
Message-ID: <615a32d3-41ad-c318-9a96-4dea3c486fa0@gmail.com>
Date:   Fri, 11 Nov 2022 08:46:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
To:     Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     bpf@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com> <Y2zE0zfnQ7mt740i@debian.me>
 <87v8nmhnkl.fsf@meer.lwn.net>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87v8nmhnkl.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/10/22 21:49, Jonathan Corbet wrote:
> So the report you're referring to is
> 
>   https://lore.kernel.org/linux-next/20221110182938.40ce2651@canb.auug.org.au/
> 

Ah, I forget to refer to that link!

> ?  If so, this change will not fix the problem.  That error:
> 
>> drivers/iommu/iommufd/device.c:1: warning: no structured comments found
>> drivers/iommu/iommufd/main.c:1: warning: no structured comments found
> 
> is caused by using .. kernel-doc:: directives to extract documentation
> from files where none exists - thus "no structured comments found".
> 

-ENOENT files :)

> The *real* problem, methinks, is that the directives are added in patch 4
> of the series, but the documentation doesn't show up until later.  So
> the real fix would be to simply move this patch down.  Or just not worry
> about it, since it all works out in the end and nobody will be bisecting
> a docs build.
> 
> Bagas, you are *again* misadvising people.  Please stop doing that!
> 

OK, thanks.

-- 
An old man doll... just what I always wanted! - Clara

