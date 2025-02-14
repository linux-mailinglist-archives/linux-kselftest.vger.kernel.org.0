Return-Path: <linux-kselftest+bounces-26679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE20FA36583
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 19:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3E97A1734
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 18:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF84D268C69;
	Fri, 14 Feb 2025 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YMatHjwu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BAF268FD7;
	Fri, 14 Feb 2025 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556743; cv=fail; b=S6VFGSH8nv8TfDmnNEOxo7+x8IFokyDpiqhwd69x02EL1S/AU9SOn9lDvsS/RhzqONMLhTRxk8YAnL0E/ZMIlukCMm22Jr7vLN7U8HUT8PhFHCm4Zgifmq3Cf3GUkTO39XpIA+u9qWodnKQCWGSiSu5T9ORgjExsUJ6UbP3UuBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556743; c=relaxed/simple;
	bh=Jy6KzncL6w2NoKj0iijFoP9bDz/DX6totiVLuQKFUlc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q++bflZMrUoJg5mHdlxkIXUv/+GH3vYVYvA+TvrjStrSELrWYOIqr2pljeqzTzoHZN0qIKAUHvG+Ue1972Jx+9k37xEshim1IZIcxr0XncPpp6RVBV64Df+W2fhW63bMxgQuOoffKcXkuyvQ8gulc4BZy/h+qyPxKkNaG/FlJAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YMatHjwu; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSo8nNBNQe0No3quJMln5aDfg1eqBDePkkhHfNt3dr964ye/Z7FhUcGaSoo0BNplYS9PkRNDIjSYEvIBsK8dfVeaIuESmMarYzjzQO4Lt/oGqc0ALGevP+ksiN8lIHSBgxXI6FcEmhGJbKzRQyH/UnYEd5htEvMd2/0LZVnF4sE98W5NehKBiLVbXy9WZAjLviqRugP0WChRNBN71wNUyKbGj9cb/EDisLnSCWK8sNLZCxKycs9Xq3HztfgPS/ejWj3koLP/AUprZ9YTkHT3Lai2EwAlpwbrNvHN9cc6EIyod6wqNgB4clAdMRSRxp11GC3f0la/tRq7hCcqtumIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cjhq6kkUyImM7huZY2JmAPwlynmUjdC0B+hCOyU+eLc=;
 b=XDaHQbzGGlenUEQIqnAaME8pUrYTEcLPtUBU+w/EB5X6Ljb5hRO4Aun/p2qUb9GTxmz56+gaiFVpTC8HPCbPFo3787OFoIVKP+vNFZTjmyHpiiqJwPUxKOdTbT4rAuan0FlB3TlPraA4YblFNXMSWc5PF7D35TV2+xOOnLo1tU5aTudqAPxaWwdrtblKrlvMf+KW0KLhbNi/6105V1XEH3hTaHFaSV2fjttlrNrBiiUmol8s70S1+Zj9QkJraxT/xg8Mt54791XpJJkfpnVBP4D0b+9RwEeE/iCI3tmoVx+0XEy3z1oAINHEEqzmI334fXi00wusYpvuUY0sylCIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjhq6kkUyImM7huZY2JmAPwlynmUjdC0B+hCOyU+eLc=;
 b=YMatHjwu75+eIoF1DVzznejqa4WEkKmI6lxUXEMLZT6Wt4h+yFYAIODHcxMcZW4Y3jFWAn8eg3AO1E+0QqBRHnwEFbehZ4lHzB1oZBJk81uVjrvKfJjs7/8JtA8fn0l7X0gxTXNPB6GvrEE0BBgLRAn2+2PePXvgHm+C14Jspng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 18:12:20 +0000
Received: from PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f]) by PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 18:12:19 +0000
Message-ID: <ecaee27e-c121-4831-9764-043d2e6230cf@amd.com>
Date: Fri, 14 Feb 2025 12:12:18 -0600
User-Agent: Mozilla Thunderbird
From: Pratik Rajesh Sampat <prsampat@amd.com>
Subject: Re: [PATCH v6 6/9] KVM: selftests: Add library support for
 interacting with SNP
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250203223205.36121-1-prsampat@amd.com>
 <20250203223205.36121-7-prsampat@amd.com> <Z6wDiOGjSElatLBd@google.com>
Content-Language: en-US
In-Reply-To: <Z6wDiOGjSElatLBd@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:806:d3::24) To PH0PR12MB7093.namprd12.prod.outlook.com
 (2603:10b6:510:21d::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7093:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 4645b251-8f1a-4000-31b3-08dd4d231f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTR6T3gzZzNNWjVtbWJVOElZUXNmOU55djc5eHNZalRPYWRETk00c3F2K0x2?=
 =?utf-8?B?M0FUR0wyeDkweWlMbENjTzBzaWx0M1I1UHhna3BZL3FGZTJHNkRvZ0drREls?=
 =?utf-8?B?TTcyYlFjNE5PbmdGRnF6d1B2c3hkM0lrdjhiZUJHc2JGblNiT0h2UytvUm5D?=
 =?utf-8?B?MXQ5VStvaWwwTElicFNkMDBlN3YxTE45bjFhRm84Y3ZxSXl0aGEvRncxc0dv?=
 =?utf-8?B?TEpzVFhQWUcva2oxRWR6NHE5RjJIY0V5bkgzUStuTkVVM29iVG5GV3paTFpw?=
 =?utf-8?B?dW9yaEUvWWxaVmtybUNDMCtwdysydDBuQjFaZDhJL1ZVN2dVUXhJbFhFeGlm?=
 =?utf-8?B?SFdHVWR5cnFJYkVSWEh2akdXaE1nYlFkcFVTQmZjNWZud1VDYzlIbXk1d0F0?=
 =?utf-8?B?WXoxbHhZRGVpYzBBWlljQTdDOHlMVWJ0ay92QUcwTEhCekpJRnk5V0MzcHlN?=
 =?utf-8?B?Q1AyRk5UaDVpakhVTHg5NG9zY2RLYzJldmcrTFdsOHZwMC9oNVZCWFR2a0JD?=
 =?utf-8?B?YmNVUnFwVlVIWWRlRi8yaDQxM1JhZ0taZElUWk5tTXJLNDl3OUlwbmVVV0Jp?=
 =?utf-8?B?TytwY1N0UGFYVWJTTHJPY05ma0VCeVcrN0VJaDdHUVlIalltNjlXRWNPNlRN?=
 =?utf-8?B?ZXcxaVZ6VTEwaTZhV2g0TWJBdmtkSEFCa3pMeXpMMW52SXo1dVFiTUtxRkhL?=
 =?utf-8?B?V3lIbjVIY255RExFa1FJSWhaeUhGblpub1lXNW5EQm0xQ3BUNG1OZkN1VHdh?=
 =?utf-8?B?dU1rM1Q5eFF6emlLUlA4N2VOeEVLcmw3MHJzRzFVeldhSXUzZ3ZweTM1eGVa?=
 =?utf-8?B?RnNrNVJxREo5SWYwMUExbURkVG41R1RrNXhwcTlQaU1RaGtCcHlyQWRhWHRi?=
 =?utf-8?B?Um1ReG1lcmxSRUl6Wkw3ekkxSFhIRmZRWllJbno2QjFvaUNZZUM1dCsvS1BD?=
 =?utf-8?B?ZWhGMnYxSVNNU1NWWnoyTDU3UGRxWlBHdTBhQmVXL1N1QjlRWmtKRnQyV1Rt?=
 =?utf-8?B?Sk92aVVkeFJxNGxtTVBscWt4RlBCSnQyNWhDaTlLekNldlIwM1RLREgzUmNm?=
 =?utf-8?B?WENBbSsvL1QrNCtSdjFlY1FBc1dUL04yblR5dFJkSUI0T09iOEptb0pzeWVm?=
 =?utf-8?B?cGtjM1NQQXlzdjJHVURRSSs1Z1VjLzlGSSt3cDRYNkN6cGJZL1V6eW91QklG?=
 =?utf-8?B?TVU5VDhVU3BWWXFSMjFYcFZ0Mzg5WDZ6a1B1RTRYQzRDMEZtR3prQmxvZzBp?=
 =?utf-8?B?V2JLNzBmV0Eya0piTnhWZ3NZczhkbGdOSVlxSm9ObEYxdEFLQ2dCZ1pDNVky?=
 =?utf-8?B?S3dwdldkMTRRaFhXSXpjRmFMemJEbkpTcFJENVpKekFVL1dVZTFrRExPdkVM?=
 =?utf-8?B?SkxqdU1hUVFSUGdJdHVaTGMzaTk4QThLYXVsUUpFUWt6OW1haDgyeWFpQS9U?=
 =?utf-8?B?KytZSHppZlpaU3QyWW4vR0pnTUhweUMxaEVCaG9oOGxoN2VQZzVncWJPbTFr?=
 =?utf-8?B?UU1uV0pvSFlzTlMzYXJzUWNBRWN3WjVlSTJwWUM0aUU0eFp5NkNQS2VPcngw?=
 =?utf-8?B?U0dKVmF1MU55dUZLMHllVWljN0xGdWpiWXBqKzBvUXpDVVhGbzVwOVgzek5U?=
 =?utf-8?B?eGIyYTJQa0JwUXBaR3RvRGwzWDJhUnMwL0ZSUXFwc2ovclEzSXMzYlpKNUVG?=
 =?utf-8?B?WWVPNHRqL1hCd01QQmNCb0JEc0d6YWwycG9iZlRKNnJGR1k0VmRwOWg1RlJ5?=
 =?utf-8?B?MndLM1E2c3ZoM0lNR3hpWmZReHVSWmdLcUlGZlZRUW5TUzRsWUFEemtqZUdm?=
 =?utf-8?B?Q25kSHBTdnh6M29hcHc1d3VYNG9uVXFESXRFZ09wTktEMWpYdjkzclU0WFhE?=
 =?utf-8?Q?Jn3Yaf7aknda3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7093.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2xHUVZBRkhLMUtpVXlpdWJGTzZiSDJockVNMVlIQStSMW9SNHFiWGdiRyth?=
 =?utf-8?B?NSt0bVNOak9yeDRoOXNWNVFrQjBGM3lUQ2NIOCtsWWRZZk5zTFhnSi9EaFp3?=
 =?utf-8?B?Y2NXc1JTNTBYeXh0dVF6Yk9VeVlYcnBWeHBuWllrTWsyWUR6U2J1YTZOTlFL?=
 =?utf-8?B?TUlMMjZsYUJDeGRZQjhkVzZhWkFSYUJlbWlBQ1NWVWNiV01BSzJoTzJra1dk?=
 =?utf-8?B?a3Q5NS9NamxkU1E5SjRxSERVMkY0OTErNnBTR2dXT0cwRXFzMTMzWDh1ZnBa?=
 =?utf-8?B?V3hwQzdmL01wVVhCcEZMRTdTSlBua0FlRnQranNGS1k0a1JTRzN1UnVoWVB2?=
 =?utf-8?B?NmQvME9Pci9VdHRmazV0OVlYTm52YVNtL3h4MWVRVUs3dUNFblE4ZGNCQlp3?=
 =?utf-8?B?QU1iallDdlkvZ2creVkxVGgrbmtXaDI2dUl1dUxsbTV6bDlpLzdHOCtQWUR4?=
 =?utf-8?B?MmsvTCtnWUY5cGJRVDRNcVZNUzlNWThURGZJMkthSnNKWHU1RkJXS3p6YzF6?=
 =?utf-8?B?a2xhUXdzWEhIVVQ4WEhpL2pLRW9sWkJMeE9EUHd0cWdIQXcrU3IzWXhNWDlr?=
 =?utf-8?B?c3hkZWx3ZDZIUGg2MXpWM1JDOTZIVjlPMW1MVXR5eGJHbkFRK1Y5cHVUajBn?=
 =?utf-8?B?SHFKcDNINWIxN09ZaU40UmZCMTZYQzZJTW9xem9GUzRUcUJuQllGQ2Y5dTI5?=
 =?utf-8?B?bWs5UUdwNlJGUm9iZzJ5emlEM1pnL2I2U0VJMlRBSExYNDd1V1Mzc1dDbTdr?=
 =?utf-8?B?YnVWemgwZ1c5UjdYSHk2S2hDOXZzRWkxb3pPTEJ6Q2VvdUU4OTVYdjdrcWpa?=
 =?utf-8?B?MHMxbERBcElCYkNnNWRlOFpMU0pDL3VYdkd0UHRIaUY1aDE4YldkYWhocHMr?=
 =?utf-8?B?L2Y4cVRtQUVNTm92R2cyaGNkWjhYWHJlVGY1YXVmSWhOV2d4UFgxaGw0ZHBL?=
 =?utf-8?B?Zjl3U0NKRXY3RVZNbXoyTFpMQWpkL2x5SVpKUDJ3eTArMzhQUGdKdk1uMFFG?=
 =?utf-8?B?cVVFZFA3ZnE5ZUQ2QURYck1jRlBBMlZocmV6NEpYWGpvYmFaMjNPN1hMbS9j?=
 =?utf-8?B?RjFETmU0NWZjcGtyNWJjemU5MXAxMHJiT0gzTWN3VGZDQ1B2Ly82RHNxanRS?=
 =?utf-8?B?QWtVdlBKNjlGbjdJN281UlR1RTdCTG9ybnYzRktmQkhlUXhqdk8wdWxvZkRZ?=
 =?utf-8?B?Z09PMDFMVkMvbXFqSGs1blVFc2pwY0hVcDJodWRBanlia2FJQUZXbUhaSzdO?=
 =?utf-8?B?dEVvT1BjeWxlNE56V0lydE16SURiODhncEdxYkJYbWp4ZjNueDB0SWp1S0ll?=
 =?utf-8?B?cUFzM2RrRUNuOE9jb3RSN1VrNFVzMVJaVFZqaThrU1V3THIzREkzYVIzV0lq?=
 =?utf-8?B?VzRJcGFYOHNsVGFacHJnOE5ucFJPaThWU2dWWG8vOVF5cUtwVndVMlFlbldx?=
 =?utf-8?B?aXY0WXdLSnpOVEN2aTlHcjM2ekFRSEM1MnRRcE9wRk4zOWs4TTJWVE9nTGpu?=
 =?utf-8?B?bzN1S2FvT1VhM01FcXUyTGgxbkZPMkpYVWFFVkZHclVPc1BacnYzdnQzTDFU?=
 =?utf-8?B?bjhXWUlyc3BEYzB5dmcwQUFtdVlKTG1pNWEyODVBck1vS3orRUtENVZuYVNZ?=
 =?utf-8?B?dU13NUpaL1A0WlJNbVZnbzhVMUpVNWpjOXpiWG1MeUtXQjJaaEo3VUNlKzN1?=
 =?utf-8?B?WnJKZkJrMlNwc05ZZ25jWWNZZnhFeFNWM2NzakVkcnVFTWw0NzBPRjJWUGVs?=
 =?utf-8?B?bzhlYmR3aTJqZWZpeS9oNzdMNHlwZ01OMSs3K25TQzNKdktobkNKVDFTTDZj?=
 =?utf-8?B?ZVVQc3BUVHdEaERNakRQeVhmNU5FbmN5TndRMTJqd0VFbUNVQ0tsZ3RNUDlK?=
 =?utf-8?B?ZlJlWWQwUFhmVllkVjFvK3J6UWtPMTJTQmg5dHJWODNTbG1xWXNiNjV2dXl3?=
 =?utf-8?B?bE9JMlB0ekxnUjZtZXNjMUZ6MG15dTBWVVFwNFgxSW9xVHdCd08vQnc0Qmph?=
 =?utf-8?B?YnVjVUkyelJISS85V0F3eDlTc1hmMXlpVHh0RXFqSFk4WXFqOE4yNVZ6SUpi?=
 =?utf-8?B?dUpOVXJEUHBYaDVBOUVNWU9wOGI5dTVtMzJTYlE2amFTYnNZSGJLbVRLMVRh?=
 =?utf-8?Q?KfSaFB+OwnpnZKaaHBPSOxL8S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4645b251-8f1a-4000-31b3-08dd4d231f0f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7093.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:12:19.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJaZTbyOY7xYRsO6rBITSxEuvWRA/9et1CZHRfq8Ba4XvPJF8BaH4kNYsQDSLnw3u1nElICAp76MhRpu5WYE1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013

On 2/11/25 8:12 PM, Sean Christopherson wrote:
> On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
>> Extend the SEV library to include support for SNP ioctl() wrappers,
>> which aid in launching and interacting with a SEV-SNP guest.
>>
>> Tested-by: Srikanth Aithal <sraithal@amd.com>
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>

[..snip..]

>> +/*
>> + * A SEV-SNP VM requires the policy reserved bit to always be set.
>> + * The SMT policy bit is also required to be set based on SMT being
>> + * available and active on the system.
>> + */
>> +static inline u64 snp_default_policy(void)
>> +{
>> +	bool smt_active = false;
>> +	FILE *f;
>> +
>> +	f = fopen("/sys/devices/system/cpu/smt/active", "r");
> 
> Please add a helper to query if SMT is enabled.  I doubt there will ever be many
> users of this, but it doesn't seem like something that should buried in SNP code.
> 
> Ha!  smt_possible() in tools/testing/selftests/kvm/x86/hyperv_cpuid.c is already
> guilty of burying a related helper, and it looks like it's a more robust version.
> 

You're right, a more general helper is in order here.

Since the hyperv_cpuid selftest only seems to care about whether SMT is
possible (i.e., it may or may not be enabled) and we care about it being
enabled as well, for the flag to be set. I should make a more generic
variant(s) that can be accessible to both. Maybe I can implement it
within testing/selftests/kvm/include/x86_processor.h?

>> +	if (f) {
>> +		smt_active = fgetc(f) - '0';
>> +		fclose(f);
>> +	}
>> +
>> +	return SNP_POLICY_RSVD_MBO | (smt_active ? SNP_POLICY_SMT : 0);
>> +}
>> +
>>  /*
>>   * The KVM_MEMORY_ENCRYPT_OP uAPI is utter garbage and takes an "unsigned long"
>>   * instead of a proper struct.  The size of the parameter is embedded in the
>> @@ -76,6 +109,7 @@ kvm_static_assert(SEV_RET_SUCCESS == 0);
>>  
>>  void sev_vm_init(struct kvm_vm *vm);
>>  void sev_es_vm_init(struct kvm_vm *vm);
>> +void snp_vm_init(struct kvm_vm *vm);
>>  
>>  static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
>>  						 struct userspace_mem_region *region)
>> @@ -99,4 +133,17 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>>  	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
>>  }
>>  
>> +static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>> +					  uint64_t hva, uint64_t size, uint8_t type)
>> +{
>> +	struct kvm_sev_snp_launch_update update_data = {
>> +		.uaddr = hva,
>> +		.gfn_start = gpa >> PAGE_SHIFT,
>> +		.len = size,
>> +		.type = type,
>> +	};
>> +
>> +	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
>> +}
>> +
>>  #endif /* SELFTEST_KVM_SEV_H */
>> diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
>> index 280ec42e281b..17d493e9907a 100644
>> --- a/tools/testing/selftests/kvm/lib/x86/sev.c
>> +++ b/tools/testing/selftests/kvm/lib/x86/sev.c
>> @@ -31,7 +31,8 @@ bool is_sev_vm(struct kvm_vm *vm)
>>   * and find the first range, but that's correct because the condition
>>   * expression would cause us to quit the loop.
>>   */
>> -static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
>> +static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region,
>> +			   uint8_t page_type)
>>  {
>>  	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
>>  	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
>> @@ -41,13 +42,35 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
>>  	if (!sparsebit_any_set(protected_phy_pages))
>>  		return;
>>  
>> -	sev_register_encrypted_memory(vm, region);
>> +	if (!is_sev_snp_vm(vm))
>> +		sev_register_encrypted_memory(vm, region);
>>  
>>  	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
>>  		const uint64_t size = (j - i + 1) * vm->page_size;
>>  		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
>>  
>> -		sev_launch_update_data(vm, gpa_base + offset, size);
>> +		if (is_sev_snp_vm(vm)) {
> 
> Curly braces are unnecessary.

Ack. Will be remove them.

> 
>> +			snp_launch_update_data(vm, gpa_base + offset,
>> +					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
>> +					       size, page_type);
>> +		} else {
>> +			sev_launch_update_data(vm, gpa_base + offset, size);
>> +		}
>> +	}
>> +}
>> +
>> +static void privatize_region(struct kvm_vm *vm, struct userspace_mem_region *region)
> 
> Can't this just be a param to encrypt_region() that also says "make it private"?
> 

Sure, I can parameterize encrypt_region() to have a private boolean.
The idea was essentially to ensure that privatizing and encryption can
be called separately if they wanted to. However, since this is
currently only used in tandem (by SNP) I can remove this to reduce
duplication.

>> +{
>> +	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
>> +	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
>> +	const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
>> +	sparsebit_idx_t i, j;
>> +
>> +	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
>> +		const uint64_t size = (j - i + 1) * vm->page_size;
>> +		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
>> +
>> +		vm_mem_set_private(vm, gpa_base + offset, size);
>>  	}
>>  }
>>  
>> @@ -77,6 +100,14 @@ void sev_es_vm_init(struct kvm_vm *vm)
>>  	}
>>  }
>>  
>> +void snp_vm_init(struct kvm_vm *vm)
>> +{
>> +	struct kvm_sev_init init = { 0 };
>> +
>> +	assert(vm->type == KVM_X86_SNP_VM);
> 
> Use TEST_ASSERT(), or do nothing, don't use assert().
> 

Alright, I can do that.
I will also send another cleanups patch to remove asserts() in the
SEV, SEV-ES counterparts too in that case!

>> +	vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
>> +}
>> +
>>  void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
>>  {
>>  	struct kvm_sev_launch_start launch_start = {
>> @@ -93,7 +124,7 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
>>  	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
>>  
>>  	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
>> -		encrypt_region(vm, region);
>> +		encrypt_region(vm, region, 0);
> 
> Please add an enum/macro instead of open coding a literal '0'.  I gotta assume
> there's an appropriate name for page type '0'.
> 

For SNP, we supply this parameter to determine the page type for SNP
launch update defined as KVM_SEV_SNP_PAGE_TYPE_*. For SEV/SEV-ES,
however, the page type doesn't really get factored in and falls through
unaccounted in that case, so I had passed a zero to it.

Having said that, having a literal here is quite unclean. Maybe I can
pass one of the existing page types to it or, better yet, define a new
KVM_SEV_PAGE_TYPE_[RESERVED|UNUSED] type instead for our selftest
header?

>>  
>>  	if (policy & SEV_POLICY_ES)
>>  		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);


