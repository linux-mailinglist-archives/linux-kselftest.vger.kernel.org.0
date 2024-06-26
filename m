Return-Path: <linux-kselftest+bounces-12762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E56D4917596
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 03:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730C91F224DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6C4F9C9;
	Wed, 26 Jun 2024 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gjli2Brs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qi82yCqt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0FD2F0;
	Wed, 26 Jun 2024 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365354; cv=fail; b=JNX0UKD+cPgWNGHrQ3Zrxzv6cuuqdCT2d92kDXbNfAgO0R0X66c+exEyJhPxm7mu/HGG0qJnzm1vOiT3T/pBxH+0rzMUbj2Hcv0LQm2Bpb6hyKryOl2/muJDtWcWETlQQ9FH7CVhHcyaqDs8DD0G0wMly6I9FCyQiVR10MEay4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365354; c=relaxed/simple;
	bh=a6USTozOOk4ibYusmm6Puwl18qksV8SbIIp78SZ7XBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uA7AB5FAsJKC87eOP33WWRQ2NkhbAfh4/Pq9DCi4e646ZzfIOC2kwVduKFiaBWJSxUnyUHBgaOOchKcxgdhcIgN63GXjCJajh+o6tB7Kyilq/jcbaKIkOgYeDc5aMTKOsRw+YC3O/Wa/8RyhDw6XRY35pUaYrTkEYm4OeGzTI2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gjli2Brs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qi82yCqt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PMBVSC003074;
	Wed, 26 Jun 2024 01:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=QNakxFB1cm04kNOyVqQ+Uuqbdo8PfCWEd5SF7Z8r2Ys=; b=
	Gjli2BrsHqBiodzCQ9ZLnSQa0UgxyTbpi+7cuBn/qGtxJ6C8rCHByyd2oCAi54bf
	ArtqLRvAzCaoS5lGOBDY+c8UoZYk3ouD4phT7tlrFLB72cpCrG3Ri5p+ApHU7f+D
	SY5x/gGGvV7/q84UnkiBGcaKoxlx0Fn/KPXWb+oYkBymq1Hr5cWkSPR52T/2yjzT
	WXxfx7voZAhLj8eddytf4QEd4gtCHoJoAu9CKQ2DVLVyr3WA33jZdqP62MmF6pkm
	tekuGbvlM/krcuN/XVShdih2RZqOS5pD26YgZfJJ2LiyrpnLvPDNtSJb0O7rHmQJ
	sjb4l7zNPdnRi3tvIcjI4w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg99u7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 01:28:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PMxQNM010948;
	Wed, 26 Jun 2024 01:28:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2ev3dc-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 01:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdNSGCbtIB8dGeni+Aq3uf1Z3tmaEuAMPT24YIvAw8FqOSPzAPn6mDIkTUfWNnUjJt6nLid2GZhJe1h0ub20eGkARXFjrjzR34gWIyypYsSROc/rZPPNdzEalwcVSda2+CbpUuCMpbctBJ0UW7OCge8PX7ZYMXWHZ9mPyA1Wp2rbSvBg3R9oc5nzEDpWVBtes8QYFaPd5vSE3KHv4J9WHe6HiEKNZWiw+sWs5vMCzpiiwMaDyo2yrQZ5cJ3xRgBxjzrj6EbJMdAJoJcOhApZ4NnAg/oYWZ4ePoQwIf0qaM2ysZLNo8mK92svMqZvQDRaXf7WUk72BJcnQWLlNXMn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNakxFB1cm04kNOyVqQ+Uuqbdo8PfCWEd5SF7Z8r2Ys=;
 b=hbCupJipr4IJDvf3SFBQGOAgxdI9Y3tw/MiW+BQx5CLC2WErok4yWvbPKvTxERdiqjdOz7B/QUE5mF1HyGWzAzbM3jtYbLWxMF8LrPdTaisrLElUlEQrEKkcLh5gzyN2Cp++T9qlltpBcyzDMJVqQJ+MnHdIBm5s8z0qODtwOEayloEudysOrsOnS5KI9d8s9uzy3cGnKAX7PFkpzJKrC2WQW0aly8/7z4auNKTHZ0Ne7wNtPR+LNnMT7nz8YymHBv6fxeQGqarl+IgHoetbNe8JSoZv3IeOjeRByvr0Hvo7FepxBUBJfCfNdrj/+NctPVLUQUOunCBRQ3s8IknY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNakxFB1cm04kNOyVqQ+Uuqbdo8PfCWEd5SF7Z8r2Ys=;
 b=qi82yCqtV5JHYhxWLgDQu+F+hXrE5qyWPqRKFy2UTnNSuj+C2xXkq48ITe3p7ZtuemPxQyr2Hd9N8Horxrmw0ZUQexLKLvSuYViPMp3Apt2GDa4Fks5e++wQs8HH2zn4oi4uHt2d9EcGsWkLiePQarQVH+twoANYnhVXjIW/lkE=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 01:28:48 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:28:48 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-rdma@vger.kernel.org, oberpar@linux.ibm.com,
        chuck.lever@oracle.com, vegard.nossum@oracle.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH net-next v1 2/3] net: rds: add option for GCOV profiling
Date: Tue, 25 Jun 2024 18:28:33 -0700
Message-Id: <20240626012834.5678-3-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626012834.5678-1-allison.henderson@oracle.com>
References: <20240626012834.5678-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SJ2PR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: f61d1dc8-14e6-4df8-14cc-08dc957f53a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ig/VcK1kc9vodLVoEzp4UeO4fPT5pgQ7vrzXfwszYQhW1sCQ+YXjyXypRYKR?=
 =?us-ascii?Q?V/cfVUeuwD/eskDTKkozNPg5COnr2SAbulj7n5rdcjUEtwkvO6BMIQZhC8Ld?=
 =?us-ascii?Q?3FxgR28cpzOPXRDwj8LqjBCsggjUXvrKUZ5ThQVsvHFDdYFZb9f6LUn6GzLd?=
 =?us-ascii?Q?XYT1QeWcpeSFPNv89nCGeJRf48Bo5OtxrdAkiLnkiralAE4NQafRCUHGS2wN?=
 =?us-ascii?Q?wfctCkgs9l/fGOlrezCxGYJcDo/Bwr0ApLUvrPDZGmq/bHmWp4LicqEv8h2e?=
 =?us-ascii?Q?TnnnIaMb0CCVymTBJOazqQVzdx2kBitbYVqcRRO1q9RMmNxW47JWWjODujc/?=
 =?us-ascii?Q?LAWQZz4aYqVz4/zoKHe7r/BRnmaznbqBdOUwwVkW3pfUBEJw1/YxaZYDD38A?=
 =?us-ascii?Q?/A4Z56aSrmb9Mp1BXFC/4dciMy0vH+IexLCex9uiUhIEnucxmh2Mie6wnbqx?=
 =?us-ascii?Q?W99BeWBG2wy/aqc7vVEyPzVeWE4o+o4jQ9IRztP7cUsRDuP85rCzEGN0ICp+?=
 =?us-ascii?Q?DnxytTh7ZxbA/H4R5znHlrpHPZSBetcHE0a9AOGCq5GpphHGoGh4eMCsny6f?=
 =?us-ascii?Q?+D5k0DNYXzHmbFKkYcfm4RW9t2Vd/6/e1dogdcVuO7BAoyjcsfoeCH4aiBBT?=
 =?us-ascii?Q?hlnLCuXljLCLFEiJSXZ1jsYfcR1nmdX2x/bNkBM214WUdkEzrS4aPDZWY5b/?=
 =?us-ascii?Q?XZfXk62qTtedFxPcLz4g73M5XhJR02K30TW5nc0R+D1Lw0nRnbteWoDMXdWS?=
 =?us-ascii?Q?DLx1ISbTh7JV11onhcPrOXKCa47TdjUvNHOKfWNB4lb1a5vT4txHjJq1Ajej?=
 =?us-ascii?Q?LWeRQP19pNWW/M6xh+gDUivJQjbadSIYD+Iz/YqVN4mCAKQ+1mc/Oilhm7Oz?=
 =?us-ascii?Q?7Zt1JwprZEbeWnAWcpWMC1cQqhFbhirGC3miu2TwTgKFwIyCklKUd7pxevPX?=
 =?us-ascii?Q?fcsE0bU4HGQuaTvj7WJdoWMIGWDQqVeabaKFvwHlWki2J6b+d7dkpik6zUzp?=
 =?us-ascii?Q?uPoLASNAAUJonxVBA6ZhWim9ql0PTobzoN4NSFHAXQR+hcrhoR8zhhnl/Aro?=
 =?us-ascii?Q?ZerZ1Z0jvkZmKuM9EYKWflo6XcyEkvVtbUWovH0XpMSyc9mbkA2gj94qWc9h?=
 =?us-ascii?Q?eMS75GZ9p8h9rj0d/UNh76I2DSmzhklHKXy18sDdrKaMHL6Re1ec1wF4Gwku?=
 =?us-ascii?Q?N+GuU1TmwFrW0TSgaPgY80xYSH5KkV/kmsR3PE6K9fEHmGG93q3XJkeg3aIQ?=
 =?us-ascii?Q?9hDURQPPlcdJ/9KPnQw0GWCRitozof/9HPX0C9fAw3JT2KDB1+yDBmNsm4xS?=
 =?us-ascii?Q?B31bs4AmnjjAyBIj1tm7JbH7hRmmmXww7NCFFt8q86S7cQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o7bAL34Rr86htxqAJNzFjv/SfUvfI+jbKUesyDWgWA7Y0UuTLbpTocRuEXT0?=
 =?us-ascii?Q?s1DMlvZlMPOQZoGigrQRPLyjDGMrmx5+BxV4tz0ex19jFCRF/gAgZISJ5VBB?=
 =?us-ascii?Q?AArolad8MXTPDHUu/HJzv3rHaaWJs34SQCQvn8rQ/7Fjv8nH4xyOyDDyXB25?=
 =?us-ascii?Q?MQpZx5cea7PNt5u8tkxKZuQWB4k1GA8Lne2UX3ac3IviJsLo6/Yj2AKv+o7N?=
 =?us-ascii?Q?s/fPwnwQu+pgk1Jaxxv5ca3J+3mVXLYAMrQFV8MVD1zwZnaF75IOr8KIdXXX?=
 =?us-ascii?Q?UnwsdaGYnmKRYf2ctTKFN6H/dSEj/fvpv6vz2/Tap42H7pPMCrFQezLNIfgr?=
 =?us-ascii?Q?DihXUvExtvPD1l6QycdHXIH2Qg7WeDy4DVAS4GYiKgraAYjkFnG9L/PgbuGB?=
 =?us-ascii?Q?DuJI4s+OatNariWNktxaXlBcVsmoU5tKf5/R0qmL+RVInGKAxcEMQpW74MIK?=
 =?us-ascii?Q?lqEH4lZEcALpj4tHL0RL6b10gXU5m3mSjdAdhiDJMAnheFhfVDgbODAr0I/c?=
 =?us-ascii?Q?UYPAHS1rNARsK4WOn3St6rR3H0ltyO1yrRV4wkftjDoNEVILSu6AcMVeScMj?=
 =?us-ascii?Q?oiaoB38ZFqcUq1uUzwLDUrqPU+Ifx3iQe7v7b1eAAmuMHqBBk63MEUkRlggW?=
 =?us-ascii?Q?bH8s9f+H/5ghlUJjKWf9gaJJbes+83VeANyYXXU2BW7/xwD6+151YyACElUl?=
 =?us-ascii?Q?yuIaG4tNW+YnXxWz2vaaymMZSQEyuNcL3SBWXw+xZdNr/dn2MN6PkPYpdza3?=
 =?us-ascii?Q?NeUn9rgCYvzk8BhtkZjnDZQvwufn1Ftj8BiN7pt304Lsuo5xqcPxXAXyp6/a?=
 =?us-ascii?Q?MxpkzEqpDY3gHVFJKsstU9hFs90jcP5EhrFQvb32XriV0Y8C50CQi/vJ04W9?=
 =?us-ascii?Q?u7x4v8o0soV202G3gmBcwRcuEQAZDCNJOwqdzCOJbhXHT3GxRq81r7eEmkRQ?=
 =?us-ascii?Q?mUp7fLsFsmfzEk+0jqPSP71913MPoj3xm5ZH4WgP5iN3fvITveXRIIqjgXVG?=
 =?us-ascii?Q?N2Of8ob3s1ymFIfMYZ3H0JJAxAyVivIn/CLsLyFxmY39DMKhkPFMU/Wz3lV3?=
 =?us-ascii?Q?gwMQDSshFx0xTcIwgYe5hj+pdXRvnACnD//Cvig5hCRwthX3RReqGgFytV/H?=
 =?us-ascii?Q?GnxIDo8EDL3KXuXHoOfzMRBuh7oNzyN5RJCDYQ5kAAFa2Oem/yKHsrRJ/EYr?=
 =?us-ascii?Q?6aoV024PEdy8zF5IOKS2/1pPwzl0NyWTrmb8MD4RRZS/7gNM1NVbZLMZzC56?=
 =?us-ascii?Q?ndMIreUs77jXmUQOpYPow6jY8BsshRrEgqT8x1sql6tWJqi8cWiZQ+8s8YKf?=
 =?us-ascii?Q?Py1rrHEHoIw1WDlOUUJO7RXUla21bL8lhU+S1S5xnOKfKFm+G7vOS4UpoX2A?=
 =?us-ascii?Q?8Y3NckntbAByyKlAahft0TrLOimPJ15+p+3HD46osLOtH1HSYNrMANBFH/0K?=
 =?us-ascii?Q?JE8vdxLJsvhHqvPilB8El5nWZ4rclCZ03oFtJ4H+cRZkSrXX6uiZNSFWBf2Z?=
 =?us-ascii?Q?9ulvFxODcKIZtBQ/1GagHHZG/zQAb4PvJZiGQJYgHDEl7WPto/YXiyf4w1fH?=
 =?us-ascii?Q?yGuH0w/7YGSFHMOFSvphtMbXlg9WV4/Y8oSMgVDXhaaGVLj6BSKTSe9W9/Hv?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l9j9WXjhbHwAadCayLzHVddGJp8/4S3D6V+RPY4D/P7Dw6WEHfgNDHsoby4pAvdekM0rXC2n3MxeAimurm2xfRBcVlZeYrO9HhUesoOe7pQoftAiLpTnQ0mIgalvqnZ0GNhRJJNGhDNqkcZ5f5Vg24CeHqm1Uz8II5f4RT8a5ehNZKwvrNfQYaCHcUFb0rTDHkAcI07dQzErU6h0g99gBHKPxa/TZBYdRhuMyeQ+dngi8o9kOjnp6RPP6z542/9Hs92xCfL3pZBdiiun9d+cisfLRL7F6ITy+6fVpffeyL7YPTqhk7cRoTjIC59pFymjnxJlUs2N+3OFlfoYro3+rg2SOEgJMN9fvui99+Pt4nAQ/ne7dZKCF5qikuNKjFmADX8CE8Lin3oF/6nKPqJacQwbtY4q/gQr8+mGnup/mBENxBncmmU0EY73E0h9NV7mipdV3gWYIJa/wEHivUzmrPAnoXQgD423dYv+ok+9PKfgPVxHagijuTrA+zU4Erx89PhPq3aRTQdrLCqHGVncVfaDsIUty2TycyRpp8bvZw6CdlLGh2r5k1Ta2pfKrbFyCIvFKYVquOidtF08LSafJlBGinRSzPFcIZ/IzfpWHdc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61d1dc8-14e6-4df8-14cc-08dc957f53a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 01:28:47.8555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmTfg0w7wGxpIuEi6pZFWAI1tHLwQ3BGUK8Nn0MiiqDfUbKNXgMTaA/dRq+0MTfiST/+mTl00e8AzhmU89/OAqDsfMFFL8I/fY+SljCHn2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_20,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406260010
X-Proofpoint-ORIG-GUID: Va2MESJab62c_eFSRSeH45ZWYDR_itOi
X-Proofpoint-GUID: Va2MESJab62c_eFSRSeH45ZWYDR_itOi

From: Vegard Nossum <vegard.nossum@oracle.com>

To better our unit tests we need code coverage to be part of the kernel.
This patch borrows heavily from how CONFIG_GCOV_PROFILE_FTRACE is
implemented

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/Kconfig  | 9 +++++++++
 net/rds/Makefile | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index 75cd696963b2..f007730aa2bb 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -26,3 +26,12 @@ config RDS_DEBUG
 	bool "RDS debugging messages"
 	depends on RDS
 	default n
+
+config GCOV_PROFILE_RDS
+	bool "Enable GCOV profiling on RDS"
+	depends on GCOV_KERNEL
+	help
+	  Enable GCOV profiling on RDS for checking which functions/lines
+	  are executed.
+
+	  If unsure, say N.
diff --git a/net/rds/Makefile b/net/rds/Makefile
index 8fdc118e2927..3af1ca1d965c 100644
--- a/net/rds/Makefile
+++ b/net/rds/Makefile
@@ -15,3 +15,8 @@ rds_tcp-y :=		tcp.o tcp_connect.o tcp_listen.o tcp_recv.o \
 			tcp_send.o tcp_stats.o
 
 ccflags-$(CONFIG_RDS_DEBUG)	:=	-DRDS_DEBUG
+
+# for GCOV coverage profiling
+ifdef CONFIG_GCOV_PROFILE_RDS
+GCOV_PROFILE := y
+endif
-- 
2.25.1


