Return-Path: <linux-kselftest+bounces-15880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E6295A361
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5282840C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F0F1B2ED2;
	Wed, 21 Aug 2024 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z4+n8imD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gX2TNFWv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D41AF4D7;
	Wed, 21 Aug 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259702; cv=fail; b=OUyqB/H/kUoUsprVPaBYNDnSTy7goInSnwJMVZbKYZdOSxjob1cKQTx8ZEow7Qot6mhPDxhtPyzzV9N2+AVETKGszQf7k8ysrnHYnypUQ5S2dCA3FPscF8yCxdf+XEwNzvBLcZfJjkPe+zWArt236kGaJZ07+RcjnOhuqWkC138=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259702; c=relaxed/simple;
	bh=HurgDrHj/5qbIwC14z6as9is69bFb7SLqjkRGl3o3Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WplF8SWbZOLk6jE5f/EjDn9Gs/dtq2PEK6RqLc5gOAQmciTytr/UYrZ3bELMhLExoBCkZpfUf/0QOpkCk5r8AXlTP96wddXj78u2wjKv6dmEc3TlqGogzvtPb9Wv55fR42zKQtzdPy//otJOhWne3k1HK3f4Z5LBbs8FuS8TWzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z4+n8imD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gX2TNFWv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIZ4D007041;
	Wed, 21 Aug 2024 17:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=CYjKjLl0qfNYggiv+WemwQOcZ5ihEVu+z/FHoEcZD9A=; b=
	Z4+n8imD0iV9soDTMTtTIDTTbJOS0XEqa9QhgXhrjeQZDQlyGW64koHwOYNkObWJ
	iScIio82jBSJ8VGP5E+eNtesfLvPh7SNwY0AhiUNRvnZkC5aDBldvQxkSlyX6wW4
	qhBrCt2Ib/zIIEjlFbb37wxOh+/qwpr7P7kmAHumqFUqrq+EcPmNCyv5HbI5zcBY
	NbBWe1T+dRgJgkWZqPM1Wazrs5ULa40SF5jUveRrf3ykewG9RfVu0ZL8MeTDSPb4
	u7G7bUDEmqN95TAKitkQL5narod0igqWiquhNsl8mqYjq+mbWMNeAVaZhU4yQDna
	oaeuj0wtQ4/uUlpsRiu9fw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v033k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:01:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LGgRq3018555;
	Wed, 21 Aug 2024 17:01:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415m0b8qnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxvlVWBCTHVARLQkv4oNiu3sMlkE61gJamfBfQeRYPrIYLQ9fgI/TGr8Y5kQI5JsWiwdE6cZjVUJb+GJ23JhCFnXZ08jl28molY3zww9gU9vwu1pY6P0BwommXXS4LT+B6eRxwxhEFr7nsb+Dh+yxqo1MuqYFkAK9jrwZHV+pO2Tgo/sRvBwSH/rDJ/9dxxkq1yrTBpVtFVbU1wbRKrRcpsl+ECrbOi67zFk5USV/JJPznYWuyVCwG4oryrAuckUiygH7d5WuMTL4Md4uA9UVmPRc5f6O3CcrCPgQ/KmZ+1QO6huMfO8fDI4Pm+4+n7HpRMpskI9BLcGhi6YNJYkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYjKjLl0qfNYggiv+WemwQOcZ5ihEVu+z/FHoEcZD9A=;
 b=ppchwv0JdWz3wkgkCVkKrXnlMfvN8HBvIBIFVu/ccSmYaxRJ80VE4DbmYPboJ/Q0l9ztVkydKAyz0JlN/6TnkekJhJLyVCuHXM2lSAXV44mRYzoYvaz6DgHDXhVIvV95NcJGr9AeZYNM2RomLSWFr1wEujjtnBnMBga+t6Hf4KeMPMcmzjUzTREb4d5ufW2E7YOsPcLx4xe9l83u4u4QSeL7j4Q6pRhDGAOGnbVAgrPTPbq5dD/4OH8GcxISrAlq76CfGsnyucSJyHdC0rdVwNPga4Jw1QZKPvdqGodcJQhk1IgxrzoSltK2wM7p6P/zkC58kc6omBocOZnooikaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYjKjLl0qfNYggiv+WemwQOcZ5ihEVu+z/FHoEcZD9A=;
 b=gX2TNFWvXhHXDhsqq8ziM8Df/LMNh02FOAszdfQZiuysWw8z9wH7rSrfXRX6zDg7Mx+fzYylYaD1jqqu2737WO8hTV15RI/OdUKxyFomLKrEG+JJjhR9Wq6x1IKBvoUTEb78RfvnsPiNXfPgcInjYEstcY43sKwabg3TShRpGRE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 17:00:58 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 17:00:58 +0000
Date: Wed, 21 Aug 2024 18:00:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 2/7] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <012f05c9-a1f3-45cf-b584-897a03cca867@lucifer.local>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
 <CABi2SkUBH+utreVMTd1qEBSvXTPM7Qc1GiwNKjVa9+EeZK8WWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUBH+utreVMTd1qEBSvXTPM7Qc1GiwNKjVa9+EeZK8WWA@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0232.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: fa28b599-27e9-41e3-b73a-08dcc202d3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTU3RHZWbTlsUWthUWthQ3NDZElINDByN1drckFkbFpXanhwT2tIQitGL25j?=
 =?utf-8?B?OVhkUFFHRHM5d2FIZm5scTNLeFhzTyt1RGhiRGlhaWk1dHdsODZac2FOR0FF?=
 =?utf-8?B?L3BhZE5xeVV6a2hGMk1STU95bkViR0J3ei9LaGhicEpTSzRWWlVVV0V3S3ll?=
 =?utf-8?B?OXVGcTQyaGlmcHFQTGVXTSsxSE5yeDVXRmU3WU9TRkI5MmxuUjdXcDRhclEx?=
 =?utf-8?B?UXhjcERnWmVqbm5WZ3RkNkpmTXlJQ1I3QkEwL0ZWSW04M1hGdFZ3c3JqaVB1?=
 =?utf-8?B?SkVCd0x0NVE3RWhqR2M2NVRjUFVaM3hZengxOUJWVjRwcjNiUDE2ZXVuZWov?=
 =?utf-8?B?QnlCM3pocEJtaFQxZ1h0d2pKT3hDRU9jOUR3MWJ4bmRRQTh1WlJwWm1EOG5l?=
 =?utf-8?B?bmZKdTRjRUtUTjUwa21BSDRCK201TllyanV5d3Naa24rNlhrUDMraTVoQTFI?=
 =?utf-8?B?UXNwNENjOTNrQnVnRXFTWGF2bGJKQi9lRmJVeWNPYXJsUSt3UzBidTh0WW8r?=
 =?utf-8?B?U04zT2dsTjhTcU8zK0tOMG1PZjhpUGR2TVhjT2NrcTNiWDdmc0lwcVRkQjlE?=
 =?utf-8?B?N00wN1pOWFZVY25ncWFrdEt3bWxaSnMrU0Q1ZDFOZVRXeWlQT1pqR3hUaVNR?=
 =?utf-8?B?L1FoQXVRdmVkQW5hMjNVMTZyeWNLUHFYYllRMUxpSjZ5VDZaTTlnbmlBK3BM?=
 =?utf-8?B?blpXbjJMNEtPUjM5TUh5SENBK3YrcjBwektiZmltckRGQnJlNkZtSUJVSGtN?=
 =?utf-8?B?TktNYTBwTE10RmhpZ1RjWXgwRzF0aVdPR09lSTRhZEVkV1h3UDhpSzdzUG5U?=
 =?utf-8?B?SHlmRHFRNmU1VitYMFFDZTBPWmxORGxLMXFCNGhXTE1UYWR3a09MVmkyckho?=
 =?utf-8?B?SnlRUTVBZGR1cm14SnFRU0VUSHhHcXI2ajdTRUk4UWpZeXB5ajNvbUlrZEhz?=
 =?utf-8?B?cHltVFZSVUlwdHd3dkNCanVYR3Y1NlR5UVJhbkFVa3c2V2hlaDZoeGdKZUN5?=
 =?utf-8?B?NHNnbzg4alBHRzlLTVQzWjBGZTdpK1I4Q1lDb1J5VmRQdmRPdEdkZVBaTXZq?=
 =?utf-8?B?S3JVR1lCcnM4aUdXbEtzQzN1ekxBMG4vWDBZenQ0M3U2WklxUDhxOWdtbU9S?=
 =?utf-8?B?cllEdEh5alU5NmZ5ZStsVnBkRVVqMWszbmJhdG5oMElObWdoc3UwajBmMGJi?=
 =?utf-8?B?SVFxUHZNVTE5a3BmY0pPRkR3c2hRMjZkV0wwQ0tBZW4rcW0xOWoxbTRmckRX?=
 =?utf-8?B?V3VqazQ0QlFmNFhhanhCdnZNeEJwb3BDVkdvdzB1eXkyeFYyZmxuNUtMODhv?=
 =?utf-8?B?NEk1dGxKUEgrQXBHbWloc1RoS0tsL3VsQjVkYVdmM2I4eU9Sd2lRMEhHdmxt?=
 =?utf-8?B?K1g4V01MY0l1Z0JtcmluVG0rQjhCcGs1enFLdUJueG82YlFuNGFVWDRZejRj?=
 =?utf-8?B?QTRTSlZpOXRSL21ScFFkRVdXNWZuanAvZkI3ZWVSbXo4cVNFTnJxWGhCUkVZ?=
 =?utf-8?B?eHhnTitVbjVLRmlwcjVpemJUUFNOVUtlSlNFRHFvMitDQ1Yzbjc3UitvSzZY?=
 =?utf-8?B?WExnaTdRRlhrM2lFYlZDaWk1Qy9VdndYTTNiMmcyd09HTzZVTEFYUnV6Y2ZI?=
 =?utf-8?B?ZHorbE10THQ4dkNacCt6TUhkeEQydVg4WHJJMEhUaXJIR2s4eHl6WUE5blF5?=
 =?utf-8?B?TVFUK0sxd0MyeVhxeVBVeEM3VjZDK0dpMkIzR0ZPUy9kd0tQeWZSazBOdE84?=
 =?utf-8?B?bzVaOXYrdHM4U3VlQjJURlhudG5UV2Fwa3ZYRWFEaytHeVhMbGxudmdMODli?=
 =?utf-8?B?ZGVXaVlTWGNRQmZGaDY5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3UxRkRJZ3FvMkNPanI3YnlEOStvR2VWaTZFWmFZSWhFMWlkL3FrbERBQlJi?=
 =?utf-8?B?U1NpVlRaT2JEeldWNVU3aWd3MzVSUHBFZkRPVE5JVkJFOE94WG4xVWJhWVhL?=
 =?utf-8?B?SkxaQlVoWVErdVVCeXdQcGdNNW1YMGNoTnVaQytJUVdHbEp5d3hVMFNHLzdi?=
 =?utf-8?B?ZTVQeE1KYWJpMXBjNFp2SE5qSi9OalpZR3lJMzZZQW1HZWtOZWxMMUo2YVJl?=
 =?utf-8?B?WGI5ZG1jd2JrcTRydm1qS1F1ZzZNTFBTL1RhelJqem5uK3B5ZHR6YUwxOERR?=
 =?utf-8?B?YWpRMys3MU93NW5BUTFKMXRQcXh4bXdzWTZaOExqMEd1OXREV2hOcFVPUzV6?=
 =?utf-8?B?Z2QrK0REUk01YUNqSzJwOGZsZVV2azc0a1JrVFVjdXRlamFiNzZTdkhITnk0?=
 =?utf-8?B?NjZzVUpnekJ1Z2xXcDNhMDNPSGpSNzFFYWpKT2FjT3k1Zm9reW41K09ZRUhX?=
 =?utf-8?B?dzV2dFlGbnpkQXNkY2g4dnZJbnF6dTlxL3ZzMzQwd2dOcTc3Y0VZc1cwSHpL?=
 =?utf-8?B?M0xvTUNOc2FTaEI1b1YvVWszNjB0WGhBazJQYytNbFBsZTF5VCtBdlhrUUQr?=
 =?utf-8?B?UUhzcEJZZjFMaC9FeVljQjBKQU0yU1lmN2pKcjJxS0UydUxhQU10cmtZeHln?=
 =?utf-8?B?aUhIZ0tyWkgzb2RmNGFhSXJpTDhmd0NQemhGM1FVTkh1RzZvZFhjdXZrcWVs?=
 =?utf-8?B?bjBZY3p4VXlERUVCVzUyTzFMQ2NQdTJzOHIvTXFaOXo3WVlJVzZDVlZVblZK?=
 =?utf-8?B?ZjBSRGNacWU1K3ZLcnZKSEx1R1pvNnU1WTVUZmRQQzNXZU4vQkdacFpQWUgy?=
 =?utf-8?B?alJKQ0gyb0FJRm1VbHI3dkMwZ0M1TDVlN0xJbnBqRm9vNUJRSGxYc3dNcVRH?=
 =?utf-8?B?cHRSWDVSYmVvRjM2SVNwMGppZUsrRFNMNGtOZ0EyZDRCa01NNEErbkY1Q2RF?=
 =?utf-8?B?RE9zQ01PN0VUVUFOT3ZiMkk4N1FMaHVnQUVPYU5veTN5T0xjb3dsbUMzWE9L?=
 =?utf-8?B?RkcyVVpLWXFPOVVPQTBPNTFUMFNiQTNwVHNFaGFzeWtRQTZiZ3I4VXBiVXJK?=
 =?utf-8?B?NFRwMHFPdHRROUVsL3FXc3l4NWIyT3dWb09LZWVZazA1Y1RRZ2V3dUpOY0U3?=
 =?utf-8?B?bGdjVTJCTHJIWWZKMGJmZDlRZjBmY0cySjBDUTAvRE9VbDZrZG9xUGtUdzll?=
 =?utf-8?B?QU1IUlRzdWluNUF5R1hvV01nc3Q4WFVBTDdJcG1Ebjg4ZytCemtreFBGb2NM?=
 =?utf-8?B?Mm5EM0ZBajRYdW1XSUxxdTJTUVdxSmhTZGZVTFJuZlJzMkhzc29rZkN3Zm0r?=
 =?utf-8?B?eHl5YmVHdlpvMDM4ckp1TXFjcHFtVzIxWmpRU01XYkFzRFdZQmJHNVBxcVEz?=
 =?utf-8?B?TXExUndmOGh6elY2enozcWxudUsxVlE0a1RZYWhmN29yK3ZBVUttRG0yZGh5?=
 =?utf-8?B?TGJQNjlybXBNMW5BeGtYVVZVRkpTQzFUTlY1dnpuUHRNb1hYSngyMTJJbUEw?=
 =?utf-8?B?SW5zR1RrZDJ2Q1BSTSsxQnk1dW5tNW02N25RWUlOc2lxcUlqQ1dOc2JCdTht?=
 =?utf-8?B?dW5SRjVCbmcyU2hQYWdBK0FuRGE0K05DNDR1OFlJSlhFNThyLzRjWXhRNHIv?=
 =?utf-8?B?NVkzMk11bE9xc3hjOWJRNURkVFczdi9ZSjk3cWtPTVphYVZCVnNwU1FoRjA5?=
 =?utf-8?B?NGVlWEN5RlhUbjBQTnBPUGJJWDlUcHpUWXRmNXNUeFhNSlR4L2RyMC9tTnFM?=
 =?utf-8?B?cFJoVXkwMWQrK0RRdktrcFJJbnNLUENlMG9QbkdCRHo0U013LzUwSHdSdmpN?=
 =?utf-8?B?TU1qMHAwcmIzMmZXYXo1cWJ6NlEweEFpYlkyenMrVkVrZjE5NU5SVXV0Q1ds?=
 =?utf-8?B?MGpDTmRHNElEY3plRGM2KzgzVkxDYmpjOHR4YmRKWEpPUGtHclByanpnTktv?=
 =?utf-8?B?Z2xQbm5LRzlRZlR0dm9nbUFhZDlSN0VJSEtNaXJ6Q0w3cHdSN2pVTWpITWdR?=
 =?utf-8?B?SHF3bTF1Q2hLK2cyTTJoTERjZWhncWRtSkFNK1k5VCtWaFJSZDlmTHJXNEJ2?=
 =?utf-8?B?RHBtRnRFdURiUW4xOUkwMGJOc2FVYUo4WGtkU0ludm9UalMxaHRzNzZtNnBl?=
 =?utf-8?B?TjdqV2ZHeTZacmFjOE1LaFJzM2NTbWh0L3lrZjZnWE95MHhiUWZtaFU2Ni9O?=
 =?utf-8?B?WCtTbjhmbUgzRDRYMkZWamtIalZHa1VFSmxuK3JWaExNR09KenByQ1dPN2ZK?=
 =?utf-8?B?VnNOSVBZL0JlQ0hZN0p0VWsrM1NBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nu5Jdez9D5L8MBx+bCMj12Ld85MOevn0wDRPmwFq39O8O3C46ZASVjjn46PC+JDNKXWZFHu28ZEpyyBEfd8huNPzDLpFUx+jv/tVJK8xa1LMCjkx1+MPTB2vJSHlGYH0QFH/3EyzdIXviBj+cmmG1WRIY9qEuSCtoC2aizxGhDFoIWfqxqLj6Ueab+O3oCUhy0i49Ocp3CdJyShCXLBI45iiq/gNbj++QeV7bo5QuNMWmdiYUFURwv7jhrojvEo40CBz9tzJEnr2EAjiCq2cOLS8hi2p1UnYhijT0nyHxQ60bwgZIod4zHK/l7A1w3k7P2HDqg8IykF65c/5ka5KhTQH7X7IVauhAXP/AyMByNTo2nVbDJ4/6PPrcGrZgXPuIiSDqs5Ydf64kw4ucyHsH5R5nVmZlau3yx3xxcz62TMB7WluNp+oIMUm8s6Z8AHcsdSEuaKHSDMraQmsJ+CKhfZ4eaADfqZRU41PMKs7VkjTe6tngomIi+IFrxjk7+cHPDz+e5FN+DPbkGQoqRxVK+TGjJcmMXngKKZP/svXx9bd3hXqJ8tBJOumSPtvYqSdnqhxU1k6mzdxwjMNKuYpApAJMLCPUS52vJv/lOTiTkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa28b599-27e9-41e3-b73a-08dcc202d3db
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 17:00:58.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fmRvXAXDp5yHm8u0qKS/8Mj4Iux809WnsvRAg+JoD0WQpVnNnIh62KXiPB7IbQ9E22oGaeT+ROLansGyNruKQjrK7oVygOr/pTZcrO5iEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=954 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210123
X-Proofpoint-ORIG-GUID: iCd-vyhsmzgC6qh13kw8c2x6YYovZMBb
X-Proofpoint-GUID: iCd-vyhsmzgC6qh13kw8c2x6YYovZMBb

On Wed, Aug 21, 2024 at 09:15:52AM GMT, Jeff Xu wrote:
> On Fri, Aug 16, 2024 at 5:18 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > We were doing an extra mmap tree traversal just to check if the entire
> > range is modifiable. This can be done when we iterate through the VMAs
> > instead.
> >
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > ---
> >  mm/mmap.c | 11 +----------
> >  mm/vma.c  | 19 ++++++++++++-------
> >  2 files changed, 13 insertions(+), 17 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 3af256bacef3..30ae4cb5cec9 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1740,16 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >                 unsigned long start, unsigned long end, struct list_head *uf,
> >                 bool unlock)
> >  {
> > -       struct mm_struct *mm = vma->vm_mm;
> > -
> > -       /*
> > -        * Check if memory is sealed, prevent unmapping a sealed VMA.
> > -        * can_modify_mm assumes we have acquired the lock on MM.
> > -        */
> > -       if (unlikely(!can_modify_mm(mm, start, end)))
> > -               return -EPERM;
> Another approach to improve perf  is to clone the vmi (since it
> already point to the first vma), and pass the cloned vmi/vma into
> can_modify_mm check, that will remove the cost of re-finding the first
> VMA.
>
> The can_modify_mm then continues from cloned VMI/vma till the end of
> address range, there will be some perf cost there.  However,  most
> address ranges in the real world are within a single VMA,  in
> practice, the perf cost is the same as checking the single VMA, 99.9%
> case.
>
> This will help preserve the nice sealing feature (if one of the vma is
> sealed, the entire address range is not modified)

This is tantamount to saying 'why not drop the entire series and try a
totally different approach?' and is frankly a little rude and
unprofessional to put as a comment midway through a series like this.

I don't agree this sealed property is 'nice', every single other form of
failure/inability to perform operations on a VMA is permitted to result in
partial operations and an error code.

If a VMA is sealed and causes an operation to fail, that's fine. We run on
arguments and facts in the kernel, not feelings.

Please provide this kind of generalised critique at the 0/7 patch. And try
to be vaguely civil.

>
> > -
> > -       return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> > +       return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
> >  }
> >
> >  /*
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 84965f2cd580..5850f7c0949b 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >                 if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
> >                         goto map_count_exceeded;
> >
> > +               /* Don't bother splitting the VMA if we can't unmap it anyway */
> > +               if (!can_modify_vma(vma)) {
> > +                       error = -EPERM;
> > +                       goto start_split_failed;
> > +               }
> > +
> >                 error = __split_vma(vmi, vma, start, 1);
> >                 if (error)
> >                         goto start_split_failed;
> > @@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >          */
> >         next = vma;
> >         do {
> > +               if (!can_modify_vma(next)) {
> > +                       error = -EPERM;
> > +                       goto modify_vma_failed;
> > +               }
> > +
> >                 /* Does it split the end? */
> >                 if (next->vm_end > end) {
> >                         error = __split_vma(vmi, next, end, 0);
> > @@ -815,6 +826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >         __mt_destroy(&mt_detach);
> >         return 0;
> >
> > +modify_vma_failed:
> >  clear_tree_failed:
> >  userfaultfd_error:
> >  munmap_gather_failed:
> > @@ -860,13 +872,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >         if (end == start)
> >                 return -EINVAL;
> >
> > -       /*
> > -        * Check if memory is sealed, prevent unmapping a sealed VMA.
> > -        * can_modify_mm assumes we have acquired the lock on MM.
> > -        */
> > -       if (unlikely(!can_modify_mm(mm, start, end)))
> > -               return -EPERM;
> > -
> >         /* Find the first overlapping VMA */
> >         vma = vma_find(vmi, end);
> >         if (!vma) {
> >
> > --
> > 2.46.0
> >

