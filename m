Return-Path: <linux-kselftest+bounces-38435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4810FB1D154
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 05:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0120918C7B1E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 03:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A801DE8A4;
	Thu,  7 Aug 2025 03:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J80QOeum";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ep/jA4TA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E13208;
	Thu,  7 Aug 2025 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754538670; cv=fail; b=MPLnhEAgnH+yZVuelsY9Jj+iZh8ZsUP6yJHUy4E3qwkALhxIqWUpeV8xE5iLmu8nbWg/lASJonuIatqLFC4QaMhsjD0+KN9fa/IulRTFWWrcah02hLNnqmkm4dkPACkQOpTVCh3TWijlILbxbnGCstDHzZXkfMsSLvb5klF+kEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754538670; c=relaxed/simple;
	bh=PPn/9VBvqyKL5O0ZJlWl2ifE1r16oJag1yiPhbXrfas=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=B2M9meaORjs2ZKxZaWe6knyKjeIYSLqrQZ1VrlAKGS8DpuAYeJQeLgmZryEMEvG7Lg346DxUFjK9MZycAwZA0iTXcohD4ETPC4P+g/sJpMAQ7y2aIxl1Dt1HdvwUslhT2h1HK8BkeT7ZLey0bAOmlqupezgSY+uGzdi8CvkcYec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J80QOeum; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ep/jA4TA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576KRLSF032662;
	Thu, 7 Aug 2025 03:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=mRlNF2QOz0DT/lqk
	qctW4cb1mPRG0Msci8sYcEmfluo=; b=J80QOeum4M4Ezx7uTRuz9ZO4O1uW2B5J
	w8nZV1qXsAobQIYhrSfgshUPnU9b0kznUF80u1CrAX2LJJVH8ApjoWoEtxWhdAgQ
	tH66PF8u6Thiz9/6DZb5Ccf19Qc0Y6pjmkM54qF7mlJ9+IgHXI1fTvF2jm5VDTDT
	lX7kCQHfwzf/WrNrHnsRhLLaZPfWapt49yP/lxa/MC9S8yMnlQhVyHSNq0nNwMr5
	TYMdrm8YnzWhSToil2jLaxWL3d85GIgTAzC0Cl4AxDeRdWvUOmuuGU8SHU5ZpaVn
	T+7Q4pwoB9QPuHqINgVr3SgqnJnojpquFwQvti6lW99qi5uEjsd1eQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh31fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 03:50:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5771WUxQ027261;
	Thu, 7 Aug 2025 03:50:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwnugp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 03:50:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojV2JNLerHu+jLiZD892mwUn+JRJC+SBv9YM0PggZi6wB1PNY3E4rvjr9ClwGTtxDMm8oBPwSa7PzNc9Rwwkmg8/W0QAzusLr++2kic8+FDnmmyNPeNvkB8km6KzWj3u7jHsURYUnJqu5W0tYXGcAe/mFPAEkMnbmmSVKlA16XGeTqC5l2zaCPRs4Jyy9SKiyTqgZ7ZLFG1NC8O6zdpJvuMUgdIjzT3cEkvKf/SWyP0yrLIPFof4URHMYvhXYcX1xGyceHKkw9neB0bp5R4z+BkUSqrWiOcEbDhfP4u11zdXbI6cTZOOxvOHKeAmbKJiv7FmVhU622jMvcnE0claCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRlNF2QOz0DT/lqkqctW4cb1mPRG0Msci8sYcEmfluo=;
 b=ok1pf3MN0BBsHTur8ZxpH3dxdtapfjL87d5vDv0d5ICOIjb+n5PWEBryeXKTjqEu4m1Y5agKEeg8OaPcReAX7MP3DCqHk9uegwz/ZplowMckyjZwTwHeNf7t+NZFK8Dt0kATdEvI2SxC9k1RydOW4shAsLsk7JGTUq7M5OpAEcVCEtkx1INUoAeLSBP63gMfvlfu7Aaigr2YTLgX6lKi6jXKg8/a+585oTGuKhYt2yYGGwnlwtreIePqYBdb3fCKXpLs4TIsmosIVHpLfrseei/rpIeY5k5m7QCeskzCPDrmHcTU50u4H2fiYiEBlHxTneu2Bv81vhcy14KpF3J2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRlNF2QOz0DT/lqkqctW4cb1mPRG0Msci8sYcEmfluo=;
 b=ep/jA4TAlYRLrbaDXcy6G99fz6ZQClHKPwcnE5uyTcFiYlgxuyS8OD+6tCCTQkatEoPZrFnaGKewwbpQKj1yOArwtDVXr/yMjYQ8JPrISfCjLt5GletebS4WzNEu0ZbIjbXvXcgTJMEu7Wvo12x66pU6p1HHVJkEQ7M83n9sVvI=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 03:50:34 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 03:50:34 +0000
Message-ID: <b1f933f6-545d-4f2e-a006-4e5568656c38@oracle.com>
Date: Thu, 7 Aug 2025 09:20:20 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau
 <martineau@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc: Geliang Tang <geliang@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, mptcp@lists.linux.dev,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Subject: BPF selftest: mptcp subtest failing
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|MN2PR10MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afa9a58-94f9-4050-df11-08ddd5658fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1VMVnZwNTBtZlFLWmVONkRjNC9jeGlWd1c5MlQxS3JMQkJuYTdhd0Q5eHh6?=
 =?utf-8?B?Rmc4bFRubUliazRHNndXTE02VVl3Z3NwZStDRGwwT215YjVHQjlVUUFRdUs2?=
 =?utf-8?B?TUd3OHNKcWUvQkJmNnFnU0poRUY1RkFjdjNhY1hSTXZsZWtqOGlaWGc0K24r?=
 =?utf-8?B?TlFTUDRJajY0T1dnU3p6cG9mRVhwWWEzQnpscU9iMGk0ZndHVk9rMG9XVUt1?=
 =?utf-8?B?RTVhaTZPdmpGeEd2NDNzY3FqN0NsTENodU1CNFQ1VnFGcHFEeTNVWWNmdmZ5?=
 =?utf-8?B?MzBEZlBHYXNDMGVtZE5wbVZ4M3FjUGorK1gzODJiRjhaK0k5ZUl0Q2ozK21r?=
 =?utf-8?B?U25XV3g1NXc2MlUzWFZQVVVYYUVQM215T1FkS2xjV1dhKzI3eGl6N0hNQUVo?=
 =?utf-8?B?REZyQXltS3FNcTcvTkRwVldQeGczQkhWMDhwaVdGZkNicjVacHJlNW4zWDRV?=
 =?utf-8?B?RUlIRU5OcUlPTW1xeWw3V0VoWGJGeXZmaXR1ODRhMDhGUHVDTXFsOFZrR2Y0?=
 =?utf-8?B?LzZKQUxLbWQvWlJDZFVqL1RhQkVQV1lqVkpXaGNleUpVbXlNMFgxWmlaZzZq?=
 =?utf-8?B?RzZ1RStUbVhTbmtUd0RlOFI5R0d4YUhMUDVhR1had0RwOUtGQ0lRYWs1akN3?=
 =?utf-8?B?Y1A3NHNvNnlSRTNUbytwMVpJQWdmNWRkZGV3QTNNUDR3LzVHbkdZV2FZVVhI?=
 =?utf-8?B?MFZmV3ZHcUJRdVpaM2h0SnZtRTJ3aVB1ZlV6RlpYeXJzcU5EaXMyaWtDbzRB?=
 =?utf-8?B?TGtRRk5oVUFpMk9EUGV3M0pKOUNEMldMYnpKSXNlTnNvb3lqWTM3eGkvOGpy?=
 =?utf-8?B?aDBxQ1I0bGNtd1J0RGNQUFR3Z05CLzdGbU91cTFkeE9yTUtjS3psMzdFbGNB?=
 =?utf-8?B?UkJIaTVMbFl5TG0vODhhWUsvaWd4NW8rOW53WlR1QUMvTERwT2RhRktzZWtl?=
 =?utf-8?B?RkJ2TUJwRHlFUml5WHFqZEhqMnlPanNzeVo1VjdnMFJDTGtDQXpNR0NxVVdE?=
 =?utf-8?B?SXRiNUtQRE5jOGdralVDMXlnWExhYVpOSEpQYk45eXlSdmN3VTNzTUxmYkJW?=
 =?utf-8?B?NDVOalNYY0JhOXI3bUF0SFVYdWZZaEM4c2UrQ1RaSUkrazVZMGFyeDRyeTZZ?=
 =?utf-8?B?WjFzaUJxS3lPOEptNzI4QndOTVI2WmlQd1VhakJldlhDOEpla1JjUjQyR1lS?=
 =?utf-8?B?aW45QTZDdVRCa2VTQUZXeS9Ta1RuRlNKQ2gyWmFFellqb0VCZ3BDR1lpMUd3?=
 =?utf-8?B?a3RMb2lTNENyNEhMYVppbjcwTnFteThRWTNUcHRxd0FxL1BkYStheGt2MVF4?=
 =?utf-8?B?QnFUZ0w0WC9tU0VJYWdkNUZZVmFGc0NzWTVHRExVdlVZeUNnYkhpUUM4T3hu?=
 =?utf-8?B?ZXhBTFNsRngxa0ozdW5iNVFpVld5Y29FdzRSWUZ5WDd2Vlg2TExkbVV6Tnlt?=
 =?utf-8?B?Z2c4YmNFMGdMVmVpMW96V3pkTTROWnEzVWx0TUlVTEk2aDFZVGF3MkhWeTUw?=
 =?utf-8?B?eGdQdXNQQjJYSllRSTFjZmE3dG9tdWgvU0phdmJIZ05McVdsUmNaejk3NStE?=
 =?utf-8?B?MHFWOTllalgyenowM3pXQllpaHo0YnBOYmZLZ1QwcDFqRVpRVTM5Q3hwb1Zw?=
 =?utf-8?B?L3IrM25xcjd1dG9CZ2xUeXdLNzkxUW51QUtUNm9lTlZ3dm9zdXJoeHVlUkNw?=
 =?utf-8?B?Z0VzK200SkxFTC9RdStzZ2VOTkE1ZUlHak94em1oVnQzOGU2N3VVN255RDNq?=
 =?utf-8?B?eWVpcnUydU4wV3hmdnBVbk5EclBaYWpydDlYQ0xNbm5pL1lsZEJ4dm13N3N4?=
 =?utf-8?B?TGE1YTY4WjRqaVM4NWVRQ3VGWjk5bEVDQy9jbzliY1o1N2pqcjRMMjVvVzRO?=
 =?utf-8?B?VWxwNHhqK252RDVKYlRZWHRBOXVSeHhKUWlvbktLM3U4Rnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2lvYXoxbXhqUG40TE5NbytNTFNwRkwrZmNHS2FWVzJ0aVpQVzBSMm5lbEVm?=
 =?utf-8?B?Y3NUcldBUjMxdEw5eGJTaFYvd3J3aWtoSFlwdGt1WGI5KzNDUG1WK0JKYTVN?=
 =?utf-8?B?bGNib1FXQkJOTFJXSlFmL24rQ2FoYVpoN2NMYnQ0WEVnSHh5UGtLazZvRzNi?=
 =?utf-8?B?N2w0VGM3Tzc0ekpZMGVUTkpoZUplWU9HQzZFRGpKSkFxQXZkSGlqN01xOGla?=
 =?utf-8?B?VE95MjQ3ZGJIZFpkRjVJRmpVNXA5c1FSK1FTdy9HemZWZFZjUUVQalNlcWow?=
 =?utf-8?B?anNjeS9NYkZwZWJLWk5BdGsxc0hyblhEQURBR3BKaks4dkd1ZUNRUE5pc3VL?=
 =?utf-8?B?WnM0TFFtaEh3S2ZrS3VCczNib0tNd2hPaU1NL2ZxUlFWZkM4b3dLa0Ftc04x?=
 =?utf-8?B?c1NhZlU4Q0d4WWZSZ2srZ3JoVjdMWTBmdmI2ZEJoZFRoMVpZYWZUU2tTTy91?=
 =?utf-8?B?YXpOZzFrR3dNNy9qTkxzUFBPOGh1WVZ3UFptT3NGazB1MUljaVVJYnl2QUxM?=
 =?utf-8?B?TXQyMTV4bGZIZldhdHIyUGxxN2NlVFFRUlJSQTUzZTVPMHVtaGtHNk9IRnJM?=
 =?utf-8?B?Tk5GbWtPazVPeG1sSloxU1hnT09KaXNOR2FSTUNva2Y0Z1NpNENVSFp5L0JZ?=
 =?utf-8?B?ZzVJTnMwaUYrQk05dVVZNldkMENKZ1VCWXdZc0pCVENWMjlYUTlUdVVYMWsy?=
 =?utf-8?B?QmRGVEtSMEdHKzR4TWhZY2c1S0tUbGx0UzhxckhLWXFWUE96ZEFNOUpGVUUx?=
 =?utf-8?B?ZHp3TDkvZ0lWZENNNi82Ui96MXMwZU1NUGpOQ2JYN0t5SEpKU2dNcWdZV3ZR?=
 =?utf-8?B?V2U4bHd5RzdVR055eFhCbVJwSFMvaTM1aE1jR2ovTklpcHAxcmxOWm5iYUg4?=
 =?utf-8?B?THJtaEc1Mmd1L0ZpTjJkMWxXMEhJYWd0SUJScFVSYTFhOVMrVnZIZUhYTmRS?=
 =?utf-8?B?RE80TTdDYjJXcmk1bmpBenJuZmVER2w1V1dQcFB4M1VicXdFKzlSeU1OL2RC?=
 =?utf-8?B?T25TMnlkUzU5djZYQ0VZTjR3WTJuMVJNakF5KzQxOTZTQWFwUC9WekpONWNQ?=
 =?utf-8?B?cWZHNWhnUEEyaUhUNFBBS1ZZQS9mbWNsN1dhVUhJMHRhOURxMjZhV2cvN2dm?=
 =?utf-8?B?ZkNVbkJwcUZLckhJUk52QXNXVEZnc0NOV2ViYTRGVVFxRnhiNXFwWTlnZXEx?=
 =?utf-8?B?N083V21aczhSN0FTNnZ2TER2K1VYWWN6MG9ic0M3cnE1Z3hrSWRjMGYrQksy?=
 =?utf-8?B?dlRvVVlNN00zcHNwUENkWmZjaDZjQnF0VDhmU1kxUWNpVFd5R0RDS0MvamNn?=
 =?utf-8?B?MG5VU2VFNWlTYTFVZnFnb3JCYkxkMHBEUkRCTkZ5ZVM4ck1QeHQzZmQzUUpk?=
 =?utf-8?B?QkMvWC9DcWN2QW9pMS9OeHNvZk8vc29jUEhzcnpXL3FZM0FPSHpzQXBTTGtQ?=
 =?utf-8?B?eTdMUndrSE1jRFdHMUNLc2tlRkxuOUNJWW9vcmNIaThVOFpWejB4OTJwU0ox?=
 =?utf-8?B?K0VwV01oZnJWS0FRNDd2MDF6ekcrc3dEVy8wS0Jua0prblk5enFLWE5sTHc5?=
 =?utf-8?B?M0RrV1pCRndycG5GUWc5ZjhKeVlqM3ZTRWJKaTRqakgzL0JMN1dKN0g3Y0Ru?=
 =?utf-8?B?cit5MUo3OVFHYmFQTVlJV1Z5cFFqcUw5WEsvWXZrQ2o4V1NUNkZDdS9EZGJj?=
 =?utf-8?B?UXB1MXBlL2NsbG90QTlMMlpMblA3RFJuK1dCaTRLNzdLang4RTFrTlZKaTVy?=
 =?utf-8?B?T2wzRzMvQ05pcCtZRk9RN01uUFNnRXVDMzlva2daRm1oUytYSU1yemtlVmdY?=
 =?utf-8?B?UU0zT3pTbGR0UHc2ZTJHV2dheGN1YXJBZk93Si9IMnhkQ1VmOGhiUVRoNlhC?=
 =?utf-8?B?Tm5VRnAvS1dJUk1rRURtdTIwYWtEUVRYZWhDS1lLcHFsZnJEZTVGaEpMbS8v?=
 =?utf-8?B?ZlI2d2wzaGpXZUtsVUs5dU1hbGdjUzVEUmRRTU5VY2NZWEZsdXhLaFZxaXZY?=
 =?utf-8?B?U3VZVmVCWEU3bC96amRic25QSVk3VFFTSHArQ21ydU1uWlFJZjA3L01iQ05X?=
 =?utf-8?B?WHdvVWt4TjZuYlBmL0RUOEFjVmJGUjREam9tN2h5UnBSUGJuaTh0eVZkcGVk?=
 =?utf-8?B?aUR4UFJzcjNkRVI2Y2Fac1BDNExMc0ZOanJ1YjB6Zk5NOGJZMVFWd2NudDVQ?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JJ1aegT08YgDRj1s7sy/FU8OB/gSeIlitLNfdRVc0QH59BahstTjR9eDEwSwcOOla3RchRm0mFdl1JUE8OKkcH6jJxWyqpgwtoej/6mUj50A3qjSqhyaHTKk+h51zlx2HBwznkX/M4fFBAxKQsvXqZCTOr3lJTukBWW0ZPdvIoSQ9d5DpdCtcrM6MiLoEnomzMSFX1nNG3+sz1DWxTlqZC3honSoiUhrL4uldhIzme9hZpYNv+trxxi0BNn4ytOEf3JeXQCEEpDCs7rzSBL9xJi/RU3fp2gG/1GfxSu29vqtHwPyM/MtXJj9EJxByjMAQX9i9ZKe0+1LUCxW4srxXPu2/6YZ+muN7Ijuw8NvVcOJJeC+lkDRAcYkGk3YfwR5FgKwpBSYSWyCmiW2g621qu8JwF/7/XC65wo5zqGfghxi06k1F3HetAhEjtrO+U2D+yKEiVkAEkQCzvobOLb1NfqsVxVpArycwO/Nqvocf0y/MHsH9NfmRMWVqGRTaq1NgwFYov2kMkuUewUgWrAAzyeZ50fIC8+STTCNoM1Ln0uck4uTeZYBKGtoea4BGor1CuT4RDSyD3IQU73Hb4BE2F8uQi3ZoAAxTrtpP6/oMW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afa9a58-94f9-4050-df11-08ddd5658fde
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 03:50:34.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny1Nkv8kRN4m0kbRcniTpgQfkxVpzzZGloMHo3xJofuRZ8M74bFzlASYnQZgBED2KUBJwfL8IzTD92GT1MAL4W3XXfAiuIiFlKXAC4zlXFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070025
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDAyNSBTYWx0ZWRfXwu7+ZO5tqPJY
 E9itx/69qFAupDGU7PpaPh7bUdeA55fpm65+XMVecBRd/JvOjOrBCz0eRIAsVcNDYSmJHwHZDrM
 AHh/3Gzv9UFdPBn9k0Ok/8M3t+DFrtZ/41pejKbC+axBvUoFTR7I1dMjj4ItoIqS7fciOO9sU7o
 TyZj03TGbdl9AMFyfP5/GhbUoluAWVvvQql5Gw23xPzZIbpXwFOVlXCEvuueBaOMrJ/V6JbXV8x
 ksJYKdpX3feGy0UbmZvq4IKYR/99NxrXzqGUpQ94gPK0dm/O2xBqaqjxsDAiOOM6fEKelAMahzZ
 kbwFzVeiB27etZer1YDo4ACc0sU5oWGUYahXdlOh9qAzahgpoLUJ4Qntr8HMPJ73FiFCscZIYXp
 sfLqGzj66dwEnpjr1C6uGdf3OEbnSxOzSeb3Oxx41r4iYQg5m6yBTVU6g4JJKbdkFtUVmmJS
X-Proofpoint-ORIG-GUID: qP-mAKYLDgUx2tF0w0tTMRs9wg-NM8H9
X-Proofpoint-GUID: qP-mAKYLDgUx2tF0w0tTMRs9wg-NM8H9
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6894228e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1n48s6ucHT-fsz7lYfUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

Hi there,
I have explicitly disabled mptpcp by default on my custom kernel and
this seems to be causing the test case to fail. Even after enabling
mtpcp via sysctl command or adding an entry to /etc/sysctl.conf this
fails. I don't think this test should be failing and should account for
cases where mptcp has not been enabled by default?

These are the test logs:

$ sudo tools/testing/selftests/bpf/test_progs -t mptcp
Can't find bpf_testmod.ko kernel module: -2
WARNING! Selftests relying on bpf_testmod.ko will be skipped.

run_test:PASS:bpf_prog_attach 0 nsec
run_test:PASS:connect to fd 0 nsec
verify_tsk:PASS:bpf_map_lookup_elem 0 nsec
verify_tsk:PASS:unexpected invoked count 0 nsec
verify_tsk:PASS:unexpected is_mptcp 0 nsec
test_base:PASS:run_test tcp 0 nsec
(network_helpers.c:107: errno: Protocol not available) Failed to create
server socket
test_base:FAIL:start_mptcp_server unexpected start_mptcp_server: actual
-1 < expected 0
#178/1   mptcp/base:FAIL
test_mptcpify:PASS:test__join_cgroup 0 nsec
create_netns:PASS:ip netns add mptcp_ns 0 nsec
create_netns:PASS:ip -net mptcp_ns link set dev lo up 0 nsec
test_mptcpify:PASS:create_netns 0 nsec
run_mptcpify:PASS:skel_open_load 0 nsec
run_mptcpify:PASS:skel_attach 0 nsec
(network_helpers.c:107: errno: Protocol not available) Failed to create
server socket
run_mptcpify:FAIL:start_server unexpected start_server: actual -1 <
expected 0
test_mptcpify:FAIL:run_mptcpify unexpected error: -5 (errno 92)
#178/2   mptcp/mptcpify:FAIL
#178     mptcp:FAIL

All error logs:
test_base:PASS:test__join_cgroup 0 nsec
create_netns:PASS:ip netns add mptcp_ns 0 nsec
create_netns:PASS:ip -net mptcp_ns link set dev lo up 0 nsec
test_base:PASS:create_netns 0 nsec
test_base:PASS:start_server 0 nsec
run_test:PASS:skel_open_load 0 nsec
run_test:PASS:skel_attach 0 nsec
run_test:PASS:bpf_prog_attach 0 nsec
run_test:PASS:connect to fd 0 nsec
verify_tsk:PASS:bpf_map_lookup_elem 0 nsec
verify_tsk:PASS:unexpected invoked count 0 nsec
verify_tsk:PASS:unexpected is_mptcp 0 nsec
test_base:PASS:run_test tcp 0 nsec
(network_helpers.c:107: errno: Protocol not available) Failed to create
server socket
test_base:FAIL:start_mptcp_server unexpected start_mptcp_server: actual
-1 < expected 0
#178/1   mptcp/base:FAIL
test_mptcpify:PASS:test__join_cgroup 0 nsec
create_netns:PASS:ip netns add mptcp_ns 0 nsec
create_netns:PASS:ip -net mptcp_ns link set dev lo up 0 nsec
test_mptcpify:PASS:create_netns 0 nsec
run_mptcpify:PASS:skel_open_load 0 nsec
run_mptcpify:PASS:skel_attach 0 nsec
(network_helpers.c:107: errno: Protocol not available) Failed to create
server socket
run_mptcpify:FAIL:start_server unexpected start_server: actual -1 <
expected 0
test_mptcpify:FAIL:run_mptcpify unexpected error: -5 (errno 92)
#178/2   mptcp/mptcpify:FAIL
#178     mptcp:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

This is the custom patch I had applied on the LTS v6.12.36 kernel and
tested it:

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index dd595d9b5e50c..bdcc4136e92ef 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -89,7 +89,7 @@ const char *mptcp_get_scheduler(const struct net *net)
 
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
-	pernet->mptcp_enabled = 1;
+	pernet->mptcp_enabled = 0;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
 	pernet->blackhole_timeout = 3600;
 	atomic_set(&pernet->active_disable_times, 0);
--
Thanks & Regards, Harshvardhan


