Return-Path: <linux-kselftest+bounces-18482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA1988694
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 15:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA391C22689
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9500F1BFDE3;
	Fri, 27 Sep 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JM3O0eo1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD7185B72;
	Fri, 27 Sep 2024 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445207; cv=fail; b=Zl6FT4J7hCSvtIsc0wm/DtX3Xif5Yp8qWZdtCaUaOqm/ZPZX3YCaoMilR3I9G3QE40WJxcXS5hNe6ffbPDKh+toUqDw9JD7HHM9djcIw/uIDXt68dE+CM/TQof3oukj6DUEBTYE0C6MB7+mHAZiNwvTfz9wBkUXIdLjQn9M1Q6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445207; c=relaxed/simple;
	bh=LAZShFjERUi91W3yO0MOTNQA+PVbifd3CK251rojC3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mFuBE4NHOyIg6a97qAtOxD43g54FZvjk5NvRtRlq8VBCUVTz2FSgMId6iZpKJ5XEmdjuTWUaq8tqems7QxGjEFMmS2QbCkai4NXkLTneUj+Mr23x4Pj//4nFEMKAX4PuOC5icXL5d1jN1/2bsQCQ5cTT05tKU//uiy+vy6EKI3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JM3O0eo1; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTEmdaP25TP7zZeVtNGCHaHBzmGHM6an1K2eIHyJo56RN/G/SHoA+2iLfqzV00Z0PAbKbq9sKcxqZ9WPFSNibVR8I9Az5gz6U6Ppq6bcBCyQLsflFjz40s6+AbnWXdTl4DJCuoOmSjXVCBDkqCiKF6SgXt+4F6KwonjFEDW9j3K9fjE2uAWmm3LAUsjg3cs93sY5/Upi/V98AtRUwRYjCsWy02JkHicQS8nuMvri3AoQ2VOMtAs2sBkB13VszzPbIo+p0JT3AxuKEcQAAPj81TMrSuQflSSV+VxWPK124VGT2DakCSXNcAF3NM2I8EwCdj0DIlkgLENIAecQA1HIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnSo+Wbj5UhVfRRXzRS+5un0tXomPVidpNLYXOZklJY=;
 b=WW+x/bRSYNHEpFUsFFB54CsYLJLCHh/i40ptBgAqlJwufEoiGVaaLH33dBUDxZE7jPWDia9WLsrseSl4LLO5OUQhtdraXo51z9twoRMsfY1me5xHwE0StgdN63TftMNiJGYSoQKm8xE9HcRqrUT1lyStRkjBzNX2WQS+LA8IAq4h1U7qz+GR1MLxQelWVMceOnPoQGSfugz9K9oK6jB2blrcDtB/LkMODQIclehKNfgvHyTyAi5SWDggOymnbbwnNQxhFtB3fAOK3YFTI2eyUXOXcMf6fVFu2CQKF2+avOVqzAK24DiVTtCxIao09IRhxeTpLhfX/SgMZeXRmiWalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnSo+Wbj5UhVfRRXzRS+5un0tXomPVidpNLYXOZklJY=;
 b=JM3O0eo194CHCx/9TrRVIx2y/ZneZMTkmzWbjMoq2lT71Ju0lawNMz/JS6sCKxZPy6wlJp+srB9+wsDxwN2cQLkcgygTRvN//vI4kidYhcjH/0+JUvTvl7hisC3olrUHStEIFVRTZyLyRBC/qWuQId1TOG0lyUGw2E2nCBX1XDoByhenMbWLs4ioAJYm3TW821DcTT6kY/3oYk8iRjgS3wgih2+E85nY7JCXlzpuixJhnhl1uDzrB2sw+JP66j6hRhs5YCCbA4nzbdKIFoTcz1+/z+PxgTa5Ln1Ww2NNGRA6DX8O+XTc2ofR/ziMW+NXNzA1pnZbmjVS5Lh23Ri3Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 27 Sep
 2024 13:53:22 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 13:53:22 +0000
Date: Fri, 27 Sep 2024 16:53:18 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Kacper Ludwinski <kac.ludwinski@icloud.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, petrm@nvidia.com, horms@kernel.org,
	edumazet@google.com, shuah@kernel.org
Subject: Re: [PATCH net v3] selftests: forwarding: no_forwarding: Fix issue
 related with assigning two different vids to the same interface.
Message-ID: <20240927135318.duezjjl5l7xjfdla@skbuf>
References: <20240927112824.339-1-kac.ludwinski@icloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927112824.339-1-kac.ludwinski@icloud.com>
X-ClientProxiedBy: BE1P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e19a88-6da1-4f26-962e-08dcdefbbffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hkgim7q0gzd1mVJw9gd6chYy57kDNjNz1ERdMkH70X69zcMAeXx1oNCMT1qm?=
 =?us-ascii?Q?NeomHwMGPo/tb8Hbdt0JLuukB60RFZrZA0cyCd3WCuJPxPZkKBJx6yhIcHam?=
 =?us-ascii?Q?EZG3rRXtMIxytUVy3hZI6rCBTf3DuP5/aTaxUwlRviUBMjSNKEmSHKBMvTl2?=
 =?us-ascii?Q?aAyBc/v2VZ1P4TTmDsnwigFNufTq9nzsvmJb+VD2xtmhUv+I8w8bGCHuLDNw?=
 =?us-ascii?Q?8JNGVu7IDbo4SnDSemEzPoWLm8ZfrYCU2ACFaJ5zjZ68+9+LIdvG6t3TMpwk?=
 =?us-ascii?Q?2SXo/8b6JzTUfgsCUZ35IlGyGZM/971dAoAZxCiofESHkZ5BXhxIBS/wGoof?=
 =?us-ascii?Q?UXHYSAZBCECllavyK4dzHxzyJ0BfPQUyvtPBJnaMgrva3Gty4G7Mx1ZdH13f?=
 =?us-ascii?Q?PaEjULlhqW2Lzz27HWVytHljJutBhGPzYc3jr/PafRuh+x7V14lTNCKWLpqB?=
 =?us-ascii?Q?C+N8lm8ZFD7BD9d+TpS4YsNJgBqMxeNFNhTe7UzzofRdnaWKoH/Uylh7HLBL?=
 =?us-ascii?Q?SF2jA20m418RJInnFVxTmpVDJx9TLO5xeNgd+sM0is4G1y8rsYgZaaeGm3kX?=
 =?us-ascii?Q?O7Y4NzIzXTtqTD/u2BkFIZOsLHeY90FIAv2XBIeg5y6TSLzIFW5pqyBqceEk?=
 =?us-ascii?Q?NkLBUxHJNeX0ryZ5WbNEBezLGSvOpISnnSX8FnE5Odlxq5uHbKWIVAjnbq7h?=
 =?us-ascii?Q?FEyRm3djdP52fvlCc706NfEv1IwTYBqLsGOdYDRED+AiElMwigTQxIyoE3cc?=
 =?us-ascii?Q?deammuIq+pRvHaUxitMWi9UWWoZJrXMJkkF1hqwiAXBFJbmLy8Hzbeg6y3EF?=
 =?us-ascii?Q?MTLIhLZJ2nIyQ/GUkHevaitr5j56+V74KGsOBWeMcGF+gsQkCXIXb21wR5oR?=
 =?us-ascii?Q?GWpy70fBuWJd4+u4HYcoyu+QnrIE4cf2NFKbo3nZw8QQG2lwLLp8DJd+lrr0?=
 =?us-ascii?Q?nSxTYvgdm7ZV/oPg7ndvtxgPO+4axlPpkIQOSf69HuCM4ABww89lbeVtgyDx?=
 =?us-ascii?Q?/5PXKOmIg1NUDEbvOeF7JzoLBxQcCPlJAiGlRdQDCCgVvQCPty011AJUX2zB?=
 =?us-ascii?Q?EbOD/LfxG8W0AH5y/ekKcNGzq+dHFUOBSG7/6cpaWE7EoedBXp06yNyut9Td?=
 =?us-ascii?Q?40/nPbE2+6gUSMp1wrmnHzgy1OMIK0YhdBDdMogNrM8VoRBb6FyF1oBQvttW?=
 =?us-ascii?Q?iXG5fI1cnnd8SC9iLSGVlgXc58JU7rwckzVmb7IruyiSok9SKKz/YTse24Kl?=
 =?us-ascii?Q?al38N35kwjzSaSt70JkqtxSB6sZXJi825Odbq1U5pfdoF+bzlrjZ5E8pDk/m?=
 =?us-ascii?Q?h8I6A7M8hkvR0ZnEy8jadoGvj/Ue8Y6wGKpgx6hYjYNVWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMjTY/A9aOxbT6IDh/yy06Xc94zInKXyRXTXMfx24AHprkyY+E+Yq1T2UvZK?=
 =?us-ascii?Q?4xbUCsHPB0JZx4k0uNTA7kaD4wR0t13BXLbMjA+8GysZGp9mpGibdkGNpfhv?=
 =?us-ascii?Q?SbYA5RGdQmIUlil/MnBdIsdXPhsgnXNE8CV1PwvznrsO8JhbP1ZQiPAoU9SX?=
 =?us-ascii?Q?cWMn2KvJ7w9rUqZSVeThvlrs/31Cd+sYkmXZcZy8GdwaVPW/62KGwgTzTAxs?=
 =?us-ascii?Q?CQaP8aaG8ijsb2Vg3CUhjeI4OLvQHqndliVNbTiS+WsBTtPxLzPJnfZmhRZF?=
 =?us-ascii?Q?UUjwltu8QhxeTnsLao34D/YmhOgQx1OnkoNE2Ab1lrWh8ejmC1bZcuhc27Dv?=
 =?us-ascii?Q?PdDd+zBoyKMmrtPVMemAL/j6AoZrWlUJ2TAyNCDQwWRg2R135glifxMp3I7A?=
 =?us-ascii?Q?XVqtEEVh/6TNCm5eNDuhdN2KSNilcK+7ETAZ1e+e65cbJBriAcjCIAwxt7QI?=
 =?us-ascii?Q?7bI/9MROqQRUFnI/FhWgUP68SqGpuKlvDIkqhVhKLlFRAhBu0Fy/ByBXQLD6?=
 =?us-ascii?Q?Ymif/4Z2p7zGyYgw2yqDkt3kIX4PWZjRNz8I86lcTXdmlI6L+ZQHrrUrBtPp?=
 =?us-ascii?Q?oxXk12vvn9NweBdMXmx+dv8HyNsa9+cKDrRhMF2rYn1NjDnc1iNqXYhuzusf?=
 =?us-ascii?Q?2s0EOkts4w2xgYZiWwzSXwN218oanCZhDJLQW89hUWFpcn+gmAoB1HCxJwU1?=
 =?us-ascii?Q?RmSWcgRGH610lAvC1uJtNammpxl8w3CHm1hXWlYkFJWofRN9QfBzR+4t0WY0?=
 =?us-ascii?Q?kxmmAdhuSsgmjHBWKKfLbTzpk9nlPh5lW9xqL0yss0wt4DT53MPtW9lBQdFh?=
 =?us-ascii?Q?9ITF3HN+98nchFh8pMw/7TMXuQajD0e8+/WST248pfpabaiMR/6LZatjnBJc?=
 =?us-ascii?Q?Y5Afk6gppabIFOA618epio8K938FAYW89WpdmjvFqX+9TUGuuTZo3cGaK3yd?=
 =?us-ascii?Q?xlU7QwbyzrQAP1TT5KME8SHQcrrP4//NS6ALOHIF0So2JmOWJnQz/nzp4BqW?=
 =?us-ascii?Q?nxx15xtUfOMPeOyNnXmUzXbNXN/xyGoECiw1ogmwVyaJeHRn/Gw8m2WhnY61?=
 =?us-ascii?Q?cSQs92xv2ee9zRd/ZQds9K4PpyiRFUJH0Sb2OnEgCSop4u0jugoOzSyC3Tj/?=
 =?us-ascii?Q?ucOVR0HroAsJg671z3R7Qch0f2XwLwwxF3lS3wClv1liTWYQIMd3nNjCg3qu?=
 =?us-ascii?Q?AlARmbkOxLp6q0fYvHjgwnfRdnufxGIdBltW5bl8pwlgj2vTohqy45FDV9JY?=
 =?us-ascii?Q?eQ4jKolXqPPqGIpJ5yosdxmQWhqxhPFxTcbrmg4LFGNBZwpNs2WlT5TQnHd4?=
 =?us-ascii?Q?5Qs2ilCbdXqyRQz8F/7ep/E2nE4ykV2/Qrysdmp/NwYRB2ta1MA4/iWKZyOd?=
 =?us-ascii?Q?s2XPOpAq1Nw7gTCeDzaDPcymvx0v4OS7o5JoQl9QmEXDqr5a+QKU05okWjI3?=
 =?us-ascii?Q?My2C888UZvvzeSQRCyVK6EMRf+OBnmKzKrqf+kelHliSOTQ81YQEWgoNJTjA?=
 =?us-ascii?Q?YN7W2lZhQQGN4KqJQfedtlpw6IWShepqRMWGOuUg0X9U1EBkfW5KNWT0L/Iq?=
 =?us-ascii?Q?7MXlQohO6iyUtzcfRMbQpKTEYBuup0pyHcO/0yrndIoG6RUazwiSCNHYfLrh?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e19a88-6da1-4f26-962e-08dcdefbbffd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:53:22.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fR2XSDqw+eoPM4vjSKDAbMnvxCoVsQy7e9WXthEKWtANplfAmkjzgmD6os6QqiMWwEUevhvyyCFxjwZLTZSBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8822

Hi Kacper,

On Fri, Sep 27, 2024 at 08:28:24PM +0900, Kacper Ludwinski wrote:
> Fix typo.
> Currently, the second bridge command overwrites the first one.
> Fix this by adding this VID to the interface behind $swp2.
> 
> Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
> Signed-off-by: Kacper Ludwinski <kac.ludwinski@icloud.com>
> ---
>  tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> index 9e677aa64a06..694ece9ba3a7 100755
> --- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
> +++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> @@ -202,7 +202,7 @@ one_bridge_two_pvids()
>  	ip link set $swp2 master br0
>  
>  	bridge vlan add dev $swp1 vid 1 pvid untagged
> -	bridge vlan add dev $swp1 vid 2 pvid untagged
> +	bridge vlan add dev $swp2 vid 2 pvid untagged
>  
>  	run_test "Switch ports in VLAN-aware bridge with different PVIDs"
>  
> -- 
> 2.43.0
>

Thank you for the patch. More process problems though.

Please use the space under "---" to write a revision history for the
patches. I had to download your v2 and v3 to figure out that you changed
the Signed-off-by email address and fixed some whitespaces. Generally it
is the task of the patch submitter, not the reviewers, to record the
differences.

Annotating the revision history to links on lore.kernel.org of previous
patch submissions is also a sign of a well cared-for patch.

Secondly, Hangbin Liu left you a Reviewed-by: tag in a previous patch submission.
https://lore.kernel.org/netdev/ZvTDJyKatBVpgqMj@fedora/
When you resubmit, it is your duty to pick up such tags from previous
patch versions and keep them in your commit message. Some say to keep
your Signed-off-by: tag as the final line though. No empty lines between
tags (Fixes:, Reviewed-by:, Signed-off-by: etc).

Thirdly, the commit title is unnecessarily long. Please limit it to
around 80 characters, and only exceed if you cannot abbreviate anymore.
For example:

selftests: net: no_forwarding: fix VID for swp2 in one_bridge_two_pvids() test

Fourth, bug fixes as per the Documentation/process/stable-kernel-rules.rst
process must be real bugs with a visible impact. So your commit message
has to make it clear what that impact is, to pass the 'net' vs 'net-next'
triage. You can't leave that part for the reader to figure it out.

For example, I suggest this for the commit message body:

The one_bridge_two_pvids() test intends to check that there is no
leakage of traffic between bridge ports which have a single VLAN - the
PVID VLAN.

Because of a typo, port $swp1 is configured with a PVID twice (second
command overwrites first), and $swp2 isn't configured at all (and since
the bridge vlan_default_pvid property is set to 0, this port will not
have a PVID at all, so it will drop all untagged and priority-tagged
traffic).

So, instead of testing the configuration that was intended, we are
testing a different one, where one port has PVID 2 and the other has
no PVID. This incorrect version of the test should also pass, but is
ineffective for its purpose, so fix the typo.

This test was run on $<insert platform here> and this is the result:
<insert kselftest output here>.

Please resubmit with these changes.

Thanks.

pw-bot: changes-requested

