Return-Path: <linux-kselftest+bounces-19172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0911D9934B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6A4282756
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE71DD535;
	Mon,  7 Oct 2024 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hF9KJVCe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E71DD525;
	Mon,  7 Oct 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321527; cv=fail; b=klUQLszfLxxdKfy9J1QUle68+r5OBAWd+nTorwIY8uMH7T76JFlU5LMSgpFzssMpRisl6PlLt72D9XKryfNR8aKvMDVTtwm94LOvEYsNeABV7++CqiJLvCgAKZekMsN6yYXZeNBvReWYKYxCkVuJQ2fElWAw10bnU9zhD8ug8qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321527; c=relaxed/simple;
	bh=3ZSoLaaxnD36inMMkLuedxruyFXFNql5EsInhUH0GLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UbnDm9YmJTcli+t7742/5+KE47a1yvwqmAT++SozKpZSTCSZka6TOXBhJ1LTrKzkI8+Qrqz1iODdsJc2jzO89kVZFO/oSRjAbmFkpczeSHM56Kr/FyYM/kgT4nNqjELb6R/LFTYx5cgcc8tWhQakIue8Orpgvx6iB1ImVjrvq5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hF9KJVCe; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3UU7apuB7svXpUtOZmF05Zzn1O4Ifv/KSP5wIQmrDqyHRjCGxZlcWy4d3vcy9OUnpdHYDjaEAD3q6u0GZsLyEbnlMhdj9BeMJVeHXfE2LcOl/M1QluW9Fk4Q2/hA+V5nCfL4OmTsoPipRXtWZbhMpM/MWJiJEp+XbqMMSJEI8mwWR7vEOnJ186CGjiQKKU/R1N583wj7q6bq8mjhiq2vOo4yANvgGScr6n1vyiJ+SzdAvKBRHo7QMK4Xkq3ph1mZW2161hThm5zoNhjInGL5oJHW0nm8+ic6Bfl9g0owbiG3346dRTqS47Id8OPNcF4PdalqE5SoFl5YtsS6qkhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8OLWQbUi+Yi2zYM7704hs/16fmhGc7Cfe4rITJEBgY=;
 b=XbYvKLE9EnfKqVwRs8k4p09cnDEDlc3ZEUuBeszt0dM0bdj54+z/d5bboyAytwpUU3y+Le4hDYjtUBZCT1ATV77vVeURyXDJ7nn12B7PfI2CVgPyFYINSrRFcTuAOCi+plaS2BKubPN1dJpvD/CAm1mlTgo4wvIptA75bAmkwkXvrQKXAUHe9KZGcnNAipgt4BgXce6xlBgANyiwhSkFCNfw8jFDf+Mw8HUIG9eyi2doAfI8x6rUyTxLmfzkrK81z50Q/pj3MbYLU8Bnh2B28rcfSwUvjCuQ9LlvGB8csIQ4n3DytbSHGw9d4pa7d18Qna2KvVcyyIBQ6ov5MDvH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8OLWQbUi+Yi2zYM7704hs/16fmhGc7Cfe4rITJEBgY=;
 b=hF9KJVCewRoIDwKx7y4XKDw9lkYWZRcmS9UMtYPHuBxkpK7UaU9QJQVuCtbehukpj907oRnQnGqFtJMPP6vgR6/i+tTpGHAyjv+S5ZfmwXZClDO48OqmrZks5+PW7xNi0TEjblGZau2DzBa6FE/KM8/Daw3AM3WIDUr+oircf29Lmhibzlqkexe94OO78qfLD4aFinnvvExT0HrYVcM5ndI6Y4KYLdHxP9i2aM51eE8eJ4hJa1LjZsNVZ5Jopxcp6GZCsNNs0Y9YMMV7Juy/JDMRvGFEH5BUqpzziHMYBkqStzOeCgBaB4RHso07nGVa7maKz+2OQws+KPklu6VNqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 17:18:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 17:18:41 +0000
Date: Mon, 7 Oct 2024 14:18:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20241007171840.GZ1365916@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <ZwAwWr+q3ZGkZCSM@Asurada-Nvidia>
 <20241004185019.GJ1365916@nvidia.com>
 <ZwBBH+9hwuGKOstl@Asurada-Nvidia>
 <20241004201746.GK1365916@nvidia.com>
 <ZwBRHfwrRJCKXrn7@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwBRHfwrRJCKXrn7@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:208:256::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f12743-9251-4d4f-1257-08dce6f41723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQAPgyYdEHY5I7a5SZuWSHVbAVCY74/3mNsWYmMjQUUbiHdsWVlCc9Vco67v?=
 =?us-ascii?Q?q0V2nhJ/uPOMxpvbzQRRsKBiFCJhUbYHoCDIFrRG2jwB3VxXZ3WN8QZhY3Mk?=
 =?us-ascii?Q?3R3gi26pEu4amSBb98SEILUZx5phEomiBZ15oSr2drJezi1CeBPCHtQMIm9F?=
 =?us-ascii?Q?unniX7ybQDeuucB9dmWiINy+4yoEfhSUKzPErvZHr7F+yifOCWj0KbmvEdTK?=
 =?us-ascii?Q?TmPc7aYPv1KMXgHn/xCIWg0lIIcSuslGxrvkMXDuvroY1Fts6TttJIhSHjls?=
 =?us-ascii?Q?1C2Ra+vbAlCTMDmtFKJ7o69TvN2tcYrMFTpW5Pk/ohtwasCpVaLgtvabPgOl?=
 =?us-ascii?Q?ocqmS9cuhmR3xPqP4ZtSHr9XwridIw/Fjq+BFhIr8o4TYD0lFX6zflL4Ooyp?=
 =?us-ascii?Q?MqUC5nllLRg2mvT2Bs9Tkwpk6Odnmtbq8ibeo4OHeW2YdOnaRe2zD1FbDXo+?=
 =?us-ascii?Q?QhTdPygQ6qTxI1VItzULuC1oGd6qk7kfFSPLApdPHXEpCw6WdFNmK076xmdT?=
 =?us-ascii?Q?iMQBxU49jtIhco1V1xg2UFlimxCgETmDDBpYDf4jU1JNLLZBY0ZVwncIhOTW?=
 =?us-ascii?Q?Y9YTmpy6Uq2p0KkZmZE0D9xjeEnaiFZjkz6KHQW2ke8nB9mKgWf4BVlfpJa8?=
 =?us-ascii?Q?99NtE4k2U4AgauPukwN3cQsHffNwmSIOi7mSh/uGT1pIh6FuzwljZHca+bSL?=
 =?us-ascii?Q?jloA32Acc8uU2MRBwckrIZb5AczCQRP4UOVR2HmewDuuISPGttnFVr2ZlmpO?=
 =?us-ascii?Q?hV+oE/7vrQiOv3Rwp42IYWvsDYIMQoptYAGFnyEAc49PnyBpO9zhPLbQ2i9y?=
 =?us-ascii?Q?nU07NO/fk7aJVQbdn8kIsw5ihzPh5oLNqAEtW57AzKyYfzocnTo1r/wOo0KU?=
 =?us-ascii?Q?ogODCeq4K9aARWBycRUyiK1IUdBkmuhGmZ3dIpgEodqCZCgosLXPQLEKHgH6?=
 =?us-ascii?Q?9fxeGlqEVtSUdvna+8nhAVv8vCvgPjWsJKVWUlq8zy55gwWQypvJqfrrN7Ao?=
 =?us-ascii?Q?lDJ716IzdMsoWmUl6TI0BShnolCs8ciPyq9fgJ31IzM9U4dupxbP/PgAkbC5?=
 =?us-ascii?Q?/JnhmOIwp9MYY9bkvBiJWEgUxkBT69qD5Xocav8Y9eBVS/zVisr5BVzp39jN?=
 =?us-ascii?Q?7lS7vZ3v2X/N+rWCsR+SDHw84D7pUI/5wluHlyI+rXqE/QCtxh250SEO5hl5?=
 =?us-ascii?Q?UrYe/nti8J9cMLOmZLlM+ZUcZp+cWPn32M2k7h2qDkb+WUUGlVVCAVeCpQvv?=
 =?us-ascii?Q?+Jt0/af2pQrb9uFc4NUgmV0/njjNnuS9VAPIyzJk4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a3gYxErivtCRyB3rY+CcoX/J3Z8aA+HI/6t+gFt83Zjel1GEiEkMV+AxqQWa?=
 =?us-ascii?Q?e8pg1ut1G3c4tNukauAF7hsyAiL41BPuWRoemmCzvd90GPzTlIuG+3N9Q2H/?=
 =?us-ascii?Q?85NkpMFMNHd6Mmv9xHCkBnmKARK30RRFQ8SCq3BMtyB8B4wPhaQo+uKrVgOf?=
 =?us-ascii?Q?PoKM/8obPod5KlIPQr+N4yTZ6L5MDFA2j76FkSgaCGhswwMALivLBP+Ummsq?=
 =?us-ascii?Q?RGroNGheFSr05ES+jmxivaP2WGgTs74/+/pLV+3Z0Me3mgoWIs/o6hx5mhzo?=
 =?us-ascii?Q?VLfh6U7IpYw61UXP53G9uRAlNFOirGkSgltZRvoW+xV6QEqNAuwrs48yujkk?=
 =?us-ascii?Q?8fk/CQmM1Tee70z4w6rv2NTzGABdCQCMgIOa73bgaef7OLyi9Ke8/61ukVG+?=
 =?us-ascii?Q?+xOhT1SfcmEWW8S2RjslIISqC4SwZfLqRkCn4JyE4cjq/bI06tIlwNx0bPu2?=
 =?us-ascii?Q?yrMRRUtIgIMFKXMq1q2+maNPJiut4fux6YT54PG4hHrkY9vkfo2i7nmb2tLF?=
 =?us-ascii?Q?ahyaRpKiRlqJtVZcTrT7EH/sTl4oztjPKKIl2E65A5XJTlanOB9hHPrD5BGB?=
 =?us-ascii?Q?E7Q3G1zP+lCjFMSIbHmnCfldZ0/SN/s8GtaTRvMo3y/d6G8J7+dOp+raMlRc?=
 =?us-ascii?Q?3/1SND5i5YZhS1W9qSOT8xcf3b2UhMUBgH2ImGLzc2gDQB7+1HGikVEAy0Tq?=
 =?us-ascii?Q?hLklzl2uB4M6KA4Ahf8YmcqrUVh5IjZeBUfnn1l+nyCq8KbEfRp0op07Hv62?=
 =?us-ascii?Q?Cv/PBVWGeR7ZPtnmlnh9/JgqsvQSyWt4XopV46Vt6a+SME5h8DLvclDS5sfS?=
 =?us-ascii?Q?2iUSVeOn8u+vr66btDf+Xi95Pa1ZIX1XcOS0XwjwoVZIOf9Idvh6bA/RymuS?=
 =?us-ascii?Q?Sm+7Zn+YfPXogAn+Z90a0SRrxjvEUlj9q97mqr04TwZ8c4Qrgr9mMfFCK9g3?=
 =?us-ascii?Q?h5Os5koRD+AJ3v+ZZ548l1nk+p6mCKPRbkugO3dL8tKs4FuqAn49w9cQ3Al0?=
 =?us-ascii?Q?rUbYR6TTzcMzA9KdfOnss8W2jamDip4iKVQAeJeZkUEcN3pD/B3f9sLgejWh?=
 =?us-ascii?Q?nGKvZ0OVo8A8eZHKTkW4TRhpIGoIF//obK2SsM4YHJCkVC4MkNSolklUivX4?=
 =?us-ascii?Q?wETuqntomBhACAJiGGT2lK89sBNLe9vTkaJwA0uM6hmHWGKEg4vDlQDt49RV?=
 =?us-ascii?Q?zBVAHLkIQ2XVUbHRAnmFDlevlcBrT6q5bSBIco0HNsNJsp4DE1JYrLU2T/xx?=
 =?us-ascii?Q?vLAYJdEoEsDSc5GUZ87g5EVxj94kU7mjgVz268nmMoHRYjySKOVYmxrrHOU9?=
 =?us-ascii?Q?bl1DiJkk3xdw119KVMXQQETFctYd2BSyF2iGD2q3jImCtUpTmpWKMjWB8rQi?=
 =?us-ascii?Q?iqM2NRpblWDeZd3bd90CL4NXhDGyLt0NYBi1KZycIUlUfe0fOz4T75sCyDsL?=
 =?us-ascii?Q?DvSUHASQAEn3qqzNy34uOxJlsar7HpEQhPHpD2l3Ht6e7eBnQ8g/jGykFBem?=
 =?us-ascii?Q?E9DpwBF8uaYkYSMwhvDp8D6zaz498ZDYyE6Q0qAVO337IIpHm+/79TquvL6I?=
 =?us-ascii?Q?/zwitV8skjXCmLcKxkA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f12743-9251-4d4f-1257-08dce6f41723
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:18:41.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JN30Byutb6i75cgqcSaLSgIGzUS3aZMGrzcvDMVOHMtXsoYZWV2MzHw2JsgIdUqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331

On Fri, Oct 04, 2024 at 01:33:33PM -0700, Nicolin Chen wrote:
> On Fri, Oct 04, 2024 at 05:17:46PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 04, 2024 at 12:25:19PM -0700, Nicolin Chen wrote:
> > 
> > > With that, I wonder what is better for the initial version of
> > > this structure, a generic virtual ID or a driver-named ID like
> > > "Stream ID"? The latter might be more understandable/flexible, 
> > > so we won't need to justify a generic virtual ID along the way
> > > if something changes in the nature?
> > 
> > I think the name could be a bit more specific "viommu_device_id"
> > maybe? And elaborate in the kdoc that this is about the identifier
> > that the iommu HW itself uses.
> 
> A "vIOMMU Device ID" might sound a bit confusing with an ID of a
> vIOMMU itself :-/
> 
> At this moment, I named it "virt_id" in uAPI with a description:
> " * @virt_id: Virtual device ID per vIOMMU"
> 
> I could add to that (or just in the documentation):
> "e.g. ARM's Stream ID, AMD's DeviceID, Intel's Context Table ID"
> to clarify it further.

Yeah probably best

> > Alexey is working on vIOMMU support in CC which has the trusted world
> > do some of the trusted vIOMMU components. I'm hoping the other people
> > in this area will look at his design and make it fit nicely to
> > everyone.
> 
> Oh, I didn't connect the dots that lowervisor must rely on the
> vIOMMU too -- I'd need to check the CC stuff in detail. In that
> case, having it in vIOMMU uAPI totally makes sense.

I think we are still getting through this, and I do wonder how to
manage it with so much stuff still in flux and sometimes private.

At least for AMD's CC case where there is an entanglement with the
physical IOMMU it seems like it makes sense.

Even in the pKVM type case I think you end up ripping the translation
away from the "physical" iommu and there should be some coordination
to ensure this handover is clean and undone when iommufd is
closed. But I wonder how the S2 works there..

Jason

