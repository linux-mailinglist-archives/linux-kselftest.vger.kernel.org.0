Return-Path: <linux-kselftest+bounces-15447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10266953B4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 22:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86D82853F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFDD1459F9;
	Thu, 15 Aug 2024 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KnmoZ1rT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fg/B1iKP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C05103F;
	Thu, 15 Aug 2024 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752918; cv=fail; b=uudysHPzjxZXBOAnkdgcMNxl6Y4xv8u/BmGAblCgB3is01dLhCeaEuk8/3NL76qjAO49XWm/oLTa6tpkd4sYlX9pEK78z6KSzHZTPVFvWvetadTCLzgvV+bC1Q6RIj2T/vtOO/38riLaH+FSw++6/Rpi5LvYjpG9DlA3dW0cidc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752918; c=relaxed/simple;
	bh=X0u0JYiqONpOTtxOW66jTfAS19iIj8ycyQKYSFMEuHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Se4qaJMEOJOJLTIjn9I90CjUHHAXQ+VJxsGrnqdfUgQnqB2vWjSmGRlIUEfm5kMUvxwB/Honec+LENOOoARJtkWteHorXCcuxaX7dNYR3015Ks+0NNkhb2+gm5El/OvT5CzIOM2IwMxzhjyX2h2Qaq9XxfXUgct+7INbtYITbNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KnmoZ1rT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fg/B1iKP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FJtXSM019126;
	Thu, 15 Aug 2024 20:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=z8ifncITrzoevKcu4z4/R90bH7XzCrjf2vy9FoqF+w0=; b=
	KnmoZ1rTwiKB+2Tuv65ox+lapswUg7DE8A2XA1Vys7pMpgWaWqv25nZZvDn9jf6K
	eyoOKR/MsgXav55rFIDpcIhbYwvmxJO19FVF2za5/jNM/Wm7nSvVvyS8kYU6KWot
	o+HH01d/EcoVtgGNdNzR2AsKERufkhgY1N6l/5br8L3WRbT4RZE0RqZxQThewY23
	Le29jBauf5CYx7A8rwfQdeEjSmMHARgQA1x+ic1U8eVEIUp+A2FEatAEWcTdts3k
	BAtBF0dmTrbE859sTcwxCbE9Z3unyRt8peR5WLpM9+N8I1Xf34VRW0bhDOvFR9WP
	H6hdzy6dy4qU2YK6Lo6Jow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4bkdwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 20:14:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FJ1nnJ003805;
	Thu, 15 Aug 2024 20:14:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxncjx8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 20:14:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUAhQ+rrcb0HlMe6bbKy4QIJWgb/PE/+TY+8bNlLyug+VWTRFkBXbsWB1KaJgY5UpeRAhcWd+SzzKsssvNPqQlOLW/+zbRAwlf+Jsb1P8z9Od+b5rES5MhM+P5DBoo0R7FIQkG2ByWCS1wapgViRPQaHwya/tbTuZ3eRr5ZHvwM6g6hH50pdHy7nA1AAW8wgpgrrYMeh8enNgZtLX7TDIUPRDgIC4szqkgUS8cC2j6QsffF/6I/meUURrEzDxV4zFpTiTT3uCy7xD+5w6+CUBgHYe9tXm9ZelvCLEj2XVzIAMQsfxprd1BqRErsGmjuVqRbtNxfuMvzxURHwLTMQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8ifncITrzoevKcu4z4/R90bH7XzCrjf2vy9FoqF+w0=;
 b=KJsWi7I9YPU0ai7vhBvknqvkvEiWGKK/9cDsrevzuhEnWcDbdwjkOirUEUBer2lIQ5rfJ31grui2GjX3AkD3SlWAqIWrNrHB7gu8QHmr2PCDGw7I4WJ4DTj46y0+JoYuDA9h03VxvfZ2m014czGoVSqQytqORmw8/Ya/NnStKyVKH4zBEKLawMsenljJiOwMc0ReUkbDFLtYqJFgP+aBQtXoFaHDaTt4OvcG0ohE3zLtoJwtRtYQ52VpoH/onTthHXAH1brxIu7ShjYnVQta/N9UnEwO3Kqi8MzjtuMqvEJ3ayv3a5+v1vNv+wEdtoetnLvsVTvpc7U/Gj4zx7Znvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8ifncITrzoevKcu4z4/R90bH7XzCrjf2vy9FoqF+w0=;
 b=fg/B1iKP0shtofzacH6DAn7z7V/ln221xiyRmZ38ptr9++fKhl8Lex611O5vV+xah9SBGT5cAofECFLjmezQL6OI+jSGXoHZvH/mNN2+Sd7Zm8Bj8yVd2n2Yj+rJ8P/1FGH/mffKJuVT1QIcM7m9aErf4xAGP0NdHSwbkOiP4qE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW4PR10MB6582.namprd10.prod.outlook.com (2603:10b6:303:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Thu, 15 Aug
 2024 20:14:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 20:14:35 +0000
Date: Thu, 15 Aug 2024 16:14:33 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        pedro.falcato@gmail.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, lorenzo.stoakes@oracle.com,
        mpe@ellerman.id.au, oliver.sang@intel.com, vbabka@suse.cz,
        keescook@chromium.org
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
Message-ID: <nu4c2nh5jsm6ldb2xvyw5ilgvekalq5lsfrxjw6xsx7txrwygt@r63xfvdt7cjk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@google.com>, Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, 
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALmYWFv+cy4mL85e4fLCC6fbt4FxB1ONSnVaBcezN84bCbEr5A@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW4PR10MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf1c175-6168-472b-d210-08dcbd66e1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm9MNitMcnpBcE9kNk9nSEl5YzlMajgyYThLZDBoQlhHWVJXaFZMaW9ReC9s?=
 =?utf-8?B?aUZ2SVRoQmlPVFd4aktGUWN2Q0NmMmZmb2duMGhKcWZ1TkZnOEdoY25kUjZo?=
 =?utf-8?B?NThZVmcyZU0zNXQzeFViZll0NFU1VnkzM2t4Wnlka1kwaC9uWHNid2FndHZ2?=
 =?utf-8?B?OTRHa0FVWitFM1BEeTd1ZGZQU0ZZcVRZY011cTUxODZrbFZSbVJSNGdUZm1O?=
 =?utf-8?B?Ly9DdjBkWjdwaGZBbkorYkxmb05FU1pTK2JUdW1GeHVTR290NEg5a3JsVC9B?=
 =?utf-8?B?R1hhVmRQWnI2KzcxeHhlRWJzaHlYSmVleUFlYXFObDE1VUovWWtCcnB3UGdL?=
 =?utf-8?B?N0NwT25CY285QlB6cWhpTForODJ6NjRDeFpRNlYxeWJkS0lFRGo5VGV6VnR5?=
 =?utf-8?B?QmJ5eGkwc00wWmpJVFlyazBaQU9zZkxpQkdMbVU4cHEyb1ltRkt4M0NEZUxC?=
 =?utf-8?B?dXRob0N4NjlBaXU3aWVtK0NVZldWSEprNFRZY3RoU01UQjNyTEdyaTArVjJW?=
 =?utf-8?B?QTBheUYxMnlJM2F6TmZmYUorUHdNdHltNUtWVWhZbmdQTlRKMk42R0p4ajUw?=
 =?utf-8?B?ZEhzcUh3dXVxVnpXTlc3aVdFL21RNERJRVZ3TmduNGlqb0d6eUdnT1Njb2F4?=
 =?utf-8?B?TU9kNDJyd3hySER3NHdxU1dody8xalBydlFTSHFDRzgwT1dIS0dXU0hacjIz?=
 =?utf-8?B?ZGpxVnUxbUUvU2FobGR4dFJIcStKR2dhSGRXbUQxNmF5MTVWOXFYWk8zY1Vh?=
 =?utf-8?B?ZGU0c2FWTWJDL0loSWZHNkY0UHZIS0ROVmpqdzlEMklxeGRzbzJaRDFHaEE1?=
 =?utf-8?B?SWdQdVE4dDRhbGllV2RwWTdzU29rU2Z0dm1OUzVQVzFvdlNvTGVvaUdJZVBQ?=
 =?utf-8?B?VDlEbklQa3RnenZYdVBORkMvU0FncW81TWxjSk9vMDZlQWwvNldrM0I2MXdV?=
 =?utf-8?B?aVVMVG1XZVJ1c0RhQkFCNUhoK3drRDlIUnNkSGZZMEF4TVZUUFFBS2tYbGJM?=
 =?utf-8?B?d0ZKMWNmVXJvQTZldWZOS0dxcVk0eHlNMGZTWUhTNUJNSytFUW12ayt5WS9w?=
 =?utf-8?B?eG43MVdEODVQM21Qa25HMTBWb3hUL0xpa3dvMjE2eUprblcxVnRVWUE1bmRz?=
 =?utf-8?B?Ti9DQTRBM0NlbXV6Q2l6WFdNYmxTV1N4MUhYSkJJVC9IZ0gxdGZBaUdqZ1Nj?=
 =?utf-8?B?K29YSzN1SXNDbnU2YWZ2R1hnZmJpRS9mN3BEUldDTjdmNURlZ2hVbzJsQUIy?=
 =?utf-8?B?Y2c5SGRIN2VaT0s3QjhScWh5WW9JNFd0VTJ3NG50aEd6YmdGMktUUHo4dGJj?=
 =?utf-8?B?VDUwaFBCdHBDbE5LdlJuWTU2aFlGQ3hDdFQ3VlMyemdHNXV6aytXR1dGN1Nq?=
 =?utf-8?B?S0t1Q0cvbnlDMTd5RDdqSmpIK3c5Q085aDFKWk16Y3RMSGpzU25TRWpmd3VW?=
 =?utf-8?B?NGI5RXkvLzZpSlFFNDB2dWRIc1lWcU1vMmQ1aldrN2JGc24ybTFNbWlVZWkv?=
 =?utf-8?B?cEtYNFcrRkl6NDU5YWxxdHdiQlB4Ukk0UmRsa1BMR1U5cU9ibVdsTk5pMWZk?=
 =?utf-8?B?b2dnVE1najFjOVhNaGFTN1hxVU54aVlaY1E4TGNDTzVQTk1kMFhoWi9RaTVy?=
 =?utf-8?B?Q0ZMQkxPaUlEQTc1dkRIdTk0S1J1Q08rZW41VWFvNWZ5em16bTZzVk1oeU0x?=
 =?utf-8?B?SUN5ZXVweVNFUjZJRXJ3dExDdElDOWdZTmsrbHBmV3Q0M0tJczBPUFdTUTh5?=
 =?utf-8?Q?A46E2RlxKyyUR6ewa4bgZv58AeWSO7fZC0fCLE8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXRtbkEzOHJNcEdncWkwQ3NaLzhSMTVsU2Z0SWhzc0hXVUVQaTIxRi90S2pC?=
 =?utf-8?B?eFFGWGQxWTNzZFM3QVpteXlqcGJoeTdiYTBYeGU3d0FrQmVLaWdDYWgxMHY5?=
 =?utf-8?B?MXBWWUg4a2duN05OWU1kbGRkbEI1QWx2QkE1WjZOeGhZZDFZdVozZ1Mvejdl?=
 =?utf-8?B?OFAyQVZxdHh0MlYyYVdieXNobnVlbmZzdExPVDl3ZUhaYm8yRk5FcDJTa3BG?=
 =?utf-8?B?Rjdpa3JmVlhRbEw5RzMxNWFydzVKVDhlYVNUbkp0dGpwRU9SOUhJMXhNQXor?=
 =?utf-8?B?YUMrV1lxSVZ0OHRHNjI5WThtOFFCelNEZWNGV3lyb284eFFNZ2FtNGd4VDhU?=
 =?utf-8?B?T0ZNSktKRzE1clNDK3NvYTNDbUVSWUJEd3Qxb0lTZ2NmR0x3TjNmRjJ4SnJZ?=
 =?utf-8?B?ZGU5VEZEUzJncEd1NTI0WkQ3ajliL0IvQU5senpnQklDb3krNDcyWGhsbk84?=
 =?utf-8?B?WnVaZFRXdFYvd2VvMjB6QzI2Nk9waTVRaEEzdW9YRnIwelBWaHFlZTFjNTBG?=
 =?utf-8?B?YVd6UmFDMk4vWlhid0liSGdBeWJGS1k4UE52b1NhTDV5UFR4T09ObXpyTTJB?=
 =?utf-8?B?YUZ5R0phSmlueElZeWpGc0dFVnZ1c2k2MVd3ZjdKSmRJaWs0b283ajdURW5Q?=
 =?utf-8?B?WnpiS2Q5UTdZL00rQ3YrSE5TMnJSV0F2QXd5WElMNHFwZ01kUyt5ckhZU3lB?=
 =?utf-8?B?dDRkYTBWZUdMdmRNQXNRc1g0eXhkL21VTkdCMjhUeGRMclJ2aGc4SFZ0U08y?=
 =?utf-8?B?L0NMaXdqMDdZVysvT2dWLzNGcW04SWF3cEN6V0JDNHFkZnljbkVESk9JbWQr?=
 =?utf-8?B?SVFKUWthb3BJNDZiWlNVcFl0TWc4U1duV29iTTJ6TFUrcHJmWU9hRmdRRHgv?=
 =?utf-8?B?c2pqY1ZVZEZxYzFXck5WNTVHTXgxM2crUW5OQXNFNVhBa3VxNHVRdUloYzhN?=
 =?utf-8?B?eGxmVjlhbTdaYU9WUjQ0L0c5b2ZUWHI1KzZkRUgxSjhBNTduYnVnVFlTUmJ3?=
 =?utf-8?B?Q3kwYUR5b1JKdkVQbkpuY3dQbGxyM1BzbC9NcFFEUnBKNnJrc2RORE9VYTRH?=
 =?utf-8?B?UWsycXFWNUZNZUY1V3h3bXZBUENhZ0tmUHh2UFN3aEtvdHRjSVlKY2dkYzg3?=
 =?utf-8?B?SGJ5aGg3MDdBOFAyMElvQ05uaHM1c2xFcC9MS3oxQXFNcERrZTk5NjFRdnNr?=
 =?utf-8?B?SFZXNmV2elFkMDZpNmtGRldFcDVJaG9tVTNlWXZmSGFzalFxdmNlVThTSEQ2?=
 =?utf-8?B?anU5QXZLZkxLVWxrdHBzVmRla1h1K2VTSDJFUTdRQ3dkVE9ubUVmMFUrcDNP?=
 =?utf-8?B?SXdqdVAweTBkd0FOaldFOUYzR1p3b2FnOUh4dVVGRUZmNytHV0tuZ3NBS0xa?=
 =?utf-8?B?aWo5akl5MUlIS1BMUGs5RndrUGZqeVRiUEVPcDRFOWVRT0F2dk83NHdGYSt5?=
 =?utf-8?B?YnNOTlU5SHRGWUtoWURxMkQzbnNHM1dFSG1Wd25PcWRERXYwTHhEdk96TThv?=
 =?utf-8?B?b1p4L0trQTJsUXhiQ3N6YWNXL0t0cVZjR0tOckQxNU92SGJacHZxM21UZjJj?=
 =?utf-8?B?a21UNG9nWmJ6OHlvbzFhNHFPeXpHemliRXBxNTc5aWEwRHA1MFliRUhiTjll?=
 =?utf-8?B?czR6dm56MkFvd0NUbmMzWXhHK3lUSWRXcEZ2QVErOHF5c2k1UlZJWFhlVXR6?=
 =?utf-8?B?Rk5JR05nWjVPTjdyS0toa0VjT21UTm1SZ0ExbVlETElXTlh3ZUYzMm9YUmZG?=
 =?utf-8?B?VVFZZU11RmN4YkRNQW1nYTExSGpNQ1VQVnZ2bmZsQlpjUFFhOTM5UVh1Tkl4?=
 =?utf-8?B?SkY5Z000M1hFdGRqOUhISDFoUDlFSFp0N2F2R2dJKzM5bTNydEV1eW1ZMkZC?=
 =?utf-8?B?eTJ3MXpxeGYwR2xQNytGMWE0a1padHBZLzUyekx4Y2ZyWW1qT3FuR1RvUnNN?=
 =?utf-8?B?aFptdm9GSnphS1VJZFRvaE82U2lHcW1MYXp1T21SVFJjSWIrSmdYUEdJdlhj?=
 =?utf-8?B?bGVBTlFRajVJYUdEREkwTElCcnlab25iK2NpdmRLb2ZBTXRkdU1mWjV6NXNU?=
 =?utf-8?B?N3M0VmY3UXBxWEhsZ2V6eXBZMWlTYUVKYnBmcGRkODJWdUVtSGRKaWFUcktP?=
 =?utf-8?Q?jRVs5G05jkys7e/DnptQYfDaG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KeULTjz1nRwABxLHJsmqh2ZitOuQ6c+kjD9ZJu3Z4L2LxMy2fdMxf7dDJhGdxt1sW3l8LbFj/0DSMGJlEjW6k8lBvGuk26lZgF2P6sVIK+DK1FSx0UEL7STSLArDcHxxTZXMP4VUEgiaF5flYBfh0BQ9SkRQNktwt8wtKj/JviPw74k3zbRSLsTEn34vrbgNCeIWKWDg7omrywlp+dl3vBuIp4bto34iCCz+8GOYjr3rIEg4M2x7ziSoYgfG0Vo5lzUmaJOc1S2JIPWtx5f4LZLEr4dKNVwuU+FTmQWeiZ+QKw3UZ1AEMdQdi6afKF7Xx6zI7qZGYE5m6grde2f77AM8CVOUtQGBDPDR8wGKjPzXZsE9T51gRab6cLzCfxdEIXXqo/EAKOcmXBfDQb69IcH8s67eMQ5eKmpJ/wWFajRnO34dpzZJ8vytBkmuRYzAwURz53lFRX7xOVmvKhVEfr52AfGrdKht4rKDbpVCcKT6fHcclUR1vwTSIiZz79fzyKOcAj74QaodFK8w+HTeZO6/ggXij/vogcbiPjYU2bSdhrxkYuIZwE6MKlQb2RKacLKg7VApW4KhrSYKOMqH2krplX91PAGF8g4NbjirTgY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf1c175-6168-472b-d210-08dcbd66e1cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 20:14:35.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFKt+jJaVC0+b1GB7cNWn85LlV0QqJbsyBnekM1XK0kPDn9mBqy1d6LnGTd7r6K1PJ3I7t9lvr+b4yahIzeilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_12,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150147
X-Proofpoint-GUID: zH-mkAAeGInbfsBs9PSviYiJQPCMUfUo
X-Proofpoint-ORIG-GUID: zH-mkAAeGInbfsBs9PSviYiJQPCMUfUo

* Jeff Xu <jeffxu@google.com> [240815 13:23]:
> On Thu, Aug 15, 2024 at 9:50=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Jeff Xu <jeffxu@chromium.org> [240814 23:46]:
> > > On Wed, Aug 14, 2024 at 12:55=E2=80=AFPM Liam R. Howlett
> > > <Liam.Howlett@oracle.com> wrote:
> > > > The majority of the comments to V2 are mine, you only told us that
> > > > splitting a sealed vma is wrong (after I asked you directly to answ=
er)
> > > > and then you made a comment about testing of the patch set. Besides=
 the
> > > > direct responses to me, your comment was "wait for me to test".
> > > >
> > > Please share this link for  " Besides the direct responses to me, you=
r
> > > comment was "wait for me to test".
> > > Or  pop up that email by responding to it, to remind me.  Thanks.
> >
> > [1].
>=20
> That is responding to Andrew, to indicate V2 patch has dependency on
> arch_munmap in PPC. And I will review/test the code, I will respond to
> Andrew directly.
>=20
> PS Your statement above is entirely false, and out of context.
>=20
> " You only told us that splitting a sealed vma is wrong (after I asked
> you directly to answer) and then you made a comment about testing of
> the patch set. Besides the direct responses to me, your comment was
> "wait for me to test".

[1] has your "wait for me to test" to hold up a patch set, [2] has you
answering my direct question to you and making the untested comment to
someone else.

So, entirely true.

Liam

[1]. https://lore.kernel.org/all/CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo=
+-8MuRJ-g@mail.gmail.com/
[2]. https://lore.kernel.org/all/CALmYWFvURJBgyFw7x5qrL4CqoZjy92NeFAS750XaL=
xO7o7Cv9A@mail.gmail.com/

