Return-Path: <linux-kselftest+bounces-16848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A696696B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9051C223CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 19:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531E16C852;
	Fri, 30 Aug 2024 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pzyk1l3v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iTJu7MzX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033213B297;
	Fri, 30 Aug 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045459; cv=fail; b=s6rOxuUhvJZgZqN9npvlc2+mJoExC6JuBK9+ceLsmP79PUafc55CP7oeF6AXt2C8CTvC7UpEAswV9ffH6CLFRvTgwqnM9JcOcW5AXqTONSbhFt6Rume4704u03NsR+V2Rnuu70AeqN2FpD3EcRZkyJfZsEe+NM9HGYNjnFxanyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045459; c=relaxed/simple;
	bh=RYq8n0kfsq2lEsM2BCtGw0IYC79cTP/cmhs+3i7GZ34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mtG9URl66qSP1uJbW4OgNH+IPmgoTDssBLmIR1O7snKLAj3rmzTEevPgFn3tieLY31JLr3WbUgYmhd4KTaMNBkgXz8dTc0xJ4uf/P0erWqX8G4aiQwqviaA4U764zxkNFdEV5qCYIaWLAOn3Xbw++lHwI/8SBA6nQGsZJe1T2BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pzyk1l3v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iTJu7MzX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UIfT3P027072;
	Fri, 30 Aug 2024 19:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=STwFz7jp2Klebec
	na3RQQ+YBFKLBYUQ1hwAUfS1NCeQ=; b=Pzyk1l3vq/Lv27vVrrtansOjf3Fb+I+
	WFsmXqfOGUtYvUbLNzdrbvzg4LEf1VuWeWbuXFcv6xbcG92Yal1e5WJL0e/xKUlQ
	fYDMYZDHZ0rmUO7rTFtYd1Cg56CD5WsKNVEfli3scsMCx97HvrJ5uiDrkfhj0lzO
	0j6qrgCA0LJkA1Byaw/eysmv7GFfta9c/RsGfpKgbhB+joYXVIo+UPaYYzruSxwm
	g8zyM1MylLmwGZ/nh8LOQYK1vFFOrAY9jdyfcgg/6mTRQt3akteOxKQXic3kpnM5
	0yhropvgqVyuyE5/jMbmaNmCKxBwr/MjoIJj7/VU7kAujyHj0eZZgvA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugyg82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 19:17:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHNaE9020156;
	Fri, 30 Aug 2024 19:17:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8s6e8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 19:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3ZgC/OfyUysMK0Kb7PKxH79nykYhiZR8E64LA95Ja4/xxKsGBeynOkIF0b8pfgQEMjx1hx5idW9SlzlJZ/RdOwwj4n8jh+KQyE5CNZX9dU50UHzoW3qsoGcAQJgmIc8ant2TmSo2jI/HnkONDkw2uBusjsvRD1izftHjZvbbVxQ/eXK9N+6KMTlwfQHNM59qdyQut0uFBmwOgQwpnqKrUAs3tiNerFx9MPk1oghc27N/VyF9tBlzkrlxGJbUnXJyVE7u8OSyF094GuktS9/q8F0tRYO5e6pgI7jJ6HnOJ1EKtAfa0FdOaCVzuDoq8kvDfiJ6CsaGbln0Xo3JAYtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STwFz7jp2Klebecna3RQQ+YBFKLBYUQ1hwAUfS1NCeQ=;
 b=pqJnsfwcusguEQwK993zDmMw6OVpziKvTJpxjTkBvnlG5Ns70QNKoF2gnnQjMUZZOXYyypaL8ZJjskC3e7uWnIJCieeuGpAdXqo7kvhZ0ZgYbsE3hU0BO/aE1o76JTUM356M2WDliiz0eYUWKOqLYTsH3DNgA7eUBOsCUciKnpm8iv6BVg1ew2HEMcTn05R+Z829RDe33bsti/rhGNJ6p0A8XvvCm8UUN3lPqKhvpI1gdAzp3YmE+iQm6G3OgmFAdJU5q6rCluEXdDx4n/GD/G5BL/LbeKKs47WD6Pc9iiyoHokEgEdZ43pyLk5k7mV9tQE3aRo+0MBFDLvQn8A3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STwFz7jp2Klebecna3RQQ+YBFKLBYUQ1hwAUfS1NCeQ=;
 b=iTJu7MzXrIIfoFuh4jQiycoz2L3xIbX2iQPHpObaehsnAIbCNe1tyWKDsLWEI79K16/nmjhHjYlKQyyfOeVp52c0ATf/8qVPGJXm2Fa6EzJup1d8Wi4oAefSuFW1pNJ69dojzXHZa/acP+mhBhCEYbDFrMuj1ZSz4Zq1RLmQQsk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 19:17:09 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 19:17:09 +0000
Date: Fri, 30 Aug 2024 20:17:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        willy@infradead.org, broonie@kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 0/5] Increase mseal test coverage
Message-ID: <9f2f751e-2acb-4a27-93cb-767628b38236@lucifer.local>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830180237.1220027-1-jeffxu@chromium.org>
X-ClientProxiedBy: LO2P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f4f4d6-9473-46a0-68c4-08dcc928583c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NP/3TI8SbAbweDuj0QUc+QsxTujp1ZIfm8ULbxAaeAFRUK49nD4KHuvKlz7C?=
 =?us-ascii?Q?d3qZNBfd431i6iYcyDZWhBMm/nEbkDXXI3/jNpv9U69qOTgsQ5oP4PDHEvWN?=
 =?us-ascii?Q?7GDB0mCI1FiQHhYTghwwW6WvgXUmzXFj92RD2vohEkEbT5gpX3JMs+I+dsba?=
 =?us-ascii?Q?xq31GSvBwE4pLokGcrlTQ1zqwLe8SsHwbg9gjvBVno8nYuxZ+TE3T2rtPGFi?=
 =?us-ascii?Q?8cIFu8dvGeRmBKdzbeRBvQhRZfWFLx7C+ky87S8nLtlf8VBqDqKoR8e7iuIW?=
 =?us-ascii?Q?a1FpDFtzdOW7e5AePfqly9hN8rNJQcNYXel691h5CKGlNoeOvp+B5nrXE+Nb?=
 =?us-ascii?Q?4/TsQBiKghupXQn2K7bO52jEvdQPB+9ztamM6Cm2qRqp4mpmLkz3YZ63z+7d?=
 =?us-ascii?Q?qIAyQUH6JBUp0S6oBBcHMP4r/UOG2oy+d75EVouHK42XdpToSAyfJwug6zcp?=
 =?us-ascii?Q?eRqcbxwDX6Y8UpLBm/IBvM3Vncv27BuEJGledoLcVlUEH20szbu4y6DBv3fW?=
 =?us-ascii?Q?uHHZvo6qbVXEFgYdnY83Id+KO5ggZI27368C8SHroNrGqAzDPoQBr6cY90mS?=
 =?us-ascii?Q?dTtIJRs/LyaS4vRuGtzys+WSSIxg4tBIiZiaqGTi1nBgCuhR54LNpO7M8lEa?=
 =?us-ascii?Q?UIijPGkfNPWMn15v9zRT1JJNF8kXhm5Nq7dRji57ABac46/F6ZgOeEcEPLl0?=
 =?us-ascii?Q?N7DbP3G7efC6agzo7Xwoo6O641I/bZJaJSSRxO75FVow3LxljopY1eeKsdNg?=
 =?us-ascii?Q?Fsyjdq/iidcah8L+TDQML3ZeNYLssL2iKn3RsGt+IjymRuzcOP7Cmt0XGxuO?=
 =?us-ascii?Q?QBRP084zdm+P4KRfTsbP1DaB+WrPyrjA6oUVsMRDbY0ooRH2bwD8liJAODho?=
 =?us-ascii?Q?lv7VrsbVMU4jR9iioVKG5ptRfolPmGP6ToneerfeKZwJ1idJEX/UD1DMPIOV?=
 =?us-ascii?Q?UWg6L8/YU0BdJtIcAA1C9MJMr6CB1+15sQr/A+95W4qSJcsKnSWqOHBEFOUZ?=
 =?us-ascii?Q?cgOX/WufbnCpnImFnbNsXjXWiZTb7l1JIHBupUWVJ6UsEEPxtumkxdpXssJH?=
 =?us-ascii?Q?x5Awy1mFYAg5H4qEslD5O4cp6xVmygbUS+tMNbRKjTm0ERe46wKRsWq4mGNr?=
 =?us-ascii?Q?bapoH4QzJH+eQhpZj3ky2aNcvQ8LCpUlVxmLaRTymKndbHAvMTgiqyVUdEga?=
 =?us-ascii?Q?QRAEyOwCLyFm441zhni0KEjF101vFlv4Spptb2hG2tbvxjmT0GXt3mrYV/4/?=
 =?us-ascii?Q?Y7zvR+BdlPMx+bwpaV2KtIkID8NDrCEsYIngliOWwwUMjLBf0S4fsUvPcbXZ?=
 =?us-ascii?Q?XldSEZuNGSD5iqsUe4dmrlOU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lfZjYApAYsGuTqieAFoq/MlvRVKrP6OL5+dSw0x0g/y5cYRVnB2kFXWuYil3?=
 =?us-ascii?Q?RioD2HNy1Fm8MEbggXsA5K26BFP9ZeBBh/ThzT01cStVCdpmRPuJjKo7u238?=
 =?us-ascii?Q?vLTSkh74fibCSmrwedF4z85FuznW7fVtnh1yMois9lCScIqBbyuReKyD4lXO?=
 =?us-ascii?Q?XKdNoSswPiZ7NAKp/pUmmlPrudcstCwmdoL+ozgF2acJPWQz0pv/RYfLAk+D?=
 =?us-ascii?Q?r3EAxIIbC5DI5bq98WP1cznOFLOk6yx3Hz5tqs0iU3upMfsdIuP/yymfCmai?=
 =?us-ascii?Q?2fCsK2HBZE5/U41GIdshaem7aXuV8lGoWv9YOu79+XLG0mdgfURZvDssHua4?=
 =?us-ascii?Q?/E/JSjG/LSQ9HorlPgBuS8hdvK7e2sD2sWWWoViPrrC7awAFWOlrs9cPTLdS?=
 =?us-ascii?Q?9BzxnMGT1N5yiSaPCMpQrC4Ch81cutwdSyUnZhPfwKcrAtmx7o0I1iPJHgjq?=
 =?us-ascii?Q?MhpI+W0tqZHWXTAS3KCdAMxoGF5NR1svVMluPcTs13ZTTHgHClJS0Sv+c33s?=
 =?us-ascii?Q?c2p1+yv3vk9og5a/9oSrUt7HU7HKKBHP4JHmcRl3zf6NSOECGR6x98UPE+qR?=
 =?us-ascii?Q?zDYY05NZAn7azZrWrI+3vG2YWhJ2wYlGKfvAQ75sX1NZgkO2WHWmv6uvLkZV?=
 =?us-ascii?Q?/JIs6l62c9mw+6rJyUTZD4HoQQoB9oXi5iE6AP6PG6ismNIE+/EgbF7hkDF7?=
 =?us-ascii?Q?GDlaBqnmb6ZMqZMJKvnqivxTkoPZEUcx3Cy5S6eBnoKVNmU/SccjUJGrjb+D?=
 =?us-ascii?Q?yKLC8KwksqIUSA76W8OXzzD+iAFymHloJIG66+/HKtzPtKUnqVZGRrSfMHsv?=
 =?us-ascii?Q?Br4cVF/I0hsYScN8xCtdHKLYXFQZX1SbKcA+bpChOm1rkli7dsSdb9K2MnyO?=
 =?us-ascii?Q?vSenScOTnYfEsHtzmygmPd2AVEdb35tIL8QqSAoWb+xR3OA77z3XlAdB5D+T?=
 =?us-ascii?Q?Wjf4d4pro2IWYPbW0kj9UNBAletvjYn0GNwyCYUkMjgIu62j+aZVaDEdfQq8?=
 =?us-ascii?Q?8OySp8cC4B5S9g+ouXqWw5icDA9JE8yZxGQLFQnohWozgrA78gyacpOwI/JU?=
 =?us-ascii?Q?M88TWvSbbkTa6TmcNU1Bsxrv/Rf/H27ZKf233GYxvc3j/kLvP5pHHHmXo2yV?=
 =?us-ascii?Q?5eX8e4j8iBtQcQCD0dDjSsQGVxq/3LeQNdd04+c3QdQ4mgcNrWbcvNPr+sZ/?=
 =?us-ascii?Q?Oy+l4m6H3U2FqmBc1LaWaiDMrQ88iCjkzfY93BA6bqPRmmuVmLzdiVoCe8+G?=
 =?us-ascii?Q?oaoGWxKhHDEn2t1yQfInEgA/qtuVo4egHvNk7Ck9JH9jEmh0ZmwHYbLiW2l2?=
 =?us-ascii?Q?Th5r+oISJJRh1snN3VihMBvi1ap2kXm31Rt2HApgXLivDuNtU6zz1Y2xjWjT?=
 =?us-ascii?Q?8Eq1J3AvcHQRgUCFVyH8CDrYwHLm6W12KR90W/RXpSojGaHYYsoALF4LPIqf?=
 =?us-ascii?Q?4IRUf/fzREVqouDAbZQ9xoznrWcyILECY7L/9AqNhHsv/WzKnTiH6SzhwNLx?=
 =?us-ascii?Q?q8rE/hmBSrHYAy3zNbdIvEehmPNmsC0Mbydwc2h1qb4mfnb0qqGpwT169RJM?=
 =?us-ascii?Q?u4c15L6OiRk165YwG2g3BqExgbCYz8rCankFORv0dgTmfEoPt809YYvgQNiq?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XoxlvVniGaIYmpaOo+nzEVIrNOuU54BEn0oZE1Xg/mrwGFXGc6ZdiOCmX0c7yDPMlIM/DmNxRXwIz2dCbeeqqMpcJA1IScVMHkt8niezyOiIxkUFqAuI/cxdYcp6H6hRSmDjkOlYC0biKkOBopeMSJ1Al3ORc7Dtysp37kfO5kMEmX0C+Jq5hiNWFaMyjh8bjuLyRHNcyjrb9yAA4fBwBW5bNS3kS9s4Rpm/XB75JPJpAa0tTGVGj1YEVyT+DMop9RhKm094lXOtnVPqyAICpIqEvXOTl7qv1y3lhURPjy/H8uzaUQwKyu7oQlx3UKbBJJdHBIOa4y2FHGFiz93jl99/J5bETGuSERi9S9BaUoI+eeXHhgGrnFr8NoKOKgO6RrOGrqxuPGuCjQ3RCgkdwgq0pWjWQEpX1nAfSPjVwgP9blVEMx3pA8fl9yko5VEh4vbYrxXmcWgqDHCO2d825y6MY59sf72hxPqA/Smrv6DZd5kg1PAe1C7kOumCG2mnnBsOF6s6pvSWBaoH97ym9D4ZD1DCoFKXDLbEWd/oXf01KHf4PEfXZLEUz/LbX2UYq2leohnIcZ/y8SLEBBKLlHB/t+4dc+vT4fSN2cwIUPk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f4f4d6-9473-46a0-68c4-08dcc928583c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 19:17:09.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEoOPs7oUir6hVDCe35xC72gDk7gxD0QVi11Un8NL9psYpezj2rnxOg2rOElUo6cARsJvFxI19KUw1ec2KjQpahAJjQIby9Sku6TRt5olz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=930
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300148
X-Proofpoint-GUID: Wa75_sO8UPuNVgwg5uzJVT_qTJgJ0ro5
X-Proofpoint-ORIG-GUID: Wa75_sO8UPuNVgwg5uzJVT_qTJgJ0ro5

On Fri, Aug 30, 2024 at 06:02:32PM GMT, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> This series increase the test coverage of mseal_test by:
>
> Add check for vma_size, prot, and error code for existing tests.
> Add more testcases for madvise, munmap, mmap and mremap to cover
> sealing in different scenarios.
>
> The increase test coverage hopefully help to prevent future regression.
> It doesn't change any existing mm api's semantics, i.e. it will pass on
> linux main and 6.10 branch.

This is a big improvement in detail, thanks.

>
> Note: in order to pass this test in mm-unstable, mm-unstable must have
> Liam's fix on mmap [1]
>
> [1] https://lore.kernel.org/linux-kselftest/vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt/#t

This is already in mm-unstable so this is redundant, and as Liam explained,
his new v8 series will contain this fix too, and his old version will be
unwound before new applied, so at no time will this be relevant.

>
> History:
> V3:
> - no-functional change, incooperate feedback from Pedro Falcato
>
> V2:
> - https://lore.kernel.org/linux-kselftest/20240829214352.963001-1-jeffxu@chromium.org/
> - remove the mmap fix (Liam R. Howlett will fix it separately)
> - Add cover letter (Lorenzo Stoakes)

I think I asked for more than this :)

> - split the testcase for ease of review (Mark Brown)
>
> V1:
> - https://lore.kernel.org/linux-kselftest/20240828225522.684774-1-jeffxu@chromium.org/
>
>
> Jeff Xu (5):
>   selftests/mseal_test: Check vma_size, prot, error code.
>   selftests/mseal: add sealed madvise type
>   selftests/mseal: munmap across multiple vma ranges.
>   selftests/mseal: add more tests for mmap
>   selftests/mseal: add more tests for mremap
>
>  tools/testing/selftests/mm/mseal_test.c | 830 ++++++++++++++++++++++--
>  1 file changed, 763 insertions(+), 67 deletions(-)
>
> --
> 2.46.0.469.g59c65b2a67-goog
>

Overall having checked one patch in the series, I am quite concerned that
these tests are not testing what they suggest they do, are redundant, and I
have found numerous problems line-by-line.

I've also encountered copy/pasted blocks, comparing PROT_xxx fields to
magic numbers, and it generally feels really rushed.

I feel like it might be worth taking some time on the next respin to really
think carefully about how these functions work, checking man pages and
source, and getting some understanding of what it is we really need to
assert about mseal() behaviour.

We're here to help you and want to be collaborative and help get mseal()
into a good state, so I'd like to suggest taking your time on the next
respin to really improve the quality and think carefully in each instance
_what_ you are testing and _why_.

And don't be afraid to ask questions and discuss these things with
us. We're happy to help!

Anyway, I am now off on a long weekend before my birthday, I wish you a
great weekend and hope we can find a way to move forward constructively
with this! :)

Thanks, Lorenzo

