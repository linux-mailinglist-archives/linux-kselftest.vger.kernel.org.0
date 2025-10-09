Return-Path: <linux-kselftest+bounces-42931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2431BC8E11
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 13:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 356FB4EAF15
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8DF2DFA3A;
	Thu,  9 Oct 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IeRcM7nf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D11A2545;
	Thu,  9 Oct 2025 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010266; cv=fail; b=kSo34Jksmq26S7XXppODspwBaeMMQSPIQo45L0cOBByMIoZ7x/89qrSiANB3vVoaMj+UEnMe+tHAXqeO4lPrGvr04SoviuNTL2FjuoKCIY9k8U/kdWye2h5xKx56fo4K3AWn/BDUFDNWQ8R+cltZyQSig58YA9BDppBVOPgtqqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010266; c=relaxed/simple;
	bh=6HxE1ZJHhscSAQnxjyDYXxC65KNU/odQZRWFCR8kaRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VekNLmiycLwSrtTtGDP+lUozHLUcbJ8e0JMZLiznIO9NvavakClayRQLT2l08iraCRehBUyuwR5nPiono8cUkFLjZD3hFi1urSB0Emda2Ue2lyQpk7KxiIewFvSzv8aKf1Lz8OOA1ysOKLEVgOvJfX0r/9jvL5mprLWBZJwVSdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IeRcM7nf; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMSjMvsAPOFRZ1+VWuLWGTAgkqtVQxKuGVzRyXv3S4xJ/9IzUZYNe+b46OhnfzywRPANzw5PTWN+y0mrXzjfgqxw6zBAfJD566x2MNBkUEpDEztZasMcWAqv+BJ2PNLdsg/8Du177QQ/k5ShGffLv3O4C2+izL9Xp4vz8rYmJIwIR/xOpZDVPPJvxN8Vxq9XrpcDnLsZD4xIAXxZb/prcgvT+v+qKpoo5+G5CJFGH2ULgi0tqAuaQXy/sK3pVs+kv3j2PNxZ35c4XK6nXvMmvKsEKRumX7eeWmuRYntt3ViR5JwQDxCBiHqwpsZSBxYTyK/WzFJDZElb2OAtzn5jvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmuadwxD26qiWG5mYRsRfgEKCgJAaaa+7UYcpmAhwdc=;
 b=SEjmi6JdC+uirPbQ7YIRk8wabUGKYLZOJWhlp1T4Abd+ELvR3shvTgVZxexEHZQ0RXqxKJdEQM4gZ5tXYqqPlj51zknxAIm8aEFrcyM/0LPZ7eSqBYPW5c4Hbbi7GidV9uKnEQLySV82CS9+z6iqWz7nprZvXW7dRkTFW9IbHrDYgwSGEC7NU76fJM+Cs/uR6hLdj5ft6MvNf/VmxHWTx29JxFmlUbuc4zHIpEieTByXffTgwEldYTJ91iTdCpQLtr2z8FXlGRDd8eXli1BPDpCuPurGvvG1ug2NkGLYxb68n8sueVtBcgjbEi64kUk61j/IqHpdbmMlrCkGKuCNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmuadwxD26qiWG5mYRsRfgEKCgJAaaa+7UYcpmAhwdc=;
 b=IeRcM7nfLVlxUhzbSNPMxE+D9lAKD6yxKbjvBHr1S0MoCEOhxZZeklEfdkwRptrvCbwjlpjfh2CxBFr3xKYTfDdKcs3QyxL9XCJ8fQB8Zk3z7y3S16ulI/vqaN/QtH31JfVI08zll9E780oi12oF2WKganfSg7cjICYOE28sYps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 11:44:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 11:44:18 +0000
Message-ID: <23116fce-b71c-46fe-a7a0-c2a01a7592f1@amd.com>
Date: Thu, 9 Oct 2025 17:14:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/15] iommupt: Add the AMD IOMMU v1 page table format
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <4f50b0f3-c62d-452d-9a39-5c47ac201d01@amd.com>
 <20251008130813.GB3765120@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251008130813.GB3765120@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0099.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba6ff1e-c539-4432-6fc0-08de07292e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1ZuMEs5dW5Ud1dLeWwzdjk2LzIyN3U0VU1ZV0NYNjVUOE5aT0FKOExSQmFG?=
 =?utf-8?B?dXMvdzNrNlB2bmdNTGZkMXpnTU5NcXNlRzNrdGhBTWZ2N1dFYWgrMmgrQzhE?=
 =?utf-8?B?aXRQNXNRSjhLc1JKck1tL2JhSlBMU253Y1g0KzFpbG9HaUl5dEFxWGk4K000?=
 =?utf-8?B?SlJaa01OSW4rd3gzdTZaOFQrK3lCV2lPaUVVSG9RL0llMDl1Zm1HRFRpR2Nx?=
 =?utf-8?B?Zk8zMXZvZTFEWjFKV0NYOW1MRXlhc0crQUFocFZCR0tzcVBXR0RpT1lQcmtR?=
 =?utf-8?B?Q2taSzIzSWlTK1VCNWZsdENnYVBEMVFwWGdKV0JrLytnWHROZEMvTThBbTFy?=
 =?utf-8?B?UDltKzNLUmRMSUF3T1dIY3AzeEdtVjhSNXFMano1emI3dU5EN1UrWU9uT2RU?=
 =?utf-8?B?K3VMM1R4MVZEeUxQUURnYXZxNFNBVlU0em8xckEyaWw4ZDNiV2NKTVFDTEpo?=
 =?utf-8?B?UGh6OU5OU01XVjlwLzNkQjdtcWRmT3VXQ2k2STUzZXlxMFcreEVSWnBpNDFN?=
 =?utf-8?B?Y00wQlJYNWtiOVIzVHZmcVYxSjkraGhFU2NLcVF2a3NpNkIvWUMzcE5PQW9o?=
 =?utf-8?B?WDZyM1ZjYlEyMURWeUZtODJaMUYzTWlqOHNTNnRubUtYQU5xd0FkOHovZzQx?=
 =?utf-8?B?ZnBMcnNpdDdWdFMxZHJVZGVYbkQ4ajVXTjlPRHdxNHdUZGpObyt2Tkx2Tk8y?=
 =?utf-8?B?VmxwRXJPOUhkK0Z3TnRtR09mb2svbElQZG4xUVA1bmdjUlBQbmc3NExiUU1E?=
 =?utf-8?B?SGhrVzdrT0Rva2NFUzhOSGxMSFB1US85U2FpdU1VRXBUQkJYaVUwdGxTVjEy?=
 =?utf-8?B?aWFTazJXU3dyVm1xNFFHekYwdTducG5SN1lHNmYvYngxdUhiVkR6YndlRS83?=
 =?utf-8?B?Unhmb1VFaEhEVHVGQmtNWmgvdGRQMlcxOXZLcCt4RG9KbEtGL3hoditNemYy?=
 =?utf-8?B?cU1JVlZqeFp5NE9sQlNPeWZMWUlSWFJUVVpOb3V5eTZGOTc3TWdTVVlnVnk2?=
 =?utf-8?B?eFZJeDlFS3YxTEpCaTlScW5aYkt2MlZEQlhEbzNuSTcvVytob0RybXhSblcv?=
 =?utf-8?B?eWppWUlhc01ROVJmOXlLMnJSVklFT0M0ckVSTEwycTdTNld0T3V5RDBGN0x5?=
 =?utf-8?B?Z01iUXMzbHRWRk1UV2IrREVwZlJPaGVKNGdiVlJtN1ZuYkVpbkJqOE13aER5?=
 =?utf-8?B?Sk1mcTNkSml0dmFKVEYrVzVPOTFsakU2UjJnQW9GVUdWbHhwQzdIZGhGUjBi?=
 =?utf-8?B?SHp3cVM0d1pYeVFHcTA5NlNvQW1DWUo2ekIvMER1dWpHRXZiaFZXR1RrcjJG?=
 =?utf-8?B?dzhuS2x1c1V2OWtvMFpqRGhrRHQ2d2NMdjN6N1ZibHAxSWhvVFBoTnRsdExt?=
 =?utf-8?B?bTJMN0tjejlSQ0R5ZGhNWWNxOEU2Ni9EcjljQVBwUmNYNDNqdTE3MkE5Mm5N?=
 =?utf-8?B?L2JzUDBIOWsvYkJrNUtnYVd5K1NFeUdJYVk2NUhPY0xqRFNWdmwxaW5rOFVo?=
 =?utf-8?B?SERMaEo3UUswK2cyS0Q1N1V1ZzRKOXdjVTVVRjBJZW85UC9WREN0cEdDUHRq?=
 =?utf-8?B?WGxFeXdDZGEwR1hhcHVmZFJ4Vi9QWGNWQkdOVGNjcHo4QzYydlpXcEV5NmpT?=
 =?utf-8?B?ZWtFU0ZSWml0dzNydWVoc3BYQXhqNjdnTndvckRTcWRWbjBGajBXcnpxeDhS?=
 =?utf-8?B?cG5rNmVMNzZ4YWp0bTFwdnpkcS92ckZCMVJMU0VYSEd2clAwdlc2K1B0TEQw?=
 =?utf-8?B?UjNCOGcyZkJ5NzFSN0dwZjdrVmZDSzhlM3Z4Ri9HUytKMXBXTE5Yd2diZjdH?=
 =?utf-8?B?OURIUk16cTlpNVp0L21pS01jTUxEWHl3b3hpV1REbGNWU3VWSHZaZnFOVGkx?=
 =?utf-8?B?RXFJSmxLT1p3cnR5UnpISDVwNTVIdUl3Q1dMd0Vram1ZSWZCQjhPbzN6a01K?=
 =?utf-8?Q?Gz/1A6Ikqq+/xeI0vn/jw5d5qF5RtNVy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWl1UCtvVlhCU1NJY1dlc1NnOVdPbXE3MWpFUnRlUks1Wmo0SDNuZ2ZoU1dY?=
 =?utf-8?B?dEI3MFlucWpRSWU2WFUwQmp1aHZZRHZGUTY0d0cwQ1FDMzZpZnMvNld1Wi92?=
 =?utf-8?B?TXRwUlhOOUdOWW5JZ1luc1hKQjNMYWRoOEFib2RucU1RbWhMY3FYTVIxSkpu?=
 =?utf-8?B?Wko3Q3p0WGdDSDNxUmc2eGFRNTcyTVBmbDAyZ0JkN05DSEUrMTVPTHdPQTdQ?=
 =?utf-8?B?dXJoNEZZYlVmcGx5akpyai9kZG4vdEpuV2hrU2tzSG1QWXJKbTJYOVFsYjFJ?=
 =?utf-8?B?eURuTDVtc3ViYmxjWGhUaUxZQWVnS1pjUC9DOURzYm41TjF2MFYzWUdETFZy?=
 =?utf-8?B?OTU3Mlpxbm9QNW5VaVpPazE1YUkrY1R2bTYreHBnUWpYRmQxeHJjalJmemJN?=
 =?utf-8?B?bklkT2hVc3hLUEVNOUNVSUxjcGNsREVlMTB1VURqV2YxUk10bU1LeWhmeHUr?=
 =?utf-8?B?TFFWMW1ZdjNObis1SzUvSG15aXZJQUEzZHpBVWc5OVNZQzBLYXc5eld0M1B6?=
 =?utf-8?B?d2JCam9yK3BPK1dVWkI0U3dhZVpiRitJYk82anVLWkllU3p1MFNmcklSQ1ly?=
 =?utf-8?B?YmdVU3VhRjcxYUorZ1NFbDdtVjhsV0Y1K1d4L21hSHVHNTJZb1hySVBxbkds?=
 =?utf-8?B?bWozcjdWaFFwdnBSUFF1N2ZsTm9tRnpadUUvTEFMdWhTTCt6aHlTQUh2cm5Z?=
 =?utf-8?B?RXkxTXd2SExYREk1RDJ1OXFPYkg3a0lkWjBJSDF2UUU2S0FuTFZoL2VzbUlN?=
 =?utf-8?B?ZVVpem9kNGoyTUNiSUlUdHpqU3R5UUNaeld0WEpEaE84Q2VyMmw4Tjd4aDFj?=
 =?utf-8?B?TnBZaVVZdE9TSmdwa2RmNDVFZktFMk00ZFFEYzNnMTBtMFk3K2xva3BhNW1o?=
 =?utf-8?B?OWEyWkIwUkdjNnpCbmdLdjBZOHhodUphQWE1SDZnb2xaSVdyTWZMaXo3R1dx?=
 =?utf-8?B?ckV5QlNOVm15bnBqdlBPWDVISmt5bjNNdW1CcTJaNTNvcDI2N01tbG9kbEE4?=
 =?utf-8?B?QS9vTE1wd2t1TEIwbU1NajhDTXlhZSs3bDZMMWNDcHRLZDhnNzZHdFhmTk1R?=
 =?utf-8?B?UENCanZRa1gxYmUxaWlzN0tHVDNGSlQ0d1dKQUg3aFZpQldIQVl2ZTRZakRQ?=
 =?utf-8?B?a3pvS1FJUHRuU05XcjIrc1pZcVoxdG10b1FkRVl0NFM1SGtXMDdDUVBiNElv?=
 =?utf-8?B?b2VkMVpRekxEWWUzMGFJdnNNdWZ2SlZSM3o0MHZQWitCSGtWbDRYRDZwUTlq?=
 =?utf-8?B?eFBhWTJZRWc4Z3JKbk1NQ1NMZmZxb2NoYnhEZDlDQkZ4Y0V0QXBDcDhxdVNI?=
 =?utf-8?B?bXRudjJxTjdIYThSRDl4Q3d3UGNiMlQ5OEhJWVhucUdtNVZUOG1sNy9FSmNB?=
 =?utf-8?B?N1p2LytsOXZlKzZKNWVEWFp4anFjWTVRa0ZmSy9HQmtBeHNaeFY3TmJmd04w?=
 =?utf-8?B?dlVHaUZxUGptMGlQYm9oaStaYVlHeFlxNHY0WmRaTHVRM2xzbXo4UHVidjMv?=
 =?utf-8?B?dzdYbFg0V2JoZE1ab1l1Q3pRVzJFeGpXNGV2MXVHOWxoemVHbDE4TUVrSlBV?=
 =?utf-8?B?UlJPVU15NkUrWkhDSHpNQmlLQlpkNjlTNmlSQXVyQk0vblIzLy9pY0Q5aFNZ?=
 =?utf-8?B?cWtNVDd4UDVwRFBJMVhWanIzZFVmRGRKUkJrQ045TW9CSVg1b2xHUEU5Uk12?=
 =?utf-8?B?TVBMdUJiaXBrb0hSblZVQUFobFlJMnpXTmZjMU5wejkrYzRkUUZKV0N0cWtH?=
 =?utf-8?B?NEpEQUtzcTcrS2FjSWZTV2huT1FUZjN2TlN5c1d1a09PdW43cUlaZm1RZkVO?=
 =?utf-8?B?M0dvUjJpQWtRSVFvVS9qR1p2T0pocWhFV002aVQzazlMcFVZbUEyd1VpNjRR?=
 =?utf-8?B?NUIzTno1Mmk4VE9VczNkWEYzTFVhcjNScFUyNG5Ed3FlS2gyTldTYWNlRmxC?=
 =?utf-8?B?N0tEWFkrUkZKYkhZZmNFZXNqWkRJeFRDeHpDN0dkejdxTTZtRXVsTXZlb1dI?=
 =?utf-8?B?ZFUwRlZXWGRuNVpkdDNYOTBQa242cnJWUFQ1bUZ4RkM4aUt2Wm93c3Nqd0hN?=
 =?utf-8?B?RXJKTnlocG1hT2didHFlaUdHMlZLNUxtb2wrWENVaTB4T1RYT3FNQmRnSEVX?=
 =?utf-8?Q?NgtTdxPUu4bXW4fyqTaAldq7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba6ff1e-c539-4432-6fc0-08de07292e64
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 11:44:18.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/MlDBvCWyNf7yWcPHsyZ9/txx+DlDLUiech5gt7vBKve1+FtkeYxWVfJu7hIVjn0pwtRsKKX4XX1f6zZUyhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789

Jason,

On 10/8/2025 6:38 PM, Jason Gunthorpe wrote:
> On Wed, Oct 08, 2025 at 03:13:32PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>> On 9/3/2025 11:16 PM, Jason Gunthorpe wrote:
>>> AMD IOMMU v1 is unique in supporting contiguous pages with a variable size
>>> and it can decode the full 64 bit VA space. Unlike other x86 page tables
>>> this explicitly does not do sign extension as part of allowing the entire
>>> 64 bit VA space to be supported.
>>
>> I am still catching up w/ entire series.. But here is few fixes needed to boot
>> this series w/ SME.
> 
> I got them all, like this - thanks a lot!

Looks good. Thanks!

-Vasant


> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 92095fd17b3899..0b97db94c8c4e0 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2054,7 +2054,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  						       &pt_info);
>  			}
>  
> -			new.data[0] |= pt_info.host_pt_root |
> +			new.data[0] |= __sme_set(pt_info.host_pt_root) |
>  				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
>  					       << DEV_ENTRY_MODE_SHIFT;
>  		}
> @@ -2166,7 +2166,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
>  		return ret;
>  
>  	pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
> -	ret = update_gcr3(dev_data, 0, pt_info.gcr3_pt, true);
> +	ret = update_gcr3(dev_data, 0, __sme_set(pt_info.gcr3_pt), true);
>  	if (ret)
>  		free_gcr3_table(&dev_data->gcr3_info);
>  
> diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
> index d7660d4170ef78..26e29b08a9b4ae 100644
> --- a/drivers/iommu/generic_pt/fmt/amdv1.h
> +++ b/drivers/iommu/generic_pt/fmt/amdv1.h
> @@ -73,22 +73,29 @@ enum {
>  
>  static inline pt_oaddr_t amdv1pt_table_pa(const struct pt_state *pts)
>  {
> -	return oalog2_mul(FIELD_GET(AMDV1PT_FMT_OA, pts->entry),
> -			  PT_GRANULE_LG2SZ);
> +	u64 entry = pts->entry;
> +
> +	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
> +		entry = __sme_clr(entry);
> +	return oalog2_mul(FIELD_GET(AMDV1PT_FMT_OA, entry), PT_GRANULE_LG2SZ);
>  }
>  #define pt_table_pa amdv1pt_table_pa
>  
>  /* Returns the oa for the start of the contiguous entry */
>  static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
>  {
> -	pt_oaddr_t oa = FIELD_GET(AMDV1PT_FMT_OA, pts->entry);
> +	u64 entry = pts->entry;
> +	pt_oaddr_t oa;
>  
> -	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) ==
> -	    AMDV1PT_FMT_NL_SIZE) {
> +	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
> +		entry = __sme_clr(entry);
> +	oa = FIELD_GET(AMDV1PT_FMT_OA, entry);
> +
> +	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, entry) == AMDV1PT_FMT_NL_SIZE) {
>  		unsigned int sz_bits = oaffz(oa);
>  
>  		oa = oalog2_set_mod(oa, 0, sz_bits);
> -	} else if (PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) !=
> +	} else if (PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, entry) !=
>  			      AMDV1PT_FMT_NL_DEFAULT))
>  		return 0;
>  	return oalog2_mul(oa, PT_GRANULE_LG2SZ);
> diff --git a/drivers/iommu/generic_pt/fmt/x86_64.h b/drivers/iommu/generic_pt/fmt/x86_64.h
> index be2a0a770f903f..d33b2fcd865b84 100644
> --- a/drivers/iommu/generic_pt/fmt/x86_64.h
> +++ b/drivers/iommu/generic_pt/fmt/x86_64.h
> @@ -79,14 +79,22 @@ enum {
>  
>  static inline pt_oaddr_t x86_64_pt_table_pa(const struct pt_state *pts)
>  {
> -	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
> +	u64 entry = pts->entry;
> +
> +	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
> +		entry = __sme_clr(entry);
> +	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, entry),
>  			  PT_TABLEMEM_LG2SZ);
>  }
>  #define pt_table_pa x86_64_pt_table_pa
>  
>  static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
>  {
> -	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
> +	u64 entry = pts->entry;
> +
> +	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
> +		entry = __sme_clr(entry);
> +	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, entry),
>  			  PT_GRANULE_LG2SZ);
>  }
>  #define pt_entry_oa x86_64_pt_entry_oa


