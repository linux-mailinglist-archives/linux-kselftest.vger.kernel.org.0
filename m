Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9768E2DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBGVVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBGVUx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:53 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BEA3CE04;
        Tue,  7 Feb 2023 13:20:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOXYcT0aB1YxEj6xTIFmCLTrpmOm8KGwN+yZ5BScUopMsv5YtljW/YvVzpQ9kJQ4BS8PHlOkJpg67afmL37OVEcj97oITt7MJKE0SIzhea3KAF2C/wYTQsY0ASgg4kDe6aH8Siug8eklPGagWq2DaTZcGnMV35RbYxK0S0EZsE78kdHAWGbh29sNuOlbguD0hekBCE6erhX2K3MCdnNSUQ6lzquX8cgbj8k4llB/At4bX3jGB2kRlGeyuK/vXyOU9i0uhr19qdGOVoV9/OP5vFjt/zl+oevhmWyA+ksqK/h5Wb1fjvBpkKPj38mT598G0Qc0ojEd0LR61iJ0TyYNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKLLUvac1wogY7bKkDex3cX9BMQuTYh0UnjpN1D9esI=;
 b=mjIDCSW6/9V85IlqGokC3IMpW1Q9jpUOJN2S7sa5PzVjxoMXOMHnIYeT9kwUrg52r3WgRivIDY3TwGrlAxtg7YLXLcmOf+2lZi944dKFp0kxcw5gVpkVkJE0hE0J+2yb9JZbzeWnGUI/h83UwyEQZzW8eLuhtryQ/IHo7z/y7hpI5XyX8/DNrJUHxHIgPolRmgrvcQzfp29fKieWbpuiDL0hzbHWjqHFW4DT9gT4p2ipgHVMpP0AP8eXixInWy+q7YwRlijNebZeV6QmeXIG1uRCdwcKmfSwRmtYH0lh1ZX0dOG1SQFNDt8/XX5jJiesQoRnvXaF5oNL+xEs2/9qLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKLLUvac1wogY7bKkDex3cX9BMQuTYh0UnjpN1D9esI=;
 b=WWetSkabSKKFpC8UTkA/15E2oAZJo2XVDePLjd42KNUfqAo5zwKlEegOKs8BAAyxiJ2465rsR4+4E8pt4VqFsDo/48aw2HgIHdbtjavwLiBGiVGVwyKvzdnlJQpoQV43JXuoTTQL0oB5xr1Xm8u865ObmsOkEnz2BbWmDsfjRQieOSPqunLfQ0kZtlMBJH0co9WYhnne32ylSvOvUSqxI8V3cAOiWk2bbymgUVLToOixa6MhRJkJ+kykLSHmMTeyFgAjM9+fFEyjaEeKW8OCEU/TafCiQKo6kjH3j7m5QLi0ZqBUHErvIvhw/G7NnYyBAL4v/bGPYMzhEMmIUyw+Pg==
Received: from DM6PR04CA0002.namprd04.prod.outlook.com (2603:10b6:5:334::7) by
 PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Tue, 7 Feb
 2023 21:20:37 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::f4) by DM6PR04CA0002.outlook.office365.com
 (2603:10b6:5:334::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Tue, 7 Feb 2023 21:20:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:28 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:28 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:27 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 10/10] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Tue, 7 Feb 2023 13:18:02 -0800
Message-ID: <59e5eeac675172ab1cb07236a3eb3e166553fe71.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2a19e0-8634-4b56-15d6-08db0951280a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgMiTUwFRgZN2uBepAr7zjelh2zIj6nLLyoTs4N2XGWaCNv9yHNriRiPGDveIsPZ+ntACaNqAGVwPrDnKjXrdX85uYumr+LclCAabhvEvZ7qTq9tTpGJIVnHCZyN+WGgzJr0hoBh+qpZQlCbYjLUuiC5A3909rUWHrOTreTEUKy3GNkeYckH0bop+tUGIAZbWvE5FQHMM6Z+trOdv0mkt/3bZV8vwPwXAUI5LN7PTKSUvU8PUkzKfKX/70OIOUgZsweboCfIjdu7MOeUiyLRrrWqFvn65GusaHdAhqVYUAFSDulp7LZyn/MZTTuMBD02ehhK1JDr8dhSBIsu6nPwjXGxsnIFytRf5oRq63brMyEtvEHh8ZqmK1p+t34acso6LhxJzogVZ7kVf4DvFlJDPi4e03X51a1SZe8IHrVTbKKw87uJXqumWHbM5hckGFrKnCLcxPBo6fKxrcfjhNU+GAa8hiAqcE9z+ubnc18EC6vPeuKj5POjSH/O22oPCY8kiErkvPfPdk6XHD6hbJo6Itjr0+2OCt+eJfWBt5/UewFgZ78KCYmOC9crRCgSWpyDGY49dhOwkWNcSUVBKKtEpJ7jwm9fBq/txYHzWD4ffkUS/VNWVv1uDOnqWBs5/PFDQgL4WCF8tC+sylRroxRR69UukgClw586avo5r1ChUNazLkJY4bk4U4oAH5Yt5N4RMle7vs8dFcSoC5/8Nz8ZQg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(40460700003)(40480700001)(70586007)(316002)(8676002)(478600001)(6666004)(110136005)(7416002)(5660300002)(4326008)(2906002)(54906003)(8936002)(70206006)(82740400003)(26005)(36860700001)(7696005)(186003)(7636003)(356005)(86362001)(41300700001)(2616005)(426003)(336012)(47076005)(82310400005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:37.0401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2a19e0-8634-4b56-15d6-08db0951280a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A driver that doesn't implement ops->dma_unmap shouldn't be allowed to do
vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 8559c3dfb335..c7f3251ad6e5 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1543,6 +1543,8 @@ int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
 
 		if (iova > ULONG_MAX)
 			return -EINVAL;
+		if (!device->ops->dma_unmap)
+			return -EINVAL;
 		/*
 		 * VFIO ignores the sub page offset, npages is from the start of
 		 * a PAGE_SIZE chunk of IOVA. The caller is expected to recover
@@ -1580,6 +1582,8 @@ void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova, int npage)
 	if (device->iommufd_access) {
 		if (WARN_ON(iova > ULONG_MAX))
 			return;
+		if (!device->ops->dma_unmap)
+			return;
 		iommufd_access_unpin_pages(device->iommufd_access,
 					   ALIGN_DOWN(iova, PAGE_SIZE),
 					   npage * PAGE_SIZE);
-- 
2.39.1

