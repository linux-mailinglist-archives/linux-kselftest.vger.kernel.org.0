Return-Path: <linux-kselftest+bounces-33321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECFEABBCB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69B218940AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB08C27603D;
	Mon, 19 May 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NWrP+V+e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05644C92;
	Mon, 19 May 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654754; cv=fail; b=ZMr6Tk14wAMuoVJMyesEEwWd9YkViQuc67PsH/Rv0s0ldIdGSVAPGR/ebwEcBA3Tr31HkOSMhwUYolTuo/mO0+26N1TzX7hXQfN0nR+jNgEMuvfpQNVeaoDN8ZhcIgvr9qp1QEMi6nlT+r2NM4O1eFaW0wZ1mQLdwd0+WR4bHes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654754; c=relaxed/simple;
	bh=GPSXGJRU7j+vKV47vnbGl9j12/pRCTUw6z/OED+YRGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rsCyQoJp0vVjgiBH8QZ/hBaPpxKzsoOaYGPTSrv2T7Uyc75AdAT5On9czbLtrsyoczvv1X3d1XCN7YsRihq+rcTjNvPQ0qoOheHgwWI/TWWzxTFbXRDGn8kZpG/qMEQAcVKvuKG9uBYhjxcbmfZzirtnxJUNoKff5zn4s00TaBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NWrP+V+e; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+48LeX6Fjtc/YDbO2XRv49lSu/uv2IjPztQ9kZIDDvcnSyzKQhkKDnweuZ5EoRfmfw4RJrb2Ur+7DmU5YiSQoFC1wIx/U5SzyLZAvqDiRGWV78vO0nc2aeObbpOKXOMW6/DmHen/JeqB1++MBSK9d7T6GdwZPjpJYVJDo0vAcKiQlr/dZfdFj+d1oQVrmUCXikDTD1TKdzZau3T/ArU1ai/BNQN40pIb53rOJMW39xtJ/NEUxviVUYCJKqVtGYc34yJc7i9YTyz9T2/f398OasF8mnza4GPPVDOQri3Pq7ZhRVPXH5amWHU6DUh5Gi4GDTHVhG/A5lKRUVSKoBgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnNPrf9RvclxbaBaB0wB+61qgH3zfrp1cOGO3R6JgF8=;
 b=uhIfMoxwsXnWxv2xuR4vAgs59rkFpK+QaRzQloGumrsEpJVk8tJ6eFWRvJhEmB3pP43ShoFX+3LYLvQbZIerjWq27FhYIpXEznsSPZtMyMKBEJFuXxIrkFi/PPUhzPjiA/52ME0MH4Q8EC35B5g4FwAwfKis8kW5sPne6u6QwnSZR/GJU8vfE6gyNAV8PK3316o1C4SjWx/hHMnN9rSxRR4pgCK0X2+eHqzdtA5OHvE6s+2juWF44qdq1BXNm/Jfo83wbRIJM6iBxt8SXRJ+3OWpIZFB+MaejIzFooKzvOrvifWdezB8qEe57ddm9qwoKISqUVsYwaBKvqay2BTJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnNPrf9RvclxbaBaB0wB+61qgH3zfrp1cOGO3R6JgF8=;
 b=NWrP+V+ekb7rkVhYH7twbsGOp3uWwD5nGhgFDx/LAVI3DNuKxrCTjL5LdKk9CifISWxpMy8L665XE9LpnPIgloILNajdBlEGOCRrvx5hJY7n0qbo3c8/yCIcCWcNcJVuIrVDqhX7GUKt+WsZ13OvBdK89qjpvbLw9HFqzphB0tA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 19 May
 2025 11:39:09 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 11:39:09 +0000
Message-ID: <6822063e-1ea3-423d-9728-5832ea53e4c9@amd.com>
Date: Mon, 19 May 2025 17:09:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add support for the Bus Lock Threshold
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, nikunj@amd.com, bp@alien8.de
References: <20250502050346.14274-1-manali.shukla@amd.com>
 <ff1f0e75-a13c-4f6f-82db-94dc600d6367@amd.com> <aCeLcLiioNJYXhRh@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <aCeLcLiioNJYXhRh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::9) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd54b2f-93f9-4eb7-13c3-08dd96c9c4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cExONE5aOG83YUNHdFkrbGFySzZ3TDFxTFovR2NROWsyVFhCQ0tsNjJtM01r?=
 =?utf-8?B?VllieDlKNm11dW94YmpCVUowL2NCdEVVeGsyMktib3ovblg4OG9haldwWVIw?=
 =?utf-8?B?dWlKeEUxcTEwdjF6UmN3ekh6cndJQzViaTdYRXJJVC9vY0p0c1BhZllHckpn?=
 =?utf-8?B?R012a0hNMXRhWnVDY0d0cGZhLzZsSy9UcG1COUo2eTVLdFJjSW8xcUNRUnNJ?=
 =?utf-8?B?WDVzOFdWbWRhUm5OcnZuekE2Q2RSRjlBdnpEMm9XL0RRSHYxYTdKbVo1Kzdt?=
 =?utf-8?B?c1NIRnNOWFBjaHhGbEJhMXBPdTk4N0J6bzBTOU9DdUdLN0phOG5RWFg2M2Jl?=
 =?utf-8?B?dmJ5QXE1aXIxckFRa3lTT01kejdWb1pCZjcvcEo4d1ZWYTNyRUY5RjYvbnMx?=
 =?utf-8?B?SmFLQ2RqRC9HV3dUbFdqdG43aU5MNVN5bXlxeDQ1bXdoMHFuUTlhMDBBM0hn?=
 =?utf-8?B?OWptZGM0RjR5ZzI5bnJ4enlUYStGdEx2aDljQUlYOW5BOXJlQWxXQS9SWXhM?=
 =?utf-8?B?bU5BRFlBc3FrZnU4ejJqVEdZTXMxdzdnWFA2aHdYaUd0M0pDVTkraythcGNs?=
 =?utf-8?B?YThERXZDaUdYQ1l4aWx5WFJIRkFaM3Z4MXNncjZtU3V2V3Fjd3pleWRJa01T?=
 =?utf-8?B?TzM5NHJzcnhmanV3N3U0ajNsS2R2OVRXL0ZzaU5hUHR1dTJ3QlZJTjB4M0F6?=
 =?utf-8?B?Vy9HSm9ldTYyTDRTZkVRTVMvQkVvWmFXR1hKdmpjalc4SFRoK2tGNEZtaXBG?=
 =?utf-8?B?WXlPZGZtaFJHeGwxYnVwd3lQZXFvZFhoelRBT1RsYWc1blZ4UWdEblpCSmRP?=
 =?utf-8?B?VU9GeEJzSys3a2U2T25HdENQZ2lycnJCQnFSQmNDWnl4S2hUTTdYdjlsTnFl?=
 =?utf-8?B?ejl6VUdVWGZRY3FUaE5HODNKM2NtTFRWOVNzMlBidVZFR2JFL250ZERUaHJ6?=
 =?utf-8?B?RlNQSmZiWlBOYm1ZQWROb3VocmJPaU5xMUw1VUVncGMxUG4vbzFwbm5kM1di?=
 =?utf-8?B?RGhSTUlzNUR1V1dvVmdIbXJadjdlYk9vS1NkVFdDMTRyZWdOcWhhUVRwZDll?=
 =?utf-8?B?Zk5uTHM3V3JTZFViTzBieHJ6UTFMZWo2U3I4L3FKQk45TGZ1VzNHOFNxOFJl?=
 =?utf-8?B?K3pXeHVmc1hoSDV3Y1A2bWVuRzdOUEw4aUhKWG9iOUxqSVJwNGQ4UXhnSDlq?=
 =?utf-8?B?eGN5UUJJQ2d1Zk41WVB5RmNTS2R4TVpaM1hDRzV2Ly9qYnk4Mzg5TlVCZUtB?=
 =?utf-8?B?NTZHRHdJT1hUTCtLbTExMUZLakZlLzhUVVdwQzhOQURQeU03eUMvTCtaQlJn?=
 =?utf-8?B?SlBmYVN0T0paTTJJZGxvUjdneDVWazdVRW9kUTBoc2xIZFFtbFJ0cFhKZVRI?=
 =?utf-8?B?TU5ERmZYL3BjWURUSUp6QVphNFlSN29tRWxOaWFWNVFuK25TZjhTaG5ML0JS?=
 =?utf-8?B?c1liUStTY1B0VDkxU21nTCtUdTVqdkprbzArakRqYk1JUExFVUFaVFBVdVVF?=
 =?utf-8?B?K2t5endsalI0MTQ0Y2lxQ3ZySWx6Y096TEd5UXVmVGVDbEQ0ZFhnUHdGTlFS?=
 =?utf-8?B?T1g1SjI3WHgwSmlpOFZvZEZIS25DUVJtT2RKRU5WTmlRSGM4MXdrQk04dkNn?=
 =?utf-8?B?VkkrOFdxaWpDNkFOTjJwdTR1OUxRVDVSRktLWUUwWHFVMldQbE0xYTcvSWRB?=
 =?utf-8?B?T2Nld01OeTVra1ozQ3U4Q3JFV0FNNEV4cm8vZG5ObkVHVTA3M1dnVTZKYTEx?=
 =?utf-8?B?TVJRUWhxSHEzZmNsTGtlb3BjLy9NcGtNdzE2SVhqMlVWMjJOcm16VExrMXRJ?=
 =?utf-8?B?M3k3QlRSMGhZZ1ptSnNUbzg1VDlHSzk0Rndtbmo1V1ZsbkZ0NzZZaVZyWHQr?=
 =?utf-8?B?by9nMXUvL2RDTDFzZ1JPVEV2Qk1qSkJrS2JXQmNGRmxkRUlLcFZVNmtrczJM?=
 =?utf-8?Q?3t9naHnc8bM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak1UcnBCRGRVRTRJeHJCSTl4Q3h5bmNyTExBM0ljaGxHUG5oaGtrWUdGK3d1?=
 =?utf-8?B?NU9vcW9KK216REpmNEdac2xGa3FJcjd3N1BJNTFiM3VvRGpzeklOS1RMb2xG?=
 =?utf-8?B?bzgyVGRYU2ErN3dtWDJ5TGZjYVpDcWV1QlRnWlJnQnNDSEpISy9tdTZpUDZJ?=
 =?utf-8?B?UndvU0xBRnRFaXdvdG16bGt5ZHVGQlJWQ1dBZTloZTU2bWxsZ2pOVFRHWk1w?=
 =?utf-8?B?N0p1TEp0NjV6YU9LS0o4VHZqbFpubWVCNHFIRU4xQVVaZitTZVZleElzMytm?=
 =?utf-8?B?Q2t0ZFRORW9DNnRKajZFQWYxNTJvWktPd3Q4NTAzSlZOOTBNeTIycExLZXpU?=
 =?utf-8?B?a1FDUldtM2VEekhxRFRObEFKVVlxR2kyUmRSb1JqTEhhdTY0enVMTWNjc0Fl?=
 =?utf-8?B?OStTbzFSODltT0dPYW5GMEY3cmZ3NWUxcmhxZHRuUFpZWkowK25XWnk2RHla?=
 =?utf-8?B?UXpzQWpILzlVc3ZJY0tvdWlaS1dhZThJMUlwOWhSZThSYytlR3l4dzhpNytt?=
 =?utf-8?B?QStLTUlaRDNJUEMvaWNXaEVTczVrOHQ3eEVFWGdQdkNNVjRWVmlLU2I3cWFI?=
 =?utf-8?B?Z25CK2Q5Qy9WMVBhaHFnWkNWTHVKcUlWcURjc0ZNclllSU9UaUVna011SjVL?=
 =?utf-8?B?R2EvOGNMT0NzellScU9jRjFUMVNTaTM2UkdkTDQ3ekVHblJ2VENSSHAzWkZ4?=
 =?utf-8?B?UzlzdVVHY2cvUjhzRmtJUXN0U0RES3ErbHl3VmdvS2lUWUFKWjJyZW1QbitU?=
 =?utf-8?B?M3kyWGttMCsyOHc3Q2kxZ2NrSFRhRWJqbUdteTdoUnozbGcxM216VVBtVEtL?=
 =?utf-8?B?NTgwdXJhZFd2ZUFONm1pdGc5YmFWUkdSWndCdjNlYUIwSEEvenBRT3AzSjk5?=
 =?utf-8?B?MjJDbm5XZWFHNndadDFVeXFNbi9MT0hQK1Zhc2RDNTlZUE9DYlZCcTloTnds?=
 =?utf-8?B?b1Q0WkEreHd6bldnQmVTeGErNXBFQ0hweUxuSXAycVVqdWs0RUhXZVlUeUVT?=
 =?utf-8?B?QytuditCQW9iRkU5dGdleTM1Y3Z3amFNR2lFUUJ5OC9xUi9NQnI0bUFBOFd4?=
 =?utf-8?B?R3YxNkEzTEtLTmdDeEZoNlMzT0hMTW1CRDhtMzR5UHZqaE9MQWZIM1RWSjdD?=
 =?utf-8?B?VWoyNm4rSmszL0ppUjR6N1drSGxvL1I4aXZpMUNEZ1dpMjRXS3NoQkhjblN5?=
 =?utf-8?B?UkxqaUhJTW01dndoZTNadTJyc05hNE1MSldUclF5am1rMkpPWGIxeGduYmti?=
 =?utf-8?B?UDZmeWtBSitDdjhnOG5MdmZLVU1iTHF2NWpibFNZMzRLSEdTUlhJZ3M0K1k5?=
 =?utf-8?B?QlMzYTZWSlRna1R0VXdya1FLeEdzbFphd3pNWlVxQlBiUWhWRmRmQXlnZ2ZY?=
 =?utf-8?B?WWJIUjhIUFY1RXp3a0JQUkEvQ3FZT3F5a2VtR0V3UFQyZ21zUVNEOTBQcVh0?=
 =?utf-8?B?blIxTFRUSUxlVWVYS25WNTAzazVXbmhHSGU0VjhaZnc5QTQxSmthdUNDOVJM?=
 =?utf-8?B?V2RjNERSM21ZZnQxRUpJUGNmUXBReWxaRnV0M3FLbGl5Q0k2Z3YrQkdaVCs3?=
 =?utf-8?B?SWdIMDc3MzFwblhJeXY1SElpdXdRSmVZUG5iN0ExRURIOUZWQmZXb2dPQllN?=
 =?utf-8?B?RkxGYnZMWkwxenZxYVNtbWttYzhGRGVORXh3cXIzUWhOZENWMFJDZ2M2WEFy?=
 =?utf-8?B?VGUvbzFGSWIrcXAxN1p6Tkp2Z0syRzA0N1ZiL3hxamw2REcwbG9vN2pRVk5m?=
 =?utf-8?B?WnpaN3NsbWZzNWtkbHVxU082RWRlTENPQi9SWmpSb0JQZDN6Rm5OMUdKS3BO?=
 =?utf-8?B?NTlyRWlpdmc1RFJjTmFVeVNPUjlqVFhKTStpTElNc2hrTElpMXVRUlRDRmQr?=
 =?utf-8?B?ZlZuQkFxSXdUK25qSDd2aXZuS21ocm9qSTZXQ001RWptdTRUOTdnbGF5bVhU?=
 =?utf-8?B?ejFOQndBQmRLbHAvS2Fic0NwSE1VU2xENkVXa28yQTIrN05lcHo3Q3RTaFQ5?=
 =?utf-8?B?WmVhQnVhZkxGVlp4VFI2M2l6UjNLdzA2b21XQnV2RGlRditVd3BEZFEvNDJt?=
 =?utf-8?B?UUpxRTJOM0hoZ09YczVIZ3pRVXUwQi9xK3hlU2lKQXdTT3ZJQm9FcjUvdG1U?=
 =?utf-8?Q?qVr0FwQjRdV1yWUgztz2UcVuV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd54b2f-93f9-4eb7-13c3-08dd96c9c4cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 11:39:09.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+3rXAx3CYD68cmDV/NBD15GeNna0wg0AqUFbS+Y3LAoI585tYWG+UdeZDpGZWOrVOVCl5rwmzcswUJDliN/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

On 5/17/2025 12:31 AM, Sean Christopherson wrote:
> On Mon, May 12, 2025, Manali Shukla wrote:
>> A gentle reminder to review patches
> 
> (a) Trim your replies.
> 
> (b) Don't do whatever you did that generated 8 bajillion "prerequisite-patch-id"
>     lines, which causes b4 to barf.

Thanks for the feedback. I’ll be more careful with reply trimming and avoid generating
unnecessary lines in the future.

-Manali

