Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC2691249
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 21:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBIU4e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 15:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIU4d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 15:56:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64356A735;
        Thu,  9 Feb 2023 12:56:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBrMdhNMmr7cCMBVjB1rUS7h6Z0CBFdFGA7rkLaU2IghZ3BC3BpoVomqw1Z8/0sr0/318gKlQjXHYpxUpkKJG35soTGG5FdrdSnSCqS9SVYIU2Nk6AGRP2E8IPYl6NsrN2g91mtyHYs+cpcHQ9gW+w6OZd7I4eR+hvXgM3e88EdMut5IQkTQIFOGjixDp6PsvlPZ7XeNRXbzsYnYhU1pMe7D1LpxuwYKOrCOX56zqkyTByGy1nB8ydY5c3By6w/MtNcTIoYU95I/qSVl1qB8Zg4BBVBGzqDNLCIaxBA9neaNaEkFeMvcEmddQ2P3eNpHuClWu5mh1sYT6IV6WrvqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kmfm3qdtikR/M4sjMbfHtsB+tEHSS8b2Po0/htxFjUo=;
 b=g4Q3hrHU5+tc2Y/miu23HMgO1EDN1UadAogtGspzPlu7uInaZIKIWu19wo3sZW6CCPBSZrgPNSxjzNPlahkfocZg1iG+YlZJZ2NDqOvGIw7Ku/gq+oVigIWElKKnPhKcbyKdVUcL27P8OImqw7AilLvS6xVAoPiIWKd9SUkF2dxiBrWRhRloj9zjNkKS2ajwdiceXy7KLe7obZRY5KAtBBZQcES2GXTIEIdTbKnYv2wsrpIsv1Tk5jhhNlw7FrxRKPr0lG8m0fqvPPCdRUy/7nw8QUvBvT6qdcwGV5vhEVjE0VVoGBtaN3FVIQgTVxNmXfJ/119xA2pDnZtHW/CVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kmfm3qdtikR/M4sjMbfHtsB+tEHSS8b2Po0/htxFjUo=;
 b=p68+Nosp/MRvjFjJQfVnYS1QAtXeLYuHk7B96nl60+diYWA7fFXH/wvuZy1TYwvK312Ac+wzU0cnT+SI5Jrfszig4/MR68JMUHpzrL5ArFq4ZGttGbjon4mfL0y5pS0pDPZgNyHdW5j6WDdCn3M6EMYuJY5A/7Sc2WZXQ/lYCsxG8hJOlj+j+MK35nfXLh8pj4bl2CeL9eUN9GZhjo0jy4phg1v/Cq6G8nZKg4hNR9bH9WLPiwtR4HO/tdKJPFmdRBXOmIZhG9c+oVk52mP/qA9hAvrQYQaTqRmkBp+4dd9FndSjx30jvBlvB4eRXtiNf/4Ye3oKAdBq39OYYg7Dgw==
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Thu, 9 Feb 2023 20:56:21 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::92) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 20:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 20:56:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 12:56:15 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 12:56:15 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 12:56:14 -0800
Date:   Thu, 9 Feb 2023 12:56:13 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+Vd7RdM5FOUHcu4@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <DS0PR11MB7529AFED1A0F681F8C5A52B9C3D89@DS0PR11MB7529.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529AFED1A0F681F8C5A52B9C3D89@DS0PR11MB7529.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3120b3-13bb-426e-fc36-08db0ae01963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BonD0EZuMoBHjdfLu3h5cDDqOjK1pJXi2K+4OmR4MDQmNjxi6QA21BDSU9mrhhqzquQ9j40IgILi8xJGtPB39uy0xQwiTZOZy2U8wHphn3jvJs67CTedo6eyD3xwlQ4w4uUegC4zAhErumz4WvzPNmV12/aIqSo5FNqyjXThspWDaQLtaDC+fHIp/z8z32La0ggvBFTQUBmfbm7LZa3bT9SY9UkgMcPjqUiHle1qCCrQ9RYnhLNCLmjeudxMykyms1I1iHyqhw6lumh8M495KopcfpJjqcSX5uQfjXm1gZEWVapNUaFTeZfrpO2DOvIcS0TfQODxpHNIv7ggwRx1Lq2W71ls9Blvxd2Jji84/6BaXFb/05VSXRPg1FFih08Exm6qb7KDjs/7TfJutmde0a9RkeHmJ7aXp0a22mGP/sbfScjVF3o7uVXsB8QRtgLQDnKU7aG9jlt69f82INdjfYciXqRsIzcU6frBw6ZmSl+5J0ORTThYbBkRVLDqGulJ3ii3XpAdxxlXY6ZwXACaEjcgp5nmSnN9c0CY+dCqSCiqCZqFSBKfjWz3X/DYcA4NHGyRfsMruJn+OkZVQWtVlmKlRKjSQpr5NtBMv7GHixQ2rEYYb3dQbF7UdtnPv/0rrsoAmFDSmRquy5HY7azBWIRnVK07iIi4l4KcGqQkeYwSV6fGdepgI3o4Xz9nznv5L6SIkijxL1dFXvGjK9ddvYBor6Cm5P0GQL9YDDxRy8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(46966006)(36840700001)(40470700004)(426003)(9686003)(26005)(86362001)(186003)(336012)(47076005)(70206006)(54906003)(316002)(70586007)(8676002)(6916009)(82310400005)(55016003)(41300700001)(40480700001)(8936002)(4326008)(36860700001)(7416002)(4744005)(2906002)(40460700003)(356005)(5660300002)(33716001)(82740400003)(478600001)(7636003)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 20:56:21.6429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3120b3-13bb-426e-fc36-08db0ae01963
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 08, 2023 at 08:12:55AM +0000, Liu, Yi L wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 8, 2023 5:18 AM
> >
> > +/**
> > + * __iommmufd_device_detach - Detach a device from idev->hwpt to
> 
> Nit: s/_iommmufd/__iommufd

Will fix it. Thanks!
