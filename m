Return-Path: <linux-kselftest+bounces-17989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D0797919B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47297282FCD
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C819F1D0145;
	Sat, 14 Sep 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JqgaYIP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082861CF7AF;
	Sat, 14 Sep 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325465; cv=fail; b=Glwo6xmBLJwfTHLQLRIrrK6c2NGXaLTGE8C+/0DExccvcZWvt1t+86XWYZFIiw17neonZHf0E18z8IlI3hvsoJtaCShXihdF3MCs9TAfSRVCr5tWfPh6qCF+GSU7U12tfAMjf5ZDTT/Usgztjr4LjyXF2SG/cFjl6hF0i+2mii4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325465; c=relaxed/simple;
	bh=D+ISOAlDH9a5vWmSOq33hG/hB8muksFGz1qN7jFq4UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Shme11NANWqkrCCUgn+QD/ahNA5Kdiwy7sk0RVdsCIqzq0A3wSokXOVozRJdddJjeqPksOYYtTGZSkfmDXQQovXPzWCwcNOE57DwR0ltIo774w7DM5B2AeG5ttYDqpharlj/p25SjtteM4WvFkJa2ESjE5ojffw1AfpSdBn1Yl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JqgaYIP2; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw5YFl1EVvDG3mK9OqN9xX9whYtT4Auhw55O3l7egNLQnJ4Etzzirtqc7rQMEmIVTcP2KxhfIc2KlSkwxF4+f94mKo3ThZvtEFLLIkDPyZMKJDjEC30vwZSsl5J79Ixps/qRqABBgS8cbojFTarQCdWwn03ULLXZ9fK1z8vTS9bpLebQBoL8Q4wCBqhD+XwNiAe7JdrVHX9x0XeurfNjV2qEzAsHopjAdqWP6WV4v355cMXQwg+UCXwvWOLmLNOTQ+KOSIx3LftLu/GB+wSyOXC4nGNv8LUqRExOtJw+3aP3JQfVD0Ct/AYgP/tM1pSbqt+u5ZoRMavnGby1oveHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLfxQMQtcZzhPG7PeZ/zIQh1ojl3s8UAg71Xuj7hlV4=;
 b=nBFbBqDql/4s0hTNb6Vep8zeYYql4o+a5qz1+dys9FXGPaa3/Wl0beABJzGp8TegxkpO+F4AiXUFfYSkLe8Cz6iUdW2lrRXELRU7f1A51QqHvEdJTolv3c2FusEgo7Ic6uU+O8C3qyKLQokZJdvD44XWzH9oy1vjcVxuzpFgP8cizXn66cOjMnvlGuW1dBG4qUr++8fTGijgOJXW/YgUZpYnjIP+7dudjREwB+PaA2xFXYv8F+wYuUVkZDKnF4fAjwoanqupkYE19M7W/VF/Tfq8kcFQdNrug97aUphHxPmrMlVuu8fcPZldJepU56YQ5Ixa4sDpVLoO/tkGZ28M7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLfxQMQtcZzhPG7PeZ/zIQh1ojl3s8UAg71Xuj7hlV4=;
 b=JqgaYIP2JegHwM7NOoVjCukF1sBY2WKI8/SKWCVB8oSRXA60NNDfd61jwhGcgVSqX7JslRb/70rRnoLxtcb9he4UmFZLqmpzlFoG3HwFHOEzv4kdWJsxaPMvTKQdEBsjmqv4jkW60QWhM9mfbSgPGcTNOtsHyZSyNg5rr8cTDtkmiSIYMFThozNJL6eKgxRm0fOJnqHV7WqBR/SYKSYCL0GFfBHN+rf9paEtues4QRhJ92c4uAynZw5GIAi+89RvCVGA2xn9gfupS+OnAxjMgvkiEuYo0JToULVb/Uas+DTjCzJ8ErbqNPnvix5qQVTjYRuuhQi4IPMHO+Uzrnqx0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Sat, 14 Sep
 2024 14:50:58 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7962.022; Sat, 14 Sep 2024
 14:50:58 +0000
Date: Sat, 14 Sep 2024 11:50:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Message-ID: <20240914145057.GV58321@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com>
 <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
 <BN9PR11MB5276EBE0F714CF3EF0DAEDEC8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240911230735.GQ58321@nvidia.com>
 <BN9PR11MB5276D3685466B590F36318AA8C652@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D3685466B590F36318AA8C652@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:32b::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: e23718a4-47e7-4710-da3d-08dcd4cca4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tyTFvaOKOfLHx6iN4ejn6z0YZG8bEZLDzXFCzubjiNUgN5GBvT4q9Ryp6p2F?=
 =?us-ascii?Q?iGsZSoK0ErsorZsPRHuyMBrEP/GjpYUufU76LNibBXY3/mWQt7iiCDCYmjcO?=
 =?us-ascii?Q?xCKBfl+Dxc7Ej3HGrlNU1BspQcfpN3JZP1KnZ1YLdeqP4PqAf5v+KkJ+b/eI?=
 =?us-ascii?Q?49+mZRbOvweXHIG6enAnoLwDuCMgp3EHz0MRgDIg/eKi1LVed3ib+f0wa5tC?=
 =?us-ascii?Q?+BXAsVRVRM2vmMGcCGE9WaEsU7G+9826agIBXTJ1YZOShMvI2eJlIOSZ5z/+?=
 =?us-ascii?Q?6/xIBNgbzPy+njm2DaWks9UEjyiJ+ZxCiBg0duElY4It/wRtRPM4u1pyWapK?=
 =?us-ascii?Q?6cRn0t+J03TJAxKBk3h97EUfSSPbNrOeseiASY6mDfcGV+VMSWzx2o/3CMsB?=
 =?us-ascii?Q?wNQLfipvfJZPRlYJNJ1BTv1FG7M3HoSlWFbllnL+0VdTEIsxeUdgYL1Fi2tt?=
 =?us-ascii?Q?mcFeV9CRquQmhY4y3MVJb7E+gY23DnETBggzCqJVHikdJ5dWRhskIkExFzm6?=
 =?us-ascii?Q?f17FL1QFe5+6ct7QY8Kbs2coylPC/FV9ptxXBkMwSDRkEUjrMnnrFCkWNJDh?=
 =?us-ascii?Q?XyZE59AIcRs7cfLaM5/ONJOajoehDa86F0tMdhKSKZ9tK3iYF7/Ue3TGOWOj?=
 =?us-ascii?Q?xM/pLfoOJMXgA9310Fd73ghYprkO4hDlhMx97bbl9Iaxszw0QlwVowMoS4Ch?=
 =?us-ascii?Q?POwoBQMjSjwNVjq0u5oVTUwHFasTVjYA6fSxOu9v/rqlg7+8XINpNN3VHjvX?=
 =?us-ascii?Q?nLtVmMeYOgPrJyHZJY+1bXWaP8amuQTDGP1jrzSwvA4G8ox16FxfNUB+BUL5?=
 =?us-ascii?Q?IfKHsBsgczqXSqMwch+5apbQ8LC2OoT+S6G5RmlZFPDkZklyvfDnzsiZQbar?=
 =?us-ascii?Q?Az1p5w7xmEXCYj1wEjSMUmP6vOioNz70QXhfguTDxcCalYBRBJWn63zrpNGK?=
 =?us-ascii?Q?0KmGPe6qsW23JxNCmA96ItRjoJsUQPygDOawsMn1IiLiCUB/xrrudfvgq/YX?=
 =?us-ascii?Q?RFtXZil4REnuCtJuewTdZYyFnIuPRMezyfcdvp2ObFSF3tHtwTOUIk/Jvvii?=
 =?us-ascii?Q?nngJsK1tL29wKSt76xPBk/BrgMNZSdU4kk36H9+E98i+rUDGnqMMANunndgs?=
 =?us-ascii?Q?5zeU1S19RMA7kzrySuIrP3c9bXDhnQC6oSKc0YUPBoOPRKj8kZ5HPGiTlo2H?=
 =?us-ascii?Q?B/LF0In1K3/TejfMsbHOhkYY9Rd1ENl9Une9oGJ2oFvavE6fMZVN4NOGfPnn?=
 =?us-ascii?Q?NtULS2A4M+BYT2Hr2AxM7i23RXr92OG6tbRIp1iEL6YzhcnWC0o2H/j9rAVs?=
 =?us-ascii?Q?lmJfVcO77zW89ltrs6RqW7p4xEPLO3OpXD4aMRfd9QQ/Ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nkhvv5rq6HM5wBXEXNBiS/p6U73Pc/4IWH5OExRnGM+SEZD7rpfzSMoD2GbT?=
 =?us-ascii?Q?obCbZstPiqaNFk4adwTw9ZF/nhgRfO4kCiS3t4hK9mKc1VSoDjaKjKKfwzJ/?=
 =?us-ascii?Q?nIBkqyXzqIjAqGtSghrP6eokXC+zvygf104/xpbUeYSCMNurv5dDM/QFYPC3?=
 =?us-ascii?Q?bt/pRp7zcJK4hK99msN9K2NzidtEEo4t+RiH5GNGvW4Aw3TNqLOfDwDPye9E?=
 =?us-ascii?Q?7rtkpigWTR8bwGcA7Phm6DyLiXCOIQ1kx3Fmp/S+j1ZYcJvGtlRID6M82QBk?=
 =?us-ascii?Q?pTctbuhh8igVwTCqYvxRWEgHWvgRD0MkYWWNMqOVpmTHGeLV/cngm2ru//a7?=
 =?us-ascii?Q?zeKGldjkgIif+tiADklCF6oTD5tsDVzZoqU4vDUMtSnKxO7xG9kOYgyhN2sZ?=
 =?us-ascii?Q?DKE4yt9FpZYedonOUBhoQOOTPWBW/6pIhVISBCiPm7fnfr0tJyweIZQOn0XF?=
 =?us-ascii?Q?VLb5NtZoZy2KrE1r6xluqWY07236bYpu9+Nl9LdxoYzuXaZmTNrnXuXYxrTZ?=
 =?us-ascii?Q?cFCk+aayQ72gIn6qrL6CBxmGlgI303tkn7ht+/JhuMrE7+j5z1flw7foq+iA?=
 =?us-ascii?Q?g4CxqlDmfi9AhwPQLQXEj1JuQH8EY28Muhu1wQ7vyvdDnLG0hMLzX18CybL3?=
 =?us-ascii?Q?zoU8wsfb+X+I/4pKGu5QDgpZIp9wbXnUsUboKtCLxoIEgENvBm1SwCr49jP5?=
 =?us-ascii?Q?w4q2ARVaeprZChTECz0q/49USwG3OiyAfEbiZOVtbE8TTb5N6E+qqXodhdQ1?=
 =?us-ascii?Q?fp+5ffaZYkIAmwzsJvjvmQL7lJBw95ZdR6EhHA7hHtDmwjx5E1K75UO9howG?=
 =?us-ascii?Q?ziBcCM3fXhUvY0X/9fAZrWCZXqN14CGBOxF3AclDWZA28UZkczc45Knm2uvS?=
 =?us-ascii?Q?+SazXrnWubn8wpunYqbtOsByuYXtpXMBgg3IT/dyik3lFY6AiYt+QKmFbSs5?=
 =?us-ascii?Q?o5xNjMt4EMXLQh0UpCceJhmLX+rXaiBYX4P2ypBvDAEn0PoHuog6qLvWbJLQ?=
 =?us-ascii?Q?mH0W6xf5jf1f8VOoYPLA1AxScFSeu6V4CkZjAW5b5PbLXY5Cbq78Vwol7ssj?=
 =?us-ascii?Q?rHNSzRkIApeSjYzW0NaKZNnE8Wn++AZ00CVy6+TkQlV4WtUm25sWKX+LtNi2?=
 =?us-ascii?Q?nVrNKp2AnotAMncJ72yTWUyuW7eZ9Ogg+3A7C+UlBMCh2XsCto+BY8pZiqKQ?=
 =?us-ascii?Q?qSPIVj6LFnn2E3Bby+EFcXtI0gwbPT1BeUy0czNmoXjeKpY+Xlhu8PIt2BZs?=
 =?us-ascii?Q?nCjcC2rtiY6vhJvSZPjTDC01FJl0NbtNGZ/6/6IncOtxZh92Yk8kzwDTRUjJ?=
 =?us-ascii?Q?/ApnNg9gR/MLt8qKh+2M8Au70697+CJKU7zcZJaGRUJ+2A2gdHmi5pZ6fOMY?=
 =?us-ascii?Q?W+ul8ctrkoHF7qpHOUxHXabQBht6AfSvfPIavmTJWJqqiRiIZOKSuyw2SKVT?=
 =?us-ascii?Q?lO9/Y0u4/oPP4rEeQNVtPMlBVYs7KKCw0vISjhudM3OKoYAdSrM1VCNxP+Wb?=
 =?us-ascii?Q?9WOr+W1+WW7vUg/fTFUWeasHHTv/+F5ARINyb9Ox1V35jbIyWl9G/KpCH4fA?=
 =?us-ascii?Q?apWf1WSdcisjbI+joGw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23718a4-47e7-4710-da3d-08dcd4cca4ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 14:50:58.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O16BVguTHnA360YogWZ1RF2/14MqGf6rC1flawGl6vCfingYQfFSUtcEcdmCX4+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

On Fri, Sep 13, 2024 at 02:33:59AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 12, 2024 7:08 AM
> > 
> > On Wed, Sep 11, 2024 at 08:13:01AM +0000, Tian, Kevin wrote:
> > 
> > > Probably there is a good reason e.g. for simplification or better
> > > aligned with hw accel stuff. But it's not explained clearly so far.
> > 
> > Probably the most concrete thing is if you have a direct assignment
> > invalidation queue (ie DMA'd directly by HW) then it only applies to a
> > single pIOMMU and invalidation commands placed there are unavoidably
> > limited in scope.
> > 
> > This creates a representation problem, if we have a vIOMMU that spans
> > many pIOMMUs but invalidations do some subset how to do we model
> > that. Just saying the vIOMMU is linked to the pIOMMU solves this
> > nicely.
> > 
> 
> yes that is a good reason.
> 
> btw do we expect the VMM to try-and-fail when deciding whether a
> new vIOMMU object is required when creating a new vdev?

I think there was some suggestion the getinfo could return this, but
also I think qemu needs to have a command line that matches physical
so maybe it needs some sysfs?

Jason

