Return-Path: <linux-kselftest+bounces-3651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E583E6D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 00:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3721F2A813
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C245D725;
	Fri, 26 Jan 2024 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aMIG8p2A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35FD5C8E9;
	Fri, 26 Jan 2024 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311326; cv=fail; b=ANQ7H8PGWiBcnHdM0x6hQewZfo3Lk5MrzdlvDjRVxauCGVHE5Wcn8HPK5cG+c+al9ZU+Qresexg/8aRM1fCD61cYQ4E1CpDAn0xGDsYcy7GADebzYXSmEMHXsRdsfAoMUyP3Xj7bVerepzCXoDA56XiETKi4jinCY/hmKQJFt3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311326; c=relaxed/simple;
	bh=3p6DW1oGUkB+rbF7QetRxogci53UjHtPBdqppz77xeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luhQMs050lQ1Rk4i24BfWKasfjtk1hYnc1wa99l0FH7o44N7xca89tzoHm/CYMxU37J+iIDX3zKLxeUxRt61KOBkPvtOYpkQmrPM5o4P2J8I1/Eo4ZG6q5F22AMqTZutCJFBc7UEQy5YA+CUVNjJIzt1o/GoawtnCg3/yVnH00I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aMIG8p2A; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0xoX3Lr8HXqgjifShyrGbgqYbkRT/vGCvszOUrVtgtviTXQAmWyZ4Cqi/LOrNODSelHi7mfCo5ABklmx1LPJE0uyX8o2ENc1k2gFeyeesKPBGeSiq2d40IP6pHHUqc3QEOejHhIFictAwz2gmi9Rzvz35pfjgJkj8D1e5F67S/F5iG4MgXP/55P/Gl42Elxn84laaXMJMokGjpa0m4xtvJj8t26dDPMYGnU4cub4skHzCucCQJSeZiBYwXwvwVcAPQvn5nb6EVnX9z+NGKlBDmBcyUBvjc1bVrMSpE9242LUj8XUvPMSy8JDZ4aG2MFcZfc0ALxq3ZXP8VP2LHmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbWz/pBwfjLBLKb7hvVMcCd2x9ssSsmIQXiICIOGz9c=;
 b=GBicERYECaPhkyU3c5vrEE1pkGZCa/Sn05stOO9YZQSweSkSP3CO6lvccq98uMNSe5CV5GNLPnJWm4iEoOxdka/JldT6icp7ULCKqEQcT2yvCY45BdzHMYBlaNO369q8e4dyDMR3jkLcmjKHXNYie1X6D0mKp8u3zfBvTtjjIsKHfbu6Pj64mPQf3rGVC5Rav9O7I3U+1+QIAcz95oGUyeF0yzlhQnt3L4h3A7S5+1X0zNAhN3XMLZZfBV5uahST55LdN3zKLfSWnnBb+s2+Kjbrnk55aj1KmGs7BAcH4thhZtLTRefF6viNHQekpRFfSGbVDBDm4FM0HoGjkapDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbWz/pBwfjLBLKb7hvVMcCd2x9ssSsmIQXiICIOGz9c=;
 b=aMIG8p2AFoNXKEFdOQkJqURJClBeMauihmU/pOYuLI0ZEi5NHn0v9dzch6tqE8Zlm5NV/O+YfS2lgP05dbbbQQuQeG0n0Ue/fq+1cnWXW+9CQIo38L5QVhFluth3MRZD4n+dGpJwtAdeGWOVOlpkVeFx5gSXn8C6SCyFKNUd3Vh+PiC/1Rvo8fpdT5GuQwZv+AE6Zr8TEm1YwJ1L6MIFoJ8a263HVSxb5NPrhjWoXm2TDftsU5NjGOgAdpg1efcwRTgKEqyXtV0WbL1+f5hF6g3grdjbDuFazFS64hI3UYfbXjpLpFV5ypNCgydcfyhwMN8/bbo2+TOXCFq7EsIC/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 23:22:00 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 23:22:00 +0000
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
Subject: [PATCH net-next v2 4/6] selftests: dsa: Replace test symlinks by wrapper script
Date: Fri, 26 Jan 2024 18:21:21 -0500
Message-ID: <20240126232123.769784-5-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126232123.769784-1-bpoirier@nvidia.com>
References: <20240126232123.769784-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::22) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 6441e470-a5bc-41fc-446d-08dc1ec5991c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q5v0206bbjI0Tazoo2BIi1Hj+Hzto6iPYeHRG4lFlNFiCvozTCnc4w9mQbFrDxfAMKxe45wvu938JAxU/D2tVfhd+7CEAQPMNy4BzkFyu25ovTae+HC5hSegBWJKV1Gct8BtOqsQGLPqNGKuJq+NLY+bY5RqcCbGBK4u9ROipLAsMhb7pssIpbHv5atAd1JzkBZVHXj8bGMUvl8ufiTupu7CMZTIqgr2J4Yes0ZdXQrB6K0wWYNvW2vmJOxKjSj7KPyVu8i0/glmKh7YU7DFmQ1+fA58hacThjpV9GUnFLW1sbNjbrJ0vDAYjex9wDiDiCSew0JcWNWBji5fWCo3uOAr1PjwmcME37UxZCi6WV7Qu5qRm/yZYjM5tnp4jU9THcl1Rt/U01QZZIIhTPc1mFFyB1qeIWL8r1LPYkXhJLBtFqbduWX2UZsiND3nizCpnTS02aGVkdYm+Gsa+JLLq6EwUSbLh6sdMileRNgOa+Esize7hftb/2A1BMl2IrDoXFRsHn7szAkNaLM/tAVxM2I5RT/98xNaQ8YJTVl7zl+2VymHnJhetO4ksYGNQGL/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66556008)(6916009)(66946007)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(6486002)(478600001)(86362001)(2906002)(36756003)(41300700001)(7416002)(5660300002)(6512007)(26005)(1076003)(83380400001)(38100700002)(2616005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gTRKYclMMDuiio0wxhgOZGnh6tUo4J70mAp3F6UpEy0dGXaJGdYECjFQxL2a?=
 =?us-ascii?Q?XKRuC/gKCA8l8ARKjjRVY7657dTAguScCY6wWhQDVBh6eHG0FRZJG+qhHlAL?=
 =?us-ascii?Q?o0UKkvc/h/S9v6m/wXGIH5JZgeiEukA8clPMlq6CzyhsGdeWlIIzbHwbxTk3?=
 =?us-ascii?Q?luBbihg2eVOXXJXTf3Q4Ubh4bxCuPYnwh7h8/1Y99Yzw0haf5xI4XW861OgT?=
 =?us-ascii?Q?gUnDynGhTuVVZ/6L9uB74PRRyIIkAlVbHFhtAV0SCz4MQC5U9U78DguHwXts?=
 =?us-ascii?Q?C4Wu34hzAlF2xKMlW8FZ61dJzISiRpRISZfd/Ea9/m2Aksvxtek537o+JKxS?=
 =?us-ascii?Q?DgNL91oA/jRiZj1uiui9PNI4oapWUHfz52Ej8BSUUlcRCsZfico7cMvPfsdM?=
 =?us-ascii?Q?1v5KO4jKz8z34/QmEaE5kaMdCBy5JDsdx5oh/iSksX04bfknIwSJpnZDOQuZ?=
 =?us-ascii?Q?VvoyPayJOABzl0uaKCyZnWwC2OMOcnDwxS9xal78t2C67w/5ClcyobblSkTn?=
 =?us-ascii?Q?S7NHfaxSVeEzw6BWWKfCJ8XtrP+uHr5oADr4VeTJxPAgKRLU+Uuasf6s41mn?=
 =?us-ascii?Q?1HkQn7Cp08QtVqmiFnljeh+uRZJACDQnrc/Q8sVDK8qs3ssWrEtnxrBERS/P?=
 =?us-ascii?Q?mdkJ6c/aTrElJQDHv6GgKyFQ5ydU+0fhh0e3bIRTCIvkPgMSqLMY64KYxCsW?=
 =?us-ascii?Q?ka19QmkIcub8eZLUjJ+run/Mmf42kBFGy5NYjsP7xQtc0FJwwj/mVeN/il7S?=
 =?us-ascii?Q?AZ7seaSk/6SCmWfNz/q0alHofy9i3QuqC3GJJjef9c60CNG8bt9Nkub/s8WO?=
 =?us-ascii?Q?v2l3TLtyzdrKmYNMuF6QXVwoomMMgQvEykqqy+bdrMx0pI5BxKTuI8A00a16?=
 =?us-ascii?Q?Iulx0ihcVTjj+KR0cyTsS4OhgCY+lUIzrSlqoZyBP0snpkbV49iOJJDfsE2z?=
 =?us-ascii?Q?riyVhdNcH0Q4N4QY926KcjtTOLkDCLQ6B6IhJvhOo/Qu6Xt7+wje8xS4yhHw?=
 =?us-ascii?Q?yAaWVhjZo3EzRk7tVM5+GHvp3z+eqEVHYAx6HLJnpIqn2mNvE3D/15MlMDny?=
 =?us-ascii?Q?0/pBjZgWlPVkmS/oEHfzwjgIhHgdUWHQfhd4e3JSLAmjLYuwPEP6eZF7Iv2N?=
 =?us-ascii?Q?gN/0pQenbeTWowTfFTk1ZzuQ3qgm/Fi/mKFRlb7+rYv6rFE8xIj4JVvBhpXh?=
 =?us-ascii?Q?cgDSZH1w1WimGhcavdcv77R0n7sWVt5cIu/DKVcfl6phmrkAYeDei3GXvR6w?=
 =?us-ascii?Q?PE9K8d9xBOls212FnugKhGgnem3vuLgRgPdSqsXDnLdBlUieSZ8uUCFMLC91?=
 =?us-ascii?Q?dOkI+AHmRZZzNFEIfuyDNH9fnRpR2L/DySch4KEgvL3m2SUpnLAdfd0/V1+d?=
 =?us-ascii?Q?sw54jNkRXzQH7SqKD2h/h8FK2TC6vHrK9+PrbrQLKALG0hV/hEnEmr8L5Whd?=
 =?us-ascii?Q?W40Gmn/ckHiLBF+W1RWKEulU52u0Xwm7bG0ZaM2X4+CtlJfDtxGTWHGYbfXf?=
 =?us-ascii?Q?7DRlVEJffCrf64Q4X7YJbMPfDbiJ5CR8DjSRzEFaQ7LTiZPQFF8gsfnxVkU+?=
 =?us-ascii?Q?ys7LudQ9Rk7cOg1FfUo4xzJ6UTwYP7jSAtP1rwQd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6441e470-a5bc-41fc-446d-08dc1ec5991c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 23:22:00.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jh65UsVMy9/jjeHL3iVp2I11yLtRuvX9ivaqAEGHXY6539AbaD6xRg8ye2MMeHIkFNgxav6h9UbnZlNPPRCSQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

The dsa tests which are symlinks of tests from net/forwarding/ (like
tc_actions.sh) become regular files after export (because `rsync
--copy-unsafe-links` is used) and expect to source lib.sh
(net/forwarding/lib.sh) from the same directory.

In the last patch of this series, net/forwarding/lib.sh will source lib.sh
from its parent directory (ie. net/lib.sh). This would not work for dsa
tests because net/lib.sh is not present under drivers/net/.

Since the tests in net/forwarding/ are not meant to be copied and run from
another directory, as a preparation for that last patch, replace the test
symlinks by a wrapper script which runs the original tests under
net/forwarding/. Following from that, the links to shared library scripts
in dsa/ are no longer used so remove them and add all the original files
needed from parent directories to TEST_INCLUDES.

Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 .../testing/selftests/drivers/net/dsa/Makefile  | 17 +++++++++++++++--
 .../drivers/net/dsa/bridge_locked_port.sh       |  2 +-
 .../selftests/drivers/net/dsa/bridge_mdb.sh     |  2 +-
 .../selftests/drivers/net/dsa/bridge_mld.sh     |  2 +-
 .../drivers/net/dsa/bridge_vlan_aware.sh        |  2 +-
 .../drivers/net/dsa/bridge_vlan_mcast.sh        |  2 +-
 .../drivers/net/dsa/bridge_vlan_unaware.sh      |  2 +-
 tools/testing/selftests/drivers/net/dsa/lib.sh  |  1 -
 .../drivers/net/dsa/local_termination.sh        |  2 +-
 .../selftests/drivers/net/dsa/no_forwarding.sh  |  2 +-
 .../drivers/net/dsa/run_net_forwarding_test.sh  |  9 +++++++++
 .../selftests/drivers/net/dsa/tc_actions.sh     |  2 +-
 .../selftests/drivers/net/dsa/tc_common.sh      |  1 -
 .../drivers/net/dsa/test_bridge_fdb_stress.sh   |  2 +-
 14 files changed, 34 insertions(+), 14 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/lib.sh
 create mode 100755 tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/tc_common.sh

diff --git a/tools/testing/selftests/drivers/net/dsa/Makefile b/tools/testing/selftests/drivers/net/dsa/Makefile
index c393e7b73805..83da1d721017 100644
--- a/tools/testing/selftests/drivers/net/dsa/Makefile
+++ b/tools/testing/selftests/drivers/net/dsa/Makefile
@@ -11,8 +11,21 @@ TEST_PROGS = bridge_locked_port.sh \
 	tc_actions.sh \
 	test_bridge_fdb_stress.sh
 
-TEST_PROGS_EXTENDED := lib.sh tc_common.sh
+TEST_FILES := \
+	run_net_forwarding_test.sh \
+	forwarding.config
 
-TEST_FILES := forwarding.config
+TEST_INCLUDES := \
+	../../../net/forwarding/bridge_locked_port.sh \
+	../../../net/forwarding/bridge_mdb.sh \
+	../../../net/forwarding/bridge_mld.sh \
+	../../../net/forwarding/bridge_vlan_aware.sh \
+	../../../net/forwarding/bridge_vlan_mcast.sh \
+	../../../net/forwarding/bridge_vlan_unaware.sh \
+	../../../net/forwarding/lib.sh \
+	../../../net/forwarding/local_termination.sh \
+	../../../net/forwarding/no_forwarding.sh \
+	../../../net/forwarding/tc_actions.sh \
+	../../../net/forwarding/tc_common.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_locked_port.sh b/tools/testing/selftests/drivers/net/dsa/bridge_locked_port.sh
index f5eb940c4c7c..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_locked_port.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_locked_port.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_locked_port.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_mdb.sh b/tools/testing/selftests/drivers/net/dsa/bridge_mdb.sh
index 76492da525f7..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_mdb.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_mdb.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_mdb.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_mld.sh b/tools/testing/selftests/drivers/net/dsa/bridge_mld.sh
index 81a7e0df0474..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_mld.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_mld.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_mld.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_aware.sh b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_aware.sh
index 9831ed74376a..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_aware.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_aware.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_vlan_aware.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_mcast.sh b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_mcast.sh
index 7f3c3f0bf719..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_mcast.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_vlan_mcast.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_unaware.sh b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_unaware.sh
index bf1a57e6bde1..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/bridge_vlan_unaware.sh
+++ b/tools/testing/selftests/drivers/net/dsa/bridge_vlan_unaware.sh
@@ -1 +1 @@
-../../../net/forwarding/bridge_vlan_unaware.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/lib.sh b/tools/testing/selftests/drivers/net/dsa/lib.sh
deleted file mode 120000
index 39c96828c5ef..000000000000
--- a/tools/testing/selftests/drivers/net/dsa/lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/lib.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/local_termination.sh b/tools/testing/selftests/drivers/net/dsa/local_termination.sh
index c08166f84501..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/local_termination.sh
+++ b/tools/testing/selftests/drivers/net/dsa/local_termination.sh
@@ -1 +1 @@
-../../../net/forwarding/local_termination.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/no_forwarding.sh b/tools/testing/selftests/drivers/net/dsa/no_forwarding.sh
index b9757466bc97..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/no_forwarding.sh
+++ b/tools/testing/selftests/drivers/net/dsa/no_forwarding.sh
@@ -1 +1 @@
-../../../net/forwarding/no_forwarding.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
new file mode 100755
index 000000000000..4106c0a102ea
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
+testname=$(basename "${BASH_SOURCE[0]}")
+
+source "$libdir"/forwarding.config
+cd "$libdir"/../../../net/forwarding/ || exit 1
+source "./$testname" "$@"
diff --git a/tools/testing/selftests/drivers/net/dsa/tc_actions.sh b/tools/testing/selftests/drivers/net/dsa/tc_actions.sh
index 306213d9430e..d16a65e7595d 120000
--- a/tools/testing/selftests/drivers/net/dsa/tc_actions.sh
+++ b/tools/testing/selftests/drivers/net/dsa/tc_actions.sh
@@ -1 +1 @@
-../../../net/forwarding/tc_actions.sh
\ No newline at end of file
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/tc_common.sh b/tools/testing/selftests/drivers/net/dsa/tc_common.sh
deleted file mode 120000
index bc3465bdc36b..000000000000
--- a/tools/testing/selftests/drivers/net/dsa/tc_common.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/tc_common.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh b/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
index 92acab83fbe2..74682151d04d 100755
--- a/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
+++ b/tools/testing/selftests/drivers/net/dsa/test_bridge_fdb_stress.sh
@@ -19,7 +19,7 @@ REQUIRE_JQ="no"
 REQUIRE_MZ="no"
 NETIF_CREATE="no"
 lib_dir=$(dirname "$0")
-source "$lib_dir"/lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 cleanup() {
 	echo "Cleaning up"
-- 
2.43.0


