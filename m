Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2047BD80A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbjJIKHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346105AbjJIKHL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:07:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00CB10A;
        Mon,  9 Oct 2023 03:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T37hcsWW/PzXvn+GtK0ESJzy4u0jmIrQs5B3yaLHWUVrttr16sigFPBG7qBlmbaB2pv0Ygy4XH6lcwlIfQj7fonRGibxbxkkdOcajDbvkFo441yPWOIGaqMc9azi3GqTTagW9/nwSNh1BiWevs2iKxtDZT58ltt2mgXkgEsWRyUDfX2BnNCTGZ7HpZsIUkVgrqx3rp5qK0h56HXuihkJKaL6L0eYMweh3EcLSrjOFVYd8lMbmkEZ35AG6rb1Cop0zxkwOvgNmNKSR/O73Udt2JqaoYyg+DZjMfky5EteQ9AW0kEu94J2hW+hYmH2gjywTm4FBY3z4kMHAvWVo0h16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rtfrZsIGrxrPNKj1deBXKst1E6NF8TioHabpf5xoyM=;
 b=MnCE85QDleKbjLv+cZHFUpSsq5tVOrwq1526qlxbhNAcBRqbHmXFl/dIF+/3bvv8o4gKubncA1qZ86+8Tbq/K+ObAHbcd6dwBF8IURtQuMZVq7o59RcMRXSe9gMCjQQtQ0P8sbKudqpV/+c2vtR1Pr4pBg7B30M4LMRd3a6V4NU714Z30RVJlQpF+4+lSAeN0bOEzt1mX3PcKJsxopVviWOYqTDkhAb7fS3upkz2DivPtXX3kWUUTPgML6zB1FzKwrbDeNjwLr8himOs1E7Jgo2SU4Ir1GUQRAe3vNp17SGaFXml43Wxrwzxu+mBfJ9LLm0cvTglTBhYQ2oraGc8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rtfrZsIGrxrPNKj1deBXKst1E6NF8TioHabpf5xoyM=;
 b=i4X5UckGC4YQVoCeBoApEXxli5XLgjlXfirrN+TmPkxE0Nf34pIYrPHHNZ6K9WzgAsGPshL1KpShG5k8h2P7LXP5/9h/ESHpVUM0uoW6OU+kR7+A38Hdec0vD5j4Yy4j4BwKM/gDyTn3X3gzwDqsmAiYSjtGNV49sNlqONQaEETL0daQjnMZediUBeWdWU3t9VogFGjV+Qqioy46if9klrzP4UkZwHbUUEI9x48ZWnwSaHS9+ZylmkmiY8qowSDOQNaP6AOVI1mNqA2F4ABZtnO3WF9RhSIDKADqKFJuClLY94j6h6sbb2LAVGQGUtFPnBiPnWg86WovksOeiAZTlQ==
Received: from DS7PR06CA0011.namprd06.prod.outlook.com (2603:10b6:8:2a::6) by
 DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Mon, 9 Oct 2023 10:07:05 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::6c) by DS7PR06CA0011.outlook.office365.com
 (2603:10b6:8:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 10:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 10:07:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:06:54 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:06:51 -0700
From:   Amit Cohen <amcohen@nvidia.com>
To:     <netdev@vger.kernel.org>
CC:     <mlxsw@nvidia.com>, <idosch@nvidia.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <roopa@nvidia.com>,
        <razor@blackwall.org>, <shuah@kernel.org>, <pabeni@redhat.com>,
        <bridge@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Amit Cohen" <amcohen@nvidia.com>
Subject: [PATCH net-next 01/11] net: Handle bulk delete policy in bridge driver
Date:   Mon, 9 Oct 2023 13:06:08 +0300
Message-ID: <20231009100618.2911374-2-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c406c69-611e-40b5-8b3c-08dbc8af7db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUG1747g34tc4VlyJKsh4+cthpwfZmIomvu9nu0WCgG4csh+BWXK8T89eH/bhq7qDijra80bs1ajrLGv4r/JksREKjWAlg2g9jYX/4NfuLwrvKpilvYTFMRbgCv1tZcPRaDBdp9bGrmzbEI1Evgra2/6o5FKJpO2PN8og5ssTUsGKWQKFR4lT4rGOcSsW8T/9LdA4cPkLiPWALEUFbinVLg8ApRCRaciY96uDt5fDPSXpQl/XznvLWobjzHlGcFjjEfMKZatHKjY1rPYtbgGws2z+k3su8VDHMi3lNucvcFVYHdSc/eG5QJY/iVkmVIGiGhOlkBCo5dADAy00WTxr2B3SV+CjxZV7Suf8MMBtAsoYHWE2UfbXsUnQ2hHrQEXixdP9WgU8THtFORMxLcwqCprUjU+7y9L3T4mezTXyHiWDB9Vlx7g0ndKcmFiZmjRQC3hjD6R/6QQw2cn/urv2cWNlxJtgOsPypmwdSfNhmnebDgElC53LWwGAOxEK+LGwYMupYt7ZijwZjkS3fZphuiP52AmbSyqaTbJNNL4UWaDhRRCaNEpHK9pOx6R3A80w7a3lud4Ehu5W9lP5RIqfc2bmhmfut3zFo6WL/Z5hYe7iGT3qxwiDtpYBLN1EH8GqAOl8ynpOg7iih69trh1itvW+by/g/KplUQlaetkbkzTKg4/5uxt2aLa0/aiQ85h3mytQz25SLSwHey8YQtoyj6muBzGarJIDHwksiWlyV+LYFV2sfczFwvuhKh9Ajvm
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(7636003)(356005)(86362001)(36756003)(40480700001)(2906002)(478600001)(82740400003)(4326008)(5660300002)(8936002)(8676002)(6666004)(41300700001)(83380400001)(2616005)(336012)(1076003)(107886003)(40460700003)(426003)(36860700001)(6916009)(70586007)(70206006)(316002)(54906003)(26005)(47076005)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:07:05.5270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c406c69-611e-40b5-8b3c-08dbc8af7db1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The merge commit 92716869375b ("Merge branch 'br-flush-filtering'")
added support for FDB flushing in bridge driver. The following patches
will extend VXLAN driver to support FDB flushing as well. The netlink
message for bulk delete is shared between the drivers. With the existing
implementation, there is no way to prevent user from flushing with
attributes that are not supported per driver. For example, when VNI will
be added, user will not get an error for flush FDB entries in bridge
with VNI, although this attribute is not relevant for bridge.

As preparation for support of FDB flush in VXLAN driver, move the policy
to be handled in bridge driver, later a new policy for VXLAN will be
added in VXLAN driver. Do not pass 'vid' as part of ndo_fdb_del_bulk(),
as this field is relevant only for bridge.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/linux/netdevice.h |  8 ++------
 net/bridge/br_fdb.c       | 29 ++++++++++++++++++++++++-----
 net/bridge/br_private.h   |  3 +--
 net/core/rtnetlink.c      | 27 ++++++++++-----------------
 4 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e070a4540fba..17b3c0e86bb4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1290,9 +1290,7 @@ struct netdev_net_notifier {
  *		      struct net_device *dev,
  *		      const unsigned char *addr, u16 vid)
  *	Deletes the FDB entry from dev coresponding to addr.
- * int (*ndo_fdb_del_bulk)(struct ndmsg *ndm, struct nlattr *tb[],
- *			   struct net_device *dev,
- *			   u16 vid,
+ * int (*ndo_fdb_del_bulk)(struct nlmsghdr *nlh, struct net_device *dev,
  *			   struct netlink_ext_ack *extack);
  * int (*ndo_fdb_dump)(struct sk_buff *skb, struct netlink_callback *cb,
  *		       struct net_device *dev, struct net_device *filter_dev,
@@ -1567,10 +1565,8 @@ struct net_device_ops {
 					       struct net_device *dev,
 					       const unsigned char *addr,
 					       u16 vid, struct netlink_ext_ack *extack);
-	int			(*ndo_fdb_del_bulk)(struct ndmsg *ndm,
-						    struct nlattr *tb[],
+	int			(*ndo_fdb_del_bulk)(struct nlmsghdr *nlh,
 						    struct net_device *dev,
-						    u16 vid,
 						    struct netlink_ext_ack *extack);
 	int			(*ndo_fdb_dump)(struct sk_buff *skb,
 						struct netlink_callback *cb,
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e69a872bfc1d..a98ad763b368 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -661,14 +661,30 @@ static int __fdb_flush_validate_ifindex(const struct net_bridge *br,
 	return 0;
 }
 
-int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
-		       struct net_device *dev, u16 vid,
+static const struct nla_policy br_fdb_del_bulk_policy[NDA_MAX + 1] = {
+	[NDA_VLAN]	= NLA_POLICY_RANGE(NLA_U16, 1, VLAN_N_VID - 2),
+	[NDA_IFINDEX]	= NLA_POLICY_MIN(NLA_S32, 1),
+	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16 },
+	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
+};
+
+int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 		       struct netlink_ext_ack *extack)
 {
-	u8 ndm_flags = ndm->ndm_flags & ~FDB_FLUSH_IGNORED_NDM_FLAGS;
-	struct net_bridge_fdb_flush_desc desc = { .vlan_id = vid };
+	struct net_bridge_fdb_flush_desc desc = {};
+	struct ndmsg *ndm = nlmsg_data(nlh);
 	struct net_bridge_port *p = NULL;
+	struct nlattr *tb[NDA_MAX + 1];
 	struct net_bridge *br;
+	u8 ndm_flags;
+	int err;
+
+	ndm_flags = ndm->ndm_flags & ~FDB_FLUSH_IGNORED_NDM_FLAGS;
+
+	err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDA_MAX,
+			  br_fdb_del_bulk_policy, extack);
+	if (err)
+		return err;
 
 	if (netif_is_bridge_master(dev)) {
 		br = netdev_priv(dev);
@@ -681,6 +697,9 @@ int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
 		br = p->br;
 	}
 
+	if (tb[NDA_VLAN])
+		desc.vlan_id = nla_get_u16(tb[NDA_VLAN]);
+
 	if (ndm_flags & ~FDB_FLUSH_ALLOWED_NDM_FLAGS) {
 		NL_SET_ERR_MSG(extack, "Unsupported fdb flush ndm flag bits set");
 		return -EINVAL;
@@ -703,7 +722,7 @@ int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
 		desc.flags_mask |= __ndm_flags_to_fdb_flags(ndm_flags_mask);
 	}
 	if (tb[NDA_IFINDEX]) {
-		int err, ifidx = nla_get_s32(tb[NDA_IFINDEX]);
+		int ifidx = nla_get_s32(tb[NDA_IFINDEX]);
 
 		err = __fdb_flush_validate_ifindex(br, ifidx, extack);
 		if (err)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a1f4acfa6994..cbbe35278459 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -847,8 +847,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		  struct net_device *dev, const unsigned char *addr, u16 vid,
 		  struct netlink_ext_ack *extack);
-int br_fdb_delete_bulk(struct ndmsg *ndm, struct nlattr *tb[],
-		       struct net_device *dev, u16 vid,
+int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 		       struct netlink_ext_ack *extack);
 int br_fdb_add(struct ndmsg *nlh, struct nlattr *tb[], struct net_device *dev,
 	       const unsigned char *addr, u16 vid, u16 nlh_flags,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7452a6d190c5..eef7f7788996 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4367,13 +4367,6 @@ int ndo_dflt_fdb_del(struct ndmsg *ndm,
 }
 EXPORT_SYMBOL(ndo_dflt_fdb_del);
 
-static const struct nla_policy fdb_del_bulk_policy[NDA_MAX + 1] = {
-	[NDA_VLAN]	= { .type = NLA_U16 },
-	[NDA_IFINDEX]	= NLA_POLICY_MIN(NLA_S32, 1),
-	[NDA_NDM_STATE_MASK]	= { .type = NLA_U16  },
-	[NDA_NDM_FLAGS_MASK]	= { .type = NLA_U8 },
-};
-
 static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
@@ -4394,8 +4387,10 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
 					     NULL, extack);
 	} else {
-		err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDA_MAX,
-				  fdb_del_bulk_policy, extack);
+		/* For bulk delete, the drivers will parse the message with
+		 * policy.
+		 */
+		err = nlmsg_parse(nlh, sizeof(*ndm), tb, NDA_MAX, NULL, extack);
 	}
 	if (err < 0)
 		return err;
@@ -4418,6 +4413,10 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			return -EINVAL;
 		}
 		addr = nla_data(tb[NDA_LLADDR]);
+
+		err = fdb_vid_parse(tb[NDA_VLAN], &vid, extack);
+		if (err)
+			return err;
 	}
 
 	if (dev->type != ARPHRD_ETHER) {
@@ -4425,10 +4424,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	err = fdb_vid_parse(tb[NDA_VLAN], &vid, extack);
-	if (err)
-		return err;
-
 	err = -EOPNOTSUPP;
 
 	/* Support fdb on master device the net/bridge default case */
@@ -4442,8 +4437,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 				err = ops->ndo_fdb_del(ndm, tb, dev, addr, vid, extack);
 		} else {
 			if (ops->ndo_fdb_del_bulk)
-				err = ops->ndo_fdb_del_bulk(ndm, tb, dev, vid,
-							    extack);
+				err = ops->ndo_fdb_del_bulk(nlh, dev, extack);
 		}
 
 		if (err)
@@ -4464,8 +4458,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			/* in case err was cleared by NTF_MASTER call */
 			err = -EOPNOTSUPP;
 			if (ops->ndo_fdb_del_bulk)
-				err = ops->ndo_fdb_del_bulk(ndm, tb, dev, vid,
-							    extack);
+				err = ops->ndo_fdb_del_bulk(nlh, dev, extack);
 		}
 
 		if (!err) {
-- 
2.40.1

