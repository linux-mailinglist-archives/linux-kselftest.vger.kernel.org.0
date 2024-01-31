Return-Path: <linux-kselftest+bounces-3846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7DA84416B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291B91F223B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409B82862;
	Wed, 31 Jan 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KMaPGoPZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3C80C0A;
	Wed, 31 Jan 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710203; cv=fail; b=kbp5uBT9kTYNC54N/6kabszz7WVy1pcy0VmOkFlSfZTjL54gEGiBng/Ubs9W2jfQyqsnb7KIpm2s+a4I1n84auU6AHwGGfYSHb2hBek8jXiW+rrs2uxTbqdCU2ErlUAlUWU6HyipVmSTyohYwVtikuhftprj9SyB21mrYZywsdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710203; c=relaxed/simple;
	bh=b+C0Vk6oz2cX8/kt0a9y25HR54fa9Cfl/1cSqcOocZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKQyA/QXdoWHhguw8nUaAjCCh1oPL1eHat7rwwPzxlO5MSNGLe2QNUPIye9VzqqEabIOtvdfHXTP4gD/Si1cRtbioj1rA4BNd1eDW2V3fSY0m1oXig43dLBbT4SFXckrNnXQRjNX49XkaCSfVaA+S1RxVQnCcw0A/ZWebizk0Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KMaPGoPZ; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d94QKiT4LQ+tGMaSdBLD1gSX0d3+Ejv/hgXsgHulchtxLVY2al6GPUoys41SC9/cqyVAMKCJ+6jlG+NLnFeahMJ4fPzUzdhP4AwLOsalwbWDPXqsLAE7de9SjFmwA5r0Vh5IziPl9XyOhV+RLh+aGrM3b/HiBSOQ/fCVxNVhT5f0dHB6pI65Jq3T/oUPp7rFgzh+h+zhRvzy7dgrrrTFZQWXrtbWRqD95yAVKJeGseCHrD//CtS5q2a55WHPn5FT9TpDTb0QdtncVymZer+6YzSV3Kpen6gf+f1nu7gBacFu+NZcC4uGB9HDaPjDjZbEWvfLnzVxnjJbXfB4uAG2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFF9Zb+0sVfdNxiee9rR73n2+GfQkMaVU7qzAZ87omc=;
 b=gOmhPgHM0HQym4zpxM+WIjVdazv1xR+++m+IfCF36bM3PB3vsbNXjFnjIS4bl+kHArOoMNmrDlYXhXMxbw9t00CGmtfEtVWmmndRA9Hqz2BH3B8oBnqzO0auTzXcSHUzqlD7fzbVZbdb23pbkL5d1AZN+tXeTHFj3NHV8/X4hNVFzKJGdH8wI18w3HsJ3ISgKEliWcM7BP+34C8u6vF1fjukdFkSQOZf4T7N1smRiyvQpJ/qj241OwCj605XhVMXY1yl7CFG+bZUv6QwACHukromcTm3nfa8S/70VyaF3iR2Pk0uf9vLaAg3QcvAwie24Z8yPjRs/qiH3YdFtalO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFF9Zb+0sVfdNxiee9rR73n2+GfQkMaVU7qzAZ87omc=;
 b=KMaPGoPZ4RSXJv0cLTSaUObgCcT23Z29lLD10MEALmGSGP2CozUahdoPJb09GZUeFjOJDfEhRfJKskVHqsJGM9JRwfNOtwwmNTbFh+pQ0BeosSq26GZ9/m2GT0GXdUFhSihYO7GQo3a2On9Bnw1AdVKZtW4zhKSZCX4MB/7KJv34Tw47ycwppjqUto2mwVj+ond/vSvFEvLd4ASKC2fANcLZQjJZTzxkPf0cbehhWd7N/XAFctsDHq5dX6KvzRJvTq3CfgJ6ZGUF2kprRYVV363SX0Hr5wZ676H287rJ1H3IkOQbLDh5zrGP957qZN/IFa0aNFOZ58OkXTEhpm1/gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 14:09:57 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 14:09:57 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Coco Li <lixiaoyan@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/5] selftests: team: Add missing config options
Date: Wed, 31 Jan 2024 09:08:44 -0500
Message-ID: <20240131140848.360618-2-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131140848.360618-1-bpoirier@nvidia.com>
References: <20240131140848.360618-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::11) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a0b9f9-d2d9-4711-0e3c-08dc22664e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jW9RkrpNrEBMWOje6JwOkBnCAAJkG5eZfcvrZ7c/QVFVLQD+d/+tI1Whv0o+mM7WhOPlupzOmEzarSV/ejLvcxZx2zUXr/yrvDmFdCIStfvLcC/Fc8XsCWwaaaFwkJtiF6XjCxI9vZGf93KfL/1t0RJZf91AgvzZFdFk1XLTK3m5cX4WkT1/SOgwa+eTWh+ShIobOncYiFFIWNGeNZGCrPeW69yNCAtzvj+Ys6O8JZ5zNgMYYf+Bq5q5dZ/p9ipBLxeMnmF12DozEt3OpOWcVM/mlF+43AVoBlH6khk6v1z403AD6uTF7kqv55hapJ3sj6vSThn32iNmv9Xl/D2pKKiVe2znhhzZC1fUPviyodnYeovkvqTzFmTp8rUVJRx+4ydrxhoBFuHWW9E3ePMnZmahUKqABLnC1OJvW44fWGRYhYtIrsMqACMtwRZg+AQ9jMQqjanfV+LdM/Loxz8kumqwINIpQ4ZGa9e5e7CuJjGPsd2LvB00ctcA5Ly8rtjBmAz8Cnh1LnkdU8SKQlKtOtlNqzlm5ddiUfjgeNNfPct0JLQxDmAnzCIJIb9Am6YB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(66476007)(2906002)(7416002)(5660300002)(316002)(8936002)(66946007)(6916009)(54906003)(8676002)(4326008)(36756003)(478600001)(38100700002)(86362001)(6486002)(26005)(6512007)(6666004)(41300700001)(2616005)(1076003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0VE74Ika28aBCabClH5n86/Va4l2nfl30+ikMWkPbHNUqGTgBbI1Q6KRdper?=
 =?us-ascii?Q?hVnDBlRiYOeB+ZDuaKygbovoptGUTYejqXQeAwsDtcWNCfse78EMMb8kbtgu?=
 =?us-ascii?Q?boyNDp87PkFkTmpGON27+VC7xHzbowShZZ1JP5UPA4qhJuGnbJIwhi3+wEcj?=
 =?us-ascii?Q?AJckCX/rDnnECbCQVOYpNx1mTggeqx1BGGUDTwe3ALwR6Fw8sXE6fhRF34kp?=
 =?us-ascii?Q?8NyRanmeGFlDNawyOkex/JYTXeVO/ZuoqBIRxhpn28zD76VAuHLxPQRBFQDu?=
 =?us-ascii?Q?i1zTPqdTWpIdikUuxAn6Pc1IY02BQ/uwG4qdK39PfkDOm9JhNY4L2OEZHMmI?=
 =?us-ascii?Q?EfRIt8kwDAjv5zCi8X45CdJD9YnJkeWFmcrkuwLjPIWQE7Lk4Ili08tw8ZzM?=
 =?us-ascii?Q?X2YG0UBJ/KJyyV1IZtNvE5stToCWk0SlpDysAgP2MASQFXDALEH9VHFix98A?=
 =?us-ascii?Q?OL5vN+zXIchofQVn321nV3H9itBRmpYlQtSoV5O9NsYitmOV4wcgwYdQGKST?=
 =?us-ascii?Q?gO3/PiRbCtXGXtxoIXkGtqUfQabANJhZiaE/Cs9SRjR/J8nYsW5aGvgchThh?=
 =?us-ascii?Q?wRmKnctPdMV0sKH3H0AAyrYymXLGJh4IWdnuMtVkfwsULEuoVUeCCvGaF9En?=
 =?us-ascii?Q?ulaSzirPpxKy3cuAprEY3+juvZ2g075V7EXjf/pa1f34dORk0ojhwOu7b8AF?=
 =?us-ascii?Q?8C/j+TQJ9f9JtCtnSP+ajqmTzFBBI3tmUBZ7sGY9zgwDK34XNYWFUfkDPrU7?=
 =?us-ascii?Q?OvSTOQ85VzhjTzsJMhjSmqLbQmSZxtF5gkDHH0VrL5VZxARSO9fvR4dIL07r?=
 =?us-ascii?Q?fvKscg+kkDGfy4d9GoCejaHkBUT8We6xU9UA1lExKk0MgEya27ydc3SmkXev?=
 =?us-ascii?Q?5sHt2AxyIWulaj34tDbr/k/1NOB2qiJ8IbrJ6NF8J/wVf8dGcjM/MvM46JAK?=
 =?us-ascii?Q?G1uUBoSS5TIY0s8kGtPFTg4gIVVLVAyQ5TchXD2BLrfsaQyxBHcZWZ1DNw1s?=
 =?us-ascii?Q?cQ6OTGNZl2XJx0EHYgOcJs23gEB29mwySKjYDuxc02/btsJ4OwTWMPVAfBR7?=
 =?us-ascii?Q?x3GO/EQFthu2jW24gMnkBUhwlqxU4DiVqRw/sPGY8NxLgVpTHpUPfsneA0em?=
 =?us-ascii?Q?ypXLu9+B5oeibnId+dSI5jUjtfWjsN5geaHLXbQLCu5OT6gQPTFHv6IqdjoT?=
 =?us-ascii?Q?HcmkxUK66TO75Z0lyUfzkb1ncew2LmXsmB81JiFs0S+hwOMyWLHhYm6ckHYp?=
 =?us-ascii?Q?SUaa8n9e5fRS848VVZuP1hoXvrDa26OPDPd+MjWTmijdsNgmWq5yzdVcqOdk?=
 =?us-ascii?Q?Plyg9fFYOO08la0obiEoqYrGz9u3BifGnzZvvB25gOLIYRWIAtY/uOSMMbN+?=
 =?us-ascii?Q?+H5g+MPL2IvOge4jiO+gDhHAMJz9ueMq8jrNJ5fWqqnovYtUgkBWcLZXtCzg?=
 =?us-ascii?Q?xYYdyUGUsOHh9QWt7Lxdf6YAcIv/FAYLn7jEcwyR5uAOKKf+omUhPpFlpiiO?=
 =?us-ascii?Q?ftWcfg59WCdyfuXzCYYPv+mY1lwsBkMXP8f7ya5mREYq+8grOkxni8GxshZr?=
 =?us-ascii?Q?i7InoeMPlg17iwB3yTWyzaAexLugtHP5489a0Kyv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a0b9f9-d2d9-4711-0e3c-08dc22664e11
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:09:57.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDbmjvcxseEPHAg7cUf7GfKcUzANFvLIN7Ba5D6A2K5POgKtvkvV9fD9FwpH1MDZXnRYhhGt18s6XhbshELqcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

Similar to commit dd2d40acdbb2 ("selftests: bonding: Add more missing
config options"), add more networking-specific config options which are
needed for team device tests.

For testing, I used the minimal config generated by virtme-ng and I added
the options in the config file. Afterwards, the team device test passed.

Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list management")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/drivers/net/team/config | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/team/config b/tools/testing/selftests/drivers/net/team/config
index 265b6882cc21..b5e3a3aad4bf 100644
--- a/tools/testing/selftests/drivers/net/team/config
+++ b/tools/testing/selftests/drivers/net/team/config
@@ -1,3 +1,5 @@
+CONFIG_DUMMY=y
+CONFIG_IPV6=y
+CONFIG_MACVLAN=y
 CONFIG_NET_TEAM=y
 CONFIG_NET_TEAM_MODE_LOADBALANCE=y
-CONFIG_MACVLAN=y
-- 
2.43.0


