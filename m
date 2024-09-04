Return-Path: <linux-kselftest+bounces-17166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325496C785
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8E228804D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A2A1E6338;
	Wed,  4 Sep 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g2gY9DRG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="efm49zNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096E1E6329;
	Wed,  4 Sep 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478011; cv=fail; b=nj5TPDSym41RKqAj0YtzRj43cl5GLcZ5VB+X2EbYRuYXhUDmKDkPUQYlrj9BjGHgo/jgFQ75XnT6VMilxfTQin+UrLGUKcbUDvZph2eNNUxaAkQolYA3L4ZOwtRDbALnOJ+XNztjH3r29NLJpM3/0Ekp14xILSG4p+5o8DX9eGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478011; c=relaxed/simple;
	bh=cnOQKn9kicp0UP+8SaCpTCi8aobQ2YdgWbCCZiRQFYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pMnGCaV9/R2yYuLhyLStzx82ohffLei6A62H0O3Dwat6OXIKDaQaimAjwwbw655kA0lKuQpORgurWejxKxWNeVNHJBKvhl4nsWyyJpU3SC0tuhymaY58S+P3M89ynfIDOzeqrhwhQWswapufauCrUiPIxfbWfKZWrehXmwGY7bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g2gY9DRG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=efm49zNB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484I0WAS003755;
	Wed, 4 Sep 2024 19:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=M9j7E9A8uT+QebQ
	Vw3qpW1lkjSQB0yZSlyUoU5iHofM=; b=g2gY9DRGKfUgWSbCO5tBltBxBu6O/P/
	kolVXfeL1RKlKgqfpBjMY2Oy/jZyrqfBX7wWhWkIRDsz9NYU1HTAJbZq0GatepXG
	+/kHVApfvD+/v0oQ0CKp9RGkyjD0jjKkJu84KiLYlXMDeiE/1HlurxnF9PHPMdZW
	ZsPpli19gBkYq114Km8f3mmn9CtjcXJgAgo5AqQtJYCR2/AkfaD4OOjfSakFXLvV
	fHzmJ+FraIvZPqKmO7Pyj0YB8k99WxZ3iM+hQxnqM6nZT6/axKgALNDoUbJXWJfw
	USiE7HmcS96cAaPR/QMkxaAf281jTORLy0dL5p2scqI2Y2/wlybhlSA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7venj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 19:26:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484J5U4F001695;
	Wed, 4 Sep 2024 19:26:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmgtv28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 19:26:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJdaITNVY/mNs5lr7MaXvXv0Rscqo/sWjZ0dW4MZNcSDbjjn5OqBMOlrZ8ug7N2vjwfD3wnLdyrI6zWmJEQX0G6e1UkQ+nfYw27FZxmrTYYylzsDEae74evEvD6E+GO1lvoFVo5XBhZrj/pkWmvGYRMEOA1UsfYaLe7vRhntdz29X77jpARptwVNn2Cw6xhFA7p0MY8zzQKa6zKcnonYEXwSuQTOU0xV+XuclJ2DB5/DqBRujeEtcAGQc2HwgY3mhiQtIFejWJFMDVHywGtUTG8i821dXJNGHJ1gbcxIwRFvJ7JdB7N8UB2ryXRfuYBOwCkQf+tr/RcWVMJZKy+fGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9j7E9A8uT+QebQVw3qpW1lkjSQB0yZSlyUoU5iHofM=;
 b=V58CJygVz4/j0Jz6JEnzrzQt6XJJ9tsflu+83nHWjg51kxsDyEPJkrS400XPvWkf5acnALw6xdl0BAWwTjuv1uA6lnZwxNYg4F86glfE0XDPjW9I59IPWcmYxaS46m/o/DbbF9cG2LIrPZk1XiDYin7da7gvrXWpMKKjrndGDmEzuuYL7N6zglHRaeMqxrUtnenItmf1Y0YXhn1+TeOV5MKzOiNaePli2AYGTS/secBclRk67Eq58bxKCl7VP057PTdxTDVQv5S9N+FZSztphKWnBGR2o1JMB4WI2A2QA5npfzavmciqRKuNTKX5rivd9fqz4VnR+XIVKednELvKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9j7E9A8uT+QebQVw3qpW1lkjSQB0yZSlyUoU5iHofM=;
 b=efm49zNBjbTGXfbU/B2XRxNmnG//eH7F/N/rbjRvBTh2Cihrm0AWTMEAhNnk0WD/q/pB/P4MttCZFkqbmjghTygzqsBq7621JaYTKRtHGEvYmNi7mLacSN9qfh3s3FMQll5mr7gF753KkhtB7JP4CbQkkrFZZccFDZ7/9hxCCiE=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by BN0PR10MB4902.namprd10.prod.outlook.com (2603:10b6:408:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Wed, 4 Sep
 2024 19:26:13 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 19:26:13 +0000
Date: Wed, 4 Sep 2024 15:26:11 -0400
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
Message-ID: <gaouhgel2kmzkm7pofpkjkt5ya3a44rwsal74zsgzh76xzh4qo@ne6sqvzj5qor>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Guenter Roeck <linux@roeck-us.net>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904005815.1388-1-sj@kernel.org>
 <20240904011840.973-1-sj@kernel.org>
 <whdjeq6qpccj6ms4wgiyjcnizht4nl5qbt7rbaeqfwzt67smxt@vvduwpqcuizl>
 <e83dedb2-89a3-4327-9a2f-610d3199f0e1@roeck-us.net>
 <54zu64vxrhdxr4wtmwbewga44shu4f7lz4ffx2hxhag46b56hn@qgrgfrb6mhbv>
 <b83651a0-5b24-4206-b860-cb54ffdf209b@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b83651a0-5b24-4206-b860-cb54ffdf209b@roeck-us.net>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0381.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::14) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|BN0PR10MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e02d50a-53d7-447f-69c8-08dccd177071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gMqYPsfVbAVgO1AqvNeZdxCG/7cdaNxAZac48kyiV+cvN2nJkUYk3xJklOWV?=
 =?us-ascii?Q?SHYvlBQr4PhUlcgtQ6lL2Dl4lpqR9+vdEermVCtULHM7bBgvlQOI2ELgxYtC?=
 =?us-ascii?Q?1GsNY+gDEZZDaSgoBVs8+kw9yPyhXmXp/RxLv412xsMA0rSs6tL1dMI67S0C?=
 =?us-ascii?Q?SoeZqr7NQDYd6dhhyRdRMGyWb56GZwI/P+h6scw1PdtFv8gZQcRMa8tmj7RV?=
 =?us-ascii?Q?BP+vtp4cS+payfVXYyEsYXUKfm98Urlv/yhI/fgKdG0gFsmAMz3bj0KcWtwS?=
 =?us-ascii?Q?FQzdaoLmh2nbWlI710229wQBgom3Xdx63hE7loGxTHE323VX8mSVFI/UyfF0?=
 =?us-ascii?Q?P1S178KMSE5ImoWLRtGuB7wHKPHzkO8Q3P+GbDBzqqiR1ULW2/PnrdVG7tjx?=
 =?us-ascii?Q?x1jhGzXfMh6BYKq73o9VzvSFZjufd6CZGCxC5BSUf1igXyaC8hWE28vG/6uG?=
 =?us-ascii?Q?nWNsgC6pc6MYDA1Co1ndFsxfJUDgtAcmiWrCL/VT59bS7lSXl9Ox45A+eUyS?=
 =?us-ascii?Q?Mls5hCqs7NfqJkQnfPlxzR8V0nFK3RPX7erSmDhZ0Wm4qhbAXatmNxDjfGE4?=
 =?us-ascii?Q?HABfdHpRPQKVJ0690QJvD12Z2XNZ32fb1cAR8b4RuhH8Vdr/7Oyum38Rycyh?=
 =?us-ascii?Q?iPN4eKjpcFch/J8aahofy2CDaTPcwr+kI2Wp0rkBOOc0RUFwyWTvmEe8m90z?=
 =?us-ascii?Q?MI1Sp1CknxDJpnUSbFBv5uAJziZGThyF/Cvobue5WmVbaj/z5gYlaBMurXQp?=
 =?us-ascii?Q?PDCGbUlsZeLVrAWb5yuFHfn+Jr2GjUrmL/2vnNZecZRVnh3A+d7iD5mVfYFx?=
 =?us-ascii?Q?gosGd0mTMir3CXvqW0RAt92qQurM3iFVj/ceC0owsWs8aN1UOo7lijqDvVt0?=
 =?us-ascii?Q?71+qqqj8KYNnM/e6jk7pnvm7dCcEpmDvXvXa6DPjIjSYliWhpXzszfmZhwyj?=
 =?us-ascii?Q?JbRas1PH1ACCJjH4fXHHECwjdd7riWGUHqvNYH7EuizTbCimLhibyrmFCeMm?=
 =?us-ascii?Q?Ef6eMNqX4Z0FHBe8GRK3GIZ8M+Ggaccy9zSbI4qfKON6OhGnDjdFkxl4TTU9?=
 =?us-ascii?Q?6BF6RLsDF9U5OEkG4MQ5EguZXN1fwO8bOPEsSB09X94u17MYoXOZxC3bFcl5?=
 =?us-ascii?Q?4QedwpRymGKIg1SldPEM/oJV70IVv61lNQU/7wsbVflU7LqtMu/eJzGU1HLo?=
 =?us-ascii?Q?IjUs8rCMnzZYAJAYktZQqaPELYLgjwdPzv5cGdBIIIqVIDZbuyP0mFLBonU+?=
 =?us-ascii?Q?+X5ASRL5hb9Aq9+eW6x+0hr5uAVKupxe6PnToapPu+cznRqqQX07t6z/OWjD?=
 =?us-ascii?Q?uY+8Q9qG2dYix0tjGaZkrwFEHDVEaz5q3Ss84P7zA9vEHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yiIhoLHwFnXsiblw2A2TI5mQsoE1y+cGKcxpvdaciKwJV82HorU1oIirpCNC?=
 =?us-ascii?Q?m778d+I63m9svBeIVQBqGPIZMAI0qfjl+jxXQ4k9Kzc+DerNuYsChQKnT51V?=
 =?us-ascii?Q?bYOPbrvqhQImtaSSprTdIxrrdmQaI3TISy6u2gq0OUmmP7vEVrXYc7VG7/DX?=
 =?us-ascii?Q?CwOFmf8v4p+/DsjbeZ++0PmvC9WJVa1a8sFXBZmXS32pejG9BBlwKZ5/pek0?=
 =?us-ascii?Q?jYUHHqZZvs2HFIjiK+cBpC0rKLOx3ctF5uyHTVlqwUYDhQs6W9cXIpmE1bGp?=
 =?us-ascii?Q?0ZpVF11mnxhR7tIg5cyXagbYvzOdsXRjSn06ypUR+hP6ttnC4A9+Iwx3BVFB?=
 =?us-ascii?Q?by5CwKc76+iDc2ODbv6KHYXeClO+uCkhTyDzfwtrCwc3sB80BwO9g5fedqRI?=
 =?us-ascii?Q?ZZC3BMTdG1hBLuw77WHwsLfMNb0Ne5Mcx/nPvA/BwOzxJfgFn2Xr3AO5tTmq?=
 =?us-ascii?Q?qxgJThWOFB+mlHDJbaCXNTS2DdcNCIXq0uv60r5DiYu2Dxw+8IL9UVYMDxp9?=
 =?us-ascii?Q?IwF8DgQVjfgBHvZQvo0diywc8GfFO8LMPi3OT4rGBuRHFFtxX/lLyYwbcCpe?=
 =?us-ascii?Q?2LilgO2evoUBsxNA6PzF1USiy6MaFIntmRMk/Zn4oEfPVJ700A4X2uIvygec?=
 =?us-ascii?Q?EbQazsOZDWjPB+iEN0HF7LgO42mjDBKeDvQe7v52V/i1FUcmfamDkJfXWwk7?=
 =?us-ascii?Q?BUvH4yQEHjOOyBD0MygkIyziRKYsW9rd6tCKXnAjw3MNYv4joMqVxaKP6cTF?=
 =?us-ascii?Q?dAWSn60sjI8OLdfux3SavvvOOtxHJBrZ787Era5G02ihEwJO7yjeu2SPt8wG?=
 =?us-ascii?Q?Foiq940zsvu7qXl3XLn2JSIAd5Zj8uoYq7Gwn8ip6zQzDr4J+YK/+sqN1N/J?=
 =?us-ascii?Q?YZuHzMdP0yDIszqAkdaWbUAG61gW1NSem2Rl+DsNg3Gfeku8lyz+CZO7vwmX?=
 =?us-ascii?Q?BgNLcerJm2e3BWCHm3jQH5IBkgr3mtz7/jPTkTEsHmXQr0XMpKaXVkEgnaSj?=
 =?us-ascii?Q?q87TxWX03PGyU33KxCgbAzKFFm3cIx+7lYX6VeaPBYuzBAv/ijzGnkfZtGAO?=
 =?us-ascii?Q?s+8VTve+XEbqpW95rkFXCI5yCaxL6BSphrtrW7QAlOdZAMCWNeMcocM9NPjr?=
 =?us-ascii?Q?ELcWMz0HDNdgV1ta1wCLMjRnYqV+DlpCYkGLvhQs3FHAKfzbO4cdXt7QsfLg?=
 =?us-ascii?Q?g3rgnMU2U9N4rtcuQMHUlZ3AMuFDPNYipNXVniAE1YtifHVRqo4IVqPqA5Qy?=
 =?us-ascii?Q?5tkcataZZBkOV8N1/wyZpM6nciQyGCISUN/DVlWvjUqbA0Yt6Hr3zidDH3dd?=
 =?us-ascii?Q?XcIKCFpquX88MtbNv6xU8S1E6ORB5Aj1lnniLr9tUXnPbGRapafmlPIfbZNl?=
 =?us-ascii?Q?NolJwE68eLoJeKT9XDc9i0+2KGUrQ0TezPKxIR8fO3Xddy+6cuIBFlZhy9IB?=
 =?us-ascii?Q?rSBxET/3F5/BnE3zpcBmMEQieg4gKSwOPIAAWryb8Tsd9ZeZtYrVyvXyTL2P?=
 =?us-ascii?Q?ys8+7zFdhOisB8KvNMB2MoVMutWg0SomYb6vHWFHBEbfbKYoJM1Sp13CIAZS?=
 =?us-ascii?Q?Z5OHk7LF/pBsnU2baF9LgRv7tD+hVOhRIuRLc3en0r93Tm6MUytODyN0VlOB?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gsB8vfSLtI0/3UooNF//awPH3eYb7BLFkf886j2DMeg+rQE1ufV4wrwEpf7/MYA1X9Tg/16/xMqRamhVJ0ib1haeuTreDm8r4VVp6zEVOgXOWAIVVOBxowbc/o3axaVB25Ceot/6BwIIE/IvYca8D0/U9R2zy0DQhsU5QKETbiis3OiqOnFN31PgH/kIqthK13izVk6nxY89eu/ruAGkh4ZffqYMl9jtuAxnxqtYLZebF/R0z/iFzeqZaT6NSy1yYylyoHzvgXH3gYbXMPKZij7G3Eh50IFGjz0hQw2ejy2nfl7Grc+WQY5nPPnnLd6ayaf5vOWjKNDYJ8muXDKtHVQ4HN46dL9+Ft/71eF3gGDfL3cRqBuUJDVxoXiP76U7otfv4xZc0FKzOKgCNWAWNAkBy4S5sEBNK0EeC72SwziVAnKgy7cJLgiRcTXTrXpXcxMaiTyTdMoHDiNkaD/bGjuX2tCIpylQywQi5j1Z7n0WRIlzYOK8UdPLU8A7cVyQlzcvX3L1phcHFHSIYSHCHxlU6HVYeNMY/7EQFgIgYJDPx5u09HPMHMzQ3l/gH/HJUYpOuxBfHzVeIGbGDWj60dW4E/8sLsYvLjpHw/ctPbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e02d50a-53d7-447f-69c8-08dccd177071
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 19:26:13.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD6ZlavZ/ecQEuo+ZR2z0TfPcEr5REsWzizfHZas2Ufp9NR78dSbtuZV0D3IEIUrpPrRJct28ZejHNMMZuXMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_17,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040146
X-Proofpoint-GUID: 12o6_t5sCQ_trU108OG3cCf1DZ11RroB
X-Proofpoint-ORIG-GUID: 12o6_t5sCQ_trU108OG3cCf1DZ11RroB

* Guenter Roeck <linux@roeck-us.net> [240904 00:27]:
> On 9/3/24 20:36, Liam R. Howlett wrote:
> > * Guenter Roeck <linux@roeck-us.net> [240903 22:38]:
> > > On 9/3/24 19:31, Liam R. Howlett wrote:
> > > > * SeongJae Park <sj@kernel.org> [240903 21:18]:
> > > > > On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > > > 
> > > > > > On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > > > > > 
> > > > > > > * SeongJae Park <sj@kernel.org> [240903 20:45]:
> > > > > > > > damon_test_three_regions_in_vmas() initializes a maple tree with
> > > > > > > > MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
> > > > > > > > mt_lock of the maple tree will not be used.  And therefore the maple
> > > > > > > > tree initialization code skips initialization of the mt_lock.  However,
> > > > > > > > __link_vmas(), which adds vmas for test to the maple tree, uses the
> > > > > > > > mt_lock.  In other words, the uninitialized spinlock is used.  The
> > > > > > > > problem becomes celar when spinlock debugging is turned on, since it
> > > > > > > > reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
> > > > > > > > as promised.
> > > > > > > 
> > > > > > > You can't do this, lockdep will tell you this is wrong.
> > > > > > 
> > > > > > Hmm, but lockdep was silence on my setup?
> > > > > > 
> > > > > > > We need a lock and to use the lock for writes.
> > > > > > 
> > > > > > This code is executed by a single-thread test code.  Do we still need the lock?
> > > > > > 
> > > > > > > 
> > > > > > > I'd suggest using different flags so the spinlock is used.
> > > > > > 
> > > > > > The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
> > > > > > causes suspicious RCU usage message.  May I ask if you have a suggestion of
> > > > > > better flags?
> > > > 
> > > > That would be the lockdep complaining, so that's good.
> > > > 
> > > > > 
> > > > > I was actually thinking replacing the mt_init_flags() with mt_init(), which
> > > > > same to mt_init_flags() with zero flag, like below.
> > > > 
> > > > Yes.  This will use the spinlock which should fix your issue, but it
> > > > will use a different style of maple tree.
> > > > 
> > > > Perhaps use MT_FLAGS_ALLOC_RANGE to use the same type of maple tree, if
> > > > you ever add threading you will want the rcu flag as well
> > > > (MT_FLAGS_USE_RCU).
> > > > 
> > > > I would recommend those two and just use the spinlock.
> > > > 
> > > 
> > > I tried that (MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU). it also triggers
> > > the suspicious RCU usage message.
> > > 
> > 
> > I am running ./tools/testing/kunit/kunit.py run '*damon*' --arch x86_64 --raw
> > with:
> > CONFIG_LOCKDEP=y
> > CONFIG_DEBUG_SPINLOCK=y
> > 
> > and I don't have any issue with locking in the existing code.  How do I
> > recreate this issue?
> > 
> 
> I tested again, and I still see
> 
> 
> [    6.233483] ok 4 damon
> [    6.234190]     KTAP version 1
> [    6.234263]     # Subtest: damon-operations
> [    6.234335]     # module: vaddr
> [    6.234384]     1..6
> [    6.235726]
> [    6.235931] =============================
> [    6.236018] WARNING: suspicious RCU usage
> [    6.236280] 6.11.0-rc6-00029-gda66250b210f-dirty #1 Tainted: G                 N
> [    6.236398] -----------------------------
> [    6.236474] lib/maple_tree.c:832 suspicious rcu_dereference_check() usage!
> [    6.236579]
> [    6.236579] other info that might help us debug this:
> [    6.236579]
> [    6.236738]
> [    6.236738] rcu_scheduler_active = 2, debug_locks = 1
> [    6.237039] no locks held by kunit_try_catch/208.
> [    6.237166]
> [    6.237166] stack backtrace:
> [    6.237385] CPU: 0 UID: 0 PID: 208 Comm: kunit_try_catch Tainted: G                 N 6.11.0-rc6-00029-gda66250b210f-dirty #1
> [    6.237629] Tainted: [N]=TEST
> [    6.237714] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    6.238065] Call Trace:
> [    6.238233]  <TASK>
> [    6.238547]  dump_stack_lvl+0x9e/0xe0
> [    6.239473]  lockdep_rcu_suspicious+0x145/0x1b0
> [    6.239621]  mas_walk+0x19f/0x1d0
> [    6.239765]  mas_find+0xb5/0x150
> [    6.239873]  __damon_va_three_regions+0x7e/0x130

This function isn't taking the rcu read lock while iterating the tree.

Try this:

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b0e8b361891d..08cfd22b5249 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -126,6 +126,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
         * If this is too slow, it can be optimised to examine the maple
         * tree gaps.
         */
+       rcu_read_lock();
        for_each_vma(vmi, vma) {
                unsigned long gap;
 
@@ -146,6 +147,7 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 next:
                prev = vma;
        }
+       rcu_read_unlock();
 
        if (!sz_range(&second_gap) || !sz_range(&first_gap))
                return -EINVAL;


