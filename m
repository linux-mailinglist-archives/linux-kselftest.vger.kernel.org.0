Return-Path: <linux-kselftest+bounces-3150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231C83091F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5721F25EDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BA62111D;
	Wed, 17 Jan 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrOBWr54"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031220DD9;
	Wed, 17 Jan 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503954; cv=fail; b=KCCZPt13tCknEXhNo8gXtQFeHxn8RgnUwfxrHOY0XJwg8uRDxPqv2WWVjcp9mOrM5nabLGHPlQRraMr5ZoQ1AysIs3gD3abAwwlv1RnWaU6DG93jRUQYHWWJ0MjK2G6vCgHYmKzwE8/mhE0F51PPSUYeVlcnVT3oQZB8q2E2s7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503954; c=relaxed/simple;
	bh=GgSwrFtJrTYot7ZpgRCJNi9bnD1HUCv4GzPEo/mcWLg=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=iC+iLKKeNRBoMKQH8obPPw/Pk0MFiyMGCFEXoFmd8I0VfGJ2guj62sI1CSiMcIcMa779+Vx+Cb79Ce26pCCZdMGIIt3cry/OO9c795tu+NJQlFGXOem3B3N19XHdB3X/kd3gDnVvwxVe00v/EBqOcVPKd6ed3SBdvSQXFDw3ilI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hrOBWr54; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9CxKDeOrX5ETt3FBPS7tx2J9Pp9/T9jGGo4hTJJxUROZreD1xIxMH7u3R70miRgUoi+zEM37s3SDp8buiF/Of8mK/2YtbZQnRxvHoc4VDTiHGPxofuK3juMKjH6vgpVYQPbcl9gMJd47dCoqzFLN7xd7ooUE1eSC3CsmxqSlF/UCKzNCm0wpLsLtBPbvm0g5ZlWOG8YHbPUiydhMmLzas8nS0UjHTQc7fHhY2AaZT509H7WqKGy6g6bNcdkyBIJZkiPV/oEJCcM6+tenXJIvXs6OCf++EZ9VgCfn9VwWpzXnXnhgu/5QDi8DRh7MGVecWnL1pwrrtS4+zAhkogsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqQQUfeOr20GLsiO1xqvRI4+QuBU/PlOhiGjUuQi1XM=;
 b=a6sc/YHprUR24qJfedNBG66Dx1n5uz5VbxdiosRYmUh+ECot2BpIHZhWas5f518au+FAD5hjZM73Cyhu1L5dk2agHL6LpI1vj0u5McaBR4LmBT00aRykbGwDkMsTZtWx2IlvAIvAtzC8jC4VVsdQHhmFT6LxZiiyFlKeDxJ4MJcPubbjoBVLA5XvRn6QSIRJRUffy2Vn5s+tU0t6to5P2hat/xNmfTY6mZ7OOGR1UPbDFkUZVB7DvIxCf68L0xfoRfG36g4muVWgFTyn+T9sCtRKlg9EnKWwj8ZW5mw9A3V+NbDR/Gt1/CzeziLItYxqiP/CYfLnR4Sb6fiYnXzEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqQQUfeOr20GLsiO1xqvRI4+QuBU/PlOhiGjUuQi1XM=;
 b=hrOBWr54ejndwc5Xujhy5dJpPCMdfhhQfIlbkhZQAz9S7n0xJ1Qt0X9iy/Lj5gPpeHAeo5YD3GoJEzT+06Cm912LKYuZAyYp48iUATtfI7SRWNScffhXqdchA0QPXfItogLag8TA8JfDx4s8bpcwJPTGsnJ77t1vVAHHz96zpxCCy3x5A1jT0011znLnUNZwl6AwMM9+AtlIyQLNVlwdmQ5AjUJn0Rg+OVV1AG4VWivUgaLYjibs+KCjogBa5uPUQXPromFE5HOBQ7zgKp+RR2Z7EytckunIaOqeZmXfs/YAETgeTXLk7KatO8TZOynOxxP2cu0VvfjGMbERLslQPw==
Received: from BYAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:a02:a8::42)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 15:05:50 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::71) by BYAPR03CA0029.outlook.office365.com
 (2603:10b6:a02:a8::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 15:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 15:05:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 07:05:20 -0800
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 07:05:16 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	"Jiri Pirko" <jiri@resnulli.us>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net 6/6] selftests: mlxsw: qos_pfc: Adjust the test to support 8 lanes
Date: Wed, 17 Jan 2024 16:04:21 +0100
Message-ID: <23ff11b7dff031eb04a41c0f5254a2b636cd8ebb.1705502064.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705502064.git.petrm@nvidia.com>
References: <cover.1705502064.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5f2255-c4fd-4c49-fb61-08dc176dca9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c0Zw7pOqNkOBZrqqEGh/L9Ts9ZyHfUgfPB0+ck5JrEH2RGi8D6DWlNSH3bV7qc+9u/8V3MErL1obWBKWjU5tDgPWwJsl4smz1lT2I8ZiB5cT3XuGwUBGkYi2m5N2u2KcS4y5kcmCWB7b4pKCYIm07htM7Vn2AzLhkfi3ADrJT+Zkn+GN9LzzBMRAjha/s4KI4hgSgq1IVZvVqgw2ZSzDfRSVVHLdUShTGj5AfRFK52FWzIz+SYf7LB62YgoitplHrN1ocuUNH51r3577fp7Y4H4jmwYBchT2WAayTHPQ2/zudCcOqh1YNvkzfBK9urG0Zu7U8J5ArSuydCt59KsQfBXibU4HHvMwpitkPXYK/ZvaQUYl02zlVd7yrlD2Eeii8XWger4qktlr4DcndCX2ZrQxZh6QJ10Bq94nJhm73zFaWskpTw8QAGDY9AF0p+SAIdrtIEvPGuTjcTCDhFq8F4INGtOVBu6celnC1MMSNSc+E/bFzEoIVATQxfARwLvZXx5Ra7Wi8IymLDcnu5Gs6avMHQ0epSJTVljfoRv2tV7HnnncklHrPymnvoLK5SX6jydaml+WV62B0X1rg1ZSiO/hCwCLz2Q0647cfcYugw5P469Ti2qjj+LqRRp6CIDNI2VCGW8vThfNY7dMLq88wNxiRuOaMygiKLCiy1j4lRwNDYDzWImgnQ5GbX3edCYMYSyl3ologVm9RNBP/QAQqLPth4THpu9clwYfCfFcOsmDVeTT12cG0y6GHocV6QhB
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(7696005)(6666004)(16526019)(426003)(356005)(336012)(26005)(5660300002)(83380400001)(4326008)(8936002)(41300700001)(47076005)(8676002)(110136005)(54906003)(70586007)(478600001)(316002)(2906002)(70206006)(7636003)(36756003)(82740400003)(86362001)(36860700001)(2616005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:05:49.6455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5f2255-c4fd-4c49-fb61-08dc176dca9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

From: Amit Cohen <amcohen@nvidia.com>

'qos_pfc' test checks PFC behavior. The idea is to limit the traffic
using a shaper somewhere in the flow of the packets. In this area, the
buffer is smaller than the buffer at the beginning of the flow, so it fills
up until there is no more space left. The test configures there PFC
which is supposed to notice that the headroom is filling up and send PFC
Xoff to indicate the transmitter to stop sending traffic for the priorities
sharing this PG.

The Xon/Xoff threshold is auto-configured and always equal to
2*(MTU rounded up to cell size). Even after sending the PFC Xoff packet,
traffic will keep arriving until the transmitter receives and processes
the PFC packet. This amount of traffic is known as the PFC delay allowance.

Currently the buffer for the delay traffic is configured as 100KB. The
MTU in the test is 10KB, therefore the threshold for Xoff is about 20KB.
This allows 80KB extra to be stored in this buffer.

8-lane ports use two buffers among which the configured buffer is split,
the Xoff threshold then applies to each buffer in parallel.

The test does not take into account the behavior of 8-lane ports, when the
ports are configured to 400Gbps with 8 lanes or 800Gbps with 8 lanes,
packets are dropped and the test fails.

Check if the relevant ports use 8 lanes, in such case double the size of
the buffer, as the headroom is split half-half.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Fixes: bfa804784e32 ("selftests: mlxsw: Add a PFC test")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/qos_pfc.sh     | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh
index 49bef76083b8..0f0f4f05807c 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh
@@ -119,6 +119,9 @@ h2_destroy()
 
 switch_create()
 {
+	local lanes_swp4
+	local pg1_size
+
 	# pools
 	# -----
 
@@ -228,7 +231,20 @@ switch_create()
 	dcb pfc set dev $swp4 prio-pfc all:off 1:on
 	# PG0 will get autoconfigured to Xoff, give PG1 arbitrarily 100K, which
 	# is (-2*MTU) about 80K of delay provision.
-	dcb buffer set dev $swp4 buffer-size all:0 1:$_100KB
+	pg1_size=$_100KB
+
+	setup_wait_dev_with_timeout $swp4
+
+	lanes_swp4=$(ethtool $swp4 | grep 'Lanes:')
+	lanes_swp4=${lanes_swp4#*"Lanes: "}
+
+	# 8-lane ports use two buffers among which the configured buffer
+	# is split, so double the size to get twice (20K + 80K).
+	if [[ $lanes_swp4 -eq 8 ]]; then
+		pg1_size=$((pg1_size * 2))
+	fi
+
+	dcb buffer set dev $swp4 buffer-size all:0 1:$pg1_size
 
 	# bridges
 	# -------
-- 
2.42.0


