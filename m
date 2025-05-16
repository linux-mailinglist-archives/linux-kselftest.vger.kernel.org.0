Return-Path: <linux-kselftest+bounces-33184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D659AB9D58
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6171B62A10
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7472601;
	Fri, 16 May 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JAfuWXb2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366960B8A;
	Fri, 16 May 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402197; cv=fail; b=ciArrILVD/o2x9h+4LDyIfu+amyB6UM2eIGVFoJ9hZz29sSiN+Ts/DnM9wbZuv7RRn1rgAlhUNZAoBNOz7Dm3VxTdnqoGHdEo3wm8RGuQ8D0hAX4jmH3HfkhAwd4mWFpoBwLT5AL2b3OQda1Hq5KkfpCwJvsteLoWS0QdX0mtZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402197; c=relaxed/simple;
	bh=IpxUqpUVwHDCpKFjwxJKmR9Y0B+s3UkK5ErfWw+W+bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f6uN19me4MlG6a9NI0LIaL/pKxVU5ZoyvPmzov11trou4vOsMoGDt+0DNH51sLzhSUoOfZ1ZulImV1Ex2Hm8XlUUyajYP4zMfMz0c5QNsy7T5SWyBxu8fZZTbGVa94Ikr9+j67xHG2LAhm8YXW0uWqxnRpMZ95IHTajiVoikMLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JAfuWXb2; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0hiDqByQxBi0dISxMbSZzRPWMJ4t2TRXFSWv1VknY0MlO/esq2tMv7D7n6TpHSnJR0ZAPUiR0Epz1sWD04BI03U+tVDeoeFjLiC9UHCbHMOEILgQhl6s7aSWGvob+WQ+xe5Efd29vjDSjf55H+bVDvTp7y0xC9GLf2hy2//sGHIyGDCg0aFfMmhb5Kw7XOOIv0OQ90mecBLJKnWuxuVnnIfNLza4UAWK8E6l7W+mK3hTfYoIi/yuRF1H3KzmvSAQsop/LGJ5T/5pA6F9G/E4FQMbuinZks9uxeJwk91Yl8YZrLxOm0lm1gWGZYJBE8ZpX+20G2pj78I8TGj2Me56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qM8yLSa/7I7fkF4JMC8MtKUceF6O9KR6RDYEH4APBM=;
 b=cfbeRZdfmwp8cbXSnpT4qBUG962YJfflTRDNgK3S9U3jMLQ+wbeYduRHM1ngqs7yU+THaRdWi9J7dLojIh/IgmLkfKFaN4XhqifGLNGy16eU5HQbLEzVevb/g4ufK6/9MB2TzF1nvbU33q9r4yeTlNpiwphNVdMGTOEi7nqcWSa9WfGmJMsR+60JkQpywxSRwAxiWgk/B9M3uVpswlzX9BAg+YJ2qr43yJoiW3IkWZPD6kl8B4A241JMttjd5IloRc2TMYtutx3MQtMigCKBC9fsK5M/2eZdObpiRGBQiDOdHZxqsOiw26Jel3c5HPM9GPXZe4bFKCm/N0qno81Xtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qM8yLSa/7I7fkF4JMC8MtKUceF6O9KR6RDYEH4APBM=;
 b=JAfuWXb2hP14RCeupGn69Y6JhHyzFHkbsrLKM3jisxhNyl1fIrE49vEKSYiKgIeEnGwTiK/HpcwK7gRbRAY3feOqynTqnSmymMwMwLnQ2liJ9tsK5SdBZa8EDnp40+oxdWeEHGC7VxWXGvVpQDDZuUi5szlBP1j6jGaHpSsljug4wWJRikWHNjDtaBhzvhU5/RA6LtmCpf9ddmz1trbhZGj48xGlC9VaL3yXaFMn7BzHA+b7RQlqMWvgy+3NCwFGy34374Z1a7wNKFhjE42MaET0dnUdBrce4mPKmMohDtd+Xr8ln+klAlW9mpxdpsY/nGAkhvQzz4j6VEGwa/6acQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 13:29:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:29:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Pedro Falcato <pfalcato@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adam Sindelar <adam@wowsignal.io>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 1/2] selftests/mm: skip guard_regions.uffd tests when uffd is not present.
Date: Fri, 16 May 2025 09:29:37 -0400
Message-ID: <20250516132938.356627-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516132938.356627-1-ziy@nvidia.com>
References: <20250516132938.356627-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:408:ec::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4635d3-abd0-46cb-6af1-08dd947dbc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RmMYdeQUuGYkgROszyauTYe7Oc1UJg2ZXy30kV2wUWPa77jMxfP1E6m/Swex?=
 =?us-ascii?Q?gXd7d2baDmUKiLf/tzCVbyqlVZ46zFaMxPefVWH98k3W75J5wfAx8NichLqV?=
 =?us-ascii?Q?2bpaKAW6Jicsl7hW+Qk9wdSgnmAswguIz1oEtjYxwik8chG4q6zztev3d8sf?=
 =?us-ascii?Q?uTzE3x6Sgqtm0os5XL7xY1dj36wK9QLEbgyXf35Z8goPwCtI63SC0wXPU4td?=
 =?us-ascii?Q?7+dftOWw/ovDqOn9WF/qNcGLwHJBjj590RRxpAdY+8Y82FpHsXf+/dmsKNZN?=
 =?us-ascii?Q?AcFqyiy19uFy+N1r+zkuCNu3IMCesM89eQqYeMjlejgHLF4xro+HnbPwADO9?=
 =?us-ascii?Q?k1ibqmc2Hi3ygEdZULHgI0a8PqOEga8ZXq3NOiYlcKlug4KQAV9aTVtiZWuJ?=
 =?us-ascii?Q?uWlT4F8QHyndIIUr9TWa1+H83wfpd1KTj7dDeGbwtg7dW7wuY/cs3xTjz7v0?=
 =?us-ascii?Q?m2IRzgEC13NrfVkyUcfeNPFqXowdKgjXXVzo5OiiVorxwkvXZkD9PF6c+HQD?=
 =?us-ascii?Q?QPRQpxuUXaw9H6VX1CnEpNsjCXSG/i6irDKOSbJRXtuWu4FprUjt5p/3m4vj?=
 =?us-ascii?Q?9SEGqiIDHC8RE1ObqwbDA6omMGFMicCN7JA+0NpX42Ts1pas4LYdXFJ8s/pX?=
 =?us-ascii?Q?CTdy9hgAD+Ppub4ogI0XHL6gmtYIxg4qH3NDefL5n4j3zabvBtVrP6u1xoXs?=
 =?us-ascii?Q?EM8JwVceY8k4Qp7q+xl4M6vSCx2fwD5NloL2jGggirrqVI0qMP/OckhI3/VI?=
 =?us-ascii?Q?UgvPb5RkC1E0ycVOsahgbfKOFm7Me/gDDHI/wqAQe+HdX4/cgAdKMz57ZQ0I?=
 =?us-ascii?Q?YFPdJqrwe/bwuqfKeRtzmI767ja/OBlFMGnpwjc1mqwlKHJhtdxjMRlpgUgF?=
 =?us-ascii?Q?Vrq5J7lviHAqn6bZcu7/H/weYS1BGfQvAKROFIUZHS3gFaWl9vhh/VqccJu4?=
 =?us-ascii?Q?iCmH7thiowZO+5+RXQ9A86Kd4rsDYw28zqYi9ZK1Iu3S0qu+2U4gcLPZvIRy?=
 =?us-ascii?Q?9vcT4HSrt2rCVNWP35HKxBrqJQ/0nyzibzvmdoGOdGpy+l+xgn9cCrKdCQtg?=
 =?us-ascii?Q?Ft0flM5ntoHeOfQZxY3doJN6cgjJVhJfxiKT3V1TPj446nfeCgqpnrsk8R4T?=
 =?us-ascii?Q?mdaMWsK8hq7mb2jZ+wTOdv0TvvQzqeCWHTChOIyrubXkGFx7dLwjf4FEnEtp?=
 =?us-ascii?Q?G5426URcc/tkDpCnJNLqCllOMlbpqqV6g/zhHWv2na7wdURu5vXGd5gokvIp?=
 =?us-ascii?Q?Z9uY6xbG1r55uQ+8/ELYChwnYoocgGfrRy21aTQl6wkCxeWEUkrvH0l62XTa?=
 =?us-ascii?Q?n7qb1TPMCj8MnuIZ+Skl50czArOxxHvNB5yxNJsnadsoEZFRWk8C+1omnhoo?=
 =?us-ascii?Q?t5HlJfshum4EjZkInKA1AXVx9apyEsAfBXgxUQ/WRWY5TsBghuEHZ2w0/IKS?=
 =?us-ascii?Q?kx+L97jHfxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7arupAQ9RzIneSNfz36Em962BrzpM/LaTS56PMac0cPcTJqM8i1jObUqY3Jk?=
 =?us-ascii?Q?GX5C3MaT25h7OmP1cyLK3sC6FrlmCb/pMQ/pg4kM+BXySD1TqlVt2CQS1ayj?=
 =?us-ascii?Q?dA+R4kVQB2SbB5hAkBmt0Wz3McxnKGOlpxi5AFIh+EflguD4RFnMzK/VhocY?=
 =?us-ascii?Q?bZlepj8yKkJldiDHBAWWnchiuZ8Yy+PL1WbPqjixGZwnE60OEuo5JzSNlrDD?=
 =?us-ascii?Q?5Y3+vWpFGEnY/vtsx4xXsmjQsuKUwfvnIL6pMMmmjWqjEkwTrkY9x5zd3mQl?=
 =?us-ascii?Q?F/+8/7SRuxK1mH/ovtTzCqf4+j5hoiAu00pufJ1/wy06QoL4Mrfu+tIIMOfL?=
 =?us-ascii?Q?W8S3G1eqEw1MwcjNs6BbRxj9vDONDb+MfbU7K6CGNUQ6b4/rO43WmcnL+ElL?=
 =?us-ascii?Q?yevPWhoZM8NJirN56nzcElEw7WbICF4Cc36EdA8I6QSNH/u940XC1k3PzAat?=
 =?us-ascii?Q?L7W1jruBeIESP3uyCSKptmA6c/G4X8gvjQVKkk/qBf5P8x+40Jsse+CwXg38?=
 =?us-ascii?Q?OCReBkmsVElObbhKPz5fNSBJmqfIFYRzzevCtgMBf2Y9gSS7Lf4Dd89lattt?=
 =?us-ascii?Q?zyQUkUFwAXutJJPW6/2rMRq3wnQTW9uZL7ztBtWEf6H1sVh+ItQ+4utrkCh1?=
 =?us-ascii?Q?j/DTyHeMXgaR//enyRynJ2q7tUB7fvej1U8UNXiqHJCVbstDhcy+gpL54rUN?=
 =?us-ascii?Q?gQGcOGiYR8mG3nZv+8Tebc8vg/e8urz5K/27O6OmG4KCz/qWxlVt4F4OQ2+L?=
 =?us-ascii?Q?Y64wckajurug1BtDQD+4xuCT/XlQknc9ML77E413NxWTEMqhplI9MItW7xiT?=
 =?us-ascii?Q?V1WS44j37COCEVFoVhAB5cI3P8pqUsWrEas4v3/jPc6XNjjoKARABjk/6TiR?=
 =?us-ascii?Q?K1qd8nk2UHGIAx+a/45KywJ8fLrKT54TWg04yEg0K+Hp/RlRPnXwk1szCVlg?=
 =?us-ascii?Q?yAX20/oGiWn93YzBPw7RIB7wwpCKvrNICF9rQmVc0/cu8ub2f2O2o5AEcXp0?=
 =?us-ascii?Q?DsEs3S+9CXZjlNc29DYLqeTElgv8+CLc1dzq4sfHtkQ+qVWL36i/r/zTwIoA?=
 =?us-ascii?Q?rkNyOkZ7nQPwIEHP8HY1eEtrZZMZVfzA7g9eCK3ABZtVuYYNFeM1pOWpIVU4?=
 =?us-ascii?Q?ibN4CsUmUt/9tm4NwQ9zWUNHnYSAXawMV3lXfH1HBZ1tAZlx971aJGw9tHYH?=
 =?us-ascii?Q?O9AMbKFP3QPjLkjUQrFzEUZ7xQjB9/tfC1/P5WLbRn25txb8yq0PuL/QAUW9?=
 =?us-ascii?Q?PHiHN8fqLxELMX5AmcobSlL7F9U7c5bbxwWHilzeGmTZK1Epk4nbJmbTYrMo?=
 =?us-ascii?Q?cqpL+y62MjmFnRCRWKYlIQjn7EOwCyWcpotx7BH19hgra+esgMn6hpGjZpo1?=
 =?us-ascii?Q?2KTUrqa0vNAmLjMBURGS+UEh/8kgZ5GcQrkJ6wGu2kiGuSkBHFmSIwNOqoCM?=
 =?us-ascii?Q?1NqEhRlD6Yo8QT89Dpn5xu2IX98kAQGisSEgE2q7uTa0Qn0hoV6ibLAl3n/u?=
 =?us-ascii?Q?2RltjjIykkrRM7clKtJDw5npXGioDcoXAsbM6gJu2Hsx+hWKPjM+q9ascwVW?=
 =?us-ascii?Q?oC4mab3f2YgHmJVYIO7xsXFEegLqLA4ZJxEkJRQl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4635d3-abd0-46cb-6af1-08dd947dbc97
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:29:51.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HKB28vCAl/EhGIlW5k3Yv7krq6tRs21+63wEh5AhJM8U6dCzJtQofVQoh5IuE13
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

When userfaultfd is not compiled into kernel, userfaultfd() returns -1,
causing guard_regions.uffd tests to fail. Skip the tests instead.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 tools/testing/selftests/mm/guard-regions.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 0cd9d236649d..93af3d3760f9 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -1453,8 +1453,21 @@ TEST_F(guard_regions, uffd)
 
 	/* Set up uffd. */
 	uffd = userfaultfd(0);
-	if (uffd == -1 && errno == EPERM)
-		ksft_exit_skip("No userfaultfd permissions, try running as root.\n");
+	if (uffd == -1) {
+		switch (errno) {
+		case EPERM:
+			SKIP(return, "No userfaultfd permissions, try running as root.");
+			break;
+		case ENOSYS:
+			SKIP(return, "userfaultfd is not supported/not enabled.");
+			break;
+		default:
+			ksft_exit_fail_msg("userfaultfd failed with %s\n",
+					   strerror(errno));
+			break;
+		}
+	}
+
 	ASSERT_NE(uffd, -1);
 
 	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
-- 
2.47.2


