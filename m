Return-Path: <linux-kselftest+bounces-46517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 992C5C8A8D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EFF7350619
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D930EF68;
	Wed, 26 Nov 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bRZlIQH9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k2/nPBuZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD230ACFF;
	Wed, 26 Nov 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169945; cv=fail; b=j5ewxv6KyTDHUBLth+DklQLx2BoqhL1+igpoqDtJCFIgraf+JoTF1pMjo6jH6EoyTms7XZvA+gCab2m1GGOEjFoToC8IW8tndsQ6JcoL6O58MLYRCwAW3WBQPB9B78F9nTh5DUAqR1IIVO4wF/92yen6pio2KKTSVqonbreP2eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169945; c=relaxed/simple;
	bh=xpeBl/qcaBf8sqGot1ReXdr+Pl9n8KDdgq0CAXEegTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BXk9e6ldZjX1caKoRVR8d6phxMjNudRhAWEf7Flv1O/X8m2NOB0imDwA4SRyfAsCq1xaChoKhNDdvKFxMiMfgep3ugU4NU6e+rl5fbC8ihdW53UCsVub/iTLkWEgveOekIiZMnTttzShVawTXI3zkJyiUf0G+0MDUeRCT+K9iR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bRZlIQH9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k2/nPBuZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQF0X442583990;
	Wed, 26 Nov 2025 15:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qRWwrJeaqL+Hk2a4Gt
	e/k54tj34oQ5JEYVA7caavz6Y=; b=bRZlIQH9fxDzfWC9gRtL/mEiX9DgUnolzV
	u2jUkL1f4D0QdZVg0s1gypFig8KiTZnG3Z3mG8005S/s35JPYAQB0FjSuvmwYncc
	8dZ2dXmc44TNCVSLaecImtbgEIfJmXkPBXiVaL1Tp5vBmbeLKnKsvyxGFvdIng2E
	QbI2j4WiPv+jPAtYK10CUlvuHmGbSP7ggEcMFprVSTat6MbACvfGwg1Elxuswjy7
	Fo3IFCOFcEuxlt5Q+U1p8Vxe7aq12Rj9qjBopqvribqydl/3cxg8fyCZnTAfy8Jq
	bKVHCopbb0GGcMLWvYfhw+aCVf8UwTfPU+DPqSqDryCd5Alfjh4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7ycmfh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 15:11:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQE3UqQ032895;
	Wed, 26 Nov 2025 15:11:55 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mb3trv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 15:11:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0jhnOm6Hhy7D7l7tIWwDDz7exnPxGwMsq2QPTUAlGJH1Mn8m4EyflXIeMugeMo33b90DlHFWAReYYK4/zm89jbpf1yMDONzh2CduLUp6uScPcxBuxH4c0ZJ07j9ZtE3SMHil6jEf8Ak5LP+G3fo5NJjz4xUvYNEzs1iK5HqNN4qLa0DNTzn2FEovIoL9pSRI872XXnkNp3ykjFZ75inV3dbvKCV/XU6jq6K3TZeJ3L8QiMELaVcZsl59xm2Y2qsItqEO/WLeOat8juyBCHdpF9hJHmTFzUH3nM3bkgV65ajwa/DJIhBGUqe6IMqgKlLfbvSMhWeXVBj7ZAWqGjZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRWwrJeaqL+Hk2a4Gte/k54tj34oQ5JEYVA7caavz6Y=;
 b=j7CgojT/zj+ByXKbAnyAQcrIwopLj9SWEakMi45/+QKxekFtfgoDSugN8xoPjCOYRhn/PSPUZITfBkHtMkt9qk10f0P77eAq7z1p8vYu2U+dDHtkRTTSqsYopF3+XMDIjNOFxqud15xhO7FaJKQA+zg5ASznwJ5FmqDQcp1QN9dE/irOPp2PCW8WYuaKaoZd5TP/Qp1PTnTGEQEoMGmlmPCTe3ZqZsugkMuZo9fVzzhfZlr61rdhPgndHNeKCqGz/7+UqgqZHNxoyLI7+itfKyHbs7nbIc/N14ti86sidd9GtysmESQoq37hKcmFGZFcheLfJVDSeejORIoeLoiTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRWwrJeaqL+Hk2a4Gte/k54tj34oQ5JEYVA7caavz6Y=;
 b=k2/nPBuZzLSNI/erJKDsXjhXCeCZEsejPLG8rXOKMc9+dLv9BTWmjm8BoIWBNAGgT31aSOD8bas4OsMEoehlgpQhcCGHaO6Jp/6DiGfapHXX2K4SwLLV0D88sy5Sil9WkoxvDJSDolhRcvlgKBHJm/Y0sF40KSqJewkxtys/Yyc=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB6241.namprd10.prod.outlook.com (2603:10b6:208:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 15:11:51 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 15:11:51 +0000
Date: Wed, 26 Nov 2025 10:11:46 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Nikita Kalyazin <kalyazin@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/5] userfaultfd, shmem: use a VMA callback to handle
 UFFDIO_CONTINUE
Message-ID: <dgtxmr3oidq2uoehy4kg5wbcxwghnnbk2w4ilbd3imyqzmvtue@xoggdhie3ncf>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	Hugh Dickins <hughd@google.com>, James Houghton <jthoughton@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Xu <peterx@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-3-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125183840.2368510-3-rppt@kernel.org>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YQBPR0101CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fa1340-6cec-41ea-f4be-08de2cfe2076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O4uTnLfELKs4Xvu46acYZLzTrnQXrtnFNYfVp8x16cdOT0xa06K7nvpztqz0?=
 =?us-ascii?Q?yJPiRMx5yWu+tgTjb/07hA1IV8BIWuqxHstu/m/8niS2SNK3xpioEuF3Ncrk?=
 =?us-ascii?Q?a9aY8kzNjb0ZvbDAqnq475oJ81XhUrdwDJIQ6E22sl2hMktz25dtjgMp0U19?=
 =?us-ascii?Q?sh6gmyP6aIHJBgAqjCJY/jfBVpyFFjDUZaBN+A/IhEWg2Mt30Q29GKDMIrQE?=
 =?us-ascii?Q?pVOUbnZRI9PN0yD++2Fu5U49ajWJzMJS2ZGg4vse1cxWjQy4lYWV22ZWQpVc?=
 =?us-ascii?Q?f/HyAC/pqX+USbmpKcgXx+hqdDYL9xuJkxE5sjV1OUc0v2+Szjs68MN1uR2v?=
 =?us-ascii?Q?+pfwJtzhFibCzEr9buGDOrPaOVEWs+tehXrqwLFiaXvRDs4FLTDak03XX607?=
 =?us-ascii?Q?AQqqabyq3NbG42zGgvmdGB/9vzIghrONSctXXjdnQMtJVxKFtbPaMRZe1Mq6?=
 =?us-ascii?Q?0AW1EWGT3RGmOmGnPmPcmo6jExdEiSdNxE3/DpAjCAe5cofli3lCPQB6pR7V?=
 =?us-ascii?Q?fRUh0QGOYgU6zqIKphVhx70DjWlkU0Ezd/tNghIifcZCibm+Q+nTVPiyBiwZ?=
 =?us-ascii?Q?khUmIFHVYvEeCeH0K02+qjawqCnXTpRRWSSfV3oFueddqevDJZfOcA4MAdkK?=
 =?us-ascii?Q?xCszjPbQXUXKKp57wEep5YtOLEi/zk6C+LrYTHQSzlFgeM4x4akWtzHyK0+t?=
 =?us-ascii?Q?OTRSFWqNIm+d5aypEjQIwH0/6s6HGEo9NdOQehxl6GHEdF2AwXdq9ajvCVcF?=
 =?us-ascii?Q?Mh8V/7MzsqkYsknQgYS62Z7uSxqMyKHMMJBoMn9T6gj+UBThVTcXJcHesIBm?=
 =?us-ascii?Q?K0D0W7ILu+Lk2dR0OjxuFm2fyEylMmKq6D4A80EnW+XSvjxkWqbKO2dXWPb4?=
 =?us-ascii?Q?qh6D1DerG/OVX9+EVxtoJJAvgqQR9OuP8TCkbNae7prlRAVOgbkEEdtvYblw?=
 =?us-ascii?Q?cJDA9vG0C5cH92z3Amljbs3k7qX5kKgVgXmJPPX6F1zKaXrcGqHJAzYT2r9q?=
 =?us-ascii?Q?DSSXZu6+ZNNMJtcmbX5rRn0Zy1L9BIeffPPbPnbPolonUJTUcR4ZiGZRHOuQ?=
 =?us-ascii?Q?g4jOzcWK/A0aG23CDas58Cgn++K9xabPnbSjpZBbx/7AMuCoJpR3Igt5w6G/?=
 =?us-ascii?Q?ajaHHIJ2A6J7USdsYPkUPTC8ukHfc3uapnnJm29INg4q0GPMdixf3Penm+KU?=
 =?us-ascii?Q?By9DxxykBWDOILmTMqMjry3q01TCIBBTc6pdhnUslgmDpgxvPYedsowtwoGx?=
 =?us-ascii?Q?IJXXMnrH9hZnD94xYkQFNt87XkX668ay23liOsAwNydV+pX9Y3xGRZFU0qsI?=
 =?us-ascii?Q?TA6lEKYUmzZ9f2Es5+yHcsd+CAV4YnLL+G0zoOqYA14ROp+0zEzkV337aLwg?=
 =?us-ascii?Q?+3/BuOE8l4VUcsuWGSdXpieuEQ+Go8Pyl+hqiGMBrzA439fJXHmd82h9W77d?=
 =?us-ascii?Q?SVkvTauvtaX0asxkQwHmgaoQZKJIRdI7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xgd5dOoLyB+mTQVdFtYPJWeGAW6ySRPpriqiotlQTrnvRPwa5vlkQz+Lfq8Q?=
 =?us-ascii?Q?udU/yaoEknssdcrNu3GDjsl8iJxu0WumxXWXYTgXnBA6ti4vYPX8wcU8gds2?=
 =?us-ascii?Q?dvaRgUyENvbdwK5xR388m4QBDgzNHXHVlYcySkRfA+uuiBOrQu2lnNxIr2UY?=
 =?us-ascii?Q?iSOyyykG8+4gXJnoT6XYmlT7L4jOOlboQl5k9E2cUDwGozTxtYxtYa8Izmdd?=
 =?us-ascii?Q?K1/V+ngCyMahZyYRdvqvR/hUnDnL0XGKwlDKigPOq6uZLxSmfQw7AyIycuk8?=
 =?us-ascii?Q?xZUpd1oYndwxcF82pJOiHFCDwDtoT/V/ndluElxUv1PIHj/WNMFLsrtVKN6U?=
 =?us-ascii?Q?yqFs5fub+DxMCxrOLZjGSlCsKYVdpa8UdyqJxpKMYOb+qv2WiBtxmSeeOczk?=
 =?us-ascii?Q?MhPvjUtaYLxEpaxS/1RPM83204yNUxnivtKDB/n9S7mxqHQJer/vLaH/7a3l?=
 =?us-ascii?Q?FxfCxgJ4nuqllpRP5tCONxcX3hrml2xvFmMh35ACxc1GRrXZUpiflBMLrC+p?=
 =?us-ascii?Q?j8Af5AWDNvY2AaXXdgNw9/qtbGHgu5qpOOZTH6/nr3vj2xkrmlFiqKWTHE4j?=
 =?us-ascii?Q?cxPVvM/F41ptbA8ntUcx9mlEc5WcvUDRYOwIVUEHtKi8GBGuIdQeJEbVrWP3?=
 =?us-ascii?Q?aDGFbKSuKaWj7zZXjfWpCpSDTfx0byK5fBctdxOhek7LpXduUAYnHSR+GRsx?=
 =?us-ascii?Q?FrW/vamDcvbr7HWTcRqVmHfzHjWtx/MJhz6ujtniz0yBY34RAYXYD1rcqKR9?=
 =?us-ascii?Q?WsfHjckkyYR/4CtFY53fa77DihjFChKSlXhzYDpy7fTKLXZ6s0fam2eefPeB?=
 =?us-ascii?Q?TnzXx1q3DiBG70b0gtEgBlCTrOgg0VEKqFvQX2HtShKB+UJ4p1YCL0c+BTsG?=
 =?us-ascii?Q?4NTvFVpWOmMnMyC7HFj4L162Sbt3EWBViIWZZri2EloUyBk3fhq9D8GHTuqQ?=
 =?us-ascii?Q?GNYnexxg1gX2eXgZfAd2VfnhYCWi8OE/0bfYMkAFTdk/zkwBxkZurWda8Hz4?=
 =?us-ascii?Q?UJowsMJunZu43ChMeaGvpttovDvIc0Tv/UsQVEa1Aon4erV7CA3e0zcbcBoy?=
 =?us-ascii?Q?cwin3h1hZr73fv0DVyBjr9Vvw8UE3pl5wFEvkKY7/x/BKcm76roSj+y0/9ei?=
 =?us-ascii?Q?vPx5S0nlPhPajNgx3RTcbrEb/u0kSSSofBhxofkg825RxC/hr+TjgjBw25la?=
 =?us-ascii?Q?MahoUJh4/7Qc1a29rq/sO/22KV2TT4BkHWF1Yv7fPo3aYyK/01BNSfDmPg/K?=
 =?us-ascii?Q?IFB6/BeEO8viF50BTF1DfZep5200YElMaZEXKFZcyQZaX6v3kzXD7Dj4QFTB?=
 =?us-ascii?Q?yPnRuFtqRYItZunxYIhz5ja9Dbhy0by8alZNYQ2iGM0MZs98V2WwkDg+yFUh?=
 =?us-ascii?Q?WEvF7zW2vJAxOM/fSYIN1owqotxf2/4UuVIvju1k8hWYVg9321PIPDT1BTLi?=
 =?us-ascii?Q?5yQXPLyKlK5sJykFSTEjKHvgMTibkWzGQKOKyo409UoWpdx82cR304waUKIs?=
 =?us-ascii?Q?sp9PbWDsW2ITM60z8POOefxj0X/DCF3G7pmT3qNs7t4VMv75GQjndfjO7CcZ?=
 =?us-ascii?Q?1A1Wpe1/lUU54ovoI/IYTfyp3Cu1pB4e3fVBpy9G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pGdKjcBvCjVXnVnyVf/U633ESlj20q+b+U0Hg6V/voBf1XBEAlVIt7/uvFqH/Bmkgch4TKZbyHmIJ6BPFt25uTGNWCoo7bZS2LyldaYsWLVCVkOgfwNgb/b8mht/morbUSuyhbQAjTly7lzOICXFHBKMGf2O9ZgrUBhSoJFtvaeCYuIHSji996GgpK4GDbpEGZGGydA/cF0Az0L6CppS6rOFZoPZOsOH+S26Sx1FwCQMwJkw5QyzrUnkSLRJv0ETsJlQNPGk0oxjOk5Pd0RVmJtkmNot2wucWp1b22dwqBRHEhsYy2YKEHvKFZQw0anOfTeXVw2mEzD+EQUFK/xnVBg3JQ/ItAYmVg8tuEl98PvXkbiOfxNQm5lN3Og1jNriIozcY8w7wnHAvS+g4CzwmSkuJesOVoY7Ck7wfopdM1xJE8ow6F3tr5vN9C+Jck+XtICYdEGISUTQOAHRk8/1cJjdwvsDXd0Lcgo2fV8zS2yweeZvBRPvSuzLw6xI83ofWhynMjQTks/92Z4JVK5q+39+QAi0LmTkV/LGCysrnWm8RGowG23EcCUHEi2gxN9f+fFu4ydwuVIkueAeYbORaZ8tA0Jw4pQZaPbhy20RiLk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fa1340-6cec-41ea-f4be-08de2cfe2076
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:11:51.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH6gbEFu7fyMdBztQJFd6bu50ux0TjycDhVhd3UrRnhxvLbc9fAZfBiBQeCv4nps0XdqxaTIdFYspvV75ZMBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511260124
X-Proofpoint-GUID: 4az8OPc8kyVtEsFYO3c_u0wmErHHbwvk
X-Proofpoint-ORIG-GUID: 4az8OPc8kyVtEsFYO3c_u0wmErHHbwvk
X-Authority-Analysis: v=2.4 cv=RofI7SmK c=1 sm=1 tr=0 ts=692718bc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=tkcGmhNVzAUJoktrvT0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEyNCBTYWx0ZWRfX61gygs2of1i+
 G8F88K2t65tjcc8R5yS8//nVRrVUgXr8yh4pZBo2kUvvJ0saMV4+W3YuAQp+lkfv9BV9I0P9q2i
 Krk4SwpDVyps2S/gTCUsOuJj41APX5Ky3w7DrnvgtdQ1hJu81JJX489ZKG5OggnaxaqVVvaauk0
 bTfYO67VXcPqFngsxpYnTTofZYc4RKmjiVm5il9WOIVM+s/LtECRzG1Iz88GLId04teVomDNQ9t
 Np/orkHffB0yRbyxkTzkmrhoKvtbwhW+SRa4sZcVQlDIP6e/rWhcyI4fTwAlujrK4rxkXlvYJp4
 4LPX62nEbiCUXUabgY84tTKNPXhBRHcXwOzQkQesqkMHmsrZPyrx+sVjWbYB7OcRGunvlJda8+z
 6usiEdG3/PTOsYvM2tMhFf/VpLcJ2Q==

* Mike Rapoport <rppt@kernel.org> [251125 13:39]:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
> it needs to get a folio that already exists in the pagecache backing
> that VMA.
> 
> Instead of using shmem_get_folio() for that, add a get_folio() method to
> 'struct vm_operations_struct' that will return a folio if it exists in
> the VMA's pagecache at given pgoff.
> 
> Implement get_folio() method for shmem and slightly refactor
> userfaultfd's mfill_atomic() and mfill_atomic_pte_continue() to support
> this new API.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h |  9 ++++++++
>  mm/shmem.c         | 18 ++++++++++++++++
>  mm/userfaultfd.c   | 52 +++++++++++++++++++++++++++++-----------------
>  3 files changed, 60 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7c79b3369b82..c8647707d75b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -690,6 +690,15 @@ struct vm_operations_struct {
>  	struct page *(*find_normal_page)(struct vm_area_struct *vma,
>  					 unsigned long addr);
>  #endif /* CONFIG_FIND_NORMAL_PAGE */
> +#ifdef CONFIG_USERFAULTFD
> +	/*
> +	 * Called by userfault to resolve UFFDIO_CONTINUE request.
> +	 * Should return the folio found at pgoff in the VMA's pagecache if it
> +	 * exists or ERR_PTR otherwise.
> +	 * The returned folio is locked and with reference held.
> +	 */
> +	struct folio *(*get_folio)(struct inode *inode, pgoff_t pgoff);
> +#endif
>  };
>  
>  #ifdef CONFIG_NUMA_BALANCING
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 58701d14dd96..e16c7c8c3e1e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3263,6 +3263,18 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
>  	shmem_inode_unacct_blocks(inode, 1);
>  	return ret;
>  }
> +
> +static struct folio *shmem_get_folio_noalloc(struct inode *inode, pgoff_t pgoff)
> +{
> +	struct folio *folio;
> +	int err;
> +
> +	err = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return folio;
> +}
>  #endif /* CONFIG_USERFAULTFD */
>  
>  #ifdef CONFIG_TMPFS
> @@ -5295,6 +5307,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
>  	.set_policy     = shmem_set_policy,
>  	.get_policy     = shmem_get_policy,
>  #endif
> +#ifdef CONFIG_USERFAULTFD
> +	.get_folio	= shmem_get_folio_noalloc,
> +#endif
>  };
>  
>  static const struct vm_operations_struct shmem_anon_vm_ops = {
> @@ -5304,6 +5319,9 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
>  	.set_policy     = shmem_set_policy,
>  	.get_policy     = shmem_get_policy,
>  #endif
> +#ifdef CONFIG_USERFAULTFD
> +	.get_folio	= shmem_get_folio_noalloc,
> +#endif
>  };
>  
>  int shmem_init_fs_context(struct fs_context *fc)
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 8dc964389b0d..9f0f879b603a 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -388,15 +388,12 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
>  	struct page *page;
>  	int ret;
>  
> -	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
> +	folio = dst_vma->vm_ops->get_folio(inode, pgoff);
>  	/* Our caller expects us to return -EFAULT if we failed to find folio */
> -	if (ret == -ENOENT)
> -		ret = -EFAULT;
> -	if (ret)
> -		goto out;
> -	if (!folio) {
> -		ret = -EFAULT;
> -		goto out;
> +	if (IS_ERR_OR_NULL(folio)) {
> +		if (PTR_ERR(folio) == -ENOENT || !folio)
> +			return -EFAULT;
> +		return PTR_ERR(folio);
>  	}
>  
>  	page = folio_file_page(folio, pgoff);
> @@ -411,13 +408,12 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
>  		goto out_release;
>  
>  	folio_unlock(folio);
> -	ret = 0;
> -out:
> -	return ret;
> +	return 0;
> +
>  out_release:
>  	folio_unlock(folio);
>  	folio_put(folio);
> -	goto out;
> +	return ret;

I really like this part.

>  }
>  
>  /* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
> @@ -694,6 +690,15 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
>  	return err;
>  }
>  
> +static __always_inline bool vma_can_mfill_atomic(struct vm_area_struct *vma,
> +						 uffd_flags_t flags)
> +{
> +	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> +		return vma->vm_ops && vma->vm_ops->get_folio;
> +
> +	return vma_is_anonymous(vma) || vma_is_shmem(vma);
> +}
> +
>  static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  					    unsigned long dst_start,
>  					    unsigned long src_start,
> @@ -766,10 +771,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
>  					     src_start, len, flags);
>  
> -	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
> -		goto out_unlock;
> -	if (!vma_is_shmem(dst_vma) &&
> -	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> +	if (!vma_can_mfill_atomic(dst_vma, flags))
>  		goto out_unlock;
>  
>  	while (src_addr < src_start + len) {
> @@ -1985,9 +1987,21 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
>  	if (vma->vm_flags & VM_DROPPABLE)
>  		return false;
>  
> -	if ((vm_flags & VM_UFFD_MINOR) &&
> -	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
> -		return false;
> +	if (vm_flags & VM_UFFD_MINOR) {
> +		/*
> +		 * If only MINOR mode is requested and we can request an
> +		 * existing folio from VMA's page cache, allow it
> +		 */
> +		if (vm_flags == VM_UFFD_MINOR && vma->vm_ops &&
> +		    vma->vm_ops->get_folio)
> +			return true;
> +		/*
> +		 * Only hugetlb and shmem can support MINOR mode in combination
> +		 * with other modes
> +		 */
> +		if (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma))
> +			return false;
> +	}
>  
>  	/*
>  	 * If wp async enabled, and WP is the only mode enabled, allow any
> -- 
> 2.50.1
> 

