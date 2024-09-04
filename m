Return-Path: <linux-kselftest+bounces-17095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC5A96AEBA
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 04:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE76B22F7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FBE39AE3;
	Wed,  4 Sep 2024 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f/XliQw7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eB5VCJKu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991B15E88;
	Wed,  4 Sep 2024 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417858; cv=fail; b=fbHCql+MESC7K0w/HtoJqRaguZEdNeHqPb4UJg6mHrd3+p7gpTBCxLJCEPrkTa80PxlZOTemtMe9fyQY87P8oD/7Cqv41RtYkkW65iaDHGik/EwsapynUtwo7Ct9DPLWvBq4TzTglznxzuHVhjUAeTA9HxgvinRGyyq+bfM49iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417858; c=relaxed/simple;
	bh=6BUO+ZgPcIhwWiw3nx9Q1eetj5s7RZsVbyg5hkZG42k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ScFVYFU91X7KQVKKvyEmM6JmO7oHNZOAnFAZSPyBSCaPO6JkfOSuCw2hQAP4YOstFxCGYSYGjdFALlyqwKVY+USzxR38v6n/g/XRcYwWx/CitIbK/z36iGQiawZ45V9RJEoa5kcyOxWHNqe2TYkd7iBOK1RwKZjivTKYEkowgyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f/XliQw7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eB5VCJKu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4841MYs2023291;
	Wed, 4 Sep 2024 02:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=HT+cK9NLqbpRbaF
	HguGiDRjBpUFHOrvLnWA5u2jtAkI=; b=f/XliQw7LWC1Hh7DcwxwPwfnyNi3Wah
	ONClb78tCMYy4m3SzG634VsPhRloLNs2AcobpSTPhMBoiotr4dYpRwdFTN2fI558
	lIWTBwa+l21wMZY7K0aYu8in4qTSH23PhXop4syio8lciEPDhzYxZ8pSSDK1yFdq
	mr5ToBAX4/MONSG9tu5nubN8R4r/lnDC6PL7tNX60H8kbWW9izaLAU7wcRis+2SD
	DYUZKqW8RYNA+3GpfVfCVgP35X079+XjK6xpMNL0wUG+WuKSBHxRo/kTE2FcFEyJ
	0miVvhT4SbroEwVpehzUsploojvbMCu6Rvq8sob3N1F9TyQShPAz+Cw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsaabgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 02:43:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4840W8ff023561;
	Wed, 4 Sep 2024 02:43:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm90bwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 02:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZv4IpbPHHsJqA1hfasvqCNhzPEKb+TGMtjjD/diTihjeF9qVKL6/mpKNZnhShxkWGUjF/C+34wYiWRJGPhVK7FJE84VORcBLdffYqsRKpQ7pUSoBaROlSgsIC3554L0Ue7gHWYS5aQGMLZu0tvrgz8sRPBPuGtlhiWaMJir+4sALceJwLaBxmzPEW0dKj+lkbFsBU5Fl7dzsaH6zE4eZvlGLyPYyXijeDtPlT+lZfx9XTyx+BTKUOUZXglYGALm1bhr93Q8XHDoUlZOC2uAJVNdFpuZiYQxgkeIIyt9DBR5PvfuuCAjcD/SejXyF1Tz/RYPSE+rVawAVMwVz8Jsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT+cK9NLqbpRbaFHguGiDRjBpUFHOrvLnWA5u2jtAkI=;
 b=wezZCAWvsED3wiCFz1tQbDCjaa9M/SnpL07D4ExgmoO3leyhUfEy+PMM7PcteLrXDKg2z0+EOnbGvYM6BCrKrU9QV/+pkoMFCp576FVDJVuYOVYlVR97CGZ+ZkSHIx9loTS9chXmKpu07fTJwrIymm6XOZVvDO4umhKSRsq/FEHYUmp6lWmkazxUnlVjgbGD5I7DvTcY/ktFoUTycTWGYuGEnzXHVxiafM994A6o9tZHcueHNDlL2iOafmj+GDJOtjGa6bHTmOVRPIEYAilf9ZEBxyOlEaGsU6U7uoRAZj7yjJL42Jq7gQBvzurMdYGRU6RL9ujPBSjr2JKQ4gM69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT+cK9NLqbpRbaFHguGiDRjBpUFHOrvLnWA5u2jtAkI=;
 b=eB5VCJKuab0PAguJAKYk6LqupLddQCmX8YxFCLf+NnIEd1sJWOzWFNSChHo6oKGZACPYW/7mG/F/wdkrt6JMUfNYdZwZek6MwlTMuDmDz9O/PparTzcWhKWo9TAac4cJeDiW+qS7eT19gQs9I3A7GLvK8FEag52CnbG5SAsG9WM=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by PH0PR10MB7077.namprd10.prod.outlook.com (2603:10b6:510:286::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Wed, 4 Sep
 2024 02:43:42 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 02:43:41 +0000
Date: Tue, 3 Sep 2024 22:43:40 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
Message-ID: <z7xkdvh6hfjxbt5nazkyxnpuztu6c425rucs2trmwqlfu7ywpq@5w3g7wpsyuji>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Guenter Roeck <linux@roeck-us.net>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904011840.973-1-sj@kernel.org>
 <ab03b853-07c5-4997-8983-68e547e3c873@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab03b853-07c5-4997-8983-68e547e3c873@roeck-us.net>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0429.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::19) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|PH0PR10MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: a185807b-da0f-4573-cc77-08dccc8b6344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xStwDFd0XxfPoVCPLH8hhmxB6UuWA9bXUbHqE5Nc8f0S5xweRA2otlGVyoAA?=
 =?us-ascii?Q?WqaTkmh6saLBwoLYDOQNjTGjXzUqfxH7IBlvarQhFTXKOIymDUJjUYG1PQPu?=
 =?us-ascii?Q?0QZcF0n9e0OhFC3wzT3L1leyK9UfFOIgfkIguHCjBzQZwXX3iONzlkaB99t1?=
 =?us-ascii?Q?z61AD7XtZR2KwPWk+iKqCAMNgrWUfDwsrZvXeY3jJBDCrqpILKE+UpWSCb+M?=
 =?us-ascii?Q?lkvckKsxTiC+ci2nR9dnUoYk7C6EVCatiOfMz9sx94iRtmSwYMbS+mcUGc+I?=
 =?us-ascii?Q?T707jSLU0oeXQRBhdzJYrrVGAGgKYBtVT7Zp4tEyENLUUMMo/5x5PI8GsU3L?=
 =?us-ascii?Q?6NppuCor9ldCm7jkLpmYztkgv5Xo0JsmfYmCL0/zJSzIvc52TsQsIVoL87JJ?=
 =?us-ascii?Q?36/aYhdFcPoGxkwBgcQmU0wLjVTpZHFDWcnuuvWPNkkk8mGlXkmVd5NSNYqx?=
 =?us-ascii?Q?pnsHwE1MDOHqedUPbGtSFNoLjiWgEq+S8ht7GFfD+o2gwno1/DL00uPdpIbM?=
 =?us-ascii?Q?JU932ptJhjc+hb8bl4dijrtxZlnBAm6vSlrjmoxmWqSnTEqWTgYXfAwsi74t?=
 =?us-ascii?Q?x2YZsaVMDVi+rHHH9v3rkcEaey1AD1s0ablFGN8cRSaos4o8sTu1Uy/OxXfy?=
 =?us-ascii?Q?psrV4f9kwL0azB8sMmdBxrwHvPTD33F9e968q6uT3ivqpjiXv+4ZDgUgFS2r?=
 =?us-ascii?Q?WDHmxrscBrkDwvADtYuAApCu7i+MmA3fCXv8MZlZoDinzpz3LUXy6Uci/Iy+?=
 =?us-ascii?Q?QtPzyjZq77z8SQHwQRyZLNRm7Bq1M6aTfiZb8ZdqSM5zK2c5/Ap8Lb47GgH8?=
 =?us-ascii?Q?bbvatLxkToX+u776uIzsMD+JxOI2k2Lbe0W3lhRgwU4StolXazc9xa7CmKb1?=
 =?us-ascii?Q?7M8P/xDx+M0MC6FaaQB+5GHyNx5rRIZNEX9cGGqwPQEOqOt+LWHvpn7hl1By?=
 =?us-ascii?Q?V1rgQiziBbjbMH8iRFPsljasRtqPQKr8rap0MYhz5xnRvTDJsEfSKWm40lVh?=
 =?us-ascii?Q?oQOIvDJLyRFdYkJJXKntr4lc8Jr709icm7eHij5c/Iq+CbInR+XFjyA1lZo+?=
 =?us-ascii?Q?jV1WZuLEfKe0wWKIzgiz+1cTZN79GZGsS7oEjzHsFmNRckQg1nR3TGi/Sis3?=
 =?us-ascii?Q?Y8TzYLd735MHqAIg46tsvKReyN0C8CsXUuGJb829gJ8hiZEuhgQGLtTXVZXx?=
 =?us-ascii?Q?YFJbT+SozPXQuSuorI/eTl0dJNvzz8ECHv2I1/gPxwMhxmy2UuCAnLMh70b/?=
 =?us-ascii?Q?1niXwwrl5i0OXietQbxQukUKJHiYE+jABKi3PChQrXfddvM57dQRYBbfqavd?=
 =?us-ascii?Q?4ocFmwPGe+Tl/KBTbfLhgsWmuGHe9vB7zx38uBKHLlz0Mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AhsaOM/92k5ZJV52ma8vLpCeTVziN1/IH1nLnjrcBPwJl98w/Sc0TiWEwzvy?=
 =?us-ascii?Q?VKlQKJcj0zm7lkGvzLZHqjcIWSjBgIMWCCIGnNr7bVucc+iuJQdxJ0PV/Rcw?=
 =?us-ascii?Q?TuZM8Nq+SR7U+IgiIAPFyDvS/qNuV5dXot6DK9qPUGb3I3YXTc3e7zgAVoLx?=
 =?us-ascii?Q?uzD49CpTTdlE5IIz/k77y4OxJXsMabdYMqhKGFcjFPx8Gm65RzwXp9QJlp5h?=
 =?us-ascii?Q?VvGi3/xtBKbvqpgu7lsG0RZccf79UDQZCsic9saN1kt5H2lEJJX139EP67KM?=
 =?us-ascii?Q?t5O8gfkTRR81/MaiSLHEu5TH/ilpA4xziLrzli6LD9UgJ0D/Un6T2NAExbOQ?=
 =?us-ascii?Q?C5nauV6/52YRcZQrMaKMany5yw0Uv+qbiq0vmt5W/f/943c9nFrWjiGZ+X5S?=
 =?us-ascii?Q?gdtBxDCQHc3kNqDrcbRha4gVJuxMc/BxG4wLYu5scoIF/B5trEs8gIWgM7aq?=
 =?us-ascii?Q?nRTYGzNu2h8QGNOI/oqQCNLts1m1ITsFXB7mTgyB6rbT1869LRMVxKriSXb/?=
 =?us-ascii?Q?Y7bIT+E8WL1qqTFDCNX6/248Ap8ZxwYAI87R6mskxf37T6lpc+aCig9kFDoM?=
 =?us-ascii?Q?VQ8SeOGnByoNkngDv5fymrdN2dNQPritjwb74NTA/7NcIKbAAK9rR3BSyvrH?=
 =?us-ascii?Q?E6uUYeB1qTC9L+0kmlftxZBDKp6pEkmWLoJeJcCscgUdywuzpyVwVLlBU/Zu?=
 =?us-ascii?Q?It2IBqCYKqARlESEbYiTirmBsA4EybexjttAsEK8VYzFv1IbIJXm+AukWBKF?=
 =?us-ascii?Q?kw3YdyMRJmPWg/rJT4EGckftJLjpRVftupwGAeo5IQ5M+Cr+CjQcIY3DAPRr?=
 =?us-ascii?Q?hlOj2JLeGbDE8Bs0oOwisn3UZ+9n6dgAaOmS4ODgGDHOsoBld7CQpwiVfs9M?=
 =?us-ascii?Q?5HsIjyoA/aufH2SQWGmrWlwdCNQ2/6XveJCTxYZoKnKao55S8HnMAGEsmPWn?=
 =?us-ascii?Q?TgqSK0QCjz6TEknQkzf9zKnOSXGiC70GrzcYUwTmUxQx5FHm6AL86Zs8Et8c?=
 =?us-ascii?Q?v4YAyAziI0Y5azMMZ1zZ/YDtBVlpRLTGu7Xgrn8sy8U1hJxBDXGE9twdGnzv?=
 =?us-ascii?Q?XuHNPbRBsBoFkSRF68+xwCxgxkYRt9rqt7ESS5WlQibs7KM6eeflJ4px8Ltm?=
 =?us-ascii?Q?s1PFtVPib1D8+btPufKcsezdmIVVbCfDle/dCn7ZEC3jw2hF+qEyJxk8Aq4S?=
 =?us-ascii?Q?k1rGYGXGEteUsDtiOD9TioMalPxNwk9sTnzqoQF5QPKV42vhKYMxYp0o4K9b?=
 =?us-ascii?Q?bTh9tDpbk1UZeVvqgc4dF0d+qJOiQmtPAOlQ7P2qQRxTIFN1kt5lTZIqBRfP?=
 =?us-ascii?Q?u0JAfKg7UrQR9hZBc89q2ddssBpwgtwmPHXXKK28wfSi3NHkz7D0MI84KJTo?=
 =?us-ascii?Q?f+BjH+iXJ790IUlxGgQvlIJxjwuCVv2fyUVw/6q3AAii/ym4asoBYXU5QUIF?=
 =?us-ascii?Q?a+XFOg9Fes/ub6boz4fN9x97C8FtL6vVgdKz6CEsEk7pRHsgAwAAuLY4lYx4?=
 =?us-ascii?Q?RKp0BtQqIm+VqbwafIYvx3cEBmHcgCsAe8lLLr4iuLHZFO0ZqwELaqPKV9R0?=
 =?us-ascii?Q?G+817hfre7f+ua/ZFM0JronUJVMRgjRXp4teHIWPnR1ZXqnCaHEtTShq6erT?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uagYzPNiKh/99Wpn+/sm7+oMe50p9qYcnSFfGr51PPrSC9KUY90nS6JiyayHiWWRf2osf8rbqpVf2G4EcBTExbySt+IM+UmNN6mutjXm52CZ0aykK5Oz2UeHk1GtWFKoRKE7tiMBIZDUPciaFbiz99Uc/DTiXrRbiYYSkTdD1HKXMIZvVzuKjo8MA71mHoqlRI1Pjr5UQrIcMB6joIV8pvjmLZke3X9s46l+Sp61JREZaNGnnYZJ8H/mZRUFS+4ehJ3480MVGsvknnm6gAuvrpqC45cVWI9a51A2DyuAbkrHQ/NNm3HjK1HHsJfztJ0lUuG6cpYKqoMHnS51h3EnxTLQ8PDHu6UDKm+ms9nIm1kUAdPj4G/hnINR60CBAhZmph25lzoII/Hd7Xh0uwdDn/IhPsxh4RBX1UXpV1V4/ynN6w6UGxnyZI9M5rqJXjARrRSKRD3h1QVXmG8SQ4s+QuHursixOEm0te8qfUpHtiqZ8gWh7mHI8QNM2rEWnceL5z26PMeXDCaIEAhWV7wHtt1IcolVLpogOHN0jd9ISeofQ9CyiAlXSEW0D9etm2ESWdos/ZiOVVzSmK9KeBgF3+alBzBV4TEERJFoYLO1d2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a185807b-da0f-4573-cc77-08dccc8b6344
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:43:41.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLBvDPGx/0Q/MIwtVZiof95+EwJ6molEPz3+SmwkeKk1FoBYjmkWt55EhhJIviSTjTI3AfxPUpY2jWw5GCZY1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040018
X-Proofpoint-ORIG-GUID: 6b6LoHBEyhqBODa5_u1SPScW8hCiGm2w
X-Proofpoint-GUID: 6b6LoHBEyhqBODa5_u1SPScW8hCiGm2w

* Guenter Roeck <linux@roeck-us.net> [240903 21:54]:
> On 9/3/24 18:18, SeongJae Park wrote:
> > On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > > 
> > > > * SeongJae Park <sj@kernel.org> [240903 20:45]:
> > > > > damon_test_three_regions_in_vmas() initializes a maple tree with
> > > > > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > > > > mt_lock of the maple tree will not be used.  And therefore the maple
> > > > > tree initialization code skips initialization of the mt_lock.  However,
> > > > > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > > > > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > > > > problem becomes celar when spinlock debugging is turned on, since it
> > > > > reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
> > > > > as promised.
> > > > 
> > > > You can't do this, lockdep will tell you this is wrong.
> > > 
> > > Hmm, but lockdep was silence on my setup?
> > > 
> > > > We need a lock and to use the lock for writes.
> > > 
> > > This code is executed by a single-thread test code.  Do we still need the lock?
> > > 
> > > > 
> > > > I'd suggest using different flags so the spinlock is used.
> > > 
> > > The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
> > > causes suspicious RCU usage message.  May I ask if you have a suggestion of
> > > better flags?
> > 
> > I was actually thinking replacing the mt_init_flags() with mt_init(), which
> > same to mt_init_flags() with zero flag, like below.
> > 
> > ```
> > --- a/mm/damon/tests/vaddr-kunit.h
> > +++ b/mm/damon/tests/vaddr-kunit.h
> > @@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
> >                  (struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
> >          };
> > 
> > -       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> > +       mt_init(&mm.mm_mt);
> >          if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
> >                  kunit_skip(test, "Failed to create VMA tree");
> > ```
> > 
> > And just confirmed it also convinces the reproducer.  But because I'm obviously
> > not familiar with maple tree, would like to hear some comments from Liam or
> > others first.

Again, I'd use the flags "MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU"
because that gets you the gap tracking that may be necessary for tests
in the future - it's closer to the MM_MT_FLAGS, so maybe some mm
function you use depends on that.

> > 
> Same here. That is why I gave up after trying MT_FLAGS_ALLOC_RANGE and
> "MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU". After all, I really don't know what
> I am doing and was just playing around ... and there isn't really a good
> explanation why initializing the maple tree with MT_FLAGS_ALLOC_RANGE (but not
> MT_FLAGS_USE_RCU) would trigger rcu warnings.

Thanks, I'll add that to my list of things to do.

Regards,
Liam

