Return-Path: <linux-kselftest+bounces-3650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55B583E6D3
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 00:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C81729136E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8E5C610;
	Fri, 26 Jan 2024 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b+5TF/kH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310E5BAD3;
	Fri, 26 Jan 2024 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311324; cv=fail; b=A6/pt7EejX0OIrsKelY0GiaM42GVlOrjLl8suYsdFPLL9MB8BBPIo0nv3MQ25+uW2h5adY9ZAEUTb1FdcYjScu9pvyphOC9Lr9DJJPWRAzqmZZk8Yl1vWXbgk0bHwkSlJixS/O2PVqJOZA1tJItKgWLOkOyPFhkvdHLZtHj0rEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311324; c=relaxed/simple;
	bh=cA3k8LWm7VLtEPIYorvnev/YnU8E0Wk2+xw2LrGnWWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1uYcpAJVgkeKW3vaqNFMJuslccrFCYzCox/0vu8XnkPj9wB1KkFfZu5Yn6w06ckb7+oG7B35hVmbp2nG+MLeTrLuLHpLouncuXtxvKZOAKzYdg0T/zPAyuaZN8kjXspShFkGL7L13ReFCJflUzw8Iou0lgu8fi6R7UIKHez9Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b+5TF/kH; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP4dp+LnYt3XFLn2267IMk0fG95MiatqgJ2+acAAAVhXKiE3c8HnkjDPI2ZXL9cCvq3HvpiEFM10uimEaK29XmIo4VXYeBhwljlIoyAbK9IjUVdHhx2duslZrdo5HaoxCOf36dVvxStz+4jzy4j/6eHuU4Lo4pOZXZqmLNKJbmuVrwzZAHeEKLxcVv2ZCLBO9mogYiRjqd5GGm4Hztsic1yHELdDsWOP2ozB3YXkkQ42T9N4QfveQ91PQvmM2xrQKATFFMKgOvpD6ZpuLI9Nqa3979M/ovsydEu9fMu9jnIoNOoKTtcqd6ytUKCt/ZPnIod+xnX8o9conJx9xueXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWcyj8502/2obuD71VFDqmW6SICIRpBNjekg3HOmAyc=;
 b=O5p2z4SL7TdyFb/aZic689iJhhiUNYmqvRF1CPsFo2M2xJtxAbhYi7iGen9JVUnICH32eeBEpYZ2Qx50KubfHXXLwNADd5ox6zMeLDI4+ShUmFoyTB/SC9I11Og2372FY1SvamNu+3TceLf+OVxKtzrvnrMVVhZa9uKzNvTBJaI1hew8pTslDbeFru4UNoWUr22ZHPWXgHHH6BOwYOhCJa4qS06HyZ/7Y9HI2ByMyN3UCeNNiKlz2+guDsooJfKWvS0FJFc6vAxy+sPwR8cqceMduHe7IS8mKmOavKkdc0bt59lmiPgWo116mrEAZdlsq5Epas1fkKCAnZROxX2UFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWcyj8502/2obuD71VFDqmW6SICIRpBNjekg3HOmAyc=;
 b=b+5TF/kHGH+tcNb9W8VBfVUtvCUTvOZdCuUswJux9+k8bH/vqusY1VlAAff0O+Mry5bdSM8MXRVsSUqjGmcp3cccYN3oCk5qfv2wG7cCC2+mSEGybY+kYY4q+NMnXrTrN22p/NHbKOcXX8m9NOAFyGCEI+sr3qCFKy2Pvv9upwojnRCLw7UsVXP1MjnGhW1IYih6P4L9canMTYw8rB+yW40MWw0EUcPNVl4ct/1ZpNb02luYVwd+iIYau5rzdf2VbQG82pAkTXmiq3jekXeFxh1mXmRZLqVobTETpeM+V3DXR8FVq4AMsFS3OV7n1BiUqyq7cpqH0WJqlV4wd1FcfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 23:21:58 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 23:21:58 +0000
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
Subject: [PATCH net-next v2 3/6] selftests: team: Add shared library scripts to TEST_INCLUDES
Date: Fri, 26 Jan 2024 18:21:20 -0500
Message-ID: <20240126232123.769784-4-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126232123.769784-1-bpoirier@nvidia.com>
References: <20240126232123.769784-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::8) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c2f0bd-86a6-4d14-aebe-08dc1ec597f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gTsuYngUkbLirzcnIrSiExx3k1Cp6UILC6DcJ7j05Ky0nyi8g5+bJWjG2uyoagv0z38ydBRjEH27I1+Q0jW4LSk10JnKpAQfeg+NTEl10eROfufbqCY4++NuZijngkSAyTgQD/BRl8SF1odOmtcnXYzs4dhKb/YVdONAFyTndCNM+fp8RCot245YekqqnQz4UyENEeTr5TGxyqVIBXfK21JJ/KOTr5oTTm4cdlynMH1WMlDchDb/1oOKax95LDF73u6WpYqNYo/qaQqhN0BMm2sIB+kBEj0SPsGYz2sWK0PLThJb/bnVSyY9gMdWOP5L9Hx4scRZfd3BPYV7xpJgvZq8ZnRt19zmbQAwDgffZ8gYtA2/dnozuFyW2X4nQ39u23qh2m+6lwUU5JST5JTSzV5UK4THF3z9+KoH4+jVnqgEQ7RGZ/9/JYs1Hvc5biusVCFcsXkBxFaxhYqo8oWNugFHNcFkb02jHxpJL4kHVmfH9GUYY+xGwmW2W0VWBR08+xKUPF3EL5bDdufPOh83JgvfucAqsBNfzUPMWyYjIsd/TSGhZY2K/HM+cXOjPU5I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66556008)(6916009)(66946007)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(6486002)(478600001)(86362001)(2906002)(36756003)(41300700001)(7416002)(5660300002)(6512007)(26005)(1076003)(83380400001)(38100700002)(2616005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nzv0SkcoAuRsjdY22tCN0at/o36VwOxYxx9Seu8ygtf5kwgNjx/ChX/ZxFmT?=
 =?us-ascii?Q?ZKAxz4Yi5QF0G2NFe0LkH2KiavnNJzty9TjJ2G1piFblmqMpvgWwQcMsEoY3?=
 =?us-ascii?Q?Y2oSWw2dttPtGgSPRDMurClRkyzyoA92tXsCVM79IAvflmTdQqKL2JPAykkT?=
 =?us-ascii?Q?wQCK5+DMmYrhOkkuAIqBAXm/qQmHn+EcNBdruBvx7s9owkWHLdfrHhZLm/iU?=
 =?us-ascii?Q?IWe6COhFODgqI4kECTiBLEmqU58zk/fM6sOjZ4OGQMJJbLB0vSZx9cBIqLd4?=
 =?us-ascii?Q?AXD0AW1ygyst8exF4koGg4rdD/eRDPjBoydasTFytg8w7+wd9peDGk4hGv/j?=
 =?us-ascii?Q?/7uYJZ/gkPM9Y9VZUXIB4Pie/ubbvzLXmvfnZ3RhDV2sp2p7RqarETiz6HpN?=
 =?us-ascii?Q?QbKMFBOBoh99qxhSOxxh93o1dKwgr8i1kvrPObfxm9MhREeVm+iv0Fs5Z/Kn?=
 =?us-ascii?Q?eJrLio3onZTh5a1U5H7i9ZSoX7z0+/4QojA9VGiD3zqCxKszbxrSreZWF6e0?=
 =?us-ascii?Q?XtMiaJszW1kqLMqqQA9I2QV40IsO+wgfDBvs8/fVpswprROk9RMxQrl2i/Ig?=
 =?us-ascii?Q?XJeOg/MS1FsHHr3WpJoxyzA9xwa7rkmts1gQxxx7zGSIKbzGhJLJSRs0kJV7?=
 =?us-ascii?Q?WJp+b/oQ+W53LcZr40zb35o5LLFejuX1V2og7zLUaAtZq5DSQKukZkJRyd9Q?=
 =?us-ascii?Q?Pmir3uTKI19WhQNE23YBAsdHWJt/6ceu8ezDkPvUhGKm1Qj1CcsWbaxbeP9X?=
 =?us-ascii?Q?4erzgmz50JZb6VuQnqQcX0LLeMG91Ra8xSfXEq9Z7ZVwM63SqOGkPCp3BHOk?=
 =?us-ascii?Q?+OKd3qZshPKmYNFTdiNcUCTANLdqwIlXAYec0EJjKHvEBsuN5EUeifKzsmrH?=
 =?us-ascii?Q?b6Pxh+HMAcMpwBKkB3sPo/QW2OhA7+y1I4DUFwCJa0OZ7knQUzttJm4+Tz0W?=
 =?us-ascii?Q?B/nuCc4oi3JZBEGyum6Vy2PiQmd8jp4WJwH+vuH26EyHfmDQFltBO7BUYgke?=
 =?us-ascii?Q?oPZ0uJH7leyOaCWTC0MZ1pn8INwPNnY+Vqi3nAB9NNGwp3+M9EUVZJFIUbVf?=
 =?us-ascii?Q?BdGmRQnpwddhMy7j0Ki7SD9rmmCIeaP2KqekJR6+xSXa4BL05vmnzJWZjqYm?=
 =?us-ascii?Q?VGrKBLopa6rJwkmws02jxUsFa3bcPlM99Fe/NBDnES2RpJA18qf0bWxEJ0Dy?=
 =?us-ascii?Q?iSdeMtg3zMSjGdrC8AuxKcgpjxpTnI3Sp4+jqVQfW3C9cCT3gxxT14595v0r?=
 =?us-ascii?Q?QVY/3JKpCrpH/FB1kv2ZS04xsCWkXmS5szovHfGv8UTWoKpJ5tvB3neLKqfe?=
 =?us-ascii?Q?0nNuiVGqJ0AOR713OA//GzN6aGQ1fiAJUjk7em6l0opF26neqmcgoy5B2wsO?=
 =?us-ascii?Q?EonPfk6dzkWm/OO78lnSNOi1syqsGflAhHdMP12OGE8lqMiv/r1JSMKIwScj?=
 =?us-ascii?Q?oM3u7KCQop7DbWZCjig/ANQD7hlWyIc2sdXSCV3QxGACaou5aEY+8cKHpd5Y?=
 =?us-ascii?Q?eppBzh2ReLUnBS/xdt+XKKh2j5v6elgpSr3lfUOhCDCsSdbWUVj/PpgG1d5x?=
 =?us-ascii?Q?5/te40arR7pRv/UMKu+6LYdDhbC33ct3pdhfsSkH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c2f0bd-86a6-4d14-aebe-08dc1ec597f6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 23:21:58.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daTAm2YuFwZsXiN4/HyzXFOS5roayCXWQiiTDQOg9oM7pf1PJ8K6Ua3MaSQrJuYUv+1kk22YI1iYwCuFTOydgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

In order to avoid duplicated files when both the team and bonding tests are
exported together, add lag_lib.sh to TEST_INCLUDES.

Do likewise for net/forwarding/lib.sh regarding team and forwarding tests.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/drivers/net/team/Makefile           | 6 +++---
 tools/testing/selftests/drivers/net/team/dev_addr_lists.sh  | 4 ++--
 tools/testing/selftests/drivers/net/team/lag_lib.sh         | 1 -
 .../selftests/drivers/net/team/net_forwarding_lib.sh        | 1 -
 4 files changed, 5 insertions(+), 7 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/team/lag_lib.sh
 delete mode 120000 tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh

diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
index 6a86e61e8bfe..708bdfce37f5 100644
--- a/tools/testing/selftests/drivers/net/team/Makefile
+++ b/tools/testing/selftests/drivers/net/team/Makefile
@@ -3,8 +3,8 @@
 
 TEST_PROGS := dev_addr_lists.sh
 
-TEST_FILES := \
-	lag_lib.sh \
-	net_forwarding_lib.sh
+TEST_INCLUDES := \
+	../bonding/lag_lib.sh \
+	../../../net/forwarding/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
index 33913112d5ca..b1ec7755b783 100755
--- a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
@@ -11,9 +11,9 @@ ALL_TESTS="
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
-source "$lib_dir"/lag_lib.sh
+source "$lib_dir"/../bonding/lag_lib.sh
 
 
 destroy()
diff --git a/tools/testing/selftests/drivers/net/team/lag_lib.sh b/tools/testing/selftests/drivers/net/team/lag_lib.sh
deleted file mode 120000
index e1347a10afde..000000000000
--- a/tools/testing/selftests/drivers/net/team/lag_lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../bonding/lag_lib.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh b/tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh
deleted file mode 120000
index 39c96828c5ef..000000000000
--- a/tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/lib.sh
\ No newline at end of file
-- 
2.43.0


