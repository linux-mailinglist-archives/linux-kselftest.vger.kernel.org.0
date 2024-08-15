Return-Path: <linux-kselftest+bounces-15450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1027D953B9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 22:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E9F287E5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CA15443F;
	Thu, 15 Aug 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D5t3RWgp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L4y5P7AW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4214F9F8;
	Thu, 15 Aug 2024 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754462; cv=fail; b=BYa+1wJG6znMSWwKshnHNDqFUzONHU5mhGB2VgDqnLCXksy/VkwkTUJqanIAdqjOGzVLRUtZwM33frN5QOG1AFVhE8iZUGtsIFahO87u8v1Y/oFSTBuV6v3WnYuzJr0Jgyt9rai6bQr796gjZ/inkxjywoEPcDHb7fUboBzM5bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754462; c=relaxed/simple;
	bh=0S6aZdidZ5sfjnqvXTmhC5/0RfvMSejlspmYEZXv/ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T+XTIj1YwEpYnjaakNosCKtEtutN4K3dAaBly8LRNWlJT43ydsYhtSOpBjty3akJmd3yYhz6NbB+iLiWMpqM7iW2QvR6Byt9mVXCjDLIYVuvDoP/R9fIMwan5+gTHPb8WnWCoSstNohAhhAv0cNDdGbi2Q9UezqL/Nv+iCrgfP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D5t3RWgp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L4y5P7AW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FJtUm7001169;
	Thu, 15 Aug 2024 20:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=5z0gNRUiz6rSQTUc+AigsxfjhxdLlXJ9pXtWQgtNtVs=; b=
	D5t3RWgp7WkAsJEfv6PCF628mHLB3kdYK+gPM+aQhmcx8nYLoTdNaJVJ2vIjWn4t
	zpEhURvrby6gzasRqS4cqTzMEWpW30+plp30bnzOXE3XVXrGw9BYcrO4h7mIkj1M
	EPRK15h2Kni2b2LMJFmdHO0heVQJZhbL0YRLOpLny5yH5ONMMGqIq0kT30hzEgo8
	zI6h/lfSBuRsK4qSiXnifcTUD3xyFOWcyrjzloRilTNxjrMn1vZoIS7BlQPEvTxV
	JiETRnUK9Tk+Ahxg5NrkXy60EEJ/KSI9fQkOayEj4O7CAJG2ZZm7V7peU7N2TtCU
	Mon/KcrLmoIiFploMdcOVQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gap39w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 20:40:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FJlNMj010755;
	Thu, 15 Aug 2024 20:40:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnbkqvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 20:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRlasMqXzpBvQLc6y2TxAaxKjKtpF/aKhJSh3VisW1UUEH/ldzvUeSUnDbqh7E+Jki8E+yTtl/F9rqxtjsaWJnBAr+kKOxtL3SbiYfXjOthq3krn4wX/WCjC5mZGbaZV2Jqi05rTFxp8MGFpFcJDnSddBJpcclY5qilMwJLFwRQc/gCKPEHtk0W4EHUu2yrLJQqd7OgeHmZQynq+SgS41jHm0USzthu95rnFdZJHHRr2vttu7pVtRws5c1y93vf2wVC/afzLxQUwJHaabSPavsHgnsDaP+UPzj8ng599cBXiNggUH7N6jBDWSdrSrZEbxVrx7NhVwGhseIqxD3vbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z0gNRUiz6rSQTUc+AigsxfjhxdLlXJ9pXtWQgtNtVs=;
 b=nDkZYVucRtHC3Se20C1XBbGQZ9tnj2BxVvgGnyLemSntjzhmGJ4N58wkW/v8CYmelH8lMc01pDy7nuLZrY7JhcCclEflKxVUy0prLS4PGVKUevLuSiBoXF1eG6SXHvOpjlwq8rm6YQNMJzcUwQm/De2dQ6xEt/XzKgmDVaD7U/SwH+ufWsQE7xFZAy2L2tXdp/iQIKqB2DnuD85Oi7EPKeTCDsgSospauyE7zcqVBmc9VRdk5IoiRPqDxtECpLEM4z8bLhffalDYyK3njKFie4js/HdtanpdccQNA7whCiyzH3bwsRJje/RZw+1tQQWhO7cyvsArJ2gyYJMMIZCFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z0gNRUiz6rSQTUc+AigsxfjhxdLlXJ9pXtWQgtNtVs=;
 b=L4y5P7AWCf+abL43gRCqkCZ4TCezcZ5E02kfIyYLro3mbf6FJXI9cUKtUQPZLK/PbOXiKOXc3HaJiWYwJSn3BkpjeXgjAJV/B9NsWSp4NC9IzBFEhG1I4ee9gUj+tCcC2+NJyHE0UHMo3g+NxVM57wEcIRCl4KxD1PySzT85LpM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6904.namprd10.prod.outlook.com (2603:10b6:610:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Thu, 15 Aug
 2024 20:40:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 20:40:37 +0000
Date: Thu, 15 Aug 2024 16:40:35 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        pedro.falcato@gmail.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, lorenzo.stoakes@oracle.com,
        mpe@ellerman.id.au, oliver.sang@intel.com, vbabka@suse.cz,
        keescook@chromium.org
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
Message-ID: <77w7ubt4f7hmpc5grmcmzey7kuav634zzgmk7amwbx47tols3g@ptjbrd2w4ay3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, 
	willy@infradead.org, torvalds@linux-foundation.org, pedro.falcato@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, 
	oliver.sang@intel.com, vbabka@suse.cz, keescook@chromium.org
References: <20240814071424.2655666-1-jeffxu@chromium.org>
 <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
 <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
 <mlwues5aus4uie52zi2yi6nwlaopm2zpe4qtrnki7254qlggwl@cqd42ekhrxez>
 <CABi2SkVrk-MyMGVDzRZi++7tzCu6k92Vz4hyaVHY2nbYDxd97g@mail.gmail.com>
 <szuouie2gbpaj6gynixelasgeo5fxtn5fd3vbmebzve2x3auum@2q4cjchfajvh>
 <CALmYWFv+cy4mL85e4fLCC6fbt4FxB1ONSnVaBcezN84bCbEr5A@mail.gmail.com>
 <nu4c2nh5jsm6ldb2xvyw5ilgvekalq5lsfrxjw6xsx7txrwygt@r63xfvdt7cjk>
 <CABi2SkU84jZFa8qGPQen9g16zQ9E-Z9VOuUE+HjNDSMCPoRA1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkU84jZFa8qGPQen9g16zQ9E-Z9VOuUE+HjNDSMCPoRA1g@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c6ff5b-b526-4d6d-6062-08dcbd6a84cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVlPRlhrUmZQcnlvZExZZ0YyYUw5SERIYWdKN2pQbkQydGo4ckl6Nm16NmJV?=
 =?utf-8?B?Qm1HU1p3Vkc2eTNoUUwzT2RNaUd1QytDWW8vMmJ6QkxVbGs1alRaanVMT3Ey?=
 =?utf-8?B?eG82MThJTUZsRXRjVHY1a2g2MGtsMkdMRXNNL2pHRTdkcGdhWkxZUnhtVGJ1?=
 =?utf-8?B?QnVQR01Pbm1TNXJSazlaK2MxaXQwVnBKQkVhZ1VxazBzUjAyUnQ3UHdIOWpv?=
 =?utf-8?B?bkZwZGE2Q1VjS3JUNFJPbS9Canh4cFBFVTJTMnc4WVlNN01iaDJQWkVhV3Yr?=
 =?utf-8?B?K2dDajhtZnhDZU5qVHNxMVd6R01RMzNFSE5vV3BZMy9Mc0ttYmtLRnZXNWVm?=
 =?utf-8?B?citzSndDNDJkQUF3S015WVBsNmQ1ZDNxQ2ZGc0FVNlFNZnNtUGxRN0EwUVIv?=
 =?utf-8?B?TUFMZUxjZHpVbXpLVWZVQ2I0R0Z5MmttU3Zlb2F0TzY0Y2pxOTdPWVE3RlZH?=
 =?utf-8?B?TTFPYjdZb0NTeUFxOG9ubktDSkM5M09nQ3Bhams1a29XNmM2VzNoNHUvL25O?=
 =?utf-8?B?Yk1GcjNLWXZQN3JWajYvNnNObUJRTzRrRjFTdUM1THkwYWtqVVdHMUZRallU?=
 =?utf-8?B?MU51WmNoU09Ob2l5eE5WSXNYb2RhRVlXMmkyNDhDTEpQc0k1T1NQd1lUYkUw?=
 =?utf-8?B?YWdYQ0FnMDB0bGhaVGg2a1VGMlU4S2JKWFIvKytnU1FveTU4Vkk0d1U1NFkx?=
 =?utf-8?B?cVBVMjJGS05UaFFaLzNMU3R2TGJaSjd6Ni9HcmJNUjhmVFNFWktvSUhxZWN5?=
 =?utf-8?B?LysrMVQrRGx5TmJhekRjd3F5RnpsMkhiV2xONzY5bHE0RE9rRlo4UExEbjRM?=
 =?utf-8?B?ZW85WkhVSnFCYkY3UTdJb1RQNC9iTUJHSmt5Nkp2OUVHcW50Z2crSHNXUHZx?=
 =?utf-8?B?U0dVTDdSNWs1ZFVXQ1BDSEgrWUIxc2ZEU2tlN0kzWEEzT0lSUVp2VTRHOVF6?=
 =?utf-8?B?YTJZZWF1cUlSSDFsRUpkM0JpVVNSQkFBeHlDN0lNbGZndEhqRHlKUllhSG9B?=
 =?utf-8?B?V3p5eE04VWc0aTNmUGpXU0cxTFRoYUllTjV4YURJYlo0Njk3bnNkc2xNY25i?=
 =?utf-8?B?OWMyK2N0M2w3czJMd0RXZnV3SVliZ0U5RVRBN0J4a2lLSnhpeWp3bldYTFFa?=
 =?utf-8?B?N282b1FhREFvdTNseHo3M0JPaGVvbXoxRUltemZPLzg1b3JOWll3Wjc4b0Vq?=
 =?utf-8?B?R3dSZzlhU1A1d3dlZFdTQXFkV0ZJUkVWS1BEVUJHK2kwWll5MzZwT0oyUVo1?=
 =?utf-8?B?cGloaFlZQTdXRm1EaUJQNGlhbjZ0Z3U5djNObjZ0eC9Lb0E0U1RuTTEvNUNN?=
 =?utf-8?B?RnRsS3lGVW9BZzcrWkU0UHl5U2s5enVLMHNzT3huWnR1RmdMVzkxSy9ITi9E?=
 =?utf-8?B?NGhJT1NpdlkyQmZhZk8xZG1QQk5HdWhBMnJUMDVmbDZzWTNWa0JwWDgwNHNr?=
 =?utf-8?B?c1JpT0VOZGV3V1pnRWxjVDZ2SHEwWnl5OVUyeW1YY1VmaHlHRUhzbklIVGVF?=
 =?utf-8?B?L1ZyWlgrZE9HODZIUHdEMXA3dXF3ZmplTXpaeTljRENqaGZoa0h0WVN6RzFo?=
 =?utf-8?B?N2RDWjRsdzZBZURNTVpqQ0dqeVRESWI0S2lpaFdBd1AwM1JiYkZpMnB1T2wv?=
 =?utf-8?B?QndwcWlFMCtNZ0hTUG9PQXg5ZmIwbGdQb2JQMHZ6bENpZ1pnWmpDSWozdTlp?=
 =?utf-8?B?VHRydE0zVkZJZERsQ1dmTDFTUVJSZkNWS0QydHllL0lIQkJyRHU0RDgzL0xV?=
 =?utf-8?B?T1l1Nm1XTzJLTHlBNms2Y3hLSWhwb2lPejBVZVBwTGl1Z2w4UDdlaG02b29I?=
 =?utf-8?B?SWw5ZDZVeWU4eld2ZGpOQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1VDcWU4T01rY1RhbDhvL3JaNXN6Ri9BdHlqdlBMcHFxNkY1aEM0YWVHYld4?=
 =?utf-8?B?QTJaa3FPWHFMOVZMU05xVzJ6aThEcStWbFkxZEpTN2QveHVjS0JDVFN3ZGZC?=
 =?utf-8?B?NXFENk1IM2ZSc0E2ZHR5bThnWnVuSlkydzVaNk4yMmZRTi9mNzZlVHVTb01C?=
 =?utf-8?B?eVF2WXJvUmZURnRSNVBzNHZVMklWY1BVWTltQjE0VHU1Mmt1bnZxdUNnRnpU?=
 =?utf-8?B?Y1lWZHlQRHREQzBjYURNS2NBLy9GRVVCM0E5YVZqUkM2Y1BMdTBxMVVZSEMv?=
 =?utf-8?B?bDBiVVhXVzFDL0lJUkRLZkswcVNpMXQ2U3NPYTBtZnE2bm0vZUV5V2x1dW5N?=
 =?utf-8?B?dkJxcWZZK0JCUk5EVS9NazJtRVNrSDBBWjhyaVpucktOTVUzOVQxRnJKb3pO?=
 =?utf-8?B?cWJRdSszQmpyaU9sWmZoWkFBZWZ6QzdNTnNZN1FGWnpzZlVwRzFPSzB5M1VC?=
 =?utf-8?B?UXJBZXgrZTZXWWd4Ujc4c2ZPNmorYlIrZDNGeWEvSHBQajZQbTMydndxa0ZW?=
 =?utf-8?B?K3NYcFBaelJGNng3M0hQOVI3d0x0T21HS29tUDE2cGYrd2RZdEJUaU9VWVl0?=
 =?utf-8?B?SjdLYnNIYVlGMWZvbzVxbGVnY3MxekJLUUV0TUkrazV2VXVkbVVCMDRPR1U0?=
 =?utf-8?B?WllBRU04VXJDZnpndmpEdDhQN2JTUlUrSWhnTUd2Szkxc2gwSFF2UTBjckUx?=
 =?utf-8?B?cXhySVhZVzQzbXF4ZzBheEpLaVJIUFlQRHpRZmcwTm9aelVWa0tOVHlGUUZB?=
 =?utf-8?B?bTZKUFBaR3VNVjJMalU2QTJJN2ZCSEZNUHh3dDZYVUpRKzNCNVBHNW9vclMw?=
 =?utf-8?B?cUEzbW4zZEg5M0s3SXA0T2laWDljRU5TT0FMeFRXTndTWC9abUo0WGJNTllC?=
 =?utf-8?B?VGduclJhWW1GejVPVlkzd1hnbThJVzdiZWtvS3NzTE4yd3F1dTdrWkt0MkE0?=
 =?utf-8?B?L1BFeUxmUmF4WVRvWXhCUUw4R1JNcm5ERGplelB1cVA1WW9QWVBkbDZQbDlV?=
 =?utf-8?B?QlNZT1U5LzAvTFpFSzFCUSt0SlpDWk1JR3NGRURzUzRmZ1VqS1l4YUVjOXJP?=
 =?utf-8?B?UExRbHNSajdhditzWXVlL3FXSWl6Vzl3U05nMTRYNTIvZk1VRkRBcUk1S1kv?=
 =?utf-8?B?RE0ySzNSdmVCem1OL0Y1b1NEbnQ1dTY1UVdaR1QzMytuaW80ZjdPaVg4SG1I?=
 =?utf-8?B?VmNibTY2NDQ5d1FrNVYxdGoyZU1uVjZXVlZFcC83UTJvUGtzUDd4bHhyMDZ4?=
 =?utf-8?B?aGZ6TmUrUGQ5ZFM5R3pXbFNNeURuQVJGOVR4aWhPcVpHRkk5Z1BCa00veGRK?=
 =?utf-8?B?MmFVekdwcEVhR3QrSXovK3hDNktJR3lmYmZLN0hTQ2orVE84Z2V2R1lUTHRH?=
 =?utf-8?B?alRIRTFZRC9BcWhleEdKbG9KVENKQkcyV1JvcWVBSlA2Z2t3cUVXWThnWFdr?=
 =?utf-8?B?S2RGaURQcWxtbTgvdzdtWG1ZTFMraFc2MzhUYWVzc09qdmRId1dkRVF2SWlx?=
 =?utf-8?B?amw3dTR2TUJBVHB6Z0x2Rit4c0VzQTJweWRxcUwxcEppOVpweGFtSkVnNDNY?=
 =?utf-8?B?blQ5NWZKRllvNDRaM0VvMUxBYzlLMC9LaUVYNXVjaktpYURMVHZ6YnVmZkdt?=
 =?utf-8?B?cTZ4dDg4K2Q2cjFpcXRuTXNMT3VlWlo4U0dEcHRSbmZjcjVCdVRiUm5mWU9o?=
 =?utf-8?B?OHJPVmN0U2VUT2pMU204akYrMTZKMGlYUzZRdHZ6Tm9ZYVpXcG1CN3U0WTk1?=
 =?utf-8?B?dm9LTmFOemJ0bk43UlZ2ZmtydjlOcGFGNnZOUnJXS0dyeUd3TzRTN29HcUFS?=
 =?utf-8?B?OG9RQS9UT1dKeks1bVNmM3RNUWovZWhvd002UEh0eHNaTmNZWlpDT0VVWXZk?=
 =?utf-8?B?N0xoRnhzMTVybEthRXl6eVNBVEJnblgwOHl3d3ZvcEJTZi9YUGdYbWZDM1lI?=
 =?utf-8?B?RGR0c2lpVEdXdUVObVhZTzYzM1FKR2ZFUWhqWEVnbDc3QzVzTG1PMUhXck1G?=
 =?utf-8?B?ckhkbXE2d3UvODhtOEFSTDBsSGx3Tmxza2FFWnZDUVZjTERpR0VHc0twa1Ew?=
 =?utf-8?B?aGhVWWV6a1NveTNXcFRKcklQK2pmS2cydVcrbVM0MTM1YWNVRklTN1BNdHRr?=
 =?utf-8?Q?+hgLpRn+EnhqF8YKRAAvanLiL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2pPo72OMZPEbe0CYKqZQSO6K2I7cGxvXTo8oZ5Flt79Al6jxv9k2ms3ZkfPisHt4jErxUUBSk9MWS/gL/+hgp2huLSoKkPfhWhjTIGuVeNmIXuu/PEX+IAr+FY2r2psW/ENdZOXI1kolx3JBjLdk2+THAYH7cZTbrbNlqPfjNcduAXHsKIlIwkpdO7mKNhR2dSalxFQFffWxz8Es1aBicknrJt7WYha31U4fa3U17PBYpPOVNa/j8LZJlVFRl7EaDELU9v1kf4TaIXK8p6DkRjt0dX8s8nkyR4vyNFP50wjYl/bf26qnxaTTb6IZU2FAOJD2ToR3oDSeKwetHzRoV80lSu4DA3FwLm/RRLa315yX34xC0h8K6Fi7quin0Py4RHhvjmK6T0Tj8t2f6MDmN82v4Ntm6ShrkEmYyI8I4vtlC/zZqVwmgOM2R5bjw2VsGNGjiWtDrQBVJ/QQLs9AwxykO3dDaUCqch0innnK5MJKpeYEHZhUIMFAjtpUKviPGXSBbdKPFxjDsBXIW+jw3vEK6jar/3Kb6II3CnXuCTHlNz3lCuyXoKEaonYgI2IOWTsROYFuW5Bm1N1CdGgC8TBXKdJmbN2k2PAOhHkx+AE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c6ff5b-b526-4d6d-6062-08dcbd6a84cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 20:40:37.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUCmGFcQMeid5dWmhEnlP27R04/YIVm7jp+9s1mrrKbrXQDLjc8ewSY0EIA4fijnyyjK6xHcITWSB+qO6UNhbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_12,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150151
X-Proofpoint-GUID: TKp8oUV4fAwBYX2q3xoOSxoDayTb5Mdw
X-Proofpoint-ORIG-GUID: TKp8oUV4fAwBYX2q3xoOSxoDayTb5Mdw

* Jeff Xu <jeffxu@chromium.org> [240815 16:23]:
> On Thu, Aug 15, 2024 at 1:14=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Jeff Xu <jeffxu@google.com> [240815 13:23]:
> > > On Thu, Aug 15, 2024 at 9:50=E2=80=AFAM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > > * Jeff Xu <jeffxu@chromium.org> [240814 23:46]:
> > > > > On Wed, Aug 14, 2024 at 12:55=E2=80=AFPM Liam R. Howlett
> > > > > <Liam.Howlett@oracle.com> wrote:
> > > > > > The majority of the comments to V2 are mine, you only told us t=
hat
> > > > > > splitting a sealed vma is wrong (after I asked you directly to =
answer)
> > > > > > and then you made a comment about testing of the patch set. Bes=
ides the
> > > > > > direct responses to me, your comment was "wait for me to test".
> > > > > >
> > > > > Please share this link for  " Besides the direct responses to me,=
 your
> > > > > comment was "wait for me to test".
> > > > > Or  pop up that email by responding to it, to remind me.  Thanks.
> > > >
> > > > [1].
> > >
> > > That is responding to Andrew, to indicate V2 patch has dependency on
> > > arch_munmap in PPC. And I will review/test the code, I will respond t=
o
> > > Andrew directly.
> > >
> > > PS Your statement above is entirely false, and out of context.
> > >
> > > " You only told us that splitting a sealed vma is wrong (after I aske=
d
> > > you directly to answer) and then you made a comment about testing of
> > > the patch set. Besides the direct responses to me, your comment was
> > > "wait for me to test".
> >
> > [1] has your "wait for me to test" to hold up a patch set, [2] has you
> > answering my direct question to you and making the untested comment to
> > someone else.
> >
> This is the last time that I'm trying to clarify this.
> [1] is my response to Andrew and Pedro.

That doesn't change what you said, or what you are doing.

> [2] is my comments about V2 lack of test , i.e. no selftest change, no
> extra tests added.

But they pass the tests that exist.

Maybe you should take a step back, and look at both solutions.  There is
a competing set of patches that fixes the same problem in a similar way
that was sent out before these patches, and those patches address the
entire problem with the mseal() approach.

Instead of helping make the complete solution work as you think it
should, you are making the design problem worse and can't seem to verify
your patches actually fix the regression.

Liam

