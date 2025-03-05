Return-Path: <linux-kselftest+bounces-28287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B31BA4F6B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 06:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5E5188BF54
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 05:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B01C84D2;
	Wed,  5 Mar 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+TJtqFu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bDEGuBp7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2943AB7;
	Wed,  5 Mar 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153930; cv=fail; b=LtBRV5f33t42IAv0U1KHK/IzS3oLYlMYPqMk1dIDcM+fEt55/fFErHC/7VmVC0gR4hrvANkGPtmxbPXO7gu5tUP6csKNgkxnUtc4AP4Op/H2CES+B31Z69QFEUyqaa8x+xpZ9ZrG0ywY0usFG91CuuFrhGu6CUI/FuHuscgPnxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153930; c=relaxed/simple;
	bh=KyW5WDQHOL7bU4MvuJOecUX1KKRsy47QZU1MDz2PwbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uW75LfKWypS6LTjpHmXAVk8WfUqUY4pYT5+Hj8Re79hKDfD6QZNPznsOputcYJ50Z1NltxDx2SybQmEkCpJ96J0U3AAJWrJq8spmaCCz13JH21ZHfwVwSCYyTJ9qrLi9o29YK4jereeEFYcbp018Z52KstXkvJxwbpZ9alRTX9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T+TJtqFu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bDEGuBp7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5255MghS004421;
	Wed, 5 Mar 2025 05:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=UoiQw6OYxN9Ghk33OO
	s2INgQzYT2zmeR4InzR/E4Z5M=; b=T+TJtqFuBifTKKIFKxKui9vq7jFQUj6CUQ
	ZG8Pqp4hHBjSNbH6+jP/wbVeA2xj6DBZ/+fMwj0zrudWnr2UDa0TlBtEAtDSUKyd
	N+Zp4UOGicXIoFLdSiyGv1hRdeQm2Q5ndw7LMfuyk7NlyyPr2bM5CZZvwaeZP6/y
	pVzX6dQZXufYRVDv21wiLQL58ns1BAbK9WSwqrqRNQtCwdgz/d0zXRnTXI1P3RGl
	8rWhzNjKMpEaC3NI/svVXMC4vBOZOYSczQ2t5oDEa5x1PIQSnIMmo+y0rgJbxWUl
	0GPXrD8qLL29iiMrz/kRIg2zaZd55mPl/ZOR8M0RBuY5mELvpyHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub76rma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:51:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5255UkZj039739;
	Wed, 5 Mar 2025 05:51:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpamrp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 05:51:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEIY6XeljMz3o3NJVXfVURWK72pH6r0Dx4ZAnxH5yuEFmcmML+KrJcnrfpaHK5TtEqZXT5pjWN0TabHIANBf1RuJTucMVSImdp+lsRcgZhjtZwjSVBoz1/hcKglmzeAgOh4GIyicQDrOI+FxDp4Lmw/r5uZzVFRr3bznk0TbXy/fMnI8ep/G/LNygCc+89EcUKiHDZFU+9c/PYrpQKUWB5lI5aIJjJ5muqMc6yhrQ/LLywp6pZWOHkvS/wj/WCInq9ACsdU8nN9MaQEvAnjUBKkCAxO5TVpGMlWrQfGk5JhyLrV48eT/1ghtSabHHv3Qwr7elTKUyoixs9Z4IsZSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoiQw6OYxN9Ghk33OOs2INgQzYT2zmeR4InzR/E4Z5M=;
 b=bcvm08aJ3zndPkjP7qjokLe1+ixiZAX8eJwGKX94tSpVLqD5EjVqitXHBX/2bWCLpC2DgvFAY4SNsEp8T2YpJAAcKMv61/Lnx7+T2uGfwdrolmqHRzpWDF3XlyD2RMhbAx8CtpjCAEMxcylA3ksSxKouURl6wso1QU25sp/TMPgDNEIkpC9OCGMukWXoqZYs/9RM4RDi7Fvqg2hbMGEoH9Bk3W8sQzyZx62+fsVXDZQ4hkONiQwLkVRlBwhQDk8HaElod/Br1iEYbd/AEtFMkFACjdi3tbfGfCu0mnvyiApCjqJMduxkTUFLDg61UbqIwtncckiDCfirJymOOvANCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoiQw6OYxN9Ghk33OOs2INgQzYT2zmeR4InzR/E4Z5M=;
 b=bDEGuBp73U6Ss+jlh1xpYnF/VCrwAU6P1eYG4wb1YlDZL7PPcCaEqZf6rJrvNnCYC2hMVMhcPaxI1EK6v+WjbjiP7d4MX2ZMmSnVPcPzSf9EeHY78o4i8/KjEKyX8tKtVYipfryHs66GXp1jAau9cPgZ9bEVBzRKyaKiz2S1I+8=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB6073.namprd10.prod.outlook.com (2603:10b6:208:3af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:51:04 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 05:50:58 +0000
Date: Wed, 5 Mar 2025 05:50:54 +0000
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
Subject: Re: [PATCH v9 0/7] mseal system mappings
Message-ID: <dfc9d260-ad0d-404d-8b90-fbcc5ce212df@lucifer.local>
References: <20250305021711.3867874-1-jeffxu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::12) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: f5487fa7-405e-4efb-b2cb-08dd5ba9b3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PxDIIcGCtJ/ZB3pp61qpdvKBD/+X4QHbcZgEqI4AepjBEovSKpEiB3IuOYzr?=
 =?us-ascii?Q?uanNVGGERrVcGJ/Z53xZ9pjtLV3qjDA/e966lSdmsykWGoA6WLGtQ/TDpzw/?=
 =?us-ascii?Q?MQEJb69x7/c5EOobhAl3zzrTFHM0VpdL8b00G0HjKUqT0ZsbgvNS8Zw8h+eI?=
 =?us-ascii?Q?ECKepReC4FcaX9XU7xdwWH//g0uMd5wX+sQJhrisTFwHNPVfSv9L8/ekhXlV?=
 =?us-ascii?Q?v/VEectkW7fccNeJEmmReDQyA+q/LOR3PLu1yaGPr9cM9Q0EeUaYYTw/5ZKC?=
 =?us-ascii?Q?Z0WMhp4lGmBCOzLQR4XEh4JW4MFpqPvkx1aOIn7HKuMXsN2xe39nsBK8NfYQ?=
 =?us-ascii?Q?t5ct8xsIHYIZbZcnsSB9RkyCLLiQbrExA6lF/uQWS97n7g1ZoiP6jXF0s760?=
 =?us-ascii?Q?FAZOjiikwvKFpW3wimiQ5J/eteFjfqDZnM2Rzs+GUq6vtnif15C/ES7KZnfL?=
 =?us-ascii?Q?yPMKmEasgqCc5pGmGxh4ApSBHIpngrEbyxPA1hIKMCk+Oi+meVy5iIF+KAvz?=
 =?us-ascii?Q?zP+UGs7b+Kszh81oMvIrA2IDwMoORKZcifN+6FRuS6dw1PmpNte7zgcRdnAO?=
 =?us-ascii?Q?zYpO01FyRhCdXV86NV11eTuhbIIYymQOG8aBYM1aScm3l7J5xd3cZZ9x0tXe?=
 =?us-ascii?Q?NHizM2WBII1ZGzeDj0IpkNke4xtY7AJHcgIFwtmnOqXb6kIkJTeAGnm7yLxd?=
 =?us-ascii?Q?cKS6l6LnmmLXobg7cZcja+CLCTQE2PFpooD+xVCUzmeoODsS/6dOnNGaBodL?=
 =?us-ascii?Q?U+S5ZqsMFH4qVOsVrzOvBDuZApu1KuCdoam0hU4T1OSFadJAUKnRCKeu4IyU?=
 =?us-ascii?Q?id72IgcqDlT6sS/K7z3i7aybUV9grCkLoNLAWS/SHOhlOlY5Q7GK7Q4mllXd?=
 =?us-ascii?Q?auH9deoDAS1IP4LTPV9ZSRMVK8ojd8pXhuRhuBo7SfptequlR/5D7nI8zOPH?=
 =?us-ascii?Q?vl3R13yeSwk+PY0Y4pPqzfl4pSpZz+HKl+29Qkf2Ak6KtJFaG03dc/v8xdld?=
 =?us-ascii?Q?yznEi/sG0X35J5lPMC+/4zNrDHdu0xUlF95HVTh7XKrUIdChqFKgwZ9nyESG?=
 =?us-ascii?Q?ES+q6rxLUfCobvQ0iH0WL1iiRMLLTFQmYc3LT235u3SCdFTiYFzOyJtLs9tE?=
 =?us-ascii?Q?J7jyjn5/3G/nw1E9f8pwAqR/aasQ0bLP5Pu8NHx/+c/pjzHV167fRCyV5U++?=
 =?us-ascii?Q?of9eUEO6YF6F422iBMZ0OH/ABYEpMvGuyrtlDUyybpdnFmlj7/yMvQP9G3WZ?=
 =?us-ascii?Q?1kXLLNri/NnbH7AQZEivUf/hun26JWHoti928kP6v9AcJbldgFMK30inus0/?=
 =?us-ascii?Q?mgWXDRYOwNPcQmkTPFFmtgwnXZ9LCFp1nWZuFodCZBWOkdFRERPE85Qs5g9Y?=
 =?us-ascii?Q?AhnAm9GWI1Foc+tgZU1GdNp4zIPz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OiwQuXE7bFVwJstR01M60aFU/A7xr6z4nUo7aiWE0t6IsCDNhQMVqt3qHTkp?=
 =?us-ascii?Q?4Ypjg80H8qGucCuU0j4aQa/ZWubjQZ2AB6W67bvt9XrP+eEFWv4rSZr6xJDI?=
 =?us-ascii?Q?sUD/tZc8NpodTiHcTcBUWa8RenqjniOQnhQ+79jOaQ22A2jDmiBjHf9mERPn?=
 =?us-ascii?Q?pqm+tGQHk6oF/gTXHyCxupbzwpgGAQXidWkokxdH6WtlFSh9NJOJTYKnrDxd?=
 =?us-ascii?Q?asRsu/EPLszDPC0n601BWO7Xf0IrvGgc+3BYOJuLkF9ALpM4XeWGUbCqIKZp?=
 =?us-ascii?Q?ROg52wpJsL1dXLbVzvILZX8aNzVbG0d7BsCPEhgNB4aQJs/F+XbUe8dyS5sF?=
 =?us-ascii?Q?DAWdbN3rLiZ3jRa2OrmzdnjYaEisosQns4F+wQIrRDjcJIXg9AZkBxrSFxkM?=
 =?us-ascii?Q?CHMJz3m5Q72VlPoejUzUoltCzj0UkQiOgL6VYWJW6bKfGfYcG5nQn/9Rnuil?=
 =?us-ascii?Q?tDFrmoo60Wdl2WEziaeAFIxkifA8D+xzgWiSufHodpZ/GMOWtcQf3O3XvxWC?=
 =?us-ascii?Q?T+qFvQQwC3gOrrNhGXxAqlwoZVwTwQ6zwUdTAF1A3tu8K0LZn0miy8PqDGCZ?=
 =?us-ascii?Q?Bo6imfBtQL/Zy8qDoExpCfCgNF9eQrVVvz1wUd9EfMkYKJkkcARSvSEw5+UN?=
 =?us-ascii?Q?M5s5vJqNKabdu5FkCWpVhsdAEpolGckwPr0PsGrz7puiWttddDmLBRIrKEN4?=
 =?us-ascii?Q?mueMJvAnn/ApLXKBkNb29CWgR5Ac8iEu/Uue9wxKs/RzqH7MUUJPvx4C4uyI?=
 =?us-ascii?Q?v+IlI3nfdYFp13jTiinK5FPePJeS4C4CGTnqEFzObSh5WkaBSyn1CeqL4Vgz?=
 =?us-ascii?Q?BkrOvZAYwYk3TA61SUd8gZwLeqTzdyOVbobGNRTiJM2kKV4SmkdpmfxPO6Iq?=
 =?us-ascii?Q?ffOxg7xhj/+SFk3GUcrOFGtTqtr0EO+8dvl3ExhkO8flcaX+K/o32V1rYA2U?=
 =?us-ascii?Q?KOYx2Y7G9QrcRgPnwxXT3aMridE6d538hBvAgMW3ensUCx86trVhXtqEK3Xg?=
 =?us-ascii?Q?r9oXDayTrI7mfngGeNeqnCB2Pbge6NFLvb/72DDMjnoQNDXrCGcZrTTF7PoY?=
 =?us-ascii?Q?pJTY3j4NZ+jdpNf7E0/6/2eQDAa2Mn/Ci9DWbAn2z14CMBs3hM6Bs3ECooyq?=
 =?us-ascii?Q?eC93Q2ZH17fVdDlO6yZTqe4lPujzZdl8zmQTxlc4xNtlI42dXCuhhrrGSIRV?=
 =?us-ascii?Q?qSsupJtDaR0t2VI62gTGwSQysZP0vWhFMA8+9dgarygjreLCJYbZDFGCGOhD?=
 =?us-ascii?Q?hzT6A/HcdIU2G0qGHEtVc7pcrvNtJSlhehWT50Cgy+moCYVSscylbnQoqTYn?=
 =?us-ascii?Q?LkdHUOc1MZ0TqnJ9/kEROWjhDtQbJXHrvMAE0SsRZ/NEQOx5Pi3C6CSirGoC?=
 =?us-ascii?Q?09Kwrex1jHPuZKMv6JgK/WSFZojqaSwgBbp4rFHO+ZcDqcoQheJtp3EPWk9S?=
 =?us-ascii?Q?MoHHsENo7XRKNByWrFOxcpfBQfl92fNeqsfKWG1cheQO36FAdypGdmK8FCds?=
 =?us-ascii?Q?I4NH/3aINiZd69mC/vrrCicOx92R5XWj4ABh6q7eqJx73kMz9IgjtcjiErfn?=
 =?us-ascii?Q?A2BHltZu72nXpEMew0BQlxcKSomNMzkOkFS+XofumjL5ItwzbT7WCsFXad3o?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qwKeDDOBusCxJim/mhGBXnWLWF4VWkhp2bQJtsKwt/3tShBgoAdtOlcqPlbbsLlXd9tkJ4vdSoT3eMSrUsFeu1Hs0+7WD5pvEPo0cOeg13+5Ryf0MM5Qc9k+olUEv+D6+Mp23jzMUaHlA2SceeY7zIUC3SZ1Lfq3etq0YNXFnHbFcxucaDVqDp0/B1Qlh2nY7zpriR8G8imfBCBf1rTFo0Xau7jNNVsOibfSDii89WlMO5t335OF02fysCJ9MuP8lZOLU08Am+LW4HK+XaF8m6lwqFBDK8GJf/af4HYXMbeXxLjaQ55tdaWml18SPc3qUWZqnp/XHVCZ2sq2oQVDXRDJRoGRWY1fLSBp8v/bd4HTpXb0ghZYFiiu9KyZJP29p/KCYhQh0ZCmT6amh6BQo8Wqf5zdqWKBZM3jfiRnWnnANagBUoHYPCDvCy49Vg9zEq82mY+fHv9M+2UmY7Kct2skMJrLWQ2mEp3F1ZXPgA9PZ7cD1log1yPOPFqehSszkA9jC+jGpNFX3AzcqHJzQNIxNrSVlAsdh61uUb2TSDeratja2BPosnmIZD47bY0xsLsBSp0JjJ6TPIFYO4xgatabdT17kgcp1LVtVQ2PZk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5487fa7-405e-4efb-b2cb-08dd5ba9b3f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:50:58.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sq/kwvy3NMS81UkwVPwI6rdBwvJdRXNh1ps6dXrQcLKWtj9bc5ogBIPVQlLLW6gNseV2jOQ/DI+hrVbPeIrQZIPX2kb9EuUzXx7kyuK6Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050044
X-Proofpoint-GUID: faEiKc1ZvY_Jn06N0fa_0lxfnrWyT1WR
X-Proofpoint-ORIG-GUID: faEiKc1ZvY_Jn06N0fa_0lxfnrWyT1WR

On Wed, Mar 05, 2025 at 02:17:04AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> This is V9 version, addressing comments from V8, without code logic
> change.
>
> -------------------------------------------------------------------
> As discussed during mseal() upstream process [1], mseal() protects
> the VMAs of a given virtual memory range against modifications, such
> as the read/write (RW) and no-execute (NX) bits. For complete
> descriptions of memory sealing, please see mseal.rst [2].
>
> The mseal() is useful to mitigate memory corruption issues where a
> corrupted pointer is passed to a memory management system. For
> example, such an attacker primitive can break control-flow integrity
> guarantees since read-only memory that is supposed to be trusted can
> become writable or .text pages can get remapped.
>
> The system mappings are readonly only, memory sealing can protect
> them from ever changing to writable or unmmap/remapped as different
> attributes.
>
> System mappings such as vdso, vvar, vvar_vclock,
> vectors (arm compat-mode), sigpage (arm compat-mode),
> are created by the kernel during program initialization, and could
> be sealed after creation.
>
> Unlike the aforementioned mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime [3]. It could be sealed from creation.
>
> The vsyscall on x86-64 uses a special address (0xffffffffff600000),
> which is outside the mm managed range. This means mprotect, munmap, and
> mremap won't work on the vsyscall. Since sealing doesn't enhance
> the vsyscall's security, it is skipped in this patch. If we ever seal
> the vsyscall, it is probably only for decorative purpose, i.e. showing
> the 'sl' flag in the /proc/pid/smaps. For this patch, it is ignored.
>
> It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> alter the system mappings during restore operations. UML(User Mode Linux)
> and gVisor, rr are also known to change the vdso/vvar mappings.
> Consequently, this feature cannot be universally enabled across all
> systems. As such, CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.
>
> To support mseal of system mappings, architectures must define
> CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS and update their special
> mappings calls to pass mseal flag. Additionally, architectures must
> confirm they do not unmap/remap system mappings during the process
> lifetime. The existence of this flag for an architecture implies that
> it does not require the remapping of thest system mappings during
> process lifetime, so sealing these mappings is safe from a kernel
> perspective.
>
> This version covers x86-64 and arm64 archiecture as minimum viable feature.
>
> While no specific CPU hardware features are required for enable this
> feature on an archiecture, memory sealing requires a 64-bit kernel. Other
> architectures can choose whether or not to adopt this feature. Currently,
> I'm not aware of any instances in the kernel code that actively
> munmap/mremap a system mapping without a request from userspace. The PPC
> does call munmap when _install_special_mapping fails for vdso; however,
> it's uncertain if this will ever fail for PPC - this needs to be
> investigated by PPC in the future [4]. The UML kernel can add this support
> when KUnit tests require it [5].
>
> In this version, we've improved the handling of system mapping sealing from
> previous versions, instead of modifying the _install_special_mapping
> function itself, which would affect all architectures, we now call
> _install_special_mapping with a sealing flag only within the specific
> architecture that requires it. This targeted approach offers two key
> advantages: 1) It limits the code change's impact to the necessary
> architectures, and 2) It aligns with the software architecture by keeping
> the core memory management within the mm layer, while delegating the
> decision of sealing system mappings to the individual architecture, which
> is particularly relevant since 32-bit architectures never require sealing.
>
> Prior to this patch series, we explored sealing special mappings from
> userspace using glibc's dynamic linker. This approach revealed several
> issues:
> - The PT_LOAD header may report an incorrect length for vdso, (smaller
>   than its actual size). The dynamic linker, which relies on PT_LOAD
>   information to determine mapping size, would then split and partially
>   seal the vdso mapping. Since each architecture has its own vdso/vvar
>   code, fixing this in the kernel would require going through each
>   archiecture. Our initial goal was to enable sealing readonly mappings,
>   e.g. .text, across all architectures, sealing vdso from kernel since
>   creation appears to be simpler than sealing vdso at glibc.
> - The [vvar] mapping header only contains address information, not length
>   information. Similar issues might exist for other special mappings.
> - Mappings like uprobe are not covered by the dynamic linker,
>   and there is no effective solution for them.
>
> This feature's security enhancements will benefit ChromeOS, Android,
> and other high security systems.
>
> Testing:
> This feature was tested on ChromeOS and Android for both x86-64 and ARM64.
> - Enable sealing and verify vdso/vvar, sigpage, vector are sealed properly,
>   i.e. "sl" shown in the smaps for those mappings, and mremap is blocked.
> - Passing various automation tests (e.g. pre-checkin) on ChromeOS and
>   Android to ensure the sealing doesn't affect the functionality of
>   Chromebook and Android phone.
>
> I also tested the feature on Ubuntu on x86-64:
> - With config disabled, vdso/vvar is not sealed,
> - with config enabled, vdso/vvar is sealed, and booting up Ubuntu is OK,
>   normal operations such as browsing the web, open/edit doc are OK.
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
> V9:
>  - Add negative test in selftest (Kees Cook)
>  - fx typos in text (Kees Cook)

You have a bad habit of missing stuff off these logs. Usually I don't
comment, as it's trivial, but while we're here :)

Please try to keep an accurate log of changes requested so you can populate
these properly.

Obviously this is not going to block anything. But for future reference...

  - Add selftest to main selftest Makefile (Lorenzo Stoakes)

>
> V8:

Nit, but no lore link?

>   - Change ARCH_SUPPORTS_MSEAL_X to ARCH_SUPPORTS_MSEAL_X (Liam R. Howlett)
>   - Update comments in Kconfig and mseal.rst (Lorenzo Stoakes, Liam R. Howlett)
>   - Change patch header perfix to "mseal sysmap" (Lorenzo Stoakes)
>   - Remove "vm_flags =" (Kees Cook, Liam R. Howlett,  Oleg Nesterov)
>   - Drop uml architecture (Lorenzo Stoakes, Kees Cook)
>   - Add a selftest to verify system mappings are sealed (Lorenzo Stoakes)
>
> V7:
>   https://lore.kernel.org/all/20250224225246.3712295-1-jeffxu@google.com/
>   - Remove cover letter from the first patch (Liam R. Howlett)
>   - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
>   - logging and fclose() in selftest (Liam R. Howlett)
>
> V6:
>   https://lore.kernel.org/all/20250224174513.3600914-1-jeffxu@google.com/
>   - mseal.rst: fix a typo (Randy Dunlap)
>   - security/Kconfig: add rr into note (Liam R. Howlett)
>   - remove mseal_system_mappings() and use macro instead (Liam R. Howlett)
>   - mseal.rst: add incompatible userland software (Lorenzo Stoakes)
>   - remove RFC from title (Kees Cook)
>
> V5
>   https://lore.kernel.org/all/20250212032155.1276806-1-jeffxu@google.com/
>   - Remove kernel cmd line (Lorenzo Stoakes)
>   - Add test info (Lorenzo Stoakes)
>   - Add threat model info (Lorenzo Stoakes)
>   - Fix x86 selftest: test_mremap_vdso
>   - Restrict code change to ARM64/x86-64/UM arch only.
>   - Add userprocess.h to include seal_system_mapping().
>   - Remove sealing vsyscall.
>   - Split the patch.
>
> V4:
>   https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.com/
>   - ARCH_HAS_SEAL_SYSTEM_MAPPINGS (Lorenzo Stoakes)
>   - test info (Lorenzo Stoakes)
>   - Update  mseal.rst (Liam R. Howlett)
>   - Update test_mremap_vdso.c (Liam R. Howlett)
>   - Misc. style, comments, doc update (Liam R. Howlett)
>
> V3:
>   https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/
>   - Revert uprobe to v1 logic (Oleg Nesterov)
>   - use CONFIG_SEAL_SYSTEM_MAPPINGS instead of _ALWAYS/_NEVER (Kees Cook)
>   - Move kernel cmd line from fs/exec.c to mm/mseal.c and
>     misc. (Liam R. Howlett)
>
> V2:
>   https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
>   - Seal uprobe always (Oleg Nesterov)
>   - Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg Nesterov)
>   - Rebase to linux_main
>
> V1:
>  - https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/
>
> --------------------------------------------------
>
>
>
> Jeff Xu (7):
>   mseal sysmap: kernel config and header change
>   selftests: x86: test_mremap_vdso: skip if vdso is msealed
>   mseal sysmap: enable x86-64
>   mseal sysmap: enable arm64
>   mseal sysmap: uprobe mapping
>   mseal sysmap: update mseal.rst
>   selftest: test system mappings are sealed.
>
>  Documentation/userspace-api/mseal.rst         |  20 +++
>  arch/arm64/Kconfig                            |   1 +
>  arch/arm64/kernel/vdso.c                      |  12 +-
>  arch/x86/Kconfig                              |   1 +
>  arch/x86/entry/vdso/vma.c                     |   7 +-
>  include/linux/mm.h                            |  10 ++
>  init/Kconfig                                  |  22 ++++
>  kernel/events/uprobes.c                       |   3 +-
>  security/Kconfig                              |  21 ++++
>  tools/testing/selftests/Makefile              |   1 +
>  .../mseal_system_mappings/.gitignore          |   2 +
>  .../selftests/mseal_system_mappings/Makefile  |   6 +
>  .../selftests/mseal_system_mappings/config    |   1 +
>  .../mseal_system_mappings/sysmap_is_sealed.c  | 119 ++++++++++++++++++
>  .../testing/selftests/x86/test_mremap_vdso.c  |  43 +++++++
>  15 files changed, 261 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/config
>  create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
>
> --
> 2.48.1.711.g2feabab25a-goog
>

