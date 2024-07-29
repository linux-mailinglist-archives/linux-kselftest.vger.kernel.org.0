Return-Path: <linux-kselftest+bounces-14386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5AF93FC6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 19:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01092B20F23
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE7A80BF2;
	Mon, 29 Jul 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OWsOdMZV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZSOA1eKG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B871E86F;
	Mon, 29 Jul 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274242; cv=fail; b=KkS2MvvF6PmEoMGZtntHNJ+K8MwlsvurDb4SF9q3IGPX2lac90BSOQC+ayp3k1fMHv9o/XEiQRshREblPciwcCFcuFSb8P0fqAkV2x4TRIWVYGIwM4JyZ16N7r2YsN+yDRYCJDak+ILk5oGghRhhr7YoetOPAkCaP/61yjxk4rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274242; c=relaxed/simple;
	bh=dLwyjLg+qQ3eKThAjli8KBZHOea4xrOQMwnCoLYqxZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YSIYxjNjzCuimzfcbARJ7kabDVzNkdnEfz1/u4yFoF42NfTmuSG5MDw0BoZ8yBbx8eh0zt2vA8yr/WRuY1xEcnB55LEXLtYo5SOjXMJ0b/O8I7PprPvTsInRuuqAVceA5ghzgNOJRMQneRS3Fk551EBxvsq/YfQNmOL5rD09DJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OWsOdMZV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZSOA1eKG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFMWkx018289;
	Mon, 29 Jul 2024 17:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=wskjCFExlfo7Auz06/QdZ0iSlaGpSiQttEaZUm6mKE4=; b=
	OWsOdMZVSp8ZVCQ2/q+tQwls0C980/Mmro+gG4Qoi5UPXWbPYnNXzZG15rt50MfC
	WvsiTeDyC5PtUhe8+3wEVNymGLdTenyY9EK1f5RF/O+naWvpTNZpdn3aT04WtyL4
	/zOlOadQd7lwxgd84QjATfeocY7ZmQmJ1MK/l/Tza8KcRYZI9trqE2Pk+PKVnKfS
	Gcas04VHRzYdnM8qAsmfViUlbIMEeC+VhUudkUG5uvvSt6v7iacUasLZdD6Ms/44
	vlzycekdo8zhWU0/FKMfBfNjhaTk14UsQJxB4Pm4wvYOgDXWrKqmHDU0WV0bSjry
	32C/MemU4sz+0Tww2B4quA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8k5rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 17:30:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TGahgO030812;
	Mon, 29 Jul 2024 17:30:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehrx0q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 17:30:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk8w86pVa8WEIDsRBg+L7UkcrKTG5uBiSwXvfoedsXKayjuLU2EEttYzqhPn71xHwE4+XqbasICY7DGqzVYQx9yNiyQz53CTXWTKBk6X45Xwa33X4BNdYGVY7kV30o5kdLMpFvYv9zVzgYZfnPZ5kyyTCVCetZSWRmqhMy7gV7n30BrodStMX3OZJCMx6J00y4RVoZscFnAXzeHE6AjVhwgdYXEwmoI46wFW/iguhuYRwO1nl1CskqUN1AG9tGQZ/b53c9BPeACJeEi5VQpzkszdOy6YFl7xkYgFfgmZUAxAF7cNZuWnLTSp8+OGn1ODh8lKND2eGvO/ePgsaaMdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wskjCFExlfo7Auz06/QdZ0iSlaGpSiQttEaZUm6mKE4=;
 b=TylIpYj4u9aLnkAQM7ItN9wQI6jHMh3Bcpe2bJcTUoGjNmo6uMg65H0IYd8Rx0uO34rXdLZcnBSfIrHwEXiqw5c2eTxm+/0BJu7mWMGEYIyNZPKRbO9IxX+Ysai26Y/XWSTzWzcQH80WbuQRDIxoOjPYS5g3+kSDJozBcKlTvCNWcySrXf/1ZgU3Ih4FcYB+33WM4SI/mLIlyTRE9j4uww8CXwUOOnFAhU5tnXc0gE0e4INecUXyBgQRpcPqp2W5jPxxwoojkAAid7t0+pqNpsjeTJIZPFg3P5T4deKsFNMGlaAItSS1iDiqCGUclXDp5/52KWq4Y7hHXA/SxcGacg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wskjCFExlfo7Auz06/QdZ0iSlaGpSiQttEaZUm6mKE4=;
 b=ZSOA1eKGKNH3bc6A3P3eMlTISi4/ODQSyle7h/9WMyTqi8zd2WUrsVzZ++YwkvsbkFe+p9Wq/ldMVaDargYxp0LAIHTp7VDMjoX19tCxl8Kmo2KA6Dezt/mTS1rz7BtsDMX2iKyituu1PVdJ0ZI+BV0boSgdgRf59A7uIQCzXZ8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4425.namprd10.prod.outlook.com (2603:10b6:806:11b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 17:30:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 17:30:12 +0000
Message-ID: <30ef4e63-02be-4691-b85b-e98c18d59e57@oracle.com>
Date: Mon, 29 Jul 2024 18:29:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
 <20240729-convert_dev_cgroup-v2-2-4c1fc0520545@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240729-convert_dev_cgroup-v2-2-4c1fc0520545@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f97c755-a49a-46f7-d0ef-08dcaff419dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDNDTjhFYzZod0xER3ZtZDlqRzZOcWtXTXYvYXVJVlBTZmJVUDRpRXVVeFVZ?=
 =?utf-8?B?UXh1WjlRT2F2dkNaaDZrUzF1Tm4xckx6VmJjaVJwT0VOdUV2Ky9HMXJoWDM3?=
 =?utf-8?B?VEVLZVV1aEFYeEx6a0YvUTMzZTRmeW44ZXdKMHVldnBIY0xYcnRjcEZXaUdH?=
 =?utf-8?B?bHBUSnZvaW1ibE9UWWpGdUFjc2FDV2ozbTJOWXBVUWZVakdRM0JBYWo5bTB5?=
 =?utf-8?B?ZlA4d3c3aXBNQ1o1RzFGQ3V5OVp1WUtsdUhWUUJVdWNqdTB3Vi90NnBKdTdw?=
 =?utf-8?B?ejBvZTB0c3o2QjkrVEpzdjMzY0FldFFIS2MxNDlkLy8vS1gxaEhDOEMyUW1Q?=
 =?utf-8?B?NWo5VEZZOHlFT0N0TmFEakswUXJGZVRvWHMyYlY2cE1LZEg1blRYdzJubXpz?=
 =?utf-8?B?VUx4L0VBMWgveUsxRnZad2U4cElqanBGZUdBWngxbmU1V0tWcmw0cEttRlV6?=
 =?utf-8?B?c2dGcmVhcFI3NXhXRW5uZ2RoRTlFOXBrSS85aTVOU2F0aGNFMXFqV1FOdXps?=
 =?utf-8?B?eExOVlB1T3htKys4dkVHNUg5K2FjL3NWV3NhanJSNHBZaFdJRGd1L1BQMm5j?=
 =?utf-8?B?cGlFRzFHVFFPZmFodTFBbmo1RkhqYVZDMVVER0VrU0c4NHQxSGZvL3QzbEw4?=
 =?utf-8?B?STBPV1NpYmxEZUYxcnBxNXcyc2hjQUxBWHEvZmZzTmZZdG1KU2N1bUtSQ1VP?=
 =?utf-8?B?T0hCZGVMK0FEaHJiLzRwVjE1Y0NIRWY3MjcxRHNIQnd1SG40akNOU01FbW1w?=
 =?utf-8?B?OUxYcnEwNzNrNUZCWmU5cjc5NXhXZUNSWms3RzF1S0Z6TlhDcUltNGJ4SEZx?=
 =?utf-8?B?U3ZkbmdxNWpLQnpCUUdCY2JCa0QydGR3RnlidHplNmJjRS8vNXFOUUt2WW02?=
 =?utf-8?B?Y2ZteklqUndpVWRyRGU5V09pT1R1UTdqYUluTk9ta3c4b3hUeHlad0o1bkFU?=
 =?utf-8?B?RDA5V1o4eW9uOHNXZWN2ZDYvcXNTZStIdTREWVp0c2hMRldjVUhBUy9Vdm5N?=
 =?utf-8?B?dzd2b253eGhZMGg5ZTV6RzUxNk1RdmY4SDFPYkgxa2hQYVdIaUR2UTdoVFZw?=
 =?utf-8?B?c2tUeHNmYjNZNEZQVWtQRHZGMGVBak4rMGdqcUhPLzlGQUhYcmRDbmVWcHVz?=
 =?utf-8?B?UjNCQ0E2VjdaeDdYMkJvVVhtYWlZZjJueWt1VytUb3JWV1NTeEQ2aE9NMXla?=
 =?utf-8?B?dG4xd29qalZMQi8vdW9WL0JLSkJrMnZYOVFGZ2ZYU3RjbExYYmMvblJVeTU4?=
 =?utf-8?B?UE1SRHE2Z0FQR1V4RjFsTFd1MEVJRkRlK2hQamZySzhTeXBDNXNlMG5UbnRE?=
 =?utf-8?B?cXNJTHlTSlBhcVRDbnJNcDZYRHBuZ09sSTBQelNsaTBlK2FKQlVXaDlOSXEx?=
 =?utf-8?B?aUJrbEVjUEEycVRJZ2tJQy9GcW8zdkVDTE9pNjRqV2hiZUZKRFhpam9RdXBk?=
 =?utf-8?B?TElMaFRTNGJiSXpRcUxDeGt5MlRFWXpmdm5qbWx6dVNBK0NyNGJtQXRQb2ZK?=
 =?utf-8?B?SmF3TjV1ajNVbDkyNWdjVXBtMis1bEF5eXpFNWZCOHVMb0xHeWdSYThyakdM?=
 =?utf-8?B?bHFkRmxDNVMzRlVrZUlaL1pXTk9taGNsKzV5ZGlVL0toeXpzcmdob05vVlk3?=
 =?utf-8?B?Vk9WYzNFSUxYRmFlTnVoSFRQKzlQenF0V0NYdzF2RG85MjhvaTRueHE3bFlR?=
 =?utf-8?B?TXR2cDIwWVlDYkNWblBtNFE2UnRQaXd6OVByUkFtbFExMmdUZTlOQUZ0eE9E?=
 =?utf-8?B?ZTZXSnFqTW1TMTd5Vy9mOCs2MGNIOWZKRDRDMm16UXBvaWM0NGxwc1ZFUEJl?=
 =?utf-8?B?QUhiazdoSmU5YlNneWtFQktqcXgwd2RiWThzZzFGYXhCbmxXYzFHNXBiRW8w?=
 =?utf-8?Q?WfeacKt5u3wi+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFk1bmo1QVFaUVViTnJZZ3M1MEM1RTRKR0w1L0pNdisrdjRFZElCWE5NYVl4?=
 =?utf-8?B?M1dCL1k1WWt3Y3Nxc3l4bmhRaHVaMVZ4c2tKeWZFMXp1SjRucXRrRis3YTZ5?=
 =?utf-8?B?Y1hNb0RjRitMckxlVjdQaXlzc25KN3ZqUjNwSW9KWkJuQ3d0VEhNdXBOR042?=
 =?utf-8?B?cEgwM0FmKzRBUU1yMGdmNmxGR1FMN0VyZVBRcjBNanQ0Wkt1L1U4bmIyb3lF?=
 =?utf-8?B?RkJ2NmU4NWhzd0N5T1psWDFUQXNyTmtSd01aMzloYmxvSnpjUXZpYnpJdC90?=
 =?utf-8?B?NTRUVFVXQ2lwZVhudVNzZ3NNZWhrTXJrQWg3R2phUmhXWEFtWXlZcEUxaDVh?=
 =?utf-8?B?RTBwTVg3UVlGUXl2NGRIaGdHNXB6bGs0T0dMblBwUVNsakx0eWEzUDJ0c0Rm?=
 =?utf-8?B?VGZvc2tkOEZqcjI0Y21IWGtiK3NEa0ZzdFMwNVcyT251TXZXekhUYnQ4bmlV?=
 =?utf-8?B?TElHSnJYMUFyTDRBdXlCbGVpUU5IR3FhK09aOUlBL0RxUW4zT1FVcHQvZDg5?=
 =?utf-8?B?Rzhia0g3N3NxN2FPR3habVg0S1Rwb0VjTWIxMDJvVnMxamtEdlpaRDhGbXZW?=
 =?utf-8?B?TGhTa2cvMzdDaWNJS0I2b3B5czE1MFI2T2cvYU5ZVlJQVmtIeTZrWVMxMEJB?=
 =?utf-8?B?U1FENUJJdTdIVkFhVk96L1duT3ExekdNTXNvdkgzY1dNbTZPMDdtdStJTEtm?=
 =?utf-8?B?VEQra1VmUUtHZ2dNWXdKUytMUFNiMkdiTWdHbjV5QisydEozRXJVcldhYnRn?=
 =?utf-8?B?NjI2SjFOaTE4UzRjZDMwMlB0bTdqYStDSlFvSXNQODViU0JYREhNUXRUV2pC?=
 =?utf-8?B?NjR1ZGI3OVljZ0d2S2FuYlpyL0tYbFlUTlBON1EzLzBaQnQ3L0sxMkpxTXhw?=
 =?utf-8?B?WFA2b1VmZHRIRWFiWm5vSWkrWXpCWjFNdXVxckNPL3RpNHVCY3g2cmhqZ043?=
 =?utf-8?B?RlhrL0NJRmNPd0lFbDVaWFZabWZvWjlyUkRZV2c1WElVVmxtYk9KOFA0djJ0?=
 =?utf-8?B?OVFUR0hYdkdVN0o4akNoOThkOCs3cXJQUkI2WWJCMVVycGxYYUF2VUx2VEZx?=
 =?utf-8?B?T3N5NnpESmhsbTVOZ05RS1FKNHRHQVZTaUJvVUN0THBhTllnMi9RaHMrWFl2?=
 =?utf-8?B?eDBsS28zVlczWjFUcXRiQW9ocFF6UWxMQ00wbTFlZDhxU2ZWRjYveW9Xc28v?=
 =?utf-8?B?MlpCYW4yYzBDL1pTblVIelNWR3I5TSs0cFhzSitIaDdxREZtVEsrSzhMZUxI?=
 =?utf-8?B?Z2NLQnFGS1NKbmx6SEF3cVlOSXZwcTVYTElxMTlOZ0ZNUHpEQjV4NVErU2RT?=
 =?utf-8?B?d0g2eG1XVnYzd2tuYlhKR2JwRHJsODlhZXdXejBhclJidFQvbHd5TmJURXJP?=
 =?utf-8?B?TXkvOFVuaFlhdkw2VW5iNVUwQzIvM0QvcDgvU2gyOWxxVWxZY1F2SGxtZVIv?=
 =?utf-8?B?d1lUNXYzZDNMR1BuSllyc1pvMFJLalljeURMWUdDTDdnZUtmYXArTmlSdnZv?=
 =?utf-8?B?YkZrNDFFeUtrL080dk9XdS80Qnc5bFZ2L3UzNk8zM2xkN3pXRExGeDlCVWJZ?=
 =?utf-8?B?MmZ6MVRMOVBCVStkWlBqUCtRMys3NmFXTWx4SUhIaUU2c1MyK1pzNjUzUkxo?=
 =?utf-8?B?Zkk5OTRpc3dwTFAvY3hTazJBQ3lIVzdxMzlQbFZmMUpIbGdTM1YrSWZYbklT?=
 =?utf-8?B?anZzMldMV3ZNWUx2U3JNWUVUSHZ1NU5DQlh3aWI1Vmc2YTF6bHZIQXI1SE5S?=
 =?utf-8?B?bzg1UHhGdElHZmRyb1lMbWlCUDJ3MWF2TWJkNzJmc1F4ZVI2Vko5NXpMcmlB?=
 =?utf-8?B?K0hKOXpGN2pTamRRQWpVMlFTVUlQWnFvcS9NL2VVdk9Fc1BvMVpFVUpENGNU?=
 =?utf-8?B?Q1FaMDJWa0p6a3RNOUVoQ1ZNb2swNlBUT0lFeXU3V3lBYjBVYS81cmxLRnBT?=
 =?utf-8?B?ZHRYY2F3eXZGdURUY3djeXJac3V3S0ZxS3FJbHd6ZitiVnFMRFRFRTZDVFJI?=
 =?utf-8?B?bXJLOWN2QzByVDBmWWxsOFdteEpXZjRmSmNObWZGS2Q3TmgzU1VlLzNMSksv?=
 =?utf-8?B?ZnhuejVHMG1sNk05MFM5QmZhTUpndStzWkNURnFQMW1GWmFGZUxsdC8zWEZT?=
 =?utf-8?B?WDJKVjBZMVJLM1lrVkQ5VEhOZWxkZ3Y3NXR5V0doWDJIZTBQV0c3MEk3anNR?=
 =?utf-8?Q?C98WCfciIdqMblIWlm29t4M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3wb1Rn/JJYGu0d0R2nKqJeO41Mh7kgLjKiRQiPJMAyFW0ahuWo0WqIh8ySP2k3weV46i0B5MzthjgB+Lq09W4cwoUl+fsHqv9EAkRJy9sKVZAPhR74hEosjtz23976Hb7jKNzt9gLwogIYI3APYWZTDVBLuCTwaaZX/v9R40Bkx7vNWteDeeL5vG5q4tHgrSmXDvOIdxBWi95khiSJysOGhQJM6NvPILhjNcBbrsS9Tg8eiqAjM7g+GxsrxHxo0TNsohV4tcwR9nv/hE2wnmXu+lW9fRe8ANGRpoLHagGKdD4ixvxAGUObxo6nwltWljVbemHgXLpMzlsOAHUePKHPRM2QEjxfvDW1M4U35RW68c75vxWqO7kocogY28hF+HaXrfAkLcvxJ0hXayyDfUNtaG6QvAaZC0tMPulcckSqqeey0n7Rzi7hDOYb6W8z5rUVwA5cyQw3QyqvzhFmgNDUvdVPQM3w2Tt3+8S1A9lKDHquoIH+S++1ZQXFab1VRsrwBcAnDFXp4Eer0yHAcVEfK4WRvPa/G4nUQs8tCGPjDFGqcm3BAPtAVP4Khh31ohTTPWZurSgeUPXieLELQjstbj9mCKlUam9BgGC7Gt9uM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f97c755-a49a-46f7-d0ef-08dcaff419dc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 17:30:12.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYRvfaokMw0GpGzILvUzV0VgOwkQUrq717cV9mqyZfb0Mx4VCJ7kFXj4kYePjmA7F4NcopkEf0/IXw6UXNzh3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_16,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290117
X-Proofpoint-GUID: x5L7u3iH1xw0kVIO7Wf2UdkBYs_rIs3U
X-Proofpoint-ORIG-GUID: x5L7u3iH1xw0kVIO7Wf2UdkBYs_rIs3U

On 29/07/2024 09:20, Alexis Lothoré (eBPF Foundation) wrote:
> test_dev_cgroup is defined as a standalone test program, and so is not
> executed in CI.
> 
> Convert it to test_progs framework so it is tested automatically in CI, and
> remove the old test. In order to be able to run it in test_progs, /dev/null
> must remain usable, so change the new test to test operations on devices
> 1:3 as valid, and operations on devices 1:5 (/dev/zero) as invalid.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

A few small suggestions but looks great!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> Changes in v2:
> - pass expected return code to subtest function instead of boolean pass/not
>   pass
> - also pass buffer and buffer size for read/write subtests
> - fix faulty fd check on read/write tests expected to fail
> ---
>  tools/testing/selftests/bpf/.gitignore             |   1 -
>  tools/testing/selftests/bpf/Makefile               |   2 -
>  .../testing/selftests/bpf/prog_tests/cgroup_dev.c  | 110 +++++++++++++++++++++
>  tools/testing/selftests/bpf/test_dev_cgroup.c      |  85 ----------------
>  4 files changed, 110 insertions(+), 88 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 4e4aae8aa7ec..8f14d8faeb0b 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -9,7 +9,6 @@ test_lpm_map
>  test_tag
>  FEATURE-DUMP.libbpf
>  fixdep
> -test_dev_cgroup
>  /test_progs
>  /test_progs-no_alu32
>  /test_progs-bpf_gcc
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index aeada478e37a..2a9ba2246f80 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -69,7 +69,6 @@ endif
>  
>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
> -	test_dev_cgroup \
>  	test_sock test_sockmap get_cgroup_id_user \
>  	test_cgroup_storage \
>  	test_tcpnotify_user test_sysctl \
> @@ -295,7 +294,6 @@ JSON_WRITER		:= $(OUTPUT)/json_writer.o
>  CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
>  NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
>  
> -$(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
> new file mode 100644
> index 000000000000..af0b70086c21
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <sys/stat.h>
> +#include <sys/sysmacros.h>
> +#include "test_progs.h"
> +#include "cgroup_helpers.h"
> +#include "dev_cgroup.skel.h"
> +
> +#define TEST_CGROUP "/test-bpf-based-device-cgroup/"
> +#define TEST_BUFFER_SIZE 64
> +
> +static void test_mknod(const char *path, mode_t mode, int dev_major,
> +		       int dev_minor, int expected_ret)
> +{
> +	int ret;
> +
> +	unlink(path);
> +	ret = mknod(path, mode, makedev(dev_major, dev_minor));
> +	ASSERT_EQ(ret, expected_ret, "mknod");
no need to unlink unless "if (!ret)"
> +	unlink(path);
> +}
> +
> +static void test_read(const char *path, char *buf, int buf_size, int expected_ret)
> +{
> +	int ret, fd;
> +
> +	fd = open(path, O_RDONLY);
> +
> +	/* A bare open on unauthorized device should fail */
> +	if (expected_ret < 0) {
> +		ASSERT_EQ(fd, expected_ret, "open file for read");
> +		if (fd >= 0)
> +			close(fd);
> +		return;
> +	}
> +
> +	if (!ASSERT_OK_FD(fd, "open file for read"))
> +		return;
> +
> +	ret = read(fd, buf, buf_size);
> +	ASSERT_EQ(ret, expected_ret, "read");
> +
> +	close(fd);
> +}
> +
> +static void test_write(const char *path, char *buf, int buf_size, int expected_ret)
> +{
> +	int ret, fd;
> +
> +	fd = open(path, O_WRONLY);
> +
> +	/* A bare open on unauthorized device should fail */
> +	if (expected_ret < 0) {
> +		ASSERT_EQ(fd, expected_ret, "open file for write");
> +		if (fd >= 0)
> +			close(fd);
> +		return;
> +	}
> +
> +	if (!ASSERT_OK_FD(fd, "open file for write"))
> +		return;
> +
> +	ret = write(fd, buf, buf_size);
> +	ASSERT_EQ(ret, expected_ret, "write");
> +
> +	close(fd);
> +}
> +
> +void test_cgroup_dev(void)
> +{
> +	char buf[TEST_BUFFER_SIZE] = "some random test data";
> +	struct dev_cgroup *skel;
> +	int cgroup_fd;
> +
> +	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
> +	if (!ASSERT_OK_FD(cgroup_fd, "cgroup switch"))
> +		return;
> +
> +	skel = dev_cgroup__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "load program"))
> +		goto cleanup_cgroup;
> +
> +	if (!ASSERT_OK(bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1),
> +				       cgroup_fd, BPF_CGROUP_DEVICE, 0),
> +		       "attach_program"))

I'd suggest using bpf_program__attach_cgroup() here as you can assign
the link in the skeleton; see prog_tests/cgroup_v1v2.c.

> +		goto cleanup_progs;
> +
> +	if (test__start_subtest("deny-mknod"))
> +		test_mknod("/dev/test_dev_cgroup_zero", S_IFCHR, 1, 5, -EPERM);
> +

nit: group with other deny subtests.

> +	if (test__start_subtest("allow-mknod"))
> +		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0);
> +
> +	if (test__start_subtest("allow-read"))
> +		test_read("/dev/urandom", buf, TEST_BUFFER_SIZE, TEST_BUFFER_SIZE);
> +

Nit: should we have a separate garbage buffer for the successful
/dev/urandom read? We're not validating buffer contents anywhere but we
will overwrite our test string I think and it'll end up non-null terminated.

Alan

