Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3057D8840
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJZS2u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 14:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZS2s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 14:28:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B877192;
        Thu, 26 Oct 2023 11:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKQFbS77apq99tTOiHalZC0vpXNmNPDZbm4LncNiAc+WkmuViIyeD6YSPt6fPRGYJTBd0U8BeLOaQi+XgYp4mxGnF8AqSPThJfjTeN2N1F1imDIZtEMLbR2/OuIcbmD41/Mt4cJLYMIDWNt6SiyvvUatnkvVA+SiQIpAp94rEKQIExAlHREopNil1UF1EAgRcR7oEqLAd6v6WnukhRsvH1R6u5HwM834BoJ4AhmMuf50Z34+OuRZ42EVS5Nw3mMksg9nOLJBihXnokVJSSU9I8cKrXzlwB8vZerBjsjV6CfL+A5+0sou2ybt6eDzn2EzwakTjbJ6UBiUwVlDF3Kt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvt4AxRp0YOZYUUyEC6uDhVDSCEbs2JZ0PZsIqymznk=;
 b=Hmh+BmJkvWxVMManaGLJL4Ixl2ZP2nHNYhPRMmwhYNRrKqCJC4YOrqLIA/aUeHF6sj5ejbQg0LMTP+ST5qPxSSSwQg7f/SjHYeIdao3RAGIjv/f7PVkvb+JzdO9DnLKyOXhtQjz1R3jDINFLMJXUgiVCC9qO8j1sfeHbURcxCRhiKwLRlgJco834JpRp2No85ezSDdvnEynPvuM7UY0J5b6xGKo5QDVPgMS8dPtS+wILOZRB6K/kgA0fd80Kpri7h6KHRlol3eWIxNu0hYWxmMW9VeKI9uQ39uRaSZy3NIFAqNSAHu2lcCB0qTyTe9J+8UvWFVeOu1cv3Z2+04/3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvt4AxRp0YOZYUUyEC6uDhVDSCEbs2JZ0PZsIqymznk=;
 b=QzUdLHjxmqhkYpehdqYy989EspwwYYuAY5RxAABtBA//TId8MqzSgaKXNvKzh59nG3XRjk9GSbWooaZZ7EoO64F1APMSjndb0fxgas4ydjUrT0n6b/Cpv8DHAF+Y8PoY+iMtG88PginMTH3Sb3bAuR938r/IwoPZNlDj0EXEOoGIJoncXMCSFYlHRDlpiOQmS6hFKDyIUra7XzfG0W02XLXsincMyLpHncjFxViWoZxnNTzfUmgFQ8TuKnJCupw0BWlejgIXne7hkrRW6Cn4IUQbMvy9+9thbZ7DoRabSXrXwj0YtxeHt76PXTO0sw4KrfGEUZ6Nc8UvMCEUYj54tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 18:28:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 18:28:42 +0000
Date:   Thu, 26 Oct 2023 15:28:41 -0300
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: Re: [PATCH v7 00/10] iommufd: Add nesting infrastructure (part 1/2)
Message-ID: <20231026182841.GR3952@nvidia.com>
References: <20231026043938.63898-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026043938.63898-1-yi.l.liu@intel.com>
X-ClientProxiedBy: SN6PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:805:de::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b06d299-7d82-4c79-8f73-08dbd65161e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUSpQfgmo6y0zVQ4lv2Ik1ljxZIanRP3X02nh4NVKqzfyYC8RPEIBL2Z1FgURs67hwmR2i/jK0PNn146rC4WXNTf8mqEMbCQoJA8vOGO4bBJ4vyWmrYuRsnBLm2PvT39YTm3SX1Ku+SIE5e+wAWqh3tGx2jaZrOX3z90852sTOp4AvOt42IRiwPhjVZedvlu6owE6DujRVmtz8xSuLCacFy1MJXvBDsutTrUd0G/9ra+RjEMmVnPtiVYrbw96jWs07NqFIe+GiIqU6ke0gXHINReoNFbdKitamI3llusveNTVNAA0Z2B9HJccm2LKBDy+EYliJo610tnzXbYdosw+0gLx88jYJk+JA3O4XWKCNo0xHPiU2bj83MMsjwI3ax82szn1Ku/WVMlGdIYoxPCCz5LxMTXOqDR8gvp1FIZ9tJn0oB2qUa89sCXVWWpPhFIEUnBiJYo1uuhFKg7U8dk3ij0VDY8OW3/Xe8lucbUBvJcFnfOeOyQQteZSt2G3OyJnm3XzYtwIbfDIu1tm2reu+oK48wyV7jitUHS48AkTZdkp2+KembOeXXW6s7koRqM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6512007)(2616005)(1076003)(26005)(36756003)(33656002)(38100700002)(86362001)(83380400001)(6916009)(8936002)(316002)(66556008)(66476007)(66946007)(4744005)(2906002)(41300700001)(5660300002)(7416002)(8676002)(4326008)(6506007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DkryHO4WtrHosTPoeWstLMrhKp6j8l5B9BNOB1/M6xxbw7zeAn3OT1wmTBY3?=
 =?us-ascii?Q?VLUKRRIEmelxq7SRCz5Xtf5PR4n3kKG3lsssh27r8h0jHRhP1/EXFlWDiO6r?=
 =?us-ascii?Q?fuhMI35SVibjhdOeUu+TiUQjWDiIlmmNE8SdRRZGNqb+JiKuBcSa6aa8pEnl?=
 =?us-ascii?Q?IligODp3sh0g3txRkCDoBY2CNKfSrESeI1UX56DI/saifZbHk9FMiU4zQcYV?=
 =?us-ascii?Q?6ZUmy3NkWWLVSsO9gfNdVGJ6gNyO83DiB7Ag8t+4uoc6BND27EUfnu9k9x86?=
 =?us-ascii?Q?GN7vGXMLzCrUPqnxnpU3yCpGxUGErDal8C/GXfzAbsSVA9DFagtMSnXA5VkV?=
 =?us-ascii?Q?Vv5hgj3EqKQQJRnmACl+fTgCnGoM2JRpyZzjAZZj/yCanv/fSxLC+ToIhP7w?=
 =?us-ascii?Q?RpAbkteCBXf3dm/jjM8eg+QoFqG2FzSnNnQbY0jrSyd/Ju/Dkqq/EkE0rPVd?=
 =?us-ascii?Q?bZCzTVX43na90RmWZfa3uhzDweIyYNPaXAoufM4V5CY0akOufdMQaq+Kr0uc?=
 =?us-ascii?Q?8zFmLy06Op3m0sV8ROaeMVHgX2qh4v8Sv8HZlDi8pz9+EoD2tOf9irsiVg0r?=
 =?us-ascii?Q?HbK56QcXfFnqZUtejGlHQHMEDjjfNOkyVMAfhc5O8aH+YJRmxeolkjlS07rk?=
 =?us-ascii?Q?PU+oFQejLxVuSvVBMKIRinVKiZd0URvKTdJl77nLJkXoP+D6wNyIk6kJdoVC?=
 =?us-ascii?Q?GLnxnC3dW1Zo+aqI/zatzUnEyKhzgBNhMkYkC42fwhxICpmnP+tQuoLInuan?=
 =?us-ascii?Q?lfWt8Mb9ovBpSY7bGGfSZkn9ajVAfkDq4Hha/lnYHh3lhu0G4+N/P3DcNl/i?=
 =?us-ascii?Q?gjtkU5TpC8x0iiVlXmH/v+3hNNCoHKksSBd+u9Gw9EEaBY22e42MqZ+dcemc?=
 =?us-ascii?Q?554bUlgaU9xo7JsPUdpxbq6akt5Y+TlDOZiW406rPFUJS5vDTDWZG36h1fKF?=
 =?us-ascii?Q?WNwjyM1qqU8LpYbjfg5Pw7NktiAZvzHGarJrsTNt2e2yo3i09UJmSJ2zym5e?=
 =?us-ascii?Q?QWx9zlQbsuAlNPCiOzqXN6Mx0EWD5ePxAEUkMQ69rXGYCdPiYmVi08TC5UHP?=
 =?us-ascii?Q?6CkvHUNcAYnO7i1HPdzqN5YZTYIG20+tkMKL2okxmW5EpgtyrjALE/oht9aV?=
 =?us-ascii?Q?ztP9XOOudUO3CsW12dIrPzVI9TD+s1gcxL72VUXhg76vT4TSnznzu5ZtsrNi?=
 =?us-ascii?Q?ursTjNK9b/W9RScX1WacaFdl7gdbWjTpcYQV+5iGfuiqs36PzhXbRPOt2kWp?=
 =?us-ascii?Q?JeeTSv1y+Mg7PE8Jc3cVKMBvM6CkzNJsAKjUgstFV8IKMC2Ezic4POiHhi6M?=
 =?us-ascii?Q?T15Kw2kyOfcf7ivIMcFmTA309LqKEQx7sfjN4jkmko3GiXi+T0As6xg0DRmE?=
 =?us-ascii?Q?gsz1vo+8ICvvgBXCPRt8Qjg8XKykYeFVuEE5lSU58wFjJrKZkxyEb2/C0XVW?=
 =?us-ascii?Q?h4tti3YTzSmOZQvRIFiI4hBqC6zN8F7i4KJapbcRvdkDUpvQGiTACXYEQEKC?=
 =?us-ascii?Q?GmSd4aR9aWZSIk/4PbUQtltWVvHJa1x4tOulsq/F9fYTDqXv1LMJN6OdBZ9Q?=
 =?us-ascii?Q?MmH8qPPvj3Dv4Z6aYZs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b06d299-7d82-4c79-8f73-08dbd65161e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:28:42.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdWRBqxIjq8FgwLvGsEKdHufvfBtNaH4Kv/6btJENvMrEw2EQZKybmoBOMafaqbr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 25, 2023 at 09:39:28PM -0700, Yi Liu wrote:

> Jason Gunthorpe (2):
>   iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
>   iommufd/device: Wrap IOMMUFD_OBJ_HWPT_PAGING-only configurations
> 
> Lu Baolu (1):
>   iommu: Add IOMMU_DOMAIN_NESTED
> 
> Nicolin Chen (6):
>   iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
>   iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
>   iommufd: Add a nested HW pagetable object
>   iommu: Add iommu_copy_struct_from_user helper
>   iommufd/selftest: Add nested domain allocation for mock domain
>   iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with nested HWPTs
> 
> Yi Liu (1):
>   iommu: Pass in parent domain with user_data to domain_alloc_user op

Updated, thanks

Jason
