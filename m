Return-Path: <linux-kselftest+bounces-10765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C561F8D13EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 07:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B352284CDA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 05:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB70B38DCC;
	Tue, 28 May 2024 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dyJDJ+T0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BC4CB4E;
	Tue, 28 May 2024 05:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874298; cv=fail; b=XIvo2XZr2VQiP+NLiogefQpReTH/fWXvQncNflTSQA2mnB2dDcOFgyTA2kgrGUo3kqxPvK+YPg0B6p7BkPsV+DDf61hQE4nEJUC36v9DmIOrybDzGKCmBwJgYtD0jbKzq6M7PMD8+FVEEhPqntZ219SNfYT6g19f3YoyRYxgJgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874298; c=relaxed/simple;
	bh=b8dLcW/5e1AC2g66BIf+SqOR+pKk8nYyqn7uARxW7KM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f3zD0CNlzQbkEgmoqjRfHJDT4M+8ePCrRQWrrJ+nRoQ10Kp6aR/bA3bWLSdvfz5ldxhM+BcmDnAL75NwNy2dNQmQrPWw7qWPDvMhfrWrVWKlvTd2iFpDmAoJSglIHteNCtuss+FMo6v7yRXWuWFsQT6zhiqGhCVWHCmxhSpqcCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dyJDJ+T0; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCjehLte0uqkpsm30d8T5wR8Zr8z75dEAsJIv5mv8JTA5Tmgfa4w08LwszXHJSdMh2MuZQaVxfn0/NcSmvirKpFZgjFdm5zSZykM/d7srknPQqLhrf3K4+sOW6hrDxNT7imnEXjq9a3qYgtZdYW+eCiQYpkyBg+JFeaph/Geg6zPGE/zC8RNnjJAT4TjXkMd93so78RKWJFNbRTWLFQEPY+A+t7MEu9YBVp+7M51p2yfSjGYR5oDsOyoSxGFjBcCTitrpRy46AyrGsc5P8lJIABleJoyzMAPoXuLjEC4s6MQtA31T10TLs+auXZOZI/MzMZ2a62+Pxz7qQ5VrXrxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqdEIlTESx8IoEIVN5QoUBMZqYXQ2Z4zdvqe40ZKiWE=;
 b=FpuKorsGCyBkNnfBxHFNMLSQlC9xYpRZBsI7U1K3NYU135bf9I9+tDA84O4qnIPnq8l9soLXA8sAOOsVvH2Aq7+PhSRqgwj8Lj3TqXzdhEdBGwPy+hKJOkN5w1qE9NOvN4S8ox/dhLOTA3Xk8egjKNDkR+opuYr4DWpHcDhU7cciUzbrslJmPuekMVbvxcLZtRqajIXUolnQeORs+3NvEiVJgsZj+JP5MngLXQN1azb88Tnp/BkK59m/U1cd2d3UZJJz/Os8AgQOp32rhUra6/3VADzFYySwOS5jdlD35TpF9GgK8DhI4s35HPxUoNQwNsFtUFH7IcXfFH/OTox7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqdEIlTESx8IoEIVN5QoUBMZqYXQ2Z4zdvqe40ZKiWE=;
 b=dyJDJ+T04S9eNKrec8MgDHSn380bsSiIBS2Ut4mLK9NdeCUXlzoLERh25GjRtsyUwgFmwWeZZOfBvcVwgNX52/O7ljAuU3VKoZpVNxXSG2CFJZXi30PiiXayNkF1QOhk1dK4sP+xPZgaUyCCNmsdaih0n/jhzVo6V4fSY4eDsvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Tue, 28 May 2024 05:31:35 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.7587.035; Tue, 28 May 2024
 05:31:35 +0000
Message-ID: <7a5ffaa2-9b18-4700-b4b6-da414333d894@amd.com>
Date: Tue, 28 May 2024 11:01:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftest: Add family and model check for zen4 in PMU
 filter test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, manali.shukla@amd.com
References: <20240501152451.4458-1-manali.shukla@amd.com>
 <ZjJghQ25H-ttaV4b@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZjJghQ25H-ttaV4b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::25) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ce8790-52e3-4bbd-2a3c-08dc7ed7700a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akVrZDV5Zk9ocEZuU2hSd2dJZTJSOEN0NGNjcU1lcE5WbnpYbUFzcFRIOW9h?=
 =?utf-8?B?UXJKTnpYdlM5cnhwRS9OUktNaUtkQnh5RmR1NmJCUTVWbFRNZnVoQ2J5UitN?=
 =?utf-8?B?aUgrVTlQVk8zN0hLYmpnZU1oUVREY25xU0J1OFhOcTJiQjNLN2VFSFdTN0hk?=
 =?utf-8?B?NkIrSktjZS9ZVkI3VEtEYVNDU0dmZkl0Zk9jaFBjQ0xnaE1kSUowVkNFQUFJ?=
 =?utf-8?B?b2hENEhoNlFiN2tINFBtWXduSnpaQXBrelBMdXJpRkJEMVRnOUtPVDJNbVcv?=
 =?utf-8?B?Z0dqZ0QrVTJPZXl2QzFCM2VKSjFZVDczMmR4UFFzVEx4dm9LUE0rWGZlVEhL?=
 =?utf-8?B?VUlFZFNPUEpkemM4M3RxVkNCRFBtMXd2QUxNSk1vck9qc2lRbnUrSWphUExJ?=
 =?utf-8?B?QittTjV2azlDcy9FNVk0Ti81QTVsQkhkVlprM0lpdkNIdEl6N1BmR0tZVmpu?=
 =?utf-8?B?QkVDQ1ptdHovZ2FEeUQvL2RGeklhcU5DVEpMOGVlOWNIYjlBVGlnalVldGlE?=
 =?utf-8?B?TVhjbXhta3dIQ1pJbjVya0ZXbWExYkJOU3Y3Z21aRzk1VVFpcHhDOC84bi81?=
 =?utf-8?B?QjQ3Vm9vWGcwbXN2MjNoOTFGb1F1SDE4U0NOOEpXWXAwZUJKTnBYVS91RHhr?=
 =?utf-8?B?RCtEYW5yT0ZLaGd3VS9qVUNodjhQYWFvTDlycmljU0M1d00rS3NDZWFQcDZX?=
 =?utf-8?B?M1Z3MDBXMCtWN0NQSG1CNkcyYzQyZ0lOREFUb29yeWVpaVpmS2l1WDJTNjZt?=
 =?utf-8?B?cDhzQ2N3MzBQSHVCdnJBNVNlU0w0OGJHV0VCbHlTa2RjWHR4dlhJM0RzOStx?=
 =?utf-8?B?SDcwS1YyZmFHOHh1RE45SmVmQ1U5dWI1TkJaV3YyckVKMVdOZURqTWxhWnhT?=
 =?utf-8?B?UFBCU0M1WWNyT216UjN0Y3BKRnd3eElKNUFQck5nNGMyTXp2VW1FRjlCaTJl?=
 =?utf-8?B?V2J4WFF6ZVl6TjdVMXBJL1NUTDBIZ1VPK3d5Q2VNZmZTKzU1N3UxMWFRZUJI?=
 =?utf-8?B?cUFaUnpZQlFZTHZyYkZhSGpHdlBtMmxySDRSWllVUWZLZXRyMVpvZklNcTF4?=
 =?utf-8?B?MklBcHQwVFNMK2FoMnNzakQ0blBteUhCdml0UnlQeFRGcG1aV1pqQS9KYzVT?=
 =?utf-8?B?ZHVQZXYzK3pYdC9WMFp6eVJ3MjY5dlI1bE84enE4Wkg2VVFDcyt3cWx6Uy80?=
 =?utf-8?B?dmxiQzBIMUZpYXp0c1ZKREVYRXc2ZmZOVTUrOXBHWXFPdlY4OVA3SjZwZDA4?=
 =?utf-8?B?Sk1RRTNLbnZ6THJQM1RId2FYdW5EaXFGc1l1Y3poRkM4dW1ZQ1lFbk1pcDZw?=
 =?utf-8?B?ZlJMc0p5NEQ3eVhLRmR6Z09sRmpIRGpvTU5RcGNxdExEV2tqQ2FNcjJyMnc4?=
 =?utf-8?B?N2pCZU1POEZIYXFOazM2YklGSDhiUWd5c0xFWHNhekJMekpvbWlyK1BJZTBa?=
 =?utf-8?B?dHVOek0yUUcxby8wYzhTTE1WajcxNHM5WkNiTllEd3BYbGlmOTRPVW9za0lF?=
 =?utf-8?B?UnZ2YjNKeDYvMGJ0Q2pzQnFnY04vV1pyZHI2bTFkblNkQXRRc096VW13YzN5?=
 =?utf-8?B?ZWIzTGpIRXRhaE1vTkYvSUpVclpTV0d2OXN2SGxmU3dHeW05WUkwelFadTY4?=
 =?utf-8?B?M1BjTXNxZGNITFR2MHVnUjhOZnB0T1FkZG4xcG1aTFppN0xsamdHV2VKM1R4?=
 =?utf-8?B?VmtDMDVuVGxjNXEwbUQ5ajI4SkZVMHp5ZFU0bzRXeGxIcDZsS0lZbWh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEV1NitmQ3V6RHpkaTdvZDB6bmxjK3V4M1J5YXRWUm0zZDFmMUVFVzFWeTk0?=
 =?utf-8?B?ZzVJdUxkRnlFOS9lbnp0NUlZTklFTFpldVIrQ1FBVGNvSk5qbEw2RzVaTVVq?=
 =?utf-8?B?ZHh5cmJKYWxQa25SWVRUQUhlRWkzMEU5Rlh4eDNWZUEzR1lNYmVyeVpVMFZV?=
 =?utf-8?B?T09aV0Z1Y0JuSWwrd3VuZlAvZGM0d04wTVU2aUFpYUpiclVHL1MwbkFhSGZo?=
 =?utf-8?B?RFB3aHdYZS82LzN6aWkrc3F6d3V6SVU0dnRYa2ZSa285TlArQzcvbTFYbWN6?=
 =?utf-8?B?UVFTQUFZUnhzM01lbjY1RldhcGQ2N081UmJGNENjcW5mZmpWbEV1eWIxSTlu?=
 =?utf-8?B?MW11TXBwcWYxYVhLMDkzZ3pwM013N1BzbGtieVJoUlBkd0Jta3loV25Lc0ZS?=
 =?utf-8?B?THRSYjJHS0M5b3M5NGZjUitGSkNZNnNieTJqNE14L3JKdWRiaFZpTG5lcGdp?=
 =?utf-8?B?bEgvZm5MT1lzUmZ0U2lYVGV5ZGNKRXJ3bzdOTE5JMlBKWmFISDVsNG1JZUFr?=
 =?utf-8?B?a1ovcytuUk0wam1wOVl2Yyt1SXZObUhrYlVyVWp0QkNUeC9YWHpUczFSTFk1?=
 =?utf-8?B?NGRSbXhMcytGVHpKVEQ1aGJEaXJuYTAzUC9wS3VpanQ1bGxoaXlVU0kvSHpk?=
 =?utf-8?B?elNaVkcvTmVHWGZNNVhtMEo1dTNHSjFoNXZZODh2Nkg3ZlNoUUZmdy9ZdzNt?=
 =?utf-8?B?V2wweGxEV01XZ1RyaTlOR0lZZzVKYUM1eXRnM0FOZmF0T08yTU01ZVZLdDYr?=
 =?utf-8?B?cW9yVlZsbGFsdDVmV2FEVEkrYlBBU2dxcVl1NVpKa1R3VHdNVHA0ZEl3SHlQ?=
 =?utf-8?B?M0ozb1l3cFJ0SG1hN0ZtcE5LQXNjeko3a0ZLM29yUGY3bWZIamN5Z3ovSjVE?=
 =?utf-8?B?aDFJc2g4cUxHK2FSVS9CZk5zaDZTN3Fxa2R6S0FqMndmNE9tT1picm5rMjJM?=
 =?utf-8?B?RDEzSnpZcG92V0UvcEROQTNTdWpQYzhsQVdYSWhpSDA4LzlaYiszaUxLT0M1?=
 =?utf-8?B?V2U4c3ZPQ3ZHNlJHbTNFS0lPOHpDeWZLTm5sTEsyOUZhQnVaYW11WWJZZENl?=
 =?utf-8?B?NGtMOUZQd2pvRHMvYS9EaEN4cnliaDZORjlzYk01bWFveDhGUFlIdXF0dC9M?=
 =?utf-8?B?cjB5YWRQRGp4TnNucHM3N2pjR0tISFZNV0hYVldLeTg2anNtOW9WMEZyVkk5?=
 =?utf-8?B?UjRxYlRwVFJJY3VHTVkvam8vUVhuRFRKbzlBNFkwaDExczNLb3BNZG5FR1di?=
 =?utf-8?B?d3dyT2pTSjhpQkI0a0FQc0pxRS9Qekc2dHRRWDVmYXpxRzNZNTFRZi80Q21K?=
 =?utf-8?B?dGdZK0J5YjE1d1dJaG4wSkxQZE9uajRYVlowdUd3d0oxMkVxZ2UxL0phZFY1?=
 =?utf-8?B?MHQ5cWhnVnhWN1ROMzRKQmNMY0FpclVMcDJYWjFxd01pY2ZxYXRvalJpUkpa?=
 =?utf-8?B?NlNJandxWStpVUxONGNxT01TOUpCRkczbGlVVmJNMkRndVUrUzhZaktGM2VR?=
 =?utf-8?B?Y1p6R0pJeFpuNDhNdFZKOUpIU0o2N3FEUEF2NzVMcWM4QTFTZVRnNU1aQWYv?=
 =?utf-8?B?dFpnUStyY3Jpa1BkV3VPVnA0STF0ZStSWkRNWTdGN0tFTDdySlVlODhnUWpE?=
 =?utf-8?B?NVVFa0NFR0RGZWFLYzdLb2xCY00xNytrL050cTBwRmYwcDFSSlM3Wm83OS9J?=
 =?utf-8?B?S0N1SGZaeFRYUktYNWhjNkNZV2hFb05KZzlUQmkxWlM3Y1duTUZ6ekVFL1M5?=
 =?utf-8?B?enJQNGE4ZEFYbTdwdlIyZld6emZkLzVVZ0RTbHl6TnJPdVRSNGRrRGkvaW9J?=
 =?utf-8?B?UXhSZkhMREo0dlNZcWtPc0NYVmVyNHZydmRpWHBjMFRUQU9IUC9WNUNrMFFQ?=
 =?utf-8?B?SG1YL2tBZzQ3aFUydVJPQ2dRUnJZVFNub3oweStreXJ2SzJ0eG5saGlEZXRm?=
 =?utf-8?B?ZVFYb1JydFROSTdqdlhkalRud3YxRkNiMUJXNjlKZlVXTmZPckgvS3lkSEZh?=
 =?utf-8?B?ODdjejNBUm95N0lJU1JpQ2tBQzdMa3ZXTUU2dENQc2owNm8xT3FMNlMyeW5K?=
 =?utf-8?B?QTBxYXpTZFNGcHBGNkZ2WmRQdlFtTkVDL2pnVFl0QXJqNzNiRHl2cURNQXVH?=
 =?utf-8?Q?Ak3Yy5nfT9AhX3Y1ABc2n3YfP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ce8790-52e3-4bbd-2a3c-08dc7ed7700a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 05:31:35.1100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SH2SkKlRNnQKGPRbOqbnhT28KVJ5wR0GS82LkWzh9UkR9sqPKiciETh3Dgwf6hcCWDqfw92g0YswAuYmpV5oEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

On 5/1/2024 9:02 PM, Sean Christopherson wrote:
> On Wed, May 01, 2024, Manali Shukla wrote:
>> PMU event filter test fails on zen4 architecture because of
>> unavailability of family and model check for zen4 in use_amd_pmu().
>> So, add family and model check for zen4 architecture in use_amd_pmu().
> 
> Is there a less ugly way to detect that 0xc2,0 == "branch instructions retired"?
> E.g. can we instead check for v2 PMU support, or are there no guarantees going
> forward?  Pivoting on FMS is so painful :-(

We have confirmed with the hardware team that 0xc2,0 == "branch instructions retired"
is always true going forward, we intend to maintain backward compatibility for branch
instruction retired. Since event 0xc2 is supported on all currently released F17h+ 
processors as branch instructions retired, we can check for "family >= 0x17" for all
Zen and its successors instead of checking them individually in pmu_event_filter_test.c.

- Manali

