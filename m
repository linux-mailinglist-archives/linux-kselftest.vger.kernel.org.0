Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C465968E2D3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBGVUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBGVUk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:40 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A323C297;
        Tue,  7 Feb 2023 13:20:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHzBm6swlHINAV4SrlNBz0t6xtfIsluosCqD8K+bP548OoPe1GKCtCea7z6tO/MVX7baR8RIaku24QnQgCF7DYUn7iIjZPn6w7Ubqt7cbxKk+VFEb4hjEPsyfHnTUX5Ye4I4seKgZJ3yaWEgveu4enKdg5hgooHCaqkc1SHPp9+20DNUpgCpKe1Kto0GQRgv6U30Wdh63+DxwCCY5gpjRdCq8khP+0aG+wuqrW2be8oieBWZR5kj0daLi+ZVDXt1YZDOcW5nEB797E0pYcrHj5BwRxmEsZdBIhZk5D1pcQVLXFV077Mbd1bkdNKK5uHAW6VsZtgRIcks5v2M2avAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxcEFEx7S9T+RbsM7A4XdhsKMDpsan6wzz2z2R39Ax0=;
 b=HyIxfia4A2T628a3Cqy/zsu2g7RTJTW10HZuL92g2i3DWQ5d4Fc6W18vELB+wOREjUAIyHxuMmh6G+dteiMqeJpzld/f7VUF2VT4785zJLc84pOdfgAzrl+C0xhj+4bycKoifGyuCnhZplE3C6zbZl3jq/nxb9tihL99RbH2RUvAMC889ypL/vsLfS5KjjvD+2Xh1r+oWc9V0ENRBRQ0riH7hVj2+PtO6dgjTkKUXlervwWDr7/VhNBmo/qpSwPbTf4MEy+Gv3gsWmnDDTcz+eaYZADwRn0adppSJAUHZgFB/WIIdE4OeZz8Au5zp6dkMa+y1aXtjvEFJ6AXHG7L1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxcEFEx7S9T+RbsM7A4XdhsKMDpsan6wzz2z2R39Ax0=;
 b=dcMXMY3CAQOOWuxVnIuenKjz5WbJi5qY2shnZ9N6AansJ+kUEEpt6a1BzJWi8Z5uhRhlGnwEYQGN3pHfyG4Z0ur8ZRYIWhonDlYoT6THJCtBOZsRbCo7/dlPie/9DlI6MSS7fth/iyw8i+M5AuBS6fPPpcSPgRthJ0Fj8mvIyv2gBjoADTpJJqN+8D20TO8lMSKz/0nQQL9Q3r0wo27clH2rfv9Qu5eAHGV5omwnZSTNKsDHJWrXCrzXl9ISaviGUHp9T0Ze2ec6l570V4XBePSbe1XYZy5qRJI++tNwLZdDiIQ+FlbTxkbGxYC2v8XJphJG+MgYJOprircjAjM7Eg==
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 21:20:36 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::45) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Tue, 7 Feb 2023 21:20:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:27 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:26 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 09/10] vfio: Support IO page table replacement
Date:   Tue, 7 Feb 2023 13:18:01 -0800
Message-ID: <121b90a852cb53f3425ed0660173f12d15ed0137.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f082d3-b12e-4110-bf88-08db09512793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foTuTxoWqdrRdAl9G0R13RP57ju5xv9qMVHD6qxPIQLdtWpOPM2j6uZE4S+xtfQf92YF5XlZttHH4A+8FaRzP59fKDIL4ltEU1DA1cYGML6uKfsdKfcH/QFg+0gn7GSJ82/ZU4y7EmwhRvS8LTMdrFktMhhrzSpRBJuDZl6/3z9WVge4FzPyEB/DhprHIZSe6yo+kuhhKElARBUXYL3hMSPBCnGIKZs+m3pO6TB6+8qg3doOYcOSs+4HFqVRlKbvIgNQXUpirUOYZB6h0WtpvpwrgM3iAzHZFl9Z6x06st9f1GtVOdoTNNeED3XbUM7UsNZ83PnHbwcTbJs/qXH+x53NkEb3XrdhgnnusDuxy/Du/ZDBrUFX8zDszyjJmuqVae5dScJ1CTop/bjr9vmJESss9DeDwve1ROFxnhMQGqgrLqy298QUL1vZ4AnvlQXa4m8W4I5KK4qZEI4F6gf5qcaCVep24LxtfVZcbhp888EBczYeSGe6b79X16usOAk7ggKJRTc2nB1XDmhKHUsu3w1wpGOQct5OC7CfVbHdI47B7OrEUtnHwEg3xHlNlqSnbjBXylwKPUYb5NGoPtOzMKC/KroW1KHQ4DKzhNGdLNRI6HIcHhZjTRdz1OZNyWItD4ftUdPH4G6VbQelypSS3lcJBG+qSbrJxtKfG1m0zk3Wmsw5r42CqUbwG5+wgV/I9351dwI74PSQ8stidbg6RQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(40480700001)(110136005)(54906003)(186003)(86362001)(82310400005)(426003)(7696005)(47076005)(336012)(36756003)(40460700003)(7416002)(2906002)(36860700001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(70586007)(70206006)(478600001)(26005)(2616005)(6666004)(82740400003)(316002)(356005)(83380400001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:36.2489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f082d3-b12e-4110-bf88-08db09512793
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove the vdev->iommufd_attached check, since the kernel can internally
handle a replacement of the IO page table now.

Also update the VFIO_DEVICE_ATTACH_IOMMUFD_PT kdoc in the uAPI header.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/iommufd.c    | 3 ---
 include/uapi/linux/vfio.h | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index dc9feab73db7..8b719d9424b8 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -97,9 +97,6 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 	if (!vdev->iommufd_device)
 		return -EINVAL;
 
-	if (vdev->iommufd_attached)
-		return -EBUSY;
-
 	rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
 	if (rc)
 		return rc;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index c86cfe442884..69f3ceb18d7d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -236,6 +236,12 @@ struct vfio_device_bind_iommufd {
  *
  * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.
  *
+ * If a vfio device is currently attached to a valid hw_pagetable, without doing
+ * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl
+ * passing in another hw_pagetable (hwpt) id is allowed. This action, also known
+ * as a hw_pagetable replacement, will replace the device's currently attached
+ * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
+ *
  * @argsz:	user filled size of this data.
  * @flags:	must be 0.
  * @pt_id:	Input the target id which can represent an ioas or a hwpt
-- 
2.39.1

