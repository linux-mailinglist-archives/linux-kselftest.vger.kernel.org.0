Return-Path: <linux-kselftest+bounces-15444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA6953A9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC871C21E21
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43A7710F;
	Thu, 15 Aug 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FwsUojMb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BE5A7AA;
	Thu, 15 Aug 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748935; cv=fail; b=XRJaR//QjUawbHitxiQZaw5LDKA3Bo+f1wtjvbJgCnRX9a2QYSn6qn4Uvakf++F1KElbUE/hUJ00aeoHXodmFKfRC9IRzgtALMRO6Pu7kP3abpseY+qx/9/lhliWm4yddShVxPmF1mHL5nU2sj7u7imy1E3P52TVTFk2x824yes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748935; c=relaxed/simple;
	bh=kRcNWpq79q9mCgBaXVesYQLZdNZWdyzSgrdT3H1f9qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qEzdAVhNH571VW55fCIwzehZhig0F/EY+PsyhgFMr13xM36aNvSwPJ+/9ug8i9tlaMwDRnwWMmZ/VzBobapx9Ka+JhuCf6Qu2w8x2+dg6y6jB5x3SpO6oM1amjJpiveoiLw6s2WlJeGUCyRzHLz20qHtNDtgg6cbT1FbwjJlqF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FwsUojMb; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvV862v01Nov3TyUgWZwACiSKB/95LVTndblHapz0P1GRc6m1g1N4qLaZLUs6OL47UnPoVeBwHKm0AJHBtTzHrdKze76UyCg7PTyIrnomfL/OYOMZeUbqyBBXXod054UVqGShrqguHyATwZoWBWmf621ITqO12MK6mylr/8maeJ4UERPT92rbiNnM3FYKYanx2GVUosxRqUriUGo5gKk21SiuvkOTTR0ubhhFgD91aPZzWl9pCSSy54NYb1cjih/5LefTbxhm1ay9SYou66UPnpUjTAmi1o8KkiMIzlVhuDxI3b97E+wiK+5WOcrkczQbE/u/lObA4tsQRH8QqJ3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7sjC4gFhB8lk4lTcBJah3VZhpDQTmW2Bu5rjwUYE/s=;
 b=vbkiiqXmWvXwvZmktIxA/iD/VxayzInkOR4L+vaOftPM1rZLd5FRAddzmGi4TU8lCcwL0Z2rCpWvROWePDlAfD+rQAuumcxNv1u3kNsOuUa9j5QEgYzaAdbflbMQKvmq3RFawDphHrWye2WcbOxTwlmwf21uSFjN7DeA+un522Kif8S0tKWO8wqFVsbTsv5ixCJbqwJ+oDpMBDeSe1qSsny/+oQqCahTCCuZexbTLyYP6JaU1Dqt/TvB8HSl3eWUUtuxnqGZQZgYh13OgXTwsofKhLHv3tVbFoidUsJWFQfZd6SkrdbdWG0ncmIkPYKwQi4vpEwMBxLX/DYMtWrYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7sjC4gFhB8lk4lTcBJah3VZhpDQTmW2Bu5rjwUYE/s=;
 b=FwsUojMbI4VGa89GMBx+7gvSC1uTnk/mIcIt0kPcz2Oikq/roS/akt1yfPdh3fCICqVk9tYOf9EkBE8iNjzjSUkb0Qf8FQwuzfkBGlxN3pQuRsEP24Sv9Z6M9Z53lMndr0coYw0I7mBWIYCmtUuUp9+wO9jTyATX1WFss8LMKbJvoX+5PywYPvofH/FSU53og3M5mXqpGxGBiG1EpsFP0NWH9ZFf5hwmZVRoW8pb/XQLiEg91a++/6FEuihrWTzURsq+DRgYEDyi9OW5GILkIh9DS5+vg8E/JU2r/bHERPdcbzc2Vrkn5QmH27w/qiQWbmFKsOYff0kyalzsP4FdBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24; Thu, 15 Aug
 2024 19:08:50 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 19:08:50 +0000
Date: Thu, 15 Aug 2024 16:08:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 05/16] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20240815190848.GP2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:32b::18) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 212d2ac9-4113-4414-8eff-08dcbd5db227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MM7Rz6btkSFdhhgCI7Xl8vRk5w34a+WPz/5HqgiAykdp9TcQKQSYWDdcpvXv?=
 =?us-ascii?Q?TP9p1mgKNrJbrhS6ZLQcBybMENAVHmeySAVihalkHHPcIB687Aa/WONZuCq7?=
 =?us-ascii?Q?R6dOiy0QYz4Kojv1KgcdT4OdJzEl57DLUO7koTjfCb2AYo5hzqa9+gU+F3zl?=
 =?us-ascii?Q?M/0DihMd1ta9pGfphKEZ6BlvXXSii1/dCWtu9lNWiGjCt/XAhGb5ZU2TQ0qD?=
 =?us-ascii?Q?6ET74KU972SjFrO+7EFRDe3kCv7/mw4JxfEJK0/gbIExL4KwEllybUNG1rtF?=
 =?us-ascii?Q?ATOEB88ehvFwFfFjbk2gJy5NFztWLn3IuvLwzEGHn2R+gY+TMCwOsvsI1Pqd?=
 =?us-ascii?Q?24qu9qbOq50pw9CDcrtGLGMJKt649hIMpl8c4atmloUt7q3F1gWWw3IRVWY4?=
 =?us-ascii?Q?NTDxmq3d7h7y2UOZhitpCV3QyCLiIK12HzVLxPS+vUSDWTkyR5lxDWY/zri7?=
 =?us-ascii?Q?K5MR3+WFLV4F+9DbCeFr/wjSJZoZcuuo3Kn3Q/AcbucIdpeHk+9lF8k0zPDo?=
 =?us-ascii?Q?PydSR8hOwdGEtiavnBAo3Qf1685Wk6GG7PTyR8n5CWIKErdj1TpxL2/THlHR?=
 =?us-ascii?Q?NDhkVQYkgnAzbAsiGJpv9dgATKLQvGV+mKTVNg+egaXukeWkoR7QzczOHTIN?=
 =?us-ascii?Q?OHYJIY/+dYdG7Ithncqnd6SOf27I37hQKDW53AeEf2OxyCTYvJu3j741fxHo?=
 =?us-ascii?Q?Hn99ovdlOzHkZHfg8m5KiDzV9eAOBVomQOblf/TpfpRFl4uNUIey4CiMsp2Q?=
 =?us-ascii?Q?DIDPQVRGso3Xn1aIT3zCkTfDkLid44BBQ4XKeFUzCTAgQtVPIj4f12iqhSfI?=
 =?us-ascii?Q?BOxQ1ShyhQbxE3iOfLWvENfX9Q00jZWpkjJMTkwhtGAOYujs4SFxoTpfT6o9?=
 =?us-ascii?Q?Z7udxguEZ3eULm6F4q2yP8VFyh9gx99nPVzMXFqXYeu3DpWmohaVyHYy58Z3?=
 =?us-ascii?Q?ML67wWFMPTWyEDudv32EoMtnhQJW0Qi8F0Nms1OJq5UmTECk9Dui2uHhqG0T?=
 =?us-ascii?Q?BsYZLsrh1N1jm1UZeCKTAYDCqfPv8iJPVK2d43yRf71/yPkPCAGK5mYw+TLy?=
 =?us-ascii?Q?GVL2kAg02x6FHz3C1rUK75AYG5Mc2FjMrknMvNWtJWPxFdIDb64pE/8qA7wC?=
 =?us-ascii?Q?nls5ncsGOA1BWs9fJYdBZTvCglqgd85zDZLwOoRoVfVoeqnQ3NVs2IDnGStQ?=
 =?us-ascii?Q?gJMeuxGrkKgsJpLJSVh28rpcrj18YBofkGS/Os0buZbP1P6/KbaAuMQ+zxCo?=
 =?us-ascii?Q?SlzZq9kApGRHDIjbBPEffg32vGxQi1sHE679WR5OMNaMAtOcbX6GkwDetEv6?=
 =?us-ascii?Q?336aWaemH7SeG9TaI/lg/DhDtB1VgzEgFoVBaLcDtxS/vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7uSUb4/UdNJAp6WUjRSPCWqytWSPvuKU+ifM+b3SaLWjL/PP6HpOGpay37wl?=
 =?us-ascii?Q?QPhgJKTPcIkOaKpLCSDvXfz6jpTiVz6d43Ng8waj4+96nrXu3BYyYLj2AYmS?=
 =?us-ascii?Q?dyz8vBKN90uEwzkCR4yHJ/I0VfE2uFzwjPQoyp8UTmit7Nty/KVPOFC7U1iG?=
 =?us-ascii?Q?nqOmLg3UW5SaPVciFsmy/BmMYQtPpQw/Nry4F4Ozwa5oCyVbflGJZkjzxHL1?=
 =?us-ascii?Q?I6pb1LuyT2ALu2/OZrOEU6iGr373aP90JXB+iHJYx3q3v19VF/xVhFPaI1y6?=
 =?us-ascii?Q?jomw/DyWzc/swFWBlOeBemTO1n3ei2XUeATNi+NlXROW69YK6Cx/vTS2ZJQ7?=
 =?us-ascii?Q?hVTsIZH6SRd5rvjnT2+lEvhdnCScOgBornTeWBOqsXiurbi4CGqTnbqfJd6n?=
 =?us-ascii?Q?cs6WFO2tXzIa3ZKtWv+MEZM5xXKdYaBQnrvj7maDMFMeES9q9mv/3eVQa6er?=
 =?us-ascii?Q?JT2SpTZ76aUdQfC1EIUhcLTfTw3MSMLZMBqPsA3MSDS9BOxmRTmeteDPJ66l?=
 =?us-ascii?Q?8YTQRmPtAW0hsuNjTKT71C4k1wA5bBmTtuPFf5v/0gChgNZ9IGSGMfzklAor?=
 =?us-ascii?Q?gr13X6HZczFegR7FJi6ArxPvi5mUUSOSpq0Bx1gHJtd90pWnN40jWD8zLgJO?=
 =?us-ascii?Q?fJ/80eH1MaLgKurIkIwH6QwUVvaSBupcGLdSMg1FYrdyW4EV0rZ7UkGQayfn?=
 =?us-ascii?Q?VLKKhrWd9oCf+IITB0cKC7ipNAfK7xginbj+iSjPzByJcbQEJ+9TV7x6gVNp?=
 =?us-ascii?Q?x0qROiJlJOJlIC/CSFIv0LoJouY4mvHL65Ax4aFTbzLz31nzN9MAoU0wFU0d?=
 =?us-ascii?Q?s6jYWGoWE+SQkx+Z7cKLtjrJnq4u9AlvUzA13fMEzjPakDJ6L65vYh3i1ySN?=
 =?us-ascii?Q?rZK8jjUjaW5BWqqxFZVRdRfXMzE3J0QIob369n5UgYzeXQVf4zkOmIWmrHQY?=
 =?us-ascii?Q?Dz3uAkyu1fxEPx67/Oa6+uPpU8ma8zvJZWFzICXE97WiWvhb1YTDLsCoggqM?=
 =?us-ascii?Q?4rpAX+7kBkoGc2SK1etmDcOpf/k9jSlONYyDr9W/ZclMauoUp5zyfxY1T4o5?=
 =?us-ascii?Q?p+J2R+L3gmgba40YJ7cqvK+xKsTXcHBuYDmtHYpKAcgiKgIgnjdWB+sP+12E?=
 =?us-ascii?Q?6q4usl6ZjL3efgjy3eDScRyipI4iqwofZA8rInq/25GO7UsLTRsGBFUb0Yuo?=
 =?us-ascii?Q?Thb4L1XUaUJM0dLX4XIYarQE14vHmVlrQAv7nZC8ekCml19x8e4sluJIhlAq?=
 =?us-ascii?Q?l+qBAsf1mvQEMrZtCc4hnq6wahp6t71AyWfos8omiQQ78QX1szcZfdpMIjbO?=
 =?us-ascii?Q?vbj2BK736LdnCYZ8QCT7dDdqKrmEu/2JBfDrqvA8h3GstGm3sVDMM33CQm7m?=
 =?us-ascii?Q?k6CBgLFbult+HqbPIMcoIk2tQ5AkewCf0lDMScDveKtGBbuqSFB9Bf3U+qAQ?=
 =?us-ascii?Q?AUKsv8ADLh0IYi/DaBZQdfeGOsWSMr0imMONQ9ChtkCQ/j3t94WPTynz3Xhz?=
 =?us-ascii?Q?9rgspkUEkqdh774u6iIDnoYN/Oa2Aue9+nq/+1h2h/zt89CUvs2wmzjFcMoi?=
 =?us-ascii?Q?Ml8niLD/GI25OPMRiPU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212d2ac9-4113-4414-8eff-08dcbd5db227
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 19:08:49.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnbWYlMAbO80vCcdWoM5eCl4Nq958Ez4d/c2ZeIsuiM8N6LI+vDgNzitsuTDw5cR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

On Wed, Aug 07, 2024 at 01:10:46PM -0700, Nicolin Chen wrote:

> +int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_set_vdev_id *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_nested *hwpt_nested;
> +	struct iommufd_vdev_id *vdev_id, *curr;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	int rc = 0;
> +
> +	if (cmd->vdev_id > ULONG_MAX)
> +		return -EINVAL;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +	hwpt = idev->igroup->hwpt;
> +
> +	if (hwpt == NULL || hwpt->obj.type != IOMMUFD_OBJ_HWPT_NESTED) {
> +		rc = -EINVAL;
> +		goto out_put_idev;
> +	}
> +	hwpt_nested = container_of(hwpt, struct iommufd_hwpt_nested, common);

This doesn't seem like a necessary check, the attached hwpt can change
after this is established, so this can't be an invariant we enforce.

If you want to do 1:1 then somehow directly check if the idev is
already linked to a viommu.

> +static struct device *
> +iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
> +{
> +	struct iommufd_vdev_id *vdev_id;
> +
> +	xa_lock(&viommu->vdev_ids);
> +	vdev_id = xa_load(&viommu->vdev_ids, (unsigned long)id);
> +	xa_unlock(&viommu->vdev_ids);

This lock doesn't do anything

> +	if (!vdev_id || vdev_id->vdev_id != id)
> +		return NULL;

And this is unlocked

> +	return vdev_id->dev;
> +}

This isn't good.. We can't return the struct device pointer here as
there is no locking for it anymore. We can't even know it is still
probed to VFIO anymore.

It has to work by having the iommu driver directly access the xarray
and the entirely under the spinlock the iommu driver can translate the
vSID to the pSID and the let go and push the invalidation to HW. No
races.


> +int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_unset_vdev_id *cmd = ucmd->cmd;
> +	struct iommufd_vdev_id *vdev_id;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	int rc = 0;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_put_idev;
> +	}
> +
> +	if (idev->dev != iommufd_viommu_find_device(viommu, cmd->vdev_id)) {

Swap the order around != to be more kernely

> +		rc = -EINVAL;
> +		goto out_put_viommu;
> +	}
> +
> +	vdev_id = xa_erase(&viommu->vdev_ids, cmd->vdev_id);

And this whole thing needs to be done under the xa_lock too.

xa_lock(&viommu->vdev_ids);
vdev_id = xa_load(&viommu->vdev_ids, cmd->vdev_id);
if (!vdev_id || vdev_id->vdev_id != cmd->vdev_id (????) || vdev_id->dev != idev->dev)
    err
__xa_erase(&viommu->vdev_ids, cmd->vdev_id);
xa_unlock((&viommu->vdev_ids);

Jason

