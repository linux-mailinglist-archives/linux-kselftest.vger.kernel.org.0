Return-Path: <linux-kselftest+bounces-20987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB0E9B4F6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA04284442
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A4E199E84;
	Tue, 29 Oct 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ls0DyfU5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ihCPClQh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21F19341F;
	Tue, 29 Oct 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219771; cv=fail; b=fhPPE9wAkfTS3NE39KiLKd7mK8gGGaWUrNnReBX+p3tlSYIfHRpLqVc52t4zSzJE5nklWfLHKCpxH1PozDdpXTf+41dSSQO02pA/7gP4BGM+YT7voRWLeGRdjUtdSIZhynzy+eN6QQu34vARXgT7hX75+IWe2428bMG94a/EY4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219771; c=relaxed/simple;
	bh=lvHpVRDW4cwiNX/sKfDU9yDzp+wE0KSE21rU8a16c6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qy8hh1xb3Rr6CtaP+lh8I5jHbNt10QawFtFuSnvgOXJNKA6kNzelmjj9lTgbHj1nKLI8VnrR8e4mRKL538BrBnYGXME9U/p5aUdNLyyDrfdzY/SYfIvWYY03u9iPyPbT9wo2S4uhJm9KGcHH+nuB+O5zfAaeGnt2vzGmDgxXzSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ls0DyfU5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ihCPClQh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEtivl008726;
	Tue, 29 Oct 2024 16:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KEpc3ClF9QzcbrSNw3jRoaeCFVn/UJ6A+wfw0S1QTnk=; b=
	Ls0DyfU5ASUpHlxuTa11m5BCP1r3fBaH933/smDwJljSqiE+8hN/WZD8LzOqYp4D
	85+09MdYGWNCq7caYZvPzxGagUKvL80jm2fsx99ikUR+cNxDHRTd3dMi3QBbexpt
	N5GwEaw2+sR6n00jfnWjvWahvxnX8HJV49aWWkCXqcGEHHJxKoILIgEIga4pbKch
	3k2M5YHYycSZTn8ZZSszEbzwqx8iZc2jT5xn5Yjygj+eglCLQKGC6FDZoVhuzgzs
	7YbWkVhjJclk1ETSjh0FQFGJlIZXoBPJ7WBwHBSClS7iTQsr2dM1+USqeHpV1E8L
	jwEPR8NvUCJnpKCExYqHMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwdydw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 16:35:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGU6JE004792;
	Tue, 29 Oct 2024 16:35:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2uhcwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 16:35:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4vNRQKceV2qM/TxbER66wM4rKsbw+oZHNVQJDCkxUelxNjLdNrWW5F/Z5x4wfdlajWL3Tc/VNrTx8cWx05xpuuAcPExf/Z6UfqApDJyevjx4OauMajY9x3cYEoAEm8CuHF2czydE9mN2isBN02b/ZWQ73/EHXcCrXSjMzxoI0ASPVcVEIq8ceAGMVTxGCbOWpFow83YHLtXh74spily0x4rLj/lpcrgQLldmoARkR1QXkqZLl1NixjuzdhMY0N8sg3okF2HVKn+aLK1UjdyJVh5HCf384zpmEKXWtv39BEGagDDy9AZMosAtns4X7YpS4S6JRWq9pEh5UgeKTJKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEpc3ClF9QzcbrSNw3jRoaeCFVn/UJ6A+wfw0S1QTnk=;
 b=vbTWNmBk/uJV5xHJSR9vp/Cvbmc58YFwrDs4jW2+5SCncpsxn07VGgrf2whMHdAlWw/ZyMHa8+0QO5kobUhQIvJRpInRxQ7D/RtBKQo12e1INh8I/ecF09SRRJ4iFoAm95RfaUZvT9GD7lX0gp+D8tC5XAOJBc/wxAUrDLIHpw2qMMZqk5J+ax0s+9U7HhhFGrpPfRqYH/SDCWidGPW1fhpxzFP2138BdpM6pw1/ke1mnJTr8jSa+exjnHjlvupbvmcIGnDY3PJnMdVLrSI/BgzJlxnEezOc3TSYIH6EZ2Mu1gqdRgVc5nfqqP+779Ko8LZ/GDNBQ5lz3qqKpJC90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEpc3ClF9QzcbrSNw3jRoaeCFVn/UJ6A+wfw0S1QTnk=;
 b=ihCPClQhDVFTHEGLoJVGriLmZRmnpMiZV/JBbU3qhQFpMRMogCkgCPjBKMGZxgpzRaAJuQYvWLYHlW93/mn4CKCZlkrilpBleotyVtY9HjwTH7Ep/WQ2w+tV2jbnx6LzB/sMyuue8pBhFQxwILxG0p6dwOsH9K1pixg52HOfdj4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB7409.namprd10.prod.outlook.com (2603:10b6:610:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 16:35:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 16:35:25 +0000
Message-ID: <18b278a3-3bae-434c-924d-b539fab1726e@oracle.com>
Date: Tue, 29 Oct 2024 16:35:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: handle implicit declaration of function
 gettid in bpf_iter.c
To: Jason Xing <kerneljasonxing@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
References: <20241029074627.80289-1-kerneljasonxing@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241029074627.80289-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9663dd-b401-4e99-2e35-08dcf837b083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXJyb2E3dHZGQVMrZ1ZlTHQ3N051SGZXZm92b3JDVll5bnF6dkRoT1lJOTUz?=
 =?utf-8?B?VHl4aDNHUmtvU0NvU2EwTys0T21meG91dWFrNW13YXdqUjhST0owL1l3aWkx?=
 =?utf-8?B?YldhRHR3eWJVNHQ4RmtBN2lHYmpHam5FREtFQUE4V1VNdHZ3T0F2Y2J4SWlP?=
 =?utf-8?B?V2MySzN5TE1WM0huWEI0Z1lwTjduclY0QzNtRCtZd2E5RThhSVlieGh2MUow?=
 =?utf-8?B?dk5BWmZzUGk4S0pCWFRxRCt1NXhIU1FUek9veEd1UXdKTFp6N0M0ejQ3L3cy?=
 =?utf-8?B?MVRnam1ONTlMdVdxejJtTmlhY2kxRTR4a2tqM3FCbEt4eTNVREVQNm9HcGw1?=
 =?utf-8?B?M0xaVXk5bkFhaDdDK2lCa1hNZWFMYmY1QUVtOHM5QVVHQklPbGhzU256WWpR?=
 =?utf-8?B?cnl4Zlc4YXI1U0l5eG1QeWp1Z2VWNFZ5eTFNakc3Mm50cUJMalJOWjY5dHBq?=
 =?utf-8?B?bXhLTE0xdHlOYVAxRGZ3V01lSkl1WVJKeDhtTU5rQzk4V3NjL05VWmVHYWZF?=
 =?utf-8?B?STZFYmJwZG5ONmxBdVJITUw0ZFhDSWVndS9EbitRWlFvczdleXdSbGZEV1R1?=
 =?utf-8?B?SXMwK1RNQjNMaUJubHdhOVFtRldDUmNjNmF4eXA3WU4waTNxRHc3ZHRKNkd1?=
 =?utf-8?B?NlNZSWJucHJtanVibDRNd1ZhdFBTWEV3Wkw2YWRDQWdDUkQwSmlDQXZRanBz?=
 =?utf-8?B?b3V1UDY1YXZ2dS9tYWdRZ2VMYzgyRGdzdU5jZ1ZxV3NuWnhHTWRmVXlQTXQy?=
 =?utf-8?B?VHZFUG9pd01UUGd6OEk5cEVCM25oeEsyYS9OMEdCWUE1anNUd1BFeEFxUDFu?=
 =?utf-8?B?cnIrV0trRGhqbVlJZXFxRGI4TFVJTnI5QmV6R2hIelhiYk5WYmZxaGJhS1Ro?=
 =?utf-8?B?cGVrUG5QdTF6Y2NUamhucm9YS01TVXdPMWhsdUlKT296MEp6UUZDanFBMW9h?=
 =?utf-8?B?dVdmSC9OT1RESlVRZlo3YUVzTXZsTmNKb1o4eTZPbVh0N2taZyt6NllnMjdy?=
 =?utf-8?B?V1BXeFZWYlNpdEl1R090M1oxUnNEYXZBWHZkZ0tNS3ZnSWpXU0JPaDNpdmZr?=
 =?utf-8?B?K0ZPWEhuSTZEdmZLMzZUTit3M3JJZXZhajc4YkdvUHZua0dTOHpNa2JQSE1v?=
 =?utf-8?B?Uis1N1NQcGo3UjhoaWJKYXA5L2hhQkxVTHplUjFXMVNqVWVoV1lCcDNVVnBM?=
 =?utf-8?B?dmFnSTN3a2ZUN2JFd1hQTnU1aFowRmo3NXJ3QWhQb1JXV0dWYVZlYS9SaTNj?=
 =?utf-8?B?Mk43Y2xBUUJuRGRFS05SWS9POWpnQWVsNTVHSkFQMW5yaTVMeE1HbEhBUGJN?=
 =?utf-8?B?aEFBS3dnQ29hR2EyeXREQVhydm5VMTNQQ3A4elhxLzBUT0dMNUpBbXh3UnVM?=
 =?utf-8?B?am1FN0ZNT2paL0Y2V00yblE2dG1xYWkwMUk0bUhHa055bjNrREtWQ3BYWE15?=
 =?utf-8?B?WXhqWkxRZHI3U0ZleTBKb2JGZEFSV0NXK2JEMlNIQWlRWEVoSzZhVXAzZUd0?=
 =?utf-8?B?SFVxRCtLM3BSR0hZVlp3Q1Y1U2ZCWHBhUzFiZWNhNmdoeE8wTVFiSjlOV0JH?=
 =?utf-8?B?NU8wSWptdnJFYmEvMVB6eW5yeU1wYjk5OXBLMHIvL0FRTm5TczhGdFM2Zi9L?=
 =?utf-8?B?dXllYWh3cmtqUlQzN09VNENXaUNaK2pKUFpKaXlvSUJmMGNzeDFOMlA5V0RP?=
 =?utf-8?B?ejlidlhYQXRFMzVTM3FLQ2lqenFidGpucXlYVlJWRm1ZTGRMSEViM3ovbXMr?=
 =?utf-8?B?VGFaVXpvQmNFaTZONG55bjVabEJ3K2V2Z3F6bXE3NngzSkdTM01jRjU5Mk13?=
 =?utf-8?Q?brKYPCtRCqH1OByMgxHXrhd0avoLt8CMjrxaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW1kSnFUTG5sRWdvcjdNVGZuaGQvU1dGQkRvRXFuTnBTbjc4Nkl6QlJ6Sko4?=
 =?utf-8?B?a3hOQ1U1UGpObHFQeDFqcnVCU3kzaitVdHcrTWZaN2svVmRJckYwZlRjay9y?=
 =?utf-8?B?RElBRHREVXpjc090MDZhbFdqejIzTGFvTVBsL1BrMEE1RHRNZ3BtSFV4YWNO?=
 =?utf-8?B?RXVJdzRYbW5zaytzb09NRm56QWFrd2hHb2M1eUhqNkZ5dEpzVG4xajJXMExi?=
 =?utf-8?B?QXBzVm1jZTRobHFjNjRPc3MwZkJjSWlYem9xcjVrci9IeXNiUDMzTlRndDFy?=
 =?utf-8?B?NTVlVW5wRWpJeE5LbkhscFIvcUpHSWwxbmNMSkNTbVBhM00yK2ZkeFFlTWJ0?=
 =?utf-8?B?YVg4NGUzZG5Qc0Q2Q2FmZ2syUmV0R1pZYXpNdk4yR2xFNG5jSjluNVM2V05Z?=
 =?utf-8?B?T2t2STNKZERpY0ZCNktxYTZQNWpuSGVrWUZhdmNJUHVpeGl0ekZzeS9oMzNr?=
 =?utf-8?B?NFRXbmhWTmZqQzZXcHNicXhpeHhpSnlzdHFUMkt3d3FBNHVWNytTQTl6MWw4?=
 =?utf-8?B?YmNiRkVMU28xc0F1OWNXeTJ4T2VPV05EQkFtUWpUMWt3cWVHNWdoWnpuc2t0?=
 =?utf-8?B?MVlRU3QwUElaSFc5US95d3h3VkV6eElidWFWMzlVT1JBUm00dm90anArRyti?=
 =?utf-8?B?M2MzYXVyU0NKRll5ZCtwSm96UW10aHp1OEVIRFdVUXkvK0RCRXFheWNrMTlk?=
 =?utf-8?B?Y25ERk0vekN2TU9BM0VZTmRzdklJeFExQUpyUlB2elNaUWx3eEM5TmcxUnlu?=
 =?utf-8?B?OHh2YkdlK3dzWWhIVStQS0NCZDVqemlUNnhXN0FjM1FPOEtORzhYV3FnbWtF?=
 =?utf-8?B?dzYzYzdDbnViVW5NT1UvWkkwcFJtRlFIMk03dUNFRk5KaTF3ejNjK3dNY2c3?=
 =?utf-8?B?bTNNTnNDcmZDQ3RCR0wzeUt2Wi8yL2g1MnJ1Q1pSWmlBRCtMUXV2K2lNeGNv?=
 =?utf-8?B?WGhXZXNUcndZOGwwbkJiRFhleFI5TkFqRldDaTdEbUVNb1hYMHhjWFBGRmhQ?=
 =?utf-8?B?ZFdVME50YTRlSUw3a251Z0labmVIR2RtMzF3ODhYZCtoTmxkb1FSa0VvTnBB?=
 =?utf-8?B?cjRldXpaNlNLQzVkMXM0M3F1UEpoZjdjd2NyWkhZQjBjbGM2ZWJadk9QWjZU?=
 =?utf-8?B?c0wyOWI5Y0hQOGxwZ2lNNm9ySW1XM3R5RUR3aWcrbXlpODE1SVM0SThIUldT?=
 =?utf-8?B?QzBVQXdxN0VYQUNOTzRsWmxQVnRIQnVoVy9CTEVyL1JXRC9xdkVxNjZOME1s?=
 =?utf-8?B?MHB5OHRZMjJFeHc2ZTN5RFJUMUszc2pscVBrak9hMzI5MzdvejFDK041ZWhL?=
 =?utf-8?B?NjJuWFF6Y2tEU2ZwMVAxaFROQ2RTbUdDSyt3dlhJYTREU1Z1Q1lkU3FrTVM5?=
 =?utf-8?B?aU90dmdEelkrbnRZNU1MVzJUdTRHby9WMzNzRlU5R21sYW11OEdwSUI0cXhM?=
 =?utf-8?B?RlFFMUdzL04xeEJrOGFFc25OUXZlV3FuUXJjVDg2dzZDWTBlUllxSE5KK3My?=
 =?utf-8?B?bUlFakN1Y1hFeHd0VkhsRDduNFp0Y3U0YVRhRFlzQ2lRNkNtOEtXNlZweTl5?=
 =?utf-8?B?UDhkbHpJTWUzWXF5Q3NmZTVrdG1IcThvNC9EWTZIYSs4dmhvL0srSStUb2NT?=
 =?utf-8?B?NnBFdXRiL2lQY0l4dnpPdjhXVWdNN2FRM2YzRzd4VVZsUEZzQUNkOExNald1?=
 =?utf-8?B?Q0FsNUFCMlY3SzI3SkJURUM4RmVtZ2NpUlVwWFJEdU80cUxDMWk2UUxyZ1ZG?=
 =?utf-8?B?SU5BOVpDQW5qclpJMDh5RFpKK0JrQnBrOTZsSWRoZXJ5b0hSUGRBaUwwSWZs?=
 =?utf-8?B?Y28xVFMxQ1NoeFlWWDFEb0pHdHhSYkd0a01DcFk2enY4UENuUWxzUFRoNXda?=
 =?utf-8?B?dmxqWW1mTWdqc1c1eUtIQkJ4K2JDbm9ic2gwZmhuTEdtRktXclFiUDRxRXNQ?=
 =?utf-8?B?bUY1UjhjVHRXWmo1OHpISWljM2cyQkxKNi9Zd0ZxTkUxbnVucEcrbHgxY0t1?=
 =?utf-8?B?ODRSb25rOVd5RHQxckpXUVZDZ0h2YlRxc21oLzRiRHFwZmFxd2JmSlJiVmdn?=
 =?utf-8?B?MU8xWVE4R1RHSDlpNmFGUnpJU21xcVFaQkY0aERmQ2J6N1ZKcG9nUGlOakVB?=
 =?utf-8?B?eTd3d09jYXV2RnU2NDNOSE9Mb0IySE4xNmI5b2EyL3ZURzNnRTdSR2dFczJM?=
 =?utf-8?Q?PeVt3jo0y8BLGV7LrLI1kZQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IDEQvEQv7cEr5XLPts8nlAtJm+dYS9z03w+sAte6tM7zX8SUs5FpDBvZbFnWZhJb9RqXqhIQxP5ciOEZvpMGCgDXWUgyVNwbaM82hYN5odXegjcCIWEI0ov3ttLz8dEIXihhVceNzTm47M+LXdItdqXf+PQNlOxAom4uugMS26+pKHwIaJPB4qqk2H4kjr4qAlaTRobQy1ElRjvC20D4eiSl4oVgIjTYq7xjLwcGuv4GFqCJkBCvX71yhTKvn4V+1JpZRWKWuBnk49xGMe968EF2lSNr0YYRfGo5IiHdnpZcJNLUAs4uUMnqFnGiqmmZK3nXst7qr2uf7aT0AdTyf0g4sy3sjuizfS6jrCAcKIXH00K8g0J7G58vYdzQRxSpIwPqeAv/e2XSCf33u7lEP6fxXMpYeCBNfLQYtEfXBr9ldm5Oi9Tg6/HlLDw0HUkez4RUA4ofQKgbH6YFDS0VmFj1z1PB7SsRiTKCwaWcYkcK2VS9aUrLxzCi/D0v4zotjVwMQUblYGkofiw4cEHBfIPjDGWkJHSSblSdsdPpZoFhW68O1uDcavqF3haO1wHhQCODcXlj18OgDJoqgU6uw6X0pV0z5Sspffzleuq32Bs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9663dd-b401-4e99-2e35-08dcf837b083
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:35:25.0873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlvugFrPk5YnHJZqQ2XviR0hkzUYcmNrRgDmcBymwqM5OA9cppuqA7LB7bHh/+qgnJzPeXBvMK6au5ilgwmSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7409
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_12,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290127
X-Proofpoint-ORIG-GUID: FHYav5os0Rjfh64l6rOqDRwHBUGZ9nQB
X-Proofpoint-GUID: FHYav5os0Rjfh64l6rOqDRwHBUGZ9nQB

On 29/10/2024 07:46, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> As we can see from the title, when I compiled the selftests/bpf, I
> saw the error:
> implicit declaration of function ‘gettid’ ; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
>   skel->bss->tid = gettid();
>                    ^~~~~~
>                    getgid
> 
> Directly call the syscall solves this issue.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> v2
> Link: https://lore.kernel.org/all/20241028034143.14675-1-kerneljasonxing@gmail.com/
> 1. directly call the syscall (Andrii)
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index f0a3a9c18e9e..9006549a1294 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -226,7 +226,7 @@ static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
>  	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
>  		  "pthread_create");
>  
> -	skel->bss->tid = gettid();
> +	skel->bss->tid = syscall(SYS_gettid);
>  
>  	do_dummy_read_opts(skel->progs.dump_task, opts);
>  
> @@ -255,10 +255,10 @@ static void *run_test_task_tid(void *arg)
>  	union bpf_iter_link_info linfo;
>  	int num_unknown_tid, num_known_tid;
>  
> -	ASSERT_NEQ(getpid(), gettid(), "check_new_thread_id");
> +	ASSERT_NEQ(getpid(), syscall(SYS_gettid), "check_new_thread_id");
>  
>  	memset(&linfo, 0, sizeof(linfo));
> -	linfo.task.tid = gettid();
> +	linfo.task.tid = syscall(SYS_gettid);
>  	opts.link_info = &linfo;
>  	opts.link_info_len = sizeof(linfo);
>  	test_task_common(&opts, 0, 1);


