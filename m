Return-Path: <linux-kselftest+bounces-35286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B601ADEB17
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 14:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDAA168AA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476BE296160;
	Wed, 18 Jun 2025 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MQ89qycE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vmcLeSNq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0FE298274;
	Wed, 18 Jun 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248002; cv=fail; b=ndGVyoJG4mcN1m7RmZaEgSoffXkNl/QyReK03Lx4RwKYe7aU3R4u99Q3HVyG4VVK3CrerDybbAjWmI37zfrhq2+jrlBkwT/uKZXH6CtvFqngyRrPFrEEBckaXyp21IrR11Jl/fR6b6OqSMFh9SJv3NrAhjX0Ba187R/eHnCIbx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248002; c=relaxed/simple;
	bh=U1kTKsDWX9c1vRAw26FipU9mu6uLugwxMzJnWAYU6og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=naM+jEgk4CbhZ53KF3LEWBhwyafXEssTFI7kKagGAuSMSBPuz7aOkUkqWH+eLQp23g5W6XNwMSTDhHjabPwHUNLCWA1hoYCsiek9IeZNnQT7sGcWbnXP6KEXQyiQs8wiyPWEpzFVkHEXw6L+/Fco1VqeF7hoS2ici+Y6uBRLxVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MQ89qycE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vmcLeSNq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IBMYZ3026122;
	Wed, 18 Jun 2025 11:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=U1kTKsDWX9c1vRAw26
	FipU9mu6uLugwxMzJnWAYU6og=; b=MQ89qycEWMZcZhUJW5dxfPA0TpsOhTzzY0
	B3rVTtFEVTUDt1TlOoykzpabSjShWm9S5SDk9gw69n71LvVJnLeeBCdqgJBvmgJd
	79TO1ELG7X4Ssxjk30BHM4iVkfRL2h6HBy0sve8Cr2rH/FURJ/ZZSFHi+Uwz2XTa
	5XbhM5VHOM3SfEuZ8KA4hg4y69Yi1x7qJkbRisz0UFzx0RshB8G+4jkQ6PJaNAKj
	6gdE6TLzedzzdxolkF6QpCreVZhQZi5WD28fyMK9LMulnfuVWlVQqiere/lo7cNL
	+xPdL7mz5zlg1gxYXpMCQLokin/hsGgFnxssISsu63OLS2WZk5QA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvn70r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:59:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IAP8i3000790;
	Wed, 18 Jun 2025 11:59:36 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhajawu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEde88VZOcgpuCv7DE/kRj9RooZPT6Edgz6s3hb1DdX89FDyd4/eqz3nelzL2AieLJdUWvIrAigORvrOQriuE57sGYHDI2fiNROG3p3nIbJUS3EgusoCMnylQNQpXnI7FV5g91xSPuvbM4jXY+tH5svK6n74W2p0xjUnE5/iV0OEHyB26J0BVX11Kuj/bCTW1ZbkfIYyDBGq9BBmf/C70onHPlp1FVG+mHiT8QP3jWo0Bkn/3D+7EQ60iQCb+JTMC7a3DRJvjv6MVkcVrXfhwhyMnUYfS4QDbGhh1KQ4AvfDyzIvNVUZlvLEBt1kBwq3UrGDFzFGQjKhtFY8kK5K+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1kTKsDWX9c1vRAw26FipU9mu6uLugwxMzJnWAYU6og=;
 b=brkvFL7ZHZKtOLZSQe5+OVC9ucyniD8vuo4aHephNJPKyZFRwKczIrXbIShRaS6SE3fryBWSWWxdHwHxskEWvwuTKIWVKgXhB2fAPexMTAADTFENrOKQEAhTiTOcEaOUHnKHMRa5oukJvoAUu7nHt7wIFx/wV+z7myMABIWFvgKfhmutXUhPMWA4xt296ISEnTCh+6mKZ0BYUQSa5UcUWxvpgKPdLISdy3Jod2wOl9wkDfCsoDEH5CfCZEpsJhionAUwCU4zoTGsq1Os7jVFLd52AqHq3V6DIMj7Gm5zzB5pu7PGCnTIVDsllvZzOm3+3xyOHFrCeaHleyuSQ0eH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1kTKsDWX9c1vRAw26FipU9mu6uLugwxMzJnWAYU6og=;
 b=vmcLeSNqB3aZ4+3TEDWr3kH6XDj3IjDmlb0Jbui/Y9JOxrV1GY3ecw2ubVyOqDDlBOdngubbMj09turB9zz5CmHI9K/Amr5ee7Y63Rmg/wAM+E1xL1yIZQEW6+zNw2sQ/LKQbDr57z+QBrH1dEa2HM39lgvUHyrlCaic2kOLy8c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 11:59:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 11:59:34 +0000
Date: Wed, 18 Jun 2025 12:59:31 +0100
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
Message-ID: <649e9e39-b786-47a5-b932-5170f7e2aec2@lucifer.local>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
X-ClientProxiedBy: LO4P123CA0628.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 83509cac-5f35-4537-a80e-08ddae5f97a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TmOZ2gyRc7SoNW8EUhmbZGpDuNhogcPThgBWdBqxAeqiJw04v26UEGVbxt3o?=
 =?us-ascii?Q?kI0+Hz2I53jWJ6i66JEqx0DP6J/HdRokF3y3A+kLfUTcj92eX1t4KghMx16t?=
 =?us-ascii?Q?o7KgaQmXoS97JbJMLrc4IerIadnVqcE8GyuUj9cJctWDj2q0RgKMOP/QIaIp?=
 =?us-ascii?Q?t9CWRmNTvB0Bbx3jt+sdMRnbKUvzPD/vow417eB7I1ASX5iijsWwxMMRVNe4?=
 =?us-ascii?Q?qriJwPi/lNFFYTBLgUhxt5ow4bbe9psW+dkQppmibb45ISV8/p24nIrHD5ih?=
 =?us-ascii?Q?Ai9Rg0baaoAEslrNn8J+/Zilq4KM5CupjxBkMgeX+XzogAzs9lMe2SpsP62g?=
 =?us-ascii?Q?5cjAeveh23ENs1sgcukNMFjb4sI3qVixUTFVJlFVfGHbsSwtDl8nNEGpiyzh?=
 =?us-ascii?Q?Rw3NTTjDVzQFKe1+dacUkabtQ+Hy2IXiN2xaEBHUPeWMtV6u6CM+resMJCIx?=
 =?us-ascii?Q?p5ZcAk9xePXUCQAUSR4wt8NBICu3ukywoYLAhhGh+FKib8cAmaapD1cRGok9?=
 =?us-ascii?Q?Swo5wBX7JNql7Hm1U1Y+Br5Ra2VIthxZIgArPVEUsZolN27ojxKOxzMIxTr/?=
 =?us-ascii?Q?wQ/URb0O1DyC81Vqy2SPq9noZP4ASwwlZjPJpBRSPaTexNzzqT5tOw52LKSi?=
 =?us-ascii?Q?XxKMtPiSNAHeA4cleXeVz1yKKltt8MtTQD6qlUpoG8QSbO9i4vo30X0MnqjQ?=
 =?us-ascii?Q?l9SQzvQQugfocG8hSYXjJMuD6xujQm4/RoPu2/nE2Ghn9LL6MFsFktvrIutO?=
 =?us-ascii?Q?KI3LPsRbA+FrjyGTeBQOR8jOAftnDSAyossX/3M/9XCSGmkyM8jeLeEOeU1y?=
 =?us-ascii?Q?CRLDFCC3G5i7eUe/kXCIQsCMibGD6IQ7Kw1Gdd9oE8HGQ9GivaPATxK6U1Sj?=
 =?us-ascii?Q?qMfCfmPJp051sK59ZaHMuFpz6vI7ltVsqmmDRJ4CQi/57Pz2To6RXLCR8Z4v?=
 =?us-ascii?Q?W5p9GOpB7b+fxcTdGLdO6TTrDlYwiYmXQ89/F1Dp9LNFxIwmpYtDj6+orRK+?=
 =?us-ascii?Q?i6AsXMqH84zLYy1f8FYfvJIpIeNphJxKR1ZyCHrx4ZX9Ur6iBc9GoPelJgT+?=
 =?us-ascii?Q?N5BxxT4A35alpeOYcK1L+ehfGoD1wCQMgsY6jdrb6hEN9WafsgdN1QDYW7QQ?=
 =?us-ascii?Q?QPQboDGPnNfymR17SBA8o5/8RjngsJdq3sPnjXDXsUZr4RGT5IkhdWJ2aPf3?=
 =?us-ascii?Q?sJCY46mpM8ssQQUEOmMO0qr9iUn5j45r5A2eYDPBUOqjLXHyU7+Sn5PiRL6F?=
 =?us-ascii?Q?fAGrRbHVcIN0Ny1CULw6q1u6TxbmsWnEnMotCNsFT3E7rr3VRN5n0yXgUPB6?=
 =?us-ascii?Q?eaBIq7OOIKZCqNnITDbXVE45oHK0UZa4EKpw8oYzDeP4QIbMFbMYywQj8R4+?=
 =?us-ascii?Q?L3JvlFGfFV7RB7nr2SRwlKnfDXQKZsqsofG8DesuIY2OWGQxgELJucvu4IEq?=
 =?us-ascii?Q?YyFUkX9jqj8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1K7v3mwFU6QRaN/VBoRHkHwsB9LywcI1iK6RpSn4wTAwzXH+Fx7oTXoLRGnr?=
 =?us-ascii?Q?cnmrX57k+q5QoI8TwdZfXNTJr16wJDVxRVOCXGPXYhEJh4xoSlr/8FyNhH1w?=
 =?us-ascii?Q?8oF7Wh4vmV2jG8X5ZAG8phTVmsOMaJyXyxhXw4w977LpKPePIyhuyX3xEqEZ?=
 =?us-ascii?Q?BSy3V/7G2aDCt2ji7mJCSA3wCgOs0ciJXK0WIpeuqFh7hXxvZMtByooekXNm?=
 =?us-ascii?Q?PzanJwH81uWvcYftXJKf4k5XcKh7B2E/fKjMW8gq2rrGc/9IGPyXtg1kpznt?=
 =?us-ascii?Q?eJpJJJU+jmF1OB0jaaPG66222CgA5dVr13Z8SqmX2RqBskcUd2hGYBm3h4gc?=
 =?us-ascii?Q?nWKVd8Llb2rd9C1IVcOUbKR3i6mmRx+RUeDHhao4hJ+uKHqMdpg+E7+Sdbm4?=
 =?us-ascii?Q?x/37HvJqwrNcqFIE7QB/gBRVaN+kEJ56f5Wm/PvgPKgCdU1u7X8494qdFz6z?=
 =?us-ascii?Q?yF6wLYyGo3RifEhTa0ffIcfgwkJCKlI8ilJs8aN8sE7zLPfB3Ma7agW+N1R2?=
 =?us-ascii?Q?JE000MvLEXJ9pQn4AuGAfVxHzQjT81O/DWT9L5cdFVzriip0MBW9mIfbjEMt?=
 =?us-ascii?Q?TefVNt6uPnShr/QaALzt6c/gDqPFHHyUE2uyybRePOggs8SOjfHdS/l3XoJm?=
 =?us-ascii?Q?lyP5deRXwd3PqVHTwkfGvkmYBOSGtwU/eec1vmTnoaXxpqbNtR7/T4jSEOng?=
 =?us-ascii?Q?O3WXTxfut9cnHCoF2PIZyut4jlzO4yQLs7bQTM8vG7RQKtPIRNONQlsZKEPF?=
 =?us-ascii?Q?oBgVC1xjMaZXy1pnX+kDpf62SAhHcJ1lw9iJo0qTlDbfwHct+c5jQSz9UrGi?=
 =?us-ascii?Q?6t+bgK8PoKqeW6Y/5eMLSJQRVxEjqG8PvIdjkM8rX+6isS4Djv/OJnNR0qXD?=
 =?us-ascii?Q?cfbCNYJ/Pbt/yuRW9Reo0zisRIMBRd6THHLk8QcObynQwavWaYJGToB4dbYL?=
 =?us-ascii?Q?FnwKaZsC6ejczKad9MmVYZPYtDlgi1Hkszz3sGLmR3/qO57wGOLN78m++aJ5?=
 =?us-ascii?Q?1ClC8c9DkZKvP0T/wdGqMFOiui1LW7Fakvk4EMR6D+EZLWcGGom+ok1Yyv4b?=
 =?us-ascii?Q?xZLzNOpnfrQFH4jZhFuDXm82B6bSsMQr2zvPlyCDgQ5BAYXvqERei2J9WUmU?=
 =?us-ascii?Q?kgYVqqiKZ5gDQE6bdhMhQlw+JvH30QTwTA720sdJBqZoG0XEWPDDMEnGn1TA?=
 =?us-ascii?Q?EDHCu22MlWeGYgiMOqwXw9FYqtQDoMHIYHJYo2WSocp61c0DDngCyVVWYfoQ?=
 =?us-ascii?Q?L4HMrGd6USoIOCkGV04jofa1iKa7AsEDr3jE6Pe50102rPAsDW2HBor27VcL?=
 =?us-ascii?Q?5jyggRPTlgrONQpXkMr8OHkXPgkeTtQ1Y/xnzYs7SUjEjTCGoP/NPqu9wZsd?=
 =?us-ascii?Q?+1cbPvid2Zh0Y9V6wjO9IayGfb+feTH9/EeSV3wCPlB9dHZROWZ7svW7jn/c?=
 =?us-ascii?Q?Tvm9jpEX/UbfvCgg8juXi6XzC7ibeD0Tu2ZZFFo15kIFf8TehtBblItWimiG?=
 =?us-ascii?Q?zxczsCGurxpEkJbgzZG+7qYl7wS7xFGUglosXMAUHHMFBtHHvMAmGRYKpaok?=
 =?us-ascii?Q?/x3Fz2CeJNzFU0qHLRYog1URLI2TXowttH+4OExVA9BxgiiMX2RJ2XfBYFvO?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AT8NgTm3fo78eNIiCxzFMhR3VDSmTsA1EBDjeBtF0wBABj15KB1pR9nYSJWQILcYPyVeGYaQ0yeYlvlISuJX/xKdTBp50uM0LXRimE0vIn9/+mUBdLCQzR/b2lPQWbzktejqk/JnL7f7wAspVH+lNwaMkaMRf6/PUVZT9VNpm20KngOGvSGmHqU2Jzok+1uw6eRyPz9AApDoSmBGSObyFMiduyn86jPtu9woTJdcccKkFV4VvlaqVqVFbgGGetbPaROpMEo6ZoR1dGbiPdt0ydG6E4gKexArDoZ4GaZdBxD6NBFnDwbUWaRrwwIRR7P6ivrZjfl6pE32E/oO9msXTMmPEYAnINl7bT0ec/5en74m4tmIcJsssUAD/gzJjidmmfTDNE2sC8hwuQp4dX8IuJ+Nd6xtXkDZRSKxklOOWWxXrXQDswwfGDXQz3VKcULn7iXYuvzECfevXNtLFrgPrZlNDGi4dhDFxgmqqx7AjAAkSNrNvvhzVn/jV3F7Lq4mMsPhlaO2MVRF6eAdUvJ39cts9GW4UUO+kiZYaR5nvDOIT9/Ndx7ECuo/DXOINvADQIuh5cYz/8AtDKPtJFxM8wQERbuM/CfaB7vqOoIjW18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83509cac-5f35-4537-a80e-08ddae5f97a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:59:34.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESDFRgaWDDEegz3Hn9gEZZX/Gzy2fkt4hOSTyo+Ha5eQQa8nUVJ3ITtPzKnVdLVCbUrWSUAuRT+d5sLqagveAKgx9fFm6wEKQRj4amsf6a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=932 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180101
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=6852aa29 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=27G38BPztPnxODzKcc0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: aCAlsfwiZ1rQrk1TUMTuDqjgxkfbwde3
X-Proofpoint-GUID: aCAlsfwiZ1rQrk1TUMTuDqjgxkfbwde3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEwMSBTYWx0ZWRfXw6H4DDveQaMX DPipenR0uQ6iNxXuLIud2hlU3B574Jz+6SK4qAX9SgrIw8mh118kDjwjc5vuKmovPZiWkn/ko6G hGdm+vy4DMtWx2pQa4Uh1hydvW93nTwemZGVm4jrJrCT4khXXD1H3K0pRDbGhgJQ8/cZFi//uS0
 a/E3SPC0pdSWN94h+5Mzwc39YiD4HVm3aJmoPLhjFYqWtbOSEWFCk1z+be6kFXzWe4OfBrObGaq wb/AhTl5TMR4/bBiDzKEy2QVDX/6S8FBfc8O2iLApBtZzLAEqJdwZheZB97WpXyjLMG9efyCYp7 sLbvQ+0izfFK0ziKYyeFrT6/0KVt3YiVZdNyamBExEnXjApwNBKcA2cdMnFesf4GT8j2MzaWJLd
 atQMn6hpnDfrGLdQhkeInMI6GNkyXuHanyeeUe46u2Bs7pxP2pd0FYHV26oPvQWfEJyXK/XG

On Wed, Jun 18, 2025 at 12:57:38PM +0100, Lorenzo Stoakes wrote:
> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
> first.

* vm.max_map_count

