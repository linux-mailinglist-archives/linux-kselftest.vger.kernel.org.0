Return-Path: <linux-kselftest+bounces-42402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C289BA0EBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22B64A2A05
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FAF3191A2;
	Thu, 25 Sep 2025 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lVq+qUQ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3A315D52;
	Thu, 25 Sep 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821701; cv=fail; b=VxuWvbHD4+ePBaaKznYU2NODcnrgaD2CdkHLnpQfWJxbu7avvUZCCTWZJa1Ui5WZTPaB3lMQTx7YyRUqn8ZnfhGH6BYXXSLbu7rCY2sbB+AzBemuxA8ENFn2oJoZAgwOVzJM8PK4AcYJ7cN6rwBU8zdMDSMqFQTdxyyiL2kdiuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821701; c=relaxed/simple;
	bh=JIcV5G5k26hEuAVcHtBh9ftvAH5dooxISW4iSjntRbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3lUTPBmxsvGbdep9ymuubAqPN1t5QYnp1WfZWk51Ej85HvqSsNR3gGEam4T36cgCuURcEHMvtMz4sw7t+WJRbGPXnTBPnl4z1iC3FuGyNsImjGBHS1GL+732Yni/ccEMG2YiujIdxUbpwm5FCWqfOviilyGwhwcHQzYohz22Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lVq+qUQ9; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPX+yY2YJWfdaw3A550Clt+9Zy47K4KBrPKQ+aQTr0omYmwKQXqktfDtGaSQr296hYKeYGP+6vY37wSkoLF7i3wgSgOYIQBRSAWFLxypTxirEPf/c/KMlCdKnfsKmxGdhsROlZ/D2WppfGlzYStDJIYgRoJdhAl/xBaH/FTqjHyuXkRf016aDCG4k91b3T4BNS+YV+GuHM9Q+FQtpCEWyDmM/aC7bWO42wi0cqEzT/AnthUiuID1SmfIIMS8FbaiQYuoVhtjKmNCNJJMHGBjiXbuMdCO1vqv42IkHb8mgIFBCvDvBjjlDrlz2shgzOfDPrgfS4CA9AJ0xK3YZWNc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg+v9U8wqvVapdsbsvc4TtESt3ihxxesyRCqXYhHO10=;
 b=QChIwKq7WbNFS//De5pfRVPaLVKApDMSz4v0NSfp6Z1sCM8g1y07m25FAA+t3au24kXBPTcKEs1Sx/bv3N4OJleqYoo8zS9bVClNL5a0GpNCfi4mEXVDL2ndCgLcRQPpW9SoTECd/IMqO0Ots7yLWOIcwRGc+j3pXxRiO+ETBiKTXR4HqLF9oBUr/4k9gxb/p7v5XdpksofqROY5ipGkkTtILNf9XQ8j70KT6azv5OCB5VeBJJpi3fkPLSWUN8F3MVCX5clqUWThEEdJxfiL1tijAhOmZv2QfnjWWNJuWd4l9eJcHQga7/o5PwXTApjlENatl4Bs1qXMcPCHLy7oAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg+v9U8wqvVapdsbsvc4TtESt3ihxxesyRCqXYhHO10=;
 b=lVq+qUQ9IxwLHiXYpW9hPBybJqFDRmoPBlK+zclCo1f4DccxnQkZ4n6gTaoxC5ZBpFYmEPc1RVG8ijADqTlS2wL50grLQ1aExdhLRuO+ydPpXaFAPTP7WXZflNW/vzk55RFWaWGir0mBMbxMg2LiLAw0GhkOJy4ZhXNiKM1AqfgKUFFlyt5EAUUwm1jnAw4HHgValLwbvza+DEQKolTcDGAlAFe5ZB/WZIBmBciq79kOhbne8rR94GnSsrgoj/pjRk5TphImy3QM7Q/owU6Ul44P85lWJZYzmJCuX7u2BJMOkeScoR1xW6L1c2LxgOGWZjCfzTFrZtgkqjXcRheMPw==
Received: from BLAPR03CA0156.namprd03.prod.outlook.com (2603:10b6:208:32f::29)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 17:34:56 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::9f) by BLAPR03CA0156.outlook.office365.com
 (2603:10b6:208:32f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Thu,
 25 Sep 2025 17:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 25 Sep
 2025 10:34:40 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:34:34 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, "KuniyNicolas
 Dichtel" <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next 13/13] selftests: forwarding: README: Mention defer, adf_
Date: Thu, 25 Sep 2025 19:31:56 +0200
Message-ID: <0764bdb9266cd516da23ddeec110e01118cf981e.1758821127.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758821127.git.petrm@nvidia.com>
References: <cover.1758821127.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 19badfaa-15d2-4214-c4df-08ddfc59d803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vNQDKQkAl/D27lWcEcIAfRJHqitUHaoLozb1KG4nZ8GdNI9KfttYRNSlVax?=
 =?us-ascii?Q?yEnRE/oGolwchsLxKmBdwSNrWz0DYQYKq6wugfYltZNjshyxhrMs0bEbIjO5?=
 =?us-ascii?Q?5z+uu5E/X45bJ66GIRhqMiA+9n2rMUTzNllUII0e+oZL7Sb4AATrzlDs/AMm?=
 =?us-ascii?Q?dlgGnkV+l0KMP9J5BOhGA1NBDq78QKPUxeuc1VXTm4g3pqM7xvc1AE2x9jw4?=
 =?us-ascii?Q?ISr2KTBH/U70Ajv11YeCxSWs84ksH0NI4rOsIwfgjkosjO+Ie8r546B3MnP+?=
 =?us-ascii?Q?jL2vB51Ey8dlHhwFL/dZys29Rel9baeoqPmD+OY695hQaKycNGoYlICaIGfl?=
 =?us-ascii?Q?VFlyzCXc2UWo8GraOYBhdPD6ZkjymJpI51DuT1FaUN8j6OwA0OrKfWV+r211?=
 =?us-ascii?Q?5ICnWK4yT5bSgVvncaggJ7Wt8y690Ica6q3BLzSSuMwXZBRZFFovEg7N59fg?=
 =?us-ascii?Q?c83b2s4GlQaHTPVM3qHhGz2RwOhU6QLJbULKRLLeIoRVDu+nRvE+or1PR8hU?=
 =?us-ascii?Q?8vw6M33VeCD1PxNFjGkntnqmYkg4D7VHpUTDrIRJ24a+6emWnG+votcPpeE1?=
 =?us-ascii?Q?aFCrpEtqsEPaj00UUJcRQ156rbMrqqW/hZFtcI0QfNPKNHvKsACWyOaNVjzC?=
 =?us-ascii?Q?Qtl9BKVUPmgf/+EPK/zcAbl0u5W7GyWz9DLwRd2/k2LdWa9A8+Avh9coI2Fu?=
 =?us-ascii?Q?xMlO2jssSj/GmecFjercgixbxmKs69474JmFk/LEQUFDvJry+Q5SOmXfRXiw?=
 =?us-ascii?Q?O36G/x2YW0jKIiaqmE4D3qqCIkFum/b3RNajmsV0ik8O3RmG/wIXnuMAPlvC?=
 =?us-ascii?Q?nQleNC0CLHh4Gjuylq8isGpsnBx0FN+Enh5m4jKOZBKnRVnvlJRc0tRu+BHO?=
 =?us-ascii?Q?RYQyD5x2mCkp5U0bEUBqDkyqCigg4fTVgESmVYa42t338E1FI0cKTr2d1+xu?=
 =?us-ascii?Q?ig85K68j9HIW+Qnvwg158pMzU/GtVVHbc1zVVIoMpnZHjTbcXnEWEyuGptMu?=
 =?us-ascii?Q?WAU0Nb/EGg0Hhmawvv31LVkcP1rOJb27r9YDMTLU4kBsssngYq118CPWIGqD?=
 =?us-ascii?Q?vo8MM38CERxUYj86lmi3CSDTqI1Kmr3CU3uq4ZZeNz5zud2Zl1mHBCCxVNvS?=
 =?us-ascii?Q?So4pZsuEnvoaIWnIWkHPH64S7rI4PSXcGjLxqb13zG0pGC6bihpgBNS2ybwE?=
 =?us-ascii?Q?tBh3u76UBnom9+VLEdZ9oo6Y0rFN8IJW24b92GBgdKTRV4yX9cxo2sG8Dx56?=
 =?us-ascii?Q?FP5AqnUv+gisNZgAShoQ44ZFAUqfbmhGTfzJm3x7R1YN+/IZMBpwYkWhDfqn?=
 =?us-ascii?Q?V41PVZUpLq3uXw0DKxN1kccp/Dbrw2YV4824DY48DUw9QVVhg8sodUUayPU/?=
 =?us-ascii?Q?FsmiCXY2k86VGexJewngGV/dVGIHF8oNXTk8xqgbW0JQ0Q/SQJbedLTe9jRI?=
 =?us-ascii?Q?n0+Sd36pjKhjxOn4eIBM+TiHvTZyKGk/xfIPOXKMZEN8XO6EHsu7MbscQKmz?=
 =?us-ascii?Q?uV+YX6vxrueowhcPD+bWpGvQrQoQmfFXenis?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:56.1008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19badfaa-15d2-4214-c4df-08ddfc59d803
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332

Mention how it would be nice if new code used defer. Also if it does that
in dirtying helpers, how it would be nice if these were named adf_*.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Kuniyuki Iwashima <kuniyu@google.com>
CC: KuniyNicolas Dichtel <nicolas.dichtel@6wind.com>

 tools/testing/selftests/net/forwarding/README | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/README b/tools/testing/selftests/net/forwarding/README
index 7b41cff993ad..392a5a91ed37 100644
--- a/tools/testing/selftests/net/forwarding/README
+++ b/tools/testing/selftests/net/forwarding/README
@@ -57,6 +57,21 @@ o Code shall be checked using ShellCheck [1] prior to submission.
 
 1. https://www.shellcheck.net/
 
+Cleanups
+--------
+
+o lib.sh brings in defer.sh (by way of ../lib.sh) by default. Consider
+  making use of the defer primitive to schedule automatic cleanups. This
+  makes it harder to forget to remove a temporary netdevice, kill a running
+  process or perform other cleanup when the test script is interrupted.
+
+o When adding a helper that dirties the environment, but schedules all
+  necessary cleanups through defer, consider prefixing it adf_ for
+  consistency with lib.sh and ../lib.sh helpers. This serves as an
+  immediately visible bit of documentation about the helper API.
+
+o Definitely do the above for any new code in lib.sh, if practical.
+
 Customization
 =============
 
-- 
2.49.0


