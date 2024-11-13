Return-Path: <linux-kselftest+bounces-21919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B789C6EDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AC6284082
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C82201001;
	Wed, 13 Nov 2024 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FJAdNuC2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B99200C82;
	Wed, 13 Nov 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500115; cv=fail; b=W4ydxxVOI5bw/bEa+dbE4X82oeO37K/WANyBnjgelw9yLoMQ+i2z6sH48O9H46iKspHSsJXci6dHoHrjp/G9MZc2Hd1sBOrdX0PJDdyg2z4Z7RISoN5ep6UTa0ulZ6kjnnosUuBS7l+ykNoc+1xPyGX+j+WJf/QWDXU3IERzCtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500115; c=relaxed/simple;
	bh=TpoovN4UHPj7yAx6FOh4cHmawX9HwZ/W7T5mretRXec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1z1IsMUFINJmpeWWnUCeNP7vxUh0yS2eipRXouyTtQ1Y7U0MSgeW+nseP0og2iqys0WzR+9DDezsvA+7TMkY3PuMA77iU6FfPd5CDinGRV07Lv3M6Uh6bAvYyLCzcWYRJi5WFCao0+7SXXZ7FMBXgrEG6tw8wSAcmrq3PpgPlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FJAdNuC2; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVd/wDxvYuGYpM2Iv1XwS8HwpYllXAyXdP48TAmjDaZwQ/Wn1kEacjk77jNL0GeAy9wzAHJwljqW5OFmDQdw7AEG7okJnczIcgQgJgqNkJPIn4Cyppfj48plP9ndQDW9HqVXa7CZ5GCxM+CVAbgu+rmF4j3V+tiS+l839J4D9FgjD8sDaCHw88ig5TgTEia2UHJMluBSCdj6vX0SC4ddd50dM+AFXv7s7yWjlicQ1m8ERbMcm5Poocpi4NxqHIXunVmqo6jrP0yefEyZ8HE8ETh9bJtjbtNM/p3dovECF3bb3b/IioRa1IC2TNYjGigHMJW41bRL/qpZ+2tphSUhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exRrZch1YnXkWBCKYEzsFf99k5cEwGMkBlSWs2QbSDI=;
 b=mJfDD7Hz6Lil3uhLGdNfTCXd/WfgaPkmFMEoF+4uWZo8d3NxGmW66ONao0v2E09W2LGbqGObDNS7Dy8zZkkriUEh2Il5AvULY+2Mfrhr103KkzbL6QHr3C8FQAv7lNIb2PYqVuenfHf/dRtvmtWZ2DVPCPO6iCno95xmmu1PMWVuEkq5lBhS/16KoSdOIvl71gXizZj09yoDrmePMRujUVoFfbbeiSSIYn3I9Bdk4Bvt+8GYV8NleILITpDUU8MQ7a00GJZdB7vRbVFHGTDo3+z6JOhFJlreTgGBlRf/HAn8E3MQi9i92t5fA/3uiqbCpHRPdKZ2F0QfPsC4F4y9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exRrZch1YnXkWBCKYEzsFf99k5cEwGMkBlSWs2QbSDI=;
 b=FJAdNuC29F/GO4cCeBPsKc/o3nceoO+bJBBTseSfT2DIPlh58fpvOHqC5dnpVLgcWm5Q3YJITgfApMy/SlHyGGmc6C572kyKzGh9SZoQZ1LQsixA/biFRzvCVXa8eXfJ9P43IYVcYSeun7TDyn6qLHUQQhxS2CFImfAm6skXQTY=
Received: from BL1PR13CA0145.namprd13.prod.outlook.com (2603:10b6:208:2bb::30)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:15:09 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::dd) by BL1PR13CA0145.outlook.office365.com
 (2603:10b6:208:2bb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Wed, 13 Nov 2024 12:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:15:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:15:07 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:15:07 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 06:15:06 -0600
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 5/5] selftest: extend test_rss_context_queue_reconfigure for action addition
Date: Wed, 13 Nov 2024 12:13:13 +0000
Message-ID: <58276b800ab78c0a79c1918046ccae7fe45ba802.1731499022.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1731499021.git.ecree.xilinx@gmail.com>
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2cc6f2-606d-4741-97c5-08dd03dcd0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOfAaDmiUk4aELSPOC+JYNiAb0ouAF+EdeyokcUhtYVz3J5YNbC946W7cGMi?=
 =?us-ascii?Q?9xfxnsONpaBNTbslAJxaBPg1jx13cJ270SFMxBGELURwASyFYK8lK1KA49WC?=
 =?us-ascii?Q?Y/23AT4xuTkPkGSJTD7MYX1xbRN+dycqklxqxdhSmY/SC+75mrrVBli7Nh+W?=
 =?us-ascii?Q?J2Nr2TNMJT6JY4wAVGdwqWMI0E/pWBsGga9CXZ3eXbdqnNYipguZQSC9f9GW?=
 =?us-ascii?Q?7+1GZLRBdLsvRtbqJfVi0uMKoRaQS9egk4vbI8+HOI2j4Q5LuPA1VwB4joQl?=
 =?us-ascii?Q?wGmzo92XuIo7k8aeGNFeoVdo6zd88soe932/pDjYnm0/B/SzP/qXap2PFyrc?=
 =?us-ascii?Q?eym4S8qkN3IgiJVZRnJAL4I37IaeFiyO1FgUdueAvJVZq1eNDTgukgU4XnFs?=
 =?us-ascii?Q?XOgLbc++S+69cRy0r62SK8TbvOLcnmLkv9SVw0jwjZeDCDB93nvXRfV0dUBX?=
 =?us-ascii?Q?4Q5paLJepTeGB6wv05knnvkeVgiArPON9niii6fiOjd6abpCA1aVosRxC8DO?=
 =?us-ascii?Q?BDtYF44TB6aZXZ+OYIfN3M5xvXIjkS6tn+M1rGEgCqR3mSBXj96Pbz17Delk?=
 =?us-ascii?Q?ondWRcmS60tGesVARjT/fgXzy2OKP7uujTdru/pOozWgbz1/jiJVXZfF+U7o?=
 =?us-ascii?Q?pz0xVi2y04AgVTwHJOkc2KfpBrQD506IFyoAqlgNESARmQN6x89DaPWBk/MM?=
 =?us-ascii?Q?i/X5drCxcQBzK1U+KED4pcWDy3sexC70KBhhyh9Nivcv40JREbiZdPuPudxa?=
 =?us-ascii?Q?w+zkQsVaR0iIoOuIyamc9KD1dGUlR9iG5VRuzxZzs9DnniT0SA4kHwN16ZXm?=
 =?us-ascii?Q?LGZWO8yvkBaEDR6upUboi9PKPzZxcSe+V5FHbHjv/HnxB+q3rMkkgfamD7gd?=
 =?us-ascii?Q?AV2R4UQCyu9u8HGbqAuSjq8PiykC70QwJ+gxWLKjWZOLKNK2eDSpYAyVzN6v?=
 =?us-ascii?Q?Ip8+uXhA+ZGeKPwq4/BFiG/63eFn+FgP6Hyo2FyZUWn4v8Fq7pGX56WsxoqZ?=
 =?us-ascii?Q?9wf+j0RMTPwE7WKEHAcEU8BznINGjftUKtLR+3O6l4SuOlrLifTc1J+YrwIS?=
 =?us-ascii?Q?kjo6HoOD9nxW/GQOOXaWXat1WhDxKVNnnGSXfgxIaAf22ixYis74XdMFXk8+?=
 =?us-ascii?Q?WIcm9k1VS1uTBdNJR5DrYjuMRM+TgMiC6eZhf0lQcNqs1fq/msfMm6sh9LOq?=
 =?us-ascii?Q?CzoQVVwRxqqOPWnuYPwTjL6Bk0qF5n+UPbZlKTih9V2KutskCRQKvj3WwKii?=
 =?us-ascii?Q?parLdYm6Zbz1thkXGdpcSNt4k3hV1ISyTMfCcZWHEWb+aMUVZagFLZ40j0Nl?=
 =?us-ascii?Q?rTSeaV/E5euFSQro4kjQ/3lz/m/sAF+30owe3Fx8qeOH33F1fND2pvnoEnkT?=
 =?us-ascii?Q?N5CrLgdo7+fpiS/J57qFdCBKdJy27sMGazctHdPaGVbipH77vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:15:08.5033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2cc6f2-606d-4741-97c5-08dd03dcd0c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177

From: Edward Cree <ecree.xilinx@gmail.com>

The combination of ntuple action (ring_cookie) and RSS context can
 cause an ntuple rule to target a higher queue than appears in any
 RSS indirection table or directly in the ntuple rule, since the two
 numbers are added together.  Verify the logic that prevents reducing
 the queue count in this case.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
I'm not able to run this selftest myself, because sfc doesn't support
ethtool set-channels (-L).  If someone else can verify that it works
on their hardware that would be much appreciated.

 .../selftests/drivers/net/hw/rss_ctx.py       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 8f62dc29bd26..0b49ce7ae678 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -238,6 +238,32 @@ def test_rss_queue_reconfigure(cfg, main_ctx=True):
     else:
         raise Exception(f"Driver didn't prevent us from deactivating a used queue (context {ctx_id})")
 
+    if not main_ctx:
+        ethtool(f"-L {cfg.ifname} combined 4")
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id} action 1"
+        try:
+            # this targets queue 4, which doesn't exist
+            ntuple2 = ethtool_create(cfg, "-N", flow)
+        except CmdExitFailure:
+            pass
+        else:
+            raise Exception(f"Driver didn't prevent us from targeting a nonexistent queue (context {ctx_id})")
+        # change the table to target queues 0 and 2
+        ethtool(f"-X {cfg.ifname} {ctx_ref} weight 1 0 1 0")
+        # ntuple rule therefore targets queues 1 and 3
+        ntuple2 = ethtool_create(cfg, "-N", flow)
+        # should replace existing filter
+        ksft_eq(ntuple, ntuple2)
+        _send_traffic_check(cfg, port, ctx_ref, { 'target': (1, 3),
+                                                  'noise' : (0, 2) })
+        # Setting queue count to 3 should fail, queue 3 is used
+        try:
+            ethtool(f"-L {cfg.ifname} combined 3")
+        except CmdExitFailure:
+            pass
+        else:
+            raise Exception(f"Driver didn't prevent us from deactivating a used queue (context {ctx_id})")
+
 
 def test_rss_resize(cfg):
     """Test resizing of the RSS table.

