Return-Path: <linux-kselftest+bounces-35136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A0ADB873
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B511890343
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3122728981A;
	Mon, 16 Jun 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WE3MARsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8D289349;
	Mon, 16 Jun 2025 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097200; cv=fail; b=l9vSSrc9SrvIPqzQmSJvGdOJ6Ntf8xczHG7wRM3t0VuVmioeuXkboE3+GU8eptUIoEE5fefNjwgrGbYvH+anphi7KXJq7dR/jYes8eicSp72tJi09DKZWGRhMx143qedJmKmZxtYNXj8gBWSFgcdp38uLt32Dau51y+uxsTxjCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097200; c=relaxed/simple;
	bh=cCD8QiVcWTSag7s8OHnmOZwA8d6pEGUPgkmyzOqLyGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ley/+s1n2bB1BOxEA1i0QIWw8G9eR7LDX92MZgZMC3shUZuyGL1T/n6siaz4hJkY9CwQds8GC68ZLSvq+qXCQl5M2fy4xkzeVdzu7+XvaYVvvZo3frHR404f3DOZqy7K44XMtNsEo++cLe3AWPumpDRD/6cUpLJbfx5f6lKfclM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WE3MARsD; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smfoY+pF+sZH83cF16AD/8CvZO7Yfl27/Ec+jNOWYzJlOksvVslH9Z5D1g7RllVmhJMJZtP2gynWL4O81hnY3hWIgke2PkuKSAQ0DqR0TtjmqU2J5DYFBqIpwPMLKIujuoutGwDfvzjXycg8zb7TbVnCmF6vTMmEto+BkAKxEEO7fPvIqwMPEuGJn08RmDkMSvyuw44IMUKkY2DraqyJwf0VTh2cEeFlVFapnW4LPNYB9wPDHZNuQQRXrEVOWXlKKGytHObxjmNDKOT/r/S0LoE+FbbV35T87yy6h1jUM7TbA0oy6QVmt6TDW0HC48NyUYH4G4Tzyun5K3pLqCyc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0A893A1rjih4d31EMWk+QRN02rqEfHHi6remt8e0xY=;
 b=vaoRLUEKPAwKPZitIIkA9GEGfSktheqcBoIruloVI87hEEnwXWfumppZAcCzMaaCadt4lxmWXZ75+szmrUarbnMbwHVNaLNtohdWJNwpewFsaxif9H3KMNqYw3b85RWC0JdbSAqiNJh59vxYlpKRuNZy4iAUV9OyYuMqMiLuX/llfOR789rOmE8eMS2v6cQTcwOjG0Mgaw19FZNTDR7BNaprZEicO7tyDdEg2+L82zFAFEEJr3gGf4+duCVEknj+Hio1A3EX/hayN7nVjBuNFsf9RfPMpZXbMyKkLr183CdkcKJohJB54S0OWC5gSSdW9mjNQ00n1y3TdbdaHZDSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0A893A1rjih4d31EMWk+QRN02rqEfHHi6remt8e0xY=;
 b=WE3MARsDf1/vXuX+ayurvpA+bCMVZZW0CJ6j2jfcmn03g0B4zXUXpFXb0h2NF0rXaHWeZ9evopCzUOHnP1xIQ0j4UDw6ijo1FH1wY/sx2WxYUIVg9gpu1/ys66QrVkghIMd3RMVWPMbix7rEXkxxvPld35vTGEkYQ6ihBce3aI51RE0tPYKf8sqU50RhK0ZDQCSvmIB0MWun+oTkxnTvFvNdeGc99LR56GTHC8luS2cWpZ8fdZqlwn0dS+alrYZn6n1hKp5OMwq0FuTZnHQXaRwc0eaQD45CzrCalgaMNWXvfyXHbn0YJPBUFUlhTxUdvi574o4gurHEvA+NTDL91w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 18:06:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:25 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v3 04/15] iommupt: Add the AMD IOMMU v1 page table format
Date: Mon, 16 Jun 2025 15:06:07 -0300
Message-ID: <4-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fcd62c-aad3-46ca-5e78-08ddad008046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5NKK0sDDwys5n1vCgl0cMLXBrjY47GUqjOR905LSM9F28vt7x3GXLQs/tV5o?=
 =?us-ascii?Q?qHjw3gsetmJaWzP2Bq63n/YPy4jcRrSq9hKFDLHGpb8AGz22rvBANv1VtI5J?=
 =?us-ascii?Q?GWMWqYPXEYSXrpPHtTKQ/7Q1CUiQEeTfAwmBQ0IQ5GtZMPEbMWCtpI2SmcZE?=
 =?us-ascii?Q?j9oDcr0mzgofBHuMkgIm7TYlK+mdaa+RCqNmj2sy+zadwUM+RrBUh65+vlym?=
 =?us-ascii?Q?j8oT2NJlQLkk7GygGFkDmk1+KR1peQD7EgHZ9IUJLpbOEWs+oC3H4+IZ4HEW?=
 =?us-ascii?Q?lZD4A1vAshn3Iz5B6gb1l/CGgV2Ct9d+cP2no8qMYLmb/TN9zadPvDpZzVb8?=
 =?us-ascii?Q?c1+MBaTkMJRmgw+P/PiD/eWULlMVZ5sjuCcbW2fb0Q8RIFec54/R1ombq+vv?=
 =?us-ascii?Q?WKBsRLyYNWXfkE7g2rmt0njkDtoEanynMAza8UizEcGoeMqGubHJ8vRjZKM0?=
 =?us-ascii?Q?V6Mwr/UBvUBNojCnOGjh3LNvVIemCAvnsLvdvar0TQZjFntVtGW97iyu1Cs9?=
 =?us-ascii?Q?D1en158QaRt7l9j3d6gSfqji1iBNcQ2GX4wRyxUFLrSs9HLO8uLsC483x39b?=
 =?us-ascii?Q?Qjygl5qrG6A5s1ZOscrT2pyQOdNf9oB8wc6hNczPW5wXY/eNk/RR5HURFGNw?=
 =?us-ascii?Q?ogMKAY5rlP5Edv1fFb3qvT1ywhbxgzmzXYHafoVwJhQHw86ZhvH7lI0sC1rB?=
 =?us-ascii?Q?4M5tA8cSxKc3pbUp0kcufG2Ay7zDg7/M5S9hAdv3Eyz+3MTiesn4MNzXwaSj?=
 =?us-ascii?Q?WKIs//DHImAWyOpzZWAXhXw+a+TqNIbpmVshke/d3odFt0N8foGRN4PjKaXD?=
 =?us-ascii?Q?ZIRn9FVMuKVedX9BX8pNj8sccMwu8pEBYMqz2fZi7iB6zIHC0gNy59IxPmR7?=
 =?us-ascii?Q?W+rYJEieNuO6AQhtJ0fHF/fCxfmevHoXNYWP3qJIFfcNpH2T821JRKp91Dga?=
 =?us-ascii?Q?TGQCV7HAaDgUjKNVI1T/gwB/4K6UBtKetLv88A716QdEc9XdLedXVw988w2O?=
 =?us-ascii?Q?J5oOTj/56eaNw2yFvZ/nuZVCOhtrZcsa3A9xte6EpxuOLGfZaBD6eTBUp18E?=
 =?us-ascii?Q?/D9cij0TUaz/qfkblq6UFin1/2VnjA8rAkZV/q2EZmBzNG5P+ddSLVncKvKp?=
 =?us-ascii?Q?ErqeDQE9C/TfBh3oNkIAk2omdiCJ9KqLe/x6JXW1Uic65RqPunXfZUU9DoMY?=
 =?us-ascii?Q?2TNJ8lRxmhMG6/GxY9/ZSNgaKQPpdgwEZ4VWi+FmYKJQBvGdGLbtC9Dj6JRN?=
 =?us-ascii?Q?+01Gu+hruHu6eTSMArkLtiy3qCA/cREm3NxZnR0rCkZPUPQnwUibPc4e0XPU?=
 =?us-ascii?Q?Lg6MH8QmMfMMRlMWzW2O2peZN3/tqsOmgmqj4dWdL/bp+A0GHK+n+VgWhXfJ?=
 =?us-ascii?Q?gbjPtH7RXxnZjx74tBh8+vMt83uLK1u6LggodoaVL976xmIJk1VlHLWHdf7d?=
 =?us-ascii?Q?ixfHWSIwIWFYXhtsKCGe8rq+jQESU+XcEYPhxbb3W1vp0ltH48G+4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRRhBS/91pDKtbTjFKLX8UbRAyw0g/nMCiwcT7GPRIwcbtkqEyWjswKcC+j9?=
 =?us-ascii?Q?d0soBAqp55K3nI3btFBb2Wvg9+7vUvariyVFjiv3mbQ6p4ObFf0JpXmGtcQv?=
 =?us-ascii?Q?/VYU178e9+nSSRMrBwvzVvPipeEZ4vDvT9/OLXYen+bp2siWCmqNnByHayDa?=
 =?us-ascii?Q?Mv6l+9Nk3SWZ/bGrMDug4tPywWcxXIM/4zbmcqgXRGwKhq8fCccz1ZXQ25ol?=
 =?us-ascii?Q?rw8GFFf7usskYR27BZL+a5joW8l6om3kYQPyR47HwacNTDZf9yp4SiqNY1J1?=
 =?us-ascii?Q?MC0mMpSjQGhtnvIIqqCDDz54qqejFsJnWblZqOtNnRySd1XceNxx6d7aedpS?=
 =?us-ascii?Q?fiPd7o3PYbWbYWvAXZNPVUaXBImC/w2UizaUYu4JFbV7S5/1yklrc1/2jZFi?=
 =?us-ascii?Q?jrjUsQV4pcxY0O7Aid6GepBMtkQFaat63p7uigZfcFrRi4MjshUm5dgtDYcq?=
 =?us-ascii?Q?T4CEExBnd5uavE2KuKsZN0qRhEii/c3C0+MQyjRFWB47C/I9xt2VFVuyUI4s?=
 =?us-ascii?Q?E/IaV8w8CYj4KU3EWnW7zouWs73NhkqW1OyCtCXXLnKy7mS9IC27vTI48GAL?=
 =?us-ascii?Q?nRVOlWUecbs9CmIbWeRrArHbozXFw7qn6CWK4MKeLDjSGhtfxY84i8Mf2Zb9?=
 =?us-ascii?Q?aYDRCLR4M4SnXzC7wJsaI72dak22UPDBVvoVWbsu4vncq8RNdnKkQ3efiCqV?=
 =?us-ascii?Q?Eb4aFHNnqZNw0M/EseiolDqWRUrs9hLfLDkLwyAgLAUO4ce5yNafV4+THrHm?=
 =?us-ascii?Q?UCuaysrpuQQW7VhIY2jYaf1mYycJvTJdpvkuRQ/xnYlD8e+CVhz6aX23ODTb?=
 =?us-ascii?Q?PYyGfrY4GodNT42Ksn5oEuDLrDQ4gwqgoQ4d9tSMpP4PYPxcbD7oV3Dl8ynH?=
 =?us-ascii?Q?Tkw6JcN786EKIZTrjIfHwCoOse2iKnrianTaTGGYWmYlZ2tLeyrm5ALqouIp?=
 =?us-ascii?Q?MgfWUT1i7YSFBeP2seHzsn2Zt/KHlgBryfBlgQpe4uaVbLmYrVJgHHUHe1dR?=
 =?us-ascii?Q?ZL2XtzgnbnpYjakeXPRpvTVeyLlh4bLTu6FO1n/9+3VhT/WyYiJLCsb12fZU?=
 =?us-ascii?Q?j/oM+u/YcYOnqa8Ya8cRA7N2wVvFqslQpzM8Bmjgj+Dewm3PTAvVtYGWVPZM?=
 =?us-ascii?Q?TykdimI5lCnHUqAjFPWYLjsaUmp3NQYsqYI6/MtkHlNaxpSotrXZ8fcqTjf+?=
 =?us-ascii?Q?vlfhJDGU9rDBPqJGslrOWRZca/6E+P6goomRnv+19g48/OfSD62ZT7BV2xcP?=
 =?us-ascii?Q?ZMTBWPoGf2mvyA+A5hnFYQHdlJivXz1EZ666U7i4JwSlmpcJwNhqMBvEwLuB?=
 =?us-ascii?Q?UyKN0qBQbJFXYdPn9K0yzLEEOzg+yULFdUpEWuCv+dvgqu6NL3nRpQU03TYf?=
 =?us-ascii?Q?V6tMMAVsxnm9U92DmCVHPJU8FCagAJLo4HWIXAu1zhHo5Uxh5QFFKwpW+8K8?=
 =?us-ascii?Q?3C0mqiunLKY3Me1jRUn3TJjpbJgRPwfrHjKjZ3G6fzo0slIfOn+99/EJJKsM?=
 =?us-ascii?Q?Oarw1IYU6sP2pdY3lL9CsbD3KsTahWVaAQyy9r1Kw/zmup2z+YU5cNxb78Tm?=
 =?us-ascii?Q?54Ph5eXVLy7aKhkByl92I6OanyLNETZaF3UxDMg5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fcd62c-aad3-46ca-5e78-08ddad008046
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:22.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3F4N/rOKripv7tiEuaKFyfXYAzNiLb8vS/0mMGgY8VEQv+FqTdQR0AY9t1XuvB0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

AMD IOMMU v1 is unique in supporting contiguous pages with a variable size
and it can decode the full 64 bit VA space. Unlike other x86 page tables
this explicitly does not do sign extension as part of allowing the entire
64 bit VA space to be supported.

The general design is quite similar to the x86 PAE format, except with a
6th level and quite different PTE encoding.

This format is the only one that uses the PT_FEAT_DYNAMIC_TOP feature in
the existing code as the existing AMDv1 code starts out with a 3 level
table and adds levels on the fly if more IOVA is needed.

Comparing the performance of several operations to the existing version:

iommu_map()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     65,64    ,      62,61      ,  -1.01
     2^13,     70,66    ,      67,62      ,  -8.08
     2^14,     73,69    ,      71,65      ,  -9.09
     2^15,     78,75    ,      75,71      ,  -5.05
     2^16,     89,89    ,      86,84      ,  -2.02
     2^17,    128,121   ,     124,112     , -10.10
     2^18,    175,175   ,     170,163     ,  -4.04
     2^19,    264,306   ,     261,279     ,   6.06
     2^20,    444,525   ,     438,489     ,  10.10
     2^21,     60,62    ,      58,59      ,   1.01
 256*2^12,    381,1833  ,     367,1795    ,  79.79
 256*2^21,    375,1623  ,     356,1555    ,  77.77
 256*2^30,    356,1338  ,     349,1277    ,  72.72

iommu_unmap()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     76,89    ,      71,86      ,  17.17
     2^13,     79,89    ,      75,86      ,  12.12
     2^14,     78,90    ,      74,86      ,  13.13
     2^15,     82,89    ,      74,86      ,  13.13
     2^16,     79,89    ,      74,86      ,  13.13
     2^17,     81,89    ,      77,87      ,  11.11
     2^18,     90,92    ,      87,89      ,   2.02
     2^19,     91,93    ,      88,90      ,   2.02
     2^20,     96,95    ,      91,92      ,   1.01
     2^21,     72,88    ,      68,85      ,  20.20
 256*2^12,    372,6583  ,     364,6251    ,  94.94
 256*2^21,    398,6032  ,     392,5758    ,  93.93
 256*2^30,    396,5665  ,     389,5258    ,  92.92

The ~5-17x speedup when working with mutli-PTE map/unmaps is because the
AMD implementation rewalks the entire table on every new PTE while this
version retains its position. The same speedup will be seen with dirtys as
well.

The old implementation triggers a compiler optimization that ends up
generating a "rep stos" memset for contiguous PTEs. Since AMD can have
contiguous PTEs that span 2Kbytes of table this is a huge win compared to
a normal movq loop. It is why the unmap side has a fairly flat runtime as
the contiguous PTE sides increases. This version makes it explicit with a
memset64() call.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/Makefile                     |   1 +
 drivers/iommu/generic_pt/Kconfig           |  13 +
 drivers/iommu/generic_pt/fmt/Makefile      |  11 +
 drivers/iommu/generic_pt/fmt/amdv1.h       | 385 +++++++++++++++++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c |  15 +
 include/linux/generic_pt/common.h          |  19 +
 include/linux/generic_pt/iommu.h           |  29 ++
 8 files changed, 494 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
 create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 355294fa9033f3..b17ef9818759be 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -3,6 +3,7 @@ obj-y += arm/ iommufd/
 obj-$(CONFIG_AMD_IOMMU) += amd/
 obj-$(CONFIG_INTEL_IOMMU) += intel/
 obj-$(CONFIG_RISCV_IOMMU) += riscv/
+obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index 73b7a54375f9bd..887c585a66699a 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -32,4 +32,17 @@ config IOMMU_PT
 	  IOMMU_PT provides an implementation of the page table operations
 	  related struct iommu_domain using GENERIC_PT to abstract the page
 	  table format.
+
+if IOMMU_PT
+config IOMMU_PT_AMDV1
+	tristate "IOMMU page table for 64 bit AMD IOMMU v1"
+	depends on !GENERIC_ATOMIC64 # for cmpxchg64
+	default n
+	help
+	  iommu_domain implementation for the AMD v1 page table. AMDv1 is the
+	  "host" page table. It supports granular page sizes of almost every
+	  power of 2 and decodes an full 64 bit IOVA space.
+
+	  Selected automatically by an IOMMU driver that uses this format.
+endif
 endif
diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
new file mode 100644
index 00000000000000..a4d83b7e0cf691
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
+
+define create_format
+obj-$(2) += iommu_$(1).o
+
+endef
+
+$(eval $(foreach fmt,$(iommu_pt_fmt-y),$(call create_format,$(fmt),y)))
+$(eval $(foreach fmt,$(iommu_pt_fmt-m),$(call create_format,$(fmt),m)))
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
new file mode 100644
index 00000000000000..901fc4a80e9a83
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -0,0 +1,385 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * AMD IOMMU v1 page table
+ *
+ * This is described in Section "2.2.3 I/O Page Tables for Host Translations"
+ * of the "AMD I/O Virtualization Technology (IOMMU) Specification"
+ *
+ * Note the level numbering here matches the core code, so level 0 is the same
+ * as mode 1.
+ *
+ */
+#ifndef __GENERIC_PT_FMT_AMDV1_H
+#define __GENERIC_PT_FMT_AMDV1_H
+
+#include "defs_amdv1.h"
+#include "../pt_defs.h"
+
+#include <asm/page.h>
+#include <linux/bitfield.h>
+#include <linux/container_of.h>
+#include <linux/mem_encrypt.h>
+#include <linux/minmax.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+enum {
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
+	PT_MAX_VA_ADDRESS_LG2 = 64,
+	PT_ITEM_WORD_SIZE = sizeof(u64),
+	PT_MAX_TOP_LEVEL = 5,
+	PT_GRANULE_LG2SZ = 12,
+	PT_TABLEMEM_LG2SZ = 12,
+
+	/* The DTE only has these bits for the top phyiscal address */
+	PT_TOP_PHYS_MASK = GENMASK_ULL(51, 12),
+};
+
+/* PTE bits */
+enum {
+	AMDV1PT_FMT_PR = BIT(0),
+	AMDV1PT_FMT_D = BIT(6),
+	AMDV1PT_FMT_NEXT_LEVEL = GENMASK_ULL(11, 9),
+	AMDV1PT_FMT_OA = GENMASK_ULL(51, 12),
+	AMDV1PT_FMT_FC = BIT_ULL(60),
+	AMDV1PT_FMT_IR = BIT_ULL(61),
+	AMDV1PT_FMT_IW = BIT_ULL(62),
+};
+
+/*
+ * gcc 13 has a bug where it thinks the output of FIELD_GET() is an enum, make
+ * these defines to avoid it.
+ */
+#define AMDV1PT_FMT_NL_DEFAULT 0
+#define AMDV1PT_FMT_NL_SIZE 7
+
+#define common_to_amdv1pt(common_ptr) \
+	container_of_const(common_ptr, struct pt_amdv1, common)
+#define to_amdv1pt(pts) common_to_amdv1pt((pts)->range->common)
+
+static inline pt_oaddr_t amdv1pt_table_pa(const struct pt_state *pts)
+{
+	return oalog2_mul(FIELD_GET(AMDV1PT_FMT_OA, pts->entry),
+			  PT_GRANULE_LG2SZ);
+}
+#define pt_table_pa amdv1pt_table_pa
+
+/* Returns the oa for the start of the contiguous entry */
+static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
+{
+	pt_oaddr_t oa = FIELD_GET(AMDV1PT_FMT_OA, pts->entry);
+
+	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) ==
+	    AMDV1PT_FMT_NL_SIZE) {
+		unsigned int sz_bits = oalog2_ffz(oa);
+
+		oa = oalog2_set_mod(oa, 0, sz_bits);
+	} else if (PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) !=
+			      AMDV1PT_FMT_NL_DEFAULT))
+		return 0;
+	return oalog2_mul(oa, PT_GRANULE_LG2SZ);
+}
+#define pt_entry_oa amdv1pt_entry_oa
+
+static inline bool amdv1pt_can_have_leaf(const struct pt_state *pts)
+{
+	/*
+	 * Table 15: Page Table Level Parameters
+	 * The top most level cannot have translation entries
+	 */
+	return pts->level < PT_MAX_TOP_LEVEL;
+}
+#define pt_can_have_leaf amdv1pt_can_have_leaf
+
+static inline unsigned int amdv1pt_table_item_lg2sz(const struct pt_state *pts)
+{
+	return PT_GRANULE_LG2SZ +
+	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE)) * pts->level;
+}
+#define pt_table_item_lg2sz amdv1pt_table_item_lg2sz
+
+static inline unsigned int
+amdv1pt_entry_num_contig_lg2(const struct pt_state *pts)
+{
+	u32 code;
+
+	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) ==
+	    AMDV1PT_FMT_NL_DEFAULT)
+		return ilog2(1);
+
+	PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) !=
+		   AMDV1PT_FMT_NL_SIZE);
+
+	/*
+	 * The contiguous size is encoded in the length of a string of 1's in
+	 * the low bits of the OA. Reverse the equation:
+	 *  code = log2_to_int(num_contig_lg2 + item_lg2sz -
+	 *              PT_GRANULE_LG2SZ - 1) - 1
+	 * Which can be expressed as:
+	 *  num_contig_lg2 = oalog2_ffz(code) + 1 -
+	 *              item_lg2sz - PT_GRANULE_LG2SZ
+	 *
+	 * Assume the bit layout is correct and remove the masking. Reorganize
+	 * the equation to move all the arithmetic before the ffz.
+	 */
+	code = pts->entry >> (__bf_shf(AMDV1PT_FMT_OA) - 1 +
+			      pt_table_item_lg2sz(pts) - PT_GRANULE_LG2SZ);
+	return log2_ffz_t(u32, code);
+}
+#define pt_entry_num_contig_lg2 amdv1pt_entry_num_contig_lg2
+
+static inline unsigned int amdv1pt_num_items_lg2(const struct pt_state *pts)
+{
+	/*
+	 * Top entry covers bits [63:57] only, this is handled through
+	 * max_vasz_lg2.
+	 */
+	if (PT_WARN_ON(pts->level == 5))
+		return 7;
+	return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64));
+}
+#define pt_num_items_lg2 amdv1pt_num_items_lg2
+
+static inline pt_vaddr_t amdv1pt_possible_sizes(const struct pt_state *pts)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+
+	if (!amdv1pt_can_have_leaf(pts))
+		return 0;
+
+	/*
+	 * Table 14: Example Page Size Encodings
+	 * Address bits 51:32 can be used to encode page sizes greater than 4
+	 * Gbytes. Address bits 63:52 are zero-extended.
+	 *
+	 * 512GB Pages are not supported due to a hardware bug.
+	 * Otherwise every power of two size is supported.
+	 */
+	return GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
+			   isz_lg2) & ~SZ_512G;
+}
+#define pt_possible_sizes amdv1pt_possible_sizes
+
+static inline enum pt_entry_type amdv1pt_load_entry_raw(struct pt_state *pts)
+{
+	const u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	unsigned int next_level;
+	u64 entry;
+
+	pts->entry = entry = READ_ONCE(*tablep);
+	if (!(entry & AMDV1PT_FMT_PR))
+		return PT_ENTRY_EMPTY;
+
+	next_level = FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry);
+	if (pts->level == 0 || next_level == AMDV1PT_FMT_NL_DEFAULT ||
+	    next_level == AMDV1PT_FMT_NL_SIZE)
+		return PT_ENTRY_OA;
+	return PT_ENTRY_TABLE;
+}
+#define pt_load_entry_raw amdv1pt_load_entry_raw
+
+static inline void
+amdv1pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
+			   unsigned int oasz_lg2,
+			   const struct pt_write_attrs *attrs)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 entry;
+
+	entry = AMDV1PT_FMT_PR |
+		FIELD_PREP(AMDV1PT_FMT_OA, log2_div(oa, PT_GRANULE_LG2SZ)) |
+		attrs->descriptor_bits;
+
+	if (oasz_lg2 == isz_lg2) {
+		entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
+				    AMDV1PT_FMT_NL_DEFAULT);
+		WRITE_ONCE(*tablep, entry);
+	} else {
+		unsigned int num_contig_lg2 = oasz_lg2 - isz_lg2;
+		u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+		entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
+				    AMDV1PT_FMT_NL_SIZE) |
+			 FIELD_PREP(AMDV1PT_FMT_OA,
+				    oalog2_to_int(oasz_lg2 - PT_GRANULE_LG2SZ -
+						  1) -
+					    1);
+
+		/* See amdv1pt_clear_entry() */
+		if (num_contig_lg2 <= ilog2(32)) {
+			for (; tablep != end; tablep++)
+				WRITE_ONCE(*tablep, entry);
+		} else {
+			memset64(tablep, entry, log2_to_int(num_contig_lg2));
+		}
+	}
+	pts->entry = entry;
+}
+#define pt_install_leaf_entry amdv1pt_install_leaf_entry
+
+static inline bool amdv1pt_install_table(struct pt_state *pts,
+					 pt_oaddr_t table_pa,
+					 const struct pt_write_attrs *attrs)
+{
+	u64 entry;
+
+	/*
+	 * IR and IW are ANDed from the table levels along with the PTE. We
+	 * always control permissions from the PTE, so always set IR and IW for
+	 * tables.
+	 */
+	entry = AMDV1PT_FMT_PR |
+		FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL, pts->level) |
+		FIELD_PREP(AMDV1PT_FMT_OA,
+			   log2_div(table_pa, PT_GRANULE_LG2SZ)) |
+		AMDV1PT_FMT_IR | AMDV1PT_FMT_IW;
+	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		entry = __sme_set(entry);
+	return pt_table_install64(pts, entry);
+}
+#define pt_install_table amdv1pt_install_table
+
+static inline void amdv1pt_attr_from_entry(const struct pt_state *pts,
+					   struct pt_write_attrs *attrs)
+{
+	attrs->descriptor_bits =
+		pts->entry & (AMDV1PT_FMT_FC | AMDV1PT_FMT_IR | AMDV1PT_FMT_IW);
+}
+#define pt_attr_from_entry amdv1pt_attr_from_entry
+
+static inline void amdv1pt_clear_entry(struct pt_state *pts,
+				       unsigned int num_contig_lg2)
+{
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	/*
+	 * gcc generates rep stos for the io-pgtable code, and this difference
+	 * can show in microbenchmarks with larger contiguous page sizes.
+	 * rep is slower for small cases.
+	 */
+	if (num_contig_lg2 <= ilog2(32)) {
+		for (; tablep != end; tablep++)
+			WRITE_ONCE(*tablep, 0);
+	} else {
+		memset64(tablep, 0, log2_to_int(num_contig_lg2));
+	}
+}
+#define pt_clear_entry amdv1pt_clear_entry
+
+static inline bool amdv1pt_entry_write_is_dirty(const struct pt_state *pts)
+{
+	unsigned int num_contig_lg2 = amdv1pt_entry_num_contig_lg2(pts);
+	u64 *tablep = pt_cur_table(pts, u64) +
+		      log2_set_mod(pts->index, 0, num_contig_lg2);
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	for (; tablep != end; tablep++)
+		if (READ_ONCE(*tablep) & AMDV1PT_FMT_D)
+			return true;
+	return false;
+}
+#define pt_entry_write_is_dirty amdv1pt_entry_write_is_dirty
+
+static inline void amdv1pt_entry_set_write_clean(struct pt_state *pts)
+{
+	unsigned int num_contig_lg2 = amdv1pt_entry_num_contig_lg2(pts);
+	u64 *tablep = pt_cur_table(pts, u64) +
+		      log2_set_mod(pts->index, 0, num_contig_lg2);
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	for (; tablep != end; tablep++)
+		WRITE_ONCE(*tablep, READ_ONCE(*tablep) & ~(u64)AMDV1PT_FMT_D);
+}
+#define pt_entry_set_write_clean amdv1pt_entry_set_write_clean
+
+static inline bool amdv1pt_entry_make_write_dirty(struct pt_state *pts)
+{
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 new = pts->entry | AMDV1PT_FMT_D;
+
+	return try_cmpxchg64(tablep, &pts->entry, new);
+}
+#define pt_entry_make_write_dirty amdv1pt_entry_make_write_dirty
+
+/* --- iommu */
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+#define pt_iommu_table pt_iommu_amdv1
+
+/* The common struct is in the per-format common struct */
+static inline struct pt_common *common_from_iommu(struct pt_iommu *iommu_table)
+{
+	return &container_of(iommu_table, struct pt_iommu_amdv1, iommu)
+			->amdpt.common;
+}
+
+static inline struct pt_iommu *iommu_from_common(struct pt_common *common)
+{
+	return &container_of(common, struct pt_iommu_amdv1, amdpt.common)->iommu;
+}
+
+static inline int amdv1pt_iommu_set_prot(struct pt_common *common,
+					 struct pt_write_attrs *attrs,
+					 unsigned int iommu_prot)
+{
+	u64 pte = 0;
+
+	if (pt_feature(common, PT_FEAT_AMDV1_FORCE_COHERENCE))
+		pte |= AMDV1PT_FMT_FC;
+	if (iommu_prot & IOMMU_READ)
+		pte |= AMDV1PT_FMT_IR;
+	if (iommu_prot & IOMMU_WRITE)
+		pte |= AMDV1PT_FMT_IW;
+
+	/*
+	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
+	 * control this. For now if the tables use sme_set then so do the ptes.
+	 */
+	if (pt_feature(common, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		pte = __sme_set(pte);
+
+	attrs->descriptor_bits = pte;
+	return 0;
+}
+#define pt_iommu_set_prot amdv1pt_iommu_set_prot
+
+static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
+					 const struct pt_iommu_amdv1_cfg *cfg)
+{
+	struct pt_amdv1 *table = &iommu_table->amdpt;
+	unsigned int max_vasz_lg2 = PT_MAX_VA_ADDRESS_LG2;
+
+	if (cfg->starting_level == 0 || cfg->starting_level > PT_MAX_TOP_LEVEL)
+		return -EINVAL;
+
+	if (!pt_feature(&table->common, PT_FEAT_DYNAMIC_TOP) &&
+	    cfg->starting_level != PT_MAX_TOP_LEVEL)
+		max_vasz_lg2 = PT_GRANULE_LG2SZ +
+			       (PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64))) *
+				       (cfg->starting_level + 1);
+
+	table->common.max_vasz_lg2 =
+		min(max_vasz_lg2, cfg->common.hw_max_vasz_lg2);
+	table->common.max_oasz_lg2 =
+		min(PT_MAX_OUTPUT_ADDRESS_LG2, cfg->common.hw_max_oasz_lg2);
+	pt_top_set_level(&table->common, cfg->starting_level);
+	return 0;
+}
+#define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
+
+static inline void
+amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
+			  const struct pt_range *top_range,
+			  struct pt_iommu_amdv1_hw_info *info)
+{
+	info->host_pt_root = virt_to_phys(top_range->top_table);
+	PT_WARN_ON(info->host_pt_root & ~PT_TOP_PHYS_MASK);
+	info->mode = top_range->top_level + 1;
+}
+#define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/defs_amdv1.h b/drivers/iommu/generic_pt/fmt/defs_amdv1.h
new file mode 100644
index 00000000000000..0b9614ca6d103c
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/defs_amdv1.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ */
+#ifndef __GENERIC_PT_FMT_DEFS_AMDV1_H
+#define __GENERIC_PT_FMT_DEFS_AMDV1_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/types.h>
+
+typedef u64 pt_vaddr_t;
+typedef u64 pt_oaddr_t;
+
+struct amdv1pt_write_attrs {
+	u64 descriptor_bits;
+	gfp_t gfp;
+};
+#define pt_write_attrs amdv1pt_write_attrs
+
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_amdv1.c b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
new file mode 100644
index 00000000000000..72a2337d0c5510
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define PT_FMT amdv1
+#define PT_SUPPORTED_FEATURES                                          \
+	(BIT(PT_FEAT_FULL_VA) | BIT(PT_FEAT_DYNAMIC_TOP) |             \
+	 BIT(PT_FEAT_FLUSH_RANGE) | BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS) | \
+	 BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |                           \
+	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
+#define PT_FORCE_ENABLED_FEATURES                                       \
+	(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) | \
+	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index 91869fad33fbdf..b127d8915d48fc 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -131,4 +131,23 @@ enum pt_features {
 	PT_FEAT_FMT_START,
 };
 
+struct pt_amdv1 {
+	struct pt_common common;
+};
+
+enum {
+	/*
+	 * The memory backing the tables is encrypted. Use __sme_set() to adjust
+	 * the page table pointers in the tree. This only works with
+	 * CONFIG_AMD_MEM_ENCRYPT.
+	 */
+	PT_FEAT_AMDV1_ENCRYPT_TABLES = PT_FEAT_FMT_START,
+	/*
+	 * The PTEs are set to prevent cache incoherent traffic, such as PCI no
+	 * snoop. This is set either at creation time or before the first map
+	 * operation.
+	 */
+	PT_FEAT_AMDV1_FORCE_COHERENCE,
+};
+
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 9d2152bc64c0d6..b51de39c03c431 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -115,4 +115,33 @@ struct pt_iommu_cfg {
 	u8 hw_max_oasz_lg2;
 };
 
+/* Generate the exported function signatures from iommu_pt.h */
+#define IOMMU_PROTOTYPES(fmt)                                             \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
+				  const struct pt_iommu_##fmt##_cfg *cfg, \
+				  gfp_t gfp);                             \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+				      struct pt_iommu_##fmt##_hw_info *info)
+#define IOMMU_FORMAT(fmt, member)       \
+	struct pt_iommu_##fmt {         \
+		struct pt_iommu iommu;  \
+		struct pt_##fmt member; \
+	};                              \
+	IOMMU_PROTOTYPES(fmt)
+
+
+struct pt_iommu_amdv1_cfg {
+	struct pt_iommu_cfg common;
+	unsigned int starting_level;
+};
+
+struct pt_iommu_amdv1_hw_info {
+	u64 host_pt_root;
+	u8 mode;
+};
+
+IOMMU_FORMAT(amdv1, amdpt);
+
+#undef IOMMU_PROTOTYPES
+#undef IOMMU_FORMAT
 #endif
-- 
2.43.0


