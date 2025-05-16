Return-Path: <linux-kselftest+bounces-33185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C20AB9D5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B441BA5B1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE00132111;
	Fri, 16 May 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OWtSpix1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71474BE1;
	Fri, 16 May 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402200; cv=fail; b=RXbVDNpAdghcBK7gfmnhyGQRVta9eA9sDWNH/qXvSZ/h637Eu0wVQDv9wmLS4GoyJ02cdLEfDisosSQrGWeWmvcjWTIar5dm6AC3fgz16OIE6ob8yzMuxe4Q9jW/UNiflmaBxcScSISe1KC66KguQUuTazPZaDd/rdIHrARkG/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402200; c=relaxed/simple;
	bh=qx3AVF31af9DOSLLm4bK8ikV8Txa7SF9Dmd5OHtsHuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zu04iJ2d8JSkxx1D2Ho1Duzr6BP7X9f+Ry+sFyKOCaeMZNUw8/iXW0ifpXnqwQW9hFPRw1j2ovtjZpntR0KRL3D8A2y8y0s6SvW+S6/ziYjvtXOFfeYVGOIVwXcuowJjqteQ44ICRS5Q6AYck6xMIUg1B9gxnoYDZVwoOMhwiBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OWtSpix1; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ti84Fr4X+5TAlIXaPhe3bcxulvZPRD7g4ga0dcGIUEeY0Lqk/9i6FClPGzntne6ZjoabANdfdlB3qoIU4nMjyFWqND+wtM/fqSkUBzlewyeFTjtjNQoVAgH2Llv4kMQH29DNSJ1Z6tp6ZSRRQlkqLo8MNOo20l5aKZtX0C3tvHHag9HVcXCdP2seHdYCKrtDj2+6Ig+xkpb/+jMWd2M6O/WB9AWflJ85g3AryqC52QdsxUc9v9Ao6yrqm75zhp8sASDwCSROHLfV8McgYv1ATQc+OjWOI2p/6PcH18x7W6lsaCgoWheVUx8rJj+PLMFlIcdPOCxJJ1NH5MzIrwbLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhuAksPZalburscZctRIvdNG4x2LdBtwksz9e1mwuk4=;
 b=Z9JRv5vH4KWafIt8ykHUvAVvGYTHEt5V+ABMuFAZSmEapCkMKFhL7RFITJ6dYwtvIO2aAQKs6x/n/z54nkpLofQNQO3Q301G7CVkhZETjAVmwq7zGJPxxaIEhBmfLFF6VhYgZJGQpCtaNaDhYJKeB/nf7uUzaPKEfQcrPEwjtINTbCjFjuMitguQiGcRnqBK36mfh30thS7HkFCOFtzovmqom6SLf9KOEZ+K4GWXOHeAxTBrJI1vU5krA3m2TMb3woowHegenCB+cHVbqOCrLbwAxdHDihFjzQTheq1RaNEYfOfKrsQm7ThObsPw+yQrN98g2x9218Od5GhIAGDVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhuAksPZalburscZctRIvdNG4x2LdBtwksz9e1mwuk4=;
 b=OWtSpix10dphFlcipiw52nzDaWA+cYfoEqMpgWlJc7Qs7wg2RXkVA1yLHwdLI0GxvCeaZuEBADWhgyWEcWofj95q0TU7vcCOU7DJmM3lb2vAJEsWRX7mVhC77iZ+Qx5mPvyzjBFS7dIRrWx7Zw0GsjntPQdNpNpEPmx8wntF0nmMZRjGdu4wo/rOWV5+pAT2Hbf3U7CRUPiYBNT3gmqFvRGE6b0EzzTP97OVam+U/MHv02Oqe1NKrciugKl6EnfcMEyzKggihSiB5hXAsfB8gh+POgwpCBEX+luOC2SjfbygeI/Dcmj3d8kfHWdqQ7HJiXhka5ko4Um1CtJIigyV6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 13:29:52 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:29:52 +0000
From: Zi Yan <ziy@nvidia.com>
To: Pedro Falcato <pfalcato@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adam Sindelar <adam@wowsignal.io>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 2/2] selftests/mm: skip hugevm test if kernel config file is not present.
Date: Fri, 16 May 2025 09:29:38 -0400
Message-ID: <20250516132938.356627-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516132938.356627-1-ziy@nvidia.com>
References: <20250516132938.356627-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: ba850477-894d-4703-f772-08dd947dbd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TNXiyJ9S2hhZTqSvMx3hGKQ1QWjCeIAOFXG3fc9YYMYc9gLIKmPXDwNVlQ8K?=
 =?us-ascii?Q?m3SgEQfpNPxDbdmL8aifY4urfS9K78SPTIUd5OC37W6U85gsGGOsKhlgyNHW?=
 =?us-ascii?Q?WdDe7TeWwbxoM+QlNsKMyInCq8qU8ISz2KcXyuIQ8bIjlujP8oTmnSSpzuMw?=
 =?us-ascii?Q?Ln6801TbVNPDhRJ1ysPUN5AWu7ptsm+6hgcgsfj8bR5QuL48Ymnof02ax7tz?=
 =?us-ascii?Q?/fDpGbBEruW7xQDOneKW8YBjvcgFh8hbS2m8PB1rD9xCVvh6PTpAc6bxBPTe?=
 =?us-ascii?Q?/heoSF+W4Q0d2JjIhjLr5sIJ1knQiV2Bfxcb3IaT2/6i7co/lRWS8rMWHvM1?=
 =?us-ascii?Q?44gXbfpOvbwa170nV3o9GgtBfrGdYiKEkt+6Qlo12Cv1vbCRczlYiMvzpZKH?=
 =?us-ascii?Q?3geuo2U0/Ysumnu35LPG1nTyfLt345MFWSRIpuszbnIInWs2S2HOk+D4+74c?=
 =?us-ascii?Q?ZORxYqOtEAlW0Bh13TeaUNIZRA08NEUKDTnRDwu5tS3TXdSwVcnIHfWr9eBD?=
 =?us-ascii?Q?7RNuZyNn70JIRkFnHrph3sYcSpS2/1Nk21ODVgS2j0sBW2WO8vha3M40kZQo?=
 =?us-ascii?Q?NCOpyMuBSSye0s5jt5mOxRLU3EojD/fS/gYe5AwF3nL8Qpk4yHGx+0uEVtIU?=
 =?us-ascii?Q?vJ6ptyN3G6SLYVsbsmBdr7pvyNh02af9MgR2agKtIcB1E0FSOy0vUxsXl4ee?=
 =?us-ascii?Q?bYModFmZe2BX4ztnDp9PZl9oPYl2GB8cUuEfnCs4Yb5WzECGQhKC5sWyerT5?=
 =?us-ascii?Q?bARYsnxOgPX2vM2JuZo41r/fZ7lvhdgIg56fRPscUsHSZbFWr2UZ+kpKzcBF?=
 =?us-ascii?Q?hmGhtpDvd3sPaQJ2NyFB68yQBktdoiuZMunbIKKDAzeG0YsVUc9G0jtCftkG?=
 =?us-ascii?Q?EAwDFuzT5YrBYa2t+BO/m1zLkeJEHaCi4x+dlXeqEWd1DfiXoOrekNIuk8t/?=
 =?us-ascii?Q?5dBo4Y42Sj9zCTIswEOX9cDZm1YUKGKz3F5l6zvXyuaqb//2adMAWHmkJ4WD?=
 =?us-ascii?Q?XcnT+1sBtHdJSge8qsM7PdegmovLw58oOEamC704EvbVdgMUq3cSxW/7lfl1?=
 =?us-ascii?Q?3MDd01Ok6hCjXRuXx17XQL66pgz/zDPWOn89YBYdbBUryEhsEHPDW0GLKMz7?=
 =?us-ascii?Q?rHRYv92LIFoUNSrGg7cW7PtHpsdSp+PIpbreAgm05U9TSvE+Q7C1wUugl2pl?=
 =?us-ascii?Q?DhbZw4gu0kjbn82otBHUvp4wI+Res7bxrQd/CXbCryOCoussWlOHnIudVeD8?=
 =?us-ascii?Q?vJ/d+E7fkbctCR6NdcGLlWMu9WDxOuPJA6zMSx11fyqGpiDUCL3o065qN/Ut?=
 =?us-ascii?Q?RvM5qwck7Gkq8T1cKeDCWRHG1dcXVfE6PDFWOvIV2HfZQGJlaeWGTcsNGq91?=
 =?us-ascii?Q?TgzovRxJwmmCrtINv7Uh9Dp1oMVNUtzUkUh27RaIyKxdPQvh9vpL1NtEXc7k?=
 =?us-ascii?Q?QKzutPD83Nk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Dwjjt7iWwV9MHEJY3qhjnqouC/JZMRKaie00Trh7aTfbF5UpHT6b08aNwWR?=
 =?us-ascii?Q?yzoCWSMoo14yVyGOyTusHdpSsSZ1D1decf92xJBrENiOPZC/n9kEJDNx21bv?=
 =?us-ascii?Q?wAUQBrmmJucxf7SOEnuaQB5TAye/EQQopWZnZl0+OSG6cUjq6bEES8CzhowW?=
 =?us-ascii?Q?+JZ6KkHKpp7fEH5nIPtga45gRHQTPKgD36++MHX5zDcCQAdDseU2zmIbZa9p?=
 =?us-ascii?Q?Nq67npWhTQjUO4pLKww2uPjcUQn1n99FnkG3JfizxtAMKS9AMGQlUOEMxjCh?=
 =?us-ascii?Q?8+Idyfbwdjn8DtLf+11namakSyVzsCVEv6zHXn/TfOaJ0mro8ldCDoRJAbuM?=
 =?us-ascii?Q?jJ9OV5uF7/clzRGiEmnx9YfdAwBeyllTymT1w4wyZBu8ybp5fbM79adF+sqo?=
 =?us-ascii?Q?ugU9sN1LzhOwmltXdVOVCqzSi6tMAm++vRgzrgPIKK5lMMl8oER9HmW8dh65?=
 =?us-ascii?Q?euJ+hy5OhtQWweS+MzTh6zF4kxOgbAlvX+dHobmJ6EhdLepc/dL1LbAOOK9Y?=
 =?us-ascii?Q?8JJucYxtdYyOP6GMXuo+LGT7Xj4EoZZaYn2UAlKclCnXPo0AXPjxGqEtF7/o?=
 =?us-ascii?Q?wpmiQKAttU218/hqJXgyvwvQgQ4RG1I6U8j8wZYqcpb4/ARq7FvQ/RxeVTgw?=
 =?us-ascii?Q?JffanjLclLsFJpkPR713AIY8AGT1CEP0jDk007PUMVLX7oUv4q5VKRZgE9wu?=
 =?us-ascii?Q?AgkiE/LdOUn6y/jFpBEoVTkoFr9Bcg842I1Q2UAcTM37ar6rMVWz2wl8pp29?=
 =?us-ascii?Q?ZWKS0ZonsLCkUx/wHIrmdhAkyypybQ4JYXasQaYkFG4z1pbPAHUridc0ngQD?=
 =?us-ascii?Q?EPTW2OrVciRpjYHfTGb11+2ZCy0Loge5MRm3x6sQBYd1a+OcAw36/69aif6v?=
 =?us-ascii?Q?0OsBiQOxdyoS0EzaKhQrVCGeGmbL44B72IQibXkIK/Vvk2QOEJwERBxcmSVD?=
 =?us-ascii?Q?4zonUWfElMTlZIIO93FvVfc9Wix87sIFychfqq7yHgPrlKvIUrGBb++nD4Ud?=
 =?us-ascii?Q?GpkEFxG0k9Aycg8Wd3yNgDegNceEkj4KNMOgMmtIPFs3hnlzkBXbt5OgqcNI?=
 =?us-ascii?Q?gKwGolEFMWRCsf03punmsQbqKfWQ3Xj6Qdvp/YN1YHMv8WSZmMQ3NiDOvL6Q?=
 =?us-ascii?Q?+Bs1mMbHtpevEPMkOzmVHZCrhdRBDyqoljGImUAzqbZ7ctvNdOLNaxYbDACf?=
 =?us-ascii?Q?JRz2yYjy6BkQp/cwgXDdRLHt67qdmeTA6jzsZbWi6hDUfcI2Tf2SMscyh0Ur?=
 =?us-ascii?Q?agov8dAvCksWhTfoX/q9yWbYjrYEeRKi1NEmPS3oopg82ZXLPe9BohhhQT0A?=
 =?us-ascii?Q?8nY8l/uhqvOirHGZhRVTnp3SgItXLJKKfi20iZW+zpR4Jwld2HOvYt97yrrf?=
 =?us-ascii?Q?PWGPGXm7uqXT3iOhXVH++Aq+iuDuO7qMX7sY5RODICeYj98EzvsPJg8oQNkj?=
 =?us-ascii?Q?YX5SJcPfz7bw8oEnBPhjWVWtE/1wj892zQocAwNGdZyZO/KqdvgSRU39nCE2?=
 =?us-ascii?Q?kaFTsLRSvuI1ox0hYNNZ26Yfeppgf+Ga0j9/hMoP6nOdUOVlNQ47/1io+sE4?=
 =?us-ascii?Q?QX5DlbjomFcdoNzpc/7DbTFR2zy/44h+aBJAGpv6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba850477-894d-4703-f772-08dd947dbd69
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:29:52.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38dFaih/FfAp4HYxSyU6lXStgeQ7yNOwkdz98/TUIZmG37jsfjBieTAk66bEX5vM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

When running hugevm tests in a machine without kernel config present, e.g.,
a VM running a kernel without CONFIG_IKCONFIG_PROC nor /boot/config-*,
skip hugevm tests, which reads kernel config to get page table level
information.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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


