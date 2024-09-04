Return-Path: <linux-kselftest+bounces-17186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E573996CAD8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 01:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727562866FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 23:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA4185937;
	Wed,  4 Sep 2024 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b8mevldE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC114D703;
	Wed,  4 Sep 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493033; cv=fail; b=I4At6efMo/aK89PDNEx3btqNGc1KHID4ie9glvdkGIr0GP/P0U01j/EFisarx2++05A2d+4TYaD1Z8B8UYBKWaXDvhMSSHGLSxRhvI0wCiPX4CtpTFg77Ww4KVVuoBb8QVxuEbmbVey19plEbtdTo8ImVcz9U7C5iMZV+brj/bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493033; c=relaxed/simple;
	bh=ZktIaYOxFeTttKG8kMXufH8bVHciWgm/0/MsvcdBe2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WO/0SgRosIUSzrcmllB+eXoFThmJRrVuBGRnNRJB+pmEZUcBAbqMVzIA686GSBayEiG7lSSGKm321u6ACHN9PYF3bon4bgYddYkC2hx/U+2O+C6+BrGyzp4LBSdWqlXls8e6Y96esjZG6Gv0Y4Ra+UTFtg86moLoeMTgo2/omEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b8mevldE; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7PYLkTcOwrKrftDLp7C7t+hBLACs59Em+y4jZ1WgsttFOxGo0zaBU6RmIlNuaXikwxFK0+yTZPToPFWfomxafcnh+W6U+viJNvD7NKexX4zuCzD1dYVBV04Vk0PgSOxBMsxOB7K1rWrwH/9hYSv0MGzOolc1D0XyC0VMDYtVbhf1/Jl7i1BC5/Vc7PlU+oE09xJFnj43VjoAi1g9ivJUhE6sKzSBkT80T6Afieu6cmfRqeUxqPgUcdvH7amKUGppaW9xCAUZMq36JQu8DJlBIMrp0aMx6xEEHn8Ek2neC/xt9otc6pS2R/1ACnSqP2IScd8SUzGX/iMFxqqC+Jz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjVIJTHpkusCqNpCkBZuM7weNiLwA8Dx3aeiIjNpFt4=;
 b=xq+gox2eQv74ZkojDs3rfGQpumI6dlBDwpimI9+cwoZeIZaSfGsyl/FBF6IeDvDWCXHpwQSZRqiMGrh9Z8DkVHJUQ2Tw/SLVZsrE3zBDEFJ4ONEsunpbVMzAOxWtWFOpxP69FV/DD3AYFwWB8FwjJBQPRXOvy7PDGqyt+RLst2ZjEUODVZ660W7+uzAhG44flHrYKslwAJZHxRYnG6UEcrbLiaqeAORwqJLt43wrKKCfJDKmRPk9gXV/6a7U52sYXITH9R4eYIvAVS5tkMVUudLgv39W5mzS6VjIgg7reSXmwv11ngZ/O47S5Jz1AHb7CltnomAch08n9TycGh595Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjVIJTHpkusCqNpCkBZuM7weNiLwA8Dx3aeiIjNpFt4=;
 b=b8mevldEWQcx7z7S5DkoZSQGvVimjZDbidx43nLsBF1jJx/JAfC2y1ICIShvHzCXSJZR+823Gm7NwrMRZ1GA5Z44FOXY6n2vQmDlXo4kW1PFVXsXhdqO2F/iGOEMAaQm7wdEE63U0QfSju0GLLF6gDc4bOMs3etheGSkuWOibcjuGeXr0u6BaMxuQSrZDXEzf4tR+4VRznvBC+BK5ZU3vEYH5tBdQP6uQAOcXpUOOTGhOpIRzX3KEB0eUG4e0QqfhNLZdfqRgnnz7taiPFMqWC+nma5z3XVCtbuzBs3NHNzApx65pGoODf3wzbPfNJt8jveSwCCdCos41blBz/BcWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 23:37:09 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 23:37:09 +0000
Date: Wed, 4 Sep 2024 20:37:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20240904233707.GA1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
 <ZtVMrXXESy/RfWVi@Asurada-Nvidia>
 <20240904162621.GN3915968@nvidia.com>
 <ZtiY9gE9YDbgJyRN@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtiY9gE9YDbgJyRN@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR02CA0077.namprd02.prod.outlook.com
 (2603:10b6:208:51::18) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 936f8b1e-4b83-4d78-815a-08dccd3a7e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ncm4px8kgzU7A66+EhZP1AIeMrYcGpGizjnsoWUz9VTHeOJA1+rD/JeItVB?=
 =?us-ascii?Q?x0W7YCQgr2McyAhyVYQ5Gpjy6x4j7EEijFw07A+B1eFTKdGIMnnBt1z8ttJs?=
 =?us-ascii?Q?txau05R3NjgOpa/ABL3mop+a9HPElim++Ybyy/cDKkkdJRVl1aynrZvtqLRZ?=
 =?us-ascii?Q?pnSAa91xJ1pPBg0pJyZujj2/nAw7Ab8RE2sf9zXAPLnISj/HvEQoyawulAXc?=
 =?us-ascii?Q?KVzhCjOu8fCu6rUvqh92us7NVN+4qZWzfRQNufpIo2YofvfMUus83rxevfy4?=
 =?us-ascii?Q?YtlKHqXI+R2KgtXnF6CL3Y8/oHpPaC52tOnDL2rYaXhTgFI22ziNGXHbi/ZI?=
 =?us-ascii?Q?0cUYHFv+9y731xSI/KuTobXJoogqo1R3Jar2EG9hb3THTGX+5x+XxE1DToXb?=
 =?us-ascii?Q?IY/3flvDDCE+IvqylvyunVFDhKY7AkAVAlkRkj7zftBRdm++NYqWvXHTvvto?=
 =?us-ascii?Q?2t+L9s/vneGU01/vSPtmIGf0Fbmt+cJQNTB1fvETu8MM8BlkB4GVWjhyxtI3?=
 =?us-ascii?Q?ea1cQ9wqbJtIJWQ60Dq14MNsTTv6LaAY+2Bt1BsFRpfD/v9QkPsPGjrSr2pr?=
 =?us-ascii?Q?jBzrv9PyBGiWSErzvZHXMl6rSVWOBjCj6Py4iEzhEgdwoID3un0Q8AO2MoZ/?=
 =?us-ascii?Q?pvvpIKVQJVrWU5M/LxGjJmeLOAGrRLDMQcvortGHUqlHhO0L/gYcB1Ngal5O?=
 =?us-ascii?Q?F+8tFJFHeQ0BHbnBVhMoxRYdxX5afApfylRxlNaZBvxCiVuuYPX3U1IG8+/a?=
 =?us-ascii?Q?HuKZq9qmLvxXelkAmcqeO92VHgifiMaaQOS5dSDrsR0MQRAqFoSIhNeSQ++M?=
 =?us-ascii?Q?SqSt6UmGWvzs4sfzPa+PsCmM5qJYcdIWkiD22tLdDN+BXvaWG7LKL6WooIgB?=
 =?us-ascii?Q?dUE9cHrRSPFGuPc0ClkNe+/lxQ5nU6qTNgm+qYBEo8Xsc+qKY/gc77H+rwjN?=
 =?us-ascii?Q?WPmVevh2d3Pq0Grz1bPSZjkY/248Uclt13J0PGblHNK6j2pRue2DxNMfiXrA?=
 =?us-ascii?Q?jJr2RUbIwW4PUwiSePwzLJUgLZuqMTJjZJaJ1qYP18yjR+vQ6EZN1xaolZYV?=
 =?us-ascii?Q?yNgrUnYTbEivwbUoCju9t9hsNybacTuXSCjbvR7HAad6+5aIteGq5SfnlW6F?=
 =?us-ascii?Q?0kk7L/0VhC3yTS2okr8SqIa9n3UjkklxXsRwR25yleEF1kBVKFY6OLpzFhcu?=
 =?us-ascii?Q?/YCp83e6RR9uE5q39bjWUiX9zzQIRcwm9/Ar2mmd+Ax8Dm8QEbM6JE0UXmTG?=
 =?us-ascii?Q?dkNd1F2UJKDJja5/2RIqB5G9vOfN7NC1CIGxRtBqfbx/VOt2MhX8L8e1ee/M?=
 =?us-ascii?Q?4ETmXosB56Fy8qBm/sri547dKokVcj9CRQnTaUxPKAY3pA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hs8uB/T7akfc7A4lJnek0Lij9+CEBzEevzCkn4uqQzn4yyc4cfcRyeSNhrwn?=
 =?us-ascii?Q?b+MxrTwgo4LhuEPKnTsLaVqu2U9JVbZygb7OnaIwXZcDG1cLvtG53kCETQUZ?=
 =?us-ascii?Q?dHrEYeolZvz6FmR8OIHAIFealHpzCCPfphbV1YwyVlnv9/AqkY7dNggNUdrN?=
 =?us-ascii?Q?3PKjeKF2ECxOtVZNAdlIN2QUtCJjF3hmY+/L9IbQhQPwejwtw5Xg4B5yt1nM?=
 =?us-ascii?Q?TJftd4WdPgTHmtgWgJWMaXnajUpPvIubg/SWaBG7Y26+4jWAsPFqcgzk9Jd/?=
 =?us-ascii?Q?zO3H5jUI2UiQZfD7Erbf/0g/UisIdL2rCgT29vnSWMJhaNdqRRd/MgRS3Y2g?=
 =?us-ascii?Q?mrt5CO1E1NgePA/BNiiGO5gZ0EFBd2uydPCHT/iYZzWBpajbKAyUUc1bzN3v?=
 =?us-ascii?Q?jc+VQx38Y/mS3XB7GRLqyGaYiwNGB81Ejp/790duIecs6BrW+EDa+8fiUabj?=
 =?us-ascii?Q?mW6lMw4Z/UfC25i0S2kz2df733gh2UC1WxlPXf+J4m86s6qbmuwzFMj3WDAY?=
 =?us-ascii?Q?/Uy4afwc8hCCS/qfmRX2Z66gyNmB84QE6vaX1xCJWHIHPkJ/NTXTuc7x2LnU?=
 =?us-ascii?Q?VtQsPUJbhlpmmfLt0OYeHD3l3Ihu8QQiS8/8UBMFq11gVWobEBm58X70qWtt?=
 =?us-ascii?Q?In6I8D+miagGsJwEXjQLla+mNHieePzBvPpShfxBqudlMu0VUc1RK+eeBNI1?=
 =?us-ascii?Q?PJ8Ad24rJ5dvPzoQL1S4/6W62Px+QLeRP1LcJmRIKmdEOOzLcC36p4TIvULo?=
 =?us-ascii?Q?X1MxUomBozrAgukNFFtRMFRh0VMa4DDOKgEWs1pdrhItmkQAJ+gOj8lz5Eoz?=
 =?us-ascii?Q?0Og4TzO9hBKcoDmQUO6ws8+0qQNMYQTD0E3+H1KDEwy+XkKBwZs0hFLG4BKQ?=
 =?us-ascii?Q?Fua7ddzZiMzdqz2Elvb5JbmQ89McU4lme0csa8LIRxjCqhTJV2LfD4LyIGWR?=
 =?us-ascii?Q?KvzJ9rOmdrMYmlpl2NJ8qNaTkkddyi6OHkD48R5H0JZZn2xjZPuloYk9agcT?=
 =?us-ascii?Q?3+Pt+44lZ0hcVqpWczO/sA6pfHPYyVgf35QjvoBZVJBn/TBhPaoSc1VejwPD?=
 =?us-ascii?Q?U7tCId0uNaFPOQnqTO98gzoxqcnLrIkBQFw4ePgUueJM6P+9CLM/oJKbZlxC?=
 =?us-ascii?Q?W1jUrxCPD9JXqoxnO+kNs9Ox/eMpG+PiX5acBlSQ+jOqZmkGDFQNdpkz6vnS?=
 =?us-ascii?Q?JU+qlPLRpDwLHMtwOHFPo+pQfOSFtQtf//HDIo8XvflTXeZTFGaRTe666jcw?=
 =?us-ascii?Q?9zjppX1g+wVH7SSDHLt6cotl1b/E5vsCyeICyRoA+Xskxv+XWX23UkudafXs?=
 =?us-ascii?Q?lXkPJq6S3QbpBLNdufbdjDWVwx2YhwEI8vWGCnkVGZcKdVoM5MaWsPShG8Pg?=
 =?us-ascii?Q?fNaB60rKaRkdEsH3ADDt+NBWElinToX7BRwpJa0NPv3j9OsdHVePTjHiAwUv?=
 =?us-ascii?Q?YBwvkYwPPYbU/zwh6ezywJjz9icvXwOGnwJhaeXT4dEbcVOPHNcq6ih/vxP3?=
 =?us-ascii?Q?iICYOoBu/aw2wmU8eLdx9B4bNO0bHQ+PYZeMJ4kfge8H4jtwhD3BQ4F44U8I?=
 =?us-ascii?Q?qfA+wqJdgsfVzmmwTUr28gTCzzKf60dBD69EvTVo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936f8b1e-4b83-4d78-815a-08dccd3a7e5a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 23:37:09.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fNyrH5/LIQqc/ovFWvg9gUMb1foXgsTD5lM4w6tNTsZFdLWvt/GEHuwgxUU8+Yg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

On Wed, Sep 04, 2024 at 10:29:26AM -0700, Nicolin Chen wrote:
> On Wed, Sep 04, 2024 at 01:26:21PM -0300, Jason Gunthorpe wrote:
> > On Sun, Sep 01, 2024 at 10:27:09PM -0700, Nicolin Chen wrote:
> > > On Sun, Sep 01, 2024 at 10:39:17AM +0800, Baolu Lu wrote:
> > > > On 2024/8/28 0:59, Nicolin Chen wrote:
> > > > > +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > > > > +{
> > > > > +     struct iommu_viommu_alloc *cmd = ucmd->cmd;
> > > > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > > > +     struct iommufd_viommu *viommu;
> > > > > +     struct iommufd_device *idev;
> > > > > +     int rc;
> > > > > +
> > > > > +     if (cmd->flags)
> > > > > +             return -EOPNOTSUPP;
> > > > > +
> > > > > +     idev = iommufd_get_device(ucmd, cmd->dev_id);
> > > > 
> > > > Why does a device reference count is needed here? When is this reference
> > > > count released after the VIOMMU is allocated?
> > > 
> > > Hmm, it was used to get dev->iommu->iommu_dev to pin the VIOMMU to
> > > a physical IOMMU instance (in v1). Jason suggested to remove that,
> > > yet I didn't realize that this idev is now completely useless.
> > > 
> > > With that being said, a parent HWPT could be shared across VIOMUs
> > > allocated for the same VM. So, I think we do need a dev pointer to
> > > know which physical instance the VIOMMU allocates for, especially
> > > for a driver-managed VIOMMU.
> > 
> > Eventually you need a way to pin the physical iommu, without pinning
> > any idevs. Not sure how best to do that
> 
> Just trying to clarify "without pinning any idevs", does it mean
> we shouldn't pass in an idev_id to get dev->iommu->iommu_dev?

From userspace we have no choice but to use an idev_id to locate the
physical iommu

But since we want to support hotplug it is rather problematic if that
idev is permanently locked down.

> Otherwise, iommu_probe_device_lock and iommu_device_lock in the
> iommu.c are good enough to lock dev->iommu and iommu->list. And
> I think we just need an iommu helper refcounting the dev_iommu
> (or iommu_device) as we previously discussed.

If you have a ref on an idev then the iommu_dev has to be stable, so
you can just incr some refcount and then drop the idev stuff.

Jason

