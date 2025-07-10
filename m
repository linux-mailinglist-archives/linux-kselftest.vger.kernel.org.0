Return-Path: <linux-kselftest+bounces-37026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739A1B00962
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1818516BC08
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B62F0C48;
	Thu, 10 Jul 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gIyJm2uI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="poOhFCLo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23847285062;
	Thu, 10 Jul 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166688; cv=fail; b=tQCcKfJuQ944vFnXJuqnFpeGZpIS/x9n7ZWn2jU9ekM7uG+mf7hk+MVRbVyXD3fjMVbJNlGUe/I/EEeEgp13YU6kE/Xil/xYegMboxJnn+NhbEYUf9AH9tXw9J2RNAkp5UV+6XNcbbpRX83bVvgu/aPHM2rz1nIV4VpuLPGHG68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166688; c=relaxed/simple;
	bh=Z6c7lyS0MMkITatvSjcD9Sy17Bq0p/cBVmkr4uIlh3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CdIFVjP+Y5w5sAOSKSfTqsHURUu67jsE4UizSl4JezePWfIjfMD5h1wbLHnL1DRBJpsBFQ0rz0wHb3j+IlgYqNOj3+wwxBTBbWwdFMt7nBc6ey8lFnLWwhthd7RMOeDNYYz66+/E1Y9GC/EHpcBwqM3rLCtPAwsGdYMjncWMatY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gIyJm2uI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=poOhFCLo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AGMTXr021467;
	Thu, 10 Jul 2025 16:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=StBvXGscybz+MdmwVB
	BCwl/HLmLQIlsq7nbEybF+sDU=; b=gIyJm2uIc0E45CsduvSLYAEnf+/pHhmQsb
	t9OfzF1Zvw4LbmhMK2NfHfszyGLh0yzNZk+tw82vLwmNt8vkyywKw0okNqguJ467
	cqdtmUFN/LD+WkKgQC/drvAYM2ByCjcjJna6Ig5ruNTMtW6CuZg/8NhtoWCT/bOU
	2d9ELRXLnXC+A4BPjO0wkh5zgMtRjGuMott2FEHto35aw4GvByTUxbUF9w9B48Zb
	bVfRxgex7D+qN7ZOKbdZYYFatrLszd6wCpRZ49356f4uwA3zx1LX1W7NZjz7Mynf
	Fnvh0gNa+zl0nT3oZD2PJoWJU8XU4XTWlptyoEcileqvmkuoA06g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tgym029t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:57:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AG84JW021405;
	Thu, 10 Jul 2025 16:57:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcgv7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:57:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeJLRXimFgDFldYaVMqAkSwm208aArr3TyhYByUO/v2OriebZeS8bbqcNwgMrNsj54eppdYyVwqUkFXC6zrVyaLGGv+wOdJwLMw/SE6lOFXvCzTDU48lvfq8ZuaKOrZwD8bK9/4sSyasAkIzWA6eZc6E8QoOmti/fK2fnDESOxPzRmIa3u01syxCWA61DFRFqQgqjKoDXZ2igM6eCT7PejEidAvuiuA0sHyCYatV9c/VS9SQThu0hyXklx4ASgmmMUSkYD8qAOgdEzI6FbqmKrGjNxVCaRZRAfzMWUisHO+m2FIL+cf+A9/r8NejMgHgsUb45LQyQhaa8E9uDO3IDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StBvXGscybz+MdmwVBBCwl/HLmLQIlsq7nbEybF+sDU=;
 b=DjjQ+WCLtIERo8Dmd0OaVHx2oy5rta5Wip/ElF8HzeaCBHxt2bmxuD8K3sY5JvT+2HZJDeoPiDS0pAwHLEYp3ooEtSvjRGiovih8ncCaNXmFrowAaEWOColNjwBLCepNPUGv9HFLTFj09K6XXNJzBUkkOHXd8lxI59ndtTrqlaLAiDQ0xofeR8FrO9vHLtD3vXQEcW4hdt57B8CO+MNa5Ltt6tReiDJAMtEaWx1iFkqF1GB3K5hoqlKGjhAXnNy1qVJGnU6Jv0+BPPXGN8mGygQOOlApWY2q+RIDMM2zl/CpmJIPRFccYeESftGS7j6Bd2keleNLorIUNovZOkxWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StBvXGscybz+MdmwVBBCwl/HLmLQIlsq7nbEybF+sDU=;
 b=poOhFCLohEWBaqOkcwa6WKzVQQAODiiNHtrNFV+SMvpEnFFLN6pqLCWFA0osIgWZJVocfaa4U1CXtYiPNBvLrslexokXuDEkdvWWGj+e3VpKAGGkMWYwWxYHvxpgglfBO4EbGd+elvRDYItB5kx6106p91kxnxRK0a/y44RhwR0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 10 Jul
 2025 16:57:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 16:57:26 +0000
Date: Thu, 10 Jul 2025 17:57:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: wang lian <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, david@redhat.com, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, broonie@kernel.org,
        Liam.Howlett@oracle.com, brauner@kernel.org, gkwang@linx-info.com,
        jannh@google.com, p1ucky0923@gmail.com, ryncsn@gmail.com,
        vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH v4] selftests/mm: add process_madvise() tests
Message-ID: <81f9a104-6d7d-4552-851e-8690d4a1b723@lucifer.local>
References: <20250710112249.58722-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710112249.58722-1-lianux.mm@gmail.com>
X-ClientProxiedBy: LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b7e83c-ae76-408f-5511-08ddbfd2d933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NPye9zVmehRArzcR63S7c2Vg//NVSFI7xlX/ad6DOtXqvHS5I+4j3WTKOGLn?=
 =?us-ascii?Q?8jUzXoAhxoWWduyNp33TZWF75dp86s06bx4MTVbTb5Lpdk+bdgyAJKr+JRoc?=
 =?us-ascii?Q?uaQGp4EHBwM3F5QN9KCRW55D85qKSiS6iCD4OvTzX/1aXUdiqVYCLclZ8RZ5?=
 =?us-ascii?Q?I7sVq9yauRKPZKp9ICfkEm9dKnVbs7zZ8C05dbBybAj75CdMqbqsJdFWdcAI?=
 =?us-ascii?Q?nxoaXI9qb5OywY0KrnNDi9jdFHtldkuUqvkZBY3n7MmY58wokAonR2A8jLea?=
 =?us-ascii?Q?lBNmkxMDW4fQDYYrfxtGd5F1rc66H54vv/MrBBxAN1tvPAt9qaDsUHtV+yF9?=
 =?us-ascii?Q?AW+rONAjHk5G8DTKFj5iIpOHFq//Cnd1vLQPZohegXdPdB9f+HEL+O6IgCTn?=
 =?us-ascii?Q?8VCzWuxOUSkARtWTs8HclrditBuX7TAZoLPmN9/wfY19RWgS3OuMTIFyy9uD?=
 =?us-ascii?Q?WU6ZAxZWsoiNRzCJG3t6MmUSxxlio2Lq+wwBRpCIzkN0k2pJ1ffm8TIcX29x?=
 =?us-ascii?Q?M7h/81SUvPqbIZgebwKoZGbp2xyL37EvhS054oLmKmpFnSv2LAvB5DLDIU4I?=
 =?us-ascii?Q?pgD07NOlstmDRrTi48kIPxkts51sK/U8QFAmHC7Uks2A0/3YrAy0u5qH9rR+?=
 =?us-ascii?Q?UslOcgoI3O4GJNqE14nJsiT2PuX/bAr572Mm0ZC7dPXkEKpVM3wihUhBXIu5?=
 =?us-ascii?Q?UDXShpTvRCv941JdMrGr1Su4L64gqHr9gkqVNq+WF4RJ5yaQuOLGwjVY5cWf?=
 =?us-ascii?Q?C8AMxmvTVyvU11CI94IiZvD4gJIPE2aOpD2FJ8ld3kHWxUqUqgsNKG41KTr2?=
 =?us-ascii?Q?2V7qQKV1ZBQOLGZPb2daK19m+awNkMCFSiwYqkTpxXYZlGxmeHXqJg/3rNIv?=
 =?us-ascii?Q?CuIaddzHXcMKeMS80ljt36SIJlYDeqPCW5BB3xODFHBOgaWq19hIWNxqV9lB?=
 =?us-ascii?Q?Nh4jNGeAXjzRehywKzGnGwDg5lsSpQCj3bmyhr0TEHQP/iun5yXM7kGY5jv9?=
 =?us-ascii?Q?nSAJd8F+XTYsUzFQfggStQmjJrB760dBwUHModiX9hw3qgBSEAPQCL8Wrp2F?=
 =?us-ascii?Q?ymUetrISphirXHe/JJEhwBi4/Dm9sQ/dwymHhsOueAxt+JRG8A80XKX9pSM3?=
 =?us-ascii?Q?gSRi+jHi/H1sW05TdBI2GuiiUX8CLge2oYYNysGTWhmxtZxRotbebz5ZYV0g?=
 =?us-ascii?Q?0+dpL8DvL/CvM0cpe2vjC9ViFzeTZtTAOwUSH47ntTVTxV5bW6eA6ezpt4N+?=
 =?us-ascii?Q?GolAgs6/iyQFBH8qW/F9pg9QiDFkstlIU/FrPA58ekG2bvFghhZ7C6eE1ttU?=
 =?us-ascii?Q?G4yAoxodmliFhI5qBfHsO+JADS4FiBsJXfEmBvBDSHRspmhq+uhPSIrkqUmy?=
 =?us-ascii?Q?SZJjcJllFat6e9CEZt0CUCNOUp6Ba57tJgozlq/Z1go7895J26I8d3/udOrC?=
 =?us-ascii?Q?KWG/pQthTGLJxvo5l2e5PxuwW9CvRO3X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YmaXH/IG8Hq+QXZ/O7Plvup8sPEvJntUojSdltxKKILu4hT9pDfHJ/C/DkjQ?=
 =?us-ascii?Q?DvIStb8j8iCGX6xaiwUEsdW6VLIy0gCQjM45Sm/rP1ZObGX3JOnLV64wPg6z?=
 =?us-ascii?Q?+FC1FEq6g/CHIszmUfskmC8efHt/YK58j58zUvcbEuGcnEKAJ9CjRE6PnTR4?=
 =?us-ascii?Q?D7U0vNd5dqDUoRrT2xntn+3OV3Xa/LMNdAMgflMw6AM50wMz3HZaJCFcOBYy?=
 =?us-ascii?Q?6JDyWc5hF7cdh93QQ2AiNy5NkDeiVJXWq3PZpie5Kl/mFokUiDLfP58nMR6J?=
 =?us-ascii?Q?tCzl1P6eeRRqbLSI91E7xyNNfcug1Qm2VG2jGGjxv29DIdmE2HrO7jYwmRUV?=
 =?us-ascii?Q?Xfb82TyJqn+q0Bi7pt2muZRJqoMSe2/Uc4s06AQZ3ReAu8FMnm2HEWGv+Dm/?=
 =?us-ascii?Q?poSIPDrS7Hssta3z0BvJuCwJH3tVwSDNNZMigDTX0XECviwfWPSJ9D9uNLYV?=
 =?us-ascii?Q?gbwb7qdXMlWF9Isnwg8O4AMki3H+8gPSdqm5USKQeAB0ZC/AQtOlG8rD75L4?=
 =?us-ascii?Q?VUplEUkulCmvs+ZDxGsOtA0le3qrxYc9cQqTMjKBRGFCU4zyOvhkaXNw1jwC?=
 =?us-ascii?Q?WHwI7y2qgFU+XFlb7yawgC02FkbaBwtKxcQaAPLrWb7cDkS6fxZ+zGkcSOac?=
 =?us-ascii?Q?J2tpRpkJCC0Ueyzqi8/aGcgdU4eY9n8KHliMCn1Nr/k3OOs31dWJqyY8lBGs?=
 =?us-ascii?Q?xLjTsn/+1P26UdiRFBwQNxr3IlXdosdCAR3mwOKZZaDJJuPtayre0KAwYKbP?=
 =?us-ascii?Q?/Wb66fMAVrYEo6ax1PpzI+jA91UK0enxYhgd/SwBOqfhNVVaY5WTaTwsBdw6?=
 =?us-ascii?Q?jQtg0S+/5lNGcMdJgdq8LTb84aginaNX9jCDDPgRxp1bvuLdV0BdXx/3I1Dm?=
 =?us-ascii?Q?BhuoFUiFWpuzOlLcp7wqH2thLS5IOnj1WMusj7w5P0ORfM2X0+w5HuAX2S/x?=
 =?us-ascii?Q?Q6T3xqAYhCEUkE2MoSOm0nmtHQ1idTGRVn+3Q+aI2z3Nudl7/YrWS5pZ4+9a?=
 =?us-ascii?Q?hw4Duir/7PwAl7J++lS0bZKOsMGHW/MZ0l83Pl3aY6m0g6BDHjPCxq1QgY7+?=
 =?us-ascii?Q?RS/UVE67yLPWhYSYtVBuHs/SDtOXYHIz4dMLgbnjqye5kDTZ1rw8FMAtSZd9?=
 =?us-ascii?Q?85PWQbPwGfOodyE/3m4fK3aoQABCY9R2ofP9JQC5JfwrTD024Cxrux3DR4WF?=
 =?us-ascii?Q?tpJfrN3YjQLaqY9+i/n9HesfzMfU4Ok30DI28F3uRu7OvCZLkvLO7bQixHGg?=
 =?us-ascii?Q?CacVEWmCfjpIkLZxBoFj9o6zhlCSIjCek68V1ZOYVM5eF8cTIOl8dLMc0Cl2?=
 =?us-ascii?Q?pDmaXy15bqs1ZG4hVXxjb3IbW28iDNQqwCd7yRYhTrBqc6kIPovN0/KLuW7w?=
 =?us-ascii?Q?8gz/uHbqZUXD2VkrWkRgM9ilzI14R76I0luPEoNiA/Y5SuDuTCxBMPPIom+c?=
 =?us-ascii?Q?1/LFa1r2dSAOhhpwdlPK9viUZxlej6QAyqxrZjZUqjnxZ9W46n3ZA3QMU+1W?=
 =?us-ascii?Q?pZkwyLlfUUk0wwuuuvuj/jGaQwtwK8LTGusLqURF1tIRKUK/bZo9Mt4qQnIb?=
 =?us-ascii?Q?9t8l76z3vqrdJymT9gumS/Zx+cuM6tEINYjT/ge+0mOW8omoa/BvXef9hdag?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U90Shscd6jxE7cjj16Dqk0If6HWSaH6Pdoalzrsn2Dkjwuo1X+2uIqcUbF686Xwhs+Xnyf3WkqOsQtO5nfHfrqpZdgenpZanPFD95AybhG/tBL2PlHk9RPtfdg59TLbAJ5nhvZ65Q/3ZahWucdS6DuVfM9LDEzu2OavlqdtyI4+9ZLyC8C2moqvYDcMySkg3Ek7bu/TtjPO7SZxIde5Mi3ZJI5ZqBmlxPPMagwQgcyyInMCRTgv1UAi/E7W0PagvTRwS+3gkscj3n3QBEQOrQ1P2PMkIzyWWXH/G2VfhseXJUwGm++zeSxmWhdpsBr/vruli3OIlaWAnReGe/XTz6GdIRncrKX5zwu44UNAw7BdGi1ba+yKfNUZo4Tr88qvHdYGUcotX9WBWMkLfr5uSnlHKVEx8TSssjk8GTEBf1gn+701+E0J4f5VYJV/5HEzyHUot9NlNRxHYkqrHkiItXDK+cHj3E31z4Vi5vzTBiIbPko2d7zprzV+rpPn5GP2gP/+6mLVQi+quH31Thk3znOvL21sER+33q90BpqvJZWhEQHMSaKrq5WsKz28sI1+biIzOqpZkm/c0oTQ/1Vubl6yJ7pVdSVQl4OVWEcyNIJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b7e83c-ae76-408f-5511-08ddbfd2d933
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:57:26.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZLzC2rFLshvQxt3v+laY+9tHlb+tP48oc10MHfFevmETxADvTwRPrL7JZ5ikozadxvGIaEYvPbPLvU6uNz4bvorXlLBbcV1Af+sZdbiiAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE0NCBTYWx0ZWRfXz91LAwM46vVg HVUipNgJUJfjpEsBIKl2eljGYUzSpq2U7hweyV7RQ0eKXs3Hh4sXmKbU1FWTNUE3uxuwOEmIQ/a gFAXeZqAsqY9Aj0FUXqODNpKQ9mRGJuVD44h6zlfpEv5j4+AITrr0rXF2/By4AC5RekI1YCVPKx
 I3J+leEw3NZM5xcC4XunLWv4AXxfxG9fbhi3GKllTcoV3dnnLzw3rggSyPhBJPXsDVJnU6ntUtV +8xgq3bzgpg08LwpJUVsNBs5fFYSB1F3FSVZARy8+QQfOi1STOOUgWuH01CSfT+etOAz0+UN2Q5 uPMwF/9G6BCw1UNLobghogiWk4Cyw4PVhjTZ3WV94YYUSMMAaXLzLv8ViOwuSIe6pOguuDHYKDG
 pDvc5hq29S3xA6vDIzEUAaSK1+JuSner6QOHlafccItz69mFdPwB0TYyKwlHs5aayct/VGvy
X-Proofpoint-GUID: kVn9xgVOnpRe_LMrv_KZu3RcjrNz9ZvY
X-Proofpoint-ORIG-GUID: kVn9xgVOnpRe_LMrv_KZu3RcjrNz9ZvY
X-Authority-Analysis: v=2.4 cv=GqFC+l1C c=1 sm=1 tr=0 ts=686ff0fb cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=JBvxSx4XFbA70SyYfVwA:9 a=CjuIK1q_8ugA:10

This series doesn't apply against mm-new currently, seems some conflict on
vm_util.c. So unable to test.

Am reviewing based on code, will have to double-check functionality against
respin.

On Thu, Jul 10, 2025 at 07:22:49PM +0800, wang lian wrote:
> Add tests for process_madvise(), focusing on verifying behavior under
> various conditions including valid usage and error cases.
>
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Acked-by: SeongJae Park <sj@kernel.org>
> ---
> Changelog v4:
> - Refine resource cleanup logic in test teardown to be more robust.
> - Improve remote_collapse test to correctly handle different THP
>   (Transparent Huge Page) policies ('always', 'madvise', 'never'),
>   including handling race conditions with khugepaged.
> - Resolve build errors
>
> Changelog v3: https://lore.kernel.org/lkml/20250703044326.65061-1-lianux.mm@gmail.com/
> - Rebased onto the latest mm-stable branch to ensure clean application.
> - Refactor common signal handling logic into vm_util to reduce code duplication.
> - Improve test robustness and diagnostics based on community feedback.
> - Address minor code style and script corrections.
>
> Changelog v2: https://lore.kernel.org/lkml/20250630140957.4000-1-lianux.mm@gmail.com/
> - Drop MADV_DONTNEED tests based on feedback.
> - Focus solely on process_madvise() syscall.
> - Improve error handling and structure.
> - Add future-proof flag test.
> - Style and comment cleanups.
>
> -V1: https://lore.kernel.org/lkml/20250621133003.4733-1-lianux.mm@gmail.com/
>
>  tools/testing/selftests/mm/.gitignore      |   1 +
>  tools/testing/selftests/mm/Makefile        |   1 +
>  tools/testing/selftests/mm/guard-regions.c |  51 ---
>  tools/testing/selftests/mm/process_madv.c  | 447 +++++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh  |   5 +
>  tools/testing/selftests/mm/vm_util.c       |  35 ++
>  tools/testing/selftests/mm/vm_util.h       |  22 +
>  7 files changed, 511 insertions(+), 51 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/process_madv.c
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 824266982aa3..95bd9c6ead9e 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -25,6 +25,7 @@ pfnmap
>  protection_keys
>  protection_keys_32
>  protection_keys_64
> +process_madv
>  madv_populate
>  uffd-stress
>  uffd-unit-tests
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index ae6f994d3add..d13b3cef2a2b 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -85,6 +85,7 @@ TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
>  TEST_GEN_FILES += pfnmap
> +TEST_GEN_FILES += process_madv
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> index 93af3d3760f9..4cf101b0fe5e 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -9,8 +9,6 @@
>  #include <linux/limits.h>
>  #include <linux/userfaultfd.h>
>  #include <linux/fs.h>
> -#include <setjmp.h>
> -#include <signal.h>
>  #include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -24,24 +22,6 @@
>
>  #include "../pidfd/pidfd.h"
>
> -/*
> - * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
> - *
> - * "If the signal occurs other than as the result of calling the abort or raise
> - *  function, the behavior is undefined if the signal handler refers to any
> - *  object with static storage duration other than by assigning a value to an
> - *  object declared as volatile sig_atomic_t"
> - */
> -static volatile sig_atomic_t signal_jump_set;
> -static sigjmp_buf signal_jmp_buf;

Please keep these static.

> -
> -/*
> - * Ignore the checkpatch warning, we must read from x but don't want to do
> - * anything with it in order to trigger a read page fault. We therefore must use
> - * volatile to stop the compiler from optimising this away.
> - */
> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)

This one is ok to put in a shared header.

> -
>  /*
>   * How is the test backing the mapping being tested?
>   */
> @@ -120,14 +100,6 @@ static int userfaultfd(int flags)
>  	return syscall(SYS_userfaultfd, flags);
>  }
>
> -static void handle_fatal(int c)
> -{
> -	if (!signal_jump_set)
> -		return;
> -
> -	siglongjmp(signal_jmp_buf, c);
> -}
> -
>  static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
>  				   size_t n, int advice, unsigned int flags)
>  {
> @@ -180,29 +152,6 @@ static bool try_read_write_buf(char *ptr)
>  	return try_read_buf(ptr) && try_write_buf(ptr);
>  }
>
> -static void setup_sighandler(void)
> -{
> -	struct sigaction act = {
> -		.sa_handler = &handle_fatal,
> -		.sa_flags = SA_NODEFER,
> -	};
> -
> -	sigemptyset(&act.sa_mask);
> -	if (sigaction(SIGSEGV, &act, NULL))
> -		ksft_exit_fail_perror("sigaction");
> -}
> -
> -static void teardown_sighandler(void)
> -{
> -	struct sigaction act = {
> -		.sa_handler = SIG_DFL,
> -		.sa_flags = SA_NODEFER,
> -	};
> -
> -	sigemptyset(&act.sa_mask);
> -	sigaction(SIGSEGV, &act, NULL);
> -}
> -

I see what you're doing here, but I really don't feel comfortable with
having different tests share these signal-y variables. This stuff is fiddly
as it is.

Also let's please not have 'setup' or 'teardown' functions in
vm_util.h/vm_util.c - the util still is meant to be there for abstractions,
not test implementation details.

Also note this signal setup stuff is basically customised to the usecase
here - so overall I don't think you should abstract any of this.

Yes it's somewhat duplicative, but these are tests, that's ok.

>  static int open_file(const char *prefix, char *path)
>  {
>  	int fd;
> diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/selftests/mm/process_madv.c
> new file mode 100644
> index 000000000000..7d7509486d46
> --- /dev/null
> +++ b/tools/testing/selftests/mm/process_madv.c
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <errno.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/mman.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <linux/pidfd.h>

So you've seen the discussion around this.

Basically John has provided an excellent abstraction layer for this kind of
thing in tools/include. This _should_ be automatically available, so all
you _should_ need to do is:

cp include/uapi/linux/pidfd.h tools/include/uapi/linux/pidfd.h

However, the pidfd tests already have a stub in so you can alternatively
use:

#include "../pidfd/pidfd.h"

As is done in guard-regions.c.

> +#include <linux/uio.h>
> +#include "vm_util.h"
> +
> +FIXTURE(process_madvise)
> +{
> +	int pidfd;
> +	int flag;
> +	pid_t child_pid;
> +};
> +
> +FIXTURE_SETUP(process_madvise)
> +{
> +	self->pidfd = PIDFD_SELF;
> +	self->flag = 0;
> +	self->child_pid = -1;
> +	setup_sighandler();
> +};
> +
> +FIXTURE_TEARDOWN_PARENT(process_madvise)
> +{
> +	teardown_sighandler();
> +	if (self->child_pid > 0) {
> +		kill(self->child_pid, SIGKILL);
> +		waitpid(self->child_pid, NULL, 0);
> +	}
> +}
> +
> +static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
> +				   size_t vlen, int advice, unsigned int flags)
> +{
> +	return syscall(__NR_process_madvise, pidfd, iovec, vlen, advice, flags);
> +}
> +
> +/*
> + * Enable our signal catcher and try to read the specified buffer. The
> + * return value indicates whether the read succeeds without a fatal
> + * signal.
> + */
> +static bool try_read_buf(char *ptr)
> +{
> +	bool failed;
> +
> +	/* Tell signal handler to jump back here on fatal signal. */
> +	signal_jump_set = true;
> +	/* If a fatal signal arose, we will jump back here and failed is set. */
> +	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
> +
> +	if (!failed)
> +		FORCE_READ(ptr);
> +
> +	signal_jump_set = false;
> +	return !failed;
> +}

At no point do you ever assert this false nor would you in any sane
situation get a page fault on anything you're testing, so I suggest you
just drop this + all related checks.

> +
> +TEST_F(process_madvise, basic)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);

You should just put pagesize in self + get on setup. You can always do
something like:

	const unsigned long pagesize = self->pagesize;

Here for brevity after that.

> +	const int madvise_pages = 4;
> +	char *map;
> +	ssize_t ret;
> +	struct iovec vec[madvise_pages];
> +
> +	/*
> +	 * Create a single large mapping. We will pick pages from this
> +	 * mapping to advise on. This ensures we test non-contiguous iovecs.
> +	 */
> +	map = mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (map == MAP_FAILED)
> +		ksft_exit_skip("mmap failed, not enough memory.\n");
> +
> +	/* Fill the entire region with a known pattern. */
> +	memset(map, 'A', pagesize * 10);
> +
> +	/*
> +	 * Setup the iovec to point to 4 non-contiguous pages
> +	 * within the mapping.
> +	 */
> +	vec[0].iov_base = &map[0 * pagesize];
> +	vec[0].iov_len = pagesize;
> +	vec[1].iov_base = &map[3 * pagesize];
> +	vec[1].iov_len = pagesize;
> +	vec[2].iov_base = &map[5 * pagesize];
> +	vec[2].iov_len = pagesize;
> +	vec[3].iov_base = &map[8 * pagesize];
> +	vec[3].iov_len = pagesize;
> +
> +	ret = sys_process_madvise(PIDFD_SELF, vec, madvise_pages, MADV_DONTNEED,
> +				  0);
> +	if (ret == -1 && errno == EPERM)
> +		ksft_exit_skip(
> +			"process_madvise() unsupported or permission denied, try running as root.\n");

I think you can use the SKIP() macro here.

> +	else if (errno == EINVAL)
> +		ksft_exit_skip(
> +			"process_madvise() unsupported or parameter invalid, please check arguments.\n");

Isn't this latter one indicative of a bug?

> +
> +	/* The call should succeed and report the total bytes processed. */
> +	ASSERT_EQ(ret, madvise_pages * pagesize);
> +
> +	/* Check that advised pages are now zero. */
> +	for (int i = 0; i < madvise_pages; i++) {
> +		char *advised_page = (char *)vec[i].iov_base;
> +
> +		/* Access should be successful (kernel provides a new page). */
> +		ASSERT_TRUE(try_read_buf(advised_page));

This is a useless check really. We know page faulting works :)

> +		/* Content must be 0, not 'A'. */
> +		ASSERT_EQ(*advised_page, 0);

This is not clear, you're checking first byte of each page the below would
be clearer:

	ASSERT_EQ(advised_page[0], '\0');

> +	}
> +
> +	/* Check that an un-advised page in between is still 'A'. */
> +	char *unadvised_page = &map[1 * pagesize];
> +
> +	ASSERT_TRUE(try_read_buf(unadvised_page));

I don't see the point in using this. We know page faulting works.

> +	for (int i = 0; i < pagesize; i++)
> +		ASSERT_EQ(unadvised_page[i], 'A');
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(map, pagesize * 10), 0);
> +}
> +
> +static long get_smaps_anon_huge_pages(pid_t pid, void *addr)
> +{
> +	char smaps_path[64];
> +	char *line = NULL;
> +	unsigned long start, end;
> +	long anon_huge_kb;
> +	size_t len;
> +	FILE *f;
> +	bool in_vma;
> +
> +	in_vma = false;
> +	snprintf(smaps_path, sizeof(smaps_path), "/proc/%d/smaps", pid);
> +	f = fopen(smaps_path, "r");
> +	if (!f)
> +		return -1;
> +
> +	while (getline(&line, &len, f) != -1) {
> +		/* Check if the line describes a VMA range */
> +		if (sscanf(line, "%lx-%lx", &start, &end) == 2) {
> +			if ((unsigned long)addr >= start &&
> +			    (unsigned long)addr < end)
> +				in_vma = true;
> +			else
> +				in_vma = false;
> +			continue;
> +		}
> +
> +		/* If we are in the correct VMA, look for the AnonHugePages field */
> +		if (in_vma &&
> +		    sscanf(line, "AnonHugePages: %ld kB", &anon_huge_kb) == 1)
> +			break;
> +	}
> +
> +	free(line);
> +	fclose(f);
> +
> +	return (anon_huge_kb > 0) ? (anon_huge_kb * 1024) : 0;
> +}

This seems like a lot of effort to check something that's pretty unreliable...

> +
> +static bool is_thp_always(void)
> +{
> +	const char *path = "/sys/kernel/mm/transparent_hugepage/enabled";
> +	char buf[32];
> +	FILE *f = fopen(path, "r");
> +
> +	if (!f)
> +		return false;
> +
> +	if (fgets(buf, sizeof(buf), f))
> +		if (strstr(buf, "[always]")) {
> +			fclose(f);
> +			return true;
> +		}
> +
> +	fclose(f);
> +	return false;
> +}
> +
> +/**
> + * TEST_F(process_madvise, remote_collapse)

We don't need kernel doc style comments in tests :) please just use normal
comments.

> + *
> + * This test deterministically validates process_madvise() with MADV_COLLAPSE
> + * on a remote process, other advices are difficult to verify reliably.
> + *
> + * The test verifies that a memory region in a child process, initially
> + * backed by small pages, can be collapsed into a Transparent Huge Page by a
> + * request from the parent. The result is verified by parsing the child's
> + * /proc/<pid>/smaps file.
> + */

This is clever and you've put a lot of effort in, but this just seems
absolutely prone to flaking and you're essentially testing something that's
highly automated.

I think you're also going way outside of the realms of testing
process_madvise() and are getting into testing essentially MADV_COLLAPSE
here.

We have to try to keep the test specific to what it is you're testing -
which is process_madvise() itself.

So for me, and I realise you've put a ton of work into this and I'm really
sorry to say it, I think you should drop this specific test.

For me simply testing the remote MADV_DONTNEED is enough.

> +TEST_F(process_madvise, remote_collapse)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
> +	int pidfd;
> +	long huge_page_size;
> +	int pipe_info[2];
> +	ssize_t ret;
> +	struct iovec vec;
> +
> +	struct child_info {
> +		pid_t pid;
> +		void *map_addr;
> +	} info;
> +
> +	huge_page_size = default_huge_page_size();
> +	if (huge_page_size <= 0)
> +		ksft_exit_skip("Could not determine a valid huge page size.\n");
> +
> +	ASSERT_EQ(pipe(pipe_info), 0);
> +
> +	self->child_pid = fork();
> +	ASSERT_NE(self->child_pid, -1);
> +
> +	if (self->child_pid == 0) {
> +		char *map;
> +		size_t map_size = 2 * huge_page_size;
> +
> +		close(pipe_info[0]);
> +
> +		map = mmap(NULL, map_size, PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +		ASSERT_NE(map, MAP_FAILED);
> +
> +		/* Fault in as small pages */
> +		for (size_t i = 0; i < map_size; i += pagesize)
> +			map[i] = 'A';
> +
> +		/* Send info and pause */
> +		info.pid = getpid();
> +		info.map_addr = map;
> +		ret = write(pipe_info[1], &info, sizeof(info));
> +		ASSERT_EQ(ret, sizeof(info));
> +		close(pipe_info[1]);
> +
> +		pause();
> +		exit(0);
> +	}
> +
> +	close(pipe_info[1]);
> +
> +	/* Receive child info */
> +	ret = read(pipe_info[0], &info, sizeof(info));
> +	if (ret <= 0) {
> +		waitpid(self->child_pid, NULL, 0);
> +		ksft_exit_skip("Failed to read child info from pipe.\n");
> +	}
> +	ASSERT_EQ(ret, sizeof(info));
> +	close(pipe_info[0]);
> +	self->child_pid = info.pid;
> +
> +	pidfd = syscall(__NR_pidfd_open, self->child_pid, 0);
> +	ASSERT_GE(pidfd, 0);
> +
> +	vec.iov_base = info.map_addr;
> +	vec.iov_len = huge_page_size;
> +
> +	if (is_thp_always()) {
> +		long initial_huge_pages;
> +
> +		/*
> +		 * When THP is 'always', khugepaged may pre-emptively
> +		 * collapse the pages before our MADV_COLLAPSE call. Check
> +		 * the initial state to provide a more accurate test report.
> +		 */
> +		initial_huge_pages =
> +			get_smaps_anon_huge_pages(self->child_pid, info.map_addr);
> +
> +		if (initial_huge_pages == 2 * huge_page_size) {
> +			/*
> +			 * The pages were already collapsed by khugepaged.
> +			 * The test goal narrows to verifying that MADV_COLLAPSE
> +			 * correctly returns success on an already-collapsed
> +			 * region, as documented.
> +			 */
> +			ksft_test_result_skip(
> +				"THP is 'always' and pages were pre-collapsed; verifying success on already-collapsed page.\n");
> +
> +			ret = sys_process_madvise(pidfd, &vec, 1, MADV_COLLAPSE,
> +						  0);
> +			ASSERT_EQ(ret, huge_page_size);
> +			goto cleanup;
> +		}

Yeah this is asking for a flake. khugepaged can operate at any time.

> +
> +		/*
> +		 * Pages are still small, creating a race between our call
> +		 * and khugepaged. This is the main test scenario for 'always'.
> +		 */
> +		ret = sys_process_madvise(pidfd, &vec, 1, MADV_COLLAPSE, 0);
> +
> +		if (ret == -1) {
> +			/*
> +			 * MADV_COLLAPSE lost the race to khugepaged, which
> +			 * likely held a page lock. The kernel correctly
> +			 * reports this temporary contention with EAGAIN.
> +			 */
> +			if (errno == EAGAIN) {
> +				ksft_test_result_skip(
> +					"THP is 'always', process_madvise returned EAGAIN due to an expected race with khugepaged.\n");
> +			} else {
> +				ksft_test_result_fail(
> +					"process_madvise failed with unexpected errno %d in 'always' mode.\n",
> +					errno);
> +			}
> +			goto cleanup;
> +		}
> +
> +		/*
> +		 * MADV_COLLAPSE won the race and successfully collapsed
> +		 * the pages. Verify the final state.
> +		 */
> +		ASSERT_EQ(ret, huge_page_size);
> +		ASSERT_EQ(get_smaps_anon_huge_pages(self->child_pid, info.map_addr),
> +			  huge_page_size);
> +		ksft_test_result_pass(
> +			"THP is 'always', MADV_COLLAPSE won race and collapsed pages.\n");
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * THP is 'madvise' or 'never'. No race is expected with khugepaged.
> +	 * We can perform a straightforward state-change verification.
> +	 */
> +	ASSERT_EQ(get_smaps_anon_huge_pages(self->child_pid, info.map_addr), 0);
> +
> +	ret = sys_process_madvise(pidfd, &vec, 1, MADV_COLLAPSE, 0);
> +	if (ret == -1) {
> +		if (errno == EINVAL)
> +			ksft_exit_skip(
> +				"PROCESS_MADV_ADVISE is not supported.\n");
> +		else if (errno == EPERM)
> +			ksft_exit_skip(
> +				"No process_madvise() permissions, try running as root.\n");
> +		goto cleanup;
> +	}
> +	ASSERT_EQ(ret, huge_page_size);
> +
> +	ASSERT_EQ(get_smaps_anon_huge_pages(self->child_pid, info.map_addr),
> +		  huge_page_size);
> +
> +	ksft_test_result_pass(
> +		"MADV_COLLAPSE successfully verified via smaps.\n");
> +
> +cleanup:
> +	/* Cleanup */
> +	kill(self->child_pid, SIGKILL);
> +	waitpid(self->child_pid, NULL, 0);
> +	if (pidfd >= 0)
> +		close(pidfd);
> +}
> +
> +/*
> + * Test process_madvise() with various invalid pidfds to ensure correct error
> + * handling. This includes negative fds, non-pidfd fds, and pidfds for
> + * processes that no longer exist.
> + */
> +TEST_F(process_madvise, invalid_pidfd)
> +{
> +	struct iovec vec;
> +	pid_t child_pid;
> +	ssize_t ret;
> +	int pidfd;
> +
> +	vec.iov_base = (void *)0x1234;
> +	vec.iov_len = 4096;
> +
> +	/* Using an invalid fd number (-1) should fail with EBADF. */
> +	ret = sys_process_madvise(-1, &vec, 1, MADV_DONTNEED, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EBADF);
> +
> +	/*
> +	 * Using a valid fd that is not a pidfd (e.g. stdin) should fail
> +	 * with EBADF.
> +	 */
> +	ret = sys_process_madvise(STDIN_FILENO, &vec, 1, MADV_DONTNEED, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EBADF);
> +
> +	/*
> +	 * Using a pidfd for a process that has already exited should fail
> +	 * with ESRCH.
> +	 */
> +	child_pid = fork();
> +	ASSERT_NE(child_pid, -1);
> +
> +	if (child_pid == 0)
> +		exit(0);
> +
> +	pidfd = syscall(__NR_pidfd_open, child_pid, 0);
> +	ASSERT_GE(pidfd, 0);
> +
> +	/* Wait for the child to ensure it has terminated. */
> +	waitpid(child_pid, NULL, 0);
> +
> +	ret = sys_process_madvise(pidfd, &vec, 1, MADV_DONTNEED, 0);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, ESRCH);
> +	close(pidfd);
> +}
> +
> +/*
> + * Test process_madvise() with an invalid flag value. Now we only support flag=0
> + * future we will use it support sync so reserve this test.
> + */
> +TEST_F(process_madvise, flag)
> +{
> +	const unsigned long pagesize = (unsigned long)sysconf(_SC_PAGESIZE);
> +	unsigned int invalid_flag;
> +	struct iovec vec;
> +	char *map;
> +	ssize_t ret;
> +
> +	map = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1,
> +		   0);
> +	if (map == MAP_FAILED)
> +		ksft_exit_skip("mmap failed, not enough memory.\n");
> +
> +	vec.iov_base = map;
> +	vec.iov_len = pagesize;
> +
> +	invalid_flag = 0x80000000;
> +
> +	ret = sys_process_madvise(PIDFD_SELF, &vec, 1, MADV_DONTNEED,
> +				  invalid_flag);
> +	ASSERT_EQ(ret, -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(map, pagesize), 0);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index dddd1dd8af14..84fb51902c3e 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -65,6 +65,8 @@ separated by spaces:
>  	test pagemap_scan IOCTL
>  - pfnmap
>  	tests for VM_PFNMAP handling
> +- process_madv
> +	test process_madvise
>  - cow
>  	test copy-on-write semantics
>  - thp
> @@ -422,6 +424,9 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>  # MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
>  CATEGORY="madv_guard" run_test ./guard-regions
>
> +# PROCESS_MADVISE TEST
> +CATEGORY="process_madv" run_test ./process_madv
> +
>  # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>  CATEGORY="madv_populate" run_test ./madv_populate
>
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 5492e3f784df..85b209260e5a 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -20,6 +20,9 @@
>  unsigned int __page_size;
>  unsigned int __page_shift;
>
> +volatile sig_atomic_t signal_jump_set;
> +sigjmp_buf signal_jmp_buf;
> +
>  uint64_t pagemap_get_entry(int fd, char *start)
>  {
>  	const unsigned long pfn = (unsigned long)start / getpagesize();
> @@ -524,3 +527,35 @@ int read_sysfs(const char *file_path, unsigned long *val)
>
>  	return 0;
>  }
> +
> +static void handle_fatal(int c)
> +{
> +	if (!signal_jump_set)
> +		return;
> +
> +	siglongjmp(signal_jmp_buf, c);
> +}
> +
> +void setup_sighandler(void)
> +{
> +	struct sigaction act = {
> +		.sa_handler = &handle_fatal,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	if (sigaction(SIGSEGV, &act, NULL))
> +		ksft_exit_fail_perror("sigaction in setup");
> +}
> +
> +void teardown_sighandler(void)
> +{
> +	struct sigaction act = {
> +		.sa_handler = SIG_DFL,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	if (sigaction(SIGSEGV, &act, NULL))
> +		ksft_exit_fail_perror("sigaction in teardown");
> +}

As stated above, please do not abstract these.

> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index b8136d12a0f8..6bc4177a2807 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -8,6 +8,8 @@
>  #include <unistd.h> /* _SC_PAGESIZE */
>  #include "../kselftest.h"
>  #include <linux/fs.h>
> +#include <setjmp.h>
> +#include <signal.h>
>
>  #define BIT_ULL(nr)                   (1ULL << (nr))
>  #define PM_SOFT_DIRTY                 BIT_ULL(55)
> @@ -61,6 +63,24 @@ static inline void skip_test_dodgy_fs(const char *op_name)
>  	ksft_test_result_skip("%s failed with ENOENT. Filesystem might be buggy (9pfs?)\n", op_name);
>  }
>
> +/*
> + * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
> + *
> + * "If the signal occurs other than as the result of calling the abort or raise
> + *  function, the behavior is undefined if the signal handler refers to any
> + *  object with static storage duration other than by assigning a value to an
> + *  object declared as volatile sig_atomic_t"
> + */
> +extern volatile sig_atomic_t signal_jump_set;
> +extern sigjmp_buf signal_jmp_buf;
> +
> +/*
> + * Ignore the checkpatch warning, we must read from x but don't want to do
> + * anything with it in order to trigger a read page fault. We therefore must use
> + * volatile to stop the compiler from optimising this away.
> + */
> +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> +
>  uint64_t pagemap_get_entry(int fd, char *start);
>  bool pagemap_is_softdirty(int fd, char *start);
>  bool pagemap_is_swapped(int fd, char *start);
> @@ -90,6 +110,8 @@ bool find_vma_procmap(struct procmap_fd *procmap, void *address);
>  int close_procmap(struct procmap_fd *procmap);
>  int write_sysfs(const char *file_path, unsigned long val);
>  int read_sysfs(const char *file_path, unsigned long *val);
> +void setup_sighandler(void);
> +void teardown_sighandler(void);

And as stated previously, please un-abstract all these.

>
>  static inline int open_self_procmap(struct procmap_fd *procmap_out)
>  {
> --
> 2.43.0
>

