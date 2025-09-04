Return-Path: <linux-kselftest+bounces-40803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F92B4453A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 20:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09F85612A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0F341646;
	Thu,  4 Sep 2025 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="si804De0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o1RXfic/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62990223328;
	Thu,  4 Sep 2025 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009969; cv=fail; b=dnLxXGne9Cxi7r1HFgGCkIsvUa7ZddwBgLyv/+DiwF4N48yrxjWqcaYLOOpGKWw5xyzj6B9B/QMaO1Nywaap75FZR+6OnNUQtKvG+vPOBeOWx+HVhcXLmd7gSkrne7PZjDGB50rGjT8EYYLol+McxC6iPx7m4r0K8xhXgxlq0N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009969; c=relaxed/simple;
	bh=I/SFsPmOXQGpgDCll+BWPgsbxhZZk4goIoBfoovIVaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dha1El8bjkgWJ/xKahoqfVhQjljdaODVVfCdnDT1MvFm110VxVbM3tEOIgkufwyL2avLFPJgw5usn6L7PP/1FV+d9xHDrYnnxZ+/CzLXyhFA1Oqp4puDtminKiySyZIyC8qFEWmFj9Y3KeuplQU1ryVl1J1G4wZnsgBK5wjpD+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=si804De0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o1RXfic/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584I9Swe031339;
	Thu, 4 Sep 2025 18:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4qxX494E5cO8brmj3juf8Gd2XuLFUoK6j+4qAXh9PSg=; b=
	si804De0Nyh9RgdwU7ihfQ77vuiNzjSkmeMx71H7Ed6DyDma8jHO5F3cqPTD9trd
	SPI6HVqr3G91IC4483IWdrU4Dq7VxL6iKntJGnbztYHR+ajdyuzw/51sTQvog4M0
	lcrSR3822S6qYXJrfGql/izHeljkddoQFCgFS4dJJQMoPlMHw7g0EuH4nOlliTky
	ckqVaYRHl6REMFE52BNJalDWqRFMALAmQpDitOpCiy0llQajDL1Vyy+Y6q7e/kk1
	ElUVtI8EnjdbnFvmwjeAf8X9JVXnxfTQKGo+2sQfnGoDeWgsJaiUwczYZXwfjhiT
	iUu9uhMvqGCSBfmkYCoggA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yft280wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 18:19:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584H4ZnA030953;
	Thu, 4 Sep 2025 18:19:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbytbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 18:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCtnWFuzA69aFHBk+njoWRwiBLxxaKvQfY9qdzBnqNxq/czSdmM1uI0eXTTktBzUGeBkuadCNoWNsMoUxyQH4cal8c5smrxbGivJLeEh4XKJOWXSUbtTtY+737T8oGCN7ZEb/CzNhiu1LRuobaABUIKuJ0bXA7BnU6A6NkhRw+n4vZEWzMALwNowTsVYpS666FKY2TcgYMhNlsHy1VSMS+kXsdA+su9w+o6FU/Pb+w4MmfdQlovCmKiTcSDDD3gYcPMiidpgqaFx5L2byVAVmE4GQMU2Q+5+sZav+EvHpiYpCXCkkV2n7FARlfUY3gIEEHs4fLTXqXvvSYKOSBnd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qxX494E5cO8brmj3juf8Gd2XuLFUoK6j+4qAXh9PSg=;
 b=p+ZsBYNoLHPaHBG74jQEEAQJzAMTZn7oA9JJDFXu6yxwk1XhPOrdWGenBvfnd4Lj9IIn1ZgR3p1Dx1jtfkQqdKY2tZ7s72aZ7jJTggUJZXvgxAEtR8TloxuEp8fX6oylEz2Zcq2ntFfdagR0g9Z0NZqqqEOqoZD2ZbESLz2ScWNXFlCIgT0DbrV6c71KPinTUMIueynAZRMw5y4J6GpJOhy8SkzSqT5ZOGipEy/dKf/896ackEiqwr+enAf2QgJibmLz+gyBULSOKTbwiJX2rX5Lu1xT9rZnhXal3yHg6rdxItcEYygr98vX54Zs8KZowjRVaiYXq8x37WMQXqkjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qxX494E5cO8brmj3juf8Gd2XuLFUoK6j+4qAXh9PSg=;
 b=o1RXfic/hv/zxKtlFLT5ujNg9nXPNreBIIvBxSAJMOIyZUlQkyDM8dqjlkme7VoA1UvDwzhqVMEwjGHUTGGtHpW8wOirkA8mpgBAaVrCfUkARakZ/+YI0h5tORsU+9bfFunMD9Rk74ucYcWNW/3h0jmxWrTIPWKQbpqrCAh62aY=
Received: from SA1PR10MB5509.namprd10.prod.outlook.com (2603:10b6:806:1f5::20)
 by PH7PR10MB6034.namprd10.prod.outlook.com (2603:10b6:510:1fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Thu, 4 Sep
 2025 18:19:18 +0000
Received: from SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24]) by SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24%3]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 18:19:18 +0000
Message-ID: <149d275f-e03c-4911-bc06-530a7ae67fb9@oracle.com>
Date: Thu, 4 Sep 2025 12:19:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
To: Kees Cook <kees@kernel.org>
Cc: luto@amacapital.net, wad@chromium.org, sargun@sargun.me, corbet@lwn.net,
        shuah@kernel.org, brauner@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org
References: <20250903203805.1335307-1-tom.hromatka@oracle.com>
 <202509040837.78EFA6E@keescook>
Content-Language: en-US
From: Tom Hromatka <tom.hromatka@oracle.com>
In-Reply-To: <202509040837.78EFA6E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:930:a1::25) To SA1PR10MB5509.namprd10.prod.outlook.com
 (2603:10b6:806:1f5::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5509:EE_|PH7PR10MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed5605a-c7be-4a45-f2dd-08ddebdf8fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enFDTElLQ2xKeXIrVDVSenU3SllCNHNSTVQ4NjN0MXY1OHVGVzI0blNUZkVC?=
 =?utf-8?B?TndERGc3Q1hrcm91ZFhEVDlEd3lnM1p3VjJhT1d2ZnlIbWV2QVpXbndDSENr?=
 =?utf-8?B?bHRSWVJvUDlpb3Z3cjFxOHlCblBoeXYxb2NYNE5uTlRpVE1aRDNQdlJoK0ds?=
 =?utf-8?B?QTBpRXI1ZkpKMWthYVU1a2U2eHlJVmx2cXZrQ3BiYjIvVm9EQ2tiSHRCLzBV?=
 =?utf-8?B?MDNsQ25lS0NJVmplL1NPTGdXMkhwZE5YT2p3RWdOU0R6aWpNK1BPVUNaZWpk?=
 =?utf-8?B?aXF3aEo4Z3Q4MUMwQ0tMV0Vtcm5CU01iSy9DYmE4SUY0U2Z5dzYzUm4vN05K?=
 =?utf-8?B?R1lTcUxodkNleHhkRjNYNVZmNmNiN0djdkhsMDUyQXR5MGU4UUdRaW5wVEtj?=
 =?utf-8?B?dEhYVzE1aStOdGV1VzFwbDU0QnNmQXBzZlhTcTVCWW54cnYzN0hQTG91M1J5?=
 =?utf-8?B?WFhkRWtzT0hoc0FycEhOZGtqTFloQ0pFUHpZMEQvSkRnenZuMlJtSGcrMkJm?=
 =?utf-8?B?RFlCeWR6WnJ3ODFOTnVmNkc2LzhpYW4rSkY3aDd4a3dyRkJ1Zk9aS0tTVUR2?=
 =?utf-8?B?TzJVdWdDei8wZlhzam81SkhWSXBRZ2xhUXVXWVh6Z01iS3VGYllIYVdSY3Js?=
 =?utf-8?B?UlRsZ29Cby9SNElIQnExRkkycU5PdDRUdWZoUmRNd0EzUHBrN2lXb1RUaGNk?=
 =?utf-8?B?Zkw0QytsZzYyUlRiY25PQjVUKzVNb1d2RmJsdmFIbGhlOVVubnlhWE45RjZG?=
 =?utf-8?B?czlHbkxaUkd3SmpVbFZ3b2EvUm5GUVN3ZjZwaHduTE1jSW9tejJieU1xZ1Rp?=
 =?utf-8?B?aW1iTUc1aENtTWNrZUQvaWtqQnlSTnJKL25NOVk5Y2lvODRoalRKQ2tyYldG?=
 =?utf-8?B?NVJkS3BJaE9HRWw0MTlNbTcvUDU2L1U0RTk4SXV0QUxGZEdtSG5pc011RU9K?=
 =?utf-8?B?QWltLzVvaVdiM3FLNGtHRzkzUmEzMHdBWklycDMxbkJyZUtmYzMrYXo5SXZY?=
 =?utf-8?B?cGZkK2RsbnRFY3hkMUNoS0ZPSEdMMUl0RndJS3BSWk4rRE5ISXFVWUgvK3Zr?=
 =?utf-8?B?RnJrTlAyT1FaVC83SmVXQy9qSGFwM3I1U3VBU3RHa3dwR3dsc05FaHJ6Vzlq?=
 =?utf-8?B?WHZLWkJwY1BhR2tLMnBjZm1pMWtUKzBXZnVpM0lRTnkyZGdSZjBWa3Yva29y?=
 =?utf-8?B?KzdYdGZkbUdEdXFma3JNSW85YXVjZkg3Q3RQSUhTR3IxVElOdTBrNkNuQ25Z?=
 =?utf-8?B?NXF3QXdWVldyTEFmM0JDSlU4MTRMdlo3M3hpRmNESHd3YUVRUU9qRjZWbmVZ?=
 =?utf-8?B?dVdqd1U2RFRaeHoxcU05VEVCTlRRNStvWGFhajFjV25yZSs3L1p2aS9FUmw0?=
 =?utf-8?B?YUtUVGhRejk4cGd0Mk1rMElsWDZSQXRmTm1HSVhTemdaWU5xbXRERkozV2kr?=
 =?utf-8?B?eTlNTW84bzRmd0NxWGgrcnozcXBSdVZDci93dkZWL1Vyd1VtWVVtRmo1dFRM?=
 =?utf-8?B?YjhCRHBPTXJDRGtoYUEya2F2cUZkeG1KWjgwUnk0ay9kYWpURHVuMlFiQ05Y?=
 =?utf-8?B?eHJzcU1teXRvWnUzdGdVWU5ibmswc0hUU0oxQWJXSG5UdXloWXdjSjB0SW5i?=
 =?utf-8?B?NE9WME9YTTRFbm55NnFmRnpnNFloNHYvb2YxOFc0V0wzbklJd2o3RkRTN3p0?=
 =?utf-8?B?a0xCM1krdVZyZldqbE5Eem9JajBtVUhiNStqaER5VksvVmtGTnJxcTNMRjUy?=
 =?utf-8?B?L0F1TitjL0oreHlFQkxOYm1uUFEyTFBWWFdwbGJ5QnpUcml2TjhoUUI3dUZ0?=
 =?utf-8?Q?Dal236u3uhWLoZ/zy2OdBWFruTCAdWWHVSPZs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5509.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME9BYUFBNWVUb05xbE45WHlLTEdJQTdkdnkxUGpUenVVUGFnUG1sVHBQQ3Vw?=
 =?utf-8?B?dnNLYTVLbW1BVEFzZmVPT2xOZzZEakloUlNKcm1KSmwxSkhsb2V0QTF6bDg3?=
 =?utf-8?B?ZUJwS1kyU2U3UkpDTEZuNUZWenVqZnYwTzU4MXpIZVNyR1VLa3RTVitxajVJ?=
 =?utf-8?B?N3J0WWpac2NiZ1FTNll6Y3hndllXS2xiN2YwcGhCaUJaRkYrRVQxL1dHdmg1?=
 =?utf-8?B?eUFEZjBnMDFQZWlIS1dPaHU2RTkyRFZyZmtMTDFJYTlzbENMRjBXUXhvTmc0?=
 =?utf-8?B?eUN6ZFpTZ3p3ZnZHdXBSQ1ZHeVZyN09jeUh5VFIrSVZDM09QbkRJbWp0QXMy?=
 =?utf-8?B?MTdIbnVsVEpYSFFWVks3VW52WU1lQzVaQUlhZ05XOHFueUhEOVZpTk5qR2FK?=
 =?utf-8?B?NmxUZGppNGUyREM0ZENlbmlhdnAyVk53ZmZaeEVtZzM4ZEtuWVo4ejJER2NM?=
 =?utf-8?B?ZnN3YythcDdObXJRVnRqN2RoSXByTUoxRFFSbW1Hb3Q1aExqYkt4bUVxVVEr?=
 =?utf-8?B?T0hUaUo5N2loS085UnpFb1dsMWUyNStyN29IU1ZObzI0L0RidzVGZzhGNEY2?=
 =?utf-8?B?U0FoMURQbE1IMklXeEc5RVdvL3A3VlVwVFdySmlWRXNFY0ZNVTM1S0JRdEMz?=
 =?utf-8?B?Qm9KR2tVWnV6dVJmekJvOC9iYnFnTGQ4MnRBVTgwRHRvM2o2OVpwaEE0Ums0?=
 =?utf-8?B?VVhoQUdaWnZWdko2NHZuSFdRdG5qVjRjTFNUejhxUk1TWWd3T2JKbE0vUGRu?=
 =?utf-8?B?N1N0RDhLVU5SYUtzL0QzSS9uTzNaNmtUem01K1VoeWdxT3pFOGJKWDc3T3VM?=
 =?utf-8?B?S01TSHdmTEVMUGxyNjEzcTg2cHhBUnVDd3ZUa3FBUHhQaVVJemJOd1BVUHdP?=
 =?utf-8?B?R29rdXZyaWNEWjlzTHBObkFVVkxaN2JRcTVhV1pQMW9hSjA0MVBsdWhCVUlj?=
 =?utf-8?B?OEYxMWxWU0N0ajZRNmZrQmZzZDBJdG5LQVdGaXNIR3ppV2pmZlVESmExaUM0?=
 =?utf-8?B?RXdUN294S0tRZE9PSTlqSG8yMlJ2RVU5dm5IaHFNb0hTZ1lFOW1SWEtEeThs?=
 =?utf-8?B?NGZOVEdCLzlXb1lybDdTKzdQVjV5NURrS3FzbWZRR21iMkx6Nittc3dta1Bp?=
 =?utf-8?B?YUFhZmtVMzA2bWEzeGhTdmVibUxiZ0ZNMlZockJreGdhOWwydG5ZQVA5TEVI?=
 =?utf-8?B?RHRuS2hLbUFvcUh6M0tXWnRPQ0tVSFA3TXBVQ2ZWaWJDTDluVTFNV3VWQWR3?=
 =?utf-8?B?Qnp5RGFyWTQvL0tFQk5OUi9lTGs5c21HTC9scnpIYzJ6d1BiS2E5T1R1SGdK?=
 =?utf-8?B?a2EwVndtTHYreUV2b2x4SlEvd3NYb2RqN2E5R2VoYU9LZ2l4bUtEckNGRDRx?=
 =?utf-8?B?a2crSldTVU9zNlFkeGdRRFFPSkhsblhNbzB6bytmSE5ON1VYQUhEeFM1M25q?=
 =?utf-8?B?bU5pMGJJczlzakt4eC9EVWdBOWlhUGYyNWtJaS9KdUIwdmUxVEhFaGJRSk96?=
 =?utf-8?B?WEpRU0V4MkhFeWZVYXFmNHlGcjFmejdmVisvYUJYRkZLM0hvazkvd082SlFs?=
 =?utf-8?B?dDZGQThXeDlYSXU4WnFCME9VN1UvOEdyUmRSMC96ZnVKbE53WW82ckZxWksv?=
 =?utf-8?B?S1FlaTlLVHozdmE5MW5acjNaVW0yMTN2MW5UT0w0Tlp4eGE0bG9KTEhLU2FU?=
 =?utf-8?B?UDlKUHpsRWVDSmVuYVJFYklsNC9zb2EySnNCUmxtUDFubXp6Z0tXRnpyc0F6?=
 =?utf-8?B?OWtDanYxRkhGVTJaaFlnUXl0UU1MRGJrWnA5bks5MEh5WFVWaHh2MmNOc082?=
 =?utf-8?B?aTVnZjA5eDd4UzF2UFV0OGV5WnFXTnRoeUhoS09VVlF0Q1JWT0hLUTBlbHZI?=
 =?utf-8?B?SHhKY3hJUlozZ0x5RHFHcmZ6VmlkQkRDZUcxL3YxTEtVVXVzMkxEUWhmeEUy?=
 =?utf-8?B?QWg4TnpYaDljbkl1eTlJaFFMc3J2WkFPR0tYUnhtTDliSnlTTUs3RE1BNzA5?=
 =?utf-8?B?TEZCdXBUNTlNNFFNZlpMbjNRbWNpQWVBY1k0QUVPY3BQVkZsU0xiTWZURU1j?=
 =?utf-8?B?cU13ZUtLUTVqL3ZuUXZoM29uYkl0U2RGQkNzYTFqL2pyajAwVTRNYloydHdH?=
 =?utf-8?Q?1uqEIv2LYMmtFYJsmSyXg/YTq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zfr9BsaSknWVP3W8u5Lt1WcxZwMcjcR+d4j3zPZ/v9FmfVgWRK9L45ifsNTOhzjeGHnvD7hAH9tXlXdQDAVO7B3ZD0LiQHCzIxDwpBLvhPbXolwKLi/Q+pzonkYsx1X00RDBVDB0i1J7bjNo7V3Evvfum2HHYDN9HyC+iKn8ybnlvyB6UJeB8Sk1Ev1UgCfA2acr4Y6zTDPrT/N2+SRd/0mYx+Y7jYhzmcQUcsW2fmvhZRCQ92cgy0y4dmoRN2lJNxHcUId1tbhtAutI71KzVypmahebEpMbkT0ng/IS3vLBW7vbttImGuiflZjkU0WxteB/JPfrlHifPYC3EVwgIsH32p+tbFOL13FEzwdYxsbBjPydN/3s3Y1hDKqUhtBQvEzMAC/OR/od1SQfrbtu+ZD//9yFyvCkuYuCl280i053gl7VfkccFPrO4nZvmRvl3sxNcvzPJzapvU9fv8vrOkq2Mp3zaVcIFU5kfEYWjjfNTCcqwB+ORqiwkbZee7vKaIxIh/umcrl7vVLEBKV850oduIpY5F/p5HLart+Nr+jk9gmX1fyF2vZ1IgPGjJsZK+kbOf1gV2qkxq9GnKe+JvkdYhS9ftZM13oet3RE0co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed5605a-c7be-4a45-f2dd-08ddebdf8fba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5509.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 18:19:18.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MeQNpUgxadjEWQhEx1UAs4JWWKJJwxNw99wZdSC2mdvyupFhlyGOGutwoNTGjLxzUKIPSIOIlN9ZLxazg42Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040181
X-Proofpoint-GUID: 7KPegQE0UosPwehqyOAXgb1341T215Vt
X-Proofpoint-ORIG-GUID: 7KPegQE0UosPwehqyOAXgb1341T215Vt
X-Authority-Analysis: v=2.4 cv=frfcZE4f c=1 sm=1 tr=0 ts=68b9d829 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=MYie81EXOYmOcq9IZp4A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE3OSBTYWx0ZWRfX7YTKRaJdrN93
 hmq8AuTqGv8W+XERcHAf5c6m0DsG6phBciaCe6deWs/Ib0OaVmo4mvDab5PrgAYBJRR2KU9IHnY
 cmohLNs2CJ63R7pjpQ+wY3UnEpi4wD9/wxry/VMikIVMq3rEeaufl7/gsGH+WaiUuy7q5A7ps1K
 FJ8ZQ7A3IkJjW3QrsrYorns5tMtnp9BuCDkhWHBvZgxzY8xq7ehnTq38+on1q+NAsZ7g85mmdUb
 W/UBPSI3TAJCpW+I8laQ1uM+5MGWn9jDy+5R6RhGuz9tlnRaTValwnfhGf/OMjeeuiEd4Rnsuzr
 NKebFHurc6sROfrmaAE2pdOmysAvL8DRSuI7RU4gZx4n7ZM+FuLEaYNU+UAYoLq6itSPOl1CNIS
 gz3eTV4DNeTh1cuuEGrVnHP3MYs8HQ==

On 9/4/25 10:26 AM, Kees Cook wrote:
> On Wed, Sep 03, 2025 at 08:38:03PM +0000, Tom Hromatka wrote:
>> Add an operation, SECCOMP_CLONE_FILTER, that can copy the seccomp filters
>> from another process to the current process.
>>
>> I roughly reproduced the Docker seccomp filter [1] and timed how long it
>> takes to build it (via libseccomp) and attach it to a process.  After
>> 1000 runs, on average it took 3,740,000 TSC ticks (or ~1440 microseconds)
>> on an AMD EPYC 9J14 running at 2596 MHz.  The median build/load time was
>> 3,715,000 TSC ticks.
>>
>> On the same system, I preloaded the above Docker seccomp filter onto a
>> process.  (Note that I opened a pidfd to the reference process and left
>> the pidfd open for the entire run.)  I then cloned the filter using the
>> feature in this patch to 1000 new processes.  On average, it took 9,300
>> TSC ticks (or ~3.6 microseconds) to copy the filter to the new processes.
>> The median clone time was 9,048 TSC ticks.
>>
>> This is approximately a 400x performance improvement for those container
>> managers that are using the exact same seccomp filter across all of their
>> containers.
> 

Thanks for looking it over.  I'll make the technical changes in a v2 in
the next week or two.

> This is a nice speedup, but with devil's advocate hat on, are launchers
> spawning at rates high enough that this makes a difference?

For users that launch VMs that last hours or more, you are correct, this
change doesn't matter to them.

But there are a small subset of users that launch containers at a very
high rate and startup times are critical.

FWIW, easyseccomp [1] was created a few years ago in part because
generating filters with libseccomp can be challenging and somewhat
slow.

Thanks!

Tom

[1] https://github.com/giuseppe/easyseccomp

