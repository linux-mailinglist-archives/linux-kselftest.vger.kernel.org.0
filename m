Return-Path: <linux-kselftest+bounces-15723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8B09575BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 22:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9402B1C2202A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A0715853C;
	Mon, 19 Aug 2024 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D+sxeH22";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i/BVk+uS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1D158216;
	Mon, 19 Aug 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099666; cv=fail; b=B3xLnV7/ElZxVRv20G6PYz+CKILw2LTUKTbnycZpNc1oR4cbNnhRoXxQnlvoD5AMsxY3h4bSCpzgqwDMwYBs0yb+KOgYJaaIcecoU3KP3DxdUXXbxfP/Hh6ahff+l6bvvaQGjYUq1pM3f2Yc5CjpbaEIfINTFImS89sk9Q6s3Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099666; c=relaxed/simple;
	bh=xF8azsfpOfQnzjWRaNSUhQoJLoqQzgOK/gQmI8pjswI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tjqHP9IZyNwDN0C/DVrOEIYb+9E9wOupIkZzupaXdmvR20s7N2tuWS98MHe+HgNj7jTVC+qoy9IeIRY+RhOaM1iEVzzHs0+0zk4c4FdoK3pmEHrRZa4mYRnpfDlk7NYFmP/hqiOcXvABI9m/YcjBWg1qVvQNyz8wimZzxkONtRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D+sxeH22; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i/BVk+uS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JKBVEu006809;
	Mon, 19 Aug 2024 20:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=zFRO9orJ2ZMxO2G
	4d+Cb3aUHUb5dqPtEaL/OyWfSR4s=; b=D+sxeH22Q5vmpIIuKUsDaMRZec9/XFT
	P7kY6oqbkYC/KoqhKEyzMbgO5Er5/So7w/jT3igUVxb1a7AgMSYCrxZUZcdZaFl6
	pnhz5oiPU9HATpCXad+hdCSJRb48G6KMdIsnIEA0McPSIu7cVF3qmwCr7i1Zn+4J
	OTA0ZYZeGhNlAlq9zhk4idgeW/CDCrSx7qo3HO+pAbe8XspCUNcbFXHnZ8Fd3zHB
	iecK/wGmkW6hLuMdiLyH35/MsM3fuDuMtXU2Dnac30V8qis2p4lVng+0Mrm7IAW8
	jtsyKQhmzzVAwOfjxX63urzoDdEb+EiWmc7VGxC5X9fXnPOijv5ECvA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdsujkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:34:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JKHIig005537;
	Mon, 19 Aug 2024 20:34:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 414cy0rmub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 20:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq46DXvlH7IWouJEtDFjDB4vNu1vKlyFu8alfcjvPqMpNk64bD9rNsxQPUNgwWYz/NJRx6Su0nYm1JBsKg6snN5tqIAsmQFq9jg9NhOrukTstJToLZHuEQkdCnlJUFVW8dYMyefYKHJsHzJpNqOoENBfbpdG+KMMLZRGqaGnDlTsb9E/iwel1uc0yzUe98LlPr81Vpymc8TeaCsH8L7Gjk2I2OcTDsubsML5Wr2gONjoyfDlbVmIhlsXtItLOdZ5kuaSzflHtuPO6ic0eLqkhkI1J2GUvBN0UuHrqDYGbXLfZbJYKdpkM6JywGNgrzerFJ7wJF5jJBhyVroNruVfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFRO9orJ2ZMxO2G4d+Cb3aUHUb5dqPtEaL/OyWfSR4s=;
 b=nT6v2lh+t1TMZceXRg9oqbPjowmzIAR1jOc1JUhqZU63AlgH4D4e9gADBZJmCAH8RCyaQsSz0mT/BcPDCnv3PwBJwYKKSK/9Gppi09WAh1fXGcs+cM21NT/1AhAJLVihL/TrqL5JBiju7V0D1QVWP206fqw4yjT2M79wXYAxReXd15AGsKOHKGMAR28RE+C1aYxQ25gnyDg8UCtNVr3t83MQctq2WQ8WHBzifzDG3GIa2HQDQ7kZwnQZFcRgs/gNLS2AbqRe/8q2W3j/jHgaYJCcyiImQpLK92cEwuBrH81ayFIBcRYRiQ5H1lbeu542k2xLpl24sj/KotoG4aQ3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFRO9orJ2ZMxO2G4d+Cb3aUHUb5dqPtEaL/OyWfSR4s=;
 b=i/BVk+uSmBaj50oiGFAAjsOkWMigbp7KazAmV52IRxJqeBOVfHpKIQa1nJ1uUI1ctP3rAJYySDZYDu0oqjPZKS2Em7JPfXLgI8/XJXlJAz0/hblbEPED+BC3nugRm4UzD1xph6yAYqbL/AdJpBCeP84kEYpdJ0AzNTHmen5QmFQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 20:34:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 20:34:05 +0000
Date: Mon, 19 Aug 2024 16:34:03 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        jeffxu@chromium.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 4/7] mm/mremap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <wjwf7eiu3kcd76tr3riddcusybbg65obpoo3of6xb5gswrjioc@r33dbsgu3zvk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-4-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-4-d8d2e037df30@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: fa486f7f-a749-40ff-dd9f-08dcc08e4520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhzqqY6u9boVAMc50AvU5dnbmjVEGeVUwkbl2JY8E6f6nvyiHeq0isU+RfbO?=
 =?us-ascii?Q?vdNbLzH7DLxaz+SaKZZHT6ySkESNk6ZRYR1jTH1mrngBUJDuQWAIF2Slv1BQ?=
 =?us-ascii?Q?YrUd866vcPAC3NqHtaWnHPuMeodKN8ziKi0IxnzvDy+RBWjoNwouQgsQZyvK?=
 =?us-ascii?Q?hmPtDXmavV/QhyT2/p3IQZFeDC9kF3baOvHVOzyLzeX7ZZ+uA/g6Dwgzuoqx?=
 =?us-ascii?Q?vMl78/gFYeSErzmCc8ML8auNGUgrdHMN1v6JkNEf8srKrLTvKqCxPl2yDCHV?=
 =?us-ascii?Q?C8gFMhPtrz4+B+Exvs50U9hUYzlzh6DUt+RaP4Ci3c1lgPnv85elojiYc0Xt?=
 =?us-ascii?Q?p86e/4sZvdHi96FD4IPxbXfi0q9pBn1bRIpmDQhCTsrcAIoOITEyHCz30tnV?=
 =?us-ascii?Q?mRQq41JkTyOnyTXqrJcn/KdaTSnaIfVXidTKk/Mh0FjBxw/A494zMNquxLhr?=
 =?us-ascii?Q?14I74p9CWUN1BRK6kL+SyJP8jwpWOnJ9LEP0cdAcYDd1EIWNmAZYxGrAk/b/?=
 =?us-ascii?Q?dh01J6adusrlKgXyl2WS3EFJqaWd8hD1ZvDel9caPfNzn340MvEwWn/jouPj?=
 =?us-ascii?Q?mE2PkPt84BKNx3pVidRCj2Yl2fwDjt3T2i+FypSQ2QjKTTIyVyDVf0P187el?=
 =?us-ascii?Q?TSiYcQ9DavPChz+H1pXHMSxL+7UNeYIv6kcSxME+y0ZbHjVSJhqgEgKhVGEK?=
 =?us-ascii?Q?5+hwuSdrhpeKb0xUJVrLG21zmhraO6zIFlWVbTJqUK7I1tJe6FYH5KCIzRiM?=
 =?us-ascii?Q?a1L1aouZBbCoBrv/XeWaLtPtw57XNVaQYTBPRUtj66JF60WLYbvU6g89cLha?=
 =?us-ascii?Q?+HImNKguD0zkcTa73rcadz20Mjt1IbrxW7JTdjLVSN7YTQarq0WiryRmgsjg?=
 =?us-ascii?Q?SMFGtdEnnVv9kgA6wdMxUufGlbhHcSG0+cjNajHhUFTzXp/l/x3lxrMg/cdD?=
 =?us-ascii?Q?nVbfHuxkNjmYkXh+lxGf3cP1TqERV040zxUR6v88yQ9sUEYWXAnb9pDA+iT/?=
 =?us-ascii?Q?8NJu1AIhxWPsa9dPtnGLjBy2jO7c9FVssn+ys0Cj708M/O+W06oBvtlx+vMC?=
 =?us-ascii?Q?zGE4qPeGFhfvqpSeBZIsiWM4H/lUHs38nANA1Vvmp5yi5xPsrzaxefzve+me?=
 =?us-ascii?Q?o4EtoO7SKLIhIaVTcOde5F3kr2O3wJdg1gQwP3Lw7IPiS3zR+3rPkEVGqCQr?=
 =?us-ascii?Q?6iuBybWiAxUF83u0bZE++yi9QTbaQWXxi7R81z82yFkTo4D9LMM7G5QTry3D?=
 =?us-ascii?Q?Nxc9qQmexAVk1XgMunpHXKkrwKusrZK0zdF3iO5wWtHuEs83Jjcqc6h0jGXh?=
 =?us-ascii?Q?TWKOb3pSPHi4ucnWv8+EuAqVgyoxYRAqO8hIbXDw48h0KQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9H0t992SrLtRNaIvNC0oj4KcXrX+XwrAcaO8LbWP3IyKL3b8IMO5qEO41CO3?=
 =?us-ascii?Q?fpQ3VqnnuyOX5BRdqZAlIVYEncIXl+yM+PC72K1sIPy9Wni7E3QPbnzgWtQ7?=
 =?us-ascii?Q?RXtdBjXFvfQIs7+OrUE/9ADymZvKXS7PcvHjEajey5CCQmiqA6kSgr+e60Xr?=
 =?us-ascii?Q?Mz2QMyHp+7XrsywkgxjsHa8RCnA+FTAtijG7hFM/D3PA+ijhs6wsx/2JgnGc?=
 =?us-ascii?Q?8VdEbfBSTEHGgmqmJriDAPlcaQSF0jwtB21VWP/NIHFuUjRht1QAdUKAXIId?=
 =?us-ascii?Q?kz5BsLyLpjyAgm5DREn7eRKIYTuYjmwGfLgPiKSdY/JdxS3uuy+L5Z211keQ?=
 =?us-ascii?Q?vpf23fvoNc1FwNa/RupBuK7ZlaRxsdB2v3EEDQbyYWi66QoNdAHeRd/htonT?=
 =?us-ascii?Q?eCZqXhYw40O1P4xLWDU4vuTlzjW1pTvEmRGvPmCKivrpv5ynL2fbVi8a66Ds?=
 =?us-ascii?Q?t2/b/oU5DPqM0wXZoCIzj38FrWpbpPp8DR8ISeSf4CjVW5jZcY6AY878cn6A?=
 =?us-ascii?Q?vhRza7fxEkXOqRBnEzwMB7bk76UtCDeCNOrArkCLTjM1YN3vRi8hMsVL5JIx?=
 =?us-ascii?Q?1CMbGLyIaGUNDppcMeuP9Gr24I+lDAGqorlsVvawjX3L7RtnAf4ukBzO3lnf?=
 =?us-ascii?Q?Q/Acg0mDwP+qlfrOgPTsithlne0f55pT2lmddERi5ivrinRZVjV/y/NoZ2hO?=
 =?us-ascii?Q?zJwxuMwUGtTDAKUS6SWPfhpP/PqVytmF6qoNMdhKz72b2e7131Btka/RbOU6?=
 =?us-ascii?Q?DomgXzuTbMZKMAsTU/WVFOYEObE3abkAIfTYiTrC1V8kxK3Le5UyZnRTbuFK?=
 =?us-ascii?Q?/N+KnBgW4GPWvJBdAIinYFbgVGIC/qmVLPulr2Tx4lcxz2k4D8sAxaqTIdXp?=
 =?us-ascii?Q?OoP7k6Y/sT9/KcWYtqBC1+cyjww15ax6eVXGDVwG7QXHzR03VYWHCVCcgDAP?=
 =?us-ascii?Q?Tc/81dfmwzLMf/S1cf9Hk/4so0zZWE+Va1nVkxkqe+7TA8r+XxxZmpC6rRyj?=
 =?us-ascii?Q?XlI1a7Db8ykRJICwtEZHuobCk5Hlni45lUEWEtqtPplvWY0Tb7QlfEEMQyXQ?=
 =?us-ascii?Q?UOdTJZ343Hb3FKP7DnICUMDQ8n/3fNI+LqeZoYHjCq9JiYpRb1dBfrzWguRt?=
 =?us-ascii?Q?j2ZfJeILoEsCBnp26ElOEWz+6BaHsk0qCI6swsvRsN4D7cIiaEM8IChuQPUg?=
 =?us-ascii?Q?cP4G7PDKdAGK+WBNavBi5ACcpAi8MpsY3pd3UpHbVqhcJlbQQF1hGrPHWFjl?=
 =?us-ascii?Q?Jo7dTYg4tal+7wJQCkPx5NNas0WIDdDloq9+j56gBlyG4ZwPma5qhA+Nf3kP?=
 =?us-ascii?Q?yVl3S4SCoBZeZ7ndqCjsm2fcPoBYnmK3QLGmU8Ih9ZLNIAzSrbJpv/0rDSUK?=
 =?us-ascii?Q?HnObxTm1brh6d5rxS1c0oA1C6oyaWEVIoNnB3f9qy56vzfvpI8e2BojGjtIM?=
 =?us-ascii?Q?7MCyg+gtF+aCYSyTcTbd1oXPbI5jNPjwKnTuuu/wL8sR8QbHfOLEqKifimMs?=
 =?us-ascii?Q?h9Y0QC2YFLBOOiZcy/mzixUGJN0gaUtQeX7tAPIY6vC3966tYQxtEigfQkK9?=
 =?us-ascii?Q?gt8Bwif/KbEB6YwY6csumX6IPmn1k4h14OnTd/Az?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FzqFhvoepmZwfyE2xjwBfSm3RR4P9+cKQlXrx8WNDbLq2ExahNfXEGrIw+SHCngJGW/fYjMqj8QLCMYFK7z3LZN/eDJrLXEMQxVdSX5nXa5KNKHasMswafBuxckFOVZtO7dQLw7pk4GOhwHfRv7t5jhnOfdTiuavMCtxu509aps3ETpFyXpXsgInrOCwu/AyOBrTgB2XvcEF/DgDdH2Zb4bq9n6X30unhn+VGnV/fnjJYMEZh4LqkUvWBsxK255ar3t77BQlBS5qnrMmEuZS2sZsbSK3Ilq04zvsQBFNfgQaGjZP8QPO+RQ83XyV0p1QBd08Di2jkh942ftHu5+tdAgefA1i7BZlC3SzT6QLuT1f83u9k2Z0AojscnQeynLODew390vgOIGhfqB2/x/WVUS5Bq1VKPhgVHL07Th+cvwEBFQGu4/7SPBsELFK//9FlpsnOz54+6FttKXhKVqe1SHXv0grB+HQEHKTxbpJ7WtIa19DGFdgedLKH9HWbWcUUZnt4ooIuuez1O279N1CtzwNnR51xqKvgDFl1LIwa7BU+kGar8UfJ50EFJL7dI3JcIOmjNWkoNoHRzyBUjzMc1/+C+h6oLEHUWjnCgtjwHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa486f7f-a749-40ff-dd9f-08dcc08e4520
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 20:34:05.8876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pykXMtIbszxzbTwZD0DWb7aT+ObMvCaVW39cXmz9i81X/+bqfzw/WtP/PQlMRCz7ocJIfKaHiF3pEh5FzAT8Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408190139
X-Proofpoint-ORIG-GUID: MJU7zh7E0apxWNEKJa5hP_-Jv_fxLcj3
X-Proofpoint-GUID: MJU7zh7E0apxWNEKJa5hP_-Jv_fxLcj3

* Pedro Falcato <pedro.falcato@gmail.com> [240816 20:19]:
> Delegate all can_modify checks to the proper places. Unmap checks are
> done in do_unmap (et al). The source VMA check is done purposefully
> before unmapping, to keep the original mseal semantics.
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  mm/mremap.c | 32 ++++++--------------------------
>  1 file changed, 6 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e7ae140fc640..24712f8dbb6b 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -902,19 +902,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
>  		return -ENOMEM;
>  
> -	/*
> -	 * In mremap_to().
> -	 * Move a VMA to another location, check if src addr is sealed.
> -	 *
> -	 * Place can_modify_mm here because mremap_to()
> -	 * does its own checking for address range, and we only
> -	 * check the sealing after passing those checks.
> -	 *
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, addr, addr + old_len)))
> -		return -EPERM;
> -
>  	if (flags & MREMAP_FIXED) {
>  		/*
>  		 * In mremap_to().
> @@ -1052,6 +1039,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		goto out;
>  	}
>  
> +	/* Don't allow remapping vmas when they have already been sealed */
> +	if (!can_modify_vma(vma)) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
>  	if (is_vm_hugetlb_page(vma)) {
>  		struct hstate *h __maybe_unused = hstate_vma(vma);
>  
> @@ -1079,19 +1072,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		goto out;
>  	}
>  
> -	/*
> -	 * Below is shrink/expand case (not mremap_to())
> -	 * Check if src address is sealed, if so, reject.
> -	 * In other words, prevent shrinking or expanding a sealed VMA.
> -	 *
> -	 * Place can_modify_mm here so we can keep the logic related to
> -	 * shrink/expand together.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, addr, addr + old_len))) {
> -		ret = -EPERM;
> -		goto out;
> -	}
> -
>  	/*
>  	 * Always allow a shrinking remap: that just unmaps
>  	 * the unnecessary pages..
> 
> -- 
> 2.46.0
> 
> 

