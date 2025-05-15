Return-Path: <linux-kselftest+bounces-33111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0986AB8F3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78A8164AFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FE026A1B1;
	Thu, 15 May 2025 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RzR182yd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qXdqmoSz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B77269B07;
	Thu, 15 May 2025 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334637; cv=fail; b=WEo4IEND4KxZh8+lY4zlQPAIAvPMd4Sak2unaoNOsKs8QBrhQftEHCaY8vkKxgHR13itX0Sw6xm+k5slQOrFGkmtLO/uSuoi9hsyHt5sah28clOGlLAZgAlzc2dFHo43pQoiDjp7fnpaREEikUFBvHxOBWZc42gXvsPGpi/Jk28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334637; c=relaxed/simple;
	bh=yJ0Gb5cPZUCFp1gNSoaBMlC72p36fBs1mqkFfxkRrc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SNegu3DHzA3tDixtXL1qrn1Z95Dj2IzC3FctfyALzfY98zPeU1rjIZoPfRh4dSMb/NUtCilAReDMLqdaQQ6cet8Y4GHMD3iATVYGz4UHVyxTuWsc0kQ47bIbGZJ9teRN6J/9nMzV3eHiY/dGs0J9+msuYKfSanNCvxXGQNx6sMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RzR182yd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qXdqmoSz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1oZb006316;
	Thu, 15 May 2025 18:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QZIHi5qJ+LwbmRoqq8
	79KQKO6LFjcpP7tKu18zFWeUE=; b=RzR182ydm8Vk+8Jarn9Pl+gXYM5GRGzcRF
	TnvEiTJGXTknleoUqpt3HENkml9HBOAZ8TT4KJYN6p98nW24Fy3Xaj9tQTuxthg2
	jGLv5BxmoRpGyZqDySCsjVwBqVEUihzS9Df/qMSsVLIPC14BhPcoQ7EI9tYRJ14C
	pPBCxe6xcgV+61Bb6Cv3ydV/0s4+PPvwNtl+V/XXJSWIdM4dVWicNU6S5q3uxmxt
	Q/cp7v9KaZwmGDz5ohn1ue7FMtZ6anf84Qj4GlLcethXbc4Ka9k2S0QdM7R7ypNS
	N8NuAcy5rk/pmdTHGwQDYzeWt+UCV+/gT+ua6yJcw74n53B2vlrQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcgvvx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 18:43:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FHXYMu016123;
	Thu, 15 May 2025 18:43:46 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc356sgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 18:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3blyV1pnIgtzn6HRheTqDhnoumpjL8ACyrJreVGJVqaT74MQUoOSZIHOsg2q182D+VZWB3evnkvNN3R/yYATtN6iRjhdsXjuWRo+PzhP62eyxDY7co5bbHOxlpfmrtKFUNvBoUu7FYgrDQr+qticUCkByE7fIiKlJsnEYkzUPdbbn3MQbMUAsE22kjctqb3J1rKuNEpcaNrqmxEVV+KhOGpqzSXFGW6QohIj85T3jRGr5cNqxb7NliRYQwpqENcQw2nW17rneODntc6VP0ZF424CJB/5Mm51A0DK1OhsH6Em5t6H0hrAGi1oRdS7DSGEEtMTdxucGSw3LisfNPcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZIHi5qJ+LwbmRoqq879KQKO6LFjcpP7tKu18zFWeUE=;
 b=hL1sXd39iAbWPU25k+jnEQ3GXn+m/k5cX4beim1J8hVR6IrsBOiPUoyuZbc+KijmzW+wfP9QUO41t9GpBMorPzyepm1RkXkZQgnvFac9ZKZYnVLzXQgBFQn7Z8sI4BillrFP+9xCpBy9Q/gSKXFdwvC5Uu6R7gJZDZ2GSa4dhR0x9CH+N6ama+gh4STUnKDYUynjOY1P9/rkRkx0ohzP1ymGFXvJyL30FqKu6lJTCMmWdsNwwRvkZrOP0B5Bef/OWVFQKGK054bQ/egLe6KpA8maKoQ/0rsw7qsrlj9yo0+2Xrj4c1jonHzkNrCBgtNSX3PKX1kIyKLnPfPCTm8uuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZIHi5qJ+LwbmRoqq879KQKO6LFjcpP7tKu18zFWeUE=;
 b=qXdqmoSzkSbKDdUQdLdr0LNlToPeum2i69MW72z4MqopcceeEmU2SQ5qfclnUHSTOhad8FrJQMCpzmgamXfIXo5JIlEEkPwZjALF25q6Iwu+IbSmYBP38lGDlf3AFZrDn4xBsoLT/mE8HVMOVeqH52tXnxiWman0FszlTOVQ+3w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4456.namprd10.prod.outlook.com (2603:10b6:510:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 18:43:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 18:43:42 +0000
Date: Thu, 15 May 2025 19:43:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Adam Sindelar <adam@wowsignal.io>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/mm: skip hugevm test if kernel config file
 is not present.
Message-ID: <a81d06c8-11b5-4599-a749-5c288f2a9772@lucifer.local>
References: <20250515182333.346587-1-ziy@nvidia.com>
 <20250515182333.346587-2-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515182333.346587-2-ziy@nvidia.com>
X-ClientProxiedBy: LO4P302CA0034.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fcea6a-dfae-4a0a-4204-08dd93e06a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GyFBCQjNIzY/W+LAzQbucC2Tn6qegl8D5JjS3vQyEqwNByIPBZ478kweoBh0?=
 =?us-ascii?Q?INxMhQ+5qNxadsWxiAUrkqfc34I4USeuo5CGYBMtfGCM32L5O9aG+6FE+JxP?=
 =?us-ascii?Q?lnZkt1JpN8dLlRKVfG9lf6Y3pB8pGmqbNIYDb04tBmBaGmdc/2WR/adEnXoB?=
 =?us-ascii?Q?W/Xpj9m0vpu9q8I9AV1rF/sARtjWDpi9caez8CTzHlZN0ioHaaTsv3uJ1MXE?=
 =?us-ascii?Q?1K3LNkEQeCM8SqpFCKZBTbe64p9Y57fdS8yBXmhEI8GstWl3NBCtpKd85YBG?=
 =?us-ascii?Q?1f1weXUcJ/G3rooU9ZOOfxmL89GVDAueYdjA1dKu5d6TnJVWhfZMNmookrAU?=
 =?us-ascii?Q?9Cfl1wtqnmjZGtFXHpb5bn9hMqJj7BiIZqboaLuTI/HehIrpSV/U9dsa5Wc7?=
 =?us-ascii?Q?dIf2bJMbGZ3lST7gNktK+rKJ77SMw4+SStpkpRIC0yRlxG9tfZYU3F/ZEIXD?=
 =?us-ascii?Q?JUe/iviatvdJaJw8e3toO477Zx5Tiw2U6qgVrdePaSaSugHI0C/CearLqcE6?=
 =?us-ascii?Q?+hmEOfIKLGwTsgGO1q/HVVvzv6btY0AoNEZdxj6PH0IpHoykMpQbceSMWNlj?=
 =?us-ascii?Q?z56bz4F6KUXLnaHYHv7r02ugzTudYxx9mZqUOCYx+OBnUfay9dyYxqDKfrzG?=
 =?us-ascii?Q?KVEtRoTeuc/O7aGE8GSUnQntygjKhBD1IpuEq1w5VfACtncBmvDuy1x05BT8?=
 =?us-ascii?Q?cR3B9LAXheovACjJfJulJizc96ONWvw6Xl6joLyJwl5QdbekMl8AGrHUo1qp?=
 =?us-ascii?Q?si9vcE6ekHsTDV9Ekb1Iiubjqeovpp78rjHQSlkP58kqrMBTXBbDfanC35XU?=
 =?us-ascii?Q?Ps6QRaundaLDFEoTTp4aEwfJgp/ckMEh+dpO/bcNfU5TqrvkCNoel59Wlwcz?=
 =?us-ascii?Q?/zEOhrg8NryHbMLRcLKMl5NXm5PhbSREnm9fSGn8JdQYQxLNtSVtwcz7lQUs?=
 =?us-ascii?Q?PVgTdj4cbBCYbCV7/H70mMnXW1kkQF9Pj48uFcQ3IHCoR+2zaHIlZ2vlHU4T?=
 =?us-ascii?Q?JGwjrp50GfyhSgke81cbwJlcCzEMR16PhPPNyrd3v2eooxRWEPDNJDu0zLUE?=
 =?us-ascii?Q?LAbRKdVosQZZoBmXqrCx2W0EXiw53LGLSNe7cnnFiNPR7ILVSLek7W1KQFBi?=
 =?us-ascii?Q?6m0Wwtk2Lp8qN1kB82YAgUwjhRZCl+W8uvQvH2UE41Qwi3ySt5scJtX/NSw7?=
 =?us-ascii?Q?+72QC40xB9X+9ijrinEz9s9q5c02qI5OOGMXHQxWP+FTRiI0rMzyQNdSZJW7?=
 =?us-ascii?Q?YuO2amN5+tJvhgOx1kawGdErnQxUINO50rJjAGcddQWa6qt40B1JmdVKLjMe?=
 =?us-ascii?Q?5tBalz/H3ZH3GyWyBJtC0xL3HEKWrUPtLshJfCAEu+5fDsps7C2BDhhRnrvb?=
 =?us-ascii?Q?TIVD+oMzqpvU29MRJ7YB5m53R2zGdvLXroVm/tYFqt7k1zPDegzzBwUGb7P8?=
 =?us-ascii?Q?8vkJR+1qcgs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hE18WuElvCnoSeIYB3jdEtc0vAsmZbT6IY3V0Bc9FnEdK46fXxzztjBoPtdS?=
 =?us-ascii?Q?hSmfAopaYZMr+mqLRDkr8Pq4Rvjt9D6UKVGSvVhsK6FejPcG7npRWFHY4fNP?=
 =?us-ascii?Q?NU/s4HXt2fhTcLzFb8r6E67/RXUtQkPPnXVOf8xjpHyDaphI+To5Nh+mhwHD?=
 =?us-ascii?Q?9EKKVCJtbqWum//b5+zGgd9S67noDipvm0sEmuu1vRdCxPYk54ePFVXrfcI3?=
 =?us-ascii?Q?FTSegqzRGWH5DQpH16aWhvQRWCluYxLS5WR3z18YTugMCHK5crMwEXoR6pR2?=
 =?us-ascii?Q?3mAk7XJlmHfYb0lJJKv5aDJvQEBuYbippYzrA6yrwbE0uyt3agmL1B+GQw4Y?=
 =?us-ascii?Q?Hr5OHJ19NDP9p4svXs4xutV6ns2Zw++R9eEKUA+dB1uZLjCLJYwL2H87yh24?=
 =?us-ascii?Q?JNAVf3JPciY/LqT/ybDNEuxSmljLLpbqjk04gj0Ht96DVzjnVup/wrbeGIYS?=
 =?us-ascii?Q?YMupJm0SmilvzZk9uqZMxlvwZswVC+/sYAtRxxxc7Mk09egWgsMByhO2LT2e?=
 =?us-ascii?Q?k9aLx0P6y/ooDo6f9So8aIXihGLaJVtPvq24KIafhlgcjeEIbn8jo8ak0IHi?=
 =?us-ascii?Q?NGcIZsg7zadbu0mQT6/xPNt7DtNVnsV1LJSobKO8L12UbVYDaJHbJPYiPM/r?=
 =?us-ascii?Q?esfjGf2J+JBUA6GcXbLRE4l5s5JnypDd2GL402iSNF7q5EhRZucT5LbQXS+r?=
 =?us-ascii?Q?VhSRWV2pG7bHW3Ldgiua3zXFLlzwZg8eCMrWmWskIngPy0blPt7yh1Fl8wrd?=
 =?us-ascii?Q?unDLL1FipfIRLRNVkxFPuF1DzeBM9YG6ccEQbDduM2zDg0y9h1OqRwfP6a/D?=
 =?us-ascii?Q?VU5xxUAaILtMevMWUuJQzBt6ZOCcV8/APliOOJb6RO+uLVxZgHbLCDLH+1eo?=
 =?us-ascii?Q?vfW9Ah1UJ4YhR44WvpTAXQPWzWfGRzM1llGT1Urw20RyBqgImd1X+/meIkh8?=
 =?us-ascii?Q?a9AEXLppTs9dHqiCAKsqPOo1VfyKnWITMsvdMg3U8Xmc0zgZZZi6XGNHLMRf?=
 =?us-ascii?Q?w4niCDeAJ8O0SNB3WJgvW3c+x4cA6Ay2qVZ+fViy8xQ3n1IyoowzLW5ro3Dg?=
 =?us-ascii?Q?I/fzvO4o0rSSsYnVTHA3p8nP3PNnMJhGqQtnjIMLMEbERD2kiJIike3oIDqO?=
 =?us-ascii?Q?BddWUILn22hYtq4YXGq0n8+4YfNBaUD/9zP1WLa0V8MliLHv0AEJYI8/zvKt?=
 =?us-ascii?Q?nrR6Dr0U1nzLFeReQ5gAuB8zNCozLLN8JSRKkSjZ8stne+OvXmDI8n1tFUv8?=
 =?us-ascii?Q?2TDkGlMhc0B0xaMakqHsCsbWIUlJ7ZZIfzcPExr4vx6/Lfh27Un1W3n3Dnzs?=
 =?us-ascii?Q?tN5v1paKGmZFJVW3OueGeDT9uS5pV2kX6p4BKRD7WKlSw4eNICo10lKc6/lZ?=
 =?us-ascii?Q?P11xbohxtWENoB+kNYCunnUXY9EB33h8ZnmghSoLxrn3VSQ+BLcvfGdxesRL?=
 =?us-ascii?Q?5ZzvGwuWwcgCkqQfT4WF/cVY9In+3UyfH4MpmOPD4I+mzGS1A+WNTcD5DdGT?=
 =?us-ascii?Q?6Zdl/0YQCvCi12IlwQjNaDAPC+NTv1G6lfdiV56wiCiP+GDrUA8gPBgCNvt/?=
 =?us-ascii?Q?YRAsuiFWfKkSkPfCbfONtDSlAUfIosHeYpBg8Y6/6TEB96M1AppOkZx2YZsx?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Lw/eNghBG8Ktoyo94vlxe5NCoT+Sq9GUvxydGbGEsqFpwigN5J13NWxY5FjYv9Z5zHIeKabWNZnqsC7l+Sx3FLsOBoaeRppRUacfYdUEBGE1CgRd8MJPrJhOBYEJGxQk/oHbKv+55syAnuVCwyhskhAd/ZcrrjXNkNJIvDRI2yBsG8G476p60KoagAE3Uls6Ghe6iWn6TSUzOcdxSLqb4Xf8D7GjtmSrWBU9xM2u/HqLqj6EqyBaUvMRCbfBWgszm1k3XlBOWYA7tGTyUlidgMMU6NP21BGNL2o4o9uQSi0npQW59rzRWt6Pd5ouR9ei+N2NDSA/UH621Gzw9RrDet4gOQcQJ5w5WpiAwqPgTVXebYulmnzTQDKr61a+9HFoiFLPq5wJQ9D2JswTirEoIU3vmvCOTYSJQtYsl9XYqdBcjR0oktYa5ououB+yItMLBAxxP2sdHpdgsUYl5Tk/A9pao6MNxLeDAYia75QPNAKKo/8TdCGFY6lGpG4PzZUsic/+3nPIb0L+X3+GDCMCN4syrpNW8Alck5vW+iqzBkQWXi9iYNdX5HWASO5hb+YOjrBkfsQLWRfzIFdns+FuqigItgO5BzhIwBXrePuQ48=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fcea6a-dfae-4a0a-4204-08dd93e06a91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:43:42.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVj6+cPfFWTukGaAK3Q9htaybwsJipgOT84YnVBAIhMC1ILHsLiIqfrm/WHEy8gfm/SnKuwsUvRdSdHT3YJ1Mgs7XDhl58dfgM3Xif3+jug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505150185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4NSBTYWx0ZWRfX3ZhJUp6u0i5s udMndsRsliOaXeZlG7/rDazgpRaGhInZT6v3P0gtxbo3mhIKM9Jf0YR+p2MRW2nPTN6+C87tlhF L893bSGvAn1OSt6neVpXFo8XbWJTOmn5VyVb1/D4za5V9ZEPLO4mPwiTgcq/oyvd4NIVPNSw3eT
 JvglWUSDAyRhU7ed8B10CZyE6YvKAvEmWM/mzZeuRzr4rYc2qjTGO6O1RYYJU7VXTAvN63R6pt2 SqTM+pOFqQGHbhzvSRSMB2EarcSc+3HL2gkVvhTXsaKnsQ9udxB5BwzgO5r/RvO2ucp9xAowl2t 9Gb8lAVZQUZj3l0DyFbSuZ/BwVYWa8t0nAQYH0KMcah2vvXYHEVxcmZ1GHQa1uVxACfrko5YnLI
 eWVQVVt2MLFurszf0jjP75waqjCJp7ABvSaHXE140GivehpAw0OWfwDbGkXxJ5zoYfXxiU7X
X-Proofpoint-GUID: XJNvhcxXBhDBVSaQ1Ir9GsWjGsbBIYw-
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=682635e2 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=83yXuxyMJceoGsA3e0wA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13186
X-Proofpoint-ORIG-GUID: XJNvhcxXBhDBVSaQ1Ir9GsWjGsbBIYw-

On Thu, May 15, 2025 at 02:23:33PM -0400, Zi Yan wrote:
> When running hugevm tests in a machine without kernel config present, e.g.,
> a VM running a kernel without CONFIG_IKCONFIG_PROC nor /boot/config-*,
> skip hugevm tests, which reads kernel config to get page table level
> information.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Looks generally reasonable to me, but I'm not so familiar with this so,

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  .../selftests/mm/va_high_addr_switch.sh       | 26 +++++++------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
> index 1f92e8caceac..325de53966b6 100755
> --- a/tools/testing/selftests/mm/va_high_addr_switch.sh
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
> @@ -7,23 +7,20 @@
>  # real test to check that the kernel is configured to support at least 5
>  # pagetable levels.
>
> -# 1 means the test failed
> -exitcode=1
> -
>  # Kselftest framework requirement - SKIP code is 4.
>  ksft_skip=4
>
> -fail()
> +skip()
>  {
>  	echo "$1"
> -	exit $exitcode
> +	exit $ksft_skip
>  }
>
>  check_supported_x86_64()
>  {
>  	local config="/proc/config.gz"
>  	[[ -f "${config}" ]] || config="/boot/config-$(uname -r)"
> -	[[ -f "${config}" ]] || fail "Cannot find kernel config in /proc or /boot"
> +	[[ -f "${config}" ]] || skip "Cannot find kernel config in /proc or /boot"
>
>  	# gzip -dcfq automatically handles both compressed and plaintext input.
>  	# See man 1 gzip under '-f'.
> @@ -33,11 +30,9 @@ check_supported_x86_64()
>  		else {print 1}; exit}' /proc/cpuinfo 2>/dev/null)
>
>  	if [[ "${pg_table_levels}" -lt 5 ]]; then
> -		echo "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
> -		exit $ksft_skip
> +		skip "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
>  	elif [[ "${cpu_supports_pl5}" -ne 0 ]]; then
> -		echo "$0: CPU does not have the necessary la57 flag to support page table level 5"
> -		exit $ksft_skip
> +		skip "$0: CPU does not have the necessary la57 flag to support page table level 5"
>  	fi
>  }
>
> @@ -45,24 +40,21 @@ check_supported_ppc64()
>  {
>  	local config="/proc/config.gz"
>  	[[ -f "${config}" ]] || config="/boot/config-$(uname -r)"
> -	[[ -f "${config}" ]] || fail "Cannot find kernel config in /proc or /boot"
> +	[[ -f "${config}" ]] || skip "Cannot find kernel config in /proc or /boot"
>
>  	local pg_table_levels=$(gzip -dcfq "${config}" | grep PGTABLE_LEVELS | cut -d'=' -f 2)
>  	if [[ "${pg_table_levels}" -lt 5 ]]; then
> -		echo "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
> -		exit $ksft_skip
> +		skip "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
>  	fi
>
>  	local mmu_support=$(grep -m1 "mmu" /proc/cpuinfo | awk '{print $3}')
>  	if [[ "$mmu_support" != "radix" ]]; then
> -		echo "$0: System does not use Radix MMU, required for 5-level paging"
> -		exit $ksft_skip
> +		skip "$0: System does not use Radix MMU, required for 5-level paging"
>  	fi
>
>  	local hugepages_total=$(awk '/HugePages_Total/ {print $2}' /proc/meminfo)
>  	if [[ "${hugepages_total}" -eq 0 ]]; then
> -		echo "$0: HugePages are not enabled, required for some tests"
> -		exit $ksft_skip
> +		skip "$0: HugePages are not enabled, required for some tests"
>  	fi
>  }
>
> --
> 2.47.2
>

