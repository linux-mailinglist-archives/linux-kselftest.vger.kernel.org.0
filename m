Return-Path: <linux-kselftest+bounces-14388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1493FC8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 19:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED621C21896
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203C815F32E;
	Mon, 29 Jul 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WxSzKNMn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GBEYXXOb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A8186E23;
	Mon, 29 Jul 2024 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274852; cv=fail; b=Op7tQGOqU+hGVcgeF7BbQLeUl6EmqQiv1J8Grr8Lcs5Jazq/wejGi6VYoEArNIzjH5DF3OVyZkZB3GWfpk78fh/hu+IvqReuQsqV+/e8xJDMMI8iDV+F3szTexMZ/zl+iKE0AtwGwSuGn1yaBRVKgWowZAciix+EwYdcQlBbRDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274852; c=relaxed/simple;
	bh=LZQq3lK4irNTYpKsMJBkEjz7fALTj/D/0HGMoTo3Psg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pi2LyC3hciUI8N3myR7dvMHeVyclabZR5PYbsVMOMoeYnOFJZBOlETOFot0hV0UlBolI9juUXhtWRpe/xLWagbAsG29RTMxtwRvXO0tKdfwIGtmizZdpWYDbHMEXGEwja3z20/wQrqaIyxOruiMnQN0hCDKyzDI41wlydn3JIqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WxSzKNMn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GBEYXXOb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFMYiH015429;
	Mon, 29 Jul 2024 17:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=1i8ouBjIb7kZ/UMuNUrZ47s8hLESJhsnwBPD+xtm1YE=; b=
	WxSzKNMn8vVNlPfK/2c5b8RT7W3GtRQcOIDhoEA7RRcxk7deRE9QNRzQ+wdo0hOH
	OqUGmq2LsVy4ptxJ8A5s8rDocyEH6jXABfrrPZUD11VrlK86UXExMN+Y/nXulfnh
	Nmof1txSgSewGuo77K3jhvJFqI31uxKbFOT8TWc99Oipngtm5eqyO3Yy4IsPV2Nm
	dEEKz3HXdWVijb6/N8MyUI9vNKUmomayV9UP0AriRdA0QSgStg70JhBb0dig3tpt
	2MFLQnN/ji+Je6JXfTNNNHfXeOqR5f+UOXpBFC3rn7ou6iApyBt9REZ3pmTChUYq
	/RE7rjIlfCCEqrEq6mXIEg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqack8b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 17:40:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46THRnfK009896;
	Mon, 29 Jul 2024 17:40:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nrn64wcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 17:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0lws25gcMkYkNxPOPIVD4bqM6c5NtNIYIc+7/PwpMJYy/AUh/+OT2PZocUIAVNunR99/sIkr1VQprA4kf4PoG7nbVj0FRfu1MOZo4pu1qv7iG0X2uuViLaoiTVm4lddNpnykOlj8PkO91w65P9+AzDBHn6mqbAgU6zwyA57zwgENOqR/+JTtXdXQW2bWcjc2JU74xrxTh8AdwSgEm1j68o0cNs+7qEqZrrXTvHpCn92R2cu6Ogcyz65FQ5BsFcQejoa/fJbkdp5oAGj2Z6Xs2oUjNg3R+GATk7XlPxJMrECk6bqUCBWu6hgvEJuOrAqee+Oc+7pI90oUW1JPjKpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i8ouBjIb7kZ/UMuNUrZ47s8hLESJhsnwBPD+xtm1YE=;
 b=tEN271hchqdPYvR0XqXMq6bZ/g5da9F0VhJe1Lq5qLH9f8FbQ2RvmHwN2aRZPRu9WUJ/0DtiSvng4UUMoDiEtTRySdt5kvW5bUkAwbcOUvT5aR14axnOlJQIf9LnIDKlzCEhUGs/mKQcPjz++gnXauO1CzxXOTpCXrz+g2yhMXeXZuKp8PnB5xhVv7nR7gicH8aEkKScpewECNoWT/MgfR9YcqXhafiTplcs3GTXuk9KFZtb3c/w5AbZtz8fmztf/eHOsMMk6IQdNqOIuCM9WCHwWYK388Q4NyYTT1DPccZom7P5gBhm6lAr+7ZvK52KeAEoF0yz03/pN0h7nESDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i8ouBjIb7kZ/UMuNUrZ47s8hLESJhsnwBPD+xtm1YE=;
 b=GBEYXXObBjjgv839DDPx27WZa4epE9t+2yetyf8nhCCI6l8EBCfTkviwKKOjSUGkTaoMvPQSnEKIABfZgZAVF0PhDI8+Th6fmpn/UKVUoySQJmN7RYVp5qXacVk1D5vCUIdbF288B++Ysi3p1usbqphZiYQU3DFiPcIOBbjo4wE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7643.namprd10.prod.outlook.com (2603:10b6:208:48a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 17:40:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 17:40:23 +0000
Message-ID: <b729c275-b1c4-4435-9d4c-6147b6a4675d@oracle.com>
Date: Mon, 29 Jul 2024 18:40:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: add wrong type test to
 cgroup dev
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
 <20240729-convert_dev_cgroup-v2-3-4c1fc0520545@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240729-convert_dev_cgroup-v2-3-4c1fc0520545@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5ec7bd-056a-4b7b-a830-08dcaff58623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVNjdVcvSmtXWkgwNzFRS1pVaGppUmFLZmlzZGgzcmJtNUFuc0JOQVJoRzli?=
 =?utf-8?B?YkJSaGtGbEdUWS8xVUU5ZUcxT3JnNkFZYkp3UHFKT1NPNUwwT3VnS2RLYkVX?=
 =?utf-8?B?MGlsNXBkOEF4a1JWcDFscmNtZmVwVkc0SHE4aGkzcEVDZzZFTVRxN0VhYWgr?=
 =?utf-8?B?N3BEejNpSUg5YWVVcDVSbXhFZEZ1OG5LQ3RrZWlrUi9MQWZYQTA3cEd1dmpu?=
 =?utf-8?B?WDRZRFVJcGV4V3dBWFhlS0FGaC81WkNsM2MvYzdRQzNHRSt6R0FQVTJXc2FV?=
 =?utf-8?B?WUVSMTNCdGM5UkIxWDVGMGc0RUZEdk5lZGpIUVNNM2RrMzRUN09VWEZqQWlV?=
 =?utf-8?B?VGh3Qno4dURsdGxmM3M5dm5Fajd5TTk5ZFIxcXVaamJtdVZMYnpRRll1VkZh?=
 =?utf-8?B?L0Z0bkkxWk9yMTA3UVEvYTgybTdhMmZZZUpsT2ZXLzBWNEY2Sm1vNDZUcUVU?=
 =?utf-8?B?RHp1VjdMTkxjbGtKRGlFRFR5QW5XWklLdTRVcHdvK3RKUVRrbVlCbXNabGdl?=
 =?utf-8?B?aldUOGEvQmpkWnBmVUJGSjE3Y3BHeVlUQ3BDZGtZVHNVd2czd0RRNGNOVy9D?=
 =?utf-8?B?clM0dFNuWjZ1dmJoWWUxY1RLcHBSL2VzeC81VFdMMmpEZkkybUVRVG1IdGZn?=
 =?utf-8?B?VEd4NENpb3RLa1pZZTRMYjRQSDVzRmN1cWRoOTlPNzRsOXd4bk5WWXNseTli?=
 =?utf-8?B?dU1qRVdLM1NJOGZOY25hd2s5MUJxZmlmVkdodTE5U0h1bnFnME9hcmwweVdw?=
 =?utf-8?B?K1hieE1FMTh6eUZTWkY1dFE4V05UUC95TThqN1VuanJGNGJJb1ZialB1MkUz?=
 =?utf-8?B?UGk4NGQ3a3M1dEZYWUtZSlJZLytOMnFTek1nbDVTajBWTitmd0FXd3hsOXpG?=
 =?utf-8?B?ckttVjVlRjZic0tMdmRDOXBMM3YrS29CTE5mOHJCWVNmOWJMUElRTzE3VW5z?=
 =?utf-8?B?UjkvQVRGNEM0Y083OFZOVXpvWDBLa09saStySllNaTFGSmFOR25wckJrN3J2?=
 =?utf-8?B?WDk1cktHUlA5a3lKZEVSTVlGallWVjFXeGh4L29FUG5RaFhOVmIvdkNRd2I4?=
 =?utf-8?B?TERiTG1HcHdwQUJDOFQzenR5Y3BiQTNxbGdWNE5BSlp0TFhyK2xGNTVwdDRM?=
 =?utf-8?B?Z1dNOFZyVnVPSW9GZ3pEakdVYlZXK2dUdjRUVU1yQmZKaG5SdWJML09EQUh3?=
 =?utf-8?B?eHlBb0NXenEyazRYOThGekxvaXU5ZFhMWk41MU5ieW5SQTNMYVhUOUlzdG9K?=
 =?utf-8?B?eHd4RFRoTC94QVZia2xWaFpFNzJtNUFHb1JJMDBveGVwdWJRTDYrb3p0MkFo?=
 =?utf-8?B?Z2JFdnM1VjhBbFhJcVQzbHZpMmE3dkJFZWJOOHRML2pSbXRpYklYUGRxVmJq?=
 =?utf-8?B?T1M2R1RjTENvWlVzQWQ0UU9PcGdLaE5nQTRmZXRBbS9JR0RDK0psV3ZYRE9z?=
 =?utf-8?B?bXFGOXJCWFhmdGV2eWliQmZ6T2IxQVpOVDBpRFdYZkorT2hDWGVNanBRTGIr?=
 =?utf-8?B?Z2lCNGh3bjlXSnpMdGJuSndQUkpraDZKMDRtK3BqaGpKaGRETEE4UUZVcHhQ?=
 =?utf-8?B?WURVMjJmL3RWSmxCczJ3aVlVTzBoZFlBK3hyT3FlVm5tY0Z3UXE4TG5qSjlk?=
 =?utf-8?B?R2tHdVo1WUl2dzZkNkV3QkJZcUJLa3pQbjNJSWVVclVGa29ObDhUKzNhdXFP?=
 =?utf-8?B?alp6T1FuWGNWN0JMR2pNSU16VC9DdXRydDF1dHoyRjByNVBaV0lVTEVqSnFw?=
 =?utf-8?B?TWJvb1dzT09NT3UvdjZFWHllOWt1NzVoUW5SZHhJMDZsKzFaYm9NOUpEbGtY?=
 =?utf-8?B?VmtXU3JRVG9WMWYyWnhOL3ExY1Axdi92OUNYVzRpWXhETEFqblN1TlpxenB3?=
 =?utf-8?Q?hpXqjz0hABdIy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UURFdzh0OU5hT1hTMFoxdDJyaU1zU1JjVGJyc0lESjVvMDJKUGlwcTFmT1A0?=
 =?utf-8?B?TEN6R1NuR0xMekl0WWFneTNvU2szbGlpTDNoSGozN2VBUjZQVjFRUjVneUxx?=
 =?utf-8?B?aHN5RkdIbFFPRnA5L2p4UEl1RjltMzVZajVpUVpWbHI5OEtZMHdlV0QwUWlw?=
 =?utf-8?B?VzZiZU0wUWc5YzdJU1Q0dHhlc216MUdLbWxwSUNMRDNKNWlkWnNFM0xRbG1T?=
 =?utf-8?B?Ylo3U0ZsNnJuZVlzNVBUK1lKNmhKUE93YmZxOVAvVk9Vd3J1M1c4d3o5ZlNT?=
 =?utf-8?B?aXYvckVFM1daQzBoWitOQTBNSTB5S1U4TlVma0xwbkduNyszWmJMWC9UZ0I1?=
 =?utf-8?B?aEZrcytncEEyd2gvRUQ2TXdOWGx2Y0xJUXE3NEJUcVptUkxMQTJyZnp1VUZ4?=
 =?utf-8?B?d3dESlF0NjNoMjd2NzdwZ2JMa1BXZjhnVWlxOThtb2MzUzBRM1RaWVYrQnpX?=
 =?utf-8?B?S05jNjN1UEhCVnZDTi9WVXZva0JUV2RTQnY3N3c3bXVjcTYzSDRFVkk4Nmpm?=
 =?utf-8?B?WFBld3JPY0hUQnVjUVI0aGVsdExNdjg0clI3dnlKa2cybHpoTUNMNndLbkcw?=
 =?utf-8?B?ZUZPUUlNRzlndDRrejNFVUw5L0RTOHdQbnBqU053bk5JTURHMjBaSWc2azZS?=
 =?utf-8?B?Y1BlTVJDTVRmSjkzY3ZGUzViK0c5V09SYjRKSkh2Y2JPTklaMlA0cWEvMlFH?=
 =?utf-8?B?a2N2ZFZPTHRMOGl2MEJKWTJzcmNXT3EvQ2dXSzR5akJQWnpnTnFjbXJRZXBV?=
 =?utf-8?B?aXNxQzNBam1HK3NITXhDNXg4ekRTaVA5dEkvdUxFdE5TbVJCdDJldFlMVXps?=
 =?utf-8?B?VjhzUHByRmQ2Q2JMWk43TlJrL3ZYQ3hUZEVoZU83RG8rM1VMSFFoUHRCbnBt?=
 =?utf-8?B?azJEbVo0azBXYUF3SlZoNUMwNnZDMWJMSXNZWlF5NFJuNk03cERRWFpHemNS?=
 =?utf-8?B?Z3owZFRLTXNDZmlhNFBhR2dUN2piME94NE5IQXNCVFplYVIzZnhDZG5TeTVN?=
 =?utf-8?B?bFhmSDRLNWxuTkNVZmVXbDVjeWpZMlZjYXRGUEduSjJuTXNSU1VmNVdNWmpX?=
 =?utf-8?B?akthdWtmbGtnbkMxQXpReGlKVkJkdnlUU1JqeGJNVTdaZ2daenpqRmlGQm9o?=
 =?utf-8?B?bXo4YTIvb3dnQVBodFFjbUpDYUlSckR2NkZQRDFWelhmcG15ZDNrdVJDWHox?=
 =?utf-8?B?Q0xNcmpNL3k5bUkwV3FUcHlCWlVQbi90ejM0Z2VYb3VaSXYxVFdsU1cwY3Rt?=
 =?utf-8?B?clY5cmt1NU9hbGVDdUx2RWh0RWp5TWlYTVZ1a1Y1Z3d5TXlXdW9FcGloMUhh?=
 =?utf-8?B?V2FCMVpWS3ZJWXcrMWtLWDJDSk5GUTFia2dJSnV5dWxRR2JpQWZjZ05CbnY3?=
 =?utf-8?B?SXlVVldFV1pBNUJpa1g3RkUvODFmYnd1TjNSNkdlU2xTUjJkYm5rQWJYbUtj?=
 =?utf-8?B?TkRiTjJaQUVENTlvRHFOZURrTVc3UG5VRlZxMnoxR0JWYkozT05qZzZPOFFi?=
 =?utf-8?B?VGVsa3JNd0RWK3JoVkJXUSthUzdaNThHZHc3aGwyRUZyTmordGF5aEZTSE9s?=
 =?utf-8?B?eW5sNmRFMG4xUEk3dmhEeVFKSnpTcE1uQUd3N3ljUC90UXBQRWx5bVM3OXpU?=
 =?utf-8?B?SXJqQU9qY0gzM2lNaFZEV0o0Wmc3OGlQZFhZV3lqMFloMGdITzU0YVFGSExl?=
 =?utf-8?B?RWc2WG11MEMzQ1laNFFoRGtWUVBjMnZpb0FQMzI0RXpwQ1VOVUVORnNsYlVr?=
 =?utf-8?B?bHloSFFxb0FyOXd3RjlHeWR5bWwwTHU4bVRPbVBlZDJiMkdEWE9ObU5DQmsr?=
 =?utf-8?B?ak5GKzl5NlV3WWZqU1NuUWxjZS9NVm1uYXhhWnBmZDcvdnplRWRDM3FBbHJL?=
 =?utf-8?B?YXFzWUdJYVV3SUZ3ckpiVnJPNFJ2U3A5Vm9NZVZ3Z2VWL0xscEI0d21BVUw1?=
 =?utf-8?B?WUJLRkdhZW1NdTZBakNiM3ZmQS9uS1hrS3Y3RjRVaG1SMklqdW8xTitGcmJp?=
 =?utf-8?B?aThueVQvMjV3NDczNldwcFNWUFVEdjUrejVyczdUYVJIek9RMUlRU1RDZlg3?=
 =?utf-8?B?MHNoMXFJcEZlNjZqbFlkdmZmanpEd0tvWkJEbHhuamoydFU2WjZMTEFnLzE2?=
 =?utf-8?B?TUxRaThxWU9RN1QzZkFoNitqU3FsYVU1WTFhSTlDQnVIaGxNWjN5UTEvVkk1?=
 =?utf-8?Q?F3GfsuOeJ+YqPTsNJ1XqK+0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ezn2wD6pUUCLfg3k2zm3mZ6TKKNVD8xGlY0WRYOMbJpvTS0JdW75dH3ujpwSmLpUWWW5H9XoK0TQG44XkIaWL3HNdG3CjFVHKZLwZN5VTqgJWDNidgdP7IPlOPfvpzcyQTKFqGms0Q4RTwjZcoQXNYV+Xk02bjjUjli8IwclOMPwGqGVZQBYbjaIqYLECwYq53IhBL4XeS/1Jb76hHZt5wPAzJg0Aom5w1KrkFvsjNglwqniS392RUcFIct6eL//3ZVcHyleqSewvbw0U0a6WfqKBPmX4ETd6u9didl4XL6o++YEu7kgabEJLtcimlwf+zhxmXrExIeEdQ0yVPYZrGvxgpxv/03IGtGReMls93gmaEi5WJbNoEmZV1P1K+GvTUCA5IV0IJgtxzGQ+hF64nCUYdknsUQCrNq4WW0Zo8LMTmsAlVBqVsQOg6U/L8dUtA/niXgpJUrWCXC01zcmTULZ8/f0RBvfXq5Vr7kHgj26N2cI+xlbZROo5k0948/7UaEQ3PtdTaNRArp8avR9kcJwSczlDORfvnDKJj0Sz9pY0e6ky73WhZZugq661+V+2QI91GZ8/Ms/xIuWYWaT/D53IvkTcDTmJbgShcYF2lw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5ec7bd-056a-4b7b-a830-08dcaff58623
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 17:40:23.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdqQT6s63KfYAtNgWfH7ZeqnpTYiV1I2k2yFn1Z3XjmWaQvhS+fmy7Epy7lbZoqtLXOmO3JO+Qdk1S3NbhlRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_16,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290118
X-Proofpoint-ORIG-GUID: OH0J-T2xy8CL3KArRNCbq43SC0uyB2eb
X-Proofpoint-GUID: OH0J-T2xy8CL3KArRNCbq43SC0uyB2eb

On 29/07/2024 09:20, Alexis Lothoré (eBPF Foundation) wrote:
> Current cgroup_dev test mostly tests that device operation is accepted or
> refused base on passed major/minor (and so, any operation performed during
> test involves only char device)
> 
> Add a small subtest ensuring that the device type passed to bpf program
> allows it to take decisions as well.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> Changes in v2:
> - change test name ("null" block device does not make sense)
> - use updated subtest API for this new subtest
> ---
>  tools/testing/selftests/bpf/prog_tests/cgroup_dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
> index af0b70086c21..a840973c87b1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
> @@ -91,6 +91,9 @@ void test_cgroup_dev(void)
>  	if (test__start_subtest("allow-mknod"))
>  		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0);
>  
> +	if (test__start_subtest("deny-mknod-wrong-type"))
> +		test_mknod("/dev/test_dev_cgroup_block", S_IFBLK, 1, 3, -EPERM);
> +
>  	if (test__start_subtest("allow-read"))
>  		test_read("/dev/urandom", buf, TEST_BUFFER_SIZE, TEST_BUFFER_SIZE);
>  
> 

