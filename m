Return-Path: <linux-kselftest+bounces-19931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A799A1CF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 10:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9894CB2101F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10990199944;
	Thu, 17 Oct 2024 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxxZJsUZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="edYlwgPo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B663398B;
	Thu, 17 Oct 2024 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153139; cv=fail; b=O1OeM3XO6esfuILorIqP5BctCYnMN7eqE8KUREgQFtQ41Kyt+63b+D4jBhlMrrvGSBr+mV0FZw2vKg6fwt3ysSS3xJgnKwpQvE3C3T4OmN6cjl6jnNDVYkYmpKeZTbo2Eo4jvwLkdHk20PfuI/PqhrGyScafWqqjU7NUEzghS8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153139; c=relaxed/simple;
	bh=Ftsh9m2DlpU61z8RNMuFEg2De/SSmhMje58rPEj+bKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DjwLkyD2xglYsvmapJ49ZOl69dYgkNDaefEaFSECbrlv+GgGVl4gzafhPvkd0Ha7A115+C177OZcgwjr2RE6mvyh4U6bBjCaTCJ/Tph0iz4aedTIrqGmhxbbZxuq3UtM6+aDLBACFDIsVk4ship+FtwWHw89WKQBjN99oTdNE4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dxxZJsUZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=edYlwgPo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7fh4T008517;
	Thu, 17 Oct 2024 08:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Xym90imXt96EU/8l/u
	X8Dav08I+9ggZINUoKrQTohRs=; b=dxxZJsUZKgqT8fltoeWh/spGMO6IklRSwe
	dsHnTIZ4QkMpxAZlnYc1Lo1tbYC1yDrzzSq2gCgVNgCBa46CEe6agCc+36K1xyqC
	5V9+022Hg0I1/9G8z5wWUYsAY6IlYMOY8W0rvfaUDlhpvED3WQ+jn2ndY7tqchju
	EuMl/DUSaHtTHHJ6U2JbMN9baOujQBPsg2MlLGVMOQwuvmGj+us7QC+r/eU/7r5m
	f4yuLEFIeJhR8bIipihJF1L6ucDHbrzf5LEFsM8BsEI7m7ATiIULSUveZpGBFIjy
	ZzZjkrds5Y+go1RF2x3hlw7RuMaoajs2qJBLZjJGKIz20hvilZRg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1anh8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:18:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7t64F026420;
	Thu, 17 Oct 2024 08:18:27 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9w9nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M27wKzmTE2OMe3f7RG+U1r+8ehoJsNxoQCsvAf1qVWkFFV5lWEbownd1ivtdTpjRrXRiRBQx6JffY9pN6Wq9NtdrRV4QFE7WI+rGy//xdKoRbt6+ygS40CIIMDstbbh9tgrFXbuxUOJkZDsL8qUvKgkYmUgKpMqeORHxFt3axN5HqLviaZ+V2wur/s6PtSiEUpy6hMePjs3ZtTfRg8xRW7JOyS8KELFEfyvHAZT1kKDAv6hfiRwldMfyMcmiXfQaC208KYuhx41qDk+tpwaNGAidTCZEnhRfbNVx7TAT/UFu0aGrTx7Q26AYC89wcoqHT/4mrgDTmhAbwl1/wPx9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xym90imXt96EU/8l/uX8Dav08I+9ggZINUoKrQTohRs=;
 b=ZuE7ZIXhMbb/NBCIIMhQYj9fj2aJ2p6OmJR+kN9wumvmQQJMYb/W33CVWHb45khk4+UGTacMOzoAmksg6CgmQuJ5KUbQ/kFglTGZrC6PIpCyMX731OgbzQwsOtuqTv+kXeWKCsqwXmsZmGcRiG1t9G2aLrCtDy50ISts1ip+A3G2Cmq2j4L1QzXHlogmLGpVz0cb3f9LSZRjb08ylJ463iggxrlGiUpqgUWWNUyPnARiVsHvQKmSpGALdvab3RfyaMnX/UhnoAmmsXDr+xbmF/bnu1pjc2vNawG1f+6dmBxFOexF8J0giNXzCz835It3cBMwlobRA29oT+xDKEHb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xym90imXt96EU/8l/uX8Dav08I+9ggZINUoKrQTohRs=;
 b=edYlwgPopI8nz2pLOmrPfKbnk1erx8QQP9/KbiXm58h7KyIw8RNKxB0xAuajbYWUxwsow1xVY7pd4oY1Bk0Lr0YWC83pLcqBBe4g+ve2xxSdXMeCOXr48FjGk4Tjw60EDGoYjXwNEAeicGE9FYREUUBKkmjsejxgD51Bri+VoKA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 08:18:24 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 08:18:24 +0000
Date: Thu, 17 Oct 2024 09:18:20 +0100
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
        surenb@google.com, merimus@google.com, rdunlap@infradead.org
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
Message-ID: <3a1bbbdf-1281-4f44-857d-58cba583e3da@lucifer.local>
References: <20241017022627.3112811-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017022627.3112811-1-jeffxu@chromium.org>
X-ClientProxiedBy: LO4P123CA0160.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM6PR10MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e96f28c-6229-4d93-036d-08dcee8444ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eAm9JiQ4U72ISjWnUBRoKjyy0q9vJrwVg2/89cxI0Pht1A/JuxOa448MCLQY?=
 =?us-ascii?Q?H8xCtjHa5CXQjKoNyc5BP3KIU6CpWmooptbE1CogWYfOKxL83elT29l0c10M?=
 =?us-ascii?Q?fAOi/cVw8TtIBzAhGjdf7x6Fp3OmllULIAA+Xb6ECjAVnwCuRVwaDFXc6GxO?=
 =?us-ascii?Q?6NY05/3jGQhiZP7+fVA41t9DIh9VuwkDZiuK3C9nDWGHaK8eki9dqR/ytOIn?=
 =?us-ascii?Q?LFapngYCKTWcoK94E/v1vKoSE0ExB4PT9AQvZcRYxOLXeCkaM5IDFKL9JlgD?=
 =?us-ascii?Q?NIBrttRxxB3MztELmzluBQU6xbKk9Jl8CSIXtqHNCnt6LSjKAuqowM0D++pV?=
 =?us-ascii?Q?uvXHoTxlHkdOWl37qQYB7hTG5EZtooMfx1oIvmluMYf+ELdTIpaukAoChS1q?=
 =?us-ascii?Q?K5xnzOty1nExs6LZVNhEU/pXnWkRwXLyHc6gBb8OHunxKjiNpI9Kq0ebw1hj?=
 =?us-ascii?Q?5CPRbJx1yIpR2vTaiF0QrBOH0TGiRJpJfG4wgjVan+jQ5vX/iZwdZU1xEtlp?=
 =?us-ascii?Q?9pQV7l9+yVUmSELfQj8dzec3NAZbY8wQuqrZ+AzuES+6OZT/6+A5eO8MhAG0?=
 =?us-ascii?Q?z5NWoVsP5QvS5VAo0SY0brkQizm6Mp64O1nPwcyYLq92zNyUnC4HeDpsTHJZ?=
 =?us-ascii?Q?5LpIfwUpw5cHRuCR1OqJBIWDzOLsAOeeXKLhZyy3OXUT6J3AVAlGp7QfJLLX?=
 =?us-ascii?Q?+fi75/xdjLsqMBWE74te2al9gxhjt5hsXpBupsd784EZWYS/RAZDc+obKO1b?=
 =?us-ascii?Q?K6QGVG6oQJrFfyWGk5UMbigSS6AnbA0Zuhs37SHMOJBdhFL2k6XLI5yKw2Xb?=
 =?us-ascii?Q?BhkSXCtlNcf3h7b2VABkWU7kG3+1LBp7ET6qLI+lddqd8LPnySPtxpaRteAe?=
 =?us-ascii?Q?qlL53al8xa4fJeZbeuJM1qqOkGu3TrzSifXUve4ZSm9F+2aV6SDjcVXDJp2r?=
 =?us-ascii?Q?wiSqDSypkG0gjG/AlkRIFHcziREQA8058CJZWxE4iRP889o9X6NBmgzOS3NP?=
 =?us-ascii?Q?OjcebsKFbi5mvYSj9qnBAa1jqAnmTLbSV90uQ17YDmWzivxHhlzoYWltc8FG?=
 =?us-ascii?Q?u/jjDmr1NrUyQ582n/NXVjqddEHdDB7+eg0i2kRiXH0zWOkZX18OXZKZwg2A?=
 =?us-ascii?Q?alBjtzgIZqTDFtYMH7GnIjeZ3zGeqLmsUr63Y9gWAURIHn7J0vKKe0wNbaPZ?=
 =?us-ascii?Q?SbzwmWQ7+A8UoMv4TIsbXCHZYzXwD+9FU2FfH4uv9+fZorXT760lGFPO26P8?=
 =?us-ascii?Q?ho3pqFnbbqt9yNnjPaw+owLyzJkPbwWT4whGjT4PxK2A38J656BBcX4qUJNX?=
 =?us-ascii?Q?S23WBcrjSSZxVfJ4g7vQy0/G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fucXiU5d7D+yQFYNbsok5yQ+XLGSRRTNoMcFE8WZ6x1TsC1+J954kKo09J6R?=
 =?us-ascii?Q?tgIzH+kbxdRB3UMw9EGQ83jJDPxkIWivLDGYQOFkcOJlFJFs6rOtdSu3p2A5?=
 =?us-ascii?Q?oI/U1mCQEPjVRPWHB/HzdtkYoGpg8o2kebVUjYvS2MVLftGQQGQFpZLOE8l7?=
 =?us-ascii?Q?BU6rAGF2l3lZ8nCK70MWrd6RW5QJNuXWr6A+zubYkhihxYBa9ZcYG3bpJzQ9?=
 =?us-ascii?Q?IAuT/YnP09f0TFsQmq0aNZ+hdWNK5GQqK3WQDolRwtsM9S+k9y5yL5KDCq71?=
 =?us-ascii?Q?APFGSDbnpSi4Riy7+UHVztt9y3fChf1116kLgfgtoPAwfYAkVtIu0Jcl7vE4?=
 =?us-ascii?Q?cAUSfURUfOhY3iK9F1hCT6DuIYLYRknoxSz763OxdAe4cWkLPfNBgqHbMLWJ?=
 =?us-ascii?Q?J8eg2wDq48Wb3HL60EEp7XZwsNU68m4oywXl1/4w2+HyTHRrjbr6KkGQwf/f?=
 =?us-ascii?Q?JxRMIQ3MgUiawJV/uR14D8+r7RXQVgzMXPtXMzD1rNnqVK7xeGBAm1DaN2Ve?=
 =?us-ascii?Q?UQlzDp4UU6TQNByyDKuOo0mE/vF4HemMEYlE/fgjrpnSB5NPUj0VvvmVTPbv?=
 =?us-ascii?Q?unBCwUlWNZYXH9Fo1w3rZw4sazMWnfdhbUibhjLsMGHJBkIZKkGUp8CkuGxX?=
 =?us-ascii?Q?5u41TIDMejOvU4kTuXrRqwHW/GdJt0gsE1jYB1SOur+Wp5ZnBTcnBt9+7St6?=
 =?us-ascii?Q?aua683GNXoaH7hXfXDbzYXB/B2xgcae8Bu3OQoqbRFtpqe8/JDdSmy060CQb?=
 =?us-ascii?Q?oktForDkIe4PmAn/sL8x9gam/oTfakOFY9Zwh09xK3T/Q0r9XBrrK4vzHWmZ?=
 =?us-ascii?Q?PYzehFc7+I9vlpZm2p1s24vuhrrnOLPsTiJOhY0gpvB16GTJVJ1/xfymJ1i0?=
 =?us-ascii?Q?TMfuJ5j8d5tFplsPwnjk31GRcMU1OoZP4z/bnK3oHQdKO8PX0L/hzu63VBHy?=
 =?us-ascii?Q?QgEat1D/DCQ6JzvOM7m/juJChld5wnNlyhDSAjZ1LbksfbFL4ZhR//K3EAqg?=
 =?us-ascii?Q?IjAR7k8oseb0H1z8EWg2LXEw0wtkfz+3jw632US3ZD1kPLTbfev1+Js0WtuI?=
 =?us-ascii?Q?xUC7oSx2nXaoUxR+kLyc7Sk69PZOYiXb5XccWWi8SoymYUOF8NrUmIHTUoup?=
 =?us-ascii?Q?lHocCKtZT3IzpsCd5Qa33tNSAibGEyHCx3lXR0sPJlzQYjrje1J/U0u6MvAK?=
 =?us-ascii?Q?JeW98WZYZOLXCjLhf169valtYqddcuEI8gd8xJ9T0VwIDDqfCr/4JRa+ah1R?=
 =?us-ascii?Q?3/3wSgkKTV4fWp6y38c8DWQmWE0jHibXx54eJKdNMG44YRHK/opoSEYk4Gdc?=
 =?us-ascii?Q?/pWEA3SMJYya7AyMFKNOcfpo9vpwosrRb11FeaSC91b2Ji7d6icbDIu5du6G?=
 =?us-ascii?Q?yDjmNMvXzcO0eSTqWyhyNQg0Pqi4+7W1UvHVjGTy8aTI7YUI+MlRR9sPF9Fg?=
 =?us-ascii?Q?J0jekv1s/pnXBZ3Hgm3o00O86kFy1muRzXNwp36Ps9Sicj7MxdHVUscmQzt1?=
 =?us-ascii?Q?7160cCCnHQFpgxAnWbMSKfMq7GUvgeUhrVBiKnGfkqmlQCBUJT2i4UHwY0ok?=
 =?us-ascii?Q?Zkjv1f5+4Wgurv0xHGvJC3nlCoyBH47sQPz0tkBXmbPTShh7EqaQMkmHA9EU?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W9CGFZR6arDKosM7ZAtaWTnS1zMEuUGlo03EuI70KYU5Za9Wk3WPe4fCIYPNiKk9XF91kj/rNRhV4p7wQGmHq/qha6Y0c55HqZ+b0bYcmGZKqN1eFr60rdFOgUUf32FzAe5esW6P64ccIx4KDiFx1PSPGjUT8dYeO++17TCwBIKwAAhOp1F3nzwwGfgGn3QHRpmmrhQeAgJAmjSlzh4+D7bq+tDGydZdbEP7HpXj4TVxbsLuo6MVu9+HLawn5q09SRyRobAve/0V5BiDI93UwUBtV3IpTJL00ad1+cj8xTinfZ3vsnx+Tf6f/epup/7urUFIZjdWdoMY0Us1KXHshuBmIs3bMD1WFMLKkJvA8l45GB9ElFCIrCgcQkUJx1oOdLu6iBWt9LKQedeuuw7uSRBUSyGHRpR/ZQ6Fo+sUvnmZtyIyqvDjmZifFmB/GTq80hKVSkpcnJi8HnNZ9+D/ibcHXeo6uuH1pwU6lKTojZAUg0RFMtGo5THrFoOek1srLDtAwcXq0ePfSxQyPxYgwQb164x1nsyw4b7588HpfbzNXyP6zi3C1OL5YcSszkmnuszkko3lrDR2Hodf2/Xd0kCesrGxCu9TjAvD017rnnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e96f28c-6229-4d93-036d-08dcee8444ec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:18:24.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tocqnhNsj2NNccYqXhv9LB8kz3UsUzmGYs17M7PuSaGXVIp2uEmhxatPW7TzY0QHqhJb39wTdyH/rXwoSXfNtmbPTZkbmwN4dcHQ5q798GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_08,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170055
X-Proofpoint-GUID: d1C6K2A5yT6dHV9c1ABwlzyXRyLTjFiy
X-Proofpoint-ORIG-GUID: d1C6K2A5yT6dHV9c1ABwlzyXRyLTjFiy

NACK. Greg's bot got to it but...

As per Greg's bot, no signed-off-by line.

The subject should be something about adding a test.

You later say you are somehow dependning on things (what?) to make this work but
it's broken.

Jeff - you're doing things that were raised on previous reviews as if we
never said them. It's starting to get annoying now. Please try to listen to
upstream.

On Thu, Oct 17, 2024 at 02:26:27AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
>
> It appears there is a regression on the latest mm,
> when munmap sealed memory, it can cause unexpected VMA split.
> E.g. repro use this test.

This is an unacceptably short commit message. You've been told about this
before.

> ---
>  tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index fa74dbe4a684..0af33e13b606 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -1969,6 +1969,79 @@ static void test_madvise_filebacked_was_writable(bool seal)
>  	REPORT_TEST_PASS();
>  }
>
> +static void test_munmap_free_multiple_ranges_with_split(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 12 * page_size;
> +	int ret;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);

I'm not going to accept any test where you do:

	FAIL_TEST_IF_FALSE(<negation>)

As that's totally unreadable. I asked you before for justification and you
didn't provide it, no other tests appear to do this, I wrote thousands of
lines of tests recently without doing this - stop it.

Also referene MAP_FAILED here please. You've been told before.

> +
> +	/* seal the middle 4 page */
> +	if (seal) {
> +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);

Again, you've been told before, stop referencing numbers instead of
PROT_... flags.

OK I'm stopping at this point, you _must listen to review_ Jeff.

> +
> +		size = get_vma_size(ptr +  4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  8 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +	}
> +
> +	/* munmap 4  pages from the third page */
> +	ret = sys_munmap(ptr + 2 * page_size, 4 * page_size);
> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  8 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +	} else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	/* munmap 4 pages from the sealed page */
> +	ret = sys_munmap(ptr + 6 * page_size, 4 * page_size);
> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  8 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +	} else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	REPORT_TEST_PASS();
> +}
> +
> +
>  int main(int argc, char **argv)
>  {
>  	bool test_seal = seal_support();
> @@ -2099,5 +2172,8 @@ int main(int argc, char **argv)
>  	test_madvise_filebacked_was_writable(false);
>  	test_madvise_filebacked_was_writable(true);
>
> +	test_munmap_free_multiple_ranges_with_split(false);
> +	test_munmap_free_multiple_ranges_with_split(true);
> +
>  	ksft_finished();
>  }
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

