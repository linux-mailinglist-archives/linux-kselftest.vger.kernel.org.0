Return-Path: <linux-kselftest+bounces-13467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8390792D498
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A28B24DFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720EA193479;
	Wed, 10 Jul 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n0hvz9qh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qSlk4tZq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29519309E;
	Wed, 10 Jul 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623316; cv=fail; b=IGb1bLlXiaxGRZi+W+TshKOAwZwG92AGlF18N26q0SB07ASVOnNcrOJeeEjDY35Uczj7xIHK8vPV+vEcShnPIMZ8T0s/1us0Q2wKqd6vPk50LSMHSr40SwN7TQK9wgmOQCdDz50ZO7voy3DNvLbs6FPeSHIb9Lekjmfo9q566iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623316; c=relaxed/simple;
	bh=2rhxWGdsd75gragUuWVV4zx3i25XeN8ITbgi14ppjvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hyyPjt27qJEGG2mSOWO2SNmIy3BCkzKxW85Ez8gRN2gfUKeMfrbGxCghTp9eEAASv4qiVjIOOkkpU9tjk7mgs65mcwFvDhRv3F0FBHzbhI6mXpGVYVOZVlthgZTHGaTJueBycmEPEpojP9SVALcFNHoMAVtacE7Gly5G7tUtkyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n0hvz9qh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qSlk4tZq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fXid019278;
	Wed, 10 Jul 2024 14:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=cCVPM7NQXpi/Dhk8mYq70jVdGqzluiBhHpc1OswsrPY=; b=
	n0hvz9qhQhr9vD8jgfeiNfh4ymrIL+EzU3DANj2lZGIM4tE+rq8wg823J9yvSSuk
	fVKVv5aZZoevzEQguPWxJpMDTr/9/8aAmwIMZUpVlE3jZeD4PSCAxOf0T/jN7C+f
	z+q1sqaq2eMNhrZhIOg0W+N85Ad72g9Q+cGbgAr6NjQbSKXFlPkUiEt54+zvYdGR
	D0dV7Ip2w33ZFDQbtPMY8Iz9hndK92Xgb4CMwZ8X23DkuwbNV49FRRqwokGDq4S1
	/obqDgA3L+b39JO36HO969VOn+IRgKHNGe/obnGoyIuvYBDPr0uTiX33ZtmI9nmx
	VFkjaphRuswvXPJ3bKoOWQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky7gpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 14:54:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AE60cL005700;
	Wed, 10 Jul 2024 14:54:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx4cqw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 14:54:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEIc88L9rA67Cz3pMUU9/MRMyrBBZGt7ldyE0kUOn8cK7El7rhdSPO+vy3rLG2R9VC01fvxAuvZB43nyyXRFc6X2KfuNDTXyxBje60NcxAklrqzQOdG2W4cj1a0G34KMGm30SZZy3ximIWXkziMKOI5zu+2Yb9vhFLI0rb3wI0IUPE02Q6od7ZJVXZil6L34sDsx8Ib76iGz7ucscWbmJZrBU8QHO3eOiycb2KytV+38t6eo4JbGGH6w7LX4M7J9BxhYDp4UOIEG4KsEvJ/NO3fYEU7IqsIVVQ1653b2zeG0zb37IXd1Y9/65TcdGKw7kahzQFfdeO5/Xdh22/PtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCVPM7NQXpi/Dhk8mYq70jVdGqzluiBhHpc1OswsrPY=;
 b=LH6MNkqI8lTDXnA/QANZBHahzBn62yT2zaLBzzvqM3rH0fCzukUx51Qoo3IcUBkpU2zYlAUTLyecwyUV1D2WnODKnrbR5Sgyx/0y3aSszUT7yMc5NfcNsB3l2uZUVIz6OIaXsQU+wGph+0UAqaGTRfiJNskRxixmkATSxFx+Riunz5XFnAaPo0DXjgp9+TVxnhHbxlTj2QJdkRRsNXPhJWFTytRA30wDr/VMrHc4cZhhvNcunmXxtwnCC0x/HHekB2Bx/Nky7HOIox+mqvI3EL8Sac7JXt5/Lgg5U/TwdG3f3ZEnZF1G7Xk1l6++2EDudt0ktJaETZ84Z2Ud2A6H4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCVPM7NQXpi/Dhk8mYq70jVdGqzluiBhHpc1OswsrPY=;
 b=qSlk4tZqKlkDklo86UH79DYu1f1xtUysnR+f+gMe+b7KriHgTn5mlS2SHzwX3FIInZrgGbWVQ/MwYn4Gf4+JMFDaJBz89tGh2+7YCHc9eiWZBwYzgMHq27usOrPgA5oRKwqARM17qLrkRdgCYNT3QUylqg7QRR0L1i2GegUQpiI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB5147.namprd10.prod.outlook.com (2603:10b6:610:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 14:54:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 14:54:12 +0000
Message-ID: <652ba92e-8f74-47e8-a8c6-76e147421830@oracle.com>
Date: Wed, 10 Jul 2024 15:54:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Close obj in error paths in
 xdp_adjust_tail
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <cover.1720521482.git.tanggeliang@kylinos.cn>
 <3e55e7dc99f0331566cc3bb140fc189a0f8943e9.1720521482.git.tanggeliang@kylinos.cn>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <3e55e7dc99f0331566cc3bb140fc189a0f8943e9.1720521482.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0045.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 432ddabd-03d1-4684-dda2-08dca0f02949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NmhxdmhwSm5aVWhwbnRPSXk3cDM0cmtlaS9kbDZ0d2JNNmlMTDRFM0FEb0c0?=
 =?utf-8?B?VXZld0M0NjZvRG1RMk5aVkYrSnBPekQwNHpHODh2WjJrUTlieXhLakZxWnRo?=
 =?utf-8?B?K2pKaXdiNmRhc2MxQkdKOHNaaGRiVUpUQ1Y5VDJ6d2cwTXlYQWJtRVdwSzBG?=
 =?utf-8?B?QWN1NldUdFJvL0pyTCtOSjFJOGJnRDBtaU1lUFlYdEVnOE1taWkzZ3FmRnNh?=
 =?utf-8?B?UzNlQmhGZEthVGNYUFZDdklWU0FkM2UyM1A0dFlTcm9iRWRUY0k0UXJTS01a?=
 =?utf-8?B?THlaeFdKQWJvZGpWYit5TmpVaGhjWjRIQlNCK0Y4NXJUS001UGtDcUxxeWZ1?=
 =?utf-8?B?Mi82cUxSL2xTdXlYYWQwQ0dGSXRpbXVEV0dsd2lJZUxVM2NQcXV6VlVoeURG?=
 =?utf-8?B?SkdCQ2F1Z29oMVBCWkhsZWJBTE90WElQT0NHUDVGemt1VEVHYVVCUUNuaU1r?=
 =?utf-8?B?Q1dnRDFEdFpaTzkwTHJNRTZGSUROQVRlODBwcHFFMkhSaHpQem1vMWNoSGNi?=
 =?utf-8?B?SzJZanNSZ2JpVUR0SnIxajVnbm1qOXg4NkFHVms2UkIzSElsZmhrOFh0aC90?=
 =?utf-8?B?aktESGtlb0ZkLzRPdkhUWHNLdG1NcjBYYTZWV2V5WWJlK1FuVHE5MElYL1JV?=
 =?utf-8?B?bzJKbWlVNkM5VTdFazM0cDY4U1IvTi96R2k0Mk9zVEtRNkpicjR4M3YzcWhG?=
 =?utf-8?B?a3B6aWRURzl1NzRIWTJOaXUxQ29wcUpnZGx5UWVhMWhUTStpZG50Q0RKVGZY?=
 =?utf-8?B?amVNOExnT0hDYnBKZU56NFFYRXVyeER4NnB3NTFFWERPVDY3NXRZNFpoQ3Zq?=
 =?utf-8?B?aHNHc2xRV0huY1hQQ2VERkxqb01hUjdqbWp6SFZJUURCRUNjT0xjVGNaRnVY?=
 =?utf-8?B?SGVsVHhId3dVZ2RFMU00TmtvMSt4K1RFNUgrcytQZ21pZStFTmNBbUtPV0xZ?=
 =?utf-8?B?ZzJtY3NGTCtwTThnQ012bVN3TXRRbnpBQ2I4UWxQd0E4NVZRbkVpeW1lRWpn?=
 =?utf-8?B?b016UHZFc1dPN0NvYnB5M3ptaWdYMzBSQU1rcTA2SHNHaDVYcUpEbnRjR1pN?=
 =?utf-8?B?U2VkNVBnNlBCc3BxNzZyeDdrdG9TalpjRHJkazgvelZIN1F4UUhBb1AzVUNQ?=
 =?utf-8?B?RS9seUpRczJ5UlpyRjFsOFYxVDlac3NZT0JFZ0lRNEtQVmQ3SnVRMlg1WlJX?=
 =?utf-8?B?SkJTMmpBRWFaOGtnSmdjU1NGcXNaRXEwdU56Z0wwRWsrWUExeXdLZDdTd1R2?=
 =?utf-8?B?OFBYamlLZyt0NzlldnJST1FRc0FlZnYxUUM4bFQwSFdMTHE5akJIOC9aVTc4?=
 =?utf-8?B?c1hPYXlYM09TWGwwUUU4NHNDTVhXNG5tQk1ud2NMRHkzckp6TmZ4NDJoRkN2?=
 =?utf-8?B?d0lMUHIvQW96cXloUmlGMm8rUHV3WUwvZ1BNZndSS3FHZGJjRTdaOEE5N0FO?=
 =?utf-8?B?L09vM0MzS25nTUQxdzNVVTBDZmpUaEZYbGVGZXRMayt4akdUSzR3RlJxaVJE?=
 =?utf-8?B?bnNLRFVpN1REZ3MxRUluWmdtOW5GVGN0cWdablltL3FLanMrYWNSY0V1aHVZ?=
 =?utf-8?B?aGtneFQ0Z0toRWJwR25VVGY1TnVPRU9Kd3N3S0xUWUpkT2pERGE4bFJnTkdB?=
 =?utf-8?B?VUNKRjh4V25INXRacUdqZjF3dDlYQ0RQU0l5RGcvdTlBRUk1SVRoZDBPd3h3?=
 =?utf-8?B?akZiUUlQSVVnYi94dTJYcVcxVGtWMmZlc0RGTkpyVzBOYk5JNXkzOE5ja3pS?=
 =?utf-8?B?VkRibnhjMzVOczY0NjlYV2hreE5kZk5QZ1QwYnh1TGtZUGFML1JqekNXeXRQ?=
 =?utf-8?B?dWlLZG16Tld0c1I1YzFTUngvU0Y2VG5LUE8vWWMyTzVvU0ZtVmxxaUFhS1JS?=
 =?utf-8?Q?///lL9lC1IF24?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHFJTkVYREg4TVl6aGR2ZGNlNmtEWWpBcWdRcXVTK0dDSURLZjJlaEVTYlU4?=
 =?utf-8?B?WWV6SnZWZEFkcEhGVlJIQ3BhUmxCWFZrTkptL0hMUEVKcUE2V1FUUzBiUkZz?=
 =?utf-8?B?V0JqREF0Q2UzbEZ6c0ZKeDFibXBEbDB1ZUFNblBVcHZONC9Na2NrcnNxNWpJ?=
 =?utf-8?B?a1Mrc0RBTFRUQWlNUVpwQTlkTnZUbWNicDRIRFdYcE9OdUVhWk1KVk5IRy9t?=
 =?utf-8?B?bGI1bjdwNEprTVVpcXdxZTFCZ1pOeklncnhDczFhQXRzd056UEtmRjdGZWVU?=
 =?utf-8?B?NHZVZTBHM25TNFZlcVNDMFIrUEd5b0ZkczhjVGE4R0JpbjQ2a25RODBUUkpm?=
 =?utf-8?B?NmpJTm9KRUNZSE13c0hObkVKazZvV0MxYi9mVnQ1aFErQ1puKzNHbHBCRjFC?=
 =?utf-8?B?dFV5QW1UQkZERE42d1pNNTE1YlF0SHcrZDRRUlNEOXJCaDVFZHZCb0VJSld0?=
 =?utf-8?B?aFBVNE04b0oxbHR2cm94VE5ZY1ZXY09FaktVSTZCVldSYXozVWsyM2hTK3ln?=
 =?utf-8?B?QTEvYkxQcUV3d3pvaE8xZllaOTIvRml0M3pzUEVBWWhSWUZCbWFGa2puVkZQ?=
 =?utf-8?B?cHRQNXU3QmdxbGdWbnFGYTRDcmdIbCtTbVZaNVNCemxHVUxnc1pTQUdoYUVz?=
 =?utf-8?B?YVozRnRKQVV5UWZNV2tZZFpKZnR3Nkc0U3lBMkgwQ3FhampJNHNuZU9lS0lx?=
 =?utf-8?B?WVFjRUQ1Ym1ESWM0dnNFTFpvRGNEWm9NeTN5ZDJPT1RwSWd2ZkJnaEl4Zmdz?=
 =?utf-8?B?Slk1b1pRTmtUQTNTcmQrQ0ZwZ1QwMk1NMWdTRVQ1MjNLckJzZlpjSFFVU1ow?=
 =?utf-8?B?eWdMaE9LVUNmSklzc3k0aGdOTVhGZ3l1b0ZEZVFyd2NvWjB4WE1nMmNvY2J0?=
 =?utf-8?B?bUtLM0hxSFltT0RqeUx4SGN3dk4zTml5Rk9RQm1iWW5jUTZvWDhEbG4ra3J2?=
 =?utf-8?B?ZnI3WlAvTDZ6U0UyTUZDRC9iU1lYeWZxNGxrTHh1dFN2MXg5a0tLMG9VY3Bn?=
 =?utf-8?B?TUhmcnVNbzA3Z3l4aEN1TDlNTS9Hb0tiSWdoWkZ3ZGpDalhUNkNvYnBUV2NF?=
 =?utf-8?B?Zm5WRXdWeFdBWS91YzNMbnEwTWkyUXJnakJVRjdKc25XWnRBYnlVekVWaTZr?=
 =?utf-8?B?RnptK3B5aXNMTmgrdGdvVW5SdlUyQXg5d2JqTThmU2dOTXZGMDhkWmsrZTly?=
 =?utf-8?B?WFVCQVpCNTNSb2hhR0w3ajRrU0xuVEM2dGs2UDc0VHVMMkptNm5XOFppeE53?=
 =?utf-8?B?ajFYY0gxNlk5c0pQZXNWZUJ4eEE0eGlBbDRPRTFVSHR0VFY2N3F5SFBjcC9R?=
 =?utf-8?B?R1dyaHZxKzBuckpRazBqSWdPMjFQTGkxZDA4ZVN1SVVKLzU5aHNrSGJVd0M5?=
 =?utf-8?B?S1RIaytDbGZGSWhsV2NBUUJNY2lwakNBaXNZbVpjTy9kczR5M1BLeVFHNEdD?=
 =?utf-8?B?OUZWa004bmUrQ2NUUUR2dUhjNWZXSkNhN2drN2M1bkg3eUthNlV3MHdmcFV3?=
 =?utf-8?B?dDZlUzRoVDJkaXIxUmJ2NU9Da1FsSHJSL0tneU5NMTl0VXR0TWpDZWJPQ0hO?=
 =?utf-8?B?WXB1SjNqNVVlMzdMNDJJQTNLMnlqKytSUndLVVJXOUtiOTNKWGx5anVPRktR?=
 =?utf-8?B?WndVMTZWUzY3QWpJM29YRlFvQnRlRGl5RFEvQ1ZOY0I2YTFaY1RLVlJLUEtQ?=
 =?utf-8?B?bENseS9ITVY5M0l3NHQ3S1R2bjd0ZERPcTZYZG1RSEZwRGVtZGI0T1MwS3VT?=
 =?utf-8?B?ZDU1SlkxYVJOb01nYUpPZlV3UXhBOXRDT2tQZ2JtR1dOanU5enpRdmlFc3JD?=
 =?utf-8?B?a0h4U29FdTBPckpwZ2Roc2h1QithWHdIM01ML1RlaEkyRCtCSjloREJzbC9o?=
 =?utf-8?B?WmtETHh5TlNJdjdQVzFJNmU3REtTRVlsaUpyQXR4TDl4bGthU0FYNytnbkto?=
 =?utf-8?B?Vzk3ZlhLd2s4VU14eFJBcnZScW5LOXZuazJ1Z2xpM0xTaTZsMytVWXZUWWh1?=
 =?utf-8?B?Rmt0aHFIcmFTelFxT2NHQjF6ZmZnZnQvdU9oR0dGSXQyeURyVGFTMEFTQ3N2?=
 =?utf-8?B?N3lxeW9aWmpyazZVdWlUTnd1RUpHRWs4RHpvbkZWY2tZVy9veG8wYm1xVHdq?=
 =?utf-8?B?VkVuYml2NnVDd0N6cWhQR05RUmM0SDA0RkZMVGxFUjZhSlBJL2dBSEQ0dHhI?=
 =?utf-8?Q?K7qqk/1t7xov98B6GskNxk4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kFxFJlhX5JJhn5Wy/4j+udqpHx/GAHthSWeXSADKHPOLJHL8D82PgUiG674+zjT0wAZwrSqX5jGhGvDblEFts4dkzpOV1TRBDo+XRsVpVa/ug89b1QO9CR5EV3ksSa4roxCWPMjDEjzOj3R4u0/Vai5DtqUanLCDM/Uklsp4aUw/+3GQAZo4ZoO+DPlp7PRqIXJJMw3KvHGL98XlOijDC425r975OS/sQt/MioZB58zZ4GDYPxiGdbQ2xzvgwMx6Zeu9zfLhGhj461XAU1+EgL5Nfc4aWEmgrejtYfcGgpAeq2NfN6AA8cj0jy2RdI8TEduo8JZxd4lGlgZ8XicCcP6PPPepIaEsPp1zbSqQoxNo0PuIPxGOcHmY276WccuSBjvxY54NwHhuJ9SOVO6QNR9qYJTlkXeNmU5AAXubWkRYrp0kpVMdByN14pg1vpfdt9ecN9IEQ8L4Ud4jpUePyVciDMNpPw+Y7CSR6lwIgdgHeKCCe0kzzP3XPJ88Op2fHD6ecMQrWAtERlKhdxE7dRJnK89TNMuOJdrwtx9caKYp/8QTGiRA4SDGqpBxm5IBG+e1qRSUeXdlr1UZmMRn9+zYJ1c9fhkIj7zYdfTr618=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432ddabd-03d1-4684-dda2-08dca0f02949
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:54:12.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eashdn88mWLBEVCwN9F8UzWT9pHqM2k4tEUZz4hmTt4V7LVUCJ4VZ0wN4hUDvqK0NRXa0CmgTGqPUlumZ7ZgWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_10,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100105
X-Proofpoint-ORIG-GUID: wobR7Blkn3Yt-7dO-jT7yqyHMJdezNvA
X-Proofpoint-GUID: wobR7Blkn3Yt-7dO-jT7yqyHMJdezNvA

On 09/07/2024 11:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> If bpf_object__load() fails in test_xdp_adjust_frags_tail_grow(), "obj"
> opened before this should be closed. So use "goto out" to close it instead
> of using "return" here.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

...with one suggestion below...

> ---
>  tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> index f09505f8b038..53d6ad8c2257 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> @@ -222,7 +222,7 @@ static void test_xdp_adjust_frags_tail_grow(void)
>  
>  	prog = bpf_object__next_program(obj, NULL);
>  	if (bpf_object__load(obj))
> -		return;
> +		goto out;
>

Nit: perhaps we should change this to

	if (!ASSERT_OK(bpf_object__load(obj), "obj_load"))
		goto out;

?


