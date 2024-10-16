Return-Path: <linux-kselftest+bounces-19856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5579A9A10E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 19:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792511C22AA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 17:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA91DFE14;
	Wed, 16 Oct 2024 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FUuQnKzY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oFWMdmoU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15AB290F;
	Wed, 16 Oct 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100893; cv=fail; b=Sd2m1hB0fN1NAkz1BKGYIWU84g8WJ8HrfzOjdGezyU9zIwOGNQbPuBtlz6YFpT4SAaliF3igi2Il63/TOaiAC+jwijFcSsxOnVgXsIjJPItPHLYq3THz6aOjQrzDVCQjXFY7XY25hWbPeTG5fXIHtIkTc74LgI7r6drEkG1u8SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100893; c=relaxed/simple;
	bh=eMPqi8R74ixbaQwgiLZV/ZUGY8QQLyDJZJAfLXPquKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AfcyeLmw1csfx+ApdsqU54GEwBhWHzEQwPIDUs/iWk1+ut6Mn0yFpRZD8v0sluRKIIwyFKYWwku5Jp6tJc9ZMCqY+csiW2Ji9qzQCnqZZpBFrE0Ghjwy4rfjimWHHPwYjJlFzyKJppsujkxxRNH3Gc57b4Jl0ISk7vDdlWekSJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FUuQnKzY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oFWMdmoU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGBsmg010176;
	Wed, 16 Oct 2024 17:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eMPqi8R74ixbaQwgiLZV/ZUGY8QQLyDJZJAfLXPquKs=; b=
	FUuQnKzYGgrmPJj6XQsxIiyWP00KYBhkbD7xPzAHuf8KSQZnwkcuDcGnggWerTZK
	RBVGkBIfW3C0WhlwpMHSrpxtgPQ8MvDXK5CBEAOUMGxlux3cY5+A9N8/ujXSJg4f
	WNQcv1vhHeT3+z0ZaTVRbIFfZ23o99hGZzfpmd6Jtj+Lg6vhQJ9orsJgon8lCUMU
	cFm0n5ZacyPtyekWgManq9XGMC50sPZdrFDXBkNzgfAip48aM1aaQgZNHQ6IsqkZ
	7T0bAN1FU80jKQ3mEa/THuUBt1Zd2QKLz2S8BQkxOH2PvFTptpFffAuIrVC7F4cG
	1Hy9s+/7aSY03LWToDR7/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09kxx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 17:47:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GH8nhE036006;
	Wed, 16 Oct 2024 17:47:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjfjuab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 17:47:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEKU1R6azMABX5L7An+35YBHCsTYTukz6rsoO4qkUsEIS7tUR7mxaqH1rvWDWCQiKMXaqUHnt6Rv2YF+6PPxdCD1xfGNXQp5vS0UPIRAUcKcgXJIUy8WZwHD/SFJIdAliDd+aQelETBP0MSSwEKb43Z4YxDyUXRahxCwm/BFxpT4DfCw/EGldPUFEJzKfvSmSDHaRTtlXAEgsTxZ5rwTEGqhLF5iGBxGEOoTdoKCWKJOSdT8MBpkqu0dLVkOqLmho7NsePqBcK6twtLENfoWmH7eggbl7hZMryVsjZWOlDSXz/IJJ8HKd4rmvUezRvLv87n7TzZ2VQ5JBL02jIUu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMPqi8R74ixbaQwgiLZV/ZUGY8QQLyDJZJAfLXPquKs=;
 b=ea0P8ZJNI9YZH6IAXVj2lmI+v7+V2RZtXPTCbNHEEe2PfwpX+uudXRh4rre69qxkLQUuCf0KMdhqb3raLRdz8c+dOamY613DgRICEp7B/VmTTMmslWZWijHRS7mA4W6r6oX1RPFRkuTjZxrCBuzScNBS8nyHW8MZIlCoW/hagMy2EBsaR1qGLLe0f0usiTjpOCj2QNR0p+tmhceDNGcBnuPO4QymQaYEOErq/62WyUMv1uByESp+7ZTGB1TGKOPCjdnu/AniK3PNOH4ZjzQdPOud3UYIiN5K9gOrTfs+kx+s1vWMXGCK1sn8ZOOw9rEgwnAp9hwQP5CslRW0hc8BGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMPqi8R74ixbaQwgiLZV/ZUGY8QQLyDJZJAfLXPquKs=;
 b=oFWMdmoUVDs4y9GiRnpW5/Qyc3k7XQn5kKC/6/lgvOSJ5c9GoKY3xM3W6i0TmFP3YYLDmpv3USlQ8Na6IpIWCgNjoYmYX9ctCyaT3beTaqE71JfUwwCVxwu1Jr2bnLkt9+vNmVAzNtBWMl+nOlI0rJ0TWEo4yEyxthXCiDzrgD4=
Received: from MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11)
 by CH0PR10MB5195.namprd10.prod.outlook.com (2603:10b6:610:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Wed, 16 Oct
 2024 17:47:38 +0000
Received: from MN2PR10MB4144.namprd10.prod.outlook.com
 ([fe80::b385:3691:3595:ef17]) by MN2PR10MB4144.namprd10.prod.outlook.com
 ([fe80::b385:3691:3595:ef17%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 17:47:38 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Liam Howlett <liam.howlett@oracle.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Pei Li
	<peili.io@oracle.com>
Subject: Re: [PATCH net-next v2 3/3] connector/cn_proc: Selftest for threads
Thread-Topic: [PATCH net-next v2 3/3] connector/cn_proc: Selftest for threads
Thread-Index: AQHbHyfyb3isQmfQUE+MZ3/MYmXKmrKIMjKAgAAhvQCAADOdAIABIRGA
Date: Wed, 16 Oct 2024 17:47:37 +0000
Message-ID: <16D94420-D0C0-4EE1-BE41-7BB63BD18CE6@oracle.com>
References: <20241015173014.1083069-1-anjali.k.kulkarni@oracle.com>
 <20241015173014.1083069-4-anjali.k.kulkarni@oracle.com>
 <36kdqgl425qzoqqbct4jusrzgpcn4cff62jaswcsrc4licalvp@f3okz2ygoww6>
 <B4DCFCF8-BD05-4379-BCAE-DD507D894032@oracle.com>
 <sjvtcbqkewl6n2sh4eukwhj2grcun5outspl2chm3dmlomxgxh@sycexvmnhsn3>
In-Reply-To: <sjvtcbqkewl6n2sh4eukwhj2grcun5outspl2chm3dmlomxgxh@sycexvmnhsn3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4144:EE_|CH0PR10MB5195:EE_
x-ms-office365-filtering-correlation-id: 565e669c-6f6d-4231-fbc5-08dcee0a9fe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RHY5cG9uN0djSTQ1bTV4Vm5DdnM5MWJxRElNY0YrR2J2djlkTUMzKzdZMC9w?=
 =?utf-8?B?NFFpSnM5VTJ6WHlYNmxwaFhiSlI3OHVxMENPQlBKczMvYUNWUUhrNWlmYy8z?=
 =?utf-8?B?VUdKL28vTFptSDJEWU9BakVvaU85QUFESVhzNi82ektGRG5zY2JpMUFib1Y4?=
 =?utf-8?B?TTg2WXdoZk85VmE2bHdncm1GOEVlZFpmZEJvUGZaeHRBbGk5TEExcEZ4dHNG?=
 =?utf-8?B?a1BBUkwzUHo5VHcrZzB5eUluU3JGSlR2VmtZUTNzRjBGUEMyTlNUczlweXB3?=
 =?utf-8?B?MjRoWExUVjVnVmxxd0tzeGR4MFpzRWhRWTB0YzdIcU5CS055NHhqYjhTQnFz?=
 =?utf-8?B?TVREOElVaTMrUFBYR0l3QkMxckFnUHptdE5Oa3RxTnZUSzV5ZHlzaU1rQm5i?=
 =?utf-8?B?Nk5xaktRS3JTYktkanR1bGZkZmtvRElWaU5UWlllaFQvREdrQ1dPemJYVEg0?=
 =?utf-8?B?cURocXQ2ZFhKemdaem9TbW1vZ0J4dHY3NGNvZWNUVE1yZ1pyWGtLdDlWV0dV?=
 =?utf-8?B?NHc4TGFSaGVBN2dBaG8zWjRQSU00Sy9CMmVIZlR2UlhneUlYc2NFc0xuQjhH?=
 =?utf-8?B?V3hSaXJkczZDS0Jub1k0cW1ZSlpzeUxaZ3NyaUovVW9ielhNZTcwYVQ3bXJn?=
 =?utf-8?B?MjYraVZRN3VTT3kvaG1EKzBBS0k5R3Z4VWJ4ODVFVzY4QlN3Y01JZHJEaXdI?=
 =?utf-8?B?c3ZGVnJzN1F0Y1ZmdlRZNGxkalA0VGxQampLMjJ0WkpjSG5nUStCbEY1anRW?=
 =?utf-8?B?ejNjdnFGNHltTTVaZ01RZVZ2VHdyaHR0VUY1eEN4U0lZS2RYVEQ4UDFsNVlK?=
 =?utf-8?B?RllnaXRaWU5UUGlpMUY1Z0N3Q09DUXpEMDE5WHdqVzlqUWJBWE9XaTV0eWJh?=
 =?utf-8?B?bElPRmUwcXByMmkwMUREUmYzUm1xM3BmREZOZjRTU3JkaFF4QmhiZnZxVnhP?=
 =?utf-8?B?M0VZQzdDdHEvdkNCSjh0bjlBbUllclRuTkVwb1M4bkxVSHcyT085L2tLL1Vq?=
 =?utf-8?B?QjJqRCtJQ3ZGMk00YXhiWWtXc3l5SncwWEdXc0dLOVVIUjN4SG9tK1lZMStU?=
 =?utf-8?B?Q1ErNVZXTlF1U2l3WFRDZ3NrMi9EdisyNVBiRHBsRitPTW1MRnFQb3VZY0F0?=
 =?utf-8?B?REZnbit6N0pLUG9HSWVtaTkyTE5ZTlRpS25Xek82enhOZEdXWXREaFl3Z1ZT?=
 =?utf-8?B?YTdUOGZ5WVlHYU1CYkRpTGVSM1hLam5ET1k4V3ZzSUU3YUlsc3YxaEFoaFZk?=
 =?utf-8?B?c1VxcktlakNOQjYxYmVjSlZDd3p2WjdiUzdCeDlCai9YNlE4ZTN0cm5DVGJz?=
 =?utf-8?B?Zit3ZlZCd3pOWHJGMmhMT3l0Q2JFUU5hcTRydUV4MTJEOVpkS1FlTXU5a2N1?=
 =?utf-8?B?T1paRksxNGg1cmowTFcxYmcrZDdCc0c2bCtIVFpaVERvN0U1ZGJhbmxDemk3?=
 =?utf-8?B?ZW1mdUZ1Y1JFdlhZdWc2NWJpLzIyTEx2OWxRRHJiU01oNXA5VHlYaGxhdWti?=
 =?utf-8?B?ZHZuS0xiS1l4MmxmRkZYSTlGYzdzYzU5RStRclZOcExWdnRzS3JTdFFHYmlT?=
 =?utf-8?B?dDg0U2w5MC84b0h2SkVuQm8xL2kvczlDc3NzM0hNMVFKV2V0Z1l3SFlwdEZq?=
 =?utf-8?B?cllVZUdXU0Ntd1FFYTVWR3hCdnd5azI3OGhyMHRDYXpHOGkvZWlJYVhpSS8x?=
 =?utf-8?B?QjZHdEhrMXVhTy9pZzIwVHhDU0xUOW1MU0Q2a0lOWW12anhVTllDMFVvOHRB?=
 =?utf-8?B?WFRNcGJmcGIyb1IwdEdwNm9YVGVDaDZpd0pPdTREZTNsYTdiVi92dXZxOWEy?=
 =?utf-8?B?Ty9qWmdMQmVXTjJnRWRCUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4144.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3ZRaHJnS3B2MlFkYmZDTDR0WWFrV0FUVWJwSUtaL3NFQkcvdHV2NFltTmll?=
 =?utf-8?B?ODczQnd6Z3FNTGkwNWU0bFBqc1ZEVlpUQUdqMWRJWlhacTVVbUdsM2tZck5M?=
 =?utf-8?B?clp1N0RSaVV1U3VhUHRQTjVCUlRpMml0VFFIUzhtcHNBZ2xyeWdpYTl6KzBj?=
 =?utf-8?B?Sld0K2E5bUNNcXMvNm1SSWpSZjdVVnR0bmw5WXByaEZZVVUraGx6U2NCbW1B?=
 =?utf-8?B?cVpYcG9neFU0NVhnWEVEM1RTenJMcTZ1QVJrT1h3MGhjaWgyNmkwSGpjY29N?=
 =?utf-8?B?dlQ5ekRQV1Zjd3h2NFc5TkVXOEhXY0VTWFZ0aUJMb0Z5NlpGczRxc1lHdUZQ?=
 =?utf-8?B?UnVLZHhyWFJEY3hrbm16UnhvcnFkZFZDZ3EyZzQ5M00yUVZzR2pDV21xQlBU?=
 =?utf-8?B?TUZXQUMzMzYwendma0pTSHRqQXNuTTZlUERhVkJpOFpGMGsyZlU1NFRYTE1i?=
 =?utf-8?B?RkNTbi9mVmdRSXpQSTFmY1RselVkY1pWWlVnSWIzZktuN3dlQ3Rka0p0RTMr?=
 =?utf-8?B?aWYrb2lnYmt6UGZ4MThZeldlYUpsaUVYWGZPLy9nYTRXRW4vb3B4cGVwMzA2?=
 =?utf-8?B?Nis3OW9NUnQvTHJtR2s3aVF0cnhPN0hqeGRONmtJcVdhb3hXRjdwR016VUVt?=
 =?utf-8?B?TGRwQlE1L25nSk5MbmZENCtERWlsSzg5SXFtdDY2YkpzUVovVThlMVM5WkFo?=
 =?utf-8?B?U0owQTlLZG96UkZ2bzJWQ052OW9hMzdpeTRFREMvdHNOQkNKS2pXeVVyN2lh?=
 =?utf-8?B?c0x3TmE1bGxiNWlKOFFHZjIxeWhuS0RpazVnRXdKMTRIUGk4K3VCZmQzMEhr?=
 =?utf-8?B?VmdXVXNwTE5QQitvUXZ2UlNKRkRzL1RmWjQrYTQzWGMyVnZ4cFFvdEZLUnlZ?=
 =?utf-8?B?bWJHY2F6L1VqT3RFNjI5TkM4czBQNUNXMEEvblI0bVJ3RnZFWGZWRWRHTjYv?=
 =?utf-8?B?RUthM21xOXRVVmhVdVZXbm92b2R3ZFlNWmQzUnlUdFFnTEQxL21xWTFCVWpJ?=
 =?utf-8?B?SGgvYnp1Z0MrakJPRFZzS3R5eStyQytUYkI0Z04xOWNLTVdTQnRMYkxtMzd6?=
 =?utf-8?B?dmpjVnR3d0RDMmZTZW9iSXNLL3Y1S0YwMzBENyttSFlYblFWamkzTUJoVXl6?=
 =?utf-8?B?YXZ1M2thaEFnOUlUMHhaWmRZZWg2djFRdlN4bkU4MWF0cGJRUXBnQzA5WUk3?=
 =?utf-8?B?OU1VRUJPWjJtRDJ2WXZUU3o0MG9Kc2ZrNGxyRjRhYzJ3TGxoTWJTaS9kcklV?=
 =?utf-8?B?Um9MTXVRNWhENDVHeXduZEg2L09MT2QyWUNKYlBCTXJHaHV0VE5jUmhhVVJO?=
 =?utf-8?B?MFBQZm9KWHg0TUxwMjhrYS9BUkVLT0RsY1VqMkZmNEVMTVFYUHNIa2NsUUxt?=
 =?utf-8?B?ZHA4QVVwa0Y3QmhwZjhUL1VxeDZrRmw3SnNrSXVkNnJnb1pUWmN4clo3b2lm?=
 =?utf-8?B?Wnc3ZFhMOW9BWUtNbFdxd2JicGQ5T1BsVzNLRlNjbE1PM2xGZTNOZmVNYkho?=
 =?utf-8?B?RkFmS25pT3E0cWNVbHRFVkRGb05TM0N5T0Z4alV3RkpNWE9RdkZ3a1EzbWVI?=
 =?utf-8?B?ZjQ4U3l3QWM0MUhsdUNZcW80QkpLUytYUTVIZmJ5Tmo2eTJ3V3BVdldXblYr?=
 =?utf-8?B?akJpVFpQMHFoVGVZaHdwOXJiaXIyY1lmdlA4d255cHQ2bHZYK1M2dkt3cmE3?=
 =?utf-8?B?T2s5VHZTUDVVVVczVDFjb0ZzbnFpb3hiZXcxQm8zNEVKYVZmUGNBMTRJWVA4?=
 =?utf-8?B?TGdRZW9jeEk5bXBNVFJVdjJ0c3hvTkZnOTI2UmtuTnZJYU9zUVRmN2psbWVS?=
 =?utf-8?B?elNIUWxhZU5NYW9YVml2SWNMeVJMay9HTVptSzhhVGFWcDZZOUFSdEhMS0cx?=
 =?utf-8?B?bWFjYTVKZkE4MFNmZ0F2endzeEVrVHZsajZRVFBNaEtUSEs3WVhZeGVnSUNQ?=
 =?utf-8?B?dFdXNlZPS2VqTyt2bUtxSWNwNUMwRUFVVFNPTytVbVRpTnhZa1hDaW85c3dm?=
 =?utf-8?B?c1FoMGkzVEE3cjJYaGc0SzJYdHdlZzA0d3V4Y2doOTdsbmdhejBlNmZJb0ZR?=
 =?utf-8?B?dm1nRktGSVZZc1FSTkFvbU0xMlVoQnIrSTJNNWV3ZStEanA0OHE3blN2Ykdp?=
 =?utf-8?B?U1dzRmhoMnI4NUhXRVJKaWJxaVZIYmhGQWdyWitxUXJUR3MvMUhsd0ZFZTRo?=
 =?utf-8?Q?cw4XBPReJDhajBXaFFP2ToPyB+mn8g2/p2Ss+D5D3uTe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26D18FB1812BC34DA8877E71B32D3130@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xspEZ1UoAugllpCk++rMjLf4PDmdA35HM9JIWkUjKnMmwlBBMPuwjx5ttW5VG5lnGvZbqw5LXzetDEId9ksK32JGIva5CA5ZtPR/r1fM1ivnHivlP6MKG7S1Jwj5XZFzdsotnfzBOVKOS3HXHokOb5cbTujRVdDp8z0vBCbm7+JOf9l4073eImcA8ICDqc2pxoG/2+hM2g5SypVkPGbZfBOk0EaZlbfMD04D3ik5Zx2cyJ9eo1puTZiBFKWRAR06CZaMHNcxJr0PTxpvoQ5VkLxHsjFz4KLJOA39n70gKJY6MWVEASIP7sgiW7sWbyFmfKuRKp6cusyJlc3QBygNQOI1JkcLGN9i3QRD6Z5HeRc59Fr71HLFuS24oxS0iI32tUGtrfWp4FiZJ95NujPyTl6gTuIrXrHYCfGKgNZVpfcqF/KvAt/tBvSSTLhFeh585OEc3XPyvST3EPlBmCl4x5Hzjceob2+tkrDjKp96BOsjxtdzbk0Pv0l8trJurmicpRuO80nYbUNLROVB38cgdqXBKLifCZ7c7MMFMhHrT9kdxcCaE5yisDzeltjo4CXQwcWVmsMgpuXQwzH6bQwE78qwsHmdO770ELG0x4PxIm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4144.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565e669c-6f6d-4231-fbc5-08dcee0a9fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 17:47:37.9053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siGGRagfNEZKZx4g7zcNZBdrasIkdw1w8K/vQwFE8Pg+JdjI2HhRA63arnanRa9WFXbUjMBFuti8IoQu2ZUr8biTizpybfmCS9LipMvM8rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_13,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160114
X-Proofpoint-GUID: tOp0Cj9_myFZyh4BYhfsHXl7LsFWUCHg
X-Proofpoint-ORIG-GUID: tOp0Cj9_myFZyh4BYhfsHXl7LsFWUCHg

DQoNCj4gT24gT2N0IDE1LCAyMDI0LCBhdCA1OjMy4oCvUE0sIExpYW0gSG93bGV0dCA8bGlhbS5o
b3dsZXR0QG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gKiBBbmphbGkgS3Vsa2FybmkgPGFuamFs
aS5rLmt1bGthcm5pQG9yYWNsZS5jb20+IFsyNDEwMTUgMTc6MjhdOg0KPj4gDQo+PiANCj4+PiBP
biBPY3QgMTUsIDIwMjQsIGF0IDEyOjI34oCvUE0sIExpYW0gSG93bGV0dCA8bGlhbS5ob3dsZXR0
QG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+ICogQW5qYWxpIEt1bGthcm5pIDxhbmphbGku
ay5rdWxrYXJuaUBvcmFjbGUuY29tPiBbMjQxMDE1IDEzOjMwXToNCj4+Pj4gVGVzdCB0byBjaGVj
ayBpZiBzZXR0aW5nIFBST0NfQ05fTUNBU1RfTk9USUZZIGluIHByb2MgY29ubmVjdG9yIEFQSSwg
YWxsb3dzDQo+Pj4+IGEgdGhyZWFkJ3Mgbm9uLXplcm8gZXhpdCBzdGF0dXMgdG8gYmUgcmV0dXJu
ZWQgdG8gcHJvY19maWx0ZXIuDQo+Pj4+IA0KPj4+PiBUaGUgdGhyZWFkcy5jIHByb2dyYW0gY3Jl
YXRlcyAyIGNoaWxkIHRocmVhZHMuIDFzdCB0aHJlYWQgaGFuZGxlcyBzaWduYWwNCj4+Pj4gU0lH
U0VHViwgYW5kIDJuZCB0aHJlYWQgbmVlZHMgdG8gaW5kaWNhdGUgc29tZSBlcnJvciBjb25kaXRp
b24gKHZhbHVlIDEpDQo+Pj4+IHRvIHRoZSBrZXJuZWwsIGluc3RlYWQgb2YgdXNpbmcgcHRocmVh
ZF9leGl0KCkgd2l0aCAxLg0KPj4+PiANCj4+Pj4gSW4gYm90aCBjYXNlcywgY2hpbGQgc2VuZHMg
bm90aWZ5X25ldGxpbmtfdGhyZWFkX2V4aXQoZXhpdF9jb2RlKSB0byBrZXJuZWwsDQo+Pj4+IHRv
IGxldCBrZXJuZWwga25vdyBpdCBoYXMgZXhpdGVkIGFibm9ybWFsbHkgd2l0aCBleGl0X2NvZGUu
DQo+Pj4+IA0KPj4+PiBDb21waWxlOg0KPj4+PiAgIG1ha2UgdGhyZWFkDQo+Pj4+ICAgbWFrZSBw
cm9jX2ZpbHRlcg0KPj4+PiBUbyBzZWUgbm9uLXplcm8gZXhpdCBub3RpZmljYXRpb25zLCBydW46
DQo+Pj4+ICAgLi9wcm9jX2ZpbHRlciAtZg0KPj4+PiBSdW4gdGhyZWFkcyBjb2RlIGluIGFub3Ro
ZXIgd2luZG93Og0KPj4+PiAgIC4vdGhyZWFkcw0KPj4+PiBOb3RlIHRoZSAyIGNoaWxkIHRocmVh
ZCBJRHMgcmVwb3J0ZWQgYWJvdmUNCj4+Pj4gU2VuZCBTSUdTRUdWIHNpZ25hbCB0byB0aGUgY2hp
bGQgaGFuZGxpbmcgU0lHU0VHVjoNCj4+Pj4gICBraWxsIC0xMSA8Y2hpbGQxLXRpZD4NCj4+Pj4g
V2F0Y2ggdGhlIGNoaWxkIDEgdGlkIGJlaW5nIG5vdGlmaWVkIHdpdGggZXhpdCBjb2RlIDExIHRv
IHByb2NfZmlsdGVyDQo+Pj4+IFdhdGNoIGNoaWxkIDIgdGlkIGJlaW5nIG5vdGlmaWVkIHdpdGgg
ZXhpdCBjb2RlIDEgKHZhbHVlIGRlZmluZWQgaW4gY29kZSkNCj4+Pj4gdG8gcHJvY19maWx0ZXIN
Cj4+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuamFsaSBLdWxrYXJuaSA8YW5qYWxpLmsua3Vs
a2FybmlAb3JhY2xlLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nvbm5lY3Rvci9NYWtlZmlsZSAgICB8ICAyMyArKystDQo+Pj4+IC4uLi90ZXN0aW5nL3NlbGZ0
ZXN0cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYyB8ICAgNSArDQo+Pj4+IHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Nvbm5lY3Rvci90aHJlYWQuYyAgICB8IDExNiArKysrKysrKysrKysrKysrKysN
Cj4+Pj4gLi4uL3NlbGZ0ZXN0cy9jb25uZWN0b3IvdGhyZWFkX2ZpbHRlci5jICAgICAgIHwgIDk2
ICsrKysrKysrKysrKysrKw0KPj4+PiA0IGZpbGVzIGNoYW5nZWQsIDIzOSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9jb25uZWN0b3IvdGhyZWFkLmMNCj4+Pj4gY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci90aHJlYWRfZmlsdGVyLmMNCj4+Pj4gDQo+Pj4+
IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvTWFrZWZpbGUg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvTWFrZWZpbGUNCj4+Pj4gaW5kZXgg
OTIxODhiOWJhYzVjLi5iZjMzNTgyNmJjM2IgMTAwNjQ0DQo+Pj4+IC0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9NYWtlZmlsZQ0KPj4+PiArKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9jb25uZWN0b3IvTWFrZWZpbGUNCj4+Pj4gQEAgLTEsNSArMSwyNiBAQA0KPj4+
PiAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+Pj4+IC1DRkxBR1MgKz0gLVdh
bGwgJChLSERSX0lOQ0xVREVTKQ0KPj4+PiArS0VSTkVMPSIuLi8uLi8uLi8uLiINCj4+Pj4gKw0K
Pj4+PiArQ0ZMQUdTICs9IC1XYWxsICQoS0hEUl9JTkNMVURFUykgLUkgJChLRVJORUwpL2luY2x1
ZGUvdWFwaSAtSSAkKEtFUk5FTCkvaW5jbHVkZQ0KPj4+PiArDQo+Pj4+ICtwcm9jX2ZpbHRlcjog
cHJvY19maWx0ZXIubw0KPj4+PiArIGNjIHByb2NfZmlsdGVyLm8gLW8gcHJvY19maWx0ZXINCj4+
Pj4gKw0KPj4+PiArcHJvY19maWx0ZXIubzogcHJvY19maWx0ZXIuYw0KPj4+PiArIGNjIC1jIHBy
b2NfZmlsdGVyLmMgLW8gcHJvY19maWx0ZXIubyAkKENGTEFHUykNCj4+Pj4gKw0KPj4+PiArdGhy
ZWFkOiB0aHJlYWQubyB0aHJlYWRfZmlsdGVyLm8NCj4+Pj4gKyBjYyB0aHJlYWQubyB0aHJlYWRf
ZmlsdGVyLm8gLW8gdGhyZWFkDQo+Pj4+ICsNCj4+Pj4gK3RocmVhZC5vOiB0aHJlYWQuYyAkKERF
UFMpDQo+Pj4+ICsgY2MgLWMgdGhyZWFkLmMgLW8gdGhyZWFkLm8gJChDRkxBR1MpDQo+Pj4+ICsN
Cj4+Pj4gK3RocmVhZF9maWx0ZXIubzogdGhyZWFkX2ZpbHRlci5jDQo+Pj4+ICsgY2MgLWMgdGhy
ZWFkX2ZpbHRlci5jIC1vIHRocmVhZF9maWx0ZXIubyAkKENGTEFHUykNCj4+Pj4gKw0KPj4+PiAr
ZGVmaW5lIEVYVFJBX0NMRUFODQo+Pj4+ICsgcm0gKi5vIHRocmVhZA0KPj4+PiArZW5kZWYNCj4+
Pj4gDQo+Pj4+IFRFU1RfR0VOX1BST0dTID0gcHJvY19maWx0ZXINCj4+Pj4gDQo+Pj4+IGRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jDQo+Pj4+IGlu
ZGV4IDRhODI1Yjk5NzY2Ni4uNmZiNDg0Mjg5NGY4IDEwMDY0NA0KPj4+PiAtLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYw0KPj4+PiArKysgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYw0KPj4+PiBAQCAtMSw0
ICsxLDkgQEANCj4+Pj4gLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0K
Pj4+PiArLyoNCj4+Pj4gKyAqIEF1dGhvcjogQW5qYWxpIEt1bGthcm5pIDxhbmphbGkuay5rdWxr
YXJuaUBvcmFjbGUuY29tPg0KPj4+PiArICoNCj4+Pj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBP
cmFjbGUgYW5kL29yIGl0cyBhZmZpbGlhdGVzLg0KPj4+PiArICovDQo+Pj4+IA0KPj4+PiAjaW5j
bHVkZSA8c3lzL3R5cGVzLmg+DQo+Pj4+ICNpbmNsdWRlIDxzeXMvZXBvbGwuaD4NCj4+Pj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci90aHJlYWQuYyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci90aHJlYWQuYw0KPj4+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjhjOWFiZjYxMTVkNg0KPj4+PiAt
LS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rv
ci90aHJlYWQuYw0KPj4+PiBAQCAtMCwwICsxLDExNiBAQA0KPj4+PiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPj4+PiArLyoNCj4+Pj4gKyAqIEF1dGhvcjogQW5q
YWxpIEt1bGthcm5pIDxhbmphbGkuay5rdWxrYXJuaUBvcmFjbGUuY29tPg0KPj4+PiArICoNCj4+
Pj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBPcmFjbGUgYW5kL29yIGl0cyBhZmZpbGlhdGVzLg0K
Pj4+PiArICovDQo+Pj4+ICsNCj4+Pj4gKyNpbmNsdWRlIDxwdGhyZWFkLmg+DQo+Pj4+ICsjaW5j
bHVkZSA8c3RkaW8uaD4NCj4+Pj4gKyNpbmNsdWRlIDx1bmlzdGQuaD4NCj4+Pj4gKyNpbmNsdWRl
IDxzdGRsaWIuaD4NCj4+Pj4gKyNpbmNsdWRlIDxzaWduYWwuaD4NCj4+Pj4gKw0KPj4+PiArLyoN
Cj4+Pj4gKyAqIFRoaXMgY29kZSB0ZXN0cyBhIHRocmVhZCBleGl0IG5vdGlmaWNhdGlvbiB3aGVu
IHRocmVhZCBleGl0cyBhYm5vcm1hbGx5Lg0KPj4+PiArICogTm9ybWFsbHksIHdoZW4gYSB0aHJl
YWQgZXhpdHMgYWJub3JtYWxseSwgdGhlIGtlcm5lbCBpcyBub3QgYXdhcmUgb2YgdGhlDQo+Pj4+
ICsgKiBleGl0IGNvZGUuIFRoaXMgaXMgdXN1YWxseSBvbmx5IGNvbnZleWVkIGZyb20gY2hpbGQg
dG8gcGFyZW50IHZpYSB0aGUNCj4+Pj4gKyAqIHB0aHJlYWRfZXhpdCgpIGFuZCBwdGhyZWFkX2pv
aW4oKSBjYWxscy4gU29tZXRpbWVzLCBob3dldmVyLCBhIHBhcmVudA0KPj4+PiArICogcHJvY2Vz
cyBjYW5ub3QgbW9uaXRvciBhbGwgY2hpbGQgcHJvY2Vzc2VzIHZpYSBwdGhyZWFkX2pvaW4oKSwg
cGFydGljdWxhcmx5DQo+Pj4+ICsgKiB3aGVuIHRoZXJlIGlzIGEgaHVnZSBhbW91bnQgb2YgY2hp
bGQgcHJvY2Vzc2VzLiBJbiB0aGlzIGNhc2UsIHRoZSBwYXJlbnQNCj4+Pj4gKyAqIGhhcyBjcmVh
dGVkIHRoZSBjaGlsZCB3aXRoIFBUSFJFQURfQ1JFQVRFX0RFVEFDSEVEIGF0dHJpYnV0ZS4NCj4+
Pj4gKyAqIFRvIGZpeCB0aGlzIHByb2JsZW0sIGVpdGhlciB3aGVuIGNoaWxkIHdhbnRzIHRvIGNv
bnZleSBub24temVybyBleGl0IHZpYQ0KPj4+PiArICogcHRocmVhZF9leGl0KCkgb3IgaW4gYSBz
aWduYWwgaGFuZGxlciwgdGhlIGNoaWxkIGNhbiBub3RpZnkgdGhlIGtlcm5lbCdzDQo+Pj4+ICsg
KiBjb25uZWN0b3IgbW9kdWxlIGl0J3MgZXhpdCBzdGF0dXMgdmlhIGEgbmV0bGluayBjYWxsIHdp
dGggbmV3IHR5cGUNCj4+Pj4gKyAqIFBST0NfQ05fTUNBU1RfTk9USUZZLiAoSW1wbGVtZW50ZWQg
aW4gdGhlIHRocmVhZF9maWx0ZXIuYyBmaWxlKS4NCj4+Pj4gKyAqIFRoaXMgd2lsbCBzZW5kIHRo
ZSBleGl0IGNvZGUgZnJvbSB0aGUgY2hpbGQgdG8gdGhlIGtlcm5lbCwgd2hpY2ggdGhlIGtlcm5l
bA0KPj4+PiArICogY2FuIGxhdGVyIHJldHVybiB0byBwcm9jX2ZpbHRlciBwcm9ncmFtIHdoZW4g
dGhlIGNoaWxkIGFjdHVhbGx5IGV4aXRzLg0KPj4+PiArICogVG8gdGVzdCB0aGlzIHVzZWNhc2U6
DQo+Pj4+ICsgKiBDb21waWxlOg0KPj4+PiArICogbWFrZSB0aHJlYWQNCj4+Pj4gKyAqIG1ha2Ug
cHJvY19maWx0ZXINCj4+Pj4gKyAqIFRvIHNlZSBub24temVybyBleGl0IG5vdGlmaWNhdGlvbnMs
IHJ1bjoNCj4+Pj4gKyAqIC4vcHJvY19maWx0ZXIgLWYNCj4+Pj4gKyAqIFN0YXJ0IHRoZSB0aHJl
YWRzIGNvZGUsIGNyZWF0aW5nIDIgdGhyZWFkcywgaW4gYW5vdGhlciB3aW5kb3c6DQo+Pj4+ICsg
KiAuL3RocmVhZHMNCj4+Pj4gKyAqIE5vdGUgdGhlIDIgY2hpbGQgdGhyZWFkIElEcyByZXBvcnRl
ZCBhYm92ZQ0KPj4+PiArICogU2VuZCBTSUdTRUdWIHNpZ25hbCB0byB0aGUgY2hpbGQgaGFuZGxp
bmcgU0lHU0VHVjoNCj4+Pj4gKyAqIGtpbGwgLTExIDxjaGlsZDEtdGlkPg0KPj4+PiArICogV2F0
Y2ggdGhlIGV2ZW50IGJlaW5nIG5vdGlmaWVkIHdpdGggZXhpdCBjb2RlIDExIHRvIHByb2NfZmls
dGVyDQo+Pj4+ICsgKiBXYXRjaCBjaGlsZCAyIHRpZCBiZWluZyBub3RpZmllZCB3aXRoIGV4aXQg
Y29kZSAxICh2YWx1ZSBkZWZpbmVkIGluIGNvZGUpDQo+Pj4+ICsgKiB0byBwcm9jX2ZpbHRlcg0K
Pj4+PiArICovDQo+Pj4+ICsNCj4+Pj4gK2V4dGVybiBpbnQgbm90aWZ5X25ldGxpbmtfdGhyZWFk
X2V4aXQodW5zaWduZWQgaW50IGV4aXRfY29kZSk7DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyB2b2lk
IHNpZ3NlZ3ZoKGludCBzaWcpDQo+Pj4+ICt7DQo+Pj4+ICsgdW5zaWduZWQgaW50IGV4aXRfY29k
ZSA9ICh1bnNpZ25lZCBpbnQpIHNpZzsNCj4+Pj4gKyAvKg0KPj4+PiArICAqIFNlbmQgYW55IG5v
bi16ZXJvIHZhbHVlIHRvIGdldCBhIG5vdGlmaWNhdGlvbi4gSGVyZSB3ZSBhcmUNCj4+Pj4gKyAg
KiBzZW5kaW5nIHRoZSBzaWduYWwgbnVtYmVyIGZvciBTSUdTRUdWIHdoaWNoIGlzIDExDQo+Pj4+
ICsgICovDQo+Pj4+ICsgbm90aWZ5X25ldGxpbmtfdGhyZWFkX2V4aXQoZXhpdF9jb2RlKTsNCj4+
Pj4gK30NCj4+Pj4gKw0KPj4+PiArdm9pZCAqdGhyZWFkYzEodm9pZCAqcHRyKQ0KPj4+PiArew0K
Pj4+PiArIHNpZ25hbChTSUdTRUdWLCBzaWdzZWd2aCk7DQo+Pj4+ICsgcHJpbnRmKCJDaGlsZCAx
IHRocmVhZCBpZCAlZCwgaGFuZGxpbmcgU0lHU0VHVlxuIiwgZ2V0dGlkKCkpOw0KPj4+PiArIHNs
ZWVwKDIwKTsNCj4+Pj4gKyBwdGhyZWFkX2V4aXQoTlVMTCk7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+
Pj4gK3ZvaWQgKnRocmVhZGMyKHZvaWQgKnB0cikNCj4+Pj4gK3sNCj4+Pj4gKyBpbnQgZXhpdF92
YWwgPSAxOw0KPj4+PiArDQo+Pj4+ICsgcHJpbnRmKCJDaGlsZCAyIHRocmVhZCBpZCAlZCwgd2Fu
dHMgdG8gZXhpdCB3aXRoIHZhbHVlICVkXG4iLA0KPj4+PiArIGdldHRpZCgpLCBleGl0X3ZhbCk7
DQo+Pj4+ICsgc2xlZXAoMik7DQo+Pj4+ICsgbm90aWZ5X25ldGxpbmtfdGhyZWFkX2V4aXQoZXhp
dF92YWwpOw0KPj4+PiArIHB0aHJlYWRfZXhpdChOVUxMKTsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+
PiAraW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4+PiArew0KPj4+PiArIHB0aHJl
YWRfdCB0aHJlYWQxLCB0aHJlYWQyOw0KPj4+PiArIHB0aHJlYWRfYXR0cl90IGF0dHIxLCBhdHRy
MjsNCj4+Pj4gKyBpbnQgcmV0Ow0KPj4+PiArDQo+Pj4+ICsgcmV0ID0gcHRocmVhZF9hdHRyX2lu
aXQoJmF0dHIxKTsNCj4+Pj4gKyBpZiAocmV0ICE9IDApIHsNCj4+Pj4gKyBwZXJyb3IoInB0aHJl
YWRfYXR0cl9pbml0IGZhaWxlZCIpOw0KPj4+PiArIGV4aXQocmV0KTsNCj4+Pj4gKyB9DQo+Pj4+
ICsgcmV0ID0gcHRocmVhZF9hdHRyX3NldGRldGFjaHN0YXRlKCZhdHRyMSwgUFRIUkVBRF9DUkVB
VEVfREVUQUNIRUQpOw0KPj4+PiArIGlmIChyZXQgIT0gMCkgew0KPj4+PiArIHBlcnJvcigicHRo
cmVhZF9hdHRyX3NldGRldGFjaHN0YXRlIGZhaWxlZCIpOw0KPj4+PiArIGV4aXQocmV0KTsNCj4+
Pj4gKyB9DQo+Pj4+ICsgcmV0ID0gcHRocmVhZF9jcmVhdGUoJnRocmVhZDEsICZhdHRyMSwgKnRo
cmVhZGMxLCBOVUxMKTsNCj4+Pj4gKyBpZiAocmV0ICE9IDApIHsNCj4+Pj4gKyBwZXJyb3IoInB0
aHJlYWRfY3JlYXRlIGZhaWxlZCIpOw0KPj4+PiArIGV4aXQocmV0KTsNCj4+Pj4gKyB9DQo+Pj4+
ICsNCj4+Pj4gKyByZXQgPSBwdGhyZWFkX2F0dHJfaW5pdCgmYXR0cjIpOw0KPj4+PiArIGlmIChy
ZXQgIT0gMCkgew0KPj4+PiArIHBlcnJvcigicHRocmVhZF9hdHRyX2luaXQgZmFpbGVkIik7DQo+
Pj4+ICsgZXhpdChyZXQpOw0KPj4+PiArIH0NCj4+Pj4gKyByZXQgPSBwdGhyZWFkX2F0dHJfc2V0
ZGV0YWNoc3RhdGUoJmF0dHIyLCBQVEhSRUFEX0NSRUFURV9ERVRBQ0hFRCk7DQo+Pj4+ICsgaWYg
KHJldCAhPSAwKSB7DQo+Pj4+ICsgcGVycm9yKCJwdGhyZWFkX2F0dHJfc2V0ZGV0YWNoc3RhdGUg
ZmFpbGVkIik7DQo+Pj4+ICsgZXhpdChyZXQpOw0KPj4+PiArIH0NCj4+Pj4gKyByZXQgPSBwdGhy
ZWFkX2NyZWF0ZSgmdGhyZWFkMiwgJmF0dHIyLCAqdGhyZWFkYzIsIE5VTEwpOw0KPj4+PiArIGlm
IChyZXQgIT0gMCkgew0KPj4+PiArIHBlcnJvcigicHRocmVhZF9jcmVhdGUgZmFpbGVkIik7DQo+
Pj4+ICsgZXhpdChyZXQpOw0KPj4+PiArIH0NCj4+PiANCj4+PiBJIGV4cGVjdGVkIHRoZSB0ZXN0
IHRvIGNoZWNrIGZvciB0aGUgY29ycmVjdCB2YWx1ZSB0byBiZSByZXR1cm5lZD8NCj4+PiBDb3Vs
ZCB5b3UgdXNlIHB0aHJlYWRfam9pbigpIGFuZCB2ZXJpZnkgdGhlIHNhbWUgdmFsdWUgaXMgcmV0
dXJuZWQNCj4+PiB0aHJvdWdoIHRoZSBuZXcgbWVjaGFuaXNtLCBvciB3aWxsIHRoZXkgbm90IG1h
dGNoPw0KPj4gDQo+PiBUaGlzIGlzIGEgbWFudWFsIHRlc3QsIHlvdSBuZWVkIHRvIGNoZWNrIHZp
c3VhbGx5IHRoYXQgdGhlIHByb2NfZmlsdGVyDQo+PiBJcyByZXR1cm5pbmcgY29ycmVjdCB2YWx1
ZXMgZm9yIHRoZSAyIGNhc2VzLiBJIGNhbiBtYWtlIHRoaXMgYW4NCj4+IGF1dG9tYXRlZCB0ZXN0
LCByZWFkaW5nIHRoZSBvdXRwdXQgb2YgcHJvY19maWx0ZXIgZGlyZWN0bHkgZnJvbSBhIGZpbGUN
Cj4+IGFuZCBjaGVja2luZyB0aGUgdmFsdWVzIGFyZSBhcyBleHBlY3RlZC4NCj4+IFRoZXJlIGlz
IGFsc28gYW5vdGhlciB0ZXN0IHByb2dyYW0gd2hpY2ggZG9lcyBhbiBhdXRvbWF0ZWQgdGVzdA0K
Pj4gb2YgdGhlIHZhbHVlcyByZXR1cm5lZCBieSBwcm9jX2ZpbHRlciBmb3Igc2NhbGUgKDEwMGsg
b3Igc28pLCB3aGljaCBJDQo+PiB3aWxsIHNlbmQgb3V0IGxhdGVyLiAoVGhlIGNvLWF1dGhvciBv
ZiB0aGF0IHBhdGNoLCB3aG8gd3JvdGUgdGhlDQo+PiBvcmlnaW5hbCBjb2RlIGZvciBwcm9jZXNz
ZXMsIGlzIGF3YXkgLSBAcGVpbGkuaW9Ab3JhY2xlLmNvbSkNCj4+IHB0aHJlYWRfam9pbigpIGNh
bm5vdCByZXR1cm4gYSB2YWx1ZSB0byB0aGUga2VybmVsLCBzbyB3ZSBjYW5ub3QNCj4+IHVzZSBp
dCB0byB2ZXJpZnkgdGhlIG5ldyBtZWNoYW5pc20uIA0KPiANCj4gDQo+IE9rYXksIGFzIGxvbmcg
YXMgdGhlcmUgaXMgYW4gYXV0b21hdGljIHRlc3QgdGhlbiBpdCdzIHByb2JhYmx5IGZpbmUuDQoN
ClllcywgSSBoYXZlIG1hZGUgdGhlIGN1cnJlbnQgdGVzdCBhdXRvbWF0aWMuIEluIGFkZGl0aW9u
LCB0aGUgDQpzY2FsaW5nIHRlc3QgSSB3aWxsIHN1Ym1pdCBmb3IgcmV2aWV3IGxhdGVyLCB3aGlj
aCBpcyBhbHNvIGF1dG9tYXRpYy4NCg0KPiANCj4+IA0KPj4+IA0KPj4+PiArDQo+Pj4+ICsgLyog
V2FpdCBmb3IgY2hpbGRyZW4gdG8gZXhpdCBvciBiZSBraWxsZWQgKi8NCj4+Pj4gKyBzbGVlcCgz
MCk7DQo+Pj4+ICsgZXhpdCgwKTsNCj4+Pj4gK30NCj4+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci90aHJlYWRfZmlsdGVyLmMgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9jb25uZWN0b3IvdGhyZWFkX2ZpbHRlci5jDQo+Pj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uM2RhNzQwYWE3NTM3DQo+Pj4+IC0tLSAv
ZGV2L251bGwNCj4+Pj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29ubmVjdG9yL3Ro
cmVhZF9maWx0ZXIuYw0KPj4+PiBAQCAtMCwwICsxLDk2IEBADQo+Pj4+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+Pj4+ICsvKg0KPj4+PiArICogQXV0aG9yOiBB
bmphbGkgS3Vsa2FybmkgPGFuamFsaS5rLmt1bGthcm5pQG9yYWNsZS5jb20+DQo+Pj4+ICsgKg0K
Pj4+PiArICogQ29weXJpZ2h0IChjKSAyMDI0IE9yYWNsZSBhbmQvb3IgaXRzIGFmZmlsaWF0ZXMu
DQo+Pj4+ICsgKi8NCj4+Pj4gKw0KPj4+PiArI2luY2x1ZGUgPHN5cy90eXBlcy5oPg0KPj4+PiAr
I2luY2x1ZGUgPHN5cy9lcG9sbC5oPg0KPj4+PiArI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4NCj4+
Pj4gKyNpbmNsdWRlIDxsaW51eC9uZXRsaW5rLmg+DQo+Pj4+ICsjaW5jbHVkZSA8bGludXgvY29u
bmVjdG9yLmg+DQo+Pj4+ICsjaW5jbHVkZSA8bGludXgvY25fcHJvYy5oPg0KPj4+PiArDQo+Pj4+
ICsjaW5jbHVkZSA8c3RkZGVmLmg+DQo+Pj4+ICsjaW5jbHVkZSA8c3RkaW8uaD4NCj4+Pj4gKyNp
bmNsdWRlIDxzdGRsaWIuaD4NCj4+Pj4gKyNpbmNsdWRlIDx1bmlzdGQuaD4NCj4+Pj4gKyNpbmNs
dWRlIDxzdHJpbmdzLmg+DQo+Pj4+ICsjaW5jbHVkZSA8ZXJybm8uaD4NCj4+Pj4gKyNpbmNsdWRl
IDxzaWduYWwuaD4NCj4+Pj4gKyNpbmNsdWRlIDxzdHJpbmcuaD4NCj4+Pj4gKw0KPj4+PiArI2Rl
ZmluZSBOTF9NRVNTQUdFX1NJWkUgKHNpemVvZihzdHJ1Y3Qgbmxtc2doZHIpICsgc2l6ZW9mKHN0
cnVjdCBjbl9tc2cpICsgXA0KPj4+PiArIHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCkpDQo+Pj4+
ICsNCj4+Pj4gKy8qDQo+Pj4+ICsgKiBTZW5kIFBST0NfQ05fTUNBU1RfTk9USUZZIHR5cGUgbm90
aWZpY2F0aW9uIHRvIHRoZSBjb25uZWN0b3IgY29kZSBpbiBrZXJuZWwuDQo+Pj4+ICsgKiBUaGlz
IHdpbGwgc2VuZCB0aGUgZXhpdF9jb2RlIHNwZWNpZmllZCBieSB1c2VyIHRvIHRoZSBjb25uZWN0
b3IgbGF5ZXIsIHNvDQo+Pj4+ICsgKiBpdCBjYW4gc2VuZCBhIG5vdGlmaWNhdGlvbiBmb3IgdGhh
dCBldmVudCB0byBhbnkgbGlzdGVuaW5nIHByb2Nlc3MNCj4+Pj4gKyAqLw0KPj4+PiAraW50IHNl
bmRfbWVzc2FnZShpbnQgbmxfc29jaywgdW5zaWduZWQgaW50IGV4aXRfY29kZSkNCj4+Pj4gK3sN
Cj4+Pj4gKyBjaGFyIGJ1ZmZbTkxfTUVTU0FHRV9TSVpFXTsNCj4+Pj4gKyBzdHJ1Y3Qgbmxtc2do
ZHIgKmhkcjsNCj4+Pj4gKyBzdHJ1Y3QgY25fbXNnICptc2c7DQo+Pj4+ICsNCj4+Pj4gKyBoZHIg
PSAoc3RydWN0IG5sbXNnaGRyICopYnVmZjsNCj4+Pj4gKyBoZHItPm5sbXNnX2xlbiA9IE5MX01F
U1NBR0VfU0laRTsNCj4+Pj4gKyBoZHItPm5sbXNnX3R5cGUgPSBOTE1TR19ET05FOw0KPj4+PiAr
IGhkci0+bmxtc2dfZmxhZ3MgPSAwOw0KPj4+PiArIGhkci0+bmxtc2dfc2VxID0gMDsNCj4+Pj4g
KyBoZHItPm5sbXNnX3BpZCA9IGdldHBpZCgpOw0KPj4+PiArDQo+Pj4+ICsgbXNnID0gKHN0cnVj
dCBjbl9tc2cgKilOTE1TR19EQVRBKGhkcik7DQo+Pj4+ICsgbXNnLT5pZC5pZHggPSBDTl9JRFhf
UFJPQzsNCj4+Pj4gKyBtc2ctPmlkLnZhbCA9IENOX1ZBTF9QUk9DOw0KPj4+PiArIG1zZy0+c2Vx
ID0gMDsNCj4+Pj4gKyBtc2ctPmFjayA9IDA7DQo+Pj4+ICsgbXNnLT5mbGFncyA9IDA7DQo+Pj4+
ICsNCj4+Pj4gKyBtc2ctPmxlbiA9IHNpemVvZihzdHJ1Y3QgcHJvY19pbnB1dCk7DQo+Pj4+ICsg
KChzdHJ1Y3QgcHJvY19pbnB1dCAqKW1zZy0+ZGF0YSktPm1jYXN0X29wID0NCj4+Pj4gKyBQUk9D
X0NOX01DQVNUX05PVElGWTsNCj4+Pj4gKyAoKHN0cnVjdCBwcm9jX2lucHV0ICopbXNnLT5kYXRh
KS0+dWV4aXRfY29kZSA9IGV4aXRfY29kZTsNCj4+Pj4gKw0KPj4+PiArIGlmIChzZW5kKG5sX3Nv
Y2ssIGhkciwgaGRyLT5ubG1zZ19sZW4sIDApID09IC0xKSB7DQo+Pj4+ICsgcGVycm9yKCJzZW5k
IGZhaWxlZCIpOw0KPj4+PiArIHJldHVybiAtZXJybm87DQo+Pj4+ICsgfQ0KPj4+PiArIHJldHVy
biAwOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtpbnQgbm90aWZ5X25ldGxpbmtfdGhyZWFkX2V4
aXQodW5zaWduZWQgaW50IGV4aXRfY29kZSkNCj4+Pj4gK3sNCj4+Pj4gKyBzdHJ1Y3Qgc29ja2Fk
ZHJfbmwgc2Ffbmw7DQo+Pj4+ICsgaW50IGVyciA9IDA7DQo+Pj4+ICsgaW50IG5sX3NvY2s7DQo+
Pj4+ICsNCj4+Pj4gKyBubF9zb2NrID0gc29ja2V0KFBGX05FVExJTkssIFNPQ0tfREdSQU0sIE5F
VExJTktfQ09OTkVDVE9SKTsNCj4+Pj4gKw0KPj4+PiArIGlmIChubF9zb2NrID09IC0xKSB7DQo+
Pj4+ICsgcGVycm9yKCJzb2NrZXQgZmFpbGVkIik7DQo+Pj4+ICsgcmV0dXJuIC1lcnJubzsNCj4+
Pj4gKyB9DQo+Pj4+ICsNCj4+Pj4gKyBiemVybygmc2FfbmwsIHNpemVvZihzYV9ubCkpOw0KPj4+
PiArIHNhX25sLm5sX2ZhbWlseSA9IEFGX05FVExJTks7DQo+Pj4+ICsgc2FfbmwubmxfZ3JvdXBz
ID0gQ05fSURYX1BST0M7DQo+Pj4+ICsgc2FfbmwubmxfcGlkICAgID0gZ2V0dGlkKCk7DQo+Pj4+
ICsNCj4+Pj4gKyBpZiAoYmluZChubF9zb2NrLCAoc3RydWN0IHNvY2thZGRyICopJnNhX25sLCBz
aXplb2Yoc2FfbmwpKSA9PSAtMSkgew0KPj4+PiArIHBlcnJvcigiYmluZCBmYWlsZWQiKTsNCj4+
Pj4gKyBjbG9zZShubF9zb2NrKTsNCj4+Pj4gKyByZXR1cm4gLWVycm5vOw0KPj4+PiArIH0NCj4+
Pj4gKw0KPj4+PiArIGVyciA9IHNlbmRfbWVzc2FnZShubF9zb2NrLCBleGl0X2NvZGUpOw0KPj4+
PiArDQo+Pj4+ICsgY2xvc2Uobmxfc29jayk7DQo+Pj4+ICsNCj4+Pj4gKyBpZiAoZXJyIDwgMCkN
Cj4+Pj4gKyByZXR1cm4gZXJyOw0KPj4+PiArDQo+Pj4+ICsgcmV0dXJuIDA7DQo+Pj4+ICt9DQo+
Pj4+IC0tIA0KPj4+PiAyLjQ2LjANCg0KDQo=

