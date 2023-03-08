Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B976B0B03
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 15:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCHO0h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 09:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjCHO0g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 09:26:36 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A37C5604;
        Wed,  8 Mar 2023 06:26:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfiPXlNWio6I1JkEO95ungASUprhjhfNCD1YMMCEfvYA8zi5gMIfj3XC/4Z4uFf5bPAqTZX+6PUUQyRcOzBkqgfyyKjatS7aNEjneYusoQmFs9/aKh4FurVBAinQG5/Ssw+mHwBgWu2M2/QsudGYubqfPSVi3QFR0TQbMM/fVUuJAVDvuWSXDDxk0yekNIyzuZ3+ic6vHbA69e9APNarzmz+I0SbmqyWjMU3qykZzSggNLwWJ5Js854vj/8h45GQSQJ2zI8wcG2mp0BbwAKdtcYqBXyoDQYaDkgkys2xWl8W2E1fHmxv9oRALgRtc4F6QVuVHJ5og7VwnrbcVuKJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASDw3GKkMVKHR5vFMjUe7HP5KDKS5oD9aQGH4N66VTc=;
 b=hIUxEqmDaya+OM5DSJAY9uCgJfRv7APmeQlemVFx8gW61xfq6EaorH6zGanqVnDoKIYxPHf3EGju/DMEoy/2Jb8oBuLZErBwn/tbXewE7DW2YiHxRriZUbGYvimEhdiaxlkZlakBfym2ld5D1OIDkhCKwcUgSogCkaoUhJueEJXFRxiSLCQHZerML2bo2bkR1I8fka/JWczWfyFbRSzvxft7dapshrSr2yAqG90uSSuj/cZMSzHn0QM5pBwMTIKz93t3mRJQpAIND4/VkhK8KcFYW84ExgOX6cd/wECl1UMtJbokl+LQyRzg5SA3gGBxQzGIrhcxCshOfRMy62YWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASDw3GKkMVKHR5vFMjUe7HP5KDKS5oD9aQGH4N66VTc=;
 b=r3AFjY2o5adBLD5mpOZ7WPJ/Xw2SWYffwYAzKmtc409DVsnZPBokBYfexUFKCT9Kh7QudgTNot9DkDeguabGZjyxQwwDpf7ODXuWJRong2jufj5aWUI9rHs7PHaq7lqOOeO7QHXwoCuE1+wmLMiO17ubgUllraLt5PhvlNWbuw6H0xSjf/ima4wT2uxWY7CX+vMNHqGdrR1V6qL1bvC0DPZZ2hbRDxMGhPeiGEySvu7o6u7bdNtugJpBnXczmvwhJTdOp5yMa9v3l1FO6OPcytY/kMMtO/Bm5fn3PnJGSiJH64fVema1gUKL31vUcADy3ulCKv92DeErT6KFbz4QSQ==
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 14:26:31 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::14) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Wed, 8 Mar 2023 14:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17 via Frontend Transport; Wed, 8 Mar 2023 14:26:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 8 Mar 2023
 06:26:22 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 8 Mar 2023 06:26:21 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 8 Mar 2023 06:26:21 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v4 3/5] iommufd: Add replace support in iommufd_access_set_ioas()
Date:   Wed, 8 Mar 2023 06:26:00 -0800
Message-ID: <58b67ca78925186b246ce8ed3639a1c92e56f98a.1678284812.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678284812.git.nicolinc@nvidia.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2b4725-ebe6-415f-0fad-08db1fe11cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpGScsGc0ZD6qJ6b4INqyG7YZs2hUlLVAge0IOVF8WppyM6j0Age0OUTTyFJlEp3EZGIolqK3J3nRiY8Ze/uBQRUraqyTqLNnpuFxPONAAtTHuc3zRqu616sIbbVlZWLG2v5h40mqu8HsfH6EuDwg6UgtWDxYhks0jDB5l4kGdQYkgXPwvgqrWyjaiPrfa8ykdBZZUsBCNmZR5YkB26H/gbj0sVkaZ5BhMOVHAHXU/zeoBApQU4ajSSK0Siq/x5mmdAY873mI3oOm6BTm+GroeP//PnYHzVzx8RDEDR2Nlu7BhtjP1xkVE07F5sFHzF73cGFkL8/A+tAfL1igmBpZfQyt8YLwhE3yeYOP+0apjWEhpTTceiwQ3UPr/F1gzQjtSoy/L9Lbe4QBiwfwpNel8E93U2cTjFelPQUNOgRlcxaY+HN1h+UdFaDEOxrD6e6ZkPSg3jJ+oQKYJ42N0kq7AceNWGPih7pIwSNpNydsUVdRKutdROvcL1lz1SOfrXub6M0cNEauqxXSexdP4FxljkRCXPc9mTafp+MtEq/vuOiyHski/xZwgZXEdTw4ixo+BeZzOE+68NjxZANtdu+RobP6e1BPDLwxqPqi7JpXCYVivyO9d/Nz7jhn6cTov4cPCRas8lecafKc+u3N6gJgDzRXi+39wbzjGJ90+HQVFM9QSTWhpNJJ7WHn6JxOrG8qYPD6CL+5pX+dc4ZiqzzQw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(86362001)(41300700001)(6666004)(8676002)(70206006)(70586007)(47076005)(426003)(36756003)(336012)(40480700001)(7696005)(316002)(110136005)(4326008)(40460700003)(54906003)(83380400001)(2906002)(186003)(478600001)(7636003)(82740400003)(26005)(356005)(8936002)(2616005)(36860700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:26:31.1633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2b4725-ebe6-415f-0fad-08db1fe11cc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iommu/iommufd/device.c          | 17 +++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 612a5f424bd7..c10e02f6a0be 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -727,11 +727,24 @@ int iommufd_access_set_ioas(struct iommufd_access *access, u32 ioas_id)
 		iommufd_ref_to_users(obj);
 	}
 
+	/*
+	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
+	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
+	 */
+	access->ioas = NULL;
+
+	if (access->ops->unmap) {
+		mutex_unlock(&access->ioas_lock);
+		access->ops->unmap(access->data, 0, ULONG_MAX);
+		mutex_lock(&access->ioas_lock);
+	}
+
 	if (cur_ioas) {
 		iopt_remove_access(&cur_ioas->iopt, access);
 		refcount_dec(&cur_ioas->obj.users);
 	}
 
+	access->ioas_unpin = new_ioas;
 	access->ioas = new_ioas;
 	mutex_unlock(&access->ioas_lock);
 
@@ -805,11 +818,11 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
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
index db1ead8ff9d0..b18f843ad6a4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -312,6 +312,7 @@ struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_ioas *ioas;
+	struct iommufd_ioas *ioas_unpin;
 	struct mutex ioas_lock;
 	const struct iommufd_access_ops *ops;
 	void *data;
-- 
2.39.2

