Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7926F766432
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjG1Ge1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjG1GeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3C3A8D;
        Thu, 27 Jul 2023 23:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3cAObRWh1RnZXAvC/gm2sAS27K3aBvCJ/x5y+dQRWN76ApAV1c52tmEfHoTEsOlotNjAIKRgFioaKq7kfJO1MAT7yMnKj+SjcP2GL573Zv/QucV4j2O9iA1qGApE2IPOVU5ovmbLHYYXJNUwIQgUUAtuX4qQJyMl8SYGkLKPHLjG9iIYGiCoZcoTTeYEF7Y4JOJtcwtF47c95lB9sda/ZGDhPGfdg6WPAr9Mdj2GdsRuEC8bf8VuaPbKj/1RsB7HOmVhZkWP2kgI5w3M8uP4RGDp7RiLDSALdA2noyZxTWJm5UuXEeNegVD8LnXX8Os8zzJ5+FOyh7wQ+uTqLCP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6aD3dt1PckeOKkxIclyv3iBH0qTiumx46+55bGQRk0=;
 b=CXxC1JRIui7/bG2Ns+Cb6AicbuaTcRsxYWra/FMwM9uOiIZeZJZ+LSVG2Jh35Q5yQ53fiHUJF2SS0vhJYTLAi3KOa4F2Ym7vGhtVz2gFcE18eqqon56hGAT8S6i+Fgm6k/VXK8wJVGyZNdC+MydQjqvMBmltJBuWUN/tynJbuOb3O4a6Tnxn6FtT8jWooIQ37kpD/vgxugtDqXZ8ZFIBHPs9crJHaj9UEFa7OZkpooAR4bhqeUzKzRj5D+csrX35TLSUOAIrW/qO5gcdbU25AKu91Nhr0ZTn7iKA4GA0fDdyf/kSmmE88awCU+nkoWnR6SBhBQR7uWP+7GZ1ByQjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6aD3dt1PckeOKkxIclyv3iBH0qTiumx46+55bGQRk0=;
 b=fScOYJE2FWBrdJsBgHOVVVivhdNtig65ZQocOEw8g8puww771/C3XxvStGdcerGeIcuMwt/TK5bzz8ITafHMv1qyjQgS+FQGu2qbvotw24MtH/7q5l4jRCCEvWyzMHATbL5ZfXdovXZdq3UKsUybONHmwk3+54BhBdSNJKpdZA9zDvx88VDpn5Lxf+FnpDT8AsQYbrq4TmIUbBTJKuzOrmv7x8PsqNb+Q3MNYGlKMscxZ3l0288sID4PEEDKek4bphGlqLaWJjjnOOsS2QlDBzx4loFnGmC3olOPXqTQzGnY70XWRpvrzhO5AEe60P9ujTPCMNYPKXti2YFRnyOzbQ==
Received: from MW4PR04CA0221.namprd04.prod.outlook.com (2603:10b6:303:87::16)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:34:12 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::d3) by MW4PR04CA0221.outlook.office365.com
 (2603:10b6:303:87::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 06:34:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 23:33:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 23:33:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 23:33:58 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v11 7/7] vfio: Support IO page table replacement
Date:   Thu, 27 Jul 2023 23:33:29 -0700
Message-ID: <b5f01956ff161f76aa52c95b0fa1ad6eaca95c4a.1690523699.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690523699.git.nicolinc@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: a6217f11-12c6-4798-db19-08db8f34a7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4BgrT5wr++NsHUh0BHbBzEFOdXqTkHCDUu1x5kd1db7d/jDjwJbPHV2HxpWLZ9tb0jZ7ZI6teJ2kw74amK45LHEaNufL09iNFsZZNPPoEjEiY3Km2QQ72QEc9NwwSj2BJxDCr7ARIBgDUAePcdhwF97sP3DSm/U5bf1+s1ZGUU/WJDPTRonlN/wvvfPQfiLWehw+Js0RjBmXUwA8CXodJieF6f08X0lyNkvkmlFYSAnoz1gl2XvUo9DkqlCawi10Kht7tYs0MNxtR2giFeaItaoVrHKlQ38l2zDEIdAwfExhfhjJ8Gj6xpBwC/ZLhcSTWUwOrls8mGoWDbcZx95UltnI6bef8SMS41eTKpzlB8AbLHnDPUEmnJAn8Nuo3dMDUlmyhI1WoEBkxHh7AzcygXLSifmSoKVF4/YyAJRsXG//AniszAvweT6TZExH3UByw0596A8Hai5PPGKdv5wFkY5RptI0/uTquGZt5m1iz+YRsVxfPOD/VRPJb8tUmFAMTnhxeDAg7uq69tc3k3dJ3TWnxOj3nNmdjaDUd/0KE5Bd8dm/Gn+UHRB5c33+hylbB0v4ZddpMZRUQdc169OzQvjTy6TMwwYe5/r4xa5sPY/VHH9wMAFyaFmFSXLnZtq0BU/wN+/cq1axkP2A9MsbrG78meJK58+u9SLSd98wwUdonFgJKb+ag/6cVuG9Phw4HMTtFyx0wR0Li0r7gcneGq37DMkSzTgrnSS0kIXEWKuIxdgfJE1cud+S5KYkal7
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(83380400001)(47076005)(40460700003)(36756003)(426003)(2906002)(36860700001)(86362001)(2616005)(40480700001)(356005)(7636003)(82740400003)(41300700001)(316002)(4326008)(26005)(8676002)(8936002)(54906003)(110136005)(7696005)(478600001)(70206006)(70586007)(6666004)(7416002)(336012)(186003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:34:12.0967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6217f11-12c6-4798-db19-08db8f34a7f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
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

