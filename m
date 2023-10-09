Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE97BD808
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346035AbjJIKHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346104AbjJIKHL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:07:11 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F40109;
        Mon,  9 Oct 2023 03:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEllMDNGAF8ssNtKfbUZdbZMGt34h8xCB19ly//rfJmPyZxRgwnUdWD256YfN0bx7yw8ApfxQvAJn7pZ7FWFZrKkTwtrfhJgoM4mWp/YGchLeQYTuSnLTUlBXXBH54D/VUoe39b/fk3rgy0b6oiFzowFIAhIZdix4s941whBHZ845UbZrRMZnYdoDMWvI5aCgGr0D5w0JAtQQ3c8TSnZMgKg0FayfApYJFwXKxpzs50OsnN1FrOEMX9Jj7Ga3yIEvSEy65e9bcvOjcXksWgQhHev3K3zharhdCIu74kPM2O9qtbjEfXHniwQ3be2VoLefZzI48TZf0gjat/HtTI9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ath0yXoGX+w26Wh+M+ziarUJMEcVX0Kme1m4YZaKbFc=;
 b=acEHQGaKC9IJOTgVnHFBKxusPqveTrwmG2UEh0T35uzP5IUgrH/F0GJhbIoNViSodv5tU1T1XWXZ1BEG804roUvGPfHvf/Est6Xv14Yo0PTUQmyzP+Mvd3xqqaRXg4GmgydvD1za02bZtcDbkMzfr4bUQSX+fUxvT+xJMzrOXvXwf8Vbuin2050Vgcy4kce8Z6EEgU3zIG4rDl0m05/xx2vRwo1i2auXbo4eR6ejQZ5QI7nQA9ed+mstS46qhYIaH7STcCtZnvD2barcCAu6H/9+l4XIXZJlB2qgwZfBbmPSq39wCcAQLdfuiSvkNXJh9ogqA8yFGbup55EKWqsZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ath0yXoGX+w26Wh+M+ziarUJMEcVX0Kme1m4YZaKbFc=;
 b=gCjyhapyDjpT0yQPWISKKc+wlKbi/a4B9bY8kIGN9R2gTL1Db+7wGEJhHh4SO1xSU7qJybZ0dLrIr5YqVA89FiOZ4+p0UUwgfrj9W5zwDkqZQttHfmFCh/n2ttC2+XNHWtqt3HeBp1KAaByB5FJrKrAuzPwUPVj0fZW+r4OL8MjJ/Idz8BkNH6jIinsDBxS//qZYNDVJe8vnv5cDMNvgYM88E69f7kJilYvJh/U2ATmFoIGfXyuAZZ21Cdo7ZIst7i5SSrMLEf76FwkeoetrW50+weYygoMRirikx4XI9CzLSezT2fLFkzZFAoyJRFon4VKknPmkOqvOPNeiA+UUSg==
Received: from DM6PR07CA0109.namprd07.prod.outlook.com (2603:10b6:5:330::17)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 9 Oct
 2023 10:07:07 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::23) by DM6PR07CA0109.outlook.office365.com
 (2603:10b6:5:330::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 10:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 10:07:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 03:06:58 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 9 Oct 2023 03:06:54 -0700
From:   Amit Cohen <amcohen@nvidia.com>
To:     <netdev@vger.kernel.org>
CC:     <mlxsw@nvidia.com>, <idosch@nvidia.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <roopa@nvidia.com>,
        <razor@blackwall.org>, <shuah@kernel.org>, <pabeni@redhat.com>,
        <bridge@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>,
        "Amit Cohen" <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next 02/11] vxlan: vxlan_core: Make vxlan_flush() more generic for future use
Date:   Mon, 9 Oct 2023 13:06:09 +0300
Message-ID: <20231009100618.2911374-3-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b6ce3b-f2f2-45cb-d127-08dbc8af7edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyFUeD4jDjyqbFEqEhImjmcUDc9KQSjPs+KIZrMdIeU67sPs+RfHoeEk3FXg0qxoPjHHdGtkixnZ8pbxzWDIYoyutsmtn4lzdHrvmt5NvNIwwuH+lqyg/RI6PBoS02mTIJYhtyU6g6lhHHFaHHQf8qFrhYO5trueZe8mXORMXzzuUJTRNh3wmgnNRrUwyqnWW5FFZ3w/s9tTvyIphlHfqXJnOgydfuNNWQ8ms9Di2k71iKh63U9MtWP3dki7B4OagmaAtvvGcCZZy1uK5eieItaLruvQmY90iGN7Qw3OlMtjSuw20RZjHhAeZR8Sr5jvROtSvTCP3OdnHfGFX3XBLGLaDZkeF+7XcRUlkodeDP/BMOCTv+quRXuth0ve3k0F/Qeo6pOwpXIgpB6a0H1/ofsJPsUaNGidKVMxXvTrv11KLrQvk1PXSilNsf25Mie06ygNXXlhcsO4HmgdHluPOc2PPZLitY1sO3duaeLPGmlqxUr5RNRRE5TMqQkAYWlJIOK6KMb41I53zM496rmxvqNJ8Y01Dyf0NFY4RGb3touMqfHsn4WQFvHz54HtYJUuJ3ydwiQQ4zkIKTz+gcRcWcSS3IBaH11F2q/kyBd3I30YCEKu3r1cyFhtNjUktMf1iGDgKvPJFc2yMHRb3slnvbRfJPL9lNelVt9hg35fAZP03co9I3CJWMKvDVEtERejevthltClMUV7GLvPfx6KuS93Uh4F3htTlIyX3Qbn+EtccOr8Vbv8UQoN99Onk3XA1/7aiKXKoeugVqf4TtejXw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(26005)(1076003)(7636003)(2616005)(107886003)(16526019)(336012)(8936002)(54906003)(70206006)(426003)(356005)(316002)(70586007)(6916009)(478600001)(41300700001)(4326008)(6666004)(8676002)(36860700001)(83380400001)(47076005)(82740400003)(36756003)(86362001)(2906002)(5660300002)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:07:07.5080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b6ce3b-f2f2-45cb-d127-08dbc8af7edf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The function vxlan_flush() gets a boolean called 'do_all' and in case
that it is false, it does not flush entries with state 'NUD_PERMANENT'
or 'NUD_NOARP'. The following patches will add support for FDB flush
with parameters from user space. Make the function more generic, so it
can be used later.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5b5597073b00..1c58fddb7df4 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3022,8 +3022,23 @@ static int vxlan_open(struct net_device *dev)
 	return ret;
 }
 
+struct vxlan_fdb_flush_desc {
+	unsigned long                   state;
+	unsigned long			state_mask;
+};
+
+static bool vxlan_fdb_flush_matches(const struct vxlan_fdb *f,
+				    const struct vxlan_fdb_flush_desc *desc)
+{
+	if (desc->state_mask && (f->state & desc->state_mask) != desc->state)
+		return false;
+
+	return true;
+}
+
 /* Purge the forwarding table */
-static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
+static void vxlan_flush(struct vxlan_dev *vxlan,
+			const struct vxlan_fdb_flush_desc *desc)
 {
 	unsigned int h;
 
@@ -3034,8 +3049,10 @@ static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
 		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
 			struct vxlan_fdb *f
 				= container_of(p, struct vxlan_fdb, hlist);
-			if (!do_all && (f->state & (NUD_PERMANENT | NUD_NOARP)))
+
+			if (!vxlan_fdb_flush_matches(f, desc))
 				continue;
+
 			/* the all_zeros_mac entry is deleted at vxlan_uninit */
 			if (is_zero_ether_addr(f->eth_addr) &&
 			    f->vni == vxlan->cfg.vni)
@@ -3050,12 +3067,16 @@ static void vxlan_flush(struct vxlan_dev *vxlan, bool do_all)
 static int vxlan_stop(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb_flush_desc desc = {
+		.state = 0,
+		.state_mask = NUD_PERMANENT | NUD_NOARP,
+	};
 
 	vxlan_multicast_leave(vxlan);
 
 	del_timer_sync(&vxlan->age_timer);
 
-	vxlan_flush(vxlan, false);
+	vxlan_flush(vxlan, &desc);
 	vxlan_sock_release(vxlan);
 
 	return 0;
@@ -4294,8 +4315,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_fdb_flush_desc desc = {};
 
-	vxlan_flush(vxlan, true);
+	vxlan_flush(vxlan, &desc);
 
 	list_del(&vxlan->next);
 	unregister_netdevice_queue(dev, head);
-- 
2.40.1

