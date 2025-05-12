Return-Path: <linux-kselftest+bounces-32859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE5AB3640
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 13:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6796F7A8446
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477AC25D548;
	Mon, 12 May 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDxHyBKY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p+1850Xa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB61E87B;
	Mon, 12 May 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050749; cv=fail; b=uuJ2a9e92ryJ2P1bSPU/ifkR2ErOLXvXUDTamgPtzn75hwVZquuKKuJ66elIbZTSdNG9bcl/5g+8xPHCp3hlUjdkI3bepUYUHrQlpaboUdUSBJ4uvIWMbyzVvpRJQpH+Iu6STz0srSXwceHXmUrs9gFlEmrQPHcUiWDng32E8hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050749; c=relaxed/simple;
	bh=mfIn9sHxgp80tHcrP5HRgL099pZ7G0OX9xiIm5i6mfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxAWcg/aKOenrsV0eWqqOE5e1tDEzfSq5QOmcTcpTAGx2dbShikDYyYxpVQbFpGvhK51aNMCjtZsGb4b3MRcGBN+QIapjIGznVbzz/jGZJx29NAZelfgLGK+5sNbpbH7ijb5dzfEp4B++gvJMmqEL+8sYXzcQdtHkFJa8ZbqAsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NDxHyBKY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p+1850Xa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C7fr77017486;
	Mon, 12 May 2025 11:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gv4ook35kpVIeEyE7t
	1jwAa8pfTaOiZLBIK6uL+xuHY=; b=NDxHyBKY9r0CTZm8tH4j/1V+xXXyXw5XCA
	5CsattGOxld+sAjhPYd2FPPBilhynHRzw7m+gPPq+RfXpKW6tFE1KXLGYC6TkBwL
	hWFPIUem+vJA8Vc/HElWVQ4nybrRsVSdzj14QdX/GSL8lwWB/Ser4lleHn/rLUh3
	tjw2XqjMSH/1mTqf2P17s/BAS4WvBLZe3cAS2OrbknSP9F6vUC4fRMTHhJcP6KiZ
	a6z3NXT9ZTHv8RPNVdogmAUoQzSarFuXVhW3nnVP1nyiEcBPGK8BAjBph1k5xmot
	jNwHNmTnqpTQFNRxg21T1MxkaDkzU32NNzcKGjTcdsRRc8OZE6PA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c28w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 11:52:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CA518K002414;
	Mon, 12 May 2025 11:52:11 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011024.outbound.protection.outlook.com [40.93.14.24])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx2x64e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 11:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKORI5dgehRAm8cCx9ia/ML9orb9ZAerCOHVj6BZ5LFUR96+hdiq1RmOZuZcv7E1X+4Ul+8QM51GSJfT/uZjC/rqeuZYsU+pfYgglPSXvT9oQbj92VCwU+fYNm5EDOEsip63hqE1TybNx4yzzTd3Hu13TWv9CGbCwebdc1qFFMreGUNmBvTE/nF3uizuGikq7O+HqHMVYVCAbTLDRsMM4hDbiS5u7gBk1pL5Fk0TRX6W04P/0oubHVNfDCoZ1kZDJmx4W/bEdY6aPYsFVXql+9hnWf9icockqY4KeQKS1VR1P9Zr2CQHEaSqxv0dzjL1o7RUMtvvkP20/nWnuoKZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gv4ook35kpVIeEyE7t1jwAa8pfTaOiZLBIK6uL+xuHY=;
 b=HXSwPfSWCyyHVcO9xyYRz3DnBA6Bu3RYz6pwC+WGw2RrO1f3tGmQ154zHXKYZ3vvMd15/hecd8vkF5kqsSG2Gm5DAqcuf6+hn8QCR9jMEsEwNyB94f/BV1HL3TmxexrAlHdq+UaJ3P4Y2RArupPzc63/w/nW4T468HhBj9HYZtNcrKs05/sy96o0X7Q3Id7iOnnt+FOqwSgkG0ITJdNWSiqwhxHLJ8XQgyrgIe9lRTrolaZrtPheykZ/423EBiJ4feBrjWTwLZQj3SPifjyJRuu4/J2aF4hEUTzZg8rSMADrufabTp0J5LXphjoCHfiUIJLZf+6L0+hklSpx8CcIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv4ook35kpVIeEyE7t1jwAa8pfTaOiZLBIK6uL+xuHY=;
 b=p+1850XaBOJTOs4jR+wXB0+fqV+XHckOJJfHIJsnFOua+7s676ZScTPah9JMCPlHOmj32TkuXfoCxcOljssaWuUCGZxETVHBqmNX/h5cKqj9Vy9gHtGheKAd+/esS/IUrbzIEqamFrFDZMY7cowUt+0PBJbBmvJsoUNsocDG3vw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 11:52:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Mon, 12 May 2025
 11:52:09 +0000
Date: Mon, 12 May 2025 12:52:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Xu <peterx@redhat.com>, Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH v2] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
Message-ID: <eff9451a-ab92-4686-97dd-a53d10da6bc7@lucifer.local>
References: <20250509153033.952746-1-david@redhat.com>
 <bfdd4a08-1887-421f-8ea4-d48eb0cee778@lucifer.local>
 <56a3ce13-f8fb-4f9a-93ea-ff77d7b109b1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a3ce13-f8fb-4f9a-93ea-ff77d7b109b1@redhat.com>
X-ClientProxiedBy: LO4P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e96c6a-4b63-4d79-f8bd-08dd914b6ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zg0yicPWtmf+ewAZuKkm3rMIeT8aJoR99YIYzO8t7tng0ZJOzSWb+PNyLd14?=
 =?us-ascii?Q?nhM2XKaIZ6pM4YwyY1Np7+Uzf7w84UsTlqRZ7/KyuBlAnb7zBOYpsgK73M9b?=
 =?us-ascii?Q?wu+aPziQcXwDJsUYR5becFbVBGFHU2aS+ekM7QWpFKMP8qjrxNIzs77pyg4A?=
 =?us-ascii?Q?j4sNHsz3N6BSo3ZG0N/pLPY9nbwvxfNvusSnAxDFue/6z4Zfvd2t7SOaqxIl?=
 =?us-ascii?Q?ARFqF6zKs8VPeqJ8N23U+FjOGPvbhc87Wnd/lilLj8AjGbLh6pGXyEHqmzrr?=
 =?us-ascii?Q?UlGLeU3XbT6dzGubSKEKW5mAQlN4lkWFDbPsNJ5++LuW7a6j9f9aB9WVrO5Z?=
 =?us-ascii?Q?+zu6jJ057cHyTGXbnZs6Z+rtqmG1besnghpuVXCk1YyFhC9gPCVUzZqnyLtT?=
 =?us-ascii?Q?jLflQcNHtk9o1F3yBqBaw5q/LoVA02/TYFu67wYGQKgrS3TCODQBJk31pL4Q?=
 =?us-ascii?Q?IjCxLuRr19TeqYIVH5swmIXnnedEUzU7RG+QFRMWNzgjKrNDLdvOOHaVcZNO?=
 =?us-ascii?Q?oYwKn3RW4j8z4BRq1NXQKBIpYY5cBpF6wuzAftn9Yn5UVzJBjT5NiTFDco/V?=
 =?us-ascii?Q?0QapJfZvbYagUiUtZGUboGLXl+g7HMUv0Sk2JXRo9SQnjyt/LggaA16NE5pW?=
 =?us-ascii?Q?tDtb0X0pbiBhNSm8Y74j5DudbnXg3JB9nYAI8vN5RPnJtejBBdTwmrjb9Ung?=
 =?us-ascii?Q?9HPPEICXTnkr5hiunJKZ9Hbzu69kWkJheC2E68JDuygV/7Hk1KcanNPmli6W?=
 =?us-ascii?Q?8egnXNCeA70PjRrE/CvQ8qUIOPGv+3Atedm06G4UqKbqy2VsFlryt+aEsav2?=
 =?us-ascii?Q?AQ/2p4vLPZh4a0RsSH7btrBBR0uU2BCgwWfmDUrazAFWvsGGUkW7P0MQGFJF?=
 =?us-ascii?Q?ar6OaE8qYCLu97FoheXnbOR2ihnfawshjo/huCbTdpykM1cAbKc4S4v/gGqw?=
 =?us-ascii?Q?3Ggx0B701olHzitY8HobKZGKqEa60zcLAAXrJu7XUme9h5l9yOC2Jzk7Ydcf?=
 =?us-ascii?Q?PKb4dvcnwj44Zq1FofUp0i+JL1hf1f82uMEXnvWqUodeL8YBcPHmG+PImUYB?=
 =?us-ascii?Q?yWYsi7m3+y7d6eGOP3OIWEU9Mb/EdVlVKWOvjRQJCNajgt/0mczps+am4ITJ?=
 =?us-ascii?Q?ryswgoE/kBmLzhhNDlaEOPP4cDBREBIFFbIEMBB2jQYLN8Tsw9uvOqLsSOZQ?=
 =?us-ascii?Q?y0S5KN24mL0dZTHCSlfAVcfqlnmRskSfzhjdh7+cc1WPIyF5dHY/CKeQgQko?=
 =?us-ascii?Q?lXDg5X1dEdMre0bizDuNqQjRoD2egdBdMYhTDq/PCHTpYHBMHZvTh+SwaBzn?=
 =?us-ascii?Q?/2ZkKnbHd3/pIRZo/HcMij46ln+tbjhqYD1WSM4qLyl8kJfaiionMChMeOxm?=
 =?us-ascii?Q?DIYxuUg0k8NMho+UkGZh3o//4p+t79WnVLpS/0gE3Nhtbw7i8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZVR2X5EsayVjpVdbL3KMbeqFY04j/txgfjrTjajnG/i8NYye4bjbNPDIDiC?=
 =?us-ascii?Q?R+OcbpHU/2I9OqriUMIO1dpxDXxyXqsb9o77M6K+dFkqHYpWCqxSpCsaY2lr?=
 =?us-ascii?Q?t1FafwX+fsvVy9FtM7P9hxStutd0pq6subTFD1z6r0vV7HL5komY1IYprxHS?=
 =?us-ascii?Q?rF1IaObtk9IqBseU5byfknVZlwrbWVLjz/6t8gttv/dAWouf09Cjb0Le1rqr?=
 =?us-ascii?Q?EUPGdVGZSI8GR2cOmOfcKog7SkuDy0GcrJuRkwWOkkaiWz5Zv6hlUhtCxknI?=
 =?us-ascii?Q?rVXC4ydqwaNvMnavC4nthai0R55/dBCiIY9+uhYUg1JgpsopM3Imf9obkQUy?=
 =?us-ascii?Q?3rnYfwt+FTTN3b+Rae72PR+0Lh45IHda5/mYjSir1gtFO4WLWQPyv0mKHdaQ?=
 =?us-ascii?Q?kkKCTFA+PECW9EG9GgNFTR5Fu5u5TOVyUgSTsg5qqMmot+JWZhWfRrg6dxJt?=
 =?us-ascii?Q?yUGKm2PRmvG8/hDvyXNPLDDW5FSKTMxQ6e1R7txP0wq6rkLP3Zy45+nqqv/8?=
 =?us-ascii?Q?uKO6b9sHC7euoL+oq9gtgZ0I2g5wZdIp6PndWlW2bDdeHx4sOLKQbpjxAV95?=
 =?us-ascii?Q?915a4bumZfJ0pg2eJ8GiiwCSoMgFrhTQ2EDn/OJh8x41VZRbt+5gJbUTlBEp?=
 =?us-ascii?Q?9mAI6Xrz8PCFW1t4S1FMGfbmbepyuSmWZg2q2/WrtdVqlI92lFVYR4g4B3b2?=
 =?us-ascii?Q?P1IoOS+pzIhWneEhxqmHnIDvGJWMYd8uUQVR6t+UW1foEHP/7AUkpKyz//cI?=
 =?us-ascii?Q?vzvHX0ZqEonfAGt8R3SNCzNN4vayZxylaN5ii7lfmikODlPC8pqPnOtFeQ36?=
 =?us-ascii?Q?jUttLIhL+WJtm+/Tm+H/2QI73tUQPH+PsdTOnoEyzHvkPNarY1zEgC9YcbNR?=
 =?us-ascii?Q?4IG58cvPToAt4il3V/+E3syWUOSFHb16KCjz1GimYsT3va3L1cpnzZPlreq1?=
 =?us-ascii?Q?KDPqwU0AAr0fHa8aInBkHOLC0OtB6dcoR4dkFRGn8nJf3B8ixNztRQsd0tEi?=
 =?us-ascii?Q?aXciFF6EXvSA35VycSr2NXFoCqY+uXFiI+6IwZfM8Jq7pYHRbKq9q8+Bt2dj?=
 =?us-ascii?Q?9M/4FOFMXOkqyGWogkai3V03GCnBnaQaZRP5OzJTDkyeVNbA6Wk3xc4PjOj/?=
 =?us-ascii?Q?P/pyj+tn7DL5UZl6et46KrSQONkjPontREGGcocpnbASnRck86cKjNne4KiK?=
 =?us-ascii?Q?//EeBJOOycSqff4j++MWuKUAuidYmVr5YRjQxHyKT9KoS5pDrXuj/gmxv24o?=
 =?us-ascii?Q?sXXcR1mCqZ5zTBQcvvIdjxWWidyzRzIKQQMTpcCIYNFhfw6bysRkjwnaB3ZY?=
 =?us-ascii?Q?HNBzEghinxq1aD9Jo5m6rHil7YKwk6r4ZRPCfT4GFiyn43hERn9JwTeNN8wv?=
 =?us-ascii?Q?rf+810v92cZPEssV2mRUU3Pao8yC9ctktjRJ8ZiyC+tKP9tqpjLFxmQ0bByd?=
 =?us-ascii?Q?YaMvLJQX840MTrNfryEenjK7VLaBpw4spuBMXLOr49UQvfu1fnKNtIyThD8c?=
 =?us-ascii?Q?9RjmEWzSZ1kmYbeQq8YDQi3Piitpu0Sv7sVx58lum3CpBt56TRpwoIJmNo4U?=
 =?us-ascii?Q?FdTnQ/se8Wob4TnQG9wVoM53d0P552rI5yiT10NFTIGat4PmMmGoW8N/mZsd?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NHhlHD5Qszcbe1g+6QKXeRXkdUyJZoZC2JwHIwy1brqN26AJZtaptbtRqMkWUBAlqYsYcXV2/sc5PPRWglGyMIT/yZW77HrXCbvZndEQghfixCPQUIFRMeF+Cev/t6oW/EBbLuUAKJDPE/393oqO+jd5jD3L+fd2EcplNve7Gi9lh9EolcDEnAst02PGIfjhe+owfRqIwoNwkdPB4qNW7Rd3FEHtCMmG1AjbJV7N2A1i4JSO5BHy20IB4Oa1OViQIRLXidnTEUJT5TWJ8TD2N9+xVry5EmShvDTD4hzjc2/Mm1IV8S7VJvlteO6tIp+EItQTGkEvHN3y22jUZX1LGCe7IxIFvtXpzGoH1+aLUJDyDX9NZ+Jf6OT58Gi2zSy+FhRj0sJltWF2O9RRkQqRwynmzli/vROFwixjdFX8ou+nGKx12SEzHkebLacxkRozJFCKy1mTxq17LFKlAUUlZAV0HX2hMEddDZXC4r5MTzpNm5dz2KwZsIKe3u2sEYlyr/0Asv5FkEiFACy0pamWVEoFW7owAVYTsH6J7GfUrwBfy2PSg5ePnaeKP5xLLlH0jodgYAPg8Nq/jgn532bgxKQpsjcpT18CnRSfwajdGbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e96c6a-4b63-4d79-f8bd-08dd914b6ccd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 11:52:09.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o52Jm4GZc4f4gALwS0qUsUXIupO+g0gxSVTGWQBhVOz1/RBwhpZl5E8HohOWRV88HLzDWM2F58WhQT7vPfBPLtdsPa7Prh6+jr9e4AHeoTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEyNCBTYWx0ZWRfXwhE/CYpNZiCX qnLYLu356UE27eST/gB+RV4J48yqKTn7bjIcpivIF2bT91tn2sUdi0Poz+Da+z7w4mMgntIG15b 74fTlJiQta38NjsoYzeZrjfIJmrTNqTOsa2YjQX0L2gV0QstIEoxV0sJbT0AxhHFD1khgwpJVHz
 gsoyyKcm4uKIWathlqsL4zJr0X/y0jMUfe6e38gGayx/KRpcTLjaDjsNOpRxibtG2jjM9Nf97Ny HZx5uh6Rie8cXSei8AXuYmUjKtK9Mn+fTtH5hnbmyNmFd1LUN0nIoMLJaF5V+z3tzijcT7X6KyM KbANc4Id0qETv0WBFbuw+gnCSA0KmQtqrPK9iggmshshzbTyPcHvjomsvm5xYtyMHNjbHF45dw4
 QISYdX80CPixP8okSbz66Jx9zM3JjCecoZpVE2fFjUxiD1i+UT04p9Ow4iSiLItteDjToeVd
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=6821e0ec b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=E1YA8w1r1XZrqKQUSZIA:9 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: SCMWYfAX0BiPP3SlLJvopNhV0KXr7Rpd
X-Proofpoint-ORIG-GUID: SCMWYfAX0BiPP3SlLJvopNhV0KXr7Rpd

On Mon, May 12, 2025 at 10:18:05AM +0200, David Hildenbrand wrote:
> On 09.05.25 17:55, Lorenzo Stoakes wrote:
> > On Fri, May 09, 2025 at 05:30:32PM +0200, David Hildenbrand wrote:
> > > Let's test some basic functionality using /dev/mem. These tests will
> > > implicitly cover some PAT (Page Attribute Handling) handling on x86.
> > >
> > > These tests will only run when /dev/mem access to the first two pages
> > > in physical address space is possible and allowed; otherwise, the tests
> > > are skipped.
> > >
> > > On current x86-64 with PAT inside a VM, all tests pass:
> > >
> > > 	TAP version 13
> > > 	1..6
> > > 	# Starting 6 tests from 1 test cases.
> > > 	#  RUN           pfnmap.madvise_disallowed ...
> > > 	#            OK  pfnmap.madvise_disallowed
> > > 	ok 1 pfnmap.madvise_disallowed
> > > 	#  RUN           pfnmap.munmap_split ...
> > > 	#            OK  pfnmap.munmap_split
> > > 	ok 2 pfnmap.munmap_split
> > > 	#  RUN           pfnmap.mremap_fixed ...
> > > 	#            OK  pfnmap.mremap_fixed
> > > 	ok 3 pfnmap.mremap_fixed
> > > 	#  RUN           pfnmap.mremap_shrink ...
> > > 	#            OK  pfnmap.mremap_shrink
> > > 	ok 4 pfnmap.mremap_shrink
> > > 	#  RUN           pfnmap.mremap_expand ...
> > > 	#            OK  pfnmap.mremap_expand
> > > 	ok 5 pfnmap.mremap_expand
> > > 	#  RUN           pfnmap.fork ...
> > > 	#            OK  pfnmap.fork
> > > 	ok 6 pfnmap.fork
> > > 	# PASSED: 6 / 6 tests passed.
> > > 	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> > >
> > > However, we are able to trigger:
> > >
> > > [   27.888251] x86/PAT: pfnmap:1790 freeing invalid memtype [mem 0x00000000-0x00000fff]
> > >
> > > There are probably more things worth testing in the future, such as
> > > MAP_PRIVATE handling. But this set of tests is sufficient to cover most of
> > > the things we will rework regarding PAT handling.
> > >
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Dev Jain <dev.jain@arm.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > Nice, big improvement!
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks! It was worth spending the time on using the harness.
>
> The FIXTURE_TEARDOWN() stuff is really confusing. It's not actually required
> to teardown most stuff (unless you create files in setup etc), because all
> tests are executed in a fork'ed child, where fd's, mappings, ... will go
> away immediately afterwards during the exit().

Yeah, it's maybe not always necessary, but stil handy, and at least allows for
strict cleanup/separation between tests.

And having things structured this way makes life much easier in many other
regards, as you have one place for it, you don't have to manually fiddle with
test counts etc. etc.

Overall I think it's a big win :)

>
> I still implemented FIXTURE_TEARDOWN (like everybody else), because maybe
> the manual teardown can find other issues not triggered during exit().

Ack!

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

