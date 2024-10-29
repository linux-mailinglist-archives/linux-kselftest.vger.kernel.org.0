Return-Path: <linux-kselftest+bounces-20997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A19B522A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5481F24558
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A7E204082;
	Tue, 29 Oct 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O6iAwbAL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91C1DA305;
	Tue, 29 Oct 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228009; cv=fail; b=GMSAXsm0qm/mFguAt1DY6266yOUH45iVcI0eo+0MtSTB3E2RKsjSLKst2jEItnTcamIiY5aJgs79NAICvBjEnhdHQgCZfEmz7O0oM4SrCCe/s+RR/m9bZJSfyqIUsHZP1vA9px2+cqmH80lV16nBOUx29jzH/3hepJIpo92l7I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228009; c=relaxed/simple;
	bh=9WO2yX/VvbxKADGEa9EwKbh4rQrjJptdBmGrqWxpOuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NE+sEeyCsfqwti3tmsopAMyPzC4VJry/IMhXfF3d11EinsS76s8rchmCA+nT1QONuFnqaEnSlZgt+fbuUwVQLWuV4k7k9Lh+TNSBGcfzNaZfjm0wKTCY+B7G/dg0PIsIFq9OTF1Ic+JPYO99I4oX12hPN3kISvjpwhAquyrNSoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O6iAwbAL; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCC/skMDe5jVb4el1d6XYKevw0iueID0VkJE/smzM7UpvztZNgRNRns5LdKMqqAbGkqndGZIxaEudFnHtNBp04I+HAnSJnKz6H74vYQfYODJtQaa12CBhhnjCOW6dNcOrGcu0ovCQfKOEt45SQBD/m0qDh/UV5s+9z7jF3rfZbnrfVIG9GolAYk2eYogQ0XUmFLh2NdfldLdm22QhSaomHjvJkmGpv/yUMU+JJsb3EH+KvVs9awOl8mk9F3qagk0/YgR9vBz2dMpa77E4BNyGFTe1ilNehwjWpmm0YPJyAPbaj2AzIg4zZeYS6SowD2TAQ2sievJS2gZNjQp3UcutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+15Qw9Zu44RPJFGFLsr1/89LTXRYF60FOGI01Z63ehU=;
 b=G0ZvAJT3vu5aD6jTBv0UmCEsTh+M7dxj8KepGYYbLTmIGPtdr0PHil8PBGW6YG4RUo4q0DUF87C26wVciITPp1PApDo+iXEJHZOtrCpz1A5WP0K0x0Nagjr4Fmh9CmXZ/TolAcLitiSHKmRmo0zYIkhNAsmQg7u6WJjPlKMro35HdUINP52XFxJC5dYGXrDM6Qa7176TJ8EcYyiwKLLwE7YaOsxwwOoI2mGp8glp9+Kj4BDvHV9+o4UHvBnabGHISLMcs3ogukh/hUtsH/OrRVBOAZWskeyF/jYUHWFKAsG+i7RlKCgKNzOaBziMaQntHxqHPeEyFDmz5XypA1WPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+15Qw9Zu44RPJFGFLsr1/89LTXRYF60FOGI01Z63ehU=;
 b=O6iAwbALnbTX1A/F6OqDOpHqEqiqBMH9X31TChwrm2Mr0nlVSQxvW1YnRgzLs7PMSUGjhTI7bxaYKWeBicifqViJBkzsEQ34GA9LqhJztxfQbsW3qotThWGuGgpr+NCVlra2crMTwWyZcUX/KaJz56dq3Z9HBr530I49DtTKdyRUgEK874IBZ4nVtwxpvSqxE7it7My7X6AE3xkFN10NdP42UBKFL4X6EYHN7oICnXrYUdFOXWWZ0ArLbMWfd+7QQv+gTCJSRuVs/9K2LhyaQlKCuqPcbaqYGrJi/ewZayrTDyx4Mz5dcWykWoylMvtuXOBRA0RM+cXfNl86qbKwAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 18:53:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 18:53:24 +0000
Date: Tue, 29 Oct 2024 15:53:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 09/13] iommufd/selftest: Add refcount to
 mock_iommu_device
Message-ID: <20241029185322.GX6956@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f91cc278a173a95969af16c46442f18b639d4ea9.1729897352.git.nicolinc@nvidia.com>
 <20241029153438.GH209124@nvidia.com>
 <ZyEHMr7bQi0fFoUv@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEHMr7bQi0fFoUv@Asurada-Nvidia>
X-ClientProxiedBy: BL1P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff16b8e-e77a-4992-2ca0-08dcf84af72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ccd5PBEzUKdU8Xjpm0GdjzcZ9sGQVPftwSVneKp4kVYPcCiN9FoQZcNr8Bv?=
 =?us-ascii?Q?6RlyZoTHLffWkNSxLdPKNmKeyiHugmightdeSBqnlX157UyHvPUCiiW7iVQ8?=
 =?us-ascii?Q?hbr9yIvzs/zGXzTV2+6W8rrUlSdQOn9XZj87dQRPrMEmBDOvJRuFPlJQbUwr?=
 =?us-ascii?Q?EDjB80f89VjKNYJGBX9lLe2o0cMVTGGgyfV3mPzrcsLO8AEr96ptwgIZR5Hy?=
 =?us-ascii?Q?hy/cUSXctouUHOTs6NGLb7ioorbIrlCdlIgtUck5aJgijBJTGAneFEob/3Sy?=
 =?us-ascii?Q?Tszr48Bc5IHBqR4fkGGKJypnq4UtyEubh+awY3ePgI+SJmbBHeBIk9VgGrDe?=
 =?us-ascii?Q?8vzY+xVGj2h1LpBjhVP/4kA4M3R0Zp7vLG60ZWy77dSdqqEbkQq5AfKvlIbA?=
 =?us-ascii?Q?dfVyYU9sJ7rb4l71+9Mt9E/9yXp/FCssMpVh3Ud0jF81d3tsJyPd4cPCBlW6?=
 =?us-ascii?Q?6qqR6toMiqWpef4sN6PjYobJ+DAbLndpEw7LRWX++9+dKNCfKeItso4S0yio?=
 =?us-ascii?Q?PK6fbZrSPPsRdkhT/reLny6azh1KCWvZm+udN94K5EJ6y4TNFxUQ6hVjUHgL?=
 =?us-ascii?Q?K6//PF2xn74vl8ri2TCyoq4uqy/qR1TnG9c7lpn0xqqAHrS6/YDEAL2xaTAm?=
 =?us-ascii?Q?itpdUoPKjwF83owD4+gj+YWUiJbLEur1TaCwIgbkP9m/b/vOqVa2F4700Zuc?=
 =?us-ascii?Q?zs6FIrAszWZhYvDQKHnGvrQ7lTAOWIgemu9fg7It6N0l7G9YdYcCI8cAZDYb?=
 =?us-ascii?Q?/mrmNNkgVEyhXTmUCC7ZuteVhbIdC+Qf79cVAIfb8v89I3t0sU/DXMw82DKA?=
 =?us-ascii?Q?QQS2uZuc5BuY3XTUOlF0VvJ+E9rMvXg1kXFZMnfnYRcd3F0wvjBGpFr7tFZv?=
 =?us-ascii?Q?VC3OvDeul/6M6GYcolzeNYJ51RPSx98+Ek8wdsq/EgYoEGud1ejdlKOitEG8?=
 =?us-ascii?Q?vv3JOzpB3T6Pbswl4q2g34FVJuuJptLARnstINI2qx8rLj0Y7Mz5cp8dvIhk?=
 =?us-ascii?Q?dOtXWcwoxQ4o4CcABMZZFSmRo/xcgmpCP7qQE+sRA945VtEgi/5/VScpVZLJ?=
 =?us-ascii?Q?xDMs/d5mLnQWQ6ncoEDQY4rHlTeHMb23O80ybtaD45s1aX1J1svrgvY7kwIY?=
 =?us-ascii?Q?OMu9cCxZAkbhV9AsIy2fdAk/nTeMJbyHWGASoCSArs43O+Sj0j7LHgTdkFHc?=
 =?us-ascii?Q?+Her95PWcOmhbwvprm/Sf1TBoW6tjTzOdzHkYi2rhlo31PitGtDwAYrC/qhj?=
 =?us-ascii?Q?vaLcnubq8guKcwESyb1v5+ehXCb0C9IpIpY36LHgiT/gMHcufnVeTNosT88B?=
 =?us-ascii?Q?whvH+U0CqC1PH4gdnNiCQx/t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OtROuaN47E3qYWpQdglcxVUX7tK4TOyJRDm7jH4WKgsy8OXpOkQNVg8NyCiT?=
 =?us-ascii?Q?xdNkC2j0idArs2CA+JKC6cFgzwcE5esg3m1v3cbZOUFkMfevBdVZDUl8HvpF?=
 =?us-ascii?Q?Odso9HkcaqotdyZNUaRQ7+aehnyJnF1kWkM8Yghayhjn/RezdD7YKr6qcdJ4?=
 =?us-ascii?Q?IKBuUPBjrMrlDEc3lnVmtRHRrJJsYFk+rfxAaoWkbr98OImrGhm3NqlnMWod?=
 =?us-ascii?Q?SIOkctnXgsDytYeSX0sGmNCNcs1MECeV4KyItZizLJcEXw01iNIP5X/iaV2J?=
 =?us-ascii?Q?72ZnLGHtm4t/d3ye+REjeIrZNIkAtfWTRsN0/lexz9KSFbCy8mBtasSAMAKR?=
 =?us-ascii?Q?+g87UQZ3JkbHAWqnkuTwYNMeqOMIZcbvWtgNQCswjn8XWxJoE/HBplVzyXXr?=
 =?us-ascii?Q?L2ssDU+gK1Vrz5hs+UN67CzQl6TzkfFcR+NxooVMe2Co+Cv9ZaquFSq7687U?=
 =?us-ascii?Q?QvpVRSvIdbMYlwTXsyE9lacmMmoNZpMXp6RLeXepwjzP6GCmmIPrd1OuTcxA?=
 =?us-ascii?Q?ZlVGzRub17x/z2b0CNXt08PUK1VnN/Oeya2QOq8y9k/Vqs0BDOiki2SDHmyp?=
 =?us-ascii?Q?8sU0NfMbEO73T98/YM43QTLO/Z8H7OiJ00GrJqteaeI7RHQsaaRTM+xW5RGu?=
 =?us-ascii?Q?YWo1zs1F+UUG7PVw0ZDGHGU1i246s0zJb1ZFHxIhgJi7e//moWT3q54XAWN8?=
 =?us-ascii?Q?O/Tjd5Em2sm1i0OxwSNm8VpwFVu9eEt5FGIS91hmOaZRuyK2lI2RVOm6tUiM?=
 =?us-ascii?Q?cskA+rqJDjkprEcAB3xBWFtQcW55QHhrjA1/+lvcQ51MHs4gS9ieqyWO6qvQ?=
 =?us-ascii?Q?7enM6SGPb3rWb3JY5axGbB5/nIsBGGkz8pelK/PLuXf+bWqZ6T9yvSEWeGWl?=
 =?us-ascii?Q?4ZhHegVbKOieqCjUZNsdAVcbZzLi+LF+dMmfFPQW3q3WnX6wpAGm8DSUptQ7?=
 =?us-ascii?Q?yzPX8d5T9PTtCS0uTDhrjnR1P2LOgOIqdWB4JqhawLY901Uut66jP+iLEjrI?=
 =?us-ascii?Q?s47HYYm95dgHuhcNKtpWbxUW6kljTm4YDZ9FoQUsRMiu2bHjeSbpllSG5970?=
 =?us-ascii?Q?reDQXQVaruSqDDKGstMEdO6O44XOue5yb7nwrA2oi6ht51bEUR+o3hBgVEex?=
 =?us-ascii?Q?1YBuZm6gM0nuvC0g7CHB/rm6mjuMtlrzvHS9x9Ii+ZH1JLWFn4HqHgiVxWL/?=
 =?us-ascii?Q?OEZqbnZEF4dHBipNabq5IqA+3VFZmQHQ6XF/Btl0B+hdE+fLezAk1qYsNGa8?=
 =?us-ascii?Q?x57+DevhfTkWsCxs1ZSsPthyptSm1si4SdxifiY2Kyp3n96GjTkPS3M97qho?=
 =?us-ascii?Q?8tfwsuht9GkHS8UcdOf0Oqki65j9z3dpV8N1Zs7QVlULpDpvSKSwKXN9v27i?=
 =?us-ascii?Q?fYsSr8APe4xvfQBwdfdg2+31HvKMLq1AHyTHdQVbxsJ61kKyL0kygNKhhtBH?=
 =?us-ascii?Q?3JGyJcF+vp5EEm/bc+M4Mf29QLdhYZPVM8ap6j0c+Z8C6SouzaE58GfuwatQ?=
 =?us-ascii?Q?71Y3s4BiVJaQe6R/FH1yfw4Tbgc2ndQvbe0mLa8ZJAVlMpTEj1bk8GiAxRpZ?=
 =?us-ascii?Q?C/fk4MICku4T0kUQuTs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff16b8e-e77a-4992-2ca0-08dcf84af72f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:53:24.0783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tgkzgTpEYU/lZ8yQRShbgPmFo8Dh9iMa9SYAtJB3rZnWL7iz9SW3/XQuBZVBNi8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311

On Tue, Oct 29, 2024 at 09:02:58AM -0700, Nicolin Chen wrote:
> On Tue, Oct 29, 2024 at 12:34:38PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 25, 2024 at 04:49:49PM -0700, Nicolin Chen wrote:
> > > For an iommu_dev that can unplug (so far only this selftest does so), the
> > > viommu->iommu_dev pointer has no guarantee of its life cycle after it is
> > > copied from the idev->dev->iommu->iommu_dev.
> > > 
> > > Track the user count of the iommu_dev. Postpone the exit routine using a
> > > completion, if refcount is unbalanced. The refcount inc/dec will be added
> > > in the following patch.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  drivers/iommu/iommufd/selftest.c | 32 ++++++++++++++++++++++++--------
> > >  1 file changed, 24 insertions(+), 8 deletions(-)
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Since this is built into the iommufd module it can't be unloaded
> > without also unloading iommufd, which is impossible as long as any
> > iommufd FDs are open. So I expect that the WARN_ON can never happen.
> 
> Hmm, I assume we still need this patch then?

I was thinking, I think it still is a reasonable example of what it
might look like

You might include the above remark as a comment above the WARN_ON though.

> Could a faulty "--force" possibly trigger it?

I'm not sure, I suspect not?

Jason

