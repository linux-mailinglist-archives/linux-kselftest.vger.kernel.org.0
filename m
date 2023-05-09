Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE946FBE5C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 06:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjEIEpN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 00:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjEIEpI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 00:45:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CB593ED;
        Mon,  8 May 2023 21:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFyFguCDz3k60qrx3/3cJghJHkIFJq+glbTi+SKG1PfQwVWzVBm8P/z3fmeidysVbeQzwDA584ceNK098WRYDHbGZabzf4ra9elwDuUtLwF4M9z1EDzOyXOQ6mB4S4oybvGTgm4gcflXqMAcsMW0za4TuR9JXQyrpGGrCEiKQak2DT+dCy31Tl9Bh2SADaOge4WiGr8bVDFjMOOlejP/THa5z6/Lb1TlFYaHapQbMvG7vPNAL4vFuQNDkrl/16eSJSbXhBxmowUEOQivik/fHqQptvN3PkY8qARO6sry23cN6BL5FFS2v5/x9MVhk4N3NP523BiJLfKM29hus25USg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc2aKx/azFpnC2c7hwbY0ynA6kIvS2Xy+Kbhg1tZrNA=;
 b=G88MhM7nazX8LSDXqPpJdRHyegQmudEb/+Os29lVSANcFJgjgzuikABtgksMNuZsSyLC4T0dM3HBJoO0CdY1MUyEkMXvBeFtHPU2r1L4BARhb9Zh3oM9iHml2X1xhXQcZrm9OVgN3wjCJ7oX8r6Earknmt3TQqqwDm+eiLw60WPTCCfnBP//xeROsrisGSH0XN5rXozi4p4+i+Orx6MdZMoTAlmWulERfUmbLxUQlt6OlrRQUBPA26WitDxYAJNS/iLoWkn+EUpIWpvRHHrAWCeN6ZRW5xGSM7cknGXWaA9BSENXh6svTsJOQ1RaiygyeWahH01GSpYoXkOaO2YXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc2aKx/azFpnC2c7hwbY0ynA6kIvS2Xy+Kbhg1tZrNA=;
 b=PBFp1CloF38udQJRWXqyEZIYyTKqiHTEFJ7L/CnHe+iltwvOmwNFtf1sYZbov9TPUmYoay9Il1pWTWt5JAGYZTygxjahO3PkY2a6rqla6uAWgHbFEnEoHuwx5A2H9FU+jsl1Li+tC8fwtzS+Sv/SnqlzxBGQ6ThA6ycdYLGjtWjdG+uz4QBeAK9IPuOM31p82SfUjAMsMoatYb4ORnJvazFyMFpUoakCQLlFZFJ26D0MHljqWpgZ3cUSaG8I3desyjjIB3bumkQzXSp+d5vv/xoXcXB9NP8blIhriBKn3nFGnKdr76u47aKgZnuQ8KA2084phM+/k/kSzTI6cNZlQA==
Received: from BY5PR17CA0013.namprd17.prod.outlook.com (2603:10b6:a03:1b8::26)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 04:45:04 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1b8:cafe::63) by BY5PR17CA0013.outlook.office365.com
 (2603:10b6:a03:1b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 04:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 04:45:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 21:44:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 8 May 2023 21:44:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 21:44:44 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: [PATCH v7 4/4] vfio: Support IO page table replacement
Date:   Mon, 8 May 2023 21:44:14 -0700
Message-ID: <cd12bc5992e9247296891429c24c600c5bad82dd.1683593831.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683593831.git.nicolinc@nvidia.com>
References: <cover.1683593831.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 00908405-c28d-45f2-7f57-08db504827a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4PoPlXHwGd/Ls4LXlVya0oD/eMiPBlFGses1T273esUJS9d3xlSt9EA5kVigW8Uh3zvdVpPWKbGRespZ3zsri3IdHTFlUbaxpWSh1NVK8y9lVnuR7eM3pciTIANCA/dK132FeCP3v2/qRPiaSF2RNvyFQDaz+Zfg0by9Vy3ywb6WE1j36NVl0kNDpiGoUSonzTAmpwjH6Lr2T1xM5q8SWxwO6dw4qx5rQ9p0rYvm7Q1Wezo8gU1VXXT/0z1niBYONZoGNU58ftDpUg0fC0hzz+AljAeVWy8zzFBc7sfFjX/PVIc58vYUY3P3bCOgLtYcXWNcAn4IUZrtDd5tWxYLKJuBuTeme3wP3QJbnNbUsuDeY9ZsfvqHQViHtNB4b10NWGScSLO17nLVnv95ei/4npnvyycaA+Ogz3FVOUEa14eU60vHoQR8xxdyz+E1Xflji0mdy1SHASW6VgGdCZAynDEe4lxJRyY3IGGf8SvaI88VhXhvpLtdGRZNSjiqloreJw2LBnuV8NZ4nOQaNJR/XMM9kKOBfy53LvIysmwSsgd3E+RiXm2e6h6FSV8Z6lhRD/rgXkoCQg6l8pkhfuRTEVgF7Qt7zOl0LZSJgZYW4+uanzgBZKFfu6aSHrvFqpd042G+H6Hn+74BgWLw+Bc1K+IeWcGZmK4+Wu8nB3T7OpZG32TxplyXq1lpDIutbGZOcTkm/RGR9xSBLAswbauZg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(47076005)(54906003)(110136005)(316002)(4326008)(70586007)(478600001)(70206006)(7696005)(40480700001)(82310400005)(8676002)(41300700001)(5660300002)(8936002)(2906002)(7416002)(186003)(82740400003)(7636003)(356005)(336012)(2616005)(36860700001)(26005)(426003)(83380400001)(6666004)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:45:03.4479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00908405-c28d-45f2-7f57-08db504827a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/iommufd.c    | 11 ++++++-----
 include/uapi/linux/vfio.h |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 00c14821bfa5..99eaf03e337b 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -161,9 +161,9 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
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
@@ -243,8 +243,9 @@ int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
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
index 62bd41c214fd..e57112f63760 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -234,6 +234,12 @@ struct vfio_device_bind_iommufd {
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
2.40.1

