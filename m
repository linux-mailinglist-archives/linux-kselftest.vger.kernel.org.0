Return-Path: <linux-kselftest+bounces-25212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB05A1D08C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 05:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D5A7A2B17
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 04:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDB115DBC1;
	Mon, 27 Jan 2025 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EC7gW5tf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958B37160;
	Mon, 27 Jan 2025 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737953895; cv=fail; b=O/Ql1qSLpD0VZbVIeXViyxbfIcnnoyZsCp5TLA+I6oUpIxIcmHM3JDscpm5F725oyHfkNH89PL5FkypgHAzlOX5Z2bgHhB5MgIaBFPwtQ8XT3CQaoLTYEYNHmoAzl8sKS1DXwK4nbjDy7+w3i6zaQ3O/CW/sNNOuT/OTenHQzP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737953895; c=relaxed/simple;
	bh=3aRN6j/dOWqH95QX0LV6WZCI9fY+Hc5G2k+i3aDVcIE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rug8NWbSudV5URdgsg+SDT0YyXkjguGi7EUXUZGBLh9wrrES7nDlUfEV/cZ8rS9mMvb/q6LuSbooY1DCrcQ3tOpGsBQF98qZhkeB+hnPIfETMcgRpU0492pijVmY7k+9MluvuhuX7z5D8EXlr982QzVs7iX7l0RyRLH0tjTNLeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EC7gW5tf; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx4UrN3lOe57NkzLImpCbbLvm1TG74NvxCmDFp6ECiLYmj6NN7hLpOFEw7gH+4qcSzLoHu5s+nFezggk4vONE2CvqGXs58HtusXA7Z0lbh6ky0gqKR9mnK3ee2TpyIsd7ViJGKKS5X161153wCkPbamtYnGLaZTwKjXA+I3uT9Db/CQXWfX/zX9U8WSy5QK4EQahBudSjWWDu3132eAFvmCuGuC6KRKBqZD5VZ+xI6Il6U//BsByo6jZQpUge3I2pnsWX+gkLs/+S6sVpSbrxndCzDqw0d0mmNQZgyWntog0BllhOGa11dPxY07p/2dlb12cp1hqpAxfojBoj0m/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqG7hnN7afS5CfImZD4pTqaVPydoymf9GuTLe+vqDaQ=;
 b=rrCkIlzp7g1yC0L7xJiTnisymVqelxGwhekij+CcPIWODM381O8Ox/BjhIDhEMNQUuxi7Ft6ngfUutg468Ei5EGQsCSUn+FBoOFM4Tv7kaemfgR4rrtZuOZhS293VCevKTRfB9IacZVDpWNaasDy25b2vIMtxWktsswiNwHJn6rfBYF8wzZgSvsJ0/yuSsa6Ill9z2uirf/TKHe9ZfL5qs28iEQEnYjJyH878YGS/eT6ecZoImO/pbOQP5+8XecNHDTVaAHZ8d0bAws1ACz3KEUNp5WKi+fQ2K3ITfFAIEz7T/pD9+AM9dIcr50+U19mm0MAQXOrhAPm69+QIsXsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqG7hnN7afS5CfImZD4pTqaVPydoymf9GuTLe+vqDaQ=;
 b=EC7gW5tfOPaaR3TD5VDM7hU4f3lDgQQngVocVU6KELX34IfbpmzrlxLnPK/8WEiTTVlqLvPSm6+mMSJCrZvzrbLbut6N1XFzW4dWafG28Yun7clZ+hK9mIVAgRbeCYX5D4fKnQA9oy8oKlUdG4XWFvPU+qsx0ZiN4ufp3lbUB+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Mon, 27 Jan
 2025 04:58:09 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 04:58:09 +0000
Message-ID: <33969c83-966c-4c7a-a68b-f5e46912b725@amd.com>
Date: Mon, 27 Jan 2025 10:28:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add support for the Idle HLT intercept feature
From: Manali Shukla <manali.shukla@amd.com>
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20250103081828.7060-1-manali.shukla@amd.com>
 <1d988e21-506b-4dd7-8a55-649ed939ef56@amd.com>
Content-Language: en-US
In-Reply-To: <1d988e21-506b-4dd7-8a55-649ed939ef56@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d48714-2d23-470c-0c83-08dd3e8f3181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0J1RGE0VktxNjVBaWt3V2kzRzFCbmhuYzRLR2JRKzNENzd1eVNvWjhtTmZG?=
 =?utf-8?B?YklNd1J5NWJpUnlNWXpxcHNYNXVTL3NEdlpnVUZ2cHdzYWVESkg5anlPd2g1?=
 =?utf-8?B?RW1pdjNyYm9EM1FSb3JIZjZaVWxOWjVnUzJrTHFjZnVOcGd4NmEzZDc1bDFT?=
 =?utf-8?B?MVlwa2JucFFTOEVjSkxpNmRsNm5UNXltMk1tNXZuRHpLOEZSckczZVBIaGlI?=
 =?utf-8?B?MTY3bUpXODRmYVVkaHJBSXk3S1VuMUJuYWwwMU02dkFJMWR1T2xUc0dRK3pU?=
 =?utf-8?B?Z1RoSHh1eUNkbmRUT1ZEclFiWWVmTnVxNktiWVJqTWk2SGcxeFNMb0VzLzNx?=
 =?utf-8?B?bG9HNi9qRVkvRlZwdVZsUFZ1TXhnYUM2anVNUEVpMU5kM0N4eGQ5dHBhT2FW?=
 =?utf-8?B?VnBNVUQ3Y0ptSUlHYUhqS1VDdkxJZzBCZUdsbFRwbHBoK0pyM0hYQTZpZTEx?=
 =?utf-8?B?cURMUnc4dHp4M2J4R3Ayd3F0djZkdkJta2dlVWcrWUtsT0RrS044ajlNRGZ4?=
 =?utf-8?B?R2JWMEphbEk0aGhyc0VuYVdSbWVBOWpRMHNGTlFZNVZ0TTVZWTR1QkxqdFNC?=
 =?utf-8?B?WXhvb24ydXNvbm4vMEZGMzJoNExvd3A2WkhXb1F6N3cxOGtoYnRmajZRSTd6?=
 =?utf-8?B?dzViTHlwTE5Xa3ltTGRma3ZKTUs4MXlBSGpOL0JYekNId2tRcWFHcDRhQzFM?=
 =?utf-8?B?SHJJVGZSeTNMNjBrNHhQODlMRTJHaGFWNzlqbmJLTWZYRHJ3RExKY2tHaXM1?=
 =?utf-8?B?M0xPVFhMRytpR0xJbXlPU2RXRHVFWUVJaTB0N1RlMjJjcjVERGo0UjdxMjFC?=
 =?utf-8?B?R1hFQ2g1NWxnenpwczNneHhEQ1RUejF4YndIV1k4TUlJbGdVRzZOVlFDRWlG?=
 =?utf-8?B?L2xsWjhoYm1TTU0xUUtGUWdmM21ieVM1N1RzL1Q5Qk15d3lVb00reHl6eUx0?=
 =?utf-8?B?R1lRY09XMXBXU2pCZWwzZVZGK2JjSUt0am5MRjFpclh1OUo0ZXhmRTBINklv?=
 =?utf-8?B?R0VTVklPYW5ON0M3L1VOY2prTUJqaFBnNGJjSVMveUQxeFU1RXJsWEYrTWQ0?=
 =?utf-8?B?c09uVkZtL0UzNzYzaFRLdVNKZWJ1RlhHb3VQSmJaRHUrR3kyMjM3UzAyZk9F?=
 =?utf-8?B?UHo5b0R2VmdPcklEYjdmQnZNOUR0YWd3ZlNPM09Nb1FCMXdrcjFVSENpNStp?=
 =?utf-8?B?ZWpTNEViZUJMdGNXWlVibmlXSG56Y0trRHZ6VEk1VXBZdGlWbW1hV3dpTEZ1?=
 =?utf-8?B?VVQrclgvZzZWWUpLclhOU0NUVFRuYTdwcU9iRTFQTWUxYlZ3OFA5eWFQVXpy?=
 =?utf-8?B?ODBPblpLUitSZWg3eFdOVW56a1lidWZMdXc0QkJEV0wyaklrSDJiSjBrUytN?=
 =?utf-8?B?WDJZZjUrNEZobHJmaTVrem5naUg3TlhvTkJJOG1USzBFa1Y2K0xqMG11QUQy?=
 =?utf-8?B?M3ZZZzlGR2ZhV2dYWStTZFB2YS9ZRGw1S1RObm5HWnhBMm9iQnZkaEMzd3JC?=
 =?utf-8?B?SWwwQ0U1NWRaS3lPOFZFa3RkKy93dHZHbkhOWkU3YnRXaTgxSGZLemkzNmlL?=
 =?utf-8?B?VVRNYnptZ3RkVFlvT2VrL0duSWZldklLbS84aEg1L05kblh3NmcvME02czRH?=
 =?utf-8?B?dit2NVlKc2pMbGQrODMzdVZFNVZtSmJocFVVTTF0YjVpbWlRU3o2aEx0TFJt?=
 =?utf-8?B?S1M4ZFA0YzVDTldqVUt6b2szRTJKSVNsS1JDZ1VpR2IzZW1OUFRzM2NwNGZC?=
 =?utf-8?B?U0VEd3YrbUl0eWFnLzhQdGRpRmNORnFIZWJzUFg5dnZmNGJ2OWJvRHNtR1hu?=
 =?utf-8?B?ZEMwODh1WWw1Yy9KYmc3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmVmNCtIaWg0VWtvdGhHMXkxU3V1UVlDb2krMnQzWTk1MEpqdnZlSDhoM3dB?=
 =?utf-8?B?eSswMFp0a1NRbWpKbTBGN3BkbVNDRGgvbzBWRm5zZGJQWStaUTFwT3grS3pB?=
 =?utf-8?B?Vm56T3hjRUxQRndxYXFPTkFjcEVkNWxlVllZd2NFTjhYMktQa2FEOWhlSXRX?=
 =?utf-8?B?R2FNYzhyUWE3enVJT1Z5aUR2R2tNODJLN1BPSWJJQi9uV083QmtJaE5vdzZ2?=
 =?utf-8?B?dUI1MUxDTVNReXAxeG9qZERiZysrMXpiNWo4b2NER004ZSt4b1NBamNoYUFw?=
 =?utf-8?B?OUo5c2dMTzJyRWxZa3o5UWVTNzN6OXVtR2VOYmxiaEowTmZkOU4yWDEzWFpR?=
 =?utf-8?B?bmhpd0U3Q3dwYmVjajJEdjNhQWZJTmxJVW15OXN0V3BaK1N1d0tvdTl5TEhL?=
 =?utf-8?B?ZjVmR0xBeUNuOFZ0VzlIZnFQNGVNcDFBS044ZWMrQjVSaXNPRXhaN05OeUtJ?=
 =?utf-8?B?d0JjMWNDQXJ4cThkSHNVWlVzYWFNUkNOWkNlYUR5YW5WYWNRaDlwM3VTVzZy?=
 =?utf-8?B?U3hCY1ZaTG1qOWptRnB4OE1rc3RucC8wVEMxaDl6OWprRXRzV0t4eXhwMEZr?=
 =?utf-8?B?cVJkTFVidEd4MDA2WWVoTE9lYm5wNjN3L1IrVm9pelVRa2tTUmRDdFVaS2Rw?=
 =?utf-8?B?dUVFT1orRnJPS1ord2hiV1lZZkN3UUJKT3lHcVhaWmFjMlI5eXUySG5sUTM3?=
 =?utf-8?B?Nlk2NS9TaEQ2aDBqeUZKMkVQY1FieDl5QTZzNWJFV1dCL21qZkk5YnJTUHI5?=
 =?utf-8?B?R3hiT2JsZGdRYjlDMHdJRUZBUTJ1NSt6bEFvdG52MC9rcFlwUmszMVVxVHJV?=
 =?utf-8?B?MWF2UVpRc1ljNjJqQzRFaGdrSFVTdm9SbVM1Rk44VW9yNmJkNDhlVWVoSU9p?=
 =?utf-8?B?YXFIRi9nSGpxSmRnSlc2V2VGWVhSSG85WFQxTkhKUyt0UU5Fa0doSi9qeVFm?=
 =?utf-8?B?TlBwN3J3bUhPdnlpL08yK0lZeTNKQjFkMEdrWW92cVVYZlE2LzE2UTFZVDNQ?=
 =?utf-8?B?dElHUi80cGVpSDU3UGJuc2hqcWV4aWpLcGY1SUN4dmZoeTBpcVZTc2RnalYr?=
 =?utf-8?B?ZUZsUmN0Z3prZEY4L3YxbWRLTFVDak9BcFVYNFpSNUJHRStPNURPVmIzbExx?=
 =?utf-8?B?RURRc2s1N2t5MWRhbVZvWFlHVWh6Zm5wVGFtYnB3dmEvU2hhNStHR1laVWJ3?=
 =?utf-8?B?QjUvek5OZGtGQ2s0c2oxT2RBR0xJVko3WDMvZUZLNGlRZlZEYzY1SEVLUmVL?=
 =?utf-8?B?Y0t2Q3IrRDJuVzB6SjJlVGJtY0YxdG52Z0dtRHdSTW5sWG5CT3YvdlNUeGx4?=
 =?utf-8?B?MEk5VWVJa3pTOVJUNG5BVWV3elVNb3BaS2diWHNvbDhGWUZJQzEzQmhtL05j?=
 =?utf-8?B?dzRhWDRjaWFucUlOSjJxa0szelQ4UWVFSnRWVUhJbkZPTWtvNFFlQmpiMWRK?=
 =?utf-8?B?cUY3SXVWcjFNMmlpNm1NZTl1c2IzdTlDQlRPV1l2THgwc3lFNDNYN2tVTEo2?=
 =?utf-8?B?ZGhGNlgzM1l0WEEweFQvK2k0dnkxZENTZ0NyL1djZDdnV3NOOWNJNDJ2SzMv?=
 =?utf-8?B?U1YzNGxCQzEweFlFWHlaZkN3N1J5ZXlCYnAwY0RwQUR4WG1Ka0YvV3FyV0tN?=
 =?utf-8?B?YlF4akdrdC9qWGRxR3J0bHk4RDUrTVhYWTdSZGpoTlN5c1lJRndQa2Q1OXgy?=
 =?utf-8?B?Nk1HdjJjNDJzdGd5RFRDWnBkcGFYT0tPTGJZQ1p4UWFEUm15Sk5uK0p4ekRl?=
 =?utf-8?B?U0FFQjRzd1lac2VjZ3RndGZlSHpKNVFObTJ2a0ROK29ST09DQ0gyN2kxRUhF?=
 =?utf-8?B?ZGlWeVNsV2JBZzRSeFhaUG0vNnR6YTIxZDZ3TlVrYUVreDR1bXNveVV6d0Jv?=
 =?utf-8?B?REFKSTNmODJRN3o2UzJ4Ui9pR3BuNUJCV0c2cmt5SHdKZ3RkNjNMd0RXZDU3?=
 =?utf-8?B?aVcxcmVLQzNGSEljcno5d0VJb2VpQStVOGhneHBqWjJFSSthSC9FNHNMVjRU?=
 =?utf-8?B?QXB4OElnZk00UlVLMVcxMXB4bWhXZFpTYWlYTHdtVDZFMUdhV2tCQVpueXhq?=
 =?utf-8?B?TnNFeUcvZE9ZaGVpdWhLbVQyQlFOTGVsbnV6ZDBORGVZZ2lDVGprVEdDZFNj?=
 =?utf-8?Q?2nxWVMre9yJwlaf2BUgtO6H6J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d48714-2d23-470c-0c83-08dd3e8f3181
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 04:58:09.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MwcckxjCAZKejev0WRoD2jOVpTXXkpkouxVw8LXZonpe/vrnsa1rlwc5vU5iXTKM+FDqAwdb1tyDmyh82LZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

On 1/18/2025 7:11 PM, Manali Shukla wrote:
> On 1/3/2025 1:48 PM, Manali Shukla wrote:
>> The upcoming new Idle HLT Intercept feature allows for the HLT
>> instruction execution by a vCPU to be intercepted by the hypervisor
>> only if there are no pending V_INTR and V_NMI events for the vCPU.
>> When the vCPU is expected to service the pending V_INTR and V_NMI
>> events, the Idle HLT intercept won’t trigger. The feature allows the
>> hypervisor to determine if the vCPU is actually idle and reduces
>> wasteful VMEXITs.
>>
>> The Idle HLT intercept feature is used for enlightened guests who wish
>> to securely handle the events. When an enlightened guest does a HLT
>> while an interrupt is pending, hypervisor will not have a way to
>> figure out whether the guest needs to be re-entered or not. The Idle
>> HLT intercept feature allows the HLT execution only if there are no
>> pending V_INTR and V_NMI events.
>>
>> Presence of the Idle HLT Intercept feature is indicated via CPUID
>> function Fn8000_000A_EDX[30].
>>
>> Document for the Idle HLT intercept feature is available at [1].
>>
>> This series is based on kvm-x86/next (13e98294d7ce) + [2] + [3].
>>
>> Testing Done:
>> - Tested the functionality for the Idle HLT intercept feature
>>   using selftest ipi_hlt_test.
>> - Tested on normal, SEV, SEV-ES, SEV-SNP guest for the Idle HLT intercept
>>   functionality.
>> - Tested the Idle HLT intercept functionality on nested guest.
>>
>> v4 -> v5
>> - Incorporated Sean's review comments on nested Idle HLT intercept support.
>> - Make svm_idle_hlt_test independent of the Idle HLT to run on all hardware.
>>
>> v3 -> v4
>> - Drop the patches to add vcpu_get_stat() into a new series [2].
>> - Added nested Idle HLT intercept support.
>>
>> v2 -> v3
>> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>>   a way that each architecture can share the generic types and also
>>   provide its own.
>>
>> v1 -> v2
>> - Done changes in svm_idle_hlt_test based on the review comments from Sean.
>> - Added an enum based approach to get binary stats in vcpu_get_stat() which
>>   doesn't use string to get stat data based on the comments from Sean.
>> - Added safe_halt() and cli() helpers based on the comments from Sean.
>>
>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>>      https://bugzilla.kernel.org/attachment.cgi?id=306250
>>
>> [2]: https://lore.kernel.org/kvm/20241220013906.3518334-1-seanjc@google.com/T/#u
>>
>> [3]: https://lore.kernel.org/kvm/20241220012617.3513898-1-seanjc@google.com/T/#u
>>
>> ---
>>
>> V4: https://lore.kernel.org/kvm/20241022054810.23369-1-manali.shukla@amd.com/
>> V3: https://lore.kernel.org/kvm/20240528041926.3989-4-manali.shukla@amd.com/T/
>> V2: https://lore.kernel.org/kvm/20240501145433.4070-1-manali.shukla@amd.com/
>> V1: https://lore.kernel.org/kvm/20240307054623.13632-1-manali.shukla@amd.com/
>>
>> Manali Shukla (3):
>>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>>   KVM: SVM: Add Idle HLT intercept support
>>   KVM: selftests: Add self IPI HLT test
>>
>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>  arch/x86/include/asm/svm.h                    |  1 +
>>  arch/x86/include/uapi/asm/svm.h               |  2 +
>>  arch/x86/kvm/svm/svm.c                        | 13 ++-
>>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>>  .../selftests/kvm/include/x86/processor.h     |  1 +
>>  tools/testing/selftests/kvm/ipi_hlt_test.c    | 85 +++++++++++++++++++
>>  7 files changed, 101 insertions(+), 3 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/ipi_hlt_test.c
>>
>>
>> base-commit: 13e98294d7cec978e31138d16824f50556a62d17
>> prerequisite-patch-id: cb345fc0d814a351df2b5788b76eee0eef9de549
>> prerequisite-patch-id: 71806f400cffe09f47d6231cb072cbdbd540de1b
>> prerequisite-patch-id: 9ea0412aab7ecd8555fcee3e9609dbfe8456d47b
>> prerequisite-patch-id: 3504df50cdd33958456f2e56139d76867273525c
>> prerequisite-patch-id: 674e56729a56cc487cb85be1a64ef561eb7bac8a
>> prerequisite-patch-id: 48e87354f9d6e6bd121ca32ab73cd0d7f1dce74f
>> prerequisite-patch-id: 74daffd7677992995f37e5a5cb784b8d4357e342
>> prerequisite-patch-id: 509018dc2fc1657debc641544e86f5a92d04bc1a
>> prerequisite-patch-id: 4a50c6a4dc3b3c8c8c640a86072faafb7bae4384
> 
> 
> A gentle reminder for the review.
> 
> -Manali

A gentle reminder for the review.

-Manali

