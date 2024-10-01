Return-Path: <linux-kselftest+bounces-18733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206F598BBD5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 14:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F301F21FF5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1821C1ACB;
	Tue,  1 Oct 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nGoq+MVs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9601C1AB4;
	Tue,  1 Oct 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784634; cv=fail; b=Xr5MXsfcSks27GCIfQ2vRYEPM0Hqo3qBNboY1ZwZCyBVLbxMJ1MGv4rD/0WJ+4vrdiRpnwKmPfLvQvBsqzhyqr//HlbA6DxMGberWZGKRU1S2VkWn1tgkznUvMRmE+mveV+4TilJatZZ5F4PikILR5bG0w2eZMYvi6bhlcZeRBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784634; c=relaxed/simple;
	bh=fsv42npEeOEAc7wSBtj0deHTVAM2goza+kzk+ZzcnoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TxqejmayYUjUXxnmSGJAGCyigYU8X2kD/FfR73cRAW5p2xNC5H/uZreENgs99SA6fnBmaGx+pIJVlkSKI5EZnv52Dwx5bNcFbs4pLnbzJ5RRe/VeKPb3XZ22OjkYWuI4euPoKLm/ixadhQV9hG3NYuNTwqEuN2j3LfEBGSPN8BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nGoq+MVs; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED/hHVpZNiBHfbVfocEFYH1BvrxzkMYGOUUlAoFtaf2mhZyInn/dHnUvU4BsmvA/QDnXc1+OHSAYUmKGWNXosKoc+SC0coko4I6nTxnPPTSPGns0Lrpc7K2g6zKeX/+A30iRwIO8TQ6rcuibIw6jiGT+Nlhs6A9aZ6AHJxrm1Q5qT0U1yzdf4Rczj5qp2ErObjMnx3GIcNliuuB8IsUf304Q2XyN2cT4BiYV9GXBF3YbW7J4X1zhavXCEGL8KjeqkLF6yDuv7CjUKw4PzXXfUnar1T6aROBjnRuSBvjkg+RaZvcTMU4JL0npuuTJhDjfIRggJfNXteo9P+gF9qLh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsv42npEeOEAc7wSBtj0deHTVAM2goza+kzk+ZzcnoU=;
 b=do+wjVLnWBDz+HZYoatwAA+DUn1bWG04THeIMDH2OKrsly5uEAHk922xus8UH8ODItrX//WGyy2o4NYbGj5BedRAdWOU9o1E6IE1+P9Y/s+6X41Bfh3PXzwF2InfBWuA2SBq7PYnUM+WdpJtFNPgW8fZtPJSioGXbqFgV+VCcKTD57o7dUFz4RkVNMF1cAV1/9KGR2prA5iK+Knw6LTh3nO+it3d9wPRCJBOPi8I9UIecSEcaBi0T2Ji/w3jqgjnGt2bdL7EV1ccE1wHjCIKJegroEsxtkciMYcHhI/2XSkItXxOqKbtppm9mJLnJwLnvUEwliqwGNvHfBHt3+JeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsv42npEeOEAc7wSBtj0deHTVAM2goza+kzk+ZzcnoU=;
 b=nGoq+MVs9pMoYHA3kqv5XrYlhdH07Trru4llZHhGvfBVPkQ4VqXIJ0bf2Buj+Yy2FsrrTLm+PSTcWNk20zhD9CXYxcbMZolvuYNUyThT2mxKjbaG8YdlkFbz0JnXFcgptI5RGVY7mM4oxbWyfA2XSCNWwg4VFN1hCYDRmGOjgrlYZigyLZHqagjkMCnFMtRooGSpUe6/TICY3vfcl1j91DwzyxxnM9Egtthux6F0CKsDa5i12F9n7xHyGaJEDNGzo6EXI1QJSBpNxE+pIhLWZUlVSXxHneAsEWB7kpkT3R2VhBYpi5TDAKfUNK9MPwi6BX64j27NaHKtUV+dNeVsSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8473.eurprd04.prod.outlook.com (2603:10a6:102:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.27; Tue, 1 Oct
 2024 12:10:25 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Tue, 1 Oct 2024
 12:10:25 +0000
Date: Tue, 1 Oct 2024 15:10:21 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Kacper Ludwinski <kac.ludwinski@icloud.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, petrm@nvidia.com, horms@kernel.org,
	edumazet@google.com, shuah@kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net v4] selftests: net: no_forwarding: fix VID for $swp2
 in one_bridge_two_pvids() test
Message-ID: <20241001121021.jczfi6s4xrjy5mvn@skbuf>
References: <20240930063543.94247-1-kac.ludwinski@icloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930063543.94247-1-kac.ludwinski@icloud.com>
X-ClientProxiedBy: VI1PR02CA0048.eurprd02.prod.outlook.com
 (2603:10a6:802:14::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: c83c12cc-0266-471a-a400-08dce21207d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IqG1NEsUsKgVpNlGmNiIeV/nzuMp2o3vg/RmwpZrIW4/jkS4ttTyL0PKdyGI?=
 =?us-ascii?Q?dmJEOYd2Ofc2GIv0SPtV575d+B4oRpHQ2Ulk1Q3ldW6HP/h2vsL4tsggzaU0?=
 =?us-ascii?Q?mChzLiG+Hm8ZGJkC2VDzcs/6iRWP+7uLUGhpaEC4Tmju53lwbIFTjYGiNg+v?=
 =?us-ascii?Q?H/AyvObu8mkTvytnw0Z6YKHkpAQC/GBrN+uC5HZl6PoPzYBso7QbcW7xBrju?=
 =?us-ascii?Q?r+w/oEg0lGRznYiQuatXg9uJXFfTd0Rjw6Eh56Rr+VO6Whuq4QtADD1BRDMy?=
 =?us-ascii?Q?aq+JUqHknUZRyz1Vx3eV7H+UD7zmik5wD+bQLNaATJdic/ViusgVD5FMRgPO?=
 =?us-ascii?Q?nU4BbMKtzGm+3skc/7B7D5CDUTPkki4TX84A5mHQ/m+yaXwYZTwWh5KZdTO/?=
 =?us-ascii?Q?t0/VyAEEJmuBP5BTcHkE9eTTYRtvJdVwabP7FYMsVqFuWqchRHXOFDVbqvK8?=
 =?us-ascii?Q?7wxpuf1/2x94iUXpdXdWOs+/z9afoD4vIy+y/YR9/nnAJLher8OwK1HqlEuX?=
 =?us-ascii?Q?xrk35HJL8svK+v5xGJULgNyVS1XVwxSU3/qN067ip1pChqHdMt12jaPAD1Z2?=
 =?us-ascii?Q?KguSBhgIqM3BWpymEKW435DQBKViBXwEJL9ItHVGX6Hmd80A2N7EPVEyxbB3?=
 =?us-ascii?Q?aO87+dvkZioteLuNSslDzZwkqj693Zt5QNHThfH+BfEM1up4y4pxujgDJzha?=
 =?us-ascii?Q?kHdcFgsCfGoMqIEbWvHNLMSSaRZPlW9ybFmf1OsaFqv13V7/d8HSd/Q+JwY8?=
 =?us-ascii?Q?QJX2FKRk6u/9WyMsgrcW0mFQpNjGjG6sYloqezksj5IC/ks7n+nxb/ttvpPQ?=
 =?us-ascii?Q?0NSbaJjLPz+KrVbnURHgRyE37IwKG5lD8muuUIINt8j/WXMnUSTVw2ipbcZ6?=
 =?us-ascii?Q?tpcpat5lZK+dB/cC6+ieke9eHaFWCA1rTVC/RhJoy3vHJ19x5tcrnCkiJL8H?=
 =?us-ascii?Q?FHRxlw5fd9kDMNO35wUzQKtyJVeIWrA+cg7GZ3d1sxaXNMgNBJiC/sJngwIh?=
 =?us-ascii?Q?sR+JdaWPfsAzO3FxGKAdkQlRe4WqUpptIuL9JqeqOTAn6euqfnrv3oDHyo9k?=
 =?us-ascii?Q?m9ixR+O4rB2vH7C0bPcqVZI1dNKtriV6ZC7G4EgNas4m8tHj/CJ0iCaglEbQ?=
 =?us-ascii?Q?h/1qlFUARaHCciRvNujYUePFrA6GzmrBUQzmCtM2gkmhM+n4vRTRtYkm9mmQ?=
 =?us-ascii?Q?TjbSniddCWryxkE3z1oAiK9ZqoXvkQp6R4eYjvOWWpBqeYFpRH418kHLp5s3?=
 =?us-ascii?Q?u8gfEKK6csjZ6M4KcqopX3o64EY2HFDVX70wTAa19w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIW2ZZr3z7q//n5Sobtfw40ZMl16g3TVTHVUxSe5luNfkk++2IAxCiBL7eTn?=
 =?us-ascii?Q?EGxPA0ZrMJY8weR7U7mi14TOxtmOnWkoZnuNZ2PbeMOv+zVW+aKPyKfynavS?=
 =?us-ascii?Q?Soh1ua9zjcucpXR0WOm3JeQ3Ppd9OFsqX+zbiK8y3D8DfgaOWVRvRNSJKT9U?=
 =?us-ascii?Q?flifSZ6kxappcOakb2jrCEQmv4SMPlFua6bFpUiC6J4BYOX1dn5RS2teHEqY?=
 =?us-ascii?Q?dKWCyCp1ydG+FoTGnRFA1v74AkeaLfCUqZXimsIhwMjYT+MXKI/ILn7AjVCM?=
 =?us-ascii?Q?lRWzJrBfIOavQ0Jov9yVkTpuzHY6aeg/q/CUotHgfB88tUv679szRM9ZFcxP?=
 =?us-ascii?Q?oprYBRpvSiKvkMNkcJv4UqjMwOL0iB37egJRsS5adNtdoBoKBMPEygJsU//d?=
 =?us-ascii?Q?oxriopcxp6KsUWwWXi0eraSRI4E+bor+29n66OyVoqwrOg+4KbofUPaYW+5m?=
 =?us-ascii?Q?CJ2LpBEKwU5gsC8QvwIi+8eMVQ3ShrsRl8Y63ncZ6XoctFQJwfmWHUqi/yzW?=
 =?us-ascii?Q?1d2g3ovJknFFUymZKkr7VESwUan40IvcCB+1+KZDxG5UZlpDzCSOBKHZT9kj?=
 =?us-ascii?Q?gd6k1AzdjJms+a6RpMYYauqu4ryUqlegh80HbTdD4UDBKHH+JkxLYmyMeLl8?=
 =?us-ascii?Q?ohcFt5baMOOE842wJSTifxbBN6sZXIerSv6dFfQZ+z0dhRuSmXYXjVbILJPj?=
 =?us-ascii?Q?TaFK0DZ2HzcTDC4rT4YdlMSlOTdRAjwYICjnlY6uUSlv7gOBy3LvDVtufnbH?=
 =?us-ascii?Q?TB7R+G1E7zoUXgmLet28Er9x4oJM+GJKuIWPWGNpDbmejsNTuDqphf72JV9D?=
 =?us-ascii?Q?U3rdARFFzcTlqKsBiW53vHC9STZtySE4YpGrg2tYoi7Napaap95YbSgJ/bJG?=
 =?us-ascii?Q?dxl502V4Ku2ybS5t/34BgqQh9rkPgKEcOOpvgBzit4DrpOoV77plIOL8AqtK?=
 =?us-ascii?Q?YZ2Ijwozvok76l3PrGDPQmeqw82xWHm8Q4d266MzBNTsZxTX+1dCbhUV3Zj4?=
 =?us-ascii?Q?fF20mxzj+mSSLh0ztKHKyMp8He176yrMHgL2O5+GuYfSHLmEpoL5QST1q9i0?=
 =?us-ascii?Q?84CjKV1I7I2gTwA18nKJC1PkyFqXmxyld4wxyZS3nKrJizy0fP8NEmo2sLjU?=
 =?us-ascii?Q?uIO7eQ/Zpx9+veWC+3Xcv9v3qCN/pu71K/smGaKUeFZuTxB+7LgvIQ09zFj5?=
 =?us-ascii?Q?k9u6TNaW2HU4k3oPaO93PUeJXRPYsytGjQrrMj9obNO0mvRsIQRykz81uRPi?=
 =?us-ascii?Q?d6IJ0grhsnYMCMAJEXAHJb+0Z2jctq77FKAQR81QPRcPvGodmSD+8uQdnMOA?=
 =?us-ascii?Q?aKpBIiMtwevCRTpX3hWmbXWvBFFZkU7g1T2Za38pDBU2aztZrlaUCqzsbLs4?=
 =?us-ascii?Q?Zn1K1kJBFqBtKkXIZ+TCw7q1IF3nirKxHWKx2gx5ETDPNx/EtjailUsEuevw?=
 =?us-ascii?Q?uwU3u0+UMRU/V+9UxurL7i2N4Dsz1qme3gDp+u0Wplpc77GLM4RjomvLZ+mD?=
 =?us-ascii?Q?pz1R0T2jJNps4y6VsSGhhxXjy2VTm0pTnV/ZUZ52Nvd3/ALIYG/Fx/lqs8HE?=
 =?us-ascii?Q?IJ9UxtvzQspbrzZExCa6Ild95jyRqRoU2TaZcPSybckOlizC8adIQCffusTO?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83c12cc-0266-471a-a400-08dce21207d1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:10:25.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BRO06/N4EhLupJkARi5PDifvtbcNt2c0NmBQ1jYQ1NwLbo60I6Dc1Yf5oyokoVznGH72bWGpNHIXM/f2DnBrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8473

On Mon, Sep 30, 2024 at 03:35:43PM +0900, Kacper Ludwinski wrote:
> This typo has an impact on results of the test results,
> potentially leading to wrong conclusions regarding
> the functionality of a network device.

Did you test this? You are effectively introducing a new test.
Could you include the test result in the commit message, please?
Also, "results of the test results" doesn't sound too good.

