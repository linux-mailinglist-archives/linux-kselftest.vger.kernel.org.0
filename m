Return-Path: <linux-kselftest+bounces-15391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B53952BFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 12:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59043B2323C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87901BE858;
	Thu, 15 Aug 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hHTUAgd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC971B5828;
	Thu, 15 Aug 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713083; cv=fail; b=cBZUwEx5ylgcoi62xEfksD+q7H1UnPnoa3lAONYI3EP+ZMhdBNm6jQ15h2PE//+NKUOoniqMd7gAFLbFxrEYTiRprJDAVdx/4bhXi0XtPZP22HP1GcuSPbGaXYkEOXigH4wiNTwysBWtMu0iCt97/AYC5E7n2E5fHMQlz4ZoPOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713083; c=relaxed/simple;
	bh=l8U10CcJJ02AVpxvYHmaYDN/WmbNP+xbV5sQsLAVeyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dvn9NNrX6Ilag79DobWlIknSzS7z/zoGM0EV/MTexuWOe6WR2htFSSk89GTai3y/INNxHZEBbv/z4xGX2rZKrC91SQi+CJJJnC1eVAtY/RbFSsAGpGYd12+9R08sjXFxKHgJJzpjnNlk4Vg9w4aZ5cSxHD7KpcDrvfsAAI6PQjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hHTUAgd0; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqcXSfzovm0Bc3thqxIHbXNNsV5UCO99RQo21o1MRhAkgrNqldgaF9SAAFOomNij7kn92iDCVXoH1+komUpqxS8sTJ73F8/yfykMVLapasiy5xd7j2YbXOmkm9V+aZycHDA0qIUUVVZnmcEA6ad/tpjkH/ybdqXnCGf5Yy4B9kwDR9UOHRraMu4BVgUbsa7Ja3TYoGdYK72imRnYyxLLSP8hY1gUxr05BlR0VidhRhfIMxcPrlDdzYHoN2Hjt5/MPftVssnWUcXO2saHUfBkVyesuoV/NhiLGAlmavxDTYk4OtB+pxRKB8ofce6Rq0EH4HSWGj4VZr8agbPWhobO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeVkKYM7st/9hkMrrwNSo5fU1sbQnQmLyvU8eumB7sg=;
 b=Da78GZhASCD6FUBzS/IzN4m64kVvquBEJQB0ZyAKFffzsvqF4y5qaKfyckkbJ73PUvNbSmVvFfLUL0iXqQE3YWZFv8UO0X+Hh6EjbVMuO+cNtYPj4fzUgOGWPhodn1Yd5M3YmueTMOQHRB4/S3x8girlGkW/Lmtg7Gc2cUgHTk7zgsiKfEcqKvBbuF2HhzeKYd4GRlgExEqUX2Zh1mJkY1hF0CSvGFtREB1xza4jBhmk2ZnOX29QkZ3m33kr89CnWPa4xqZqh766IHgWsdGeOWqOU42htrD/xb0gmVYeIAKVCE6kRJa+Ypw2qoAfAy7/mZjJQg15haCMcDOWtoxTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeVkKYM7st/9hkMrrwNSo5fU1sbQnQmLyvU8eumB7sg=;
 b=hHTUAgd0BT6JjaxUeHfQ6x+WU8GorzYqJ82IaL7Kqk006MCT6wFgCOBQys53WEzauzo/FUvo0mSfk/q/CsUVjUOsAx21mYxAQ1mrRoIJXP7YjPds4pTRytZjifMML0qkFqyVVSL0XWeJMc9wKPyhkcRXUy1bmD5SphwMu/2ttF5bile4+ulGkzukDr9HUBEE+aOR+XBXZ4XiyPdbzi+2KQULjKciHM+QEjeblaoTv1fVJO5leyZJfr85yywdiBp0duos6C+6IqyrTOwHWnR0pAQbNvSg3p1AZ1RivR1w3KYZXv8uodpWh2hMpdsXuZFcn5Wr7PL3PNyFONGYRyhwrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 09:11:19 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7849.021; Thu, 15 Aug 2024
 09:11:18 +0000
Date: Thu, 15 Aug 2024 12:11:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>, UNGLinuxDriver@microchip.com,
	Hongbo Wang <hongbo.wang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Hangbin Liu <liuhangbin@gmail.com>, Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 08/14] selftests: net: bridge_vlan_aware: test that
 other TPIDs are seen as untagged
Message-ID: <Zr3GK3NeZGGt2lpx@shredder.mtl.com>
References: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
 <20240815000707.2006121-9-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815000707.2006121-9-vladimir.oltean@nxp.com>
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be87896-2f7c-434e-a503-08dcbd0a393a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sq3nYlqwSzAi+ajHiwL+PO9GkwSHZYHQBIVVi4JlwyXyWh0k1/5crV9RIGQD?=
 =?us-ascii?Q?6SXKhtpFMsGzWvN8ESdp/WuifQxOUKUfWNn2+J/i0R6AKfa04VS6g6/+FdlP?=
 =?us-ascii?Q?UJsmgwBUQPz18wkBYyGabD+1QnGlSStvNNhqjXYD5mCePdXJ3rA+I3L2zuvM?=
 =?us-ascii?Q?lcmq2od39A+ayp6hWguW0jIFtT2FX35hpnhQwsnTnzWbNsDjS6pqDlDJw+o7?=
 =?us-ascii?Q?AyA8k5FMumJ9XtAIrwY64IzZzm+absHU7v3/kLB83YcoxL8hXm+KAR0k76kN?=
 =?us-ascii?Q?G7KCKs4YkCMZMyuUDr2oa43zV8X+ijDDRmgwAZif7Tom2dLb784luGI74kB8?=
 =?us-ascii?Q?LhvPCuJ+07KtwffQeNU9s/I5QOQVIQtlLm7szLtz+VmhRQHqVbm3q2AQagNN?=
 =?us-ascii?Q?/KfRC9sWy6qSznj8KTgU2VrXBhQfl+E+TLMnVgoUbqvoE1G6eXidn4ZdVm1f?=
 =?us-ascii?Q?RPSECcyptvcEGK1EmWlPSHwblN3ExrJJCq7QgAqjS6yJx6pEoZXdhqWdjiZd?=
 =?us-ascii?Q?iiYba0blVHma2QibYiGifaTZziTnGHhNd8emmepoezMBRtTevWRnaaVKeEjU?=
 =?us-ascii?Q?+Hw7n6vINrLNaGxIRi6Lyyu6xBUyS423civ1NZb7aOVNORrJGsES79/A6RpD?=
 =?us-ascii?Q?lQfIZK5D/aW67G6m8uvvUp9+7oq5G5eigHmF69ScWtL1tulmLu9vXvpP/5oD?=
 =?us-ascii?Q?Tqg8sBBKxvTzszLm77lpovyqdve+6wu136u/a0cwkuzD3e4WbEj33gHMkNuP?=
 =?us-ascii?Q?+9+yKxJ3WlzqSdzcca+0V3DbdNmEhf27aJMGC3/Voj4DsIzlx9cBJ0Q9cKC7?=
 =?us-ascii?Q?gz9r+5IdkCm21vLQ/5qhVGMgFQxQxQwnFeYeIgkfE7BDE5WA8GjVaFn7HzL5?=
 =?us-ascii?Q?XjBnGPRN4QlAip3FOOQU51c50IBfZ2rKvQAEJF4eh3EzEN3J2r7bfxU8XgkK?=
 =?us-ascii?Q?VEnPm3AUHU2Rb3U/FzVefEsbX+7oQ6aoYj7JKIG7mOv30WL3Qk5ez1btgd1/?=
 =?us-ascii?Q?+TQtxz5K6xhtso6PDQCeWNGGsoqX5P0kLzCsmXauyiUV5EJTSYGyxTYDudNn?=
 =?us-ascii?Q?zq0WUCdV2HR3fB8tBRBn3lSgKw2KZfpOxDRjb1k0Mfhe61m0yq4PCnYVJgVo?=
 =?us-ascii?Q?9c9Wf14XnREhvSY1W8ZZmerteE0WaJgXTfojUpzLgMjbHHDeXfz9hEh1j+xR?=
 =?us-ascii?Q?DjUj1SKo7Na/VkwHlrkmX7sxtIESSBv5IJfsWfh9R52UZAu0ndQuyIE6OI/w?=
 =?us-ascii?Q?oGkvla7mTpfe1EBMKI6QVzIJJ5ziQ4su2u68NroHd/tfVRDXXshRDq+9ySOa?=
 =?us-ascii?Q?fntfms3Rl3hgTIvYnQxT8cpkykTrhjwzvW+iA6bs7XKMAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LOGJs6ExXTwXL+S6oHU8Ixjufhiz1RI5GUAXF591P4We3juZ8Ro46gHHun4U?=
 =?us-ascii?Q?sIS4R1TEgQsvgMk1G28us3H3HXGHsTJFlfI89kX7pMhyOf7WAYBnGXenzEb0?=
 =?us-ascii?Q?v/Z4hBanYEoemzs+tTieoqxgxunvl1m3pssq0enxjd9kdu0HR8Ogb16aAix3?=
 =?us-ascii?Q?JeJHzVNqp8R1gcSMuEQyj/yQ64EocBHL6umGQhv/BJowKwKLzE8fGab4j4RV?=
 =?us-ascii?Q?R7FrBpFmH1pa7aVP1Nm025K5HeOTqQViue7GgoWMGACZrlPGwHng0TS5gmhV?=
 =?us-ascii?Q?WELdEhKgjM2AFTquIaCf047joVLcZPvuTCMwMpQY4bT5du6V5HBcNJSV/vGM?=
 =?us-ascii?Q?W0t4wqbuGtLk2mQNUVToY2rOM1rp04vnI0DLlRN7gtu6MJbuH/Fi4QdxHTzM?=
 =?us-ascii?Q?945zEhYIFyWFWhZZrAuHjcvCNoCxxMmOT/0+iW/QTlMt9t02bUODjCqft7g3?=
 =?us-ascii?Q?rlETha39XySYVHoLPo2cmlUDi6F3GWNI2jBEl3Vk3SZGkNvF0mswOhw5iSLo?=
 =?us-ascii?Q?Dz7oyTwnEFVgs7PZCb4jKVKbgY/oXK++t1hQxfSBwJEfZ79HRN0BJk0jKIdk?=
 =?us-ascii?Q?0YAnFuUzVyrduh6nf8oPvUzWqKahR0D1fpxBtIoI/qlHKAbW7vV/E8RRo9Re?=
 =?us-ascii?Q?W/haTSJ5j8fGsebUmc9I8cXnFh0k1r54DA0ce06yySg8YjFWeJH7G5cP6j46?=
 =?us-ascii?Q?eEitlF8ktHr8UMIbM5kbGwz+cnVMEatVvGYBaCZMTBDNHP7bugIJ+7aXunLU?=
 =?us-ascii?Q?qju0umDDNyilezeE39v4uzgDM0RZePObtVx0bG9tZZOTe8bQK0aAGMFJYLSZ?=
 =?us-ascii?Q?iJUDxg50MKsmd1kvZA3rwtLbTnlz4SX6WDPxqUqLMmLGSXhjToNUJJb0EzPi?=
 =?us-ascii?Q?4ZAR6Q/Ns/nWoef5FgsL9CThITJQ+cKg67aTL239OPQyYFD+eBjmkGEJk71N?=
 =?us-ascii?Q?Yi6Hr5dVmmnlt0Lk1qtGrnk727AjfJ/0eRa2/Iok/opsEEJ4s+B3EP3BROLn?=
 =?us-ascii?Q?DbGyPOkV8orPiq6EAe4row/Miy0ZEBlbOf9uI3Fj+w6pIiVjF+ZPZ3HEDH/d?=
 =?us-ascii?Q?TDTCBgNGW469lJJGT+VGUqHZjH2pQzsWwBsAHA+J+Cfvq8/7K5RwylnNrzgi?=
 =?us-ascii?Q?mJjlDH2btgGvZwb6rEtC2H6+c5/X0Xm9uR9k/WQR/0Jd+Ba9mRCkjJx8z7Me?=
 =?us-ascii?Q?WzpA6ot+AA0p9TeMNO0Pdn7z8ZdBp13F31rOROaadeBb3OCvC99jKLeRBWfI?=
 =?us-ascii?Q?QmWmqUgl4Hv37nL9f7GpEivD64H2UPXqh7UA8Sopkba4vlmohio34+oSomLI?=
 =?us-ascii?Q?p2YMhk9EAXso1aCcMrfdtDPOxrrlVDtN+ESpR9sNsiJKRf1znWYK17NQvOAv?=
 =?us-ascii?Q?bGlwO43arKgVBEfEZUpxGNGMNw++3OeHXAbrczk4AQ8FKHG6aemsBQwyo6nH?=
 =?us-ascii?Q?Nfu4kTTFPZkJeZLFNmB2E0H74u311QzAoiuwubMYtg0IlVhRkCfhMQ+UlZgb?=
 =?us-ascii?Q?iZ3H7ORVLfz1+iF9qAB8Loko8nDYo14UAGUtsqQvaS0sa0Ek9yYkqomVHB11?=
 =?us-ascii?Q?Iss48rWg4A+ny7PJ8mtSLwhlTh6CHYCP3qZABVt7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be87896-2f7c-434e-a503-08dcbd0a393a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 09:11:18.8225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0U61TaFldENkqC/Q9IJl6rsJW8JwtyjISlC5UGYtg6QNArdR703AODhSKQJHWswT9uv2/Kfrto/CAY3mnuAFrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118

On Thu, Aug 15, 2024 at 03:07:01AM +0300, Vladimir Oltean wrote:
> The bridge VLAN implementation w.r.t. VLAN protocol is described in
> merge commit 1a0b20b25732 ("Merge branch 'bridge-next'"). We are only
> sensitive to those VLAN tags whose TPID is equal to the bridge's
> vlan_protocol. Thus, an 802.1ad VLAN should be treated as 802.1Q-untagged.
> 
> Add 3 tests which validate that:
> - 802.1ad-tagged traffic is learned into the PVID of an 802.1Q-aware
>   bridge
> - Double-tagged traffic is forwarded when just the PVID of the port is
>   present in the VLAN group of the ports
> - Double-tagged traffic is not forwarded when the PVID of the port is
>   absent from the VLAN group of the ports
> 
> The test passes with both veth and ocelot.

Thanks for the test. Passes with mlxsw as well.

> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

One question below

> ---
>  .../net/forwarding/bridge_vlan_aware.sh       | 54 ++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
> index 64bd00fe9a4f..90f8a244ea90 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
> @@ -1,7 +1,7 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion extern_learn"
> +ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding vlan_deletion extern_learn other_tpid"
>  NUM_NETIFS=4
>  CHECK_TC="yes"
>  source lib.sh
> @@ -142,6 +142,58 @@ extern_learn()
>  	bridge fdb del de:ad:be:ef:13:37 dev $swp1 master vlan 1 &> /dev/null
>  }
>  
> +other_tpid()
> +{
> +	local mac=de:ad:be:ef:13:37
> +
> +	# Test that packets with TPID 802.1ad VID 3 + TPID 802.1Q VID 5 are
> +	# classified as untagged by a bridge with vlan_protocol 802.1Q, and
> +	# are processed in the PVID of the ingress port (here 1). Not VID 3,
> +	# and not VID 5.
> +	RET=0
> +
> +	tc qdisc add dev $h2 clsact
> +	tc filter add dev $h2 ingress protocol all pref 1 handle 101 \
> +		flower dst_mac $mac action drop
> +	ip link set $h2 promisc on
> +	ethtool -K $h2 rx-vlan-filter off rx-vlan-stag-filter off

Any reason not to undo it at the end of the test like other settings?

> +
> +	$MZ -q $h1 -c 1 -b $mac -a own "88:a8 00:03 81:00 00:05 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
> +	sleep 1
> +
> +	# Match on 'self' addresses as well, for those drivers which
> +	# do not push their learned addresses to the bridge software
> +	# database
> +	bridge -j fdb show $swp1 | \
> +		jq -e ".[] | select(.mac == \"$(mac_get $h1)\") | select(.vlan == 1)" &> /dev/null
> +	check_err $? "FDB entry was not learned when it should"
> +
> +	log_test "FDB entry in PVID for VLAN-tagged with other TPID"
> +
> +	RET=0
> +	tc -j -s filter show dev $h2 ingress \
> +		| jq -e ".[] | select(.options.handle == 101) \
> +		| select(.options.actions[0].stats.packets == 1)" &> /dev/null
> +	check_err $? "Packet was not forwarded when it should"
> +	log_test "Reception of VLAN with other TPID as untagged"
> +
> +	bridge vlan del dev $swp1 vid 1
> +
> +	$MZ -q $h1 -c 1 -b $mac -a own "88:a8 00:03 81:00 00:05 08:00 aa-aa-aa-aa-aa-aa-aa-aa-aa"
> +	sleep 1
> +
> +	RET=0
> +	tc -j -s filter show dev $h2 ingress \
> +		| jq -e ".[] | select(.options.handle == 101) \
> +		| select(.options.actions[0].stats.packets == 1)" &> /dev/null
> +	check_err $? "Packet was forwarded when should not"
> +	log_test "Reception of VLAN with other TPID as untagged (no PVID)"
> +
> +	bridge vlan add dev $swp1 vid 1 pvid untagged
> +	ip link set $h2 promisc off
> +	tc qdisc del dev $h2 clsact
> +}
> +
>  trap cleanup EXIT
>  
>  setup_prepare
> -- 
> 2.34.1
> 

