Return-Path: <linux-kselftest+bounces-40657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B79B40F7A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F0C3B4381
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4D535A2B2;
	Tue,  2 Sep 2025 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PuVLn4tB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZCIFMBW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909D021ADA3;
	Tue,  2 Sep 2025 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848909; cv=fail; b=TYsUSwG9+ef78REii0yJY/Av/aHWLekmGxt31vOQmWAe9qPH3qcs4mYAOBZrNzsQqNsGIHwNPXF66vm4CCSDePd1/VmS/anX5JJ30E7fN3kNLhwYMZxOygqqvkGPiCcZjf1YShFrqwou4frgRwsGXh6cALnE0gTnsygGiP9ONw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848909; c=relaxed/simple;
	bh=+ihNNpWTFgmwUrAY7n+/o/x5DTJ3GSFCxo0P87uoujU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hy/EznmYDrQj9NcduYQGt0Itg41+guU7/flE7AUIJPNO9Wj2MEYK8f3kecm4rQwgKh1JME5Ww1nR8lPpAf4XuPC3rbG5q6/QEca9cM5/B+iT3tJ7Kxs7Q9fFZuO8d5cH6pXmlJNVbSJ72my/u9YYNVBnYf1v4E21oVa0Hq45Ob0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PuVLn4tB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZCIFMBW1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ki04p001934;
	Tue, 2 Sep 2025 21:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=w8psx//NEJ3J40Cvk6nBFbm0P+DfDk1CPN/nqZsMF2M=; b=
	PuVLn4tBC5+NvcrCruvyQQQY3Cj/OGitjJ3S/7A7lct3HD/pY/uFrSNBXVj/1dmP
	SSmpSHd7CAFQIlyf+CuzQ+lPSruuWxChNlhRPhiz2JKDXJP7TA2YXzgzTsRYWLUd
	uNjU8kp1N/pWgyEsPoxaiARdo8mzm9jFiYsg1AC4ynLc3ZTq1CCJiv2TVNIg7rKb
	IgmatrzbDqgnrbxplL8UXaPGrCPk/V/eYmaJjguqrFmvAzHwTNc/apDaHPueZqrw
	VBwwA6gFgWLjm+KEiFvIrYcEj6BDaEYctPc0DI/Ei/yGgJltbAYDDUPGJ0X4HO9+
	i8cKCbnQRsd+Tqtky2ACZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbd1h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:34:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582KPSpg015825;
	Tue, 2 Sep 2025 21:34:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01nvwbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2v+SvL2kqSrp2IYGSnd3oENvqNn7/n8f02UEVOMUkQuyXL+MnTelQXcaXhv/FmJ9omZRF1S4A+n3hA9uio6AKe6XX6EoMeZeOyp5hszBu9+0SspWdnUVq1M7G2MXKIqwZQwMUHO16QxXFJc3lzk09zePPJFLHlbEZCxQsemFVvJvqqS9nC9R86rF6KBW8n7bY/Rjg9pwGM2/Lnd4OW6hyfHWr5PrM+Xive+uLP5nQOWuzILCkmnIZ9QJHpQ2JYW4pEV8eV9+JqtruWlhOpRbVCTKKE2KWWAawritYV+0jbf+Ph1CBzeUPD1CBk+3rJWmPYKjMOCB0RjCaCZEEqWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8psx//NEJ3J40Cvk6nBFbm0P+DfDk1CPN/nqZsMF2M=;
 b=WLNVZAVHolj+GOz0c/qe7ldB8mV1/XmXTdIIndp3Si54K0f02u6kJoE17meQm/geYEf4J8yjbHnhscodqU2y7Sb3uNN0Lis++tOhhYFpJYLSA8bsw/y0KS23LNOzXIF6iZpgP3+rj3EF36XV/uDY9mBi3StODkLWlQkYhgJX+seeLTZRdvRoo/Gzm0YG4m+iLmftNkDCpyJUTnBWbR9nNutJHDHYRdakBeBy6aWsjlXvzerufrLNN9A/r0yFzLIEMOKnCJ0t/IFT/UQXGf6QGunyfV12zjRpNBC3LyPBrthBx01Jmvmtc0qhYmmYTsjQwWA9CK8scqtq/MgGPJuJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8psx//NEJ3J40Cvk6nBFbm0P+DfDk1CPN/nqZsMF2M=;
 b=ZCIFMBW1QL6Wfmtn+Xa/C4zBbfZ0I4wv7zPrcY6fvkKo1ZCsMle6m5dY/gWFkglKCYkgGobF3LrpYOskRoAGIqt5/pxyEAcD1LIvm7l+ADNmAw7vXukZVx9PKbAS6nan3Vxd5onBpe9fyBBV00zuoi3sOhgelMbOswjNvrh/+aI=
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22)
 by PH0PR10MB5626.namprd10.prod.outlook.com (2603:10b6:510:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 21:34:42 +0000
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb]) by SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 21:34:42 +0000
Message-ID: <7d61c6b9-fef7-4b70-9172-effdd7e69457@oracle.com>
Date: Tue, 2 Sep 2025 14:34:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 4/8] mshare: selftests: Add test case
 shared memory
To: Yongting Lin <linyongting@bytedance.com>
Cc: khalid@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
References: <20250825145719.29455-1-linyongting@bytedance.com>
 <20250825145719.29455-5-linyongting@bytedance.com>
 <18530429-cac2-42a4-891e-24033dc54461@oracle.com>
 <CAFuXZ_UY6RrOVmTayW-DdxQX9TE978LPx7ad=Pzr01j1cZ4o2Q@mail.gmail.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <CAFuXZ_UY6RrOVmTayW-DdxQX9TE978LPx7ad=Pzr01j1cZ4o2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::9) To SJ2PR10MB7653.namprd10.prod.outlook.com
 (2603:10b6:a03:542::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7653:EE_|PH0PR10MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e130a3b-3bd7-429a-a967-08ddea688724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGRVQWRDSGdtaEdCZlJXWlJaN1VNNEpEMHZtUkxkMG5rWnMwVCtqcG1ieVg1?=
 =?utf-8?B?VTBrNnhFVEVScW1SSDVXZXdKQ0ozL25hditFVG5qMnp1UUxralVVaHArbEVJ?=
 =?utf-8?B?SVBsZzBDMGpaTEZsWlBNTE9WWTV5YXVZVnNuMGdWTXZvcVpDMytudnRKbG1G?=
 =?utf-8?B?ays5cHBoODlMd3FwTUNzZjRuMzAwTkZJS2NwUTZFeDhvQlhIM2dGeEJ2SWVR?=
 =?utf-8?B?N0J5NDZwS1c4elp0Yk1hUC81Zm5MSXpWeW8yYVpyTlBEUUU3OUZ6Wk9nQm5M?=
 =?utf-8?B?SStkWVppRjFzZXcyYnl1VjFOSkJBSXVKdEJUUDJtRGhzMXJTdlZqTUNLY1FQ?=
 =?utf-8?B?a3N1Y0xONDhNMFNYMFdxNThnREllMEpLNVE4cURmOUdLbGdCVWVza0dEU0h2?=
 =?utf-8?B?VEdVcGo4K2NvUTZFeFlkYkxReTA5c2ppSWxlY1N5aURqeTBLYkhmUndZL0dn?=
 =?utf-8?B?Qm5mZ0J2U1FVdUtRNXNQSnJncHRLSXUwUGV0NDBoVU10K0UxZjZucVR1dFk2?=
 =?utf-8?B?K2FtYUNlVkhzYW5VMHVLTFEzQVg4MHRLUFArSU1uRHZQZ2pENnBCOXpUS2dR?=
 =?utf-8?B?cEFZQkZvTFNZQkc3WlJZNHZvTXNack1CejVLNlFiMlAvdTlxelVJMXZwMkVH?=
 =?utf-8?B?eW5ydFhoSUdRSVRlaXJDYndLNXdvOVRDMVUySkRkc2dmclkwMXBmOXhSY0hv?=
 =?utf-8?B?VHgrUzQrMGcrWjBaazlsY05meDhPOC9FcWoreVFhdTNBWUdmWjVVa0RqMVh3?=
 =?utf-8?B?aVZGWDRTZGRQNC9aVVhHUHNxRXZNeWhuU2J0b1FPTmd5REVuM2JhZE5PUHZn?=
 =?utf-8?B?bnhmaHo4R1dRSnRBaXVzY1FIY0RNcGJvWThub3oxSi9uMGdzMWpGbHJuMWwv?=
 =?utf-8?B?dysrWUZVNzBhSi9oT1FOOC9hU3pqN0VUQ05sT2d5eEhsNHA1TFVnZ0dzYU1O?=
 =?utf-8?B?SVFERVltdUVRVytqMW9mTXcwdzJ1SHluNDFOWHI1MTlwSUpUdTAvYU5HSnlj?=
 =?utf-8?B?Y3JSM1RkOWJsR3NpbzZNSnlGVDVkMjNtbTlBdzZSREdIcUJiVXB6K01vZlZS?=
 =?utf-8?B?ZU02WTVUT2ZUZEpDeWJzeXRLQWh2RzgvQVBLOXRaUUhyYno1TmROVGVEbVB0?=
 =?utf-8?B?SFNxcVZ3bi84c21hd0hzZWo0SCtCK001ZTZuTFFnZFZWVzNsOXRzUmFPUDVV?=
 =?utf-8?B?N3ZCRkwrQjN0cGpPck1Xd0RZTGlpSzhEUUNaSEI3MHYwdlUveHAvcmtVZzB2?=
 =?utf-8?B?SDlZbXlWbTMvV2IvcWtHSTgyTkJUM3Yxb0dwcnlzNEc1bEtORjJZVkRlZVV4?=
 =?utf-8?B?aDQxQURsVEIzL2h0SVlpUTgzdXAwdG4xMW5IeGdjVmRrMHVYTlZ4MWlnWTJM?=
 =?utf-8?B?K2RrNmpkMlZxTTE3L1lwclNIMEQvUTNzNzg1c3hKZ0xnZkVUVDAvdlh5RlNK?=
 =?utf-8?B?SjYzOFBNSk1rbkVzVFFmUjVtT2Fldmo0VnBaVXZSRXFVUTROMzg0ZGUzNmRy?=
 =?utf-8?B?VTJGTEV2cWhyMEhRWEVSZkhWUU5TakRob3NZazUxTm1MMjRjWVRGQzdrbjNJ?=
 =?utf-8?B?bUJtcFpNTDMwejRwRGFGdHFJSCs1NnFNWklwMzhNQ1E0SjQvRzhHbDF4YldK?=
 =?utf-8?B?V0JlaStTamZscVgrMW5QOTBPVHlQclZiVkhIdWsxb1p2WlJ6MUN0ekdpTFBI?=
 =?utf-8?B?d25NcTRwZUZ2a21TMkluSUsxZS9FdkZuem1LdGcrVG1PRkQrSit1emc4Vnox?=
 =?utf-8?B?M3BJZUlodU1NZ0pvV0FxQUtDaE0vdDVtZHo3UlNpME1TdmczZU1hcVJIRlBh?=
 =?utf-8?B?TysxZWMxQ3BKa3dRd20xWlNJeXI1V1lxMnB2RmVSVnk0b0F3UXBJd3B1OUlx?=
 =?utf-8?B?RUh2R21jTFAvbHJPOGJDYzZpRWtCZTBiVCtsV00xRUkxbTN1Ym1DQ0l4ZHQ3?=
 =?utf-8?Q?6CGyoNxDvKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7653.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEVCWjBmWGxvNk9YTkU3MDlsRkxKZjIvakJPcFhYdlRUdGpUVVI3UXlBSXRl?=
 =?utf-8?B?Z1Y1cVlSdWVtVXV3NzBKcThFMmhqODA0ZWRuaUQvdXRGZHF6ckxPanlueDJY?=
 =?utf-8?B?MDJVVVNKelJuN2FHYzN2VXFINy8xbHdCMVdKNW9WQnEwWG91QWY0MVcrZkNH?=
 =?utf-8?B?SnVNdWMwVExvRlB4UjY1dXFtRUNGb3NPZEI2TUl3RzdXWmJBWU1BVEEzV3Fy?=
 =?utf-8?B?Q2x6dWpXQ0VmK3pnelo1NHhDenJVKy9NWXY5Y1oxSHNLenE5OXNka1lISGlC?=
 =?utf-8?B?cFJiUFVka2t6UFJCbnJWaWVLTVJ3WTh4K0cxLzdwK1VtL3NPR2VVQ1dCdVZm?=
 =?utf-8?B?TFNsWnk0WlVQckpIeUhXbGhic1N3RmlnZFFwcGZGTVFvYWRvZ0ZlbTN0K08z?=
 =?utf-8?B?Uzc4aWcyaGtSZXpkRUZXMnorcVg5V3NFaHFtREVtcGxhcXFhM3FXZUNBVXVn?=
 =?utf-8?B?VG93YWZoTjU1VzI0cFdIVkVQeC83TWhuQTNEOTAyOTBEOUU5Z0V2VjhpSHZN?=
 =?utf-8?B?cWRRVTM5VWk5cXVKWFB1d1lTbjIvbzdURjZOaVBoQzB4WDBCbWx2V2NSSk5M?=
 =?utf-8?B?TFB6anZacHdQRldWSlIxamtUaU5zUG81d2lDMHJoaS8wd1dSdVUvUVFhbTJw?=
 =?utf-8?B?MjVGcVpZYkR3anU4c00zbnJiSG42QldaWGc3RGdUZDR2N1plMlJHdG1VOTZI?=
 =?utf-8?B?Q3BGdy9KK1R6dmlvUk9SQ05BRkFWTk5LQzl1amlFOFpJR2R3VCtPUzladXQ3?=
 =?utf-8?B?NjBhSUxSaGErcW1MYmNVU25kR1pTNytYanh6TTlZRW8vWVE5WnVvbTRGVC9z?=
 =?utf-8?B?YTFwK3NzRDNLY1dnZlBiSEE4cGswclR2UDQ3bTVjTjRVZ205enNTb1lkemlD?=
 =?utf-8?B?M1c3ZG9jMmZjZjRBWElTNWNhWmppeHdWbzhIZFpIN2xySW9hQTJnS2VHdldZ?=
 =?utf-8?B?VzU1V3BJcDhJQVhoSXBnMUswNTNieG1tYTJZZDhFS1pMbUF2Ry9NNk0yVUlm?=
 =?utf-8?B?UDVEMk0zQkdycGpsY3hRbXZCQ2dHN1VQMXNDVGUrMnZWOSsrNnp1VkNtL3px?=
 =?utf-8?B?T1NNa21YK2VXUHdybkx0RTdLR1hDUFZDSldxSjVpWmlCZ2xJTXc2RHJ3Y0F6?=
 =?utf-8?B?RlQ1aHY1aWF3aXpiWklhREpMclY4aWQ2cTVUL3hMYVIzZkFRSnhRZjVWNWJQ?=
 =?utf-8?B?eWdzOC9EQlJNY08ydVRTZ3oydWZ1L3dJbWhuNW9IbFB3bE41N2pTdDZPVFdl?=
 =?utf-8?B?UTR1ZitNM2RNLzJYdnhTNi9KaGx2TFBnQitzOTNGcmhlUjdzc0k5M1pXTnVV?=
 =?utf-8?B?NGY4bXNBV0JaMkRUY0hmSEdNWStTOHpEWElkZFlSR3FsaUp1dzFnOW9lQ0Vt?=
 =?utf-8?B?TFdFeTkwZUFtT24vUm9PRUdjc3ZoZ0Jtcnkra3BJTU1GK08rNThEdmJqWk9m?=
 =?utf-8?B?cFJYYkczNU9yYS9yWDdFaUJQUmZXM1IyMzhEYVgxTE1HdU9hTUlidk9ZZEtU?=
 =?utf-8?B?clBCQ0xKelFPbmxvT2F4NG1jMG5MV2o5eG0vQjJuclAxNHhScHJMYjBXK3Nk?=
 =?utf-8?B?cHJxT3RPclhaaGJWT3dMQndtaVMvK0dNVFdZcXhkN3lEcDlEdGY5NXV4TzR0?=
 =?utf-8?B?R1I3U2NCSG11TGxUbzF0c0daakw5SUQ2aFZITEhWcFNSeFBkcGdhOTN5MVNx?=
 =?utf-8?B?Rm5KODJ6WmFIYlJzNTRRalhQM0k0SkxweDVnSjhuTzd4TDRiRTVhNlFsWmVz?=
 =?utf-8?B?ejl3NUYwTzdqUENrTG84NkFLbXdqdXR0ME5QdGtxQ3RYZjI5R0VtclN0am1B?=
 =?utf-8?B?YVhRNjVlRUFMeDY4NnVqZFoyOVdVRFFIeis0TXVsR3g2aTUwRE0va0Vtd0ZL?=
 =?utf-8?B?emN4dGNlaW1nMit3ZTh1ZDBHTEFxeTlaVXFVRmJ1Q04ycmZjYVlqSjV2TCtw?=
 =?utf-8?B?OHZrUWN4bk9wUEVBbGpSckhnanY3RER3OXJZTGdEN2dLdVpJemJLaXNKMTdZ?=
 =?utf-8?B?NkVUVHFVS2hqRTJFNit2QlNyMFFnZkR4ZVNHS3NpRXR5NHN5NTB4QkhNUWFk?=
 =?utf-8?B?MWRuWDNMNGRkdnlaZDVPcVYxQmYyWnhIamx5dzhpRWxmK28xU1cxcVZHdis0?=
 =?utf-8?B?bE0vVllQUUZweUxndXAyemNuNmlQd0JyYlk4d09UU3FQRzVyRXBsTm12ejMw?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nxzGsMy13/EkB0Pa56C50sj7k16P5tY0PZbKy/CXDpDfmiR+ERqI5s1nOOO61Tm8DYwhjcDi3pPnFXjD3Td+NYuSyZbnxeEYrMcYepjr4KhUn1FnOYgMwzksHEKm7CtV4Pyuf3CHvMpPbNLJcxOXE24l66FQaWuftiz+Gvb+w1ElgjNTo/RwYZeFNgKhkMOLf3lmB6R15sjG/L97hgfebTOWcaebWSrND28B7l/zNgbqAJxFD5s3tq8j8+Yck1LGfqLuB3xZdD8k2jBu/E9tX4025hzUA8LgmEHS6qwZCTT55QyKZOV/59/1Kjku8kPPAZocAJCHcx6jtTqVTjyAZLT5Bry+52cv6w3t0i8f91S+Sy4XgkaYK8MJrPtHUAZrMXo777zZC5L09u0nHn4KbKlHTK2rGBhK79h27XaHVxaGiu4kpFvo3JRKS0e7EzyAsv32wnHCgS2YyWYIZ/koS/9zFHlIT0egT1LTUoM1Gh59sBO6fQh+J+NCrOAfZeZovhKR3Jh3yG1luMjoZQfnNfGYT+rcBxyZJWEw+sPbZUxVMmVlVY3BqeOn2Ct9O+JfYPs7rxXou3Agq7YHfc2A1U8rSKyKVnkpiONCB+0RNKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e130a3b-3bd7-429a-a967-08ddea688724
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7653.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 21:34:42.3033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA04epUqbdHyuZHxY/PcWKZTqFHXgaTkH01ZlLQfiKYT4V1LwS7abAl7Zk4L4F5KzlDZq7WstoCERUUPdLzH+vyu/BI5bIElQZ8G+TPx4BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020214
X-Proofpoint-ORIG-GUID: o_yyNUTiXEndCE2t99q34dVw93qp6cIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX1PdFfEgJPgBW
 4D8bcNIRDsazIKn/0YZlS8stvzEvAczcxGD3KnUFHX7PZ96jgJEEWxmANQsInretMAmrn7CDxuy
 z1SouOaw6o8+5wEELDCdtAFb5zXP1eJIwe1x1JwdM4VY+We+dxCntTbVGKqK115OLXx/lRp6I0B
 xoJZip++exDOLAjmQ9WRfT9kTnHeI2Khum7/oOACaTFj5ND+Cab74l1Ap96UNQjr4NfaUUfmJJl
 Woq7YMRFOum1u7qBRPQv2Ma3IQcaPJWDX5W2mzGauUiz0W1jJZg9buo792U1C27Rl3wXrt9I/gJ
 B8paV3Zq31jymqD8rYWL9mfS5vZBVbsXGODfdudxUIpJ8yCQwyzjvZWW/Ejtnd062jR6Gbby3k2
 QFOHseMp
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b762fb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=968KyxNXAAAA:8
 a=lQHjxRLVID5O1YWMZxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o_yyNUTiXEndCE2t99q34dVw93qp6cIj



On 9/1/25 5:50 AM, Yongting Lin wrote:
> On Fri, Aug 29, 2025 at 9:00 AM Anthony Yznaga
> <anthony.yznaga@oracle.com> wrote:
>>
>> Hi Yongting,
>>
>> Thank you for doing this. This is a great start for testing mshare.
>> I do have some comments below.
>>
>> On 8/25/25 7:57 AM, Yongting Lin wrote:
>>> This test case aims to verify the basic functionalities of mshare.
>>>
>>> Create a mshare file and use ioctl to create mapping for host mm
>>> with supportive flags, then create two processes to map mshare file
>>> to their memory spaces, and eventually verify the correctiness
>>> of sharing memory.
>>>
>>> Signed-off-by: Yongting Lin <linyongting@bytedance.com>
>>> ---
>>>    tools/testing/selftests/mshare/basic.c | 81 +++++++++++++++++++++++++-
>>>    1 file changed, 79 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
>>> index 35739b1133f7..2347d30adfee 100644
>>> --- a/tools/testing/selftests/mshare/basic.c
>>> +++ b/tools/testing/selftests/mshare/basic.c
>>> @@ -3,9 +3,86 @@
>>>    #include "../kselftest_harness.h"
>>>    #include "util.c"
>>>
>>> -TEST(basic)
>>> +#define STRING "I am Msharefs"
>>> +
>>> +FIXTURE(basic)
>>> +{
>>> +     char filename[128];
>>> +     size_t align_size;
>>> +     size_t allocate_size;
>>> +};
>>> +
>>> +FIXTURE_VARIANT(basic) {
>>> +     /* decide the time of real mapping size besed on align_size */
>>> +     size_t map_size_time;
>>> +     /* flags for ioctl */
>>> +     int map_flags;
>>> +};
>>> +
>>> +FIXTURE_VARIANT_ADD(basic, ANON_512G) {
>>> +     .map_size_time = 1,
>>> +     .map_flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
>>> +};
>>> +
>>> +FIXTURE_VARIANT_ADD(basic, HUGETLB_512G) {
>>> +     .map_size_time = 1,
>>> +     .map_flags = MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIXED,
>>> +};
>>> +
>>> +FIXTURE_VARIANT_ADD(basic, ANON_1T) {
>>> +     .map_size_time = 2,
>>> +     .map_flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
>>> +};
>>> +
>>> +FIXTURE_VARIANT_ADD(basic, HUGETLB_1T) {
>>> +     .map_size_time = 2,
>>> +     .map_flags = MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIXED,
>>> +};
>>> +
>>> +FIXTURE_SETUP(basic)
>>>    {
>>> -     printf("Hello mshare\n");
>>> +     int fd;
>>> +
>>> +     self->align_size = mshare_get_info();
>>> +     self->allocate_size = self->align_size * variant->map_size_time;
>>> +
>>> +     fd = create_mshare_file(self->filename, sizeof(self->filename));
>>> +     ftruncate(fd, self->allocate_size);
>>> +
>>> +     ASSERT_EQ(mshare_ioctl_mapping(fd, self->allocate_size, variant->map_flags), 0);
>>
>> The tests should differentiate between how much VA space is allocated to
>> an mshare region (i.e with ftruncate()) and how much memory is allocated
>> within an mshare region through the ioctl. While the bounds of an mshare
>> region need to be aligned to 512 GB, the memory allocated within it does
>> not. Right now the tests will try to map 512 GB or 1 TB of anon or
>> hugetlb memory in an mshare region which will fail on smaller systems to
>> due to insufficient memory. Better to allocate smaller amounts so the
>> tests can run on more systems.
>>
>> Anthony
> 
> I Changed my code to allocate a smaller chunk of memory (i.e.
> 4K/8K/2M/4M), and these tests are passed.
> 
> But I found something different:
> step1:  ftruncate a mshare file to 512G
> step2:  ioctl map 8K
> step3: but after that, I am going to mmap 8K to a process but it
> fails, then I have up to mmap 512G memory to process.

This is correct. For page table sharing to work correctly the entire 
range of the mshare region must be mmap'd into the process even though 
the amount of memory actually mapped within the region via ioctl() may 
be much smaller.

> step4: Accessing the memory within the 8K boundary is fine but get
> segfault after exceling the boundary (as the vma of host mm only holds
> a memory region of 8K)
> 
> Should the mmap region keep consistent with the ioctl map region in
> size? (currently, ioctl map region is 8K, but mmap region is 512G)

It might help to think of the 512G mmap region as a window that gives 
the process visbility or access to the actual memory that is mapped 
within the mshare region.

Anthony


> 
> Yongting
>>
>>> +     close(fd);
>>> +}
>>> +
>>> +FIXTURE_TEARDOWN(basic)
>>> +{
>>> +     ASSERT_EQ(unlink(self->filename), 0);
>>> +}
>>> +
>>> +TEST_F(basic, shared_mem)
>>> +{
>>> +     int fd;
>>> +     void *addr;
>>> +     pid_t pid = fork();
>>> +
>>> +     ASSERT_NE(pid, -1);
>>> +
>>> +     fd = open(self->filename, O_RDWR, 0600);
>>> +     ASSERT_NE(fd, -1);
>>> +
>>> +     addr = mmap(NULL, self->allocate_size, PROT_READ | PROT_WRITE,
>>> +                    MAP_SHARED, fd, 0);
>>> +     ASSERT_NE(addr, MAP_FAILED);
>>> +
>>> +     if (pid == 0) {
>>> +             /* Child process write date the shared memory */
>>> +             memcpy(addr, STRING, sizeof(STRING));
>>> +             exit(0);
>>> +     }
>>> +
>>> +     ASSERT_NE(waitpid(pid, NULL, 0), -1);
>>> +
>>> +     /* Parent process should retrieve the data from the shared memory */
>>> +     ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
>>>    }
>>>
>>>    TEST_HARNESS_MAIN
>>
> 


