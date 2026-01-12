Return-Path: <linux-kselftest+bounces-48717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 204FCD1104B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 08:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70E1F304F880
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D281633A9F7;
	Mon, 12 Jan 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qP4z9kiB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB133987E;
	Mon, 12 Jan 2026 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204715; cv=fail; b=Jyiaf51GziAUS7ybYMJHdM8YTIojHmUkoXBAzHX+1Vt6lgxNIWJ+boCqNXGAIcLcJSLi6EQ2M8ibQTOPOAmp8Ecgc+37B5ySoV6xh0g7aylvPqCNU1qfBJCacMFgPR4XmsmZ+GYBdY5IdWI64+B5DGcI7xK/Ty24CcjKJUatXKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204715; c=relaxed/simple;
	bh=3wVWpg9GnRAtUdu2yHKzoYKL4aOspqUr9me0O1tBNS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BVApAkgI6gsc/A4+7fyqtJ9EJxROPf4k+6/MieFjrasx8D2gjCjePmIxHEuXY3FqurbFD5lwzcluuzsD9bBSqQaaF+XmiDSQC/fpIbMADpJujhP8YbGOaxRitpze/vUEIkOgWoNLOiUaGiVFsmfKRPhzKKTBGiLobdJJc3jdxrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qP4z9kiB; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrSKSFCxHo5OJy5R64xzUKYc0J72WpF4OFqdCH4zwBNauHQ0tZIC2hFWKcwHqoTetJN5xEKLzs1Ldd1pv548niv8Yt+GUBUp5lxB/Hm+SgO94sE0tcnGx/5QXAa4TGCzDF5bUCFXqJnGZtjYOdKN+Hj2RBRocaPY1n+E07eg/0QMcDRqR1vHk7AX1rwahH7g9B5kHRiqX/v6IOfGf65kpP2+ZPvFrAx6ub+Xsbl9MkbT4yr2/RHW+4d6UTtEMNFZCZaFORhAxaqwIjJUWC09qFsqwc3uYJt3RZY5o3e5C+6Ift8RaJRqn8m/pNazd2NI93PE0yfUlvCucl/auZBegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L6OujRR6novpTPoW22VlyRKFI8kSCycIhkwp8lFu5Q=;
 b=du3sE9ZUyad5eyh2+JrGeKkndqc2h/Q/Nt25hAfmlzuvY7uTv6eMuUekZyQuVJ2AigV5M8N+GSxhWHn0da3RU5MCs2p3r1wAz4DSu4R0zcbHKZOEM5hE0b0BY0IWp7Mteeu8IAdSDnaarqrE+/IuFDXl402HFNTMRKbiKz5+ZzRc/WukUi+M6KM2S88xLXkPgDFEkok09hEl40fT0Qh20FuzUJe/dBrV+643v7uBCceeL+MbFe7ITfa03+919PicFoYA2Lz3LSDKynj/5BJ+DVxl6HxgDi7BI9mvZiKDa8yF7KDDFFjZ7oJuALkvdxDpS9Xsiz+w+IlnjcJPaK+TWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L6OujRR6novpTPoW22VlyRKFI8kSCycIhkwp8lFu5Q=;
 b=qP4z9kiB2CKPFjK75NjKatxIQyz5JG7wsTDsmPZIJ0XxbmA0P3LT/O1g1JConkTTaVWK2WPMd2iPG0vx4s+uodG/NkJGhtuUw9OF0+v8xpHJifpiao3znwFmDyE39QX79W8aLGr921VADAeeYmgZw1OpPMIe+BVogwn6UGd8SsYAPkBtH6ESe2mFc2qXrQsixFgf4BN/Y2/4AbS68ikL1sKBtBxpZlKbv1Y3Jao+69WISoA3dMtXr9cdUH5BrulI/Jj9Euf9H38tFrvOGIHBxGPOtlB7XLSVaMpEsXHXlqGx08ufR7KRaW0g4BWdkgO21q/v8iK0IAjZrc/Ii/25KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 07:58:31 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 07:58:31 +0000
Message-ID: <363dee6c-3a02-4f76-aa6d-46382fa41df9@nvidia.com>
Date: Mon, 12 Jan 2026 09:58:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: fix RPS mask handling in
 toeplitz test
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Petr Machata <petrm@nvidia.com>, Coco Li <lixiaoyan@google.com>,
 linux-kselftest@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
 <20260111171658.179286-2-gal@nvidia.com>
 <willemdebruijn.kernel.f136c851c9ee@gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <willemdebruijn.kernel.f136c851c9ee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: bb13a306-afa2-4e2a-3fb9-08de51b060bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFg5bURrYXFYekpJS1FyUlBxTmlGRS9aaXVDalhBSGY3Sjk4eFZHR3lnZ0JF?=
 =?utf-8?B?UEhJek52SlRiWTBVMVcwZzFCWlZJSCtsUlVvc29SRFRyTTc4cklJd241Y1hy?=
 =?utf-8?B?Y2hRZ1AyNkVNYjlSNHVCaDZNY1d5RzdUMzVZNCtnWnpleDJiYXI4WktyTldR?=
 =?utf-8?B?U1I0M2MvSDlFbTR2Z1lqalpLNzdUUmVNNjlESi9TZjV1NU5BeGZhVUkzcHhw?=
 =?utf-8?B?RlNjN080Si9SSE1JOXdCNkNqckVjL2xDZHAwaHV2Mm5TZkYzRFF4NjB6NERj?=
 =?utf-8?B?U1RySDJmN1JQNktneDhUa094QUpYTUNsb0I0VHV2MVhVa3RPKzNqcmtSTG1N?=
 =?utf-8?B?NnZBRG1Dd1NpTlJxVGkvNEgxZGh3UThOT1p0SzcyVUdVc3VIT3EybThJaFBN?=
 =?utf-8?B?VG5CdUxQaGZaRkVWbVVzOHVwWDY2WVRkbU5FNXd3MkZzVk04TDdrNi9CNzI5?=
 =?utf-8?B?UjVkazd5SGNTK3JiYTBZR1BETHE3c2V1dStJR1BNMXZLeWlPMjNJcUNKeEx0?=
 =?utf-8?B?azNZVTZuN1ZYRHdnUnl6Z0NzN0l1VU5DL2NUaklDL1hTK1NDSGhzODY2OWpz?=
 =?utf-8?B?MWJ2Z1NaSHBONWMxM2laUDR1RGY4UGlsdUZBYzV2azIvdEFGMTVtcE5rc3NE?=
 =?utf-8?B?VFFlaVVPQjhRWVdaQWtEbUFBRnBXaTVvdElpc1JCVGtVd09sUW5kQW13MllK?=
 =?utf-8?B?Y3FneU9oUEtZMDBON2s4T3I2VENIL1VsbnN4UUZsMXQ5TzhhUFZUb1NNUnRF?=
 =?utf-8?B?b280akJzb0VQQThQUXZsUUx5RFlnKzJpOHlUUWlicTZ5SVdLaG0vWkFhZnBh?=
 =?utf-8?B?MW4zWUxoWHUrR1FiWUhSTDlPMFdjVG1VZVNva2RjakNqQjRjaUVMakdtcjFy?=
 =?utf-8?B?NHdlWWpuU1d3ZGkyS0l5MEhaVEVPMENnbGlUcDdpRDNXMWJIWmdYYS9ib1Ns?=
 =?utf-8?B?eDEvajRSUWJqNzAxTUhzOFl5MW92Q09WZnJZODZ0ZGx3a2VKak4rcnF5OWk3?=
 =?utf-8?B?OVVjVlJXY3FtaUxMOWd1TXNzcmRVOHdDUXp6cktCRGFlWVZMdUdDM3JUSWMx?=
 =?utf-8?B?VFJ2cXdNL1YrMDdzVzV1M1ZOM2czd2FrM0lpakhGVU0zb00zS0hYd1o5bnN6?=
 =?utf-8?B?akpMQ0x1SzFFWEEzRXkyc1U5aGkxdHI4dnJDclBLUEt2QTNaL2hTSmVEUkpN?=
 =?utf-8?B?WkZrWExNVzhWZTRmcGl3RWhPSkpKRkhwbDlIbDl2Q0pwQWFxTmJxSmUwS0Zy?=
 =?utf-8?B?SFRlanlTQzl0QkNCVTlxa1plVmZlUGl5cWtPNFArcWhqWXRPV1owU3JCL2dB?=
 =?utf-8?B?Mm9ZSllzYUNlOVVEbFQ1THkvTFFoZmFjdzlBT0kyZG9Mc0JHVUdhQld2U2oy?=
 =?utf-8?B?WGlwVkNDOFQzR0l4MHNSVU15RVZRdDk5SlZkZU1ZdHNVcTFoUkYxcCtvVGNQ?=
 =?utf-8?B?c2l6UWQrM0tnK1hMYm5wNGRJRUxiNG9NVFJTZkRuZnEvdmJRbUpiOWtyL0VW?=
 =?utf-8?B?WVlNMnFhQlpFaUZsREdvSE9sNEc2aGxCbzhoTHBOcTYvRzl1RWpUbTJTNXNp?=
 =?utf-8?B?cFE2ckVlb0NjM214cW53cFhWQkZRRmMvY1ZNQ044RjNyTDFVZmJLdGowdEJS?=
 =?utf-8?B?WUFtaWtFY0VPQjZwb0loUWl0N0JyYzlJVXJFK2NBQzRMS1dZeXpSY3J4ZmR1?=
 =?utf-8?B?RmlGcFZkL1JreDUrMXV5K3U0UlM3NzdueGdFcDlJemY4VkVqOEZDT1NiOEYr?=
 =?utf-8?B?eGEvSFU4eXZscWd6VlVxcGxHWUFTVG1taE5lV0U4WFVxUlJlM3M4N2I5ZWIw?=
 =?utf-8?B?MVpwcEFyWmZocXJDeW02NE1uYXM1QmtKWjdoSFJ6R2UweW0xdEJlUjVNQ2Ev?=
 =?utf-8?B?RUVrQ2l3R25wSHVCblhnakQwS21Wb0gxL21GSVpla2NEUGpzSURGNk94cDV5?=
 =?utf-8?Q?Fp/VHW+PV3D1IMEiaies6mKzRogObzAE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlZ6ZHI0SFc2WGNITk9CYXR1a2dZOWtKWk4vb01TZ2x6SmZtUis5Q3VyWmNE?=
 =?utf-8?B?NmMwNnhyZ0l6aDBhWTFRNHREeHJvSVBQQ3BESUM5OFdGMy94ZWpRdC9KK0hu?=
 =?utf-8?B?cEpjcEdWN3ZYajQvbFNRckpwb0lEQm1FK3JnTHlycUhDOWFMa1RVZHppSHpW?=
 =?utf-8?B?QVljRXJVSUkrd2puR3NuS1VuMWo1Z1pBaU1ZWEpPMkxHR0gyVzhMbDkrSjFq?=
 =?utf-8?B?bHZEODJySFVXWlJ5RTdXY1ZZeTJiWWVwdGVQVGpzS0JsR3ZsaGhlQitLZ05s?=
 =?utf-8?B?dmFrc2MxaFRPUStlUDF3N1FXb3NQL2NERWY1SlVkL0dHYjlzS1h5QmlSRktp?=
 =?utf-8?B?OWlBL3BHRGtOZW9NRmhxSEVRMXVQTDNlbXZ1QWdJRXFicUJnUVFwUDlQTFBy?=
 =?utf-8?B?eXdPUVJtMDE3Tm5HV2haci9lTVhMaW43SElyMzlRKzVwY1p6aUc3dHdHdnAv?=
 =?utf-8?B?TzFXY2Z3Z1ZqUTc2Z3FiMGdoclRmY1ZWUnN2cnhPWXp2Qjc4VmtYY2FtanBp?=
 =?utf-8?B?TXRlbWV3M29RY0c4bzFabGRGMHBOanpSV2M4eG5za1J6UVo4NklBWnhmZU9L?=
 =?utf-8?B?YkhMZVVTQmJTd25YNXlLNjJQRjUvVDFVaHUyY1oycEI1QUtrdWtjaDczbk1T?=
 =?utf-8?B?K1RZVVhLenR2YkJ5SmhyNlNGQ3V1eUVDVTBLUHpId2h1RjY1WWVvOWI4Q0Vq?=
 =?utf-8?B?dHNhcFpMdDBNaFd4R3R1d3dOQjVQc295Y1F6ZG1tV09GNy92NGFPdDdlWHVO?=
 =?utf-8?B?QW5nK3dUMW1kV2tXQ0VST3dwd0VvL1V5NFZDZUUyMlB6amd1TWtwMUVTcGxD?=
 =?utf-8?B?cHZKM3pCZ3NQSDFWelhkcUwwMEVhSlRpOU5YRC95TXdueVJYZlE3WUwyWDlJ?=
 =?utf-8?B?MHZnQ2xhMkxvVVFldGFBVzZMOFNMenFsbnVPMm91VDNrUnpqdFp4RnJUYXVy?=
 =?utf-8?B?TmlyZTJoRTRZSEtkZmFObVdXU1poUzVkaHZkMkYzY0lQNVpwejlTdDdUUXdC?=
 =?utf-8?B?Q2pkb0oxQVNxa3d6blRZTkxQZTNYT1BvSlBwazRzNkRtN09JUEdzbVIra3Fx?=
 =?utf-8?B?SzV1RTBhZG1CV0NOZU14NFZUMXJOdm5TQ2JITjhKTGRBZmJOaFQzSnQrODJ1?=
 =?utf-8?B?dWFtQi9QcFlPa1hMOHF4NFAwb1ROSUVCZktUNGhpY0Q1Z2VFT203aHp2Nng2?=
 =?utf-8?B?ZHRrY1MvSkhSQTRJQkxTVUUxVDNyNnF1UlNrVkh1Z2l5NGVuc0V5eWtlSDR0?=
 =?utf-8?B?OGNnQmxOeURqaE1oamNRNmxPcGVDNXRqZUR2UG43dnEvR3ZCUTRaUTJ4VXd4?=
 =?utf-8?B?M0orWDE1VkMzbmozOTFudzdDaHJtempsVklRZU92M05TdTVsb25obUsxaTNB?=
 =?utf-8?B?WEt1MERFbVRmcTFMTmoveGxlZzZhT3ZpeVJzcFJPd0Y2STJzb3E2RGdaVWFM?=
 =?utf-8?B?YUFFQjI1eGxnZS9CZlJPYWo5bno1aDN4ZGcwaUlxVTRMd3Q1M1EzZnA3RVpz?=
 =?utf-8?B?c3k3NjBJSzgrSjVYNDFBeHBPWVlma2xyRG5QQ1JET3NOWUJXdlNGN2xPUGNK?=
 =?utf-8?B?bzJjL3RmWndWcDA3dHNpMU9QYWtoRTVmbWV6TWswZkxGdzcvRFZNRWlNQVR5?=
 =?utf-8?B?VUhVa1p5Y1lISVZTeldkS3JaYk05eHRMK0ovZnV6c2xqYjZFNnFiaWJSVFdR?=
 =?utf-8?B?Z3JsZVFPbHducmtCY3V5RlJJbmEvZ2dpK2RZa1RCbDg5Tjd1eVFqNUpiOExR?=
 =?utf-8?B?dGRCTWRxVDJuRnNyRlh3dmFCN21GZ2VUVGwzNEhPNzhLN1BrellQUEdIb3pK?=
 =?utf-8?B?MW93V0VmcFUzOUV4NFJENHpmRWovcXEwSDYvY2FvN2Ura3VJZG1ZSkkxZXUy?=
 =?utf-8?B?dnE0cFJtZ3lrRGtmSHdoOFZWWTB3MUNncmlrdFRKYWw1clcwQ3I2NDZZc0NG?=
 =?utf-8?B?WlUzdUpESlpNemQranNTL2ZTUFVZWjQ1N09hSWZGOFFQSktNYTNzVlpxazBG?=
 =?utf-8?B?elVldWUxR0J3NzZqQnU5RGI5NjFaOWhnYTlLcExESXpHNDhqNUJsc3lCTThp?=
 =?utf-8?B?RzlKeHVNOEtRWmNFQ0VWdkRETkpGYzloQ1hLWTVJcjJPdjFGUDZDWE5qK0VK?=
 =?utf-8?B?OC9ZR2pjR2lzcTEzdlhWV1NKZWxFdXArQzVYZFpKMEN1TkdtMWQyQUFQSVpK?=
 =?utf-8?B?dmd2cm1HZ2J1eWU1aUxybXdhOUZYWTNiQkp6YktkbWVuTEZtTGliTXZhSGg5?=
 =?utf-8?B?dUVzK2RxcG9ISnNveTNFUjdHajNOZXZrSDYxK0ZLRW5jRk16ODlLL20vdzh4?=
 =?utf-8?Q?tGzLbr5J+e5wSgVfJO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb13a306-afa2-4e2a-3fb9-08de51b060bf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 07:58:31.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hWySzTEwBrtJkhG/fjVnhY4zJOWl5ZOV46LIj3gxAjgFbT9IzL5RKbikeYbwp3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

On 12/01/2026 5:43, Willem de Bruijn wrote:
> Gal Pressman wrote:
>> The toeplitz.py test passed the hex mask without "0x" prefix (e.g.,
>> "300" for CPUs 8,9). The toeplitz.c strtoul() call wrongly parsed this
>> as decimal 300 (0x12c) instead of hex 0x300.
>>
>> Use separate format strings for sysfs (plain hex via format()) and
>> command line (prefixed hex via hex()).
>>
>> Fixes: 9cf9aa77a1f6 ("selftests: drv-net: hw: convert the Toeplitz test to Python")
>> Reviewed-by: Nimrod Oren <noren@nvidia.com>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
>> ---
>>  tools/testing/selftests/drivers/net/hw/toeplitz.py | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
>> index d2db5ee9e358..7a9af4af1838 100755
>> --- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
>> +++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
>> @@ -94,14 +94,17 @@ def _configure_rps(cfg, rps_cpus):
>>      mask = 0
>>      for cpu in rps_cpus:
>>          mask |= (1 << cpu)
>> -    mask = hex(mask)[2:]
>> +
>> +    # sysfs expect hex without '0x' prefix, toeplitz.c needs the prefix
>> +    mask_sysfs = format(mask, 'x')
> 
> A particular reason not to use the existing slicing?
> 
>> +    mask_cmdline = hex(mask)
>>  
>>      # Set RPS bitmap for all rx queues
>>      for rps_file in glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*/rps_cpus"):
>>          with open(rps_file, "w", encoding="utf-8") as fp:
>> -            fp.write(mask)
>> +            fp.write(mask_sysfs)
> 
> Alternatively 
> 
> -    mask = hex(mask)[2:]
> +    mask = hex(mask)
> 
> - fp.write(mask)
> + fp.write(mask[2:])
> 
> The comment that sysfs and toeplitz.c expect different input is
> definitely helpful.

Will take your suggestion, thanks.

