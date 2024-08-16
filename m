Return-Path: <linux-kselftest+bounces-15501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8FC954AB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9254E1C21B93
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E477B1AED29;
	Fri, 16 Aug 2024 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWWxWMJu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6219A281
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813393; cv=fail; b=MNa7OV3I5nac38STrQJXLFWKgd8rKSlCUCavBxL/gwto49yUYBbtBpRF8V/V9aeSdsCeW1P4EhNZBotl/8sGOshigohIUJAtcc7W74NUrSbbLt/lMVY5Z2hCslTOwZQtLPlWRiRv/K5YsnQvsrD/I9VDfckw4v6qXynZJfnvFis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813393; c=relaxed/simple;
	bh=MYSv9mUXpu5+S1K5jG2bvoWmr/QWTPgthd2+RQAhyU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WK1T4zF0tyktGrSgocMLvMElMHUCmSLKmOL+0TbqNZP6YOZqf6Ev/YKnW9MjaJRC1iyVwWeICxA0gnzqAXPlUqKsLmPziEkRQdfaeAfn0RlsQJMvB43otvfidKklniE2CHlHRkuvRkM2C1/gKV1twl/QfA0ilfojCBfaO1waNn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWWxWMJu; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRjowQrKY2XXGEpSLH0kXAkIFlkNxuRtdSKRBjIqjIqox8PniD4ywvaFHrGCWCqKLhyArF1LaB21GirsrlCF4JvqnCkI8n6AmzGCsPIc2xv7TD6xrw3M9MsKUQvHAbl1KQk8WxOpjUENjo9ITBLTGTTu5/beEbj3vJqViLOGn6KaFPUyWLf49tdshLpficEJoFTdXV/q8qI2nl6WunUcsejA+V82Es4VxzS0YaPlsDTjOthtOHyaASlNQdNDFUGCf0uUJqHTSqVG3f5Vb1K6MHkFFxPoGHFNMN1JCVpjZdjHP6GpjoQW5B6/c9cdUOZDpLBbs8jDR0DlyqHVYtfPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypUe6j9ihktcVz5o8BxE73otKdNAsvg251FpwIC4SG8=;
 b=muk/AH31cMpw5dC615xbUg90Ck70sZUBY1UCBap3wT57KHiOSeI0LPIYo3Q1uom3Cn4rVDRB/5FgbQ1ej1RCFTt8hFdvTvmiWj+q8Z2w8bvtFy8PD1+yuTw9q+Bp5Y8U6DWSGSnzuzpcbywuBGTmi57LtFaFf/MXx5C32k8gF+bMn4pY2yMz92N94WFfz2MXWOjFy357O1lEMVokiujN8wkIc3C3tR0JZwHZfZjqRAel/CtzQXgvuFnrQLJt8vrylUc5KIePoVOGo8rXzZWcnS8MaKM8vPYGl+U0nL+roNpCtIpRAmW1KpkdBkszJChzdQ+1P8woc/FU5o7B7r11zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypUe6j9ihktcVz5o8BxE73otKdNAsvg251FpwIC4SG8=;
 b=HWWxWMJuvPRH9hoxPqIc9cvtuy4Nm4dihbPsKImRTFDdqht7ovz/YqadmqIibCaVWuP2eHAy9MjDVjNOdooOGQdM0bSrpsf6p1MqSa7C0MwSTXIgi23K87H5xc9XFNC5SZ/AwSfB/RQsGIaAAjahzZUxDoUicKpKbmixT5pI33ddkCLLjipwnlbOnxQWdSGuGW0A560/ry+WFfvWXByyuypjg5FqDDAV6sTEJVfTGSFxjNBKlFEAOo/csGaB/5DoSy7SmdIrkYIfuahf3C9bRmXl+JE3iefwUwEGcrzrGFe3WnJ9/Xz38s5c3sK7c75v34X165siYpHHh/4+p+cN8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 13:03:08 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 13:03:08 +0000
Date: Fri, 16 Aug 2024 10:02:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] iommu: Introduce a replace API for device pasid
Message-ID: <20240816130202.GB2032816@nvidia.com>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
 <20240628090557.50898-2-yi.l.liu@intel.com>
 <BN9PR11MB5276B4AF6321A083C3C2D2648CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1a825f1b-be9d-4de1-948a-be0cce3175be@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a825f1b-be9d-4de1-948a-be0cce3175be@intel.com>
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 86600d06-13c5-4314-22eb-08dcbdf3c666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b6d5n61z0/p3XWS3ET9h0CEV5s7teYAR4r3FFRc14N/paHifha4r6DNNUuNS?=
 =?us-ascii?Q?OwGXu9GxOEvNkLmkR9jWcSRYm0IemUgNxLHMoKChQNg6Q6RX8/XH0bSwCcyE?=
 =?us-ascii?Q?acpjAw9TZ+qiD5u3TUi7+AvKROErBZmfLMp1qzIkgRrCp0DH1iBp3t644ML6?=
 =?us-ascii?Q?WDqE1IQj/BnOgIV8+VorP7+Iqh6FDAzHy5s3yby2nOFmCzb3Pi5xUrqJ/7VW?=
 =?us-ascii?Q?f+g5w7t0PrwgaoQQNxvXSfwAJ2nNOeVD4erNjqNlf7HrOxXsOhtaFE8+6VxO?=
 =?us-ascii?Q?VIvJyqtHV6Zl9RL86b4DiDB3SkmFc28cRKHRgAhdNI6x1dnrO6rPyegpGXYd?=
 =?us-ascii?Q?33EDpCun2Nos4F6UQ82emlU+xZRZR3LcFaFRWdPhGRjmn3FCZddbtkf73qmy?=
 =?us-ascii?Q?VSYRu2TCcnPQlL4Cakjz/4MHSU46QgwVBxS5NH4gYxsgbk1fVQhZKr0NE4ae?=
 =?us-ascii?Q?eEICDWRj+EL2PIMNbhWOnelPB0RpTE89T2j/fd8tFRTnlZSFwJjlTHSodmRz?=
 =?us-ascii?Q?+qnYcngjMRFvkOy8rT9Sj3PvBhqjYDuBkIcuSH/j0vNCY5Vh8brN//GCJu2/?=
 =?us-ascii?Q?yrmNSS+deqABXZsG41bbPRN6zsOaJ3p+VeRg6ux+htOgkEHWIHQAwG4N9lu2?=
 =?us-ascii?Q?t7DJkVl6kEXYJu1lsHafFA256nc0qTPdqZhIDmvn1X1l/jepQGLVhdOPfDMz?=
 =?us-ascii?Q?3hTVfhhnUaiw1PsYE0fWQKrY6VDDBDhHiIQ7R2yT9L5hzyTAaCEj6DpuDNZL?=
 =?us-ascii?Q?ZCPHeaCiAECWG/dOQH/KZkAeLpJntzBZ8xMoyfDRRwjbAjcpL+8ACkhhKgRX?=
 =?us-ascii?Q?I0SBnL4sTkN3/hT6RppyamI7DLITAB4l4jLhCBSMLtkPT7kDPKsHx7uBNOuJ?=
 =?us-ascii?Q?45tsgAt/yTur6D5uxysjshtG4MJSCngC+0e1kVgxGG1ZJXKAgtUtrYa9ibY9?=
 =?us-ascii?Q?gCMuBLur39/GHodHDwn5RP4yyb8NFSlvgKRpPnRI1oAk/xV/I/kWYtkMGRZT?=
 =?us-ascii?Q?z71DzFl/adnWWyBVp811De7+yrjYwi0zDBtxifPDSn6SDJM1+PrBzodcYMGp?=
 =?us-ascii?Q?P0qESi+JRZ9gWFp13PR37qxoQVYySpArmUnwWiJtYB/H8HtXakw+IYRFGsG6?=
 =?us-ascii?Q?SoOzSrB13zgJO44zAbVQCOPN2hs4ivfAWRCg8fQnt1bxB8e1TkD1Kw2BHWYD?=
 =?us-ascii?Q?DKovEjw85FuVMbNi42+IGfhiNEbsh3lBSrKTdtPdUguCJI9e/OUnkf4qeKzB?=
 =?us-ascii?Q?uPqHibrPTeD8VoxCIeoodCaqM2NVf8WcSh8Ms0v0V7oyZ2YWc8+AAiQvRhxf?=
 =?us-ascii?Q?GvtpJFZJ5crjqlGc65nEpNx7JI7whM0/5m1Kcnt4mGEEQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ttI7sp7F/wLZ52LcRGMbxPAs8WfpDyEnKfjaCJplwRD1/EMH44Wt46h1F5B2?=
 =?us-ascii?Q?2Ot+nXutAvwGDvuRssEvo4cm0Fj3syX20WzoJ7Y4lH10O2mh2+3Ho15jJxsR?=
 =?us-ascii?Q?iTx3v+JsIfhokXWVokDVXPC5u4HHUNjUwLa7tZhls5hUZgQt+o6jQCru850W?=
 =?us-ascii?Q?ENYB7VeQepZ4UybNIMTN/RXAEV7bH4QT/oaMjKuvBN16d1qUcBmsiq+PNYkz?=
 =?us-ascii?Q?qcHOyRVsYU29oqqsdE4weTy9rq5+X3svh5tGLPeW+cwznWMNUrKzVjbq+CdF?=
 =?us-ascii?Q?Sa8T6fY/z1op9mMPMiI53LH63TqvLPKWvW9MdjFZx2eaI2Xsvovxybdvahnx?=
 =?us-ascii?Q?EVlsQwkWEUgnDvlZzN2G5jgurCpU4+Q+pnNWh+fWO1IS0KfDyYi8wVIroCHv?=
 =?us-ascii?Q?QNx93IIu1DwyQE7f/hOgunnLQpkNGc8x7DIwUs1ls5FxnhgmbOAGCy30+ZMZ?=
 =?us-ascii?Q?mZaQuhjF5DDmwPfaELCvX0S3Qo2uTzRD3E+4mk+JBvEyl22r1AAbz9lZnmco?=
 =?us-ascii?Q?0obTIT+5gBDsuqhQ0/0vrV1s2K1dLevPSpMFReF/+YOv3WAPRvqQGoKLQkRV?=
 =?us-ascii?Q?4z8rmTqJTMdBMqKwLtOtAGv2lh6tRWz/Ez8bgCUIcVCYIe31ef/nYNQwaRG7?=
 =?us-ascii?Q?Jp+U0mtIn5svpR+dl3SQy+llkhEdpOhUZSBLr3eyUSAbEttrH9Ie4usaFjza?=
 =?us-ascii?Q?bomBO/bdcUNPtWoxMi+xvem9BMD5NIqxhp2PFObwiThQXc4JNcaYgPRRRNfh?=
 =?us-ascii?Q?iXt3aILBh9uJpsPaR2HedKSu5pQNanYz8qp++/d/GevrXFXEB8WTrpt7Iz9O?=
 =?us-ascii?Q?91awWH+BxNe9siI/Ymf3xiaTG03ibYN2mERJF5Y2Yacwtrd4A9n0zRcAGwVW?=
 =?us-ascii?Q?qK7hJrfsdfMYPoskICmySUpMKSmAVX8WqYnEOZV79FRd0hDjmvqXbFeAzPyb?=
 =?us-ascii?Q?a9Q/HFZoufMzwMU0oe003f3zKQpVx9i6JT4koAmavXP09Su9RbWPlSfCH3Qe?=
 =?us-ascii?Q?j+VMt5oiSE7+uiVm4iQu+vGWCfcFuhZ2cwx2g8yORdCrDAXfwnpjZiMvmuYk?=
 =?us-ascii?Q?wMi6c0HtKKu4AiaRCt1QVwi3EbJYMlodl5xIoMnI5DxIrJdffYc0rK+ORPib?=
 =?us-ascii?Q?YpQvnxNc8ZBdxzdjoercIjXcQRc33GHkJmjN8lpxa+VkPbwsnlPBY9zF8iaT?=
 =?us-ascii?Q?SZMIkZAqPjYXt6ecOeadLGI4FOXl4AmAkPI1c2DOLQwuiheiVnocqxgpXlG7?=
 =?us-ascii?Q?QHoouJIHATq9Da7VKtcJTx7lQVSwBi7XaHv84jMDQdBLLYW48qTZHSphyQeF?=
 =?us-ascii?Q?RAyChctFIcLHUvhUs5BodLpwEMSjbp0eWlVnUIGPetSbtDs5MaemrcpD5eQj?=
 =?us-ascii?Q?IiiYr8Wch0+6kAH9Kpn48CTRBh7GvEChLvdheaeQNkJSU1N76wx9nHteGCSx?=
 =?us-ascii?Q?haYcAvkgrPej6XNVOljTum3vUVOggwSfnxYAOpmaynjghoU68Sm7nJh+fBFl?=
 =?us-ascii?Q?gDLhu75Zk37mXfw4J0+mvlXpR6QXdap5hMR/8NdsSH2UM5T4LA3H/yPkh7WI?=
 =?us-ascii?Q?RLX3QgoGv48w5XZWeSk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86600d06-13c5-4314-22eb-08dcbdf3c666
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 13:03:08.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRAuxmVgx1OPaWw2+tZ8AWBMBvQs1zYmseBy812ba8IlqiI0CZkSe1OIDuMXpWpi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

On Fri, Aug 16, 2024 at 05:43:18PM +0800, Yi Liu wrote:
> On 2024/7/18 16:27, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Friday, June 28, 2024 5:06 PM
> > > 
> > > @@ -3289,7 +3290,20 @@ static int __iommu_set_group_pasid(struct
> > > iommu_domain *domain,
> > > 
> > >   		if (device == last_gdev)
> > >   			break;
> > > -		ops->remove_dev_pasid(device->dev, pasid, domain);
> > > +		/* If no old domain, undo the succeeded devices/pasid */
> > > +		if (!old) {
> > > +			ops->remove_dev_pasid(device->dev, pasid, domain);
> > > +			continue;
> > > +		}
> > > +
> > > +		/*
> > > +		 * Rollback the succeeded devices/pasid to the old domain.
> > > +		 * And it is a driver bug to fail attaching with a previously
> > > +		 * good domain.
> > > +		 */
> > > +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
> > > +						    pasid, domain)))
> > > +			ops->remove_dev_pasid(device->dev, pasid, domain);
> > 
> > I wonder whether @remove_dev_pasid() can be replaced by having
> > blocking_domain support @set_dev_pasid?
> 
> how about your thought, @Jason?

I think we talked about doing that once before, I forget why it was
not done. Maybe there was an issue?

But it seems worth trying.

I would like to see set_dev_pasid pass in the old domain first:

	int (*set_dev_pasid)(struct iommu_domain *new_domain,
                             struct iommu_domain *old_domain,
                             struct device *dev,
			     ioasid_t pasid);

Replace includes the old_domain as an argument and it is necessary
information..

A quick try on SMMUv3 seems reasonable:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9bc50bded5af72..f512bfe5cd202c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2931,13 +2931,12 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
        return ret;
 }
 
-static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-                                     struct iommu_domain *domain)
+static void arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
+                                           struct iommu_domain *old_domain,
+                                           struct device *dev, ioasid_t pasid)
 {
        struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-       struct arm_smmu_domain *smmu_domain;
-
-       smmu_domain = to_smmu_domain(domain);
+       struct arm_smmu_domain *smmu_domain = to_smmu_domain(old_domain);
 
        mutex_lock(&arm_smmu_asid_lock);
        arm_smmu_clear_cd(master, pasid);
@@ -3039,6 +3038,7 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
        .attach_dev = arm_smmu_attach_dev_blocked,
+       .set_dev_pasid = arm_smmu_blocked_set_dev_pasid,
 };
 
 static struct iommu_domain arm_smmu_blocked_domain = {
@@ -3487,7 +3487,6 @@ static struct iommu_ops arm_smmu_ops = {
        .device_group           = arm_smmu_device_group,
        .of_xlate               = arm_smmu_of_xlate,
        .get_resv_regions       = arm_smmu_get_resv_regions,
-       .remove_dev_pasid       = arm_smmu_remove_dev_pasid,
        .dev_enable_feat        = arm_smmu_dev_enable_feature,
        .dev_disable_feat       = arm_smmu_dev_disable_feature,
        .page_response          = arm_smmu_page_response,

Jason

