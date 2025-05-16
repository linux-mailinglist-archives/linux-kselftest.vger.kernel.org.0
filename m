Return-Path: <linux-kselftest+bounces-33227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBADABA4C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 22:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4601BA16CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0CC27D776;
	Fri, 16 May 2025 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k9QFNNMI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o9HYebwA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38542AA3;
	Fri, 16 May 2025 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427983; cv=fail; b=GKOq37/GyP9nW80BZPSSPUyqn80vhai1pdruKO8Y+mQSESa4O9dlqL+N+h6P4siPtblkFZ/ESfwtkcD5ZzQH9qF3VJ6SsriW9DtLVt+bACZkI9RM4ukLrCxDHvL1efeALe3oHLj9/b0pioTu4yy3EiqW/dRfeTlMdtkyIflDPBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427983; c=relaxed/simple;
	bh=rSibY8r0kLLEt9CUPjp3oNkOz6WQJ9jrWsaBXa9O164=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IjSzslDfRBxxb96b2nqbjukUOa2960MtagRzezUQ0GMBMPWeAbqtJ93quR+FbcSB+UOIyPxmXU/tFDtBCJHyZUxY3/lkTCe9uerC8F/Bkanm/RORrBXg/pzFP8GqEfMoneHaXJBLYrDodiE4qMIi8SzC0fwvATZjt8tnml/MjQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k9QFNNMI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o9HYebwA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GK9xCA012936;
	Fri, 16 May 2025 20:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UMEI7ngSwTQJRktVQHt0jfCwZt7cDYXPNzL+EORfw1s=; b=
	k9QFNNMI8vGAEwWGhwtLGNZgnLNNr84VlfzBpsBy2wwSebQg+ybwYpf9d3c34AaA
	OY2zOVcTcB3nZvfPomayXurP/MkmvbNxWBxnb31NRDVv5hWVMyIHuDmSEL2lb2mk
	oWsWelQ4nSbEpKBBLy1aPgHKT9NBtzUoZFWGFaYnZy57IIFnRXQA55mc1mQPi9n1
	/FZtAKfXPHvzHrD9pQ6BF0lLqSUczouzdsLhczahw6CKa3ZUboghJ9SbC4/DnZ/D
	LzKgaem1z8XIFKqZANPBrj9FbgxTX7Xqsn6k1pS7DhuspI6JZe+YQf86+S5y8ypG
	BXKoE88CyWLYhx11Q8PK4Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbdj6y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 20:39:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GILR4a026169;
	Fri, 16 May 2025 20:39:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbtb14n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 20:39:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riZ/Pt4x61Gx5IDoGYFQBvMSHm6Wv5185QjOJOwg1LVTriWz4JAcEqhHSOz9DpBtwPQexJY8e01w3TPAmURG13/zm2iDbNtU1Hln5WP3HgMFI5DYgY8Y2Q/ijTLhlWEKmDVNiAemegcqBCMOtZyU5cNS4eS+Z/zPAweNRtlMlr3QtWoGf7OGF2HBmBet9w69jvfJuNQ7fenl4cBUqkMEGv0vZNPn6BOEWZXjAXKHDLds6p9GFO0td7qyr+U31mCN/4CnOP8uvuceLsKePVch5wNsG7qBejLlIVEqgB0dwIcN7I0dEg9F40EzWulrqU50BT2lurrLCeFq2s+nsSYVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMEI7ngSwTQJRktVQHt0jfCwZt7cDYXPNzL+EORfw1s=;
 b=LwrKweDs0H4tFWxe9ame8Cv46lPP0Guagyg5KdgyNm1q/kwgD1KMsq34/z37LHu2L1zFYgBQJ6oSYxjhMj+jW++6Nqat8eH9m2Rni3On5SX9t2RyR1sWLm04b30rNnBkGFTbTdpTHCnvdqjFqZlqq7QfiEBhuL1U6YerKYI3eeD38Dyjnj6TaYCsXOqZJottCLkiueuEUc+Dy/aLG19kqQ1Gc3vY9nPTGOPRjZrclUxqBZWmz39OlgqIZ49xS2WgzVhMR+ED95qHCUuNLVYV5eKp4+Orjad5XtrW65DU5t0q/X9g36BW30BWbC810c8srehUzlJX1FGzb2cYbbyyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMEI7ngSwTQJRktVQHt0jfCwZt7cDYXPNzL+EORfw1s=;
 b=o9HYebwA2BnPSGW6jFBpHEiYjV8ouXUsa0UpA6qBl4xTwoPu2FTiDFfi9VQq0sp6DY+WZ+/IceFyPvF/cXh/yvC7VC4rVaveAXIKeI44xo+V48tUEKbS2l2xjkGz8BKy3qKwkcsmBsBwLKsieHD+uVen1iJPhy83diB3BHo87YE=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DM4PR10MB6743.namprd10.prod.outlook.com (2603:10b6:8:10d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Fri, 16 May 2025 20:39:12 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 20:39:11 +0000
Message-ID: <abd93b56-3a25-4ae7-8a35-8ff6c3727e66@oracle.com>
Date: Fri, 16 May 2025 16:39:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] iommupt: Add the basic structure of the iommu
 implementation
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Justin Stitt <justinstitt@google.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
        James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <3-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <pntkuh63y26rygrkxegbzncvc3shtplucrnzkkz2dimpkfyn75@uekvyuz5kred>
 <20250514155411.GC382960@nvidia.com>
 <2459f14b-4f4e-47b4-8f79-6af784ef6686@oracle.com>
 <rvrpqwvrrqkledbftjzhgprowwc5sulngs32vkurb3oxk7c2fg@5qnorfs4vzyr>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <rvrpqwvrrqkledbftjzhgprowwc5sulngs32vkurb3oxk7c2fg@5qnorfs4vzyr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DM4PR10MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b22d9c-a191-44d8-8f21-08dd94b9b70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGNacnlYTktYeDFQWG52bmJ0WEQyeG02TjVDcnJiVkhZSXhJTi8xYUd6TlRl?=
 =?utf-8?B?djF2d1MvWE1DNUdUQ1hmK0ZoWVA2QWdZS3cxQnhWZFdlc01tcXZLQmZybW5O?=
 =?utf-8?B?akFkYTNkQjIwd1FUakZaVmREL1BuWCttaGw3Q3VRMHVLbmR2SU5LeDBPY0ZR?=
 =?utf-8?B?RCt2ZlNCZDhxdFNhdVozQWJGK2NyR1FVQlNZNUxLcmpVa3BIZzNXK1NxeHhu?=
 =?utf-8?B?RFZaa3UwaEhHaFZTTGlvSFU0b1hFS2ZZRlZKQ3p4Y2t2TEFpQW51RWhOWFlW?=
 =?utf-8?B?NXV6VTBMOW5qRjVOQmFtNlVJc0kwNGdjMmhJZjI2bDJqMnJVNnYxcWlzVkRp?=
 =?utf-8?B?K3FjTGE3V20xSldNZUtVN1haSUNWUUJDSkU5NXRYT0Y5eldYUHhVbjBMaFR2?=
 =?utf-8?B?RmtKT2V3dXRvN0RYNnY4bG16V0xuay9xdmcrUzNuNTRwUmxSUzN1clJBOVov?=
 =?utf-8?B?QUd1NHZ4ZnJBUGpINUEzSWZjeWZ6bCtJUlo1TTJCWHNsYWtZb2FRL2cxM2JG?=
 =?utf-8?B?aUxjcExtamNuS2hDc2pIWmtueHNza1JwVHNobXQ1VFhvb2M2UTZ6Y3owOEtD?=
 =?utf-8?B?blVTNlB5V2liUFNDQS8xbm9YdFd0MW42YVA1VG9FNFQ5a3o3QXlkRW1KeXpq?=
 =?utf-8?B?akdVWmVaZ3BsVW1oN1IzajZPcUdyMXF0Sk5ZUHBQcFRBa2tqSWMwa2VUVWtr?=
 =?utf-8?B?aGhRVlFYNTJiS1VWWTNvcU4xMVRHSGtQTUd6R3FwMmlCbkhlSmphS0JER05m?=
 =?utf-8?B?VmpSdm4vaDFTWnoxc0lDejBKZE4vNVBJVWowMTVtQXFoeGlMQXhNZjJETGxz?=
 =?utf-8?B?ZlBpRSsxNHhYY1dmM2ZTdE50UUh1Mk1CN0MrRUxUZFFkU3NQT0FpWSt1SC81?=
 =?utf-8?B?ZXRGS0FVcWp2MGpnd1VKTVRaNDk5SHlydlF3UjZvZGJHTCtoYkgxOFRIRnN5?=
 =?utf-8?B?bWw5VzBVamh0a0RvMzdGZkN1Mkw0YksxTjRhL1BRUDJPME1uR2tBM1JlMzFo?=
 =?utf-8?B?dS92clN4Z2hpSlFMdW5uNzJSbUJ6aFl2dlJzbC9nbktqd1l1NDk4eDB1NTMy?=
 =?utf-8?B?OXpBVk0rZTg4cmdybjBuenIvYTFOS3QyTHdxRE5GTjV4blpvcnRlVGpZVll6?=
 =?utf-8?B?d2l5L3hGU1JJM2F6dGFSUmF6NGsyYysrSlB6RXFYRDZicEttL0R3blN1ZHRr?=
 =?utf-8?B?ekZYaG44OG9BWFRHTzBxU1FaSExjSnBVeVpNZTByV0dtcHd0YTlkaU9ReTlV?=
 =?utf-8?B?Zzk0d056dGFFVlJzbGsvL054eXZMYmE1OGdoWlJkZ0hVaGpIUHI0TmhoSVZR?=
 =?utf-8?B?c0dtWmttSlE2Skp6SXB2K09MOFlJSXFVckhTTnF1dzlyZmhvWE9tTEwyVnlS?=
 =?utf-8?B?QVFLS01jQzRiU3NIa0NYdUNucFBWMlQ2cXNwVFMvQitDWE0wUzdhdTk4eE1C?=
 =?utf-8?B?ZjdIVGdTSTNtMUxyRjkzWW1RaUtxNGRHZDlRektWWERnTDFKQnRrZFd4MVV4?=
 =?utf-8?B?U2VkNHZwbzhqdllzR0tLODlNSWJoc0lOVE9xMDg3RmhveVZSaGhCZjhDZitq?=
 =?utf-8?B?UVhQbHhKZjV1YzNUVzZROXZSWTRoRjhnU01rSU81TG01VmwyZ1BZOUJ3N0Zv?=
 =?utf-8?B?K3JxQVpRR2RGWHJpL3c1TGowVGM1c2FEK1JnSS9VS3dHMWR0SDBsZHZJRmF0?=
 =?utf-8?B?UDIrNDZlMlprZ3FBRWxMRE0zcGROZ1N1NWk4THlvQUZMcVZoT1pSbGt1TXlx?=
 =?utf-8?B?NFUrZVpuNWJ2aGtQU21aeU81SEJ2Wi9tZCtRUUp0NFA0azBFM0ordlNhcFI4?=
 =?utf-8?B?eFNkRnkrVWQwWUJxdzRpcXFkZ3pvTHB1VFczbFFPYisrRmgwUVFKRGtNeWll?=
 =?utf-8?B?ZDdYbGI4bld3c1hzWjlsL0laL1RaY01EZDJCWWI4NjFCcVVPWFBiOVVGQkt2?=
 =?utf-8?Q?9Sn8euhQvwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5280.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE1vLzNsTVRqRjVMS0ZBUnlPOU04RWt2eXpSbERRUFpxS2c1MVgwL0NHRXF6?=
 =?utf-8?B?NWk1MENVeHZlYTVHS3QxUE9DaWUxS05iK3VFTUw1aUp6a3NwdU5ZMFlZMzdx?=
 =?utf-8?B?VmtDdVM0M1FieWlaNlpyZEtFaDBrMzhJL3BGdUY2WW5kek1iL3Mwc3dFRi93?=
 =?utf-8?B?WTBCUFNpV3RZaXdTejUzdXVqN2I0dUZSaG1rbFJIL01CZThBMEJQaHFGUWFy?=
 =?utf-8?B?bnlkUHB0byt6VzhyRFRBSzJQSG1YVVVQLzlGbWp3T0Z4dVM4Q0hrcVhncEVp?=
 =?utf-8?B?aHFoUVBGclhuaTlXVE5LTmR5OGFIZHpCSzh6UlZaOUE4VDJNZDV0UVdCcXVn?=
 =?utf-8?B?UXFsTFo5L09HUTZqemtDLzU4ckxHcmtMRldlcDlXMEtFZGJSN2JEbkpYWVgw?=
 =?utf-8?B?Skkvb2Vkc0VYQk9XNFNhU01Va1NFMThJODR6VzdrcWpZMkczNFNnK0JVQlB6?=
 =?utf-8?B?dmpEOFBQM2o1V2xGT3NUNENjQmhTbXBqcjhPVmdCVzluMlRqVTRrRHdiYkpX?=
 =?utf-8?B?STRhaStSQkZEOTZJTGNZcFlNNExKeXdOUGY2Zk5SazRZYTNCMVJpb2M2QTdp?=
 =?utf-8?B?L2NDRUJ5RjUvOVlmeW42N0U1eEFRTjdwSW1taXZWQ1IwdFZXdXR4emFSdFI4?=
 =?utf-8?B?R2UrNnZmSTRXMHJBWkZaOVdOdy9XWEN6dDgyNFAyUnRUQ09TUFdPQTJvb2Ro?=
 =?utf-8?B?UVNtUi96bUZQdEVaKzZCU21XSXVCWHVqZHQwNTBDTS85TTM2ckNTOGRiSW9J?=
 =?utf-8?B?SzczUlIrY3hIU1NFaStxWEtsdWFzbWJYbGNmS0ZQNytJWTJ4WXB0U2tmTHZ2?=
 =?utf-8?B?MUU1TDlOQ2pFbWFmbTgrd3pFZEtqQi9LQ3V4WktackI3MHJKZXh0S09JdGxk?=
 =?utf-8?B?WU8waHMwQXM3OFpBY2RkbWNUZzFWdk1ydE5sQjAycGRzK3VVWGVvTkQ3Z2Ja?=
 =?utf-8?B?VTNhY0ZjN2lLSHVrSkZiTy9jV0lBQWFQOTd0S3NpQ3Awa3lDYit6NUFMb2JQ?=
 =?utf-8?B?bEhWSEFhcGVqZ29vTEVibkRlZDZadGFHSzR2d1dZTUZxNzFhSHY5MUlvN2JQ?=
 =?utf-8?B?MER2Zktya01UTkJtVGxXTDg0OXAzbEJYcDd3MXgyZ0tvMTNtMGVLTytkQ2tN?=
 =?utf-8?B?Q1paKy9zaHJxV2tTZ0lxMmRPMC9CYUxubEhRQ1BVaUFKa0x4ZXhrdU1QTFNF?=
 =?utf-8?B?ZHRUdHlXc2ovRUNvOHZlQnkrMEx3S2NTMFRSR0lyeStLVHJZREdzVkNxTVAy?=
 =?utf-8?B?UG8xWS9oYjQ0NktRZ3lRTDdiWUFIU215WnBXMU51RTJjVCtxb0kvMWx0STZr?=
 =?utf-8?B?dzhpU0RIanRmN2Yvbk4vbk1YaE5Cb3pqU013YjhiWnBOU2ZpcHJLY2VXWTFK?=
 =?utf-8?B?RzNzaDloVHJwQW9CUkQzdGhqclBRanIvR1dXaDJRQXdBYjlrSHNJTFV1di9w?=
 =?utf-8?B?c3YrS09qa3JlRDhzL0RGNHFxRW9Ua2puZ0JjSXUwOWNrMUsycGFPRksvUDkx?=
 =?utf-8?B?U21FLzhrT3ptUXhpY0kwb1ZJVXg0NG0yNWhTZDlsT2tZcEwyd0I0ZXRCNjVI?=
 =?utf-8?B?T1dhQWtnb2hiRlcwckJkTkIxejZZMGh6ZlFEQTZ2cks1Zm1UQk5QZjl1MVpJ?=
 =?utf-8?B?ZHRtTW1ydUlvbjJlMW8raW9ERUFXTEgwcy9lbWUyQmkzOEtrMEs5VUpzQlRH?=
 =?utf-8?B?TGJYeGtpWTBqY3RGa0g2U2g2QnJTM1ovK1d3OER2MHJ3d1NRbHkwdEdvM1NC?=
 =?utf-8?B?MU5CakdKUHdrSG5xQlhNYlFVZG1rREcyUC9IUnVzMzlEWldUM3ZiLzJVY2Ux?=
 =?utf-8?B?cm9STGNnekFqbGpLQ1EvK0EzY29kbnMxWTY0S1cwRFlBejM3N2kxVkZDelVj?=
 =?utf-8?B?VDFWNFhXQjkwZ20wVVVBTE01elEza3RLQ1ducEl1R2hVZ2NPQmladk9HY1pH?=
 =?utf-8?B?N0l4bG1ZMTNMS29lVDhnYmxoeE0vV1BEM1lCOUlVbDcvNVdRMU1ja2NjRnFa?=
 =?utf-8?B?WGowcE1zeHhLRFVVeGRqUDZEaSsxYWpqV0NmNlZ1eUZGMy9WcVQvTTQ1Y29N?=
 =?utf-8?B?Zk9BeUlnanNCUE4xNE1hcXNnTDFEY3pndHRhSnpaVlcwU0ZnRllDMVJuZkF5?=
 =?utf-8?B?Y29yRHEwWDAwMGQxVUtIWC85M0RpZlBZQ1h4Uk9mdkdVRnYwYktldnNCZ2ts?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mXwjxhl3CKJzqiuP3iag1YbprluQUFX6EDoE5LasCAhL6J+07++4SVg/C3BQopi0lFMFPxuS2KGbQqs6YXv5FkIy2/GDbsA5O4jmj7n3nm3tDYHcVFsHlQXzYwb/YzxqiGFwH8PBw4vebjoaWU+yEx8S/SX3MnkNZBwIaWScjztekzS0LCYTjy4JOpwRGYHcbyq4h0QjhTfLKC7i/i0ai9SA+KNAvkB25iZbmQuWbCDzPBEg1zkn8+wx2NW9QvhCUdYd/bHaejoQzL60TT9uiBuvZWIj91tthi9erUdoT5kePZrocidIP2/r+HUEwFfqGycdY2D2fo5d6wfmmIW/9ou64irS26UjfUCFltf5qJ3Uwd3pCYl5UEqraRMngVSFlNEGE8nS6gdlmbSbYoa6tY00TL1UsreSA5RfubuTF8bBDV+g5mKpFvWJPgf4WgwI3HdiYkrRWGlYO/aGvMjgbSA2yP9KwE2EfMNWpcXoU15dVFDAIl4HA6eRWimhXEx9tJGAKZoLNVK3L+N1wr22OsMQEeT24qNv51fxtmA4ogJOfTbkWVNcg6vU+6s0DXOLqc5mn5uLzSxfRPLlkf0UnIUKggKyFHk6BsQEehyHsdg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b22d9c-a191-44d8-8f21-08dd94b9b70a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 20:39:11.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: speR36chGYnWxaqhnOkLQJ5ZipXUZDjlEIo8jbSawRMCUEhkCEdVyegV2YCbL7GodmWecMcFAVU9XxS/JWPPnOQlEmKlZHTh0EdbqH+ZcvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160203
X-Proofpoint-GUID: pNU3v8VQOoGMzyTC1QVZEuy7595LB41c
X-Proofpoint-ORIG-GUID: pNU3v8VQOoGMzyTC1QVZEuy7595LB41c
X-Authority-Analysis: v=2.4 cv=G/McE8k5 c=1 sm=1 tr=0 ts=6827a273 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=-l8xOHYEpnoToePDHG4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDIwMiBTYWx0ZWRfX9QmC3XDaZxWg Cm+OqRvDHrDUFGYMrFJeWahq9IznqoWU1wNJwJdPsYUH5HPqSk2jOpY6yMAOwQ4pH+7zwHYPbUd G5tGRHQK9vERHHqDaCdy+MxwKHu5TVIExJ1Yl3nby6Y3ujGx5HfEVCeBU3+bvFf7pNRxCwJG9L/
 w1fcgXB9OCj7eDbUyZjJj85l3/71k2+fH9E8e/YgW+yv31kZjvJ/+F1eyTFS3Y05Zf592Ywh/VN 9Oxfwaxh5sqzqzB9DUjUMvxYg9LdA5qwOUPa1X2ADNjiNfaHeBLi62nd7QbQCG/MKEt6G4ljhrP 0RRcXynu/IVjtlWqxp8rpUWo03dAFHuWw0We2UOKFrP1fgd1d/idrXx59axhLRm0CS4PFAC0s0B
 EJ4f6j3k56ITvnr6vcPuxWyI1mvuII5ksoMVrP1Lf00YxpkTqAZO58UaC75Br1QhWJfYQtsn



On 5/16/25 1:02 AM, Ankit Soni wrote:
> On Wed, May 14, 2025 at 04:08:09PM -0400, Alejandro Jimenez wrote:
>>
>>
>> On 5/14/25 11:54 AM, Jason Gunthorpe wrote:
>>> On Wed, May 14, 2025 at 09:23:49AM +0000, Ankit Soni wrote:
>>>> I am experiencing a system hang with a 5-level v2 page table mode, on boot.
>>>> The NVMe boot drive is not initializing.
>>>> Below are the relevant dmesg logs with some prints i had added:
>>>>
>>>> [    6.386439] AMD-Vi v2 domain init
>>>> [    6.390132] AMD-Vi v2 pt init
>>>> [    6.390133] AMD-Vi aperture end last va ffffffffffffff
>>>> ...
>>>> [   10.315372] AMD-Vi gen pt MAP PAGES iova ffffffffffffe000 paddr 19351b000
>>>> ...
>>>> [   72.171930] nvme nvme0: I/O tag 0 (0000) QID 0 timeout, disable controller
>>>> [   72.179618] nvme nvme1: I/O tag 24 (0018) QID 0 timeout, disable controller
>>>> [   72.197176] nvme nvme0: Identify Controller failed (-4)
>>>> [   72.203063] nvme nvme1: Identify Controller failed (-4)
>>>> [   72.209237] nvme 0000:05:00.0: probe with driver nvme failed with error -5
>>>> [   72.209336] nvme 0000:44:00.0: probe with driver nvme failed with error -5
>>>> ...
>>>> Timed out waiting for the udev queue to be empty.
>>>>
>>>> According to the dmesg logs above, the IOVA for the v2 page table appears
>>>> incorrect and is not aligned with domain->geometry.aperture_end. Which
>>>> requires domain->geometry.force_aperture = true; to be added at the
>>>> appropriate location. Proabably here!
>>
>> Thank you for pointing out this issue and its cause. I originally tested on
>> a host with SCSI storage, and after your report I tried but couldn't
>> reproduce the hang on a Zen4 host with an nvme boot drive. I wanted to see
>> if it was a pattern common to NVME, but I suppose it depends on the DMA mask
>> chosen by the specific driver.
>>
>> Alejandro
>>
> 
> Hi,
> Can you try with below command line?
> "amd_iommu=pgtbl_v2 iommu.forcedac=1"

Yes, I can reproduce the hang when booting with the combination of: 
"amd_iommu=pgtbl_v2 iommu.passthrough=0 iommu.forcedac=1"

[   72.763105] nvme nvme0: I/O tag 8 (0008) QID 0 timeout, disable 
controller
[   72.772093] nvme nvme0: Device not ready; aborting shutdown, CSTS=0x1
[   72.796372] nvme nvme0: Identify Controller failed (-4)
[   72.802603] nvme 0000:01:00.0: probe with driver nvme failed with 
error -5

It also triggers failures for the Mellanox driver:

[  134.342120] mlx5_core 0000:61:00.0: wait_func:1185:(pid 3235): 
ENABLE_HCA(0x104) timeout. Will cause a leak of a command resource
[  134.355465] mlx5_core 0000:61:00.0: mlx5_function_enable:1215:(pid 
3235): enable hca failed
[  134.366570] mlx5_core 0000:61:00.0: probe_one:2003:(pid 3235): 
mlx5_init_one failed with error code -110
[  134.386593] mlx5_core 0000:61:00.0: probe with driver mlx5_core 
failed with error -110

Setting force_aperture = true in pt_iommu_init_domain() solves the issue 
for the AMD v2 format where dynamic top is not available.

Thank you,
Alejandro

> Indeed it depends on DMA Mask chose by nvme driver. if force_aperture is
> not true, iommu driver will use dma_mask in place of end_aperture.
> 
> -Ankit
> 
> 
>>>
>>> Yes! It got lost, thanks alot!
>>>
>>> Jason
>>


