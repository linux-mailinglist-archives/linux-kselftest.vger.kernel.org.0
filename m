Return-Path: <linux-kselftest+bounces-27044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945ACA3D1ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 08:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4673BE6C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 07:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951E11E9B07;
	Thu, 20 Feb 2025 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J3mG4KrV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A81E98F9;
	Thu, 20 Feb 2025 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035597; cv=fail; b=ZcTBzBmtzu0jT7zPQ+cx5u4e6syqCsBAsn7NCizEvtdWvBhU7zFau3gX2qvWcrpk9QaXopE3QMEfJDZBX+qc1ZXB0OJjdJc2s4H6bcnvWo3WG1lVVlphM1/dizvyaYTWurrzJN5CxkrtjbMNV59qik/VHWn0EFYP18lDJpFgdIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035597; c=relaxed/simple;
	bh=lN2KkDCbVWYS3MtyBC95rm6eIta+GSq2qfH2+HUZAI8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRkuQG1D6J4lof23lStYR+eAN9pLBjOhhAjYJT86t4rAGxuiEPQD31sLvu1UWCGxztfK9RXaicl0LJ4KB6e2GU2dYYa8iGsE3FgaCuzk7W/GuH3gCxr9b4Jhf1qaQlY4NUhsatZJEDGygbpCrb8bs1+5JF+Rzcu8NVI+FN2rFLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J3mG4KrV; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OupMGrvggHDBQxDH6HE6PQ8tWW3zUyRiTfb5D/GfQBBjE64omFeFjMWHbNTwCr7Sxp0CIc0Ry09JZ2g4yelbDWctUtu2nQYghVFbTZop58NoeX0HegKlMnwX1/4HgmcBumjRfShcR1DPkuv9prQtURqHpxMxs7Dx7u3TkIH61gkcgEyUobdp68ydCA79T9lUITJx3VfE2lNJ8AE2eNZx+gD6aXvdW8FjxRgPmfFmoGkoF8eOoEcSkPTOpN0roiWSKSzTopffxqoiYiI+r+0212PIY5vVyj4KsA5fBjbUH2dPXlGTQ1Ccc51qCTCh/wj1H7lrAm4aVwxyOlTDYYJe0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yxK95LnRbROa6bs/D1NakOTn74GT6H8mhuoPMhcoHs=;
 b=vNQrd3KUmg/bAhv0ZnBG5rATEiyFKnJlwfa4ixvGOgsuiZcp2xUCtBe+mMS22s9pB1OzfVuBGsJExKglxdYJsBlytqY6TKqzGheOwsQnx6fqaoFGy+6bnCesckA8YnhBFgYy0q2Z+vokLFyVYdYYcx2Psceatf+d9uqu1gP7GrNbRoxEy5fYsAV/jaQtZ5O3Ma+HRrkMip2nDG3kYQuIr5y4aJbItCqLmvPTjwqPqJ4Dz3yLSgPzPsHaoMbFSgMlW8uBH+6GmyjHQwx6TWWj5wkeL8WvZGJiCqXysydjh/O5yYu/MLI+bJd085wfUYQZps1qukv5NqEgFL7l/gWi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yxK95LnRbROa6bs/D1NakOTn74GT6H8mhuoPMhcoHs=;
 b=J3mG4KrV95dXB5pbbZe2ooZzS3Xa/2bjqhk3asyb5QqEI4CHMfjxxJNQBIsoy/td1DmtOSDCuLi8Ln2w8aC4ujdhNl1Ux8NQaSpf0bSvRA4ClMSgXPaRPKYJ8RMfA8xz0aBYdvwFH/AOFatyCHlWPMVUooG3s7R2mdSjkI5/r/Th0bqyrGrvrAxKz3qANcbOlK7qIZlsL6/1bLS7UHQ5z98td7N/5HLRJug6tZNxCv+yAOKMA/kVRQrtqHnl8DV2xMZLgRd2T8HpFFluQqNqY1LrxcZ1is8RRJFKZFps5HISwm5OyqTe/bnjDC1RBmQivTSiPsVhqE2rNGnsgVrc4A==
Received: from SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 07:13:09 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::4a) by SJ0PR03CA0250.outlook.office365.com
 (2603:10b6:a03:3a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 07:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 07:13:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 23:12:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 23:12:53 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 23:12:51 -0800
Date: Wed, 19 Feb 2025 23:12:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7bV8q8h5ssgiucv@Asurada-Nvidia>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
 <BN9PR11MB5276291C74E2DF0C8821BE718CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z7TOq-gIGPY_ztW7@google.com>
 <20250218185229.GL4099685@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218185229.GL4099685@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: d04b840c-62e6-42f8-3303-08dd517e07b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5758ZJEftm8fwVsfK1Gn2dnNq/fSlRW8zzQSxQ7HOP0txiw23IyaVbYlLit4?=
 =?us-ascii?Q?g6bH+G3k0r/O+PKiqJFelUx3PH0v1FWOTTsnbLBO1Ulu/YoGQ0L3owozGyBm?=
 =?us-ascii?Q?JSPiH/ePqSo9FrdGjolvPiOVibXbSwPTA34ZyOtQMtIFBOkTa3+TpchZX6Cq?=
 =?us-ascii?Q?k0SNqRRGdij8aPjKt1xEAiw/2cdxo38u4NKuFNmPMUVddFFDurIZcuAnMsXN?=
 =?us-ascii?Q?N2PAKW325NngwrOXlOYoDl6S3x5UYOCxBp1s+3hdGumUxwHconT5IsFmQfdy?=
 =?us-ascii?Q?N4IT8yJLTzPg/ux+fzR9LFnPlabmC3pgE1xGvkbj/VRxeXVMIJAfFrKX5Yro?=
 =?us-ascii?Q?upsL0QUXZncgzp/SvyWe80EL++Csd9v/VoHRfNgctZt17YvOKtmAOHJ+pKRG?=
 =?us-ascii?Q?MuMLMXT7Zv5uf/eQZkwIapbbTyzFJud6duhcqE7cDvMGB3ob1NXPPi5xx+WS?=
 =?us-ascii?Q?OXKJIo+dEDqbx8wM//cWtQwYf8RjLa2MOXigcOPAScHK26AXYMoJ04wyOJjQ?=
 =?us-ascii?Q?NctMMMLdkhVm3nDYSnK3Hc5p842EaAkf83B1pGm4B54JiMb9q5FPRc8Kqyqw?=
 =?us-ascii?Q?jg6RXeLS04cS03R9VSeclKDo+nkh6IUAlvUCaGoARI+AsZ/43oweaBymntLc?=
 =?us-ascii?Q?D3I1LgCumEI1sJjoNe285DUeolQGWX+xzslUqzU20s/U80ctzflcUV6dHEKm?=
 =?us-ascii?Q?nB4OaSwrkzl0x34eO9tTF+f8Tia9JE+pNT9a8VG4VUCDC8VtF+8THz/ql8LR?=
 =?us-ascii?Q?oSKJsGAo7FdxjQSe9CRnyNNQro8r/WkFoOu1/1Tz64vlgGfdAoaN362e7bYi?=
 =?us-ascii?Q?XHnJthapHvoRsId2VMk3guL/j2t7NESWNARB1wiZBkuCjVHG71CO3rUeYQWW?=
 =?us-ascii?Q?ER/l1tHykYwDPrEb2RSN68ferelqiKWEJfeKDLtTkTpU3yjVcRDXuKk2TjdI?=
 =?us-ascii?Q?+SflfPkumaTpRYmhWaod94l7Q3wcHcKRisuf9tS0TxO4+yoC7ps/CAJ+B5TU?=
 =?us-ascii?Q?dr2dWsBwZNxaw+yeM4M+jX5/MPoIze+3/wMFx1KawwwO4xtPN6ze8hHE0Lq8?=
 =?us-ascii?Q?PJ8SxDA6jHmqKRBfvSsdqiH528NQ5wdgLiNZY1y7QxSNt5uhYxUu8wgNjsw1?=
 =?us-ascii?Q?t5GtLpTdKPedI25PjzxvqNitOBzBsdzBBFG4x4RPuSnLrGBpv6jtop08bdNA?=
 =?us-ascii?Q?1jQQyrO0UrQzCzHuKr/65Necy5vdxBaUU5nbZtq8EXe2Cn1HFfcftxuHCsRg?=
 =?us-ascii?Q?H5lbQ/wGTnAs3nx0Q5sDFY+Bn+ShX5X12ZzSDrUxpUX4qlZx28/HFWYvHlSS?=
 =?us-ascii?Q?eZv3uU3aoFZO9Wv76uBat/8Z7q8bEYLx/LyJpASYtEvmgsZzx1w3R/shMbjP?=
 =?us-ascii?Q?53bMr+e2Br9vrJPPO+scX+OpUzeItOxFnRwG63RsfAbrIDZw8iN8w/7b8Jka?=
 =?us-ascii?Q?LBmD5fdq0lBsD5dHZjcrzLQXGYyvubJi7yybc7MBMAGTc6kThrVCaEQ6jVig?=
 =?us-ascii?Q?8P1orpTAJ0ez6QE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 07:13:09.2182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d04b840c-62e6-42f8-3303-08dd517e07b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537

On Tue, Feb 18, 2025 at 02:52:29PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2025 at 06:17:15PM +0000, Pranjal Shrivastava wrote:
> 
> > > Is MEV available only in nested mode? Otherwise it perhaps makes
> > > sense to turn it on in all configurations in IOMMUFD paths...
> > 
> > I think the arm-smmu-v3's iommufd implementation only supports nested
> > which could be the reason.
> 
> I think starting with MEV in this limited case is reasonable.
> 
> I agree it makes sense to always turn it on from a production
> perspective..

Then, I will just add a line to the commit log:
"In the future, we might want to enable the MEV for non-nested cases too
 such as domain->type == IOMMU_DOMAIN_UNMANAGED or even IOMMU_DOMAIN_DMA."

Thanks
Nicolin

