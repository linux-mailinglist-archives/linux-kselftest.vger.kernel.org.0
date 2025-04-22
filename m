Return-Path: <linux-kselftest+bounces-31290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB997A9665D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 12:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3A83AEBA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521C20C023;
	Tue, 22 Apr 2025 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gXgmig9j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yQWT5rqT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E01DDC00;
	Tue, 22 Apr 2025 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318872; cv=fail; b=aC9ybdVIbE45Qw9e0hQXY7/cDuCue8+mDIJ6yMN0eXmC6gDqyTCJxFffpA6Ph/yDhd/Dh2zuOuIFjdvw9/f3x1In1BgTyMQORx8blnsR0xtoxK0fE2cfG7/N9RWlqd6musLNaeE70PWFKuUgbzqn+5offcX1KYIZsLdZyNNv4Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318872; c=relaxed/simple;
	bh=3wo8vF7i/ClaX7vkjQoQg8y2+rfm1gdObTTv86qp+NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A4YLa+SxvGThsHwbNCBH685tP0qX9E1QA1hzmf9716hVPYpbfaw+pQ7dAzvyiKfFVjjdMawLlNhVcUTNfxyz33a3sJfPZrgV5i2BGzdW7dtt3Jqw32NO/zhWMEWdtuDt3vRTRIWtiMPgYjZvsTkEsE8KKKfu7np8F327FiodokE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gXgmig9j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yQWT5rqT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M7Mw0J027829;
	Tue, 22 Apr 2025 10:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9OpVB/B42rsBJ5gW9v
	l7bpbdzUkQtj5z2FkPWVhozmM=; b=gXgmig9j9kndZHnmr13GxPkWKl+tHaO7kM
	tNdrdTVKD75za6ze4qGiHqpsVtEyamL1EPZiMBJU8cqf87RKcMubHcu34T+UfZme
	IALUA02qZRTzvS2dwCw9zEK842ISlIOrRaroRc8EImzvP6rmwbD/xxUgX1ueK769
	UV9bwhhrkaKhWMUBNn58Zzni/cmGsncN9N+00iKsaALuM57KVUGxMHsPhbdzSNkv
	yO5lB6XBf/5NjpytJpeZSQQCAA8YvZue/2baG2MJD1IxyclV7JTkECJUXNdRCeCt
	S6zrMMBsWg3KPs+PQu/Fcsi2w2iU2Sk3QnzGx0FuwfEfRRHw3diQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644csv6j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 10:47:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MA3WkL010943;
	Tue, 22 Apr 2025 10:47:23 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013075.outbound.protection.outlook.com [40.93.1.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464299ptnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 10:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPmgY6c5LMMSV93kVFhmPLbkJgBAEBPTc1Skd+d4N/ZekT/OSKWEjQdRFxluRFVGTMbcRzO5lbSWtxuBOpW0VNVdsOhWi9upJuKeUZHQ4XCoXYYBuyu5xGHhXzMsp7sD/kirFA8nQ3qEB3DZYOCDLYBmO4g/fm19cZHKOhJ1t2TnMHhURXnws6zUAYXtBBK671aO5lkeknyKefvIPNv+NkIeLZrIy+KG6GoMvyOUsU7er3ERdOPGQY+UeBkxodA+7idWayMP5qsrLK0yTPCdZQvB7JezrBvHVde+HL3SbFbSpExh44l1p35DFERVXhoMbM9MGbauy2dM7N7OP1WfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OpVB/B42rsBJ5gW9vl7bpbdzUkQtj5z2FkPWVhozmM=;
 b=QsI9+0UzmlCMvD2cOqIML3PEmDem/jVzrePkrwQ99EnEP4J4MUXMlpfRMofELa6MiZbm99nPILvSbKrb54E8b9z+tEux3Jv9rIsJiflECqLUSiqrPaV1QOU7kVrfdH0tdFnsO4uZ8EpAKfSIJZ+6Br/iSXHUpdlZik3SqcVcl1/IP+3nfDPYdGXLooDKZWj1JacAluGUgYg8uUXNDRs87ZwijEnTm9pjAxtXmKHmSu45P9kjxdcVinsToY/aEaQI+Hu0ASIkWhTRh0vnEPQVZjDOl6gCP4fTc0FUagzmWtYblHVbD6xVzbYdc04lSYeKCHA4v2Diw9i16MPEF6oJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OpVB/B42rsBJ5gW9vl7bpbdzUkQtj5z2FkPWVhozmM=;
 b=yQWT5rqTJEiujGFe4sChqr5evnKKEpJrGXmT3Msxk9HqPh77grA5oQSo8WQKegOGy+4/Eqr9XJaeEMuZrP+9FAMqavDqYCyvMN8bLBIivfSVOIpiSfitjz2nk4WCpBtsoQkVKupnRA4fYMFj22icpanmrJFewtT2IpUtyzoMuYQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW5PR10MB5690.namprd10.prod.outlook.com (2603:10b6:303:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Tue, 22 Apr
 2025 10:47:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 10:47:20 +0000
Date: Tue, 22 Apr 2025 11:47:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 3/4] tools/selftests: expand all guard region tests to
 file-backed
Message-ID: <7d5e0f61-66d9-471c-b6ef-bf68dbffa614@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <ab42228d2bd9b8aa18e9faebcd5c88732a7e5820.1739469950.git.lorenzo.stoakes@oracle.com>
 <a2d2766b-0ab4-437b-951a-8595a7506fe9@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d2766b-0ab4-437b-951a-8595a7506fe9@arm.com>
X-ClientProxiedBy: LO4P302CA0005.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW5PR10MB5690:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff4db46-b710-4766-55dc-08dd818b0eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HejkpZlSusvsrXrW0MiAC19Y9E3vsPUqnpr4pZEQ/dFDFG5AL/AmtvBblspc?=
 =?us-ascii?Q?3jilYAZEXWRVjhpafN2esqsfwJ1Qgz9DL0vFgHQBtHefQ0WXxRD5nldrNrM4?=
 =?us-ascii?Q?b7/qZS5u7bEB5fta2wEu6yA67Ark3yEV3dOpjS7dcKjUeCmUtVOUKpzTDf//?=
 =?us-ascii?Q?P/ZwFPTF09BEYEjrRAu+IqeGiGV9ck4WSJMMrC+MdGqfhbDtcauiMpfl571T?=
 =?us-ascii?Q?Sq7/pm8lyJ8TcnwsUsHlRpTdlybXDSHuJ/pQsVAuZsEBdEfl4FSXD9VOe0oX?=
 =?us-ascii?Q?3jilwEqRh6q3IXeL+np/nADq0y/C0dxhdaB0l1nZDT3wxZh97ZWgo/NjJm/l?=
 =?us-ascii?Q?zcZIyEYv5VdQT8D7BG9B6O3N6oRVXOGW1+6lD6MWvVTWFmu7mSeo4gAzFDf6?=
 =?us-ascii?Q?es8YnEFYhzKYVK4RjLs+00etf5ZkdsBPmLFq+To0zV0YSd0NubN3tL4uGJNZ?=
 =?us-ascii?Q?ajeNC2doo67GfPX1DTkoktPTFPowrHCzEqlYdxeol2BrJuhOwFQZn9z+DlYT?=
 =?us-ascii?Q?xEUhG962zmKA2CTGkSHGKL2XnRLspJHuZA09x6aMk2dlqkL7W2vEln7kSBOS?=
 =?us-ascii?Q?d2CIKnZim7p7slNEfx7AzquvURdGJD7GpXCoHAXqLc0l6DpmFPlonuY+vBFw?=
 =?us-ascii?Q?zDkCofBAj1ntVPEaeRwfN7UL5n3Sg5bfdeOK7/uNqnMxfRXZLvKdkJAZxBnm?=
 =?us-ascii?Q?UmjcP319laGRE3x4mSkCLhoCZhzU2pJ0Bfx4GJT0g1gWBfQRD3Q8sPqOJyvI?=
 =?us-ascii?Q?bkFxVylwxwy2hG4vRom/JK+LTMVfQT69ZmySk43MmsGEsaiWsil5UJwPzELG?=
 =?us-ascii?Q?aZxVmT35A3um06XFB1Cni18Yi6KskqghkJafVSlF9o2vD3LauF2aBNqQRmxy?=
 =?us-ascii?Q?I785usNCqLwXqm+fWcLEXQaAQKAV1Odv7+EUak4yVXaQ2rYj+SuOymYiEeWD?=
 =?us-ascii?Q?YW8pqotwAHbwSSBPH5bxttL0OaJVO8FxHt5eLOYVvEPTwNLanEKqgPTQdA0V?=
 =?us-ascii?Q?2FhqK0fd1rzEGU8yX8A55yW4r53QdZDzz+fv5xaXqJYe+O9H6lBcNZ5+QMrV?=
 =?us-ascii?Q?Qgao9HRdCKKoDeFsNKrb6uFh1IN10orMFsuEH1r/4sQZrJtc7yCkJFgjr74j?=
 =?us-ascii?Q?/giz5rnELqFGryzCZHs/HonWeVT8HrVo2fuP2frIACpGQx1fTrvY0m1kx8tK?=
 =?us-ascii?Q?RDGjC5uMYUMVoeqSkEpkTJVM1+MLVN6+Ww9TM3oqgmYjh6PUJ6t4U9XpCxKr?=
 =?us-ascii?Q?x96Xvj/xjdJh11rmVErPrwf4ZKryN/GYSoy+9LgZRcF4zYeCZq380BBOXESe?=
 =?us-ascii?Q?5+Qr0PiWEp0RcRXHjv+wB7InlC1umXoPMXiCO92rNLzMGXVutwYUXXJss5zr?=
 =?us-ascii?Q?0YfjqavY6inP9TZZAW39EuPI+cViwCn52l1f7JrI3llmXjyXhW89LcfTxmJe?=
 =?us-ascii?Q?sQ0I+4Gj5xQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gu8J5sX9q7kHkFrX1Maa3cCS+p/dzSNNADo1RkxqPlfknDk3P34DlMDzPqM8?=
 =?us-ascii?Q?g5gzdSFLNvhUgYg8JOQdhEFjoJgh/40J5RJZE0+Mzs82oDWuWGEokst/C92b?=
 =?us-ascii?Q?E+iPZStCj6LVnP4DsK3YXT8qLwhRoaWghgp9vGBOPGbWRwt8nDpIa8fitQnN?=
 =?us-ascii?Q?F2fZrKNf1hz1oUHR4wKXm8jAqo6lKRSXNDNHvELUot8XI/tP6bo0wrMOuIi1?=
 =?us-ascii?Q?5dsFOSvSrHQGVqHsKFQUWDpP38BLmFXaUfXqEB2VS2zeElDQpMy2eEFYYqi9?=
 =?us-ascii?Q?V1wq3M7t76WyH+nnZ4mMjUroz5wxMGQof4puJOqOm6tRPBQjiJgkLBj/J81T?=
 =?us-ascii?Q?5xZQf7aBqXRPxBnb+qTchJu8iq8igJvLDQnFJW7Fxxh4MIrYqb569XPf5ljT?=
 =?us-ascii?Q?o3hNUCdnLFJ9bfZRzKwk9CP04RYUZGN/hm8r6WsPL/BQ498gpVgBhL47u56H?=
 =?us-ascii?Q?mC1S7GgyQL2rVgwVWCdeDd5bMrJFte3RV9uFk4vRAfBXIuHaEMYTLE2HHbnO?=
 =?us-ascii?Q?GuZGL/aPOi7NyevvQB3efExkFZbzh4t6G8XNbUp4LTTx3A5o1eFlTkXaZMo8?=
 =?us-ascii?Q?vCI27ZnOIiuiZ3qvbtBuxGJN22llFZ6WJp1OzWxKMOC+g7Xob8ZzR+BrqDYD?=
 =?us-ascii?Q?wpfze963JdvvkFHun1kpPLutO2NFQ2wHJ7Dheqa062sWUYrTkKHcT6N3ivit?=
 =?us-ascii?Q?ITN+3sBb45vSPc74McLdi6xlGsUPrx4ovpu2MtJ8ZEd2/n7Gr8tUYwc6qyJK?=
 =?us-ascii?Q?l+7ePz4jbcpcDf7XF2Dv+Fw4lA6ABVkPnTgbR9Ht6XdABe/mzBCr50yU3/UX?=
 =?us-ascii?Q?sjF8bMWnP0T5mczPh13E2pT/GB8VKm+ro+crFiXvo2/YH0W9S9mJ4t5YZIZf?=
 =?us-ascii?Q?5i5+kvVxdSmhqFAkA0xeMJoCPNZkQ+rpJOvl2K4FusmVg3cg/InsUCAOoleS?=
 =?us-ascii?Q?2jjUwvedbP07MZGDJqnU6jUotqk3rPamYtFhwBszrwia1AKpWG/E+FBYJBUf?=
 =?us-ascii?Q?oNbMjIdHPIp/68v0csB0ezCI/GNlxDx7LafYckZTJ5wtMzdTpo/twDFwDkxF?=
 =?us-ascii?Q?arQqZBosHa5uX6hyf+w2LxfGR5GqUvH2+FRwG5zgYZ0kClI/xEe+g2nHh1fP?=
 =?us-ascii?Q?pW4DLdayBPW2Qb+ilRlpvMScGEwn3hmtj+KXOZA6JeU0mZpKIFo9/Uljv79e?=
 =?us-ascii?Q?vnEw7n6IXmi0TLoIkPRsiJH0XJJIXiCmkxc83kX1+yZKShyEFSUqPV5LVWNj?=
 =?us-ascii?Q?9ZNq6iDGHX6Yeupeu7QJW7V8OqkPndoKvtlVSTCUENN0G1p6XICjWzzxG/s3?=
 =?us-ascii?Q?2MJPBbEKzmrESSsiQ7kVcCefnsNkvkfZqZl0OtWdF91KDmM3jUc108vvHpq5?=
 =?us-ascii?Q?FidDb9XhIa0swxDg/rPD+nAkRxc29OzI0xJqBoNTIV369FWd30t8CoSmUvX0?=
 =?us-ascii?Q?TTJrQMgAArbd6daAxRm4BPEm7ZHlF4puktT6s4BaB68hGN87nGp6xzsnYAOb?=
 =?us-ascii?Q?+0WH6ihJMdhOtl8jf6y4fNRfH3rlskNRfJT3uMbwmHBBsvlIodn7u1g5Wxz3?=
 =?us-ascii?Q?PoLHsRF1Qcw5neMOCtqyydwMdM1+XHNqqYYozixI56AMskpM6Y6++zTRLX1L?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EZfQbO3Z7vAY9XKfyv32DimeBOrofBx4GpPnCYz0Ef2thgrtfJaPdfwFGLbCfZgtPGjzQCRVWYys3TXJdJkPxnhEfo9mnwS+NmmZs5X6MvjhvDBpwdKoh0ic0xRuasjbAD5x/vZjHcHz4gB0IVeS/UT8bCKlpPrh/aPNRjUhLHvl6Jg5YAqQs+mU0AywVuQLRSMgMWKe4Oz9umWODdcrc8mmjBGF+FOrycUC/Gx+1jC/90l9bSOkIbSTTUMohAyqo2F/XEQAuf7C17RKd7Z4vC072eg64XOJep03JMPH6xKtwwAbvLBEfDR9GLtzfqXVDTSN9QDJyDKi2iK5Dekw8ftHVmigHmbDeCWDnT2IM7Y7EJ3JAC+TyZv3eSU9XvQs6WhfdkCYONOH6zf7ItvspsqQPBtE1oK4bMYDDrn8kZaBLC10qTUCXLIFpweA97p3E5ZL98SCZ9oNweZ40xbK9jx6hlaHgeBFUWYhWNQtSf27aCbzvluPSgSU9XfneHu0FBVl0jpmiqutuRnPRvBYqm9mQhrgl0V8L7ADMMrD5pbG7bdUin/PH3iO1t8KnZHPQ7XMKHIYXzUlqUeRVdykEezGTEBc6Qw9XG2S9NYt98k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff4db46-b710-4766-55dc-08dd818b0eca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 10:47:20.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeAUmrxRgKxl2qM05Tu186OF5pPy+sPbAgDCc5mJTylp5KNOkm//aRPVhWvv3DCu1bnNW4Y1eRwQY9L5YGuSOLynXq9OerGmt7blox60j8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=721
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220081
X-Proofpoint-ORIG-GUID: -jJbSctnn3-rEto05coHQmlegbuMX46A
X-Proofpoint-GUID: -jJbSctnn3-rEto05coHQmlegbuMX46A

On Tue, Apr 22, 2025 at 11:37:57AM +0100, Ryan Roberts wrote:
> On 13/02/2025 18:17, Lorenzo Stoakes wrote:
> > Extend the guard region tests to allow for test fixture variants for anon,
> > shmem, and local file files.
> >
> > This allows us to assert that each of the expected behaviours of anonymous
> > memory also applies correctly to file-backed (both shmem and an a file
> > created locally in the current working directory) and thus asserts the same
> > correctness guarantees as all the remaining tests do.
> >
> > The fixture teardown is now performed in the parent process rather than
> > child forked ones, meaning cleanup is always performed, including unlinking
> > any generated temporary files.
> >
> > Additionally the variant fixture data type now contains an enum value
> > indicating the type of backing store and the mmap() invocation is
> > abstracted to allow for the mapping of whichever backing store the variant
> > is testing.
> >
> > We adjust tests as necessary to account for the fact they may now reference
> > files rather than anonymous memory.
>
> Hi Lorenzo,
>
> I'm getting a test failure in v6.15-rc3 on arm64:
>
> ----8<----
> #  RUN           guard_regions.shmem.uffd ...
> # guard-regions.c:1467:uffd:Expected ioctl(uffd, UFFDIO_REGISTER, &reg) (-1) ==
> 0 (0)
> # uffd: Test terminated by assertion
> #          FAIL  guard_regions.shmem.uffd
> not ok 45 guard_regions.shmem.uffd
> ----8<----
>
> The ioctl is returning EINVAL.

Hm strange, that works fine <resists urge to say 'on my machine'> on x86-64. Is
userfaultfd enabled in your config, to ask a silly question?

It'd be odd for this to vary depending upon arch.

So a factor here is a _stupidity_ in the testing - does your system mount /tmp
as tmpfs or an actual file system? As the test code unconditionally assumes /tmp
is indeed going to get you a shmem file.

It's shameful to be honest. But actually I suspect this more than anything
else...

>
> [...]
>
> > @@ -1281,6 +1398,9 @@ TEST_F(guard_regions, uffd)
> >  	struct uffdio_register reg;
> >  	struct uffdio_range range;
> >
> > +	if (!is_anon_backed(variant))
>
> Perhaps this should be filtering out shmem too? Although the manual for
> userfaultfd implies that shmem is supported:

Yeah it should work with it fine.

>
> """
> Up to Linux 4.11, userfaultfd can be used only with anonymous private memory
> mappings.  Since Linux 4.11, userfaultfd can be also used with hugetlbfs and
> shared memory mappings.
> """
>
> But I'm not sure if that's referring specifically to UFFDIO_REGISTER_MODE_MISSING?
>
> Any ideas before I start debugging further?
>
> Thanks,
> Ryan
>
> > +		SKIP(return, "uffd only works on anon backing");
> > +
> >  	/* Set up uffd. */
> >  	uffd = userfaultfd(0);
> >  	if (uffd == -1 && errno == EPERM)
> > @@ -1290,8 +1410,8 @@ TEST_F(guard_regions, uffd)
> >  	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
> >
> >  	/* Map 10 pages. */
> > -	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> > -		   MAP_ANON | MAP_PRIVATE, -1, 0);
> > +	ptr = mmap_(self, variant, NULL, 10 * page_size,
> > +		    PROT_READ | PROT_WRITE, 0, 0);
> >  	ASSERT_NE(ptr, MAP_FAILED);
> >
> >  	/* Register the range with uffd. */
>

