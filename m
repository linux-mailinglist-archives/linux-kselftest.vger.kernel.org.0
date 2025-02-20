Return-Path: <linux-kselftest+bounces-27070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B39A3DD59
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11222189A77B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052D81D5CC7;
	Thu, 20 Feb 2025 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QcRNTUlX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mxb84fvH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA351D5147;
	Thu, 20 Feb 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063169; cv=fail; b=felSY7QB6LfRl7uDLHSEeaKPj8HuFw6cUn7S/3BP1U7/34C/IIk1F/1O4K61/7XZf6vBspJbs3/VMLObTWLC1SkbfxRQNo7sB+K0cWsK5f0rB1pzMbvbK1SUiF+IxNJgZwclLaXTj2VD53kVqfcj+Tq5fNPxruztDxySaoEy4TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063169; c=relaxed/simple;
	bh=Sl8R+7iBUz9WaA+tsz9v4wF5ZTcMZgh7g4pgLLCzXT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L9WLsM83qHbojptrUsgIB3x0cFzKlDIPrvSCaffmbf0+NXC7E1VMo1TjrMdqCv3ild54bsbzX0vgOZBiB3IXQWEyxpJjjvJuJdK5wPyzjYDj6jhemw01fRDB9/iGuuZTz3cQjDQorFZfKAz05vlWcVmKSITUKR964NyWBFwkBJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QcRNTUlX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mxb84fvH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9fb3S001626;
	Thu, 20 Feb 2025 14:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HENq3bA54GGH7Yb38frZloVcPvTzbWu6E96quwCWgPc=; b=
	QcRNTUlXYiKO8F5eLZQWwoVjyzaDIaNZjrysk9kWEtxKcj+e+e/5VTcGJb7MJhY1
	HJXBegQUOEpxms838KhXtRfPeUWLh25wQjZuIe6b59BnXcv3hAR5TQ7sdG6WRckf
	6LkO89n+06FWTFw0015Xt36V2TWGxzmrYLPVwVEVkx6RmYnssAcmvzIVshK66G2s
	xJIbTzhF6QCz4rWi5on/gGE3c4H/tw3VHx9ZgZ9GB2lR4G3s/tCYE+yEs9E1X2UL
	TRxUxGHp6+zTrukDgdv0+NirmxDbbEozHWZ195GriqtEBHb4ej3tmm375tO/KkGR
	sLbId0w2xV744q/HYqFEOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00mv9yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:52:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KEkFEi010490;
	Thu, 20 Feb 2025 14:52:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07f1qu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILuDekFEM7YJ7PB3jGMiGD/xBhc9GEiOT2TE1hQv7aRagOXhohK3eBSeuWNzVe+s1zXmStMpCSi0oXY/kulI9XuPtTGRgFTZjD9p/LQxR3mNGzTQBuus/R8j1XVonm7yaiEpP3NLnOTGGzdgP3mpXoj57eRvd+QgbFbMqIHhY8AmIernesQWmNtD7gxGJ7Jkp1ziZEywdpwPLr+jCd3Wy5RwD6fXhSCTUfAQKrR/hOkpQ4/KXBSYXGDNdnQjFJn/SElfHgMq42ytzIfbQ9l4lZnz/iFCff13wQvSyuKVbSaVvU3odEfAbJhVPLFmmYQgbP1MFoDKM5yJhjw4uOfoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HENq3bA54GGH7Yb38frZloVcPvTzbWu6E96quwCWgPc=;
 b=uKR0qEmsU/eHy8LWMHNvj6zjQAa2IFz+p36aaMKL8YfYmXqx3Wu3MACR1UdyYOZIuB9AjyDhYRMdy8rzHQqmbJbsehYY4mHsq3IsV9JJwNV9+6x/ixAxF9faiiWwy3slBaSf3Hbx3hvwnnS0S/UTAoFxWvZWr+4nwdBQlUdR0sE7nxG8qX+/6XY2qAFqO0A6WkUvZBZAB170vSceuBJTSRtdykRklzwj8yXrzMbfGDJWjIhzRD9YTls/EeOaMKaNoT4XmRG+oUTrb/NK4fFZQaOzhMQl1l04ns3jNrtnoCDtO3TjktLYid9SJ8Agbx4uBVbX3MiSODmSorTOdqmT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HENq3bA54GGH7Yb38frZloVcPvTzbWu6E96quwCWgPc=;
 b=mxb84fvHpwvVNOyjCbfBYIMnlyB8f/epJtMkaAR+w7g5rJH+8f61LfE1OdNrTk6O90j2paFafLz1ByefXZGvJcBKPOYDV6piVNzKWwfFoaMp5hIZXvvCQ1POYr2T3sE11DgjIvsfmbG6Px6RPTtkZlGa+Wo/mGCJaDfajKKz9CQ=
Received: from CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 14:52:40 +0000
Received: from CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e]) by CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e%5]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 14:52:40 +0000
Message-ID: <a3b5bbc0-f875-451f-8528-38a7eafc4949@oracle.com>
Date: Thu, 20 Feb 2025 20:22:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
To: Shrikanth Hegde <sshegde@linux.ibm.com>, chris.hyser@oracle.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
References: <20250219064658.449069-1-sinadin.shan@oracle.com>
 <74dddd26-4a0e-4bb6-958a-229cca3c24d1@linux.ibm.com>
Content-Language: en-US
From: Shan <sinadin.shan@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <74dddd26-4a0e-4bb6-958a-229cca3c24d1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7211:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 9239612e-52df-42d6-ed2c-08dd51be3914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW5OWVpDZlZXYXpqN0paRWZDdWptcDlVLzVLeWk4T2Z3NzNhZkUyaFhVM2xI?=
 =?utf-8?B?cEw4OGpMZ2x4MFNkTGR4cmcwUkgvUUZXbFk5UlQrWmZydEt3T3lRVWlZM3U0?=
 =?utf-8?B?aG9yQ2V0MXFvWjllMnhQOHhHblFxblVoRmhwcWV3NFpqVFVibzdJdXVhUm92?=
 =?utf-8?B?UTBLRndzYnZjb3hFUHFkUDY2WXM0UEFGd3NXVU5GQ0JvT3FpY1FrU0hNZEZW?=
 =?utf-8?B?N3Rnc3VyOFQzSUIvWVFqQ3JCYWdkMXN2TmRiSUlQbVBlZ1Y1aFIrc3lDMm9k?=
 =?utf-8?B?ajBVTEZMTEtMZ1h6dEhITXA2THYzalBYLy91V1c1anpWb3IvRWlydFRLcUZ4?=
 =?utf-8?B?clJtY0IxcE01WUxCR21Qak9uUkRUUzl3L0s3RWUxMThXbGZ0VmY4Y1lTcmpn?=
 =?utf-8?B?OGxIK2RPak5TMGtjSU9BQ1JnQWZjUEJ6QU00dHJ6V2JqOGU5Y2ZZZFJHMmcr?=
 =?utf-8?B?WlZFRkl5eHZqaUFpZ2ppT3d1eUg2YXIvRnEzanUxK1g4UDNyUEU4UFQxOURY?=
 =?utf-8?B?RVFaSnA2SFZsRzY5QThibnlQRnp1TWFFWk1xaVdlSm9FUzB0MGgvaHNWMVN2?=
 =?utf-8?B?VHFSNVZaYmptam82WlBkNndYUkgreCtFQk1UN3VHaXNEamhXYmxJN1NUZmVF?=
 =?utf-8?B?K0ptNDI2MjVLUElhejhwamlqc0QwL0JqZGVHMWFjV0l2aWxtdEdXbkkxOEhG?=
 =?utf-8?B?dmVVU3k1T0psSDZ0bnNNNmlKN1luTXRtZjFQZEd1c3F0V2JSQitBM0pPWi9B?=
 =?utf-8?B?a2UvdU9CM2xEcjZtT3dycGw4NU1EaFU4aHNZZjd2Y1o2UFZiRXovZ09IeG9I?=
 =?utf-8?B?OVRHWFBjK1YyQmhXUHltYk94RzBGTWVTY3M3enM3WmVmYWRiVXcyaFNOQnZE?=
 =?utf-8?B?UUJvZVAwcWp6bkxlN3U3WGR0azJNejhqSGtYRm1NenJPZ21aUTZrRk0zNnA1?=
 =?utf-8?B?NjIzY3VTSHpEd3Z2eDZJUmRDOTVkN2tVRkQzdjgxUmFteW1vK1ZIUXBPMWJi?=
 =?utf-8?B?aHNNVmQ0SFVLY2ZvQkFRQldaa2ozamRRaHZFaVorSXNRUVhLWGNqNEU0bDNh?=
 =?utf-8?B?SFRlTVNOeXNwVzEvTVQ3Vm9COFFKWDZoM2tEcWlscXhNM1UyTVBnYWZMWlZm?=
 =?utf-8?B?YnhObXc4ZTlXL2h5UHVMdVZVLytLZW9yNmpMRTR0dEhxa2ZGcjhES3BjK2Jl?=
 =?utf-8?B?Y3BPc01ZTkhPMDR1UXc1NWNkc2dGMlB1TVcxZVBpNmdFbjhtV1ZpRVdVQnRJ?=
 =?utf-8?B?QzdoemFUUzhvcW5HM0JNM2VrenhrWHc4UURSWTJZVWNma00rZU5OeDRTL0Jz?=
 =?utf-8?B?aUl3WmRVa0RndlVPOWhHT0loUmt5V216cWx5VGNkRjh2aVpCSWVVM2VHaVdj?=
 =?utf-8?B?ZVM4S0pxY0Uxb3dLTE41OXM4d1hHT2dZS3l6R3BEOUY4NmtoOGVyeDE5cHht?=
 =?utf-8?B?Mk9JMnNUR3ZzeUdkNGdYTGUzOERYR1BTUU1FSExLN1hwYXFKYjYzanc2Rjg3?=
 =?utf-8?B?SFdnY2gwU2YveE1IQ2hMQUNvbkZjYWxPSHFWVFEweXUwNDJiZlNPNDRla293?=
 =?utf-8?B?WFh6MzlTdkRiMXhSVHA5UW0wUUhhUlJDK1Rqdy9MeG9zamQ4OC9SOGVYblBj?=
 =?utf-8?B?a1FCRXJRRlJZY3ZYU1ZpNEh2WGdWUTJudHJYN0IrY1Y2ZEllbmNYZTREcjNV?=
 =?utf-8?B?ZGIxYllXZkUzNnQ4bUVHa1JrekQxODNYbWdwbnpsUXkwR0Q4aFM3bzRVU2l1?=
 =?utf-8?B?MFdSRmZTSzN2U093Q2lpUGk4SnFZbGRtSlhLUGVxMU1TVmpIdGttZEJ0azhw?=
 =?utf-8?B?K1l2bkhGYUg0MzZkamwzT3VQZjh2V0xNNDcxaU4vQW5MaVlaMm5Ra3RaaDhD?=
 =?utf-8?Q?2vCHH4C6L5U5b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7211.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWJVSFArM0t6NitKRi81YzgrN0cra0wxSmM3ZnJ2V1NudzZyTlh5TGV4NUcz?=
 =?utf-8?B?cEtXM0prek5vZjVsaHdjOHlyUkNLU3grZ1FCbVFTMEhXdU8yOGR1OFFiRlJt?=
 =?utf-8?B?YzVFTk9pdHhuNUdqTVRmR0lTbXNhQzFIM0VXOU13Q1lJeFRYbFkwWXBuOXFI?=
 =?utf-8?B?d2l2UnVyWlZRZDV3OVlxTGxVR2lVMmtKckt1Mk1RM2l3OFBYUU1lcS9vOVY1?=
 =?utf-8?B?Q0N5ZEs2K2NEVnFneTNrTEM0SEdMVlRickZJRzlHcWQrQWord1lwZ0paWHBz?=
 =?utf-8?B?N1JmM0g4RFZnRnl6QUlYalRsOTFHY0dycWpzRlJYeG5Wc24zUW5oOUJKMUhj?=
 =?utf-8?B?OVY5ZHBVaDJjTk1NeTA4cGhLV1ZtTXEyQnhvcndST0pxaTVEUXdkSDg1SEJy?=
 =?utf-8?B?My9RU2k4ZDQ0c1luT2JESWxXazllcGdZQUwvZ09IZ09iejgvWUdZTmN3S1Jq?=
 =?utf-8?B?VDJtaWorN0xaOWhOZ1UrQ3JwZ2tuYTU4UDBzVU5kVXV2T0ZXRWwrZGprRTdl?=
 =?utf-8?B?WGFIajZvaU5DN1hYVitmelMzcHUvU0Y2c1VTNm95L1REYVJad3ZseE9ob21E?=
 =?utf-8?B?Vlo1RWZVZmxZek0zbTl6blhYSURZd1U2YlBORkdRT3pCaElvK1J6ckd6ODBP?=
 =?utf-8?B?U291L0M3YzJqTFZhWEtVbUxEYUE5TC9pT2tSaDZDakJXdGdML1lFTzN4WWRZ?=
 =?utf-8?B?MEwxUWpnVXR1QnZ1aGVxbldOdlB2SzNFck5VQUZLbk4zUGdIKy9GU1lQbWp5?=
 =?utf-8?B?L3NxczAvRjhjVVVZMVVEeWtvUGtYTG1MTXFLWm1sSVhjdmxxdWlVQTU1eE1R?=
 =?utf-8?B?bDBka2dFa016TU40TnpVUVI2bCtsNTNZVHNMSGk0a2dJNGk4NEtjZWZwNmd6?=
 =?utf-8?B?eG5MMlM3RWVNVExwN0htMkQ3VVRKQlgzcUx3dWRoWlIwVXdYUWwvaGJLODFo?=
 =?utf-8?B?QXdFWjNvaTB2ZGMxTEFuamJIcVVvc3NQdEZLTWVGOHhXZ21neVVacEEwUjlF?=
 =?utf-8?B?Y0s3RnlyMTIxRTFhdUNXWUhIdVlBTEF6aDBjbk9tUlZOVGdIUU5zNWg5MGpp?=
 =?utf-8?B?NU1wWlhTM1JIcVE5N0x5M21WQ2s4aHI3T0F2VnVvOCtDOGVCRGtKQm1nOUNH?=
 =?utf-8?B?NnRtcWdPT3pnbFUrRjR0dWMwS05zY3M4OFc1ZkpEVXB0eUZVQVFYS3hOS1Vj?=
 =?utf-8?B?MHN1ejhpQncxajNRRVFBUDZGWlRra1BZVXQrTDVJcFAyamtNRDhBaUNmSDdu?=
 =?utf-8?B?alRzYkZ3c2NjVGdvcm81c3VwVitWUHNITWV1UU10M0c0QTdycXQzNklUSmlm?=
 =?utf-8?B?YXJnbk95ODlBOFBobTQ0cStwdkpuelg3bDBpeitjdmpZWjloYkJpOERySTJV?=
 =?utf-8?B?RWtNSkVIc0J0cWg2cEJTd1pkNHN1eVoyWml2c3dENVlzb0NLM1IwazBsTE15?=
 =?utf-8?B?ak95bHRNdzZ1ZHgrdVFkNXVKZkk2SFMwdFl2VW01bFh4M0x5enJVc2lUTGh6?=
 =?utf-8?B?OW4xRS9jS2JFM211THV0NnF0QVFBVWtBa0ZKMVRhRTNoSWVrSXF3MWtaczBr?=
 =?utf-8?B?SmhFUjdpV01rQlNQcFduaUl2R2kvdlNDZ1FzOWZXRzQ3dVoySkk5QjRCQVZJ?=
 =?utf-8?B?aWRUN1R6aXVYTFFQY0V5dzVUYSt3NzNJNmxiOW40YkRvRmRtaVRsSlR3cjVU?=
 =?utf-8?B?c3laL3Q4UE5WVkFkVHE0SGtxUXJ1VlhLTXY3QjJjVEEyM2R6ZUU1QlF1c010?=
 =?utf-8?B?NFRWaDNhVHVqcjk1dTM5WnlZK3RzeXhINi9XQ0pVTUxYOEg2bjZXSkIyeUhZ?=
 =?utf-8?B?dTNDWmdzVUJ1U0taSDVvb2Raa0l5dTBDSmVzV1I0SWI2d0UzWnp4Vk02ajFE?=
 =?utf-8?B?RVBlVE1aeWlodnpWZSsrWVhWQzRDTXg1ZEwrS1FtOHgvdkJNZzRoS1cwMkEz?=
 =?utf-8?B?NEVlRk9HZy9DR21jT1hBdzY5TUJyUENmQmIzR3VpK003SnFRSm1EamxZTzEx?=
 =?utf-8?B?Z1JQMlNKNTdSckZNdStqNGh4SDBTeENrajh4cWZTbUI4cytIekRlL21MYks4?=
 =?utf-8?B?b1VDTU84MXRPQk5sUnZOL2ZJMUtwa1piTFZxRDFyOEJENUFUZ0IraFhvTHZ6?=
 =?utf-8?Q?DxFN9ZmpBBdp06jdbJQcK5UuW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HJKqkdo99TGFkCIYSoRlMwJGhySEXw3Un+/PiqJhTKmJR82K+Y+l33g7hrDawJxuVikiTAcwHUCoqgHAmpKTznc21xA1tckRT/uQmaIG65Ji2Rmskk5Pjt0cAhOJYenka0FkxLCkmI9Tee+VaUS220HDoQjtp7lD6Havf1NXWUYKm6aMvlLzoWguJVwguzk5vBpoF8wZbokyIDt3MpgyXbZX7zdFylKlt14iTMPqjdpxdSWLRYK037/vrncY6FIFuBuP7VmInxNFjWIz/PxWhwiVpZqYWQMtvdujUTWpd/fSBrgtm112Sq7zicCt0USSoutMd6zUc99HLGO349BLfNj60iWEnBegUVNn4fHsECqg8ZGiT97HYKmRLQUPIrJKSHo4XQMc7A/qBqsxesRIShZZFRd+weCkk22rXqkZwK0TXP8U5Ieq/BMXm64ANPWeMDPZixBxb7+IMhE98gQYDG9uG/GbDFob/lbtXCcKV4dDrAR7oGn3aw7LdlErdiVxCD4B1t4e+Vo7RgmYTNdLorbLfBD6zqgzq2YxTUxGMXNRwrOfgBzu5Mb5jtvr8Jy2j1wvDoyZmvUXDB9rZYdN5FJJnOTXD1mzbR4SUAiPwtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9239612e-52df-42d6-ed2c-08dd51be3914
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7211.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:52:40.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iA10BBmSxyuTsIdSz3AG/pFn3iVDXWzaarIF2k2X+UFHVCYAmzQMw3cI0mxa0+B50caN6oAv9oH2jKxRkB8bVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200106
X-Proofpoint-ORIG-GUID: GDhRUBHOnsaFEi3qRgLp5xXVKMLq2DES
X-Proofpoint-GUID: GDhRUBHOnsaFEi3qRgLp5xXVKMLq2DES

On 20-02-2025 01:15 pm, Shrikanth Hegde wrote:
> 
> 
> On 2/19/25 12:16, Sinadin Shan wrote:
>> The sched tests are missing a target entry and hence out-of-tree build
>> support.
>>
>> For instance:
>> make -C tools/testing/selftests install INSTALL_LOCATION=/foo/bar
>>
>> is expected to build the sched tests and place them at /foo/bar.
>> But this is not observed since a TARGET entry is not present for sched.
>>
>> This was suggested by Shuah in this conversation
>> Link: https://lore.kernel.org/linux-kselftest/60dd0240-8e45-4958- 
>> acf2-7eeee917785b@linuxfoundation.org/
>>
>> Add support for sched selftests by adding sched as a default TARGET
>>
>> Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
>> ---
>>   tools/testing/selftests/Makefile | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/ 
>> selftests/Makefile
>> index 8daac70c2f9d2..e2d0d389ad912 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -91,6 +91,7 @@ TARGETS += rlimits
>>   TARGETS += rseq
>>   TARGETS += rtc
>>   TARGETS += rust
>> +TARGETS += sched
>>   TARGETS += sched_ext
>>   TARGETS += seccomp
>>   TARGETS += sgx
> 
> There is only one test currently in sched: i.e cs_prctl_test.c. to see 
> the cookies validation when core scheduling is in effect.
> 
> If CONFIG_SCHED_CORE=n, the test fails. So you might end up seeing 
> default selftests failing on such systems? or this is only compiling?>

Yes, this patch would enable the test to be compiled and run by default.

> Likely the selftests/sched needs to modified for CONFIG_SCHED_CORE=n

Agree. Chris, I suppose then a graceful skip would be a more right 
option for kernels with core scheduling disabled?

Regards,
Shan

> 
> When CONFIG_SCHED_CORE=n
> ./cs_prctl_test
> 
> ## Create a thread/process/process group hierarchy
> Not a core sched system
> ...
> Not a core sched system
> (283) FAILED: get_cs_cookie(0) == 0



