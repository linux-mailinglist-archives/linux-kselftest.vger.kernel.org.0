Return-Path: <linux-kselftest+bounces-3462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6583AF1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA2AB28C5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F2C7E782;
	Wed, 24 Jan 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GZ7/xk+s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9342A93;
	Wed, 24 Jan 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115835; cv=fail; b=dR2Woky1DSkBRKhhjM5f0x3s06NesdZlzvyyySXSwzXzJS5jbgpscNQuoMXRRaYRmZFgEm5LCiUz7EuelxpxZKeyY2GmgwHgt1PicvmJH49s9+R4uXu6sSDsvRntMvuz1A4Arj3A9YPrSEgmTbyYUiH9WYZQ3HVw9V3aTu0E9rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115835; c=relaxed/simple;
	bh=XAAEW8FKo5KaFrpo7ZpnLrP3U2rrSawZ2m8Y8w2Jwj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJD4jBclOEVpB4mzU4v+sfjk9HNxq7mdsAsNH3AZQGXdaalJ+3vjlLwhAenVDezwkv0TinmvQYQp2b/jmFVKd+mm2Ijn7DNjmyCStih+ydovrBxeXv7X/IRekczFm/10ydLS8ibyfETM7JuPbo9XKqP4oZ6ktjZKzyLRUQmUqN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GZ7/xk+s; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWzp5xL1TQabSw05SYeGxbbhWOELz9LZleqsn4ng/8Gz7ojGmxWy3H6k9ZoBzADlzWIdlz3JrQJunQ95nJWKpQHwYxbs3eScvCvR2ofb5RF3+3/DAj1kI03ngv+CwXAVf5NVPxMoB/i8Wda2KeeMEtFnZjOARKF7Wk4Fne/fcwbK8zG+nrg6XUA10HYdsJrUsAGLpB+9JCQCuqN+lTjGt8LSayRuuJFYw6678J8qBRR7u7JW/aPcyORjOxgO22VKgUxVcuOgQhd2y0D6C5NtyJcDaVxA4ZpjX2hM3WY/ZuequPuZGyoc6oWlDJAfKTeuZUI7PiIF5m6ptmIe3HG7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itAIixG77wUhv2LVVUp3StYiRLE0EYtaJQwD+2XohfM=;
 b=RoXU/WAsh0TqAjioHVyq2bOE1wiTQXJrIHbgtUO+1Ftxm9VSlBGddd5CIxb/XH9l4wZ/KkW7j7f/Xs3GekKxlEzBoulKPRdOgKM/vjsglNTCkAfiMZwFmduT1elRfddC6/2fjqZW8ZDGhDvKyr05yatMyBkf2yPV8TyZfLcIdYXMCKzY5OIqdMehU130hTdnIs9cniyVebxPpYKtO4LDhzqkH5MRSGxVHLjipBGMSYkTcCDg+q221ooPRd9ljsARl4aIuzP9jZ09Zoop8QBjMUC4Fy2HLC3OxVhR2UgDeFiadQLx6WiHxYtF1FI8QuCIy/YpL2Sm60KEEhqeXAtAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itAIixG77wUhv2LVVUp3StYiRLE0EYtaJQwD+2XohfM=;
 b=GZ7/xk+sPK74fFunJGrjGLy4T3Jp8fmdg4cPDm7RiQ07ubDLXRnbphdJMXuem+ynHPtrzbEv07BLF5t1PRQJerb2gAOuCFu2QLSpXwXa4XYqc3E7lExVTAjQIiD9yRQCrW5iC6HjNrsrBesIthjac4lsQQfV7w74iEJojPl17xNIDN6jMEGreIK9yAix2oE3TzjkzeWdmQEA6B2np31ttU4nemCtZImZcUEQLcv87OtWD0DGdRanfg9Rx7rmBDxDJ8dOVUlyo2n3HPaWJf66jOhodbBlz02uLmTNJqongqklE03nNStx358araaW378OT3gEr1iNs04GMI+TJLm4RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:02:50 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 17:02:50 +0000
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
Subject: [PATCH net-next 3/6] selftests: team: Add shared library scripts to TEST_INCLUDES
Date: Wed, 24 Jan 2024 12:02:19 -0500
Message-ID: <20240124170222.261664-4-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170222.261664-1-bpoirier@nvidia.com>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::11) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: a614979a-950f-4d7a-1060-08dc1cfe4b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dqaAm2NJBU59nTDjmdPFG1fDK6PsDevVi6sINPFOW64X0gwMZUMOGobF/ftierlO00CGHxRTUtF5IJxPKRT96QgPclAQ5DJeYHt71bVYCOuQXQPS5JzxSih3jYOlO0oYJ3RwOE2ekWqYBoL0gi34XdM8XE/mgYdIBBGt6oYe8IpsxmyvpqjQNq4d91SB2tIbnkIVE3rbScZIKD6SY9UV/EpC1WP2+Y87cVqFWZaHxgBnLO4mF0RhVTh6OrO/83lICxBiyWvAQDfbCzBgOcMSI8YgK+ImnU2/nHt5sozrwEsaJY6wuELo9Ge5PyNO5FDDvE6hVdeO+hQvdv/FuL0QexDwhAMq0dcZKJuZxmt1gCaft5FJI5H5CAj35Ma0QpeYygI0M4IHTvLuHdfAvZU5BvstZof1NngRSNJ4jEQQmuzUkqenmk2ST7BYlGhNAt8+cwhr4yI2pcGh3uegZwvSm0neIJgxgNGzOgAQk2eCSNAft3dndYr1yqdm5c1EoHRTxJowHVLsq5wxqToVEshr4R3vr9yBgcIoGiLtPfgtU/ARuYwe949zATUOCdYH+6TI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(7416002)(5660300002)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(478600001)(6512007)(6486002)(36756003)(38100700002)(86362001)(1076003)(26005)(6666004)(2616005)(83380400001)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+B7kAnaOw5jex7O2q1VtrdPirorz9KtDJvlZAt94wDGDGCQH5S4ZtYgHTAuy?=
 =?us-ascii?Q?dBiqukXBjWsOnm5eAUvH5risj3ySescNa9xtpYfgjA7R9LgIMT791LxSkxY6?=
 =?us-ascii?Q?t/BsDAS21S0Y+TQ0Bm58VmA7lgF1IQWRqTr0cthQlbYvKUZGj2DBVsuhwash?=
 =?us-ascii?Q?vbW3LBMxiapccnN94ESUoOvq4NsvSbc4KKE1NWmerIVWjKd6+z9Z2bYA2sVA?=
 =?us-ascii?Q?FEqRi7LSCiarb3Zd7QQQWjX84AxJImURAfskm+nByb3QPo2Ggiq5XvFmBLD0?=
 =?us-ascii?Q?TmOsMvR5QVgFPUx12AA5jSE1nlNZGEjfbOHrdz6kSrHCQJ+SWRrV3ft40IV/?=
 =?us-ascii?Q?OApI1kYsGLAfdoFVE6afzY4HwoFP1foPzhWRCOQpusEuRcgg7BaVuSa+kBxF?=
 =?us-ascii?Q?AaMO+W80zszQS5fRF9Xai8u/3i/uKP1EeWqP19nTGWLZ8M9Hgr5za3xM50hB?=
 =?us-ascii?Q?f37MyM+QCo/r/T8GVE3xThJ4TOTl20SbeFCXvK28i9SzZn3OVmq9T8nmVjh9?=
 =?us-ascii?Q?TN7yt/KOaZdGpkfE52IkZN03AcElwS3OUYHRiZDkTJ2pefL/fAPCinEEFDLi?=
 =?us-ascii?Q?S5tvXJ5nCCHg77Ly7xx7EFT2QOwwCUiqTr8cZZJc0t+UtMbBfsuSuq7hkebg?=
 =?us-ascii?Q?/Savshmx/Z01vuHF/g4LQ6dptQiCpkcgBFfP2WR3r5nTvjgf13j/ZA84B9lk?=
 =?us-ascii?Q?w0AZ92s54vjzVVYwW/8r3QiaUFRNsag938aH2W9l8804LLy/P7QkiZUfuEVH?=
 =?us-ascii?Q?TAqUKSGGgHMmfBdKAY3C4OP560G8Cno8Q1tUk48L3+bPA6CoJyykJLpRgdrA?=
 =?us-ascii?Q?m0KsYDYzqsxV8FMK5UTsqkD9EZQjZ+OmmjlrCeWyBBUGkFpPg6Llq4Mav9WS?=
 =?us-ascii?Q?ug+DrweYYIcHjplgqmBpPrWREr1276N7cgFjm5jEsu6HncqGfZ2RAX2AXEjb?=
 =?us-ascii?Q?iAJG4ahHRCphUGuEZBe2J31Ic5tgNs5TV5l8lBXa4anHLsbMLCZ7O0s3HfYD?=
 =?us-ascii?Q?jBPGHXv0UEkoPmWmmLHzZBWhq1zpI3ZQcu6yiIxlGWd+NhHjcvMF9QQLRssv?=
 =?us-ascii?Q?ohLzklxDc6ZHfpqtHMog++MABW7EJGsRycG7eYgDxAFg8YpwIrE2F6YZ7NG1?=
 =?us-ascii?Q?4qTbXRRJ6oZCdC7O/ELKNkyRHuYJTMGF8bdjAAZeV18ctkLduv7g0K+Vg3Ok?=
 =?us-ascii?Q?3fIg12AZPVR76RfXlrljXHycyuWKRrqD5FfuX5K9VhKKXJqHjfORxOYY9PgL?=
 =?us-ascii?Q?3X9nQRwRlyG6tXE3k/VkdJO2V5LqrPNbDqBCgM8tUorWYA8IWr8+tvrd8jti?=
 =?us-ascii?Q?jSr8/L8hr5yYkzNrZ0w1ETrLvrBtKXQdgrKxV5gv6DsGWMEkC7nP4o4QEsU0?=
 =?us-ascii?Q?7lVtl7euzK2MWtiNOn2ALkOnjke2vWjKHaQcVxPFItnp6AU8l8u8kCMm8h/g?=
 =?us-ascii?Q?EVOowhIl7PFsjuO1L6GYHVPPCh0UM5+rqPIIi76kV2DVOQtBC5umKb/Wzqse?=
 =?us-ascii?Q?vYFWkFj64YeLMH4qe7p+z3oivHaeIH6sNteJa7dwX+UiNPw28yPCiAX/sb+S?=
 =?us-ascii?Q?jD6+uYF7fCGsL1+qtIJOFgENvN9vGVE/LpFHdFDB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a614979a-950f-4d7a-1060-08dc1cfe4b08
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:02:48.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VsapjlMoIoY5qqgDQMWCjZutbFIZV4ZzmcfCC4KWr7EXeAAIgMYNUB1AsdBFfClS7NYGTZjZd8xbsWQ+RQ1Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935

In order to avoid duplicated files when both the team and bonding tests are
exported together, add lag_lib.sh to TEST_INCLUDES.

Do likewise for net/forwarding/lib.sh regarding team and forwarding tests.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
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


