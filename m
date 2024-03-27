Return-Path: <linux-kselftest+bounces-6726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892688EE4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 19:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36221F3C180
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E016314EC61;
	Wed, 27 Mar 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OsjWVVPW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fmQPMlHq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EA13774D;
	Wed, 27 Mar 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564433; cv=fail; b=qAPl6AlAdwpdjs87geYmW8X9U/RNVMjkEZryhNwFYthqpRQu/VWIEhIGmXOF037ar6OUjS5/RFXkVxp/O2MYqM1mgoNoyjcsdVvIUBc1F2zWbUy+nu6dmCztzUF9A6feHBq897SCnLzxaTbkfqO13gJDqJO3N2Kg2touvtfl9TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564433; c=relaxed/simple;
	bh=oOsf3LB1hl33FC/tbt5i38dfMfKEokWQm/hPZocosBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I5cvmnlprJTYQmcEnR9/hVEZXZ2hAUYes7TTzvpNf3D50I5D8gGlftETMdtR7i8oSjxuNGQXqMwWkMH/mdlsDc1kQLHxusMZ2ghSK+W7+5YXkqJlZoLN1HLfV+b1lwIQ/BymIto0zVhiXGUd0Rn55NHvimF346YO4rsS5Dc0GGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OsjWVVPW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fmQPMlHq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RHx3td007552;
	Wed, 27 Mar 2024 18:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1ZXue7kF5c2meZupcOsswExoqEqgEK0SgzDgOzcbwB4=;
 b=OsjWVVPWT8WmGSC2BepWLOTN/8ZiB0uhKlBTvWOrWKtp/B65C0rHQ00stfoDDijVr5pC
 O7Emi57mi97vURFPCIfxXpOpRcv2U4bBmYVFoJdTI+6NR1HirvSWlbc1/gRvvSL5YawV
 Ic2BITe6dJkassoVyEXFf4B9NhbulQiwgfGNpJjtNm2+ec79J6oIvJTkGD/O3Cx6ugLU
 cSB08UoOUnHz7bQj5AsyVwgNIB2JIXEZlbvLepxnFR+XzqoiByGUdWrRWHF36lKfSr/m
 H+eSRaKjBb7ccrhaoCema7FJGD7SyDuW/e0vR4L46H6k+1kjrFf39jUeRthFUa3hHpnT Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2f6h6y43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 18:33:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42RHZioO008854;
	Wed, 27 Mar 2024 18:33:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9866v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 18:33:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5m+NkwPTbCP1IL1/bsgh2ppRQxuL4wNMYuUtoWDUFxZCsFp3K4STc69sWe35BgGakO2LfcZsmHg5v30yHpMTd5qBde9vuZ4QxXDRNZGflYk40BXhQShfgFbNNKLzGAEVYw57wNT9Nh/HXXP1a5wi2pRt7FyvJ3vvvUZmbUnXH/3NaPSNSFK7dlq4YQj3qVYAoSrhfRKUraaA7FW9KHDcE4N2I3AXig9inxxt/d6PUTnMG5U377VvJyJ6NWKLDuM2XX/kXEX9Z96qh1i10UN47NgRNYG73abUyzJ5S4QI4UsKqqC7Tdsm47ruEwm4aWqmznaUqQG7nTCCSPPNPgqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZXue7kF5c2meZupcOsswExoqEqgEK0SgzDgOzcbwB4=;
 b=Q5coGgPZyu61x8U8dVghAtbUWmKK0cVwbWfTNghwGVQHESCaXHj8aSaMWaQNRhtWKxBkXzkNvlFt8SDIjs3YpMmhOksfI7pXEsCvdWfS7wHHtAHznJnDMwjXL5q79kTPscWZ3u0U7pOGg3j6Eqdqlok4m48RPkOqx8KVSEBEiIx3+FEBE2JhhWYZt3LgI7M13Vlyjbl7JeKvJv/j1RtOb2umqRX8ZZG6PmLsmfnN4nadRUeueWKAtzjhiXBqGuORaiWuKYHBgYWtMg9KB99uIUvzVmP+M/NZ/f1+gI18aDK6MsW3IzYg1ZUK5UNOBtkcI3D6qNOWjBN1UDEhoPz0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZXue7kF5c2meZupcOsswExoqEqgEK0SgzDgOzcbwB4=;
 b=fmQPMlHqDMHfeQzDI8aimh5pns6bYGi+8ZL1U7CeHMNXmpW9bH1bKpNEY2m0TLq2/eBtDTgqTI8/Ll41WJTv0Lb2PEEWERf/Os8l1EKRNWTp0xKURf1pXRVclrVPksD1AhU/jPImv1z+oCO/fg3KES6RxUxe2lKjfIO00Lm3bYA=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SN7PR10MB7004.namprd10.prod.outlook.com (2603:10b6:806:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 18:33:21 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::b037:6181:76f0:9a72%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 18:33:21 +0000
Message-ID: <2cb86abd-1c28-4916-8763-9f4e6863bf94@oracle.com>
Date: Wed, 27 Mar 2024 18:33:15 +0000
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>
Cc: kernel@collabora.com, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
 <20240327114958.GG8419@ziepe.ca>
 <51f493a9-08e7-44d8-ae4a-58b2994ea276@oracle.com>
 <f78b685d-a147-4b59-beb2-cde9d34ce22a@collabora.com>
 <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>
 <b05610de-f102-46d2-abe2-4e9ecbcd42eb@collabora.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <b05610de-f102-46d2-abe2-4e9ecbcd42eb@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0025.eurprd03.prod.outlook.com
 (2603:10a6:205:2::38) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SN7PR10MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: c571e861-cc7f-46ce-eb8e-08dc4e8c60fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CrY/RcoWa0ROiLwaM2ILsek+2TAhyZutvYBezCbwq6ykPOKaB3iEeYNeYBQeQPjEd07ehYuIJ4Vb9xEPWnNfS5ahEPA6PCVTKL6EdHVxGAOmKJaskBHLyJQSP+Yfv8FJ+GS8ZettaeeVrjfFmgFZGTsL9fw48jLQ3QvM4QfBeUlelvlwHvNsPg3gdmI5B2hU66u2UogKti+bC8ynRHaCmEywMLYs7tFL9Ja3HK+tu4VnXaJZVFe1G/EIN7gdf4Wxxjv9sXcsUa5PIxJoosrhAfbwtB/xSiwiNcXElrhLTe0Uxbs8HVNWzikFPVnsvTr7XdVRMCO8/+GMySWh46GKvFxymOsdHgfXTnuPVDqYzk1QKVkszq3tsXKlNPqaR+wSu124SWzxfF9RfqvXCmokKfbd8/aQglCLviUQw7/4eLhZi6a354tOrwxIMzH6vVbskWXypbJxAX8KB4G2e51j3ysoeszlhpvZFkpxkn8qjtMT3BJ7pNH4K3e/h7B05yKB98nMWuNuV4vgYt2OA8yu+RJsfS8DqovvHRZfyCWJhjSdOZBGiw32H++3igtDknJCsT8lZDh+1O2Zfuhaz+qwAP6SkhFQpyYTgQdvCM3KWzDcjL3g2z3eIIvyITSIy/w/yiI7nTLJW66nghlnNjlFkTixudjyHv2NoeKTAhAwYc4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1FEeTNPNmpmcVN4bUU4NzVoV3ZpZW0rM292UDNTZy84SDVteUNNcStGWCtR?=
 =?utf-8?B?MVBTMG5pY1FEamVxd05xVkg5anhKVGN5b3JZVzhDZEdTaFU0UWRVUjQ2MS96?=
 =?utf-8?B?MFA5V1o3Qit1Ykxid0dSMFlUdW1LWHdhZm13bWxZYmJWK0RJWWs3WnZ0NGhJ?=
 =?utf-8?B?clpmYVNPV1N2VEdqYTdVMVg5Z21hZDRsa1lYeVRoUHIrTFYxWGFQeVpWNFNU?=
 =?utf-8?B?UlBFNTNQTEJUZ2UzbWJGK2hYU2xVTEFIa1BhdURYU0s5bFZlRU95RVN2b2dN?=
 =?utf-8?B?RnZWdVlzSFdZSVZqc0dYcUsrSjZFSHg0RU1FY1JENHdnWFhHYzB2NlEveDVo?=
 =?utf-8?B?amthcitxS2QxWXc5Sml6d0xvcjFyUzIyWG9Da1NFV0pCWlN3b3NiVXJ4bTlj?=
 =?utf-8?B?VHB4eTFTREt0N1BBaGhCNFBZeGlvNUZjTnBFVG1rc3lEOFoxMDB5RU9OVDlx?=
 =?utf-8?B?TTVINFdaak8rY3hHSU5rQzBXbEZyUWxCTTFzaENtOFlZWW9kbWVPVWU3V0Zt?=
 =?utf-8?B?TGw2SFk0NnpxZkpkZENtMzZuUjU0Mm14UFIrakZUQkx5dlZMUUVDZXFhcHo5?=
 =?utf-8?B?SkJ5Ry85U1ZGRXNOYWpRMms0eGtpb1BBMmpYYldTempyRWwyQVFHS1ZJbkVq?=
 =?utf-8?B?emR1dnkvS01qRlJvbHZNR0dYR0RxS3VEQm5neGgxYnBZWTNraDB0YllJRE9p?=
 =?utf-8?B?WFBqbG1tVFVEWEdkTEtEZVRZcGF3TUZDMngrS1MraTZqZ1lXV1c1SEg5djRG?=
 =?utf-8?B?TCtuWGN3TG96WGFWY0dLTk1pNDVOZVZlYTBEdEdya2hvRVF5cldlSGVNVkJz?=
 =?utf-8?B?RWd5QlBnTFJGWkQ5RlVMd25kV04xaFhIQnlYSEdST01FT0NWcWhGVEszWTBV?=
 =?utf-8?B?cFFXOUtHaG9RRUM0VnpzSi9RQzY4MmE5eVZGSytIMEJYS1l4QWxydU1SVXdh?=
 =?utf-8?B?akhocHZvM0x0NWdHMnFxRUdGVkg3QVhhWWp6M3Z5VWplNlRaL1B6K3oxeUd2?=
 =?utf-8?B?dTkzWExXa20wajAzNUZkdlIzOW10SitTNjlEZXhma3dSMEVMeEJ1Qy9nanMv?=
 =?utf-8?B?dDV3dE00aFloWWdYdTh3eFp5TXN3WkNhYUFVRHpzdTMzanVyQzd4dTk0cnZI?=
 =?utf-8?B?ZUxPK1VhY3pHRERYUTh1M3ZPUzR6RlZVWGdkdWVDQ25nTlU2THlVYmdKZFhW?=
 =?utf-8?B?bzQ3V3dBaW5mQVBsRWh5T1FKQ3ZhVE9PSmRFdG4xdjJVZTVwLzUzUjZZZFBG?=
 =?utf-8?B?cnNZcThJWXJITUVmQ0VvT2NFa2VEazJPOVZsZjFUMjBCdG1rTDM2OVB1NGFN?=
 =?utf-8?B?VVFsL29rVGhFVE1NSWl2VW1ZMGFMUWFUditKRFBjTkwzR2NWUjgvNDMzVUNr?=
 =?utf-8?B?TVRvWnpoS0V1UCt0dktIM2RTVVhWaE1FS1RnUWhwZThBWVNMS05IQmtoR2p0?=
 =?utf-8?B?RGxUdmVxZUZreUdVM2JGUTNnZVMxRjBPU25GeDFEdzlkVzFXWE1jejNUdjUr?=
 =?utf-8?B?eFhTT2VzZEFSczk0cUZwUDZhNUZQZGZFVGVLSGgwN2tPUUtSd1MzQWgxSkZU?=
 =?utf-8?B?dDJ2NmRVREJSMER6L2VjQ1poU3FIM3JmemRrOVhHNUxHU0xLWmNIeXNtZUlW?=
 =?utf-8?B?VWpzeDd2SFZkbk5wckhjc0xaeWo5N0ppWXU3Y1JDK3FJOFZtT3o4WkJlQnly?=
 =?utf-8?B?eWZzMTJlNG56NmpKWllEdGttWDZsSFN4U3g0eU5BRHNkL2dJMktDZ1kxSy94?=
 =?utf-8?B?Y3J3Y0V4aW9mL3NnTlJSdCtMajlhRG56RGR0Tk1Kb1Q2dlNvY1g4MlJzaTdB?=
 =?utf-8?B?YVhWMmh0QTJBWHc4a25xM3Z5WG03NVd2Wmdzd2pqaTZYVWdTSS91VmNGWU9v?=
 =?utf-8?B?MFpURGQ3NVRoVFJZNzJ4N3I4MlVmaUVwM3I1eVAvN2s5cDhLRE9LZUZ4b2N3?=
 =?utf-8?B?aTduK1VENzZMYXZhMStJQTlsUWNSc0I2NGRrLysxWHdTMWxNcisxaHZLdjBo?=
 =?utf-8?B?ZUMwNGNKSFJYNlRrOG10SkVhSDE0dFV4QWRGSG1yZ0lqcThIOG5oaU45MXRB?=
 =?utf-8?B?UG51NnZBRnByYWl0NFZQTjVMeWNDUzdRWE1CUjkzNWVyR1YwbWMvdVA4RUJD?=
 =?utf-8?B?MVRjMURlK0NaNjJML0Jybisxb1pLRU40VlkyYkIxeGp4TVU2SjdLbXVqWFNE?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l4BmtXQSa+JSx+sfncvcpbusZsWWz0V4jBedV41nlOseAaZEnLaBJki1hQdVUGitCdun3r3frcaP51KubARnJfZQN8NmlGdBmWsgb1ou0MMs73IZGx+KMazrnyroAXKP6g1TCH824dzdALAh/7Nb/uKfofsZtD27HT74yzEj3NEPwBUyzcEEERXJX2jWKFtY0nJPQjbUxJcfY0bYhJIcHdH4SBNsKtrIAGsa1UqNo/mJ+fVFqWKB4ro3RXtO7e7bT+CU/E+xqJAScUM4JjyCRBNjLZeCmTDch4cFfxRYuVPDEnt9bZ+4I55xGIdaljaK20A8YOuaH9/1oiNO3hzYO+P65AeuA3p2aZ5lgb8vkDhHMycA7Oo86phM/QUM3LTuKwKrnN32lWfhoyBBMOTbflvTzIr5pJrh2ccppoWUU3N4CIpKQj9Q4jJEk1gy2yyRuXb3yTJzus96nrowjy2zGUWqqYXgOK8gHli3mabZzJMfyBY8yA+NtSxwfOI8pYjMPTGX1q+Yj1YZUSLnULTNMEgWJ2PShDJQVV68Jk7DYQIZa0wwzBSJ4n5JoIr5/9Oxhgh/E6BMVKqSCDsrWi6E52Hs1clbOL1fh/TQnMxVuFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c571e861-cc7f-46ce-eb8e-08dc4e8c60fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 18:33:21.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es/nS4Bi3FoW77/E0wA53HQue5fyKdA9GYrWE+SBotYKx9jseyP+hUlxsqzoZMgrCxAj5OsZfPapc/jSBHnqmOMQ+SIfQc9gHEbDtm2jKLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_15,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270130
X-Proofpoint-GUID: 64J2NAemwSNawRan3cPjERjYov9WzJFD
X-Proofpoint-ORIG-GUID: 64J2NAemwSNawRan3cPjERjYov9WzJFD

On 27/03/2024 18:17, Muhammad Usama Anjum wrote:
> On 3/27/24 11:09 PM, Joao Martins wrote:
>> On 27/03/2024 17:49, Muhammad Usama Anjum wrote:
>>> On 3/27/24 7:59 PM, Joao Martins wrote:
>>>> On 27/03/2024 11:49, Jason Gunthorpe wrote:
>>>>> On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
>>>>>> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
>>>>>>> On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
>>>>>>>> Even after applying this config patch and following snippet (which doesn't
>>>>>>>> terminate the program if mmap doesn't allocate exactly as the hint), I'm
>>>>>>>> finding failed tests.
>>>>>>>>
>>>>>>>> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>>>>>>>>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>>>>>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
>>>>>>>>                    mmap_flags, -1, 0);
>>>>>>>> -       assert(vrc == self->buffer);
>>>>>>>> +       assert(vrc == self->buffer);// ???
>>>>>>>>
>>>>>>>> On x86:
>>>>>>>> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
>>>>>>>> On ARM64:
>>>>>>>> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
>>>>>>>>
>>>>>>>> The log files are attached.
>>>>>>>
>>>>>>> You probably don't have enough transparent huge pages available to the process
>>>>>>>
>>>>>>>       echo 1024 > /proc/sys/vm/nr_hugepages
>>>>>> After making huge pages available, the iommufd test always passed on x86.
>>>>>> But there are still failures on arm64. I'm looking into the failures.
>>>>>
>>>>> Oh that is really strange. Joao? Nicolin?
>>>>>
>>>> Definitely strange, I'll have a look.
>>>>
>>>> So it set the expected number of dirty bits as that assert doesn't fail, but it
>>>> is failing when we check that even bits are set but not odd ones. Like it's
>>>> hasn't set those bits.
>>>>
>>>> For mock tests there should be no difference between x86 and ARM assuming the
>>>> typical 4K page-size. Maybe this is 64k base pages in ARM? That's the only thing
>>>> that I can think of that affected mock domain.
>>> The config is attached. The defaults are being used i.e., 4k page.
>>
>> Looks like CONFIG_IOMMUFD_DRIVER is not defined :(
> I'll retest with this config and update the patch to include it in the
> config fragment needed for this test. Once we add all required config
> options in config fragment, the test should never fail. Somehow this gets
> included in the x86, but not on ARM.

The option is automatically selected by an user of iova_bitmap_set(). x86 has
AMD and Intel IOMMUs which use it and auto selected (ARM64 doesn't yet, but soon
to be a reality). Some vfio drivers get it auto-selected it as well.

But I forgot to do the same thing for iommufd-test kconfig in commit a9af47e382a
("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP") where mock domain also
uses iova_bitmap_set(). So your patch is likely not the right place to set
CONFIG_IOMMUFD_DRIVER=y.

See Jason's snip on auto-selecting if IOMMUFD_TEST is set.

