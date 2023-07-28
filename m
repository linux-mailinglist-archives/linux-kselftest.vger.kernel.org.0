Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB87673AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjG1RpB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjG1RpA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:45:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D140C10CB;
        Fri, 28 Jul 2023 10:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR8U3K12yE2JP/0SyyBEvYWoUPJlM+qrhaEPhp+TqYyRyMMh8m5ulCBn8mT/eJUXc1EpRJL9xaqJ/gitumryBLRMowKOmySVVU1bzGBWsQ1DSISAhZZcWbhQoqOu5Lrs1dYWdocoxXmU48sreF6xyvgshyH1eR1H5lk/vhHNpEBEKf6EdLVHWsmtn9sfR09W2UESfncwOKh4oSy5sdXrB0pFu6wzDkZPrd3YEZaRrCSiglKLNqGZpLLFIsUB/vtn4zze6LBfOmIkibNdDULP1af4O+rhPesBC1zNOSkG11RDPV9Hhb22in+4gm6scPM4XbumOpWAN78QB/qLYvQO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYEVtr6GvMf4zoSXv94IFXgiiOXFWFa0gWy2SxQMWvM=;
 b=JGUkYqJGyhP9REQ5URElODr+atBNVVy4K/AeSHOimacXohJYPPRwqMJoxrT45zd0nUA5Q53hIIVM8umxNmTF57earAbChO2xYBLJDVVNGFMyWCx5QaydH/wGDxw6oeau7/Gesv7ftT7dXqyXeEa6A1wdGT2vE26Q49Gl9TNPpt+mVdsc1I8gfu42hc1S24zLnfEmrwP+QS+e7ZgokQ4Pf1KyjVWAlZgnnh9jLvD7bxO9EkUaV/Ar3ROrS5RqB1SscRWb7EbXAIvDpyMKN595+z6R5WUejjL56eizNyoblo8ReDiqKV2bzT4KviAMambriN7hM8mVcM3BjgsTol5J2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYEVtr6GvMf4zoSXv94IFXgiiOXFWFa0gWy2SxQMWvM=;
 b=BtYuLnNlF8nrrPH8kHS0iRFRu/b1MCUVWgLjGO/0kRc/nAEwDaqxjZhropgaKekKL0R4IbJPLKKnuzOgbdiv5yopcGmEFhPrfZmmjlJlw5FA6qtNfXej3cRQRAHwRMNBQ07eSm/g+X3o/9AlssMCGJRJknI4vPGbwAmq7hQsEAm1OxJlHYvGidD1Q+hsXwMrILKS1I2I9+DFqmwKU/XxPtUuFtiJWZnFk5tRitC45D5vA1KtRgwLxml+dZYlPIaoyXtZpK/uZYe1Z8a21k9Y4ctC++pjOKsHrYeoFJ6sxuhcWsegCtvlzHD1VTt9WM4KI2PNZFUknkUGnUQRi0ug1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:44:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 17:44:56 +0000
Date:   Fri, 28 Jul 2023 14:44:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Message-ID: <ZMP+lvbhAwEbhjx/@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724110406.107212-8-yi.l.liu@intel.com>
X-ClientProxiedBy: YT3PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: f173542c-e5d5-44cb-fcba-08db8f925b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KlR+wU5GMsUNMrf0MTuKxKw3LrHwQ8jkJOfLGlwdkkAlMNIFz+ILF1zyCT6ZgRWkyVNq5YRmtPokoZV2tj9rCLKvm36+igzz7r7GbFwmzJrPy0tcUfvYgzZhgXPblImq2IJCINtahNh04v70XGRhkJg5o41UUZxZmn6hkonyLOTDsOFOhdJsvgultkDjzwNFdcuhz54uz6DdyxDTH7M9DdaiLu4B65aokkEHawErbzxKdZVUfu12ng+iB/LFdzcHiTFyySzLLuVIXg4GCVa7VHhfuaUmIOREY1WdYuj//DUXVgDz6MLXCHX6EY7Puo7iAClMEvA387ZZdNYUquqbdza0a94HApg6aLh7Ol6NA2uqyP548p2I55kCM7nDmjL11WTobOaX7kIi0rFnGshgAT69QQRMZqa/qPyy4MUMIPqbfTjz6bjHkk+a4dHz9dvKoruIgcXWcNB+GoLvZg2Go+gx6YXHaZEd7t6H4BDrwDMajaCMvJqKgkPSoYrUYQ/9qcu+c32/RiQ2lzKf01PaxaDbJuhISXYwS9FHMoHOptfJZ57PfMyhBp66kGcPMht
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(5660300002)(41300700001)(26005)(86362001)(66556008)(38100700002)(478600001)(6512007)(4326008)(8676002)(6916009)(8936002)(36756003)(186003)(316002)(66946007)(66476007)(6506007)(7416002)(2616005)(83380400001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMu2YQtgEod8sPhYeUa+XNL/38LfWTIi/OrSysIxS7kt/fZ47RCNA4v7HFlu?=
 =?us-ascii?Q?nTDYjGkKgb2m9SyZl3+Z+Gu/sIiUn0ir87dn/OdeCiz7thOgyAs4cXKJ5ulC?=
 =?us-ascii?Q?zyW/ItEwD2pUzxwkV+2FsSHa3hngE+ewB59q4g9Flse7BurYEXU6Y9uXFlDx?=
 =?us-ascii?Q?EwQQ9lwAgCmU5pLvc2Nifst25MUOuge1tcQv7l14LYgnM20E/whhBX69+fOE?=
 =?us-ascii?Q?p+J6Vv1U8TIVn3Atr1CwOQTT5hqyiw3j83lX9Rr+QSjJHD7E9KrfylF/IXto?=
 =?us-ascii?Q?RU9TQXTtaou/lS1zBWEvNguap4mpF5z2FsSrlE1CtOrF3DM8jqx69mTm9WNa?=
 =?us-ascii?Q?AAZoDjEfWbHEJTlSkM5fV61Wk/efFAMI5wZFTiOD7uez19z7H4KZhtBXr701?=
 =?us-ascii?Q?xYMhoISETFBmPzshGZ3oIU4h/jdslHKYdCK6HWIggr6n3VjKahPH3WNwiOyn?=
 =?us-ascii?Q?H6U3Y3mjzb78QA0ZHboNufHf21a6/a4FSs7QgeJryPeNycKzvq70Z3WIgttZ?=
 =?us-ascii?Q?iBwJwuGg6Fe44PS8SMq20CNpCHndwJcdakfkzRE+sJup4HrpVTcsIc4C6rSk?=
 =?us-ascii?Q?kd4/crIEvM1hFB3tPBfMfNgAifjaeIjyGTyBK+J+MvFh3eqc0R6Nm8jhK6+d?=
 =?us-ascii?Q?jkvrCLt1/ocDT+/fuJf9zGAA0Rq+/K4mhkUOdyk9Q2u7hYgmc9x7s2f088To?=
 =?us-ascii?Q?rkCMkCGTQsuZDQyV3qfrtijb4GNne5oNt5DYARMdkUtGXtYu7COIUmrxJbmb?=
 =?us-ascii?Q?nS4kvu/+6Fv3tgAuaKjfHiB77vDADEAdgzBiyoznoSfOgdxxMZjdsYehp4i7?=
 =?us-ascii?Q?l5jKUjSfq20m+PAIuOyLDMJ4KLWnXrqoFdPJxEUr2ZTTFB6pgNrLph2dQGqO?=
 =?us-ascii?Q?9nXKRvBxWTmwcy6gF/d0qPDjj2bqaLI7ZIZ2eCRVBuWvGpkiKsRXhehC0CDE?=
 =?us-ascii?Q?oknjZNFejxZGusk0rESptRfnsfw6TQ+pOY2H4jnXI7qyX7dTONwZ0vM4wxIx?=
 =?us-ascii?Q?fOYE5d3Ac8ijEUeDmaJWdgCNRHKiyPHkqubiixkInsSgN42oUDIA3lxozXsJ?=
 =?us-ascii?Q?HlG0u9Na7qQHl1NzBDedXZXaBnCMtZjxqe0jyC4AOMk4e5oYtonnaH54ZJcd?=
 =?us-ascii?Q?mbI5zYY+UVMQ/9ozBXJiQJjfO0Yy3iR1lFVIRQ1enLy2d07gttfHNzFJQzbx?=
 =?us-ascii?Q?2bzeuQ2TfUXfe5GsTOZ2CP0y6UCHJcgLBWlELr/fAbCxnarw28Lse0z2xqsA?=
 =?us-ascii?Q?whUJGHZpfx9FquhjeiI7KicZt6E5vSDcAhThDqBRDeZ/XxRHAp/Rb/P1JNCJ?=
 =?us-ascii?Q?OI2LpmHZp+xwS5WMIYywezDfOdiT7xiARUo1MDtmt3eiVlrRIMLoYb7mwLlq?=
 =?us-ascii?Q?0orxOKbHYv1zj4a9a1Q6iJoScxvp5PWVi14ZbvQCbJy8Pg+ebp86wzf8NzYS?=
 =?us-ascii?Q?yOuAhJnWQ+1fd7bGJbWDrtpahTQXUQ2a2qvyIEG2ZBWt3UtyA9z0ihBksfFA?=
 =?us-ascii?Q?3wpEMn61AcdpcNV8b81LadruQN4u2Jlatjs3aV4KE7m+sLBtQ2Mhm/Cb0qtF?=
 =?us-ascii?Q?+Eg+y8U56jIyvCWG9tdf6XbqLU6rDGRHG2BOujuV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f173542c-e5d5-44cb-fcba-08db8f925b81
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:44:56.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCCi7zHihjPrGIGEvjCVspsus5hdRkHPkUAJ045LWTWmmAYixOkZ/QYTWvkik5P9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 04:03:56AM -0700, Yi Liu wrote:

> +/**
> + * struct iommu_resv_iova_ranges - ioctl(IOMMU_RESV_IOVA_RANGES)
> + * @size: sizeof(struct iommu_resv_iova_ranges)
> + * @dev_id: device to read resv iova ranges for
> + * @num_iovas: Input/Output total number of resv ranges for the device
> + * @__reserved: Must be 0
> + * @resv_iovas: Pointer to the output array of struct iommu_resv_iova_range
> + *
> + * Query a device for ranges of reserved IOVAs. num_iovas will be set to the
> + * total number of iovas and the resv_iovas[] will be filled in as space
> + * permits.
> + *
> + * On input num_iovas is the length of the resv_iovas array. On output it is
> + * the total number of iovas filled in. The ioctl will return -EMSGSIZE and
> + * set num_iovas to the required value if num_iovas is too small. In this
> + * case the caller should allocate a larger output array and re-issue the
> + * ioctl.
> + *
> + * Under nested translation, userspace should query the reserved IOVAs for a
> + * given device, and report it to the stage-1 I/O page table owner to exclude
> + * the reserved IOVAs. The reserved IOVAs can also be used to figure out the
> + * allowed IOVA ranges for the IOAS that the device is attached to. For detail
> + * see ioctl IOMMU_IOAS_IOVA_RANGES.

I'm not sure I like this, the other APIs here work with the *allowed*
IOVAs, which is the inverse of this one which works with the
*disallowed* IOVAs.

It means we can't take the output of this API and feed it into
IOMMUFD_CMD_IOAS_ALLOW_IOVAS.. Though I suppose qemu isn't going to do
this anyhow.

On the other hand, it is kind of hard to intersect an allowed list of
multiple idevs into a single master list.

As it is, userspace will have to aggregate the list, sort it, merge
adjacent overlapping reserved ranges then invert the list to get an
allowed list. This is not entirely simple..

Did you already write an algorithm to do this in qemu someplace?

Anyhow, this should be split out from this series. It seems simple
enough to merge it now if someone can confirm what qemu needs.

Jason
