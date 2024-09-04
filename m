Return-Path: <linux-kselftest+bounces-17084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D1D96AD7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1751F2587D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7AC1EC00C;
	Wed,  4 Sep 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j06Jrp+v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Slaz2mpJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA834C6C;
	Wed,  4 Sep 2024 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410969; cv=fail; b=GH9ncocgij0IKoXqpHJhT7jSsncfakcvZi0MxpaszFxHbfTxCGV8o5DzwP9nUIdL8ONk8phB6YFIOADhXacBcsC3YHOf5D8BAOIMEJ4ALYkFsJCsKbDEK2X73DrpgwCKzieMKeIfnKlNZwNWIp+smwp6I99q4bnYYVEj24Onotk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410969; c=relaxed/simple;
	bh=KgktZocli3k2YwT0U82WdnzgUW6LYp2tNfHljFf/MJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ghff6KFUKpxTSpdP7w+u0HxtgixvEEAhPGvylyfRcZOltgEkIqlAL1+F0yaaxaglfsKSye8dN/jbL3NHbTAiE2Yh4TVmCJTiAVMruFBuVRAqYHGFbQYnae/q2nhN8K/U4GMjsYe/JObULu+KUcj7xl8hXfnOjhuhlxYqfH+bh+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j06Jrp+v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Slaz2mpJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483NtXo5022634;
	Wed, 4 Sep 2024 00:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=aOWzQ7YoZVhOoTk
	Lw0V/wd6wnRSE39rc7VObtxg1RQQ=; b=j06Jrp+vl9bec8u7oxZ+R3s+EHl0Yhb
	pw7+Qo/QPtrOD9mXtkOPUYN17+6ni64BLgqKaBMo681QOmWtdJ3yiQLOKxzKK5pX
	msQlL6D+QhR82igCloJVM7L7yMryWEOv+qG7VRkfBnACq9SA7iaG3Nuz7jIvGSBI
	o0oqt8YSO5wbIsiYD0CMZpAxMM1/Gee3Oa5BFwYoNP1Gv+3SzrpOaYexscH8GAh0
	JHu5ScnLnGPRdZzM99V52uokEA407fQ76E7dAU1YvAuQVy6MhGaX2SJ7Qmhmysuw
	aBPGeITtMJK4dV7+Yhxu/1vhnSx7amBrdEI1okWb5v6D9w7YyMePsQw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7t9cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 00:48:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483NMXrM032617;
	Wed, 4 Sep 2024 00:48:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm9mk3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 00:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3SMzdzjFFBDnl5vmKXqOEsiO4RCRDflW16kMjM1IrRh4LcqMVhunW7ON/6+YvaHFrse8x6z6BG48KffdAZFBt9P8Qg4/WbVmfxF/+QqZHFMfetWTT+j9uO2D4jaIKGSTH8LcvSWrDwZv7ozejCKsIqjSXoJtDudnP/o7fcBDSLnceTCbbsLsRbbd4UCyfMoVK6MPO058iWOOQ0TaAFayXT5NNV2xwA6zU4lc7IbxvwcsJFALSIJ8ZC4lmFHg905ljTKCn3g/SV9xWGbF3COS2lAHGq+8dVqY9u9VopmfeyC9arZB7qPG1am0gQwhrZzT/SjAuz/dGMGka8vXgA9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOWzQ7YoZVhOoTkLw0V/wd6wnRSE39rc7VObtxg1RQQ=;
 b=tWdEn2NVfwoVeqtcNzPCew7bJ1BDxm5srqEFs8MkJ5TLtKuoHBIp4of4WYfq7uref/LBJFPIN/GaYusZGFDlztIRUSGJDnW0/e/9MqpgpAIy1k3M2yKVSNzFNUJ3iQjc+pQlln0hSIC2GuPaW0rr50a5juKvA2u2JjBeoi8+lKzhWldlET9PZymIj/hvcODJgAE1VQGFuADD2T2mKq9E7ALjlToT8FTLWCQGPvPyOYkTJNmwtytC8wcCaSrK1uIb51xc0RkfHt1HFAMjWInvc0C4wxi34+J7qUp53it12Z6FGyqPnIGkoMR9ewuRKhiREjMNFwBF8nYzeUevUjYHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOWzQ7YoZVhOoTkLw0V/wd6wnRSE39rc7VObtxg1RQQ=;
 b=Slaz2mpJ83aWcDpAQRnkaDWgym4TtuUt2a6O03XokTFYETHb4444tn4rwYCOXGDfm/+KwS8jcHQDgwBHEb1lrf4zPtpWL4WiJVu14d8hVO8Dj31uUkN5VeldIOiEfBVWS2X7lFoaogGwl+DXFFQSMmCCSlfoeEmVSQgaK7FNpHk=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by PH7PR10MB7801.namprd10.prod.outlook.com (2603:10b6:510:308::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 00:48:55 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 00:48:55 +0000
Date: Tue, 3 Sep 2024 20:48:53 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
Message-ID: <jy6263g6em4jsdhp6tknmh2cljpuvq652kvcet4ko3z2xt7pym@ltc5h5twsszu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
References: <20240904004534.1189-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904004534.1189-1-sj@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0487.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::14) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|PH7PR10MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: b311a9a6-968e-407f-dd38-08dccc7b5ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ASJ+44SF3kmB/OeKm+EZRBDekSR3B106BicOsaQ3lWOD0qyDeDN6JP/E8xe?=
 =?us-ascii?Q?/V3anUHIcpD3eMSqPR6xhJm9YRYeyDVshYs36UA9m+LruHjnPqc+qgWVujNF?=
 =?us-ascii?Q?Mr80Ark42NQQ6sLGX8+6grTd+nUebkM80IROTI3YJZ/2vm9w+ff2DEPjbT2Y?=
 =?us-ascii?Q?0TvfJAWJqR326hsJrBq9+8cq3n3h+GgChdh24n3N/E+riDg8dQAtjfXsFRuW?=
 =?us-ascii?Q?2ZSVpibZUjx66TOnpgjJJGJsi1zmCmtolpjbULvAgTh7zIDNYOyUDRqjjewA?=
 =?us-ascii?Q?C+PAQR6cNiJKeAvI9RwRLTHqPgbXaEAeOE7XPGJVq9O2pYH4CnIZlEZh+3a8?=
 =?us-ascii?Q?/7LPyWHwlI69ozSJZyi2O57OM3JYgHy2v6W+GVQjpFcin3nJNCam2iVZkAv4?=
 =?us-ascii?Q?5Jf4fym7uJZCRy5UzgYjxFztQTgVOqvX6kXT/wNmrA7xJukUnDnqJsVoSHlI?=
 =?us-ascii?Q?jsYkg6UbHyDewkRF6oqBnUSrlqalqhsDXBeDJ+XN1HxHUYTuu9IAzEhNS68M?=
 =?us-ascii?Q?6eQsmdcVRZP93pElDAUE6lVCiOj/D96I7pA0IjwmTZyLq5IgqSFnNErdNPvg?=
 =?us-ascii?Q?qX/eXSiRD0oNSqh8qEHDC1Sm+KpSSU/R4r3DtdD+wXOhZoo0zeUfH+dOfIzB?=
 =?us-ascii?Q?+eVM9dpLYn2ok7v/gp6HL2o2uneqLuEyGM58V1QmHusQLV8dyo3UOU00c7GQ?=
 =?us-ascii?Q?+uSXy/zAUTG/UNusoNJjnEfkRINuzqcWxIXV0D1vMIU+VWOvIaD2+Z1zFCgu?=
 =?us-ascii?Q?r7fLT7Q4pmYPlBHU/z3fxRrXbY3FPAu3Gwd1gHxW9R3v0axRloxtKhWsDevD?=
 =?us-ascii?Q?W8r1FhQPQAmNNj9X/RwPQLTkLBrA3Lcgnua6xfeBtgfqEuhKCGI0qFcXncjy?=
 =?us-ascii?Q?Gy7Dwg3bygFfN99so7Ph0GelkqvfiMocti0oub6TbXvWX5yV5lNZ7C0c4hdL?=
 =?us-ascii?Q?UKjxt2c4fLtt8x0IMzo/UYQjlnj+ksrfW7NoVu2zV7S8grHs3TiPwZYCKP0x?=
 =?us-ascii?Q?8eCrUkmns0AgewmWmQUAGLlNmOzA2+qZAh9ZfSbJchZuFoDNRcX/AXgIrW+C?=
 =?us-ascii?Q?7KZi3qx4ZFbOdkRn6qKu6n/16j26RHKBcd5XiPuftkzktHNvqKIlTziTpO3R?=
 =?us-ascii?Q?0o+s2caF/bqp9PALcV45W/2UQc+sme6s2VwkoY8OzqaYnQhk6gyxssJRRoqt?=
 =?us-ascii?Q?XEQBdWLMohIR0f/eJkgIzP7S04ZcIRvllwPOAaGHS0on9odhuQYZnjKgZsYy?=
 =?us-ascii?Q?KO+k5CPqr83smVXpDfHhjpuhQDcih1VDsmjttpxXybpnzsdTAH5uK+6StRFC?=
 =?us-ascii?Q?/urj5om4k7Fo/wrw/266ldLiSb8TzYhlNeLiPDfbOQMv6vKqhJtiR+sLhIXb?=
 =?us-ascii?Q?sydNa+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Up2WBmfQ+jg5lxGAr2giQPhPc39eGkSCTTcydnNkrc4h/c8RuCyoS1TAoIhB?=
 =?us-ascii?Q?9lrF7J4iO2wSjlybQL8lMQha+vnBZE2BMKhqYeLlMvcP7VG9Wrfwq/IRSaUt?=
 =?us-ascii?Q?aSBpKgYuKsIqOlZ+1iPvV8T42nSN4YgGZiXQ7vu7YZ26Zz6CB+Dj3hIxD7pi?=
 =?us-ascii?Q?DYpzawyigxVObhsX7/UuEKylAjleEF50BalM6CYL3SI5GTUzcswQGVaS5WP+?=
 =?us-ascii?Q?gdLzOFwEjJgo7bWF0+s9+d2gEJMwCRpWNbw1z5b4u5xQ/1hudUfec/xEU493?=
 =?us-ascii?Q?1M80e+s66btTWMbLFP13xswsVxij+MdhdhuOpLkoA0xicIJT8kgtFf8UCY9d?=
 =?us-ascii?Q?GzBgmAKXfE6/IS7JarD9mj2lcJ4PhYrFA2yqMzJkjGeZW/8w8CZgPrclnVWB?=
 =?us-ascii?Q?djjUZZG5FjPiCC7Y8c9GbJwwqz0pv8wunS0vsuFwzFDQRtfO8upjAzVmhd8B?=
 =?us-ascii?Q?EP9rFU9hxG7/olPL75Uwo2O/KbrbIlyhfHdDsSLHMqgJd48Yb2TR6J/MTuw5?=
 =?us-ascii?Q?V9IY9QkOQouD4bPPKRh7caB6DeX7mELsEAcaXQzFLvg7BVelCGiKcEV8/UUW?=
 =?us-ascii?Q?eIn78kBmrT/Cznk1aIFachcxIgOXZNZ+6jfP95CYXNn4whJneqddDz6aolhi?=
 =?us-ascii?Q?gb7sdfYroJUwH5EyEBYeq6CyYf8OFqY4ehSxtQFGdLWQraewPgBsBU4x+Kas?=
 =?us-ascii?Q?OdsUZXUP7cu2FpxgZWPmTS5GqmRjW7j2mQ1/XPpvDUWfhIAeaAp/Rc+L918D?=
 =?us-ascii?Q?n4MsjJAMd0dfyjARwTTV0m3eas4yH26gkE3+BdxA55S7Xg0RIbEkuhMM1RNf?=
 =?us-ascii?Q?DZiVo6pqXZVWVhsetksfcAcY87ZDQzYnKdksf4QK6RYpKbDwMUfCo1jY96PP?=
 =?us-ascii?Q?5kanTsTuKJDayAHE8YbIgoSyb1qw5Yq4aGz9/bHaMx3PbHD+whdgeD0FSS38?=
 =?us-ascii?Q?lapY9s8YF/jHkIibiqzNFYUDp23aQre11uoP0qSnqq0QImzfF+5zo/qZ7DTH?=
 =?us-ascii?Q?8f88RtFHdYTNN3WCVV8owKxpP+xJcZ67IZMWJ/9B6Gsry5v5yZSsqZbZfQ4f?=
 =?us-ascii?Q?nk4LHt/cANicmXV1n8Mg2gB/1E6fzK0PL52IOa1xIA457+tTg2kZnWrZ4akC?=
 =?us-ascii?Q?EfBBy8KZnbwUiqypOKdGb3Rv+XBWY8w2kDA9qlDe9NnB7fiEWG0q+kD750Ms?=
 =?us-ascii?Q?vikiJgsAHWNyoA30IMAwWRBEDmZPW25ATNIiGTa0Lm0fK10gEexUm4FlfJcj?=
 =?us-ascii?Q?vblhuwkutpliE7eS/uAxuQACMX5Uul9DhM2H1fKYrQkI+n/Dy4aL+xowhe2q?=
 =?us-ascii?Q?tCZqo0Xe3HCs4VVTJcAlc+7mXq1XS8uxJ5OhIN8EhBa9U8vvK0ivWbeOS+EG?=
 =?us-ascii?Q?3AxSMoXrJBrWFWqYi0FiHvKBEIq52+ZmFb2nIfh6FyTS0jfYNB+8lCBJuKGz?=
 =?us-ascii?Q?HfAhtbvEg9KRvSJfOXjbFeAr9Y0GgaUlITkJwZeoQcSegbh7AGpvFJEyuvPo?=
 =?us-ascii?Q?HoSArHzqNTcHQduhGCoTOy+Sm/wosEBc+WQEDykXKEEO3lLOX8Mujk2HljU6?=
 =?us-ascii?Q?95vijZ8vKBPXaH+MTR7EOKFytAwnR76XAUyv/a7B4S11ArAdoT7p+zVb708w?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BeANNKzRpGKo98guBNT8Wv3i4azMY5j8bHeashDhpfQCJT5J2C83OlzHC0ON4kfgyan97bECOrIo83X28m0amdziMqppr86HWwruw2Qycute/aBUi/yqr9EbIcVFeTgC+cBra0uNB6D4DF1ypk2YFhBaG/HEfRyQLkChNjYVUNJqXDqjggTadQhHitoS+eHPLFMZV18wwzxhSn5pw+K5f50HEzNJbzLRVKc9fGVfSYz6WPTc+Co60Syjm9hUXweliUJxZ5XzeVb4VhM+Rk59W2rgiygpW3ba9eNztDhrIlzb81rBDhASTy2U94MxzM/nAy46qTxr8E5ad0lHlUXxZvCjIPixldyTI8flQW9eNstg4PVRq7eT7ganxAwjA+fAIqKiBZJq4SaYuBMnz5t94n/LSbK9LX+bx7R4jdXuqjrufDmFSIxHbJuSB5XYwpkfWBY6LZ1z9K95twzboL+06JAwCwVgAe4kBgdOtr1Gl+3dnaw8TRRXkR5a6cc9WYqOv2bkZJ0ff3chAF4/AaqLg9CELz9OnC8qhSosYVW+DwZREWt0j68239FRPm50M18xiJ490uOtGausImv8lzz0IUP8/F2gbyQdDTQHN4C+C8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b311a9a6-968e-407f-dd38-08dccc7b5ac8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 00:48:55.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5w4EjHyOVWegRdu1IsKROT5C8sgttI7dQ7gdQKvUPDDmE7wCluD2YbS+ul7Z2IPXMK1QiEf/b3xZ/4ceWjYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_12,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=863
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409040004
X-Proofpoint-GUID: ItOxO1fSO6PsxWJidabw7o8nny0MJDR6
X-Proofpoint-ORIG-GUID: ItOxO1fSO6PsxWJidabw7o8nny0MJDR6

* SeongJae Park <sj@kernel.org> [240903 20:45]:
> damon_test_three_regions_in_vmas() initializes a maple tree with
> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> mt_lock of the maple tree will not be used.  And therefore the maple
> tree initialization code skips initialization of the mt_lock.  However,
> __link_vmas(), which adds vmas for test to the maple tree, uses the
> mt_lock.  In other words, the uninitialized spinlock is used.  The
> problem becomes celar when spinlock debugging is turned on, since it
> reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
> as promised.

You can't do this, lockdep will tell you this is wrong.  We need a lock
and to use the lock for writes.

I'd suggest using different flags so the spinlock is used.

> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
> Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/tests/vaddr-kunit.h | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
> index 83626483f82b..c6c7e0e0ab07 100644
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -17,23 +17,19 @@
>  static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
>  			ssize_t nr_vmas)
>  {
> -	int i, ret = -ENOMEM;
> +	int i;
>  	MA_STATE(mas, mt, 0, 0);
>  
>  	if (!nr_vmas)
>  		return 0;
>  
> -	mas_lock(&mas);
>  	for (i = 0; i < nr_vmas; i++) {
>  		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
>  		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> -			goto failed;
> +			return -ENOMEM;
>  	}
>  
> -	ret = 0;
> -failed:
> -	mas_unlock(&mas);
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.39.2
> 

