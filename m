Return-Path: <linux-kselftest+bounces-40780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C9B43B0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 14:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99E11C27A85
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E992BE7D2;
	Thu,  4 Sep 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ce2nw8sh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sHQSSonj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919902C0280;
	Thu,  4 Sep 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987732; cv=fail; b=diUaA9fZK1KCI8eehLof9q9KxeHslp/ang6kyjn/+fIW5mQe9ig90W7F8PCVZTMgL7ZHBObkG5ogqOsD19Vl1JEtmhjk4lWmEtz0o+k/7DPUgehZkHmt/jxrcA+9eDs0AQdzOAjiYkwFl76THyfG+vONSVQw8YbQS1JWtHx1lXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987732; c=relaxed/simple;
	bh=cXrB/kw+jba/wiQekng6KypZZS+rbpCpuqB2nPP8zNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kp+NqDrXZqkRfKgJoFfYZRPelH2dniR2ies/t/BMxARCT9oMWk2bR5QKWHihgYLNJK1hbpHat9hUUt2nzqFSzAaOfibvpfQhNkCvNSmfHwDvAtlJmxpm4MVXFNl4nEi23g5HW74uhNRnhbugMuwL0rHutG5ZF15G1ys0PlSzi5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ce2nw8sh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sHQSSonj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584AYiHF021953;
	Thu, 4 Sep 2025 12:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6V9zEfLm/eHGWE5yzNcMk6hXDZnzLYl0O990jvvRXKw=; b=
	Ce2nw8shoyknbaKkJo3wSwhpxpkgc45Qax1LP+3P5e7ccycf4ZXtI8M4u1nhGBfg
	eba0SWw3AafWEWbg+2Ppots9LMvjK3LvlarCuXfiIOVXWlc9VHV+jFSPVrpdnoPh
	qabdYOFHYjmcjDa+rTOtMpxJMr/EYemruhcY4zKdoqYdrUxJS7uWTXayIqDQjLyE
	HryS0n37MomCG2U16T5SywMsXgjMagMuHZOIMXJ6MMLhMLxbxEsNRefGc4GaPhEi
	xI71mBGWkMP+xYTviVhEJnYU3SlRhFPCOXlYB8zCmsRGZxF8dI6tDu/CqY/7xr3t
	fdnRBp9yljyL9PQ+RBobkQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48y94v85ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 12:08:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584AqCKo032618;
	Thu, 4 Sep 2025 12:08:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrhtun3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 12:08:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a70v598lIh+2/jx4y1bPhlhJeDiSazI5O1KYUpvjpEv6IKsdQZKlAwAzPDw+KjTG/K03clKyFI5ZjKlubO07cRJUKy+qDRWxRERoFDAyrzhdBTsSr0g/E6/cYyviupfqXRAJ1yI8roJl73BQx8KzjOUmh4K05HTGL75fl3firo+txv3Q1LcwV24lmyfHRHhgFshLvVl3iOAJmbeswjqeiORGgSR6t43w6DhXq6il/xDlfY646yQfVXFu0IW+VDYVKgaHMpLITbLXz4C2cMKKao3Dloj6sGXEthWm2gwn3hoPMIvLV4AnI98eXu+nkGS4ivmaHND/wdZvN7Tgn9UMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V9zEfLm/eHGWE5yzNcMk6hXDZnzLYl0O990jvvRXKw=;
 b=uVM/UB+s/xBrIQYCRh3BMCvPgT4nb2WbSbkm/UY7134LweyPRny9KGRCtFIKUUU/XojIbUnKS6hMgg2JDvZIMSI68aj0MADBBiwaQxhqtGK0lsQTqM/oOPOLKf6mlH5yp8hw8UpKIpWpK4QCZzokank+vXhbo+nz2qCkQsbTKmwMBacOYaPNeUNPSw0jBRBJN+kcD9IsVlTdrTeiGp9mOgJEwenQAis8mG576Cmejtcj50rsg4WfhRgwoFUzAoqjfYYlxsaxedgq2VvH0/XxLu+ovFwD1UVOU5tI5E4H3wBxmNRZhSPH+mz9Y3o14LZTG++cuNc6vx0upraeyM1pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V9zEfLm/eHGWE5yzNcMk6hXDZnzLYl0O990jvvRXKw=;
 b=sHQSSonj5FZZdQwmFX9YOa71B4tjb1eq7FXG8KZZxlBtSOQ2wz8rPWjI0X+7bmp4y+2L8LagY2bMXsWPaxVKY/09a/FkR7SktLD2pyGlljrHrcwYtQaHT40qO+ancIE/LGMdpNO77hVIiy41PPm6IsWTwq/kLWV4rk7xy0cGv1o=
Received: from SA1PR10MB5509.namprd10.prod.outlook.com (2603:10b6:806:1f5::20)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 12:08:39 +0000
Received: from SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24]) by SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24%3]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 12:08:38 +0000
Message-ID: <0411cd55-6a3b-423c-b0b6-cb5de34827ff@oracle.com>
Date: Thu, 4 Sep 2025 06:08:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Sargun Dhillon <sargun@sargun.me>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20250903203805.1335307-1-tom.hromatka@oracle.com>
 <CAADnVQLve3KgrqNqSqVrmL-wz6Jj1QUdjAcE5P26Z4wvh9e4HA@mail.gmail.com>
 <42cf76db-6cda-4606-9128-6f433da57d48@oracle.com>
 <CAADnVQJSgcAjEnU-A9bF6-9MQRFvbHqRsCCY7a0Y6bhVGtcGpA@mail.gmail.com>
Content-Language: en-US
From: Tom Hromatka <tom.hromatka@oracle.com>
In-Reply-To: <CAADnVQJSgcAjEnU-A9bF6-9MQRFvbHqRsCCY7a0Y6bhVGtcGpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR02CA0073.namprd02.prod.outlook.com
 (2603:10b6:930:ce::20) To SA1PR10MB5509.namprd10.prod.outlook.com
 (2603:10b6:806:1f5::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5509:EE_|BY5PR10MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: ed05856b-08c4-46d3-7263-08ddebabc78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3lUUkZLdGRKckx0SjBSSVA2dEg4dXVQcW4zZkV0eFpjKzRSVk5LcUthajkz?=
 =?utf-8?B?S0UvUDFYVE54bjc0MnVKS0duVHdOdElGN3ZmOGtKcnpWdy8wM3hFUDNwb1k5?=
 =?utf-8?B?Mjh6U0RiMmQ1VnorejA0SXlxaTZ1TkdDN25EYnU0V084QVFMK01pb0pOVnpt?=
 =?utf-8?B?VGxoUDk1b0x6T3ZPNU1remlyWFR3Wm93bXIwbzlXUiswKzM0SEp0TEVMTFB5?=
 =?utf-8?B?NXJpV1lpVVd0TTkyK0REQU5HWEsvOXJybGFkR3pZazBsd01JQmY3Zjh3dDFN?=
 =?utf-8?B?MWRKRTdOenRFRHN0aWE0TitLR1AySFZ1NWQ5SEFaQkhrMTV6QmdMK2V2cXc3?=
 =?utf-8?B?UmVKQXNYbEZubWtZWXY3MVJnUWd1b281SzA1Q1lqODZIVXhML0F0WEpreGhB?=
 =?utf-8?B?d1psQVNpTnhOTzRlMEg3SVcwWWdrNThFK0FJenhjUFVtUmNaSjZoRVF6VnlT?=
 =?utf-8?B?MlVrMUtMdC9jbFJqZlZOWTRmT2JHSmdyQmdKdWZCdzZMNnp3MlVGd2kzaFlU?=
 =?utf-8?B?c3pNRjRjR1NYQTB3NTZ5K08yaGc2OE41OWNoSkRGdjVCMGNGTmJuTVhMUmpY?=
 =?utf-8?B?VW5CQlVUdTdDYVZTbTRuK05hRkdNUzlaRDJmVWtCLy9SK1BLUnFCMnRjbUt2?=
 =?utf-8?B?cXdoVEVGcDVsdGx4ZHZVdkx4OWwzYm9ka3BuQlNuUHdVVllOZGFTaGtzdi91?=
 =?utf-8?B?alVmNlM0Y3M4amJjeUlsUFpjajZxZlY0dFBTOERJQmJKb1ZSakJSQXF3MmVL?=
 =?utf-8?B?NEJMY2tlNVpDU3lXRnA4Yk4vWXJUSm1rQ1ZjODQ5bkFrZCs1WS9GUTUxQmVw?=
 =?utf-8?B?L2xUNWZsR05yUVk1ZUUzN2wwcTNuNlRNZWdhUG1YaHdFeGNWTWRaa3JrNlA4?=
 =?utf-8?B?bEcvZm5ZTEhvZ1E1MHg1czl2ME5PY1ZEQ2RuS2lIN2tzWGtxMUpGaWxJSE81?=
 =?utf-8?B?TjZRVTlZVy9aZ1ZJTllmcWVPNTVTbEY2dFNxQkU5RVJ4bjBZeVBOTEdoWktl?=
 =?utf-8?B?Z1FPbUdUcXVaRnp4SkVmbVp1MDQrVWlWNXN2K3FRSlFvenF2YVR6Y2F3eUl1?=
 =?utf-8?B?aTZsU1dacXVzY2JHMTJ2UysxUHpoajNJNmhkRnVraXR4ZUJKeVVFL2Zid3lS?=
 =?utf-8?B?cE9jRXYxbFU1YmQwUE9yOEJSVXNhSi84bUlYeVQyRkVZTC9za0g0RThsb2g0?=
 =?utf-8?B?STh3Um1DeHhNU3BORCtDU1VXcVJKUW9aOEZCTGc3ekNHd3Fzc1Zrb3krR2Zq?=
 =?utf-8?B?Y0lyYy8vd2lhQWtXNFB6ZVlPRlRtVE1NTE1vYmxZb1gxVStSbkM0V3M4UzRV?=
 =?utf-8?B?L3JkbEZFZWN4VzVnYlkzaFFXSUMvRWdFRVRlYlFDUmJzWm1mNWx3NTdldUN3?=
 =?utf-8?B?QnBoekFicVVXQzFoTFlpbWR5bjVBbHh0TGp6SjM0WVN5QStrb2V3akZUOW5n?=
 =?utf-8?B?VTFWR0tmUzBORlAwVzJHaGo3aDB6WncydlBpMXVkc21GL21vNmlVQTZZZHRE?=
 =?utf-8?B?UWlPMWpzN3BqbTgrSk55MUd1ZzgrK3J3ZTVyTjEwV0xTMVgzSm1HdWhUeDZC?=
 =?utf-8?B?anZ2bXE2NDR0QVUrRzdoWkxnVXluUm1PNlpuREFTTXg4cDVDZXhrMkFWS21I?=
 =?utf-8?B?OFhacUIrOTY1RXcwTGt3a0ZXYytqYm9lVFpyWTRhK0RLZzNzVzdUYnNjTzB5?=
 =?utf-8?B?Vy9YUVkwRllKR2VCRFpMdFhrUjlCSmJXRmo3ZThHMENlSzIrZS9Bb0lNMCt1?=
 =?utf-8?B?dHBEQlRPWHlVYzhjTHlOcnBsdE10Y2dlNnNJYm1iMHY2TWV5V2x2aUhHNFZX?=
 =?utf-8?B?VGVESGdRKzA4dWIvRmNVcGlZQVZ5SGVPaklCVENFVXoyVFd0TXpxZndsdEwz?=
 =?utf-8?B?d1Y3bEEwenhIdXBZMSswNVh5cE9PRWlIcXV3NTdKSjJ4VWlFKzRLRjhucWlw?=
 =?utf-8?Q?mRI/HFH8mgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5509.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzR6N3ErRGdCRklBWTBHNWxPdkhjZENmZkVCbGxGOTFGeFVBaCtXaDNzNHla?=
 =?utf-8?B?YzBSSjRXZ2t0UXRPeUlzenlrTlR0VWswOEErdE5TYUhhZno2VU1hUFZMZzEw?=
 =?utf-8?B?ZkpmNE9LTGNscFNQSDc5YTJYQU5YdWZLY3VVeGh2OEZDWUM2QUoxTGV5UWtX?=
 =?utf-8?B?VDlBbUVZZFY2S2JodVRzRUJTeXFzK0RCOE1ENWpqK1JHQjJTREs2d0ptSjJI?=
 =?utf-8?B?NlVMYmsrZG5mZG5jQzJqSnA5K2xJQ3VPS2p5RTB0T28zUDJ0L3Vab094NElL?=
 =?utf-8?B?U3dIVmIzbytGN2dRdUpPOUJCREpoN0xpdE0vWUo4WXRWMDY0Nys0UkNDSTJO?=
 =?utf-8?B?Myt3ZXpDbGN4NC9iS3Bzc1gvenpwRmZ2R1BSeVpVUW5yQnYzZzVpcEFNTTcr?=
 =?utf-8?B?ZVpIWWNmVFNaT0k5L1NqQ3NwdlFmTGpYcFNndnV4SUVGSzBnTHZXdldYTVE2?=
 =?utf-8?B?NHFQNW1GL1NBNk5zNnVtMHl2dkVVbnJsSW92Y000ZFJ3amJJNGR5Q3REOGFr?=
 =?utf-8?B?d0dlNjZiZGRVajVIR2ZyQU5wc1lkOXBHL2VZNVUxcXpxa2tab2RudTlNR1U0?=
 =?utf-8?B?ZzNFNVZRVkZxK3lIcldSNlFVZlVaZDZyOTNFY1JBd3d5UStZNkNtWEtpcWVo?=
 =?utf-8?B?aEQvT2d2VnhEdnpFcjQxNlMySHdvTjRHMCtFbTV5cEhnZStZRCtuUFRyRlg0?=
 =?utf-8?B?VFFKeWJMVUtYL2Z1WXpvRWVzRHF5M1RCcVV0MCtNcGU3OWEzQTNkWVF6SG91?=
 =?utf-8?B?bytXMW04Vkt3Slk2a05BTEZRamFEVUUvbmJ5Z2pjVlJ1RDN4UThtbTU2Y1Rv?=
 =?utf-8?B?RlA3bzBvMExuNVRkS2o3VnVhSDFKNHpxUjNRMnpEcldTT2JFYmFFcmg0blhu?=
 =?utf-8?B?aDY2NmhYWGNyVG14REYrV1ErUjN5U3E1TFRZamdHKzA2YWxCYzVBUjhKZjUr?=
 =?utf-8?B?Ukg4TGJ0eDU4Y0tCQi8zOVlJWlZWRVRkN1RUSW95TnFKQi9RWWdMNG5QM090?=
 =?utf-8?B?Ty9sUTFHdHZvcDZObitLbnp3UUh3eGhCZTZXdytjYkJlbXFpQXdmczV0amZO?=
 =?utf-8?B?YlZPbUc3VjFHQkgzdFRKMDNMNlAwdVZqYW1RNFBwUnBVa1BxNjN6dGcxR1Y0?=
 =?utf-8?B?emFhMDdDd2pSNVBJcStmSG5RWFl3QitMUHlxTVZwbkJmV1dPRlNHY3BnMEZv?=
 =?utf-8?B?TDhOQnBUMndNRjNIc09Ubis4WVBIR0VObXRyVW1TbnlCOElLMFFCR05HVnh0?=
 =?utf-8?B?cXlZdVpZN2NhZlRTeTludldSQUh0ek56c1hkTDN5RnFUdGJlSVFZdExWMmxi?=
 =?utf-8?B?ZWhNaS9qdExiVXE3c1QxSzlLTjJtdFFZR2FoWVorU2M5aUp1OFpHZ3dRSzZh?=
 =?utf-8?B?QkVFanZGQ0xwZDI4dFFqOTlSZ0pqNVV4SVQ4WFRUZkxlUG8yT0RWNUdOOEZT?=
 =?utf-8?B?cXo2UThJTUNHK2pEWnNqZlVMQTZzYi9XbTRBaCtvSVFHTmtUMys4eTMvbllB?=
 =?utf-8?B?V01KVzJNaG1rTEorbEZJMVE2K3RIVFRMUTFNalZHWk9sRXJJNVZHWVZNRG1v?=
 =?utf-8?B?eGpucmRvbEZxZHpJSHczZWlEUjNMUlJFMmo0aElac3hVVkVPSlJVUkdRQjM4?=
 =?utf-8?B?Vlh4R05abjU0Z0JzNnlXKytOMjNaMjJIdWdNUFE4SmN0Z01ZcVdZa0J2Y3dL?=
 =?utf-8?B?OU1nTnU4OGx0WStPTnRiMHRGdDE3T3duS25hcmZRSk9GL2tjdyt5MjRlVmxT?=
 =?utf-8?B?YlpFZlpTUkRodlNGcU56ckJ2bTVOQzhBWGZ4ZEZtb2ZVMzMrRnNiUDhKM0FL?=
 =?utf-8?B?RkVXNTZzbnExNG5kSHNvenozSjRKMmx4dWQ3bmpmaEZzZDFDOHhRV2pkZk9z?=
 =?utf-8?B?YjdtTW41YkRxUHFVbUJxZ1U4S0MyQVRFTjlCOW0xSkt2MUk3TElXM3ZpV21j?=
 =?utf-8?B?bEJmbVE3K1ZDQnhLMTY1WERiZks4ZmdxZE9ZTkF3V1V0aTg5QnFMMy9xV2ND?=
 =?utf-8?B?dkMxaFFPZnZHem1wc3NqV09Qd1FEL3lyY0hPUkNqWmdsdXJsVWpRUXN4ejdH?=
 =?utf-8?B?TkxpNGtIUzRMazdBUUxhM1RBV01OTEVrcFRBTXFTQlhLMFZSU1Z2U3FIQUhj?=
 =?utf-8?Q?8QaDupWUW7+sIazsxbpu8KyGk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6a26jVannKWlRgLFHwyibobNKN/W2CmoT7aDMVnInPKIU2Wl0mVVNzZuog1MZVpS3oBRigCz2Qdhsn2jkntV8c700w4TEpBTI6WLFMnoY34dHeDJfZ/3IAdgrCrzMLO+xqKNlb6G0361vySzvEtTGgB7ZgZcfELcOz8NM+CpJEUppedzTvexEWR9sRYkhiKmqo9ut6sRatO8kSwFCd6DhxkMjawp/zxMYUj7C/cPglevQ8ZtG79OhoABuBFf+PW3S4Aa+MpaX8fdktbg507tycoWD9MeQwoAbZEZFHc236ZXx2/uhGxt5lOfzyiAEB25Yq93xcogzs4aGj+DvKlWxD/Y1Uy5DY2cCfkN+386Vjn/zUZQwHfN0D4ncvAYWqRzjadKuQpctGkG9Gz3Z2ZhEZX3H+707cAthTXhpe9X4IF+JAGefaZOYrfOedmV2wKZUI+okGqHoRYJVSbPfbbg4v7Upyxmvilzbyk+6Maquust9OkQw4lXUELZpqGG196FleYbcz3qcxtMAhG9kCiuim/8kMnDgKJikl/VFArrSP9BFQNYEHJSFKt9ddjqxZ3oI/SMkCQXGQ2d4UIHExW+e/kaFUQJBDUgTLXr7E98J8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed05856b-08c4-46d3-7263-08ddebabc78d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5509.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:08:38.5929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7opyzNYMNWq1umCpkcbZE/6TDq0lDXrJxzRysszjSm27G2yOgDsIRowbmUIW2xmAB93wivKr0h/eTFWvr/KGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040120
X-Proofpoint-ORIG-GUID: 1t42mz8nlhbXz9DwpBCOOAqOdSCg_auY
X-Proofpoint-GUID: 1t42mz8nlhbXz9DwpBCOOAqOdSCg_auY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDEwNCBTYWx0ZWRfX7YWzPPrRNp8f
 1VivV5Bu0v3aGmEdTABj7V4zXkCWwaS1yMzkZGLCosnEzHtJu3uJJv4yMHosK1D4EdLbzwwAw+e
 PrbxrGya6D47LTMspxtORUfqjmUKdSz7xT+uv777oAWD4mtjvd4eJgNvdcOd0n5qLi8ojQIzIYe
 vOFmtAA/aNXB8jzLVdYIU/1eKJ0r5ksBIdKE0WOJU7ReyYN8MBhXSEUqG16M6DDMVN35OUNwfQ2
 KULCRl+JutxukqtJeb1kFvDbtWx3IVXK5UzqfGebem/X8W9+bY9jdQlFiIXG416cfaWXOVHaNf2
 afV78YASkKAUVrolVW8sF54edeQ02rVJ/JtBe9nOriXJmGEHPcB0nomkzC480W26PdJ/psa+w4l
 B2HFSxAxss0uDMi9FA8avarVQR7ovw==
X-Authority-Analysis: v=2.4 cv=UPHdHDfy c=1 sm=1 tr=0 ts=68b9814b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=hV2IK7sstZAXtw1ccqcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069

On 9/3/25 4:44 PM, Alexei Starovoitov wrote:
> On Wed, Sep 3, 2025 at 1:52 PM Tom Hromatka <tom.hromatka@oracle.com> wrote:
>>
>> On 9/3/25 2:45 PM, Alexei Starovoitov wrote:
>>> On Wed, Sep 3, 2025 at 1:38 PM Tom Hromatka <tom.hromatka@oracle.com> wrote:
>>>>
>>>> +
>>>> +       spin_lock_irq(&current->sighand->siglock);
>>>> +       spin_lock_irq(&task->sighand->siglock);
>>>> +
>>>> +       if (atomic_read(&task->seccomp.filter_count) == 0) {
>>>> +               spin_unlock_irq(&task->sighand->siglock);
>>>> +               spin_unlock_irq(&current->sighand->siglock);
>>>
>>> did you copy this pattern from somewhere ?
>>> It's obviously buggy.
>>
>> I tried to mimic the logic in copy_seccomp() in kernel/fork.c,
>> but as you point out, I probably messed it up :).
>>
>> Do you have recommendations for a better design pattern?
> 
> Several things look wrong here.

Thanks so much for weighing in.

> Double _irq() is one obvious bug.

Makes sense.  I'll look through the kernel code to see if I can
find another place where two task structs are being locked at
the same time.  I've never had to do that before.

> Grabbing spin_lock to do atomic_read() is another oddity.

That would indeed be strange.

The spin_lock is needed to ensure that the source and target's
seccomp filters don't change out from underneath me.  Once I
read the target's seccomp filter count, I don't want another
thread to make any changes before I've updated the target's
filters.

Thanks!

Tom

