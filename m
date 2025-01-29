Return-Path: <linux-kselftest+bounces-25375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034DA220E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 16:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DC816469D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739541B4235;
	Wed, 29 Jan 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Z/x4EWK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455D224EA;
	Wed, 29 Jan 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165815; cv=fail; b=nITzmQ9Mfnm39I4nXCd9OHQ5PASRL1fTxI6TpcW+Fc6OAoJYxrImHXycyzw4IU8ZSXjHvwtUWlk5VwEMCjTjsMNjvakMJ5tY8SWzcq6v1Ca4xls6lz+vt71yn8PyzaVydXGNW4/cFBTmoW5uWTh/YwQusiBfTlTGifwsU37hENc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165815; c=relaxed/simple;
	bh=d2C4CAU4CEndPus0uOxwrDPOpfn8jRdsMhFZEwxNGBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PVVWEvbgSMvITFoQyql4ARaHYJtAYSGiOa7bei4XNqEiVrDN6+P3/kJny5K0+GXCjutolFTt4eNFzqIuCSTvJ1T8lypg6UU05HaNJbUEFI4itztXoUqrpL9czaTaeg91mXNo+/sHyKsMMQUsswkMaZrfGqWgyoHYDZWfnRfXsps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Z/x4EWK; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcvbEi7Zhy6ZrS1cQcjFzkeV0CKUbnzz7DPLgNVHm0iPXJNeL7iZfFagTEp7lS1DoZajqLeVC6n3DxrkSWjJhOftquE0SmZ+Nf3946qhC7Lrrjf0SyUmEmVf83nztV+j6id1AUcak8GQ3mNl8WlSqRJbnL5oQwhGtySNGfuPiwHKOqCQE1Yq/0rHJneneKklGrgJjn04RcY6AKU6FGMvWUf3MNIX/+mpVvjCnCSNQwelx9fEEybjQAvaVZ+AJFcgPHZ9J+D5HG0M+zjvYSo1AGahfgeEuXLe7Rsr+krUlUgD5BYDFnSisvNhJiTJQ3nfAg+poSyS/C1c4D2SnEBThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cwu71PY5gX8GMs5yotjRNsMC1dhhHqGD2vOkwmHEkn8=;
 b=wgHYFk9NWQqrE1xmEvGmN8ueU8/M01GMeYB1OyacdNCYXxs16nB9dBks2CQaBv3QVKBtS9jb1CWRTr+AzO7gE4kX4QPf4gImt7XDpN0zugk4EBZmVUdIFz66jG2XYDmQ4nOOidJvNbt1xY+tmzZkwm+MfucvjS5NxNYt031lUvulBvnE98lnhRbInkFaGlyu7iXz2REyblrK4szqkoLB2kLfs1mEr0ThL1HHpXkb0e5IoetPaA1mP/OSAfMq3XHERNcwxccGRu23hM74+GPd+pwev3KsQ/dRr4vwz8+ESQYtgOEsNzlhxON07GXNFzX3DF21waKqMDWsbzlZsA4liA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwu71PY5gX8GMs5yotjRNsMC1dhhHqGD2vOkwmHEkn8=;
 b=0Z/x4EWKcpgZ5rKjIdMhzuXkCzV5p3XW2jIftOUftPS7XXkGdKJUSRYpA0V8o9XRWcTSdK43HM4jeb4WUgz4k1KmLIQQGjo5R0oOm1mmHU0HHPJSwFeWhnf3cX/IWEex6QlXI7pJVba5bQdnOAfFyZTf8WYxvVeJ0zRAvSf0Jbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 15:50:10 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%6]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:50:10 +0000
Message-ID: <8e7d8172-879e-4a28-8438-343b1c386ec9@amd.com>
Date: Wed, 29 Jan 2025 21:19:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Basic SEV-SNP Selftests
To: "Pratik R. Sampat" <prsampat@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com,
 ashish.kalra@amd.com, nikunj@amd.com, michael.roth@amd.com
References: <20250123220100.339867-1-prsampat@amd.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20250123220100.339867-1-prsampat@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::32) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: f0dc6b02-45e1-42f3-4f3e-08dd407c9c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0R4VmJib0hNSlN3c3lGS3hMV3dyVkVSUWRNK0FLQldGcDZTUjBaUGhMZXZT?=
 =?utf-8?B?OExkWDNySE1kUEJGU3VJME1ZWnhoQnR4aWUxNTN3K09VYmwvMGZ4MmhUVTR3?=
 =?utf-8?B?eG02aEQ1Nk11UUlhdWx1QzRBNUEzTjVkQUo0Um41M01TRjBGNXhZTGszd2Yv?=
 =?utf-8?B?MzdJTi9JOXNCRWhUbjNQMWhZaFlPdWk2eHV1dlUweWY2S29tSERWWE41NHls?=
 =?utf-8?B?VEpwZ3lTK0xKdVM3bXdpN0UyR0Q1eHBRRCtHSURCMm9wajNnbjBPWU5xZFRQ?=
 =?utf-8?B?Y0dmM0gzYkIwS0hwOXBvM0FadUxiVHM4Z1lITmtjN0lTaWRBdTkxbk1VUE9t?=
 =?utf-8?B?QnMybkZueTBlaVNxUnVtd3JhY09HUVhHQmZ6V0UxOW8vTVpWZTUwVk1ERElH?=
 =?utf-8?B?S0tBNWV2UXhvbGdiVHBnQ1pjT1hXcFZHZ3lKbTR3WmJIeTZtelo3eVh4ZkFN?=
 =?utf-8?B?Mitsdm5hdkJtd2ZOd3VUVjBUZHRRTEZ1M0hzanBnQjJrTTYvTmwxWlgraGF3?=
 =?utf-8?B?VUpJcXEwaGJwQmtUalQ5OEhRaThvYlIxVU42dGhORHBYSURoVytUd3lwa1Yy?=
 =?utf-8?B?aUtYb1Q2MkF4RFBzNWszZ2x5ZnVwNmt3OVF5em9FU3NZKzh4RVhrakNkeHpD?=
 =?utf-8?B?OS9yR01BanQyaGg0d2hmUVdmK1krK3F2dWI5NHhXbThNdnYxQVM3SE9MS2pT?=
 =?utf-8?B?MVhSd2x2aTBxbzdDSVRtTTBOUkJpL1p2TFlpRm5aMTVEZzlueVcwb1UwRmVz?=
 =?utf-8?B?THpIM2hsc3Q0SkJKeExkRHlHVnBOUjRxTWo0eUtuWjFJbXFmaGZzdDFDMlha?=
 =?utf-8?B?RU1PdHk3SG9BRHBFeVk0dy9wNGE0YTh3RGM4SVhsM01UbjY4S213MHBQd1BX?=
 =?utf-8?B?OW9LWGZONXVZb0VjRlFEOGdSYmhIZU1ub0gwaURidDBqQjVJdmJFcDV1R01K?=
 =?utf-8?B?TXU5eUJsRUYyMmJ6Nm1hQ0ozcm5idWQxa25Icy9pUjVyZFJOWkVpZS9iQlBY?=
 =?utf-8?B?ZGxIUXRsVWw0a282SlVIRWxKUC9tU29vZWZVMGx0VHdESWpyNG5reEJMd3F3?=
 =?utf-8?B?Z1VFdGFKUjFsOW81YUI4RE5aWFJPYVl2cGlnK2x4Mlp5QVNoeTBkb1lCYWlX?=
 =?utf-8?B?b0J3eFd2UWkvcU5Bd1B2SThMdjlYU05jZjhSMUZLYnVlb25MQSsxa1dwM2NI?=
 =?utf-8?B?WWZybzVDNEtjSXhTcDlnWHBka3c1bmExTjUxa3pTaG1aak1SOWsyQ2Zuengr?=
 =?utf-8?B?Q0dMbE1VdFduWjM3NGhBV2QwYnpGeXd6R1ZxS0k2b1dlTTBDVW1IZGhsZFBv?=
 =?utf-8?B?QkNHdWFNS3Rwbm93RERQV2FNU2hlMG56TnFlZytEYzlGWkc2ZzZ5d3kvaWsx?=
 =?utf-8?B?anppQW9LZUpDbGR3eFN6QXpWVlppSDVVWVJjOTVqQnMvR2QyWkFpaDRiWlMv?=
 =?utf-8?B?WjZhWmMvc2poRDBnbWtIbXhqZEw2Qlh0NnlVRy85cTFvdWhBanBia1FvMWJt?=
 =?utf-8?B?WEpLZGs5dlQvbUR3OFo2UGtBWEszL0ZLRWV6cnB4UTNGN1BFSHFKT0FhREZP?=
 =?utf-8?B?UU5RaGpWbFN2TDBJeTBkN05QbVloaUlEUG9MaThhSFQ1cHJqMEwwSDVCT0Mx?=
 =?utf-8?B?MjY3VzhoTmJaY1BMVXpDOHFldm1HckdXaWprczdYQjYyakd5WWRPckRIdDJE?=
 =?utf-8?B?dEs0ZmhGVE1MbmYwNVd0Y3dYSHBidkltT0tlVzBRODVTTXAxNkpPMXI1bGs4?=
 =?utf-8?B?cUVkQlRRcjBMQ1dFMUFqZXZteHJ6cGhxVGJ2dmE4c1cyOUF0akdCQkcyWDVB?=
 =?utf-8?B?OGlBTDlHbmlRK1hQZnd1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDF1MFZyQkt1Q3VPQ0JNYnlJTjB1V2dCUC80dmlzN1RtMVNBdVdTTG9MM2Qw?=
 =?utf-8?B?V1RyQUt4ZTBTNWo5RFBiNWxZaExjTWs3aEhBNjRIc3hNVEcxeWVPNUtDTE9O?=
 =?utf-8?B?U1VoMEx3VnhMVjJiajJGeEdCTVNxV0ZUWW4rR1VJdWdqYStpanlDNU1QWkEy?=
 =?utf-8?B?ZHFHY0FsaGQ2THQ3WWozM1VwZjlZM1orMjc5Q1N2eTBnUkZNV2FoSUYvbkxW?=
 =?utf-8?B?WTYvRFpFWVBmMXFERWR3bW1ySlpuV0tvQlVpVE9iUSs3MXExc0RtZXZXSTYz?=
 =?utf-8?B?U3phT0oxNUZFbmgycmFsUzRoeStxVmpObC9Xd29vSERVZFY4bStpMUdWZmJ4?=
 =?utf-8?B?djFWMHkyOUFQaVRlcVhJbmNkZjdtcDdHOVlsUThqU25SSjJneUEwTWx1YTlp?=
 =?utf-8?B?WVRVTlRHMzJSK25JZWxRRUNyeHBCZGFmcDMxcVYySlgxNFN0SnlQUWpqdmdG?=
 =?utf-8?B?TmdYc0pTdHBaRGcwUSszL2xMb2JXT2d5S3lVMGpjN21FWGo0UWdtRkRBYjFP?=
 =?utf-8?B?VWpHaWJmUk1tUVVnWFduZ2JBUGxZTk9tSU1oR2Y3ZXF6Z3pHc0JXT1RRYUE1?=
 =?utf-8?B?WXJlT0FFZkxOS1h0QnpVNTNpTTcwS1V6VWZ0K0hEQVE2a093QjdsMFh0eVpn?=
 =?utf-8?B?ZUZteWoyZGlFWFVFbkJwVDFWY1gxUEpJVjRlNkRWeDFRQlhSMXlaMzM2QVkx?=
 =?utf-8?B?anhJY3AwWWkzSkxNMTJxMU5BZmJrVlZmZ2JXQ05YUWpJaEdIdkhuOGJKZkhI?=
 =?utf-8?B?eEFvSUpuYklqODQ5aitGVzlRM2FTZG5GZFFIVUZJZ0FjK09INmVTdUhEcllH?=
 =?utf-8?B?eVl1a1JhWHVHdFVjaUozVGwxYUpHMWRPNEdiMzc3R0JhZGFUeHBqcnlVN3Rh?=
 =?utf-8?B?a0pySWFwbzZ3NnRZd3ZFTy9FRmY5NVcyM0VDbHFhaXdwbUozeWR3RmFxOWdv?=
 =?utf-8?B?bUl1ZUpsRUQxYXJZM3hJb3dRR3FmNXlxMm9UdUFTVnUvNHFmcUVWRy9rdlVx?=
 =?utf-8?B?UkE3NjhxU0JxMHJNL3N1RHBjcmx0WlV3K3M4c3RVZDRzclJGcENWVmdqay93?=
 =?utf-8?B?NEl4cnBaMzNWVmxYYXlTc1NSVUlBNUlPZnd0V0RrQmowRVdJNk1NdERZWXU1?=
 =?utf-8?B?UnN1b1c1V09JN0tYM0s0VXEzWHVyWlJ4QTZKV0FrY1Z2OXA1S2R6STAwbUMv?=
 =?utf-8?B?QXphMW1Id1g0N1lzcUZ4R0xOR1lhaHlsYXBOK2RCZ0tBSWlpbk9GNnVIQTZn?=
 =?utf-8?B?dWFCZ0xnVEt5TkpjSFQxNFlyU0gzUVVRWVNsRTcyalkyVUpCam1xUG02bTZr?=
 =?utf-8?B?TzAyT3d3TjlrOWlqVlVuak9HVzhCbjVXT2dOcnZhcDVwbkFZbE5JQUJTVk5X?=
 =?utf-8?B?YThiZnhHOFgvSFJaQmY0czRndGhVKzBRQkpuSy9pazhQTmFNU3VnYkNWdW1S?=
 =?utf-8?B?Y1kwR1RTa2x1VUs1cWNZcnJ1MHB6VmxlSUdBUG5Ub3Fnd3pUM3pzcDMrZVUx?=
 =?utf-8?B?K0hVTXNWZ3VRYS9TSTI0NWxCaE15UUppQjN5N2I0NlRLaTlndTJmOGl0QmJn?=
 =?utf-8?B?M2NoRGtHMVV4VlU3Mm5kY1FkR3ByWW56YWhYV3cveHNzMW81TXBtVmJSRlFl?=
 =?utf-8?B?WVNmTEoxLzFRZ2dDU0xFcjVTRTlOWXk3MFlIVC9rdnFEQ0pjUGZRUlFVMGV0?=
 =?utf-8?B?aGdrekloeXc2Yld5bUhiaU13NnlWa3ovcmRoV2xPWTBHdDBxN2VFRndEclY1?=
 =?utf-8?B?Nmw1U1NVVVRidlM0YlFseTNJU1NvRGMrUWJFM2hEbjRWSlUxclVFU202SlI1?=
 =?utf-8?B?cXEwOFF3aGcyL1NlT2lvdE0yR0F5SUpUYThMNHhQaWhlM3RndElGcGRTSi9n?=
 =?utf-8?B?VC9WU21LVE5VUXpmMGNRMUtrOStkME9xVkpjZUx6YmZmRFB0UEFsM3FZUWN6?=
 =?utf-8?B?cUUxWHByOHRCdlM0NUhsc1oyNytURnpJOEF0dUQvTERlV2djREFSZjQ4aUh4?=
 =?utf-8?B?RkIvZVdvZXFmb2JsNXkrYjMwM0E2QjhnaWFGNE9jTm1wZU1XN3ltOWZyOFBV?=
 =?utf-8?B?alhEdGtjRnEzZVpUL3R6ODhENmx0c3I5WEJhM3B3SzA1aFJmSnh6ZDNFanhx?=
 =?utf-8?Q?BxizUGDMoCEfzwzkMaHg8AMHN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dc6b02-45e1-42f3-4f3e-08dd407c9c81
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:50:10.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9AT95HPF3LDx+/+nFsczajhq+EZXLwQNPBtbs5LPNNiaAsRZoPvz6jsytxZlXjLJPdkUvQdEJ8qne8N9LT4zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

On 1/24/2025 3:30 AM, Pratik R. Sampat wrote:
> This patch series extends the sev_init2 and the sev_smoke test to
> exercise the SEV-SNP VM launch workflow.
> 
> Primarily, it introduces the architectural defines, its support in the SEV
> library and extends the tests to interact with the SEV-SNP ioctl()
> wrappers.
> 
> Patch 1 - Do not advertize SNP on incompatible firmware
> Patch 2 - Remove SEV support on platform init failure
> Patch 3 - SNP test for KVM_SEV_INIT2
> Patch 4 - Add VMGEXIT helper
> Patch 5 - Introduce SEV+ VM type check
> Patch 6 - SNP iotcl() plumbing for the SEV library
> Patch 7 - Force set GUEST_MEMFD for SNP
> Patch 8 - Cleanups of smoke test - Decouple policy from type
> Patch 9 - SNP smoke test
> 
> The series is based on
> 	git.kernel.org/pub/scm/virt/kvm/kvm.git next
> 
> v4..v5:
> * Introduced a check to disable advertising support for SEV, SEV-ES
>    and SNP when platform initialization fails (Nikunj)
> * Remove the redundant SNP check within is_sev_vm() (Nikunj)
> * Cleanup of the encrypt_region flow for better readability (Nikunj)
> * Refactor paths to use the canonical $(ARCH) to rebase for kvm/next
> 

Tested-by: Srikanth Aithal <sraithal@amd.com>

> v3..v4:
> https://lore.kernel.org/kvm/20241114234104.128532-1-pratikrajesh.sampat@amd.com/
> * Remove SNP FW API version check in the test and ensure the KVM
>    capability advertizes the presence of the feature. Retain the minimum
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
> Pratik R. Sampat (9):
>    KVM: SEV: Disable SEV-SNP on FW validation failure
>    KVM: SEV: Disable SEV on platform init failure
>    KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
>    KVM: selftests: Add VMGEXIT helper
>    KVM: selftests: Introduce SEV VM type check
>    KVM: selftests: Add library support for interacting with SNP
>    KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
>    KVM: selftests: Abstractions for SEV to decouple policy from type
>    KVM: selftests: Add a basic SEV-SNP smoke test
> 
>   arch/x86/kvm/svm/sev.c                        |  6 +-
>   drivers/crypto/ccp/sev-dev.c                  | 16 +++
>   include/linux/psp-sev.h                       |  6 ++
>   .../selftests/kvm/include/x86/processor.h     |  1 +
>   tools/testing/selftests/kvm/include/x86/sev.h | 55 ++++++++++-
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
>   .../testing/selftests/kvm/lib/x86/processor.c |  4 +-
>   tools/testing/selftests/kvm/lib/x86/sev.c     | 99 ++++++++++++++++++-
>   .../selftests/kvm/x86/sev_init2_tests.c       | 13 +++
>   .../selftests/kvm/x86/sev_smoke_test.c        | 96 ++++++++++++++----
>   10 files changed, 272 insertions(+), 31 deletions(-)
> 


