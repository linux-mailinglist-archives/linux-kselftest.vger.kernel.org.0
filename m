Return-Path: <linux-kselftest+bounces-22512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE5C9D8D79
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 21:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9267B16A916
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE31C1F12;
	Mon, 25 Nov 2024 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LZ88t0Do"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95BE6F06D;
	Mon, 25 Nov 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567138; cv=fail; b=fkJ6U+iYn885VoZOCW7WD+V7lmb6xn2hOby/fNMaOo39SENFHk/htVFhs8whCEk0Q6ssIcf2ksUDYz/ZFZaN3NnhuYp/KT5piOdUSEZb+MxoifEdoCOJftlQfCbwgE/fn6mCX/2yojEp+UysFwECXwTtiUJEXya3ZYYl2oCgvUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567138; c=relaxed/simple;
	bh=QKsvRS16dyf4BmIX0z0GYVMAnCjNwwRdIwjMl7x6MYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XHzzBIqi84M2wsrmQb5z7H6o1FzxV6NWU8x6pPN8iwDE9p29XhWDuP2iF9N+6vjTJvkk9LeVJCv33r/in8N2QXAxBFtfAyC9w2X3J0VjWkfHa5NepEqdwcm1W9DrtmjAaOyMxYPn4htVGnW+3LjNXWykRxyjgI7q1kbN1WUyXj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LZ88t0Do; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyrZJotIEEDYpofqh28vLP42pFZ5dGSJ8VhhEi0TqjgVFY6gLJ4nsbS3dRealoS6ALZhSeEVyqjq8w3wXeAE13ewoPzs4rnYOkDgZxOaq8TAQzrUOACRTyCpbiAH1MbmcwQ6OIdKFOm41bmko74bd/jVoEU9/yMaBSI8Kf+9EYWNRXVRnUR+qnhVuA0Dczyo9TT0iYid7W6kwN0Cehjjn16V/pwtSrLW2n1pN66QAtJu4cgkVfSCac3ygLtlsHhKiwIdwdXWSGM0JHkN6JkA4HGoJBiCPygcfKFU3inElVlzXA+2rIMjESOWKnYaPLJZz4ZdBzqeN1/uXkhfk0/www==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPgVx+084s7jSN9Wu+ApNvxZht9keamQd8VuLwMr1u0=;
 b=W4Oll8VCPTAri2anHK6CMdmOf02oJLPc+qzTaOTCFdrYiaz4ziCnIT17YStsV/vd+s7wlvYm32ymh55uZPYjPkbnVNuoOZH0icWYR+KkmB8KTpH6ij41BC1xZzHTM3ByXtHDtioSbV9n+Ktc8PY8JQxHe2onnt/wCE6i865XqrBTvIgKr99SpcMkBfBN5UmdB3Biu+LNURroxZjI3kPu659sdmCMxkKHSplq2XQg+QOeM6RnIUdIDa0OSL1gPNBJzAOIqGeFj4NnYLK9Z4tlLVy1+uRi5qVIgBu8T/rSA6Qmubj1ryge8dlvz5XCaM5sv0AS/RC005/EG+RAbB8NAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPgVx+084s7jSN9Wu+ApNvxZht9keamQd8VuLwMr1u0=;
 b=LZ88t0DobrgDodMzpsF9DiQdhY5QJiNk7i6cMZVCtCvogMrfxUOAA2pCZS3RbBvI7xtUz/BY67IWgvTFz+IX0nCilV+Ut5i9Xtj84YI5Pz5mo2KW5vePZqebrw1Zy+n6VU8A5nAFwSL00LWTSOphpA1VubaU7qaIxq62t4GjcQq0sKxt4skIPQafIlE6PFqT48htC19pLT4OIwb8h0bpP1+Z6ymRDZmJg/+dutBYdW2NBkNBv25kkjcwV4YH9f+3v0+oG/Pj6LbHw3lWOlFYq1G9IGiHNKTxjt+3fg8mx21hlTXcwFQeYYnE7yqWLHllUBrqklyOKo/e2kA3RPeOWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.20; Mon, 25 Nov 2024 20:38:50 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 20:38:50 +0000
Message-ID: <c737c8f8-5fd5-4acd-aba9-787009a8497c@nvidia.com>
Date: Mon, 25 Nov 2024 12:38:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v4] selftests/mm: Add a few missing gitignore
 files
To: Li Zhijian <lizhijian@fujitsu.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 kernel test robot <lkp@intel.com>
References: <20241122074612.1582161-1-lizhijian@fujitsu.com>
 <20241125064036.413536-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20241125064036.413536-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fea983-adaa-446a-9aa4-08dd0d912b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFpVVHlOTjF1aFVpRFBHSlZwQWFXUGNHK2lZa09rdFFBeGhzdFFhL1huV3dO?=
 =?utf-8?B?ZDhpWjhIRkNWSjVqakpYeGhERjhXZGJURFVEc1hUYTVHT0h1YmdaamxNeEJ3?=
 =?utf-8?B?V3h2eGZqbStTQXJKTmdqam5lYVVGVHRqc3I4T01kNjg2RXdKaC9telZJNmtn?=
 =?utf-8?B?a040RHljYk9ZTFp0V0wrZDVpSGZnUWdiRjBOa0hXbDRQSTFCTTljRHR0eEJB?=
 =?utf-8?B?bkkzb09EZ0JWQlR6VzNDYUlJT0h4NXY2Skt1bHh6ZC93TFNaVVhFMXdwM3Rn?=
 =?utf-8?B?Sks4MDdjV0dUQWdtcklockZFQ21qK2JVWjZKMFpNNmM2SVp5MDFGTUUwbGxG?=
 =?utf-8?B?WlZmT3RWWXFQVDZjRmdZc1lmR1dlZDFGaERtNDE2NTY3MlFpb0VxTWRiRHpK?=
 =?utf-8?B?djFabW1aVlA4RFZyTUJFa2lObmNaY0xMN1I4NnladERiRkVaa0M4YlpQdVlq?=
 =?utf-8?B?WHF4bjc2TFZDN2tuQ2hQNk41cHJ3cmQzNGJjL2pUOGJoQ01HWlpLWlNkSjdE?=
 =?utf-8?B?b1BLbGkyYjhGZmkvOVhjQ2FnejRmaGpMb0w4bTdySCtiWkhtTDd6WnhpK3FN?=
 =?utf-8?B?T0tnbGk0VmV4NEZLRWhXK3l0ZUw5VVEyem4rcnZlc1I5TzkrMGVzZExGWkJz?=
 =?utf-8?B?VDBkWTZjdnNtMGF0UFRrZnJJMFhZc29Gb1lqL3hycmMxdm5OcDBxenJaU0h3?=
 =?utf-8?B?QUZKbXNoVEE4VE8waWhFZE10U0J2aWxoVUNCK2VjSm9LUlFwSVpSOWhNdGcx?=
 =?utf-8?B?R1U4dFVXSXFqZU5wdlFLTTREVzNwRjJTK3dYVUczT1BBOVNDdWY1bHNGQzBz?=
 =?utf-8?B?L3M0VE5WREJBNDVjRFN5UTl2L3l6ZS95MFBzcUNjVlY3OWlRcnFON1FMQXlN?=
 =?utf-8?B?Q1J3K0tPUG9YVDByKzVZaTcwc2RXV090K0tXcThYOUE1RVMyQkJIamZrMnJH?=
 =?utf-8?B?TS9lcytjSWhwTHpQKzhrRVZsVEZCd0gvbHZnNnhKKzVWclFrN21sUEJabGkv?=
 =?utf-8?B?UEJUbUlMS0FmeFJHclZhbFBLR3NrSHgyMC85MFNNMXVvTVhzOWhoOFBWWExY?=
 =?utf-8?B?YTM3ZGJmaHBZR0czN2I3aXVHTm5sbHBLWFppQlladWt6MGVWQ2FCUlFER0F5?=
 =?utf-8?B?VkV2VDRQNEg3OGxnbFdxVTJpV0xMY3pFMUFCbFZqRi91ODBGWjVNQlZiUmNL?=
 =?utf-8?B?cGtmMlU3WVVyMkFORjNaYml6TUhyTXI5UllBNUJ1ZWlhUHEyLzRWdit1YWUx?=
 =?utf-8?B?QWRyQUZRQm5ieGZQY3JDM1N3WDJhS093WEJZT1BYajFCZkd3MEs1NUJldyt6?=
 =?utf-8?B?M29uMG5YQ1ZxN0tQc0dYNjkvcDY5UC9rWXZpbThIOWErU1pHQml2bkc3emVl?=
 =?utf-8?B?dHVlcWJXUnVHWlozaGdlNlhMcE41UE9ubVd5MkVya21kS3hTWXhCMjlTb2M3?=
 =?utf-8?B?bnhWMmRKUTQyRmlGYXhFQVVSejlXcGJEWHp5N0hjdmFxL0JpR1NKRmFVRmEx?=
 =?utf-8?B?OTVjQ0UwN08wSHhoYlRJS1NIYmgyUnNGaWd3cGtCcXJjM3A5c01rK3hBNWNL?=
 =?utf-8?B?MUhTcm0yMTN4alNTRlpFcVprNklRdDRON1BscDNaejJFNzhGQlpVUTFyWnV2?=
 =?utf-8?B?eHk4NjVjbzZtcTFSYlBxbFk5TVBPT2F6Z0g2dlFzK1NEd0h2QlZXUlN5YkNi?=
 =?utf-8?B?VlRMaUxHNEkzRmhsNkRzYjdOMzIxRXcvNjRYeW00ay92Q09pemRLK3BnQmxH?=
 =?utf-8?B?anF3bTBmbWdWN2kxdU5OeEFYbUsvZWl3Nnp4aHFsaTlMbWtvVGo3S2tjbEcy?=
 =?utf-8?Q?111ZWryB1kmKACaurNKZ3/Abw0xB29YEc4YP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3N4Q2NidTJIc3VyVlhEbTVUenpLVEMzd2lBMmt1WllzaFk4MWhOakhhM0lI?=
 =?utf-8?B?cnFteTBNZnhQY0lDSmEvSXd2dzF1TDI0MS90eUFwNkZ0VnQ3UGx1VzVGMFBI?=
 =?utf-8?B?eTZlK2FLYnU2Mno4VXRnV09DUUNWM25wWWQwZnVWaTdwWVNmQ1RNaWl3a0hj?=
 =?utf-8?B?cnRVNDJyM1dDSFFaa3dISStaSDdSZTBCNk9RRkVyaVFUNHdkOTN6SGhLNzAx?=
 =?utf-8?B?ajgrZzVPaFdYRlhmNlVCZ2FtODVaNXJCWEl1VkYydlpqbmJXVWFlOXp6a0la?=
 =?utf-8?B?d0JkZ0hEZm5ObGtEZUhBdlIreVZFZW1zMkZlK1dOSVg2bkE3a2NObU85c1ZW?=
 =?utf-8?B?b3NPZnBXMHdKTmZ1WHlBRVZ3R1QzeUh6U1FhY0RIdFVWbkRpbmdqbGk3V2lD?=
 =?utf-8?B?ZUlvSmVXNlZkM0hRcGtUV1ZaMjhidFNWNXJUQXF4QU1NK0JFa0wxS0NqQ2RL?=
 =?utf-8?B?VjFaSStob0oreFRyL01BWFd5dmdEeXJhajVhR0NGSkUzUnhzKzRzR3RHUUdC?=
 =?utf-8?B?eERRcEh5QXdIR2Z5dVhhWlF6WklveXZGVk5sTldvSkViMFl1d2E0L05mT3BR?=
 =?utf-8?B?YlBRRklrMDAwSnN4VjVPYWV3L0VVaCtHVkVOYlF5Qjd2b1BqZVlMbFJwV3pV?=
 =?utf-8?B?OHJFeXFZdHNPZEZFRENaWENQVjJBcXhjUEpQM3lUMGV3R1RzTUxTU2FNQU5y?=
 =?utf-8?B?N1pzbm9ocEpsNEc0RVZHSlJTNlhtdjhsUGUvdTIyY3NOK0hmeUpXVmY0SHFW?=
 =?utf-8?B?VkNpaFJnZlNZOEhoWDg0eUd2RVNLdERGd2xrbW1yL0h6eG5nUmJwbXZxUXJu?=
 =?utf-8?B?ajMrMWovbUN5RlFCaGFJbTI5cHlpSFRMcndQdFBYa2RDY0laeUlXZHNtL2ts?=
 =?utf-8?B?b3U4MnFyM2J6eEJrNmJNZndOQ2Y2cjlYRHVYd0pGRFZWU2l3NHR3cWhaWUo3?=
 =?utf-8?B?TUQ3djkwTGNmaWluNE5TRkVhQkttZDhwbHA4d0RyQ01SK1AvTXljVzN5UDFQ?=
 =?utf-8?B?cFVyWkY1TEYwendZejF2MW02UVpiejJsVnZhaUEzSU96TE1ZMTdZeE95OEdW?=
 =?utf-8?B?S2RQWGZrS3RlVzNJVVJmOEVsMEgyRTJ2TE5aYjBja2hCWlRUWkNJUlRRZmlY?=
 =?utf-8?B?dG1CajZ6RVBSR1VXUmRuMEVML21yWVJqeGVuTCtHSTE2YzJhNm9TSFhoM0lK?=
 =?utf-8?B?RVdCeG4zZEQzZWl2RlF1Yi9GdCtSN3p0NUQ5YnR4NFd5Nm9SaWp3K1ZDb05E?=
 =?utf-8?B?S3F2c1NaN2tENFkxV1djNzVPZXBHY2N5SjBhTVE3NEhKd1NSVkd6YVdvOU1m?=
 =?utf-8?B?ZHMzVjVycDJPZEpmNHMwVU5ndUxMdVhPQlZNZWI3aWw5V2VDaWFINllLT1o4?=
 =?utf-8?B?Zy83YjY4NU1UOThHSU9FYlMxUzlMY1p3UlBrQlFtbjNJZEkrYjFnd2tPWnhY?=
 =?utf-8?B?Qm9UYXJsNjQvM0p4NWhLT0pyakZJNnhFVy8zYlc1alpBTk44aUx3bG94eVJN?=
 =?utf-8?B?cmdXTytyQU16akxYSUVCWVJJcDhmTHlFa2hBa2NKaVNRd0tuNlI4VjNIYTI2?=
 =?utf-8?B?cXVUekwzSHZTcDNJd2lIMFVxdE42VndGLzNmNW5iQ2xmYy90TlpMT3R2S2s4?=
 =?utf-8?B?STN2cWl0NHgzY0k2MUkzc0tVcExPbEFPd1NIdHRBSk1DbjBScGdZbmJpTWFj?=
 =?utf-8?B?VDFBaUFDT1YvY3VpRHhNTEdBbkFXRnhhc2VmUTFYRzBQczRaNXpJY1VBdHFB?=
 =?utf-8?B?ZGhhc1E2bjdvUTN1Z2tqS284aTFhMTdmSFZ0aTNKL2orL3poclp3QzU3UWJP?=
 =?utf-8?B?WFVNU0RBNEdjK3RabXRyaFlVQkR4SlBNN1JBMmdkOWxOSVhDblRscjdqdUtU?=
 =?utf-8?B?OXpQeUlna3JYTUtxRWZoM0lpcCttVGR2dHdyc250alc1YU9uNmRNdFdDeGpQ?=
 =?utf-8?B?SmsxK1pBVnFUN3hJVnRzRXBVZFFhdmlkU3pkZml1M2xoZ082eEhoTm1pVGFK?=
 =?utf-8?B?WFliMlVNQkxuWlFSaE1iRUx1aFdrNU43ZUMxekgrMXFtK2pJR2ZRakxtVkti?=
 =?utf-8?B?cjBrYjRHNGNmUVNrSFNldk5aa09OeC9PSHoyTTZGTExCUWltWlQ1Q1pyekk3?=
 =?utf-8?B?b2JQblpzWWlmaGJDZ0VreDB6bDJMa2FFa2tLbEx0SitrdnpRQW1Ba0hEUzB6?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fea983-adaa-446a-9aa4-08dd0d912b0d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 20:38:50.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkOK+8vwOFs8582790p8zvET7P3jN/PCD2HSnueb1UWy4koDPg9w/SrQ4xDErpKpgzvfhbq6uu7++iEv3N1ucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

On 11/24/24 10:40 PM, Li Zhijian wrote:
> Compiled binary files should be added to .gitignore
> 'git status' complains:
>     Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>           mm/hugetlb_dio
>           mm/pkey_sighandler_tests_32
>           mm/pkey_sighandler_tests_64
> 
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
> Cc: linux-mm@kvack.org
> ---
> 
> Hey John,
> I added your Reviewed-by tag in this revision which have a minor
> updates. Feel free to let me know if you feel this is unsuitable.
> 
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V4:
> 
>    Use the exact filename to fix warning reported by lkp@intel.com
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411251308.Vjm5MzVC-lkp@intel.com/
> V3:
>     nothing change, just resend it
>     (This .gitignore have not sorted, so I appended new files to the end)
> V2:
>    split as seperate patch from a small one [0]
>    [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> ---
>   tools/testing/selftests/mm/.gitignore | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index da030b43e43b..689bbd520296 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -51,3 +51,6 @@ hugetlb_madv_vs_map
>   mseal_test
>   seal_elf
>   droppable
> +hugetlb_dio
> +pkey_sighandler_tests_32
> +pkey_sighandler_tests_64

Makes sense. Yes, this still looks good.

thanks,
-- 
John Hubbard


