Return-Path: <linux-kselftest+bounces-14845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80632948F03
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28DA1F21A5A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011D1C37AA;
	Tue,  6 Aug 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KLgMPQUA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dLFwuHMs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F01C3780;
	Tue,  6 Aug 2024 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947248; cv=fail; b=p9igxZLWJS8OCDDGFcENPchA1OHjKcQqZvutjKPKKgLfGZ5+cqq6DsXrG5nQyec5Z3bZqboqJuXLWPAzjy9P1o1L6+KHXmw3t0LezO9DJQenLOEeY8Gm3OonGOBtlERf2hX6K7COaqBWq+OyHhU9Ux3Tj61RVP15GUqaa75EmEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947248; c=relaxed/simple;
	bh=ztLjgn98nSHYopDM64ed7DJFYjfRMjKhfu2cnZ4gdxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wzf3I3jGdY5u6l1sejbI0zuQshyqnvc0aBlFyxWA1fD7y548arfRaeP5c7ry0mb6SMnYawpFwlwTXiQU6RIeljE+V8h/nxoethYuZEP8EmsMKH1YO9gmoqYvHp9T5Fgt9bvQREY6hBiI4byGfBZ3XhkHt25tgP1E8XkdPLZ5+tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KLgMPQUA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dLFwuHMs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765l8Le031383;
	Tue, 6 Aug 2024 12:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=1Kc89S1q6J7d/TsKxyG2WxWSSNwpE6ARQqpq46SUIA8=; b=
	KLgMPQUAFm9+5YcntxSTwXmFfV1CU/bcZ4/hocPnsklAauf58UBjfLiq2FgzaocW
	jK0yYzdxoGTBCQ2I2GDeCKw4K+jnhVgITPpGI7AnMCf7p6OeH58Rm8UUcTBKqtFy
	YwEP/LnixoPdSPv3VguaSBP8t9pY51FgBjD7lMxdPNVQf0NdvRe6Tt/piNPcOvCw
	Erz/v/3Oldwzf/BHRveyRaNaVWAuFGUFCa7/bM2r06MvWjtwxj8HY3sdPLkphzBM
	FRo+pmFSFMmRH01lySSzmL1zPmldUJd2+7hethTN4Ce472iVZa18uTpuHQLr1zxG
	3d6UdZ9XA+mv02Sw+9SLcQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce953ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 12:26:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476BeHGh019764;
	Tue, 6 Aug 2024 12:26:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08jw6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 12:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1jiqTNE265/eE4xD7rj5ln1lTMCEJmY4lfiUbm2R9OVStldfvlDTwDcQSNBcWLO9keq/h+3D7W/SDLhZPENQEcb/t4ZJlDLaH0bfqiOmgmHCJDGhVS5rXNr8Goihs4fQ7y+aN3R8PbKTS2ddAAfkLf/DlhpFQaBeloWkVvOiSQIgHYhhU41oCU8K+8SayaCJ7d05V3S8ZUUenO/ZOfxGRcvYjGW2C74sv/4HmaF3ubs8nfJq1yYVxjRP2Fc64WGYiubE/tXiKwBw0qyMveNNmJR1KmH2JYKNQp1xjrS81wvAlcbCw+Rzk2C+IIMt67JCDaZUgFDwldfO8yTunXQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Kc89S1q6J7d/TsKxyG2WxWSSNwpE6ARQqpq46SUIA8=;
 b=AIBc7qA12kOENbxYOTB0ZhySQ3wiZPE0XxBHK8FrlKqBJCA+/Ztt+L8I+/XXztPz+8/8zuScmrZHU8+zUJT5reGR2NINS3MjfpWLfgvNAKq8NRIwgYVXPy/VJvR5IymxHWLcphWXFssCVmg/Ucs+G9OO0e1Gwwk28CQ1hZZMwIqTUiSLsMdvEVNJcG2Qa3YRdGpudeTdIV6NW8T+w+65kL/8/LS3ZVGXyqy2J1OiFOmsNZdTauokBNlwazZnZAZKXAJiGCXxkEQE5k0LI4mgTiGGPIgEhi9Hlt2QdxQo2dsL5Yc0UAfojxVgXTgXVUkpPXtM7y+WsisFPxrhZ+gymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kc89S1q6J7d/TsKxyG2WxWSSNwpE6ARQqpq46SUIA8=;
 b=dLFwuHMsFbfozKqEekIK7G/KxWREstdTCgMKJKE/du9FFSzj4WtrlFYNq8SgzU17ax47txkgouIYpCqxEIY4VJ+CbAra4QLwuZ3fTk5HpMil1Lexcc/fBFZ7rRS7UcLsJGnr8Rxvu7QpmcPZG/F9qJsHpknBVUUWyc9PQ+aBdUk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 12:26:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 12:26:48 +0000
Message-ID: <d8a16184-964e-4359-89a5-b2a464e262b3@oracle.com>
Date: Tue, 6 Aug 2024 13:26:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: convert
 test_skb_cgroup_id_user to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-4-14cbc51b6947@bootlin.com>
 <1edbf600-237f-45b2-8fc5-47e471a17db8@oracle.com>
 <fa0b7986-27d2-47f7-ba1e-1d8075e5c35d@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <fa0b7986-27d2-47f7-ba1e-1d8075e5c35d@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::32) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: df444c35-77a0-40f2-4bf1-08dcb6130b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEs3eWtvdjI2VFhhdmNPMWRURDNQMHNPRXRqWW1rQUhpcjkrSDlYY1VjM0Ra?=
 =?utf-8?B?bWNpTmtQVkUyeTd1aFVzS2JaK1JZaktDdE4vSmI5VC9qNnlrb0sremFoa1Y2?=
 =?utf-8?B?aU5BTHV5RzhQQm81dy84QmFLRTBRRndxZkFHOTlSOW0xK1dmL1dqMjJNYk96?=
 =?utf-8?B?TUlYYlhIN1JQRWQ4T1lEZEVpSFo3NEp3MXAxNC8zZ3BxZmF5VVRUOG8xWVNY?=
 =?utf-8?B?Y3hrQzUxZXk2RVA5SVZaQzRrQWhPUTk0VU5RajM3ZU9pbTQ2T0hsNE1MK3RB?=
 =?utf-8?B?b1pJbGVNUmZJa3hra0Nwd1FQTzdneUp2ZW9lRkFDN0ZBVmcxbnVRcURTckNz?=
 =?utf-8?B?RUNMV1pJbGc2bEhVbGF3V2NhVWE2bDhVTHluQWhLVEd6Q08yZ05RNHNwK1gy?=
 =?utf-8?B?bWppdzB0TzY0NFNZYVcxL2xFRkp1ZU5mRGVLcVhHbFFWb0J1M2U3SUg5TXFD?=
 =?utf-8?B?SWJMaWNWVGltZjVNM3NlK05TUDVST3pnM1NsNXFYZTZtdHplNGpHc1NHbHQy?=
 =?utf-8?B?Z1JCSzUyLzBnYTRydy8xdk83eUxmV0lBby9TWkV5NzNwZkRTcjRpVitQWjFs?=
 =?utf-8?B?cGQ1WkdUUTh4RFZHM3cyRUZHK2Y2WWxTZzhzTktxVHJNVTBvT0RINzZ0blhi?=
 =?utf-8?B?bkNNZ3U3V2o5KzlqeXRMS1JFRllNYXZmTnhhbE1UTGNxRWxKNXNHazFoNTFB?=
 =?utf-8?B?c2pjZGRLTTZUQnFrQ2ZNY1puZkY3YjBlWUlTYlR1RW9LZ0lsY3FYMTNocTlM?=
 =?utf-8?B?S0RwWjBGamwxQitVbGtTUktvSXlsRlNoT1lNaXZBc1BsWGJHQU1vL3VKdThz?=
 =?utf-8?B?ZjMwMmVmMTBJWkZOTzcyeFhJMDNnYTUvMkhkVEhlSlRONEdvdWI2NWxhR2dL?=
 =?utf-8?B?WCtscloxVjZvOTg3ZWw0a1Vsc2FRZDFINlNwSkxmSlJocXptcXZXYS9CLzNJ?=
 =?utf-8?B?VGppendLM3djRUZKVWZNM1JRYUxmQnZkcUJNemY4S0dybFBHbEl0QnM2cjhq?=
 =?utf-8?B?bUpRcS9XTlkvN2ZsQmE5bDRQOFdSSlRWdVFxd3dUWmZ4dTZqaFVkQ0tiUGta?=
 =?utf-8?B?NDRzRVhZNFZheExNdkhhUENoM1UwVW13eFQrQ3NqTFQyRDFWai9PY29JNFpR?=
 =?utf-8?B?dkdUZHBaYmJSQkxLamhaajJWeU14b1RTL2dsYkNPK1NlT0w3S2VsTHpDcWJv?=
 =?utf-8?B?bmV6QUMzbUk2MElTY0tPdnJRazc0eEZGZVFSclVyejlZaG5zSjIrQ1JpVUNq?=
 =?utf-8?B?ZDZLTlFBamhvYlkzVEVIWGxXVmNxQjExbUtVK29NcFgxa1lSYWt6SGx1ODBr?=
 =?utf-8?B?RHJEUE80c1YzYzIweXY2NTB3QU5iZzdRaFJySUpJZFNnZFo3dEt4bE5tUEJw?=
 =?utf-8?B?MksxemtrNjkxaEQ2NHNnWmY2akIvbmlFVEhVTTNIbHVab01VZkF0YUVxazRO?=
 =?utf-8?B?MEJtUXRVNUdJOVcwWVF5VEVXU0hzNGNzd3B4WVk3T1lvenRpVlFDbWxwRzdj?=
 =?utf-8?B?cUxYQ1R3V0xMU3l1MGZBZmduSHVuVXltNWZldFYwSUdLUlE4VStydWZnclc3?=
 =?utf-8?B?bUI4QXhubXVzNjU4eXpBUDJGdExIWS9hNjIxdHlRU0pDMklYNmJTWXNOU1VP?=
 =?utf-8?B?ZXBpc0dHQmVIWEdrb1YzRjFJYWQrTm51NjhSL25RQ051Vm5CbkV6ZUIrQncz?=
 =?utf-8?B?eDVrZi9qcGxPZnF6VzdCN1h3b3h5RDhBMGRkVHV1N2ZCYW5GN1BxbjVBWlJu?=
 =?utf-8?B?ck5leFc0a2JCanFHcXlWUTRlSzVxSjB4Z2V5Y2VVRkNJWHNKMWZKTGVEdk9V?=
 =?utf-8?B?ZWJLbURkSkxZNG16QkdKMlA2dndXQm1iVWZHYXpUYnJBaG4yektlVWkwRnlB?=
 =?utf-8?Q?Jy+pjatHP+Qux?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBGVW5McCtkbGlNTTR1WVdMbjMyOHRIUzIwZWZhc1FjclF0RWt0QUkxb2Vk?=
 =?utf-8?B?WkRaTzBoaklFR0J5c29xaEQ1ZExCQUFydXpjV2xScjdNNHdEQkU5ckJmeXMz?=
 =?utf-8?B?aERxVEVsMjlJakY2VVk2Zzh1cWQzMk1va0ZxV3R4SzhYUzg2VG9lNFVuelp3?=
 =?utf-8?B?WHdIMmtzb1RSUDdqY1JXSllDK2N4MzJ2cFg1U2VqM3lCWDJJSC9OelBqcDdY?=
 =?utf-8?B?MEdHVWxWMk5ibnB0MExEYWdXb2F2dVhmaE0xTUpicXJrZHovck5OU3ptWWV3?=
 =?utf-8?B?WGZ0M0l1QWtqbENmRUlWb0hhTVc5R0ZpSEJ4dFpiNDBZRDJZTS9CQXNsUGdp?=
 =?utf-8?B?enA1ZWdlUnFhVFVHc0tMcG5zZ004c3BBRTArZDVmU1VMWWx1Wm9ERnVtcFFG?=
 =?utf-8?B?dHBydTd5Q0xCSEp3R1VyRTl6MVhteGsrT01ES1o2QlJlSHVkVUZnd3dTT2Np?=
 =?utf-8?B?RUgxSmpMZnNXTUI4Y0VYeW05L2V3UjlyNFNPS2RQNmNOZjl3MmF2Y2YxMlVC?=
 =?utf-8?B?TFVHdDlETzRSYkhTRXVqaUV0WmpNcHF2azhMM1BnQkRjZ3dISGRGYjBpaVR2?=
 =?utf-8?B?VE1MOE95S1F2a3RTQjBVZHYyQXNsZlIzalhYRjJoVGhDeWNvbFRmRHRiL2p4?=
 =?utf-8?B?Mm5ybVN6VnRpNDJGNHB6d0hxRkRZYVFJVDlhci9rWXNJWGRKUUVUY2xFNGFs?=
 =?utf-8?B?a0ovQkg5RFlieGJta1NDd3BzbUlxWlFadzVmTUZkeGVKY2ZjUkRTZ3BOTjFR?=
 =?utf-8?B?a2Y4YnFvd2M3YWQwRmNUeEhmTG5EOXNqU0RJZUg1Zy9aUW1ZZWZHMm05Y1RV?=
 =?utf-8?B?N0VwUGl2azU0cWIvanBMbnFDc1ZYUXM0TUkra3g5TjVYRFFYSEJlN3hnRnlZ?=
 =?utf-8?B?OGQ1azhJNy9xdUFEMEFkVi85OXN1bkowSmRIU0xJclV1cG9PRE4rcDFCV1VL?=
 =?utf-8?B?WGVwdFNvZUlXalFlMjdOU1c1a0tLcldYTDhqUnBwZlcxTU1kVis3VWEwOU5p?=
 =?utf-8?B?d3poSUhRMmxnaUdqcFNOVU5yMFNzYnV5dWJ4WnV1dTBpYm9vbXZmUEpzc3p5?=
 =?utf-8?B?TEhYcGttS0N1MFVDZGlYek50L1lvVm4yYmRTcVYwcG9WNmxKNjJDWVdCZFhu?=
 =?utf-8?B?R1dkN0JYbTFIdVdsVHA0SDUvMTBaZUcvUEo2WUZjdis3djFOU3BuUVVXcjlJ?=
 =?utf-8?B?b2llUENBUkFQOFJ1emFkVWh5cUZHSmYrejNuZk9adU04RU0reEFFcEFJT00r?=
 =?utf-8?B?MjRtckN6ckZXZXd1WklUV2psNW1tYlZUZWE0MjFNeVppVVJBV1JlTE1OcnFQ?=
 =?utf-8?B?QlFQNnZvWFlna0YyN1JHRXhZOVdKcWhDU2ZYU3FPa3FCcGR3N1V1RldRVU5G?=
 =?utf-8?B?NzdZZ1ZuRFFxbjhCQ0Z4cmlTS1RQMDBHRzBHb3UyMjVFZFRjZ2dqZnQ2cngy?=
 =?utf-8?B?TzA5ZkFRZzJtaVFXVVlrZ0FUc2pyQ3laTGZHVklORXc0aEx5Z3IzUjJkWG5j?=
 =?utf-8?B?RjRtTithN2xEb0dGVWY2VUVZMXYxa3FyQm93bnJ5Z2E3eEUydFFpemZWemRj?=
 =?utf-8?B?QWRiYWZBdDNOY2hqNW5mejN5UVpHSmlWdzZMS25IT05NL3QyQ3g0cUhmQm1s?=
 =?utf-8?B?N1p5RkhTN3VvZ3BHaXNTbnFRbGZHSk1jdW5BU1hta0d3cUl1OWNOWnFQTENI?=
 =?utf-8?B?TGE2WjVBeGR6MDVYY0x3TUNuODh1bk4remtrUTQ2V043cHdjQ3JXU291ZUNP?=
 =?utf-8?B?VGM1TXJCcmlUNTE1MFVOc1l2ZVVaVUhBeC9XMVdhWFZ4NnBoWVp3M2wxLzdk?=
 =?utf-8?B?Z0RvdUpGdmV5QXhMQTNxVFJGeU0yZGhSN2tMWlc1R0l0bVp1UStYSWdzL1Qx?=
 =?utf-8?B?RndqbFl0RWVWeGFYZDh1R0dEVnFvQkRhRHd1RFQ5VXdJSHJla0c2Y1NVeFFx?=
 =?utf-8?B?Mlh4UUh0MjlHQTl2bUZrUWFsc3J1SmpMZDJMV0l1VzdoV2ZlcVplMXBRb1d6?=
 =?utf-8?B?N3RzWFNzbXZ1V2xZbFlCdS8zQlBtdkJOUWZ6emUzM092NXZ4cFhJT2FnL3Vz?=
 =?utf-8?B?eC9uVjJmMU8zVmJPMkpKRUlIblVETHdJQlQ1amhtMVNaakI5ZHhXRXFCS1ky?=
 =?utf-8?B?ZW9NWjRDTkNXM0g0bFY1cFlLNjBEQ043UjlJcThMakNJWVE4aGJPVXNEQ2du?=
 =?utf-8?Q?fmDt5euD0GKP2WktXHVUdig=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7k6KkxxhtuCu/KcONXvnFZ5BX/hHjQBVjVhJKMAfGyORREg5R41KsUkHk740AF67GgAJP7uFBywRaxO4tPC+/QF3b/cCsSgte12CpWiEOLmCeXrNu5Z5a2wbzntdgmEevz54bUuqCXcH1ear272NYJEToadyIypMYBOSNqUT6Ctr4agrm94udacik0Y5nlUEATLOsurW/Ukal/LxR2kaDjaBx9P9roNYLFbG+ct2MBx8scNwWrIeeDbhZMPhf0DkACGEXU9zBqsd5RWs7L7ahbQdYchQkhmFlOoju5+EQb78+5D8NZEsWgME6fJxNmD2QFsp5PWOhvA1AoLz97ml2gcKynAxPxe8jOInKW6Y8azTybPtRv0gaVWPOgpiYtuCiUMCeiEwvc8IK9FvWGSxgn8krtS9CU3rbcG4vtvnRe+KVuKxuMGtkCh80p+TSiAKKuZkTyvXvxQN622vZdT5iZVrxuP851P5Hd6oBmN1FvSdaQYd9agH/gYFqw+0kwQLGJCoZCqGmynbweBoYrpNShpffFoIskpjfHB9vjlbLmuHKZ8N+HPVUKePTrOuCY1XmYkzZtm7BPzp+7Roz2SFhS2bDFuOycBY5hzLK5WU1IM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df444c35-77a0-40f2-4bf1-08dcb6130b15
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:26:48.8936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZthtS2zXC8rGl+epGSvL4p7L68Pwdnu6VAUDuWSGDem6FrX78QAKHzMP5rAZDwKfQvDba/gi/Cfpva92nEPHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_10,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408060087
X-Proofpoint-GUID: J1YMB9O0qy_NU8VLpmesBloV0yakcQRx
X-Proofpoint-ORIG-GUID: J1YMB9O0qy_NU8VLpmesBloV0yakcQRx

On 01/08/2024 11:12, Alexis Lothoré wrote:
> On 8/1/24 10:49, Alan Maguire wrote:
>> On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
> 
> [...]
> 
>>> +static int wait_local_ip(void)
>>> +{
>>> +	char *ping_cmd = ping_command(AF_INET6);
>>> +	int i, err;
>>> +
>>> +	for (i = 0; i < WAIT_AUTO_IP_MAX_ATTEMPT; i++) {
>>> +		err = SYS_NOFAIL("%s -c 1 -W 1 %s%%%s", ping_cmd, DST_ADDR,
>>> +				 VETH_1);
>>> +		if (!err)
>>> +			break;
>>> +	}
>>
>>
>> thinking about the risks of CI flakiness, would a small sleep between
>> checks be worth doing here?
> 
> I assumed that adding -W 1 (ping timeout duration) to the command would be
> enough to make sure that there is a proper wait between each attempt (so
> currently, waiting at most 10s for network configuration between the 2 veths).
> Don't you think it is enough to prevent issues in CI ?
>

Yep, that should be fine, I missed the wait option.

>>> +
> 
> [...]
> 
>>> +
>>> +	expected_ids[0] = get_cgroup_id("/.."); /* root cgroup */
>>> +	expected_ids[1] = get_cgroup_id("");
>>> +	expected_ids[2] = get_cgroup_id(CGROUP_PATH);
>>> +	expected_ids[3] = 0; /* non-existent cgroup */
>>> +
>>> +	for (level = 0; level < NUM_CGROUP_LEVELS; level++) {
>>> +		err = bpf_map__lookup_elem(t->skel->maps.cgroup_ids, &level,
>>> +					   sizeof(level), &actual_ids[level],
>>> +					   sizeof(__u64), 0);
>>
>> could probably simplify this + the BPF prog using a global array of
>> actual_ids[], then compare it to the expected values using
>> skel->bss->actual_ids
> 
> ACK, I'll update this.
>

Great, thanks!

Alan

