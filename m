Return-Path: <linux-kselftest+bounces-22604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47A39DBA0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 16:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CA4281B76
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03D41B415C;
	Thu, 28 Nov 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UtkYaqcz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8A1B373A;
	Thu, 28 Nov 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806429; cv=fail; b=Y93xkivi4qyZ7In31WjogoSa4hfnOusOHO8j6VQNxYqke2fg1Rdku2cir9mu4hvvtD+d1vdCsvf+ZpmLuqrLCr4uO1L9Ys6QVsNl2Gh1/SfX9n7dt5mwDpU+cPcf8ZZ5VXlXqPExPvITutZ5W6ihR3sVhrm8uU1sQm0qjgi8Gms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806429; c=relaxed/simple;
	bh=KgQih5AW7YJghNmKpYMQIuiWDGsHOmib+HrxX15fzAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dPULrKlKz2HC6U7jZA3PeR1cIH8YmA7gY7AuL2AukY8Y5cQO6AdmkaeVqHlrjDXneFyqOpZHFt3ovekRW5AQuHQiQgKAKJ1UWc40zb1+bNdzB05FW2Kjo738iGUznyJzBaZE4Zbov+CL41pJ2Hzs+0So9pc0S/PsTSQWgn/lyrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UtkYaqcz; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIgSBlw4hhOuZyq0tGE3XSpq/LInfVMjAhQ995GjQPfVpyDrEuCQN/HWxQ2HM7MjYQAghB4eXn1/eACAySx19LlEJIOhjJSvZRyPU+9P6pRwlTl0o8+1tRKy34QjqEIFV4YzwoQunC3twbHFXy0L1LGHOfbjR+Mc+dMNbNJcPFzl/C1+2C6xHuU1iJsE3gZE4Im2pHaZhlGJT2JBPTHcQu1VmjCOvN6vb8C1VDf5i9UHQYWzM6u7YBonUfgdpF3sQ9vIgvCgYmUHbiZJUYdwSDRQRnNLu4A2OvQUmz0ErPDMIg5gGe+Y6eIecmwjfGbkXWI84jbydE8l2b4KGA2s9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96sYsCV+7HfPut893OSLEXFIkG9D0hcxONkIrpZnONE=;
 b=ueOJO6SFlH2M921PjfJMSS8wTVnXu8leVVlIny1wYQlFzYClun+vJWRFxBlCOgtwcJBJ9V3qiZENJijHzVaae/zrVPbpy5sj+BUNp6hmhdUpsrHpnGLZdUP1HISY4hbSzNvB9Bl/7a5sAVM0wQEiN53xYD2l5ZlemmpsfuqJZ5/ZqmtcYuivLOiiG9XYhdOc3M02fRRGTUr6WV9U3tGKGJtx2uBxJNIBE0SglzjtBmtLIf/0fU7V6JAPh3/ADSUAiJMVeUn69SbHGY9CcKBnCjQ25BcIUaOKXqeZcuxHVhzTzYfcaGGb6BOJVou9YhuIfCaceld3MndO5XLG4MfC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96sYsCV+7HfPut893OSLEXFIkG9D0hcxONkIrpZnONE=;
 b=UtkYaqczWFzFzWo9IHDIOtdN9n/798kkYKw7JSKAWCjFdEK4+2Y8AmTF170T+MQ/8yeu9jrLhdKO+A3D8SRYQQoSjbAi2tC85Z63q+JKxWiYR8SnUGw1KbODQt8waWuSdDQGssAVwBp1k4bQ6rmRU3spBL3BARJkNdX8IeP/jAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 15:07:04 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:07:04 +0000
Message-ID: <081db246-dc58-4329-9841-14b45a744c55@amd.com>
Date: Thu, 28 Nov 2024 20:36:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] KVM selftests enhancements
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com
References: <20241021062226.108657-1-manali.shukla@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20241021062226.108657-1-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::26) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: da1d2044-418b-445a-c231-08dd0fbe5132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlptdlB2Y3YzMTlEbDJFSU5DRFFWWEhwWTFpdVQwbi9Hd0dvVWVLb0RGQVB6?=
 =?utf-8?B?ekJOQkJ6YWdOU0c1ZDJNamhHVWw0UkF2aVJLS2lTbFZtb3NyWXZDYXdISU13?=
 =?utf-8?B?b1REb1NxU3NqdFp0bkpXOEcxa0gxMmRqUVBrb2ZIdlNITDdMLytXRDYybDFh?=
 =?utf-8?B?cHR6TEFqaEtHbCs0VXVIcS80K3ZQTjJ4d2cySDhxdlZFYW5hWGdzVmtqK3c0?=
 =?utf-8?B?YXBoNEc4YUhpN2p6MjJoMUR1MUNwZ09ndEt4V2w0UmFqbHAySFdWSnNVVG1B?=
 =?utf-8?B?cUFvNWUvL1hnS09nSlB2M0hiOFhlQVc5bG50UUFzTXZoSUMxYWhUMTVYNXhF?=
 =?utf-8?B?YTBIZ25XdmhaWFFyUS9POCtMVGlvVS9lWEZaMHpJM1YrUEM3ckxFYzdPZTNo?=
 =?utf-8?B?MDJuTzRrbVJwRUM1REhadUovRHpQeVNWb3d2U1FYbUsxbWpTODRUODVSclhX?=
 =?utf-8?B?QU9RQU1mRW9EMGgvYVlSdU05YUhxM0NwTSsweHFwUmVWbFZxdXNHOUl5YnpB?=
 =?utf-8?B?TTlrUmRUNEM1YTJjU3Yva1ZaK3M4TnpBMEZXWmh4S3pJcVdRVm9UaHRaaEVt?=
 =?utf-8?B?dnpoV2c1UjhwRi9zZzUxWEgxTTFLUVoxQ3llaHRxM0lwYzg4dGhkbGNhRVNt?=
 =?utf-8?B?Z29UenljWmwvYXBPVytTcGtqYVk5QnFMaGpIUjFQUS9lcitkN25LNFVnVWp6?=
 =?utf-8?B?Tld5YS93ZjhxTERjUjByL0thWFNnTEJzdHc2d3hobnFLNGlHZGx3aEQyaHUx?=
 =?utf-8?B?dE9wRXR6eTYxK3VIVXYrb0dYdlBHSUs0cFBrTHNQM09FTEcyMkxHLzVBekFi?=
 =?utf-8?B?ZFFucmRlL1VJY25BMzZaWG01R04vRVBpc2dpTFFTRG1GMlFKQW0yYllKYTk0?=
 =?utf-8?B?SXdZNkFyVG5nU3pKeWFyL0hQUHZlamc1NjJqZCtHd1NqSzRvdTJEQzJ2QTFU?=
 =?utf-8?B?eWlBMjQ3dlNNNHpNcHBLaGdNTy9yb0EzOUxtejFxbUYyZVFJZG9JNitlbzhP?=
 =?utf-8?B?SS9MSFZYUzM0eUYvbzB4M3VWYXFaM2xJZGRqY1dvYTFzc0haSjlkS3N2OWpo?=
 =?utf-8?B?V05vVkZrTWh3d2pzUi9QUHNaKzdXVlF6bzRFSzdHelBTMW8vSFhQVXV6ejNT?=
 =?utf-8?B?OFNLdzhoVmNtQldhQnZNY1dYcFY5WndhK0tONmVJY3Y2eURzWm9Yc0dJejR6?=
 =?utf-8?B?RmxmVkpvcGpaOU5CYUprZkQyNjlOQjA1L1NiNXVvMERSSWVBWG5mamVHc1Vk?=
 =?utf-8?B?aFgwZFNWWDNPdExLRFl5K3ZBa0g1VjRLdDIyNnZNcUhRcml0b21JcXVCL1NC?=
 =?utf-8?B?VlpDSHM3eFJ2TnBwaWdZVk4rM20ya290NHNlSHZ6ODVObTFpb25OS3kzNHhT?=
 =?utf-8?B?cWZZVVk3R0RuSU9VTFdJYW05a3d5VlhYck9lYkdPdlM1NUFZRUZUZzBoM3BU?=
 =?utf-8?B?S3N5ZmpzeWlpeGJMMWpYZVk2eFdsZmRyWVAxbWdmZ1h1WFRHZFdON3B5MWJV?=
 =?utf-8?B?MTF6cHRnMjUxNkxYVkFBMmtWeWxBSkJ6bkJEc0JrdGo0UUc4YzROdisvZjhR?=
 =?utf-8?B?WmlTUi96b0RueC8rYWg1ekdzcXBYOU9rREYrY2VWV0o2c1VhUjBtOTgxRjVO?=
 =?utf-8?B?WWM2OEVoSmF2VFdrOXZjZGxmRHcrN3QxK0VSbll3ZVBJUDJnUmFVSDF1M2JC?=
 =?utf-8?B?QVIxdzNUbUNjcFNaakZTUTVKVndHWU80TExjYnZQV1Q3RzJDNDVyalhwU2V0?=
 =?utf-8?Q?l1i14KxvBTCL1m27b8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHFYL1hSV29ORDlFL0tlYys4amxRdHArZUkwTGs3SStYRVJGYmxKcXh0SUZ2?=
 =?utf-8?B?dzJjVUc4ZG92TmZKRy9HeWgveUVSUDB3L0ZDYzJkSzE5aEJmZWFxK0UzM1Jw?=
 =?utf-8?B?a1NYY3REZXVkTjdwalRvS2tHMUNyaVowU1krQ25UcFBkeFRCVytyNUllZHpx?=
 =?utf-8?B?aDRYVTczZHc5cUJqT3VBWWxJd1BYMExDN1JRSEt5c0RmUTJXdjNnaVdyQXU0?=
 =?utf-8?B?SW1FSWM1VmEveE8vc2FkdnJyY245L05LVXVLamVEU1o2Mm1TU3FvTUNnMVgr?=
 =?utf-8?B?N1U4QTFLMFU5T3ZNbWR5aEp5bzRmZk9nNDNuMkkxK3VlaUJENUVyUkF6SFBL?=
 =?utf-8?B?OHZaMlBCSVJsLzBJZTZ0OXQ3dU9XUzBiWC9WbVVoaFVHalBhVmFNeFgwYkNx?=
 =?utf-8?B?bEU0eFYzeWhWY2wyTm1WeE9MVzZpa0dvOXAwenBleFZvVEZsK3d3M3dlTDNp?=
 =?utf-8?B?TFRJMWdVUktjRm5FajFqN2dsdS9oc1laNHBpUHNud1l6TUFSdy90ZGlqODh6?=
 =?utf-8?B?aExCekswK2xtNXZJS1ZsV2xJVXcvNjVnZWFmRWplN2JaSnRtSU15N3pLRVls?=
 =?utf-8?B?TTlNRW5oa0JtK3U2d0VZeHpDL0ROcnRhcm9DRks4a05WbVpFUzhoR1c4dmM1?=
 =?utf-8?B?Y1NqcGhnT2hDVThBUVk0eS9GUHk0MTZrWDlMTURwRHlFU0dhZ1QramNvZ2hV?=
 =?utf-8?B?SEdMd3NONkZWVGgrdXFqQllDWVhyYjNsTEo5UlYwV1ZvWSt5WkdUK2psMHls?=
 =?utf-8?B?RTJBbjhpOEVuNTUvKzVzaUNLSlFIOGh4azlLRlZ5bEpha2pTdkh3NTJoRkxy?=
 =?utf-8?B?S0RXNnJ2WU1UV1BlRzNSb01QMVNMVlIwenU4RmR4OFBYbDR2Q0FNUEpBR3kr?=
 =?utf-8?B?V0tLZDg4eFpxaG9hYmJSc1R3bmFGbzJaWGlwN2Rna3NUck9ScWpDdURGZkV4?=
 =?utf-8?B?czY0eGpnemMyc0R5Snc3VFFmOEQ1T3g3N3oxaFRVS3lTVTNQclBJbytXbmho?=
 =?utf-8?B?eXRwWjdKUVQwUmM0bDlXcmZVWXVUU0VBMXZFTHpyVVBUZnRPUmQvWEdMOXky?=
 =?utf-8?B?NEZCeVF0c3kybHlRT2RMRlI1VDRpUXBSWERkVmhrTUdJN2tjdVdZdm9kdEZY?=
 =?utf-8?B?ZTk0RXJvNG1YeHhKUzN6cWZMUm52QzVNMk5DUndkZExTRWZkZUV3R29RcDVq?=
 =?utf-8?B?bmF0cDBGbkJUdGJyZ1B2K0Ivd3lDQVk1eTJIUmpWMVUxS2JoZWp4dUVkUGJH?=
 =?utf-8?B?MTdzU2pWa3puTVVPT2Frb1k2MVJpTWUwdlFWVEJSQnRmUGU0VjFiT2dSejVN?=
 =?utf-8?B?aFlJUXpFUDV6MDduTjJDR3Q2cnZWRG5RSzBUU21sRnRXQXFLT1YyaUkveHJy?=
 =?utf-8?B?RDllQ24zMGREZEY2MGVuSzFoTnR3L2pwYVhZVFEwODZXN0NMMldyeEFlQ3RZ?=
 =?utf-8?B?eGhqOWorMFBUZkdkUy8yRDluR0JjQllSeXhhYmFqWlJrejhhNmlJOUo4NDlr?=
 =?utf-8?B?a2plTTUwSzk0VTVUS0VPejF5ZDVFVG5oMEEzVXExd212MEFRbnNiNnZxZkQ2?=
 =?utf-8?B?RlplTTJ5VWN2OU1YNHZySDJuV0VwUHpJUVkvWlZ3MCtzZFpiSWhJQ3ZrY202?=
 =?utf-8?B?aWtJVGVyUExjR1JKRE1wL2Y2WVgwS1RaQUtsYnI5MmFJSk1BVFZLWkJrY01n?=
 =?utf-8?B?UHNLaVNZV3RiMFl0MTdTdW5DVjNEanVQK05EMWZzbkhPMXhsSVRHd0tuL2Rn?=
 =?utf-8?B?K0I5SUszVGJFS3RreVpRc29RWFlpMmZBY2NrZjRWU2xFQUNObEdMSngwblRl?=
 =?utf-8?B?dnc3aXhld0R6L2pSaWMvWlZiVUo1UHU2UElqd3J5Ri9zVTlML294TkxHZ0Va?=
 =?utf-8?B?T1h2emVyOFMycDJwaXRtQlFxMkd6Sm54MktQTEZ4R2o4eFAxRlc3aldLMUQ4?=
 =?utf-8?B?a003ell2Z1cvUGl4YjZHRGlyOHJLeEFDWkhDMW1QM3FEWDFlcVpWb1lrWHBN?=
 =?utf-8?B?aGVkQzZvTUVqdGQrVDZ4d0IvdzZqT3pDLzRCY013WWZ5SFVVWnZxSzFRRDlk?=
 =?utf-8?B?T1lkcUxHeGRPckJQWHVGdm5UcnB1bXhqQUpWRXFRWjdhSWFITmpObEtnaU56?=
 =?utf-8?Q?N90u9AfPbUbp25lnzi0Ihstq1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1d2044-418b-445a-c231-08dd0fbe5132
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:07:04.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BreJQhuUEy6bnhuYh3dfV0FymGDaUZxWDYZWKAFVP6qG/FtTE3FriAQ7VO+xNZrwqIG3u7gs4xYZhivHoWkJYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997

On 10/21/2024 11:52 AM, Manali Shukla wrote:
> This series was prompted by feedback given in [1].
> Patch 1   : Adds safe_hlt() and cli() helpers.
> Patch 2, 3: Adds an interface to read vcpu stat in selftest.  Adds
>             a macro to generate compiler error to detect typos at
>             compile time while parsing vcpu and vm stats.
> Patch 4   : Fix few of the selftests based on newly defined macro.
> 
> This series was split from the Idle HLT intercept support series [2]
> because the series has a few changes in the vm_get_stat() interface
> as suggested in [1] and a few changes in two of the self-tests
> (nx_huge_pages_test.c and dirty_log_page_splitting_test.c) which use
> vm_get_stat() functionality to retrieve specified VM stats. These
> changes are unrelated to the Idle HLT intercept support series [2].
> 
> [1] https://lore.kernel.org/kvm/ZruDweYzQRRcJeTO@google.com/T/#m7cd7a110f0fcff9a03176935ed016f49088df6b0
> 
> [2] https://lore.kernel.org/kvm/ZruDweYzQRRcJeTO@google.com/T/#m6c67ca8ccb226e5f357d943da2a2965a4224f69a
> 
> 
> Manali Shukla (4):
>   KVM: selftests: Add safe_halt() and cli() helpers to common code
>   KVM: selftests: Add an interface to read the data of named vcpu stat
>   KVM: selftests: convert vm_get_stat to macro
>   KVM: selftests: Replace previously used vm_get_stat() to macro
> 
>  .../testing/selftests/kvm/include/kvm_util.h  | 83 +++++++++++++++++--
>  .../kvm/include/x86_64/kvm_util_arch.h        | 52 ++++++++++++
>  .../selftests/kvm/include/x86_64/processor.h  | 17 ++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 40 +++++++++
>  .../x86_64/dirty_log_page_splitting_test.c    |  6 +-
>  .../selftests/kvm/x86_64/nx_huge_pages_test.c |  4 +-
>  6 files changed, 191 insertions(+), 11 deletions(-)
> 
> 
> base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da

A gentle reminder.

-Manali

