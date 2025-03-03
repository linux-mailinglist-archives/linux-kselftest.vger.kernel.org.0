Return-Path: <linux-kselftest+bounces-28028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28934A4BF60
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D22F18840D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88ED204F6B;
	Mon,  3 Mar 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XT8J2W8O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ukbLibY0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACA1F76D3;
	Mon,  3 Mar 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002743; cv=fail; b=P53lh9RZeVLjgaDN6XNNrPeyWdxcuKKLAlr0+NZliSEK/+UUja3eMHxdf8JiwjmYyGlYC5N8Cyk+pAc7uIuJkwcVmyeEL8uWYIwBe2JA5zAv34tEJV6a5zEECFQUtccgAzfF3//HXxPPqBXmdKv3oI1Dm46rFda4Q2uELFgm9qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002743; c=relaxed/simple;
	bh=8E2LeYRtl1Y2bnZM7z1yzR9g/ToB9GTwBnpU0WVdfM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zs6xbJ4biy0SV64oID6eEUBZjz6LopVedQ69KSn2mINrcpZYf2kD6aHf6lGlWGI7DxCJ0lxY5iUejdjRkwDofgWp89lo3Shgmy1Ut7bUhDDKHb+lo1qm+9DhSc9ClpAIUENsJwDuN3ygrtSALX1gJtWfEkSuBgpCHsc3aStaQs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XT8J2W8O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ukbLibY0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tfEp030063;
	Mon, 3 Mar 2025 11:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KfUb/R1cl7DsvIpvTd
	3NmQ/bYvsniqQ4K5McdmCSn+k=; b=XT8J2W8OBv4rvtusb73vtYB1vJiRW+294F
	WMV7VzGHBeeQHVCUPha4Rv0iH4CUiQPku8IQ+B/iu7KtGx0zTVxWGgvWZ3vt+2Ew
	DH5HIm0kvftiLSlu61TQz4vNKu1AADVDLynDl+V6aVvGornJlLGcEdypjQuZtho0
	cO7H5wfWN1G1v5QJYPvV40WaiRXe0GuNqVHamQ+aw0D/9wtq9vVQyMLyvx2/3sf6
	ej1gKl9SGa+kGqk5ouYmvJ1wZISaKFRDtRflGFl5AoG9RLphaWtMLvyo7bMKwFBc
	PCrWGf4gkl+nw2JNTvaDF2EfZwzz08adqComYyjm9mEcu2NFGdtQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86jfs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:51:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523BTEoc040346;
	Mon, 3 Mar 2025 11:51:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdmukx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 11:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA+JD3XQytu79cwWu7xnXThYHWlBA6t/ifjJwCNgxODZsq6EpD+E2vIEjFQftVNAKwoGNZkh2uTu9gVpgZzznw/bu9bg7PUZbsHb0Uin2NGA7Qf1EvPyVlG3PsPuWCamGBvr/KLmhVYvwErOHpuxCfVEn7OCpq1CkhxU6uJb1BLLpwfSxZYS0pEkDrn8xjDG5od9PuIb5a6rA69OU0TEGID0v7BYP7Pzm9nmhtjTet9GbeJ1exyvaJ3ygwOzGWSzWsHafLatJqFbjGWU5nGxhLpgjZ34lO9g+cNqSIyrUYBYv6IlxEOZsK8ilGYvMqZzBYWPIDXlwhJGIqWYmyFSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfUb/R1cl7DsvIpvTd3NmQ/bYvsniqQ4K5McdmCSn+k=;
 b=u2aImDY2uOwbN4gh4O6ENlJbAVVSM4RgYywk6pYE16/XpKzE0fdkW3DKA2PE96Twc5/NFhlEJ6ESsBRPf2Q5v5evTGgUCaSSXy3L2aUzlGBPuCCNwaC59rfh9vYwh21qbdh3z3IenuE/RgQhdivXPbU6tF0EGKinFkzii/DUc8j3+/P5SUnwQlid/A/JJMD7WU+YaWW0+ssCBQt/m59TXLer78HfFn+RouKH6u3htG0GxGZtZAD0G/pc4emoixkbpHBV8u6mpt/tbUwUOY9WRB7TpRXW4IKg+Oo0xQf6wnq+aKHJvnPAtFTDf7nPQ3w3mzo+JooOXMFCwqVcEB9W9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfUb/R1cl7DsvIpvTd3NmQ/bYvsniqQ4K5McdmCSn+k=;
 b=ukbLibY0ux3AZD5zm3K9yRR9ekK8OIM0R034lXiqJTS+sjIax+5ZjRBK6e/3qI3L+lUwn6Ny3ApVQ/tsAs8ocrfxlcH/wPgyeS8BhYQKYnhWVE+yuzSzLcLShyE8EpK269RB9xprm49y8T9cXu5Xge/DjUdpYuZnL7QBGpSOXhg=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 11:51:39 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:51:39 +0000
Date: Mon, 3 Mar 2025 11:51:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
        sroettger@google.com, hch@lst.de, ojeda@kernel.org,
        thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v8 1/7] mseal sysmap: kernel config and header change
Message-ID: <0ea20f84-bd66-4180-aa04-0f66ce91bdf6@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-2-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-2-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: b23711d1-7afa-4f24-091f-08dd5a49c258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iedQjZFBeUenh5Sit2yYyIEdm+EVs79/NRlblI00qcYFU5UdBCqLrhKJwjQI?=
 =?us-ascii?Q?9xBfH++qaE/MEoggpE6TZA/Eh5DsuHT4NbdoJrnRwOHzEIdhHRQ/lQX/E/yC?=
 =?us-ascii?Q?QePYCQrxjGYX7+dBdkWx+2vFfxer2jl413BLrpIxZ60L9sxUDc7QTXfAoP6l?=
 =?us-ascii?Q?aYx7zOoC5ijPGbzUQwT+Cj5f/d1VIc0N802QkqK7iQl//woIwvkIpB5/JWQh?=
 =?us-ascii?Q?lSBhG6FnrxGIkobJymNn3v7C64bOk5GsOp6KW3hgrjDLO3nMN3UbtMcn4mJY?=
 =?us-ascii?Q?XKL1/QBkz6KG90dHm78nE84jyBlBTxPsVmGi2mAuMOiJwPpzUbJ1qRUe03DI?=
 =?us-ascii?Q?967wJ/bh18xOx5Le6441gCBtIzyRTpVyQgJlE/1hf9Vi5inxi6AarU+5/EkQ?=
 =?us-ascii?Q?v1WiXb9DEy2KM6wYD0RCTYkm+cMNsfrR/ke2OzsUEWS1E1RpaMnWdtx+qQ2+?=
 =?us-ascii?Q?Yc8KDuqyUtVGGT60CcCJDwTUKpHwe3NGt9HCZrWPUMyaqkevD3mS/C7qG1pI?=
 =?us-ascii?Q?rMA1wu5GhM0NbKG63+zzLQAN7gaNCAc2bgmXHPlPC+Pdhic+UTSQJtAzSrrj?=
 =?us-ascii?Q?qWsZFEUudKJ3QK2Lma6TtS+buFEwN9H0nokLwck/qD8TFbxlbJU6wJ5dofZS?=
 =?us-ascii?Q?g1AqtuvjzUxS/5U8Y/bOGuAb1tHhMXUx0UaWfaRKAJmiRAVcZmOnsJcx7OIo?=
 =?us-ascii?Q?B9ip7huPAjnLBS/S4DhcW9cblwcgfG3BU8dAfVYtdb3/fKRkbid+Qoj4p/Ax?=
 =?us-ascii?Q?QeIyKCpouPmPyJVq6idpVp9XSmRN1+4HDHV0MUs0yRpifZNKt/56IGDLFvD3?=
 =?us-ascii?Q?IlI/+L47xiGuNfdevdo0QDdSWiPUN5zbHqpu5SPhUw2qhBNsZxAahJOGpZmr?=
 =?us-ascii?Q?4nWaV9l54cM/XdTraxtDthbbW9BKyZWcUcB6h/PqoIPsES98MCvdLrIR3z4W?=
 =?us-ascii?Q?sJ2QTmYPDNpKPde0SUUVvhed+Uf7HDi/Vj62/C4Vogazba0ka5041a0Uqip+?=
 =?us-ascii?Q?dqlkGyQM7pZaIQ7zXF3B4cdSWr9VxNcaAMrfcXPbMnFbuetF1R6WWhE4V/2O?=
 =?us-ascii?Q?EQisZyS6+6Vhjj0OfVaND8R1CBAUqNpao4+AziqV0N0zguiRkbTx/U9S6TI8?=
 =?us-ascii?Q?HJxdsgl0lUuZht9/qlpblJf4qgBmeldjzCZfKeJE0FD1s85yolKiYWH6lSIN?=
 =?us-ascii?Q?tMOJa8BcOFpWM0gQyi+FcJCbKksFJWqXC2zA4mGIC0Qflxcz83Knj6nvU5Ba?=
 =?us-ascii?Q?JVIkgVQMbSrNMRMncinjWyFsE9z1jtz9ydYU3h8/qiXf6Sn3369fub71ZN2i?=
 =?us-ascii?Q?FtnY4ZKIugBEVgv/su/F3r9I9qgtB9HI93xzTbYy8Az348j2txC5IdmWB3GX?=
 =?us-ascii?Q?mzqrujJjFtd/VJ6mR97skOJgJcfZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zs4AeK1xCTX5Kvmbl64RqzLim8ABz+M9CfknDteEroNKFwcITLsUla7y7WN5?=
 =?us-ascii?Q?wzOZcO6WkuHndus3PI8v6pBHO3K7jNHzB4Ftjj1KDOKDkPPpzfRX0pG5E5kL?=
 =?us-ascii?Q?WDFprbqwaw6xnu7ejHs8WV7MpAJ6Oh765CmkvMERJh8mQ4vYAUGnBQ+1N1YT?=
 =?us-ascii?Q?xkog3moRsppbANc8vv+8qlfDSOEOn+J6hK877fEEaNzY6DroKmOw6opMTqNq?=
 =?us-ascii?Q?6g8muvwkQIUZ+n3IkDRzzKqJR4Om8YDZAqoWZRm50rAsJzsq2gxxMFvqAZLu?=
 =?us-ascii?Q?GMit8Pm807KWGOtcunlox+fgV4LEb+pMLo1uegtVs0KSZHb2vU1C5N2wVicr?=
 =?us-ascii?Q?yizOsAWaS+M0hdy4tqXliV2IJz7o1Rbq/5pdIP+BNNbbz3PDG4lAAbHSvrgS?=
 =?us-ascii?Q?OaiObqCwUPJ8SbZ5KFBZNbrWudfqxCgUn68efmqD5hE2otJIhtyh+6K618h3?=
 =?us-ascii?Q?4aNxl/wGdRD0gqlEY3nh8ktsFt1HWeimZPI0wh8fN9tZZr/80mrg8guR6ApB?=
 =?us-ascii?Q?nEtudmKMR80rojWRNDshDp5sjZAZmsXC7KuV4HuH4G2jaN0uOeGFTgdlU7zt?=
 =?us-ascii?Q?+zMP6y3TQPe0GKChXTXd59fKw9jK0eYHTVuJG1ZAr7ME0UL6PWpA8o9B2Qga?=
 =?us-ascii?Q?ZJHLiTsI12agtNgvmvOh8JsfM4clIEWXGqtHSnj1MSmKV/Dg/HR4upBKUtOw?=
 =?us-ascii?Q?Atdg2tVwKZfCR16uLnu6oI0XgUPT7S7x+ipsHxw4zTT3zkTLXjzi8CuUuwth?=
 =?us-ascii?Q?1JQxanCMfkvWy02PdHzMBsxfRstyXD9rRCt3n5UxhWuMatdmwtCAqYr6uDmX?=
 =?us-ascii?Q?fGEy9GdH/ddwLMbWnMOG33LnpdLMIixl6ut7P54Ne2WJJWjOgK2q2mNBQlK7?=
 =?us-ascii?Q?GOAfM78ugWf1UqQvPeuzBM/ZCzEaqriM9lLkOua39XVYMQaqPnOZK2V+SdvK?=
 =?us-ascii?Q?bb0cIfF8aJA7OSK5wPuiMOVjKpg179aFIUelFNG5EWNJv8m5x+xOUThrxTs9?=
 =?us-ascii?Q?fcpnDCOpb1uDSmOrEUtXOVpiBf8ENTksnd8IAx+7THjpUn1iS+R6yRjBD2XZ?=
 =?us-ascii?Q?0GO0/u2DAj2TKrGO5ktwwOhGj9Js8CtWEC3df/+bsKUrEcsu5b3LDsbmi8aF?=
 =?us-ascii?Q?qApDnGrs6TIIeGJ9VfYf0HOmf0MUiadmG29fPvGCVSTN2YoqVz8cLtCj7O87?=
 =?us-ascii?Q?M8MeBq7iHGp2qcaws6Ftx3xaGbbjtWP7MmBQyAuf5x46Nmv6v87f6CZM2Qxl?=
 =?us-ascii?Q?ZyFjXU1sYGUOaI2rL0m7s2JEOC92ll6hTZEcDNS0EuGyq/LTIVqb9SMC5tJA?=
 =?us-ascii?Q?hhNEpjGx1r3ohc0MCYbYR/t2E3ALuJtZekYMJfZwxrfV0At9JM+rZE4TkI+n?=
 =?us-ascii?Q?lXDMtFMmHymb4V4ZwoqPQ7yH2zhzGccPG/jbF8MJaGtd3AC6oA31eXaBa4CY?=
 =?us-ascii?Q?/uEj/T1ryJOcuPbtkNF5/AsB4PejW3lOnONuJCL5shSycUblzpCeAwibc4kQ?=
 =?us-ascii?Q?JCIt/j0jNHrCjBP3stAxi6RsDwlosCt0RQsLjwFFiZ56s1P+lBjeEEA/pr2s?=
 =?us-ascii?Q?lKuAGZiSnb1pWM40uwmbivLEGVDcnWatpT96yLF9966Oba+WukVl0sMAxhM7?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tQQyKmCfzLJWgbYdBs9hyPRVe0rJOXvWsv4kmykvE2DcU2Ce3RUJ+d63GTsIEWOBX1Gp6f+W8vqB3tVflB3b+SnH/M6nd+Pb/BVsgt99UDJCZMSqln6yPXbS+fZvhZVu1trlouIwvg/sRrljD0ktdFv5rDBiREZhzXdWjSCrxtPIzFbK8IXhN0htmHhDSz+mA8a+lKzpy8VRa3fPq7M+9ztb7kDjC7n5X0O4mp0caA0jmInZO1heU6SNVmhIrKAOmOGvCNJRccNEscSIlRZOHHiaXt/lHj0cybIjayO5YcfCH06eD/ezq4VsamgrUj4idLbE7qV+eBPn84gL4C5SJsstVm6RUEkrmo4cQqlEmACQf32EwX3rUNRCz8Di/954nwyctTvDXTqPKD9DPZqboAURBSXbqRvYENYtTBC59zJc6vF1FOrbaZRIvfu+IWHB4FAHIo8uWPj+axCVkcFOCF3DWtU1dcKysvAG2dHfe4/eb1Z3qvV9IxNEKFbPc42ddpG6JLyCYUjBv4hb54Z6hv144kRW3A0KrcAoy9Rl4yWCdE6IvWFEuQRcQNuUgIRxoWKqhpZf25jZs4zqhoy7uUPeB8kAL7+n1lKTkHObVAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23711d1-7afa-4f24-091f-08dd5a49c258
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:51:39.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQDIDCvFiVWQ0BbcDToZTz/Oz8I3eq0Hk2qtfTws48GQ8c+N9+lon8ym/eDBm7aeLBGI/bX8lCk4WhBXAR2QVIMo/raxAhqxSxIc24h+7oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030091
X-Proofpoint-ORIG-GUID: oXr1wD7x6_ryqyn9uXJML2xYr_bvtshP
X-Proofpoint-GUID: oXr1wD7x6_ryqyn9uXJML2xYr_bvtshP

On Mon, Mar 03, 2025 at 05:09:15AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Provide infrastructure to mseal system mappings. Establish
> two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> macro for future patches.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h | 10 ++++++++++
>  init/Kconfig       | 22 ++++++++++++++++++++++
>  security/Kconfig   | 21 +++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..8b800941678d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
>  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>
> +
> +/*
> + * mseal of userspace process's system mappings.
> + */
> +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> +#define VM_SEALED_SYSMAP	VM_SEALED
> +#else
> +#define VM_SEALED_SYSMAP	VM_NONE
> +#endif
> +

Thanks.

>  #endif /* _LINUX_MM_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b..c90dd8778993 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
>  config ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	bool
>
> +config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	bool
> +	help
> +	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  To enable this feature, the architecture needs to update their
> +	  special mappings calls to include the sealing flag and confirm
> +	  that it doesn't unmap/remap system mappings during the life
> +	  time of the process. The existence of this flag for an architecture
> +	  implies that it does not require the remapping of thest system
> +	  mappings during process lifetime, so sealing these mappings is safe
> +	  from a kernel perspective.

Great, perfect thanks!

> +
> +	  After the architecture enables this, a distribution can set
> +	  CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config HAVE_PERF_EVENTS
>  	bool
>  	help
> diff --git a/security/Kconfig b/security/Kconfig
> index f10dbf15c294..5311f4a6786c 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
>
>  endchoice
>
> +config MSEAL_SYSTEM_MAPPINGS
> +	bool "mseal system mappings"
> +	depends on 64BIT
> +	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	depends on !CHECKPOINT_RESTORE
> +	help
> +	  Apply mseal on system mappings.
> +	  The system mappings includes vdso, vvar, vvar_vclock,
> +	  vectors (arm compact-mode), sigpage (arm compact-mode), uprobes.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  WARNING: This feature breaks programs which rely on relocating
> +	  or unmapping system mappings. Known broken software at the time
> +	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
> +	  this config can't be enabled universally.

Perfect thanks!

> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> --
> 2.48.1.711.g2feabab25a-goog
>

