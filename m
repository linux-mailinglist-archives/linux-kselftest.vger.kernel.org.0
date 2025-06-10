Return-Path: <linux-kselftest+bounces-34537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81D6AD2D45
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 07:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D92188ED85
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 05:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBFE25C813;
	Tue, 10 Jun 2025 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iZI2hzT1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2861C19D07B;
	Tue, 10 Jun 2025 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533336; cv=fail; b=OnQgyBC+9Jzd39NRcwkyYVf8DVCeZG0bKZRSaP5ldY5QuJIk6OMDbj+iLoqxBIZ8296Aq9SEXnJMHs+TjeuntF/oLpHfZZrYtctChPsJY5f/d1EPbMeu7utB/lBh1tWtA7T7ONWLGbUb7tGyqn5zGUxrEuTiigw/wt66vhe3SkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533336; c=relaxed/simple;
	bh=qu4Ieuq+h2pzg/SorrpfAGmNAvgZ3aai+Rg6wblt8wk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dA8p4BTC3OmaXkKaaw4lL+5FV88rFL3hHlcVg7OgINFBAGsh9KOOVQYlt0vV6RiUNDXYIrhRiiq1m7KgP3nF8DkDZfb1gWFnhOXoYdB6TSLLGRetNqRGkrlF1RoFTIQVuEYvn7G4LkVui7oFp27XOk1tcO/nOcmP+pNgW/cBwHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iZI2hzT1; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Clxmes3nTUfWlTBuaM84dMycxbxSYEZE1WKX2W4bY/3O+GcMVP35IAZu6+Lzztkpo/mVpEJhxXhLP26owS5aqiGzZ+DIcnJqZkkeHlP1S+B+jo0P8smFplo3KaL/6tz3bXydAWc5i3LtHSYnksJeiAiF8IgyKbN98HOy/VuYxq61RS1ovcRZQrRrZ7n+i/6+kyUTt1XviqWPp7mJ/LN/zLC/L5ZGNjtpsBXL1hliJBmcjzk2rtCU8hB7gs1a9jdX3MGn0CFJ2F20gFaYwKoDjE9T5w5ghSfmJdPz6GIizwuqgym6wWveeYn+ipvCulbAqqxxtDTgOFMFIBeuF7WuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz7FX2HDnZq2/WaN+R0sciVdZA8hosgJK3JOe1Dw5gY=;
 b=R5h6JrTJw+YJKVoVnuEdAUbN5BoLMipAg5iS3x8HiWjeq1ebunejC0nt0pwFYNWhiItoty7Z/C/1cudO1TTu5SnIWK0hgYoCaNiozEUCKjZp21ilnZPFMzFQrAjsdZx/Ehy+CkSTku7v+ry+ZZUnMOp2qI9CWIaT9jzLGlnENvnY3G8fL9qTysDklEvkK66Zo/zV7ZuK8CrZwQO0lZvtVgudGVlvF01XR9LM/w7d0tLEIW5UrQ03ReUgvVXwQJQmsdJ4EgWP2ce4DfPkfugc75tcYmbt5uwsStYUmpT5icEfdlY+w3t9I9LdL/aeL04Ki6n9cZypBXftKHeknrHADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz7FX2HDnZq2/WaN+R0sciVdZA8hosgJK3JOe1Dw5gY=;
 b=iZI2hzT1h/ySF4r+hrXcrpfYfyBHzSQYRSpzYBj5uTmzQ6XgWGHuWG9b8B0Wz+UC3ws5vj/4i8Cvjd9OKlt4rE/ygQxpHK0ibme198qy5CgAvAohjkVIB21o4k8iqCQgrW8Cgzlm9CV6qjn3LNRkJiblhnW04mgh1UFQQDUWfvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 10 Jun
 2025 05:28:53 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 05:28:53 +0000
Message-ID: <b1fe7706-cfce-4c8c-ae21-b2ddd03a0917@amd.com>
Date: Tue, 10 Jun 2025 10:58:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Increase timeout from 180 to 900 seconds
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250609120606.73145-2-shivankg@amd.com>
 <20250609160719.9c07424afaf33651f64522aa@linux-foundation.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250609160719.9c07424afaf33651f64522aa@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::16) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: a8798d82-7194-4dfd-6730-08dda7dfafd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWsxK1plcU8rN1ZJb3NjRVlDd0sxajJMaHBuWVczZG0wNkEwVEFPZ080dW01?=
 =?utf-8?B?d2RiNE9FaHdPb2l2L0ZXcFN1azRrUElsODBYVEJkb2ZNTCtBanRpUWRwRjdG?=
 =?utf-8?B?WVV0b1d4ZmVEbmtsZkdCcTdsODcyaVR0QTRFMzRrMW1WWHFFdzlhcjBXL2dY?=
 =?utf-8?B?K3FET3l6S0gvYTFrNjNWOXFIN1ZvMzcwRUJHUHRwU25QRTB5ZHZ4K0NteU5O?=
 =?utf-8?B?QXFWQUFQTjk2dDZWaWFoK1pWaWFnYkZnRkNWUWVZdU9iYXFlZ1BwaUw0dm50?=
 =?utf-8?B?Q3ZoQzhOS1Y3a2NWanhTeHJ0VGEyaTJsU1dEajhRa0tZOUJVZjRVbUdFNVVH?=
 =?utf-8?B?bUlGa0JYeWJrdmlVUXpNT1l1RndpYy9tNkt6b3FlSkNiR2Z0bk5NcHhudDNi?=
 =?utf-8?B?REFja3UyTnNSNUtTSWVrYjY0QkdpVkZNUjY4MWZFYkpTRi82Z0Vxdk56WU1s?=
 =?utf-8?B?eUlZYXJ5ZHl5ZmI0NGgyUzFRazZjejBONjFPdlRUV3JmYmpkcFg2T2NDYm1w?=
 =?utf-8?B?ZGVLdVNJM3UzdFdmOW41RTcrZHBhUUhJRnVtaW44SEpnZW1HTmNTSXdLUENq?=
 =?utf-8?B?bXRXZlMwZVE4Yi9XazFIOEZUNFdrdngyRUVQK2EzQnltaCtIdE9BYkZPMUhP?=
 =?utf-8?B?TS9xRkx6eHdPTkllbTVqUGpLS1o5eFlEaTZNRnB6SkY4c3V6dXZjOGVPMXpo?=
 =?utf-8?B?cko0VXhNdU9yTnAvbkVJVkxXNURKTnovemY5T0U1RGFHL3Y4c1VBWGkxNzRU?=
 =?utf-8?B?QlNtMys4UHpNdi9LbjUyNEFxQnRLZXZHalpQVkN0cHJGUWNzUkoyanczalBw?=
 =?utf-8?B?NEZSanZTWnBUbUZ0TGxkTkJKWmt0cWs5WjdaUzBJNU95THBwamo0c2lIbEw5?=
 =?utf-8?B?Snpwc3A0TVRMb1QxVW9QMFhiVkp2ZkluTXg0YzlhU1A4Q0NuNlpwMnkyYTJE?=
 =?utf-8?B?cEJYM2JmOXpIc3BzWXBsd2hRNE4rVk5iR0hoVGFjYXNCd2s3ZTdXSi9wbi9i?=
 =?utf-8?B?K3AxOWY0K0dYV0lyazRqWkltbHljb0xlS3NIb0VPZ3BFSVpodG44OGN4VnVG?=
 =?utf-8?B?L2thTmEzTW1wcmovM3c1OWVydlVYczFKaGdUNHVwZTVaNDlrL3VzQW1ZZFBZ?=
 =?utf-8?B?NkpEUFIrcmR3T0VsdmhFWEZBK1dPcUFUblVEMkhuWE9LYnBjZjZic1NnbGhZ?=
 =?utf-8?B?QlZjb0hLK0VZUnVqOFJQMGV5cVE2bjAzRDZ0cW1WM1RnYTFUSk1sL3grQmZE?=
 =?utf-8?B?a3hRbENHTnlhc2ZuMkt2ejV0b2xjbG85OVVNekMwRnJVNjhQa1haL3lwOEhD?=
 =?utf-8?B?Y0RtdHZaLytMWXVaMjR3K1NDcU53V1dOclZRbFNZNWtxdGhkMHZMU3I1R3BB?=
 =?utf-8?B?MWlHRVlVYnJQVGJQMGNOaG9KRE5OdTR1TWxsRWhGbVkzeTF3OVRqczRIY2t0?=
 =?utf-8?B?WU54bTA4NGtramc5Y0xvdUppK1FXNVdxQVdLbkNFczFPNGphNW9kVldKeEF0?=
 =?utf-8?B?R3pjZ1VZbjBCNlJCNEF0OFNsMFVHcWdxZ1krdmpmb0xmd01zL1NnaEVQVnZ1?=
 =?utf-8?B?TzJ5a3BxWVdiTzNieVhFOXVJUmkvd1JCVERteWJzUjUzVWI3VzQ1ejdORk5R?=
 =?utf-8?B?WFhWWlBmeC9xSCt4clRnTTZ2UFNrUGxOMDA1K3E4dGxRU24xWUZnS0tVMzFj?=
 =?utf-8?B?d3BYVGdRWGhScEphVGcyWGtOand0Z2dVU0ZONmdTL1VRQlBmRlQyZlpxbmJX?=
 =?utf-8?B?aDVYaWlvU3dmSTFLWDdqMm9kK3FmUWxwMWp6VHdYUUZQd1FYQ2Z4YnNDWEZN?=
 =?utf-8?B?dG5ndXRnUVNJNi9nRFVuWXNwU1VHK3A0VU94TFo2Sm13NkRBbjZPQU12ekpp?=
 =?utf-8?B?NzlUaU1oK1NvNUhIZHh4WFYzaXdKdUsyai9lTGFPYklkU3NsMGpzSk55YnZU?=
 =?utf-8?Q?f+2ySlNDkFo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3ZMRng0ems2cTlURkp0V2FSckhGQ1U0d2lOQ0NBM3BMYXJ4SU8yZXZwR2Rh?=
 =?utf-8?B?a3h3N1dxTE5yRGJRTnViajRtNmpwMVd6M3lTNWNGK1dTeUNXMnladnViM3dZ?=
 =?utf-8?B?M2NKbDF0M1lyL2F3THA3Uk1WTFE5bnZqRmVxc3VHSTMrT0FtRy85OU1UZTBP?=
 =?utf-8?B?K2RXKy9IcGxTTGJTK1B1eDlTSGw4K25RNkM3UWRQRVNNbkVuWXpSbENsdmJ0?=
 =?utf-8?B?TitvcTFRU1hmMmNiQ0VUN3owYTZ2YTcwOWdEV2E0ZGh5aisyT1lsUVIwOTdt?=
 =?utf-8?B?Rlc1bjk0bXIzMEhHRGYybWp2SFZoMGJXNytPc2JoTUtuUnpkZy9pbHdWYS85?=
 =?utf-8?B?R1daMVJ3S3VSSmdLeFBJNFZXcnJBaHVvWHRmd1F5UWlJRkp4S3ZBQXhCdmVo?=
 =?utf-8?B?TEI1ai9kcThLSm8zbnhZQ1ZJVGFaM282NlhHV3ZwanErbHhuMDVwc0FNWVVz?=
 =?utf-8?B?VFFwYjVWeE9LL2VWSzZHU1BTNlVXNUgwRVBoRmZxTHovMWZ3bk5taWxoMFNW?=
 =?utf-8?B?SllHNHVjNTNGOWpqNW1QenhYWmpyVXA1UTBTcmREMVNvV05aTVFKU0RLVXpU?=
 =?utf-8?B?WVdITEFOZnUrdlN6eDRWNXNXdzNVY0NyNlBoT3RIdTJGWVk2VE94MHRHMjZ4?=
 =?utf-8?B?OWJYTENiZFVsVzVZbzhpUjY2cjNPT1dXK0V2anRkYU10VXhoTEpxTy9rT3Rq?=
 =?utf-8?B?bVA5Zjd5bWRwc0RxdnorKysya1dwOXJKak41cU5oOWxLQzc2bkliUjdJRkw3?=
 =?utf-8?B?ZHpQeW1EcmFlRnFlRDhsZVkrQnFNYUh1NDNtclM3bkZVTjZEckpKb3hmOUd6?=
 =?utf-8?B?ME9heVZxVk1ielV2VlNjNTZyeXdWbnBvUStESkJWbkhQZldhMTBQdDJzeUZD?=
 =?utf-8?B?dXVaaDM2ZVNDSW5NWU1sZnl6aTFYY2p0QUZic284a21uYnltK2VrVllWdUIz?=
 =?utf-8?B?VEk3U1dXWS84Nnd1NlNGRFBNNHB0QTdGaW5HbHNvYW04bE5oSUV2YnIra3pQ?=
 =?utf-8?B?dSt6SnJOOTl6TXZiUEpkdkpiMUhBN3VKTXQ1UDRQbUsrTDBnbnNlT2djTWdV?=
 =?utf-8?B?MVduMGVoS0JWbFNGcDJZcC85d2pxK2k5bk5DK2NYYnNyWDllQllpU1h1M2FQ?=
 =?utf-8?B?Y2FXb2VOeTV3SjAwd1o2UmQ5cFFVNnRMK0Jtc1NMR3Avd1hzNSt0NHlWejBh?=
 =?utf-8?B?blhlMWJrNDNwUUJQVDN3M05OVHlkZUwxMy9xNmZqNkJuMGFQS0d1clRWUTBF?=
 =?utf-8?B?MFlibXg2bjZiZHlYdlltMElFa1d5MmFTL21Sc0V3VmNZWHRIY0pPYkMxeDdF?=
 =?utf-8?B?R1Fxem1tNm1Va2hubUFOK2RYeFArYVJCRUNZc1UzZTN1NjE1cUtLWVZobXdB?=
 =?utf-8?B?R2QyZFl1dUpWcHJWTmRxK1IzOGpoM1cwYU42eHBSSmdEd1MxZDE2c2NpNVFK?=
 =?utf-8?B?L1FmY3RSL2RCVFBUVXhIYnlGYWk2MS9uVURnOTNmd3dCM21tMFhkdlNnQndL?=
 =?utf-8?B?RGxqbFVjUGFkdkxDWWpYYVQ2b3BhYWRkcTluZ1hYT0c3SUl0dEdvbmdvMDJi?=
 =?utf-8?B?Mnhkb2hHOTBFSkZjTUZoTDlsOTErRHhEQllSQU13dm1XVFp5RWxVc0NVUGRi?=
 =?utf-8?B?dnVrQTkzeW9FZGFDeWlGdk9kMUlhc3lJUGp5dXdQb3ZkVSs0ejlqTWUrOGNO?=
 =?utf-8?B?eFZFVHMzZUZ3RFBDczMyTTgwdStXTzZ2bS9yTE5KWEpRdDFzRHdzekt0THhx?=
 =?utf-8?B?YzVRUXZaRkQzNUMvbVJMaFc3ZjFiRW1WOXJwdkZLMzdTdDIvM1NCYzBLUlJ4?=
 =?utf-8?B?dmhUSllzQmw1N2Z2SHJIYk9BMXptVXZwUzNyYjFQa3M1bTV4L0dRWlFBbWwy?=
 =?utf-8?B?WlduT21ZTTVYN3pXdncyYSs4SlJRaHkzdUJ6MnZVNVlPc0JsY1VTV2UvcXFF?=
 =?utf-8?B?bHRrQUtTNjdiM3c3V0xXL2hCSXhUYkhoQkdtcG0xU2ZJODJXWGJ2ZzhMM2pR?=
 =?utf-8?B?Z0N0KzVxUEhZREs1bGlBdTNVc08ya25oZjNFcXMvajAwdzlrQUNoU3pIeDIy?=
 =?utf-8?B?NkUwSm9RYldJRU9xSHVCY0o1aktkQkhYcE11K2ExZGVoK1dFR2tLWEM5TkY5?=
 =?utf-8?Q?ByvcD7Hnxi9zjS5OutcW1eBdx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8798d82-7194-4dfd-6730-08dda7dfafd3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 05:28:52.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpR55SR75LAx1Y5npk+Am2YTkG/2I9j+vaC5V17sCHxRwDSI5wt3t1wKfTEt5JKB66sULQi7r62u0LaafqQdLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B



On 6/10/2025 4:37 AM, Andrew Morton wrote:
> On Mon, 9 Jun 2025 12:06:07 +0000 Shivank Garg <shivankg@amd.com> wrote:
> 
>> The mm selftests are timing out with the current 180-second limit.
>> Testing shows that run_vmtests.sh takes approximately 11 minutes
>> (664 seconds) to complete.
>>
>> Increase the timeout to 900 seconds (15 minutes) to provide sufficient
>> buffer for the tests to complete successfully.
>>
>> ...
>>
>> --- a/tools/testing/selftests/mm/settings
>> +++ b/tools/testing/selftests/mm/settings
>> @@ -1 +1 @@
>> -timeout=180
>> +timeout=900
> 
> Gee, that's a bit crude, isn't it.  I have a laptop which will need 90000 ;)
> 
> I guess it's better than it was before.  Some sort of smarter monitor
> of ongoing activity can be bothered about later.
> 
900s is crude, and I can imagine some systems needing even more time!
I think the real issue is run_vmtests.sh bundles many tests together. Most finish quickly but few (e.g. compaction) tests take significant time.
I agree that a smarter approach with per-test timeouts would be better.

Thanks,
Shivank

