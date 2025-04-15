Return-Path: <linux-kselftest+bounces-30834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13876A8975B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE3E3B6B4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8F275107;
	Tue, 15 Apr 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LaaKi+6L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1E1DE8A0;
	Tue, 15 Apr 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707798; cv=fail; b=uLXaalmP7htVeX4l5vsuRGZVC459RL1mSUXoGpyhg+olx2WS1s+rENzFB7vLRgt55Ebflp8K1Hs2oZHkiyXnwcgFQ+D2axuFYvesbCkgTvRZwv57h6XMM/V7xJLcIoM+nB3Y8QD4VkTQCkFrLQFNEAORzSOqOn0YVqjIi+LzkqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707798; c=relaxed/simple;
	bh=oTl9UZkIYCNYkFFfYk659AUBbE6sx8KUzALLWIzIiA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YyCqiQYPQeno5dap9vxUgB+7KWd/MOlmFyxo0Ar6kJg4S6o8xdmMikTrqIKxz1KzU3MOj2nH/qiVk/h1ndfQNst/iDbpJcckmeXc0tSso9v0IuCO6Prp0ZIWFVwo+9bMhEb4ZIbv5D3czca4sf4CIcaI061ERj3/CwfuMTRIm2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LaaKi+6L; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPxrGfwX+kfiBkNhH3ADsV+TYED26MGVBQ6YupXa73HxG6Txz4Z3rvEPGxWO+S8u/YO1541g6WKhv0NkXgRLS1R5iOj/B0ZStRVu8h+7G5FWifnyCupHG3Z9rP+yEEZ4ySEzgLz8yrPxLRxOx2dLfboakT0h6CXbrkCO56MlCrMee/qmSebZbG19z1aH02XlH0a6dgFAl9kDw23yGDe4UpDfD3PV9HyvE8AuoE+8oKJeTVnIs+u2sEY2TknUmzkJoB3PWFfDjjDZdzqYOiPRwrWi4Yts1TjRvhvLUZ3+b0g4FDCIqx6G3skzOJTEXAZj5WSdKf4nBx3ifn1yAoTjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPui5XTIbJxAqfJUuvtVo0pM5WZSfhQ29CX9ENnXIh4=;
 b=gZkBm9DDfpysVdetsa45YqsnzSswkRzjV3jc3vuSD0ecyoRzmnWhvFyCXPW5HgB82CrGdLe8ccK/843SWODdKFQu+GEUc6puykZ6bIa0NCU/Q2M8WOMlDXEcaayGxwPKhenYUpUgiC3VrqN1E1CI4Y8IsKQWxT45TkSVejRFHiPbY+kruEAcZIr8jbUwuOWVfC3/5Tm0O6ghAGvOclkpns1HgjCayCavl/lgmLqPHmDbTgtM1ENQ6uOY24AlK9ZuedG3QVKt6yPfrT1pTeUeQVYm8ilVJ0CwVTPFTfWVqVCjusLC3TBs+cCnikQEVC1xo0HmGnMM2+WjhKeMEw6epA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPui5XTIbJxAqfJUuvtVo0pM5WZSfhQ29CX9ENnXIh4=;
 b=LaaKi+6LbALtHanedG0xxkN7e2yhRiP0DUP0//7dFaPuRBUwl1N+Nc1pLZYD/TXkEXU4ar/T0tNxSD6OsqBhyNI0Qq76YpLPm+aq1T2A7fR4C3KbtfZrMlERLA60IMdqR4o3y5ZNQeRFL7BIPZz4E5ZCoAdMWSSTaFKppCSJvcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.33; Tue, 15 Apr 2025 09:03:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 09:03:12 +0000
Message-ID: <1d94316f-3336-4d40-bd18-e4703c7037e8@amd.com>
Date: Tue, 15 Apr 2025 11:03:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Replace CONFIG_DMABUF_SYSFS_STATS with BPF
To: "T.J. Mercier" <tjmercier@google.com>, sumit.semwal@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch,
 corbet@lwn.net, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 jolsa@kernel.org, mykolal@fb.com
References: <20250414225227.3642618-1-tjmercier@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250414225227.3642618-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7e4921-ec18-4153-580d-08dd7bfc5974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXVjZlZBaGhySFlLQWwzMldKWmNHVUI2YVNmcjR2bWJjR00rVEhpSVUxakVW?=
 =?utf-8?B?RTJobW1PQ0lSSDdtbDBZWmk5dldadExNNzNDNFc3b3pqYU9qWEZwTlNUaHFa?=
 =?utf-8?B?OHdxOWJMSzc4NTNOQytYOFZ2eW93RDhuK21IM3BvQ3JPZ1daKzhVSUNRcmhI?=
 =?utf-8?B?eGFkWUhtQjc4MUhPSHQ1dDYxbUM2ZXJnRlU1NE4wZ2FaVGw2cGozS1UvNFhw?=
 =?utf-8?B?TnhTdWZzK3VIZFJ5UEJtSTgxbkJXbElSUStRcEYvY1ZaeHZqaEtKK3lkSmJB?=
 =?utf-8?B?R0p6UUZrcm9qQ1hqNGU2dzRrV0xsWlM1a25YbktGUlNraGNlYVJVcHpvcmZC?=
 =?utf-8?B?Qi9VbFVwRldDRmt3RnZXNEJnVi9xRkxnV0FQUzdkQWs1dHVWRy9GckNtQmdC?=
 =?utf-8?B?Ujk4ZUs2ZVo5Vyt3R0tPNE9Hd3ErSEZqQjFjVkdaUWpFWmNQbnhidFl5SHFB?=
 =?utf-8?B?OS9oRTJDaDhMUWgzaDlJdC9yZ3Q3TWo0V2tmcHhDYnVQcENXa21NQ1NidE9F?=
 =?utf-8?B?WGVTMThzd3c2bjRCVFVUUHEwQ1A2bTlRVWZrV0gxRS94NFc5Tlh4QVYxRkNh?=
 =?utf-8?B?Q1d0ODlYUDRSZDB0dStPNE5MTWxwYTE4QjVYMk1kUU1OcGFiZnpnek8yb3pU?=
 =?utf-8?B?elNQSGdzekd1ZllBU29DclAzNjFiclZWSXBBZ0diLzFwS0QzM04rSXVBK2pz?=
 =?utf-8?B?eVNPUUNQY2Y5K0tXWmU0ZG1obVF2SktlR0dLd0lKS093UERmY0NlNjlsSGJq?=
 =?utf-8?B?MklDaHVsbWNha3hWenlkMUt1RWtGeU5vaWdUQ0szbkRXSUxPOWppVy85ZlpM?=
 =?utf-8?B?VWFYUEl4M1dEOTIya1hjSmhQaGhwUVRCYUY4eHhLbjA0SU9CNi9aaGlORjc3?=
 =?utf-8?B?Um1VektjQVlObFJaOWVpTFdqY08zNlU5NUNmYjJEbTV5R0EwVDV2SUxqUWtZ?=
 =?utf-8?B?ZGcxSEdOb01MSFFSWTVoZndHME1GUWtLb0tTRUZqc09DN2xWRFdqK3Q4V0tH?=
 =?utf-8?B?RmZwRG5QN1VzbjdoNzRLc09nWDRuQ29SbVV5cGMvb1ppNHllVlEzSGo0Z08y?=
 =?utf-8?B?ZVFPaE9sYlhaVDI4SGV3YjNRemtEL2ZZT3RKZElxTndYaGprZW9aWlh3UDdB?=
 =?utf-8?B?S01yTlNyUElub1JORGljc0ovRm1oUGtVK2NzazczckFYeFFiaW9RZGp5dlVx?=
 =?utf-8?B?Q0tqMkJWT0Z3dmM3Rml1VTh6YVBtczRKVFFoNnF5dUxRbWYva2VFM2JUTzRR?=
 =?utf-8?B?Tno3SDU3UGwwU3ZUWnhuMEsvd3F4Umt6Q2RRbTZOY25aTFhndGRnMWQ0bWVI?=
 =?utf-8?B?NXUybjFSZG8yMWE5dnd0a285UFhIWEZ3eEExSnRXbkg2MHZTakhvb212UFNO?=
 =?utf-8?B?VTRmRVUreVRvZXgvS01hV3ZjdENrQlFHUm81a1JWZk1iMjBwQmRiR2JKaEpH?=
 =?utf-8?B?NGYyZ0tJeEt3eDdQM3ljWXdBWU9GMGc0K292UWFCWFpXYnY4bHBaaml4UDBw?=
 =?utf-8?B?WUwyckJRK3l4cmJpK2h1OWNscVB1cFdTSnpPa2IzeU1CRkxVV00rN2lYTVlV?=
 =?utf-8?B?RWJhQ0FXVVAvT2xEM2FMVGkzb1k2akxjalF3ZUMxOHdVTjlEU1VvM3dNaXI3?=
 =?utf-8?B?UkV0eDRySEJOOGV4TUZad3V6Tmp1OVRrbjlDSHpxcVdFeWUxNTc1UFo1MkEz?=
 =?utf-8?B?K0VRUmZYZ0RXdjBkNkZFRmdLOEgzS2VRV2ZEeWZnSVpjL3VzKzZEY3hRTlFt?=
 =?utf-8?B?Q0tlWkZjOEVWRnE5MEpYNk5EQ09GUzJhWFh6a1BTcldHOFJSMUE0cjlqMVNX?=
 =?utf-8?B?bTV4c0RhK3BHcGwvUUZSTXRxZlhGS3JMdVBZUHFRU25vZi8zbEVuUjgxT2Z1?=
 =?utf-8?B?Vm0wa0FnZkdWZjNsejArOUtUNVhQSGR5bUxGaEEzY3ZyRituT21yVWk4MDJj?=
 =?utf-8?Q?PLYDg9vXDiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1Frc3hScnVPZkJ1Zmw2a1JZdHlmQXN2ZUg5RkZDaWhIUUlXRDBYWmE1c1dv?=
 =?utf-8?B?SUtib2tqdDNnTFZlK2NUT0VTYURaT1JWRTRjdm8vQmR3eWhpZTNlNHNQY3lJ?=
 =?utf-8?B?RmUzQlRhMTBQRjNzV010QUszR1pRcDVrSW1GS0dUdktSZWhnMFk4bXhvU2Va?=
 =?utf-8?B?MnQ5YzFGKzkwUEp0UU1FbFAvbE9KQmRtWVZIalhOMlVwNnBKQjNiblc1YjVC?=
 =?utf-8?B?Tm5aNnpXZzlISTV3Y0hDOUZOTU9EVWF0dllCcGRxMitQM0xZaWJncFhFanZ4?=
 =?utf-8?B?NTEwMXdkOHl3RTRyQkxKZFpJZW1yWGRuaURMNk5PVGpCTzdXSWRoWCsyNTY4?=
 =?utf-8?B?d3dPMFJuQ28vaHp3TGRqN0tMQS8wSDNJN1ZPTXVVdGJERDY5QWJZYjVleGRL?=
 =?utf-8?B?cGNIZkFidkViT0xOV1BzdWdqcFgxbUJKcG5PUEdXeFlDWm43dmtGRFdtUll5?=
 =?utf-8?B?NmsrR3JVOEJ6WmlLREp5c0JjY2VzUjZkVkc4MDBmdkh1TTVucXBiZ3NiT2c0?=
 =?utf-8?B?ZFQvQjVMNDFtSlJJenR6eUdaU0tYN1hUNWxLdnVFcElNM3lSNVplcmJEWklN?=
 =?utf-8?B?S1hMWFBwRmZja2UrU3V2NVZEZ3ViME1ZT0g1SmZBemVwMUErb2l5VXo4MmxB?=
 =?utf-8?B?OXBQRDVtNUVta05FSFdSYzc4WTBMRnYwWUZYZHNWbm1UMzFtYVZWK2ErSGlm?=
 =?utf-8?B?RjlKcjNWckoyL0YzNFNVL2wyRTNEUlQ0L1hmVFdQZ0ZDRXQ1V2RIVEtMY0Nk?=
 =?utf-8?B?QXZjZDJuNWxFT0JtMUxEb0M5NzZXOWRQbndTU1ZVWjBCbDlnVzIzaFBuTmVh?=
 =?utf-8?B?VFpnc0gyVFQ3bHdEWkgreU9lNHphVUxjVENMamZUZTh4MHRpRThzTHpkVVFO?=
 =?utf-8?B?UHBHelB4SjJ4Ymg0MXlnS0RJMWt6N1NGNWxBclV5RmdsTVcrZ1poUmRwVVJN?=
 =?utf-8?B?MkJHOEpGUjNtZFdYVjRMd0NPUTJPNE9uQjFPUnc3NytCalppOXJhdnJlc1Y3?=
 =?utf-8?B?VWlkUlZPYVVYeUhkRW9qR2p5YXltaFpwanRPRXBDMk5VeGk4QXZFY0tiUVBF?=
 =?utf-8?B?bEVkOWxHZE9GUVVweUtIV1FuclpxaFpxM2lwQTdVb3N0SnFLaUFOeFNvam1j?=
 =?utf-8?B?a3Fia0VRUzVXNEVvZGJ4S00yYlpJRVVXMzlxa25TcGZFWnoreWE1M2JXY0hk?=
 =?utf-8?B?cjBPblY5SEtTU3owUUt2ZmtBN240UisyL0diSUgvcEZiVTJKdm1ZNk1KclJi?=
 =?utf-8?B?dWdlanJDLysrSVZ5UDJRT2RUaHU2OTlqVTk2Z3grb3F3QkhhTFVpcU0vQVJF?=
 =?utf-8?B?di9Oemo0TUk1dUFsZEdaOFg2T3JDUThtdG84ejMvb1phNWNvNmlpN0tDbFhT?=
 =?utf-8?B?ZXhBcnAxcjRBVlJQWnp3WFBRVW0yak1EKzQrbStrNDlmYXpoY3BJQ004aHFK?=
 =?utf-8?B?dnZYd3M3WjRJRDc3THdLMldDNE9yNlVCY1lNNjByekJNdjNONFlQbzNuN1dR?=
 =?utf-8?B?TVhidGEyZ2R3dmhoNmx0TjhCWGt2aEVJQ2JUbjRoTDl5VUtSU2ppWURMb2tm?=
 =?utf-8?B?WWdmdks0TkhLNVRJVWQ3ODdPODR2T0FHZktDcEdsN3Q5bnRpWUU1NUcrVmpi?=
 =?utf-8?B?STA5S2Z5dEVCVnJmMm12MGtXa3JuQTRqVVJwa1ZoRUx4Tzl2MUpaVlB5bUFT?=
 =?utf-8?B?M2pwcE1FQ2JOTGMwVVRETUZsblBWNXQrOStFTjk3YVhGR1g5WmMydXdkdWhT?=
 =?utf-8?B?eVcrSVVrZXhCVCtvQkpiNWZ1NTZSMVl3MzMxV1dxU2VsblEvWHAwUm9PYU54?=
 =?utf-8?B?VmwvTkN5UUdZRFJjL1pLeUJrS2YvYUZJSUprMHFKU3F3NDl6Q3NLZEh1TzEy?=
 =?utf-8?B?K2hEcVdwc05zQ0N0dFNBQ3kwYUsvV2R1R0szdy9TVFBwdi92Yk52bTRRc3cz?=
 =?utf-8?B?TEpubW1XeDZqdWUxc0VvL3k2bENUNHRKUDB2dlZkODJHbTVhaENhNDFMS29Z?=
 =?utf-8?B?aEMyZWphUnlKNnZrUEpHeGdZcEhDN3I3amljaFBpNWNOZ0hCOU52OXp2bnNt?=
 =?utf-8?B?UEVycTFQRyttS1RCVUs2dUYxK3M5WjhVUTM3TkFZWmRtZDJpdEEra2JmZWRI?=
 =?utf-8?Q?BSzE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7e4921-ec18-4153-580d-08dd7bfc5974
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 09:03:12.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhgzVhF1olvEdjW++nUblWRVZ0acSOOLDH0dIPpwjk5MI5Yn+IR+oLZY7O2YybQj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071

Am 15.04.25 um 00:52 schrieb T.J. Mercier:
> Until CONFIG_DMABUF_SYSFS_STATS was added [1] it was only possible to
> perform per-buffer accounting with debugfs which is not suitable for
> production environments. Eventually we discovered the overhead with
> per-buffer sysfs file creation/removal was significantly impacting
> allocation and free times, and exacerbated kernfs lock contention. [2]
> dma_buf_stats_setup() is responsible for 39% of single-page buffer
> creation duration, or 74% of single-page dma_buf_export() duration when
> stressing dmabuf allocations and frees.
>
> I prototyped a change from per-buffer to per-exporter statistics with a
> RCU protected list of exporter allocations that accommodates most (but
> not all) of our use-cases and avoids almost all of the sysfs overhead.
> While that adds less overhead than per-buffer sysfs, and less even than
> the maintenance of the dmabuf debugfs_list, it's still *additional*
> overhead on top of the debugfs_list and doesn't give us per-buffer info.
>
> This series uses the existing dmabuf debugfs_list to implement a BPF
> dmabuf iterator, which adds no overhead to buffer allocation/free and
> provides per-buffer info.

Really interesting suggestion. I was expecting something like cgroups, but bpf is certainly an option as well.

How do you then use bpf to account the buffers? E.g. are you interacting with cgroups or have sysfs procedure to expose the list or how does that work?

Additional to that why using DMA-buf for accounting in the first place? See DMA-buf is for sharing buffers and only a minimal fraction of buffers usually need to get shared. Everything else is just massive overhead.

> While the kernel must have CONFIG_DEBUG_FS for
> the dmabuf_iter to be available, debugfs does not need to be mounted.
> The BPF program loaded by userspace that extracts per-buffer information
> gets to define its own interface which avoids the lack of ABI stability
> with debugfs (even if it were mounted).

I think we can make the buffer list independent of CONFIG_DEBUG_FS.

> As this is a replacement for our use of CONFIG_DMABUF_SYSFS_STATS, the
> last patch is a RFC for removing it from the kernel. Please see my
> suggestion there regarding the timeline for that.

Oh, yes please!

Regards,
Christian.

>
> [1] https://lore.kernel.org/linux-media/20201210044400.1080308-1-hridya@google.com/
> [2] https://lore.kernel.org/all/20220516171315.2400578-1-tjmercier@google.com/
>
> T.J. Mercier (4):
>   dma-buf: Rename and expose debugfs symbols
>   bpf: Add dmabuf iterator
>   selftests/bpf: Add test for dmabuf_iter
>   RFC: dma-buf: Remove DMA-BUF statistics
>
>  .../ABI/testing/sysfs-kernel-dmabuf-buffers   |  24 ---
>  Documentation/driver-api/dma-buf.rst          |   5 -
>  drivers/dma-buf/Kconfig                       |  15 --
>  drivers/dma-buf/Makefile                      |   1 -
>  drivers/dma-buf/dma-buf-sysfs-stats.c         | 202 ------------------
>  drivers/dma-buf/dma-buf-sysfs-stats.h         |  35 ---
>  drivers/dma-buf/dma-buf.c                     |  40 +---
>  include/linux/btf_ids.h                       |   1 +
>  include/linux/dma-buf.h                       |   6 +
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/dmabuf_iter.c                      | 130 +++++++++++
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 116 ++++++++++
>  .../testing/selftests/bpf/progs/dmabuf_iter.c |  31 +++
>  14 files changed, 299 insertions(+), 311 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
>  delete mode 100644 drivers/dma-buf/dma-buf-sysfs-stats.c
>  delete mode 100644 drivers/dma-buf/dma-buf-sysfs-stats.h
>  create mode 100644 kernel/bpf/dmabuf_iter.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c
>


