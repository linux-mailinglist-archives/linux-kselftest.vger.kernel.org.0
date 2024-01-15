Return-Path: <linux-kselftest+bounces-3010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA782DE66
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 18:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3621DB21B12
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010E618034;
	Mon, 15 Jan 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hF7bDmSi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA817C97;
	Mon, 15 Jan 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKUsYSGR73W61F+9rl99oTT+1FEqD/80sFD+kEmzFDeNljHOftlB/fQJ8MS5EyzoGr6Qi+93LlPMO8Zt0FwpMOaDMToYNTcvnlSoZT9UiFbb2E/heFT2q1yjE/YW3zmBw1I9NlhPhVJ+HScDjyc2C4e72ner9KBnp/lpB8X+GD10WzqDVOYqZlSYhE9VPH6wGshqcr+XhFRuWS+oUYCzzZGLmvGG4iV+2spBBbknfReCVzX1TFzaaDVOBEJWo8oTHn43usoUDAT11l/xY2UPz0KI9R6Tk9ZxOoEhY212L+3+XuUm/3GJlRdfxKqGAlnuA5ppE7RTzf8itpcPWCuGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zlKaXR24xLKfuQDEsH93rF9pRRsLNRJ45efLQZXYv8=;
 b=J4HZGOp1kyA8hGKz6cDzYI3poA60VHo2XgT66mAguOEnZ+IgMa+H9ekhGccW07uI9TJtDnSMSSNITTDsuyZkCgmmiyNfL+GuJKYZKqZ83LMUieSxWLr3bsQ1Ol32pEe/Z8wM41obQcloCukbjyOWGALcgJR+98tQ9mUB3SgB6qAyoQxR2Mjbg8FLgltcfzkwus21gjwDGLwOQsWMWvSUX8jIdxYGNHTHK8efnbuHpLQGNiK3jL7hgvFfAvY7+AGA7/YOwCM8Gui8E0kqa19DveMXMdYjM5Mt5OO2jm3mpiC2R6rMds58JzAMy3c2dj1d0qziGkETGw530oWAhEgDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zlKaXR24xLKfuQDEsH93rF9pRRsLNRJ45efLQZXYv8=;
 b=hF7bDmSikkLaOum4E0S+5wyQb8MZjAhYUTP+UZgIXLj6AnfGz5gt8w9/cOjR/XqNb81R5C3WeH8CHkOe8H1nSlLcmmqeTKKYEBbMHTzpp68JOJXfVVQshULIFlGqutmZZkVti3zLjjQhEj7hpB/k+UzvRFTyXCjmjHrbI+bRy1e+6+SJDx55u3dF+MUK9zg0EXsJisdAse8LrMFoQI6smSKXfsOaDhJ5I8fTZq+Ee6lXCwDbaDEbg8Cit5z3nOlA+tg57XJZvTkNRk/aGdOFFFLFTNUVdFFRxavh23FTOwKV2So8tNFtvY+JnSQeY40Cr+15DuQ9mrVBSwr5KDoaYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 17:22:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 17:22:14 +0000
Date: Mon, 15 Jan 2024 13:22:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
Message-ID: <20240115172213.GM734935@nvidia.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-9-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127063428.127436-9-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: ada12b04-1a3c-4bcb-88d8-08dc15ee83f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ibz69OQjeVSwKfPpCVDBUgKirxnHRAevzALcLZMUxwvoN4pCZ5ktI/ikbZW3H/yTjWbPn6ao+Tt/M+axS58FYDze6in4RV99O4HdHOT9fNWPnxk6xNa9hAn8DWO6fCfTrNS54MpJ3H7JwwkwhrcBrQBUoYj3ntjSBsf6Ygq2rP2jgQgIeDUNCrtakEhl++KlPWhRoZC01DDMpqN1+6kQY3g63T3RTwGsgi61/nng7M+NWK9lizVsQRCoQT1m7dpVWC7vTOciIEmGWejRaI8VdDm4qJn65fnD2DYIRcL2vzEUwIm2Bt5XzOHBaAJ/mlLFCQfHEz5JJl8nfc9TleEAuimY0R9pYfsUNLlABiD4V+SzsArlT1ExR8gr/xYUEqoIT/aBf4kvZ8ZA8Wmm2ZdBxTtKj85hvJigRBMVmsfhDzz3YF1bcY3Fb/ZL8tPzSsBokTunBBL+OudPIJL4IDF7NcqMI5mmwsX+P0NOsRACl1LBCXKMzpyJM7v/iOcO1JkeQZrtzBVDyd5OFuqjfCapdiSNeDIrgN+KQG/RA3nT/LUcOYmZAOBwbhQkwfQRWZFQsptGm8x5SL76MhyyJ7QPFV0t7RSmd8/xdBcNs29xTbgE0O9dZxw4477zzh+64a9U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(6512007)(478600001)(26005)(2616005)(1076003)(86362001)(33656002)(38100700002)(36756003)(41300700001)(2906002)(5660300002)(83380400001)(4326008)(8676002)(66556008)(316002)(6486002)(66946007)(66476007)(8936002)(6916009)(7416002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jw4v51kUN6f8VscH8ne/RG5hjfLn3WzNto5dSeXf/abAA5GCzxVKz+Ixy88k?=
 =?us-ascii?Q?D/Y8DTCEf37J0IGmlJHV0L9T9G0EKk7qKE0ETbPcAHCHLhRFZ5h9WVPiXNPF?=
 =?us-ascii?Q?viRjWhpD4qJ2K05aKjZCUIjAR5nnWulQSngeFfnjIQ/Q5SLGpIveYQfaqr4z?=
 =?us-ascii?Q?BpTk4sTwd9TIdcdGRLW60YDoDMY7ylXydSUVHumdLdzBETeF2BceCDGyZla0?=
 =?us-ascii?Q?lj8/lirsU/0RSp4sXaxgtuKrqgg0Q/eu7ZUJ+ONv0K8NwE20k8uUpnbTDkT+?=
 =?us-ascii?Q?BmvqV51dcZk1V72XmB5cYvIkuIkW+wDYL+SScV6Xjqhu2O2gvQI45KktzKyx?=
 =?us-ascii?Q?XBIDh0USWe/TmtqcI/PzUCGfwc4mXph72Kumyxx1MK/64p+31YTEDJPIixia?=
 =?us-ascii?Q?5cX91aPI77NKzcf2NAwraUQlGkRh3lJeK4QV0Vs9r7F+F+zVtXAunFRcZMmt?=
 =?us-ascii?Q?IUBTjFbZNm7yDNwqbS+DnwUU2QUtQ1mpLwc9Yc9mPlvSTdOxNQvXsIwzL2KY?=
 =?us-ascii?Q?j5SU+H+bo//ZrYeeDydy5aTV/JwaFK36qZ/WmyOUiUhl9mbs6gW62zoXaugg?=
 =?us-ascii?Q?bAJjzbvXwqiEMomxoR3NapE4ISbzxSwvDybBsO4A+k6L2joqq8MUg9U/FetC?=
 =?us-ascii?Q?oh8ucRlE3bZQ09RNJfdbJ7rAvCACMKnvLkZd9SSBJon2h5p14DFE3kEnOcz0?=
 =?us-ascii?Q?JlmCnWsKOR/MOQoTqxhM1FbtpdEjxl9ceBoKTLEBz/QFiIX10q6dkMVykafH?=
 =?us-ascii?Q?moEdDURFMDElgoX1Hb/vBv2examyLy2fYZZBEzhOqhnQYi2Kw8bDsG+/tI+S?=
 =?us-ascii?Q?oYSJCxogRvabmRoK/OhUcPcoNjGkhekgrCZScX2H16F1lijzapcXohtTsk+D?=
 =?us-ascii?Q?6hyu9/n8Emnxpyx2cPD//fqMJ2ZSgSxqc8LbpwSfZIyQN6XY+xHZQnrJxNcv?=
 =?us-ascii?Q?+H6mQkeOJ5Movv7oY3Pr2Wft5dQ+N6BCG4L2uSIeUjjJTX/xnAI/sc8Hy/gY?=
 =?us-ascii?Q?DrQfEkNu1P+rD1T3gTnk/z8Z3vuvnekxcjcTsKEQZ/yLxrd5faWXP7jY7exD?=
 =?us-ascii?Q?NOR7RvOXpFcNPWcZlbSdYyAXoF3BrtOQFMqVpBfihaRm4/dvoZVyCde6gqvf?=
 =?us-ascii?Q?+z6DsjansM3OJSCfo5fbjP3CGiSR3w6S1y6RP18CpZc3/t5sJEYFfSTxEelv?=
 =?us-ascii?Q?JtSbDVXiGBEzWZBGiTNesaX8jjgGN3LBRcX+9BIDdT1AV6sXQfg2fBk4xOPY?=
 =?us-ascii?Q?IzVC/3zjRlbXAlgbZc/1D8anp0s5L9XcARCxlJLR0KlhkHOlI+q68xAI6Aiv?=
 =?us-ascii?Q?EA4bAlDy2c4pVHAjKDIuZqHZdbpDZa2Psr5nvpU8EGqelSPR/VvmkwGRMnCJ?=
 =?us-ascii?Q?vLIKijHbh3BhutWtButeCU8eloDoOpWHINnQinqFAwhK9g07+HWh6uQVaMtf?=
 =?us-ascii?Q?4tfofNHGiZiTie4Zqha4tz6BNZG0i6Yg/gzqOSaRGO/aZqBpbc0BG40483hf?=
 =?us-ascii?Q?ZQwYUDiX4BjfiZORYNfVvzPt9R966YEOeu8NCKTWNN7ldHZQ145NHVcZv27O?=
 =?us-ascii?Q?vOOOY37K4Co71MSrrHB5HDPHz+XQf3vug2Wbl040?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada12b04-1a3c-4bcb-88d8-08dc15ee83f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:22:14.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeAg1MsCMZvXFu1ss7huLt+uT3vcvjxK7k+T1lbd6wEblOdIvRE9GkmilvEZjeyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477

On Sun, Nov 26, 2023 at 10:34:28PM -0800, Yi Liu wrote:

> +static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
> +				      struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct dev_pasid_info *dev_pasid;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!pasid_supported(iommu))
> +		return -EOPNOTSUPP;
> +
> +	if (iommu->agaw < dmar_domain->s2_domain->agaw)
> +		return -EINVAL;
> +
> +	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> +	if (!dev_pasid)
> +		return -ENOMEM;
> +
> +	ret = domain_attach_iommu(dmar_domain, iommu);
> +	if (ret)
> +		goto err_free;
> +
> +	ret = intel_pasid_setup_nested(iommu, dev, pasid, dmar_domain);
> +	if (ret)
> +		goto err_detach_iommu;
> +
> +	dev_pasid->dev = dev;
> +	dev_pasid->pasid = pasid;
> +	spin_lock_irqsave(&dmar_domain->lock, flags);
> +	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
> +
> +	return 0;
> +err_detach_iommu:
> +	domain_detach_iommu(dmar_domain, iommu);
> +err_free:
> +	kfree(dev_pasid);
> +	return ret;
> +}

This seems alot longer than I'd think it should be, why isn't it
exactly the same code as the other set_dev_pasid's?

Jason

