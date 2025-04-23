Return-Path: <linux-kselftest+bounces-31379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE359A97E70
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 07:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AAF17BCFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 05:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7C265619;
	Wed, 23 Apr 2025 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SMIt4ljR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944718BC2F;
	Wed, 23 Apr 2025 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387953; cv=fail; b=GB1/WcQI5yzoq/CKxFw5d3JyICz+yzGE8oagF5qtlcz0WI0sTwUKZEHshtGI+ZYfbvzO2phXqSGqyhK22oSoFi6jX4b0DvVFSnMJQzXvr/q9Io0zmAfaSwQgyEmifrjVt+CsQiNRZ8CIMheqP6d2gYbw5nCJdRM3ajV0jU7oen0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387953; c=relaxed/simple;
	bh=A7FBSRfR1l9v6IsWIdIb9BFKzZIccPKdzjKAH2nYlS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QjcREe2BD+PoU5h/TU8rVt/3fbBoC2bOlL1MEqWLoHepcVXTJlhUqjbgNZ2WyGaY8Pm5rd/3nXuQVaUsW1rbl63AUTadFqyhXjrdn0fMYZQZd1vPmLfdqff0bq9uQ4IUpeZXWwnLJdqGHMQIfD4yvDYClILewoLZr3Vz8jyGBnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SMIt4ljR; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNyX4MpZ1bV70jv4JOEehjudpcM2lHwfYQOHHo97JKZSIRYPAOG8VqUhfP50gwDV2TeYPnXztRrbT4O7LoytGx5hkFOsxaxAH47TJnYFQq7Yj6AG3LenfThXlRnbi+9I0nQ1TkJOyIueZ1UrY2K1tKnqhuekUSY8nEYsBOCBCQ+4+Ij2kO9R3kqkx8k5EwINOsjHcXB2z7m6BGOp0kLMxuTRpFjRgh+SOSVp3xeIrH1f7QSXwIt4WnERH939ohEPf6mrt695BUMbjT4tmGRyslgPll8tSrExx03VnlRAo0b8bcJcfES7XWdIbH+gGLPajEuiyHqHko6wU3ooWQEf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XNAI5nzPds9MtLa6w+HPh9rkbkYGrzshTubG/BqD1g=;
 b=NBPHuNVmjJIVDNmRogx4lcbfG5z2hmMzd3EdJZEql8XHAtVX2VyYPDvsm524rKY4p8UkchQ/EZGNIbdFuEjCrmpe2jIEtrx16LAmgfHPS4ev8I+b+DvXGuQPp1Md/+KEFCAOG8r4fnjYyXR1gtuv68dwD1q4mHiyHO4YZ9OLQNMrhttRtJR/aroM34AbDxUBTB5Lk7TgWRbuS2297zVfs1HyfZtahmBWwh4hqP/rIBXl+/KLK0MIqR2I/06/IQ8DMYi2q20oeFpzxYq80tx+ErbRPochHqL5FqWkB8wF6HQaVAiD6sVj+7im2B+paAX1y6QbiMlZF0Mpr1nFgGNe8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XNAI5nzPds9MtLa6w+HPh9rkbkYGrzshTubG/BqD1g=;
 b=SMIt4ljRn1R+o5ri+6u0Vu00G7FtqdAMI7ODzTRcSel9sslVFOW+G0oRFnvcCmRb2jreuWqk/BmyPRG00RMLh2bRjViqQMYYsyBrGlKlPaUgrd5W/oZCuAeLHJXUFyYpg1hQIdrCFnBmHazMIulqf0z58vQnBGdXAg4UHImX4wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 05:59:05 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 05:59:05 +0000
Message-ID: <95034bc0-2b42-4c10-8752-c7c3b59d90ae@amd.com>
Date: Wed, 23 Apr 2025 11:28:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] x86/cpufeatures: Add CPUID feature bit for the Bus
 Lock Threshold
To: Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, nikunj@amd.com, thomas.lendacky@amd.com
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-3-manali.shukla@amd.com>
 <20250324215627.GBZ-HVC-KmZiTMxPr3@fat_crate.local>
 <55986a72-1be4-4e96-809c-dd004291df2e@amd.com>
 <20250409092147.GAZ_Y8K52Opcw2X-tg@fat_crate.local>
 <Z_hTfFupiBFPHwVe@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Z_hTfFupiBFPHwVe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::7) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fa19c6-2bde-429f-76f0-08dd822bf46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUlYM3JJOUhhbmplay9mRFhtUXE0S2FnZE1OQnprYy8vK2hWYllucWNzOGg1?=
 =?utf-8?B?bjVZam9NZGx4RkdZamsrNTdiRG4vZnNtbHcydDdDN0JzZ1Rnb0F3NmVoZm5M?=
 =?utf-8?B?SmlVTURRTTBld3RiMmIvMWdzdURpYU1oRGtrM0RpOHdLU21tSWVyZHNaczRZ?=
 =?utf-8?B?N01UYkZQeWwzaktGUjNkalVJK1NUNEhXNlZMdkJwMkpLQURzaStSd2EvY21a?=
 =?utf-8?B?UlZ3NHdBYUxqTkRjMXE3TjlzbmNCdEE2Uzh6OHZEd0lkR1d3TS91M1NLOHdp?=
 =?utf-8?B?bzgzVWx6dnh4TG9zT05CWFJlbFp4d1lVTHVQd09TNkljQzhMWXE5YmQxczVm?=
 =?utf-8?B?anNRRXQ3UW1wZWJuMWpXN1ZPbVFEdkUxM3BRNy80Y2cvY1F3bEdMTktXL1Rw?=
 =?utf-8?B?WVorTWpkSHpWQklmbXZNWkZDTTg3M1B2b0FkcnBIN0phdWVqUFhWb2RpVjFO?=
 =?utf-8?B?dy9LZStnY3Fzb1ZzZVowM1dxRDJvRmFVTUJxZzdzSlNteEYvMlJJMnk1ZkNh?=
 =?utf-8?B?MmtDbVdld083ekRwVzN0VldhbTZlMC9KQVJFbHMwKzNFTEp2dmxKTTdTcUFy?=
 =?utf-8?B?YTR6aVFTMjVxS3hFQlRNWVF3bFg4aHRrNWtnQk1xMFJka2JyQzlBQnVGdHBM?=
 =?utf-8?B?bWtCM3R1YlJBdFNjRXd3QWJKVnBlR29XcElKbjFVUG5KL2JabXBLMW1mNW5a?=
 =?utf-8?B?NHkrcU5jOVUxNFFzY0FpZWFmdElNODdHT0N2WGZHMDV2LzdCcjVvWDNtN0x1?=
 =?utf-8?B?MjM3TkdaTnA0SFJyc2ZKc0puTXFWY1NuMHJOUm5NYm9vSWZaa2RzMGZOalFQ?=
 =?utf-8?B?bTA3TWhLSkJiRHorclR3VGFZUm1SVUJ3VFBJWUdZWE1WYWlqNmJRT3JIVFho?=
 =?utf-8?B?bkxlM3BaTDhTQjRSM1FYaTNxbXFqNjBoZ2oyaUJLN01WT2E4ZWI3d3J3TmRo?=
 =?utf-8?B?KzZUTEtCOTN1MVN6MTJmeGRaWHAzbzdpVnIveEpwZGJWTjJFeUMvSi9ybjFv?=
 =?utf-8?B?U1dsejhrUE1sWEVPRFhUQ1VqVnhaNXRoVHFNei9NVmhRbXEyWEJ2TzNKd1VD?=
 =?utf-8?B?MmNzNmdRdXdqSThveTBCM3o4WVBvRUhIOWE1WDErRGVHTmllY0VGeFZvRCtG?=
 =?utf-8?B?RVN6Z3RRamNGdSs5MjdPU1FhNzc4YjRldTFobEJLOFBnL0RvVTBEWVRqWjZS?=
 =?utf-8?B?OUM1VUVJWGlWTmMxWWtJM2tkOVlUZzJCUmxRdkl3WDZObjFvR1ZOMFZaM1cy?=
 =?utf-8?B?ZmtvMkNJbldQUkNNRk5xaklEUWhyVHFYejJUUm05K2RQZzFvb0MySUFIbFdm?=
 =?utf-8?B?b1BqSUFudDFSbXlZV3hXV3RzZEpSTUdReE15WjdYckZoYzYzSENoMWZwQmZD?=
 =?utf-8?B?YW81SUNVYTRKYlROYXlqbnhublM3cklraENyU2Q0QjBZbWlOMFltZGMxMm9O?=
 =?utf-8?B?b0dkYmNWTmFDQUtzUTR1ZlVwcENzeTEzUHhWL1ZGbVo5U1VJMTBpQzlzWGZF?=
 =?utf-8?B?SkJhMWpRZTBHVmJYUytVNUU0czJXQVVPWUtBU3R2a3VyTnBQWDRPY1Z4bGVE?=
 =?utf-8?B?TmtDYWxEUEIxZDNTQnJQRER4Sjh4dmZMVE5hREdhZTZXM2w3M291UlZObEZz?=
 =?utf-8?B?L3pzUytMNzhsL3VCc2VwaVJSNC9pTlhxakN6U0w3dWREdHkveDN0cC9hNDh5?=
 =?utf-8?B?QTVQdHc3UnU2cnNSOFFSYllhbnJkVUpRa3pTb0lGUDFlWFRRZm8yM2gvNU01?=
 =?utf-8?B?cG5IdE43d1JhbkFOOU9IbVg4ektodGRWclhBeldsK3hDazdvM1g0elpxdm5B?=
 =?utf-8?B?dHpyemN6b0g4dG0wMVBTbTE2RFVOc2xIU1dTNWtyT1dEb2o5OUhSZk1lNXdK?=
 =?utf-8?Q?XFEP53QvSr7UO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVBzKyttRmpmbnlVS2p4N1IzbXZJSUlHdGxqT0ZJUjkrT1hXTWJDbmJmeW1i?=
 =?utf-8?B?aUVOcWx0WXFIMW0wdmpLMmR4a2NsczVYWVpMY1BGTk4rbkJjWURuVTdKQ3hZ?=
 =?utf-8?B?ZGpvREw3YlA3SlRXRk1TdVNaUWJwdzUvdXNseU9jN3Npc0hMRzhGRVd1ZElX?=
 =?utf-8?B?RXhCT3RiOGc0cEdkcnBPY1NJSDBvT1Fwb1pJY3ZrdkJ2bVVvdWQzWHB1c2pl?=
 =?utf-8?B?U0tEWXFjSDd5ZmZaTlAwejMvTkU4YmpTVUxpVWZDclRPUGxaMDdTa0ZKalAx?=
 =?utf-8?B?LzB6SmtiODZDczJRMndtOXkyOFhxcXVRSEc1bmdCNXRYN3dQVlg1V29sbHFJ?=
 =?utf-8?B?cEZXSWx2YWVqck9JcHE2VnNISVljeENXNWJsdlhZVWk2blNTTExDeHhYOHV5?=
 =?utf-8?B?RFRwbGgrRGxNV1V0YW9nK1hWUUJsQU1mL21COTJQNThiU0k2eW5DVkFZbnBV?=
 =?utf-8?B?aE9DeVlrQ0kxVEVJZ0VQZExqTWIyM3g1aVd6eWxXUzNEM2grSVV0a0lLRlFY?=
 =?utf-8?B?azBXbUM1aG1PTldGYTZmWU5UamxUakM3bVpuMWxyZmN5WHFuVE4zN1o2R2Jt?=
 =?utf-8?B?SXVKbmpwQ1VWcVVKMkNIM0tFVUtjV21mUnlwVHhEWGtjUWNpeEVVc3M3cjVZ?=
 =?utf-8?B?bElOUS9sK1dvOUNQcXAyN2ppc3NjUzkxamU5WUI1U2N3V0RJSW80c2ViR1dS?=
 =?utf-8?B?OWRVL3crRUc2bFhibEVCT2F5UkM1dnlzV3kyU0prOFlIeHk0MDFQbGd4UDQ1?=
 =?utf-8?B?Sk41NDA4MnFqczJOQ0IybTlaMUpWcUV1aUtwM0o3UGZyNnE1NmZHczVnYzhX?=
 =?utf-8?B?ZVBaWUNDRTFxTWZXbU5hcHZsdUltLzAyNW5VclI2ZzQ4TEdLa3ZIQ3JKM0lO?=
 =?utf-8?B?RDg1SjRYSG9rRGozbG81dGRsZ2FYeFNVNkZkNkFFTGdBUlNWRVRJR1ZFYTY2?=
 =?utf-8?B?YzFsRmlDQ2Y2NmltQ3YzTndZV1hWeFdhSkF4elVkekhBU0dXcEQySFpZSExY?=
 =?utf-8?B?SExMVGdpUHNzMU1GQmRudE10bjFqK0VWLzgwcURVQ2NBbDc1NHllVDVhOC8r?=
 =?utf-8?B?c1Q2OUpsRXlsSTJCN2d6SUpqcVVIKzBpNDVSblY1TkFmR3lMRktJMTNXcXc4?=
 =?utf-8?B?SjdVRVdZbFR5YUxhNkVxMk9OY2cxTURlZGtuVFdUNTNDczVwbldZdlVsOCtn?=
 =?utf-8?B?WFhobit0QVlQTU1SekdWczhUb1VWTWE0MlRVcDhGUStxUG00d2hiSG9GUVBp?=
 =?utf-8?B?VmN4SjE5c0lmZXhKQUg0VTlsNStsUEROWTFWQzBGOFNmVHZEdloxRXgwWDJk?=
 =?utf-8?B?bGF6djRmYXdROFRJQlNQU3Y2bytBWGUzWjZsSmtYbXVvMEIzcWo2akxJMjQ5?=
 =?utf-8?B?dUI4VWNXN2NlUk1penJndlUvSGZnNitRb0FCYm02STFORGc3MkppUXlLYThL?=
 =?utf-8?B?elk5QytocFdDbzZBSERzZjZrNmFLMGxWcStCekJ6aFhmTkxTZFZ4dVUra3VD?=
 =?utf-8?B?cGd3bVlnZmVMc1gwcGQ4ZzhYRDNlOHEvcWZKVDR0c20zOEN6WkJuMmJkMEhz?=
 =?utf-8?B?cFJkcGd2U3oyU3Vhb2JTbGRLMkxvektUaWR4UkF2ZVNjMlFtQ3RWd1QxckJi?=
 =?utf-8?B?U05QWFB0NEVGcFgxdkcxandBaHFhNFo5b1ZNc2RwTnR4cmt2Q2JVcG1UVi94?=
 =?utf-8?B?L2RGcGhRQld5VGpiaWM2UkwrTTlKMUFLa0huU2c0dmVvN0RGelRYcERxbjJB?=
 =?utf-8?B?cEJVREpEa1BxREgxeHVGT0ZXVkc5eDZwemJZZnNESGdzSHY2bHZIeUlkaU9R?=
 =?utf-8?B?QkMveVVlMUtZS25aUys1VG9hVks1dHFocUsvQWVMYVhFdFBMQlBDKzZoamJm?=
 =?utf-8?B?RUZtZXhNTXNOa2JnYzhTNjdqR2NzM3RCdzRPbGZweWNxZ3lMQkVCYm9aa2M4?=
 =?utf-8?B?Z0tqdC8rV0xVOXJoVTVNT1NlWEYzMUM1clNrT1h4eTNoczJRaE53UnErSis2?=
 =?utf-8?B?bDZOZnMzVjdJWm1jUWhtUUZSdVlKVllJd29JS2VlWG9GMEdIdjdZQ0JWV0E2?=
 =?utf-8?B?Tll5OENvNEE2OGduaFJLVkNkTFo3SFFmUzJHYW5tVUtiNGt4YndLc1MvdTkr?=
 =?utf-8?Q?II+3q0hfcFxJ0GqkgKPmsX0/j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fa19c6-2bde-429f-76f0-08dd822bf46f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 05:59:05.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI68l2LwKaL9mrbKrXdSbUZvRhrU3ZisPM/wvVMA0ANX+/Grb1b0+p2sYWAzAbuOzzimUs77ZUiQoG+3JYx2qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212

Thank you for reviewing my patches.

On 4/11/2025 4:55 AM, Sean Christopherson wrote:
> On Wed, Apr 09, 2025, Borislav Petkov wrote:
>> On Wed, Apr 09, 2025 at 11:30:56AM +0530, Manali Shukla wrote:
>>> Do you have concern with the decision to expose the flag to /proc/cpuinfo?
>>>
>>> The decision to expose the flag to /proc/cpuinfo was already discussed in 
>>> [v1]. As suggested in the discussion [v1], I have added "buslock" to be
>>> enumerated in /proc/cpuinfo.
>>
>> If you mean this:
>>
>> https://lore.kernel.org/kvm/20240709175145.9986-4-manali.shukla@amd.com/T/#m1dc7e08c54dd91d53a6bc5b1ed0a6721b356a756
>>
>> I don't see any conclusion there.
>>
>> I see Sean wanting to export information out of KVM to say what it supports
>> without adding user ABI and I don't know how far that has come
> 
> Not very far :-(
> 
>> but what you're
>> doing here ain't it.
>>
>> Just do:
>>
>> #define X86_FEATURE_BUS_LOCK_THRESHOLD    (15*32+29) /* Bus lock threshold */
>>
>> and then later KVM can export this however it prefers.
> 
> +1

Ack. I will remove "buslock". 

-Manali

