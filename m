Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194696245DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 16:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiKJPag (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 10:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiKJPaF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 10:30:05 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911033E0A5;
        Thu, 10 Nov 2022 07:28:45 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CAEBB37E;
        Thu, 10 Nov 2022 15:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CAEBB37E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668094125; bh=va/Z2qTnKDsS1pdWrOu4QNjUZp+uTSMAsg5VDdjhRBw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k8ooLvHEZHXZcS51FQG4xMfADuPWslODvMX/f/4wEga9Bvypx0oMYHBQ1EiaCK1d6
         D2syrbMLyZcRBbHkxV+PPXKKW8acTps/lKIZ73ggihYIOvD2jHYdO6sjdUv14p+cnt
         UT6ArCqJx10lhx6+adX+5aFowvzxzQIl+PtFGAfTR8TR/aibG6+QvL+haLtjBq4avs
         Va5HG5xs/dfznaoYCdS1hLgt6h+eWGhpkISkrGFFydHb2SKEFN8GGv7k7dhe8P79Mg
         eCt6r7OenGwQzz0kWBI7t5CoXu+NGlLLpsw+div8dKzt5LTS3ZPL8Tn30porIQN0T9
         ZhyyDKwAGFp9w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, bpf@vger.kernel.org,
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
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
In-Reply-To: <Y20XhjH96k4x7qdx@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2zE0zfnQ7mt740i@debian.me> <87v8nmhnkl.fsf@meer.lwn.net>
 <Y20QotPsxivvV53l@nvidia.com> <87r0yahmlg.fsf@meer.lwn.net>
 <Y20XhjH96k4x7qdx@nvidia.com>
Date:   Thu, 10 Nov 2022 08:28:44 -0700
Message-ID: <87mt8yhlqr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, Nov 10, 2022 at 08:10:19AM -0700, Jonathan Corbet wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
>> 
>> > On Thu, Nov 10, 2022 at 07:49:14AM -0700, Jonathan Corbet wrote:
>> >
>> >> The *real* problem, methinks, is that the directives are added in patch 4
>> >> of the series, but the documentation doesn't show up until later.  So
>> >> the real fix would be to simply move this patch down.  Or just not worry
>> >> about it, since it all works out in the end and nobody will be bisecting
>> >> a docs build.
>> >
>> > That is half the problem, the other is this:
>> >
>> > https://lore.kernel.org/r/0-v1-c80e152ce63b+12-kdoc_export_ns_jgg@nvidia.com
>> >
>> > Since even after the whole series the EXPORT_NS functions don't parse
>> > properly. I'm going to put this patch before the doc patch and ignore
>> > the bisection problem.
>> >
>> > I'd like someone to say they are happy with the perl :)
>> 
>> I'm not happy with *any* perl! :)
>> 
>> I've been sitting on that patch because I was under the impression
>> another version was coming - was that wrong?
>
> I can resend it with the single regex if that is the preference - it
> is not quite as exacting as the first version. I have to test it is
> all.

Single is nicer but it's not worth a great deal of angst; nothing we do
is going to turn kernel-doc into a thing of beauty :)

Thanks,

jon
