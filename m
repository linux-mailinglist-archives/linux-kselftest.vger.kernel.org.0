Return-Path: <linux-kselftest+bounces-43886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6CAC01E75
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 16:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9BB84E1B2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6A4330B27;
	Thu, 23 Oct 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gu+JSEWG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7BF30F80E;
	Thu, 23 Oct 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231098; cv=fail; b=M0dvJaLgA1bLmWLR4SDxWa3kiz/AibU8eiIKqZHE6pX7qMQL0MSIkVKparFhCYRMIMf5CaiuUMXhsqm5Vp/ETjAGbGdl6P6y/G3TqBcZMHFtw2lKT9DT96NK0LUIgnmCH6xFGEN7eYaY2raWCEU3ZmMxFkvKrJWux0lyl75Z3wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231098; c=relaxed/simple;
	bh=ZLtJfLBHoeaFiPXOKMv6zuKp4UqdH1fI3pWBq9lk6dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SC8po1wc+f+0k5kd8XZKPrH0/Dvntl4gtGJa1LqdiNjIFBMY7ZQklzpHqTDKBg05jm6SJqlEuYXW4S8p+3kJAKvin+eYm9wSiulau0gAXo98+bErA92VLQu4tfzQ9A4FAft5ZNT7XdFiRilOZs0Sd44hCbALgDPRxzJpKp5hLlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gu+JSEWG; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STMFV0ekc+B/eOIpTt66lMPOpb1lLfyOd4JxHOfcMfGN/Lf0oHyTZEMnEr/Xw31VRWTiwIlBX8NhXqbdKciLUhGnR8ThSMstrtpBvu+vwv5T7fTS0Azs1fbKF/52aLTfETCruzj173DV/Fj4RrBBOl/sTM7MMI4ifbBqKPkm77DUofFjVXFWcVR0GvV3qTbvxwtXEIfYDlFWm+pKqamR/bWiWoZPRQbIjIXIt1ax0DDE+Ub2Jb7PmPqalK9q4Q56Ovl9NESsHAnDEVfj9BfVadPpY/pSIv+oSxbF4Qn0B8j8Khje/zi8PIsLf5ou10Xbj162jX2IBg7CQVto/9WfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KgrjOoKIearsih8MQgSnLAWqdJEgovwKSzcHhpS5QU=;
 b=hcJTYAVH/HacoA7MYbgBZqiGIGixPJ2BXAZJFOiOuedk06r4MhotbU9oYaCW+5u5dzv5ZdaxiCDXQTXdT1ya/HePO2mreKIZEyLTPY9h2HrbZN+R/qAXHsItNdxztt2ue74KYRAXNdG7vUXXKBPr8AoDVaz8dUla+wZWKggJNj3o5CPyTHIk/h0VmMl8vlsX8DBoiq7WQij2SMmoaR5d5NBCIY5QyPes5ttrK20Kxi23yt/cOkHuPElsrrl41OCh9ponRm7I9/BFcjbTfuZffZwnf3mJyUJDrO+IVZWoEwqu76UCi5kdHstB8d1kCbjHBUfzuwBUbyfgA0+bkJAong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KgrjOoKIearsih8MQgSnLAWqdJEgovwKSzcHhpS5QU=;
 b=gu+JSEWGkeFlvd8K5fZHYGfVaaOd09jTXD4tPMF/ZpXVumtJfcGEb7EqWYahyXR/XsYEHikiGO0B78pC6h4q9qOy/mG/38JTgTfFeciKEpMnObkaYUajC/5V/By7HJFTg6/PdmwH46gAjERPCtm0KiGvxuw2tJY1K5NXQn7CwsLvcXEiu8rpq6l1kPq8CjoRu/ebok/HwB4lXCkq2RNq9KgF9pdI+1zrioMyS30eItHdo07ZfK1NlO5IjcueFF29Q4qJ6e9n7+2aJG3WHz9BheNaoPoI4FT/2ufFE4bxmN2rmxTcos18wkCCE+mjLujkHyhq5UHPrXaalHqG9UEDkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 14:51:34 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 14:51:33 +0000
Date: Thu, 23 Oct 2025 11:51:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251023145131.GI262900@nvidia.com>
References: <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPo6CZyT_IGWmu-O@tzungbi-laptop>
X-ClientProxiedBy: BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::29) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: abcc7e6d-cd10-4336-764f-08de1243a8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s4MmL0IXeoyLFloIn1YfzAm1A+cwBDGLjUS8KFlNe20LCoQ4byZ7aIagJHvh?=
 =?us-ascii?Q?g/iPilUmoQftVdSVwniJ2o6wu92NqUkxUQd7vkyVrReTnyHvdw5TduG1jWnd?=
 =?us-ascii?Q?SOPfoFlksMSJvGItyKEe6Y84N/qirQzLUIK8xB4BM0GNyG5GkSiAwgkcH2Qh?=
 =?us-ascii?Q?Kc95XU3jCuUX9gGdljQhcdf+CL8Tn41DRdxMctrwef+nPwyWaD8jbhbHbb9o?=
 =?us-ascii?Q?Djee4fnDfdS7rm3FZExKc+Y+jbrdHPLazOt6pDipVuzy4c+rOjiqw6shWB/s?=
 =?us-ascii?Q?3izOfVysPHkSMO1S/bO5dQjN4NCU6N0H613opN/DM4hM0eTV+6LXJap2/QD8?=
 =?us-ascii?Q?yJqxQCT7Fto5c1gtfiqsyoISaqDK/uK/C//I0vYk64H08Snph1aiL1ycNUCq?=
 =?us-ascii?Q?pWqIIQ0DdIWbf40hE3c9UHtxZI/4dEg1IomMDLhtu8du5lmS/ujyMtYjXpOt?=
 =?us-ascii?Q?qNo2acSYDoJg+r/SN5y6/LnNOIfaZ8Aq8HdqPPJhGY/Sa/pg9Xs7efl1xPIG?=
 =?us-ascii?Q?8EYVsQOBxcGXjNlRD7aGkc7q8smlga6aVbk6phbcL9F0xwlTeThtMJiinMac?=
 =?us-ascii?Q?9OVG2CulVbcKxKU52GHi0sfhNLzbsjWilUmDSzjUqsT71SV4Kk6Z63Zl/WSz?=
 =?us-ascii?Q?RSK8Pg07iDKdfxfY7Q8YwNayu9LX2W3dgPksURmASNLxrTcLU5CN4zRX8HTe?=
 =?us-ascii?Q?dHk435E2T+PbWSOzMpsjHkTYfE/MRkDSHNw7FYXZz9lDbDTiK03esDUnrAPV?=
 =?us-ascii?Q?T6hKhGoPBfl7Okak43Kqru8DOCNKHUPHEGTxzSATfRtXqhabgkF+5Uvh7Wwt?=
 =?us-ascii?Q?k42jsZO7rr3KBotF7hmNwNMg/Tqp2wgpguuSbOAWNp/Tuj2T0MqVK4q0oJrd?=
 =?us-ascii?Q?b5x3yszZwfGUAWh4br87GlEe1NXTd3WR8/hF7Pa4+UcqAfTg69wapeli+2id?=
 =?us-ascii?Q?q9DqWKwtZnN9TFgzY4d33UpElssk/bnLsbSNG37Du30vrrrkWbVWIYNNWebD?=
 =?us-ascii?Q?L/+K1HivY49zVk+9ijGxJLLDIUCZ5gK3XURsvMilAuuz14MRdy7CwLWBiBqk?=
 =?us-ascii?Q?GLHReZ7BZhVwPbdLu84aai6SFEmCsosYxhydYdycTdzxO4L+KVcJF4Us39Kz?=
 =?us-ascii?Q?U44MYfKTIoztGVfPKDqMHt0tcsaXOxOYv6OC/6ZzTmr/Q+ZJ5lcbUms583jm?=
 =?us-ascii?Q?nSScIc9x0RrKHy9ihgEIEvU+jDawM+K2r+dI8PU8abH2BoAlMn+RkyU8kfiY?=
 =?us-ascii?Q?xQpNpqTPzDvqnb4FCTlFxaau7TmMKjgIadpWSGwtX9pRgMaxjrfeHEO/3Wdv?=
 =?us-ascii?Q?AkPF4Daw9WM/cqpE/lDtDCSyC4uISk6FFMy2BcCY84SI90wZyAHHbEhA5OWR?=
 =?us-ascii?Q?Fv1ittgb/I2/LmFmdKHmrtZFNjk327YVdXrlEtVPSNyb8n6PDhYAYisvPWUO?=
 =?us-ascii?Q?jKH48WEVvX8D3slSqhZNxVkt3Vy7kQ7G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pR/mfpklVDsxkh0Ygpy01yyWEvzLGmdYG4GMMhFzywu/itzZoVqqYaxJrxik?=
 =?us-ascii?Q?UdtFCK4NgscRWx0iwWJT2SQhbsmqNlS0pIVIcZITJ/qDJdl7I5LN5Tl86QV5?=
 =?us-ascii?Q?0vi2xvF6bAadZJ9I78ftUJPHBCmemIOSg+QURR9Aim+VdL1uDbWQZk4M+izk?=
 =?us-ascii?Q?LgCQP5ZrcOa//L/xsNhdLF/EH/uJZw4856LkxRZbRL5JgXf0dFh5pJ5bQYLH?=
 =?us-ascii?Q?+2/Pl+shylO93Ya9u0qeh8K2nrE5AY6uhxhCIZU3Q4i2npqMIZzv8ntBRfbl?=
 =?us-ascii?Q?BMKgvdC9a6BBvGl9ynmSg7f04JFFtmccBUIwVpsraEzrdNHZQor3+B76gSh2?=
 =?us-ascii?Q?ffILhcbQInXNW7kBbjIz8leFRZJeVkz7DC45KMEGIFu1s6FlWcR2HAQWt8TC?=
 =?us-ascii?Q?bH5h5FY9JXsaUIHYXOpJreW+XbhH+aIgxD3wCFGxlKJjbiu9D176KL81AHPM?=
 =?us-ascii?Q?SKDdZSsFAgh6toQSEUu8mTgvpQtA0oGlyGdnB7/8Pogc/yasxRZ2QaonyTLL?=
 =?us-ascii?Q?MG3g/Pae3ZDUVF+i/kbs7kIRTh8FApcRFtQGeFBPmqeBGKsPtlZR7LjV7PEU?=
 =?us-ascii?Q?DRAptiVjXPYY/HXKmU/I6L3DPM24o8TPSuYsuXe7FNeY1oBOElH59xu0bFAc?=
 =?us-ascii?Q?Vz/aH9vQobNs2QMCzyAyXmS+oALUOqnbktGMmKmZDwue+XWGwmkCTPtlv1Px?=
 =?us-ascii?Q?2ooivyy9tx6e+FnNhwQ+oIGbgxpmom6P0tfPh7K01TzYiRp7TSLdeyZqnUZW?=
 =?us-ascii?Q?lKkL0k/slVruptDp0irOg5Yj4h0++Vee6P3CUgZWroQqZf4Yr7sP/OxoR1Af?=
 =?us-ascii?Q?W8qk5xrDJuxXRhpFWCYBvP5PZu/MqQ5AxTifj9EYcov7BdIFqcF4tFth93Dh?=
 =?us-ascii?Q?hwYUjoSSAk4dfmKbHKyg9wWbLpy8hK4jY3kogpKO5wqkGQJ15awKulowZcKD?=
 =?us-ascii?Q?jxsLFXFkpLGM/mr+x1Qyiss+aikGzZt+wkZPrcorlJ+V9p6fT+FbbjsNIwxU?=
 =?us-ascii?Q?h6H1YMfw57UnDqmVp73UbC4dqm6arC3sidZ1h0iGJqgIWOk/BeP0Vf0Kwg2j?=
 =?us-ascii?Q?eVR75kngErZRFVAwh9kmuXO4K1F59sp7JnKs8+C6qxf9bR4lLe37MuGHgV0J?=
 =?us-ascii?Q?/RILNhmkciK6j1LHoPW62Hik9VFUmZssEmjUGyZ1NDpAFEdlg5lLoqDCDPA0?=
 =?us-ascii?Q?JDrioOVBsROkKn+w0stzSJv5fhfjY7Zc9q6ZpEfFtzwyKxlV5fi2HmwMUFH2?=
 =?us-ascii?Q?cdNryIjFlZK3IN5ITuy5PrdxKrA+HW+m2bkcp16OCsSITUa+dTvbRmYn+PDd?=
 =?us-ascii?Q?m20io23AQZ1S+vYOddiB7pzSQELHdzXcvPW1ch1Q+gdD8bK8wmIRS5yexsfh?=
 =?us-ascii?Q?3jghg6j368sonx1yzOxAdOJMAfYCP8We0AWJSbZHrj8IIXnzisNHdZsPEwed?=
 =?us-ascii?Q?z1JrJlx+/HFhBmZ+NOfL6nR9ttm9QRQGJ4TFiDLcTVN5bIqTYGyBYYtrGVD+?=
 =?us-ascii?Q?dqeDnUc0+MwE8dT6Wem4EM9OIVNDcxjhoYtu1lpURXzf5WFkn/4wCD7+UTuY?=
 =?us-ascii?Q?ZhtW86tSFa6rNgjGpR/4dHgZ8qYLSsydNgVTtbMB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcc7e6d-cd10-4336-764f-08de1243a8b3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:51:33.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUWhkZ6HmW2ititOheqCE4hiRgAzXSixNldOY2FkToEgAgK5wqsw6ti5gWoYKTGE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266

On Thu, Oct 23, 2025 at 10:22:01PM +0800, Tzung-Bi Shih wrote:

> I was misunderstanding about the "sync" we were discussing for
> misc_deregister_sync().  The "sync", is analogous to synchronize_srcu()
> of revocable_provider_revoke() in the revocable version [1], doesn't wait
> for closing all opened files.

Yes, and my remark is we don't need to obfuscate simple locks in core
kernel code.

Jason

