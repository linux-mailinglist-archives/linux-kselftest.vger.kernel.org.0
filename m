Return-Path: <linux-kselftest+bounces-19932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB99A1D41
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 10:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3021F222A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220DC1D3198;
	Thu, 17 Oct 2024 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QJwH6edk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qx0ckgFz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8D1D097C;
	Thu, 17 Oct 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154063; cv=fail; b=Nei6d/uWuOK6spc9lRphSaK6ckwWbB5qS5hjLvV4Ispn0//utlHvr8anoj1YOCQ4mJUC8yKjR/KTeetgN5rK6KafGqOH/BTwpRgZ9RHvcVTZsHbWatC03LMLa+mcSZHq8eDh0rVY14XDWei4Mb5n+VXlEnvqlJgltEsIqmZq9S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154063; c=relaxed/simple;
	bh=qVynO42SwoYr3kx+L2vMSYgH9izZsEOtKD5J6MqBg+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m4eWLTUiWk02f6LuLuLkMmi/sKO5w9IWnJigXyLAqYCxDtTgfnVIRMCvFkUhTvGypdjBcKnIZBry4AnxSyMX0EFvb/V032qko7rFGFvgThmSyaAqKssLlC1C7JpJZ/X6OOblBD6Gzq/Q5u15CBbG8XPeo6+YWcgl4GLIQ8jaa2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QJwH6edk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qx0ckgFz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7fvKX015572;
	Thu, 17 Oct 2024 08:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=I8Voi6yCJ1//JYUn89
	c3Eg+861w91fOv83PRdGfX6D0=; b=QJwH6edk0pqe0bUBYrxZwmJZVmEpoTJyX0
	wqTUMTdZt1PGYmgaga/1AHz/16inNCcmgMICdGCidYubaU2ByKR/tTLLcbm6sC8l
	0zdMYZCU9X55QmSE9K5tIKTFacnYJu6vQ/OuJzDXyf6x1WiE2zY/CQectWQCvDHr
	IVE+u9TH4mghn30y3XIOdKW5wHqKmBW8YSnrrW0RDaQ+Nl+8rDHw9aJ2agWQ9pOb
	L8XGjSwVeFRUHTdmC4sPe/m37lUu5Mp1WcIb4fTpK7u2ZjqP7xm6szIQZCOZ/3KE
	i94S3MNHasXUOoYlOJP3I4l1j6FT7a3Cc6FCrEcfvsUDWkGGFIPw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt5rd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:33:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7xkJ0036678;
	Thu, 17 Oct 2024 08:33:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgbv41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:33:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDERMeb5k53RKhcna3jgZEOrc170S05Hvfm8jdGGMKZxbIw2cZOzK3/XPnklA0IvtjHyZ4E1wlHM89e33888mlNJSW/aZUp6njPc82HR+aBc4zg6UMAkaw5G3PxOVXp63YsKxJEXaQvgLD8V2lgmWxpxoOZGTVjO7HnInuJim/Wr9R9MrH9TRwEW8IqWZSwMhdWJ+tQbNB21MTeFoA237DF/YUQ1Cv/ltJX/rqOPu6uRY2lwkLlcGybdmN428NDWQLktraYSPnUxKHxQj/aIuf0S7tsrWrAjrNP+38k70vEzrcd4o14frQQ6VWS08FnAPl/886Cn6KEw49EyU4aTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8Voi6yCJ1//JYUn89c3Eg+861w91fOv83PRdGfX6D0=;
 b=oeQ5ABhC9QECS4l4Bs0IfIED09NvnITrN/nKjfOHG0zCyFFrw5TqzrrOFfJ4ISdd5F6Ql5/9JovIyLSmCtr2QRCTM49qnVeEKVWHFgcT2gaRE6dPl6qyyb94op3r4W6RstHG6hd8hFoY+iHoL7jyomqQ4UndQ0KnVQn2k2EZ+6vxgvPEa5tJdNTsZVwMeByPTT7eaC/CO65vsD0VBClYBmfn/fgp76ARgFjt5KmO+nvhEQKr+TaOi9HMSwWMr1oCVJwIgNWShmKTUOqetzqsIHLZsEaf3TXP/G+pyqDoEAfIVOGXSujBHCGvNdlFTfC81VPDuCOZkOlxU41lqFw59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8Voi6yCJ1//JYUn89c3Eg+861w91fOv83PRdGfX6D0=;
 b=Qx0ckgFz9U4S9wcjLRcUZDcYXnNHvWDQei0UgCpIqSEdzSx/YGJ0JB8kQM4mYiyTfMV7aX2od/BG7ca7kHy+49w9VLZ5+kQqb4tvJ3ACq6RWuCAOmJczFp+7VEF41VtxTgiiKMAu/tHhf/pMeCcxxQJk7nCvUgnofe6lzEALYjk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 08:32:55 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 08:32:55 +0000
Date: Thu, 17 Oct 2024 09:32:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        corbet@lwn.net, Liam.Howlett@oracle.com, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, sroettger@google.com,
        pedro.falcato@gmail.com, linux-hardening@vger.kernel.org,
        willy@infradead.org, gregkh@linuxfoundation.org, deraadt@openbsd.org,
        surenb@google.com, merimus@google.com, rdunlap@infradead.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when
 sealed
Message-ID: <4584981f-20da-4a05-a43c-8c715508b430@lucifer.local>
References: <20241017005105.3047458-1-jeffxu@chromium.org>
 <20241017005105.3047458-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017005105.3047458-2-jeffxu@chromium.org>
X-ClientProxiedBy: LO4P123CA0430.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW5PR10MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c53ea3f-c5ec-4eb0-f5c9-08dcee864c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPQVO3enyGHsxjDCGv6aWazw/lycyb8vF7XbS6qpGASEwMfJu5AbRWoXykUQ?=
 =?us-ascii?Q?PqhK/KMdLpsyyfAc7yO2WDTBVSQWXxYBr9rX4UMlVcn3M0QUnF+0VCmJUF/G?=
 =?us-ascii?Q?tAtiPQVpFUMmbZSmetRxODt2oXS3Kbo2HyboH7mvZmwqqx/bsepLPZo8mVwA?=
 =?us-ascii?Q?esi6mNF0v90JSpUicxW1o6lIOkMqYUMidlsG9BsLZP6E7ZB4BlRxBbMImFG6?=
 =?us-ascii?Q?3yyYXSANd5ny0Wc+JE7Gv3aZ7d1cfm10daHqxyRcUeICNBL6ieMoNtJCexAf?=
 =?us-ascii?Q?q2GHKPusdIbZXOwhGvR/jV4ELNqgViA9qsSM2tEtQ/JrM+q52LTu3TLMjryn?=
 =?us-ascii?Q?W65FhroW/07xtsD9rmkJhjlct+AStdhYjszN1FG4n6+tq0vZV3hP6C8WvIjq?=
 =?us-ascii?Q?0xrPWbwwO0arCMZCJgY/PTroH3l9GKNDEJ3JQq7GfhFqiwSUjCUd9csf3WbT?=
 =?us-ascii?Q?9QmDt/ZsOK6VSC6Wb24EuTfnZVww2+t+pe296Qkq53iC1RXnB4UaMBXXKPjn?=
 =?us-ascii?Q?bAU80QOonO8HSr++EY1DyofuTSFEM7tVv/fU7ecz3C5JFKIVa9ym0jZbZE3G?=
 =?us-ascii?Q?z2xuylAx0H0g/3HamOmb9ZegjO15MzzvNstdu8VOHsYGf06YD2pfhB2HZcn+?=
 =?us-ascii?Q?C93XzVnwxXkys7phQDHie2sWadhnyF8gGP813k9oTSG46Zd+9Zj5ZmOJGwMz?=
 =?us-ascii?Q?DqEVcjKVQI3YeOeiYOmCEI9hYyeaAI3E+Owx1PyreHhr4GT/UIan1Dpp1dBy?=
 =?us-ascii?Q?ldQFqDuwAuDHzu3RKtzBGkEGykin0+AtQcuiANn6asu3AA0fBG92/YEe6dys?=
 =?us-ascii?Q?5ouIVXXb7sxsW7EtP4Lk49rm3eR08oDkrMDxAnQe+fPl9YqhWwY53zvUqMXw?=
 =?us-ascii?Q?yaRX5Hau3ux4Tlv2443ESuoyT9LCSLShzc4twcjcQIATlS1c1r5teYclKxss?=
 =?us-ascii?Q?JXKGv6jlZQFejtI6D5xmvYjKNeJzj7isQcmHjMEXVZ8uyKU4x4n+Gj9Fxtg5?=
 =?us-ascii?Q?CcP1fK3Fu6aTzNDALfEctMg16PyVGlG3aRVuZO9zGKrnfuP91tegBPAO1SFB?=
 =?us-ascii?Q?SlBxpv/LtS8nX0pYyEGqwiQuFDqlwiWwqnaRQfzlQHaMUFQ+UAx4S7JI7ZaD?=
 =?us-ascii?Q?vRiDSIsJGPu47Fi+AWC53bnphpg9kfI+O9IoJ82pUBLETrF71Vtw7X9TXbSG?=
 =?us-ascii?Q?PX40thGVksaqvC4kh+hoc/kvXkXhsW/1tOroDOPsQ7dsF8XRRCSKrxj6WeXF?=
 =?us-ascii?Q?3PuO6c/TO7fFE8wsncZv9v5FsdSVLOBwJCZc/gSi3re9gYkhcPv2+lhyQcmn?=
 =?us-ascii?Q?fCXkyGnNwp6FxkkUcRXsMkoi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBAWC39PDIHjOKAewmeUgOEXXmP759BWSzywQbcV2zUZ7XLY5TWdO7NiF9lt?=
 =?us-ascii?Q?xFw8p4l0X/BDAqouSbWY2Ey7csxoVC6o2pboKG3aYmzEAOMA3/QoYJfg4OJP?=
 =?us-ascii?Q?Cgoc6m9C4jhHKcF/mZHcXHhXJStMsGO4DOhXH/cM7o41JA4dWiHcFne+cvQV?=
 =?us-ascii?Q?dZY0d5/7SIuSWSDZppOROi0QPtWAQWBPNXGPYRiUMI1A7aHqo1+gL8/gQqER?=
 =?us-ascii?Q?UWvM/wU+gaVDfiBxEpnkWDG8OpwbORqrLn5pLX42IJscKWtT/S3S9ZWW6a0S?=
 =?us-ascii?Q?UQUatXAMY1GIe/k6IOcXF09UwFAolZfXE95gp8M4DvgATCI92K27G9eqT0tY?=
 =?us-ascii?Q?rOLRXQTIYUkgayjcCfEp3BLQDF7uEcvNOkd46IrBlGkAmtBnlbJDIYi1PxSC?=
 =?us-ascii?Q?G9P9RalTjzePsQFcHzrRN4N6PBX0hVMfYwyKyULG28/lHROAAhPgT3RWF0qb?=
 =?us-ascii?Q?SbXRWNidasr36hEOsAbBA77vz11HdOnNIDMlmZ/eFiOKqJoDs2QsRwpVBkeG?=
 =?us-ascii?Q?t0t/njmw0HmflN75UfTxppsIYKit/408V0vdHEDlxRyGmIuBSEMCsoGxrSa+?=
 =?us-ascii?Q?yGMoM5bWVyV8zQub83tcuEw5WwadewSl07fJYW5FVnJG6PiKdZqI6+RjzJTF?=
 =?us-ascii?Q?FKmEmh/6g1MkzrCg81ijfDMyMS7ZHqimAb3iGJjzE/i5knuTyaeF1ij4XhrJ?=
 =?us-ascii?Q?aL+zLJd76zZ0Ori89uOIl7P9QZC0/1kNLNJrcx408Ksw4th/dJ+0gqu81DaG?=
 =?us-ascii?Q?Xrmex7KcslN2z2tgZeiKht/7ggrcN2Cl/pcszJwvpVXEspF2SuwLB8qRaKcu?=
 =?us-ascii?Q?hfcKMIjCenu5vdcFhVVDQFr1gyAP1vFz6y9s70s7CfUv+beYMF+WWUhz1Lvi?=
 =?us-ascii?Q?ztYN4vG+ltW+LJUmPZrQy5G0F2MJzyFV4vJHRKjQ9V+rGE9sU3RkPAb++iTt?=
 =?us-ascii?Q?lx044ZVywveZgBjIBmbs8yFomUH2Fcua43MxlPfX8XRvq+jp4PIZKqcF6GJJ?=
 =?us-ascii?Q?AsE3S3oFgmNa5AP8n/adFQU/znayFaXpg8PlWUkIWqumJPO/yXJqly5q5UMm?=
 =?us-ascii?Q?5QFthkJvSZ1+c/pYNGalceBGoG14N7iCMsW3zazgtMNdXFx5kG+PNlBP+5hx?=
 =?us-ascii?Q?0W55L2GKGCmNm7fZeTOzU77C/ZyDbYTyL32NaIz7FqKdz9xAE8gl+QtvQjFC?=
 =?us-ascii?Q?uu5cR7oj3CnVlYdBVyWEMYb60z8oKmc9Hin+CvAFYo31HAkf3EQGweMM5SJv?=
 =?us-ascii?Q?M2DZ7fpsDZ+aEch4wZXpzHySOiRWLeyelU0gPfBQe/bnTF83c8MFebuygODl?=
 =?us-ascii?Q?5Wu9VZrQOkaOmdRALI+MioDqAfpKhzQYusuEYqCH+E9nd6ysrA9pe8LBsLPT?=
 =?us-ascii?Q?NVNeEKiao8X8hzMqejWfMwv19M7+2S8x4f3OK66qt3YDLrqjR1eYZTHTD5mH?=
 =?us-ascii?Q?4bo/Jr28YL3AGDgDy8gdiGGDUf5OId/o3rg26e8dlB72/sbLj/YumS5ZZEIf?=
 =?us-ascii?Q?ui/GUw8P7ZE4QlZn5z6/VP+N3rnlYTjpD8x2OT2mv5THCxuM6/YzSGLiXnzM?=
 =?us-ascii?Q?PbBKOukjRA2pV3wt1GVfZ3CSNu4ljwLe6lFU1uo3frRgE+siP7n3XdkOSWyV?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WxMhvOmqGWkMFjN8Z/pVrs9xJxMb/rEv0avsoAmcfO6lC7WB2UUerBoR0RXId5yw+FlnEMHoQiFLYuWoqb8zgNOzCBQhzZt/LjNPDkP9Vd39FCVvH2EJ0a3UmIQfSL8KP9SK3DRcLfVKtU/haQ4d9+v0l0WCMdTiPfkxYc3WHU9OIvlwg12MOrowKp2gIm6P5zrcHk9ttZHt5FBfINm+g5mQtf2aqZ3CSaqSJ8rU5ABpAteBek03ahXh7dU0m8kgK7JEZMv1ktf36R/J4d+XGSKKXId4xXfBmh5VA0otAZPmfVnA9KS3WOBqHhAzqVENKGHwu6xnFMcK3DIUd6P2SYRl8DARnjkY9g/2oPfj1WKGwQGLXJI1jFZcysc4t+Swxw1A8VCw1oM58qCR/hUqhZfvFrcgPUn08C6lvTvrbe8xQXzhciXs72mz8PKsNxliLXqHKKzgG6O9SWrEz8YV3xgpuf20QH4BnYkrjbzc+zG4XAdEC46IqZHQlqfKCbJCArvTx503hJT9D0NPZKSfu1URbogACz5JKhK7SmUY9sOPJjwAOQIN//j0KvQlih7fS7x3p3db9pvgdXVp2vDc3fmt19hCQ1lUmbSthbMi9vE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c53ea3f-c5ec-4eb0-f5c9-08dcee864c66
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:32:55.7017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5W0LxXsUZSm6Ri/Mcra2WwYc1wrEzdhFA+ugNj1TQqTPTjt2DoXnMhJsYrxB4dHKkn0OuVDgAlFuCtrchoBzvqK9rpb4ZTJqEas12JTBuoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_08,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170057
X-Proofpoint-GUID: NhTcfrginB1RupPEEZCiYRgAB8Qkj3O0
X-Proofpoint-ORIG-GUID: NhTcfrginB1RupPEEZCiYRgAB8Qkj3O0

On Thu, Oct 17, 2024 at 12:51:04AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Two fixes for madvise(MADV_DONTNEED) when sealed.
>
> For PROT_NONE mappings, the previous blocking of
> madvise(MADV_DONTNEED) is unnecessary. As PROT_NONE already prohibits
> memory access, madvise(MADV_DONTNEED) should be allowed to proceed in
> order to free the page.
>
> For file-backed, private, read-only memory mappings, we previously did
> not block the madvise(MADV_DONTNEED). This was based on
> the assumption that the memory's content, being file-backed, could be
> retrieved from the file if accessed again. However, this assumption
> failed to consider scenarios where a mapping is initially created as
> read-write, modified, and subsequently changed to read-only. The newly
> introduced VM_WASWRITE flag addresses this oversight.
>
> Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
> Link:https://lore.kernel.org/all/CABi2SkW2XzuZ2-TunWOVzTEX1qc29LhjfNQ3hD4Nym8U-_f+ug@mail.gmail.com/
> Fixes: 8be7258aad44 ("mseal: add mseal syscall")
> Cc: <stable@vger.kernel.org> # 6.11.y: 4d1b3416659b: mm: move can_modify_vma to mm/vma.h
> Cc: <stable@vger.kernel.org> # 6.11.y: 4a2dd02b0916: mm/mprotect: replace can_modify_mm with can_modify_vma
> Cc: <stable@vger.kernel.org> # 6.11.y: 23c57d1fa2b9: mseal: replace can_modify_mm_madv with a vma variant
> Cc: <stable@vger.kernel.org> # 6.11.y
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  include/linux/mm.h |  2 ++
>  mm/mprotect.c      |  3 +++
>  mm/mseal.c         | 42 ++++++++++++++++++++++++++++++++++++------
>  3 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4c32003c8404..b402eca2565a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -430,6 +430,8 @@ extern unsigned int kobjsize(const void *objp);
>  #ifdef CONFIG_64BIT
>  /* VM is sealed, in vm_flags */
>  #define VM_SEALED	_BITUL(63)
> +/* VM was writable */

Woefully poor and misleading comment.

> +#define VM_WASWRITE	_BITUL(62)

The bar for an additional VMA flag is _really high_. As far as I'm
concerned you absolutely do not hit that bar here.

>  #endif
>
>  /* Bits set in the VMA until the stack is in its final location */
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0c5d6d06107d..6397135ca526 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -821,6 +821,9 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  			break;
>  		}
>
> +		if ((vma->vm_flags & VM_WRITE) && !(newflags & VM_WRITE))
> +			newflags |= VM_WASWRITE;
> +

You're making this unmergeable now!!! No! Lord this is horrid.

You can't fundamentally change how mprotect() functions to suit edge cases
for mseal, sorry.

>  		error = security_file_mprotect(vma, reqprot, prot);
>  		if (error)
>  			break;
> diff --git a/mm/mseal.c b/mm/mseal.c
> index ece977bd21e1..28f28487be17 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -36,12 +36,8 @@ static bool is_madv_discard(int behavior)
>  	return false;
>  }
>
> -static bool is_ro_anon(struct vm_area_struct *vma)
> +static bool anon_is_ro(struct vm_area_struct *vma)
>  {
> -	/* check anonymous mapping. */
> -	if (vma->vm_file || vma->vm_flags & VM_SHARED)
> -		return false;
> -
>  	/*
>  	 * check for non-writable:
>  	 * PROT=RO or PKRU is not writeable.
> @@ -53,6 +49,22 @@ static bool is_ro_anon(struct vm_area_struct *vma)
>  	return false;
>  }
>
> +static bool vma_is_prot_none(struct vm_area_struct *vma)
> +{
> +	if ((vma->vm_flags & VM_ACCESS_FLAGS) == VM_NONE)
> +		return true;
> +
> +	return false;
> +}

You don't need this, there is already vma_is_accessible() in mm.h.

> +
> +static bool vma_was_writable_turn_readonly(struct vm_area_struct *vma)
> +{
> +	if (!(vma->vm_flags & VM_WRITE) && vma->vm_flags & VM_WASWRITE)
> +		return true;
> +
> +	return false;
> +}

The naming of this is horrid and confusing.

> +
>  /*
>   * Check if a vma is allowed to be modified by madvise.
>   */
> @@ -61,7 +73,25 @@ bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
>  	if (!is_madv_discard(behavior))
>  		return true;
>
> -	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
> +	/* not sealed */
> +	if (likely(can_modify_vma(vma)))

Please don't just use likely() / unlikely() because _you_ think they're
likely/unlikely. Only use them based on profiling data. if you don't have it,
remove them.

> +		return true;
> +
> +	/* PROT_NONE mapping */

Useless comment.

> +	if (vma_is_prot_none(vma))
> +		return true;
> +
> +	/* file-backed private mapping */

Err... how do you know it's a private mapping?

> +	if (vma->vm_file) {
> +		/* read-only but was writeable */
> +		if (vma_was_writable_turn_readonly(vma))
> +			return false;

This whole thing seems broken, and we already have a mechanism for this,
see mapping_writably_mapped() which _also_ handles write seals for memfd's
which you are not accounting for here.

> +
> +		return true;
> +	}
> +
> +	/* anonymous mapping is read-only */
> +	if (anon_is_ro(vma))

You're implementing subtle details here with 1 line comments (that are
pretty well useless), that's just not good enough.

Please make sure to add _meaningful_ comments that will help another
developer understand what's going on.

>  		return false;
>
>  	/* Allow by default. */
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

