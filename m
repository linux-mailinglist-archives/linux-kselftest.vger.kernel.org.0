Return-Path: <linux-kselftest+bounces-32435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D383AA9CC3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 21:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9E6189DE72
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3C1DB546;
	Mon,  5 May 2025 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSZZ+TDy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848BC6DCE1;
	Mon,  5 May 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746474481; cv=fail; b=RDWWqkZBuK3eQoHYG1qk3kQHHKr5txPwJdd7EahBx0orclfE5kWR/WluC23wdWfpD27A9YGIssfCZ7uSo4yBo2QqVaO8BOlYgZ3amhj3veweN2fRnZo7DERQj68GsypqOxMAKUFZ2InqQBXSZJVPa9Fej4qTu2mlEiSArrVKXfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746474481; c=relaxed/simple;
	bh=hwpPbBECLZl0pyzu8hnRQY1oMp5BCcgkbRM7oPc/0Eg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PdMNo9sCpkjHLgkD9uHIXZ8W+ghmZsWkaAOAADWn26sCsn9qA6Sf5/8l5DNqNHqh/LrciaNlval4PihGEtbN/JeW37mrNXD4D1RbqjX4FrERqtN1USe5gl/IyBwNJOCmBpnMOXvaYgo63QNzVrh9ULdWVufd+w7QeTGs3YcKgK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSZZ+TDy; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEfu5tF3LSFaQZGr0UfvJOm8YieMyiMD9a/m/JvSze5glBhzhM8FMcD53OZg1wKNw7c5cjxfyC3bFlVRczdRjPOQfVKYL7hccAEt/x2kwrRIpzarrL7eo/LeIfFCn5d7CuSRSni63/JAidUTYnDqIKSdHhL7TTCCivtC38d2FBrXjwQHlBZwtlSTtcWrLzmyYITfCB+WIYw44S6GiEylSdqSrS7rrqOPgMDTTeEd5oAz7B1qhQHbDdmJ/2uS07YfOUDBEzdJaecnIuZSDbYdQVYroo9flHqxEZ3kTJOCWysHEFpFExuU/4Ajy6edxjrSTfmLfWViCnqWB5cSmcetdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwCvFIwDRTI7zZ/y1JDfwXx3mUASQIpsHj+D6awCQtY=;
 b=mhTyGYbryt8VaZ7Q6qaCdE07LDVDlcRUlchakSULaO3afLaj2Wt5/TuqW9JMaGKl8xpNCTDk6vDzLpDmBJfpfLxg0p/+rYV0/nf9m5WRrmA1Rvl5fnVrfRdZQIo+lEUk8pFE+lQX8FPeD5IxgZa/DD2hPfvuho49uA72Qftq6sCwu4erWEbSNBbZUqOF4XNwDHOaPzB+z/9aOqbGOYtoOYw37PYNcq2u26icg8GfLeur6IV3K8TyAf/J5wPrmFKETDDlBy/kaRcrqd4iLsmoFZVnkXLGCTF2Hefuy5Y4p7b0xrCcVyx1M8IXaBCHMSawyjLYkXXgXldFovW+TSddIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwCvFIwDRTI7zZ/y1JDfwXx3mUASQIpsHj+D6awCQtY=;
 b=kSZZ+TDyffAllUc+RMGCbeZjKivRaLoUoapTAez+oSlc4HS50SulLfa9IRWL9QJSBZmkqAq+VoM8t+72qWr9b8ULL8NZUo+q4LKgLwisvUBlI0X0RAHQ5lUkvpJBeyvqww/JRh/YcoQqGu3frR6vluMoW5mel3bLs4NJ0JjU9UKgUbpRHlMCuEQH/CgsKSN6ESj2La5FbOKuyjSoaLm1lldkjM/Vs3edYD19DiwDeohCqs9Q7otIRePyzSAQQGDUcWAcL4XY9tmeXa4XlzyvbOGvIErFDhTCk5jW/iFlXn8tiooyrSCrcg9N9skAH3e7b4HQpCp5XZgF9qk1mOPSCQ==
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 19:47:56 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::d6) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.17 via Frontend Transport; Mon,
 5 May 2025 19:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 19:47:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 12:47:31 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 12:47:27 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: Stanislav Fomichev <sdf@fomichev.me>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "jiri @ resnulli . us"
	<jiri@resnulli.us>, Saeed Mahameed <saeedm@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net] net: Lock netdevices during dev_shutdown
Date: Mon, 5 May 2025 22:47:13 +0300
Message-ID: <20250505194713.1723399-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 683aeafc-0311-42b8-e835-08dd8c0dbb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NPR9xtulkJEGD++NOMMwXfHAsSfARuY2l8BjpHWJ9EO+9GfGXj3xNP7svonl?=
 =?us-ascii?Q?+/xVs45mC4JOAHuzB3FKdBddSrfL+kd9vTHklgcLrZ+5HfBJuzBfQeC/0Gsr?=
 =?us-ascii?Q?ZGxBwNTdRubmVw6A+2YfHze5W/xpDNgE/3c5Jx1ULv3kO1n+22gcgQupXPUn?=
 =?us-ascii?Q?0vU55SEDcmdsEfVUS7sRSJaVr7KQOWtJUa7A+Ii7PjBaCfwxwOYC8RlaME9S?=
 =?us-ascii?Q?QJ6F6ll/0jKdsdPhXHWfbaUpOlrYJo+0J8jkDL1XvDC71Qk4/nlMJrhbSaXd?=
 =?us-ascii?Q?vmTsCS3CuaDvkKXXuBsRMDcdxjTZCiSOZpSsVZuwsUMWkaeGbmmuKAaa2xTX?=
 =?us-ascii?Q?HeMebLUxEOVy7m0zqx3Uyu94z2VY4mXZbDy4kcgwNqFuLDuKBrpUbIK9Tpcn?=
 =?us-ascii?Q?fkFlCLcfQWMxDWlZgtY4F8J6G90F/afp9oKwSg7M+3CeQwdMX1xJHd7Fg0Xk?=
 =?us-ascii?Q?cPFCJvT+ipXWWMP7lulX0s80+Hij2cl/y6YYt6CfBo6jHOsFt0rnw+93jqOd?=
 =?us-ascii?Q?E//m25ews2x7rmV+GSu3u2ruoqVUTkVZS6Cbgb37xdBBaVA4q77MNmuGTmU4?=
 =?us-ascii?Q?qaY2axQw1r3p/sbTRVld6upurxEo1t0CO5Elytyd4rUgR/VYhknjBMuPpkbG?=
 =?us-ascii?Q?1PSkzgD48Iz2IQj0gjhCcr++/VqSOqNe2eKg+8vwrAvMVRhtQDSQkd76GIvV?=
 =?us-ascii?Q?vp2GqbrraK6EwesfUPgadRH56qEoXDfmOcuFWMZgBEu6EfcZASbdOpVRSfmn?=
 =?us-ascii?Q?93liAVb+lfFLkZEHIjrGZNpsNVxaZOSrcZPfHykzzf5UGIt/XlDUqc0HkVAI?=
 =?us-ascii?Q?oU82A/fbdY9Ke8J6haeFyO1m/oVIUY6xQ8wuhjSEDF935kbOmiT9f85iW2AZ?=
 =?us-ascii?Q?2o6ZQg5aOZKezJ9JhPKBEWmbsIK4bpZe2Y3L6kH7GfQYhXEDJ5A0pO/gCHbD?=
 =?us-ascii?Q?rnsBNlnTqrG/24o0ZEGlOY7I3bKAijxNj4b18hSRbb7FPMFcxZFzsXPDlSNn?=
 =?us-ascii?Q?Le+3YL45rqJfUDRsFvgq+xS+Qz3DsXiXIh2xgCqHGYdLTKZAp1A8D+ARdBNo?=
 =?us-ascii?Q?2W+9Cr4aw1+QGTzXctKqebumFpARwn/iGnUgdSGKUKG+jmZezATPeCY2oMSz?=
 =?us-ascii?Q?N51TnqFbBGkCx/kt7oKnZ2tlVLdSn/vaMG4ZOcTDScR3FBD/WcV9PDCxbZw8?=
 =?us-ascii?Q?yBidzAqeXlGX7Ee9IsqSYy2Zp/NuUtW0rohcmgytzQzHQ5O7cimnqJWsm0Og?=
 =?us-ascii?Q?EaMSftM2SaTVJBUzwNZLBgyhvpVzlgy/gPE7SWmKZlPelArb8xGwgXx4dw9P?=
 =?us-ascii?Q?oVNrQC5yY7u0o3HWy2V3wZhzfltbhkvCHf3ggHVRg+dOKcl1Na/BulZgj66U?=
 =?us-ascii?Q?b80wP+9PKAWvCOni4bLpXZcbN5AxXyGD4Ogv92TARniZginMYqtDe0BEmUeO?=
 =?us-ascii?Q?3KnQkgv/ID+BafKvVYcsHlj2cgFGxhuUVG0RSTPKgYuqUOjMpZLF8XsXeToJ?=
 =?us-ascii?Q?zScf2KM5N29rQLGXTE0ovpf9sdW7G1r1nxOw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 19:47:55.8386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683aeafc-0311-42b8-e835-08dd8c0dbb40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714

__qdisc_destroy() calls into various qdiscs .destroy() op, which in turn
can call .ndo_setup_tc(), which requires the netdev instance lock.

This commit extends the critical section in
unregister_netdevice_many_notify() to cover dev_shutdown() (and
dev_tcx_uninstall() as a side-effect) and acquires the netdev instance
lock in __dev_change_net_namespace() for the other dev_shutdown() call.

This should now guarantee that for all qdisc ops, the netdev instance
lock is held during .ndo_setup_tc().

Fixes: a0527ee2df3f ("net: hold netdev instance lock during qdisc ndo_setup_tc")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1be7cb73a602..92e004c354ea 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11966,9 +11966,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		struct sk_buff *skb = NULL;
 
 		/* Shutdown queueing discipline. */
+		netdev_lock_ops(dev);
 		dev_shutdown(dev);
 		dev_tcx_uninstall(dev);
-		netdev_lock_ops(dev);
 		dev_xdp_uninstall(dev);
 		dev_memory_provider_uninstall(dev);
 		netdev_unlock_ops(dev);
@@ -12161,7 +12161,9 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	synchronize_net();
 
 	/* Shutdown queueing discipline. */
+	netdev_lock_ops(dev);
 	dev_shutdown(dev);
+	netdev_unlock_ops(dev);
 
 	/* Notify protocols, that we are about to destroy
 	 * this device. They should clean all the things.
-- 
2.45.0


