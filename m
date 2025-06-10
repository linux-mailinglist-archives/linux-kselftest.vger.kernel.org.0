Return-Path: <linux-kselftest+bounces-34588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9936AAD3A07
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422761894EE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C8B2980B7;
	Tue, 10 Jun 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g2b0xgva";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B8RSIh+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804728B3FF
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563767; cv=fail; b=EwXi5IhBFl27pqd922yHdIJuEp/Qqm1MhM+beO6DVnLRKpj9lpJsLlEhvAxvClePIW3sPEOLL4GfGfywWtMEYK9W4eMLrQZy0GsxKruo6kCUHQOqiLAA/OvObl0ISPAnMUa+VSTPTrnAe3uNobfVla08w+OT8mcBmbT5Le8OcLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563767; c=relaxed/simple;
	bh=ezwaQPdzaIBay0Wav5dBIe1ytg8Bu+CtcqEY/7ZCIq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XWy6+8azHL7IBe0mpWjvDzEnRe2JBuAudbrYLsCpOzUkvWUiCQmyj5zUhzvd4TJDHf6Rut5IIIA4fUgBqm8MRjzgRA6vw/tOHy19KLLlHFMOvgZ5Y9o10hCrHaLlxoh9VgGCis8al8qXMeD790BgclWd1phZH1PlaNtXBCGpOGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g2b0xgva; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B8RSIh+y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADBcM6008606;
	Tue, 10 Jun 2025 13:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9G+YRPgM4NqOO95lpn
	UKB2K4Q72sHv+CJO0N4ZxJGvI=; b=g2b0xgva8dQ0etTwHJY+J45qjTSZiUVsZQ
	0Vk33uy9uFtiVbtohxbSUfQeRKYdDkWAtiU927gGfp/fKUCNInRnnfU+CtV7mJnO
	abNCJZHfEgyi3/qYhrmDglTK9cS8Y82HJKH0FPV7BlgtXGzdPwenpd5mgsGBM97a
	jCbiPAUlW3jSKzxYBCaBxIMsJ049gGTKdltXZvZ4r8FhCf2RMjezim+Rd1+q/BeN
	AAxsXsnrLhW9J4Vox2d7YUxGA1eL1NmHCNlLfgxCbaX+0XvRobN3KBd09S2ZP51d
	lgamSx9GcKjDdyNn154UepkZ69pLMTzHu1npQqH+V/yTznzbuuQg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf4an6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:55:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADomFt003344;
	Tue, 10 Jun 2025 13:55:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8s6vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 13:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxqXYLZ0ImM0C+K8leUPYw4ZDDSUSqWyvYZ+HVd7EveMU+T7Keb4ZDTKISr+3iAKhypgcoNosIe371NgXQVBXmPhu5hMzjM2NKHCELlmOUeH6c1/ZE49z67qwvlHvtKwKrWxaZtM6xs+fUHW02k38hO3K0RpRIk0/TQzCW3gQcOIbnWTd85kVYounZg0GOsg2oIb3TOpKTJ9iy5V53/Vt/SYjRghxia8XRvYS+MAKQXRkekmH3YCf5CHc9jIejBWx8LVRUTCQBBa/0dv8J64IlFxPdYE7CI6brUX0aUEVLhy2vlmLx/Wy54cGXQbvjltwd8GOjRW+gvRfCVLByHiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9G+YRPgM4NqOO95lpnUKB2K4Q72sHv+CJO0N4ZxJGvI=;
 b=Qv6grC5dfoI14UIuLsJs9qmyE5kgvijQU5b2wKy2D7XJ+ITuWBVocP9kgqFo29AWC6U+apKAC6KdG6ZJaxP3mTpL1xMvjDX6SXC5O+3CfKauBQD9tJB1T3wfug7bhvBKcqqokvELZc4UacXqeLAvfzBnobjoyP6DqFWPYc5P2Juq3HuCkw+ZXbwuoGo0hZ5ZstR1g3xqIrgTEHvCtdpB1buOxS35ohN0uDxY3txQEFAPIFftxfdnF/qJUPUgtKgPe33ExOhb48KnAcVo4q/K1g/n+C14lFGOAgm+QIoL4aSWfXVrVqLKo9geF9QhhhFip7vcnZ0Ydf7pn3M9tZe3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G+YRPgM4NqOO95lpnUKB2K4Q72sHv+CJO0N4ZxJGvI=;
 b=B8RSIh+y7EP5DjHMEdIKgpg6kMdI+KmKZKZneXdN5TiXdL7/sOoov8kdNa+jWbXB6knFSRYqY6wYfxynalUOkCt2Sy8HkIHsaW2xIjqU7izxrpTcPrkWRJSMf01Ye5annPDSXJwpTAXWu+7xJguCOIBEOuCtXJ000xm8G7OCByw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFA0AD88203.namprd10.prod.outlook.com (2603:10b6:f:fc00::d3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.24; Tue, 10 Jun
 2025 13:55:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 13:55:42 +0000
Date: Tue, 10 Jun 2025 14:55:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pu Lehui <pulehui@huawei.com>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Aishwarya <aishwarya.tcv@arm.com>, broonie@kernel.org
Subject: Re: [PATCH] selftests/mm: Skip uprobe vma merge test if uprobes are
 not enabled
Message-ID: <e9993a6a-712f-422b-aedd-dea197ffa6d5@lucifer.local>
References: <20250610122209.3177587-1-pfalcato@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610122209.3177587-1-pfalcato@suse.de>
X-ClientProxiedBy: LO6P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFA0AD88203:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e21e0d-95e2-4c36-5a9f-08dda8267d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uY3FRPLY/pS/wDbIsV3Z4Xrx0Cn6Si0/KFxYD8gbQ7HpC1kpxtQ4kESKAl0e?=
 =?us-ascii?Q?f/N8rLcrIbCRgHI58hl2pf43yUd5SpNgZU2rX/MASQLjMF+E4YbJRaQr6OuT?=
 =?us-ascii?Q?oUnrgwXOA5mSrQEIWD9z4TWGFfw5L3JVvYaUxwiNcOpzoU2BR8CwUZqYToTp?=
 =?us-ascii?Q?2zw15ZxzrPf8Ck3Da4W0542KLqg8v1TMVfl4S5YGIJZ9yYKB7th20f7UEENs?=
 =?us-ascii?Q?eXxH8i3V8GBkUrOjjTDjud8O+WAMDLpPrc+jJWtvUaOC2PVVRzWq6Gpc/p/L?=
 =?us-ascii?Q?MR/5q8eJ4Aiy06otVAqPZ1617cXYZ0YMkhoFJsr6Dz21LwWMC38CFkUZfjFD?=
 =?us-ascii?Q?ysJVHSEkPN6uWOJ/mrrB4BQOIxK9PKQHKoXmbFBXxzK2wvOTNYoqIsdaMCmF?=
 =?us-ascii?Q?EsavSz9odBdMUPXzg9Eu43Ak6g44YXoq+XY/ZlDdpN+8pvrUw229X9+c7mc/?=
 =?us-ascii?Q?89TNjGu76kvby7uIRQm/I92nea1o9Czya7G91Xd6+jqx1qiJ44qamfyEGLli?=
 =?us-ascii?Q?xM2Xtf+dlE/N0bzMQCSRXPwGru8dFbDvsPFF8EpiaNbCmkvEOthkHRM9jB4I?=
 =?us-ascii?Q?+hEsmmqes3HI18kdAR3VxKQCJMja2nqzyjLPc3sBIoAAbDzioSTgvcPZ+0P7?=
 =?us-ascii?Q?mYen7TIVUScfROodPprPhzAurml5zyiqFBiB0r/W7UYbuF0DM7GQOl4yzXPe?=
 =?us-ascii?Q?ClG2GW5fZp1p/PL0OwsLXc4yz6Dw9vueN96sldrb+gBfohxwLngYz7n02CLd?=
 =?us-ascii?Q?5R32fdahzvQQH24Ft2CTuD5SgeD8Eq92XNyNjayNIXG62JaXAPoVkSWQphsx?=
 =?us-ascii?Q?ANNtXEL6+fHfXWhP9FQMp5ShDwV8trj8zpACnaGsTbxxcapN8MzKf8JPxuyo?=
 =?us-ascii?Q?hbthTZEuWDfpI6wqjByMyqUKe5PQUJh3OO9Bm2BeNnO/afyr66ONCNNjaL/s?=
 =?us-ascii?Q?CmlG/J1/CwthROXFhwfdRpD1FQeMfZJx47ypt0yReZbiJLtpYj9vTi21h+zO?=
 =?us-ascii?Q?+tLW+o5jlAS1P+Hz95asnsHMU7NeRdMqQenYtKNfduBa5KN8KLmd6H4VW0DO?=
 =?us-ascii?Q?0lEtV7yi0z96ZcVHOFWEY+0AMiwc1SzHneiFUgXZFJ+7hR9y+oEX12ahCx7X?=
 =?us-ascii?Q?OU5PluUqGY51uVe1nAJk7Vi2j+97eHs7eQD9FinoEAu09sR49xFw0H2ePkTM?=
 =?us-ascii?Q?l5ZwDKhHpsy70hf/3sjozqSleT0nUEaok0XJtZi6tCu7mie3y+jAdq7V9/s5?=
 =?us-ascii?Q?xv1rZwAm9Qp3nIV+pjzhiINkVAHVpdahVywv6BysJE696Nft38G7Z6yi9ymR?=
 =?us-ascii?Q?Ly3IlQymmvN5KcjD7alukcCfjGVezjg6uncv2RX5L0X0nhon7Bcqo0xxaBMn?=
 =?us-ascii?Q?odNPOOxbpujuVbK3vdnSvYW+LpR9dlGPNUUNtlloxOLNsIgJsPcmhRrOnKwB?=
 =?us-ascii?Q?LZG7QdNAXBE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjOiCiximj32Zs0yyMFAS4Kvw5fLdpRQ9ByzwpBFKPJ9AA4pBr4uX8bfGWFe?=
 =?us-ascii?Q?Cqyx646Gl9q0GUlDFfXDcS6WI86lBULtcfZH1gq+TqgI8XjPoPC5EAfjk9xj?=
 =?us-ascii?Q?Z68ElsmCplP6pbqC0Q+tp4SSTZJ/bML2qLfQ3i+UEKmqsDWjcL6bNSxwFSFp?=
 =?us-ascii?Q?Hu/NPsbmfho6J54RTCbIqgAqs7EirqmmNyujJIGjy2aADtOKXTQkqZ4FTqdt?=
 =?us-ascii?Q?RDaCV2S5u58Fioa9C6mjLJF7YqrdK56FDt2gJeSXVV0kgu7/lAWj15vd1Xy+?=
 =?us-ascii?Q?ONFsHaXFu0D/2E2VuVZ5tLpJe0EfnLSS1pXD5Fh1E7Vw3LtVC1AZlitA9NcF?=
 =?us-ascii?Q?V3+bRyKDNdmHPejRthxdmdvKzHpsA9CxqlLzJj60t1epeeoiMFrUV28XAoeP?=
 =?us-ascii?Q?SSznYJ/v/aKJ2wa/eSRhx9liGN8tGpioV5YO2Tahtvd14dhD0JienIm/P1+s?=
 =?us-ascii?Q?R2IVePJ0aJwB4wfE/dytVg72goZTZh++2DNpE+jxuKrdtcEWab6r48iIgOnX?=
 =?us-ascii?Q?g77JWSMDz1Wy+fRDG1u1ac4KODlllIbeoP3h0VQlFIx0qk8Heys1p6C9lTCm?=
 =?us-ascii?Q?B8epOlS054V6CG3Pe/P5gGyBzIePbwJxkmzzeMOGaONrxVo4TKafv1C/1Owf?=
 =?us-ascii?Q?ouLMzTGaMhAaIMRH0vgCcBM5iif4K2tgIfeRPHnbKdvwACRhlBaf5QfH+if8?=
 =?us-ascii?Q?R79VbxNXIK01vcJIeRn+oyLt3+nBlGOHdc5uHNFC6igflON6N3Wps/XSOvjL?=
 =?us-ascii?Q?fLoozFeFaRiau9LEF8rbz+ACXdLTQ7EwdXrze8Yo+yReknabFmHVUkilC0hK?=
 =?us-ascii?Q?TemMYt7r3YUS+Lz5lWSRoZwvU2BZ3UnwSRqAikbbBJGGsgvqCyE+H+PmyQ/h?=
 =?us-ascii?Q?beAMn7nuvjtBtfEVVkmRN44/ixhmIYPN/KsDeYhjy2QD7mDCuJU9oybjtcwC?=
 =?us-ascii?Q?Wa8yby3altz0deKqb15OP1ewXhwVl1LNYZtrH9BcQA4aIp6jBTmpmfjlxDPe?=
 =?us-ascii?Q?z/+O290WT1O6Om9PaVLPZW1A6Y+gf3x+gss08bWa1G42xr2x6nqpE2YOVinn?=
 =?us-ascii?Q?gWUshrmqVkvl+pYR4azh9YAwAnCHb54j3sXqYTUTN3fMId/lSBDqbIGydL6N?=
 =?us-ascii?Q?ZOiVWm3ZKAc7RZ8yRZ8l1PSwk0PZvCktsB2hTRRiRkgikGWieOXgvu6XjUG3?=
 =?us-ascii?Q?1Q5S2ZiZB08LP3Qflo7dblCJ7PP0AsGzPSnYU2y2mchQdw7P8k5C3s5T/1zM?=
 =?us-ascii?Q?2VWrKq1yhG7kWd1qYLMen11p5ZneK+nxacn9kvVcmRqp2x+DV8yoCBA389Dh?=
 =?us-ascii?Q?RT7oA26p069fNyqrUv8b6MQWjrXwSl/HkICzzktUSpljooJ4VTzE49Pl7M39?=
 =?us-ascii?Q?37Vyfkw3tHrMw8/JwDvocbTBiGeCbVNyQLVpDzGJk+DZgENQKq/qyMJVgzmD?=
 =?us-ascii?Q?X1IMe2ZePJbp6ujS8rmTdai6koWKt+3OmjD4H5m9ZJ/zDb6a0XCghDnrCiqt?=
 =?us-ascii?Q?Ec/dbjY8YZ3MoIqi86KrVt9nRg4AeGbSVs4ERupdWWWz2Do6cpnS6vbWriMt?=
 =?us-ascii?Q?KpbnH8UcTh/1HOYJdTMRZZR0mppNu94JJR4QdArdjdYzmssGhx0l5RHOQtTy?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U3dsn/H3Zw2Z8ovBh2cNB0gTZCKHoJvoPFa78+R5o1gz6Utm5aVxssMLk1Nxb8XIgZZXJQDtdYK2PwSSW9y/zxaZzvmAU1IAIk/qGZyjHxzuRWNQz1Qv7nr1S4foK/AktgzAW4dmFmMApOr+fQtVU2Vy8eBs6rnq56PTT9QH5nOkiMQXjZV5hxnxbYvQ2N4A7nBPJhSjraY3dpXPgbULk4kgHBzggNSMCQ2mSInKrZp2Ljbdye3GidWATUDQC5iwmcWxyYeSfra28d4fesM3ViDZinxl5p9dxXRzeYVdseI14ChiqjDufONTBUk02nxjU0IIqrYuYjeT5WO4+vyUFHJMV/FshXIFrfdTN5enjT83UgK7JTaMukUJxX6n15U8UBRqJu8JsVyUb/BMo/fWNYZMli4PagzkuNbJFwaN497tMBoZgbHd/gdDQ0DNj/TcV4znmDsf2des3o/WCCp9uh/nTVTA2yyVMZ6Nqq9qE1wphdxCROFyZ1KvBkvffvoapmEDltq21hiKJwAO/JApjbBBktxT74oDdyBQRo52CPZCXrJllHz3TYgZ4MWjbxmvIkhYFX7MVpE/rUavfo3oukB48Lo63JgUQtY3JEaE5H0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e21e0d-95e2-4c36-5a9f-08dda8267d34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:55:42.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzpKHx7J2BvKmmywUmDK2n24IWbLPS7iPVGJbsQfNVPk+CHhKIia3pB/LV0QXT9Ro9ak60gDSwARZ9cHTgJaFYU91f8Ike385zjevQeBS2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA0AD88203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100110
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=68483961 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=h6i3v21f8pZAO7MeEkkA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:14714
X-Proofpoint-GUID: eWxBrzVV3EMEcXNqSA9G42nw2HNpcPPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExMCBTYWx0ZWRfX8w44n5+qf1tX ExldnyKn+xwPJv2qQCiio76L9B/1L2MWJho/4/l2AmXAFIKFik9z7k+hOdrahpWiSSOxZkeywA4 uWKnM0eTIXPXwAY8u7j91FJtcqCu1xMcAgQqo6e32KWt7oFFWcm7Hr9R/xIVLQxmmrNqkYm3Ii7
 oXNQiIsEwrmMJhl/0CwNxOS4yahlO2Fgzy251eL/mQAWOdX0XfoRVZfk7okud3eOQA0rHMmFycP TU2PE4eFpLKbkcyWek5ofZMJP4fCGuYvT6EndJUPyA0fPh1gLFUP8vzzEui8k0419WhdF36OdVy Y8eBHakRKjrRE1cYf66LKnmdZtVg5+L8s/0YSYFnF3XfwaYZIlpfXspoNLDEpeSlVFYO52m6RkK
 h9r+i6c+uzmspxpqupfuLw2t50aU0G9WON4yolad1cydbesQyZhSjxypza2ZC2ADNpG8grSK
X-Proofpoint-ORIG-GUID: eWxBrzVV3EMEcXNqSA9G42nw2HNpcPPf

On Tue, Jun 10, 2025 at 01:22:09PM +0100, Pedro Falcato wrote:
> If uprobes are not enabled, the test currently fails with:
>
> 7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
> 7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
> 7153 12:46:54.639306  # # fopen: No such file or directory
> 7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected
> read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
> 7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
> 7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
> 7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
>
> Skipping is a more sane and friendly behavior here.
>
> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/linux-mm/20250610103729.72440-1-aishwarya.tcv@arm.com/
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/merge.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> index bbae66fc5038..cc26480098ae 100644
> --- a/tools/testing/selftests/mm/merge.c
> +++ b/tools/testing/selftests/mm/merge.c
> @@ -470,7 +470,9 @@ TEST_F(merge, handle_uprobe_upon_merged_vma)
>  	ASSERT_GE(fd, 0);
>
>  	ASSERT_EQ(ftruncate(fd, page_size), 0);
> -	ASSERT_EQ(read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type), 0);
> +	if (read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) != 0) {
> +		SKIP(goto out, "Failed to read uprobe sysfs file, skipping");
> +	}

Thanks this seems like a saner option!

>
>  	memset(&attr, 0, attr_sz);
>  	attr.size = attr_sz;
> @@ -491,6 +493,7 @@ TEST_F(merge, handle_uprobe_upon_merged_vma)
>  	ASSERT_NE(mremap(ptr2, page_size, page_size,
>  			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr1), MAP_FAILED);
>
> +out:
>  	close(fd);
>  	remove(probe_file);
>  }
> --
> 2.49.0
>

