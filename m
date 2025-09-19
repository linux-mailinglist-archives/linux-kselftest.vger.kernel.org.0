Return-Path: <linux-kselftest+bounces-41978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B013B8AE3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 20:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AB43AA45F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE8F25BEF1;
	Fri, 19 Sep 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wjr24ojw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D85254AE7;
	Fri, 19 Sep 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305997; cv=fail; b=jxtNm5ANQ0mYUe408zRfCdDhujNmWo+Mi6RsLAwK3MJieIZTTIniUPaEved/8bCq7V6Ycp0XRUMT4FJ+YhYxEWKeZ6qk9LpwHikO1OGWTQSkVNfMAgSzKs0F6BM7GIABxjmV2f+XOlnH8MEF6LZmLTQLlswDZfkjc2JU2H8hb6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305997; c=relaxed/simple;
	bh=0IGR2VzKErXDfgUxjtL459OI1g/yBMxEDwP4tj2Ppco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HJtYn4Dp2DXURoceGKTPMTK/CrH4kHvqVwWBiT6yboIU2MMDFxL76+SJMAJrWryTkS2sDSjurRn7/jCmlUNadAdsVDEFofcEkYH3Yz1HGHWAqmMHazNoy+PdePTVNfIjrYTgkNHugwYkuwwAtSUdhfvYKr6ilMPolTUdCMAevpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wjr24ojw; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7DM/axn+ocaeSNp9F6J2DX/SqvqAjY/Qipe3acYSZTyD+4YTh1AQ1J5K6sJjYtYoODn6Xe9t/WUvnNcpSqlaeYstkHhp8R8E63WA+jYEhEN72TMuGIhKhAHev1E84QE84dBlFaC4T17kU8IfgLfMdZ3RQqNaSxwUrcDmM2dE5i7vltUNX+5w52U9Qru6izpM+70dcdwbKshcHRdjczChpg+1RyAOd1bCbcTsrTFLPK0gfpnAxuElsl1me29FoR06PTIDHdYG2BaumCre9PiBkfzVvHxjjbVHmt/qpXDuDsllnqKMVKLscoCznhsSsa1BxoR6i2GBEZsn2gwckG6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm4tgmfVXaVZBRVoFEqBlzbp6lp6/aFHSYRnWxZ9lzY=;
 b=Ctpxy6rOzA+udxfqz2lDoo/MKPp4Qoc23gPsf+RTYipRfH/dPiF4QE5iJAoPF29YXxlHcaOYQqhwAvlUSzV2h/LyH8P13m1YoKHcdo6m21KkeclsMi4rjSy2xbrBE5BVWXyDhv/aUxFI4cmasn2anz1YNhn+AftSfZaY2jLmXPFCMnM2C+Pwg6yXsvBy8RpRyziG8ymGcSg09ihl7E2j0B7O2sFKU6LbuGG9mc4xTEgoBKtbeebANQcNPc4sbCTAqEzI2W7AfW1GbpTkU3Lm3qWrtnv3+CBJItygIllPfDpnU4Qu/irvL39fFKpk644efreSiHrwWHFeCHHc+aZyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm4tgmfVXaVZBRVoFEqBlzbp6lp6/aFHSYRnWxZ9lzY=;
 b=Wjr24ojwkT/y+YNFKgL88UNtnDJK3BsrcZj0lq33JiAXkIhd8qfQc/HR8TI2v39iFgv5apR1VUySZSLgVc1fLr+ib7EzHM+x91ACDDsWhvFJs2Zge+IpwKG3aNN/WloR4RiXIU2wrq/7bg+CNaxXV1uqRLg8Shlvg30J0qKsEoejK9lMO2gPGzC/A42+H9ESL+vaC6YSvRH6ztBy8qdo0LJtILc3Q9aOr+14HLj3SRMsljxcHfiAe/f7qtMNo7EkKWvoexPiT5vgqe8KF65nlOeoz/I0rdwsPEAKJFIqorl4lfpf76DecRYmeWVlzFAHrG3XfGtYN7M59hoVuel/pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.23; Fri, 19 Sep 2025 18:19:51 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 18:19:51 +0000
Date: Fri, 19 Sep 2025 15:19:49 -0300
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
Message-ID: <20250919181949.GF2132010@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB52764CB85A0C6814797DE6728C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB52764CB85A0C6814797DE6728C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcf4eee-6575-4c68-dd2b-08ddf7a91fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjNMWU5oUjJNaWdLeFhReFl4Nk1FOXRic3VvUUJwWjFKWEpTV0l0eXZWYVhP?=
 =?utf-8?B?VjRDMGgvUWVDeUlhT1l4NGJHVGxGUnVyTGJPeXZzYmR0OVVqQkVZK1c2NVNC?=
 =?utf-8?B?U3hGNWlXeFBsN1JwR0VacmRmRHVva2FFY01ZaEdkU3lTVWFTdDhMdXR6OW9h?=
 =?utf-8?B?NEVjUUhFUlI2ejN2U1o0OHFUTkNQaUQ3d0lZVHJUK1JpRmN6YVpoNVd4bzBC?=
 =?utf-8?B?L2U4YTFVUE9scFlpK0RLMXN1cjF5TTY1RHFtb2pGbHFja2pqcGUzS0JEa2xh?=
 =?utf-8?B?ei90azROTlVRUDhCWDVoOVIrUElHOTQwdkIyT0REY09CcmJCMHUwWjNFaFNw?=
 =?utf-8?B?TXgwQ3FZNHc3Q3N0dEQ3RlhpbHBJK2g0cGNIL0JBZGlId3lkendyMmZMRWRt?=
 =?utf-8?B?d1Y0N2NUV0VIaHV5V0M5U0NJVGNQM0NzTk9vdE1FWS9kWlhmNXZlazkvUjUz?=
 =?utf-8?B?Z1FDaGlpNmJ1WUNxU0U5UUJGcWNIYWVzTDMrR2oxMzhLbFRoZlRJVm1GOHBh?=
 =?utf-8?B?Q0x1WExTWEhEclNBWFpZdDBTbEt4ZGl1QVMrcXM5Y09hWGZkNU5xUk5PbVZa?=
 =?utf-8?B?MnQwSURLdzhuLzFPaEZTUWZBOWYwVjVUYWRObmZPNlBGemFNRm95SGhXUW9y?=
 =?utf-8?B?SU1zR2xhd1p2YnpUM2RRTXI4ZWFBdHUyRVNTRUVHcFQ3T05YQWl3eTZoNDBr?=
 =?utf-8?B?Q3JnaVI2NUxBMXNRZThoQ2FFMGUrN3o5bWFKK0NZWUY0Y2ZkcGU5dGpKTUQr?=
 =?utf-8?B?VStNM0M4K0FRYlIyNnhoNWo0YitKSUJyUVlNUElkeC84U25LMUNHdXJNTUxH?=
 =?utf-8?B?NmNSVTUrOGVQd2Q1UkxYdzVDZStXell6Z3Vha2FRUStPWTQ3bVVRTVlqZUFO?=
 =?utf-8?B?ZDkrWFJtR0pGbTBMTWZycEdMa3FyNDY2WmpaazBESW1QWkVMSXhjeEREZ1VG?=
 =?utf-8?B?ZUtKTW9Hb3VsWWk3aUgzWFdVZzFFdlBhOHFMSGxyR2tEcUFnVVQ2c3Vjd1My?=
 =?utf-8?B?VGhFUHpKK2VqT1NzMC9hcEVBTVE1R1o0eUJWVk9wMDdXNTdXY0NLRUpJREQ3?=
 =?utf-8?B?N2VYYllZOUp5RGJqc1JoQVJZVldEVVRNNllFcGEyRGlQYnhZUWsybnlqYmtJ?=
 =?utf-8?B?c3FvVm4wWlEvL3lzRXRrek05c1JQM2NhL01seVN1ZDhSV2s4Z0JVYlBFN25a?=
 =?utf-8?B?c3NwajJYVHNjTEJENmkxRnBBQXJ5Q2VNTGxyZzR6NW82ZXIvbGh5dnllSTlq?=
 =?utf-8?B?djZuZmJHcUJ5RnFBRG5WWHg4S3N1alJFdENYaFVWQUpZbmZyQmpnMmZMS2Fj?=
 =?utf-8?B?Y1gxTnM5NWZxNWg2VjhvdndIMkNxdHpHODArUkwycEkvcXdBSWM1emQ3b1Fy?=
 =?utf-8?B?L3ZMd2Y4eGpTSGNEQUU5YS9Mb3hrY3hxNVllempLY0ZzRG5qQkExblFpWk84?=
 =?utf-8?B?eFhoY1ZpS1BsL0xNVmNGNGxrZzA1VmtiZFFJSStwcUtwbkp6dWtRMlQvWCto?=
 =?utf-8?B?eVpyc3VXM1E3SzJaKzd4bCtvVTc1dTBLeEhoU0RINzF1amo1S2tHU1NqVEZi?=
 =?utf-8?B?WFp6NkNKclhSblpnTkJWbDN1Si9oeGpmUlpsaUpna2p4TXJNeG5qMVlXLzBV?=
 =?utf-8?B?U3M4QTRoeUlRdW1yNGpGbWhNZ1p4RDB4WmMyd29ldXQwd3BBc3MxVGhJclNX?=
 =?utf-8?B?N0pIZGFXUzhmUXZmWC9BVlpxK0hxM2VCTEM4dEFKbm5RbHdaTzVFY1ExYkhI?=
 =?utf-8?B?b0NNeFRBdFZnL1FBanpGN0tuR0JuaUpiMkRhKzYreXREMzIrdmNFbnc4RnlY?=
 =?utf-8?B?LzQyTDlqbFM4eHVVcUlobUdYVjJFSEZCSlEyZDl1WFNQaGpkUFIrTUhVN0h5?=
 =?utf-8?B?TFFYTmJGdlVWVFJKS043RFRQZVhvRlhXUUxNVnc0VHgyZ2c5czB1dGtvMnFP?=
 =?utf-8?Q?WVUoqeHmjhE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTdlSFptWDRNUlpzRWJqSG9SL0w0UXo5VS93ZVRiU29PdzIzWlZFdThlYktB?=
 =?utf-8?B?cWNCSDBkUkN2YjduWUhIODFNN2VMTTFvTE1XaFFJckJtVDBPRXNrWUd1MHdY?=
 =?utf-8?B?Z2Zlb3I5RlpUODRLTlIrbS9ScXpMbGJJUGxlTjhMeFM3SC9oWFB0aGhMTTZo?=
 =?utf-8?B?b2d3WnEvWGZhdCtBdGdMTzFlaVJPK0E0aXhiL3B1VXZjNGJlS0tMY1NTT1Zh?=
 =?utf-8?B?QTlWMzh3eWtpN0Fsb3lvcUtBY0lqNXIvK013ZjZjTlR1TjhiZ0d6V2d1ck9K?=
 =?utf-8?B?aUtHV2dnZ3g4TkV2OGZodVViN3orbVVFa1crZmhiaFduUFRpUWZTdHZTQjda?=
 =?utf-8?B?cis5TmRYS3ByTFdCZHROeDNwUlBaWXhEM3BEejdES1d4VHFJdkhJV3lFTG5h?=
 =?utf-8?B?NlpsRVZTM21zcUJnVmJtY0xLRDV4VDI4WXpEK0YxZ2FpYm5Fbmoyc2s1bUU0?=
 =?utf-8?B?S2dpanoyUElTeEJaZTJzUHJQbEJHWnYrcGFBelVGSmhYbThlVldmN2w0S3ZO?=
 =?utf-8?B?NlpxdWFSdTRKTUVOMStpeTFzS1JVU1kyMUVLZ2YzSlZSbUNuNzJ6QkhnNVgz?=
 =?utf-8?B?eU9sM05BMzF0R2xuMXVhc3lJTm9WTlJzVlhIWTV3c0U3eHZhZlhDYWt2bVdp?=
 =?utf-8?B?Rm9KQWZFVG9TMVE0VHQ3Y0x6d25jWUI2dG0xZlFkVzdQNUxnVUYyR2k5Rkw0?=
 =?utf-8?B?bUdabmRKbGk4Y0hPS0hjRHVsUVdLNkl6NVdSUTBBcXpyNFQzUGRLKzJZMTVX?=
 =?utf-8?B?eVZ6R2I5MXdHLzZGcWFTK1N1NWxXNnhxdmVWdU9ZdnJnc1hGcHVvb29BNktC?=
 =?utf-8?B?MjVRQUtOUWc3bXZ2WG9KTVV4dlp6c3pnRTBaR1hqYkhodG9kdlErRC9PeU1Y?=
 =?utf-8?B?Z0lTQ2dSRnY3OG5DUzBraTdDSGE5c2hwR3VlMmxBV3hzNmlzRHZzM1l2ZEFk?=
 =?utf-8?B?SitnR2pITUV2T0ExSXpkUmtYazJIZEZtd2d4M1U1b2NhcHZ0aGtvODh4UHpB?=
 =?utf-8?B?UTdLNTFzN1llWWJvK2x4RitGTkgrSVdES3ord3Mzd0QwOWtGTUZFbENENUpu?=
 =?utf-8?B?Q2twYkN1MFZWeWg0RUttSEFuRTRvUWtIUy9pdkhaOWF3SkcwVkI4WTBRQnlF?=
 =?utf-8?B?UXNVNHVGZlVCQ0NTS05mWUw0UC9nYk1xamwxcFI1T3Azb0lHck5nNlNpc3NX?=
 =?utf-8?B?eFRBYVNaTDRiY3Q3Y0JPQ0daQWpRelk2VmVrQ2tNVXJxNlNpR2pueFZRWXo0?=
 =?utf-8?B?azJlSit6UURZTk52ZVIxaW1SdmZqNjJST0o5TTdIL2xnQ2VSWkVoUFcxQ0tO?=
 =?utf-8?B?NFpzc05yTE9NL1l1V01EOENiTzkvc1EvQ1NYRHMybENxYmpnMnhORTZCdDRz?=
 =?utf-8?B?UlpGWk1pTzl6NGxwdEVUeUl2NE1WQ0xoQ09DemZZTnNYcXBnYzY5MGp2SDZy?=
 =?utf-8?B?QzhMcDN0RDRkSUErN2xFeWNhWnF3ajdsSmdOTkhtVGkzT3daeTVkdWVIbUtJ?=
 =?utf-8?B?TENQeEg0aGZtVkppWDJXQUJ3dFBsUE9jbGh2M1QxUUU1TXlBZkd3Mmk4bEVi?=
 =?utf-8?B?QnJaTFBKY2RnN3Z0SW5jZXliT0x5bm5VWFFkRUJyNld1aHJEeWFSV0paQXBP?=
 =?utf-8?B?eE5wcWxYK0ZBOWZXZjZIb29TY0VPNDFGU3hLbHRNWUpKZ0NZb3V3aUhIOWE4?=
 =?utf-8?B?ZXJ0NWtqTDdTQ2IwMTlzbXBCZ1UvMUc5TlZKbHRqeWRLK0t3R0RieVRzRXRR?=
 =?utf-8?B?M2dpR2FXRUd5allBeVZhMlZzKzZxUUZWK1E1bGZRcklQdS9Jd2kxcUQzbkFB?=
 =?utf-8?B?MWw4eVVLemxCcDUvWVhtUDI5emg4bDBOaC85NzZINU9VeVhiTEpyN0J2WjdG?=
 =?utf-8?B?U2RwcXE0K1V2ZVdZN2Rnc3BsRTdxS09UN2JwS3h1bzFyMGZmU243WjRpVjBp?=
 =?utf-8?B?MnJlQzZxRVhCeHBWTnNJenBoTEZ3cTEyVUFoTmhBM05xOGMzVS9BUGt5UG9o?=
 =?utf-8?B?MzYzeEM3V2NqeHJ6MmhzVlVnV0NLNC9IVE5HV1lBeUo4VWVqUWtscXYrcmJJ?=
 =?utf-8?B?a2FpYWpVaTViN0RoTGlpS3MxQVVncUV1RmlGRWVCdVZKQkM3VDBVcHYvVjFJ?=
 =?utf-8?Q?mVI5xr1gTw9dRXqbhopl63lA2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcf4eee-6575-4c68-dd2b-08ddf7a91fc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 18:19:51.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GV0f79mK5HpjxKJLjeRJt07Qr+qMOSDE8/Yl6Hk3ql6Xfaz3IZolnnMj80J2TVG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288

On Thu, Sep 18, 2025 at 07:05:50AM +0000, Tian, Kevin wrote:
> >  256*2^30,    396,5665  ,     389,5258    ,  92.92
> 
> data here mismatches those in coverletter, though the difference
> didn't affect the conclusion. 😊

I ran it twice, it isn't stable in micro :)

> > +if IOMMU_PT
> > +config IOMMU_PT_AMDV1
> > +	tristate "IOMMU page table for 64-bit AMD IOMMU v1"
> 
> remove "64-bit"? I don't think there is a 32-bit format ever.

I am marking the 64 bit vs 32 bit in the kconfig descriptions since
that seemed to be a pattern from iopgtable

> > +
> > +static inline unsigned int amdv1pt_table_item_lg2sz(const struct pt_state
> > *pts)
> > +{
> > +	return PT_GRANULE_LG2SZ +
> > +	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ITEM_WORD_SIZE)) * pts-
> > >level;
> > +}
> > +#define pt_table_item_lg2sz amdv1pt_table_item_lg2sz
> 
> this is the same as in pt_fmt_defaults.h

Yeah, I left these behind because the order of declaration is
inconvenient, the format itself wants to call this function a few
lines down.

But I just realized it can be forward declared:

/* Body in pt_fmt_defaults.h */
static inline unsigned int pt_table_item_lg2sz(const struct pt_state *pts);

So that's fixed.

> > +static inline void
> > +amdv1pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
> > +			   unsigned int oasz_lg2,
> > +			   const struct pt_write_attrs *attrs)
> > +{
> > +	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
> > +	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
> 
> check that the index is aligned to oasz_log2

I see the various formats have a mismatched collection of assertions,
I added this function:

/*
 * Format can call in the pt_install_leaf_entry() to check the arguments are all
 * aligned correctly.
 */
static inline bool pt_check_install_leaf_args(struct pt_state *pts,
					      pt_oaddr_t oa,
					      unsigned int oasz_lg2)
{
	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);

	if (PT_WARN_ON(oalog2_mod(oa, oasz_lg2)))
		return false;

#ifdef pt_possible_sizes
	if (PT_WARN_ON(isz_lg2 < oasz_lg2 ||
		       oasz_lg2 > isz_lg2 + pt_num_items_lg2(pts)))
		return false;
#else
	if (PT_WARN_ON(oasz_lg2 != isz_lg2 &&
		       oasz_lg2 != isz_lg2 + pt_contig_count_lg2(pts)))
		return false;
#endif

	if (PT_WARN_ON(oalog2_mod(pts->index, oasz_lg2 - isz_lg2)))
		return false;
	return true;
}

And the format can just call it.

Made both these edits to all the formats..

Thanks,
Jason

