Return-Path: <linux-kselftest+bounces-27343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B619A41E9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 13:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F7F17763C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6021931A;
	Mon, 24 Feb 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WYYUaLo1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sTR++xys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8E1A0BCD;
	Mon, 24 Feb 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399025; cv=fail; b=FGoYm0LBaPdOw/2BlM1qdKe1YzHrGIwg8ZhYDvmxvZLic10+BG6XWCOXcRPLdUdcpKkaSQEZireY0N3N9SixsKEp2M9NghjdfhN/eIOggJfGYEZ81vM17R6X3gJ1qxqEePRgB0l0xjt580CSdwbrBATdnsVi5roA2aozkXVw3js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399025; c=relaxed/simple;
	bh=DQry48JNRzGZXn31ohO4p09kGSreU7fxNbYZ+l7Lu1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r3K4zjp/u9dwR/jgUkB1+O+gHsJcZKYgPLLtNqYKFd7KF+C81K5TIlHlxuUZiN28s3sdTvYBN/2LDYhmf1Crj52Hd3UpxdEbJIAFmgx4jwfaxLForvl3XVEC1PywGEts4A4L1hQdL629sHjIsirCsrMfmAq9EFjXoqzyLs8R3rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WYYUaLo1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sTR++xys; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMnG4017683;
	Mon, 24 Feb 2025 12:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mHjO5xBVvzXsV9u5FsIDwRwgjCD5Qc564wEAJFcGEk8=; b=
	WYYUaLo13Qn0r7lIHT8ix5FjqPUvYk1X1vvSkoCYyNv8ZOI3R5pkoujmLWaasbgv
	2KTYvygn5mWdrlrs4KH8WUEPeOKNcw6MDmmm8GCXkw6zUGK2JaqmOFdCRGQ1hGLi
	U9+/T0WZaoCEpZJi2fJM5T8fj1u+wDrivsWaxKtXDkyDSqFGBN4jGl/KqXLzCPaY
	7Yz6+lzit4kP9Uokn0bFXZBjBe1eM15hnQZhEGCug/6wxPL81s5N5WSXZVWPs/6E
	Ql7phhiDjUa4L3KMBI6Aq6x7lyA+tUeT20imn9CjUOZ2Bk3UEI9+BcRR9Ows8Jxv
	N+NDhsfEeZphKsRnzk96hQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5602dwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:10:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OATWuL024523;
	Mon, 24 Feb 2025 12:10:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y517j8uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:10:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yvqqkxjn4UcjcTt64J8IAA2usQ2JzcnGRWqvjbMYv1NxrL8qC7rlu8Eim15zSRn6ci1Pt6UOUXNfki8I+R94dGT8vL+eTJxUPyHUIVn6aLQssXmwEqVc/gyIoYeG7tep3pWvKEJrzZp+fqjr4V5KLLPewQxstCdnthLMWYiuJuFTIx6dfxDrepp3DxXdZX2xXHb1Xg+n2zEjP9gveus08nS6PQA5K+G8E201ba/xmkkLdNK8r3Ou8K9QxuKDQBCGknAkxFHlSiOOO8dd9OpU3ugbfU6TdvwUPjOq7re84RT8grNI/qVwFo6YeZfHp8QBgE596EQqT2JJxUpGhHXuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHjO5xBVvzXsV9u5FsIDwRwgjCD5Qc564wEAJFcGEk8=;
 b=jpFU82VHsMMs9qnOV+vfd2dP6HtpduF/FQhMDVQYiuT9QkMs27miMBeDrWtmcV8Y5dj+H/r5Scj+5mJH5AuSMu/W3Y5s0JJR6WdfA7q7X5Alk6qScGGPInVnlPI4OXV9EE4syUIsM59ZQ8JO50/nU86H/C8FP/m+J6B7ZPYOSye+j8DRUH33d3tvreQiuCupo47mfLFFNsXPi41zL/Yz6bjPZBQX5w3sC/p3cA9rnPiCiaqwVCwYRdjMfYKEjwkBO3J2UeasgUfHm/46zPc0nvUYV8fRn1UBRNRKwnWLh8Owo3t+O8ANeenTY2YBdh+AIwjq9/7B9Lfful2O8A15xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHjO5xBVvzXsV9u5FsIDwRwgjCD5Qc564wEAJFcGEk8=;
 b=sTR++xys4fIdAVBjVeYzKkP/n3PbgsUoQB0iUYxcqIrkcXnqBcHGoS9byBfj5RoE7gYFmtl1xwr8TzJiCL0ECrtJuloJQdxns5f2/1sRouHqPWUJ7+5Bd6QhACp4QcmUxllWJz7Z2NXvlg9LGJP/caK+VTOZW6Dhd9jxA5d0U8M=
Received: from CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22)
 by SA1PR10MB7682.namprd10.prod.outlook.com (2603:10b6:806:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:10:10 +0000
Received: from CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e]) by CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:10:10 +0000
Message-ID: <c5f8d593-e667-4b39-936b-21c5d92f7016@oracle.com>
Date: Mon, 24 Feb 2025 17:40:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests: sched: skip cs_prctl_test for systems
 with core scheduling disabled
To: Shrikanth Hegde <sshegde@linux.ibm.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.hyser@oracle.com
References: <20250221115750.631990-1-sinadin.shan@oracle.com>
 <20250221115750.631990-3-sinadin.shan@oracle.com>
 <ed7386c2-50f9-4fa0-8a94-fd67ae2bba4f@linux.ibm.com>
Content-Language: en-US
From: Sinadin Shan <sinadin.shan@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ed7386c2-50f9-4fa0-8a94-fd67ae2bba4f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To CH3PR10MB7211.namprd10.prod.outlook.com
 (2603:10b6:610:125::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7211:EE_|SA1PR10MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: f063c945-4d4e-44be-1a99-08dd54cc2f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emUzcXFsM2ZyeGlwUkp0ZXQ0SXRJQTIyUWZmZzBJZmQrQ0I0ZkQyaW5Wdzcy?=
 =?utf-8?B?VStwcVNjRVhGeDM3NVo3dHRGS3hIUlBEMU9BdDRDYktvYytQblJac01aNzdN?=
 =?utf-8?B?bmw2WFB3OHE2ZDRQallDVnAraVEwRitSMjl4VUUvSkJlbTE4WmJFdHpmUUcz?=
 =?utf-8?B?T3NZWTl3T0Z2WGpxdXM2VUFybkI2MkVjNkFVOEZYVCt3ZWVXem5xbUJtek1N?=
 =?utf-8?B?MnUxaDlJbXRuWEljNUJzeExVYjNITW1hV2lZampyK3JJeU9YdXpBTEVZNnVs?=
 =?utf-8?B?dXVYN2lYVGpMQnlnWm1GWTBJZFpYWEZDTVdUSFlMVEp2Sk1EN3lrODhnVjcw?=
 =?utf-8?B?TkRDd2h6MWRSOVNkSHRPdGZvSjVjZFVYalBtZXEwd1JvZGJUL2dkd0puK210?=
 =?utf-8?B?SWRkZ3BFVnU4MEJITDRyS0tyNjNQKzc3YlVhci85UDkzK2RwUXQ3K2JWbmJ2?=
 =?utf-8?B?NXltZE5nVkFqVXhXRGhlaUJrbXlBTmpja3JFS0t0MjRLN095eWs4N0RyYnJB?=
 =?utf-8?B?L3ZVVFRvRE5FTVV4M0tud05yTlI0ZnppTllrd0p4WDhIZms0TnB4YlRVTTRG?=
 =?utf-8?B?SkQ4a29tVUJKTGc3M0xnTm5vNWhmekhwRVBXYWpVTmtqdytHdThXQ2tZTzBP?=
 =?utf-8?B?aEZjczFGSTgzRDdnMGJnOTNGTkxkSExYRWx1UTFibS83NEQ4S2pKcVdvUFlt?=
 =?utf-8?B?aTRmRWNPVzRsOG1tMXBIT2hzL1ZRc29TaHpoSHljQzRUa0J6dkxEQW1IcCtZ?=
 =?utf-8?B?S1BYSjR6ZDhnbXI5SFZRUFJMazRnRE9GMVVtSTM4dWJSYzg5bXVSVDMzTUNn?=
 =?utf-8?B?ZTU2SVRJY1Z4czFyQTZ5bWZOMTMyalRFVzVld0RJZTFiREJ6clowR1MyVjFn?=
 =?utf-8?B?VDFBM0VWdVlyRDZja1dOaDFpTEZkRWFDY1JYVHlGOGVrOGR3bWNYYklFVThn?=
 =?utf-8?B?dityMk8vbjJoY3R3OG5nWXhhTktLS3JTR1RCKzdOUTNoK2JXYXE3QSszTmQ5?=
 =?utf-8?B?ZlFKcC9jMCt1Yzh2L3VCNGdOODdPZDErMGFwUFhzMlRhckt2Rm10SGQxamNW?=
 =?utf-8?B?Y1VhQXQxbk9lNER5WS9oQzJzZUVmdVlkWGJRbW0rNndRR3dCQUEyeTN5emN0?=
 =?utf-8?B?R0RvWVY5WWxZNEsxRUJ5dWpjM0lldDhZMmEzRGlSUFZmcDNIUFhueFIrL05N?=
 =?utf-8?B?YlZXcUN1MzE1R0U0a0FNTWFDWGE2KzlFU1VQL1BmZ05ML3FhSVZ2NmloUHlx?=
 =?utf-8?B?ZFpsbXBQV2NYcGNPSzh2eVBldHFrTnF6SWhaTENiVDN6c2kyY3MyUzFPZDR0?=
 =?utf-8?B?bWVCQUJIRSswTnNSTjFIMks1SHdqRGFNSGpyQkkxV08vOGdqdzlKOEQya0Vn?=
 =?utf-8?B?WnRzYkZZMTBkZlpXYThxSEdIaXVxUUcxM3lWN1RrNnA3YXZhbGhUYVJIMk5H?=
 =?utf-8?B?dVI3MTEvV2hZekJJODVidlRxUTFwNkJ5SmFvcUNJL3Fld1ZuTFZ0QnlGc3Bk?=
 =?utf-8?B?UEtYY2RvWjZ0b1FPQmUrT09NRXZTbklsdjdXcTRFaTlTMUw5dm1TamdsVkJW?=
 =?utf-8?B?M3BUeThrcUhYTktPL1pnZjRsSmVQRkJYTVJZQXJTVnZGRERraTJIQmNadllD?=
 =?utf-8?B?enpJQ0VlQm4xRTZZVDljY3o5VUdzS0pPWE1KajBWeWZSL3ZsVll1bm83TGlu?=
 =?utf-8?B?NjBkbDZGRlJqN1Z6VFEzZHNXZm14SUIrK1RxMWwra1dOdWUwRDJKRStQTFhO?=
 =?utf-8?B?RDdMek5xcjliOW8yNktSMElNdkZJQVB5blBXOGJWZWxMOSsvbWgvVmJ5Sno2?=
 =?utf-8?B?LzhTUHZ4cytpQTFxSTloRDY1ak5WaWVOQU9HcHlpc2ZDaXh3OURkYVQxaWZi?=
 =?utf-8?Q?+3xzP6zDdt4ut?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7211.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUZSTmYrUU1TQUVXak9Qb0NRM3N3eHcxOTdNbnBYYTRSYmdSWmNKa2lxdk90?=
 =?utf-8?B?QlVFTVhCMHVmTHNvNlJ2TzQ4NnduamFMZ3M0bFR6QjhuL1FrbkIraWJLRkNr?=
 =?utf-8?B?L0FaSlhCNUt3VW1LcXlNSWM4T3VJbndNRlhDZ284NDdqc29oSjZ1UFFSaUY2?=
 =?utf-8?B?Tms3MjNwU3ZDbEdFQkkrZUF4cVVRSU1XYm5kMWZFa1B5dkRMbEFhdEs0L0da?=
 =?utf-8?B?THNEbzV6bXV4MG52VkZ0d1VXNUo5ZW9ZUFY5UDQxL2ltMi9oOTNWZ0pnbGdE?=
 =?utf-8?B?MG5nMHZXRVVjU2xCV2tmaktCZ1NZRnlkVjcwNGpZaEVaRlVWN2tWakpOZVVv?=
 =?utf-8?B?YjZGdVliUlNNdGhwWDArYytOTUJaVXRrelJ5b2NYdGVJT3hKbWoyRUIyaENu?=
 =?utf-8?B?K2hFNjdOL2xkNXMzUnNuZUdjTHNNWjZaRm1qeGo2T2J2cGFjVVJoalVuM2Zp?=
 =?utf-8?B?MVBUR0c4MUJnRmFoQ2k0NnBrZGVwbE5oK3Zna2NEcEZHTE1nb2Mxc2JYTE9K?=
 =?utf-8?B?MjVpUVlUWWUzNkdMTjdrVFNIa0wxN3crcVNTcWc4VG95TnRJZDZwS2ZxUjc5?=
 =?utf-8?B?ZWRoNnBiSlBiaE5UNzlMY0hUVytDemhiWlZWZUNoc3FFb1ZhN2ZBSnFMc1Np?=
 =?utf-8?B?R2JCaHgrRDlrOE9qQlZ0MHRUNlk1NU41UitacitsSndxU0cwakhTZG5hWHk5?=
 =?utf-8?B?NUFPVDZzb0JZV21MZXk4OWQ3NHRmc1dvZzVNeVNTZlh6SWZ6Sm93VUljcmFI?=
 =?utf-8?B?L1JqdjI0UW9wNjVQbVBDam5Bb3N6WkxnRzVzN2hQeDUzNFQ0NytYUGQweThB?=
 =?utf-8?B?WlF6d2NaQUZnbnVFZDNVSDc1TUs0TXZXREwwSXFQakxROHN2UURFTEZySlZL?=
 =?utf-8?B?UGY5QWJVR3dyRjRKMnh2Uk5DVzlzeWMwKzBHNTA3NUphMnExajNoTWdycFBQ?=
 =?utf-8?B?L3NkRXIxeVZFcjRYVm85YjlhS2dIMmtyTzQxcElMWlNaV0VtMEZtNmt4Umd1?=
 =?utf-8?B?RVl1YjNrL013SStkLzhaaVR0REJ2RVRSeS9lcGtlZUExbzlmWjZzRU5nclVm?=
 =?utf-8?B?aHFRZmpJSytwaHVSSnZ2YlBHZFM4QUorc29HYmx5SlJlUmZ6V0EwZndheDNo?=
 =?utf-8?B?emJvSStBK2RpZnVwSEN5T0Nvck05NW5rUjNqWndGemc5UW5CMmpKUlQ2NVlU?=
 =?utf-8?B?R1dwRmM5T2c0M1N0RTNXMnRscEZ1cWNrN2QxaWZyVG9LajdydWRrbzJKcW81?=
 =?utf-8?B?VHNxRmNRRWo5WnF4ZGliNUQzbXlKOGU2V3U2VG9UUEVIcFhQd1Q0cGo3bXky?=
 =?utf-8?B?SkhZVWJZL2hKdUl1bllNMStadWZibWRzZUp5MVB6OEtONGxteEtjUFpabG9C?=
 =?utf-8?B?Wmp4aDc2WEJ6YTkrL0xFRUZzTDJmQnQzZVR4bzRWL3pLUGx0Y2hiTk1kNFQ0?=
 =?utf-8?B?a1pHU04yVm9IdkpaNmJnVGd0bDRNczBEb2hlaUhHdWVIOEZzeXU3UFljY29B?=
 =?utf-8?B?aWN6b3pmMVMxUDRVWDRiM1BFMVRSV1I3RGlZa0FKVi82TlluVUdyR21YTkVM?=
 =?utf-8?B?b3J4MEhKeTBHQWNpKzlVd0k1MEY1Mnd2NHZhS1Q3MWxGd2J0RkpvdXpHQ2Fp?=
 =?utf-8?B?eWZrcVJRempKY2FuRUY3YTZKU1ZZSGx6aGJHYWlEK3pTOFdWY3M5NCtZWk00?=
 =?utf-8?B?RTZValR4MFVoNDZhL0FpNmt0ZklLalQxVm9vMXZ6Z2pOc0hBb0xKVlhPM0gz?=
 =?utf-8?B?Tzgyc2t2ODQwenJja2RkRUNrWjZPR0d4dElKalBMNXQ2UmxNWVp2TG1KOTd6?=
 =?utf-8?B?VWtnaUZGT0VUYmFKM05uci9JMnVJRHhWNHlEU2Roc2lSRy8wK25sd1Y4UWk4?=
 =?utf-8?B?V3VNUlRNRUdoVjRkaFhXNWprRlFRT1MxU055QjdoMnFDa0JnVXUycFZLVVJh?=
 =?utf-8?B?MnZsb2Z0R2dlYVhiWGdBaDB2cklaaTdEcHRCMGgvU2YveEZlWThldWFyZ25Q?=
 =?utf-8?B?bEtqMzA0RjY4TkZHcll4akcvQTZVOWcxeEpNTUtVTkp5Y3Jvc1pNQmhubVRj?=
 =?utf-8?B?ZlNocm9DM3M4NzQ4L041ZWI5TlI1SVNEaDFwVW1wNE1hK0hTdmh6bG56RDIv?=
 =?utf-8?B?TU16Rk1tTzVQU3hpUDdiQVlkQy9pMGgvRktCRjk5TXpycGVrSUtsWGkwcVpP?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O0RDkjVUj2JNnZbFPp7PCyQjq4zx2bd8BoH/i6WC07e0EvZFHTN9+7i8p7OMA0c6HODlslOaOPtqW5Gmffupe+VYEDvy+gWfPjRz+ZCNFZ6DJ5gaNoung0X1F+rq7VKRMwOh6qFP9FaTTNgx69UH0e1PeBWBsb053BVX8iVXaya5WUucjIUADR8BGqMrpA7EhGKIhzaSHpwPYHTyJsKYi2amyva0aAZ87aXUUbe93YLeZG49yF0OiF4mKCB+2xGc3epsQ56D/HZi/uqPN2AVkZPk1ANAqsNZ4wsFPk3zWms8yPPJ285d4wKexgqV0AZoKANjvVfCG3FKOaCb8pmAc5HYZy7QTDf5J/nkhMYjeGknFtkDz3lZ4loWgJ0bsuxWOuo/d+EPfZ1ZMzMkrNAsBHYnz6c39LPVf2dOmlV+nqDDkW4GsldMkeIu9BpZvoupWdchIESTSAwUgvS9oJHlgpZKFzf3tfJNDN+4DxCgRCin5g3xQKqWzWlqPI+Jd0Q7QrVsSqPkXLajF/33JlS/3f1ugPsl5kBbGzf+zAntf5GRWJlOIWIJlM6YAqrffCTio9rWJLWj7zmOLlJzoWysNEiA+ih9O+R7L5fuXxEGr6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f063c945-4d4e-44be-1a99-08dd54cc2f45
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7211.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:10:10.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNstzv1HyyQQVDS7lseUPHC0RyI6dGYxONxXaM/xK3L2oHLenN5QDLdQz215tBPVI0ZZ+UXtT3XLEuZ2F5O3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240089
X-Proofpoint-GUID: fODJJwjYN5Tw4bzl_LvCUOEgpFEeVqxL
X-Proofpoint-ORIG-GUID: fODJJwjYN5Tw4bzl_LvCUOEgpFEeVqxL



On 24-02-2025 01:49 pm, Shrikanth Hegde wrote:
> 
> 
> On 2/21/25 17:27, Sinadin Shan wrote:
>> For kernels with CONFIG_SCHED_CORE=n, the sched selftest cs_prctl_test
>> fails with "Not a core sched system" error. Change this to gracefully
>> skip the test for systems with core scheduling disabled. Exiting early
>> would also ensure failures reported in obtaining cookie are valid
>> failures and not due to the config.
>>
>> Skip cs_prctl_test for systems with CONFIG_SCHED_CORE=n
> 
> I tried this on kernel built with CONFIG_SCHED_CORE=y.
> I did make, make modules_install and make install and reboot.
> 
> ./cs_prctl_test
> ## Checking for CONFIG_SCHED_CORE support
> Cannot find kernel config in /proc or /boot
> 
> This happens because, make install wouldnt copy the .config to /boot/ 
> config-<kernel-release>.
> 
> If the self-tests are to be used in development flow, these checks may 
> not be sufficient.

Right, this particular case was overlooked. To handle this, the test 
could take a path to the custom config as an argument. I shall work on 
getting this fixed.

Regards,
Shan
> 
> Not sure if i have missed any steps in building process.
> 
> 
>>
>> Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
>> ---
>>   tools/testing/selftests/sched/cs_prctl_test.c | 29 ++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/ 
>> testing/selftests/sched/cs_prctl_test.c
>> index 52d97fae4dbd8..60fd657b56c84 100644
>> --- a/tools/testing/selftests/sched/cs_prctl_test.c
>> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
>> @@ -23,6 +23,7 @@
>>   #include <sys/eventfd.h>
>>   #include <sys/wait.h>
>>   #include <sys/types.h>
>> +#include <sys/utsname.h>
>>   #include <sched.h>
>>   #include <sys/prctl.h>
>>   #include <unistd.h>
>> @@ -109,6 +110,30 @@ static void handle_usage(int rc, char *msg)
>>       exit(rc);
>>   }
>> +static void check_core_sched_support(void)
>> +{
>> +    char config[128] = "/proc/config.gz";
>> +    char cmd[128];
>> +    struct utsname kernel;
>> +
>> +    printf("## Checking for CONFIG_SCHED_CORE support\n");
>> +
>> +    if (access(config, F_OK) != 0)
>> +        if (uname(&kernel) == 0)
>> +            snprintf(config, sizeof(config), "/boot/config-%s", 
>> kernel.release);
>> +
>> +    if (access(config, F_OK) != 0) {
>> +        printf("Cannot find kernel config in /proc or /boot\n");
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>> +    snprintf(cmd, sizeof(cmd), "zgrep CONFIG_SCHED_CORE=[ym] %s", 
>> config);
>> +    if (system(cmd)) {
>> +        printf("Core scheduling not enabled in kernel, hence skipping 
>> tests\n");
>> +        exit(4);
>> +    }
>> +}
>> +
>>   static unsigned long get_cs_cookie(int pid)
>>   {
>>       unsigned long long cookie;
>> @@ -117,7 +142,7 @@ static unsigned long get_cs_cookie(int pid)
>>       ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
>>               (unsigned long)&cookie);
>>       if (ret) {
>> -        printf("Not a core sched system\n");
>> +        printf("Failed to get cookie\n");
>>           return -1UL;
>>       }
>> @@ -270,6 +295,8 @@ int main(int argc, char *argv[])
>>       if (keypress)
>>           delay = -1;
>> +    check_core_sched_support();
>> +
>>       srand(time(NULL));
>>       /* put into separate process group */
> 


