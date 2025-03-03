Return-Path: <linux-kselftest+bounces-28234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD205A4EC64
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 19:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000558A3ACB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DB027932F;
	Tue,  4 Mar 2025 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OEBDA27c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pMTd4Tsn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF8285405
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111618; cv=fail; b=BNDlNYnqokGZ2sq9iawY8bitbixPXtIRo0gN3ZOOuNSGublUbYl1/p70BVp+g1QweWtA5zrI+UwmiSiTFA0BEOWrJfmR1wGvgHikT58tfl2XJKXqXmK2mb6HN2QsDVZrroJugf6xAlu+SvTnv/GKhMJrJ0FucTTqEaPfSL4oSvA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111618; c=relaxed/simple;
	bh=EtzYzgiruy67Pra3u+WsgfVXWlJ0EFE5SyLVFd6BLYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AvYHnK5mp3gvoqWaGpMkGH4SZAoLSPE1Vel8JoaQhqCPy+iul+mzp0GNuC4eIRbUjrqv5dfIiwiCGdUPLS6G/qH49DVJ2Jl3PpBaH/+IoIB4MZZ47Tg+nhsA4nPubrv2ptN6efpIbMq2LlULfRbeqAJoMuWbCCK2ZE4Cj538omI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OEBDA27c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pMTd4Tsn; arc=fail smtp.client-ip=205.220.177.32; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 3275F40D1F53
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 21:06:55 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=OEBDA27c;
	dkim=temperror header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=pMTd4Tsn
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6glL31mnzG2pk
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 19:15:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id F11BC42749; Tue,  4 Mar 2025 19:15:24 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OEBDA27c;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pMTd4Tsn
X-Envelope-From: <linux-kernel+bounces-541663-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OEBDA27c;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pMTd4Tsn
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id C0E1042020
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:08:31 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 2D5D63063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:08:31 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0743AA728
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C820E339;
	Mon,  3 Mar 2025 12:02:50 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E701CAA71;
	Mon,  3 Mar 2025 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003365; cv=fail; b=k0ByMjWY8eQ38SdXPIlZidqegLZfwOKDKBW3vFUPz/VUMTtZjRbKHrpYN1iExiz0U52wYPGBCBLOIZStjsA6tJ/Kh6WKwsGEOfVDZSp2+KcwGZj/uRp8p5vV8SET2q5jWjrEZof3K/98w7T3T/ZPqnQU6jsqdkHoRySk0QjXRns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003365; c=relaxed/simple;
	bh=EtzYzgiruy67Pra3u+WsgfVXWlJ0EFE5SyLVFd6BLYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HtrKtJ5DF1SwAa1kX/apdfwsP1U7USNjIQVX2ys8ecIYf1y5DZ2eltZQHxXwvvECDDBtg9IWSgXEvfB5eMAb51js5w1NN//x9U7B36Q834aEGlfd748ekWzWrRd+GoF4b6CCJlR0999CEvZl34xo3PApBQe8ljwhQg2fTc2vfWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OEBDA27c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pMTd4Tsn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tcb9022593;
	Mon, 3 Mar 2025 12:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zVd1CsMgJOAnI2GxOg
	TBxAT9+0CIwjhFUSlxRuUUAZc=; b=OEBDA27clN5c51vHLDMAje5I56Mv1OW/uc
	JQaCFKl/gEGzy0/0xTVXiD3fE/F9U2OINBs1Z8vYteI0imzzs6kz5RqiE/yYeaq9
	GFGlMFXryCmKuYZsfXYGsZAqR9zwCLo7BkM455Pv0KKGvG/crQcdxjfiS8k6HfF9
	xmF3tZHu1I2B4AmNJQvkUv2gE98TNoWu2S5WDEl/4FheAFtQMzCvRwypJ1N2rEI4
	AiWQ41/T+r9lJXYWfVxzOhdMI7z2JX0KyiO0JQ1FNNXxnyhw/1st5aUwXLtXeJHo
	IAXMJt/t8JcLrBqDMN9XGH3pSm+VMzJixo+YutNnUwUHtvkOBGEg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hagdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 12:01:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523B5L0T010979;
	Mon, 3 Mar 2025 12:01:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8wgd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 12:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHjjnuK1eKQANx0SDgYuPGOwp5ZHVUyL1McbA3zi7YooS4r58eHWHjw7/JLNQ3uX/XrPaCyG5A+TQjsTIObfIyTtbTcCMrV0b6hhInzjKGz5S5e+079ts5Tz88emVyb1FB7HRxkGZE2LLca8M/gMsa2IatdiF/Y4DDznwLvvMMOkFmCQhamy0GFWaDnpZilUJczshJ7b6VFGVzr0WHdCJkZzwF78OgwZmzHKP4NjyQ7PcIyKvdlvB7Zr8epDTjdKkVZGEZCdIaKwq91ZnCClce/rHg5bR5Ra7cZxGi8QcjyFGd15AG3/E/yqRYDDhTZhV8D6TjiYRUGJ9Xs8gTuCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVd1CsMgJOAnI2GxOgTBxAT9+0CIwjhFUSlxRuUUAZc=;
 b=pKh++a6dligK6mw671ngfA9MyT5S0IGc5I7gK41ys6lpEgqXwHTh97w9AFefLSrIlJrZ/rtk/z25a7mrwMdRRBEpOWJqq8P1Q2HSfM8vE0lMj/KCVEbK5VqFgjuKXBwdUhbnSXl7ZAjwNR2VNjr5L4a8VRlS0YOCzTpARfy+oBFwyy+6Uy/3xrZ7rV40UnKtNFPXNszeIEkgVBiBOHyWlrCKltVCVaApUZD/+ArWXNTZAUHqKvyA1JlZp3LPwbaSC+nQ2Xam+IdIQuHqAfYC7mrgIMgs9/8sfpr0Pj7oltcZq772UhUXtz87CBctmKu2wJeC2z3MjYCfvZ+ZTGebTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVd1CsMgJOAnI2GxOgTBxAT9+0CIwjhFUSlxRuUUAZc=;
 b=pMTd4Tsn3IT7AAVCmli3ievVJbKj9X7dzV+8f2y64nt6ZDXNQrMXzuZjK1TVbL/TfHyyxRAdwP6kX5Fp4vGtwz2jjpK1hKRQk+qbbYwzs92qpQNxKEsoDfm5IgQVKr/0w8cga2hUcYfuiu7ZOR1JZLfZVb4WQSi42+uo/YgWsfs=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CO1PR10MB4755.namprd10.prod.outlook.com (2603:10b6:303:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Mon, 3 Mar
 2025 12:01:49 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 12:01:49 +0000
Date: Mon, 3 Mar 2025 12:01:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
        sroettger@google.com, hch@lst.de, ojeda@kernel.org,
        thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [PATCH v8 3/7] mseal sysmap: enable x86-64
Message-ID: <24be17fd-4899-49ae-9b4e-9372fcb4e0cd@lucifer.local>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-4-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-4-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0201.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::8) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CO1PR10MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: 00eef48d-0914-4577-9ddc-08dd5a4b2dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FmezNx0I2PXF/YrC+c6PJLC0I3nUGbBN8UkxpnTrr5sMdCwz7IiJp2T7aKuX?=
 =?us-ascii?Q?zpls9sDQ5Q6D/c6+sAUgfQcrkppD7gxhjA92qSHXnZdEUqVC8Swze3dZiuoh?=
 =?us-ascii?Q?zkQZAvLk8IISaHSwBm2997vTY7DXdvzy2QY7ChGn+7wBB7Vmy5oNgIhlvtVB?=
 =?us-ascii?Q?qNvWf7RzDBcyeU4lODaL5+Rm+pQESN9N3tvOzd72NLT4+QEioKQk/sxHRr3A?=
 =?us-ascii?Q?xIDC7xJtwbE7DUJE6kFLNq6naVL63AH5WY0L1unXYL+Z8b063ldjlM1DcN+U?=
 =?us-ascii?Q?1kpk910X4AtwXAJ+ggpiqZFUM2+tWJ/fDplKAjS1rtKMeqTwaIvYyBwMF5SY?=
 =?us-ascii?Q?IoxwGI0dRzwzdtx93JqhHAwcIAM8P+XwA2YS3qcgNwTUPRYTPDdMA3MAaErW?=
 =?us-ascii?Q?6PKO7+FVFYP/5jKQjl0DUxVEnuHDqGnK5NSPzTVYwr46stVK9qldMUv1h4Kk?=
 =?us-ascii?Q?JpoImbu4LLyecDeystY0hkkncZ6v7Y82f8UKXffDD9+5Rkoyegi519VtAgg/?=
 =?us-ascii?Q?wOAiRqIpYLNnZ7eFxEHZuP6Cvg9o8BKHVkD33HNAKBSaifSv0cNsnYxRuR8b?=
 =?us-ascii?Q?vN85tLu+JoJ7JVe/6/nkPiJoEirjObCQ/zS19TJjugCw2AcTOz2yO5jnFele?=
 =?us-ascii?Q?bPM/xJ3TpK2itFgVsW1PQFrvdv8aiD5SN/OUFZL3nsi2Bo/mSKUrKaeLY6wo?=
 =?us-ascii?Q?aXsk5DkoAVgOhlxNhyfIEYLgfDPf8oxyw7MK3wdvliaISAcyQ33eVaMLaoSE?=
 =?us-ascii?Q?nU/X4IpjTKFSpIEnU8s2paw6aynwhNLPwd/mgRna4bC/xbHCQaPcSuDtK9WK?=
 =?us-ascii?Q?z4trIEVRvMHvOwjEiyUN2VHNzBmdDsYNhBwBMiskKYj4m8rpEp2X8PjoXuLK?=
 =?us-ascii?Q?p3CJo2VZErm+N1Kj0sxTxPlIBJ7eFAilruFqfXds2LFEPcMtYbOzh26JIncT?=
 =?us-ascii?Q?aboJOrb9sk16IwHx+6HuVon8aeXseHdvsJxqWSsfKBhrE4Q8x10EDyOncLIU?=
 =?us-ascii?Q?7yOZYAwoTbUVNCe03lGl8sIH0fHK8rH2KOusrEBfENtRiTcsCkSUQVUJizLB?=
 =?us-ascii?Q?EpF02OyLzM8IF4hmc8zbIwy364cv//Ib+xOVmGkoFYNElJvHuPpSdhc6oqxZ?=
 =?us-ascii?Q?sL4HMlcd4cz/MnbgZ4baf4ibJwQNCb3MRVxvkyHC/Q8+DPKIRviqOQaaVaa/?=
 =?us-ascii?Q?Mo5bDD+HgUU8XJSJS6qFrw9LvOLUy3MIk+Ngd0v7Ef7e4yqXzJyDyfVNZvd7?=
 =?us-ascii?Q?WvAC0Eb1wbbJayl0/7H4Jb2LwjW/1noFJHL1Q90g1lPi7iQDemKYyqTf4hOx?=
 =?us-ascii?Q?1cyc98rxzrZZuDyeCfbsRm8Id1SZiYARA9x/+OEh/z6v9nVQfQs7tFnb0p1g?=
 =?us-ascii?Q?NnkuHqSdi/sRo9clgogayx6lVJvE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uOgfg9fIfO//xVKNNCkGSkB7gCcDurolrEM4OzX5jOBqPS7UudX9BEi8F+Qk?=
 =?us-ascii?Q?X38a9ZUpXopMdDfeICMELaiUF4cIkzoRXx4LoQkdA9N+YGk9rM/UOneRTKz5?=
 =?us-ascii?Q?5W/x5koKsz+fV1mmJmdhjX8Thp4GhefOUuJ66MrsasP8eDDMep/W4Ck+9Lge?=
 =?us-ascii?Q?Rid+kXbk+H9h6mgXGbEnLzC8A9USYGBulHjosLxiBTvHHjwNNmdBt4kfrrU6?=
 =?us-ascii?Q?y06uoXl5Z1qZMQvlv9iJ1/yg4u28tVp7bf1hIKFMCpanMW+rr6uV8FT9tZTb?=
 =?us-ascii?Q?2Z2eVFOvQtoTsISE+mzlC5iZVsNubIZgbX/X9JAFvokYbKA9VTbPDZClS88v?=
 =?us-ascii?Q?MQjKBBnCPYcQMwko7kVSXRMg0cpVGza/kdpZ3lbIGeq5MAenze1paXtAWIKN?=
 =?us-ascii?Q?TDH3iuLwhuSmtOq7GgfrC8t/RE/ssyj4zgDx6FmVaqE8Ls8/gWtn893yWUTz?=
 =?us-ascii?Q?EeUGhQISzlLYoZyAD6oVHKtifeUK3xkiphbnBxgFzkrbDjhzXV82q5tS6b0l?=
 =?us-ascii?Q?ys5JTK6JHp8Mroceur+vZlVGHxYS7lE1Jlxfjawmy830ILwaNjpqXFdl92M1?=
 =?us-ascii?Q?WjLiViAyA/TyFC+tGVZG9uEKczwtLbSd66ICmoza+VQ50xvztIWXcqQbK9eY?=
 =?us-ascii?Q?O3fDprwKN3gG2BK8C1cBC7l4AQwl+uRc3Z+s+KsYkk894S7zVThTXEGTa65p?=
 =?us-ascii?Q?IIU8Coi1tmYKt91v5cQKZWD89iIHQl3CiAENb2mQWzk7Cu5/AjSya/o7Am0U?=
 =?us-ascii?Q?kfwrHp/lfOmAtTvzYoiSLgrag+S7pZkJ42sH7waUl85S6HRhhFgRgIiY/4w2?=
 =?us-ascii?Q?LI0fGR1NyMBBE2B3+caWl9+Vn91UH4GQx2wBQ5QSem0AKrq7l73ptU8kdb8c?=
 =?us-ascii?Q?d03ib/FIj26st99W6nbcKe0Qho4Ef/5HCumkLM3lk/QDE7y1lkDn9hsssGax?=
 =?us-ascii?Q?kS/movGDXI0Gn6SS5eTYH66sqzm46o8U0obYG2SlNEpLrAqKboAzOH4OjwsD?=
 =?us-ascii?Q?WY6ATYpn26aPXc2FZls2jgAHdng8mKf1MN5Kt15Zm99OvKPbgg4OMWe5gudd?=
 =?us-ascii?Q?5W1n1zTmcaNYHu8diP0ozXrNyGv5WkOMmgQjBbIM8CiKGvYbdc6iXh+LadLv?=
 =?us-ascii?Q?D/o9TIh+8VQPJe59r6o6jL5ODcgTGEmGpkcm4qdtlQkVLX3prVpSp+B3/0I9?=
 =?us-ascii?Q?iWgZCq+2xePrXYNwLQHWSuoTf284SjD0Uk2xMun6As520+oWlgcPyrq6zwzM?=
 =?us-ascii?Q?9z0O/6is0jp25WoVUi32RKZ3ioRz8Hl4gll0b3HTKvMzqUxdUC7fVU0CBldj?=
 =?us-ascii?Q?C4XaAQemlRlp/vGq8a+pITqNief0W00DWRbWPx6N3e/pi7cGBZqK7mTh+F53?=
 =?us-ascii?Q?zoGGdAtio/DnaBTggaTr6abMXwpIGIoTYhscWBLmuvirE/J/niPHJTuE+KXs?=
 =?us-ascii?Q?jgdwJJC21uIX5Spv9gFERvRq6baxCqOpz2C9lXdFe1jeu+zWAjgSbHALwe4G?=
 =?us-ascii?Q?8AUHWgaji0KzK7PbxU+r6x0nJJpBvL6n7IrW9SR5Ke5y0lNJNff/9e5D1IHc?=
 =?us-ascii?Q?AKWK2//FktVXz05j1y86n3GCNmFTu79pr3/luUtrQWb3hYgPolj3C+4207BP?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ev1b4HtbsMZ8skan4ZWk36Nx+XKuHbSsqDbxT9SiO5Z36zasaJBUfRevxbz5eJvl89/UlR7dnJcDKPwk1Oqw+0WO8MOM3PsU7lgcIvOKdIC4fVz0jhqkiHRglWAJYWZUzU3t966US1FlFT7rQYL/MT6/sqcQWdpyAuS4VzSTDxs4x/WqpJk5TNvf30BSUqfRxAO+iTimIiKSeSep2C2uLBmXPk4E2Mf2LJweILXz7L+hJ2Q/ayp5pgvU13mJU2vUQNp1K5JY/IjbF0pAXL0G90jyTx0CFrGfCurVZUwvW+euHXb4IKby1bP5+SnUTQ5n8Yr72Crpq6QIhrL0vGvypLzNJkD1bPDw22KtRDFJ+Lk2Ni/kho2iIXNt+P4eiZ5IXPoEUhpffkfyaxzaY2mPFrgQJbVe0i5zB4If3yY/A3KG+SGh2wsbCz+1aF7jsNObHgomcF2+oxI0CTRN7P8poiyqnvrh7scOX28LdarDj4UBPSc2Pc8xqtp9FLbHhPWyNI3qf0ZXBspPAvKDyYVfvAEL0WVgHtwB69c2QkdvhIwlynckgfEN4c7vFz5edR03Be4vRqKFHNXg9v73KrTjMMVTIhGfMJlCnz3d5hj4esY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eef48d-0914-4577-9ddc-08dd5a4b2dc9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:01:49.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lElW9regFXU+ETIP4cUpJVgEKGbtKZFjCEO3CDyZkZ2F/oKjd9L8Nd3r5uAMfjGv0KI1bWMd2f4GRpLLGNuYCbFCPMlB5EbX70QDyNg2gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030092
X-Proofpoint-GUID: MPLowhmIJ4Gk5GbyaQod_YBql9WunY9l
X-Proofpoint-ORIG-GUID: MPLowhmIJ4Gk5GbyaQod_YBql9WunY9l
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6glL31mnzG2pk
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716314.21445@KhnFCaoqF+R1ZO2LUL0uEQ
X-ITU-MailScanner-SpamCheck: not spam

I tried b4 shazam'ing this and there's a problem applying the patch, seems
maybe a conflict?

Not sure if Andrew can resolve or if something needs to be done here?

Seems to be commit d77a800944d8 ("mm: make DEBUG_@WX dependent on
GENERIC_PTDUMP")?

Should be a trivial resolve though.

On Mon, Mar 03, 2025 at 05:09:17AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> covering the vdso, vvar, vvar_vclock.
>
> Production release testing passes on Android and Chrome OS.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  arch/x86/Kconfig          | 1 +
>  arch/x86/entry/vdso/vma.c | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index be2c311f5118..c6f9ebcbe009 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -26,6 +26,7 @@ config X86_64
>  	depends on 64BIT
>  	# Options that are inherently 64-bit kernel only:
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 39e6efc1a9ca..a4f312495de1 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -268,7 +268,8 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  				       text_start,
>  				       image->size,
>  				       VM_READ|VM_EXEC|
> -				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
> +				       VM_SEALED_SYSMAP,
>  				       &vdso_mapping);
>
>  	if (IS_ERR(vma)) {
> @@ -280,7 +281,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  				       addr,
>  				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
>  				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       VM_PFNMAP|VM_SEALED_SYSMAP,
>  				       &vvar_mapping);
>
>  	if (IS_ERR(vma)) {
> @@ -293,7 +294,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
>  				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
>  				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       VM_PFNMAP|VM_SEALED_SYSMAP,
>  				       &vvar_vclock_mapping);
>
>  	if (IS_ERR(vma)) {
> --
> 2.48.1.711.g2feabab25a-goog
>


