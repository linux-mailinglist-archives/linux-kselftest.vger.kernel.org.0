Return-Path: <linux-kselftest+bounces-28060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C17A4C415
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F531716BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647522144CD;
	Mon,  3 Mar 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iijgPNHt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bYXkz3Lk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83E2144C7;
	Mon,  3 Mar 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014034; cv=fail; b=YS3nEyhpDtT6qqirk478lmuqNb9anWI2lwRE4gYHNlP5IU4lW4CCZZjnru54JUH17fCobFBfZNWsAU0I1OdhLJHuFNcI5WMROLuLZdlwAPekrBSwpS7RY5oBOzNnklsSMY0T0XHgKYXJupRWOhoW/+HlgsCgCtnCZs4fCgFWRSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014034; c=relaxed/simple;
	bh=vZHCU7VcuzKyAwprob4Au5btNeagvWV4vrqsXKVVyt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T8FioKHitkoAMntI+uByOd/22bAKbEMF15iZ+z8MhDvHM+2ugvOanxP2+Mjgw5M1gmCdV/G4NKJWzL/yDJWzNHCXzn38az1V2NGY6q6C+RqbK++jxFjOK3OSVgWq3QYi+s34euEneU3baJAmaWFMwx75fmZWzvdW1ZSui/m8ACM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iijgPNHt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bYXkz3Lk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237u5Q6016225;
	Mon, 3 Mar 2025 14:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kBeOtjvhLqFjAWMBro
	x46c0RL3wcD+LQgs7hKSgkRJM=; b=iijgPNHtqj+fnusMnZ8bocX8Jmp5cNg7Ku
	Wn3iIUffBRsJd0XMYLMYIga46mA6D0OQLliCrap/OngJCjHElHGiE/qcjXdAkSud
	NYV0OdVQyiKqkiHzq3T8HRyYKbuawE5vqLbqtck1PsHmKdawe2+lA9taqZVyjfsT
	o3ytHBvypdtd0FInSc4gEApMhuFk7uW9mC7wyska/aZpXMaeRZ50wwGG8cI9VEFl
	IF+KJ3iF2mGdWe9VjqbzD0mdAWOEjr8h34J+LHkI//wdUynAMmtlnLAH0rI6aHLd
	oShzIicXYuhF1YV0pewxLLC8Tz55nAuf/o5u9XUs8v6R+FAv9Tbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavtteg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 14:59:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523EuCoL039757;
	Mon, 3 Mar 2025 14:59:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8ajv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 14:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWghsDgR9XusxqyjtARD/aZoFa+RLxTh37ihmRwQZAmUYxuwjndfndDEYtNdMI7sEUYKqKJ0f9eJht7ZwNxnIyF1r9hTIZDo6F/pU++aQnGtDT9MijdMGi7j149W5vPo0YQ8nhOhc/hUyIs9EQhQp5IvEom1DFd9u4MIIysMrWzxUkEzNDkqV8mYzXed5uAaZhq9a+9+Bcp/4wddvWdm9MkT+jPb6AvHbIUta6jXfGgXW+wP8b1C4GTHukEdMZml+8AuHNHnySsBmTVE0uSAiJ2MVRN/FdWAHznOsiTJIH9E/ywtUKYUhn7JxDcApXQp9mfQBPWgc+T7cGBGlzdgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBeOtjvhLqFjAWMBrox46c0RL3wcD+LQgs7hKSgkRJM=;
 b=kuKg5/UMwX2lmmf+pOmOAa/Et77Rvo3dw/unYJ3ATeCIAtfXBIM8W0LDRX4oyEV3Tmsbj5qKf97v+WBNtxoMa7qsm7wxd5f8ZhJh/SD+90p6Rc7UocwLO6gAgbN8/2pF0Eq5b8qvjKoepfRQszRxGpHUtHJXMZD72HtNInzv6s7w0LvaPS1Y0YiMLIvEwrGzqMDFKDZvkPJeuJU02whsJAy72L75czFI52Xxg5V7biMNpXgkRILjHNlYW8+717waqoAkHoUkTSmlcxEtmHDG1hzMvf5SN+UbTXbzshudltJ8LbfCTDV/S0clT/SpT/A7qlYmQQ5fADyP209xXSk6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBeOtjvhLqFjAWMBrox46c0RL3wcD+LQgs7hKSgkRJM=;
 b=bYXkz3LkhWRVPtfMpoATy6+aCpt2iI8DSJ4QryZVUyNoO4zvMvN5RzFu9zAXIP73W+eFoKwhbpHONfa2BkL4SxOOYbthZyMzZjCOzCpV5Os3DGN1DPVlx1P32zfWHKHIgvqM0mVyTFQ0gbsvZXmjbSRwEfZelGFrxhdVs0f68bU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB6196.namprd10.prod.outlook.com (2603:10b6:208:3a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 14:59:19 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 14:59:19 +0000
Date: Mon, 3 Mar 2025 09:59:13 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org,
        oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com, Jeff Xu <jeffxu@google.com>
Subject: Re: [PATCH v8 0/7] mseal system mappings
Message-ID: <o2ynggupddg2iscald76q5niaipssy3gkmsvdkvobopc5whvah@ealwojbiwsrn>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com, Jeff Xu <jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::34) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edc1020-3b2d-45ed-7676-08dd5a63f9d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9y1C2hFetacUVEa1A7vbkIUzFi39X0/w2Jdcr/ZepM9DNVr12XaoksmtNWE5?=
 =?us-ascii?Q?lBVWAgUobmtkV4aUFnGyw4MLCNgA17rbxdcN7TKIelUDQHKf6zRo1pa6dsKv?=
 =?us-ascii?Q?Q3kH+HcXzc/Bc0w51UJURRk4N/ExkxiuNei7RfbFF5Ap21apqA7KuQB+3W6/?=
 =?us-ascii?Q?wfUGiHSTFfPydEXn5kr3zK/wug+yQ4upzWiKFOrjVof5MzGjYOPSa2VTQ2u/?=
 =?us-ascii?Q?LoA0H+gCxuDPWXPhe8kfUS4BUQ8MLiH634NjvScO8UwaZRCRASba/Hfw62B8?=
 =?us-ascii?Q?NxH5Ic5LzSh2KBUbQG+/Vk9S113hzb4rRPyHeLsqQxS7CsambG8UMyr5EF9p?=
 =?us-ascii?Q?o+9zH1b/vuAXX601JPHa5fAp+qLmUyN0H+MkbzW0WPlsrOmaaXx1c1OnaG+0?=
 =?us-ascii?Q?uoziI8pTibt7MJBlW2I1JSRrr/2NF3K0PalhAJPRay8DMokEbTwD1BvM+uzu?=
 =?us-ascii?Q?xAwa67ifr5PKHtAVZy5k/4vXuetRyVk9/b510f2M315R5j1IRTh0YRrljul3?=
 =?us-ascii?Q?1aBIdcsf2KkgftQ/W4IBBWHj59H+5yVkdkpXhIuTtaS3D66oFNwJDZbe+PsJ?=
 =?us-ascii?Q?bTxIyJQZWis5s8UPsdwZSOar1tZbkj3Yy9M0i5pBbHt0JADznhaXZH5AYhFK?=
 =?us-ascii?Q?FXTr3gLZ4s/un6uH93zE0Uw8B35kC6hu9kHxwX+aWHTd043hs8CWHmw/ax6z?=
 =?us-ascii?Q?3iWc0wwlK0/MVFZwNTHBotscYglodFs441To1UIhdvC+txKY1VCX66Wh38np?=
 =?us-ascii?Q?A0Zz5lgcJHyQqqXAZ7MBqm8l52mS9zRKWbHzwYw6l0/pqkPP/hxaeShG0lmP?=
 =?us-ascii?Q?xAlPfgUGkvLVUyE7YwAhm+G0n9KiTU25T+UmEBrDKCDJDpgB0wV29jbOjlt8?=
 =?us-ascii?Q?coXUScABK1eTdGRNjmONN8L3Jdz7lK78mkqzjYIeGPTEjGuDqviip3y20QTy?=
 =?us-ascii?Q?nKMGmRgRpqSfs8A83DJE/FYwAnhFhyjEWcnEri8ZA9UF3e+9yZNlVcw2yye/?=
 =?us-ascii?Q?h8un3yLcN1APcmkbQc3317ZFBXV4F7BVQigd/SsYacMATV/630Sy8zopK74W?=
 =?us-ascii?Q?Xh0DzYwQsuxCNhxfJ++pGesz9mfROvtcv1KzKl8yaeGFtjXEI49Z0pjQqWRg?=
 =?us-ascii?Q?nveNxTQ1T/HA1vCEWAyqXvgSxAL9WammcEWhmELpjvyDOx2kTEzE9k9U/pDj?=
 =?us-ascii?Q?5zXKXUfVGZVPDQ7F1Gied85ZHQ51uZUebdLa5v2Cq4s0by0r+31iZ3w6oHOE?=
 =?us-ascii?Q?dx2lI7xkkA4JEQ6Ay6Q/w1GA9jCMFWh/KgdvgE1IE6wGPvPE5OD8RQHeF/lJ?=
 =?us-ascii?Q?jHgcvaZ8gWJTzYPF5Aj5RM6XwFlfpR3/uZ2QOD1AuduOvfHrC7f/fTqBi4bp?=
 =?us-ascii?Q?aEAFt1JvNzdhTLH63oDnnZIcfvbEC/T/W4vyOplbvgJbILoBIDB54NshHB79?=
 =?us-ascii?Q?WrMaGO8/rvt2kaTZzlj65mCGosznCBUM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VLOYRiTChBRmPmoqw7k7QhJzBAbOpWixlNgf9ROXz18OZVKRGfUdpNVAJTH2?=
 =?us-ascii?Q?0aYSoR1G5Z+r6fdaVkABJNDsJ4xKuPbNBq/v3eNdUeWZYQ+e1Tib4JW7TbK5?=
 =?us-ascii?Q?7uY55fQ4fTbeT4RE23kDE/1yZtk9LFu/AectdP61nQ010w8ryzG8n+g/MlAY?=
 =?us-ascii?Q?5pUWFxd7NoJBdQ0uisYzfvMcOij0fLXTvPrEOuANbD8V6yh3YsMLd4daYxMx?=
 =?us-ascii?Q?XosTV5xczz50DZ+f1rxfMxATyhT8HNHiogzt7xo1Wr0+ZlqzA+ZuM2BFrwre?=
 =?us-ascii?Q?WmVSFtjXH6JJhkgHZY79hIHdmdUYcaUoJKGE+DmJzYTCvIkui0SUxgcIDKpF?=
 =?us-ascii?Q?510Px9/htEOvIFJO2mk9i0OE2VDWK45rHcsZ6bATjniWiI/tnIrv5mcNkqEg?=
 =?us-ascii?Q?7bKjx7VH5kDnUnSy4cL68N7ucGtSfndSYmFGoK/5bse9+EUfXIVDp2GLltfI?=
 =?us-ascii?Q?Qd7zJjYbcfolTkmCsFM8iWokMxy598XhMzD6yMn1efK8XiJjPyNQOYHaOBin?=
 =?us-ascii?Q?U3I3QxVS9Ro5sklM8w56c/bpa+8YJn0lIbyNfXy4IPR07mnP2o5Gv4jWxFxt?=
 =?us-ascii?Q?7MY+AlrBzQuW3/7PwnM4c8wD8tkDmSNoq9RWZ/kJdUQDpNacCGowUqIlGwu8?=
 =?us-ascii?Q?ephFh2qHoFFYNYe4+FtXDTsudOe7gI5WJv1lf8rntM8kUUFjP2n50+mAodeF?=
 =?us-ascii?Q?D405dd7l7u8bDssxsdvODo5nrZTgiR7SqL342LwuXQjVTo1TpPRqi9vXQfDr?=
 =?us-ascii?Q?kqgc6uCaGS/0m5UDDiyCSa66hp9xYpv//gMcl433EedNtS1wflG5y/MJ+PHO?=
 =?us-ascii?Q?HG/1rDx/U/i5Lvd/OduELLbnOB/HVpieF2SM5QrZB1iY8L0Dz6U4Up9N0g25?=
 =?us-ascii?Q?WM7EuLF2KIgdW6lIJJtKoUNhMzYVhkdj0uxLKC+o6/BnS7CJDJzUX/z9Oly2?=
 =?us-ascii?Q?toU0EmCQjKKa79xeOIqZAhi2VFdqdCgKbV94wAw1+UPa1tEPpYMlwpSDJgzk?=
 =?us-ascii?Q?aETYaA/BbfkfG449xuQzzX94rsb4LrCN1gHh6CPDTTyLxgOscMTmVKvPaQ+c?=
 =?us-ascii?Q?VEgg5wIL6ttsTVmJOd6Ezod+CAcwnLz/bpX4vJOPXzLjHHt96JlKNN3uSSIV?=
 =?us-ascii?Q?uk878Ok19fTR2VpRi5BOct3yxATf4I0pwF37FTFJCCjXGenFGLR4Eeo2sgb7?=
 =?us-ascii?Q?yhF5eeRE8dsfp1CLUvRtcsJISBbLAhiKQk78W/BDbsGMQ8x2opbZoT7Mj2iT?=
 =?us-ascii?Q?1bZsw+6f45fKWJj2hPSDhuAYLxSyeUMrBCAE8HkKYGfhhptbmyHfX1McQZKF?=
 =?us-ascii?Q?g/5zpBkotGzq8w/FyBOX1Veq5KpodsCWd2wtJ4NsfULn4BJ6QieaiRzFbaXA?=
 =?us-ascii?Q?r4nn1GTfASRaChiFKtn0ewce9IOWNuW1wssty+1pwRr80CFEb8Y0zpZIpT5K?=
 =?us-ascii?Q?gVVkZ2xd6lw10g5BoXz/QOM0vzfYGmLByNghdJPMK+0maP9wXPZAGmSin5UL?=
 =?us-ascii?Q?H9WXW8UQW2TrzxHRtfyHyWtpf/z/oFs3mqB69M4xfVes52bAvv0thgMy+0lP?=
 =?us-ascii?Q?LfgN6UFpEBCJ6y5Yb5RkSrpr+T24elh55ViyDF0x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v7ABL2LURMpowI47dzA902YJ0YJ14L2bfasTUM1usGm2vW1oy7re7Yhb+0XV7iKaLRSVppRzbXTVlS6Tq0VdiqswzEJXkjnf+9fbmHZIaUxZFxeio8UAD+n+S8P/ewnR8pjl+5jVMc1Vm7fw6ZQbUqyMLPYdRtL5+8GJtpVFue3MbMj7a+UNUnBD3EBR70lCqe1jZt+ISg+d2Y82aX6wZslWFGMFYATlthIquUYHB6oPdTzg+/7IJ09EZNsNlnY2xjuv6Gc1WMl33rOTlZaF1ZEI9w/h4k/QnDCHMCgtD6gBus4m70aR/SV9m9u58D4KFmkz5avFxtRmDDKrsrVBmLoF7jj/KVB/Q17o8I/1TbnHS3fGvcWV4xP9Avk3JGQ2Ta37HICWwhO5O1EnQq4aoYFrelTXoNGebhJDS/qqQK8bsVzEcHUCR6yAMtnHtJXLhiCChVk7o67cD3/KkT5fMLTAXkF3FGU8Pp1PNGMW1SbWRSZFESztgDHofO/okS7XTyOWlk8kS8hRgaX5zMSO0AWf9nCyVD7Gz5qKzxbtolylT4W/XZlPFfkK/K/sYbxNAvPvAvalRks1iOu402ErHnMli9XChWqNIhyhSYLv/g8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edc1020-3b2d-45ed-7676-08dd5a63f9d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 14:59:19.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: do4OIAPVMqNomHik3shC4hZTElckY0jY/DiPZbqZLRKLT9eElb1uSUHk5CGcmwOS+8i54f9brKOUST/yELeQxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=498 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030114
X-Proofpoint-GUID: zHvbXoXT4BlMMqMZ5U5VrZlv0p-WUAHL
X-Proofpoint-ORIG-GUID: zHvbXoXT4BlMMqMZ5U5VrZlv0p-WUAHL

* jeffxu@chromium.org <jeffxu@chromium.org> [250303 00:09]:

...

> 
> Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/ [1]
> Link: Documentation/userspace-api/mseal.rst [2]
> Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/ [3]
> Link: https://lore.kernel.org/all/CABi2SkV6JJwJeviDLsq9N4ONvQ=EFANsiWkgiEOjyT9TQSt+HA@mail.gmail.com/ [4]
> Link: https://lore.kernel.org/all/202502251035.239B85A93@keescook/ [5]
> 
> -------------------------------------------
> History:
> 
> V8:
>   - Change ARCH_SUPPORTS_MSEAL_X to ARCH_SUPPORTS_MSEAL_X (Liam R. Howlett)

It looks like this was captured wrong in just this update. Change
ARCH_HAS => ARCH_SUPPORTS.  Code looks correct.

Kees also ran down the meaning of the two more than I did, so thanks
again Kees!

>   - Update comments in Kconfig and mseal.rst (Lorenzo Stoakes, Liam R. Howlett)
>   - Change patch header perfix to "mseal sysmap" (Lorenzo Stoakes)
>   - Remove "vm_flags =" (Kees Cook, Liam R. Howlett,  Oleg Nesterov)
>   - Drop uml architecture (Lorenzo Stoakes, Kees Cook)
>   - Add a selftest to verify system mappings are sealed (Lorenzo Stoakes)
> 
> V7:
...

Thanks,
Liam

