Return-Path: <linux-kselftest+bounces-20686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303589B0A85
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870831F25574
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BCC18C933;
	Fri, 25 Oct 2024 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ahWQiV9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F911862AE;
	Fri, 25 Oct 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875977; cv=fail; b=ieaSVUpMwi/HfA5Kemn8oU/tAmuO4bLaY2dAv0oko9T1gQpk8/NNfNkrEhHKFXMsmP/pghXs1SdKwEpGs7MvX9nAFuZM8UOW23YMEgB6kqA+R6hTfwnDYBIzVbkzbfNWWpHaT/EIe2hl4+jHiJVXBaXxhdB+4OS8loLEruD1/4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875977; c=relaxed/simple;
	bh=rUKdYp8Y61B2uPBwa1+iLqZJE/zma9ajQDBmw9DnlF8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kMM5dbqisVAceSUhlISk8YeUoi8XN4yiwaGK8/m62+ArwbH6RH8EZAzY0YCnWovqSp8mcAGgN2b53/Jryotafj/KJLZaL+H9LOVwZxnCBbbjmFKP4xG/XHmu59Kkr/b2st62hOX6bcpJObxg1SlafwlA2YZUlssENgtJQBHujBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ahWQiV9F; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMkY5RkxMCbGtvsXgLZuIIiZB++bY0JHwwi4JULmX8yXVvkjV8cyUXwuK0iwrKr6fyz77PaJuXDlNpCVfKCZ3/kk3RceM+YIKZBmTo+1i/CwdG2/hFkAkbPKlF6UOO0/a5WpU9I64mVDjLqBb0we16whdulyfLalDLr06PpcqOtjQR9PKsWfUFTfUrrOK8giaVHFc+v036ifLhhZ8gCoBvOxLXgpf1MdbTtmy83qiFW4eVOsqJxvxM/7Hpx8bMW9m5flvN6thOH2xKlxhutoTjs4N0R1S1669tSAoZsgP7LTmAWD0frQfbvmc3x3Mhzd/cNj5cx5PQGcM/gTkkF8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsuoDUDdBmpoju9FPPauOjpmY0+aFfxgBgBLw7SIWqA=;
 b=Z0pDNLXKMErx71ES+vx143tqFDLRDodnBLg4R8W4Q8nAORzdfkoCl7GESY9+0Dzr9eR+wP4Fk1EH4rKEXG/Q5/hmvNB3e/0J07m2kGQxqOAUwloUlCIjvrx9ZGyfa3hFN5no6UMtxqub5MiuNNcYcsjr1Ou/gBe46QhX3uB3vkpY1xVhdb5Pz6IshBDizgqjOiXehBALf8bI7TIMbtC19F4gLd/tneFjNabbjDFtWtd8WA33sH37z4ZeWfZlbBAmWDR9GUaVmVvdzH8I+U564elONdnUXAq8ni7s9gIt+jNo/Evc6G0taKfxUWDO8tfaunVcnd65u5/ZEGJdpZsElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsuoDUDdBmpoju9FPPauOjpmY0+aFfxgBgBLw7SIWqA=;
 b=ahWQiV9FwiozRSYbzJezHdm7g+hPRVy4o5GVCEutKioIIm516MJzXyAmGOaR8UzaatJWvwp3aq5oOscqrzpCnX23Hx1xS+94vjVJM35RetCzidjeFMRgoYJVcFWoiX1ZrUCfeSx8Ey8cRHBnhNGpA7u9oqbYV38dVrTfiQLGFa16EdkBNxch9QqA7XGE9eJ63CSdyJ45RwojzBMkE4hA7LOqI5ryY4wsze8pNiwH+ViSVfYyn1aZvWhxF9btWkwNuM17UfLlHhStatw3FvDJ4v0wvnxVA/8N9obcI8PHgqrMU2Rb8jI7pIJ7Z3e3nTiZAtsis8MxCMidt1sJz/Qc4Q==
Received: from CH2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:610:58::15)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 17:06:10 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::5a) by CH2PR20CA0005.outlook.office365.com
 (2603:10b6:610:58::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 17:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 17:06:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 10:05:56 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 10:05:48 -0700
References: <20241025161415.238215-1-leitao@debian.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Breno Leitao <leitao@debian.org>
CC: <kuba@kernel.org>, <horms@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <matttbe@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	<thepacketgeek@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <davej@codemonkey.org.uk>,
	<vlad.wing@gmail.com>, <max@kutsevol.com>, <kernel-team@meta.com>,
	<aehkn@xenhub.one>, Petr Machata <petrm@nvidia.com>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: netconsole: selftests: Change the IP
 subnet
Date: Fri, 25 Oct 2024 19:01:59 +0200
In-Reply-To: <20241025161415.238215-1-leitao@debian.org>
Message-ID: <87ed44kt92.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7651f2c5-d896-405f-9040-08dcf51752d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PL15IYTKXOz8wJtE08G5vR8ofcVwfv+Dg8tXI+jEPd/i7BhAobUwbrhPqoO/?=
 =?us-ascii?Q?xrLyr+R+oFQazryn/hu+Ui/pkHgctENMZHF+3VwpAVcXS5vA1ScX1zDe695u?=
 =?us-ascii?Q?G0pcL3nAl73Jj1GyeHpHptCDguw5jODiGwt1yR+UDVUBgb39Pcmh3HEU3k1C?=
 =?us-ascii?Q?JcM6tjt95McQO82GgFEyeMnMvbHST5c6JL5ZDJRNJn3uVP8zPngxj5A96Bfl?=
 =?us-ascii?Q?L186cNFZ0fulFlnFUF+dOXQAwo0Qlq6vMr4hWgk32MyW3/55uUPccQyOn0lx?=
 =?us-ascii?Q?B3NKed2/RsC55flAWpVPc2m9qoGZ1TKrcJbTndInexTZbpY1vt+KnVr5Rt6B?=
 =?us-ascii?Q?2Y/O8VqG0R+LAaMkFm2cV7yU5dRXfoeivmvOIXuxSzCdYjpjPh60c0ine7jG?=
 =?us-ascii?Q?gezOeNWg0U2Wi/iBGa/ADvQoMfrAPiicbP8vTx/MKi3VZgLWIL5e0ikbtpFd?=
 =?us-ascii?Q?FueWdcUHIxBOzsqaZQvPClEEC1H5ywmq8tlGfwawiHTI2GslWAZXn80eEmRZ?=
 =?us-ascii?Q?51S2LYmVFJ23M0FQLsLDy5Lo2AQh3th0cdbjbYr6g37MSSaGEuT0HHuhab+L?=
 =?us-ascii?Q?R0QbJWbqggmlm+EN9kudSGNwrvySSN3jM0iF8wAkJ7Ymi9pMc23qPI7vNW9I?=
 =?us-ascii?Q?VksivMBPk+jiIMk8aHuE+dM5ItkM4EpiHWm79WjT4SUCr91MK9LJVVHRbw/g?=
 =?us-ascii?Q?LnoPH75q6ACV7dIHVol93ZylDcWeCYoFUj8B2CiPP/MSrWJQzWBtcAz0iSO8?=
 =?us-ascii?Q?hHDD8fnfjLUhStnuftWrfFeVfeWIeRWdYVZXEEFkopB/VeyXwHbEZ7TCJymk?=
 =?us-ascii?Q?N/jSeA8VirAZ/SN1umj5D415R4PUeXsFH4EnkDoZyxsm7BvlRfdhsoB88RMt?=
 =?us-ascii?Q?3owf2aK8N4MOoMJam3PMPuypR1hjXnzQ6wQrjzWWaoEj4yB315sZLh9RxvBt?=
 =?us-ascii?Q?X1SwVboLSFK+odTPt8QfuwcZOmyXr8ep0i8bgiVlKE6wXALVOOtVSyfo+Ii8?=
 =?us-ascii?Q?SO06IDqfEelaW9mNpP8KVwzd88Ohwa5jxwDD2PSwEgTNd7YxHG+XYA+Ay1oc?=
 =?us-ascii?Q?JUquoZIn7+2b87sG+k+a6TGeFbyN+3KTSEbADlB6K98mSczJ4vsTOmdkstd+?=
 =?us-ascii?Q?RINxbkWDyIikRqEuIDvXTo4JoA1fwIHGPg5hFL/VO5dIQgAL3XEyUhq6g9Jr?=
 =?us-ascii?Q?FaYhOMUbFsHkJ0C0sK6lvo5rnC85b2OY0KnSGGxNhVd71vf4UW/0ZqERhaCN?=
 =?us-ascii?Q?LB3dsRMdG4lAVJ4Fh53mnRmKv2FrnxbFdFq9+LzokQEMDA6n4Ia9TnV53uON?=
 =?us-ascii?Q?jBV9masKzfuKDtVyowABRmSdy/u6ARA6If6tEb7cygau6Z+4YGfdw7eaVY+r?=
 =?us-ascii?Q?HV55ByHwTud591uBi4/ouQ2meO7UYqb8WV4p3GcpdPOxZSTe1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:06:10.0869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7651f2c5-d896-405f-9040-08dcf51752d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519


Breno Leitao <leitao@debian.org> writes:

> Use a less populated IP range to run the tests, as suggested by Petr in
> Link: https://lore.kernel.org/netdev/87ikvukv3s.fsf@nvidia.com/.
>
> Suggested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/drivers/net/netcons_basic.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
> index 06021b2059b7..4ad1e216c6b0 100755
> --- a/tools/testing/selftests/drivers/net/netcons_basic.sh
> +++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
> @@ -20,9 +20,9 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
>  
>  # Simple script to test dynamic targets in netconsole
>  SRCIF="" # to be populated later
> -SRCIP=192.168.1.1
> +SRCIP=192.168.2.1

I mentioned 192.0.2.0/24, which we commonly use in selftests. The range
is meant for examples and documentation, which is not exactly selftests,
but feels like it's not bending the rules too far. And we shouldn't see
the range in the wild.

>  DSTIF="" # to be populated later
> -DSTIP=192.168.1.2
> +DSTIP=192.168.2.2
>  
>  PORT="6666"
>  MSG="netconsole selftest"


