Return-Path: <linux-kselftest+bounces-35786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3CAE8A08
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1945A6344
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CD02D12ED;
	Wed, 25 Jun 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aKZhS38X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA451B042E;
	Wed, 25 Jun 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869469; cv=fail; b=RGlNlI/fBLaq9475RFzhZkIG2fYj9tyW3rqejGyReqoGwjGZ8E31RDjwxYfjYYuxX53AXkghWnC6n+CMZyEggd2s6m5gHUtn4Aha7RyCOKRaTq8pX5UlwajlOM8M5OVWuloBZ9Ji9oRG8c6E5VkO3eAD9q6SEhYsElB2FXDgl/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869469; c=relaxed/simple;
	bh=lkqIu0r73iSw3SQbTtDPSwYMeK12QzVEy+bSuOUDxOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEU4U2BMQPRl6I6NDLxqRpgbWU4/AaDu9rw+I5tNtiy8qaq6BCuJc437DgxX1EvnOiSV/oD3nyA5hEorNSRbMpsvnyJmNK90h7hSMZQ3uTEXzUk9+67PB1UACM1jfhV9HjW/WuGZQ5BXnTXqj9Znyq0yX0Wy+ts8zetS3en0Ys8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aKZhS38X; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKsYDRCO9bLzG2z5QeZIw3QrrDrkyWGDtYiY37bbToZP9fybdhcP3vxk/uaYXxvQl2Vv6o94j7yNBa/DfTH/GoWJQtQj67wfR9J1akulYuha91THc7SvC6hugzs80KR/uvI7urG6PXgYE23U0Lc1Z6Tye7srUUMCvm3vkEK1X1L0ARg1OJpWPVi4/LW1F9aO8/r3Qfuj1SHZN8WeCV654IquzI9Eh5HBHDk9iUIo8Jvjb+vxA7scrrqOSqQ+ognadHmpJ2Yzti9tliKdTcWfvuxsxPqT/cgKyr9nGmRtujYcZClzwMtTu4CdFN2U1anDU/NnNdtlBdes+Et8cwU1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FRdDfW53Pgtbfa+hoVwW0XlohWae4tQ9e4EtEpfn1g=;
 b=QNSp4ZKuWUdOVbY3k4p6qrsNMAocewgstX6Gla2Hfna2oVrie71vuz2+32tyK3YnjijhBNFGwJZdap8YpN9dkmjsykwmb3chktYFm9KaHPksnLz+y7oPR3lciQ210tqXmtk5Jmv4zadt9ugeXQbs+wTcG+mNdM11sy71i+DVxm5jD4ERu320l1ivkOEtEapmG6pVHF+V9AtI0L1tie26yKQJjUvFhS2VK2/RkFw9ra1XV8r85iP1jmFtOtfzg1SsZVegldPdRq8VDpfZ/Xl4cQqBX+Dpys1aOivVtHdcuXPHowpR7fLUlFYXxlHE91w7HAoLGpEIHDvTqgS59zLV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FRdDfW53Pgtbfa+hoVwW0XlohWae4tQ9e4EtEpfn1g=;
 b=aKZhS38Xs2i7TB5xikyrmYnSJ4YK3B5/KhWLz81GQZ7gTo0j1lkH1OdI35TOHKqP1vcPpW94XRqH93N/pL8IeTrvL0ot9F1UKTTr3QnMFStiNhrg185/Vlb4eQYpd7Zjq02rmQzeWsDfaA2xknhU01sC//J7UYodJEOfHoZPOumwbyC9kmYNy7Qa1pMh2TyKubq7YTY/xz518wkvO8J4NWqi1N+1tdQYBPcqYNJMyrvZ0W2Moa+e8/zWiDxsUHnYUy48rI1+ebSHDuu3vPHqP4zmuzrBuxv9edMmDpsqjBFuBRMh832YDTbffycsVaErPfyB39rrUmdItRbcSC6E4Q==
Received: from BN1PR14CA0020.namprd14.prod.outlook.com (2603:10b6:408:e3::25)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Wed, 25 Jun
 2025 16:37:42 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::d) by BN1PR14CA0020.outlook.office365.com
 (2603:10b6:408:e3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Wed,
 25 Jun 2025 16:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 16:37:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 09:37:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 09:37:18 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 25 Jun 2025 09:37:16 -0700
Date: Wed, 25 Jun 2025 09:37:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL
 for internal use
Message-ID: <aFwlu7FlfIP85gko@Asurada-Nvidia>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
 <BN9PR11MB52766D0C0B12F1F10A6BE7548C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52766D0C0B12F1F10A6BE7548C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eefc242-9aff-4b28-deec-08ddb40699fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zBMI1Yx5F8fjJKh8M2EynXwgt9uMyjR9J03J5MlRJX7doRRRownlvueoXFDm?=
 =?us-ascii?Q?doANt+Qn4VabCqt7kBwBjFhFtM2cJ6qZ5BjwLzYJwmoeywanXf1uNRpGWS9+?=
 =?us-ascii?Q?fjyEyTO8b3k/rPwtRqyQXG3Qrvtk0oDn/HGMSYO5kdFIIRYlH9yhwvWWHLRX?=
 =?us-ascii?Q?2MFgi+jZMovnIItx960h9cPnOm/qXyrX52A91WWtNuljUNjA7kX8uHNrHCPp?=
 =?us-ascii?Q?bmxGuqpUaCOQ80geMlHeVM7cIkD1GQkY2AT1PnsRolhFWnhPCHEjBa8fnKgx?=
 =?us-ascii?Q?zJD+HSN9idjS+MmCTAus5zy7VUVDl5x+7kHSVWQKE+wAM0At7YyhzLhYYwpG?=
 =?us-ascii?Q?Fl8LCvmwk29w/5Efe+bjuJu9g3Z6HnIoJjFquyYFZWq72PML/3NZdmybeaLh?=
 =?us-ascii?Q?pzn3gv8bSYQqnjwbilPcRO0098c9B6Z685h6go6hGSYnlisILk0lo1LQRaJ6?=
 =?us-ascii?Q?Wf7CiR9x3y8wqEpGOVpbFuAKGY2MvPuMQaC1o4pDXXQ+tHqlPGnIr8waMqpp?=
 =?us-ascii?Q?ndWwE3r4itxWVoZitWVzYS2rL/sZ6XJZ45aAp4nHm/Iqky60RdzhB6qKxul+?=
 =?us-ascii?Q?+1inMxecXRrAzDOsOf230oDsCqyIP72ViBamEBY4OGcmscLasqRVni4tMULJ?=
 =?us-ascii?Q?Hqqu+jkQDQfH5T7GjN442W/4hFVLIsDOdGlFjOw3poz/+FOq9ir+4hz/xU7n?=
 =?us-ascii?Q?yd/vcAgb/dEAuKeRiW6TXyPBNCbr155UBOL1vDf6lXGnmJ8ssML+DJt+CDiD?=
 =?us-ascii?Q?CR+wMnqtbuX1lzZyYKZGpp9w5EeLP3cz1pJBytOCoZ3wS2L3dYFeXwlS3UmY?=
 =?us-ascii?Q?NwqjZciCW0OJF4oMxvsq2AxKuiaJUkysv9hBCdeAWdD5GAtvMuJewqZ3YITJ?=
 =?us-ascii?Q?kVsPZ8OkIvq6uUA+4Kt4vbojS9ureLHmdIvTKQJ+iwZvmdbBbH9lcrmqFU88?=
 =?us-ascii?Q?nW9kwmulFn+HWFdm2ppN4NQ4X4HTeAM6pxggffOUajlGkVt7BtriKwx6ZY/B?=
 =?us-ascii?Q?+vpAV6hNeX8eeFh45K/mYF80sGkbQovWLWqQ6sJaOSW78PRsOL3n+WnzU3a5?=
 =?us-ascii?Q?I4tBFhiZ7oEhG9MxrJXJg6W+5dTVjLQ5o7jfIcEbkFZTN7z9F2DzFzU/5xlb?=
 =?us-ascii?Q?+9woYA8AORUCa+5DlwW0knBXBUsy3AbC0iArft7fJzhbLQPWVKENORhJsnXI?=
 =?us-ascii?Q?AicKerpDKMEbg4gf7sW0DQ1jWHUat5/RsoMafIAJiszPwEZq5RggxCjtPYsw?=
 =?us-ascii?Q?2MvsuNFMEbMfesqHx/SPjlhi1dlIps3QhvTfv3cHcoOfwCOYQXhe5/hcnEyz?=
 =?us-ascii?Q?U24kftwRueap/ft3HAHf47eUxfZ/XudT1wwk2/s1ZdR9djksaXJVHlMnek5r?=
 =?us-ascii?Q?AWBuS+m6EJER2zQh4+bBkVwjkf4C7HkwsRherBlKeL9K6qiPmEe/qan1r6Hi?=
 =?us-ascii?Q?5Uf/yMt147HziCdbeS56ZlU1TVBlNmPCkq/UsHM8M9I8iwKqzHOAapjEwAmN?=
 =?us-ascii?Q?3R8jWW4v0B5NHbbiSkiPN+MOA6YF2hDyWyCr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 16:37:40.0726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eefc242-9aff-4b28-deec-08ddb40699fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734

On Wed, Jun 25, 2025 at 03:38:19AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, June 14, 2025 3:15 PM
> > 
> > +int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long
> > iova,
> > +				unsigned long length)
> >  {
> >  	struct iommufd_ioas *ioas =
> >  		container_of(iopt, struct iommufd_ioas, iopt);
> >  	struct iommufd_access *access;
> >  	unsigned long index;
> > +	int ret = 0;
> > 
> >  	xa_lock(&ioas->iopt.access_list);
> >  	xa_for_each(&ioas->iopt.access_list, index, access) {
> > +		if (!access->ops || !access->ops->unmap) {
> > +			ret = -EBUSY;
> > +			goto unlock;
> > +		}
> 
> then accesses before this one have been notified to unpin the area
> while accesses afterwards are left unnotified.
> 
> in the end the unmap fails but with some side-effect incurred.
> 
> I'm not sure whether this intermediate state may lead to any undesired
> effect later. Just raise it in case you or Jason already thought about it.

That's a good point. When an access blocks the unmap, there is no
unmap happening so no point in notifying devices for ops->unmap.

And, when the function is re-entered, there could be a duplicated
ops->unmap call for those devices that are already notified once?

So, if we play safe, there can be a standalone xa_for_each to dig
for !access->ops->unmap. And it could be a bit cleaner to add an
iommufd_access_has_internal_use() to be called under those rwsems.

> >  			/* Something is not responding to unmap requests.
> > */
> >  			tries++;
> > -			if (WARN_ON(tries > 100))
> > -				return -EDEADLOCK;
> > +			if (WARN_ON(tries > 100)) {
> > +				rc = -EDEADLOCK;
> > +				goto out_unmapped;
> > +			}
> 
> this looks an unrelated fix?

Yea.. let me separate it out.

Thanks
Nicolin

