Return-Path: <linux-kselftest+bounces-27153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6FA3F2A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A23B7A3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5396D207A3B;
	Fri, 21 Feb 2025 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OMkXp9ik";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hMm+O2Q2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F493204F87;
	Fri, 21 Feb 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135922; cv=fail; b=DBk8Tpg+pdyqyq5kvJD79/qr7r+I3d6SV04lOdIlKX8zbJlR/kYbK7sIysHbLitWr7wiLSxGayWQQ9OuF5K46HVPtTQ2yhnKyltnE+4ronanbGzmldlpOqsGsD2eG+99T694qSDoP3wkQcr7APtd+1tfhJGGawm2HbPUkf1fSK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135922; c=relaxed/simple;
	bh=AEJRbnaK0F+3/p8Wfv0ybW1dA1VdNWKrTx6SW5+jpZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8WnOerOdHfjmxbdf94oe7BVGUWENUsFyVQrN7jQGDDoVZptM/XAmw5vRb/XSKVqm1lXddr+O5pH8M6Kv9L/J7Q+0t4qNjQC1ivMClhA3gZs0l5jzWZXIflfrrfWnskBDJs5I2ShvYLDKuxoPo05j/xHIJrdtOxVfWrhfOl9h98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OMkXp9ik; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hMm+O2Q2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fggs029946;
	Fri, 21 Feb 2025 11:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AEJRbnaK0F+3/p8Wfv0ybW1dA1VdNWKrTx6SW5+jpZM=; b=
	OMkXp9ikoQEpDXG6XjnQ/lVfbla1YrFcXoqPs7vb3Z3HL76NivgEKMME6OHq8nSt
	I6JLdllG+1ihOX6Xi/t70QbsOvNfWXJXOLfOdsLQbHsTmG95kjh7NviPUsGkL0Nf
	h8lsCsmmZFgRtCf62ylg2R4mslwNwe+gunPP1rEy17vtuPGT/H5C9G+dyH4KchG1
	yv4mN5uX7VT4gZCxft+ee8vpSKWE00VjxSm42vIBWVnIB2GswgbBFm76lZTestNy
	d/Tq5MjUYuj8muST1joXXJU0uIN3U6JpHbIU5xGQW+BC863BWNqDmoNxZqKF/ldV
	QH7x9WLhbsuUURNuvp2+vA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n60wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:04:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LAVmq8010619;
	Fri, 21 Feb 2025 11:04:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07gfkfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV54+K4edItre3/rUpeGEgcrA5tmB+pBX8J4P+guKvHrCFc0d0g4z6pD9gKvAKxZcSgX9d7jAZwmTp+1EL1MC2yzq84IQL+x1Az2Ii8pYjbzZMx+b4yuQElCqpY/wf9XWK1YLUmo/aQg6ZYzgNshFWWG0VyTybCzIp4exdB94UGoG5rF05tVJryLye5L6nkuaahQl3HD9q/zM8TDhE9f0VNvmbdV8jfktCUpB8hx0apxK6eAoLbSbgBsMWaygbE00DEUIs7MEO6rxgyfQOf60KJh0Q6mj4eZH7T5sUQftKgkvkh0xQp5YZtoAjv4Cjm3KN73jGgdRuSxt9uswc2qLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEJRbnaK0F+3/p8Wfv0ybW1dA1VdNWKrTx6SW5+jpZM=;
 b=q1LlKDNW7TOay4gokqdm0s11pTa2K5eqrTI9e/AkWOG6taxhVg/GZ0ajkLtk+7tA+0MOgow35CFDPgeFc+GhN88yHWg32KGRUSrwzvPW2jfzwKJNpybP+hGyGiQ6UsKQ4UjUm4i9p7SufSzCKoxLfu/CJIDHPOSZJAycupX7gPFOoP8ciW/4+ZWI/nXZ6hHBYxPINq1VNRvR0HosgnlgY6Zut4gudd0OwDBFRwz5+Wk8unJR5RyaoEkHqoYK5BudehoIFnvwAn2RqG8CyCEBup7zna8chSrcBIWI7kBzUKuhrXfb0hZ9SU8p8fZHn1oH8fDi2zYL9VQEUWZ/WFjp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEJRbnaK0F+3/p8Wfv0ybW1dA1VdNWKrTx6SW5+jpZM=;
 b=hMm+O2Q2daAwxPpjd9Am1D5tB4e5erqzsFiGjoVf6mDwXAjqMMNM2iZJ+Ey6ZDykUY4eH1H988Z/8FmrJUY42i3kTbHUp7oiHoC5aSPQP4lkiiJYWtSIJ2bbA4jXW/M4Vd1OXrkg5fNxoTPqj1mTSzRASuOfyk1aH6QJs/OIy3E=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7693.namprd10.prod.outlook.com (2603:10b6:510:2e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 11:04:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 11:04:54 +0000
Date: Fri, 21 Feb 2025 11:04:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <87bae232-b01d-4962-bbe1-3677b71ff752@lucifer.local>
References: <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local>
 <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
 <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local>
 <4f5a9c19-9bdd-47eb-bb14-205e3dcced90@redhat.com>
 <1e959451-2534-44b7-bf62-bc75305048fe@lucifer.local>
 <bd4597b5-2da2-484c-9410-384e04336a9d@redhat.com>
 <31a007c0-884f-495d-ba27-08e3e0dd767d@lucifer.local>
 <CAJuCfpHpchh0CzEgh5CKmRLwpscBLx32A-mGi4eudpir1wm=cQ@mail.gmail.com>
 <CAC_TJvd2Y-EnavZkt5_nQUXmRpjo8AYMu6rND7eMUwXn27ab0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvd2Y-EnavZkt5_nQUXmRpjo8AYMu6rND7eMUwXn27ab0A@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0159.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fda6db6-3a7f-47e7-f532-08dd52679212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEhUTjBmR0xGUmVDVkppanF0d1E3UnlJb281aHhrNkdubFRKR25DK0cyR2NV?=
 =?utf-8?B?a2JKOFNtN1dXNklRSkxKNVdiL09GazIxMm9wRFh0bUdwcFh1V0p0OXRwUkpq?=
 =?utf-8?B?YW5DYkpMUWhhdUxtdFJKUkV2UGlZZkEwVzVFTTdjN2FWSmsxWlBiOUEydVlj?=
 =?utf-8?B?aTFsbUhYU21VT1AyNXRGSUZiaGJTejYvWGg2ZDdDS3AwSmxZdUxqWWxJeU1C?=
 =?utf-8?B?RXU5NVkvbnJyZUFBVFJ3OHJBN1ROUEpVMFhacGxiK1NQL2I3UExFWjR6UTNv?=
 =?utf-8?B?ZFRJZVVZbnEzNmlTdThadFNWS0RQUUxoeXhBTmxxVWUrTnJhQ2FkVnFxQnhS?=
 =?utf-8?B?RHFza2RmbWZrNDdLdzgvblh0VWxqYVVvWUxVZkYyMWcvK1RJYXRva0VMMzRI?=
 =?utf-8?B?cGVMQ2g2ekcyVTdyM3crWDB0YWxzRGFJa3V2ZWwrUGtDTVRWNUFocG5tWjdU?=
 =?utf-8?B?b1dMeGdFTGhOZi9hYVdwc25GRUYwZjdlbm1oK1liK1FEdGpRT05ORy9MR1BR?=
 =?utf-8?B?YnNvVHFiNHhucDV3UmlCTjU3TXYxRWpYdmlHS2FSRk5VT3hOd2c2MEkzd0JL?=
 =?utf-8?B?c1I0bU1QR1RpdEVabDZRaHBmUEhTRC92L2RjWlE1QkRPVGR0Z0s0ajlwd0xC?=
 =?utf-8?B?RjUva3R6eHFaZEM1YWxtZk43Z3ZzSk5jU2NPTEVkK0JCSG1YcmVCUml5MnAr?=
 =?utf-8?B?Q0pXRGNWVWovVXNmeEtvSE5menl5MEQ5VFNML3Awek9yYTg1c0s0RUZ6RUpK?=
 =?utf-8?B?ZGNFK20wdkRYL1lUSUJHUDNBeWtneXFwbHRyby9BVTFoQ2NkQkJaVU14Rk8x?=
 =?utf-8?B?UENCUzVXUHJ6b2pWVXAzYU9rTlRKTm1nN1cyMlRoL0xKeFhwSHVmeHRtZDUv?=
 =?utf-8?B?S2NVdkJsK1U1Q21mMUYzTElVU055anVHVHNOemw1OERTVmNzMDBZZ1U3c05G?=
 =?utf-8?B?V2FoNGFabW51dTFSSGRkYWJoWlplSXlHSVRJNG9TNDgrMG01anZoelp3UGJE?=
 =?utf-8?B?di8wcDBqOFFxUElUSnAwNG0vRTQ2UEl6ZENhNzBpYXBFRkp6d2VTc3Vic1g2?=
 =?utf-8?B?aGJaWmd3WWdPVmg1WHpNQUpYK0RIVWVoZVJsWSsybzd5YnVQRVNMRE10YWdJ?=
 =?utf-8?B?TUh2clJFSU1GcWlxVmNtQXAyczlBME8zTHJpMTJCdWkvdk1YYkNiRkVzZ2x2?=
 =?utf-8?B?SXdocjMvN0VZZXRwWkpWY1FrNjJ6bGFOcHpPMVRiYys2NDBOZng2TVg5dFRS?=
 =?utf-8?B?cU12WnZvOHUycWpuOEZkWUVtVUpXbEEvMFpKWEMyRkNGYlkzdHJqOC95V2ZR?=
 =?utf-8?B?N1h5Z0FqTThMUHNZQjBnTHR0TXAvZnJoM1lsZm5IMGk3K0pOeG8xNEJza054?=
 =?utf-8?B?UzVVKzFsWnpxUGpMQ1NsQmpRVDl6WDhLTEx1ZWNaSDJ1OHVyeWVoaC81aFht?=
 =?utf-8?B?d1BWRmg4bWd0clBhVnB4V0NLUkgxTmttNTB6aTNQQ0hoc3JRL0VFR01hV0dj?=
 =?utf-8?B?dWdNcEgzRS9ya3VqUm44cGhjeVFndDhWcTV5NlpGTGJpT0d4bVFqRlF2OEhm?=
 =?utf-8?B?bExpeHZqc2dtZXcxTFg2dnI3aFM3akpwa1RsY3hhZ09md01IL0FHdmlsdUFu?=
 =?utf-8?B?dzZ4K2tXd1JBNWFBRlZDZjZtNElpblZtR21uSVp1MmVMS2FlV2pYNHA2dXRj?=
 =?utf-8?B?ZmJNYk9PT3RQMFA1TmdWemxjc2psOVRzei8yZTdjL2l2K0Joa0FDeHFvWHha?=
 =?utf-8?B?MDZpOWY0SjZ5dWo4UE0vU2UxZUljU1dNcjlBY1BkNENWNmFkV1VKZ21NYnBL?=
 =?utf-8?B?TURtYlppRU1vajgxYlE1dW5WdktpRU0wcFF3WTY2cUNMc1VPc1NwUituSkJI?=
 =?utf-8?Q?8U5JDJ/qHInTy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFEyOUNkcFFLakFhV1Z6YnhGM0haRjF0NENPd2g1WENYM1l2TW95ZG9Qc2Vh?=
 =?utf-8?B?UUtJNXJLSTRxQUwvVkFJTUIvZUk4ZkQzN1JrTTZpWlB2ckcyc21GVWFLeGlR?=
 =?utf-8?B?N253YjNtcVMxaVlEaGFNZUZMNjFKWGFEMHRCaXRIQ1o4dUZubklWblRYdnJX?=
 =?utf-8?B?dFAxSnRDSnkvNmxCUURRbzJpZVoyb1lNNGxtaXR1bkVidHlnNjMzRURHOTQv?=
 =?utf-8?B?NE8rQUM4KzROc2FrT2lUOU5WSWgwSVdqbnpFbWVJdW14OEwzRUJocDROcmlL?=
 =?utf-8?B?SXo0aUxWb1RDQitQRTdseXNsUEk4SkdaNjd2dEk5Um1qR21HT3VzbXh3RW92?=
 =?utf-8?B?cWFOeTNiTEtWUCt3Rk90TE82aXFPNXFPUjFPV1QxaXhkc0hPUmhGOGVlOWd4?=
 =?utf-8?B?TStRUmtFTEYxRkpxd0s2THBhV0Vha1pFTUlvelB6amd2dlY0Mm1DTU9oWVNx?=
 =?utf-8?B?UHM4Nk1nUnNWK3N6bDB4MHJoRXIydEhQaE1TYU43dU5SL2NQNGJxMTQ3cmVi?=
 =?utf-8?B?RDJiWXhIN0RHcld5clVBVmIrZzU1OGR6YUhieXBMZm1lOXRRZkZZTVJRb256?=
 =?utf-8?B?LzlDYkJpZGhRem9INTI4T0RqOGRXK3VZbHNoT1NPbTc2bFZOTFI2WFh2WG54?=
 =?utf-8?B?cHdkRjlZMTF0cTNBYzl5djZuZk1sQTRTZXFrU2RCc3IvY1FqMW8wVzErckN2?=
 =?utf-8?B?S2FUcjRGWWNLdFo4UWxIYUJreWF4MlpXbytNMjlEZERpVWlZZ1ZuRVJOaDFH?=
 =?utf-8?B?VHJZS2s2QUc0U28yUGNhYzI5aHV5VUM4a3R6dTFYQ0JwSDFrMzZDSm9TSTUz?=
 =?utf-8?B?M2EzRGZpNzNsbzhjNVlmZThDaDFVSXVGaUZaTkQ5T2tTSHM1OHpqSUdlOCtX?=
 =?utf-8?B?ZmRZSm9KVEQyOWxORXN0YWhyamx4RlpjL0tnQUkrMEtkMUVmWEpNUFJ6Y1pF?=
 =?utf-8?B?Tmt0QnZHcVVpN2QxcDRuZDJxYWd0SVk3RHBuaWNXKzZCMEo0MEVmRDhObFhP?=
 =?utf-8?B?OFdLYTlYbEJManZMN1BWdHlMdXZzTE10S084ejQ5eTYvOVJENGYzYkt4Szcw?=
 =?utf-8?B?NXY0dWVWYW9MeGE3VkltMXU0QWJna1A2Uk84alp0R0hLOWxnMDlOR2dRZFBS?=
 =?utf-8?B?b05CWFc1NmxVYitKU0Z5a3U3djEyUTcrSDV6NW5TUk96T3RmbzZRM0x5TnJp?=
 =?utf-8?B?b01iL2VBSVBPQzdFaFdsUmRwK2pvYjI4OW1MdjJUbmgyNytrSjREVFpBcFh4?=
 =?utf-8?B?VUt0WXcvV1FBTmJMMkJIU1o0UUE4bDRiQnB5Sld5K1JjaVhsSDYydWxoRXBH?=
 =?utf-8?B?WG9UTXU4em1BQmQvL1grY1kzdUdRajBtbnd0b2FoOUhPU3RlOGkwWjR3ZkUw?=
 =?utf-8?B?RXJTNEoydzhLaGRVZS90TDJqbmRwRUlvVXhBcVBCQWRqT1pLdGZkSlk1SG12?=
 =?utf-8?B?cGFZeS9FZHFnaEZkdFprMGdpMWNmTldCT1RkUU0zbDVCdFd4aWI5RmdGOEVp?=
 =?utf-8?B?NGVxMmdFRmxiUlB6RS9nKzNOYUhSUXkxV0Z5dTNaNGlkazFsVmtjYmF0c1dv?=
 =?utf-8?B?VEZ1SUxhT25MZmJqNUc1USsxUU1mcXVrSXZxQmMzWGJLbTVEaXJvWUJaWHhh?=
 =?utf-8?B?bE5CRmZIQnNtY3E5eVNQVG81eC9VVFpTa3ZHZ3R6WWUxWU1nQ29CMFhqYWww?=
 =?utf-8?B?SmdNWVdTbDQ3NnRzZmc4bDVSTkxtcGY3c25vME1NK04yVUpvZ1gzWk0zWUVH?=
 =?utf-8?B?R0NoajN3LzJ2REFCOFBXSVI2ak9ENGVaYmVkdFRicUxFdVozZnJybnRoMmlr?=
 =?utf-8?B?OGFBV2pxSWNubjRvamV2QjZDM2hOVklDN3ZJbitYQU5DeCs1MFRXQW5XYnlw?=
 =?utf-8?B?VFFQNkZnU05xTW43TUNXbnU5SzkwZzc5Z05FVVM0S1p2Sk14NFZSa0d0TVpZ?=
 =?utf-8?B?WFNveHltbG9ac0QwbDhHck9vdnJQMWFSQnhGVVcrNVdEcGVsUWhhc3JwT2Fz?=
 =?utf-8?B?Y0ExS2hBU3JhaWhMZDhybDdiYU1zN1JVVEhzTm5Pb3g3M0RTSWtlUlIwTXUx?=
 =?utf-8?B?M1pXWWtScUpUUVZ1N2NUK2xIalUzd29mZ0grMThnTVhPVUI0NE9qVEw5aitL?=
 =?utf-8?B?OGVCV2NxNEpJblVRU09zMVExT2l6Q25VcFYzVnpqbnhUZWhxZ293R2dpRlMw?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LIBQg6OABpc90yfz53o0eLrRAK4n0ZN/gXjyTbCOrAI2Wa/YEulB/+h1wtTcVVhopxprKecuikXmZT4gnswl+HRzQ39mUXtWiCFr/8hKkttTu+GB+8nf444ci5TVLWhRcIHwm7p8LvdE8RpR9NUM67W74+8lnBxq7wwL4H+/e6lHiLdrg12Pnak80uuCemuvByR4UfYBY7Soeyrs/OBe2AQjnFWLyS5PVKS1eplZxS2QoPTh0FbHtQ1LBqp7y1IKCHUOCFPYCYeDh9gpa4XINiOosgcVQkD8lh2vVewppHW7Rz1qGs9tQ8VnivdOZRDRe7N2Fr47gbR3okUVVW8TfFJ7EG2LzBODJ3k2nlnjVItO4XNt0wpiuS38gPnyy6TBDZz9RTrOR9AsUtTaeVXkY7hdn4VyaL8+c7rhnsbSMRL/lFjWl4jC5PwjBqUSHzt3WyfirUjuZRSR7bBavZETzbV/6MLH4HDKvE1cUb+grw+/jGqv8ExNpTKO7azGmhWWHEnM4c54utHzIB3Vto3lJyVVxFKwmzwd80lIj4XyiZynj790lHjn1Z9RdXoOp6k2sBeyLAfLXqsA6gNQ9SR702pQ8tqCveX/SKxCu0r0lIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fda6db6-3a7f-47e7-f532-08dd52679212
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 11:04:54.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7CzDnFTdCMxF+nRXN2Tbxwmh8cpyLf1vFjvGpLC7Sw6XwRXDxb8pYhV2RcEgMo+CzV/jpwyCBsF5VFGYs02MapCBqlRrZF06x6kFick8Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210084
X-Proofpoint-ORIG-GUID: kkhT3YXqDduLfr8dV3RswogrovCcW-n5
X-Proofpoint-GUID: kkhT3YXqDduLfr8dV3RswogrovCcW-n5

On Thu, Feb 20, 2025 at 10:08:36AM -0800, Kalesh Singh wrote:
> On Thu, Feb 20, 2025 at 8:22 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 5:18 AM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 01:44:20PM +0100, David Hildenbrand wrote:
> > > > On 20.02.25 11:15, Lorenzo Stoakes wrote:
> > > > > On Thu, Feb 20, 2025 at 11:03:02AM +0100, David Hildenbrand wrote:
> > > > > > > > Your conclusion is 'did not participate with upstream'; I don't agree with
> > > > > > > > that. But maybe you and Kalesh have a history on that that let's you react
> > > > > > > > on his questions IMHO more emotionally than it should have been.
> > > > > > >
> > > > > > > This is wholly unfair, I have been very reasonable in response to this
> > > > > > > thread. I have offered to find solutions, I have tried to understand the
> > > > > > > problem in spite of having gone to great lengths to try to discuss the
> > > > > > > limitations of the proposed approach in every venue I possibly could.
> > > > > > >
> > > > > > > I go out of my way to deal professionally and objectively with what is
> > > > > > > presented. Nothing here is emotional. So I'd ask that you please abstain
> > > > > > > from making commentary like this which has no basis.
> > > > > >
> > > > > > I appreciate everything you write below. But this request is just
> > > > > > impossible. I will keep raising my opinion and misunderstandings will
> > > > > > happen.
> > > > >
> > > > > Well I wouldn't ask you not to express your opinion David, you know I respect
> > > > > and like you, and by all means push back hard or call out what you think is bad
> > > > > behaviour :)
> > > > >
> > > > > I just meant to say, in my view, that there was no basis, but I appreciate
> > > > > miscommunications happen.
> > > > > > So apologies if I came off as being difficult or rude, it actually
> > > > wasn't
> > > > > intended. And to re-emphasise - I have zero personal issue with anybody in this
> > > > > thread whatsoever!
> > > >
> > > > It sounded to me like you were trying to defend your work (again, IMHO too
> > > > emotionally, and I might have completely misinterpreted that) and slowly
> > > > switching to "friendly fire" (towards me). Apologies from my side if I
> > > > completely misunderstood/misinterpreted that.
> > >
> > > Right this was not at all my intent, sorry if it seemed that way. I may well
> > > have communicated terribly, so apologies on my side too.
>
> Hi everyone,
>
> Thank you for all the discussion.
>
> I don't find any personal issues with the communication in this
> thread, but I appreciate David being the object voice of reason.
>
> I understand it can be frustrating since you have made many efforts to
> communicate these tradeoffs. Unfortunately these issues were not known
> for the file-backed ELF guard regions for my particular use case.
>
> >
> > Sorry for being late to the party. Was sick for a couple of days.
> > Lorenzo is right, there was a breakdown in communication at Google and
> > he has all the rights to be upset. The issue with obfuscators should
> > have been communicated once it was discovered. I was in regular
> > discussions with Lorenzo but wasn't directly involved with this
> > particular project and wasn't aware or did not realize that the
> > obfuscator issue renders guards unusable for this usecase. My
> > apologies, I should have asked more questions about it. I suspect
> > Lorenzo would have implemented this anyway...
> >
>
> Suren's use case is different from mine and this design fits perfectly
> for anon guard regions from the allocator. :)
>
> So I think in conclusion, these aren't VMAs and shouldn't be treated
> as such; we will advertise them from pagemap for those who need to
> know.
>

Thanks Kalesh, glad there were no issues here and we have found
constructive common ground! :)

It turns out implementing the pagemap side of things is _really_
straightforward, so I'll be sending a series for that shortly. Hopefully
this provides some basis for whichever use cases need this information, as
it is the best and least invasive place for this information at this stage.

Cheers, Lorenzo

> -- Kalesh

