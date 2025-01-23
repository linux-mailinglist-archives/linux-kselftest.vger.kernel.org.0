Return-Path: <linux-kselftest+bounces-25002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56964A1A52D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 14:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950CE1889178
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F42211464;
	Thu, 23 Jan 2025 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ckWq1ZTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855021018D;
	Thu, 23 Jan 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639752; cv=fail; b=FwwGQ+PCATglGZh1IGO5EN/3YzO/RuYppmVsFOiuFmDVFDi54q8KgZSKC578boRXjtnncydzYKxRgRjeJpZP9mct/hucPTXlo8WZVEFZND4DpXR6zJeaZ4DYmi7zdC0nYqkMeP+oT3ipxZlq7kGojE5Xk1wM21VAMlys8gp4BCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639752; c=relaxed/simple;
	bh=HanO+Zcst3+B9ytBqmG0WAb5viMS6Yh3fggjCLQfj+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aijt4EMi/ekOJyfL0CAtgCzomPdxvUkA6MNc8TANoiYIwHBMqtproUR1zD6r4qXcKzvqL0XlWHgWvI/3B0/SIoJ+8+CZHNd561Q4438pQlxuo8WmtpyQd9uYuX1lZRvLjsGCGv9Wm7I7YBn6hqiRmtxaNmiBAN41xqWIDGQFhfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ckWq1ZTZ; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8lP8CV5k+sZd+g7CPj1sk6exolJM2zztyLRdHnkVdlY1wAuVed1LH40OfwlJQfKhbv2s+6cK84ppDgdFixIWJ5kDuUKHMHceMoox5xE45ossMD1/Hv6a4oyk/9/UL7FNfkEyL6CMwyZJ3w4y7mcIcIwkM3V6jgS96Ggb1Ce/yvZyUmmlK+le0zCNEmqTAQF/m3UpUiGdENKguk11FVOiSJ/p91FjrTc75fBLbEYCV7cu43L8G4iGp61/4DytYrXX4aZvBCarXZZGDvMabdCFuxYwNjaApAJiapJpEG//Lflr8scjZ9RcwBzRY/L+Ujcvr46vAnWBIIOrEMFOwzsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUGch3vPqFbwnj2tUWVTi2tqRZ1yFDaf7B+D8HbJvpw=;
 b=dQi2uAxleFRL1VClxOyFBd2XzO4Yr6o2pk0QhWOL7fr/fsECUpEeLt9XHbxFwRkfUqM4RYEhd1foVcZdsIRW9cUQkG9YrjD+LT5P2eyc4rCp1xWk6ymnjoCw4VwJv8aUCPEB7eDqBUcAI66ub8gABlpk/xNitzfq3W3IdxoSNT2CF3QJM6jpOdSguStg6Tea6/dU3aK+kPIYdafBxhCTVUuKsWumw3XZ7+HX5CnF6LF3mqo2ipcDlS7h4Il57EBFNRUcqCSvHZSoENWzrforQ43NiWJNEXOxMp3uXIiSRieCjTcp5+CiiV8hbl5JpWkxu4VE8Qh4iAjHvs8RF6fuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUGch3vPqFbwnj2tUWVTi2tqRZ1yFDaf7B+D8HbJvpw=;
 b=ckWq1ZTZQSsgfTR+3GS4Vjh119lK4cX32yxva9SUwGmetvwKOYfvEQf/F9iWoA+K0q4swI9udFKOsQFcxIB7gWJvkcdBAhvwHbb6LqOVqlwV6DEVj7djt3KoGulqxAz0pLTFQIc7siHx2/r+1Gkty1yE0d7YI9H6ArahibGsLhU1h/BKzr0neWPdsImmg7E5ZjHo3JhCDTumFcWBFuJNimLsfTGLCRlrLJmAc/Xn6HIN23Q2uM7MeL2B35CBYo0IRWMuex8SyojMHWGYhAcsUmTANrULTPA8jhxHUBeI5P6CCZH9He1Ilzd8QvSj3r54+7GIO7jz+fBaDl0mtoOJEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Thu, 23 Jan
 2025 13:42:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Thu, 23 Jan 2025
 13:42:27 +0000
Date: Thu, 23 Jan 2025 09:42:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250123134226.GO5556@nvidia.com>
References: <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com>
 <20250121200924.GZ5556@nvidia.com>
 <Z5ALWFVTOSC/8+ji@nvidia.com>
 <20250121211404.GB5556@nvidia.com>
 <Z5AUNVHzJPATVqAY@nvidia.com>
 <20250122002128.GC5556@nvidia.com>
 <Z5CbGKYbwy+qPjyh@nvidia.com>
 <BN9PR11MB527600A5B8DC271075936A918CE12@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z5FNDOqkiPq90c16@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5FNDOqkiPq90c16@nvidia.com>
X-ClientProxiedBy: MN2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:208:120::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f74521-38e6-4fe5-9f70-08dd3bb3c670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hkQw+SiKk+9wn1k6K1wLHAr12fitfThXoTdIFYyCsxx728XIhehI3zQP4rk5?=
 =?us-ascii?Q?GrV4gPh2lG8LZJAKc8AHtjEisp8tCBNA0BYBC+cKFy1X3e5mBeMwzR/vGL/d?=
 =?us-ascii?Q?lV6xCI20KDT3BhyhugUVFMQJvGXZwe321hmSUrB3akMqsB2mT0thLu8jH/PD?=
 =?us-ascii?Q?qMkV8RK1KGtQBUUw23d1LemsGVe7F76Mke3RVbQPkby7gCdndj42OnLwnR0m?=
 =?us-ascii?Q?Lv0Gz0Amd3RdrizWhdQBdw5+dozNeZUx3kBaDs9EeIYoAZ14kt5TK+AOf51i?=
 =?us-ascii?Q?bKmpSmQ06JiHgoQVtBjeMcuTrNI09KCFkjKLSvT9thrfNDEPROQjdNtBzy76?=
 =?us-ascii?Q?Lnl4nRoHsHiOQHP0flc7f6xa6jzgzjGoc1+y8Fs2Gg12+bzHvpXEy0IHY/3m?=
 =?us-ascii?Q?edYIp1QkeVYHbfFgKwvqNdr+XUeYEaF64n+y3x53FZMvekimTvBqMLqXdmj7?=
 =?us-ascii?Q?naM2o3GJur/uwUHaejfAJihFXNL7tIjlx61INfbfuxfItn6bydulNGLwUmzm?=
 =?us-ascii?Q?JESeailcQfVkYfB+JGNSkuAaJl/bb0TbdlPBeqBkM0oLP4GQJ7N/zTXsqO4C?=
 =?us-ascii?Q?QShlsksff99kX4ByHjB4I4MofRmoLH0QgsHSUf9DWDBWkM2cDIB4dyDUS5ug?=
 =?us-ascii?Q?baC+JuInkphVTGK5QXZPV0nOV/4PYtovtW1yHj12Zf+li41T8zdK+TRmb2YK?=
 =?us-ascii?Q?roliEqJr7bp0GidU/TuCsvutUlLHGFcI81mTj0QY7n8Bu6YUz61c80+EiTTi?=
 =?us-ascii?Q?QqhTClEVQa4+yjit6WXRyXTqIesBhcPdlcgw8Y9gaL2+JjBkqlaBhY/X0A0w?=
 =?us-ascii?Q?Zykv0hcHqJXXQ8Worn8iOa8/cpDPvJnAsK6QPIVCi3/9Zc5PP8iAMCWP8q34?=
 =?us-ascii?Q?JLD0iQyr+EApwMhyVDB+75pYQisY7pY0lT79VufXi7Gd92P1LkwVoQdM3Ggz?=
 =?us-ascii?Q?W2YkLsGj1AfYcZ8cyu6O/sFwZug3Jjyq4JXet1L6PwjcrscFeUqEfO+Sb7or?=
 =?us-ascii?Q?Gm7Ww22J1rOdzwA9FG2vGtsmcifjwFkMs61rHfT1wgtwV7fiB11ps15+ggi+?=
 =?us-ascii?Q?ZxP3dV7ioc2vK2q22HF0zIn6ZHZjIkpH5eJbjC1X0fD32PdsQq+4PqeLbgry?=
 =?us-ascii?Q?4j8dINbcIiFE1ZMOoV46c1r8Nqt1o/eQOXcaggj3c7Wcb7n815h+nawIsVpq?=
 =?us-ascii?Q?ZYFxVi9UxkGPaioJ3NFGw5CsfqAz5wSs5k8wVay3N5qMCJ1M1PhUUuLRliAT?=
 =?us-ascii?Q?TJTQVRho63+opyzCnoPo3HLYJjHvyzwbayRE5oDK8ikAOo8FOcBmjBXpI/x9?=
 =?us-ascii?Q?LtRoxlpL1hKmOZax4GpLQ8QTlnOu8jLBmRuoZ2VHpzXQ2db7NuExlAee1Asg?=
 =?us-ascii?Q?gQFvVk8EF45q4/RMn5tBVFJcfDBe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uebmAnfpF6jwrM1VX1ztD7t7d9KWoYY07QC1HFvbG7AL795mU5NCnleno+VI?=
 =?us-ascii?Q?YkRP+txBuQW8b+1CZtNS+QWhK+1DPsClBLeFOQ/83ZzUTtFD9nQbdu9P+u1e?=
 =?us-ascii?Q?ggRdtVq/o0w5u/iCOmVSMyeB267EyTrzUKvSA+3geoK/Lab6Xccdqferi9Hd?=
 =?us-ascii?Q?Wp5d2RQNXrLcxw8qqfG9/dfxKsIlxpkmM/D3gpYaKlRdcXCEuNEcs66VN9pO?=
 =?us-ascii?Q?HHy4fAywB7QyQh6Yph5b9HttCEGkRH2ucxKjQiLWAnRNeRhvPhFOUMBNPPWI?=
 =?us-ascii?Q?EOUK3PRIQPtr1JKvDGZtf0q5wqW2Hl57MmOtbdgIkQ6mMXUiZgRlM8Yo3+vi?=
 =?us-ascii?Q?cWPtye0K8CZOEP9/iP3yuCYKuARBohjTb58QT7WFuYPVkcvucAea3zqJiehY?=
 =?us-ascii?Q?oSM58EPR83dRi+1DBS0NcS/gJ7LXC/sA2MmpMyJ0DaJLeUf1qPkT6SevgcdP?=
 =?us-ascii?Q?tz9i3R1ThXgIhjyxVGKc/Je4XjcogZt0b3XId8qflvtpqBScu3N3OrfuaZYz?=
 =?us-ascii?Q?NpXrtBgpvUSwUFN1iyQ/FW6xPU3Sfz/0my5Nr0Z+GYftr0MZ5/4d3Wpqz7AC?=
 =?us-ascii?Q?Za5AGgBJNU0I/mGPZUWOKhjG/kIB/r3WWEvglMGSREfk7L40oZLBx6vPDLUB?=
 =?us-ascii?Q?LP4khoAfm+/3oOn+HauiF/F7x6klOIWJv9d3fiLUZZQV4oMdYRCzzDHszz51?=
 =?us-ascii?Q?xaeJpt10jHgyrP9Y6s4UT7N9faRcxmNMO4hOQF8ep02efDBplvylQQ4MNGxd?=
 =?us-ascii?Q?+fSqAazsPglyhNYvJjNR6v5t7EsX/jvbW2LFQRYE2f+N0L0sbuHb6BI5lsqe?=
 =?us-ascii?Q?Yh2VDQKypqbX0QnPVdt8j7/PX9HkoQnZEaz34VqoJSjutQGA/N1zvOH753wf?=
 =?us-ascii?Q?Sp4hbw0YlfXOvzf/5IaBBt0/TvQdxTycJA3Dbbv9RYS5ACQ3Iyh83ugQQ/8S?=
 =?us-ascii?Q?Ram4CzNtpu1BwotJs+ztkq5so300uo/APRm2v6ox19qAGOGXHln7P7SdH8T6?=
 =?us-ascii?Q?cndUbSEqXCC3LlEZaFfQUGvxxgrCMpi2KEUkB8VinaXAw99qvMLzWBJqcWRz?=
 =?us-ascii?Q?CiCNETQolGubnwMAo7frKdPyJ81jJ13JI2ivVWW6wReGyrMDdmaT4pX8HpsA?=
 =?us-ascii?Q?/fHbSiHVLPeT+4RnW49uQKDuGPiDPnvw1l0FW/vr0ymNzsS8/dExR09Zzmwq?=
 =?us-ascii?Q?jDeFrek4U24Ywq74x4wqize0Ah25wLS+xPRMqfNl7ZuswxJRsuqP8gaOl/90?=
 =?us-ascii?Q?VRSKvQA1395oDtnc4OV8oIxJXrM7UOK+vHAwnkJOQ7ohhr9rw0cIFCwtPWA9?=
 =?us-ascii?Q?Df7ZsLoxjRoGIh/VNYVzkasHr3vLP2rmrsgJxEviuTMUxAGR0xmtc4OvuBnE?=
 =?us-ascii?Q?SfwfUQ1Oe8muH+M/5jgwbmmTUBR20IuCC3u+Qlbeow7r1fz+lqzZ4Qi5CHoD?=
 =?us-ascii?Q?Y5N91fUKunrqXSiA49YXaSFhIyAF+r9mJDvg2AjwhvJhzwCMVuSrSuLVzeHm?=
 =?us-ascii?Q?keHi+TpZjOmOGllaZ11ys9g4DHZVr7PGkDaoOcaRIMxOTq4OBktMAouBDAav?=
 =?us-ascii?Q?OPw1AH1MicIXGQje/SNPTq6LQwm8aW+cgJDE9qhj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f74521-38e6-4fe5-9f70-08dd3bb3c670
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 13:42:27.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ci3ihd5n9pBte2N/abOaAWRcRvaeVCuvW44mEOxl4y4yr7RrsK2FQqao1U4cMFW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252

On Wed, Jan 22, 2025 at 11:54:52AM -0800, Nicolin Chen wrote:

> ARM seems to also have an interesting event merging feature:
>  STE.MEV, bit [83]
>  Merge Events arising from terminated transactions from this stream.
>    0b0 Do not merge similar fault records
>    0b1 Permit similar fault records to be merged
>  The SMMU might be able to reduce the usage of the Event queue by
>  coalescing fault records that share the same page granule of address,
>  access type and SubstreamID.
>    Setting MEV == 1 does not guarantee that faults will be coalesced.
>    Setting MEV == 0 causes a physical SMMU to prevent coalescing of
>    fault records, however, a hypervisor might not honour this setting
>    if it deems a guest to be too verbose.
>  Note: Software must expect, and be able to deal with, coalesced fault
>  records even when MEV == 0.
> 
> Yet, the driver doesn't seem to care setting it at this moment.

Yeah, we will eventually need to implement whatever DOS mitigations
are included in the IOMMU architectures..

I think DOS testing the event architecture should be part of the
testing/qualification.

It should be quite easy to make a DOS spammer using VFIO in userspace
in the VM to test it with the mlx5 vfio driver.. (though you need VFIO
to work in a VM which RMR will prevent, but that can be hacked around
I guess)

Jason

