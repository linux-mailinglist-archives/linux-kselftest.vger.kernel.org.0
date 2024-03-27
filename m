Return-Path: <linux-kselftest+bounces-6723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0488EDF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 19:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F521C32E2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BDB14F9FE;
	Wed, 27 Mar 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lsjfUjAw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CwDioEEX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B614EC74;
	Wed, 27 Mar 2024 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562997; cv=fail; b=kbv92Vn4xogmx+LzDD7dx0srLXEUiMTORPngzX66C6MrkqoGJ9LV9ImaAnAg0fP+v/v+C9sYIAvMtyflWq55a2KQ6qM1VE/vCPPW98MIQe5UaRXFFYzZFnakIp/NLk20zd0gJzi1VrKIa9F+oRO3i+D1vhcfRn74PuWQsajLOKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562997; c=relaxed/simple;
	bh=hejfwMVJqDDjEHMcxuunfGaEVcxNZ+WByjyk4Fnk03c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uldUbfRgeboyxNSrLWoIYrJTiqxIKZV9XDE3cCPAbPN6Y020OhUGAQJUUj3qwuP+f7TA/Q3sqaJmxW0xF1ILLHLMThWVWv2E+vHGPywU+cP9K5A1DcAfHWxNolLtFxuDiZV5haP6i6rrsSzJqo8Phbhbi6D2xgc1BPXVSv6auAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lsjfUjAw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CwDioEEX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RHxKbs025505;
	Wed, 27 Mar 2024 18:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=d3sqhl11Q2O3q3MHn6GOcKgb1/fFJ48NJBzRytBksLA=;
 b=lsjfUjAwSYyFdKvZIv0qqnVXeRI2CcWvGN0a4vhjyL2VnoX/EZT6377//+ROdzqsJ9bG
 7M3PPItzGpE0j4PbnJL861nkjkEZLx5yn/E8E4SwdCVM+9uQa/ajY+vxZftmPh7l69+N
 KOK5hAiNh0bHo+iyIvwQhf2GWf3Am4rN3fxEgYXkYhzbYDmwvGpi+pYbiUxYaHNaaKeG
 RdlkxiIdAqHviHQUIQ0yz5pTDkIUnLHwdqYBpdnFw+NM30LKgF15EsB7vkpDOU7UXVBj
 7YU5CtjQSi+JDb10Q9wo/rx1se3rNDR21+s3Q18gDtGVPgmNb4pwPRqQBDHnssdqvoMI 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybr0yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 18:09:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RGvv0U019231;
	Wed, 27 Mar 2024 18:09:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhf5uv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 18:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaHbXG4n4dHSxqL/UOQeKXQqwhCj4Ya7k0KgzEZH2p6RIAFpcrPMNO+nRUS3dypuuwQq0YarCrBi21ITjUxrxWPnSsc64PPBeHV8alxM2OG177NMjTqNzPAxIraxS29TmYlQI/lFxZAj0M1pyhlJObtFBGRlpoYSFksmweFl0JkFTtYZM2tBNlsOPD7kMyp7VshZC9+KKMaV1IJoOlcJxB3M6pRENmb/DPzzByxQc/zi3LaB/CxXk71qktrsqdM9D8J85CyEZCjWtqYgndzphFf60nYWQ7agBlie2ApQW5ws+txU+nKONUSjC4AClPisAu/PESrPGzrZy7flfGAIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3sqhl11Q2O3q3MHn6GOcKgb1/fFJ48NJBzRytBksLA=;
 b=kw3US1jHAfmv40Bg3lXdRjaG8WGTIPUSUBRsygISkhvKYvrbyTJ6uC6CD6PtfX2/jDTE5Zcd7JonZOU4Ce6Y4oxNi+M7vTD/oAhS7922ckhRr+/fwN0kGonTg1MaDqoe86iVayuIdP4bd4jIdPHjUzYvyk1vrc5XAW+keJtBJDRWf08rEdiykKVEUIt6rxUa6QIeMVx5VJclLUWQv1207UIg9ge3ULjQeMLXfO1MAN0W6Or5hKfV3eL9Js8jw5E5JfCUMsKVtcT9OQmseN4BUdoh9XVOeJjr+vVqLGoUxaJENaNgE9ZqAoWN+SliRAesKx2Z4+qOqmv90D/SRGpx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3sqhl11Q2O3q3MHn6GOcKgb1/fFJ48NJBzRytBksLA=;
 b=CwDioEEX60a46UQyJFij2fI6gkyz+7cek3u9iTnibBUr4Ba4+rzCW+obMvhThmhfEWEcAU9bVxq9V2+O/Zch4rVHI4VdVzNZh9AauNGZzXKmA1X2tJovurfPbTOfbS3vZQ0cgrf8+M1OeuwRpPPH/mdKyEvcJm6kL5lGrOzV9Uc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB7691.namprd10.prod.outlook.com (2603:10b6:a03:51a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Wed, 27 Mar
 2024 18:09:43 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 18:09:43 +0000
Message-ID: <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>
Date: Wed, 27 Mar 2024 18:09:37 +0000
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>
Cc: kernel@collabora.com, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
 <20240327114958.GG8419@ziepe.ca>
 <51f493a9-08e7-44d8-ae4a-58b2994ea276@oracle.com>
 <f78b685d-a147-4b59-beb2-cde9d34ce22a@collabora.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <f78b685d-a147-4b59-beb2-cde9d34ce22a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce5383f-f5af-4bed-1b00-08dc4e8913fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	32oiWU2kWTqycBeJkv2LPkkfxkwN1AD2O2DJmn/GsGtSsBnREkiIJ5GxjLM6LnNbvqa2VD39mGz8fNF4PSZe3O7xHK0MQHa1RjiWR3GayTJioPXrFoFKCTURuipyNqtRN79AfVPZvoYuSHHxwjw9AybQe6XUpmvh5QUNHAc6lqNHXyK6RizHGZ5rIwbHECC9pCTYRP1PprypmzNCetCVu12TJoOkQM52fcnfL3AHq+DeUDPNUgEcMR5Pce/QIZl7Ubt+7Gb5zjuXBBy5BGEhc4Z+zWUj52lu1MsTCsay1KF7H2pFyTiCfuzOlYph+IIuRzL1/fN0IhvhajxScCOta+Wy0kP/31MGPQL8uCnWApV7Fo9F/rL8WLgkcTx8AWElQ64/eO0fYf2I6NpUvo2j2OHKt9wp9NaCmaFImg/R5pniPmskT7xtdTY3mylj6/bBmKcUNKI3hHpIivzLtoiISycp4HvWKjyiQSOwBG449vhj1VTKNNDItGZl3WaaM0sBXlobZKLjsz2D1/XOuIMOsZ2q6uyUoVL0CJrYzckTt04yprKeIs/nMEFijaBhU2O8I2VWvk/LmwVDwN6amfJvCD67nBb3WZPKKJR5D8kX3exmRV+VDylSxv6NovEfJ9MPwlOtl6Lh3oZJ5Bo6Y4daSPEwOe7Vns5uOetXfijAXiQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zmh0OVV4Ulh0ekpYWUUzRTY1OXU5a2pVOWxYWno5T2lyTVpzQ2ZKaFp1bVgr?=
 =?utf-8?B?THMvdXZBMTdGYnNJVnQ1VEVoSHdyQjZDaThabi9zVko5SHFGVGhsRi9uOGlS?=
 =?utf-8?B?TFVGd01WQi9lczY2cU5aMmVMT1dsU0JsQklqN3lKZkhjaE5VTTh2dStkNkUx?=
 =?utf-8?B?cGhPek9qYzVsNEtMZFk3UzN0VUpvQVg5UTRWRFpvZDdZZDFnbGxyZ3ZrOFBZ?=
 =?utf-8?B?dFRQTTh5OEVmMjVneGo3dllScHZRa3BPL2Rmakxrb2kydTBZd3Z0aXFaQlVD?=
 =?utf-8?B?T0Y2eEQvTFBKL2xmelFva3kyQVB3L2RtY1lCOStPY0xvTTY1eFhxUGtuam1p?=
 =?utf-8?B?KzVmaW1YYSt2ZkIzWDhNUnRDWDBxMmxhamlRbG91Rk0yYkRLaFNSVnlRemhC?=
 =?utf-8?B?MWdiS1FIdVNMaTFwbWpRS01BaG82d0Y0UTdhV3JtQW9lT0ZsKytzSnFqd1Rj?=
 =?utf-8?B?S1ZiNjFSYVA5Nk5VNnJEYUN5bU1Xb25OQ0tUWExmV0FIZXFCTDhvdUVJQjd3?=
 =?utf-8?B?V0Q3clNSL3NvR05kODArZ2JjZDBEV3l6UXNhTzNoY0J1UkZXcUNlNy9JbCtG?=
 =?utf-8?B?UVd3ejIyQkp6WEZFaVl5UktVUTRremp6YXFaNzBLOVg3bnRBSWFJazd2c1VY?=
 =?utf-8?B?U1hHYzBjZERESVZZUjZUR0dXc1ZqR284aS9JVEZRaVlwdGlsQnpUQ21wSThx?=
 =?utf-8?B?aGhlTmhSYTRzSXJ3MGhPZ01PRGIwbXdyQ012Y25BcGM1dW1tNE94YUJqMHMr?=
 =?utf-8?B?Nk11WFhCdVk2UTJveXZpUE1tZGh0cDAzbWxJSjJ2TFYwazJDblYzZy8xV2J5?=
 =?utf-8?B?RkdSczh3YmRGc2dtY1R2Nll4ZWVzUWwzQnpqNTNBc2lvUEdPbHZYeDNYU0ZI?=
 =?utf-8?B?Z3FYdEhvZ0ZPWjc5UWtqT1A5bHpRVzhpS1plTHp0eUd6QXZaTlh1a1RSNmpF?=
 =?utf-8?B?eHpoTklTcHBlaUVwUWV2MDFMaVVmUncyUkVIbXdRQWFUdlNjZkVxZnEwK29W?=
 =?utf-8?B?RlJvTzV5b01IZUs3aENVOXI5L0gwN0Q0eVNIUXBOTTFUU214TlFEd2dRY0hU?=
 =?utf-8?B?em4rcE5GK0FEQlNDaTh6a2VwWWJLS0JvcHJYVGZlN0I5b1U2NHN3NlJzendo?=
 =?utf-8?B?cWNRVndLeTdNRmFSanZVZzNQbDlLWkJuTUNWMjN6NVZwNUdUWWh6NEUycUU5?=
 =?utf-8?B?M2xkbjFNN1ArN0FEcEVqbkw4Q1FzdTlEVUQyNTBKUlVBU081a0lpUFd2RklQ?=
 =?utf-8?B?dWNHY1A0aDFEcGxGT0ZJY1dVTVJUU1JPRDlhcU5wdktlUG9RVjRBVno2UWJ1?=
 =?utf-8?B?NnFhVnpFL0lDV2dQUThZaXRtNlRidDZhZkFLdUI4SU0wV09Bd2h3c1pNd21l?=
 =?utf-8?B?WW01SS84aDVhUVhTQnNmOURHU1dPZ2N6ajN1TExZbE04cFdVN1Y0Rk85Ly9J?=
 =?utf-8?B?aTM5ZXF1NEdZNWN1U1dBYjNCWHFILy8vUzFQZGd3UXNEYUNwWmxrM2VqTnQy?=
 =?utf-8?B?MWJrdWpWNjRLT3RYZjRHenZkUzQyTjJoNy9sOTRieUdaU1Jrb21ZVHBWWE80?=
 =?utf-8?B?NWd4R1NwZldLT05GTS8zMXBQSERlazdiSU44VmFrVEhVTHdPSDZhR3JuZmJX?=
 =?utf-8?B?QlRRdFg1NXZaVzFWRG53MHZrcko1Z3JHMEF0azBMRUUwRWs1UHpiVElFVFNU?=
 =?utf-8?B?b2lvZjQxdlFObko2OFZNTDBLb2NBakFnWitKQlVsSElVRTJ6RGtNOEowWUw1?=
 =?utf-8?B?cFZyL3Q2U3RBdEI5dmVCZ0xGMCtRZ3B2UWxvM04rNUxNcjRMbHl1aG54TWEz?=
 =?utf-8?B?WEpyVDZFNmh5VFhPem9ib2ZQNjQ5R2tIRzdhSnh4TmtIRThlcDJiNVFKeTcr?=
 =?utf-8?B?TDZHYjZPcVBoaHVGakRFL0gzbk4xT0ppSmljN0tqL3RvdGsvV2Eyd2RUSHZ0?=
 =?utf-8?B?QmU0aXBKZ2xBWS82UjVheld4OWdWQ3A4TzMyanVXMC9OaFpCcWhIaWdJNkh1?=
 =?utf-8?B?TEdEcGs1WHo1L1dQRlpEYTk1YkxuR0NEV0lueHZ5QUVhMUs3UWpPN1JLcWVS?=
 =?utf-8?B?OXNoOXVjbklBRlB4SWJFdXB2eDR3RU5oT2RGcWN3QWVlSUVpRFJkTE1FNzY4?=
 =?utf-8?B?MXQrSXNYU2VoZU54b2JTSjlvWklVS3IvWE5wSU5CTFUyNTA0M1Z1VzdmUDRI?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	svPP4w3oVedYPTi/rXQPumZvLEeXJLPtOVXLy2tPxx92KgmVz0IxnHrrxecU7dPcUIg70GU5em9EYWEHb9j30wqPJgdfyEXkY1MDMhacNqvffFoNOv0jAWNy6bP3xuDV40U2ebYlEHUeBulPebfYoxkhU1henSaPRmiOXk9WzXJxiHp6JalJEmaZG7WJ8pdurvazpN7QojsRO3Ui8VspZGAfde7/8hk5/29T9clRqdUCe3rarDGw5+3I4s2Pvfhc75JeHBbUHE+8h/hXypl7Ua5PZVb75JISPm+i4xoGr4Ahup4T9cLOTp2Pxsfveam44p7t+jQKx5lVgIQ7cDM7ol/y5GguYuCnnB3p90xCf9byryL9E+SF4Q87d38ywl+DcpSn1aMTbU+ci4uwI/bFRshqfhqosgY23TRS9C+R4CAHRVB4OC439j898LQyLb3WK39i5w7NU7p5cJ9hYAyNCp2XVzaKvGpUBO9ZnKP0fo1jWbZb2C1Z9s3t2kktbp7BhXsRcklL3J8wOlkEKCXILebxYi8DGBNaViU0/EDSILxjik9nwbYfgFGVvYnnw6eZ3Dp4hEcKaY4IDz0/LpSmAZ5A6hmpE/jPa2M0tmvluug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce5383f-f5af-4bed-1b00-08dc4e8913fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 18:09:43.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiX5KdTPf9TBd5dbMfE2TEY+T85SJgmnk8H2G0ZbR9n0uRVKKl9D0+7dcFlUOZSCrpIYnscfwnnG/SDWn7TwZV/tgKxoXzVnZR0rz7eAx1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_14,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=840 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270127
X-Proofpoint-GUID: BxlNyouNtLqbA0awa_UnFJy4GWs5Xa4L
X-Proofpoint-ORIG-GUID: BxlNyouNtLqbA0awa_UnFJy4GWs5Xa4L

On 27/03/2024 17:49, Muhammad Usama Anjum wrote:
> On 3/27/24 7:59 PM, Joao Martins wrote:
>> On 27/03/2024 11:49, Jason Gunthorpe wrote:
>>> On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
>>>> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
>>>>> On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
>>>>>> Even after applying this config patch and following snippet (which doesn't
>>>>>> terminate the program if mmap doesn't allocate exactly as the hint), I'm
>>>>>> finding failed tests.
>>>>>>
>>>>>> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>>>>>>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>>>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
>>>>>>                    mmap_flags, -1, 0);
>>>>>> -       assert(vrc == self->buffer);
>>>>>> +       assert(vrc == self->buffer);// ???
>>>>>>
>>>>>> On x86:
>>>>>> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
>>>>>> On ARM64:
>>>>>> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
>>>>>>
>>>>>> The log files are attached.
>>>>>
>>>>> You probably don't have enough transparent huge pages available to the process
>>>>>
>>>>>       echo 1024 > /proc/sys/vm/nr_hugepages
>>>> After making huge pages available, the iommufd test always passed on x86.
>>>> But there are still failures on arm64. I'm looking into the failures.
>>>
>>> Oh that is really strange. Joao? Nicolin?
>>>
>> Definitely strange, I'll have a look.
>>
>> So it set the expected number of dirty bits as that assert doesn't fail, but it
>> is failing when we check that even bits are set but not odd ones. Like it's
>> hasn't set those bits.
>>
>> For mock tests there should be no difference between x86 and ARM assuming the
>> typical 4K page-size. Maybe this is 64k base pages in ARM? That's the only thing
>> that I can think of that affected mock domain.
> The config is attached. The defaults are being used i.e., 4k page.

Looks like CONFIG_IOMMUFD_DRIVER is not defined :(

Thus no bits are being set.

