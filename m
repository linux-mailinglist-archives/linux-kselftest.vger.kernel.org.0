Return-Path: <linux-kselftest+bounces-3464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8410883AF1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798D5B28F6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459057F7C7;
	Wed, 24 Jan 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WkSOdvd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60797E79F;
	Wed, 24 Jan 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115841; cv=fail; b=YzpY646tsaCrohGN4vIzxhl89nhrtzXKJCU97zCoeA8W6OoWi4kdeyr33Q+N2Tx0wmajhAl+1VrWS+jkvH7S4F/MDIc086B1uMjENc52taCpUdfdtm0brhEphxfZ1BqNxQKePPzZV2JXcVVGw63Z2z/Yvi84eEs3KqoyAGTRTCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115841; c=relaxed/simple;
	bh=Uw09HnO1RGrPYPpqehDOd9nH5dtg87/DP6mBr00tohs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQcCrBgOjCdwJ2mfTBfweMRfTspnBe+EGQv6wIoAxzn/HJXdm9gr3SBLTZCuaFvPVgDRbg10ed/Ki2DbeQjFKmXxgqit4+CEtu3IROE9RhM6g0cn215CofHWrelhKLaOLnpmbwWcUnhnI2k2eINdXM5aFiTQEhGANQwQ+QMHjjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WkSOdvd1; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgg3fmqRTU8GQoaNWg2dzTkiyKLAEXVEzRDLeb/LL/sA9Z9hiPyGS23X3LHq4ujx3rzwZ57lKrHZ3lE1t9iSvH15XaDjTcj/VV2qXl/fqfHogGjIBracHHfpOx5lpyb05mHY8SXOFz61jg02QED/zirnh5pjhM5LGrElB1UMoYJcPpFtjNom8U7GGxYnohFau/1OzG3Sv6kRktCluLEUFDpXcETokOcZc+qRH2Nju7uo8EZ1JYmhtHgQDX2tt0k4LreyJJKGpqn386disaRw0cdrA25kuGJOz4V758UwJ7tIIO7ava618iCzccM07Sz0zbejgppy4YRja7CW6CkZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IZ9oAN02i2JdaTWyezQ7UmPk1kKYInDUHcbe4bi2TE=;
 b=WGL5NL01t0p8Ecv1W88tFO8GWKhh2GEfDgfCsOFOGuNxkf3kiWBtHD8gsfhjr6tREFbvfZSpM5nEtjcBMXmZG9wnE61qo9xzrjfCoD0U+7zlkkfZaX9g0Wf9u2gSGBiBRdJ8b4dU+n9B1d3EXDMoh6If7/jeRUoxNJ879XAw4pRjfYtIqBZu47A921emn5bGS7Wyw0dXW6q/XSvTp9ke+N5DVoGnRYu0ZsSYG27JtNGQe41MvoxofSSAmvTsp/9H83YvfgXxPjnXVHkQO0ly10eq5pzNTSfzEbCwJIibfjJQvC4TKX4hJ3qd+Z3iBRp1RPIPHan2/wN9OeDh5zgmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IZ9oAN02i2JdaTWyezQ7UmPk1kKYInDUHcbe4bi2TE=;
 b=WkSOdvd1cEkFmcbrkJH3GK1FL33BO6BZylbw0THmvnRKC7rnbdi7Z0WlDDQSKNSi+lstON4m4n8TbWCF/PHqzlfhuiRw34xV8M7MvQz3iF+QPpFjXainF8lDnIpimaZrC7i3ZP9ISXUpDetTgZoLYP66aihLRaqbCSildvnTHEFWZ1RMa/j85Fv0lmjLXcZ/egNf34Y7hxrGqB1r7/0rHX0BxB3pVuPwuonMVqzK9vc/rGXRiaF6Ne62ay90stGk4g2Qqemfp6Y3YkSXapeNWgeLvgisDkGHbPyvzbWnaiQQp6QeOKxWgMZ/0we4sYCWiJEseE0jQ3I4m4efVc646g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:02:51 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 17:02:51 +0000
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
Subject: [PATCH net-next 4/6] selftests: dsa: Replace test symlinks by wrapper script
Date: Wed, 24 Jan 2024 12:02:20 -0500
Message-ID: <20240124170222.261664-5-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170222.261664-1-bpoirier@nvidia.com>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::37) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 60523cbc-d8d3-4d1c-07fd-08dc1cfe4bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	USM4/kL4gV4KXCsEL37nSJBnoiKEwTSl7YcGWUmbx/6B2RBsAljomaE4BbiE8EO9bHNuBsszSAjjnI1hmGm8bXl1D4UnrxxsUz6iuI9Mf7P5DSbrnn8zOhPYNGnlA5b0lh97/3IQ9gdLfrIe5hM45X34skNXG+uRSRI13IaY/n9MENznvphncqO0Bk13qBiSqayWokZP9ZXAqCDZblPKPPzPKmBTO1v1tlxP1eQzawjSps59MdP/xta0dTH9GYGE6ejnKLWZIbSK8gO+zrSMh3yE38EDtv21AewQ6SDof/O3Giy6tFtSDYEPYXrk6DJwKkGcDbw9bUOuGraPhnntDZTajbX2cBn+ekHULnJe9S+kPtMEQkWbMWj4Eu4eURE5aizfcPMVjf/X+bte/UWJLH16W7RAe8aSqIO3JISTwDwXKxmztz10rSWleGT9B6pLVekMKloUxPydJH9SSTAk/fbwA0fw5SAQnt0RaIDgAJ1xQkMRxZsIZFKnvDcF2YdGngWIxNvyHxrDDiwoxSzF727FespP4whuqsIoViIo9i3/hDlC1DkmQc8pUyuhlaDi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(7416002)(5660300002)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(478600001)(6512007)(6486002)(36756003)(38100700002)(86362001)(1076003)(26005)(6666004)(2616005)(83380400001)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kSBemLXY2oXSs/S/jVgy+ac5mnJM5fxbQezNsKFAeUrys820/aTf3+6XtOFI?=
 =?us-ascii?Q?G2vtkg07kBKjDJ9mbMisEo8Hf0PbgWyq3e0i1BGSRX6UqPH5Brz/iRmCJ/eC?=
 =?us-ascii?Q?hKkbOCJKxSPuRkMYHWMrGijJPosivem4vZ3S4vkENosaQHsJbAv/aZOwAcYn?=
 =?us-ascii?Q?nDcLd9pT8MWPyUXzRt15aNgutuY0W8fE8k9WFNbAhAhmkhn6RZ1BP8b3qJvV?=
 =?us-ascii?Q?6cX3k3LKTd9sIx2ogk702zqhQS8HIFvfM09xkn9xh9SoGQz4BKzLio3tew9Q?=
 =?us-ascii?Q?b4Cczu5Xef7ZO2XxoFyE/qN2xwIlQUH9/J0CJSLB5hc+e27cO4FOv8cqRN1g?=
 =?us-ascii?Q?snqluhdY1QeYpJifdmFSsF2vQ8o7yG5r9DbbvWMu7L7PqD0gGVq+yRUlMHP9?=
 =?us-ascii?Q?GA1t7v6DP12G6JLr5RrgofxtMPYLMaIpynW+o7QOEO61pyZ/x5t40mCUN3QB?=
 =?us-ascii?Q?MeQVKuFTARaHufV1mIyAASHio539aKADRL511CBLcdgs/dFji2wW0KLPfyoz?=
 =?us-ascii?Q?QXj3pbz/X3/tloVeMBWdGutWN+hVj/v7CoovZ2mQxsrWN2S9vfyFTjWtE00S?=
 =?us-ascii?Q?Uc9fiR1L0zaGAXLlwlaUsu6b5e9qktt0vAk2anrfsunsQnW5r1G7ZccDEGQ3?=
 =?us-ascii?Q?3esboTGmX+oIxT5SJpbVtXepOv6sLkkgYS3F0IIjHLCKAvsFZanU2pcNHgy5?=
 =?us-ascii?Q?Hysq9qqjdx0hZAf0K2Woxwo+M2/kO5LhKV0+Amo3DpfGcq4McZOt35k3/6/F?=
 =?us-ascii?Q?g9gqYZGLL60xP2WCd+DADcdtBedNNf6uOz5S0hBU8qkcX26e+wfdYZPUiz+Q?=
 =?us-ascii?Q?3wZnHoDvxhVaxD3L22e2eUFVsA/Syhdb2rGLsSphuqoo2Lr/KSN27rs12EEU?=
 =?us-ascii?Q?66rg2HoUFeTu4DTSk2Iman0QyPMp1iH7SLIkCDYILKmUWHwegC5CpM3VcClX?=
 =?us-ascii?Q?yyrXM7iwynKEDJ4bhA8GHg2WkC/M8EjH1oMMN1WGLJyzXOgA0qBfyU4cU+Wm?=
 =?us-ascii?Q?IYZG02TfuDJwbHjxqPn8oPrbJ4aK0Yg8qh32giZUjTYxuWpxjwI3gvxUsXvf?=
 =?us-ascii?Q?7F+eN2X2Tpq185meZ/qTtwAU7v6LvaTc5vNQZ+MjbkB0frrcyln3qA7rakzZ?=
 =?us-ascii?Q?ZwEB3Jhemaz4P3ywvAfoDL7owY8QiooxLexwoNdo+NBAm6q947tiR69jCMie?=
 =?us-ascii?Q?F4lyLrpGOIEy5PXuP5drTCXjPkGlHL8kOnPBO9bGhkqjhp3pykAjakSEd2Fe?=
 =?us-ascii?Q?LjSBKPELFXOW67ZIw3oJE90zTSWFHVbFXevAKHgD5Mm+NIhPJQqW1x2p/lKz?=
 =?us-ascii?Q?FpHF4GIstXy+PB2j8kUv+50knywbwEKd1dTChEv/5dfPReNndgO371ggYwaq?=
 =?us-ascii?Q?xiMrfVCXwGJczl0LfIO0HDvZSTqDvuMg3GatDkBRT+3GlrSSiSpzSlwaSpyU?=
 =?us-ascii?Q?7rG3upd+prbOq6h/flDBWRq1Yq4PGOET1bGN8xqoJEI4FoAD6BkN5oVwsNqK?=
 =?us-ascii?Q?PnmMH6AMJLPFv9nH6KyTMQvyapUpEsPrQ9IND4f3bbwU8TDWx9kgi9+Y1SzK?=
 =?us-ascii?Q?qCFzuIY6LmcHGPssyzPkEMG3DGnv723xgZwb/VNi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60523cbc-d8d3-4d1c-07fd-08dc1cfe4bd5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:02:50.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+E3h4muFJRuJebzk5qCb4/+bnRolE0SuKZXMlldC8CDS35WxmXAN0n5nP6v7iVlyWwf4IsdgQT4/HziHKA3lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935

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


