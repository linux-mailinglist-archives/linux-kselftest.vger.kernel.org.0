Return-Path: <linux-kselftest+bounces-9672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D348BF40F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 03:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEED281EC0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 01:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FFF8F4E;
	Wed,  8 May 2024 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lw+oum2U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719182563;
	Wed,  8 May 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131567; cv=fail; b=YLDZLjdHzxDCWWPJ587H6Kj/M96q19ECMomyCiKgMWkPX9WYRFpv/hMUC4m7UtxlCQNpVjxkS+FCI9Y/fQj7tQ7gYBOlfPxBnYeuGlT+OkPdImAzCZnbV++KF3lTjaiS5MKvxB/bLdo2zIHihH98iiOFJb/cXX3VRllgEJuDiKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131567; c=relaxed/simple;
	bh=ZxXQuSjp9BSREaCVICTAKTEegXEMbcRm3yt1+ObnJ9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PfD7l33o2ympN+H+xdaW2toDnHdVJ/jq7L4waevgePSy3dqSC6krZZ1oiHQRZTF4SUVnTdy6zq4vqR5UEWNG1kf77isS7E7V2jdkq4MJt89MnIE6eLENoQirlU2c+BA36gl2FqAIwBSgLM911kZ8AD9t17MhyGJpEozQtWsc7XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lw+oum2U; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrfb0K76c6bm1ZaRDcjfDZ4qlFmWLY2yg8XD5n2vAK7FUwC5v6+gtdaqlDf7522rrW1w6htX25s3jXHuC9z+2Thz98/8czO2Jzi+P3CzdYuxCHUFaLYcK5NE6koLekZOnRFS9z6fmbfVkZmWCzg3XkdOPDzT9F+Ch6Cj6qVQkeFTQq5zmL4zp4JFdMQg0ziihChO+2d5qxycm6cp1eRPHoK5yqEskItSJhpGKTWK8K1EN4L4j7i2EnoZFfMDtRNSp4qUJ98Vh+FGIlv1pre2pWm4M5HL/9VghzN581PE/1lEEwSWXMx1+soXJA+BF8omu6gnIQ100HHPAm+PHvnMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrAnSojX4cjaiRBhd4cJ+Z13qRmE4DdA+Ijj1iFiKPw=;
 b=k3YmCEEJVqVv6PbLYTCUnp7P9INQEBJACEM4s8maDksDE3k0D5OpXLTs+gUhsdU6wONLSOwnqqw8bAECFJJ9wiFdlQpo7T9sFpnJx4WMsvmJrBeIZHmMDresD/GgjF65PjKs1gAsUdPvdssQ/Qb/DHcINyOUJRvNkeUX94F43cGddSoWoKpxNEMktXI4DnH04ZD5FRXJ35OTSmeCGBs6f0V3QCO4vjRgquen1z4Ai94FfGJq/IAjpYIjlS2yEfHP6XPVziK+lNzHxuPUjXfXUZo5xBKu4HxbKLuRHIDYBfDG2Sp07vsY779QenEsGtGqB2rZUlPltBUAaWvNTzQZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrAnSojX4cjaiRBhd4cJ+Z13qRmE4DdA+Ijj1iFiKPw=;
 b=lw+oum2UJhN2puo5dyfZEd01IJv7on+g+JkSvKnMulcBvJoh98HStsd/YlUTHcaBmrTVUrdGgK68c/ykgx5qAO3Ah0OfxYn4UVi2UV8Tw0F5fT+GIjTnMHfTyNPJOeYTt33tWnxqZQUQZ6G8cOoQUTh9+8o3Jx1NgH2qdZwEN0IGktoNObS8SA5OCQLlQeKqETDLci00I6poIZsFUMB7w9PpAjdJsIhz9AVbaKy9llEwD+Qo3gJNJihLnruNOqSyEKZw3HRIBK4DuexaNAxyyJOVJDjUdYvbw89DxdLnTxx5c9KMAVQ0wAgyoh+VjzT5turGAU/wPDCsSBLGRAM5Dw==
Received: from DM5PR07CA0081.namprd07.prod.outlook.com (2603:10b6:4:ad::46) by
 CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.45; Wed, 8 May 2024 01:26:03 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::d9) by DM5PR07CA0081.outlook.office365.com
 (2603:10b6:4:ad::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 01:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 8 May 2024 01:26:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 18:25:44 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 18:25:43 -0700
Message-ID: <7dd4b09e-b9ba-459d-bfa4-150e712f54bc@nvidia.com>
Date: Tue, 7 May 2024 18:25:42 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst
	<kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20240503234051.21217-1-jhubbard@nvidia.com>
 <9ae11dcb-62e8-4361-9f78-971d4c6e6054@intel.com>
 <997d7fe0-46c8-4b38-824d-083ab29f54ce@nvidia.com>
 <d67f4f57-4e9a-4715-b6dd-7b83a240b7dd@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <d67f4f57-4e9a-4715-b6dd-7b83a240b7dd@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4bc995-fd5e-487d-2a75-08dc6efdd38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OCtrcWNZQi9RSWViOEdjR3JSeDQybEd4RVR2akNhOXB6ZE4xQzZDb0tPZUJq?=
 =?utf-8?B?Mmc3dXlqZzdFaGc3UHJEejkzeDRQb0thT1lZNCtUK0ZvZEhXcExjbURaaHdi?=
 =?utf-8?B?RXpsUVp3OWJHRkh3SmU3N3BIMktDVitmYkFaNDJtamJFUmZvdGUySlNma3Ry?=
 =?utf-8?B?WHc2Mlo3WW4zekN5bW1sWktacFgrNnNHeTRpcjgyQUVTRzVkNUxvVW1vVk01?=
 =?utf-8?B?bnRyZHJucGdkVXVQeisrWWlTdFgwRnJEOXQ3RkxmenFqckcrOWFkMndERVhW?=
 =?utf-8?B?c2Jia3RZY2NRdmF2WmVUTVZTaXY3NGhOR0VnTlNCNm5FQ1hkMms3YUExSm1O?=
 =?utf-8?B?V3l2MnduUjcwcXlyNVJjdFpkVDh4RnlQZmM4VnBuRk1yRHF3Mks1dmhDTHJW?=
 =?utf-8?B?Zll0VFU2UThyK3RFQ0Z2UXk4MFh3RXJxWGoycStzNitkYkFhTTZkUTVLcjQx?=
 =?utf-8?B?N3dDTlJmQVNYLzNzSXE3VVUwSnYraCthTXJBQ1liSnVvdXQ0ZTV3NE1zNFRB?=
 =?utf-8?B?QUFpU1NjaWVUNWJ0NEQ1WHUrSUtsdXVuZExOSk9CeDZPKytqcE5ncDNTVjlM?=
 =?utf-8?B?a1ZoRjVybG1hZVNJMWZ4ZHAzMWhIQU9lcUVpd0t1VkkzUmpabWlrREtPOUp3?=
 =?utf-8?B?c2Z6S3d6d01JU3o1REtQM2hwQW53dEtXWTZCQnIvdzQyb0dqMDZneFoxVmNY?=
 =?utf-8?B?UkNJMlpubEZlTkszaDFCSDlodEZxV0ozbWdsRU9VTE9GeGYyWGs2VHRLNFdM?=
 =?utf-8?B?ZkVBem10YkUwTDB6YnN0OVUwZ1Zkc2JaWTJLZUZSNFhuT085QWE4OVUxZTJa?=
 =?utf-8?B?QVdGT1lmZ0UzZGwxcXczSVd4VGZaamxJTmRuVnlFbGdmd3dKMldvVkw0eEVZ?=
 =?utf-8?B?LytFOW42MjFxZkZGaHkveklkZFNWbEVvbmdqVjE1V3lMejNESzIwR2RXZnRz?=
 =?utf-8?B?T05mSGs3TjhLdXRSZHhjbFF6ZVozMHVCdmJPRDhna0QySXlUVUt0SklUL2J1?=
 =?utf-8?B?NVE0SDdJVHJYUXp1SENjelREVFR0OG9mc0JpZzhBTi96dzBrRVlrQ201MDN0?=
 =?utf-8?B?LzhwYmUrWmJ0cmsvamxpY1lWODBHaVJ6dERDUWcva1dWZGVVS0VleDF0KzZM?=
 =?utf-8?B?eWZLNWZrUmtqc2RteG1EdjRzVzhwdkJmUENaWlp1TDVWcEU4UTIzSm9MTzVv?=
 =?utf-8?B?S2hzeUhabkFuN2Z0ZHo0dzA1THlEMUxua0pwVVFvcDdnUjlkSktYZThLblRW?=
 =?utf-8?B?T2czQ1FtTzN2Yk13U0NCYkgzZGJKZ1dLSkNkNlpvcG5VeDl4VURNYVZRRjRT?=
 =?utf-8?B?bUpCWEhPOEZDT0JBNzNjRFhyNWtkcUpLeFJpMjNBMUVCRWhZK0UyTG5rS044?=
 =?utf-8?B?eTlTaklNY0Q5MW1qVzVqMlU5dnJ2dytlL05USk9FbnE0N0ZmalppVkE1K1Q1?=
 =?utf-8?B?YnJBZGplMStTRThjczNTbG1PZjFmV1F5TE9WUU9TTjJoMDdCOTZmTzdWUzNP?=
 =?utf-8?B?SVdSd2Z4UUZyd3IwekpneDhtR3hDRUZYSmNCM1RoNTFZNFZ3eVNKTkdwZ1p5?=
 =?utf-8?B?V3ZBNVR6Uko0UVlzMllOL1V1azE1UVNQd2R2UmlFR0hPSmkySTdTbUt1SS9v?=
 =?utf-8?B?akNLL2MzYjUvVU42RURUMmRJY1Q0SzBXTU8wU2t0amIxUjE3NmFUKzJrYUpL?=
 =?utf-8?B?OUpmRGlSeDUyckJFWmd2WmlEc2tIUDJITkc4T0dEaGxQWitBaS83QW1kWmFx?=
 =?utf-8?B?SThIbTdhOWxnMFo1d0xQY2YyV3VTNCsyZW5pcUIrVzVqRUlIdVlTUm5iN3cx?=
 =?utf-8?Q?vcikY9x8aPuXgsf84UrZNZQBxn4yhcIeiRkXI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 01:26:03.3138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4bc995-fd5e-487d-2a75-08dc6efdd38e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243

On 5/7/24 6:21 PM, Reinette Chatre wrote:
> Hi John,
...
> 
> The following (what was in v1) looks good to me. What am I missing?
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index a81f91222a89..05a241519ae8 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -40,11 +40,11 @@ static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
>   	int ret;
>   
>   	avg_llc_val = sum_llc_val / num_of_runs;
> -	avg_diff = (long)abs(cache_span - avg_llc_val);
> +	avg_diff = (long)(cache_span - avg_llc_val);

This deletes the abs() call, because I incorrectly let clang's warning
lead me to believe that the abs() call was a no-op. But both you and Ilpo
pointed out that the math breaks if you do that.

>   	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
>   
>   	ret = platform && abs((int)diff_percent) > max_diff_percent &&
> -	      abs(avg_diff) > max_diff;
> +	      labs(avg_diff) > max_diff;

This hunk is OK.

>   
>   	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>   		       ret ? "Fail:" : "Pass:", max_diff_percent);
> 
> Reinette

thanks,
-- 
John Hubbard
NVIDIA


