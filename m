Return-Path: <linux-kselftest+bounces-34833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D1AD796D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 19:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DEB188E934
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02329A9CB;
	Thu, 12 Jun 2025 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KRplw1eL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D317AE1D;
	Thu, 12 Jun 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750837; cv=fail; b=gsSpPKMwxLe7VVz6YTALsPQbBxrmhMseyyL3eqYsnlnUvgYBuQ0NemIbBmWnM0pzoPxb+QycW5gEkgHVOK0kCSGUQu9OBds7HCo2UBgcMBQjCPkON7tEw3gy4n0/rbksoXw6xac9/8jj+2tiDfVW39sW1u41p0HtpQPGW0PT4rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750837; c=relaxed/simple;
	bh=A9v2XbJXcQ0qhi38p6taiVIIbn1P1+IuNRbUo8xaEr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl4OIocWl4up9mzqQqunY96KchadCGBzoOM1D8ATAX90Gk/DcTwdq/Ixfq2yPCeYe39b+r2R0g+5zCFwjvyS2HULtf8r+aadZ70Rq+nF12WW9nlDCYA0GrhAa0fDO2tFrWp7c+S0HOZpkT8Y7BftOvkEFJ4jrugERtuU3fx6x18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KRplw1eL reason="signature verification failed"; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMp6VvmFy1Jc7LJwfp3jCAhC8zsOmmBESCYUZtlBr52jyu08BZN3KlJ6DAKJDu6cswVyQZFfsVbjhGirKzwZ6QZsgfpGn8qidUgj5cTnRT8f/UKS0IG+Ebu4mt7HkT0Rxyawfa4PROnanj4yl2EDvEmmea9KJmZgIDClOrHt1a9WOmhiAnGRfDl69tOmPmRs3we4UFARU0Cb8IKHLM59bEBrhSpCX087k6db0DD6fUc7LC0J6nAtf9GkMmeZD85YB1tcq91DS6Ab/TAgDLYLWPLMDmZmnAytsBXwl+DX+wzsEenXsr+c/+uMx+xdpvSbseKCTTuHRg2Pn+A+9jHOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1rGNhnJPCxN7is7lvv6LVRQ/pw1+V5+CHJGIBD5veQ=;
 b=tVVXKNYVEHfvnhcusO2BNB5+/CNsaAZX9gr11jgdwFBYIcOc+s3aQV+VWzYBGmb82NP+/cqI+8wM3DPMXHPctVx+29cWoP5UQJbf/RLBMB37tUeolZPA7q73+/pDeCsw4JBbj1aXxG05WdsOWzxkPAmRdK+mpuRzpuf6HwN0BrNd1TVKX9pSjm7jG2vJGqqRQvotmkVJv+tGxauOX0plctoKMClcSleX2chl2T612jgd0fzwhSleGQaaxUSYXsXyPSRgDC8tv8SOiC8xzl+dTCG8DGg0WTEzJ+k8BItqESLK996keRWCn3xfQJG9FkE2Ylsb0LOmYoNc4xawVAHQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1rGNhnJPCxN7is7lvv6LVRQ/pw1+V5+CHJGIBD5veQ=;
 b=KRplw1eLkAxXWnaohYnN7c8ZoLKPuB4nj8ikrpc3HwP4UAtb+6PkKTkl3TqW+E1xN6j6YJ828JpoobPb1FEQG8Mx+AVuc6IQhw+NbdB9J3UhgJfyazQLKR3sJrE6qBJm53S0+rdEIpooA75ifN8lDEa4p6wlO/K/k3c3+LN08qXoXZ87dLcXrFUMN6GOVsEz12pF8D+pL2QZ03dvJXGS0uq8tPIOwg4cmwQqWdCrK+7ZyW7t27uAMqQPv/BmCf4GSZhpgAM8EKEUTsjGnhI/gShf2hATPt0tjPLrrZsgZXBFuuZDIy7Fxgobo2Z3RPJUkBMmXDmY2XEAW9fk8AG2hA==
Received: from BYAPR21CA0018.namprd21.prod.outlook.com (2603:10b6:a03:114::28)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 17:53:50 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::31) by BYAPR21CA0018.outlook.office365.com
 (2603:10b6:a03:114::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.16 via Frontend Transport; Thu,
 12 Jun 2025 17:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 17:53:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 10:53:34 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 10:53:33 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 12 Jun 2025 10:53:30 -0700
Date: Thu, 12 Jun 2025 10:53:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, "Willy
 Tarreau" <w@1wt.eu>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown
	<broonie@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <aEsUGP8xPTDjG0ob@nvidia.com>
References: <aEm6tuzy7WK12sMh@nvidia.com>
 <aEn5jmXZbC5hARGv@nvidia.com>
 <aEoUhPYIAizTLADq@nvidia.com>
 <20250611235117.GR543171@nvidia.com>
 <aEp6tGUEFCQz1prh@nvidia.com>
 <20250612135802.GU543171@nvidia.com>
 <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
 <20250612145801.GV543171@nvidia.com>
 <20250612171437-450fb7d6-c73a-47e3-9e1c-5c009cba7fe1@linutronix.de>
 <20250612154242.GW543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612154242.GW543171@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c780f1-c9af-4e19-8139-08dda9da16c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?gr2NQMGTXoHDE0K17tVCfGHr92XR8UGFg6U/REVl9IWNeA7gOy24mwY3Ww?=
 =?iso-8859-1?Q?YTJKedvDPmMcjQKaQXx1+bVbUz+ZrK/3DCd43Vq5j0VaL9Ss1/hKoHb7pZ?=
 =?iso-8859-1?Q?3swq95z6U6s+apULGLjcbYQyZjR8pXbrYv8GyTzEBNIx2qya0P+NoXyIUC?=
 =?iso-8859-1?Q?dqOTEhVF3xOFf2yTBj/7z8SbnM+2Uj6TDTeQSBRwEae3O32/VDf16zdlOV?=
 =?iso-8859-1?Q?kPk+n7eiizEjRFIGX3wLH2JvL80FCmLYW7L9BLo1bzIgxIVkQ4iWxwK14X?=
 =?iso-8859-1?Q?W22ILhE/AepWNEQERywoFqCPWQpvR3GOWBUkK8EwUPtyjoL6m3aikPZbHF?=
 =?iso-8859-1?Q?qvvNlopm6qq8MkGveYV49g5EoHgPPaDI20rxzdAFSsZ9o9ykoGvjXXNSMJ?=
 =?iso-8859-1?Q?QKdeM3RxuwFhmVdxKfclHAXfggPLjgiKPYct7E4xFjtgBUxlI2+OaFDjf1?=
 =?iso-8859-1?Q?JXnAHGHucyEsZwmmuYIkadQCF4vTC2MUYrJVKcHQviUgtpS8k3ZCeUcRdz?=
 =?iso-8859-1?Q?tKg3JKpbKFyKx/fVuZiJy+H97YRw33NRjOzLBmTq3ZTtDKbAg0Bm6SQNRR?=
 =?iso-8859-1?Q?lYpPaMDlU2wgQFdQv5Liwtrx4xfwpXkhkVY+f70QlFSQChsJFuKgPJX2hP?=
 =?iso-8859-1?Q?lVBI0hRDeD9nQXcDRyhT1yqLBB5foZixeeNxfrzEL/9ZDo292NUusuyZv4?=
 =?iso-8859-1?Q?/pDxc7GySc27KlQG0gwUrwTVRHLRpcUtqT4YNKeWramE73+UkbF2pYBine?=
 =?iso-8859-1?Q?WhWc8weqRWyIO2I0N7orMBwb0JJ2008MNtdJJQNqFXbjSdzgSBVfsK8234?=
 =?iso-8859-1?Q?4jEyu/L7GAE6YTmnI3FV3HQz+aBDP1Pdp2zb2PtKXd6z4WlMUQGraHR/g5?=
 =?iso-8859-1?Q?i5YpwGN5e/j+oZJcmZkxKXxJn1hGDWF6PMQui8HcpDWhsdJe/DJxD0pTMK?=
 =?iso-8859-1?Q?odSG34wVvWZJ60gNm2mHn6iFkRPXwM7+O9nUynL+jsKujqgk+N05//uVu+?=
 =?iso-8859-1?Q?UL4VMqZbg3PaRlv3FtmSqbvSRq/XV3wIzweKXxfTiwCiKjsGMfDYjUI0sr?=
 =?iso-8859-1?Q?zgLx0aXqhETpK/g4hZCRMKVmscdRCkqXRNwN82PinaGeiz//WWhjhoTTgu?=
 =?iso-8859-1?Q?EkSyWYSdGnhijRLbSWLVLgPfiEwfeMx97VY5m+GaJii4D+xz7bglOCvvkL?=
 =?iso-8859-1?Q?flnIH73o9Ow6PHNRQ5tWl+WG7t2qLZCLf6X+qLsxJGEPU8EIfjY7TfhKwU?=
 =?iso-8859-1?Q?qyqQgk+VlZVk0HltjWTIcSmdUOetiPNmdH0kPgXOpAU5yyII9EKK3FryaW?=
 =?iso-8859-1?Q?n3Y0yjXwiiruDkgPMEn9Cot7vLRNcakRZsdYeQDw4lKGGIAtmn9o0bWf4F?=
 =?iso-8859-1?Q?xybLmYlWhCpHOmhrrHdVpWagJvSdmziBA33ZQK+FBeiyaRSKr9lD/0twFJ?=
 =?iso-8859-1?Q?5xmdVhKj60SLo3j/AyHuIHwCYeY9XSEoryB8rkjv5uBti0s0fD6+5pV4Il?=
 =?iso-8859-1?Q?aOARE7ZC2nLFpqKJPmqehpSzG0t7ZyVL2xG3biGaJWxIFAB4yBEqKX2ihv?=
 =?iso-8859-1?Q?0uiKuDMbthpG/haF9eT7wEuZLCEZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 17:53:50.5980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c780f1-c9af-4e19-8139-08dda9da16c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462

On Thu, Jun 12, 2025 at 12:42:42PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 12, 2025 at 05:23:01PM +0200, Thomas Weißschuh wrote:
> > On Thu, Jun 12, 2025 at 11:58:01AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jun 12, 2025 at 04:27:41PM +0200, Thomas Weißschuh wrote:
> > > 
> > > > If the assumption is that this is most likely a kernel bug,
> > > > shouldn't it be fixed properly rather than worked around?
> > > > After all the job of a selftest is to detect bugs to be fixed.
> > > 
> > > I investigated the history for a bit and it seems likely we cannot
> > > change the kernel here. Call it an undocumented "feature".
> > 
> > I looked a bit and it seems to be mentioned in mmap(2):
> > 
> > 	For mmap(), offset must be a multiple of the underlying huge page size.
> > 	The system automatically aligns length to be a multiple of the underlying huge page size.
> 
> Oh there you go then :) Horrible design. No way for userspace to know
> what the rounded up length actually was and thus no way for
> userspace to unmap it.

OK. I think we would have to skip those cases then.

> > > MAP_HUGETLBFS rounds up the length to some value, userspace has to
> > > figure that out and not pass incorrect lengths.  The selftest is doing
> > > that wrong.
> > 
> > The selftest would be more robust if MAP_FIXED is replaced by
> > MAP_FIXED_NOREPLACE. Even with the new explicit skip logic it should
> > make debugging easier if something goes wrong.
> 
> The point is to replace something that is already mapped there, though
> I no longer remember why it is working like this.

By replacing MAP_FIXED with MAP_FIXED_NOREPLACE, at the existing
two places, the selftest crashed at early setup_sizes...:

iommufd: iommufd.c:53: setup_sizes: Assertion `vrc == buffer' failed.
/nicolinc/iommufd_selftest.sh: line 19: 21487 Aborted
		(core dumped) tools/testing/selftests/iommu/iommufd
strace:
mmap(0xffff80000000, 1048576, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0) = -1 EEXIST (File exists)

This one doesn't MAP_HUGETLBFS btw...

Thanks
Nicolin

