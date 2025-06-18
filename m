Return-Path: <linux-kselftest+bounces-35281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77FBADEA9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE847AF7B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 11:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE3E2E2640;
	Wed, 18 Jun 2025 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YRkg1LPG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rKM0/cwr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0A2BDC28;
	Wed, 18 Jun 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246682; cv=fail; b=ihssRGKXxSRLJAeS+jlacnyygR63zlWSuLSJSu0fuIUoOrI6INStRNGayJYcTIDffJo67tQNtXdA0Nvx1ke2kl5UTbGLWw+EkDN11D54yHl6F9FnOGmEcY7t2WGrq+QdUyjXAeWEC2bdqnbtJY2/VBQGjDyYUq/Stgw1YgLPuug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246682; c=relaxed/simple;
	bh=Z+4HQhZ6BTFbO9aRhqCKMAzPZR51li4t3zLJzc6VJAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IaLEBRI8BOkbySJb9xAPojxmPI47SpnfJXSkhsk13QU8Weak46/ZkoULmXb4hJFetgYrUennE6OA8PJpoTkd7gwk/4wGUf7RVKO3D1RqPqFsBbMLLwooktUX31yAisCuhgbShxUl+egIVqSzSnKLYrd9eLHFHv3JQQhHGW/iox8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YRkg1LPG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rKM0/cwr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IBMaoi008662;
	Wed, 18 Jun 2025 11:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Z+4HQhZ6BTFbO9aRhq
	CKMAzPZR51li4t3zLJzc6VJAQ=; b=YRkg1LPGZnNMF2VWYy7KAMddgZ1n5Dnj8O
	5WjYT4Rkx/85d3hLufH9RsWrYc7VRmpdXL9uIeIPsW9BWbPzlOYWpSZofXohgaYt
	HmRLbmxtQ8ZIr9ul6YpVc0LPtkW1Fr0n5zNuNVyOjwOaC6wEpuSp3JPG1pAlLo5r
	f6tMu3gVL7RmuRBOrcsaG7rVaAU7+3zavOVPxP7Q8UhpFLrsLWoLEtSchstgaOhV
	N+KKwHEFFps34xylMHOE/C+Yn3lZ70662qC78YiMj9f63mAphqMQMKCPZVda4Hw3
	bbu8YsgBhOrkKRM1GyVvgTwzU1z5K0279D2iBtJX+Y2msKgjM14A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47b23xu3ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:37:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IBUmsE034394;
	Wed, 18 Jun 2025 11:37:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yha9y7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqIHNC+/xfsPFvGXdJiBjMq+Bv0QzkhwpzhV+iAT9bUVsU3iagbq5rSSVQlQSBLLR5JzjpUjok+CzgsQa/VpcjdAg2xzOe4iKxjc6ukA45jsgnY3BPhFrzFXp1nuOrmIzckYKZBPKEEtBqwk8NCeOa0ygQBmz/6YaiN7NnEiNwtj8hNlvtWR0FWlFave84DCKHOIeOXISC47STlI64/Jnwszt9SkpkveY3P868TlBmi3aTPoVTP2/BVRQjO+EGFkeb6FXmTNb+DcKHizGFkTgWq5fLRd03s5L2CcxfBu526X40MRy1ogJuyVfi7JDN+nAas/Lw+082+9aX2WCzbvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+4HQhZ6BTFbO9aRhqCKMAzPZR51li4t3zLJzc6VJAQ=;
 b=aNhy1dwirL96ZsG0uZlK9+H8o6SUBfeyCOiuIOawD3CACWRtBSQcWCubEqppd20w7hcShnPhUrgHCTkkQTyco8LGltVRL935zHwOllXnACohzdMMhsFouiRvT/ksRZvIJvHhEEGSScSVL9/M1h5fNKmM7vQNBEFHc4zquYQZyv/PY1MYrHWZxWQvXfbSt9c9zDwiDDF4qgxk4Tz1stgoVjIKexo9OTdANEOBDvvIFULVrtNGOC3UUWLnxjdqYeMoHw7EAPSVHX2/J+Uz4vnvO7lhfcf0jeLwEwUCYimUQcQMJRNm8ZWZr6XsluKvMSIl2W20vAMdS4PFrpqNLGdELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+4HQhZ6BTFbO9aRhqCKMAzPZR51li4t3zLJzc6VJAQ=;
 b=rKM0/cwrA6CcmJ2aim66g3r6tMcVxqL3lNcqvXu/tlLwzY2CA5Mwtlj1nJkxduQfMuKebYixNDYu/rvZ16WTWSjbKjPc0J8QEcCol9sx3oBtxelChkCXkrXW+ruxFXX1Yez9RZEjTC1U+dp93Ms4cYRL1nZcoIHSMbwALwADgk4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4808.namprd10.prod.outlook.com (2603:10b6:510:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Wed, 18 Jun
 2025 11:37:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 11:37:33 +0000
Date: Wed, 18 Jun 2025 12:37:29 +0100
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
Message-ID: <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
X-ClientProxiedBy: LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: f827acc4-a841-488a-1d30-08ddae5c8448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sO02TSYobjzNRyePQT0TJwJG7aLkTfB+Q1Ej3FiocJ8Q/9LVowWF2fmmmdmH?=
 =?us-ascii?Q?adcsyPbaN5rXgYRd1MuJWTCyW9k5dte9wQ4wpnvgJ51YkzhgXzyWsDbLT2LW?=
 =?us-ascii?Q?jShUMCuLoyYo392rQzPrE21+oXnxEeuQTnWFipJrRQMQZ7zuArggRsIS0SkE?=
 =?us-ascii?Q?q6jbu+oYIpne349djVsYlwNAeCIYnfejfKCW5KwJ353vhqHzsV+EN/V2QLNp?=
 =?us-ascii?Q?SG5/dtsie4wRC9xKqVRDMBRRZrOqcAZ4O4FYbpC7Hdb1yVcD/wBEwoyxdlTS?=
 =?us-ascii?Q?X2AFFzhUa8CEvsyAAipVJYgIYuG78Z4wvrGaNoKnw2ju0QUKijJA3tR21v95?=
 =?us-ascii?Q?m46kLjwQl3F/0NlP3Rpw6IHE1/Zq9gR+oOdHcT+uwd4L6AmwWnKI3WrIlMaT?=
 =?us-ascii?Q?oy5jLAEjVAlBub2eepEwJhaVkevwPRsF4aWSmLp25wghbEcLvpxGm3OdSYJA?=
 =?us-ascii?Q?Rq24k7e9qAupkejD8hx3TMObFYx8OpLKd9Rprz0hYyu6xcOvTrwnzhl/pMI4?=
 =?us-ascii?Q?yRvalKO3Dd61PvaN0XhfNLNh1QUTJEqDtf1L90rY3qaP0tCURgoNDP5IHCz8?=
 =?us-ascii?Q?1NQ4OBj5pO5Mzx7qWqaPiQc5HTqmTX30VIpVGTlXjEiLS6pcltoLjHNUC1E9?=
 =?us-ascii?Q?ZiVi/DfaiMXpDPIoQ/KD4iu7OB+m3XhpHPTLiZzbn2teKmMIyhilTnXR5TJS?=
 =?us-ascii?Q?nXcBlLvsxlp9Q/t9Q7bruNcQ32f5MeKB77V+CHi5+k2jU0WdLe8oWw9uYuVa?=
 =?us-ascii?Q?I/fkZ2B6QQSdkArvfcvoZfhHp6V1ozrYgF35NovAUUyYbK8zCGlB+AVkvuZs?=
 =?us-ascii?Q?6oKWgLzQWgJL84el/cl+ghFzf/ZcNIfAnVXJTgKOGU40a8QO/S8AWQEeVTgH?=
 =?us-ascii?Q?cWZDreCR2+OHiPeX0/BJRyypL3II6qVsodw+K9S3rNLK/oszM77IkVCGgjjj?=
 =?us-ascii?Q?YmlJbOPNLfLz3LkG4KSl/1lArIqTrRWw0hnBLlO0uEUs87zoGK0KeBZ3UuJp?=
 =?us-ascii?Q?Dxh55SeFcwfkgT3OKL9G3cUJgE6/GPAkt7bUtokn0osYXEmMJDR4yLL32E/e?=
 =?us-ascii?Q?367pL86RPsJ92hz4qYwl4mnS3zhJu/dFaOSt8fUXaU0T6IQqiKRStfBJ+wk2?=
 =?us-ascii?Q?+hTJF3R3XytNxOLwl/7cSH/fPe5VeG4zOQxUu7Zs8FEOQppheNqaucbGwzru?=
 =?us-ascii?Q?hWo71lYE9AI5zdvtVH7mqz4K4EXAzd5C3GfY+rQicZuqNNldGOsnidp737uK?=
 =?us-ascii?Q?l7M/OfuME6dSJeoHBSrc9KV2UFPDLpznM0bdnX6XFYkNwt2rUR073XjxIEZ3?=
 =?us-ascii?Q?/y2NXVHwg7g5s4ka35ACjs3deFFGG8J38Vx0r/nSLU88T/P2AjySIyReAwxx?=
 =?us-ascii?Q?a15uUHvu1dXFfaqEWH+0n/FTHUuOdXFm1OINzZTmKlx3B8yOjUQy2pbyTn9R?=
 =?us-ascii?Q?gK4+89Sv2oA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?70WyOFye0NmUx/EHvng4nwrR+J1SJSRipTTdKWkuNG6hr2w6gdYF2YtJxmB4?=
 =?us-ascii?Q?UAKSHHbVE67lCAH7MF35XNCyXYXTS04xBOd02qp22Nkby6Wr0hWzm38LcW10?=
 =?us-ascii?Q?5PT5Cn1teId7/52JMfxKZDa3LD1tzppqY5KfeK0SLR1Q6qiixq8kwDq1LUKE?=
 =?us-ascii?Q?RLq3tMtRsWNp6NCI8ev3mvtQIzwVBR38KWfWu4xcEsJ5zZvYeCbGwDU0r8LS?=
 =?us-ascii?Q?gUyD85qj3CUBUvR0YPLOJiZeDImzOWvLbD93Op3u+01S4y3/Vs2pUeKS3GD/?=
 =?us-ascii?Q?I9prf1JT4DnjnARQaTmjd3zoC7lLFHa/HuYN1IASwavU3USWz+1yf8K8FcMR?=
 =?us-ascii?Q?y6mIU6C+FjeZ5vdHUB71cYvSDenR05A0t5wCgNgwLrhDqVGjM6P0nd/6sr0L?=
 =?us-ascii?Q?x+2I1JL4bN3lMMgAqRQNsG7aa+qb30UIo3/MLlcPso9vz1zgJ3si4QctUhLq?=
 =?us-ascii?Q?h5Z8lNtZGjN3gIsbbMDG/YeLrkSyxv69/DGb92yU5XdamSoO4t/TtRUeCiEH?=
 =?us-ascii?Q?QDFVeToYR7lPqYAeSFhsGjZlQsyfyl7JdNtBNXsP5CNFmJQ9By93g4Wx9pYW?=
 =?us-ascii?Q?rRv23qJ1DtoTvBUs366EMx8HOLPB9IghuNVh1KRUnhdeWWZiRxgWWYO2Pl/2?=
 =?us-ascii?Q?oKANpR6SmWBsf0pPW+RF37ETa4HRam+jppljWFOECes50RL2CkgY7M0pANLj?=
 =?us-ascii?Q?mI2o29XO2+Ehq8vrnWX4gtAYOQ0UYUEbetyrzNBjTF6N7MsnYr16a1bH+SxZ?=
 =?us-ascii?Q?gtm9HdwfEXcCdOqLAEQ+WF6ccUU91Q1tRkZH3jY0aiyQkXKY+fQJ+cq/Ho79?=
 =?us-ascii?Q?U0IV3YELJnsVt9ZyOaw/Ye20WR7qoCcFXdYkgXTDuw7vjv98+HXDdkHzpurr?=
 =?us-ascii?Q?bDq6GJ4BXc1vWXrs2b4MiTfyn0TChl19OIoDjCGJbpoS8VHH+cjoadkoaDmf?=
 =?us-ascii?Q?74JFNJPKtAwtNoFc5yLeX3v4LN+aqKQTq5D6Ea0Vcnf/qg7UxyZtJzUfDwqb?=
 =?us-ascii?Q?aizQy0FvDp8TY++NZ5MR7Y8NDhLUPB8PmXU4/tnVFiQ0wkvyOj0oCJMipc0o?=
 =?us-ascii?Q?UD+KEYcDnXVasy9EuUvy/Xn20eAor/gx51NV0qiwqtygFbR5wJmD/i43EQVE?=
 =?us-ascii?Q?yQB5pDFUm2mXJjYGvLefJcFfnLUI7yq6sxXwtZVANdiVCHQpFKW6z2cYK8OP?=
 =?us-ascii?Q?0JlhBpDbJYE6IyF8TYjFHtI7SJ2nn36qa/1Uo0r7RLG1ZdSS4Pfz6Y794F1M?=
 =?us-ascii?Q?9KesBhRSUc6h8Vj/FCpsNCV2XGfCH/3HIumDBHvzg08/xwgV4JzHpNf3PhRa?=
 =?us-ascii?Q?dAj8DdXB0GN+lAD4o9Ct85NzuodW84o/qGsQhx1F4b+f5HOd4XKovVCZ7n8Q?=
 =?us-ascii?Q?ow8L+jaMw3e9/UDjj0f7vjd5XvHb6hHKGMzNJmK31QMYwPhpwCexmKdfIdLP?=
 =?us-ascii?Q?hMM70THOgoMCAI8umkWUh/SJ8ZfF7T372H1Nqa3aEzuwbJ295lysmiE82gq6?=
 =?us-ascii?Q?YFVc/wBnFPnqNQkCqiCA3K0d0wWC3wRlyh7dHRohL1mZ8uxp7uu3300pr0Os?=
 =?us-ascii?Q?ZOIt3LLsaI4ao7YXJ/LNPKqTG7zYtZzc3Gdbs2VrIqs7CPxRYJLiJn/aSEVJ?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eyQ/keJOAtKrrJq3AdsULUMVkxRDwNn8Opi4rMgbxqPyvdBniVKcIHd2VcXVI7VNFogcBrE/96Qoiv63Ku9lzwDg5WzZMbiu/w4RiveXY4Qgd19l5JvwVyVTgKq3L6py7Ymn4DJwhLstMTJItCZ9w0ZYxFC40pUSJu2+hbAZskEwDJQvr7r1mzuuaJy8M1zWypHavsNykFqbmk682MPL/cOhVSGrbXSIQ75QfuW4ajU+ud3BpR2NK5SG8AY+zVSCmuoHuIPRz5TfFjWGy/bvnjpB7d4yQmkqzmxVawYbNFJCxvq2PiKXw+4bUxwk4sM7XqD71eKrTMIhnwCfr4RPR0+WrZkpmjGOHCa/ZD+eJH5+J+UMDA9WpHY44M1MV4MygZtoOHPM8BZr7f//79osCuqKAT4Fl/B1sZV5dqtZM2vfKAyKtpiyh6sT4+XtW6cSEdcXKcNpe3YDIadKJ0iuIaMldI1/EFNxPb4Ib140GpvFe+8DH4Y8MDpjb8l5emZvu0BUoUez70oWroJt5FbVPvRQb18QCreKCr443VDwdZirZHDIYqwscpRTdnKq4yai+7BXXoVKkaqlvCq/9UZE/DioU2Orqw9cihzdzPeYa9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f827acc4-a841-488a-1d30-08ddae5c8448
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:37:33.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mcGOvO50TWhEyfAvODtc5WxeUgB8Bak3+luoE6yTdtO72g/CQoz4aohKk/nssKiyxY35RjShNsTq8Lre2Iy33S/2PalKq7ys9AIz0fNERo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=994 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5OCBTYWx0ZWRfX06PwkwW4t+qH kg+zdDsL4PySsV/quPj+ZOAPdOT/eeyb7scn+TJrXg/ThtLq4QlzAACtBHQ62Ip7Vr4juKhrowV h3mMQq4VvCX1Oa00fHd91R0hRzzdN4ShsWJIqYyVSN9XofLaWA1sqrBHHmcieY1OnhvFD7EqAmp
 1KmeQmk63okA3Vkq5V9DLK0z4jRAm7a7LnIc+X40Aih9BKz7WcnVOK24piTt+gi92wC40XlAgc+ X4S6dNhOraLYpzKhjD/vc2VZkKS1KcdmB/5SsRbC3xsOdVatMADyX0i3RD9IqY8eh+R+nREpAi9 AV1PC0wYPAzZNd31hyrBQlzzGHEcpAOLNF+//VAp1nquvzldI3Za3cCmh0N4QFKXtIY9DxRbcsw
 5zMpLHv6jUKYrEfse4XpQuuiUpbdH5NjNnXpgvrfmQTjaQu1qBe4XxsdiUQQcsyeCYB3Gjnn
X-Authority-Analysis: v=2.4 cv=DM2P4zNb c=1 sm=1 tr=0 ts=6852a501 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=TKLs8lymmXxHiOdcA3MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: IU5uUQjOM-CqDSGfUELANWbF5FUlJufJ
X-Proofpoint-ORIG-GUID: IU5uUQjOM-CqDSGfUELANWbF5FUlJufJ

On Wed, Jun 18, 2025 at 04:58:56PM +0530, Dev Jain wrote:
>
> MAP_CHUNK_SIZE was chosen randomly. Good to see it translates into something logical : )
>
> So I guess I am correct, if we can find two VMAs (except at the edge of the high addr boundary)
> with a gap of greater than MAP_CHUNK_SIZE then there is a bug in mmap().

No haha, not at all!! Firstly fixed addressed override a lot of this, secondly
the 256 page gap (which is configurable btw) is only applicable for mappings
below a stack (in stack grow down arch).

This assumption is totally incorrect, sorry. I'd suggest making assertions about
this is really not all that useful, as things vary by arch and kernel
configuration.

