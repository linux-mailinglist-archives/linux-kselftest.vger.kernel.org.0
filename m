Return-Path: <linux-kselftest+bounces-16267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1485B95EFE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 13:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A632B21646
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0F1547C5;
	Mon, 26 Aug 2024 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ayGjwcwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E745153812;
	Mon, 26 Aug 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672284; cv=fail; b=GDlb7gEWYbq8tqMzMem2WFv77EWybULvhwwtlhct+M11toZhTJjursz5LpAqxScwvf9+6zmfiKyArBK7DeWEge1Wi49d59/pt+tOWM6SJuCNMGCQlQK1IGfRh7OXSRoG4Db9oYvaKfwjGOwLX0bHbfuW51NR2jZedf+nzOsyk54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672284; c=relaxed/simple;
	bh=a2kPJVzJRocuvcTgL/0Qa/vpb7CW+BpbhA9GgJbva+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jR5AqPOKpx/99gSYRsOyPbrk97jFmZCXlGkGrvLB/TR4El+tedKij4eKwZan+r+OJSTDrU8Rs1lJ5qh03F4JixT7ucomDHEO1eqixRmBwslrYpVc3oleEA55KdpNF5olreISyeqaRHlz9D9TYkxq2cefm4XSi6T++k2Cf5ALRBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ayGjwcwQ; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx8a9CxbJT8oonlpougYqKx5jkTOm5EMzNWcldLOGKoZCsHQMSjFY3ylLprELShwRikdMeDSvQ/EqPCQzlwv722lgkgyluwUuj7jgB7nSoHslVdVoAVJTeQoTn1LPn2fgqj6bHY8xawgNt0yYDZqujRprKybFaHMP4W3hWVxWrThUIWWYhkqICa/0Z+iAxXdSYpRAI9dl9k5QX3ZFtHsvWmvm/rn04mvkR1cCKGFr/rl5n55+J3bNt9XdjOEjKfk+mjquutwG4MufJ6v3J7gShJraD4jCxKu6oN8KQCiR8ED3hvGpjzno/0ewSfZB8z2CrHBznhqJr1vt8eYuQ9+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+OqtR3UF+bY+/5YH6HDnBDa7golBD0IqrpdsNGutJA=;
 b=Goe+1veok8Q3e0mX9GJuSq1qJprvZnza90aGoDSpg9tCwit4h3V3WcdEam3Wgkm6YWlOFdZX9uFeijRkeXplvG6aI/Vaiv8jS39zEohigdYUp0Dsgajd/T3LMP/PwkzBY0DORdCjmNdw1jZ71HBJzszxXLlH7LKHfZPGjBRhBWcZTB3up11BojVRZaQBCoA3mejC5EkTVTmeB3yl70rG4lYge82PN8WCLxq3fa+AXz0LAAhePMeCbtUgVRlHij37/7LEVPk7/YQk0LdRyX0XupOS3K6q1+dZ/1KaNSX6sUS8fT2/Ke53bMGRXEL9mZLBAbNNNC9qV+69S74pRqq22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+OqtR3UF+bY+/5YH6HDnBDa7golBD0IqrpdsNGutJA=;
 b=ayGjwcwQ9RjRqFy6AE/1aUjs/NNRU9IQhy5Q7ZeWo+IaCTSpI+M72JRjctaTZx3zjAoTsQPytXro2clXMEIlGp3mShDKnnhko3t08/5Oz54UjBgfgEZK+4VHEWmwl+u8po1t0YvcP2cKPS0pEzEAgOZPmFJvyZ/U7p4HRK3rcQ1C3wx/RUwjl56Pc69zqza+gRshVKv+RoR6IH4FEx6LoYyyoZwHs/cWjCbUSi3zkG5AXoV3pTpR5c58rk5wQCCH9XfBn7p/lz58XAPhCZQAEdoDuU49GohAUeMY63GFUsmlzvulk0lqA32l9jA8xY2jILke50DVoWwZrjX5hi6UHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 11:37:58 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 11:37:57 +0000
Date: Mon, 26 Aug 2024 14:37:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 2/5] selftests: mlxsw: sch_red_core: Use
 defer for test cleanup
Message-ID: <ZsxpCuJiomaUCl4F@shredder.mtl.com>
References: <cover.1724324945.git.petrm@nvidia.com>
 <bc6a5bf947f0b1fedfed218ae172d823951ef9cb.1724324945.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6a5bf947f0b1fedfed218ae172d823951ef9cb.1724324945.git.petrm@nvidia.com>
X-ClientProxiedBy: FR0P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::7) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f0225a-485c-43e2-86e3-08dcc5c38863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C+V2zyeK470aRxj7RPvclQJEUbW7e0u3BJUGzKRr7T/HAfXvo/4OK75yBpto?=
 =?us-ascii?Q?xcJt7Ep2344uxrGDGx9p5K0Tm0kDAiR+4hPyo60pY9b4+uqIffC4QScZcT3+?=
 =?us-ascii?Q?HmeAn7V7LUio/6ObvVddyLhAa46TJT8xXhjENF/cQGP/1hRmNH6JTb0Wy3My?=
 =?us-ascii?Q?kO6jWhTuTZxJwK/5uBc6X2NS1nXhlGPbhIloI9qcg1M2gSGLbGdUtvWcDzqf?=
 =?us-ascii?Q?bB7ha/jParEqXE2AOhnpthMER6Trm5eUnSfcpnVqrSpJ206b41KQENeGsy/y?=
 =?us-ascii?Q?q3Kb2y90ASHutyBT9ijTRF1T/5CTMuj+oO9fv98nQxaDJ/cWsEnteB61QInb?=
 =?us-ascii?Q?KjpunIpzKQVqQkSMFfVHmzR62uINzJs8X7nVgfBaFPIizOSyn88GOc9FlP7B?=
 =?us-ascii?Q?UUkkY0ZiSirVLQxwCeNX0Cjd8s7TeWP2B6xY1uQTyGp6iD8HUsp1fgow7TuL?=
 =?us-ascii?Q?8pHsPQiJfTGW4JPENbH+p4b+zc+H63gA9J9a4Es58fe+S+kBpd12Xy/D1lkh?=
 =?us-ascii?Q?cFIf7lBdyck9xvIdkdnoPJdF1GJsKlVWYoyLgB8zv5cQONLQpQMAPPiMKXhU?=
 =?us-ascii?Q?GYjRHijhh5Hyrhn1Sit2Fi8y4BK/OJGz1bYjJtMzjkNh/vVHeOPQCMuzBluo?=
 =?us-ascii?Q?YYblvo/pfON7dFZWOAGfTH/USMBSJvPchgUjjRPdL5bR56a2Yrf4x+oh3M6C?=
 =?us-ascii?Q?vzOYF53/SC/ND3oKVA3U29fNpOoG/bzPeFAQqZeOCMTYWQad7Jptfn7yantb?=
 =?us-ascii?Q?DNAOnUoRX8JoEZaV0on/WtWVIB/uk0BGOkRfRxZc7wqKN/LGIHbyscHmTJ0Y?=
 =?us-ascii?Q?TJstrZVWIw/vyZZBBvTsRTC3R/Zl4sfJYOLKzwI4ffdygChEzL0swtrGcLjW?=
 =?us-ascii?Q?QAdsKtCYGcGVYQvMZf63jUTA+JPCXVdcwjkt4yY2p9exwnrD7Tl0k9H9BvH0?=
 =?us-ascii?Q?6KVtkPJJvMIcDfZwM7dzwH6BC15c/8yv390gjC1agdy5p7+EZ+Yq7LZPultp?=
 =?us-ascii?Q?xY43HmNobuNLG+97Xz/VvXH8QCpEuV2k9Kf28IeP/c+nO9EPLBttnESPtfkq?=
 =?us-ascii?Q?mVuywwiBXn+FZ/pHD2Q/M71bn/Lrym86zcRGCDFg5cmGogkW1l+ugfQYUypS?=
 =?us-ascii?Q?jEHKgFfQQ8sAfhVlUsUokKqk2VbijQp5GjYiu3ZyIKml3R3T9BeXSDzYGVwQ?=
 =?us-ascii?Q?/hj4dMoGd0kydTjE+jj6Qg8iFVX8m7ajSUbshPTGfUwxQmguWkhQXEGob5Df?=
 =?us-ascii?Q?8OJdhUvdChpUhNDYiiOyt5PB3A8f2Jheytpi8r+Cnjk2Xq11LKndXTkLvRxm?=
 =?us-ascii?Q?xAwJtLY5VzsdhIGBZfoeZlg/ApDl2xy0ziyviJcjUTOHOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zKyFgCkUE7KoN5zwZusIAj84pDaHTfLsQxaqmbjmfQ5loR5KBhxePgcrhQ5S?=
 =?us-ascii?Q?yzevicY2rthRKD7iwIUD3YJa990PvjYqFFrShsT9cHE/BJQ/gQ0fr9lzNruS?=
 =?us-ascii?Q?P3SqRHc0ocfuiwteFPiBtV+SOEsVyt5Owhhs31oxa7jQ3n8AzoyVSdDS0yVe?=
 =?us-ascii?Q?KnOblYXlipKcpImcf4Iu7p9m9QG2G8/3jZRdz8zl9mFYE0KkjCy6R5sN0qO5?=
 =?us-ascii?Q?HGg0MKjESCjwZrLoVVDl9SFex24ehw4FOg3yACEl7aiqG2mWx5Tmc3ZLgFoD?=
 =?us-ascii?Q?8hyMuN5PBU++PpAXcxVw9eFLFBw47sTFoASCS0vBJNFxOY4rKPSBPI8GCF9R?=
 =?us-ascii?Q?1LoLHCRF6LCuGiTk3ZBXk9GR6V3DiDbxPMVMR57uElJjSyKc/pXK2F1eleY1?=
 =?us-ascii?Q?510grwGewQUslgHL2j4DzMcqYsld7wnLZYxJ8vXLKmPr7CdQo9ZEOm6yXiKQ?=
 =?us-ascii?Q?LRsGQhsWGo1IPRTQtZxvgudj5YqEql5beOr/U+EXF0z3AnwvLdOhgbto0hAs?=
 =?us-ascii?Q?t6aVHQ8nSP54S07uJODAEVZe9MmyGO/oBLj7tWzdvMlZtpaRChnSeA4JCoUm?=
 =?us-ascii?Q?EthBcTej1s/IW2vsr0aapOCQCpNyxSN0TGyLcjOHQRAMZnmcsIbRuz/VDvS3?=
 =?us-ascii?Q?vDahpmk50jY25Czbyfuz9uL4N92RuVrya8/iu63beScLvs2AsgBz7PDj00fW?=
 =?us-ascii?Q?OJrvnYdggRrfPfRzGhMKypkhq1thXwcJCp6kEsPjnYwW/8AT1/Rq/Sib9YOc?=
 =?us-ascii?Q?f7/d7acz2tqmvll4I1PzRtWbaAHsgwQ3zDIzbxovO+ssc//cbXNXXek7It/+?=
 =?us-ascii?Q?/cO7PFJkIPJeMrMApV1YgyqRu1r+1f6tvwI2ScLi2KvOTJwOvhhlfoFE/Q0N?=
 =?us-ascii?Q?V9DFqxqqUZbB3H1KxMBH8xgePTJ52WSz4UyyXW4MVbu4tpiNvOBR0CJtfGVI?=
 =?us-ascii?Q?ez6hC3I19U+C5Kno8k2QUMpV+TkFSkCh8cfbzHjTWQKXHcHy+dWYyowBPkP4?=
 =?us-ascii?Q?b16BTstACHmobu7D7/bwNUJURvko7xIiGwA5uUovgf9KiB1xodWarT+I3S34?=
 =?us-ascii?Q?BLvGXWuVl+5y2p0gGIByElhPb+/8+tZTkJCamoc35ZPygacxqqQQV/H9mGmS?=
 =?us-ascii?Q?HB4FYM3EDKUdziolZgszVbYO9getyoVSWRDa8D9QAk0sbSB6u5qyAEa3l6tj?=
 =?us-ascii?Q?o2+NjERSWzOSiYw38V7DKvoIG4Z6EfgMMh8Sf+yZ23v3X7Ak4sZeScUeBpm4?=
 =?us-ascii?Q?9cgIdrBmruLZJXxD6EFapSKjNA3pXBLNmVYGTAIDTRiXgFQSyk8iLgy5o2Bn?=
 =?us-ascii?Q?wh8xz4xfhqZr+VyGgPGFaAZYixBNePwW42axT5ST91jI3X755eT3a5m60Fb+?=
 =?us-ascii?Q?Ex71Ydn3visjXZg/KaOvln431mBoTBGnOwrEXr2jrJRczX+YbfDemLtR9mhl?=
 =?us-ascii?Q?7HalkVUeyRToyxIXeCBEpaQRN5aN4WcQ61augk+3h7hJ+w8x8g9+cSdrfybX?=
 =?us-ascii?Q?dsCMtu0OntVo1YWvEs4xS6H1/AcyVr+h5E4rD8lXJxt7u6qnNiE5Tbd0Deg1?=
 =?us-ascii?Q?6HkYnDEwoICbxnS+WpdZ0CG88rxxAhr+cFbjq7QY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f0225a-485c-43e2-86e3-08dcc5c38863
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:37:57.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHlOyjtzqCUoIKiS1WIO4ftkszHQb2KSLuPkM5DCXefHWIjtZDIRLYwg0fI41LjgZ0fmD6IhUA+tNRYzMFUS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581

On Thu, Aug 22, 2024 at 03:49:41PM +0200, Petr Machata wrote:
> Instead of having a suite of dedicated cleanup functions, use the defer
> framework to schedule cleanups right as their setup functions are run.
> 
> This makes a dedicated cleanup() moot, instead fall back to the
> lib.sh-provided one, which invokes the necessary defer cleanups as well.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

