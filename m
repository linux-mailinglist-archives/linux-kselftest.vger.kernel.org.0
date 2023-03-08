Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA36B0B0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 15:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjCHO0s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 09:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjCHO0o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 09:26:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F85C3E27;
        Wed,  8 Mar 2023 06:26:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLS42hZ38uSCszISFzAVaFGuW6+L1Dmor9OOPzGwMZBnBtWhcOUuD+PeHvQHwYPzwqCkwinST6UgHElvVv1EbTJbQlSP8jDoRPqRzl/vJAzBHIgqRMk2hcmP2Yg5iQPGTEkvi4Kiil9IGrlBiNAaspWq2THnmPiG7lAI3c06//v5o/wtWY2GJqDSMepSyKBtNA3SF3NhA6KDgiYJX1pVPfANc83JOlm4Q1VDjFr2R8vfdTFFWh4Val0l/ge86g9hilBDtCWv/u+FdmDXlwrvJdcLFmBnbDUY58f5ydNlk+oE4hOIdr2VPqsKB/bipZC1Hedn2PshZEM7LPo4LnfNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEHEiva0AInWLMPGMorLpy6fr1b2GpNjaBysPbPcCOw=;
 b=fklRz0ibqsHhU+/guB5tHro+6CChQQlnkabJM+Xhq5hqjCZ+oMxt3jyy4zQAk43LQ4jEIrwN2nWl6QFQ4pB6/UQbTZ4F7B1NNW4S4HxI3j19FqlQxYAt3MXjl6mQlUYJt22irIefyz31Kn9+330DDyXDIHXkpRDPSOVs2GqiCYdITfdSj0hX0ZJAa2uF6H68ydTxyioxFihC4VBo6MALD2ugyX5E2VYOsHc5cAHY0/RrCmJY/nWLbi0uOvDK/Cz52iwbXmNrXUOVXyhs3IUqYLMzgVcyhNBTJgOExiTqyFRELJfxBnQckgDutDxZCAi3ULUn48bnRVGMPHeZBYK7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEHEiva0AInWLMPGMorLpy6fr1b2GpNjaBysPbPcCOw=;
 b=DIvSE+xLdvyru41ugUp6dqeRkL9D+9y4JixJYNZm5Xs4ODVrU9ENFGdB8/U8xpRhs0mWT5vPwV1KjT1LiSNzYrr/C/xtU2i18BrVgLivBLoRso7IziBvJXxQoaaho1OHCHKYEUBMj1v954606thj2nfaDnnTZSi8mBj8s/BIfKSUMjlLsK2zwNeVl6ud9cii50F3cMesxCVfmM0q3nll7HAlJy+w3LHbWbhMt0O2So6592C8kBTB5aJPbB8rKh9pl6dpQOQtBo6+kiN5uAQzGBVtfeDb2J9CUVABInJhY/WEcnVX+p8jNkYHw+zDJlza+R2WRZ1XgC7bKelri0nNBQ==
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 14:26:36 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::c4) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 14:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 14:26:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 8 Mar 2023
 06:26:24 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 8 Mar 2023 06:26:23 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 8 Mar 2023 06:26:23 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v4 5/5] vfio: Support IO page table replacement
Date:   Wed, 8 Mar 2023 06:26:02 -0800
Message-ID: <600343ffb282ff3bed5eb98a9255c0084d01a859.1678284812.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678284812.git.nicolinc@nvidia.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 7324f2f7-7edc-407e-802e-08db1fe11fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRhummsE804Gc78CWoI49EcOI8MS97zKCxpieW8/j+2qLBz6ClZnNbz6bkP3iIoujrQb0p8uSDDUFEAb3svwlu6zZAjfeurseFfwzGboT8tjL1CC0ddSH6RlCPzxpDuaY7UUuSw2qpyu+BbIESD/wsCoYAlAfExjL+5LH0rl2vbPt64HMJ4VDryseDhvfFtKyg4IYF07i0dTZC30Qo0domzr47QdLvVog2j6DTMEXJwakvWKMNta1mOK/sHdlH8Qsy0Cin9yZRvoc2ZRN/YXQdJWwaYQ1g/r1zAZTuW79YMwJyXOih++zAe+QPZeM+om1bNw1sINstiazQvod5SXvt6LfR6Aph3ZoKgfE+qJFjuwDLYf4o5q4/gBeybnxz1FrNE3+RaeJNxQydBq6APzeZegz7YBF9LaRtd+ckcQXChUgyP+zjRxG1TO2DnE7ZDOf7CxU8A7sAa5voFhzTuoC/sCeFEMvE2FFNc8LWjMedlnr8mwqMthMvbLkB18jbnmK2Jrty4ukrxHuAJMcri66hG/4OIii2NPanGlANIdbJT1pQr2TXIGEU1XjGctgVVDDKndGf2b08BiAAS0BxMLRw1m9LKN3pAzMRCwIUqwDSzCyNyrzYGCeZdEr91BeJoW00LSrXuYjPOJbUnXaDRHuyEqplakdRTon8gdoZpjfPFsGHCjg3AgzO923JFIn5z2oL5vzywihA4Fxq3hiskOwg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(8676002)(36756003)(356005)(8936002)(41300700001)(4326008)(7416002)(70206006)(5660300002)(70586007)(7636003)(86362001)(82740400003)(36860700001)(7696005)(6666004)(478600001)(110136005)(54906003)(316002)(83380400001)(47076005)(40460700003)(82310400005)(2906002)(426003)(2616005)(186003)(336012)(26005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:26:36.2584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7324f2f7-7edc-407e-802e-08db1fe11fc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now both the physical path and the emulated path should support an IO page
table replacement.

Call iommufd_device_replace() when vdev->iommufd_attached is true.

Also update the VFIO_DEVICE_ATTACH_IOMMUFD_PT kdoc in the uAPI header.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/iommufd.c    | 6 +++---
 include/uapi/linux/vfio.h | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 8a9457d0a33c..a245a8e0c8ab 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -145,9 +145,9 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
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
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 692156a708bb..14375826a25b 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -243,6 +243,12 @@ struct vfio_device_bind_iommufd {
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
2.39.2

