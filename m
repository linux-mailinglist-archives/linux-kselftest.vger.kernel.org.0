Return-Path: <linux-kselftest+bounces-41760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F1B81B53
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 22:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2613271F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5924466D;
	Wed, 17 Sep 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JgiH8Wjh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2F1DF996
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139320; cv=fail; b=dk/Re3bFu9+timPwbEZyaqA4z4w5a3ciQELzSYobXk51YZ2xOTi8StRePmQOpg0jh+J+UidXHyohiCEPMbJD6m5mmm8mVRxKX/f14lEgHJ5W9atc+ZQ49dDPSsl91dkFnhvVsMpAkGJqfsv+QQcerakIGD19VOm+9eEsY84GjoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139320; c=relaxed/simple;
	bh=sRD8QxQj6W8TBISqTMbM0OAcWBHb3QUY03PwYQwzAaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kCFz5o4JjOqkT3xS7NNaYy+l2n2cku44wbqn6d/lVrIp6+LR4dafvJD9k9s0QrJzZ2cWXVXdHKofWJZirMGXZxC98Sw4C8au4vqQ86FkVHxV10+/nLAGB1UIYVmnwoweNjEkR4bgg2SeEPbEtaC+1eu7mV6zdyARO1H0y9I22rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JgiH8Wjh; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmN8PsqcfWKXPlaZ0RIo25cDI6Pb3fsej851NG/+LlAXr4Rv/goXLk72mnq+tDRBJtqQzsYfHGlIvI8ujt4G5819a5gL0xue0ok3nt9xi6pkpZ0xH6LMMaojsLQoiOkrG65d3w7idPqDNbaKoIgrCmkT19dbKt9thMbtk+SMYB/Z71ti7ctR5ycedUNHNw8j9eIfwRMJ4xCXElUCTk+y/qLF09XgxGnwILjVttmw7HR3+DiZiELwUZwGkb0lkd6E5pottaVRDN+Fivqd43BckH4unKP4ck28guzfbEG2OPLNs7FH1Ho7AQu8xI6+qJkSm43G4SsCjpXLqnUX1Avbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mmVbF9RWJ0kE5NXKhyYnk5QdWwoX0Ah0AoZBihmAzM=;
 b=BOXSi5mUKvdDm2GNlrfn1j1OeSYd71RzMJjSArgm1e66M0MEscCp+pDvI9wnYXu6ymdIvr+AVrdh3jxHSkQNRRbxI5EbIARSoyFkCBrMgnVjUp0GgNM2X/4eV8IJ7M5xoRYgAYVx9+sdMn1kIpenaQouUyoUAtNm+n1ONfOH8RavCv1/GETwJG5QsISOYeb15QhfAcRdgYZyaOPckQQGarvSlJerijcQ5/Q3P2idQP+bBcIpU/SOqkUO6ELWXvPz6SfI0pJ9qMOb0GWk4iBfDGRV7IL2PCwfHucSQpOhO4mEUjJyOTqELT3fB9iZ0GcYPQWrI2j2OcK2KBKEEUnfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mmVbF9RWJ0kE5NXKhyYnk5QdWwoX0Ah0AoZBihmAzM=;
 b=JgiH8WjhBa14EMBm9P4hLrVrLwomC+CPjmoh3CkQsulZUTmHXTSnoekaocPK6QSuM6zE0+Zy6oW2NF3PlqiFcODzkWvQBhEVjNIauLvtxPCGpgl8d9MX4vqm2YPlFTFpXdZe/1AGlwvhgfAEyrLWNAcy1/Qd9OKKdkYQ4MTnbFEhIL3DI3nbeUAoHd+0y6ChdpcpHThueAm2yay4vZYuIfQ2NeByZ3iDhMMv0OOZ8wst/4/ZQj518L1qOe665JbkMJLScXH2VcvWqW08i9PR8X+pdkTq4k31oS+72m7jmW+9YIcGQxI7pL63+BwRIRSODv+SdAyWdlCnikQEP3+bmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 20:01:51 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 20:01:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	patches@lists.linux.dev,
	syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
Subject: [PATCH 3/3] iommufd/selftest: Update the fail_nth limit
Date: Wed, 17 Sep 2025 17:01:49 -0300
Message-ID: <3-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
In-Reply-To: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::20) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: a70228e1-afdc-4ad5-5549-08ddf6250ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1mk1d3dY017Hp6+OIssXHno4GoOlBCdIOp13/ggc/QFXywTj5uXi0XUPnXNr?=
 =?us-ascii?Q?+MMPDpLLCVwi7jJlcJggECtOE4C9sY/1v4j/5qBUDlZGpF0NtaFFSh3+7sjj?=
 =?us-ascii?Q?jlQFczBqtu8eZ5FJqGwvHPjnQMGJvjgOvviX4zJnK6KxSqG+vXhBAh6I1HWR?=
 =?us-ascii?Q?yaFu04JX6e+gHlaAP+sjs5CqVqXMXZkxWP6BBHKnw9lKMpUcLBes7BxpN/Tn?=
 =?us-ascii?Q?rerC63zlUE9tNSgnOYYG5o/VBye7RE9uX2AA4Zc+QeNbenqTfgkUwd6QTuB8?=
 =?us-ascii?Q?eFNK/L7QzNJ+KUAJIqgpjcvG5PnYlVByLpUDPrRPsktyW7LSBXNJoFueHrW1?=
 =?us-ascii?Q?EaAhMFn7/uRb9M/ZPpxSgsPbAiVbaNt1Vjs3uwT1GxwiCKHD85LP8gBOEqJT?=
 =?us-ascii?Q?YiTtAGuBHMqWqQ9Vje6RISvoG3g2Nn3+jee86UUkarGIOH9a9nPqWCSWTLgG?=
 =?us-ascii?Q?M/m1UYgnF0mmv/64O6HvdKBIWmUEnghqtI72CMRFIQ57yaKr5iw9fBMWSz4Q?=
 =?us-ascii?Q?2LApoKlgCAF+TjLIB1hkoyaPybWWMQp1TSXkuxDgSYuULycWEvzGW0wOgWNF?=
 =?us-ascii?Q?Tg9tSRDnOcw+6yxEonDlYrvsccEhhpL4SBELvdo8LH4fGIKdcRDiHeOjxF++?=
 =?us-ascii?Q?rmupKzu0Vu8EHe9oblLl7PvshHN7fVgth9a/2NzYrwFDYCA+6KvuYmazlOXh?=
 =?us-ascii?Q?sjG2YH2uTo6exTy73TUmqF5ZxYKDKyLhb+ANlt3i5thW6kiwOFZ9OPfeTzTI?=
 =?us-ascii?Q?PCOXBG4rvWgyUk7ZJQXL21jYeRwk4AmfkF2yxCwGI9CfZY5Ht4nydEQrabtK?=
 =?us-ascii?Q?Ny/p9w1VC1GOTZdELoxK6HhYfaQU7KjbiyymdRlZR2MxQrGapoC0874/wfqZ?=
 =?us-ascii?Q?U0HCZDHrRohjI18PK5+SrxEhCwlCTR3kG0tZwEZgdRhesaEabO2w+5POuurB?=
 =?us-ascii?Q?pEceuED24rYQYV/l/Ks4zo8NjUwNW8FMd//7mJ3FNwFZjgM92lSKpbEHHrl7?=
 =?us-ascii?Q?DZjzucpOTP3RZXWCjn0cXVQcC/jhq8ygDH8FqhNE7lnEirpPGPkqJGfblXL7?=
 =?us-ascii?Q?i1XZfT38zQOj4/SNaPy0yUm7gV/QRq4PChJK8orA8KO8GSI02a8npjPeiQFa?=
 =?us-ascii?Q?iVV29fh/5lBY8IB6YF5I+E4XWerEIYS0y22dQqkkT/J8cMc8T61cETpO3ojj?=
 =?us-ascii?Q?dFLMzPDT5Qj6nlmZ9CtDyOh/JglQuG7lSHI+f+cpC68CjMiy1YZ/ThlfycOd?=
 =?us-ascii?Q?FPvmzfgBul6tTH86ZU85kd/q+7Qwun2s+KzmC81lwmRXLWHZN5i612CtisMR?=
 =?us-ascii?Q?Yndr4SOWrEj7lx80Jx8poMIXTVAksTxe9j0aMDdDdesmVUtdR80p+aOOTd9M?=
 =?us-ascii?Q?6WTbOCJmlgafsJs9DDyltBdOFx3SQ+vXgqmUCHKHl58rC8QSY4NSv4NWP7zM?=
 =?us-ascii?Q?bAmY5YyvFgU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rSkONfy6rPsumA29b4wJMiOEPPHntz50s8MmMdcwO2zvca8upREQ0WeuC88V?=
 =?us-ascii?Q?BnheyDGfLobcEntJVb+iJ8urtXXULJ7cqoHg9ROcxuaRZBxXMrJRLulcTGUM?=
 =?us-ascii?Q?TF7FbrAUSI93DBOUJsQziId5uh43yuMvTvwLMV6rB509grrtQWsaJN8CC+Tp?=
 =?us-ascii?Q?QYox3fFhv804SO2Sq8/A6HuLu6c7QteMmB8NxBAiDRT4WDlkVQ76A1xytQdt?=
 =?us-ascii?Q?8EdYOeBbtdVsncwSQwhncpdZJIebGF73ULsE5NySh0aYEkvd01pYL8smido5?=
 =?us-ascii?Q?qkCRLyiKb6CyDZV8TtsnDnsaWT8AFtUYOnfZ4Xy9IxvBSr60KqKmm1LZqTyU?=
 =?us-ascii?Q?tj6rVcgRE7ghAmj4EeLadOx4sQfsxN8fKyr78Vr/Fvlh2kh2p5jPVDa9bdSq?=
 =?us-ascii?Q?ZKYBlIZaN/uwj3svjQCOv0r2D4qzP7CWtpGpB9FoPcmz3imf7SDLdWqf8QDb?=
 =?us-ascii?Q?Uy1FWDvjyb0qefaJkgCAHPtwW0QE5zz92CrMZnLzyWEpNUcV3qKvPc3c3d1o?=
 =?us-ascii?Q?0SCZWgnOgOU8EbQjU3eeGO0+DIbzXAauZZJsnAQgkbylHaYkR4Lhv6RTQFte?=
 =?us-ascii?Q?KMCjeNesZ/VtundQgN/+Ada+t2v0dIM6ZBvRaNK8Iys5cyQ/cE0xKiGWP6nL?=
 =?us-ascii?Q?T/Da82egLTNaqbIL/F0iHQSICXq+pnsvUNGf146do1YVExa6yLNcfjkYVwC9?=
 =?us-ascii?Q?be3pdWdyNWLI9trXIItYoiTe1LyaEXfFoVVEVzodbsjVEnNH57S2+awwwcQh?=
 =?us-ascii?Q?SJKqkCD5QQEgKN+5yGODIvhIB9o8IbIzzfSDf4j9Qgtp6UOWjCsvWehNhird?=
 =?us-ascii?Q?V+/x+msOFSJbaVeHRjbphGrEvJB7OV9cJ/q84XTEXKl94NTIq1u3iHhWcuKc?=
 =?us-ascii?Q?AfrTyLB38mMfGSa6XkPC0ZdE0scCy+GyxT8mmXjAnJGhXaC+J9BveNEh/gqO?=
 =?us-ascii?Q?JxJj2rRKF4186WMYgzcxSrGHfG7YYPYWtPa/n4P7e99LGA5GF3KFCOPTKP6f?=
 =?us-ascii?Q?+Jx6lhGEA4VxE4Gt7NhrbEuBWNUiJP+0h8wviEn6OcaB3CVMbk8DluggvtlE?=
 =?us-ascii?Q?oVF4ope3AYu2ssqRSZCYsY5M9K/2P4HphG/DmzU+W8k8tP4rktqqdP4uclDB?=
 =?us-ascii?Q?oqJxpJQNfdsrnrlUQc1+FF4yn4mOaJEitCicSVVyOlBykqvkS9AKIdIpq3pl?=
 =?us-ascii?Q?bQvhhCYB6t6zsVK0tRdkkKrCd/luBFSdnrRKFw+OKwcaTU+VEdL/RxnJ/B3U?=
 =?us-ascii?Q?+G1C/CrcxbU880f95meCCd8nJSFGoI1I6AQk0fuL6cfuC5RM5qmzwIHxbILl?=
 =?us-ascii?Q?rQossK886QApTO/O7VoicvNVGmKpt/D9507hXPG6Jh75qkezDk+u+j4GsJb7?=
 =?us-ascii?Q?H5Qrbv/sEZUvtHd3YYG+G+0dDWwPEoTeT9E96jqUvOpY6Al5HVJDDbz+YkUH?=
 =?us-ascii?Q?B4W+V5utKfgJdYfIs11+OdLftLQeiR8VKXq/CFQQ3Mtd0fiv5zBNnwXW6yGe?=
 =?us-ascii?Q?wI0nNiMT3ievu3Eluh+fH8RToU/kxNPE+Dfymyik/1zdnj/ytzBSkMN044XG?=
 =?us-ascii?Q?dJhhzBwLqHFWyGSLIXs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70228e1-afdc-4ad5-5549-08ddf6250ac5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 20:01:51.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsG8E0cbqW5TJ+ASE8e562sWILzOrsE4w2E3AIE6Ha5W8MtVrXfSMgKWN32LPz0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

There are more failure conditions now so 400 iterations is not enough pass
them all, up it to 1000. The limit exists so it doesn't infinite loop.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_fail_nth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 651fc9f13c0810..45c14323a6183c 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -113,7 +113,7 @@ static bool fail_nth_next(struct __test_metadata *_metadata,
 	 * necessarily mean a test failure, just that the limit has to be made
 	 * bigger.
 	 */
-	ASSERT_GT(400, nth_state->iteration);
+	ASSERT_GT(1000, nth_state->iteration);
 	if (nth_state->iteration != 0) {
 		ssize_t res;
 		ssize_t res2;
-- 
2.43.0


