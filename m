Return-Path: <linux-kselftest+bounces-9543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDC8BD3CB
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2E31C21644
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC0157470;
	Mon,  6 May 2024 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvMXxrOj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673B157473;
	Mon,  6 May 2024 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016350; cv=fail; b=eoc0tJLnGsdDDynMrmce7R3/SAjdJzwKgoFtCpY1vnond8zXb+BmdJo89Foa8jG0OcsyJcFs0oRbCehT1yJopmnmGJW1MMYzSeZQn6mPAUM7PT8rYDlpDZaWR/BlgY25hTin8EhZx4gigT4zleeOX4fAUqj3xeb+/FBbzeCA0cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016350; c=relaxed/simple;
	bh=0yuxjsT2zXAEFbgRgex58oOY3BCHAlWvWISD1Lo2gMU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iFiAcpvnSVAVFfNpQ42V+zNsyIcl2frNJYk1/7YTkmVAoVhdjgtZoeN2SCGWIshfPVekwFuHsCp50P75P9o7p+S/gTfHbXs2o9kLx6gHVdhprJPVpwbKyCXEvLwiWAUs8P3KWTwMUvG1tAVpOV79usV/oZ5WWZwrnsGX9T1tPy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OvMXxrOj; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mj1/Xi85MjYsDgZyLkXjroaezYpn/DBzDzoo2HiGbn1b/dSUclqBHEX2wGuDJVKx3N8QDL9AVgPqgKHwC/Jcz8pXEk/CRp/ycp1s3D7r1MYZ242FyVF+ckix955Cef4eyGz07ZEiLh4Y3995rno1cFwNQoznX3qPu0fT5Kjz5H2mww0o96l7FOJU18luko0v2CHMCLFVXqn+UygUvYsSGpw00kkJope25Vny4v+mk863FFYYoWcmilcdepGdI8M1LzKlcuqkSPx+so68dzFxqBerIdGl1+8hld/fqC1LBGrIbQp3gzllp9FyvciMflIX4tSgnoozll44FM6bqqHMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHJm95KLTWJS5SmCUsVbN8DMJMtHh4lqQnzhMPE1D9o=;
 b=QjuV7r/ymrNp08gZTUPevzFcD7tMCb0IGma6a8IuupetRbxB1M0nbfZMm+CrGGmbCyj88ZA8W9Tw/Z6NzkhoiHn+a+SGTD5ZVkRQGsgPiwdF1XLmCmHVP1H/Jga+U2zjasTYUPTC+p0trvsrzYxl0BAsLbaYR9gZxKVPnK0lTAo/LrONp7e9sIT4O+SJ1wvR42rh1yL5n55v3BRZquXKuMSpChtrBGhUAY/+P2op/aTPieNQt1JjIG2NBAi6SZjlP/ODCEnf9fWilAorjOl25JTFIHyrhs9toyQab/0Sd1VqWE2pnjt5THexLoR/XdFkNucbwhCxAHqfi5qoUX3DEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHJm95KLTWJS5SmCUsVbN8DMJMtHh4lqQnzhMPE1D9o=;
 b=OvMXxrOjiqWa0SlLB9p3Iafq8b+M/zay/TVBPTYyQ24lbaybibk+AtlMXw3+gOgdJFXpeeE/vX6/xybLPo4fdCGzinSgnMrxm4zTpcjJ2ExF9lwdeSmXlNd7FIBKX9TWlZgRwnp/cPUAYIOZYBdDjPtxOn3fjwZKJhjqMGbhHIWDqOqgHUzc9Z31kGfJDOWaa7q6q0d20qn4mkDjqkNdvS+FjQK/h+3HS9uKy3wmLUq1EmOTKTMrTyDat08oBcDNw57n8JdTDxu41DPSz+F9UaDNfWMnXmarhwbgo79RecHDZ8kCXoYuhBzvud00g+q2gYCwsZT6okdQ/KPk2f6EnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 17:25:44 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 17:25:44 +0000
Message-ID: <9cb43d83-466d-471c-a101-b2394b281f0c@nvidia.com>
Date: Mon, 6 May 2024 10:25:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/alsa: missing a return value in unused
 dump_config_tree()
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Shuah Khan <shuah@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 linux-sound@vger.kernel.org, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240505210824.55392-1-jhubbard@nvidia.com>
 <875xvrif0c.wl-tiwai@suse.de> <a80cb2a2-735d-4539-a758-a536296975cd@perex.cz>
 <87zft3gz8u.wl-tiwai@suse.de> <ZjjsybLA3VyY0r_N@finisterre.sirena.org.uk>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZjjsybLA3VyY0r_N@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:a03:333::17) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb50558-e775-48a3-b3c4-08dc6df18f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU1TWTIyUnczM3hmYzZvVXUwRW9ucTNxS0R5QlhTOHNFc252RCt2SkJGK0RL?=
 =?utf-8?B?a3FaL0x4cXIzRFVvWTk0ckJQbm94cDJYK25McktUMXlIUFIzaisvdk5RSGpm?=
 =?utf-8?B?K2dlN2VSUk1najN4dkdxbjdHTXZ2dzY2YkRXdzl5anlRb1I0VXI2aHlRQytD?=
 =?utf-8?B?ejZqb2VVTFlkUXZtV2ZkTmNLK3ZVek1wQ0VyQi9GdWlldktja1hxbkpWMnF4?=
 =?utf-8?B?ZnpuUXJ4bHlJclQ4OGxzZXJvejZ0RU1VcHdRRDBwTFBBNUxFTFl2cGErTFg2?=
 =?utf-8?B?L1pWRkRNS3JaeGdJNTl0Sm9YREk5QW5KcWo5bWV1Z0JZT0IyZTdlSFVjdHc1?=
 =?utf-8?B?Y2FSYU4xemxQYkh1UHJtbGkvckF4WFk2SWZFamtMelhXSGZqSEdQZEVncE9K?=
 =?utf-8?B?YVpQajFNQVBZcnNoV1FJWVN6QXd4eTNjbTVHTzhXcWEyVWY2cnN2bThQOVRq?=
 =?utf-8?B?eldNdkc1MXJTano5T3FvVzA1RnZUVHVDTVpTOXJzUUtkbjdWYktBZHFKYWgr?=
 =?utf-8?B?K09sbXlZd0d4Zm5xcGppYU5TTm5OL3IzYnkwUURFM0NoS2NCQ2dTK2VaaXpQ?=
 =?utf-8?B?T2pTc3A2OFM2bjVXeUlDcVNOanFyQmo2SHNOMXg2SEMxa1MrTnB4MzF1VzlF?=
 =?utf-8?B?UkVqc29ZNDh2MWtqWEhVNnpTRG1wa2NvREY0THl6WW5xVElXV2lqRkM5dWdv?=
 =?utf-8?B?T1RtMmJPTkVxMTBVcDJoODFEUlVZZnVQRHBSMXJuTHRLdXA2WFovTHNBVWRF?=
 =?utf-8?B?Wk5Bb0pzdlJpQVZZZ1l3VE5GWjU0VFMyYlVIMTd0U1lsd0NkbFpoS1hnNm83?=
 =?utf-8?B?RUN3cm1PUXJkakdDZnFOME1uVXVONmJPUWRFM0pWVlcva3NRU2liNUFMNC8x?=
 =?utf-8?B?YXQxdHBmQ2dFZXNmbzVnWlVTVGJEREVqU1lGWFZzWkxDeXVGUGpiTzcwRyt4?=
 =?utf-8?B?WTBGMWloN0VkVldOSnZhOEdmUUtrTGxFTEpEK3k1eFdxWnU0cFpkcU56dG9Y?=
 =?utf-8?B?aGovRkp4clpjSzMwN01ETzFnQzM5NVptVzJWZnY5QitvZW1kcFFubnFPeURh?=
 =?utf-8?B?T0pNYzRuTWp1eU9YZkR5WXdwOVNxcGVYdG5RamhMRVNmYlVOaDNFQlI3TThO?=
 =?utf-8?B?WmRFSTFyaVN1dmxOWjlWMjRMZXpzU0QraytGOFlqeEJpZzR4QkVnSG4rR1dV?=
 =?utf-8?B?L3Q3NHFSZWJIbUdkQm52S0VHT2swUHNMTC83TmdtK3VRaFRiZkpsVnc1akFX?=
 =?utf-8?B?Sjh4QUY2dUNja1JqcWxkd0o5QU1LUWpFMnBXRmlvZXdqbDZHYTYrUHhIUldP?=
 =?utf-8?B?dTZpVFJDNXNCVVpkNVZncTFPQ2wrYm53Mi9SNExDRTAxb2ViYzZCZ3A3U1d0?=
 =?utf-8?B?dnYyd3czN3NCc0hQSzUrUG1jMHFXUzBaM1FrZkJ1djdYeExFby9lTURyNW1p?=
 =?utf-8?B?eE0wTksvYjRQd2hid0FHMFNNbm1SQ1F5dWJ1VUhmbjgxeHlIWTBneDVIL055?=
 =?utf-8?B?dXphYlFJU3JYQnRxNGZqdmRZdjRqa3RDcnZwa3JiOHU5VDJNbTMxMlh4Skxp?=
 =?utf-8?B?NnNsMXNCMjVXZEZaN0k3ZGR2dm5saGlDMTVublAzSldoU0JGaGZRNC8wUnRN?=
 =?utf-8?B?bHZqUEo5MEtFclpyNDFTL25HLzJYWFptK2pFeksySTFrVk1ZSTdBRFRoTTlU?=
 =?utf-8?B?M3pMTUhHWkp4ejZJa3JiZ0VtRTlXSXI2SFVEVVQ5OUg1ZzJuait4M1ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzVocFRXZkNmY3VSL3JSZno3SUhOMG1DNEhVbVk5cEVibExUQXR0WUJHU2lW?=
 =?utf-8?B?SWZ5YWJuYzFwWFQvbUc0OG9IY0R3VEtyVWY2elpETlFQaEtZc0ltQTV3eDJi?=
 =?utf-8?B?UlVIZlFVcUNmTm0xdDBjUXgwV0tveE5IbnZHMjdOQk9KdzNCa0k0NkJLU1d1?=
 =?utf-8?B?WGVuaUZFWXg3dlN1SDJIMkphaGRSL002V0VObGQrNzJybUM2Sk96bVB2Vlk4?=
 =?utf-8?B?M0RraFlESFo4S2xBTlV5TkVKQk1zZ093Mng4NzBDeGJITjlhV1ZVdGRPbGVY?=
 =?utf-8?B?VytwcHNVaUVNeWwxbklrS3FkQkpJc2YrZG1KMG51cEhGTUlKNmtlaWJlOHc3?=
 =?utf-8?B?QXJOc1M1enEwY3FWbkxZREhTV0NNaFhPWUc5c3lUT3FSN3dvMndvc09WUXB2?=
 =?utf-8?B?ZGdXZkhqNStydXhFMGIrYkhMU1oxNG5zM3lLSWdTbDBTZnpoVnU2dFdpNm9M?=
 =?utf-8?B?dGtJZEs5RlRvc3huQUpJT0ZBTVBvSnc5cGVabVRIU0doaWZZSDdOa3FWMlU2?=
 =?utf-8?B?TURYTjFYTGxwNHQxN2d2VmptcFE4Wit1b1lib3pNM2xvVkh5NVFkMWk2RWJ5?=
 =?utf-8?B?UzZtNXJmSHRSdmNXODZSS0p4M29saThOLzl0SG52TWlsN3pid1hwRlQ1Mks0?=
 =?utf-8?B?Nkw5c0NzOCttT1BlL3I0cGpKWExYRDRBcFVEY3BRMTlSQmpvVkNwU0krK2sr?=
 =?utf-8?B?Nis4Yjk4L3pLcGdTdTBqWmxxdVcyaDE4cERpNFdqQXl3akVmNEU3c0RXNmZo?=
 =?utf-8?B?TkJ6TC9GT3F6L1c4NHZVQWdUN2RWZmErWkVxQ0tWWldDQ3pyTElNT01vMjJ5?=
 =?utf-8?B?S1dONUpIVnJLcDNiK1J4a21Hd0w5R0hiRFBvdFJDMExYVmFLNlhtUWRYOC9R?=
 =?utf-8?B?Si9IQWQ4QnRabTR3SnpkWEtZdDkyUE01VFRPUVF5UzZMc1NxejlIaVJubVg0?=
 =?utf-8?B?V094THN3dmwxS1ZncGFuNVFMZUJSWXh1V0RFU1EyeU1sUHVTK1VmalZxM01V?=
 =?utf-8?B?aEdzaGJwTTZudUh5UFdlTHRTdGcwblVxOFg5OEpYWDNYU2RjZlZ4d1paUUR5?=
 =?utf-8?B?YmFLKzZWNEsxeVI4YWdrOFdQdVc0R1Jyb0c5NWJxZ2xvZzB6REVtUjVFTTlR?=
 =?utf-8?B?MFVaeGxUZnBTZFB6d3RlaUprVW80Z2w2Q2RHcFJxNjZsWFh1V3QzSmZ6L1pV?=
 =?utf-8?B?ZWJuQTJQeWIxaUJBU3hBUVJXbEtWeDM4QkRLek9UdXdvT3FUMHYzWHh3TGND?=
 =?utf-8?B?R1BkS0hXZWhwOG5oRC9yT1NrQjFFOThOU2MwbUlUSE1FQnVuUDk5NllTaXBt?=
 =?utf-8?B?K2RMcEpuNmNmaU9IcDNXdEV2YmdsWFBZQ1pyclZIRnpwMWE3T3pmbGFObnpK?=
 =?utf-8?B?L0I0c25WNExqZkZJVlpRZ0s5TENHRlhqU0czckZ1MXBoZWhVVDI2blJxQnhU?=
 =?utf-8?B?Z25YbE5DV29DK3lwR1lmZjhDcnZySDZiT29lSWVCcjNpWitDYVlWYzdUTnNm?=
 =?utf-8?B?QWpqTDJpa2ZEZmFRS0ZidENhQUtkVmdLdWFCTFE4dnZZcStXZzRCTjJacTFu?=
 =?utf-8?B?cjhKa2RHYmR5MUljV0QrWTIzV3J4T2VQU0lCQlVScGQ5OU0wdG0vZGo2SS9R?=
 =?utf-8?B?dnBPVEYzdnBRWndvV3IxbW0xSkN4eWcvaDlhSXExOFR2bDFiQ2ZYMW9Jckcw?=
 =?utf-8?B?UFJrd0gxQ1lucnNvY2pqc1ZscWpvSVdWVTdlOXhNNS9PcElNR3VNczUxL0RM?=
 =?utf-8?B?bE5LMm1DelE4eVZHdGI2dFNNSTVrenUrclp1UXptV1NLcXdGbDNRVzFQR1F4?=
 =?utf-8?B?T0h4RXk3U1FuQWpTbHBnOTlqbmFqQ1RINnpXV213aU9KVmFxTUJQeG0zQnNa?=
 =?utf-8?B?SEpmMnZvMlhacUZ3VEZYMmgrV3ZJWnVVT1JMYzlZS2NNTmNMWHJ5R01mUGlL?=
 =?utf-8?B?NDVrK1RXWWJQZTNpTjFndkZ1YU5lbkYzZFJmQ3VDZGUvRU5QUmRIQ0JsWmc1?=
 =?utf-8?B?b1lUcmM4dEJvaGFkVUZSK2wyMk5JYUNNWmh2TkluN3ppamNEcEEwbnVFdElv?=
 =?utf-8?B?bU1FOCtiYkIzRm8waHlrM0RDcndEY3k4eHIrWUorOXVIbkxERHo3emt5eWxw?=
 =?utf-8?B?Y2NpWG5hWWVIT3dyWnpSQmRXU3ZOM2o5MTN6M1FJSTFyMUFVdzYzNWFFU1Nx?=
 =?utf-8?Q?1TvXMxPdJ3ZQ1H2cYUvNFq4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb50558-e775-48a3-b3c4-08dc6df18f82
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:25:44.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pqf6mJ3ab01C1+e91wh3cTwzdNhlSnfv9g/DJI6GGTpGDW4eGqP/MJLUZ8b4ktGmMPbFI+tmuYDcFp6CCKTyQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111

On 5/6/24 7:44 AM, Mark Brown wrote:
> On Mon, May 06, 2024 at 09:45:21AM +0200, Takashi Iwai wrote:
>> Jaroslav Kysela wrote:
> 
>>> This function is nice for debugging. I'd prefer to keep it with the fix.
> 
>> I'm find in either way; just submit a fix patch, then.
> 
> The fix was already submitted as v1, I noticed that the function was
> unused in review.

It's generally considered a best practice to delete unused code. If
there is something you especially like for upcoming code, you still
have git history, and even a lore.kernel.org link, to bookmark it.

So I'd recommend going with v2, but of course it's your call! :)


thanks,
-- 
John Hubbard
NVIDIA


