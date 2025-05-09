Return-Path: <linux-kselftest+bounces-32729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF60AB0A36
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 08:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2211BA5A78
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 06:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A732269B11;
	Fri,  9 May 2025 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AuFRwDTw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D811CBA;
	Fri,  9 May 2025 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746770648; cv=fail; b=t640jRTIH4C1SfQNuP193mPjnXpMFLMdklQjUoVCz2OaBKuAkSrcD8xRJ5521t57h3whRfsQnPG2zYhGWZurh/rjIIBniwoq24PAQEzfUTA0MvI10e0V9+JuKPuONEgEnKOzcZUDqCR1DWEIyZ0A4u73kbfTrrVbvN4au/Crk6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746770648; c=relaxed/simple;
	bh=AUa4s/eISj0+KTEl6lECQRscituCaO+LhNV3aa2+C2A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SH7G8uAvZFXYtFSTL21aPGVJZyxI5gzFV6cHzM4LcFrrpFJaUZOHBwhV4hYQodE8DCTBa3V8yY1S+AECVcEoVqfqHjCWnYayGooIWmo8ToZS3jPZ03i0tWJ/9w36aW67GWPTgUw/ndq66flTK9TIaaz03iXh2O+gIDivb1zZKVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AuFRwDTw; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pP3ZTXC5LmYY1E2KBBqyikKLQjdypR9v1yGAXR22qMzei3GwPvsfiG18rgbF0BJK9vmW3HIBTw/sGIhE3yhtIUieAKK+RUEc42sDCGHXebazWs70rMLDVuMp0z42IlS6VwA/H/x38J6pW0uctVecwtqFY9w2nU5yGbxrZYXsKHdfcyDx0V0VpcnHjRfJBAMLKQMp4P8GS4u8w/EnKXBiBgpsRzcd7TXBOp4aeQRDZh5dEbrqF4/774phm8T5rAMoJYYB+QsOrJsAE6yIQRNIxabLPp6TPEXuMT0Sm44yxGYFwyZsAXzwiWvPkiMX9z5pFytEwK1XzXtQUbZcIB0cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RZ47Yr9NC41pKhebl0AJmXhcDFDzOdz3r5E8DUf9Fk=;
 b=fZzpvJ4XjP3HGB6ewtueW0aWLguoIxMnkI4r8bFqy8HxooFgBdlJKXURMv54lKe+Ho2PnS1/Sc/Y5QmEFHABagkOGYF4Cr8ilySSwn4NOeHw9AxTnQnS+mWL/sz5S8cIufre80Jm1+lb8Og4WIgmC+wJcMuZUgZEiYUVRW0w4T/m0elviMhfCOmNwqOvi3ZrAmBT6KiFXIVH/1hveDsMhRKnDSkRzCuLW4IrOEhQUyLkpcVS3Bx0fBrDncspkK+axwq1NH+EEQxmPZ8YO7xfq0kW97pPsSJZ5IX5I6h1Le+b0Vm9LCkEir3LIsjFG4SRMIj0sPA+nkMyyjpEu0EgFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RZ47Yr9NC41pKhebl0AJmXhcDFDzOdz3r5E8DUf9Fk=;
 b=AuFRwDTwRfMEGO9wY0iGgf31tpHXH8p6uWmobA4ZA3HBrJE45ioChA2CWUYUZcv082SwmaSQfUZiyMYx27tLRNZwJT0wLTHhI2wUsGEHyUCBGzHNSvXPybs/nEmCkR62y+IMzlEoGXRlFhIQSg6OOz12EXoSh/oi/IrVtoZE3W8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 9 May
 2025 06:03:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 9 May 2025
 06:03:59 +0000
Message-ID: <b1e53d0b-04ba-4ad7-abdf-2406283a9cfb@amd.com>
Date: Fri, 9 May 2025 08:03:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/5] Replace CONFIG_DMABUF_SYSFS_STATS with
 BPF
To: "T.J. Mercier" <tjmercier@google.com>, sumit.semwal@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, skhan@linuxfoundation.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com,
 simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, song@kernel.org
References: <20250508182025.2961555-1-tjmercier@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250508182025.2961555-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:208:178::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f153d6-e9a7-4866-d8ac-08dd8ebf49f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkJ2ajRkS2NMU3dtNkdqbzVVL2NDTm9uNWxmSFhKd0ZjM0FFdFJ1ZEU0Y0JD?=
 =?utf-8?B?NHVzcXpldzVFU04wd3oxT3ljeSsrYTIyQW5zVG9JM3RjN3oxVW5xTkJFVFJq?=
 =?utf-8?B?MkhzN0tTaEY4SVBPdko4NnVVWG12QU9tTXNaYkE2eG9JZU1XbXJSaHQzdWho?=
 =?utf-8?B?U2dKSzNKWDZHc0hrUFBzQUJNREdWQUxPRjJzWjRJeG1jZnEya0VzUDdzc2pS?=
 =?utf-8?B?a2NER2RyRmJuQ2dleVd1aUdkb1FsRW5qZlBzcnJVWitnWW5DTFBRM1YxTTNF?=
 =?utf-8?B?ZE8rT0dWRVFQZGdwVWh0MzFwSDRmdHltbVJKVzExNVdXY1B0YWJhSkZMMHh2?=
 =?utf-8?B?TGZIMTZDNGRCMHBiWk93UzdNZW9zYVE4L1N6bVU1R013cHpaTm1ZZUdTejYx?=
 =?utf-8?B?V3VvWTA4SW1FTkFRc3RDZmp4cGU5L3liVGRCMUVyR1grcG9IeGZVTXJCc3Zt?=
 =?utf-8?B?Z0tzZ0N0L0EyejZ1SFVtNE5RdWR0cFFNelZjaC9pcU0zaXZudytHQXB5RHl2?=
 =?utf-8?B?U05oOUtUVkxIbWo5U0p5TlphalVSMWlMb2ZxNmR5MnNiSG4wRjdsaytxcW14?=
 =?utf-8?B?QyswNUE5MkxEYmExVVhiaEhUQ1ZKWDVwNWRhcFdkSnBUMTdON3RJc1pIcmFK?=
 =?utf-8?B?cTNhZXRXOXRRYWVQdHZNYUZ1dzcxNThVbm9tODNpV1dxaVZyRnBTSWxTZlQ1?=
 =?utf-8?B?WVR3ekJsbE5tNkxGcWxxbWdlMnExOFRLYWRLQVlnejU3VHk1YVVLNGh5UGk3?=
 =?utf-8?B?RnJwSVJsazZ4T2xmSUpqWnU5Y0RKM0NLakFvQzVIUk95NU5rM2NHOFRKU1Qr?=
 =?utf-8?B?WERZRUpyRUlNOHhPc2VTMHNrTzlZWGdvYXptNm5Qc1FkSFVJSEtOTDRicnc4?=
 =?utf-8?B?b0xJcXpocVQwRTBPbGFYb0hweG5KUzQvajBNb2NDNHhJWm1WTFlaT3FXWlZi?=
 =?utf-8?B?R21OUCs3QisrS3NhQmZEWU9GRzRiU3ltREpQdSt3WitTRjdwWm91RUNQZ01J?=
 =?utf-8?B?ZUR0VEVQSkhmYUIreG5XdDhuSE1xT1NNc3RkUWkrWlo1MElzVGVWWURzWjlr?=
 =?utf-8?B?bUtyaWxhTzlGR21ISllURGdQbDdHdEdEb2haSUx1ZmRjTzFqRnl0dmt5aW11?=
 =?utf-8?B?a1RPME4xVzc4YXpDR2JOOXVDcURIb2dibkpiM2QxZjIyOVk1bExUWFlPZEFW?=
 =?utf-8?B?bldNWVNjY0RHMnJ2QkVGd3dIRUx5YlZvYitnQmttZG9CYkNzUFlBeUpyRkVV?=
 =?utf-8?B?NWZZMXZyQmFScHVhYkxWbXU3aEhzbSs4anVOTFhXWnlwbEZNVGoySTEyMGtI?=
 =?utf-8?B?cWZtSnJtZ3BOYTdRSFhOOW5PNHcrYkR4V3dEcG5Cb1hpbE41Wk5JWW1vejdi?=
 =?utf-8?B?a2xqWXQ0NFNVdi9jYU1XNVZoYmxpOEFzQlpNeHRUcjNKcWZNTUI0Q1NqZmx5?=
 =?utf-8?B?Wk4wSVczOFFheGdUUUlyVzNIY0kwZmViVG5CTDhVS01ZajIvNTNmaWkvN2Qy?=
 =?utf-8?B?WkhiTUZyVC9salJ1UUJHZmRkbmlQejJDK24wZHlqQ2d5RXpGY1N0QzB5d1V5?=
 =?utf-8?B?a0c5bDZKN1hCUkZWYXhuZzl5bEdXS3hvWUgwWFlnWkFlRy9Ca3IySEtMZmt1?=
 =?utf-8?B?SUR3alRKUTN1NzgvbForM2lHOW4xNjVGL3FwSVJKa0lrMG13NmluZDdLc2Nt?=
 =?utf-8?B?cVA2aTVOaUo0MWpQTFdCc1VIZW45aGZrUVVyQUY4b0QzbjRMQkk4bThGZDBn?=
 =?utf-8?B?THhhN2lrb3hyemdpb1NTQW10YnhpalpWN2lNR0taVUxyd1k0UHRuN3hFeFhh?=
 =?utf-8?B?bUZRbkJzTFFQclk3MzNVb1dVN0V5eUFxWlhmNlF4SHFGQ05wcEkwd1l5TFpx?=
 =?utf-8?B?ZElxOHpYTVZVMWpwU3lTWDdneTRZOVo3eGpXUmhONXpQSVBQdGlQbUkzNnBH?=
 =?utf-8?Q?teGYuDxobEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWFETm44a2lKZ1lWNHJIWU1KRmNPaXNGSnIvZzQ5TVVHb0hkZUhGVzVkaU5B?=
 =?utf-8?B?VE0yZlN5czVUejdKTXZsdVRXMjMyMmVwMk55YzNSbEtteUV3eEFOc29BOWpt?=
 =?utf-8?B?NUtYU2d0SWFUcnV5eDlsQXZlZHQ1T3dDVmMxUG45cW1RUWFkL1BLWW8wRDJs?=
 =?utf-8?B?SS8yZklacnlJclp1S3IvR3dxdDZQNHpkSUtPNVNJSXlnQ3hJNlVKVlNMU296?=
 =?utf-8?B?ZnBoT1B6a1l4MzNFLzFXQW9mdUJlTTR3K0YzK0t2WGR6anR5RlhVNENOY3pw?=
 =?utf-8?B?TjlhVkl6ckFMdGM0Q2dVa1J4SFBhaWNZdEJrc0lISUVrQ0d1QVBkaC84NGlp?=
 =?utf-8?B?NTZ0NFptMjI4dTIwZnlKZ2JhNy9qMjJYL2RseGNXOHV1WW9aSmIvcmYrdFNR?=
 =?utf-8?B?dGx0UVFkdVNuYU1zWHp0REdmM3hHK0NmbXRFeThWTXJLTnoyTEtiMWQxZUM0?=
 =?utf-8?B?amlaZFdWdTdWN0d4SHVqdEV3K29wa2thVkRYQTNxbmN1OUduN0hYRXlCbnk4?=
 =?utf-8?B?dzJOSkNFNHhaa094TnNHazZiOXNjWXpLWDIvcXJyNGVNYXVCMG5Qb2YxaWw5?=
 =?utf-8?B?RHhrbFJlVDlxK3RQdzhLS2tjQUx1NjRKdXlnTjNzSUN3TDRnMllJS0M0OEhY?=
 =?utf-8?B?MGdjNlFhekY0MFN3aTd4YzhHL0F1SURmM1FiL2lkNmc4ZzNGYmwzVUpSR1Y3?=
 =?utf-8?B?bU5sU0pjTENPd045dEl2b2xtZjdYZG9ZSU5uYmgvTzJlUzJiVC8zS2FTa0FD?=
 =?utf-8?B?SnJodzdUNEt3THVsNW80V2w4L3FWVkV4QkxBWk1hMW85T3huQ05kOEJrUlQ0?=
 =?utf-8?B?aE1MK3J6b2VBSTJvc1JDOFBsV1NOTnBZcEpZaGtMbmxDRXh2RWtmdlhJS3hM?=
 =?utf-8?B?QWYvdWlVWnB1VkIwZm9RaUMvTERYZ0RIRHpJWlNhVjF4VVdob2U2ZmdhWVU5?=
 =?utf-8?B?RWdmM0VBUEEvZVNMNUtaN2s0NWdWU003NVNlTXdSQWUvWUI2YUEyb2RsYWxo?=
 =?utf-8?B?WGpmSG1aRkNqeTVGQWlGbE1aSVU2VFhFN2hvcjdoRGlCSHEzU1BHUG1wVWo4?=
 =?utf-8?B?dE9MM1V0dUVwU3I3VmlvNnlIbTl4TlR0TTh2eWxIaUtNNkJnMXY1bWhLV0hR?=
 =?utf-8?B?aTlQUlo1REl2UWNLdXRaU2xrOGwyeGl2cEFnZXZwMW9qamhWTmRvYU9FS3V6?=
 =?utf-8?B?N25LbkdCOU5qdXJhUHJIU29mcFBNbEk1bzgvOTMzVmppYWpYMlRLWDA1K2pj?=
 =?utf-8?B?eFhmMEkwdlZZNE5sQ1hEK0lNR3BWc1B4cUZCd3JmQ0JkK3RjcDR5T0NwcG5Y?=
 =?utf-8?B?K2FIRE96Wlo1Q0QwbVZMTjdwM0NmSXNuTGpjVXg0a3poR3U0TXFEeWExdVoy?=
 =?utf-8?B?S3Vrc1ViZ0U3UmhXeXFlcFZwL1NYZnRET2N3T2dxQXVlQVpuajJnaUdHejZT?=
 =?utf-8?B?YUFlYnBhMkRwRnVGSDlUOFozOHM2UWlnNEt6Q0RWd1pxMVMycitsdmREZ1VF?=
 =?utf-8?B?b1hGY25xeUpkeWJWMjBUL1E5MnpBdW83MHlUSlNnQXRXWnlxS0tjSWlhNmpu?=
 =?utf-8?B?WVJ1UkY2ZldveWRiMXFSZGVvVGppaXR2YWV5SW9UcnQ4ZHJBU3hMRGdqeFZr?=
 =?utf-8?B?elJYeWV0a2tBOEhGL2Y2MWNvcHk3QzlPemE5WnY3QnQ5dDQ0UEl5NnJWV05t?=
 =?utf-8?B?SVJoZlF5Qjl2Z1lQUjVIUU1Eb2J6ay9ETFZxS1NRM3JWWml0MlFocHUxMGhL?=
 =?utf-8?B?ZGVxTmkvSWphSmlMY21aRnF1WGN3bzJrWHdId3JkV0Nac3poK0tzOER6ZGE2?=
 =?utf-8?B?NHVTZ2JXbEE0RlY2cjZhdHhjWjNmN0tRTFREd3JiZDR0WHkydWhDdFJCckdY?=
 =?utf-8?B?NlNhNkRETnVmZVNjbW9yb0Nrb2VTQ2VTclZnYjJNZkhiQ2MwbTZyQkdlQy9O?=
 =?utf-8?B?VTlOeDg5bnN6SzI5TDFLdWJpTERzZGt1ZWd5OWI2SHZHSUJpeWViSG1CMitL?=
 =?utf-8?B?YUQ5ZWlVbEZxalA1MzJUSjhQY2ZBb2ptTEswMnRFYlJjSGQ0bURyNkFnUDlZ?=
 =?utf-8?B?T1l4bllXa2VmOGtNaUprbzd2eGNNbGVrSHJObVFjeEJsSjlaQjdXU2gxdlhK?=
 =?utf-8?Q?TPfNgpajNxOxZXZJL4mH9ERBN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f153d6-e9a7-4866-d8ac-08dd8ebf49f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:03:58.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u56zoTLa7CFQmNjjpRKRFhL8mRqeoydPR7haQ6i7pjBFRM2Zoxzobi/z/NeUBdkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609

Feel free to add my Acked-by to the patches which don't have my rb yet.

And ping me when I should upstream this through drm-misc-next, but if you want to upstream this through some other branch then that is fine with me as well.

Regards,
Christian.

On 5/8/25 20:20, T.J. Mercier wrote:
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
> provides per-buffer info. The list has been moved outside of
> CONFIG_DEBUG_FS scope so that it is always populated. The BPF program
> loaded by userspace that extracts per-buffer information gets to define
> its own interface which avoids the lack of ABI stability with debugfs.
> 
> This will allow us to replace our use of CONFIG_DMABUF_SYSFS_STATS, and
> the plan is to remove it from the kernel after the next longterm stable
> release.
> 
> [1] https://lore.kernel.org/linux-media/20201210044400.1080308-1-hridya@google.com
> [2] https://lore.kernel.org/all/20220516171315.2400578-1-tjmercier@google.com
> 
> v1: https://lore.kernel.org/all/20250414225227.3642618-1-tjmercier@google.com
> v1 -> v2:
> Make the DMA buffer list independent of CONFIG_DEBUG_FS per Christian König
> Add CONFIG_DMA_SHARED_BUFFER check to kernel/bpf/Makefile per kernel test robot
> Use BTF_ID_LIST_SINGLE instead of BTF_ID_LIST_GLOBAL_SINGLE per Song Liu
> Fixup comment style, mixing code/declarations, and use ASSERT_OK_FD in selftest per Song Liu
> Add BPF_ITER_RESCHED feature to bpf_dmabuf_reg_info per Alexei Starovoitov
> Add open-coded iterator and selftest per Alexei Starovoitov
> Add a second test buffer from the system dmabuf heap to selftests
> Use the BPF program we'll use in production for selftest per Alexei Starovoitov
>   https://r.android.com/c/platform/system/bpfprogs/+/3616123/2/dmabufIter.c
>   https://r.android.com/c/platform/system/memory/libmeminfo/+/3614259/1/libdmabufinfo/dmabuf_bpf_stats.cpp
> v2: https://lore.kernel.org/all/20250504224149.1033867-1-tjmercier@google.com
> v2 -> v3:
> Rebase onto bpf-next/master
> Move get_next_dmabuf() into drivers/dma-buf/dma-buf.c, along with the
>   new get_first_dmabuf(). This avoids having to expose the dmabuf list
>   and mutex to the rest of the kernel, and keeps the dmabuf mutex
>   operations near each other in the same file. (Christian König)
> Add Christian's RB to dma-buf: Rename debugfs symbols
> Drop RFC: dma-buf: Remove DMA-BUF statistics
> v3: https://lore.kernel.org/all/20250507001036.2278781-1-tjmercier@google.com
> v3 -> v4:
> Fix selftest BPF program comment style (not kdoc) per Alexei Starovoitov
> Fix dma-buf.c kdoc comment style per Alexei Starovoitov
> Rename get_first_dmabuf / get_next_dmabuf to dma_buf_iter_begin /
>   dma_buf_iter_next per Christian König
> Add Christian's RB to bpf: Add dmabuf iterator
> 
> T.J. Mercier (5):
>   dma-buf: Rename debugfs symbols
>   bpf: Add dmabuf iterator
>   bpf: Add open coded dmabuf iterator
>   selftests/bpf: Add test for dmabuf_iter
>   selftests/bpf: Add test for open coded dmabuf_iter
> 
>  drivers/dma-buf/dma-buf.c                     |  98 +++++--
>  include/linux/dma-buf.h                       |   4 +-
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/dmabuf_iter.c                      | 149 ++++++++++
>  kernel/bpf/helpers.c                          |   5 +
>  .../testing/selftests/bpf/bpf_experimental.h  |   5 +
>  tools/testing/selftests/bpf/config            |   3 +
>  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 258 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/dmabuf_iter.c |  91 ++++++
>  9 files changed, 594 insertions(+), 22 deletions(-)
>  create mode 100644 kernel/bpf/dmabuf_iter.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c
> 
> 
> base-commit: 43745d11bfd9683abdf08ad7a5cc403d6a9ffd15


