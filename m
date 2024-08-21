Return-Path: <linux-kselftest+bounces-15899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1268C95A4AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 20:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B27BB20DA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 18:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469E1B3B36;
	Wed, 21 Aug 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MQRqN2x0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IYLo2v7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D831C1B2EF8;
	Wed, 21 Aug 2024 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264772; cv=fail; b=hAsYCqICVocWYfzPqS2+w23U/q4cTwAORF9rxIbRsUCvcelSuIqzb/yssiAn4wme6Wd3A8PSJp/DadNexYheZdHlUwqN+m9GHm98kHIazWo+SIEkTFqyRNhgrBW63bcdshgAU9tOpMtSKl1fIkjIhi9bsMumdIyDhHT87VvwYOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264772; c=relaxed/simple;
	bh=FZOScwB15+A7/ZMnq2uKhhtkA/808+bmeQtoI8OEWDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CafZfcn+FH+joO3vxTAYktqxuZ5p5qE/S8xSnpa76KXhz3rHCp6EHt7ukwcSIoKmPSuTxr3NalBH3SGBqYHmdxRT4btMHXZUhaHOfXy45kWbIK9xiVeV7BVyFX3WiIK0xIwk9qtvxEpytSCSTIJlunj96ftfZED938x6kClWeTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MQRqN2x0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IYLo2v7Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIYJQ000959;
	Wed, 21 Aug 2024 18:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=r/xRjvejJk4SBZEXt0rxeiJnsqH2PWXh8nMI1ubhNKA=; b=
	MQRqN2x0qyD8ITKI5Z8OGmj4YwidRUdRiGCzw+7GPOi1n9wn0uUR1D+ALyXC+wm5
	RZ6GU7oy6sm/yBfyu4qb9kgQ9+NxcB7wwttMUBLGn0OXo+XnotZ57weWbApPuln0
	Wl6hlDN9rEtpkKAzQsaH7i2o07n8on1cObpJ7848SiXZRMYrBhcTdtjpObCraJX8
	FaZdzv5Q5ArF2NdqUWNcG5atDTP/pNmxW71ymaXVH4CTNMozUsPicc8hP/1selrR
	iaQAe5maQrjdIDzAWYFvyzsocpVF4wRy5FdFaKlviTMO4XbsSVYkKSkQdOleGRSZ
	J5Sjnx/p+E631cY9AOC5Vw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj2ha9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 18:25:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LIJhvT018407;
	Wed, 21 Aug 2024 18:25:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415ndx07mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 18:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9rIOFpTSkGKULdFLSWTRf4AKkw1PJvvxe4J7Op/Eqykfd0psIBJLyJlmxwHED/DWi94GgYXWNVcaWbLrxR6Hml5UqD6dsX7j0f6N74VayWHiGLlPmaR4jG0zbCZWFizH34AGiOU7EiD1+H1uAjOGtKg8JeA6UcaoFXSLbEQkeIm5O1+1EdlYVakgm5UoDRMbGJBnNettUr+WSn0hVneh7urLBW1lpcIxf46NqFtVxh+QwvI6A5kBEEoqoDQOyVmgPaxXHtQ1Vc8wBCBFSBqlTHlpQRODSxm47KIpuywzfYOpqDW6l5Vm0CuU4luT2CLaz+ey9VB+cyueZMD4XLlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/xRjvejJk4SBZEXt0rxeiJnsqH2PWXh8nMI1ubhNKA=;
 b=Y6+gRtxwLO6poJJg3bvppAMAIDF+sRhTsxYihS/j6s0IJtXNhEPewNmpt1bCPHz8F2bX2KCHyMQILfMMysnOXZSEKCSs4lom5+4O5qq97nNdEGhGJZn/hd7U50LpEfj44dSigDLcb7SQOArCS1cPGbEIFfqSJKbR4KqQ3SRbsiT7kpERyiHtYxVl9yQ+1H7AIVBHjaAPimgSWokp0xQo0Ej1Q9pKMj2QPPnvAZj78izGPyifzMV8UAa4r/OGwYb9Rg7lc6YTtZy4R9Yets4KVyuRZvmexp/Jp+qD+jEVsYqVpa2vaD98tAodKwY+nk7Mrc2ARPJdE0DJOAq0kadYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/xRjvejJk4SBZEXt0rxeiJnsqH2PWXh8nMI1ubhNKA=;
 b=IYLo2v7QpQpCvxobtGwZLyfBIbz72SNnqxJ5YQpsx4ZzooAJB/UxbOdNjwyHYc8spdjg5uEt8/myuPiVZzJ/rfd+gLBaj2tOPs+GtD6AFHHqDvux5JzNsc0JKfB7YlTJ4EHuWK7t59i92RNhjbvxi7VYiOadW26kMt6VeLpOjd0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Wed, 21 Aug
 2024 18:25:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 18:25:46 +0000
Date: Wed, 21 Aug 2024 14:25:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        oliver.sang@intel.com, torvalds@linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 2/7] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <lya4vngdchp6g3cjohfxjpbz7ehnmdxhcwfz7qn7ge75e4c7em@somajfleln5a>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>, rientjes@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
 <CABi2SkUBH+utreVMTd1qEBSvXTPM7Qc1GiwNKjVa9+EeZK8WWA@mail.gmail.com>
 <CAKbZUD1d5hXWUPVpUzPo=M33_eo9_sdMq6nVg-jd=-O-CpFjsg@mail.gmail.com>
 <CABi2SkUZ-OQFCNZcc0OMN_4YV8NoqrRu2HGEeFms+Ty6Bnofdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkUZ-OQFCNZcc0OMN_4YV8NoqrRu2HGEeFms+Ty6Bnofdg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0483.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 333a211b-0f69-4bcc-608a-08dcc20eacb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVpvRHBmcGpRSXpOV0FpZ1Z5QmR2a3AyWDIvTFVVN0FzbHFNS1VBQTlUNVdu?=
 =?utf-8?B?M2xXVUtqK3VXdi9FeGMvazkrYXdTdFFzSVpXTUZvSjExSUQzOW5LZUh1OGdx?=
 =?utf-8?B?NDZQLy9SVyszQlF6aDV6aVhJT0lUNWNSK0NGeUk0aDl6dE9rU0Z4bm5HanFr?=
 =?utf-8?B?czNBV0VNZDVZb3dSV1dmYU02ZXNUdjRYL1ZTcHIyYzhwZnhQVzVIbFNaemV0?=
 =?utf-8?B?T0hiQWtrenpMejNmV1NuSnhIeXU4RXNqSUM2dDUxVVRsTzhZWFJjVldZZVBI?=
 =?utf-8?B?bTZRN09IWU1waENWdmRONmlnRVV5RjFFL3c2Q0s3eUc0VVVGNnZIT2UwUWVM?=
 =?utf-8?B?T0ZPUlpSbitjMGhyN0ZrbXhSeFNXSXpHUCswWnZ3a3FWbjQ5MGJWbURyTnFy?=
 =?utf-8?B?ZVJFK0MwVlk1YzlaOWNENHRvT0JjcEF4QTl4Q0JOTVRubDBITXNZNTRIOGRo?=
 =?utf-8?B?eDRFVXVKdUpxS3pCZzd0M0drRVMxdThnQ0ROODkzS0xiOWdJcnA0RE9TZnZk?=
 =?utf-8?B?MndUcmFnUzlYNzd0dGREeCtMWUtzM1lCRUZZT0trVXdueHhyTzl4YUp5am5h?=
 =?utf-8?B?TDNzNXlNOHBOTWtvNkcvVThPQThKajZ4VW9nNVBGQU5mS3lQVTl4Sml6VjJu?=
 =?utf-8?B?YWdYS1ZsaVB2cmlGanBRK2xBc3plU1JGRFlwSGxKT1pqOTYzZHE2bHh3VjBC?=
 =?utf-8?B?WjJ5a0lVbmE2QTJGS2s4V3kvYzV2Z1JwR0RZeTE5cE5rR1RZQm5DdklGUjh6?=
 =?utf-8?B?M3VicHhYSHIyK3BxTUloakZlcCtJWXd3UUhzcUNoaThNSXErTTFYNURtdStx?=
 =?utf-8?B?RlVTblM1WjNhUmtwZElpb0NlTDY0SnArU0YzYnpNbXM5V1E2eVo2M0o1ZGhH?=
 =?utf-8?B?SGY4dGdlMFovdkdhMmJJZWg5eExIUHY1U09JYzh4YTNKWEJraEJEQ0J6bUpO?=
 =?utf-8?B?WGV5TURWa3hQeWxpajRnQ2dKVXBORldZV0VLUzVzOFZyVDV3Y1lJZ1JnbmhK?=
 =?utf-8?B?SzdFUU51MlJXYXlEYjhoenBueEtSS1lkV3FTRDdKZm5DMFo1WXNRVlJEUDF4?=
 =?utf-8?B?NWRPWmUvTVRHbi9GRndrY3dWNGg3b3E1MmpKamx3bllrcUpySVBSbUFqQWVE?=
 =?utf-8?B?NlBvWVd3cExrVnAwNFZnbWN1VU0rMFFEM1l4S2VCNmFwY2dKTlhqOHA2RGRk?=
 =?utf-8?B?UDdkbHFENnRmMmJ5MjR1TXF5aFVvU0VidUs1d3dla3FZVXp6YUtQaHRydG5Y?=
 =?utf-8?B?QlR6a2h4bmlMVE9mZ3RNb0dLUlZhTm1NcFhiQmlaRzUzWTc2TVVIdVpCaG5Z?=
 =?utf-8?B?dmN6czVNQnZZVi9lV3pTMXYxWkdDVlZBUlhTWitSRVJXbGpPbndka3FlYkdP?=
 =?utf-8?B?WG9Pa0xvazdPUlFPSXo3czFlTUlWZUFrd25yZVJOZUYxRFdlaThhTzZRYjFR?=
 =?utf-8?B?ZFFtOUc4clp5b1VONFNFdU9Vb1E1Mk1TRWhBNnVRZE43UnJCaVJ0dTBpVlJ2?=
 =?utf-8?B?bDl5bjhXT1pHcXBlTkxVcUhOZHZ6ZFlDa05aSWdCY2x0VXFYOVpTMDBHNGN2?=
 =?utf-8?B?UVFSZlU4RmdKN1RiYjRwTkJRMzNqVkluVWdKNFN2NzBVam5OTk1nVGx2QlA4?=
 =?utf-8?B?d2UvcFlpd2I5TkpEaGVzVlNwanNsWWZvTS9UYVRDNHhQU09YVlQzZmlxb1BW?=
 =?utf-8?B?U2l0ZW1HVHhsc0I0ZUp6cUc5cnhtelJKbjR6ZlREakdYWGQzY2d5blgvQnBP?=
 =?utf-8?B?N2lYa1JXRlJnSmVadGJGbVp2bE5GTVA4SzhQWGl2ZDIweFUzaUNDRzk4SFZo?=
 =?utf-8?B?dnlnem53bnV4THphQlcxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEFORjBkS3lrRFY0VUpONGFnc1FybExhamtad1VkY3U4cENaSUdtQlJkYkRB?=
 =?utf-8?B?UFV4cmVIUTZWbjY4M05Hc2xVR3ltNS9MVWVhSy96dGpVSnQxTGlMamgwa1Ur?=
 =?utf-8?B?aHBpRFVHVzdiMC9YMmJSVWtNMG15ZU4vWVZVcVhwd3AwSU1QUmNYTFRJVDAv?=
 =?utf-8?B?cnV0RnlNMFIzUms0NytnYUo2dTRUM0ZlcnpEd3BWVjk3Z0JxUGR3RFhmYXBU?=
 =?utf-8?B?d2Y1RlpqUzd3M25lRkdEdTdEOXRJR2pQUlhPSlJIUFRWR01ScFBFZUFFZG9l?=
 =?utf-8?B?bzBoOW1GK0lRcGlpM2Z5MFBMN01OcmJZRS82amYzRzlVeEQxNkN5WFR6QzBu?=
 =?utf-8?B?QUxRcHBvRERwNE5lV0NjbERxUFJvbVMyVkFGai9Pb3pGKzRhZHErN1JhOEU2?=
 =?utf-8?B?UjJQemlaSXlQczNvckJPbnVNNi9aSENjWXBUdHZXVjl5Qi8zdlZ1WDJuNGxE?=
 =?utf-8?B?RXF0enNpakE4UnNiNEJMakVFclBFNEt0a29KWXozcU9NVnk0ZXU0SE53WlFq?=
 =?utf-8?B?UENtc1dXV2ZDWnZrUHRyTEhrcy85UTNmVVpVWEdHdW1ONVYxaWhIUmR3cmMv?=
 =?utf-8?B?dDFhYWRIYkdJdmJtVnRpS2V0N0I5d1lQSjhtdCt5WVhzYlRzeGVHRzFYVVNX?=
 =?utf-8?B?V0tIWjNvOGU5RWpKckkybzRkbmszYkNpcHhCbVZLRzRFcGFQMjVNZ0VVaFFM?=
 =?utf-8?B?M3MxV2xObnlRZ1RhM3pEMkdVcElvOEMrYWowUHNvZTdLeXFtSEo4cTcySWNv?=
 =?utf-8?B?K2VGczZyUFMwQVpQWXZJTFdxUllCMHMxa3hLckI2VExBWUNGdktDSngxcUpt?=
 =?utf-8?B?Q3M2VTBJRzZYQlRiNDQzM2p1ZkRLZi84UUhycFBoSTBKanA3M1hyU3VBYlZY?=
 =?utf-8?B?Z2NYb2lRd3ROOEw2d01mU0lmOE5ZMzhQTzFjNWdSdXB5NElQS05MYUtqYjhR?=
 =?utf-8?B?SkkvSFRCWEdwVW9YbUluMmFFaVdMK1l0YjFjR2xHN0VwVk1hWjdvc2pZSE1q?=
 =?utf-8?B?a2FDeGxwL0JNUmJ0MzZtK08rUjErc3F4VkdLSTJrRFBraWdZbzQyYVpjNEZa?=
 =?utf-8?B?dXhmS0g4OUx3dFh1ajJXNHVlakdkNk9kRnBKZVNGSE10T3pyYkh6UXRiSUFM?=
 =?utf-8?B?QU5IT0svb3c5TXJJUURvdjQydWZhUm9hN2tNcXhVZkZJOGptNVZ5a2w0blNu?=
 =?utf-8?B?SmRCREprTGtSeDJrTVV1bGYwak4rWFB1b3kra3BTNmovbmREYVdZZVBxRHFH?=
 =?utf-8?B?a2UyT0EyNmgrV1YxYmFvV1hOd054SkhHTitVNVdTY3FhMlF0cnVQaDdVTUhC?=
 =?utf-8?B?VG1uNFRMZTNNVW5KU2VNQzF6MWU2YmkyTytkQ3dSYThtd0ZDTkQvZGhRbWFP?=
 =?utf-8?B?M3lMSHdyUFZiZE1BM0RaU0lONUY4ZSsrb0dmc1JHbGgyZ0M0U0VHZ2VCK1J3?=
 =?utf-8?B?dXBiY1hBOGJLejRhS05XVU9MMWdCYnFrT0k0QXR0cHp5Q1hLZkkzMkF2b24v?=
 =?utf-8?B?aDM3OHdrVTRDNXpKYjA0NlcySFhpVVBZRS8yYTMwRGV2VmZuMlJiV01ZdEx3?=
 =?utf-8?B?Yk05dTZ6d210ckw4Uk1ESmdiMnl6RmhTODQ2R3F0MEJyNHRkbE5wYzlJZUdZ?=
 =?utf-8?B?dktRNWxTekR5MXRROXYrQ2RRZjF3eFRlZ3pxbFJDdDZkRVYwcjM5blgwT0Rv?=
 =?utf-8?B?dmo3TG1ncTJiaWpOSVpOYktnNlhVd1BvNXg4WjNEbFpNOTZCYVdjTm4wVERv?=
 =?utf-8?B?a09QOEV3YnkwRFNOZm85SE9raDJvUURUdExoZ2Z0b0RhajB4VkdKaUdyOFJ4?=
 =?utf-8?B?WUVFTjJ2MGI0aFA5cmNVeURRTTNNL0NmSEFyUGV0ZHFSSm03MVJrUjk2NWk4?=
 =?utf-8?B?MUdDakJCNHJ2czhQVS9DSm9GbjVSNzFXa2U3TFl5bEd2eVViSzViK1Jhb25r?=
 =?utf-8?B?NzhmTmpybW55SHEzbzZSSE4zOHJkWFIvOVFWRHhBOUo4N3Ztb2ZDNW9BNTNm?=
 =?utf-8?B?TEZiMk5STGJETE5ZaVJUSjZkbFdCQWN2OEVydElrVnR4cEIyOHdPcXU2b2c2?=
 =?utf-8?B?QUZ0ZXRQd2dnZFlidHQrakxrSXRzTkpRVElOdTlBTGZFYmQ2RnF4c3FzeWgw?=
 =?utf-8?B?RWZ4RTluMlpud2JKaXd0cVdzbmROV1ErcnNpL0IzR3VMRW85cWpuTDh3d21k?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i9WFcjGFY+G9miJi28yzhvRPo4SplqoINb90LO8CfF0keAUBqCQ1Ub99La7QxBdjVjnqimS3tof2yU0Z7kUTe2fe5Atne6xvB8pIwNzfukk1LvhQTbafpmPuNOr6lQutcl4IlDcgOrWSsZFsD2E4Sw3cGIOsmKI7i11EZw0cpb5tL6wnNRns36yjlLZBsksjWj/MiRPldoaMMaJUKBdXYrgRLMBipNOXbwnZAbwesav4wgVbW8k2Zs47CS1ZBQ4gEA/y9WrLbzpe++UB1U8gVxf7ZoMPrg97jEbbb1iRDDEq8V7hsigG6r6zCsjcF1xoDrT0WyJIcWkbEQdOVf50hhZAwygZ7VrxccrTYh3GB+iQr0lqrYDg36O+PnP8ZG7CvamVSLOSYHaHivb1olZt+q8Lir3PX6usVD5rVKkF1/i3h37at6loiahWVPfo9ui4GFKfxP6tnBOOUIOdAIOfHIJKadB1Z9sJYt9NA/XFy1o2vdpD73/fbk+GCfXFracn/ktQ4CvWDYxAqDwdW/Vtx6DgfcgCKhnSpyDD3ImM/Vo874GaOUySoE9zI5ICO01QjF2KNQJnYPl94K5TI5sPkOk6cAMndYkJ+hBg+F+R8/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333a211b-0f69-4bcc-608a-08dcc20eacb4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:25:46.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ru08uokNr7PkYZnxkqKdC4/3C+g5ossa/nQefEpE9IGlys5vZ+SvYmTd6esFNy2aCWVSA5JTs5JukrJeWULnyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_12,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210134
X-Proofpoint-ORIG-GUID: 8bg0AuO4G37SVdUivAeHl7bO9Caxw-Mk
X-Proofpoint-GUID: 8bg0AuO4G37SVdUivAeHl7bO9Caxw-Mk

* Jeff Xu <jeffxu@chromium.org> [240821 12:33]:
> On Wed, Aug 21, 2024 at 9:24=E2=80=AFAM Pedro Falcato <pedro.falcato@gmai=
l.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 5:16=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> w=
rote:
> > >
> > > On Fri, Aug 16, 2024 at 5:18=E2=80=AFPM Pedro Falcato <pedro.falcato@=
gmail.com> wrote:
> > > >
> > > > We were doing an extra mmap tree traversal just to check if the ent=
ire
> > > > range is modifiable. This can be done when we iterate through the V=
MAs
> > > > instead.
> > > >
> > > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > > ---
> > > >  mm/mmap.c | 11 +----------
> > > >  mm/vma.c  | 19 ++++++++++++-------
> > > >  2 files changed, 13 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 3af256bacef3..30ae4cb5cec9 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1740,16 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> > > >                 unsigned long start, unsigned long end, struct list=
_head *uf,
> > > >                 bool unlock)
> > > >  {
> > > > -       struct mm_struct *mm =3D vma->vm_mm;
> > > > -
> > > > -       /*
> > > > -        * Check if memory is sealed, prevent unmapping a sealed VM=
A.
> > > > -        * can_modify_mm assumes we have acquired the lock on MM.
> > > > -        */
> > > > -       if (unlikely(!can_modify_mm(mm, start, end)))
> > > > -               return -EPERM;
> > > Another approach to improve perf  is to clone the vmi (since it
> > > already point to the first vma), and pass the cloned vmi/vma into
> > > can_modify_mm check, that will remove the cost of re-finding the firs=
t
> > > VMA.
> > >
> > > The can_modify_mm then continues from cloned VMI/vma till the end of
> > > address range, there will be some perf cost there.  However,  most
> > > address ranges in the real world are within a single VMA,  in
> > > practice, the perf cost is the same as checking the single VMA, 99.9%
> > > case.
> > >
> > > This will help preserve the nice sealing feature (if one of the vma i=
s
> > > sealed, the entire address range is not modified)
> >
> > Please drop it. No one wants to preserve this. Everyone is in sync
> > when it comes to the solution except you.
>=20
> Still, this is another option that will very likely address the perf issu=
e.

The cost of cloning the vmi is a memory copy, while the cost of not
cloning the vmi is a re-walk of the tree.  Neither of these are free.

Both can be avoided by checking the vma flag during the existing loop,
which is what is done in this patch set.  This is obviously lower cost
of either of the above options since they do extra work and still have
to check the vma flag(s).

I think you are confusing the behaviour of the munmap() call when you
state 'partial success' with a potential split operation that may happen
prior to aborting a munmap() call.

What could happen in the failure scenario is that you'd end up with two
vmas instead of one mapping a particular area - but the mseal flag is
checked prior to allowing a split to happen, so it'll only split
non-mseal()'ed vmas.

So what mseal() used to avoid is a call that could potentially split a
vma that isn't mseal()'ed, while this patch will allow it to be split.
This is how it has been for a very long time and it's okay.

Considering how this affects the security model of mseal(), it means the
attacker could still accomplish the same feat of splitting that first
vma by altering the call to munmap() to avoid an mseal()'ed vma, so
there isn't much lost or gained here security wise - if any.

Thanks,
Liam

