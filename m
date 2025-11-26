Return-Path: <linux-kselftest+bounces-46524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9926C8AC75
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352AD3B6BE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4233A6F9;
	Wed, 26 Nov 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QXw+Eqpk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB03043C6;
	Wed, 26 Nov 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172696; cv=fail; b=tYq3Mwy25iYBaFBgPfDmB9/XNjXrUg7+x+ESkLTpKmenUhU/dTDi4VZKx6l2aPkQksjTy7i+MDXBeuxaE7MnAWoPSrfx8bXIxC85OUn27PL3He84rVDtqvqKn2W9EKiHcSuktVCoU9f0Y0t84iFbytKEt4oFQrXdu87w0sTCUDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172696; c=relaxed/simple;
	bh=8TomdLi4GJV/hH1nWThqkPbarW169ZioZUJ488ZDLFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f8/fXy6ychx2T+GpGYeGCTwJwE7Csbg0l8kCZvAeMpDFtjJVQuW/mksBJ6pfiAaFDdqD3lB6W7X9GtZXS3bI3j3PajOashRn1Sujj8m0xdvMJUmE4uIcA36q0icUAuvOigIxyIzZj/JFaXTJBpwTQu/bNGadApjbGeKatbI5hA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QXw+Eqpk; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQFuNMw3278922;
	Wed, 26 Nov 2025 07:56:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4O2Buj0OnG6z+RdRqTr6QhKK8claNAsAM/V9MxgZbu0=; b=QXw+Eqpk8uuO
	qTSkS36zJxivs2KBZTMBpTVcV6jSeAqL7GMMNreyoVw88kHOsp/nT/OCdkn3sVpU
	xfbonUuBUKtc9I2PUrXBgZ5APwFiL8EsOWSLcDEsqOXb9KS4Osqf/F8y4n1RFt6G
	6yDjoRSpfiHHPv9PkX9Lqdbs41iWFO8UCDcCIyLYRWFpmr3Ow7UW2Q4kSLBvBl9L
	Q9tWM7P2nxDE0OIPVTN3Yc/OuF+Th3V+Qpd+qRgWi9mgTOhM5kfTQ/Ffj/7hEp28
	YOqA/w9O6l8u+PCY4xquPLVtGgViqcJI+SS/demaUP1r07aDVQSpGcz+iqM71HTW
	rXDxWYVOow==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012030.outbound.protection.outlook.com [40.107.200.30])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ap4mrr01j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 07:56:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POorkDmBZbYwW4nLX9T9Vq31m3968Nvt1CciFfFAaLJ9P1VIE/FtQq+YZUo0+sCAnyQeMpnkYBX5pIerWdIMxUDMC6sflxcBBbEys2B9mq8oSl/r9pnTIpYKlzRty7STzXF94GiT59PKE1nFx4J5UFjz2nBi4WSsKfARM5MSW+drbxrxFIyEvjQIELh3LWdxKuKOvKdnE0Oc58x50dlLD21WPkuzQl+Owv/pHB2EpnLH8wA2TmEGuCRuAc9gucL8/2w1bI0ozTpLc9tRWecp/81D61KzYQE3Uf63jHbb+oxdfx61dWWONs3IOQ5YaGWmz8/ppzmAyGrpX5zHNtG7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O2Buj0OnG6z+RdRqTr6QhKK8claNAsAM/V9MxgZbu0=;
 b=MSRTKii+BUOYjt6K6moGyrq4Dd08t2vrRJ5aGkv1q2niQmOUUriRG4NFaFjSr1RM0Wyvfd4KxcxyGzgNMUGyksr3Ts6j4fD72ROdTktzJV9txOwkdq34Rrc3xcJ2RRGcM6+uU9B1WU1ntiiiU8Anz/HDM6Az/k36h68OQHTGE0ygyMtXPCWX2nokTH8n/fPqRARP9A9fBNd3tQVgwX3A2HYwNAVN4iKe7IwlHD4vKOw6BmQUuEkR4zMmAmd3g1HDa22+x2UKql8RW4zN3AmyuYJy8tmu4bdb2pFy+BVGsYCjipaNvV5yxMj/Ilvd6YEl1pI6jvkj4ok8uvsNX1uKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BL1PPFCBE3073C5.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 15:56:23 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 15:56:23 +0000
Message-ID: <26c4677b-aeff-4516-85f4-87b5d1a9f6ee@meta.com>
Date: Wed, 26 Nov 2025 10:56:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 2/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_array maps
To: Leon Hwang <leon.hwang@linux.dev>, bot+bpf-ci@kernel.org,
        bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com,
        dxu@dxuuu.xyz, deso@posteo.net, martin.lau@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, shuah@kernel.org, kerneljasonxing@gmail.com,
        chen.dylane@linux.dev, willemb@google.com, paul.chaignon@gmail.com,
        a.s.protopopov@gmail.com, memxor@gmail.com, yatsenko@meta.com,
        tklauser@distanz.ch, kernel-patches-bot@fb.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@kernel.org, ihor.solodrai@linux.dev
References: <20251126145039.15715-3-leon.hwang@linux.dev>
 <07707b44fc9032398db551041498d6265ccf0a0313ecd8779bd1fa82a7d96409@mail.kernel.org>
 <4d8120f7-f3b6-4654-9b14-0ee7da5f87ac@linux.dev>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <4d8120f7-f3b6-4654-9b14-0ee7da5f87ac@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0041.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::19) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BL1PPFCBE3073C5:EE_
X-MS-Office365-Filtering-Correlation-Id: 770bcdd4-44cb-45ec-5367-08de2d0458fb
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkM4YVFCOGc3M0w2Z3dRNUw5eVppbmhZb0QwMnoxMUgxT2dzbEk0QnN0em1T?=
 =?utf-8?B?aGJMVEJqUmpBQ2I2cXVmMlFzVjU4MmJMclcvMTkrYVpIZ1hRM1gvL2o2QUFl?=
 =?utf-8?B?LzlhRXRyQmpmdm5ESFl3R1U3MlZZUFIyM21Gc0JEcUx0c3pCNVBFbmUvVk5F?=
 =?utf-8?B?YTUzcEUvajU0bnFBcTJPY0FYNEVWNTcxdm51dUFIcE03MzNSWHlBa29FSTdj?=
 =?utf-8?B?ZFRqaUxaaE1SbkpaRVIvNVYvdFpYMWdSUkFlVW1ncm5zUGtkbDlQMVNDMi9n?=
 =?utf-8?B?dWNSdWp0cXFsWGRkQ1N0ZWx6RjJHM2FHd3lwVTkxZGNBY2tjcFdpQm4rcU9P?=
 =?utf-8?B?bWJ5eVZBTklscGU4VWpsRDlVSHZHUkRnV0ZCOWZaSjlWd2NyOGFZRnlQT2ZN?=
 =?utf-8?B?SFpuM080SGdLVjA1ZitsTDZ0UStwZWNNc0l2TFYwUkgyMnBXS1RkR0p6Unh6?=
 =?utf-8?B?dmNxQWRLdVpxNzl2OTZmSWNBNVF6ZjA1alErRnE5NDBjWXp3dm9obGRFWW81?=
 =?utf-8?B?RkVzdi83akowbzFZeEQ0VWVTRHVoclI4cU9sQXBIZ3RBTmp0ZlVhUFY1aktI?=
 =?utf-8?B?YnN3c05sOGdoM2R3c0toeXhLdVVaSDkvRXpZd2Y4RkN5eGxiRHMzaW1tb1g0?=
 =?utf-8?B?K3AzTlp0SFdvdTBYYVE5SWFPNDJwc1ptSE5mcDU2TjZGcXVMRGlkWnNFWnRG?=
 =?utf-8?B?bnpUa3FKMWtuR0wvQW96OTEyYzZ4cTFJNG5EazhKQ0lZSUU2RjM4ZFdtNmtV?=
 =?utf-8?B?cTMzWWVjeU8xaWtVTUdGdGx4b1NQVGJjYmUzeEQvbVVsb2Y0TUR3RDE0cExF?=
 =?utf-8?B?WjBmYVVYR2lMOWN2QkJXYTJsUTdVSyt3YjZaTG5tRE5NUlplYlBISG5GMklF?=
 =?utf-8?B?N2JObnorOWxkNGtwSHUzU29EbHQ2VEo0WFF6Rkk5bHdJWkRpVWpkQ3ZQd3Z4?=
 =?utf-8?B?S2pnZmhxZTdsaUgwZEJSR2J4MHN0Qy9WczNhUEN6WTVWUVJUUlk5aVBuUHkv?=
 =?utf-8?B?bTNDTUxjZUYrdXVPaEcyTGh5dnJ1RGFqNkZwSDI4QXZ4UzB6bFgwQXUwa1h5?=
 =?utf-8?B?TnJBelJweUQ0bUhvZlRRQlpJMGs5Qk9RMFFrY2JxVkdtN2Fkb2hOWSt6aHFh?=
 =?utf-8?B?bWswdmRrWkd1cnVYNFlPQ0NKM1c4R01KYU5jSEdYcUg1ZlJBR2RSbkdLTFFJ?=
 =?utf-8?B?ZkxGQk5KS05TYUVidE5rQk9NZ1RpOGFQOEt2RWdza296TWhjSTBKM1htSEhP?=
 =?utf-8?B?VjA5a1RtTU5id0lGWFlBcUw4VlhsbzlLODN2QkJ4ZHZQS1FpWjFyeUEzWlpK?=
 =?utf-8?B?cWtxYlVGUCtHN3dRb3lhd3laWW1GaklYbE92Nk4rZHVDVkVEd3VYU0syeG1S?=
 =?utf-8?B?OU9tbVNRWGdWRkNDVDNMVW0xRWk2czA5cExNOXdpWlF3c3dzMW84WUlTY3lw?=
 =?utf-8?B?WFRqdnZnRFpOc2sxa3cveDFrWUY0aW5MLy80MDNvZ2cyTUdCQUc4SThjRWZj?=
 =?utf-8?B?eGREaFdSci90QkJ6VTZkUEN1UWZRcWdVYU5yc0xndUk4M3l2eUdhRjBDOFVF?=
 =?utf-8?B?bXREbm9xcEJoenVQQldkNXBLTVZDZjBKMjZqcmw5akFSN1RQZDZZYTMxNWxa?=
 =?utf-8?B?TEd2bThvRUZhcDJpK25hU2Z1cXRpd09JVFBwcHlnQVF5N0RrbkdrR1dqMWxU?=
 =?utf-8?B?Wm1sbnJpOXByeU1oWkl4SGxCcmRTeURNMTJYVXQrMDdTOWhwQ1IyQUtTWkFk?=
 =?utf-8?B?WDUvOGJ4d2txTi8zSDFnQy9LTkV5TVhQb3gxMytuSk52STVyVWR3NFdTRFYv?=
 =?utf-8?B?SythbkxibVZvc3o1TjB3QmVQL0tqVUlvaS92SDVmTERBTTNUTmNYRDFBMDhE?=
 =?utf-8?B?Ukx0R1BBQU54Zm5PZjUzSnJYSVpkZ211SmRpT2J2dnJpd2tFT0ladGZZd0I3?=
 =?utf-8?Q?ToSISzvULnZe1RUDPyh/mxW55RjJR0tg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmhhNFRmV1lRWFRqa0NmcFBURHV4TWgxVU5wYzFZWWhERWRZNXhjSzIxbmw1?=
 =?utf-8?B?YUpudjVjQXVaRTZCWVNQcEtINXl6OVdRWkVXamd5WVZlTlduZUprS29aSWgw?=
 =?utf-8?B?dUNrWC9mK2pCRUYzdlN1S0hsenZuWE9OMFR4b2oyQlZzQXlVdjVvUHJjK0NL?=
 =?utf-8?B?TnhNbFVQYVpvMVRXUmtRaWtRalVHZU0rSzRVNDNGZnVLc2dZcmw3TGJKelJ1?=
 =?utf-8?B?UnpoUHhtNVZVMzhsYUU5TVF6TTdWRWFhTTZzd2xaRk8wYkRlbENKUXpGU3c1?=
 =?utf-8?B?d3hsTWRFNThibjgvTzVkSmtuVm15cGFpZzZ0eUFjenYrajhoZFVyYWp6M2M3?=
 =?utf-8?B?NmVKMWJ6VlJOdEpLZGU5T0tZVEZ5aU9PZDBSSC9CYjl6eWQvV1BMRUROVmhU?=
 =?utf-8?B?Z2xBcGlKUVFpUG1OMGtlQ0tkQW9VbjNDWUJ2MWhPZVRsYS9hUnZvbUJSN21W?=
 =?utf-8?B?UVJSSFU2QmkzRE1LTmlJUTFaQjlYZ3hURms4Y05nRjRZcks3WWtKT05FUlNG?=
 =?utf-8?B?RzR6dU1VZVNMSUxYdDhDUDlvVVprcnBLNjliQ252TWhxci9sWElKbGVYMnVI?=
 =?utf-8?B?dUlOc1VwOXlOcG41NndGMnZCb2RHRlpwYlRHSityN2J0ZWdkQWtvaWZvL3BT?=
 =?utf-8?B?NmJkYlVaSmxOQm9NT0NreW91Y2ZBU1F2d3ZQcGY1b1pBZ2xKWG5hdjhBMDhm?=
 =?utf-8?B?TEFHdm02cWh3K1Y0NkxsZUM2bisyeENwTEpYU1lCS1lUYWk3TWlGbUZSUlp3?=
 =?utf-8?B?YUp2NW02ZW00b3R3MnlNamtHLzlGQWFtTXZRVXNRRDBiYXBlVXdXdUJnU0ll?=
 =?utf-8?B?OWcweVdwUmp1Q241NVY0RVZ3THJLS0tIbE1WbExINkZNUGlFRGNRNlhHNGNq?=
 =?utf-8?B?VU1aQm90b1NRYk1HZnZxQ3lreEdYU1JHRTVaZVMxb281MWMwdWdQcE5XRlpj?=
 =?utf-8?B?d0ZiMXlwV2JVeGNuRjVOSW1uc1BRcU9LUDU5UDY3MjQrc3FRVGUzS2J6bm5F?=
 =?utf-8?B?UGFtTkRYVllrUVZ3QjdZRVhqU012YVJkLzA2SVRBRUw1VjR2eUp4cWVwc09G?=
 =?utf-8?B?V1BBalU0UDIvRGlqcHBWbUxBQWRhSFJCU1UrVy8rY08ySXNsRTlJNDdoRExM?=
 =?utf-8?B?Q0JLU0FCbDJLZFJpaitidVQwOVNBNjRtTkJBbUJrU051WWd4bG1LMDQxeG5U?=
 =?utf-8?B?V1VjZGIyL2FPN0phNGRXb1JZSEptV2hsQVU3K214blZoOGV5TDRFWmwwNWd1?=
 =?utf-8?B?VTRTZVdyM0xlL1BJU2VDWVg0YVFDZlZsWkdFYmtwc1ZsSU5MRHFzaEJIT0J0?=
 =?utf-8?B?VjQwNG9sR3orUWVGNXBkZ0kwOVhBMUJCZG1kNGdIREUyK2NvY29XdDRiVU5u?=
 =?utf-8?B?SUJ2c1FBNGt3T3o5bVZHVEFYR3dUOEFSdDdNVy9FM1l3dlN1czl2eHF0dHh5?=
 =?utf-8?B?TkpHNXFPUGVTZHpodUhEM3lkWFNHNEM3VHhBSzJKYXVaY2JwbUNLNVE3NWpv?=
 =?utf-8?B?dEJYWlpWNHlvYk9Td0xsRWpZQjhPL1M3Y2NpQUxYSVREa1BJcHlhSnNtdUE2?=
 =?utf-8?B?TXdFSHdzZzl4TUxBUlA0NE44SjdRRG5wOUdkR1N0NmprMGJoRDU3OTRBVG43?=
 =?utf-8?B?REhURU5XZStjTWNMN3V0L29HSCs2SWJ3eTZyNnduT1lSWUdIYk82dGUreDlP?=
 =?utf-8?B?bzJkSldvQ0xKWGY2L0hyTGlFSFdycjM3OXB4bGxJazcyVVdUQ2ZEUG1zcURT?=
 =?utf-8?B?WFVTZkNhMDVNek9GcEJpTk5DK2VWbTR2bjREMWNEaHBjN2lyUUhieUdZK09F?=
 =?utf-8?B?UTdvbW1Fb3FNT05HeURHWTErNjAxTllXRDdhU0dTNGdCYXNTdjEyUGR5UW5Q?=
 =?utf-8?B?YTVxTnpHTlU1TzdTOW9FemIrQ3U2UEk5RWdnenVndFJxZHVRdW5ReTB4a0Jv?=
 =?utf-8?B?QWFZR2hhUE5WeEdJS0JqM215NlhqZnNiTUhLOWlJKzlmYTVQZ0todG5WWTJw?=
 =?utf-8?B?NE9DekRJUmU3bWlGMGRrR1lPOURUUStsdzdTSzU3NTYvNzRJTXpKTkZCWkV6?=
 =?utf-8?B?K0tPNXpTVzZZay9xVFRZdmhTNkRMRlZKQm1MUGlscm5pWGxIcEVDRU9WZjVQ?=
 =?utf-8?Q?dHGs=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770bcdd4-44cb-45ec-5367-08de2d0458fb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:56:23.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/W15hM+4hC8zz7WmHUS/NEdnKfq/z9mQEtnHeubVy8oYeTuEacJzA9cASJS5FGf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFCBE3073C5
X-Proofpoint-ORIG-GUID: uLe2lvmzIe9Q23aExAjhyk0O3WoSMoVF
X-Authority-Analysis: v=2.4 cv=a/c9NESF c=1 sm=1 tr=0 ts=69272329 cx=c_pps
 a=7AyV/nWbqbi5qqSn9KuTSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=L3FPrzqFbnZg0gN2Vg4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uLe2lvmzIe9Q23aExAjhyk0O3WoSMoVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEzMCBTYWx0ZWRfX1ksizNUV7WvL
 MNZ4tNYo3+wrP/+YFFnNUqSYE4ZHcMpqAnv9stlURhc7Tod8Na2Hc6Rzk0YTHumlcoo7SBTylgn
 Yx7D7WSVFX7qhLm/uFVEB1FIqJj/q3TH2NHRKbPlun6VN/bpNbojObrCZDL/v22O8Apfja7eX4d
 73/UKRT4tAMI69n3aXrfkGbv610vZxRsCa994tl1ALl1XBujZBL0JReFqh95XhQmT1J3JR9zOsx
 VT4VextDo/YISv8CXdRT7JO2vzZhU3IArKnsNfzNnGdAhCXloElzo2CM/oADNkKkeW5cBtHhJp6
 8PW/XXuQ+ZeOyebicC+kwgpF9WV/cL9KqKI5aupXEw5J506C9C3jO/PMNbvZWCyJ2iUwiImQzNf
 HtaB2Su+SOQUwDRcqYtTEatVoFZACA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01



On 11/26/25 10:24 AM, Leon Hwang wrote:
> 
> 
> On 2025/11/26 23:11, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index d84af3719..01a99e3a3 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>
>> [ ... ]
>>
>>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>>> index 1eeb31c5b..67e9e811d 100644
>>> --- a/kernel/bpf/arraymap.c
>>> +++ b/kernel/bpf/arraymap.c
>>
>> [ ... ]
>>
>>> @@ -398,10 +405,11 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>>>  	u32 index = *(u32 *)key;
>>>  	void __percpu *pptr;
>>> -	int cpu, off = 0;
>>> +	void *ptr, *val;
>>>  	u32 size;
>>> +	int cpu;
>>>
>>> -	if (unlikely(map_flags > BPF_EXIST))
>>> +	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
>>>  		/* unknown flags */
>>>  		return -EINVAL;
>>>
>>> @@ -409,7 +417,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>>  		/* all elements were pre-allocated, cannot insert a new one */
>>>  		return -E2BIG;
>>>
>>> -	if (unlikely(map_flags & BPF_NOEXIST))
>>> +	if (unlikely(map_flags == BPF_NOEXIST))
>>                               ^^
>>
> 
> ?
> 
> No such change in this version.
> 
> It seems that this change was inferred from v11 to v12 by AI itself

Thanks for flagging this, I'll try to find this section of the logs to
see how the false positive checks failed to catch it.

-chris


