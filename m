Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93A7BD815
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbjJIKHb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345822AbjJIKH2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:07:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223C5AB;
        Mon,  9 Oct 2023 03:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GduwwFw7KPBIkq+jQ7Kc3VfaZLfHoqD5H75q5GCP0doyYWtWkpCxv6Ck/bwta0qOLB/d6sPlDGMZ47/XCuYspTULWlp3hOdPzu7DNqhjMz4mi0ZIAzshpCFim1eUd+EYkUpuc0CjSVg04FdSSOJrCvierTB08imy9lfK+SslhgzYzmOkn3a+wmIdfjhiO2LQoWjNvT6y5QA37mCp+BD/8H+AG5dgjcBBh3FHrCQB22YBe8xkLg0k9wlWkrq+L+6wM0NCS/xsB0gqhi00aYzWTf44zqAm1dSZhzp5BRsqBubooGnVcwnpxngbfyOZrmZicqdJSxqHuNhBPftCkmccog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HiHzqApvoOf/BYHCJv0CGWSnumfWBB0kh8K60Vg7Ng=;
 b=HQn6NfibJg5T3/BMOymMQAzzhQ1IjKRcD1rkhV97JDgXkYh69ftFWQRZMNOQvY73hzaZXxB6SK91fSQQNt5LTIxIaaQ56YavvrY49nomP52bTkF6V9O4Zloy5viM80wlz9MgcIRzuE71MXUuB0fThfe6beiHFdNX5bCk0rZqoV7+IChMQG+Qb2fapjbEw4SHdYtUNIVMrCqmM9HFdAPye3LHioJKRT2l2RjwTn3xYtjY5dnmUV0HS8iG9WN/BVgrinSf5fAXQZx3XuH6czcoaqxHWO7W4qvtLEYHbMv4fVbZCoiPjnh9LwtjLR2UpTU2KR6gGKOvctk0fPUMvM+Ilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HiHzqApvoOf/BYHCJv0CGWSnumfWBB0kh8K60Vg7Ng=;
 b=kCvro4akQgE9IeYQ0x4TnGb0A6EYxZe8ZdFUQdEonNwZt+uEmsF3AX0xodySd02IVyGWvSvp7vu9D/sDxs3auWG59JdsAFgOzl07RSOS+JgI8smVj8rZsY+iUcMBFA+Caf3ZPXVVq/cCPXlvWSy9cLzn4i6Ae+uRyd9hKTWCSIw4I7vH4eYOmu95jpwJLW27ry0dRTn+N6Bobq3ttSopIH+76mBgj89oj2lv1Pm+FpCQBMEg8Eb1dhrcyrZ6ghAIlDbPh32N9kj3gQKcHtB5Atpb/XsxNle41fxrDU+m3RGzsHZHeOTN2IeSGopf9fUeKusJz1MkJMxOtNv2dOxYYA==
Received: from SJ0PR05CA0209.namprd05.prod.outlook.com (2603:10b6:a03:330::34)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 10:07:25 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::79) by SJ0PR05CA0209.outlook.office365.com
 (2603:10b6:a03:330::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Mon, 9 Oct 2023 10:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 10:07:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:07:14 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:07:10 -0700
From:   Amit Cohen <amcohen@nvidia.com>
To:     <netdev@vger.kernel.org>
CC:     <mlxsw@nvidia.com>, <idosch@nvidia.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <roopa@nvidia.com>,
        <razor@blackwall.org>, <shuah@kernel.org>, <pabeni@redhat.com>,
        <bridge@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Amit Cohen" <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next 06/11] vxlan: vxlan_core: Support FDB flushing by nexthop ID
Date:   Mon, 9 Oct 2023 13:06:13 +0300
Message-ID: <20231009100618.2911374-7-amcohen@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
References: <20231009100618.2911374-1-amcohen@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f305463-e31f-43b0-8c27-08dbc8af8933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UI2Q92MgMiW0jZvOHzRXsfVBoHUlCj5zzEayLliTw0vdcHxyGyZ8EtGQOjW9/++n+QR5AzxtvjvVpO+eLLsJfvRIJVWdaLrWWCiwKugUML2ydAPJVqkVpfIBRw8a+SSZ2tQ2KhKXSnMVxq8oyKb1/v+GOfMlQBngD2r+2oeGE+l3h7x4Ymt56lnvVMMJ5hWGMu1rw9RJas0a4h4tN62DO2yQWbM9AKPr1yKCZAq1BDqjs73U07kpy4si5b944uzfZd9mklq4N1mSUGLOUHIWj3ZvNfov0abdu/bMB7+mHGHwf38YS2iMg0HZpK1E7qr2PxmDFSFYRYmA4rqjLUiWQ+xaqFUzB97l0T57B7+rwpDs6BCX+4J8Mw+6ypAGVWzOC+V/WZtTYSjyYqnOvYPuEQhX0DqMjD/G9xFglOyxZZ5zNoRpo+YKBSTedORu4V/axuo6RYLE2OJoL8HNeYPMHWMnDIVFqaTbAPOQroDhEYreX3pyCid+zBEr4u4wsFjoHpO/tKTePuJDrdl7TDL5O7h2/iih81GDqJeCdHrgi/r3YuJJ15QZyaZCYUp/Wa2UZXoz8TygLQDvNT73IRG7G3ieXi1P5ifMyYcovTMuaQCSP9sWhyNN2vxayyhnilQFgIeheAHwMQgVNwygwuxYjSb9zZqis5FlB+z0KKw0gCOeKZb7KARm44aehCmd76PXgUWO5d39exnu/1/LTyDxK1OHHEA2BfYK9KvMk4Qnbs4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(83380400001)(107886003)(1076003)(2616005)(336012)(426003)(26005)(16526019)(47076005)(36860700001)(54906003)(70206006)(70586007)(316002)(6916009)(8936002)(8676002)(4326008)(41300700001)(5660300002)(2906002)(478600001)(82740400003)(36756003)(356005)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:07:24.8808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f305463-e31f-43b0-8c27-08dbc8af8933
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for flush VXLAN FDB entries by nexthop ID.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8214db56989d..ec7147409d99 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3029,6 +3029,7 @@ struct vxlan_fdb_flush_desc {
 	unsigned long                   flags;
 	unsigned long			flags_mask;
 	__be32				src_vni;
+	u32				nhid;
 };
 
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
@@ -3037,6 +3038,13 @@ static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
 	return is_zero_ether_addr(f->eth_addr) && f->vni == vxlan->cfg.vni;
 }
 
+static bool vxlan_fdb_nhid_matches(const struct vxlan_fdb *f, u32 nhid)
+{
+	struct nexthop *nh = rtnl_dereference(f->nh);
+
+	return nh && nh->id == nhid;
+}
+
 static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 				    const struct vxlan_dev *vxlan,
 				    const struct vxlan_fdb_flush_desc *desc)
@@ -3053,6 +3061,9 @@ static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 	if (desc->src_vni && f->vni != desc->src_vni)
 		return false;
 
+	if (desc->nhid && !vxlan_fdb_nhid_matches(f, desc->nhid))
+		return false;
+
 	return true;
 }
 
@@ -3081,6 +3092,7 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 
 static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
 	[NDA_SRC_VNI]   = { .type = NLA_U32 },
+	[NDA_NH_ID]	= { .type = NLA_U32 },
 	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
 	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
@@ -3128,6 +3140,9 @@ static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	if (tb[NDA_SRC_VNI])
 		desc.src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
 
+	if (tb[NDA_NH_ID])
+		desc.nhid = nla_get_u32(tb[NDA_NH_ID]);
+
 	vxlan_flush(vxlan, &desc);
 
 	return 0;
-- 
2.40.1

