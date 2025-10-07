Return-Path: <linux-kselftest+bounces-42828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A42BC15D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB3F3C7CA2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 12:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFA92DC330;
	Tue,  7 Oct 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sazJ2tfX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8FF2D46C0;
	Tue,  7 Oct 2025 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840136; cv=fail; b=KWp2FZU9LthSOIqd+aGWNxHbdftwAraw3XfhgOCwFfjy911AkNcrZ7k0dVw/+2FOdytvrU6i2zdT2luY9OQse/ht+PAhzAKBYwPLMfnL6Xwqm6HDxet6QW5e66KcFQ6vSMNGhCunly+gRZMYPBBnbrXtJe1+EyFV/rfIdYEHkZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840136; c=relaxed/simple;
	bh=e5eAWun/fHARkYJrzWlaCSCe8iZs+X2VfcwPd3zjqW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PzE+enTDecjT6sCiJ/53U00cktaPfOtmkQ5GZpGpPtQWG7IGsgmLW4q/VkT8rd5W3F8+FirSC1TFR3+MvQz5Au40WwL1r5HWsUMt4H44S17H0iWInnu2D6UKGx8t9XIcuS6d2o9hj5QYNKGgPbrexAnlDjOfVFH4Bm5NkKvxtN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sazJ2tfX; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZi/FK5K2xvPmGdQ6y04q2lXfWyvGrf9xOSnop/+NbPgixFJS+DHw7JAmwwpQJf1vYTl00lQ+ld+1+terJc4TptU4NN+VipUHhrItIWarqs9JuuXq8YkZUFH2CT+FgzRk5RB8VRw4NV9iQNkjhi//YKBuPvoGM2i4a21z+2/Rp06VmQ/psXFnPgdoVLiGCO/lZLa3XA6gjou3D+68RqQP75IovcuLGVWaCo13hrAcjpN8UwzRcgclRseMhrFWOnxKPrLmvdP/Au+/BIj66aAd0/0/WDYxxj6EqhKIKTRZ4G/lO7IdMyQFc8cEm5NRreC4qcmtF9ii6VdOSPd8wjOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8mkitLhhFY4UHhOnqyAzRfTY4Jturl81NpAAGnfEB8=;
 b=Dhrkt4P0gMVEwLNpDussCHZBVklfE9meoMET80sYIe1pIaPFyA/vw3AZ8iTMHT1aAt7CLt83Bk6ig7d1VRC7XBg3rpFG+QceTcEelq1mWahPSaDVRFt3xpzZR1q7RXka1f2NtdB3jPGSI2lvMa9O01DU+di3Rx9YK3mgah47lEd+RrHIwG00X+M0JCAKMUoDAyAgq8V9O7pu0BS3N/MVORUslGwt4x9vXo5F8jtSXIU+u5vyCeUKVfasmSqK4MVvBUc4NlwIZ6zlxHPJF67hR3g4Rr625XC8fiTgr00yiztP3dof1xuhVe6uSNuXNttT9OjT2Id9TVHvy254XEVjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8mkitLhhFY4UHhOnqyAzRfTY4Jturl81NpAAGnfEB8=;
 b=sazJ2tfXMqTVuwdDpx+seZVsnNoaZvJTBZjb5O50nzxQmxU/ILel9LbPMpNe2yPnHfbv+lyMW1EisEoaMTuC7Qe9TIu6jz2bZUTkntw1dsJpUcZWjDI7iH3fghvi505QmDtZ+Y/Gioix20gUV9H8riDZ2p0b16tMZfQm5/Qpt58CjnSKvkrpX8PoNWkMAHKkpRjEk/wZB5Ndf5Bpptb/PynJ/0RtNa5RgSFgUBgIg1TS0+ldWdGTiJYKwFBXAch03+BGHXT9t96Vz+wjSIASa+evFBzUiGlV1F96v7jYqif54Vh88dm723P22ePwr32Nypa2vS/Ks/lg3pR5bGQmXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 12:28:45 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 12:28:45 +0000
Date: Tue, 7 Oct 2025 09:28:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 04/15] iommupt: Add the AMD IOMMU v1 page table format
Message-ID: <20251007122844.GA3483655@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB52764CB85A0C6814797DE6728C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB52764CB85A0C6814797DE6728C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:208:239::29) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6025ef-7aaa-4a58-8154-08de059d0ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yi9kWjFZYktHcjFWamdQVHhBdHhrVDgrS2lFQVJwa1dBdklKcDZuTDdDbEoy?=
 =?utf-8?B?b3JRVktpTWFxWXVaalZsQnhmU2ZKKzM2MUVCTVJaM0dLZjNNc1NqMjE3WkVi?=
 =?utf-8?B?L21tTVkrY2pPdGdHQktpRnBiTlROK2E5dUJ1VU41ZDQ3UEZoZzYra2pZSk9V?=
 =?utf-8?B?QWV4anhiU0t5Tmh1MWZYU1RBMDhhVmU2bGxGOW9oOTB6MVRMUXlNeGU3eVFm?=
 =?utf-8?B?RklpTkc0Tng5dWJrdFFDVEtDcE5ZdTFiRFhwS3hDT0wySVg1a2MrMTFuSUti?=
 =?utf-8?B?UWJKRHdLcmxLeEQvWkduMjBrbzBTeVVoSUZLSnp2MSt6ZW1wcEZCVVZUdk4w?=
 =?utf-8?B?VEhnOTFRMDd5SjM5QmoyZmcrSU9HeS93MHArRk95VVc1RU9sOTVpUXpkT2xE?=
 =?utf-8?B?bnJiS3FweXZyOWpuQzd2TExqRGttb1dtNElmdU91ai9RanRwdVpaaGFHOG5k?=
 =?utf-8?B?cExNSGI2VXdpd3p0SWlieFRFUXQ5TkZIY2l3WWRtOXVxTEZyMFlGV054STMy?=
 =?utf-8?B?QXRXSDhoVTBlb3FyRFNoSVBTYVJIZzRIMXFuRVA4dmNueWVLTnRMdUdMelpD?=
 =?utf-8?B?QTBzV0JaMXZEemU4VXBTRHQrM2Nvd0J4WTFTQlF3U3k0RGtPZ3pacW1qeE5U?=
 =?utf-8?B?aFpqNXJIK291V0RWRWFRY2g4UkVLQ3hQSGRTT28ya3lHYzcyK0plSUNLOTJD?=
 =?utf-8?B?WUlpK1RvY3pmSm1DQStNZU5sdThrbEphUUo3V3Q5aUtLejhmeHduVVFNaUtV?=
 =?utf-8?B?cGhOWEtMMlVFK21teWtvVU54dmV6dGRqVlNPeFFvSU9VYVVEa2NkTFA4Zkti?=
 =?utf-8?B?MXY2VWVoTFVOVDN3emlWOEZuMHJPSGZVMnlqSGJlVmV1d0RQNjZZai9rU0or?=
 =?utf-8?B?ZjJzZWlVSVdaVHVRK2JwZ0tadkRINlJNMXlKQ2RaaU9MYnIzYzB0ZUV1MFV5?=
 =?utf-8?B?N2VwS240TmorS25mQVQ1ZUVQdGN3eTZhTDNYVWVDc0NlRWVkZERXUnQ1STJo?=
 =?utf-8?B?Y0VER3lmL1BVcEk5Nmw3UDdEUFM5bTZ2N2UwbDEvWGszeWE0QjVRQml4QVhh?=
 =?utf-8?B?eTBJd3dRUG40OVNRQ2VvYW1qU3hjZU1NNzFOQW5BYnhwNEVQbDljbjFWMkNR?=
 =?utf-8?B?VVRYSW05TERneDg0SHpnTXYwK2V1Z2lIdEhkd3ZoblF5Z2tWQzBZU2ZCS0Mr?=
 =?utf-8?B?c1BTemNGcnQwWjU0U3kzUktlVTJDMHRkZkJoQ0RaYTZ1OTRpVm1rS24vbFMz?=
 =?utf-8?B?bkR4SEI0T2hrOXNMY2kxWlloMTZUd1p3SGNLRjh3MDBBZDFRQ1NFOHlVcW81?=
 =?utf-8?B?WkFWSGYyUlFDd29LVkZ3enArSFRoRHRUWWZoQ095cHFrTkFKcm5DbG5XMDFE?=
 =?utf-8?B?a21nVHlUOURpWXl2UHB6aVM1S09ycC91TTRQWFplZEw0NGpGUGFib21lOUZN?=
 =?utf-8?B?TXhHdWFxYXd4Qm1pSWYrbUtkcG84MGkrZnZTaXM4Ti9iQWR0WUVSRVdEN21W?=
 =?utf-8?B?ZTR1bUFFUzBIaFlWQWsyTHlLcTFDM0FaN2l3dmZkNjIwTmM0RXdSYVZxT1Ix?=
 =?utf-8?B?bUFFVEIzb01DYTFQV3JwUVl1VGM2ekt4TmNrb00rY2I1V0dBNUlJajNwWGo1?=
 =?utf-8?B?VmlzMGhMdTJ0dUlpeGwwTFJqV0YrTHZmZ213aVREbDl4U1d4VGRTeXllQnA3?=
 =?utf-8?B?WFJqRnoyZ1o1dVdVdzdCTnFFNktnalpSa0J4SXNCN2trSUhrTWdwZkx6V2FY?=
 =?utf-8?B?VGg5VjNacDFRbElWM3djSGxBcEJodWpPMmQxajJHaU40ekpaK3VFZ3IwVkVp?=
 =?utf-8?B?UWsvSnBlSU9WdkVHREpjVmtpTmJJU2tGMlpMYU1sM2hENys5cXVqZzVYY1FH?=
 =?utf-8?B?VXMxVkhXVjVBWGtqQnZtZDRCekhWMm1McW5ENCtnUTgyQXY4bkl0U216MUNa?=
 =?utf-8?Q?lc8jtq6PMev1IadWmh0Y+LiEvZAFk7Gs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0NZMHhJdlFMeU5XZnJrLzdmbnJlSlF2V0VhdE55RlpacmpQaG5SMmpHTW1q?=
 =?utf-8?B?RlVxcnhwaGRralIrOFlSNXJNcmwzNHB5TjVmNUVhUnRjYmwwWllBbmFqaUFu?=
 =?utf-8?B?M2NOOVo4RWdOMUNISmZGbFd5ekI0eHFsdlQwOUcyVlJSZUdWZUQxK3dMN1Ro?=
 =?utf-8?B?cmNQSnAwMXZRdVpuUkovNExrT1pHL0tHOHMyM2Q2M3RHTjNlMGZQWUcvaU12?=
 =?utf-8?B?T0FPaEtaL1BkV2xabWxMbGplRkZpU3RqUExWYkFxcWlZdXdUZ0FRVlUrQTdO?=
 =?utf-8?B?cnNoaXM2b25tNEVzQzJoSUxkNVh6WFY0MWxONnpZbjFCTVkrdEUzSGFsbFpL?=
 =?utf-8?B?NlV6emZtbHlQbHliTm5VTWhWRk5INFlsRnFMSjZodzM5MVRSazZOOTdiOE4r?=
 =?utf-8?B?VlluS1M1R2o5WnJvYmc4bzJTZ2R2eXVXNXlGR0JqTTdpZGZPQVVqVGlNaTN0?=
 =?utf-8?B?bWZxbm9uNzJJeDZJUFFIOHZnbDc5VmJzSXpUMHFqOFduRFNLeEhmc2VWbTBK?=
 =?utf-8?B?ZVZudjRXeDB6ZUw5VFk3N3VKcG9aRm1jUjd3cTYvVWM3OTNCMmJUaDhNSjBy?=
 =?utf-8?B?M1U3SGQycHlZSXJFSUNOZzhzTE1vQURlK0pBRkpiRHk4b0NYZGlweHFSTElH?=
 =?utf-8?B?SWRmZ1FlRG9ZWTl3Q1BXdjd3c0lIYmlJSmwzQnE1RkRTaXRhOU1rUVl4UW94?=
 =?utf-8?B?WXFwbm5sTWZXazlsL3FsQStUSmtVYXFXOURVYXhaWUtPSGFQMzFzS2NSUnFH?=
 =?utf-8?B?cVlhbE4vUHpKeGNmY2NaVEtTRHFIcGVHeTMvTXFDWm5XYmg4anZLTU50UEVY?=
 =?utf-8?B?QVRFOFlUTVQvUDhFKzZhU3BtRnExTkhCOVprMFd4cnhPR1VFTmJXTHZ6dy9n?=
 =?utf-8?B?Tmc4NEp5bGlDMW1mUHZRQnZtbjU2MkZocHVvVmVqTDU5WlphMHowTHF0NmlO?=
 =?utf-8?B?Ukt4MmwyU3pQTzg5NVc0Y1loZE41aWZOMUtlRHRhMlA5VnhJTHcwODRRMFlm?=
 =?utf-8?B?ZXJISlpkOFo2YThsOWtkdm9oTkhRUFpvanNKcDJTSVY4MzlMUlBqUVE3YTZZ?=
 =?utf-8?B?dDVkT3VzRU50cVBTN1dtaUZyUnJkeEhNQUhhMjRpaFkrcVh3d0FlQUhPUXRz?=
 =?utf-8?B?ejJYWFdIMHJEYmFuWHFZejkrRFFPN0tjK1hFVEg0ODhKRFRxRy9aZnRBRnJ4?=
 =?utf-8?B?eGg3VzRiaVRRTWRpbGdYODJncUV0MnRidXNwcTQ4N3oxVW9MeTZDamR5UDYw?=
 =?utf-8?B?VmlIckpJVHNmbGsrRjN4NUJ5bGk3UE5NcFl0cXlzYXR3eXkyaGNoTktpeTBr?=
 =?utf-8?B?c0JtRldlRmJtbUdDQkE5WU9BTWtpdVMyM3ZGR2dDSVkwMFNLRGZOalhTc1FP?=
 =?utf-8?B?aitsbDdKendXT0F6bWkrT3RCeUNrSExUODE4Q2loQ1VQN1hvWm9OcVdVaFla?=
 =?utf-8?B?dGZNRWt4dmVYSVljbG5wbUR1cXVKQms1SDh6cHlPZUFKZzFLaXJkMFNUV3dJ?=
 =?utf-8?B?bjVTa2FjTnJMYWJDUVovTnlnM3V6NUFmNjRIbjlKQ0dYOHFPSVpkS2t1dk9u?=
 =?utf-8?B?UCtzT1ZQdmpYOXJ4VGNDazZVYXlONE9rT3NXdVoxclI2T1R5UU1JSnlmQWNW?=
 =?utf-8?B?NjFQMEEwdlh5UGZVQyswdVJxK3FrdDNiL2NtRFNEUHNhZXN0UHVib2ppdVVJ?=
 =?utf-8?B?UkI4eXBMdjU4YjI0YzlYRkhSS2ErYkVMQnNFdUZuemplV3hCblBWZ2dvRDNS?=
 =?utf-8?B?clEzUGJLNXQvQkU2dTc3NHZabHdFNHhqR1JjcHVvU0NNV1ZGRHBrdEVDMEFN?=
 =?utf-8?B?WUlCcTUyTGhMUlJCTXQ1aDBMN2NVSUhQSUJsWDZ2QlUvRFlIM0x5bmZVWHN1?=
 =?utf-8?B?ZVd4YU9IVHRiakJQT1ZZRUM5NUZEeHVWL0syK1NPOUorZ0thRzFRZitmVWU4?=
 =?utf-8?B?cHkxc1NPSTZJNTJQR25QU3lNSC9CaG9OUElEYnlKdGlpcGptZ2RwZmJMSzFj?=
 =?utf-8?B?ZTZEUmxsd2JIcllFSXBDMGJoRHFDYkprZ2NtN20xcWNCaXlGenM2cmJZU2Zv?=
 =?utf-8?B?YkZiMEFQdFFVRnRIclpxLzA1K1JXRHhaT0NVNGFwU0xReGIxdVZkQWVycm05?=
 =?utf-8?Q?lw6s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6025ef-7aaa-4a58-8154-08de059d0ecc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 12:28:45.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUcTj+aFJifx4PyuXGnSMQ4BFRXnJtTNW90X1JEFFf3YZIO80P46b+WcdfKpL0B9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221

On Thu, Sep 18, 2025 at 07:05:50AM +0000, Tian, Kevin wrote:
> > iommu_map()
> >    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
> >      2^12,     65,64    ,      62,61      ,  -1.01
> >      2^13,     70,66    ,      67,62      ,  -8.08
> >      2^14,     73,69    ,      71,65      ,  -9.09
> >      2^15,     78,75    ,      75,71      ,  -5.05
> >      2^16,     89,89    ,      86,84      ,  -2.02
> >      2^17,    128,121   ,     124,112     , -10.10
> >      2^18,    175,175   ,     170,163     ,  -4.04
> >      2^19,    264,306   ,     261,279     ,   6.06
> >      2^20,    444,525   ,     438,489     ,  10.10
> >      2^21,     60,62    ,      58,59      ,   1.01
> >  256*2^12,    381,1833  ,     367,1795    ,  79.79
> >  256*2^21,    375,1623  ,     356,1555    ,  77.77
> >  256*2^30,    356,1338  ,     349,1277    ,  72.72
> > 
> > iommu_unmap()
> >    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
> >      2^12,     76,89    ,      71,86      ,  17.17
> >      2^13,     79,89    ,      75,86      ,  12.12
> >      2^14,     78,90    ,      74,86      ,  13.13
> >      2^15,     82,89    ,      74,86      ,  13.13
> >      2^16,     79,89    ,      74,86      ,  13.13
> >      2^17,     81,89    ,      77,87      ,  11.11
> >      2^18,     90,92    ,      87,89      ,   2.02
> >      2^19,     91,93    ,      88,90      ,   2.02
> >      2^20,     96,95    ,      91,92      ,   1.01
> >      2^21,     72,88    ,      68,85      ,  20.20
> >  256*2^12,    372,6583  ,     364,6251    ,  94.94
> >  256*2^21,    398,6032  ,     392,5758    ,  93.93
> >  256*2^30,    396,5665  ,     389,5258    ,  92.92
> 
> data here mismatches those in coverletter, though the difference
> didn't affect the conclusion. 😊

I was looking fixing this and realized they are different
deliberately. The cover letter has:

  * Above numbers include additional patches to remove the iommu_pgsize()
    overheads. gcc 13.3.0, i7-12700

Which is why the numbers are so much higher:

     2^12,     53,66    ,      51,63      ,  19.19 (AMDV1)
     2^12,     65,64    ,      62,61      ,  -1.01

The additional patches make the difference.

So this is telling two stories, this patch at this moment gets a
slight negative for small small sizes and a huge positive for big
sizes, while after some additional optimization on the core code we
move to a full significant win everywhere.

Jason

