Return-Path: <linux-kselftest+bounces-14870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CCF9494AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 17:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491F81C23AC7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D388224CF;
	Tue,  6 Aug 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aH0zDs7L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PNKj922I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8621105;
	Tue,  6 Aug 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958752; cv=fail; b=t6QnfiX/QPCXf/VMMLhYGM4vioiuSBNUhxThwpbXWBf23ZUcV1UB9svopM6PvdQ5/cRqbBDAoVAJgH9oJwPsVpbqVlQgUFpZYyUVkDnbn0PJiJ5y18lzRIoUcR7dT/n11XXUVhtNVjxH7h9LjygR+vLruw8OuWTo6xST/V0tv2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958752; c=relaxed/simple;
	bh=Y+rY15DAXOv4jxpDVkCXqvOGzcPOKNDx2oSAyFm2rq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D1WJfL4yi6UgDJRgjXwkm6zGiR6hJnJdVjlz7UWIenZaLrHYmgf/Z1sJsmki/iA/XuIggPdC/fXiLMo45ZaB8Se7Mp9uwzQyuxpEQ2Pxcgwqp0pqy+8tR3lAhET4wwhpOUorbZVqeFNXKUb84H9l6hpqVAAHiR8qgGpFTLSNRY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aH0zDs7L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PNKj922I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476EdOpA031383;
	Tue, 6 Aug 2024 15:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=CZO/lBl85udxP0Xkiq/dHNJpiQ54Jri+kwF6mEHKP0I=; b=
	aH0zDs7L3PpLUfyba6pi6waw20+lCghGZZf0HNe6MaI7Jl4x85rUz3bbZUwJVdNW
	hoMV68mNSwd7UZC83KYQOQCBm/Krp0JW4dUPR3D58qEnnmToZ/Yg0IXXhJJ3xBAL
	SCRvduY9sRWtvgCfp4JfozCAcY/R0LWu2gmu+2tv4v/NoIUsNSxStdQLVfRRk5nX
	e8sEc9ORYFgwahEJIKMVB1bj/m9PInK8DfRhCbP8B+8NzScJCxeyWzlUTGE1vEh7
	e+o2isGrWTX2jOGtkTYtFKS7jS2dPH6aUiTbCQlfZUzx0nYcj+//SDZEEWo5feVW
	emed7sLMGB+8NPrBCpj0jw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce95jdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 15:38:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476Ekjup035030;
	Tue, 6 Aug 2024 15:38:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb092101-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 15:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO2cCkd0lg4iEFLeyCCh6CF1L3DXVD0fGHvb0aIqLmKm1pxQ77Dxsnh0eD/PDiFoE1DRG/JWgONHJMx8sfFpRc6+Xm6QMKOQi3hoLkX058yzjVTyL+XLgnjkfuAoTrRGZ/CcrF6oJKphFif5SXtgsc4jVUoehj9OX8TsMQmGeLnr42JfuwCUgnKZfI4ETtEg3HoooR5Q5UEsNlUwIaW/GwoYGRGpGmjpdcDwaJZ2kD/Vc28LiOvn8QNN/T3jOmWFrFk+OQrGppk06kQsoFVw94N8OAfgAYAQmDNuEntD+V0Q/aqm0MCmo8Xb6NsdSdi6tQrdDzvBpruWfscc3HzRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZO/lBl85udxP0Xkiq/dHNJpiQ54Jri+kwF6mEHKP0I=;
 b=nmTPOfAFBD6FChe7p7aYetPQU8mh0mcg4qvBYLgBnEmsZ3YPaeOfMFsyKBpI457FcbVwkIU6T8vaqRywr4ESml+7bHUC+TszkbXQ/qMooer+MT5bxTct8cXEGOyhD66z4SOPwfNi7bbZER6G/ZtD58IObqHPSKW9KxPDu4k6jmTwvpHhpHTGX1xQYAIuPFjGsY8BjCijJ7/ORrAZgsnxl7M9E7kgreS+WiAtW6ei6uYSpiC07V8sVAVPaFvJbCi7GkED4D4I/883zMvDLTxdvABfT1vlg13aQ6XsJcCi6xrmNRcynd4uqWtsS4S3ztOdqB4cFNScnQ6urv8XX1qNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZO/lBl85udxP0Xkiq/dHNJpiQ54Jri+kwF6mEHKP0I=;
 b=PNKj922Iphp7xFVtcjFcmaYth8bqoxmUbEb4tXeVLXaeh6Nhpg8WjWiZmGXE4mYBV6k+kMPhKDEGPJXijZA/hTR4XWQUhCnNdSTxR8wFhpAKJXwimU1AOUBV0zmy65UbbeIeGti6y4Pe+bs4o/D+U+cnGqXFCEGi+gLS+sGXYvM=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by PH8PR10MB6647.namprd10.prod.outlook.com (2603:10b6:510:221::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 15:38:31 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 15:38:31 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-rdma@vger.kernel.org, oberpar@linux.ibm.com,
        chuck.lever@oracle.com, vegard.nossum@oracle.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH net-next v2 3/3] selftests: rds: add testing infrastructure
Date: Tue,  6 Aug 2024 08:38:09 -0700
Message-Id: <20240806153809.282716-4-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806153809.282716-1-allison.henderson@oracle.com>
References: <20240806153809.282716-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::25) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|PH8PR10MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef65695-12db-4aa6-29f0-08dcb62dd310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R6ceIBN28adzo15q4FQ57/c27nIYSXX28VEV8L4IeOnbLFTN9H1xR7MFRuTw?=
 =?us-ascii?Q?gLQpGkM60rmvKxP6VyQFbWeqIAAHwf1k1boqpZMmGc3VAk4fXsUPAikSPTtF?=
 =?us-ascii?Q?XY1thg/TpG2geJInPgfgwY9hDFHwsGUxoPxn/RV4rGmVhf4rq04dbsBgYOlD?=
 =?us-ascii?Q?m+7+7lbPGYxNjmA2z6WRIwWrzMUlKfCNafnWJzJd/4AKBpeENtHtvphdD4sy?=
 =?us-ascii?Q?1YwVKmUEinpMC1mZcSJ4yicVmNeDaG/DTca0S61BfPuDaVdcV1K+KwenntoC?=
 =?us-ascii?Q?dqmpvd6B5VO5dlyhEtlnFcBClk2kihPUnntprJ6WF4/opTFeEucvBmV1VBn+?=
 =?us-ascii?Q?R+E4M050PXGeJAIi6yIAJrATYWagR68cCt2RUt5FOLIspHwgjiu5ROwHH0tV?=
 =?us-ascii?Q?nj5WmzDZEmfoD0w71hE6+diWoV9aJquqHtrihBKXimGTgeCT7/3rTGhhibVw?=
 =?us-ascii?Q?sl47qef4VtHQnBF7NahyNJD7nPdWwJCiTTS0fmUP8+6uCbpmxRJbxwuzqsWL?=
 =?us-ascii?Q?5fwdWAEtYDlHj1eVGtlWQqJ3fYAkNgEjQ6zoOQ1HM80isz295trxAJpN76nV?=
 =?us-ascii?Q?XwEOSXzOLFYjP/gKFcuc1YaoWSjgleWT6GcH28PQDW/U9r0f6hIwscBcs/ge?=
 =?us-ascii?Q?Z/wcvTvCxLBlCRgxMKawa8iBLLpTl98oBAM/6QgGiF7R2m1IHG1s2RCAFAR5?=
 =?us-ascii?Q?3DOvvX9GCVLNBfwCo3VvP8T01cteYuAgiikzrg6wqETMPYb7mE9m67qFJ/DI?=
 =?us-ascii?Q?7YIgB0VS0bqcMbj7PVRPp/xDAg5/i1lbvtgaxNJenpz0kcWJKSDsnlSGm2mQ?=
 =?us-ascii?Q?MLo8V8E/Z018RgCLwnUlLgHu6d+zh5WGhHO+E6aUZe0Ah3KSVldj+Syu/p3c?=
 =?us-ascii?Q?GMJbA7CrFqypz38rMV+ZeIP+iDS5dFuQFrbAH4KgqP8LXIngL+aD6HoJ28nE?=
 =?us-ascii?Q?zva1XV4MVACVqN1JBQRxLkdhaH2p8I2vBJhGGuDu2fox3Z2fsycBuIqFssxR?=
 =?us-ascii?Q?d/vyQiznPZBF4lddRxrozF13W5YTUcSwrzDNtpOqKlyWrTRBOEeVnjEznChP?=
 =?us-ascii?Q?yQlhgA084x+5Mp8qGEufecmCM5L/DcSO/3pqkOY0IqU/0Ks2fB3GFVrbZ/MV?=
 =?us-ascii?Q?JHr13K2F4Dw1Vh/+DVvvEUCy3cewDv17mIC1FwXtR7YlnqT92ULpa6cAJl1e?=
 =?us-ascii?Q?UXrVFwbpshC7yoVh+eHyIDf4kNTiHZNEyd9GPWnk74f82ca+3FkBbL8e+HeI?=
 =?us-ascii?Q?WnXPmVP4FUps5dOVFa4yMZQ/c9/Mg8TAxRt6fK7sc1Byy7iHDIpo0QGdr3Hx?=
 =?us-ascii?Q?gr61ZNHWBSd3SUK6w5VOhziv0RYRpYT908of9ENZCb5M19hQbC8UKQ4Ps2nr?=
 =?us-ascii?Q?LxhViiY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DeAer1shSdyjZ+0CFflE+yzNoSl+dX1ve7MFS3onPFAlQ5pT9IN+BsOFIwPO?=
 =?us-ascii?Q?c7+oAUNuea0tVVPAYPTYx9AVNsy44jazaXdrwTCLAikKCoNmoj4q32wgktai?=
 =?us-ascii?Q?0qrc1xd3e+KoTvhJUvVYZ5NWys4XTu/TPd+lq5cPePE9wsEBLilZqkjeKSDU?=
 =?us-ascii?Q?ZaJkkyGiNqfxawwwWZLGFzKj7iG89fGKLDj8sI8ndnFnzedKhX1NQkdIkUpC?=
 =?us-ascii?Q?MtAni53EKUY41qi4OXY8/LXjEGhzvot2UjQddkLlr05/dvGAE5u0tHHg6uK+?=
 =?us-ascii?Q?KgTKrZJp5PAe81Dpj5hE7YsTUW8gUtLYsmOEGKHEtYi2t+8LT9Wsj+PYshx7?=
 =?us-ascii?Q?Fg+zjSmb3q9HR+LUB/uDGy0lcOuZGp72errRRskLNgBkKX/ZE8vjuZ9/njmT?=
 =?us-ascii?Q?drmNBBjWVsbdWQVGxulHIhJRaQAtWDIQK9XGqYgjMubH7+xVpuS4359zNjio?=
 =?us-ascii?Q?5pXe3T8NHSZpgno7F7MAI//X4Uks4gMBb9en8ogskOEB0YF5pJbTuTqRwSfi?=
 =?us-ascii?Q?5NKraHgaN8InbTkbAZXvFcKlZV+6yrMj0nRQeoAUx2PRwUtpR/AL52zQ4wuq?=
 =?us-ascii?Q?MTYAYS7GdcexhKAFo7LTo1zh8w1PceIVP/+bGFgKG8Tqx79KBFMWeiZPiG5P?=
 =?us-ascii?Q?gUfLWSDiUZKUeIKuK8I25QMG46jteLjiLEBZJ/7vBawpdu3rHI+zA69/L4aP?=
 =?us-ascii?Q?Rj0L2/4th+Vkv0sQcofJvm6rANsAFtBUPtg9a106GsBllUWBNfYsLEfeKaOw?=
 =?us-ascii?Q?8pyvYgpxPHW0iGSrqWU1p/qKdwOJDdxRj1zx/Gk1ukP/dlPg+7ewmczDDeOC?=
 =?us-ascii?Q?qBJQeG8upRnRM+g3cXg2t4ux3pPQQquzr3TKs30yF5SAgkt44PTBGldKLGFL?=
 =?us-ascii?Q?5/ebKYj9Q5k1idj7TTgfiowP2Lio18tpQNJs3DcFLLfEWSgLjCLg+sez8AKM?=
 =?us-ascii?Q?rVjfLehZ88DaWh6tFBcjBp276u2nNAtyCKrca0Y8M4CLZ1x215HIoRKyP7GH?=
 =?us-ascii?Q?FUMhvFLB7o0Y6iQEpvJl3J8I0CZ+0fwPj1OPH6HiE8tMbL99gy9/2IinDh1F?=
 =?us-ascii?Q?BVte4MiFKGwl7zvEkMjHh1W+a+waKjUd2X1IJPsZwx4XbRObXAC+xzcCN16R?=
 =?us-ascii?Q?sqBmVzZFIIzAGM6kvOMPA9NeaMXT7TTZSF6423XUpkfMz2znYoB3GaF2GHLw?=
 =?us-ascii?Q?k2uqaZ3+Wsqp7kawaLJTlAQLvoNCxgajfA9vOR3/cjOKwftVB5UoqEIj1C39?=
 =?us-ascii?Q?1uasiw9vbqT3uZpOlgxFNowTpFdRaIYKxVV5fOc/Qt4Xd7m79GDtov8oYunG?=
 =?us-ascii?Q?5/iuUle2cVBq8U7IxtJZCXFNExMCIdjSdqxq9++9/IPGT7Wwz+gI8uAU9GOT?=
 =?us-ascii?Q?UKBDc0CRf75cg6qw9T1VoGaigeUN/w42K5T2umYc5iBr0l6DPNgG0zGrJKo0?=
 =?us-ascii?Q?zZcf/vx1gn0bF1vrsRQGn0Uj+Tz1bANDL/WaNecL6clXtrl65yQ3k6RGKU8l?=
 =?us-ascii?Q?py0Gfkzf7HYZ38gUGpv9OWt+A4eTTq80vQp+ft1iGTDVVFszUKhqo0HG1wsh?=
 =?us-ascii?Q?4iOjIGlKBECVw8MC+zXujm7uCzzkS6qeTYWzomTcT06F8MaRHr3UIQOtFWYR?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2qXvdEETvA6eERhOvsTI3+EY6YJk0yHwrpGCYepn2wF4EIct2BTiG0RXVfqADimNVxnpY0+f7idt9G1Cxyszr2PbE1eklpPKeNU7Q1oBFna36AoqHzL0ehr8X/KixZJhh7knwSSPy0TSwmxGoID6hFujuBS3LLaRWCj2tsnLy2De37+YrOZV8Hijnpca3Dvj9HwsM0DN3WghUcrgP+57YkHK7DE2l/1Kc81LnNY3GkwthT9tCtycSoswDEmU+27/JuXvl6MG2ONurg1nDnW8S4OYcu319bx5LfbiyN/6v1QizJnF1WhOaUtjZ1Dn6B+erHnTtN08SgNZ1JWiatoNq7gMEdXlaBxQqTSBzh0bx6FRABGzHL3RPHF1IKBczQlBqIG3NwJZ1wms30p5HDR8A8PQOYMW4kD0IaSgVUqCt5/HYPXlxObKp53Tsj3CwY1r3MSUEu/DIjeVbgfHCbPzfVYmQSs306yq56MSO1ZFhvnXg6AZfQHs+OxUq+YnygF7azY75pY76unSYwL+RmKIVQRuwGEc0E+eenGpiaVohePo2nPPtELKmz9KaYnltGBg4UXQhAzSHKqL39+m3JN9TqgulOt8puNxKLhdUvsLWo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef65695-12db-4aa6-29f0-08dcb62dd310
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 15:38:31.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CFwcQJyJmPeO/xgqrlU/72WOBwd41B79Psd6HG3hGmwRuCJi1JBqeoKsqMylmzfjipJtzOYE6u4H6YxszFNuJyUoNXJS0RpwNxaTaN9s1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060109
X-Proofpoint-GUID: jmudbBzmFlahwhANMCugt_EHBvHxjmUK
X-Proofpoint-ORIG-GUID: jmudbBzmFlahwhANMCugt_EHBvHxjmUK

From: Vegard Nossum <vegard.nossum@oracle.com>

This adds some basic self-testing infrastructure for RDS-TCP.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 Documentation/dev-tools/gcov.rst           |  11 +
 MAINTAINERS                                |   1 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/net/rds/Makefile   |  12 +
 tools/testing/selftests/net/rds/README.txt |  41 ++++
 tools/testing/selftests/net/rds/config.sh  |  53 +++++
 tools/testing/selftests/net/rds/run.sh     | 224 ++++++++++++++++++
 tools/testing/selftests/net/rds/test.py    | 262 +++++++++++++++++++++
 8 files changed, 605 insertions(+)

diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
index 5fce2b06f229..dbd26b02ff3c 100644
--- a/Documentation/dev-tools/gcov.rst
+++ b/Documentation/dev-tools/gcov.rst
@@ -75,6 +75,17 @@ Only files which are linked to the main kernel image or are compiled as
 kernel modules are supported by this mechanism.
 
 
+Module specific configs
+-----------------------
+
+Gcov kernel configs for specific modules are described below:
+
+CONFIG_GCOV_PROFILE_RDS:
+        Enables GCOV profiling on RDS for checking which functions or
+        lines are executed. This config is used by the rds selftest to
+        generate coverage reports. If left unset the report is omitted.
+
+
 Files
 -----
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..8e0324b964f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19195,6 +19195,7 @@ S:	Supported
 W:	https://oss.oracle.com/projects/rds/
 F:	Documentation/networking/rds.rst
 F:	net/rds/
+F:	tools/testing/selftests/net/rds/
 
 RDT - RESOURCE ALLOCATION
 M:	Fenghua Yu <fenghua.yu@intel.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc8fe9e8f7f2..a5f1c0c27dff 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -68,6 +68,7 @@ TARGETS += net/mptcp
 TARGETS += net/openvswitch
 TARGETS += net/tcp_ao
 TARGETS += net/netfilter
+TARGETS += net/rds
 TARGETS += nsfs
 TARGETS += perf_events
 TARGETS += pidfd
diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
new file mode 100644
index 000000000000..da9714bc7aad
--- /dev/null
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+all:
+	@echo mk_build_dir="$(shell pwd)" > include.sh
+
+TEST_PROGS := run.sh \
+	include.sh \
+	test.py
+
+EXTRA_CLEAN := /tmp/rds_logs
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
new file mode 100644
index 000000000000..cbde2951ab13
--- /dev/null
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -0,0 +1,41 @@
+RDS self-tests
+==============
+
+These scripts provide a coverage test for RDS-TCP by creating two
+network namespaces and running rds packets between them. A loopback
+network is provisioned with optional probability of packet loss or
+corruption. A workload of 50000 hashes, each 64 characters in size,
+are passed over an RDS socket on this test network. A passing test means
+the RDS-TCP stack was able to recover properly.  The provided config.sh
+can be used to compile the kernel with the necessary gcov options.  The
+kernel may optionally be configured to omit the coverage report as well.
+
+USAGE:
+	run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]
+	       [-u packet_duplcate]
+
+OPTIONS:
+	-d	Log directory.  Defaults to tools/testing/selftests/net/rds/rds_logs
+
+	-l	Simulates a percentage of packet loss
+
+	-c	Simulates a percentage of packet corruption
+
+	-u	Simulates a percentage of packet duplication.
+
+EXAMPLE:
+
+    # Create a suitable gcov enabled .config
+    tools/testing/selftests/net/rds/config.sh -g
+
+    # Alternatly create a gcov disabled .config
+    tools/testing/selftests/net/rds/config.sh
+
+    # build the kernel
+    vng --build  --config tools/testing/selftests/net/config
+
+    # launch the tests in a VM
+    vng -v --rwdir ./ --run . --user root --cpus 4 -- \
+        "export PYTHONPATH=tools/testing/selftests/net/; tools/testing/selftests/net/rds/run.sh"
+
+An HTML coverage report will be output in tools/testing/selftests/net/rds/rds_logs/coverage/.
diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
new file mode 100755
index 000000000000..791c8dbe1095
--- /dev/null
+++ b/tools/testing/selftests/net/rds/config.sh
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -u
+set -x
+
+unset KBUILD_OUTPUT
+
+GENERATE_GCOV_REPORT=0
+while getopts "g" opt; do
+  case ${opt} in
+    g)
+      GENERATE_GCOV_REPORT=1
+      ;;
+    :)
+      echo "USAGE: config.sh [-g]"
+      exit 1
+      ;;
+    ?)
+      echo "Invalid option: -${OPTARG}."
+      exit 1
+      ;;
+  esac
+done
+
+CONF_FILE="tools/testing/selftests/net/config"
+
+# no modules
+scripts/config --file "$CONF_FILE" --disable CONFIG_MODULES
+
+# enable RDS
+scripts/config --file "$CONF_FILE" --enable CONFIG_RDS
+scripts/config --file "$CONF_FILE" --enable CONFIG_RDS_TCP
+
+if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
+	# instrument RDS and only RDS
+	scripts/config --file "$CONF_FILE" --enable CONFIG_GCOV_KERNEL
+	scripts/config --file "$CONF_FILE" --disable GCOV_PROFILE_ALL
+	scripts/config --file "$CONF_FILE" --enable GCOV_PROFILE_RDS
+else
+	scripts/config --file "$CONF_FILE" --disable CONFIG_GCOV_KERNEL
+	scripts/config --file "$CONF_FILE" --disable GCOV_PROFILE_ALL
+	scripts/config --file "$CONF_FILE" --disable GCOV_PROFILE_RDS
+fi
+
+# need network namespaces to run tests with veth network interfaces
+scripts/config --file "$CONF_FILE" --enable CONFIG_NET_NS
+scripts/config --file "$CONF_FILE" --enable CONFIG_VETH
+
+# simulate packet loss
+scripts/config --file "$CONF_FILE" --enable CONFIG_NET_SCH_NETEM
+
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
new file mode 100755
index 000000000000..8aee244f582a
--- /dev/null
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -0,0 +1,224 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -u
+
+unset KBUILD_OUTPUT
+
+current_dir="$(realpath "$(dirname "$0")")"
+build_dir="$current_dir"
+
+build_include="$current_dir/include.sh"
+if test -f "$build_include"; then
+	# this include will define "$mk_build_dir" as the location the test was
+	# built.  We will need this if the tests are installed in a location
+	# other than the kernel source
+
+	source "$build_include"
+	build_dir="$mk_build_dir"
+fi
+
+# This test requires kernel source and the *.gcda data therein
+# Locate the top level of the kernel source, and the net/rds
+# subfolder with the appropriate *.gcno object files
+ksrc_dir="$(realpath "$build_dir"/../../../../../)"
+kconfig="$ksrc_dir/.config"
+obj_dir="$ksrc_dir/net/rds"
+
+GCOV_CMD=gcov
+
+#check to see if the host has the required packages to generate a gcov report
+check_gcov_env()
+{
+	if ! which "$GCOV_CMD" > /dev/null 2>&1; then
+		echo "Warning: Could not find gcov. "
+		GENERATE_GCOV_REPORT=0
+		return
+	fi
+
+	# the gcov version must match the gcc version
+	GCC_VER=$(gcc -dumpfullversion)
+	GCOV_VER=$($GCOV_CMD -v | grep gcov | awk '{print $3}'| awk 'BEGIN {FS="-"}{print $1}')
+	if [ "$GCOV_VER" != "$GCC_VER" ]; then
+		#attempt to find a matching gcov version
+		GCOV_CMD=gcov-$(gcc -dumpversion)
+
+		if ! which "$GCOV_CMD" > /dev/null 2>&1; then
+			echo "Warning: Could not find an appropriate gcov installation. \
+				gcov version must match gcc version"
+			GENERATE_GCOV_REPORT=0
+			return
+		fi
+
+		#recheck version number of found gcov executable
+		GCOV_VER=$($GCOV_CMD -v | grep gcov | awk '{print $3}'| \
+			awk 'BEGIN {FS="-"}{print $1}')
+		if [ "$GCOV_VER" != "$GCC_VER" ]; then
+			echo "Warning: Could not find an appropriate gcov installation. \
+				gcov version must match gcc version"
+			GENERATE_GCOV_REPORT=0
+		else
+			echo "Warning: Mismatched gcc and gcov detected.  Using $GCOV_CMD"
+		fi
+	fi
+}
+
+# Check to see if the kconfig has the required configs to generate a coverage report
+check_gcov_conf()
+{
+	if ! grep -x "CONFIG_GCOV_PROFILE_RDS=y" "$kconfig" > /dev/null 2>&1; then
+		echo "INFO: CONFIG_GCOV_PROFILE_RDS should be enabled for coverage reports"
+		GENERATE_GCOV_REPORT=0
+	fi
+	if ! grep -x "CONFIG_GCOV_KERNEL=y" "$kconfig" > /dev/null 2>&1; then
+		echo "INFO: CONFIG_GCOV_KERNEL should be enabled for coverage reports"
+		GENERATE_GCOV_REPORT=0
+	fi
+	if grep -x "CONFIG_GCOV_PROFILE_ALL=y" "$kconfig" > /dev/null 2>&1; then
+		echo "INFO: CONFIG_GCOV_PROFILE_ALL should be disabled for coverage reports"
+		GENERATE_GCOV_REPORT=0
+	fi
+
+	if [ "$GENERATE_GCOV_REPORT" -eq 0 ]; then
+		echo "To enable gcov reports, please run "\
+			"\"tools/testing/selftests/net/rds/config.sh -g\" and rebuild the kernel"
+	else
+		# if we have the required kernel configs, proceed to check the environment to
+		# ensure we have the required gcov packages
+		check_gcov_env
+	fi
+}
+
+# Kselftest framework requirement - SKIP code is 4.
+check_conf_enabled() {
+	if ! grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
+		echo "selftests: [SKIP] This test requires $1 enabled"
+		echo "Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel"
+		exit 4
+	fi
+}
+check_conf_disabled() {
+	if grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
+		echo "selftests: [SKIP] This test requires $1 disabled"
+		echo "Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel"
+		exit 4
+	fi
+}
+check_conf() {
+	check_conf_enabled CONFIG_NET_SCH_NETEM
+	check_conf_enabled CONFIG_VETH
+	check_conf_enabled CONFIG_NET_NS
+	check_conf_enabled CONFIG_RDS_TCP
+	check_conf_enabled CONFIG_RDS
+	check_conf_disabled CONFIG_MODULES
+}
+
+check_env()
+{
+	if ! test -d "$obj_dir"; then
+		echo "selftests: [SKIP] This test requires a kernel source tree"
+		exit 4
+	fi
+	if ! test -e "$kconfig"; then
+		echo "selftests: [SKIP] This test requires a configured kernel source tree"
+		exit 4
+	fi
+	if ! which strace > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without strace"
+		exit 4
+	fi
+	if ! which tcpdump > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without tcpdump"
+		exit 4
+	fi
+
+	if ! which python3 > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without python3"
+		exit 4
+	fi
+
+	python_major=$(python3 -c "import sys; print(sys.version_info[0])")
+	python_minor=$(python3 -c "import sys; print(sys.version_info[1])")
+	if [[ python_major -lt 3 || ( python_major -eq 3 && python_minor -lt 9 ) ]] ; then
+		echo "selftests: [SKIP] Could not run test without at least python3.9"
+		python3 -V
+		exit 4
+	fi
+}
+
+LOG_DIR="$current_dir"/rds_logs
+PLOSS=0
+PCORRUPT=0
+PDUP=0
+GENERATE_GCOV_REPORT=1
+while getopts "d:l:c:u:" opt; do
+  case ${opt} in
+    d)
+      LOG_DIR=${OPTARG}
+      ;;
+    l)
+      PLOSS=${OPTARG}
+      ;;
+    c)
+      PCORRUPT=${OPTARG}
+      ;;
+    u)
+      PDUP=${OPTARG}
+      ;;
+    :)
+      echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
+           "[-u packet_duplcate] [-g]"
+      exit 1
+      ;;
+    ?)
+      echo "Invalid option: -${OPTARG}."
+      exit 1
+      ;;
+  esac
+done
+
+
+check_env
+check_conf
+check_gcov_conf
+
+
+rm -fr "$LOG_DIR"
+TRACE_FILE="${LOG_DIR}/rds-strace.txt"
+COVR_DIR="${LOG_DIR}/coverage/"
+mkdir -p  "$LOG_DIR"
+mkdir -p "$COVR_DIR"
+
+set +e
+echo running RDS tests...
+echo Traces will be logged to "$TRACE_FILE"
+rm -f "$TRACE_FILE"
+strace -T -tt -o "$TRACE_FILE" python3 "$(dirname "$0")/test.py" --timeout 400 -d "$LOG_DIR" \
+       -l "$PLOSS" -c "$PCORRUPT" -u "$PDUP"
+
+test_rc=$?
+dmesg > "${LOG_DIR}/dmesg.out"
+
+if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
+       echo saving coverage data...
+       (set +x; cd /sys/kernel/debug/gcov; find ./* -name '*.gcda' | \
+       while read -r f
+       do
+               cat < "/sys/kernel/debug/gcov/$f" > "/$f"
+       done)
+
+       echo running gcovr...
+       gcovr -s --html-details --gcov-executable "$GCOV_CMD" --gcov-ignore-parse-errors \
+             -o "${COVR_DIR}/gcovr" "${ksrc_dir}/net/rds/"
+else
+       echo "Coverage report will be skipped"
+fi
+
+if [ "$test_rc" -eq 0 ]; then
+	echo "PASS: Test completed successfully"
+else
+	echo "FAIL: Test failed"
+fi
+
+exit "$test_rc"
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
new file mode 100644
index 000000000000..e6bb109bcead
--- /dev/null
+++ b/tools/testing/selftests/net/rds/test.py
@@ -0,0 +1,262 @@
+#! /usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import argparse
+import ctypes
+import errno
+import hashlib
+import os
+import select
+import signal
+import socket
+import subprocess
+import sys
+import atexit
+from pwd import getpwuid
+from os import stat
+from lib.py import ip
+
+
+libc = ctypes.cdll.LoadLibrary('libc.so.6')
+setns = libc.setns
+
+net0 = 'net0'
+net1 = 'net1'
+
+veth0 = 'veth0'
+veth1 = 'veth1'
+
+# Helper function for creating a socket inside a network namespace.
+# We need this because otherwise RDS will detect that the two TCP
+# sockets are on the same interface and use the loop transport instead
+# of the TCP transport.
+def netns_socket(netns, *args):
+    u0, u1 = socket.socketpair(socket.AF_UNIX, socket.SOCK_SEQPACKET)
+
+    child = os.fork()
+    if child == 0:
+        # change network namespace
+        with open(f'/var/run/netns/{netns}') as f:
+            try:
+                ret = setns(f.fileno(), 0)
+            except IOError as e:
+                print(e.errno)
+                print(e)
+
+        # create socket in target namespace
+        s = socket.socket(*args)
+
+        # send resulting socket to parent
+        socket.send_fds(u0, [], [s.fileno()])
+
+        sys.exit(0)
+
+    # receive socket from child
+    _, s, _, _ = socket.recv_fds(u1, 0, 1)
+    os.waitpid(child, 0)
+    u0.close()
+    u1.close()
+    return socket.fromfd(s[0], *args)
+
+def signal_handler(sig, frame):
+    print('Test timed out')
+    sys.exit(1)
+
+#Parse out command line arguments.  We take an optional
+# timeout parameter and an optional log output folder
+parser = argparse.ArgumentParser(description="init script args",
+                  formatter_class=argparse.ArgumentDefaultsHelpFormatter)
+parser.add_argument("-d", "--logdir", action="store",
+                    help="directory to store logs", default="/tmp")
+parser.add_argument('--timeout', help="timeout to terminate hung test",
+                    type=int, default=0)
+parser.add_argument('-l', '--loss', help="Simulate tcp packet loss",
+                    type=int, default=0)
+parser.add_argument('-c', '--corruption', help="Simulate tcp packet corruption",
+                    type=int, default=0)
+parser.add_argument('-u', '--duplicate', help="Simulate tcp packet duplication",
+                    type=int, default=0)
+args = parser.parse_args()
+logdir=args.logdir
+packet_loss=str(args.loss)+'%'
+packet_corruption=str(args.corruption)+'%'
+packet_duplicate=str(args.duplicate)+'%'
+
+ip(f"netns add {net0}")
+ip(f"netns add {net1}")
+ip(f"link add type veth")
+
+addrs = [
+    # we technically don't need different port numbers, but this will
+    # help identify traffic in the network analyzer
+    ('10.0.0.1', 10000),
+    ('10.0.0.2', 20000),
+]
+
+# move interfaces to separate namespaces so they can no longer be
+# bound directly; this prevents rds from switching over from the tcp
+# transport to the loop transport.
+ip(f"link set {veth0} netns {net0} up")
+ip(f"link set {veth1} netns {net1} up")
+
+
+
+# add addresses
+ip(f"-n {net0} addr add {addrs[0][0]}/32 dev {veth0}")
+ip(f"-n {net1} addr add {addrs[1][0]}/32 dev {veth1}")
+
+# add routes
+ip(f"-n {net0} route add {addrs[1][0]}/32 dev {veth0}")
+ip(f"-n {net1} route add {addrs[0][0]}/32 dev {veth1}")
+
+# sanity check that our two interfaces/addresses are correctly set up
+# and communicating by doing a single ping
+ip(f"netns exec {net0} ping -c 1 {addrs[1][0]}")
+
+# Start a packet capture on each network
+for net in [net0, net1]:
+    tcpdump_pid = os.fork()
+    if tcpdump_pid == 0:
+        pcap = logdir+'/'+net+'.pcap'
+        subprocess.check_call(['touch', pcap])
+        user = getpwuid(stat(pcap).st_uid).pw_name
+        ip(f"netns exec {net} /usr/sbin/tcpdump -Z {user} -i any -w {pcap}")
+        sys.exit(0)
+
+# simulate packet loss, duplication and corruption
+for net, iface in [(net0, veth0), (net1, veth1)]:
+    ip(f"netns exec {net} /usr/sbin/tc qdisc add dev {iface} root netem  \
+         corrupt {packet_corruption} loss {packet_loss} duplicate  \
+         {packet_duplicate}")
+
+# add a timeout
+if args.timeout > 0:
+    signal.alarm(args.timeout)
+    signal.signal(signal.SIGALRM, signal_handler)
+
+sockets = [
+    netns_socket(net0, socket.AF_RDS, socket.SOCK_SEQPACKET),
+    netns_socket(net1, socket.AF_RDS, socket.SOCK_SEQPACKET),
+]
+
+for s, addr in zip(sockets, addrs):
+    s.bind(addr)
+    s.setblocking(0)
+
+fileno_to_socket = {
+    s.fileno(): s for s in sockets
+}
+
+addr_to_socket = {
+    addr: s for addr, s in zip(addrs, sockets)
+}
+
+socket_to_addr = {
+    s: addr for addr, s in zip(addrs, sockets)
+}
+
+send_hashes = {}
+recv_hashes = {}
+
+ep = select.epoll()
+
+for s in sockets:
+    ep.register(s, select.EPOLLRDNORM)
+
+n = 50000
+nr_send = 0
+nr_recv = 0
+
+while nr_send < n:
+    # Send as much as we can without blocking
+    print("sending...", nr_send, nr_recv)
+    while nr_send < n:
+        send_data = hashlib.sha256(
+            f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
+
+        # pseudo-random send/receive pattern
+        sender = sockets[nr_send % 2]
+        receiver = sockets[1 - (nr_send % 3) % 2]
+
+        try:
+            sender.sendto(send_data, socket_to_addr[receiver])
+            send_hashes.setdefault((sender.fileno(), receiver.fileno()),
+                    hashlib.sha256()).update(f'<{send_data}>'.encode('utf-8'))
+            nr_send = nr_send + 1
+        except BlockingIOError as e:
+            break
+        except OSError as e:
+            if e.errno in [errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE]:
+                break
+            raise
+
+    # Receive as much as we can without blocking
+    print("receiving...", nr_send, nr_recv)
+    while nr_recv < nr_send:
+        for fileno, eventmask in ep.poll():
+            receiver = fileno_to_socket[fileno]
+
+            if eventmask & select.EPOLLRDNORM:
+                while True:
+                    try:
+                        recv_data, address = receiver.recvfrom(1024)
+                        sender = addr_to_socket[address]
+                        recv_hashes.setdefault((sender.fileno(),
+                            receiver.fileno()), hashlib.sha256()).update(
+                                    f'<{recv_data}>'.encode('utf-8'))
+                        nr_recv = nr_recv + 1
+                    except BlockingIOError as e:
+                        break
+
+    # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
+    for net in [net0, net1]:
+        ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_rcvbuf=10000")
+        ip(f"netns exec {net} /usr/sbin/sysctl net.rds.tcp.rds_tcp_sndbuf=10000")
+
+print("done", nr_send, nr_recv)
+
+# the Python socket module doesn't know these
+RDS_INFO_FIRST = 10000
+RDS_INFO_LAST = 10017
+
+nr_success = 0
+nr_error = 0
+
+for s in sockets:
+    for optname in range(RDS_INFO_FIRST, RDS_INFO_LAST + 1):
+        # Sigh, the Python socket module doesn't allow us to pass
+        # buffer lengths greater than 1024 for some reason. RDS
+        # wants multiple pages.
+        try:
+            s.getsockopt(socket.SOL_RDS, optname, 1024)
+            nr_success = nr_success + 1
+        except OSError as e:
+            nr_error = nr_error + 1
+            if e.errno == errno.ENOSPC:
+                # ignore
+                pass
+
+print(f"getsockopt(): {nr_success}/{nr_error}")
+
+print("Stopping network packet captures")
+subprocess.check_call(['killall', '-q', 'tcpdump'])
+
+# We're done sending and receiving stuff, now let's check if what
+# we received is what we sent.
+for (sender, receiver), send_hash in send_hashes.items():
+    recv_hash = recv_hashes.get((sender, receiver))
+
+    if recv_hash is None:
+        print("FAIL: No data received")
+        sys.exit(1)
+
+    if send_hash.hexdigest() != recv_hash.hexdigest():
+        print("FAIL: Send/recv mismatch")
+        print("hash expected:", send_hash.hexdigest())
+        print("hash received:", recv_hash.hexdigest())
+        sys.exit(1)
+
+    print(f"{sender}/{receiver}: ok")
+
+print("Success")
+sys.exit(0)
-- 
2.25.1


