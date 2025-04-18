Return-Path: <linux-kselftest+bounces-31142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44667A93A67
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A328920C40
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2B521CC4A;
	Fri, 18 Apr 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HvWNoB4T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471F21C195;
	Fri, 18 Apr 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992647; cv=fail; b=lttKcVXu6Kyq4+LUn55hHqRzTmr6K7il3uckDgTU4HMFTFur6ijjdzhcFwc2yUTxJ+F4mZcfSnYmIYYSe8CfYTwCcx45X/ci2yjJQwvG4l5NP1nNy2BK5t5TipXSqDePkfyFv7Odq8epBktS8KKWuFJNFZJ+O1OJmddo67eoL2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992647; c=relaxed/simple;
	bh=4uKQLHu9ErUqylJTYJa2qwPHIVmJendn1wsCwPIVucc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYRS8C93cdF6QqGYsUDHa8RH1oW5/1m4xQCH3y7MSNVideus0Sn2smsb2SIIl3pr6YdW+S+o+SR9YDqjJhbLpx11VjawxxZDAAbuZZ2s0caDsOApQ/Z/pwZlnRykPh387LRcDdgbLymql+P7McTBEr6cAXH6YP++crWQLMLU9es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HvWNoB4T; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh8Hi1oA/javOoNvrE+XJtDThrZCTc7Mm572InnhG5vvCjyWumUpnE5NVDM25vCkyKRb8Ms+TgJ+w8LV7oluT1QKwkKAk6QIBQPTM2Y/ki+3U6A8FypQvB9vv4JTcpEkcTFVzgvRAkZXg5RyPYITJoiCyiZmYKtJnbeijvq9mZq9Dh85l0j3SbiYMbyaZ+bgMcubwdZdxtsxAQBA1cJLZ60km2QhYBwYPpjhqeGZMyRwvgxcmgpN/TUPgNH695L7ll3J4XvUX5+0sH66+Yu6bDlD7SJ3G4xkGnxrYeI+hITJZETa32mku93RDkjyQaTLkA/OGok2FQnkO0n1RZ9OOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KfwQ9RJMtB5Am+gQtSg3UVueRQOr5TpM0BRFUFqOjE=;
 b=SEpoaBxoKazpqV6NpcFBORJahiDH4JeLIG5MAZ+Mz76adLgokGs1tTgqoYvVdJTiuHcMlje5C9DRRuiU5mQt4NSqRfYtcvm5GngWSm2XA6PK3UJop4CzgCxxQeQysfOr721NsIONN/h+33RsYS2IVHrJFpqrBcQUSussm0BJDA0ZDPU2DaXjqhmjTSiRfPYmAdPZFgCggVcBQpSgaT8YhfxcSqvT1/81+9RrFcuVDWmum4Xpuh085e9cD0lrpYw56ngWkwRV23rlZR9I28+8FA/zOVGvW8av3UlMrs23VBiblFlc9NuAHqvSoWm16IL8Y8q5V3jpYifCC1VQ45SUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KfwQ9RJMtB5Am+gQtSg3UVueRQOr5TpM0BRFUFqOjE=;
 b=HvWNoB4T0QboY++A3xXfEDoi7CXny92467E538/fG3cRHDH8yChigExOBVcdEimmv//ZhaT0zvVi/9tKa6y+J1iSY32YZ3sgh+MUzpwHWYFm6htjkHwMLowTLAaGmXBgdw/3bUsX9hsLMgluV7ijbyj0gDlXBbUd0suumezJSDewUUHfSfDck3IoM3oZT4P03QgTzYZi0/3FyrPmQxPQ3K3sS7R0PZiw1pjC5ksHVzpnw54+bi75ksAsufTYWN10dWcZ04kqmUOC1emYWWcJ1KXR6ovEUUyR3OYFmA3dg+sl/CuS+dSDBATc39pxM7BK4EAI83R75/KIkC56D2r+ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:10:44 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:44 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 11/14] torture: Add --do-{,no-}normal to torture.sh
Date: Fri, 18 Apr 2025 12:09:43 -0400
Message-ID: <20250418161005.2425391-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: fef0e34f-36af-49ed-588b-08dd7e9392a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zgGWPJ3rWI3O4qiuY268RaXWXG8Bui3euyvnDjnx698fXdYMwGb54xSklnIh?=
 =?us-ascii?Q?bAjxGw0lGXDgcS7U7MpYvc/nDx6f6eYR5oXBUR1ba85BA6ULo67dLPKFXXHq?=
 =?us-ascii?Q?aTorr/gY5oni23W3AjiBnYV9UWAC9mHKkzqVI2zBKT/XMoM1w7/5PEGVzv88?=
 =?us-ascii?Q?SxlisPEZ3mIX7Ki9FlGxllW1b21qYDcwebt2vJ5xPoVHnjjTrOhqdLXpeIuo?=
 =?us-ascii?Q?NcLYipn26nkC66KfoJ9PWK7Kz3R7qS3fnGaJGu2csJYRGNa1B7rnMeEXp7rT?=
 =?us-ascii?Q?0pe/CDIZcC+ZlhqNY4Rk8qv6wmxXWDdIE3g/zI3ArziU6Ob4hniS951RrPwl?=
 =?us-ascii?Q?1c/1C8G9VIb5L4MKOYwnx5IsB7/q7VQqOkkmfYm2VFFxwuQi/t9PptsKXH4I?=
 =?us-ascii?Q?Y+mzRmAwOPSkN+FelOKf0/fJVA/IoNuiSNbXLZKTCeLtOGtauVnxTMdB/ZHq?=
 =?us-ascii?Q?YDKf0PxPbKZjdvDDOJY5kqP8T5XVTMRfLUmMbrxBzCNeFaWi3S+a5yMDwYJ0?=
 =?us-ascii?Q?CeKm0Vx7Uiu9XKLehtbFa4jskZGoKYBxX/DE2MeaIU81BqaVmLcO2hBdL+QF?=
 =?us-ascii?Q?ZfZw9u7UF/66HefSXidWCmFa0v0cMczbA/1D0H0d5WgIEcOK0/cPuK8ks/XS?=
 =?us-ascii?Q?j/Enxnr//5ynlyMmpyKxLIWiQ4swkv67ateUdo1KRvWkrptpLJ7nD86lGmDa?=
 =?us-ascii?Q?XaxhpueCr9H0Jb7Oi8lerdvrAv1h+KcFvHeNg5UiXtR5Te+Z1T7z7zodMSWG?=
 =?us-ascii?Q?Qt92ejIz6lMHwXDwaZEZFrTVl5gsVRNuv4UsvtxA97nh6UXWDg13a9UjFW98?=
 =?us-ascii?Q?1M8ugWzA1rJgoncUR8vHkHFMsMMQPDck4k1+cexAqkrVixvHwfJbT5JWxnCO?=
 =?us-ascii?Q?Fg0Tr6Zo0t6eymCCTuuTQa08l4HpYZq5dr2ZZHtnxKpTy7iLUD9yaejSub/Y?=
 =?us-ascii?Q?W8csNDuCzMA80nDRxL1Oi5e0ryTjbdzBz9UVSW7+lDeOywv0fOmRZTWER4he?=
 =?us-ascii?Q?b/tpEAJ1x30Gjt9HamEYCABnuce4eLyqzgOczi+niDt4fkbjdW77QSiDry0d?=
 =?us-ascii?Q?VT8QxY90cs/vuXXQPg/ep6vODjlKS+4NEeXfsnK8E+PChuo7E67iyzmiPl4N?=
 =?us-ascii?Q?psn71mf0o7GSX6h3NZ6a2ImbxHiPmrRTL4aptoGaeMQmCYeF9DsLo/3sHoV7?=
 =?us-ascii?Q?Wc9OLLaHVCewmd7ds1bBk2I0g8Zoh1taKqMCWxXHxhW1TNiHHeE7d4teUiJA?=
 =?us-ascii?Q?6TTHsEhpBr4UcA1YOOBrhj0pcB+V+vfFtWUQ7CHRNULDqbJbshxE9FAQ/Kr7?=
 =?us-ascii?Q?WQWeBL087QL3FLHpxZdzQ5gq9LajWhP12uHHh95Cj1EjzVbQxOg+c8t9j5nJ?=
 =?us-ascii?Q?MoXunTdxU+CNuRNRjaM98pSbPR3CFArx7lB4pOdTSdSkk13UYBLv9sCWtRhs?=
 =?us-ascii?Q?6HcWzn9Ltbs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7frVH3U+jNJmvgpQQBkKP8JAfCZ86osjnrJd9bny+A9wvTLB+zDCta032z1x?=
 =?us-ascii?Q?tVtM3BeU6NBJCGxAPDThZZBiO+y7GllqW7YSoOs6Qwoki5mtjA8OgQG4ObdU?=
 =?us-ascii?Q?PdQk92PP1tkKkXuHf+c0moM+QlCt1IbtZBA5vD29qs1m61IDULKg8/T9LgK3?=
 =?us-ascii?Q?LB3Y89/4RqYjKQOsNDzHHO50xZXWWQcmaiMRBLS1yIgBrNzy2XYW61c/7RzN?=
 =?us-ascii?Q?37CN4quESN4CC550xM8Y308j/rdLvT3iz+ndANkFdxHYHks3ph1KgHbpwgDm?=
 =?us-ascii?Q?hrrETbB7e8BPPOiYlbKfHQ/sF1DT1rG/MSHOIyVlLtq3X0Pnhuw9X/gUR6Ow?=
 =?us-ascii?Q?m79LTJzbZTcfpCkFDO0klxJ/n/IKQRn4DLix2LzNmPc9kFgTEd5TEyNkL+rt?=
 =?us-ascii?Q?zp9bLqpZFahSaREYdPYTrOIeurZFRV+atudP5hhBCFmaSD/kSYXYOMYzWYv7?=
 =?us-ascii?Q?DKSa1u6z1b+cP8U+b/axTTBOUYWPRNfZSpp5tO2t3YYlew9ORaF/Et8CMfaw?=
 =?us-ascii?Q?45fWrK+X8lQUdQ9RxM4bR4/sEkPZtkQkQLVDOqy3i2yDyjyUkXb9s5BNepO0?=
 =?us-ascii?Q?2amG7CYpm7SFgHYp3DiayfpBjjgk0wHClzu78bcBaHbWnDVuonE3j7TFqrlU?=
 =?us-ascii?Q?HG8OGQ4ZTtQYr/gsdzjxedw/JRiyKh7ZRai+K+xALC/SprayW6hL3uJjfkB1?=
 =?us-ascii?Q?gs8kIyYGcPX55QKuU5Y9zCxEfNo4z6bDaDHLCcb0ePgB43RUcZaJmOxm46QW?=
 =?us-ascii?Q?OFVCSgavdG02EOM1xNILxwuYGL7nJJjS029JdUTCWGBDmKonCeL0J/0Ec/VM?=
 =?us-ascii?Q?8HA96yoI/SIvG7pcqxltMWyH8g3F2AO9mEibhHmS0iBpmrAaJTlTbiTRaWBY?=
 =?us-ascii?Q?tTqJGxabmuY+G2aGIhqTb0xAJTSkAS1E9lCqJRwDKNJZJ0M4K9SqFVMc2nXJ?=
 =?us-ascii?Q?ZkdMVfulE7iM3aW7p5cl5cYniPu17TwsUYQneK3aXv0ToKw8gfTv/V8KvEgq?=
 =?us-ascii?Q?+5vC5KAa/1LumHJdCCZOEPj+Zc4sDqPkggTRbJ6E4NAIjzly0oDMiKHsOANA?=
 =?us-ascii?Q?vU1iK2yJ2LRQiFDO2FfT3l6n3HGrtKQeySIoE2RORLV5msRYlEcTzMDJT/IP?=
 =?us-ascii?Q?jej0EmqGv1Tq7xVgfuQ9j72JDASaoEV6mqGCJmBIfJ5JcHT4eqW36DPM8fVZ?=
 =?us-ascii?Q?McxEFH5PppNMOMuCn2LFOh7qMpOkSjYotJJqy0E9VWOEx1f23Kt/uHGgbmij?=
 =?us-ascii?Q?XulcsAJWdmbQ58ePe1zRCR+eSnTIi4vshqOhry2URRxGp+4XloAFbspIB1Zj?=
 =?us-ascii?Q?MKVDCuIXV1hm2Masdfca8gLnoq4IvkHXvjgy8DBJwt/7wXvCwwdgyCumgPko?=
 =?us-ascii?Q?KOFLnPVb7FyNXy/vPX6TpgrGep4XfY4n37W4oa1/fqjIqTIDvVRAAtjpZn/Z?=
 =?us-ascii?Q?8XkcBCKoGpiDtaaimP5cC+YfThN4KvyUzZlbD+qJL8xp52sL93ZGfM7ToqNi?=
 =?us-ascii?Q?YwFzaZPRwORFVjDMYFXbM7cBTvSNmQDUoR7ng8eG4Qaj0lTMdsqrjywBd2d/?=
 =?us-ascii?Q?wVFqpDWQfOnk8mcS2/76Exbiu4ssfU8d9Am+rbhB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef0e34f-36af-49ed-588b-08dd7e9392a6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:44.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNmoYD328QL/+a09quQ8V/vnR+ce1CPPY4v0YQe8Wzn/7vujQJEsUpJgLBX1U7iUYd/juQ5IGK5mzgZY67Wd2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

Right now, torture.sh runs normal runs unconditionally, which can be slow
and thus annoying when you only want to test --kcsan or --kasan runs.
This commit therefore adds a --do-normal argument so that "--kcsan
--do-no-kasan --do-no-normal" runs only KCSAN runs.  Note that specifying
"--do-no-kasan --do-no-kcsan --do-no-normal" gets normal runs, so you
should not try to use this as a synonym for --do-none.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../selftests/rcutorture/bin/torture.sh       | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index b64b356f55ff..475f758f6216 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -51,6 +51,8 @@ do_scftorture=yes
 do_rcuscale=yes
 do_refscale=yes
 do_kvfree=yes
+do_normal=yes
+explicit_normal=no
 do_kasan=yes
 do_kcsan=no
 do_clocksourcewd=yes
@@ -128,6 +130,8 @@ do
 		do_refscale=yes
 		do_rt=yes
 		do_kvfree=yes
+		do_normal=yes
+		explicit_normal=no
 		do_kasan=yes
 		do_kcsan=yes
 		do_clocksourcewd=yes
@@ -161,11 +165,17 @@ do
 		do_refscale=no
 		do_rt=no
 		do_kvfree=no
+		do_normal=no
+		explicit_normal=no
 		do_kasan=no
 		do_kcsan=no
 		do_clocksourcewd=no
 		do_srcu_lockdep=no
 		;;
+	--do-normal|--do-no-normal|--no-normal)
+		do_normal=`doyesno "$1" --do-normal`
+		explicit_normal=yes
+		;;
 	--do-rcuscale|--do-no-rcuscale|--no-rcuscale)
 		do_rcuscale=`doyesno "$1" --do-rcuscale`
 		;;
@@ -242,6 +252,17 @@ trap 'rm -rf $T' 0 2
 echo " --- " $scriptname $args | tee -a $T/log
 echo " --- Results directory: " $ds | tee -a $T/log
 
+if test "$do_normal" = "no" && test "$do_kasan" = "no" && test "$do_kcsan" = "no"
+then
+	# Match old scripts so that "--do-none --do-rcutorture" does
+	# normal rcutorture testing, but no KASAN or KCSAN testing.
+	if test $explicit_normal = yes
+	then
+		echo " --- Everything disabled, so explicit --do-normal overridden" | tee -a $T/log
+	fi
+	do_normal=yes
+fi
+
 # Calculate rcutorture defaults and apportion time
 if test -z "$configs_rcutorture"
 then
@@ -332,9 +353,12 @@ function torture_set {
 	local kcsan_kmake_tag=
 	local flavor=$1
 	shift
-	curflavor=$flavor
-	torture_one "$@"
-	mv $T/last-resdir $T/last-resdir-nodebug || :
+	if test "$do_normal" = "yes"
+	then
+		curflavor=$flavor
+		torture_one "$@"
+		mv $T/last-resdir $T/last-resdir-nodebug || :
+	fi
 	if test "$do_kasan" = "yes"
 	then
 		curflavor=${flavor}-kasan
-- 
2.43.0


