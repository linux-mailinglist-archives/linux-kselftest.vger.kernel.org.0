Return-Path: <linux-kselftest+bounces-20172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F459A476D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 21:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15B328834E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3370205AA9;
	Fri, 18 Oct 2024 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yy1B1wpU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sr7ZEXLZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84A817;
	Fri, 18 Oct 2024 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281188; cv=fail; b=ZLAKxxJqQXLH8jnqFaefjSQUWGq8A+WM3q1oOoeOTURxs4tkjKJsEUozceU3+5WuFkfothBG63suBfy03TnuozNIgCq6/oy+ZIiyg8TpMTVqU+hNzV+fjuCwkG3WOYw5hrduz7uz6hQkud6ZeZLlcqQlGfHLWp+arxWi7gX6Kg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281188; c=relaxed/simple;
	bh=LTzdqJC22qvye0lu/VtwydAZikDGLCTJ4+HteYWkXMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TQ7oJtIR9reN1zULbxq4gj4H0/t9eNU8/XI0d+2q3Psp6SVwpNEPW10zfqArW2A48FPJE5Q88nt400ysydhEoNJ/G35bhaNl12zpxGB6XH2E3ISYseBYhvrqftPcZO01lounNkMmCpj1mPntKQSEcfFvrGnNuyIztdqlMVvCs7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yy1B1wpU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sr7ZEXLZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IIfxOs002435;
	Fri, 18 Oct 2024 19:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=c0boIsdK3jhtZo9cMp
	5+JQ82kzHPZ5K00DRRIS2mU9Q=; b=Yy1B1wpUx8X2InA4w68hgG+CQ6IAC/Im05
	/7DM+sflICf6Y2r5T18B1N235FxdVif3sUSzbetzYZX/ew66EhBbxDoeTp1gDsG0
	4gDCdEMWmxIKhgZ6wNycgSRGJQNwCYrXRqMAYN3yFgZwAV7fbixymUL2PyNcHQ5/
	6nuhnWGDpz2KS8moCyMtdFItdyKqYDdhooPngmx1y14pl35LkkQlBSpoEQWTocxY
	7UysWtES9dnv725a2ZNVc1QrHwvxYCpVXSYjfi1pgZrLFGHR88BTXRaRzvt9DOGh
	H/7ymsfVC/HmaywtmDw06vFnrYMtmRE70iJ5TkgMVpFfH14OnUgQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7snay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 19:52:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IHpUDV020061;
	Fri, 18 Oct 2024 19:52:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjc10k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 19:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3op2hxK3fM8hIFO0Mn8apmrJKQSk4IbXWYGTWS8akx4ex99fRIiqzHDb++LzwyCu/GZWrXRXmwMz+j6B/AERGhfP8KkhgAgZMFCBhRtCsEPzNfDF4dVHrMfvm0orr+NEfMgSHYjrELhAdd/yx5A9LTxcsswuxd6XgJ0UhA5iGsoodRo9s5x3QXDAVddAGvayrQbZND/Gt5A1PA1/tuIXl8nGDnV9Nxv7Im/A8NdK8LKXTVGq9qMvDOINj6Pt0WJnceIoAI+VegPDXvABPa1o8vdu8JYn9XovAVbP4+JBuTjSbhDQPE6MNEj0Ok5SeJNu0h6gixjSAWH/JdwB/QLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0boIsdK3jhtZo9cMp5+JQ82kzHPZ5K00DRRIS2mU9Q=;
 b=gAhl/2UhlGcUltCQPEDF7htq5lNugi6mfrgaBr9TXn4qA5gCjXyD5Mfb2lq9m4bySjwijhYbqg0JhFxoeu0IhLBjOH+shM0/G1SX3ScFH2r6Bc+f0DDSv/i0r0I8VGTDR9iXcZcqb1bWvzmWOU9JcCfam8DHZXLmRwT/BoZrseEClqnSjMZrIkNFD2r3NkQDhyqhiApQspn5thglpoAlH/goS0R7iawFYHjA7de2V1sytOgnqFdCWa/+1vBwS1grauRJVKF1hXMNyoIuNdBkDP6HnxTUNlWz1epQuabwTF91wEpYwgbGCnn1Q3yUtqGS7Z68zwNCl1MgSR32Ex23/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0boIsdK3jhtZo9cMp5+JQ82kzHPZ5K00DRRIS2mU9Q=;
 b=sr7ZEXLZenZ/lHHzAo/1FJRCGxWtIdSVDWJO0UmlTamxF1wOMQG+ugzcb8FC+XOEIXEYxu2pYU+N2T3AJWccksmGKerc+nIMkbbWOpLCOi0BFRjccfncHkv7NH58iEmK7BVZB0/6F7l1TsHOqshts8RVS/HWsmy1h6FANwPucyQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7263.namprd10.prod.outlook.com (2603:10b6:208:3f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 19:52:43 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 19:52:43 +0000
Date: Fri, 18 Oct 2024 20:52:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Mark Brown <broonie@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        willy@infradead.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <736fefd9-4bce-4aec-a492-2267fdc83776@lucifer.local>
References: <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
 <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk>
 <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
 <a2652ed4-ea8b-4b56-bac6-6479b3df6c14@sirena.org.uk>
 <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0502.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: b25a786a-c4fd-4a99-189e-08dcefae6e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CVXKieO0tPWGNHa7/DCbLfS0n+5EvfqHkM1aJ8ULcbWwUxGA33c6bitmSOFM?=
 =?us-ascii?Q?d3Dp/ErpBPH56/ASADmmmLkw7InTtOeZz0DnFgG6TFP7KoZak+Bl+gVqPKtT?=
 =?us-ascii?Q?pm4Tt4xxla98fao/Zz2juYHelqutehWP/w8oHOQ6XaG8uWEu5S+46Q+V1Fpm?=
 =?us-ascii?Q?mwSa4uoizntlNFOZZXuQBtXznNN6tseRy9Jtn/9RZcdc0P+gRw6PdX/PorZm?=
 =?us-ascii?Q?zYcvYa6ys5y24Wdlwujj632Wyt+N43QB9stzTsdEEOpXRCZSzdg9r9yYgsLS?=
 =?us-ascii?Q?2XlkgSO+tQsnKQEj2xRCmVZzkJEe5XXuD40b78gBWi945PuIRg9KB68lo4YR?=
 =?us-ascii?Q?UQc0atXJifc3Cwcx/+Chand2kXXcmIdJSxm0/PK/gRT57i4My56hcrkxaPqt?=
 =?us-ascii?Q?6+eFI1c82X5QazWF0sRZYtkMIAysjwCRcri+yYmKfjPbNAc+pkJjUIGd1Lmh?=
 =?us-ascii?Q?AyceNp76dke5Th//1GyDPFKUvurwCaPBHL6rF5MPVBAQsB4h7Tuupu9UZYio?=
 =?us-ascii?Q?IyICprB7vNpPltcsshHJRdAM2RTWVkBSWW7mn8wSYV/eWjPyv/DZvW5NFmZi?=
 =?us-ascii?Q?kHzCfRRo5MJxDHKMoHSDMncuIYAmuMu0bBGB3qA95mB+CkhPoJM39jGwZxQz?=
 =?us-ascii?Q?M4yEh86GWV7sKWxiPWEBDX6Rm/F8VP+CqbaPi0yJ6x9qAuD4O5PRZFj80Ja4?=
 =?us-ascii?Q?eOYOH/33ousVLErIUnnyz4VBI4HR1jkLSHokc2aaxkbZoOwgtdsoyqgaJJoW?=
 =?us-ascii?Q?+XdLmAN/mnawLZTfPuhp4Qysy9ECbRe1DIg7c0mHDMVj5PHI3CFsQ4p5dl7e?=
 =?us-ascii?Q?hQ+Z1Tfl9LTraaBmxSC6+l5qw6F8fgXH4LVSjUDMZ5dj3LJJITCP1/h2adIn?=
 =?us-ascii?Q?51tLlMln74XwprXTPLQUk9uPU4SHoZ6Ls1HxZ6IM2srU46lV5nzW7oYMawL4?=
 =?us-ascii?Q?4YGlupY96JPMkrUC+bhVqp4c+NQB+LfW7Q7D8wP1dwAn3VKMbI1wfT93pJpf?=
 =?us-ascii?Q?stuK32TeQJQukwQXRUFBZnvUWdlriesx/uxAh5x+FI0ELcJGoTc1MAtasQIR?=
 =?us-ascii?Q?pYXcMLy8A8fwf51yWEr3tcYVEbc/L0cl4zWxtY+31t2LeNQWckpb7JRv+OdC?=
 =?us-ascii?Q?oTXKnIOQQGVMa2THKmn7FnzRvaSsHH4h5ielpnLvKNrUPkKs49ev0DazetaO?=
 =?us-ascii?Q?k3g0EWTd/b7OESxabzBWf1zd6YBlOjttoImTdWDfg7ZFQfkpiIDdAUDsxvIw?=
 =?us-ascii?Q?P3BQdMmKyOPnI3uIgSyS1sFhMECOR3NLtVtlJaTjWXS0bRUnRNO11tkNxy7+?=
 =?us-ascii?Q?fMr8l1ECg9M0PDPbT1Q5WPTC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5EQv1LMBl2HPKaNLxg6DdRF8ALN2NzKWSwwhMWR3/RWuoydfwNv8qj1hmUv3?=
 =?us-ascii?Q?05Z6cmdRDwmh51GWrLLjF6HyBCAhHS97bIAG32XAPlbm3w/teF/rRMXUAyQx?=
 =?us-ascii?Q?J2esJCY6FPROqXisEXj1CRAd+pE5nwY8zsPRpG8+pZwA96WG+u8L5WMjqPjC?=
 =?us-ascii?Q?lJe+Gex0Z+0HtAAUdNwpPhkWw1FD4XM8Iqi8s83FNZh8afovngxlb7GwfFRZ?=
 =?us-ascii?Q?RzoWX2gW+me/fq3u3NSaUNLV/ebcnPnBaqgQzC7WP5/GQCd4aWkOxmQraKXF?=
 =?us-ascii?Q?xfGMetiJy2UOSTmt4x1TVaNA2RDrxIKux8g8QHnOxrmJbInyMcvAtwBW40Xr?=
 =?us-ascii?Q?nQeKsrScd6lJoSpOISM9nzgFFAsBqrsctLKHcga165qdGXXXhofYxIUYH94+?=
 =?us-ascii?Q?+Ob1LI3NCAjOk1rcSKVyU3mmXW7sp8spN45GL/f6wjSzC5bffl0NxCKFB0aR?=
 =?us-ascii?Q?88IvPfUiBMHU0NUiMnLYR3mpSuF8+bGkW//RKxJV+dANW1pnJ1FGazdd+HzE?=
 =?us-ascii?Q?tneQ6zRfptbBaNwB4jRXkKERjPmFVSxfM52w1Ztova2YmQm6w/YR0p3zhK9k?=
 =?us-ascii?Q?yy+gL9uzuNRL5pyQFtnzpILYj4yUn4LMZjkO2i2vvPKAl+pzIoc5N7cQbAGh?=
 =?us-ascii?Q?OExQp4hnnxm2nAB87lDplbvw1ITDBd3NSr+0cZLxazUKdGseiULi960UjqzQ?=
 =?us-ascii?Q?42oJ1a3p/GhRoBhPsyjJ5XeLMTsZmCmGqjo5u/EA3rb7VcCee4BFRxvqEY0y?=
 =?us-ascii?Q?w59GYit9q1D1JROaquMS6oRaRP7+IBLlOCe/o4qS5fp9julwOM3p8hkVpEQG?=
 =?us-ascii?Q?YPXNgh5W64s0/53qaBCIowlCfLAAiHM95z/WuYniDXxr41kfyWOPgjXTUkMA?=
 =?us-ascii?Q?KRvxtqiGiAGn/mP0TrYq/sJSU8X8MF/fey0aeDsTo5hFNc4ZIlncgkcI3Nwt?=
 =?us-ascii?Q?vhB75EMyzpTA6curHc2iq+Q1k5ZnQnG7X04sCfg9SXxl1qGI5Hhv0xVO7eBH?=
 =?us-ascii?Q?wWoBF2x/qE65HkPZWIs/3xzc6A/ygkySoLR0KM735Ypz5l8HsVEYHEFz1nTK?=
 =?us-ascii?Q?6MqepMNI72vLG0BAKUrf7bsIww1XrP3aoBmcWJ6in4w7bOo3tm7UkHUkPgY0?=
 =?us-ascii?Q?VQxFQOuQsE2hx9UUs5u1mizhKv1tIfP1eU2bYwhylF+WmTzt6k2kO5gz/dpw?=
 =?us-ascii?Q?uu/b+8u0PoNicjFoV6rBkq5Sdp3tTeP1aJzwdur5A2Sm+btS/DLxnaSDKO/8?=
 =?us-ascii?Q?n8Tlc9pNVibN8QngUsx7a7UOcj1btUFUWl74B6zvvU9NNN/gEYQQgy60PwFK?=
 =?us-ascii?Q?R0K8KXzVy4InHUBO5f24R54L3ONBVdUzkVUbJN97ncaiU0aXKN/Cd5Gh3Yh6?=
 =?us-ascii?Q?qbKAKgO+MY7eupk/c+BoRt8W1UUk8pBpyzO+TQdTQJ581yG6IBXDLSEdx3js?=
 =?us-ascii?Q?xvhp8429nxFudMl4FMG7aCeBMBxN+9bylUkUl1hiO/Sv0us+nL+Dfi/Wz/9N?=
 =?us-ascii?Q?vLWeVRQlhD48umv7Z3JCuKpy8eBOYMYQQD7M6AIJ31c7BmFYxaEmFL7OxVdg?=
 =?us-ascii?Q?SXCsMuxsJ/vMNJsOg+DeuFhzDAb24Z2BodUbt12cbMyuggqLIzy9RkDuFeLJ?=
 =?us-ascii?Q?ob2i1c9ETxF/e3SsPxKaTn6iq5Yh5uS2hFX3wsv0xq6Ud/EMXL7oubsamvLm?=
 =?us-ascii?Q?Bynq2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cUVl2sDn2nX9HwzMSd+AtYu5QktAfMJqnBeI/9DQPCsIJnRa2pJ1GGq5y7dKF3ou2gWF5JbO0dVgTvY8AxZ7K74/Ymj0yHED33i93DQ/M9DFTWA9sC7O2Nt1m/mDkAiVcrC6ZMXTwY8HMu5n1NEazGU4zcPPKk+XN3pGXb4NPk6luBlqMNzmIdpOCSARyEDfLehXJ8qPu2Lb46rdvNNn8ajN34uMM7ragGlX7TTbxtV4vbrq4QqtLHAk2UDkXlCO6ZCKxieQU4f8CDdOyg9XzCwuEfy8NZ3d830umE7ZsN8N7Mbpzah73Fwmi1zTXIVAQzvBID5Zz5EnLSPF79QIwe58hsxkpL4J5rTGg329zHRDO9Bdv0d8qSdEYMXYPZvSTC2zHZeGWtHOk0PJ6/1ESYU4le4OfvRfnEdtngB2Z0Q2fy89M3lNQotKso2P4TjyD14msk6YvvGT0CydOCT6uxWDtgOpO6UpNqGH92bwKeuc5TJsQY8N0ozFsqh03O+RIcXIo05EY9ZhsLSM/3XzZXzoiM6g4A0/I3X7QGIFdJvvZ+qx/nMRXKutl96E1xsfXhp8src4ceUvfFgU3JXxBjqis8OZMY4xjmYibw5F6so=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25a786a-c4fd-4a99-189e-08dcefae6e58
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:52:43.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVH3rZa89gU5QhscGf9vfgbSAeV/EJhLQYSGmTi0xlotulAlRyZZTS1qiJg0ko5OexLAnNUt6lleZpJL80cwHJbxv7CfzhyfIbiJAtCvVSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_15,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=973 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180126
X-Proofpoint-ORIG-GUID: uw0TNPOPewiq6z9I2q3Jn8QgFqSzGa4f
X-Proofpoint-GUID: uw0TNPOPewiq6z9I2q3Jn8QgFqSzGa4f

On Fri, Oct 18, 2024 at 12:32:37PM -0700, Jeff Xu wrote:
> > when they encouter a failure, the pattern I sketched in my earlier
> > message, or switch to kselftest_harness.h (like I say I don't know if
> > the fork()ing is an issue for these tests).  If I had to have a macro
> > it'd probably be something like mseal_assert().
> >
> I can go with mseal_assert, the original macro is used  by mseal_test
> itself, and only intended as such.
>
> If changing name to mseal_assert() is acceptable, this seems to be a
> minimum change and I'm happy with that.

No.

