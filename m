Return-Path: <linux-kselftest+bounces-33107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78026AB8F08
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B28505E08
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1426A0F4;
	Thu, 15 May 2025 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BmvEpeQL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5520269CF4;
	Thu, 15 May 2025 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333434; cv=fail; b=VfAdk/age6u8H7x39hv1/mHazxqj2vf7cGemmTnsDl2oeN8BLdrq8FyrjjVipJVBhKVRKgrktfERM9OFU/1/l1h45SYUYraf4loihhuqMWokvwVYtwGqdFTgA1HCiVQHnrDT0J2rRQg5a5GSKpomfaSe5bYF2R/h6/+I4cxAOHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333434; c=relaxed/simple;
	bh=dPkDUW7jrLCywyBnJltf+O0KRdd/ZQPs4WwfvlTUNQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZX6QcENG/VrcSp/4Qq/F24jEh7qJk0/kWIQdylbqJaLvsM42VG0vflRsJSUHYn00THGStNMKlcsB6nsdSOEHkl618qAQvF8Q0PJ/5R+ecqe4sakvZdkfljEfPqbjiJYD/nz/7oNCrIVJaLWAViVzT1F8RX/xgtLZgGydK6wD4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BmvEpeQL; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgrhjnI/eJ+uuGYTFv0UrOewoOo75RlsiFAFYn0oi0fcDVSIXkKnDj3MGZMdsI+ydEPFQ8KekgTqxPotoC4k3wuRXI5tOBiIPXK8YJgZAS18YvYcUIqrGUajtshUVqoHE965oUJ9KXgHWpaz6J0/hLhnIfgjoCntNG/B5XD6Ad+niQQPKedaqCAhOHECeA1XgHY2Sgr8xDnXGpAuaJ9iG7GhN47KQSfY3Zln3pfEG3FADMw9Wcjfgw++pWZ7qB7+K9zDsYrCl5QvU6AoP9GBlu2ddu64z8kNj3YZs80YzAzo6txDeqguK/29IsUWtvt4WRWul6THp4iuNAlsMSLbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frYi8cY6Y9JblJxZwyh5qhBC+TI3ESmI7GvD1QAOIXY=;
 b=L/YIN+ubf8DziVMsVCi35IS2SLWJbuwtZSUjWnOmswEz3yKa7wP4VFzrKm9fSp1F509K+CMWfjcvAPKaBv9swCgMWKV5dUZvjXaKfPPA4az021ciRyQBvMWoGSfj8X/y7BEj+WUdtYgiXkmJ5KD7fsyoL8eSyY0g6LYd2qzE1KdRU0+juUoxqhTr6wBWrxxWrzr83N08NkGT/DMa1OptMP3jOvEOCLNhsTxORAqMJsLGx/8aaPPiXSGiZspHVQeX0mitKDw/6huz9d1J+MlSDjmvISQdxMaILFqKQ39Oz/C8YiX/BQkQvMwqoegF01uMqsv8pQFUnsLRMeEMgWF1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frYi8cY6Y9JblJxZwyh5qhBC+TI3ESmI7GvD1QAOIXY=;
 b=BmvEpeQLkV6FHV7IR00/4TFuHQPyDd9tc01ebPGxyMeUGVeYeFMwmpoEKrtlwQYiB7HR/W2p1bxL3N/54Dv/Vruw92H7rJ/RLNl+t4k25jiD6LSquueU0sd0lQHL8E7y51NoJ77/LdiVKtj3TctBrvU8H1ZFM4hJGWCtT5mTZM5LHJpkeanKQdCqfHZIF4wo20uU0FjCxXyDDu8kyLsramSO/g6jpR4GdQaEtx+5RjIebFxDMtH/unprnxZqsv8spBwPRPiJ7mtMBeQtFBkActkhNs7M9jAPrr2d+ayiNJvmFuaT5NVEss99+qVi5XbGI8bxzsgW1u7niudbRBSJOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 18:23:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 18:23:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: Pedro Falcato <pfalcato@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adam Sindelar <adam@wowsignal.io>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 2/2] selftests/mm: skip hugevm test if kernel config file is not present.
Date: Thu, 15 May 2025 14:23:33 -0400
Message-ID: <20250515182333.346587-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515182333.346587-1-ziy@nvidia.com>
References: <20250515182333.346587-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a32fdb8-3f7f-45a4-09d9-08dd93dda11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FwkEVlu3veOQKR3IxsECc5krdL5aAxchfTFRn/8mg2qHDBGl5H7YqJBhpYd/?=
 =?us-ascii?Q?q2voLzv34TebqtXByJADsVdNHjOnjoVFzYD9VD7/3U3xZIzxLe2QfEvdlTI2?=
 =?us-ascii?Q?LWnTcVcZcZkavzKerB6vrj0oFErSMwts6PBru46j+81h44To3Hpgwo7gZZgi?=
 =?us-ascii?Q?smXV7fshsGPmogjkeiHgfl1GRHgwOgS5QQFm31GrZhqMzfS9srJWgU3G5Rxr?=
 =?us-ascii?Q?qd4Q2jxcZZZNcg1JoDEaqF0xfsUEUIGyaxDMifusjo5rFvWaYFNbwoETlAoa?=
 =?us-ascii?Q?YmkbhMVI00kbNbljU7oY9sX9vde8maZIMM9YaruiOKWoJ3EMNtI4/aDo6F8Q?=
 =?us-ascii?Q?0u7JcjBwgIQQhzklelFxNqDlS3oVRXspIgttaproOln6PDW2JKCaQgzVHD23?=
 =?us-ascii?Q?gadE/4cOlCVa7rdrsZlaN4GhM7grdffOhAOd41u1uXZMzllvOtmMcIA2/fYm?=
 =?us-ascii?Q?B+CYnzoNLztsI5j+HV2iN/DCE9GN8ujBGBoF6N1WddMGqoWTJ3ua0+e4FWih?=
 =?us-ascii?Q?kj8QLMoC0JFN2NNQbqsUjakyXj4lEOsGo2g8ncKjb453mB0ILDb3tf/sTgeX?=
 =?us-ascii?Q?q+Ip8Qzu8YRUIGOM9xZcG+ZdjO01+44SZbchuKPAJQEkyFkFTt7iraAnZPps?=
 =?us-ascii?Q?htrSkFsY3Y4FFhH+qCvGZhnbqjsSXJQ7LBQ8UNVctlw5W9O6B7FrNx2QmO8q?=
 =?us-ascii?Q?JtIxgjAy/c7aaUI6oHIE89gfGDeO6IvitM37rbg5Qt7STcPmaD0f09wXTKAP?=
 =?us-ascii?Q?zkXsS7T0nvg/L/8txigWAQjgtqf4ZGdG4qPY5e3a+OhUHUcuRK3+aOasyQKf?=
 =?us-ascii?Q?o2IRbU1Tq54rDXMTXHB26k4jmTm2qewxD1rr71DctSO0pcpwAz4zF1UiCCdc?=
 =?us-ascii?Q?7uMa+yeLlyx1XbXL+L2qFw49qMTky28qjUDJohIblmGiRXMQhNaP7C2FmQcC?=
 =?us-ascii?Q?CZQbjZbTjdqHAPJJya1nikscftHbAhtR8uQHZRU7a1uzPFmCC7QxS+e1V2UU?=
 =?us-ascii?Q?61wamfbtSX6/QPHksQnGvAX6e5k/7butjqbUVwBR2C4AEuBbBA7wopr4y9kS?=
 =?us-ascii?Q?Fugg10SUHMj7F975Gcqqmfpe74ywy6YLRoMyPnOiRHFhOxdAFHPlJKM56HvL?=
 =?us-ascii?Q?1gpwwNGlZfLb0uCZq/lj8j8IN9uC/zOE2TQ9p2CWJp0FNPez8fg6uGtInnd7?=
 =?us-ascii?Q?xJGrOv5Vpyua3CxqakBImbJ8jVy3MiIfwTpkUwVvethdspw++AOCnfpATci8?=
 =?us-ascii?Q?qJPgnhaxifeYBE1Hz9GRmpNB1HlCxj0wxpNd8/nCnwAleP7LTldTbpMWE3pE?=
 =?us-ascii?Q?bhgI2JTjFZoUFG7uFQWoAkZL1DoGjprPwnvmUf/M7sKzFFOvsh+jz+KYJdqn?=
 =?us-ascii?Q?01/Kvop0dEZrWqgn7RfD0qj2vzRki/8S8rZMyEcYn4aV0mAUOIdJgCdaAEIQ?=
 =?us-ascii?Q?SO87Bi7HWq0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4TTsj/Ku/oUCMu1O202y1GSN90j6T3hlZuMnvmK7z4dP7MOfniOxmmy4Vf7/?=
 =?us-ascii?Q?Al+mlvOAXjO4xmZ+BNehIhZHM1QTrwCJHx1pi5bMmvVhVZM5db1IF9r72+yf?=
 =?us-ascii?Q?MpKea9F++2v4/to714Ph/+zqAb8Zwu3nWHwyR597AX9osL9GFPDt71bnDQVz?=
 =?us-ascii?Q?0BZO7YTTBDt+9whvXiDC9WBZzFAzwNPxJ5IV6mFd77urJ9Qecr872tRCh8ex?=
 =?us-ascii?Q?NHb09OSxZuCdYm/QSXAETjyonNuw6MBGoOOTcR2zQUc5WagFz6BKAJ0uIXzG?=
 =?us-ascii?Q?8k8V+ImUPjUTrsljPUpNzNuM43SYwBD5MhtNiYY1KWa9NnFqq0Vi4ZgsNB+0?=
 =?us-ascii?Q?LprrhH8872+Frrb63M+/bU2gahITQOPltgxnoEMkQkO6f4Gyvt98cld2B10L?=
 =?us-ascii?Q?TZYRzSxLMugJZjR3VQOxJF95XpwUNOT5MLtraxwqwBxFfx2TcCmlo9ue36o1?=
 =?us-ascii?Q?QY1bi3Pd661b5k5HWS2FCbhj24BmEjQZmvj1WpLa7m37QZ7fytj3Onq25hpu?=
 =?us-ascii?Q?60UL7zG596ND9UZSq88fTKgq6kwSmFyhNj7tFtsBASNwhh2S5/5E85XZjvfN?=
 =?us-ascii?Q?5agcK38bn16pGTkxD5UV7hLLqr6NCBpNZpEcudx62ysA6h0g7nCfjzkKpLEn?=
 =?us-ascii?Q?o8z+Mt6JOXL3MRfGn0bhI0bRyzEJNx47hqGUNTZiE4unrH7fFW8zt3vLALNf?=
 =?us-ascii?Q?8obqgTJ6yJQ/bgFblAZWGSSzfEO9KYW+daSKUeRnU69oT/8BtBId+205yWqU?=
 =?us-ascii?Q?qQ5z3zSQDZn/SW9zQegtc1UxTpcKCs9Bb4kQlcNezJnvxvNjZgNYq+9p0Pne?=
 =?us-ascii?Q?1ppLBQqFsdKgWtletkipBmGoFikkIpLPgStaYav+FrJcgHCBNLrx7+Pchj/6?=
 =?us-ascii?Q?B7d5gLxdNbgZQUnPXRScE5lSP6bpVktYFItx/VHf76wPjgVVSopMVPZ1/NFM?=
 =?us-ascii?Q?OCI4zaw84M9Y6G56aQivlQRX5SOOh2ARgD97CE4MklQM07p1y36GL5xNoVsU?=
 =?us-ascii?Q?ExhfNN0oy65NP0dfQQKNyl9okSrehJXIz97ZKkf2ZVAnAeeTGX/K9y3FlOK5?=
 =?us-ascii?Q?tzTXzuPIO/3Xn9ZgyASbF0wwUEY2pIo0ejuhnmEs6E4aEENoaM/Nu57exyQu?=
 =?us-ascii?Q?dCALoy/oBs3AYk/Q6r+uhRrwB2elg5G81CTjjv07eVjzc+shsszeVVWuUGsh?=
 =?us-ascii?Q?wSGfv0wEMKq9Mg3HNDb9uYcF42ztT3HSkb6XMO2zFmgGSK61y6PuDRvtuUCm?=
 =?us-ascii?Q?fl5UzxwGJPfA70gI45pci/CaMiZgAjF3PQBAE+NKCUs2HT2zuHjEbyCzku33?=
 =?us-ascii?Q?NdnRVRJM+ugXvfZc94heTyY19kJTuFZUXqzz6AD/znftc6VvguCtuopMNDAR?=
 =?us-ascii?Q?Oxm/qTvfA+g7Acumch81PO5QmbOS+3KlVPwDCKUrJoWzw6CTVQZqa59ZIxzC?=
 =?us-ascii?Q?/DTg3v5LGoaAUjwu+pzUFd6LMswiQOdVNDvWrMRBU8jLds2L7Fo0LT8uloab?=
 =?us-ascii?Q?TTIJREJjDHzJGp6tlRKGWKFTQRwV2l3RXEquBdxOZY6jP9yeuuUvESAInUdK?=
 =?us-ascii?Q?TzlXgwTu0zrLc/Rx5qfRWpzCj/szxGqB9wuA1mSM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a32fdb8-3f7f-45a4-09d9-08dd93dda11b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:23:45.7934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fupAqdiDZFzJvqyzpngtSI3SRaT64ufOJJzz3Fhr56pEzyev7EPrVM9lPQC4bHKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

When running hugevm tests in a machine without kernel config present, e.g.,
a VM running a kernel without CONFIG_IKCONFIG_PROC nor /boot/config-*,
skip hugevm tests, which reads kernel config to get page table level
information.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/va_high_addr_switch.sh       | 26 +++++++------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
index 1f92e8caceac..325de53966b6 100755
--- a/tools/testing/selftests/mm/va_high_addr_switch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -7,23 +7,20 @@
 # real test to check that the kernel is configured to support at least 5
 # pagetable levels.
 
-# 1 means the test failed
-exitcode=1
-
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-fail()
+skip()
 {
 	echo "$1"
-	exit $exitcode
+	exit $ksft_skip
 }
 
 check_supported_x86_64()
 {
 	local config="/proc/config.gz"
 	[[ -f "${config}" ]] || config="/boot/config-$(uname -r)"
-	[[ -f "${config}" ]] || fail "Cannot find kernel config in /proc or /boot"
+	[[ -f "${config}" ]] || skip "Cannot find kernel config in /proc or /boot"
 
 	# gzip -dcfq automatically handles both compressed and plaintext input.
 	# See man 1 gzip under '-f'.
@@ -33,11 +30,9 @@ check_supported_x86_64()
 		else {print 1}; exit}' /proc/cpuinfo 2>/dev/null)
 
 	if [[ "${pg_table_levels}" -lt 5 ]]; then
-		echo "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
-		exit $ksft_skip
+		skip "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
 	elif [[ "${cpu_supports_pl5}" -ne 0 ]]; then
-		echo "$0: CPU does not have the necessary la57 flag to support page table level 5"
-		exit $ksft_skip
+		skip "$0: CPU does not have the necessary la57 flag to support page table level 5"
 	fi
 }
 
@@ -45,24 +40,21 @@ check_supported_ppc64()
 {
 	local config="/proc/config.gz"
 	[[ -f "${config}" ]] || config="/boot/config-$(uname -r)"
-	[[ -f "${config}" ]] || fail "Cannot find kernel config in /proc or /boot"
+	[[ -f "${config}" ]] || skip "Cannot find kernel config in /proc or /boot"
 
 	local pg_table_levels=$(gzip -dcfq "${config}" | grep PGTABLE_LEVELS | cut -d'=' -f 2)
 	if [[ "${pg_table_levels}" -lt 5 ]]; then
-		echo "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
-		exit $ksft_skip
+		skip "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
 	fi
 
 	local mmu_support=$(grep -m1 "mmu" /proc/cpuinfo | awk '{print $3}')
 	if [[ "$mmu_support" != "radix" ]]; then
-		echo "$0: System does not use Radix MMU, required for 5-level paging"
-		exit $ksft_skip
+		skip "$0: System does not use Radix MMU, required for 5-level paging"
 	fi
 
 	local hugepages_total=$(awk '/HugePages_Total/ {print $2}' /proc/meminfo)
 	if [[ "${hugepages_total}" -eq 0 ]]; then
-		echo "$0: HugePages are not enabled, required for some tests"
-		exit $ksft_skip
+		skip "$0: HugePages are not enabled, required for some tests"
 	fi
 }
 
-- 
2.47.2


