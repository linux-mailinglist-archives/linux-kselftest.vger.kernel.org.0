Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC77C8874
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjJMPTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPTa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 11:19:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150195;
        Fri, 13 Oct 2023 08:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtBtWrYWOz0QUjKzMqMUJ6IeGt3t++dgAdJdgYmBHOSggEXx/u2UGkg2o/0f2J/nfJbtjh3G09bCS1jPLvB7PanRGAfdvsmIQtf0Njm9PoNUVUZFt+WAMfNs/sBa8AOTV1whr6hQrKSg32L1MgXD1iKYNzj//5Gy9I21oSSc85l2tZts2/JpJWiCsg3UwFYdXyCuU8rwo426FmmIu08bnHnRor+TaUFJ7pftT5zODzlqueB9e33p2Enot8pF0ZQlCk8u1s0bOivHpLB/yNxLGvRUeUJZt74/L6gMviOCPQUpTLxZaBiE5vx4zKCIQxGX44+zsQPwSWK+tsy4bvFE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgcIl48qCBFV4P/QIC5nngJPL3QF+MQ7aqeL0zTG+xQ=;
 b=OllgO0HBUWGGIy63QqrYFaMxgJNiDcAaYnXtTOzh1n30XCbvMz1oqjPxYFRXEiXw2N4SgVq7CDw9SKDp++zGqj+6RCebkgSQ9BhXoJPmVebeNlhPln2YqMzlpSk9EddPRjgExv4FZjfBgm6AJLeXeC1XqhRjFxgEGPhIYOLlJRtfxsCd99Ccv6cguL+qKZWfDCzjyA4tyGZ9ZNz2Ul/zjUb+a9fohfPxYiEGL9wyY6nDl3MvT6HsGRBaVlLoCtq98UTc1XWaH295XP7GO/HqZ3lkHHvgoBrSl7AG+m7R2tEBOFg0J1jW/b9h+gRra/3S8CZKu7PsYjC4T2nBWyPBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgcIl48qCBFV4P/QIC5nngJPL3QF+MQ7aqeL0zTG+xQ=;
 b=QKR/VbH9601HnsLGy/BIAQVtEWb+dzcIoVnIgOW75tavpF7JN0YS+q6V1xpQkHdS42n79rljWMqPSLtNoUolq1QNNBIt4ukdwrMFa6ZwuktcCPXKTzP59Agbf427/4O/QgPKKG4C3NH9N6SI67GEl9+Io/DpoTlwbckWioE/p8W+OX/h2/rCZfVY4sHIE0xHmW7MQHPiWToJgCvnak/OwfLdA7BpdLpAVR2a4qe2EbJhAQIFXy48FFHvZtGj+UuTm027wS7kViToQMwQeUAxIv6VigGduFTKXjeKnjgZ3pw/atP8VZ8hyBIoPxwR95uKdq/nBepEwt85CL2XKxrwFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Fri, 13 Oct 2023 15:19:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 15:19:25 +0000
Date:   Fri, 13 Oct 2023 12:19:23 -0300
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 10/17] iommufd: Support IOMMU_HWPT_ALLOC allocation
 with user data
Message-ID: <20231013151923.GV3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-11-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921075138.124099-11-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:91::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b420ae5-05da-4ffc-cdd3-08dbcbffc8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +uZD0cd7pKDj8XfXnhJaLmlXRk85ddtJIxmc0pau55MFVBlAf42Wyfzby+M9whUwu2KgjcBhqlabiFkLQwcFpgeTXUEe2KTYH4qvlDn9gXLOmceERI9CVxZaoGXUCXdhQW2qSVivl/rvJptyFxEWpX6CXD9OQnB8wTfHRWQEq/4YMdC5I6Lq919MlvW82Kya1SJYsRFuTFLV5G2qNxZZsVwC0tke3bGGR9iVH7Yvk4gVcLRAB9WSNjW7bGDIp4OrnUB82PKKjVWNWHLlI167ttoO754GbdQsLAXG2SVS4Cpw35kddC3GUe434H35TBOJphUHBRjEcJZIMe1MydHxi1tLyX+E34d2zFVWfB2D1f8MHh7IxnqA9AvnceE86Z1s0DG37TnwGfa7dGQgR/WHL4onMv1Uk7pajDPHeoLywiDYXSn7+8OJ2Fy92S7cTXTW8qrNrE2F/nSvjujWrDCxKLG4Joe3iFgvnLYPKHVr0rUwvqLsRAVW3I3EcJ6vxJSzI4uYIQCVOrv2hMoCDVoAgC1iLAvPlHIDBVnhzZNGVSVjtzoY5MUs6+xDzD3Nf5OG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6486002)(2616005)(6512007)(1076003)(478600001)(41300700001)(83380400001)(7416002)(6916009)(66476007)(5660300002)(66556008)(66946007)(26005)(8676002)(8936002)(316002)(2906002)(4326008)(38100700002)(86362001)(36756003)(6506007)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r1qUX7mgEy2cLFmQVMoTKwnThiHryRvGRJfVcufocTVSzubuj5z+t5ffRWed?=
 =?us-ascii?Q?itu5AmbGVOuN0nmc0+E79lFHhgXCNWpqP3ZCu+XtEEMCz+fQmG1SHKzsHFXP?=
 =?us-ascii?Q?SBvyyTh+1XnCD5vPzFilP3D7eBgYD9WNUJqw53s6iDDiup45Qpqsu2dLC8OC?=
 =?us-ascii?Q?ElqtvBy1qKEBtknzOet1f8OSsH8uWTBz/R+Pbf193woJujBX64COGvl2I0Wd?=
 =?us-ascii?Q?SG7ACeOmP2R0pLXpryt6xIRJLwnSg3Oe7U5e7h9CBnJ+pOqX/HnKz0ByMgbK?=
 =?us-ascii?Q?4SZzzLfBZp2WK6XfjMJHHEefKO7VUd0siQkwVpUPBgj8sFJXKLX22O5V/WA1?=
 =?us-ascii?Q?Iqhjg4D4tv82j8f17WitQAxtHdoq64y4NIMb3Vo+KUtqf8SndOBBDciuwFOi?=
 =?us-ascii?Q?uK1cnpXXa2pxoEiJzNP3+jHb++kkfADRoNAIoLgG0nqiTlMGCpYKjR/hxh5B?=
 =?us-ascii?Q?wAkeHQypEYojTzDxNJ+g4MwgNlMZfjkmGh+dcGr1Y4W9axJW5SDRuVYabgFO?=
 =?us-ascii?Q?zrz6nGRcDa531zOOr/A3XOwOlNdGyiKRt4AQG3ZCbZDgLRUT9u3G1N77K++8?=
 =?us-ascii?Q?bTZO7tZtHGahJ11/dWSZ4LjnasMp7Xj9cxPMYAcTJrUPVTACMj3qvOk0MEy3?=
 =?us-ascii?Q?ZZjBkVnplNKSS2UCaUcq53L6qkwgkT//0rAja8ms4uXPPmtGebGIKvTugEYl?=
 =?us-ascii?Q?vE8t17sS7CAduZskkE7C3Ez/5oklifSxKXTEZ4k37TpZTX35V0qZTUme6xLu?=
 =?us-ascii?Q?mlBX67AJufsF/jsHXFmgccKhLQ7gpgqTRCawGGka9d+vJHA8GrH3Yd3QMgda?=
 =?us-ascii?Q?3edMHhzjZDw62jl8mJ7QR+xmocfGSflTVocjZwZgggTRArWGfL5ciaHLb3aU?=
 =?us-ascii?Q?AXw+UOkEiACra2yr7khjqMxEwJhyjt4bKSYAx5ppA8DCRA9couNYJUyxcjqh?=
 =?us-ascii?Q?8exD0j0ZIZPXMb9KBcag0NP4WIOw+uQAp1XyrTM1vwrHxMuft2QZmxdG2s5P?=
 =?us-ascii?Q?KgEKJU/og92Txbd93ZMQ7gH4zueSt+SxTTbnq7N3wo3Od242aSpxhzFSaSNO?=
 =?us-ascii?Q?sc6YetsxOmT+rTo8vt9hZPki5RvIuWFDDEUXFd3VqLdhmxxSmQtsBEinR2m0?=
 =?us-ascii?Q?JGxcPnKX3Q8+u0r476dlIa7yUH8Z3W54Y4YiRUPgnhkDzm/TXqPu8BjTkJTJ?=
 =?us-ascii?Q?/hdx4Es1eK34m0jfitEtS6hlNqwtxbQzBYaZde9Lm6QRIcA1P/sVM9j3sCIA?=
 =?us-ascii?Q?6C6V6d89iqm/9n9RdGtQWRqW71NvwDFDSbm1arRMtjiygmS7Ou8oqtxGLmrA?=
 =?us-ascii?Q?WgwJOR1+2Qf7sYzsvvbGmoC1sA+aMKj9QABIE+fOGIlqT+752Asu2+BxP+R6?=
 =?us-ascii?Q?8GO/bicxrq/yr/2GWhJQ9vi2c2pvganjmJ1vOf/NNmozThrHKYjwMSdcRlA/?=
 =?us-ascii?Q?SKV3LJFTQmvvEUdRxSq+8iI+YOCxWm26wCLMnCujTowUiJ7G7ztNdwZwP+PS?=
 =?us-ascii?Q?wwjSrHWlTdX8fkM+I20hcV1ZP/6jhnnDep1NLo79XC4FHHbMuHjmIRzkOihB?=
 =?us-ascii?Q?2YYjSZWacyMOvc1mxsgOSyekDZLj4ogYFG7TO3hB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b420ae5-05da-4ffc-cdd3-08dbcbffc8d9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:19:25.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAIkwM7oJgohn8JJtkBigh0P/TIOpaaokapjSIyLOLaJkENPJhRr3oF0xcfHRUFq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 12:51:31AM -0700, Yi Liu wrote:
> IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
> But it can only allocate a hw_pagetable that associates to a given IOAS,
> i.e. only a kernel-managed hw_pagetable of IOMMU_HWPT_TYPE_DEFAULT type.
> 
> IOMMU drivers can now support user-managed hw_pagetables, for two-stage
> translation use cases, that require user data input from the user space.
> 
> Extend the IOMMU_HWPT_ALLOC ioctl to accept non-default hwpt_type with a
> type specified user data. Also, update the @pt_id to accept hwpt_id too
> besides an ioas_id. Then, pass them to the downstream alloc_fn().
> 
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c | 19 ++++++++++++++++++-
>  include/uapi/linux/iommufd.h         | 23 +++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 3 deletions(-)

Can we also come with a small vt-d patch that does implement an op for
this? Or is it too big?

It would be nice if we could wrap IOMMU_HWPT_ALLOC into one
self-contained series and another series for invalidate.

Jason
