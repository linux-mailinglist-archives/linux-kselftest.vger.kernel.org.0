Return-Path: <linux-kselftest+bounces-44609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9502CC28596
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E35F64E1436
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3476529B77E;
	Sat,  1 Nov 2025 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="arqLa78L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i97gX3K3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D41624DF;
	Sat,  1 Nov 2025 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762022829; cv=fail; b=KCGG7un2EkG5TdjUB89pvMDw7DB/pjUyoRsIOlEJpS1wOhSiSEcVBPqwBaOBIs8GbiIXdIPaLpXBHY9FcrH+lVMXh0OcEKaGLLcxrfhhKgD4E0Vf2MipCCj3XTV7qvIRj6e3N0xuAXs2WSjFukaPhHLchluCmAH5/NXRZuzbz8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762022829; c=relaxed/simple;
	bh=8AuXV0dtW66Sh2wm/uYHRHywLXXH++5+ZsmzbxIouKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=csM6Yq9N/aEHtoQfcaW/eQ8XgUOBUxA83CiHbzq7119Xo0hgmt72u6OVmgqp6TJbIeXih65i6v9eRtE7RfXtZCyUnZvi5loO166fbzlNQmh+Ip1ymbkpG+Iwpq+FmKnm2ndV3oTNmdXitJ84pnAEetH7Tj8DL5fHds47hwSJO7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=arqLa78L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i97gX3K3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1IimcS027312;
	Sat, 1 Nov 2025 18:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OhHD/CDp3gVmWkNE0ZkFp5KK7eI89y8F5uSNyPSsl88=; b=
	arqLa78L3g7jsJO4HrZrCZJRXooa/JX9s5bc+JtwM+/klBZnZcawbu/N7z+c7chd
	RuOgPSeaNIYHzHuCn1LIaSHhKx/l8x7Nm6U0TG6GI4gXm5wZeNCTfAZ+vfoE0kXE
	6eoarRvQU8fGZVjZpxTQpzY8v/febIchqGhx+CB2EUyvDtgu4Dj/JJSdKqYzTQJT
	RAun1Tnwx2DtBtgKyTPhNyDuG2ZD1udturzV+sPIe+vubJHVYL/Zq1M6/j0IcOHf
	bgbqr05STI2HKKE8CuX2vA+w0Jet3BvK5Wh56EkgCkfXQwif6BCBqAxMVV0kCpaw
	5freM1kArIJe/96JEexcwg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a5qrer00n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:46:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1GZeNR010221;
	Sat, 1 Nov 2025 18:46:37 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58na8pm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Nov 2025 18:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fY2LCCLVumUQGeGCWLzqEOPqyl+oL1p/tWiGDbpPMm65lFZVwlwrQqe50bUf9OU6eNNH23pubKSU8S38WvVaV73Y0AqsSoMF9H4mtc+D/JdbqzIdm7ql7MJEOEUKMcYYeAathB/IYF6AepuSm4gmgO9QWDo6Vd59+rzqGwNWi51bhdvR8Tl843gJpeE8oaBVqTyPkXw6w15CYu6kHoeOAFgvEWw4GRCFhoVihc3slnFtjsM5kjKnLOraL3NiHZ29CQ4WZowiM8vK9OEyIDc5rPn6scRDPdUYYFwapCjhPi0yt17UgiiY3q44ul6EdpAxfekshBbL2KIBerVN8M8GYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhHD/CDp3gVmWkNE0ZkFp5KK7eI89y8F5uSNyPSsl88=;
 b=dQvqLpyozMcX4mu4rBgaq8JiwpJ1fC2cAC3mA3dePQDqh/xnwglzOaltQv0G8ymFaINKdsmZOmC324jm4V8UUx0jv6xn0fq94RsAXhGWHD8P1NTmq2YAZFK1BEaBTH3yjx2lpwLRgunH/3FFh0Da8llXoCU7Rf+8H52w3Wt2b3/7uQyhzYjSGeqdsHUrHSe5mBMhtYzOc1/pda9ukV/btZHKl/z4e3I1Z9Xp6b1Iy5V8RgBUYaIhmUVqTSkENeos7IyeJLHYYWDm2U7tJSFolPFwqyedKJgofMJfJ+9OPirKf2V6rd1B42y1AbY01ofsL0ZSUkkAtwyFoN8Vndcj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhHD/CDp3gVmWkNE0ZkFp5KK7eI89y8F5uSNyPSsl88=;
 b=i97gX3K3KF82SOFs78gAxUo/CIYfPm1noGZk7HgaTCVVLsC5iDzXYRd41F6sBHkdQ46zPzk4lyY/FNqPep88OF11w2K4S7Xjt5TDh/mU4AwKhytSy6sBJ2zqHK9e/YiPcC+9mT0qbXTULxoiYv3b0bX7NTuUwaSKLpK92w1z+Ts=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 18:46:34 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 18:46:34 +0000
Message-ID: <e029dc37-9e83-471d-b536-b29130013d1e@oracle.com>
Date: Sun, 2 Nov 2025 00:16:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bpftool: Print map ID upon creation and support
 JSON output
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
 <20251030210655.3938262-2-harshit.m.mogalapalli@oracle.com>
 <d9baed0b-c272-4970-8a46-87f12757ee87@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <d9baed0b-c272-4970-8a46-87f12757ee87@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To PH3PPF558EA2A2C.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a2)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|BY5PR10MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: f4806927-671c-43d1-254b-08de1976fa27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ny9tT1gyS0x5YVBBTXBoRmJMNGZsSU9BN2xvREh2MEJDN2VENUZZWFlHZ0cr?=
 =?utf-8?B?eHZOSHoxdTA1MGl5ZjFWQ3YvcWFZSG5HbDZUTVk3T0ZJdjMyeTRuVFJJZ3Y5?=
 =?utf-8?B?TGpVaTNHZVRzejUvTFFhZjc2bmcwWU1rMUVKT0VFZ3p5SVQzbm93N2M2WTZk?=
 =?utf-8?B?MldsQkZWbzF4Mkw5WmVhV0ZRUEt6dmxyeldHbnN0M2dMWnlsVmdBenkzOGJx?=
 =?utf-8?B?bzhidkZ0SGJoSGN2MjRvNDByQ0NYMjFuc1Q5NStLSjUvYzJ6YkhzemNwVXNm?=
 =?utf-8?B?Z1lZaU9PT2NwcllnVnFYT0NTV3hvdG1uUVlXb216ZExPNXVaQWxzbHZCb1gz?=
 =?utf-8?B?eXNqT2lJTUhJaWs5dllYcXBLVTVYZ01aWk1kK2EvazRFczBodWloMjE4MW51?=
 =?utf-8?B?WmVkbStSTVkrQjZrdUlReUFqV1NURFo0ZjVGZUtaalh4STZaRXN5RmFDSDdT?=
 =?utf-8?B?U0NXOW1DK3JaVkdNVGFLK3ViVDJDUkRyTENiaWZzWkVGOVExa2hYclBTajNM?=
 =?utf-8?B?OW9IaU5EaWhQelNhN0NvbXpBRE05d0ZITS9ESDNXVHFETlFSVWtReWFCcUI0?=
 =?utf-8?B?Q3lZd1FObngyWFBLVTMrUmlHTWxrUHRPMUZiNjFtZ25wT21xTkprRlZmcTkr?=
 =?utf-8?B?SHg5YXdxWTdHQzNxVlRUaTJDM2x5NkdJYWZaS1BqVmFtSVo3ZncrbXhTRVZv?=
 =?utf-8?B?MC9lNzJYOUJDbXBYeVJTYnBTV0NwaHVNYXJIVTFoR2h2U3lnWW9EZmVtOEhM?=
 =?utf-8?B?UXdxQkZxUzNQQjhYVGZzRURwdjRidEwwZS9LaVpYQnUwT3ZybTl2UC8vOVdm?=
 =?utf-8?B?clNIVXhKNlF2ZHBDSFRkaVkwUEpWOGIyUEpsdnptbjRPOEljOWQ2dDd4UFB0?=
 =?utf-8?B?UkVLaUNhcHJ3TUNwSUE1ejR1UWhvc0dkN3pybmZwSDArY0xscG80bDlJK2tp?=
 =?utf-8?B?R3ZzSmZqNzBNdytKOEVkbXd1U2ptSU43ejhsR0pOdC9CLzJQK2cyVnNqc1JS?=
 =?utf-8?B?bFBoTkxxVXA5ZndhMUd1Z0Z1aVc5V2F5Tlcwb0V1eWVGRm9OSlJLY3EwOXVL?=
 =?utf-8?B?MU5SblZFSlJpSkJuV0c3NVVKNm5MUEk2ZmpzRTFwdjRYRTZjditrc3B3Yjdo?=
 =?utf-8?B?OHJ5TTk4ODM5ZCsvZmlvdVhyZjBwcm5zWER2c1NWSkp4ZGNVZERoOEl4SWJC?=
 =?utf-8?B?MjR4UjhsNjhBNzhwY1JqUDI0Zlh4V1g3MjNWZWl3WnpJcENkMTVRZm52VDJT?=
 =?utf-8?B?aVk3T2JKNVhNTnhEVzE0M2JacEFGY21STXdEZDA2QkNUMnc2Qzl6ZVdPTi9S?=
 =?utf-8?B?d2Z5d1dwWFVleWgycEFXQWNaeTlwSDVXRW9Tc1BIZ1RLUFUvQUZuWmVPbFBZ?=
 =?utf-8?B?cjIxZk1teTV6a2YzSUh3OHU2REwraGoydUtMMnJMMWxJazZ2ZUxEUVJXK1VE?=
 =?utf-8?B?WGVQUStjRWViYzBHblZZODN2WlBjYXc3dExJa29DVENSQkhsU0JkR0RHdGd5?=
 =?utf-8?B?SDEwTFBQTVZldlhSSzJhLzFlNFAwWDM1eE1HVnhkcm5EejFJVXZTdWdPWk9N?=
 =?utf-8?B?R2hPTVhpRW5wMFR2bUNRVmtxN1ZJcDdWM0ZsZUFBSjJSS0RoMHJYQis0TGx0?=
 =?utf-8?B?NlIzMndQejZiTnI0WUxTaUtEQkFyQzdkUzRvSFI1R2hoQ2t3djFLRjhrMmhH?=
 =?utf-8?B?UWdRR045OWUycVl6VzZxR21YdDNESDZvdWtranJvWVdzUm1ZSEhHd2NQbERJ?=
 =?utf-8?B?MWhLT1BKeUJCdWZ1MStnMityN1kwRllFbVRLbnRXREpqSlZmQ2hkMFhXZmUx?=
 =?utf-8?B?TUVXREVubGpuc3VjeTNQQWNGckg0T3ZkTC9xRGFyc3Vnb3NSNWNOWnk3VXI5?=
 =?utf-8?B?bi9iZWNEQjN2L3FmSFpaUDVVT1I0ckRoVURxcTBXOWY5OWhiWjczRGlUNFd2?=
 =?utf-8?Q?zRSSN6XvEZP0djYi94uM6i559G2EdRuX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y20rRElYSWxwYlVZVVhTZzRyQ2ordjkyUzU1TmlJWnBpSHB6TGFvckZzWFFT?=
 =?utf-8?B?OFZ4OVdEelE2eE9UUGVSckRkcFdSYll1NnlxYjhKZVpLeUJGeGoyc0RtWnE5?=
 =?utf-8?B?RFJNUEhRZk1RTzVPdlpteXNXQ0Z6OG9VQ21CNENLUXI5T1pHakZuT0FEZHVx?=
 =?utf-8?B?dnpuMDNRVVNPZFFHQmZFNk1CSFQ3QjNCMC9rRlhYcmE1S2VqMDdmYmE0K2RQ?=
 =?utf-8?B?REJUTVRsRUlOZnc1NWRpNW94UU85SXQrTFZZYVZYR1pXcGNRTzl5SEU5VGpj?=
 =?utf-8?B?cjVRbEZHLytNa0hDcDBoYTRkR054Tk9KZ2R2T3c5UlY2dHduSlNXclBrVmRv?=
 =?utf-8?B?SFkwa0pLbmZiUVNKRzdBVzdybW5hVXZVOHFveGNmbkd5YUgwRlV2MmtVb1NF?=
 =?utf-8?B?NWpLYkxFL3Z4YitkWVpKQXNOUm1neDQxUzhYV3FFRFR2YlMrWTM3YTlIK2hB?=
 =?utf-8?B?dlNML0lMOU51TU1vNnhoemVrakJ0eEJkTGdaWWZkUGczaUo1aWsrNlFsOVBy?=
 =?utf-8?B?cFBVMXBHTDNqZFBpSyt1R2NJM2V0RDFWZ2FWdWhmUmpDQ3ZzT3hUcE1HZGIz?=
 =?utf-8?B?T2VOWG9Xa3RMZnFLRWVqVm81NmhRNEtqZUdJWG1UNW03UHN3ckl4bkJyc2tw?=
 =?utf-8?B?dERZbkJjUmppVjZGSEpza3VXVVJEWG93SGJ0d05CWkhyYU9HZGZYOUZJVHNh?=
 =?utf-8?B?Y01IWFpxSDYrN3F5eWJUL3JySDIrR0RoZ1kzblJLMUVXT0JQSkhML1dXN09O?=
 =?utf-8?B?WVprc29aWkZ5c2R1K1ZaTmJMb2xzclA1eUZkTHZ5WndJRU5Ec3RJTXVvQVVV?=
 =?utf-8?B?V3U1VkdzRDBMRzZ4UHRiYUE4OXhFU1pnRmJjUXU0K3IyNjJRcnQ5Z2pwL0xU?=
 =?utf-8?B?WjZqL1lzNURPNmlKUi9QTitqRmd2QTRjeWVKa3pCMW9hQnJKNTloQ2pjNjI5?=
 =?utf-8?B?aytSZ2R3cXdxK1dyai81UURlVFlMVXpyckRZdkw3cDd5eDZKSWczdXVDaC9H?=
 =?utf-8?B?anlLWU5EdmxOWmtlVi9pRzRoMTRwekV1TjBLMm9NVUdZTjVSQVJYZy92Nm1E?=
 =?utf-8?B?cGw2ZXBxYjBCeVdXRXlqUUladHA5L1JydmxHYnFlZkd5YU5ESE4zVFRVNTd1?=
 =?utf-8?B?TzZ4azQyYlhBVVdDa2l2YXl6akhpMllNNldMTEo1Uy9DTDJtdlJtcFl2a1J0?=
 =?utf-8?B?alJPOUNKNTQwaFdMUURoVkh2dmx3RVpHREhDRTErKzhWUjJwVjBTckg1OUFW?=
 =?utf-8?B?Y2s2NFVkK28yRkhrWDUzUGY0RXloTzArTjlGcyt2d0tVY1hpWXgzNkN4VGRR?=
 =?utf-8?B?YWZOUzgwekh6cVdnYWNkWlhmTFY5SmRnM0hJZ2VLREJRTSs2YkxZdjArclRk?=
 =?utf-8?B?cjF3M2FXSDV6RjFsY3I1SlpMUER1Z2NKZk5STzdVZllhQ2VCRU1sTzcvUW5N?=
 =?utf-8?B?UVd4L3UvTGhVcGxXTzlEVTQ2VFMxSW5rUTFLMGVaT3cvaENycGF3RXBUWVBC?=
 =?utf-8?B?MzU4ZU9XSGFTRHJXUFQwOE5kSTNOVUlzSmNBQzdZUlJuMThYcmNmTWczSWRM?=
 =?utf-8?B?U1FHU3pyRWpIZjVFeVVwMmk0ekF1SFA2a1QwSnFwdktqNkplcFJ1SlQwYzBG?=
 =?utf-8?B?SC85RE1OMkg4OEMyVktwdldWSVpMek02S2I2V3Z3clE2VDA1amFVaUUycjRI?=
 =?utf-8?B?bW5TUTZkQWd4RTd2VnArQ3RRWk1ZM3gyNFVwUEdIRDNXZWgxak9pRUlidGw5?=
 =?utf-8?B?dlZGdE1tZElkTkxPM1hhME9FVm5TQ1lmSytuQkZSS3JZZHhSSDYwWE9WdU5F?=
 =?utf-8?B?QmNrMUMreVdZQ1J0emtJcVpsL1BPNlJLS0crRjdkZWFxWExnK0h0ZHR3YjBT?=
 =?utf-8?B?TDU4OVg1MnJvUUk1OHNYalNhL01IUkxJS0lEZGQzdnhSRmJHSUJHYkhIZ05U?=
 =?utf-8?B?SFFwZ3JoV2dQeDZXc0tPRWozd0FyYmd1MElTWUxNd041Z3JSNnkzTHNkdlU5?=
 =?utf-8?B?bnp2OW5XV1hNRENEWHJhcUswK1V5SnNtbm9DaVh0RnAyV0E0V3VBZ21OL3Qv?=
 =?utf-8?B?NEhTcmpPeDFydlY4WFpFWWEwSjRmeVN1WlBrMm1OMFg2WWR4SmR4Y0pCNmJj?=
 =?utf-8?B?Yklja1VsNUtzZWV3VGwzcEtaV09tYmJZQkM1QzBWa3VxS1dJd2lUWDU4Rllj?=
 =?utf-8?Q?JlBgGgkEpC1SMoDAu5Lf9Q8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Doq3DKK7NSbI5RkWchS5kyJME6n7lkQXyi/4p9usAfkzwASIIV9bXaeqWlKQiZJDgF3Zek98f9GPBHTH6eIGXPra8GskbXYhXW93e0n+XQP/UOYRbj1eidxUDnH5yj2cW0KoozgMJwD+0WK7xdFmdfZslJTCy0GvEkjbAmkZHfmKrjUadKJFfiQ5yuLP4I592k6yqFKP10T8ikm44bJ04bSGnzTfbj/HsL14YpaT/NpqSgt/hAAd3+AxinHi5hrSP0+2sMq9qoJlwUzZ/DN8pNbLvYADosKvCY1j1F/iwh0EnqJsiZ+comb96frKbR4Y9S0NZP+iv3WmtDj+Xfa6iB33Rw76ambgWYlYOozGNw3K+Rjssr3HIdLUVJblEoPD/7SFaV4/YsdvwwiYWmq3JyFHaMPFexy7T0MsED72erKvRYmM+cqLQIWxPLtFsKgfL6qnzaKTXX4wHzkcVSRAS7kJPQmISBjNzzAODNyBZCyb8ZTBqbwWsuMzieG4GuzVIV0rSGzxeuMq+DGkJ1ynTnTLDbASZLuxEaPZfrFxUyusGHylEORy2SGndh/BaACapTZO4A6DGGmPonyAwpIOu/u3iMYBUXr1tYnkWYe6HG4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4806927-671c-43d1-254b-08de1976fa27
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF558EA2A2C.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 18:46:34.3201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m75gZoDb8NRac8+2SwFqnU5nULr0hKMnJ2Gurc35J9/touKH9cwzuzw5Teuncdwa4QJhI2wUa5juLYbLUjDGj30al8Fgr6sLlrdAh3Ilgl1ug0fKo+YoxltZ6LqPEj+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511010161
X-Proofpoint-GUID: ohnNeBk_v_oxcs7AgbTibAD0O_u1VpUI
X-Authority-Analysis: v=2.4 cv=PPACOPqC c=1 sm=1 tr=0 ts=6906558e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=X6DeloClNAyxm3H0TvcA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: ohnNeBk_v_oxcs7AgbTibAD0O_u1VpUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE2MSBTYWx0ZWRfX8VbkL0YJJkma
 w87Hmg2pYbcK6WULTJslBY26IRtyLQ/oK/QXvI2f1QCqPvVsB28uLtgVQ/1OdvbLnc34Y2ap6cE
 VixK6mdRcZnQsbsuGUOjSJHxN7lGROoVvRT+qFi2HzAApr7e2VKWWgN+LsNlKfufcDcuSwX16Fy
 jrxeXPJIdvoxLdDGZzBcmUPoJnYp7W1tR5JjH816ROWLV80lSbYv2YzwsJkWIyYqimw99Btq/HI
 IYmilN+HFoVjigfDY1RujcwuzoJAJJ+uLa6QDVSHZq7oiZQuBA51/6Igc7w5xJN/DQ2Y6PBtu68
 DatIXZVOeoxevz0x1CASnRhZsiOUi4eLFAf9opuz2iyJlwulvaSTpOz2+xxZoALr6/NIK2qSzWr
 ofW098j9h3AA97H14bxv+maqAT8wu+7+fXAKjAyBEopf00FgWCs=

Hi Quentin,

On 01/11/25 22:29, Quentin Monnet wrote:
> 2025-10-30 14:06 UTC-0700 ~ Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com>
>> It is useful to print map ID on successful creation.
>>
>> JSON case:
>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
>> {"id":12}
>>
>> Generic case:
>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
>> Map successfully created with ID: 15
>>
>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>>   tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>> index c9de44a45778..80c96b33b553 100644
>> --- a/tools/bpf/bpftool/map.c
>> +++ b/tools/bpf/bpftool/map.c
>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>>   	LIBBPF_OPTS(bpf_map_create_opts, attr);
>>   	enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>>   	__u32 key_size = 0, value_size = 0, max_entries = 0;
>> +	struct bpf_map_info map_info = {};
>> +	__u32 map_info_len = sizeof(map_info);
>>   	const char *map_name = NULL;
>>   	const char *pinfile;
>>   	int err = -1, fd;
>> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
>>   	}
>>   
>>   	err = do_pin_fd(fd, pinfile);
>> -	close(fd);
>>   	if (err)
>> -		goto exit;
>> +		goto close_fd;
>>   
>> -	if (json_output)
>> -		jsonw_null(json_wtr);
>> +	err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
>> +	if (err) {
>> +		p_err("Failed to fetch map info: %s\n", strerror(errno));
> 
> 
> Nit: Please remove the line break ('\n') here, p_err() already adds it.
> 

Ah thanks for spotting that, will do.

> 
>> +		goto close_fd;
>> +	}
>>   
>> +	if (json_output) {
>> +		jsonw_start_object(json_wtr);
>> +		jsonw_int_field(json_wtr, "id", map_info.id);
>> +		jsonw_end_object(json_wtr);
> 
> 
> I've been wondering if we should have some parent object like
> '{"map_created": { "id": 15 }}' in case we later add more output, but I
> can't really see a good use case at the moment, I'm probably
> overthinking it... So I'm good with the current output. Thanks for this!
> 

Thanks a lot for the review.

> With the line break removed:
> 

Sure will send a next version with updates to p_err and selftest(to not 
echo messages on success)

> Reviewed-by: Quentin Monnet <qmo@kernel.org>
Regards,
Harshit


