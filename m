Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F022E7BD813
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346065AbjJIKH3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346060AbjJIKH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:07:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF5CF;
        Mon,  9 Oct 2023 03:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkXS6jkYGiMHxgtY4dpmbY9caToPesRpVHorUaH/S0t9b1zPLtj/3LkwZdET1qd1T3CRdMpiQMgSb+H4udzcKgy8Xe+v9L2/TQ/sJI475jxS3Qewy0D8rvWgDrIHL85db+0brGjzQzacU137W+zz1+ah37erBTqp5B0+LfnWzVlc/RFs53zR4vnTVr5n+6co24mUfJ1I5ad/mx1cRAXFdcSjkmQzN3jYEKmM834SWSJDiiDpLJVoP+fO0WBuMNMVckXUBiQn/lCCgqKIM8jNVsZaT5tPIoryXlxJ1bCG+aV3UCWD1LGvhWP9nUPlg1e9QpriBFiN6aqPf3F/xDwuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt/wU6WZ7GRXHaUbxO4XGUjytCIUM1CTzE/+Q9sHSjs=;
 b=gMaFKdg3pA76oySDD19sn/fIoLHsKABz8NOgB0yWkD7g/X0mlWcROT/Lm6+xdhY6qRCee+rolYt1oeubF5dErIouDQnG0avhfcOBw2YKvGBnmWpT0cru9OEU3SN6sRSt1S2zNZ58I4k/iSc+vk32WYkr/TWdWi73BrJqk9FFQucOQ9qTiwGKQbOIFwxExR1+k+Cy1p1Rvh4yRdkCJm4pERm8aHoDAZceTorFWlW382MFmPytn3xENlH+4wZsbX/V2Jkti2lbdcGbMjcT+OmWvTLO6d+mDI2qSVvOyH8Oc/ng1g6+Q0TueGB/9zX79EaKardsWGo19FMvc7xyS7DR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt/wU6WZ7GRXHaUbxO4XGUjytCIUM1CTzE/+Q9sHSjs=;
 b=rqQ537MTTePZo23+PRGN1cX/bhrswaiLYMG8gJXEZx8MyUZdVVqMYRS7YcH0nPApvh9wFrYYShiQfy1g24LrhXcFfi6+v+mQNzumFwDOJ0+lon/SX/+m6bT98xTmnwyMa/hg2QIdzpZpGIToFx5U41yi3NQR483gwmtDWkWaEKjX0F7UVnFppCIITWOXjS16gsmSeqmkUaYAofGhx0SIhOoR+FxgJDrSDNplsNjCUTWo6ksEVuD/CZHdCmv2hvPGD4W3fK/bqHwCEWvsgXtg+cRVHXLO3WtN6CjBB966ixpRdTkTXf2GNDgLHXX0+ok+CXR/7lJzIvtGmFcDNO2Hhw==
Received: from MWH0EPF00056D13.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:16) by PH7PR12MB7258.namprd12.prod.outlook.com
 (2603:10b6:510:206::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 10:07:21 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2a01:111:f403:f805::) by MWH0EPF00056D13.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.14 via Frontend
 Transport; Mon, 9 Oct 2023 10:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 10:07:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:07:10 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:07:06 -0700
From:   Amit Cohen <amcohen@nvidia.com>
To:     <netdev@vger.kernel.org>
CC:     <mlxsw@nvidia.com>, <idosch@nvidia.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <roopa@nvidia.com>,
        <razor@blackwall.org>, <shuah@kernel.org>, <pabeni@redhat.com>,
        <bridge@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Amit Cohen" <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next 05/11] vxlan: vxlan_core: Support FDB flushing by source VNI
Date:   Mon, 9 Oct 2023 13:06:12 +0300
Message-ID: <20231009100618.2911374-6-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c39c77f-0f3f-4ac3-f7f5-08dbc8af874c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chqF84LtRMbHLNhnXlPCxERigf8pkNiHAoGYyYIUh1GXQ9HmoKgWZK9Wtp1yU41diLvmAWVJQlheWlyrYFCCYz/rUoPa1J540UPa4TosarP9Gsem/jyl/Zf/Enmo+ng9lr1oKDwtFZdL3rHvOrO6+1RmEenIgnSymeLyMC8qLpycJ7+SSqXyHnh+mTwTP1KYMzyCLWQAg8B28H6YfN6ye7Z4fgVLBZ/zh/DM1pMqmk5AGfyWkbipB503oM8P8YDuIosajpnUgiI0OPIwr1k7l5IDHh2UcxchviC9kK2EOZG5n3ete0gQ7bp1LuJe32QnlwBM22WBFpxEZy3nLPQfEKHXk4rjP3JMKtDUt7OLTbwpePbXYYZAWnOFuk4++GdAQq2BS6j2rCFweKslAgwX0wbghd6JX+xm+yI/ct42z4mpl5NwIBgF3XHK91A7iGqCHnYPlYLw8KAzo4j7MnoS+UhtW2y3smc5tVcB67nJCOPUKLA0VVt5sYeyIdJmgjkfQod/MkIk3E1f//HSCLx1fHqN5UECiq/gcVzOAIkSyXlUSdjpa9ySOgdAVqKizmhLSDyWDCDdwi1tfIPnFj6SLwCrUReH4qnGxvBzo7lOGHxSIvZg/+BPzea2vOgUTeXP+Oqr2quiEWJALIrAmiWTNC+HSWyEilz3gKbx3Yh1NdqXP7gQt/qDgosE7A5rewRZDrueLJ5UzJ6m0ga2cFH82J4/I98IkL/vUuFEcCJpCdw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(1076003)(107886003)(2616005)(336012)(426003)(16526019)(26005)(47076005)(36860700001)(316002)(54906003)(70206006)(70586007)(6916009)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6666004)(2906002)(82740400003)(478600001)(36756003)(356005)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:07:21.6763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c39c77f-0f3f-4ac3-f7f5-08dbc8af874c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for flush VXLAN FDB entries by source VNI.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0aeb973e3da7..8214db56989d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3028,6 +3028,7 @@ struct vxlan_fdb_flush_desc {
 	unsigned long			state_mask;
 	unsigned long                   flags;
 	unsigned long			flags_mask;
+	__be32				src_vni;
 };
 
 static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
@@ -3049,6 +3050,9 @@ static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
 	if (desc->ignore_default_entry && vxlan_fdb_is_default_entry(f, vxlan))
 		return false;
 
+	if (desc->src_vni && f->vni != desc->src_vni)
+		return false;
+
 	return true;
 }
 
@@ -3076,6 +3080,7 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 }
 
 static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
+	[NDA_SRC_VNI]   = { .type = NLA_U32 },
 	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
 	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
 };
@@ -3120,6 +3125,9 @@ static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	if (tb[NDA_NDM_FLAGS_MASK])
 		desc.flags_mask = nla_get_u8(tb[NDA_NDM_FLAGS_MASK]);
 
+	if (tb[NDA_SRC_VNI])
+		desc.src_vni = cpu_to_be32(nla_get_u32(tb[NDA_SRC_VNI]));
+
 	vxlan_flush(vxlan, &desc);
 
 	return 0;
-- 
2.40.1

