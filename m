Return-Path: <linux-kselftest+bounces-13466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D118792D3C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 16:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C08D1F22267
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B21946C7;
	Wed, 10 Jul 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AZ91Ri9c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pshf30xw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B951946C3;
	Wed, 10 Jul 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620163; cv=fail; b=MBxMFcCaIOVmm+PBnck97Q7JglfCRkFPsWb5Xxc0jSn202hBmvXmP3No7CptwzGAeBi+4gTHiXjPefSmGeM+tEwfk8CUOtUtAKAJ6MRG1oqFJVx4YfbB5Rr+I0fXkl0TJ7KruX9oFeM+z/uXqIzxLnUulEYZi3rc0ZYnlhn/Z8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620163; c=relaxed/simple;
	bh=I7WW5/bEx059SpBk4AfbAKguYCeyyWSJIkqp3pcanU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ls+uy1hV2Ha4nOwfqj0XDzrviXudJaIbDbLUdlUSi5YqUd2CZs7MZjjgsizEaaK9g1lA+WggVutrRRrOOlp4SnEpq44IYMHq5p2GtB0WgfnHeusc5zOraS04elFkOgxEjLnoOPUvnruYcww8bzurZTYrq7/ShXY6BJVJiSBjH9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AZ91Ri9c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pshf30xw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fSx2012005;
	Wed, 10 Jul 2024 14:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=JxTsB3LeeAkWsrm8yVDULc1qh9ia92OYjm5EYMlmo1E=; b=
	AZ91Ri9cdYePAnKd66Xua/2rHsvBn+43EOXOQrrveXFim+QktnFCEKqOLyLhiyWd
	9UD0r7zPNfoENJCFgawOMHCIZv5wcopOc06xOe9Tf1sJvWggTIno7MVoNGKxE5/M
	YmnjIPFnxFApkRhQzeXHR3pkJYMNn3wvxOFMsmi6GoNCKSYARzLYIPF1+edivd+G
	INRVUEgSzv7rvRUSCpi1zV9dPNEsIBhyfHvOrESLGH+oi0s5baE+tPUjtGS/H+RK
	ap8M1gzRtw05z9F/zKKk2yyZGIIjQ/U2gw1HDCyVfBZTglvVzUxQnjC/mqRLug4l
	Mj6J8jcJrdtOjYo+JknPvA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcfae2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 14:01:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46ACg0vR007764;
	Wed, 10 Jul 2024 14:01:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu4tfby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 14:01:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY9oQa3oQcSzqp1les47dN+/oJF3vIZsJQqMfuvY5ldnN/2C6AScPm3UUT6f+pyLRJQ/JCcKZXWX6BjukX++bOCkBYQYDPY2NFDgyUOr3k+t1LeGg9LREOgiI4otur+KLk4+1THjb260seWmMcg3JrfYaIfeR1/VXtUlaDpNiP0DlxJhBWTvnpNcVaFgAog27x+UNPpbVCt5goJnxJLCRtXHRn/JMIK9sDjiIDEUKUoDbewcqdtCl7lDPaPMLGSEJW/QTOsEUbFvty06xoESqq3BChQFKskdNQ301t5TyxASxfUYq/O7q0kAbKuKjLhi2pMmcqTS05BsA202tXWg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxTsB3LeeAkWsrm8yVDULc1qh9ia92OYjm5EYMlmo1E=;
 b=izi4AINT/y2FQVZzlQwwgT5OCgZdaMyxEPqhJr48DpjIJarAUzRYp2YHwxfk9ts9ux5QMrCfNGrEMAEeyfoK/fRCrgyrEvvT3pR8hP+Mj8kiYq3EbLOaVKZYtXCJCFvkaPyHrYLF2+gL4xI07hOZTBiAM3BoKZIuJsx852uzCFtYR7Au04vLewcwOuYtPh0Ur+y2qQB2mHGzqXsQ46rzEKIB8aZCFbnKglceevFdk27ulWJhT1s7N3xABiC96oVnhrNIys9rnM8yP93HacczKveuwzoYRU5CofZSjjbNr0ekfUceSvwgLzOO5NFF0U+4svx1teUE8xnSjimnX11c9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxTsB3LeeAkWsrm8yVDULc1qh9ia92OYjm5EYMlmo1E=;
 b=Pshf30xwYCE3af6zsHNpW0uu1ZKlAkQ6WdnGy2bG0W3CeZe+SEUMbWvotu8MzE1zcFvSnT0jaQLX8deRbonvbt1MvGcr1T20WP4hwL4gPsSuvUrUYFfrrDpyQ/trWRs0P/8/H29BY2JhBZPWDuSu2q7BIkpTZAj98gNWFh84QHE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB4918.namprd10.prod.outlook.com (2603:10b6:408:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 14:01:11 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 14:01:11 +0000
Message-ID: <1499773d-6560-4af9-9927-aa0c94cb9677@oracle.com>
Date: Wed, 10 Jul 2024 15:01:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Check ASSERT_OK(err) in
 dummy_st_ops
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
 <21fbc0db764656805340085ef2a77c8a770ef1d0.1720521482.git.tanggeliang@kylinos.cn>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <21fbc0db764656805340085ef2a77c8a770ef1d0.1720521482.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0148.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BN0PR10MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: d54fb242-1398-4d04-604e-08dca0e8c0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TTBvaXZHZm1HSUgwM0JJd2ZoVFlVQXZVVTgxTE1WZnIya3UzWmxWRnpCejYy?=
 =?utf-8?B?TjA1RVY1M2ZHRjRmT2tGVGZOUlZ1SksvM3owTklPSzRTT0ZvRUdyOG4wcE9k?=
 =?utf-8?B?UjZDTnFteVMxOGthRE1XN0pTcEJZZzJGVktjRzlhdGxDYUlKMXdYU2lhS2w5?=
 =?utf-8?B?VjhuUzVJbng2cm5oTHljM1g2eXJ0OERzTXRHWFEwb2N0MGxBNWdEMW1GNUQv?=
 =?utf-8?B?R2svVTFVVU1URFBvREhSenNzNGVLTlFUQlVqZDhhODh6Y3hQREdXeC9BK2w4?=
 =?utf-8?B?MEZsdTZtdlF2d0x3S0JxeUJ0NXZVT2srbkRPZW9WR0FWZ0puZWR6eFhkTHlB?=
 =?utf-8?B?a2ZRbTZhT1AxMEJLNFVFdWd6TG9vNWZPOXZ2WTVwd21oa3RiTFBaOUs1UlVq?=
 =?utf-8?B?OW9jOG5RNVlRZExyS0o5MGYyd2ZrMVhZdDhuaFFHNzJuRXhKblhITVBRZGox?=
 =?utf-8?B?L2dwajlrRk1WKzRjUGYycDRVd2d2WUpDaDd2Nm1XR2s5OGNXRTE0R2lESzZO?=
 =?utf-8?B?UFlpV1AzTGJPUWZyRTBVcjJPWVo5c1FlRDJOcXRkN3FHMVUxVUNuYmJrNndQ?=
 =?utf-8?B?bDhPNU1YUWs0Z2xxVHBLcDFsM2ZiVldNNUVKTm9nelF4aGhXaE5xR1IvcFZJ?=
 =?utf-8?B?d1dpSEwxcS9xQkV5M2J0U2dFZVUvSExHekxINXErc2ZKTkVvSXk3b3pBMHlO?=
 =?utf-8?B?OVpEUVBwYUg2N3QvZzRtaVBHaDBGdmdhTnh0dXRybUVPQ1V0S2txQ3pWQWFO?=
 =?utf-8?B?bUpVdWJIV0wxYWkwR2NxNEsyLzJjcEtzZGNOUm45ZERTYmFGalo4V0N2eHdx?=
 =?utf-8?B?aFQvN213QTFYNm5RNDF3L1VPbnlvaEJXbkw1Vzgwb2tGYnhJd290WWZOSldq?=
 =?utf-8?B?SFdVMDBQajR5eVFsOHNwVkNSb1ZnR1ZyM3FVQ1FSZ0Zwdis5U3NienZPZFow?=
 =?utf-8?B?UEFVUEJqZlpiMTEra0QwbHlSK2RCaEsvUkNBM0lZZ1hqamxicG5COHVWcFZn?=
 =?utf-8?B?RnNwbWRSMGRqbERIZUI3bm5rUmp2ejRBMGhjZWUzNEtJbHZUb2w3UGZTaU5B?=
 =?utf-8?B?TkVhQmlGb0gxNnYzQnFITkZyTTVtQnAwUnZCaHBDTllmUmdKcmkrVjEvTUVX?=
 =?utf-8?B?R1ZINlQ5b0NCaVpHMmJVM241cmVMTVRZc0hOOGlQQk1SU0tVTGhCNG5wSDZZ?=
 =?utf-8?B?TWlDaDFZVHc4VE1DRk96bks5TGt2dlhYWmJUUUtiTUxodkVBTmJGVzVSSlRJ?=
 =?utf-8?B?U0Rwc1Y3cDBVcGgzMjlTQjRxZzN4RFRVNmNhWmtXTk40S1hjTWt6aWJLTUhi?=
 =?utf-8?B?ck5NSEUrKzlYV0JjdUpqSXl2S3Q0cndYMzdHUWNKNGk3Y1FKWktDZWgvWTky?=
 =?utf-8?B?OW9wRUV0a0piWmtwZFh2bnhZU3liNjBMOHhybFlkRWsrWnJweVBwZFFKcWda?=
 =?utf-8?B?OXkxVTZJcHh5U2VZZ2FXZGJTb3FzalVWYm1UeExtY0tZbTdXWThqOXV6UkRK?=
 =?utf-8?B?MWJLUHRIQVNLWVYvRXd5KzMxRGZtQThsU0hTMmJaRWF0Ui9KbC9MOVBIejFT?=
 =?utf-8?B?eTRWNzBsOWdta29ZRVRuY04xMDFWUmpHYjRjRzlZVHFxQnU4RUhZRlZlaElP?=
 =?utf-8?B?VW51azNJWDNiSE1pV1NBZHdTVFVPOG9ET3NOMXhndU5kMlJ0bWF0NktXcWxv?=
 =?utf-8?B?d1Zad2MvY1dabVVMeUo5NjZVNGs4bnZXblI2ZXhQK2lrUmRVYm5XTVlGUG4w?=
 =?utf-8?B?cUdMN1ZqMGZiVFVNQmpSWmloZm1tV0ZhN2ZOQ3pCd2F2ZldXc2JZaVA0RGxo?=
 =?utf-8?B?T0ZJRVNWdWJwTnBubExxaCtSeHVzS0IvSmhkdjg1N2R1cGczaDZtbGdQRC94?=
 =?utf-8?Q?yAQZmEfZHsny9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekFJTkRuVWQ1OHlUcGhRWGFkYXY2cFhIWXk2Smx1cTByZm5ib3R5djk4ZkZB?=
 =?utf-8?B?SEhNaFRvT3lvNE5uOXljQ2NrRVVETk13RjBCUkE5NEpFZ1NkeU4yWTYzSzk5?=
 =?utf-8?B?Rzl2S3N2cjFkOVBBVmVBODR6R3JRSzNjbm83TkMwZTV2K2s2U0NoenRpNzBI?=
 =?utf-8?B?WjkwUmVrNnlKSVdjbTFEVWNvdXNIQUNpU3Rvazh0L0lIMjcyVVdKY01RZ210?=
 =?utf-8?B?N0dxL09pWi8zQ1VpZ09mUkRzTWR5alQvcmlVZjB2VmhvdW05YkxFdFBIM2Zs?=
 =?utf-8?B?NVBOWnJlaDhRbXJMOHJnVEY0bmxBREE4VTd6a3Q2eitlc0dvVk9NYis1ZFFV?=
 =?utf-8?B?WUVxdStreE90eXl2M2x3SXZhQmFHelJrUkNRMjlZOFhRTDNwaFJncW40SkRN?=
 =?utf-8?B?ZXlTTkh5TFJQZlg1RmZtZUZQL2dyTE9aVmFwNS9wN1NUYVM3UEI2TGFBY1NX?=
 =?utf-8?B?VmJmOWhtWWlOOW9lTlV4bjJ4RURZM1A1M29XR2pqMlcxTzFzMjBtN3hzL1Bn?=
 =?utf-8?B?NWRydDVzVk1qVm5SRGVLKzREYms1cHZya0lXeHczVmQrc25ncFdzNXFyaml3?=
 =?utf-8?B?U0RFNWgweG9NcnVxZXNWbm8vYnE4dlNpUm5rK3ZOWU4zZ1BDcUlGdWdJU29I?=
 =?utf-8?B?VnlXRnN3eVRFSCtod3ZJa0FzeWNoSXJlMWtjRUEyWnZ3SGxZMitWY3BtN0dE?=
 =?utf-8?B?U2M4MFpualkrMUt5WS9ERlhkWkU5Nk5mLzNyWjJKdW4rYXR1NFBNbFFDSUpr?=
 =?utf-8?B?dlJDWCtiNWdQT3JxV29vdEVSa3dlZFJoL1NiOHBGclBQSFVyamVsODV1cW9P?=
 =?utf-8?B?cm5sMU1KdURIUlJrTENuT2dYUDZJWnZ4ZkIxdzNvQ2h6dktRcFNJVU5hWTFk?=
 =?utf-8?B?cjFpU2pZVTUwNGtsN0dpOTYxNE91N1ZROHY2VHJrc1dWVXFKVkZMQlNaUHhT?=
 =?utf-8?B?dS9qTkJkZEpQd0I0S3FSNmdraW9OS3Z3Y2xYL2lJZTkvbXZNK1lURlAwY0dR?=
 =?utf-8?B?VGl5Wm5SWjh3V2IrTU9aSmd3RVNyQzFhb0tXOCtnV2xjY2tzMG1yb3VZQTQ5?=
 =?utf-8?B?Zk03RXpPL1JYWXV0Q1BwMXEvZWZQOUwxSFVOc2ZCNEtBRkNxdkt1SnRSb1FW?=
 =?utf-8?B?ZGFNSnhDWGQrYU4vc1NUc1k4Z2xxNWRXcVNQaGZKVDRaNDhXMFYwY0RIZFBn?=
 =?utf-8?B?QWhONzhkUGhiZ2ZqOGtjZUZZS0V0TVdPcVZYRTZxZ0hlTTdONURUSTBwQ21E?=
 =?utf-8?B?Z3hVNWZLdWhVZ1BSZlA1SzMxNGFGTk1hRVQ2RkM0ZGU5T21KMFpsRDZPbUpQ?=
 =?utf-8?B?aGpTNUcvaExzNDVRUDFaclJjR0VIUWMvSmFPejF2TUJiTzQ2QjdBVlRQRmNK?=
 =?utf-8?B?NTd1N0NiVGZVQWkvZWthRzEvbnplOGU3RGlqUXJLSXMyOXNwZElwcmgwek55?=
 =?utf-8?B?VFZMOVdnR1pKQmhWMmcwb1IvOG1Ga0FvMlQrYjYzK0h5NkdVYUpreGpaVjFt?=
 =?utf-8?B?Qm9QUnJETzl3OUNmdXhLS0VUaSt3czVQSEs1bjMxSHFUTm4xV0RyTU1KK2NP?=
 =?utf-8?B?OU9FMHV2L1ZXbFZRWFhmVGtuQzhUczlkYlhYUkx3NjlIY01WNkVlYWY0dWFq?=
 =?utf-8?B?ZUtORzhId2J2WGJpK09LOVJGQ3BrNDloV0NxeHVrd1dLdXVhbjNhbEt6cTM2?=
 =?utf-8?B?eDR4eG5OSHJ6MjJ1c1RtQmwrS1hIbmdnS3ZEVXdEKzBGU0syQmRGYm1ObjY1?=
 =?utf-8?B?SVJRZnZDblZWbnFiL2JqQ1FrZXExNU12WDZyVEZqcTVYaEtYNjJWWW56aW9h?=
 =?utf-8?B?SWM5MjJ3c0FSc1NPMXJqQ1VkcnNVbit5c0ZHZXphU0hxSkY2ZitVTVBUUzhh?=
 =?utf-8?B?cHM2NWNZZy95UDR4NXF1QkVpQTRHczIvNExTd2s5eFJGUm8yNHFzVm0vVnpR?=
 =?utf-8?B?K0krT1RLQXZKNnlGL3RHcE1XcnVGZnFqMVM1Nno0M0ljTkRMd1ZyV3AzS3Jy?=
 =?utf-8?B?bnNxR29TWGR1emhXT2crRnhrelQ5cHNVS0tPU0lyRzZOUjQ2SW1NcGdob3I2?=
 =?utf-8?B?SVM2SHdEM1NzVVM4dHBSNW9ZVnlhUlJGUTBzOFoyQktjQmNHWXFDK1ZxVTdH?=
 =?utf-8?B?SURqYTA2b0xFQU4zN085T204anU1dzkzQ3A5S2hKTUErRm03ZDN5VU9JODAy?=
 =?utf-8?Q?Epmmy4OBC1XNonv1LpDyPUc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mbuyh8ouWcBTsYfdlfIbKeLxK8pLfC5X0Ulkn8JliRKywkzOB8Em6BjPMJk7u6yWJ1wlHCBtuyoWMp0jdt5q6aYKNDcioaTSaTX47J1S7bYByOQqMQpShVxh5l6CSwZCVRlqMTo4XBXD/mk1cTiPu+MJAItK1ghwVMhgBrZ5pKbwqLyEo6OzC0s+nYWv+/avBJVPWjNU9RZ4miuTqVpHt0g7qgU7jPyjwOK8LzkX8kIQNEjZhYvacvGlM6ZeLwKO7dfdiiDb3ECQ6rWH8ZdTj2fCqfbdPWvvW/KELi9ZD3Y/xNoTjhNCsSteVHi67chjXJsM6XCWDsqsdlgEjbJXcrbFVnlJwYxrKyKsVxS5tZdoMISLBqEhw2xyM2tV6p88gIIJlLetxbrj4DywB9ATjRt3ZAuXJ1kOFaJL03XpGlJqayMWL7jx8d9sSsF/hwI89XxRcXqv5YenFR2298R+gNJHyU4URa8/pwostvDEfF5MJZ9xP6OmCGyMfExBwbI63LngLxP8fdjoNUl+pAQErjA3gxDg+UWTPaR0XMUHKvIKbF6rmnhhCSBznwRR59DKETSqBSaz/nHfs537KRJbMEZaXwQQxsgWlitz52urJtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54fb242-1398-4d04-604e-08dca0e8c0ee
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:01:11.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +86pUT8TjftDOplB5cLrMJgXQe/+tdZRo80JmmhnCxGjwT83QAG3rZ5UF7yz+k92vuhkND/Bfn3cgaloTMXNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_09,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407100098
X-Proofpoint-ORIG-GUID: BlVZceekJxN6Wm7kZo1pz3jd-C-vid-_
X-Proofpoint-GUID: BlVZceekJxN6Wm7kZo1pz3jd-C-vid-_

On 09/07/2024 11:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Run dummy_st_ops selftests (./test_progs -t dummy_st_ops) on a Loongarch
> platform, some "unexpected arg" errors occur:
> 
> '''
>  #78/1    dummy_st_ops/dummy_st_ops_attach:OK
>  test_dummy_init_ret_value:FAIL:test_ret unexpected test_ret: \
> 				actual 0 != expected 4076074229
>  #78/2    dummy_st_ops/dummy_init_ret_value:FAIL
>  #78/3    dummy_st_ops/dummy_init_ptr_arg:SKIP
>  test_dummy_multiple_args:FAIL:arg 0 unexpected arg 0: \
> 				actual 0 != expected 7
>  test_dummy_multiple_args:FAIL:arg 1 unexpected arg 1: \
> 				actual 0 != expected -100
>  test_dummy_multiple_args:FAIL:arg 2 unexpected arg 2: \
> 				actual 0 != expected 35423
>  test_dummy_multiple_args:FAIL:arg 3 unexpected arg 3: \
> 				actual 0 != expected 99
>  test_dummy_multiple_args:FAIL:arg 4 unexpected arg 4: \
> 				actual 0 != expected 1311768467139281697
>  #78/4    dummy_st_ops/dummy_multiple_args:FAIL
>  #78/5    dummy_st_ops/dummy_sleepable:SKIP
>  #78/6    dummy_st_ops/dummy_sleepable_reject_null:OK
>  #78/7    dummy_st_ops/test_unsupported_field_sleepable:OK
>  #78      dummy_st_ops:FAIL
> '''
> 
> This is because BPF trampoline is not implemented on Loongarch yet,
> bpf_prog_test_run_opts() returns ENOTSUPP.
> 
> This patch checks the return values of bpf_prog_test_run_opts() in
> dummy_st_ops to fix these errors. If error returned, goto the newly
> added label "out" to destroy the skel.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Verified the test still passes on x86_64 too, so feel free to add

Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
> index d3d94596ab79..a208801f524f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
> @@ -41,9 +41,11 @@ static void test_dummy_init_ret_value(void)
>  
>  	fd = bpf_program__fd(skel->progs.test_1);
>  	err = bpf_prog_test_run_opts(fd, &attr);
> -	ASSERT_OK(err, "test_run");
> +	if (!ASSERT_OK(err, "test_run"))
> +		goto out;
>  	ASSERT_EQ(attr.retval, 0xf2f3f4f5, "test_ret");
>  
> +out:
>  	dummy_st_ops_success__destroy(skel);
>  }
>  
> @@ -115,13 +117,15 @@ static void test_dummy_multiple_args(void)
>  
>  	fd = bpf_program__fd(skel->progs.test_2);
>  	err = bpf_prog_test_run_opts(fd, &attr);
> -	ASSERT_OK(err, "test_run");
> +	if (!ASSERT_OK(err, "test_run"))
> +		goto out;
>  	args[0] = 7;
>  	for (i = 0; i < ARRAY_SIZE(args); i++) {
>  		snprintf(name, sizeof(name), "arg %zu", i);
>  		ASSERT_EQ(skel->bss->test_2_args[i], args[i], name);
>  	}
>  
> +out:
>  	dummy_st_ops_success__destroy(skel);
>  }
>  

