Return-Path: <linux-kselftest+bounces-29277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486E1A65DE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 20:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CC53A4AB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2511E8349;
	Mon, 17 Mar 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xp/opmnk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAC315573A;
	Mon, 17 Mar 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239641; cv=fail; b=jecKBlNMC96EK1ldiYayysAGqYv7IkWDGPJjEE1QhBHBtLUYpos1Ct6Lr27oG12NM+/RlZb2eiQvSElHpH0/LE4I9LHUr62Vh+S4XAoUQdL04zRF/QtZLxJuzKTyRNgpj1BHyR7wNgs6T8nc6rGqDq+tWAeG8aWchUTCyAPjyEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239641; c=relaxed/simple;
	bh=scTn3LX0ydaflqL9KdWaaccLtyE0rHY1cx8lQHcucVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kZQt+fGuRydz/mXcB3B1YJbsaII1Cyq95r3vCGm43++owBG9KXodryDZBloVDMCikkJys4SI3CQfvPGrorZkudas0O8heoUXKxeAGoEfKXpowYW0/bySh8uB0bFuEm0gIgyQqzTAslQGhHNzVme0dcTppNw9AQ9o3iEQNkSmoZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xp/opmnk; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ihsr+03IH52ESHwV4kq204IXNp57kaFY2QDChhQysDQOCBEvOlr+CySQTVffBOqtFBqrkzuiCq36gcN6H4OsWgz9DoaOCnN/j1S8n2HK0d5n5aUb89REAMIKO4iUGhLA4VZ/zdAIwTjKXbbh473ddUWPa1HGB3NLVuCc9MlaYDCUDRzPsxP92WZwiYZ7aXN/EN4PyTeKS0zywbUwjQH8oUQ3egDGmR/4KmPe+KL+yHKUecfsqO1uhoe+ph+gMic/TjrCMVcs/Xr/tPRZl626bgo19KIdVXL5RfOa6TE4iX9NMh9ekCzHcb94YPHnNbwmepc3xFjRKwMmR3/SCapGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCISel3hkwiVaJS3a/reiyc9jqJDCVc+lNGcKizqMfg=;
 b=rnRG9dZNtneTBVLwnT2/qZ/ETOdVwRRfCc1ubLDf+cW9cb6ZA6p5r+apAn7o1JSPkTrpvCl1u6Y52r6l0So9iw25jzk5J12/1VicBpM1xRsxNgxoPGAKnNWy1b3ipRUKFXqTCrd9dURtg7Sv2wKypMS7HwAH77qHRtpx1fZerTMF0+8HnGBLe/fUvhw1ocR8lCve2PDf9IUOKIWcMI75CWoEATW9g5KiJiQD0mftwIiOgSX7zTUYRu6O6HlCu4/VNV+vV9ppOEUs3hxoG4Nw7jTlw3utSkXN4MrraDMCGstS46TCErPQh+rxSMGLZHMKEPEjDYEPCyYr+ZcKBqHzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCISel3hkwiVaJS3a/reiyc9jqJDCVc+lNGcKizqMfg=;
 b=Xp/opmnkZInS0EjLmFD/J5uLmIL9BSzO2PANHU56xNX96tFR/+S9nYMpnguxWPSOeBVKQ7+YbWSLKNt2lOTTmmY0xmMLGk+tpJFy1HQs+qwFNfMSd+2GgepO2LTA5WhQX//lKQ8HeNY3WB5qEZOkJkYTLGtDAoxUghN28V1vWXChN2g4VDls7cbKDfUub9nUQNbje+nkabDTz6/8Ica/xVl2U0PXCAhFhVn01D1kupTvUHsSwEseUg4oTgfIhzjsA0mBKty0uZVubDO1IcwSHNkmpoaFVMlFdKyTToLNxa1vzfnQ4S3ePO6l6ZC2yl9udPOWB0JAykchuYeWj4fdrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Mon, 17 Mar 2025 19:27:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 19:27:14 +0000
Date: Mon, 17 Mar 2025 16:27:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, kevin.tian@intel.com, corbet@lwn.net,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	praan@google.com, patches@lists.linux.dev
Subject: Re: [PATCH v8 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <20250317192713.GS9311@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
 <20250311155714.GC5138@willie-the-truck>
 <Z9B2LMIi+88hlfza@Asurada-Nvidia>
 <20250317154423.GI9311@nvidia.com>
 <Z9huquCf7YuzIjqx@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9huquCf7YuzIjqx@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR01CA0027.prod.exchangelabs.com (2603:10b6:208:71::40)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a99180d-1cd4-40cf-fd57-08dd6589b8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zOKeFSYGbrsg10BCaHKXI4x6IbhfB3AklnWwdMzzq5sqIP8uiPInemDJRwxu?=
 =?us-ascii?Q?YJyJQ/u3vTegr8x4VDmCp9ahFxW2GBHudwxAAhQQyuUPEtZejQbFidmzAndT?=
 =?us-ascii?Q?3dI7eXZtBo1bncvDr5e6CP/GufUpF6YpKdFfta8ofq2ch02jjssQ6eP1rglr?=
 =?us-ascii?Q?VUgdkM4RotK3UcIBQ9jSckkA4jy6svL5hQ/nSyQUnjc6Cn4SetwHRJNDeMXQ?=
 =?us-ascii?Q?SidjupZyHXZ8hJcbxTZKBz6PhpWfFb/Taxx4XsLdry4eBhAZ+mqkbdrJA2C7?=
 =?us-ascii?Q?1JyQ2/zP7dWKgM7FC3q47e4ibKvZxHDu9X7gpTlIAVN6+EgtEVJadlefHWO3?=
 =?us-ascii?Q?didj1MKiJ6JNYFUiLcg4DYl3Tj4tVBWEm5/FZt7Nwg9A5PsTgKf0CTwFblME?=
 =?us-ascii?Q?ugd0s5nQQmF4pujPMCdXlQnahcJ4Hkfxl6+oFl3IuEwFudGqbphEJAr7SI0f?=
 =?us-ascii?Q?gqwZKviVp9GBPMd5TjlmhfN/UZpZQD7zQLkvW7L12jrVH5KADq0dHyqdiozo?=
 =?us-ascii?Q?JQ5pYee2PwKvune2R8bKYNQxslZ38N4tufm68PKoqw4V/qLTHxeS1ZnGDqzK?=
 =?us-ascii?Q?g0J9OUA0Z3aHcGJ/P+syzF7HMbIKr0nNOStfaYaY4AlaLMAZyEIeoi1PysfN?=
 =?us-ascii?Q?YfkL3Owt+i71yITwHCNiW/QnbjbLJcrN4/7wwrRcexHFZrlgodw9TQ3WoW0j?=
 =?us-ascii?Q?EAENayXzyIZFCCVFH2mdF57urBoRNibmiqIfD6pWd24A3n5z59LNQvHK7tGv?=
 =?us-ascii?Q?xTbaLxt3Ap5m8LzNdQ+Fm/terBmXPbFltK5RHdyEfX4+/aBVNTsxs1IIq2Kp?=
 =?us-ascii?Q?6ckSsEdkxMbGeI/tLHkt7NeCQZDby8QtI2r2yVJm/MXKViTw0jjeOzOPdXZ1?=
 =?us-ascii?Q?GNoqZW9mDxuU3wXeDi/UwFIbJMO0i3ebLSjCSYWfqaW3KBj3W86W7V6Brolx?=
 =?us-ascii?Q?ZAUqyHbkn46MqdsP7WEsrOfdAM/aJFUUcArl3Pu8kZkreg64rh/Qg1MD65Xf?=
 =?us-ascii?Q?po1D3DH0YzOiCvdtKiWIp3uGeRe77miqs6sC9B5GrOS/63zGa9idAMQgFt1K?=
 =?us-ascii?Q?F3ZX9rgjS7anaMX0VJGK6eFMYnPnjFWFI4C+iEzg5ZlfEJ078QgjbIGMzYT8?=
 =?us-ascii?Q?rpcF6dKL/K+JRw5gGdpQJMKFGfkXmy1WDMST9TKf3N0GezRwzjZoZXro4vC3?=
 =?us-ascii?Q?8xFiLGEbCvDZuDWrNT/7nDfYbxNBi/kpCavGaUMU2mOEmoFdjm+iBAYdn0e4?=
 =?us-ascii?Q?oW+Cjt+jiPRB1LZmsSiKqxsowK6poYtAowCl1xg03c7n1VTd/zFuzw409Uj+?=
 =?us-ascii?Q?JuTLUcb+t03KEVFANQ7gTqKDbjg0zm0LYtb/2kUXSmrk4Bnizwyb6O5zoRJx?=
 =?us-ascii?Q?D3pJeFctOEvbe5IHhIodGn0qt5Jh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGOlxqFF5e2QA+AdVJPCqdzbNscnCalPhq25r8Q5UYZEp1Iw/DhuUo9aXQn6?=
 =?us-ascii?Q?obgZD3v2PLyACybmfEGlfGFvdNfBYwfKPbtt+mpfzlu5g03ZqT9AUfH0rjr9?=
 =?us-ascii?Q?4x2Xe9zs5u/aDxyM/ojPWC2po4D7yuWkrN8+wsgwNZPHZE4Op02jncgfsEiJ?=
 =?us-ascii?Q?JbB1Ga22ebEPy5w83D4Nq/uY/LkzjqDNU7B6daP41i81zbl7S72B9eckPOWS?=
 =?us-ascii?Q?1j1We73aKANOF3hMRCxlTEqDnWWcB6cd14+HgGsFgMZ9UEi9jLlBjJAKdN1E?=
 =?us-ascii?Q?QnjOfR1AE8p21grD5Wh3bCTdf+G2TP7x0/UJVGFBzH7LTDqnukK0yB736r8p?=
 =?us-ascii?Q?J/nIZcCD5kDYPknBI33XBR7flHcnJA1dk8hGE1ntyzEngNFDGJYg4j0dTq0l?=
 =?us-ascii?Q?EDbybzQs8gDicsCPYDVI7gMAflPOoj8aO+55xuawl+x2DaZ5x0CL7Nqs9Her?=
 =?us-ascii?Q?JguQsoX0nJMJS875p4FciM6Weave3u0vR28MKLf83R8ahikPjA693u1iCC7Y?=
 =?us-ascii?Q?Z/h/x37SBqlYBTHAdxDGTj04Xy87sD6eUDqLjcK/PLVadtQrK6wees+i5sHf?=
 =?us-ascii?Q?LRZB/iupGKO9Gur1ywVKpqe0+aBpdrVjOjSBpGu28NJr3dCadtroKqV6ZDy8?=
 =?us-ascii?Q?WUIpPahE9Zy0+21GLBUFKc+ulcUPS1yh4qd54gqTdqf2C+BaaZIlNKIH5Ip9?=
 =?us-ascii?Q?PSa5Up4WnqIAm+gU08Hz44pcxIc8sNdd8qqCr0Qe5CId0jS0v+2eV21cRHW5?=
 =?us-ascii?Q?JLHGRQ4L2CPa1Pavpf4SRGWe+VHd8TjtLouHbwSeUk1emrpnbo6pjobvxhAB?=
 =?us-ascii?Q?19/iTm14T0oxySxCaOve5WZTsJTcoZ93p46TcLbLwou3TS6SHxcVtD5p/Ut4?=
 =?us-ascii?Q?yBjwVY2gp7Dd4R14d+E2jHMXt/1AfuO8yoVH4D4I5PQt0FkJAZX8TJI6tv8Y?=
 =?us-ascii?Q?KgEzlAkaqj2DrrJevWlZg7bI0Ji7o5YaI9glT3mXxAKcEm+L3zzDeFpxcUFh?=
 =?us-ascii?Q?5YuK3bGOPlQO3+Uotqdl/QgI887pNYhadhbDpYS3QQAbTpkJC47IvnKYQ709?=
 =?us-ascii?Q?k7Y4IH3Y2vdvCuQUv/ib6+3ogbUu+oM/zw6nvIp/Vgfmz8texorCKcSe95Ne?=
 =?us-ascii?Q?EE2ZBwOPQABHDCbbDeIaUE4euKJUfDdYoByyDPtMTCFkSfltsUqqxu9QcdOF?=
 =?us-ascii?Q?/QhnXK7xQGF+ngB2SyAav6Fs3DapzmpUoB2WrSh7vd4BEDm3gzxtLhv+Necu?=
 =?us-ascii?Q?UdIw7FgqJ43p1FKTzLHy5YUjM/KukM+hLtiwjnwWc9Xni+kHB47e2C9lJpKJ?=
 =?us-ascii?Q?6SOMzVnUXlIJoMnTfKeSFQAdco142kORiGqXmSYLymeTIimM3AUWoLn0G/Ax?=
 =?us-ascii?Q?wJHplep/+O3UkLLkcFBluPEGMRd3dGUev2X9hdzsBOT+Du/iC2VzdyM98Amf?=
 =?us-ascii?Q?bgmsCx5xwVecVqfppnZIY3hnafF2O3r8YwuLmqQBMTMyX/Pqebo8oHp/dtdd?=
 =?us-ascii?Q?w+rwDKiWPyIDJrybub+gJFdFaM2voAKQ50hvJG8S2or/UOrye3riHRLnWfIk?=
 =?us-ascii?Q?B7hXjxyiCUnXIuHyKxlwxH40tRRgSTRQsKfyJIzq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a99180d-1cd4-40cf-fd57-08dd6589b8e8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 19:27:14.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Liv6s+sWPg7ip2bwyzRpP1TxPvkpcaiKPskDkXxI9MSiz/XTLxjxWU7acsZTiBYE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

On Mon, Mar 17, 2025 at 11:49:14AM -0700, Nicolin Chen wrote:
> On Mon, Mar 17, 2025 at 12:44:23PM -0300, Jason Gunthorpe wrote:
> > On Tue, Mar 11, 2025 at 10:43:08AM -0700, Nicolin Chen wrote:
> > > > > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > > > > +				    struct arm_smmu_nested_domain *nested_domain)
> > > > > +{
> > > > > +	struct arm_smmu_vmaster *vmaster;
> > > > > +	unsigned long vsid;
> > > > > +	int ret;
> > > > > +
> > > > > +	iommu_group_mutex_assert(state->master->dev);
> > > > > +
> > > > > +	/* Skip invalid vSTE */
> > > > > +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > > > > +		return 0;
> > > > 
> > > > Ok, and we don't need to set 'state->vmaster' in this case because we
> > > > only report stage-1 faults back to the vSMMU?
> > > 
> > > This is a good question that I didn't ask myself hard enough..
> > > 
> > > I think we should probably drop it. An invalid STE should trigger
> > > a C_BAD_STE event that is in the supported vEVENT list. I'll run
> > > some test before removing this line from v9.
> > 
> > It won't trigger C_BAD_STE, recall Robin was opposed to thatm so we have this:
> > 
> > static void arm_smmu_make_nested_domain_ste(
> > 	struct arm_smmu_ste *target, struct arm_smmu_master *master,
> > 	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
> > {
> > 	unsigned int cfg =
> > 		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
> > 
> > 	/*
> > 	 * Userspace can request a non-valid STE through the nesting interface.
> > 	 * We relay that into an abort physical STE with the intention that
> > 	 * C_BAD_STE for this SID can be generated to userspace.
> > 	 */
> > 	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > 		cfg = STRTAB_STE_0_CFG_ABORT;
> > 
> > So, in the case of a non-valid STE, and a device access, the HW will
> > generate one of the translation faults and that will be forwarded.
> > 
> > Some software component will have to transform those fault events into
> > C_BAD_STE for the VM.
> 
> Hmm, double checked the spec. It does say that C_BAD_STE would be
> triggered:
> 
> " V, bit [0] STE Valid.
>   [...]
>   Device transactions that select an STE with this field configured
>   to 0 are terminated with an abort reported back to the device and
>   a C_BAD_STE event is recorded."
> 
> I also did a hack test unsetting the V bit in the kernel. Then, the
> HW did report C_BAD_STE (0x4) back to the VM (via vEVENTQ).

Yes, I expect that C_BAD_STE will forward just fine.

But, as above, it should never be generated by HW because the
hypervisor kernel will never install a bad STE, we detect that and
convert it to abort.

Jason

