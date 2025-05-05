Return-Path: <linux-kselftest+bounces-32382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A0AA973F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C427ACEAF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4326A097;
	Mon,  5 May 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bd8TUch8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xe1cYfjq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6126A092;
	Mon,  5 May 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458196; cv=fail; b=UwGa5E3Yg1wjtSCk0U2wU9jC2ddlM7JpdEKqQAJO61qWTj+uf+OHfgNhmZhPwz0tr2Uq2csdHwz6+8Xh+ASwpQ4k3uFD03NtisR63DMJv131G4LMamsqNF4OwszmmwW++AjgKOKkMX44BtKEK1c+d8phqxml9HuJkpZC9vA75dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458196; c=relaxed/simple;
	bh=XVAFElvE3BlbE5QVcyE2d0UGL/uZoGPbkwlScjxon7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ac1neTc/7e1SqwX7nRBa4BpmQZqgMa+3+i9DTY3pTVmjoqm7InnryQHo54hT65tS5D5PsQrLBC8g7WfKtLym2BrzJ9DfEbAAUh1mX8+nth50N4a0Y5FQ6wkIO/vY/bmVCQy5G3L7yLUgnzOoROhSLJ/upQfmrYSJu2/sSaYNnLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bd8TUch8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xe1cYfjq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545F6sUo017684;
	Mon, 5 May 2025 15:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=siv7gW6VEkJ8chYGEDBxmzUpE6Jlo1E2Xhv90fcwzA0=; b=
	Bd8TUch8LiIECquOt8rjOHyuEK2swI21WErq0vO79QJfxpLoII4FsMbX8H3+JUEM
	OdezFT+w/Bm/tTcYmOGdBEMcNSJX0bNGb5gMAKSIfCA4BjftZOpCXFWJNeh6vidJ
	8JMOchbrvfSQ2eSEg1uFmZowAdT4m2WtF8cRE5qMSOwKH1uIoRdDy7uGIGgdoZAm
	N8/CfN/RRi2rvxtxpe2BrfvietBYULM3Y227XyHdfVdubgysWAC8gIj5nGKTpVrB
	oC9SgbhUSXhn5czn9jPTONWI8nzJ9Twfpm9cSKaGaQx2fMJSNwKIso7Y5X89KL1Z
	Iyrl7lie8DBoerjesKZekQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46eyp8g0rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 15:14:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545DYxls035335;
	Mon, 5 May 2025 15:14:28 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013076.outbound.protection.outlook.com [40.93.6.76])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7th5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 15:14:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0zCE5BDePvDCkMQojjlbh7Gp6SYYwng+nuVJz3c1Nb8DaNdOVe0ETHXNKeeImlyKpE646XkGwYWt+82yjhpbnUuxpjOB3CjVhS6PyM93uKtZARljlSTpAJcIhApdrvOHC1ImeEA6m11GZ2jSAiZKR7m5Ks/qJno6hmFi0528Hk5c5vhTMWRHdfugKi7bdLOaQgxdc1qww55+JvL7+fRHEB83k7M6euxOuSrZd7RThl2X7AC4C1SOlB78gWG1AVXDXf713CidPj1beWRNHbXEtf4TxlfyTW9EFsIVAngPKL6g1ryUxLfVe5HZu3pkFwAbD5F8UkieBm7I7mppcrGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siv7gW6VEkJ8chYGEDBxmzUpE6Jlo1E2Xhv90fcwzA0=;
 b=OcuLQ+CLwAtoT+T1wAK7IsJPgsEanQEW0t8QjFndlkhrHDa8T0+Dq5y9skMHzi1G+lx7IP/kzSim47qRT3b8ujNdxrjJoI7vQHrC9R6zFELWgeZybyRQ7qLMWSPCzRE2rxNVwNZ0avXpoInG098E+AJOSDZjGoBTsccMKG5qObBC0lyBNNvBz1FUQqzxyMFMCKVmB3A+jg17sXw+MGhHNvq4jH90X9+cfwLGqTe5c24zIx4iLDQgiIJWVVOYOsAFGRi7qCOoORNfHaX8yG7EZTa0bnztiOzuEYSHYZFlG9CYI7UqLGt434u3oGCpzfMqB9wYABRpNVux7eYy5S2WoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siv7gW6VEkJ8chYGEDBxmzUpE6Jlo1E2Xhv90fcwzA0=;
 b=Xe1cYfjqxbcYi4HBPwsam5gm8Zu/UExACrVII6dKAR6ws0G0+lurRfCoZA9tNfyXO2X3eRP9W48mX4HoXe4FaVjsSU+O2dpvRLfGpz755I9kqJLxJmH8XnK9C8941t4n6RbOv5hMVzAR2RVo46jTVf4UPW+is7OL+vxPKByFE9o=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6232.namprd10.prod.outlook.com (2603:10b6:8:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 15:14:25 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 15:14:24 +0000
Message-ID: <8a39f961-1f2e-4f99-9e7f-4d60f754b815@oracle.com>
Date: Mon, 5 May 2025 20:44:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 iproute2-next 1/1] tc: add dualpi2 scheduler module
To: chia-yu.chang@nokia-bell-labs.com, donald.hunter@gmail.com,
        xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
        pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
        stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        andrew+netdev@lunn.ch, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
        Oliver Tilmans <olivier.tilmans@nokia.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Henrik Steen <henrist@henrist.net>
References: <20250505094717.7177-1-chia-yu.chang@nokia-bell-labs.com>
 <20250505094717.7177-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250505094717.7177-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: e8703033-301d-4377-11e2-08dd8be784de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWk0TEp4d2dNWlZIN2MwYUN4VXB4cnpYTDdUemx4VUFIT280Ni9SZE5jM0p3?=
 =?utf-8?B?VHNkN0QxZjhkeUdkdm1VQm5mYStTY0xGVU9LTWVaRjlkcjlPZk0yd2poRkcw?=
 =?utf-8?B?eTNzN1pBa050S25SZmxRWWw4VVFLa3ZFei9JV3kyUE9HMXJaanJwcTJJQmVi?=
 =?utf-8?B?Mm5jM21JYUIzNG1LS1h2aGpDTnFwR2J0cS9uWFh5VitCdWovdUNxRTkxVEtY?=
 =?utf-8?B?ZS9yaUVZNkoyajA0SWlkcURtbHdvcCtjSUZJeXJTQ0xrT1RFMGtJY1l6Y3lU?=
 =?utf-8?B?cnIrWFpLWnFYNE5NY2NLUTNBdm8vd2FoNEtuRlh3TUo4NyttTEdOTjNCS20v?=
 =?utf-8?B?OEh3WnJ4emozeksrQ0tURUtTT2NYTHNsTGNzTVovNmZPK1Q1aWtsYWQ4eWdE?=
 =?utf-8?B?cnBJS3pTbnpGSlR2YmRGQmJqb1pOODN5T2ZGdzVOTmQ3YjM2dTZPOElvakhi?=
 =?utf-8?B?b2JnVlQ3OS81WFBvb0wwT0ZrbVNTcFVad3oxMkxFSnFVZVNuQXJxMVQ4YTgw?=
 =?utf-8?B?aDI1QjhqZ1IzTVpJUm96b1lSV3dPaEw5UnBkMXhJTkRqcVlidktkbTRFakN5?=
 =?utf-8?B?QUNEeCs2ZCsxMVZEYzJ2Qy9YcXE3QlNMd2d3dFg4dFY3SE1pc0V1bzFpUGV5?=
 =?utf-8?B?UndERnpXK0p0Z3lDUzhpM1Rxejd5amNmbTA4WTdnTDdFQkFFRzNRTHZFb1hh?=
 =?utf-8?B?OGdRejIvRCtoYTdjcFV3dlk2cW9Uck9IZG81d0NMdmJRZnlwT1JyUDF3Z3dx?=
 =?utf-8?B?dStHK2JNK3Ztd2txZG5vZ1N0YUwrMEJ4OVVuNHRSYit2TWtCamdST01PTEZD?=
 =?utf-8?B?QTI2eTVDa3ZYeDl6TGkxbFdVRGt5dTdRcDZEYXVMMGZWRDNLZHdNNUJlVXRE?=
 =?utf-8?B?YmJQeTEwVXZxN2FRbVBuQ1Y4VitNMTMvYXE2ZGxDRWlYa1psRzFYb0F6anpU?=
 =?utf-8?B?MXRSVlYvRjk5TlEvcnhaM0Z1aGZTVjBFNCtSMkIxcS9uL1IrMzNsanhHejB5?=
 =?utf-8?B?bGl1TEVFOUh3SGltNDhzYjFjWk5vWXVVQkpHeDVNMzE0RHYzcm5RYTNkM2FX?=
 =?utf-8?B?SHpRQzNnRktadi9HZVp2cFZTaHc3a1VQOXdjL3czRk9hMHF2SFRKVWtscEJO?=
 =?utf-8?B?dEV5VEdIQ1Z2SnAzYnpZQUdKcXJnTjJQdG8wOUp4WFhPUWIvWlhEbXN2VHpB?=
 =?utf-8?B?YlVsZ1poeGJzcXJCSnJHbE9Sazd1aUloWlhoa0xCOXZNbVhGbldQV3YxRDNP?=
 =?utf-8?B?RlMraDNpVG1xdmJsN2YxU0w0cHBpM2cyZ3UrZnJ1RjA3V3IrSGo4L0Q4bENV?=
 =?utf-8?B?d1N1Q3RrNC9SMlgxOUNZa2h5NUduR0s0WStDVXFBU01VbTNhQWJIQjVyenNI?=
 =?utf-8?B?NTJ6OW1kQUpBWmxxUUdhS3JPV1BWT2hnT2w5SUNjRGJyaUljMU1OTWtFVHBF?=
 =?utf-8?B?ZmowUjZWK3JtQytzemI2OW00VVRaMnE5Qy9HYW9seEV4SlNoYjBhMFQxMjkx?=
 =?utf-8?B?d243V0szQnVmUktNSFRRUnVIVVBBeDF4ZFdSdUtYV2I3K1psdGRCMlEwbUJv?=
 =?utf-8?B?V2ppdUlvTVRNSVBkc3VPS3RReEo0WHlReWNhYmFsc0NncmYrYTdhcDJ2RGNG?=
 =?utf-8?B?WlU3VVdoRHlWaEcvMGdKeW9kSEh3NVJQMHFheTlwWDlMczhWb0lvR3lQS2JO?=
 =?utf-8?B?SmRZNHl1VkIzNHJOblUzL0xUeTRrOUo4T2xramlqekFuak5MNFFDdlBqelB5?=
 =?utf-8?B?SnN5YVJXcXR2cWNxOURCTzlvbzNPRWlzeXFkeHJlcWVFOW1kQ2pMbzh0MkZ1?=
 =?utf-8?B?S3cwRW1Ocnd1SG8vZzdjSjEwNHZtd0t2RlhQaS9nOXowNitHNE5qaWpGYnB0?=
 =?utf-8?B?cXBiVkZIWGNEUjM2N1liY2lZQnlzeXdyVmxMc2xMeWRnMk14aDViV1kyUnhr?=
 =?utf-8?B?V010UlJjRnA3NGp2WUpsWDZGbWlONDlYRExROEgrZjB1NVJEdWcwN2o3RCtW?=
 =?utf-8?B?NFkyWTcrZVh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW53ekdwY3VkRXdqZEZlSWxROWNNRlhuT0IxSlBENGszU0pRbkFsY2ZrSFFJ?=
 =?utf-8?B?cFlGYmYvNDB1dnY4OWs1UmxmS3p1dEhVMmE1OTB6VW1UVDRLb0RPaWUxUzQz?=
 =?utf-8?B?OFBPSnVITlgrY2diem5ycXJaRjU5cUZNZCs3RitLUVZNL3V5ZFkyR1AxYVc4?=
 =?utf-8?B?Y2N1aElDY3JVK3l3d1ZJZ01oNVJWNmM2VXl6em1DbmI2TGd6TnAwblNzdDV2?=
 =?utf-8?B?UWFpNGMxcmN1bDJ2Tnk2MnBDR0xHMFNsWmwzRjJIbkJZdCtFd3d4dW9lT2to?=
 =?utf-8?B?ODVUcUpvLzhvQ3lDUmJOM2ZFeTZibGJLaERKMFVJK3ZVOGgxdTVlSTNkQ0pu?=
 =?utf-8?B?RWVFanlSdW1VcVFNaGx6WVlMMjNyZXpVSlFDUThrTnljVXhkSGdQTlZvWnhr?=
 =?utf-8?B?VjhldzVsV0U1aE9KSjZjaTZkMzU5bGcvR1ozMTFHM0JyblU4MHVXMFZiSEhN?=
 =?utf-8?B?WlJKdVJIcDNFMkNRc2o4V3VoZjhLdFI4c0d4YXUzYi9CN3NzSzRxelk1a3FK?=
 =?utf-8?B?V1Y1T291T2hGMEtMOGZTZ2xkUjNUdDBqc2lYSEt0UHZNSjhnTDZqU3N2RFBq?=
 =?utf-8?B?R0tmWHg1MTUxc096OTdraUlwS0Q0NHVlQkZHc01ZaGNwL0IyZ0pnSVpKbnFD?=
 =?utf-8?B?SFpDdU9xNlhWcDFnQXQzL2x3SVRPVmpJTzlzVHNNeTZ1YVJEMmhMMGhWayti?=
 =?utf-8?B?UU45RzUyQlI3K3lXOXFydjgyNUtXajhmWGxUUTRTNFoyZGdXbkxNc2pxSU11?=
 =?utf-8?B?Q2pRd3hmblBLSERTRVFwL1p1cHBJNVZzNlh1cTNNUUU5NzV0NHBERU8xRkVs?=
 =?utf-8?B?dHZRMDRqd1Zsd05BaTBwOVpMREVHNHQxTStmcmUxRVlDenRNbk5SYU1XUWo2?=
 =?utf-8?B?K0JFRzFsNjVRZmxoWm9oaytWYmg4b1ZBWGt5bHBmb1JwYmFRbzExVjlLR0x2?=
 =?utf-8?B?WFNWbDZKUW9mTDc3VmszRlJuQWY1Z1plcm1qdnFsOE41ODNnOGJRbWN1RjBQ?=
 =?utf-8?B?NmlxT0drZDAwdWFaUkdldXJQb2dWaUZNQWh0MWdQdWdMUGo4Z3ptRnFrS09B?=
 =?utf-8?B?Tm44ZndLYTJOb0h5TExXSFk5YWc2Y2pZSDBrVnl1VURCc1lsR3RnaFVZSWw4?=
 =?utf-8?B?ZnVGSUhLYTNYODl2WnhtbGFQd0RJcVNUdXRwcWRNZzNtQWVTaGNuc3U3bkdv?=
 =?utf-8?B?bWdrRDYzS2dONS9ORlNOcWt4QnNBVzNjSzlPaGdOTDI4THFDbHdLVk5EbDF3?=
 =?utf-8?B?dVpXNWtoWU9BZ1BQR3dEWDNZSXBkWHdxL2dYeGt3MWRMUG5QaFExNG9MdXIz?=
 =?utf-8?B?TGFQdjlrTVk4OWFnejdvTmlNNXBCeldYUWNyZEJoZ3ZBMXdidzNxV3IrR3lp?=
 =?utf-8?B?NGRvYW9NYi81MkN5NEFZdWp3cUVPWE5yZFU2WHU5WDM4VSsvN2NFRkJWM2Fu?=
 =?utf-8?B?TDJ6WnhIaTJCclh1bDF4RldkRWVkUGdPQXhsOXVBeU5EWkNxaC9xWHdlOHlX?=
 =?utf-8?B?TjhyTThiWXBIQXRzVjVGVlkwQVNZRkxBM2c5Z1JLSVlmeXVDMGtBT3Z1WUwx?=
 =?utf-8?B?RmIrdjhleDVhNU15bG5YTTZGb01MdDBmSEZGWjBYc0VHNGtGMEFVWkFQN1dZ?=
 =?utf-8?B?a2xLYXdxTTUyNG40Mm42cDhyKzh6OWdRTUsrc3ppUGcxY3dpRThiU2MzNzR0?=
 =?utf-8?B?djhwTHduYkE4S3Q4Mnpkc3BIUllCeDQ4L2l1L2IwNnpMK0VCNXBkcVM1Z3V1?=
 =?utf-8?B?Zlc2OXpkOUw0RHNjQnJFZ0l6Tnl4NHFLNTlIWUw3VHprN0Y1UmRiODdLUGtr?=
 =?utf-8?B?Qkp3QVVHWitKekJyby9VYjBBZEpkTDFkR1JkTVNFT2JrdDhkbHRXWlVjK2lR?=
 =?utf-8?B?OEZhaWx5aHhQZFlXNnNFamRpMUY2U3JUOWRrZ2pqdGpRajlPMTlqSUNsd0pn?=
 =?utf-8?B?anRUeTBONUoxaGJsc25PZS8rczdPTEp1c3RrZjgvN3l2eEUvbUpVUmJhSFM3?=
 =?utf-8?B?NWJTY2taa3U5bFZDc1lCaGJzN2trZG1Oa0Z3dFhCbk44UFduQlpZOGpROUFY?=
 =?utf-8?B?Y3VvV2NxbGVqWlNzSjVyOHcvRm9kSlBtR1Rodm9TVERaSnI2eFRTcE8yZXM4?=
 =?utf-8?B?dThxcWFTU0Jsak9uajFwaS9yaGJjT0NicitRZmQzZkNnME81MjFkZ2t6M1Vq?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tUbSaJ+yQYUBiN8GwIpACXE14pMLM12AlLrq6AIbvb90W9coV4pRgBhCiWmEs8tQptnHkz9sLwixtk5VyPQcnHRkgjkXOLmvNrNvIRb7eybBHb9GxHzfC4TEV/8/NJhHWKAODisGOW/OvrIk1e5uZ3QNgRcU7f5PCRYcQ9Ahmi8uHQ/mCLPy1DJh+Hwj5e0MEAOzs/S6jTrovjlWenDLpLg3locQumZGGjL5RitmLVcTGK1tG1p4ZF3l0dwNjfkZWfHwCkSXmtNjxFbnf24X2Kl9+ct14NPJzQPZtlpUmaElGE4oaWrjiyJSVvpN2Noj4Ks4C6ppQ+b28fAPNnZCZyPpv+SNr3E9PIt1PiZT2HrrVoxGinDBeUf/mKG+g5k3SX99HdkfDVtRaV5QH/4BMq//eTBEMGPv2LgTM93w3gJNriamVdT+cC3Bjp5vvHaipViXbwpGsXWYf25Y4zLo61Fp2Ur58MHxsF27mcF/dLX+phgGhBE5NfgxrtfQyt2vEB+dYlFPkZqj11L0/CE3o+wlvx6K3y7O+hLa8/toch7OM2cSVn1S3PNKiz9FruJpPdy8w3p/cc8C4CmKbQ8E4qOr1eVmDzRROBKvjGG6qMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8703033-301d-4377-11e2-08dd8be784de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:14:24.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JU2ZIk5eFcOte1VQwxXDMOQr0cP4c/V3MD9q7GpttReeWyf/gmGsalm2RLCmze7EdaBHAlQo3NOiXbhVZ0kwbiiBRTTBxfr5IaYS9K8g7T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505050145
X-Proofpoint-GUID: vX_bjv9-7e6INuA5JAzARJyLBAGwpuzH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE0NiBTYWx0ZWRfX4Ee9sa+A63SB UhbPAYVmdMbZ2mCCfUyrDziKnZFwkc7/icwqYw1k++KyBwBEafTpmGkX19tr9IzS61m7IE7rlGy RyYWxt1kMkYw/gxeHDOReYyqLdQouicc8k+te/yh4NrU1bAZ83H+MBgDvMglB74cld3dh8rWo6v
 fdXfE+DkJzucLbpAvjnkXHbQkUhydM70ZC7Kk5iD45AMvbGs/cxcSPuoE0hTwn6O2vqzxkoPzkD v5HYly8ObUc12xJ8TAI1iONdZMTGdfeT5436A89HT3jqNFFAP40a7A7qv0DSvRG1R3gzEfEomAx jBQrL6qtzojrXJvos7wSuryKFEtdA54PpfhnST8Ddu+DuXYBLcbSu8ayxJK0261WmZl05DY56L2
 kXSpzvzcQpaelMTihkQcTx4N67LrSNyxvS0mVhM39WcT2vmpW+BjKxSqdis+rxNkMaB5oj+q
X-Proofpoint-ORIG-GUID: vX_bjv9-7e6INuA5JAzARJyLBAGwpuzH
X-Authority-Analysis: v=2.4 cv=er3fzppX c=1 sm=1 tr=0 ts=6818d5d5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=48vgC7mUAAAA:8 a=QRfgzcQfAAAA:8 a=T5h9VGK7AAAA:8 a=9qxNCY_qAAAA:8 a=ZYOxkDpqAAAA:8 a=wsYdVedNAAAA:8 a=VwQbUJbxAAAA:8 a=5OBTALiwT02rqndU45wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bWi_NY57ueRCZMPDbo1P:22 a=4sjnvvPVYadLTVfh1zOT:22 a=DSX8VK-MHXYh3DGVmxOZ:22 a=5TmgkJrYsa9NT1YAuGZe:22



On 05-05-2025 15:17, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> DUALPI2 AQM is a combination of the DUALQ Coupled-AQM with a PI2
> base-AQM. The PI2 AQM is in turn both an extension and a simplification
> of the PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while
> being able to control scalable congestion controls like TCP-Prague.
> With PI2, both Reno/Cubic can be used in parallel with Prague,
> maintaining window fairness. DUALQ provides latency separation between
> low latency Prague flows and Reno/Cubic flows that need a bigger queue.
> 
> This patch adds support to tc to configure it through its netlink
> interface.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Olga Albisser <olga@albisser.org>
> Signed-off-by: Olga Albisser <olga@albisser.org>
> Co-developed-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> Co-developed-by: Oliver Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Oliver Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
> Co-developed-by: Henrik Steen <henrist@henrist.net>
> Signed-off-by: Henrik Steen <henrist@henrist.net>
> ---
...
> +};
> +
> +#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
> +
> +struct tc_dualpi2_xstats {
> +	__u32 prob;		/* current probability */
> +	__u32 delay_c;		/* current delay in C queue */
> +	__u32 delay_l;		/* current delay in L queue */
> +	__u32 packets_in_c;	/* number of packets enqueued in C queue */
> +	__u32 packets_in_l;	/* number of packets enqueued in L queue */
> +	__u32 maxq;		/* maximum queue size */
> +	__u32 ecn_mark;		/* packets marked with ecn*/
> +	__u32 step_marks;	/* ECN marks due to the step AQM */
> +	__s32 credit;		/* current c_protection credit */
> +	__u32 memory_used;	/* Meory used of both queues */

typo Meory -> Memory

> +	__u32 max_memory_used;	/* Maximum used memory */
> +	__u32 memory_limit;	/* Memory limit of both queues */
> +};
> +
>   #endif
> diff --git a/include/utils.h b/include/utils.h
> index 9a81494d..91e6e31f 100644
> --- a/include/utils.h
> +++ b/include/utils.h
> @@ -146,6 +146,8 @@ int read_prop(const char *dev, char *prop, long *value);
>   int get_long(long *val, const char *arg, int base);
>   int get_integer(int *val, const char *arg, int base);
>   int get_unsigned(unsigned *val, const char *arg, int base);
> +int get_float(float *val, const char *arg);
> +int get_float_min_max(float *val, const char *arg, float min, float max);
>   int get_time_rtt(unsigned *val, const char *arg, int *raw);
>   #define get_byte get_u8
>   #define get_ushort get_u16
> diff --git a/ip/iplink_can.c b/ip/iplink_can.c
> index fcffa852..9f6084e6 100644
> --- a/ip/iplink_can.c
> +++ b/ip/iplink_can.c
> @@ -67,20 +67,6 @@ static void usage(void)
>   	print_usage(stderr);
>   }
>   
> -static int get_float(float *val, const char *arg)
> -{
> -	float res;
> -	char *ptr;
> -
> -	if (!arg || !*arg)
> -		return -1;
> -	res = strtof(arg, &ptr);
> -	if (!ptr || ptr == arg || *ptr)
> -		return -1;
> -	*val = res;
> -	return 0;
> -}
> -
>   static void set_ctrlmode(char *name, char *arg,
>   			 struct can_ctrlmode *cm, __u32 flags)
>   {
> diff --git a/lib/utils.c b/lib/utils.c
> index 706e93c3..dd242d4d 100644
> --- a/lib/utils.c
> +++ b/lib/utils.c
> @@ -220,6 +220,36 @@ int get_unsigned(unsigned int *val, const char *arg, int base)
>   	return 0;
>   }
>   
> +int get_float(float *val, const char *arg)
> +{
> +	float res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtof(arg, &ptr);
> +	if (!ptr || ptr == arg || *ptr)
> +		return -1;
> +	*val = res;
> +	return 0;
> +}
> +
> +int get_float_min_max(float *val, const char *arg, float min, float max)
> +{
> +	float res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtof(arg, &ptr);
> +	if (!ptr || ptr == arg || *ptr)
> +		return -1;
> +	if (res < min || res > max)
> +		return -1;
> +	*val = res;
> +	return 0;
> +}
> +
>   /*
>    * get_time_rtt is "translated" from a similar routine "get_time" in
>    * tc_util.c.  We don't use the exact same routine because tc passes
> diff --git a/man/man8/tc-dualpi2.8 b/man/man8/tc-dualpi2.8
> new file mode 100644
> index 00000000..f303ee5d
> --- /dev/null
> +++ b/man/man8/tc-dualpi2.8
> @@ -0,0 +1,249 @@
> +.TH DUALPI2 8 "29 Oct 2024" "iproute2" "Linux"
> +
> +.SH NAME
> +DUALPI2 \- Dual Queue Proportional Integral Controller AQM - Improved with a square
> +.SH SYNOPSIS
> +.sp
> +.ad l
> +.in +8
> +.ti -8
> +.BR tc " " qdisc " ... " dualpi2
> +.br
> +.RB "[ " limit
> +.IR PACKETS " ]"
> +.br
> +.RB "[ " memlimit
> +.IR BYTES " ]"
> +.br
> +.RB "[ " coupling_factor
> +.IR NUMBER " ]"
> +.br
> +.RB "[ " step_thresh
> +.IR TIME | PACKETS " ]"
> +.br
> +.RB "[ " min_qlen_step
> +.IR PACKETS " ]"
> +.br
> +.RB "[ " drop_on_overload " | " overflow " ]"
> +.br
> +.RB "[ " drop_enqueue " | " drop_dequeue " ]"
> +.br
> +.RB "[ " l4s_ect " | " any_ect " ]"
> +.br
> +.RB "[ " classic_protection
> +.IR PERCENTAGE " ] "
> +.br
> +.RB "[ " max_rtt
> +.IR TIME
> +.RB " [ " typical_rtt
> +.IR TIME " ]] "
> +.br
> +.RB "[ " target
> +.IR TIME " ]"
> +.br
> +.RB "[ " tupdate
> +.IR TIME " ]"
> +.br
> +.RB "[ " alpha
> +.IR float " ]"
> +.br
> +.RB "[ " beta
> +.IR float " ] "
> +.br
> +.RB "[ " split_gso " | " no_split_gso " ]"
> +
> +.SH DESCRIPTION
> +DUALPI2 AQM is a combination of the DUALQ Coupled-AQM with a PI2 base-AQM. The PI2 AQM (details can be found in the paper cited below) is in turn both an extension and a simplification of the PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while being able to control scalable congestion controls like TCP-Prague. With PI2, both Reno/Cubic can be used in parallel with Prague, maintaining window fairness. DUALQ provides latency separation between low latency Prague flows and Reno/Cubic flows that need a bigger queue. The main design goals are:
> +.PD 0
> +.IP \(bu 4
> +L4S - Low Loss, Low Latency and Scalable congestion control support
> +.IP \(bu 4
> +DualQ option to separate the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling
> +.IP \(bu 4
> +Configurable overload strategies
> +.IP \(bu 4
> +Use of sojourn time to reliably estimate queue delay
> +.IP \(bu 4
> +Simple implementation
> +.IP \(bu 4
> +Guaranteed stability and fast responsiveness
> +
> +.PP
> +The detailed PI2 parameters (alpha, beta, and tupdate) of DualPI2 are hard to get right and typically give bad results if just tried or guessed. These parameters need to be calculated to a coherent set with a typical objective in mind. DualPI2 has a set of default parameters that can be used for the general Internet, where the maximum RTT is around 100ms and the typical RTT is around 15ms. It is highly recommended to use
> +.I "" max_rtt
> +and
> +.I "" typical_rtt
> +(or target) helper parameters if your deployment is deviating from the above objectives (e.g., in a data center). These helpers are used to provide the theoretically optimal PI2 parameters (alpha, beta, and tupdate) for those objectives, and that can be used as a basis for further finetuning, experimentation, and testing if desired.
> +
> +.SH ALGORITHM
> +DUALPI2 is designed to provide low loss and low latency to L4S traffic, without harming classic traffic. Every update interval, a new internal base probability is calculated based on queue delay. The base probability is updated with a delta based on the difference between the current queue delay and the
> +.I "" target
> +delay, and the queue growth compared with the queuing delay during the previous
> +.I "" tupdate
> +interval. The integral gain factor
> +.RB "" alpha
> +is used to correct slowly enough any persistent standing queue error to the user specified target delay, while the proportional gain factor
> +.RB "" beta
> +is used to quickly compensate for queue changes (growth or shrink).
> +
> +The updated base probability is used as input to decide to mark and drop packets. DUALPI2 scales the calculated probability for each of the two queues accordingly. For the L-queue, the probability is multiplied by a
> +.RB "" coupling_factor
> +, while for the C-queue, it is squared to compensate the squareroot rate equation of Reno/Cubic. The ECT identifier (
> +.RB "" l4s_ect | any_ect
> +) is used to classify traffic into respective queues.
> +
> +If DUALPI2 AQM has detected overload (when excessive non-responsive traffic is sent), it can signal congestion solely using
> +.RB "" drop
> +, irrespective of the ECN field, or alternatively limit the drop probability and let the queue grow and eventually
> +.RB "" overflow
> +(like tail-drop).
> +
> +Additional details can be found in the RFC cited below.
> +
> +.SH PARAMETERS
> +.TP
> +.BI limit " PACKETS"
> +Limit the number of packets that can be enqueued. Incoming packets are dropped when this limit is reached. This limit is common for the L-queue and C-queue. Defaults to
> +.I 10000

Incoming packets will be dropped once this limit is reached

> +packets. This is about 125ms delay on a 1Gbps link.
> +.PD
> +.TP
> +.BI memlimit " BYTES"
> +Limit the amount of memory that can be used. Incoming packets are dropped when this memlimit is reached. This memlimit is common for the L-queue and C-queue. Defaults to
> +.I 10000 * interface MTU bytes.

Limit the total amount of memory that can be used. Incoming packets will 
be dropped once this memlimit is reached.

> +.PD
> +.TP
> +.BI coupling_factor " NUMBER"
> +Set the coupling rate factor between Classic and L4S. Defaults to
> +.I 2
> +.PD
> +.TP
> +.BI l4s_ect | any_ect
> +Configures the ECT classifier. Packets whose ECT codepoint matches this are sent to the L-queue, where they receive a scalable marking. Defaults to
> +.I l4s_ect
> +, i.e., the L4S identifier ECT(1). Setting this to
> +.I any_ect
> +causes all packets whose ECN field is not zero to be sent to the L-queue. This enables it to be backward compatible with, e.g., DCTCP. Note DCTCP should only be used for intra-DC traffic with very low RTTs and AQM delay targets bigger than those RTTs, separated from Internet traffic (also if Prague compliant CC), as it does not support all Prague requirements that make sure that a congestion control can work well with the range of RTTs on the Internet.
> +.PD
> +.TP
> +.BI step_thresh " TIME | PACKETS"
> +Set the step threshold for the L-queue. This will cause packets with a sojourn time exceeding the threshold to always be marked. This value can either be specified using time units (i.e., us, ms, s), or in packets (p, pkt, packet(s)). A value without units is assumed to be in time (us). If defining the step in packets, be sure to disable GRO on the ingress interfaces. Defaults to
> +.I 1ms
> +.PD
> +.TP
> +.BI min_qlen_step " PACKETS"
> +Incoming pacekts enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. Defaults to

Incoming packets enqueued to the L-queue may apply the step threshold 
when the queue length of the L-queue exceeds this value.

> +.I 0
> +packets. This means that every enqueued packets to the L-queue with a sojourn time exceed the step thresohld will be marked.

typo thresohld ->threshold

> +.PD
> +.TP
> +.B drop_on_overload  |  overflow

remove extra ' '

> +Control the overload strategy.
> +.I drop_on_overload
> +preserves the delay in the L-queue by dropping in both queues on overload.
> +.I overflow
> +sacrifices delay to avoid losses, eventually resulting in a taildrop behavior once the
> +.I limit
> +is reached. Defaults to
> +.I drop_on_overload
> +.PD
> +.TP
> +.B drop_enqueue | drop_dequeue
> +Decide when packets are PI-based dropped or marked. The
> +.I step_thresh
> +based L4S marking is always at dequeue. Defaults to
> +.I drop_dequeue
> +.PD
> +.TP
> +.BI classic_protection " PERCENTAGE
> +Protects the C-queue from unresponsive traffic in the L-queue. This bounds the maximal scheduling delay in the C-queue to be
> +.I (100 - PERCENTAGE)
> +times greater than the one in the L-queue. Defaults to
> +.I 10
> +.TP
> +.BI typical_rtt " TIME"
> +.PD 0
> +.TP
> +.PD
> +.BI max_rtt " TIME"
> +Specify the maximum round trip time (RTT) and/or the typical RTT of the traffic that will be controlled by DUALPI2. These values are specified using time units (i.e., us, ms, s). A value without units is assumed to be in us. If either
> +.I max_rtt
> +or
> +.I typical_rtt
> +is not specified, the missing value will be computed from the following relationship:
> +.I max_rtt = typical_rtt * 6.
> +If any of these parameters is given, it will be used to automatically compute suitable values for
> +.I alpha, beta, target, and tupdate,
> +according to the relationship from the appendix A.1 in the IETF RFC cited below, to achieve a stable control. Consequently, those derived values will override their eventual user-provided ones. The default range of operation for the qdisc uses
> +.I max_rtt = 100ms
> +and
> +.I typical_rtt = 15ms
> +, which is suited to controlling Internet traffic.
> +.TP
> +.BI target " TIME"
> +Set the expected queue delay. Defaults to
> +.I 15
> +ms. A value without units is assumed to be in us.
> +.TP
> +.BI tupdate " TIME"
> +Set the frequency at which the system drop probability is calculated. Defaults to
> +.I 16
> +ms. A value without units is assumed to be in us. This should be less than a third of the max RTT supported.

This should be less than one-third of the maximum RTT supported.

what about "to be in µs." or microseconds , here us may confused.

> +.TP
> +.BI alpha " float"
> +.PD 0
> +.TP
> +.PD
> +.BI beta " float"
> +Set alpha and beta, the integral and proportional gain factors in Hz for the PI controller. These can be calculated based on control theory. Defaults are
> +.I 0.16
> +and
> +.I 3.2
> +Hz, which provide stable control for RTT's up to 100ms with tupdate of 16ms. Be aware, unlike with PIE, these are the real unscaled gain factors. If not provided, they will be automatically derived from
> +.I typical_rtt and max_rtt
> +, if one of them or both are provided.
> +.PD
> +.TP
> +.B split_gso | no_split_gso
> +Decide how to handle aggregated packets. Either treat the aggregate as a single packet (thus all share fate with respect to marks and drops) with
> +.I no_split_gso
> +, trading some tail latency for CPU usage, or treat each packet individually (i.e., split them) with
> +.I split_gso
> +to finely mark/drop and control queueing latencies. Defaults to

Enables fine-grained marking/dropping of packets to control queuing 
latencies.

> +.I split_gso
> +
> +.SH EXAMPLES
> +Setting DUALPI2 for the Internet with default parameters:
> + # sudo tc qdisc add dev eth0 root dualpi2
> +
> +Setting DUALPI2 for datacenter with legacy DCTCP using ECT(0):
> + # sudo tc qdisc add dev eth0 root dualpi2 any_ect
> +
> +.SH FILTERS
> +This qdisc can be used in conjunction with tc-filters. More precisely, it will honor filters "stealing packets", as well as accept other classification schemes.
> +.BR
> +.TP
> +Packets whose priority/classid are set to
> +.I 1
> +will be enqueued in the L-queue, alongside L4S traffic, and thus subject to the increased marking probability (or drops if they are marked not-ECT).
> +.BR
> +.TP
> +Packets whose priority/classid are set to
> +.I 2
> +will also be enqueued in the L-queue, but will never be dropped if they are not-ECT (unless the qdisc is full and thus resorts to taildrop).
> +.BR
> +.TP
> +Finally, all the other classid/priority map to the C-queue.
> +
> +.SH SEE ALSO
> +.BR tc (8),
> +.BR tc-pie (8)
> +
> +.SH SOURCES
> +.IP \(bu 4
> +IETF RFC9332 : https://urldefense.com/v3/__https://datatracker.ietf.org/doc/html/rfc9332__;!!ACWV5N9M2RV99hQ!Iz3a1Xv-TwvDgbgUfqZFpvdUaHQQPaq-VFfL-h9g9rCGKSVFqxI1ZxAwBDHdmWEw-V4jdwQScu646KIS-GjZpcaFbVpsXDewNK0$
> +.IP \(bu 4
> +CoNEXT '16 Proceedings of the 12th International on Conference on emerging Networking EXperiments and Technologies : "PI2: A Linearized AQM for both Classic and Scalable TCP"

typo EXperiments ->Experiments

> +
> +.SH AUTHORS
> +DUALPI2 was implemented by Koen De Schepper, Olga Albisser, Henrik Steen, Olivier Tilmans, and Chia-Yu Chang, also the authors of this man page. Please report bugs and corrections to the Linux networking development mailing list at <netdev@vger.kernel.org>.
> diff --git a/tc/Makefile b/tc/Makefile
> index b5e853d8..6264a772 100644
> --- a/tc/Makefile
> +++ b/tc/Makefile
> @@ -9,6 +9,7 @@ SHARED_LIBS ?= y
>   
>   TCMODULES :=
>   TCMODULES += q_fifo.o
> +TCMODULES += q_dualpi2.o
>   TCMODULES += q_sfq.o
>   TCMODULES += q_red.o
>   TCMODULES += q_prio.o
> diff --git a/tc/q_dualpi2.c b/tc/q_dualpi2.c
> new file mode 100644
> index 00000000..46511e55
> --- /dev/null
> +++ b/tc/q_dualpi2.c
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +/* Copyright (C) 2024 Nokia
> + *
> + * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> + * Author: Olga Albisser <olga@albisser.org>
> + * Author: Henrik Steen <henrist@henrist.net>
> + * Author: Olivier Tilmans <olivier.tilmans@nokia.com>
> + * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> + *
> + * DualPI Improved with a Square (dualpi2):
> + * - Supports congestion controls that comply with the Prague requirements
> + *   in RFC9331 (e.g. TCP-Prague)
> + * - Supports coupled dual-queue with PI2 as defined in RFC9332
> + * - Supports ECN L4S-identifier (IP.ECN==0b*1)
> + *
> + * note: Although DCTCP and BBRv3 can use shallow-threshold ECN marks,
> + *   they do not meet the 'Prague L4S Requirements' listed in RFC 9331
> + *   Section 4, so they can only be used with DualPI2 in a datacenter
> + *   context.
> + *
> + * References:
> + * - RFC9332: https://urldefense.com/v3/__https://datatracker.ietf.org/doc/html/rfc9332__;!!ACWV5N9M2RV99hQ!Iz3a1Xv-TwvDgbgUfqZFpvdUaHQQPaq-VFfL-h9g9rCGKSVFqxI1ZxAwBDHdmWEw-V4jdwQScu646KIS-GjZpcaFbVpsXDewNK0$
> + * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classic and
> + *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <syslog.h>
> +#include <fcntl.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>
> +#include <math.h>
> +#include <errno.h>
> +
> +#include "utils.h"
> +#include "tc_util.h"
> +
> +#define MAX_PROB ((uint32_t)(~0U))
> +#define DEFAULT_ALPHA_BETA ((uint32_t)(~0U))
> +#define ALPHA_BETA_MAX ((2 << 23) - 1) /* see net/sched/sch_dualpi2.c */
> +#define ALPHA_BETA_SCALE (1 << 8)
> +#define RTT_TYP_TO_MAX 6
> +
> +static const char *get_credit_queue(int credit)
> +{
> +	return credit > 0 ? "C-queue" : "L-queue";
> +}
> +
> +static const char *get_ecn_type(uint8_t ect)
> +{
> +	switch (ect & TCA_DUALPI2_ECN_MASK_ANY_ECT) {
> +	case TCA_DUALPI2_ECN_MASK_L4S_ECT: return "l4s_ect";
> +	case TCA_DUALPI2_ECN_MASK_ANY_ECT: return "any_ect";
> +	default:
> +		fprintf(stderr,
> +			"Warning: Unexpected ecn type %u!\n", ect);
> +		return "";
> +	}
> +}
> +
> +static const char *get_ecn_type_json(uint8_t ect)
> +{
> +	switch (ect & TCA_DUALPI2_ECN_MASK_ANY_ECT) {
> +	case TCA_DUALPI2_ECN_MASK_L4S_ECT: return "l4s-ect";
> +	case TCA_DUALPI2_ECN_MASK_ANY_ECT: return "any-ect";
> +	default:
> +		fprintf(stderr,
> +			"Warning: Unexpected ecn type %u!\n", ect);
> +		return "";
> +	}
> +}
> +
> +static void explain(void)
> +{
> +	fprintf(stderr, "Usage: ... dualpi2\n");
> +	fprintf(stderr, "               [limit PACKETS]\n");
> +	fprintf(stderr, "               [memlimit BYTES]\n");
> +	fprintf(stderr, "               [coupling_factor NUMBER]\n");
> +	fprintf(stderr, "               [step_thresh TIME|PACKETS]\n");
> +	fprintf(stderr, "               [min_qlen_step PACKETS]\n");
> +	fprintf(stderr, "               [drop_on_overload|overflow]\n");
> +	fprintf(stderr, "               [drop_enqueue|drop_dequeue]\n");
> +	fprintf(stderr, "               [classic_protection PERCENTAGE]\n");
> +	fprintf(stderr, "               [max_rtt TIME [typical_rtt TIME]]\n");
> +	fprintf(stderr, "               [target TIME] [tupdate TIME]\n");
> +	fprintf(stderr, "               [alpha ALPHA] [beta BETA]\n");
> +	fprintf(stderr, "               [split_gso|no_split_gso]\n");
> +}
> +
> +static int get_packets(uint32_t *val, const char *arg)
> +{
> +	unsigned long res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtoul(arg, &ptr, 10);
> +	if (!ptr || ptr == arg ||
> +	    !(matches(ptr, "pkts") == 0 || matches(ptr, "packets") == 0))
> +		return -1;
> +	if (res == ULONG_MAX && errno == ERANGE)
> +		return -1;
> +	if (res > 0xFFFFFFFFUL)
> +		return -1;
> +	*val = res;

a '\n' before return

> +	return 0;
> +}
> +
> +static int parse_alpha_beta(const char *name, char *argv, uint32_t *field)
> +{
> +
> +	float field_f;
> +
> +	if (get_float_min_max(&field_f, argv, 0.0, ALPHA_BETA_MAX)) {
> +		fprintf(stderr, "Illegal \"%s\"\n", name);
> +		return -1;
> +	} else if (field_f < 1.0f / ALPHA_BETA_SCALE)
> +		fprintf(stderr,
> +			"Warning: \"%s\" is too small and will be rounded to zero.\n",
> +			name);
> +	*field = (uint32_t)(field_f * ALPHA_BETA_SCALE);
> +	return 0;
> +}
> +
> +static int try_get_percent(int *val, const char *arg)
> +{
> +	double per;
> +
> +	if (parse_percent(&per, arg))
> +		return -1;
> +
> +	*val = rint(per * 100);

a '\n' before return

> +	return 0;
> +}
> +
> +static int dualpi2_parse_opt(const struct qdisc_util *qu, int argc,
> +			     char **argv, struct nlmsghdr *n, const char *dev)
> +{
> +	uint32_t limit = 0;
> +	uint32_t memory_limit = 0;
> +	uint32_t target = 0;
> +	uint32_t tupdate = 0;
> +	uint32_t alpha = DEFAULT_ALPHA_BETA;
> +	uint32_t beta = DEFAULT_ALPHA_BETA;
> +	int32_t coupling_factor = -1;
> +	uint8_t ecn_mask = 0;
> +	bool step_packets = false;
> +	uint32_t step_thresh = 0;
> +	uint32_t min_qlen_step =  0;
> +	bool set_min_qlen_step = false;
> +	int c_protection = -1;
> +	uint8_t drop_early = __TCA_DUALPI2_DROP_EARLY_MAX;
> +	uint8_t drop_overload = __TCA_DUALPI2_DROP_OVERLOAD_MAX;
> +	uint8_t split_gso = __TCA_DUALPI2_SPLIT_GSO_MAX;
> +	uint32_t rtt_max = 0;
> +	uint32_t rtt_typ = 0;
> +	struct rtattr *tail;
> +
> +	while (argc > 0) {
> +		if (strcmp(*argv, "limit") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&limit, *argv, 10)) {
> +				fprintf(stderr, "Illegal \"limit\"\n");
> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "memlimit") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&memory_limit, *argv, 10)) {
> +				fprintf(stderr, "Illegal \"memlimit\"\n");
> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "target") == 0) {
> +			NEXT_ARG();
> +			if (get_time(&target, *argv)) {
> +				fprintf(stderr, "Illegal \"target\"\n");
> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "tupdate") == 0) {
> +			NEXT_ARG();
> +			if (get_time(&tupdate, *argv)) {
> +				fprintf(stderr, "Illegal \"tupdate\"\n");
> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "alpha") == 0) {
> +			NEXT_ARG();
> +			if (parse_alpha_beta("alpha", *argv, &alpha))
> +				return -1;
> +		} else if (strcmp(*argv, "beta") == 0) {
> +			NEXT_ARG();
> +			if (parse_alpha_beta("beta", *argv, &beta))
> +				return -1;
> +		} else if (strcmp(*argv, "coupling_factor") == 0) {
> +			NEXT_ARG();
> +			if (get_s32(&coupling_factor, *argv, 0) ||
> +			    coupling_factor > 0xFFUL || coupling_factor < 0) {
> +				fprintf(stderr,
> +					"Illegal \"coupling_factor\"\n");
> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "l4s_ect") == 0)
> +			ecn_mask = TCA_DUALPI2_ECN_MASK_L4S_ECT;
> +		else if (strcmp(*argv, "any_ect") == 0)
> +			ecn_mask = TCA_DUALPI2_ECN_MASK_ANY_ECT;
> +		else if (strcmp(*argv, "step_thresh") == 0) {
> +			NEXT_ARG();
> +			/* First assume that this is specified in time */
> +			if (get_time(&step_thresh, *argv)) {
> +				/* Then packets */
> +				if (get_packets(&step_thresh, *argv)) {
> +					fprintf(stderr,
> +						"Illegal \"step_thresh\"\n");
> +					return -1;
> +				}
> +				step_packets = true;
> +			} else {
> +				step_packets = false;
> +			}
> +		} else if (strcmp(*argv, "min_qlen_step") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&min_qlen_step, *argv, 10)) {
> +				fprintf(stderr, "Illegal \"min_qlen_step\"\n");
> +				return -1;
> +			}
> +			set_min_qlen_step = true;
> +		} else if (strcmp(*argv, "overflow") == 0) {
> +			drop_overload = TCA_DUALPI2_DROP_OVERLOAD_OVERFLOW;
> +		} else if (strcmp(*argv, "drop_on_overload") == 0) {
> +			drop_overload = TCA_DUALPI2_DROP_OVERLOAD_DROP;
> +		} else if (strcmp(*argv, "drop_enqueue") == 0) {
> +			drop_early = TCA_DUALPI2_DROP_EARLY_DROP_ENQUEUE;
> +		} else if (strcmp(*argv, "drop_dequeue") == 0) {
> +			drop_early = TCA_DUALPI2_DROP_EARLY_DROP_DEQUEUE;
> +		} else if (strcmp(*argv, "split_gso") == 0) {
> +			split_gso = TCA_DUALPI2_SPLIT_GSO_SPLIT_GSO;
> +		} else if (strcmp(*argv, "no_split_gso") == 0) {
> +			split_gso = TCA_DUALPI2_SPLIT_GSO_NO_SPLIT_GSO;
> +		} else if (strcmp(*argv, "classic_protection") == 0) {
> +			NEXT_ARG();
> +			if (try_get_percent(&c_protection, *argv) ||
> +			    c_protection > 100 ||
> +			    c_protection < 0) {
> +				fprintf(stderr,
> +					"Illegal \"classic_protection\"\n");
> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "max_rtt") == 0) {
> +			NEXT_ARG();
> +			if (get_time(&rtt_max, *argv)) {
> +				fprintf(stderr, "Illegal \"rtt_max\"\n");
> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "typical_rtt") == 0) {
> +			NEXT_ARG();
> +			if (get_time(&rtt_typ, *argv)) {
> +				fprintf(stderr, "Illegal \"rtt_typical\"\n");
> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "help") == 0) {
> +			explain();
> +			return -1;
> +		} else {
> +			fprintf(stderr, "What is \"%s\"?\n", *argv);
> +			explain();
> +			return -1;
> +		}
> +		--argc;
> +		++argv;
> +	}
> +
> +	if (rtt_max || rtt_typ) {
> +		double alpha_f, beta_f;
> +
> +		SPRINT_BUF(max_rtt_t);
> +		SPRINT_BUF(typ_rtt_t);
> +		SPRINT_BUF(tupdate_t);
> +		SPRINT_BUF(target_t);
> +
> +		if (!rtt_typ)
> +			rtt_typ = max(rtt_max / RTT_TYP_TO_MAX, 1U);
> +		else if (!rtt_max)
> +			rtt_max = rtt_typ * RTT_TYP_TO_MAX;
> +		else if (rtt_typ > rtt_max) {
> +			fprintf(stderr, "typical_rtt must be <= max_rtt!\n");
> +			return -1;
> +		}
> +		if (alpha != DEFAULT_ALPHA_BETA || beta != DEFAULT_ALPHA_BETA ||
> +		    tupdate || target)
> +			fprintf(stderr,
> +				"rtt_max is specified, ignore alpha/beta/tupdate/target\n");
> +		target = rtt_typ;
> +		tupdate = (double)rtt_typ < (double)rtt_max / 3.0f ?
> +			rtt_typ : (double)rtt_max / 3.0f;
> +		tupdate = max(tupdate, 1U);
> +		alpha_f = (double)tupdate / rtt_max / rtt_max
> +			* TIME_UNITS_PER_SEC * 0.1f;
> +		beta_f = 0.3f / (double)rtt_max * TIME_UNITS_PER_SEC;
> +		if (beta_f > ALPHA_BETA_MAX) {
> +			fprintf(stderr,
> +				"max_rtt=%s is too low and cause beta to overflow!\n",
> +				sprint_time(rtt_max, max_rtt_t));
> +			return -1;
> +		}
> +		if (alpha_f < 1.0f / ALPHA_BETA_SCALE ||
> +		    beta_f < 1.0f / ALPHA_BETA_SCALE) {
> +			fprintf(stderr,
> +				"Large max_rtt=%s rounds down alpha=%f and/or beta=%f!\n",
> +				sprint_time(rtt_max, max_rtt_t),
> +				alpha_f, beta_f);
> +			return -1;
> +		}
> +		fprintf(stderr,
> +			"Auto-config [max_rtt: %s, typical_rtt: %s]: target=%s tupdate=%s alpha=%f beta=%f\n",
> +			sprint_time(rtt_max, max_rtt_t),
> +			sprint_time(rtt_typ, typ_rtt_t),
> +			sprint_time(target, target_t),
> +			sprint_time(tupdate, tupdate_t), alpha_f, beta_f);
> +		alpha = alpha_f * ALPHA_BETA_SCALE;
> +		beta = beta_f * ALPHA_BETA_SCALE;
> +	}
> +
> +	tail = addattr_nest(n, 1024, TCA_OPTIONS | NLA_F_NESTED);
> +	if (limit)
> +		addattr32(n, 1024, TCA_DUALPI2_LIMIT, limit);
> +	if (memory_limit)
> +		addattr32(n, 1024, TCA_DUALPI2_MEMORY_LIMIT, memory_limit);
> +	if (tupdate)
> +		addattr32(n, 1024, TCA_DUALPI2_TUPDATE, tupdate);
> +	if (target)
> +		addattr32(n, 1024, TCA_DUALPI2_TARGET, target);
> +	if (alpha != DEFAULT_ALPHA_BETA)
> +		addattr32(n, 1024, TCA_DUALPI2_ALPHA, alpha);
> +	if (beta != DEFAULT_ALPHA_BETA)
> +		addattr32(n, 1024, TCA_DUALPI2_BETA, beta);
> +	if (ecn_mask != 0)
> +		addattr8(n, 1024, TCA_DUALPI2_ECN_MASK, ecn_mask);
> +	if (drop_overload != __TCA_DUALPI2_DROP_OVERLOAD_MAX)
> +		addattr8(n, 1024, TCA_DUALPI2_DROP_OVERLOAD, drop_overload);
> +	if (coupling_factor != -1)
> +		addattr8(n, 1024, TCA_DUALPI2_COUPLING, coupling_factor);
> +	if (split_gso != __TCA_DUALPI2_SPLIT_GSO_MAX)
> +		addattr8(n, 1024, TCA_DUALPI2_SPLIT_GSO, split_gso);
> +	if (step_thresh) {
> +		addattr32(n, 1024, TCA_DUALPI2_STEP_THRESH, step_thresh);
> +		if (step_packets)
> +			addattr(n, 1024, TCA_DUALPI2_STEP_PACKETS);
> +	}
> +	if (set_min_qlen_step)
> +		addattr32(n, 1024, TCA_DUALPI2_MIN_QLEN_STEP, min_qlen_step);
> +	if (drop_early != __TCA_DUALPI2_DROP_EARLY_MAX)
> +		addattr8(n, 1024, TCA_DUALPI2_DROP_EARLY, drop_early);
> +	if (c_protection != -1)
> +		addattr8(n, 1024, TCA_DUALPI2_C_PROTECTION, c_protection);
> +	addattr_nest_end(n, tail);

a '\n' before return

> +	return 0;
> +}
> +
> +static float get_scaled_alpha_beta(struct rtattr *tb)
> +{
> +	if (tb == NULL)
> +		return 0;

if(!tb)

> +
> +	if (RTA_PAYLOAD(tb) < sizeof(__u32))
> +		return -1;
> +
> +	return ((float)rta_getattr_u32(tb)) / ALPHA_BETA_SCALE;
> +}
> +
> +static int dualpi2_print_opt(const struct qdisc_util *qu, FILE *f,
> +			     struct rtattr *opt)
> +{
> +	struct rtattr *tb[TCA_DUALPI2_MAX + 1];
> +	uint32_t tupdate;
> +	uint32_t target;
> +	uint8_t ecn_type;
> +	uint8_t drop_overload;
> +	uint32_t step_thresh;
> +	uint8_t drop_early;
> +	uint8_t split_gso;
> +	bool step_packets = false;
> +
> +	SPRINT_BUF(b1);
> +
> +	if (opt == NULL)
> +		return 0;
> +
> +	parse_rtattr_nested(tb, TCA_DUALPI2_MAX, opt);
> +
> +	if (tb[TCA_DUALPI2_LIMIT] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_LIMIT]) >= sizeof(__u32))
> +		print_uint(PRINT_ANY, "limit", "limit %up ",
> +			   rta_getattr_u32(tb[TCA_DUALPI2_LIMIT]));
> +	if (tb[TCA_DUALPI2_MEMORY_LIMIT] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_MEMORY_LIMIT]) >= sizeof(__u32))
> +		print_uint(PRINT_ANY, "memory-limit", "memlimit %uB ",
> +			   rta_getattr_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
> +	if (tb[TCA_DUALPI2_TARGET] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_TARGET]) >= sizeof(__u32)) {
> +		target = rta_getattr_u32(tb[TCA_DUALPI2_TARGET]);
> +		print_uint(PRINT_JSON, "target", NULL, target);
> +		print_string(PRINT_FP, NULL, "target %s ",
> +			     sprint_time(target, b1));
> +	}
> +	if (tb[TCA_DUALPI2_TUPDATE] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_TUPDATE]) >= sizeof(__u32)) {
> +		tupdate = rta_getattr_u32(tb[TCA_DUALPI2_TUPDATE]);
> +		print_uint(PRINT_JSON, "tupdate", NULL, tupdate);
> +		print_string(PRINT_FP, NULL, "tupdate %s ",
> +			     sprint_time(tupdate, b1));
> +	}
> +	if (tb[TCA_DUALPI2_ALPHA] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_ALPHA]) >= sizeof(__u32))
> +		print_float(PRINT_ANY, "alpha", "alpha %f ",
> +			    get_scaled_alpha_beta(tb[TCA_DUALPI2_ALPHA]));
> +	if (tb[TCA_DUALPI2_BETA] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_BETA]) >= sizeof(__u32))
> +		print_float(PRINT_ANY, "beta", "beta %f ",
> +			    get_scaled_alpha_beta(tb[TCA_DUALPI2_BETA]));
> +	if (tb[TCA_DUALPI2_STEP_PACKETS])
> +		step_packets = true;
> +	if (tb[TCA_DUALPI2_STEP_THRESH] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_STEP_THRESH]) >= sizeof(__u32)) {
> +		step_thresh = rta_getattr_u32(tb[TCA_DUALPI2_STEP_THRESH]);
> +		if (step_packets) {
> +			print_uint(PRINT_ANY, "step-thresh",
> +				   "step_thresh %up ", step_thresh);
> +			print_null(PRINT_JSON, "step-packets", NULL, NULL);
> +		} else {
> +			print_uint(PRINT_JSON, "step-thresh", NULL,
> +				   step_thresh);
> +			print_string(PRINT_FP, NULL, "step_thresh %s ",
> +				     sprint_time(step_thresh, b1));
> +		}
> +	}
> +	if (tb[TCA_DUALPI2_MIN_QLEN_STEP] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_MIN_QLEN_STEP]) >= sizeof(__u32))
> +		print_uint(PRINT_ANY, "min-qlen-step", "min_qlen_step %up ",
> +			   rta_getattr_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]));
> +	if (tb[TCA_DUALPI2_COUPLING] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_COUPLING]) >= sizeof(__u8))
> +		print_uint(PRINT_ANY, "coupling", "coupling_factor %u ",
> +			   rta_getattr_u8(tb[TCA_DUALPI2_COUPLING]));
> +	if (tb[TCA_DUALPI2_DROP_OVERLOAD] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_DROP_OVERLOAD]) >= sizeof(__u8)) {
> +		drop_overload = rta_getattr_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]);
> +		print_string(PRINT_FP, NULL, "%s ",
> +			     drop_overload ? "drop_on_overload" : "overflow");
> +		print_string(PRINT_JSON, "drop-overload", NULL,
> +			     drop_overload ? "drop" : "overflow");
> +	}
> +	if (tb[TCA_DUALPI2_DROP_EARLY] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_DROP_EARLY]) >= sizeof(__u8)) {
> +		drop_early = rta_getattr_u8(tb[TCA_DUALPI2_DROP_EARLY]);
> +		print_string(PRINT_FP, NULL, "%s ",
> +			     drop_early ? "drop_enqueue" : "drop_dequeue");
> +		print_string(PRINT_JSON, "drop-early", NULL,
> +			     drop_early ? "drop-enqueue" : "drop-dequeue");
> +	}
> +	if (tb[TCA_DUALPI2_C_PROTECTION] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_C_PROTECTION]) >= sizeof(__u8))
> +		print_uint(PRINT_ANY, "c-protection",
> +			   "classic_protection %u%% ",
> +			   rta_getattr_u8(tb[TCA_DUALPI2_C_PROTECTION]));
> +	if (tb[TCA_DUALPI2_ECN_MASK] &&
> +	    RTA_PAYLOAD(tb[TCA_DUALPI2_ECN_MASK]) >= sizeof(__u8)) {
> +		ecn_type = rta_getattr_u8(tb[TCA_DUALPI2_ECN_MASK]);
> +		print_string(PRINT_FP, NULL, "%s ", get_ecn_type(ecn_type));
> +		print_string(PRINT_JSON, "ecn-mask", NULL,
> +			     get_ecn_type_json(ecn_type));

> +};


Thanks,
Alok

