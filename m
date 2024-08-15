Return-Path: <linux-kselftest+bounces-15464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F85953DFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 01:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1F6B23036
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B715688C;
	Thu, 15 Aug 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TQvOqm4H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3457CA7;
	Thu, 15 Aug 2024 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765286; cv=fail; b=ZEKlCSzTcOrNnBHiRESiTKVTT3ge/wFt6XlFCQJRoQE9gHr+P70L4afhcfZ6fJGulkSveMBCnUdJ4nsKt9XaY8dI4Cn0UMxt9fXeabMK8DlPxv0MpCfiNtOloT22DmV+5Ivh05KxYBDXbSX4PedXsqlP9C1KgnOTAPqsyMwk0ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765286; c=relaxed/simple;
	bh=LjcHEoBGtMWfVrW9KOGz451g/ZTkVEPOZ6tvApXR0ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MF550ANWMr8o5Fb7GUciWcApiUEwtuA+MlGOI0+HbhYo8BSKlESsWyy7x/vmUaym87mTjolnU9WmQH8nnr59wOkmNaOkRbQnkLzWmTXK3hx2dgKXUhXY9cpRkAIk/pUmFa08yXDKROCoSeoliDgCodtr6cpi3wXpVvB1ujJ76aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TQvOqm4H; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suPcTF7XO7GYBzmg25nYaGaVtzzNNwUMDv6JYrNPzQT1aY8ldiqnmvcDTyRVVFUBHvRKhvElyqj/XmPF5FJTMqe0flte4nB46ZIWSZfc5+lsON5i69CAD8NRLnRWsMQQTBmDX4Q+kYALZBTaCzniEn0iVppUxTRDu8PcXhmnzO4A5BBqzT3SN79fZaCm+NQooOf0IsincJg+U4QCFh4Ghj+GLtw41mYSsc1rtr2Ly27AjrxxqFAm039aAUhExiByxFtXbmz53keS7SY3yc2bymhYtkCDqilJLc5+WTMVBBh6n+KZAALC34Yh2cTwYt9xjz+Pw4CeTdpppnF0Pjdh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDQ6KGtRA6VfahmfS/FtakSo54eExWxil8Kq0kZby6I=;
 b=uAZARJzrGiyXlsI+k30W7wENa0+o9QveHXtrOVw+jPCl17IeAMbbpcJkWozm1p8jSgr/rB+URX5knuvO1Xix5BW1Xktlvg7DlnyO8jNv/gIHu+XTDmtFRNIAWepyhHF0lLdujpKZOJnbs7cu3tuidKg4F0E2P2C8V1cW6hoG7kdwIpKxd/GS1J+Tdb2QxSGFJIW9LG3/5OprVeuCwhznbC59RePaTRX7Xl2OtD44HLmziWs3kwR9gSfnj2xLidXVyT8tBprabw7ieSVeY2FJMkDNpTbL+YqP2scWYtRJQ331jIoA1as+hzYKuzad4BE/qH7FQek7sWFaHKoRyNFTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDQ6KGtRA6VfahmfS/FtakSo54eExWxil8Kq0kZby6I=;
 b=TQvOqm4HuK4cEeQTN/BFvRqEKJV6FbpzJXzdoFhD/fS26naHskkjVrBe3WQV/6hKfeMWeXodaQi2b6LfpW5Nv3Tff/TF69fNlM54w5kRF6BTItElerw2NgOvWtRCoEc/6g2NUm+8kSYs7kCzzBOBSck78ufBaJZOFSO1mqAskLcyDdHGQxgqHHnfhTnvm8RCexLnh8xc4Ut6iBpADXvUG8Dj44n7UPuAwZZygqCx1VYQID5qoh0DcQCFr0bbwZRUQWJ30n6qFo2NHU/JrQ5mA6eH6EJmyyRp7rlVtwus5stWW9NrhoIjF415im0MHRaoYgtyvGVKwQQQPFSgAmmRNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 23:41:22 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 23:41:21 +0000
Date: Thu, 15 Aug 2024 20:41:19 -0300
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
Message-ID: <20240815234119.GX2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
 <20240815190848.GP2032816@nvidia.com>
 <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0381.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::26) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: bdda73a4-9c0e-4508-7754-08dcbd83c465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pRL8t2syPYV76sNNS1QmF+Oxq6T3qzSEoX17rRFXdLD5flOSp8OoNrUmT+Tg?=
 =?us-ascii?Q?gOK9XNDO+bIzYXXIsaTriJjNRfiNQs8Z8fRZUxlJBnlGfmkDmdDwNYctrqwe?=
 =?us-ascii?Q?duglyHEawYSfisXnwt/9HBFoNMK5D0i73gT15wpMzer8Pt/EoSWfI4ovmJIa?=
 =?us-ascii?Q?pbfVQrrFetcp1QmHwMJVbtAFeuaA4OcpO9QREDCWpFtovXPADasKP4LWx7TL?=
 =?us-ascii?Q?onV+IF24TJdrAk2AlXe09En/Nv4baoI+tl/AQxdYyB2doHdf3cNjN1+JhAqJ?=
 =?us-ascii?Q?cw2YNZmdC06eviYVXMSifNzZT0vWgKtrnpzUZTSxPE/pknZb9oh4SVMN6Ixf?=
 =?us-ascii?Q?W51VWUlwoclhvZQheTqq4XBMN7y2R0EJUZLLJOZ1VAGrcVo4r5jKRHov43ps?=
 =?us-ascii?Q?KpD6hnAR+xfg3iPp4d6yVBRturoGsV4gYsRahzIzHMWvB0/u2q7RFQK50MNC?=
 =?us-ascii?Q?8STCYd0sK/Fn0yeK0o7ewkUe/jWA+E2t8skIjMAfFR5KSG6quV0PzLd6WM/d?=
 =?us-ascii?Q?3qZGVsL4NT9jh4VYnwo/WVjAz1T64JkkwLZiqEk4/TRVUtYhM0hVhWjDqwy1?=
 =?us-ascii?Q?FTo5WnB5Tt0LwQDLt/xYwkhFHqEgG7qBW6Uz3kcuf4/2hqqQmbT0n+jZMc6M?=
 =?us-ascii?Q?bg4vWPqMMxrMc3Bilr0o2hLrnfS9nklyITJpHSm6QiiZbxsJ65LDCkfg3a2Z?=
 =?us-ascii?Q?hs0xV/m7Wgk4phd/2Ay4I8obSWFNZTvw3RCMEzJ0iy3aKgwuzQpTCVPhipEd?=
 =?us-ascii?Q?A3bscxcnVELPXhlk9xsLg6xEG/tl3jOJqu56hD8gGYhpQZEKb29utLZS3P4F?=
 =?us-ascii?Q?LaTaptdRsywUDfkorQqe03K7Aj9w3gs3Lw2DSDAdpKmu7OQ/XJ7j68/Vu062?=
 =?us-ascii?Q?eBS7sWLAgNJ+jyTBtRdCs+VfQ+B1KRzKNoXGm1IO2tmHKT73OVXrrUgDgxrs?=
 =?us-ascii?Q?pQVQKIYwG408zp3o/YxGhwig0Lt3CM+Sg+cqAUAN2u+GKGPgMXucScYtScCH?=
 =?us-ascii?Q?QPfJEfMNlmhFj12ADAAsKxGt5zMgjhrScuVyLOiLXADIWbxpDRETfqIr5n2i?=
 =?us-ascii?Q?4PUNkY6qejDus9wTvFKUZbmuKD+mcCU7OkBp6Q8iCvmEHwmMB5gh2PI3dS3e?=
 =?us-ascii?Q?ahJ/tw37LIVGqmg+3hLMZXL3Q7qtHX588ojTaouhJSBYptauN0H+E/OTbcGm?=
 =?us-ascii?Q?/x1Mkvs/cbiPx2unU2hCQiVhRHlaGlkC8kIRjWinxqw9Nfsbt+G/naR7+sQ4?=
 =?us-ascii?Q?yGjoVbdlIxHAErqqlaulwCw4/i39CgujoL+c/iXe86DJcqJSa1yIQ2hdoiKV?=
 =?us-ascii?Q?wOUI5yt6e7ovfND0IQbBw4LM/Je36+qQHiXF46sxFlj5pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ccroInATYRB8KdlJsd4CAsizvTGqpAG/cAw3Yy7gLdsD/2SAWzh2y5iQewRf?=
 =?us-ascii?Q?HGoBX8wYcFlPW8W4PCZLui43nccYc8AODkzcxrpM2ZXGDVlGsE6SPPzdglG8?=
 =?us-ascii?Q?WTUq1vn7fRcTNDkoaPO5+m7JWcENFajCY1j9jNgyzzNomStzM2Oo4F/6KWIS?=
 =?us-ascii?Q?zyBlwhHKTn1b029adGdm7AQbIzFfmOONCiSdAqkts03+ta3g1lg6gCTN7+LU?=
 =?us-ascii?Q?l0PbTECTmONJr3JGNElH+ihW8bEXxMi4XXCSn+HR1hO1ElReSO1YVuNeheEw?=
 =?us-ascii?Q?mKTUpprh2e+IcK1f8yNUDRDa6mdExUqt0vFjzg9Mrgb4EkwogmZTQdp8uie+?=
 =?us-ascii?Q?O8rNG/RB8KO6TDkLTR+yBH+g749682D8kSkrgg1qpF7LqZCUYqe9PLKFMCNX?=
 =?us-ascii?Q?pn4m/ucfFhBQWy8OytMkm6K2opEulnWsEUeqaw3qZBRPycHQ20uQCRKVrfCk?=
 =?us-ascii?Q?bW+uipPE/g5d6mG2P2Pb7Nnt2sV6MELm4hGotEacVnnun/a9YIl5iSxG2sXs?=
 =?us-ascii?Q?YK+HftX0RNveBDr36z2m/LkRVEzdIA2/ROVjpVmTFanLZ0FxeAHDfHIwQhgg?=
 =?us-ascii?Q?nQkBo0eE2GkfVhlVBioEFJCn8oRFZNG+mkohO3htXmU/jER6Ol30WKqvm4eU?=
 =?us-ascii?Q?5/HZ9ZOidnKcb6MtzYYCFvjRIa9cgX5s4lOBume16l+YF4h0fK5ZnL2oC8tG?=
 =?us-ascii?Q?o3q7P6/GmcZ4HWqtWV/D9expqheUNNSS7jNtrUX320RHBnokWWg2AX18gIUv?=
 =?us-ascii?Q?9qyksrV/01VcWmtgRLWTUoa1TIMQu46srzL+82frnLu+nkkbohgTi0u6RgWp?=
 =?us-ascii?Q?o1Cy+xmrCcg8gOvm2PenFCaPZdxyof1a+5xaR0KAagJWJXB5B6kb9JzUQrU7?=
 =?us-ascii?Q?vP4cOHeH3A3Nlyp4JlNqNXf9jy7Hvu2tZ+Mx1IJTeV4GlSL8Svu9DGK2XlhS?=
 =?us-ascii?Q?ydywZwSNLwY2YIPPa/CztNjgz6MOnK+6x3vCsqmXOTrV+jDYH4CeOeqn5W+g?=
 =?us-ascii?Q?M7arU1HulrCIERvQN4whQiGA+KhJiQ76Qxtwiwf0lOGr1NTLO1+Pk1wezKNj?=
 =?us-ascii?Q?KYIH3vIlWsYHTMABnZfF1fLCvHKH2qM4ktH+5GLtwsjilwkDuucRz/qZhdAU?=
 =?us-ascii?Q?P0ojDE/Q32GkZKU6RsvTFrQsGj+ucGClv9YFTyw2Qv6EZnI2sFi2ef8gNeGU?=
 =?us-ascii?Q?Vv9xSmLZNQe7vqIimWbxgaAo1wfMyqMdCb8CyzpBK0VoJW8Fy1WcYWTzw/Ey?=
 =?us-ascii?Q?BMYbQSly05AC2WVKfP3fdG0JEGaj9yJ7eaETO2EYTz7Nc0xUVU+4HrWvftg0?=
 =?us-ascii?Q?a5tfrwJlMRLhYp0Wstpf2SIjoN6yTKp9Z8To1I3eQVYvXbQtEg/r8fEa8Nkl?=
 =?us-ascii?Q?lK7AYCwaGDgftfx1xEyZk8KOQjV4lN7Zz7n/YgmYVZOlim9eBvu7D5VsnR/V?=
 =?us-ascii?Q?g8UgeT+exya5lDag5zziIDVyog163NpgKnnDrNCkxgca9SJXbtk5INc86MSD?=
 =?us-ascii?Q?8/yWQ4cPtemOLRlPv0bAsT0elXKXAMYp1cvzP/hBJE8ljsWE0m4bAh8pwiQy?=
 =?us-ascii?Q?1Cj5Zxu4pIxZUiHwU0I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdda73a4-9c0e-4508-7754-08dcbd83c465
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 23:41:21.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAYYTV+pVEV4nmQVohQdxaSWiZC8JXwXMc2JqNdqqRJncVyUUGLKge0sNNIRPgQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On Thu, Aug 15, 2024 at 12:46:24PM -0700, Nicolin Chen wrote:
> On Thu, Aug 15, 2024 at 04:08:48PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 07, 2024 at 01:10:46PM -0700, Nicolin Chen wrote:
> > 
> > > +int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
> > > +{
> > > +	struct iommu_viommu_set_vdev_id *cmd = ucmd->cmd;
> > > +	struct iommufd_hwpt_nested *hwpt_nested;
> > > +	struct iommufd_vdev_id *vdev_id, *curr;
> > > +	struct iommufd_hw_pagetable *hwpt;
> > > +	struct iommufd_viommu *viommu;
> > > +	struct iommufd_device *idev;
> > > +	int rc = 0;
> > > +
> > > +	if (cmd->vdev_id > ULONG_MAX)
> > > +		return -EINVAL;
> > > +
> > > +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> > > +	if (IS_ERR(idev))
> > > +		return PTR_ERR(idev);
> > > +	hwpt = idev->igroup->hwpt;
> > > +
> > > +	if (hwpt == NULL || hwpt->obj.type != IOMMUFD_OBJ_HWPT_NESTED) {
> > > +		rc = -EINVAL;
> > > +		goto out_put_idev;
> > > +	}
> > > +	hwpt_nested = container_of(hwpt, struct iommufd_hwpt_nested, common);
> > 
> > This doesn't seem like a necessary check, the attached hwpt can change
> > after this is established, so this can't be an invariant we enforce.
> > 
> > If you want to do 1:1 then somehow directly check if the idev is
> > already linked to a viommu.
> 
> But idev can't link to a viommu without a proxy hwpt_nested?

Why not? The idev becomes linked to the viommu when the dev id is set

Unless we are also going to enforce the idev is always attached to a
nested then I don't think we need to check it here.

Things will definately not entirely work as expected if the vdev is
directly attached to the s2 or a blocking, but it won't harm anything.

> the stage-2 only configuration should have an identity hwpt_nested
> right?

Yes, that is the right way to use the API

> > It has to work by having the iommu driver directly access the xarray
> > and the entirely under the spinlock the iommu driver can translate the
> > vSID to the pSID and the let go and push the invalidation to HW. No
> > races.
> 
> Maybe the iommufd_viommu_invalidate ioctl handler should hold that
> xa_lock around the viommu->ops->cache_invalidate, and then add lock
> assert in iommufd_viommu_find_device?

That doesn't seem like a great idea, you can't do copy_from_user under
a spinlock.

> > xa_lock(&viommu->vdev_ids);
> > vdev_id = xa_load(&viommu->vdev_ids, cmd->vdev_id);
> > if (!vdev_id || vdev_id->vdev_id != cmd->vdev_id (????) || vdev_id->dev != idev->dev)
> >     err
> > __xa_erase(&viommu->vdev_ids, cmd->vdev_id);
> > xa_unlock((&viommu->vdev_ids);
> 
> I've changed to xa_cmpxchg() in my local tree. Would it be simpler?

No, that is still not right, you can't take the vdev_id outside the
lock at all. Even for cmpxchng because the vdev_id could have been
freed and reallocated by another thread.

You must combine the validation of the vdev_id with the erase under a
single critical region.

Jason

