Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411C960E63A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 19:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiJZROK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 13:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiJZROF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 13:14:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC15FC1F8;
        Wed, 26 Oct 2022 10:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg4wBAFtEwfN+z8gwbuZF2AYbp/bkadao1HwHEJ7OHdwkRtEQjNA2CUCO/jn8QNECshByI84icAUyjXij5e76eFlK4Z5qJxJvTQ8+QiuX0Lg6p8xq3nAuTLgN5XmaQeyoBqaq08EFkceUnlCvyfaZm1U7B3BvvnF5+fAxeXVdN4oaJJGp5ZEtm5jgvZVRXAqVW3MIns1/JENsQgH9ZL+XG6KJ8C9fXiD6Yppuya7fbMBvwAtAYNHL1EgHCOOAgR7cmwHwLPRrgdGLekCmqhb9FLon6pu+Z3/z4NNSz5iUbKXO8wPpiiYsQko4TCDXXqcTLhxxeEAMilWDfQAORKlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4xGXL0pBYsCq5GPJtn9/cJkpo+m2GMnLEIbpWEh+gI=;
 b=XnuIuPt8exKd9P/AtQDTjTebtOQswCqaYVMzhAOK+0OR6+v+ulX7TZlnqYeF0QACD39fALXNGay9xWRnIkCxaiHaSA33Wypd6GI2V6V2cbT4YmpqzI6rHK0aT4QQ9fXxG3fP7FEOTtwF4zlqhrjz7Iz6AK4w0FLSSATXN1QQ4tqjiIYFR9wtTsTOzULE2o5fI4JGwAWTPR1aeyPI+keq5sM+SZTcnPAF9SQLMG0lJHGI081hliOzHfAwPqBkwVexabYUGYqO2DxisdGabutOWEnRGiGYJLtRLdBXD51GVpT/3gN4FxI5rpeF6mSXJNsNNAvGF5jT6wx+xSTH+9hvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4xGXL0pBYsCq5GPJtn9/cJkpo+m2GMnLEIbpWEh+gI=;
 b=k0w0U5r7mbQeVpb4U9d4Wtzlt+MYx0oSF1tT2wCMjNHSllXrIZU7+JuAMjUofw9o7B4+D7VuwQrZeF+kGP+mw6TO+e7F1jSUi8yUSi+ppArDniWWdHkiwOjRR9KOEzI0EC+eprdRG4/KYsBYJ5XLhpTFSVo4bcv3jqrVHGijJ5zFQ5jWTEj3eLkZ85Nsl5DCkhD5xBIqF7YE2FYy1vkjKxBPHUp9zkHpN+kjwCiJAEQG8oo3cG1rs13TvbTvyHJQ1MC+r45EAKIt6ByRYe8wh47AksfYtzDHv9uzC87DIL8cPQ7zAFbHI9dVGCzOBNZQA1m5qb5+9jyEqITWOq7a5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 17:14:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 17:14:01 +0000
Date:   Wed, 26 Oct 2022 14:14:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 05/15] iommufd: File descriptor, context, kconfig and
 makefiles
Message-ID: <Y1lq2JJt1yLrzNjs@nvidia.com>
References: <5-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <9a837538-6333-0973-c6f4-229064026330@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a837538-6333-0973-c6f4-229064026330@linux.intel.com>
X-ClientProxiedBy: BL0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:91::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 46cb1728-9e7b-4244-ec74-08dab7757a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quhSKI/2GWbX2amtsFAkGGnthLsvjI+ivvR0cLBa7tpy/998m8OiZSuhNzCR4VUNY3Gc5sF3IiaWuhpOcv7K7460b1QZeYXvE1XnIrHHQdKqpQP52LsrVhnXyINE7sZAAHhpcpNiQC5jd/M1NTJl+scnRrsZ/koDX7rRywqkdg0+Uuol+65y5EsaT2npNGZ06/fk0HnX0OJ99uWcFFKsdr6xsexu9THWeirG+vHzW/KTLWilGordwfchjkSl76U0V1jzqk9jkavXYRaMy20zmkcjWABp+R4ioO1yYxEATqcpWi3aTR1o/LPsgYS8wGTMuBnHbEACxtuG/LZE5+IVsSK6YYQkWEnXaZKu7BXwZ05jAReOM6V2shLX4fJwdCb9x59kMFQyxlhonpmkU/rTJRiVWQKghuABrmbxjQCJwCAgXfB5keuHtfhyfeD/myDdUllxQ8OB9QvVaPoW1+EYaI+Hs7HNk+t62BrsNFpZWoQ9dXfY186muFLUQxFjMy1iYcXwgPjz82Vj99UJywXOU+vMq9UQz/ctTZijpUMbR4FyaUuFdSK1GL3eh0R9AioWEThFNraKlW9oCnMPHXJm22LcnGEgaGYQk15kZLD56V3M+e2pdUJSwSvjP5urUcccKugvTv9F0VLOnYjQ/MqyVP5huEoEFDnqiabxnLFP4oQiTmA01jH2acTau9rKdiqW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(5660300002)(6512007)(7406005)(7416002)(2906002)(26005)(186003)(2616005)(41300700001)(8936002)(86362001)(38100700002)(36756003)(6916009)(54906003)(66476007)(66556008)(316002)(66946007)(8676002)(478600001)(4326008)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O85C84wldiTUPi32VT69aju42FgC1yfSPrgJUGwbJDoIuktRfLWudtO1SVer?=
 =?us-ascii?Q?+GFh4q5snylzBTRy5QfuF9dvpxKI4PpcDEbir9f+88u75k76Tw2FKlH2a3cY?=
 =?us-ascii?Q?gzCuUF0N2FbQo/7V5SppdJA/7fY/S9JDHud7gHuphyCLVJ5aPvU4JaxSefmJ?=
 =?us-ascii?Q?uVKcwNUY8k1UUhPyM5dDk5yEDjZiFqNjzp5+BjETWXKe7+uaoglUa5H4Eszr?=
 =?us-ascii?Q?1KT+H7Qrs4j4QxAkuR7vmSNxoLonqHo+/zMDx2k3T7WWsaKpYMUsQ63o6Jdj?=
 =?us-ascii?Q?ELCXsgU4WrSNGvpOCWokj5aShrNqj52pvWh9ylWHUN1GDv0oUwsw1kC1s/hd?=
 =?us-ascii?Q?3E2KtqOSIuFZy8ZejL/5WPEf8r9nKHdp2Dq19yRKQ3Cv86CrNkxKltYtlQRr?=
 =?us-ascii?Q?kXJ5kVnDGCuPYyuLj4Uhske3bJ1+lVRRXIwMjVZpmTt2lPvabw+hUApQpt4l?=
 =?us-ascii?Q?yEoblK1ZnSvAyaYPxTFLb6J/pieswm3KDpIAzGNfz9twPka1JvHMjQEz2f4K?=
 =?us-ascii?Q?YryHHMP6SK24isURDpTO4djIB0mN77X7SWB/+UaJfYbiPLWbqv5pfxxBhkgj?=
 =?us-ascii?Q?nVGHjGQRE2jgkiWptThMPbEX3PorjW4s97CbHvrI7CJLY/tYOKZH50wAvpl+?=
 =?us-ascii?Q?I337gSPKz/c3GYylTxZAskGxhTXwCiOexjuKPUulTgxcUPONcjqeRvqYWeM+?=
 =?us-ascii?Q?tN7bMVmk8+TODf1f+2pMP7dT5wipXXLSLvkxy1wQzp8C5pBlOe8gSQb1OCS5?=
 =?us-ascii?Q?qTBtRLvb3uKy/46HV3Oq9Pqisvma4EVDTfk/yOHcQyzYBkABpRNoient3eg3?=
 =?us-ascii?Q?qylgScGjs7V7i7BCM3mJr7CpFPTT49736KSs7ZwObXFlFFpQOX5trQ4c05Bh?=
 =?us-ascii?Q?uq3tY2unuAuvc+7xlF30On+q9b7U6ffPsN0bq4pcDrOrRw7URncTz3u9I/B7?=
 =?us-ascii?Q?Jr1dSjOJvynhX9r26CpZIx1XRllywMmuxS9sgJlwnfOazNAvnpPuc0mg9P5V?=
 =?us-ascii?Q?ZNnUhK1xzi5V3kgRAGckx6R52+XIyQXA6+YeyIwGigGs8/skQyD6YB7qCtJj?=
 =?us-ascii?Q?Z7jxLzYtiX8EvLpltEILgrcp0sMxvuyqMGMwIkz8MG79quCJsk5YGWJy/BTq?=
 =?us-ascii?Q?aRiQNl/UvRqU+rW7/J7cC453BeuNehsewro0M8QNwQWEbnidAoGcAc42KLuI?=
 =?us-ascii?Q?94LuvGP1ghQe1KlZMhHI7OqT/ry2yJGlN5IJGkvYufkD9C1CqyAjel7vP4UT?=
 =?us-ascii?Q?aBXhrVNrKmg7zuib+KiYOWly19+80iknLNtBCdio/VYd6NArLxu3CUffSDV6?=
 =?us-ascii?Q?XvSmm1+yn/dJr/yLol+spd1P0Y02zYMx/pBC+cAN1aDoNgJKY21Kym8NvXhv?=
 =?us-ascii?Q?xkLzQkDTR9GC8yCFsCsbQDmYJBOEiTI4Rpnqg6FcCatLlqFlf/xl0jYycqQL?=
 =?us-ascii?Q?uwlorTD1yYsYRpL1WUfnKUXsS7XLEiy3KpgkqJnMEJ9Ig1zn6GlqB1G57CHG?=
 =?us-ascii?Q?L/slBOcb2DbM2YFyWukIETHSGYakJQPJ+AdF18QxuBxkQkM78DTteGZQ4s3B?=
 =?us-ascii?Q?1JqLfIcz04wd0epzT78=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cb1728-9e7b-4244-ec74-08dab7757a39
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 17:14:01.7269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRp9C6QGkd0h6eAayNPcxBoAvkBFq2s+BE4MG29VvLYDapy5MXezwNllFc3j7SNA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 26, 2022 at 08:58:23PM +0800, Baolu Lu wrote:
> > +	[_IOC_NR(_ioctl) - IOMMUFD_CMD_BASE] = {                               \
> > +		.size = sizeof(_struct) +                                      \
> > +			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
> > +					  sizeof(_struct)),                    \
> > +		.min_size = offsetofend(_struct, _last),                       \
> > +		.ioctl_num = _ioctl,                                           \
> > +		.execute = _fn,                                                \
> > +	}
> > +static struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
> 
> How about making the ops "static const"?

Yes both const's were missed

> > +static void __exit iommufd_exit(void)
> > +{
> > +	misc_deregister(&iommu_misc_dev);
> > +}
> > +
> > +module_init(iommufd_init);
> > +module_exit(iommufd_exit);
> > +
> > +MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
> > +MODULE_LICENSE("GPL");
> 
> Could above be "GPL v2"?

It should be just "GPL", see Documentation/process/license-rules.rst:

    "GPL v2"                      Same as "GPL". It exists for historic

> > --- /dev/null
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -0,0 +1,55 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES.
> > + */
> > +#ifndef _UAPI_IOMMUFD_H
> > +#define _UAPI_IOMMUFD_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/ioctl.h>
> > +
> > +#define IOMMUFD_TYPE (';')
> > +
> > +/**
> > + * DOC: General ioctl format
> > + *
> > + * The ioctl mechanims follows a general format to allow for extensibility. Each
>                 ^^^^^^^^^ mechanism?

How about "interface" ?

Thanks,
Jason
