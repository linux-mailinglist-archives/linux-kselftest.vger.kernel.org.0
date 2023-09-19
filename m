Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB07A56E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 03:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjISBRD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 21:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISBRC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 21:17:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15C10E;
        Mon, 18 Sep 2023 18:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL66NDqyOblavYiD9C+g3IEszA2IODadOpFAYTB0kKc9RQK96bzzpXMr4KfQGjcqR9/wV4AweFczljzOWpyVtmH6/hLJ/GhECn+TEseMHLOnTjoC1KB62WT5XaSiswJkN/WNRupoj3dKpPbrtXmd7rYl/oDkWBPxmyZdsXSKOmXQ/Aw89i0R7KhkISTIpa25Vf6niuWTa7n1WQ//m5YdNDGUC47+HwaTrz21k+pGPCuHpJgYIr2e+rN3EVlRhwzg5j030ir7fHfoXBWuy/QHa+pdYZcejX+YZBn15g0DbBCY0mANM4JBlh6nZnxatE3oimgr09z0ikBCTA3Jsm5/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRdZPUa02x3o8TT8X6XONiaTX/Dw0W4BzvRfEDTe84k=;
 b=Wv+aWfsCv8rxOsjnmcik8JjdsutdSgwBrhrzGCO6KyukLjRVTDJUJadRqT/luq/Kr3mHp74x7Vhm0eqj0akq7LYqDv0wqYrUKdhYGYTigWKi2X6/2CB6Q698kQgXzJpIRsZi2xU8ILKky+brbJWyZ2xtnfNQmpBhKFvN1yHV6ofUMXoFt7tpmnh/utUAoTCR9e9V7RqNYOnNlZ2RiECFwk8EvYgeucKrlZHo3PlixIegySFZOM8K+Y8V+hLHaxo+D1A95GyxShwBqzofGWwEnyo8/FNM7nSGZ/tJZVTm/dM2gOCT+FVk/jQETn4wc2EiOU/R1iksnkyZ0qtY0h7Z4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRdZPUa02x3o8TT8X6XONiaTX/Dw0W4BzvRfEDTe84k=;
 b=Yo9NbGYS2JHp8Sea/yGTx8xlpLEOtXlNAod5XiNxz9K9TJVUAtS5363OjuQPU0iNzlZf1PlEOE48QFTcSJAkooFM9Ih7TnK2CNnoaYtWappoQeOYyOcjWnr64wI+dDmjcGtwfF5QoLrDEx9fPHRW4cWS67cEbVDa7qpqux6L79EDLwF3EevWNNV9vpXQTO1IDVx0AYnUxbQFjolgVRvVEacHOiJzean++kJMpxXExbHMkPcY0fwk+nfzgW1yFZdyOyCKPZ7XpVo5vVVc57Q3+t99LBafaAeOJ8u+uduvcfPd5AwdENADPWpbzaf2CVxWQ2gaMRE3GGd3L6UQJmPgcw==
Received: from DS7PR03CA0158.namprd03.prod.outlook.com (2603:10b6:5:3b2::13)
 by DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 01:16:52 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::92) by DS7PR03CA0158.outlook.office365.com
 (2603:10b6:5:3b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Tue, 19 Sep 2023 01:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 01:16:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 18:16:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 18:16:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 18 Sep 2023 18:16:39 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH] iommufd/selftest: Iterate idev_ids in mock_domain's alloc_hwpt test
Date:   Mon, 18 Sep 2023 18:16:37 -0700
Message-ID: <20230919011637.16483-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DM4PR12MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c9e4d6-036e-49d9-1fca-08dbb8ae1b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+gvBEFC/2C6TSgANeyY3aTU9xuRbA9KwsLhvTYXTN0/9akmpcnE64p23uFH/25Kdz/tvCjujhXdl+MiFs8oO/wVDltOL+HRfljmuZWXCJWSDVAwkl8V5o84kxRyVmnALDulZeG01qHDmQyAmwD7ABIeRpJIi6h5C39TftthdtpzFfs6PlVjuLAlsNNCJTiLns48FKU0nn02Dyx/9aDlWNVU2nE+ayiJXQPjOWYZbxPpBLRmGoDzqzDFMLy8CYQKTtLCXI+RXVAptegQ4LmiJDSVG3xHYqwNBju+Os4T+ml68thq97QtWcL3Wo/I9HoRVZZiyG3v8RZHwTK8D9fy+YCdOHgdJ8G3YAO8hFErIkmUBwrbbcFN8Wxsowndiq7CMHQQAEcGp7qk8oXNptqE/uKUvUa5XTTyAv0lxdhmlIBfbQwx+ShEgjX/T03rGJpFCA84fXuWF3RMLzZxPHmL2BkSk1ej9tCTYmn4ix2lMG9pa6X3+8v1X6u3+6usLUwl3j4vTYOJBPciydjIwBf6w5JXn1b4DeMWqFzqZnzAkmyNYtpXEysTaNCyWVb43yg4A/z7D5vRdqs1h5q4oVoE0Wl39tUrPcI0JvH7t6SHwClLKnKYyK7wEjc6jYFWSPb6QmfKY10jH/QbPZi6TDfAGgEgMAR3HQae/rqx6Ag9BRykN0IF58LunfqydUdGIG44zvzLuZXEhcgay6fa+hu4BUI/hJbJZ2FaZkkRpAhSW0Y=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(336012)(426003)(83380400001)(26005)(2616005)(1076003)(47076005)(36860700001)(316002)(41300700001)(110136005)(54906003)(70206006)(70586007)(5660300002)(4326008)(8676002)(8936002)(7696005)(2906002)(478600001)(40480700001)(86362001)(36756003)(82740400003)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 01:16:52.2043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c9e4d6-036e-49d9-1fca-08dbb8ae1b39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The point in iterating variant->mock_domains is to test the idev_ids[0]
and idev_ids[1]. So use it instead of keeping testing idev_ids[0] only.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Jason/Kevin, I formated the patch with "-U4" so it shows the "for" line.
I didn't send it as a bug fix since it doesn't feel so critical that it
should bother stable trees -- yet if there's a need, I'd resend. Thanks!

 tools/testing/selftests/iommu/iommufd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 33d08600be13..9f705c1ea30f 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1406,9 +1406,9 @@ TEST_F(iommufd_mock_domain, alloc_hwpt)
 	for (i = 0; i != variant->mock_domains; i++) {
 		uint32_t stddev_id;
 		uint32_t hwpt_id;
 
-		test_cmd_hwpt_alloc(self->idev_ids[0], self->ioas_id, &hwpt_id);
+		test_cmd_hwpt_alloc(self->idev_ids[i], self->ioas_id, &hwpt_id);
 		test_cmd_mock_domain(hwpt_id, &stddev_id, NULL, NULL);
 		test_ioctl_destroy(stddev_id);
 		test_ioctl_destroy(hwpt_id);
 	}
-- 
2.42.0

