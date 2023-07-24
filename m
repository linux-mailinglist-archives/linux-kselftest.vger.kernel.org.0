Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4677E75FFFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 21:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGXTrn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGXTrm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 15:47:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5084E1729;
        Mon, 24 Jul 2023 12:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbhKd9UmruTDXkqK6NEBVgIN2mWlTUYefFu4gzk+a0ztviD4ZCAVPstqGenq84zTiHk9a5Q50eRBIRL0z3VCZkLNPKh9kvSdHCQPF935+P7fl7KDw1JitHADu7HBR0WfG7Ciev2nGSvKYLzGVUkOKtQBSGqqmuxhWkV17f3jNc8Pgd8PqWEqMo1CIeXQJClhLpKCYQ1EymoZHRjDhrRQkEtHcPmqgYON5a1Z+GMMgtsfHnP4SKZthgLFmfYMu58Hmap/I+HH4tV9jWAqzavABZE5ubmXHGd+DPqVSMJWrpSjcToGWxo8tl6wFQ0CtD9OpwRl4bOfDFud/SaL7z1MhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDGlmKoEFytc6HdNUFgcPjErrWTIlcH+ptTAeDSJ/wM=;
 b=mbAr18vqi2+IYIdOuUQgdYiEHmF9ALK1dgrAJVwtKlZvgJLw0W3ejwdjG5LLfQm+nuwkdswwJ3B2FYXLBnhkbGunYBh0fGX9cKhnozwR8mrWzWf4G4xYnB7ywYyidB6oGoMLhz3JEUUB09nY5GydVD1WB+Q+Z0zm+hG/Ob6jvQgnvqbxgo4RcvF0ySb3+N0Of0oUEEEMsgLtbgtJsD96agHf1ZSrYuU12+Fi4pcnVDO/290uE22wI6mzJ23Je/138KqYoZuUeGIvy1gVRf8nwK4/R1hB1itBPicAoLa2S/uXk+zldxwMoa267yKLaoSIP2bQKU1qYW5nGT0qvc/1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDGlmKoEFytc6HdNUFgcPjErrWTIlcH+ptTAeDSJ/wM=;
 b=Qx3OQIjyW6Z0HbyVazvCm8ffM1GZPggyj7IzUEEEGP0I18t6qOmgzuTxd2s12cRcjxQvuzsGD5FD0Hf4y9Vkyyfg8qV3DH8lAzJ2j3jnqNKYh0zOIZZx4M59QmaQS8J6kjtxYUb2xlOrO+JLkEzwTYlcvCJT/mjgldFm/DINFQuE/CmOW6c3hAjxRikF1slNeizFHILCMtTl+mdnWzI1s46NMXzGGWsBnH1lueDco6xtsVu8wGdnhQlgfbCt/rDa2xbU2vRQktKV9TLfKjm4QQ6i9x7W3GAczlhERtFzK3nW+zOld6r8TJA5jMKV8EXHrq823tJ8kLoqwzY1ExiS0w==
Received: from DS7PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:3b7::7) by
 PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 19:47:29 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::8) by DS7PR03CA0092.outlook.office365.com
 (2603:10b6:5:3b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 19:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:47:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Jul 2023
 12:47:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 24 Jul 2023 12:47:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Jul 2023 12:47:15 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: [PATCH v8 4/4] vfio: Support IO page table replacement
Date:   Mon, 24 Jul 2023 12:47:07 -0700
Message-ID: <182b79f3838f84f220ede6089a0326b6f3f44acf.1690226015.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690226015.git.nicolinc@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1edcef-f7d8-483b-163d-08db8c7ed0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wy5zMX7JfdUiUmACQomKrUZCU7UHHktjgypg53f2uWK6QnbNlSHKjzUICp3J5TkonW/PZdhZ8JGgxfQjV6FYyfgrxoZc7QGBoqfk4Kbk/Ykx/9NYiP/OsEVLWU0KeUkVgbKc/ghLDNBRV+Kpo9Z05NXBLoL8g+tw09+HpQ1OxxRhKEBkomjq4R0Xxer7/JMI9X5L4rgk7pgDcqCRa3hZFVNGehIyFPy2sNKj4qimzDfUX9LGojqKVQca0Jx4wjAMs7CLGwNRU50kKeuBSM9ES99vdQWAYWbRHMCCZPSdUdyWnKkWxfBODyALjQV/zT/KugCqVLK2JkkkTepZb6Zan25c9CLlVD0aCIysxfJYzAEd+fvt0zLawP0Uqb3o+EHJW+838G4eCe5ZhGtMp8OiPsgsVZpR9sgp884IqovhuNraBRInJWJEzqRw3p+extGLD6m3i8+PZ0nc4AW4J7dSCsdoxMoP1ta6UlJuzjTPeCQaw6WSjdm2y+1v2G1cUdZG7pCnjfKESUohljXfOrC1l2zOrXvhFAoOgs3MPSgPgMHbIawR9BivxKLLCdaWfyw2J/Pk8kIWvCDneekWCIhzzj2xr18gYzxn5digcR0uYbCC+CLyoFiO3sHWvCDzjOuUtyXOwy+atIdUh2tbsncis49f6Gm69ECUaJUnfmFAKRGSqMku30SgJEYgWPgf2p2aNz11S3pMSa3h+j9uHR2hs7OgriyZqDdvGbM2B3d9YWPLU5BWNT9EJurJ0VjUA0FM
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(7696005)(110136005)(54906003)(478600001)(6666004)(83380400001)(47076005)(36860700001)(36756003)(86362001)(40460700003)(426003)(40480700001)(2906002)(336012)(2616005)(186003)(26005)(82740400003)(7636003)(70206006)(4326008)(356005)(41300700001)(8936002)(70586007)(7416002)(316002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:47:29.6357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1edcef-f7d8-483b-163d-08db8c7ed0ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now both the physical path and the emulated path should support an IO page
table replacement. Call iommufd_device_replace/iommufd_access_replace(),
when vdev->iommufd_attached is true.

Also update the VFIO_DEVICE_ATTACH_IOMMUFD_PT kdoc in the uAPI header.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/iommufd.c    | 11 ++++++-----
 include/uapi/linux/vfio.h |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 4d84904fd927..82eba6966fa5 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -146,9 +146,9 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 		return -EINVAL;
 
 	if (vdev->iommufd_attached)
-		return -EBUSY;
-
-	rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
+		rc = iommufd_device_replace(vdev->iommufd_device, pt_id);
+	else
+		rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
 	if (rc)
 		return rc;
 	vdev->iommufd_attached = true;
@@ -223,8 +223,9 @@ int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 	lockdep_assert_held(&vdev->dev_set->lock);
 
 	if (vdev->iommufd_attached)
-		return -EBUSY;
-	rc = iommufd_access_attach(vdev->iommufd_access, *pt_id);
+		rc = iommufd_access_replace(vdev->iommufd_access, *pt_id);
+	else
+		rc = iommufd_access_attach(vdev->iommufd_access, *pt_id);
 	if (rc)
 		return rc;
 	vdev->iommufd_attached = true;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index fa06e3eb4955..537157ff8670 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -939,6 +939,12 @@ struct vfio_device_bind_iommufd {
  * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.  This is only
  * allowed on cdev fds.
  *
+ * If a vfio device is currently attached to a valid hw_pagetable, without doing
+ * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl
+ * passing in another hw_pagetable (hwpt) id is allowed. This action, also known
+ * as a hw_pagetable replacement, will replace the device's currently attached
+ * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
+ *
  * Return: 0 on success, -errno on failure.
  */
 struct vfio_device_attach_iommufd_pt {
-- 
2.41.0

