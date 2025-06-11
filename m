Return-Path: <linux-kselftest+bounces-34678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71260AD51CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6401BC1563
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D69A262815;
	Wed, 11 Jun 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MyQz7tY+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rcs72u1F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162DD2620E4;
	Wed, 11 Jun 2025 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637531; cv=fail; b=mze1fUWKSxqKeV41hrrGPIqaNueYjRbZ0Al/Hi4GAXcze6DY3CzT32irbb0Qi98LrdMcbB2vdUbegckrBgm2y+6HbUtLEx5msj9n1MSN1/FduR49S+Rbo3sCm/Sp7J2VBZVtwHFnpzvsNPZ8Kv7B8Ufa5CYxjWGRHiWOsvJ/1eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637531; c=relaxed/simple;
	bh=Gzbmr1oRuP6zXXxUl0SV4frT6htCs5HWuaGOvcHr5Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MyFQHjS0ivO8fQTob8GO9yQPk6zZTzD7EfX47ZAZ2S0nCViQXYYiNdpPUH2owA3axl+eLIMG52cNZFE9BJZvbDPzabQvPHH5ib7q0d1jlbPLPR012J+RCVbxKvtzIw/OnYGhGfn6reGpsMpjHOBhhxDAvD/krHvKtWoS34by7QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MyQz7tY+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rcs72u1F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B1BqrJ028262;
	Wed, 11 Jun 2025 10:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UXb2B5t6uSNuh6wmWg77m931es9Lylgvn0RnyIyEBjI=; b=
	MyQz7tY+UW55rCqndPnXnV8NMTgGoDPQGOj+zNS83niUftbcQh0B86D/fzLqLUMp
	eiTbBUAioUoJBrKTRDIhIaNW04oBe8GjuYsucQ+zPF8kXyolBAUc9MDieCxjixeW
	qMq6CnZKinFOeTm+y0p/QwiD310TDNU8h6+33PZ5TemOsrsChMt5tY97k1GjxgVF
	7/P9kEihsU4iPvCvyHAqe9OcS3lnMt5M8VZDNxDQvCwFAY7MDXE8P9EFHhoIXTe9
	VW84Tr151IYs3VkvQMFGTOH6QCZTQ4M+ccoAhkbvBCDx04iWjbs3ZNfOH5gOWorA
	61bg49hCMoCG3U33UVa+ww==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14dx1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 10:24:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9tKsW031946;
	Wed, 11 Jun 2025 10:24:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9y1d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 10:24:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntdYdwtyR31SM8gPO5R+RMI078mB91L3JydVGRXUZwr951G2xw7Dfui0oHSNoyGMmKmpy9RNXXP42c2qB4a6t6KEFzKB6nfOsih2zTfb/rrBldqHA+ttPOYGn9aeyMxZYOUfeW7mcenOe/zlvu/TIOZA9CGfjWOaz5Cwplwv7LWZ+4ZriHJJW5P0cdEvv2f5JROJsNJ55D6aanoMbWHx6VG88QUpwMlj7VCNYZOAbr47kwszV1ydcIOwgfqe17ywcBO0zaLIg6wSZQEh4Ve8YdvDpodk0SmC89zJcCV5fNDMFrhj/+wXUtOneP8c5GKjFQ56MaM1EeBKxnklYZNrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXb2B5t6uSNuh6wmWg77m931es9Lylgvn0RnyIyEBjI=;
 b=P4ZHBIXkDziLRLWl0iIzJhGz8Z8UKhBXtEwAl4XvY3OnvDN3L4fxVzKLVaMSpgPutqHyrU27PSZ1CDGmqCAno43rSOym3xfo0UH+JUkz8+AcjOJIF8DlsN6wj69r/SXSdCCXs9RsrMQAz+g5lfWu7hs8KPvWiUXQdcEuF3dntrRFojeqXEXamtm+M0QFG5TKfwtxynPB6bqrIpVN1pIjDwARTzcaq+ggHbrQ8D70od59mGNMdelaXNETfMaeq0MHLhib7EjwGI5lkh5b9epCBhDU35M3H/7pW23WRG+VpWBf2BLUGD4jgfO1vra2+Q1/wjVoSCCpqzj0bvKcoLMYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXb2B5t6uSNuh6wmWg77m931es9Lylgvn0RnyIyEBjI=;
 b=rcs72u1FmkXZbntRZv3laWE8NkrAkF3KSXkrRMptvrGPech7qLFkaaiWBq8WNPDk63cW9MTLUWo3WaGjX1PVDvoWYjALU3ych8xkTSH0F7EI31DWLp2NF2rOb/hDMdtaPgAsvcMnEOT9u5486pwiP93sFmHlZgVuBjtu5N8qCJs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 10:24:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:24:45 +0000
Date: Wed, 11 Jun 2025 11:24:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 6/7] mm/maps: read proc/pid/maps under per-vma lock
Message-ID: <7a26aae6-8695-4bbc-b00d-47d0c56b9cd6@lucifer.local>
References: <20250604231151.799834-1-surenb@google.com>
 <20250604231151.799834-7-surenb@google.com>
 <4cefe058-d67b-491c-83ac-293544385e84@lucifer.local>
 <CAJuCfpGxTdnEgKj1Mgu2bGK_6rxnBd=Sk5HiKKdp38uMtEHu3A@mail.gmail.com>
 <6364468a-ca45-4e21-8c4d-3d9c4e6396b8@lucifer.local>
 <CAJuCfpFb4Ky0Hw71KePuMPi5_pPPgK-9rDQ6HRAf39CfcWc6cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFb4Ky0Hw71KePuMPi5_pPPgK-9rDQ6HRAf39CfcWc6cw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0659.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1b86ad-3652-4949-7040-08dda8d22f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2NBVUhYc2hrMzNsMTdjSUs2NVZyWkR6MjF3UVkzUklHNmFPZWwzYWZRRGow?=
 =?utf-8?B?VUFXbzZTb1M4TEkwamlIYWdOS2Y4L3VpR2ViaTNWbDdKd1ZqNmRQRVFQVHo5?=
 =?utf-8?B?akppOGhNMlBHRzVUN0FEZ1VIdUVTTEZOeC8xam85NWptQVBnK0Q3OWRwV2po?=
 =?utf-8?B?V2NiU1h6bzB5WXZSbE5XWSsrNUtxSXFMditiaWFzU2ZKU0tPMkFqeTY2em5p?=
 =?utf-8?B?YXorUEhDbEtESmJDdmVDZEhmbHVEb1dWYW9PalorWjRSVFFxSmJkWjBrUWF1?=
 =?utf-8?B?UlIvb1lhWXJxRmxtVEJBa2UxSGpYcVdLTjZrZlpjdjROOE5rOXZMK2oyNVFD?=
 =?utf-8?B?Y2RWMktZL3ZkOEYrQUVtUC9PeXoxbW9QVG5ocXdxMFdab2NIRXBlbzA2RVdO?=
 =?utf-8?B?OUF1RlJNWWU4a28zeFU1VURRbnlaaDg2VFBXcmZCZ1BuWUNxbFRwc3A5RDhr?=
 =?utf-8?B?N04zNmNzSHNhVDBsa2x5WnNZMm5nUllDNUhJMW53MG5hMlRYMUsydXhjQWdi?=
 =?utf-8?B?MEcwc2U4UGRJUk00T01LVkJ2U0xSTlZSU3NTU0ZieDNhWGVWWEMrUjUwZERq?=
 =?utf-8?B?UTc1UlBpajFXcWRMOUNCZTI3RmpHZHhBUUdINVVJd2hxMm1YRnAvOUJ1K09y?=
 =?utf-8?B?MklHMzVsdGZPeWdSdzBBeU1qUzdBcDVXWVdSZU9hYXJPNHJRalhaaGhnS2Ew?=
 =?utf-8?B?V0Y4NWVkUkZ1S3NjMUNUbXhQUWhaMHUvM2JQTDd0Sk9BN3RzSWFQc0h6cUVV?=
 =?utf-8?B?REZueDRnUnkzZ0NCWVhCbkY1cW5ZT2xXMHhkQ1ZzSEhSb3o0aE1UUmc1cHN3?=
 =?utf-8?B?S2t6dDR1L3FLUk10RllxUndrWUVrYno1N0JxL0tVZHRRNXlMb01KQ0gxdzN5?=
 =?utf-8?B?T2VaaTluTjBidk1xb2p1RVFha3kvVE83RFErV0ZDdXNrMnY5K1laRWV0NkZp?=
 =?utf-8?B?eDRSWHlBVkZhV1BselpIRmFldWZNa2tTWjg3czRvYVkzcncyT0hxZmM5M2Ns?=
 =?utf-8?B?ZTBzaHJqaEFZY0NHTnkwb1Y2aUxCa0pzMHVETnZJUG1qQTVPL1lFdWh1akIw?=
 =?utf-8?B?eXZxYkdNVldBN2tDSlUwcXE1bWhzVWRIOWFFaDFodGNWZFc2TUxlcTlQOWtW?=
 =?utf-8?B?d2xjNm1ETmJZSlVYRnZNN090Y2F5QTRFeGF4dUd6NldWNU11cHFKY3V2cVNk?=
 =?utf-8?B?REZIc2lJWkhiazRJOGd4ZU0vaWpUNEZJV0xMOVcyT2hLUGp5aWN5WE1NQzZV?=
 =?utf-8?B?R3dhQ210cTNnUEJYWHVIWkZDYjF0dVBNbHk5UUFBZE1NNVFDcXVMVDdDcXRC?=
 =?utf-8?B?SEgvRHpYTEVnZEI4RU9ac2E4WmVoZkhQWDhXbEdiNDF4ankyMDRxQ0E4YUM2?=
 =?utf-8?B?VS83ZFAxQURCb2dlTldmbkxXL3d1dGVBYUtlT1VvOXJoQTNCVGZIdDBTU1d4?=
 =?utf-8?B?czdnTHVWNmdjbkpUbjYydlArVDFnUFNzYjZNRGcwRHVhWE94ZHFsbEZPQ2pN?=
 =?utf-8?B?OVhwRFlXdCt3c1M0TndvRkJmTWw3UHFiUXhpeGxYL0tyeDcvblg4YUxiU1FK?=
 =?utf-8?B?V2lua253ZTMyTXI5VFBKNUpSZVU2Zm1HSHU1TVY1TWJ4OHVzQXBoVVVLRGpq?=
 =?utf-8?B?OVdLNWoxWDlBVlJyWFJTaExuY1NrMlB2bFM5M0cwUHBxaDdKS0tEdnJuSTBn?=
 =?utf-8?B?U21KelpGb2dTZFFVdWJMT0QxaFQrQ0Fhb29hdkdkbnk5L1MvaEpkNlhvS04r?=
 =?utf-8?B?Z3YzYmFmaFRCUnZZMm9iajlVYlc1eXpnTjVQdy9JODZncFNiVWVLaWFqZkFL?=
 =?utf-8?B?UG5ydTVIMnp5ZzM4Tkh3OGFaZkk0WjBRNEh2QUk3OVdwT2VSNGMyNmM1dXZV?=
 =?utf-8?Q?cJFJM+usoHYF0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUNxSXoyemV4SS9jbDNSbTZ2Z3JxeXBpSFpRcUU3YjJUaks4Wm1ibkxwd3lJ?=
 =?utf-8?B?MDBXbDRBOXhXbGJaWDZSV1A5MWFudU5mT3F1bFFKdU5MZURBdDRuK0xad0hp?=
 =?utf-8?B?ZC8xSDNURklvNlJEU0ZscG1YL2xtYlRVd3BIc3dOVHluWGQyR0Zna2g1OXBj?=
 =?utf-8?B?dnYzcG9LNmY1dzNScUcvNFVrWkVWc2JrR2FNeEZDK2QwQVNUdTF3VUQ3UHY2?=
 =?utf-8?B?MHpuMEF4MTliWlFHUUFDb1d2dzZTcjRqVlRnY3VaU3F0YlpkZDBvdG5NeWRp?=
 =?utf-8?B?dWRsaHFFakEvelRRS3dqTS9oaW55LzJ6SEVxbndVS3JJVWIyMzdqM3NFOUtN?=
 =?utf-8?B?MnpNd1o1YkJsck5VRFdzNlYrd1dISksrVFFid0Naa2VKbVAyNzdZMnlDQ1NS?=
 =?utf-8?B?VnpHajZyUlI2bUhqSU9RVjNUN3RKS2tmOE5uN1Bpck11cGVLSW1jdG5EYlcw?=
 =?utf-8?B?ZGM0R0hSMFZRT2g1TnJFMHdIM2xnTzRvRThxR2FsS2trSllmM0JReGJtQ05p?=
 =?utf-8?B?T3l0Qy81cS8xRDNZVUFSL3ZZUTBnT3AvdUUrUDA3WUlDS2RsU3VuRmF1OXFk?=
 =?utf-8?B?RkhqUWZHNFlaYkpWNkJ5ZGVEZlBnaVdVbkNoUVpOMS9LZ1h2TXdpalNVdnVi?=
 =?utf-8?B?UDFLUktPWEFIdVduTU9sQTZoR0Q0TUZRSFIwcSs3dGJPTFFEalp6K01PVkoy?=
 =?utf-8?B?bjNjUTEwWVhqd2hSaGJqaFB3VVJ4ZHpnWGhVQWNpYjhWS0lnbTBWV25ORDdo?=
 =?utf-8?B?TEZUTG1hNENHbVAwSTJ4ZzdzWU41NUlXSWx5OFIveC9zNkI1WHRkbzFYdFRx?=
 =?utf-8?B?a1Q5QjJ0TW9SYk04UmlCQ0s2NFpLV3M5M0grOElscjczU2NiNSs4ZUR0c1Ja?=
 =?utf-8?B?MEZ6V1ZBZTNvQnVUVkFXTVF0b0htWEJ2eXZDOERsbHJMR2tEeS91SGxNcUNY?=
 =?utf-8?B?SmtpYW5HRTluVkFPdXJnQXBCd29uYmRRUHZWZDJUMDlPVjRvZnViVk85RjJh?=
 =?utf-8?B?Qi9CV0NXMGIwREIzK1hSSG9pTk9EbHBJNzdWSCtFMjRjZXZmWGgrOUlRMGdX?=
 =?utf-8?B?TzJhSGNOR0J6cFF2T1A5VWN5bDVtUjVkVDNmY25CdzluM282eWN1aElkemYr?=
 =?utf-8?B?bUxNd2xKdlEwcXBQSVJrcE5pR1E5MUJZSldwVEtaek1rZWZwdW5NMmU4WklL?=
 =?utf-8?B?MmZBMDBPWHdUWDl6bStQMlNhQXlXdW5UdUlLREI1amhZS01IV2s2UkFWKzNZ?=
 =?utf-8?B?ZWtRQWZYNmNQQlRPQ1hML0FIdVRuTGlBdEhVdkVDY2hVbnRnbGQvTG1aK0J3?=
 =?utf-8?B?T21KNlNyQnBhQ1c4ZlFHS250SUVQUGUxYjBUWFF3ZEJDeGc1TDZUajFFQUVT?=
 =?utf-8?B?UjJTcVdxeUEvL3VTRGs3ZXZ6SGorbFdxRWVSSEdlbTZhOVZYUDl3dGJyZ3VE?=
 =?utf-8?B?cW5ZUHhLOXpQdjI4MFJZakp1dnVHalNvMFR1eEpsQnZHK1dpNC9nd2p0MnlB?=
 =?utf-8?B?QnR5U3Q4ZFh0RzNtSXdnTkN4REZrUHlROE1jL3ArTnhpSmloUVZhU2lzVTk5?=
 =?utf-8?B?RENPY21pcFlnQkZiZ3NVaTI4dnFLQUI1M1hWSjRZV1pTT1dsNktjNEErejRG?=
 =?utf-8?B?eWhxRVJHV25CQkl6b1U4aVB1QjJmZ0VuMVRTZm8yS1FiT3VEQk9ESlhMTFM3?=
 =?utf-8?B?RDRVaEs5cmJpalByRDNhVHlwT3VFWnhYcTcwT3hXYlRIdHR1TmpmQ1FyNS8w?=
 =?utf-8?B?UytMbWIrNGk1aEh1K04zOTJtdzg4L29kNHVONWJqZjVQN3JEek1PZWw2MkRW?=
 =?utf-8?B?NDhiZXlOUU1ESWR6YTN5Kzltb0F2Qm9pWm91RFlSeThmcG1WYXhWUWwwVVYy?=
 =?utf-8?B?WmpLdWN5TkF4NUFvSGZ0eVpZYzlIWlR4ekNwU2lBVDVwelhGUnlrM0w4SkxU?=
 =?utf-8?B?b1lqSFppKzB5MmJ6WndwdHNsVENxOXNhOW5yR1ZaZ3JJVHRwNE5aTlVZVjJu?=
 =?utf-8?B?cWJxems1VmRxUjRWVGRJMDBlTDVHK3dNdllXS3NQbHEvbE9KSzBqeXpiZVA2?=
 =?utf-8?B?UEppRkRodkQ3M3k2MklGbndTYlBDL3VHelRhOFUwMk1sZ2RKU3dmblRUTjNm?=
 =?utf-8?B?QzJlV0xNMXBSSUllVW1aSUJHYnN1RTJBMVF4WEd3MDMrYzVTQm5BcjZHTFlY?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wBVp5wszLkf08fhqZN5/xhAIH08etYFj52URh5Wj/vPLLLPInM/q0vVTzf5qQVnE59kUarJI0cQWXF42mrrojXnwr+J7SPgZ7bcDL0Y2sMK3NVn8XbRIiYCu5M/VsecHeca9etnviPsdo3lvbz74KrS3O6RxT2SIaGXzqoweWLkLDLkT9/W3vbc5dwOYWJ+FPuibSwGTZg5R9oSBeFs9+t5LzRSIsfpUVPCp03DHNYw2javkh5+3f8Xcn21rt0IyKfOCJvhqeKfSRpy2SuDMkn7Wo6iiUbw1qEOHeKPon76BGdx8g48sViJzjEoWDESYmJpaorRjXztGcb4uCpuIaGYZjZ1Kw8Ufi17s2boYdsTJkL/uTaBoTaa2wi0Scq033TsAd4VZaRHMCtBweMZv7eI3gm8FgsBUDIHIkcfGt5P9rbBXUOYw5rD+4T1Tw1MIYisrX0IKQCF/PiE30Ahh24VSLKq5IpqddiJnTIOAlb8EtLQcsC/q2KBYalWfFY5t83gKWczpd6wAfAIdp1BvGLvKnUhlIjprFxqm1elWLY4eA7i0HlcRbSLxK03P2IaH4aaWhRXY22bKlXYwjRiAjX9UxLBsTKWu1BxH6XzWhY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1b86ad-3652-4949-7040-08dda8d22f73
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:24:45.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsunsXLnH+Po4OjDw0vUslTpI0ISG4Nh8e+lxKd86cFLL1ky8cJZOEVQBgH2zsbVVDNQJcpVpWTy7Jm+DEK7zqlARnENg5We9BYNhY8ZxiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110089
X-Proofpoint-GUID: nPpN8YrXAsezOtPVhpblNUTXZyOyTzvz
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68495973 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=P-IC7800AAAA:8 a=yPCof4ZbAAAA:8 a=lO5oM2mX6O8sqg8k3FMA:9 a=oM-DqhEjOM34sHK8:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA4OSBTYWx0ZWRfXwMOefL2fQwFd K2hSlsf7KNjf/bR/1nqakVfJ+2tkrTWF3cjjuF3wqfU5oGST1mLLWqseKaVCNWiWbWyeOf910C1 PoRjq4RDhUITyUzQAMbEzOKy5wfxljqqk8r7TRiFaYy+/yRofnjNSu06Sex9obZ23MiBD2F4D8k
 CLIQKbeyE85Pyjwec39w7T/ty5kMmXHKBalb9LY0cHEXoEpSsJdV484w3nVTco8LY4tIdiz1+VC t5+UrN0lLMk+Z3ZPi1rZuTTAwB7hswdoiQgWvoS+hvqTmtLTSzUAasle6BQLfDeBhburjCMKkYX NVG4UFedADT6b7vM12hE5Tl63+SG0oQTptN/Qj01sAKP8EaD5NaWSlhHBMvw5+oXjqY0lzJJaga
 FKeGsNTlN7hHJnraQZJ80aEVKWXB6tYizSuxZ411X36Mcqb0h5b8/J6IGLhp4onl5NB8Tvv/
X-Proofpoint-ORIG-GUID: nPpN8YrXAsezOtPVhpblNUTXZyOyTzvz

Thanks for your patient replies :)

OK to save us both time in such a huuuuge back-and-forth - I agree broadly
with your comments below and I think we are aligned on everything now.

I will try to get you a list of merge scenarios and ideally have a look at
the test code too if I have time this week.

But otherwise hopefully we are good for a respin here?

Cheers, Lorenzo

On Tue, Jun 10, 2025 at 05:16:36PM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 10, 2025 at 10:43 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Sat, Jun 07, 2025 at 06:41:35PM -0700, Suren Baghdasaryan wrote:
> > > On Sat, Jun 7, 2025 at 10:43 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > Hi Suren,
> > > >
> > > > Forgive me but I am going to ask a lot of questions here :p just want to
> > > > make sure I'm getting everything right here.
> > >
> > > No worries and thank you for reviewing!
> >
> > No problem!
> >
> > >
> > > >
> > > > On Wed, Jun 04, 2025 at 04:11:50PM -0700, Suren Baghdasaryan wrote:
> > > > > With maple_tree supporting vma tree traversal under RCU and per-vma
> > > > > locks, /proc/pid/maps can be read while holding individual vma locks
> > > > > instead of locking the entire address space.
> > > >
> > > > Nice :)
> > > >
> > > > > Completely lockless approach would be quite complex with the main issue
> > > > > being get_vma_name() using callbacks which might not work correctly with
> > > > > a stable vma copy, requiring original (unstable) vma.
> > > >
> > > > Hmmm can you expand on what a 'completely lockless' design might comprise of?
> > >
> > > In my previous implementation
> > > (https://lore.kernel.org/all/20250418174959.1431962-1-surenb@google.com/)
> > > I was doing this under RCU while checking mmap_lock seq counter to
> > > detect address space changes. That's what I meant by a completely
> > > lockless approach here.
> >
> > Oh did that approach not even use VMA locks _at all_?
>
> Correct, it was done under RCU protection.
>
> >
> > >
> > > >
> > > > It's super un-greppable and I've not got clangd set up with an allmod kernel to
> > > > triple-check but I'm seeing at least 2 (are there more?):
> > > >
> > > > gate_vma_name() which is:
> > > >
> > > >         return "[vsyscall]";
> > > >
> > > > special_mapping_name() which is:
> > > >
> > > >          return ((struct vm_special_mapping *)vma->vm_private_data)->name;
> > > >
> > > > Which I'm guessing is the issue because it's a double pointer deref...
> > >
> > > Correct but in more general terms, depending on implementation of the
> > > vm_ops.name callback, vma->vm_ops->name(vma) might not work correctly
> > > with a vma copy. special_mapping_name() is an example of that.
> >
> > Yeah, this is a horrible situation to be in for such a trivial thing. But I
> > guess unavoidable for now.
> >
> > >
> > > >
> > > > Seems such a silly issue to get stuck on, I wonder if we can't just change
> > > > this to function correctly?
> > >
> > > I was thinking about different ways to overcome that but once I
> > > realized per-vma locks result in even less contention and the
> > > implementation is simpler and more robust, I decided that per-vma
> > > locks direction is better.
> >
> > Ack well in that case :)
> >
> > But still it'd be nice to somehow restrict the impact of this callback.
>
> With VMA locked we are back in a safe place, I think.
>
> >
> > >
> > > >
> > > > > When per-vma lock acquisition fails, we take the mmap_lock for reading,
> > > > > lock the vma, release the mmap_lock and continue. This guarantees the
> > > > > reader to make forward progress even during lock contention. This will
> > > >
> > > > Ah that fabled constant forward progress ;)
> > > >
> > > > > interfere with the writer but for a very short time while we are
> > > > > acquiring the per-vma lock and only when there was contention on the
> > > > > vma reader is interested in.
> > > > > One case requiring special handling is when vma changes between the
> > > > > time it was found and the time it got locked. A problematic case would
> > > > > be if vma got shrunk so that it's start moved higher in the address
> > > > > space and a new vma was installed at the beginning:
> > > > >
> > > > > reader found:               |--------VMA A--------|
> > > > > VMA is modified:            |-VMA B-|----VMA A----|
> > > > > reader locks modified VMA A
> > > > > reader reports VMA A:       |  gap  |----VMA A----|
> > > > >
> > > > > This would result in reporting a gap in the address space that does not
> > > > > exist. To prevent this we retry the lookup after locking the vma, however
> > > > > we do that only when we identify a gap and detect that the address space
> > > > > was changed after we found the vma.
> > > >
> > > > OK so in this case we have
> > > >
> > > > 1. Find VMA A - nothing is locked yet, but presumably we are under RCU so
> > > >    are... safe? From unmaps? Or are we? I guess actually the detach
> > > >    mechanism sorts this out for us perhaps?
> > >
> > > Yes, VMAs are RCU-safe and we do detect if it got detached after we
> > > found it but before we locked it.
> >
> > Ack I thought so.
> >
> > >
> > > >
> > > > 2. We got unlucky and did this immediately prior to VMA A having its
> > > >    vma->vm_start, vm_end updated to reflect the split.
> > >
> > > Yes, the split happened after we found it and before we locked it.
> > >
> > > >
> > > > 3. We lock VMA A, now position with an apparent gap after the prior VMA
> > > > which, in practice does not exist.
> > >
> > > Correct.
> >
> > Ack
> >
> > >
> > > >
> > > > So I am guessing that by observing sequence numbers you are able to detect
> > > > that a change has occurred and thus retry the operation in this situation?
> > >
> > > Yes, we detect the gap and we detect that address space has changed,
> > > so to endure we did not miss a split we fall back to mmap_read_lock,
> > > lock the VMA while holding mmap_read_lock, drop mmap_read_lock and
> > > retry.
> > >
> > > >
> > > > I know we previously discussed the possibility of this retry mechanism
> > > > going on forever, I guess I will see the resolution to this in the code :)
> > >
> > > Retry in this case won't go forever because we take mmap_read_lock
> > > during the retry. In the worst case we will be constantly falling back
> > > to mmap_read_lock but that's a very unlikely case (the writer should
> > > be constantly splitting the vma right before the reader locks it).
> >
> > It might be worth adding that to commit message to underline that this has
> > been considered and this is the resolution.
> >
> > Something like:
> >
> >         we guarantee forward progress by always resolving contention via a
> >         fallback to an mmap-read lock.
> >
> >         We shouldn't see a repeated fallback to mmap read locks in
> >         practice, as this require a vanishingly unlikely series of lock
> >         contentions (for instance due to repeated VMA split
> >         operations). However even if this did somehow happen, we would
> >         still progress.
>
> Ack.
>
> >
> > >
> > > >
> > > > > This change is designed to reduce mmap_lock contention and prevent a
> > > > > process reading /proc/pid/maps files (often a low priority task, such
> > > > > as monitoring/data collection services) from blocking address space
> > > > > updates. Note that this change has a userspace visible disadvantage:
> > > > > it allows for sub-page data tearing as opposed to the previous mechanism
> > > > > where data tearing could happen only between pages of generated output
> > > > > data. Since current userspace considers data tearing between pages to be
> > > > > acceptable, we assume is will be able to handle sub-page data tearing
> > > > > as well.
> > > >
> > > > By tearing do you mean for instance seeing a VMA more than once due to
> > > > e.g. a VMA expanding in a racey way?
> > >
> > > Yes.
> > >
> > > >
> > > > Pedantic I know, but it might be worth goiing through all the merge case,
> > > > split and remap scenarios and explaining what might happen in each one (or
> > > > perhaps do that as some form of documentation?)
> > > >
> > > > I can try to put together a list of all of the possibilities if that would
> > > > be helpful.
> > >
> > > Hmm. That might be an interesting exercise. I called out this
> > > particular case because my tests caught it. I spent some time thinking
> > > about other possible scenarios where we would report a gap in a place
> > > where there are no gaps but could not think of anything else.
> >
> > todo++; :)
> >
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > ---
> > > > >  fs/proc/internal.h |   6 ++
> > > > >  fs/proc/task_mmu.c | 177 +++++++++++++++++++++++++++++++++++++++++++--
> > > > >  2 files changed, 175 insertions(+), 8 deletions(-)
> > > >
> > > > I really hate having all this logic in the proc/task_mmu.c file.
> > > >
> > > > This is really delicate stuff and I'd really like it to live in mm if
> > > > possible.
> > > >
> > > > I reallise this might be a total pain, but I'm quite worried about us
> > > > putting super-delicate, carefully written VMA handling code in different
> > > > places.
> > > >
> > > > Also having stuff in mm/vma.c opens the door to userland testing which,
> > > > when I finally have time to really expand that, would allow for some really
> > > > nice stress testing here.
> > >
> > > That would require some sizable refactoring. I assume code for smaps
> > > reading and PROCMAP_QUERY would have to be moved as well?
> >
> > Yeah, I know, and apologies for that, but I really oppose us having this
> > super delicate VMA logic in an fs/proc file, one we don't maintain for that
> > matter.
> >
> > I know it's a total pain, but this just isn't the right place to be doing
> > such a careful dance.
> >
> > I'm not saying relocate code that belongs here, but find a way to abstract
> > the operations.
>
> Ok, I'll take a stab at refactoring purely mm-related code and will
> see how that looks.
>
> >
> > Perhaps could be a walker or something that does all the state transition
> > stuff that you can then just call from the walker functions here?
> >
> > You could then figure out something similar for the PROCMAP_QUERY logic.
> >
> > We're not doing this VMA locking stuff for smaps are we? As that is walking
> > page tables anyway right? So nothing would change for that.
>
> Yeah, smaps would stay as they are but refactoring might affect its
> code portions as well.
>
> >
> > >
> > > >
> > > > >
> > > > > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > > > > index 96122e91c645..3728c9012687 100644
> > > > > --- a/fs/proc/internal.h
> > > > > +++ b/fs/proc/internal.h
> > > > > @@ -379,6 +379,12 @@ struct proc_maps_private {
> > > > >       struct task_struct *task;
> > > > >       struct mm_struct *mm;
> > > > >       struct vma_iterator iter;
> > > > > +     loff_t last_pos;
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +     bool mmap_locked;
> > > > > +     unsigned int mm_wr_seq;
> > > >
> > > > Is this the _last_ sequence number observed in the mm_struct? or rather,
> > > > previous? Nitty but maybe worth renaming accordingly.
> > >
> > > It's a copy of the mm->mm_wr_seq. I can add a comment if needed.
> >
> > Right, of course. But I think the problem is the 'when' it refers to. It's
> > the sequence number associatied with the mm here sure, but when was it
> > snapshotted? How do we use it?
> >
> > Something like 'last_seen_seqnum' or 'mm_wr_seq_start' or something plus a
> > comment would be helpful.
> >
> > This is nitty I know... but this stuff is very confusing and I think every
> > little bit we do to help explain things is helpful here.
>
> Ok, I'll add a comment that mm_wr_seq is a snapshot of mm->mm_wr_seq
> before we started the VMA lookup.
>
> >
> > >
> > > >
> > > > > +     struct vm_area_struct *locked_vma;
> > > > > +#endif
> > > > >  #ifdef CONFIG_NUMA
> > > > >       struct mempolicy *task_mempolicy;
> > > > >  #endif
> > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > index 27972c0749e7..36d883c4f394 100644
> > > > > --- a/fs/proc/task_mmu.c
> > > > > +++ b/fs/proc/task_mmu.c
> > > > > @@ -127,13 +127,172 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
> > > > >  }
> > > > >  #endif
> > > > >
> > > > > -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
> > > > > -                                             loff_t *ppos)
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +
> > > > > +static struct vm_area_struct *trylock_vma(struct proc_maps_private *priv,
> > > > > +                                       struct vm_area_struct *vma,
> > > > > +                                       unsigned long last_pos,
> > > > > +                                       bool mm_unstable)
> > > >
> > > > This whole function is a bit weird tbh, you handle both the
> > > > mm_unstable=true and mm_unstable=false cases, in the latter we don't try to
> > > > lock at all...
> > >
> > > Why do you think so? vma_start_read() is always called but in case
> > > mm_unstable=true we double check for the gaps to take care of the case
> > > I mentioned in the changelog.
> >
> > Well the read lock will always succeed if mmap read lock is held right?
> > Actually... no :)
> >
> > I see your point below about vma_start_read_locked() :>)
> >
> > I see below you suggest splitting into two functions, that seems to be a
> > good way forward.
>
> Ack.
>
> >
> > I _think_ we won't even need the checks re: mm and last_pos in that case
> > right? As holding the mmap lock we should be able to guarantee? Or at least
> > the mm check?
>
> Correct. These checks are needed only if we are searching the VMA
> under RCU protection before locking it. If we are holding mmap_lock
> then all this is not needed.
>
> >
> > >
> > > >
> > > > Nitty (sorry I know this is mildly irritating review) but maybe needs to be
> > > > renamed, or split up somehow?
> > > >
> > > > This is only trylocking in the mm_unstable case...
> > >
> > > Nope, I think you misunderstood the intention, as I mentioned above.
> > >
> > > >
> > > > > +{
> > > > > +     vma = vma_start_read(priv->mm, vma);
> > > >
> > > > Do we want to do this with mm_unstable == false?
> > >
> > > Yes, always. mm_unstable=true only indicates that we are already
> > > holding mmap_read_lock, so we don't need to double-check for gaps.
> > > Perhaps I should add some comments to clarify what purpose this
> > > parameter serves...
> > >
> > > >
> > > > I know (from my own documentation :)) taking a VMA read lock while holding
> > > > an mmap read lock is fine (the reverse isn't) but maybe it's suboptimal?
> > >
> > > Ah, right. I should use vma_start_read_locked() instead when we are
> > > holding mmap_read_lock. That's why that function was introduced. Will
> > > change.
> >
> > Yeah, I'll pretend this is what I meant to sound smart :P but this is a
> > really good point!
> >
> > >
> > > >
> > > > > +     if (IS_ERR_OR_NULL(vma))
> > > > > +             return NULL;
> > > >
> > > > Hmm IS_ERR_OR_NULL() is generally a code smell (I learned this some years
> > > > ago from people moaning at me on code review :)
> > > >
> > > > Sorry I know that's annoying but perhaps its indicative of an issue in the
> > > > interface? That's possibly out of scope here however.
> > >
> > > lock_vma_under_rcu() returns NULL or EAGAIN to signal
> > > lock_vma_under_rcu() that it should retry the VMA lookup. In here in
> > > either case we retry under mmap_read_lock, that's why EAGAIN is
> > > ignored.
> >
> > Yeah indeed you're right. I guess I'm just echoing previous review traumas
> > here :P
> >
> > >
> > > >
> > > > Why are we ignoring errors here though? I guess because we don't care if
> > > > the VMA got detached from under us, we don't bother retrying like we do in
> > > > lock_vma_under_rcu()?
> > >
> > > No, we take mmap_read_lock and retry in either case. Perhaps I should
> > > split trylock_vma() into two separate functions - one for the case
> > > when we are holding mmap_read_lock and another one when we don't? I
> > > think that would have prevented many of your questions. I'll try that
> > > and see how it looks.
> >
> > Yeah that'd be helpful. I think this should also simplify things?
>
> Yes. Will try that.
>
> >
> > >
> > > >
> > > > Should we just abstract that part of lock_vma_under_rcu() and use it?
> > >
> > > trylock_vma() is not that similar to lock_vma_under_rcu() for that
> > > IMO. Also lock_vma_under_rcu() is in the pagefault path which is very
> > > hot, so I would not want to add conditions there to make it work for
> > > trylock_vma().
> >
> > Right sure.
> >
> > But I'm just wondering why we don't do the retry stuff, e.g.:
> >
> >                 /* Check if the VMA got isolated after we found it */
> >                 if (PTR_ERR(vma) == -EAGAIN) {
> >                         count_vm_vma_lock_event(VMA_LOCK_MISS);
> >                         /* The area was replaced with another one */
> >                         goto retry;
> >                 }
> >
> > I mean do we need to retry under mmap lock in that case? Can we just retry
> > the lookup? Or is this not a worthwhile optimisation here?
>
> Hmm. That might be applicable here as well. Let me think some more
> about it. Theoretically that might affect our forward progress
> guarantee but for us to retry infinitely the VMA we find has to be
> knocked out from under us each time we find it. So, quite unlikely to
> happen continuously.
>
> >
> > >
> > > >
> > > > > +
> > > > > +     /* Check if the vma we locked is the right one. */
> > > >
> > > > Well it might not be the right one :) but might still belong to the right
> > > > mm, so maybe better to refer to the right virtual address space.
> > >
> > > Ack. Will change to "Check if the vma belongs to the right address space. "
> >
> > Thanks!
> >
> > >
> > > >
> > > > > +     if (unlikely(vma->vm_mm != priv->mm))
> > > > > +             goto err;
> > > > > +
> > > > > +     /* vma should not be ahead of the last search position. */
> > > >
> > > > You mean behind the last search position? Surely a VMA being _ahead_ of it
> > > > is fine?
> > >
> > > Yes, you are correct. "should not" should have been "should".
> >
> > Thanks!
> >
> > >
> > > >
> > > > > +     if (unlikely(last_pos >= vma->vm_end))
> > > >
> > > > Should that be >=? Wouldn't an == just be an adjacent VMA? Why is that
> > > > problematic? Or is last_pos inclusive?
> > >
> > > last_pos is inclusive and vma->vm_end is not inclusive, so if last_pos
> > > == vma->vm_end that would mean the vma is behind the last_pos. Since
> > > we are searching forward from the last_pos, we should not be finding a
> > > vma before last_pos unless it mutated.
> >
> > Ahhh that explains it. Thanks.
> >
> > >
> > > >
> > > > > +             goto err;
> > > >
> > > > Am I correct in thinking thi is what is being checked?
> > > >
> > > >           last_pos
> > > >              |
> > > >              v
> > > > |---------|
> > > > |         |
> > > > |---------|
> > > >         vm_end
> > > >    <--- vma 'next'??? How did we go backwards?
> > >
> > > Exactly.
> > >
> > > >
> > > > When last_pos gets updated, is it possible for a shrink to race to cause
> > > > this somehow?
> > >
> > > No, we update last_pos only after we locked the vma and confirmed it's
> > > the right one.
> >
> > Ack.
> >
> > >
> > > >
> > > > Do we treat this as an entirely unexpected error condition? In which case
> > > > is a WARN_ON_ONCE() warranted?
> > >
> > > No, the VMA might have mutated from under us before we locked it. For
> > > example it might have been remapped to a higher address.
> > >
> > > >
> > > > > +
> > > > > +     /*
> > > > > +      * vma ahead of last search position is possible but we need to
> > > > > +      * verify that it was not shrunk after we found it, and another
> > > > > +      * vma has not been installed ahead of it. Otherwise we might
> > > > > +      * observe a gap that should not be there.
> > > > > +      */
> > > >
> > > > OK so this is the juicy bit.
> > >
> > > Yep, that's the case singled out in the changelog.
> >
> > And rightly so!
> >
> > >
> > > >
> > > >
> > > > > +     if (mm_unstable && last_pos < vma->vm_start) {
> > > > > +             /* Verify only if the address space changed since vma lookup. */
> > > > > +             if ((priv->mm_wr_seq & 1) ||
> > > >
> > > > Can we wrap this into a helper? This is a 'you just have to know that odd
> > > > seq number means a write operation is in effect'. I know you have a comment
> > > > here, but I think something like:
> > > >
> > > >         if (has_mm_been_modified(priv) ||
> > > >
> > > > Would be a lot clearer.
> > >
> > > Yeah, I was thinking about that. I think an even cleaner way would be
> > > to remember the return value of mmap_lock_speculate_try_begin() and
> > > pass it around. I was hoping to avoid that extra parameter but sounds
> > > like for the sake of clarity that would be preferable?
> >
> > You know, it's me so I might have to mention a helper struct here :P it's
> > the two most Lorenzo things - helper sructs and churn...
> >
> > >
> > > >
> > > > Again this speaks to the usefulness of abstracting all this logic from the
> > > > proc code, we are putting super delicate VMA stuff here and it's just not
> > > > the right place.
> > > >
> > > > As an aside, I don't see coverage in the process_addrs documentation on
> > > > sequence number odd/even or speculation?
> > > >
> > > > I think we probably need to cover this to maintain an up-to-date
> > > > description of how the VMA locking mechanism works and is used?
> > >
> > > I think that's a very low level technical detail which I should not
> > > have exposed here. As I mentioned, I should simply store the return
> > > value of mmap_lock_speculate_try_begin() instead of doing these tricky
> > > mm_wr_seq checks.
> >
> > Right yeah I'm all for simplifying if we can! Sounds sensible.
> >
> > >
> > > >
> > > > > +                 mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq)) {
> > > >
> > > > Nit, again unrelated to this series, but would be useful to add a comment
> > > > to mmap_lock_speculate_retry() to indicate that a true return value
> > > > indicates a retry is needed, or renaming it.
> > >
> > > This is how seqcount API works in general. Note that
> > > mmap_lock_speculate_retry() is just a wrapper around
> > > read_seqcount_retry().
> >
> > Yeah, I guess I can moan to PeterZ about that :P
> >
> > It's not a big deal honestly, but it was just something I found confusing.
> >
> > I think adjusting the comment above to something like:
> >
> >                 /*
> >                  * Verify if the address space changed since vma lookup, or if
> >                  * the speculative lock needs to be retried.
> >                  */
> >
> > Or perhaps somethig more in line with the description you give below?
>
> Ack.
>
> >
> > >
> > > >
> > > > Maybe mmap_lock_speculate_needs_retry()? Also I think that function needs a
> > > > comment.
> > >
> > > See https://elixir.bootlin.com/linux/v6.15.1/source/include/linux/seqlock.h#L395
> >
> > Yeah I saw that, but going 2 levels deep to read a comment isn't great.
> >
> > But again this isn't the end of the world.
> >
> > >
> > > >
> > > > Naming is hard :P
> > > >
> > > > Anyway the totality of this expression is 'something changed' or 'read
> > > > section retry required'.
> > >
> > > Not quite. The expression is "something is changed from under us or
> > > something was changing even before we started VMA lookup". Or in more
> > > technical terms, mmap_write_lock was acquired while we were locking
> > > the VMA or mmap_write_lock was already held even before we started the
> > > VMA search.
> >
> > OK so read section retry required = the seq num changes from under us
> > (checked carefully with memory barriers and carefully considered and
> > thought out such logic), and the priv->mm_wr_seq check before it is the
> > 'was this changed even before we began?'
> >
> > I wonder btw if we could put both into a single helper function to check
> > whether that'd be clearer.
>
> So this will look something like this:
>
> priv->can_speculate = mmap_lock_speculate_try_begin();
> ...
> if (!priv->can_speculate || mmap_lock_speculate_retry()) {
>     // fallback
> }
>
> Is that descriptive enough?
>
> >
> > >
> > > >
> > > > Under what circumstances would this happen?
> > >
> > > See my previous comment and I hope that clarifies it.
> >
> > Thanks!
> >
> > >
> > > >
> > > > OK so we're into the 'retry' logic here:
> > > >
> > > > > +                     vma_iter_init(&priv->iter, priv->mm, last_pos);
> > > >
> > > > I'd definitely want Liam to confirm this is all above board and correct, as
> > > > these operations are pretty sensitive.
> > > >
> > > > But assuming this is safe, we reset the iterator to the last position...
> > > >
> > > > > +                     if (vma != vma_next(&priv->iter))
> > > >
> > > > Then assert the following VMA is the one we seek.
> > > >
> > > > > +                             goto err;
> > > >
> > > > Might this ever be the case in the course of ordinary operation? Is this
> > > > really an error?
> > >
> > > This simply means that the VMA we found before is not at the place we
> > > found it anymore. The locking fails and we should retry.
> >
> > I know it's pedantic but feels like 'err' is not a great name for this.
> >
> > Maybe 'nolock' or something? Or 'lock_failed'?
>
> lock_failed sounds good.
>
>
> >
> > >
> > > >
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     priv->locked_vma = vma;
> > > > > +
> > > > > +     return vma;
> > > > > +err:
> > > >
> > > > As queried above, is this really an error path or something we might expect
> > > > to happen that could simply result in an expected fallback to mmap lock?
> > >
> > > It's a failure to lock the VMA, which is handled by retrying under
> > > mmap_read_lock. So, trylock_vma() failure does not mean a fault in the
> > > logic. It's expected to happen occasionally.
> >
> > Ack yes understood thanks!
> >
> > >
> > > >
> > > > > +     vma_end_read(vma);
> > > > > +     return NULL;
> > > > > +}
> > > > > +
> > > > > +
> > > > > +static void unlock_vma(struct proc_maps_private *priv)
> > > > > +{
> > > > > +     if (priv->locked_vma) {
> > > > > +             vma_end_read(priv->locked_vma);
> > > > > +             priv->locked_vma = NULL;
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static const struct seq_operations proc_pid_maps_op;
> > > > > +
> > > > > +static inline bool lock_content(struct seq_file *m,
> > > > > +                             struct proc_maps_private *priv)
> > > >
> > > > Pedantic I know but isn't 'lock_content' a bit generic?
> > > >
> > > > He says, not being able to think of a great alternative...
> > > >
> > > > OK maybe fine... :)
> > >
> > > Yeah, I struggled with this myself. Help in naming is appreciated.
> >
> > This is where it gets difficult haha so easy to point out but not so easy
> > to fix...
> >
> > lock_vma_range()?
>
> Ack.
>
> >
> > >
> > > >
> > > > > +{
> > > > > +     /*
> > > > > +      * smaps and numa_maps perform page table walk, therefore require
> > > > > +      * mmap_lock but maps can be read with locked vma only.
> > > > > +      */
> > > > > +     if (m->op != &proc_pid_maps_op) {
> > > >
> > > > Nit but is there a neater way of checking this? Actually I imagine not...
> > > >
> > > > But maybe worth, instead of forward-declaring proc_pid_maps_op, forward declare e.g.
> > > >
> > > > static inline bool is_maps_op(struct seq_file *m);
> > > >
> > > > And check e.g.
> > > >
> > > > if (is_maps_op(m)) { ... in the above.
> > > >
> > > > Yeah this is nitty not a massive del :)
> > >
> > > I'll try that and see how it looks. Thanks!
> >
> > Thanks!
> >
> > >
> > > >
> > > > > +             if (mmap_read_lock_killable(priv->mm))
> > > > > +                     return false;
> > > > > +
> > > > > +             priv->mmap_locked = true;
> > > > > +     } else {
> > > > > +             rcu_read_lock();
> > > > > +             priv->locked_vma = NULL;
> > > > > +             priv->mmap_locked = false;
> > > > > +     }
> > > > > +
> > > > > +     return true;
> > > > > +}
> > > > > +
> > > > > +static inline void unlock_content(struct proc_maps_private *priv)
> > > > > +{
> > > > > +     if (priv->mmap_locked) {
> > > > > +             mmap_read_unlock(priv->mm);
> > > > > +     } else {
> > > > > +             unlock_vma(priv);
> > > > > +             rcu_read_unlock();
> > > >
> > > > Does this always get called even in error cases?
> > >
> > > What error cases do you have in mind? Error to lock a VMA is handled
> > > by retrying and we should be happily proceeding. Please clarify.
> >
> > Well it was more of a question really - can the traversal through
> > /proc/$pid/maps result in some kind of error that doesn't reach this
> > function, thereby leaving things locked mistakenly?
> >
> > If not then happy days :)
> >
> > I'm guessing there isn't.
>
> There is EINTR in m_start() but unlock_content() won't be called in
> that case, so I think we are good.
>
> >
> > >
> > > >
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> > > > > +                                        loff_t last_pos)
> > > >
> > > > We really need a generalised RCU multi-VMA locking mechanism (we're looking
> > > > into madvise VMA locking atm with a conservative single VMA lock at the
> > > > moment, but in future we probably want to be able to span multiple for
> > > > instance) and this really really feels like it doesn't belong in this proc
> > > > code.
> > >
> > > Ok, I guess you are building a case to move more code into vma.c? I
> > > see what you are doing :)
> >
> > Haha damn it, my evil plans revealed :P
> >
> > >
> > > >
> > > > >  {
> > > > > -     struct vm_area_struct *vma = vma_next(&priv->iter);
> > > > > +     struct vm_area_struct *vma;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (priv->mmap_locked)
> > > > > +             return vma_next(&priv->iter);
> > > > > +
> > > > > +     unlock_vma(priv);
> > > > > +     /*
> > > > > +      * Record sequence number ahead of vma lookup.
> > > > > +      * Odd seqcount means address space modification is in progress.
> > > > > +      */
> > > > > +     mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_seq);
> > > >
> > > > Hmm we're discarding the return value I guess we don't really care about
> > > > that at this stage? Or do we? Do we want to assert the read critical
> > > > section state here?
> > >
> > > Yeah, as I mentioned, instead of relying on priv->mm_wr_seq being odd
> > > I should record the return value of mmap_lock_speculate_try_begin().
> > > In the functional sense these two are interchangeable.
> >
> > Ack, thanks!
> >
> > >
> > > >
> > > > I guess since we have the mm_rq_seq which we use later it's the same thing
> > > > and doesn't matter.
> > >
> > > Yep.
> >
> > Ack
> >
> > >
> > > >
> > > > ~~(off topic a bit)~~
> > > >
> > > > OK so off-topic again afaict we're doing something pretty horribly gross here.
> > > >
> > > > We pass &priv->mm_rw_seq as 'unsigned int *seq' field to
> > > > mmap_lock_speculate_try_begin(), which in turn calls:
> > > >
> > > >         return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
> > > >
> > > > And this is defined as a macro of:
> > > >
> > > > #define raw_seqcount_try_begin(s, start)                                \
> > > > ({                                                                      \
> > > >         start = raw_read_seqcount(s);                                   \
> > > >         !(start & 1);                                                   \
> > > > })
> > > >
> > > > So surely this expands to:
> > > >
> > > >         *seq = raw_read_seqcount(&mm->mm_lock_seq);
> > > >         !(*seq & 1) // return true if even, false if odd
> > > >
> > > > So we're basically ostensibly passing an unsigned int, but because we're
> > > > calling a macro it's actually just 'text' and we're instead able to then
> > > > reassign the underlying unsigned int * ptr and... ugh.
> > > >
> > > > ~~(/off topic a bit)~~
> > >
> > > Aaaand we are back...
> >
> > :)) yeah this isn't your fault, just a related 'wtf' moan :P we can pretend
> > like it never happened *ahem*
> >
> > >
> > > >
> > > > > +     vma = vma_next(&priv->iter);
> > > >
> > > >
> > > >
> > > > > +     if (!vma)
> > > > > +             return NULL;
> > > > > +
> > > > > +     vma = trylock_vma(priv, vma, last_pos, true);
> > > > > +     if (vma)
> > > > > +             return vma;
> > > > > +
> > > >
> > > > Really feels like this should be a boolean... I guess neat to reset vma if
> > > > not locked though.
> > >
> > > I guess I can change trylock_vma() to return boolean. We always return
> > > the same vma or NULL I think.
> >
> > Ack, I mean I guess you're looking at reworking it in general so can take
> > this into account.
>
> Ack.
>
> >
> > >
> > > >
> > > > > +     /* Address space got modified, vma might be stale. Re-lock and retry */
> > > >
> > > > > +     rcu_read_unlock();
> > > >
> > > > Might we see a VMA possibly actually legit unmapped in a race here? Do we
> > > > need to update last_pos/ppos to account for this? Otherwise we might just
> > > > fail on the last_pos >= vma->vm_end check in trylock_vma() no?
> > >
> > > Yes, it can happen and trylock_vma() will fail to lock the modified
> > > VMA. That's by design. In such cases we retry the lookup from the same
> > > last_pos.
> >
> > OK and then we're fine with it because the gap we report will be an actual
> > gap.
>
> Yes, either the actual gap or a VMA newly mapped at that address.
>
> >
> > >
> > > >
> > > > > +     ret = mmap_read_lock_killable(priv->mm);
> > > >
> > > > Shouldn't we set priv->mmap_locked here?
> > >
> > > No, we will drop the mmap_read_lock shortly. priv->mmap_locked
> > > indicates the overall mode we operate in. When priv->mmap_locked=false
> > > we can still temporarily take the mmap_read_lock when retrying and
> > > then drop it after we found the VMA.
> >
> > Right yeah, makes sense.
> >
> > >
> > > >
> > > > I guess not as we are simply holding the mmap lock to definitely get the
> > > > next VMA.
> > >
> > > Correct.
> >
> > Ack
> >
> > >
> > > >
> > > > > +     rcu_read_lock();
> > > > > +     if (ret)
> > > > > +             return ERR_PTR(ret);
> > > > > +
> > > > > +     /* Lookup the vma at the last position again under mmap_read_lock */
> > > > > +     vma_iter_init(&priv->iter, priv->mm, last_pos);
> > > > > +     vma = vma_next(&priv->iter);
> > > > > +     if (vma) {
> > > > > +             vma = trylock_vma(priv, vma, last_pos, false);
> > > >
> > > > Be good to use Liam's convention of /* mm_unstable = */ false to make this
> > > > clear.
> > >
> > > Yeah, I'm thinking of splitting trylock_vma() into two separate
> > > functions for mm_unstable=true and mm_unstable=false cases.
> >
> > Yes :) thanks!
> >
> > >
> > > >
> > > > Find it kinda weird again we're 'trylocking' something we already have
> > > > locked via the mmap lock but I already mentioend this... :)
> > > >
> > > > > +             WARN_ON(!vma); /* mm is stable, has to succeed */
> > > >
> > > > I wonder if this is really useful, at any rate seems like there'd be a
> > > > flood here so WARN_ON_ONCE()? Perhaps VM_WARN_ON_ONCE() given this really
> > > > really ought not happen?
> > >
> > > Well, I can't use BUG_ON(), so WARN_ON() is the next tool I have :) In
> > > reality this should never happen, so
> > > WARN_ON/WARN_ON_ONCE/WARN_ON_RATELIMITED/or whatever does not matter
> > > much.
> >
> > I think if you refactor into two separate functions this becomes even more
> > unnecessary because then you are using a vma lock function that can never
> > fail etc.
> >
> > I mean maybe just stick a VM_ in front if it's not going to happen but for
> > debug/dev/early stabilisation purposes we want to keep an eye on it.
>
> Yeah, I think after refactoring we won't need any warnings here.
>
> >
> > >
> > > >
> > > > > +     }
> > > > > +     mmap_read_unlock(priv->mm);
> > > > > +
> > > > > +     return vma;
> > > > > +}
> > > > > +
> > > > > +#else /* CONFIG_PER_VMA_LOCK */
> > > > >
> > > > > +static inline bool lock_content(struct seq_file *m,
> > > > > +                             struct proc_maps_private *priv)
> > > > > +{
> > > > > +     return mmap_read_lock_killable(priv->mm) == 0;
> > > > > +}
> > > > > +
> > > > > +static inline void unlock_content(struct proc_maps_private *priv)
> > > > > +{
> > > > > +     mmap_read_unlock(priv->mm);
> > > > > +}
> > > > > +
> > > > > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> > > > > +                                        loff_t last_pos)
> > > > > +{
> > > > > +     return vma_next(&priv->iter);
> > > > > +}
> > > > > +
> > > > > +#endif /* CONFIG_PER_VMA_LOCK */
> > > > > +
> > > > > +static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
> > > > > +{
> > > > > +     struct proc_maps_private *priv = m->private;
> > > > > +     struct vm_area_struct *vma;
> > > > > +
> > > > > +     vma = get_next_vma(priv, *ppos);
> > > > > +     if (IS_ERR(vma))
> > > > > +             return vma;
> > > > > +
> > > > > +     /* Store previous position to be able to restart if needed */
> > > > > +     priv->last_pos = *ppos;
> > > > >       if (vma) {
> > > > > -             *ppos = vma->vm_start;
> > > > > +             /*
> > > > > +              * Track the end of the reported vma to ensure position changes
> > > > > +              * even if previous vma was merged with the next vma and we
> > > > > +              * found the extended vma with the same vm_start.
> > > > > +              */
> > > >
> > > > Right, so observing repetitions is acceptable in such circumstances? I mean
> > > > I agree.
> > >
> > > Yep, the VMA will be reported twice in such a case.
> >
> > Ack.
> >
> > >
> > > >
> > > > > +             *ppos = vma->vm_end;
> > > >
> > > > If we store the end, does the last_pos logic which resets the VMA iterator
> > > > later work correctly in all cases?
> > >
> > > I think so. By resetting to vma->vm_end we will start the next search
> > > from the address right next to the last reported VMA, no?
> >
> > Yeah, I was just wondering whether there were any odd corner case that
> > might be problematic.
> >
> > But since we treat last_pos as inclusive as you said in a response above,
> > and of course vma->vm_end is exclusive, then this makes sense.
> >
> > >
> > > >
> > > > >       } else {
> > > > >               *ppos = -2UL;
> > > > >               vma = get_gate_vma(priv->mm);
> > > >
> > > > Is it always the case that !vma here implies a gate VMA (yuck yuck)? I see
> > > > this was the original logic, but maybe put a comment about this as it's
> > > > weird and confusing? (and not your fault obviously :P)
> > >
> > > What comment would you like to see here?
> >
> > It's so gross this. I guess something about the inner workings of gate VMAs
> > and the use of -2UL as a weird sentinel etc.
>
> Ok, I'll try to add a meaningful comment here.
>
> >
> > But this is out of scope here.
> >
> > >
> > > >
> > > > Also, are all locks and state corectly handled in this case? Seems like one
> > > > of this nasty edge case situations that could have jagged edges...
> > >
> > > I think we are fine. get_next_vma() returned NULL, so we did not lock
> > > any VMA and priv->locked_vma should be NULL.
> > >
> > > >
> > > > > @@ -163,19 +322,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
> > > > >               return NULL;
> > > > >       }
> > > > >
> > > > > -     if (mmap_read_lock_killable(mm)) {
> > > > > +     if (!lock_content(m, priv)) {
> > > >
> > > > Nice that this just slots in like this! :)
> > > >
> > > > >               mmput(mm);
> > > > >               put_task_struct(priv->task);
> > > > >               priv->task = NULL;
> > > > >               return ERR_PTR(-EINTR);
> > > > >       }
> > > > >
> > > > > +     if (last_addr > 0)
> > > >
> > > > last_addr is an unsigned long, this will always be true.
> > >
> > > Not unless last_addr==0. That's what I'm really checking here: is this
> > > the first invocation of m_start(), in which case we are starting from
> > > the beginning and not restarting from priv->last_pos. Should I add a
> > > comment?
> >
> > Yeah sorry I was being an idiot, I misread this as >= 0 obviously.
> >
> > I had assumed you were checking for the -2 and -1 cases (though -1 early
> > exits above).
> >
> > So in that case, are you handling the gate VMA correctly here? Surely we
> > should exclude that? Wouldn't setting ppos = last_addr = priv->last_pos be
> > incorrect if this were a gate vma?
>
> You are actually right. last_addr can be -2UL here and we should not
> override it. I'll fix it. Thanks!
>
> >
> > Even if we then call get_gate_vma() we've changed these values? Or is that
> > fine?
> >
> > And yeah a comment would be good thanks!
> >
> > >
> > > >
> > > > You probably want to put an explicit check for -1UL, -2UL here or?
> > > >
> > > > God I hate this mechanism for indicating gate VMA... yuck yuck (again, this
> > > > bit not your fault :P)
> > >
> > > No, I don't care here about -1UL, -2UL, just that last_addr==0 or not.
> >
> > OK, so maybe above concerns not a thing.
> >
> > >
> > > >
> > > > > +             *ppos = last_addr = priv->last_pos;
> > > > >       vma_iter_init(&priv->iter, mm, last_addr);
> > > > >       hold_task_mempolicy(priv);
> > > > >       if (last_addr == -2UL)
> > > > >               return get_gate_vma(mm);
> > > > >
> > > > > -     return proc_get_vma(priv, ppos);
> > > > > +     return proc_get_vma(m, ppos);
> > > > >  }
> > > > >
> > > > >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > > > > @@ -184,7 +345,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > > > >               *ppos = -1UL;
> > > > >               return NULL;
> > > > >       }
> > > > > -     return proc_get_vma(m->private, ppos);
> > > > > +     return proc_get_vma(m, ppos);
> > > > >  }
> > > > >
> > > > >  static void m_stop(struct seq_file *m, void *v)
> > > > > @@ -196,7 +357,7 @@ static void m_stop(struct seq_file *m, void *v)
> > > > >               return;
> > > > >
> > > > >       release_task_mempolicy(priv);
> > > > > -     mmap_read_unlock(mm);
> > > > > +     unlock_content(priv);
> > > > >       mmput(mm);
> > > > >       put_task_struct(priv->task);
> > > > >       priv->task = NULL;
> > > > > --
> > > > > 2.49.0.1266.g31b7d2e469-goog
> > > > >
> > > >
> > > > Sorry to add to workload by digging into so many details here, but we
> > > > really need to make sure all the i's are dotted and t's are crossed given
> > > > how fiddly and fragile this stuff is :)
> > > >
> > > > Very much appreciate the work, this is a significant improvement and will
> > > > have a great deal of real world impact!
> > >
> > > Thanks for meticulously going over the code! This is really helpful.
> > > Suren.
> >
> > No problem!
> >
> > >
> > > >
> > > > Cheers, Lorenzo

