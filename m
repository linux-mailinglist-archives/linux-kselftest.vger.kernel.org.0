Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD39780FA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 17:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378356AbjHRPzz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 11:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378360AbjHRPzy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 11:55:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C68270C;
        Fri, 18 Aug 2023 08:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/trg22MaEpuAN2Yxmpof78Gz9belCC7QPk616EHHco392ntmcg04lweo7WMoyrpFf0OCKMOlOmScJeLADDIatjjNNa/QA2Hyd/SrLrJFNeMKyYww0SWyUXYrn/JKAeheiEgSTlgRuKFLGo+KcyN6DMmLcb4yH+AttITwS7zvIhQ57yXcTG5QKDVpqEp6CO5VAiCcnPI4TSjdI4Ntlt/MvCtWAUlqrlxfogbvfOgqvdBi/mbCYAY0XqPJuQ0PyyQszf0XMUlpAH7NDQGH7aVCe+myZzte2Zyjbc2c/ClQTc5eWeLI8NkPt3yBmF2OS2U41wVDNNvB/JbR/iplMPmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5tVJuZInndTTgwa2rSIUFCsX8wwsuubkUte+axi0ys=;
 b=IJIBuopSmF5OwvCt8UaOoX7ZpcB4VljLrzNl5zwXTZs005voDlpN+H/ALWFcPQ6c94ERkXFewHpSY1Oj+INyutQlwZ0uPhyCrHlOfxOW15LmsUbXxJ+ROE+6NBpbIbz+ZsAG9RB4kfExHqfAkfWvFiNcqeysahgyEmbF+yDYlWzyUY00+se4hux5kFZvipAZz99MIG2aABgTkf6ddqv+qJSg0zVBle+KVqHrVfDwb4PmeUFd0E4fP0vy4Ua/VuyIQK+7mK3hVgRYPTXkWK4IxKFRL18Xq/z5YmpGZQ7fiUO1JCosCcBY4AP5HAgMWX9li5b9RpMv5yPUFDTA+XD2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5tVJuZInndTTgwa2rSIUFCsX8wwsuubkUte+axi0ys=;
 b=TdH9rwoXo3E8iJ2yUxu5mCaRwzFJnZwdWVCPtFJgd/GJnYT8Tir/wXNcBIOs0P5Pl5ApjX9oxgZsDaUxgCgmE3yvElZmFKo3ukWvL605oysbR+lvRYYdWu0nks0pjY8lRBHb7CTHM/pDQ67upbu+7QuC5cNyVennQ6aFr6QTB+b8r34hc4ld7LU9bIJvw7NC2Dva7jJeJ4FvEXFxUu6bfvnoQUxyNOTH5GjgMdVCBnbDvdxdDSgo56UmA8ZXzOyuHZLAP6qVFRWj/mEYrikIC0aqRYRoGcqX/Xg7V4z+4pSZsMQrxPcAKqvownPzAoQRXIlHFMeQkG+mynzdPRB/OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 15:55:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 15:55:51 +0000
Date:   Fri, 18 Aug 2023 12:55:49 -0300
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
Subject: Re: [PATCH v9 0/5] iommufd: Add iommu hardware info reporting
Message-ID: <ZN+UhR5FDHmMNcNV@nvidia.com>
References: <20230818101033.4100-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818101033.4100-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0322.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fe8fdf-72a9-4816-c3f4-08dba00398b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6u54tXVuMCSJ5Y9OgINqsyXP59cFvs3Ox5YgHm+RYet6QpIHL20Oa58XjJuPl5ZFPzgiJQ8l+4saaEQb/QVNEgFZAtWGwmupGZGvqc6FCeBu16p2WLgIsKEb+/IsW9/A98KUMXGqVM7GKTO1kkKQI6aVfhn9MPmRPXm2lkcfuNsROHpzaN2gKaOdwbPFkvTx+lhvKplTNad4FI9huzdGpWz8iVGqKYYjFB6vpKOIqjukVjoooCJw8xrNY+ZM9j995V0bEoGmYAy0UM9yoVrY8//wm6zqx1IxfNxcMMZshV/mAqJ1NJcFBsUQWsx/ev84JUFcJmoVICTDASJhhjw/vyqSWdbsUMcUKfbNbyR+HDRwV13O7WdwdXwmjL0Nofa1o8D2oFV4Tu/iVK+3z3j+f9L+5u2s2aiZcY5oUzf8FZuDAYIoJXrz05aXI4qanxRihKxYcFqlNpK10AgcFX9zDc8VNDgqwQ9mfKUiNvKzY8+IjvOPYXWKaunZu2eUnS+Y0W5pH9uezc6NuBwj+rZtENAff2RVTrRweZb27na8VAmr4Q/VfO7K1UyuhNjfNEQjv8de6XsNh/psmWcUsvFFXsOPXvEoSSMmZnDdAYhvSzdy25mSOeQfIu2gMkj//c88L9qzNNSj+T9E0DQfE8fzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(86362001)(36756003)(38100700002)(966005)(5660300002)(2616005)(66556008)(66476007)(66946007)(478600001)(6916009)(316002)(6486002)(6506007)(4326008)(6512007)(26005)(8936002)(41300700001)(8676002)(7416002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fcAj8Pi6AeJZ8qXBDGFwaZjdM2bWWoQkhCoShfM0uYkcHmAtZW4GTCEfKOP1?=
 =?us-ascii?Q?Y63Q628yhouYIvZ4SZZgNG08MyBc0LL0nTS68FBowfWsjmMmi037lhXBxToj?=
 =?us-ascii?Q?8hYSR9wWO/HkpXGVNDs/ALHos4P3MVuoJwlJFV+hScahYdnqbk4JctPn6yLx?=
 =?us-ascii?Q?tjkbQGqISl6Oxx2j0bhTODS1bMgmXNXjzkinStNBk9WbufIkqS4wX6kPG2+o?=
 =?us-ascii?Q?+QRoas/l1ApWMgt0PS9dXk1BccWENfEXUAgsJ1h82GuArntDg5mx+Fmkex8Q?=
 =?us-ascii?Q?5Up2ZJh3eOr2LBv8lgHcFGQTDKIT95Ah+YSlyWbEMr3DqmuUC3YCtAOVgtJg?=
 =?us-ascii?Q?56vqiY0gDKuLl0nzhdSb4QoJfCOyn/0jsVnXQiLCtZE0gE8MXzJdJaQA4NPE?=
 =?us-ascii?Q?Yu+F/qnF8xMKWP52WdcJ8C7m1E+fnnqO0WN+TyGIBcmywoL2Oz+D47Du9erZ?=
 =?us-ascii?Q?rbr2qSFtGxEpB7PN7VkFNN+CvsNSTPqaiIMk4xLt3o8y1bV274g2CfLpjZUg?=
 =?us-ascii?Q?qA2ovoiYo4FZ7uuxplKkMQTyhDwHoCGR3iH8Cjit8we+Y6zsydXmCmnp8VY/?=
 =?us-ascii?Q?lHb48jxPQwg/L+qFqOe7a+cZpm2dzRPivJJ34iTV+9FJqVwF7DCFRcEx3kJ4?=
 =?us-ascii?Q?0XTvsh5wPMmpjO7FuYZOugzWE+FukShyNlFloy2oblHVhnD7urxZ7EcT62WE?=
 =?us-ascii?Q?7kiFtJRU4SIqm81KP+9mBNP9qf7QQUw+Z4KmMxSoVWXT9H8JfpMYhuxuws7X?=
 =?us-ascii?Q?aRsJX2QQlE7TWGBisIUXGNWAyBAjk+aeVKWd3oDxchuPgfGPaeUe5VGMcZmO?=
 =?us-ascii?Q?pbgE/Nrwk+6181IbgYAULuHu4gxDLF0eO31515CAuqscpzXdnSVV0bjqV7Vn?=
 =?us-ascii?Q?x8yUWUM/HFVTFoed3IM2ELSHzF6eykajRwO0Bgmd+pKYpdPjRKo9kNI0o17T?=
 =?us-ascii?Q?jQiadrIFIhLpKfnp0pigkrSmRV4tFHy7MpROCYGddjYAGROpujsJJdqv31j6?=
 =?us-ascii?Q?h8Y7If2m6wzz1f4iFZKwiYvVCjoh+2jxS4Ymdlkyx2J/Rvh7YCqS3YAUJ52R?=
 =?us-ascii?Q?gWdUVi1QShSvhPIZpsIq1IjPZZI+g2y6Sawg9D757248/RmFycYS2xfwuQ7z?=
 =?us-ascii?Q?HdDMsqGxCGP0o4+4tuu+iapeZPnnSTvrgjaKJoBweVCpdKt66SR68xVSW0qP?=
 =?us-ascii?Q?yZ2YtuVjO1lZhtgUYTSgKz63OFbWGE7AQII8muEcXmA1MmhRrrLLp19ZU2s5?=
 =?us-ascii?Q?0Yd4AAxiz/PGfxt97KMTQrXhEroajnCtplREU2hRAzGvllhUH7E/RE9KQIKd?=
 =?us-ascii?Q?2cqgSY19V4OuELN/5lhp624xJYj6jVKnnnG8oYADsLgjUZ0iQKHuX4hW+BZo?=
 =?us-ascii?Q?moQ8/PBLWFadlG0XJ7R1tr2B5xRBSau8pI7bY7Da8rtkgH7pxajuC+jl/ExW?=
 =?us-ascii?Q?+utwRMwjVpZyV7wXtM3eTBCc5Ifa84Cjn3HNgg0GD+gXXgbw67H5q4HOIyGM?=
 =?us-ascii?Q?iqfDpsqIWSWeULwHmNsKEy9R+p7rD4MwUUZ+N5JAziJG56NkgJhUBmmdU+QV?=
 =?us-ascii?Q?9jNxCtnGQ1zhneZ/73m3NXDoHLI3o46Eq4TB6pUF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fe8fdf-72a9-4816-c3f4-08dba00398b7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 15:55:51.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9O5XgQL+tim9L+Fr/VvZymsTmBBAfPrVDBldJEFySSoek2yhoVidpSe8BCViB9T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 18, 2023 at 03:10:28AM -0700, Yi Liu wrote:
> iommufd gives userspace the capability to manipulate iommu subsytem.
> e.g. DMA map/unmap etc. In the near future, it will support iommu nested
> translation. Different platform vendors have different implementations for
> the nested translation. For example, Intel VT-d supports using guest I/O
> page table as the stage-1 translation table. This requires guest I/O page
> table be compatible with hardware IOMMU. So before set up nested translation,
> userspace needs to know the hardware iommu information to understand the
> nested translation requirements.
> 
> This series reports the iommu hardware information for a given device
> which has been bound to iommufd. It is preparation work for userspace to
> allocate hwpt for given device. Like the nested translation support [1].
> 
> This series introduces an iommu op to report the iommu hardware info,
> and an ioctl IOMMU_GET_HW_INFO is added to report such hardware info to
> user. enum iommu_hw_info_type is defined to differentiate the iommu hardware
> info reported to user hence user can decode them. This series adds the
> framework for iommu hw info reporting, and adds the vtd implementation. The
> complete code is available in [2].
> 
> [1] https://lore.kernel.org/linux-iommu/20230724110406.107212-1-yi.l.liu@intel.com/
> [2] https://github.com/yiliu1765/iommufd/tree/iommufd_hw_info-v9

> Lu Baolu (1):
>   iommu: Add new iommu op to get iommu hardware information
> 
> Nicolin Chen (1):
>   iommufd/selftest: Add coverage for IOMMU_GET_HW_INFO ioctl
> 
> Yi Liu (3):
>   iommu: Move dev_iommu_ops() to private header
>   iommufd: Add IOMMU_GET_HW_INFO
>   iommu/vt-d: Implement hw_info for iommu capability query


I picked this one up to iommufd for-next, thanks

Jason
