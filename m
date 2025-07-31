Return-Path: <linux-kselftest+bounces-38112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C03B174FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 18:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709803BA6EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8B222587;
	Thu, 31 Jul 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DJnZnYRw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hgLU65Xk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081D7176AC5;
	Thu, 31 Jul 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979574; cv=fail; b=YEAnvoG888lmaRsjaZi2WWgqRpry95I72pKCmTnFqp/EVtFjM+WSw1kNac3q0ge7kMis0S+qxmwD/ErovZNiIQznJtf62GDWvaCdj7f2x3hl1cV2Qlu9UIyHzuQNhFzjQxcqDvVvA5D9uzHmnzNUlfT68zrucN3BK1vSr1iADjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979574; c=relaxed/simple;
	bh=qj8UL+eEcRyaeVGXhYl8a7Me2ofPxCMacmmrv+VfTyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p24CygM5O4Dy7PSnGQXR6sWYV4LzQC76pTxPVTNwK+Cdtsd2Z58nSOYl0fX9WFvunkTBhFC7Ai8YVQQG0UQSJQ2TRcGvu4Elp4r3+vgmpD7cn/zpkiMt28R4QjF8aqx9PQlnzC6tpgBeWnS6zyaIgBcpd904J4E2yQjzopb6toc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DJnZnYRw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hgLU65Xk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VEuKIb010342;
	Thu, 31 Jul 2025 16:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6QZHc/IFoK9KCbNWbf2R9lvW5rpvevY+6C46fE6tVn0=; b=
	DJnZnYRwJ+qHPcO62MG6DRqbRcm5lg0Td7toCvWs0ZHfRakfSeaTDKY1bDuFlOpN
	VEnQhsBhpN/RUm6/UJHI2rvR8ekLsgRHcieIq07QHsjoXep+ZEQC/PEpLm82uAXU
	cTrBU4DFrPAH6Suop79rEvYtrSqc2cxZvpDmEufkVfv7pzcCAIIKQ7VV0x7ZmLea
	dN1mRbEyyJquAK/JgQl/OGRjPfqFUaUuGx6BSlz4hRXul2lixfr16EdyOOFSEP5k
	e0JuQ+s7qkGZhGA8RzeHFUdrN+d1zWsSb3K4p9OnzFNtIQ/SOgA7GncZ6mF+zQSu
	LaVpReFc+o1nTlBwj1PAjQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q29vmf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 16:32:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VF1Yen016685;
	Thu, 31 Jul 2025 16:32:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfk1mdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 16:32:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVBJETRNJTXldZ66RnsnJpp5JW+JDARflPZDaWtgMVqAHHb/UgamLA7g2MexaG3UKw9hxYnbGr4pcVT7kL6CwFCCZGd/71G8NM0eFKfl2wt0+4xM0XCAK97Ez8LyenggX7qI0I+z6p7hns4OTm0wkZVU8wOOXoSMKTdNiywMHkATLrsv7DmAZUpzttitW3dPmlXtVseWeVjYmRXuwOZdLsqrggVJZhnq3l8EyhhgvYrmJqV1KXZEB5xLTeRwoQMd/eVZjOSwibkwC/jrlWpEz7yx7MRYaSs6LQ26LumO8FZA70nHn9N9tFixpmlCEVmHR+K9d0VFna2ESrWPJ1ZoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QZHc/IFoK9KCbNWbf2R9lvW5rpvevY+6C46fE6tVn0=;
 b=xJLEnJX+AtDhXJa6fIcqfWmX0mHOxG36o7JKxbTjPQ32sRKCmN6qYYKyODem4efYdek+fVDOLtHqChU8psGHjvQcTFnsORn0NZS5APDPINqHxrnVw1jRYjVEZB04GizTvNp3o2LQhN00j7Z9LZNXkOPKtKgTtzXe1heijkrvWCGrZb3dzrTjFpIl1pzeVnJpZzPDfMHr5t5v55YBPmuaavppFitlz209OkTCYBwLWsa+ImyJR9290M6wio9lfQ0btmzZbqKQs5fRIoS6gumjnx0uBwnmH20LKjCuCpMA9CbF2aT8x1S5m9RJK2Vt6vCJEl4pZ9B/l+glPuUBqd//DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QZHc/IFoK9KCbNWbf2R9lvW5rpvevY+6C46fE6tVn0=;
 b=hgLU65XkB5vS02qnOv+HAywqmgy4Hbmn7mLyF7uawTxXcsC/E/4B6SkSq/lh0aQEp4nl+8fb9RkI3fGo/7bXP72IkZx2XfrMh82eCt/gyZAn+LwZHYxnJV0rZGL5oIJ3UW7dkdjCf4XjyMmDL/s8RU/54o9Zgc7sgYjMCG7wmBM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB5854.namprd10.prod.outlook.com (2603:10b6:510:127::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 16:32:10 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 16:32:10 +0000
Message-ID: <5e5998c6-1375-4a68-8291-9728eee4bb07@oracle.com>
Date: Thu, 31 Jul 2025 12:32:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] selftests/mm: Add -Wunreachable-code and fix
 warnings
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20250731160132.1795351-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::28) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 4728959f-cd77-406d-c00e-08ddd04fcc03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3V2UUxERmtQRWxtbjcrdWw2ZFFIcVp3eUxnTWUwSHByRys5QjZKUksrcU9Z?=
 =?utf-8?B?eDU0aGNCbGZIQm5qOFFTSVIwcVFnZU9KUS9obEQwZUVYUWNRSTVzaXFlMC9n?=
 =?utf-8?B?Rm0xcWdXWVZWeGRPN2gyOUpheVBsb1NDdXlWc29RZFd1N3lRL1IxRmgwRmJt?=
 =?utf-8?B?am9UL2RyUGJmSXB6TmVPZUxxaG5wck9JT2JNN3Q5RXJRRThlQ2dJdFRmMEpy?=
 =?utf-8?B?dVY5Yy9Vck44Und3b2o2WEtES25IQ0h6YVYrdW1FVVJQbEJtQnprTXJEeFNu?=
 =?utf-8?B?R0lQT0dteXZjQWlrUFNpc3REVEZDN2IxTmwxWXV4ditZdDZrdUNSSHZEdExv?=
 =?utf-8?B?VjVDMm9oRlV5VnBUU1FxQTNIV21IZytJVCsvcjVyWVV5anovT2NTelhXaGpJ?=
 =?utf-8?B?cnluRHVwQW9rWTFPY1hqVzZxd1RZZTJRanFPSm95WmF0Z1VWTlRNcUlQTUFG?=
 =?utf-8?B?RFBmMFEwMW9weklPSEZwckg1K2NrNU55b0tRMHkwVTlGbnJzYTE0blNOaVpv?=
 =?utf-8?B?L0pYOTREdkRzWG1nd1VjbHhZUFIvaTdKOGNPdDVTSnduSm5DQW1uRkR5VGR4?=
 =?utf-8?B?SUJrYk05SGlENEJUTUkrRW1rR1lDWGFOQjRQeFd0aiswKzBzdjBnNFJYTDJr?=
 =?utf-8?B?eWNEUktWRzh5OEZSa1IyVDI0NlRScHNQRVBBRTdJTmZ2N3drMGNiaWxFS0xW?=
 =?utf-8?B?bFNHYWlOUklacWoxV3hWNUcvOVJyQmcyc3BOMHVLNGJydWJtSkFCNjhzeC96?=
 =?utf-8?B?VW00UmFxOWZRR01oeDBkc3NPQnN0MFZUSHlKdXdwZXVZQ2pNQUVjWFRUQ3Fy?=
 =?utf-8?B?K2M5cmNwM01pU1FqRjhLRkpNSjNLNTR2ZXp6cXVLdkQwWGt3SUpnM2YwenVE?=
 =?utf-8?B?VWEyT0xBOUFVYXM2ck9LcnVVaG0wckhDaU1zNnRtTTd2ejUrY0drMXBBWW9p?=
 =?utf-8?B?emFEZjg1K0VSNzJ1SjFmbVExVExzSEdjU3E1dThVbi9saHFPamxsUnRJcHkx?=
 =?utf-8?B?ekFkbVFaeFRRM2MrcGh3RFdYTDJOYklmenVsU2JHNVk5UWJ3ZXJpa2gxcDFa?=
 =?utf-8?B?c1Y0NEd4TlNWL2tocWJXVVh1TXh6YjRXQjNHaVlncXNFTlZRQy9oTkNWS0N2?=
 =?utf-8?B?ZEFndzUrVHVsSzh6c09DY1F5OTdYZ0hWVkZxMnJ6UlA4SzNGKy9GVEFaRmxS?=
 =?utf-8?B?UG50QUFMbG9PM2lVZTA1T2gxWkJNYjR4RVZQelVjbWorUHI3TGYxMTNhTTRS?=
 =?utf-8?B?YVZadkE1S2NCeS9BM3dTNFVkM1dLVUZHciswM3liNGk1UEJGOERKUUxlL21o?=
 =?utf-8?B?Sm45S3BDdUJ5U1Z1TVVEQTRTZkFScWZLZDgzaForek14ZXFmQ0NKWm02Zm13?=
 =?utf-8?B?L1dpakdMd2dVZ0pnNVE0b1BhaDBNR1I5MkJ4VCt6cWNLWVB0eVg3NjRZcHo1?=
 =?utf-8?B?ZHR1VW16alJ4L29tZU5oOFFsUi9ldGpxRDlHeDFISGtmZlc0UDlYNEhFRFFW?=
 =?utf-8?B?TmZ6R0tuRWdHOWNRdURaQ050dHk5bDBhMnlHVEJRRmEwMW1JQ0NKOTNSMFBP?=
 =?utf-8?B?bHZ0TmRiQmhFTS9qZ3dxd21RSEpjaWlHUEZaUkxxN2p2aTBWaFI5OGVZNnJk?=
 =?utf-8?B?QTgxUmpiQS9XZ1ozYnRuZVNWcjlmaXNwMlNwR3J4MTYrbDVlRWVIbWRaMnhR?=
 =?utf-8?B?WndESnJtTXF4Y0JkNHBJanEvajN5NjVJSHlGRVEvQ3VhU052Zkd4M2tCTUl2?=
 =?utf-8?B?R1M4T2o1MkV5ZW41S0FzcG1jRXd1Z3JOeGtsZjVZS3pYZENrZ1NmUmJ1ZEo3?=
 =?utf-8?B?M21ydEdYYzdvSmF6enhkVysvdFJlb2RxMklaMVZ5Ync1Y28xUys1Y1VTOW1v?=
 =?utf-8?B?eFRRYSt4dlI3TkJnVzlJR1h5S2VPMklUdVpNbUtxc3kvSkd3dklZemJUT1ZR?=
 =?utf-8?B?dlhubkM2c1ZoaXZUTzZBUnI0UE5tOEk2VVpIeFp6T2NwTTF5RHVOQ1Y1T0x0?=
 =?utf-8?B?R0lUVHk0amd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnE5Y0l5VFpoOXY2K1lobDRILzR3emlSSE5sR2M4S00vVGlNcXNoZTlaM0pt?=
 =?utf-8?B?OFZWamVlOWtiTmI3TjRjWXVnNlF3SjRoMkFhWVlSSzVrdmpkZUcyZEQ0UmVT?=
 =?utf-8?B?WHkwazVraWg3QlBkUmJ5QTM2N0dTdERmL2JaS3EzOFBVQjlGR2RXdUc1K25r?=
 =?utf-8?B?WmxpRjA0eit1MnJnanlKT0JXSjY5N3ZINlRsUzlXd29YK2RTMk8zYWJkNjEv?=
 =?utf-8?B?bTFGMU9GUlVhNzFvWEtKdWFpcVdxRXoyeHJBYUh2UFcxK3NMaTk1WXI4WkZY?=
 =?utf-8?B?NS8weDB4Umdib3hWdmF6TDBCRUF0c2xaTmFvTElOZ3VFV29rdTV5YW9DUnpU?=
 =?utf-8?B?M0E4eFJpd1NaL0l4VlN3QUQvT01lRytsN2kwOFhCUFBCRG4xS0JBWDlJTDRu?=
 =?utf-8?B?blNvRStiaUNYMnAwV1RqamJmTGhxZ2xXRVBUVU9HQUdMdW9tZnM2TFdwV093?=
 =?utf-8?B?MDE4bk1leHBHcHRIamRrQXRPeXQzZ3Ixenp2YXE2SjFqMWhHSTB4QnE3cFdv?=
 =?utf-8?B?NFM3bVFUdUlWbnNCdFMzeERCbzJ1THVCWDViK0MwQTNiclJGdkNUVFFpNzVG?=
 =?utf-8?B?LzJRbkNoak51K01ETmJhY285RlZrSHBIY200cENJZ054VTFrbUE5czZWendF?=
 =?utf-8?B?NkpFeHI2SkVmK3MrT09MNHNOa0tLd04yRHdlaUFMVHVnKzFvdUFDVmx0WmhY?=
 =?utf-8?B?eERwbVMrbWJEWjNhanZTVjBoQ1NKMzNKNVNIZGFydkU5Uk1pWGRzQnlBZGhW?=
 =?utf-8?B?L2pzRGdRTENvUGgvVzd0ZUhtZTIveEFLZFVmcFJINFJiQ29zeTRjM252dkYy?=
 =?utf-8?B?VkIrc0RWdHZ6aFRDUjRybHlHTjdnV2VyTUZTeFlzTWxsTmRwek9mZ3U4SkNv?=
 =?utf-8?B?cUFnSk8wZjdyUWdpUkdCemx2cnErLzFYeW5pQzJVdXFLQ3FzZmlVbWY5ZkVR?=
 =?utf-8?B?b01zSjdiRHF5aEVucU1ubkoyREJtZUgwZWVjZi8zVThaWmZzUldkSndXeXpM?=
 =?utf-8?B?cXh0b09IRXRMWW9RZmlZWUI2M2ZuUEpuOS9Mb0NHbXZIYVBVNU0vTDQvajll?=
 =?utf-8?B?Sy9hU3Q2MGp0akd5VDE4MUNwcVozVTNzYyt1V0RBYStXODcxdFlMNDgrK1N2?=
 =?utf-8?B?Q0VKeUh0eFo1M2FvZUxoVUM3UUtQb0c2bk9hMkFpQjhJWXlVcUVEbFJtUnRQ?=
 =?utf-8?B?ZEhSeXRNQzI4VTdxUGhyQTc4cWpnVkIyZ2JHNmtPaXVBR3haQ1B2VjVQaDFx?=
 =?utf-8?B?cVhLVW55TkFrS053NlBvU05NR1Y2Tk81KzJUZXNYM2tkMXpYMklZVkRDMDZv?=
 =?utf-8?B?RGlOT3ZuaEswMFhUV2tXK1lEYUtzaWtoajNWSWMrd0oxc2xyN3oyV0xyNnVS?=
 =?utf-8?B?QW1naXNGekhRV0F6V0RncXFYaXJySmFRRnZKZ3E2YWRZbmJyRG9hVDBVUmVI?=
 =?utf-8?B?UjNiNVNvTVgvMUhpTWlVendlUXZRQzVyRVBHU2pLQithei8yNUVqMFpaaG9M?=
 =?utf-8?B?RXhzMm4yakNnNlE4ZGl4YUR0THlMLzNFYVdQRXQ5N2lmNlI3RithdnNUYzZw?=
 =?utf-8?B?dEUwVVpTWUprdXhoRTk1NFB6bWI1c0ZEcEZ5NGVSZjVmaFJSbDJDTXdaYW1G?=
 =?utf-8?B?WFFCcGY1SzVobXFVM1R0OWE5RFVQcTlVUnNtRFRyNHczVVhDRWd2NjBjaDVj?=
 =?utf-8?B?QmpQSFhHdEtOS3NnVmpJbDZqSGxLaW9lZGsvWCs0cC9PTVRMU2NSSXVkUmtQ?=
 =?utf-8?B?UDc1Y0Z4VFF0OVQ4K0NhTFE2ZEpsQnFldXRnbTRCeXNmazFGUVp6eHZ1enBF?=
 =?utf-8?B?Wm05Ky9meXViQWdETjZ6OUZwUXNsemhRaTdZNFE2enc1bjBETjJLaGxsdVJT?=
 =?utf-8?B?RVJGbjRhVzkxYUZzUmpqeEJyS011RWVWdUFkbDhzQVoyNGIvMWIwV3VJT1lm?=
 =?utf-8?B?QWkvY0s0cCtiSjJTM2N4eUpPSElxOWtLTmRCVUlHV1REZjR1ZjVleWhzTUc3?=
 =?utf-8?B?QnMyNnVTMmpmUHZyUWJvS21lSUtsMldvRGlveUlEZnZUbXAvSzhoWWErWXZx?=
 =?utf-8?B?WlNHaXN0YjU4NUV0MjJiRGh5UlFHUUJkd250cU5zeWlFNXRwYXFyVDNiUEli?=
 =?utf-8?B?YTlUNWJRd3RwamFQQndRRkZoRURlcVh6dmNCY0xET0RnWjJtKzdIWGEzUzZw?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OTCA0iKDm0Q81sCXOrzvF0CdnD0JIq9yF5WOdgS2/tf1ZZfRhd2VkWCCI/MyqyDc8WzVy/rmjtXa6zu7VljlL1Ej12qt3u0Uf5IESwInqtBwDtYJlEYngmPUBlkUrOXoPkdw6aXIcAVT+xT8Ndgv8fzHJTbd+3Ukbl3o5ck455M+rfwwCH1yyA7jynKPax+F20bmliX/XhSbfpjQffl7dEQsevvUbRjHvlMeN67Z6AzdYUEVvEASdcriptoaaGr/v8tAfbP2m2+PF4QmeFzjKIQ8DGK4DYDTKYpX0MhVXbm9HKrP0rfhP2b2Sdi6G6uUVio/QpCGRTcSbxw6TDqSca7nIV42iPAZcTamfutBHTu2AwFobXhs7SvVoznVZ6nZr/yVs49vA7PGw2DwNkt60DhuIzounwcMruJRNLuAZ2ou3HdJS4VRDSWAeH8UO0feVso8v7EhCfjl4HbyxjWFkMlDZjdziT1ILcYEj9sk9M3zG0NOrjuEfxfSPgPJ8V1qs/H3vO+nvvjgLW+jmot/5BjibkzWMb6Bl5wBvsmohF8F8vyq4BNN36AUaiFGOp8DdMJss8/64oBRPxubOv4Z9IHKnimlzzr7oE+cVkp4MKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4728959f-cd77-406d-c00e-08ddd04fcc03
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 16:32:10.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DLFJxtSwweOBlWB0rSZdaGYrPD/nfksOrgF17N6vk6ARVSKSF0Swn6slOGce6XYluIxWsaE+fTdjrElGZppjJwFJyqWtAAdM/fuRqrpbO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310114
X-Proofpoint-ORIG-GUID: EzOa0nTIuX44vLQLDKDZUX3Cy-iGmuUT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDExNCBTYWx0ZWRfX9FhzzmIZaPoE
 wXAJvoArCQD2NxjoEPFJcaEuZszbmQG8+aX2iLDKPhc75ha9QZrl8sXz25OKOe8G0m6I5kZG56l
 c78OC1wInR6AjI6keCSS3mGq8QUKjBnZpLK4Z3aXxFRAWCnQR1dqbmCQqTqzBEzRdv36NnUJh0T
 hRM+V0etxujGa1aON5xd4+QD6x7TwRMeA/7mVDYw0KCHXit+HkGLdOsWw0/TOt3qacK7CNm/mip
 LBcdVZWsH5BPaGB6vIotgGantfgEmB17eUo8ClEFX8pxHVb2/bU6DCVmPYaCuOX3cHEad6qtCyF
 QzaOr0ejhtFuT5183a2HFCiO/jbyESEPAh6AfjiKn0/DR7maAlBK2bsqrWqGnYpNAnxFE1q/hI3
 B5c7NBo8NCon3uh8qIjMzsU3L/Gi8PIKZ+ed13Ph8Aq1fLPowK7S4Lk5kxpMzcWmOFy8cciw
X-Authority-Analysis: v=2.4 cv=FvIF/3rq c=1 sm=1 tr=0 ts=688b9a8f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=QX4gbG5DAAAA:8 a=yPCof4ZbAAAA:8
 a=KYhZthayFOtCH620LbcA:9 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: EzOa0nTIuX44vLQLDKDZUX3Cy-iGmuUT

On 7/31/25 12:01 PM, Muhammad Usama Anjum wrote:
> Enable -Wunreachable-code flag to catch dead code and fix them.
> 
> 1. Remove the dead code and write a comment instead:
> hmm-tests.c:2033:3: warning: code will never be executed
> [-Wunreachable-code]
>                  perror("Should not reach this\n");
>                  ^~~~~~
> 
> 2. ksft_exit_fail_msg() calls exit(). Remove the dead code.
> split_huge_page_test.c:301:3: warning: code will never be executed
> [-Wunreachable-code]
>                  goto cleanup;
>                  ^~~~~~~~~~~~
> 
> 3. Remove duplicate inline.
> pkey_sighandler_tests.c:44:15: warning: duplicate 'inline' declaration
> specifier [-Wduplicate-decl-specifier]
> static inline __always_inline
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

> ---
>   tools/testing/selftests/mm/Makefile                | 1 +
>   tools/testing/selftests/mm/hmm-tests.c             | 5 ++---
>   tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 +-
>   tools/testing/selftests/mm/split_huge_page_test.c  | 4 +---
>   4 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index d13b3cef2a2b2..23d4bf6215465 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -34,6 +34,7 @@ endif
>   MAKEFLAGS += --no-builtin-rules
>   
>   CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> +CFLAGS += -Wunreachable-code
>   LDLIBS = -lrt -lpthread -lm
>   
>   # Some distributions (such as Ubuntu) configure GCC so that _FORTIFY_SOURCE is
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index 141bf63cbe05e..15aadaf24a667 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -2027,11 +2027,10 @@ TEST_F(hmm, hmm_cow_in_device)
>   	if (pid == -1)
>   		ASSERT_EQ(pid, 0);
>   	if (!pid) {
> -		/* Child process waitd for SIGTERM from the parent. */
> +		/* Child process waits for SIGTERM from the parent. */
>   		while (1) {
>   		}
> -		perror("Should not reach this\n");
> -		exit(0);
> +		/* Should not reach this */
>   	}
>   	/* Parent process writes to COW pages(s) and gets a
>   	 * new copy in system. In case of device private pages,
> diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
> index b5e076a564c95..302fef54049c8 100644
> --- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
> +++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
> @@ -41,7 +41,7 @@ static siginfo_t siginfo = {0};
>    * syscall will attempt to access the PLT in order to call a library function
>    * which is protected by MPK 0 which we don't have access to.
>    */
> -static inline __always_inline
> +static __always_inline
>   long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
>   {
>   	unsigned long ret;
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 05de1fc0005b7..a85b2e393e4e8 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -296,10 +296,8 @@ void split_file_backed_thp(int order)
>   		ksft_exit_fail_msg("Unable to create a tmpfs for testing\n");
>   
>   	status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
> -	if (status >= INPUT_MAX) {
> +	if (status >= INPUT_MAX)
>   		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
> -		goto cleanup;
> -	}
>   
>   	fd = open(testfile, O_CREAT|O_RDWR, 0664);
>   	if (fd == -1) {


