Return-Path: <linux-kselftest+bounces-32569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80818AADF60
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B464981D0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B883A280036;
	Wed,  7 May 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNhH1n0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257721AA1D5;
	Wed,  7 May 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621417; cv=fail; b=P0/BEp3ySmnQVXE/BpbR9B/12qCsf8ZIHx20DCRjFMQ/C9QNqCYhUqNq6XPM6TJEiiqkRMzMlln4EYcOtbOuKyp847No88IFWheMZKtS95i21bcM7lkPLVB+OuSxIAexwaI1IEwQQQicZK9hMdsX+S23QOeuVgQz8y/8YZkLTJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621417; c=relaxed/simple;
	bh=4NPpUWHxXMcRzdTLDEidOn2peoNMnfMlf/RpJj5qsQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cjc6luzQvYWLbbmBX4KIKoM2hSN6VVJoLFCLozHgpo97QkwuCzSLUAkjpYNnl54EVT45hN8RdaesCZsL7RNmokxk/AHSANwaQmsc6vJFWpr+CQH176Pfb3XVIkMkP5MzxzkgTIVEplSwgoygrW/Y0RqEtyKULcSrbjfbOeckHss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rNhH1n0S; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPDOc4bJPxhu8gxVlaGA8y+IIhzPqF4nCDRDuibum0RvtqWqN3iXe4QGuOAqnupoV/3nfZkoS314xkX6C82Ajmzmxejo21NcMj0I8335yKPQy3xqQa5RrFgVCqQC0y+ht1x0KO9BS4hSlLZFAcMBkmVOQrUdjECeM6hdZaalWM0uAyxR9/e3UOBbJ3l9MytqHWxL8jie3Fnm/iIHiWRsavZ0fS42ICG7XZVh4d46AhXc+3h5PShhjfZiCDE55alAG2ooi1HR1DYtoDuIYmsMFJNqdbocRqgBVqLMuH1x0vhoDa8dAnYkKbdqX68JHfxUtCDM3PyLg3KrwWw61hPpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NPpUWHxXMcRzdTLDEidOn2peoNMnfMlf/RpJj5qsQE=;
 b=mpsGJF8lKMiKeZ6Vz2mjye7r4zrngZgpeTxiCgb9l+C5fFQTIr0/ips6Oxd1WxbVR9U+NO5WSRlG0G6MdRH5Rc9a0Wlofq040tplDwmZq5RHwc0AA55+CGsg5RqNkSLL1jaOBMepf3ljsoyvdmhmmRNMV2IDxpp3m5QsWzCvXDgjXNup7Nir1dB6Gthen+Fn5u9fUEiylPs1Ij3frTU4GkTDga+tAfrjVWx/mO0oRM3z7QLhVuVn2/HABSGv7JXFZwrfDMFF82s54wcq+MfUNgCIeIlnCe27nS/fX44xpVlvAYCgATGAONSRQDX5fTxbvtelDaP95syxs+FqaBUE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NPpUWHxXMcRzdTLDEidOn2peoNMnfMlf/RpJj5qsQE=;
 b=rNhH1n0S5WOLbRocNsQXH8EbbkcjEF8Dk1XiRg3xZAxj4jOI/ldDYccWTdFa2xJo4dn/iS/cqjKVJXJejoIR6FnOj6hxR/z2mbAQYKZumOOeK8Yr/NEJPfZg5iw5i9EjSc1sNoqraeoGwSCjzJJF5uA3Wbj+K8SzPL1Pjz7X7om186O2o9IUSXMihleVWZ3EDg7N/EwQCPSiuNF94MIrqOzT1Eb2sA9bZ6uaHlot9t+n4axQl50WRzxjGFHKnhvkCb7fDt2F3bzBbm1klh+G41XlCbVAAFoqPfdrUC3WDHbjhLlBwxY40P22QsoG65obcUkft/YKeNS2OSuQeHVhDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 12:36:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:36:49 +0000
Date: Wed, 7 May 2025 09:36:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250507123648.GE90261@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
 <20250505165019.GM2260709@nvidia.com>
 <aBjzf9PrYnwF5uZN@nvidia.com>
 <20250505172813.GS2260709@nvidia.com>
 <aBkahmXQGxFC0Fdw@nvidia.com>
 <20250506125425.GX2260709@nvidia.com>
 <aBp28sjZpPfDUfYr@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBp28sjZpPfDUfYr@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0382.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd96539-a62b-4c67-0b57-08dd8d63d629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tiei9IiZniv16c8C4LvE0rRW5mMQHj2jkC53lAANOaAYjcd1OAt/gxJLNJV5?=
 =?us-ascii?Q?hPidWjVr/E3N04khDvF3W6M4hciv1EhWTaEal8yTPm6QAanBvqnUKLiVklRS?=
 =?us-ascii?Q?NbBoDTXKyOmAFlO2gfxcJNjDKno4hi7JwqdG1BVCCK5CdN+JqxULmeULH1cT?=
 =?us-ascii?Q?5Hlx6YbMr3xwYZjwBceP+EJUZzsmfl7aPS2NQI1rjVKf9EgmWOkBerA35SEB?=
 =?us-ascii?Q?o/4aN0qIlTXAGhhuVhuUyuVTtpIwKi16CK28t/CojNYmSXpbWgFyxFeR24mC?=
 =?us-ascii?Q?e2EnV5kBT9DwrfadzZtEJhhKTC3ResWZaWRIMlmt1u4xB2vxAJFaBiLdK+VN?=
 =?us-ascii?Q?GzdEgAs7YPXiffegj/CGh2ZwMlvoIaTj45X0d1d2COHqxRKOVHtZqkw+0QjF?=
 =?us-ascii?Q?iXgFrusLb8KcpSn8sNtGoObiRsgCJ+q7t+IebIRy4+xbtVd5KXyk/uH3bhNO?=
 =?us-ascii?Q?CTDh3ZCUS9loN4p496IozskIirzaq0IfUteTCVKMEJitSo84y1aPpDQZFtNj?=
 =?us-ascii?Q?4ux8wFl8pkdNUbdg7VTxUAbaCw+dMWHy2pCyIqmGsfNfa+AKAQZnAO1nq0QD?=
 =?us-ascii?Q?NKlC3gc9ZjCyJ7ahvDZuopufdxcMIm5/DDtPx44MgJvBz3JEifgmFz26Ns3Z?=
 =?us-ascii?Q?3ZzjlaR2KTr4Qbrrv5G8k1d5/RUqteh8PRJP1jXBhZU2fFqLejji/yRFw8Dt?=
 =?us-ascii?Q?KD/UnKrDKHTKix0zB7WQu3Rettt5YlEJRtIKZa6c0qrqKTa/yoIXtSu1AqEW?=
 =?us-ascii?Q?umQ4Lu+Ih4FGvClai01qJX/Jsy7/SkRNE0+p4/MrHEURhgmxpQFfzaye+Pzz?=
 =?us-ascii?Q?FgVIJf7Nqb9MWNnA2syIADSoaFyc6khCstXWgVNxT6JQdROWUOOnESmLi4fx?=
 =?us-ascii?Q?vchuhBDq/Ah/lNA/+nzLiOOMPyjX1adYJ6OMxt8LWLfT+K2A20x1E0nTwCNv?=
 =?us-ascii?Q?E/ABzks79Hi4YGWHe0zFE9wYjiKCvYhZLy3egjyqjTHy21waexNfn3HIIrOV?=
 =?us-ascii?Q?JWgKDTIBvULMjMQSD+7SQCKXD3yb5ymyLyshjvQzFTrpxdN3unqBqO5pFSTj?=
 =?us-ascii?Q?sx1WfPm0LXH/2g7l0M0HPohd91xMnGrrvNO86rBVDzYOt7N1oDr43vs8qoR1?=
 =?us-ascii?Q?P5u8kflqEpeLBJLGiQzFgAughDi1uMmbMoXGwhw2N4bX9H8vJJXf3TjOtcOL?=
 =?us-ascii?Q?1JWMoOvYf6smNdZZiwi7ZrGY07kEJlFYhu3dPKrYD4W1lHeCs+SiCO2V0k4I?=
 =?us-ascii?Q?aJfe9ldvF3UlthEhJI84hywB01drtWGStkVH4S5SbnRn04ayRC3iS+5i1Rdd?=
 =?us-ascii?Q?HWX4IlKNWQ2DOoFCZ+KzizZ8xjDxnpTwAYHEbqEI51EHt9QYRWyfTCEoT/yM?=
 =?us-ascii?Q?RE1jl5l+lJFsGo2QlhOntHWIz1Xkeyrh5/D2EWNegYUK5x+twkgaKodg+dQD?=
 =?us-ascii?Q?GHFfKFRzIfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h4Gk2neSgX8nyfiMVqV1iwm4FDA5MEY3JOzGDOSFA7phnk3DnJn/U+8S/SY4?=
 =?us-ascii?Q?mFigiHZWSzwXd0BnnP2xUxP1PfwZjnthzshmgzXC7Qe11Wye//iHppjRXvYV?=
 =?us-ascii?Q?Hc65XTumKy2Z5piDjzGd9bbNqQvqskkrX91YsGGfO9ZhQsr7/JZezJ4/zHGk?=
 =?us-ascii?Q?5M+7R8gnCRBA0T218nK4opoeelewf9Z0OZ1+GOgfV7iwOxZqpRNkMyzA5+6o?=
 =?us-ascii?Q?I5BTX5EY6oja9CRFmUaa0WY/0lwvjSQawq8RZuuHQ2mOPF8Z7Q023PCSYNyM?=
 =?us-ascii?Q?EoYZE8+cLXfLg3sJT3fkbrBFDBC7zSRX3UTOIrZ/tzanwEGcmD0Tq9lR4UL3?=
 =?us-ascii?Q?iffzRq8/RPJ3xmkvxaGsejWCCus0Lan9VolQMqCdSUU4kYvvyqctYCfR8ZiH?=
 =?us-ascii?Q?v7ypi0c9gpAPSORi+qULPY544ugDLj/h7uP+T2BNj/C3UfzmkpBe1mQjmzdQ?=
 =?us-ascii?Q?OeseU6iDaCiLO19A0EjipqzvIbRSLVv4x4lx4GYcvcvG9YnmaRvBYLwgLbDh?=
 =?us-ascii?Q?yXH01hLCLWMNDiSOAXu+aMjzbdF4t5DptOgmtss6LfV1oQ3S3Jhnjn7hqH9u?=
 =?us-ascii?Q?2pjCJCVBdgoevr+OywGqTP77WtEcSy8vdICdbW7/3gbsjYaaik49NuG5wsGh?=
 =?us-ascii?Q?WgEHqyGWl+dAaEzdNhVk2cEX+dXW7/lop35iAp0RMY/dqVBqht91I38Q406n?=
 =?us-ascii?Q?bK+h0kF7dWSXXAw4B9qWcp9jB1mvmnyAbWfvN8cwHOjoJziDDs38Det/xQTJ?=
 =?us-ascii?Q?ZDCCRnADnx3U6SHpTlTf6yHE/37w2ehFMr0FfSGZ6UuR/Rck0J6/IVNE6iY6?=
 =?us-ascii?Q?8hI5qZHBJfBOgqVe8OmqiMWA5sHKfc7N2EQDSB3oE787z+adUI8ICR2a+LCK?=
 =?us-ascii?Q?NzAwKl0rDiGjxtjwt7slhkFKFPCzqNc/s8ylc/o5/mif7nMZHjSLNeMChJGd?=
 =?us-ascii?Q?SYs0JX+h17wm41Gqy8OMUyEg4ERfHjSd7z3rACZLdHyHvaRa3otv0WhC9Zpf?=
 =?us-ascii?Q?PRD5DX9bGZNTFWGi/I+e9aQscHtU7BY0DKJhBM68RtDVo0eHOCsZ/Z4vM2aO?=
 =?us-ascii?Q?dm7qRY9U5B24Qzr/nzrVDYdOYm1NRhYnwsjuWvDFdbwW4Es7cHnE0MdP4ETb?=
 =?us-ascii?Q?1pkMxJ/7KJqmnBvbX/ZDaLqHScfhZFNxTVacurLxypjk1I/rhhNy7n8Ac2FL?=
 =?us-ascii?Q?4s4s6vimY26FRTZ6kbkI75u/mvDTf7ezagY4u3NrQEDQ2tNj+zFVB0oJ5brN?=
 =?us-ascii?Q?a8NzoPYuC2dZEIO6yMfftjCUqqXyGU7RZUd5QKRd1rJHpYj0GmDVl1ZU92Ps?=
 =?us-ascii?Q?MY23JB3UOkHlpdBV5/3ZRVVAn0Z4DQ4AZ3UqeBNS4mx7YTuyr1nYM3ysHEgu?=
 =?us-ascii?Q?HwNaiYn5AZ129gccQqukls0Yr2bgLSJayl37q1cB/KMDdft7SR0BSNPEz+F2?=
 =?us-ascii?Q?W5x6cJ2+oJNDg50Xeb2H42BmQ4d+bcTf7cRY29l6yo49x54r/8Glfnz2w/lN?=
 =?us-ascii?Q?1zIOVTpTaTxhd1L3HkLEX2xSdb4Q/ww2bY7Q2gCAVF5gyrqTIj7whxGpMugI?=
 =?us-ascii?Q?eRQRuNfwMcAsKYPDNIHHgEFiwK9hT3Q9eRKWQDTw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd96539-a62b-4c67-0b57-08dd8d63d629
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:36:49.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOCmVnC2OgRAaZWghQLQYzvQzzenQbapyecQTzaBmhDzamGyjAevoKcpKe9gSEq9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642

On Tue, May 06, 2025 at 01:54:10PM -0700, Nicolin Chen wrote:

> Now I start to think about the FD situation: either a fault queue or
> an eventq returns an FD and holds a refcount on the event object. So
> the event object can't be destroyed unless the FD is released first.
> Are we doing it incorrectly here?

Not necessarily, and maybe that is a good point that we are already
doing these cross dependencies. But we could fix the FDs with some
work too.

> I see! It just needs to call that function when we remove the mmap
> for a vIOMMU destroy().

It is a little fussy to setup the inode as well, but yes.

The other small advantage is you don't need to setup a special VMA ops
and do VMA tracking to hold the refcount on the vqueue object.

But there is also any annoying race with unmap in setting up the mmap
PFNs which is why vfio is doing it from a fault handler..

So maybe refcount is the simplest option for now. We could fix it
later and it won't prevent close() from working right.

Jason

