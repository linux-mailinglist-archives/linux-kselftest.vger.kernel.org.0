Return-Path: <linux-kselftest+bounces-16672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A126964071
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 11:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57DC280C8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7B18C90B;
	Thu, 29 Aug 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ajrf0Tvb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B25189F58;
	Thu, 29 Aug 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924524; cv=fail; b=hsnu4ae2ycD4QhczT5HJ70taZuVwfPmKqIelJ/Qj/opvVulXLFK7nHxSnqOaPQagYxLFhFg8LoPAdTpgAvmoK360wMcsnftvjFEOm9Gp2+SrwSB6Eqh6UYthNwEfYkq5G5ciChhmKW58k+LzW1jiXwDm2OBHiFdXjoOAcC0/7dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924524; c=relaxed/simple;
	bh=gvCHw/krbwC9gcwtDpY7QnxuR5lRGP5r/4atj9NsBNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DgDKI/Mh7sOG//nU1EHpCx6OAIpSgj2ysozp2jLbyT/K+PSMezZplMHL4uuz5Ny4GcgYrlu4dzCeSQkw8fV8AqaMEIgm+T+nw3nytiRCwWx9cNnX9EOHhmcgg1cR+3A9EB8JoS4s4BxyNNpC7vCVcvpE8zOShy1gQbYDhuqF29c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ajrf0Tvb; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuEl9vOKdU8L4WViHHY9tt5u2dl2kEMeT6yZBCtshTrDI13al3am9DKtIg7OBTHS7d/bsdfbJouUKzRPxJB7OMlhJGMV+2T9nahcTLa5FuzDVYs6bTq8PBxj4WcHjCHEt2KmSVZPrFSWxqrg5lT4VZMQ+9PhReMzl8cmxbH808v8lsCPh7ysP7/Z+QnzzIX/16ozG3pt0p+gRWLxdyNpF7tV9wrlnOI64EnBCiy4YnLccBhmySY0LcXGHmRPxyiI5o88CMeLk93W1OHvrz+o/mn42p5eqlF0QRWAj48tn6NzYv1+2psYXQilwVblGfiHO3l4I668aYRUb3sxuq1f+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuQEpSY+Gv94e8Omq5FopJmVD0uG5CZski5NsLcN5hM=;
 b=bauRGQdhtoFXuql8PUpiP0oGQZevcyHQrmCXZwzfZGu5RT5yETlF7sNSK8zrf6bEsvN7f4tgK2GkPuRolGq6IWiQGuH1r0mpZUl0vuMpupQmI2T1z3cSjBreoS85Euj/+3PONZaqEb5wd1Ch0LkfPmMZ5q0k8xkBaUmfPOyXOGhD2/ePM72RuiZQyY8DvNHW//4WA4yZZyPFMdZq7P0lPw8KTOvOJJZIKl4VJrNNJ9Iv9FAu8td++EHW45Sd1B9XpE4EuYFlr8/NLx7qn2n6o07FaIryfXsW8j8xOJ8ne8BoTwlD2kH8sG1Y5L9BIr+0MeNnJ1kjCBo9+seGRoYdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuQEpSY+Gv94e8Omq5FopJmVD0uG5CZski5NsLcN5hM=;
 b=ajrf0TvbojA0VP53JHnvkGKcEFfNNo28SaSqXaK73ZimI+EZmTS5UpB4J/x/ogVtRSPk6R+uLv0Q+j6UGG0z2Jp+CiOb8p9mvUISzsQTmExPXOUhsVaclR0aS3NrXk8uvL1MKit8uWDTJAUcjwKaUyp3TiEzo2nkLIEQlQ5C+Bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Thu, 29 Aug 2024 09:42:00 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 09:41:59 +0000
Message-ID: <340637b1-d2a6-4555-9ea1-4a28b16f9576@amd.com>
Date: Thu, 29 Aug 2024 15:11:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/4] KVM: selftests: Add bus lock exit test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-5-manali.shukla@amd.com> <Zr-0vX9rZDY2qSwl@google.com>
 <002c7137-427e-4bd8-ae9e-04aab3995087@amd.com> <ZsyoEz9DMq2hZhV4@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZsyoEz9DMq2hZhV4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1193befc-e786-49ad-8974-08dcc80ed41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REk4bGNDZEdlUUc1dHNLWGE5V3BTOTAwNXRCVzhJWDIyUUVTWVhFRXNmMWJj?=
 =?utf-8?B?OFJnTE1TMk1Pcm5haEh6ek9zZ203R3VUa2FGUU5neDZ5dDRlNk9VM1NvMklL?=
 =?utf-8?B?emxGbDljYlc2cUd4TFBLSkxhZlQ4cDJyV2xvb3VXQU9LcXQzMW83THdVSUg2?=
 =?utf-8?B?akdSNnNCQ1RmeU1Hb2lFcDZWVkNmQzFBTWlIR3dsNHBkKzNqZmtvMk0reWZ4?=
 =?utf-8?B?K3BZeXBhQTZSVlJRMHpGbzJIemh2ZGdKWFFKYnRXVnBCZ05XZ3BlU0dxcnpk?=
 =?utf-8?B?NjArbThWOFZzZDRWM05tZXlCdnA3Y0hvVGdUK1kvcHAxcHBXMVBZTnBXRkwv?=
 =?utf-8?B?clNubW85a0lnMkE4MllmeE1tcUJ0bFUreElDRW9Relp2clRxVDJ1R1RNWEha?=
 =?utf-8?B?cXZQaFVCeFk2QmFhZk1xL0hPckVSOENpV29LRm9zbnNXTkhlZWdvNlU3am91?=
 =?utf-8?B?cEoyNkYzNFJoMmgzUWJnbW9aL3pSWFlLaXhlK2JuZ3hTOGsrQ1A3eGJacGMr?=
 =?utf-8?B?cTA4dlpWNEN5bHZzaWM5UXFiQ1BRVHRoZjJ0LzVNOFNGZFhvdnM1ekJRZXQ5?=
 =?utf-8?B?UFNzVFVjOG9URmZDYkwzczFXMlFkVnBMd0U2K0VkVHp0WUV3RitrSS8vcUhp?=
 =?utf-8?B?c0ZwQTU2ZG1kRVdPa0lpbExSamNUQVpRVjYvaGhHUXNOdjJpMmZuK1hSYTU0?=
 =?utf-8?B?ZUFMV1V5ZE9YMHNDZWZiZm9rMUVoKzBPWWhESXJHczFQRnJIVkFUTmdjY3Fr?=
 =?utf-8?B?MU5LaXkzWTdjTmdOWFQ5THF0WlM4VnNLbjN2Y3BTVHQ1U2hYOHQzMytCRE5G?=
 =?utf-8?B?Mnd5MEp0dXJTcG5YOERWU2d3VUJxK1JncWpKejdETytWcHNSQVhLZmxjbUpl?=
 =?utf-8?B?TE5yQXdUREFCSTNWRENwMHZGN3pxc0c3RzN4KzgvbmF5MUMrS0NNaFZVOXpp?=
 =?utf-8?B?REwzbDdiYzFrbHhiNmd1VkMzbGlRZ0tOSDczaHkvb3V2SnRxWVVLcEJFZzRx?=
 =?utf-8?B?MmpGMTU3U0VYbTBUUDFPbU54QUdmNUZMS1V1TSsrMjUyR2FkTHpiU2JJeFY4?=
 =?utf-8?B?eGlkQ3lrU2ltUUZsQlN0SEQrUFNUdzZjMDFHMFpyREJVL1hyNHZ4RGZoQUlh?=
 =?utf-8?B?Ymk1UXlnZVlGbU1ZVXpUQ2lPNVRBaXVxMHhzQ2NhcHBUUC85MVlBSno3Y21K?=
 =?utf-8?B?VHJvNkxBZk9XM0hOYThBeEg1Zzk0c3g1akVrSStGdW5PN0tCZmFQUHJnUWhs?=
 =?utf-8?B?Z1g3eVAraHdSVmFFbzRVOGFycnptNWRVYUJwa2JtdWM4Zm9XOW5rR21PdzRv?=
 =?utf-8?B?ZWQxVVJKU0dTRlduZVdudkV5YXM5SEgvc2xKMXRhcnRwSElITEtKQlR6L0ly?=
 =?utf-8?B?K01FTFhlU08zRUdGZFhiQzIzbC9ncnRKWEYrdkxXSDd4R2hUeU1ZNXREM0N1?=
 =?utf-8?B?SjZNeGpPcmkvQ09JeVpER0NCeDF3dmFtMVZ6TVRUVEJsUURNVjVsNHBGUUc2?=
 =?utf-8?B?YVhYTDBwdmIrZ0RlM3YrUHNZaTkzTXVXb1hra3NnU0Q0cHpWbGpFeFJiS3ZL?=
 =?utf-8?B?K1dzR0xib0RBamdtcVlETCtrT3Juc0grTTRSekI4cXl0d2RFQWh5QkM0SDF5?=
 =?utf-8?B?aE90ZzY0T055dURtQXVkc2h1bzVCVEtWekttd2NGU09jOTlIWUZPQkRodkVW?=
 =?utf-8?B?QzBqZWVud3ZOT2g5MHhTUTczWkFBVTM2Nzdrb1p5clF0aVF3TU5NUVNlcTFN?=
 =?utf-8?B?SnpRcnpCM3hyNWhhSW9aRjRJdytyY1VlanNtc1JUNG0yNVBKaXUvV0JENVJH?=
 =?utf-8?B?Wm5VWFZESGhQMDFFUnFKUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2NCMnFZNnlTN0c5dmQyUjRGbGZnR2FjTVZmS2QvQ3krT0xFaXNPNlZ5WVMz?=
 =?utf-8?B?NTVRenNkbk1CUWNCTXBtdmdZc3FlK1d1a2lIM0xLSS8vZjhGUEs5RTR6WSt5?=
 =?utf-8?B?Y1BPa2pLV09DWUVOYlMwU05IU1FaSUQ3YXFqbUcwL3Z6VXpybkF2QUJnT0pF?=
 =?utf-8?B?S2phZmlpemROSzRSa2ZyaWJWaUhVR3RlWnV4UG5IY2l5VzM1bmFKVk9YeWt4?=
 =?utf-8?B?OVZVVUpFTWFteVRCUDFucUFHcDNXcFZFSTAzdTFqbkJjK3RNYXhFKysrZkRl?=
 =?utf-8?B?ZDFIb2pjVGhsckIySlBKYXZ0ZkJMMDhvL3MzWVlNRmZJSDhiUDcwK0dVMzBa?=
 =?utf-8?B?Qm42QUZsRTVxek9jRUFYTHJ1cmE2N0dyMHhtL2lTK2tMOHNwRmdMQ0dBbEJz?=
 =?utf-8?B?RlhMM1VlR0w2Z1FqT2ViSGFmcnJMTzhFSGliTkFTKzBpb2ZrT2RFQjJXVEcr?=
 =?utf-8?B?VHZ0WU1LNTB5dERmampzaDc5TjJnQzFrVUlhbUQ4clVHdGlSdWoxN2Z1NjVR?=
 =?utf-8?B?a2pZdS95Y0U2WEhTSlNESE5jZTR1czEvZnRaMWtvRlNLSUI5SnZPTEZScUNY?=
 =?utf-8?B?UE1BMjlNSWMxSUN2eXQzS0ZpNHVTc0c3V0FHd21uMmZ5MnREZTNEcXp3dTJu?=
 =?utf-8?B?WjVoVjNOZUpYb0g5NEhyb0J4cFk2SnJ2ZHBSa2VmTlYwa0ZYOCtXNG15ZlFr?=
 =?utf-8?B?djhScG05c29OOTlCM1R5OTRUM3BxME5HSjBkSWJpMUhmMkhEMVI3dGFZK1h1?=
 =?utf-8?B?dlVIMFZjaWR5VUQrQTVtb1NqTVdpdWlRcHFNUWhKOTlHTGEvOTBxZG0wYXR3?=
 =?utf-8?B?VFVvMkprd21LUyt4bUNxb0RJWmV2L2NhQVlpYnVoWStsOUtURmRwQWRieXdl?=
 =?utf-8?B?clU5Ymk0T0hXSGE1Qm9Hc2FRY051L1VhUTh4RVY3RWxQWDdQVkh6YytEa1VH?=
 =?utf-8?B?cVp1SFpPUVN3d0V0WjRzbW5VL3JndmpUKzFCVEdEWG5sZ2pVeHNPbmUrZEsy?=
 =?utf-8?B?WjNha1pGVDVkUWdRYnNyNXFoWWxtQ29qRStxa09FeTFuQXZNcTJTc3U3RWFE?=
 =?utf-8?B?SEVuQWlJcGtRV0RpTEtzOWZESkkxYjQ0NXlDdzYxbEhPRUZQcjZOTmgwT0FL?=
 =?utf-8?B?R0tWbWc2aG1OZXR2SXVTWEVrTCtFM2ZXSHd1dXNtUXBZdjFYWStDbFZ2eGlU?=
 =?utf-8?B?d1ZWUDBxQlpacjZWbmtkR2tNOXNDU29udmJLWlRxbFZHYXA3Qmh6K0VQTWpx?=
 =?utf-8?B?bFBuL2lPRkpWaFRicXNCTS9CVXhtNWE0N0QzMy9TTkpDNnVtcGtzSnRoOFdm?=
 =?utf-8?B?dVdkK09RSFdRb2ZyaXBXMzNLY0MycWR2ek9IRjd0d2xqNWU4MkRoOFkxU0lD?=
 =?utf-8?B?dnBkeSt4WUZzYmVDY2pMaUhnMXVwR0xSV093ZkY4ay9MOEV3S08zNXhMbWhW?=
 =?utf-8?B?ZEIzakE5TnRyUklaOW5QS0k0QlB1SkVRc1ovdm1MdDJiaDRjYndYVUgzTzF5?=
 =?utf-8?B?ejJhWUFQZndOU2wvN0NOZlRUbDRjbmo3QWk1aEVyeTlaYmY5Y01CVmd4T1dp?=
 =?utf-8?B?Rk1VQzVKcGZzUE9rN1ZrMVJxREZEZk4zSkxNaWVNU3NDTEpaN0NaanNQdS9C?=
 =?utf-8?B?U0s4M1VEais2cTdrdGc1U1lMYjBURVE3Mm9xTXAwQVgrMXNwN0FaMHJaLzda?=
 =?utf-8?B?Q2M2N2FsZDRSdXM3ME44S2MwMUZpNElsMExjQ0R5YmdIdEpDY3pVejRTd3Fa?=
 =?utf-8?B?emZCVzJUVjRHMU9ZMnlOWFlZUk5OM0YrWEpvdmdXcWNmQ0E3NTBwblZpSHRn?=
 =?utf-8?B?MExEeXlUTWN2aDFIVFA3TVkvSU1zbWRFbXZ0V3Y0dWJwbHpqcW1NV29uMTla?=
 =?utf-8?B?N3FXazYzNzFOUFh0MDZYWDJTNFZMYnVtMmdCcEdKSC9VSzJtZEE4cEJWcmNE?=
 =?utf-8?B?cm5maDlHWHNYdUVDWmFJTFVvamVtR0x4c1ErbE4vMlc0L0RwSC9GMjZMYXpF?=
 =?utf-8?B?N0pHY3hmdHBEOFBsWFNkMFA3RnhNUGRydFZYUU8yNFc3OVY0QzdpUzFIYS8v?=
 =?utf-8?B?cllPNmdBSVZ3WjVoOVk4Y2J4R1BZRUdncUVRMElGdVpqWFA0aG0vSlhDWDFK?=
 =?utf-8?Q?pgDLgyFFa9GoFKeBSehkgX3g8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1193befc-e786-49ad-8974-08dcc80ed41f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:41:59.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Poh8VA6JSd9APxNOtKarZLD0DyyT5iQ3jnRjC3/X0XskKiP9s0hSaJk8jnbdyVpXTIBS+P0DXrrK+/C92e3Tcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

Hi Sean,

Thank you for reviewing my patches.

On 8/26/2024 9:36 PM, Sean Christopherson wrote:
> On Mon, Aug 26, 2024, Manali Shukla wrote:
>>>> +struct buslock_test {
>>>> +	unsigned char pad[126];
>>>> +	atomic_long_t val;
>>>> +} __packed;
>>>> +
>>>> +struct buslock_test test __cacheline_aligned;
>>>> +
>>>> +static __always_inline void buslock_atomic_add(int i, atomic_long_t *v)
>>>> +{
>>>> +	asm volatile(LOCK_PREFIX "addl %1,%0"
>>>> +		     : "+m" (v->counter)
>>>> +		     : "ir" (i) : "memory");
>>>> +}
>>>> +
>>>> +static void buslock_add(void)
>>>> +{
>>>> +	/*
>>>> +	 * Increment a cache unaligned variable atomically.
>>>> +	 * This should generate a bus lock exit.
>>>
>>> So... this test doesn't actually verify that a bus lock exit occurs.  The userspace
>>> side will eat an exit if one occurs, but there's literally not a single TEST_ASSERT()
>>> in here.
>>
>> Agreed, How about doing following?
>>
>> +       for (;;) {
>> +               struct ucall uc;
>> +
>> +               vcpu_run(vcpu);
>> +
>> +               if (run->exit_reason == KVM_EXIT_IO) {
>> +                       switch (get_ucall(vcpu, &uc)) {
>> +                       case UCALL_ABORT:
>> +                               REPORT_GUEST_ASSERT(uc);
>> +                               /* NOT REACHED */
>> +                       case UCALL_SYNC:
>> +                               break;
>> +                       case UCALL_DONE:
>> +                               goto done;
>> +                       default:
>> +                               TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
>> +                       }
>> +               }
>> +
>> +               TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_X86_BUS_LOCK);
> 
> I doubt this works, the UCALL_SYNC above will fallthrough to this assert.  I
> assume run->exit_reason needs a continue for UCALL_SYNC.
>

I agree, there should be a continue for UCALL_SYNC in place of break. I will
correct it in V2. 

I didn't observe this issue because UCALL_SYNC is invoked, when GUEST_SYNC() is
called from the guest code. Since GUEST_SYNC() is not present in the guest
code used in bus lock test case, UCALL_SYNC was never triggered.
 
>> +               TEST_ASSERT_EQ(run->flags, KVM_RUN_X86_BUS_LOCK);
>> +               run->flags &= ~KVM_RUN_X86_BUS_LOCK;
>
> No need, KVM should clear the flag if the exit isn't due to a bus lock.

Sure I will remove this.

> 
>> +               run->exit_reason = 0;
> 
> Again, no need, KVM should take care of resetting exit_reason.

Ack.

> 
>> +       }
>>

- Manali


