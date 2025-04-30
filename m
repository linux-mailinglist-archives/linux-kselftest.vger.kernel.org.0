Return-Path: <linux-kselftest+bounces-32028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ACBAA4A0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 13:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245077A545D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D525A328;
	Wed, 30 Apr 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3P1Iwo+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9A23C4F0;
	Wed, 30 Apr 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012647; cv=fail; b=Q1Q1Y2rY/wxqzpe+CltPl4pi3jNQWmaDJ5snU2BrHtWxSusStAw6gfnVZZtWuVdeDKHUDwS6LqRIH3aHF/lUUNrsmfOSRQUfvd9n6b+fyjmERDsjpLkr+aJSNop8Nb6Ax1yaTWTFnll8rHZ0OGcdvNDEAmfH3DzbDZIfmIMpsi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012647; c=relaxed/simple;
	bh=RkXtagEmKAcJ9iPoylHo/QhFcDEcDM91cez9Qq3tIyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=An/zcQcQUzoarzLMHxZuLWIsyp4YU4rlAzdH1jd5KMfgWkj8tUo+SG15nnJPMNvlDqWPExAolaAfaq8/HcWLHmERJNWaNPPtyog7g9HDgDYRaYfQPaM5DNiCxuSjsj9wDvXBOgdF8/YUUdZbQj4XTLaY+Ljad+w1h4IPH22mUD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3P1Iwo+y; arc=fail smtp.client-ip=40.107.212.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTyL+xl+gL4X9fzlp+m4rXvSq0XI9xvB1H05HjDU1me9ZZDea86xxYBAKCvCpQu1EKwrUx9Ul1/rKJI6Kct1P00L29xe/c7VoFGkmH6tNu0vXLFwcn+DAt6P8UFe0FELPgL99/fIgatLqQ+Bf/A8NAUR2KA96imqEFM+21vjbs1lV2Avom0ZU1Ej9KB0T/tfEeCa1TGXHrZu4/MOwpiqOSLSObfzaFUsJesc9DofXdzatNnidpjlY1ZkU1eJ+kyDZplb/u9PqId+CKnoS72wwmqrukmLFXnWwyn/+nRs4YN0ZwmtjUy1iPbvcx5gYOvyivYR1Uv8oMzLz+iCyN2CjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTdvM3VDcuYr0opdotiC5viEffCyHXo/lUnn0R2CAFE=;
 b=fkixYVAsxVzHMPMXAmIcjPZAr1R87TCsQKh8in7X7FfFYIfBnLAKpYPVmEyrubmnEhuV62Du5xpvQE6o/2I83oF3NLtrUAJ1taNazkl9OPlKmqXdwOTIr8qRh0gOaqgDzZZcJC1W7TC2LtkOf9Uu9VlxmlsYG8GILZsPg0j8c5GBWN6nF83YKGFDi14h+nhnrI+sEseWiMrGRe0YWu3FNMroioahqqhD2wNrePMy9gW3219aQGC1V21I4oov36UNn1msHYX3Mv57pa3kdsC4NTtpF+e0Sgd+GEppOzcM3WJoJ/WhDn6eSy4NotgtaujzrNDDy8m6bgPEX/DNWGed4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTdvM3VDcuYr0opdotiC5viEffCyHXo/lUnn0R2CAFE=;
 b=3P1Iwo+yITwgC1uzIHVo9KEdfuLUevh3w9tS2+BmH6Y/R1miDxKsv34XEu7WfDcU38gfxRBwiuC7EwfExvJOyG3Dhg0heexoTIMqAcjufvhKLR8nLpPIW5p2ypHr6M2/QH43idjOrlgZspBVgCXTzYKHQfIfcOTtVdUbavc2g+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Wed, 30 Apr 2025 11:30:40 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 11:30:40 +0000
Message-ID: <470cefce-dce2-475c-82ee-71489f32434a@amd.com>
Date: Wed, 30 Apr 2025 17:00:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] KVM: SVM: Add support for
 KVM_CAP_X86_BUS_LOCK_EXIT on SVM CPUs
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, nikunj@amd.com, thomas.lendacky@amd.com, bp@alien8.de
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-5-manali.shukla@amd.com> <aAkKzEpNXDgC9_Vh@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <aAkKzEpNXDgC9_Vh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::6) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0206e713-e511-41ce-a019-08dd87da6fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0NSTThOcTJreHZGRks2M2VKOXJsTGJjSGQ5UlIwOTdrSmxnNFNHeW5ORHRu?=
 =?utf-8?B?TEdjMDd0SDRKS09TSHI3QitIT3M2ZVVXU1RFNDA1elhJb29ZSWFQUFpwcjNC?=
 =?utf-8?B?UFl2WTRYeFBvSDh3R24xbkpHQ3ZrbkZpQlpaLytOK1ZYYTBhTWI0V1p5Vm1Q?=
 =?utf-8?B?ci9qU1AvYzBseEU5clV6NHYxVXo1dlE2VFJKUG1jMmFWS2tsVHRmWTV0OGx0?=
 =?utf-8?B?WkI2UDBLRmo2ME1aamhVeUZ6TStmT2tvN1hDa3lKQXdBMDYwZjYzelpTc3pq?=
 =?utf-8?B?VWVpTldPb3daMVlYWFlpVjZWUWlQK1dMdiswVjZVbkk1MDZZcFJmbTE5L1ZZ?=
 =?utf-8?B?cWV0REUyNDNQamUvRUpyN3Z5ZmdsSkMzTnFqcVU3K1hVM3JYenQyQUNMaDlt?=
 =?utf-8?B?N0pYN3pNN2RqS1UzOXh2cVJxN2xTWFljT1BYL2hQR0p3M0JVMGlrTCs2a1F4?=
 =?utf-8?B?b0svbHpwV0Q1TzVmMHhUSWEwR0JYTHNNNldYczhVY1VMelQveHZ1d3ZGU0V2?=
 =?utf-8?B?NStKVVdaUFFwdFJKd05hMUMrNTBMcFVxWjByaDNpdU5rbGFDenlDTG5ISE13?=
 =?utf-8?B?U0J5U1orT2FSYjFJL29nZm54Y1d1Um1hT1VuL0RXS1lDcXVLVDBLUlkwMmk5?=
 =?utf-8?B?ak1sYlRYN25CSFppNTI5aXpRc1hzM1Uxc2x4QjJTTmFEY0xtSVBPUXdNVWtO?=
 =?utf-8?B?M1Btd3RzT25HbE1pVVhjcFR2bFc2MjZPeE5VTmtRUSs5SE1pVnJ4aUNmTWU2?=
 =?utf-8?B?NVZBcE5xWS9kcDNJRldyUkFOdGNtT3pOZ1AvQittOE1HK3dxdkdqcUVWWjlz?=
 =?utf-8?B?OVI3c2hBcldLTGl0L0NjRzExTTYxSFN2U2JFTjZKakZWS29qMWVFcGJhczJs?=
 =?utf-8?B?Y1VEMXRvT3VlaUtnbVM1RWxBNzN5KzJFL0NIWi9jblpaaWx3UFcyc20xckI1?=
 =?utf-8?B?Nys2Uzd4RHdiUE1nODYrb1gxeFhFNmVqZm41ZUQvOXIzdDdza3V4TTRsWkZw?=
 =?utf-8?B?M2RWaUg1TExkaEVTMHJEL0VQU3VKK2srUndoRWJFckZCdE9jNzVHQkkvSTcy?=
 =?utf-8?B?ZmlLckJ1L3F0dGpGNlkwQW5OcXJCMUcwbkUxMVBWNy9kNFQ3dml1c0loU1cz?=
 =?utf-8?B?QjByWFBDMVVqL1F4Q3RDS016OVhNWjA4c0R5NzB0YW5lT2hOY0p4TWVKM3k1?=
 =?utf-8?B?RGlZUWRqelVJVXd2dkdrOGRFd3M4Vm51WWRpQVFmOFZiMjkwelpscXFmc0NQ?=
 =?utf-8?B?andOa0dpYzNFaXpibCt2Nlc3aFU5M3JDMm8zTmF6UVVnTitTZ2pDM2tuNVVu?=
 =?utf-8?B?ZTNVNTdPcHh0bCsyUmI0YWZheFZnWGRzenFhS3Zma1R5V1JDaDFRS3dDZHBz?=
 =?utf-8?B?Mll3bXVvbGhHeGd2RXErcnA4NW5DcThzS0lWUWtDZENyU004QXZFeCtiQWly?=
 =?utf-8?B?YWdjTVpKUDRFMHFKWnB3M2lqOVF4UlNOalV0YjhhaGphQjhkQjBEc1dQb1dz?=
 =?utf-8?B?WndYUi9xeHVBQzA3aE51dUdWKzJnMWYvYkI5elRzRmRPUElNeitRR1pqKzN0?=
 =?utf-8?B?NmxxdVpZK3M1YzV2QWN3NjBya3NSdTZXS1dtbE5jU3pkcHpBT2FzWnFQUHNY?=
 =?utf-8?B?TTZPaE42dm1pZHdKZnJzZVlhZnJ0dWJUZm5QVjZEbzRuZDlDYVpKall3OUo2?=
 =?utf-8?B?OTlUUitrVGpCQVQzYWt3aWxNSXFkZmVnYm9yMnROdjBZOVArQ05YRzVsMm53?=
 =?utf-8?B?TDR1dlpPZVQ3Q0RybmJobitNbi9EUmJoMHdkdVhxVFVGeWdrWmE4UTh1V2lR?=
 =?utf-8?B?Y0I2emVBU0RFZXVtSVlxUVQwc0hhbE5MdUZ5UEFVekRzOG9XMlRtcG1OdUdG?=
 =?utf-8?B?ekl2T2s1L2hoSWV5dmJnWm1yRDZEKytiNDJ0TjVGYlQzcWlXcTNCRTdQc3ph?=
 =?utf-8?Q?WCbnsxhotxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU1ZWkoxeC9Tdm1kTlRMUEtGV1dodW1oQWJnd0RTWEEvSHhLQnZVbjR5WkNR?=
 =?utf-8?B?MnBZaVpHTUY4dExMKzFkOUVIN0l3dE0yZUVZekZNTUxNOU9lTlVQUVkxaWxV?=
 =?utf-8?B?dnNSYWtONmdDeUtQVDlyckRHbW5DbThaemFWdXdWc1VEdHU1WVBiK0l4Q1Ax?=
 =?utf-8?B?OFpwR243VEdEdC84eWlxNXlaWERnaTBFY01nRk4zdHZERkVMR0E3ajJRYkVo?=
 =?utf-8?B?OS9BUDZuc2tKZ3F6T016ckVMbFFDcjdZNGJhdW5ZZnFhaGlJU3NhUkVvbVh3?=
 =?utf-8?B?WGo5OUFiTEJiazlXTTlwUFRWVjBoSEQwTlVJb1B6WEFaOERGakJrR2FRMlhO?=
 =?utf-8?B?c0hRdXdGdzFXUlhvNmhqVnV1VGJUcktRckxjRkFvY2hoditXRzhGWS9tY3VL?=
 =?utf-8?B?aWpTNkFuTHR2eWZsL0lwdVdJVlRqVVVkWit1TE9DVTVUSTZXK0c5eWI5VW1D?=
 =?utf-8?B?Y3MrRUp0YlFJSk5zT1lGc09kbFB3SzNFc05nRnVOb3FickQ0UmhsYVhVaHZQ?=
 =?utf-8?B?YVJQKzZ1YkQvd0RrY1NpK001b2tLNjZNcEZabUZTcThOZDZoYVhvdS9SK1ZN?=
 =?utf-8?B?U1JubTBYc3Z1S2RIZGpDZ0N2VmJnYXg5VE9NNlVvNEJ4aDYwYkFoSE93T2Fj?=
 =?utf-8?B?WVpIU2FiellRYnczbHpIR3A3WS9rbjhBVjFCRFpiWkhTV1IrK2lqT0NtbEZX?=
 =?utf-8?B?ZWZVcGdDRGJDTGVzVDNON1BjV0kzNUlUVzRHV0ExcHQ5ZXNQUmk5ZkJmaUtF?=
 =?utf-8?B?aDRKNFJOQks5ZWh3bDZZd0xrZ0dtS0pNcStMTXVXWTlJZzNpYk5ERUVlcVFX?=
 =?utf-8?B?S25uMkdPeXFIMHJXNXhYYW94WWtBcjJkcVh2UFRQV3UyRTNVTkJmWTh4Qm5N?=
 =?utf-8?B?R0QvTENoTHlEZHNYUnpFNEx3bm9LeURrNWJwU3RSUkZFeG4vNWtmcThJRVBR?=
 =?utf-8?B?UTVWdkI0WiticFFFeHg5TEtJaFJJTDFkaktXVWhHVGRFeHhRNU90UkRUTlVt?=
 =?utf-8?B?RkdHblNpTm5hSTlYOVF6NUIyUUIwTktzRWtob1dPWjJDSWlBRkJkRzJMcmYz?=
 =?utf-8?B?ZW5mOGhhQ2hIUVJDMjlOVXJDSUNER3BXUVhKWUlpWmRJWlJ3ejV5cHZqVFgr?=
 =?utf-8?B?RVg3ZkVCRGJyNUpRcytRY2IxcFNKVmZSa0MrUXlzMmJYRDdsbWJxZUc3dFNM?=
 =?utf-8?B?SkNoYk43L3R2S2dZd1dSYnBCZ0pyd3MwVUg4Mm1HRDZEbzczM05sVkRabU50?=
 =?utf-8?B?Ry81OGpNb1NUelp0SXNoZ1FoS0gwQ1ovOXU4WjBPakZjeTR3aGp1bjNmT1Zj?=
 =?utf-8?B?YU5vSEYrWTZDY0RvLzJvSUdoclNSenZuNFc2K0NUZmdJbWxUcjVBRDZFUy80?=
 =?utf-8?B?MkxIeVoxV3B0NzhFdExuR21tQW9lSnpUUzdpbVhYaDBGSXp1cVFzODloRFpO?=
 =?utf-8?B?bm10TmZVaTE4Y0Rpck5GL0ZCblNMY0tTVzRreGtXcTN3K1kzL0QvMXd4Wkpx?=
 =?utf-8?B?cm1lNkoyZmZ5RkE1RHZxMkxiVVcxcTMrb3QxTndRSUE2OTNKUGM5K0diQytZ?=
 =?utf-8?B?TEo1aVJFZ3FDWkcxckJ5SDZES3U5dDQ0OGR0TEpGNlV2bTliNnIyNzYrM2lw?=
 =?utf-8?B?Z09qMjNJSlkyU1BxWmpxNTA2RjlLWkcxd1Z5QnR0VDhCZllDcElBSmdDbEtF?=
 =?utf-8?B?N1JwWFdZdWlFbmIzM1diMWQyWTVGS2tHSHJqWndMb1NhV0JGRnZVb1gzSWQx?=
 =?utf-8?B?YUZEU25ScW1SbTJobnUvYlhqZURKakQ0LytZRHF3OUNMb0s0YzhoQ2VEVVd1?=
 =?utf-8?B?TFRRTFMzNW01U1creEpQZGNGb083Y0pNNm9uWjV2blRHRXA4alFlZW1VdjdB?=
 =?utf-8?B?R3hXOGtSL09sNXFrR045Uk53QzBOQUtwcXhYazJ4TGtGVlY1SEVTZGxmNzVt?=
 =?utf-8?B?bHFmOHNOWms0UHE5dStxMS82Y3VxVnFteFlqUCtySW9meXo4TWV6a29qTUh5?=
 =?utf-8?B?U0M5TUU2YzNrWTY2dmNURjZaeWxCZzBvaitVc2tTaDh0d0k0NHVlQldrd3E3?=
 =?utf-8?B?c1Rpb2ZZZUFnQ3B2Z3VQaS9tSnltZ1hrSFMwNEdQY1hWQ0hhMEZ0U3E0M2NP?=
 =?utf-8?Q?1CZH5n5eo1X3u8AakwrV/2jkL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0206e713-e511-41ce-a019-08dd87da6fb0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:30:40.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irGnwJIPUQefRMA//77waZwMQE9znywqrMkkKGbUrF4HDzSFLY8PrFROt412DkLAYV5QWViX+kTP0L/XBplr/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237

Hi Sean,

Thank you for reviewing my patches.

On 4/23/2025 9:14 PM, Sean Christopherson wrote:
> On Mon, Mar 24, 2025, Manali Shukla wrote:
>> +	if (vmcb02->save.rip && (svm->nested.ctl.bus_lock_rip == vmcb02->save.rip)) {
>> +		vmcb02->control.bus_lock_counter = 1;
>> +		svm->bus_lock_rip = svm->nested.ctl.bus_lock_rip;
>> +	} else {
>> +		vmcb02->control.bus_lock_counter = 0;
>> +	}
>> +	svm->nested.ctl.bus_lock_rip = INVALID_GPA;
>> +
>>  	/* Done at vmrun: asid.  */
>>  
>>  	/* Also overwritten later if necessary.  */
>> @@ -1039,6 +1069,18 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>>  
>>  	}
>>  
>> +	/*
>> +	 * If bus_lock_counter is nonzero and the guest has not moved past the
>> +	 * guilty instruction, save bus_lock_rip in svm_nested_state. This will
>> +	 * help determine at nested VMRUN whether to stash vmcb02's counter or
>> +	 * reset it to '0'.
>> +	 */
>> +	if (vmcb02->control.bus_lock_counter &&
>> +	    svm->bus_lock_rip == vmcb02->save.rip)
>> +		svm->nested.ctl.bus_lock_rip = svm->bus_lock_rip;
>> +	else
>> +		svm->nested.ctl.bus_lock_rip = INVALID_GPA;
>> +
>>  	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
>>  
>>  	svm_switch_vmcb(svm, &svm->vmcb01);
> 
> ...
> 
>> +static int bus_lock_exit(struct kvm_vcpu *vcpu)
>> +{
>> +	struct vcpu_svm *svm = to_svm(vcpu);
>> +
>> +	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>> +	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
>> +
>> +	vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
>> +	svm->bus_lock_rip = vcpu->arch.cui_linear_rip;
>> +	vcpu->arch.complete_userspace_io = complete_userspace_buslock;
>> +
>> +	return 0;
>> +}
> 
>> @@ -327,6 +328,7 @@ struct vcpu_svm {
>>  
>>  	/* Guest GIF value, used when vGIF is not enabled */
>>  	bool guest_gif;
>> +	u64 bus_lock_rip;
> 
> I don't think this field is necessary.  Rather than unconditionally invalidate
> on nested VMRUN and then conditionally restore on nested #VMEXIT, just leave
> svm->nested.ctl.bus_lock_rip set on VMRUN and conditionally invalidate on #VMEXIT.
> And then in bus_lock_exit(), update the field if the exit occurred while L2 is
> active.
> 
> Completely untested:
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index a42ef7dd9143..98e065a93516 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -700,13 +700,10 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>          * L1 re-enters L2, the same instruction will trigger a VM-Exit and the
>          * entire cycle start over.
>          */
> -       if (vmcb02->save.rip && (svm->nested.ctl.bus_lock_rip == vmcb02->save.rip)) {
> +       if (vmcb02->save.rip && (svm->nested.ctl.bus_lock_rip == vmcb02->save.rip))
>                 vmcb02->control.bus_lock_counter = 1;
> -               svm->bus_lock_rip = svm->nested.ctl.bus_lock_rip;
> -       } else {
> +       else
>                 vmcb02->control.bus_lock_counter = 0;
> -       }
> -       svm->nested.ctl.bus_lock_rip = INVALID_GPA;
>  
>         /* Done at vmrun: asid.  */
>  
> @@ -1070,15 +1067,10 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>         }
>  
>         /*
> -        * If bus_lock_counter is nonzero and the guest has not moved past the
> -        * guilty instruction, save bus_lock_rip in svm_nested_state. This will
> -        * help determine at nested VMRUN whether to stash vmcb02's counter or
> -        * reset it to '0'.
> +        * Invalidate bus_lock_rip unless kVM is still waiting for the guest
> +        * to make forward progress before re-enabling bus lock detection.
>          */
> -       if (vmcb02->control.bus_lock_counter &&
> -           svm->bus_lock_rip == vmcb02->save.rip)
> -               svm->nested.ctl.bus_lock_rip = svm->bus_lock_rip;
> -       else
> +       if (!vmcb02->control.bus_lock_counter)
>                 svm->nested.ctl.bus_lock_rip = INVALID_GPA;
>  
>         nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ea12e93ae983..11ce031323fd 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3333,9 +3333,10 @@ static int bus_lock_exit(struct kvm_vcpu *vcpu)
>         vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
>  
>         vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
> -       svm->bus_lock_rip = vcpu->arch.cui_linear_rip;
>         vcpu->arch.complete_userspace_io = complete_userspace_buslock;
>  
> +       if (is_guest_mode(vcpu))
> +               svm->nested.ctl.bus_lock_rip = vcpu->arch.cui_linear_rip;
>         return 0;
>  }
>  
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 7a4c5848c952..8667faccaedc 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -328,7 +328,6 @@ struct vcpu_svm {
>  
>         /* Guest GIF value, used when vGIF is not enabled */
>         bool guest_gif;
> -       u64 bus_lock_rip;
>  };
>  
>  struct svm_cpu_data {
> 

I have added these changes and tested them. Everything looks good to me. I will include them in V5
and send it soon.

-Manali

