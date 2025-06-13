Return-Path: <linux-kselftest+bounces-34924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9334AD9311
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 18:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E55917435F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FB3217727;
	Fri, 13 Jun 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lzrKzIOl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vwZi5uNr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171651E8338;
	Fri, 13 Jun 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833157; cv=fail; b=AxtcuftbfLPed0+jJw7d7AtCjxIYLpZEDEJ2xzDgc0CbEc86RMKd5Cmcuw33/uhNJTrWqgn1eFVkgbYHVxTwk0PG2oh7+jXlwE3XFptkSdStZk7PGb78pVuOdrIXHODnQZZ/S+HNl/rwLB8v+0XarjahHhfmLhIahcI3NT69geI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833157; c=relaxed/simple;
	bh=FNHRC+7rZ+OyJx2ZrHdfNPppyp/ubTL0u/rO84+NGPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O6OpsLftbyfwD4LrRo8R3ncrEP8/L83mwfbIfyBPN2+g22Cxu0HAcBBSuzhO9kjCQHcfSa+o3dMR2+DbyeZBjbi+OjkA+beYzVZzHecyziannG+C9RfiSyR25ydAFkibQhU2k96IkSrdJ08dVKwe7PLu2bHLITnuJVOGbZoNfDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lzrKzIOl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vwZi5uNr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtdTg007807;
	Fri, 13 Jun 2025 16:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bnxnS6qOplz552IG78KL/lfc2JkBVkJBBy28GNMm1TA=; b=
	lzrKzIOl0SWqY70HjIDD9tnLtKbAim+vpr/XSz/4As0YFXXRpovgThbovBElPTuJ
	wgE4zpIdIHGvagKqEEASlgUT4Fj1PJZymLDBOWI/f5WFmiJK0egWq2wxhWsAueTV
	LF5TRnn/HEjm4E9PtKJK6xNGiYR12IHxjZPL8chUkFWDuQSZfZeyX70ysDvfq3Ev
	bH9QESubiZ1o3/u+1Ng0ajm82efRFY4Z67egCc3iSa8m0v3SazQxyZH498b+pDz0
	kcGsURhKECwv2sAO1p/RozTZFWyn/YROKM3jYaOEuDXp/5/ieHCnSBlMe2LrF20X
	I2vvsyqtLrhLFJ3LXrAWqA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx41cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 16:45:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DFTBvM040818;
	Fri, 13 Jun 2025 16:45:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bve43q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 16:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4nhUcg9hQ1qgGIil5icKhlj2X9UO0Yaaz8AtIUcIwaldBs4ecwSGVjXJrKw60X4Q+QtwoVC3c5Q7BcKfRFyG0lNgL45bM7Zgo5mRA8cQy9EYcaufFA9C6CiHjDJEqib+HqVRk+ogE4lmnOXC6YYPZpRlbOXofHie/t2JkBDpNvFIpHSKIrd1Z8z9JnA5YOBOSLbd5cZQ6F81SVnmFjZhByzfuc2h/zjzMgNtoKLj1trU6kF+04qBl/0nGpjiGiCckRsHeFwfLG3KCXUoXk6ZkuUuKFymjcy81jIgdxjt0HKrJVCSb37qnZWTU4T8zVqL19lCml7Bu0ctL1VJElBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnxnS6qOplz552IG78KL/lfc2JkBVkJBBy28GNMm1TA=;
 b=SlqZhVIvz9e9Yceh4ei2+68eSVApfm1T/7KDT5bR/zTokg8epnhwBwBBwrR6OzMgS87lZh2ZQf361eDqOpkOQfApO7MbELNerxPXcQJKIIOtN3YqX8ppjhvy02HQpCJyAiiYpOu5H45A8Hsk5gvQNhSu0mfL/mv2f/ioL2T6niXXd/6Ti2OXXuyM8aLNx4Glp2m8v2XtQ/VPfWhHivroY0FqUIUYeF7lQuACur6pVfudfy0EwUn2uqMgI55bS4BC9JHaXWuBQFugsS6OR4pQ71UkixCB92uR9jKh5/UWO74Lo0L9C9vGQdgHzrm9lSBQ058GIqiWDpcNBr28JpEo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnxnS6qOplz552IG78KL/lfc2JkBVkJBBy28GNMm1TA=;
 b=vwZi5uNrdcKjUXIOaRQU+8Ah36JOvoNDk52ruauE4TFdbLNZQyiNu1uoXenZxG/PaRIujXDfYkt/Dj6TKXkHHnOt9nzSnFRXfez+PvW2SXylZc8SB5kF+gFyseOyQgtSgUhpSXCuXtqzqA67Z66r6F8h2+2t2uYm51J1VpsDLBo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ2PR10MB7757.namprd10.prod.outlook.com (2603:10b6:a03:57b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Fri, 13 Jun
 2025 16:45:21 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 16:45:21 +0000
Message-ID: <33d3a830-f5ce-4f7c-98c3-65c842ae6c9d@oracle.com>
Date: Fri, 13 Jun 2025 22:15:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 net-next 4/5] selftests/tc-testing: Add selftests for
 qdisc DualPI2
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
        donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
        dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
        kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        andrew+netdev@lunn.ch, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Victor Nogueira <victor@mojatatu.com>
References: <20250613153725.7983-1-chia-yu.chang@nokia-bell-labs.com>
 <20250613153725.7983-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250613153725.7983-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ2PR10MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 071b1977-5979-4323-b141-08ddaa99af9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkNzMk9ZMmhLeXFBbjhndjhuMHJkTDl5SWF5d24wZENQRVBUT3J1MnhJQ3VW?=
 =?utf-8?B?VW9jd1BRc1JjVGdzeS9HRFFhQmhPWm50OHJUUVB6QkpldGhhRTdEZnl6OUZQ?=
 =?utf-8?B?Q0NpcTVzR3lHdmVqdlI5TjNHWTBKYUVSUHFVYnVZVjBpVmpQNEovdmFZM2pW?=
 =?utf-8?B?Tk1JdHM3dTZZZVgyZjErWWVQVzVrakcySjNQT2RtUTZjK0FXTnIvSWpLZVky?=
 =?utf-8?B?WTdsY1kyeUc5TnVRVU96Ym0rVXV5S2lkRE1nVzlvSi9FNzRvY3RSNFIyR0RR?=
 =?utf-8?B?Szd1V0dXbVZHbDdmK0VOZ2FXUG91MFphT2Nwemp2OW56Z3hTWmdIQThnak9D?=
 =?utf-8?B?d0NxTGFVWWNyZnpYWm1TRjBxWDB2bW1QSU1VVUNiMWs5WUlweG4xMUY3NjZo?=
 =?utf-8?B?cWM0OWhubzR3em1wMVRWTDdoRVVwSGV6UFovYUUwdnIyaklqSTRYalNuVm1P?=
 =?utf-8?B?a2ltQTBpdkg2andiNHZ0K0hha2ZCVExtWHUxVWhtT0NzeFdPZS8zd1I2b2w4?=
 =?utf-8?B?YkxXYzJyYUp5MHNBMzlIcEFueWVIUEk0RTZPa2FKQVJzVUxnNkNTdnltV0gv?=
 =?utf-8?B?S1FWeEk1VWY1a2pBeGZJYThzYzFVeFpsaG10bUh2T3BBcHYvOGFrdXdTMGlu?=
 =?utf-8?B?MHduR1JpdUFMbVhsYUxqTGkxZ3VzTWZGSEd5alhkNFFCYU94S3BqMWhSbXIz?=
 =?utf-8?B?cGo0Z0QraG1VYWNyaTNXTGxnWmU1bjJZYm4xNGplMmJuSSs5dUthSnVJZDRV?=
 =?utf-8?B?RzVkNFJNOTFuZVh4VUI4M3g1aWt1YzdTOGU2RTlJRUJtazJoc09sOThzTDVF?=
 =?utf-8?B?cFRISU02REdXdGR4WWFienU3WVBlaWwzZjh3QUlsWFkrZmwwOERvejVtV28r?=
 =?utf-8?B?Q2hab0FBTCtHYlFNWGJRRFU0QXVDcEhkcDBHcnRHNWo1SlFsamRCSmxGRThp?=
 =?utf-8?B?WW1pY3I5SUt0V0lqUDV0ZVNhbVlzYXBKNExDNzlkdENJd2F1eVpJR05BNjlI?=
 =?utf-8?B?d1dFdVFXeEg5MlpkRk54aDJwMjU1Nm0zWTl2SEUrdU1RNGhIVExzS1pWNlht?=
 =?utf-8?B?d3hBTlVwZjhXMy9uMUFBaE50QjcxN0hzbTZ2Zkppc1FJL1FtVlpLMHluOWFE?=
 =?utf-8?B?UEszVklHTGUwNGRNSGw5aVp2NXl6NXI1TUpOY2VKSnNGQkJlM2dxY2RqdndO?=
 =?utf-8?B?Mmg5WVpmQ1FLcEdDMnU4Z3Q0Q3pFZ015ckpqcGRrdEo0bkhTbW14T2MwMFZZ?=
 =?utf-8?B?U1dqT3dRVkhhc2hzeEhOL0VSc0ZRZzV2eXVrTWIzbEhDVEMrNGt3WHRKVEho?=
 =?utf-8?B?WU5xcDRLQXhZUFh4NHNYSGNRZHdHa1lKcUY1MVU5TTZOM2U1dlFPWWc0aS9V?=
 =?utf-8?B?S2lFRlpJVnpiUWhIWlZOc2ZDdDRyUWZjREZZWnpsQ0NpT3pENndFcWlqVVBH?=
 =?utf-8?B?MHdvNnVIOE9wR05RTWtKZzJvak41RlpRUGo3UWRQK2c2ZUVwY016Rng0Yk5R?=
 =?utf-8?B?c3FzUnhKRlJHRythbmlQSHUvNHM1QlJ0ZVZibUNBdGxrcWxVdUVGSDRVYWxR?=
 =?utf-8?B?bEpEcFJGQUc2aWMwTFFMbkJRdzZpWXAyOUxDVmt0UlMrc2ZadHV2UFpYbisx?=
 =?utf-8?B?VFFzZUE0OWc0TGJHZjNNc0dXYTF3SVhqUmpxNWdWZTNHRG9lNDZkMnN0S0gv?=
 =?utf-8?B?OWxGRkxUV1lTem5odGZHalN6N2F3cUVBaFNWYWdJdEZVbGFWM2o4UjJZUzRK?=
 =?utf-8?B?T3RCb3JldHJ3NU1nK2NJZGx1NEQwS2ZzYmlGSW5lTTZ2MmNRUEVHdjFvcmlQ?=
 =?utf-8?B?VXhvVWNxV0JhejhpTHFabVI3YVBHZ1FZa2k1QjhnNm55azQ3OXUyMTV4Szky?=
 =?utf-8?B?aFgxOHZnQjl2dzA1V2EySEhITi93bFRmY0lWaFE0ME4xamxyck5WeDR5MTVy?=
 =?utf-8?B?NW00VllYSzBGVCt1bDB5Z3pmbTh6dmRkRzhaRGVuSnJxcGV6d1lZVzdMUXV1?=
 =?utf-8?B?ZEhpdmxteTdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDNuZjVJa0VFRkt0czllV0xhbG9RbktONWhwZ2tCU1ZhQzFsdnlncWVOcWdP?=
 =?utf-8?B?ZVhOclhwaTBrcWNOdTIvWEp2eWNDd1liS1lMWnJ1S1F1Ull5ZGJlRGEzZXlQ?=
 =?utf-8?B?Y0F1VkthMGR6b0VmdldaVFM5QjgwWTMrYUIvdmVzVGZZTEdORUhSTm9xa3li?=
 =?utf-8?B?dldGYW5YL0RsbUFrOFFsUWx5czZlZ2hkOUo4aWdLL2FidndiaWdOVERLVDY3?=
 =?utf-8?B?aFFrbG5Famx0Q29POVZOaWg3VXJ1SVNKSVNzMWswSVpZNFB0RkwreHhOWEF1?=
 =?utf-8?B?a0JWeTBabGFmNjFXdHVVbVVWN0VnZGRGdkdEWmJtNGdGbDJReGZHQnFBc3Mr?=
 =?utf-8?B?SXFxWmhMWXk3cnJTU2xsVzhsSDVHdW1HZTRxM0VSQlp2K2hNN2kzSWhSbkwr?=
 =?utf-8?B?OTZnTFd3YkFtbnVQNVB5UnQxMlZyVzN0OVRQeUsrb2QybXNvVlRSdTU5UVR3?=
 =?utf-8?B?TWhGRWpwdk0yZ1BnVHVKMHBublFoUHVJcVB0bTh2Q09pcGQ0TGVmcEVBbXY0?=
 =?utf-8?B?Vit3RmUvcFNqQXJNYWZXSXJXNzhVT1RJVzZQS1FpUVRLQ1VLb3Q2Zkt5MTlj?=
 =?utf-8?B?NVFTZlZYYnZ6ZnpuTGwvL052SC9Edy9SVnlnNDkyR1hTRENTcmdjK3VPRGNr?=
 =?utf-8?B?ZStCVjc0c0dmWjhKNWhTQW42eTFYY3JHSnhNYmpJN0hyclIwbCtEZkpyVlRU?=
 =?utf-8?B?a1plTGdMVER6RjB6eXJkbjJibXhQenNGZ2psNEZHRng5MzIxOFF2dGNPR2Nx?=
 =?utf-8?B?cFc1djZxYm1lUnJqaUFROUdKbERmR0dwaGVIY2dBd1dWVGpXdno1VkVza0Vj?=
 =?utf-8?B?aVQ1aWdMM3ZnTVNJRXlLUE9GdVozSDcyT3J0SXJMOWxId016a0M2YnZhM0dY?=
 =?utf-8?B?YVdVSmZQeVZRTkdya3dZb3FGeVl5Y2lLa05pRlJOaXdjR3g2OFpoSTJQMTdF?=
 =?utf-8?B?VW5zZGZySk51aDR0TDdSdUIvWlh3V3g4OUdiWWlSS3ptQU5xTURpbGN3UlBX?=
 =?utf-8?B?dHJZd2h4S3dTSFllRzFRbTAxWHFhS2ZzT1dxT3Q3ckxFb0JFemhPTHVxT001?=
 =?utf-8?B?aGhPQmRDWHdyUW9kajZ1V0JVQXI3TUdsVGJHS3B5Y3cvcGxvc1ViOFJvODFY?=
 =?utf-8?B?dUNYaS9FQ2MwNFErZlpNWmJ3UGVnMW1wTmMxTTk3L0NBZnRTbGJuREZoRUFK?=
 =?utf-8?B?aXZnVGd3bHpvRkx1UHd4Qy81cEplTWlXVDJEd2hSUlo1bXd0b2xOeVg5ckxP?=
 =?utf-8?B?dzJkcVZEdHBETGVXN09oL0dEWkR2bkwxL25MK3YvcjlQeW9sTHBCbWlTdWJM?=
 =?utf-8?B?bVZnWUdrNDVhSGV5TjY0TzNPQ0ErK09yZWxTMWlqVXNHK0FNMlBwbm0yS0l5?=
 =?utf-8?B?Syt2bnlGS2pkelhaVGovRmRDUFdvblYvelIvWVg3UnNpZVA0b3FEaTUrMGJW?=
 =?utf-8?B?L3o2aDZaMHluc2Z0SkNQRzJ0NlNMYWJmSllDeW1iM1UzUnJuMkNvaVhpSjdN?=
 =?utf-8?B?djVTSVFEcU9rSkJjWVFRTlhsNEl6cmc4OG90VHVkRWVHKzNNZ3FPL1hlZWlQ?=
 =?utf-8?B?VnA2Z3pxNlZSZXNlSXpRZFoyRDg4MkpicWNMclo2UlBCdzhlZDREN3B3SnV4?=
 =?utf-8?B?OCtZUzE5V3A1SVhXQ25JcEcvS08wckhiSE5MQlI1NXdOcmZMeWdrR3F6L3JP?=
 =?utf-8?B?dWpoSGlDTXNzaUxuQ0w5WEUyYUVkNk1TanpNVWtkZVNLQU1HOWFuQXJRK09F?=
 =?utf-8?B?K2xIRERVZjRmOGMweXlPMHNNbFhuU2laNW55YjZ5Ry9RSFVkTzJsQWI4NHM0?=
 =?utf-8?B?bUk0YkhqOEQzVjZoWThCQ1Z5dWJROFpHYjBPcWFRV1FiSlNtWVZRci9vWCtY?=
 =?utf-8?B?Z1IxNHo3NWJHZzRDbjR5b1dNVGdHQWpqdlpZQ3Y4WUNDbmQrTElidjFGSkR0?=
 =?utf-8?B?d2cwd1VCUXh0eEZTb3ZkUUU3RTNpZDBWby9ZeXZ6Nkd1dTdaVmE0NzMxVGwx?=
 =?utf-8?B?elpaRkFDWGp2WWoza2UrVUU2MCtTS000ZmZKZEZQMm8yejJFYnF2cWtPZGp6?=
 =?utf-8?B?S1RNMC9kOEVGRTRiTFlPUmUyNmlJT29sSDU1V2Z3bkh6RWZ1ZVRMcVduTzM1?=
 =?utf-8?Q?e4kD4MK1fsQIDs6txvx+YDSoH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7r5Gwy3CVvumdkuL46ReYWlhqUqiyDDeFYWJiOOCnbAih/wIxtCGiUWMf/+k1KbD3Df7e7pLarsuY7TzVPPuCBrNydglSUjE8Bjdj33ESeg8CSCTa+3AxcpPla/qM94hj4syc3VBDFnX0k3dXWuKXBh01CiGoJAj4Ce562yJ/OOayZ/PRpXwkQiyZmskDCOtF77mTKkqgO4EstjGj13gqnJTPMYfQ8zA+xkCRKssKOuF6f5WYFx4E9w7mnMgrwwYmGIDlFZXx7T5ZLau1DSLxSB/EdRQ9T7buasf0HCkBe0eH/B7z7FNBfaX6jf0CHbEXCNU7SilvpUBPHhM7kH93w2m0R9CKePgesRa4t3ISasQ37GD6ETKCy8M8k/GKtjSZJTubfh/M1knStVR2HOc0h9IIhG4+vNfuVH38evHpJS5KSs8ISzos3ML/3o1Fo7ZE1Pg99hy2LK1MqebD2Ux+k14EL5TmbRmmClKss4IaX/uZ8fKKi9Qs8KA+kw7cvPS2XQrnnEaKjYxsILSIKCD37CTPKwsWL40RYJ6cae7aEZeQlPEMMjn9ZoX1OGti5J7OBcRHf8VAzBgv7MSCAe3fSeC0LDyzJTF5Ci+0mMSqMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071b1977-5979-4323-b141-08ddaa99af9b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 16:45:21.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1tJ6+aZLP2+f05FQp/JZtLE+Fv7Z1rpR6fILEk33jw4RJ33JxzCQmERF4CDir/HV9Qo63zw5+dyWyPVUwM4yUQ/zDaFbNdqirPpQ/CZ0kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130120
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684c55a5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=QRfgzcQfAAAA:8 a=A7XncKjpAAAA:8 a=2U7rkjH4zqESZsM6-tsA:9 a=QEXdDO2ut3YA:10 a=bWi_NY57ueRCZMPDbo1P:22 a=R9rPLQDAdC6-Ub70kJmZ:22
X-Proofpoint-ORIG-GUID: NkiySo3c8VGhre0AS4ylAnwhbnNqL_qw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEyMCBTYWx0ZWRfX1z1+lG82ouwS Gj+RALMYfXIwkLitHw4Oxzv6IaSccGVdA9GjiITnaPTjOSAIJ9UR5GigTieWQ9dP+tD/QGDyMFT /4PwzCHIS68QU5f5nhzNvymUcDstG+6WTfVfO5uR78FfWFtcJbItge7wwm00maSPJz/hWe/6i5A
 s61q1kLCVAmGfA5RDZE1lA73ko3JkLbnbzrB66UP/RvXh8250ouL2xsjHZ2WiQM6lJ0k5SWkRFV y24XTRSriwl/YT/6AnGr1dSo4zS3EMXH1wZHky8ONt70lvG4+n1kklLY/qX0Ny60NBoRwI5mM9y z0fPywPw9kU0eoPiTmQYGzB/OwWhPut7phjshtHnNE6huJtFv80IDwdR6yiGCR5Vmyan7V+KCel
 SRxDnEU5+pLXk62sbwJN+8RtHEa/ITf7oj2DR2y8kFRsmR2WVD67c5/JxyPITJ96/mIvb/iB
X-Proofpoint-GUID: NkiySo3c8VGhre0AS4ylAnwhbnNqL_qw



On 13-06-2025 21:07, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang<chia-yu.chang@nokia-bell-labs.com>
> 
> Update configuration of tc-tests and preload DualPI2 module for self-tests,
> and add folloiwng self-test cases for DualPI2:

folloiwng -> following

> 
>    Test a4c7: Create DualPI2 with default setting
>    Test 1ea4: Create DualPI2 with memlimit
>    Test 2130: Create DualPI2 with typical_rtt and max_rtt
>    Test 90c1: Create DualPI2 with max_rtt
>    Test 7b3c: Create DualPI2 with any_ect option
>    Test 49a3: Create DualPI2 with overflow option
>    Test d0a1: Create DualPI2 with drop_enqueue option
>    Test f051: Create DualPI2 with no_split_gso option
>    Test 456b: Create DualPI2 with packet step_thresh
>    Test 610c: Create DualPI2 with packet min_qlen_step
>    Test b4f6: Create DualPI2 with packet coupling_factor

typo in b4f6 or json file using  "id": "b4fa",

>    Test 37f1: Create DualPI2 with packet classic_protection
> 
> Signed-off-by: Chia-Yu Chang<chia-yu.chang@nokia-bell-labs.com>
> Reviewed-by: Victor Nogueira<victor@mojatatu.com>


Thanks,
Alok

