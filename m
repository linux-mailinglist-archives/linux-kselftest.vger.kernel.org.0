Return-Path: <linux-kselftest+bounces-44275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A35C1934C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FCA1B228EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453D31B111;
	Wed, 29 Oct 2025 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dmR+BDyk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LIfBuBIN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79169313E0B;
	Wed, 29 Oct 2025 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727793; cv=fail; b=USU2IRk53I9RoWSJBnujS9d+bfEy8tvsXNt3hjyUh+FjHPRD8TrK3RLnDl/HpoCQc2N3LQBRt9u/eu9U5zVGS6IISUmxJwQwPcqqEyP8dT08EoByMbc6cEMng4/N4b8zaFnT2BQcjCcIfwjV3370Yc2uB+sRl4oBRfr6HXyL0II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727793; c=relaxed/simple;
	bh=XCwdPNZWs/W48Y91zg7qd92DzrcPOIVYCr/ikbL7tJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kc6niCL54TEpXv4YTcHzvUFtYJ2tmFGduCLZha4OTAMIDJtwTqi2pXEk3V1DnyvcAe4vZEN11fHuzn5twGaW7IHDF0KZ8Q8gpz741Z2KFKnACvpOCgh/JPzhV4YTTj/yG9ZeFr3wqW5FeRPxy+S+pDl6onUFjNGDGm9trV71uko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dmR+BDyk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LIfBuBIN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7gHkr009946;
	Wed, 29 Oct 2025 08:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qrmWTu/cRB+SmUvvOMmC/kUqKyLKWPORWTEbOKxS2nY=; b=
	dmR+BDykU8aLGvgRmJqNN6s0EeOFBfGMj4Ngtc4Ls/bSfGoS18TyaB50GXjINq0F
	Ul8XRkfJXqIoYH9f49gH2s/ZAjz7XeWDT76lOMCRHUMub6PMRwid9L2Oo0Hsqygy
	YyOjX5IVOvL6K9sPFsOBB8bF1Vhfq6u3bRgMQq1XjU6vigP5LPfbNwYsRRvO25gy
	v744Tfg7/tdgNTj2/6B5N6tq2SM0lkiEvgokQU1h4ipeMFQfGjzw6VrHxU3qzBoq
	Eo8F6nX/lwNouVWXhd607cjFs8S7wF/s5gnNebkGMwf9jihcfHfQGYTq055upwHg
	oivkoIzgIBcnYyHtgVUbwg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3b4w0f95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:49:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7FAux016668;
	Wed, 29 Oct 2025 08:49:08 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q7ccs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:49:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfnIcfxaViyPeFsGaEzeMD5lhbcgmt9BgJXRPpDEbgRqdWH6lWxT4GpsLZDdDKV4rWJ3FOFWJVcAeJdkWxBiPg+HsMm6zFCTn+RhJVw2GK6wpNmZTLP0j4ChMX0AyexFlVxkPd7af/qwfUyYBXVjpmLXtWe7dp85F78XVtb3/oISi1AkDZ776iMDaLOkSSLuGCkhoAGqzfJDKGhzfqxsyxR2uCOD+PkwyS1VoAtWSbNr/FLXSqAt3RMAGgSHhrMXizuSnKaDWNTJHbnpJ9YrE9Z2PXC6H95aAiKd60LCPnpO7PasSOcjJySlLFfAMv5vflePEl9PwQ8zklwqRd6rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrmWTu/cRB+SmUvvOMmC/kUqKyLKWPORWTEbOKxS2nY=;
 b=GUx+tA1COk/DGRnh/D/EJY/kiKzEeVe0AC5VLyY43USwYUV2cmRExa9c1XIDhTtgeBV1YQIyrbKn6Zp2O1h4Kmf9TGBkn3iIf8Dw8emRPdh8mZ9fz/+KasY8d6TN+XFL/A7ngVnswvq9lbjQ5aNCS7Clo8kMLWjrJ+jOOyfG6A0GtBO10aIoPjqidODffGFpXoog0AvIFZX5VRwnZ1It8wJU8U/JB+vfUuw3f7dLiri3AG6xsotTXcsoW1BRJRWKhmfyX6zgyz1S7bj4BARjoXtxXhl8frzH7jPif6VXwP65e8FAw6PHrOh2h7kqRiNC8y0WHQrKm0ZOdlJpj2OrlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrmWTu/cRB+SmUvvOMmC/kUqKyLKWPORWTEbOKxS2nY=;
 b=LIfBuBINnx8yJgMFkHK5D3txuSlin8nmgX7kWupw5jlABRK98J1vUGmaSU68Ma6lI/U+mVaFfrjW4iHo7FTpWzbPfBjAy5/masaV+RjtcJ9i403y4zUDY76W1N65b9Hti9dvNqX6koPH3mbFr4YRK+5Ol8Fo4XMZQ/hP/iT3QCY=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by MN6PR10MB7492.namprd10.prod.outlook.com (2603:10b6:208:471::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 08:48:51 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 08:48:51 +0000
Message-ID: <e0f70023-e07b-449d-9ba4-0cee8d01d676@oracle.com>
Date: Wed, 29 Oct 2025 14:18:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 1/2] bpftool: Print map ID upon creation and
 support JSON output
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Quentin Monnet <qmo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20251028125705.3586552-1-harshit.m.mogalapalli@oracle.com>
 <20251028125705.3586552-2-harshit.m.mogalapalli@oracle.com>
 <89b12696-26ff-411f-9cd3-74361f0f1ecd@linux.dev>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <89b12696-26ff-411f-9cd3-74361f0f1ecd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::12) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|MN6PR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fe6b4a-68a5-4010-dcb9-08de16c7fbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVhLMm9yRHByZE81RGdqeHJORDJmN0NKbVFBSU5XUHJnd2ZMQ3daenpKVUlp?=
 =?utf-8?B?STBMbUYrVHppcldadmxIVVhYUFFwU1ZYT29VeU1DdHBZdzlOQVdWWlVzWGI4?=
 =?utf-8?B?M3RlSk1Kbm10NjlZZUlMRFRURWVlblhxcm8wNHBBZUpEWUR0Zm9IdGVzS1JR?=
 =?utf-8?B?VWlxdXFZTmowNVZua1dJZ0I1c0QxUFA1SnJaYkFKcDNodkQ4ZUljdEtPQXk2?=
 =?utf-8?B?M25WMUlrVGs4MUo0NE52MCtXTE1KcE00QTFoamRPQmw0dnJhTE9nRFVvWVpD?=
 =?utf-8?B?dEZ2QWdNVm8vcHpRaDRUZE1iQ1NlbzlQcVhsMUNtaHVGOTJCaWY4cDREeUx0?=
 =?utf-8?B?LzF4U3FudXEzUWJVSmhwdnhxN2ZIRmZSeVhFK2x1K3ZFUWJkWFNUdnZuSzNp?=
 =?utf-8?B?MXdSbmROSEJkRmF3SnFDZ25CY24xT2FwckhIeFZ5b001SFUzYkQyVS9wQ21G?=
 =?utf-8?B?S1VObFVJdTE4d0dvTCtsTW9YRXJ3VW5QT051YVdWMzhETEdjNGhQWVhxWWZi?=
 =?utf-8?B?RWZrMDY1bUVTUFhjS0ZSUG9PYmkwN0Y0UVFPVUFUVTRDWXB0Qy82VFJhaU9Y?=
 =?utf-8?B?bldVMGhWUXRCQnFmTHFWcFRpZXVkaVFZYTQ0MFVwb0lJZ2JYMmVGZlFYLy9y?=
 =?utf-8?B?THhpK0VNdnIydlJiVEtGSlF0K1YzL1g2VyswdllkNnczeWk3WXE2V3ZJRFkw?=
 =?utf-8?B?LytCR3MrUnhSRm9ZZXB0V3JPdkdlR1VsbEM4Um0wQVJUYlhSMlA1TCtJdUVz?=
 =?utf-8?B?WHQ5WTJjeGpHSG14NXBQaHhzcFJwWEdnSEpMbG0wWXpvVGZ3aWFCQkMwMmxl?=
 =?utf-8?B?dHFUNXFPUS9IRE83cmRYbHhzemVsTDluNFNlRStPUjNSRnFlS2N5ODd0MS8y?=
 =?utf-8?B?YXNxKzhQWFk1ZXhOcDdnK0pIZHNOUTdHWVRCZTArU3A5bHNlK0FodjY1YU93?=
 =?utf-8?B?Q0QzR3VFR2p4Ymg0c0trdDlmRWVpaFNrR2UrNHozMUhESHI0SkdFSG0xV0Rz?=
 =?utf-8?B?aUsvaTI4NGU1NWQ0b3h3L1ZsVHNXdWh3MUJaU1FRRjlXc2xUVU94ZDZlaVhm?=
 =?utf-8?B?S1VrREtYOTFkU0pISzBHRWl3SFJUVG1oUmEydFU2QitoQUMrV2tRMUsyMkcx?=
 =?utf-8?B?TW9IOTVjMWFyK2JGTFhQU3lmT0M0V3d6VmIvNjJrY0RJaHNXekhibkRSUitC?=
 =?utf-8?B?cmJpUlJhNlJQMndYdS92UUNDdmR2RnV0WmVWUys5QUlPRGtEN2VRUzVCcTk1?=
 =?utf-8?B?cnluZTlPRzhGMHllb3F0TUZnYVFWdXNLZWJmY1RjMkErV3JUaEkyaHlVNVk2?=
 =?utf-8?B?ZTlhb2Z1OWVBcWIzOEgxNDRDREFIL1YrWkNOVXU3S0o5QWczU1F1d3hRMEVp?=
 =?utf-8?B?MytRZ3k4RUhtUTRqekRzZVhvNzlBTno2QWlwYXg2b1NNc0xScWRoYndmWnRZ?=
 =?utf-8?B?QVM4a2pEeGVDYWwxRkU5UEtrSGF5OWRoZCtmTnJwTGdTanVOK1pXYTBTdXdW?=
 =?utf-8?B?NWJkcURMVWtyTlVERGRJalMwZ2t6QUZWQisyTUpJSmUvcjFkazlFRnMvcVk0?=
 =?utf-8?B?dEZjRXBEdGVwUEdJaUtiSmxGSjVtTUtTSTZ2eXFOcjU4SHcxcnpDYk9Oa0hi?=
 =?utf-8?B?c1VmeGVhM3RiSTUrOGRvekJlOSsvSE9od3NPcDFvVlAyT1RLdG1YZzRsOGFW?=
 =?utf-8?B?QVg5MTZnRTBiQURucmluRUVsbSt3dlBFbXpXdjJ0clNIbVBNZkhHM0ZMd2Yx?=
 =?utf-8?B?cW1UUElTRjFHRU1EODQ4K2t6VVJQZHhTQXRjT1EwOGVHV3EwZ0ViUDRnRTNo?=
 =?utf-8?B?UlNmSjRvTkNPdmJwZFgzTm5jRHhQakVaaWdsOVhZTkR2RTI0YktYNURBM29Z?=
 =?utf-8?B?RE5Sb1ZaMmRaeC9Dc0dxaFc2OUhwemtKQmZBWDFxL1l0WFBjaTEzRzB1ckdi?=
 =?utf-8?Q?yGRK38IOn3zWBsTGTw4UvbwGogMQBPra?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGNrdjRVbjNFZUtGdzZyTEM1c1B1SVNJdmU3NHBHQlhqVlVBOXd3U2tXTnJQ?=
 =?utf-8?B?OEl1ZEt6NDM1NXNWNVdkT0I3blgwOE5ROXdNUnJYSTB1ZTd4aDZCR2Vxbk5W?=
 =?utf-8?B?bEh6ZkxiZVdPNFJXRCtDRFBXOXlqKzNhdlYzcWdndGRrczdVR0xWZ0loQ1I4?=
 =?utf-8?B?S1FYVU0rWThwQkhNWFpKb0drczhKeXVNSFhYenZwbDBWY1Y5VW5ZM2RSSDVZ?=
 =?utf-8?B?WXNqaXl1NHJWUTRlblVKSnBiZEVSVUFQaHU4eGZsOU1Ud1hsNlJ3Z1hRakYz?=
 =?utf-8?B?c3QwTk1TREY2amxMc2ZWbGc0QzJDK29LSmRZNXYwUDloQnVLWlRMVDFMeXAr?=
 =?utf-8?B?bXIzMWI3Y2p1RVd1TE53Y25CUXpUdEMzRVFKTUk2amF4ckFJV1BnOFIzR292?=
 =?utf-8?B?OUp4M1BwSE5yUW5tKzRTWGEvNDNJQkdBY1pDd05IeEVpYmIxZ3c2N3Exc2FH?=
 =?utf-8?B?Yi9UMllSNFhwdThuYUY5b2pydVhkQUFiZzVwSk54ZzdWcUZWVkc0SzRNM0RO?=
 =?utf-8?B?QzRFUjB0WkhtZURKQ2JZRTIvK3ZEaFFYeFBtSFFwRWs2YklJek4yUEFaTzRU?=
 =?utf-8?B?bHRzWk5IclVuckRQQnpTNEpyVnVOU1d3WExvSFZRNlBITUJpeGM3VlVpQkli?=
 =?utf-8?B?bWw2aWt1Vk83aVpKL05CQXNjc2dYR3JGa1AyLzlPSGlqUHhMem9iaC9YbEx2?=
 =?utf-8?B?ZnpVK0kwRjFpRlBjZExQQ0ZJV1Bkdkk3NDNWVmhjUzNPNUpEN3RjbGpQL1VQ?=
 =?utf-8?B?eXhUZmdVTXE3clBQUzUwSTV1eGg2RmpLNEViUnFjdEh3Mzh0TXphSjlsOHdI?=
 =?utf-8?B?ZVFOcU8yZ015SFQzR1g2NWxmWTBQYzRiTHp5aTVVcXFpazAxMjhhdDZXdDM0?=
 =?utf-8?B?YnFoVTFQbklzN3FxVTdIN3JKZnJsUk5tY0NKTXlkYm5NSWNDUFhRZ0h3UGw1?=
 =?utf-8?B?ZkFCRUhJL0hnVWFIbU5mZWdTRU5sRTRSNUI4bWMvcWdITHRheFlPcGNkOTMr?=
 =?utf-8?B?MDM5STNwQjVTekEyOG13WVI5R0NCSXBhZEFSWG9heHgyTTJUeFlRUkJDVWZu?=
 =?utf-8?B?SjZibEI0WmxMNE1EeFhjMVNBUmx2aVovaWRSb3l2c2g3bDQ3UHFXL1F3eVlO?=
 =?utf-8?B?dHo3VzRncDRiWHExeXRHNnJ3cVV6dkNVVTZKNCt1cnR1czVJZFp1eS8ydDhy?=
 =?utf-8?B?M1JJaW53N21aMXFYVk9nbmtzSmZQSmk4RkNUQXV3cGtjMXVCdWhhWDd4Um5x?=
 =?utf-8?B?RGJyVmVRSWdkV3lPVkQ2b295QUVUdTNCcld5eDAxWk1VaDhFVzZDcGd3WjNR?=
 =?utf-8?B?QkVNUDZYQUF3RTk1UWpEQXhEcFZYaGwzZ2ZsQ1BWbFNKazhBbmNzcm1sdUFJ?=
 =?utf-8?B?MldZMjJUWmJzU3NsTEgxRW1RVytYRGZHY01maWdKY0dCY0U3aURuUSt5aUVM?=
 =?utf-8?B?ejMzd2lDd0RjdlJQSHRIeG9CVmZZWnUzRGhkQ0plcXVES3NKM1ZtMktnQVNs?=
 =?utf-8?B?WUlyMVBaS0FmeHNoRHFXb251WWdORG9ZUWJCSzFRamFXdHhPbjZ0WEJrTGNw?=
 =?utf-8?B?K21uVENaaHNqbUJlaTNhdkFLNVo0Uk1ZVFRYbzFRYit6aFBBbVpGOWtTZnFI?=
 =?utf-8?B?N3lEWXNQUWlKWmQ1V0piQzR2TDZCTjJLaFFKS0luV2lZdjZxNUlSZ1hBNFl4?=
 =?utf-8?B?NUFpY1ZTaUo1UzFVU3BMZnRCOThPREw0OGtOd3FsZXVMRlZZbnQ1TSs5QlRT?=
 =?utf-8?B?UE5rU3hmLzlIRFBaazFxT2lYRnEvRVU1N0pxWkZTM0ZMNEdvOVA5UVFoK1Nw?=
 =?utf-8?B?ekRkMnloQWpmQTdSMHpqL1Y3c2hVYmd2RVRYeFBrRnRYOCtHQ0JUanBIbGo1?=
 =?utf-8?B?MkRkV1FyZ0xtbUdZVGY5UkZHdzNxaERFMXAwSGxaaXphL2U5TVdxUFVBSkZF?=
 =?utf-8?B?QmhVZzA2NVZpNWZMWVdBRDBhN1NianVwYVZyWk9ydWVKUU5pZUNwc1BvKzZj?=
 =?utf-8?B?ZUdaZG1nVXA2V0pWSmU3QmZvZFJBM0R1REdPMEcxSjVOdGtOVzlQTThlM1oz?=
 =?utf-8?B?aElpTjlidXlhQUJob0g3YlEwM0RFamFPQy9hVW5jK0s4c3o1RGFuQWJodzY1?=
 =?utf-8?B?Q2hMbWhOL3hXdno4ZFdCVVZ2L3lmUVgzejA0TG8ybXlVUFQxbG5ON3FiTnhD?=
 =?utf-8?Q?Kmm4p7o0CnCCHPxxLe8eApw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uy9jNPO3oNXWTpkcqaBK2ejycxHKQuBwi+kp3tsBwSJz+9X9+dfyubaHxV5GIYbYZB5UHL6j8CSpqu+p7V5cjvM9Qq6MxLQ0iYTuiHH1Xs2FKPaZ+qbUTuyJHuY3d1jXCeZO1f971WBaCPAHalPlHGWptSV7owp36V/zuRnJCUgY9FSHw2wc336OL0vEUx/5WxYsHkXWl9eCCKL81XTsB9QNRd3N2NuHwAtvkYt4IPIzuoGtMCDR53Jn+oSe2bZq7e7fjexBKLPqsAwYGRJ09ckzbAzQPW0cJNsM8qHyQOfhivP/vAxnDr/eyCmjCqQzVR/QBtNVP+ikyIHftTJWy0kExBjRbAIUbUK3iZzUglE+f0kn9LS6yW0lgIWwF8RFwbCPZ1noOO42eI16Ul6y4ynKJzOrteJIpMsccBVSgl52SlsWdMyM1M3ciTlpvBSrTBEIjnIJgeP0BLye6uouHK1/nCwwOOkuXUOfJACOFrzVijA6oYtxViNhrsRzgUjdIMjc95IWWS3BPx+XVrTdt7Da6w1RHBcK5qOgFevVtIYzNm0lSWQsENE9880kfAjfw86dAb+dJAHqyplqhMqdW7s0/ZFIH+qUUZGITjeyQio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fe6b4a-68a5-4010-dcb9-08de16c7fbd6
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:51.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijB308xr5+74lREvgukSS4zR+z6N7SgG+JGjsK7btZiQqQdikhkDwpaooeIamGOY6gKRF99LvEJks2/XQtTKvjfOkJo+2FmnGp4mLh5PqLN8OhNA0KcZYUOTAfGm6OL3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290065
X-Authority-Analysis: v=2.4 cv=R9YO2NRX c=1 sm=1 tr=0 ts=6901d505 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=k2BhJZnDBl5Sc5ChpfMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyNiBTYWx0ZWRfX1hlINfbNqIx3
 L8ZK5eDeqQGDH+V79L0wEGR4fJSXCvBhPohnGvHpPLMMqMJ9vvbYD4KQ8rB0u4pTrINQ8FTaX9X
 eN9TqOTHxXtt4T9WWXD9n6xpkIRHw8dROM1xBNRMuCkzKP9FbuAnlSuzAJAnda1K45MkYKFhAIN
 bhBW7ptHSfkRGSxnh/WqenNC2zKAEMScNj9IPVU8c2U30tNsMrv1JCe/vm6gAdqYasFN8inggW2
 7SoRuUcTQvD7Z72PK1yjl5/x1vVZFfLI82WZ3mLqMgnBtKQI0imK0QsBwx5h0dpLsY6LiNfvBHr
 G3DaT4intIFGITT0aR7CNO071dvWdYbgcQTdN8aIYU02OwErENsUO8FuNfbVeDl9qyYAQcuGaVn
 Vh7V1uXJj/9qkD44dL/tPWd0IOfpCHoc78A0oNsC96HtI18FvTQ=
X-Proofpoint-ORIG-GUID: GA2kOtph2sE11piDv1Gdt5pFeYQeECys
X-Proofpoint-GUID: GA2kOtph2sE11piDv1Gdt5pFeYQeECys

Hi Yonghong,

On 29/10/25 07:44, Yonghong Song wrote:
> 
> 
> On 10/28/25 5:57 AM, Harshit Mogalapalli wrote:
>> It is useful to print map ID on successful creation.
>>
>> JSON case:
>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 
>> 8 entries 128 name map4
>> {"id":12}
>>
>> Generic case:
>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 
>> entries 128 name map5
>> Map successfully created with ID: 15
>>
>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>>   tools/bpf/bpftool/map.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>> index c9de44a45778..b6580f25361d 100644
>> --- a/tools/bpf/bpftool/map.c
>> +++ b/tools/bpf/bpftool/map.c
>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>>       LIBBPF_OPTS(bpf_map_create_opts, attr);
>>       enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>>       __u32 key_size = 0, value_size = 0, max_entries = 0;
>> +    struct bpf_map_info map_info = {};
>> +    __u32 map_info_len = sizeof(map_info);
>>       const char *map_name = NULL;
>>       const char *pinfile;
>>       int err = -1, fd;
>> @@ -1353,13 +1355,27 @@ static int do_create(int argc, char **argv)
>>       }
>>       err = do_pin_fd(fd, pinfile);
>> -    close(fd);
>> -    if (err)
>> +    if (err) {
>> +        close(fd);
> 
> I think you can remove close(fd) here,
> 
>>           goto exit;
>> +    }
>> -    if (json_output)
>> -        jsonw_null(json_wtr);
>> +    err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
>> +    if (err) {
>> +        p_err("Failed to fetch map info: %s\n", strerror(errno));
>> +        close(fd);
> 
> and here
> 
>> +        goto exit;
>> +    }
>> +    close(fd);
> 
> and here,
> 
>> +
>> +    if (json_output) {
>> +        jsonw_start_object(json_wtr);
>> +        jsonw_int_field(json_wtr, "id", map_info.id);
>> +        jsonw_end_object(json_wtr);
>> +    } else {
>> +        printf("Map successfully created with ID: %u\n", map_info.id);
>> +    }
>>   exit:
> 
> and put close(fd) here.
> 

Thanks a lot for the suggestion.

Will do that and send a v2. Thanks for reviewing.


Regards,
Harshit

>>       if (attr.inner_map_fd > 0)
>>           close(attr.inner_map_fd);
> 
> 


