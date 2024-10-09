Return-Path: <linux-kselftest+bounces-19340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B539E99699A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EA81C23A12
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39892192D68;
	Wed,  9 Oct 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBaYf1FN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20C192B95;
	Wed,  9 Oct 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475789; cv=fail; b=VBBpYgfN0/B1UwJkGIjRTFDPsRil08Ld9sgBBFxYElAvZVN01DTkvjsKfq/RVX+zGKVh1npPxfktZATIdg3bFWriN5Vyu2Du1nf2UPtG0sCRMX+Y9gCdz8aqZfIuQz/ZVhT8LcgZ/WF/y03y0JhY6hQG/WCNCxo411o4+NCCi74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475789; c=relaxed/simple;
	bh=Wj8/eDIkFKqrizBwAIL+rGQ4mBwhFSnEvLRXdt6sRuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZBNwSKtL1+W7fU6QJksv7t+n2mabe81sLCZEINKPQJ3NXlqlJvQkWEL7V/YANQDHFE8jWb7W2vKWky4WWZNBL97xH4D9t6nHXGPVfhXe9k/kqCco2awEgtLxxrP8XT9FxDNK9hOQ9aOKWovD8481ZBXfEtK/AyziyJ+1F8YoMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LBaYf1FN; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoAMvym0n3hTCj1RLRhYQwr5rzTF3ttG3P/pApMxlbO0B2I8G45gcaDjxfj7qsRiRFFNcA+MyVloR9IemW33uB+Rk5tMW1fnDqj+bF6qqRAWwW0fFhRBlDmOUbcPbNf/0LiN2q1vq906cp1q9rA2YiFln7GWeaeLTyUxP8e1Qs70mFuTl1OSOj/f13vb0YlnszpK4lsg3HB/Qfx96w8SJjjbNX80D9EHiAGjjUbtgVGdh3oJCMTFL5Rl1JNZy8F56al46y0O7FNGd8+sLNXcBGQG2WPz78nZ6lgnKuq1axrLOCRBr6qZO+RMWsWQVxsN04EyjgxyeseH5EF97OA0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VCQkaVJVw+WAjtwSfv9f7bEjAIvy3jeYEnEyvsHA9E=;
 b=loXxz2/b5N+izNBUxzUrl/c7RvBtF4rYcGdJUjV3BaQ6buzi+MRtEeSuNNHOx7Z60oNcKTAmhJyjnj5ACByfuUj/9xMZ4uqFuhoNCBJCW3t4mkeBk3VVsDQm+TQdhD6r7Nl23Apd0okQX/GhC93dyZjprXHVFJdDuTLmM77wzK7TEH/l2XFYW22is1spuCFpwYjV3d+e04BdENNk7dkCJKae/oyrTuyQuRmOZLYactBcggfp1Ilu+lM/GFe8iVYP+Sog96gEva0djzDfTt6bz4JjEqHWIjFkCKoXCZrTlfU+oOyvpZCjOyQVz4VsiLVLoJAXNCQ1Ne9Rh684hX33+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VCQkaVJVw+WAjtwSfv9f7bEjAIvy3jeYEnEyvsHA9E=;
 b=LBaYf1FNM30Rzo4Q4KtL6zkujEMCaBW0G++APRXaW6s3fvXaXDrL34msmpoxsZTL8m0MR+yVIUffOGkYtx6vn1adq6nff412RuJvvdWtnL3MfTCt+TvTv7eLoktGE16WtqlI85Gr+QgCyEhIVIVNjlUNRkPL0j4PTzbcC+N6FswQbNgw6gUGw6WYlKjaxBvygR1ObDhgI+G0FJBZCHR9USErlNzKtsiak4AZLo5cfDJjTCOWV6iYSFeI4e+dl7Vp6IxG5xRGA6xqRm9ykRZdjTNMYkKLkyzB7enum05Oyw9KNpbQoyPdNg59hJBSVlipOPEJGGEs32diO7P7D2AxyA==
Received: from CH0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:610:e5::21)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 12:09:42 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::e0) by CH0PR03CA0256.outlook.office365.com
 (2603:10b6:610:e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 12:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:09:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:30 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:24 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 02/10] selftests: forwarding: Add a fallback cleanup()
Date: Wed, 9 Oct 2024 14:06:20 +0200
Message-ID: <c13556038e69e20edf0342a926c984ee3d50402b.1728473602.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728473602.git.petrm@nvidia.com>
References: <cover.1728473602.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: ac27af0b-c884-4263-dbf6-08dce85b4157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kf5dj8iCCcYv/QCyzUvlb7sJLzUSm3RixSl02a6G3Qhi1P1mMBJRit61+rdV?=
 =?us-ascii?Q?PdvY8VJR1Ig4DEh6HdbvYFyO7M1aZYI2tkfGQlsLY1NgEViz+hanEk34RvxO?=
 =?us-ascii?Q?bRaQ/00f+UIIuf9nmU19HNJGDgYWJ3yIed7A7fbPdwhPDDwP4yRjaZzvSMyJ?=
 =?us-ascii?Q?6sioa7Elfh9/ZxHD1QXw9jFfLvXpLzb65UUIglaGDLHcgtSR+qzcg8emvX+x?=
 =?us-ascii?Q?hYFNMr+w+JSCTd6MGc4j9XtqZ6k3K9dVTzKvGYsdAAdF4y+qJQTdl/g49G+5?=
 =?us-ascii?Q?ma51dcmnSf/OTmMsurwem4Ggf1Q3AICjnkyaAyggJYOdTImCisF/rWLwH/3B?=
 =?us-ascii?Q?rWn0BMO1c6mDjtfTpn9m0c/dqFBE1oQ3o6cwx7TBsrlcEJOaGBijb4+pox84?=
 =?us-ascii?Q?dGTS4IK6UFsbJkWwMLn6gDVzyYKnIXMoJr/4LjQSvg6mMWXmL1WdyOGVbGd6?=
 =?us-ascii?Q?2oGzNkf6XqIg/QvPhNyqADyBIrZZTg+2miOpbHyvgbznLw7Od0bDeTmRxcyx?=
 =?us-ascii?Q?GHJg7ak4tGouXakaPGOVAE5PAPXti143/grT2MXzM5hS9l7ysVVkbOxBteA3?=
 =?us-ascii?Q?OLjdiKwTQ+1uBE2OB21WG1hdppSUtsA+saqh8lDb49GITUQMjS5HYTqksE7R?=
 =?us-ascii?Q?TOWz+NeJwcwavq5qkXwv5bDh3AlCuQ0uQEgp+ji+Q4RacnOziMA+acILIIxn?=
 =?us-ascii?Q?LD9YZRxYz9aT6gEHO3OCdt9++zl/89gMavEBjfQ+hUybPmCaCyJO9lvug/sa?=
 =?us-ascii?Q?H01QrdTfWrNPAOxz6W0GwWoe9134jd2DjpSN2mR5zstUvwfLu3+d4LyC4zgu?=
 =?us-ascii?Q?/H6YVg0kkpvLMw2d4SAaFZW06WT7g8x0SfBfSQCqUb5OZAHzAR14C0zMIDqL?=
 =?us-ascii?Q?7lNRCz6NVldZ3nNeKayZ8lZo4Bmzvhsfo2OQeodw1V8vaKMlsdNbYfpbVxVs?=
 =?us-ascii?Q?QTI3Wrx0marogHBblmIT9qBdhY1pnrB6XtqxIppPa+t7pd3KFuctqHIm6Ien?=
 =?us-ascii?Q?YxcPSsPmdAeNUY+e7StCTK7Vlb/V4XHDlpMjnvuFXaym0JYFr4LtCpqO1IYb?=
 =?us-ascii?Q?ygFPWBZ4/BpLzgNKMXWywlD7Q0jN72t6siqLzuVzA+6E4iTp1H1HETFuW+2z?=
 =?us-ascii?Q?Zym5YGV41UN7ACGQZENsRqOYLpLr2OfnOoSfsRYpyuWZNMG4z5cM1j0GzHao?=
 =?us-ascii?Q?coAS3EjeBO6w2/uZljyvtYTVwtQKJ8Hn1t3XT/xta6N/nNrdgZwJ73v2lNOY?=
 =?us-ascii?Q?yRAEaf5RYHiTENGL+kc/P3bpR9IGUiKbvN6gJ8GeinpYrpeQWgad8i35EtTd?=
 =?us-ascii?Q?GAUOgEz2IGlXZmC4fT5+ZhHHkhiY+E7ConIIFxjrcEozcDMCZpDDOWGH7Isp?=
 =?us-ascii?Q?chGPUG8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:09:41.4305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac27af0b-c884-4263-dbf6-08dce85b4157
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046

Consistent use of defers obviates the need for a separate test-specific
cleanup function -- everything is just taken care of in defers. So in this
patch, introduce a cleanup() helper in the forwarding lib.sh, which calls
just pre_cleanup() and defer_scopes_cleanup(). Selftests are obviously
still free to override the function.

Since pre_cleanup() is too entangled with forwarding-specific minutia, the
function cannot currently be in net/lib.sh.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index d24b6af7ebfa..76e6d7698caf 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1408,6 +1408,12 @@ tests_run()
 	done
 }
 
+cleanup()
+{
+	pre_cleanup
+	defer_scopes_cleanup
+}
+
 multipath_eval()
 {
 	local desc="$1"
-- 
2.45.0


