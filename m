Return-Path: <linux-kselftest+bounces-26678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF5A3657B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 19:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79FC7A60AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F972698A2;
	Fri, 14 Feb 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pVYAflRD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1862690EB;
	Fri, 14 Feb 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556577; cv=fail; b=t4rmauruEx3YcAl10uvqqfBEa4rzl/VmUeH/eOZ2jLDLgp/vbU9U6z02bKznkIktlNkb2j/nEpNdWvrGfASRhwFUVhuVPtygbU18sxN/U29aPWOJyE3Wj1NMsZzuZWv3lPajjrnJXV8CJGB+VncGqitSQC4vyvzbd97RVbyTRNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556577; c=relaxed/simple;
	bh=ripKoqclxSe6hF/axdFIRueOPqHPZjcHS4COGnCjVxc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D591NYCAASGVr99snIws0fNJp87Z7V6u0tU7wDGXfWw9MVcww2lb9cOPIxAI0x0t6uzyyXV1eb2ofrz7qN2YC5cjn/q0wlibyvHHebqHn7jpuDZ3aze3JCsVPCaMgMgg9JigIMrTc1kD1gRCCo7Fd5aat3r7eQ1G+Vqnm3PSn0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pVYAflRD; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzqhmPheUk4XZ0nV/+VKtqLJYzYFicvs10MukYpj8FAZqO6Z/1SIP75h4Mv+6/cxtpYdHM2bY3lPckrsbIPJyJ5hlmf6IVGUOACJ0vVWmV42jRIeXGhJr2J2ha93y6k03T7Be2UYnDFtY8OWUdgE/ADC+YydyFa4VIcOnV3uMsd2Xw0oIienlRhwt6GSo4R2GTCfTNKxa1VlmNwRXDiqPF+sZaKAqjr33ETy0kNFVvW2sC9iggYo5dtkUDe9BYwLtS/QCSEQm7nkLnf9+kMdl/I5DvZcjm176b+n79KnC1IF0JujM5/UgbiCLOi9nZml8VYekMBrvScQoXwKC8yYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9bSzBV+6qVGYedjr8gyBhkL2atpnxL+7akac2z9x+E=;
 b=VmTf+qqSex3o6f8VnRrqAd+gslLLeMSNAQa6awOqcNvMYCxpL+3ITjNHByZqL6o8ZsrEZrVU9a5hdKTBqcXmSKFDTrWTsCs2QtJtVvq/HmpP3NY4rImv5q+8qe+2sy4Tm2NIKtCgxJAsm+BliwKoC9Uk58lddg8kHdLnmuTGcF9MSXVFzMfGgc1LNSm9c2UcG2obzkGI2UVt0hjdGOb5C9gk9EPu0SXuvVDMS56TWGNAnkLmvgz8v2Y9eUal888LHsVNafQsLUBEaiYLVtZqFMOE2p9o48k8cBLiOUhRB/+3W1c/iyuxiBaVDtftq+jXgt7F9g5sVGCaTCavG4IlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9bSzBV+6qVGYedjr8gyBhkL2atpnxL+7akac2z9x+E=;
 b=pVYAflRD4+6zqb2Ova/bn6OcN1w6EGji7bBLJr0waJlCeC1zpTNvdh5jgRuxSMWARR3MuxBzHAIYNZaQuHXS3oplYtukwsLLQdIbejYtFPuZAuByi+h12WAFyp/J80HdhWjYnFm7h7fBXgRuFFryBaHvczRoHYi31XbJyaWyRXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 18:09:32 +0000
Received: from PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f]) by PH0PR12MB7093.namprd12.prod.outlook.com
 ([fe80::ebda:ae6f:3e32:2f7f%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 18:09:32 +0000
Message-ID: <d8217a1a-4aba-4e26-9b87-2fd9b6bf92f2@amd.com>
Date: Fri, 14 Feb 2025 12:09:30 -0600
User-Agent: Mozilla Thunderbird
From: Pratik Rajesh Sampat <prsampat@amd.com>
Subject: Re: [PATCH v6 4/9] KVM: selftests: Add VMGEXIT helper
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250203223205.36121-1-prsampat@amd.com>
 <20250203223205.36121-5-prsampat@amd.com> <Z6wAclXklofHtY__@google.com>
Content-Language: en-US
In-Reply-To: <Z6wAclXklofHtY__@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0168.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::23) To PH0PR12MB7093.namprd12.prod.outlook.com
 (2603:10b6:510:21d::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7093:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 67570ead-7c24-4d16-5b28-08dd4d22bb07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFNzL1JCNDY2U3o3dWZJUENINVVPVE84L2s3UGVrSnlWNFRMaDFVMTFCU1Nx?=
 =?utf-8?B?bW51dXAxRVNDRWxkYU1WM1JaWXIzZXNTaE5Fc21JNFkySXNRRXRxbm1QejFT?=
 =?utf-8?B?cW5HZ0FodkJ4V0FYdmVqNHQ0NmhLUFdLV1M3TXFOU3EvRTJCdURjU3BhSTdO?=
 =?utf-8?B?SFF2M05ZT1ZnSHA5R1d4YVNsZ0o4Q2RuQmlQcDFrZlJ5cmp6ai9uNmIzdVNl?=
 =?utf-8?B?Nkp2YkdxZnlyQ0hRWHJmUzZxS3pYMWxaT3g3ZGtPMHAwaHRWMHc1ZGlPcDV2?=
 =?utf-8?B?TEJ2aFFVZEo5T3ZYZkFyR05odEFJeWtJb2thdzZDL1k0UUhMclpwdDUxQkdF?=
 =?utf-8?B?QUtmYUdwL2lZMjRLY3dXTlNxdnk4QXM4MkhnUHFGbXJQRjFVRE9VUm5IVDIx?=
 =?utf-8?B?Yk8xQWFCN0w2ZUduK0ZmVzdCdk5RcDU1WllHSUtNa0JpRGNJN2RoSDVRQmMw?=
 =?utf-8?B?aXdOcW1FWHhsanFVQnJpemtKcmg2TG5XYjBJYTZWdjh4YTBoZkxWeHQ3M0t4?=
 =?utf-8?B?ekNxTlVaNzR3T2w3cGl6MXQ1RzN3QXYrYWNPN2dxZWExNGY4dHBCbWx1cjdw?=
 =?utf-8?B?VkxDVE5ZS29ESlFtRHhSVGlQck1EVUM0MVFCQlZ1RFdzTzdGSzRKQVdpaFNx?=
 =?utf-8?B?UTRubWxvTnlHS3RhL3A5bFpsalFkczBrNlQxWEdEWVNDOTJYcEc2M1ozeFZE?=
 =?utf-8?B?Q25tR2hMN05HUkh6QzVNeGVBamo5MDVSZXNtK1hLbGEwRlJjVHU0Mjg4OWNt?=
 =?utf-8?B?MzdiL3Zka1ZjWnhPdWlJaDlZZzFBOExLRGY0US85ZlJyNENHb3pqZWwrdnZN?=
 =?utf-8?B?M1NSK05Cczg3amMzUVg1MzdVbHpBTkhvN1l4UFZmT1UzVVh5YTNta1hTdngx?=
 =?utf-8?B?Ty90dkdmUlpTeElqTHlITkRDL1hxNG5XL0NPaUlYbDREbmVUMW12emwwKzVX?=
 =?utf-8?B?V29UVTZMQUt2TWp0aFNTVFJhQTZqYXphUEpPclBrMlFXN0g3SUlJZ1hoSnF5?=
 =?utf-8?B?bG9xWm5LaW5hQ1F6ajIrR3BKSG5ldDBuQWFNNVRDNjEvYUVwYU9WTkRFZHdi?=
 =?utf-8?B?eDlDUzRCQ1FIRFY2WmlEM3k1VithYUZabDdQeUFOS1J2anhuaGU0R1FOaHNn?=
 =?utf-8?B?dFMza2FYanA0bUdlRWN1ZmNqZ0RyeGJUdmRuclFqS1psVDFya21FUWFobHVN?=
 =?utf-8?B?UUNqOUtpazFhZ3lJeC92WGdPNUk2SmUvcHF6UkhzM0grVmE0cnVlQ213YXMy?=
 =?utf-8?B?aE0rV0dkai9ST2Z6aXNSNHdmMndnbjJBNFhXUmx1UDNuVFZYWjUyQS9GUjNj?=
 =?utf-8?B?NVAzRHNiMXF5OTVkMlhrcGxqa3FzSDhzY3h3Y3c0QnR0T2t5eXk0RldjMGZa?=
 =?utf-8?B?YXl0WVBMSFB5MnNjZHgwTUpaMkFvUW1LamFuU09KN0ZzNTk0Y2JTNEcxUEF1?=
 =?utf-8?B?ZEhNb1FGckpWTzBRU1c3aCtVWk50VWZaczlFMFVjdVBscEZ5SFhvckZlcUJG?=
 =?utf-8?B?T0E3blBCSjNJMDJYUmJGcnhlY0NoSkxacUg2Smo5eklSSWtmdnVzSFNPSytG?=
 =?utf-8?B?M2UzS0thUkJnNVV0cVVMS0FKNnlpdFV3WG9GMWJVcTVSdVcrQlJFZWd5RzlL?=
 =?utf-8?B?ZkkwUU1ZakdCY0hERHNKWm53bVhFT3QyMVBHZkk3WlQ0Zlg0QUs2dS9MRzAx?=
 =?utf-8?B?ZVRhd0pTOHZ2dFJCK1FFaThPTzB6bXJwbk9saEtxSE1zNnJCaEo1Ymg3TEhZ?=
 =?utf-8?B?aVIwNVo1Y0hINC8vSXVsNGVPQ09GT0graVAzT1hWS1VkRDFEb1hISEF0LzE0?=
 =?utf-8?B?a2FWOUJ1TVMrbi9FZ0k5UWhmOUVEalg1WHJqQVdVbmI4VC9kQ1prQXhscWpD?=
 =?utf-8?Q?OQmbRC7CtG+BZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7093.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU1NcGFQVXdGR09FWkw4NzJxL2FhcjVYSGJJc1VFekxwT2I2dzFkZ2hPc0J1?=
 =?utf-8?B?T3J3emxUSVdYUzlHWmlNcVo0a1ozUGNUNkt2anI4b0kvYkVnNURHY0w3WTkz?=
 =?utf-8?B?OHpEZVlHUnBnYmd6SllOTjgzb21Ia0lPVWZIOHhHNmhpVUZiV3NDYURQMHlV?=
 =?utf-8?B?bUlKSFVKRGlTR2xqVklFRFVYOG12akxZeU9JR2R4RTN1dlBLTzRma2RFRUw5?=
 =?utf-8?B?dVgwRVl0SmttU2QzOXhISW5jQWFJRElkMHo4ZmV2QlNob2dkUURxYzNoVGhk?=
 =?utf-8?B?K3lJQTh0eElwY2J1UVFnVXBPclRRNHlxaGx6VG9rNXNGUFpXMnNzeFZNczlD?=
 =?utf-8?B?TmtXYklnUHhLT0x0c2RFSXlWMnhUQmpQS0Z2bFRLcjBUME9zUTJ5VWVYb0N4?=
 =?utf-8?B?eEprTytPcDl5WDNqQzJycTBVcVNtVkJUZ1BkNnBNb3FQZjBtZm1wL24rNGhX?=
 =?utf-8?B?a3RrZkVJanZrMGx3MDIzcWdSSDB6YXk2cDc5N2xLNG9kNk1aK2RWRmRsMUlW?=
 =?utf-8?B?ZGpXMFJDUlZHdGF2TThCMW96d25NSE1wbXI2ZUluNHdjbUFUMzVFV0QvU05o?=
 =?utf-8?B?MTZUbVorRXkyVzVlMGFKUEFhWFhsMDFMVEpVTHlkL3BpWm1pMkowbXJCUW54?=
 =?utf-8?B?RHFhZjBDT2ZxOTdmTEpBQWRFT3Bub29CSVM5OFZYTG5WRDV0ZGsvcHorZStp?=
 =?utf-8?B?RXRrbzRWMVFybDNiYngrckNLRHJUeVQvbGpGcXZuWUU5dG1JeDZZOWVnQ1By?=
 =?utf-8?B?NTJLYmJqSTNyVDNDZVFTMExsM2tFV21hZ3QyUjZUQWdIdUFXK0cxb28xUlpD?=
 =?utf-8?B?NTBaVTVFcmlVQ3BuanJQSmdOd0NhMTM4ZThXM3VacDNWY3J3V2x4Z3M2SFZp?=
 =?utf-8?B?cW5qRFluYU9kSUVYWHo5RGN1NVNrVXJCaVgwRzh4UTJpVmdGbkdBNGRiWFdI?=
 =?utf-8?B?c0YxZEJIQWVqYThkeVQvM0hMUERHSFpZZ3JYREFkZDh3allmdHVjbmR1U1Z3?=
 =?utf-8?B?YzFpWUplOG1CWHowd0c0YW5JZGJ1M3QwWDlqdnpta0RuYldPblR2NUtFUWpv?=
 =?utf-8?B?THRVaVhtTVBWZUNsSzRTN2ZOZjJzM0pXZTZHVGJBRDBaRU1lNVdEckkyVWwz?=
 =?utf-8?B?TGFiMWs5WGZ6TlNrbW40Vm9idHhBdHRPVzRnWUZ0djcyYkw0eDhQUU5sT29j?=
 =?utf-8?B?TFhLaTVXMWtsdWlqdDlEbHVFMXBuMkRsVVJxdXZibmdHRGlSanJOYlRnRW5I?=
 =?utf-8?B?ZGlCcWJHSzlnNzlXK29DbS9rdk83eDZZRWZPUlhNdVc0L05BT09Xb3R4SDFa?=
 =?utf-8?B?QnpxRjZ4bDhHSWdyWUFYUHI2TkZGWmw4TFcyY29MSXEzTzdwaWlZUmhaanlo?=
 =?utf-8?B?SVdXRVFtK3Y3ekhSTmFjU21KOEVQYmNDU3JGclBJcExXVU1iVlVJUW9LbFRx?=
 =?utf-8?B?ZmJGZkhYeGpRN1poYXJHK2g5NVp4emQ2T295SmdJbzZFWElEZmJZN1YyL3By?=
 =?utf-8?B?V0FsU1ExUDJqdHYyelBVQXRaQmo3dXE5YkxKTFFMMnJmYzNMWlRucUNydVVK?=
 =?utf-8?B?dHkzQ1ZUc0xWRndyZ2pOdTRQZ2x4SitZOEdYMTM0dFRpQWUraXl4Qm1RcTRO?=
 =?utf-8?B?cmdCQlFwTlFiUmlTV0JkK3NpS2tIcmxmOGZnYmJyU0ZkL0VZeXo5QVBsU3hI?=
 =?utf-8?B?aktPdGNSR0p4MHc2emdxUlZKM2FKbk9WQ3cycndMa1JMQkxoVXJ6cHZnVnJ3?=
 =?utf-8?B?bHFMU2hEVWphck1MTlpXVCtEYXE0Z1ZBZCtudHhETEFFVGNnNzdNUmNOY1Fr?=
 =?utf-8?B?RkJYMElUN2dwQW9xQkZlbksvQzVxK3pwR2FicjBCYlpmdjhWM0pCcEZxV0Nq?=
 =?utf-8?B?UWQzWldFOWFLK0FXdXVPSER5aFQ4UDQ5ZFJ1ZURXZ0JtR1hRcWpidXMvTFBU?=
 =?utf-8?B?ZE5jMmNRUHZ0NnQ3RFF4cXpuTE9jRzl5RGw1UklpT25xY3gwak1LZ1pRYU51?=
 =?utf-8?B?QkNYakl2UUtjT3F1ZVlDdFpoRVBuOWFBdElyd3FXOHEvWU5pakpndGtKbFZS?=
 =?utf-8?B?VUZtU2ZITm1TZHVMMXZQcU5yZlB1dWdhc1dIOTVnOXUwaE9jMkZIVTNwdllS?=
 =?utf-8?Q?nzetDrTMyMvHJqfsrryD0+Atp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67570ead-7c24-4d16-5b28-08dd4d22bb07
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7093.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:09:32.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3KOBJVIvU13eEmr+5N6FEDN2+SDVWzPLIWTZ9jPV4qlMv7J5DHXa5itNAEgds/qsTojNFf+9236Y+kcWFtHLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802

On 2/11/25 7:59 PM, Sean Christopherson wrote:
> On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
>> Abstract rep vmmcall coded into the VMGEXIT helper for the sev
>> library.
>>
>> No functional change intended.
>>
>> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
>> Tested-by: Srikanth Aithal <sraithal@amd.com>
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>> ---
>> v5..v6:
>>
>> * Collected tags from Pankaj and Srikanth.
>> ---
>>  tools/testing/selftests/kvm/include/x86/sev.h    | 2 ++
>>  tools/testing/selftests/kvm/x86/sev_smoke_test.c | 2 +-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
>> index 82c11c81a956..e7df5d0987f6 100644
>> --- a/tools/testing/selftests/kvm/include/x86/sev.h
>> +++ b/tools/testing/selftests/kvm/include/x86/sev.h
>> @@ -27,6 +27,8 @@ enum sev_guest_state {
>>  
>>  #define GHCB_MSR_TERM_REQ	0x100
>>  
>> +#define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
> 
> Please make this a proper inline function, there's no reason to use a macro.

Sure, I can make this an inline function.

