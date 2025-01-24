Return-Path: <linux-kselftest+bounces-25080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B7A1B321
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 10:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D34D1635FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1897221A44F;
	Fri, 24 Jan 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N0OUxPgR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3023A0;
	Fri, 24 Jan 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712634; cv=fail; b=BZs0K8vGIi61uBgMAv84JmPIRF0BMB+3XWPYOS+qoNl+bvZ1F8G9SS2K7D2vOQZOgJD4bkAt5Ljz7Vy+YokCsMkc+1fZlwzKKl1DLJ2vRrkLo0VBDQOJMplCZOC/AnG4vjaE1Php4SMCSqcc4VDuIWC2ybzjRSlDA5K4zYtvS8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712634; c=relaxed/simple;
	bh=HX5052Y41jruVz9HPPuGtAu0e71LyvI2nvDkp0mVAV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dcxyYksYcDnBMbcjN82GCTfKNJ904CvQG7ZEb9EbJP6s0XbDTud5w6DkKGBZHO/otDXWIMS3rO6sIC66bX6/SV3d2VuRdyIZslML6FWuk1Q0oT1p5Gf4WFFdNyFXwuhOr8yZRyPjq/3x+nPmB01DbIdi2WuURaF5RiVsJCfJj7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N0OUxPgR; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ialnn1rZYb09m4q0JmEAaYa6IG7C48AoY4+icPg5OhbkYro+D3MUBPr70yTjeWBI60pGQUGDHSNWNNvsbs83c7OMJdS9gaGXgt1sUuZUpCYXuQvULBWbddcRt5OIBZ/S9eBnPdviIiRZTwTqcGQsCzksl4zWqDYkvv3WO0AIje1eRSlx4kSQHJYI6ePQvSJcIxowQChf0gnA8JszvTqUvQeYLIGXpFMonXmgXtLlwJ4rR/ySzW+8ZgE5jMHjF9cgt6RcKXtEHfu3N9SDgkceI2OUVey6pKRSM9BtZmr3trzcSLCJ6HD9klbCv4fwSdwbTAOiK11YzxaJ/nq5cZKaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9uUYQ0pdhs5ObzzN6En9Xzg70EQpJByWexK7c5g2L0=;
 b=GNB+V2twau9OUN1uBAepIXN4E82dffTSnU0wmDsHA8zVIXvjohQ+uNyg0ZY3bg0JHUnHnkrXdAqmvC5LulZRmS2EBGZHL228P/ZF1nGKM/pe+ZbCsPVCIyxSx7Z4iLkKEUFIVH8j25/hVqSInUf1hgSuW7A6jWUUaJQyFCC+Ij/v4F37c5aQ/F1tNhTWD7oXgWhEk5DZNNRbYhHn0SCZBfHiAEYg+EtIAwEkS9iJkfH+VMTUCo4gQ+Gqu8DNmiIaQLooMzZUWWRE2BEi7NYW4AXoiwqWZuJ7AV92mf7JTCSW5Jt5ScfzrWZLy4Q6cRVHrQethr3j6Cl44UZiYw6H1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9uUYQ0pdhs5ObzzN6En9Xzg70EQpJByWexK7c5g2L0=;
 b=N0OUxPgRzQlkwMrsxI3o9Y7rOpzuJOHlx1O3A5aNB6yNTIjCOnzNxsp4tdCtiU4hySY+zhqP5MrjpnIj8oBtx/3W3qmnyb8GrZw3pJTmUVNgXMFmv0DHMa6ioi+fcR2RPZn4xcMGk51rb1AWTUkEjWFh974mGiSbODCOYln4b5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 09:57:08 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%6]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 09:57:08 +0000
Message-ID: <6e7d7f4b-7a0c-436a-b6a2-5e364411ec87@amd.com>
Date: Fri, 24 Jan 2025 15:26:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] KVM: SEV: Disable SEV on platform init failure
To: "Pratik R. Sampat" <prsampat@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com,
 ashish.kalra@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250123220100.339867-1-prsampat@amd.com>
 <20250123220100.339867-3-prsampat@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20250123220100.339867-3-prsampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::27) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcce58f-45fc-434f-6de0-08dd3c5d76e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE1IZ1N5dURIKzhjeVk5STlUNVlRbzBNaGhQeFV6azFiQUVFL1hURXgvWEVi?=
 =?utf-8?B?OGdMQVVkQitHMHY4cXlTY2s0bHdEcEdwaXpiYzVLbEw0RWZiSitpYVorZUhl?=
 =?utf-8?B?ZDFJMDVVdkwyZnBwN1ZQSCtvQnFoQ2Nua1drWGlaTTBCZTRQSVhHQVZDRWdr?=
 =?utf-8?B?QUZibStnMU91YXQ1T05ZMm1HdEo4MWJoTjdOTi9PY3EwZlllYjVWNVRMQUpO?=
 =?utf-8?B?VmV3YjRDOHlsQS9MVjB6QWNiNUZZL3RXU1pubGpGV3Yya25jWFFQelN3VnYy?=
 =?utf-8?B?bnNLRXRzdVc1L2gvMXJjc0VsQkRVWmlCMlBjMS9QSDNxL2xiTkVaajlmQVdC?=
 =?utf-8?B?c3dueUJmcFpQK1ZSSCtJVGtGRHA3ZnlxOXhsOUJ5d3EyZWJaTWtOZ2FQTlNs?=
 =?utf-8?B?aUFBbzBlaDlTdzJMZzBqeGRWZ1UwcFZCZW95dlhhdTh2b0J6ek5Fd2ZlZTVk?=
 =?utf-8?B?elJkQWxySlBiY1A1WU5oSzBXS3pJL2dyUFFZNldVUmlza3FDNXpIb2xDNXBC?=
 =?utf-8?B?NGE0MnRxRnBNN0J2VTA3U0s3dytJL0pwWjA5MXZqVExTTUNHOXNtR3RpTmhL?=
 =?utf-8?B?aGw5U2ZNQzRiWVFVQytDM1cyWWw2Tks2VVJHYitMK2ZNN0x3RXBIRTFwcGJR?=
 =?utf-8?B?MHNoMUR1dVd0bW1vZ09MdEU5Y01oOHNnQlJaeFp2bXRpa1Fmeks2ZkgwSVBq?=
 =?utf-8?B?YWpYUG9FMmhYODB5ZE9uL3dtMkNIcHBjQnZqYTRZOTRkT2tDUnJCUStaZ09k?=
 =?utf-8?B?dnhyVDdVS1o3eXcyLzlLbDhXbkM4N2xjOWZkeWl5SVk2SWZHN01lN2NiWUxS?=
 =?utf-8?B?NTRjMThVdnhOWkk3RlRxeDJLdzRMb1dLdjBodEx3QW0vUENpb2lxNyszcUdE?=
 =?utf-8?B?dnRHR1l2UXptNE5ENi9nL2xPbEJ3ZTk2MXpSeHBMYnVBdER2eEVMOTZHc1dL?=
 =?utf-8?B?dU10aFNpYmxiajNpNDQ1S3BUL0pTa0dCc3duV2JUcGRDSWxDbVByODY3eW1v?=
 =?utf-8?B?NXNzbFF2ZE55dFFFRHZuT2lsSmp1WjVMVFBQa01JRzRQeW1lSm5oTU5mMzAx?=
 =?utf-8?B?blZIcExEZHhjRnVBdTRISVU3Z1Y0NnFHTjNaSExsbllvbXJZMHBsaW1VeEZi?=
 =?utf-8?B?SXRaRjZaUndlWTJZOU05RmdlUHFhR1pvVTU5cmNBajRaSG92NjRJMGRxYjZW?=
 =?utf-8?B?eXdsNTRpRnNZOGx4NkdMRGlnWkNVZVFPR0RGMU92azZ4M2VxdE9mRmdZanc2?=
 =?utf-8?B?ZnF2bE9IL1dlcEtwS3NIOEFibS9FYWhiNldLYVF3M2tJUXlGbWFoTCt6UGN3?=
 =?utf-8?B?a2dpU2tnQzhaUThUNnJLMG53OU9YNWtHc3IyVmo0N0E2SEpKZWVCQU05WXo1?=
 =?utf-8?B?TVVRWitacWpza3FFTThZV2RENmRWTEV1eStCaGQzbVdMaHZCcjhCekduNUts?=
 =?utf-8?B?QW5RaytzM0FRdUxSRGNBNG9UcVFyYjB6SmU5dFdoTFRwVFBRVTZVRFFqekJM?=
 =?utf-8?B?ZXJEQjIvazJrTTJlVjdsM2E5OWNMeDFkNnROU3NOWUc3cExybjkwYXNieXZ0?=
 =?utf-8?B?WjVibWtIZTdoMjlDQWgySHJDMzR3Y0xNN24wODlISldzQkpqdkFDNzRyZ3BP?=
 =?utf-8?B?NjlZbXI0SXlyTlVUd0wxZzBrOUptZENuMXd3TzFmNVB6TGM2eVZpN0dERVNQ?=
 =?utf-8?B?WGdsRjhxRnFPQU5sZ3d4a1B5OXdSM1FBc0Y1Rzd0TmY3Wk5wWGticm5DdVhk?=
 =?utf-8?B?ejZsdjJ0UGh0dGwyYXZCbzZHbFg3Q0JiUDk2OFRxNW1nQkE0YytXUG9EdktI?=
 =?utf-8?B?UnFBMUo5b3NDTTVkMmY1M01sTzNudHZkWDlLUW11QTdVWDN1ZGNXNFdvS0FQ?=
 =?utf-8?Q?FUBXTQHsVC26C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzY1QWpoY0thdmJ3Qy83eG9sUFRoYjg1UExUYitmM05rMmNlbHNKSDgrMVRD?=
 =?utf-8?B?ekxsWk44UkxSZnNkUU1BeVZPUTZYY0ptbjJ1Lzl2SHJBSkZkRitTeVE5SVVy?=
 =?utf-8?B?QUFSWEs3OVdrZHRXTlBYVWN1bGc3TEl4T2g3bmxxdHpoelVsVi8vQXBPckFP?=
 =?utf-8?B?dUEwcjArbVkxS2NxZUc3eVZaWGsyYTFQdjV1RzRkbm5nUHBTY3NIT3lMQks0?=
 =?utf-8?B?QjYxWXE2VkZ5TXVwa1NieWoxNk9rNllzdFVTRE5RS3UrY0VoSHFiVjA0Ynhi?=
 =?utf-8?B?VFZwbTFUQXlmTUtCTXdQM25aampxeUNOQWVYakxxcEtSN0JWelZMQ0JjeTRk?=
 =?utf-8?B?ZWdURjNvREV6VlNpV3BOMStCQmliSitIckdRWEVhQ09FV0dLYzhYbUVXdTR1?=
 =?utf-8?B?aTNKK2cySzlsWC9WYjMrOVFmS1BlVkpBVWFFbEs3SUx6bTIzN3dOcUFJSVMz?=
 =?utf-8?B?dDJxOTNJeDFLWTRxMFNpOSt2SU1lTk5qZm1aUEVDTTQyTXo4NWR3SEtHbnVG?=
 =?utf-8?B?OHdodmNsdWVzbnBCc3pnTHZFRVNlZjljQkZGL0dXR1pJY3NpWjJucnBwOEtS?=
 =?utf-8?B?L01Vd1YzQ09MZWhNU3RkeVo1eVZrRGlkWGxTV0pQSDRGbW1wOGdtR3FqZlBG?=
 =?utf-8?B?c00ySlU5amJ1OE0zNzZKaUE4NlhSV3I3ZXo3VUVNdm9Tc29YdFBYbXErOGMz?=
 =?utf-8?B?VEY2c1ByeW1SSGdJNk5lS05jdkljLzZUdlg0WEpoZFI5VzlOaHltODRpQmVn?=
 =?utf-8?B?VVM2VTlHeVhCSVdhTXVKVnZDb1dsQldIcllEZFZIOWx5Q3RUK2llTHVOSStp?=
 =?utf-8?B?ZDJaNFN0ZkhrYmg1bkh3aEpZb0RKOGdQL1ppNTNzNHkxaVJPWllvc1gwYzVH?=
 =?utf-8?B?aGt3MElpMWpjeDdtRks1d250b2txZWg4UHRCSDhKcmxGWHNKM2JZMDY3Nm84?=
 =?utf-8?B?N3c3N3FCbmh3dHB0dDN0ZVk0NmUrREhsRWUwdDFDQmxLbVdHZmhUUnBCenZF?=
 =?utf-8?B?cWdTa2NMa2JEMVlLZFNtM1d5d2l1anZhclVDcmMvNHdEQjFOckVRTFlzQU5r?=
 =?utf-8?B?UERqSk44OXFUeG5WM3IyY0YxWE1LazhCNWdwdFlzbDFIeG9lQUpaVGI5WWNR?=
 =?utf-8?B?ZTNuVUJUVEM4SE9Rck04MTNVbVN4U1dFbGNxYXgwSE54cVdtM0tiZDZZbDA1?=
 =?utf-8?B?alJjUUhwNkVyUnpYbmFseUFvSWJwNWVENG53SVcycWk0cFUwZm9HVk94STdL?=
 =?utf-8?B?MXZoeGFXZzFyRU8yWFBnalByN0tIZXJXbzdSU1dVM2JIMDhlc3MyNzdQVDFo?=
 =?utf-8?B?Ky9td1FpZ0hITGpzV09kZ0pVM2xGR0YxWlB3YkVCYlZvSFNVQjBVcDF0aTJv?=
 =?utf-8?B?TEJYSDUyOUR6b2l1Tm9ZdDE5aG9iYjZUK1lRaDA3OWlsZmRiVU90VU1vL2d3?=
 =?utf-8?B?REFWbHN1UDlob0xwaFVzVkNKcDAzOGRvSjFkbEhJZXlabEFRdDB6OVA0V1Zl?=
 =?utf-8?B?dk8yZDduaGxBQ1JyYUhSUk9rNjBJOEl0bUtrcXVIOE1WalJGTVNSK3NCREZB?=
 =?utf-8?B?SnZrRkl1K0ZzZ09oN2RaNlh1LzExUjlEU0s3alJlV0kyc2ROc0pmNkk4alV6?=
 =?utf-8?B?ZEdsTGRPQzlrTTFrNG0vbG82bkRZenZXY09qMWNBM1I5UXlYWDdETnUvVEtw?=
 =?utf-8?B?V3J3Wk5EYWs2SlU1VUpVdHBaYVFBSUIzb1ZJcUZjdGVmSU5HVTNNM1pUVXR2?=
 =?utf-8?B?V3pxTXp6aFVIdmNoSS9pR1VLNHMxc2I0SFZxdzZSZzEwYlZhV1o1QkJHNHBw?=
 =?utf-8?B?blpRM1RwRDFVaG9GampKNXAwNWFMdnhHNWgxWCsxRXJtcWk3MGtHb0lCQnVL?=
 =?utf-8?B?aEhEd0tyZnRHdGwzSHd1YUFuaUw2bHZYNHpFWTFLVXRuRzJTQldFWGlPakVv?=
 =?utf-8?B?RWFlODhmL2ZkOUZ5MW5NcmFZWDV6RHlOeTk4VGFJa1ErdlpFZWtQUURCcHc1?=
 =?utf-8?B?YjV3WlowVkN2VW5lSFpQai8xT3M0Tlp1R0k2RmFLYkYyOWgzWXdBMWVsTzVE?=
 =?utf-8?B?VjkzWE93RmxiVExRZndsMitGTkRIV2kwL21yOUZiZ3Q5c2poUVhqR2pkQU5Q?=
 =?utf-8?Q?X5icY4XgtxlVJff6iTFuucQZi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcce58f-45fc-434f-6de0-08dd3c5d76e6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 09:57:08.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26SzbZ6cR6a/Yj90bciq5OZK0EzWS7qJJij0lcnmQ1qQ7iYO7ig6K4pl63kEkjrdvByy6mbtTkMokn+34R2Fog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209



On 1/24/2025 3:30 AM, Pratik R. Sampat wrote:
> diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
> index e841a8fbbb15..3a40b79fb37f 100644
> --- a/include/linux/psp-sev.h
> +++ b/include/linux/psp-sev.h
> @@ -946,6 +946,7 @@ void *psp_copy_user_blob(u64 uaddr, u32 len);
>  void *snp_alloc_firmware_page(gfp_t mask);
>  void snp_free_firmware_page(void *addr);
>  bool snp_fw_valid(void);
> +bool is_sev_platform_init(void);
>  
>  #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
>  
> @@ -982,6 +983,8 @@ static inline void snp_free_firmware_page(void *addr) { }
>  
>  static inline bool snp_fw_valid(void) { return false; }
>  
> +static inline bool is_sev_platform_init(void) { return false; }
> +

The naming does not sound right, sev_platform_init() does the SEV firmware platform
INIT, so how about calling it sev_fw_initialized()?

Regards,
Nikunj


