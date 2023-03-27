Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19C86CACA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjC0SFd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjC0SFa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:05:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691CC30FC;
        Mon, 27 Mar 2023 11:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbC1uiNj2nE8EEk4Adt51n2/pqwzZqZ7Aj+h38w3VKJOJzvHOPRzqcEiTycVwiUxt7Gz3AytNtRbHfN31M45H01GFRD0Xiy3xjdAtpNJj93kjS6MH7xSd3H4DsPtmjGCllaeNogktiWZQ9sWFRe+rkNTvMOT4xlNKe2R3gkbV5ZlokHNa/5jbZJLHyg+QbABaZnYmHl+hTU5QjNF41eVa0rJxQ8bz2iPsUkWVKIBBqPlPbrzG73R+0ihsDsmJvQ8NWJyYzMlCCuFlnHubzKZ/imwHxWDjhJYgSn1SFGq8onyh91QWICKlAH1eqK18azGnT5JIOoA9PQ76Ai01bsYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhsXn0FewKVnreJMeACOaqjGG5sfQjsE7ypOeLMVg9g=;
 b=V/zYO3cCf6drME3gEnQr6dHNp3TZWRuEnasy7BHVHrXO15zkwX4ipcIj+XWVFnfmnHGsliK0kPLsY4qmKaYzhQTTiMzhChbGC4cA/rkwG1ypUmUVbCL5AoVmOMLsCjLE3tFtroREiUNEoB5W3kVdkr9WaXsbFcrkEY3029scwdJsGfZheBz/5VQw2NfBEGzMWD9tBDIvbLd8JqG8RnoHiPXCm2td68HBDAAZt0By/fu7SZUt2skNipai22+kY/xRwnFpdlc//tAU3wZMEiyc8cCAcSf+GkG7JtnEGu//ASdHgL5zwPc7B8/YmmDKaVG4YUFaj+ViL6ij+1lbsNUMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhsXn0FewKVnreJMeACOaqjGG5sfQjsE7ypOeLMVg9g=;
 b=Ib/ns/hkdlO+7R4TiVQA57DPiQg/cs+hJxtOGLdJK9uEFWcHMkNLMVjgKEzidHherop+VBZd9byZrHJ6uy9ADms/GbTWlND09paanZqkYhYNiZQlpLHaTo0ZfpjaoWSJDIU0Q3t+0qL8XVl17FLh0xA0F9NT6Ngq+jUOdPkmLYHkbz9eyoXgxFZ0RLa8hnfL3lAzvrZVLvD7ZllnMi69o1MMe4aPtQD5CfRxnqHzxKvnhpcuOC7jt7wqS3ISK+DdPvDmORWW2pN9GkzbzOMTMAKMrINr1IrR//nb0ky5uJ60pARYyGtsktw5vQBsDThDuGxCmP0JzRC1iyoOzvjlow==
Received: from DM6PR02CA0127.namprd02.prod.outlook.com (2603:10b6:5:1b4::29)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Mon, 27 Mar
 2023 18:05:27 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::b7) by DM6PR02CA0127.outlook.office365.com
 (2603:10b6:5:1b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 18:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.9 via Frontend Transport; Mon, 27 Mar 2023 18:05:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 11:05:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 11:05:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 27 Mar 2023 11:05:13 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v6 1/4] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Mon, 27 Mar 2023 11:05:02 -0700
Message-ID: <648acac966bac4c4760faf8be5b05d054b8f3f6a.1679939952.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1679939952.git.nicolinc@nvidia.com>
References: <cover.1679939952.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc5a4a8-7c77-4c57-8721-08db2eedd83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJWrk6XR6dFMWNZvhSo/Rda4bTXXzSqgvis6qKF8cWtKA9p6eX29oCllDPPz8LSOlk4rKRkj7SD9HAYgQfzDX1phYxEZQRuweX2RdDEgr7m2mXgVuladIjbDPQZy1Vy7WPi+mGms/VLUbb7OZ4MQBv5850DykdnpJs678NYEhWdVHUnW6VgXvbu5w8lrd0PvW2/fwqRXiFlOsR2c10Ffwz3PFncIu6ahwRS5bgsiJbHSlkJZ/3Y+hjO+HcGqAXqqMsoaMV5SM4VRC9C9SotdMoGMw9OZRqQEf8WPn6MICTKOIm5B82qQqHuxkdDRNPAq2zM/c+F5QwfEGNwD4cRBZClAfFr1MjHcor/xXpWRJCpZx7LMtdY8RDomfjZJ35AFdSs3jVDdCMFfPdDZ9TqcTdPii7mJWb8r9qv1xftXvhyPsjPludl9F1FEt1U3+P3sSbKh/63rt0r2+hKjOy1gWytRPYwPu48x0Rb1MFWCVpipHAufVstjqqFgeqRu89xtR+ybP73zowcJgouEZ0YvjL2znXb9AadP5ilkV7jgnBwJHC3oT5zQB5gKEnZMcsc9zV4Ncz/N5EMf6l9+qJcJqE8wLHKYiGt7hfpimcSk+8Rx/usvmxS2YbfBvju1ZtTNWf8Ais5OaggpFlVmo1QBJwlMEqa66WdU368nw7Adm/vIsZoKz/Cq51t5nAsupudEFwnwJxytRwhIxSnRxtbU65BBek1rH75nBtuVF0padBB6vx1ag8/51o7dROCbNbC9noxPGvjMobYNQjrtIpPGpfWs5t+upnP1gbfQXVAn8uI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(7636003)(356005)(7416002)(426003)(82310400005)(8936002)(5660300002)(36756003)(186003)(26005)(40480700001)(2906002)(6666004)(47076005)(86362001)(2616005)(36860700001)(336012)(83380400001)(40460700003)(82740400003)(34020700004)(41300700001)(70206006)(110136005)(70586007)(478600001)(4326008)(54906003)(8676002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:05:27.1557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc5a4a8-7c77-4c57-8721-08db2eedd83b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A driver that doesn't implement ops->dma_unmap shouldn't be allowed to do
vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 896d8bb49585..48807d587946 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1485,6 +1485,8 @@ int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
 	/* group->container cannot change while a vfio device is open */
 	if (!pages || !npage || WARN_ON(!vfio_assert_device_open(device)))
 		return -EINVAL;
+	if (!device->ops->dma_unmap)
+		return -EINVAL;
 	if (vfio_device_has_container(device))
 		return vfio_device_container_pin_pages(device, iova,
 						       npage, prot, pages);
@@ -1522,6 +1524,8 @@ void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova, int npage)
 {
 	if (WARN_ON(!vfio_assert_device_open(device)))
 		return;
+	if (WARN_ON(!device->ops->dma_unmap))
+		return;
 
 	if (vfio_device_has_container(device)) {
 		vfio_device_container_unpin_pages(device, iova, npage);
-- 
2.40.0

