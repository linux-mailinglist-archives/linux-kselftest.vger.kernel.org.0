Return-Path: <linux-kselftest+bounces-44610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC46C28629
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21EBE4ECAEC
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F14D2FFDEA;
	Sat,  1 Nov 2025 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p4GKa/BC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I+LGD17R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E0221FBD;
	Sat,  1 Nov 2025 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024887; cv=fail; b=gLdKH15a7cwPzDITuHehn9UTOgF6pshTugST8RVzsVmQu4DHYLEbiIly21zfuiTUrw06Rqu68dvhcos5jYuapsnqjxv7vX4qkiEJ6fxhnDjFjEH+sQ3O2GrruvnVmoUziYR5yujdq2zF8mMXgZ3+7++xLScl1z9a/MFL6JbTJTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024887; c=relaxed/simple;
	bh=1yRkmmLd//vg7SkdW/bCjzf+FgvRAGAYaCpiCmVSoDk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lf6U7qZmYLKFMz1F9klQaW1QSkeTxGNGhVVKrsYjpb5nA/VLGdc6bhE++cPoLJIjFFOsmYidYJWUZzE4AJKFYXAzZkBD+TLVkF6f3JfkxQWIF7av1K7rl0mPb6KDKyum3LsFvME5ZbLJE9O7e6j5/7s2ocUK1q72JpPyLSFaGcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p4GKa/BC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I+LGD17R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1Ij2RP007769;
	Sat, 1 Nov 2025 19:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c+TsWaFKBdOYZHKx9z9DG4w7I/nmLmSythhYgr3IWv8=; b=
	p4GKa/BCH1YLX/CuonP4hccW+HRHLgRxrdGjLUzyunsAkULnj+8J+2BGvovz0njE
	jNxHjeIk7D0WK9YCD3zp15QQhXJrXCKE/tbnYrGii0Z093c2vMYhS5p13fnT/GjJ
	ZMBy4+1OkCOcxCu/vowcUMvniObua4+hGlfFccD1SufvbGiYqIdAHLxC+WC8cSx2
	pNZw37tPHIT8K4Qwb7TySWyRolZXLrZWlqL/KDRpWEtrITnouHCFkbEbwgrBhjTA
	Iii1aFtQqd2ZMU4w8YSHc1wOZZxCrYJnWaRJkr1QfHSaWBML2e3IfRBP/BzSmtCa
	YX4Rc8mJ6y9x5oXa8RzxAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qre01ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 19:21:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1G6AU3039899;
	Sat, 1 Nov 2025 19:21:02 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ngh88j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 19:21:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3cL2yoK05rAZZq/v/L7yf1Ryn5MioTyE7YIMRHWVPIDe03KQXeDj8MITsrcGXa+J+RyoPRX6K6IU6PzTAStmjcwqwWP/dxYYS9aE8NSAvYkVmHx+DkHoDd96ssZfSXncyr6SitQ98aK4BJWRYMOPyp4Fa8iHh3+ReXrp6mUVH5u4REfvAr9YzsYgOJSOiBUu6HNaN+EbknrHlcxeD/KX7e6s1M4MKwGu57BhWDyUS1k9DA0R8pAF8iKz1mt5KBA5QTkT1obOR7wsqS8JzaOPYoPQjdxukq/YfM0y2DsDHEy0vs0uYwr6bgg7RaxYJgE7sZ7N2DRhX6PBHo61imDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+TsWaFKBdOYZHKx9z9DG4w7I/nmLmSythhYgr3IWv8=;
 b=vuu84gq2PqDy2W+c85CxVAQE0wYmynEeBlBlXd3w78O0CRv6RS2LCfJmt/LmPN7VAOOdEVrGgqnaM7vOSzb0KUqcCHkjVV431i6YjvOD5D1onJK+ZrHl234bOmtMhn1tNfIH/q1TeCMBJegEmoVSRP0rmM86XG57QtMZyep+/XhjSaut8WeNLLXHZTMhBPdObaDN/vXpAbGpY/NCfJuUTLHa4yFaidz8u2KldDpqn2iOgXf5qmaJAEwMITvwCUVONKoZpGy2FsRd79urV3FSLqxHZm7OMReR3i4qqMCXPJyrrbXea/iG/ApVHo78vzoh4mHXkbK0rnJpjnsjUPu35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+TsWaFKBdOYZHKx9z9DG4w7I/nmLmSythhYgr3IWv8=;
 b=I+LGD17RdAafDPCi3D+HHIJQRZTXeDt1cJL9qYqYaQp/Y+VXYwLKVGaSS3Wj1hxzgSvKwOyNEeZ9ZdM6kKT5JjEJT2QZwJPd7amFvcWTycbrncEiFYx2b6qVd6Ev3rxWSfYKX/qo7HbNez2GSo7QLGhTooQSfgc7UUR/MECNWCE=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by PH7PR10MB5853.namprd10.prod.outlook.com (2603:10b6:510:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Sat, 1 Nov
 2025 19:20:56 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 19:20:56 +0000
Message-ID: <e3833d27-7f7c-4d03-b047-526c2cb9fa13@oracle.com>
Date: Sun, 2 Nov 2025 00:50:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Print map ID on successful creation
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
 <5f7078cc-dc32-4d7a-888e-922efcba43b6@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <5f7078cc-dc32-4d7a-888e-922efcba43b6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To PH3PPF558EA2A2C.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a2)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|PH7PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: aea8cdda-893a-48f1-97d9-08de197bc788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjdBcDVvNFljcWZUV2lwaXFyNitzRHptWTNoejJkME1vcUoxT0JzNjJERWZH?=
 =?utf-8?B?WHdPSVpRTzhEdWY4ZS9mNGdOSmloRXY1a0pIa3hNSEdSbnNlVlEwYitPTDJS?=
 =?utf-8?B?TWU1L3BYZDlCdlJlZnl5UElqanhJaFNDTHl5MDk5REh6N0oxVVRYTkc0bktv?=
 =?utf-8?B?dFdpWVM0bGNYWU9Ib3BhME4zRk5GRDJ0ZmpWNmVjcHRuV3Z1d3FJQmJPdjIx?=
 =?utf-8?B?YXdKSERWVHJPMnl1ODNLK0tBYTl5WmVtc0M4R3g1bnYxSzV5QkFja1ozK2lw?=
 =?utf-8?B?S1piczNvMU5NQnI1RWhYcW0vL1AvQjlUaU9DUlRPOVdEby92bWQzdE4yOHla?=
 =?utf-8?B?M1RhbnNsUmxtWUlpcG1pSVB2cndQQ1RvY3BBd1hFYk5WOXhpMnR1bndUWG5s?=
 =?utf-8?B?czVGb011Titqb2czNCszcDdraWc0R2Q1NGtGbU9UcjdhUmVXL3F1Mng2NHRN?=
 =?utf-8?B?ZDlOS2EzZEFMR3k5NFJ4K0xaNGJWZStNZDFlVWdJc0kzL0hTZHdqREsrLzFi?=
 =?utf-8?B?ME1KYk42U2ZlVUprK3FSU2FkZDA4NnRBaEVkeTFTQUtQZkNRdnhmN2UyRmNL?=
 =?utf-8?B?WXVGajNtcExwTDllWjArUVh3ZDl0cHZYOWpBRUpaWW5vZGNTMTYxd0ZrRzB6?=
 =?utf-8?B?WUtkUVdLcWhBdEFmaWtxM1FjdFN6QWxLVGFYWmFtOURFb0hPdFEwTFE4WXEw?=
 =?utf-8?B?ODIxYkZKd0dxRzEwVkY1SU4zeWxpZWliclVVdU1vN2FVdUlRbFpOZUNueSto?=
 =?utf-8?B?aHNESTgvNlV3Sm5LcG1ZMm1TdG5xQ05HaHFnUmNXamdQVHc5K3oxM0F1L2FV?=
 =?utf-8?B?TnlyQjV5SjUwVHJ5UGsrd3RIUWRmQ3dOeXhGSlJ6NmNaQkF2NHhBcjc0SWFY?=
 =?utf-8?B?ZTNBeUtIU1N3QXRuRk5YZm5XRWFkaHNrdjEzSGRQQ1VTMEF2QmhqbjFYdU9n?=
 =?utf-8?B?K3BadjJCR0I5UlBFa0srSU1pY0w5SzkxUG1qYmxGVERUSDVDK0hyTDNoeXlJ?=
 =?utf-8?B?V29IVmFSYXF5NjBQS3dSY3c3d0t1dlNBTnVXRHFMTHZvVGpOODNiRHJFZ3Fs?=
 =?utf-8?B?aGhZd0F2Qm9pSmZVU0cySENhSUEweVJFeGhxaEVRRExWbDlBcFZ4ZGtQakJr?=
 =?utf-8?B?U1ZCN21rRVcwNXF1Ui9vaFk3L2l4ajl0NDBzUTN0dm8vbnc2UnFxcnhJS25x?=
 =?utf-8?B?VGcyK2VvTG1hNVo4dHlHMHR0eWJoSVBxNEVPdk1LSDRRTlFhMVM5WTM3dWFU?=
 =?utf-8?B?ZERBQVM4KzV2WXRQMTIvYm4xQlA5OWswMy9QczVJb2RlR3pTc1JEa3ZVT3VM?=
 =?utf-8?B?SjRaVWExYlRIMEw1cE1JYnB4MkdCQS8rMlhVU1pwdjlxUitTQ3hoQ3l2NXc2?=
 =?utf-8?B?ODNjSGxsakEvTThZSktLTVZlS3hYNlBpWDNydlpIWDFMWTdqTHpVWUVVSTF0?=
 =?utf-8?B?UGp4SFp4ZU1DM05SWmsvUVBwNFVDc2VZYXFJTkxydXhrT253NGxyRWhuaHlY?=
 =?utf-8?B?L0hRUm9RbFpYZGpkaS9nWE9VclhneUpRK0xiQ3oxQnhVT0kzcWhHajhwSFdq?=
 =?utf-8?B?WkxnSkRIYlowUFZDYXJYVVk2dUt3aDFBalpOUW5RcU0wR2FDR2t6Q1F6dmha?=
 =?utf-8?B?NERmL3ZIMlU5QnFsTkljcVZma2dNTVBXRTl0S1JWc28rT1A2SlArSEFrZXox?=
 =?utf-8?B?ZXJQaWcwekd2bXo4T2pPeEloUGZaQjRXaGhJTHFWenR6THpQM0c0SlZoNis3?=
 =?utf-8?B?RjllUTNlcWM1TG5oMkNORkRFZWoyVEVEMWpxVkFhSldRd1JlajVVcE0wTXFW?=
 =?utf-8?B?Ujl0cFYzQU5xZGZha2dqdHY5MXg1dzVqUFQxdS85aDY4dldzVFFlMkQ2K2Zj?=
 =?utf-8?B?blNuajh4WHdiNmxqYXVHTWlmbnl0SnZmN0FLanN2Q3Y0cEZHVEhod1hOaGo2?=
 =?utf-8?B?SXBGeHlNaGlRRmZYUDZudlJ0RS9LRFNxMG4xa2h3elJudHExTTNqWEN2UGRC?=
 =?utf-8?B?NnJxcTZWcDVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDZnNmUzQko2c3FNSUw3L2QwMUxlNWhtYVVsTExHVlllYTJmcEtuamJ4d01I?=
 =?utf-8?B?NEFDVHE4c2lHaUE3RGJLc0oxek1VVXUza1Yyb2VLT2EySE4yWFp2QkxPdDgz?=
 =?utf-8?B?MS81cHNuZGR2R2FGSVQxbHhtbHJFUzNzNUdPaGRSdVorRkpYMWxtSnhMeEE0?=
 =?utf-8?B?SThINGlSVDlyckIzNG9GOUFoZlZxcjhUd1haRmZFb2lJQ1JvaEVKZVdVejMr?=
 =?utf-8?B?RnJaWnczbkJDOXl5RGVTdXRTbWVwQXdsdDJ6TFA5ZVMwR2NzbXFreFVSRDFG?=
 =?utf-8?B?aUgzeDFUeE9UZVV2UCtIeTJYRkVpN3p0TXVHZTY5UFYyU3RmUUNqWGJVU1Zk?=
 =?utf-8?B?cjdjMHJ0bkYwYXZBZEhlMkJnMzNBYS9GR3k3YWxlNmwvR2s0LzhrNHdnWjFT?=
 =?utf-8?B?c2pQZmhpQkViTjYyV2Q1K1piQ3kycERXK2pQOGhFSWtaaXJ4TksyNzFzclhY?=
 =?utf-8?B?UkFySGp5dVpxNjRrelFwRFcrWmFhTnllNVJkUzBFdlh3ZkYrYWxyV054RFRU?=
 =?utf-8?B?RUFmRzJoNnJiRmg2VTNSbWpBUnJ5aHNWYjY1TmNXYyt0VFJWMHhKWUZ4SWFU?=
 =?utf-8?B?aHA4R3BYYjZjWTV1QkkxV0o3bjFmeit3ZitIaVo3dXM4WVVzZFJNaWVnSmlP?=
 =?utf-8?B?VDR3Nis3NW1kWDg3NWdPRWJwMk1GWDJLR0dDSVl3WEx1T3dOMHU5NTk5b1pa?=
 =?utf-8?B?MHpMZUVXMDNVOFFHK1YrMktRMDUzdzRaQmFYSjlkZ1h0SlFkMXdVQmRrTG9D?=
 =?utf-8?B?ekNhdUJEYVhUU05wbmFCdWdGT3FObzAyTjRrdVR2YXVnTkI2Y1V2bndxdkc1?=
 =?utf-8?B?bUtremVKdjhNZU1laFptSUJtNkMzRXVZNHV2bFluZEdkY2NnRk83SzV5Z3Fz?=
 =?utf-8?B?OWg3Y0FlZFhTbUwwNnREWkFkQlA5OUV4RkM2ZmhFdDBwd24vMEE3K0MreVQv?=
 =?utf-8?B?cEc5bVIyTnBiaXh2WjdFQ1BScThFZmEwYjg4RlRUZ2lOam1nMkg5ZUxiNDdG?=
 =?utf-8?B?UGpBN1RWdjY3bnIxeUxZdVdjaCsrbnBrRldQRjY0ZTNocGlhckJYTUxSWXM5?=
 =?utf-8?B?WlhHYjVZa25CREZNb3liSU4ydzMzbTlmeFZiNXlpZlJ1dEpvSXcrZThEMnox?=
 =?utf-8?B?aDNXZHpva0FvUmxWTG54cGJWQnVnQi9Qc1pxaUVnMmx4MWtMZ3VYSG5aWUFz?=
 =?utf-8?B?Y05vdXQzNVRoNXEwNFJIVEdORE5wR2RlR2xvVmRWUmcrWTNlUk1MQ2dvRnV5?=
 =?utf-8?B?R0pPNzBDWkNxUUs5WGx4WDR0M3BLZ0NZMEg3TlRsME4wa05ZcmVSOXpHVlZy?=
 =?utf-8?B?V2VQTVhURU9uVjQ4MFYxTXM3MUhkYXcxNDlpOXhIRHlqMkRkdmNVS2g5TTVv?=
 =?utf-8?B?cUltMDExUXhkSkxjVlA3d2FqSVQzaTJEWUpWYUpIWll4YUdKU3NXWVJCRzBk?=
 =?utf-8?B?VmMxcUgxbTc0WVp2aWpVdzQrOEQySTlYSnkwK1M0ckM5Mk1nbWRaNHB3RnFy?=
 =?utf-8?B?QkQ2M0Y4LzZlTjZlaG0wd083R200dkRFb0tJbjRlN1EzUU9LczN4NGZPakhs?=
 =?utf-8?B?Y0VHeWJaRmExaTdWOVJPSjljVVk2UmtSRzE2ZVNSU0VMUUlEaUZ2NmllUG5R?=
 =?utf-8?B?Tkw5NmFmR2pxbjd3dFNVSld5UEI3VjBIWjJkWDRWd0ViZEdxQ2hDYU9mN21T?=
 =?utf-8?B?MExBVTN6U2k1Zlh6VEZ6VU9ENHBTN3Fwa2tyOE1BVEtKL0s2TlNJa1FrM2k1?=
 =?utf-8?B?MWoyOGpRZE83OHRqNTkyT2JGWDlRZHlpNzZWVGtDU1Q4T21RRVI1dUtaRDlR?=
 =?utf-8?B?NHZDZzVDdkl5blpibFk1cVZRSmdoaWVnK0M1YTczeC93bnk2OCtXNTZuSjF4?=
 =?utf-8?B?MlVKM0ZxOUNzWlBZMWM1YXVDUzFiTFhnNmE2dDZPekxuei9rUzJpb3l6Q1pm?=
 =?utf-8?B?eTBPSTFjNm52aHJDN0hMalVGT05WM1l5UHdzbHBpdFdPSHk2YW03QnBFcG0v?=
 =?utf-8?B?aU1TeU1pMHN3SUQ4V3k0bmxzSEhTWmV4WXRCQUR0TGJOeGtVNHJjRXJiVEU3?=
 =?utf-8?B?aWVnM1g4MzVsYWR3aXFWbUZONHl6R3psZ0VLbzU5SlN0ZUFiL3lrRnJYQTUz?=
 =?utf-8?B?L2NINmtKWW9ZbiswWENlQTc4RzBkeUlXYWdTLzhLRlhrdmpWQ0Vqd1FpaEU1?=
 =?utf-8?Q?UqQkwXXhd4H8bOTCcD6MIdw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MBitpmYXJCTXnPc2khRmeKjbuOru8WZOTauioFoLAs06OL6NirGTrBnjdM++OU52mc8JrXUcd8HWR0Ytq7uxLqXlCQmLI8ShokcaJvMoPmPjzUCGKbTVcUkRbp8PbfiEQI3P01Tkr7B0ZYHT/FoUwK8+NL0cyOV6P21oBWuDkvS4KPVIoQ8BuMFYsRmd8AfHfaSQznSKvjif0wbWopb6k+W0F8re+z6BJfvFMgZdIoT0ygtA+zbMn3xB2VtJ/zc95zPatp44m68ZqToIrDYx24oNj1J6NHCG02VuX1bFeidjc/RfRlFLnL1bKBuCULVosQlwMV0whACt3XRBng4X4Q4pHu05E64Ja+5DL82Zby1s7jerVHVF6V/Zvs9kManlB2daa1vHspEG+1RC9R73DGt+nzkiYyZO/i6aZLREg40GRaYmkGnzd91uZ02smMWqt0ViuugilWjGK66ZmH5nAbG4A/wjOTgupNE1HjFiENiZp7VPeCxgoGlGOEi016931OuHzpDH6C0yQE/RGuHLOEwuS6sh9ItEm4abcTf5uF8RqthcaaF5iOJ2dL0fJZgaU0Zvayoj5WgjioKX0ciTLPgF3ctZZ9VpN4Ht4U3sKMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea8cdda-893a-48f1-97d9-08de197bc788
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF558EA2A2C.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 19:20:56.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/xb0w72fuROCP8vAJxnQCkRA0g68ouRXIoODifMQckzMLGqpuqVh9Q9oWsRPb0FFGmoSg8/iyThXPSvHMRaVgJaXDnLZtO9ZzUbxYQ+tst2GXWIK97Je15h5mumFyOS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511010166
X-Proofpoint-ORIG-GUID: GMktq1MT2WFgmtlEUq9C6h6y4okkilYC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE2MSBTYWx0ZWRfX2TyGHuqFpDr+
 d51GoMudu4LnDjECWRLnya7bNTa2qmvsBLrW0Ahu4AMVyLAEEIq+taWGHKwNlVX/x6Z2UHvRRDz
 RjPWe238proegEJHm0OUFGwJp7pU4qibfjmjZcoqzWmHkqvyRPGGS/Urj0EedFVFmRjGE0LexHP
 gBQJoMPM0DiMpzDGfW6QjGtV9JWIOPNWMBjccBnsBES0zXfoB3CnaoBIwa9NnlBKp3Hbip5qjuv
 5+BiLlZIr9SoFY3IB9EsKonxxiEqqS38jtobyHxs2aN7KgjCkJGRFbUQ+AhsSbyn2cQovmM0LMW
 K6JUb06euB8T4SqFo+UrY9BadM5yQkEJv0/Tb8VSktktpoqO/KOd+7oPkoxjvu1M8AVHVpqzlJ1
 hETH1owJR6C7uJy5kgeRUBnu/DQED6gG9c2osTu06+kb0JOanQA=
X-Proofpoint-GUID: GMktq1MT2WFgmtlEUq9C6h6y4okkilYC
X-Authority-Analysis: v=2.4 cv=AMtU3n5w c=1 sm=1 tr=0 ts=69065d9e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=_ZLhF3Yj6cvjBXCJz5IA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12124

Hi Quentin,

On 01/11/25 22:29, Quentin Monnet wrote:
> 2025-10-30 14:06 UTC-0700 ~ Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com>
>> Hi all,
>>
>> I have tried looking at an issue from the bpftool repository:
>> https://github.com/libbpf/bpftool/issues/121 and this RFC tries to add
> 
> 
> This is not longer a RFC :)
> 

Oh, right, I used part of it from my RFC cover letter, sorry about that.

> 
>> that enhancement.
>>
>> Summary: Currently when a map creation is successful there is no message
>> on the terminal, printing IDs on successful creation of maps can help
>> notify the user and can be used in CI/CD.
>>
>> The first patch adds the logic for printing and the second patch adds a
>> simple selftest for the same.
>>
>> The github issue is not fully solved with these two patches, as there
>> are other bpf objects that might need similar additions. Would
>> appreciate any inputs on this.
> 
> 
> What's your question, exactly?
> 
If I understand the issue correctly, the goal is to improve usability
and CI support by printing IDs or other relevant information to the
terminal upon creation of BPF objects, instead of producing no output as
is currently the case. For maps, printing the map ID on creation is
particularly helpful.

In addition to maps, I believe it would be beneficial to print the ID 
when loading a program. I am currently working on implementing this 
enhancement.

Are there any other BPF objects where displaying additional information 
(such as IDs or relevant metadata) on the terminal would be useful?


Thank you!


Regards,
Harshit
  > Thanks,
> Quentin


