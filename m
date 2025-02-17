Return-Path: <linux-kselftest+bounces-26754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C105A37A9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 05:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46735188D6AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 04:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB65156F54;
	Mon, 17 Feb 2025 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZdBoGfA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259FD12DD95;
	Mon, 17 Feb 2025 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739767467; cv=fail; b=nZxBjISLowzCPlfEbSwxzyxDrPl0/rgfXIDZY2WYp7E70VBXNyU1nYtYhE6c/nWUIeRRCKwsAcwKjQduPMqKOuLszaq4CtvPPjTl4IZr/LSpr1eiC2P+X6sLWD69Fyohd0KaB3FWdRjam1vKQnljVNVVTyVGFgWoR6BrizdHN2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739767467; c=relaxed/simple;
	bh=uQ4Ejg2OSEpBCHkbOaPJIUWIVhmZJZl/crH/x+oe/kA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9EQde5z+3Chg5G6pofRsBWupLVMJFruRbMoFhrb+D5fxngb+JwQTqYVw8vzzy8geIMoSc1eQocsr7ZDOZBpaBgY5HeRYt3ghRKzWQezCLIiujG2s/nvn+ILuPTP8L0cPgFQtoG+k/oQE4crZINrbjYd7dbS/6ndL+2IqtiwBqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZdBoGfA; arc=fail smtp.client-ip=40.107.100.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCflVki8TGuVeLn4ugX+7HJIhEjXLBrXFPv4xcv8w5jcFWCcABeTdqNLY4P1Ub3vq2ufDG2xnAg28YUA4Hwzk8T+lbnA256drUqL0s6ZobwSOJH8wERvMnV8SLx8b7DsV9UQ4kEgQAqm96dwKm7Cak9zgx14E17st7LrH9IkXXVRybE+YWSEyIlwhXWtWjsvLd8wnN8tp4D/9D7hRpOqsU8Kq/H+q2y7oPaKt5FinaZhQwwlF37ILS3l/t6yPe0FbJTN1lB+U1ZmxOY+1FFsYm94Rcs+gbv32e2S8X0KHLTnimkm3bsErhwsVvxIIMFMxEUjS7Fml0aQUUSiFtoQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDVvElRt+YuWJLI0RNxXtlcX86qRhFPIO9cfhazz4XE=;
 b=gzj4VCIIt+E/nriEgK/Lyq4H9q7A0oJ7Htq0VC95LTq4gkezpuefu/4Q+TSzk5O+oKhvYqYCz/qfEuXH1NPgBFQ84Dqgttzd6d0XJ0GFvFetOgW1M7a/F2nQd9WR6VuEPFSXoxk1pdDhF5beHPiPlzAR3USu/hh0VVOyECIgUWlQP8+48JOK0P1isYRm5YRJftiW2GkDLlysj3jaNvY0Nc/AKnj4LBFRmXq4UkpLE3QLJ+KhD26epjXwB2dvLjhKi0IriEEh2lr+uE/HZxIhCu678K3KlUPcosTdZJEg8jAdcR4zAY/5iD9yDkVEC+Gr9nnxzubGeofOE/2QhwmZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDVvElRt+YuWJLI0RNxXtlcX86qRhFPIO9cfhazz4XE=;
 b=qZdBoGfAgxgZQFqT0vGsB8TppxD6LAp1gRpPIhnQKUFv3rrmMNp9RmQN7me+JgAwJegYnj1Qc36zoKXgodbYK8nRvh1Y62QzahqeazE6takO6cJmQYLBdf6DoJj8DDod9HAt2Z8GcMKXeaQS7w0M8QllRIMHmP2sT+XMZaEyyX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 04:44:19 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 04:44:19 +0000
Message-ID: <cad45745-3e77-4f6a-8165-6f8051e03322@amd.com>
Date: Mon, 17 Feb 2025 10:13:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Add support for the Idle HLT intercept feature
From: Manali Shukla <manali.shukla@amd.com>
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, neeraj.upadhyay@amd.com
References: <20250128124812.7324-1-manali.shukla@amd.com>
 <9f1cc809-c2d8-4a02-ac01-093d3d3eac38@amd.com>
Content-Language: en-US
In-Reply-To: <9f1cc809-c2d8-4a02-ac01-093d3d3eac38@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::19) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e924c6-b3c4-4148-718e-08dd4f0dbd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0k3R2l2WDQrZGtwMHJHWFFpRTZBeVpFay9kV2FqUEM4NW8veksrN01OT2lX?=
 =?utf-8?B?blhTWEZHMXlsV3ZsSmpOWVh5TmFoK2hWUDhQUTJQblpkRituUGNWVXVLOURm?=
 =?utf-8?B?R293amVLQVRtb2phQTN1ZE5hWHZlZVFjeXo0Vm1GUGRlZGkwR1haZTloUmhL?=
 =?utf-8?B?VHE4OE96dUNkYTJFODkwUGRqVVUrL0VRL2x2ajVRekFZTWxUVURFUExEN0V6?=
 =?utf-8?B?T2syYlVRYUJ1MFNWZ0hxWUc4TEcvakhkQ0RLZ1c0UG1OMjIzYnpFeTZ5N1Zs?=
 =?utf-8?B?S3dCUFErcERUTDVpN2ZGUnJUcGg4dHU5MU40V2tQMWpTaFlpSWF3KzhFN2g3?=
 =?utf-8?B?dmIxd1pCaGJMdTdhSUVSMEFjVU1VeHFiQTRJSEp3cHowbGtQWWdCTDBZQzlP?=
 =?utf-8?B?ODFidDF3NmFWWmtpQUJrRkNtRTlrSkZXQTZDYlJtWUtDaERlNTRSQkt0Sk5y?=
 =?utf-8?B?UkliZ2c3RmZaR2JpajRIM3c4aFYvOWIzRHp6dlR3THhSVkFCYjZLNHlHem8y?=
 =?utf-8?B?Tkcxay92ekttRlExaXNEQWpwRGh2dkpkN3dmVlk5NHhRd2VNZ2VZNlNzVXlr?=
 =?utf-8?B?cyt2TEF6cDVrQXByMnRWeForemgvakwyNE00My9XcVVnREh4aW9kZjhRVWlm?=
 =?utf-8?B?RTNDUjJNcll2WUtPQndHTVBzd2hQem8rejhwVENldHJzbUNXTFdNZU1VNjM1?=
 =?utf-8?B?bE42QnJCb0d0Uk5VVzlCdHdPQmd5MXlUZmxVVDl0dmxIL2hnWHUwbmdqNzZM?=
 =?utf-8?B?OE1QRGxpbng0NGZ2QWNVd0JYdHB2ckVScFVPdHhpZnlTNW05dlh2RHU1L1pJ?=
 =?utf-8?B?eDlXanllaVg0NzJLWjJkWHVFeUVvYnBPd2RFRGtuQXl1VnFZTi9kbHV2c0Iz?=
 =?utf-8?B?Q2t5U3UvTmdYNE1tbVdmY3NKaDJRb29hQ0g3L0xWQ2c5QTN0cldWZStEdzRy?=
 =?utf-8?B?ek4yOHVaeldxbG11aFkvY3JYU2xkZ0hyenNCUXIvblZDK2RlWWZLbU9yanFm?=
 =?utf-8?B?YmYxU0hGdzQ4cFdRdTB4NVZ6Z2lpOWRoT2g3akJBU21xaDVJTFQ1aTlwb2dW?=
 =?utf-8?B?ZTY4SUlYWjlWWkIvQnBZRXJ4WVM1QmRJaFBsZDBQbm82ZkpNN3ZiY2JZeE5E?=
 =?utf-8?B?RUd0YkIzd3l1MldXZVRsdUlkSENrWEI3d3FtRkY4NTVJZ29MdlE2dUloMUpa?=
 =?utf-8?B?d1BiUlhJYXZua1Y1aU1wdkVxZHZyYjNaenQ5NWdnTlBhYWU0TEk5UGdPRG5r?=
 =?utf-8?B?N3d2d1l2S0t5RzlkNTdaN0g2b0xET0ZPOGRCbTQzbGk4ajk2cmdVSlR4NUdW?=
 =?utf-8?B?MWk0VXBnM09GUk1TdU1HQ0RxdmdISGhQSU0wSHgvNWtWY1N0TUxoNVBBVVFa?=
 =?utf-8?B?cG43L2dXWGw5YTZlTHJhcXFucytRbTE0ZE1vMlNHbnVEcFBRNTZ1TU4wV21O?=
 =?utf-8?B?c0c4aTRNMUdTN3lMWEY4OXErenFyejhjRmhwL0RURG1YZ2dLRjJxL2Nodmll?=
 =?utf-8?B?M2l0SGpRbnRkZmZxcThXenlDWUVpZlVPOWU5dk13VWU0eHRZSVZOOGZ6WEhX?=
 =?utf-8?B?Q21KYTZLOGdDR0EwK1VIMjlrUVk5NXkzcnA4WW0rQ2RGNWpSNXFBTWxvZEwz?=
 =?utf-8?B?YkczVXJ1bU44N05UOGxvWEJtYUZPbll5NXE1T29ONytHUUsxeU83OUZEUldZ?=
 =?utf-8?B?YzBYM0RINW5FU0NCS1MwOFArcitDRjFENlErSWpWeW81dG9TTW9sOE9yUGZu?=
 =?utf-8?B?blc5TFkvd1phZ1JXQ09lM3pMd25KWGRYcnJXdDZIcTlwTnNzYlYrU2l2Yloy?=
 =?utf-8?B?N3hsUmdVcCtGK3U4a0k2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3NwMlRtVXJqTlVDUjdyVWhpRTZ3UUIxOTR4Z3pwa3pxa0lyRmVIaHhvTUll?=
 =?utf-8?B?aERCbmRzV3FOTnh6NTlLaXhXMUIyWjZValQ0a2JaVEVaNXpGVExNeXpoMlJw?=
 =?utf-8?B?ODBuMkxHaGFZSktwNmIzRjkrSDlMQXJmQm1zM2pNZ0xPYVUwVEduS3FnRGlR?=
 =?utf-8?B?dzVqOUNPVjB2dlVGbXBXeFAxR1lVaUprY1JaamNISzd4dkJIMlk4M1RqWWRS?=
 =?utf-8?B?STd2bkRCZFdYM0U0SWZoU01vNU9PSzhnd284UnZSVzdpOGFRRWUzd0N1NS9s?=
 =?utf-8?B?VW0xbmZ1Z3J4NFFTZWgyb21EeGw4TnRkbkV2YXNIb2tPMnR2RnZTWkVZUlhl?=
 =?utf-8?B?OVFpL0hveUlQc2ZJMW9UZlo5UW5ZY2JmdzR3aEVGYTZINWpkRDVibzYxYkdr?=
 =?utf-8?B?L0JoWXE4RWMyZ3Q4WFVCWk02bllHRHVreU1OUktuWFQ5bVBhOGdDNWhHeHV6?=
 =?utf-8?B?S3pJb3hhOHpJZXVIZkZuMjBzaFJjbGxCbkwrVStCaTFIYTAzOFE1T053N0E0?=
 =?utf-8?B?VnM1NzNvcGttVjlXTVJPcnRxcFppT2FCRzhpbWxqREJPUjE4VG9scGsxYTEw?=
 =?utf-8?B?ejVvMXNGeVpFS0wxb3N4akJYTjl5bEk2cHQrSklrWXBjSDMxb3FRSXhYd3dp?=
 =?utf-8?B?eVNFaVRrQ0o3VWNDQ3FnS0VXWU9JbnY3bGdmNmhFd0g4MVVYSlpQNWUydXlF?=
 =?utf-8?B?MEpXam9XZ3JtRllFNHhQUFA4b1VjOGV0M3UvWHJoM0lBcnB4VXhsaUZlMUoz?=
 =?utf-8?B?SWw3NENnZE1NK2UwMitUQjYrZkFxWEFpcE1aQ1QrUUhVSnFBbGpXYW9tN2U0?=
 =?utf-8?B?QUhHQS85QnhyU21wWVYxNGUvR01YMnI4WUZ3MUdYdy92TVl2b0hQSGVXM1p3?=
 =?utf-8?B?SUdpNFY0TzhVbDBXVkJ0OXdTZmRPVUJaMDRXaHBSVlU2VXRXOWVac3NsV2VQ?=
 =?utf-8?B?M1U4VU51bXE2UXpoVFh6b2pjYnVGeU1hbUJjS3Q0QUNaZDJNTjlkZDgvYWQx?=
 =?utf-8?B?aDFueWlRSDZIYkxXRE9EN1BkVDlWcnNyQ2pzZ29kam12a3dFVXFoRE1wNEtn?=
 =?utf-8?B?UXZNU3FnYVlPMWpjWDJ5UlR1YkQzc2tvcUI2NmRzUHhmVnQ1UHUzd3lzVzh2?=
 =?utf-8?B?eUppLzFFYVIyZU95YytBR0p5bjlPblFxbG5QcVQ2cUJGODdyS1ozQThKTEdQ?=
 =?utf-8?B?M2l0M2xQdVpmSUN3c0dEVVNBL3hyeG5DVlVPaGR0S2JqVHFQZ3hsNDdyTGJ5?=
 =?utf-8?B?SE5YcnUzRWxFZ3FtRlltQkRnR1grY21KY0JvaVp1Z1o4cGtKSDdSRXBOUXRH?=
 =?utf-8?B?c0pnYndnZldpc1hMcmw4WlJyZW5HaW9VcFlpUG5OK1ZBc0l0MUFrN1NBbEts?=
 =?utf-8?B?dktWQmtzZlc1TFZxUkpGTW9rU3VtNUdYWUhqb29QZUxxLzN2QnNCUFNvZEwr?=
 =?utf-8?B?NFNLdmxOcE51TW5XZ3FsNFRVVWFvMld0NlIzVmxYZlpwck9JakRMSU9FaWhq?=
 =?utf-8?B?YnAzdTJISDlrcUtScVJQM2hHZVZ1S3h4RTlQemVkaDh3c1pQdWVJR0ljK21s?=
 =?utf-8?B?ZWFlMzFKSVNlMmt3WVhpWVIybUp0SnRLeGwvYVFzRjN6SStpWXdZYkt2NW11?=
 =?utf-8?B?QkI3NHFRVEpWU1pkTHkzVWRsOStFckNjUGREcmQwUXVIdDdreU5jUFIzWTZz?=
 =?utf-8?B?Z0xoWEtnemtHKytIMHkzWHFRVWY0UUhTYmdZbHhxUk9tL2JFOEgyMDhNMWEy?=
 =?utf-8?B?Uld2M09vM2JJem9RNUJ3OU91WDFBRlgxNlEvSFBONlUvVFlyRm5tbzVacXc2?=
 =?utf-8?B?d25sUHIxQ1lOMm5XcHRaeGlHdm15TUVCbHZkWW5qWUM2dFA1Um9MblYwNmxn?=
 =?utf-8?B?ZnFGZ2VIRGw4OTczUk9vM2xxaGFTb1gya3NxZi9ialpOQjJXTjlsaHJEU1J1?=
 =?utf-8?B?ZkZFTTBiZzRwSjVBbnNQdU5ZSUs3ZXIzWlBTUGxEVnQrOVdzSmlSY3MvdHVC?=
 =?utf-8?B?T3FUd3NLTGVUSDA2dFpWbkt3eDJpVW5Hc2p6Vk1BZ3V1RnZIWmFyc2NhMldh?=
 =?utf-8?B?MEpiWUszYlBnY1NjWDh1aDFOd1BXV1ZtWEhTZFFQVUg5WUJUcG11RVlnWEFC?=
 =?utf-8?Q?fmBHWs6RzEnTrW/vdvKatoFpv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e924c6-b3c4-4148-718e-08dd4f0dbd63
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 04:44:19.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0E7UHYLDUSfmnmUJfHk58NrZykUARCEE+xfI2xCUqCgaGrZxWbyyYDs/qKQ9sHy+fb5fxGzBpxa351OKJWF7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980

On 2/10/2025 10:36 AM, Manali Shukla wrote:
> On 1/28/2025 6:18 PM, Manali Shukla wrote:
>> The upcoming new Idle HLT Intercept feature allows for the HLT
>> instruction execution by a vCPU to be intercepted by the hypervisor
>> only if there are no pending V_INTR and V_NMI events for the vCPU.
>> When the vCPU is expected to service the pending V_INTR and V_NMI
>> events, the Idle HLT intercept won’t trigger. The feature allows the
>> hypervisor to determine if the vCPU is actually idle and reduces
>> wasteful VMEXITs.
>>
>> The Idle HLT intercept feature is used for enlightened guests who wish
>> to securely handle the events. When an enlightened guest does a HLT
>> while an interrupt is pending, hypervisor will not have a way to
>> figure out whether the guest needs to be re-entered or not. The Idle
>> HLT intercept feature allows the HLT execution only if there are no
>> pending V_INTR and V_NMI events.
>>
>> Presence of the Idle HLT Intercept feature is indicated via CPUID
>> function Fn8000_000A_EDX[30].
>>
>> Document for the Idle HLT intercept feature is available at [1].
>>
>> This series is based on kvm-x86/next (eb723766b103) + [2].
>>
>> Testing Done:
>> - Tested the functionality for the Idle HLT intercept feature
>>   using selftest ipi_hlt_test.
>> - Tested on normal, SEV, SEV-ES, SEV-SNP guest for the Idle HLT intercept
>>   functionality.
>> - Tested the Idle HLT intercept functionality on nested guest.
>>
>> v5 -> v6
>> - Incorporated Neeraj's review comments on selftest.
>>
>> v4 -> v5
>> - Incorporated Sean's review comments on nested Idle HLT intercept support.
>> - Make svm_idle_hlt_test independent of the Idle HLT to run on all hardware.
>>
>> v3 -> v4
>> - Drop the patches to add vcpu_get_stat() into a new series [2].
>> - Added nested Idle HLT intercept support.
>>
>> v2 -> v3
>> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>>   a way that each architecture can share the generic types and also
>>   provide its own.
>>
>> v1 -> v2
>> - Did changes in svm_idle_hlt_test based on the review comments from Sean.
>> - Added an enum based approach to get binary stats in vcpu_get_stat() which
>>   doesn't use string to get stat data based on the comments from Sean.
>> - Added safe_halt() and cli() helpers based on the comments from Sean.
>>
>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>>      https://bugzilla.kernel.org/attachment.cgi?id=306251
>>
>> [2]: https://lore.kernel.org/kvm/ee027335-f1b9-4637-bc79-27a610c1ab08@amd.com/T/#u
>>
>> ---
>> V5: https://lore.kernel.org/kvm/20250103081828.7060-1-manali.shukla@amd.com/
>> V4: https://lore.kernel.org/kvm/20241022054810.23369-1-manali.shukla@amd.com/
>> V3: https://lore.kernel.org/kvm/20240528041926.3989-4-manali.shukla@amd.com/T/
>> V2: https://lore.kernel.org/kvm/20240501145433.4070-1-manali.shukla@amd.com/
>> V1: https://lore.kernel.org/kvm/20240307054623.13632-1-manali.shukla@amd.com/
>>
>> Manali Shukla (3):
>>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>>   KVM: SVM: Add Idle HLT intercept support
>>   KVM: selftests: Add self IPI HLT test
>>
>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>  arch/x86/include/asm/svm.h                    |  1 +
>>  arch/x86/include/uapi/asm/svm.h               |  2 +
>>  arch/x86/kvm/svm/svm.c                        | 13 ++-
>>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>>  .../selftests/kvm/include/x86/processor.h     |  1 +
>>  tools/testing/selftests/kvm/ipi_hlt_test.c    | 81 +++++++++++++++++++
>>  7 files changed, 97 insertions(+), 3 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/ipi_hlt_test.c
>>
>>
>> base-commit: eb723766b1030a23c38adf2348b7c3d1409d11f0
>> prerequisite-patch-id: cb345fc0d814a351df2b5788b76eee0eef9de549
>> prerequisite-patch-id: 71806f400cffe09f47d6231cb072cbdbd540de1b
>> prerequisite-patch-id: 9ea0412aab7ecd8555fcee3e9609dbfe8456d47b
>> prerequisite-patch-id: 3504df50cdd33958456f2e56139d76867273525c
>> prerequisite-patch-id: 674e56729a56cc487cb85be1a64ef561eb7bac8a
>> prerequisite-patch-id: 48e87354f9d6e6bd121ca32ab73cd0d7f1dce74f
>> prerequisite-patch-id: b32c21df6522a7396baa41d62bcad9479041d97a
>> prerequisite-patch-id: 0ff4b504e982db7c1dfa8ec6ac485c92a89f4af8
>> prerequisite-patch-id: 509018dc2fc1657debc641544e86f5a92d04bc1a
> 
> A gentle reminder for the review.
> 
> -Manali
> 
> 

A gentle reminder for the review.

-Manali



