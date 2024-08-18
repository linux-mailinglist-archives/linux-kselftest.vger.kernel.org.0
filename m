Return-Path: <linux-kselftest+bounces-15592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B20F955C47
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67A21F213ED
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA7917557;
	Sun, 18 Aug 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H6JwIe6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB31BC20;
	Sun, 18 Aug 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723980226; cv=fail; b=k2nCGT2Si2RijMCTeyqeM9hJkySGqJhyXliH25KJ1kxi3WCZ2TYbwUHV2E9V9aFj2166w49Nu4CIgAxKBmwONRkBMpIIETfQvebQ55V/N7X2faUnBPYnXZGCGRHMPcRScZxgXt1KbTjRaCeHwFfCRJw+4lK9zfBalnXtOovtijE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723980226; c=relaxed/simple;
	bh=bUQfTjwBWbYsNOyEja86gx+ukjlk28IxhW6n5K+T6IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VopubRTNqUf4CX1EOdrMhNpaxjJ8oozraddEVTLKKwLF1MthTXyJmVAyFYiMwY055T/7Vik6SsnIHXdShgQvW80A5qcLcqAdE3XNMeJ3nq140a2i2CIvFzaD5Rq0DXMOTLf35J0vpuS2Kc2A64WP6lSEixdl+9c1MZQhUAsdrkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H6JwIe6u; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmiwe40I7rcHXGeh9y/qUyttZ3Y7hiDsHR2Bn5hL1l8hHofKeYwrvbdYVDu70QPcYK8t78gMEGiWTlvvpHXCWbBSkapuZMuU8iKZ7GlTPYc9n1JEsR2CAXxUdhb2lif5wL6y20huGHg05mhwJoBkxGIX+JDHo1D9VQtjS4eCuDH3I0nd7JmvmrpGXBnBE43FWkWizn/sS+/qJJ8gEaX07FyGjw6tH5knrWZ4Rop3/hxp5xwy+d2TiS6FO9OavUDNP45zznJEAbOodABJBlBLrtggrbYs/Osb7Uykr2sRSkbdTDhL/vGOpWeGdqgYF5sEbPhcNgTfoIeBkZnqFhZUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEJMDvo/S+GRJvYA75FBbQXfusoHKMKJXIuz+8YoTMY=;
 b=xtInfSH8sCjHjfj34cgXmAlHTtQtNOTJhIadWttMVqZN+2VNxpx3N3xrrcr029SwVKWTPlzlaGpcLxyI2ySFTDp+ai1Uv8fEB4d+kWI1Tsgb1DI0mL76XIFAC54LEY0w4LF8jKLiPMST/gRyhNmo+CSZygwgKdlnrNC/MJe89eiqXx8y/ugf9bwBKHha1A7LyVfFYIYGVSxXwi80hE46bvYEOtuH/5UZJv42rW3GUkCZ8qmRav6rY4PytMiCjX8WLuR/Dll9bsEFHk/ctay0z5elU9SttirlLQ4J1FrIMMulWAfmIY4sXWp2PZ4DUuPy+Fm/mpobas/pepbtsxryWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEJMDvo/S+GRJvYA75FBbQXfusoHKMKJXIuz+8YoTMY=;
 b=H6JwIe6u2BKGL/T5nDLy4FK5AgMfaNf/3zb5eJOBweJmUrb4gbcdE5U0sdqNCcdFTZtT17giB9aYUiDAddv+aI1Hj72fAH1Cgp7XkX1n0AgB0Xd4BR0F0KX0B/Nu2AppxkN9I9XwwrkGN6obC+cbHyH53MercqOiYBGUdhWZgbPFlih/JkIQ/7r6e8fks4me+JisPdlBeYQd/HqcWblLVatGFCyGUr+De6NqonL1yYAXYGJoQ+nY0yjUqCSn/evbrBPZUU7UuRdNUAXwlkiUs5u+23tvgUsFgpSVpa1dv3Gdc0GLMRii21Cgy0C6UhrM4T9leZdq0/vOD90M1WMzTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sun, 18 Aug
 2024 11:23:42 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 11:23:42 +0000
Date: Sun, 18 Aug 2024 14:23:29 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net/forwarding: spawn sh inside vrf
 to speed up ping loop
Message-ID: <ZsHZsemDSrG-qG__@shredder>
References: <20240817203659.712085-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817203659.712085-1-kuba@kernel.org>
X-ClientProxiedBy: LO4P123CA0449.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::22) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 4428a32b-c7b0-4bbd-8ce4-08dcbf783703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1fQ52MbA0VAnGpT8gb++/DXymeY+vco9Wo7RUXbWVxdl8IVLz8d47qnEQMC1?=
 =?us-ascii?Q?xSSl8szMV5o4IjlLcgVJnWonTHhm+CXZj3Gz1eRqdo0R1efuQNIUpQSbvLAq?=
 =?us-ascii?Q?B8nCDyMTICIE92esboEL5o/Sr4Icgy3ld1+ukdKNzYrhdbCGqEVfFKGnJQtg?=
 =?us-ascii?Q?6NCRJwULr9dmWZHsK43YN8p5MBhyiCDagdiDbLLQZtOmsi8GY3jC2mXDw1RB?=
 =?us-ascii?Q?AERxquQE6ke1q+cfMMjCZ5ut0dBSQ7GHf3eTeBO7u3ZaFL25fCBi+gq8MUfV?=
 =?us-ascii?Q?wO4nfFBfQ1jbCIk5zBdeProGLill+7KcB8yG7Qljo0u6lj1ZAIie5XWqWb6F?=
 =?us-ascii?Q?90VBu/6aO2XE8q2BEPityl+UCnuTYuZaxKCAuISzgAad47bwwsE8xcYx4T3p?=
 =?us-ascii?Q?7NxpThQeKL+dBhDk1OyJqZtnzCkjsNjXrPR/HY/XAOoa+Ye+uKEchfi1VH25?=
 =?us-ascii?Q?//e2myEX8arh0gaIQyHSLzWN1fMJSLoitCLXa7LIIDpKeCswdrmhqs9laGHJ?=
 =?us-ascii?Q?sIlMtZtRzqrmI/Rc7SKN/2vkmNCkVAaK9jCkV5fRSujKabj3jJjygHr5t3pf?=
 =?us-ascii?Q?C5l2XUkkEJ4RO/GUG7zk/uGzUQwHfUT6t7CHJYbwlmSWuIpHtm7OpPNHdYEk?=
 =?us-ascii?Q?U0zNieX8J6uvzvfCJK7sju5mOucJ/9r8oiALJKSTt+S8PDxADnGi7eoiQ/nE?=
 =?us-ascii?Q?3DkGGJ78rNFdYJtysYLQ32G6VwcqGkvOwfKjMN56RIms7jjzlkIok5YEpAsS?=
 =?us-ascii?Q?MGtOvxRXK1g70YihnGnKN+NO9aYkOu0LN2Mzv8DMkwUBN5tAMN4HAm+8NqRD?=
 =?us-ascii?Q?Ngu7aPX2cRE6iW3if+tzFb2hBBd3WcNZ6ncK5BADsHvFSIAoLXDwxlaRfAlU?=
 =?us-ascii?Q?lrqSAdMkFHuLBGfSXhqUAoDbr38N0GTJ9zBi83qetdIF7ZUr64dCzkmPcVhk?=
 =?us-ascii?Q?JD2ovNN2YsAnBYVVJO2cUAPAqx3QEHZopiEeahjtw8euj7/7YqJpVtzO2wCU?=
 =?us-ascii?Q?UIbODl11tFmj2eP+1Bw2OmMmQzXlB47qF8cEKvWDUTYUyFl0Z9X2MTX+Mrua?=
 =?us-ascii?Q?L2FNg8fmOua5s9e0Gn+2j65aykl8CdVSH/gn3kU2hHL+1SACvwYzEcjOlczu?=
 =?us-ascii?Q?eH8QdUvASrM2PQu3/ewqsO61VDK0x/Kj+SQlLDwn/WzHpkICKPdQ566mXP1w?=
 =?us-ascii?Q?M27PdE/ifcyC1CN7vPhZTqkPogIBhQGCRb+DkkXKTrqo/f/wSBVkYw/oKBqy?=
 =?us-ascii?Q?HITk7sE8aF+79nBoZPhTwkH6dcOwT78SG9pBPBBC19r9yDCOj+i5NaxeFogS?=
 =?us-ascii?Q?CP7Q0ACAil9c9Tdb8kxzjQfgSMeLyx3ZqvkOxoqrs9fDVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hXJeG59Cbkqvw6wS4Jt12dCzZGsa4lpgFVrVCbTlztpQBTMz642KMA2lvR9m?=
 =?us-ascii?Q?0EPOKF5ZFxXP79AqXjOKSQXBXLdF10CsMYz/mNN/VjexT7yVaBOnRtV/LkRA?=
 =?us-ascii?Q?SCfwG68qnhXtZwXZJoZmz+uTcqLbLz+5fCoSLXD3zaUHy7e1LbvVQr9TGzs2?=
 =?us-ascii?Q?+NIG80NgVFkDcRpPVqvopgPTzHTn8yQDE29He7NIseVLrQuVdtksbErRJytR?=
 =?us-ascii?Q?wTSD+mfrwDY9+0GKG8smhmvCIOqsVHweYzH/BU9DjdNL4Do+U/+JpCzS9il+?=
 =?us-ascii?Q?q774kZJMUWuVRkjdlA9rW+GN6m3ubdRqsP2GwEvWizFT/9XTxc8EgjTWQxWO?=
 =?us-ascii?Q?+pAyCadBhExEGEqmGOTH4K9eBqAvYPv77gf219/OWqOFtZpWP+qIUtMNl56y?=
 =?us-ascii?Q?wYefOSXUQH5NpkIgstQKyDtNtFpLsWHXg4WnT1ZSJpGnS7aS5zqEUfhmfctY?=
 =?us-ascii?Q?iRNDWzgtb2bQKs79YC4WGWrY/0JOh93F0ia1FhKgyaiTGjBnPuDu4qhROk1G?=
 =?us-ascii?Q?muvdXxB32Z7GW05VUH0N2y06MlSqXzhpgDNYiarRD9JhwGa4QWxM5GTldxzA?=
 =?us-ascii?Q?pffvdnkVQq+JDwO2ojc2T5L2pHnOxl4rUetiHPaCyyLxMoj0eeKAcR0d2AFX?=
 =?us-ascii?Q?HHRSLTOkc/DoH0P9m3DXxgDSCwCQDHnkLnkvXsxO5hmHrOosWyL1iqI0W+A6?=
 =?us-ascii?Q?qY4nLyFe9qUZuSESKW2rr4nW6eXHGcdOzIyyrzagAsKbC+1VwQhl1wC+07Qu?=
 =?us-ascii?Q?nPuDvna3JUOhC+lT+fOctp+j10fKNoTlivFVfFbdP8Dy7UQRAxHD8QDpWh/3?=
 =?us-ascii?Q?N5TdwgNW0Zc0fOeK1YDG7SaskAP23yo0UHEN9YH8MIL8/VQAsLHbxcatKV1p?=
 =?us-ascii?Q?8BOLs7/EI4VEvsVGLgvXfQWAVdyCs9+8TyBNpPUQWVAeLokm1eekvIIRFqIp?=
 =?us-ascii?Q?mU5IWUTHjcyqKmok6h7jherOfpDvDWpUaZl685fK7DWXu4FVuW608hUBJ1Sf?=
 =?us-ascii?Q?iwd6yF8dgYHzPixDNx9kKqqIcnIwvfi7QWqGynVKa8Zo+QuycghUFgZkXvgu?=
 =?us-ascii?Q?Dlz75qf+vanRy6ZAAYmUI7hHKTZcVSq9romEbZl+HgBF2Si2abaAqno1OgYb?=
 =?us-ascii?Q?spJkNBxbelylaq1sbc4nHmx99ZR40XvqkyNA915TOwoyNNuBWlM78ZFIX8vE?=
 =?us-ascii?Q?kt0jUfB4kR/5ohatB4M0kw/Xs//lV/Jyt0Ra5c3TMajVMQTn5nWs/VuzmcDL?=
 =?us-ascii?Q?xbZL8nPf4SUEOlGI2GGP3mlcB7Oj43qfAfLhuYpV9Ur1fFZyzV9VaupQQ4te?=
 =?us-ascii?Q?wMzviwArC2taj4MmzSomywoLF849t/c1F331reUdUDS46LAnvqmr13NgrnMd?=
 =?us-ascii?Q?BhVe1EHqEeKCfCJMs+tG0+oLn8+APRhXLfBmkKL9kQff2LS1ABFEdiYNulxo?=
 =?us-ascii?Q?eTyBHtt1bVZS1FRXIbgTQ6OqHFArW91inIZprabJr2GIt0agsZTZxNXn8h7G?=
 =?us-ascii?Q?whOFnQMWwR2FFTg2EgsuAKHLcv2zBPS6lBnzcLsP79byXBG6/xV3q50CIEE0?=
 =?us-ascii?Q?IoBT3EvHjiTGL9JnIcc0Y8Ntbl32yPX2rGcQ04+0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4428a32b-c7b0-4bbd-8ce4-08dcbf783703
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 11:23:42.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ggfp3R/fjaZvMNd3UmmVZjzHVyBKbveylm2/t0xxuMzdwux73wZisE7LhLpZtlFcbBdH3VD2HRaN9Z9/d9Lczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412

On Sat, Aug 17, 2024 at 01:36:59PM -0700, Jakub Kicinski wrote:
> Looking at timestamped output of netdev CI reveals that
> most of the time in forwarding tests for custom route
> hashing is spent on a single case, namely the test which
> uses ping (mausezahn does not support flow labels).
> 
> On a non-debug kernel we spend 714 of 730 total test
> runtime (97%) on this test case. While having flow label
> support in a traffic gen tool / mausezahn would be best,
> we can significantly speed up the loop by putting ip vrf exec
> outside of the iteration.
> 
> In a test of 1000 pings using a normal loop takes 50 seconds
> to finish. While using:
> 
>   ip vrf exec $vrf sh -c "$loop-body"
> 
> takes 12 seconds (1/4 of the time).
> 
> Some of the slowness is likely due to our inefficient virtualization
> setup, but even on my laptop running "ip link help" 16k times takes
> 25-30 seconds, so I think it's worth optimizing even for fastest
> setups.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

