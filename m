Return-Path: <linux-kselftest+bounces-14599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD86944656
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 10:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6941F2353F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367616DC2E;
	Thu,  1 Aug 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PFr3WqNq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ynBPh7oa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2FF1581E5;
	Thu,  1 Aug 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500326; cv=fail; b=oAK6mmHK7eylvF8qzqqweUc8Muv3Z51gey8aSzGcX0h5vES6IYWppMy1s7NXMd8wEKCcGy3s8W3h9DS0LG9ceFn/E2zPlZqXoezrLPpnerT7ltDtH4Bg7Y+IbkYYr1LK/V2EcE84pubviRzegcPyaUcAwm2no8lRsFmlQF2ac8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500326; c=relaxed/simple;
	bh=gS47tjIKiglwQrTSsHHYQW+CUVYGjOwg93R6Vh0IZYY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XQlMZM9b8jbDWFbKeA6pjivNip8kjm5WYDl9JL/FgccDFfn99Mti1g1n+WOywM2QjKnKgzqddKNc1ZRuI+zTuju13zL9pE7ykC0rxYoiUGYZBxNhJYfezRyKwnRKLqnf0cMHySSXlpfFhNNyVtuTy4lGTMhyCC3h68xuCfkj60o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PFr3WqNq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ynBPh7oa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717tW9i026233;
	Thu, 1 Aug 2024 08:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ytVkdINYdM4g38Jpgbsf6Dr5pbbgSspnBwN2I59h8yE=; b=
	PFr3WqNqsF/hWZZWC287dQ0I3ZExXrn+15pYA8Ief6w0peS1oqE/8Z3NJq34jxuw
	f4kUkixu4U55DGH5cAj7ntWYberlOpx/zso9eWqKvGOu/QKV7aFykKLI4T9hn1+u
	J7blbqjlXPalt+nUGcBZvhX839VVpzGLXCEXCLuzV4DLHIXN0/DJMjUy6ieruW0f
	FvGlshr/NSFS0p7bRVMEbA5l2amlLPpi1IoVMG6fqDq1zOsEW0oUHhcPsHEwJiiW
	r3DovnpGVXdYfiHgA2ppwVRFDO1g/xtyBpzwGCLhdNxxFLfThpdK/SopF0u2qzXb
	MXK0QTNIH/87g+SODmbJZA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyh6ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 08:18:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4716cZeP029018;
	Thu, 1 Aug 2024 08:18:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qmpspf5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 08:18:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvCgway3cnP5KdONDJMvlUCOOqp1o40CxAlYpYfh8c56y6JnoJGaSonypXirMhCjsiQNzAF9p2Qnic7NqZTJQpPSxUUOqINeRQMxbqqfA9t+AwLcXeeeyJ575dLmcpAFshIC0bM3Ss+ai7yUzuetOR3oc4dNF+AKFU02rMFY85xv5M/l5aWU+D65e4kqsFPP+AwUsdW5SFqS+uR8aoQIHTboQoy4KkB3gikUIzM73FjvjFPk63a5yx6s8DYOdByfzeLFgJFEbbfL0uKf+zdAaDgxghbl6zuM44F5uZeXdWbQ83SBhQGv48eSoj1SzLjN0nx76Yksvkum6kgL1oLK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytVkdINYdM4g38Jpgbsf6Dr5pbbgSspnBwN2I59h8yE=;
 b=jhZrFKwnHgdMGFrgDPIuhtw75NteeGt8xvKwdxhWbrHdz6zsP/3uM7Dnw/Mw6ApnVSkhn+fSnkJMgWFfbWibAiB1wNen7EFCSuWtSQRbkDdSyhBOjGbmP1KM/ldJTpYCZMez00+48cB30mDKeWHt/QZXgHLR8b1e1p/YZQRe2A7nV9hb/FYYAa1qEV22/noTgZfULSnpUN1KBC5Rwx+Oih4GxPSFzwiTqgbHBQp+05YYf0qGVbtc3PoWas+ejacZtFnnu/1Qbg7CwGmuCf/DjXK583OQqzIjFmJtq7jY5BAeMCvdHEwqltPnRaTXfK4lxWec3YXGhrrOj6Fqdlj7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytVkdINYdM4g38Jpgbsf6Dr5pbbgSspnBwN2I59h8yE=;
 b=ynBPh7oaNCRpjLuuT8Nibv4BCvuZIphXqzKCpMxJs26KAB2+9iG/YoccD6qGaajIBtvNmQriP4tr991Ht/ZmFotQsFKBU/XZFvOR0CtghA/KM7xskFxUVOZbXJaz1JPktoTadLgZwueBpFSlAx+OtgpmVixh8pXPzZZcEOukm10=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.29; Thu, 1 Aug
 2024 08:18:07 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 08:18:07 +0000
Message-ID: <c5a9033b-8f47-4ae8-97ca-75c70bce88cd@oracle.com>
Date: Thu, 1 Aug 2024 09:17:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: convert
 get_current_cgroup_id_user to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-1-14cbc51b6947@bootlin.com>
 <f54ddf95-a5ab-4c56-966f-9bff37f50364@oracle.com>
 <f60d47cc-84ff-4031-a9e6-244954af901e@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <f60d47cc-84ff-4031-a9e6-244954af901e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:208:55::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: a48852e0-7edf-4c34-8e11-08dcb202791c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWdqdjE1NWdtM0g5dTFhYWZlaTI3M1U4MTB1RmkwY3VROGJWUXVFaTI0ajQ3?=
 =?utf-8?B?S01QV0VncjRWbTFlZW1PK1NHVkZtbVBIT3NwSElpa24zR3k3WDBOcGMxL2dn?=
 =?utf-8?B?KytmMGppbVBQOHUwczRzQ0hnV1JrT3hQVHl0Nk9oTng0Vmh3ZHVRTXRJZG9p?=
 =?utf-8?B?NFljN1l6dUZoMHBHcmI1UVZzc3lpMGdtbjduSmFmUEFrOU9Pdk5lUlJsNi9o?=
 =?utf-8?B?QmJ0QTdhY095TXVEbk1WbmhxTVRPWjlHZXVXQ1dJcGZQcGxTVEt1QVVCbWFT?=
 =?utf-8?B?Z2xYaytSWVIra1dwTGVMN3FXaFVNM1UveFhDNEtOb0R1QWhLQ09nazd3SGsv?=
 =?utf-8?B?a3VOeDdoOTd6R3l4QytBZEpWN2IxVkN5WjJGOFVUaGlVSGxEYythYS9lUDhz?=
 =?utf-8?B?dU5Dd1hFRnVIdkt5UXVZcGZtL1hFcEFtOFhNZU03dGtWSExacWtLREJ4emxG?=
 =?utf-8?B?dWZzenZ3K2w4ZDdtRGlKSm9BWGRmaUl4Ti9UM3hEbFhtYWkxQVhDalQvbXNw?=
 =?utf-8?B?ZTBHZlZaQjNMZnoxdGRNQ2lXQVI4K2J3c0kybTNYT3liOTR3SnU5RXlXOGFE?=
 =?utf-8?B?V0FuSHlCUkNwUEROcjFlZXZiOXBvU2p0NnQ0cVJiSUVuOU0rSzd0SVh6bXY3?=
 =?utf-8?B?K0w4VTVJVmpnd3VYbHh4L20rWVh3K1JmbVQxNDFGUTk3aWFGZHl3MmQvY3or?=
 =?utf-8?B?NXNTbWp6dWlLSHU4WXZhMUFVcy81TzltT1JScVo0RkV5ZnF3S0NzKzBwcVor?=
 =?utf-8?B?OWhScktsbTRFMEo0WmYvRXBUTFkxTFZvbjIxTjE3UktBNGhLZHg1cERKMXRh?=
 =?utf-8?B?bFhUUWh0OEExd2RaNC9ITlgyUjlCclRJVUcxVXhBcDJiQ3hzL1U3M3R4a21D?=
 =?utf-8?B?eDRuOTJ3a0RqUzlnRGY5clU2NXg3UXRDM1JxcnFXbmRadEowSjFIRGZsNHo0?=
 =?utf-8?B?N3NsamVNZ1Z1cjUrVUxXc1JVZ3I4NStvSzRuNCtpbDloSzRCVUVwaDdrTHc0?=
 =?utf-8?B?RTV1RVdMWDVQVVIwS0sycDFncjVKekF4eWQ1ays5ZUNtSnYxRTQ5OERSKzRY?=
 =?utf-8?B?Z09URDJJUU5nUENuaHk2dHdwcWFMWDFFOEVHWW9xOFJnSk9OM3JFay9OcGN6?=
 =?utf-8?B?YTVvRjJTdGVTb0J0aytnY09WTTE2SlNpYVRlR0xxWFEwNWN0clhqb1lhUDNH?=
 =?utf-8?B?K3NORjJSNDNzVnRwNXp5U21NQ3VCd2hUM2VaMFRrSUJXT0tYNDFrcGVsczhO?=
 =?utf-8?B?UFQ2bVlYOEJucERsV2JSOFRWbVZVN0hhZzlVUVFaZWlnOFJKd1hxVCtUTEI3?=
 =?utf-8?B?bHYvTTZIV2d6Wmp5NTA4ZklaSmFRUGxKUWcxOEJNMzVQMlpWYWZ5MHVtQlV1?=
 =?utf-8?B?bTV2ajBIV2g3M0xESlBuQUFhQkl4S2hSQUorWlVHcHhVSURsY0IvNm9QZU1N?=
 =?utf-8?B?S2xUZENENkU5SlVJSWlsa3E5RnhhMWc5d2p6Zm9PZkNwUzVNWWF1ZElRVVY1?=
 =?utf-8?B?Vit1TjFlTllXbmNyVXFpYVNiYWlGRFY4dmdwMlFQbW9iK0ZxK0diNnpmLzBV?=
 =?utf-8?B?aS9WKzdpQ2RTenM5ZUx4Y1VLVG44KzhNWFJtUWFJZzBTY0dJdk4zb2V5SUkv?=
 =?utf-8?B?aExKZWhzbHp3MkFicnorUjFnWUhnZXBlZUg5UEpUSjZBVHdPZ2FNM0p4cjVR?=
 =?utf-8?B?TGNJUVhjU2I5c2lidVZXdDZCZVc4cUQvbWtZaTEvOGdtaFEwNU9nT0tSN0d5?=
 =?utf-8?B?dzNobzBTaFM5Nk1UcWtsb1NYK1k2QkpMNlRURTFvazZGRjZkdWUxTC9nbW9T?=
 =?utf-8?B?YlFWQlQrSk14WFA4bXM2cS9LSzNPb2U2MWEyeGhLV2Z6RVRMRWduSyt2SWFM?=
 =?utf-8?Q?IdNWBG96cOuOQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlRoT3VJTlUwUHZYVVRnL2RjUWdEUEFTTEdKRVU2Q2swMWtxWlZEU2QxZmhR?=
 =?utf-8?B?VGVWQWtKSm5nNTZoMUZYaTY5M3VmZDNiMndzeHZ6TjMrck1KQ1FJakpkOWY0?=
 =?utf-8?B?elpiN1o2M1BvZVJYT05YZ080cGlCRzI4Wi9hZ1pZODEzSCt1SE1LNXYxQTdQ?=
 =?utf-8?B?SUx6U0dLdSt5eGpZRTM2dTJZRm5oTzFDSVZpUks4NFh0WW4zV0c1Q2M3Qy9S?=
 =?utf-8?B?Ui9Jc080YWp2QVdySEpHSzVMWUFXNWRRb3luOTJsNkJEZXB4bVlteGRxQWFP?=
 =?utf-8?B?WlNkVmFOUndvQVBJRG9KNEduNzBzK3p2MzBqT1gzSTlBdnF0SmYxSG9SbmFP?=
 =?utf-8?B?Ui9IV25Wd2FYMEhzYzVCeUhpY1IxTFB6NWRDbkZZaTdnbHBtOGJGMWk3NlR3?=
 =?utf-8?B?T0RhbkVma2pLbk5SdDJyb2M3c2Z4N1pJQ3NiVzlkQzlzOXk0WXJZN01razls?=
 =?utf-8?B?dUhlWVk0Q2owWFp3eUhScnZXYVFaekE4UmNNM2hNbGluMHloYzU1R3BUS3N3?=
 =?utf-8?B?REY2YjR3aGoxVjZ5dnJTUlRXUlJVY3cyVkYyYlZGTUdKVEVmSklZaUFsN0xU?=
 =?utf-8?B?WmlKUkxydzBRNGpPeGdIREluMVFmWW9LRjVJVnoxYmlYVWlTTkY1VWN2eFln?=
 =?utf-8?B?ejV6ZUF3T1hwRVVpN0I3TWxiSTVqTVFvNElsL2FoOEVsU1diSmhtZTJ2MS9X?=
 =?utf-8?B?RTZXQ1dxeFBJZkhrQ1l3NnVXS1pUblNVWU5qcTlWR3FGMlZxK1JJSkhBMTBZ?=
 =?utf-8?B?U01SMVltQU05Vy8ySEVBajVpTHBYVm85cC9KTWRJeW84YWRBY0tLOEhWTUFX?=
 =?utf-8?B?U2NRM09SRXAyYjdmY2tKTWhERmNVb2x0T2lWUnVXK0xtTFZwdzFlRTM5TW1l?=
 =?utf-8?B?WUpEYjl0VCtpREVaWnJGeHZhSG9oUTI4dHZEQndYVU05cXVYdTFwOFJUdk9t?=
 =?utf-8?B?OG96RmYxVzZEZkFKZTkrelZ3U2I2Y2VaSkV2V3d0YUNLKzJUeFVyZ09aSjdm?=
 =?utf-8?B?eTlYRjJPZy9hRlpnK3JSVzZVRjAxTVI4czBJczNvRmNOTCtWNnhtVDhQdFJm?=
 =?utf-8?B?bTJlSHZjc2kxekFkTHd3b0daRGp6MHdSakF4WjFPT0c2MzljWGFLVU5sR1pF?=
 =?utf-8?B?a3RIdXF2SDdpUUpJd1YvVUx4T3E3bW9qZ1dJNm9QaEFJdEFMRkhOcmpzM2Vu?=
 =?utf-8?B?WWJpcEhMT0EveXEyZDZGUktPNU1qZFVRUTF2dUpPMWd3TWxob0ZQUVBIUjFj?=
 =?utf-8?B?NHlRYmcrSk94NjMwQTAwSlloVXl6blQ1UFNFUlZFalZjS25pcFFQUFFQWmtv?=
 =?utf-8?B?NFBvQkNiSEtpL1J2ZUIzZlczZC9vQTIvTEllaWczWWNNK2JoYnFja0JKeE5r?=
 =?utf-8?B?dzZ3YXVIT1ZrU09PZFByRmEyVFdxRnpnb3JBL0l5WExrUGsvMlZ2Y25VWEtD?=
 =?utf-8?B?M2pSR0UzS3lRNDJkT0dEb1VvODVadGV2azBuNEx6Qi9VQWRxenFQcTBBOTV3?=
 =?utf-8?B?VWVyYW1iaEV5MTNEUm1vTitpSk1qWjFPMktMaXU5V000TUUvRmUxMnRDZzMr?=
 =?utf-8?B?aFpOUVZGcWhXaG1uc3NNM0ZZRmhzaEVkb1NVTDhiUDF3cG92TUJlQzR3eEZ6?=
 =?utf-8?B?Nlh4VnhQVmE2ZUpoUElKTy9SWlNZQU5MeTIrUlJKT3IzVU9XUHI5YkN1dTd4?=
 =?utf-8?B?Tm0yRFdQV3MzRjFXSUVLeWh2MVdUZjlOODdYdlJoQlEyTkdmQ09yZFlHemow?=
 =?utf-8?B?U010cFJHT2FsbVM2bmNQeERXQ09RU2NBMEVmZzBHd0xMbEpxeURVY1djYjNy?=
 =?utf-8?B?d1dZdVlhOUtxRlBWTStTYkxqZUtYYWs4VHRtOWtwTkhZV3BRSy9JNXg4c3o1?=
 =?utf-8?B?KyswakV2NWRLejNNU2JSWUJ4WWpPT1FSUGYzOWpuWmxRbG8xUE8zQXJBdkRL?=
 =?utf-8?B?Vko2SGE4ZWRCUDF5Tm4vTWNMdFhRZllvaXAwbHFYNnZYOVg1MHVsNEpXTEZ0?=
 =?utf-8?B?dlFZMytPNnhDM0NPWTN4OEkwOEFKcHZEQjRXcXp5QlhKM29WM0VQT2VaYUx4?=
 =?utf-8?B?MXM2WFlkSFRCbnFNV0lVVXdNcm5HRFEwN1BDRTZjZ2dhUnNxVXlDT3NMalFv?=
 =?utf-8?B?MGxzaUpqZzE4R1Y2R3gvUEttclFuckdxSjIxaXJqeWZWTTdvUE9teFpWc0Jm?=
 =?utf-8?Q?u8ijTS0QG+bo075iHwd+/ys=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hFkjLn+gkJ1HmDcMwrC+FvqzNFg/yG1rnHIfdXsWmnwJLCTHneQy2ureRgsV0iTbc23dpwyJd0LtvM9idMdN3GwgCQauqk6pBdmcmq220O68oDJHugY9BpSsZv2wSboom5zJs60i4qOPcw5D2zcWdYrDWjZyjxB+223Cz/SckEWrabnr6DlLGICn10GUllalzz94wJRv+uwfhR/7opXA2EN6/iYlxHQGxtTwdJCb0iDqOn7iEF7thnoKyQ0xYt2Vbp2BTg3uI1xlKapusr0ZLTW5UfGvp6tCGPDSpLEzByR5an318il8cGNSBtgWF8OCslCdNf6XuvLpoF+L3kVMeG56ql1F9wOgGdSKKijdD68rddCi9f6tumgL2ZRtY8SA0iA/yalXrODrWfb7+MCHap12/aAk34oPGSbVbq/spGq4fspsTShBx9Zp/nv/IZBNlarG7BEKlEZ4Gh5v01wbY4DW2xJvp8KzsXaqeDR99nz9aUS6AoYww2CUHrIVW2Zk27MrBG/lJnr6Ae/2rm9n4BZNtdaRnhLHPsh64K9ag+rqXTUmcBRhn31R3elKEQk2kXF62pafmOxu2cXolp2TDJYH4A86Zl8cen1+V4JvhYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48852e0-7edf-4c34-8e11-08dcb202791c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 08:18:07.3064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2ULTheaEdEBp/nx3yYcVTZ6blJCwtRGr8I+2/8zSItu5Og9p8LBZrWpFCiDmOQSKebr2cPdQVw5LHZHW9LO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_05,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010048
X-Proofpoint-GUID: QShnNtD5a2beaJA9iuBb-wRwDPFO4g9R
X-Proofpoint-ORIG-GUID: QShnNtD5a2beaJA9iuBb-wRwDPFO4g9R

On 31/07/2024 19:53, Alexis Lothoré wrote:
> Hello Alan,
> 
> On 7/31/24 19:23, Alan Maguire wrote:
>> On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
> 
> [...]
> 
>>> +	pid = getpid();
>>> +	if (!ASSERT_OK(bpf_map__update_elem(skel->maps.pidmap, &key,
>>> +					    sizeof(key), &pid, sizeof(pid), 0),
>>> +		       "write pid"))
>>> +		goto cleanup_progs;
>>> +
>>
>> I think it would be worth using a global variable in the BPF program
>> my_pid, and setting skel->bss->my_pid here as other more up-to-date
>> tests do (example progs/test_usdt.c, prog_tests/usdt.c). No need for a
>> separate map anymore.
> 
> That sounds like a good improvement, thanks for the hint and the example :) I'll
> spin a new revision with this, and make sure to use it in my next test
> conversion patches too when relevant.
> 
> TBH I am not familiar with global variables usage in ebpf/libbpf, so it is not
> clear for me when I should prefer it over classic maps. From some quick search I
> feel like it should be the default choice when needing basic controls
> knobs/feedback on a bpf program from userspace ? Or maybe it should be used even
> more broadly by default ?
> 

Yeah, it's certainly what I use by default, unless I need multiple
instances of an object. Under the hood, the BPF skeleton creates
single-element array maps for .bss, .data and .rodata sections which
contain all the initialized, uninitialized and constant globals in the
BPF object and mmaps() them so you can read/update the values in
userspace via skel->bss/skel->data without needing a map-related syscalls.


>>> +	/* trigger the syscall on which is attached the tested prog */
>>> +	if (!ASSERT_OK(syscall(__NR_nanosleep, &req, NULL), "nanosleep"))
>>> +		goto cleanup_progs;
>>> +
>>> +	if (!ASSERT_OK(bpf_map__lookup_elem(skel->maps.cg_ids, &key,
>>> +					    sizeof(key), &kcgid, sizeof(kcgid),
>>> +					    0),
>>> +		       "read bpf cgroup id"))
>>> +		goto cleanup_progs;
>>> +
>>
>> ditto here, cg_ids could be a global var cg_id that the bpf prog sets
>> and we check here via skel->bss->cg_id.
> 
> ACK, I'll update this too.
>

Great, thank you!

Alan

