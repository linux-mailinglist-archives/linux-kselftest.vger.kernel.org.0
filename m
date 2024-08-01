Return-Path: <linux-kselftest+bounces-14604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36E944704
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20098285CB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722016EBE9;
	Thu,  1 Aug 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OM+kHew3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q5n/zr7h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AB16131A;
	Thu,  1 Aug 2024 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502226; cv=fail; b=Fs7VKkHFOxkEWPods0Gjy8Fo8gFRk8DJDX6K8nB0ezVFr2luaOgKB+4jajt3duHJWl3C2H75YJVZe6Xxmc2QRj6tGKqONbQKPF+KEAvT7OChRkcKTWUEayrApKj70Sz7/NPkrcmgjAjruAl0wyIan9KD3fK/7sVTZ6kT7lvucjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502226; c=relaxed/simple;
	bh=UGYCuAl0S44Bi6cKzlpMQvubYVgPvWpo99ySXgUB230=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qxbA2u1Zq22snyT3OMPVHyGaYIQXdV+GKZ2+czyBMzW/FVie0TlMZjL1UuWQS3CS7dnh77AcT+DuIkhowQZGtbm1dA04ebq6EOq4RNKQvKFHROTZgOpIHUx5qJ5/4EHmfKL8DOWEjCRx2bgWsy/N1DK7PWhiyrqU1dCTcLXojtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OM+kHew3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q5n/zr7h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717tU28004462;
	Thu, 1 Aug 2024 08:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=pJyI14p9E3HkpNL4jgRLw3JGS8WHyEN/xCYwbVJ4hXE=; b=
	OM+kHew3MS/FlKKp37tpIfyYEyH8Pr9vHu1R5D0xad11MH9H3+FsrLyJvBhxYvgN
	jE+0JMqJ0TFbw6NuZIlsZTyrs44aSJJZv6lSnFvM33+NFkI+AqJkXAyfOW11uMLb
	B39pBPOWpSAbgvqWXyFHe71ukAtYYCr2p8mdUaZMyk/W2wbpB573Fn3CLA1ScSIi
	31+zkzE/QbA0GH60OFaWb/RiYyPRWqIJVtx33tXTqDsVggm4aJqmxDAw3Z2j51by
	8sm/zmCyeqSzIaPOVhAxN3xoXdtL72iQf1kyC9TNJqd5hlpyCH0Cw+gWoeF4KFI6
	y3/S8FPAHoxLOp29K8UzSw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgs99su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 08:49:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4716qHP5028950;
	Thu, 1 Aug 2024 08:49:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qmpsqdbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 08:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCsespYC62IXqnsFyjSqRIVm4HD1Fg6XbjXwiMnb3SSRDQkd1F1v5Sgye5WM/yayk1MHEN+813pjjKLOk8QumMhMosn1qpr5LhRw1FVZIx0MQwACQx3+ccK3WHGKcgr3wVQ2toSgZy6PqXW//dEs41vPiHgVg6yOVow7AXpHDM1HQe97k0b+GoBEk1HG3qD7KU3YLnWQdgMeQAlstkKrq2tWANAC9aK6LL5AHasEcvkA7rVKeh6DkvQYpI3VshmNNBa1Ru18bcvrUp79v4MLVuYNM/yA0UBkiFS3n+LMIoHpmhKzW0/nqhGhJQKZd7D0rj5Jy5TRv6qDpB4+vHuGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJyI14p9E3HkpNL4jgRLw3JGS8WHyEN/xCYwbVJ4hXE=;
 b=okA+GrJ3wMvtPTS7gchg9YXwAx8H+72iOOyitXdyXl/kmL9V2IQk7oIc0RbD/tU4fzTn3JNZfEooPCx6HQf5xl54zPcmDpHWQ5y9bGuYccAgyIG1UNRDbZJ/immHlHVxCRAeRHk0SbYkOiNL2lFAAoBWvsXQRCqv7HYdjJ6TrgN302on+8FrzqXaCSeRXuSAJuwirMA7kzEx782VUQnghWife8FKU2AXSyEfpOf7BkTB88oeXjnOdo62bVLsXreBZDRdtGhLyAt56hJkkbfqjI/rnwR9URb7lWh4Pszd+tADr+8KvWo8riPOeMWiP3fxv1p5UNFlUPu2IoLBFVJNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJyI14p9E3HkpNL4jgRLw3JGS8WHyEN/xCYwbVJ4hXE=;
 b=Q5n/zr7hCv58skl+iQK7K+dEohStFmp5kmYu2MMWn/OHY0OyHKtu+ue1Xq9QOC9uVDDhtzl1VrCq28lj0Dp6ni6mFM1lV5aaf1ZlyAWB/aAlgp3AKYj1EKOQPFch4g516M23r8KJcrgERvv50zszxMC1Gpxk2aeNqyo96eFEEyc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4639.namprd10.prod.outlook.com (2603:10b6:a03:2db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Thu, 1 Aug
 2024 08:49:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 08:49:23 +0000
Message-ID: <1edbf600-237f-45b2-8fc5-47e471a17db8@oracle.com>
Date: Thu, 1 Aug 2024 09:49:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: convert
 test_skb_cgroup_id_user to test_progs
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
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-4-14cbc51b6947@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240731-convert_cgroup_tests-v1-4-14cbc51b6947@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0315.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d2fc8a-c1b3-4268-a77b-08dcb206d76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnVQWDN5MXNOM2NJWERpVVhmNkxzNXllVHk0aUgxWi9LMFRhdnZPN3RUeFlV?=
 =?utf-8?B?empqVzhqOGNCWk5FVnpTdDFJRVBUUDRRd3R2Q3JCRXpuZGhab0dFM2pzWVNH?=
 =?utf-8?B?dFZJOHZjS3pVenFCeGF1VnVCYzFTYUhJWERhTkxuSitGd2hrV2FMT3llVXlx?=
 =?utf-8?B?V09tTm1LaHk4K3lwMCtyRURISDdSaTVPME0zUDhFTmdtcDdtd1N1QnRrejha?=
 =?utf-8?B?SWoyS01peVdOSytKZHdEZWhvTk1UTDJpa2VVZCtPaVF0bDBhdnZjb3JIeWdX?=
 =?utf-8?B?eml5Q3hmYXJaejlzdGNDWU5DTFRLM2krSy9jZExKK1NRSUdhVnc2NU1MTTZS?=
 =?utf-8?B?QW4rTjhBbHozWGxrMEZtQWk1STFDNXFWbkZJR2srZ1JCdmR2cFZCS3Z3bFlY?=
 =?utf-8?B?WjlBc0h1Y01SbFE1SVcrcVpKQkhrY2k2d2VPTXc0ejRuTnFOaGNUd0M1SU8y?=
 =?utf-8?B?OWhHQWU4NU80em5ZTkpxUlVOYjA1SVhnSXVBc0pRdTNDRkRtNGpJWXdQU0tL?=
 =?utf-8?B?TDFSNFJPTlpMZXRKdkoxWG4xV0o4YjBMcHBqUkpCZ0VIdmUrSkJWcDllbEM1?=
 =?utf-8?B?M0NQYnNPMW82dWQ3cktsc0Q4a0IvN3RCOHF4OXFBdVA0R3E2eUtZU2FXa2tN?=
 =?utf-8?B?dkVVSnV0RllOVVBwaThhT0ljbHBUdXY3aGFITW93Mjl4YUFEVFhRU0s4Wnlh?=
 =?utf-8?B?TXpsL3V5VnhrNnI5ZWczd1MzUjJYVkF2bmFEaHlIeTZEQmc2SHBkWW4vcWlz?=
 =?utf-8?B?UnJ1dXYxWjRMV2U0aXdlelptbFo5Qnl1UmZlemRqMjhoUVRjUEpmb3NjWVFn?=
 =?utf-8?B?MVlXUzh0SUNXSUZSbzh3eThKbDFERGJwZGNBd2NEVmJCUWFzUTdOclc3U1dD?=
 =?utf-8?B?NkQ2c2hsZTZvQVNJZUg0VE5LRXlMVXo3UkZtY3Uvb21hb3U1OHNqTEMyd2pF?=
 =?utf-8?B?RlRpR2tMejA0ZlhOanJsa253bjc4eWhJNGNHYitRYWxUb0VjVk5pT2l1TXZJ?=
 =?utf-8?B?eUtxWUhhZERNcG84OWZhMEo5dXh2QUVHeVZ2T3hLTGZwYm5ONVZhTnNIMlBH?=
 =?utf-8?B?a25zZDlvdlJ0Z2wyQ0NVZXRlaWdISWJUeG9YNmRUL3N2aDJyZkg3eXdhb3Fu?=
 =?utf-8?B?Tjc0TlNqUlN3QlVMTFVYUTZ0aUdTM2Q2SFRqUWpCL01qZTZMTngyUjNzZDg2?=
 =?utf-8?B?eWlIczZHSU41L3ZxR1ZCTThDeWxBUTZMalFxTFJSY1A3QXNrc2g5b0piUmJR?=
 =?utf-8?B?a2VFZVl2QlpTL2xoKy84YWlhMG5sZmt5cmdnOVZUS1QxZ3FYQTVwT1RtcVE1?=
 =?utf-8?B?QklrcUJkM1FFa1FqYXVCbkV5SkFDWkthN2VUdnpSZytaWHBXUmU0cE9wK2tQ?=
 =?utf-8?B?Mk9OQkFNQ280ZnVXblc0TExzeHVPcnJnczhURGdmcUducXp0RmRIM0cvVEVw?=
 =?utf-8?B?Z1plSnMvRUJFY2NPRU44T3pRdVVoK3B2RUd1dmRrUFFLNlNVYzZuZmR2dkNX?=
 =?utf-8?B?azB1UEZwMENwcDBCY1hQdUZKZDFsa2tWVWZXVW53VDhmK3hmMWxydWM5b2JJ?=
 =?utf-8?B?cVZvQlMvYTVEZWwzR00vZEEwYkwyU1FHRUQwOVAyeTh1OUoxa29jT0VhV1da?=
 =?utf-8?B?a1o3MVhqMnk3dDExcjVMVFp2SzdEbzNKa09ONk1ZOXROWkdNbEpJQmxWSk85?=
 =?utf-8?B?MldqNjd5bjRTcFBWemhuNVp1N0p1eUl0czMzSDU4NURHV2haYTZjMi9YMWF3?=
 =?utf-8?B?dFBKbm11ZnFRdzc5WFJ2TEhNTXo2NlVyRjl6NlczZ1g2MUs0NlQzUk9UY2ZY?=
 =?utf-8?B?eitrcGE5VThUdExKU3N2UEFrWmVTS0d6VHo2YzVxWWRsRlV4eXhkOCtFMFhH?=
 =?utf-8?Q?YqH/WhVf/dJf0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk5YSXlzUHNJOTdlNlgxSFlVVmhvalcwa24xbmNrOTcwWXRaQzZKenZ3TGk0?=
 =?utf-8?B?RWpkY3ZJYWdkS3dDbHZXRjVVZGZuMmNOT0Z6RnZUK3VLeTliVXpuRy9FeEdo?=
 =?utf-8?B?SnFJWWZzTmpIYngzTFp4K3BqZVZJWGV4eHVPWGhSYjR0ZHdvZlFtbVFLTlhK?=
 =?utf-8?B?QU9KVlpnQXR4ajRCVmVBbkFjVjlwaERYVFBPcFQwMTluelNRNjROdjg5bkZy?=
 =?utf-8?B?SjgxclpZRjVrWXB6Y3FoQXVYWkJ6V1ZZb2d6QTNxbWs1cXAwRDAraWRTMGlU?=
 =?utf-8?B?eGkxTXg2NGR6MXYvNThNUEVGYW1rUWwwZkdlS1E5ZWp3WnV0bDZzTElZVlZm?=
 =?utf-8?B?d3BOSGRVV25lVVZHNm1PZGtGYllvT0ZEK2lTV0RxdXFyUEQvaDlyWlIvaEk4?=
 =?utf-8?B?K0lDb1d6NTNTNm1PMVhlT2haakZ0eUxzVVlJREhKUUM2eG1nNGRXbXZ3T1FX?=
 =?utf-8?B?Tmp4L2hhazdXVVVZTTRqWVhFNGRIeTk4aUJ0MzcyR1FDK0Q3S1N6VHhXSC9F?=
 =?utf-8?B?QjM1cmUxSmZGMmh1Umh6cmhHNmVRWFp3Uk5adXIxby9VQ0x0RUxkUUVuT0lH?=
 =?utf-8?B?bUNubXZ3U3pQelVtc1NOZEFBaXgyd3dUdGsvVFhrRFRNcXRFekQ3OEV1blZY?=
 =?utf-8?B?amx2ODRYM05iaTdCbVBHSkZvZWtlSFQ2aDFQa3JsVUNQU2hSYlcvRFU5aXYv?=
 =?utf-8?B?cS9LYmhwRVZVMFBGVzBuaVVralJnVkVKQXlkTDVmSkphSW9zRlhVN3MrNGtT?=
 =?utf-8?B?cjN0dTBseTI1dVFzc0x2bXJmOGJFanM5WkRQOVhiZkkwOExORW5qaEJobUZ2?=
 =?utf-8?B?d0gxZUdoYTdrdTJTK3Q1NEtlNzdDNkVzOG5adnBaWTUvU0RCeG9sSWlMR1BJ?=
 =?utf-8?B?N0MwYkU1aVA3TG5EVkhIckVUbTNoSU4xeTlHQXZYL3AxUHRiNjByYTV2eDJt?=
 =?utf-8?B?VWVJVjBmWUtrVnpDaUpobE9vbFdHRFFESHk0d1lpWS9NbU8wT3d3cS8yVnRv?=
 =?utf-8?B?UEhMRERoRWVLMTYwRnFqZFVJL2lyU2tLU3dzam5NL3l1WDZUYWFKTXNWRG9H?=
 =?utf-8?B?dWx5Y0JhdGxralpLWnd4S3BtdGlBTnY1ZHJad21uZ2lkYTQ0eEc3T1dZRGkz?=
 =?utf-8?B?M0w3NG90MWhiT05wRW93ampzNitnb0R1MFFMcllHdmtUdXFLNk81aXU1ODIv?=
 =?utf-8?B?U2hZbjZXNUdsdkphUktVUnpkcGJlZmd6R3dNcUJxZGZGaEpibTBSUE9NQnN3?=
 =?utf-8?B?M1JIVFphNm1LY0FnRi9DMkh3akt1bEdtbi8zWnZySWd6Zy93OXMzWWFGQnd5?=
 =?utf-8?B?V3ArU1dJTFhKeCtUWjFoOGdDM3E4M1JodmJkZ3RYendrUDF1SUZTMHpJdzk5?=
 =?utf-8?B?Z1FEekV3MXNFNEpRWGw3MjNVYmFkSkIwWEtmdnRFSGNieVgwVkpQVmNXb2JD?=
 =?utf-8?B?MnpnSjdwR1IrN3Y4UFM4WHZKRERLK29pN0ZTREdTUG9FYjdNeTNkc3pBY1VY?=
 =?utf-8?B?UlNoZDlnbWMyclUyK2VBMGpaRU95aU9menRDSCtBb0J3ditmTHB0UzdNVTlW?=
 =?utf-8?B?d29RNWlnUU04V3ZQcDM3RUVpNUVZcVRLZmQyU3JjZi9QWWJXMGtxUlFHb3FK?=
 =?utf-8?B?M2JMQ2l1aGZhTDBqbVJHMjZmRzRocEdVS1N1bGdEaXV6VHFmVVc4QXpaNCtJ?=
 =?utf-8?B?MUtJY3lXeElYUENhM2V5TzRzNnRkdDhIVXJGcHlGREpwRWlPZkdpcW52VWhQ?=
 =?utf-8?B?dWlhQ0M1YU0xRDdCd2xuU1lsYVJOSjBTczdkN1R0NFo1Yy9vZ0QrUUY4a1Uw?=
 =?utf-8?B?dWEycDNJK0dUZnF1dHhoMkF4K2Niak03ZDdEdElrNWc2bFVmK3ROUEQ5eEs3?=
 =?utf-8?B?KzZ1YVVMTWNvTitNeDNHVTBwWFd1MHZmelpkYVFlNDIwRjZlVEFsSWZWSXE5?=
 =?utf-8?B?WUVXRlpiTVJnUDU5L084Z2NERVlvc0Y3N2xMci9BOXZKV21Ub3lSS2pKcU1M?=
 =?utf-8?B?YlhDMFd4SGthSTFtTEJKM2FqWVdCWllNUktaY3J3RS9NMDF6bnlSYi9URHBn?=
 =?utf-8?B?b0FuTGVXZGVMNGlQdjNRRGJMYmlERkF2OUppNnAwbFZTMUN4YWptWnNrdHJ1?=
 =?utf-8?B?RDZMS1pJeHRsTFVDZFpMdjIwZDd5dHd4bUJnSHlYK280NVZsOUFtQWxXTis0?=
 =?utf-8?Q?jNwxAFeHsAZ0hVNqtzcNkdY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1D6jDXAiQWVJf8bHffHhM1c+hMGYvg3UyoTMVC+PnH08bENQruEU41qvsmyMvbgEkyeQUSExo4RyQ32CfYXAoxYmOdJaprRtWgR7jTTC81MU45uAzfA1An7aukB+cfj1n9oTxRGcITl8cYQKa1CUPJ317wUfuqiSRH6uafRI5ZwtsBvhhHTc78hCUmeSLZlYQETGNmCgNu6HnaR09qet6B5rVYOaHrzx1F9srWgaJ+n5QY/8k8haY1EavcFM/hOtxYXI/gRnfGnZRWezKn9NqOZffczxQ/awoe9bFTXQqBIS3quIy12DaqkKu7Thggj2eKBPkrRo8GD6hfS6fYiESwPm2aEUYbPCsACrfLyWNwT88DYdhGKHsN5esxl2zLLLMuiiAc9oYzQ4ZjsefRZAySbHnorXYXkdRquwJYgi3hJClOc7ZTVwFbyVDxRLbPNBFuMfYxt1vvciXGNwF46KHE/HB4xhiJTZUfvTHjuUg89XLrgz0wbufKTOlAF0zQiP/8j37Iuo6r9/wZssl2sdxUc33oVIF1scVsR4P3inZ1WkXS6BMd//JTNC16eT/tdgVmxI+3T1MCeSUvUBB2ADa+pan69K7Uf+Ru2F1Urf7iQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d2fc8a-c1b3-4268-a77b-08dcb206d76d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 08:49:23.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR9tAHHe/Pt/3rWX2pbL7YHPV4JWBfMxCQeVW3+voO18T7ugvTcg8CwrBMVltZikOkZkn9IV3s8H7bC07bOTog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010053
X-Proofpoint-GUID: LIx9t9yoAyP2DLqRW_JuFPBlQ-RjKKzJ
X-Proofpoint-ORIG-GUID: LIx9t9yoAyP2DLqRW_JuFPBlQ-RjKKzJ

On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
> test_skb_cgroup_id_user allows testing skb cgroup id retrieval at different
> levels, but is not integrated in test_progs, so it is not run
> automatically in CI. The test overlaps a bit with
> cgroup_skb_sk_lookup_kern, which is integrated in test_progs and test
> extensively skb cgroup helpers, but there is still one major difference
> between the two tests which justifies the conversion:
> cgroup_skb_sk_lookup_kern deals with a BPF_PROG_TYPE_CGROUP_SKB (attached
> on a cgroup), while test_skb_cgroup_id_user deals with a
> BPF_PROG_TYPE_SCHED_CLS (attached on a qdisc)
> 
> Convert test_skb_cgroup_id_user into test_progs framework in order to run
> it automatically in CI. The main differences with the original test are the
> following:
> - rename the test to make it shorter and more straightforward regarding
>   tested feature
> - the wrapping shell script has been dropped since every setup step is now
>   handled in the main C test file
> - the test has been renamed for a shorter name and reflecting the tested
>   API
> - add dedicated assert log per level to ease test failure debugging
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Looks great! A few things below...

> ---
> The new test has been tested in a qemu environment:
> 
>   ./test_progs -a cgroup_ancestor
>   44      cgroup_ancestor:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> ---
>  tools/testing/selftests/bpf/.gitignore             |   1 -
>  tools/testing/selftests/bpf/Makefile               |   3 +-
>  .../selftests/bpf/prog_tests/cgroup_ancestor.c     | 159 ++++++++++++++++++
>  tools/testing/selftests/bpf/test_skb_cgroup_id.sh  |  67 --------
>  .../selftests/bpf/test_skb_cgroup_id_user.c        | 183 ---------------------
>  5 files changed, 160 insertions(+), 253 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index a45f11f81337..c46950d4ef53 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -20,7 +20,6 @@ test_sock
>  urandom_read
>  test_sockmap
>  test_lirc_mode2_user
> -test_skb_cgroup_id_user
>  test_flow_dissector
>  flow_dissector_load
>  test_tcpnotify_user
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 0ac0f9dbc2f8..057e6ba003f1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -138,7 +138,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
>  	test_xdp_vlan.sh test_bpftool.py
>  
>  # Compile but not part of 'make run_tests'
> -TEST_GEN_PROGS_EXTENDED = test_skb_cgroup_id_user \
> +TEST_GEN_PROGS_EXTENDED = \
>  	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
>  	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
>  	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
> @@ -292,7 +292,6 @@ CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
>  NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
>  
>  $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> -$(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
> new file mode 100644
> index 000000000000..796aa3af75e8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "cgroup_helpers.h"
> +#include "cgroup_ancestor.skel.h"
> +
> +#define VETH_PREFIX "test_cgid_"
> +#define VETH_1 VETH_PREFIX "1"
> +#define VETH_2 VETH_PREFIX "2"
> +#define CGROUP_PATH "/skb_cgroup_test"
> +#define NUM_CGROUP_LEVELS 4
> +#define WAIT_AUTO_IP_MAX_ATTEMPT 10
> +#define DST_ADDR "ff02::1"
> +#define DST_PORT 1234
> +#define MAX_ASSERT_NAME 32
> +
> +struct test_data {
> +	struct cgroup_ancestor *skel;
> +	struct bpf_tc_hook qdisc;
> +	struct bpf_tc_opts tc_attach;
> +};
> +
> +static int send_datagram(void)
> +{
> +	unsigned char buf[] = "some random test data";
> +	struct sockaddr_in6 addr = { .sin6_family = AF_INET6,
> +				     .sin6_port = htons(DST_PORT),
> +				     .sin6_scope_id = if_nametoindex(VETH_1) };
> +	int sock, n;
> +
> +	if (!ASSERT_EQ(inet_pton(AF_INET6, DST_ADDR, &addr.sin6_addr), 1,
> +		       "inet_pton"))
> +		return -1;
> +
> +	sock = socket(AF_INET6, SOCK_DGRAM, 0);
> +	if (!ASSERT_OK_FD(sock, "create socket"))
> +		return sock;
> +
> +	n = sendto(sock, buf, sizeof(buf), 0, (const struct sockaddr *)&addr,
> +		   sizeof(addr));
> +	if (!ASSERT_EQ(n, sizeof(buf), "send data"))
> +		return n;
> +
> +	return 0;
> +}
> +
> +static int wait_local_ip(void)
> +{
> +	char *ping_cmd = ping_command(AF_INET6);
> +	int i, err;
> +
> +	for (i = 0; i < WAIT_AUTO_IP_MAX_ATTEMPT; i++) {
> +		err = SYS_NOFAIL("%s -c 1 -W 1 %s%%%s", ping_cmd, DST_ADDR,
> +				 VETH_1);
> +		if (!err)
> +			break;
> +	}


thinking about the risks of CI flakiness, would a small sleep between
checks be worth doing here?
> +
> +	return err;
> +}
> +
> +static int setup_network(struct test_data *t)
> +{
> +	int ret;
> +
> +	SYS(fail, "ip link add dev %s type veth peer name %s", VETH_1, VETH_2);
> +	SYS(fail, "ip link set %s up", VETH_1);
> +	SYS(fail, "ip link set %s up", VETH_2);
> +
> +	ret = wait_local_ip();
> +	if (!ASSERT_EQ(ret, 0, "wait local ip"))
> +		goto fail;
> +
> +	memset(&t->qdisc, 0, sizeof(t->qdisc));
> +	t->qdisc.sz = sizeof(t->qdisc);
> +	t->qdisc.attach_point = BPF_TC_EGRESS;
> +	t->qdisc.ifindex = if_nametoindex(VETH_1);
> +	if (!ASSERT_NEQ(t->qdisc.ifindex, 0, "if_nametoindex"))
> +		goto cleanup_interfaces;
> +	if (!ASSERT_OK(bpf_tc_hook_create(&t->qdisc), "qdisc add"))
> +		goto cleanup_interfaces;
> +
> +	memset(&t->tc_attach, 0, sizeof(t->tc_attach));
> +	t->tc_attach.sz = sizeof(t->tc_attach);
> +	t->tc_attach.prog_fd = bpf_program__fd(t->skel->progs.log_cgroup_id);
> +	if (!ASSERT_OK(bpf_tc_attach(&t->qdisc, &t->tc_attach), "filter add"))
> +		goto cleanup_qdisc;
> +
> +	return 0;
> +
> +cleanup_qdisc:
> +	bpf_tc_hook_destroy(&t->qdisc);
> +cleanup_interfaces:
> +	SYS_NOFAIL("ip link del %s", VETH_1);
> +fail:
> +	return 1;
> +}
> +
> +static void cleanup_network(struct test_data *t)
> +{
> +	bpf_tc_detach(&t->qdisc, &t->tc_attach);
> +	bpf_tc_hook_destroy(&t->qdisc);
> +	/* Deleting first interface will also delete peer interface */
> +	SYS_NOFAIL("ip link del %s", VETH_1);
> +}
> +
> +static void check_ancestors_ids(struct test_data *t)
> +{
> +	__u64 actual_ids[NUM_CGROUP_LEVELS], expected_ids[NUM_CGROUP_LEVELS];
> +	char assert_name[MAX_ASSERT_NAME];
> +	__u32 level;
> +	int err;
> +
> +	expected_ids[0] = get_cgroup_id("/.."); /* root cgroup */
> +	expected_ids[1] = get_cgroup_id("");
> +	expected_ids[2] = get_cgroup_id(CGROUP_PATH);
> +	expected_ids[3] = 0; /* non-existent cgroup */
> +
> +	for (level = 0; level < NUM_CGROUP_LEVELS; level++) {
> +		err = bpf_map__lookup_elem(t->skel->maps.cgroup_ids, &level,
> +					   sizeof(level), &actual_ids[level],
> +					   sizeof(__u64), 0);

could probably simplify this + the BPF prog using a global array of
actual_ids[], then compare it to the expected values using
skel->bss->actual_ids

> +		if (!ASSERT_OK(err, "read map"))
> +			continue;
> +		snprintf(assert_name, MAX_ASSERT_NAME,
> +			 "ancestor id at level %d", level);
> +		ASSERT_EQ(actual_ids[level], expected_ids[level], assert_name);
> +	}
> +}
> +
> +void test_cgroup_ancestor(void)
> +{
> +	struct test_data t;
> +	int cgroup_fd;
> +
> +	t.skel = cgroup_ancestor__open_and_load();
> +	if (!ASSERT_OK_PTR(t.skel, "open and load"))
> +		return;
> +
> +	if (setup_network(&t))
> +		goto cleanup_progs;
> +
> +	cgroup_fd = cgroup_setup_and_join(CGROUP_PATH);
> +	if (cgroup_fd < 0)
> +		goto cleanup_network;
> +
> +	if (send_datagram())
> +		goto cleanup_cgroups;
> +
> +	check_ancestors_ids(&t);
> +
> +cleanup_cgroups:
> +	cleanup_cgroup_environment();
> +cleanup_network:
> +	cleanup_network(&t);
> +cleanup_progs:
> +	cgroup_ancestor__destroy(t.skel);
> +}
> diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
> deleted file mode 100755
> index d7dad49175c2..000000000000
> --- a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2018 Facebook
> -
> -set -eu
> -
> -wait_for_ip()
> -{
> -	local _i
> -	echo -n "Wait for testing link-local IP to become available "
> -	for _i in $(seq ${MAX_PING_TRIES}); do
> -		echo -n "."
> -		if $PING6 -c 1 -W 1 ff02::1%${TEST_IF} >/dev/null 2>&1; then
> -			echo " OK"
> -			return
> -		fi
> -		sleep 1
> -	done
> -	echo 1>&2 "ERROR: Timeout waiting for test IP to become available."
> -	exit 1
> -}
> -
> -setup()
> -{
> -	# Create testing interfaces not to interfere with current environment.
> -	ip link add dev ${TEST_IF} type veth peer name ${TEST_IF_PEER}
> -	ip link set ${TEST_IF} up
> -	ip link set ${TEST_IF_PEER} up
> -
> -	wait_for_ip
> -
> -	tc qdisc add dev ${TEST_IF} clsact
> -	mkdir -p /sys/fs/bpf/${BPF_PROG_PIN}
> -	bpftool prog loadall ${BPF_PROG_OBJ} /sys/fs/bpf/${BPF_PROG_PIN} type tc
> -	tc filter add dev ${TEST_IF} egress bpf da object-pinned \
> -		/sys/fs/bpf/${BPF_PROG_PIN}/${BPF_PROG_NAME}
> -
> -	BPF_PROG_ID=$(tc filter show dev ${TEST_IF} egress | \
> -			awk '/ id / {sub(/.* id /, "", $0); print($1)}')
> -}
> -
> -cleanup()
> -{
> -	ip link del ${TEST_IF} 2>/dev/null || :
> -	ip link del ${TEST_IF_PEER} 2>/dev/null || :
> -	rm -rf /sys/fs/bpf/${BPF_PROG_PIN}
> -}
> -
> -main()
> -{
> -	trap cleanup EXIT 2 3 6 15
> -	setup
> -	${PROG} ${TEST_IF} ${BPF_PROG_ID}
> -}
> -
> -DIR=$(dirname $0)
> -TEST_IF="test_cgid_1"
> -TEST_IF_PEER="test_cgid_2"
> -MAX_PING_TRIES=5
> -BPF_PROG_PIN="cgroup_ancestor"
> -BPF_PROG_OBJ="${DIR}/${BPF_PROG_PIN}.bpf.o"
> -BPF_PROG_NAME="log_cgroup_id"
> -BPF_PROG_ID=0
> -PROG="${DIR}/test_skb_cgroup_id_user"
> -type ping6 >/dev/null 2>&1 && PING6="ping6" || PING6="ping -6"
> -
> -main
> diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
> deleted file mode 100644
> index ed518d075d1d..000000000000
> --- a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
> +++ /dev/null
> @@ -1,183 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2018 Facebook
> -
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -
> -#include <arpa/inet.h>
> -#include <net/if.h>
> -#include <netinet/in.h>
> -#include <sys/socket.h>
> -#include <sys/types.h>
> -
> -
> -#include <bpf/bpf.h>
> -#include <bpf/libbpf.h>
> -
> -#include "cgroup_helpers.h"
> -
> -#define CGROUP_PATH		"/skb_cgroup_test"
> -#define NUM_CGROUP_LEVELS	4
> -
> -/* RFC 4291, Section 2.7.1 */
> -#define LINKLOCAL_MULTICAST	"ff02::1"
> -
> -static int mk_dst_addr(const char *ip, const char *iface,
> -		       struct sockaddr_in6 *dst)
> -{
> -	memset(dst, 0, sizeof(*dst));
> -
> -	dst->sin6_family = AF_INET6;
> -	dst->sin6_port = htons(1025);
> -
> -	if (inet_pton(AF_INET6, ip, &dst->sin6_addr) != 1) {
> -		log_err("Invalid IPv6: %s", ip);
> -		return -1;
> -	}
> -
> -	dst->sin6_scope_id = if_nametoindex(iface);
> -	if (!dst->sin6_scope_id) {
> -		log_err("Failed to get index of iface: %s", iface);
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
> -static int send_packet(const char *iface)
> -{
> -	struct sockaddr_in6 dst;
> -	char msg[] = "msg";
> -	int err = 0;
> -	int fd = -1;
> -
> -	if (mk_dst_addr(LINKLOCAL_MULTICAST, iface, &dst))
> -		goto err;
> -
> -	fd = socket(AF_INET6, SOCK_DGRAM, 0);
> -	if (fd == -1) {
> -		log_err("Failed to create UDP socket");
> -		goto err;
> -	}
> -
> -	if (sendto(fd, &msg, sizeof(msg), 0, (const struct sockaddr *)&dst,
> -		   sizeof(dst)) == -1) {
> -		log_err("Failed to send datagram");
> -		goto err;
> -	}
> -
> -	goto out;
> -err:
> -	err = -1;
> -out:
> -	if (fd >= 0)
> -		close(fd);
> -	return err;
> -}
> -
> -int get_map_fd_by_prog_id(int prog_id)
> -{
> -	struct bpf_prog_info info = {};
> -	__u32 info_len = sizeof(info);
> -	__u32 map_ids[1];
> -	int prog_fd = -1;
> -	int map_fd = -1;
> -
> -	prog_fd = bpf_prog_get_fd_by_id(prog_id);
> -	if (prog_fd < 0) {
> -		log_err("Failed to get fd by prog id %d", prog_id);
> -		goto err;
> -	}
> -
> -	info.nr_map_ids = 1;
> -	info.map_ids = (__u64) (unsigned long) map_ids;
> -
> -	if (bpf_prog_get_info_by_fd(prog_fd, &info, &info_len)) {
> -		log_err("Failed to get info by prog fd %d", prog_fd);
> -		goto err;
> -	}
> -
> -	if (!info.nr_map_ids) {
> -		log_err("No maps found for prog fd %d", prog_fd);
> -		goto err;
> -	}
> -
> -	map_fd = bpf_map_get_fd_by_id(map_ids[0]);
> -	if (map_fd < 0)
> -		log_err("Failed to get fd by map id %d", map_ids[0]);
> -err:
> -	if (prog_fd >= 0)
> -		close(prog_fd);
> -	return map_fd;
> -}
> -
> -int check_ancestor_cgroup_ids(int prog_id)
> -{
> -	__u64 actual_ids[NUM_CGROUP_LEVELS], expected_ids[NUM_CGROUP_LEVELS];
> -	__u32 level;
> -	int err = 0;
> -	int map_fd;
> -
> -	expected_ids[0] = get_cgroup_id("/..");	/* root cgroup */
> -	expected_ids[1] = get_cgroup_id("");
> -	expected_ids[2] = get_cgroup_id(CGROUP_PATH);
> -	expected_ids[3] = 0; /* non-existent cgroup */
> -
> -	map_fd = get_map_fd_by_prog_id(prog_id);
> -	if (map_fd < 0)
> -		goto err;
> -
> -	for (level = 0; level < NUM_CGROUP_LEVELS; ++level) {
> -		if (bpf_map_lookup_elem(map_fd, &level, &actual_ids[level])) {
> -			log_err("Failed to lookup key %d", level);
> -			goto err;
> -		}
> -		if (actual_ids[level] != expected_ids[level]) {
> -			log_err("%llx (actual) != %llx (expected), level: %u\n",
> -				actual_ids[level], expected_ids[level], level);
> -			goto err;
> -		}
> -	}
> -
> -	goto out;
> -err:
> -	err = -1;
> -out:
> -	if (map_fd >= 0)
> -		close(map_fd);
> -	return err;
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	int cgfd = -1;
> -	int err = 0;
> -
> -	if (argc < 3) {
> -		fprintf(stderr, "Usage: %s iface prog_id\n", argv[0]);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	/* Use libbpf 1.0 API mode */
> -	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
> -
> -	cgfd = cgroup_setup_and_join(CGROUP_PATH);
> -	if (cgfd < 0)
> -		goto err;
> -
> -	if (send_packet(argv[1]))
> -		goto err;
> -
> -	if (check_ancestor_cgroup_ids(atoi(argv[2])))
> -		goto err;
> -
> -	goto out;
> -err:
> -	err = -1;
> -out:
> -	close(cgfd);
> -	cleanup_cgroup_environment();
> -	printf("[%s]\n", err ? "FAIL" : "PASS");
> -	return err;
> -}
> 

