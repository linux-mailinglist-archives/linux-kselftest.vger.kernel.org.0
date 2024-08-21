Return-Path: <linux-kselftest+bounces-15881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F12B95A365
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A0728398C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC71AF4D7;
	Wed, 21 Aug 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OPnnoJx1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DEf7hYIK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044813635B;
	Wed, 21 Aug 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259759; cv=fail; b=UT3s1Ls7cDuc38hxjtQFsfgl+a724xY+3SwVkUNpVpysHygoWO6iwpE28iAqYXPUSLzhxBX6vwqKoOBSkxLezyMUcpEIOwMfmgVxvakRypzrvUFspMXWtIFmL1OXaZCB7D3FGS29zuTHtdmB3Az89JaCez8qOY8vyw2a51JgUuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259759; c=relaxed/simple;
	bh=UvSyFxBdB58UZ9hOf2BmBUTT3Q6TkjMjmV+3qBFZMAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sB8XxKjAaJSc4vnS5ByUOngSdpj5gdZ7XZ8LNKiDFK74VT0n60KZ/4YYHqCtFuZ0kMSudzfukLhOUdo6nMnslbXiwvHjxxw0GQzc/ka/LVFK4BNMmaCBS83jJ6FE2D+bJOzOs34JJR9UqPrM3CwWapYVlptuNTG3nxOQu8YVE7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OPnnoJx1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DEf7hYIK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIXQP031845;
	Wed, 21 Aug 2024 17:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=1GLZAJhEPXbvszTzQhF8QXt+f/qRtwHzzjmc3lfTIRI=; b=
	OPnnoJx1X6Rd/TJJGwfSwoFVPLUEq+GjEd450gavnG+BMqgd3SJ/rtvTEOdu5M+6
	8IbK4vp8KmHchiR5Kkhbk+u1KVLZQNgUIl+7koURZ9KI1ks2rvJqquxN7BzZCjSL
	Coowt13HjSdi8KFfL17on9NwRo767LoV0HUPC7CTh3MkudL+5MKHXucOkkUUb4Oc
	P0PURrbWXwU3LtxGWCaxvABEdQN6UBjVLFFhOk4QUrGAS6YP58Jn2FYVY5PxjlUf
	HGHCOC/12rJOf+f+9hx/8KxFVnBF1XE0AaEvTYXIrZwIf35Oz54kIfVPD3GxBLIW
	728NNiS7YZAbo/a4UCOIqQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dra3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:02:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LGE1Ms017464;
	Wed, 21 Aug 2024 17:02:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415kk01xgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NC5ySS5kP5jiUlixEcPUPIDNhwHzKIqWMAcEALx2OpfZ976sMsqZXUSjsFK3ETWomUswbMit/gNgJ4FhG6EtChOqBsq7bMGgdJy2orR13950vgHNyb5hz4Y+5arya6+erA5nvjC0q49YF84oKy01kx8Nww8YxnfGjPYvOiGRF9NIxGW731QhXVHPaY3w0/ocIpDPV3UFvAHz/vvwn6/3UwgpB+/i6yehTIxpFS1CY1ORa0Z7+41/2pnXovBCruR7hFX9ynDYIyIMyvff9cmDojIEIUuizdm1bz5jRya7KKxkQkxmGc8cIYaunJPpE8lSMgaba9pfgaq62poZ3VrxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GLZAJhEPXbvszTzQhF8QXt+f/qRtwHzzjmc3lfTIRI=;
 b=gvQOpjGXu4G0JilrPtW3U7gFdLN1UOrpcrm54BuF5P0ry0niL/lREaCoa2mtVrYiw3WC6+77iNs7aEjfPEmDkirAPMTgjGGJn6rRdx17p1i7mpr2nBJkpoi0xexF5iLHP8KnT/eThKeeUsLNb93KhX1hpknOlipnU1dz1LPqR0oLtppwQ11JWSHcy7WRoj+6MU0s8sIHzpdAG+hjCZxMlpvtLq+soMPo2FXeqME64rWajDLrALNXocL0abZyZtE5Q6oCpj+yWG68+yD/wpGaUZ/xTImunUOMiLgMq1Nd5VOVs7e4kUU7iHM+gf3xuDVj1XRD0h+qhm/kcPqrJ0ZMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GLZAJhEPXbvszTzQhF8QXt+f/qRtwHzzjmc3lfTIRI=;
 b=DEf7hYIKr/+PYQzOFHpWSj6oCVTPVjBDD1VGORMG28cZTJwkesYxvivGGoL6x8mmD06K9/sL5uGmB1OWkQEWumoh91wjVzJrPC/zJHD+FhPyFkIVkuuKD+KrYcK3RlKrDWDEIzO6nwndjSggLzy9hZX/vxnW82V5ynPf8ysmnHs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 17:02:13 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 17:02:13 +0000
Date: Wed, 21 Aug 2024 18:02:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 2/7] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <78017d84-9e3c-40b0-bc95-4ad8026d9e6c@lucifer.local>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
 <CABi2SkUBH+utreVMTd1qEBSvXTPM7Qc1GiwNKjVa9+EeZK8WWA@mail.gmail.com>
 <CAKbZUD1d5hXWUPVpUzPo=M33_eo9_sdMq6nVg-jd=-O-CpFjsg@mail.gmail.com>
 <CABi2SkUZ-OQFCNZcc0OMN_4YV8NoqrRu2HGEeFms+Ty6Bnofdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUZ-OQFCNZcc0OMN_4YV8NoqrRu2HGEeFms+Ty6Bnofdg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0522.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: a60e5623-89df-4a0c-77dd-08dcc2030094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGRDT3V4TmZFa3pFazduNENoRDhvR1hnRU1sN2ovWXVvQ0VJaWFjdmNKUUpj?=
 =?utf-8?B?R0xoZjBsWitsdkFZdlM5TEpEK1F6S2FaYVU0VnFZV2xIV2JCNTZxSmNTRDkx?=
 =?utf-8?B?ckkzdDBOWGpqOHRKQUJ5ZXNzUS9OV0RacGUrQWlaM2w0aWk0b2FzL3NyU25p?=
 =?utf-8?B?OGF1VThPU1FMUHdJTFZYTDkybWszTHJNTXZmUzlGeTJySzJMSzFTRE9PSTZ1?=
 =?utf-8?B?RVE1eGVaM012dDV3MHRXK0pQSWlva25VTmFtK0NOV3FRQkQ4YzZmdjhFeEFK?=
 =?utf-8?B?c3kwemtWZTNneURBOE9GUnQvNS9BcjFyYXVSYXIvdTZONkRIRjh3UmlzYWQz?=
 =?utf-8?B?NU91ZUYzZGU3YzNLd2xVZ3ZpV1BaVExhNHhQcmR4UTAzT0U1SUNuRlFWeFY1?=
 =?utf-8?B?R1RKVGxyVk1vNmdkeXhSNENSQzdBV3djS2gzUEt1TEI3Y3p2SXdZdHRUbVk4?=
 =?utf-8?B?VnNJRkVZL0dVYzd2T2UrN3VWQlE2TC9PNXRYSnppWXBSUnBHbXNHNklPYzdQ?=
 =?utf-8?B?elNERzFOU003WCs3OTQ4TVlnWTMybUZCaGxIMDNYVHZBUTIxSEhmdXFzOURn?=
 =?utf-8?B?bms2WHZYRGNDWG40ejRGanVNQThEd2NBV0syNUlldFNlaTZxZkZVRmMzbTQ4?=
 =?utf-8?B?Vzh0WEJRTEdmR0J2ZzN1ZkhkYnRxWjFTRDZ1cVdqeHBDVmRsRzdHa2FHTks1?=
 =?utf-8?B?QnN3YXltMkIxSTRaVUtjY3lDaFNqU0Q3MTcyclp0ZjRYdFNIMDdRMURJQWYw?=
 =?utf-8?B?M2dDcjQxVmVqeEl0UElYcHRza21weXdsbGNYbmVSTEhGRnU4blBDVGpCVE0v?=
 =?utf-8?B?RzlqRURtWUhhdGxoT0hTcTZya3M3QVJ3UTkzMXdIMTdITXNWVi9XRzFQcmIz?=
 =?utf-8?B?bStMUzQ5TERzS2hoVGNURnQ0QnI4andEcVlzS2xYa0Q3SzlkZDMyRHNsVEVE?=
 =?utf-8?B?WE9ZU2orV2pmZWRSdjhlZnpvOXN3QkRxYXdVRTFZdXllazZIMWtMRkJDYVcz?=
 =?utf-8?B?MThWVWtJVnZYeVB1ZnVQYnlJTlpKU1lrcDdRZlJHc3BRVDZwcWsrbTB1RzRp?=
 =?utf-8?B?ZTNoQjVkVzlwTU9jK0R5UnFKRXVwdzBldkpyUVE1Z0Jyay9VbnFmNVBqZ25k?=
 =?utf-8?B?QUNMbFo0TzNyb2luMWJvL2wwYzFtNFdyNHdzclo5WEliQ3lwQzZlQTlDUlJ6?=
 =?utf-8?B?dWRkamJmenBNU0lUTUhCTGIyZVRCaGp1RjQ5M1VOWm9QdFVRNXFsczZrWHZ4?=
 =?utf-8?B?YktqYmp6enJNOTl0V01YK0xGT1k3K1QvdWh5UVpibDVtZGxtbXI1dEdxd3BV?=
 =?utf-8?B?eEhmbGxGWUR4TWVQSVAzSzVNTGJxRGM5VCtkd0JvNFJEaUtzeVZ1eEE3RkNz?=
 =?utf-8?B?d2lhbGMyUUdORG5ibjNkelhrSGpYYi8yNjd5MjZoTFA3eGZCcnkwQzRMSUF6?=
 =?utf-8?B?Wk56SVgySTdLVksyWFNjbnpsL09sdDBQc0xQNmhYTmx0QkJUeGJFTWV6SjhP?=
 =?utf-8?B?WnpPay9wbW1ZbTY3aEZNN3JoTC9XcmNjUHlwSHE3ZXFoWko4OGdoMTJPdFpo?=
 =?utf-8?B?SWR1S0NjTlhMdGhzMHNIaG9ZdkxQcDdaZkdPaFkvZm5iUkhZQ2lOODl6M3Va?=
 =?utf-8?B?MVY2VGZvSGhWR3NxK2xvUDdEeXJyVXR6azh0NW1yZ2ZBOWp4N2FCRHMyVkJJ?=
 =?utf-8?B?L0FDcGtlWmxIdUVyZzBDdkVjNmJXaGI2NiswQTRsNUhkM1R0cStNb1JhK01X?=
 =?utf-8?B?TC9YcDVNbWUwbE1TYUJIUE91U2VHS3Qvb0R5Z3NuYUNyQjlaMS9sMllOMkFU?=
 =?utf-8?B?VG9rcUNobUliOU9jZ2twQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3ErQVdaNTZYRExyaDlKVzNPemNDei9zTklPeHR4dHR6a0VIOUk0TmxHNGhF?=
 =?utf-8?B?cm80UUM2SUdQVFdCb3U3K1RIM2ZRUnAyMk95MVFhaUxPYktaQXRkajNsTzQ0?=
 =?utf-8?B?bjZtc092QzR5bDNnbnNsOHdrdTMxYnlwVHUwd0p4ekFQSXJYMFF3cmx3bnVU?=
 =?utf-8?B?Y1FKMUR0WTYvNjRSbER6VHBmcDUzeUVWMHFiSDVWZ3loelFuaFUwQjJhdVlM?=
 =?utf-8?B?dWQvcDF0MVFZMGJsZUU0TUtxSGtWaXNRZnRCUE1scFJlSThqREQwUW1oM3Ry?=
 =?utf-8?B?cXFBTU8rblNtYnZ4N3ZFMWs1Z05jSzAzQU5HYnEwR000Y0xwSE1zanJxd2FH?=
 =?utf-8?B?SjdHb3Z5ZzhxYmk1ZmJTMk5ha1RhVDhXK1paUGFmSnhqSG9wKzBlQzZJVkZM?=
 =?utf-8?B?RVZWTXN1MXMrSExFdHF6SVJubURBNEN2NUxRK2tCdGtSZGFncWU2VlhTQ29P?=
 =?utf-8?B?ZGYyWGtPRzdSVnlVNVVoenNTcEtmcmZTN296SjNyK0lGZy92dmw3aC9JOEtn?=
 =?utf-8?B?WWxrTzExTko2SzVJZnhGS2tscVVQbDZLV2xYeXFOeWRIUEwyU2YvSldkaVBF?=
 =?utf-8?B?MzlXOHFjb0xBckRpaDE3bUVhQjgraEZxanhieGF5dDI5ZlBsSnFtTDk4RVZ2?=
 =?utf-8?B?a0YxSmplY3pmOEFsb0ZtWjRYeUkxMFVqTmMxYUVEbC8rbkdZaDBHQVQvS0lu?=
 =?utf-8?B?YURIcjQ4ME5ja0Z6YlpvVWpqUFBkaS9kRS9oZnZGUmJPM0ZzOE93MU5QajZq?=
 =?utf-8?B?MWFjZnI1YzZ3UTBrWWt0RDNDMENuNVMxdFc3N0RuaDNhNk53WDdjV2htZDhF?=
 =?utf-8?B?dFMxRko0OGliZzNWaXB0TnBRQkVveFBQWU1YOThOTlAwUitqYkF3eXU4WjJI?=
 =?utf-8?B?WWZNNGlKaVZHUlBaK1A0RUQ5VEtEalRCbEV6dDY3UFlUSGRBRmJYQlFSczE4?=
 =?utf-8?B?elhhWE5heE93Z2NaS3VKanlKVzZaZEhJenpaS1dhTzZGdHo0OTR0dGlxRndz?=
 =?utf-8?B?aFM1N25tbHg3NDdLQlN3dzlpSmp5QlBUYWpKQnM0aXhGS1hvU1pLaFNHMHk1?=
 =?utf-8?B?VWdseGhrNldiYnJWd2dIaDk2cVpaeDRVc1U4aVlsY3pUYW1oTnRMc3NIaTI1?=
 =?utf-8?B?S3FGOExCTUU2d2VscDV1ZFJUMlZEcDE0RHNGMGRQSlJrS3huczRBaDRmM0xr?=
 =?utf-8?B?Y2RLbytZajk2UDl4Zjhtd2ZRZ2tjUzRlVEphR2NxcCtLNXlnV2R5ZlVrbll4?=
 =?utf-8?B?Ri9QTjVzQitYd1ZwSWJFSmRiYkJxVlNJNXdoYldkRTVXZUprNTlVdzJ1U3Fp?=
 =?utf-8?B?YmpuRW1uVDd6VnduRnJsNjJXMmN0enZNclZXdDFPcUhleVZ3S1FHTTlwRVh0?=
 =?utf-8?B?a0xGYm9nb2ptMGF3d0VsK2l4U2Q5a2N0SWU5L0FZU0R1REpNTW5nNjJiM0d4?=
 =?utf-8?B?VlRieVNpS2xjMWY3elg2WXBpR2Z4K1NrcHhFaXVWOWZ2K3h1SU02VE5wTGNn?=
 =?utf-8?B?OUx5L1o5eHBwdmQ3UUp1WTUyNGpHckdmcHZPclc0Y0JHYS9QREZpRkQxTDI3?=
 =?utf-8?B?TmovTlRaQjRTNkJVQjdYV280emhsRXRxcmdsYzFkWVpLcWdDQ0VvSk5FTG13?=
 =?utf-8?B?R2F0Y2NKdmlXQ0UrYSs1T2pHTXZyYUM5amN1RWZqOWdnYVdqYmNBZ2FtTHBV?=
 =?utf-8?B?UUFJUklld0tpSnVqWEUyeDV0K3loYWRqMzVLek5JSlJjRXVTSDk1UTl0MlA5?=
 =?utf-8?B?Tm5IMFd5QXdtQ3hqUWRMSjVCNUx6M0NLbngvTUU3MndMaWRPUTFkc3JodDcx?=
 =?utf-8?B?cFhoTEZKUHUxSzhWWXBpSkF1WE1IRU9qV2xMVFd4dnlNNDdmdE5mMllIQi9u?=
 =?utf-8?B?UEJjNm9vWkpUdjlIN0NMY2VrM3Jma2lsY3MvVk42aGFQVVk3cUNDVkVXODNP?=
 =?utf-8?B?NTFrQ1ZWTFpUa1BpcFk5cUwwZFBjOVk1MDljaXlXNTE0Z2I3OVYrbzJkYmk4?=
 =?utf-8?B?N2QvNTEvQUlMdXcwaEF6RGlRWDVQWS9DMkFZLzlRL2Z2UXczVEdRd2NsbDBE?=
 =?utf-8?B?SGxRVUF2NjBsSHpOVHc4dkxMVXlYMDVCanNLakM2SzZSeEhWUzRVRU11MERm?=
 =?utf-8?B?RWgxckdKQ2tTZ1VCNVlRWVpVamR4NmlKeGJ4cm9OR3hKUjJhUkhGTFpxbUN1?=
 =?utf-8?B?eGo1ajArdnBTNERjVnF2MjRoMm1USDVTM2F4eGNxVWVkUGpjWGMvWG5Zc05a?=
 =?utf-8?B?bHBOOW92L09RbE56THllUHY4VHZRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	85O3F/z913Rq+ckBjtXH85hCn+KV8KBJh0hyCJK5ek1cCPQ1wijXX4fwMTDXp00QNmhzu6Kix8Bxh5p1G76UturapoQQ2m1aVqWHVKSVu6sbdqzJ6Nq3axCwu4i/SH9xmh2Xk8mkpOYaakabySNpO0ClFBzCxtVGgxHelm9NqU4UKUiSFIdkep1Mvld63ivcbC/58aL/I5AwNPqWA4aAeCjvk7uZEVU3bQ3+HhAfGL1ZxdDTB3zZWzpuw9brc7OFWHZwMciGI2wGeFipVJuKRAiCmN/3BN0UUKStluJLaJq8jzLmexJmlC2v0yY8QrfP1S3S5ack2MbJrh3LqIDCepZfcj8PJ35KNIeKDkafKQg3APQLGTQu+mpApdS2CpvT7m3Vn1VM0M8P9YxNFWdZgefkbhClYIRE2WZsp8cOM0sG18ioWj9BtHr4/lWpTtE6U+dTL4nw2vLkbtx4u20QmuzW829ffMrqPz/vXS7Gu2mQ3R6fV/LtA5XcsnRlRodaAFtPAQ354V+jdS/0h6Thbh08PWqJUcpYs6hg+EOmEJsY+NDHF//PYV0wTwZbNEzf0XNoRMkrH+B8fYYt5UGBzWAcn0SskqMVifXf20hjFoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60e5623-89df-4a0c-77dd-08dcc2030094
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 17:02:13.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncYy4N+bHOPEGJPVAQXCkZL4iOL5CXsf+WRUH5k8wsLGQHjqdDRCLC/LG3ny3JqPnL4Ie892DQsHSAS0WWy8NOLKe9d1ZCjKw1AQEgbhmmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210123
X-Proofpoint-ORIG-GUID: b_luV0c7DN5ui3RmhzAdmpqWJR7f6R4Z
X-Proofpoint-GUID: b_luV0c7DN5ui3RmhzAdmpqWJR7f6R4Z

On Wed, Aug 21, 2024 at 09:33:06AM GMT, Jeff Xu wrote:
> On Wed, Aug 21, 2024 at 9:24 AM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 5:16 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > >
> > > On Fri, Aug 16, 2024 at 5:18 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> > > >
> > > > We were doing an extra mmap tree traversal just to check if the entire
> > > > range is modifiable. This can be done when we iterate through the VMAs
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
> > > > @@ -1740,16 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > >                 unsigned long start, unsigned long end, struct list_head *uf,
> > > >                 bool unlock)
> > > >  {
> > > > -       struct mm_struct *mm = vma->vm_mm;
> > > > -
> > > > -       /*
> > > > -        * Check if memory is sealed, prevent unmapping a sealed VMA.
> > > > -        * can_modify_mm assumes we have acquired the lock on MM.
> > > > -        */
> > > > -       if (unlikely(!can_modify_mm(mm, start, end)))
> > > > -               return -EPERM;
> > > Another approach to improve perf  is to clone the vmi (since it
> > > already point to the first vma), and pass the cloned vmi/vma into
> > > can_modify_mm check, that will remove the cost of re-finding the first
> > > VMA.
> > >
> > > The can_modify_mm then continues from cloned VMI/vma till the end of
> > > address range, there will be some perf cost there.  However,  most
> > > address ranges in the real world are within a single VMA,  in
> > > practice, the perf cost is the same as checking the single VMA, 99.9%
> > > case.
> > >
> > > This will help preserve the nice sealing feature (if one of the vma is
> > > sealed, the entire address range is not modified)
> >
> > Please drop it. No one wants to preserve this. Everyone is in sync
> > when it comes to the solution except you.
>
> Still, this is another option that will very likely address the perf issue.

Nack to your approach. Feel free to send a follow up series replacing
Pedro's with yours for review if you feel differently, and stop stalling
things. Thanks.

>
> -Jeff
>
> >
> > --
> > Pedro

