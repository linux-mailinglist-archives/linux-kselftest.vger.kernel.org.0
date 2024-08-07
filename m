Return-Path: <linux-kselftest+bounces-14911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6F949EAF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 05:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DDE28B88C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 03:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C915D5DA;
	Wed,  7 Aug 2024 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0LBuMHpv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431D224DC;
	Wed,  7 Aug 2024 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002940; cv=fail; b=q12ceYJzMmDsBXIDyvKddwrtxIxikYgasb91tQQh7nc9Llf5jmwcjgEBrodLQnu+NIfuZDToNj3z9G60SSzryLzkz7m8ZtiKoOkVlde7AGbCySgZzf/JaFj1vipRvnNRvQ3TTDDgKBNCVO549j85PgEYMk/Inv6pGvgQwbzZPdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002940; c=relaxed/simple;
	bh=b3kzBYzUnAhYeS4HzIU3zKjvW8T6gL74yxB3Evf1b7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iGt6+/id8KIWw8TmmBROIYWyHdNm4E3YaEjEpqdMnCb6zgnoTEzEh4WekXsaxPHZmcjI5OlnBIVjCcJnrGOgnd+D07nlzI11zGW5EahX+NRyjgecLZER1CgLxrco2xl9g81M4+kyzCI+OHSgslU3IsUcIayTASqNUuLrmMuuU0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0LBuMHpv; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAHrLQ8nCI2cCQy53zFat7E/ce/MDg2ePvnIG43Qou0wIwJAfMU/oTCTN3KKbuEaUl3jOWxzbWkan/I/2dEX+K0tu18iTYZmzMWd3gdUc61eLa1ZkIk6o1TIiwysbms/JjDCppQM68eKXgPq6S4UVaXzh3h7Jldu4uJWK+a3nGijkfydk1UwB617EL+gI0ihRIj8vFJRIwvROSx4sHbAA388kHMx6qwRu0NCBVzZIv1vSFELLIGbJ10UgckAxogR9zZho9tukauhDtSMKtvwEvPSEq3f50xOy4MUePIDZO/b5Ts0NibCf+b4h/seIDzGS6lb170ONOSBt1NItit48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xge6eerVAuVZ24pCsOsAcUo2e6ZPIpeizeloMajJ6Tg=;
 b=yltIPHSg36JbfxjcOG6fmVhBDs8LlH0o/uzMyxKv7f6NB/30krRaPknQm7eLzwEi16YTmfG/B8USYA+D+eYiczTGg4QRV47CFCRkN5lyMggk/64m/4R5OtnBK6vu4w5ZNxjaWW2sA0LOUk5C6gABvPJgJFgCWAXB8/Y2g9wQokeWRhA5qv5H57eXgvF2uz7V1kNcnD4HDuQHImFtgKVqrKuPplDnuwdggfAA40c1BAZGhKtdLnfy0iCYP5HDCAdrgj8ZoaqVUlayW+1kg6UY4sR6QcXKv3qTCKruyKmeXV29CF/5loqFaF+IO9jDN9oL5hfr/PDW4VO48OCvMxZGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xge6eerVAuVZ24pCsOsAcUo2e6ZPIpeizeloMajJ6Tg=;
 b=0LBuMHpv0+vFBf5DtpQkeMmkgYcOFr1Wv5DqQmq1iSywi7XngqqSp9PReoozBMX+S0VKqhjxMh+UrUbAUXtwwpsIoAreLMsqoMDMg+BDP4Q4hz3Bu4WtYP3O5huz7BwMFQZ1qDGj/mCGG5+XK0/gP6UZtYvHcXI01VdG4dvWOyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Wed, 7 Aug 2024 03:55:32 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 03:55:25 +0000
Message-ID: <3ab43350-35f7-45c9-ad4a-8a3aa14efb11@amd.com>
Date: Wed, 7 Aug 2024 09:25:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Add support for the Bus Lock Threshold
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <782a2791-b9bd-4cba-a734-eb673f8bc24d@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <782a2791-b9bd-4cba-a734-eb673f8bc24d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::16) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5d14dc-cafe-45c2-18ed-08dcb694c4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0FiYVNVUy9kMkVEZnhZeFVIVFBEVUhvb01aWjJNaEp6VHIxVERlUGRQQjh6?=
 =?utf-8?B?NzVpb3MxRGhLVTZhV3ZNbWxuZVhJOE1TRUtVMzBub3lnZUwwd3MyMHdUZXJr?=
 =?utf-8?B?TWMvOXpOc3Rab1c1R0MrL0xWRURrblNGYVVuUzBiYjROaVJ3L2FIanJUUzZH?=
 =?utf-8?B?RFMxR0Z1TXdpeUtCRzVjNHZidzlzQXdYVVNueGIwSGxFOTFMQ2pOSDRaTzN6?=
 =?utf-8?B?ZnNKR1lPTlhYRC91UVN3NEhaMk5VeHIzZ3lhMUl1c2xnbzB1VkNXWlJlZnBD?=
 =?utf-8?B?QkJHd0NiVmFaUlIxQ1JWMXpUTFhGTjBsV0U1QWZwRlU2eFM3ZlJlU3VRNHVm?=
 =?utf-8?B?L0kwOWdnQ3FSclpmYzBkY1JnYk1pdE9sQmJxSWxxYnhvSmdhRjV4WFd3bXZ0?=
 =?utf-8?B?NVRjbGNSaTJhY1NxVHZxRVg4dmMzQjhxT25qY3FMbFFuaklSemhnQXRVZWlr?=
 =?utf-8?B?TWFqWGh5NXAxVDhHdE5vNG1uaEt3WjBzQWlpRENrS0RabnIyNjFlUUJqYXkr?=
 =?utf-8?B?dFJkVFRFWFZEQlMzdlZtWGFJQlpsUHBWV09sNzJ5dGVzdGZYL0JVQk1vR2FN?=
 =?utf-8?B?VHJOUWtrQU0wVDlYZ3dKZ09zMk1Ba0NDaWVtcWZqSUZYbVlQOE1QY1cyV2M5?=
 =?utf-8?B?eUZpQ2FUUUZrS1d2dFRORzRvQkE3bmNMWkE1dkNhcElRcnpoM2tYMW1MQ1F3?=
 =?utf-8?B?dit0U0tabW4vSzFtSkNtMEpOcjdxS05pTmF2ZmNna0xDbWhYaFovaU51SDdV?=
 =?utf-8?B?czdYWUJQUGU1RnlHZ3lRNUxNZXBwV3VCeS9lM1FqemVIZ2NWaCtlVVNwNjdt?=
 =?utf-8?B?cnBZQ0N4dmtPSElDZG9TTmhqVlBrRGN1MEJQWVJJQUpVR1hoU0EraUJ3Rk9I?=
 =?utf-8?B?SWs1R3JpVjNOVjBsM05lMEwyYm04Q0FMalRaZGI0eU9qV1ZNMndqalAxUGI2?=
 =?utf-8?B?MkEzYkw5WXMrdUlQbHVFd2RUOWM5aWdsVGNPck45ZzM5YzJSWC83aWhvQU5w?=
 =?utf-8?B?Mjc1YjZCN2FGUi9FY2daRm1EVmRIRlEvYkdMZVRqUTNtNlUwcnp1am9waGla?=
 =?utf-8?B?ZnFMMDhCMUt4U01aT1d1cURvTkY1dENhT1hVejdPY3FrMjF2aFUzQ0sxL0JP?=
 =?utf-8?B?My9tNUdwcTBjWWQ5K0R6NWRsZXpGWC9scS9BQkQzKzRkTWtCQkhjNXl3Y1lZ?=
 =?utf-8?B?TnhOOGxlTGhYWmwrNzFrSlhveHJjd05sKytqVnF6Y3dEMjdrZDExME9ycHFQ?=
 =?utf-8?B?YWRJSmFhNStOYVcxKzExSk8vajhEdlgrNmRna21ZZk4xZmFqQ0RDNDQ0bGRS?=
 =?utf-8?B?eHNaQ0ZZcFM5bWRxaXAwdUVqc1Q2Vk1tWWNGb3RzM1JvZ0xjYWtiM213SU1t?=
 =?utf-8?B?cHkraGs2b25FWmpNRWpGeWZsYnk2VHhmbkVnTklkZGpJMGhVcHZ4WG1CMGFl?=
 =?utf-8?B?dERscTg2b2w0aEVNU0pqTWszV0NIUGZ6Y0JnZ3J1NFkxVHB2VVdOZUo1M25Q?=
 =?utf-8?B?bGhmTm51b3ZvMDR1UkFDOWQrd3NJb2dwSEFZNC9ZdjBNeW1wQXUzMUd5QW1B?=
 =?utf-8?B?Y3ZuMUdxVHlRTDRhMHc5RmNxc2VuWU9CZXV4VjBGUzZzUDlLZ05YaEFScDht?=
 =?utf-8?B?cks3cktHcWJYNGZJVkU1bUFZczJoOWdpcFhyaU9oSnVQdXM5dDB6YjIyaVRn?=
 =?utf-8?B?Z3ZKZG1xRTRod1B5NFp4dVFaandMd2JJdEZSbnlsTFE1b1ROUHkrT2xoWnBt?=
 =?utf-8?Q?bhxskO9T/P6Wanqd6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2tmTHR3SFdxRWJadTNWQTQ3ZVhNbFF0WFRZSkppMk5wdGF0S0w3cmsvTTVw?=
 =?utf-8?B?NEdaWVpRa3B6RXVVK2NibGQ4OEJER2RGYXp0WVc4OUpXbEpYK1gxVlRHTC9Z?=
 =?utf-8?B?QUVlZktFWW1zY21xemFDbXkzdlpycjVVaVBsekFjVko2UG9nOXIvTFBiV09C?=
 =?utf-8?B?SHJtWXJsbzdCSkszNFhmNnA3T0hsR0k0VllXQWdVYTFiTE4yaHNNY3RWY1BH?=
 =?utf-8?B?ekJEQjJnWU9kcUQvOFNaVFF2WVBUenJ2b1pXd2F1M2NkRTBOQ1JtakdXQ2pz?=
 =?utf-8?B?dEhzdnhKSDdTcy9QYW1wVHdST2FHb3hiVkNvTWtiUWJMd1JqcVNwRXhGckRw?=
 =?utf-8?B?SG1DZzJHQmVpbWVETkxlTkxEczFzNkwyVkJYT2VOREtVSXVURXJKbi96czN3?=
 =?utf-8?B?MWptRUNEUS8wTGhxN0h0cVFMTFdWcVBxYnNqQjVqUVlDSDNHSk8zSkJmZGl3?=
 =?utf-8?B?d2NSTVhCWTBVQnNkOVhXMGF2ZEJzTUdMV1UyOFdvaEIwTEFocFBlWEZHYzIv?=
 =?utf-8?B?YWdsTmtHd3FIRXJPZE9WZGR0bnR2YzhaNW8xOFZURlVFby9wNU16OXNLbWk2?=
 =?utf-8?B?QXhxeC9nTXpUL0pZdGlkWUVhcy90cElIcEMySDYxaE85VGl4RFpkME02SkZK?=
 =?utf-8?B?Q0wwR2Vjak42Zk4rOU1wcUIzMm9td1hneW9hVWpLRXdkcHI3b0R0bThHb3JZ?=
 =?utf-8?B?TTlQeTYwZ3FLNmhCeGpJZ1RaQnlnYWZvNEwrUWFiQkZTakZVb1F6WXJGb2VO?=
 =?utf-8?B?K0JOVmgrdmtkSG5meEsxalErL0xOb3RRd2hod2EzYkZHNnEyUzladEN1NFdQ?=
 =?utf-8?B?VTdTRVlIRk5TRTRDaFRtUElUamEwM3l5Sm83RlMrSFQwTXIvT1pVUFZGTFVQ?=
 =?utf-8?B?SmlSRHc3Q0JZaFNaTklMd3NxdStXMEF5aXp5cUIyM3c3Z3FVbGtGTDVSYnBW?=
 =?utf-8?B?SDVUZXlmK3pnWUQwZDB6WXhpdml2WmZIWmFzRy8vclVDMTF3T2RQd2VMdjd0?=
 =?utf-8?B?R1lna01LblhIdFVyTVZQMUVWT0NGM1cySFIyR2hzNnRRUFpHaWo4M1d6eDJs?=
 =?utf-8?B?QktwR1I0NXc0U3NDVUVaZTFjQThtWnJEaFF4Mi95aW1lMnJzek1DbXVVdWtv?=
 =?utf-8?B?T2RmaG5UN0dEQXBnajllb1hueGRKVW1ESlBMZ1g5UGFnZTlxOFF1c2xBb01S?=
 =?utf-8?B?ckpZYUZ3TTBSR2NPbHhKR2RVMXJtSUhjU2dXVUJLSTNrck1rL2NUcUdvanBP?=
 =?utf-8?B?K3FYVVBJQUpxcnB4a1FDVWhqbW83YXpLNWMxL3pGN1BaejBSWG11ajBXQWoz?=
 =?utf-8?B?RDdQdGRnU2ZUSFZ3U2NMcFdhVUdYU216d0R1SmpOeUsxbTJOMXRzMXVGTi9i?=
 =?utf-8?B?Z3U4RUozVWtWM05saFVlOHRwN3h5RnZuWmVtMHZzc2xiUkkydklUOWhBVnA5?=
 =?utf-8?B?QXBNQi9FRnJ6WWE4MFVYcmlUQmRwclVScWhteEh0a3VTZzZiRWRoUHFZbk5M?=
 =?utf-8?B?R2dpdHZ4aHM4d0NORWd2YVpJVklielpwZDEySlNDWWJOdG9YdjNYY2crZ1p5?=
 =?utf-8?B?cGl0MmdWNWV2SkFLbDhOSXlpN0lVdXVCdVFQZ2dlcmhXZS9INzFSR1FyQ0NX?=
 =?utf-8?B?akRleGFZQVlOb1VJa0Vjck1DVEtGQzB4RzEwV3JrRnBmS1VDUi9wSUk1T0M2?=
 =?utf-8?B?ODdsNmh2MXlSK29GajgzYmQ2K1JJU0xEZjY2SkcyQTl1c3NnZTUxcnJlSVBl?=
 =?utf-8?B?dXlPaXFVa05sWjdORGJKdkF6R1NRQitQejNJUHNLMG4rcG1HeE8vNTZEMHRQ?=
 =?utf-8?B?U1czc3o3bFh6dGcybU1YVzRudDNXZDV2dm5Fd1hqSVV4cnpTMjdld1ozTVRa?=
 =?utf-8?B?cVM2cEdFQVJ6bGpTTzBpclFvYU5xRlhQWVFkR213am1CVUtObDV2aW1uTkdv?=
 =?utf-8?B?dnQ2M283YkV1cTJ2dSthL0QzSkpxbnNQbzF2Z3ZueGhuaHlkbWJpWjhOMnNn?=
 =?utf-8?B?UENlUitDT014a3ZqdGxvU3F6aUZhT3VLYVlZRHJlSUEvVWNURWRSdDhhT1Vm?=
 =?utf-8?B?SHdrdExaaEk1Uk00MEwzZjNJOStQc1Z4a2NIdEx3SWM0RnZ0TTVXMjc2RU5u?=
 =?utf-8?Q?dhPWuOAaXUlSM2lq/b1GF9bqi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5d14dc-cafe-45c2-18ed-08dcb694c4dd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 03:55:25.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13HC9cjD3Ve8kWbhQkCRFG3WnzicSvJs7t4DDJeTnj5MbPbMIvP7zJFfSH8VTtXyQiAIyuvM0t0xZYK4p6J8GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536

On 7/30/2024 10:22 AM, Manali Shukla wrote:
> On 7/9/2024 11:21 PM, Manali Shukla wrote:
>> Malicious guests can cause bus locks to degrade the performance of a
>> system. Non-WB (write-back) and misaligned locked RMW
>> (read-modify-write) instructions are referred to as "bus locks" and
>> require system wide synchronization among all processors to guarantee
>> the atomicity. The bus locks can impose notable performance penalties
>> for all processors within the system.
>>
>> Support for the Bus Lock Threshold is indicated by CPUID
>> Fn8000_000A_EDX[29] BusLockThreshold=1, the VMCB provides a Bus Lock
>> Threshold enable bit and an unsigned 16-bit Bus Lock Threshold count.
>>
>> VMCB intercept bit
>>     VMCB Offset     Bits    Function
>>     14h             5       Intercept bus lock operations
>>
>> Bus lock threshold count
>>     VMCB Offset     Bits    Function
>>     120h            15:0    Bus lock counter
>>
>> During VMRUN, the bus lock threshold count is fetched and stored in an
>> internal count register.  Prior to executing a bus lock within the
>> guest, the processor verifies the count in the bus lock register. If
>> the count is greater than zero, the processor executes the bus lock,
>> reducing the count. However, if the count is zero, the bus lock
>> operation is not performed, and instead, a Bus Lock Threshold #VMEXIT
>> is triggered to transfer control to the Virtual Machine Monitor (VMM).
>>
>> A Bus Lock Threshold #VMEXIT is reported to the VMM with VMEXIT code
>> 0xA5h, VMEXIT_BUSLOCK. EXITINFO1 and EXITINFO2 are set to 0 on
>> a VMEXIT_BUSLOCK.  On a #VMEXIT, the processor writes the current
>> value of the Bus Lock Threshold Counter to the VMCB.
>>
>> More details about the Bus Lock Threshold feature can be found in AMD
>> APM [1].
>>
>> Patches are prepared on kvm-x86/svm (704ec48fc2fb)
>>
>> Testing done:
>> - Added a selftest for the Bus Lock Threadshold functionality.
>> - Tested the Bus Lock Threshold functionality on SEV and SEV-ES guests.
>> - Tested the Bus Lock Threshold functionality on nested guests.
>>
>> Qemu changes can be found on:
>> Repo: https://github.com/AMDESE/qemu.git
>> Branch: buslock_threshold
>>
>> Qemu commandline to use the bus lock threshold functionality:
>> qemu-system-x86_64 -enable-kvm -cpu EPYC-Turin,+svm -M q35,bus-lock-ratelimit=10 \ ..
>>
>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>>      Vol 2, 15.14.5 Bus Lock Threshold.
>>      https://bugzilla.kernel.org/attachment.cgi?id=306250
>>
>> Manali Shukla (2):
>>   x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
>>   KVM: x86: nSVM: Implement support for nested Bus Lock Threshold
>>
>> Nikunj A Dadhania (2):
>>   KVM: SVM: Enable Bus lock threshold exit
>>   KVM: selftests: Add bus lock exit test
>>
>>  arch/x86/include/asm/cpufeatures.h            |   1 +
>>  arch/x86/include/asm/svm.h                    |   5 +-
>>  arch/x86/include/uapi/asm/svm.h               |   2 +
>>  arch/x86/kvm/governed_features.h              |   1 +
>>  arch/x86/kvm/svm/nested.c                     |  25 ++++
>>  arch/x86/kvm/svm/svm.c                        |  48 ++++++++
>>  arch/x86/kvm/svm/svm.h                        |   1 +
>>  arch/x86/kvm/x86.h                            |   1 +
>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>  .../selftests/kvm/x86_64/svm_buslock_test.c   | 114 ++++++++++++++++++
>>  10 files changed, 198 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_buslock_test.c
>>
>>
>> base-commit: 704ec48fc2fbd4e41ec982662ad5bf1eee33eeb2
> 
> A gentle reminder.
> 
> -Manali

A gentle reminder.

- Manali

