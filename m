Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0DB6B0B01
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 15:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCHO0f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 09:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCHO0e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 09:26:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C4C3E27;
        Wed,  8 Mar 2023 06:26:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egKeappAzFlWeDily9eQoWgpw0DTjAtw23trBMh1HGayc4HHu+J1TbQv3R9OId9QqXd+zHxktm5cYmt/Dmt6jw6JlXQ82D4ogdUsnBXJxALf82EH6o5o06DPBPnY3PYbtn1fgn0skV8f170bzFT2D0sjjwewxg3rXUpjriiLcdEF2wntziTeHEso2a+JjQB/Nj4XmBbccC92D41QqZpYZvRki0hynMvQ6DwItUIuJfglaki31Y/f5ghG+pT6yC/81AdWfAIt3ittc8iodKLxt1mR0IyT9WqvoGKwNlBjLmOLTLqou92/h18VdEyCbKHypVXIHhvKnjbGdLFGK3hkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss/5/RsG79O6QZhht0gvrXJr/7k9FG5EPgRft3KsyRk=;
 b=mPoTWNkG9k4aTIVwH0J4j1/Tgjc4r2Y4EBKTMCMG4vSxq+TdnL+GyP2Pb8czCvtw1zhDGntUFfWZa65aFNr3HLsyS3nF/p4kbuVQkbJrjyiWOfqTAyVPoUSOq+hJZYWm4LsrKkvWhMtJR6WJRQYvEQwjFuekBbiCSbBGWblsaH9g3yiO+Zslq4o8EdFCTj33BHjMzlhqLzQJpiwRD4juTH6VGulm/gJa0ELLjeFgQ/0WN9iKvGxgMigeW1w7Jcdhi8jfMfNRZypOUzmmk+Flypv0qlhNSNTvjjA/a6iWe3TvRDSHbegDym08VmYF2JrNecDXSjOs9AxCbx4n8DG6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss/5/RsG79O6QZhht0gvrXJr/7k9FG5EPgRft3KsyRk=;
 b=X5MuPW7cDVe+hW+ZT4OzrNG7srm5HhtgZFlezsyep1QJU8u5qenelep9Ij5snIYYucK6hkFwauE3UBO2ZGkltiFV+s7vLit5MZ3hqNoeXS3vE38tzvhBffrCvP4FSAlCo77MWjLso0D1S3LFWL2Y5UVXcsKIdBBJbOY8oC/7JQUp4Ux3tPTvCiqXBNnAOoKCmJQlZc/HwR3QGFugJmTs4MaGlv9xpDVgZp0/q9hLmDJtVEa2PoRUJ1w5it+YiwFawYjHNS63sd+7LqlPnu2FfLox3H2u7F9dI1tI22M8/0oVPwhQXwW62AY75RIf0Kvgk/Oes7NahUqcaAw8mt9szw==
Received: from BN9PR03CA0736.namprd03.prod.outlook.com (2603:10b6:408:110::21)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 14:26:28 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::12) by BN9PR03CA0736.outlook.office365.com
 (2603:10b6:408:110::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 14:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 14:26:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 8 Mar 2023
 06:26:20 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 8 Mar 2023 06:26:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 8 Mar 2023 06:26:19 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v4 1/5] vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
Date:   Wed, 8 Mar 2023 06:25:58 -0800
Message-ID: <2dc87ceb7bf02c7f405bde44e9ee9b21398c5228.1678284812.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678284812.git.nicolinc@nvidia.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f17bc5-39a1-4f32-f53f-08db1fe11afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yguxdC/5yU068tLy30R/cpalEtay4fQozNcLFmxT9x3zkcH4JRzOlvJ6hAojYeUZ/Pxu7zxNulIQ9iGpkLV8dVpubvz5U+oQCRpB6tBAu6CVdSPIO237pkOYc6JYTpDheBkx82Kjst4ObaYrMmjkMzn+N1oofQ7jkYm705A/Q0mMiauviF19O/JOnAas19/iVO6dH1w0Dmk6iOiUL+i4YX7e3c3pEIX0jriBzBj4JsICkFK3v7GpePZdEj1/H2SgK0Oes4uTtwBvE6AKhOx5F7PO33RFIHe+E6q0H74cHcHVSCvw/O/6Or8MAX3IoXvwUMH3gs+l381bT9VCa4Vt09An/gJQcfXxUw8eeAnzJx+z///zIrlRBRCsFoXGXWZSffWIpSNh8cGnTbLPJw717h/gLjdlID8QTCQz/VSaNzBuP3AzTFBYJU8xE5VPMz03jZMRwf+NP8Omm7iY5VE7U7B3dNFaTqnjK21WD+I39knoOQMZIksadjlNLKkcjpfzdLrQG7IShdsKW1YNUU67vK3huIMlfLuPCi9ppJnDsBXLgWuusWbXJE7ytgEm3ojtPsrECiAk6ERdoQQVv91dCkS2w1FU9LcOssoKcufYoX2K2KIFiQPBxzb1JMn1780ppAiBFcokTAnawVrgn1YVhkGcQELpjxJmJhuxYP0us+V8IVjw4X0AN9MORMVlEAKaagMgXh5avRclUFAOCETm4Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(54906003)(316002)(110136005)(186003)(478600001)(8936002)(7416002)(7696005)(5660300002)(40480700001)(2906002)(70586007)(6666004)(70206006)(8676002)(4326008)(41300700001)(356005)(7636003)(82740400003)(86362001)(36860700001)(2616005)(83380400001)(26005)(82310400005)(47076005)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:26:28.1939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f17bc5-39a1-4f32-f53f-08db1fe11afa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index e5f4738692ac..32ea7cea1236 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1522,6 +1522,8 @@ int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
 	/* group->container cannot change while a vfio device is open */
 	if (!pages || !npage || WARN_ON(!vfio_assert_device_open(device)))
 		return -EINVAL;
+	if (!device->ops->dma_unmap)
+		return -EINVAL;
 	if (vfio_device_has_container(device))
 		return vfio_device_container_pin_pages(device, iova,
 						       npage, prot, pages);
@@ -1559,6 +1561,8 @@ void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova, int npage)
 {
 	if (WARN_ON(!vfio_assert_device_open(device)))
 		return;
+	if (WARN_ON(!device->ops->dma_unmap))
+		return;
 
 	if (vfio_device_has_container(device)) {
 		vfio_device_container_unpin_pages(device, iova, npage);
-- 
2.39.2

