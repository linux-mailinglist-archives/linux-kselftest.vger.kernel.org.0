Return-Path: <linux-kselftest+bounces-34377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E63ACF3A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E12216366B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07347261A;
	Thu,  5 Jun 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="encoLhZJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N7Xivbkq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4A7462;
	Thu,  5 Jun 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139269; cv=fail; b=g0rdsQ4fpA8K7BJlry0O5HQ6hxAro9KJ6e0zc0/kuQFgYDUUDpF8PDycfrXFZ24oFvJxKzDu8pY0OAgXlKS22aKhvoy7NNjKxzTzdQTv3nqTrzX+5a2mXKvqI780ygDiuur2xJDsyxXLwK5D5rRqaJ+4rbaoYW4YfpmyGes2WtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139269; c=relaxed/simple;
	bh=3IfzxlcqUCf9r78zG7voTbFsT/mGQnIRxr0J01sfSDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWTyrb/UYj4n+FtQhnTRovrCktJ8VgjFJqTLd4ouB696tizXRrga7WboobtUXC8Z3hnAt+aUfndUco35oDi3ZTdLo74JO76uZy8Eh2QAc+fpFX6kzYbWiJntSpFJr2NR38NEBBxSpQGBR4cc46ibgldXGeB+EpA0pxqGGUeEFWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=encoLhZJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N7Xivbkq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555FtVh5022435;
	Thu, 5 Jun 2025 16:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jLRBfVdGvTouoIhIx2
	iYZ2MqB7/30jzvnNOhJqpkWVw=; b=encoLhZJGz2B1HMvYnpbyHDLgiB3eWqst8
	U0mYTQwN3WDV1pTpD9Jujj45q06D3rL0vYknkudv1IBDE6ML6OlajtCK7Le2j/b6
	zhCxbZHpyzeHA9OmdlTVxXCMfQ71TLFtBhz29Fm8iAxZybzN+/2KbmTfVLK1UXqy
	WrdmdxyCUdYTDUBjbmd1y4gdu5AmBgofldqSYnmNYfJLokEAF/fsbdV1Vt3m9I2j
	aQLMeaymeuQoQYn4GOzk40tdzN3EGqEuoNHQAT0/hKn8Q6HHgHmr41pk4Kj+1sgl
	/bnTcVZYQoP9qERmWIHH92i5lA+nY5zc4e1pE5CFdC/xFRVCFXhg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gecr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 16:00:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555FROjD030694;
	Thu, 5 Jun 2025 16:00:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7c8kxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 16:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBLwVteeHftYaZNX1Xqc5TG/SW+0iDOJTwAzVubwwEY8zOhYVxCNHRsvdXH3+/qpDwbIz7YxVv6JaWRy31SDLmuX4aLWFiCCB2LJHQ55aiGYTF0xBjgQ3XXY0BFZz+lHFDtpwH1gasUEyzC+nPgZYk5uxwUsq8XYqz9bwOXq95eLZeJy4iZsc3oRVw7JtEhBfq78HuqNanz9pxi6wNVLCZtqkr0OPJMdoJgW64n/O+KFWw6YvKwGSIA9fqubiqqOH01LW3vyjGrasHvR3Sdd5qWChzXsFD9PR0UL9niXGtLkctVaYYMbfK/xtpmIPXdPoq75S9lzZw/8Xao4s7bP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLRBfVdGvTouoIhIx2iYZ2MqB7/30jzvnNOhJqpkWVw=;
 b=mHjq/6Atd1wEWLepoFaOXx5m8tiCtAH2N2q6NBDZkSPaYRrXG5abGLa8qir/Fa3C+RLhgRSfDBGIM1l+F4DOrRQ8jPPma4hE3yMcr7334ifeF2NA4IIqYRYdPc0ImUtEsY+zR7WKTMBOhup+p1lzMz7LFUITiCc9a6pSpLSOHDmL0SFNI/fgJjgGzAEMLpbjMt9k7izE17RR7F+ta6kGdOgaHQg8UCO8lk8G5i/1ur/ii02XW6WAJ3K7bBPtJ+cwTKkojv4B9FqGUaS7fs4D9QwOLipk0t7mAownqgxPxeVsfko7tfykqEe0RghOiVUJ0ctXVdG3nvdymNzTQ6XKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLRBfVdGvTouoIhIx2iYZ2MqB7/30jzvnNOhJqpkWVw=;
 b=N7XivbkqmRC8AdA4/GnkQ0SKYnpM6ZFwT8oG++zruNjnf7CR2rJjPktWj7fE2y/4E6dPTHtMF6dCfic2kyEJ5ebpPzoy4Lqere7Ye+4LuNr9v1q9o8tnwFn6i5apwhrVA0hspKIFQqYVnQ/zdBsUfpoZzipiXl5N3q7/Gpr4f/Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7322.namprd10.prod.outlook.com (2603:10b6:8:e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Thu, 5 Jun
 2025 16:00:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 16:00:52 +0000
Date: Thu, 5 Jun 2025 17:00:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
X-ClientProxiedBy: LO4P123CA0595.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a786455-aef7-4b5c-e356-08dda44a256d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hHHxtpV48JU1rfEaf/ItbQiju9Gbp07+pg8mXAeq2Q7e++xUYa1T93ll/RwO?=
 =?us-ascii?Q?JAwRbzRmVUBYUBDVnSYgRzspDxlsu5WMxC0XdC7Zcja4OkGt8RnD8Ph4sesu?=
 =?us-ascii?Q?QlmVseoh01BdIBhI748V0NWQxXRkIciwqiSsVN5hsoqM2vXmkx3rzRNX/g37?=
 =?us-ascii?Q?Er5a6tk23ti8bZfXIq7rhU4hQuLeXxJON+cgUHHpYHCtcmDy6zAGqIbUBygs?=
 =?us-ascii?Q?dxqoMuRQDwgx9QlukQ/sx6j57sVWkaspGibMaU27Vpkf5oNHudHiULjjA9Yx?=
 =?us-ascii?Q?A86X8o/hDUNBz3cm40C7b4qLh5UW6HNlJ1HMLCT9gGJjC4Z3UlVhk0oewK9n?=
 =?us-ascii?Q?ltNDjwCUxNMY8+KIompqhipnna+H1ssErkChf2qOGZowI9OGRXcVD1BT1ZCu?=
 =?us-ascii?Q?AXlegcdt1Gu8tsn5DPkLYcsp07nrKWzZfSIXbKZyZdwQcByyTFuV59AcLAP+?=
 =?us-ascii?Q?1nqB9wkmVRMJzhrt6EZutdZfXLl1fe/Lm0AMpooB1aQKhlt9SbPqXfVszVzI?=
 =?us-ascii?Q?TEKJ+K5LY8IK6dNkf1dMYnEBs+k61hmnrKm633njyFZkLDTNnuO+gRT9H95z?=
 =?us-ascii?Q?Z0wTSFBH0XdxGQV7qnC5P8DAi5DiAl/M8Q3G3fNYDuv83+KknMO0TA1KaCPq?=
 =?us-ascii?Q?iVZArmoXX87UYpzot6TSveCrf+oQEpHjhGlJokiyEt7U6BSJJs6VudN6FrWK?=
 =?us-ascii?Q?2t4R2KY03TCZTGA8gbCbcRpXa3uDXe98kf4pB2a3JhrKyzWAJzsHEVAfIMqK?=
 =?us-ascii?Q?mrIFInzbbo+zLRwrNDH4E4qZik3s/SFn+cWAD+G9UaQo+ST0dNWdt9Rplf6s?=
 =?us-ascii?Q?iwBVfjbxuhRy7d65KEkZwVAbro8Wb2LOMjUEDKnRW4fqFpgf3q/i5wgs+Xoz?=
 =?us-ascii?Q?oXPUHLOOURXeONTnhyDVeYm3XVDA79JFSR4nroO98r9lxGjZowlKQO2sybwh?=
 =?us-ascii?Q?crleH8W9A3WkgQaMRewiJWtaIQaU3vuOgHF+c8K7irGC34MdpIm72ms0W+xW?=
 =?us-ascii?Q?bm/wNQGT0KQTUNX6rcAzH2/n9yZmTHQU/c5Q2yQK5uE19d1ZugAYEviHnFpl?=
 =?us-ascii?Q?qvz9ZDUO5A6kVHenjHu60+2tgGakvdE8kym5sV+Q/d/RGOOTMnj+Dn0Te8nK?=
 =?us-ascii?Q?HdCbPn8qs4qqQSOsbHk9p8nm9FSEhgczwq4281cSglSvdpqil2lZbsK7C666?=
 =?us-ascii?Q?8+ycI1OIL66Sak7Dcxaj5BD3pL3jSRaV2LPvE0DyxfQNLL1jTG7facTN9Wgx?=
 =?us-ascii?Q?PXui32ES7OF2wAsJAaKE8tWHjH7mjG6EnFHgG5SN+S1RX0X+S4eXEEQLTxNe?=
 =?us-ascii?Q?ScVfy0Pm+x9Ucb59mgD9N86rqYcLLd4RYcHN/hHFR8CdgxJ6ua51K8JcaiSi?=
 =?us-ascii?Q?uLIH/H225k4Mi/7IEeuKFjaatM6sY7aNGVZhjZB5XoCeESlnYoBEeyMhFEn7?=
 =?us-ascii?Q?F+XS6eMK4GY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8PxLyO9M0RDhtGEA/pc7UDBgOLqnnYEAQ0TT5uWYTHHt4PDbV/e/vJrnuUSJ?=
 =?us-ascii?Q?ULlVrzkhPicM3/R+iMRWETLD/JlHsRtLrwuRkkrJFaJD14drmddgsITMU0yd?=
 =?us-ascii?Q?9K1Wd9ns6mBJVXiYXVtuLy+MXmZAocKFfMLY9gsWCqsghe5CMaiFglQ5eowW?=
 =?us-ascii?Q?iUcsK2howM9EHsd63HIYachgGiH5iQNtT8ux7V1+CMBjCyWQHZ1xWueJ3Y8a?=
 =?us-ascii?Q?ZIM8Hb8wsle4fiYwgmqLM3oioObiLeAMW/2VVMpPczVM+shdgTq+bwpn/x+P?=
 =?us-ascii?Q?g7cAQSJaP0PxgiP/FINycUpEyYqw1ddOMnGdxVI4IOXeisX4EdktOzU1IY2x?=
 =?us-ascii?Q?pU5Lq6/ejm2f8SHBFdyy1t5qD5BBvqGSBsOJ8ITv4ezRf/ZAxVQMrVgvKF6Q?=
 =?us-ascii?Q?0+nC2HgAkxmJG49B8N8h5s34mibVQjIho3gICE8y5Kil8Uv8e8Sb3a5fxeDZ?=
 =?us-ascii?Q?pYmYBplcIOFHh0e3lm0tODCmOn2hZMRJx+xJlXIlCUUd9aKIILLNiUdZaZzD?=
 =?us-ascii?Q?kLMHJsakGf5QBpgRVQKw3rIK7Mi7Gc8w0pTYgyu6cFRzwArUwUbKOlo9bWVC?=
 =?us-ascii?Q?jYHusGN6ZnxYTrYaia5ZEewqZa2Ti6R9cl7zXKZi5cKmcN3PfQi7y7P46g91?=
 =?us-ascii?Q?lKH13bmuUW4HpEZ8zLm3gGJFD9r4rzPhbNZHJL/KWmHmo/TZmRqYFHCN+heF?=
 =?us-ascii?Q?RDkp1/uy1MyeEHb72RKfSVdzNEaaRg61tLGftOAEMg2zWP6KN7JHGrErcGkg?=
 =?us-ascii?Q?uNsD/JibGi+TxNBkYpjp08mRBLjrn8KFpBO9HBYQQZFetX33yKjvgwyO+gC/?=
 =?us-ascii?Q?KrsotXGb4+I57dfy/kgmdF/GtlQReoTmmc/JcAMHKPqxCOeNdmlmVDv4Vpi9?=
 =?us-ascii?Q?TapQtlJRMCecBWf9dEQZQfWFetAOKrLEX5BW2cDsLqX6Yr/Gn6/X8JKjfQxp?=
 =?us-ascii?Q?+fCymfX7dLZsBP59UFJkCk/gHNqKFf99hP1JRTGM4t9R2TpiOXxdiFI/SesN?=
 =?us-ascii?Q?aCqRBuCHyM0XTTignxED94o8lFmt6tRLSklkZyJVJhYSNldXIwzrvrjQuVa3?=
 =?us-ascii?Q?/AIF7I9ISlZv8/AmSf0jqxOi5pakj06eHIi5IyWmJktpC0qd3uFgxeN5a+zA?=
 =?us-ascii?Q?wm+JHnyOs4Cmn9sSvqRMrAvNzxCOeqKR/bW5Tz5nDu8xGh2cvqUH7v2Q6EhZ?=
 =?us-ascii?Q?mILkpPZDnH8F9ItONy/X1DjHj2r/3fallgsIy3DBhkag5KnhKWr0BBJI9/Sc?=
 =?us-ascii?Q?WI+vgmPAKyfBFLYwU5ttPMrypY23zJs7v6v/GPr/CgaMfjAuVy7hVns5iEWc?=
 =?us-ascii?Q?4pPSj08Z9YDcUDNndHdN4krWBQI4LyyaZUqpLiurF2UXfzYzgiyAbVu4ZxYF?=
 =?us-ascii?Q?+oAQqnoGoRn3uDn/a+2BARgVPBmkenzRiqwswY2nJG4FCVmIan1w9IwfoSFS?=
 =?us-ascii?Q?ZtgrNQjgux0ZIsPu2TDMceHTqmiLbdiHR0JsZXmdDOZqDmzeHi7g96TFY0gP?=
 =?us-ascii?Q?+xuNiFN2bL1z62/Gp1W5zCFd9IgyHMEUFQP1R0diwCM95kDLGCUK5/RAZCa5?=
 =?us-ascii?Q?DC4YNRP2DBQDLEgWTvjoOJUPLgGHrggeGV5ltmPpHuRrrwAaOknowhfXrY/4?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C2ixPs6aZVpDdcHg5C6ETbVmV8U6oGULGALMLszMpmAS+bbTv2CigGNzS4L1/AmeHa2nFuapzUwmwropVRotD0RqQ2n9dlxPhbKr8VdP83CWjvlnAnddkxCNLxwMhPO5uea33q9Eq60DAwEd3/yxo6sN0bggalyfW3VtbddQI3Ly0/sNiRiElMFAH0zjeNvoVPfcEf/x7AseRveP1GKDT73PzOrS7IqVOf9jmgMzuS6SoCvl7Nej+ghH+Dkpf01TguAEDDS3wOI3pqiWaGLmcy71JfK7rYUUX0OCqkFAT+WoolveX/SLbXiYkpVS5586X4yg2s0xswTNYfcbl9ISgaMjJd7GTqi9WXYFq41lBTWogJ68kbw1NZ7ViAPgU3SJftqJXFt4Fp1o23jeV5E4TN7CkFeIX81BmrjHPmvMdfB2UmYcF09k1LX8NIFheooKmarkEGTV68VN3PWgoPC/pi/lU6dh+LCmyl4OP2x7dNcbcLYwI9rKwkbCz5JtmBHGmyiWQ5Mb+2F4iGx7fewQc84SxabRdoeceBt3OJVmCSkvyZjtlNPIf4Wu81NbgMU4y8Heaiehir0ZbfHv4RqVV5V7ATtb+JmhwYsnRZMOvPU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a786455-aef7-4b5c-e356-08dda44a256d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 16:00:52.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv2WzpDHybMI+JXWF96KlJ+0Id4eEWic5uYVxETdQQbzJR01FRgv1aBam00nFsndpi4yCXPVPN/RGQn7Jd7OWGAylxEvwRz6yXz4dN9Focw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506050140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0MCBTYWx0ZWRfX1zC+d7BH+YOX 6GefiU7b88G6NENODBz2PIQdVnkQo72Wq7nPY7cOmuQSDNrYc+nj4XpX7DMKoUBKO6jqmlM/1AK bzhIKZRwuQwIQ2qYASw+p76aOZnRvgseq7rx/pPLB+RVL5KXIR9hS10l96FIa6h6h9Z5YKTlq3w
 KWO/OqevTV4A89CIi6Wvjye9c80GnkLOwXLAcupi68ak6glNIQsaeLVIUIq4pNKMwkgfCe/s6+Y iO/5NeEKvRhfF6t61IISBqxDOaUhf9APPf9quT4g7AI4r4lXn2EhqTduUbErFqSeleTOEP6B6Rr 2ipYDZaWe0YjSQ2zv5GHf8TcrZBdeSZVvvRd8I7u6fZxjg2DI8BKSf0dTKYmBmmZ/kjd2dK+T+u
 gTorNxdQocZ4m5VeXIc8y+vN0msMWResIxr/CyVyfND5KIbPy8jFNH/WUz8BS+w+o1DEXhfU
X-Proofpoint-GUID: 2T_oQHBoLKcA8zAE5xTG9xqGYfo7PnIF
X-Proofpoint-ORIG-GUID: 2T_oQHBoLKcA8zAE5xTG9xqGYfo7PnIF
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=6841bf38 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=M3thGXLoIc5jhnJeB1EA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714

This seems to be causing tests to fail rather than be skipped if hugetlb
isn't configured. I bisected the problem to this patch so it's definitely
changed how things are handled (though of course it might just be
_revealing_ some previously existing bug in this test...).

Using a couple of tests as an example:

Before this patch:

# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
ok 39 # SKIP memfd_create() failed (Cannot allocate memory)
# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
ok 40 # SKIP memfd_create() failed (Cannot allocate memory)

After:

# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
# memfd_create() failed (Cannot allocate memory)
not ok 39 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
# [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
# memfd_create() failed (Cannot allocate memory)
not ok 40 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)

See below, I think I've found where it happens...

On Tue, May 27, 2025 at 05:04:48PM +0100, Mark Brown wrote:
> The kselftest framework uses the string logged when a test result is
> reported as the unique identifier for a test, using it to track test
> results between runs. The gup_longterm test fails to follow this
> pattern, it runs a single test function repeatedly with various
> parameters but each result report is a string logging an error message
> which is fixed between runs.
>
> Since the code already logs each test uniquely before it starts refactor
> to also print this to a buffer, then use that name as the test result.
> This isn't especially pretty but is relatively straightforward and is a
> great help to tooling.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/mm/gup_longterm.c | 150 +++++++++++++++++++-----------
>  1 file changed, 94 insertions(+), 56 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index e60e62809186..f84ea97c2543 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -93,33 +93,48 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  	__fsword_t fs_type = get_fs_type(fd);
>  	bool should_work;
>  	char *mem;
> +	int result = KSFT_PASS;
>  	int ret;
>
> +	if (fd < 0) {
> +		result = KSFT_FAIL;
> +		goto report;
> +	}
> +
>  	if (ftruncate(fd, size)) {
>  		if (errno == ENOENT) {
>  			skip_test_dodgy_fs("ftruncate()");
>  		} else {
> -			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
> +			ksft_print_msg("ftruncate() failed (%s)\n",
> +				       strerror(errno));
> +			result = KSFT_FAIL;
> +			goto report;
>  		}
>  		return;
>  	}
>
>  	if (fallocate(fd, 0, 0, size)) {
> -		if (size == pagesize)
> -			ksft_test_result_fail("fallocate() failed (%s)\n", strerror(errno));
> -		else
> -			ksft_test_result_skip("need more free huge pages\n");
> -		return;
> +		if (size == pagesize) {
> +			ksft_print_msg("fallocate() failed (%s)\n", strerror(errno));
> +			result = KSFT_FAIL;
> +		} else {
> +			ksft_print_msg("need more free huge pages\n");
> +			result = KSFT_SKIP;
> +		}
> +		goto report;
>  	}
>
>  	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
>  		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
>  	if (mem == MAP_FAILED) {
> -		if (size == pagesize || shared)
> -			ksft_test_result_fail("mmap() failed (%s)\n", strerror(errno));
> -		else
> -			ksft_test_result_skip("need more free huge pages\n");
> -		return;
> +		if (size == pagesize || shared) {
> +			ksft_print_msg("mmap() failed (%s)\n", strerror(errno));
> +			result = KSFT_FAIL;
> +		} else {
> +			ksft_print_msg("need more free huge pages\n");
> +			result = KSFT_SKIP;
> +		}
> +		goto report;
>  	}
>
>  	/* Fault in the page such that GUP-fast can pin it directly. */
> @@ -134,7 +149,8 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  		 */
>  		ret = mprotect(mem, size, PROT_READ);
>  		if (ret) {
> -			ksft_test_result_fail("mprotect() failed (%s)\n", strerror(errno));
> +			ksft_print_msg("mprotect() failed (%s)\n", strerror(errno));
> +			result = KSFT_FAIL;
>  			goto munmap;
>  		}
>  		/* FALLTHROUGH */
> @@ -147,12 +163,14 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  				type == TEST_TYPE_RW_FAST;
>
>  		if (gup_fd < 0) {
> -			ksft_test_result_skip("gup_test not available\n");
> +			ksft_print_msg("gup_test not available\n");
> +			result = KSFT_SKIP;
>  			break;
>  		}
>
>  		if (rw && shared && fs_is_unknown(fs_type)) {
> -			ksft_test_result_skip("Unknown filesystem\n");
> +			ksft_print_msg("Unknown filesystem\n");
> +			result = KSFT_SKIP;
>  			return;
>  		}
>  		/*
> @@ -169,14 +187,19 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  		args.flags |= rw ? PIN_LONGTERM_TEST_FLAG_USE_WRITE : 0;
>  		ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
>  		if (ret && errno == EINVAL) {
> -			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed (EINVAL)n");
> +			ksft_print_msg("PIN_LONGTERM_TEST_START failed (EINVAL)n");
> +			result = KSFT_SKIP;
>  			break;
>  		} else if (ret && errno == EFAULT) {
> -			ksft_test_result(!should_work, "Should have failed\n");
> +			if (should_work)
> +				result = KSFT_FAIL;
> +			else
> +				result = KSFT_PASS;
>  			break;
>  		} else if (ret) {
> -			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed (%s)\n",
> -					      strerror(errno));
> +			ksft_print_msg("PIN_LONGTERM_TEST_START failed (%s)\n",
> +				       strerror(errno));
> +			result = KSFT_FAIL;
>  			break;
>  		}
>
> @@ -189,7 +212,10 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  		 * some previously unsupported filesystems, we might want to
>  		 * perform some additional tests for possible data corruptions.
>  		 */
> -		ksft_test_result(should_work, "Should have worked\n");
> +		if (should_work)
> +			result = KSFT_PASS;
> +		else
> +			result = KSFT_FAIL;
>  		break;
>  	}
>  #ifdef LOCAL_CONFIG_HAVE_LIBURING
> @@ -199,8 +225,9 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>
>  		/* io_uring always pins pages writable. */
>  		if (shared && fs_is_unknown(fs_type)) {
> -			ksft_test_result_skip("Unknown filesystem\n");
> -			return;
> +			ksft_print_msg("Unknown filesystem\n");
> +			result = KSFT_SKIP;
> +			goto report;
>  		}
>  		should_work = !shared ||
>  			      fs_supports_writable_longterm_pinning(fs_type);
> @@ -208,8 +235,9 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  		/* Skip on errors, as we might just lack kernel support. */
>  		ret = io_uring_queue_init(1, &ring, 0);
>  		if (ret < 0) {
> -			ksft_test_result_skip("io_uring_queue_init() failed (%s)\n",
> -					      strerror(-ret));
> +			ksft_print_msg("io_uring_queue_init() failed (%s)\n",
> +				       strerror(-ret));
> +			result = KSFT_SKIP;
>  			break;
>  		}
>  		/*
> @@ -222,17 +250,28 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  		/* Only new kernels return EFAULT. */
>  		if (ret && (errno == ENOSPC || errno == EOPNOTSUPP ||
>  			    errno == EFAULT)) {
> -			ksft_test_result(!should_work, "Should have failed (%s)\n",
> -					 strerror(errno));
> +			if (should_work) {
> +				ksft_print_msg("Should have failed (%s)\n",
> +					       strerror(errno));
> +				result = KSFT_FAIL;
> +			} else {
> +				result = KSFT_PASS;
> +			}
>  		} else if (ret) {
>  			/*
>  			 * We might just lack support or have insufficient
>  			 * MEMLOCK limits.
>  			 */
> -			ksft_test_result_skip("io_uring_register_buffers() failed (%s)\n",
> -					      strerror(-ret));
> +			ksft_print_msg("io_uring_register_buffers() failed (%s)\n",
> +				       strerror(-ret));
> +			result = KSFT_SKIP;
>  		} else {
> -			ksft_test_result(should_work, "Should have worked\n");
> +			if (should_work) {
> +				result = KSFT_PASS;
> +			} else {
> +				ksft_print_msg("Should have worked\n");
> +				result = KSFT_FAIL;
> +			}
>  			io_uring_unregister_buffers(&ring);
>  		}
>
> @@ -246,6 +285,8 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>
>  munmap:
>  	munmap(mem, size);
> +report:
> +	log_test_result(result);
>  }
>
>  typedef void (*test_fn)(int fd, size_t size);
> @@ -254,13 +295,11 @@ static void run_with_memfd(test_fn fn, const char *desc)
>  {
>  	int fd;
>
> -	ksft_print_msg("[RUN] %s ... with memfd\n", desc);
> +	log_test_start("%s ... with memfd", desc);
>
>  	fd = memfd_create("test", 0);
> -	if (fd < 0) {
> -		ksft_test_result_fail("memfd_create() failed (%s)\n", strerror(errno));
> -		return;
> -	}
> +	if (fd < 0)
> +		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
>
>  	fn(fd, pagesize);
>  	close(fd);
> @@ -271,23 +310,23 @@ static void run_with_tmpfile(test_fn fn, const char *desc)
>  	FILE *file;
>  	int fd;
>
> -	ksft_print_msg("[RUN] %s ... with tmpfile\n", desc);
> +	log_test_start("%s ... with tmpfile", desc);
>
>  	file = tmpfile();
>  	if (!file) {
> -		ksft_test_result_fail("tmpfile() failed (%s)\n", strerror(errno));
> -		return;
> -	}
> -
> -	fd = fileno(file);
> -	if (fd < 0) {
> -		ksft_test_result_fail("fileno() failed (%s)\n", strerror(errno));
> -		goto close;
> +		ksft_print_msg("tmpfile() failed (%s)\n", strerror(errno));
> +		fd = -1;
> +	} else {
> +		fd = fileno(file);
> +		if (fd < 0) {
> +			ksft_print_msg("fileno() failed (%s)\n", strerror(errno));
> +		}
>  	}
>
>  	fn(fd, pagesize);
> -close:
> -	fclose(file);
> +
> +	if (file)
> +		fclose(file);
>  }
>
>  static void run_with_local_tmpfile(test_fn fn, const char *desc)
> @@ -295,22 +334,22 @@ static void run_with_local_tmpfile(test_fn fn, const char *desc)
>  	char filename[] = __FILE__"_tmpfile_XXXXXX";
>  	int fd;
>
> -	ksft_print_msg("[RUN] %s ... with local tmpfile\n", desc);
> +	log_test_start("%s ... with local tmpfile", desc);
>
>  	fd = mkstemp(filename);
> -	if (fd < 0) {
> -		ksft_test_result_fail("mkstemp() failed (%s)\n", strerror(errno));
> -		return;
> -	}
> +	if (fd < 0)
> +		ksft_print_msg("mkstemp() failed (%s)\n", strerror(errno));
>
>  	if (unlink(filename)) {
> -		ksft_test_result_fail("unlink() failed (%s)\n", strerror(errno));
> -		goto close;
> +		ksft_print_msg("unlink() failed (%s)\n", strerror(errno));
> +		close(fd);
> +		fd = -1;
>  	}
>
>  	fn(fd, pagesize);
> -close:
> -	close(fd);
> +
> +	if (fd >= 0)
> +		close(fd);
>  }
>
>  static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
> @@ -319,15 +358,14 @@ static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
>  	int flags = MFD_HUGETLB;
>  	int fd;
>
> -	ksft_print_msg("[RUN] %s ... with memfd hugetlb (%zu kB)\n", desc,
> +	log_test_start("%s ... with memfd hugetlb (%zu kB)", desc,
>  		       hugetlbsize / 1024);
>
>  	flags |= __builtin_ctzll(hugetlbsize) << MFD_HUGE_SHIFT;
>
>  	fd = memfd_create("test", flags);
>  	if (fd < 0) {
> -		ksft_test_result_skip("memfd_create() failed (%s)\n", strerror(errno));
> -		return;
> +		ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));

I think it's this change that does it (probably).

I wonder if it's worth checking for errno == ENOMEM and skipping in this
case? Or is that too general?

>  	}
>
>  	fn(fd, hugetlbsize);
>
> --
> 2.39.5
>

