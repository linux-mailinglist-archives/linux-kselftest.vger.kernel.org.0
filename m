Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D97BD80D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbjJIKHV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345822AbjJIKHS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:07:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5469BA;
        Mon,  9 Oct 2023 03:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzH38LDrk6lqGUU2woefVnOqNyu52En96zIGU8O8hf4xnLfikvQIW6kde7pgpIrPxstyetAe4Svx2Q+8NXUw4KQMAcKPyD7/MwVIqLRJTLJmYqFON2ftIJr/eqCBjOKrlwpFV2HE4tEYSh/k8B4XTxZzEVg7rQN+eCsxvXOT4y6rEqHkIwI3bYhgZItV0r06SYnii0MiamFPhhMkOcikU6gOgbq1K6LJ/jpQ84EXyu8HSE1kDzlqgqWG70CLQeNuTlMxAkZnqJfUA/JR+Xrtjwzhh+B8xB1aGP0jcgfWgDS15Nw3zINqN4oyhlYUziIPIqxFtzL6fAlMnroFRTrd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFy74T5CAUfq3WEbbbWoXFN/ggpbuL7yyPD344US7mY=;
 b=b2UewQvNJkIZbf2HuFzsm05GIaKh1QQNvARY2puhzJ2zcM1sXdDxgTUWBY38hDJMnjDxE1Ke1K0ONnz/5oIUIQgTSKMOK0khMtesO4L5i43hgsA4b0qJXDJIYbqZ1e6SUfKK8Zx0ioIZrS7voZF3Vzk+Nzs+Q6V7zLgoiBBZ1i9i/BpptxyRHcL5EkHqU/nFBn17lGzlqMogode6/wA9zgCW/oN+selWL3wr9LdpwTKfn4HJOEIcd2Q1DUXY60EkHVMY5MHm4HIayBXEYLQiXlNaowfvI8cPMnDnJlLz/lN2OGzYXu8Al7Hh8nzkhLWImuGjnF/4snfI4JasZFYOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFy74T5CAUfq3WEbbbWoXFN/ggpbuL7yyPD344US7mY=;
 b=NXTap1T1L7CxVwKxnYm8FCvrW1WHdCVH1AlfsgKtq6JybJH+3FSWYMhNuAElMgBwRM1AihvlnQW+sRcJ+S7CC9U6ZqBOZhw0+B0yinItuqnoUgY3d5RTUEXKFzPVoWbIzqhWxoZ0L1mUIfsOZCOP3hyWzQBHMdiLdoPI/JqPwuQk3xn3MC+K9RV9DsJRuV+mwBKz9gPgLLyWqCMWOszcn9Aq0rpyYYbGRgCHbNu3BXAQpEeUWncKGSA00eKwhgm2pFPe4WWD9aTTf7HGNkvel0ptL96bMMDAw8CgELzm/JkVh3yhXHRHGbWD6oAJiwz/H1oYhntS+RFi4HBLcxEeYQ==
Received: from CH2PR05CA0048.namprd05.prod.outlook.com (2603:10b6:610:38::25)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 10:07:14 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::8d) by CH2PR05CA0048.outlook.office365.com
 (2603:10b6:610:38::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Mon, 9 Oct 2023 10:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 10:07:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:07:02 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:06:58 -0700
From:   Amit Cohen <amcohen@nvidia.com>
To:     <netdev@vger.kernel.org>
CC:     <mlxsw@nvidia.com>, <idosch@nvidia.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <roopa@nvidia.com>,
        <razor@blackwall.org>, <shuah@kernel.org>, <pabeni@redhat.com>,
        <bridge@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Amit Cohen" <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next 03/11] vxlan: vxlan_core: Do not skip default entry in vxlan_flush() by default
Date:   Mon, 9 Oct 2023 13:06:10 +0300
Message-ID: <20231009100618.2911374-4-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: e6cac68c-bdca-4618-d24b-08dbc8af8286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SI78xWJ1t4EW3Mkn7cuV1xzP82ubZHWzIq653nhFD3YnjG4o1slgB2rXKohb2tGV1z5pGjLCkBZRJhb568ZaAfm0bbEwvsyptA63Fua4J60266q9RmPKEX6q48Mz3MqANAEuy5P0eNluHHXU4yDECtSWC8AHslRswAKhZIS9cOYLP5FZUGTvYp9q0hqdhgQu+shuUXkVvtRsPfk+M0wjRu8r8IXoegtaWSsYEa42ucDtTzFJLQ4ewjrV+NVxKRkwwq/+vT+4wEQ+K+BVZ8MHH8W30SOG3g+m846L+ntIM6lrlwh1N0il/Qd8OSLsATngrsWxPoTPnVYMIp5xuNL9+x2yKToWUWzMkG1lGRhAsIuGh7UyiDZzkQJ0svJpn2PCet2kiSaVcCXxF+7PEoJ5TJRdHBxbmIHozpRvwOozxglDB45VrMFCcwZTWsxKfXzTd63f0ozNnkIXu+cddcnFvvcfXNMrJYrHTeKFCUTwytxHorQ6Ptuy9SbAx+nNa/YVU5+pW3agza4PayDaMxhgTFbqWEz44NIb22h9nbar0HQZL41Zsw3oXTOduK/IGC+G9RbL/lG/42I+yXTUK9slBsCwU3/wFWc76xuLib8Y3Eo630VC/aJaUr4U6KWEGkYKvwEkmxh9dBkMoBxeS1D0TByaolq/U6UjimRiZZFIpPXx+BCDxIU/0hmJOpAlDhZ+xIFtQ5IceLmR+cIFUIdlHA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(36840700001)(46966006)(1076003)(2616005)(426003)(16526019)(336012)(26005)(478600001)(36860700001)(47076005)(6666004)(107886003)(83380400001)(8676002)(2906002)(8936002)(4326008)(54906003)(70206006)(70586007)(5660300002)(41300700001)(316002)(6916009)(7636003)(356005)(36756003)(40480700001)(82740400003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:07:13.6825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cac68c-bdca-4618-d24b-08dbc8af8286
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, the function vxlan_flush() does not flush the default FDB entry
(an entry with all_zeros_mac and default VNI), as it is deleted at
vxlan_uninit(). When this function will be used for flushing FDB entries
from user space, it will have to flush also the default entry in case that
other parameters match (e.g., VNI, flags).

Extend 'struct vxlan_fdb_flush_desc' to include an indication whether
the default entry should be flushed or not. The default value (false)
indicates to flush it, adjust all the existing callers to set
'.ignore_default_entry' to true, so the current behavior will not be
changed.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1c58fddb7df4..958960fdc011 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3023,16 +3023,27 @@ static int vxlan_open(struct net_device *dev)
 }
 
 struct vxlan_fdb_flush_desc {
+	bool				ignore_default_entry;
 	unsigned long                   state;
 	unsigned long			state_mask;
 };
 
+static bool vxlan_fdb_is_default_entry(const struct vxlan_fdb *f,
+				       const struct vxlan_dev *vxlan)
+{
+	return is_zero_ether_addr(f->eth_addr) && f->vni == vxlan->cfg.vni;
+}
+
 static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
+				    const struct vxlan_dev *vxlan,
 				    const struct vxlan_fdb_flush_desc *desc)
 {
 	if (desc->state_mask && (f->state & desc->state_mask) != desc->state)
 		return false;
 
+	if (desc->ignore_default_entry && vxlan_fdb_is_default_entry(f, vxlan))
+		return false;
+
 	return true;
 }
 
@@ -3050,13 +3061,9 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 			struct vxlan_fdb *f
 				= container_of(p, struct vxlan_fdb, hlist);
 
-			if (!vxlan_fdb_flush_matches(f, desc))
+			if (!vxlan_fdb_flush_matches(f, vxlan, desc))
 				continue;
 
-			/* the all_zeros_mac entry is deleted at vxlan_uninit */
-			if (is_zero_ether_addr(f->eth_addr) &&
-			    f->vni == vxlan->cfg.vni)
-				continue;
 			vxlan_fdb_destroy(vxlan, f, true, true);
 		}
 		spin_unlock_bh(&vxlan->hash_lock[h]);
@@ -3068,6 +3075,8 @@ static int vxlan_stop(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb_flush_desc desc = {
+		/* Default entry is deleted at vxlan_uninit. */
+		.ignore_default_entry = true,
 		.state = 0,
 		.state_mask = NUD_PERMANENT | NUD_NOARP,
 	};
@@ -4315,7 +4324,10 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb_flush_desc desc = {};
+	struct vxlan_fdb_flush_desc desc = {
+		/* Default entry is deleted at vxlan_uninit. */
+		.ignore_default_entry = true,
+	};
 
 	vxlan_flush(vxlan, &desc);
 
-- 
2.40.1

