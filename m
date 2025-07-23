Return-Path: <linux-kselftest+bounces-37866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D311BB0EB7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 09:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9AB580B27
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FBE271A6F;
	Wed, 23 Jul 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pECi4EFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BE2253B0;
	Wed, 23 Jul 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254731; cv=fail; b=pe7VNkAPJJn+gFWFx1u8zJK6W+qojNrQqD3Klk+iDRH6THvt9TP46LhDdhtkojAH6/GIKDaxY3U7fDeh9aroymDTG547XIe7XX+rMCgvLc0uFnx9i2YaDuFn4QRh4Zf1YyiotcaGcvapT8AGtLbOoPpynZARC6VCLnZSPv5UyCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254731; c=relaxed/simple;
	bh=q2yUfc9CzuRbCLMFsowlyHYBrKMpl8QHlOM2+tX+2gE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BmHsTq0c3dpCokZGxiPEE1IrUu8ZsPaJT7CACXyijxwzMO77aC2m2pZYkBnNO3EbKSpGO9v6BWXYl1Y+osbLLv4hyKSs55Pv/9XRG3zUoEvudLmWgOgmyAUvV/aXPGezkkWPcLzejuM3r+eNolIgdNAmJOA0EfVYxv/2e/6odnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pECi4EFX; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYdkHk4xnmywe8JfFsPdu2m09f/u4ZO38NS0QjT0qIXYb1EGWUVwFdndL2fXaESiWxNLCyOvXXuaHA5Zek4I7TIAwU4wGjrjMvezdSmrv0CO2bqgJ0uqHT1SagVheiHYEkZ2YgH2nPLHt/GKO3zKH7chPhR4n62whD7yPqfa4wZou9JnP8vFQMYD2XvZXvIqo1ifUoA3r3RSy4mD9p2Zi8xHCElcmuZ+n4MrRjCINSs/AnGiiUeWLWlYWL8E7Nf5ElvtKLfIMTqEBJIPMrmGGJeD5h3CUZtwPmoclxWZEq3rJOZiafisXi+0knBoLWp40c5/oA0RbYixMpkZg0grWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeDJ2BZBssLbyYQDFMvG4cRuUfP88RqkXOySqFGsPqk=;
 b=Zbi7SmoIvkWX4cPv0hz9xcq6Wx05DWAsE2WqtSdEgIyZ9Ebk44C7brwCv1p+GCq85l5TVvIwta4N/lK4MZNMEIbesVrPj85TO8iDaC741c7sDe86crodtwy2pEf+52bP2HLX38YXVIX2HA6bG+fm2cFndg3O6e0dhGhh1+yhVhVdtqeWGH+XXiPP4zA8nmy15GZQ7OqLVExlIaAP7U2M9vHa8VQ1ZJZzU5njPT3joPWS/JhbNgUxDQvuywgCph5Pi/5mbXaxLPd5c/lc/Gwu2mu8+IwytE3bDJ9svU+7tGhXPgqtlL+PB25aAanWAXM6tsFxmgk5tVuME3gZr7ViEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeDJ2BZBssLbyYQDFMvG4cRuUfP88RqkXOySqFGsPqk=;
 b=pECi4EFXADZCy1OFMqFbddre/Fohhq2E1nFD5hH28FC+NoVpLPRcNx6aLIRy+oE8n6hT8GS/+DkdxUIuZgCe20if9cXo9+TVQMQnQzeG3vPThIISLEowybsAVP31WuLfzCGZmZAyYrZCMyM38C8xau8cPI6k3txOdc/plG/JWD6nRdCYODZpTpHd4y3OO2bEywz58HvbkYWQpC2ZLQX52Jf1W0Z468OkgewwRp4lMhQgChgdZfWn0xtl2+2JcHikXdlO1PKTrBOUbF4BcxqabIXTDHdMMGC6qVB+meF9mEVBO4aQeb/HwylIdPor2utnvruDviJ00+wsP5OMh+AY0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 07:12:07 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 07:12:07 +0000
Message-ID: <48bb190e-073c-4ad8-841b-f6d0572cb0fd@nvidia.com>
Date: Wed, 23 Jul 2025 10:11:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 0/5] selftests: drv-net: Test XDP native
 support
To: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org
Cc: netdev@vger.kernel.org, horms@kernel.org, cratiu@nvidia.com,
 noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com, jdamato@fastly.com,
 sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Mohsin Bashir <mohsin.bashr@gmail.com>, patchwork-bot+netdevbpf@kernel.org
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <175323423849.1016544.9128937268934260157.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <175323423849.1016544.9128937268934260157.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d62a0b-e365-4ddb-f762-08ddc9b83b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emxGWldMOU16WFVPa1FUcE0rT3hzSnpGK1hvbFE1Ym9PYmxGLzgwUmNYbng3?=
 =?utf-8?B?T2hkVEdlbnQrbG4vdnhwZGJ1Kzk5cm1rOXNaYWhTTVdkM1pobVp5dmpHNG9G?=
 =?utf-8?B?UW5zZDNsdGlud3laZmFSWU9kODBteFVyZHJEUnR5dTVqWTN4YlJydGNoeFh2?=
 =?utf-8?B?aE5KTVhhRUZaaGpNZ0cwOCtEVThWdVpqK09vWnNYd1ZIcWhleEFGZ0ZEbkEx?=
 =?utf-8?B?a1FtTjRSemRua0l6TlpxWktvaXlUZlp0V0hpbCs2WWN3VjljZmt3aG52WHo4?=
 =?utf-8?B?aDZmaWxRYU9ydE4yRmh6cVQ2SE52L3RzZFg0UTdVVVZreVNMMnNnOEhCM2k2?=
 =?utf-8?B?dFhUMXVURWl2N0NhN0xzSXNuV0JTUjBxcTNEQmNJV2p4ajV4b25YY3FNMGFL?=
 =?utf-8?B?WVNMaGxYS3h2N1paS2JFUis0OUlXNDZGaGJkam9WZzdsRXdmTUhIcmUyaG1K?=
 =?utf-8?B?SHNKcU5ZcyswNnpiMHludTlrb2p5bm4razgrMFBnMlFrb2g3VmNZeEFVN0Vt?=
 =?utf-8?B?RjdZb0ZwN25pbFd3NXNXY24yNS9TMkFwam5yRTR2UW1RSy92RVFvRHp0Uzkv?=
 =?utf-8?B?SHE2WGpYKzRENFl4NUFqR3pCTHFlc0J2R3lNQUNlKy8vYmpuc3UrNG5BTWdF?=
 =?utf-8?B?UEV0U2ZYQlRmdWluUldLQzlVdVhMcHpmUWZqdXVuL21TaEFoQ2NPRXRhVEpt?=
 =?utf-8?B?MXNWTmdXMHgyM3kxbGtqTFlFSUg4dytRMllOUjgvZFR0ajBuTDEvTDhMaHlk?=
 =?utf-8?B?eFkzNWVGeDhEV250d0ZVOC9RNkxqbGttRWdkcGY4akFzZStEeE1lYjVSbEVw?=
 =?utf-8?B?bFNKWWRsUmNXSTliR0xhZjNFS3E5K3RuMlo5Y1BidmFMaERBa2lObDdOcElw?=
 =?utf-8?B?WUxWTm9kREpFR1YyZDVhV0ZGYXAxUkZZQXNPMUVQNWVCOHpKOW1TMnNKQnpU?=
 =?utf-8?B?N1haT1hGTDNiNmNNYVVpUWRldTk1RHdWRlNmQnVEYXJqL2NMZGNCYkFkZmhW?=
 =?utf-8?B?Ty85Z25iZHkvenFmKytSUHJDOWVpWlAydjlhS0gzVlhMejQrWFU2RnpUQm5L?=
 =?utf-8?B?N1UvRUUvSVZtKzBlN0F4VUFMOW5TQXJPVDA1S05VYVNmVFQ4ZGNjL3lNcUNl?=
 =?utf-8?B?c0swc1RTMzNDTURHcTZoOXRqdnhMbDREdkFSUGptMXBlcU9JUUl2bDc5ck5F?=
 =?utf-8?B?SmlwN3RBZmtTanplNy9idUJ6dXdEYy9zb3NzaVJmY2hSRlhNQzBaeG1kY1Bs?=
 =?utf-8?B?bm81QW4wa0lVMGxOUS9OMzBkVmpCVG03UWxVcXdDSC9vU3NXTTEyL2o3Qndy?=
 =?utf-8?B?Y3VZUnhObUowVWErN3pSTUoyRVFIYVN6UDkxeFBzN25qVGxxU1l0bDdVQmky?=
 =?utf-8?B?OFBkMTlyenM0RGUya1U2bGtsYXhRU3JrQ3RMUGxjd2tmTXZUMmpnRGtkSmRJ?=
 =?utf-8?B?Mkt3bDdYZXNBL08zR2pDREVTdGYrVXJodjdaQnZKOXdHVFJpazhmMVEyV0F2?=
 =?utf-8?B?ajY4MTZ3WWlleDRIdkZlQnA4NU9JeDAwbkgyR2xwbkZPdkptc2lLdXdBdWUy?=
 =?utf-8?B?cXJDZ3VDYjdvbkFBODhPb1RVMVVIc3lSS3NkbHpWcTZrNWg3SG12bHhYK1F4?=
 =?utf-8?B?RWhGVGJSMFhCN0ZjMzF3c0s0amVQdzl2amNpYlp6MHJGQXpVK0orZkQ1M2Rm?=
 =?utf-8?B?dXhrUVQzam5qa0NVYlF3N2l3ZmlqdEZkNDFCYnVVUXdjS0toNTlVeC82MndI?=
 =?utf-8?B?enl0aTE1UGdpeml2NHM3SkVkU2VlOWx1VVREUnoxOEYwNzh0MitnYjNhdVZn?=
 =?utf-8?B?Y0cwNmtrenpBempsSWJFZFc0a3ViNnllMzIxQ1lJamFvakZxdnZVNTZmLzVt?=
 =?utf-8?B?eUk3RmRGdVVsOUtNeGhEVnRUZENuaVBnKzdBMVRLKzhHbXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzJNQVpBdkp6L3JsOWlxUE9aVnRUOXdOcXNEMmQxbm53dmJFOTVOYzBUNXZM?=
 =?utf-8?B?WktiVkJMWnVsSlJVVk56aVNPMnA5YVlBeTdzU3VBakhkdnpDSnNubnFKaUNR?=
 =?utf-8?B?NzdSUEN0OWd1a0k3SUU4OHRrR2ZNdUE1YVlhUmd4N3NzS09wTURtVzVZNHJB?=
 =?utf-8?B?T3hTVncyeTROK21sdkZabHlOcnZmREVxb0xZR1BkMnNmbDd2ZGUyN3pZSDNX?=
 =?utf-8?B?aTI2ZDljNXBQbFErTG9Gdkp0aVJkSHhEV2M2SFR1L1BwclBFUXF2QUlEK3p0?=
 =?utf-8?B?U3plakJaM1JiYkZNZC9qNit5U3lnWExZWmN5SXkvaThzemxUQ0hYWUZwZUZ2?=
 =?utf-8?B?SXlGTDE3ZEl4ZDA1TE5qQ2pNeThHNU51MWhsK1ZWa2F0bEtEU2ExTGFjYWQx?=
 =?utf-8?B?bDdNVEdkSkpWSUl6eG1qWnJyZ0Q0VUg5dTJSS2tTMVJhUkRaK1N6MUdJVUY3?=
 =?utf-8?B?bHZmcmVtZXZ2bzIvYTROTEk4SjFrcVRBcDdKNmdZYzlrZk8rSmlpRkhPY1Bk?=
 =?utf-8?B?RDRJRm9SYXpISGhxZDBqTE9VLzFGcldDeW1kcXNQYW9MQjdaKzVRZ0ZCN1BY?=
 =?utf-8?B?OVhpVzlkWUtOVGxQYkpibWFXSGE2RHdWdVI2c1d1UHZ2eEp0U0hPQTh0ajZx?=
 =?utf-8?B?QXcwL25QeGJYMmpVeGQxazcwcXgxamNuclljdWZ6VzFJU0txUy9GQ3JLUU81?=
 =?utf-8?B?VVRibGIwY2xnUW11UFNrTlI1ZTZDNU01dktvWkZ2WWQ2UE9zdDI0VURMTzcy?=
 =?utf-8?B?NkN1SG55RmVlSkdDdjB6aFJLNktrYytidXhNcjJBVDB4cmZUaCtobXBvd2xF?=
 =?utf-8?B?NllVc1g4UkgzUkFRemhmWVlqd3FiUmtOMVNWSUd2bXFTSFNqYUV5dHhWdjFh?=
 =?utf-8?B?bnRJWVFwZlVvWXVxYkFhK2JqRFFSN28wTmcwMUwwSVRHM3pqZ0lwSEwrZEVa?=
 =?utf-8?B?YkVnbkdWSmZQNXN0L1RidkY5QTc2aGZFZFk2ZlB1Skt5SHMvRm5VdFB1M0RR?=
 =?utf-8?B?TXlCcUdJNGovQTdnM3ExUnd5M1BIVCtpTFRhSys3bS9Ic0o3NHNRcjBnZG1P?=
 =?utf-8?B?Z1Uzb3Ewa3k4ekovTm5NUXdsVlgzTjlSUVVmSm94S3F4TkU3ZUdZVCtkakFa?=
 =?utf-8?B?Yy9VWDBnUC9NeU9pUXU0OGVwRVY5N3J2cU9MZW1tYjR2QnJYNU5mSldOekNB?=
 =?utf-8?B?d2VPbk96K2gzcVBkMCthSmNCZ00rdmhkTXo1bkg2SE5vSE9XSXN2WS9ZZ1F1?=
 =?utf-8?B?cXdRUitiZFY2S01wTmd1OG45eWptZERYaDBXdkY4MmRZcSt1bTZFWUloUE1T?=
 =?utf-8?B?KzU2eE5ZWG51VjJJdGhuSHJNcmMrbUZVWjYvR0dPRy9ZZTF0TWVudHFIemNK?=
 =?utf-8?B?TUR1NzBwaEtVSktIVGcxWlhzSmdLWEpyZVdjcW1xc2ZDOFk3Y3N6T3dxd2Np?=
 =?utf-8?B?NnhRai9EcmJ4RnZlQ1BJMjR3MUlDWlNxV2cycy9Pb2tuU3E1WXFHdnhNNE5C?=
 =?utf-8?B?em1ka0F1bHFyYjZOYURjRjAzQjVIdU9CUytORTVpeFBVc1ZkaFZsa2pFdU1W?=
 =?utf-8?B?L3h1eDZTQTd1UzZ5S0lmQWtVeFppNFJOTDVDREt2Q1NNVTJNSGxVQm1uOTk5?=
 =?utf-8?B?RlNMMVpNbURSdUJ0MkxvZWZDa25od0FsbGVFOWJkL1BjMk5xZld5OWYycGhF?=
 =?utf-8?B?ZnJkVm5TeTJuN2Fib0VONitHVzhyd0xmWVZDUTh1RXgzOXpROXREb1ZlMzJV?=
 =?utf-8?B?d0R5eXpMOUVSbkN1bkt2U3VJZ2YxRnpSTGJJc3NHMUFyOTg1RDlpd290WnJM?=
 =?utf-8?B?N0t2Mncvd2hnTGtKdTV4Ym1VZjN1b0NQQWpsSC91cHBGQWFpOCs5MnpFU3BM?=
 =?utf-8?B?RERnZGRwR3F3R0duQTR3dERiekUwV1ArTTZGOENTdGROaGVacGRZMFMvaUE5?=
 =?utf-8?B?QmtTZmhGSjR5MmZReFU3REtmY2xlWENja2Q0U2RvSCtuQ0VCdlArSVpKYVFI?=
 =?utf-8?B?OHJyNVh0cG84UW5DMVhkQU1Zc2dobXFuZnUvZ1BNM3ZTNXJTek80SHNzTDg1?=
 =?utf-8?B?SFo4Vy9iNWo4QlF5Q1k3dTltL29XRE9IMFBTQ1prQWEvM293ekIzcmZYaUM4?=
 =?utf-8?Q?aOJKpfPvHqSOOeL4hkuzysS35?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d62a0b-e365-4ddb-f762-08ddc9b83b68
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:12:06.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qp9IKbGfKYY54IlNvSXY6vFQp+Qe+r+yzugMwfd94cIz+cqjhbrkcPZfVt5mCZSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731

On 23/07/2025 4:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Jakub, the test was still under active discussion, and you knowingly
merged it with buggy code, ignoring our comments.

This is *extremely disrespectful* towards people that spent time
reviewing, replying and participating in the netdev mailing list.

I expect better from you, and other netdev maintainers which allow this
to happen. Please uphold your responsibilities as maintainers towards
the community, this is unacceptable behavior.

