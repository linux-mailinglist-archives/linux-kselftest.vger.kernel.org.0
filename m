Return-Path: <linux-kselftest+bounces-19787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E259599FD2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 02:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36809B234BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 00:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53AEFC19;
	Wed, 16 Oct 2024 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VpONpJ1R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tZOjKCjU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093EFB67E;
	Wed, 16 Oct 2024 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038742; cv=fail; b=SPHZhwEsmrXYHIz9uR+us1cQ1te4Q24qRTflk6raG/1UfTzaTUQZ2JIU0YHz9VkX3gAZ9v7+BoMfDnwT4rDHyP0dXhScCqvHAvNYStFsvtGerDBZtuGHSTiH+HGmHg+59R4mYX2/nrz7JoiaPBjC1HUfSM+hK0g3Y9GPrsCoIYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038742; c=relaxed/simple;
	bh=1UUT141/njSdL2Le3+/fRgET/xOGTttKjOSATojaMqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aAsuFnrTeL8X2KMV4m6zovntoxjXzSNBz5KK/Dl5N94qw3QvAKX30JHLRT1ViW2rq8wF/8xWJYgyPHmKAefoT+V0XnLlmB4/zyVCaSyqZI9ByKgXNiJq+/1eyfAB60Tr7DmKXe5xlq6C+fLfbR7qyG7JEcimlPzXvZ2HwLAOsLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VpONpJ1R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tZOjKCjU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtiVM019416;
	Wed, 16 Oct 2024 00:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=i6dwh9Hcp5lIhTj3wl
	WWG9yklAuKHx+kl8d+TnCIAk4=; b=VpONpJ1RwF1MBBQQEnBrOZnWkzD9AP+LsY
	rj/HfOAN9s8Ov2zjsGHlqKopn7GDa6LrP6bpJrwVLRl1w85BMRXlU30p0mE1moHz
	Hlk+j5ybk5ixCWSjgtuauSyRMAw+YZalXzcASpU8bMF5JLzL33d/rrOI0WTJy8OX
	Tpqb+LOLx7xSu8x2qnF5dbC+k1ezaHDm/ER2by5hklP0MSKH7h2oG85qqu4BwPya
	3oC8q5Da+4Jd0PF3oZb/Ljbb8kdgFdqAt2lgOOUaK/uQVZwpwbVU64jq7fO494O1
	L1XGjeK87ICYxGubVV/JCML3pK03R3f7dzYC3NA9yVTqnOVXSSgA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7jjqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 00:31:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FMu3g0027236;
	Wed, 16 Oct 2024 00:31:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjeqe51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 00:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPoR0FbsY5iLyopPlgx1tmw+A7nnXFNhrxAMab+wGlaboxHTTF50fsd44XRcu0H1h20Cpyq1jcAyobWqrjWrRrLliqk1qtMcmLcFEc/arGdm/3uTvnz+Vqa8Kc9c7LPoZZTiOB0OQF4hNrosCAgNeTivK9qA3YikONUuAjmTPSd+sPWgfToK2/qY45l1OQ+WJMGQ9s/Cf0QV46mS9ZQVIBLIWotrJ8NYCQn17ahBdQASHkKGVYDUuGjdHNlV1yckddcyLowMTlGsrytCJldu4s1P1q1trRLvFaBmRm2Gsd2uzjeaNCg9NpuglhQ/mFgy+LBdmQk41RTsC/aC2WQ8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6dwh9Hcp5lIhTj3wlWWG9yklAuKHx+kl8d+TnCIAk4=;
 b=djLtFlaJrTNADTdv3hm5hzqXhlz7rGNfWl6apW4Iceb4/VGRajgTM7QIeKk6wBmMPfqXWrFXb2K7ri/ypzt4fpdLc/m0EDF4Dy5kTw50FfLr9zfWKvZFxPMmRKV9H+lZ6P8104xCsGvg1fQ+L93q0oI1WlZrbim4pmR7UW0+sUN6uyfErfxf4G7FZ42fhHIGhKy57msU+CMJPJnsjfqTiDWlWplNxZXw9CpbQvsE/blhgaepjq7O2siL87rSSKKnrYWr2eshNpwLGVAkXRuhgzH2Bc9yJdlP6Y4MZsQq6fsCb0yBV/Q3bnYP/8cRQZe/qUmZxeS08kTGf8c0GUt6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6dwh9Hcp5lIhTj3wlWWG9yklAuKHx+kl8d+TnCIAk4=;
 b=tZOjKCjUfZKEh12u5QRVlpb84VaTi9q5BUBEAN68vlTuyUeYnUQDAs6JjpL2Og0H1PrfkKWqebYTy6P0eXVn3PLv5zcbgv/+f9m4N93QR8AFTdVUKpjJ13W/CMV1nEWyhLzmrvPNcubGa8P3krpk9OYfx9kJdrfU545waWVoO98=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BLAPR10MB5059.namprd10.prod.outlook.com (2603:10b6:208:327::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 00:31:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 00:31:44 +0000
Date: Tue, 15 Oct 2024 20:31:42 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Pei Li <peili.io@oracle.com>
Subject: Re: [PATCH net-next v2 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Message-ID: <v34bkwijsy4blveegm6oy274ssvmwwpxynbuwr36qbwthqdrpo@34ahwdkiqrtr>
References: <20241015173014.1083069-1-anjali.k.kulkarni@oracle.com>
 <20241015173014.1083069-3-anjali.k.kulkarni@oracle.com>
 <cslvxh4obzmzbaekc52h4t3b2e4ru2kypvjy3545lucvw2jlmx@3wgym6gbgb2b>
 <E51FF97D-1051-41F6-82D4-EF1D87F444F6@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E51FF97D-1051-41F6-82D4-EF1D87F444F6@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BLAPR10MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 025675ba-ddc1-4ac8-beb7-08dced79e979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3chxvSFw2L6q0H+4O1RAMiKhUYlgmngkjWIAb2+8SKoWK7Opa9/1Vj9jYgS4?=
 =?us-ascii?Q?xchVTERNXyUgx+P5W8VTYvnRvnJKjPGXYj35rbhtg8xqsCQOKpEs1mnRFeQm?=
 =?us-ascii?Q?w2XkKaaRliuMR7kESPfMjJO1f8C+GSmtlKZTVqiYrH6wo6/FzQKwuylfgEJn?=
 =?us-ascii?Q?Eyu8q12FdapXX3h2MIFqiNEHPmPI+N/EDZhMtTCvg8QJj5Lm1bWGP//0K8Rk?=
 =?us-ascii?Q?2M1mKsySHQvfGV3DW1VFZ5A/P4S86zs7zfnMC3kdtdRrwFc4FgyysBwTVMHk?=
 =?us-ascii?Q?XG83lS2vkHun44UNetuUamlBraZzpbhY9Rsv6f2xNkYJjjBYAfJLCWx2iiwC?=
 =?us-ascii?Q?2OkwfDq/bzEvlRpg9CRsotRDuGHF2OL7P5oX+c6bEmfhLgzNW/M7P2mLbBX1?=
 =?us-ascii?Q?jLo89mdng0dznCD1BsflPTNfAHATvhW9gOA4Xl2qNYzO1FAV6fo9WFKEdYDO?=
 =?us-ascii?Q?OyN5i9734jrzux9an2l2SfD4HbS+xeKopYGqIMtgR+rtOW4v5dGZ5HoJCMmE?=
 =?us-ascii?Q?B/DnJfZOYnNuc73jAxz+/I1dLdSMxv6WdEN2ttnf8EkKXR/RSxmhaK0PBMKz?=
 =?us-ascii?Q?1Mz6npVlyBvLPgnuX3ngotW9cThEz6TROz7lCZXq+KFdl+U1VGdzf1n7OfpJ?=
 =?us-ascii?Q?tJE4iMtXB0ffiTvLWSPuMOYk7WXg3NcWz7T+dH82OkAcwz6q4fSQQFI+fL6B?=
 =?us-ascii?Q?NNO8TMhZ1AlTpV/d50lAK6YFMkbkHKZtXGTWGzub15j2Qfe/Upll1PKaJMoJ?=
 =?us-ascii?Q?QjZuq+qbmn80OpTZccloKHtqtwSE2p1vemg8f4dnT42juVcMM6ECAlu7z/Hl?=
 =?us-ascii?Q?K02RNXo/wElK++F1/TJ19S90JoVsgo5IB42rmDb429LPAaWPpxRvKFxx1F9K?=
 =?us-ascii?Q?QkeEcQGgvDfC4NQ81sly43Noy4YAtaau279lFfgi8M/A8mRQErKtNI0n18WB?=
 =?us-ascii?Q?VQKDVTRZh7rFMo610lmHnuhPzNpp5einOyT1xOXQH/65ZvZmrN6ciNHQmNX4?=
 =?us-ascii?Q?ZmPFzvsbG10nNfUI3V+4pYL1kHq9bRS5VVkMcxDdG6qnud3cQ0sDA0P+pb3U?=
 =?us-ascii?Q?nhkT4GP32mJ6xlBaj8qH55ULhyEaFrDYRhMprt1eW/hweaucZfzrQwP2PCNi?=
 =?us-ascii?Q?Pu2jFTIWXxrB+vYhvUr6IB/MZc4LUEYhja9pVyYcfDlcNHYyxGINWlIX6sQl?=
 =?us-ascii?Q?8TyS4GZ0IExsvjIlBNAWjZXB8MA7zugXHie4Zds/BaAn+vBtUQK2wdYxKoaa?=
 =?us-ascii?Q?bHu57c/9C5YskoUx/PFgQBJQrxisykqHYP0/SN5AaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aYRsz3Gnw9hwxc7cfPgZgAu3CSAp/tKWK+uzHT9HnKjFbOjPptC97bj5EVIa?=
 =?us-ascii?Q?JFWG+GwaysCwIHZfn3eFdWNnrj74DGHBIlG3TVwkU8rOCsbWkj5oXbyueNTy?=
 =?us-ascii?Q?IbfLv4ggF24LwvZqoNEPby1GMnkKiPc7Cd7Y46Ouue7MzCW8C9FBgLLb+zGX?=
 =?us-ascii?Q?Xln7gM5MIwgkwBydg04GpyAH6egWMr6Cod8xbuwm6myvq9ytxQfm5zfinkRN?=
 =?us-ascii?Q?vutTnFSAxvVr7YJIyAVfnv0c05K+F7mo19DHoyrlsA9BZZzvcLJMrR+2OKJK?=
 =?us-ascii?Q?RuVU9xAfDYk0yPOKcXRGd6zHrq1k0vmJlc8uSybJwMtXcpyNhs4IiAogwWjr?=
 =?us-ascii?Q?I9LSEh58qd6Te3HZD5dB78w2TZbxAab8A7sUZM2BL/hsE4WNDNwxKQm50VvQ?=
 =?us-ascii?Q?IDu/NvA4Q4t0zPlE8vRgstmg+hu8Wu9TTfezMPxgX5Nx6BkvAyah2Y/h8MV8?=
 =?us-ascii?Q?D+OKYbMM1x5ULn0mWUXaiRSy6tZeCmodAbnU+8aVKPKrRADUW/4njycsB42X?=
 =?us-ascii?Q?hJqU1XTwOU4NEYHQxD+MxQL2CpmPmAUV4SJouTrIrFGUlhYJlLyc8SI0Euau?=
 =?us-ascii?Q?MTlAlFbYH4HOtlwulI87MYEFthOv2TrzpinPwL8z6snRiSZaAGH0KOTcZHnp?=
 =?us-ascii?Q?4/BbllnVMCpINFcaBHRVuBRWOfy78LuR4Cokhy0uSnPKaBLeSnOD/jHwZ6QP?=
 =?us-ascii?Q?RG88xdqmqdVOgkV3ysjfRA6GZvx6twHaLl1K5hzlQPnQVbvSEz/sXF5LhcJ0?=
 =?us-ascii?Q?QPxmhcS8+73tFHEN5ohHdAc/GPEn13gfkXUMB9PwjsoqiiVZW5VD0UMZ7rtD?=
 =?us-ascii?Q?yA+2Rg9lpaazcJpTyKUkLiHNRNMy7vpC8MTZIe5QKXwIwGo1M55RYkjTKpMp?=
 =?us-ascii?Q?WO0DH4u7HcLqc8ttNYYDvIWk0ZaehQHM4fGs1MWloaLq04rGntmxozegU9mp?=
 =?us-ascii?Q?G7G72Yi2ieYLFMIXB6jS8POvWVwv2lEkVRtM62aKACO1nXy6Mjde7IcdqVd+?=
 =?us-ascii?Q?80SXFxYUuBiGQzwiLYx9Ki7szACPMR72ZfGbp06mUXLKI1ITu5CoqgNZEhgy?=
 =?us-ascii?Q?n0zb4X8TC7bXACLn6VhEjvwBLfPE+kIBFWR/Fc+oSL2CtbGdgLtKMffmBPCG?=
 =?us-ascii?Q?+vuPivy+kNpSwaQye4NbfKDpkTTtfLCnXXdZ/BEDrzuXLfdLGSq19+6Glpnr?=
 =?us-ascii?Q?AqkykNY6VEJU9Y/tEkaE2hVivLgGcPuKE4HFQao91nDZNK0EpU0cCayLqk1c?=
 =?us-ascii?Q?46Rc131pymXfHy6BQ8EPmM5KC3NDgtvQjR7PJEzxxXTU4WeTqsIRqByNWzrc?=
 =?us-ascii?Q?R8WakzCdee664X4yqxSh0tb+8mvwv8hmgj+8VP/nClslksAtHqaOWy9y2yCJ?=
 =?us-ascii?Q?wuSr7slaYNmMCpfgsGjG4wbwPgr1IoFgFCtx/afl62qkb052xtz94qIt7Dnu?=
 =?us-ascii?Q?F0IRGs2fpxUkR6RtmAIqjv1mmpGelcmDcQFmXhzPSNUuXBcAm1imE6JlbIA9?=
 =?us-ascii?Q?0o3msnr7/sUdespGvD5ne0q8iAmEQw82pR9BeI36w7RW1AlfeH4xq14qq6Ir?=
 =?us-ascii?Q?kwIw3qrP9xGMyzeWuL3XYpyil4FAEQxete6VAXyy2K0bTbWLZ2+04F4HdNH8?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XM1Wq2ukrdmpcwX6oilDE00c1Z0O7yIJu+Tv9mGfvhSzgC3p342p434xJv0H13juBMf9lNLIToWsMgeRpZEwe9vFsUnolpikUbaxUjSDm+/5QQQeu4C2vrcRqz7wRxEek1LOnfGFTHtiaVXUQaq/STQsDFhU8X8HHQXNuR+GWGox03jWk3ZJPztLrpE21slkeWz5b14P2WloC/oPIGoH6U3w2elTyUKiA1Uv6STvqYQ1RYdyQyCsS4+5Q+qKCm7ejHbPdsc6y5w5rWNw0tEwX4U16ce5VwkHuqlo37aD66q+QxFxiAbWEPQU2rbRg+oc+TtpN4EA03ihUYIveSWcIL1Y9+KFy8PtTdVL4KfCRjVjYM15IqsmXkObVZSWSwIItF9rMaeomojC0+lov6ZDo4hKtlRtnzOSEDFMaI890iylV2mSnc8U2B4zhnnFXsvLeVuBmJROTTDHL//AlDl8nY8tbK4sGs8vPFHzmXmUIYg1wpX3ZKhfKN86J96rpsgv3AJ2pguBOqXa4/jCYP9gMSdFiUllGT4K+t1ErISZzuM7u+7mzNOJRRtPn0ABXwT1xVNuIAgYTi0QtoIkMJMxwtJ6AjXmIpDx1U1JnDglg7s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025675ba-ddc1-4ac8-beb7-08dced79e979
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 00:31:44.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3sexAJ9Xfii3yt69hJCtJGMh1GCrUuX2gSMFTT/oIhE1OHNzeiEYT0AHWhwTk/rq6FXpB/MHf6aLmW6kiEBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_20,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160002
X-Proofpoint-ORIG-GUID: ysUhxhtkEVLOyfyl3GnzoaENsJz6Ip_w
X-Proofpoint-GUID: ysUhxhtkEVLOyfyl3GnzoaENsJz6Ip_w

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [241015 17:11]:

...

> >> +MODULE_DESCRIPTION("KUnit test for the connector threads hashtable code");
> >> +MODULE_LICENSE("GPL");
> >> diff --git a/lib/cn_hash_test.h b/lib/cn_hash_test.h
> >> new file mode 100644
> >> index 000000000000..46fcda31b25c
> >> --- /dev/null
> >> +++ b/lib/cn_hash_test.h
> >> @@ -0,0 +1,12 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/*
> >> + * Copyright (c) 2024 Oracle and/or its affiliates.
> >> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> >> + */
> >> +extern int cn_display_hlist(pid_t pid, int max_len, int *hkey,
> >> + int *key_display);
> >> +extern int cn_del_elem(pid_t pid);
> >> +extern int cn_add_elem(__u32 uexit_code, pid_t pid);
> >> +extern __u32 cn_del_get_exval(pid_t pid);
> >> +extern int cn_get_exval(pid_t pid);
> >> +extern bool cn_table_empty(void);
> > 
> > I think we are not adding externs to headers anymore.
> 
> Ok, should I move it to the cn_hash_test.c file then? That is what I had
> initially but the checkpatch.pl gave a warning to move to .h file.

No, if you can drop the extern and still have it build then do that,
otherwise keep them in the header as they are.


