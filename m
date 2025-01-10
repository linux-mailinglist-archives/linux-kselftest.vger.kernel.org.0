Return-Path: <linux-kselftest+bounces-24237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCFEA09C10
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 20:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255C67A2D75
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B964214A65;
	Fri, 10 Jan 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nNe41dNh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B50213E62;
	Fri, 10 Jan 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736538681; cv=fail; b=taI4CXBtzr+mH3vmqbMs8Gy1pzT1VL9JsywKzbp5SnmkYgAJh+p1HS7UTmoKyo+BAfUf+k2qMBmMGJGy+fNajZjuGoHlOXk2nB/eDd5CeorT99q99KSZ0M69cEuKVAFVhD2wK/H1REDD4+drCRNYRm1vEK1MySuTvqHNSx6v+D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736538681; c=relaxed/simple;
	bh=KOiM9/7LqzYxH8OghWPqR5RFH46kfYy6LeXt+6hofgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QRHM8PhrhdemyLz93Atn/weEuFqNc+wnb+wQ3nBlNBJE8c/Z70Lpap3Z64zRd0puP6TmysAqEIsRR+5weKpgPB7zwbnaUO7HdqOxdddpxsP2Eu0lF4gJzIi/kI9GXLuoOyDxQ6mYIehf9JKK/k0Vc47opGOUi9/aae4mkVq/xwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nNe41dNh; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfXdo3stWGpEoAHlUU6Ishvp81bVKjVwl/e7N87h60E8SC5I5ma05/QhY561rGAGUsBrMfAvE5aHAwW8TkjiUm2SqU7n5NXJCDCBl5JnT3ENejrrlGZOVGvNcm6WnR1RsPgpugcaaMF6fItllxfyOBNw5EYzadaYsPTNUNzQVnJHH6UOF13GbWouCVhUVN5CAf16HZey8DEfRliGWw0Wo6NfSKuDQ5jhaCjG8g/16tAX/xv6Ubpz+1rCb93N2hUsQZsfOzeANDzhcYaz7lbVcPJZHtVtB8I+6BEOZ7DaWwUSChwKE/ZT5Irgn9RiKMlWETcofM8c+FLYu+uaUG18pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm345WGH2FxDPSIUL8hMJMlduiNEXtWuyBXlsjcm4bo=;
 b=OpKNMSy9iokvIJpDMXG8fcg62AhU38+14b/xx9HBKOtHDB5xVnYCXfab8gDSH1jLtTD3m4OyO2C/27DWLSay42EcJMUmDyog1/hvN53+qM6qSEQeg4ZL20NSK6lrc2/zJlN1YPd8krzJ8enfY8PpnwsbSn6ZNCH6VXGD2OeGwDYQGfVahn1s/I4iQ71hu9Ie0z+2z42+5/gEiYH4M49MtiVuUr7ER3DU0Ue5saK0TSaOt2xjbgzb/NmCaFHf9oJC0O4wKMMTylnQffkSC8EiqV8HHkbdkWytoDYQwXcaq/FS7sS+t4G1D+4AhU9OzF1ubUAlD2sX/EtzVQ2WR3qr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm345WGH2FxDPSIUL8hMJMlduiNEXtWuyBXlsjcm4bo=;
 b=nNe41dNhyC8XYSQ74Wzzdpg81Mcy3YfDW6vtoFvislN6AJ9NdUAadYdunDl5oNTi2xQbGF/vIPDe34XhPap06ffVZFQYPNDTcn0h0Ar7F4NKGUhv9Ry5IQDCqNIEI0YegApSaJhpIqvBpIOyQ7S9FiKG0bnjOrd3KKokZZ+ymRu3F8dJ15IJ481U30DVorpbLcK9H7drQiIn+6ZzN7qgbkwYck4+abRcSimsqMQgP4wXtx5Ib0PSDQ1Y21qgejgBJh1fTQ8iLjMFfyVw2OHXhZo2O03MX9rVZCie59/gouHnhbbHJle5oppkL4jpS+7vRlSnSHG7Aup0Rc5PvpOu3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 19:51:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 19:51:16 +0000
Date: Fri, 10 Jan 2025 15:51:14 -0400
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
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250110195114.GJ5556@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <20250110174132.GH396083@nvidia.com>
 <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:408:fd::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a2ac39-31c5-4e87-eae2-08dd31b024cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZZ0kQ3aXoTXbpUYM1gO0O93AIIRuZr2hLv/gwK8ZIrcQ8mKblWksa/ZPnImn?=
 =?us-ascii?Q?007/a16nEjFpKkW+5TguQAo2gva3dKprGwVcXMkcOxGACQVmgUt1MXDwUL1t?=
 =?us-ascii?Q?hV7eZHgOkj5fBW6XO+tyfWARW6qqR8Sf0QcsZjByoIlKRIZfvSRsUfeTU2sC?=
 =?us-ascii?Q?fcycHlglfUFXFNsPWxuXsRkGQ4CJ/PGtYAfFrsGAIBvvw5OQxYkwzsc5T+Ms?=
 =?us-ascii?Q?cjUF9LOuK/4PVRPsY7zsZvPL5/4ccmr599nZKwbLFD9laZztodi+4i69KOYw?=
 =?us-ascii?Q?a5I2nTNQ3NOGDbHt/9fhCgd+Fl0Sk4pof2lDG7Het0SduFrwo7AAcL9AQNhS?=
 =?us-ascii?Q?TUhbcGOzBUWTIm1mXF4puFlBOzp2pDraV455em31JYCXQdjYrxFpKs39LDsV?=
 =?us-ascii?Q?posP6ah15qg8F85huRc0JhahLMJ7Q6o0MPS5Jf9C3oF/CyDk3Gh3/Mvsm9Hw?=
 =?us-ascii?Q?l1MpgPReXs6rJKdjUG78cWClsRm/8y1DLpIrtxvnDoNvWRCXfz1/mKRI3UAC?=
 =?us-ascii?Q?HrUlhRf8X2zx/Arg8wQ1539OLx6cJDbtXrPikWHKo6D9dV8Uv85ASXD/ffus?=
 =?us-ascii?Q?znNlCds3GSg6wUaSLn/z/cqIKUbqGJtxG3b3PmEjfcAX7z+3Jwlxb72ETq8+?=
 =?us-ascii?Q?hTFZ5NlK6nZhFCQkI5Tudn7sEJ90XDa65itefvmGPQA7+ox8h1g1oGTG5Bv7?=
 =?us-ascii?Q?GyRF7G+lBQKjYTbRoXmk3csZz/MQ2WqjfhYGH5Q49CWLI67yrc/P+V2v8rt7?=
 =?us-ascii?Q?GJ47DmTWDY6A/jQcFyiArOTkwkcZphZEXl0+JMUIxp6iVBfpk6Cly113mRCs?=
 =?us-ascii?Q?zlqposgLaK8nAvyDowvh/cB9hl3oDd0tmkUkVE+eFTiiKXKVdtdJaPr9VmQB?=
 =?us-ascii?Q?Jq26ZFWung8Hmyd9GTbec3SeK3MNx5z1cdF6Jer5gsfbBJiXxfyPxGoxrXDh?=
 =?us-ascii?Q?NDvHAWTIUrcLhbJ7XcQ5BM0ightU3EjrxCf59pPKpsXADt4Fb7ZRzKUARw/6?=
 =?us-ascii?Q?aeUjsfi8OqQG96wf6svyWwZyWzAv/j0aHgxkSGGx5Pugs9DAAkQmIlRs9fhb?=
 =?us-ascii?Q?W6ELCNFCHnG1+BfUjxdyk6JcsE2iUwRKQ7ffYJDJajxxnMItSfRM3pek4Fmb?=
 =?us-ascii?Q?QAVBfHsJ+H2RnG8IRWfNtFUyAYBbEqb/3TvACfg3KA+nk1EdRTw1F1DyuHW/?=
 =?us-ascii?Q?XyYsod5RuRycUQMTJjRbd+k60RuHc7g7WeuiTY302wIO9OagOChGCA3WQbHN?=
 =?us-ascii?Q?dwyvY91FwA18u8nc+LpVy9L7JYnPwgE4ue8oFLu7e+duC61vh+A4oR9Kmp76?=
 =?us-ascii?Q?e/kIKVZ2VGxYuXVJd8cCKtxUaf+65IdmbZbMfJzYWaCY1yFtnUrg28V4I845?=
 =?us-ascii?Q?Kpx9g46maQaJzuD7b3Nqr1mqOs+2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/U/4T66PgFDL5j0uxrw5IVsg3jLCeloWO0M7eW93WHzi5r8TgUSJnVQb+rx?=
 =?us-ascii?Q?jw037og1FG50hwgvFhjfRmnBHZRSW6m+rqYnPxa+QRC5QUIMKWxgfUABNkaY?=
 =?us-ascii?Q?AuQmgI2/gFBTsCUVICgErefAYtBUatD3Vu24+tWlpsPeja2p1LJzSXvj0jOf?=
 =?us-ascii?Q?YtLh6BJ39PakNmgdadV3vFBwkreZNfgL1qht9ameXV/gU+L++a0XSRUHiGUj?=
 =?us-ascii?Q?hxJ876YXRWzpwknSdwojqM2p9EbGvu67waqR1bEHi+55p8sLpufJOt4EB1iL?=
 =?us-ascii?Q?18BsyOB5lDIwBX2V/frRuB6wvhGT5DlDdomRBquu7jPYDMxH8feA+DL4TGKR?=
 =?us-ascii?Q?gfqmZKzHo98tyHWwytnelpny1o11yhZ4eZLFoLEkkLCQSpPXYUwGlGnuzJ01?=
 =?us-ascii?Q?epyPS124b15v3wSNFZJplI9I92lP2rwLk6jKPWnCju8YwDhbuEincHxTi6ze?=
 =?us-ascii?Q?NaGUjCrRO2Y2UkjOV35dym5yWCbBsiieOKTCkCTnEYEQ55ZTlG8WFpCH3LQL?=
 =?us-ascii?Q?P1oF4tRuL/1hVNuseMxnteSH9QZkvnkZrjAGHNr66KNRsTUysVDgWCwjwH4U?=
 =?us-ascii?Q?++/k9TGdKdwoEfk/zhXhsZA/HsRhRvH9mGS7328S5+fGbLDdKfMPa/AMlMwn?=
 =?us-ascii?Q?yw1+82w5eEhTFa00ikIQu2GUZs5hJ2tGJc8aDy4ujszSnCDYR8u7ypTj0bxy?=
 =?us-ascii?Q?7LJAdhpuRUfFnarwgmLi0WwEKpHxp8IkqNCDrjjiNuvxrxQZN//6L7qnKTla?=
 =?us-ascii?Q?/HFOUGWNbH8NK88ugY0stGfAuOd9li1JrA3EKOZ/bBuYxWYbVIQtisME7giw?=
 =?us-ascii?Q?ATIBYJegVtW/O2QRHN1QxnUOKk8EVPVjXOXi501vXBl6Q48i21Rt9DbWFKS2?=
 =?us-ascii?Q?k9ouKjhL3mng6MFy99Wx3DmrO8uc26vhsUGgYhPpT6d1wkN65Mc1nWxb3LKE?=
 =?us-ascii?Q?ne38nBDVLJZL/8mhF3tFCN60B/JVFicXdBYMo3QFedLPN53md8HrlbKoVonG?=
 =?us-ascii?Q?dfMI9FaBI3u14cPoax6KMgmXGYkDa18hARXJ6t60CeT5yrNWRuPK18b4nTP5?=
 =?us-ascii?Q?UJbYUNHbwXkk5Tp+Csvc2vjSmlsvziVn5xWJlV6qFrzMUSIZPAr3zfJJeeu2?=
 =?us-ascii?Q?7f7OA8M3UdVh66jBuo2vqQoVCv0lE4R+Bv1yTZZgt6AsDBShA+DLwHcvIsTH?=
 =?us-ascii?Q?+GlhzNGmRBcv0Jt3nLU3VaB8wLtqukt6iFgRt0euytnX2PLz1goZhqqV8qwY?=
 =?us-ascii?Q?cSFUGX8k5VvXPc7Qv3uGytePynk20AKo5+EV2SJm9DhrhHSuU5KouB3A2ZCH?=
 =?us-ascii?Q?Yzu0v/ZU3fG0u8OomGxtqoEhQPvke9hJ/1dwFCrBT8YldZh/2IusFh6uJyrO?=
 =?us-ascii?Q?NnDscmdo4uMRbmVxr4XPhEAawpSdXfh0RUqOK6xSG6D9JnMsFRLFjckQmcLJ?=
 =?us-ascii?Q?wvituZiWA2J6fJ09chiHQN75Y9TFGmmpb54mXmUJQ8WXDWgSCxpz3R5RaLgm?=
 =?us-ascii?Q?NDKgPOiiOXamTW7NKxFdbhfN7bdVZdzYq7bAXBmfcdp79be3Trp3hZuWwRhm?=
 =?us-ascii?Q?HWXvusCEuQqrlsr66/Bk5mHQCYH2FLhnurOrIiV9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a2ac39-31c5-4e87-eae2-08dd31b024cc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:51:15.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KM/aE2/VHM1BVncU4i2at0KeFA4yhfbQWnR/RkVpdRuAkvHlm85BNwxXRfaBpd7R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

On Fri, Jan 10, 2025 at 10:38:42AM -0800, Nicolin Chen wrote:
> > The virtual event queue should behave the same as if the physical
> > event queue overflows, and that logic should be in the smmu driver -
> > this should return some Exxx to indicate the queue is filled.
> 
> Hmm, the driver only screams...
> 
> static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> {
> [...]
> 		/*
> 		 * Not much we can do on overflow, so scream and pretend we're
> 		 * trying harder.
> 		 */
> 		if (queue_sync_prod_in(q) == -EOVERFLOW)
> 			dev_err(smmu->dev, "EVTQ overflow detected -- events lost\n");

Well it must know from the HW somehow that the overflow has happened??

> > I supposed we will need a way to indicate lost events to userspace on
> > top of this?
> 
> Perhaps another u32 flag in the arm_smmuv3_vevent struct to report
> an overflow. That said, what userspace/VMM will need to do with it?

Trigger the above code in the VM somehow?

Jason

