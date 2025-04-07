Return-Path: <linux-kselftest+bounces-30175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A9BA7D1DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 04:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF3016DB16
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05F212B2D;
	Mon,  7 Apr 2025 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Rq34rfsu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2053.outbound.protection.outlook.com [40.107.117.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F979CF;
	Mon,  7 Apr 2025 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991217; cv=fail; b=JaqeDI0WP6PTcX0cH9xdWMz/OnC+Dwbdi1JPQ4lh/9SI5ZHAywfKGFOsTCXZVIQ/H2KgF4K6qgfWv5naG9YP86SAPiv1NO1K/3yvOZdUH2WJnOSSBYq84V57wSGAYvIAuHnIUmSuDSk+YLnVfYlNGNcunRFbF2o1xT8m/uAg1WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991217; c=relaxed/simple;
	bh=lX/ooN7vFCDaHQHxEVjY6ErzBV6HooxfxcERxs8bYsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FKDZhtm+9jve9iCNfNBylicJrLLI/wfGU7oAnZrBij3990QO0/dvHldeQYhLv8iaXVFIGCYEv/oD/QawUMFM1PNpZDX3B1M6odERflJCnUifQzJocZC140vIJAcey9lxuE2A7mEDKmI6k/BiwUySEMJ+qhF+IsRSSEzZHhQOm38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Rq34rfsu; arc=fail smtp.client-ip=40.107.117.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVy+2zWmRAwkcZYoA+RP767JSsFv+a1HY0IKvm23DKodmI24+MyyQdV7u+1R70Acd0oAk9thYQzKfJdl+UB2aefU6e+Zj8QOTA7f+P6MHoFkGxK01hBGNNTQ145q+s1abqN3eeT2KwOOuqTNiuXveT/WAemKhwFdivD/yDhk8UwFc4UE5/0J6UDdL9M8r6lOonWpXenbdBzCENUwPtWQuls7YQhjJ2b+vG+owvv2VVbVa65vLnu0T46k82yS1IN50Gob44JCpk3lp3sSCdc8b03lKQ0xxjtSYz7r/hEPE4M36YguQe7s2lrn92QIP4Cyqd6opbb7vY/CumteW/p49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+7fvrbHZmmpLwEAVSyhtn9ypKDQOLOmoevhV0Y8HIA=;
 b=H0utuiZDQoepiH8YCZAQGTaZRKJPPXtbLB7yFZLSCS8j2Lruwz6LDaggB4YxEspZ1ux/Czem27UOySaMQIb0ZWO6k2exrINnotpXZcDty6x4XAfynxeME5/O6tbHie2JRteB/uvFZUbWY6OCx/mLDZuftyFKnZgObfpAEOYsYqRCaSr49BXF2uJDtFp7C4+ngQRn7rClqPEzeB57OdMA0JIxLRH94CW5QXFQcfbGx74ChWjTsDo7Wyc92768NoDpGNL3fyavjgg/JQtQQ3jdo30oIixhPrwywhXB6kNkmaT7TE/X1N/le941pFLCtMeIX/gWMLbzuWSA9EaWr8Ldtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+7fvrbHZmmpLwEAVSyhtn9ypKDQOLOmoevhV0Y8HIA=;
 b=Rq34rfsul2aj/R7cI4dT9kkFrzMFxsop1pgI6O7QQEsoi6w8MkgNfrWnbREQOe1e1m8s85VcBDHRgJlKFlWiE+CYwNBCl3nkCCLP0uW5f/Qkh57wiFbG7D4s03U89hGhuDyx15r5pvJb02kq7t7UgPk9aY23dZ1aZKR1cuPaWQjrUB3MKyYDz3TfUdm8gy2TmVdwz6IXGVOqXafLMTdSlAao51nNcI36VzNvWY3j05TI3MbkP+qEmesLst9RXnsg5/o8lZgJdhzn/mU8Wa708UoZNqgZNz7GIQ6GvzO1RAzO34RzekK9iREGpY3EpfF6T88Xz4Ld/Wp+BqM+kL7YLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB6035.apcprd06.prod.outlook.com (2603:1096:101:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 02:00:06 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8583.043; Mon, 7 Apr 2025
 02:00:06 +0000
Message-ID: <e9f44d16-fd9a-4d82-b40e-c173d068676a@vivo.com>
Date: Mon, 7 Apr 2025 09:59:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is broken, was Re: [RFC
 PATCH 0/6] Deep talk about folio vmap
To: Muchun Song <muchun.song@linux.dev>
Cc: bingbu.cao@linux.intel.com, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20250327092922.536-1-link@vivo.com>
 <20250404090111.GB11105@lst.de>
 <9A899641-BDED-4773-B349-56AF1DD58B21@linux.dev>
 <43DD699A-5C5D-429B-A2B5-61FBEAE2E252@linux.dev>
From: Huan Yang <link@vivo.com>
In-Reply-To: <43DD699A-5C5D-429B-A2B5-61FBEAE2E252@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: f425db3d-6c4b-43ad-f800-08dd7577ea97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWtBRG95a0lZRVVBRHg5S0NIRXRacFBZKzFYZG1JM1B0NDdreTdsVFFvNlc4?=
 =?utf-8?B?bXVYWVNUcjFPdEtPQjRncmx0eWMvOWtXMVI5S1pNd1FxRHdFbDZWQ2xPbGY2?=
 =?utf-8?B?Ni9TeDg2WGdqNUhwYmwrUGpONVgycTBndnl6bWVPaXJXeGtzOFVIZ3VzeW8y?=
 =?utf-8?B?SUxJenM0QjZ6K0p0R2dtV2pQYkg0Nm1pdGV6MVR4WGl2Vmt1OXRtUEhvaVlm?=
 =?utf-8?B?LzNFbTBQOEovY2lrQ3VyWWh2SGl1YjRoM1BXYlBnM1E0ZTgzMkNBbEw1WGZq?=
 =?utf-8?B?V0xUNDN5ZzN4Y2NBeUtCL0tSYVdlL0tkMmJEVHdNSngyR2F5UjJqUW5iUThr?=
 =?utf-8?B?Y0tRdG5md0Y0REhqZTVVZ1BUK253aU92SFBHRmMwbkdKeUorUTUrYjhtRGxV?=
 =?utf-8?B?bXZUTTl2cHJsbWpVY2h2dDh1REZrSUUwSGVRT04zekI2dHFOcmVBUTA3akd5?=
 =?utf-8?B?Z1E2SGhBaHU4akJtek1SREdJN2c3a2tTVzlBQmxHOXZjQ2V6a1dtN2t5dEF1?=
 =?utf-8?B?czdQMkljUFppWWxQWjhpQk93TVF0MlhHU3pJNnRQUXVHRndaRHhWNVlFMnpN?=
 =?utf-8?B?WFhIdVBoT0pVWFJ2NllwTVMvWXhtYy9JRWxNWXN4MmVlZkJhQ0owM1FUbllU?=
 =?utf-8?B?TS85NXQ4VWd1djlFQnphanhYSUYxR2tSb0p1TWcwUkNyMCtGVFRNRWVJY2pj?=
 =?utf-8?B?UzlHdkxFc0lCZ01WV3RhUjJIKzVHQzYzcFJOWmgyajdlZFlFeVRUTFY0RzBT?=
 =?utf-8?B?cEQzS3JXV2JMWGtETUxDOVZRUk4rRHlGdXAxekpRSHRnUldqL1hwNUhXbDB1?=
 =?utf-8?B?clFYd29maFpDNXJtcGNzZ2xxOENwYWt0YzJzdUF1bDd4ME0yL2c0MTBTMFpW?=
 =?utf-8?B?MG1VTUEwZGFIL2w0YllFUm1lMjh1Y1ZUbzBncEFCMjJTUmtHb3lORDd1amtW?=
 =?utf-8?B?Q0dleEhqemU4ZzNxR0s5RGNDc0ViNFQ2LzZrMG9HM2ZkL08yTDRGcmc0VDhJ?=
 =?utf-8?B?R1kyZWFlSkp6S1VTMHFaeDMyZlRNTjVlMWFWUW0rdy82SHhIdk1CdHZjQnVJ?=
 =?utf-8?B?YWZlaE5SQnZGZlFKb0wxUnBaVmMwZ09lWmlPODFyQlg5MDdyRHBKQ29GeU42?=
 =?utf-8?B?S3B4UDZBeEduQWJnWk1tTXhaaElXVFBPRW5DR0ViTXdzRmpEcVllTUhpZnlr?=
 =?utf-8?B?Rm0vQkFIWDIvVldUaFVtWkhMTmZuOWhka0p4R05mc3UyUCsxYmFjRGJUeEl6?=
 =?utf-8?B?UDR6ejB0Mm1aQkFHUTRqS0pqcXZvSWJaeDRnNGNDNDdKT2p5eVUxTmhIV1M2?=
 =?utf-8?B?a2dTQkxTdUJYRm5OYVFTdVFoeVU2bUdQU1BlVGZKakl5ZU9qakdVTFZUZzlV?=
 =?utf-8?B?Z1JGR09VdDZJY09YcHdtTWo1RGpxSnFMdFVvSzh2bU8vbFF5Ukl3R1gzUVBG?=
 =?utf-8?B?am9UYjBtTHZBODVGTFJOZlRPQjNCQ1pBMytMTEV1UjhtRkVZUUc2SC85OGpL?=
 =?utf-8?B?R1o1eE1WcERVT3Q5RFF3UGpaU1RjYUFjcVlFY2hHT1Y0TWYwM3h1REFqcUZj?=
 =?utf-8?B?N01LUkpGT0U1YXU1UUdFakQvckVxdGpaYzk0ZkYvQXgyTldiMWtnZUU3Z3p4?=
 =?utf-8?B?YUYreHBPbW5nanExemw5b2NrY0plelVUemkyZTlPL2hSL0ozSUlVV2hkWUpR?=
 =?utf-8?B?eTBwYzRnZ01ORVN5cUR4bTJNdUdlMC9TOVRnVVdyS0E2cTB1OFhoYktRMGRR?=
 =?utf-8?B?REsySHFoKzVJL1dCSWc2M1lqOTBJZm9ySXljbEZDdVFKTktSUUVVdU9CL09M?=
 =?utf-8?B?QkVmZlNhbWVtc0N1ajVaOWJFYncya3BWS0RoWE9lMG1hVWtQQmxYNkE5NXoz?=
 =?utf-8?B?TTVhQlI2ekVxVWE0QkZjb1lIaEVrb0VNMFVMbWcrbjVuTWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTZIa0k0ajlqY1RGcHN1U1hpd3dJVFJBcXJ3MHIwWG1qREgvTEd3bW52VFBD?=
 =?utf-8?B?OXMwNy90Vkovak5udnFJcm5ieUFjVjdORVptTE5BazE4SUZSamJDcHdyb3NJ?=
 =?utf-8?B?SXBQdHA4OTdJYitSaHZGZ29YbkZMQXFKeVRONktqUXZEYVdTUmFCR29LNEZ2?=
 =?utf-8?B?aVJXQ05keVhwdThhaTdtRHhJeW1FU1hITEFWQjFqZEIvWjQyTHVRSmh3VWIz?=
 =?utf-8?B?eTZ3WWxEdCtjVmRrYWcwS2dhSnJNRDFJNnZDZG5hQzJqMWtYNzFuZ3VTT1Ro?=
 =?utf-8?B?dXFlVnVWbTFhcktiMnpnS2thME12TzdTNVZRK2JsNWRabkJtaXJZMDhBeUZL?=
 =?utf-8?B?QjAvVHMzWUNRbHdEM0xsOWM3WDNtRFREQXNZY1M1VWd0L2hQb1JheDVLUTV2?=
 =?utf-8?B?N2ZyamlSSU5UVFdFWUFac0hPWTJLL0RUZENGRUhTVHdIZXVrZDNIaVhsZzlj?=
 =?utf-8?B?UVZWeW04emdKQkdMdmVFMG1icHMrTzlkNW1oanB0U3VCV1ZpVkNXeC92dVU4?=
 =?utf-8?B?NFhuRGp4Z1l1ZjhLa1Ftd1J5Tm5uWXZ0cExaSlZYZHhYeEFxOWJRUC9KVHJX?=
 =?utf-8?B?ZGhyVnVSc2FqWU81Y20rZDZYQkErRXIvbU13c1RKVGkwTmIyMCtqMFJ4ZVM0?=
 =?utf-8?B?YzJBNEQ5R2JzT0wwWXhSTmRHWlUwWG5HU2JFU1NrdGt3V2FaYnJFSnhidnNC?=
 =?utf-8?B?ZlpQRFVEMDM1RzZjNWQvUFg5RlVCQ3NzdlByaFdxUmhPMW5DdU15QWJoWldM?=
 =?utf-8?B?ZUdodUZZYkpUd2piRkh3SDdVMjJkYWp4bWxMbndXS0FyWGpHZlZicUI0WENV?=
 =?utf-8?B?NDJ6WHl5dUx4YkdHb1lOR1ZzUGlnS3A2bHdvTmhka3hQcWorMUhvcWw0Zk9a?=
 =?utf-8?B?aXBNSTJiMEpBSjlISE93RHVkR3VVT1REaHRhSkFmeHB6Zmg4cWM5bEQvNnFZ?=
 =?utf-8?B?MWswbDU5UGJURndVNTNMb2NMZ2NmSkFCT0JIRTV2ZVZXbjV2bVdvTy9Lak1Q?=
 =?utf-8?B?cVZhR3E2c3IzcWFrci9BemNJU25HaEdXNjVLemNjblFKT0dPY29VdEpFRjRa?=
 =?utf-8?B?b0tPVmwyc0RpdlRPMDhLOEw0eEZPdXhWRVZPL01CK25aYS9pWURGVXdUbW44?=
 =?utf-8?B?SGF5VXVrcG5LNWE4OHkwMDQ5RHdsb01xT3BJSk9QYXlXc1l3T2hBTjY0K2Nq?=
 =?utf-8?B?TVBKTzdmK29Odkp5OStXanRPcXNJQ1BCTXk2c2RjS3l2cHpZRERlY0NqZWtF?=
 =?utf-8?B?KzVyb3NzK201V1hXclpsYzZMNmR3eGcrWFRCQVZiZ1h0YnVoMXYvM3ZUb3F1?=
 =?utf-8?B?amMwOTBQZ3Q2N1BlYkNrUVVYTFVvcnNXVEFnNnc5alJMVGtWSnNkaElvS0ND?=
 =?utf-8?B?MTc5WHk5emVwbXVoWG10endnNHNIajd5ZytqUE84Szh0bzRvb2IrL05NMWo4?=
 =?utf-8?B?MzhPc25DL05lT3lyQ0syWUJIYWFPbzN4Qnh6YzRCQ1hRa3VUQzV5Wm5HaE8w?=
 =?utf-8?B?YlVMQjZOT2NZSnJzeWRtMUJKQVNPNmJxbnFZS1dkbVllODlQOEJnTWtBQ1FS?=
 =?utf-8?B?elhiTlE4UGZVbXp5Znh0QkFxTHFtOVN4WWJBNHBpNHVnOGRYcWtUZy9ML2Yv?=
 =?utf-8?B?ZHFpNFRSZzVid1VDMW5sTTRhS1F5aVlHMlR2cXNJWFpndldjU1hqOWxMSm5N?=
 =?utf-8?B?R0pHZkJGTTM5N2c1bWFQTkZNRE83eFFBakh2T2piMTZJUE9QZWxSejJ0L1cz?=
 =?utf-8?B?S3FsNDZNSVIyemJSNjFQd3ZMYlRUSU5aUEQxdUJ6R1d6QXR0ZXRIWHNBV05W?=
 =?utf-8?B?S0JIdW1Pb2RPdzFBRVVPdk4wYldDQ2xIazJsVDd1djZEZjhMdUxETkU4ZzBt?=
 =?utf-8?B?bWs3QWhXS2p0ampneUJLbEIyMmxtZWI5Q2Qwek5MZHVxY1VKU011VkF4akhx?=
 =?utf-8?B?MmJhWGJiUElPNUJ5aU91ZTJQYytlalZ0WmdFUW1iTzJQNGJ2a3NoVldiUy9h?=
 =?utf-8?B?MGlaSDUwWUNuVkZ2b09aR1lEaGFkc3NCRUd4YW1TWGNTYi8rRmhyRVNzTVp0?=
 =?utf-8?B?RVo1Q05sbVpTK0FiYXJ6WWRqRXhuMnNYeDlpeitUZVQxZDk2cHM2dnFrNTdZ?=
 =?utf-8?Q?Jp2/oAZ/EsAGjXWZ8jny4RLQU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f425db3d-6c4b-43ad-f800-08dd7577ea97
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 02:00:05.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqQcQNX/IrKGu+/ihqK+dyDB8MkRW7yHBypoCytDwYLwH3aL+M/1SMEPNZUUWJQiCKD2hRoUqzDm85R3f7tBwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6035


在 2025/4/4 18:07, Muchun Song 写道:
>
>> On Apr 4, 2025, at 17:38, Muchun Song <muchun.song@linux.dev> wrote:
>>
>>
>>
>>> On Apr 4, 2025, at 17:01, Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> After the btrfs compressed bio discussion I think the hugetlb changes that
>>> skip the tail pages are fundamentally unsafe in the current kernel.
>>>
>>> That is because the bio_vec representation assumes tail pages do exist, so
>>> as soon as you are doing direct I/O that generates a bvec starting beyond
>>> the present head page things will blow up.  Other users of bio_vecs might
>>> do the same, but the way the block bio_vecs are generated are very suspect
>>> to that.  So we'll first need to sort that out and a few other things
>>> before we can even think of enabling such a feature.
>>>
>> I would like to express my gratitude to Christoph for including me in the
>> thread. I have carefully read the cover letter in [1], which indicates
>> that an issue has arisen due to the improper use of `vmap_pfn()`. I'm
>> wondering if we could consider using `vmap()` instead. In the HVO scenario,
>> the tail struct pages do **exist**, but they are read-only. I've examined
>> the code of `vmap()`, and it appears that it only reads the struct page.
>> Therefore, it seems feasible for us to use `vmap()` (I am not a expert in
>> udmabuf.). Right?
> I believe my stance is correct. I've also reviewed another thread in [2].
> Allow me to clarify and correct the viewpoints you presented. You stated:
>    "
>     So by HVO, it also not backed by pages, only contains folio head, each
>     tail pfn's page struct go away.
>    "
> This statement is entirely inaccurate. The tail pages do not cease to exist;
> rather, they are read-only. For your specific use-case, please use `vmap()`
> to resolve the issue at hand. If you wish to gain a comprehensive understanding

I see the document give a simple graph to point:

  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                                     |     0     | -------------> |     0     |
  |           | +-----------+                +-----------+
  |           |                                      |     1     | -------------> |     1     |
  |           | +-----------+                +-----------+
  |           |                                      |     2     | ----------------^ ^ ^ ^ ^ ^
  |           | +-----------+                      | | | | |
  |           |                                      |     3     | ------------------+ | | | |
  |           | +-----------+                        | | | |
  |           |                                      |     4     | --------------------+ | | |
  |    PMD    | +-----------+                          | | |
  |   level   |                                   |     5     | ----------------------+ | |
  |  mapping  | +-----------+                             | |
  |           |                                     |     6     | ------------------------+ |
  |           | +-----------+                              |
  |           |                                     |     7     | --------------------------+
  |           |                                    +-----------+
  |           |
  |           |
  |           |
  +-----------+

If I understand correct, each 2-7 tail's page struct is freed, so if I just need map page 2-7, can we use vmap do

something correctly?

Or something I still misunderstand, please correct me.

Thanks,

Huan Yang

> of the fundamentals of HVO, I kindly suggest a thorough review of the document
> in [3].
>
> [2] https://lore.kernel.org/lkml/5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com/#t
> [3] Documentation/mm/vmemmap_dedup.rst
>
>> [1] https://lore.kernel.org/linux-mm/20250327092922.536-1-link@vivo.com/T/#m055b34978cf882fd44d2d08d929b50292d8502b4
>>
>> Thanks,
>> Muchun.
>>
>

