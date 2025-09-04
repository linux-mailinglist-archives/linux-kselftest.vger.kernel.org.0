Return-Path: <linux-kselftest+bounces-40783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA72CB43EC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 16:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2D583456
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D1307AF7;
	Thu,  4 Sep 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y0Q4uD9M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ly+ytzfV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3A30BB98;
	Thu,  4 Sep 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996010; cv=fail; b=fenbKp6RY1JPgFzH6iDn6kp/iQPE4EfxfoOJ8NiYuKLbjY+EeDEFgkHjjWfmbzCPj0wpqgx+LfJN+9MVLTPamEawcx/7eefdQE9OBX/03ctMMnOb0T71hUxXvLDOdeQuafHqHhBaD6iTwcj2O1+mkZgs61S05dKUa6pLo3tBoOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996010; c=relaxed/simple;
	bh=qYl/K28iaulkmvrJASNPc0TCglwDaAHFnH2ICAmsLhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ygkhi3Kn9wzEukMMX39Gc8HFYvlrr8sq1Pv8G/FKq7idYr38Vl/1VaGKTB3aSNOzHfN7hydgukyTwv0CHcjj7tdh+ql0ji3wAw5/24a+/PW1bD087pakUJgAuX5p5nkETKtNSsul0Dnf+JSUB41DjEq8p2oB+tuGoInicgUJj9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y0Q4uD9M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ly+ytzfV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584E9om5020722;
	Thu, 4 Sep 2025 14:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sxatTaYcbSGGO9158lPNrWklVN9tN+IX0TObd/KT0Zo=; b=
	Y0Q4uD9MRhb9Ba/w6D1O3vysilHNU6tw8W398IGbKW/WvOCVR5GVP3FinAJN6u9s
	Q3AI4u3b164YWDgK+qqs9v+S+ja8HVFsszbMfkhFv56V9wGE2lyh1y1qO5ZGR6wb
	eo6xYb/y1lP9O7gRtNjPNDZN4gliDml2Vx14o7QJVHXmIqjf1gsnGkayz9eDfIb2
	C4bviQNMxSOBmu5xY7gO7VybcIltCngjFx2ZDfI7GLrFENSyemBYsUPR2fe6KfWH
	uaOms0hKG8+EF5kDILwP+MzGPTC9B1NwnC1rOiy4gA1I0cTVa6RAOlOZBG6SdMdQ
	mB6AGBEI9Df/l2D3FLXP3g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yc9m817x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:26:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584D45LI040672;
	Thu, 4 Sep 2025 14:26:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbccnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 14:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HR2BLpTnLicqOiIG7vZQXILIzuVUojjzkwF5axA2135ZNWsv01MQgQaPJX+0gXsD1Xzu/iF+epUuVih2DWE81ghafXQY6fngK06OXFSrC9AK3EGtKoRThxxui+gr9rDNP7JBxW3SRkbc6VLW8J6x164X4tYRtyyb1QEIhYU+l61J8etCoEYciW9wZrI9TNSFYfN7qgMT+PNTZ7ttSAezbedswqNDLD9Mv7J6409OyLjNRNFLZNeh2syzkkH3jOSImg7bKklMLEet9UFuUF1BQqQwscRiuRC7bQihME7Bn8tE/zokmTRSnvjCMsRwMv4NVCGja5anetWfowesogbkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxatTaYcbSGGO9158lPNrWklVN9tN+IX0TObd/KT0Zo=;
 b=lApmi2nuR5NRAbHZsM2xAOwQo2LvzMT4f/M4kmTchg9j83qCiGm8UvybuaAZp3jyBgW5Kykqr4CmT6pJbqLIzl2rVFlrF6yQhc44hVRECVOvwnstglh59gblT4+aJn3ogMTWZsVnucgC1ZXgD5kXIQ+tUFgBDfbRcKW8PVx60QfKvhvVkdvB52lK8EkgdGfIPeqV1IUy5IX7q+dbIWlt7JP97v6GxbWXqFJTQ2TY4dgEh1PDbu3DrXij3tP8d1PKwP6ULuci9sJgFZXe6MmootDFuoOqUC+IYYNFHB2T3tbIEAH4hADVOoDSQ06LoXgGd9+sNEgvY5DJ7jB1lbY98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxatTaYcbSGGO9158lPNrWklVN9tN+IX0TObd/KT0Zo=;
 b=ly+ytzfVdKkvugYS39vzaArYsbkQRfyGC3P8C00u1IQwUHvIrSnziRQmFzwG6phVzhQsi6NvlDc7hVPgVYwIR7n5+VXzCbPpipTMELPUStNnTQJXN+wdu7TBpmUP8nOaVU0mzDB2MUFGmg6Y4DSAZitZtKi8tXP3k+Hhk2QKiUQ=
Received: from SA1PR10MB5509.namprd10.prod.outlook.com (2603:10b6:806:1f5::20)
 by DM3PR10MB7972.namprd10.prod.outlook.com (2603:10b6:0:43::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.29; Thu, 4 Sep 2025 14:26:35 +0000
Received: from SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24]) by SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24%3]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 14:26:35 +0000
Message-ID: <21b618d5-7f6c-4b06-81be-eea6cbac5ba6@oracle.com>
Date: Thu, 4 Sep 2025 08:26:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
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
Content-Language: en-US
From: Tom Hromatka <tom.hromatka@oracle.com>
In-Reply-To: <CAADnVQJSgcAjEnU-A9bF6-9MQRFvbHqRsCCY7a0Y6bhVGtcGpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:930:d0::18) To SA1PR10MB5509.namprd10.prod.outlook.com
 (2603:10b6:806:1f5::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5509:EE_|DM3PR10MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3ed608-ab65-4c20-d63b-08ddebbf0cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmx2QThGVTl1NjRNaWIxOHBVMG90Rzh6UkdLeDJQUmNuZG1kSms0ZEwycmFB?=
 =?utf-8?B?VFREVEdQenNXanFkT01LeGFiYUM3VzMxOW5GRDhXMzlySEVydXUvSWE5aTlV?=
 =?utf-8?B?NmdtWExuZ3R3NW9OdE9mdHpMcnJQUFFrMjQ4eWVYQW55bFZ6aWNKNzJEYUI5?=
 =?utf-8?B?LzFKWEIzUEVhTHlhV0xYRTJMSzd6aGo4NFFRbjVjMWN6cE53eXpXWDdBQUVu?=
 =?utf-8?B?OTNnQVQwR2dJb3BaK1B3bWoxVUhidkdUUjVkRVdZMC9sQVduakl5TytmdGM2?=
 =?utf-8?B?RHEvSG8rSmd1aUZmak54aXRVZXFWUEIrZ2d0d3F2T0tzdG04dXM2bGxkeWY0?=
 =?utf-8?B?Szg1NlRtWW1McWl2NDRlMDVScDlDZ3REdkhHcE81RUZoditxZUs2NVhEL0hC?=
 =?utf-8?B?VXoyV2VUWXFDeTVIQmlwYkdJdHpvcjhaWUZIYUplQXVBclpFWFJCQnEvZy9L?=
 =?utf-8?B?YkFZSlBxSS9rV2RlQU4vVlVtSFJCZzRRblg3bmtJODhDU3JlWUtFUk9Dam5m?=
 =?utf-8?B?T3FYRGpTRStOdzRhb3BGa1RuMktKdExYb1o0dlFRUDRNWjlHSmVoNjBXVmt4?=
 =?utf-8?B?dWZFVWc2Unh4aTNCVTFwNnUvakZTUzJkMGJ0ck9sSEY2amZlWUpkazNKYkd0?=
 =?utf-8?B?bTJScEV4OUg2ZExROGpGdXlocUtyVy94Y21EaS9IR0Q3T1kwdG9QNjJNUzVY?=
 =?utf-8?B?T003WjJ1dWxVcVgzUGhrUElnSWpSOUtiZjQzRnc4Nnk2QlgvbVFEWVBWUnFL?=
 =?utf-8?B?dm9Ua3FRYlZQMGFxS0dtanZPVlNhQ25DbHlqOHRVUTkzc1hKbXN1dnZycGdw?=
 =?utf-8?B?UU1SemdYTUxFYmdmU1dWSjVmUHpNMi8ySGhlcG9lQ25URmpwVzl1MncvME5E?=
 =?utf-8?B?SWExcFZOT1lRa0x1Q3MvQjZqVGdEaUM4bnVqYklFUGc0bFVhcmdwRjdGbmFW?=
 =?utf-8?B?dldNWjhtKzRaLy9CdTIvclQ3NkxKdEJxNDZyZlNzZkZVM1ZhVGFPdm9qQmlw?=
 =?utf-8?B?NVB5ZmVYMHY4VUdaRzdmLzdNM3U1d3cyZ29IZEcyTEJTaVBpTDR4N1FVa016?=
 =?utf-8?B?UnhYaUxQRGUxQVR4SE1mdmJUSVlrdUZ5eHg0V2s5MVN1YnVLYWxwRkh6OGM1?=
 =?utf-8?B?ZWRsZWJtQllaQTRJQnlCMVkxM3dLTmcwb09VOS9pNWZpYU1OenI0TENoRmNB?=
 =?utf-8?B?SUhvY0xDbFplMWNiRmI4bjhmTnprUVdYRXFsSWQ0MXNxL3BJMzFReGVndkJD?=
 =?utf-8?B?VVdhTHY2Q00yejYrVUNyaGtxRFBIbjBpUlRtSnZQMDdoWklXcDg2Yld0aFZm?=
 =?utf-8?B?UmpDZ3hnSTRxUy9HOFY3blVKbUM1blRmYlVjWUsxOW51SnlNSzl4WmVtckNY?=
 =?utf-8?B?eFRRRWpBMFJQWmxzZ1ZzdGZIczQ3YlVpRThZVVJkNktheHRNWFhYeUxJR3ZF?=
 =?utf-8?B?Nk0vWFkrWWZYRVF2WUhrZWtnRXNXK2NZcW5rMXpnc2FPSmc4ejhTYy9CYkxq?=
 =?utf-8?B?bVZNeWdxMmM3Mmcyd21zRUJBWmw1a2R2NVRFMWFKQ1JBR2xIWUU2RzRSVDZF?=
 =?utf-8?B?SGJ3OGE2SDZFWEs1QjRyRld3aGxxM3pxMktFeURuOXJlVFd6cTFhZ24rVFdC?=
 =?utf-8?B?aWRybGtHc0VNd0RmVUZ4QTlCdi9hdHU3a0VaWkZKZ2tCdVdpZXZibU96cTJm?=
 =?utf-8?B?eTZOWXd0ZG9nUFVTRGpqZ3hlcVdPanduNEx5bmk0Y295VDZyZWhzTlVlSTRH?=
 =?utf-8?B?ZjdHOFVXNXp5MW5ULzJwRUNmWFp1QUFZWDJhTjZCV2U1aGZyY2FKMkNIWm10?=
 =?utf-8?B?ZEd4TndjcXNXL01aM3Jmb3NPMmgyNjg0Z0Y2YmdYTkFPdkEvVmNjd1JmTUl4?=
 =?utf-8?B?NW5rSmJKN0R6Ump0aXFWWFpYYjdyY1l3bnQ3bmp0ZGxrUXRPOXZFeXE4NG5T?=
 =?utf-8?Q?1HTu3LLBheA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5509.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTBEQ2l6NEQvc0k0NVA3NDF3L3d5WXpQVGZ4NDY4clNyNVRTbGJmbjFKMXF0?=
 =?utf-8?B?TExPdTFrY2VNQ2Z4NmZ1MlhaZWdkcmFrTXV4QjY2Zzk2Mmw3NlF4eitYcmVx?=
 =?utf-8?B?THVwNzNUbTVKbzVaVkR6U2hGYVJqT2Y5MXhpTE9jZk8rc255Z0ZSNVdtUjZp?=
 =?utf-8?B?MFNFWXN5WHluc3UxUWlINWg5TW01RzVhNUNMRHQrZUcxR0FJTklFVUhnaVpo?=
 =?utf-8?B?Z3lFNW0yVWFkT25aN1QvVWtoZHRCaEdQQW5ERWlCcVA4TXhxYkxuM2ZkNjFh?=
 =?utf-8?B?bmVoUk9heFBuVlgzbVdRQ0U2S3JJMzRDb0FEM2lCUmU0U2pTOFplOUhNUHZM?=
 =?utf-8?B?RlpmZUNhYk1BcDBiQ1BveTJDazM3amxBS290RDVaRHYxL2w3aXFnMzFiR3NF?=
 =?utf-8?B?c1Jlc1Aza3o2RHlObWg0ZE9kaHdaL1kwT3dZcTM5aS85QjhuZi9SMk82WjhE?=
 =?utf-8?B?OStmYTgrM3Z3MVVPY3pCSVUxOGhKS2tCOW5HMGFOR1V3UFQvMDU0TzI4a1BU?=
 =?utf-8?B?eldaTWlZK1BZb0w2SEtVU3g1T3VsTDI4MCtiYWd1VE55d2VmbW5Oc1RWUEJF?=
 =?utf-8?B?T1JyT3l6WmhrOTUyOGh6OUU5aG9ONERqQmxvR3BYcGRxYkcrUW5ZUmVMZ2Ru?=
 =?utf-8?B?M1hUM2RUS3N1SEhwd2xBcTVXMUk0ZWMvNWlMK2g0aDhrL3RGNGdjTkxsUVVK?=
 =?utf-8?B?RXR4aE9IRlB3cGExTWdwSWd4THE3a3o4TDVsTERPd1BNQnFycElKU2hFeFFl?=
 =?utf-8?B?cjVGMTFZWTREK1dkQks0ZmFtSlVTYlEvWDVGZWE4aG43Vkg1eDIxbU1MRHBM?=
 =?utf-8?B?aFVBaHdlS1pRbldHUnBHa0tPSDY5OXBvTDhtRnFOdGZtL3A1UHJzSlovcmxx?=
 =?utf-8?B?by9QNzRjVHFldlpiMHVOZTB2MndZdFR0djFqeURndGd0dHFqUjRKR3VOTTRB?=
 =?utf-8?B?a3FsbWtmRjg4clk2dHNaWlAxN2ZXYUxyWWplNkxCMndOaDhveWVnYmdGSkN2?=
 =?utf-8?B?R2JhejZ6SUxaK3A5dHlkNTFpTVh6VGRTUS9PVFZqaEo0bmltQjN0TjJhQmM0?=
 =?utf-8?B?WUhaL2ZHN09HZ0RvMWRwNkVRVUxNa1Q3M1Boa2dFS2ZNcUdzOHZEalJzeHN6?=
 =?utf-8?B?bS84Zk5lZkxpNTdHSitaNHJQeGFZWmNKQWQ0NUprc1lQNWIzeWw1bXJRb0E2?=
 =?utf-8?B?MXlGdjNMYjFNTHpLak9aM1VMS0lOYkdVTWZ0TU50Ly9hZjJWbEZFaVkxbjFF?=
 =?utf-8?B?bm5jRk9kUlJIVW8yaHRmWGg3c3ZQa25SNGRqY3AwUmZQM2VHM1VNTnBaTDV3?=
 =?utf-8?B?QnVPblBkUW9aTlAxOS8zNFRzRjFqZTVrWW9UdnA3OHhOUVkzRXlZZzRuSlRZ?=
 =?utf-8?B?NXI5SWhJWVNGM0xGT09XMEJTelVmOU41dlNNUmRnWUQwdThONkxROWJLdE9t?=
 =?utf-8?B?bFd5S2xjTE13UUcranRhRnhsUFZDdFd3UkUxV3JSeU1SSDlHQ0ZsM205b3l4?=
 =?utf-8?B?TDBOdGhyZE1LZDRSTVJaZW1xTUlYTitHS3FYd3R2azhUOHQwWnJaY2ZXY3N1?=
 =?utf-8?B?SXpDSm1DcGNnWlgrbDU0S2laRXE4dFpRL2ZNMCthU2cvWUc1MEUyYkloeTd5?=
 =?utf-8?B?U29hM2c0V0VPeXk2TXdoNVVISzlDR0U2UWsyN2p2Ky9ZWStNS0QxRnJiTjBH?=
 =?utf-8?B?eUVzNTJqc2sxMzdsS1YxQUdxcmgwZ2lIcEI0Z0xzOTF1WTBBUlR4OHk2a3dS?=
 =?utf-8?B?UGhON1F1SkdSNllIN0h6QkhZTndBM1dDV09KSnZYcVoyQVc4TVE1UUdiUWFn?=
 =?utf-8?B?aGhLUDY4OGF5VTJDQjhnaWkxY3ZvdFBpZGJhSktYek13UHBUMitZNGx6cDVC?=
 =?utf-8?B?bXFJcDc5cnZxMDd5Z2xYSFFRdjkrTVhFQThyc0M1Q3U1UE14VDMrcWtVbmY1?=
 =?utf-8?B?R2lMVkdvam5lN3lOMDBVYnYrRFY4TzFYdjI3bzQ1N0ZPVmJ2YmZiM1RnL2tI?=
 =?utf-8?B?ZGs3Z2xRYUYySjFuQjI0WTZyTFpsNEFpNGV1RWF4Y3NRTmZXZ1dVSnhkWm5q?=
 =?utf-8?B?MDBvSlFaS3V1d1JkQmREVGp3V2dRQ0V5UlNoTC9aa3BuNUR4TVBaZE5HVVBl?=
 =?utf-8?Q?S2TAbEs9hIhqcIy/XQgx8+O85?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BBGZviuhfDx8j77q1YqczSqtf/As8OJwNWVGNv1ucn9tpd1P3JMVBEdWwzpTOuReBtAY1NZNyNhpQ2jSTfbv/rbUMY+QInZWYpxCcaCwdIYVMFaoE+5+WzPaAZDaU0qc5D0yqKHRXQ+/ZEvoNWlb6RE7njUXbgnxm8xiUKSKOJ7MoJ1eec+MGgtwwzfuv15rI+lV9chbxcJSssscIDTwMVEM4ecoCqwG/xEe38q8/ndo5Sa7vz5/9lDGJQ1fMuj/PXpXnqsykaPaB/rh3twrWqBq/ybuNYUYpUwFzGZYStrvccCIrG02VoTbY1LAEwWTJbZoROfYXSTBPpPJGWYGaHFoIfeWTB7nstQ9LC3guxUaB0j+RXPtJbEga6UjUsYfFHtzOaqfEJqbPU5qStppmoI6GbddLCMUO4IH5gMGseai6BTcOyLQnxZy01wTpl/wNgBSQQgjHPJwZx79q4Od7sm5vTpnjTB8e1yPOFCMS5kzHxz77M2GkJEIVvhqti8c68h5QEkbDgnXAXBuwM30f7CRm3pzMpVRq2b3j6T9Gd5LgR9AQDATd5/zFDuCYr6dHvrpW0ztCz9KUGifaZ+DYdWxt0slYctUJ2tOdf8COzc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3ed608-ab65-4c20-d63b-08ddebbf0cfb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5509.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:26:35.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxdiR+CjZk2SgBvknwBQ0H/mBciK76eJEjnhKRGMonhmxdU6ljisl72sOhP2aPrOQHdbDhn4fI5Bz3sfsLXaRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040142
X-Proofpoint-ORIG-GUID: tdg1pka30PCB-9l_Lq1Hr61_MMS1mril
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE0MCBTYWx0ZWRfX0MMJBhW5MW9f
 iIlv6w8GnA+0984In9U+MRGsQSNlqz5mafBRBA7DhQ/39OPZLxfl6hMf2tNcSYtrKUhpCIRT5mh
 NgouHZOgMFeuW9og1obdvJJMu746Po754pbPLXvzyGQpwjZgaWviecqNOYZ9jYtYgSiGSXTdhAv
 uaIzfpSzaU5aCCPqrqtza9U7/VLajuObXq6UYDCRs7HLYzE8W+Gz17wWU+jo5yePQzPMH1TPqD1
 rNjkxzl6wAw7AN+hTqx7IB2vv1OObYB4Fm3hJjbHH5dKQdVGI7NvTBVhQX3Bh/6Soh+VkxnekIN
 0OuMoEA2Avny/ugYZvPyY+jnwN0CWf/FHsD7TW3H6kfP4AcG4TNWpyVxWTQen2FfddaZdW1/ZSz
 emDEEWjX
X-Authority-Analysis: v=2.4 cv=bOgWIO+Z c=1 sm=1 tr=0 ts=68b9a1a1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=hV2IK7sstZAXtw1ccqcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tdg1pka30PCB-9l_Lq1Hr61_MMS1mril

On 9/3/25 4:44 PM, Alexei Starovoitov wrote:
> On Wed, Sep 3, 2025 at 1:52 PM Tom Hromatka <tom.hromatka@oracle.com> wrote:
>>
>> On 9/3/25 2:45 PM, Alexei Starovoitov wrote:
>>> On Wed, Sep 3, 2025 at 1:38 PM Tom Hromatka <tom.hromatka@oracle.com> wrote:
>>>>
>>>> +
>>>> +       spin_lock_irq(&current->sighand->siglock);
>>>> +       spin_lock_irq(&task->sighand->siglock);
>>>> +
>>>> +       if (atomic_read(&task->seccomp.filter_count) == 0) {
>>>> +               spin_unlock_irq(&task->sighand->siglock);
>>>> +               spin_unlock_irq(&current->sighand->siglock);
>>>
>>> did you copy this pattern from somewhere ?
>>> It's obviously buggy.
>>
>> I tried to mimic the logic in copy_seccomp() in kernel/fork.c,
>> but as you point out, I probably messed it up :).
>>
>> Do you have recommendations for a better design pattern?
> 
> Several things look wrong here.
> Double _irq() is one obvious bug.

This snippet addresses the double irq issue.  I also added a
check to make sure that task != current.  (A user shouldn't
do that but who knows what they'll actually do.)

         if (task == current) {
                 put_task_struct(task);
                 return -EINVAL;
         }

         spin_lock_irq(&current->sighand->siglock);
         spin_lock(&task->sighand->siglock);

         if (atomic_read(&task->seccomp.filter_count) == 0) {
                 spin_unlock(&task->sighand->siglock);
                 spin_unlock_irq(&current->sighand->siglock);
                 put_task_struct(task);
                 return -EINVAL;
         }

         get_seccomp_filter(task);
         current->seccomp = task->seccomp;

         spin_unlock(&task->sighand->siglock);

         set_task_syscall_work(current, SECCOMP);

         spin_unlock_irq(&current->sighand->siglock);

Let me know if there are other fixes I need to add.

Thanks so much!

Tom

