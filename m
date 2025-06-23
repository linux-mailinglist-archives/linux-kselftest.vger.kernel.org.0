Return-Path: <linux-kselftest+bounces-35622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C1BAE45E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 16:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB46E3B9E34
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8B25393C;
	Mon, 23 Jun 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eIy/GvE3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wp0qXIOK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F723AE7C;
	Mon, 23 Jun 2025 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687038; cv=fail; b=pibJPWTlXM8uYVKNal8OiKi4sC7fO62sCc5rMIP/tKYJxNRLNJ2MopQxio7Pt+LU3cYovn1OA7Am33wJqG2nlByhWqfbGvP7tXkZnfznMHAxMMtRrevz/o7Oc86q1IjqQElRnlOp3hlYWZVJRLO/JLaDd5lx0iCqEaLEnbO5SQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687038; c=relaxed/simple;
	bh=8ScAXTdQes3qFKlEMV/elS+3IzepjRQUchw2D5iUBYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pIRL67WPPihkOCc2y0/GUKl0FbXdtPigkmuCpA9OJTPxUsmTYLlSZJMk5uZ5Np9gDE7/tVCJLEu7KFfGkz1KThpSLyXtDGKgQ/UdmDS2OfihMqBiZgtYqxPBgGkE1vyRbemMRoQOz8b03r/VCjfbZpZUEdVOr7nvH5MhztxZRnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eIy/GvE3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wp0qXIOK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCifHV015754;
	Mon, 23 Jun 2025 13:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zq7D8vvDgl7tJ/fKyD
	S6iKu+pXIopNqHnbATLqm7Uws=; b=eIy/GvE3KUMMJ7yRPTLble1nXo/cjvMZVJ
	SwQzT4j64U+V6JG//9Bi6KKvpyHk6H1GEs0OwJF4tdzqH40UdQbL0ODEhUtX9Yl/
	rYGCavP6rPiONl34ZWDWdQc4eJPj5hT1kEvrjLAygFaUFm0SbRIAhw+FenRZsP7g
	Kl00VuZv0BtdC3ZTj9pxiK1ydWPKdxRChE4VX/ga2Cr3vQd4jr8VH7b35OCqkZqv
	/YKVFlVLrcxCkqAwM36m2gwDr4XhkkV0THZfJd/aSlcyynoLkVhPc649ZJodTnIS
	1VsFrT34a7q1hpvn34jz9SNSqjmOQXMr2n7KtDl25plZT5c2hmOQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8y2s25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 13:56:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDfQtp028193;
	Mon, 23 Jun 2025 13:56:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvuv6e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 13:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/E+WFpqTk2/I7wCKLLKheWYHdGKSvbP0B7xWVAECAQIFEbpKz4lpDVqEXTA6Y3DrfXkDVBhNRDTCFAcT6x3e0WGLoHXGXuWUTW2caEVLAIcz29Duw4Fhlw6catHXxYNqe19Srye+9tdofBSlGB7pYsGKTIm3+tT9Y7u7S+fNnQPRKpQermNh0P9J5HG9fERHDewl4P+hGr3U7mU54+nfZvNw8iGzaWj8UynBBWYz69FJ/GgkPeSMEYscm96X0JoX+qmGFgQcMSbqqH3ykWKAzvi5QKGWcORUAOzYDgJrM+9kydZqQPR7Y3Se7CUOzTy5TDzHeEgYI24C0wKEVeiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq7D8vvDgl7tJ/fKyDS6iKu+pXIopNqHnbATLqm7Uws=;
 b=ryN769z1dP1tcaCMjevMYa8o1WbL5VQY0fybSyxGr86X7tQc3kBFTK2K9492a3z058pid0fdNV8H5Ba/YewG4IPUg4pIS+UPdWjpEJVwwtUYhOY8CQv1PO/GkvC+GMEMoN4/7Ly0xB2x9+0Re6EfINkSTDyYmEXzpvCJiGp0K0sHYzulPahwXfWu5ZjTqpGFjOitIU/PF7QB4M5RLsJsCyM4ulyrGbTfS8j3Rd5bcOMtdAV3okACxouBJCJTIqcewO+D9MWc0GzZA5+4VaCS5qubq37HM4FnnOxyzR/Z3GG7vrld0C92ckMhRfaj70mABPee0zfEMfB3b+JRtiviWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq7D8vvDgl7tJ/fKyDS6iKu+pXIopNqHnbATLqm7Uws=;
 b=wp0qXIOKJGf8G+EnwOlAHq5z49Yh2SICkbeSzcybiSxao1N98YilcXE8SEQHjgMwrtjMLN+XCazqlL9nBAuBanWtxSvZsL9UKFWbpgMXp82PApJ7BcD3EVuIUQ0rnFJa1SazSobTiCfI5Dq7aIW1YFafk4OgssfxHb0preeodes=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4449.namprd10.prod.outlook.com (2603:10b6:303:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 23 Jun
 2025 13:56:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 13:56:25 +0000
Date: Mon, 23 Jun 2025 14:56:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: wang lian <lianux.mm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        zijing.zhang@proton.me, ryncsn@gmail.com, p1ucky0923@gmail.com,
        gkwang@linx-info.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] selftests/mm: add test for (BATCH_PROCESS)MADV_DONTNEED
Message-ID: <20b9d059-6d10-43b8-90c8-cd46330c2326@lucifer.local>
References: <20250621133003.4733-1-lianux.mm@gmail.com>
 <8fb737cc-ba83-4949-b4fb-2a2e1af0967a@lucifer.local>
 <e80fa23e-f659-4eef-89ba-8c9f5578b78e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80fa23e-f659-4eef-89ba-8c9f5578b78e@redhat.com>
X-ClientProxiedBy: LO4P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 86811ec9-77da-4497-d40d-08ddb25dbe61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2lsRwoPe3EmzyHMgMF8GykQ+hPLjOOlQJzgYv+kKXfBigtNFEpw7F9fePGnf?=
 =?us-ascii?Q?02LFjeldF2AAwwXNl8Y9d6/SHGOh3UC1LKtXGkkZv7xkJ9cEkhuWd+hn0Of0?=
 =?us-ascii?Q?X+JyqPXu8dXW8la6dx3rs0tT9RiLVVDP0a7acN6RNusUhNuVW6xd8D8D2wTF?=
 =?us-ascii?Q?WJmuoGt9sUmJYz43af7IbIj2o2yfnkcIXHif50ZthrBeD7tKQWeHyFMiDGir?=
 =?us-ascii?Q?46zAovZwYL95riGQ+8gvt9oZ714fJOEuEJnY/z+oowNIAPKkWWrCp2Mx1HjE?=
 =?us-ascii?Q?ztYLXz2aOxVH6TsI9D+MyD8kxZMgvHtAZZzbCZjUEpYpCFCs6+ALozCTszST?=
 =?us-ascii?Q?nRVlxntearzWMogp8YER4Fsc5xUsvFHubbRRSLAFGgPbFl+o+pkqAWlxoKOb?=
 =?us-ascii?Q?oIYxLUTymyHzzkDBXknrgvq0kSx/B7VRJlyRRCjD3+0B9hE6yaKng8g7ZO1m?=
 =?us-ascii?Q?w8IeHVWqKwzz8CKj+3+kVVW0r7kvPSdTp+ogz0vUxiDNcckBbC1viQ4TmMNB?=
 =?us-ascii?Q?eU2m2v8YzRfzgscgruJ57TGtPkQapP12H0ikR4CN2R5JPxqy28da14x/pU3m?=
 =?us-ascii?Q?FaZ57qZ+1q4OxxxARw/xxpPefmA/TUkXa1k9wndGFSpur9NY8299TiqIA3R1?=
 =?us-ascii?Q?gLulufEYsqAg73lUN2J59XGvPvQfY1E2RXhGMy4C7Fsej5Bc40MJC4RJiiqy?=
 =?us-ascii?Q?DfapdilOggCXEAds/u+5D8J5AGYSxM9+ipspXFvtzbyB8vibLltdVY716xTN?=
 =?us-ascii?Q?uBed7W7i53X8h1hhDJAi53tBEezYD9fBnN3pXHVI8cF5Xh7kIKH+LorQWP0D?=
 =?us-ascii?Q?CwG4R6qsUI7Fe4V2ms2HJbxhDN5R/qctprUb77mwIHpzvlaf3YRHi/ATy43V?=
 =?us-ascii?Q?DfVSV+GHY8UITxFGMWlg2DDPsX1JZthzYlELrvzUEBOLzZpy7i2beFc13F/o?=
 =?us-ascii?Q?wu1LuZ/k0/ESxCTEygH5Hp5XTKDh77veRsqYGo4bIuUYKRqQPxQ6r8fMjSEH?=
 =?us-ascii?Q?9dJlMapNdMM4WZeVCHI2fTDR6BzFYPsXizlyVe2xKomIZV+Z7JKTPCSq5cNk?=
 =?us-ascii?Q?oHOhzxdcJrPvtxiG9olg3/lpG1XsQ8WmCzwPxz4LGok90DSDz/d3FEX4u467?=
 =?us-ascii?Q?R6ydoibozsBZufDQFGOeiKCSNK6lpEO5QrTm0JJtspzsJWRbl+a5ws1hD0Tm?=
 =?us-ascii?Q?OX0BrLwO5zCt5WzNbBQiQKlNDGqd19QRxn0PQsaoJDgq3EJOswHzyki8XW20?=
 =?us-ascii?Q?5F/VWPAwrKSzT+Pip5KQU8jDnlIJ4aTKA1PL9d0fAROaQpqZXrYc5PGAQL7T?=
 =?us-ascii?Q?MjeLWnxK01XHeFbTKMrFoOAWFSW8z3oqBciUfB5TaICFjmPNfOEbSDLkaSWM?=
 =?us-ascii?Q?RLnwJnDQXjwnekEI3etXD9qzGVxngfm5tS7Ft2NVHLeTN6HFV1TDmBGLo8cs?=
 =?us-ascii?Q?aD/P7P+SSSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m7p+MbliKsonGdNmrE1V6qhlW7q+MnBCFpGfOo7zKJVKUUgZcQFvKnad74+Y?=
 =?us-ascii?Q?7CJ7ZyEjW5zamgCJE1OMpa2cKHPaF9jur60kVz4LuMIoMy9KUsQlVIfdz8As?=
 =?us-ascii?Q?cu9SS14vYR5IfYmZhzVbfJA4W1m8Yin+ki1u2DViIc2pscrvZ0T/m8YI43TT?=
 =?us-ascii?Q?y1aP6P5PuY5mQZPmhQ9zY5mJmuI4GLii8lOuR2GPsj/Flv5rUGXAwwIVeGN9?=
 =?us-ascii?Q?68PJYsCnwNEelZiac7by8nn8Sbf159J9V1MpgWn3z5LQWk55BK8HV9AT6HWo?=
 =?us-ascii?Q?3lXfTMhcc0zhBPk+vr6/3h6hNKhSnRM72HGQjPEglnftnJrc5wea9wUSlaAR?=
 =?us-ascii?Q?Tr/Vf/Suy3MmmD+k2iMgfe4iHAV4XAqHXBSZF8QJKkLdOYRuS7srF8KwkUDM?=
 =?us-ascii?Q?/D1aD8sbrxZFHYFFDBTjF/y+RaleTfxAnWb59yswafe+169kVLXBOZsI9vvg?=
 =?us-ascii?Q?3VcNLrNPZ9FhZOvhLYj3cbTimGABqXNJABOSP99KB6IunsAnx4vXpd4uNPR2?=
 =?us-ascii?Q?05Dc4g/ScAidKAauvQdPRQ5MEJrsG9ilYM3wRfKLNd7aVazUja4vp8hlCuTs?=
 =?us-ascii?Q?iKudgrNqd+ikLOvXO1rNOMv/ou4ml27uYYEQjUljFQpV9cFd0FGwF1qQrNC+?=
 =?us-ascii?Q?nVPP56gw88sbL+BHC/6GEAcUR/DyDPzyKWKw1ipgrKsCq8baF3KvUMHrk6on?=
 =?us-ascii?Q?IG04seCJZgEGEBHv1TJEhFAa4IitykDRPVjsOjit0wRdr6ubECT+wdR46scY?=
 =?us-ascii?Q?XY4eMNZ8Yjd3UbgXfkCUdoYK4ouUWb4meC85rdu+TtKLS1qRshdKyKSve/QJ?=
 =?us-ascii?Q?fDjJg2cWw5jCISm+7VHw6SLGM+2bAtBNT28JLOCnGqrlpKJ3VvQKUeb2++Ix?=
 =?us-ascii?Q?Yeswzle8FJsVDeyLCk6HNgTygaQ45GQ5o/5hctIdiG0GqEsIBa6lwtsSIg2G?=
 =?us-ascii?Q?a216qP16acpoN58GtYs91GQzigVkAka4s9Fs89FM6F+913bzLnj4iICjBbd+?=
 =?us-ascii?Q?IjPvwV8Q/v0LwxgGnEmg4OhXJWTmjsRNTeKtIoWiYVjQnt0XrU4S+iMAqoK4?=
 =?us-ascii?Q?6fyPHYVg21xXk/FBkKZqJ+09X3HLiv8s071zBTM3sBFmvUI+xCgY9kf03tLw?=
 =?us-ascii?Q?ZfrrnP/eDYwvJaciSsYNrRaW0/JHTDQp9oD6biGBeG6Ht05liqOknGmQ7swH?=
 =?us-ascii?Q?xRe20MiaXRJi3gn1qubRH1uNsAONGyS5V4dCszgj1erTIjCJMC2kGA8/+WEi?=
 =?us-ascii?Q?jeNndeAP7xinJBUJEzvk9OT4nytOo/vHrvXnOAIapIlOyo9js6D3y8gwkiO5?=
 =?us-ascii?Q?dVxH/FWzOwXkZ07VrHKisabcjWc00aO39QfNtkcIBfj8VSgraL5+w2p6+Ln2?=
 =?us-ascii?Q?KJSWGos9n+tnVxhcEHlDz/yiT7OXiMK8goAkUvn+9DCtV4JJE2BPo9LNOkkK?=
 =?us-ascii?Q?aMOAK+d14d1DtFL/K4T5foaFeN8t/HVYywuRb+mwoe+mlHviqP2hf9IMApYC?=
 =?us-ascii?Q?Cppbx0FIzLlhlEGVcITfPZvqzIDDytQpFIQpj3Jp+l9IbqrvoLRAoS4zBKZE?=
 =?us-ascii?Q?LBw/4gkYJjrLfXanIGJns6mdgpUSbHDIFiqbaicKnWJ/Yc9kCJeLnPNBy9QZ?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vYZ9wLQ1iLTFCa8G4CpFj9fpWnk6uKwz+wy+gS4IxBSW8pa4nKBHIyOpSETixQZ+WsQMOGXGkisQJvGD4yFkzhv9TCDtVTLGyasLiYy5SGRFDuWG3EOVi2zgu8jCKFWMcMmggeL2/AHwEFZyM53MeB+VV23dBUtp2urM3ArkBW/YQD3BgOQ9gFLEVLp/cogzmkGeTqZtDDmQuWiKXH9K2NW2b5zDFyyuY08CwrNXHBh9dcwHaY2m1NibHAIVKAyuXXzRYt9WaeZRLL9rEeSzwxb7c4cuvMu7cYcxbiRDSco5wuNw9gyTiQEQez2vTOx76p7DyD/b2Y4ipwI3AqXxiWu+mBsAY9sV9tmaD4uw8FEHesY7fvM4YY8kqrfadNWBSML1VmgjySgvEHX0KcBQAdav2e7cIlo9Iz8lp2yMwr5NSArN0o+6rGJb3eVnAUYumPVhsOBANBDHiX4L3YOSsPWuj8ehtoSppyFJvE7J4FfdQXUjGqE9BNTqPYxgM7ZHNnAvDiAl1t6hkOHb/rbt5k26ycVhi0xLgQS1ths2I4shH2juYorCerMJpLi+N1+odFsP2Qwbl29GjGdB80tP5cL9WjXLprPaVOshl1U0z8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86811ec9-77da-4497-d40d-08ddb25dbe61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 13:56:25.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWSHPQFOkwYCQBHi1f80cQBZmfsS0Rva3+f/fkQK4jbeIp8dgQE6PKmj/V+5pEm19tUEGK4pT4FZAsOMVdp2stlD+k08kkeZRsX7Rz2LuUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230083
X-Proofpoint-ORIG-GUID: oB9l7J9UrhSEks39snEP2CtMIUsq0A3K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MyBTYWx0ZWRfX4/pN+3pOU+Jb KMpswsbmdBk5yhcCH+ox+yvjxRYwU+YNmJGOItJeHOUZDqeMJ8G8jIE8C4hlAmlsjsxJJYfsKxE jcaC6wrkryvEKNuvIdQYT092pljVipjgBTkMdl+KSipX5xvwsOLwKgeHjbVyLuebtLe4RDuXjte
 vazOe6wxJm9v3fh0oZruqJTfmbgJwDFOAc5fYr6Xl+VWlZ10CctA/BBWHdunBzgxVOwfKIVsNmx MI8vLxy+waMeCJCnXCLetCJON7ceYEcbPjiv5jGLPYaPNHbn0bASVExM836qHnk134/4Ixqy5Nz VFkNASHk7wYb+7onWUljSshNFtSs6R/8dHQY7v1CkQ+Kf38N5Xh0sCwhF4luOlUhay2VKBO6VpV
 eENZWv5rUUMkJzFkwvxeoukC6m8iIW4QHHLJsb7kMCq3Wh8SUKZ2mDqunPmKOa9iIvM8Wnvk
X-Proofpoint-GUID: oB9l7J9UrhSEks39snEP2CtMIUsq0A3K
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=68595d1a b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=I8ox7aNbTNgtd5LfjFEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714

On Mon, Jun 23, 2025 at 03:49:05PM +0200, David Hildenbrand wrote:
> On 23.06.25 14:35, Lorenzo Stoakes wrote:
> > +cc Liam, David, Vlastimil, Jann
> >
> > (it might not be obvious from get_maintainers.pl but please cc
> > maintainers/reviewers of the thing you are adding a test for, thanks!)
> >
> > Overall I'm not in favour of us taking this patch.
> >
> > There are a number of issues with it (explained inline below), but those aside,
> > it seems to be:
> >
> > - Checking whether a simple anon buffer of arbitrary size is zapped by
> >    MADV_DONTNEED.
> >
> > - Printing out a dubious microbenchmark that seems to be mostly asserting that
> >    fewer sycalls are faster when using process_madvise() locally.
> >
> > And I'm struggling to see the value of that.
>
> We have other tests that should already severely break if MADV_DONTNEED
> doesn't work ... but sure, we could think about more elaborate functional
> tests when they provide a clear benefit. (zapping all kinds of memory types,
> anon/ksm/huge zeropage/pagecache/hugetlb/ ... and using /proc/self/pagemap
> to see if the page table mappings are already gone)

Yes right, exactly.

>
> I don't think we have a lot of process_madvise selftests, right?

No and that's an issue. It'd be good to have some of those, but not as a
benchmark.

I think the only stuff we have right now is in the guard-region tests which I
added to assert it worked with MADV_GUARD_INSTALL/REMOVE.

It'd be good to have stuff that tested remote process stuff (tricky to set up,
maybe test has to fork itself etc.) as well as the stuff I added allowing
self-madvise().

But again we'd probably really want to find a way to exercise this stuff
properly.

>
> hugtlb handling that was added recently is already tested to some degree in
> hugetlb-madvise.c.
>
> In general, I'm not a fan of selftests that measure syscall performance ...

:)

>
>
> --
> Cheers,
>
> David / dhildenb
>

