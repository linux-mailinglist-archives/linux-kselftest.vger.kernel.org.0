Return-Path: <linux-kselftest+bounces-35616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E184AAE409F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C111896E85
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A5248F7C;
	Mon, 23 Jun 2025 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R2HLCVB6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n2vI/Hf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86024887F;
	Mon, 23 Jun 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682147; cv=fail; b=nB/Wy2RX0TLAm5lc1sfcmF0hpvkU1jJReb3WaipbtMmRk0cBKSJczdgZF24SD00s5CHM8X2SZDgS0XBm6HmHuBRQC42/Q+pFPpXbKpier9braJqlA9wZLCM/SGUC/gp+fn8fPhBo0pGYihm6v8hOcE8bEp9vVuUY3Fq5vBCBXNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682147; c=relaxed/simple;
	bh=aZsjlMjrkYkRhxOFbuo+1hb6MBLLNtMo6Q1SGs4ovjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WIj82UEAITiq4LuYSxfFAxSs7jCXxVkGNTYMa80N4D5EZZ+ckRHdfybx3DDh8ST2NkrKD8eIBhf7+xbJzEHh9g0CJhevBou2WJA1xKpGSSJSf6bQvkBrHEHwEhUvXMd0SPjUyyyyK6q4u8FyIglpezKEKArcjD4B840YJe1it8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R2HLCVB6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n2vI/Hf+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCMkG1014896;
	Mon, 23 Jun 2025 12:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pOGWuqp1lUY36dPFEj
	9zM1wk1R1WY0YCkXpL9Fmc/Nk=; b=R2HLCVB6DrjxTYopzOzW6QSG5ReggpI9OL
	+r0L0yKPiPhILRv7gSDBETBBVPZeh0osFW/04PjJfSiSmL5Roc7JJVkuEgLJsHAN
	nUsoZnPizAM8yRDYtA9POq0K/6CVrlH6NVJ0ixnRHpZCV5HtfFoXRXuL1G3sW4jO
	koVfr/i7lQ96Fg3hhyGRXmDR9heb0anrdXi3pCEqM+t5tpgiBjlszPVjvkp63AhQ
	xfBvgVoqBOyAhvidlgrBNUL6g/q+gRwzizhycO4f0ImVa/mXbqbkatogiDg6gBBg
	XFtKcqfTOJmBlLTB8HvPxaquQ0ORJcP+NUGTK43z90Ao4dA3+M0w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt19fy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 12:35:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBtGp0009086;
	Mon, 23 Jun 2025 12:35:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq29e2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 12:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOuumfI8p52tK7TY7ns6oSvD6XQCu9Pggp7JDw2dGi+j5XJyr1EwgMLNtd3tjPdyzEYSKjVduylht2vUzXCxqfwlMWLvhs29dWN/vG8OKxwkrnQiLA4QDQXjTaIiKEpxtR7qWivHqOUs82ROsB9tn2lBCugg1fRnZJMpSV0MtGTyVczNJeqctTfycaREhBUgCEb01+j2iKxPHHJDvOOb/+xg63YvgZzs3I++oTIdBJg9ufEvBLopnQXu9zZU8u5yfJXld+4MFsOSC9vcu769F4H97rMpEpJX1mhv0j2ZTGS2aX0Q3uOKyjbD5CnzNX7Wr5cJ6gz05BU8tZbwCoLgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOGWuqp1lUY36dPFEj9zM1wk1R1WY0YCkXpL9Fmc/Nk=;
 b=ne9f10B23OsR2BXwRCbqbE1g9vBZoXpMhAe0ztj6iLxFMgC8y72r4YuiOMT5vwIsh0BIcC/nyDNbZ1yEZvfon93Nzjx/R9Nf+16aIdjipdKXFTauG2fruhUJ/tN/C90cEYghu8ndd6A6p2dCTm9BFZq9ah1GwjNpnMSbkNXuDpYRjU+fSAQc4MWTPcy9/Yxng/QnUweziSggI/HNdRXB/ide4deubHw+Zaxj/3EZYJcUsQuqgOw74zvvFok6meNBKjQjwN0uF21P3R+tyGVidLsXOMbcD37XMb0huCi/4iQeD02dYC8+n3cc1/0wtBxysgdMyNDRE6YcL3MzD+nMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOGWuqp1lUY36dPFEj9zM1wk1R1WY0YCkXpL9Fmc/Nk=;
 b=n2vI/Hf+dPpwjmkJ0oEdYX3hlCXaksOnqdA+/OWz2udmAzfLU7cHoJRfDiFDhvOwoYumL/DnlAJ0lpJ/UzIYJC73NzC31oH1cONo+jc9Up6VN0wUES2kq+2yYvEeFKYw5erjUAJS+kUhrd9KEekXX4DWkCNXYuUA59/j9rqa/xY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4366.namprd10.prod.outlook.com (2603:10b6:208:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 12:35:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:35:13 +0000
Date: Mon, 23 Jun 2025 13:35:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, zijing.zhang@proton.me,
        ryncsn@gmail.com, p1ucky0923@gmail.com, gkwang@linx-info.com,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] selftests/mm: add test for (BATCH_PROCESS)MADV_DONTNEED
Message-ID: <8fb737cc-ba83-4949-b4fb-2a2e1af0967a@lucifer.local>
References: <20250621133003.4733-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621133003.4733-1-lianux.mm@gmail.com>
X-ClientProxiedBy: LO2P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 496e7700-fa2c-4230-e029-08ddb252664c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I18j6xm2GGxH3DFTaKYxwGFvx4iOkT2Pz/9zrTv6PF2cxaqW3DKZVf58g/em?=
 =?us-ascii?Q?IMHPl0QhkIwLTkOjp2DDyu1CG7pe4zUQm+4sHmPIRaeLBliBlJbC9HFKsGVX?=
 =?us-ascii?Q?9s0/f4JLKhsZzC7kJtRXWaW4ONpjKqYhPA9fO2cvq17+2plCIis1UbquLY9U?=
 =?us-ascii?Q?86on6YtBro1cciIqLAfkaCdXJ1f1gyOf1XG07iNhuJY6LeWsjQ6B60h0HzfU?=
 =?us-ascii?Q?OkekoUK2J23AnS5b2DbEgRpWiJEEsi8Q6dngyr242Nq4/sBJqjvg7+uolmLJ?=
 =?us-ascii?Q?5f4QpYmkzKfUrYpdO/5zdDSJNIaYI1NbDBEhbqqavsFhe2DFYPKe7IXh4zd+?=
 =?us-ascii?Q?WSY0XdEc1iniiv3oj1dW2ihXoESpozKFrL+wJHvG1LXvJmt/2t1FWeXDwNn8?=
 =?us-ascii?Q?Yu+xiXob6RhHVj2lIoWJBp9YurddY8Mv0xg6/WDR4YYHHZAgLEVezdQCvBjn?=
 =?us-ascii?Q?T90i7AMfC2uhxibJtz33WfmegRWrdvXfrS9YBKK/HX92zNJgdUBejfP2uUe2?=
 =?us-ascii?Q?vtnrPLv4wwzcmgVWRo9GOX1CYU3gFdRF0MPw/NDhZLisQ4vYQoFEqsymovur?=
 =?us-ascii?Q?eSmtdLZZRX75xe/VWQmXNARRD/71UhCkvr3HosRTDocP0MLGGo+JJl6y8ZjH?=
 =?us-ascii?Q?gHXfMUk79NJLElg0qsqNihEJKQHp0go+YyLlGmeds7jGVF1HkRvmxsbY5124?=
 =?us-ascii?Q?wleR4uZwH0d8SL5SLUiVquZPdZeQf0AA3NsSC+emlQn9IJH2kW/grI8mwCZ5?=
 =?us-ascii?Q?4legnuSJc4dtIonev94G8qzG02tJquQk4Wok3id272F3gJ/oIelUn9qDoCW/?=
 =?us-ascii?Q?N2c4WEF/YQ76oFv6HvDJgn4t+Js1sj9aGb+PbcG29KVK/3B75ZF9WnEahc7f?=
 =?us-ascii?Q?xogESGKtYfsGAjplGc47TL/0SjKDc8/UG+xdMOltsDw+WbFHsWchN/ssYTXH?=
 =?us-ascii?Q?NPIX/G+FD0FtH2H3aen6R0cdMUXnHwim2alvJIVuNXCbpmRzQ7Lf+/JCMDdf?=
 =?us-ascii?Q?AnwqzIqdsVZCIGLpw8hZpbuPFyKBBiFT1eCyjrM9h7DahQDC+NYEEHbgkxYW?=
 =?us-ascii?Q?u6g/hRVwT2RH5DJcYKEQIIWftSckkHhuxlfYs9r8DlVu5bfRSTobdTORUlGz?=
 =?us-ascii?Q?YDOxgQLmstEZ4qsiVm0SNvv7CK/WREVppRQEdxQqQcEKjU/8lx3wkVgTnQ3U?=
 =?us-ascii?Q?OZN8AitTyDmCqPctRCBr5mFzEovpwK0OcF67abSE5V/XNwcctOpHJ0n8k6UQ?=
 =?us-ascii?Q?Woe9DUju+2LcGlOYbFzSZoWJfC/A8pFY9Y5UDLaI9oQujRfgVQxsA7CTioUN?=
 =?us-ascii?Q?O0VJolGtpGyYcu96HifA4Nq86k9ow2LcWJj2+ndu7tuHIBZKvzzIBsCO319u?=
 =?us-ascii?Q?fcXRVzSOA5vPMvcHEoBpFM5ivjfV0MvLKXSRWRfBK9e4S4fF6PraYMkParYq?=
 =?us-ascii?Q?k8pEUD2qEvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u4aH76hsMAuGv5UWikW/ogu1vIRBBBR2MVQtAeNRDyLasaSaBD8c/4cn7Sop?=
 =?us-ascii?Q?uRKhkKJsa31qszGhKxYOWs+8oPtEteSDNzLMtTWiq47ZkJmrJd9PeWlVa7gh?=
 =?us-ascii?Q?joSxbtuqPBAV2RrxGmAl949HhW36ZXYUdjpftmW+8P8PqGrNSwP9fESHJUbn?=
 =?us-ascii?Q?cJS/QXf4Gz9XrhMbkin45Lp5mOK3hatbjAHjspf7Nw7jPYDYH/RLof4gJRWv?=
 =?us-ascii?Q?0gSNT7SVAnKt3ARQ6cKOxVIqVkF2Xhn+KF/1wRO2vObDkb0wylKHih4WAN0T?=
 =?us-ascii?Q?01Sp/wqIEsWSV1gWeUTmNCBBGPmcgCfdluuK8K+Hn2JKhrrHemcDzlPjMzWS?=
 =?us-ascii?Q?Vn8uQ6+UNGET/B2BHYgXjdoDqlITsKPDU3kyf44rYbvd3oFJxKcTFWEUbQuk?=
 =?us-ascii?Q?SXZg6Uk6WIIOxsKP+QNhGcO94bzOV5wBH2MOEWWTBqZNq+9zguarO/xzGeUJ?=
 =?us-ascii?Q?19TGoGrphM7F+ZT5s1lxhI8NhbcNK40YFaU9mHsoiZJXDMSOR8AiPzH4rtwt?=
 =?us-ascii?Q?K5jBr8GA89ZccUhV0cjgMGEC5Ex3uMvxzWqGy8qqs5EGMq4aqJ8/crQGFr1e?=
 =?us-ascii?Q?7rQNyImid0mOCoO2dtWNYQyJpzYgAGWnzXXnKb7yI5W/ydwCzb5eoyDZQlS6?=
 =?us-ascii?Q?qnMc7tEYSQVu7Qp6X4yIi4gIs3mcUyGcSIztT0LlYGFuNP2BaWe7j4sRJETJ?=
 =?us-ascii?Q?Vc6nQi3TkHtfNgUCswwUSfEzcJgvo9SzT1HWFcWwyM98Mti8Tr7rMkDZHrig?=
 =?us-ascii?Q?M607g/VFQNugvUa/18dK1R4Tm6+AwWRtWV+/nO9V1adZGD+vyeAnSFxmSOiL?=
 =?us-ascii?Q?RnmxNgkrZiSHHUcuuc1MwH2xQaMqqfbEwz4KZj5oSTRD5EslrU5LX3FZx+o4?=
 =?us-ascii?Q?vtUh4NTva7ZmzuhCcka/8Myc+EEAAeszN0fm7uj1QMKncqAH7pFtZHHOFOeQ?=
 =?us-ascii?Q?uebNUToMprXwRnups4nylQTZJRSIwWvjWV3NxuoX5JeiZD3VdToHzB3NrTEz?=
 =?us-ascii?Q?qQlsJyOO1kgp2AbGhJg0GurS4HsdXVR0rzKCBiAzDkq7g1866+dsIyY0LbEN?=
 =?us-ascii?Q?IQT36VjokGUsuvNptdfOVxNiFOCkq5q2s1hPSpoKgS/BgXH5bcuA/ya1otfJ?=
 =?us-ascii?Q?eUj7DlusItyyj1jaXDl6TBtwFTasongdvaq1vKWm6BujoOMxJdm9Hm9uhUhj?=
 =?us-ascii?Q?prpOf/pNqRysKtHqC0zLYakY5glm6eUeSJ2ieJ/VzRfhYSSO+43WpuDpY5pG?=
 =?us-ascii?Q?OAIVWX6dkr1VUSS9vfdj1cOcLQy6YLQBGcqnmhBh3z1ft6fM0L5IPx1FH6RE?=
 =?us-ascii?Q?6gzfEkyJJ7sSQU+YTnCDiFHY/QKtvGKrd8/yCKbYqX+m6VmM+tvToRviX1gR?=
 =?us-ascii?Q?D7nUESQn/NroGAyojpnDB2ak/2EzrvO9Fnrr5BUowhABvW+W9sYL7k8LIZGx?=
 =?us-ascii?Q?7r4wm9PHa6ecPZq0MwlTPW9bIEwbiWbvMOIwoGTQgTMudxaXWuS+sgU5QGNX?=
 =?us-ascii?Q?jwAnRl8m2obkzFXDMEuDcm9DmguCBtTQ80tvyHyzcsxRTUbpFPA9wt8N+0Zy?=
 =?us-ascii?Q?g/6RndXqOfwuN14nyCaQ7tfYfKH2b+WkSJ3jAsZ80000rFLxRW3XdAs9xjFa?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tPcQviF2VB2+TQNa9EkEckPzLOSNTkqEHafzeqSnRXBdiyEcfM5YcSAuaEmMvzpojHe4Xyn4zdJHoLgFBb7UmtI6dZ2PIoIsIedGekTDN3bblEZguPEWs36hjNrV3OcNQuJ7UwsTVrjzK9K5RsTL1PpkKnwBrMcDfXRdON1s75s0p20ckPqT7TDOWcZngZKAkeFSSsWQ6eoKUL73jxH/qsYGUhBdpRKe5gB2X39tQ+L648sXnNC09j8O5Fx9T2ryT9u55f5NQ8jL7iO6Bd1zUYzZ+ZOukA+gjrmK7pW5MYHsaRR7SIbzhC/koLhcEs/swuka6QFMOkhz4raJUvBqBqi+4/1VlMLJNGQEvWOUl8VNsstja4JQYR3aM19+mJ1L4gb4HGcr2CjzXCnPQow64GH0C88QmMP0oJR+k5v7m3UQpixBVaR61m4YzrC8X8+u5HsPMYdYvk4Ck74tkyRNgLkgGKVHCvdoVAbOOAJ7xd1ikix7kgu4MneI9tjH4CSUtCDv/hKPFWVJb/22MEyBSApAQi347KB7sPTqE7eHluN2Hx9wZTT3UMi9AU9Mak08CF70t5sDVZ//nPqTbuM5K8s048Uz9Su2n0v/PsUGKcc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496e7700-fa2c-4230-e029-08ddb252664c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:35:13.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cvf2fW90c0V+M9gg7MiKtS993uCsuXIBWKJicFPRqPcFIIn3K1Tb4BqPvcuoqcsnZ0O5jURgiMQFdR2EHTZXdh+1ik55EaQASTsv9rBha0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230075
X-Proofpoint-GUID: IrQfNYqtecDfrTnKfLpmLaelCQdZRj5f
X-Proofpoint-ORIG-GUID: IrQfNYqtecDfrTnKfLpmLaelCQdZRj5f
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=68594a06 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=TcuTIuh_laexMcIzhigA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NSBTYWx0ZWRfXwVBlzCx7krfZ PfyKwNA15E9eOZOHdsMthR0jGlGfrKc4aNyPe17wgC8vMvVlUWKKkzffPPhfuN3vKMn/8IlB/0k SDCCY8ZXO6UQqe257SJEJ6ajOnYA6T+UoJR7Mx++02x8xHs8xxv+Jmrt/tUwS0AGtUr0F8Zraqu
 08OqxUkvnfVaKJHEsuOKJU2bdImkQZSGwIOnhC2C5JWxxhpf3ph0mraILZAyxZJnkCJ3ori0+TQ YbZvu0hQmzDKY7Is1UzcqQ97nD8xDkNZL6iOm79gPzz2F+xfpg8Q1bNVNh6T2iZeGXuI8LUdqS6 zjG/n7N57hB5AdrDVF/yM2Axa7BhlYt28XMKoEQRjaJbfL7uBABG5Bdqq6TOJzALZM5hNNz6foW
 mgMDT4u5zn22sHvSKiToA/qdMXNe5dvJKqHeEKmutH2ecLQi1rPPvmBmhql+oBoh/sMYpAjZ

+cc Liam, David, Vlastimil, Jann

(it might not be obvious from get_maintainers.pl but please cc
maintainers/reviewers of the thing you are adding a test for, thanks!)

Overall I'm not in favour of us taking this patch.

There are a number of issues with it (explained inline below), but those aside,
it seems to be:

- Checking whether a simple anon buffer of arbitrary size is zapped by
  MADV_DONTNEED.

- Printing out a dubious microbenchmark that seems to be mostly asserting that
  fewer sycalls are faster when using process_madvise() locally.

And I'm struggling to see the value of that.

The test is also slow and will slow down a test run for little benefit.

On Sat, Jun 21, 2025 at 09:30:03PM +0800, wang lian wrote:
> From: Lian Wang <lianux.mm@gmail.com>
>
> Let's add a simple test for MADV_DONTNEED and PROCESS_MADV_DONTNEED,

I'm not sure what PROCESS_MADV_DONTNEED is?

you mean process_madvise(..., MADV_DONTNEED, ...)?

> and inspired by SeongJae Park's test at GitHub[1] add batch test
> for PROCESS_MADV_DONTNEED,but for now it influence by workload and
> need add some race conditions test.We can add it later.
>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> References
> ==========
>
> [1] https://github.com/sjp38/eval_proc_madvise
>
> ---
>  tools/testing/selftests/mm/.gitignore      |   1 +
>  tools/testing/selftests/mm/Makefile        |   1 +
>  tools/testing/selftests/mm/madv_dontneed.c | 220 +++++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh  |   5 +
>  4 files changed, 227 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/madv_dontneed.c
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 824266982aa3..911f39d634be 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -25,6 +25,7 @@ pfnmap
>  protection_keys
>  protection_keys_32
>  protection_keys_64
> +madv_dontneed
>  madv_populate
>  uffd-stress
>  uffd-unit-tests
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index ae6f994d3add..2352252f3914 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -67,6 +67,7 @@ TEST_GEN_FILES += hugepage-mremap
>  TEST_GEN_FILES += hugepage-shm
>  TEST_GEN_FILES += hugepage-vmemmap
>  TEST_GEN_FILES += khugepaged
> +TEST_GEN_FILES += madv_dontneed
>  TEST_GEN_FILES += madv_populate
>  TEST_GEN_FILES += map_fixed_noreplace
>  TEST_GEN_FILES += map_hugetlb
> diff --git a/tools/testing/selftests/mm/madv_dontneed.c b/tools/testing/selftests/mm/madv_dontneed.c
> new file mode 100644
> index 000000000000..b88444da7f9e
> --- /dev/null
> +++ b/tools/testing/selftests/mm/madv_dontneed.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MADV_DONTNEED and PROCESS_MADV_DONTNEED tests
> + *
> + * Copyright (C) 2025, Linx Software Corp.
> + *
> + * Author(s): Lian Wang <lianux.mm@gmail.com>
> + */
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/mman.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include "vm_util.h"
> +#include <time.h>
> +
> +#include "../kselftest.h"
> +
> +/*
> + * For now, we're using 2 MiB of private anonymous memory for all tests.
> + */
> +#define SIZE (256 * 1024 * 1024)

This is 256 MB?

Also you don't need to do:

/*
 * foo bar baz bar foo
 */

Just do:

/* foo bar baz bar foo */

> +
> +static size_t pagesize;
> +
> +static void sense_support(void)
> +{
> +	char *addr;
> +	int ret;
> +
> +	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
> +		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);

This is incorrect, you need to specify -1 for fd for anon mappings, not zero.

Also the first parameter in mmap() is a pointer, use NULL.

> +	if (!addr)
> +		ksft_exit_fail_msg("mmap failed\n");

This is incorrect, you need to check for MAP_FAILED.

> +
> +	ret = madvise(addr, pagesize, MADV_DONTNEED);
> +	if (ret)
> +		ksft_exit_skip("MADV_DONTNEED is not available\n");

This is incorrect, you're testing for a current kernel, MADV_DONTNEED is very
definitely always available.

I'm guessing you've copy/pasted from madv_populate.c, which really shouldn't be
'sensing' if this option is available either - the tests are for the most recent
kernel, in which you know the behaviour is supported.

Anyway you should just drop this.

> +
> +	munmap(addr, pagesize);
> +}
> +
> +/*
> + * Read pagemap to check page is present in mermory
> + */
> +static bool is_page_present(void *addr)

This seems a flakey thing to test? While unlikely, a page might be swapped
out. So you will want to add a check for this also.

> +{
> +	uintptr_t vaddr = (uintptr_t)addr;
> +	uintptr_t offset = (vaddr / pagesize) * sizeof(uint64_t);
> +	ssize_t bytes_read;
> +	uint64_t entry;
> +	bool ret;
> +	int fd;
> +
> +	fd = open("/proc/self/pagemap", O_RDONLY);
> +	if (fd < 0) {
> +		ksft_exit_fail_msg("opening pagemap failed\n");
> +		ret = false;

Why are you doing stuff after ksft_exit_fail_msg()? As the name suggests, it
literally exits the whole process.

> +	}
> +
> +	if ((lseek(fd, offset, SEEK_SET)) == -1) {
> +		close(fd);
> +		ret = false;
> +	}
> +
> +	bytes_read = read(fd, &entry, sizeof(entry));
> +	close(fd);
> +
> +	if (bytes_read != sizeof(entry)) {
> +		perror("read failed");
> +		return false;
> +	}
> +
> +	if (entry & (1ULL << 63))

This is a 'magical number'. Please #define something like:

#define PAGEMAP_PRESENT_BIT (63)
#define PAGEMAP_PRESENT_MASK (1ULL << 63)

> +		ret = true;
> +
> +	return ret;
> +}
> +
> +/*
> + * test madvsise_dontneed

Useless comment.

> + */
> +static void test_madv_dontneed(void)
> +{
> +	unsigned long rss_anon_before, rss_anon_after;
> +	bool present, rss;
> +	char *addr;
> +	int ret;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);

Not sure why we need so much noise.

> +
> +	addr = mmap(0, SIZE, PROT_READ | PROT_WRITE,
> +		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);

Again this is incorrect - you need to set -1 for the fd, NULL for the address.

> +	if (!addr)
> +		ksft_exit_fail_msg("mmap failed\n");

This is wildly incorrect and means you will segfault the test, check for
MAP_FAILED.

> +
> +	memset(addr, 0x7A, SIZE);

I've said it elsewhere but I'm not sure you should write 256 megabytes of data
when you could write 65,536 to fault in memory.

Or even use MADV_POPULATE_READ/WRITE...?

> +
> +	rss_anon_before = rss_anon();
> +	if (!rss_anon_before)
> +		ksft_exit_fail_msg("No RssAnon is allocated before dontneed\n");

This seems copy/pasted from split_huge_page_test.c.

I mean I'm not sure it's really useful to assert that RSS goes down. Again, if
RSS doesn't go down we have bigger problems...

> +	ret = madvise(addr, SIZE, MADV_DONTNEED);
> +	ksft_test_result(!ret, "MADV_DONTNEED\n");
> +
> +	rss_anon_after = rss_anon();
> +	if (rss_anon_after < rss_anon_before)
> +		rss = true;
> +	ksft_test_result(rss, "MADV_DONTNEED rss is correct\n");

This is incorrect, rss is uninitialised here so you're reading uninitialised
memory unless your condition is met.

I'm not sure why you don't just pass in the condition... or use
kselftest_harness rather than do everything manually here.

> +
> +	for (size_t i = 0; i < SIZE; i += pagesize) {
> +		present = is_page_present(addr + i);

You're doing this in a super slow way, you're checking 256 MB's worth of memory
via /proc/pagemap, opening this every single time

> +		if (present) {
> +			ksft_print_msg("Page not zero at offset %zu\n",
> +				       (size_t)i);

I'm not sure what 'page not zero' means.

And also if this failed, you're going to spam like crazy. 256 * 1024 / 4 =
65,536 lines of output if somehow, in an imagined scenario where zapping no
longer works, this fails.

> +		}
> +	}
> +
> +	ksft_test_result(!present, "MADV_DONTNEED page is present\n");

Are you not duplicating test result here? So this function named test_xxx()
isn't actually testing 1 thing it's testing multiple things output as separate
test results...

kselftest_harness again would help you a lot.

> +	munmap(addr, SIZE);
> +}
> +
> +/*
> + * Measure performance of batched process_madvise vs madvise
> + */
> +static int measure_process_madvise_batching(int hint, int total_size,

I have no idea what you mean by 'hint'?

You're passing in MADV_DONTNEED, surely this should be 'behavior'?

> +					    int single_unit, int batch_size)

On my system this took a long time to run, and I have a powerful system. I just
don't think this is any way appropriate or suited to mm self tests, sorry.

At the very least it should be hugely sped up.

> +{
> +	struct iovec *vec = malloc(sizeof(*vec) * batch_size);
> +	struct timespec start, end;
> +	unsigned long elapsed_ns = 0;
> +	unsigned long nr_measures = 0;
> +	pid_t pid = getpid();
> +	char *buf;
> +	int pidfd;
> +
> +	pidfd = syscall(SYS_pidfd_open, pid, 0);
> +	if (pidfd == -1) {
> +		perror("pidfd_open fail");
> +		return -1;

Why -1? And this is just ignored by caller?

In any case you don't need to do any of this, just pass PIDFD_SELF, I went to
great pains to add this and have process_madvise() work locally so you don't
have to do this kind of thing :)

> +	}
> +
> +	buf = mmap(NULL, total_size, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

Hm strangely here you invoke mmap() correctly (+ test for failure correctly) but
not elsewhere?

I don't know why you get the pidfd first before doing this.

> +	if (buf == MAP_FAILED) {
> +		perror("mmap fail");

Are we good to just randomly perror() in test code? Not 100% sure that will
work?

> +		goto out;
> +	}
> +
> +	if (!vec) {
> +		perror("malloc vec failed");
> +		goto unmap_out;
> +	}

Why are you checking whether a malloc() failed a million years after
malloc()'ing?

> +
> +	while (elapsed_ns < 5UL * 1000 * 1000 * 1000) {

This is just horrible. Completely arbitrary and a magical number.

And making these tests run for 3 * 5 seconds to not assert anything but to just
print out some stats is not ok.

> +		memset(buf, 0x7A, total_size);

I don't know why you feel the need to memset() the whole thing each time? If the
point is faulting in maybe better to just fault in each page?

> +
> +		clock_gettime(CLOCK_MONOTONIC, &start);
> +
> +		for (int off = 0; off < total_size;
> +		     off += single_unit * batch_size) {
> +			for (int i = 0; i < batch_size; i++) {
> +				vec[i].iov_base = buf + off + i * single_unit;
> +				vec[i].iov_len = single_unit;
> +			}
> +			syscall(SYS_process_madvise, pidfd, vec, batch_size,
> +				hint, 0);

Yeah 'hint' here is awful as a name, it's actively misleading. You're not
'hinting' at a process_madvise() behaviour, you're specifying it.

Hint usually implies something like 'map this around <hint> address'.

> +		}
> +
> +		clock_gettime(CLOCK_MONOTONIC, &end);
> +		elapsed_ns += (end.tv_sec - start.tv_sec) * 1e9 +
> +			      (end.tv_nsec - start.tv_nsec);

> +		nr_measures++;
> +	}
> +
> +	ksft_print_msg("[RESULT] batch=%d time=%.3f us/op\n", batch_size,
> +		       (double)(elapsed_ns / nr_measures) /
> +			       (total_size / single_unit));
> +
> +	free(vec);

Surely this should be under out?

> +unmap_out:
> +	munmap(buf, total_size);
> +out:
> +	close(pidfd);
> +	return 0;
> +}

Anyway I seriously question the value of this. The syscall overhead savings are
pretty obvious, but I'm not sure what we're asserting here? Are we trying to
avoid perf regressions in future? Who will read this?

Just an 'advert for use of process_madvise()' I think is not really a great
justification.

> +
> +static void test_perf_batch_process(void)
> +{
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +	measure_process_madvise_batching(MADV_DONTNEED, SIZE, pagesize, 1);
> +	measure_process_madvise_batching(MADV_DONTNEED, SIZE, pagesize, 2);
> +	measure_process_madvise_batching(MADV_DONTNEED, SIZE, pagesize, 4);

I wonder whether this really measures anything re: TLB batching, because you're
doing 4x fewer syscalls in the last instance over probably millions of
invocations.

Asserting 'fewer syscalls are cheaper' is you know, pretty obvious :)

> +	ksft_test_result(1, "All test were done\n");

This is really weird output, it reads like you're saying all tests have passed
or something, but these aren't tests, and this isn't a test result.

> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int err;
> +
> +	pagesize = getpagesize();
> +
> +	ksft_print_header();
> +	ksft_set_plan(4);

I absolutely hate this manual style of writing tests. We kselftest_harness -
there's literally no need to write tests in this unmaintainable way any more.

> +
> +	sense_support();
> +	test_madv_dontneed();
> +	test_perf_batch_process();
> +
> +	err = ksft_get_fail_cnt();
> +	if (err)
> +		ksft_exit_fail_msg("%d out of %d tests failed\n", err,
> +				   ksft_test_num());
> +	ksft_exit_pass();

More useless manual stuff. Use kselftest_harness.

> +}
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index dddd1dd8af14..f96d43153fc0 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -47,6 +47,8 @@ separated by spaces:
>  	hmm smoke tests
>  - madv_guard
>  	test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
> +- madv_dontneed
> +	test memadvise(2) MADV_DONTNEED and PROCESS_MADV_DONTNEED options
>  - madv_populate
>  	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
>  - memfd_secret
> @@ -422,6 +424,9 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>  # MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
>  CATEGORY="madv_guard" run_test ./guard-regions
>
> +# MADV_DONTNEED and PROCESS_DONTNEED tests
> +CATEGORY="madv_dontneed" run_test ./madv_dontneed
> +
>  # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>  CATEGORY="madv_populate" run_test ./madv_populate
>
> --
> 2.43.0
>
>
>

