Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30160EC27
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 01:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiJZXSa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 19:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiJZXSE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 19:18:04 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72702B8C0F;
        Wed, 26 Oct 2022 16:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8U1rgEqoBQDM5RGYrZmspJMhXqz3A4SfeQmwwPVkz4zFL9rplxqdqpbtX994ZcbZ11z2tO9YvwtS3UyfnpsO3qaTulOKzXuCbNJYXfraJ+39kCdTmLAG5laIOuyhyEMXtAafZm92O1Uwa/LxqTsHf4VnYI0J0/Qp/MrjSbVoL/6hg7U2X1srQhbkzPK58j6NNHYe/kU2cgZC8Fpo+aT+PR8ruPP7QVrtUUCuJzaKuJGypZREkuZAcV5p5fHQOu4FXMa2cT8Agv+RO7KcuYAi1wMC1a45MIFWIADLehdbKr+fbzlpkQemQc7eHcZ1No/dP2zB90Bg/H1hZpUlZzEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGNiizTFcUwCN/L1ZiKc5QLrDNWfMbQatWehMkc23Kc=;
 b=dnNGS/xXTlwxawfFPdTBX0OE4rpPWukMZ7A9if+6l9vNQqJy9Is3abaK7tCfeSYuRfnNSfHNiSEcLXYf4H7KWzd9LPh1kCjt0T098E6UvVJlV13E49S3owvcPY2LiIasYfhsjtX01w0iVM914uoEKMF/kU1gix7vJfO7cFEP4MnAR0Zld5k2wl41qOgQo9movwKdnTOaagJaca3wSdGkDZ34f4VPNliqhFObNY8uCPCPWj3wxOSUmyprY4z85JjzQ0M72MBC3RNI5w8hXZwDGOEtnlZq5PVS2rL6BukhCy24TGYC3jFfr7OuP+hxfAERDW2M+uYLwYEzftTVbn1xSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGNiizTFcUwCN/L1ZiKc5QLrDNWfMbQatWehMkc23Kc=;
 b=eABlgKZAgTC0PGVr8VfgnJ/VNOepNuAYt4a9BALH+fzdcVkRfbZ+DmHaKA77Y30jAbZrVIEMrjDiHWYfkzRHIIt9uczQWqnNjoYQJlOp/oMcHZ7uThiQPOSzcOd1+ZeVvX/DVor/JzqyXe5kLQ680eMy84Mi6dMBpOdgZd73cvQ4eAh8+kt/FVyiDJ6C0DGAwLy6AO/JckA5FVdPkPBkxvZyAC+bLRX8n/tHbLGCLJo5PFMlOOTgAn3QiFBV6HIhPOQldpt+bjx1k+gVGE6Ahm/BC1EHW1E23EWWhCEMVryRYn4rsiRTtO1ARBd5ccrB81WMLIc72fabLvl3VOKA1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 23:17:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 23:17:38 +0000
Date:   Wed, 26 Oct 2022 20:17:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
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
Subject: Re: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y1nAEfNBYMswuqiM@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 52103476-c604-4e6a-9645-08dab7a845f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRIGgkrslRYmykmLkVqpIis9Q5bddhHJ/aajie6Gwu/oD6sPUdFv5qmjWa+eDqmWrYYwasTb2Q1NYf+wYUH7CcbB0yR0PRlHMJH0irtG1il4OChKeLwV4igCXRyzNE7wS4g5pVzHAmF3Rr11o/CgCMfOSbTAt5d3Vhyc47cJQF1C5ujptbMpfOXQU1JE9OMsbJ+zGMKUFvLiNVcKnczj3A4TIGq9lYMFcEEYTNf/aL2NgE8KvUcqprLORIjD54rzsRBc/MkQulYDDTZzSP+0rhJqp/qj9uFdYtYpheKRg18Bobj4knOo7I3UckFM+SHmS8HQfuf9xnBZJKEQjzJqgJn+MB/gMI9m1whcAe5UNIKCW/C4HeEAvtWjLQCVo6hQDFvZ1VuGEGFzGECVvUxAi7FEHSK9M0kpIeM1MwGp2RkTuv6A+m12fDvC5A8b4mNzswqQshmC1OfMbcIEfGmlHh2lrRy0FLuyuzTAlO5K+k0LfjuxgOCXIjoq6ssN7itBtM020q7Cy5HxEFk94Y2LaUzLy1CaSOHbC1F/UkfPgYSUK0aOL3sIF6ThyxG8MkZ9rGui+uKm5QcEmpVJI/EdKK4PIctmQysHj3eussWHPH98joTJLnpj5LVENHOnYsM4cWtVmqCC1MKaOjLDocsPhnsHMg6qtmq2pqVEZAmmp5BC1Kuz9Zjn88zsv3ZtCNKKgl4UKOiQ1el9uRHQ+mPulK95MyUbsRZ3L5bjVRgIMIM5XGNYeHmmlYSB0gRJH0z/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(36756003)(2906002)(54906003)(5660300002)(921005)(110136005)(4326008)(66476007)(66946007)(7416002)(66556008)(41300700001)(8676002)(7406005)(8936002)(316002)(4744005)(2616005)(6512007)(83380400001)(6506007)(38100700002)(86362001)(186003)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+VG9NLWHAzftHcCdcBU3VT297rcpkFdFleRh/83AFwecWpEh4s3dDGUbvZUg?=
 =?us-ascii?Q?zdKja430W+9dhmVHHoq0n1wnwRS4rn18k5mSiEMgAdaR1PLVyB+zDqKF/Q7U?=
 =?us-ascii?Q?K6X+ZgxvCYsOkO3ODm2/5mordrWUg63bio+ZFrsYtMzf4TtOimzMrb5lIEpM?=
 =?us-ascii?Q?amk2X4teemGHYzxV+LToqgP0oETjZfUlqvl3KqBPS47GC/jXqDGlbygIfijk?=
 =?us-ascii?Q?2VhyfilQJVeUiJd3AUst3uWnMCeCvYUc/Q04aLVaSsvsV8+uilmZIEQzIVwN?=
 =?us-ascii?Q?EwQJldI+F32HubhhqfOzb7Av/XTWXOffSVhedKCc/yH42/gAkcGy1rAPvjtb?=
 =?us-ascii?Q?QLiEOlJGAARuYeSGVtZwfuHUZKGGJ/bfVPOzymdy7+bf4g+1I7cjEGBPcUxw?=
 =?us-ascii?Q?o4Id7N2PgEi/z7S3nPQ19YHGXm5CNlwaYq5BAPk4wxiEjdqbBUlJ6JhW7PIg?=
 =?us-ascii?Q?LQN2oNBlyKh/ZG65bEZpVP4dOxxPpBA/uxRkuU4A/3wL/bFfdLkm2zIZyI2X?=
 =?us-ascii?Q?0ouFJQE1/cM6RsjANyEI3XXG2dzBr7dgGYrnSC7BewwVOTyQrxTw9mO6YMak?=
 =?us-ascii?Q?Ub/MJHZQ57/xN6BlgUOLdCgU6QuvWNRe3WHjWpZRmk4Tcl7nRENHpI18Icyh?=
 =?us-ascii?Q?F/aMTzRIQfO7gpuUX+eSZYAoUj/P3fmynO5+LU8KdMDqNVrKLV/Vq9/aYYTv?=
 =?us-ascii?Q?zHvM95oLRW/RUy0masVB9Nf+XTG8Tl1q9qHCa/MdscmjUv5WENiTjjUHvt1c?=
 =?us-ascii?Q?viEnlMJCR6/fRzPaYfcgFmUwJAsexdJtadlaF9keskK94uX6bz0eYiKtzVBj?=
 =?us-ascii?Q?cBSqiRjGyS+NET+ugHlYaHkiaDt9ThXcYa2tQRdHza8aeCcW6UtQlxtjC8xq?=
 =?us-ascii?Q?ORcEIG/GPLENg7phS+9WEY/2QdamE23n8d4WKIa2djkpIOqHxQFaFn4ukneh?=
 =?us-ascii?Q?i+OaEZPgLpq7oEanhNxBTEXqDZM0Wt2zZVcCjYjjrAt6msUj5cF22ZMBfvq4?=
 =?us-ascii?Q?uIxahLKePbi+xyvELFjFmDKilZuWEk8GAEVrPJGCzSXe1f49A8OV6CAkb59P?=
 =?us-ascii?Q?Nk0YwPAqYNXgvEYzUUZEINDH/Xqtobbu/OEufW4RRs3GbeTH8wZuZuU120qY?=
 =?us-ascii?Q?wBtRwNpAoMbZ4SwiXI713MQwERu+XvyPlUGWglJdKrnIgjcT/vjXxhUWp27D?=
 =?us-ascii?Q?RLI5PnL6MsNUmaBVHtSU1m7WG99KcbSTbycyMrhhjafAM5T6tVHuiLJShOap?=
 =?us-ascii?Q?U7yUSHUiNzFW5AFhJrmKDvvebESXX5KpfAafTJYYUcYZc2lzJgaIv5RBmind?=
 =?us-ascii?Q?pUG9Xk23+54Dc+6lbG7ebNwPK5jH7qJNoF22lDITekNuXhFRLb+PscwyzQJZ?=
 =?us-ascii?Q?ruzrkd39LBEV9ipgd1W2/fuW0u7HeRs6iQqMGtUcoxbpsMtc8qanRLqyWUGp?=
 =?us-ascii?Q?1e9g8jUqeXlfsF7pFofHSycNrcoZTZF2fq+9Of1vYXrAdjRSUNkck4rCOtZ/?=
 =?us-ascii?Q?Pz7NgyFfu5B/jSmDfsMmvK9+ygE+aRxRR8iSevIMMEwqUEGJF/ZKVchrStYc?=
 =?us-ascii?Q?TYMk2lwNzCps7zIomTYQHxORkNd1/Qavdayvs2aI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52103476-c604-4e6a-9645-08dab7a845f5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 23:17:38.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LOFoOFWi3WHuIlXKV9yr0iUfVZMGQ12CLwrPS8WoKgfOdY8rOZdoKLXfoHzzWnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:19PM -0300, Jason Gunthorpe wrote:
>  static struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
> +	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
> +		 struct iommu_ioas_alloc, out_ioas_id),
> +	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
> +		 struct iommu_ioas_allow_iovas, allowed_iovas),
> +	IOCTL_OP(IOMMU_IOAS_COPY, iommufd_ioas_copy, struct iommu_ioas_copy,
> +		 src_iova),
> +	IOCTL_OP(IOMMU_IOAS_IOVA_RANGES, iommufd_ioas_iova_ranges,
> +		 struct iommu_ioas_iova_ranges, out_iova_alignment),
> +	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map,
> +		 __reserved),

Syzkaller indirectly noticed that __reserved is no longer the last
item in this struct:

        IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map,
-                __reserved),
+                iova),

Also added a test to cover basic struct extensibility on all the ioctls.

Jason
