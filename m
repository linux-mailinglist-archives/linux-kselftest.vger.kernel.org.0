Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED82968E2C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBGVUh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjBGVUf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899E17175;
        Tue,  7 Feb 2023 13:20:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJMQ6wNj99Iibib+ccF2aih85AYTpFLQpiXw0wO/NBmp3mUEDdDtU2Od1ZNaSa4gPgEyMw4K7pTraHPOPhdWjW2+Bz9C5iTkXmME5CMt89ehGLm+9vy3XgNbGYb1fbx0IBrRD+Fc9dIY3o2rXZr/f9QhzL6UW+GyftBFKJH4tC1BmAnQTl1LV+4ljJnTL7ZbNViCsYrOFx08SP7xPT8LPJGzQSZ+/jvMqXn0PxIyxEyODAn2LwXi1plJx2q2+iDLamjfm0RAwUYkGLDcwHp9iRgZAuW5Kn5L1VikCEcPc7NNMNAYKgavi0ILErdc03GDWV82ZRC+W4R4/i6g/NZpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CchXSipivY6C4ClxK2M4HMsithW+voFC2DJMuKLzWLM=;
 b=YR1r77vG8I/vnnDj3YY7vz3MvGJrR1v5pcU7rgAZ38mIdMu4X/E9IYCjDFc/ahOROKAh4aUrMS5cjy/IVwmiU3aAUrwvR6CYTgAZdbMpgt8AZEeVnlZPXcJ7p0JY7lTXMPs3nwNBBFZ4I1YA8C+APXdWOegLbemzfiwEnmcgmfhUMxyGWM6reAAdB04A8fHzOda8cNm008ME0tKusho4wmllhxOvW2Ge6ndwD9V+YUTKWF+8owySQkdKqdfNVTRhfsG49drssydUzlTTXB2f4VjcTssOQ1Gyl+CPlTYkGMgkfnh6rkPMLbg7kqNdozTYQWv8AXl6AT0hKmyDO8zZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CchXSipivY6C4ClxK2M4HMsithW+voFC2DJMuKLzWLM=;
 b=Mb2itRJmTFgTE29a6sVsb+wTR3hSqTXKRANpwvw2J32qqteLNVltH6JUJdv3QchJq3hseV/pPZ+yd826L/21sMr5AqTbsdeos5GdUTGo/TAeG5JvMIO6gk3TDe4HfKPNZEfm9rvaQbS/xfTisOmXjWrO9soATtRRj0Jcsyzvdz+BNsxJzxxrd2ycJWwNlZxjXHmoy+1z9n7Ana6SZv8me/qDzh1IguGvfheI+05o6/dRg8UG+mb1NjkRRwlyc8pJ7KWRsUXzIzic+1s3TObZ95jAFGCTpUbOCBrixtElplYZdd8BRWxhkan/Dn9JM9CxhAdDlkldca0nw5ePjShRow==
Received: from DM6PR04CA0012.namprd04.prod.outlook.com (2603:10b6:5:334::17)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 21:20:31 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::55) by DM6PR04CA0012.outlook.office365.com
 (2603:10b6:5:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Tue, 7 Feb 2023 21:20:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:23 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:23 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 05/10] iommufd: Add replace support in iommufd_access_set_ioas()
Date:   Tue, 7 Feb 2023 13:17:57 -0800
Message-ID: <931be169ff4a1f4d4f1ed060d722c2dc17ce6667.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e8e6cd-b6b5-4d42-936e-08db095124d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UJeeMPnx5TxwY1ay0vWeXAU9tioWpZdcRwzFg+t7xdmfA4B8TjWTOkYyO0AURa/lCokMRjpih/TLww0ugYsPk6xMpsGs8mQiPh7J9kfV5dlNV2RKlkeml1nTg8zQyO8ADzwbxwOBtKuiFxDOvxGG7dQjLwSqUYzlYuNGlCSDnvMjH7lZETkOysZGcyKHuFLORCzZWhxFZURTIIQ8jXRPJVjT3jGekgmY/+jGI2uCySlYOwxiQnH1lyvODxyOcxnU6uYKWUz642+rsbyASF8HA3tSFFpQTes/RTBxE5lolSuVS0bgKuwdm4B0KIJSAr/HY52DD88V+pA93o2E+vm+jM56brZwc6Ah68ZwUSBbJyoVEMGiYiizj5TsKSP1Nys/nSKGiKqhZi11+jlGvpAbe3tes1bI5w9LnRy1sG7AUu3IgWIPpMjg0UYyZ3C8OQEGSb/ciUbfH98Oq8YhHgNKE2RFqvYI/Bo2slU43fW8pIre1othkNE97m5O1kOe0esIs/EVet4cmm8vah2s8aQ9//vAocSIplFFM3mP57chNlZzUGwOC7TyY4GmRR1K3fF+xj6ucINUWHCTSPsxeYou9aEfTs2tNZwL4Rpm+QvC3o1VL2QXouS6eN+Ds8u+Iy2GbAONgzWIVp3D7aQEJufCBWOrZ14OjdoL6YWru4ZuCR4rf9KLPnSCDzz6yjDWjjP9MvhBYPyNUVIa4SOvwvG8A==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(82740400003)(7636003)(316002)(356005)(8676002)(8936002)(7416002)(4326008)(41300700001)(70586007)(2906002)(5660300002)(36860700001)(6666004)(2616005)(26005)(70206006)(186003)(478600001)(110136005)(82310400005)(54906003)(86362001)(83380400001)(336012)(426003)(47076005)(40480700001)(36756003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:31.6497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e8e6cd-b6b5-4d42-936e-08db095124d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support an access->ioas replacement in iommufd_access_set_ioas(), which
sets the access->ioas to NULL provisionally so that any further incoming
iommufd_access_pin_pages() callback can be blocked.

Then, call access->ops->unmap() to clean up the entire iopt. To allow an
iommufd_access_unpin_pages() callback to happen via this unmap() call,
add an ioas_unpin pointer so the unpin routine won't be affected by the
"access->ioas = NULL" trick above.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 16 ++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index f4bd6f532a90..10ce47484ffa 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -509,11 +509,23 @@ int iommufd_access_set_ioas(struct iommufd_access *access, u32 ioas_id)
 		iommufd_ref_to_users(obj);
 	}
 
+	/*
+	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
+	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
+	 */
+	access->ioas = NULL;
+
 	if (cur_ioas) {
+		if (new_ioas) {
+			mutex_unlock(&access->ioas_lock);
+			access->ops->unmap(access->data, 0, ULONG_MAX);
+			mutex_lock(&access->ioas_lock);
+		}
 		iopt_remove_access(&cur_ioas->iopt, access);
 		refcount_dec(&cur_ioas->obj.users);
 	}
 
+	access->ioas_unpin = new_ioas;
 	access->ioas = new_ioas;
 	mutex_unlock(&access->ioas_lock);
 
@@ -587,11 +599,11 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 		return;
 
 	mutex_lock(&access->ioas_lock);
-	if (!access->ioas) {
+	if (!access->ioas_unpin) {
 		mutex_unlock(&access->ioas_lock);
 		return;
 	}
-	iopt = &access->ioas->iopt;
+	iopt = &access->ioas_unpin->iopt;
 
 	down_read(&iopt->iova_rwsem);
 	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2f4bb106bac6..593138bb37b8 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -261,6 +261,7 @@ struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_ioas *ioas;
+	struct iommufd_ioas *ioas_unpin;
 	struct mutex ioas_lock;
 	const struct iommufd_access_ops *ops;
 	void *data;
-- 
2.39.1

