Return-Path: <linux-kselftest+bounces-32338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9861BAA91DC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 13:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9514163A6E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2A202C46;
	Mon,  5 May 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a3YHi2i8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B714A4DF;
	Mon,  5 May 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443822; cv=fail; b=VDvPaAm93OlRdZ1XByxA3mhmGkh+rJLuf8EI/j1aC5eCG2glbhW2xtKzWDUGTSgQpEZzQENEHbCG1XCuB/9jqLCX1eL3y4YMUBs/W24J06nNWsGPWTMJht0Xg7MhrzUFXnC0DHFXGXgFOrpuS/YOf+M5gq8+yrDPigeaOR5YyjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443822; c=relaxed/simple;
	bh=tk7/LLGt7000jGqXYEaYUSdlnqFCtIsLZQIv7SUP/p4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q/mahf/tPRZRBfbHE99YFa4Z+3XY221j3ATDpo8PWM2dN/f6Khe6RgYJDy2zKlUVcHN9AqjQEnIL6FcOzpZHEmD6sdlDLcdA3FaIONYZB7yznf/dgbZrlBk8X2Dk11ylqMQrWostC9Fj0vF0cAW7edaD8Rb5DRUyaRWVFql5SmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a3YHi2i8; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alyt63YhhZHyBbP8TZA0XSzbjM8fVBpq0/Wbg2avXaofOYzpsbHj23qPjnx/DQI79q5Z7Y7x3wup2l6nrB8/kg2uPf61AhNAkox1gfs3YJkcUoMaqKrGVJPbWAEqJ1DJxjqSNcGecSkU69l5vh7IG6jvfo1jMyxzdAPK3isoL9754fSpDZP4Bh+yOX1C4ccxB8GzbVxaz45x/82mAABHyp/mFsWVBDvOLFeTaIhH+Jc8bw9LNmd7Kjrv2TqVEZDdIEqnPm5xT2b7lIVpFcNFx/3qhCZioNACSrycEKfaK5KrMmHC83mpBxAE0IqqFCqeOxt4p07gE8Noa1fi+p1Uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85QeGwC+/qSz3DdfgV812lgPNPZ9j56QzC5kf4v5nJ8=;
 b=H859cjVCc+rupffpSsPZ8oCe7LTjI5WmWZLJ9Jn33GF6YU7otGzDME2cptHJE8qRnz62XAJRI6PUBHNN5boQEY7/gGn6Op7Q9zv2bYSECC9CnETI5bBGaWddLb04MYfvx3XKuqWP/l9mQ8f1qKd1XwPl/2GIhCrzZiiQ3a5jnIxT1Eli0Y1eCgypKYT7sLID25ijBc2jxoELF3zIUrR7ahHyFBitD0SiF1aqre3oFEnVZjAi2lu8myqx3g2SKIsRmaY/rJA56AKntfHsPJsH3MqvXWHwBTW8KDDEyPVkWFHkJZHztvQCv1AeCO1AgAtgo4t5TlFFboH2e9VPxF55Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85QeGwC+/qSz3DdfgV812lgPNPZ9j56QzC5kf4v5nJ8=;
 b=a3YHi2i8qd26ThIE3jRcGQNnT4vc6X6+FN8Ts/bS8iA9CXcGEwckBmWcjgrSBwXBYqgK7VJ7GodwegAlDbNw1ffLhMPj28N4mxAPmxqsC1XzMTD7I1HH2hBoPEOn1u01lMKgStzc9f0PKx9U5cOvr7xA/Skcx13uUwe61H2WCtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 11:16:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 5 May 2025
 11:16:58 +0000
Message-ID: <26ca8ddf-0d78-462f-a47d-a1128b2e058f@amd.com>
Date: Mon, 5 May 2025 13:16:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] bpf: Add dmabuf iterator
To: "T.J. Mercier" <tjmercier@google.com>, sumit.semwal@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, skhan@linuxfoundation.org, song@kernel.org,
 alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch,
 corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 jolsa@kernel.org, mykolal@fb.com
References: <20250504224149.1033867-1-tjmercier@google.com>
 <20250504224149.1033867-3-tjmercier@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250504224149.1033867-3-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: 83675723-66f5-48ab-a9bb-08dd8bc659c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blJwTFdiK3RLWkFKZ1NaRFE5Y3hTNjBlY0xoWk1USE5ReXhya29uQ2Z1d1dp?=
 =?utf-8?B?dUNyYkZwZElzd0VvTzVtRmllVFdxSEN5RnJPZE1lWlJwSndUL1JIWkJBSDEy?=
 =?utf-8?B?MkhSeGE1SUhYZU9ENHJBSzNabnR6QXhQajU0MkpXUGJmNmd3eEJNSCthZ0VR?=
 =?utf-8?B?RnUzNUJBSlNzZ0E5K1RKTkQwVkJnWmNoV0VxeUVpOERGWTA5RjJpaXA0eXJ6?=
 =?utf-8?B?U2lmTlVBVWhsYzZXV3VBbnVxenhzazE1YmZ5eDIveGlsbVhuWTRzNExGRk1a?=
 =?utf-8?B?czkxMGlHM01IL1B1VEdlQlVFTUsyV096a2tvSlhReWswdkFoNGxPVDdpZmd2?=
 =?utf-8?B?VUVwZXc5azdKbklsQjNkcnhINFUzYkVxT0VLd3hOaFlFTDhCUEVuUDU1OWZR?=
 =?utf-8?B?S3JiUWJ1a1JMYjdzMXVUUG5zOENpRHAxS1pXRzRja0lPOExzUmtxOGErcCt0?=
 =?utf-8?B?RkRKSXY1ZkQ2WXhYTGZVeHlRbkZZcnpPeEE2MG9vU0NWdnYrL0tYaGF2N1RF?=
 =?utf-8?B?MnYyVElDZUdsbm8wSzVRTWxVdEdaTk5NTGxBbFduOTF4VmYwVEVKUXEzbFpZ?=
 =?utf-8?B?R2Z1bkgxSCtDRWw3d1g3L0hQczZNVlRHU1psSkVzc3VGV285SU5hV0RiUURC?=
 =?utf-8?B?WkdWUXMvMWdOeWtkSjhjbDFIb0QvUW8yT1FBVDk5b1VKWnRJVEJjL0tiSlNJ?=
 =?utf-8?B?RnRsTkJnMU9yVENwOGVVUzhvemhzZEVzZEZDWjRMUjl4Tlh3Wi9TVkIrT2k2?=
 =?utf-8?B?UmxTRmdvaHhFVldiY2xRVTR5UkxmT09MbUQvam9HRXppRm9rQlRqTWZRKzFK?=
 =?utf-8?B?WExuenhNTEtnNG9ELzZjWjBXYjc5RzdtRm1zTFY2Y2N2c0dnVDlJamt6RnNs?=
 =?utf-8?B?eC9QQWRFQkhZajhqMWRrdEZYVGExNHdXREhHcTRDdXgybmtZRzc4bkQzT3Bz?=
 =?utf-8?B?VjlQd0JLcThLSTZReVNRQ3YrekxZMHNRVGUrODlxR0U3d0cxNFV5ME8weW5J?=
 =?utf-8?B?M25qN3d3UmVnK2RFL3lUMk50ODE1SW1iNFJGM0J5eXBSalVzQkxGMlhwZ213?=
 =?utf-8?B?d21ibzJqTUh2ZGtpM0d6eVllODluYlY3MGVyMnRzeG9oSFVxZXkxVUJVTStI?=
 =?utf-8?B?VUxSN04xc0JhMzNraWQwT3BoZ0x1enB0R1BvQ1hPNnYzeGlFdDVZWVl6bmRP?=
 =?utf-8?B?WlprSUJGRG5LWDR1MXhJVFc1Ti9DWHp3MFJKRUtjUDhaYXRsQ2dqVTU2U1cx?=
 =?utf-8?B?NmhocUJtZ2VrUFBVQ0lUNytlMEdIWmN6bkRtalZXY2Z6eVdRWDdlT1ErbEF4?=
 =?utf-8?B?VldPVWtnU25iKzl1VnpnckI2VnkrSXpVZ2RsTHFpS201N3FRb2NjOC83NW41?=
 =?utf-8?B?STlPengveForaWZIdjZDaGpZZ2hxN2VYbEtOTjRxNFNlbWZ3MXBNc21tek5T?=
 =?utf-8?B?R0dnVGVHQ3YxWFNlZ0tKTFZBaVdmRFpTYnJuaE1yaWdGMzFhT0V6aWVmeEpO?=
 =?utf-8?B?Rjk4Z0N1RUtJRHdVNWdDd0NIancwM3BhZW0yUlF2YzRuOGlON1BwYmQrZVJZ?=
 =?utf-8?B?UDBaRUZxeGJsSjZ4bGdaVkdLaENHTnFDYmNRcVR4S0R5QnJuNnAxNXJNK2d5?=
 =?utf-8?B?NVlHVnE1QUc1UE8xZXVEYUhVZTJEWFhlMGpVZmtlNGdmZWk3cUZxS253ak9p?=
 =?utf-8?B?ZTlpQXN3eVdMWW84MjdtWU8rc1VpNlJGOHA2MzRwUHhJbTZtK0pFTXNNbFBU?=
 =?utf-8?B?Y3N2ZlFuZ2s3SVV2TURlMmNaMHpkNFNzZGFvVmRobjJHaGh0dHpVTnNndUV3?=
 =?utf-8?B?WDNkaUZpYkkvYWYvUmMzNXhMbzdUd0g4MVNGdWZYL0tTQ0c1WWtobXJhcWp6?=
 =?utf-8?B?eFBsY1J3M09zODZFWmtTS2J6YjN3cDhrc25idnRBdFJSRmhXL3ByTTN6Mmg0?=
 =?utf-8?Q?56dwQJnbksU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1FvNHpQVXNZUGxHZmJPT1RWbzVkZDVhVE52ZkYySEt2YUROZmtkblNFNHBQ?=
 =?utf-8?B?eTY1Z3JyYUV4VVhJNEJvL3dRd25zQXNxYXhqVUdoS1hJRXlTWnpqdXh5QTla?=
 =?utf-8?B?YkdUems1dnpLTUtpdHFOSnJqUXVqcmZucHhoRE1XYzhUek9sOTN3eHNjZ1Zk?=
 =?utf-8?B?Yjg2b0U5UEZCbnFGT2J6UUJmTnRnR3JNTUdKTGZTNTVsSEpaaWNQeGZhaTJR?=
 =?utf-8?B?TDh4VXdKSlI3QzR0UlBxQXRTREwxYjNaWnlkbHZUQUZSQmRsczk2ajFmdVBr?=
 =?utf-8?B?dUF4c2g2bURZYWJraFVuZ3piOGVOOElzR0wxbzROdlpLdDJuUFRCMWtVOVNF?=
 =?utf-8?B?V3ZYdDJSL3hia3FzTnFERXNuVXFDYVkrVUFDNVZPZzl6NzFOajY0aEJMVUZU?=
 =?utf-8?B?UWVVL3pDMGl3d0UvYm1tS1ZKQ0VxL2E5Q3A0N2JtVFRLN29CbHJaZE04RG1O?=
 =?utf-8?B?dVAwMTN2bjU3cFVDYkI1dkFpdlowUHNlWmRtelJMWjV6TzRTclR5ZnNpZ2pv?=
 =?utf-8?B?cDRVdFB3SnRqS00vbi95a0MrUDlvQ3RPcDhIMXZ4ck9OVStvS3c4dmNaSGdx?=
 =?utf-8?B?TE5ZQ2NBZUdsQkJiZmlHa211aGRaYi9MRkJCZUdHL2h4b2RhMHUzSjdmbGlK?=
 =?utf-8?B?N29LVThWKzF5eWFoTG9VNjFLZVBDaTNZSGl3TDkwSGlUU3V5aDVOakw5S3Nh?=
 =?utf-8?B?ZEllSkEvSldaa2FVck5ndjdFWUY3YWt0bE1wK0F5ZkIyaWJsbU9zN05hTHpK?=
 =?utf-8?B?YmpweGtJTE92eFpjK3ZYc2w0Vm5ZN3BOZk5CNW1FUUd1SmNDSG5SeURFVnp4?=
 =?utf-8?B?cHVtcGluZjVGNC9lMjNLTC80VXloam5kTzZMSzZtNnM2aERDYytBTndHL0ZT?=
 =?utf-8?B?NTVEVEgrbDVmQ1hFNGk4SytvYnlPbFAycFYyeE56YjVRZExQS2FrZXlpRHVM?=
 =?utf-8?B?aDN6ckJINnNIMFRZL1NjVzZhTnZJWWExaG5iWWdib2ZlNVd4bnB1eWJRdGk2?=
 =?utf-8?B?UjlLN1pNQ3NKRG83SzRkNXhTOWFWUVdSUlhsd2RaQ2diYno3UCsvMmZpWFRS?=
 =?utf-8?B?VmMxNzdjaTRPUVdOdUloS0psTU9ObDVxbGR6QkppeEtKbjI1OVQ3M3k4K2N3?=
 =?utf-8?B?dkJ5V2FSS0NBSU5NaS92bld4WU1weGhvSng0dTJHbmN1NmpIZ0tXeUFBR3BM?=
 =?utf-8?B?c3ludVhLMDI5SnpMUmZDRWxkTnM5S3pQNlFscmpBYVNnS05HSThLT2Mzb1Nw?=
 =?utf-8?B?VytySnNVa3djUTI2VTJYMUpVaDMrV2pzYmJKRjVMeVVJSUtManVBNHNHRXJL?=
 =?utf-8?B?WENScmw3YlQzRjZRQTdsanlMSG9oOEw0clhZM1BNZlB6NlNmK29vTk5oaTlT?=
 =?utf-8?B?VjBxSG9WVnQvVkR2enRuUkZtQVJtSWpLeU5RMkpuQ2EzQTNqSW9saDlldDNI?=
 =?utf-8?B?a1YxTDhOMnNaanlQQk95dU45d3ljanRiRTNVbG9rZ0JyaDlIWUVQaFNUSEd0?=
 =?utf-8?B?eUx2cS8wYVR3eitXZU9qZ0ROaHJORWRUWVdkWm8xKzFidU4rZDkwbUVNTTFJ?=
 =?utf-8?B?UnNnYU4rR1BRTnNzMm9SakZSSFRlemlMSEg0YVNBUnlaalg5M0FBZ1dPbUMv?=
 =?utf-8?B?aUtTNWhFa0tIeUVxWkhYK0VvRlA1Sk9MOTdSNU5DM2h5cDc5ZDhHSUNIdkhl?=
 =?utf-8?B?bE04NHhvbk5QNi8rWHpxMjNKY2FoR2p3TnBJUHVVRGp3WnA1cUloV3g1UU1U?=
 =?utf-8?B?UDdhLzBDMnRLMU00dlh0ZmVwamdFYmhWK0dDYVg5ODJndm1pR3N3bUJ3bERx?=
 =?utf-8?B?M0x3YStnMCt2S2xPbzlBMGY4Sm5jeXk2WDByOTA0emhpNll0T3Q2M0x2bnpl?=
 =?utf-8?B?UzBYWld1RUFwWlRxTlJVS3ZXTW1IaTRqcFNiajZEUkUwTjNEZ2M3Y213T2pN?=
 =?utf-8?B?b0RJMUxpSlhlREd5TGU1MGUzWkREMDdtb1BuQ1R5eiszM3NOaHJiMHJpcnV5?=
 =?utf-8?B?d2ZTSmY2eXptcW41cDg5ZnFBSG5oOHVDRjlQUjJWZHVyRWVQN2RUb3RsRWtB?=
 =?utf-8?B?Uk9MVE9ZQTZscXNZbityekJtOHRaUDhRaVBKUG1aeHF2WVdsWGYvYVltNzhG?=
 =?utf-8?Q?S/UTdj+KRWTmAA/HrYcXAAI1F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83675723-66f5-48ab-a9bb-08dd8bc659c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 11:16:58.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLjKKkUWzLPXTNQEp+vaowST/pqX+bV1yBHUOeBCxHe5ntqfX8KLxrkgAVKGAbUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611

On 5/5/25 00:41, T.J. Mercier wrote:
> The dmabuf iterator traverses the list of all DMA buffers.
> 
> DMA buffers are refcounted through their associated struct file. A
> reference is taken on each buffer as the list is iterated to ensure each
> buffer persists for the duration of the bpf program execution without
> holding the list mutex.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  kernel/bpf/Makefile      |   3 +
>  kernel/bpf/dmabuf_iter.c | 134 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 137 insertions(+)
>  create mode 100644 kernel/bpf/dmabuf_iter.c
> 
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 70502f038b92..3a335c50e6e3 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
>  obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
> +ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> +obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
> +endif
>  
>  CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> new file mode 100644
> index 000000000000..968762e11f73
> --- /dev/null
> +++ b/kernel/bpf/dmabuf_iter.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Google LLC */
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/dma-buf.h>
> +#include <linux/kernel.h>
> +#include <linux/seq_file.h>
> +
> +BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
> +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_buf *dmabuf)
> +
> +static struct dma_buf *get_next_dmabuf(struct dma_buf *dmabuf)
> +{
> +	struct dma_buf *ret = NULL;
> +
> +	/*
> +	 * Look for the first/next buffer we can obtain a reference to.
> +	 *
> +	 * The list mutex does not protect a dmabuf's refcount, so it can be
> +	 * zeroed while we are iterating. We cannot call get_dma_buf() since the
> +	 * caller of this program may not already own a reference to the buffer.
> +	 */
> +	mutex_lock(&dmabuf_list_mutex);
> +	if (dmabuf) {

That looks like you try to mangle the start and next functionality in just one function.

I would just inline that into the dmabuf_iter_seq_start() and dmabuf_iter_seq_next() functions.

> +		dma_buf_put(dmabuf);
> +		list_for_each_entry_continue(dmabuf, &dmabuf_list, list_node) {

That you can put the DMA-buf and then still uses it in list_for_each_entry_continue() only works because the mutex is locked in the destroy path.

I strongly suggest to just put those two functions into drivers/dma-buf/dma-buf.c right next to the __dma_buf_debugfs_list_add() and __dma_buf_debugfs_list_del() functions.

Apart from those style suggestions looks good to me from the technical side, but I'm not an expert for the BPF stuff.

Regards,
Christian.

> +			if (file_ref_get(&dmabuf->file->f_ref)) {
> +				ret = dmabuf;
> +				break;
> +			}
> +		}
> +	} else {
> +		list_for_each_entry(dmabuf, &dmabuf_list, list_node) {
> +			if (file_ref_get(&dmabuf->file->f_ref)) {
> +				ret = dmabuf;
> +				break;
> +			}
> +		}
> +	}
> +	mutex_unlock(&dmabuf_list_mutex);
> +	return ret;
> +}
> +
> +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	if (*pos)
> +		return NULL;
> +
> +	return get_next_dmabuf(NULL);
> +}
> +
> +static void *dmabuf_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct dma_buf *dmabuf = v;
> +
> +	++*pos;
> +
> +	return get_next_dmabuf(dmabuf);
> +}
> +
> +struct bpf_iter__dmabuf {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct dma_buf *, dmabuf);
> +};
> +
> +static int __dmabuf_seq_show(struct seq_file *seq, void *v, bool in_stop)
> +{
> +	struct bpf_iter_meta meta = {
> +		.seq = seq,
> +	};
> +	struct bpf_iter__dmabuf ctx = {
> +		.meta = &meta,
> +		.dmabuf = v,
> +	};
> +	struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);
> +
> +	if (prog)
> +		return bpf_iter_run_prog(prog, &ctx);
> +
> +	return 0;
> +}
> +
> +static int dmabuf_iter_seq_show(struct seq_file *seq, void *v)
> +{
> +	return __dmabuf_seq_show(seq, v, false);
> +}
> +
> +static void dmabuf_iter_seq_stop(struct seq_file *seq, void *v)
> +{
> +	struct dma_buf *dmabuf = v;
> +
> +	if (dmabuf)
> +		dma_buf_put(dmabuf);
> +}
> +
> +static const struct seq_operations dmabuf_iter_seq_ops = {
> +	.start	= dmabuf_iter_seq_start,
> +	.next	= dmabuf_iter_seq_next,
> +	.stop	= dmabuf_iter_seq_stop,
> +	.show	= dmabuf_iter_seq_show,
> +};
> +
> +static void bpf_iter_dmabuf_show_fdinfo(const struct bpf_iter_aux_info *aux,
> +					struct seq_file *seq)
> +{
> +	seq_puts(seq, "dmabuf iter\n");
> +}
> +
> +static const struct bpf_iter_seq_info dmabuf_iter_seq_info = {
> +	.seq_ops		= &dmabuf_iter_seq_ops,
> +	.init_seq_private	= NULL,
> +	.fini_seq_private	= NULL,
> +	.seq_priv_size		= 0,
> +};
> +
> +static struct bpf_iter_reg bpf_dmabuf_reg_info = {
> +	.target			= "dmabuf",
> +	.feature                = BPF_ITER_RESCHED,
> +	.show_fdinfo		= bpf_iter_dmabuf_show_fdinfo,
> +	.ctx_arg_info_size	= 1,
> +	.ctx_arg_info		= {
> +		{ offsetof(struct bpf_iter__dmabuf, dmabuf),
> +		  PTR_TO_BTF_ID_OR_NULL },
> +	},
> +	.seq_info		= &dmabuf_iter_seq_info,
> +};
> +
> +static int __init dmabuf_iter_init(void)
> +{
> +	bpf_dmabuf_reg_info.ctx_arg_info[0].btf_id = bpf_dmabuf_btf_id[0];
> +	return bpf_iter_reg_target(&bpf_dmabuf_reg_info);
> +}
> +
> +late_initcall(dmabuf_iter_init);


