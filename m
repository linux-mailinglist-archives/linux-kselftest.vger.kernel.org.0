Return-Path: <linux-kselftest+bounces-24617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B68A13191
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 03:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BDF16418E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 02:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958B70809;
	Thu, 16 Jan 2025 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NWzEvkGy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248145948;
	Thu, 16 Jan 2025 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736995940; cv=fail; b=iWPHBwU7dUvbMovDYn4KRJ3dB0vEA2GQchniRn+H3KdZGtKD38AmbheeqctPWQ8WUdQqpcuaD8fVgdOljAuMLqHnkbFjI5+UGQ5WynPjjNyzi1VwFhETyUHjho0z6nSj44BziWzsKhdy9uELczthggcUfcf3mBmxyxqyfm+sGrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736995940; c=relaxed/simple;
	bh=adsmEqGZCK0prbrWadDRiT0N+iDbUM9wlKsTq1JO6WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lX06cK2GfC774yM2DX7zkhAXHOxydKx5zFfkYKpWfZrVV0464yu8yIZyrtFceGwEYECgn8OBZQczWHjN4HjLtRrABy1A/vIvoV2i1CYF68FZOpmEGLqPWr5jpqR8yA146cnhOlC8XiFCebgblkrKB494GtHhjnv2CJlzI8Y0XdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NWzEvkGy; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fqgu2b4ZgqbdAxuNTt7GA/THx3lITv2cOE+ivNSFvjxlC99aeL2iwSbm/HKDxt4f0eYeR105EkoIFL8c0KpN7ld/1kv56YXG5UpXUmXv3f8rqizAWzh8hJRmNqPiJQa0vDLBHgF6t46EBTEKYkO9JJoiTfT4eIO3sa7f3go7HXrFkijOxhglmdIr3geCwh/YsQ1LrN1xR/8DXCkwL9aKUqZGzNrwvuLDslk6FzoJrSAyyjyY0RNNeZ1j7LBdFBscF/rzLwyQywd6c6Wh+R2uXCf48lTFRQWRyRLhebEYCN9XEYRmORGLCqYo61vCBscL8x8Ta8fht3zNMTN554avEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc+wLrO3HiQReXlVYseX/TpGg3XXFP/0sufrP3ufI1o=;
 b=RQ5C+pQnN7ojmaKGJbcN07S96Z72gH4vQlkUahWERv2nxhql7PNNNvtc0J+Dzjjjm9BN025YdSHqxCM9Afy4vl4iVPEgUp7Be4WhJzPRBjOa396EGu4XQ7TF2lp5xM8x3f+iPvEZgyeRBWlKXKCiGk/qBzWZdwaLJK/H/+IV93p49IDA086A0WK9pmyhq/Xit2X+p/sNkHKBiMP/qDGo2yKPDs9pKi0A+6ripy8SlWl65dh4fuHIKQQVrFDa2/HssSRRmBswbVhx3WTGo+uTaNpzZ0b6kpag5q9vVYph4pkGaUdfyg4pZFtEwkk+3ayNlZc1ZMpLD1ttfaOvLJg8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc+wLrO3HiQReXlVYseX/TpGg3XXFP/0sufrP3ufI1o=;
 b=NWzEvkGyLO/Ww/h44NmWsTsiCPCtwbO8gbrq/IEH8v+M1olwUS4si+oE7ZiO8xeB63cK17JsCNKvpiKs/FYeFYJLYbSQm/dN31UZ0sCb3BxMbJTiNKduMLQNQ3bfusOTjhTzC5llBP74hEnmiadrz6ms4YTEUX3oRR72bAqNpflLImQ0JYvcwfygtljvFIQ6jYmnPK3aWMI8Nk3uxY53Dr8v7DioxYg1sWduJ+6nGqKs0ZzPuX/FFg7/SMlFpUmXTTqjP3LcKGRSDuLTI2D2UxGvgEeQkXowIvVF6h2xAlQb6A6vm0NNj7VN6pfGcxsd0ZmfoC+i7K8gwyZsbS4AaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Thu, 16 Jan 2025 02:52:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 02:52:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Rik van Riel <riel@surriel.com>,
 Alexander Zhu <alexlzhu@fb.com>, Usama Arif <usamaarif642@gmail.com>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 2/2] selftests/mm: add tests for splitting pmd THPs to all
 lower orders.
Date: Wed, 15 Jan 2025 21:52:13 -0500
X-Mailer: MailMate (2.0r6208)
Message-ID: <4B01C0D2-CB4B-4A9B-A69D-7C1357543FB3@nvidia.com>
In-Reply-To: <20250110235028.96824-2-ziy@nvidia.com>
References: <20250110235028.96824-1-ziy@nvidia.com>
 <20250110235028.96824-2-ziy@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:408:112::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cafd10-9ee1-4acf-48b5-08dd35d8c8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kPOzfVwLXGOorJwbY52ZfWbIv7sNhqxPstE44ZM0AFqhUGsmY73dcvllmpU3?=
 =?us-ascii?Q?6IiC9B1fSV5AaQqJfIskVtFpx44CQzDVInER1LDHraI1xpxdy6vv9Iv/A53g?=
 =?us-ascii?Q?SlXIh8ZEbBE2LITM/QbRnM06+ujqhGsbYcK0GDjoGANXbDw1Miwy2gGb6HXD?=
 =?us-ascii?Q?7CKk51u7sYYAdwWlJuQfE+rCk1H4NdQ9Z7J4hTKnMGFd0g4oQwHCWifZbezy?=
 =?us-ascii?Q?xbAjGJ8/dhSTgnCjpLPs5yIVKtdJSkeCbxvRvzMHHFXkzFWzU5GqDkUzdmaK?=
 =?us-ascii?Q?9Qj01c/jPdJr5F/6DKJQ07DWcvnp8vLtXuAgE6TlGyPrDICqP5ZI7c9+jLLi?=
 =?us-ascii?Q?qEzLHJRUW9Kz9siBFPl7lXfZq58Q/VKbQvfreqHV8gUxcK9xpWA/FZE+S0mF?=
 =?us-ascii?Q?quq03xXczya25A3tU8ziuY2eDB6mkYKgLaTpghQ83I6IjvaXt8WXYJVNEkem?=
 =?us-ascii?Q?FlTTTIidu3hAngyOdqFnLaPxhQLmNgkzy8nXkz0AbXelfuRIERHn72aMKPsT?=
 =?us-ascii?Q?6ZOqmk6mEsN/z7ood9eYovekiOSwfWTpoNyE4vz9zlqZF2Gridszfjz3Q/kx?=
 =?us-ascii?Q?HxEeAz6VrlACz9rMsaDZqnujtUfMvwz8A+XgH9VgdxHK+IAbXp+m4ONDGsJB?=
 =?us-ascii?Q?gllRdsdwxdrn5VbIllmm79PgTx+Z/sDOSXCOIlrdMjNWdrf8PUo1Z0kuDUYF?=
 =?us-ascii?Q?UQA3416STaTySilqEY+eorZxtrWl/JzKmWTph4ZNfKUIj/1XBzInqv4zhBZU?=
 =?us-ascii?Q?q127KvAleU993b5ovVRDmCAGj/ueXgmUDW0dGxcOso7Dks6JXXiHb3pLg8St?=
 =?us-ascii?Q?LxNul4Fw9pnYQOGnfCDEvU+f9faH5PZ5HjwyjhT1HoJhvGpxTs0VYA6Wr0KU?=
 =?us-ascii?Q?eOo+k94doDINOePJXbo40hnGTnBKg9NdfWZP2Gr5TLY/jhMGSFqN0eW/CdL1?=
 =?us-ascii?Q?Wcl8p54KnyYtv+jEuApA9wwfugXIA/0OnOOY6Bv5n8rqIStuqkJoj4+C9pBz?=
 =?us-ascii?Q?iyL18bhBoVNahnFJ2RU8lCCuZnQqQ3Jh3nlZZzLP3lxGgrvr+XWlld4oZ899?=
 =?us-ascii?Q?C/sIstU2vZSry9G2kN2vCvjBuvpqxiEBiiQRK+jY69EVba13cjkS0Go3r5Q0?=
 =?us-ascii?Q?qGtamAI+4uTFQW0q+W2vY9j0zLDwyPSS2IZ1kFlNizw8DEPtBJVM+qcPUOua?=
 =?us-ascii?Q?CYt7cNWdYt6MhtO5UCPqUX7ztJn4gbcmiqK72aMZBCqNbFlQI41yJo9zKPjr?=
 =?us-ascii?Q?8HMf2uj6mfcDaMfgq4j9KYsdSGAMyYHU8zDrHpDEiGYwDJoUMilHwdQBIEDS?=
 =?us-ascii?Q?QmKDUuqYxtHog6xLvuVBSe7eb80iDGH+LeOOI+t9w4Ip/YQch2dWwB1aXTO9?=
 =?us-ascii?Q?2oyEsFx2wQT1UiHZucSItJEsZbiW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4WPaTZiAJ0EmhnZujsrjAqoKFgV1bz9Ms8JzL6i0Din0s2/BV7xHsB1bJir?=
 =?us-ascii?Q?HN4q6jEVQBiVyjHL4cG4nOBBvBoiHjR5wOsKp3sWbNl2Y5CVtHAxdamg7bFH?=
 =?us-ascii?Q?i6Nd49xaQdlcP+kffs/7jLqW6ru4wd1WfG/lQGNIn3K5lVKHow4S8m+0HNNQ?=
 =?us-ascii?Q?WZ5cwQGgRZjmJUxeqnuhym5Q05TPLFzajQwPP4mxIxbXciqn5HlDs3hRusr3?=
 =?us-ascii?Q?TITMlAAeOiihHSK0zGKHbTj1a8VVgaeqV3Hgs57cZT0xPZe+reznG6hRnUUC?=
 =?us-ascii?Q?1IpEkAEf3HIzgfk68QEzf6paP33W/tUzfMkMUkWKiq5W2+nHiR7Tz3WA/BKs?=
 =?us-ascii?Q?qs/uOrBlm7MKFiGWldJNZzC9RFQoBK0HaCN4CNgpXcrpO5FByfaAQx1eHno9?=
 =?us-ascii?Q?Bpyv4RTlwnLXQ0qAKiAmg5w6TgcJ0bwwtNXKk0lHa3DR5109qaI7cQbK10yl?=
 =?us-ascii?Q?8nceId2IL7UHTVp7Hi26UZIcyfoTcdQZDa57CCUdMLqc+JVy7hVXx1EOZyQ1?=
 =?us-ascii?Q?OO02+1BKJgIPrv38d+kaoKCNBFPBWWa3wiGtJXOido/KgzhRdpjtTBWaak8w?=
 =?us-ascii?Q?GOMm5HSprUHY9R2nhpqZsVyXD8iqZo3suOrcIv8d/TsophojvDGdUXZKL7Yy?=
 =?us-ascii?Q?RmnInsXwgaNUq1Rr1uFhAW+Mbj1tA6fY9KZhYFbdapxfP0UBH61rSiDZnIaN?=
 =?us-ascii?Q?FmtVlmXNzHqwsIcuGU91ckj0ZbhKCiaIxS6bqDOdg1zb8m6TlzjEL6/uzA4V?=
 =?us-ascii?Q?Vl8S8ZJEZjflJj7kEMHAMCfgNpuWxF67/C2wujEpLVbQraXv4QandMbDVXn9?=
 =?us-ascii?Q?BwHILsxr9XGg6r2Py2RmNHftU8cEx/duKBkbp6U/gdG2ZuMWcekFqX32HPsX?=
 =?us-ascii?Q?z7IR/QUiAuaCnw9yNoWBjIUaOzLBL63/yxlko5iG/u/byJJmdGrAkcsbkoDQ?=
 =?us-ascii?Q?bXumeKuydwu4Fx9Z/cIx5wB3JdT9xYtTJUjdoKUJJz4Kijza24buEepe12jK?=
 =?us-ascii?Q?1FOEC3Ee6v8H4QGzOPyWob8QwsWyNNfRlRt5M/S+lscy2AHfzyozhuYrECg9?=
 =?us-ascii?Q?btri68HcTrY6e7qd6OqtwsJuACzikqc279cG8yWy/ispGq8B1CbZbcKffhfb?=
 =?us-ascii?Q?pVOXTRHHC2PoBT4So8vg3DT2q9psjGER9mcjjpWW+RmfD0rLgwaauXrsZyKH?=
 =?us-ascii?Q?csAbqaaowsdlg2Q3AgaqA1oaO8eEzINYz8xYO1cm4JaRP3/+1UIN23tTR1p4?=
 =?us-ascii?Q?ajnEDdZ7qKQoFuRuiL6AXLnfMApUO1RNZxIoCFxEP6qMU/tzkh6FYL3F8tTn?=
 =?us-ascii?Q?fqyURiSO+/fojjaHNS6nPslWvATkfxv8XcgW1XuL5rIrjC4JUi8rtgik1jbq?=
 =?us-ascii?Q?2+sxJHEu2CldRzIlfZrg9Pde3xEFE8DRrZWXR/a4+hBnqSREFpRNiXlpaj6X?=
 =?us-ascii?Q?+U+bLrEE56FjT4KNth05PC9FuhPADWbX/p2/bveRV9JnIS4NoE7Y6Ecddd5Y?=
 =?us-ascii?Q?AkN1nhar3iZYAyLQoRkSbgLsi10nLwcA8z8fYww33qGYCi+tsPZcZlO0q4RL?=
 =?us-ascii?Q?tmVqwiJlHgBnGJSnt1w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cafd10-9ee1-4acf-48b5-08dd35d8c8ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 02:52:15.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c53OXJ2+pCNISnT/BYEuh8sbMjVOr+yPB+uMGtLuGSYrWFYKEVCvGJahRNfGkgf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

On 10 Jan 2025, at 18:50, Zi Yan wrote:

> Kernel already supports splitting a folio to any lower order. Test it.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  tools/testing/selftests/mm/split_huge_page_test.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/=
testing/selftests/mm/split_huge_page_test.c
> index 128004308233..3d3bc40a268b 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -144,7 +144,7 @@ void split_pmd_zero_pages(void)
>  	free(one_page);
>  }
>
> -void split_pmd_thp(void)
> +void split_pmd_thp_to_order(int order)
>  {
>  	char *one_page;
>  	size_t len =3D 4 * pmd_pagesize;
> @@ -164,7 +164,7 @@ void split_pmd_thp(void)
>
>  	/* split all THPs */
>  	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
> -		(uint64_t)one_page + len, 0);
> +		(uint64_t)one_page + len, order);
>
>  	for (i =3D 0; i < len; i++)
>  		if (one_page[i] !=3D (char)i)
> @@ -174,7 +174,7 @@ void split_pmd_thp(void)
>  	if (!check_huge_anon(one_page, 0, pmd_pagesize))
>  		ksft_exit_fail_msg("Still AnonHugePages not split\n");
>
> -	ksft_test_result_pass("Split huge pages successful\n");
> +	ksft_test_result_pass("Split huge pages to order %d successful\n", or=
der);
>  	free(one_page);
>  }
>
> @@ -481,7 +481,7 @@ int main(int argc, char **argv)
>  	if (argc > 1)
>  		optional_xfs_path =3D argv[1];
>
> -	ksft_set_plan(4+9);
> +	ksft_set_plan(1+9+2+9);
>
>  	pagesize =3D getpagesize();
>  	pageshift =3D ffs(pagesize) - 1;
> @@ -492,7 +492,10 @@ int main(int argc, char **argv)
>  	fd_size =3D 2 * pmd_pagesize;
>
>  	split_pmd_zero_pages();
> -	split_pmd_thp();
> +
> +	for (i =3D 0; i < 9; i++)
> +		split_pmd_thp_to_order(i);
> +
>  	split_pte_mapped_thp();
>  	split_file_backed_thp();
>

Hi Andrew,

Can you fold the patch below into this one? Anonymous memory does not
support order-1 folio, so there is no need to test splitting to order-1.
Kernel will WARN_ONCE for split_pmd_thp_to_order(1) test and the whole
test will fail at that point.

Thanks.

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/te=
sting/selftests/mm/split_huge_page_test.c
index 3d3bc40a268b..4b47ab544a0c 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -494,7 +494,8 @@ int main(int argc, char **argv)
 	split_pmd_zero_pages();

 	for (i =3D 0; i < 9; i++)
-		split_pmd_thp_to_order(i);
+		if (i !=3D 1)
+			split_pmd_thp_to_order(i);

 	split_pte_mapped_thp();
 	split_file_backed_thp();


--
Best Regards,
Yan, Zi

