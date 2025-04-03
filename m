Return-Path: <linux-kselftest+bounces-30079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2301A7A98A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 20:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92FC3A55DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8209F253334;
	Thu,  3 Apr 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="05EG+6AX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0472528F9;
	Thu,  3 Apr 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705353; cv=fail; b=RnGmLCDR6FrJx02EPSCN4wh1eY29JPig6cNN1jzvPB1Wmpccez1bSdbjMucucWEc7vnVEwZI/3zA+DHx7zPNp70EnbnDJvsGrrBxuowPwkI0ri/R3gtodSScpKlDvus+7wTlFsqpxpK8ECaMjZIxf3gBAC053/BXj+UYX6p1OHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705353; c=relaxed/simple;
	bh=VkSPRfyh3whShKxnvrSJG/p+LPnBrwcBkHRnv0/1eRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=elHOyWOkawp97T7axxmfmKs10hhonVDmb3IkQizuFI9TQouqWOoapOcm7eJjJX63Y1Wo0v2y3xZn44P3lGGJJIYEVlVPzZXEAmR/y5biSuQEitYi99fOWTCppo/+SSe53qPlAwk6PVj9gtY2ihnDmG3xwfyGQqxRJSEChbWphfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=05EG+6AX; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FacAVpK1b/BD0ci2AArup90QqeUTF5J+Wed4gSvcw0e8SVysd5F8OY+nzRwy8t2MwUgafs4i1sSlJzGV8iPATUeanQIa0GH7++czMeBvC4liOJwHxubaESbWVvm089CJZ6fBSUjqzQakkrQE1vSr+SNewvEtlbxK4mogV3GpZWgY31V2X1vqvlwEpumHyZznyo5Jxymu2xIO9geM45CUf28VSOS5eg7jv1a5L/Jxqo9DXepQE91olnV12CObd74I0+JaBNqxr/Q6CK10hFaJOEybpPUcTqWR8KgCEnN+70wPURx3UwmKyZoMG7DvZaxyfG08L5FkWRk4i63IEfSs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLtg1WMpwwMozs54nCdZRfAW0MctDwEi1jvEceT/Efw=;
 b=EbZE6ryipmVS2nIpEnCJ/IPCYf99WWxLQ+plFOomCzUq1PqBflQi5NbF07xvHx0EyQTnLBILXxMbmB4HYNM62z4npSRdSy9wThrMvHwKGYl2BoY6AkVRZjF25Baf/7RsKcIfQh7Oj3D9IPCIGZGjMXTvM2mWjMSVOC6QEhC59Y6EN8HFHGZbfqslY+FjexSTb9afEWf7p01lv+AAzZsUacwwDtpeNuLfu5LKvkIRI+OxhAp465YdyIvbTU+3nMTDDLgfPSJ5cCduocEP5LvM54zfMr702SCpuuWCL4HDyVNrLXgh65bwD9oOlbTKbNkdT9QcuMAK+M9gJ3Wxa+nJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLtg1WMpwwMozs54nCdZRfAW0MctDwEi1jvEceT/Efw=;
 b=05EG+6AXLE/ZXMEnCOkExIc7csIl9HeMdGs+9NV0SDg4DOHj6AzwPpYf6hCbEbCzkkBbOt4LyZDTYF2K2JlclXgp/03QT6tmp41Z2jkSE5gJvT4pEZnL7YycdMySrEwLbxiRkTnSd/aGwG0It1W+lDWSNTRE9wDSWeioHz4J5gk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Thu, 3 Apr
 2025 18:35:50 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 18:35:49 +0000
Message-ID: <d61bac99-a0d9-459a-994d-20a5cfa6dd52@amd.com>
Date: Thu, 3 Apr 2025 13:35:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Basic SEV-SNP Selftests
To: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com,
 ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com,
 michael.roth@amd.com, sraithal@amd.com
References: <20250305230000.231025-1-prsampat@amd.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <20250305230000.231025-1-prsampat@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0149.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::26) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: f8652e9d-8e16-46d8-806b-08dd72de5b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVB6TW12UmJkclhlWjkrZzBLWUttTHBQVHBRb0kxazcrYjd6b2RwcjlGZ01J?=
 =?utf-8?B?VVRWanZRdGlSNlRYY1JtZ3czME1FNFlpMUVpYVc3d1UrR3FmMjhXWE5IZ2Fh?=
 =?utf-8?B?T2VMbi9rT1JzTEU1MFlDQ0tGNmtTRlBYRVd5bW1yVGNMT09jRWhoVC9xQXdP?=
 =?utf-8?B?TnNpSGRvU0FVR1hOL1I1cUdBSDkxbEwxUTJEUjQ4STYxRjRCcm85SzRRM3Jx?=
 =?utf-8?B?L3hqSzkrNWRnTDN6U1gxdGhTeXZYbjUzNmVDYlBlNEQ0bWw1ZjcxMjc0djFs?=
 =?utf-8?B?V0FKakdwNXBoYXM1clNzMWNIUldZRjZiNnBwZCtSYjREV0I3ZGx2emhtdERW?=
 =?utf-8?B?RFBsSmpLRFNrUTJ1aHhkZWlhVnVmdDZxanlEelU3YStzVFkySzI2Q3dqYmE1?=
 =?utf-8?B?UC9Dcm80ZEhHVTNxa0FKS2dJM2tybXRnQzZFcDlhY0M5QkhybDcwTWxUWTkx?=
 =?utf-8?B?cGY5aXJFcXVlaVhZZ3ZSTXpnZmk5WlZXWGhRWUpPWDhKUmRmYWE4U0RyaTNv?=
 =?utf-8?B?R3ZFYUdCL0Q2MmR3M015bld6bGJpR2doOEpEL1hXdmNESTJHOUkyYUMrMGVl?=
 =?utf-8?B?OU1nRDVrSzJLQUJsYmw4Mlk4NmNoRWprNmNEYkx1ZGI2aFdFakJnanYvNFFQ?=
 =?utf-8?B?UlFqT2ZUOXlFeVd6cFNoaEdkNTN2bUdzM3pWdGZZREk2aHVFb3o0dVB0Vlpl?=
 =?utf-8?B?bHhlM0Y0K0VsVGRMQzdDelRyY0E5RUE2Q3BtV2lsWlR3UWNudm00eWFEZm5X?=
 =?utf-8?B?ckdrLy85RWZFbHhYRExQdTRRVmpZNUhJOFpOQmxJT2lFNTFvZVJCL1hMdWxL?=
 =?utf-8?B?bXBLVkpDS2R1ZVZaVk1uRTdaWDlpTldlaHF0U1c1a2QrQnBjdVMxdVRRU05N?=
 =?utf-8?B?ZjUzSDlMNkpwbmdBOUlmN3hMMk95bVorK1MzVHdoQkQ5bFlmTTJzaTNvVHRC?=
 =?utf-8?B?b2VzNjhXV2hTUVVnRkFiTndSYzVQR3lHcnMxSmJBWmh2a3UyR0Y3VXdlWEV3?=
 =?utf-8?B?QkZZTUNIRS9iL1hSb3Exc0tXNTJGN2dNWW5jTXp1clB1SVpxK2NZRTVhelFG?=
 =?utf-8?B?SE1ZN2xoUkpyRVNFc1JGUzNVdHNqL1YzZ1VmeEVCTy9sZ1BHMFJDSU52WU1L?=
 =?utf-8?B?SGJTOEJUcFovWmVIQXBzNHJWOUI0c1o5S0pLT2xSdDN3NGdHZUZEUG5iNHgz?=
 =?utf-8?B?OFJQajlYclZ2ZjhBOWIrZnByWENIdjhGVHNEYjJGU2p1Y1Y4MDdwMUR6K0lE?=
 =?utf-8?B?emNJZmgrQmVjZEtHM3pkNEhWM25lano3U1VGV2daTGFYUVMyb05Pb2ErQ3Rz?=
 =?utf-8?B?WWFkQzl1RGdrUjdBRUpMRjFTbG5PVzRldmpqdDNPQ2VLWnBSVVhqSHdGVHEx?=
 =?utf-8?B?Tk5JNmQ2N3Q2ZHhHWm1vdzVBWGNVZUxrYVdZenh2Q3c4RDFaTUg1cTlKZ1Av?=
 =?utf-8?B?SzZDRVZBZ0FmM1FWdXZsQkI2ZldoTC92WWIrb1BaV1lVUkNVSkFnWGZGaUMz?=
 =?utf-8?B?WTYxRlhKWFRpamRQcVZBS05QVEZWeG1jNWkyek0yQlR3b0d2TnY4RmNDM3Bu?=
 =?utf-8?B?VlhoUG9XRUtzdFhOQzZmTHI2S2tTK2pxcXYvd0hrSm9nTVRXN2xRbE9lMWxU?=
 =?utf-8?B?R2p6K1BYMmRyRjBJUnZNMU5hSkJFYzQxNmZrR0hWNnovSWJjWUtwVklUZFF5?=
 =?utf-8?B?V1JtRWZwQzN1ZTI2RnZ3M3NrYVhScnppOFFtL05LOWhpczQ0R0Q0NVhUZE5a?=
 =?utf-8?B?U3hIcTkrWGE4cE5rQkUxMW5jSmxzNStIc1JwalZLSGRmN2ZqOWtYV1dMSmEy?=
 =?utf-8?B?bnQzeFdQbllPYk1wc1lkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUlTSUltTk11QVdkbHlrZStMMlIrV0RCSkJIU00yRC93MEpSMk02UnE2VXBt?=
 =?utf-8?B?blR4dDJYM3dqRFBaL3kzRXJUd1F1REZHYUNUMlpERWpwdVVjM3l2Nmo4Rkto?=
 =?utf-8?B?am1YY0NNSEQ3ZjhwZFMyTjNJbGs0R2lKQlUzNEFiT0tmTUYxV3ZiS0dpN3NU?=
 =?utf-8?B?K09UQkVyV2haeG9LdGoyb2lhc05LK0luRk5uOTQvZGFpYVhpc01xY3hHc1M4?=
 =?utf-8?B?b29kNk9OejgzSFdSTngzcGFESEFVSDZuYW15OU0zMGRRU3lrS1JGZTM0RTNK?=
 =?utf-8?B?V0dEWm1PN0hOQndXV0NjWEw2OXRKSG11a3RwVXd0T0doZlJoTGNmSHhEOUJK?=
 =?utf-8?B?ZzM4YnlhVGZabi9wU042SlBpc2RvdnlhWm5lTHBkV0JCdTVsNU9LZVpBb3Z6?=
 =?utf-8?B?UGxTcXFEMjFhUGZ6ZmRqaklmNXdjNzZhS1padlFRREozaUxYZWprS2Nnei94?=
 =?utf-8?B?TFF0WFh5bXYwVHBEUSs5Q2J1TEZQa3UybnhEZ0J2bk9COVZPL1Q0MkdOMHVB?=
 =?utf-8?B?Ym9qSHdLb0FtM0Y3TGY5TUhNdVFqWjhpcUZPR1N1UkxiRDRNbm9DSmFiVWln?=
 =?utf-8?B?S0xYRWJlSVpwTjZlMTdJM2E3T3diSWNpQXdSeW9xUDZYcXVlMC9idkp0N09k?=
 =?utf-8?B?aVE2RW1hNG80N0E3SmpaT2YvQlo0NG9xb3pPcHUyL2s3RGt6WUdJbC9pVUJx?=
 =?utf-8?B?Q0RndlV0TEI4eDY1TXNIdkMxc1ZrUm1rVXRuRitmeE5JWlpxb215TXN6V0pS?=
 =?utf-8?B?SWhUWURXUnZuRUFzL0s3YzNybjJ0RTNXdHJ4ekxuWEYzalkwbFM0T2hRaWNH?=
 =?utf-8?B?UDd6amdpd3c3UW5QM2ZmOW5LN3pSS25qSnJpUXJFZ3ZpQm5jWm9WM1VPYi9O?=
 =?utf-8?B?QUxQOWlTRHdPU0hGNEhMT0M0VGR1OCtkSTJQR0tUci9VdXBMSFNDaXQ1UEJQ?=
 =?utf-8?B?TlJYTlMwakJoL3UyK2JyVHRvYkdKaWtIQVJpNktoRXk3Qm1NWEo0eHpORGJB?=
 =?utf-8?B?QUFNazNzNy9XdEs2blU2M2ZHZmU4a3BaaU84RjhmUjJBUURxQkJIbFpKL3Ez?=
 =?utf-8?B?WlBSWDFpTEREbkNuRE1OaHlUR2RkSW9ib0xvaFNVd20yYUZveHRLSjlmeWdn?=
 =?utf-8?B?SldzSWRQYjJLSDJzcjFDRWtjU0NyVHBrcXRNa1RTbEhHUWZLMzlMdU82Vk1u?=
 =?utf-8?B?azJhUGVpNXFmUjhFb0s0dHROWklJVFFyTERmOXdmRDUycWJlUHV6bmF4Ui9K?=
 =?utf-8?B?ODJaZ3B1eUNEaDM1TUVQWEZHUHdnKzFIMFpGeUtVSysyejRMVVkvVFNDeTh6?=
 =?utf-8?B?YWRHVmI1Nk5GcFllZGtXK3ZFZGtGdVJBbHFGMnZlZW0wRzNRQ0RKL3hWa2Nl?=
 =?utf-8?B?dFYxKzVtSWhzN2U3STF3d3p6c0JRd1ByczJiajZET3h3ckFXUEhIQ3dzdy9D?=
 =?utf-8?B?Wi9DL2tJWFRCNzU4QWFTZ2lkckZ4dVhWbENBU2hwLzdCa2wvY1ZBUW91Z29P?=
 =?utf-8?B?T3BHOEZBdjVDN2tWRUJHVXdDWU1FbHRrbHY3RjJ1RXFUMHY2UTJoSTl2STNP?=
 =?utf-8?B?ZkE0TE1wbHFmNkFhbHZFeVg1VWJGSUZ3ZE15RkJyay9kZWVmL2l2NnBMQk9V?=
 =?utf-8?B?OXNHRGp1NmR4bDdmTW0xclNIa29oMWNGZnJIVmIvSjcvZTlod2F1WG8vb1FH?=
 =?utf-8?B?YzN1akRkRnp2WTI4Nzc2WHlNcHVyemxleEhxR1h6MUdZMFFWa0dvQ0dKb3Fk?=
 =?utf-8?B?emREcXZ2eWRlVkRzQnkzQytCRVJDeThUT0t2SEs0NU9NTXRmYkJEVFM3SHNp?=
 =?utf-8?B?VnZpTkhPbTk1b0dBTHJIdzdaaUtxLzZCYkQ4WDhid2cwQ1ozUk82Tkhjdzlj?=
 =?utf-8?B?bVNTdXhUdW5GaU84dzA4Sm04RDlTZHd0V0FUZ1B5S1NGdEhmS0xPZG85UDQy?=
 =?utf-8?B?VTVoZEZPTjB5Y3MxdFFLckpuRWhYdjhjcmtjYTQ1dlgzdGlaTlpXSmhIRDJX?=
 =?utf-8?B?MGNSWjQ3NHpIU2dJYVFDS2VnanV4NFJPQUMxbUpoOWt0Nlo3aDg5ckdwcXZn?=
 =?utf-8?B?V2xKM1BTOHNDb0RYSXRUUWc0UkM2eW41TDBtNi82QlZuQzNvKyt4VTFZemYw?=
 =?utf-8?Q?yhbZ1HYaSUeUE9wDvwC84gwrh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8652e9d-8e16-46d8-806b-08dd72de5b31
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:35:49.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwHLxGGKpZpD+71vCwl9UtcyTPg1E9G1BT7uNouks3qZEX/stWSf1FsqgoIKMhphyQBy+Xm5VGBCpOjCSH1SHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033

A very gentle ping on this series.

Thanks
Pratik

On 3/5/25 4:59 PM, Pratik R. Sampat wrote:
> This patch series extends the sev_init2 and the sev_smoke test to
> exercise the SEV-SNP VM launch workflow.
>
> Primarily, it introduces the architectural defines, its support in the
> SEV library and extends the tests to interact with the SEV-SNP ioctl()
> wrappers.
>
> Patch 1  - Do not advertise SNP on initialization failure
> Patch 2  - SNP test for KVM_SEV_INIT2
> Patch 3  - Add vmgexit helper
> Patch 4  - Add SMT control interface helper
> Patch 5  - Replace assert() with TEST_ASSERT_EQ()
> Patch 6  - Introduce SEV+ VM type check
> Patch 7  - SNP iotcl() plumbing for the SEV library
> Patch 8  - Force set GUEST_MEMFD for SNP
> Patch 9  - Cleanups of smoke test - Decouple policy from type
> Patch 10 - SNP smoke test
>
> The series is based on
>          git.kernel.org/pub/scm/virt/kvm/kvm.git next
>
> v7..v8:
> * Dropped exporting the SNP initialized API from ccp to KVM. Instead
>    call SNP_PLATFORM_STATUS within KVM to query the initialization. (Tom)
>    
>    While it may be cheaper to query sev->snp_initialized from ccp, making
>    the SNP platform call within KVM does away with any dependencies.
>
> v6..v7:
> https://lore.kernel.org/kvm/20250221210200.244405-7-prsampat@amd.com/
> Based on comments from Sean -
> * Replaced FW check with sev->snp_initialized
> * Dropped the patch which removes SEV+ KVM advertisement if INIT fails.
>    This should be now be resolved by the combination of the patches [1,2]
>    from Ashish.
> * Change vmgexit to an inline function
> * Export SMT control parsing interface to kvm_util
>    Note: hyperv_cpuid KST only compile tested
> * Replace assert() with TEST_ASSERT_EQ() within SEV library
> * Define KVM_SEV_PAGE_TYPE_INVALID for SEV call of encrypt_region()
> * Parameterize encrypt_region() to include privatize_region()
> * Deduplication of sev test calls between SEV,SEV-ES and SNP
> * Removed FW version tests for SNP
> * Included testing of SNP_POLICY_DBG
> * Dropped most tags from patches that have been changed or indirectly
>    affected
>
> [1] https://lore.kernel.org/all/d6d08c6b-9602-4f3d-92c2-8db6d50a1b92@amd.com
> [2] https://lore.kernel.org/all/f78ddb64087df27e7bcb1ae0ab53f55aa0804fab.1739226950.git.ashish.kalra@amd.com
>
> v5..v6:
> https://lore.kernel.org/kvm/ab433246-e97c-495b-ab67-b0cb1721fb99@amd.com/
> * Rename is_sev_platform_init to sev_fw_initialized (Nikunj)
> * Rename KVM CPU feature X86_FEATURE_SNP to X86_FEATURE_SEV_SNP (Nikunj)
> * Collected Tags from Nikunj, Pankaj, Srikanth.
>
> v4..v5:
> https://lore.kernel.org/kvm/8e7d8172-879e-4a28-8438-343b1c386ec9@amd.com/
> * Introduced a check to disable advertising support for SEV, SEV-ES
>    and SNP when platform initialization fails (Nikunj)
> * Remove the redundant SNP check within is_sev_vm() (Nikunj)
> * Cleanup of the encrypt_region flow for better readability (Nikunj)
> * Refactor paths to use the canonical $(ARCH) to rebase for kvm/next
>
> v3..v4:
> https://lore.kernel.org/kvm/20241114234104.128532-1-pratikrajesh.sampat@amd.com/
> * Remove SNP FW API version check in the test and ensure the KVM
>    capability advertises the presence of the feature. Retain the minimum
>    version definitions to exercise these API versions in the smoke test
> * Retained only the SNP smoke test and SNP_INIT2 test
> * The SNP architectural defined merged with SNP_INIT2 test patch
> * SNP shutdown merged with SNP smoke test patch
> * Add SEV VM type check to abstract comparisons and reduce clutter
> * Define a SNP default policy which sets bits based on the presence of
>    SMT
> * Decouple privatization and encryption for it to be SNP agnostic
> * Assert for only positive tests using vm_ioctl()
> * Dropped tested-by tags
>
> In summary - based on comments from Sean, I have primarily reduced the
> scope of this patch series to focus on breaking down the SNP smoke test
> patch (v3 - patch2) to first introduce SEV-SNP support and use this
> interface to extend the sev_init2 and the sev_smoke test.
>
> The rest of the v3 patchset that introduces ioctl, pre fault, fallocate
> and negative tests, will be re-worked and re-introduced subsequently in
> future patch series post addressing the issues discussed.
>
> v2..v3:
> https://lore.kernel.org/kvm/20240905124107.6954-1-pratikrajesh.sampat@amd.com/
> * Remove the assignments for the prefault and fallocate test type
>    enums.
> * Fix error message for sev launch measure and finish.
> * Collect tested-by tags [Peter, Srikanth]
>
> Pratik R. Sampat (10):
>    KVM: SEV: Disable SEV-SNP support on initialization failure
>    KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
>    KVM: selftests: Add vmgexit helper
>    KVM: selftests: Add SMT control state helper
>    KVM: selftests: Replace assert() with TEST_ASSERT_EQ()
>    KVM: selftests: Introduce SEV VM type check
>    KVM: selftests: Add library support for interacting with SNP
>    KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
>    KVM: selftests: Abstractions for SEV to decouple policy from type
>    KVM: selftests: Add a basic SEV-SNP smoke test
>
>   arch/x86/include/uapi/asm/kvm.h               |  1 +
>   arch/x86/kvm/svm/sev.c                        | 30 +++++-
>   tools/arch/x86/include/uapi/asm/kvm.h         |  1 +
>   .../testing/selftests/kvm/include/kvm_util.h  | 35 +++++++
>   .../selftests/kvm/include/x86/processor.h     |  1 +
>   tools/testing/selftests/kvm/include/x86/sev.h | 42 ++++++++-
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
>   .../testing/selftests/kvm/lib/x86/processor.c |  4 +-
>   tools/testing/selftests/kvm/lib/x86/sev.c     | 93 +++++++++++++++++--
>   .../testing/selftests/kvm/x86/hyperv_cpuid.c  | 19 ----
>   .../selftests/kvm/x86/sev_init2_tests.c       | 13 +++
>   .../selftests/kvm/x86/sev_smoke_test.c        | 75 +++++++++------
>   12 files changed, 261 insertions(+), 60 deletions(-)
>

