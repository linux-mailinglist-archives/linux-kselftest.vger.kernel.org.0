Return-Path: <linux-kselftest+bounces-12867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697291A9DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87171F2138B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F9198E84;
	Thu, 27 Jun 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XnrRCNV7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14496198E6C;
	Thu, 27 Jun 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499857; cv=fail; b=t8VbTb6hurEK5w0jIS2L1oP3WdrRwlLR1sGdsiROzfTgARyEttdrtilaRW2cGFUpRw79Dk90Rq770jp+5gFl6OiSevm7kt7fUwL26w6qg7bI5f8qN3YsW4rG0RatfkAU8vQ35jgdvxdtZoqvEWdDRgO8NtoztxnDotRSQyc/uNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499857; c=relaxed/simple;
	bh=qjMFUlhyyAf3bpLCpYxik3d8wmTpoSVnkg3E4NqEV2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aeg0xpbUy8Z4DTld5MDcEvOEa8vrl2sYPMyCI8ESTNljnUfESCQRlk83u0vzfnED1GcYQT1MkeQdNqKPS+SSWp+kBNUaC5bksjvaFMhoviOPWjKmQxnyjWFwoeEQkFrhT8BevkTqyvTQJ7uOMabOVgP0RLbtNghENN0ZTbITyg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XnrRCNV7; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TY2N4TXSuwYMV3ibNu5r9clmYHOPcFUWGjmLmF9NOxryM/5sxeGnvBht6MkWd2K+CHtluvlWRpef9QPeT1bzeLONogPYD6RV7MboHZmvaJt/lCsZtQaulcfORBROoOVw/CGgOxpm86uS9J2+4QNU5nt30+oKN8Zl9hGYOBnTCEDeyerw2IY+1xHqoSi7CfXigIfCjVqRVCPpIlMNdJqu7YL2NXAivliZpXQdA/NGpbj2LCES8Ddb+yNE+As0bZizrsz1zQhwA88gmibeTjgO1MmoKEv6Rl6IXQiYeToPPS07apR/JuHu9mi1D7rt4VicjsYkj6yAbT9S+FiEwPKzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKgxkJmZc+rXtAW/Fn686WAz8ITy0ZU7NXGUlwA3zwU=;
 b=MyC+dvb9nJQDb/XyFhicYOsy4cQ6nN3Yn24ROYHebmoolnQJPybSZP2qWGaXUJUbAqwVnH7cTPvfKx9pObFus/BRX3x9tta+g/LTAzVKaC+G6shRWynH+sgAIXraO5EVB8VCqdefBYw2LYKJMlGhNPkSzbS4rbtIODNKxb7yjvZsatqpH6qj5/I5h4WgmanBZMgu5DKvOO4Kvzt7X+rxq838np+X4dxRvsGg84aNt387WWcAorH1eJTnc2oek6SpxOesme58JapoG3o6OPqtXTvNc24BpHaBMKLDUObSrerYauMpMNPvFESsSoW1R+yQoRfZH7x/wTeI7YtNlexVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKgxkJmZc+rXtAW/Fn686WAz8ITy0ZU7NXGUlwA3zwU=;
 b=XnrRCNV7QuVx0iqMyQkJMhNJm8m/rGw7ZVCq+hsoUiuSCJQ9OqJG2P3DrXdId9iY6d9+Y3v7oJQASAFfh/vREB6Dpbic7bh5Toc1wuAyDGJeBTMWzrMfx4SBPf2XEUSl+p+hMo2HaxFfkuVvlbrpYjns583FeC2z5mtA/Qd0w+nbBD61HrkW2olMbM+ygSTNBAt3oOGRU2I2wfRzjRvNawTtx+3xiRsrC0RC41YZ1/xwX64/vgMiF+4xYaYrHQoab+vteos7ocd4hOQzHkQ1v7JxuSVVm9fX+qzJ5kZXXaG7KIalGal4hkF38j7pUmmJ268asnkip5XpayjzJJnqtg==
Received: from BYAPR11CA0072.namprd11.prod.outlook.com (2603:10b6:a03:80::49)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 14:50:51 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::ee) by BYAPR11CA0072.outlook.office365.com
 (2603:10b6:a03:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 14:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:50:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:34 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:29 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 12/12] selftests: mlxsw: mirror_gre: Obey TESTS
Date: Thu, 27 Jun 2024 16:48:49 +0200
Message-ID: <415d4940ec50b6520650d22636365d42fd931b17.1719497774.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719497773.git.petrm@nvidia.com>
References: <cover.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b12b8ed-be50-4d17-f9f4-08dc96b889ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cZD00vVw3ZpziG/BmhjqqWWXTNRjQtxpwpHayKVe1xoNVBMas9elEckbRxgk?=
 =?us-ascii?Q?LAPq8qPERdjksSJG9GdiqW0/hYsfUvVNriTwcV0Ry/lfZRwz/iKevmvBfBXN?=
 =?us-ascii?Q?jZ36rCtzcdv18hxnsLsrIE1owQToJpaFwoqwqDiLPya8rt6+ImoXS3g0QQJr?=
 =?us-ascii?Q?oXNVtyfAx+PV4WCCfTFr5D6fj2DSariXS+jo4pqiZxTR/pNFIF6qp4q7vg6V?=
 =?us-ascii?Q?nQoY0GwPuxUpfY7ucVDudQK8dmm0Vf7Dnn13XBcOFYV/Sucd6cxhxLEMP9N/?=
 =?us-ascii?Q?DPcAw0JLOl8cNPz4ltH5INIqwfOz70u8rGtImAcPGgE1ZqvUlVGm4+4nncOG?=
 =?us-ascii?Q?eo9LbAYVGQ8jMS13m/RRMufD92Clh6GSQ3y1nIJ9G7WI39vcLbZcow5F15QY?=
 =?us-ascii?Q?voAl/D4D99u4qjbC22vXZLPVd6rHci666q0ttU8rFNG8EqlFb3eyvh1NhA9i?=
 =?us-ascii?Q?o7WQAT1jd4VfUpUI171xQCMqTo62YvmCF1ujdMCP6VlEn4tp2TPgz1XmFOjz?=
 =?us-ascii?Q?b3wPdmYqap91ig9zxS80RctfQUGGpEcdmBJ/9lNRfI05t+yb6zUGdjq9T8Vx?=
 =?us-ascii?Q?C48LjRFF+mPDQZEo/gQU3M+p8L97Z+okt1fwYFL0B5dkBuBUadZVOYZoPh8a?=
 =?us-ascii?Q?ZdFFlgQKO4VXVjU7EyooV0z1H/xLQbq3W5BB5jcJF8YJ/04cE9Us4IOcDdrQ?=
 =?us-ascii?Q?6tkkFZSkO0h27WCHbwzOt8YklUGGjW3Q2LiUV7XhDZYHxvnjOX4GUL2ixJ2L?=
 =?us-ascii?Q?DuvfMMQGVGg2HHD+XeBSvyjz2t46Pn6oL5Py8KcWJ5uBRSpH5cb1YG5MNIOO?=
 =?us-ascii?Q?n26LbpHY5WZrnhY2TAWBq5RRJgNz/8pD8c8rj1NENJMhNkFD+lPOlXGwQYth?=
 =?us-ascii?Q?q9Qvn0ANstR8Ge8dUlvdnkNwLnEUkGfebaDxAN41phYoUV2r0pTD4YN+eU+g?=
 =?us-ascii?Q?4ah7nDxue5a42s+bJuOwbcrFCxhNg5eiBGM6x1CbhVoebtg/aO+kiVlidRhC?=
 =?us-ascii?Q?UZuChjEjbG6YKgTKvVtKHt4qxjOE00g1xcwJuq28iNJi4OqbGUFxFpAgOTu3?=
 =?us-ascii?Q?28rh4afjOWySv1X/bRYI/hMG3b+EedG9KRk/hwuEC2Xpm4/JtMl0zlRU9ubU?=
 =?us-ascii?Q?8G5pqsCqYWqhZ/65gTRzv0ZRAjY3vxMijKlcKiRqv4LIlf6xdaORSobgou5h?=
 =?us-ascii?Q?w97vhM+yqAKhe9UhdJk7R8xyqJIwrG79m/lqiQGdiUgjvWi+YWx2Ju4jsh/8?=
 =?us-ascii?Q?BD9mENbgDCy67/T/I9ouZcBkO90iCRQYwCZJ1hZWs8uP7YZgz3kekJxcubxz?=
 =?us-ascii?Q?7MBru/LrEAV+MMTAYy+CCeWgQs8HaqmIPa8Uf38zI2gAgAGzsug+xzmmhRlr?=
 =?us-ascii?Q?lrot+JAS3HTYDRREEcLC4FM3eBHi8XFFCz9iPqsco3W+ERkVnZ/3vmeF1Sr0?=
 =?us-ascii?Q?SgO31dPpcPSQ98J8RnCakHAsMzZIwBHS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:50:51.1900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b12b8ed-be50-4d17-f9f4-08dc96b889ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486

This test is unusual in that overriding TESTS does not change the tests to
be run. Split the individual tests into several functions and invoke them
through tests_run() as appropriate.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/mirror_gre.sh | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
index b9326baeb43e..e1ad623146d7 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
@@ -15,6 +15,13 @@ source $lib_dir/mirror_lib.sh
 source $lib_dir/mirror_gre_lib.sh
 source $lib_dir/mirror_gre_topo_lib.sh
 
+ALL_TESTS="
+	test_keyful
+	test_soft
+	test_tos_fixed
+	test_ttl_inherit
+"
+
 setup_keyful()
 {
 	tunnel_create gt6-key ip6gretap 2001:db8:3::1 2001:db8:3::2 \
@@ -162,19 +169,25 @@ test_span_failable()
 	log_test "fail $what"
 }
 
-test_failable()
+test_keyful()
 {
 	test_span_failable gt6-key "mirror to keyful gretap"
+}
+
+test_soft()
+{
 	test_span_failable gt6-soft "mirror to gretap w/ soft underlay"
 }
 
-test_hw()
+test_tos_fixed()
 {
-	test_failable
-
 	test_span_gre_tos_fixed gt4 gretap "mirror to gretap"
 	test_span_gre_tos_fixed gt6 ip6gretap "mirror to ip6gretap"
+}
 
+
+test_ttl_inherit()
+{
 	test_span_gre_ttl_inherit gt4 gretap "mirror to gretap"
 	test_span_gre_ttl_inherit gt6 ip6gretap "mirror to ip6gretap"
 }
@@ -184,6 +197,6 @@ trap cleanup EXIT
 setup_prepare
 setup_wait
 
-test_hw
+tests_run
 
 exit $EXIT_STATUS
-- 
2.45.0


