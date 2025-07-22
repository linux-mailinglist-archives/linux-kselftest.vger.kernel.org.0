Return-Path: <linux-kselftest+bounces-37799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12770B0D28F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D285C7B216E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EC22C1581;
	Tue, 22 Jul 2025 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RxkidkaG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F52BF015;
	Tue, 22 Jul 2025 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168896; cv=fail; b=mehyZ8Woqlz32izi1992v4BSXX1a3kXfCDrgj2t/Z0M3p3GzAL4WcA3cBLelEW5H/2TSInuaeIcPqX8C/3azWjSwpMXiB94BNCyAHbhDyiBEQJNdesxyET3Gu7mHS2eYExEm4EiAsOQdXK3YFenCJYbLWJbT+Ci0bgh3LhK77Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168896; c=relaxed/simple;
	bh=FTSNTD9H3N4D+4lv929yawkP+uEIHTXHXQvS67Vn2jw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qgg+Vt+JzjDmB/qBVKalE2V+IvSppDzbjVEUTDDP78vx9kTMpe3luSzHCtZZkveYt7GC1NfrW9JK+g+ZPEmAmiYIXXiWQIoovkrVzuw8wZ/FcbbNDSGnFrwZsX+m7Z8QRqvYE+0LLi+bu7MaH4qRoujGPc6dUyRwkLnM/GTUFJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RxkidkaG; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsLhOAFZbAyGEvqNxFkZEHAjSAbh/Vh6kkRSMbfByZlLJzatigWEgyqDGlXLCnRcioUJZyJKLFsVelS9+DM0tfJecQLXIVhoYbClc1wt1PKH1SpOnhCfd3LJPxfwitQnPsmpQBc1dzkfepWpMUZEYT5dDMlMShVYUqb423mpLV2aWIbNjYbQnqpU0oOL9B4sFUbOSsL1D5BryeTQccvAeS6rnzjoixdu2jO/Cnyppb31J2CvhkOUc5v4XtREXByf71979dexHRYx17qnR3od0GALMjo0yAYz2xczoTNcX2olL/n9uf84u9rJz4fS1P6Xa1rF0hsjpW45Mt6tSMGQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M60U9KtDzz+Yk5URKC709I2SR2rzi6+QaVe1heuHA8Y=;
 b=T9ciK91vGehXWzmkjzQF97B6NB2bGIY6xSB1pcdFGGl5DXMJ2EVtR6ag3A6NCgZnTYglrQMMYKNqABBA/SKefIFsywmy+R7bx457X7HRPdBuqbDURiQdSzl2pgIBgMexW1dfhsHlRt4cdSPTKDF721Q4lSNiv1yeXTOBGGAnHy505u5qaKPZrVZgJp7jMfjaLwqTn+lyW65pUthIGGlhekJNSdBv9EK57hYz1Fl/RIReexvIY64hSu3vct5Wm42CSG6N/J+IrRaERRpF+I112Dj7zJLFmCbdyDII7NbzgQiPBeRPXxW/ahr1IiipuQBhUHt3L+sWQYhCDTe5qV/QeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M60U9KtDzz+Yk5URKC709I2SR2rzi6+QaVe1heuHA8Y=;
 b=RxkidkaGwRANTfRaF+jEP1Nj6U1zHmjaWFElk7KzlU+GGG4iaSqsHgAg+fUZK9VlbEdHPQNiJJEAxEXQmCrS2wXAlFO21Jy+yKHVe92WeNmU0MVrBk/EvTynwBIaSA5o1HnNs8H8JbDUDrt8HHujKAkBBm1V0bx4UbHZJbvgC7tvXac0GrnOiAhkrtHWy94WiOh9n3d+ZcfIpBXiwlxUfoztGho9PKUJIJeenP2mMMHIsR+9+dQqHqTB35e+J0l5Um5kddRP58FxDR7QN5Q1pnDLjDTfw2eHjDhxypPBhbu54OKamTw4b2tRCzr8P6k+ZPTbtSBRyHdbq23pgyxthA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 07:21:31 +0000
Received: from IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41]) by IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 07:21:31 +0000
Message-ID: <60729195-9c48-45fb-99c0-8965c95927df@nvidia.com>
Date: Tue, 22 Jul 2025 10:21:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nimrod Oren <noren@nvidia.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 tariqt@nvidia.com, thoiland@redhat.com
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <20250719083059.3209169-3-mohsin.bashr@gmail.com>
 <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
 <20250721084046.5659971c@kernel.org>
 <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
 <20250721133325.73e2f076@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250721133325.73e2f076@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To IA1PR12MB7496.namprd12.prod.outlook.com
 (2603:10b6:208:418::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7496:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 327f0d65-21e5-42be-a122-08ddc8f06124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlAwcHRDdVhWNldiWUFtaDJwRUlkRWtYRGVZdlNiUnRscFR0NHJLMkN2MGo4?=
 =?utf-8?B?cnpFdktZSVB6Y2ZPbEt5Y0p3RE1RVFdrUkdFOUtJQ1ZRQmJCWDNjTjQra2VO?=
 =?utf-8?B?V1F2M2pQYThCdkFkUTh0WndxMkV4ZGVMbzJlNFE1MWtscXVZSThiczR6YlF1?=
 =?utf-8?B?Q1N3RUFFelJ1bEVma2oxNUNneHhVMHl4c2REdUpnRkVVOEQzeUwyWkRCMU9w?=
 =?utf-8?B?WG5GUnRMTndLL3lXeDlMVFBIWWViMXoyMWpZeTM1L3FIRlZvOWwvS3o3Und6?=
 =?utf-8?B?aTlXZy9iQy9CcFdObjBFS2cxRERkWGwzNTg4SlkwaVI2S2l2MWFieUxDSVl2?=
 =?utf-8?B?WEhNejliaXBESHpHd0YvS2hENjAzeDVSbE9uSU5hd3dsck42WkpiUWlJOGtl?=
 =?utf-8?B?MzFZWDhzd2JWTXNIUytnWXVRRW1GUlpqa2c3SlVWeG04S0I3M293Njc0NGpo?=
 =?utf-8?B?Vk9LbTJxaFNieVRHelEwRWw5TkRLSjR1aHIvdWlnMXdtYzF0MzRXRFN5RjVV?=
 =?utf-8?B?OHhmdXJwT2ZPeGFtN1RqYjFjOS9TZTI2eU9aVHBWdFE4a3ZzdXRYdFFadEdq?=
 =?utf-8?B?Z3Q2bTBrV3J6RXNzM3pRSmZSay96S21WaGNOcW04c3o4S3B2ZVVFK01WYzBB?=
 =?utf-8?B?bGlBTXprRDdkSTBnMlcvM1lmdXBNVWt2KzBRdlFCNXo1YVg3eVZ2VWxsbldW?=
 =?utf-8?B?YUw0aEFJb05wcmNBV1RXbVJTdm5IN3FNc1pNcEF3Szh5VkN3d1VRZkpObFN5?=
 =?utf-8?B?TTRTNGNLQyt3cE9NYVNYTHJUeVZQQ001QURUSmY0M1F5WTBMUytyTFZ5cFht?=
 =?utf-8?B?Yy9QRm5YUFpac0lwYmtMbFFtdzZuWDdsM0NXZ205RnQ3M3IxNDFrc2c2eXpt?=
 =?utf-8?B?Y3ZUM25zSVZqYWcwbEtaMWNvb1h6b2dLZ2dsVmlLbW1SU0FzeWdYMk1ueEt6?=
 =?utf-8?B?MjJJYmRxZE9Ud0dWaGl1MkxicW1rbG1RQVdZWk5PMW0zMHNnR3FybDUyaG5T?=
 =?utf-8?B?eDhIMDdyc0JJZ1ZxTWtMLzAvbTB1akhvcFlSNSszRUtSOG5MTm1DNEpnMU5G?=
 =?utf-8?B?UHRJeGdlL3JtSlBUWFBLemFUMUFsY2NoS0h5ekk2QWpsRnJoelV5UXJrMGZz?=
 =?utf-8?B?MHBWK3I4YndHZDQxRjlwcjMrQjZNSEJubFFjTWhDRnRsdlJmeUFaeEU3aURS?=
 =?utf-8?B?YzdqNktCRm80ek92d3U5eTEwcFQ3ZnU4U1Q0K1FVOEJkMUw5QVE3K3V5b1Jw?=
 =?utf-8?B?Tk41M2VzMlBMd3IrdittZHFoUjlIODVnTEl0WENBdzE0N3FYd3VsdjEyTTAx?=
 =?utf-8?B?K0FncVJmYkFFWE9xRzZjdW9KYzcvc21PNmoxZGw4dXgySmpXbW1QTFVQYlVH?=
 =?utf-8?B?OGh4SUY4dlFVdVJSajBTVU4vd1VoallxNDh0NjIzcDA0bU4vYk1IaHY5L3Y1?=
 =?utf-8?B?RUhaajltdkxaY09WUk4xWS95WU5MSm43ZFRVYld1aFpwYndPbXk4SHY4ZWZK?=
 =?utf-8?B?bHhOSVBrSWJhY3dQaWcwY0NPWHpDNEVDNWcyRGZmc3UxcmtDaWNFZVE3MEFX?=
 =?utf-8?B?SWJZZXkzelFkbzFieFQzUzV2Q0RSdHdKNGdWQkQwb3E0SU5hNXdIVFJEUmxs?=
 =?utf-8?B?K3dDOEVFUjhGUlFCdjFONGRLd21Sa1VVOVI0Wld2aWMrWkxITTN4SFQxNHU5?=
 =?utf-8?B?KzlYSnpwaUNISDIzYnhIS0lwWHJFMVBZMUVYRmxuKzZCcXN2WnFpVDdoOERa?=
 =?utf-8?B?Zk5XTHYrdmpOa3QvUlpFN0M3RE1iM3RBNW85UVVkelMxY0Qza21jcjVCQzBI?=
 =?utf-8?B?VmlRODlOZEFUaGQyTkFOemh3ZnJicWdJZERpeHl6TVY2bFpZa0JLRTJ4R0Nt?=
 =?utf-8?B?V1p0cXIzNWtSbmgvWTRSRjRVVzVIQ3BvSHFWQUtlUXBxVUdGSHZiS3p4UlJj?=
 =?utf-8?Q?0/InDrhCTzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7496.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUNpc20vNkJaVFJMY1l5R1lGbFJLMUVrcmdCSGFlM1NSRVRQc3VCQWJzZ2Jw?=
 =?utf-8?B?anlDZnh6SlNWN3l6eEhscGZtMnFVSGI3WWxqNG5pRTc3b3VReE50UmE1WkU0?=
 =?utf-8?B?cndMdXVOZUc0RnBjeEp3ZkMyZ2hndGdaWEF2S0xDaUZQQTIydXdpOUlTWXl2?=
 =?utf-8?B?dXJncFcrNms1VWdQcTVwWFhLQklxSGF5Sk05c0RJWkorNFJJaG5GRnV5NnVq?=
 =?utf-8?B?MGczZkpaSHNWTVluQTNVcDh6WGdRTFluc21vcFUvcURxenQrWFlFRWFOS0E1?=
 =?utf-8?B?cUFJb0MwbGJNNEtXUENHaW82dmhIOVFEaWo4dTl1V0Z3d2JaWUdZUXFibUlY?=
 =?utf-8?B?dkVtRGYxYTg1NXBYdmFlcUg1d0ZhQlVqTkU3QlJSbVRKWXo1Vk11NVBIOXpw?=
 =?utf-8?B?UDIxeVNnaW10Q0hsNXdOY0ZUU2txWEx6N0h2YjdPNTBSMWpuL2dUN3htWFkv?=
 =?utf-8?B?ZFRZc1BXUGxsdWtDU0JuWEZ2RWdBNmRkVThIZWlQblN2eURaUFdON1A5TmFP?=
 =?utf-8?B?VTl1SzZjUk80d044bmFMQytWNkIyWlEzbEM3VUZ6RVFFSWNlY2VNd3lsYXM4?=
 =?utf-8?B?OUFsajFNa2xoR3lDN1JEUEtwZlNwQkF1R3YwWVQ1Q1V6ekd5alo4STQzVWZ6?=
 =?utf-8?B?SURxS0dNOG1yN1Y1NEFCN2syS3hlV3VVWkJ6R2IxbFhzQUdNZHVxYTR0M3Mw?=
 =?utf-8?B?YWdDOTRud1VrS1NEYmdLNWtLNWxoU3EvYlNPZm5nR0o5T05ROFFPOTAxZFNY?=
 =?utf-8?B?OGRMNTY5VyswR2VPcFFTNXVMMGQydE9EZGxaN09BRDJVeU55ejhWZmEzZmhB?=
 =?utf-8?B?K2VtcUJFalRFdUk2SFNJRXhTMEtZQTd0OEFNQXY1bE1hQzFnQWxPOTJNMVdy?=
 =?utf-8?B?bVF5K29xejJ2Y0xFbkcxVkRybVBxdlRCL2dTZWkzUEJUeHllbncyZ0pSbWhB?=
 =?utf-8?B?MXhEU2tkWmhJRTZTZHNxTmtzUjZ5LzhxamJQb283amlXZmhJRXByai9OU0wv?=
 =?utf-8?B?MkdvZGN4bjdpTVNXMUM1TytyaURkVUpTWGd2L0FmNWVhNVZZVEJpdTdGc2JZ?=
 =?utf-8?B?eTRDK1d4dFBMVWRxT1g0VzdjWXRzanI4SUNhTmVQSDV1eVp0aXpyWlFMVVRJ?=
 =?utf-8?B?S2lzUklCUVFRbTN3UWFtTzFSOTkwR09VRktGL3MzL1ozWlB0d1ArWXdBR3di?=
 =?utf-8?B?T3MvNk0xVnJSd3ZWK3dWMTZKTE80eDlLcVVQQWk0Q3IrVjlBSTQ3RFN6Mm11?=
 =?utf-8?B?MEVjMzI4cm9aclh1SGJWSG5pK2hEeitSV3VRU0RHVmJLbHFsUFJZOEM3ZmR1?=
 =?utf-8?B?U25xQ1cyelMzc05UNjArSVBrZDFLWVNSYnFuT3F1VHRzQmJQdkhPM0poK0hs?=
 =?utf-8?B?VlUwc3Jwd0Vub0Z5QU8zYmExZVhmQTRHaEE2SDRHbENBSkJJU0N3SGhXUW5M?=
 =?utf-8?B?ajlKRURwQkJKSjRoTFBnbzJhTlN0TzVWRml1cjJiKzhVTm00TUI5T29sSHR3?=
 =?utf-8?B?QXBpOHJZbjMvZDNsSy9iNUd2bE1UMFdQeERUMmdmQlhNbGNBSlFUdTYwM0JY?=
 =?utf-8?B?b3dKUWFkbUZIbVFidk5HeDhJS3h3U3NjSVpXSk92Yjh3ZTZza3A1WjV5Qzdr?=
 =?utf-8?B?OVVTdHBUN1VrdDhSU0FpajVsU3JDNVlOcDVub1hpdlVHKzR4RGl0VUkySlQ1?=
 =?utf-8?B?cjM1TEZMRG9PeGpmSVVNdCt5WkFSaUw0SUVxUjNIazV4bUxKTkZmc3hnYyts?=
 =?utf-8?B?M1VJaUdrdGl2M1QvSmZNdHplNjFoemFvM3NDYld5c2JBMlFRY2JUSTFZMHlN?=
 =?utf-8?B?RFhBS0lxNU9UT3BUbGRybXpicFJySXJ2OEtoMDg0M0xPOGFnYk8xdmdiR0h6?=
 =?utf-8?B?YUxIRTFQN0RTZDVYNnhuWWUxNHFKN2VIaWxZejFQYTZNZWVpb1JROXFmL0NM?=
 =?utf-8?B?YUs0OVd2c29BTlVNNXMzRms4OEt6dHo2VWk0clI5TVE0RjA5K0ljY2NoSlZP?=
 =?utf-8?B?WjBvU1JkaW13YS9CRTVkSVNPc0RIbW5BYkY2WkFmbXVPT3ZwMUJRM3h6Lytr?=
 =?utf-8?B?bkl4aGdwcUR2R2lNZUtsQXVKWHlwK2UvSjBPNnQxOGhYMTBGLzZoTFJuZS82?=
 =?utf-8?Q?INqMojAjTye6CA6gyOH09cSJk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327f0d65-21e5-42be-a122-08ddc8f06124
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:21:30.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KK2Ob6khmmH3UL4oMrqq08ubgubOiSL1FpGhSMUeV8Lk4XMqzKSTLSzlqWP/b9L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

On 21/07/2025 23:33, Jakub Kicinski wrote:
> IOn Mon, 21 Jul 2025 21:34:05 +0300 Gal Pressman wrote:
>>> That's a reasonable way to modify the test. But I'm not sure it's
>>> something that should be blocking merging the patches.
>>> Or for that matter whether it's Mohsin's responsibility to make the
>>> test cater to quirks of mlx5,   
>>
>> Definitely not a quirk, you cannot assume the headers are in the linear
>> part, especially if you're going to put this program as reference in the
>> kernel tree.
>>
>> This issue has nothing to do with mlx5, but a buggy XDP program.
> 
> We put the tests in the tree to foster collaboration. If you think the
> test should be improved please send patches. I don't think the kernel
> will allow pulling headers if they are not in the linear section.
> But that's your problem to solve.

Why send patches to fix something that shouldn't be merged broken in the
first place?

Mohsin made an incorrect *assumption*, it is not based on anything that
is guaranteed by XDP. Fixing this is trivial, and I don't see any
technical reasons why not to.

> 
>>> which is not even part of NIPA testing -
>>> we have no way of knowing what passes for mlx5, what regresses it etc.  
>>
>> People have been developing XDP code that runs on mlx5 long before NIPA
>> even existed 🤷‍♂️..
>> And as you know we run these selftests on mlx5 hardware, as evident by
>> Nimrod's mail, and others you've seen on the list. You know what regresses.
> 
> No, please don't try to dispute facts. It's not integrated, if you go
> on a vacation upstream will have no idea what broke in mlx5. Either you
> are reporting the results upstream or our guarantees on regressions are
> best effort. BTW I don't understand how you can claim that a new test
> regresses something. It never passed on mlx5 == not a regression.

This thread is more about pushing NIPA agenda than a technical discussion.

We're not part of NIPA as can be clearly observed by our MAINTAINERS entry.
Don't confuse our NICs with others that are not accessible to the
public, many people (inside and outside of NVIDIA) are developing and
testing mlx5 without NIPA for years.

For the record, we run these selftests internally whether I go on
vacation or not. These tests are running as part of our regression and
failures are either reported to the list, or fixed by the team.
You know all that.

