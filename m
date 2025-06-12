Return-Path: <linux-kselftest+bounces-34847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC8AD7C3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6C83A5041
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7642DFA31;
	Thu, 12 Jun 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBSIca13"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DA2DCC1F;
	Thu, 12 Jun 2025 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759245; cv=fail; b=rA9NtuP30Ou/g/lF9Ikbedg/aYTa7HYt38abcefdMn9QQRz2D5aSj1N2RuDMjAe9DiZONGeUz7cvT5S3HwBombG3idYMDFlGB6jsgemL5YGDhlbtTzOpO2VnwfShYukkYOyl1nlyXaERKaZ4jha6lr2YehMZnH+gx0szkgaHJNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759245; c=relaxed/simple;
	bh=zGRWI1rSaudgHaYVIViIGMa8JCS16ouTXh1bURlO6/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7y6O48bb83lN5YBXeHNuKdJ2rNmgNh4weSfIUdiiUSEFeUUHhdPx8lExzW17YzyHTBBQsildeqz+I93TmnAM39wwN2Bnf5B5rDL8Sx44ASVhO2Jw0Dqu5XCncT4ZPA2e3Db48tslc+nm4El4hoRerrG5ATk9p/IktBJd5dINSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cBSIca13; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4Mt3S0o7iyg9nOU2onN7EBzcBWHn0E3BGFRZAq//pvPdm+mRX5Aj8f+n/px4Z8N+kA8z6xVOMhlDFSUuJo0hdNj9R5OGKetc789F4RNKPGGgjOjs20w4jGyt0uU08HLt3B6vzOr5QPtqrctJFyEinfYG3whf8Nl7IxAAYpKc7lCNlEuJuV/cT9KqziSKIsrXRwEQS0xh8oWU3ySvyMUbUFZWPTJznnpBhhHPz6kKXWXVtvTwlGw5b3MSr58JBy+tDRdqBZEiu+6u1/PcEaPdG8xaQ/4XpaYjA+kckAwplVIGdQr0msUSswSpTIV0JrYgybTP2RuvTshMzIryCLOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FFsb81HdZQwFpZHUhMo3H8t+CzLSd2RnMvxjTvdaFg=;
 b=WuU7RR2OZGy0e+w2W5UwokJD9AIdjyZs16Z2IOCofjcjiD35wP4dh6ND9RXtW1Mb1HBaxYkzXBHG/sv4DPeDmEuyIU4bqaUUogeYIYJ0SMQUq2ssB2Px6ekFbt82Es26cOcw+zxlwqO/tXNdldakWikI6+uC+hzpN85YOyyKzUwqUDf7SeokzPblKAchzzkv+nXCyPD4ZNZObi1HvClJ7yAcyEs1/UYOs+6FjGYgZ44ySY71qawiHD0/1DfUZa2mSesHz2jc7TYGJFoVw1Sl/lMHMZH7fjR1hUS/dVFACkqtTaMHLdPQ8LIiZNYsF0BrIZhUdwWsOsM/5b9LGy/NHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FFsb81HdZQwFpZHUhMo3H8t+CzLSd2RnMvxjTvdaFg=;
 b=cBSIca13FyESaz4HvX49bsil22lZatjWwfYA3yX9e7CYCY2jwRfO10bVYKnmDyT8oO5ndcN1HFnQMLsJweo4PSwMPXgqG4ci1cWaMpxxAKlIeTF92Kh8PTmJ2NrGhV7NRCrgxS6/U1saINrKKvz+PoGjOYb4LfEnUerIV3Fx8szE/cwdzj1dWV1ZRNZWw4glJjFqTOslF7RW5bcqnjsgsTgwO0lJ1xWr7dajxtTEgRNxJubRnEguGCZQCLqXIm6ud0M/bNzeEdTFBza3CVNNCbpa6O/HYGpp9nVz7EPUqG3OWdgoyM1hv00KSfc+iv4L7EpdpkrWsODjRSJwXWDg+w==
Received: from SJ0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:a03:2c2::33)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 12 Jun
 2025 20:13:59 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::fc) by SJ0PR13CA0058.outlook.office365.com
 (2603:10b6:a03:2c2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Thu,
 12 Jun 2025 20:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:13:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:13:44 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:13:37 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 12/14] selftests: net: lib: Add ip_link_has_flag()
Date: Thu, 12 Jun 2025 22:10:46 +0200
Message-ID: <0aed1ae15c8ddc666df3f13c3507dc656e396c21.1749757582.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ead794-6ec8-44d9-6a5e-08dda9edaac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kQpvLy7gb6ubwtMPXFp1xf3SWOAC+JR3f5ceTNQDgDEm1tEVG1v6f1hIdxf?=
 =?us-ascii?Q?+lT/+3cjZHl2K4R6Mr8gm+mpMkCy86FuPRQsIH9XituNAIQWcd4PbgT57J71?=
 =?us-ascii?Q?62jnBqnHoG4ALSpHFt1PiyI1dPopTyrOP8BVrQOtGC/lzfh2yPLTOmlu6MHp?=
 =?us-ascii?Q?vD2MIu/Zy6qk4dyWad5vzjbn9S3DFKYAPJNu5ztiit3VGbh7hvec2OEvJLdj?=
 =?us-ascii?Q?z8Xp7Flxyq4qro4pixo2zIZQRRemSZuYgJ+yZBRNfQJDezWJVD0i2WkM6KfW?=
 =?us-ascii?Q?HFBwNAF/nZxDn+ga7P16Gh4hLFDc2mIYbUDXh+t7bgj63nHVVXGVz37tRS2+?=
 =?us-ascii?Q?xe3jgYdmEJhRcHq4gjImR8z03K3KavhJ3mmAPXjsiVAlBY6Hy4tj//KADuWE?=
 =?us-ascii?Q?7eHQpFF5AeMXluPD/hTiMG+o/LZkfFYsbv7OZPQHgTL7zhCF5/omXSESiJfW?=
 =?us-ascii?Q?EP2s1suou5nDg/3jJK0LI1Kmwcv81QsQBQMpq8aDIUjwWSVL2J5ZEj1NsTYL?=
 =?us-ascii?Q?sDiCMNXKTS8sF4ro8tGkq/NEUar21yj2o3Vv93shMg4l7z6jpxcvR+rlTVq6?=
 =?us-ascii?Q?JPgPEE7j9mfHhv2ZN2IWQV/3Ou9a7HRAZvqTsz38nPWEDw8LfJJxK87XLp5G?=
 =?us-ascii?Q?GVpc7A1kMA2Ei8b+OmtQDy9qtiYRfIzQN1AAmuJNMaZHVEWXQjpBtdkkwEM7?=
 =?us-ascii?Q?x5LsyHpgRofaPIVUHGLQ8XyTA7NlXJrkIizj/rEA3il3gLtRkowq2SJnF90u?=
 =?us-ascii?Q?MFhiy/zVmwbGCU4UZ1wVc7JFBBLee3k/pxGbxs9B4DCOKqXtQ3jkNvhTeoho?=
 =?us-ascii?Q?tP3qP09lPDei7vzSBqDz6yEXrOThKvq4695j3N5O2U/qFJVTSrfbkCbgb1Wq?=
 =?us-ascii?Q?2tP1gkiuV22BfsEJKAwx8GJ+0GpnDRkwTvrwARt3z/zmvL4/4J640dQDnHwB?=
 =?us-ascii?Q?DUBpI9B6MCKwVW4EKAVkmSMNdcgLATf50pKg24KiqcZUfyiBC/zLwz3vjD+W?=
 =?us-ascii?Q?W7+pmCN6gwR7azU72Vdw92Ckq7m78/ToIovR29ga74NgOw2TSYv5HOAxC1qE?=
 =?us-ascii?Q?p1mu14CgymCw5dLUKQ0DINvnTsmgMJBnPWNhq6Ae7Jt45bhSvewArETRJfdF?=
 =?us-ascii?Q?jxaXyklJwgGGzIoUdPoW8HmUpG1RNuV6GvbHPNmVjYjEF6JXK1O4CMolYHKd?=
 =?us-ascii?Q?FhwWVOWUPDYIrnIBxVvokxG+G9ZUwS3ugKR4DdRquQIgCWmY6Dxllv5ESRH6?=
 =?us-ascii?Q?+EKu/UUhzqdpia828HGkt/Ch0NkvQipNzO1TV3HWdm1Ft3vyTsPaTJC2PTqo?=
 =?us-ascii?Q?kt2Wc/jzpTOfSrffFk8hKLGqkPqnG4X+A0AeMMs5dFNPf/bACJ/d7wJk8UIH?=
 =?us-ascii?Q?cxBiXm7oKFWJrSkdBALvjK0Nc/EXdKqTpNI9b4DIOVCxCuTNHrL1vsvYA5Aa?=
 =?us-ascii?Q?087Jf4+kLKfU6SzIZNfRVjolanAMFAI+N16d/WwAwRhZ/raYNgiuqXNDZ/tr?=
 =?us-ascii?Q?bZEh+47su3d33HqjRHfjL8aZ05rafYSgMtjW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:13:59.2742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ead794-6ec8-44d9-6a5e-08dda9edaac2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777

Add a helper to determine whether a given netdevice has a given flag.

Rewrite ip_link_is_up() in terms of the new helper.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/lib.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 006fdadcc4b9..ff0dbe23e8e0 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -547,13 +547,19 @@ ip_link_set_addr()
 	defer ip link set dev "$name" address "$old_addr"
 }
 
-ip_link_is_up()
+ip_link_has_flag()
 {
 	local name=$1; shift
+	local flag=$1; shift
 
 	local state=$(ip -j link show "$name" |
-		      jq -r '(.[].flags[] | select(. == "UP")) // "DOWN"')
-	[[ $state == "UP" ]]
+		      jq --arg flag "$flag" 'any(.[].flags.[]; . == $flag)')
+	[[ $state == true ]]
+}
+
+ip_link_is_up()
+{
+	ip_link_has_flag "$1" UP
 }
 
 ip_link_set_up()
-- 
2.49.0


