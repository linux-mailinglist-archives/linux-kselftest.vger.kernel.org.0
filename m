Return-Path: <linux-kselftest+bounces-38541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE11B1E2C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 09:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181B6188CE48
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2647226165;
	Fri,  8 Aug 2025 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YoWPAYhL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tMaKHHOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351317AE11;
	Fri,  8 Aug 2025 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754636490; cv=fail; b=X7BiM5mC8AYdPkg4PFPYUNxhfovEY/ZBGOtooNkOHg4H+m49MCn+OnNa6+ADRpNqzY6z8aDgH/AyElkgUfvHhvbSZ2RiNIhZcdoChQwhSFMREN/GLwtCE+nHEVuMCxU4dAGqzgZj02sYkmoxQ7hn8anThkL2rEepbikkFW2hZW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754636490; c=relaxed/simple;
	bh=6XEfeseWwMjzREhoAfpFb49w4Kop6gOQ2ahmD0/0ioU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AtIznP9W4U2FkU8ZiFwvoKqPJNQgaQTr2JMkEfIRwNwccp1IOSnT5wQRTMSQBi0VhZ7c2ulhjxucmD0PQEaWhY5wsNhKK0LCMB02w2GlSGCon6ItpMM+V8YYyPW+U2VAhCSTRT1Pj3WizKl/DtLA/Wx807s+QGZNbE7sg0pXXeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YoWPAYhL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tMaKHHOZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786YL33032090;
	Fri, 8 Aug 2025 07:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FZm8RV2z/uG0ce0nY2oaha5WoAhCb77PclmvY2hA6e4=; b=
	YoWPAYhLDvPP1szLns1HIb6rlIaNUyHHDPb8ArflDSnngPGMKMfjr49JAvWXe5Sw
	6F4nD3oefK5kuCS6JCmbgzu5+QvsY7uTed/18C0RSglSosCIkJvNgJn0lo2Zi/sF
	k2TCN93kmesHXdu6yo4uQXKugt3du6HyOXUUBLm0x7kIWiEFX6Bc6ZGweWeuH3UD
	qAnUKn5ANSaii8o/INvrUwfAqblEV0b5uyiyFKMErVXyN8+Db2HM2X2nbDkwp/6f
	GFrnlykfi/XzXH2wAQ+M0jEWa51DmYxxafo8x02foS7/eCSljyuPqT8BftLKPonj
	14yoDrdkcyNKC2HSE+5+YQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjwjk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 07:00:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5785wZ99005726;
	Fri, 8 Aug 2025 07:00:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpx0e8ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 07:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUGxRPah4FVJb4hvKrmWcdMe795YW8Bp8+Yaak3OKZ8aWzwBsj+ltu1D4JPPwgOPU2+6LWumaf676tNX5SIde1QRbPIO9Mrt+RfTNo++fiPzYSIB7a5Y1gEMYZK41ah9wII2+3fBWZn0qFs4OVf7CFfitCXz+sTC39CCsVgb3rQSw7PpqXIKBVisuBt2jxYcGRLJ3IGOKkwU+ZN1yBZvt5UvHZPLadApPcM6Fz8oW3FrF7ft+nj2oyBrbQCmh11lF+qb+D+LgAVhmdRCPUdYhWE5vp/NYc5MK2TnsZSO0Oggb8IKzB7dCU9v6z9veODqTqwHOHR4YvoAuX8Koa7Fdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZm8RV2z/uG0ce0nY2oaha5WoAhCb77PclmvY2hA6e4=;
 b=YJfPWpqSTNut7F2dY/4T5PSwkf+XC+YbMDeHDdE4PPbpg+JqNW4XqUfM7CVQAqnlliajqHw+eRzxXBJEgQSGge4KIMNGcimZAUkJPTo0+D2u4CUeJn0L4aUeVN6Qp9/hO6DojkgfWTtSoQgKnmqltzadbUbmsUIt0+CS5Bao1OZojVOtVhuxYnNTH0vTJbAcuqqpaBtsJNVbsClsX/SVc0MIhsQpPKVHhvRXjRS6lD72rNSlWnCL126RWXO9Kw8cs32/xHc4LIkR1kUj8AdB1nYHsNpz5AkZ1pGtakLvDo5AgKNyhAgcDHV3Dn+AV5lI6jCrCI+kb4dH1XzQ9Nyi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZm8RV2z/uG0ce0nY2oaha5WoAhCb77PclmvY2hA6e4=;
 b=tMaKHHOZWwkA3sHWsVzpQAlte1lEDa73x+Z/dGluOpFaqye9b6QIz+C5XIizSTCoZ7Ipif294C6TNR0yaX62sY383JXDIZXnoR+UryyixAyAyECPZAh2dGsGNnCmgwS/fxI/z4q/RJNrRx7G4QMwBLn+zAeygJrEvy0a4Htja5Q=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 07:00:42 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 07:00:41 +0000
Message-ID: <84125c5e-ed99-4158-9a59-e1a97435c626@oracle.com>
Date: Fri, 8 Aug 2025 12:30:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: BPF selftest: mptcp subtest failing
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
References: <b1f933f6-545d-4f2e-a006-4e5568656c38@oracle.com>
 <da46ad00-910f-4eb1-9b74-14bd76fc8910@kernel.org>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <da46ad00-910f-4eb1-9b74-14bd76fc8910@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::13) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|DS0PR10MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 3485d772-38a2-4eef-2c84-08ddd64949a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzBaSk9OZHdXYXlNZUVDZlI3YWV6NzdrMGRRSkZaTXVNOXN5RWZaejlrTVRv?=
 =?utf-8?B?Mnl2VHNVZWwrK2VUbjBtZ1lGQU9wVlBMdkoyUTFVNVMyY0hxd1NHb3hsWkVo?=
 =?utf-8?B?cndqa1hyN0RNbHlDR1BNWnIyZDMzTThKanBzdGtFcUtEWFZUVnM3eFpvbm5n?=
 =?utf-8?B?K2NhSDNZL20yeWpuUHp2QlJTMnhZL0dUODEyWUNidzg2OERybmdNbmFVOGUy?=
 =?utf-8?B?VVZkVEwyUnpDZWxmZzgvVEkrbkIwUXB5Tnk4OTlXUHhhTlZuYVd6VXFuVkpU?=
 =?utf-8?B?djhuOEx1S1ZkcjhvQXpJcnZaa0kvdExuUXNlTkJJOGIxWEdFQjRyOFRXL21N?=
 =?utf-8?B?bW83WXhQenNOQ0pKU1hhZ05CMW5MVitTcHFtTWRlNHczRDR3anEzQUpMT3Vw?=
 =?utf-8?B?N3FKcmpDZzRENlFnQ1NzMGlzWmdleHpIUjJRZ3ZLWUs5VUI1VHd0ckUrZEtt?=
 =?utf-8?B?UzBCdjM3d2V5VVpiVVdCMVdiNXlCaFQraTQyYkxGbnVnUk00Y3JBd05xSXFT?=
 =?utf-8?B?RXFtaFJpdE15SHpscmZCNytaNzUzMktleTc5U1huc1FrcVFKKzB2QzhTRFpp?=
 =?utf-8?B?d3lQSWIvZjJzS1RkTzRoaEdIdHlYTnRUQllOSnBySnNZSHR4eWdMdC9uN2Vx?=
 =?utf-8?B?Um1VMUlXS2Y2eFFNUFY2cndjT2FBV1ZiNVRnUEpWaDFFQUUxRnR1Y3gxUEti?=
 =?utf-8?B?RzJLS0IvWEJwV0dUdWo2QnBpSEd2TUpyYWVxTkhBNTBtL01zSCtvUWVjL1Vm?=
 =?utf-8?B?RWpCbVhhbjRhaHY1OVRJaW54c3NKMXJ1QkpEZjVNdGdwdU9PY01kanFBNzRF?=
 =?utf-8?B?WW5nTmVDTCtETmh0c3pMTlVZMHVXRVFJSjMxWjNiYVZ5OElSbzBwN0VTNTVP?=
 =?utf-8?B?SmRMM2liRHFFTjk1VG1WcFU3TFh3bmpYY2NWV0Qza2FhQ2NEeThnQXc0eStl?=
 =?utf-8?B?VHhUNCtFTlZidG5ZWXMwT2xYOE5qRmdsSDM0bitsOXRCRFlsNDk0UGl6eEJ5?=
 =?utf-8?B?aC9qRjNmMUNRRzY0Vk5MUnVhK3BUUDNWQk9OQm1Kd0Rac0FVWEtXZGtoWWs2?=
 =?utf-8?B?M1BEcDhzZ0pxTUlhL3k4SWVFdm9CbGNKTXRQT2VJRVRScnZ2UDI1QWR0ZVJv?=
 =?utf-8?B?TjNOTkpsa0ZvU0RrajJ2WjlPTjU5WE1KSStrU3c1ZTZ0MldjYXVXaHgyUEJZ?=
 =?utf-8?B?QWxCY0NackpZMXpvaDB5UHZhSkdjZFFmRTdsZmRpQk8ybTk1RW01aGthV2h5?=
 =?utf-8?B?MmdERUNKRTlMY2ZTTHZtZ0lZb2JtSWNaMEppMXpoUURwZkRlU0g4NWR1eXdE?=
 =?utf-8?B?bmtKWHVTTzJENUZIaldWLzhXM0d6UnVrdElEb082VDRDc2dOaUV0UjBkODV6?=
 =?utf-8?B?a0tzMWtaQlY2VGpzM3VNVHprcjBJZmxDZFE3dzRqS0xicWRWalkrRUZHRE83?=
 =?utf-8?B?SkRCbzVldU5FVEp5NnN1cGVHWTdWRWJBbkRrQldEQ2MvVmR3MDMreEtNNWJ1?=
 =?utf-8?B?SkM4a2dKeDljdElsK1ovTklmVmVVUlYzS2lIRGp2bGJPR3dDaG1FTVVhL3d2?=
 =?utf-8?B?U1VQZC9FL3lCQTBvQVJKQUdlZHNjUVJHVFA5S2RKRDNTQUVWZTE5S3lwamVr?=
 =?utf-8?B?RVFsRHFFcUsrM2NmVlV1NEtwTzVoMHkvVTNRY3JQVk9vZEZncHFDR2owTTJo?=
 =?utf-8?B?TEEvazVkTTd1bHN4dFA2L2VjZmZTL2xLUS9ZclBQbVhHRXMxcGFnNHBRSlMx?=
 =?utf-8?B?Zm4yTytyczVtQ0ROWU1jVU5EQ0NNZkRadTJZeDdjV3RvSllxS1Z4dUdwUkdP?=
 =?utf-8?B?YmFRRTZIdjN1QkVYNGVUUHB5U2tmK0M4RXNWR3lEcXZOdWxJM1A5VzVmTkFQ?=
 =?utf-8?B?NkxkYjdwejFyVHVGTGVDTVBRbm53ZWpwU2cxV25oWmtvVzROY1ZnWmJGbFdZ?=
 =?utf-8?Q?wVV3BeSSBV4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alRDeS82Mkt3eVdWbksrOXVuLzJSZW1pM2hNRG9EMEdqdmlQNnkxSEdvNzZJ?=
 =?utf-8?B?T1BManlBZlRuMXluVElucEQ4RjFGSFdRVFRiRnZpUmx5amJHRjFyZlRLM3dW?=
 =?utf-8?B?b0pKK1lDdUpzZHVDODRNWHIwZWJiWDdaVnFzN2prZ254VVYrVDJMRzlMbUdi?=
 =?utf-8?B?MWN1Ri82MUFTQlJTVTJGemNhVi9oRVJPcGd4RWpQb3FGcTRFV3lFVHhQR2Q0?=
 =?utf-8?B?S2g4Q1lud2N6aTcyMGFON0NQK0xqZ3QzaXZ0YWc3Z1NqN3lQWG1ZYVBHS0lQ?=
 =?utf-8?B?RmtrNU1Hc1hvOUszK2pPUW5mOC9kclU1QkgyY3NIamlTV3lXMWxjRkRnOWwv?=
 =?utf-8?B?ai9CWFFtY2NieU9GNFpYcDJ4U2M4aVZkWlVKT3BqZUREQXJVV1VWZFVuOVB3?=
 =?utf-8?B?ZlZWTjFKZnBKSkdDYmNqekpYdXdROE0wK1lRalpwaUhRKzFXSWJnc2hmY1BZ?=
 =?utf-8?B?U1dGWWMrMS9GcFY0blNKMmp2dkZKNy8zYjhrRjNZUEJHcW5BRHg4aS9aOXdG?=
 =?utf-8?B?b3BUcnRydUFHRTRZV0xnNWY0cThzd1BRSW1lVXBtLzNuU1NTTUdVcFJ3ckU0?=
 =?utf-8?B?UFRHRHZtS0FMaThwT095RWVPNnJ3ODd5STJGd2I1ZVV3ckdRUkNkUzRIZDF6?=
 =?utf-8?B?U3JnNXlGZ0xKdEx3ZzlUb1hvZDl3bHFLWW1NMVUzZUdaN1Y0SGFnZkluanBI?=
 =?utf-8?B?OVJZODZEUmY4ZlY3M3d4UVVBd1Y3eFBVUDZYSUIrWkZvejJ2UG5KM1ZjdXVu?=
 =?utf-8?B?eExmY245SnhTNHJ2VXdwRllyRUt0d2tFcEtXS1l1OTJDcVNyU1p1Mk1qL1Zi?=
 =?utf-8?B?RGwzNmx6dlRmb3QrZFJvSDFrWm5nT0VOdHp1QTdrYnEyQmdqL0tnalNnY0NT?=
 =?utf-8?B?NlhWY2RSQTJWY2JnVFJDaWkyNXgwN0pacEl1T1habWhnMXJtU3ZMSkVkcUJZ?=
 =?utf-8?B?SVZMT0s5dmRsQ2RBRHRGQWJLNEJST2pXTHZrUmlyNVZRM0tTLytTSkQ4bFdw?=
 =?utf-8?B?anh3VE4zR2NMandrTXhwTHBaRTVZTklGaGpTdFV2V0tPNU9kdlFwRDhIM3pT?=
 =?utf-8?B?dFJCeWVBQ1lhMGxVb0phS1VZU2M5K1ZERlQ1WmVSREVVOGl6cUx1SVpreE1G?=
 =?utf-8?B?VlNGZ013K0RLV2czbnhya0c2Z0JBVFY2WTNtMHBjRzhjMFErZ3JwT3pLclJN?=
 =?utf-8?B?MlhCZ0RXOXhNeUxEQldCVXNjcFozSWw2eDZ2MW8rUWxPMXFmdmRoWHlSeWdt?=
 =?utf-8?B?REI0RXRTb3lEM2MxY0NDc0lVY1RoWVB4endzbzhxODVqQ1o0ekNla0pHMlFK?=
 =?utf-8?B?d1ZKbVplejdMeWE1b2tVcWFjTVBmc25sUlhmMlc3Qll1dlcxVkFodWcvWVFu?=
 =?utf-8?B?bUhaZWZvTGVvZWc4c1JmYlRxN29XT3FtMTR5a0JQRExRN0tGb3FqckF2OXZv?=
 =?utf-8?B?Ynp5a0c0WjVDRjM1UEp0WU9hMkJXK1ZoVU83Y2REeWtkRW92cklIeG1Gc2lp?=
 =?utf-8?B?bnl2MnpQZUV0WWNackdJVEQ1dmVYbnBWbmVacGZubmV1aXlaWU5yR2hZanhP?=
 =?utf-8?B?WVRrY3I5TUdiRVhDVm9Kb1c2Qmdiamp2L0lzMjlYckk0M2VnNnh6SXQ4clVi?=
 =?utf-8?B?UXFGbHdxazNUTzRRUm1ERUZTa2RpWnhndkJnZjlvQ2tudWR3UlVQcVpmZ1Ja?=
 =?utf-8?B?dzdKcE94UDJxN09seVRoVWlZdWRkMzBFTUM2b3lHZjdMTmV6MGpaemE5Uk9o?=
 =?utf-8?B?YXJlSzlpNkQ2MDNBYzcvSFRXUXNkQ0tjYjAxTnlqT21mUCtza0Vqc09iWUNp?=
 =?utf-8?B?SElQcVR0WVZGa0hkNTNvR3RteWpJbHdiS3hodHNTTFdNaWxlMlduMFlKSnQ0?=
 =?utf-8?B?ODJheVJmcXluRmFNNzdiQTZPZjB6UjFWQXlJQjNIM2lmbjNmL1ZoeHZJZnNQ?=
 =?utf-8?B?a2JWeWFqVUZaRVZUSXBRSmJjLzhmbnZ2V3BTRHRMM1JwNEFIV2hIVHFEN1k0?=
 =?utf-8?B?MGVUUk9PY0FLQ3IxQWora0NJM3JRU3NraDBUUVZvUU1sQmxrNkU1RWY0UDNn?=
 =?utf-8?B?a1JSOUhrZEx0dmpGaVZQM2ZmQm5XY0xjK2lSZmI1VVhpY0VEaG8xZGFFR0JB?=
 =?utf-8?B?WEYvV3J5M1FRVEQxc2laeGNhRXp5YXpGTkVBb0YreVZMZWJhUFNSSWhOQ1FR?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4MPBzQUmlcDZ9F5NTUGguqlFO2uzzualpPqPil4Nu9U4gp4WPlJhMV0idJ8hdTPTSBCzYFH5veiRFn4FG1jk0hXGY20wLemLiRwGxtulcNL61lnVTZWl0vaeX0kpog4Hu8nNK34ncdZgMNqhgmkT8yoOE+I9n2+Y9zqi1yqlZifSLRfadH8r2VKrflabcZuRYlXh3XGsuA8LheBT58/4WST8FwuuR/Mh2INEfhztYTErGDlwLat6oxK/uMauvVm91xAq1kWxtZe6Oph8WZ4gnY78mqX+ODQUwYFL4DH0Ty04zrDxvpA286RYk8Q+56QCPWM0b2lgDimnVr+AbWnfXy0uMLqwYExMRHltCwMctjR52MKDRZD/MKlQn8MhMrJGnzc18rHrTcYpyy7FG2MguHtsBXWgw0auGtJFJKlWXmNRaIKYS1vHxo0nxClwHXyn6p3VdcFPhlgXlQeTM01u3wPlLUN4y8XLem5/02AfaiKt1h3fttBlSjxhXsIXKP2aQoVKuMbFaKyWOC1Q4WDchRPIKb0kVPh5+euwVSPtCU8HZGIa2WyuWbXAlUqxRpcvu8OraY7KeJkwyKwsM37b1OWkpyKBfCKs7j8+TK6ACTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3485d772-38a2-4eef-2c84-08ddd64949a9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:00:41.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gG1NkoS8QmgxW6y/vzuasEoZdzBVY/HvuaqzFiLNHq9l2JWD5la1lYDGOBYBNrkwE5aHuQJDZVEfkKDE6p0nCwQWdYUfiUlMxXIgn5KEVLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080056
X-Proofpoint-ORIG-GUID: dbSMd-74vdTMiJE-k7Rht24vxNTgZ6mb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NiBTYWx0ZWRfXyJTBQxelYffU
 7mBrFIXlopWdNpxYnbSw+Hd8EGOokPnaqUW0UqZvZrJurSibtNnlMG6mxi6d6yu/ywjT3QSzDJw
 qzqqj9jgq0vH7LEgnvW7DduJ6DXuMOdgfqq15D4Cm/NC6cFDHN+1Dm9SN8sfw8B9CTf3yH4/LqU
 Crf243SmHs4FQj46JR/VvsEpwcZmL6xgON8TPY56x52oSCiMiCmxcCUEds+Or4vzBn4WG85ge9e
 HAQ9XpLBRGEdA+zvbXx3N+GQMxEtAZJTLa5G8Kto7Yyh9561XGvqUCjGACcGPKsdhti87WJHFvF
 n4KWfev9ouPqUhWiIHXz+3zzU1JJc7C5lt9t/SrXKs9qe7vfYuWAH2EPAabXb8U3snF7fhtH1dx
 gJUZwbOmspg+VhRypT5Qk1UzfbyaRNXbcoiAkgehzhntmXRP8hKclHHtQdpsfCmEW/dUgoOz
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=6895a09d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=TzAkpwrEl9VEWiPdL90A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: dbSMd-74vdTMiJE-k7Rht24vxNTgZ6mb

Hi Matthieu,

On 07/08/25 7:51 PM, Matthieu Baerts wrote:
> Hi Harshvardhan,
>
> On 07/08/2025 05:50, Harshvardhan Jha wrote:
>> Hi there,
>> I have explicitly disabled mptpcp by default on my custom kernel and
>> this seems to be causing the test case to fail. Even after enabling
>> mtpcp via sysctl command or adding an entry to /etc/sysctl.conf this
>> fails. I don't think this test should be failing and should account for
>> cases where mptcp has not been enabled by default?
> It looks like the test is failing because it expects MPTCP to be enabled
> by default. Or, said differently, it doesn't expect the kernel to be
> modified without adapting the corresponding tests :)
>
>> This is the custom patch I had applied on the LTS v6.12.36 kernel and
>> tested it:
>>
>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>> index dd595d9b5e50c..bdcc4136e92ef 100644
>> --- a/net/mptcp/ctrl.c
>> +++ b/net/mptcp/ctrl.c
>> @@ -89,7 +89,7 @@ const char *mptcp_get_scheduler(const struct net *net)
>>  
>>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>>  {
>> -	pernet->mptcp_enabled = 1;
>> +	pernet->mptcp_enabled = 0;
>>  	pernet->add_addr_timeout = TCP_RTO_MAX;
>>  	pernet->blackhole_timeout = 3600;
>>  	atomic_set(&pernet->active_disable_times, 0);
> First, I have the same question as the one I asked to RedHat devs: do
> you still need to keep MPTCP disabled by default? If I remember well, on
> RHEL side, they started to do that when they backported MPTCP on a
> previous stable version, as an experimental feature. They left it like
> that later mostly for internal process reasons I think. But honestly,
> today, it no longer makes sense to do that and annoys users: all other
> Linux distributions enable MPTCP by default without patching the kernel
> like you did.

We had observed issues with mptcpd daemon failing before when we had
this enabled by default.
The mtpcpd userspace fix is yet to be integrated. However, shouldn't the
testcase be robust enough to handle that scenario regardless?

>
> If you don't want to revert this patch, I guess you can modify the BPF
> selftests in 'prog_tests/mptcp.c' to set 'sysctl net.mptcp.enabled=1' in
> each netns created by the test. But again, not changing the default
> kernel behaviour sounds like a better solution.

Even after changing /etc/sysctl.conf which is supposed to keep mptcp
enabled across reboots this issue occurs.
I agree with what you have stated, mptcp should be enabled by default
and the userspace fix should be incorporated ideally, however I still
believe that the test case shouldn't be giving a false negative as it is
in this case.

The false negatives seem to be occurring since this commit I believe:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=df8d3ba55b4fa1d6aed8449971ee50757cb0732f
This does the opposite of you have mentioned in certain functions. I
suppose adding all these lines back might do the trick:

ip netns exec $netns sysctl -q net.mptcp.enabled=1

>
> Cheers,
> Matt

Thanks & Regards,
Harshvardhan


