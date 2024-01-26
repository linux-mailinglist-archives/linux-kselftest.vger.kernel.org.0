Return-Path: <linux-kselftest+bounces-3649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3883E6D2
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 00:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D25B23485
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C815BAE9;
	Fri, 26 Jan 2024 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YzvfvswV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018915B5CA;
	Fri, 26 Jan 2024 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311322; cv=fail; b=JTVkzBT4AzYlB07tLiZpvfmM5mKJ4xf71Koz29Uf8ehB1dHGuqz1rzOZZ9rV989QMrh0QmvzF6RftNKEBGx5gfSd0OSpZHPp2QbM6oSUA7BsHxB6n6wMLayVIqskGO/pz1Oill/btni8Kd0Cy6mwY0imbLK/G+vymYEfHjzvtdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311322; c=relaxed/simple;
	bh=W/z6L4hRgPMni6Unz9or8j3Iith4kFluR6fovyZD0f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bv7ZtC63Y0a5J7ivEd14l4wzEgRX7R7pGRkkxXpFXscBka5Q36IwOd1v3BiLsZU9fpWsIYqbWQgtytTsLnYl0ycySn/31V9ZslRtsYNLnC5+RwALYaxe6iVclehXtHvkus+z3G6KJLhdz9ojEaK8T/6Kp6NUtXWFDhWEy3coQus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YzvfvswV; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcjNydJjeqNfSH4opGQRSWAiB0bvqysncFkax6NOl9yfKDOEiBrUgyA0CafUiQEz3tqwR9l3FCr3ef9d8HWH2nMO0Z07HTK1dI3U+likS8uOM0H7aWVq04fGSs7acAff10jlEgLA7J+UKwiFsvNnEWxmHkToVXnd29faVpRcLCVhY3ZlkygLBDrbiyUgjcAMCGwQkHaItYzQIS9KeSVqfb0zQ+UG+oKVK9FQemF/7rS1RPdE3+seer7cwDa9vRbUoMC7zzshhnnhd8NamZTJ+8R6uGZ1xG+/c3BYIuLwkvu1S2IL/jT48mvXB8HyUgMt2G6eMcUaWOYhd6gsptOLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+z6AI2zG7Nq0V4Pn7Fu2/hHPew1TM2nYHJMfZp81t4=;
 b=Xva9nRWg2AbF3GZBQaRYdYQ5bxcUzkWntTB0uVDltRn2cgxlKLQDJOZOQDdfJPPKYF7E4Ni762W26mR6FE+H0njQ8nzBSLvZjI/v1v7gcraWXe5ZNhljxAOJTAw+QfkIIksxQMGgGDqNAH72wao0dg5ndjMkAl/QeTjttcPg2X39YDlVdyXThpDjCtGchQkL5xasrppVdkC3vGAZdXikSXuDvu6LALt9cYOlRTLalJ094Nu4qzNbhq0dm0uzJTcxQd07mS3TquziAPClf9fOyPilswsHwJTySHDGbPJoGgHXkl7V7/GvP/0S/oIqZEHZ0zCkkwvE53+dpQxVBqZSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+z6AI2zG7Nq0V4Pn7Fu2/hHPew1TM2nYHJMfZp81t4=;
 b=YzvfvswVu39s09K13dhu2amOOZhx+ywNk5ONL+bWXY58UewLZysIJ5d2NuGNZ/Ykb4vv+T80VbXAD3FeVhner+B4rr6oRNftWhg3OONZcdiwMoGqwS6B6feKxLITdn+ffGWF2vTNNKVDUrNCVSkdy8goAQ9FUJhlEb7ZfCeD1mFj1rqjqmhsP8Z8nwcvqOlBpEy6ohn8SIZUuqp83xIJzzbnd8zoHsElTUvblicStuD+KE9xVPh+PulK0g7sq2oSAkWSbr/Vy0XrgtIGynnATTam6syB1hh3pNCvx5OJcqI2/SsF3dTsWOVuGYCGH27fKtzZc/brTRRCyeDh1AilYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 23:21:57 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 23:21:57 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 2/6] selftests: bonding: Add net/forwarding/lib.sh to TEST_INCLUDES
Date: Fri, 26 Jan 2024 18:21:19 -0500
Message-ID: <20240126232123.769784-3-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126232123.769784-1-bpoirier@nvidia.com>
References: <20240126232123.769784-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::43) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4102ec91-9de3-421b-a59c-08dc1ec596da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H2N8fUVnEe5JNJW04j6OU2bxQ8ikp6/VEcaMHjCnJfPPSVlVwbg+fTN9y46gMIsul8fYPSfc2w+A4NABkuKioDACkbP7ZuSRx079AGM23NAqAXRDek2kOFsVi3lmpemIURW1VLx+yCv4T1UJ3H3ymDMvYOvscI25OYV/VpnpRf7+G+JYyXYt8ilU3wDRMEryXo9k3SandRFDWLBD6ub4zPvvL4MHG1aZVlFjafAGXsSByB4tCbqDc5oCX+5TBmFyIdGPXILIW9Yu6K66hIqWkx9nH08Uogba5Nh5Rzi9ppo6ACbPWBurm+whzMibv/Ppr9CBborKLazS61nrvwoF1v+9AEneyXWrIBubIqa5Enr5tjhFhP6/LziG5VcOtHljTTjI8uhrLmNdTPMSl+HMl6S+lljFbh0KvGBzv5Ml9UnO7ZyPnQT+BhZt/j5QBoXEEj91zT7yLPed2xDIyzO0Vr7A0k0BNV5h7t43jgGPZYdLLKFGskXjQtQCizsbS2SxNTpAzNAqI1VdEBLm/ReXkP8+xKEDRNdE3RnFzh98ysBX+pVdU38CsvliX9GK+wQZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66556008)(6916009)(66946007)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(6486002)(478600001)(86362001)(2906002)(36756003)(41300700001)(7416002)(5660300002)(6512007)(26005)(1076003)(83380400001)(38100700002)(2616005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e8dxFeUzWt7f3pI1CoH4SnEAynpuIv6qTyVJEgwY2/2zQVCenRshuOf1T78h?=
 =?us-ascii?Q?NR+vcGQkr7lJL3NEQF8fHetLHrRieqkVUuwKdeh6KpPoRFewpaksya+OsCbp?=
 =?us-ascii?Q?Xs8Yhcu3rREzruG/xpSxI93/i93Oc3yxmMS2D/mJUKPuvvuTJ/D+9AhWUE9w?=
 =?us-ascii?Q?HIrEEbjdklygcCtP+RxiP59VUZD2LEz7n+4ClBHSNHfoQF3eb3S39QyhU+Kr?=
 =?us-ascii?Q?0RvVUAD69M3kUuoBDMVqZWrhpZJGItw3nlxP6irLJIzRYKrlev6rHJS3rhNy?=
 =?us-ascii?Q?IxjGXTY8gJ5ZoFgUmvH4iDnO+romscc56V9JeB/G6ZnS/E3nsKRodUE9IY+2?=
 =?us-ascii?Q?yrvxVnniN0MC1p02ZGzMM6gNGmfPONZEdTxn04x4tsuzoakBG7IX1ZdMgeaN?=
 =?us-ascii?Q?Tc7omcazwNDHvr0tE77Y8BeJ0stN/wc2Ho3wxpVIH5Iwx72pnjzxs0L8SVkZ?=
 =?us-ascii?Q?6oBE2LJXSzvhVM1txvwg6coVs35TeCfzOwA/zSt8G5BGN4UjRyGXKqi5zAUb?=
 =?us-ascii?Q?0Er/sJjsX2yuZFehE9iiQMvHCV2gTGECUA5U81qnrNaeUfo9B+9AXCVKMbKV?=
 =?us-ascii?Q?lHIfcQ45yfJxP+MTYmCQQry2vQuXspoaf0P/jonAWQgfqnI3uceud5TMLC9g?=
 =?us-ascii?Q?5MepnAxbSyUWoXdOHoion8j4VGPFln4MaB4bO+BClDPk88AQdHLvAB/n5cNe?=
 =?us-ascii?Q?UAZsWIybdn5RTyfPUeIaq73jFxeRrl4wPHk0rSRYxsTW5WCzCvvK4s+bjDXW?=
 =?us-ascii?Q?1f3Ne20v/nIt4dqa7RNT/oXQCF1MHt0gBPbbiH023Y0eUjKqiuQM+AJLVQJZ?=
 =?us-ascii?Q?tFEGG7esLisR2byHK0PejUouEjZherGBVMJwOFI4DG/DlZJZt3/kg54ybrfo?=
 =?us-ascii?Q?zTItXFpJs3dnbE4SiSDuBWQ3JFk8kopvsewMyI0sIZ30n8WenbbzO44HHDZO?=
 =?us-ascii?Q?c4WCwBuClYSAUKKOTzYh1LKrSd0nC8fgbc4fScDDFo5x7Rtfa0Z8bdkZoBJy?=
 =?us-ascii?Q?8kh+pdLn6puKXtKFyvSA51PaITjSsBA0kj7gmr63DuD50gOSxZRpIS0ymIuq?=
 =?us-ascii?Q?XOvbnmXRbYGBw7qYb7/jg/qeCINnWbUeqflx9XISSZ877Ar8yNubyFmiKGEn?=
 =?us-ascii?Q?F9GYZsfyHU+Thk66yKXbWYrb4ZCGHzCpRdThNzED0Ji7DY6GRCFSCM1s83Cj?=
 =?us-ascii?Q?XkHiHP5lUQGIt2gtTw4Dn3TjiTTzsok66Aij8nPl/k24TT79n59UAI5/73/L?=
 =?us-ascii?Q?c8hOWaLNGGp9yVQKmrOgiXN83ToL7Kg0tRjpsQO92NmnbBG/2PD22AgaKW9b?=
 =?us-ascii?Q?LgxYbNJk2p7AXiGKHnop1Ad16Jve3lbfy1AF0T+2y+JDNVwAlUk8+0ifQFS5?=
 =?us-ascii?Q?yK72SEr8uPMZ7PIHOpBXMSE7CquORN7mElLv40qk6RC+vRfn8GGEAftTjvEn?=
 =?us-ascii?Q?U8UGwt/6CVT5KuUoFto1DJAPOYs7yO1TT6uxoac4mV9JlrorDVYcSAjIvyZx?=
 =?us-ascii?Q?KAWLLFFUSizKKDUbtdjdVKmiUW+vF8LCPfFUJYEDYhVZMPiqLz2MB+x2MJtL?=
 =?us-ascii?Q?I+/9WizflPXX+er+fI4yzS1jWGhBW9YegNRsEbGV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4102ec91-9de3-421b-a59c-08dc1ec596da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 23:21:56.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLshRXoMCbNf+Fx/gadfJWXZZnGoKpDk4QlpIxpOE2F4IakRTomnjv+EIEViZQDIxp+6Vhbd9U582hSOP6SWvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

In order to avoid duplicated files when both the bonding and forwarding
tests are exported together, add net/forwarding/lib.sh to TEST_INCLUDES and
include it via its relative path.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/drivers/net/bonding/Makefile        | 6 ++++--
 .../selftests/drivers/net/bonding/bond-eth-type-change.sh   | 2 +-
 .../testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh | 2 +-
 .../testing/selftests/drivers/net/bonding/dev_addr_lists.sh | 2 +-
 .../drivers/net/bonding/mode-1-recovery-updelay.sh          | 2 +-
 .../drivers/net/bonding/mode-2-recovery-updelay.sh          | 2 +-
 .../selftests/drivers/net/bonding/net_forwarding_lib.sh     | 1 -
 7 files changed, 9 insertions(+), 8 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 8a72bb7de70f..1e10a1f06faf 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -15,7 +15,9 @@ TEST_PROGS := \
 TEST_FILES := \
 	lag_lib.sh \
 	bond_topo_2d1c.sh \
-	bond_topo_3d1c.sh \
-	net_forwarding_lib.sh
+	bond_topo_3d1c.sh
+
+TEST_INCLUDES := \
+	../../../net/forwarding/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
index 862e947e17c7..8293dbc7c18f 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
@@ -11,7 +11,7 @@ ALL_TESTS="
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 bond_check_flags()
 {
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
index a509ef949dcf..0eb7edfb584c 100644
--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
@@ -28,7 +28,7 @@
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source ${lib_dir}/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 s_ns="s-$(mktemp -u XXXXXX)"
 c_ns="c-$(mktemp -u XXXXXX)"
diff --git a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
index 5cfe7d8ebc25..e6fa24eded5b 100755
--- a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
@@ -14,7 +14,7 @@ ALL_TESTS="
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 source "$lib_dir"/lag_lib.sh
 
diff --git a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
index b76bf5030952..9d26ab4cad0b 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
@@ -23,7 +23,7 @@ REQUIRE_MZ=no
 REQUIRE_JQ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 source "$lib_dir"/lag_lib.sh
 
 cleanup()
diff --git a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
index 8c2619002147..2d275b3e47dd 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
@@ -23,7 +23,7 @@ REQUIRE_MZ=no
 REQUIRE_JQ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 source "$lib_dir"/lag_lib.sh
 
 cleanup()
diff --git a/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh b/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
deleted file mode 120000
index 39c96828c5ef..000000000000
--- a/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/lib.sh
\ No newline at end of file
-- 
2.43.0


