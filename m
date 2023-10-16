Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B7C7CA720
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 13:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjJPLyU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 07:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjJPLyN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 07:54:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FAA110;
        Mon, 16 Oct 2023 04:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1CRQfnr67sAZGxPdi1pYOT5apjl3y1dbKw0X5/NzqAiiftLAwm580TUVRjp7rrn9yrWqwGtP4/I3Xk8+FXCRp+mfH6oTL7uj3KOwlrBQk4HX+uE+WEz4pXdt/CyTI4B1YoaMCZh/7yNS5c+MXmvNZXM6QelQsiy6lPpoeswqz8bKjoypybJY9h+FqD7ve6Ikhm0qOkjbZ5ERq+2kHy2RvnhbYJvcHobWqvFrqp6cbs0wWArQnBjKkebJ8lqDodthm1gCwgIltTIKYDTfxrE6MEpIHwX88s8uxq+ZmjjtuqP3QIqgJWsnW0d9sRwwJzVJ8OYeoYSRIcp6gX7xW6eZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFeT9PdW6s71txQpJ8G3lYgXQJLtThQKcGWpoJYKg/4=;
 b=iRooPDcI7VOEDl1k/ZTk69nxXQ39LTbKiVXUZoXiPWEsqa9fTd9RdjI+fQTfIS+/+CU1a+87IOgwowOV3txW+LZrg/VPzFK80jvVB2RuA8nnHeL+do1mLmNtaLK+zDfdj99n2Oz7ERX1ZSu4Y5gzxrsXUo7HcV319sZLJNWTq/7l/oeRAqtlwK7CnZ9GDDE/CrOJ+J/vef/bTWgKhGTc8CFAN+3RAaJcDgCxr8H1obgiXb+7SMZLHf5gMOsg74hX8LOvT/Up9mUHbRrM0cEV+7WUH+aBHrzoy7sftCPyE7OuG1KzHXfyShJiVhJ2jOEJhhN8wbsy2JfE+y+TKwtQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFeT9PdW6s71txQpJ8G3lYgXQJLtThQKcGWpoJYKg/4=;
 b=Bpmsa8GdMgjhF918+KQAQHYnkXX2iZjD09x6KFmxXO2+rfuG09bUIdCnmveeJHML/M5NupV1T8IUKuCFHVr7mMyR0/9xq933PW80F7qWaFoZh1fc7Y0kWcjbqTORg7VsI7t8nxx5v/1zhVrIZSNXN6gMjjPwRARU/oQTEodj9USrdwV21wE1ZWUhWLlOYehyPR9Zh9q+thZnb0Pf0Ept30dQXGha+w6oVPp8Uk67Tn1mLQFubNWghxXT/LPnEx64SsokN8QWe0tRg+eVG8/EQ4xII0e2bfCatvlA1lqSrpK11o0E04Q01a5/mqi8m8OfyxQNSzapALCEFFUG3AbFrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 11:54:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 11:54:08 +0000
Date:   Mon, 16 Oct 2023 08:54:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20231016115407.GO3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
 <20231013140456.GR3952@nvidia.com>
 <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
 <79f0cab5-39ad-3d98-3896-6e1ba7b8db21@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f0cab5-39ad-3d98-3896-6e1ba7b8db21@intel.com>
X-ClientProxiedBy: BLAPR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:208:32f::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 8013a175-610f-470d-014a-08dbce3e9ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0YNLvtZQUfu3/dCuSFyQN1pTxU2EoAdWqVjBcGY15Q/iJXRD7uPMO4ZCghp/VsbX62/tcQXwORMCBmRUaj3DMb7vRCaHjqgnaz3tFpKiejt7kUHBQ2wOD0bMDL56Pmy1a0PfDMcszq7Flhm5h9nV4YHHSGdv+kwA34vLUeIzPVPxQaHYyaKWukPYIZDYzx9zzwx9xD3yamjQ/79SCLbxvdIkBaEl7+6EaCKb1uTrorBwiXRXICwh5Y2whJ5DX3BmQ1NWZBnhyWT1OzyOvap5RtG0jomrJ9ZczjzooqmCPuBMH8uY0g1MxAiAzN7n6C+GjfHeqraItSVC//0gQ5D6Bc6XBcEH9UVK3YSmXuVztDdE0bvG/b0Thjoqt6SolyWniGfOwYsjOKPebT8o+qrnOVPYUujUoulqdEYcIz3QZgbw+4kAIssSsBP9GRpqoGO06+hJaXDlP/FI4hmJY33cYhKVH4OBeWx66Zp0eH3Mj7YpYS+J8Rr50Js0NOSudgLys4jcCI/mrJWoAPt8Aia+qz0qB0fJtIzU1iw9wYi+pVyrR1zjDGOHu/jCyjKTfu3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6506007)(53546011)(33656002)(1076003)(2906002)(36756003)(26005)(83380400001)(2616005)(5660300002)(38100700002)(86362001)(7416002)(66476007)(66946007)(66556008)(6916009)(6486002)(41300700001)(316002)(6512007)(8676002)(4326008)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ifXOTlO7AJOssDgPnE6aCEaFE3gViHhI+OfhhXe6PHNV+XD+zbH+TBvVUvoR?=
 =?us-ascii?Q?q8ftHTp1L+TlaTViC42oXONIjZtaf7HTFv0qXJalDgEtmxL7J10XbNPPYn2p?=
 =?us-ascii?Q?h9xrOz0uUwgzY6QcolFtU9WGE8GWkNd9Q9PlAId2h66VCDjllMP2LCOaMS47?=
 =?us-ascii?Q?LNjob8OL6UAthfgw/CyS4i23b/Rnco8V4/CL+GsFAeEffjQbIPJzASauDzOe?=
 =?us-ascii?Q?gAMaZWMF0pPFFiazie2pkn30nByyOqAH+vDlFpxTrgt5z/3TQR+LaJW548u9?=
 =?us-ascii?Q?H7wfNRic3MpYaH44t4B/7j/+0L07zxX58mjJegDmNbPnjcPPyhNPdyOzpdMC?=
 =?us-ascii?Q?f6TJW1lcHteudh7jHSNMFay1144DQWrUV7BuzVEJd22qZFEw1wq9nCbsPdzx?=
 =?us-ascii?Q?lmo2Dc59I+6ZIKW3jYiwRcw272sNI3v+oJKFQkls6oh13FklFC21Hlxhccpu?=
 =?us-ascii?Q?MHQjyzFYv214lSQGIDz6GnJKE7T+HnaUDd6+zcRk3RJ//dMkTINaBvskVTL8?=
 =?us-ascii?Q?0eBkDUg5Ct3ZolpmBpp8hS6u3zB/1/i2J12JV6XoxNIOGNoQ7yYMW1P27S3C?=
 =?us-ascii?Q?Q0f97CTB7LiQt25UfWcke6ykFG1YqGVqeYVJ1dbwZ7BXVdjiDyGJ9aqRc2SY?=
 =?us-ascii?Q?/JL0TBarlEaZ2C9cjoxTDsyTALSvpJ8Nnphek1RDEuU69EywMrLB/aRJ7810?=
 =?us-ascii?Q?Bq8tRE5suZwbYrA+j/skkMIyE4Y03sBno8jEbwVkQPvU9HaKtQxAMPQGZ3px?=
 =?us-ascii?Q?CefFB4b7jB3t93vOcjLYFIuvoG1tvlMmcTVOmEP4D23JavOEObKkHkObbhd0?=
 =?us-ascii?Q?08u0AF6ztZxdUMWV5WyNlJE7e21q7poneqWOF537ie3uIjubqvCwGhPYufJe?=
 =?us-ascii?Q?oFBdmYoV2uSBSeCcAwVQpihoi6qSa69s+nwQxHIm7wiB6ToUIwgAR1oBUgpy?=
 =?us-ascii?Q?+f7yaYKR2a5N5nuIO7JwPcXXQWieWtD4cOcEb/4DPEIWfZo3KGRUh7jxKshX?=
 =?us-ascii?Q?76tO1T38MEOv/INJ7U5E9pcF2Jq7bNnocN5CfNits4f8gyVbXIifTKQxgJ2s?=
 =?us-ascii?Q?XBbYxloS/K+oi6HTkQAYeEgDBIvBGgF98qOijTnv16KQHV28ILDLsnIAqhkK?=
 =?us-ascii?Q?snJ6RMCBaCamyACxlti5MZ0W36mskTKD8mNaX4xZQpFodvkHpXEawZkuxZDT?=
 =?us-ascii?Q?86SspoXrhlUNq+A93eLUXagvMCY5kML+Qzx2n8E4zk45TlbJFZXABJStEHvz?=
 =?us-ascii?Q?Xlx2Meql2cE+41qWlPpXfkBOo99TUX5PV+CBmVa7fPlrUU4YEy+X1ACfCWkp?=
 =?us-ascii?Q?sIxpZAtyQ88lUAy+ESxJHpPBh8Vfi8kD4gUM5Cc8PWQ8WYMcApCVIDJ38LaC?=
 =?us-ascii?Q?uCnOEp46EZWrrI30tw4ntNGq0mVb2Dv3uEbSvqBHj5q8bz0euklHQueiYaH8?=
 =?us-ascii?Q?mP8pHNHcQX+5FNuekrD3ANK7vUd8gy3yrXI8fKKQx7gSznVfBGKefIUqQIRp?=
 =?us-ascii?Q?tOrVqh3NYfZrmYG8H85WaifPduxLTglQh3ckUnnT9EpPjARxXPMfjBA8xWyn?=
 =?us-ascii?Q?ZbpfwtdDMSGMu8gBXc4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8013a175-610f-470d-014a-08dbce3e9ac3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:54:08.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tuVTYistcnBStKgMqYYQnIKSBo2NlngkZc8VnvaAxp7FriAfXRwmTrO0yb4UkRA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 11:28:15AM +0800, Yi Liu wrote:
> On 2023/10/14 01:56, Nicolin Chen wrote:
> > On Fri, Oct 13, 2023 at 11:04:56AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Oct 13, 2023 at 12:33:13PM +0800, Yi Liu wrote:
> > > 
> > > > not really. Below the users of the struct iommu_user_data in my current
> > > > iommufd_nesting branch. Only the domain_alloc_user op has type as there
> > > > can be multiple vendor specific alloc data types. Basically, I'm ok to
> > > > make the change you suggested, just not sure if it is good to add type
> > > > as it is only needed by one path.
> > > 
> > > I don't think we should ever have an opaque data blob without a type
> > > tag..
> > 
> > I can add those "missing" data types, and then a driver will be
> > responsible for sanitizing the type along with the data_len.
> > 
> > I notice that the enum iommu_hwpt_data_type in the posted patch
> > is confined to the alloc_user uAPI. Perhaps we should share it
> > with invalidate too:
> 
> invalidation path does not need a type field today as the data
> type is vendor specific, vendor driver should know the data type
> when calls in.

I'm not keen on that, what if a driver needs another type in the
future?  You'd want to make the invalidation data format part of the
domain allocation?

Jason
