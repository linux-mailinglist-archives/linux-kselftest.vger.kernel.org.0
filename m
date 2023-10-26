Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529F47D8843
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 20:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjJZS3D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 14:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjJZS3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 14:29:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FFB1A7;
        Thu, 26 Oct 2023 11:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHqE+ec9uv+MTTJPfHhExm5UX8x+JGqMubpni24syFBMs67JRJkK1s399ooEIqLKZJH80Z4/tUatbrAzUQPtpDED83s+axZ0UZR0FzN+IyBgP21vMgr3B1ndZMTP+Lm/fWEayJq4hV6R+ehqv2cjLJHuKPIwywxxgqAkuIUiioUiIWNE98bVJUz9dmIfLttLo4uLE47GN8KUxmIyLGg9T5TaicbWD1+AQj4CcHJ8eTdbtsDl+iRpAUeeRQJI9KEwtJqyEW7NY7Lf+aMV+ceWqPw1qpXirMfOsZfNuL/m0sBZCCknzkQHFCspoZyBcc2WtgCR8lYvUybKBe+q4TYcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/u7feCbaKbkc3BXs3vMIsw7zLVFKt5ceoFWFbibRzY=;
 b=gITfRa6c0IkRQRt3Yqi7YgbT8sMqrMLk+R1xb5LcGg+T1Sh4OI6vnKdZazqD9ppiKYGHI1i6QeOhOvLltvCHtbzuFD260sc9htu9/9sUHs6vaiypeb1t+kegbPdehew06KyWjgcQB2SjcUdPKLi67TGsBcfY1upxICRgNuCT8329Js1h0CWm4Dt7ZO7grULXhminW7ttFT6SqMO/FlwelMNkwfE2uuFSc7Ec1Xm/GLk/ugrBDDUgNyoKzODgFgKzXdUWyLK1YzuX69xjYPQAgG8sX9YrAEpK8vuo2u1pwVP821pxr6t6seKzXpoNdzhWm0UwqBeMMqsqyonNZdLQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/u7feCbaKbkc3BXs3vMIsw7zLVFKt5ceoFWFbibRzY=;
 b=AmMJviwJip7IJxH3JsNtv/oFbi3ghExHMrkj/9gM3NHMdGIMJf7m8cQEtf2rDQ5vLAyvLU6d88WBe4qP2MxtOHwUHCFU5Fpua+SVVn4c+6xwfFCu1kmNFQZZMQszXKDZ6XLYY7czPvRzvGkHVSTIHZmOvcvyXmjlxBMTVBgoZfLySE124kl6HGEYTESgFs9KSD6tMIRzCLI8Elq3/BbTiGoja3FaoRBqbXj9im5sPxkKT+Rab/HW4zcMMJfUblefGFjpqalMdLu6WfUL6GUTftJHV/GAFsPG9wzyaaMt36N/jkqHr88iFWqinEvXVV7AVSFHk8GyNxYxc0GjPDok5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 18:28:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 18:28:55 +0000
Date:   Thu, 26 Oct 2023 15:28:53 -0300
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
Subject: Re: [PATCH v8 0/8] Add Intel VT-d nested translation (part 1/2)
Message-ID: <20231026182853.GS3952@nvidia.com>
References: <20231026044216.64964-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026044216.64964-1-yi.l.liu@intel.com>
X-ClientProxiedBy: DM6PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 63206796-a66e-47cc-38fe-08dbd6516965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQJUJHNILVY4mi7ECvPwWxatB9UIBCXENgXm/xVgBdI5ztnL+H0FY1yVPnTdR4m/Q9xh/xfqGsnAe/zu5UDOUHFaI+ctYFy1buRK0nDR7sI3/+bBNAy2bTlk5W+h63EYL0Ej+d/GxZhH5fvP9720iRz4/9x3rE6GC6WjXcno5QxH/rmeI2Lv5GYRakMt6YfZW84hatVyoxO/Po7cBH373B+2PQUUqQRl1UI/zeLmdNzDDgGzMVqAG3/WJDQrRU4luwETI+XkPKH14mfu+7pIIiXohR7XIwCTtMJ0P3l13u/k484OioHsRuH2W2gIyVZnNV/K/+o2fOD7m1NzKh9BZrVoN7N0jUwXQMoS+5wJ9+8uemBaY0l+lWYb3f8masRnJc442ib6JEOnIjJX2FepxgPYe5us7e/7KqdVrXC8hNOx4orKd+3x/U357/FelR9z5VXKlO00A+AOyyIgsrTYRQOrvD7gbginItiUM3Zkd5QyJ+MD6fp3m+sn9FzHdSDT3F8IncEqLzhn4bWkBwIJRAwmtjEDWnp4J3mvtvFRzyVJdcalax3/uhCQ3l9GM2KI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(38100700002)(86362001)(2906002)(4744005)(66476007)(316002)(7416002)(33656002)(41300700001)(5660300002)(4326008)(8936002)(8676002)(36756003)(6506007)(2616005)(1076003)(6916009)(66556008)(478600001)(66946007)(83380400001)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MNA2KsMtJAR209NTO1AdKRZA1oLq8KokYu1dIONZrT269iDzhREu/ok/2I1+?=
 =?us-ascii?Q?AnF8l068yb33t3YFeCokH3+/zMADQTwXYMBTWX5hvsPo7K46ahNVZivKytX9?=
 =?us-ascii?Q?4JCB8nXtrQc3ymsWPCGiyuX8LttLzxX+iELmIpxHcBxd/9gbgf3/9wvjDvv3?=
 =?us-ascii?Q?FdpGYxZbdqnrW+GdWgtNxblaZ1zRSrfG0IUq/MEkscigz4cBfwHxWwTILwnj?=
 =?us-ascii?Q?JGaNWLCcK2X/k6Nd88w8ApJ2ZVq4y6p/+Ia3Yr/6zjXz+zMZtUj7YfnuQcry?=
 =?us-ascii?Q?bjYx//64lOLHweo5a1u/DkW7hj6RHbZE42pojV7Kn5zkoGsyBVJW8U3qKp1y?=
 =?us-ascii?Q?lNHSvDqe9cSTt6mICWeZ4s4+3oCp4Jr1QyJ7O9hVqD6SNXKj5z1JlVDZ2XTD?=
 =?us-ascii?Q?fz8VaSCGiWNDRUbZ0DaCKior6/iJqPKaUGyjlJlSQ67HEmQJ3OqSyHaQW1Ld?=
 =?us-ascii?Q?e/6ulVQVzB2VJADZ2rrQdjtDIxK9ZcULY2rh9sYuqfj7hU01TD3fxM1607P4?=
 =?us-ascii?Q?GOpRTEzCv4uGPaJA61knNxiuAzHR8vMV3kQGBTeDxY+yclpn8ZUWNkrZYAuc?=
 =?us-ascii?Q?F6aEmEO5mDc6/E8MH/Ne9oEd/93LACFC+ezJ2H2e8eqcnBkZxau/4HZdqzSB?=
 =?us-ascii?Q?vNLyi7SwFVOpz6fAt3jZoUbrIZ83wnVo2NtvGp2lFTNw0bKurYgrHjpZkd/Z?=
 =?us-ascii?Q?8K8/HiuNf4/2F58v3uWqy4WZqB/rrGS12ogz7lpwxrS/963F7i1eABYxNx4n?=
 =?us-ascii?Q?GSRZOn4OMNuI00rTQR0UMnk1dR5Cyc1ncSxPOVnE0F6976Rh6HnLIhNvaz6W?=
 =?us-ascii?Q?C6/bBZArpJTYMJnjxjn43XoyoJsCnjs40OHIjyrn1aeAFHCO6xH0nJC0ito4?=
 =?us-ascii?Q?z8vvhp6DMJ8YasORDIYiqfovdFUtKx6bsGLgi7j24h3qH1fmzHJLihRb0EBd?=
 =?us-ascii?Q?aBqI/FecGSHWg8czzL8XT7Y7nhU6XQk0JithIsRV6aWfwolCvU/qxSQlFAHo?=
 =?us-ascii?Q?Au+3Dkx60Y7+mG6H2VwO5TI+dQtW1NVfRp8V5ZsdY7s1sm6HhoKjm69ajdUe?=
 =?us-ascii?Q?heIeZepu7kHoyetYj7EO8oB546Ac1EmtHbEtHMEJvNjjq5hSRTbfPACRZpAp?=
 =?us-ascii?Q?1a3axloS99vREloDCIJxoSuPHC2xzQonS6nzLqB7IxJkQghxc5NbZxb/hB8f?=
 =?us-ascii?Q?gNePIT/XhtE/a3DhukptFOIz/pxAHTTuWHfX1lo8A8WnOW838MpHkbSfHHXX?=
 =?us-ascii?Q?DIDrvMNOFKFlBBlK04Ew+XJnU7wV/ujeGM9/ZlVxQJ2gtKZQ6EHcQLy91YYt?=
 =?us-ascii?Q?/ey+SsVgbKf3uNnOBxSdjnFR6WP5uxY45geG9AgkOBUCiRIMwBFnCzOEHzf4?=
 =?us-ascii?Q?k0ro8ogn4d/Wnyl3SqfZozZQliAnMb4MB2qCKM4v11CkaNP8OsxtkOI99LBB?=
 =?us-ascii?Q?ZBUSL4AnPz7zsXFF/vI9fxcGbfOs7GKW9BGKlO8CfDPdyHuSul8LVvQCf08j?=
 =?us-ascii?Q?Rwb470atBHOYs6NvOc+XFw1316IsAwWxV3yFOV5JBCQZ4938AGf/DWirkBX+?=
 =?us-ascii?Q?P9KnXGPE0igJ5Dg6k3k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63206796-a66e-47cc-38fe-08dbd6516965
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:28:55.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8czxpLzb0P8CEslpzmC6FilidEnCLHNfvgu+UeofxNdQ3j6jdfAbASPV0DniljGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 25, 2023 at 09:42:08PM -0700, Yi Liu wrote:

> Lu Baolu (5):
>   iommu/vt-d: Extend dmar_domain to support nested domain
>   iommu/vt-d: Add helper for nested domain allocation
>   iommu/vt-d: Add helper to setup pasid nested translation
>   iommu/vt-d: Add nested domain allocation
>   iommu/vt-d: Disallow read-only mappings to nest parent domain
> 
> Yi Liu (3):
>   iommufd: Add data structure for Intel VT-d stage-1 domain allocation
>   iommu/vt-d: Make domain attach helpers to be extern
>   iommu/vt-d: Set the nested domain to a device

Updated, thanks

Jason
