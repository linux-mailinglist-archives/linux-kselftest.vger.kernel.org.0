Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6039A6C6B21
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 15:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCWOfa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 10:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWOf1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 10:35:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223BC2724;
        Thu, 23 Mar 2023 07:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGC/bShmV38YK/NNfps7aYoP9ZxbzNujGC6qUZ34kk7ibqZS82zeiBbPhC3ME6+ZCsbGUt/42S4/fA5kxpHDFvQGageiO4NNdNR/buyVN5q1H+rN3PtSNZNpN7zRge4Ec0hAnBtWhA8td09kXq82h1yR/T2MSwOUCudx/rdne0Zac5yJgKQ3g8qMoqi5Kaj5NmSDqFdy3NK3NDBqE2YPt/LW2F7irFnU9W8C0AoC7wAwV8hWgclHM/8CS/gr2ZmeskRO/3DXEKhAaYeV/Njr4sZxPaHSS3WmKe6kN289b92dXnBTb3t/YO79r8mJ6YbEwKLkziStv15/XUSEOVx3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx9kRGxOm/wDdvbXk6xB0OgU5QO5MmyceReOTXNwfgk=;
 b=lX4m6sBlpsTYIt5ZGAuHenwOioOcYUu/5u9YB+N3wblUHFOw8LghsmVVlRdr38WzhG2PvSKnzRK0z14phTdjVGabLviWr2iI7qeGpQsjK/x/5QiKAl/94ajGnczjLg49yavAq7qrmf/4vxMB18viYvN4idE2tiLruVngC9kAoWW8AadsAzphC8a/uJCrOAG/MKWu/Amp+TOGgM2Cli1ZjV9Ht77dNsvUy19vKygdwlAqdjcVWOri0sZp5zLnyJF1gAtGP2QXYX5a63rpbhJSbWxDoLHCPIYQaMJbRKbxc/tPVBkMMHs4xXp266H0X3eB1E8Ka3tCRivYsXh/U0m6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx9kRGxOm/wDdvbXk6xB0OgU5QO5MmyceReOTXNwfgk=;
 b=Hm7muHQwspv/SbpkUWeDg5NlkdM5u3Jw7cFyyqb9Xccli/VGANwChcJaMeE6RwDYp/PqgwZNMksGWOVT9OsfwRvBytSpesn4d/abaQFOEVh77+XTbVrioNd/eJZVkUk6oXkggeGJOxwv5dhfXR8oih2EypIH4QtpwGyVcmMGpKK74fUNKJWzJ0bHxEaQoEZbYN3POZANmJs2FeZ7SFBQ3Y4miXP1E9pTSxhoqV7kNnr3lODC339oQHtpD8P6lOv2a1VchAy6xrjRBcpfsQ62VZVk3x3Krv+m0UbVzfPWkB5rrd39lAkk0aUZlAa4kJxbibQN6JjmNgqFFABwzk1aAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 14:35:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 14:35:23 +0000
Date:   Thu, 23 Mar 2023 11:35:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 00/17] Add iommufd physical device operations for
 replace and alloc hwpt
Message-ID: <ZBxjpzk9PmRjKRm4@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276539F11666AC861AC26E98C879@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276539F11666AC861AC26E98C879@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:208:120::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: a15896b4-4e48-4a80-5b61-08db2babd592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4lZ47k7258RdYBHEB8vBNYn0otd9TCL4hObUMZfMNIEWlDiI8MH0vS+qVspa0P7yEZ2naKY6bAbOor0a6cjnkWk8Ga4t3XBbm+GtJkmUYy77nB/Akiah93buOJrrduzS05UNrnGAKYacncz9K8MKs1zWAeRu+4JJIewDTGDuNXJWKuVCkcpfChRCdo7XzQpllSfwQ9INM62QyaatvVO6pNSCAGwnLAiG+IPEz8wuMLS0Gc5k8+YebeWAJ+tZD7X1wFqvQO3kyvliykcTGVkqUCgKkbi56jZwIs7PFVaQTStVkBITL5XDaLNxw+Mh5lGlIZ8rYnLKUXuu7e7e5VGdwq5AmxdkYA/tBF0VjQw66RGKdKFqIan7d4pbJkxCMOskZrfWPrpWo33dlBFHqKr6ETA+wIoCclwuAovdiBmX3i4LlxO60egNqdEaO5S+oW8TUTM56ITjn8eLb5mAsIytCdPX17Em6QTOuTrvcKVSKp4mSxaddWcxF+vzQu4m0WvZ64EWPaDIz1xl4d0bMjCN6LTOMB2NtwGNhlclcRkyWOPD5jQ3Buf0XW6FA9vTQm3UdWfGVYfxopoKoBG9O03Et85gTC1caQg+2EyAwsseFq2jPy2en0Tiw9PPN4icEYyOYBAd06SP3uhBVIvSQgMSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(6916009)(66476007)(4326008)(66946007)(8676002)(66556008)(54906003)(4744005)(5660300002)(41300700001)(8936002)(6512007)(6506007)(26005)(316002)(6666004)(186003)(83380400001)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2jSOkMtrf55/HxfRq1UADVQckDIsRqeva+NcbFfZN7vho2mb0Kq83Cvz3mHx?=
 =?us-ascii?Q?QTIjAkON77eOwHrdWAfmg5OUfyxJ9rSMrB29t5D/9lXpVxqmbgXtiml6ErOI?=
 =?us-ascii?Q?ijOV4DiVP0j0Go672R3hcipVm0DeqMQrXNdK+hzxJpqCaHh9cWMpX/kqQvmB?=
 =?us-ascii?Q?TaL4SyW6/36swZNf7Ht5zt7j8XosJqEqWGLtzA2I85i66JsmCdhUf8wXckVY?=
 =?us-ascii?Q?fgsPE0ukJluLuOVMejd6kq6pXu81XCl8euZCwUZnzrPPN7uUFbtXdabMJOEk?=
 =?us-ascii?Q?t/Sw8Xi9YthbSkQddJUCCcjYaIScb630EpLlPYgiXhAFG0ZjlK7A1IWNTvmc?=
 =?us-ascii?Q?+QmLS0T/c4wrLHGgeRxZ6YwcuKCoR8QtdtXydcjZrTLP7Nh4JjlNdFUJ0BRV?=
 =?us-ascii?Q?iQFlTaxUofTMN2tXyQZc7Mhj4yJ9vXfK6Hu1Pp3w38H5zRI2k+UZaL9UmKGN?=
 =?us-ascii?Q?YTe+zuRh9p+HyMkENUiCgqXMkM4K2uye5hnmmR0U3CGL0DV2A4qtKAs+2Ys0?=
 =?us-ascii?Q?nabtQF3JJKG6BhCp5+W470NakewAhD+h4ifrzDtsfq3CF84qfUIPwxjT9gSL?=
 =?us-ascii?Q?ISHEUXcsEgJ/qUWbHAQ45Wf2W3HYtp5/oJx1Cy9ArHJdeJZSzaPuePWw8au4?=
 =?us-ascii?Q?9ZuJzQpspruStUl4+iMTSbtk9Dvmp1JtrVqh1cNuZLztLydw4I3D24d9YTLm?=
 =?us-ascii?Q?NbX/Cx5zfjkLD7pzk+s6uHoHPt2r2nP3y5qWIn1kNXVr/KQaGDmgv8tiycnJ?=
 =?us-ascii?Q?+vT4tu+ELx5LaKyZ6F53m6dqtoB3h6AhOYSQz4YwYbQFj1W+yw5TV6oWdzP2?=
 =?us-ascii?Q?0JIO2DpKW5DUOk9gBNfVHuypu0IguuZL9T1+kFyyQ9AB9rmEHO3YI5zb4oTw?=
 =?us-ascii?Q?yP60JYNzfIaTLjbG0wZ3rnFNfsZfIq1PkDMQOdAc6mtVXBerobPdH3cKyf7Y?=
 =?us-ascii?Q?PfViHHQMeEHK9XqnlSu3+i4ZGvnluZBY+vGT32unNDQMwTrgCeqJ6843oNPE?=
 =?us-ascii?Q?lNpX0osxK2Nyy/zJDP8ccYCf398EFyLb0+mxvxnlJoVeCP78NzfzX9CowhT7?=
 =?us-ascii?Q?0HecS92JcDcK7nkrMGh8aioyrGjHLIPwTQc/OHG2zZbN1Na+ft1QZNjPnt5z?=
 =?us-ascii?Q?jEZhOYScrA+7ooSlrZe8QyPWFpKJgFOMU0pLyxX3MttMX6VkvlzX1Vuwfe2K?=
 =?us-ascii?Q?HSUBxDrUO8z/6CbgnTTLGXAeGDOPu0c7548MT8g524Z46Meb0ulnhEoK9g0r?=
 =?us-ascii?Q?T961wNgHWqEzJlVgXk592myNb96gwIA5bzQNc17IN41n3Xwzor8t8cCf+tNB?=
 =?us-ascii?Q?VtLKEtydzpNtFnaNINr1dTbyX9gcf06c8ZuTh8e3lablC+lfK6lj+88kM6/Q?=
 =?us-ascii?Q?MBh2Do8Q54AItfaa9HAoHind7aVCnv5WH+AeIXQLyADFRxnG5Tr16toG3BWd?=
 =?us-ascii?Q?geU3/C1uNA5HxCWsVF8tdkLv8VAMOf4CDZ0rlNeyN80qv2A41hcBzGoYQSbq?=
 =?us-ascii?Q?UROlxRBExDBdQTSnJRLFI4C2MjbWsSobvPITWnVSyklPspVjFkE8Ux/oaeQ8?=
 =?us-ascii?Q?F2aqzlryVRMeVQiYEfVJE+byjj66i0D9CEFgoyCW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15896b4-4e48-4a80-5b61-08db2babd592
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 14:35:23.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikufrAzBIo02TpFNEIOia5g8RurCmz5bHpZVMqPav9lRDQWH8PCHFBnWuJQqkXNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 08:04:24AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 22, 2023 3:15 AM
> > 
> > The implementation is complicated because we have to introduce some
> > per-iommu_group memory in iommufd and redo how we think about multi-
> > device
> > groups to be more explicit. This solves all the locking problems in the
> > prior attempts.
> 
> By tracking groups explicitly should we also move DMA ownership claim
> to be per group?

That looks like it would make things more complicated as we'd have to
be alot more careful with the group refcount to avoid bugs.

Jason
