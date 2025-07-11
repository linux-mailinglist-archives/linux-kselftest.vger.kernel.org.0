Return-Path: <linux-kselftest+bounces-37081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFFB01A9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2B9762101
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 11:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0F283141;
	Fri, 11 Jul 2025 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EoUAnjOH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wkpvrCfh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F21146585;
	Fri, 11 Jul 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233669; cv=fail; b=RPhHUfOSyXmnwZH8VavllMfPPRHahz7OAmOYtJVZ/sNyd6PhG+4OA8h6JGQCNQhHQnsYxou4Rw9br9/8k/yIIcy05WQc94IIoI0nscmgq+QlU2a8JYEIvX6XYFBH94M0ta0qGjs3Ngb+sPX5DO1Aw8F0MSPvSKBTENPfURKNHwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233669; c=relaxed/simple;
	bh=bqVw1MR7bff/PKLi5+PM/K3UZTKU/H3iOhqHokiO/ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eFNGh2ozqWsqf1HPqfRPYZVTw5tnvN1ch8aeBa3R4jX7s7ibuCCE/uRHteU1vP7ueGl3ipcHW3ivMn6E5xDOC9VX/Zw+n+8dPQxDalOC+7hU4kWpHalf519hZmC51bwdBkASu9uFO3GCuyfuIsPWNWwEHZYGFEuWoRM709qcwxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EoUAnjOH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wkpvrCfh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAvEAn005892;
	Fri, 11 Jul 2025 11:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bqVw1MR7bff/PKLi5+
	PM/K3UZTKU/H3iOhqHokiO/ho=; b=EoUAnjOHlNcE7Vs/9xRqu9o7SrZ00Ab1/E
	tlYO6Z5NroVbpXqw/i4QMjY1yazTA3+Rk7qPjpk0wtx+ZHKKMSbFzOf+mEBJb1rb
	sr7A6Za5Q5URjo2NV+SmBwsP2KVS0LDB3nmOfloJJKUuohAs8gEeVH2GUd+uMJIj
	7QZrfKDWnuDgMxXDAms8ZWpNXj8p19D3SVCxDSite0Ujyl1AJn9qblNRt32ZCOSf
	iM7Kw0R4oSKRnjBkRnMzAQuwZm3ykK+KAa06Qrezvg84A1l+VzUIKs2DlEeirTzv
	QlBbT7K1Zabj9EysyMuhsybURH8sdrGHwKG//ANPYQ9NqTr/ZUNw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1abg1j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:34:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAKabS023658;
	Fri, 11 Jul 2025 11:34:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdpj70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4oGZwJ7oJJOkkQxb7xEzTyGrW1ZuA39BHMkam63uC9AOuOC0MdecYTMoAdCVqVY3XusHBFdeaMwYmkV/NFK3A6KnZPgFZrX3LTVok3raln8Fb4tuvBfchAGsyFc5cbJWsSc78uehaNc1t2g0uDx4ZCWSk9RUgEnY9a0la4ohC/oSNDFvim1T2zggig3bgof1HTNOoI7I8DUWNhYIXpwzVm5GmGucmMcvlm61Bm75ChVNuJDKTbCCIYimph+nuPxs8MgcGEOhIFxOctU9TcLT5SorhBVONGLBVl+MD7CGoP3++Vbkd3YeYRMrTrPe/kQPWRRk4J1teRsSz2pEP+0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqVw1MR7bff/PKLi5+PM/K3UZTKU/H3iOhqHokiO/ho=;
 b=wlnKHPbDKbgj/6Oxt/pmn9H8XPfO7skVDFtq1B1j5CYU+RE/d86iN4XdDL5tNt6WPG6wTfnauUM/G2IRfmCT5jLjxuRfoq+VwXB8felPDZDN+gIvhAzuvF6JGHBbscegAZl6Cie4oZK13W4OjxjdGSX0Ssk36dhoS7NeD0i0q4HPJNd81dTxblrGu8i73MKYD681UCZvTMm5Pt1y/l8aJwyChHzC2yP2c5VFO9upCafPxTw/fdAAasQ+2BvSV3C4JB2pXXRaPiDBK5rRviDQa2kKxOyL0ct6lN8LbIDe+D9nUlB6felSbJGCgHOkS2HW+/zgr3+V93uObjribHp0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqVw1MR7bff/PKLi5+PM/K3UZTKU/H3iOhqHokiO/ho=;
 b=wkpvrCfhVbJy/s1BGIMxam9ze3k4TOJ1eCy/wVFbmjoDhYLEn0mEp7QTgzE5b3WHBsfaxPp07js3osKWoVJJhmQaP1c7ZydWQ3VEMvzStZ4+/tRRSPrl5X9JpyQPrVYuUEXs3n4xE18v3Ip2+b9srEmEJPDdQ1QHtzH7eqIWjSg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB5174.namprd10.prod.outlook.com (2603:10b6:408:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:33:57 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:33:57 +0000
Date: Fri, 11 Jul 2025 12:33:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
        broonie@kernel.org, david@redhat.com, gkwang@linx-info.com,
        jannh@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        p1ucky0923@gmail.com, ryncsn@gmail.com, shuah@kernel.org,
        sj@kernel.org, vbabka@suse.cz, zijing.zhang@proton.me, ziy@nvidia.com
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Message-ID: <a6c8e519-69a5-4de8-a857-64459581233f@lucifer.local>
References: <81f9a104-6d7d-4552-851e-8690d4a1b723@lucifer.local>
 <20250711111600.3989-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711111600.3989-1-lianux.mm@gmail.com>
X-ClientProxiedBy: LO4P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3b9303-a279-466b-baf2-08ddc06ed31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lRYTwXx/pdtxiDd60DWhn+bn087fMlatdzfcS2V4GfvgKYNtAujjXIXYRIT8?=
 =?us-ascii?Q?H8rHHmMxtgEJcbTx6gnIq9AgA3zkN/DKjddmhD43AWTK73T50KmOjQNHQQ92?=
 =?us-ascii?Q?QcFvYNiY6h6a/g8egyEC/Wi0ZFZWIwU4Ccj6/4iggd4FKmXO9CYqMHTM1NZu?=
 =?us-ascii?Q?SB0S1Yy+/zqlzTWLeP0GvS1kSG3hFvTZONiGrwAdZhD+8tpCAzkUIHe7/YeV?=
 =?us-ascii?Q?XZlqddPGVNKP2ysIvTGo+ftbaKL0tOciGx/ciqYGAsTCvQ1IfE0xBNTN3ok5?=
 =?us-ascii?Q?ppX6kWMyIYjGGy0zCCD27uFRd/MaamMeHUIpoYX7gxj+PuwvTvm0xZfJ4q92?=
 =?us-ascii?Q?yzt459T92r61g1vhWNH7zxVljhkQhqtro4oS0KQp0V0xxMttV8PzuzfvJ206?=
 =?us-ascii?Q?qEwKeP3NJomOMbMaUCVWyRN/JmDtD+uVi5xq0Xc1Jpt4fS+gGE5FQUdG1lbs?=
 =?us-ascii?Q?Erhcsc54LknbLh/g3SL7w37aOEMd28RJ+mhXR+pgrP+eXm4STjHHvFwDDQq9?=
 =?us-ascii?Q?Rs8Rh8/lBDHYRUgbDmGUP8/M5quVgaLTI9CJkf2Hu2xZE7y8uus8VVxAS1Mf?=
 =?us-ascii?Q?OTCuJ444zTGoCT9SrozExf35+I/BCYFr7ayfRnVaB8UYciYo4uX01aU74k4e?=
 =?us-ascii?Q?MfcGomyyP6NNtRlbjgGRzOSBr8isunLree41/5A5HtkjkdPTvOglM2vgy5UA?=
 =?us-ascii?Q?2rWgh7Skp/rpOE+PypVR3RnipQrNIinhhYKEOzbLMOVsfwmm6ekj6FAUK9gI?=
 =?us-ascii?Q?vR9WBwaGbAPreeBpfqacZrR3SqOuBqtTDhog8TyG6OUJf8cmWTY53fuJJKbL?=
 =?us-ascii?Q?r6aguvGmG7tif3hGy6/hz9+vaVjbcgGcgW+mMjijeorhKpL1Q22Jbbg/35iI?=
 =?us-ascii?Q?2Vey0ku8bo5A2ofayirPzVYZhdPDqMU37izTuA8wh1NE8LSUStx9/9GmWJNP?=
 =?us-ascii?Q?ayBBTxUDr/OBEsXy7eb4gUTPrHli9SLWXtAtuThK6ZU7zrUZ/3Bz6ZDCNjgK?=
 =?us-ascii?Q?FP8ElMds1KKMtJWds2gfhRE7URT3z63VNIZUZg6sMK9yuNmxq1K7eEQn79ph?=
 =?us-ascii?Q?KjUwXtWyYzMZ2+O1zMweMm5LXCK/nvpj5+cZUMlap/FcwfpcWXrMlFTUgY8O?=
 =?us-ascii?Q?5u1dshUJD5sQQIiuiTdUgsTyDlqWQVGRvHgPXIBGtokoePXwUlcsGaRTByri?=
 =?us-ascii?Q?rI9G4axkvhMtpScO+iRyftKWiYjaR0skha7GamfDNyiEaxbOlG3uKzuXCzpb?=
 =?us-ascii?Q?L/m/GiAMRZeP5OKQyWgcOHOncPfKHRuRWEtT2sxdqe+7gDc//ePvrixrcsc+?=
 =?us-ascii?Q?LjzL/DfY+VXV+PRkY9NVNMvLh2wUfg74ggThy2gAFx9q2PaVuly0zDjn3RWw?=
 =?us-ascii?Q?cX0UNlum29TPPI8FXYAyqaJYee3u7fu/olVBzwP1CVATmTGIH47PJSz87ALL?=
 =?us-ascii?Q?s5izh6AFUzE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TB+WUc9cBL6Fd2jwNTBZvUYUUx0LUOhcGY7Ag/jL7+YX+PjZfDqcJdYFM2Rn?=
 =?us-ascii?Q?DRZYEc+M+Dd3mlRCBHdx6EjeBfu/OlgymRDdQbDmC86/nMF8Bx/rP/hXUj59?=
 =?us-ascii?Q?KQ2rBPrM7FZEyQpyAdaxqL69Gg4zmwCzcEbe1egsLtrLFHa94kCC6pmz1wJ3?=
 =?us-ascii?Q?UdrcphJUuURxUOVOBoerip7xkuDvB8zvuWLR1MjJr8Y+vGG4+d5t3Vh9Ddpa?=
 =?us-ascii?Q?dr3S73Q+8HJOhSG1g8O8y7BpwiD8lGx3P3tUJ8MmWBexhDaagy/xTh/LVzHl?=
 =?us-ascii?Q?YWYGQL2TRFd6nbPwGJTDNu+KjYVr3m0A/KcuqRPMMXUnLVGH9ZZLqUqikCK3?=
 =?us-ascii?Q?iRwJ0x9v3I2oukJYkaSsUulSbpPDBYxpmcvWZ2ZYNcJj0xytsYvohlhxVnzy?=
 =?us-ascii?Q?SNZYYbmGUqTVOWkFKhIhXXpTCDuI5PRjRZfEDLat/q38Nqbsw+N9o2MV2xFJ?=
 =?us-ascii?Q?3xVnU33IokbgC2ogJ4iA7iNDPCeD0ZY8uDGnS3Z0sMQQUW6Nyj73bLNSwZXp?=
 =?us-ascii?Q?WkRZ7xth4s7Dz5ELdaTaSS866TZemVd7ChuRTfsqBiyU6jHJCtuzHMnE7Zz+?=
 =?us-ascii?Q?p4q8iNPmiEHFvhpuM65X+x+Duuw70cVnR27zkRoeAtAladGEdsi3EOvyhpI3?=
 =?us-ascii?Q?V5YXkAWXqDmd/ZCKVqnLB2dQ67SSxbz+vitPEs/URuYiBYKJ1gYI5uEXvE4f?=
 =?us-ascii?Q?qM/oy4gtlrDBfLIe9+kpT52b61a2vQJANmWF6AL1zMRWizYdKyNJW53fzAnL?=
 =?us-ascii?Q?1hRVfCN97dbItelLrLE7LbsDKfVShUq6DE2HmlZwJo3n/M8aSPCwIooupTyT?=
 =?us-ascii?Q?CMoQRdt81mAfV00R9MdQj2RJZCYDsi2Nm2oxcw78uPjp9Q+kKkLEx6gcCwC9?=
 =?us-ascii?Q?pOLiGzZqb3W241bVSMd0RBqG93jaO4uPA8zw489YcHo7lr69eQ1EIqwJHhB7?=
 =?us-ascii?Q?9P855MJ84DJRQkKNE1uvMuY3GtOPfhD1kvZOAHQExPRxvg37Ckzf39ykoinO?=
 =?us-ascii?Q?nb1H7ZgxLebw5uw489Os48dldMZfwlS2ZEz81tqWbV3AgRZpoFrfedlufc9T?=
 =?us-ascii?Q?o/0b9CKa+xeDGoEKjqpMdG+jGMHVC+Kr9miHSE8erAb6j4D4bCc+Zb2neeKf?=
 =?us-ascii?Q?+u8K2jzgfMOUtkox9FtfJOGMohzoyow827A/daTuyj7mBYIpSalE7rjcW9Ik?=
 =?us-ascii?Q?Ri4+yNvFPQqaxzwaLGNBKwKXQ7g7AowDbEdkr3/YGDuKVniPZxJMlCk8jrm4?=
 =?us-ascii?Q?FCR1Z1mzreKlA2nzP8sdnrKxSbNK7ABKzd5uBQCYXeO195+rDmMQ8WBn20sK?=
 =?us-ascii?Q?xo7eHdzkIKzCEGgVi6926ACgV+t8mXxPXuaKSG7LgUy0wWo/ayhbHFYldG+S?=
 =?us-ascii?Q?zdhykf7R+YtP/NmN2yeWv4VuUNQKmrq/VlfX5YFQ28qX8VSLmnrfvJKoxSPG?=
 =?us-ascii?Q?82iEqdJOCHXLtFaFfQ6iE8cc7euT59QyylgvAmPeBcwVm8VQNXmBBr4YDOyb?=
 =?us-ascii?Q?bRSUTV7u+F9vi1jTzC6qFO8ZlQBWpDJk3ClfkeQy5G/JlkvkIt1JpkXOofoQ?=
 =?us-ascii?Q?F8cyNwnjXlywda6OdXBocZ1VMfaVrW2P0AGoQQKGxVObqTPsUcxvHPb8WnYf?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sE53sRkqt8hUz8qYWwqXraD5Lf4RaSMRmx1zodNwK90KQud2wPiCk+fBoEG96X4A1s0MytcK1RmRwvqwn82+T9t42kofRUdz5G2+dgrxLYv8ju4SzRCiac3ltat7XtUyx4QSHD5Q0ml/kQY8gTRGZ1KiDyED5ioaWdj9+oAC6kZqX0UDBFwyg5v6/a+oPT6VqwmAWQCQaG3X1G6nncssQjYMQw4SOuuN+pAHi790VJf53tiAsPZ2kFsyJCGXeLukzUgNlQXjuZ9ctyjamzXLqVjM6OwmmwArVslKvgf/dsX5FrBzvyiqzPwpuTnDai7JA+GYEY3o04ipJZVBUBsKI9Lr7ByYMkeTfcRe3WtZJ2i05Je2NQhcn0Q1FQUQAH8o/4wdOpXEt605/s3ouLaE0V2E6/I8fSMBrqLdJQdo7+kO/q3bY/fq+p+X2i92AW+779wJ0aMyrNB3bSY/MMR7RAiusbhURr/4tozKeogcNmN+NVWgybRVPmoVvXH5bIhjlYWpq1tOgksE3CGexE2lHq3qXyST19l8/bK2WVfhpbSzVHjLyQZWchW7iACI1F92W8gyqZ6/xfg84YV7Uzvkc6jRg6+RlipKc5C83WIkPX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3b9303-a279-466b-baf2-08ddc06ed31b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:33:57.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTXOiU9jsrhgzPyVOInK0O19A15OHbhCZsrM6QzrZybZElzEXIsmg6YJENfJTcTkA1w7na1SEm4klSciSa7Cfs0itXJ4wEdGitmXwsjB5UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-GUID: i4eHR9G8D-lJVny6x3SNhpifjbigjOM6
X-Authority-Analysis: v=2.4 cv=JoHxrN4C c=1 sm=1 tr=0 ts=6870f6aa b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=ag6DPllaGg_9a4COlocA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfXwL8W+yND5j05 gx01I3/deVBlqdf1KueMmAiDJbfRO3xF87FkWykpdaLCXiJDx456G4JFM0WN4lyF6nAw28zLVrp jN8uYV1GsOlguMrdBnoPiY4vjdtAznPnkwHw8w+sgVRZJ8flI3XKAQDlGULbLhP5oeUFkxMbbwK
 ya6YTULO3DhgfzsEgapQtT7Mvsunf/Yq3u1l1b525aq2iKdwi79Iyot/Z9MuRNKi+BCxna+wBIb o/yvsBklReydJ/7g2ZtVVfKe6MopOL7ID4n/PTvF2sTkQGpgrHOPLKF+hGQlTFbo2oIDbf0i9XI GDmkBGlyPKKzhXER6aC6xv+NTsaj/5A0aPSRnq2GYtYngfq8MhwBt6EI8PSq1M9B0XX+WyBTdym
 BxzDrplQkfZFhDKB9O/bfuiICPzPiHBVM929ByanPcVMfH0/ngZ8es1UzicyJSEVtQ2yfYWv
X-Proofpoint-ORIG-GUID: i4eHR9G8D-lJVny6x3SNhpifjbigjOM6

On Fri, Jul 11, 2025 at 07:16:00PM +0800, wang lian wrote:
> Hi Lorenzo Stoakes,
>
> >> + *
> >> + * This test deterministically validates process_madvise() with MADV_COLLAPSE
> >> + * on a remote process, other advices are difficult to verify reliably.
> >> + *
> >> + * The test verifies that a memory region in a child process, initially
> >> + * backed by small pages, can be collapsed into a Transparent Huge Page by a
> >> + * request from the parent. The result is verified by parsing the child's
> >> + * /proc/<pid>/smaps file.
> >> + */
>
> > This is clever and you've put a lot of effort in, but this just seems
> > absolutely prone to flaking and you're essentially testing something that's
> > highly automated.
>
> > I think you're also going way outside of the realms of testing
> > process_madvise() and are getting into testing essentially MADV_COLLAPSE
> > here.
>
> > We have to try to keep the test specific to what it is you're testing -
> > which is process_madvise() itself.
>
> > So for me, and I realise you've put a ton of work into this and I'm really
> > sorry to say it, I think you should drop this specific test.
>
> > For me simply testing the remote MADV_DONTNEED is enough.
>
> My motivation for this complex test came from the need to verify that
> the process_madvise operation was actually successful. Without checking
> the outcome, the test would only validate that the syscall returns the
> correct number of bytes, not that the advice truly took effect on the
> target process's memory.
>
> For remote calls, process_madvise is intentionally limited to
> non-destructive advice: MADV_COLD, MADV_PAGEOUT, MADV_WILLNEED,
> and MADV_COLLAPSE. However, verifying the effects of COLD, PAGEOUT,
> and WILLNEED is very difficult to do reliably in a selftest. This left
> MADV_COLLAPSE as what seemed to be the only verifiable option.
>
> But, as you correctly pointed out, MADV_COLLAPSE is too dependent on
> the system's THP state and prone to races with khugepaged. This is the
> very issue I tried to work around in v4 after the v3 test failures.
> So I think this test is necessary.
> As for your other opinions, I completely agree.

MADV_COLLAPSE is not a reliable test and we're going to end up with flakes. The
implementation as-is is unreliable, and I"m not sure there's any way to make it
not-unreliable.

This is especially true as we change THP behaviour over time. I don't want to
see failed test reports because of this.

I think it might be best to simply assert that the operation succesfully
completes without checking whether it actually executes the requested task - it
would render this functionality completely broken if it were not to actually do
what was requested.

>
>
>
> Best regards,
> Wang Lian

