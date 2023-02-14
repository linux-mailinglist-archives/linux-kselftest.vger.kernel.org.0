Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4200F696D46
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 19:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjBNSs1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 13:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjBNSs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 13:48:26 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3780A2FCDE;
        Tue, 14 Feb 2023 10:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5FOd1BOfUv15AQyvz6ECE5c4FMci9D18EmN0jA5hMvGAueg71A9n26MR4ofg5SYj6UOt3k+Z5dXQdSDuSXV5qTF6aXrJFuO8Xz941q94/MCnDv5b7mihTALqMtOmO5LjMKuX4eJKluJwW0PVnmndGiiY9rRND/A2LTu7kkMqf8gEv3aCvreTV66rL6HekLrKrf1io+DZYCfdY5sZHvEOUa+ZIWecHdBbjqTYrzrCdd85MRqjHDec8OcfnQIO0GmZD8CtOzHitpw7UyOcTPmzkLrNdEPrV6RN29eKvqS3NDKpwFJ0SfyP/tJBecyuSKZR9sR3H45fP24s/5AF6RfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZyrWR7ypFyt0tMcoQYU76mj6jOQMdtNlPmWJsNhxhc=;
 b=OLyQLZsS8QoENve18kDITO12hXHDanTddbrjBdSVHRvZ7G2jffsd0qlBzoI8oGwgrpFJnGXxzjWBcB0gIq7MgyE0X0+4bQGpg1cWFtHpbk4HmXLvJ1f+WPE7rs5XvDWhjgH+rbkbq8GZGSLx71ufimTBXU2Q3H8RCKloK7N5E9OfuRwmt2o5jFEUG7m0emP8ircb4ycxPqU7WIrkj/2pcyLQY7xPvt8hbB+4ZUzwZ61TElfdMIJMhXH+CYr7L3vXh4XeIkG8sJAuYrJthWEDdwr1oWZds5MfBHDD3ETPzF/d1nI38i98EnxnMbvKBtlSwXJBBhYwA+Oq62PB2qQMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZyrWR7ypFyt0tMcoQYU76mj6jOQMdtNlPmWJsNhxhc=;
 b=R4j1zzn0owR+iePDWIRJXpkZv90YDaVpt3yykR+SmdO+ICjGWLBcbTMISdVP1EtrzjqM8CITXmFRflS+OzP3dOf0RpzZiy9gKwoCFcUp6fJsG5hl+m2neZvsKMsdBtFDNm8CZ/aBzHuDWqHnz9Nji83cZ6zpsKP8MftIjDkJjLhxnT821c03XwjBP/tlYGM7lrIxrN+1AbGdcDdOEkRRE+SKiVK/7KvRf6zCVMG9hq6chOSoGC54EVyW5moElf7skpdfqakSkH6zAwAFwV8/BdOZLtTaaj3PCbEvlEefbARBNo01Z5xyfWcfyNdf54sK78ZBrgxR2UV/NgBC0DHtlA==
Received: from DM6PR07CA0110.namprd07.prod.outlook.com (2603:10b6:5:330::26)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 18:47:39 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::74) by DM6PR07CA0110.outlook.office365.com
 (2603:10b6:5:330::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 18:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10 via Frontend Transport; Tue, 14 Feb 2023 18:47:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 10:47:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 10:47:29 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 10:47:29 -0800
Date:   Tue, 14 Feb 2023 10:47:27 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 02/17] iommu: Add nested domain support
Message-ID: <Y+vXP3OJ4hqNvA+S@Asurada-Nvidia>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-3-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230209043153.14964-3-yi.l.liu@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb77bd7-681d-4c22-2a07-08db0ebbf120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0h/Lo4AF5cImwu2M+9srsPOWixg4Ge5X0Qk1omksK8bLPQ3zcvefDDyNovsHPTR8egtVulQUfMDPKCu+TvpTYcpTsqcdlF+PUJlRyrglIa5Bsn1JKG0BEhqus1Qqi18b92GlNHy5drNpvr4tjgicrG3K379F0pY28SUTf/24qSvMh70PmyjdaxBRwNvLcUEpF5SmDC5gI1RcPkYfur2G+sk//tS2vFMoFNcr1Q1/SBZpgzCireL9XKS34vKGQmGlo5G3Fdq597oDvewev+fZUPYzPG/CrmDhesgBWOgdENmLKw9w1BYQRqIcw5DotW0e4U9L1mIQGnV8/rOnTi3U3VH5/U9Lpxy4jIvGr0lE3B7A//ICBtozASoo1R7uchF0OjOUbNUDb4nfwHpViJAcAEioBnBal8kwsHrSdeQ/TWe1hDkP0rELgjnfGnmVk5H/B3L63M2JbUbFHD/WdHE2mM5w3YiczibpsUBI5luG2nQ5MsKl6puwzB2MSBGQiyQ4gsRBbl/mbYlyOLj417fW0Kr2F1AOLtXGxMIyZaMJ26A5azQtsIIyI8Ng99TsQnX79GERMQlxlu3FM9FfO4r+qFPo9Vfsaovx2e/EpvDodsIxf2Cqs2tceljWulglFsAmzrtM8HE9lamdnlaf2EJ9a5eIK8VDa0CNwIDog0AjKmdp31+Gho9hiSsbx6pskyu1bcTyp3TDzbFSYbVVjk26Q==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(478600001)(40460700003)(86362001)(47076005)(4326008)(83380400001)(426003)(55016003)(356005)(40480700001)(2906002)(36860700001)(41300700001)(8936002)(8676002)(6916009)(70586007)(54906003)(5660300002)(70206006)(26005)(186003)(9686003)(7636003)(82740400003)(33716001)(336012)(7416002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:47:36.8740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb77bd7-681d-4c22-2a07-08db0ebbf120
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 08, 2023 at 08:31:38PM -0800, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Introduce a new domain type for a user space I/O address, which is nested
> on top of another user space address represented by a UNMANAGED domain. The
> mappings of a nested domain are managed by user space software, therefore
> it's unnecessary to have map/unmap callbacks. But the updates of the PTEs
> in the nested domain page table must be propagated to the caches on both
> IOMMU (IOTLB) and devices (DevTLB).
> 
> The nested domain is allocated by the domain_alloc_user op, and attached
> to the device through the existing iommu_attach_device/group() interfaces.
> 
> An new domain op, named iotlb_sync_user is added for the userspace to flush
> the hardware caches for a nested domain through iommufd. No wrapper for it
> as it's only supposed to be used by iommufd.

Following the remarks from Jason and Robin in their first looks
at the nested SMMU changes, perhaps we should rename this op
"iotlb_sync_user" back to "cache_invalidate_user" or so, since
the type for the caches on VT-d isn't confined to IOTLB either.

Thanks
Nic
