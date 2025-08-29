Return-Path: <linux-kselftest+bounces-40247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A666B3B036
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 03:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C451C8191A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 01:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBB3186284;
	Fri, 29 Aug 2025 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wa47Zh4O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eCkNK5I3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9A3FE7;
	Fri, 29 Aug 2025 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429491; cv=fail; b=Psw2D+VfgRjdtw67P2MTxuTETylcxRkOlEQaK9KcrElRmf0pdDJP02AV1HtI6JCBuIikB+hFFFXhcfcEf9eThug+luqJ4g0TaufVWC++fJTKNtYcAGAQCfQk7+9a84vpCCFhP5gF+wnPdDNO2eDxnqDJ50Rd8gWK1jpkgd7/LHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429491; c=relaxed/simple;
	bh=IjfhR7yz7CsEcFnmXF9DOauiSQCFUtzPYdP9LORFMjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y57UzIZYzLaTk/qnQTGICP1YF7A2l3Yll+pgD3EF3kdnQA/ENSut3nKqiD1n3hJ11Up7iSTo5ziOWBBaqy1D7L+SHbLSQYOLc21uSnJ5ow+R7qkXaAoJs0fCA9YKbuD8gWGYkYolmU7FEVFR8KVktEDNm2PuFTBwZe91ExXceJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wa47Zh4O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eCkNK5I3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLVCTx006738;
	Fri, 29 Aug 2025 01:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hPs7GgQU55hFHqNmgipP4eKy1K+XgVV+FqMzRq4ZTY8=; b=
	Wa47Zh4OJlSscLShcDu5H5qpd1omhqwCB9DFoj1kOKoqYqODbkHVbb2BnzaGyWGs
	vrrAQjKyL0rq9DsYLxUVKxU4yWyVao3PkfifJdSl24N/LJlWQXA0k1zW7yzFGrWU
	7c9nbxM7N6KY88NN2RCkLOCI6kp6OCxV+PnByAVRELEQQiT+VrDpYZGl6Wpvq0/7
	712dAsOsT65HW6903azZtMexA4kWcIL4u29xpUqWtWJ7x78ATWvhsxmTyx8Uk2c9
	xgmGnpJo6VjG4rhelYInL9dNrtp1Rwi4ZygLP7qo7Q82Gg4FLQdSsX55kr7rgWbh
	LFI7Tqyr0r0I8oeTUCRkPQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jasn3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 01:04:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T0X5Vd005021;
	Fri, 29 Aug 2025 01:04:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cpjt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 01:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYHvhvJsvmGuuj7gcdmd+UfgEPpsgSgGullsNegBOkfsApKE4cOD3xD7puePLpEX4CSpc5dDjLG/mRg+tq3MqCIP5tCSthxlHPAHgL7mg9ifIdVAIaZXauBFfOxXbjb/umHqzXuN99ZnS7Ui//WBeueZarr6InVnJPnSQUs5//Ldr+9+dN5WfBPSZlD9XCkh57CACySfFjlEyChAV26OfAQpK7+8n6FL8cclrONXkHbeRtxbBRqcHYA7e8NL8szoK9xE7uls6oYilj4B35rkBMGSZ59Xuh9otW5/AYCwmjXuN21Pr31uXKwSo18DpEDp5DGui3NfTbcSlaX8XyQuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPs7GgQU55hFHqNmgipP4eKy1K+XgVV+FqMzRq4ZTY8=;
 b=QNW/Kc0XXCxGn32LDno43X6LHu4XtADkPqsVQ+mcSoIrYH0m12GZHzBtPZjoATV+c/trGMjrWxTH+6xQkTG7cjRbeJ4E9Ts1KK/Xnje68Y2O+Udjkthh8vxUHJP++2CJOdDbZCMjBJWcJB274pp7TMxlHBjrzVR9tPU/NiGvk1rL5erNpzvLNKFb+PWHKy/c6iz3Xnzx6oDaoY9NjYIcdHuCGiYwctS9L6Wd6gPYbmSdNkn54kN+8IVDGmhje4txwTXv6b2pl+rvyj5S4irMPDVXO+UVIsa1zC0Ou7ddbY+rlzKkLz8lQHOcpggM5zI7oFG93AtkKIf9KEI9qL1pWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPs7GgQU55hFHqNmgipP4eKy1K+XgVV+FqMzRq4ZTY8=;
 b=eCkNK5I30sUJHn755sQs2EQFG0Ytb4f80b7hYpiZeBlJjB5X9eIY5i2/S6vilsJI3f/5FnAx9CHkz59HFyPBQabfcZ2aUjdnDr7uoOAx1+cMU7T65D0mU+ysbqWFTI8kwXgCioKo+qvPXZhQU/HaM5HaB29Hz14IOK+LhlgGu6I=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by DM3PPF76BAA8D48.namprd10.prod.outlook.com (2603:10b6:f:fc00::c31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 01:04:25 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.9073.014; Fri, 29 Aug 2025
 01:04:25 +0000
Message-ID: <d2ed9b04-8372-47e2-976a-b6a130edc161@oracle.com>
Date: Thu, 28 Aug 2025 18:04:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] mshare: selftests: Add test case to demostrate that
 mshare doesn't support THP
To: Yongting Lin <linyongting@bytedance.com>, khalid@kernel.org,
        shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org
References: <20250825145719.29455-1-linyongting@bytedance.com>
 <20250825145719.29455-9-linyongting@bytedance.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <20250825145719.29455-9-linyongting@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::7) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|DM3PPF76BAA8D48:EE_
X-MS-Office365-Filtering-Correlation-Id: b5653069-b8cc-49ec-844a-08dde697fee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUFRenJVMjBoV3p0YURXWC9OMHlQWng4bTBFb1k4M0kwdXpPTXk4ZVhaQVVC?=
 =?utf-8?B?RlZYR0hia1p4bWtxVUFidW4xNkJLTWd3T1pSd0tPeTl1UmprNUY5RUJvNjZ2?=
 =?utf-8?B?R2M2alZ6YmlEelVNYldabm5WNXZiUXFhQ0tlV2VTZlRiYm9EUGYyalNGYVgr?=
 =?utf-8?B?LzFhdzhJNjRrUmZWdDRNNXJrYStGYStmdERNaU1nVVZ4WVRLWnhrcGQrNFBY?=
 =?utf-8?B?UGpVUzNlc01qdjA1REtUTnA0M056YVpDdHo4d2hEMVNWaGhzNSt2V2ZRMjVG?=
 =?utf-8?B?UHNEK3hETFVVd1FmdmhNcjNmWndEa1UxUTNlbWlxK0RvVU1JMDFwV3lVUlM3?=
 =?utf-8?B?OWNvRkJ2U2FZdzllYzJDQWVQWStmRWZXL3RCb2pIemhvcHNKRVNvK0lPZ0RZ?=
 =?utf-8?B?RjcwWjhsWWhuNkppaU1RVXlySWtYYWV3R3FzY1pwc0pHRmViZXZvU1F1SlNZ?=
 =?utf-8?B?NlZYTkQvL2VoUUJQY2d6RVJHVngzS3ZPbEZSZnZSTk8vTUtzV3JFd1NzbUtP?=
 =?utf-8?B?YWdFaXk0ZlFqRUFoNkVXczZGOGkrWUQvZDVDblpqckpyN2xITm1kQk8wdTFU?=
 =?utf-8?B?T0dPWEhZSVRFcm04d2lOc1hrS1dwV1VyZVlCd1o0Rkd0UEJrd1M4ZFRzL2xp?=
 =?utf-8?B?VXRIVlRqSGM2QWdINjRya3BPMFluVFZDbnIwZEdhSVlGeVVRbEZxTkhYZDhm?=
 =?utf-8?B?Znk2ZmYxc09jOVNlQmh0K1FFQ0dYNDFZY0NxZFYrWVYwa2lZRFJTQVUvblBM?=
 =?utf-8?B?KzRYMGdJTDRTKzFldWFBNlFpVERWclZDcExIZk9jOVE3QVBodnM3L0dqcDJF?=
 =?utf-8?B?Tm1ZdjFqYmt6K0tqR3dMbmloMWZjVUlXaVdpbVhxYWdDcDR4WW4weEh0dHRD?=
 =?utf-8?B?ekNoWE9XbWlqTjc4dXFSaUlEeUF1Q2htN2UxblFBbFVZUGZOdnVzMGQwRzJM?=
 =?utf-8?B?Uk55ankxVFZGdnFJZnJFaXN3MFdZQW90MVVLWTRwZU0xNGlVUTFSUThwVUZa?=
 =?utf-8?B?UGowWU1MT2ZnTkg1T3duS0krMjVjWXZaWHBKc1hIeG5SVzFCZGhmQi9HdDV0?=
 =?utf-8?B?VTVjOXRZT1owM3F2Ulc0WHpTYU5UNDZlZ1RJUlByNU5KWVRxZ3FHSXZkVGFJ?=
 =?utf-8?B?NjFRa0ViWVk5R2c0SzZJcjR6UCtBck5ZSUtSMmZFaWF2OGtaRTcyTFVYTTNN?=
 =?utf-8?B?Um1Qd3hja1dEbFJUTTFuVlNtREg5VGxBZGRkNHplUmdCOGpPZDk5TFoxakpS?=
 =?utf-8?B?dW9SVk9INm9YSzBWOE5DMWJaN1F0RlpIdC8weDJuTGo1ZG5odGt6QnY1V2JW?=
 =?utf-8?B?U3VOYU5zTDJTUzhaQ2VvUjhZMlFJWEFoemRxdE15U0xHWFZtZ3p4MUlOdCt0?=
 =?utf-8?B?WFUxU0JSZUxxR3VYenNRN0JaR1JKME1oeUdZb09LdHVwNENuSkdRS1NoWFdE?=
 =?utf-8?B?WWJVNlJwNzZUMG1hQ01vcXhaa3plbFllUGZJWVhGRGFtUlVVdG9taUdnVjNk?=
 =?utf-8?B?cjFCZTVvRFoxL0JXclg0MURReWhMdHpBakpwUUQ1M2M3Ri9sdFk0RjMwR3Fr?=
 =?utf-8?B?Um5lNms1MGtQTmkvVTJNcTBhSzNsUFZVZlVMUi9CeUVqQmI0SXlxcGJYVkJ6?=
 =?utf-8?B?d1ZKZGtVUVhKalZkbmhUK3k0Z0FTSG9ZbkxKN2VlZHdCZXZGV2lERjlON3pk?=
 =?utf-8?B?bGw4S283UDAwYjZsYVhpQVZUNmRBSi9uWmxscnd5MllLdE82cUIvN05mek9V?=
 =?utf-8?B?ei9VRUNSWUxwU0Z4S2JLeFQya0NyU2VGMjY4OHpBczJ2R0JzSHZiSm5VV3Jr?=
 =?utf-8?B?T0VhQThyUWM5T1JJZm53SVlLa2dsK2dsSW53Q3pBZzdKSGpkNGJtN1BqeG02?=
 =?utf-8?B?VldGYnhzM0hCaW05VjNiclV5cThkSWJ1RktaNFlVUThuVzc2QlU4eTBhQ3Nz?=
 =?utf-8?Q?PhK/60wwwq4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFhjdGxsWHlBeGFHMEV4ckxaSktFK2ZoQ0xRQVQrQkRySXF4SkpxcnpXd2ZF?=
 =?utf-8?B?SVpZRDVLd2xzbTVDNW5GS0JsZHpUNUd5ZHBFWHNrcWd2blo4WFoxcE5hTjBQ?=
 =?utf-8?B?THdKZktodDFIbHZFL1UvM3ZMNHdobXRXRnZ5VVF0QnZJbmZxaCtQSjdpTWk0?=
 =?utf-8?B?eVNxRkhyNXQwS0hBd21iakVtbHY4SXdtNVZzOTF2aXIwMzFnOTVtaXcxTDBr?=
 =?utf-8?B?MDZtWExoY1JNUVVBeEpjTjVxUzRlT0RwalRrL21NM2pGSFRCVHpOSUkzRW5N?=
 =?utf-8?B?RnRxZVFLZm1YS0VmM1FNNjZTZCtFdUtkRVMxWW9oTUpYOWViNnFaRnR2V0pE?=
 =?utf-8?B?QkI2bnlLZ3hXSDdMT2EyN0w1ZFhLaFM0ZUpYZlBIbk1kYXpiTk96S2F3N1pP?=
 =?utf-8?B?bmo3S2dURE45NThrM3FmRFFRQ2k1R1duN3g2Q0RTemg3bUlJdG15enhtdVRr?=
 =?utf-8?B?dlAybmQvY0JKYlR6Z2huWkpiY0dsdXBLdjlaWkhYc0Qrem94OU8vakFmcDZ2?=
 =?utf-8?B?YTlLR0lRTzJTcHVQNzJFTDBscmMyUzZPb1ZXTHNuVjJ5ZkE3Z1NvV2dRamZT?=
 =?utf-8?B?YXIyYUl4cEN4VXprbjdLR2dnK3ZzYmY1NHlpcUp6TWNKNFM4ZlBrOUVDREVQ?=
 =?utf-8?B?MkJDT3Z6b1hsUC9XZWR6UVhkNng1bHc0STZISkJNb1RqbVpZeHJXKzFDcXlq?=
 =?utf-8?B?Q0pIeXBqWDlJRW5iVWFXODQzQTMwU1dFcWt4ZzFFM0hqbWZRMHVMTk1Tb0Rp?=
 =?utf-8?B?ZXlBZzZBTERFLzQ3ZTZ5SGkwS0UyOU5TY25RTmtoM0pJaFFQclFzS2MrckFZ?=
 =?utf-8?B?SG9VcUo2Y0l1aXdZRDV1K3p5T0tPbE9MRVhrRUxzaDVzNm15REJGVlVRRDc1?=
 =?utf-8?B?R3B4b0d4d1VTd3ZHOFhQZTZDckJ6R3RRZ0kvb25STVpTRHo0VVlObk4yOE1t?=
 =?utf-8?B?MGdGTzYzZzdqSXJwYWZ3cGI4UXlTWjJVbUh0dWI3NjlHckVVNnZjakZHNi9o?=
 =?utf-8?B?UWs2c3dsTHJVSEg5Q2dyaVFJVzdiWG1OMFV6bGl2V0hLNWNqQ1ZDQnZVbzJk?=
 =?utf-8?B?cTF0QVErTDlQVTc5NlovRUJTN0hrSXB1bXJHSGd4eW1BV0VZM21Halo5OGgw?=
 =?utf-8?B?dURKVVNLbytCT1BVeTFMZUwrLzdWV1hsWklVUTZlbnQweEZvQ2wxNDdQMmwx?=
 =?utf-8?B?OFhWQ0JOczRjQnZrRFRZNTJmNURhVEZ0a1hVVDk2bmQ5S0ZscUtybTB0S2tL?=
 =?utf-8?B?YXV1VTV0WlJOaGhnWHBzaGF4cUJwUWphSTR1NjJ2RlRicmxaOWI3Y3ZKeER5?=
 =?utf-8?B?TXVKV3ZnY3U0eFliWVJBRnhabVVJamMyZ2crQU1FMnRVeDJJVmRwZ3Bybmla?=
 =?utf-8?B?VDVrQmpoZTFwMURyM2k1OUFvU3BPOUlEa29KV1R4RzFCZ1Vod1VhUWU2SVEy?=
 =?utf-8?B?UXRPQVZ6UkVGcFZ3OFVFdFYxR29ubzJVK0lIWGh2VENpa2VEQVFrV2d2TjBG?=
 =?utf-8?B?dmxSZ1g1N2tTWEtjRkdZaHNmaWlRZTR6L241d0dWTW43cTEyaUt0YzNWeXp3?=
 =?utf-8?B?eXZmZ1NxVVRyNU8wTWg3NHdiMzArQ3dEcHVHSXFYZDI2NUFvYXR3Um1RT3py?=
 =?utf-8?B?TC80RHZhQmJ2RDFianI4eDYxWXQ5WnczbGQwSitTcXJSOGlTQ3dUMG13c2k2?=
 =?utf-8?B?cnZYb25OUGZhWkJ2YmtGQ1hPd0dYczM3L2M4OVFONUY5OVQySXdsZURRUTRt?=
 =?utf-8?B?YndJQmNZUlFJSjExQklLcjBDdkxjaHhMTXdPOWJ0enlNQ2FQUDNJMzBCUlFp?=
 =?utf-8?B?RjY0WXptNmhoUksrQ1E1VTJCb3ViNDBGR2R2SC9YMGtkVmZHSENWVU03S1VZ?=
 =?utf-8?B?Vkx1ZGRxWENTM0d1aTdyOG1OTkN2dTVtUklXRk5oTU9vdklPTW50dDJ2ZGk1?=
 =?utf-8?B?SXpvYTlXM3Y0dHZXditnbkxQMzFrUFcvWC9xOU9YdVU2bnVpaThaOE1KU2FZ?=
 =?utf-8?B?NmdZUEVuYk9KUkZIZ29hSDM3OWJJSUt0V01CUk9wSnlLWSs3RE40MWFqcW5E?=
 =?utf-8?B?WUtMZi9vVkUvazg1bDErclhpMW93dWV6OEF2MnhpQ1o2NnRuVE1ZQWFCYmZr?=
 =?utf-8?B?eFdOd1FXY2hCVlpMSjI5K1B5aEpsaGlCRm5tV3dhcy9vTmlQbFFEaThvN2JV?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cYAe4KleaPkZ/ki1TYkFY52lJDnTF71jmsWzvIN/ykbqA83z6bovfWKaM+DtmiMHPSJHg/LkxssgMY0JkpNUEJwqDzZAK8s97d4xF34uZg7etDtiI24pYJ+QfOLGVecYN5zHlaBi6uwAuCJmMbg6tBPOgqr+CGN6ST58z8fCc508kxMjc1FggCrABLH+vTy1xAYAseGUok2LexO5qUh5bpLYYZaP5DTT18dLp+fto2SiuKIX6HPJIMCVqKhgpj4jxk5SNIM4wFzRewfMIk5bE2YXRiayKlXdR13x0sCxhzW/I9iQpNFbmlspZHesXMfClAoqmvA05QwRPs+gyqS2rH848SAsiRVMogKqfLZvKcM+rmnZe2f/52/ZzexGaV+CBBaoSnRV8RVVHh6W59xjc51uW5rBvQ8bTT0aAb4JSQceiLTin1H0z8qTwdEXKMWN2AscbwI5JO7RPdTJGHEcXRsaa1czL+l8Zut03GeHydr4OnZALzh51BHaNrzonwYqRSK7Czi1yXjpo9TOfFicVucT9k+ssYwBioB8kvZjwQiASrw6N+u2/KfQnBassk9jjt8Y5a6zZ4LQZ3y2v821/02YZSdWxdBI1A5JvA/Q0DY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5653069-b8cc-49ec-844a-08dde697fee0
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 01:04:24.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSMHYvsGRsMOUCklvGR+NgVmm/KohjKcf4VZVrGZSoVINaVIFRWBwcg4PlLNuCBzWLCA5qKwS5vL+JkHLm6DkpYakuipOYdlmfTDFqJ9kd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF76BAA8D48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290007
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX2IfMKWU4f+z4
 C0XMWp1clSJPTEAyRoUXerpYArc7e9tbQbwdKSBBYHh863O0H1OO289883iHOVHsBuwDJYrGcb7
 haimK4Fth3uk+t4ColHQdM5hxUaTSD8bE+2YcbUGA28U1CSM8AoTq5wTcUYc8PPwR7pQsef5LS/
 zYSPNFXUAUCNRw9SudgXDlCmtsc/KWjJDSWNof0ww1Z6JvEacC0ChRZRodBLRjz0xJ9QUGekx0E
 949DUbK4U9Dhl9ZVCUSTt+5mPnWjSUbexZqcy49Ue0boQnkWVCXRyczif90T2imGntRybZIT0WM
 0BEUz9jCJw0vOGnCjoR6kG+6mnikUW9qVvniB4wn3PWtL4bl8pGlRikG5vIihjzvfWWumz/1y3z
 DQhkWS5VLX+FmOAgQyuGEDL0DbpDoQ==
X-Proofpoint-GUID: WV9-9p-JV6IldGBiYI8RrU2cROBrMlsQ
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b0fc9e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=sWKEhP36mHoA:10 a=968KyxNXAAAA:8
 a=hpJFsqIun4mH7OYcDjEA:9 a=QEXdDO2ut3YA:10 cc=ntf
X-Proofpoint-ORIG-GUID: WV9-9p-JV6IldGBiYI8RrU2cROBrMlsQ



On 8/25/25 7:57 AM, Yongting Lin wrote:
> This case is quit simple by using madvise(MADV_HUGEPAGE), but for verifying
> the size of THP memory, we need to setup the memcg and attach test
> process to this memcg before perform the test.
> 
> Because mshare doesn't support THP feature, the size of THP memory should
> be 0 even though we use madivse.

There can be THPs in an mshare region if THP settings are set to 
"always", but otherwise madvise() won't work directly on the msharefs 
VMA. It will be necessary to implement an ioctl to apply madvise 
operations to memory in an mshare region.

Anthony

> 
> Signed-off-by: Yongting Lin <linyongting@bytedance.com>
> ---
>   tools/testing/selftests/mshare/memory.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/mshare/memory.c b/tools/testing/selftests/mshare/memory.c
> index 7754c0e33506..2a415ce7bc01 100644
> --- a/tools/testing/selftests/mshare/memory.c
> +++ b/tools/testing/selftests/mshare/memory.c
> @@ -68,4 +68,15 @@ TEST_F(memory, swap)
>   	ASSERT_GT(swap_size, GB(1) * 9 / 10);
>   }
>   
> +TEST_F(memory, thp)
> +{
> +	ASSERT_NE(madvise(self->addr, self->allocate_size, MADV_HUGEPAGE), -1);
> +	/* touch 1G */
> +	memset(self->addr, 0x01, GB(1));
> +
> +	size_t huge = read_huge_from_cgroup(self->cgroup);
> +	/* mshare don't support THP now */
> +	ASSERT_EQ(huge, 0);
> +}
> +
>   TEST_HARNESS_MAIN


