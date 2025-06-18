Return-Path: <linux-kselftest+bounces-35293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21512ADEECE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643891BC0416
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FDF2EAB68;
	Wed, 18 Jun 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qr4IKa7e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y3GsBACo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433D27F01C;
	Wed, 18 Jun 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255662; cv=fail; b=CLaSa2a9/ERrvpiGShYxKhni1ZcdFdaLsah7WcM7uDCyvcLPAuPfjOrTwUiDqtt/M0CLEXEdfx2GGVWe7qwXBSu07agjUi3M0H6u8Sa4hwkLTzH8M6fFfbNJamb4a+onG9y7hW0Ny366ennK2xKSa3AIYos6FdjH8U5Zz+uat4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255662; c=relaxed/simple;
	bh=zzG57nZKsN+WpcW8v50ekhDbJcekxzs32aNOLZ/yxCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D7Rscl7jFnCHbv3X9QvfUqLPSg8cVXeqvyqPuBzaBHFRsMh+W9nyykiTJBixzpxEs4VWnW364/isGS4FXh1wVgCJTBmZzVwf/4BIuH3KyM5YL0MFAUBXJdoLS+nyKX3pF+IdswlngO8sKu0MeiSDvI8JvQfqLnABNIM74Oez2Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qr4IKa7e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y3GsBACo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ICQ4xP023580;
	Wed, 18 Jun 2025 14:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=k1CpafBp+aPNLoPgYa
	oru0hjwegEHROjEJTAWmO8Zn8=; b=Qr4IKa7ezwIE2LZx/VgEB90NntIGi1qlb7
	haHj0IYkyG/m/P8KrJ+ZN3Cu7Hp6UBHsEqNlUG9hqJqOGRo2A1yJFH7s1r6XWziZ
	arc6j62DOgV7cv9bKcGgG1V9wr0r4UFvyoQx51nA69hsoFzz69nB4QlQ3p3ZsStj
	vHJkojtVfdeWgxi+SQHtiEEN7g9Cd7K2mREhyJpFmfc9K1KF0GO7BYbn6wot3uYD
	x+tF6mA2/PGiYkaa/p3g8zXPTetmPgytVyZkMmRdnPemV6PesOoQq56BVzcQs/R+
	MTicZ+LpbC2irU3jId6n+XBvHaRSe5l9um+M5XRBAhL1IN/7UO7w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvn78rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 14:07:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ICtLJq026029;
	Wed, 18 Jun 2025 14:07:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhgy565-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 14:07:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxBwJam0AYhd9/uc49AKDxWbdyEuwDY/DksNLPVI95V0nhnpjzlwonJR8Nue/F+n2UfV8sOS1wRf4bOKsMzhOFpaVKan4ufamLbjWlYLsB07AWqihCqnWJ+7RxfgfDPSfT4e2LDAYupsqY1C71jPusDGbLASzvYMSvdd1ylOZN1g7R1tiVIZ4c5YvukkxvNsnwdW2jRLhXy9z4kj3SdmfjpkK4aGV04KL2SU2y5Qckw6aifOdNS14d2hULbDUZHEbKXwGjQBz67YJ3Uak8LkVw+KKvED0vQ4It6d033vg1bbYUXzckjdu0bBs3+gpsBGBHlzgQsLaZRbY4Qk++zLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1CpafBp+aPNLoPgYaoru0hjwegEHROjEJTAWmO8Zn8=;
 b=KpZKU2L5QKBO2Qs1aGOSjVWmJtsKOkieTUpTBOS3m0f1pgIgPRaiVyOmdoc299IAsvGnj+V3w3w8Sa2DWhi80ZCU9rVSpjPRjN6QJdTLIiyQBFr2vqmkrNeiIduV5j+NT82fxSuqDzUKwx8jjZKmqNAMrwNvm2x2CrT81/YUYnC0jLyHPYkNjZ4j9TjFzx/oq5WwRAX2J3Ix6KcFmzP4HIuezEVru6Jvq2ywyKFfrYRtux+3rE9QYjlGQIuPsqd2GhPQrj4LZc+V4ZSxcDV5M6aA+nAnBU/DuTUTwO67OtjrWpJRME+ib8vKu+RNz9Kd9Q+RaAaZe+PxhGR5YyWH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1CpafBp+aPNLoPgYaoru0hjwegEHROjEJTAWmO8Zn8=;
 b=y3GsBACorLZphJn+s0PeCtCgHMCcVOfGNgs/cd9aScAbDyZcLEcxUeoHzcf0T0kiJrLMdkJHK9XC7H4KMBBFg4ooLLdtPfZZ12jN3n5THDKnGbv2AKTepJxl3zPGmIj+42lxSq4pu7rH/GuJYZ9NVOXg3LU0ARuIK6mfGtjR3uI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPFCA9331432.namprd10.prod.outlook.com (2603:10b6:518:1::7c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:07:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 14:07:14 +0000
Date: Wed, 18 Jun 2025 15:07:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
Message-ID: <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
X-ClientProxiedBy: LO2P265CA0399.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPFCA9331432:EE_
X-MS-Office365-Filtering-Correlation-Id: 1119d94d-898e-4c8c-cd5a-08ddae716d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XhwXQJwKApd9M9R/eSlxSLu0/x9ddkMa8Kbzzoc4Jt9DeCi/wm5HM3pkz+Ze?=
 =?us-ascii?Q?40NnNtFgGZeExA5p6YFKhDnaMD1G+eBn9wO8KUfLSWLGK51T7lv8qHOrG4uD?=
 =?us-ascii?Q?HMYWkuCkG18OIIDOXdvFNj0EAogaU1wIZhpOPqEAZ/NnpyiIDCILedvuPbG9?=
 =?us-ascii?Q?D7MqcVjF5pCBo+9ZwxyvhJSDd9zZHA3JWCggdabrMBEbfYuL7u0+Fo1bSnWe?=
 =?us-ascii?Q?4cb5NKQFm87gCNln80p1tueNfkRX2++WNvYF9hKKGORr9PGAc168XmEluZma?=
 =?us-ascii?Q?MIqPERe69VRuStFkIKAO2vF34eh/h/h3u+zom/mXQicNDFX1ytBV+vT/0Rr6?=
 =?us-ascii?Q?4Q89vo2LPp6aePjE7MpxQXtIxgLxijFeCsPl3cv55OwOwJAfaDz6gOkQSKnJ?=
 =?us-ascii?Q?vJeR7BL3WAxVvBO79doiKTPTbiD7K7v5ZN5Y4vsfcUkKgetLxjY9TtmDFTeR?=
 =?us-ascii?Q?GofmhILbqmhbTMqaFtjz31YMZUrBZNWt7AukpmcPEK0Qn5Mp0JuVtoO5H98t?=
 =?us-ascii?Q?ZxE4PXRzGK6Jt2/EVaAqBV+rTSDObb/Y30znLIjqiskDWqCEti9+CHpNBM/Z?=
 =?us-ascii?Q?qD40uJptirLUgvTEmNy2rPcYJIpvLagoJLgj2B9w/rtP55t1AzajD4dszVJ8?=
 =?us-ascii?Q?cJi0a2Ty1bvehY9KLu2WhD31AklpshsRQ1DWCXgfCYLN72fopElmmdG+JB3z?=
 =?us-ascii?Q?/SBrXaqtVWeDTsVN4ybN51Yq7+ZPFVsieiWZEEF41C5jmjCuvtCd2UtmrIyN?=
 =?us-ascii?Q?03wW9bxC1uNOJ1ZYryaeSS0v1jDUlAQObOwBpHUkFP2e7y3OSHFeHtZyFMLa?=
 =?us-ascii?Q?ynXSb6zt3JhbJOFy7DRutb979CQtPPd4dqKjpYMO87lkcn1Pox095dXl9/g4?=
 =?us-ascii?Q?2b1KIZ560bOlnJuXB3c3DtuypHcR6RsqLZWuabkWogi7Z7CJo/JY0NXzjrhU?=
 =?us-ascii?Q?muCqX34frURTxPemAK+y1tLFMKQZWTjmwZ1R5sPwmnWqLKyeehdOdmyRqth9?=
 =?us-ascii?Q?5dMADBfz/ThMz7gXBIAVSeUKM2Xy6Cc0lD3Z4VA4C2xcPvSiYTzXSEDDkWx3?=
 =?us-ascii?Q?5pgu3/ImC2ucjIhDuj0KSyxHAkA4cLOekbuyOxV1714nEFXHvT34z5ApXYNK?=
 =?us-ascii?Q?MJb2Bvyj4aKOwPD4UAtu11YYGCG0f+REDWc6rVEHmLIIM0hxR1xFy/Y8kqRe?=
 =?us-ascii?Q?HbXTrnJseGWSxISmi5g0J9jZofXA3RJa1NCHclXsCpw4BqYI74QmXjWzs29s?=
 =?us-ascii?Q?20dV7QFJHRqjjxpaqoTazV+elRXzkSCXH1g3bgqbQ3usbO6SxHmlYovWC9+g?=
 =?us-ascii?Q?iQH97DLfhCSHAOY23vhjslM7gFClNC6kLqWYpez7Q/7o23j0PzrOa7QwY5+F?=
 =?us-ascii?Q?K9k5z7wDmWxSkZG6Eg2zjf2pXqRCt8KuPFUztOnbfYRaoor6mQ6FDYXzhizA?=
 =?us-ascii?Q?LvcZtrsoj0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mBHnfuSn2AKwD7UJL6GchHjw8uMjLHB/gZhkYu6Qfr0dlqllTMT1A9IIYli3?=
 =?us-ascii?Q?4psEIwHNBxbwwlH0ANViJnFv/hptpoHThxWHyZm8a0oitJo2E64+gCe9Gan0?=
 =?us-ascii?Q?+wGC6/l6oXtkchkuzjnzLX50ei67ww6alkCsLUj4U8LHhJxoiUHALLq19m5d?=
 =?us-ascii?Q?mWXnPNxijji9qHuPvBTpCG19nwLx5wSuSwpo4Xn1q0A4Ir0m3tO0QSsRjejb?=
 =?us-ascii?Q?3V2lBVikI0hphHB72i7tanzdYK7cpy2sv+31v7LFEuA9wvH+uOzDAmW4zL5q?=
 =?us-ascii?Q?Ga+3F4Yjum7CC9RSXLjpaRCUwTSEPtUBMYHUkcuZ0A4CQuJAkzRGGHm5m5gM?=
 =?us-ascii?Q?fUpamUafKywBRcicNZ+jYXApqQJsgeLW5+7zNW3E+RbwkqEyRFRg5Jo/THzu?=
 =?us-ascii?Q?VuyJCgbAvw0pvqWZ9Bb1knGN6hKNZtjeLDSCCJvpWXKd7sWuineBoh1C20TG?=
 =?us-ascii?Q?lrs0thFPVQaksLZdaMF7+kDBtmt5uJLE6fcBsrexvipUBFH6Z4aWgYxHzjWP?=
 =?us-ascii?Q?3UsZgo369RGCEtwKNG/5Y0HzciKqr03S1jRcae6XD4gzCNY093Lj44bW6fPB?=
 =?us-ascii?Q?LCw2r3swl0qtVoN9VAdkZYA7Hm82wnirTbqAOyLhj0EZaMocLMqlX5dVPFZX?=
 =?us-ascii?Q?BK4bwF6AUD+aCWdovEWF7/7ZgSr/tkiEFapiW9gPiW3pfjyVGD1+jag7e8rt?=
 =?us-ascii?Q?dLRMHLdpgtS5ugMpBDfwdm4owNNI4Nq2ffy3oVlaq+0Rd86ZequCcQy8OeqC?=
 =?us-ascii?Q?HAQMQfzCiQh0uaOi2+9b+YZOgq6hYvxC+b+l47D1u0JwGPOmyB67P2rLXYsy?=
 =?us-ascii?Q?Aj0BoqjxhmgKX9mnmTQ4gmDbci90ycig3vcqTlesqMdNROXRIhu1MeaxeEcJ?=
 =?us-ascii?Q?ag9Bq+amwtsundb4PLA050cq1RWT0y8+SXV/LYlmoy0RhvRuUmP8Tv2PtvBh?=
 =?us-ascii?Q?qzJ1eHeaq4L2DMi8gJBHhaXNAUbkkGTbgYDwCGcTE0GErmVUWpsYrATAxjLN?=
 =?us-ascii?Q?6skBr04J1HY1UgZgKXrOePqibR5Zp8WAJnbDkqSLDXniIK7po2cGK/VtxDH7?=
 =?us-ascii?Q?dIlhvfbrjfyNbBRwLbzBF0gr0y8CdF1wTvwPU982h1jwoJnjAUHSSoyl/SEd?=
 =?us-ascii?Q?FAVdFtjVC//OR0j2GEF+OyMrkEjxcM+Og+KLU6ZltRS7UfIUK/fZNS3CZBTt?=
 =?us-ascii?Q?jA0eG60rtOP8WtVUnYYkkIE4xwdB8cjW5jW9SBj9hSpaQAB4ZSyKS6nESbIC?=
 =?us-ascii?Q?dzz2Z+E/y2ZPsnsUSErdciX/YQTlcIJPrzf/eg4vW/0KApVJsNyE7wnQNsFl?=
 =?us-ascii?Q?9JdeTiui4iJtxrLDMA/H1T7cR0+NK+b5jhxH5XhhFh6nZoGJrz7n/S+EpkNm?=
 =?us-ascii?Q?pQ3+uIWIY/0ozXbfYFr95lMD1wcC8iAz3in3dZyQBZ/LWQl32webF1LpLs+h?=
 =?us-ascii?Q?spxfoDPAbjeH6KCSzd+vnsoBzPws6qjZqoFxCbGBKU7jPLDXVdI/eAqEsJQA?=
 =?us-ascii?Q?SMfLhq78LMzFtP7EgVv3s7KaLA3U/qjG8quuUmNBmU1BL+NfSJ0tuUV8oFDF?=
 =?us-ascii?Q?hIccp1cYNT0Cbx/a1heKECZXrxMOZyzknruulPbGnJtiThHC/J0Mw3EyvHYp?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fNA+mmuEl6brqokt61d0VWcEQxD5CIqUK7aNYvlekX9Pd/yJOQs5obctzxkrBOzJVDTmkVwySM9m5VtoUpyCxv6ysDd6xPfkh+hNEBOo//W+PS8DdIal9xyv47du73rLJ/oNE1PdZ2chKTm2fovfgHZMoyIc1Dxp03hRP3ueTMOA6qUFjA7nqiTj2fL1194EElmwbm1mmHlZ74LDNLIIrbjBDN7oo6XI3OHWm+gIGmuqIrtMSMzWNqymS6KX0fajRCGbcT20Eomm+xvXLEuSpWOgldi7A6lQpm4FM9qLiAgSjLpZ6G/iWiX5S2r8ohDBvWnDkbEgYjaAy4EeBZsvsfBkkWBZD2nsPGu58sO+3b1eil6/E4PUa6zbg1KaCD1gGQYggZLJ99+hwxlrLF2UHaGO2pCJUUi2Bx5zmIJ1i4ejp8+FwcEM/br649F24C6GmsDKk4zZF2dILiUxFPTPnjLJrS8dAqwfoTferYEfqWn8VTnBXrjAnJe6NyuwHoCnoVG1jukwgcR7ZQnDbiI18hVwPQKQTEyGklIXkXFLbOxB5wiH3VVtM84m19V1mg+i+pDM3bltpjeFvpaj0ULSJIgW5I4y0+TkI38vyEaQJdo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1119d94d-898e-4c8c-cd5a-08ddae716d6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:07:14.7783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdfsqnxTBqBAoW4mxorvgPjYoCux+IDiAhIgb9q5QcyBUZVvFHqp75SkB7StShPK4vvkT3sqYpNmhk74mROzBF1s3L/2tn5AX5Ollh+bobQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCA9331432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180118
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=6852c817 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=QbCuW9U7Cy2gplWP4dwA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: 6Sl7nqcMGVyuV7KfkfpGBANxNbM3cFwS
X-Proofpoint-GUID: 6Sl7nqcMGVyuV7KfkfpGBANxNbM3cFwS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDExOCBTYWx0ZWRfXz9cUfQaAJSv2 fOnCzfnUS2cYZCeRZgfAKuubcXmVb6yeGrEyID25zC2ewZ35x4d+qPdTAV2HpsJrbOXKEBmkn5R Yrm3BqtewCAJ8BszX6Lp/cnHPP4BfwRnzlFoCTZcz2ndLtZ+GQqSL3+OuDHw7jkcn99OwZ/q0NJ
 GVvcs233QQ6VgqHNMB+1C5mfC0Wb5RG5YxdWfQRcRCiWUtMk75kX/3xHIgaNHfmk4KQ25/AGHNd qRrOyg+7yQ3WhtS6csqUH/jTVH1BhdCmL5aJ2P42Du0S1I8d1rXTsGv4fSepVDI1wOqqVYnsfQR pvOlk5AB9eTDXNjz2CGpzkoWWLs4+6RWenDc+QOUz+aIVvUZV70XbksLp0olt3U2SzAhE563Dg1
 664h4+biXpz3BF3p6P3Seh0vhqK0LjDdZ8wJ06Xzn7kSRsNb80drA1lJvWMZ3Hciyv/kybsq

On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>
> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
> > On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
> > Are you accounting for sys.max_map_count? If not, then you'll be hitting that
> > first.
>
> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.

Umm, what? You mean overcommit all mode, and that has no bearing on the max
mapping count check.

In do_mmap():

	/* Too many mappings? */
	if (mm->map_count > sysctl_max_map_count)
		return -ENOMEM;


As well as numerous other checks in mm/vma.c.

I'm not sure why an overcommit toggle is even necessary when you could use
MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?

I'm pretty confused as to what this test is really achieving honestly. This
isn't a useful way of asserting mmap() behaviour as far as I can tell.

