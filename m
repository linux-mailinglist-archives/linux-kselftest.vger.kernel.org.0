Return-Path: <linux-kselftest+bounces-10743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D668D0EE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3033BB21DD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351716132E;
	Mon, 27 May 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FqGps3La"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0D5490F;
	Mon, 27 May 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843673; cv=fail; b=LIM9UwfNL2GzGAevjxXQI1gCk+afVHf5T5vspr/KtIHyquwoHGPGhh5ghP84nFILi61YphjKRGO0k949ggAnPMvHsdpTRJix1bajHtqIq+sySYnfnBvcpu0ClAvPKuuy6It0Fr3vAHlXjoCP89oqdX1TbB0GtEDCQlix8/p4mgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843673; c=relaxed/simple;
	bh=gihCW5m04bS2+gEDSeKFO1ATJfmQbUY5i7jlNe6gTDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4V381dNOFCEwQZ/iFbh9xN+P3wtwuSuV/7HDTJPtlyKihDq8owzj2TTZApOiVrGf/dm8+IjYJJrPeVHdmhfJYCTrRjk1KeerFQ85xw3sZDL86150XnnPm2dLC54+yPxJ0JGX3DA5vWBf1z6aVTQ65RktWM2pLWIIPawQCBqbN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FqGps3La; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbJu0G+7IhyZ1zk7p4IMo7mmDJ6H7h6Jc4WH9YALlXHATu4Hp46O0bMeBbN7Gtfepr7SMsL0lGCT5LyOnLFXq7DLofoTxaLRphOdfsyAKcqycOZW1SJCazYEWEMT9GkPUO8BaTKeGefKfaZWFglMWEK0jC8KMdRFh2GTpNKBjkzmlP5IoWbEjlAdld8TgauUQ3Cu6K+WgQTRhAzCkPj/bCH0NLrmcWNQio+/8tlt/uiqBQTZTRnyFzAR2/RNcaTjlm19YHR4ro+c1B9/iOfF60cYcJLSywrBDc7s+ZJ1YSXLzxy/lCE71wNv1YzJzwJpK4y9guvX99xJbMchOWIQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqlw1it8KDqJAzssbYcBZFDteKEWA6B8BUPTxuwUxAk=;
 b=jMAjWFtdNCr9hoOFXPcRantx5gd439nrGh5VdWBWsVJDWJbMQG52Oqc4vfTJTLbSeFqlUvUc5g5pUUFEswaZc+WJM3I/6wCn9S+ShT5fw9What3QhB3G1shRmCFWkQnT41Yki0guNcDGvAzrzuh1QSkYJF2Kf/YhWNQ7EqXTkaUvpl72caFIZTPV8x8ytOZTwqougq/lsNktDE0bGyC0nxp7Rb5CZ8XiW40MRnde33ALCeNBl/WZg6CT02Ds6/Z0jtp3laROcABuivhPpuohR64FjYCpkG1onOTAkxMd+ffyQINOoGZnSPzMY8ccxCqEKTAVHGQzuBHTiD8SndLbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqlw1it8KDqJAzssbYcBZFDteKEWA6B8BUPTxuwUxAk=;
 b=FqGps3LarIow1ITOspvCK0C8I80CF4MfNIS/MkzXzGpQLyJpQ1o3HtOo0cPOL7FS5EndJo0M3uoB0j+o8JXiXvpW2Sjilu9hDXdOAFwaAEwxCDhnkh7MukEx+WuVpOj3S/ipX290mg4NbIt5qfANsRv/XKk1NSqhFxMb0nvdNazlS0qPJI5Ll5TB4wwgfi4W6n9Ot/iF46x3VjHciHqmv6ej9SBwtLUBeE/PVkKK7bIoHIJwNjf1PdpU+PTiaXBItFVbmsHbpKvKENZ+k/WWBd4NBtRfUpMG2RqHAB/IRulV5m1vEowXPM5w7mA8OrGrZYlGKS0OU+6ar4N3aYbwrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 21:01:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:01:06 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/6] selftests/x86: build test_FISTTP.c with clang
Date: Mon, 27 May 2024 14:00:37 -0700
Message-ID: <20240527210042.220315-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527210042.220315-1-jhubbard@nvidia.com>
References: <20240527210042.220315-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7fa411-3e91-4f08-bd7a-08dc7e90201c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ypyK0Lv3hL9zSgKzTZ722r1F3FG6Ap0YAl5/98KRlACK1T0hJ3ZnxlkCibE1?=
 =?us-ascii?Q?ydLMZxcs0qUJAuCXUZqku0UkWp5aJJBGk/Ci9akCQJJMpk7LZN5SS9FvG+Hs?=
 =?us-ascii?Q?z9W1O866e48R+JXi95Khhg89eDBUEodCdtWndoWe+FVTW62IfVFuGyypdpkZ?=
 =?us-ascii?Q?wPg1By2YMsfbXZe4sRZ593Q3YE8TrIpA7ZgiwRG4YNzNYtWy4s77l9gary+7?=
 =?us-ascii?Q?wdQvuRdXbANn9PTkEwR/nHRC3cHw5YGL5aTg9FurxwBLd9FbhELPVoV+Xt7E?=
 =?us-ascii?Q?zn+eQ1KDTgco6OQLk7a4uAtNH3eiI9Lckw4dsw2n+KzBZzIZg0jANH6wN5pw?=
 =?us-ascii?Q?Z/qfi8gPhmXPV5jrG+yxjoFGMCnkNigT0r6fTXtaq506BdxBzgjP1t96maXd?=
 =?us-ascii?Q?Zrpb4WyEFfUPKUOolMvTs667re9QgVHs3dg2rACq8TtFYWWIp/tC7G6/fOJR?=
 =?us-ascii?Q?/0R9xgTDIFoCV/hs7z/nFMF1mi6NXRzoqfrHR4U0bSPt1in3oMvyG0TgAQZt?=
 =?us-ascii?Q?Wq2YLCY/cotI68WBTedrqE8DO537KLZo/lCxEav8C32lzxMqpXLXRhd94daA?=
 =?us-ascii?Q?bIHNJ6EeGuEcg4bu6uSPmO33q9DMNMePuLZPttVusdLJtwsgmmARAsTH/F3x?=
 =?us-ascii?Q?1OKQoPvlteQ1SROmzNYZIJlPYhJZiEbUSwdSZquzPV8bFod+J0GJH5/yOd51?=
 =?us-ascii?Q?NQ21jNc3LGwRjpEp5GuHaaMWHDW8I7OL6qZnBaBlXtaFBi3CV06JadtAClCh?=
 =?us-ascii?Q?wDSRF79ebkkwdD3RaiZ8d6iFsV419cIW/zbIY8CVbHbJIltJVIPfFour1YFw?=
 =?us-ascii?Q?f0debVWh9hfHqjlNW43Aq1g9boNRaw0T1UoOK2bamPrIWubS8eIARL3cdcKa?=
 =?us-ascii?Q?17mhYBOMKklQ888iKWgySfoA8Y/4FDbAy8WNc5kX+Vzs1ffMmKTb5DvT/pqg?=
 =?us-ascii?Q?wWp0wDO6UMluL92rLpc9+/sRHTfmTqDfdngmKeRGnCNBROVSFJfakc+ScvI7?=
 =?us-ascii?Q?m3kN1Rwtsoa0tsi0uzIG8K7lc9vuqOAEd+91ROWdQ8klVDDdNxosCGVeE2Ge?=
 =?us-ascii?Q?Ia/H8hHuRONcy2kYsxNM1FtBXgigZkfaEuti7O1JUjcqYUxps+TTCM6zPiA/?=
 =?us-ascii?Q?L/EHsPn4rUxTSd3WpQ9mKXZTCBRjo0LK+b/ukH86duLnm106quahDBwuuqWi?=
 =?us-ascii?Q?+nHMeubtyk5WdXUMHUn3AhMnkQPPohThQ4DcGTOXxCthBSFBok/3De81paJu?=
 =?us-ascii?Q?dbYcwL1aM94HGSIPOAxLgkcnzHqFH0f7mPubAJAkYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9QFnwzwyi3QrFKZ2d+X6JeVWfVy+yOfYdSEQEfqQhNbtus7CWLrW7YNpDwXT?=
 =?us-ascii?Q?Ft1yKIeJ7qJBqx8ZZENSHz0cnC+fMJp95R+J6akqrE8ghEEKrqot82TUTLGg?=
 =?us-ascii?Q?rzIL/1Hx+EhHs10I7ThPQrexSeW5QnCDxoTv4gKaXtvNuP5PWTtOfHXhvO84?=
 =?us-ascii?Q?lOmibarD5CCPnJbxzUdDDOSJ2/GwqeWVH2wUMKtuA0imJzhdX1lCR2Zmv21X?=
 =?us-ascii?Q?gOutrBHjti3LE61fUGUknTC1PXwoHBYO/WsCHEjIEZv6HIZ2LrmOcyOCJKSB?=
 =?us-ascii?Q?uQgmXhOTzUHvdYuHq9SHJNtWr1igpe/wFDr6WsSnDsXdHrZcns230FWLyh9I?=
 =?us-ascii?Q?CFwmgux9AvUgHxkgR7xAJr1P1kSWqonK6sbQMva3LAgFnVtsrrQe+qtFi7OM?=
 =?us-ascii?Q?uS6GzrPbVZT/EWS6FsakE2mKDxEpMdQcNGhNWTIBZ/OXhwqJIzRPf6HiQmGR?=
 =?us-ascii?Q?x2PCBc1ynClkDvZSTVsDn1GG8BUhRzxoVqktVCNnet7FdLYyCl4DC4mhhH0C?=
 =?us-ascii?Q?rv2u9s/MJ7sIKL79XjGRnGqpZh8mVJi/jrAcPXFCojN/UgUw1YCc8eRUTlpT?=
 =?us-ascii?Q?BmVCF0CL0ziUseMYJ6MpRo3TLN6UrN/NUsJkSQJtH/KsjouEL12RvDCdVa7n?=
 =?us-ascii?Q?YXfppJU1Y2sApWispWL4tC6jsBs9LN/Hj5O1ijqIGHRlMlt3qh/UWlYaed68?=
 =?us-ascii?Q?g3mMlELGM2VLC8XIMMqeJ8jAcyHbfJnSPbl2m4msQ7JtR5/d/mLN6QiPdEgV?=
 =?us-ascii?Q?3xwg3Btq3IZPvLzlhCmAZUfJallzeoaYxTdAjvtes/JTW/oML/CozKB3f51J?=
 =?us-ascii?Q?+CKqzPiCSk0FY4NOOjmnp4gv6Y3VDOrCQebskOYR8KLW3FjD594tuMs+fVH8?=
 =?us-ascii?Q?D0rz8Ld6UdH35EmcWd/t9XY+tok7+NEXKXO/U60s3VYURmPEMnHqr7HNZogQ?=
 =?us-ascii?Q?3KWBcFulNe/6n+2VMOY6MkrMsDZTdwFHzsNdHE4yUO4ucdfx/rzuNMTZBntg?=
 =?us-ascii?Q?lO7UgCZjFZEKBGNwPa+zda0/9MTUUo4hG24LJraX+SVJr3umKuo5cf5CBdj4?=
 =?us-ascii?Q?ayg3Z+2bItzITm44712S5bC0J76QWmbFgmWLXiV3VMihCaOZa7zGacCbfytc?=
 =?us-ascii?Q?AdNcjGryblVPDT67DREQBFFz99hUmo43Gdr7mG0ETVPpad8tFRme1zVEb+YN?=
 =?us-ascii?Q?bqm5Y4w2cU84P5m0ruEue01vH8wh5eSq/4JjxHrrX+wl3zXLTUa4DrRczLK/?=
 =?us-ascii?Q?W9FFd417i9rUmLVvPu3T0vv/hRaS82bsplkuv6yLY7psNl5RcalYO9p/Ws+A?=
 =?us-ascii?Q?DYi+0O76Q6oo+Y7OJtGVdbfgCq15/NWrjmkpLn+Q74fzG6+CR+jE+UG3VgL6?=
 =?us-ascii?Q?vDoyS1+WA8cKschGAXVuhLcZb1PcGRrk0deNXz6TcrZ5mb2SV+yXpevaNQzn?=
 =?us-ascii?Q?fMfX8MeWt+RkOE4y0AnDcDKXhH7joKqpDrxo81qzTP0y5U2Z0+aoBb43jJcW?=
 =?us-ascii?Q?aXejoDeLe8HfXSM8g3VGEeV7tPbItimgt0mhjgbI81nr53jNQ9ysSlkiAj4C?=
 =?us-ascii?Q?/PXQjDLG6xFcn5YzKwTc3NgvHtsdlKzgbbuLTabg89UpPqcjLFeM6wvw8qDd?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7fa411-3e91-4f08-bd7a-08dc7e90201c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:01:05.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOGDj7E80quMekFM1echALrtZxbDfzx4DJGFux3mypnOgQKxP5UGbJhg/75RTiuYb/0LAkjv2sIK5AoADpoXwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the build fails because clang inline asm requires size suffixes for
instructions, including the fisttp instruction. In this case, the 16-bit
suffix 's' is missing.

Fix by adding an 's' (short) suffix in each place that it is missing.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/test_FISTTP.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/test_FISTTP.c b/tools/testing/selftests/x86/test_FISTTP.c
index 09789c0ce3e9..b9ae9d8cebcb 100644
--- a/tools/testing/selftests/x86/test_FISTTP.c
+++ b/tools/testing/selftests/x86/test_FISTTP.c
@@ -25,7 +25,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fld1""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fld1""\n"
 	"	fisttpl	res32""\n"
 	"	fld1""\n"
@@ -45,7 +45,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldpi""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fisttpl	res32""\n"
 	"	fldpi""\n"
@@ -66,7 +66,7 @@ int test(void)
 	asm volatile ("\n"
 	"	fldpi""\n"
 	"	fchs""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fchs""\n"
 	"	fisttpl	res32""\n"
@@ -88,7 +88,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldln2""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldln2""\n"
 	"	fisttpl	res32""\n"
 	"	fldln2""\n"
-- 
2.45.1


