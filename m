Return-Path: <linux-kselftest+bounces-24002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F61A044AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C977166B30
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D765F1F5406;
	Tue,  7 Jan 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MHIMD2ns"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165361F37A7;
	Tue,  7 Jan 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263964; cv=fail; b=VlUPV1odUC+au5p5YcIM+mRZnEnXUU6+jYJ8c1dbJe5xhUUg08Vab3hK1EhDkEnmFvrvvG21gguBHgJQZczIoggY5Bj7nOI0qEJWYmfAzw6sDf+G9XKu2bHsMGzq0cTTENF5bM4UJvSOR3Wz9h0KEeEUuuhmHTkJqAdpiWYb9VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263964; c=relaxed/simple;
	bh=qnuZvMCdlxFbIQE6nuVLC3uFJmgQ6KHabVFIknakxL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F+2ujh8c4wjCgiqRY0mWU626P720foil7oBVPtxMIKfwBjIdgvhBu2jhSl9J4HETNZBmbMoeDoG+dYdoXtDOFI4/u+YfDG/A+nlLreWGSOg3rco5T04YPjGAATsm9XQCz8j88lqLCAPUxDZazYzLkaxUBiTmB30nJlqNPdDGAvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MHIMD2ns; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIGj0efPaxN+MxzoSXHfC+45XJ8U927RiCupW+rI7HcXySfvm9x47i3JTTb1P9LaE8kzgMRYbMJq4i+yNsJ8nNydbWBA8fi7lsxYLb+v4Nwrky5Q3E7HK1EkQ8uxDTsbzVvM6MdLieaM0Os7/NziagOK2qouTvXax7DJi7Biihakm9kmngrJWjDnbZbJKirDFnipDe7w4o3EifWijMYO/HvhsuPboRVXzMLGMCU8/8wkwL7udgpEFBx21QMsdWxi2iOWcZl6iFRkNjvzZ75QAc+RVmZsuioEUvLmNWad/DpUSBQiRBKioRCqdkyjiOZdLqFI7q0Eek8Q1tkTj8otXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gklBvInzl09ze+mRKpe+6oavCtLLUI1/9yBvqe5KIYI=;
 b=ZjkEkTnUa+Sfpxp2bsXuvEETEAmXBVf99Lk3RJHdPofHsuNEnDF6f14hfxMEX9vG5cUVuPaY/9PhB3qUFKgBCwt3KxighqS65qL5lppYmj/O9PGq8IGSriLdqzdU7fqJl4UKsIOVYplX4RvnRHbGOspj2oQ1ieu9BGv8fUPxcJcARsS3QT+OyeGSUCx78XSMFMcdZqmXMZ/orGP/BzbLRjBj7ESY82hMsQHetn1V9y3rQJIcWHRXelcmbHFjyqkgYHmodDPFewnuspDMMYOxadAeWy1WbpIUZ4oS3oG79VSOPm8RdWOUAVcy5hy0GcM/uTibeyTNc6JkrMr5T6pCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gklBvInzl09ze+mRKpe+6oavCtLLUI1/9yBvqe5KIYI=;
 b=MHIMD2nscuO5rDT2dyOI4HgF+thjp9vHpEAOgGPhwM5Hi75hi+4+HCp0AWBVtw7NTx7S0QMq2SI2Ycnwn+5zqwUFj49yr/zkFgALPcLHhKfaTLmxqs3VvMJ2Wer6JsG05USe1nWrnMx0+3MZt+56rJpNwv1sgM7zrS6OBMzCqbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 15:32:27 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%5]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 15:32:26 +0000
Message-ID: <fbbec71d-118f-4abf-8c1e-22c966c0ffbf@amd.com>
Date: Tue, 7 Jan 2025 09:32:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Basic SEV-SNP Selftests
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 sos-linux-ext-patches@mailman-svr.amd.com
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
Content-Language: en-US
From: Pratik Rajesh Sampat <prsampat@amd.com>
In-Reply-To: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0183.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::8) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 3128e2ef-f621-4061-f77b-08dd2f307d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3BvOHdiMkZYUHNLRVpYaGZPS2NnZFI2WW4rcW1paWxUdEdZOFJFcFRXbkh3?=
 =?utf-8?B?UkVvNzNUbDNQcUEyTWtMTVkrQ2tmaFZIRTUzOFdjM3MzZmR4L2hoU0xucTFl?=
 =?utf-8?B?ZXh1eXEzdlFzdUFqb2Zqd3dRdUpnTUdoUG9SblRrZ2xtN0ZXZlRKcXgzMDJH?=
 =?utf-8?B?RktZWS9zZ0l5Sk9ucVFOWXRWaEwrMncyVFN4VGsvanBpc0NPZnl3QXJsMTBO?=
 =?utf-8?B?NW83ZEtmOTFEc1FDU3d3KzZ6RThPWmEzQVJHSmNYZVVGdkVkemd3dVlxNjFB?=
 =?utf-8?B?TVNGUnJNVFpqaFlkUExja3RBQlRWbDAzRzNiWHdKbWhWeDI1WE9vREFyRno2?=
 =?utf-8?B?YWo2YXFDb0dpdkNPR05VRVFkRjdXNTlOVFJrZ2MyVXZNWTRuZEdxcnZnMC8w?=
 =?utf-8?B?bHJTNm1STVRCdCtJbUNjNXNValFlUW4vNUpaaWd0UGdNRWp1aFgrUUJhTzJW?=
 =?utf-8?B?M2o3Y3ovVHY1WGZ1aHY4VTR2WEZnNDNmRnlWenhzTVlGS0xVZEllcGxyTzJa?=
 =?utf-8?B?Z3lrV2k0aHNndzAxK3psMGtQc0tqZkNDNjZhcUQrb0xwQ3JVV2NkZE9NU0Iy?=
 =?utf-8?B?L0NJVTNoTEVEampYcFRqWm1ROFlQUks0d0NaUnZUR1FZaEY0NlhxaVJZZHZP?=
 =?utf-8?B?RHBXNzJWNUxZNEIrU1JtNUVTL21BYXB6LzZRNWVTRnBYMlhub0VHZndqOERn?=
 =?utf-8?B?bktsRTYxQ1VzNkF0K1F1MFdTb2pKZDZHYzdmU3B4aERYYW1mQVkva0xFQUlX?=
 =?utf-8?B?c3ZMcWFyYVY3Z3prTE5JYlpXSngyWUhCM1JXdTVHOHg5c002QS93L2NHL21o?=
 =?utf-8?B?SnFtQ0M0SVBONnNpaHlXQjlJQzA0aVpFTTU0RGdoRFlqR25wVlExUkN3bHF1?=
 =?utf-8?B?NDJENk1rcGlIWTEyMzJ3RnJsTHgySzZ2RlJtMGJLOWxqY3NqK2FvKys1OGQr?=
 =?utf-8?B?bUI4MWl3RjdXOXREQXZVQ2dyaDdHcG1uQXVobUtZbjVhWkQ2MlAwdjBWLzd2?=
 =?utf-8?B?aUtaMWxiMTdUZDc3c2hKbm9qbEIzaERLTXMzZVUxY3lTOVpyQ3pCSnVjbnor?=
 =?utf-8?B?ZitJRGVCa1Q3R3BZSVN6M0taUnJCVWFMYWpqMVdHOXQ4S1g2b0JxRVRQZXcz?=
 =?utf-8?B?cVV6bmc1clhSSGQ3ZGdjZmdOaUVvdm04ZzdaS3lEQ2dTYms0YW93bkEvSVRk?=
 =?utf-8?B?YmFqNldxNmxrYTlUcFVZN3BuZ3hWcmlwS00reURHdFU0WXlhUHNxZFdadXFo?=
 =?utf-8?B?SG9QTloyQjlmMEorOU5zYWdNVGdIOWlETFBuZ3FKU29oYmN3MXhsdHZmOE1m?=
 =?utf-8?B?YkpmNTdFZmw3aXBKcTFCY0JyRFlpRE9vVzNjUktwa3B1TEl6eGJIeDhNaDBE?=
 =?utf-8?B?aEFTMXkxdk1KVXRJeFNmcnRsV3JkRmlDVnVYeSs3WmRXKzdVM0xlNURpa09y?=
 =?utf-8?B?YmVLOHAvaEY3OEJ2YlR4Q0FQWjNSR1NVRmxwajd6T1dabHBpRjVpTnpHK01Q?=
 =?utf-8?B?ZE9MZzFrbHNoMmFidUdHSmRJdzdVdkNrMW1kTkt5cWc1bTBQa1NYR0RrOHRy?=
 =?utf-8?B?V2hDV2VENmhqS1dVZFZqbUEydlJLQjdzMndpQkhwRkVKTTZhVFJEcmZvVjc0?=
 =?utf-8?B?dmVyckFkVGV6NC9xV25JWHN6NzdRMHZ0T0xuZ0VlaHJacUFxVUhXR2ZoMlF3?=
 =?utf-8?B?NjdyZGR6aGJHWiszT3lGOGZTTGdpQmJnT3F1TVcxbUFJcG5qclF4TDNQbENV?=
 =?utf-8?B?UFhlWlZWcTJETGpHUWNOYXdBL0lZcVBPdUVQWWVlb2dDSEtuNzBWNFoxdlJV?=
 =?utf-8?B?Z1FuTFdiTjU1Uk9yeVYzbmZlZjI0R0g2cDB1Rlp0MWRxaVMzdnN4QzJqL1lL?=
 =?utf-8?Q?wpRaeC842kOi3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHhoQUVseE1aUUdjRlFUbmtieHRuRXowcWovc2p6UzlqSEFZLzBneWNjYnV6?=
 =?utf-8?B?aWFYU29MY1N5NGlkOWJzY1ZmSC9vZ3Z0ai84R1cyNTJINm9BZnpPK29ZSW8r?=
 =?utf-8?B?K1dlQ2RsekJDQ1UxQ0d5Rmg4eTZqbzVYRFpxWDd6cVpaZTRjb2Q1cER2cURZ?=
 =?utf-8?B?TWl1c0s5WERXWlNrM1RWL0dtUzBiRk1icGV4eXJPZzlBY2h5MXBMMHBPNjlY?=
 =?utf-8?B?TUhhb0dlV1Brbk54cjhJTW1rbXlYQXRJbm80UDR5ZTVSOFJwWEVpbjNSZkpn?=
 =?utf-8?B?R01IRjYyS2VZYkVZZlNNOGd0cnRvMDdvM0hJcVQxTFNLSCtFbkVGT0NuSlQx?=
 =?utf-8?B?cnBqVXd5UnNWVkwvUVBaWEJqWW00N1JFVGh5TUhjMUJ5RXNoYTk3ZC84a0I1?=
 =?utf-8?B?MXBCb0xxSGkwYzlXMDBOREQxRVdhdjVJUEtYNFNHellPRmo2ZlRFaXpHVERi?=
 =?utf-8?B?TmQzalY3enVsc29SY205T1NyS09WWjk3UG01aFA2Z3R1SnU2YzhVbEs4ZDZ0?=
 =?utf-8?B?cTFpK0srNEtwZmRTbFo4ejllZ3p2dG9KYUlJOTJmZkVpalFWVU1zaThxYS8x?=
 =?utf-8?B?UlphNlJYbTg2WWlaQ2tvbjF2NUNBbmR3TlJWU0Z1SXFKSURyTkVuS3dlTmN2?=
 =?utf-8?B?clVMNDg3ak5qemx0eDBob21qVHNWSCtLVDlHaFJtbEhsTHVtcmJYU2FpbEJx?=
 =?utf-8?B?eHluTXMzT3JUaVdTNmJTOG5QVDVvbmRiN0V2Nm5ON29GNm9Cdm0xbkNkZEVD?=
 =?utf-8?B?dUs2Rm0rQ2F1ME9FY0ZqK2VGdFpPNE1RL2VSOHhhYVV1TEk0d2pXU1krbUJ5?=
 =?utf-8?B?SFAweEprSmJhWklldDQrQ0huYmIydHlvUWh5djRXdlFPYWRDdnF4K1FleXJa?=
 =?utf-8?B?T01kZCtlRHB6NVpQU0ZUS0pJdG9qby81QXJITmZIMSthNlFLdHVtUDR6Q3hm?=
 =?utf-8?B?YURYR2hvY0ZHdXdWSmFSK0RjVnFXTk1peEp4V1NxSGxEVHQyYlVtUEpNOFhw?=
 =?utf-8?B?TGtpUmkrK1VvbGxSRVlmL1NhcFhHamp1ZmsxZjBQWWdUcEhQcmtjNExwWTU3?=
 =?utf-8?B?Tk5XN2dRUEFhVjZTQTB0RGZsMEZTQnQxVjAzbjFYNzg1aWNJWmtmMEVRdjZO?=
 =?utf-8?B?am5OQ1E4ZUVpb2VjM2NQdXNuMDA0bnFmZFhQZ3RqdVNGRkNjY2NDWGczcFF1?=
 =?utf-8?B?TTNoclB1eTNFajc1Q21WRGdlb2tpS29LSXp6b3NnNGt3THhZa0hxVXVaOVFY?=
 =?utf-8?B?ZlJ4cnlaSGVVNGN6eTVxNmNsQjNuRUF0YUlDY0MrdEpsM013NTFMVUJJcTUr?=
 =?utf-8?B?eS90TmxTRFdCdkNFaUljN0dPYWk4eUlkNDhYVXhWTHlpdHJtdWQyMTh3WGwx?=
 =?utf-8?B?UlE4aVV3MEpwbnl1ZkEvVDRMeW4zOUpUWFNIbHVLbjM3NUVINE1haVB0eDBU?=
 =?utf-8?B?UkNTall5dllCTXQ0OVM3ZmRSZ2FBZGVoRDQzOVJLeFJEZ3U1OUxrVXQ5Q1l1?=
 =?utf-8?B?Z2MrTE8zQXJWOUN5VVEyd1l0Z1BXZXRSMEFUNXdNVzF3d1p5TnZBdnc0c2JZ?=
 =?utf-8?B?bytBOFUvYlhmZlRPTHdPNGUwTWVBY1VpZ2xqc1hBRUQ0MDBMY1RtTGFJWmtY?=
 =?utf-8?B?bVNKenpJa25TMmZ5cFhhb040cnhIRkdoSlFnRVJQT0xDR2gwWFdkcnlITXY5?=
 =?utf-8?B?cENDc1c1aklrSjFTUVlydlUxb0duVDVTRk01SXNCc0c1a1o3dFBjdFZMV0pv?=
 =?utf-8?B?cFNtVWVnckpadU5ES3hVU242UlRRUFZiUjdIanEyN1ZqMGhWR2daUjE3ckNM?=
 =?utf-8?B?b1BPU204M2l0NnQ0V0N5Y1N2OVJmY2tOZW1rR2drSWFJejdVUDR5WHVBWnBE?=
 =?utf-8?B?RDlSVlRCUEZuQU92SGkvclZGL3ZGUm9xWGkxbFNrNWNHVnlseDN3bnZ5TUVH?=
 =?utf-8?B?YlB5T3REKzYvVnZpc2NIaEU5N01PZDJDZ0MyYzV1ZTlrbjlONUV2VlV3K2xF?=
 =?utf-8?B?ZTh0VTlvaWJKQm1HTGEzd2gwcXJ1UzhjazFwekpEQ3puUnlUYXVranBrQk1M?=
 =?utf-8?B?VXFTeW1IenVVVzI5UG40RHZHbnpjMU5Sb3hYbll4T1pLYk9LQzBMdnJ0Z3Ew?=
 =?utf-8?Q?uh515XCRqxrbY5HOvdd+gfizM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3128e2ef-f621-4061-f77b-08dd2f307d66
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:32:26.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ba3TVW+48UNcp0PaWfE4N4r16v6ogCxscSbBdJmh6IpU30yPmPHXcnpyNI43hx6aQdVdNysYTIEuw6nhXIXuoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644



On 11/14/24 5:40 PM, Pratik R. Sampat wrote:
> This patch series extends the sev_init2 and the sev_smoke test to
> exercise the SEV-SNP VM launch workflow.
> 
> Primarily, it introduces the architectural defines, its support in the SEV
> library and extends the tests to interact with the SEV-SNP ioctl()
> wrappers.
> 
> Patch 1 - Do not advertize SNP on incompatible firmware
> Patch 2 - SNP test for KVM_SEV_INIT2
> Patch 3 - Add VMGEXIT helper
> Patch 4 - Introduce SEV+ VM type check
> Patch 5 - SNP iotcl() plumbing for the SEV library
> Patch 6 - Force set GUEST_MEMFD for SNP
> Patch 7 - Cleanups of smoke test - Decouple policy from type
> Patch 8 - SNP smoke test
> 
> v4:
> 1. Remove SNP FW API version check in the test and ensure the KVM
>    capability advertizes the presence of the feature. Retain the minimum
>    version definitions to exercise these API versions in the smoke test.
> 2. Retained only the SNP smoke test and SNP_INIT2 test
> 3. The SNP architectural defined merged with SNP_INIT2 test patch
> 4. SNP shutdown merged with SNP smoke test patch
> 5. Add SEV VM type check to abstract comparisons and reduce clutter
> 6. Define a SNP default policy which sets bits based on the presence of
>    SMT
> 7. Decouple privatization and encryption for it to be SNP agnostic
> 8. Assert for only positive tests using vm_ioctl()
> 9. Dropped tested-by tags
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
> v3:
> https://lore.kernel.org/kvm/20240905124107.6954-1-pratikrajesh.sampat@amd.com/
> 1. Remove the assignments for the prefault and fallocate test type
>    enums.
> 2. Fix error message for sev launch measure and finish.
> 3. Collect tested-by tags [Peter, Srikanth]
> 
> Any feedback/review is highly appreciated!
> 
> Pratik R. Sampat (8):
>   KVM: SEV: Disable SEV-SNP on FW validation failure
>   KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
>   KVM: selftests: Add VMGEXIT helper
>   KVM: selftests: Introduce SEV VM type check
>   KVM: selftests: Add library support for interacting with SNP
>   KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
>   KVM: selftests: Abstractions for SEV to decouple policy from type
>   KVM: selftests: Add a basic SEV-SNP smoke test
> 
>  arch/x86/kvm/svm/sev.c                        |  4 +-
>  drivers/crypto/ccp/sev-dev.c                  |  6 ++
>  include/linux/psp-sev.h                       |  3 +
>  .../selftests/kvm/include/x86_64/processor.h  |  1 +
>  .../selftests/kvm/include/x86_64/sev.h        | 55 ++++++++++-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
>  .../selftests/kvm/lib/x86_64/processor.c      |  4 +-
>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 98 ++++++++++++++++++-
>  .../selftests/kvm/x86_64/sev_init2_tests.c    | 13 +++
>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 96 ++++++++++++++----
>  10 files changed, 258 insertions(+), 29 deletions(-)
> 

Hi,

A gentle ping on this patch series.

~Pratik Sampat


