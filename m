Return-Path: <linux-kselftest+bounces-40802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F3CB4451A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A5D1C87C9F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CAB341AC1;
	Thu,  4 Sep 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P42hLdOQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N/xhcgaF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E92356C9;
	Thu,  4 Sep 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009450; cv=fail; b=bCVQMgTwkZ5GiZJ2Mtf5Mf0+0AizZsoxhFNpXnkpKHN8Vaf+tRu1Cit8he+4gKFmLpDiSfA6XOy/YUnWY9CE31C0jmm25pkbc59IbvlNTXTbuM74TZbN3VF3NeoJcantdZOw23wYXG/AO+uyBL2xe+NHZWuQOoa1qhi4kwuGbBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009450; c=relaxed/simple;
	bh=OlM/uHpXgwBBjeU9qXr/8OCq9QZJ8uGJ/wlG+aLdxS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/lMSmJlS6yFEL4rKXQ7wcxHKVSCFnvdb/YoO/dizi3CKCzA1nN6rShByJvp8hh5q2WajSZ31vK1SE48MQHHjjZVjJW4cOZkgruK9JT+Qmp13d/D2lW+TVyUTBkf30XShOUGgiXJXCZ5enbyJOAdNmZHCE0OokS0rh08HOU/kNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P42hLdOQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N/xhcgaF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584I4eoY025943;
	Thu, 4 Sep 2025 18:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/JIbl8CTWINaNEjmy/tiMutyxfIw9vEL1YjybuRmSv4=; b=
	P42hLdOQntfuu5iz+3H6OpgB7pj4yYp6r+Gdm97TKj/T9NrNOcYgfJ8Fw0gyHwIn
	gPYsJA5L9F3HObmEliVHOHVbrTwu5kDxo1da4TVixBb2QFdGDnJg4qB/RMTe1MRb
	iKQJz1YSpgaSkOexVm7Zcm+2OgIO4Z3swG/5yxTrPJvQfHVhMnBiDhbrxBhLebjg
	xM1uZaNu5ZhFFQm2108+yNSYf+MoYoW6iTvQbTKxnFHA1KQoFTl7qTY9HjPKJCqI
	xe31A6V13NYeqdG947f1XRevdB062FJ0u0VrUNMwPksTMJMsK09wIYc9ZurtDh3o
	zeVbk+BoAS4wzE1qt92UFg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yfqq8098-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 18:10:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584GIMrU032645;
	Thu, 4 Sep 2025 18:10:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrj71yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 18:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvyYinndO7L3CbzZSbqpyizRysIfabXlomNp/sYcbzU+U+B1NPF6dcQhT2O4WrXHdDvV4lU2Uw/Y0EA35PyoRo3LbtTaSDydZJF97H96n+KBMJG+Z2+TL8JHob30nXh8M8P0wQsRfsvtSS8r54df1+VqoqEvrkWkpL1w9zoNvR7K4eVbwFUp+rUzz2lfYguhOGu4mJl72n/XUMySKgDjobD3Po86Hp6G+mHJ2PyOvgUGG+GoRdxI3ovlNns0mmseD6la7QGM0XjwOVKVNcTVF7+JzGbVltttxIrUM9ncTLfQFLsOfQiz3nDUdle2CT7Dfz/xj4/ecARwbQZG1snf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JIbl8CTWINaNEjmy/tiMutyxfIw9vEL1YjybuRmSv4=;
 b=bN4h2+isIVY33h88aymfVzyIKKGlc1G7MHQtOvFgkDV8ZzkpvQRxLb1qCzkyAbHAptgzdYhAiUO1Ktaf+hZc22rbiV/9ITRd9Sx0qF22KdW40srM9OxFYGyVz1bJjbkm7DK88K5Cd8X3TtQJCscEnA24t06f2btSNPLC0O59vXK/myoSgC0R7cwocbqdSmaKq1TcV5V+x53QGGVWsrhzvAUpofBPwlEzLHHLzI1TaH+qlnSAlYUtriuLUTyp3vO/DGtzlLrfK1A9wCmfgh6d3V3TsrxytVJs0sTJnk5OEbdYaeK5jY88dODix0h/D1TD6+DLJirNMaje1expJ7ziag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JIbl8CTWINaNEjmy/tiMutyxfIw9vEL1YjybuRmSv4=;
 b=N/xhcgaFo+iri2umfeiW9Yvc4cNnTf1CQHagrP9yhBgxTWhN1WjeCwokz9kVqWMekUPXG/piKI9KMl7SbAc2WzFUVec5QGLWkh9CkB7R8WXkX8jUbjtcmdvBN9xAg9PB6lZ9fvsLnUxXWeAjym9a+3ldAp/YxDGlN3cQGADD22Y=
Received: from SA1PR10MB5509.namprd10.prod.outlook.com (2603:10b6:806:1f5::20)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 18:10:38 +0000
Received: from SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24]) by SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24%3]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 18:10:38 +0000
Message-ID: <831c2cad-c929-4190-8c79-da8192124a9c@oracle.com>
Date: Thu, 4 Sep 2025 12:10:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Sargun Dhillon <sargun@sargun.me>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20250903203805.1335307-1-tom.hromatka@oracle.com>
 <CAADnVQLve3KgrqNqSqVrmL-wz6Jj1QUdjAcE5P26Z4wvh9e4HA@mail.gmail.com>
 <42cf76db-6cda-4606-9128-6f433da57d48@oracle.com>
 <CAADnVQJSgcAjEnU-A9bF6-9MQRFvbHqRsCCY7a0Y6bhVGtcGpA@mail.gmail.com>
 <21b618d5-7f6c-4b06-81be-eea6cbac5ba6@oracle.com>
 <20250904145420.GP39973@ZenIV>
Content-Language: en-US
From: Tom Hromatka <tom.hromatka@oracle.com>
In-Reply-To: <20250904145420.GP39973@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:fb::13) To SA1PR10MB5509.namprd10.prod.outlook.com
 (2603:10b6:806:1f5::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5509:EE_|SJ1PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 936ab29f-cdd9-438b-3242-08ddebde59bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHBSWjlBbGoyM0lFWDZlR1JqTGUvWGpTSjhvRVNwaFR1SGk2TGFWUW41bmJi?=
 =?utf-8?B?LytUR0Zrei9ZN3pTTkhCV1AxMFlxR0dMYVhqelVvVU92MEllODEzKzQzd1dm?=
 =?utf-8?B?WDBiano5eHVob1VFRmRGNzZha0ZRS0xib08wY2dtME1ZMjdsQ3JtSjZ1ZjJi?=
 =?utf-8?B?d1d4NDR4cmdJNU9hUnNsa1oxNE1qWE1yeWovYThFTmhnTS9lOWJCcmpEUE8x?=
 =?utf-8?B?Wk5GMC9pa1owTi9BZ21lbCtmT3FLd0JhWkl4UTE2UlNoSmJKbXJxbzlKbTFo?=
 =?utf-8?B?aDBlNlBZSkZCeUVrUy9EK2RHbG1qeE5rdlczSjlwdkx0ZVFKL2ROV0VLa0Fu?=
 =?utf-8?B?enRlZ2t1d1ZJZStheTZEb3VDd29JNURjc2pMaXd3SnJSdmJidWpjYmZLYVdU?=
 =?utf-8?B?YklpbnI5cUk4SWJVdDJjdWREbjNiREQzSTNVc1hVL1l0UXJGTDA5Z1NOdlhU?=
 =?utf-8?B?NWVLb0RGTTlaSFViNXMwa3pIemR0R1JGdnQ3U0JjS01xTzlzZS81RVIxUGp0?=
 =?utf-8?B?ZXhCcGdOZjFuZ1VHK2VVeFVXSGprYmVrVE9YZE16WlVnc3NuSER6VXRKb0Ft?=
 =?utf-8?B?SWIzUFlQV1VUWGl1UnE3eTZJOWIwQUdiZ0hReEkzSklhMXRQd0pESEhmb1FS?=
 =?utf-8?B?c1ltODRWRGFlZjBEQ1RuTk9wYW1IK2E0ZlNYMGRnZkVuZUhaME1qWFFZK2Vl?=
 =?utf-8?B?a3ZCTGpab2hQWTN3SWttWit6dDE5eElLWkJzYW1heERRcVNTdEwzUU8yOVlm?=
 =?utf-8?B?eXZ3ZGJWOXhTV3M4b2dlRGNhQ0hmenVTeDYrQWJuNGhuMFNkSGNLdXU3YzlG?=
 =?utf-8?B?dWphUFRHdjlSNS91VVV5T1ovWEV5TTA2dlJNUGY1dXdnbXFtOTFBZmtTN0ZP?=
 =?utf-8?B?U0F4Z3crcUV4Yzg4N2YrS3ZrM2lSZUFYZEJxWEN6M1lZZkVtWnB6by9JWXhO?=
 =?utf-8?B?YUFoN1Y3b09CeHphQlRhV2JjNzVYUHMrYm1zV3BCMnpBQ3JxcG9zbE43UFJh?=
 =?utf-8?B?eDdCVW5JWUdrYTZQY3piWlRZSWV2TWpwQmUzS3pWeW5kSFVCTmdFM1NDa2hV?=
 =?utf-8?B?dDR1M3MyUUJuNTVKZGNXYWpOSWJGanNlb0NwNHNDU2NtM1FlMW4wdUZzbkJ3?=
 =?utf-8?B?NVZ6YjB1SU1ORGdMaGRwMjNwN3NTbkNtdUFDYm9OcGtQZVppY2VDcFNzWTBO?=
 =?utf-8?B?Skd3RE55WlRweDcxYllvS2hBNlV5WVBnNmQyZVVBK0MzR0RXZVRObmRRUTNr?=
 =?utf-8?B?MUExeThyS2xma05yWXNBdjVoWmNRd1RjZDZudWdoNDlwZEFuWUpuRCtuaURL?=
 =?utf-8?B?Y3B4OFBIVWpreDdzMlZ0YzEvR2tKWm9nSk12RE9IdEtaUzBTWkdFcWxHbXN4?=
 =?utf-8?B?cWF6UGcwOVhaZUlaMXp2SnlFZnQ4WDl4bUNzbjg5YlZhYXVJUnpIZWRBM0Jq?=
 =?utf-8?B?VVkxRVNNK2psUHBvVWQrVEdSbjRBSjY1eXlJMHM4b3hBSStCRHllVUJ1ZlRO?=
 =?utf-8?B?U0NwemlMK3ZaR3FzKzRvQW5SYm5HeEdQb1RaZFpaSVFjV2hwV0VvbE8vQ0Zj?=
 =?utf-8?B?Mm9ZbXpVc05IbkhWczFaT3p5c244MXZVZm8zaDhDMWlUa2c5WG9aQnQxcktP?=
 =?utf-8?B?eEh6UUc4MG1PSHk3WGVVMjAzZ21sU2F6MlhPWi90dTBWT2hlbkd3c3hzMWR2?=
 =?utf-8?B?ajhySGxHTFFDK25ES1FqN2xhdVFPSWU3S1MvM3FBUnRoTHc0V0JzalVLajRN?=
 =?utf-8?B?aEZUaFJPUTIxRDd3bWk2Ti9DTU9XTFlya2tWL0JGVEY4dno0RThVenhkRHV1?=
 =?utf-8?B?czlmeE80Q3BSL0U1VGdqUTZtS0xVZmF3TDhCS2orNG9pQmZKUFV3WHA2cU5X?=
 =?utf-8?B?bFd1YTEwN05wSXhEbVJ2bFVINkpabE1EWkR5NkJiYlo0VG5COWVmcmg3Zzc2?=
 =?utf-8?Q?hC+v75ixsOA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5509.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnRxMGRGOE12TGZzaEpDK2NzSUdQcFFESFI4UnlheHRSdzBmU0g4dnZLUkhW?=
 =?utf-8?B?bEdGcWl0U3F4d2hrTmhzZndrNGNPNU91QlZxYWt6YXZ6M3E5aTJYMjlBR1BY?=
 =?utf-8?B?VjJiWkk4SWVsSmh0SVhpNHNQem5PMmZ3T0R0ZHhISStzMGxoL1NEcElNQml5?=
 =?utf-8?B?enNCL3hucGhRTmhHOFZSdU5HY05taWdVKzZOQ2c3S3F0dnNPTk12dG1YYm5z?=
 =?utf-8?B?c1ptLzJ0NFpnd1ZPVFM4cUEzbHNPejhQVDk3YnBjWmVsSGFPR3ZsNDIwUDNw?=
 =?utf-8?B?NFdFZ0p4eEJQNmJLTDJUTnZNamhYUDJkV0FrLzNzOFJzSEZBTVNqVjcwWTFl?=
 =?utf-8?B?bHRqQmxoSUQ2OVJyS2JiZFg3elo2ZDNWVnFKQjRwUGg3bkloRHkzRHZNQTNr?=
 =?utf-8?B?TG1BSlJxQVM3OTU0WE81VG5IZ0FtaktJMEhPU2pXR1hUN2Qwa3dyY1NqYWdh?=
 =?utf-8?B?ZjdCVEUwQkdkbFpOMjFyZVNVdFp6UjZwZDFvWThuSFJSaHY1ODFBODVTMlNv?=
 =?utf-8?B?WC9mRGtnQ085azZxYmhJVm1qalhBZys0Rm8zcVJpSlVSRDJ5ZUlXSTB1L0Iz?=
 =?utf-8?B?UGRkQ3YvRWJHME1jZG85eUZEVGF6K2xoZEZyQVphbVlzY3pqSituQlBKUXB5?=
 =?utf-8?B?c21kd09GaXB3YmxXOS83WlVOVzNjK3Q0cnFJVERWYVlyR1padVpjRU5pZkMx?=
 =?utf-8?B?dGdEbTBMTHdOU3h5dEtVVnVDWDJzUlBpdktYK1hrdmNRUFNkS0p5em54YzNh?=
 =?utf-8?B?anpCN2hPejdKY041Y0xXZ0FJZzNXRVR5VDJWcFYxSGJWOWh1VjJMUlJHS0Jl?=
 =?utf-8?B?TGNFc2gxVmlJbWRqRzQzVHd4NHJ1TXErWWoxMDVlMEU5MTdwcUk1ak5TVHYr?=
 =?utf-8?B?TGJUZ3JFMTBldmZ6Rnluc1JjR2gwU0syTE9TQjVBai9URFZ3REwxbHF2d214?=
 =?utf-8?B?NVVlQVFSUUpvTUFZTzBBbjZkYnEyTGdVNnRhajhOekU4R0tjSUtybTdlLzNE?=
 =?utf-8?B?ZVNFS1BuU2Y1NndEUGVSWE5VTWhmdi9HcENDOEtpamFFZXpQc1U4M0wyTEZp?=
 =?utf-8?B?V2grdTlMWkVid3ZJampOY2NzTVY2T1QyRTl0Qms2TjdhWFB3NWowRXlCWS9L?=
 =?utf-8?B?cjhXaUx4WW4yRjhtVkdvQWhSY004RGxMVW9QY2JyZ0h5SGxxR1IxTGthUklh?=
 =?utf-8?B?NlRTcGZGNzFWeE9ZbHo2ZldsUTV1NGgrQmg2Y0pERU4zbWJmRlJDM1VEVjNL?=
 =?utf-8?B?dDRqaW50bllzU1hRU0wvL3Y0SEhQb0RDT0tQZEg5ZzhFUnhVTCsyL2tjRHFN?=
 =?utf-8?B?cDVQNGQ5Ri9WVUZLYVNrcmNKYm8ydkpQNVIvQ0JUTWx3SlgxcEdiZThsdXRa?=
 =?utf-8?B?UkFZclYwOHV0QW1lZks1WWFodFFra3NBcGNnTTFSTElUL09vMGZ2UjN1VTVs?=
 =?utf-8?B?WHlUdDBQOTVzOTRrNDc0QThWNE9DekZaZlRrai9IaVY5ckt2RHFSejBPYkNK?=
 =?utf-8?B?NVpDU2NlRWxOdW80dkNhNFBEaTQwNmhON0Y5TVRQdENzSzE5bEpiZ2J4OXdJ?=
 =?utf-8?B?QjlvVVBxU0hLOWc0ZEpaV0dhNTJ5ODNuWmxDR09pLzJxRWFMWDh5SXh1QnVB?=
 =?utf-8?B?UktMSW9la3ZNUlJuU0F4dVRsaXJ2Q3k4d3VxQUJFTCttTlZmcmhEYTBlVURX?=
 =?utf-8?B?elRSYSt2cWFNeFBnV202WHE5SUpPZGh3OGpQS3ZTWXZZQUJya21hV2VoVmsz?=
 =?utf-8?B?Mk5PY0pxS2toMzhaMDZXQjRldEg2M29WTHBIY0tFVHlicStSTDBBRGx5ZFgz?=
 =?utf-8?B?U1ZSSENCMzZiUzBQS1M5eEFtMisvc0VGdWwwYVhGZHVnSHVTRldZOUlBRHAw?=
 =?utf-8?B?WWphejhwZnpYQnBZb05pcVdGcHRCeTZLbGY5Mm1oUHRnbHJmS3ROeXpsWC9m?=
 =?utf-8?B?YVhBRVIweXdxMGFwdk1RRExsMW9oWXN5VWtrbnhvY3NHMTFSeENVMVJoWExX?=
 =?utf-8?B?d0JoRkJoR1hqWVYwV2ZXZTZXeHg5cm5TSzUwNWdsV3UxK3pjaWt5Z0ZZa0NP?=
 =?utf-8?B?bjFkeGZFeFFTVS9zc09hYU1oSlZWNHpxWFFneTNSRlJqU0tTVDRjV1k0dlVJ?=
 =?utf-8?Q?Q8GCRkK3fsr10AfjeHtDfnIhc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A4YDLwIU6TiiS8akjoznvHnwpACB8MGMKytzRm0G3mToCO0rbaLRBdH3wopYjE5++g/t7KNkUt6U3uSpJTMBCDeqsOSTZpf9EdmxQUm0HaoUz1hiRW7i6hQbTAAUVgiRvezQErc6HkCbP7E9kJe+0LrfIiw+KQ3DdTIelwBKtbxSLPiEHfVMQxEYnbBkMHW/+5YMEb5XaTLfs94ycaeDy65QJiIwpPhaznrKda59vkHAfH0Pd+7N/umHqzV6cq0WcfQVUM1Vrf7eTejzSLtsqWyYFtBWsnPZ41wSXO76B70GGQBaM8VJiZBiUUpFuX0cz3zoAKv0eHEHG3adq+Df2saFgbkax7rwxLx/3MD01MKpWzXAStTARhfxQTQJ8dZJ7JUjb0M4gYHgwHrvUoqpv8ZxmZAw/XK7c5rZauTdgyjdYceldKV9WLIF/wUKcBxFdqM952VEOPoWVuRgucMzOdSRQ/NbzfEu6LlSD9lQ1XWSBHq5tE3fPM58TtzVlRSskpoUQ4YKnEn9Ux4XW/ywba3YTd5QO5wboyvX1bNcAmSak+E8LPTM0Yo+6zlNFQnubEcB1kFM5y+MDISUyf8xUSaOZ3BxN+6gR7gO9koR1SY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936ab29f-cdd9-438b-3242-08ddebde59bf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5509.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 18:10:38.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVdRx0ti9ksMU1mOoHzjRmv37eff3EUyZhfPy2+g7PAWuDsqJlKr4XIewt+W3KHEyLtcz1ggvvMNvyLu+gVcKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040179
X-Authority-Analysis: v=2.4 cv=J/+q7BnS c=1 sm=1 tr=0 ts=68b9d622 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=3L3tFbXyUU9PfQ9DC0MA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE3OCBTYWx0ZWRfX7bavI7/j+HSo
 hz57D0tAMbqP1tH2YgX4AE9QOYU+TCja/fg4w+CdguL47rz4ePuDxEL2cxAiptqir1RvqAmjFps
 jQpqfGWVP4t3b3kM+Niu3nyFh7NsvoUJSsvdR63SzATrL90Ff9Mfs0J4N7bk4+jZTd9MKfhPiIp
 VDPukCPBH0hW61hbKE4ey2uRjsaEzYNLzYvuN8y92tJUpYn2Q/1aPXZ9fquB9ZOWnm/QpChShKG
 OzqO5t1ftbRK9Wj0YeEvl4NxsuqY7fI1qEbGW/LopPG933bmQxzaonE14aSZtdb+s8+b9bh1Rrp
 xEV0Mm9tDCpPglZSDN4nfshDpXnkpwFVY9xtXVhsMxB1wYd6wzYyMQLlmo6rmfTgsJP9cnaZAl3
 HTzgOrACojfy+K3+O9GEA8WxylBHuQ==
X-Proofpoint-GUID: hUkwOhsPu-VXaa3hMwVfw_f77CTJvgFB
X-Proofpoint-ORIG-GUID: hUkwOhsPu-VXaa3hMwVfw_f77CTJvgFB

On 9/4/25 8:54 AM, Al Viro wrote:
> On Thu, Sep 04, 2025 at 08:26:30AM -0600, Tom Hromatka wrote:
> 
>> This snippet addresses the double irq issue.  I also added a
>> check to make sure that task != current.  (A user shouldn't
>> do that but who knows what they'll actually do.)
>>
>>          if (task == current) {
>>                  put_task_struct(task);
>>                  return -EINVAL;
>>          }
>>
>>          spin_lock_irq(&current->sighand->siglock);
>>          spin_lock(&task->sighand->siglock);
> 
> What do you expect to happen if two tasks do that to each other
> at the same time? 

As written, they'll deadlock sooner or later :(.

But that should be easy to fix by adding two checks prior to
grabbing locks:
1.  Check that the source has 1 or more seccomp filters
2.  Check that the target has 0 seccomp filters.

This would ensure that for the same two processes, there's
only one way the locks could be grabbed.


> Or, for that matter, if task has been spawned
> by current with CLONE_VM | CLONE_SIGHAND?

Don't know right off hand.  I'll look into it.

Thanks for the help!

Tom

