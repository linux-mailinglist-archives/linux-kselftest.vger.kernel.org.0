Return-Path: <linux-kselftest+bounces-26888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB3A3A4F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B51188D244
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7825E270ECB;
	Tue, 18 Feb 2025 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qp/cfPpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7545246348;
	Tue, 18 Feb 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902092; cv=fail; b=AEB5zs9+PlfZj2gpwYzNppChHVwigxMqgL7Vav/Uey3e1uNl/BGkZaIk+aMGx3+nr+LEEJaJYK8uIgyME1BU2o0aiAChRQ4/QgX+4jLTr2CnDzWS+uw4lHWM0lzLLMTEOnlPsnVzogwa87X5twofyz/TR3K0umCdJJ/n3lctG5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902092; c=relaxed/simple;
	bh=cFcVuRwR2iLY/52kTs4b8BSF0D1sndDLqhjg3xwiifw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gwsOItsI4IdPr0eJh9YmLLPfYvTmIG5crhCqaKeYF9TFA61z0PMNNForPcmUKMuXGDki2NxyBAPJgk8XA8HgKScdVXg47ls/mP4JSQBqLb4oGpO/XPApLrSpdhY3SADZrttDa2YDrtX7idPKKF6lhy2XpmxrxcFjsDlxO2WyddU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qp/cfPpe; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4wmI+TOeq0mErwWcjK4fI43eh535Q22YQK8mWYGMfCCbR3YiPAbe0TyfljKxSruDAzNkmosP4C3EXEn5Tl2hxpRFJ3hRxnVrlkSYaiIb6f3eqS//vYGcGELM5rf7LN7zxZTn2pe3fVXGL3rbjN5S+sFj+VOrDg1fyVJ0oUgitn6H1I0hEzbW5kSpC/FbzS5RokiAvjB1EFLPtZoEOcPzG6XOO5/K0PAguHColp5IQkr4u7vHRNVYp/K86mhe+hT88ZQLijzUdfWR4+u+XFtXORMtoj63Ks1QE66nR7GBEF7TAGP8BA0XCyp/A3AMivz0AmWLPA2XSlKHdGpSNRSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TS/shLrBFmY6HBcWUeE/akb7T2DeYuPzRXyV636ihZc=;
 b=tlxdpWUcPFJ0sKg41TUzF5GLXcOqOWSG14LhtMwrMQDqy9VQ2DVIVWrt4C4kMUGf41Ld4NK8l5fbUIGDEr9HODKnP0C5XOXWSS1ilj+sDqHAEx53tDDWg86nOfBtbyrwmxsblX2jusd/KjGcqcROrUJBHqn+hqfOIdzjF1N//90apz+WHz7ZQxY1IDhCmycQqZhg37/AreiF/YyiavT/hvVTYNtGFbvYpX8xWarlVPyzwxIHEe2eZG0waw1lQ2XKbgw/bIxNEFg9B5mDfpSUMU5ylFzgHVAcR2013mL1F6CW002dqW3EaEe5Lf8u/ocEThPw+KAuGu7sF0A5S1j3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS/shLrBFmY6HBcWUeE/akb7T2DeYuPzRXyV636ihZc=;
 b=qp/cfPpetZk8r25LncXUQ8OkkUqcce9Ma53TA9oT40wQfAnzOYeDmqDxCUzGx5x9kabLQ0a3Equ+qFCa69/fOnKZP9ERgUAhsxZLmlZMugaptLC0Zs2516o+O2HdfHpgOW0AYtE/HzaYphaERQEDczOcV6+awbwAmRXrQHhfxfI5lHmgBs5ugPfEb9cGv8BDBc5q3CAg9nirSWRzqKk5UBVBh+OcdoDLMxPSdWHx3FzS5VvaeH0PjjNtVeDcpE9qPZvSwa01kkrXSRRS8aZWAhnMQqbrOa+PUYq1XFvlUtaEogx/zeciPOTxWo2P5bB5For39Nonqztz7BBqZI2kxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 18:08:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 18:08:06 +0000
Date: Tue, 18 Feb 2025 14:08:05 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <20250218180805.GI4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <2fb8d9c7b01ad36b42849283cd33d931f11092cb.1737754129.git.nicolinc@nvidia.com>
 <20250218152959.GB4099685@nvidia.com>
 <Z7THxrq/6sYP/AIi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7THxrq/6sYP/AIi@nvidia.com>
X-ClientProxiedBy: MN2PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:208:120::37) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: a4685c7b-0105-4b6f-abc3-08dd504731cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4K06gbJz8Kxys/e+n5wqCTe2FxLiPjbHS0YDgMLdpHTH63ngEgoPRDSTi5VV?=
 =?us-ascii?Q?7Qw7HrtgFgItjndqWkAv/tanWxqKSyvSPP3FXwNMxgWCONMvy6OO4a+RkxLc?=
 =?us-ascii?Q?dic4mv/CuFp5DLeyfN8YDVIgF4LFXnJ9F7u+VEvnMHhUTJkbLsMZngltoIY0?=
 =?us-ascii?Q?7tGUpbStzGUpXLEHB9FRW1AqGCPs05MKfcZNm/omXh4ADuAB1XN7XBLcsWSM?=
 =?us-ascii?Q?P4MLo3h2heaXerFN0MLHGbqbtIrLORKbGw8TjLNt1fTJwTvR42F1mUKw16kb?=
 =?us-ascii?Q?iOryzylrNmey3LZSpH1aOrsVpeVQcvRR5sD3OFpwJju40iFjR+/yFKhuRBW3?=
 =?us-ascii?Q?M8KLQk/fa+2Vy3Zn+1oJM02xTYaOfEmo4p2vfutgF4VZSvEcB3CVW4IZnMXv?=
 =?us-ascii?Q?XxJFnMfcILrMLWY+vUJ0uZP+59w5d1xdXMHoZ5oxHw+remesoyywlOa74kOh?=
 =?us-ascii?Q?umwS60p4td+iAtykSx2nnknPZ6bb+eIXXp3Pg3hWiQdScz1Re9eKmDflVNTV?=
 =?us-ascii?Q?nkFPuJour+T1RZ01SBFq+lgwUSWer/oJhWV03gQ+g2qOiZ2JXJrB+EIguYWy?=
 =?us-ascii?Q?L5ngoqMcZ80VeYcBt+pRAkok51OxY0feKL1od+VWb5hXJFFfvkoD9u2GBPuT?=
 =?us-ascii?Q?xdFg8QKJW06op7/MoUuIBfUqxASdbxwio3GeWUg5dLZ8eBK4dcB+I3r7YEZL?=
 =?us-ascii?Q?LWXaoCepJ9ez8qktdk+MNL10tVaeqszaZFvLAU+qNC+pzevr1cdfkaRkckeT?=
 =?us-ascii?Q?BALBTU7/HGOInu6lju4p1aFE8npp/v68yBZDZU2X0NWHtJ2ZlfIpo0iiihMx?=
 =?us-ascii?Q?EKvX3auXeOl8T39CTmcz/RmOPUPmSxL38XCN/WHoWIgpLk0iJ0biqUtDyPRB?=
 =?us-ascii?Q?uVk64FvwTCqcPXDMa3owqOom/7Y3yE9+qYovLI42A1YhNaNi5PBxDfcE8pdm?=
 =?us-ascii?Q?bMX1N+MT9J9RjXggXz+qnYTacWgcgiFg8IBar2AgvFP1dQ5j873B9NkB6wbU?=
 =?us-ascii?Q?uHIjX19qrcfbcV59FGGxuP4pXVNdnJ7P1oD/OAZq4U+N3Sc10/amwCwXuCfV?=
 =?us-ascii?Q?a259kqpQKYrYw+J5/1zyUx9QmIRqWkACLu0OgV1jwDMe/tLOBHc3C8jGZInO?=
 =?us-ascii?Q?ecB0YVXmzJnF4GvXM/Y11p8qoa4dc/ku1QKER4AWkj1qucOmifYPeZeP+mtO?=
 =?us-ascii?Q?6PfbdA5dI0B6t7x9syqvRnaVdhX4ls1hq2LCvhDxookzBK8oQ2BRpVIkb8+h?=
 =?us-ascii?Q?PsPacxuujRJ8h81aM8S9pIMPF61GDkSqPLQNERLqIhM8WlCceneVk2aCotqQ?=
 =?us-ascii?Q?uH0CXtBmUvXDjDEsLIkBWIL6MYN6qdqfT+ByhnqIaKxfv2/DASXlLPNqTRlK?=
 =?us-ascii?Q?pfl1QAgi4JTC3am/x8Md8/oKLD8Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PcEnHd7qPMYdRB1iyAjw7GXf0hLu+JmgzTZ4EDJ5nh7wp9l+tt1be5PHsuMn?=
 =?us-ascii?Q?rNo65NlY8g2CKaS042rNIhm87prLD7Yl9mAktcEs0b/+Io6UWlm0iuR6m4yR?=
 =?us-ascii?Q?hBgYnACpBkA+isn9AVKyWy/h8yR6k+4yFeq6ya0p3llaK3OfVKRIYxiIFgah?=
 =?us-ascii?Q?fc8j+djg0GXSIyGywYjJQiwUUoB1wrgKf0SrKlBhrX2kEGhG9r8eoOgfq/bk?=
 =?us-ascii?Q?33DsvjcvhH4tqi1/4QlbkMnq4wU8H9nMAl4nRocHWrqQwDPYMWubLyGg1O99?=
 =?us-ascii?Q?4RNiICLgtY1zNEkY847rXaB+nE23HMKZEsW9k+nPi10I49fGh71dvMKbY4LH?=
 =?us-ascii?Q?rw3/9RILD7Ow+HMVIbjBIduHgG1pYCnpfO7BP7zEstS5mS4tV7ZFxTx837Lv?=
 =?us-ascii?Q?a/rPHcwAuP11OEQqCzR9JV6pNHJZDgGMOp92cSPp1RUuM0xguTcko9YTr+UE?=
 =?us-ascii?Q?SMqgpXXHhfzJbsFSGfDR6AHuGpIstCkCPDw96taCoPUqxhoNG9+Ll+5u3vuB?=
 =?us-ascii?Q?QFMSvYe99Ftu1SxZCACeF2NFmNXIyh7HMj6EXou7afyWksLgP0ptpK3uDO4K?=
 =?us-ascii?Q?sqZEQpW+pQWq/P0F+W2EDOJW2Hop6L1AtIpL495KvrG2LD16OGb6jAxaugfC?=
 =?us-ascii?Q?//Tx92tU2NJPImQmQEJlrDqo7gmZItoLKfKSobUdlVSfKW2vOtQZAoi/5ouO?=
 =?us-ascii?Q?XfahvNkvvNr2RWgcCu1XaltyOWVENZTUb/9AFKQEwLNYSZtFimN0nBkkoiva?=
 =?us-ascii?Q?Lh2ZjDnQcPhvnVuEi0l1WAyihkvbmbz9R78+qIrf4pRyqzN8K0NJ09ePayIF?=
 =?us-ascii?Q?KxDS2BpZaRHG1YMEAAn0RnyS75ys89KiTHS6TX1nLSSn3FQclzeaQ9SorsoQ?=
 =?us-ascii?Q?XAZchMD0DUCecfxs57Lz0B/OSmnlwY0fZv89+pd2+4o1iYP0/5ByYj9mcEUv?=
 =?us-ascii?Q?6qGbf+wRMrboZ1nMi0XO2qpMmOtyUlEyYIEfuQbK7xV3P7+VBQ7/NZwQBFFM?=
 =?us-ascii?Q?4yWvQllBN0+EMSv/61NjQ8su0t5QiVLkIEC0bl1vhQWzB4q2iV0+gizWHijA?=
 =?us-ascii?Q?Vkm2ltTYzrDnHd2GmgV5sda9NuMdtd2GSJ2Y9ZSEcUZuca4XF24IU5/6Bvwq?=
 =?us-ascii?Q?nvcPrv68rNuoOu/nvAx6fcWcV4vamTg4N69evULTyvuCsKBSZKf0j5m2WlEc?=
 =?us-ascii?Q?PM5jt7pje38ETCtLK/FaRScA6lusWjzFPM8fSqqMgXAjNXdQ1eBaYM0bM3Ty?=
 =?us-ascii?Q?nAHyzvqfyoX3zbs5RuA7/KlIvCRjGupfSafOtqX5Z30teBkVX259JngbbDTx?=
 =?us-ascii?Q?KSqIdUt2uxcCejxzmXkA9fGnwgp3yFhz4IIG9HAAU4/djg6zy/FbH4FnsIh6?=
 =?us-ascii?Q?AjD3GrB7Plu3s0LiQblCoRJ8TpGXc8fZiaNQbqvUDZ/niVbr/lY+UKmdwqz2?=
 =?us-ascii?Q?WF5e+5o6+T8DPFeEPgzY9f5PpB+Kf8cEhBoCof73rICtJPcm4pswzJw4l+0S?=
 =?us-ascii?Q?tgkiU6NuB85y0Gvvm8SvCjb0oVwxxqJQMPdUxsbPuO35jiZUmhUo6hOR3QD8?=
 =?us-ascii?Q?BcpocbewWzp60WORS96bPEcXFXL98Pm+A38nZORT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4685c7b-0105-4b6f-abc3-08dd504731cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:08:06.6998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h51Z5c39L0o1h7VeY9PVFAXJf4HiEvLlpisUrmKukM6IriAEPOHzoEaJKmFkU1gz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905

On Tue, Feb 18, 2025 at 09:47:50AM -0800, Nicolin Chen wrote:
> I think we can do:
> 	if (!list_empty(list)) {
> 		struct iommufd_vevent *next;
> 
> 		next = list_first_entry(list, struct iommufd_vevent, node);
> 		if (next == &veventq->overflow) {
> 			/* Make a copy of the overflow node for copy_to_user */
> 			vevent = kzalloc(sizeof(*vevent), GFP_ATOMIC);
> 			if (!vevent)
> 				goto out_unlock;
> 		}
> 		list_del(&next->node);
> 		if (vevent)
> 			memcpy(vevent, next, sizeof(*vevent));
> 		else
> 			vevent = next;
> 	}

That looks right

> > > +int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
> > > +{
> > > +	struct iommu_veventq_alloc *cmd = ucmd->cmd;
> > > +	struct iommufd_veventq *veventq;
> > > +	struct iommufd_viommu *viommu;
> > > +	int fdno;
> > > +	int rc;
> > > +
> > > +	if (cmd->flags || cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
> > > +		return -EOPNOTSUPP;
> > > +	if (!cmd->veventq_depth)
> > > +		return -EINVAL;
> > 
> > Check __reserved for 0 too
> 
> Kevin is suggesting a 32-bit flag field, so I think we can drop
> the __reserved in that case.

Those are different structs?

Jason

