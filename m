Return-Path: <linux-kselftest+bounces-29776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C90A70A1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 20:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41816189BBEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE71E1E09;
	Tue, 25 Mar 2025 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fPrZZVMj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IswW5JLf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3E1DB933
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929936; cv=fail; b=EY3UTPxWg501hC9hZcIZNelqkgaYVUGYY2Lpu3mpgP5tYHQOuZHre3V56PNCo3j3J/giGatIRlC40TWMPv+HLlVrsfaLs91XyyK1E/P1h5hNsfW16UlNkuUKM6bYoH4GtPgDgO7iuXkbrXgfvkt5Wh8vaxX94fAhWq7R1zqosqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929936; c=relaxed/simple;
	bh=WtGpVElQT2JRNJ7d2CG9kW86Ib/M0ZTWGcAWa+9Y2jA=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=tJ87IRmjQKL0gWS4YsOLLrH3pcNouQU+HK+8BJ7ufp4ctNk2MviE7Q2uow2IAfhEsl5XUJAvxz2fnTdKxCJ9griIkUr73PnZgev30T6sPdN/fUYBj38GbPlelATVKDA1X5mec9QHRoiodYbevlsoZzAJlLZZd2zCwWfKI6kHCj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fPrZZVMj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IswW5JLf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGuNVI025149;
	Tue, 25 Mar 2025 19:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=6hRJCOm4JDCHqnj4
	wjmyHpPKW6Lxl0XAi/LDJQIcltA=; b=fPrZZVMjvYSk08BVpqKGSLqLQc6WHLdg
	qIlloggz+ypURIzI547v3RcqUitkx8a2HvcbXaPJ03jRXMx9ZcCphacYTbIHD741
	UF97qh/GjNV3z2Imajr/cNNLwBcJ25JH+YBIf3PQMwZje5lywm9Vh6bQH2pFRvNR
	Jbuaf9UQLcmB3lT1AjcYvsN5rt/xMhKmmPqf9cqAdLT3iCTz6PVFbxAtMTpUBZ5V
	HzPTYyB4hTKiB6lW+mzkul82QVylkqIuHpfgvUl3YE9EVxG8ineIEUgRY/xz2b4O
	HmO/M5M5i8Rvb+IBYZcHCiJ4JKfnbKBP9cumFvMuNR816ZLNzmSBjQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrqwe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:12:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PIHNAS008276;
	Tue, 25 Mar 2025 19:12:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6ujntc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKurGQ0CparfWYoYGekNHWLdGzwhwwRRFpnNOndex1UsNT7//DkQwDqH6X+Zqh1dHt/W27gIQOOTAzP6YV/Y7b+cXHzS/XJoX6SrY3JXL1JFedwwRkZt/bd5fnggEy7u2kRkjnTYd88/8CETt9uOUgwaZ5eYeQDnffv2euuPTrWq4QSp0tKQtLCEAdKKLFyUqW1Lq4f864IB/YPFoLjaYwfFpIqESDMK6SXU7ONefbP17HwWr0jK31EfYYyMEso0ePlb+gPrsaDIeqHRKjDvaAmFXkj/p3GxwB9UCupjsIevU2ShhUViSIKUrySOI7bCVfxs6Tlgw6I9xiy8A3lM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hRJCOm4JDCHqnj4wjmyHpPKW6Lxl0XAi/LDJQIcltA=;
 b=LYZY9RjKB91cg4UmlXwhAW3IY96KQ2rhuCDWZBFhYMeJ+3pelnlbxtEVH8cWiNgZHtOj7YWykFjAkK504YnA6tZ2BcClveLvRuAAoq7/wNisUNMtpUmweZoPiztd2WB4iuWMeKlSQRlPRem+wAZm+UKXWT0YtGpCV556r4u77p08wRo1aX4t3jTPRj5hVuaqrIJjMFH5dU+R9PZhCxLsWABbuOpH90Y84CYVui92nhCTpnXKIdyqL9NxFiCyqdPkCFlwROBI8wa1Yd4pUNYblq1TtwOQNKVAapYJ64wMy4SZI3KVw0ZLugI2vIyFGKR4L262pzOB00WnE6OOrYlsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hRJCOm4JDCHqnj4wjmyHpPKW6Lxl0XAi/LDJQIcltA=;
 b=IswW5JLf737hw0bIfEbDDOWcChVapfraw1MHgvVS/fSNaMI7921YQ7lkXIcwnO12bXrbqC4xbaZG7zLrBrtQZ7q8xoP8ZlrAG8kmQ5SCTanwgZX1NBBnGXkzMn7EJJld0z8WaG9extGE9fl5zC9DKyRmsfqhUQAlIuOrZXlBiu8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA4PR10MB8302.namprd10.prod.outlook.com (2603:10b6:208:55c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 19:12:03 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 19:12:03 +0000
Message-ID: <63be6f9e-b13b-4b93-9b05-6ad2790e98dd@oracle.com>
Date: Wed, 26 Mar 2025 00:41:56 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: shuah@kernel.org, horms@kernel.org, pabeni@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc: linux-kselftest@vger.kernel.org,
        ", Darren Kenny"
 <darren.kenny@oracle.com>
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: kself test fail for "kci_test_bridge_parent_id"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA4PR10MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2a8770-3016-4ab1-914f-08dd6bd0ed1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjZGbERNakZ6T2dQVUlkVTBtVGZoQ1R3ZXdMMVRqOVB3a1pHWmpjSGk0cWRP?=
 =?utf-8?B?RU4xb3BhTGFQeU5CL25yWldRMkZXOS91TzNVb3lzMUh6dTdPN0dpNXNuaEFH?=
 =?utf-8?B?OEc1d0E0ZHpTNmxsMHl5SDZWZ00zWVQ0bC80a3pOOVRwM0s0MlhZYWdwaEZF?=
 =?utf-8?B?RHZrRGVDc1JXZmROLzNkUlNPR3kwclJtbXc0TmtTOGdOa1FDS3BHM1BYcDhW?=
 =?utf-8?B?QlYwcW9qMktQM1ZQcms0OTRpK2EySWdoU2NkZmQrVlFORnJPRFl2TnBTcStj?=
 =?utf-8?B?S3ZmbXc1aUxrM1kzV1dlb0VRY1N5Y3hyY0d3djEyQ1BwY1NaUm9uNDZvZmJ5?=
 =?utf-8?B?bk53YlBtZlloMWh4dThMbCtHOWtiMWEvaXBNckVVaFE4a3UydUVlbkNVcmtO?=
 =?utf-8?B?SWQrOGZFUXpxRTN5dXR6NVlBWVNxcXA2T3plRDVscFJ1anBiV3VPZExXb1M1?=
 =?utf-8?B?WDdlcmpQcnh6UzZYKzJ2QVJOK29TRlVrb0ZJajNMcC81MDBJRE5zb3FWV1ZJ?=
 =?utf-8?B?SEJHOW9weXgwQkVxUzh5TklDSFRZSjdiTE54d0RqVkhHUmM4UVdrMFFNSE84?=
 =?utf-8?B?WTd1TXdUYzZKL2l4THU1emh2UzFraWdSK1NUbXJuT1lRSEhnc2E1cUY0UU9Q?=
 =?utf-8?B?YmhUaitqWjl3THZ1VkhZTHp6a2svMlJvdldlb3ZScUNGdnNvRE9aYVhUamIr?=
 =?utf-8?B?NlFUa3pCUFdFOTZJT2dKeVcxQ1ZDWHNNQlArRmNwT284dmEvUGFML3FtZ3BR?=
 =?utf-8?B?cU4zRmlyWlNjUXA1VWtVVXFiOHA4UTlQRG15SUdhejlLb2ZIMGoyU0lFYm9X?=
 =?utf-8?B?dEZMVWhlUFRwc1hKcE1qM3ZVVXNuNk9iTXYwTzRKWmJYamhDeGphK2pmVk9I?=
 =?utf-8?B?QVFRVUpkWU9TNGovN3VEZXFRdDNUZWErREtMVVFCNUJGU1R2dlpVSGNXOHpE?=
 =?utf-8?B?TS9lNjZhR1NxWnRKWmFVSkZyTHNXdFVlNEVuUEZvRXNDU0VKeFUxeVIxUWdt?=
 =?utf-8?B?ckV3ZWlZZG5JQlNEZWdxQmJyMHhBY01mK0drUjZubWNxeGZFdSswTmhNdjlu?=
 =?utf-8?B?aGdzU0d3ZGxkY09TSCs4dTRnVjR1MjFOaE10b25Ic0o2UkZ0U3JIUHhZcnhj?=
 =?utf-8?B?eUFlREgxZ2FjNncrMytNU0J3OVVpNGZNNkJ0NmIrQndhNzFGdmpwV2pDTXB0?=
 =?utf-8?B?QitJNnVzYU9hbkVGcGRZa0UrVk9ONkxvWTJwckxtY2hhbyswcjZOVXlkWERZ?=
 =?utf-8?B?Qm1TWE1QVGJsdjd5aWtnOXZhdHNHK2Z3bFZkYysrK2xXZDAyUUJoRWtUWCtq?=
 =?utf-8?B?NHZJVS9kYzZWTlBDSFpGSlRtZTB6V3g2elhhY2JBenNweU5vT2NnVHdvK0Fa?=
 =?utf-8?B?eUxFVXFBekVOZnZkV1FxRDdoNDhzeFZUT3VXQU9JOUpHSndoTFRxM2hNUys2?=
 =?utf-8?B?MFg0SDltd1p1M0ZFRExncFMrWGxSNGNiQlhRcERvbUUyOGt6Tm43eTF0cVJG?=
 =?utf-8?B?V0xqMzhxNnczVUpDYndtTk8wbm1TczJjcEFNNnlYc0dYSHhvYlNJK2RvVE9X?=
 =?utf-8?B?b01SWTloMEY1NkJMMStRSldCV2dtWXBvT3A0SUJHSzBkTWdtcHVMTmU0ZENP?=
 =?utf-8?B?VEtsWUZjQ1drZGw0N1lIQk8zUk9XRG5PNzRDajU5dXl1OU9ieXBPeWphSEdH?=
 =?utf-8?B?MW5ucVdFY1pIb092bWtnOGlRMEIrMU8vT201RkNLa3VoeVZpOHBoZUFBbXA5?=
 =?utf-8?B?MDEvTjVZclNEQ082Ni9nWWlST010Zkc5L1lXRytMN1pYejVtMlBHTjE1YXhj?=
 =?utf-8?B?aVhUaExOWWVkOUpKeng0SVhyTHZ2R294cFdqWFRQMy9wTUM1cDZtTGRGajV4?=
 =?utf-8?Q?sGu4q+g8K7bDA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUc5SmtSdzRjWW0vb3g4bGdRTGVvWDd6NGl4SmU4TVJYbU4vUUVGdzNFK0xB?=
 =?utf-8?B?cG5XZkk4VlY3WHEvYVQ4VDRqcVk4b25FdlJOVm5KdnlTdmNhTzE2OG51Uzlr?=
 =?utf-8?B?cSt3bUhPZTIzaHUxQnhiMjZha01UWVE1SVhVV0hjR3J2dzd3b0xXUzl0b3E2?=
 =?utf-8?B?cGQ5d0tZbmNpbFVsNGpGYzcrZWNvaTJRNnhPanBNQUQ4aDhIQ1ZJR1NHU2My?=
 =?utf-8?B?ZlFqQmhETlRYdmluSjI5blQ2dzBHQm84aHhENWc0VzBPK2JrOHYySnRlYnpE?=
 =?utf-8?B?RVAvaUZtNVdMMjFTTXJTTitBbVI2Z0JHV2VqdTN2TkpQSStvYXlNYVhBQk9U?=
 =?utf-8?B?aUlJM0JmOG1PQ3Vpc3FlS1VmZHY4bUNGRHpMOXZFNGFSQmFsWnE3Vi9JQ1pw?=
 =?utf-8?B?c2VMbG12MnhqMFhzcUFyclBkODFkS3RxaE1mM050OUE5QUFTeVlVQzUvNU5R?=
 =?utf-8?B?ZE9OazhYSDUzVnpsSU95MEV5Q2hTaFJmUHZiWnZnV2MzYS8rdTVqSmVzdGhv?=
 =?utf-8?B?d3I0c0NjWFAvT3MrUWxLZUdRL3hBWU12MnIrOXM1eC9NMkVjRmh3TUVPd3FP?=
 =?utf-8?B?Tk1YVExtSVZzYVlGZTBJWVp5b3RMM3Jlamxsd2hmRjFsMjVQNG9JNTZaNHla?=
 =?utf-8?B?YTdlQ1Bnckppd25DbmJjUTgrdzJvbWFmbHlvTmdQeHp5TVJNSWFxZnVNTVNi?=
 =?utf-8?B?QzRBbEpCK3JrUTV2aS9qV1pyUDA1MllhUXhDZWk4VDc1UEhkTjhzY2dMZzhL?=
 =?utf-8?B?OVNJMktjcklNZ2RrUVdmZy9TMlBtL24rUFJxanAwQmhxWEpRTU9XaSs4Z0tJ?=
 =?utf-8?B?SGlpdDhETXpHS0JFYktSbVRSUHUyMU5hZWswZ2dqR1kwUUoyZzNRMUJqQzdI?=
 =?utf-8?B?VnYwZ0swRVI2OHVsRmNJaTFYdk5EQUJiV0c2Ym41OW53SlZTdHdjRWprY09W?=
 =?utf-8?B?eWl1Qi9FckE3VEJVSmZJenR3Yzk2MkZmbllSOXZ2YWhMTDAyaVdTdjZXOFRK?=
 =?utf-8?B?MmFqZEFZdThpM3RiemRrM0FFQlZtOGpsN2pEbnBLUVRVS2kraWpVMUxoeThn?=
 =?utf-8?B?aVpCcUc4eHZjYU1OYTFtS2xrVnA2S3NER0Y1aG1jdjc2M0grUGJtK2lJTnlx?=
 =?utf-8?B?S3NnM05VcVVXeFJtenlLcmkyQlNWdnhJSGhjaGttb2ZtVXZucUJIRWVVOWls?=
 =?utf-8?B?dDFVdEZVcUczc3YrSVBkZEh3Ui90SFpoVjVYcHRuOUh6Ny9PZWpmRW0rM1F6?=
 =?utf-8?B?YUQ4blZxcmRXSWs2NU1Dd3pUWVhPV2dzS3Q4Sm8zMGg5cEIrdXovSFloV0Rw?=
 =?utf-8?B?azgwMnRLQkVxR3dHVzVDdXZXZkpscTdROFA2Y1U1alJ4NEpjUHZQNURndjhF?=
 =?utf-8?B?YTEwSE9sOXpiZlNCTHNXQUFUUHhJKzhaQW9wZnpRbXZwSlBGRWJ1cTFJTVZW?=
 =?utf-8?B?V1I5Q0xGRTJCWnozV1N5SXhGR3RHUkV4dVAyODJYdlhNbkl1eG5rS1ZIVURN?=
 =?utf-8?B?eHQ2SDc4YlJaai9RdGc5VlpwcE0zeXBCdXR6bGpQaWxKcGZHdmlieHZDRzFx?=
 =?utf-8?B?ZzJTaGF5R1kzTWxvakVTbWVoc1FTYVM3aFZ6MlhGSmNVRlBLbFR0dVQ3bkg1?=
 =?utf-8?B?STZ3T3pJeFZlRUhvOHdIVE1qcXFmd1l5SDFObDYyZUp1MkpOK2gvRFFsd0FT?=
 =?utf-8?B?ZElEQ3BjS3BUT0dNMFRjY2tiUGRqMFhqVDZwWGJuTWQzc1crMCt0Z044anda?=
 =?utf-8?B?RTlVd2FFaHU2WWFpWkJhQUx4TGVvZ3Nmay9ZbEloMlBaMjRtTDdybk5DM1RY?=
 =?utf-8?B?eWNENVBHanRiR052bThKUzV2Q1RIelhOOEtlTWNHemEyV0t6djh6bUEwRTkv?=
 =?utf-8?B?VkFtMTQzTEJUR0xOSXpNZUx3UUhhTG1MVU1LWTRCTUZZZ3UrZzZYcFZhUmRK?=
 =?utf-8?B?VHBlWm4zWFM3cHVoWW5KUHdBU0E0Y29kUXd4aCtlOStSN1NLSDRxS09XVERW?=
 =?utf-8?B?MVU1K0swOElKSWgzRjZMTEtVZ3JrWkFUdE0rZ24zNGNCY0dmUHRiUCtNWXNv?=
 =?utf-8?B?ZkloZmJzcFUyQWtvOW8zS0NmM1JSRVNGbGFPdWdxRWZ1aWJsQ1dtY1BIeU5W?=
 =?utf-8?B?Z2JXOFA1OGxlVllFUXNRTFBqa3plZ1k2V2craGl2MGY3VWRlcXBaZGZPcWJu?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7DFgSAhV0MSUQ1IW8lQG+yRZohzLD9vd+sLWz14SC8TgUcxVQfjEjJW/YQ/DdDxdTpqbtKTTVfiiIH0n7ydrLx/voQUgZeBTbFhKYeqAz9IaQwBR55RvImyq5M8MTjOYJIqYSw/6jX61yD6dwwjEJWO4zkXToKPxBi/rkx72uilLm85lb/VC7Rg1EoJLxAX8lb27VLj2k/yNnNH81chxO48psls0Ejdb2awYW+TWNejtCfeWxqYK7ZichgzSvkNrlDz1CqBtJDyQ4fWoZiBVMlTei3ezkMQtTuByYL+sBMAlXhjwwkjLJnLRv58DcM9P+q6S3OfJTFiStVHL0gewKMGXNRf+PtUof4huMpAJUgwiQwfBt3urHvtvWWQI1Z5FhT7oKVKNub7Z2qrdhWrBDgJ02sdTswJR3Mpm2nCxR+eyl3S4wtTjhOiUMcB4QcSVt6TyPuq7KLhULl12DZMGbx5WHX2v823s7jWeIoRi3EC8Ht1qbX2o+ZrSIlZvYdlHH6/GFN+uc1za3SLiLoO7+QzG0lCk80S9vNZwfPvLhNZ5CGPHOjBX29vj9RgPAIW6H3aXgaoucmj/Ys9Q0g0IimLqYR/iNH5gaNWIEkfOIYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2a8770-3016-4ab1-914f-08dd6bd0ed1a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 19:12:03.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bi+J55AyrHfZZgncq2Mo9pmYn/l9LIvbG4Z3UkO16ilO5CJd2g1NuCTW7sHY5RxAbyza9WNq9O8flSJLfhRtAUKmGX8khFecyg96dNOGEd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=915 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250130
X-Proofpoint-GUID: NXS9s9TtHNt2tDU7LePHA0ELEG2E3AI1
X-Proofpoint-ORIG-GUID: NXS9s9TtHNt2tDU7LePHA0ELEG2E3AI1

Hi,


"kci_test_bridge_parent_id" test failed with error "as device can not be 
enslaved while up".

Here is Error log.
-------------------
 > ./rtnetlink.sh  -t kci_test_bridge_parent_id -v
COMMAND: ip link add name test-dummy0 type dummy
COMMAND: ip link set test-dummy0 up
COMMAND: modprobe -q netdevsim
COMMAND: ip link add name test-bond0 type bond mode 802.3ad
COMMAND: ip link set dev eni10np1 master test-bond0
     Error: Device can not be enslaved while up.
COMMAND: ip link set dev eni20np1 master test-bond0
     Error: Device can not be enslaved while up.
COMMAND: ip link add name test-br0 type bridge
COMMAND: ip link set dev test-bond0 master test-br0
FAIL: bridge_parent_id
-------------------

upstream commit ec4ffd100ffb ("Revert "net: rtnetlink: Enslave device 
before bringing it up""), suggest the following scenario!
$ ip link set dummy0 up
$ ip link set dummy0 master bond0 down

According to last commit, do we need to modify 
"kci_test_bridge_parent_id" test set to down.

--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -1129,8 +1129,8 @@ kci_test_bridge_parent_id()
         dev10=`ls ${sysfsnet}10/net/`
         dev20=`ls ${sysfsnet}20/net/`
         run_cmd ip link add name test-bond0 type bond mode 802.3ad
-       run_cmd ip link set dev $dev10 master test-bond0
-       run_cmd ip link set dev $dev20 master test-bond0
+       run_cmd ip link set dev $dev10 master test-bond0 down
+       run_cmd ip link set dev $dev20 master test-bond0 down
         run_cmd ip link add name test-br0 type bridge


Success log with modified test case
 > ./rtnetlink.sh  -t kci_test_bridge_parent_id -v
COMMAND: ip link add name test-dummy0 type dummy
COMMAND: ip link set test-dummy0 up
COMMAND: modprobe -q netdevsim
COMMAND: ip link add name test-bond0 type bond mode 802.3ad
COMMAND: ip link set dev eni10np1 master test-bond0 down
COMMAND: ip link set dev eni20np1 master test-bond0 down
COMMAND: ip link add name test-br0 type bridge
COMMAND: ip link set dev test-bond0 master test-br0
PASS: bridge_parent_id

Thanks,
Alok

