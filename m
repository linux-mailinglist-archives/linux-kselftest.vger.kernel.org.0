Return-Path: <linux-kselftest+bounces-34923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2132BAD92CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 18:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874153B995D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F520DD63;
	Fri, 13 Jun 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QbrzRq2a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CTSLpCSA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDDB20C487;
	Fri, 13 Jun 2025 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832114; cv=fail; b=OJjZekxuUvPgpAKe8jwK8Pdgbgpl4964L2vz77cdsDw15usaOscb6L38nRot0yewN2mEmyOkgKXc6+h4yQb3LMHjcxVZW1xspRWppPVp1ONmR9m3fRNt7sxpLvPLmCne9uZ9Vpkrq5oj6ci3ioFLo3PcFlwzygsvh3lc5H6mw0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832114; c=relaxed/simple;
	bh=IOP/BoO4lOzRfgI2tqUAKzUc/+/0GzvkfRUUrCS9JqA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jMe83DdfBmsYJ0uT5X54t43DK1CMXJZ26RNlvpGncLJxXmHtJltS5bzGNM0GRLye05+YYxrDIAVHMOMI61gJLnolxEv1CuwwfclYF/d0yFDY13Wd0qvuwEvrmA/fpeuR21roVO0KSkMe7X3+mNu2PvrzoCGbPqlVXoN4FWkCiAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QbrzRq2a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CTSLpCSA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtbc4032625;
	Fri, 13 Jun 2025 16:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PQZM0nk/r8YNiXKVeT8f6bTmaGVllYldgECxHCNhBBM=; b=
	QbrzRq2aBqvT7UgUaUXklAwrikbe2oi63hhXiLcBDZMAPoTS4aqmCahhgU3Ab15P
	FUANOud9+m3iuDLzI7rC9uEbI9092Dckn03adOw7JKxk1wi6XDDYP9+QelT5p9nc
	OyCxAz0ZqCVOxa7k7KyGFKhX4VhqA911ilIazZ3M46MuXeAJ7q/gEXHEy5CNeC6B
	zhdb2ftNQM0xQ8GF7pQxk16YqB7wnL4SL8sYBoh2FAS0TK0Fd9A4/BLMp2MkdCo1
	7TZSwKO/+LtP0mTjuqYnZVcxXDmwi4d5xP7rsxa8yBSRzx3iKR+Rbjy1W9bSeH+3
	NNQcQgl23f48XRL1VAuz2g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1vbx1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 16:28:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DFSHcg040772;
	Fri, 13 Jun 2025 16:27:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bve3jta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 16:27:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUOgsTg92EZRI2ry383xW1xXhK1k59caNwhnRI9QTm5fcEDDwkx9v5xVa9QOb9Di6a4d2qbbBxTZ3XUCYT+wf8XDtdKFKU/2hoHBRnGkHhJQNbduqskWctBnTgN4b/3Nmr43t2Tw8WkIn17GhXiC89xt6cvc2woWCPfyDlmWQa2qDbsJWhDAeGohOvyDcQiDGfB9giUXy6axDudNr1D7ULeNdc4/5Vry93ozcTJZW0o0YZlyemG5623eXm466NAS4VxBJNiK0GKK+/GotZqFFOigQjE68fMN/f4P5rfPtRLPr2Y7T/URID1+sCgILnfc0WO9NtSYaTZ/3vyyoKgtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQZM0nk/r8YNiXKVeT8f6bTmaGVllYldgECxHCNhBBM=;
 b=em9ykBvUnhoVBDEapNkvd+Cqp/thZg9xNY9I+BmDd8EPOaUN4GQFlQQNs4XIdAxVemyQR3nW1d7x+zLxvPW6XCHYFnoEH4Or7r2MaKs9cLODFNTPcXC3c/Xr7CRueHtKmhAsUkP74P9aAFfxz630QqyKbZ2rO/f0S9UPDLIlOf1ufijd26LG96djh8/dfSsxJippkwfS6ckikazLLR31TnBlx7ceATu+1HE8OFZa04dSPOpTwTHY2FiuwIyKxCpO1lyLUJUfeKK9oHBEnN/AcMDxwZqcBBR+5gdX0+eWjiZoD3ZL07c4M/CqX90Qe1POlpZWKwp9D0nS9b+PSaeukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQZM0nk/r8YNiXKVeT8f6bTmaGVllYldgECxHCNhBBM=;
 b=CTSLpCSAMb0bZrlfShyz0YpLAWzyePSlJyuQb9ns1o/Irci1EuYvHbiPELV2enjbmureetTguTzH19ha1QQVCFTRs4lNsYTClhY7tqRvfj3BAh6OHsGJSZ+6WN1e89sNE1k3F4BMDqTBhFttoPwug2GmtTX99TvjfJ/3nlxGy1g=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 16:27:56 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 16:27:56 +0000
Message-ID: <f9cf4cca-8e21-4de4-a5ab-c696f40ef385@oracle.com>
Date: Fri, 13 Jun 2025 21:57:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 net-next 1/5] sched: Struct definition and parsing of
 dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
        donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
        dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com,
        kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        andrew+netdev@lunn.ch, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250613153725.7983-1-chia-yu.chang@nokia-bell-labs.com>
 <20250613153725.7983-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250613153725.7983-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: c4204af5-1ab7-414f-b61c-08ddaa9740f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmtKSVBXeHJTY3FDeUV6TG11Y3ZZYWJGNXcrNmxGVDlHOUVidnZPcUdJVVZZ?=
 =?utf-8?B?dXFaVTJuQ0E0Z0RqQituNTJPTmNKQ2pDaU9EUkRqaEhlMTVqRFRJcE5mOERG?=
 =?utf-8?B?T3NOeHVFcFozdHRFWmhDRGxhR25SaE0yaFpwRkRFV2I3M2xpYUJPejRaTHpY?=
 =?utf-8?B?MXZqMmsydU5kTGJxZXBKcWhoOHBQU0JMQXpiVlNPbW9BM1ZpbTJqYWJhcnVN?=
 =?utf-8?B?ZFg1bDlqUWVsS2VsSkRqWnE4cnBaSURxNysvd2E2KzljTDV2Q2F0b1pZNThW?=
 =?utf-8?B?b3Z1bDBRMzgzSG53MHVpVnc2NHdLVlRxWmpHRlZrRStJMU1EZnk3N2dzVzlB?=
 =?utf-8?B?MjU2TWhWeEpkUURHQmdXcFZrZDFHSGlIUmFZL05MZkNOZlVYN0c1ZThIYmJt?=
 =?utf-8?B?SlEzYXVGditna2RlY1YrRjJIOURHZHVRWjBtaXIwckZNOWlGTm8wQ3pUSGgw?=
 =?utf-8?B?SnlpUFpBVVJRbXlna2pSS2c3bDQ3UDc4cEZJY3A0Qk1ZSUZaUE8yMC92NkVm?=
 =?utf-8?B?M2grTjZxaFM4b1JXQmxVakRjYmVnYVdqWmFjUGd6SEdQcDVuaEFzM3JkL3Ju?=
 =?utf-8?B?UGxMWlZ1c1ltem1ZaFo2VmhYeWlJNUVlemgvRFpBeTRTSmhTYkJIS3lEUTZL?=
 =?utf-8?B?NDgwdlhiMVBvcGlDWXBOVlViY2t0M3pndHdsV2NYd2ZEWDZrTlRiU2pjdFds?=
 =?utf-8?B?WVJNRWhGdnlPMzdrU0g2cG9ZVDBiV2VjbkhNMlVaSjUvdk4vQkNhdWpCaE9n?=
 =?utf-8?B?VStnY1F6NFNwSHR4R3JjNll5Ui9zZDJWejZxWE5tMUtXWldlTE9JL3RWZGt1?=
 =?utf-8?B?K3l6YXF4WmtwdHA0TUR5OXJrLzdlZzNTRHhvbmVMeHVmK3p3WGQ3NVhSMmxs?=
 =?utf-8?B?WU5BRFRReW9GTU5DUGxCMk1oZFZhM0lKVzJrTHJ3K3pBZm4vWVlHY0tzWGZE?=
 =?utf-8?B?VzZhb05RejB5a3RDaktURjhNOWxDcGovTjhYSTdlcFZpZ0V3UWMyYkJPS240?=
 =?utf-8?B?TDRBcVdkUnJyMTJkaFZaM0lEK1NicXZRMi85amFyWlYzdHVMNE1TeDcrT25O?=
 =?utf-8?B?bTZsK3lVejU0SytiWVJFMDRaQXNiWmhJNlN0ZWZ0bXBrSGpLcS9GbUIrM2xK?=
 =?utf-8?B?U0VpRmhCYVpxTjBHcnJXa0Fsbm9LQXdWL3h6cnNGTFlqb0lkUytZS2U3K2FQ?=
 =?utf-8?B?Ly9Xczc4cmo5VkUrc1hFVzBBcE0xR1RqblppQkUyaXNvbE1scEJiVENQWm5i?=
 =?utf-8?B?TmlpWkZaUTZOQ1E5ZCtYaUpHOXljYkhXeXhPTzJoK1NsclJoRmVrajdLSllL?=
 =?utf-8?B?WjVqZ0hDNUJRKzVFdExVdW5rQTQyRk1LdlJsNGo1Y2tPdytTdmIvbGlCSE9h?=
 =?utf-8?B?TFpHT2dLMmZkb3UwQUFtSkdSLzZZbXdlWUhjK1ZXSGxBdmpQNlZVVmgwNEQ1?=
 =?utf-8?B?aEVjM2ZWOGZ1WGdtYXN2eU9KOHlOVEQ0YXk5UG5FbHZLek0vNEtPUVljTmg4?=
 =?utf-8?B?NlRNWUo2cGRac2QrNU5RV0J0TmJpU0J0Qi83SGVCTTBGZWlBR2RadFNxMmdr?=
 =?utf-8?B?RngyS2hNenJLbUxZYm1McGwwUGdZWUJqeFpDeFpRMkRFQjhDYXl0dzZ4TFVl?=
 =?utf-8?B?cy9FYkpvaHpGU0MvMzU1ZDdWSGROZjZRUnE3T1lOaXhhMVB5Y3BKNWo2b1ZO?=
 =?utf-8?B?dCtDNlhlbDB4cm5RbjlBUFNXT25OU1Fjdmp0QWNFMm83bjJCdG9kZHJRVGdE?=
 =?utf-8?B?bXdUM3lmNlJkWXBFSHhwTmhMYzdzUVp3L2RNdVJBVFZIa3FMMUJUSUtLR3dD?=
 =?utf-8?B?WDExb3RIeTdNUU9EK0tPS25IeGZ4K1B6ZVh5MEgxMS9RQkFIV2s2WEdmb08w?=
 =?utf-8?B?ZjhaUC9Ua2h3Q21ndVRaWEpCMlJvT2pBam44RHo5MlcrQWc3U0dGL0YyNUNz?=
 =?utf-8?B?M2dxRkNMMUprUDB1dW1QZ2lzd1BQRjRKSWcyWXZxMWlyeFZwYUpwZksvcndj?=
 =?utf-8?B?ZjFndUlsdkNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1FzTTNZamp2Tk5DeGxXTEJBelh1a0ZSSkRaQzdPazFUU0NXdFc2ZmpMbTNw?=
 =?utf-8?B?U1hJVHoxSkh2ZXRYbHdKM3RpQzVMSHFyc202UjUvTnM0UThia2ZlNDJzd0Y4?=
 =?utf-8?B?bkFCRGxxcjI3NE9UOGd2MVZGSTZSOGFtREljbWlKTk1vQjBjZDliSWRIblcy?=
 =?utf-8?B?Y0NFSGYvM2syL2E3a0VTYnJDQU1XaXhaekM4b3Qrc3BEeGlybTNSay9INnNG?=
 =?utf-8?B?eUNkSmJBSFU1dlV4ejZsMCsvbThJRmZWa09lalB4OGpUcG13WldJUnM3d2h0?=
 =?utf-8?B?MGlFWS9ESTV3MW1tRU0yOXRWTk85NUZMOGp1aG82WURiSUdleXUwQ24rdUdF?=
 =?utf-8?B?MkM4SDdJb3FrWXRHdDVvNjRGVWVhUTY2a1JSTHBlc1VsWlQ5MXJTUk1zQjFW?=
 =?utf-8?B?ZlFSb1p2ODA4TjgxNDBOUUw3RkV1bjkxVmpyazBuUDBGR2l0UW5aQ1QyNVlP?=
 =?utf-8?B?eTVMV1VKR3dSS2JkQ05Jc3MrbEc2Zk16cXIyVHpESVhMSnhoN2pyNjNCUzhl?=
 =?utf-8?B?N2pjZmUyZDRhM3l6UUgxWTFoeEZPTzRMOW00VDNCTVJaWkMzb2RyeTMwQk8y?=
 =?utf-8?B?MjRoMTgyWFlVQ28yWThaaWxJZXNrWHVQUTdUb2ZoUkhlK00xbElkOGJ4WW9J?=
 =?utf-8?B?bGgvcU9XZDBIODd2SUVJU3hRYlcrREJIVXQ3Y1Q3L0owNkM1ekt0N1RYYWs4?=
 =?utf-8?B?SE5sYlJGWnRqYWxOclc0bkdETSthZzdGVUx6MzhKN0NtMk9PY1BsUGxjakc3?=
 =?utf-8?B?Mk1LWUVZa2hNRjR4WXNmTTBoNDlJSHFCTVJsY2FPSk56eCtXSjdHTFVtcVFF?=
 =?utf-8?B?UVlqMU9RMk1JUnJ6eVp2SVhmUGlzWi9kQVRieGZ1OWNNQzB2UnlOR3ovTE1i?=
 =?utf-8?B?dWZ4MjI1dGJpTUZDdHRvei9xNUVNTHRHZkxvTzFzMnRSakczWnVibkxrQlln?=
 =?utf-8?B?ajkrZTBOeG91UTRDNUVzMDZ1dW9sS0xQRUxvekxJbDJ5alVSRW1Zb1FCYVdC?=
 =?utf-8?B?TmMrbXo4VjE5M0xWMmV2OExLckh0eXc0VkxUbUdiNGFEUHNnN3QwcHNWRFVO?=
 =?utf-8?B?TEZtY0pUdHgzMktvaGhsTEdnTTdzbDlpMHNMYjhjMTJTbWVqOE1Xd0FMckJT?=
 =?utf-8?B?TnJmYm80TlNDbTc1Nm5FZXQ3WVZsbFI4UGlCeFlmbVFHNUlJRDRXZU5CSmJn?=
 =?utf-8?B?NWFXUVlMVlNNRzNvUGN5cW43eEJCd0JVZzdKRWZmVEw0VEd6UFkyTFc2aTQ5?=
 =?utf-8?B?YmV5WjFad3lYaFA2bUY5c3JVTkZwQ09wNk1qUUJldyswaWZDeGhXTXo3eklq?=
 =?utf-8?B?YVVkc2szWmZSSnhCQWNSUHNCdElobm5xd2o0SjR0V1NXWWFXQWI0ZytodGVI?=
 =?utf-8?B?dktVZmxvWVFrYzVHTlZmeGxPOVY0ZFFLZUpTT1VTNyt3WGM4MEovSUxMUUlD?=
 =?utf-8?B?S1hxbzNlUVhzK3hmbUVRaytMdlhOQjhqL2Yxb01DR2FYazd4Q0owbzROV1Jt?=
 =?utf-8?B?TkVZcmJ0aXVLaEJCak1vTTRLWHd5QnZpZlp6MFdpM3BhMjF3Z2VzTnRDTDlv?=
 =?utf-8?B?c2U1aEswcDY2K2NaM1dBdVp0eUJqTGx5K1BLbDUvVG8yS1BXVnhiTTI1cDBN?=
 =?utf-8?B?MmVHZytsYlpEQjVlbFFrYzR3akpOdTRXMC9xK29mc1FjTEhjV2UvcmZUMW84?=
 =?utf-8?B?bzJIT0tEaVZ1blZUM25aSjNkQ0NpZTJrSVRPNVlWaklra1FTUXp3K0E5Q1RT?=
 =?utf-8?B?SXpvNWsvclJJaytuSlJ0YjlZVVB1TmlUbG1US25RV01zek5IZ0YvNHY5TW93?=
 =?utf-8?B?TWhqWXk0eUFUTTZvc3YwTURHaC9MdktSbXNmZStqM0RGbXhySG9ENUw5c0Ir?=
 =?utf-8?B?Nmg3dkRKL3BtcGUvYkdWbFVMWGo5WkM1STJoRHBjWm1nS08ySDVsS2k1SU1u?=
 =?utf-8?B?KzVvVnFGeWRGUzJYYWd4aDdFdUVkekhVeFZpSEdYR0oyZzhFUmNvR0xFcDJL?=
 =?utf-8?B?eGhZVjUzZUNSbTQwck05c21GMHhUeFlUMlFkM051NSt3cGcwOWtPZnBsOHAz?=
 =?utf-8?B?WHIzVXVleUNMaThFVmR4K2RzK0pjUkJBMHFiaW1IQ28xaVhLWkl6bU5QSHdl?=
 =?utf-8?Q?vRfJ12zCADv03MUxk1f+5PMO+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	omMq675yq+fC4DozMaknpa+13GSeLTLVkfs3av/JDOj5Vs8i8y9kZaHO19PhH01H5y/EcN48dUMrnIvBN+kRqqQlsCQ2z3kx4SXxNf6+5nlOdv+0Kg9pe7GSU69QKD5Jq+IUexUET5o+zPhlKNCaSoY4hjYJjBb5hneT6jPqjvw/alu6ZP06dnEzYYvYIeleDi0oGpgqzCerWBAliPeAUG7ew045dSKceM8aQCaiqda+3KFEV/a9dCRWc/A21sSdo3u4s+CB8tXQ7bv/4sHBtvWX/ywUKUDDF55Uavwf7btPN8EFJq48qaSXgDEDVwA3pzAnbGpWl9pf2JRCpmFa8o8Qj7mHbnc9X2OYcnH3bFoGUElbu+s5evDl3Uoj3Xq45woC7elLE9Uo+3GXOk47QtC+agcNLLiaj2TglSkS9D3nDVxtSeu0x/mKa6t4RVLltMRMECZKQ05IgP6lsFyrOa7mq/Wl8lpSMoXTA3QAtZNoo2YK05OJmCi9WRH330bBzqFnb1Jmx8ELZKRTzU7n4UzVjNA22bqNIz4t+flL6e5Fsk9Ubon/4v/u49PNjXwn21knUboyEQaV/yf+MNRspaH02MO0HpazUiQicQD25tU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4204af5-1ab7-414f-b61c-08ddaa9740f0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 16:27:56.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cgFzee3vvMSUI4zFZSqJod/pyOnWfjJeVa43+RNtitSjlWZKsqEF5lTGnRwne7bSEgd1RKJpVOdZqhmACAjBfD42v+k+8uF7WJU2GhJ9v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130120
X-Proofpoint-GUID: yyXqEpDwR__GRvS7x7pHtrf2TgOTdZES
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEyMCBTYWx0ZWRfXzkD0W35gVtZ2 BjemA3AH7eQe/W/EgwUYksTljQY6YKb4w2/Ii7i7t1b5/IXmVT3jLRnmg5BK+EtnCvWfE4mUmlg wv0rKP5xZMFKi3g1IHsWoVp3ePkAW3bSda8kIJyeeHVG2IzJKD++9zBW3k7z0hzrpuDuZ1KNKjy
 kxfG+sEHlX7IGWHquIBpe/wONSRFWxWfsnrzXkpCIRosr36QdHjK2+bprqiv9WkutvYU/26cGz1 A7GHsfGkNoF9GJaJdUT+OIV9aItVXQA14KLZvUuK2PkIhilqPnYEgE9F7gX5COMVaAeKQja+XWo nWiLyN2cTkrdyZEP19DBBpssqSSRYFAIMJu1Rw2gE+b4FXz6BFHOEvsQfUSHHO3aGx5fwXxxGV9
 3ajxfbdQLOm2ElBSgh1WOBSbHh5KvUvW7BRdHTFa4WV1/bdc6fxBu5lypC6yfSac6qCSAh24
X-Proofpoint-ORIG-GUID: yyXqEpDwR__GRvS7x7pHtrf2TgOTdZES
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684c5190 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Dvkn-I7JYEjOimFE3-QA:9 a=QEXdDO2ut3YA:10

> +static void dualpi2_walk(struct Qdisc *sch, struct qdisc_walker *arg)
> +{
> +	unsigned int i;
> +
> +	if (arg->stop)
> +		return;
> +
> +	/* We statically define only 2 queues */
> +	for (i = 0; i < 2; i++) {
> +		if (arg->count < arg->skip) {
> +			arg->count++;
> +			continue;
> +		}
> +		if (arg->fn(sch, i + 1, arg) < 0) {
> +			arg->stop = 1;
> +			break;
> +		}
> +		arg->count++;
> +	}
> +}
> +
> +/* Minimal class support to handler tc filters */

handler -> handle

> +static const struct Qdisc_class_ops dualpi2_class_ops = {
> +	.leaf		= dualpi2_leaf,
> +	.find		= dualpi2_find,
> +	.tcf_block	= dualpi2_tcf_block,
> +	.bind_tcf	= dualpi2_bind,
> +	.unbind_tcf	= dualpi2_unbind,
> +	.walk		= dualpi2_walk,
> +};


Thanks,
Alok

