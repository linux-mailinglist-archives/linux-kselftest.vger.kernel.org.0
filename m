Return-Path: <linux-kselftest+bounces-32665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC5BAB0127
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 19:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4D03BF4A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BC12857F2;
	Thu,  8 May 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JyP2Y3cN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D817A2E2;
	Thu,  8 May 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724477; cv=fail; b=DwlxTvUnR8vXa2A9ef3wv/qbTyuzRlp0gKPKG6VWBpb+ohrBbCVcpZBf6ZGGhanbHap7bCS1FiLlwC7K5/MjnHD/6AQm6oPFPkBUKRWz4tSwzFhHCPp2XZpMRXMWpN8/aF/aH9BIW9W4lhJ7DCSWWPHOozEMevKOOKPLlQ4arUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724477; c=relaxed/simple;
	bh=+BeLTmYwu1wDn6HCwF2mgIjyzOxgeAAACjaCroPxaFk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Swf9XoTsHjI87Af37J5dRIFbz5qT2pi6DE03p2cetE5ZfkSkS6Hj327WUMopjNEKrudh0nkjKl5G8DolfQYRO8Cxg97cFhgHGoWWHKV7SOzxcM8mXH3tonORmWUhfz1CJu0fCkPrslGhhT904m0TD+4ajyGfUf/WDJj7T++fNBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JyP2Y3cN; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuSV2BlyYnI2HyT0MgXR9596+g1lJwR1ggHBGUp9DnRxvxnkRJKERlzrl+tk8eX7thoHhsTJGxfTgJ0tevUJ6388Pm+oSbTOlG9BukM3RZqXz7jKpArIGiOOiVvdySjpp18TFUOE+7SRWBPkbuZKnTKDY0i1pzRuvNwG/cfexZWIypvS/xbVL8dncqKnpizo31R24gvpcfFMqb+miwWY+IBxJCEjQLbpGz/dtZpjcs6u/m5/XGAtb6s7vK4f4XSrcxbPOL1fyOY/Uq2OU+LI08k8KFWcA1DKautD0FsDa8PPm1gSdIbLtPiQ3wConBniTX1ODOBqamk4rfJLPy8RWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VrWSqT9X1AUmnUyZwrveO83JHz/0iUIVYTJCwm1iTk=;
 b=isrpBr5KrCEPAoK93DqEglK+2hN6IdtQ8WmmrRy/zhiJAzcgHVMH5596hTzNBcc/ktF03LY8a9UM00XBQcLkrc91DuYLr/sLJaZUMqrnxuOBADar7mqFsYj8cDWlByH0bUWPVnj1xCDXskfUDQT11swRs9HfAiGFrUbWK4ICtfU24i3qD0xbmYA00XaZcwlPc//RqSShYKXIZA6mU/2cm5sDCyhL3l5GBTMzza5G/5+7qhciZI6hnmnaQKEvfp/MjJocZRY6+ne+gEdJpM9S5xcVtiMBtCGMfHYEmszbRhUkXb1YCdLmCS6+jyaQbuibVv8arpm6SHzdkMt1/7yD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VrWSqT9X1AUmnUyZwrveO83JHz/0iUIVYTJCwm1iTk=;
 b=JyP2Y3cNBVsk1utc+bbhlUYMKVirzVgxph8Ssj2kaWCiYl5RdnPWqv93K4tJLfrW8vkG85+vCbsMtUZ5DgkFG73AiXa2EU6J4o+k2ud+3s+/why3a2x6QwEZ7BUOzbOvcdn7EEAh6FwoQ+bmDnnO0yXmujD8fMhfDNrFiKu/CM0cyXlzEiSzNfqhOy5HVYNQYYf+3SCHEozJ90O2J116VXPCw2aymv13TSwD22TsPIf+8MP6zkglxTPXhJgHIXo6MgOdui/ITEttommUfg8V7mZx0/ZkdFkC3+iYTBObX5F1h2iatcMkh4aUUmLgm6v0xcmh3bNJ5z3KYqf1U69OZA==
Received: from MN2PR22CA0001.namprd22.prod.outlook.com (2603:10b6:208:238::6)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 17:14:30 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::5e) by MN2PR22CA0001.outlook.office365.com
 (2603:10b6:208:238::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Thu,
 8 May 2025 17:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 17:14:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 10:14:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 10:14:10 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 10:14:05 -0700
Date: Thu, 8 May 2025 10:14:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Pranjal Shrivastava
	<praan@google.com>, "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org"
	<will@kernel.org>, "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>, "jonathanh@nvidia.com"
	<jonathanh@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBzmW6A6mZAbcbze@nvidia.com>
References: <20250505173101.GT2260709@nvidia.com>
 <aBkWoH23VysYake3@nvidia.com>
 <20250506125222.GW2260709@nvidia.com>
 <aBpjbtRgR1nK/LIm@nvidia.com>
 <20250507123901.GF90261@nvidia.com>
 <aBvMC7dnYghoX5Aq@nvidia.com>
 <20250507220809.GB232705@nvidia.com>
 <aBwp0JviKskqbPXz@nvidia.com>
 <BL1PR11MB52711314C2A6E1C55AE694288C8BA@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20250508121208.GA5657@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508121208.GA5657@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c36735-66ab-40e3-8c89-08dd8e53cb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2dUNjBPeXU2d0lrbnJIZ3JjWjB1dkRnampRRkJRSjZEbk4wZ1hzSUxNREEy?=
 =?utf-8?B?L3oxc0h1T0NJWTZZNjI3VW1TWWcvbE1LZ2l4czc5ems0czYwRnh3eG9MYXVN?=
 =?utf-8?B?bHVGbjlucGkwcUh6aVlneXZqbXhObEVmVVl1K2hxYzAvdjl1RmVUTTlGU0Fu?=
 =?utf-8?B?K0g2d2orckZjYlR1Y0NXYXpwUjJkMlNLN3BhNk83UDRXcC9CcWljVUhmTFdX?=
 =?utf-8?B?TjJ6VGw4cDRrWVlvMmxBZmFVclhJVEZKdWZoamVEQXFvc1JkdHcrVWczVGZ0?=
 =?utf-8?B?MmZManBYNm1RS2xQQUNBbEljeDlicW9HY2dpRHloZnFYNU9YVnpFQW5vOENm?=
 =?utf-8?B?MzVmcWdsUHNwUkF4WUc2aDlrdW5rS2pKYU9va00yM1FtajZzYnJ6Y012K1By?=
 =?utf-8?B?M0xQY0p1YUxWU3BvYURxTWtCYmp3Z25JNkJ0VFJ1ZXp2OXdjZlNSZE1hWGln?=
 =?utf-8?B?aFJXa1AvdWJyUG9LbWxUWnpTU2cwWlhHdXZMMFRicnNPL09wU002YmhuZG5S?=
 =?utf-8?B?RzQ0Zjg3SGNFVnpUZlAwOFI4M2NHSi9rSmhaUGxzSUpJcytrVzBvbXp2OVNi?=
 =?utf-8?B?d0NieG9xNU1LZWNKamo0cE9pVkdGRGFrWkJrdjY5YlJtdXNwNUI4MEdPTjJG?=
 =?utf-8?B?TW8wbGxwQ2xmMTg1Zm1xY3VFaHgrNy94MHNuYkw2RGpGWUNoWmhpT3JTaFJC?=
 =?utf-8?B?S3VaYUE4OEk0emVkMFU1MWpTOWpaVnZJSndHTkZ5bVQxTkEvanRGNVFmeFdH?=
 =?utf-8?B?YVdJc1Q2V1RGTThnNVFQTktoc1dHbGs5b1hKZU5jL2wzS1BpTWgwd291OEw3?=
 =?utf-8?B?Wjk1OVpkN05pL0E4d3N6SE9hUG5HS2Jzb0tEUHNJUllVY1I2eDNtaTZGV0xG?=
 =?utf-8?B?OVdTYUFiREZyckNnMDQ3UThhTW55dDh3ZDhsNUpyc2ttUzlUVkJXNlYvbUlV?=
 =?utf-8?B?WXd0elRHdnJvc3NPNnFJVXRMZThrcm9xbE5XcWVzOWoxWFo2blFLVXM2UnNW?=
 =?utf-8?B?bnZZMFNYQjR1Yk4yY29PY0ErMlluczA0SEtFMlN6Ynh4bUNmcUlMTnhIL2xP?=
 =?utf-8?B?di9KYXlNbGgwNXgxWm4zUS9nOVdRamxMOXNEdWhrajQrYXJJOU9ERkZJc29Q?=
 =?utf-8?B?SmJCcVlBMlNNK3dCamNoenVKclZvWEhRNzd3TUlWYTRzQ3J1ckhBelQrOE5j?=
 =?utf-8?B?MHVyK3VUb3RzLzBlbHUvdHhKQTRWYWJaMXlNRzAwazV4S2xSVHozYXFBTElk?=
 =?utf-8?B?MThzdnNkUDJiQ3pYaDhIaVFQckhLM0VtOFVxWW82aC9Sb1NOYThZZFYwWmZ0?=
 =?utf-8?B?UWJFY1JEV1NLMXg2eWNYdGJXY1JuVHcxL1hqQWhKaVhOVmw5MXVsQzF3SDNT?=
 =?utf-8?B?RWxoMWhGc2ZEWDgwOWozNnVqaS9FQmI5Zkd1Y2gyRWJYVVp3d0sxL0JuSnlD?=
 =?utf-8?B?ZFJidW9UL2dRUmh0eXo5Y2YxQS82QU9JaitHQkNTdld2NXM5WFRHVmZnb2dO?=
 =?utf-8?B?MVdUd0I2MEs5V1pKVmJLWEEzcUpWZVZKVnMzdzZqeXF6ekFScG9wUUQ4NWRt?=
 =?utf-8?B?SXdPNXFDL3YwSWFVL1ptbW9xbjA4NFFZN3h2OFdPWDJwWU1ORGRESHlKRkJr?=
 =?utf-8?B?V1I2N1NDejZrZmh3aHRNVk1vSUloV29VOEJZNjdIQUJCM3lBNmhteFdhR0tI?=
 =?utf-8?B?ak8yZWpGY1RsT29ac1ludlBRMDNKTDltSG9OSVJONVVQYXEyYlZOVi9FK0FN?=
 =?utf-8?B?a3M3WVhTNUVGOWVJZTE2dDgzK0RiLzUwN3V0aVhZcWMxZDEzU1ZOSHRmMWVm?=
 =?utf-8?B?QXA3R2RlWnErR2V0RFhQY0pxOUxSTHVsa2RyckpkMzJ2SzA3S0h1anFIZDBU?=
 =?utf-8?B?SFZseW9aY3RCbHBPYmJyYVJQd0hnaVo0ZXBNWkZQZFh4Njc3SnNHbkxJbWtE?=
 =?utf-8?B?QXNldmhjZVMwNVhzUzV2dWc1U3hVc3NMMytpT3pSZTREZ3FaWDllazUvS1VJ?=
 =?utf-8?B?bmMvazJXZzQxN1ZRaURadnR4ZnhXUWpDUjF2QmNtRFdlbG1mZHpkT2ZBRkUw?=
 =?utf-8?Q?WfwVC3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:14:29.8229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c36735-66ab-40e3-8c89-08dd8e53cb44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

On Thu, May 08, 2025 at 09:12:08AM -0300, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 09:15:47AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Thursday, May 8, 2025 11:50 AM
> > > 
> > > On Wed, May 07, 2025 at 07:08:09PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, May 07, 2025 at 02:09:31PM -0700, Nicolin Chen wrote:
> > > > > I have another question: while I don't think my code is handling
> > > > > this well either, how should we validate the input address is an
> > > > > allowed one?
> > > >
> > > > The pgoff to mmap? If it isn't in the maple tree it is not allowed, if
> > > > it isn't at the start of range it is not allowed, if the size is not
> > > > exactly the same as the range it is not allowed.
> > > 
> > > Kevin suggested to allow a partial mmap, i.e allow the size to be
> > > smaller than what the cookie describes. Yet, surely the mmap size
> > > should not above the allocated size.
> > > 
> > 
> > let me clarify - I didn't suggested it. Instead it's what the code 
> > does hence I suggested to make it explicit. 😊
> 
> It is probably reasonable to require the pgoff to be at the start but
> allow a shorter map, for forward compatability.
> 
> But also, you could add flags to the ioctl creating the mmap to
> request future bigger sizes.
> 
> There is some appeal to be more strict to make misuse less likely..

OK. Let's strict the size to be exact.

Thanks
Nicolin

