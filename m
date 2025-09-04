Return-Path: <linux-kselftest+bounces-40794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3897B443FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 19:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269257BE33B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDF3090E2;
	Thu,  4 Sep 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mTYPIh6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5830BF63;
	Thu,  4 Sep 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005785; cv=fail; b=OkLuoZCNrf3MFxdTcvZrT9EUH7+pfF2RZz4/1uPOZCW5hONmsnNK++LywIziGsqzDwVjTilfA5HVYd3yenO7h0Ny+Yd1l1Q/x+DsE2aTXaTA+AbxFvePf1XDidPk2gP0iQOJifyMvyGZ6Lbka9KI5u+fR1EH7S/YaYDpPBirDvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005785; c=relaxed/simple;
	bh=+gHUbo0VUnGGs3KYaOnC4CLEFAEig4vR+9EVDwvxTEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eR3u5hRlAMY0wkFzxdZdbRjDhTByfY9dlewPwG/tz0NN7YoIzOdVk9jkIzehupiDOYBvjdJwdaqaAKipQ0di55RDalQW3uhwRP242glL3klZTVTcW3dJgqxtosL9BodXqTbf0DU4l2uGkss6RgkQQH6g5qJLx9aS9D6e6WfuFxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mTYPIh6+; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPiHuR4Qa5PCMxm0jOWOYWJk7HnyArzn2bfpjs13kD+mBwhZ7FowCEcjoih9M7yL7JKjda7c0i4u5OPf9yP4dYyV7oEb3MtRZzB3qMBwQndE/XQqwEBl9+dlBpDOeRb0oiTsBWrKfWUMVyRnBSGHQumzo0H85ImzRueG7mOvDG8pOhu2zZ4Ec14xrONLjwPQuRFbpICVNxahznJOiCJHzh5uFyM3xl0xriPzbn63bJ7HCMR7slAgFE4lcDNNwzNi4KrhTiFAPn/EOYrEDX7ynch8q6/av3yrulvnIAl48GpschhMT0Nkvx7vyg3G5j4HF+UNv6pXT7HGalfXk4jv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVKpY5wY6aLioPrWbQDHa39GXrjSkBTuqM0SHlnhlJY=;
 b=s6/sHwri1WNXyvPuAJy/JZOWopZK6qpXNiT6PI5KvzlmG0GC8l2hdsqTgRAQI9n7bJaHZDlCZHe4QmeBJI4CbxgykzE5u+zKf1SpwtXAizY8/Vti4UFkI9GpF2mkGkhxeehCKVhzte0/Fl2v5J+d8cnLOXOXYELdX+qWdI0JOqC5j7MasvH+VluPy9Xn8W7NVPk9NBQQ8TsgOlydDN1lInbOJrHiGJF5dx58AspZeubSCxAi5hDPujG6OZfiBOR1cZoLR3sBe8YEvKzqgVgmUK/NQkVo5vx+O5zvmMsRc5EULX+emgCu+oHkZ6kQwpSu2e/uZ4b8Bdw3sI1GyDA7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVKpY5wY6aLioPrWbQDHa39GXrjSkBTuqM0SHlnhlJY=;
 b=mTYPIh6++EGtIr+hibNyDgGfzF36qd7uji1E3y9AO/um8DfSBhR4x3beQVLQIGHSEbrsKJplPYeWPs3dYu97LMoKyKz+eODH9gkouCAbvU19+mMSXvNwF4pqroILJMTGlgnMfFboyggEYNkJyPu8dPCw41GoHiAS5zYPN21mB55UrOoODnuWiB+tmYhEh/CZbe9SPQ5L9f3YM1nAB5q7pgsof0JCJD8JvnNppIKvpqqDwVHBGRH/mEhImx1ubLGSvHLjqhbgoZnmEv9/sNFp6dW8jXFSw3McJg4kByg65p7jRNp8J3ayPQPJmhBS+TVVMEyvJI8h+VU64ILZpbz+Tw==
Received: from CH2PR14CA0036.namprd14.prod.outlook.com (2603:10b6:610:56::16)
 by IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 17:09:40 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::6f) by CH2PR14CA0036.outlook.office365.com
 (2603:10b6:610:56::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 17:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:09:22 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:09:16 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 07/10] selftests: defer: Allow spaces in arguments of deferred commands
Date: Thu, 4 Sep 2025 19:07:24 +0200
Message-ID: <6c2523139a6f99103889c9c9fedcdc66a75441f4.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: 90926ac6-8814-4f3f-4ca4-08ddebd5d5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FlNhh0IXC9IFctv3rQZ4IaIUgdTWWkuDmt3CtGm85jy03w2xXtLjUcy9Vuq0?=
 =?us-ascii?Q?VZ3YKYhk5bAe5fu0yCxA+LQx6A54uzsSUMkZEwuiEuWr73vjfUBGrA7yyjdH?=
 =?us-ascii?Q?pbKnIyjBkRrdZCjIA2C+yf6J3vrq1GRqOB+O1Ke0K6l3yeT6R9lcPFd8AhGx?=
 =?us-ascii?Q?QCrnPRUnhNVCt44eh8Vwnr2/peRGrywVvDQadZA7b8FXSZ6ExRhmHoBU6xPj?=
 =?us-ascii?Q?4obhWtI/GUxd1z3BlHSoiLK3ogJTBWCTuFqVa2rk1jXwJ4XfaaZyhbjTNZrj?=
 =?us-ascii?Q?7ERrsy4OvJ0jer8hADtjoIWzjVqK65TSpyabBNhdlKs7OM2e+QoNT5sthrSl?=
 =?us-ascii?Q?h+RXzVKyZPJ+Q4lQJOEvDwqNxHdIoKmJUlmhBpalFjjbuqHM2qWiqxLzosfL?=
 =?us-ascii?Q?VFVYxeBujOjya6MeNede7UpJTlLtCOj0tu86a/GUK2tDumPmXmjwU44bVZem?=
 =?us-ascii?Q?H6/SwirRLqyFXnQw4nojpSFFv5dyZvLJFDl00PahGsZVMoL1Bz2YuCR28eUz?=
 =?us-ascii?Q?Owy128mvTYg/6e4pPFZ1mptpvZ3FDKuVzuOCNjdq7L0z2MKpLHizsicny4ap?=
 =?us-ascii?Q?3Yode2iv9qii/SWsGYE6B3QvitwkdztJY+ut+IXvP7W9nH8LVNdpjQgRc8Ce?=
 =?us-ascii?Q?hNOcyevl007Npgd5Vykc5FyYyngEyroBE5QYs8jm47NaIwa+T3ijQtFw0PIm?=
 =?us-ascii?Q?JSvXnNTt1ygasDf6o/PNFQ8jDw5m+gPUI42hgl8cS8VN5NEEYiMcV3glhCtJ?=
 =?us-ascii?Q?2772RnrR/WKU+36VZqtj5O0/G3U9rn7UvkRKwRte2BVDIkYV589HDdX05s5Z?=
 =?us-ascii?Q?wE4vCavDc1/SeUVUa6ReZJMcOOfVP2MbuYwScTOZAVTPnC4hKbr3Wwyxu8No?=
 =?us-ascii?Q?Z1Pz4EqwWdK5AfkQYDB2B18rLwALOSRLDT11LydEmWXJw3/CoTxiB4N1GzzE?=
 =?us-ascii?Q?K/Jtj6pwIwyrJ3e8aqY95/WsV+dx07aAy55b98CCr6Lj0KePmnBhAusUemE5?=
 =?us-ascii?Q?Wu9gPptwCcrtJugb5qc4/oGyjFOmjgXiS5KXDbNX34Qs0LJzhhfd6Y3A+SyN?=
 =?us-ascii?Q?xk4KpMboj+7csupyUGSb+RUorlpc/pgdpN/my0gY9bs6E2znZf01Unn+U08v?=
 =?us-ascii?Q?SOBgmC8bUrpkTU1LqZrCIR98G1SF5yu9Y3rt6TmVjvFV4ZQMeQjEXxBhI0EK?=
 =?us-ascii?Q?SJ61lt1UAQ+YY0LW3qqP6gjroU+FvNjDSlL9Egc23P0AncubcPm4MUmuf/Ze?=
 =?us-ascii?Q?YvTEyZiIs2BqiZ7JUuFOtPsuvPoehM5ks9XYGs2rh3VobFEgk9VpGV03IMgV?=
 =?us-ascii?Q?n6YM9LszKT/WcBRSkKeS9v+4FMtlQ8tiL6l+QJDbTfif+SZ3PJmq4Y/RAGWA?=
 =?us-ascii?Q?FlfWu2AFPgg8ktPOha3Qg1eW9/uv2ZzCNqRCwepb9xlAYBNKkV8dp4eiD1yZ?=
 =?us-ascii?Q?KPscvHiVdeN1j4l97WKc7HPYBsP/fg/iiStWNtU+Ro+TlrRByuSqXZCtiv8S?=
 =?us-ascii?Q?zLOo+8cJwzkSrj6VwowzS3oqVAgdXwMi6W7z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:40.2873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90926ac6-8814-4f3f-4ca4-08ddebd5d5d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497

Currently the way deferred commands are stored and invoked causes any
whitespace to act as an argument separator when the command is executed.
To make it possible to use spaces in deferred commands, store the commands
quoted, and then eval the string prior to execution.

Fixes: a6e263f125cd ("selftests: net: lib: Introduce deferred commands")
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/lib/sh/defer.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/sh/defer.sh b/tools/testing/selftests/net/lib/sh/defer.sh
index 082f5d38321b..6c642f3d0ced 100644
--- a/tools/testing/selftests/net/lib/sh/defer.sh
+++ b/tools/testing/selftests/net/lib/sh/defer.sh
@@ -39,7 +39,7 @@ __defer__run()
 	local defer_ix=$1; shift
 	local defer_key=$(__defer__defer_key $track $defer_ix)
 
-	${__DEFER__JOBS[$defer_key]}
+	eval ${__DEFER__JOBS[$defer_key]}
 	unset __DEFER__JOBS[$defer_key]
 }
 
@@ -49,7 +49,7 @@ __defer__schedule()
 	local ndefers=$(__defer__ndefers $track)
 	local ndefers_key=$(__defer__ndefer_key $track)
 	local defer_key=$(__defer__defer_key $track $ndefers)
-	local defer="$@"
+	local defer="${@@Q}"
 
 	__DEFER__JOBS[$defer_key]="$defer"
 	__DEFER__NJOBS[$ndefers_key]=$((ndefers + 1))
-- 
2.49.0


