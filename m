Return-Path: <linux-kselftest+bounces-9495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA888BC49F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 00:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E6B1C209AB
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 22:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E613FD8D;
	Sun,  5 May 2024 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rpqJXCo/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1071743;
	Sun,  5 May 2024 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714949340; cv=fail; b=cdeOHYFEFaD9x3SaZn7q/+BNg8/QR0rytavv3pw9gcGqvXuwBBZaaGb1b14eZTSKs4cW3vlCKchRBNDaQvbZxJYM95LonbdnZfHucm2x7VvPE0yEAs4vJsGW9sv2BC4OyadKxJUVZX+vpY+B6fFc3iIHiglp7ZJTDvBwkzEkJgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714949340; c=relaxed/simple;
	bh=yUET6d94XMvNpq3cpPmVl69Z5/Gzy4TsC0gy3bk2ohc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pVMPkm0oZAjSYseRGkqn/2GN70DlZnIYJKwb0mBazCFEntUxjZdbfOQ9tbniIXePOSq0djOhFXiXL6Yr2uxqzPGEcsSH14hy8XRL8JkD6y5IibMSYwtN4026zYfXyG8AE1bMqh//Bm5W+CTcTyu4aoTjCicEP595C0wHw2H7aYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rpqJXCo/; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLiBqlYKT4M5b6ORte7aquzcjtNy+wsmiYOYtdBBiDFuUJUC7nvNWU+DRimiENQQL0XzYNfvn9sZsvDf142Z11cti9W/pa3K2dW0R9rLrzJEu85Cnj73FUha2F1ytxYCAHUco3vYMe8VpR/06q73opWjyukIZQPomOCC2t4pP1Cqa1zgss2JvRlYywavb0llNi/KCSanql4SzQIHoOCe9vUaC6cuOvXxXllLOlT7gxEK6JFMIystaPriIE3BxJ4oTg5co8zmv3DQXdIB3CvaeaBaWBKEEXyZth2/iuxbM/WBLajVuVAvKdWiLWZnGTURTiuF9IbSRioj7P/QbJGa1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9FfUrKKp/R6DVANkR18YNyGnfA+Q/3Sndlwg1pB0bg=;
 b=d/fvdCJJHkX9U0sSlG7CPjUklSQIOLhDRmDQgA15bOLuV+1VHlLgEmK3F6Zs0vUZpmiAFE5qcDCoQaZ/7KLe8kMZklOotGU/kXzTwKjRxLQ21CL+EVRROZR6CNGnRPTidlffLkDNcYpJKn39dfcR6r3wyhiRj8/T6H6cb7O9/lIG2/o1fJUqhIMIi8VJIZ2QDDRqhcAcJOyYXSUliLlOOC3jT+axqd1SmmSqwye+02G39ujI7JG7XJb4h/1GzCykZlRXz2pl03BFCH1kAU2v97325GLt6bNXYk1A0LyS+Vgo1c2YVPTSaI4gIwMNyxxKmTj5gv9SR4BKJyNv+E+R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9FfUrKKp/R6DVANkR18YNyGnfA+Q/3Sndlwg1pB0bg=;
 b=rpqJXCo/b2E0zAI3gQJ3OiVk8dpSbefTTpmz1H5j+eOeVRCutuq8UKfTFPGnxYvAa8coy4gmaCNQOJkJFa0znxxRFzDLfQ+rTRZe8iGH9K5vyu5wsFhLGxm6FwoDmsHOquJcagYRhrS/OYnsMCAFwoKx0OhFDsvgMKDzeo/2TRayGX++qPs1bVwxogxO+4yhBJT743QNk2xBys/va9eP6HSnmep3MW159/KS39l+66lynEVlpcoiSy54ElC9XTOXxMMSwusk3qT0ELp1nSwMUQmq0HcgiM/gJQKTSWgn1D1XInrAdNGBqaHun6fQ3CVvugRPl5lPCt37DnGcYhb0BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Sun, 5 May
 2024 22:48:55 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 22:48:53 +0000
Message-ID: <c0a8ffa7-0609-4904-961c-3f4357c53237@nvidia.com>
Date: Sun, 5 May 2024 15:48:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool, selftests/hid/bpf: fix 29 clang warnings
To: Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 Peter Hutterer <peter.hutterer@who-t.net>,
 Jason Gerecke <jason.gerecke@wacom.com>,
 Joshua Dickens <joshua@joshua-dickens.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-input@vger.kernel.org, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240505215636.63592-1-jhubbard@nvidia.com>
 <4f947691-bf25-460b-bc08-da29de3fdaa6@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <4f947691-bf25-460b-bc08-da29de3fdaa6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 669bfbb4-349a-4019-d167-08dc6d5589ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjBHS2ZJQzNHSERpbXRvZ2JBb2U4SENqbUF2dlZPQWdKMGVWMlk0UHloMlNw?=
 =?utf-8?B?WGh4ZndGN2FMSjVNU2lhaWdNbkpzVU5HZGg2MXlvNEo3L1cyTkNLbGpQREZI?=
 =?utf-8?B?c01TYUhOYmRpRHdrYWZ4bzlaWWp4VWd5bEJIRGliZDI1cEVJTW80ZlpHWFY0?=
 =?utf-8?B?TUZ4dnRGamJ5akVnZGZPc2VWTUZsZXpueGNLZFNlYWJBVkF6TExZRUt3ZXdl?=
 =?utf-8?B?a2Q4dDEyQTBkZVN0dnVLcmZvNDFWbkdpTC94MCt0enBWRGd6WGVHYTVscnZT?=
 =?utf-8?B?UHhSZ2NMaExobE1VeFF0bjdlbGViYTduUkdIYUZnV3pnUWlDcVBaMS9MK0tn?=
 =?utf-8?B?K001MXAwUWUzaDRZZksrd2NMaUl4VWNERDF5UG41akloV0ErajBYejkzVjJJ?=
 =?utf-8?B?cHFmL0dSV3Q3b21WVzNFVU0xNW8wWFhBMVQzcUpKRVpscDhjZVlKTDVlaEts?=
 =?utf-8?B?dlBYai80TFE3TEF1VkxaQWxoS1B0cG8rNlZHSWcxN2hQcFpoa01IMEV2Tno2?=
 =?utf-8?B?ZzZnVzRtS3BJRGowNjA2cjJJYStVVDJacHA4a1Z3MDU3WW0xQ0RnOUEzNkJE?=
 =?utf-8?B?Wk9GNU85N0NxUFBuMnJ1OFFBZTR3d3Z4emtncTR0UkpOcFJhWUZma2pLNG5K?=
 =?utf-8?B?ZmM3OVdrczRENTZTeSszV01jWVlNWCtUanNNSzB0TE9wWVBJaDlTVmEzdWxr?=
 =?utf-8?B?andDclVXbnlGdWxRK1AxbGp2eFUyRHRHV2Y1UmZBV3NVQUEyNEVNTHkvUDg5?=
 =?utf-8?B?VVRiaHEyUldTNStKMlNFUVgzb2NUUmhUY3pQV0FVcm5LS25EVVBKeHpPVVc1?=
 =?utf-8?B?MjlGTXkxczJZdkEzU3dsWHBCaUVWeEhLWVMxZ2R0OG1SOTR0UmlXbUgvY1dq?=
 =?utf-8?B?MzRJUGxWWUFzL280cVB5WEdUb1lxN0lFQXgxRy9qZys5ZFNBS3dCeG1yY2Uv?=
 =?utf-8?B?Y1pSY3RlQ1ZYc2s5bWd5QVkyelIvcnVYb0dtbjhIQXA3bEtZY3BNdjlPQ2Vu?=
 =?utf-8?B?QVpKcXF0S0RGRDN2dE5qQWNaT3B3NEVNUjNFVFhFdzk3RGNlYndjYnNpZmhH?=
 =?utf-8?B?U0wydXBFcjN0SmQvQVhoQ3VBT2M5Zi8yazBYdE5meUFsTDlORVk5ZjYydFdC?=
 =?utf-8?B?QjcxWDVZN0VQRldLY295M2JHU1pZdkROemdNZ3h3VXZOdXIxa2hyVFZFM1V6?=
 =?utf-8?B?MmIyQ29obCs0TDRQbHVoTTlpRjRNZDVnTWV4RUVMK211OFVXdVljYWd3TkN5?=
 =?utf-8?B?Yk91MFlwUGdueStIR0dCdDBFK1lwcGtBRFRrbG82WVh2aVUrdjRoOFhQOVJM?=
 =?utf-8?B?blFUc05BSlY1dG9CZm1WWWtBQUJvUE1waTBhalB6MG10a2N1SHA0SStXMHhm?=
 =?utf-8?B?aEV6RjhadnZ4YjVkcWJuNHRNNk1FVGFwcHNuVExhQ3l1Wk5tdjIweTRRUjJj?=
 =?utf-8?B?YnA3MFU4QjBsQ1JTMjNXSW5SOHNBRzlqUUs5SDRqRHZzWTRGTjc5aU96R0lY?=
 =?utf-8?B?djByUmxtTkg0WUtLWFBQNEMxN1VLKzJ4aEU1WDVxdlRuT3VFOTh1TjF2L3lC?=
 =?utf-8?B?SC83OXpiVEl6ZjBpeDVRaFpXYXREaG5lWkpoaHc1US9ZdUxzclExUUtNaG1i?=
 =?utf-8?B?TGZPbll2QkdXazRockhUNnkxWHloclZGTG93cmJpdUxCTkpKdVdhTzUwcUNl?=
 =?utf-8?B?cGQ3Q1lmdG9DTjFrRlhEbVh4cnNLc3JCSXc5TlZZd2FoZVlQbXAwL0FnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGhBenhVSHl1MHVLWWRwZ3ZQSytnMm5wRFBKNFg0VnYvQWNKZHptVW1yczV0?=
 =?utf-8?B?Zk5GRzdtQWtveUFKREo0VksvN1JhdjBraFErd2xHMy83S0Q4OHZPTC95Zk1N?=
 =?utf-8?B?UzE0ZkE4cVpuZUpIcFpHNGtFdFprTVNrVm5IaDkvREQzb3BxQjdPZm1pbkRY?=
 =?utf-8?B?RlVhNlAwT3JuSkxSdjJnekRrK25WZ0VhcWh0RTN6NXd6c29nTk1WVzgyZlZz?=
 =?utf-8?B?OCtrZHA5RzZSSmFrM2NXUEFzYVNoN3B3NXVHcXREZ2U0Snp2UGkrT2pib0hF?=
 =?utf-8?B?ajRnd2JUaXRIMkFwd0E1N3pNVkVCMkczWDRzRW1WellibWV2NHc2S2NCT3pU?=
 =?utf-8?B?QzIvZDEyMVV3U0dXRGQ0VmJLRDJseW1iMXhtdGNITzcrUVI1cjBkMkdSc0xT?=
 =?utf-8?B?Yk0xQzNmTUtEdTRrSm12eE9PNVBYbC9STTFSbFZndUpiN0hkMGcwK3JxQk9D?=
 =?utf-8?B?aVNGbG1JbWlUaTBFdlZhRWpnc00vUjJtMWNmMVpSREJpQ3R6bHd6ZER4Vm1u?=
 =?utf-8?B?QlFuWG5rYy9LQU9TbjVsanpkVGR3cUY0Vmg3ZS81UjZiTjM4cy8vZTRTMk9n?=
 =?utf-8?B?VjBQbUxWTkF2Ymg1MlM3VW8wbTdOaXRXckVtU1lNRktnK3dHM1BLS0VjWW5r?=
 =?utf-8?B?WGFxME1PZWlrRittc3lLS2w5WW9YSkRPWFRDSTRMa2gyZFB6QUt4YUs3U1Yv?=
 =?utf-8?B?d0dncG5saHhPdGE5SDRVVXJMdk10QnRuV2JkT2NIYStDcktwekxqOTE0VU5q?=
 =?utf-8?B?OHdDeVFEekFaeStmdXFsZGxTc1hKazVFREtZRG9CTGRLbXBoU2FtRDltTElj?=
 =?utf-8?B?VjVCM2o1S2VDempVQ2dlQnJhN2dHTFk0c0dBOXdIQnhTL2NqY2N2bXdDd2h1?=
 =?utf-8?B?Y3E2eERTaGNIWHNPV20zOUM5YTlkZHg5S0FGK3pZTUo2T29UQTI2eXRNY3l6?=
 =?utf-8?B?SVJHVVRZVTJLRVBtSmtsRzZ1UE45c0l0N3d6dWVWeXhjbjlNUHAvRHNPYm51?=
 =?utf-8?B?eFMzOGtWUlRqTVRWK1I2dWl1LzFSRkRuNGlEU2hqK040Q1V0cGpUcE43THN1?=
 =?utf-8?B?R0hNalhTR05OZVpqTkQvMUZ3OE40dkxSMjlOdGxiZ2R3elR4NUljL1pwZ3NR?=
 =?utf-8?B?MkMrMWt6eDhkakd4aUlONHVUNmc1eDNtYm9KT2pESXllU2ZMSUw5UDNCWkFt?=
 =?utf-8?B?OVcvY3o4RlRWU1lSUlRhN1RHRTMzQlhvSG03VWJDdlV5Sml0QWJoTXdDQkpt?=
 =?utf-8?B?Z0E5OXV2MDYrQmVUeVM5eGc1eExYYXd3dmVBWGd0azQ1RjZoM0NxOVZOL0hH?=
 =?utf-8?B?Qm1iWSsyY2IvRHlyZGVueDFQQ0Y3b1RWamN6Z0ZTaFA4TGNXTWpSN1FnNEd4?=
 =?utf-8?B?WENrY2lSYzZUWnNRQVoxUnNwSlZxVnZGWWhBZGk4dm1mT1Q4dzd5Y0xyT1FR?=
 =?utf-8?B?WmI5QUFZcmFCbjNvSHA3aWh5M2doM0NSaWgxeHFoVVZmVXNDaCt1SVZVNExG?=
 =?utf-8?B?ZnAxMUZaT2IwR21tWDJWNUJSNkdoODJmNXdCLzA2R0htdTVsZEhOVXRxRTdN?=
 =?utf-8?B?QTVySlZ1Q29jWjFaQzk1T2tRZi9kK3Y5WmZwTnE4VS9DVmd6Wjg2bDExMnVh?=
 =?utf-8?B?Rksxa1JrN0JQbm1YTmpJTThZVFVnakNCdDFSUWRmcWFWcmVWTGJaaHBTTlVo?=
 =?utf-8?B?UUxUZ0IxdFBUUFlNbGRkRXpvQmZIOEYyQ2hCQjIxN0lkMlVJaHEzMis5Uy9X?=
 =?utf-8?B?TXhvOGp5MGlleFNjRC8rSW1ndVArdkpCRWZ4OWhTazcyYUIzU1JrK08wNUtt?=
 =?utf-8?B?Sk1DVTN6ditYZU9ndjFhUlU5WE9rRU1mMWJWcVE5empDTlE1QlIwMktYb0VC?=
 =?utf-8?B?ZDY4RWVEckM1Q3p3bUVhc294MGFlY0pZaVlvemZoZlR3TFQ2eTNDMDdXRmVD?=
 =?utf-8?B?aVExc2VQUlBBL0dTWmczckdFV0QzY0h4ak0yWWk3em1obDd0VjhZT0RXYjJX?=
 =?utf-8?B?VGlaR3Y1MnJLelJWa1ZLZjN3NERCWFA0Y040QnpEbjZ0dEJKekppRU9tKzYw?=
 =?utf-8?B?dFMvNkU0dlVhcmsxWUtWazBYSmZ6QmRDTkQwZlE1TjJEdEdIM2tQWXpYVjBL?=
 =?utf-8?B?V1MzeTVYZURXR0hmMnVyOVVVZ3VFdTlHU0xTY3F3WTliUGN3ZkRIc3g5RGxa?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669bfbb4-349a-4019-d167-08dc6d5589ba
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 22:48:53.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgFm2bV87Ki0IsiMgo8h0KAGBZhdsv1i2qgeRj836CrWmJPQAH2aroa1535tkj4kXy89z9XOEKsCsT72VAKNdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435

On 5/5/24 3:36 PM, Quentin Monnet wrote:
> On 05/05/2024 22:56, John Hubbard wrote:
...
> Thanks! If possible, I'd rather keep the warning enabled, and fix the
> command line instead. Looking at the error and the Makefile, we may not
> need the -lLLVM<version> in the CFLAGS at all, but only in $(LIBS). On
> my setup, I can build successfully, without the warnings, with the
> following patch:
> 
> ------
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index b67454b45a49..dfa4f1bebbb3 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -147,7 +147,7 @@ ifeq ($(feature-llvm),1)
>     # If LLVM is available, use it for JIT disassembly
>     CFLAGS  += -DHAVE_LLVM_SUPPORT
>     LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
> -  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> +  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
>     LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>     ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
>       LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
> ------
> 
> Could you please check whether that works on your side, too?
> 

Yes, that works, and of course that's much better. Please let me
know if you prefer me to post a v2 with that, or if you plan
on sending it yourself?

thanks,
-- 
John Hubbard
NVIDIA


