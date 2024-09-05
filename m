Return-Path: <linux-kselftest+bounces-17277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB3896DEF8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74B3280FC7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F9C19DF75;
	Thu,  5 Sep 2024 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mw2JRD0/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA519D8A3;
	Thu,  5 Sep 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551700; cv=fail; b=fMlDIx8thVU1ed7nRPQ1lbWUhX6rNLkmT1Oktq3T0dGRtY/tbjDgeRqR16KPT+XxPPDX6vS1N23Pt1Bfod+TThYObN1phAqPPQBokEByLCcNmPvSVRJmD17YzP2xkOmrgGmOQgsTwxUeP5HAULfbGqhQoNwPS6nD0vcanruuBfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551700; c=relaxed/simple;
	bh=8LHqs4csygKIY1+tOJrCpb8MNjvkdNO5IYriDOg7qIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ime7IJh1xGqLK6gMol/i9khgfhaso4pBd5rvnrs0f4CfbX5ApXc/8zkMZIDlWqPw1c7J3o9ceG74J/NUEIayXPtHEmidhvkdp5W+1nFsbu/PCvS8uw/vPgDTiDodLvTAACmn1+D4jgbjP+GjTSvUpOowONS17OIGO8YTyq3UyYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mw2JRD0/; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9i/qviSgudXZCvPvDeCULWbgoz630DLUwzm7rMrEkyOIf0GzHtky4e1MVNWVnw2gXiBHXZ8vgWglI1VUhSE5a3OnIpeTvfhiLZJm5z4bp/bGLbDk4RBZs8K46lwcAKMRYM0kZ0XvtarRtrvLyT/Z2rclv0jh4r6U1SJ/MXLo9tRQEVeLFtBsqFP9oGlNdTcCAxSKlQ1njlX3pqBix1RJpEMKfk3fBA7P88jK+n12F3nfumwxLzYKj0LpKPay2Y2ggcAjWv0dmBpkFQm5IXjUrGsrRk6VfEeqQcAn3ehT3SK7GNY+Fhc20cY4Xt0/3Bu6VuNZsLtYaJhepDSlf78qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzk7/q87eAFvTyNzRrYnBuQT+d8TO/9zVo/OYOJoxJQ=;
 b=eiBKNy1mCS6vhdj2AmrcfJWWOoQPm12nzZuwQLiFCUXbQPOeOXUyXo0K9+5uTjGzYDzzaOFgGYa2Ll8BcaRiTjXQiQA3jFEKloVVCiMkIanDG+rSLPS4JEqgfPZocBEqMvK4BB/XGRHmdMyaghRufAlnKaqm66EYkf98QB2v+WIP52isnVM4NVPLhzU8K0N3Lit54nd/dZBB7rQgYMvLzGvjffyynT96xz/X/RR4ApKB9qPs4nGortY8Q9fps9r9xWoT8zk/WfqJm0IZZUxalgFMOzssLYiEUvUz1GJkaBX5hzk25yp5232Wa5MXq0HH0Z5pBwg1b8HhaGRPDi3Bmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzk7/q87eAFvTyNzRrYnBuQT+d8TO/9zVo/OYOJoxJQ=;
 b=Mw2JRD0/3QoOQhnKEP3ikyRHFqw+4+8E04saqRPIFR65e5uHkR4bdKJCBtTneKtUHag4oIJSPZxauKtK3dk29wHisQx4fYoMwlXXYdb/tD5qKdrEdzjvX1o2L4TaMfx3ylLrmxWOM+KXDS9pOoIsSTCYDOye3ETSXpioHkKwhPwHyvnTcVBxseLOL1LzvDrxgztJ4ae9jLNFPd2vxp5m1XL9+o+/zebgsH8gZzdvPt9B2crqpH19XyquhoPUdq2jKyCV34Xe75lSssdTV+Xv04WeaS5oidvRS/zP0WD9WFBo1YEUaKolP/n+Q/lp1N9JBgBhq3jGTLbE5lZHcSCHJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 15:54:56 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:54:56 +0000
Date: Thu, 5 Sep 2024 12:54:54 -0300
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
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 03/19] iommu: Pass in a viommu pointer to
 domain_alloc_user op
Message-ID: <20240905155454.GN1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <d6f9be955372adbee1e53621d349acde0c79aad4.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f9be955372adbee1e53621d349acde0c79aad4.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:408:e8::7) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 028f6ab9-5d23-48a6-ff63-08dccdc3167e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?916zF35rpzEt8WIrFcDQowGPrhzE6mhTN3N6J/yK/E6miGyKy3d8CPUjN5Dv?=
 =?us-ascii?Q?uvDs3SZB+90+qviMUvsCI0pc7QtUFyVfpPGoUcMcxaSD58HYkdLaW1H3K0uD?=
 =?us-ascii?Q?zd574Z/MsLC8732XPFAEARleIbcs55hotfbDzZKEhT6peqJPplk/etgUuG3R?=
 =?us-ascii?Q?5oTPNrfVkUVgQLupMTURln9v8pr39uCiayxozi5BJiT9/y9J7EgN7cU4gDqj?=
 =?us-ascii?Q?0HfP42UCR3sHL7xsU+D0PFxImdMZhfZJ0+UrkxZzWteE1s/dSFPvmdPRRZkk?=
 =?us-ascii?Q?UxcQv6XNgfGNoCw6mHhvWbnodhPWEtBRV54BnQWx2i077AX7G0DHG9939zlY?=
 =?us-ascii?Q?JjWZfu3zqRR/MJWSyvr6QxmfK8SDyM2FqO7Oj8Q3zNg5EPT1WKBEqvlrE4Lg?=
 =?us-ascii?Q?crRHvLCVGgc4wpnAVKvWepJGlUoUSjLHFxLaLMPKoR7bI9+IsFJUYQGy3I94?=
 =?us-ascii?Q?OSukWkpKufEO4orhmOKFmE2tRmELDveCcqPirA/2gTXXotFcRC/TITEt6Hk9?=
 =?us-ascii?Q?sHUcPoaay6Sobk6NMLJ2CXLAGlvwjeh3t60FGX2E9chqJyebZZC2sIleFaT9?=
 =?us-ascii?Q?HDIVAdwuLmqFcAOl6PQe7TVCy4V9JShFOuaZ+nFgAarAetBag609tApJhrdX?=
 =?us-ascii?Q?Qf4BeG+F3QAyj8G/i8iAVmQtBZP7lgUuNBG8JWiCnu0hwdknGmJ4bKFiGfpi?=
 =?us-ascii?Q?ajStx8SIWzmKaQe1Sk6B6PY6ib1kAB0zIbRURBSlm6u2032765HhxoYQdFrO?=
 =?us-ascii?Q?JtQAL5OIYNCi9uCMr8crayUqV4qO0xVLbqh3lFHQmAom8xZd+9k7AnyGcd0Y?=
 =?us-ascii?Q?6MICU+eMx02nduG6ciYPO8dQ54uE1X9vsDT2PhWx9lbdUR+v8G7m0TVR4Eto?=
 =?us-ascii?Q?JAPxPu2mdo9N+SLzqzAVhQIWZ3gEnysepbsYSBj+jdIXoOT9PbZE138g83lH?=
 =?us-ascii?Q?oFcA6GPR2zEqC5xGyCu2fDQYMROhsKNF/YS6Na/IguEPosGnlNOA9iAzjpHv?=
 =?us-ascii?Q?8xc6p/5GUoTarok29DtDnIogusdB9uGbXmLHhniZLDc4Pt8egcNaKNf1Xcmo?=
 =?us-ascii?Q?RRpuxTOUUVXC0CB4SAUhaJLttjHWxFgFOLAaVq85siSheJG34/OGj05k3lbp?=
 =?us-ascii?Q?aHkzUlrFsAQ0Owr3Q/UykYUwiqNzbtA9kiC5rgZlhtW39xXc/snyLRzixNJS?=
 =?us-ascii?Q?uDGbPWIo/ykDv9Etvc6mZ7xpRQnoQEXOtmZzao1HnhQxWl0q+LvmE2U0GRFs?=
 =?us-ascii?Q?jOV4rlrtVzn24H4sWqWkKUH3iukiWGk1RJb+LdPjSc9XlJzX14tu0sN5wv2F?=
 =?us-ascii?Q?i5MI+e6LDYzrxipt7cTdZEQ3ftabFZkzYK8HsLXpk3kwFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KrMS0j/Lt1ZuJSrszOkp16BM+Wdlm4LfzhDlxf+WGnK23xYC4gH7jIKXGCgX?=
 =?us-ascii?Q?PqQwSLts8siCfKk0st22cjqyniWyGcUTQHrRjkaYrUHA9cATAxGl51WyQiwc?=
 =?us-ascii?Q?sWw1XOD3F2Wheln1WPQlnWaSJdQYcGcvs772vR6bMZ25zJL0XP7pSVxh7ELp?=
 =?us-ascii?Q?B0hHffx0iJkH58TaQSZA57HaETOzLxYqephH470Pmov1Tt2zAyCIq562PU+2?=
 =?us-ascii?Q?V/p+QJhO5xAVoGoYCYO5XLWlLziLssT7OedfqLp7/ynIAQPa4ogSksLXww2i?=
 =?us-ascii?Q?1w2tuMUW0nU9+2TreF25kg+YfN2BCzRXwEzJxeWDnzpcVDYbk6awZQS44oyO?=
 =?us-ascii?Q?mxE7i4+7wekkPxmtOseor4FUQybczz4CRLZmdfcyp7FCcFWw2DDJypcdEeFm?=
 =?us-ascii?Q?cR39Xqk/BYvhZUaOxEow+jE72UYLfzcViup9JZyUg2fBAZhtRhWaByqhu8sU?=
 =?us-ascii?Q?lKcMi+U32fmUyh2tXJey5Mpc4schawsuS4H6RtIokob4iPV+L6y/6/bOTbBv?=
 =?us-ascii?Q?tWx+4RaHHBiWF8BdS3QhUDymrP2tWIPc6h/1bhKILmxz3LIf1BEY6HQgoeRl?=
 =?us-ascii?Q?RZbgpLL+2eAVgEe5mDZD+crAqOYn7PVXx3dRzjEaC0z6ZIiE+0wOpXReZsLl?=
 =?us-ascii?Q?WWkSTspZ+Ry4YimtDrcInqNiZ3QCwl6kJ70RdfHqQ9ohev02uLihB/P3u01B?=
 =?us-ascii?Q?YIDB4MguICxuWYwSdhfZkHblFbxNXKUpYUnLYN5+sQHqmP1IlkSO8hc3VxfB?=
 =?us-ascii?Q?FmOeT1YgXuqhie3JDUBrz9NWaIWe/JAos94GdytQImvL73ZjA/U7M3vLadH6?=
 =?us-ascii?Q?yuYCXcLMFIic7/rBojfF+TfPou3UKH3FkOvYsvRkEI6nJ71nZVQoClXxl2lL?=
 =?us-ascii?Q?j5ISXakVb9Mum3QaSSj83uDYW8tioT7R2C7vsGfo9doVdnInT8qIAk7sGcs+?=
 =?us-ascii?Q?rUVOtRDyZOjQSkUFxP791HbDGC0ojk1p3Icwu7tOTmbwJxHCPDqVSTeZBWha?=
 =?us-ascii?Q?4mLy93Z0fx64Tz65/EXK5LXaw+rg0S0TBrtRMeSKdNEQyhzBSlraG9ABkyYB?=
 =?us-ascii?Q?jkD3cxNUkqWlqtSh/rXSkp5oBlYY96axNLNzQRgK0ZM9xWpGsxoxW0kkyF4L?=
 =?us-ascii?Q?PFxbg4Ncnq68BDJ00bkUiSvFBGPGXmSp8hToKqSWNqgGQGLiW2fsPQ6ATiVe?=
 =?us-ascii?Q?DoyoUYYGGEH2aaxSiCNnM5N/xk0EGGz2SqZdMznsPNFfQc7Hh3ggipx99/TT?=
 =?us-ascii?Q?vyJE8NT9Dl9qfDsGsNlRkO09Ia00C4L2/KcMrGzDDOqs36kZll8B7SOMGlKS?=
 =?us-ascii?Q?iKGShbVckIuG8/HqaEFmNhaSwZKWShKHiB5GwOkkJM9qnd2yZ94WBNuGhKWq?=
 =?us-ascii?Q?uy354jp0jhMTzzwYQYGu3h9eA2ozBet/ttDKImdz6L70d5FNeSlTbngswczq?=
 =?us-ascii?Q?J1Kyj++5+stoS+LlxpWCbh0GcZuWMaqjhHcUOQu86O83wmsu5MaK2y+akYOB?=
 =?us-ascii?Q?en40AhYzfZ6KF+hu8MR8rkjk3/5Oh0dG8auLdlXdEX9jR/9gUUzmA/hVWj0Y?=
 =?us-ascii?Q?fjx/En6Khk0ynEQ8D9zzVt8fjz43LYzbRYM+IlPM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028f6ab9-5d23-48a6-ff63-08dccdc3167e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:54:56.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdrOGHfNLiKwrXzkD33i9wx2DbL6m6YjXqDfKvKbCKJgpj0vwkeleWm7qMUMuiPy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071

On Tue, Aug 27, 2024 at 09:59:40AM -0700, Nicolin Chen wrote:
> With a viommu object wrapping a potentially shareable S2 domain, a nested
> domain should be allocated by associating to a viommu instead. Driver can
> store this viommu pointer somewhere, so as to later use it calling viommu
> helpers for virtual device ID lookup and viommu invalidation.
> 
> For drivers without a viommu support, keep the parent domain input, which
> should be just viommu->hwpt->common.domain otherwise.

I've been thinking of add an op for nested allocation since every
driver immediately jumps to a special function for nested allocation
anyhow without sharing any code.

Adding a new parameter that is nested only seems like a good point to
try to do that..

Jason

