Return-Path: <linux-kselftest+bounces-19777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D799F727
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 21:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F141C23816
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B891F8199;
	Tue, 15 Oct 2024 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l3IujrR9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yg1qUcE2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2C1F818E;
	Tue, 15 Oct 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019891; cv=fail; b=N1YJSYh/Frwc3fmfi74wdIiIq0X/bcHUMWOKj8M29kvij4s30eNC5ONektacPzD75xEubkKM1LYUAht5Ph8yDxBm7scoL9lbldqdSdDcyOuhYemkw3Oe2shUoMMk3B5aVatJorcTYGgG45DeZVejlSBjb01EurP9x+WvPrgwjBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019891; c=relaxed/simple;
	bh=X4LbpPCUxKH5Zmd4BdgH+jSajdZQwDwUVgMO8lY1dOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uw2pAP9N18t1pzV8G5XTigJzJCZF8GqdOs+wyn2pEbTgBJrhwrw6qbkAmJ80yIjGwtTURvsJLlFUxpGWjs6e6KlQFhGV2ZqX9UD67dZsUN2qaowFiUcBzpCmn+0H3hNV2/J8xFzlCWAaC0xbtCiLNT3fieNyZz10Q7KpP6SS/0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l3IujrR9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yg1qUcE2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtiVS001626;
	Tue, 15 Oct 2024 19:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0vY5cYuz4er/ibsH4D
	zI/B7RnNM68m5N1RoQOTxriAg=; b=l3IujrR9gOlYUh3Eme8yN+xRD9tuL3bMSM
	MSuZLnRmr6Gnea7FOFdMf5yPxwyU4O1FFXpHmLiOj9y+I0PlKivmg8vMFHpmw+8a
	9XpNGCWI9YqEw4EIRPDCPIaUPnoDEkiimSXWJWly1bwIrrASiNflAwhV8QCSjism
	op+FjsSDd6Gh64MDCWxX6nGNHW4cPaA4bY3rSaGJEI8RRHlrG9UWFAeII+aygV+Z
	38I3QuI28JXRyxrqRHNXqv6mFnk9mSTaJHGysdpptJC8eQiYutbd5CrtoRZmgYuQ
	xQIme0ZQ9/2MauB8g6YvMQ1LHHwsbp69IFz3+R14OcPPWwsVzbGw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ahud8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 19:17:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FIxFTe010371;
	Tue, 15 Oct 2024 19:16:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fje6mep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 19:16:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0BrT6teW3hP6BPDSMYhALs6wR5i501silxRkFaVV1M908L65B4Rhb6SVdBjj4GJ3Udnvypg2ns4QYC+riBfKKRi1iEmMpNjA0bcU6OMZ0fD3e6QKuegNhR8HIAwkGh67Dazrz59HpnTw3W9nL/FqXaEDRylaIMZkAqyIfbAi3HM8erbiC4+oe21+KNyZpnX5o7boMiAfJHmGB3wPOLfZYkYDwNCwQRTCdB9oC9hrBfHT67qoQspqYXfrpncZf82MFIUy2F8IAja/no7S3A3hG3drG9pp9whClZFMfTazwVwydTnBiOuNpb7aVMA9mlV4tOr+f/02ZotTWKsZLPxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vY5cYuz4er/ibsH4DzI/B7RnNM68m5N1RoQOTxriAg=;
 b=xpRevIzBpFWyc8H3wFia4HkmCKeCZGKS3gkG2bgz8r1Udk56dSTlqLz/WAZy4cxUcHnKctQ7td1TN1XScfrJt5nLzHVHCa8IJJV1bxnY1xkisEX0pxzFxjjk151ngIUbDyni0ghL9BHAPjVM4S5BSb4FcajWy++H+PsCXTpmccnQopuDXvim274mCMC6pqMPLm4jOAzblI21eX/LkXvY3bZwRg238ueIZrTXuOlsPGtvX5GbuM8R7R40qp/8nHLNpa5NHhoIa0uIDiIpS77DLvDWjvWRj+yUjzG3bYqBQHsmHbM801YfK6vU5u//SdhF98Uw9Bof2ZvFo0469r+ueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vY5cYuz4er/ibsH4DzI/B7RnNM68m5N1RoQOTxriAg=;
 b=yg1qUcE2Z1kZQbeXNUdcjOe59OBEYVe00q+mO61WdHxiqHpe7lAASevAvjf1Nj+anKB6HLfYpz/PzYjBXB+z321zfqOAMGg26eSdNrFIermtX8u7HF0bWmFwFo7WZdjmnq5ePPQExmTkmNfJ20zWQ4uVAXQznKwgwKd+cMNAaWE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB8116.namprd10.prod.outlook.com (2603:10b6:208:50b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 19:16:56 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:16:56 +0000
Date: Tue, 15 Oct 2024 15:16:25 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next v2 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Message-ID: <cslvxh4obzmzbaekc52h4t3b2e4ru2kypvjy3545lucvw2jlmx@3wgym6gbgb2b>
References: <20241015173014.1083069-1-anjali.k.kulkarni@oracle.com>
 <20241015173014.1083069-3-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015173014.1083069-3-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 63514feb-efb7-41f6-ecd8-08dced4dea11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XdxBmsmbtOCAUjF/Wsuf+h0mSOsiGSGBF+gc5m3qE0H0B5dC2LxhexHTnwSx?=
 =?us-ascii?Q?/AKqeWBXxa887tMEzA9CZoYtWyTRGZoorHnz+hKN4jTnmNS2LPiX8rcYx+9d?=
 =?us-ascii?Q?e6Z/bnZBFtbPBCpeu+c1lQZF6Oa2ApRlKw9Cr3PSGul01kef6nMKrLudJU4C?=
 =?us-ascii?Q?/5PFwUf1+aN6c6WVczz2HF7imo/DOSxv1Hl+8P9eVTkgNtqZFj+l+2IMy78W?=
 =?us-ascii?Q?gKhvof2kBbrx+shmlXNLbUxAi5eoqLY21RCLupqGYNNvyKo0rqBZVvdFtOF0?=
 =?us-ascii?Q?YrvL/5QHwDBIaoVrBEUrZtFbQLyfdHaR6hI1IOU5THyPAZG1GVpQP4qoWSe/?=
 =?us-ascii?Q?MoDA696BZh81/XHPMVE3RQu48eof07lA/t91zES9hu2AJhGji6AxTZCPqkvG?=
 =?us-ascii?Q?xheQaVOuiF4nzCYc1Imt0aKcr7gEGplOUH0eU1g38VraTjwHu7R2ieeXxdI8?=
 =?us-ascii?Q?/dHnzIg0Ocmvw2+VUr7RmXJJc7Cnejey3awcUyOTy1EzkcNZHbJwHmQhbxzM?=
 =?us-ascii?Q?pFaWmGJuG21JBVgIgpEaA0sdtr2FLIEMZbIWGcdWRDp5z8qLZrZ3XQv7bfJq?=
 =?us-ascii?Q?lrz22KLD1kBuzxv7ir5bE5GRnsbb6tUxgNFckzdg1eaITOtWq2+xFo+J69C0?=
 =?us-ascii?Q?iyuwVU7wkPgZSWefSRlOp/gyugqtwtp47KbUbsIfsmK3LJanEKD/XqY3ZOan?=
 =?us-ascii?Q?unLiSZbFMbbFXmlJF6MHhUO3aaB8+eMj3iNXdVeXNR3F5pwu0DlFYPQYYm79?=
 =?us-ascii?Q?J9Vcmbf048nWfJWG2H5JuHiEahWUOnDghZCgA+S2U+hpqnCVfK5AxahK+eOP?=
 =?us-ascii?Q?h3zRSwXTYAoXVqhKDUrfgT1fz5SFTvmvcG6IZx8pd1Tg10HlVJB3EclqTL2G?=
 =?us-ascii?Q?TdaVl8aIk4n/UkrVWeZK5BgXaKsZGe55rZan/9JOalh/SbJmRg2EloRuNukJ?=
 =?us-ascii?Q?OYCa98me4QJYpPK6kWfrYrwB6IG7cnKbMr6jiBZTFl+2LhRcoGrjBSdfp/q8?=
 =?us-ascii?Q?PwmKDi1ZnV1DQRbZAS+Cu8Rp8K9Vsp8ODq9uLRgRkYRBD+dbX+ATwoQf0sEG?=
 =?us-ascii?Q?GkCTUxtNNgYOJO93CXVOIqo/JgJ5uRq88LCRitToY/KFn/9VNJ6n66fEQPLB?=
 =?us-ascii?Q?dL5/NYtBevLeu6C540pkO/DmEZc3EY7mET8frJpVpVz7CNtjd7Ds7jnhjFkb?=
 =?us-ascii?Q?kb3hC5ZAtyoIwL57AcUzkqjJ4AKKUzPfDdcQpePkS7iebu/xH5cGFH07103k?=
 =?us-ascii?Q?Jaiy3kOcGGiV25wwR/eGauvkaF00mUuBc6/CK5HXuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q1YjYsp9kj9MJOGe38ZY1xENBpApO4YGZavCvps66DwCnLk2qJV+pTETTSpI?=
 =?us-ascii?Q?ZorwZbtuKBwY9L64Y0UCsnj7xblOZ/0A62onYSLd77cgvdPV0/47INCsbC9S?=
 =?us-ascii?Q?mZRVBnQlzIJ0LcSPykGD2Sa7dGRQu7sAEo91nGfVME3WWdncqx/xEmE4DMcb?=
 =?us-ascii?Q?bdhLXsow0IUqI3FRJiP4yzbhyNqeN47eKaTicl1pYBWdUo3KB8qEGGtkmdp4?=
 =?us-ascii?Q?XQVkbt800C1JGjWKYfI7fSVJZIQ1hBkHGtADO20KgABAWdNKZ+9T6cl1xbVQ?=
 =?us-ascii?Q?tV6/KFmj1G+AcCirStB+BoPEdI656QUtjOCJsZAjG9pKftIPDsZ+Ys/49c23?=
 =?us-ascii?Q?ZuEFh55a5OgralFRC0urNHuOBFmHUfFZBJoiLmJ6YTBOh5oK26Hi+3nOLbUD?=
 =?us-ascii?Q?W5jmaNNL5exbiXG+Bd7bmYLGCWr0Sq0mBm+Trs98kA+D9SCCVkH0dMf7uaH0?=
 =?us-ascii?Q?MtnAgbuQck1cTQeebivjgu6Wgw7QDnF3xmU4zTusoFcHixvTf3M1nL7podFL?=
 =?us-ascii?Q?xZexMPD7DJe3jUcxhBY+mfGa+XKSoJ3WGndbryCaOGIlFb4V8I+/R41Etf9+?=
 =?us-ascii?Q?4JpE2vSQpVSwEUNtH/ay2UgqyJYqrqnvY2k3REn1iXYkmP36iDfkMcFOR6a4?=
 =?us-ascii?Q?2Ob8u6U6o8G4oXwDS/iOqyx490PqSdxDfAaEg1w5KDc9cGIWlejR15gtmief?=
 =?us-ascii?Q?r48r7FnXmLYNnd8qnP8gkTnkxOeiDlUZD8+WXX6sINJI8vsDCja7fJ9EPGZF?=
 =?us-ascii?Q?4aDl1PsX08L/HEfFncONI7nzkn/Ohi+TXrjb6AgyUwPAldiZRDFrxiOkuWZW?=
 =?us-ascii?Q?2kOz7VNLuqgeF5vBOBHH0Xs6r/AEuXrHf9voJTHw6MxWR8nbHC3HLXHcUlYj?=
 =?us-ascii?Q?pkjFvUUNrBNzclqReTOJhliOD9dC9eDeTXHiZv4Ka70mfJv1Tsg6VAJAlhwJ?=
 =?us-ascii?Q?K/DRETmtkSj5LzXY9Rjrf+YA4lFd7Z/FZkaD4Dy2UPf9VCAhLqjGCSqvjFKN?=
 =?us-ascii?Q?qoBPVt6Fv+vTx/jV6fp60OY24OIIEXnzxIFqj2asbIHFqkAnlU58lDGcu/MX?=
 =?us-ascii?Q?WU4vqc25tDiAX/3tc4VbqMxaLlz/N+gqkj7WEfy43vGWRLbZasScKD5CHRpd?=
 =?us-ascii?Q?XLdlr5OEdGiT2N+TmaTBMZ0SnTGzY9pkHn28vK57mfMV5RIYb4orjw9fpOn+?=
 =?us-ascii?Q?9VKKYxw3hsTndmdIhX7mJiOzZrYb+A6pMUHQX/KFWefXYvXXGP9r1OdDQ2NU?=
 =?us-ascii?Q?SXdqaYoXFpPajj2Xa5xxGzed5C7jawHaKvWHYP2dWgYIn6o5jwpZ2bxq5nM+?=
 =?us-ascii?Q?ssfVb6cdMcc1c65ATGMeBglx5czfTw4VcNgikptUQ0uEurXK5nn22pSFBfam?=
 =?us-ascii?Q?8it7zlmomtGzdPu3eUD8aSmuGqNK1o5WJbjEFua2Br42u2SSRrUEYhras7oo?=
 =?us-ascii?Q?ul9mLTTawsJpwl9rKLkio2UuN4xtDfWjdmTEScQL7ehLqJAFItNANJgqodgL?=
 =?us-ascii?Q?Am5NnWglmPuz4Fc8XXnkUjShni2cZyB0jXHtVdnZxNqdXSl2AIxsdTI+zOQq?=
 =?us-ascii?Q?7ZZEsKkR/ca3ILArc9QIAPmGYoY+1xQnJBlyZbEeRCO+NKPR+t/+TAAKfIiw?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NEn7R0ZaPZh4ETmvs8YkUQr2MWWUUHcxYsYvE+bf0x3sLQ1icggoyj99sCmg/JWyFHbgNQSANuWEjJUuhlM52OgVIJwlRequCPidB9Cu0chveW6/BcB9rDGrRO9GM5Ea1rsgdY5FchVLVgT6WIyRTAEECzSol2cv0dpEK2nY1HbExP3JhczGcoB74eMkb3fCnZeGmfnAGDDGfGdsnND/LDEc7nSjGPWnhshVEnS9bf+xrxph7K85txgnypmvJCHD4/hu1Ly/g4LgaRONW+cY8zZOEALT1cdSaTxhRxyOoue0dnVO+FQCQfg0IVZEMHUtzRiBZYqOxAosrKvdwN9494F+fCSdKv6n0i8XFkjm5W92jsHWUBMW/WKE2G4Ak0Y4pEz/ORHYcNGyYaTzxWtbmtKbrn1ipy1OaAFcwTz6yfVUywtouZ+iT3jC9N/hPC8u542LJ5Uzry+NdlK6Dm+dI3NhkECh/pAc8tEYURkejNegJGXSiWy4JTGuVcfFEqa6eviIqP2Pf9I87zRkDJY5OsoK7HRSnf8hxNBXtbzsxAKzlIM100GX8ikMyjEZnMYYX7yKFbKZ9J7FkWobAKwZh812r/6Ona/6er0oN7+dn7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63514feb-efb7-41f6-ecd8-08dced4dea11
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:16:55.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L48touKgaIqs7/8jNLSHKQMdG6gP6INqqNwchC0t87K6C8Oy1HK6GHZy8U4zhyTlcUab/zidK6ese5QuwIurLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_14,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150129
X-Proofpoint-GUID: rDfez8jCjouJt4m5Kfl0EhPksjUYCND0
X-Proofpoint-ORIG-GUID: rDfez8jCjouJt4m5Kfl0EhPksjUYCND0

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [241015 13:30]:
> Kunit tests to test hash table add, delete, duplicate add and delete.
> Add following configs and compile kernel code:
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> CONFIG_NET=y
> CONFIG_KUNIT=m
> CONFIG_CN_HASH_KUNIT_TEST=m
> 
> To run kunit tests:
> sudo modprobe cn_hash_test
> 
> Output of kunit tests and hash table contents are displayed in
> /var/log/messages (at KERN_DEBUG level).
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  drivers/connector/cn_hash.c   |  49 +++++++++-
>  drivers/connector/connector.c |  15 ++-
>  include/linux/connector.h     |   8 +-
>  lib/Kconfig.debug             |  17 ++++
>  lib/Makefile                  |   1 +
>  lib/cn_hash_test.c            | 167 ++++++++++++++++++++++++++++++++++
>  lib/cn_hash_test.h            |  12 +++
>  7 files changed, 264 insertions(+), 5 deletions(-)
>  create mode 100644 lib/cn_hash_test.c
>  create mode 100644 lib/cn_hash_test.h
> 
> diff --git a/drivers/connector/cn_hash.c b/drivers/connector/cn_hash.c
> index a0211cd99132..8f0eb6acb158 100644
> --- a/drivers/connector/cn_hash.c
> +++ b/drivers/connector/cn_hash.c
> @@ -166,7 +166,7 @@ __u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid)
>  	return 0;
>  }
>  
> -__u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
> +int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)

Is this return type change supposed to be here?

>  {
>  	struct uexit_pid_hnode *hnode;
>  	__u32 excde;
> @@ -189,7 +189,52 @@ __u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
>  	return -EINVAL;
>  }
>  
> +int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
> +				int *hkey, int *key_display)
> +{
> +	struct uexit_pid_hnode *hnode;
> +	int key, count = 0;
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	key = hash_min(pid, HASH_BITS(hdev->uexit_pid_htable));
> +	pr_debug("Bucket: %d\n", key);
> +
> +	hlist_for_each_entry(hnode,
> +			&hdev->uexit_pid_htable[key],
> +			uexit_pid_hlist) {
> +		if (key_display[key] != 1) {
> +			if (hnode->uexit_pid_hlist.next == NULL)
> +				pr_debug("pid %d ", hnode->pid);
> +			else
> +				pr_debug("pid %d --> ", hnode->pid);
> +		}
> +		count++;
> +	}
> +
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +
> +	if ((key_display[key] != 1) && !count)
> +		pr_debug("(empty)\n");
> +
> +	pr_debug("\n");

It seems like you maybe added an extra \n if you print the (empty) line
above?

> +
> +	*hkey = key;
> +
> +	if (count > max_len) {
> +		pr_err("%d entries in hlist for key %d, expected %d\n",
> +				count, key, max_len);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  bool cn_hash_table_empty(struct cn_hash_dev *hdev)
>  {
> -	return hash_empty(hdev->uexit_pid_htable);
> +	bool is_empty;
> +
> +	is_empty = hash_empty(hdev->uexit_pid_htable);
> +	pr_debug("Hash table is %s\n", (is_empty ? "empty" : "not empty"));
> +
> +	return is_empty;

It seems odd to have this change in the kunit change.

>  }
> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> index 506e3cbedf85..28e60c8b0fdf 100644
> --- a/drivers/connector/connector.c
> +++ b/drivers/connector/connector.c
> @@ -308,7 +308,7 @@ int cn_add_elem(__u32 uexit_code, pid_t pid)
>  }
>  EXPORT_SYMBOL_GPL(cn_add_elem);
>  
> -__u32 cn_get_exval(pid_t pid)
> +int cn_get_exval(pid_t pid)
>  {
>  	struct cn_dev *dev = &cdev;
>  	__u32 exval;
> @@ -321,6 +321,19 @@ __u32 cn_get_exval(pid_t pid)
>  }
>  EXPORT_SYMBOL_GPL(cn_get_exval);
>  
> +int cn_display_hlist(pid_t pid, int max_len, int *hkey,
> +			int *key_display)

This can probably be one line here.

> +{
> +	struct cn_dev *dev = &cdev;
> +
> +	if (!cn_already_initialized)
> +		return 0;
> +
> +	return cn_hash_display_hlist(dev->hdev, pid, max_len,
> +					hkey, key_display);
> +}
> +EXPORT_SYMBOL_GPL(cn_display_hlist);
> +
>  bool cn_table_empty(void)
>  {
>  	struct cn_dev *dev = &cdev;
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index 094e1730a4f6..af801c5005e8 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -165,7 +165,7 @@ __u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
>  int cn_add_elem(__u32 uexit_code, pid_t pid);
>  int cn_del_elem(pid_t pid);
>  __u32 cn_del_get_exval(pid_t pid);
> -__u32 cn_get_exval(pid_t pid);
> +int cn_get_exval(pid_t pid);
>  
>  struct cn_hash_dev *cn_hash_alloc_dev(const char *name);
>  void cn_hash_free_dev(struct cn_hash_dev *hdev);
> @@ -175,9 +175,13 @@ void cn_hash_free_elem(struct uexit_pid_hnode *elem);
>  int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid);
>  int cn_hash_del_elem(struct cn_hash_dev *hdev, pid_t pid);
>  __u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
> -__u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid);
> +int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid);

It seems like the change in type should be with another change or on its
own?

>  
>  bool cn_table_empty(void);
>  bool cn_hash_table_empty(struct cn_hash_dev *hdev);
>  
> +int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display);
> +int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
> +				int *hkey, int *key_display);
> +
>  #endif				/* __CONNECTOR_H */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7315f643817a..23599beb9bec 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2705,6 +2705,23 @@ config HASHTABLE_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config CONFIG_CN_HASH_KUNIT_TEST
> +	tristate "KUnit Test for connector hashtable code" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the hashtable KUnit test suite.
> +	  It tests the basic functionality of the API defined in
> +	  drivers/connector/cn_hash.c.
> +	  CONFIG_CONNECTOR=y, CONFIG_PROC_EVENTS=y as well as CONFIG_NET=y
> +	  needs to be enabled along with CONFIG_CN_HASH_KUNIT_TEST=m and
> +	  CONFIG_KUNIT=m in .config file to compile and then test as a kernel
> +	  module with "modprobe cn_hash_test".
> +	  For more information on KUnit and unit tests in general please
> +	  refer to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config LINEAR_RANGES_TEST
>  	tristate "KUnit test for linear_ranges"
>  	depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index 811ba12c8cd0..2c59c82b0b18 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -379,6 +379,7 @@ obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
>  obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
>  obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
>  obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
> +obj-$(CONFIG_CN_HASH_KUNIT_TEST) += cn_hash_test.o
>  CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
>  obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
>  CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
> diff --git a/lib/cn_hash_test.c b/lib/cn_hash_test.c
> new file mode 100644
> index 000000000000..78c39c0a0997
> --- /dev/null
> +++ b/lib/cn_hash_test.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the connector threads hashtable code.
> + *
> + * Copyright (c) 2024 Oracle and/or its affiliates.
> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> + */
> +#include <kunit/test.h>
> +
> +#include "cn_hash_test.h"
> +
> +#define ARR_SIZE	4
> +#define HASH_TABLE_LEN	1024
> +
> +struct add_data {
> +	pid_t pid;
> +	int exit_val;
> +	int key;
> +};
> +
> +static struct add_data adata[ARR_SIZE];
> +static int key_display[HASH_TABLE_LEN];
> +
> +static int cn_hash_init(struct kunit *test)
> +{
> +	for (int i = 0; i < HASH_TABLE_LEN; i++)
> +		key_display[i] = 0;
> +
> +	return 0;
> +}
> +
> +static void cn_display_htable(struct kunit *test, int len)
> +{
> +	int i, err;
> +
> +	cn_hash_init(test);
> +
> +	pr_debug("\n");
> +	pr_debug("Displaying hash table:\n");
> +
> +	for (i = 0; i < len; i++) {
> +		err = cn_display_hlist(adata[i].pid, len, &adata[i].key,
> +					key_display);
> +		key_display[adata[i].key] = 1;
> +		KUNIT_EXPECT_EQ(test, err, 0);
> +	}
> +}
> +
> +static void cn_hash_test_add(struct kunit *test)
> +{
> +	int err, i;
> +	int exit_val;
> +
> +	adata[0].pid = 1;
> +	adata[0].exit_val = 45;
> +
> +	adata[1].pid = 2;
> +	adata[1].exit_val = 13;
> +
> +	adata[2].pid = 1024;
> +	adata[2].exit_val = 16;
> +
> +	adata[3].pid = 1023;
> +	adata[3].exit_val = 71;
> +
> +	for (i = 0; i < ARRAY_SIZE(adata); i++) {
> +		err = cn_add_elem(adata[i].exit_val, adata[i].pid);
> +		KUNIT_EXPECT_EQ_MSG(test, 0, err,
> +				"Adding pid %d returned err %d",
> +				adata[i].pid, err);
> +
> +		exit_val = cn_get_exval(adata[i].pid);
> +		KUNIT_EXPECT_EQ(test, adata[i].exit_val, exit_val);
> +	}
> +
> +	cn_display_htable(test, ARRAY_SIZE(adata));
> +}
> +
> +static void cn_hash_test_del(struct kunit *test)
> +{
> +	int i, err;
> +	int exit_val;
> +
> +	for (i = 0; i < ARRAY_SIZE(adata); i++) {
> +		err = cn_del_elem(adata[i].pid);
> +		KUNIT_EXPECT_EQ_MSG(test, 0, err,
> +				"Deleting pid %d returned err %d",
> +				adata[i].pid, err);
> +
> +		exit_val = cn_get_exval(adata[i].pid);
> +		KUNIT_EXPECT_EQ(test, -EINVAL, exit_val);
> +	}
> +
> +	cn_display_htable(test, ARRAY_SIZE(adata));
> +	KUNIT_EXPECT_TRUE(test, cn_table_empty());
> +}
> +
> +static void cn_hash_test_del_get_exval(struct kunit *test)
> +{
> +	int i, exval;
> +
> +	for (i = 0; i < ARRAY_SIZE(adata); i++) {
> +		exval = cn_del_get_exval(adata[i].pid);
> +		KUNIT_EXPECT_EQ(test, adata[i].exit_val, exval);
> +
> +		cn_display_htable(test, ARRAY_SIZE(adata));
> +	}
> +
> +	KUNIT_EXPECT_TRUE(test, cn_table_empty());
> +}
> +static void cn_hash_test_dup_add(struct kunit *test)
> +{
> +	int err, exit_val;
> +
> +	adata[0].pid = 10;
> +	adata[0].exit_val = 21;
> +
> +	err = cn_add_elem(adata[0].exit_val, adata[0].pid);
> +	KUNIT_EXPECT_EQ(test, 0, err);
> +
> +	exit_val = cn_get_exval(adata[0].pid);
> +	KUNIT_EXPECT_EQ(test, 21, exit_val);
> +
> +	adata[1].pid = 10;
> +	adata[1].exit_val = 12;
> +
> +	err = cn_add_elem(adata[1].exit_val, adata[1].pid);
> +	KUNIT_EXPECT_EQ(test, -EEXIST, err);
> +
> +	exit_val = cn_get_exval(adata[1].pid);
> +	KUNIT_EXPECT_EQ(test, 21, exit_val);
> +
> +	cn_display_htable(test, 1);
> +}
> +
> +static void cn_hash_test_dup_del(struct kunit *test)
> +{
> +	int err;
> +
> +	err = cn_del_elem(adata[0].pid);
> +	KUNIT_EXPECT_EQ(test, 0, err);
> +
> +	err = cn_del_elem(adata[0].pid);
> +	KUNIT_EXPECT_EQ(test, -EINVAL, err);
> +
> +	KUNIT_EXPECT_TRUE(test, cn_table_empty());
> +}
> +
> +static struct kunit_case cn_hashtable_test_cases[] = {
> +	KUNIT_CASE(cn_hash_test_add),
> +	KUNIT_CASE(cn_hash_test_del),
> +	KUNIT_CASE(cn_hash_test_dup_add),
> +	KUNIT_CASE(cn_hash_test_dup_del),
> +	KUNIT_CASE(cn_hash_test_add),
> +	KUNIT_CASE(cn_hash_test_del_get_exval),
> +	{},
> +};
> +
> +static struct kunit_suite cn_hashtable_test_module = {
> +	.name = "cn_hashtable",
> +	.init = cn_hash_init,
> +	.test_cases = cn_hashtable_test_cases,
> +};
> +kunit_test_suite(cn_hashtable_test_module);
> +
> +MODULE_DESCRIPTION("KUnit test for the connector threads hashtable code");
> +MODULE_LICENSE("GPL");
> diff --git a/lib/cn_hash_test.h b/lib/cn_hash_test.h
> new file mode 100644
> index 000000000000..46fcda31b25c
> --- /dev/null
> +++ b/lib/cn_hash_test.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024 Oracle and/or its affiliates.
> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> + */
> +extern int cn_display_hlist(pid_t pid, int max_len, int *hkey,
> +				int *key_display);
> +extern int cn_del_elem(pid_t pid);
> +extern int cn_add_elem(__u32 uexit_code, pid_t pid);
> +extern __u32 cn_del_get_exval(pid_t pid);
> +extern int cn_get_exval(pid_t pid);
> +extern bool cn_table_empty(void);

I think we are not adding externs to headers anymore.

> -- 
> 2.46.0
> 

