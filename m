Return-Path: <linux-kselftest+bounces-23783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735879FE322
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Dec 2024 08:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C065C3A1166
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Dec 2024 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFED719E965;
	Mon, 30 Dec 2024 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MaBAEyyb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE342F44;
	Mon, 30 Dec 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735542626; cv=fail; b=qT6TZ2Z3gfHfbtOpgVqLLdaIikrenGqQn820ptcJ98BTtIsChQdg4WTOR4uO53A3jivifTtnxdesCec0KlZGcBkjYOgC39RMsxtMIk60N1uom88JbMvSCSPQ0rXL3UNFet8gHAKCYc871RIpdOKHgc71LGAb7gKwxr5t89g6RtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735542626; c=relaxed/simple;
	bh=4hxbwcQVeJhBOFiPSxkINQR7lxKuSn8vziWqPJlwRYc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJmWeNhEBKnianA8nfnuTAtVS6FBAxcdsrYJfdJtfMgsBlu0+eluOg3L7r2HrzXABhhup1n0KcpYhAiSBB9LkLl+aQNaGObqOewjqAik3gS0LvYfPeZzhzK9/dzozRAuRQXGh12QDJZIWveS3KVKIQ6wv4T5iJ06nMoCjRJNi4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MaBAEyyb; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkwmDDLLCJBMdvFdznSkASCqI/MnEOsxaUubEmMnRXYZSHyiXNL3aY4ZRFWaJyr3SflDSLy4KcnDoNR9hNocRAC9b4HJziOdBVnCw8m/qqgwNpcZ3Xn08a7DIgwzEEuiXz0oWg0ko13WzLwRouc+/KTueicIUzxtTYhfAlBxkcOsiPdlk1YrD833VaxtUko1J7aPXGuorrAnQMBZmsB3p3R6D4u/gSkj7fC2OuAy2iOYpgx/AQZOFlO2ikU1fM3sl01JL95xDRbjHnV+Zy++nzG1kuiFl3N4TuVQgRM0cycCM/f1Ew1ibwPcavNRhAoGIbHQGCXp+d1ZvPyLUiYJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQWVedaJ63+6pwuVgHhCorM+L/EuxNqFc7W69rWdHtI=;
 b=LDqVgbvXmC/goGhEDXkrQb568XAAZnKxqpaBSPqZ6F13AD1mL0YSjewhZizt329EMR41MQcDsFbtgzC4kAkcjyj85HEIqfHVsHDPus+YH6pspyKXVjqwx8AnHB1HYsBtCdGSRiEawKmY/YzqLGcA+mCPDEjh2ZE8O57RwX029VFj66QZH4AYesNY3IadTn/emB6lvownq0zA9f3uCAdlA8aiuWL4pPRYIyLPDu9W5agua/eMXlsIoXss1T+bCfnPNa9RPmOiEte4orvkDcv/OCeWZrxWvB3ULnjkEUK3wgzqJM6Ifu+tWB8hLx7dqbQeFw3lYWEGhpyIhQpXifItrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQWVedaJ63+6pwuVgHhCorM+L/EuxNqFc7W69rWdHtI=;
 b=MaBAEyybkvBWPaTh8vENN11TnpS3WNhjuniN2IWi7ScTOe3MBg+eozsP3+cB87V4V5J9YeZi/gFsmPhBc/VK8sKv0dh0Z7TWHLwzjOy83PmhphcPz3Q/WWi/cCE3x5ynf7tJX3799bniyO9HfjwiDjTlKJvZqpfDaQ6OWZBDiuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Mon, 30 Dec
 2024 07:10:18 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 07:10:17 +0000
Message-ID: <1cc5976b-dc51-4d4a-93f6-e8a30d4a449b@amd.com>
Date: Mon, 30 Dec 2024 12:40:09 +0530
User-Agent: Mozilla Thunderbird
From: Manali Shukla <manali.shukla@amd.com>
Subject: Re: [PATCH v4 4/4] KVM: selftests: KVM: SVM: Add Idle HLT intercept
 test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20241022054810.23369-1-manali.shukla@amd.com>
 <20241022054810.23369-5-manali.shukla@amd.com> <Z2THNLATHFyEw01j@google.com>
X-Mozilla-News-Host: news://54.189.247.149
Content-Language: en-US
In-Reply-To: <Z2THNLATHFyEw01j@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb68f4e-34cc-49b7-e6cf-08dd28a103ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2FSejAzYW1JbkVzckdpU2VFZWN3TEpDaVdVZFVUZUltaTl2N1FxbVdob0ZI?=
 =?utf-8?B?aEFCVjBuL1lVOThWSXZjamI0bXhCWjZZckNxbHhIdWIyT282Qis3Z2ZPaVRZ?=
 =?utf-8?B?QVdDUkplWkl2aDVDOU43RE1YOUg1ekYydk9yU1FNOGtWK2FqK3Z2dE1kUUlF?=
 =?utf-8?B?Wk5waCs1dERsVkd5bzRCUG03TThtZUpYQTJxZjlvN29ocHpmL1FESUtHNDR1?=
 =?utf-8?B?dVBzT05NdktuejFmOUs0WmNleHBHYkRLMkpwQTRubDJveGx6UUNPTk1zT08v?=
 =?utf-8?B?MjVLdGJmQXVhM2RqYnByUGhFSHBXY2tzeGh0dWJ4c1N3Yi9DaTFsMTVXYVU3?=
 =?utf-8?B?Y2d0dmxIT3c5SldETlFSd09Rano0WTVJZGtpMmV3K3lYQXY2RzhsUm8rQTJR?=
 =?utf-8?B?UmVKM1ZCTDYwN283VHFnYXZkdUlSelFzWWdZaXI5eGorL2g0ODFHVWNSR0VJ?=
 =?utf-8?B?U3pZTnoyM0VodnY5M2syT3k4b3JENlI0aGtLU25HU2dWa2RteUhCQk8wTkdo?=
 =?utf-8?B?V242NWxvR2JrNmdocEV1L0o3ODlmcWNEMGIxWjF5b0Z0dUY4UXdQSXp3cER6?=
 =?utf-8?B?cHNKbURVY0s4REJVOFd3cHdDZHNaRW4rRlUyRmtXTjdtWFh5UHREM0NCUkNy?=
 =?utf-8?B?ME5CR0l6TjFpditqYUtsdElkbEM2aEp2Z2NnbzN5Rm1TZ3d5NEY1cU9DKzNP?=
 =?utf-8?B?Nkd2eGlhR1FSbm9kc0I4NUc4ckF4cmN6andmbS9PcDIrUTRRd2ZCcTdXV3ZV?=
 =?utf-8?B?cWlGbFE1OWwwVU43OVdGNmx0V1NqQmJzU2hBZ3VQUTBSM1NBR1BlZEpMQXJo?=
 =?utf-8?B?NHpuNFkwZFRuUmhGQi9RZmlIZ25lTWsvMEV6eVFrRm9VWWZMVFVsbU0yUGY5?=
 =?utf-8?B?bkZsMUhhMi9NdDhNTThydG9GTllPWURUOS84YkNaSHk4WWo1MTNLYkJIb1JC?=
 =?utf-8?B?UjRZeWVmOGNEb0piYzZGTDJ0WXlkMDBiVjZCSDZtQ3I2dllXTGNBU205R0Iz?=
 =?utf-8?B?WVV5a21Id2xEdkJvNU5iNEdSN00raEpGaTBmd1FFcGNPbEc4aGFITHpVTmlw?=
 =?utf-8?B?Z1MxVkxwYkVYSXJxTjQwMVlBODZMeE5pV0xiNkFISjZGRXRXM3ZIaWFoUEJJ?=
 =?utf-8?B?Q3hNZytPS1RDYlpzU0QzOEkyUnJhYVZWcFRlZ1RFTlh2cFpyWUZWMHhPeERa?=
 =?utf-8?B?THlRZlk3ZnlRTFlRSG1QeDF1UVdUOEtCOGhzS3VrV0l4U3l3YXIzTWY3YnVo?=
 =?utf-8?B?bmxZLzMzNFpsYVF4YVlKYUsvZFhxYWF2UnRzME8xQkhPT1JxMWdJc0tnLytR?=
 =?utf-8?B?SU94ejVmdmR0L3U3MnJQTXpaZ0dkNytRWGo1UFJKOFdVNncwUnpsVzBMbThH?=
 =?utf-8?B?TVpFaXJla0o4VC9zNXFWVENmUGExYjdNNFU3RlFIcTY5cGhvL296WDI5NDYv?=
 =?utf-8?B?Ky9QTGVqRUF6bWFyenpyRHozMml4NWVpcjZvRm9BdlVhTjhuTHRkTVkyM3JE?=
 =?utf-8?B?ZjF4dnZWaDBqY1hsSFdFb2kyUjdMampZMCttVXJXWXMxVXlOSzFnYXJpOGpn?=
 =?utf-8?B?U0tkUUx1Mi9jZ2gzTllMdEZpTEovRDZya1R2L0JBZ3FyQ3FCR2tMQ09wZnpN?=
 =?utf-8?B?RE1KYlI4VlZqRlMxOHlzZGgyYm5YTU01Si9mYzVPZjhJY1VOZDh5d3FKMUxY?=
 =?utf-8?B?Rzd0a0x6YWtHMEh1SzFkUHAzL2F1RVBwbFEyTHYrL0trR0lKZzdzYmFSVUFm?=
 =?utf-8?B?MWhnaHJ0YnhzMVFwb0M0K2dtL1NKbjQwdzJ4RndkTWtlZlhpWGJGd3JMRUNS?=
 =?utf-8?B?N3VwWllCY1ZKN21jcHR4MThUdnA2NGJaSE1QYzR0UWdCTys1Qk0rbG1VVmFv?=
 =?utf-8?Q?plb6yxaiJ/urG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnBLQTVIOFpCSm85bVNwbUh1cVMrdXdnVVNHRXo5WnNMd2g4MnlPN2VyUEs0?=
 =?utf-8?B?d2hMSW9MSkFaQXJwUU1neGVoR2g1ZWxuOVlQUDNOWUg0NWY5bVZFN04wS2xk?=
 =?utf-8?B?WmNCbVplTDJWVnQrb2M1T3hib1BxMjBBVzUwQlZXam9ibkFvY2xveGRLeFJj?=
 =?utf-8?B?R1QzaGJyZm5oRmtYMUNKZDl1WGFMVGliNlNMUGJZczBPeXlwSlFBc1RzY2hj?=
 =?utf-8?B?N2wwMTFNQkxWNkg3SlJxNlRncTJlRjdhdlhZcnlNU0p5QTlTL21LWlVYeTdq?=
 =?utf-8?B?VVVxR0F6WU5sYzI5eXhOMWk1bmFHbHNEeFJlVFJsejNQejVVK2ZFazNpRTZV?=
 =?utf-8?B?TTdPSlRnTkg3MWRsekwvQ29ZUXJxRUtHN1ZzOGdKSTMrd1FYb3hTbFhhVDg5?=
 =?utf-8?B?VjFnQWZFZFdLRDVpeENybWplYitzWXRQL0ZCb1FFUDc0aHZzTnZ0OCtpeDVP?=
 =?utf-8?B?c3ZPVHl6S3dFT0N5SUtoMmY5SkZ6dEljcHpIbUlicWk4SXdHeTUxMmJiT1hp?=
 =?utf-8?B?cU13NHBCMEk1dzVwL3VzS2lqMnRPTG5rMHlXQnpvTDhwMWxHTGx3T2Z2YXM1?=
 =?utf-8?B?VjRxYzJaVTdKd1ZQUDhEck5jckN6TXhnOVFFbitEVlZmVmkvaTBVelIwQjg5?=
 =?utf-8?B?ZmhjQmEyUW5HWVA0NnRIbnluUDdzd2IvcDZUVExWUW9pNll3REFZZWpHNTZJ?=
 =?utf-8?B?N3JVWlNmRlRBZjNZQ2IxcmM2ZDIrSVVQUFFtSjBqbk5MUjBPZFpiT3plN0lX?=
 =?utf-8?B?bGVvTHc3aHZYdDRTZHpFdzV5YXd3TDNNRWsxUHNXZHZsOHBmWStQTUhsVUJm?=
 =?utf-8?B?RUpITEdRUTc5UXpkakZLSE41WG9naFQreFVLck9BOUtFWE1GTVlBdVk5dGlM?=
 =?utf-8?B?QmNDYmdMeDRqcG9QbG8xOU9XMmdhLzRWVWp3UzdrZlhBNzhOZFFTdjZQd2Fx?=
 =?utf-8?B?NS90SnVJdklSbUFaMy9CQjE4eWZFSnVqYVJmODhvckZiSEpVR2ZmV2c1MDZj?=
 =?utf-8?B?NDQ2bTByeUZRVmdweG94cFhhczBZQThJa1ZmZ2pYbGVLc0E4dEh6bDlscFR4?=
 =?utf-8?B?RWxLVmh4UC85UkxzV0JHNEJCMml1azI0QVpxU2N1N0JIc0dmZk1JNlhOcE91?=
 =?utf-8?B?aGhyQWxYdXc5dnJCdnoyeko3RStYOUluOEdNR25PWTFpcEs1QXRNUkRnVVZ6?=
 =?utf-8?B?d1BmR1VmNmNCdHRBU1VQSmRQUlVFMnN5M3hQV0Q2cEtESmtJcEpjL2dYd2dt?=
 =?utf-8?B?a2lrMDgzVWY4TG95N00zYmROOXZXa2x5ZGsrMTh3MDZjTkFzN2VhUmF0VTMw?=
 =?utf-8?B?UWRGQlJZK09UTUNmNHBZSmdwWGhKQlFaMENLTXdXbXFOTHFOTmpxUHhNaU1E?=
 =?utf-8?B?eHkyNDFodGNDR3lLWmZRNmo1K0oveCtkNXkxZjBjZ3I0SnN2bnlEcUFSOVYy?=
 =?utf-8?B?d0MyVUNXclpUSmhKUTV5anhIOUFIa25lb040czNUSmV1VW1zUGszNWRLeVh5?=
 =?utf-8?B?OHJ2Y1FSaTJBUU9EVEFNRTl0VTBLZVEvdWpUeFk0bEpPbFNNWEpzOTJDQ0NM?=
 =?utf-8?B?VkVGcnlRendNYXh1T2RCQkQyVnFZdEhHSGM4a2V3RVBKWXJZRDFCREhpUnht?=
 =?utf-8?B?Qnk3Tkg0cFBzTjlTRjR4aDlSY0VXRUhtNVJIVmdXY29SRUhmcTlkMkNhcEE2?=
 =?utf-8?B?TVkvZUFFMzM4U05Wck1Mb2g5RnpNNEVHSy8yUS9rdzlNckZ6S3pvWTNrbk1p?=
 =?utf-8?B?UlVwSkU1bkpKSWJCRzkvbUNqSmJQNk94cUFCcXVmdS9PYlhZQVB1cU1xZWc3?=
 =?utf-8?B?TGRDK1N4TU5pTEgrOW9GUzA3TVAxU2hHS2tRUDF0Vm1DSm0rWlRDZ29CUmU5?=
 =?utf-8?B?c1lSdkU5QmJ1ZndENGNXQndRa2I0cHBydWFFNzFmbTVjZkY1bHpQSmloUk14?=
 =?utf-8?B?WWNrZGNEQkh4L2pHQnk2MVUvbGRrck1oV2ZSTmlDYWpmaFVISjMxOXZNUzZS?=
 =?utf-8?B?WWt2VmhFbFlGYVNWdmYzRzFrZ3k5NnRYYTBwVlFqNVhsZlo1aHJvRGhUbW5p?=
 =?utf-8?B?b2RSS0gvcDJGZGlEWi9wYzlCeFhqMW5pME5Jd3RwWnMwLzJKazFLTUJTQXRz?=
 =?utf-8?Q?ZIsbkb02iJCACp34ASdb0Gu4N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb68f4e-34cc-49b7-e6cf-08dd28a103ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 07:10:17.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa3OyTC8smXyA77uJXHM7vFbSKP4p15Q+f/SNk6WswfpRqHk3oI1VldcAbEgERaQozicq+O0b7szDsZpKbc/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

Hi Sean,

Thank you for reviewing my patches.

On 12/20/2024 6:54 AM, Sean Christopherson wrote:
> On Tue, Oct 22, 2024, Manali Shukla wrote:
>> diff --git a/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c b/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
>> new file mode 100644
>> index 000000000000..fe2ea96695e4
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
>> + *
>> + */
>> +#include <kvm_util.h>
>> +#include <processor.h>
>> +#include <test_util.h>
>> +#include "svm_util.h"
>> +#include "apic.h"
>> +
>> +#define VINTR_VECTOR     0x30
> 
> Drop the "V".  From the guest's perspective, it's simply the interrupt vector.
> The "V" suggests there's nested SVM stuff going on, e.g. to virtualize an interrupt
> for L2 or something.

Sure I will remove "V".
> 
>> +#define NUM_ITERATIONS   1000
>> +
>> +static bool irq_received;
>> +
>> +/*
>> + * The guest code instruments the scenario where there is a V_INTR pending
>> + * event available while hlt instruction is executed. The HLT VM Exit doesn't
>> + * occur in above-mentioned scenario if Idle HLT intercept feature is enabled.
>> + */
> 
> So the only thing thing that is idle-HLT specific in this test is that final
> TEST_ASSERT_EQ().  Rather than make this test depend on idle-HLT, we should
> tweak it run on all hardware, and then:
> 
> 	if (kvm_cpu_has(X86_FEATURE_IDLE_HLT))
> 		TEST_ASSERT_EQ(halt_exits, 0);
> 	else
> 		TEST_ASSERT_EQ(halt_exits, NUM_ITERATIONS);
> 
> Not sure about the name.  Maybe hlt_ipi_test or ipi_hlt_test?

Yeah makes sense.

I will keep the name of the test as ipi_hlt_test and make the test common
to run on all hardware.

> 
>> +static void guest_code(void)
>> +{
>> +	uint32_t icr_val;
>> +	int i;
>> +
>> +	xapic_enable();
> 
> Hmm, I think we should have this test force x2APIC mode.  KVM emulates x2APIC
> in software (if it's not accerlated by APICv), i.e. it's always available.  That
> will allow using this test to do performance testing of KVM's fastpath handling
> of handle_fastpath_set_x2apic_icr_irqoff().
> 
> Of course, KVM only uses the fastpath for non-shorthand IPIs, and any setup that
> can do self-IPI fully in the fastpath (via virtual interrupt delivery) won't exit
> in the first place (virtualized by hardware), i.e. there's probably no point in
> adding self-IPIs to the fastpath.
> 
> But maybe in the future I can convince someone to enhance this test to do
> cross-vCPU IPI testing.
> 
Sure. I will make this test work with x2APIC mode.

>> +
>> +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
>> +
>> +	for (i = 0; i < NUM_ITERATIONS; i++) {
>> +		cli();
>> +		xapic_write_reg(APIC_ICR, icr_val);
>> +		safe_halt();
>> +		GUEST_ASSERT(READ_ONCE(irq_received));
>> +		WRITE_ONCE(irq_received, false);
>> +	}
>> +	GUEST_DONE();
>> +}
>> +
>> +static void guest_vintr_handler(struct ex_regs *regs)
>> +{
>> +	WRITE_ONCE(irq_received, true);
>> +	xapic_write_reg(APIC_EOI, 0x00);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	struct kvm_vm *vm;
>> +	struct kvm_vcpu *vcpu;
>> +	struct ucall uc;
>> +	uint64_t  halt_exits, vintr_exits;
>> +
>> +	/* Check the extension for binary stats */
> 
> Pointless comment, the code below is self-explanatory.
> 

Sure will remove the comment.

>> +	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));

I think this is not needed, since I am planning to make this
test independent of idle-HLT as per above comments.
> 
> This needs to check *KVM* support.  I.e. kvm_cpu_has().
> 
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
>> +
>> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>> +
>> +	vm_install_exception_handler(vm, VINTR_VECTOR, guest_vintr_handler);
>> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
>> +
>> +	vcpu_run(vcpu);
>> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>> +
>> +	halt_exits = vcpu_get_stat(vcpu, halt_exits);
>> +	vintr_exits = vcpu_get_stat(vcpu, irq_window_exits);
>> +
>> +	switch (get_ucall(vcpu, &uc)) {
>> +	case UCALL_ABORT:
>> +		REPORT_GUEST_ASSERT(uc);
>> +		/* NOT REACHED */
>> +	case UCALL_DONE:
>> +		break;
>> +
>> +	default:
>> +		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
>> +	}
>> +
>> +	TEST_ASSERT_EQ(halt_exits, 0);
>> +	pr_debug("Guest executed VINTR followed by halts: %d times.\n"
>> +		 "The guest exited due to halt: %ld times and number\n"
>> +		 "of vintr exits: %ld.\n",
>> +		 NUM_ITERATIONS, halt_exits, vintr_exits);
> 
> halt_exits obviously is '0' at this point, so I don't see any point in printing
> it out.
> 
> As for vintr_exits, I vote to drop it, for now at least.  At some point in the
> future, I would like to expand this test so that it can be used for a rudimentary
> IPI+HLT perf test.  But for now, I think it makes sense to keep it simple, e.g.
> so that nothing needs to be unwound if improvements are made in the future.
>

Sure I will remove this pr_debug for now.
 
>> +
>> +	kvm_vm_free(vm);
>> +	return 0;
>> +}
>> -- 
>> 2.34.1
>>

- Manali


