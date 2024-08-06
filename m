Return-Path: <linux-kselftest+bounces-14846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F17948F0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45907B218CC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74DA1BE23B;
	Tue,  6 Aug 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wgr5uzpR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rz7t/F7E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB541DDE9;
	Tue,  6 Aug 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947649; cv=fail; b=HUp0ey+p2QefyhzjhXEvOAcbZu7MGx0zx65NLg+RYXe2iv+5fancqK3cUX812Ed6qo21QQRRD7IUKzini1iM9DH6w7gzUl5En+hLnMTQ3JHkvGPhAw3TSHA90ZvbGCzMwnb9Bd4+xFOi6KoTgv0O8zS7gigjtTx2Sf9l69w0BVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947649; c=relaxed/simple;
	bh=ic9Zq2rPIqqUNN82YTPhib3EQ7jclBwEH0KTGtO6kq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rgssm52YKyJXT4ab5hobQ+8qOOViXMkgSG/1T80TSQ4PVj8Tpaj2F4F7wi9lvTWilVmj5JvxSH/4QPxLF7o9bcT6D1i17SGTieIGqNkmVBZfmkqX9G5JwFvR5KL32u3i8HKmdWPYnd7OyA8Au5lUwKbNIjzzJTAO3snU6/o2HtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wgr5uzpR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rz7t/F7E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765kdKc020892;
	Tue, 6 Aug 2024 12:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=114NsCYPec+UcVtxLgfppl7Lnr9EawnszLzTrnZkRvM=; b=
	Wgr5uzpRLUS0ilpxYd72Xgzt45q40L4aE4tZlfbGnxcUu7b+y4L8UI13LEk2Bsz0
	PMD0E+KV0/jYEIkx19EwVl2VyEGcoOrOuVpR2yjVW76WViBuQciKLQjL0JQLvav0
	7geGszDZ605oVjER1xcMnyn0+DYhnzjywholEXU06b5yjw+OhzETVPCrMT2NKPZQ
	njwzyvFUx8Yiv0LtKIFUVOPmHFY8HwYayGLDcc5rLKW+EZxqhzwtOXlB8ipyyihK
	8E/5d7ecPbcZeBSHxy62RtbnIAcmlZtO/TyEy/cR5Z5nT0wqFdk0pgMYQ4WkxKRY
	RGSDDxFUf1Im/MZr01joZg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5td5hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 12:33:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476BahfN018352;
	Tue, 6 Aug 2024 12:33:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08kgd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 12:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kfg9aneAx6TjM1m4nDeTj2RPcMKvduN5T/vOs0NGmyhiqR5FYG5/MbKxyjf4zhXkdz+M5mEN/EDcn4kPF5xPeYVXJ8LxZa2Oe2j1XDELVOBhmZKjzevGhqnug+3liLWES2yiEexZhJsEuAse0J3hF4K2wAAHEXsG6TdPF36Xmip/PvndE4Kk3lc6fwa4KMXLMpUBP22MklCnf65k2yo9W+43ercSnH0SY+1RLtcY2y9sB1PK9WV+GQhmcOVnaO6ljuMK4VLl3bTdV0joXgXncNbB0oTXXL36q4EVbe01iCu+5MWA0MPinTLnqTA82P7qmtT9Fq1vdc46ePbhAZRorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=114NsCYPec+UcVtxLgfppl7Lnr9EawnszLzTrnZkRvM=;
 b=CArMfRUpVb1Nc13/1O6v296r3KUfYGGvIcPjY8iO6Qma6M+FySKbUn8niniPakMULqQqAvQXIesINcLkc/s36ak/PvFiQ21Pi7wZXbbcTisYTmRNPFF4WNiE7F+UbT2bO/RFeVJwkPhVtcR1sJ8adIGxZSFtSfDKC+52zAMSE5zowDu+QXAJRf3T6FPfqtSAFKO5BGLgR/42hsodnfC0dSR7lb58IbJb9vkss3qqs4CSCYHVUk5uwSNWML7VvIl869QZYQOSEl+NEqWEo0P+i/PBxQnGQsCA9auiN78I77KBSWFI/S4gfhVkOr48K9GJ2URj61la7PFKZYRouYqC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=114NsCYPec+UcVtxLgfppl7Lnr9EawnszLzTrnZkRvM=;
 b=rz7t/F7Emm4wk/UlAHMkpr3vNS/SpJiKEqFXn0HAYTq5KhWsifQyCY8RzcjyZPuDuAyh0HWyPtEGe2rZrIJhfTKH2tBS7NER8g+FlJLUQ6AUTcQ4O2VFImucOXicSPfjmC1+StW/iZLe3KgUbw8TrhrSpKO88PbyWZW7k7fHR+k=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6240.namprd10.prod.outlook.com (2603:10b6:930:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 12:33:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 12:33:06 +0000
Message-ID: <05d39d25-d132-4194-a2a1-fbae8917e70b@oracle.com>
Date: Tue, 6 Aug 2024 13:33:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: add proper section name to
 bpf prog and rename it
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
 <20240731-convert_cgroup_tests-v1-3-14cbc51b6947@bootlin.com>
 <e8b88d27-4e85-46f1-8ed4-df883abc8a51@oracle.com>
 <263cd78b-0392-45d4-a13c-b2b0463c4c8c@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <263cd78b-0392-45d4-a13c-b2b0463c4c8c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 3757153d-d5d3-4ca5-4ce7-08dcb613ec48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk83ckxaMERjODhXWXpYVWJDbW1qQVJwYVdmTFY0VTdsTTdTREhNbitrVVlq?=
 =?utf-8?B?UG9tZUc3bHgzNTFEbnlXZ3oxTGJDREo3N0xMdWpDR0VTNnNxRmNrWVBPeGJp?=
 =?utf-8?B?TXdnTml6dmxBbUI2QjFEc1V6STFrZ1NXWnIwSnNhU0xtcnRveVlNS2tML3ZC?=
 =?utf-8?B?WmpmbzNYcFFNaXBaN0RnMk80VTU2Z2NYdE9OblYxcUl4NFlDaEx5RUlLZ255?=
 =?utf-8?B?MW0xbmZUbW5VTlRPbmkyeFlTa0drbXBJcFpOa0JkenNOWjEyNHpvREZzTDhi?=
 =?utf-8?B?N08xRXdyZ29WdWRWU1Z1a1QxQ3FLaGJKZVhoU1czblJGY1dTNXZqWmhKeEtv?=
 =?utf-8?B?aUdhcWk4Zmt0cXgvRVh5WDRoSWxoRXZWeXdTR2VtMlBjN243OERNTkNwZHFv?=
 =?utf-8?B?RFNLdFI4QkZIdi9aMWlXQnpLODRSRkJBL1JEZWpWNUlKVzE4d3ltVFhSQUt1?=
 =?utf-8?B?Q25WT1drWHh0blFlc3c4OHZZeldidWQrS3dWZjNDcTZrVlRQZmN6Ym1rSGpO?=
 =?utf-8?B?aHppMW9mdFcxLzZIZC84cG8wb0N2V0gwamlkSmV1RlpRK2ZkQnpMaW81WjY2?=
 =?utf-8?B?VmZQUWYwUUlYbnR5VnkyTUZwa0ZKV2FWK1FvcmNuMlpNeVZJZEw2TnQ5dmEv?=
 =?utf-8?B?NjZYM0svTG5WbEkxTVN0SnMwRzZCVFl0bkdpRVdQWDN5TURON1VxOUZiTzZS?=
 =?utf-8?B?QnNoUXJlVXI0eWFjWXZRRjBoNXlnQWtOVUVCMkhNWXJwWmR3TE5uYkVGVEJx?=
 =?utf-8?B?WmV2d3ZJSVpzV2wyL2hvdm9KQVBKdVQxWVkvWmxOaEFMb2hyalY1a2F2N3VO?=
 =?utf-8?B?WDBTTHBBQS9UOE1jZU9oZ0ZISEQzbkFlTGZMZkIzeUkvZi9lU2RZZncrV1BW?=
 =?utf-8?B?K2lxR0kxdmN1Q043MzRxL0JXcGQrbmsrN0tMekNCdTB4Undsdit3S3BkeURs?=
 =?utf-8?B?V1pyR3YrbVArWjhKeHY2UXQwb3lLZlNHaWk5MXV1VXpHTmN2WTUvZithVTNF?=
 =?utf-8?B?eURLQnNieFkrcTZHRU1pTXFUYWdVVzBVMURFWDN6eTFXVCtMaVY0NUlmcmxM?=
 =?utf-8?B?Z2tUVk85N3Jkeml0NkQzS3VzZ2FueCtpU2g5TVNvaUVjekoycXBFd2pUZTN0?=
 =?utf-8?B?NllWSk0zZCtpb2FJVWtORGZEOHQwNXZLR2RQVlZBeE5XN0pGNXA1K3BQRVR6?=
 =?utf-8?B?OVlOS25udkhlSVdpWHRkbDJMMUhpbFU5TnZ3V2lGdXd4U1JxNW4vTTVReHc3?=
 =?utf-8?B?TU1hNWpKeUJjTWN2bHE0blN2NnJwdzE5bkJLWkRyVGNHV3RmdW41RGVxY1Jt?=
 =?utf-8?B?dzhSUzJKSU1KWGhuTkdFMmk1MjAzTWlERXlTRzhFMUtCaVpzRlVObkVYQlJl?=
 =?utf-8?B?c1RRRTREVVhpR2JMQW9vWlpMTmtrWXlIRmJqM0NSTU9tNVp4aGR1dHFYNGtD?=
 =?utf-8?B?NmNoN2l2UERoemZYdG1lVFJEYktIOXIyT0xGdDE1eTNjekhpd2pkU1FSdTAv?=
 =?utf-8?B?Mm5SQjZValZMV093eDU4aCs4OFpmWTlTenlobjNjTFdIMGRXaUF2Ny84V0dW?=
 =?utf-8?B?elhWdjRGZ2o0OXVkWElJOUZzazRNZVRmWVBBbGQwNXkvTGVuSFF2d3pDZVph?=
 =?utf-8?B?TG1WU1RxRStKaENuOFNzblFJMDFsTDFtOGtrRUxtZUVVUnBxWXVvd2hDZVJy?=
 =?utf-8?B?a0VpdUNUYnpDcnB6ZmJxSDlOY3JTa3N6M0M0YW9VUUhId2NVSTJESUYxNUJa?=
 =?utf-8?B?VG5FZjFRYndscmFVU1RFb3hNQXRjdU1PczBFRDJqbDFBM1ZSOU93eEZGL25T?=
 =?utf-8?B?TXo0bzltR2dpK0ozVWZBUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXJYYmtjQnVzcldVenFsakJTM2tlLy9SalFBUk1CY3B2Uk94MjFLMmdUZUcz?=
 =?utf-8?B?VkhMNWVzUE9nOVRFTmJkcTR2eTNLRmFaemtPOFRib0VucW5SWWY2VTA4aFhq?=
 =?utf-8?B?R1dDVDBBem9nWnoxOFVNNFVMUk43UVhuZmpqbys1UWRrRVZ5dFYxWWF3SHJG?=
 =?utf-8?B?UzRBalk2NlhqVyt0OUVod1FZYzFaSGdvams2S3FBM0FCOFl3UkhXb3MvQi9m?=
 =?utf-8?B?L21XZU9ZbzZLMW00TUxPQ1doL240NU9Gc0hCanF3TllCc0VURkoyU0Y0R0pu?=
 =?utf-8?B?UDlnUk1yOWY3VnlkTElaMEtLZFNCR3dkMXhmNjFJYU9BNTZsQndKaGpMVnps?=
 =?utf-8?B?U0M2OEp2UmV1cXVGRW1xcUNvQjR1OHJxRjVwcy8xb08rVHdVVGVSaThQUzJG?=
 =?utf-8?B?bHZqeVJheUVyUSswemRyTXRYamwvaHhCVDdsUU9kSWllWnNBV01sZ2NtZnJG?=
 =?utf-8?B?alFWc1hLVEhlZnNrWE9IT1VZS0JHMU1JblVWZUVQcHp4U0p5b3NiT1cyaHVa?=
 =?utf-8?B?TkJGSkJ4a0MwbE1ER2lGd2tyd2ZxWm50d2RERlEwZDd6UlFKU2FtK0NTWjcy?=
 =?utf-8?B?R25NRG42ZlJQRFhJOXhHNEoyaWd3WHgwSW5KQzRYVjAwT0IwQ0VaVVBhMms5?=
 =?utf-8?B?WllBVExFZm5QdTIwMlE4aW1JVE85RTh1anAvNWtLeXB5dHBKcTBJdm5iTEJm?=
 =?utf-8?B?UFdSYmxKdlhFcWs0RzlWMVNaNnZOVkYwVWFvNHpQM1J2Ykw5bFJaRHVZSzgz?=
 =?utf-8?B?dlJBcU1aQVpyQ2NiS1dpZXhYMEZ6SFFUcmZ6SXpxa1VZSlZYUkcrbGdweXZW?=
 =?utf-8?B?Nko2ek1KcTdYSUhBS1RPbGw0bUhCWEJpSzJuVEc5V2JsbDJXd0FBdzZjR3BH?=
 =?utf-8?B?a01QQTlON2VFUlV4d3NuajB0Sm1RWHZGNStBa0loeFhob095SmtOS3NXUHp3?=
 =?utf-8?B?MS9xTllCaGo0ZmFhQS8zbzFpclgzS2t4ais5ekp6aGJYTUxwTXUrQmxYMDcy?=
 =?utf-8?B?NmRtYWJ1OG43ZjdIQWVDV3Z4Y0I5ZERDMnloSm0rcXlBUDlEUDFzYWgyWUVZ?=
 =?utf-8?B?alc2d3hhUmlrS1FBc2ZTMU93dWx5cm42S3dtMEM4VmpKV2t6aU9rWDlXYVRk?=
 =?utf-8?B?Y3NjQkVNTUpxb3VrdnhlZjM3M3c4Q05uQjhDOU1TZ2FrUU84SWpCMWsyTVNP?=
 =?utf-8?B?c2lwdXpuSU4vUVY4MTM0Mkp6SlFQMmJEWTB1djBubUdxOWpmdFZYTXVMa09r?=
 =?utf-8?B?R0t3RGs2VlRGcWtJQXIwa3Z6d2dnQUt0YXpJR2E3dGFsR0lGSjVCMHozeHJU?=
 =?utf-8?B?aUxpOFk2TmxMS0hVWm44dkZOMnV0YWthbUlFaUpST2dsV3hQRTBwMEw1RWE5?=
 =?utf-8?B?SVFQa3lhbzNSZDNoZjRhSC9Ya3pIaWhQVEN2Z1grOElRUXMzbmRBYjRITjJM?=
 =?utf-8?B?Ty93V3h2THNrbkEvVHhnVjY3c2xRaFFoK0oxRlJVNWpZUVcwSlU4bGtCenpo?=
 =?utf-8?B?K1pLcDAwTnBxRy8zeFJ6OHc5R0RBMkZMa3pncGJkZldabFFnMmdDSjdSTDZ6?=
 =?utf-8?B?OHhoREUzYUtiMGlMS3RaYk4zUDduZkZqQkRuR290amEzWEZBR2lmYzROZUhX?=
 =?utf-8?B?R2xBelFkd0pnZnBGeVcvNzJlUmdVOG0zYzFhbzh4WWsxdUNpVUFNanFyNkNO?=
 =?utf-8?B?WmtxcTdnbVB1ZDVaNHhNNXh0M3JNTG1UYVJMemxjbTlhNVh6WTVQZm90TGQw?=
 =?utf-8?B?S0ZZL1hyMC90a242VGpmcGpjdUlUK1FNNmhOMUVnNThrTUpnd0J0K3FmVjBU?=
 =?utf-8?B?U2Q1ZTFPTVFTY0NTMW9vend5U3Ayc0pkT2cvV0VIZ3hBSkFQaWRwMnpwSElY?=
 =?utf-8?B?Mko3ekh4T1c4TmE4M3pYZGJFazRTaHZDbk5ZdStoKy9MNmFJaFppYWNKa0Vo?=
 =?utf-8?B?T0wxTUdQSGFHdHd5K0lRTURhdHRxZTNzcENiREk0dkh2RG0yQTA4b2RMT1dE?=
 =?utf-8?B?dmt2SWtndWdRNFZ0ZlNkZmVZbU1naHUvb20rUVN5TEdBMXl4Y0NhTThiMGt0?=
 =?utf-8?B?UlcvYm5SZzgxME4xYU5pSnN4aU9ONm9sQm9sZWpDM3JlNVRJZ0FLS0tweDVz?=
 =?utf-8?B?Z0NnaHowRUlrMmsvVVFtNDhGWUpXanJhTFRDbzlBTzk3YUpwNmhwS2tzYWFZ?=
 =?utf-8?Q?HxI5wOzYZzCjyz3R6zHA448=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rRR+dXKgVeBNodpPsAXBz96lVPWFUik404RUQ7xBYe1GmZRoR5OQqEDxF/1BB+XgkJR9+xGml0wCRdLmj2qS+np3gZrc4jVFWjw2zS9rOVogf05ao5JqgHnyE1i3A/05HzY40ioIWPbIsOckI1UOR993/YsSFf/UxUCQt3l8AUku5i1HsmibaWjMDePskgVEBQUW6TjqcOodJdolDANVmv+J2X4CcXCv6ib59c04JDc+3+Z0st/Ky2rp1sN6RHdurCN3UlZnxxeCTWA7K68lR6edTZifbOtohXonVdQiy5hsx1hdkU8CWoCFaThSExm5dgGjEU9eRxDghC6nL1yWpK9m/bJIVOZdM9k3GvKdxOifotek9TvfZksVUBnbPWhndTuUbMB7H0uirPxegMK+KQ3JHE8s5mf4T8EtPYS8/+cXMrl+grDGSJg0qlHG4vf4Bu+HzeQo60tfNNCHZ6Ewes7b6b9DuVo7pwhBNe2kYjK+SxHCy8PKc+WPMhT4QjZ6RcZTG+wDEB9/3Prpqh7+iIDdQQO7u1xr7nW0O3LBUynkcS9efZfOPLL4TEd/sIkgu93XEIrQD39gp16DgUJnaD3Z/DRQZIgYTl7eYMP/51Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3757153d-d5d3-4ca5-4ce7-08dcb613ec48
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:33:06.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tgcUXm87HY0Oa5Q5AXLRvh1xy/hFgrepmX5ZWlBiK1TCnbqeNUSFgb7kmYaavwlInvx41AGhx2xF4ZeB38j2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6240
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_10,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060088
X-Proofpoint-ORIG-GUID: WuTICzwXcCJF7go6LVHBB9C3doiwazUO
X-Proofpoint-GUID: WuTICzwXcCJF7go6LVHBB9C3doiwazUO

On 01/08/2024 11:00, Alexis Lothoré wrote:
> On 8/1/24 10:35, Alan Maguire wrote:
>> On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
>>> test_skb_cgroup_id_kern.c is currently involved in a manual test. In its
>>> current form, it can not be used with the auto-generated skeleton APIs,
>>> because the section name is not valid to allow libbpf to deduce the program
>>> type.
>>>
>>> Update section name to allow skeleton APIs usage. Also rename the program
>>> name to make it shorter and more straighforward regarding the API it is
>>> testing. While doing so, make sure that test_skb_cgroup_id.sh passes to get
>>> a working reference before converting it to test_progs
>>> - update the obj name
>>> - fix loading issue (verifier rejecting the program when loaded through tc,
>>>   because of map not found), by preloading the whole obj with bpftool
>>>
>>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>>
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [...]
> 
>>>  	tc qdisc add dev ${TEST_IF} clsact
>>> -	tc filter add dev ${TEST_IF} egress bpf obj ${BPF_PROG_OBJ} \
>>> -		sec ${BPF_PROG_SECTION} da
>>> +	mkdir -p /sys/fs/bpf/${BPF_PROG_PIN}
>>> +	bpftool prog loadall ${BPF_PROG_OBJ} /sys/fs/bpf/${BPF_PROG_PIN} type tc
>>> +	tc filter add dev ${TEST_IF} egress bpf da object-pinned \
>>> +		/sys/fs/bpf/${BPF_PROG_PIN}/${BPF_PROG_NAME}
>>>
>>
>> Just out of curiosity; did you find that the pin is needed? I would have
>> thought tc attach would be enough to keep the program aroud.
> 
> That's more because that's the only way I found to make the filter addition
> work. With the current command, the tc command fails because of the verifier
> rejecting the program:
> 
> Verifier analysis:
> 
> func#0 @0
> 0: R1=ctx() R10=fp0
> 0: (bf) r6 = r1                       ; R1=ctx() R6_w=ctx()
> 1: (b4) w1 = 0                        ; R1_w=0
> 2: (63) *(u32 *)(r10 -4) = r1
> mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=r1 stack= before 1: (b4) w1 = 0
> 3: R1_w=0 R10=fp0 fp-8=0000????
> 3: (bf) r1 = r6                       ; R1_w=ctx() R6_w=ctx()
> 4: (b4) w2 = 0                        ; R2_w=0
> 5: (85) call bpf_skb_ancestor_cgroup_id#83    ; R0_w=scalar()
> 6: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=scalar(id=1) R10=fp0
> fp-16_w=scalar(id=1)
> 7: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
> 8: (07) r2 += -4                      ; R2_w=fp-4
> 9: (bf) r3 = r10                      ; R3_w=fp0 R10=fp0
> 10: (07) r3 += -16                    ; R3_w=fp-16
> 11: (18) r1 = 0x0                     ; R1_w=0
> 13: (b7) r4 = 0                       ; R4_w=0
> 14: (85) call bpf_map_update_elem#2
> R1 type=scalar expected=map_ptr
> processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> 
> (I also tried to remove the sec argument from the tc commandline, in case it
> could allow tc to load everything, but the issue remains the same)
> 
> IIUC the verifier output, there's an issue with the variable representing the map.
> When stracing the tc filter add command, I indeed see the BPF_PROG_LOAD syscall
> but no BPF_MAP_CREATE at all, so I assumed tc did not read/create the map
> correctly. That's why I used bpftool to make sure everything is loaded, but as a
> consequence I need to provide a pin path when using load/loadall. But maybe I am
> missing something ?
> 

No I think you're absolutely right. It seems like there have been
problems with BTF-defined maps in the past with tc filter loading [1],
but more recent tc fixes this since it uses libbpf under the hood. I
tried with the section name update only and the test passes, so it might
just be a tc version issue. As in [1] I'd suggest compiling an
up-to-date iproute2/tc and re-testing. Thanks!

[1] https://lore.kernel.org/bpf/87zgkx9l6y.fsf@toke.dk/

