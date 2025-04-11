Return-Path: <linux-kselftest+bounces-30614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2917AA861CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 17:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1A83ADEF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7769120FA98;
	Fri, 11 Apr 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="azwoyljG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CIiuxHEK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3C1F2367;
	Fri, 11 Apr 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385249; cv=fail; b=KzD3E2qbmItE3ga+QfBVbsoFfhIHOj+9BSKpNXUlLb7idplz7GZqw8SVs9bYho7KOiNS+5JOqsAX3usMRfRQ3EucmJ9iQYuzV2q3Z8Ks0K5XRr/PGX8c9jlSZIE68WW0FDZ3XyAOcqMFbHLZ4SOw/1Q/ugvhoe+H3agr7OinIBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385249; c=relaxed/simple;
	bh=Kqx9XJs89VWbuR5gL+wU5o/m9CSMVlLLPCp+PUR8ZX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L73VfCM0RLoNT1CfKLlbgh0iTG0wvx3lWx4eXi6bEAsBHse/U85kPDpBD6Gmsawel+HdmlVJwWpCaA34fZja1AEXtEsSfpNA+ED4FXQlMoLj2H6u9cO08ColQ8/4Q1gLEyYPxn7V1mRPzCO0noMn2ZIMz+8pKbqpGXcSkecp9Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=azwoyljG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CIiuxHEK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BFHMII020571;
	Fri, 11 Apr 2025 15:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qibXymMk/r1fXkPv5G8QaEYFgPPPeyX4uBbp72qHMPA=; b=
	azwoyljGfDHtk7xAYOt1+A+k6xrdNZgET0PmvpBHJBsp/oq+DWYviDTXqUu/fHde
	QjJrT4dXOsYv6n93COyAuY5jQM9D4Cht3O3YkogEL2Cg0vA95I2HfscEl5/4+Tuq
	zv76HHWdy95ylhrsOe6/DDWqtb46KvjyHe6cl/5oANUahOCrPX7EMo9dDn5ypUTU
	yT7TaFbF4IPfcbMp5tXaNJRT+O+EMDg3e1XoRJJKsMw7IYiYVaT0XNURCBznGew3
	I0P25R9HjpY57X/HgDkTBve1KOIcmS2TDWqN9n2h4BhWzbc1hd0Dg/Rt30xn/crK
	8pyIekvSpwml5xNBDAQ2Ig==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y5k4r0rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 15:27:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BE0hvn022194;
	Fri, 11 Apr 2025 15:27:15 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012035.outbound.protection.outlook.com [40.93.6.35])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyej74g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 15:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LP8HnWeCfNlVoBMUotOP9B+N15TMhqQbl609epSoA8QKcHeBi8rXME7p6I7gJTH2HmguKkhmmDs+C4HeLDaei6LFxu/vDXggeckaIoOajQPBrmhTnA/W33vnL3XxVLCmTZ18+hD3CwH4YCL/WhhwA+FH3Df/xGm0MfolJnyDRmOTmnnT/84+i9RVRKMy/ouS+O7HnTnW/jHrGOE7resdOZJPwUbujCJzJNXNmRHxbnaCSBZcFiR3L/73gYWqFka+gXfDMEYJaHTFljE+mQk280Xqq+4D/FbT/qGvdMBrGYYtMMeT9G9+aYdf6wLWaw7i4j3/FUxnHEDUlptEOpi4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qibXymMk/r1fXkPv5G8QaEYFgPPPeyX4uBbp72qHMPA=;
 b=Z0jZ/MFDvumzWfTDXkZzCqotse0f3jyER0YP/pj0874P1tuygLzGtXvvZ+5gs0QjQgN30pm3w5+NWCHHUZqujy61jDF2/+O05v7fwgK2lDXDOmfrEEEVYEVPgr572ZvUMWPfrrCbaoqa9djVgjkN9lnf5mCB+Vx/1BnIaMQjhva/kcxZuOVz93CaKdn1qGQU+B8Y6HsWNYPeWgB09LNTCTBKBrE8WLDPhRl48LkVXAw39TMHGcwDdW96+ZGka3rdO02HwHr0LxcQcE6Ziydd3Hc5pAk2ri98+i+ulYj9fN1MDmLz+3Z2EZjycslD/bHmeD8HjyzdGEzP06bSwg8sUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qibXymMk/r1fXkPv5G8QaEYFgPPPeyX4uBbp72qHMPA=;
 b=CIiuxHEK5n6dGMwvbuNh2bDLti0B3sWLWrVFQh6W5zzsfQ0RiYOgLwK+JrdjIvHiv0ZpML9R1e94zmn78OUxgu3TWge8JqJmLgKOmoCmslsvu8q4LAvI66Ssw9m3HTm9+gTGGgSLgm25Vhm/amWpESt8II3K+ExkmE9SXVXyuOY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH3PPF0A29BA37B.namprd10.prod.outlook.com (2603:10b6:518:1::787) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 15:27:13 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 15:27:12 +0000
Message-ID: <96bd0364-3926-4aed-ad9d-d650c16e7440@oracle.com>
Date: Fri, 11 Apr 2025 20:57:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests: coredump: Properly initialize pointer
To: Nam Cao <namcao@linutronix.de>, Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, John Ogness <john.ogness@linutronix.de>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1744383419.git.namcao@linutronix.de>
 <4fb9b6fb3e0040481bacc258c44b4aab5c4df35d.1744383419.git.namcao@linutronix.de>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <4fb9b6fb3e0040481bacc258c44b4aab5c4df35d.1744383419.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH3PPF0A29BA37B:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaca5ac-69a9-466a-fa31-08dd790d5516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVNSZW5sclpTZWxDUVVYQTNTYmFGb1VaK3JESXJmcUJubGdvY1JvQmZKczlT?=
 =?utf-8?B?Vnk2aXIxWmVVcFJIMkU1eEJPd3JjRktCVWM4eGJHWXJTeFc4WkkwYzlYZnBl?=
 =?utf-8?B?eHluL1JaU29Lajg3cDhKajBCekpUYW9xK0hyU3NkOTVFZXFscU1wcWVnZkRz?=
 =?utf-8?B?amt0ek85ZHpYRjZNN0tVK3kzTzI0d0Rhb0NoNnBoaUVlTDZ6d2VOMVAwTGk0?=
 =?utf-8?B?YzlPQWFqOW5ENmVRRGl3cksrUUx6bFFRdnVEK3huZjhYZ3BTMVlhK1hhaisv?=
 =?utf-8?B?VnpvekdjWmFETFEwanVzNDhJQzljcWRMY1FPSVo0TkFYaW1wSmhOenNaT2cx?=
 =?utf-8?B?MWsyRWR3ZzF3THVpeEJFV2drOUt1VXN1cExoTUNXaTVqdjNjelErZzdQSEti?=
 =?utf-8?B?UmU5RTYrK1ljNFE3YWhqTG83R2RtVzRjdEoweWFsM1ZiT3ZpMlZpSURkYTRF?=
 =?utf-8?B?YXl0dnJLSyt5cjR6aDRtVXJMYlVwZFNCVk9ldTJxZkJ0WWhjTDBGbWo3NkFN?=
 =?utf-8?B?VktkMm9HeFFkdUcxQmdxSDdoemtBNlR1cXdSN3gxcktQcTVKazd6K1g3Mmlj?=
 =?utf-8?B?TUx2ZmhVcEViTm5EbDZGZTVRblF4WS9vdUUySlFKa1dqVjJ2MEh3NlZQUWZH?=
 =?utf-8?B?cTBSbXY3RWYySDZkUll2TkdtdmhPMkF6RUJpdkFnY3JGV2UvaTBucEtrTFJ0?=
 =?utf-8?B?Vmduc01GbXB0Sm0yYS8rall3SnRmQmF4QW5YL01JZWFveEI4blZhTnF3Qk1k?=
 =?utf-8?B?UkNldVdZUHFsNnJ3V2YwajEvQk5HQ1BnNHRDL2I5R0VSRXJlcWtHVTlrVHFh?=
 =?utf-8?B?djI5cWtZSlVla3Nnb1BET25Tc0FMTXRrR3h6M2hpc3MzaUwrVWJGME14Ylhz?=
 =?utf-8?B?TEhySU5FVjJGdlJ1a201UVZwT1g1TEE5MUVFM3pHRDhudWxJS0xsODE1ZEk4?=
 =?utf-8?B?eGlRQjJJVmkzMUY0amhBcDR3QW0vVVAvWWR0eFZ4VkhQbWp5VEhsdzVCbHJD?=
 =?utf-8?B?MUw5QjhnSWdqempRRytiY1YvdjZNS1dFWXl1NEhsenRXc1NHWE9mZWFKc2kv?=
 =?utf-8?B?dnM4d1ZuSmtuY1FLUEFydGx1ZU4xMW4waDRsV1pNT290VzJ1YWtHV2Y3ZTIr?=
 =?utf-8?B?djN4bDVhelZ3UXE4N1ZXVnBuTzJkYmgxdjlDcTJBcnFaY25NZ0xNaUY2dEJm?=
 =?utf-8?B?aWRTUTJPTjlQS2ZQNlJjRW16Y3NCaUx5ZDlkV3ZFeHJrM2k4UGlZUHp4cmE3?=
 =?utf-8?B?STdsSzMyWXRreU00VGpFUE9nUU5zUG04YTZMMFBjYzcwZ0U4ZGw4SFNlQ2FE?=
 =?utf-8?B?bTBDblJ0UFVZTUZGK1lGQkpLZHBtbWFVenpRNDlBTWJHM29iV2tqK1cxNlA2?=
 =?utf-8?B?a0hSRWNlblVsTkRlOWpGWkNNRmRwNlZ3Ynh5amhMYXJvdkZyVlV4d3pXbG9j?=
 =?utf-8?B?SW9qb2ZObjBrVFVrbjJlVmsxeFFHdnpLdTMzRElXcmw1WjlwdWFwMzVGZmtp?=
 =?utf-8?B?WHU4TmViNU9DN2Zjc01ITkNEdks4elFZMjVoeUtqVUdJYWdpVWpQZVV3Q3ZN?=
 =?utf-8?B?Y0ZmMFI0U3pqckxNMFZURUo2R2NlLzlpb2FqUU42SlhtWlNCelpmWU9reGVS?=
 =?utf-8?B?ZHVBeHhZWmtxc01ZYW9kYmw2RGJJeG1MaGE0TGE3ZDVtSEJ3d2dEMVlBS1Q2?=
 =?utf-8?B?MitGNUppUG1hbjJTK1hMYTVKOHlYM1Zrdkt2dWtmcG1iVWt3c1JIdkVkL1h4?=
 =?utf-8?B?cFByMlZyQlRGQ1F0bVpsMHV4R1ZLdFJwcWliUEREU0w3TXoxdnhSeVlpOFkv?=
 =?utf-8?B?ckdIZzkwUkdKSVBKOEV6MzZFdWRXTVR5cFdlTkRsOEN0NEtMYWNuWTB0dnZE?=
 =?utf-8?B?aTJaQnVXRkx1YityUEVySEhWcEIrdy9lODBXSENRaVhyamc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWYrY0ovaHRubysxalFlZjVhSGxEUHUxSWlNdlJub1BGdCttR2g0b0RFeGlW?=
 =?utf-8?B?L0ZaVi9mTUh4bnhEbmtNbzk5cThxeHAyU2lsK0d3Z0szR0Nack9pY3J1TVBk?=
 =?utf-8?B?WW1vUFBRNElGK0tpdGg5bUphcVExY1BTNlJpcmowRkdndThhRThDaklVdS96?=
 =?utf-8?B?eHVsY05JSWlIRlFaa21kRGM5T3V4LzczSER1b3VYYWZGd3IxTVBMcytFc3J0?=
 =?utf-8?B?WlhVbVhJZkZudHRmekErWmFReXN2NWIrdjdaZ1MyVWVtRy8wZk1EZ255S1NF?=
 =?utf-8?B?N0x4VGVHeW5jc3pOQWxRTmxFR09QMmMxV1k4K1I5YlFGT0NnQkl1VHNJWWwr?=
 =?utf-8?B?blJiS3BNdUxDb2FaWEtOc1dYRml6MGFVNS9qRmRXYjlad1hrUkN2TzlUTlBi?=
 =?utf-8?B?anFrdkV3cVNkdWNMYkpEY1lseWZ4TCtVWjg5SUwwaDNSV01CT09oRVpJdW1J?=
 =?utf-8?B?YkY2U2ZHdm9uYUJrNDU4Q3M4emFVa2hqY0ZwVXBZMlhkM2JuUzVBTnVzbWFI?=
 =?utf-8?B?eDFzRjY3VEJlSFl1TGNkMzAwT25KcjFYSmpFTG0xTnhyd1MrUmQzaTJHZlRq?=
 =?utf-8?B?YzdqU3pOMVY4VlhlRlJpYVE3d1h3WWg0VlJiR2pQV2lndkFKdDZzYzBPUzlK?=
 =?utf-8?B?QTNKc1kwS1FnWFF6dVlOZ0k5cFVnMEtNdzY5R2I0dXBURUEyUmp1ZVUwTk1B?=
 =?utf-8?B?aGZzeUpGOFFhWFJFSldLbVNNUU9pSDBscmdXdjNGREJBYkNIU1lFQ0tWREFo?=
 =?utf-8?B?TElBNVVqSHlrRmRrZ1hSeTJDWHk0aUVlNXdnU3BYNGJXOTVtVnpINE1UbnJO?=
 =?utf-8?B?TVliblA3Y0J4NTRLdmFwQVlSREdLMXRCaFE1MVZyY3lWWURxa1B4VkpIUDQy?=
 =?utf-8?B?bnFVRnhkTjhOUE96T3ExS01VL0pCdVQxZTZOWVowYVFkTVBDcTdBd29ZWVVy?=
 =?utf-8?B?bjAya2Zja2p1Zm1CeHBzVk5iY0prTXdwVTlRd3F2MGlXQWQ0bUNmRHYyN09t?=
 =?utf-8?B?dkRweXl5ek8yNDdYNnJ5LzRGalh0Tlc4UnlieTlNd1BmMUFBN3c2ZTM3OHpI?=
 =?utf-8?B?c2ZPTjNiRDFsYTM5SEVxd1QxTlR4UHdIeXVoMCtHdlFjNSt4QTMzbWVVNXpt?=
 =?utf-8?B?VWFDMFpNRlVCbTRaTUFDeTlKdHdINzNwSnpGanFJRlBJS0o2dE1BLzFwbFNr?=
 =?utf-8?B?eFAxeXlOU29rODBORHJqcUhTblpoK3RkQkY1SllCSkwzd0EyVzVXb1lDSHox?=
 =?utf-8?B?Q3RVbGh0NjdLTTdkZ3Y5SmJJN1c2aDNlMWgrdlUxZHJ0ODZFdXNaYXZ5YWVH?=
 =?utf-8?B?SGFLcVVHUmp4Z1pqcTJoaXVsb0trTTFseXFxQ2hYQytJTE5qYTNCdHIzTXB4?=
 =?utf-8?B?VWRBUjRybG9lSzVWNDFlMWFoNHM5MFJKRTgyKzdLL0R1MGYzL2dXSER0L1VC?=
 =?utf-8?B?bi9jbmRtaDFZaEkzQ2FFWThLZ2llUzU0THNMYVBTRVhIMWJKQkozQ3ZaQ3dL?=
 =?utf-8?B?TzRoRzg1NitTcUYvaXluWTl6V1pXQWhwc0dDRDhQWGdIVDRiUExldEs5ZURE?=
 =?utf-8?B?ZndYSUNjV0xmbXU0dE0vOGNrS1BWRTgrV0NQc3laTGdPV1FJVmF5NVpHZW1p?=
 =?utf-8?B?SmIrSDNKbFErc1UzNW9WcUZRZVNieHVkNjIyam02Q04raEZiUWdhTGx4UEx2?=
 =?utf-8?B?dVBoTEJpVHRZTE5LcXkwRUwwZGdWUUhmcG5ZZ3FRdUNqK3RnMVJ6aG9Fb3dL?=
 =?utf-8?B?V2szVVNrdWFyZTBEaDZXMkJyRWI5OWI2REJBZUplcW1nNUFVVGxOVVVwOFpJ?=
 =?utf-8?B?MzBHRXNVV2puTEw5WU5BVm94b28zS2NLSWhiTUpHMW5UUjVDclRYRzdaSGN5?=
 =?utf-8?B?K1J2ZEdDVnNORzJ1UWZCZlVwY3BuTG5UYmJ2bmNVSlRtcllnb0Z4NUlqd2Rm?=
 =?utf-8?B?U3A5WDJIWDJJMnUwMWlHNWx3Vm1LNytOV2Fsd1RSaS9PS1dNNUpoaWZNMzhQ?=
 =?utf-8?B?b2xYY2VnL2U3R0VnRjdZUmhMN0c5WE94R2tNQTZKekpRaXgybTA2dWVHUFFs?=
 =?utf-8?B?YWxhZHRBcG5QRlhITmhDaHMxRGJwbDFMNjRPNmxNS2hSNnc4ckN5MzIxc3Y5?=
 =?utf-8?B?R21QdjlFV1p1dGFYcWlGc1owOGJpUmRaOXQwTmpYdEFmcjBiSzlxVTlkRDhN?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	On3RvRNY1AAS6noidbLQgV9X28Qk1gXYIfzrOLr8uN0F9grlyQZuy88pQ6nPBba/IgBQN4KOmijUIGvYPKf7dfKoqZqpvglPOtnzQUtjp/InQsI6mlhCx+JKiwWpfQiVBlZw/HY1p7/uf5ihD7AcLdJw+9KKWYUHTqihqes8xFf8Iwgt6kH1SOzqJz3J9XW0Cqdveg782qX4I/V4kcRiOg/7EhgeqYwI7UlDzlvAlzVzUoOkhE5+4kwYZg4ZoeiG6RN3hZt2RrNHROaai0QyTDTxcUojUnf3ChgSRepIzk/CboAnFdSTcKOlzEIkdPGCWtB4jqQn1xhSu4506E0Dqi1r0vGnDQuVwIqAm3WbJmlJxjKg91P06HyqvfwRw3v4y4hYLF/72MKrHtppH2EiG9j+9wbyOuSAfxiFRIJ9WWS20VwVnv0jPjnXk/s19f3iH4TVejYUsYOYkWpBfap41bLOKtvPUnW645zqZJ594Hnd43SUahsMrs7RFUHvEC0SBWp/jESmr9hBrbtjDuhUFd67a+RD8ssPY8F2UzD27UOo4USBrEhbUPgJ8qT/whFE0D5S/CjbnTnUFB1SuHQ9RJJMN+dNHshvNmD8+90fVkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaca5ac-69a9-466a-fa31-08dd790d5516
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:27:12.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKiq+iOrnJkA7vlJnsHnt9kt5c1FqGOR+cmBP52ThfryK0PY0jsODepAKqgiNAPt48V6tMfdAB70pL1QNKz+pXwTApLQYuO5sbkr5C4h86c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0A29BA37B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=966
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110098
X-Proofpoint-ORIG-GUID: bm5OTuEJrM3SV0Joll8jtguOc-BUYciY
X-Proofpoint-GUID: bm5OTuEJrM3SV0Joll8jtguOc-BUYciY



On 11-04-2025 20:39, Nam Cao wrote:
>   	/* Step 4: Make sure all stack pointer values are non-zero */
> +	line = NULL;

such case it should initialize at declaration time.
better to move up char *test_dir, *line = NULL;

>   	for (i = 0; -1 != getline(&line, &line_length, file); ++i) {
>   		stack = strtoull(line, NULL, 10);
>   		ASSERT_NE(stack, 0);
>   	}


Thanks,
Alok

