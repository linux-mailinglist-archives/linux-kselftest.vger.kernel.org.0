Return-Path: <linux-kselftest+bounces-16521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37284962414
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80EA1F21031
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4333C15F418;
	Wed, 28 Aug 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pClNqJuN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646185A79B;
	Wed, 28 Aug 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838909; cv=fail; b=CtbmW1DkWY7shPFBERJXjVbr5d1XxdEdWGc9rZbq2UOrCOjkE4kDLavPj2CtznrieINx7SSsX2NemPRYZ3sS+Zg02ap1nJbxAHaarDiUJ+6X2AV4shvnSIho85fivFHhX2wdTOZqgNZyILnSbMhYsCHGTKcS7apa08m08kdHy8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838909; c=relaxed/simple;
	bh=0YDHXNOoimyB/icsM5qzt45ub3u7lkFy8JV1MGtsO0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FYMzb7uie9SFQSq+bYIOfyYzkAbNiMlh5ofF3fjwaDPTG484HyaD7PbkO1XxLPLTI+QT3EDzEpTBVqt38nbG2gKduAap94hPYyDkGDmigvNeV0Kmb/z2k33DAYtLIDSClUr6LyXL5Yl+4EO0npNauy6zHlw8mAF4sfazlC6aXYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pClNqJuN; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdycC3Uc9ZTqeGB8QirLDlwg9RtBiB8KqNt2sTKr0Esn9NOvo1yIZtGPs+bu0g80RDytPprSri8qjfcl8Tb4tKF/9qDu4WuTIoSplZGZygCnYdeyk2NLM0NvPctuaXTRBSF+RCvoOiQl7m0vk98x88MiPqdbphTIwuOx2LnZSZ7xGhmcwYdWU8adtcVT/blI7hG4qnsULgJNWmNDCUHyRFsI3GZ+Rj3EneFoyV/4vqQLgiyxShj6LNvC7W+fihaKyMYx5mv5Yrl6nog3Vd00wGR72fg0BPuLbD/wi7df0gHHj2RwA46jewbjUsVMb7+M6/FbZxwDzPu7JixHNeSOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTrKQlIrSEaagSUvoeCGOlYDdg9RT6aJBuujbdB9F3E=;
 b=rE07YJS2Cse9gp63UU/VmDOWRc5rdJ6l265L4L+2X09RB1lDG2eQ4J4WecpTLpAC3BgFfAW/GI5enjCaOGybRmATGC/uR51titl42iZbLiq4HhR95uPhN1kN/GFj4OP78bT8ZUaBgLaM2fniYRUAPN5Mlly1lUgrzp/Pg0g22xehMMBfWIy5/lWqa4Bl7kN0t/qMRTNEM2z5Hl0C9M8uiPsJ4TIMihOUo4BVFl93y+V3I4ct/DvWzmy0JJSmPMyE5xFFlX5/SyHi4t1G7Z3dWWtE4m2MDKfer5XFUIt04gaWqDE77reuR7JYv50CoU0i4Bxa8ANu7R1wVa2P2Gr48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTrKQlIrSEaagSUvoeCGOlYDdg9RT6aJBuujbdB9F3E=;
 b=pClNqJuNQmraQ4/yqn9azua3eYlR28by54Oqh3288GQzr2EVR7nPknHF0iMhquabMJW42aSwm2S9ntBfY9zUGINBkQOkKAzHPA3siHCeMTYSz4I6XDYwYOKaJ2IaryveeoUxcBJku6pbirRTa+TKJ6oKv5fTds2bf3AWhGB7AqO1qVCVX8WC1Y001lsB+pSrQV0uclzAWtFpcCHBisKXuecJyR3TyFAecxffrJz1/zdFsjMSuvk8uFoa0NxhJckp4B8qdelHNfOIgt8vi1MecKViniFL89xyPxoanGHMpUngA46UGR1fBYZBqdJJyzQWrPkA8bjInO7Amv9G8473qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by SG2PR06MB5360.apcprd06.prod.outlook.com (2603:1096:4:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 09:54:58 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 09:54:58 +0000
Message-ID: <72d7f850-2143-4287-b2cf-96da367b8941@vivo.com>
Date: Wed, 28 Aug 2024 17:54:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Fix cross-compile issue
 for some files and a static compile issue for "-lzstd"
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
 Yikai Lin <yikai.lin@vivo.com>
References: <20240827133959.1269178-1-yikai.lin@vivo.com>
 <20240827133959.1269178-3-yikai.lin@vivo.com>
 <CAEf4BzZXL9=pOkt=GbrYG2DpDGtXNLS7AHH5rL3adHd50zMKmQ@mail.gmail.com>
From: Yikai Lin <yikai.lin@vivo.com>
In-Reply-To: <CAEf4BzZXL9=pOkt=GbrYG2DpDGtXNLS7AHH5rL3adHd50zMKmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|SG2PR06MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f13abb6-78a5-463f-2160-08dcc74779d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUp0R3R4em5UNFhDMWZrM3RkOXRJUDExUWo2QXF0andDdkRSeDZ2UU8vMFVX?=
 =?utf-8?B?OHVhekRVMTRrRkVuZWQ1WmEvZStORk1PQU1jcHBoYkxjNFRnNzVtNFNmanhQ?=
 =?utf-8?B?d1duU0s5YmZMSUloVUhwb1MwdWEzNnFRdFcycDRZbktDRVo4ZTVtejF1V3FM?=
 =?utf-8?B?YzlkaDRUTkY4SXFWM29icjBUWm1tU05mdTV3Z0k1U09nQUtjT2VTbGRyRW84?=
 =?utf-8?B?T2ZIc3laYmd6OXpINk54OGVBRVlNQjgyb01nYVlXZDNObkU1ZGdhVTNRV1NL?=
 =?utf-8?B?TW1YL3NkdEZSc2NxenQyZTJKdng4UnZ5NlhTVWtQdVBTWWRheVVxUzY2OTZF?=
 =?utf-8?B?TWVwWkYrcElXY1ZvOXRQMjBkaEw0UVBZdCtFS0FGQ0srTFN4RXUzZVloblJH?=
 =?utf-8?B?Qzc4cDd1eDF6OHZ6WWdWeSthT2ZTZWh6dDlvbUJDeUYrZXBWb0dwV0dteFRM?=
 =?utf-8?B?YWtBRGUxL2RQNnA0SjlrZXlwM3k1Z2FzYUhzcHN1QjJHTVM2dnRwZEJWbFlx?=
 =?utf-8?B?UmJhRDJsSlNEZDFrY25hYXNpZ1FrK25CUmhKWlc2WXhrdm84bzBHY0tsTEJC?=
 =?utf-8?B?TnlnemdBcHVGWlRxU2U3Y2FHNGhkQitWMi9ZS2FDWHBIZXRjYkpnNHJja0FL?=
 =?utf-8?B?eFJIQlllUFU3R1VDVFcva0hmdEVxVFZINktZcUlsVXhCTzkyUElUWFFPNi9Z?=
 =?utf-8?B?YnhsOHJHRjZIckZva3ZmMGpVS2Y4RzZRcmtpYzR3VEZWYUozclV1RWQxZ0lB?=
 =?utf-8?B?RkdEZC90azJhUWRlTWtjbjIzd0U2aGZhdkRsQ29xV2hiR2pUTklXbURvWU5N?=
 =?utf-8?B?MXl3ZGdMYWwyamJ0amt2Qkt6WE5UeGVUazVIaHBJMjYvZEl6aE9RVWQxeEp2?=
 =?utf-8?B?d2tBOXRQQW81VnNycURUUlpUNUVwWmk3R2I3NThQeCtlYnBtbnZzWG45M01r?=
 =?utf-8?B?SkI4OHhzVGRYeGprK2F5SlhINVdoaU92MEVsY2xRaVVGNm0zL2dXWi9OQ2kw?=
 =?utf-8?B?dkJEZjg5NXI1RTk5ZFE2MS9YbHRRV3MrS2psTlluUytzbFBBZEdCcTNPTTkx?=
 =?utf-8?B?cHE1ZjBJbWxsUTRnK0VqTkhhbklXelQvWk9ZTmQ4dFRSS0FOWHRrMzljMSs1?=
 =?utf-8?B?ZFNPSGpoNDI1N2FMbnlxdFozUWNJb3EzZVZyUEcrS0pQSmYyQmhBNytnV1JJ?=
 =?utf-8?B?VHZoU1o5QkJYc2Y4ckZVeldjbjFtMnFWVEIvK1VpclVkdVBsbWZKRDA5OXNB?=
 =?utf-8?B?MGpLbHJCR0tzUTFCUUlMSzhIcGRKS3hFWkJXL1h2WUdmb2JReEVraGtaRDJw?=
 =?utf-8?B?QURaTzV0QUdrRlczZjdVS09uN25DRHhXVWNDN0dQeTloclhrS2l2Mlp2QmJk?=
 =?utf-8?B?YjFhWm00Y3F3eW42TFdub0V5QW9HMklJVFVEN0Jjblp5cVNHSVN6RUlJRVdF?=
 =?utf-8?B?NG03RmlKcW1LRUdjNzNUelFrcVFIVFRRSVZsTjdlU3ZBTzY1azRoVlBNeWQr?=
 =?utf-8?B?RU9vZFZKUG9ERTllcDZZVS9oRGNVazhEOEh4UE4waTlCZkpISzZId2VQV0Y4?=
 =?utf-8?B?OVZyNkZQVVAvVE92VC9iSmRYL1U2aVVWQUVGWGxtNEJtWFlZclRIL0VVWEkr?=
 =?utf-8?B?TUNqamlpSnhiTlgzQWR4RXdaaUFtd2NFa2h3REFOb2JTV25VYlpXcWxSV2J2?=
 =?utf-8?B?dUJCYk9uUlo1Z0FPSXpPV0czcll3Y1J0K21uNlFaVzd6SUVDeXBCTk8rZEMy?=
 =?utf-8?B?SU9hbUxsamozNk5pcExEUnQ2VVhmOGUrVkF5V0Rsc01HOEV4NzZSTzlONkhC?=
 =?utf-8?B?WERWblArWmsvQ3BLdFN2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elNjWVJVZi94UVdGRHVUQ0JxOTZXRzZUaE9haUpwSmZiczF0cFlCdW5HWFdH?=
 =?utf-8?B?OXh0Y25UUHRoQ3BudGZnZkl6d081bklzcEVuRjRwQmNaY0g2YTVvK1owMkVL?=
 =?utf-8?B?WnY5VzRzNDlIVzIrMHRVWEV6THlvQmI3Y0l4RE5aVzRhckVzVlRFd0o0a2Fi?=
 =?utf-8?B?NzJPS0FCdENHd2tpdUZ5VS9OeStYVHFYRkdmSTBYeTZvR210dVMwZUZBbGlQ?=
 =?utf-8?B?OFA3cmpyQ05vV0x6UGdzVDVycSt1d3d3dVpOZ0s1YkRZYzdPNHlkWEJlaGcz?=
 =?utf-8?B?NTMxa3ZraGxTby96SmF4cGJsRlhQSWdUTVp4RzBJOU5zaHI0TTFxbFN3blRG?=
 =?utf-8?B?ZktGMklhVXFtTkZJdWJPK2RTemxwejY4YkZXK1FLWVVxSVFLTnBVWjNwUkdY?=
 =?utf-8?B?bkdpWjZhVzl3TXdPQnlhajE1K0ZDTSszckliWTd0SGQzU2MvOWpFczk4NTRo?=
 =?utf-8?B?MXRvTmxtbFVrUDl1R3ZabFRxUUM2dzVEemdTc0NvN3NibmltdU13N0kydEl4?=
 =?utf-8?B?eE92TmZ5QTBEUllWQ1ZmdUJUL0JGN1QySWhSS2c2MjJjN1BhUHhtcVR0SFVD?=
 =?utf-8?B?WEVaTFFuY0NWSnJCb2xvcTZDamxrd2l2VUlycUFjNnBtUWE5aWI3M2lhYW1D?=
 =?utf-8?B?TGNmbnpPMy8vMm15Zm1tcTZ0VzN1U1BqZklFNVArb3Nnc2REeHZha3VtUDVC?=
 =?utf-8?B?TmRuQ0VPQ2xHU2xjM21jZmlqRS83SDVWZGtLalVxamkvbGJ1eXZaQzdFb1kz?=
 =?utf-8?B?eXE4UkZJRWN5R3pEd00zVEJTRURLNzZMQ0x2eDBNSHd1SjhjR2JiWDJDRzFF?=
 =?utf-8?B?aGNLSFl5WVZaU0xNMUs2UTdHR0F3T3UrM0plcHBUd3pwWVp3aktNbWdUUDVi?=
 =?utf-8?B?Yi94WDloaXFMRFFVT1FqSUxGQWwwYTdvTUpQdjlVQVRlN204MGFuRGhwWXN2?=
 =?utf-8?B?OEZWNUpXdXNQN3Fld2NJdkYzUTNMb1M1aXVzRUcvaHQwR2NyeGM3Tlg5Wmlu?=
 =?utf-8?B?cmFPWVlLN2wvYkJhaFh3WXBwa0ZTRWx6ZE1CaU5ZWVZTSHFPSlMyRTQ2NGZ0?=
 =?utf-8?B?d1FKY3JRRC9BK010blRPUU83b1R5OUp4ZTZ4L1BxR3VKN3pWM1hoakM5S25k?=
 =?utf-8?B?SU9WcHhBRkNtc1lLVE1XN1RUZDRVTTFXL01hOVNUQ0JvK0k4ekp2VEprNW5w?=
 =?utf-8?B?OFcxS0dqRjFLaEpJbUFsMllBT01Pb05hRXQ5MEVBTTlxWkU3TGtTNnpLM3FB?=
 =?utf-8?B?NEdydmRBMEtQWHNqaHRNQzlBbURnZ2k0RFg1WWJrTld4aGpMRllMV1dxVWhM?=
 =?utf-8?B?aHUzZXZDTEdKTWFvajVYQ245ZSt5UUd3cWxVMlJHOHJGLzZvaVlEQUlUODNE?=
 =?utf-8?B?b1h1NTlpS2cwN01MZnVnLzBUdWhnL3U0VXJsYWk5TytaVENnMlVwcVNxNS9o?=
 =?utf-8?B?Q0tkMEVpZGEyU3FEZkZkR1FnQ081Z05STEs1S2ZsbEdFMVpNL1JwMEFUd2hn?=
 =?utf-8?B?SHA4S2xEVzFpVzZPaUwrTlhrdXZ0TlZQc3ZDTURWYnQ0R3dYSkZVK2I3alU0?=
 =?utf-8?B?djdMMnEvdHdyTjBrczB1UXBCM0hweGhqS1I5OGFPRGJkM2IyZFg0SDZZQ1o4?=
 =?utf-8?B?bUtkdk1uRmxKWWQwdlVDVDg4MGN4K0EwZGoyU0lsQ1NWQ0d4NS96N1hwN3Z6?=
 =?utf-8?B?S1VRcm9JOUlFUG11ZjFIMTUvVkdnTWRPd292TU9DRjBZNzFSckVrQ1hRYzcr?=
 =?utf-8?B?V2pPTCt4Ym5aZ1ErNjFFK2VjQ0ZOalkvOEJEdUF2cjZtdFlIRW01OFFNY0Jx?=
 =?utf-8?B?WWZPWmxENEFpRDM0UEJTL2s5d0NGei9UTzNWU0UvYjRlek5NT21WVCtDa2g4?=
 =?utf-8?B?d1JEZDR5RzdDZWMzQ24xZEo5QmMwc0YvOWZDNnk2SGdIdktaRTI2NGgxblJa?=
 =?utf-8?B?blZyS2hUc3V2Wk1QK0ZyendhYkxwOHd5OEpmdi9ONlp3WmFRbVhubUNDL2dQ?=
 =?utf-8?B?SFluVWg1ekk5VXU0K3poQ0Njb1hZTlB2ZHVaRTYySS8xbVdjbWxEQ0FiYmJz?=
 =?utf-8?B?Mm4rTHMzeENFUngyRkVnR1NHcS94Y0ZsdE5QWHZJWTJ5dVA3a1FCUFNhek4z?=
 =?utf-8?Q?SSAw+rR8YxkvCG0LVXmoaIwe/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f13abb6-78a5-463f-2160-08dcc74779d1
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 09:54:58.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUxmBIZJZQkw7xuAKxhb4Q4mZUfIZBZS1nkKMZBn67aOj9/LbruD5YKupf29qgFbxaG9AN/+9U49P7dBpr44zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5360

On 2024/8/28 06:49:18, Lin Yikai reply:

> [Some people who received this message don't often get email from andrii.nakryiko@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, Aug 27, 2024 at 6:40 AM Lin Yikai <yikai.lin@vivo.com> wrote:
>>
>> 1. Fix cross-compile issue for some files:
>> [Issue]
>> When cross-compiling bpf selftests for arm64 on x86_64 host, the following error occurs:
>> progs/loop2.c:20:7: error: incomplete definition of type 'struct user_pt_regs'
>>     20 |                 if (PT_REGS_RC(ctx) & 1)
>>        |                     ^~~~~~~~~~~~~~~
>>
>> There are same error in files: loop1.c, loop2.c, loop3.c, loop6.c ???
>>
>> [Reason]
>> On arm64, in file bpf_tracing.h, we use userspace's user_pt_regs,
>> which is defined in "linux/ptrace.h".
>> We include the header file by adding "-idirafter /usr/include" for "CLANG_CFLAGS".
>>
>> However, during cross-compiling, "linux/ptrace.h" is based on x86_64
>> and has no definition of "struct user_pt_regs".
>>
>> [Fix]
>> Thus, to fix this issue, we include the Linux source tree's header file directory.
>>
> 
> Hm.. Not sure that's the right fix. Note -D__TARGET_ARCH_$(SRCARCH) in
> BPF_CFLAGS, that __TARGET_ARCH has to match actual target
> architecture, so please check that first.
> 

Hi, Andrii, thanks for your advice.

After searching, I find needed "user_pt_regs" is defined as below:
   bpf-next$ find ./ -name "ptrace.h" | xargs grep -rni "user_pt_regs"
   ./arch/arm64/include/uapi/asm/ptrace.h:88:struct user_pt_regs {

So we can directly add it into include directory
by below approach without "make header_install".

   +ifneq ($(CROSS_COMPILE),)
   +src_uapi_dir := $(srctree)/arch/$(SRCARCH)/include/uapi
   +BPF_CFLAGS += -I$(src_uapi_dir)
   +endif

I'll test it and send a v2 patch.

> pw-bot: cr
> 
>> 2. Fix static compile issue for "-lzstd":
>> [Issue]
>> By running the command "LDLIBS=-static LDFLAGS=--sysroot=/aarch64-linux-gnu/libc ./vmtest.sh -s -- ./test_progs",
>> during static cross-compiling, an error occurs:
>> /aarch64-linux-gnu/bin/ld: aarch64-linux-gnu/libc/usr/lib/libelf.a(elf_compress.o): in function `__libelf_compress':
>> (.text+0xec): undefined reference to `ZSTD_createCCtx'
>> /aarch64-linux-gnu/bin/ld: (.text+0xf0): undefined reference to `ZSTD_createCCtx'
>> ...
>>
>> [Fix]
>> For static compile, add "LDLIBS += -lzstd".
> 
> we can probably just add it unconditionally, no? But please send it as
> a separate change in its own patch
> 
Thanks, I'll try it for v2 patch.

>>
>> Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index ec7d425c4022..5b725bc890d2 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -48,6 +48,10 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic                                  \
>>   LDFLAGS += $(SAN_LDFLAGS)
>>   LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>>
>> +ifneq (,$(findstring -static,$(LDLIBS)))
>> +LDLIBS += -lzstd
>> +endif
>> +
>>   LDLIBS += $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
>>   CFLAGS += $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null)
>>   CFLAGS += $(shell $(PKG_CONFIG) --exists libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
>> @@ -443,13 +447,19 @@ CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
>>   endif
>>
>>   CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
>> +CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
>> +
>>   BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)    \
>>               -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
>>               -I$(abspath $(OUTPUT)/../usr/include)                      \
>>               -Wno-compare-distinct-pointer-types
>>   # TODO: enable me -Wsign-compare
>>
>> -CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
>> +#"make headers_install" at first
>> +ifneq ($(CROSS_COMPILE),)
>> +src_uapi_dir := $(srctree)/usr/include
>> +BPF_CFLAGS += -I$(src_uapi_dir)
>> +endif
>>
>>   $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
>>   $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
>> --
>> 2.34.1
>>


