Return-Path: <linux-kselftest+bounces-18736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF7098BE32
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BA7B235BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A6E1C231D;
	Tue,  1 Oct 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oPxuBY+G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1E19AD48;
	Tue,  1 Oct 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790199; cv=fail; b=NLePMRKyNhg0oHM5hDiH/F2F0t4qsystRn68nAYjhC1F9bHIeQXwKI20rWk+50FWD12MWWbzkvxI5NkB1QiBI3w/XrE6jPcuXZpr5/xhU7g91zaUcXZKB0rMTKzi0rurAmbXqdPPuk59rdU4T28meBfKk2HPgcQ/8tTensC/KAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790199; c=relaxed/simple;
	bh=4V/FoYa5g47voh4aZmLZc/naXpyugk/3pHms0pqtkCM=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=gfxee+6RS1WwDhvoEStvixosZ0L4u1gT3VmOuKnHrNDX3Mhy+jiA6sa7xG7DXCKDvku0W8W6kvIFEVwiq2VkZ7j+1z8eQlN5DexW83Wgn3lnqnkWH1rOHm79Vvy5m9ebXMYNqowVrq36sEdYejFfxLazlAPjj2uKnoa69bxW7OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oPxuBY+G; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l82KS9wfRZAd2t13VbEn1GV5/7Xvza+5zN7WbfFlOQmmWIqnb9zL+EsyoN1//UqsbJoSFGLste3rIITOF7HGK5ykI244nJMY2WBlZcZCNgayC5r1Qz97/4e/I9fmtXAXA3Etnm877nqSplrJlu+KTeB44qGH176hkPP/+zeDIjfx3onC9fq0/pwSqQAC6LFPf0kV1avQb2PGABlFaz6r6F04YCSYOrPn2PDoZtcJyIedj8IOgtGXz0n//KgPlcspk4/+3/tRiTHn2VTyKE3f6zOtZIaLmkO5RMenloYeLQvweWkPDh5NZuepE+H88KBVUlBEM79vNPhGm3vx70gBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fdq6sjsWy3LzBZonxtF0Vnj3PQzqsA7YOofHn7wl/RE=;
 b=pPY3S+a2rN0/A4B9ZYD+DpE+9Dm7ide8+4BSkwSL5vicGmZTfoK3LtLRRU+GTjgCbYXvh2zfQZUkz0ZR8YSXC3Jv0cnieoYc2i3lqfT3kWueHGrfSeD7ndzVEvvBXwPww3qdRZNgI3JAzIqb0XrHtXqr1ZCUast55O1kPUWU9so1T3Mgp0SOnwrv8ouMB71QEzyxiB22bV6lzWsO0pSkX0LmAaEphLefuj9sM/3pXHsO/Os++lYUetobdnRb0c/DB0hdewVdzDNRxa0K7m6RyjokjP5BWA+03gfaHHd+rtxIn+0p9FJ3Fu88PSO/hk0TeSFe2E1+rxH3RGMOGzLriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fdq6sjsWy3LzBZonxtF0Vnj3PQzqsA7YOofHn7wl/RE=;
 b=oPxuBY+GGpnpVW9vFXaW1yX67px2IXsy/yvk8ERpLmZrpAZ5RKwe+9yxq/nQOdbuSUpptFwPHp0UQeQ7pSrOt01gGyOadO1/ABUJqQHfHCv8mq2/Bz9Vmwfzfq0edBW0IZdU0G2o+Zv+EDtyZJZ8viaQecbXKi8FZecMdK4vKfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 13:43:14 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 13:43:14 +0000
Message-ID: <728df37b-b162-8adf-8639-86233d0cf770@amd.com>
Date: Tue, 1 Oct 2024 08:43:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com
References: <20241001063413.687787-1-manali.shukla@amd.com>
 <20241001063413.687787-4-manali.shukla@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH v2 3/5] KVM: SVM: Enable Bus lock threshold exit
In-Reply-To: <20241001063413.687787-4-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::10) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2eb920-417a-4f47-a257-08dce21effaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NERaWlhrUi9ha3E1bHdaZC90VGF2OGNJQ3hGSWVZK1pnakY1VVpEV3hYajly?=
 =?utf-8?B?TzU3dHdXNkk0K3IyaUsxOUtZMVRyYlJXb0JDd3c2cnhnRTFDOGJ4NE5XZDFH?=
 =?utf-8?B?T1krOUpxcXJ6cXAxT3JMZWNnSktZdFZmbTdtLzZnayt2VmpjcXRIWE5LaVhk?=
 =?utf-8?B?SWhTT29RaGJLYTRvVUJxV1JKblVBcUZFTHF5VVFzZUJBdUdJTWlBc0RDWlhi?=
 =?utf-8?B?RG9OVTJhRkI4UmhTVUFpQWJUL1pDTktDTHJWU0FlNFp0ampHMmdvWDc2aTc5?=
 =?utf-8?B?MW1FLzlXclBKL1JFM2F2a0g4SHFLV3RNR3YwUVphdk9MOFRlcndYMkRmWFRs?=
 =?utf-8?B?eUJjVVpJR0lkcElPZ1JRSUIzTmxGYnVPcjV6RmM4RW9GYlh5RXhKV3JHRU1R?=
 =?utf-8?B?NWhKVXV1K0UxNFhhdmdLZ25ST09xMDZWaTRRaENKYU50bUpzWEl2ZTNCdCtv?=
 =?utf-8?B?REtvbFhDMk54SGswVkk1R0xRQWgrUkE3WWlwemtPdFpCbS81TG51MmZTeWVR?=
 =?utf-8?B?clNBQmplSTZWZzI0aHNSdjJkVFdRLzZ0dDJGd08yQWlPeGF1THlTWkY2bUIy?=
 =?utf-8?B?UStBMjc2TEI2ZlZNNHQ5ZlpQSDVlbi9tUTlDNVdZaXlxQlFqNFFralNRK21v?=
 =?utf-8?B?cXFtOXVRN1htb3VjLzlRb1M3akIwSXhCSnFpeThhdjdLNXBVbXY0ZDN5a0F4?=
 =?utf-8?B?VE9zUnRvY1BBc24vSEtnT2tUWUlTVGlUd1RMTzRuMzM3UmVmcVluSUljVVoy?=
 =?utf-8?B?WnJRNy9ZT3kyZGpSTjhMbGI2NEYxWkxSSStHUS9VdTU2ajRva0tneWNobTg1?=
 =?utf-8?B?Nkp3SUhrZmVGajcrQlg5U2RYcHEzWDlYV3dicXNCUmxPY0JyTlJPOU9oUGFm?=
 =?utf-8?B?YmdwWmNKZEJCV0dSOTVOb3ZjVEM5c3hMUVJ6V1hNLzBKZmViNjVnWU9XQjhH?=
 =?utf-8?B?Y3UyWnF4R25Sb3hJSTAzdnFZQllPN2hsaG44ZGFjVDZWK3U1aHpoSVNTd1kv?=
 =?utf-8?B?MXdQS3hlUklUSTVORWNmTTExUlVhOElxUUFBTU1FT3JHNmZ1ZHYvZjlrSnNE?=
 =?utf-8?B?Z2lNNmRFaUpQc3oyWnVxekxJSlZnYzhqSU5PZEdKbHA4V1QwZ1NBRXVSVlor?=
 =?utf-8?B?Nk95MTN4UVZlUUR5Q3NtSTZxbGdWWHdQdndNeFJ4NGdqbWlJOEY4NlFrcnhW?=
 =?utf-8?B?ZWVyczZaTFNaaUNYTVhnd08wTEVrSmNIdm5pUGczYm4yVklQYnRDcys3aTBE?=
 =?utf-8?B?ay9KcW80TWNQKzl5eHBtdUN4elZnLzNMa1dJaFdxcGVwQzJZZjM0VDY1STVt?=
 =?utf-8?B?UFB2YU04NHVBU0FKRDlQMkh5NGtkMm5ZNlBmRnV4YmtCZ3JiQ3lHWk5uNlgr?=
 =?utf-8?B?T3lSY1VaMGNGTXR3NTJiK05weVlQZXpKMW1iUFhsVktxcXUxRVFKS09uSnRj?=
 =?utf-8?B?WEdNUUZKR3VQVVl5SEdteHlOL2VOb05rRzdHRDNNZVIxbmwwcDB2Y3dBM3lF?=
 =?utf-8?B?TGJ2ZkNhZDQyNXEvWGtCK3dValRnaHVqcGRmNnJmSU8vRUk2N3ZKSTZPMnJ5?=
 =?utf-8?B?VDZFQTJONC9vZDlCM0FXWFdvelduYURGSmxBeEpHWXZKSkRxMW8veWVISFM2?=
 =?utf-8?B?V1VjdFBkTGk3VGkwN3NwKzlubS9EY2xTeDhab1RWdTN0UkpVeGNYSzkrcHBU?=
 =?utf-8?B?OWx0K1RaNTVkcTA2OVFUU0lEUXMzaGtzcTJKclQ2NlpiQit1SWRNNXRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG1hZmFFY2tybno3Z1NhOGJhL3g3cTNFdDE0S0JOa080UGlPMmdrcWIrUFUz?=
 =?utf-8?B?VWZFcm9SeWQ2eUZSM0hGMXVLRTZYRUFGWTYycDZPbWpCaEtEMS9CUnNUYjZB?=
 =?utf-8?B?cVZuTm5Sc0VZL1MwOHMzOU9vM29ocW1kWHZvUWdhS0dDY1ZRcFpWeTU2aUs4?=
 =?utf-8?B?ODJhMFlHeGFpajIvcVowaGdqQ1JHZ0Y4T3dhYzV1MWREcUVOTEkrd2drWCt5?=
 =?utf-8?B?TUJVUGNzc0VqekRNMFNrZ1RlVVBBUnJnWW9Nc041YUVKeWw5SnBvN2hJTXFT?=
 =?utf-8?B?V0Jyd0dGd2tFMzRXZU5pL05HY3pWazJKMEZRL083VGZkVzlSMVIxREJvUWRW?=
 =?utf-8?B?Q3pTNUxoZVZ2YTk0SnJjTDVRWTVKaERVb3R1dFVIYlB1TTNrT01wZjNTcGVz?=
 =?utf-8?B?TUJrbmd2SjVieXNGdDFKeWdlNnhLU3owSzJadzd5aDdUTSs4YzlPajkwcHE1?=
 =?utf-8?B?Q3pBUTNrRFlRZlZYMTBXdzRnd1NMMTlhQ2hvNk43a0ozYUpXWE5pakxFR3F3?=
 =?utf-8?B?aVpLZmthY1VkNjVST3Urbis4WWhYZFJZbmhDclY1enp6czZPRzRaZU5KU3BJ?=
 =?utf-8?B?UU5tODZHQmdaeWZsQUtwOWoyeTYrSGNxUWJ1Y1d2MmZnekE3UU5lU0VaRFl5?=
 =?utf-8?B?RTN3bFovOStMU29NTHBPc1lJc2RRRGtlQUNuZnJZSEM0dVJ0WlNyL0NueUM2?=
 =?utf-8?B?THluQ08yZTZHWXZVSHRvemlpeGpQbXJxQUNwRVE2WHhXWUVBYXFoSGg3cXFF?=
 =?utf-8?B?SjFaZkUreWQ2MThHL0JHMWhreHE0TVZlbEVPNEZUT2R6SlZoY000b0hHZURW?=
 =?utf-8?B?ODd5eFV3ajIzSWJQakN5d2VERFBWWmVjQkxXUDVYcTIzeEJsOGd0T2hTMGZV?=
 =?utf-8?B?NlZnWUxWWUVMY2swd1Zud2wvMXorVXJydGx5SzdZVkR1NGlNcEh5dGtQMDI3?=
 =?utf-8?B?dkM2ZHpwTjUzSXdkZnFuWTN1eDY3M2RiUklTcVhXMXZzUG9rZkpLemhtbTdj?=
 =?utf-8?B?eHZZdk4zVnp0V1NkOTJac0hWOWdTY0dBVTNvMnV0dThScllGYTVsNEN6dXlP?=
 =?utf-8?B?SlQxYXJaTlFsajNwL1lyQ3YrQUhCMjF1dDIrYUhYUDh2eitCVUxBUUV1Z2ZR?=
 =?utf-8?B?R1JJeGlIeWkxRUs3ZEpoS2RQS284MzBNa3pIN01uVUcrTTJ3WjlXbmJnL2tq?=
 =?utf-8?B?QUgxSkpOREI4OHkwUmFqaUFRekdoaE11VGwreTdqL29ybklJU1NqcGIrUGtK?=
 =?utf-8?B?NFFQY1VlVm81cjlVNDFCMlo2RWtyR3Y2b0tsazRxWGJMam5maHd2QzBXUUtv?=
 =?utf-8?B?eWhlUUNZL2d1QXgvRnNvRlZxcmNHazYrdjY5RXl2M3VvVkRnWnZ4eURUdzlh?=
 =?utf-8?B?VzZGRmI5UnJkZmNPY1J4T2ZjSElVcmZDT0luczY4ZHdnV2s0WE1mWUVvOUJK?=
 =?utf-8?B?cy90dXdZMXNzSWNhSjUzOGNrYXl6Z1ovendwY0tVU2k5VHBpeDRxREk5eFJD?=
 =?utf-8?B?MU5pQWNDdlhXcnJ5ZGVVRVg5ZDErQ3ZPZUIvNEJ6MUlMV3hqRHdNOFh2akFN?=
 =?utf-8?B?Z05SaWRldWNHQ3ZYeU5tRTBGU0VFem1FVkxnbnlDMmJBaFB5ZkpidUJGeUNj?=
 =?utf-8?B?Z2lmUnRuWi9UVE9telRGUW1lNndKLzg2azE2M2lmcXMvR250d3dVWHA3bDNO?=
 =?utf-8?B?ZTFndnhSbUVVVzBncDdUdmw4MisrSEdjWXBUejZPczlxaHpEdS9DZkZzNFVI?=
 =?utf-8?B?UlpJeTRZUERsRks3YytDSUVuamorOVlYcGNlRk9yejhwNWQ2dmpUUFFYUFBZ?=
 =?utf-8?B?MDhWVEh3Mk14UUIrNGlNU3JTY3ZYWEVxbVhjWmRvbnBhMnQ0dE1Pb3haQlFY?=
 =?utf-8?B?Ti9YTVZKTE1qcThmOHBuN3krNUxINC9wbzFIZFNhaVB2SnNISFJPdGJRcStn?=
 =?utf-8?B?VGFlU2g3ZzBZcG1IVXBKcUZ2R0pnYW5FMTMzYkoyOUQydVJrck8vQU5oME0z?=
 =?utf-8?B?SGhyWE5FRzVYSUxhSW8zbXhDOUJDejduTHBjNlMvVjhLN2ErdjYxakErLzdU?=
 =?utf-8?B?NXd0OU1NNFRhMWNHTGc0aVpMa2FRVkJEc0tYSjlXVjFKYlVhbmlndUNkS3Js?=
 =?utf-8?Q?DXfPSkvYteSzN2u0ZvkEvRhdl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2eb920-417a-4f47-a257-08dce21effaf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:43:14.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7QXETSbmczjHM0nUYDorlcgot5WjZ+g7/Kr+PQ1D00DQPj1/H2gE+g0ChY5uKq4+QAjEtmutxQqcnIU/qP9DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844

On 10/1/24 01:34, Manali Shukla wrote:
> From: Nikunj A Dadhania <nikunj@amd.com>
> 
> Virtual machines can exploit bus locks to degrade the performance of
> the system. Bus locks can be caused by Non-WB(Write back) and
> misaligned locked RMW (Read-modify-Write) instructions and require
> systemwide synchronization among all processors which can result into
> significant performance penalties.
> 
> To address this issue, the Bus Lock Threshold feature is introduced to
> provide ability to hypervisor to restrict guests' capability of
> initiating mulitple buslocks, thereby preventing system slowdowns.
> 
> Support for the buslock threshold is indicated via CPUID function
> 0x8000000A_EDX[29].
> 
> On the processors that support the Bus Lock Threshold feature, the
> VMCB provides a Bus Lock Threshold enable bit and an unsigned 16-bit
> Bus Lock threshold count.
> 
> VMCB intercept bit
> VMCB Offset	Bits	Function
> 14h	        5	Intercept bus lock operations
>                         (occurs after guest instruction finishes)
> 
> Bus lock threshold count
> VMCB Offset	Bits	Function
> 120h	        15:0	Bus lock counter
> 
> When a VMRUN instruction is executed, the bus lock threshold count is
> loaded into an internal count register. Before the processor executes
> a bus lock in the guest, it checks the value of this register:
> 
>  - If the value is greater than '0', the processor successfully
>    executes the bus lock and decrements the count.
> 
>  - If the value is '0', the bus lock is not executed, and a #VMEXIT to
>    the VMM is taken.
> 
> The bus lock threshold #VMEXIT is reported to the VMM with the VMEXIT
> code A5h, SVM_EXIT_BUS_LOCK.
> 
> When SVM_EXIT_BUS_LOCK occurs, the value of the current Bus Lock
> Threshold counter, which is '0', is loaded into the VMCB. This value
> must be reset to a default greater than '0' in bus_lock_exit handler
> in hypervisor, because the behavior of SVM_EXIT_BUS_LOCK is fault
> like, so the bus lock exit to userspace  happens with the RIP pointing
> to the offending instruction (which generates buslocks).
> 
> So, if the value of the Bus Lock Threshold counter remains '0', the
> guest continuously exits with SVM_EXIT_BUS_LOCK.
> 
> The generated SVM_EXIT_BUS_LOCK in kvm will exit to user space by
> setting the KVM_RUN_BUS_LOCK flag in vcpu->run->flags, indicating to
> the user space that a bus lock has been detected in the guest.
> 
> Use the already available KVM capability KVM_CAP_X86_BUS_LOCK_EXIT to
> enable the feature. This feature is disabled by default, it can be
> enabled explicitly from user space.
> 
> More details about the Bus Lock Threshold feature can be found in AMD
> APM [1].

You should mention in the commit message that this implementation is set
up to intercept every guest bus lock. The initial value of the threshold
is 0 in the VMCB, so the very first bus lock will exit, set the
threshold to 1 (so that the offending instruction can make forward
progress) but then the value is at 0 again so the next bus lock will exit.

> 
> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>      Vol 2, 15.14.5 Bus Lock Threshold.
>      https://bugzilla.kernel.org/attachment.cgi?id=306250
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/include/asm/svm.h      |  5 ++++-
>  arch/x86/include/uapi/asm/svm.h |  2 ++
>  arch/x86/kvm/svm/nested.c       | 12 ++++++++++++
>  arch/x86/kvm/svm/svm.c          | 29 +++++++++++++++++++++++++++++
>  4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index f0dea3750ca9..bad9723f40e1 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -116,6 +116,7 @@ enum {
>  	INTERCEPT_INVPCID,
>  	INTERCEPT_MCOMMIT,
>  	INTERCEPT_TLBSYNC,
> +	INTERCEPT_BUSLOCK,
>  };
>  
>  
> @@ -158,7 +159,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>  	u64 avic_physical_id;	/* Offset 0xf8 */
>  	u8 reserved_7[8];
>  	u64 vmsa_pa;		/* Used for an SEV-ES guest */
> -	u8 reserved_8[720];
> +	u8 reserved_8[16];
> +	u16 bus_lock_counter;	/* Offset 0x120 */
> +	u8 reserved_9[702];
>  	/*
>  	 * Offset 0x3e0, 32 bytes reserved
>  	 * for use by hypervisor/software.
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index 1814b413fd57..abf6aed88cee 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -95,6 +95,7 @@
>  #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
>  #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
>  #define SVM_EXIT_INVPCID       0x0a2
> +#define SVM_EXIT_BUS_LOCK			0x0a5
>  #define SVM_EXIT_NPF           0x400
>  #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
>  #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
> @@ -224,6 +225,7 @@
>  	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
>  	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
>  	{ SVM_EXIT_INVPCID,     "invpcid" }, \
> +	{ SVM_EXIT_BUS_LOCK,     "buslock" }, \
>  	{ SVM_EXIT_NPF,         "npf" }, \
>  	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
>  	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 6f704c1037e5..670092d31f77 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -669,6 +669,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>  	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
>  	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
>  
> +	/*
> +	 * The bus lock threshold count should keep running across nested
> +	 * transitions.
> +	 * Copied the buslock threshold count from vmcb01 to vmcb02.

No need to start this part of the comment on a separate line. Also,
s/Copied/Copy/ (ditto below).

> +	 */
> +	vmcb02->control.bus_lock_counter = vmcb01->control.bus_lock_counter;
>  	/* Done at vmrun: asid.  */
>  
>  	/* Also overwritten later if necessary.  */
> @@ -1035,6 +1041,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  
>  	}
>  
> +	/*
> +	 * The bus lock threshold count should keep running across nested
> +	 * transitions.
> +	 * Copied the buslock threshold count from vmcb02 to vmcb01.
> +	 */
> +	vmcb01->control.bus_lock_counter = vmcb02->control.bus_lock_counter;
>  	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
>  
>  	svm_switch_vmcb(svm, &svm->vmcb01);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 5ab2c92c7331..41c773a40f99 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1372,6 +1372,11 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>  		svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
>  	}
>  
> +	if (vcpu->kvm->arch.bus_lock_detection_enabled)
> +		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
> +	else
> +		svm_clr_intercept(svm, INTERCEPT_BUSLOCK);

Is the else path really needed?

Thanks,
Tom

> +
>  	if (sev_guest(vcpu->kvm))
>  		sev_init_vmcb(svm);
>  
> @@ -3283,6 +3288,24 @@ static int invpcid_interception(struct kvm_vcpu *vcpu)
>  	return kvm_handle_invpcid(vcpu, type, gva);
>  }
>  
> +static int bus_lock_exit(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
> +	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
> +
> +	/*
> +	 * Reload the counter with value greater than '0'.
> +	 * The bus lock exit on SVM happens with RIP pointing to the guilty
> +	 * instruction. So, reloading the value of bus_lock_counter to '0'
> +	 * results into generating continuous bus lock exits.
> +	 */
> +	svm->vmcb->control.bus_lock_counter = 1;
> +
> +	return 0;
> +}
> +
>  static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>  	[SVM_EXIT_READ_CR0]			= cr_interception,
>  	[SVM_EXIT_READ_CR3]			= cr_interception,
> @@ -3350,6 +3373,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>  	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
>  	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
>  	[SVM_EXIT_INVPCID]                      = invpcid_interception,
> +	[SVM_EXIT_BUS_LOCK]			= bus_lock_exit,
>  	[SVM_EXIT_NPF]				= npf_interception,
>  	[SVM_EXIT_RSM]                          = rsm_interception,
>  	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
> @@ -5212,6 +5236,11 @@ static __init void svm_set_cpu_caps(void)
>  		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>  	}
>  
> +	if (cpu_feature_enabled(X86_VIRT_FEATURE_BUS_LOCK_THRESHOLD)) {
> +		pr_info("Bus Lock Threashold supported\n");
> +		kvm_caps.has_bus_lock_exit = true;
> +	}
> +
>  	/* CPUID 0x80000008 */
>  	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))

