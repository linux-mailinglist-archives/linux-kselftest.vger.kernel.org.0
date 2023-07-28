Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D139A766439
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjG1Ge3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjG1GeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE430FB;
        Thu, 27 Jul 2023 23:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBAo1E1zGow/0k1L1BzMTWBrkMzyEQt2NqFbVdy6oiARJeBBonTTJWtUo087fOV5ESC5G5Iq3gNImwEHwK7zO2SRa1RfbInzi89VmuDwrZeBfgalZT8J4MCFIA7o9JPbCshky37xworrcq/IKF5lLkxRV5KhKoWMhy2eoQSabnqcHyB5Rx2FRpUjOiN3qgYlCPURxCz+fVLPr3bl9d8U+wC/9rExBuTUxQwVeUUdg2UAAK6HQL0maGphdyZQeZEyXuO9xA0PXtHxtumpNNcuBiyaPUE08UAoEwRL1Skzg1lBE5ONQWPup0U2KN/W+z0lmzqxsaX8uiyy49q4QDke/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvoJA5BftVG5tmbJHmelzB7Akvp8C9pV19pS3cZgeLA=;
 b=MfU/ynteayz5zP/4Mm9WG+2r7CIq5G9jQUu1CFoBon++3QMPycCDSyocQaEHGyHH09BVfWT1SGB5ovGh4tPBUECyUMIj3hhZEsOuaeHK2cHb+Vnb3cmb9J1ujsqggBzEMvwU4f2x3YW7zuLoOHAFRYNRNTlUU8rIUs/vFpal6wO0pK7/xBb+R6Hf6ZJnMMSAHz7YKKtAzFJWK9K9eEOHYDOBYasyUufcdysMrJZ9rE9ff0VAUxFic9WZ9m1f9E7SmdekMesj3hYBGETtLGeDB4Envjdy+Fl0JTMk26ZFvcEuTCj5KogUfzk9L1c4/ZQqKqf9BhrbSti9O8x9zlOR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvoJA5BftVG5tmbJHmelzB7Akvp8C9pV19pS3cZgeLA=;
 b=qR0XXjSWra9oVMNFYHw4vXW604GqBZAgORGco8CLtNbAwoiV4McDUKJttAg53UQ4M0c9+cvhcCcApHIVbED3sE2uMM/7aqM1Ojt0FhJudSN7yS5YvYkEf8Q4KWZVRXwO50wTZytNI+R8MANf2fuI1T7RTPpAWWiV19+8/KSAulClGBrBZxPowm7r/UgqNvL1J3D6wlp/ksCH3n/xhDLya3P1Av72tYc6pme8WoAgcfz1vb2kliJQ74ylqWjP/E36HMdq5vyYJ240FC2o6cLPVkbAZlvKerEBmNIFH8QuUPMY9Jc3Kz6jcSIT+WgfOJk81gD72/saDYJbgWAY2tYKKg==
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:34:11 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::25) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.34 via Frontend Transport; Fri, 28 Jul 2023 06:34:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 23:33:56 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 23:33:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 23:33:55 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v11 4/7] iommufd: Use iommufd_access_change_ioas in iommufd_access_destroy_object
Date:   Thu, 27 Jul 2023 23:33:26 -0700
Message-ID: <f9fbeca2cde7f8515da18d689b3e02a6a40a5e14.1690523699.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690523699.git.nicolinc@nvidia.com>
References: <cover.1690523699.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 67891272-2bab-4a1e-ccc2-08db8f34a724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+q3C1oWbcyY8SyIk0ZnJFVq63qdrWJkpwEA3pjGbjXQLTqQanpPgvzkguepRME/1+S+JJNmP+Z5jyTZYG1m0SpqJjJd3DWNzqfIJQyMKCMyux3s+TSqn4tE3Yz+J91yA1/KLQ5BzrdV2HZTXvDg8Cizmm/9qXj1dOa//vLJTg6/OP/eafYswkHPuXrndi17rXdoYpJnK+ft1yLg+oEma2CS76BDQQw847ZMJGaN2Oo0OKriy7k3JMHmQ2EWj+E755gGKi5ZKml4Qgf5VUdWrukHtLIq0flVwtMwdOrWbS7In+Q04KLeQqGe++mbues/VqmwQWNJjsfH/fF6fOfM/5nwSjDabFzrg+gITuBZu3xYORgmiO9GU1HyUkFFkoGEmEelMiBwb+rwZroasNkRZQfdawW/4IpJSdvmL/rwQGtpw8uqZt8Co9YBJpuTVNuQ5/C/5F2ztjVxyJ8y7V3wOgyYffov6xs4KXPsPhOKFUdgpKEb2p4ntTDoNDZf6+ITwwBxlkGpXQ+zD5i93wjuVw7TX5VrM3PwrrT1BpbpN+XD3HPE8O/FPCJenXiS7Q7xLPrjESKp87HR4g/e+179mLuFHl7J4iFMzLPHWZOMWF+vYOV4XGN0UK6hgBiv0S0Ps8wI0R2V1VaUJW/t4XuNAS1Tn/VAej1I3aEw2JF9xnwuokZVhw6NI1FnImQExeui/OsJ9mTUWRT9/IqLxPSq8D7ZN/5eXp0w7ZmJrIdGX28XlXxBAAqcFD1IjzW5xfKW
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(7696005)(36860700001)(336012)(83380400001)(186003)(426003)(2616005)(36756003)(356005)(7636003)(86362001)(82740400003)(40480700001)(26005)(47076005)(4326008)(70586007)(70206006)(2906002)(316002)(5660300002)(7416002)(41300700001)(110136005)(8676002)(8936002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:34:10.6772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67891272-2bab-4a1e-ccc2-08db8f34a724
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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

Update the unprotect routine in iommufd_access_destroy_object() to calling
the new iommufd_access_change_ioas() helper. This will reduce some risk of
race condition with another concurrent iommufd_access_replace/detach call.

Note that the behavior of this function call is changed: a WARN_ON will be
triggered by a -EBUSY return code if there is another ongoing detach.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e5c408415e95..c0b9cd97ec58 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -753,12 +753,10 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 	struct iommufd_access *access =
 		container_of(obj, struct iommufd_access, obj);
 
-	if (access->ioas) {
-		iopt_remove_access(&access->ioas->iopt, access,
-				   access->iopt_access_list_id);
-		refcount_dec(&access->ioas->obj.users);
-		access->ioas = NULL;
-	}
+	mutex_lock(&access->ioas_lock);
+	if (access->ioas)
+		WARN_ON(iommufd_access_change_ioas(access, NULL));
+	mutex_unlock(&access->ioas_lock);
 	iommufd_ctx_put(access->ictx);
 }
 
-- 
2.41.0

