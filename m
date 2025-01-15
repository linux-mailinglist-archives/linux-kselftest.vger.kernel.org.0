Return-Path: <linux-kselftest+bounces-24589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7024CA129DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 18:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851271666CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73512B169;
	Wed, 15 Jan 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PhAQmQ8u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y380Ka62"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD8101E6;
	Wed, 15 Jan 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962246; cv=fail; b=u3Nt8L7xq/si/+7pqu6rvg7AKMOjShgq7GllUFCpV6B0wG3snFdI66h7Hxm8qmIrnWpRk+b8qj729Iz3NWeVJkRQup5/MI2mcpvUie/1IIRL1iYrb8vLkPYy8/e/+2EXKMM5GqLYM+HtRnRe1xFaFWWsYyD1meWUIv2Hiwn9hp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962246; c=relaxed/simple;
	bh=KA8n0y+weUqmR0+DiX7j3M5mStiIWGEKy68R8hj3wDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EGzjJO7+r0ZOiAnmeln2iXXb9YjgU7oTxIMP18jPC5+BVQjGs+DLDflGBbCzPovlXPv4G3qos4T/fjN3rRhiAuJPrc1klYaSc9YgNk6VmtFAoNq8Faox1x3XfiZ5b8R8ROOaddWEy2zq7Foem+4hh9dit5Frd+gtZZB4Cp9N5cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PhAQmQ8u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y380Ka62; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHBqiE008359;
	Wed, 15 Jan 2025 17:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KA8n0y+weUqmR0+DiX
	7j3M5mStiIWGEKy68R8hj3wDM=; b=PhAQmQ8uk6Wc4XGLZWdqYmbGkTuqwebFJ4
	29hIdfc/kIU+mrKNW/mhcS3DiupkPhzvBCK/lgAcx1YRsOBZMUwzYAJu1/QBickL
	RqraRdW8tsjn9BP311aC8OMtwEqP2v6uyD9CPErn6YclOGfkdT+nPeDz1EHIqcJV
	+TYaLul7+XM9WxDlxRrMG8Q3W6k1R3rR+RcK6Keu+KUkyELhePlkW1Hfcoad2eUN
	u2DxLj6NIWzeumoKYaxIFbzHkq10DRq83CCZeOHGURMtIxyhYIZAruGcmwYZNr3M
	4Akhbv5DSeLCZfrDk9oUpMT7kryK6BEcX1qmssedLaYRi53Ems+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443g8sgk6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 17:30:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHIe9Y040369;
	Wed, 15 Jan 2025 17:30:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f39r7aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 17:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puiP+5V3X619F/eMq9b1kxQcUus355LKT6FZLgkRsqrVA92X56Piqv5skvHaK0ftkk4qPYo93R3+RICGZzDW40u2wjKE8gQjNFdQ2g8N/Zbwl5ICnHunPgog3dBHl+qeUp7dqgONSinh9DNbshQnJ5BEjAuKSyXIzfZQvrWJz8qbZ9IsjqkSR1ucM+iZ4FB7YRRVDcYF+aNBJHsvnlV8ZLswT/1I1YCLIttg/LwJzZLitJyhpXofez2uoa/4PxllX7ps8I0NDLQcWRSyL9uYokgSMVBHj2tXmlRPViitr5tTAG6aAbhBv/tu/Zw3l90z1iTJileVQZe6sc3WjYUwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA8n0y+weUqmR0+DiX7j3M5mStiIWGEKy68R8hj3wDM=;
 b=DKejYg5duU4xoo+pPVuFZ8pGLzlXZsTHYq8grDW1uaNn7IBFGCiDX5uBG6FI9gl3t2FTLVY9iKIOLSb5nHUJ1fql1VcbO+Br8Iy187ZnulMxU20Xq/o0uu57p9OQN61xPy4+LXWdfLueHxgwHRs9cAzEU3hqq0uA/gIYOEgnn+/ZAxAk2UHPl9b1dc6GiXzizzLsiXNyKYwnzeHnurtgQejJ+dImBfZTOZIgjLn0DUbDITJ/Sb0EnJeEV7EpWlROb8U5T6DcFfd68YrLXDPZsfc3ijYQm0ybez3DSWN/d8RkZHd5SU+FEWkpsIKfNMfXcXLbfa6wJESlHbYVfhvBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA8n0y+weUqmR0+DiX7j3M5mStiIWGEKy68R8hj3wDM=;
 b=y380Ka62DDYrRjKRk8hcX/+JtZR6eZiCcIkNkY6kEH5JCzVcIOTyTSQHgGH41AeMOdC6NrDz0GkGs4erQ+TkDBpTj1BYnmL3YJWeX/1Ppv+xFF3hhmj/02uWB58XGKHFXGy0Fjq/6UYkQjIysfJXx4c2BNJGg0jKiaWtPj6FYOE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV8PR10MB7847.namprd10.prod.outlook.com (2603:10b6:408:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 17:30:25 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 17:30:25 +0000
Date: Wed, 15 Jan 2025 17:30:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
        =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Message-ID: <9221000a-161b-46ea-a065-ee339837aacb@lucifer.local>
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com>
 <26ee9ae0-405f-4085-a864-48d1ee6371f1@arm.com>
 <Z4fui1wQ97Hlmbqd@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4fui1wQ97Hlmbqd@x1n>
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV8PR10MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d5264a-dbfe-4611-684c-08dd358a4bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?87AZULYEo75g4cM8ZqNkhrnoz0cESOYKNewjcK3Jk9y9RnnlPbMqetL3IFne?=
 =?us-ascii?Q?vavBvUCpGjnnlQ1Lm6hLpF5BjQBYJ9PMyPQ3h6XXUXUvn/UDxk4YqQdYXe6l?=
 =?us-ascii?Q?5ZQb79s0E751tTUsrgiksNvJ7zMwOYVlW2SasrUni72BOwzSQudRDkKYqUGD?=
 =?us-ascii?Q?oFec+4+Y3jl5q7S86eGz0jB9JPeoTCebiTr0tjVtidvMSKr/IiLLx6u988/8?=
 =?us-ascii?Q?KqYptyH5Sxb7krK5leTtfgPOB0HquWJklzpXKtgqIWiEOb5Pj1nLEaghIPzG?=
 =?us-ascii?Q?D7sDw8yytPwlBy02V2wY1bC1797+E+RiVZ5cL/HC7uMlbyR6sYER9K68WUDP?=
 =?us-ascii?Q?Vplnwk8FOWAlp10OuzcVPYRUhAT7zCQm9QGK8CT0HxxB1wX9Ewz9vis7x3ad?=
 =?us-ascii?Q?2VlGKT9MA98wCnnQ4e8jRMH4JXhUCLeROGrdbcid7MrZtfMQ4DoKINAknQf8?=
 =?us-ascii?Q?JB6OmBNnF6babsuYPzQiW0rPpVmyzr/qz2A6vIlsLeAJxtHgGRnGNtx2hl8X?=
 =?us-ascii?Q?cZjwFBb2LNu7oX5UteCKjApSZ+R8aezZf/Fq7tLEdiGwKMRpnbN+GCyhvw1i?=
 =?us-ascii?Q?vnwOq0toUj0BcjDv7ifgnF7zRW7EOme7jhYupMKRIvs9IAGIAqc2uVobd/Gt?=
 =?us-ascii?Q?7vhGFDMtFSv13Mr0XQyRfXWeNcuZqRRxsboUV6W+Pj7UUFFCnSZ/HCH3ldTC?=
 =?us-ascii?Q?jWi/dCFmMnSxf25zgWdnCzKB54LJ9tRU6YNgzh7zLGzguGI7l0pYzk7o8W7R?=
 =?us-ascii?Q?sN7oW4wiNCU57TJ5QzTnpGNFUi/DvGNubI1P1KNnX3wBzGhOi+XIakofnLCS?=
 =?us-ascii?Q?9lrGLKleDTWH/p49ulr98hQl6OM7DubSHk4J8VTX0JMtwc1GfJG+V2El1evC?=
 =?us-ascii?Q?yRFE13C9TVjtDIy451uS6WK4NcuRit256bI3H7HUGW3rREK0mxT1MnNF60IN?=
 =?us-ascii?Q?fpxzQWQHKFL6jokB4G6xN0xkQWWwslWvYcbtCTwYyFckclZc2z7WBcRpucQD?=
 =?us-ascii?Q?bpFtJUahVdmFvErSvSdqUYDIyS104X7Xo5RXbhzrR10Z6fx1bGBxqGI5mZFE?=
 =?us-ascii?Q?ueWCPPqM4ZKNJ3pH3BGNwXsI3RqWAr7e8O6CveXXd7YPwLXqExQELdmUWKXN?=
 =?us-ascii?Q?xkHvp/Ev0IWFjEtiq5lqD8+J860+AvQy5o2pOvZCyVhoPeDC87evG5yE+WBo?=
 =?us-ascii?Q?NfG2HhwVN0w//0nvFLKTxQGyFwNUSGj5ZG6+Md+2oPk+sTni4XVKFJmzsRnW?=
 =?us-ascii?Q?aCUXbmmkeJaHxzaaKUykP2kXCtABk/t2iyC2kC0/QBMq+9htRiSkhtoZpn4e?=
 =?us-ascii?Q?Klr/YLiqz1g3a4GtxGzu6L12zAzS4wGsApt7JkjCt2jQjDs6WhyUCiNcXnqH?=
 =?us-ascii?Q?jH/hVm4ToTI/EBqw3expKldNqlta?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1GBx6JnT3R44K/7DWvCJ8jDSmjTn+Pbwo3yv6dZLDncgPZt9lLgUzi4s9Npv?=
 =?us-ascii?Q?Jw1gKZl5MTvlc9xZqBft3agghfcOI/MFiYbs5UBK478xltvaLhFlYtNwc4u7?=
 =?us-ascii?Q?ta2ZZaQ8J7N6WCA0Rt2ZH+QGy5xCdBjpk8ocdKBsKnrPiXdy1/SKnKQOKbjP?=
 =?us-ascii?Q?hwtPnyT+/lZlTNy2ATWmtXjbwP3jCPXe57kW1ewxc1NCoWY1kyZ84/QH5zle?=
 =?us-ascii?Q?30TJnr+xIzsuqGKamfsGZ3uOVrJEuweO5ay8n0k0gfAqRA6o7VXpp3XrRa/3?=
 =?us-ascii?Q?9cpOKIV+u1fDZPL1Yf3ur/44WeXa7SJ3R8BbFZi1Aljqcq9evGABtb+5yuEc?=
 =?us-ascii?Q?wiYcFYvn5vck1xs7c1NLxCeFUudD0DZoWNZS0sVPiUrfWqtAuxpylnGjNWED?=
 =?us-ascii?Q?kXuVxB/1qiY3NNnica5kOLwisCLzrs/fAL5Xan2MXN0uLcPfE1AY3l8alY6v?=
 =?us-ascii?Q?fAMQrr88BQ2Y9bxwkWWNVV+qkZ1I2z4y4wfVplZ06+PkbeX7u1J3SnQiHN1S?=
 =?us-ascii?Q?LLxvcXqhAqEzKbSK0hXkj53aAZfh+RZF31uh74ufjK3pe+GjtLxHmAIYeX4v?=
 =?us-ascii?Q?mM/tDLVkx5RYQIBZVc+zypHT+7+34fDiZSdjL57Eve5Ib2zA4Hl+YLru+KNt?=
 =?us-ascii?Q?SbOSxYfVx3Zf1w780tIFPo9Tv/waOhSU01BngnZQ5q4j5k+zbwen8WxDP0We?=
 =?us-ascii?Q?hY4/xdRIYgMv9lRwLEskU9iohgITGI70guRdKiNJofXSlLgN2R8/ZWxwRkpv?=
 =?us-ascii?Q?hXrFuMUiup2xsILooVJsXgJpDg53gXSU8RJe5sRIxssr4O63G3NtNiQMys4F?=
 =?us-ascii?Q?LGtszBLqYNu/FBsmTt5tdMmRaVLN4xz3C4uvx8CISlsB7q/Wd+DeKXCPYZQ5?=
 =?us-ascii?Q?E2v1MiUfhzTR6hO66TqIdQEtto7770x7OFAuCP6elJgTmIuQbexAzhzyCz3I?=
 =?us-ascii?Q?hP5QaS1kBXLIFg+RG50x8AQiTHc7z2UXtuRJBV8zsq49mTs2dBHs/2/PGKXL?=
 =?us-ascii?Q?HpU2BhQlML704hwL3pJyPsSbiL5gVure2MDCKp4Z7r5hGWy9T6KaslfLuiBz?=
 =?us-ascii?Q?fRyeug5J5v5cKxLJO6WIKsR1qqKA3XytnZ4oqLofIz4gStPZQTGuLM1hKrtP?=
 =?us-ascii?Q?r1bR2TWJuNHT8PoH/00yRx/SBh4UjQgjlySao1cvTvCYzKhZ8RyB7+lUYpKT?=
 =?us-ascii?Q?yUFj8x0I+J23oADN4HguLVT2EbEXTsHOmdAsvSJhp9a9eURiG6sSFUJwR4bp?=
 =?us-ascii?Q?asyro0u5k5nMKp+zmqd+Q/6najl87cJ5hNCkhTkOaQr/zW9SzWfbLAIxL6dX?=
 =?us-ascii?Q?MeqmCmK3jtgL0QIv0J97I1Jp4eNuNt/jT6vSLFzATp0j8cHzyvDorG8upKzV?=
 =?us-ascii?Q?SFk5bxs3aKSv+WgZB1ty4K3fPYlQlM9k1xt0cbmhrKp+PGGDjRuXxsPvZLXG?=
 =?us-ascii?Q?tw1O4AjCXboUuyQYq0Xl0y8G2WZxZlfPEQY71havT+RoHiasr+KxjpmkqRJD?=
 =?us-ascii?Q?njkwGuGPGAUEwImEX9pJ/dBxznFhTdHMxuvBb39+kjZgzgo5rORiL4+CsH+0?=
 =?us-ascii?Q?qlqLmOLySp0qWnv+xKALJd0z3LIhOrW6wDnKWur+DPy6HgqxfqCT84sqRbHM?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9fFvtKwdoVYh9MlNnKm3h1+jw8v9RuwPLLTeNcrS0bukBlAss1VvWNsBLPRxuHcPPZy1CMVF2ixbvXMDMVTcpyhtCq+Ze7oye6ad6d8xeS54UJk63YwET/rmvsJW72ZOs8KDwaHXqHKZSAlt7Qy2TvHItpqjXspqSiTf/bPQ/hmyaRYOycYN+lMVVSszFcMSI7p+a5Ekia3oCZRqI7+qP6qJTMKD3DgPNZOSU5iNIaQ6DOGomY9wedAj69iuJZ+SJEAuPmlLqOf7ENT4CLMZwQyPGH0oZ+MZdXl6REDYeS/bfPM4SkjoVecKOgTscqvWJF6D6c5Z+/PVVKwIKVOM7palp+oKHPOffGVhgXlq3l+x/iws10IHYTUIrZLVet5vjSgPxTrpRFxc64aocpDw6cIDccA00hi7/NaLM3YLWAk6CLWReJVhdbP6p/V5z+QfpZhUYGVFN+QkFUxgA5r8HMw7PTIyl5pht7zoE2JmcWZ4UGxk82m4eWlG1/TJCtnxYCdyDpftz1sr0i8Xkd2F1PE+zR0aUoTA95qEoM6Q8rLhS6qhsIUGyzRcmBqzu2G5h6MqHu5MyWv0M1ObWzmP5JmHx5ARiwD9QTWppR6SmcM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d5264a-dbfe-4611-684c-08dd358a4bbc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 17:30:25.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0q7BR511ae9jTjhODiZ09kCLoGKswKrltcRKaIKH8V9ljhx5rf1qj7p7b7nhSgHDAY5lkkYDBSOk7YDqhDf9+Y9SacMbU8EoLxz5B9GSJiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_08,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=984 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501150128
X-Proofpoint-GUID: seoiQaUXKjqfpZsT7zY6lXbcyBvgFgxz
X-Proofpoint-ORIG-GUID: seoiQaUXKjqfpZsT7zY6lXbcyBvgFgxz

On Wed, Jan 15, 2025 at 12:21:15PM -0500, Peter Xu wrote:
> On Wed, Jan 15, 2025 at 04:58:06PM +0000, Ryan Roberts wrote:
> > Hi Peter, David,
>
> Hey, Ryan,
>
> >
> > On 07/01/2025 14:47, Ryan Roberts wrote:
> > > When mremap()ing a memory region previously registered with userfaultfd
> > > as write-protected but without UFFD_FEATURE_EVENT_REMAP, an
> > > inconsistency in flag clearing leads to a mismatch between the vma flags
> > > (which have uffd-wp cleared) and the pte/pmd flags (which do not have
> > > uffd-wp cleared). This mismatch causes a subsequent mprotect(PROT_WRITE)
> > > to trigger a warning in page_table_check_pte_flags() due to setting the
> > > pte to writable while uffd-wp is still set.
> > >
> > > Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
> > > such mremap() so that the values are consistent with the existing
> > > clearing of VM_UFFD_WP. Be careful to clear the logical flag regardless
> > > of its physical form; a PTE bit, a swap PTE bit, or a PTE marker. Cover
> > > PTE, huge PMD and hugetlb paths.
> >
> > I just noticed that Andrew sent this to Linus and it's now in his tree; I'm
> > suddenly very nervous that it doesn't have any acks. I don't suppose you would
> > be able to do a quick review to calm the nerves??
>
> Heh, I fully trusted you, and I appreciated your help too. I'll need to run
> for 1-2 hours, but I'll read it this afternoon.
>
> Side note: no review is as good as tests on reliability POV if that was the
> concern, but I'll try my best.

Things go all inception though when part of the review _are_ the tests ;)
Though of course there are also all existing uffd tests and the bots that
add a bit of weight.

This isn't really my area so will defer to Peter on the review side.

I sort of favour putting hotfixes in quick, but this one has gone in
quicker than some reviewed hotfixes which we left in unstable... however
towards the end of a cycle I think Andrew is stuck between a rock and a
hard place in deciding how to handle these.

So I'm guessing the heuristic is 'allow to simmer in unstable if time
permits in cycle', if known 'good egg' + no objection + towards end of
cycle + hotfix - send.

I do wonder whether we should require review on hotfixes generally. But
then of course that creates rock + hard place decision for Andrew as to
whether it gets deferred to the next cycle + stable backports...

Maybe one to discuss at LSF?

>
> Thanks,
>
> --
> Peter Xu
>

