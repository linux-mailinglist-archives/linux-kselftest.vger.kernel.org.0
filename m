Return-Path: <linux-kselftest+bounces-19936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACFC9A1EC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B4E281957
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214591D6DD1;
	Thu, 17 Oct 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m7o/uGqd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GioODUlR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B771D2B0F;
	Thu, 17 Oct 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158406; cv=fail; b=i7P/0zwAi/qLZ2Lad/jd4hT41no7VdQ7KQOD4EszRxsO+GQrNr5s6iTJPBLthjqyUVhQ6Z2scX5xAdT79GNuLV/ESRehmFJceE39dhHenbwiSOyJkMSLCZHFxbortXIMe2AHHfdSPW0mno605AasM9lQK6dzpUTL3N0Jjn6RnFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158406; c=relaxed/simple;
	bh=AnIQ5Fyv+RZYZLgaaUxhKOrAIBzBsKQQBQIsvgqaITE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XiNNHzh3yulqZ1Ps1VkmzrfSJy1HooJwVtLmjZJtk7qdJt0GlmsYiNKo8P0AzmxC6iHC4Ch2+hLnzU2TUprjCwCvCX/ZoKghy8BAk7nKfVxwQ4ibQlR8PClWPl/IxFRb3DrypaQcQ1rJlcBVie4Ol87A47adSSqV4VwLZguUU4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m7o/uGqd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GioODUlR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9Mb6c017399;
	Thu, 17 Oct 2024 09:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=DaUZkKOjs/QdRJo14Y
	d0aNxKpYIC8Blz22hqqtMgDMA=; b=m7o/uGqd7nLq8F/xz5ocaxT37pIqSrmLkL
	dmod5icFbADe20M3siM5Yb2Ik7f54lNtoR9VLQVkLcy0T8m//CZzx9gSKvqN7MTO
	yrPScK7JfgPg9yDdmMi+0y1TN8srL/EGfu7hs3ctBWFAl30Xpurt3F7DPnkjrNXP
	tQh2FDD1xh6ZEWIB/1JhNgjgLr+s5NrEuQvRzf9vwkX5z70lN5WI279I3lGFhrTp
	p1JB0vNTupKrXUGXf6rHEAiLyCVzpN46dnzGLY3v9j5nucTc60KCUrQUlojovEcV
	ewqlhtGIphqAV0uSEoWVjhRYaHht12hhmHXmbyOe5AlGcaLrqiUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2p1qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:46:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8GFmG011105;
	Thu, 17 Oct 2024 09:46:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgadw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:46:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8p/TL0qsJjUxkE2ofzvvoLgWkhdPtq59lXPgjtR9i1cT2PiqSkacSkWEuHcdQ/Uj3w0aZg8THSBw3P0juaE5vmwEKkGYD7wzMhYeHfLZzQkgVMwktCHztTC81piTBlb8ne+L/DEPeF1hOJF4FJ/Oo3EJnwJani+r0j1liSnhmw1U1SyqzCdrDOb9J9hX1MKf4LZh4GwVkKCGrsviLNTfaaU+CKz5OkEAzWk0BQDOVSwDrMaTetsFKWVeh7j8M+qzOz1b+MtCWAu7LozC9ENLlZGsdSnYjjLwetU2IER3+INz/DWuvR55bQ66/+s+CNQ/HQ1LaTKHYjZocS2vtM8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaUZkKOjs/QdRJo14Yd0aNxKpYIC8Blz22hqqtMgDMA=;
 b=yRVxcdly8kGGW63bHdCYBuEYk+Z5CDcfm3JI1sGz8/BwlWjq8A8GALUtakYIA/Eyv4p1ex7F+cSf0HAZHUG3AzzXrgvhIz2mv73hC3WKgGmQ7NHFQ3YBmEJmeHOtT0IN9bP+HuNHgTX6NjSPCzlgVHsnyiLGn7045fUledjgC4+uh0UZaKV+oochenulVdl8UqkLFE90yUJ+tuVu6DbRzazMyuUYDI0c5n+vAV5D+7UP7xwHE650oj1q8Z8yHBYOgq0Ktv7RtLOqTNo9EN2XHZDpn01sdW6iyOuc4XV1yQcg78G+Fc2msUNC4mSmOkGvqMtbDFebImkh0byMzdQTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaUZkKOjs/QdRJo14Yd0aNxKpYIC8Blz22hqqtMgDMA=;
 b=GioODUlRfTKkZpWTbDzNr4/BmENLYkNV7mhd444KEgE2yWsPxieEiT6EWeYhiYkIljSs51P8Jengc2HvqPNAxrf6XxTZndoYuELLYvsVLWNRo2M+OOzDgdmsIIM5+rtswYN449GoagbsltQFI0zB3J5qGMjfWnFGdtGX/YwnQ20=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 09:46:14 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 09:46:14 +0000
Date: Thu, 17 Oct 2024 10:46:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org,
        torvalds@linux-foundation.org, usama.anjum@collabora.com,
        corbet@lwn.net, Liam.Howlett@oracle.com, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, sroettger@google.com,
        pedro.falcato@gmail.com, linux-hardening@vger.kernel.org,
        willy@infradead.org, gregkh@linuxfoundation.org, deraadt@openbsd.org,
        surenb@google.com, merimus@google.com, rdunlap@infradead.org
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
Message-ID: <ac11e4c4-a1df-4d39-b7d1-ed9ebd65cd16@lucifer.local>
References: <20241017022627.3112811-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017022627.3112811-1-jeffxu@chromium.org>
X-ClientProxiedBy: LO4P123CA0627.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: d1cb07e3-4ad0-48bd-f969-08dcee908a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GzRgFNHkCT+h/5V30hAD8vlNQV8FVVhZwNVabxiIPFlisSG4vnFHCK3XClA8?=
 =?us-ascii?Q?RSXjHwqOtzplKudsW3UTwejN/YMqPg3MQJTq13JJyMDJ+lM7PUIP/Co0Y9Kd?=
 =?us-ascii?Q?tPXh3c4txAL/967y4JYAIrSRS+hOaRWOB6RVd2LgpUPFEUIbQEdxq4w2hSVJ?=
 =?us-ascii?Q?6vjZaIaAj3fao5mAscrTiCIVwPurGBdxBxg/GRQrg7zlGSz7a/L6ny4SIo3a?=
 =?us-ascii?Q?3AuBPbyGpvZVvw1fR6W5cMoD7MHndfQieyiqiw1C5U2Z2aqMK1+4FS9zPs9k?=
 =?us-ascii?Q?jDIDwaOk2lpHY9W+ta3SoWQchb14NJii2D0rjAj64rHKuPSrDE0WrkXAdd9z?=
 =?us-ascii?Q?C1zFG/KjaIfLyi42YWl1iXm0DqXDDzoKhggMBQexx68qex0M8clPubVpnmIm?=
 =?us-ascii?Q?9hfeOpxVCxum9E/uJb5DapOM/YQJEQr1VlTQCo6VNyOBk6bPfRNySdeaCQGT?=
 =?us-ascii?Q?Vw70iTk1qyK15HdpSpKti8+RHdjcgwp07UOvI27APgMHhb97b5RuHBvBLQCw?=
 =?us-ascii?Q?AjAhdc++XV439ep9SxrPZ2+0YUvklz4G+FNG6Q9mJeQzSsxkkqbZm/RfNiZm?=
 =?us-ascii?Q?DGN6puCfwd4RcMn1sA0ancN5CegMcaq10ev9pnT6T4m/YZNfWhtFKwlwMm7Z?=
 =?us-ascii?Q?osCKBA9viMiNEVqi0xmRa3ARRunEIIKEh7LMIfQWOqlVtwpBJKVdcUICEBtD?=
 =?us-ascii?Q?Om6FKmmC9jyczRX/NIXuJMkomQ/RSjZsyrmFoqkytXVycJDEWn/c8ea5ZH+6?=
 =?us-ascii?Q?5gvE7JHZiT5VUsFEZoQu0guPgyuX1D859Y6f2nUSERstM8SsrLA0ciF44xK2?=
 =?us-ascii?Q?intizZ43b8eJOnC36BkCHPJTyW4/09yPf423c5ytNVqdfAiqFUr9MP9WB34m?=
 =?us-ascii?Q?XZ3cFSxheK+4oG7ykLdvtA7CSne0XSRR5qqB4fi1BQP+nRCAowFyCX3cW2hJ?=
 =?us-ascii?Q?JKQMMviNtJTZMbSdEU6OH/a2bm0AuDydaqxepQ7dDYi2n79gUt9dJHwOYiLo?=
 =?us-ascii?Q?inldOo36bzjt6jVDRVjnOlW/qevvT1JO8FCQKA+hhX5iyouxRIt4oF45vdkY?=
 =?us-ascii?Q?LdSMouj/IyRib2YscGBJw8sAxq0DqIDUhZ+xzPSJZkEBjcCo6jjVOpWhAfRO?=
 =?us-ascii?Q?pqOAvuipjcpKIvjbuPSnzi22qM2USilx3V7Pb96m5Yi/gWA/oueY8E3qVPLe?=
 =?us-ascii?Q?lpw6BKTZfzYipFM+LgKgJcJ3mqOpoaws+YhJOODlYXO9kuoH6k5XX0lyK0hq?=
 =?us-ascii?Q?Czl42xJ3+rDR2tiot8kL9kAwfEFTuOVycuYHWozzzeqgl1YQjaaX7IQ1pH0h?=
 =?us-ascii?Q?EVws6j/NigEVzu99GnOMA7SL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7VVbbFi5KDrJh7WZ3CWmkIDDuPxF3DhaYYsYnh2cCEV5Jw20SksVLNvWJdr?=
 =?us-ascii?Q?87/pkdwz5gFnzHCnQVUwtFxXDE86pAD0/UMRwZirdlal9BVfhzKbdWfg8T67?=
 =?us-ascii?Q?obUL8Akk6FSP4r4rvw1QGh3YX9B9TlVm94CgY8lCseWb9jt8pvU8GOHl6c2Y?=
 =?us-ascii?Q?hQeff6mojq9J2uh+NQLQCZbLUy42trrCwv6eyC0lHhdkjyuIohVkDC6CHB9j?=
 =?us-ascii?Q?UixBVeWheInlKARQxNPQgvHcdCKcj/Y/Ls425yIVaPXiOte7keimGCLGoeI2?=
 =?us-ascii?Q?g4V/GAJsOUgwbRWcv09BrteLlzg0uNZ0JXqIA3c0M0vYJTuNiwMHzK0cRo/K?=
 =?us-ascii?Q?iebEHY+60dowg7eym5hJpMo/zpaITnS+QvsxQ1P4vX2eDku1Ri1GaZ8ReOPX?=
 =?us-ascii?Q?uUATcS1hODj7c5xD8uMxBz0RkO8mdinsFnkbSSYxQM+eO6JupIRG3iJHlhLD?=
 =?us-ascii?Q?J9npvBBTvkXu2t4xZFWhntSS9iP6wWfJqHvqUZAd38DU4d0j8YkmJg2ZdCMU?=
 =?us-ascii?Q?9mNiFn+g186WF3TAoEXz5kpjwyuLDn6GekMDq/3gJCMKOE6Cus3775RTeKds?=
 =?us-ascii?Q?i0KaEsdRpz3Wkey8tQp1xBu4rGIFCvxK6KxWB31W+eqEtaNglg6o4HszJALr?=
 =?us-ascii?Q?2IsCSDUbbyfdl+i0U2BrxqVzClRG4j84Qt01w0Zoz0PR7yCz5EETvXfVsvZd?=
 =?us-ascii?Q?V1xFPKfG7KSuiFLBflb84eou//5xvj5icUCrI+5NXQNGaImOrU58mct9mKcu?=
 =?us-ascii?Q?sbXKU14KawMHjck7dc7/zcAZvyhQrxFBLu47CvLqrgMsoR7/lwI2qB3q9h/d?=
 =?us-ascii?Q?eitz6li5p2rZf9RTBQJD7UXbBL6+ELrEsbPqsFNIGlzI4tWG631HWuPA1pNh?=
 =?us-ascii?Q?2AGpmAvKQdJNFU/hMq1SKWatndqNlewvRyp5ryfTFsFD0I1x/N+1q7UV/c/9?=
 =?us-ascii?Q?ajE9DChmwuf008rlF1DgozH4Z+sQJordXPEUSgOQlhyaSt2MfazygIXCD3Cx?=
 =?us-ascii?Q?EcWTq3z7eK+sIjZly0tALc91qDtwwlrJB72W5lhQRsCWTZSw5sEoS4hnkqLB?=
 =?us-ascii?Q?QKe082NmdYlk+Zr9HgPGlbm60PBJYox2RleypumhYCRV2TfNvPDE8+HYHxfc?=
 =?us-ascii?Q?TPcSsSen4h+x/s/JIfgzQ0xqkAO07D0g1S+4+UWcVDOKw6/ZqWbxsW0zGz2j?=
 =?us-ascii?Q?31u4QhKnWVmqiYh8nF+LMrinsvk8lGxxQhyRDDm+/EFobxVuxjLXDjN3S27p?=
 =?us-ascii?Q?LkkQb2fVDjdjgRJotcxNUhzH6daCxisdTVg7b9q/TUKJ8HcQ1CNMNR70BAgH?=
 =?us-ascii?Q?v22Jbjz9IqCJTzbiIxkq66AiNm++2Uoa3DJHN17msCuoSi3hl0rGIst+mqeM?=
 =?us-ascii?Q?QwFPkaomA9aF8ZHO3TLyS6tmsWJmfhpLj/vXm/jk9Maiq11QR79FC7oGwLZX?=
 =?us-ascii?Q?VbCqpT9FTaSM0+qOF39KcIHktPUODfNtD90z1IMFRINENKIVmnwnbkBmwcYC?=
 =?us-ascii?Q?/Ow3wQnzulGgmT2c0N78S5A3VsH/WFgTdtWQ/+OPdeHUrm0wGVJ8I1Si6WVQ?=
 =?us-ascii?Q?tEy760/+7wBYOXth2NOztyKBK+Pw8BgbrUACZ0lQa/32navhmwHwRdsXG8cS?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bu2yNHpwbs9XyjC1R0dRHjnnP58hPRdo+vaNhVTYTe9bGO2EXf+esMw8Y6dQmzbBrPyqNsXjpMzA+1lb2PhtQtrHjlp2HAQnUYvZwTjZLGZ0F1mfTG6HgIeQQJDk6ETiJRRU13g/P33pZJ5p3EooUpEDzhjSXBWhM6nXnk6by26yINvsM3H5zATwmRPgFPU5ft+lD7/2rHTQ5SoiU5/fYs5hgsIU9ez5b90l3SKpcHrh9M//QR0zXHEerGFRe4stuHGC94cIAI9FrYFiZ1cn+jssgR/vxWw8wJ4dZn5ACMOb7nruJiHjmN6Ez1wgqZeIqO9AH+Jqp2D3O52N+exCUzysS0OJAypVJtiKorR+hOzw+vN8uQIMsDg2C5cplnaeLaAsCD6+48Fv215PBotVfUgKgEO8paARLbIq47WfsrQKj0O01lIbj4u0AZTbMQSyK7/DTgZkVye1YSJtGR+LR1LpJPI8EsUl6Qow7hTsIg3bQCDIqTClyXUAm7tNmMqm9obBrM8gUUxwDlHuI9MEiOCoOxme+srXivybByWZCt28zvxVaOSqzTkp4r0PQqlD+OofEiAurvBKwwAra3mHzzs/NPz3xtUjQtkfK8zCHy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cb07e3-4ad0-48bd-f969-08dcee908a5a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:46:14.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fP+FOwpjBZBYSmkXCsVJTUs4x9DT2A4I6K+dAnP3vr7B09VLoFyrOa94eZyFsIc0uTIAJKobZOQSCJWmC0hwGqYSmOUKGFOMtt1svQg2SKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170066
X-Proofpoint-GUID: cbCJvCUBFglz9VYxG9SjIYGjrdga9746
X-Proofpoint-ORIG-GUID: cbCJvCUBFglz9VYxG9SjIYGjrdga9746

Another thing about etiquette - sending a barely coherent _failing_ test
with basically zero explanation as a... patch is NOT how to interact with
the upstream community.

The sensible, respectful and workable way of doing this is to send
something like a [DISCUSSION] or something and say 'hey guys I think I
found a bug' with an explanation and a test patch attached.

A lot of your problems with the community could be resolved by being more
polite, respectful and taking a step back and breathing and _communicating_
with us who are here to try to help fix problems.

We are all _extremely_ busy, I am ill today also, so taking the time to try
to explain problems patiently instead of firing off barely documented
patches is far more likely to get you good results.

Also you fail to actually say what the problem is, what fails, where yoru
test fails etc.

Anyway, let's try to decode (please take this as input as to how you should
try to communicate these things):


So we start with a VMA like this:

012345678901
xxxxxxxxxxxx

We then seal the middle, starting at offset 4:

012345678901
xxxx****xxxx

This sets the VM_SEALED flag in the middle and splits VMAs resulting in 3
VMAs.

We then attempt to unmap 4 pages from offset 2, but this fails, as
expected.

012345678901
xxxx****xxxx
  |--| fail

We then attempt to unmap 4 pages from offset 6, but this fails, as
expected.

012345678901
xxxx****xxxx
      |--| fail

At each stage we should observe 4 VMAs.

Are you suggesting there is a larger unexpected split? Where? Under what
circumstances?

Let's figure out if there's a problem here _together_.

On Thu, Oct 17, 2024 at 02:26:27AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
>
> It appears there is a regression on the latest mm,
> when munmap sealed memory, it can cause unexpected VMA split.
> E.g. repro use this test.
> ---
>  tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index fa74dbe4a684..0af33e13b606 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -1969,6 +1969,79 @@ static void test_madvise_filebacked_was_writable(bool seal)
>  	REPORT_TEST_PASS();
>  }
>
> +static void test_munmap_free_multiple_ranges_with_split(bool seal)
> +{
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 12 * page_size;
> +	int ret;
> +	int prot;
> +
> +	setup_single_address(size, &ptr);
> +	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> +
> +	/* seal the middle 4 page */
> +	if (seal) {
> +		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  8 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +	}
> +
> +	/* munmap 4  pages from the third page */
> +	ret = sys_munmap(ptr + 2 * page_size, 4 * page_size);
> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  8 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +	} else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	/* munmap 4 pages from the sealed page */
> +	ret = sys_munmap(ptr + 6 * page_size, 4 * page_size);
> +	if (seal) {
> +		FAIL_TEST_IF_FALSE(ret);
> +		FAIL_TEST_IF_FALSE(errno == EPERM);
> +
> +		size = get_vma_size(ptr + 4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);

This is repeated below, presumably you mean to do size = get_vma_size(ptr,
&prot) here?

> +
> +		size = get_vma_size(ptr +  4 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +
> +		size = get_vma_size(ptr +  8 * page_size, &prot);
> +		FAIL_TEST_IF_FALSE(size == 4 * page_size);
> +		FAIL_TEST_IF_FALSE(prot == 4);
> +	} else
> +		FAIL_TEST_IF_FALSE(!ret);
> +
> +	REPORT_TEST_PASS();
> +}
> +
> +
>  int main(int argc, char **argv)
>  {
>  	bool test_seal = seal_support();
> @@ -2099,5 +2172,8 @@ int main(int argc, char **argv)
>  	test_madvise_filebacked_was_writable(false);
>  	test_madvise_filebacked_was_writable(true);
>
> +	test_munmap_free_multiple_ranges_with_split(false);
> +	test_munmap_free_multiple_ranges_with_split(true);
> +
>  	ksft_finished();
>  }
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

