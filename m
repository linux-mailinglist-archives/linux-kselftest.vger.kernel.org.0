Return-Path: <linux-kselftest+bounces-26881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C834A3A411
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14631706F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39626FD8F;
	Tue, 18 Feb 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jY2PBRF8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fkULdh+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC626FA77;
	Tue, 18 Feb 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899273; cv=fail; b=Y5D2SZeSwQy88MuNqXuUrq1E3zcMn0jMutiL1UXqd/aN5N92YqGaSgtwX3MXapsI6jr7fEALQ/JEk+0SistUFMhyI0wK5txHnKvgGCXb82uSsuDQG1+wgOqF2Yx4L7tInF/rSlBW/aMshx7NTHmjwTCMQSfhgQWe6mpiTwyVgUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899273; c=relaxed/simple;
	bh=K5OIlCSm2ioTgQHMzJVOmrE1A2bezyCFuYVRJKuwFIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Emt8/TPEZAd5qGCKa3A+bRU0fO1R4GNvXfPT2QiynWD/vNpgteGZIPa+fMedm7jqAGP1r4HfsMZAEAvRc4FoSNW6XGrAp9F325aU/h20iitVy2Nw6mhfEkCPZmPBrupqdGp+HN47bx0ICHb6ynS484MbzM29htQKjEeIX5xeBrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jY2PBRF8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fkULdh+w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGMcMe008605;
	Tue, 18 Feb 2025 17:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=BcoQzhfJ/SNdNc3s29
	i90OEVH/iO6Nz5Jl6jz3IlPnQ=; b=jY2PBRF8HdhbM9pZlDPdvJW1GmAMEHP6qb
	CJ8Q3Bm4IeUdT/znOD25tELRfHSuwGNhSzuj6FUZtbMBxBijENE7GiTlGuMe/uCc
	wywBDP1f39iw8qfxUhEUueNNzmWKizawKmxrOpAiuprfhDeSCSHcbn1aZMFpOXtI
	BDGov7/tG9tWp0TfNPa/NYezchN/2HLk4sdZtVwatoMQlZhJNFVHQqLci2VRclfn
	xrg2XtvZZKiSnA1QVTrqVJFr+ZUxHQC3Vikw8YMclphtIbd0XBdxbtK/JADhvChp
	Hdsc3r1GcarHOzmNxP7/ETRifD7Ya/04dGDeH15U5a8N4Bzh5r/w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thh074r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 17:20:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IGTlDL038853;
	Tue, 18 Feb 2025 17:20:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thcakskp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 17:20:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d67Oa1P53DTDH3qRw1LQDNEpliNQEZN8m26w6rQkKd2qKoGlgeNUSAcfg+SIGvziJuWlGWVtcD22i4DHUFrotqomD9qrzZWyB967ljaEjOvWekkEcuOzK6MPEsDu+G4CcPA7///XQgH33CNjAe89mEvFFjkardw/PQ99nJOmac0b7UErs/VL/UUxcZB8bnlY5X39ASKrfoHIhDtyxx+UhfLRx11uqESWXID0EANnDNw0M3Bm9OnsmhNa4Q1YLPgswAUTDJOAZwsqkqsDUOzzbX+rkPM/3LoHojRjxLCxiTUXaWM/K8LrJmzqhihjpODf2tx0OwxFiVAc5Aw8fYSU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcoQzhfJ/SNdNc3s29i90OEVH/iO6Nz5Jl6jz3IlPnQ=;
 b=XTmMQaceuS8Cc1qNOsJH7pIMe45LoxiijghaadmjRev//WjWmQM4VvP1uVBML88o1Fe4EaVcoz4osaTyo77YPBDW/mGvM2pyd59BmcUsDik3Wafh65FeA6EXNK3JnDHH3h6a4+n8uI6PxGJm6Fzd1YjUrkfWn3nYLRCL8bq28AtTqjQBMnGpUFlXGGlJ4VXdDPvxbevY8ka1QJG3dxddNCLJTY1uctwhtKwuSR1BdVmZtL3fDvzXQVJXmxAD5W/tCnhaQ1TsQZi0ELPj+12prBzlbIGaY2tC8aehNgfnDntWAP1ChAiNIvhGCqm8ioHiorGsgv8i69x1usaVk2HiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcoQzhfJ/SNdNc3s29i90OEVH/iO6Nz5Jl6jz3IlPnQ=;
 b=fkULdh+wOO6OisXbNhGx2R5b2k6iE/l6yttAdz4SJwFRCDdsJKcKSBM9hTNDRqEr83NJuTPmNWYxnKSX6JsZwb2r7c4RukvhIYBBDnvAchuIDhWJfNqEvs8PeUqfuuGKV41QtI5QMobejRP/z+bUgEd6PPJKogTb6um08ymYnIE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 17:20:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:20:50 +0000
Date: Tue, 18 Feb 2025 17:20:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
 <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
X-ClientProxiedBy: LO3P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fff5cc6-29a2-4b40-8788-08dd50409792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0vZFtUSgFA91v3oSGC2cXNuQloME6s+tIbLtTB/C6zRZPkpsQ/3J7SSjoPn?=
 =?us-ascii?Q?rgj6a6WUMzlYnZTpiHSIoScno5++r51JUJqdfRF+3RAA+nk8ytV21TEFvUWN?=
 =?us-ascii?Q?HhQd4mkzTYCRKxl+IlRFU+BkCp76w4B8AgBXd05N2HlMH3H3dccUPh0dyMni?=
 =?us-ascii?Q?vzwvrywLygz2Bh6Bz7Mw+K/v2af7dlkC0P0/p03ghh7qMdT9K2nnQq4vS43E?=
 =?us-ascii?Q?rf5qWazmr786NMfvpvvGdAlzsMUaSOsd4V50MZ6LxX1S/+xEdru8JWe5JVES?=
 =?us-ascii?Q?8x9CMHaX0KEyVnWLUC0xKB2lRAKmuVJQR5O2SbDqTxAZfXHo+PRoE7iLkSJz?=
 =?us-ascii?Q?sR/W+iB5V7ZlNSYKqBhhsNdj69jUB96iLRY2PCKUtAVCo0Y4EsDrUbVwiZwN?=
 =?us-ascii?Q?0gnPvLBPPjefUhNw4R/+uxBSnEhXJFf9hoUe0/Xy1ZajVaucszrHYZZsYty4?=
 =?us-ascii?Q?D9MTp/T4yoi5CK9QWvXS2+sc8uJBBwkAL43rUcq9FhrdIrw7ZcFCKzdljfPw?=
 =?us-ascii?Q?w/sgsLQqm4aQKSX3Zo6bWVYk0JYhpqSzjFP1uFe+L1sb30iKsPpb1IOIjOJ+?=
 =?us-ascii?Q?AppFXHXBfs2oPx4kAjQ1DR+7IEPzI/OuXdj7p5afisMPLLjIi/yXqHnKgVaF?=
 =?us-ascii?Q?5rg3+o2QselCud8bNm1cWTCapPwtZDOtq8U1rWR02Ki/Trc5wd1wLVApzOFY?=
 =?us-ascii?Q?QqoHYuZfQin0aMQHIWjKUz3cm4Q0csi6rKBZLoKO6A4QwnZxW6nQZKq9EGqu?=
 =?us-ascii?Q?pFd9/dNu/IkR1ivTdSCCRjc5g4+J1Pu4981xyP25qIiJLg0TLk+2qhpZn5eP?=
 =?us-ascii?Q?8+5c+9yxYstEalEHeLu31jcidZqmNompzBxniILbmHx29xeJBhuH0o/6awJt?=
 =?us-ascii?Q?ski/8RxrQi4mlgWrenEpwMk9y7FEs/S/MDcxjWfZ8+augEOXNIKivS82QCtt?=
 =?us-ascii?Q?xpBYCBOTZA6Ea4bfegWlN/7CTlnjkgRxB0c2nAkg91sWeziBa0mIQfBL3mF7?=
 =?us-ascii?Q?qR7uzdYlz6fqOFc6Vl0HwEojK+ohfZU2Uq9OMg7kt2RPDzsBgFsX7+OSPsY2?=
 =?us-ascii?Q?tVbE10Xc0eVV1Eo5OKH+kZhu1UGUcK9Bmht5wGhWlndNfBx+ldEP97W1yi51?=
 =?us-ascii?Q?i0bumpGDyY+FxwS4w9RUjLYCwenRLPGv7wy3Nty/DPth+gmjnkWn6ZfWmo3J?=
 =?us-ascii?Q?5IEuUwUMxcB0uImRcUl7VqkbdWP/7JHjXYLMh17lNXs8CgLJ5l4OLdG0QBLC?=
 =?us-ascii?Q?HvTatzHGYaIGQ39vDqLdZeE5Fs2RocH3xcBxMS6UqD/YsdUSC8jRpKV7hImY?=
 =?us-ascii?Q?tZFsSWuRwqnNTOb3Dhii95TgnZy+7rbYvQrVQl79clT7icpv4laAvxd61FrT?=
 =?us-ascii?Q?HQMJLli2ihaj7hYqhIk7HWr/2di8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tmqYHFyMBQd/xh00GdMGbQIxeD/vGHRieeFs/JdmKLZKrjnMOMFrNI+E4XoQ?=
 =?us-ascii?Q?9KvXmc+4SBpoW09rQoNBuBfgCZPwGHCBL1AtQy3QPsoYCxi81OSYgKGbeLUB?=
 =?us-ascii?Q?p9iipT/VSLJTvl8wZB2SEnu4fuACp/p+HVCyrV+vjB6H+zq2hE4LH2T3Cz3q?=
 =?us-ascii?Q?Y9KE2H7WXgHBASzJVfa/TSFQGsWf6IVHHT/ZPpfHwiOqElESWotmI6cVxQ/l?=
 =?us-ascii?Q?4CEB7NxhdPkAIkM9bkLDLU0GhSZmUgAqJBMx3rysLe+09CrVbEdLZEkbgV9s?=
 =?us-ascii?Q?m1uB5TmhDiAid6rHQRV3cSALGByPaJVYAWg2QFMv5mT1EUmHISuuLpnzZtOk?=
 =?us-ascii?Q?D0CcnFpmRkonC8fVAvO3654u3tTv7FZxhwvvwCnumZMSpo1urgY3mAtrvPla?=
 =?us-ascii?Q?E7Qsw6ci56ME1rihZNaDZL0oEwBVoSEallm9Lre+ZQVvbfqjeLCrB2alSqDf?=
 =?us-ascii?Q?Z3khbhyNxW4L7ZRLxwcVbahvsrHoLlas8OK8JHr2mMTxnXqp4/GOCr7xy3Zs?=
 =?us-ascii?Q?HT/l8SD41a5uEhnLB22t8Dc53zNKoq0/rdpLBsgHdevIevhaZOIgjr7wgHN9?=
 =?us-ascii?Q?5E8p4Zl49zml8s7ifdRyOh3CV2rowUq6HY/fDoWecXYDfRxKY+GIxSqWcZkA?=
 =?us-ascii?Q?ffqhOZOY6BLDTvx2dj5Xkz7JHJAq9BDbLPqvfHHH4EkdbuSwdaRXCUnf4C8Z?=
 =?us-ascii?Q?O285iLGMs/jAezMBh1OXMn1zZE4fjDlRr3Wf6OcHbuy1gOnn8mLhkksm5TUD?=
 =?us-ascii?Q?vAAEgp9U2SnJ3/CxHxTkrqyDada7EXqZ/1/e/xqyilg4ON8jy/NByzGEy4gf?=
 =?us-ascii?Q?SN4ZRUJPT/BVAV+GN35elKKoFN4aDVX02qxJs2xp68nuN2lT7AeNkjC58ary?=
 =?us-ascii?Q?5PUJ2y3lXD3aLTVcYFoQLGuKOfXdWAeVb6bHQ/ZDjUoyzjrfUplDV0jYCcjk?=
 =?us-ascii?Q?i3JWhojkJShveoIciOhZ68VJnDIxa1tL8N7VbkUqk3DAZEF9SFmIsZtDPF5e?=
 =?us-ascii?Q?z8jwhfsiz0qBFhol/3HoCosiYVxHfxoFogkfqTCqMkE7/irea1nxiMao+1uw?=
 =?us-ascii?Q?ys/+PHRR1t14349NEZWE7DGVMBqz23xwFrzeWBZ567e3suM8gzgrwdQ871EP?=
 =?us-ascii?Q?UiWXIh8v+UdkPcngGqWkeLwJN2+ObPj782lA6mIfpUJAoVOCJxDUsUjKVTeW?=
 =?us-ascii?Q?gwOpYm8H4LYE9leObmnbbOm3ufumD6UVUlaVHdnM6jTqmzsoXNa02yD8xCmz?=
 =?us-ascii?Q?GTIKtoajKTRyAZYPLRPmO3+ostTSjgQmK9vKgJby7nVVLOcfSdTIgPc89xUZ?=
 =?us-ascii?Q?PJ2Kb0IJHOBwA2K94cPBm6cR4pFkULTN3KDtfhqZGnEsZHnNV4Zp299CqYGY?=
 =?us-ascii?Q?tvlBU10X7M9p3TJHsZofJihdnn61mDVl4q1fJFqILwTAbIhYU/2sEPv/z2ai?=
 =?us-ascii?Q?guE+bAjfHYgrNt4Oz2iBIFBYP2vzffPdZTGNFdiV31W7E6KUOTsBjf8lukjS?=
 =?us-ascii?Q?f1EXujXczTc2LaPAd/TNrh5r+QmrPhelBLR3EFcy/J691m1mrog2mbKJaFoB?=
 =?us-ascii?Q?D2FZMNM7XdjznExC1DlG7I2/Pv5hY3IPsw2exrZFMAE52Ur3PbURqslhFH1g?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L5Pz7DBmXD3SO22EumdpZKbcffdcFg6rgKG0WYbixmUIshIpNPY5sLRADawSJ2L1vl+TRk9ujPRdWv42XqdncUZ/P24KOyiphKXHO2GgguXARRrkyGqkkxRVR9+0lTQTGewcA5Z1yJLjqV60a6eJA+ncaeSrKl+pW9g5ZoRiKyEaXy7PDQX9vM3Zyzy8/1dvGk/t11xe4NljvSj2IawlrDtvW0ANNE6evQhFTHj/k8h/0MPPVUcst8L8p5VGiIjOm2lOYyAQrav624xHlgsJM+3lTTJg35DX8ea8v8ags8osUWM099PIyXO8nYSsYI/oI30BL36mO1nhkA93kDi/8pcvaXGTQAOO154M5hZDaBTHZqh4v2WYtJwEBT0XQWsj1fI6k5U1qsSgw6umq7mYBTmv+m5dGBI/E8pU33N/thhi5Wc3Lt9lxfHMCJWufpmo9cdyLu0/uGRbkzHna5kjly5IvAHD902BGWO/JzL8AgWj4ERvNOw02XDuNrck7IdaZKzd8UKs6b6FZVbyqEZ9OXZ0vwpBZRbN0jv0JLbR0cEt9JxjD/AThoB8fdnEduCbK8md6WUr2PmbOUjd5Qz0N4AQ5KOWu5GA3jDZOYOe+vg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fff5cc6-29a2-4b40-8788-08dd50409792
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:20:50.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyV3gt7mhZ8BPa7VLIK0lSXCYf43Pwn32cZrKpG2JZe8zFxowmXJwPpL9jieLqISmjkebx9DzuqC6MJJ870KmCKqOt1ToHUpByyT7Fo4mvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_08,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180122
X-Proofpoint-ORIG-GUID: lXUOXWhX7BLxaBVWJpXKhFMsDVxNaovB
X-Proofpoint-GUID: lXUOXWhX7BLxaBVWJpXKhFMsDVxNaovB

On Tue, Feb 18, 2025 at 06:14:00PM +0100, David Hildenbrand wrote:
> On 18.02.25 17:43, Lorenzo Stoakes wrote:
> > On Tue, Feb 18, 2025 at 04:20:18PM +0100, David Hildenbrand wrote:
> > > > Right yeah that'd be super weird. And I don't want to add that logic.
> > > >
> > > > > Also not sure what happens if one does an mlock()/mlockall() after
> > > > > already installing PTE markers.
> > > >
> > > > The existing logic already handles non-present cases by skipping them, in
> > > > mlock_pte_range():
> > > >
> > > > 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
> > > > 		ptent = ptep_get(pte);
> > > > 		if (!pte_present(ptent))
> > > > 			continue;
> > > >
> > > > 		...
> > > > 	}
> > >
> > > I *think* that code only updates already-mapped folios, to properly call
> > > mlock_folio()/munlock_folio().
> >
> > Guard regions _are_ 'already mapped' :) so it leaves them in place.
>
> "mapped folios" -- there is no folio mapped. Yes, the VMA is in place.

We're engaging in a moot discussion on this I think but I mean it appears
to operate by walking page tables if they are populated, which they will be
for guard regions, but when it finds it's non-present it will skip.

This amounts to the same thing as not doing anything, obviously.

>
> >
> > do_mlock() -> apply_vma_lock_flags() -> mlock_fixup() -> mlock_vma_pages_range()
> > implies this will be invoked.
>
> Yes, to process any already mapped folios, to then continue population
> later.
>
> >
> > >
> > > It is not the code that populates pages on mlock()/mlockall(). I think all
> > > that goes via mm_populate()/__mm_populate(), where "ordinary GUP" should
> > > apply.
> >
> > OK I want to correct what I said earlier.
> >
> > Installing a guard region then attempting mlock() will result in an error. The
> > populate will -EFAULT and stop at the guard region, which causes mlock() to
> > error out.
>
> Right, that's my expectation.

OK good!

>
> >
> > This is a partial failure, so the VMA is split and has VM_LOCKED applied, but
> > the populate halts at the guard region.
> >
> > This is ok as per previous discussion on aggregate operation failure, there can
> > be no expectation of 'unwinding' of partially successful operations that form
> > part of a requested aggregate one.
> >
> > However, given there's stuff to clean up, and on error a user _may_ wish to then
> > remove guard regions and try again, I guess there's no harm in keeping the code
> > as it is where we allow MADV_GUARD_REMOVE even if VM_LOCKED is in place.
>
> Likely yes; it's all weird code.
>
> >
> > >
> > > See populate_vma_page_range(), especially also the VM_LOCKONFAULT handling.
> >
> > Yeah that code is horrible, you just reminded me of it... 'rightly or wrongly'
> > yeah wrongly, very wrongly...
> >
> > >
> > > >
> > > > Which covers off guard regions. Removing the guard regions after this will
> > > > leave you in a weird situation where these entries will be zapped... maybe
> > > > we need a patch to make MADV_GUARD_REMOVE check VM_LOCKED and in this case
> > > > also populate?
> > >
> > > Maybe? Or we say that it behaves like MADV_DONTNEED_LOCKED.
> >
> > See above, no we should not :P this is only good for cleanup after mlock()
> > failure, although no sane program should really be trying to do this, a sane
> > program would give up here (and it's a _programmatic error_ to try to mlock() a
> > range with guard regions).
> >>>> Somme apps use mlockall(), and it might be nice to just be able to use
> guard
> > > pages as if "Nothing happened".
> >
> > Sadly I think not given above :P
>
> QEMU, for example, will issue an mlockall(MCL_CURRENT | MCL_FUTURE); when
> requested to then exit(); if it fails.

Hm under what circumstances? I use qemu extensively to test this stuff with
no issues. Unless you mean it's using it in the 'host' code somehow.

>
> Assume glibc or any lib uses it, QEMU would have no real way of figuring
> that out or instructing offending libraries to disabled that, at least for
> now  ...
>
> ... turning RT VMs less usable if any library uses guard regions. :(
>

This seems really stupid, to be honest. Unfortunately there's no way around
this, if software does stupid things then they get stupid prizes. There are
other ways mlock() and faulting in can fail too.

> There is upcoming support for MCL_ONFAULT in QEMU [1] (see below).

Good.

>
> [1] https://lkml.kernel.org/r/20250212173823.214429-3-peterx@redhat.com
>
> >
> > >
> > > E.g., QEMU has the option to use mlockall().
> > >
> > > >
> > > > Then again we're currently asymmetric as you can add them _before_
> > > > mlock()'ing...
> > >
> > > Right.
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> >
> > I think the _LOCKED idea is therefore kaput, because it just won't work
> > properly because populating guard regions fails.
>
> Right, I think basic VM_LOCKED is out of the picture. VM_LOCKONFAULT might
> be interesting, because we are skipping the population stage.
>
> >
> > It fails because it tries to 'touch' the memory, but 'touching' guard
> > region memory causes a segfault. This kind of breaks the idea of
> > mlock()'ing guard regions.
> >
> > I think adding workarounds to make this possible in any way is not really
> > worth it (and would probably be pretty gross).
> >
> > We already document that 'mlock()ing lightweight guard regions will fail'
> > as per man page so this is all in line with that.
>
> Right, and I claim that supporting VM_LOCKONFAULT might likely be as easy as
> allowing install/remove of guard regions when that flag is set.

We already allow this flag! VM_LOCKED and VM_HUGETLB are the only flags we
disallow.

>
> --
> Cheers,
>
> David / dhildenb
>

