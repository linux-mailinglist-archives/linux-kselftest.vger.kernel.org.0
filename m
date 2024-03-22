Return-Path: <linux-kselftest+bounces-6501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BFF887042
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 17:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE7E1F2209B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393953811;
	Fri, 22 Mar 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CPJipUpZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EB4F897;
	Fri, 22 Mar 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123453; cv=fail; b=VfOi2DQ8WL4dCsqAGGWPOGI3XLilEqpIDF3jn1Txt+lf/CKHzKgb02HICiUdPGdNltTyHRvZgwTlCpJMGREQccWW/pyNlm4MWe6qelOaCM0dwMO6915FiTIgzB3vqWDUbnTkxheKZt194ehv01+C+EXe/fiXKqXqipVmjY+KiJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123453; c=relaxed/simple;
	bh=q2Yx/Jjorabe+gYutWK9cPTADHJfS6VgM8eV8kWd6dY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cnptURf9CpJWnQrOpB3gJKzQCfpEFcAMfFwixHFm7pAgJsih4vlb9HjrS1jWNo0WKL1602aSJLtdtRWUzyhHZ34XOo/d1ketjXKFTsTnzRA3KN8GcpimcOpbO6gGa63ihYadebQ5YdqYex1GbjX/melUOBx25SonRxOzvwNLS+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CPJipUpZ; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8+xIpQHLiDXw9Vzmb6yA0GS5fI3WPe5MNsm4bs5a8IE8Tq4sAa+2cUuEl+EDTZbPY4nuRLXos6nH5LA7FVuVhs7lQD4ggv53Wr4Bi0Y89NpIVTrZuA7Ute4aDch1965C1MTH0iUI5to7waDSjnsgBTZ4ArxN2P6X1GK+WO5X//8YLortHRcTM5ptk0dmMJFzLmVsCIg1xHCjU238TlGVIQWmBKT1Ylw7bGxsbratt6VcEBuEhsAzNfWn5ABHyzcagjnDKYv40DyxJ0lTHd14gZ66+ZaOwIyZpDDH3ghTnhuVKKTQQEr1M3uEr+0cv/aqb7S2BwFOth2i5m9popobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GifrBx9CLAMm3TCCkRF2M+SI/QMILP9A4Dic8xrsKkE=;
 b=OR5kzHplpdYQkN4c/MU+2JXyl/i+uaAFnljuQ72d+xeTXUQOJ+qBb8VSTRFlkhX1RI+S88ttBLZ+nRyF266qawUSjWj0joTy3oNkVhWzzy8bbv9wBM+cEHDUCTgQzN8Hj4MdgvRKnIqn7+tXLN4FsIgGRhN4igR75ztzcR8FdemPzqs+SiHtTtHarpVsxPTumsIfU0eTgmU3quUZk8SlsCx7XnRLHNRqNCbcg9kijgsu/xnCV+AH9MB+ePD+u/W9fwQbV+kQ/JkWg4glmQuV/lPHOgUASRd9DdKweoQT2LZ8nPnSIntFFZ9VLEnmvcgxF7JzwV5C7AoGQZ8O/0oHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GifrBx9CLAMm3TCCkRF2M+SI/QMILP9A4Dic8xrsKkE=;
 b=CPJipUpZt/GLZVsHSZe9z07JXH6PjECK8DVbS0S/Dc0TRBDEFhSX5KOVMqy2gdl5597TqrztVDqQSmCny/J7YGEeWMop3s/nGQKzP5Qh5R1BscQK9fkExTFgOooXO5u/1kR6bYVlHYFNZ5JBBeQRPMYU02mH9upeW1dW+J7eGZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.24; Fri, 22 Mar 2024 16:04:08 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::60b6:438a:bff1:cd14%6]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 16:04:08 +0000
Message-ID: <689d5ba0-70ba-8dc6-3549-57ff0db3a646@amd.com>
Date: Fri, 22 Mar 2024 21:33:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 5/5] selftests: KVM: SVM: Add Idle HLT intercept test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de
References: <20240307054623.13632-1-manali.shukla@amd.com>
 <20240307054623.13632-6-manali.shukla@amd.com> <ZeoF2vfrUMCja0x7@google.com>
 <075ff472-67c7-4cb1-a344-9c1066821eb4@amd.com> <ZfMSbS1oalRPZ-MF@google.com>
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZfMSbS1oalRPZ-MF@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: faca32cc-a729-4aab-c826-08dc4a89b4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	821cDIDS66q339Kr3mJAF4LINZBxJb/NWv2bs7lwgQSz6RSlF2Q29yEKrjlloI3FWNr2HHFGNlUsaMHgEi0YLBHqq4QRQO1beD/hkE0qxzccWaRGzLbdvXjmHjF+hUs3btqF0rVgaQnuDKL6lhxnyx3A6pU7grx4Ubc2BJ0CHymkWrx5t5ExvrwXCZRAPH9V449JVQkTfEOqBT2M7gGMRyU4enJ2rDqR6efW2zMk9NMLKdo57p/IiWUcE0BibthbD74gA1zg6dtmvV4Pj7Wb0ooMS0LIVFNMIM8DUQH5+Ubisl7HcESQxf9VzQs7fF35WE2o0mYK8C17eQ8Ukf86H9G5eZfspVHO47fqC0TMY8CJl0KnCVnoW4O+3i7yfLBB7VWF+9mp/Hml5ySuF19E5PqXkm+fJ/zTsbDp5M6EedL/P3duiiP8nC36OguQulzkhEf7jeb5Qem/B42Y5fGQsOVeCCuRg3haTymKEtUZRbjee8pSH+YMLI53/8V2BIVuC3CQKDwMCKGK/+ZVkfXvdN+jfS4JRNiMLpiHbroUL5prACZnA+0yfoviKuZHd9363nPyJZpCKSZFdshCF5viJGn/wXPUiZGHDMesU2XFlWafnLQiNR9Cw0aQjp9tx0KYUGNBvFuil/CqqDDC2WbMw+/02TGD2f0AYHo2/j03l+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REJkOEcvRVhkcmQxNW5xQXBDdHJ2Y0R4UTRmaHR1Q1UrTCs4TU1HTkpKS290?=
 =?utf-8?B?a0hERTVyd3VLbUtNMWROTk5JWjMxOEMrQUhTbnZFOEEzR2tlZHltWEhuUTJW?=
 =?utf-8?B?NzQ0YWdtTGsxQlpMV2FPdDFWWVp3cXB1R3VJbXUrQkc2WHN5T3FMZjAyOGF2?=
 =?utf-8?B?S3JkOGoybXBSOS95aEt3M1Q1d2R0U0hlZytqOU9PbkpPbDB5OWlFMFFqaGpy?=
 =?utf-8?B?a25Ga3NZZFYvZ3lYUURBcExzczhoK0FUT1dtMldHVGppejhRdUZPVjJZTnI0?=
 =?utf-8?B?ek1kdTdMMVZDV0JwTXFnY29pc2NQZmJzTEE0VTJGdFBnZEpvSWFTMFh4NjF0?=
 =?utf-8?B?NFAraDBEZ2ZHMGU2clVTRTduUDdMLzhsOFZaYmZaSE45ZUlTeDZ5OFZ3alc5?=
 =?utf-8?B?VDVUanNrN2FVajY1SVpubEp2ZnlJMXB0ME05dW5uZk9LVkJkd09SYmNaK0V1?=
 =?utf-8?B?STg1QkJHaHorVnRQSFRSUW9hRWFyYlJPc241aDBtRU1QQi9pVmpNY29CV0J3?=
 =?utf-8?B?djUxcmJhQWcwSmUzTFRPZnBNTVUrMVZUcG9lcmhyVGNFTFBjV2RpcEpRQmMv?=
 =?utf-8?B?L0xoT0czQ1hwT1pyTWVHd2F3SUxSdWk5UGw3K1psaXNONURDRnRzbGxvN2do?=
 =?utf-8?B?aytNMFNlUVRrNDNXRmQyVEV4aDl6RElHMWNKMlVpV3VhaHFPYUIwZlNGWnhp?=
 =?utf-8?B?c3orRGpIU3p5SzVERXhkcnU1aW13TjBISVJQQ29FYS9vTVRGT244RjdldWxG?=
 =?utf-8?B?QnQydnNhZldER3hBcmZManJoMDNzUDFYVS8razN3SzFPZmpZWnZQd0lldmty?=
 =?utf-8?B?MDQ2T2RBZ1BaMGF3VEJxTUZWaStwMEttOUhXRkxyeTBxU0FSNmRObUVjY2NX?=
 =?utf-8?B?NkN0NnlSL3g0Z3BxS1BZTXI0Ri9SaXoxQ2FVYzZGQVRhcit2Y1A0MVE1RFl2?=
 =?utf-8?B?SXBkWVlKNHNacmtBQ2ZqWDJteGtIdi90U2lFOGt0L3J5RDNBbFhPc2FBVjhL?=
 =?utf-8?B?WGk1QkF6S1ZISVFNeUdFbTA4T2puMHl3K3phWkFLSzgzN1hWOEFnZzd6R21C?=
 =?utf-8?B?ZVVJRHFLWllMQ2psaDF1NG1zK2hqd2VJTjRLajJmMVluTngyeVhOaGt1Tjc4?=
 =?utf-8?B?WHIzaElKcENPNjU1S1lvQVdzeVpMMXZmVjVxd2RFd2l6bFdYcFRibW5abDY4?=
 =?utf-8?B?ZGNhNlhWb1h0Q3lNMDhLRDhzQ2JlcDEzODA5bDNuYkhFb3pqSXdpbFh1Mzg4?=
 =?utf-8?B?U215NGczd1NZUTh4WDZGbFVleUpQQ0VKRXFPeTV1ajRrOUxaWkp2Z3RVd0g4?=
 =?utf-8?B?Wmk4ZTJhWHdrT2o4TGg1Z1FOcmFWVUZWalJQZmxjb1lrK2hTY1lGUlFOY0RE?=
 =?utf-8?B?UlJ6cXMvNHY4NG56RDI2KzhqRy9UTjJzamlzTHE2UURXTU95ODVPUGl0bTZ4?=
 =?utf-8?B?RThHTFhTL3NGSlFDQWQ4RDlrblNQdGxPb1U1eUlpZ1hGckxmSlVQb0h1dXND?=
 =?utf-8?B?ZmYvRFFCS1dua0V4ckdVUUZGWXgyamZYMGpUaC90QUc1V2RaRDNmS21vR0NV?=
 =?utf-8?B?bGgxeHhFZGJxUk1TZmdmRzVvczdxNU9FZVFjclhkSlhJK01kT1Q3OWNqSnRr?=
 =?utf-8?B?eDIxRlVUN0w2NzRValJCWmJJU29MaEpHMEVlUkJ2eVFQcGpkNFJ0TDVKQzF2?=
 =?utf-8?B?RGlBTkFRaGVyZlpTL0RZMTJVK3Z6WkpJK2RJUVRRR1A1eml4UDI5NHUvVEVm?=
 =?utf-8?B?dnlJT3B0L0puc0VSTzFraUM2U1pwZk1ZbGhaOHRJZTJ4VGpDQzFvWHlqb3ps?=
 =?utf-8?B?Z2c0MWd2aDE2bFdUU2NhMXNtcHBFakRuZUw4T21NR3Y0NEJzaVg5R1ROaGNF?=
 =?utf-8?B?UXl6SDBHWW41MVhsRGZ0Y3N1RGFlV2dvcGJwaFEyZ3gyTU1hZnhoUUZScGhl?=
 =?utf-8?B?VmF5R3p5Mlk4NW9jL2pDVmNubitCTFlhZXhwdTBtWUJETzluNUZBK0NmMnlT?=
 =?utf-8?B?dlFqRnVLYlJHMDkxQUxUbUhQU0lZNEZhNnlUemhockorZm5CTC91UG9ucG02?=
 =?utf-8?B?VnFIRmFlc2ZZSDVuWmpLN3ZsSW1BL0E5M3daR3BrVWF1V0RYelRNcGQzOEUr?=
 =?utf-8?Q?L7veD4Byzo0PCpKSRcd9Frjaa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faca32cc-a729-4aab-c826-08dc4a89b4a5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 16:04:08.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbEey1qEPI6RJxJa4F4ZWHMFYMgCg+B8ldJ2Pl8XDvkSJ++enh8WA+O8K0oVOLaeG5G0/dw9K2tdCGNj2mo3vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927

On 3/14/2024 8:36 PM, Sean Christopherson wrote:
> On Thu, Mar 14, 2024, Manali Shukla wrote:
>>>> +#define VINTR_VECTOR     0x30
>>>> +#define NUM_ITERATIONS 100000
>>>
>>> What's the runtime?  If it's less than a second, then whatever, but if it's at
>>> all longer than that, then I'd prefer to use a lower default and make this user-
>>> configurable.
>>
>> It takes ~34s to run this test. 
> 
> LOL, yeah, no.  That's 33+ seconds of wasted time.  From a *KVM* perspective, this
> is quite binary: either KVM intercepts HLT or it doesn't.  Any timing bugs would
> be purely CPU bugs.>> Please adjust this to have the default runtime <1 second.  If you feel strongly
> about the need for a long-running test, feel free to add a command line option
> to control the number of iterations.

Ack.


