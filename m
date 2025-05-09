Return-Path: <linux-kselftest+bounces-32758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE4AAB199E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 18:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821BE1C46632
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD7623506F;
	Fri,  9 May 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YseNaYTN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CKzXpIpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D4233707;
	Fri,  9 May 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806176; cv=fail; b=goOq8FK7WL9Gk1A6HAgQTyR3Xhqwl34R8EvamrtLZTnNTp/Fsi5GbB/Jwdi9+YrZiLiz4U9b+FyDrroipsSEiOPARsnDjQzhQll6EC25eJ7wHDHNPItCq6GdRMGmVoYVWB5ZJxDG+AdiWtkUUZfwsHoT+dEmTCC2no0BgZsflew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806176; c=relaxed/simple;
	bh=KMRtnWWMBJ6yysm4x0UcOR8RfUOQvX1QdrZnnPWz8uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sniKqqzDdB0hkZ/N5DhTUOvjlQxmMcAmWDWNn6tTeQKdbKYNLMiYIsjzcuPjtw7W2yiFIb5DOuhZ8gqcvm6bygX4MsPXRd0jnRUXrUpstdc/BYPDuS4IddyEIR/jRH8c4wImuIRMh5ZKV4ufdfFybYvf+ClJfnvQp5nyuZSijJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YseNaYTN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CKzXpIpe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549FMAAg028991;
	Fri, 9 May 2025 15:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=W5yyquY79mBjQULoh4
	HjIPuriPOELTlLb2J0NxAzqgw=; b=YseNaYTN9Z0E5d//aQNPsDlHB/Dewz5EuX
	/AnfUzzAGtu3RkKtYwpyhQ1//F4SyPyNqb7dPGY73/sl1B6USHfywQkfoV4dooGM
	CKN7bcPeYFxDvY01/1D+TNosgoHdvlDMz3A9TIhmnd7C1tVAlYS6JiCPxADJvLa7
	2EbUw0reBEgXbSsElpUqZTJX9qVEu7gj88JhvUqOw92Mv2RO2t6/tOPK2tPomwgC
	qyMZY8E2uxTHwuULKGyJl1DiAjgQdsWzW3fVexx9+eF9Cgi0oViQyMCbuph649kC
	at9uSwUc6E39WuncvxzvNr17vtDWeZ5o2co7/o1PZLQFo7QmGRoQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hm9m02e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 15:55:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549FtXfB032155;
	Fri, 9 May 2025 15:55:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kd5aaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 15:55:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gs45hsz6uqoPhBUv/FZNxCcZnSHoF+GDKsyf9x+yN+UwQiBO2faez8/WvTT9TgEZsCecDoCnCADcC3uc5YW8WjsZ4Ex5C9CZBzuvN+SJVNbRWrRz18+obnghep4siOEsKKNf8Rru593PJ1j5Mli9y3rSpXhlHHiD5XBVx55n358P9Wr2KB2G3FIA67skhr/YYUxY0hPWnCH3dpH9Di5xi1JbT7O43j1fyv1CcVzi1fubFXj23RhYRwqnZwDI5a0lMFnie1LPjpP8JgM2yDV4tWxD6vF2zbrmjueRk/sKn0rvgAbspIJItHvxjWc0PCbIjaY0fGynyDkQylqmzRYIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5yyquY79mBjQULoh4HjIPuriPOELTlLb2J0NxAzqgw=;
 b=xCsjVT/IFyPqe1xLrRC7ZUQLk4iSVpF3aCffFIQcuqFx3Oajl8h4pGYeVev9oEdqVhchVZRgEjv012UcX5OH4s56YX40r3h9K9af7vR5DcBDHbAjRRbtO0TrsuS1P4Mu2CuKP9Yw/r/9mQm/in+vsk/UvT3OOd4gnSIKDCXCUJ+Xe1xFtaYDRLiJ/UrgO610pyTVYFegG4OA73ILywzwbYzbbuCAf2YzvV3booynPQM/n53gg68MYybyNajVchEE6jwM4dhoHEFaOJy3Myr602Ioa18ilfE/uPplx0edpnXoyzK2PVDnGHD0lIJwTwMNvM7iJjRJ37S4AZ1EuBQF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5yyquY79mBjQULoh4HjIPuriPOELTlLb2J0NxAzqgw=;
 b=CKzXpIpeo4zolnpXjdgug0PmQIgqMjb11p/oKFcK73cCbh3f8bFBSqmga78lC3zI/68Q878GMvat/zpF2zelRbsy5S83D96dcwlRweq2IiZYZbS7L994BxeE+W32QZ5j2ZB+f6PYQcZ9K2018h9KuJFLzM0IpCHsNCkYaK1z3ZA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6875.namprd10.prod.outlook.com (2603:10b6:930:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 15:55:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 15:55:05 +0000
Date: Fri, 9 May 2025 16:55:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Xu <peterx@redhat.com>, Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH v2] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
Message-ID: <bfdd4a08-1887-421f-8ea4-d48eb0cee778@lucifer.local>
References: <20250509153033.952746-1-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509153033.952746-1-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0195.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c69a2c-b891-42e2-3424-08dd8f11ddd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wfmb3itRFMGoTjXwCx13bYv7P8xOPVHIAd6lH4ebisnw0POPEVKXBAmEEX7B?=
 =?us-ascii?Q?8nETPPgp4dct7W5mo/cAet1b+hmEEty0m/0jU4lQz9Om2YReb4D2TzD58iED?=
 =?us-ascii?Q?se934r9UEhwPHVKPyTTNQdc3EhNCZ5N7e9kgr3/4O3D0Fv0DHKLygroy0X5H?=
 =?us-ascii?Q?XINIetHPBSM37AcGaXU3SoTO5HmO5u+LAfnACZn3X0W1tlshLtVybRZSIU6G?=
 =?us-ascii?Q?KJrynxRWl9sgVdXaEfnhpwl0TE6fbpVJYEtaZF2LoD9f8GX70E30Etupeg6X?=
 =?us-ascii?Q?KiTzoB8mjF3cN42Jnlm443hDkVQNQ9RVhWtVo2Nwa+IxAvPw3c/fRB296uyk?=
 =?us-ascii?Q?zjZplmb4HZdt5olJcOX9+t/Pse3LW8k0OF3wmRDJzcsxWOQA6a5PzoGk5L+R?=
 =?us-ascii?Q?nZCqjAW4/ZMUliY362dSx317dh9B8d0isbkZcpCrFZBGvISaC6ZT9kGkT9XW?=
 =?us-ascii?Q?+Mo/tjlRggSJ5VsvGipvdUuFb1FsMY9TImCXeWIXlMtX3zM6FTtt7i2GYo30?=
 =?us-ascii?Q?1IfN2x0zl0+yj1jDxWK4GsSFeyChIPk5jMG/DgoMIhXhlQ1/Ve4V9Wj7QmGJ?=
 =?us-ascii?Q?olNx2dBh8t3fV5HTcOZInvSIDTHqeejGbvpvZGM3yT0FvkIrdxOxV6S9kmsU?=
 =?us-ascii?Q?2ZR3XOwmujAIhzHzde+1FUgS4ZpwISePkBvFMRUZtcrWNinovhp3524y2ma0?=
 =?us-ascii?Q?p7I7A0ivQaH+unFGceREjRt4jA4E3RCObmZ2pOeEeZXO/KhWv5/tVH+g41Qu?=
 =?us-ascii?Q?78V5SzvYx1W+ofAEmsz9gIcOV7WZEZ2thMsc3ic00oK17waI5Vj45VrILcMa?=
 =?us-ascii?Q?LNgPmmPZKiP3OiE9L4s2vXls4sSFfkGxqhv4wRZtDlrRIE2NVhS1tbHX1jfj?=
 =?us-ascii?Q?LWvdpUZNS+y0dMzQOx2KXF9AOVOPabCuFh0maXfvI4xpC8jBOCqd1A7jd9F4?=
 =?us-ascii?Q?Dpz270VV/DfvZoFSgoDJQczHahMovDHVqsvJc+wQJFHOc9zBBlL7xdOZuNj8?=
 =?us-ascii?Q?a7w7FrdeTPbITushlsx3pic9KkCJIK1j4mC1t2xbcP4ulVkiCPEBNeM02PDL?=
 =?us-ascii?Q?re4zq5nFPDa0jJihy4aIO4KFSJQCUys7VaHtprr6Ui74cSS4uHyFbo28peKF?=
 =?us-ascii?Q?Gmsc453GzhBNs+UbZHqgDLMP0vaoxis2RR9ylF0/8YjGvB0EJB2Wu2xwhBft?=
 =?us-ascii?Q?g8Bv+R74bgbEic9wMif0RWdhEdaVH9ByJeGQ9s2hX1V11klBhPre57hbX8om?=
 =?us-ascii?Q?pjIUiaI/5gPcmQX9nNOJGKTol+Q0BZ2+dYmN2tDbwbfB1ApvSXNZuZqToMwY?=
 =?us-ascii?Q?cQmuR4x8+SOocKiffSUHLvft+gsFlBOn0ZMMTgV8PdpNOrUfE9COHGma/7Ki?=
 =?us-ascii?Q?Wx3WRZt/oL30h6iPK3FKnBqwoH2b728VkJgYlWt963BwnbMIRZrVJFxdhCi7?=
 =?us-ascii?Q?iPn3R8zMkrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rZGn4m5ycwLg9pUkbkVp/kktXhjcLtlHfDtcEYVC/ZYoDJ3H69EX2B7+hJsE?=
 =?us-ascii?Q?an1Ebg58NrkMmxDWLkM7tVYx1U/trzYAEBN9/M5VMHrtrYaDSIFOQT36ReVD?=
 =?us-ascii?Q?OBfNGkWDrWkGd+uznuAhoJxdMAwBynDdVUsxXfkzh6ivAimEbGoZqIMYklLC?=
 =?us-ascii?Q?v9QuqbNzcIMBRW0vjbGyHwA0+6fVjv9KG0J3Cl/kOgJaC0i5EwNP+U7ISBjp?=
 =?us-ascii?Q?P2w/ueZu5q8/zUdrTAXVBkDIOfGkkEn8LG5aQVgn8kPZsQ2x635X8tDjgNT/?=
 =?us-ascii?Q?54ZkWf1cxfnFbBuzwegjhpwB5IGcj/eabx3iR6w7fjmuU47tRYyC3WOnsI77?=
 =?us-ascii?Q?281YmipEAKYMbm7aT6k6IqPNKPcjEDR0QZzDsK5Th/w3d5lsam6kF4gHwq6e?=
 =?us-ascii?Q?GOcBmhzsQJRPl0EOXWIgnF/dbAF5IDnmSnmOEKQzUSfxVYLgwcpch/AuoGzb?=
 =?us-ascii?Q?GIezXDYFwV/5e2IJUXzio2nJ7qf2zANhrCBl1v+fSisWHPum4ZLATyNj8VXG?=
 =?us-ascii?Q?6eOWu9eXJgQammjmlYcM9x4EkvVX+oBn5mlnFHd8iWrhCDIsepy6mSWkfMaa?=
 =?us-ascii?Q?D584Ho6MIUbeQHjz/ZyjPiF2WELf8jA6PEnp75fR7kWhgtjKsMfiI+2iXL+H?=
 =?us-ascii?Q?RofgMzQMMRSGvowWvlU2MZV6w6E1fTJTL7BUNjcJ7kVH3sUvWiMyl0LDppAm?=
 =?us-ascii?Q?U6F2XjC4nmWyPW+ma2LIqj7jr4GPjOkwWPPMR92UtbgWpRfopEMXf7/4RqNc?=
 =?us-ascii?Q?uw5BM51px+RBo/XCY6WyMgeaSohZ1AnAzGXVRpZEu8WDypoMjlX5Ld34UyhT?=
 =?us-ascii?Q?4cWAVNgBN2nfQQvI3Jczeb1TdqTMZ8HGgtmzWNNsUz6RbFbZ+h4olNYRl8cv?=
 =?us-ascii?Q?UVdxar2DqGiGKzOOPtAnXvW0Kh27JC0JduvJK9nXdFnMP+/z9lFKewOPicsE?=
 =?us-ascii?Q?zNZfagzmKebufHAr3MgM2ywXWrreEoWfOmp+uNwkZXpzcZo9SEw6WjHdIuv6?=
 =?us-ascii?Q?5IekpN993nqoh1Mc82Qyyv70Sc6JwkjQYl4JJx20gCoOKUCBfN9yyOZuNpRW?=
 =?us-ascii?Q?junHot5HNMk5wgMZHYYKRk6TvFhFKDIhQFvnK3b+9+8umh8vQePPhM5AX4GY?=
 =?us-ascii?Q?rf+MmsGk9QLWQH/xLUWygbHFepIyOYTiRS9m1z2cd58mh31d8BCq+V39eUl0?=
 =?us-ascii?Q?458xWGpsydVXju0D1EzKj742VtDfZROSFmsCB+uA4JQ7vb3VTCyJTXY4w+Mp?=
 =?us-ascii?Q?2oSAJcQKM/HF3AI1fbDP2DMk5Sjlmj8wl8Ztj2HgrYwJK+VwSGK+hCpAr8v0?=
 =?us-ascii?Q?JCj5A293D8FTq/8ZlKhI646uCWkBo80hwsloqMXD52eZxbsbZgP7i+Xmwba4?=
 =?us-ascii?Q?qNWq338lbTlY4HeF2uGCkkVI4t1F13JF+kBtb0AWMBKmCrIeo6J3P9C2w8yn?=
 =?us-ascii?Q?Do/o8rUHv0ux9BBsMC4Mhu6m4lwQNm+Y4rKbfJIKQdGWLL0oEl2kGS7HL4/l?=
 =?us-ascii?Q?L4Z5ZI9ftY4yXJPdFir8+s+7vSSMmXLN7MOxEfeVnA06Z+gNcPSNBbwdyJ44?=
 =?us-ascii?Q?AUlRxOQK+9Z9lNhRZD2joPlxAQ7nf2gsLnarqPsDlmFIJ8h9FFIXDLPt9Uo3?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dH+V5pOiRxnR6CrHsCVa23s7lK67L28XDaz1zoQfxf+65U5+x/uIQdoYM6H723dTrw4P6PQ0zcWvYAapg9Swvsx8KMLiY0qDuQPiQsonVwBIb47pnmqc09svolXL62lF/18YSTcT2YVRAIp/vzEAR/mpXmdLh6xHj/TEuhfpMYVo4vKc3wx/RcXYqLww6SGe2k9xEpBjjDOGRJGvo/jGLyYy0zRdEvmy+6vhR+Fegd1v54qhsolgeZ4Ga6f5l1WtH1vIZgbxkjRjWscGS9bCwqfeLLKIZlephareJpZYsU+xrsblpRcr42Lt0XELjoaOWhrrQEoh/tAuzVG/668p6jRYl2v4tVZidRUt/gvWzxsL25Ig75yGi/0Zk4JU6QlB1dz+ZAyTGtFbgYITqL42NSR42sbPSHPQbhpVW/Q7eI2CZM+lv9/NERHuPSvyFrmM01tFOinE1mJ1Rl0Exqf/J7rLTnSwHKlVjhN1zJrJ+LqD7VetJFW3sQtqQw4iGBwnjCMSw2Kn/BuVyTH1J0sGuEkdzX4n/ELPhfegAvHS0ZGdTwaGopUpMVsRnpdZycE8CNEc6e70ePYprntlY4Zi0KDKwpZGI3eGfDo7NHpgZlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c69a2c-b891-42e2-3424-08dd8f11ddd9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:55:05.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QF8vsL2JN8YPdtv6LfPBowxTIqgLNoXvQ4YIv8T3lRxnBBp7Z4ajyjBX04N4y9eltpHwp5ocFdm1DOp/KUJpvue9fkEx2vNpMRsZ4SnZDFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505090157
X-Authority-Analysis: v=2.4 cv=bPIWIO+Z c=1 sm=1 tr=0 ts=681e258f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=YgntCEnaJufBzBUpndMA:9 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: sh6be7AExUMso9g5qg9KjZRgPqImN8tc
X-Proofpoint-ORIG-GUID: sh6be7AExUMso9g5qg9KjZRgPqImN8tc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE1NiBTYWx0ZWRfX7YJtBr+y6sBA UoW8gSEe2HlNI+IJXq4VM0aeNbQDk93i73bspNvTg0KdJUI2HqeQJuVKaEC1IF02d8aZ6wOHdUr jN/sziMH/1v08rYvJx7j8x7JjEVOWj3XwvHV70n8/8zmWUtIBtIw/I6cDDxTeKJoRxZRHh4isvg
 tyVqfGFiG9Wu92Y2fH2wkMpEuv6c5lsxgUZBRGdB+IzXHgv+Mq6hTkhg5MhvO8ktU4tnEOiACWs GLy7RpuimuwizoLNaSo/Qx5chBPCiC9PjI6Pevo//gTDYVgKrDNn3dGCtsY0JvZPAI2ddQQCaol USMID6/2W7MiCzXLnkNOAry+6dbbMy8An7LUia1n5ylHyoI/SbsB4wwAMf5uTvUJ4DNq9y0+WBr
 HDP0aP2quZb2XLLC0DES57gJOiFwk8d/N8WitJdZupZmm5/N5BzyMhnl56cwSO8BGsFv67Xf

On Fri, May 09, 2025 at 05:30:32PM +0200, David Hildenbrand wrote:
> Let's test some basic functionality using /dev/mem. These tests will
> implicitly cover some PAT (Page Attribute Handling) handling on x86.
> 
> These tests will only run when /dev/mem access to the first two pages
> in physical address space is possible and allowed; otherwise, the tests
> are skipped.
> 
> On current x86-64 with PAT inside a VM, all tests pass:
> 
> 	TAP version 13
> 	1..6
> 	# Starting 6 tests from 1 test cases.
> 	#  RUN           pfnmap.madvise_disallowed ...
> 	#            OK  pfnmap.madvise_disallowed
> 	ok 1 pfnmap.madvise_disallowed
> 	#  RUN           pfnmap.munmap_split ...
> 	#            OK  pfnmap.munmap_split
> 	ok 2 pfnmap.munmap_split
> 	#  RUN           pfnmap.mremap_fixed ...
> 	#            OK  pfnmap.mremap_fixed
> 	ok 3 pfnmap.mremap_fixed
> 	#  RUN           pfnmap.mremap_shrink ...
> 	#            OK  pfnmap.mremap_shrink
> 	ok 4 pfnmap.mremap_shrink
> 	#  RUN           pfnmap.mremap_expand ...
> 	#            OK  pfnmap.mremap_expand
> 	ok 5 pfnmap.mremap_expand
> 	#  RUN           pfnmap.fork ...
> 	#            OK  pfnmap.fork
> 	ok 6 pfnmap.fork
> 	# PASSED: 6 / 6 tests passed.
> 	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> However, we are able to trigger:
> 
> [   27.888251] x86/PAT: pfnmap:1790 freeing invalid memtype [mem 0x00000000-0x00000fff]
> 
> There are probably more things worth testing in the future, such as
> MAP_PRIVATE handling. But this set of tests is sufficient to cover most of
> the things we will rework regarding PAT handling.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Nice, big improvement!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> 
> Hopefully I didn't miss any review feedback.

All good afaict! :) the only thing would be to make the siglongjmp() conditional
but it's not a big deal.

> 
> v1 -> v2:
> * Rewrite using kselftest_harness, which simplifies a lot of things
> * Add to .gitignore and run_vmtests.sh
> * Register signal handler on demand
> * Use volatile trick to force a read (not factoring out FORCE_READ just yet)
> * Drop mprotect() test case
> * Add some more comments why we test certain things
> * Use NULL for mmap() first parameter instead of 0
> * Smaller fixes
> 
> ---
>  tools/testing/selftests/mm/.gitignore     |   1 +
>  tools/testing/selftests/mm/Makefile       |   1 +
>  tools/testing/selftests/mm/pfnmap.c       | 196 ++++++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh |   4 +
>  4 files changed, 202 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/pfnmap.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 91db34941a143..824266982aa36 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -20,6 +20,7 @@ mremap_test
>  on-fault-limit
>  transhuge-stress
>  pagemap_ioctl
> +pfnmap
>  *.tmp*
>  protection_keys
>  protection_keys_32
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index ad4d6043a60f0..ae6f994d3add7 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -84,6 +84,7 @@ TEST_GEN_FILES += mremap_test
>  TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
> +TEST_GEN_FILES += pfnmap
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
> new file mode 100644
> index 0000000000000..8a9d19b6020c7
> --- /dev/null
> +++ b/tools/testing/selftests/mm/pfnmap.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Basic VM_PFNMAP tests relying on mmap() of '/dev/mem'
> + *
> + * Copyright 2025, Red Hat, Inc.
> + *
> + * Author(s): David Hildenbrand <david@redhat.com>
> + */
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <linux/mman.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest_harness.h"
> +#include "vm_util.h"
> +
> +static sigjmp_buf sigjmp_buf_env;
> +
> +static void signal_handler(int sig)
> +{
> +	siglongjmp(sigjmp_buf_env, -EFAULT);
> +}
> +
> +static int test_read_access(char *addr, size_t size, size_t pagesize)
> +{
> +	size_t offs;
> +	int ret;
> +
> +	if (signal(SIGSEGV, signal_handler) == SIG_ERR)
> +		return -EINVAL;
> +
> +	ret = sigsetjmp(sigjmp_buf_env, 1);
> +	if (!ret) {
> +		for (offs = 0; offs < size; offs += pagesize)
> +			/* Force a read that the compiler cannot optimize out. */
> +			*((volatile char *)(addr + offs));
> +	}
> +	if (signal(SIGSEGV, signal_handler) == SIG_ERR)
> +		return -EINVAL;
> +
> +	return ret;
> +}
> +
> +FIXTURE(pfnmap)
> +{
> +	size_t pagesize;
> +	int dev_mem_fd;
> +	char *addr1;
> +	size_t size1;
> +	char *addr2;
> +	size_t size2;
> +};
> +
> +FIXTURE_SETUP(pfnmap)
> +{
> +	self->pagesize = getpagesize();
> +
> +	self->dev_mem_fd = open("/dev/mem", O_RDONLY);
> +	if (self->dev_mem_fd < 0)
> +		SKIP(return, "Cannot open '/dev/mem'\n");
> +
> +	/* We'll require the first two pages throughout our tests ... */
> +	self->size1 = self->pagesize * 2;
> +	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
> +			   self->dev_mem_fd, 0);
> +	if (self->addr1 == MAP_FAILED)
> +		SKIP(return, "Cannot mmap '/dev/mem'\n");
> +
> +	/* ... and want to be able to read from them. */
> +	if (test_read_access(self->addr1, self->size1, self->pagesize))
> +		SKIP(return, "Cannot read-access mmap'ed '/dev/mem'\n");
> +
> +	self->size2 = 0;
> +	self->addr2 = MAP_FAILED;
> +}
> +
> +FIXTURE_TEARDOWN(pfnmap)
> +{
> +	if (self->addr2 != MAP_FAILED)
> +		munmap(self->addr2, self->size2);
> +	if (self->addr1 != MAP_FAILED)
> +		munmap(self->addr1, self->size1);
> +	if (self->dev_mem_fd >= 0)
> +		close(self->dev_mem_fd);
> +}
> +
> +TEST_F(pfnmap, madvise_disallowed)
> +{
> +	int advices[] = {
> +		MADV_DONTNEED,
> +		MADV_DONTNEED_LOCKED,
> +		MADV_FREE,
> +		MADV_WIPEONFORK,
> +		MADV_COLD,
> +		MADV_PAGEOUT,
> +		MADV_POPULATE_READ,
> +		MADV_POPULATE_WRITE,
> +	};
> +	int i;
> +
> +	/* All these advices must be rejected. */
> +	for (i = 0; i < ARRAY_SIZE(advices); i++) {
> +		EXPECT_LT(madvise(self->addr1, self->pagesize, advices[i]), 0);
> +		EXPECT_EQ(errno, EINVAL);
> +	}
> +}
> +
> +TEST_F(pfnmap, munmap_split)
> +{
> +	/*
> +	 * Unmap the first page. This munmap() call is not really expected to
> +	 * fail, but we might be able to trigger other internal issues.
> +	 */
> +	ASSERT_EQ(munmap(self->addr1, self->pagesize), 0);
> +
> +	/*
> +	 * Remap the first page while the second page is still mapped. This
> +	 * makes sure that any PAT tracking on x86 will allow for mmap()'ing
> +	 * a page again while some parts of the first mmap() are still
> +	 * around.
> +	 */
> +	self->size2 = self->pagesize;
> +	self->addr2 = mmap(NULL, self->pagesize, PROT_READ, MAP_SHARED,
> +			   self->dev_mem_fd, 0);
> +	ASSERT_NE(self->addr2, MAP_FAILED);
> +}
> +
> +TEST_F(pfnmap, mremap_fixed)
> +{
> +	char *ret;
> +
> +	/* Reserve a destination area. */
> +	self->size2 = self->size1;
> +	self->addr2 = mmap(NULL, self->size2, PROT_READ, MAP_ANON | MAP_PRIVATE,
> +			   -1, 0);
> +	ASSERT_NE(self->addr2, MAP_FAILED);
> +
> +	/* mremap() over our destination. */
> +	ret = mremap(self->addr1, self->size1, self->size2,
> +		     MREMAP_FIXED | MREMAP_MAYMOVE, self->addr2);
> +	ASSERT_NE(ret, MAP_FAILED);
> +}
> +
> +TEST_F(pfnmap, mremap_shrink)
> +{
> +	char *ret;
> +
> +	/* Shrinking is expected to work. */
> +	ret = mremap(self->addr1, self->size1, self->size1 - self->pagesize, 0);
> +	ASSERT_NE(ret, MAP_FAILED);
> +}
> +
> +TEST_F(pfnmap, mremap_expand)
> +{
> +	/*
> +	 * Growing is not expected to work, and getting it right would
> +	 * be challenging. So this test primarily serves as an early warning
> +	 * that something that probably should never work suddenly works.
> +	 */
> +	self->size2 = self->size1 + self->pagesize;
> +	self->addr2 = mremap(self->addr1, self->size1, self->size2, MREMAP_MAYMOVE);
> +	ASSERT_EQ(self->addr2, MAP_FAILED);
> +}
> +
> +TEST_F(pfnmap, fork)
> +{
> +	pid_t pid;
> +	int ret;
> +
> +	/* fork() a child and test if the child can access the pages. */
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (!pid) {
> +		EXPECT_EQ(test_read_access(self->addr1, self->size1,
> +					   self->pagesize), 0);
> +		exit(0);
> +	}
> +
> +	wait(&ret);
> +	if (WIFEXITED(ret))
> +		ret = WEXITSTATUS(ret);
> +	else
> +		ret = -EINVAL;
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 188b125bf1f6b..dddd1dd8af145 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -63,6 +63,8 @@ separated by spaces:
>  	test soft dirty page bit semantics
>  - pagemap
>  	test pagemap_scan IOCTL
> +- pfnmap
> +	tests for VM_PFNMAP handling
>  - cow
>  	test copy-on-write semantics
>  - thp
> @@ -472,6 +474,8 @@ fi
>  
>  CATEGORY="pagemap" run_test ./pagemap_ioctl
>  
> +CATEGORY="pfnmap" run_test ./pfnmap
> +
>  # COW tests
>  CATEGORY="cow" run_test ./cow
>  
> -- 
> 2.49.0
> 

