Return-Path: <linux-kselftest+bounces-28879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1549EA5EB28
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 06:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A71B179414
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 05:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790711F940A;
	Thu, 13 Mar 2025 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m2o4HCmh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VsLGLevo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DB2AE77;
	Thu, 13 Mar 2025 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843795; cv=fail; b=JuPDIKpKyL+bVz+OupRKjybUGwZKkbWNHDjNTUXee5k9psbsVWV4K9HZB3oqEeuxaEB8jdfJPVOqo9+/k/wVXkOisaBFqqK7EHQx1570u0yqnFIIz/UL3DssygkrtqfmHQRWr+zYjIDbzjYrO2KsyKyCsJJARdkWP8S/ID/43D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843795; c=relaxed/simple;
	bh=HErcTLeO3gPqtYnytFiQkIm+lzZ17oz1eHpEK3Pn7sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OK+u553nB+IIfYf75dwtTTr7+lwnx/czCSopXoosOYxOaqgRssay5dT4Maby7dWYwwUAKN/nUQshW/7gWSrIXaPbai+x6rwyrsH+saOVWkhWrJfo+gE9f5Rf+KpTVigpGVN4we64JlvZX+fXl1iC+BdpRjlOXf5wDiQxbF8tATo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m2o4HCmh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VsLGLevo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3uNWb013595;
	Thu, 13 Mar 2025 05:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=B8PZpg+A+NzDlzinRnSQQCTu61Chm1W37C5Ooix0eok=; b=
	m2o4HCmhuUFIzIFs7ej7Z39+4KugnL2fdDWZGJSSeUuX53glUZGhKQeVMiQB5NG9
	xY7IeXJN2LpMsTLABqFh0ohXhPkTp4yiTfptVae9ABpXDDg8TbejUbHiZ42Lz9S8
	G0NOCZ9Vq827wrhbMV6fK5A8HWil7pUqAyitHQhYN2BSRMmgFE/JAEDj9HKKvh1H
	gRHFlpIw+TKvdpALXFo6g95FH2CrT+wYgenf5gOC+SCpk1qLoVBO2lWiuFGG3TE5
	lMC8BHDdanTy1HgvP27MSX04Yyy8LjdjV1omL36OcYJBxFa9+EoPTr0nzExlj2qU
	ORLQQdDF4GZL+Q0N8rKLog==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4due33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 05:29:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D4ZQMN003845;
	Thu, 13 Mar 2025 05:29:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn1p26b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 05:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emgs5ubBxdHkVfpZY1P8I8LjqrfnORymmr1mtrD3nBvRDhxawBvNtvPZR/nkVd7mGbCCPo0QEbo5j28TU95WRH4/FYNHNv47Y2psCuE/W1OJBwN06dA5kpS6yVK8VRrNOsdp6t9pTlvCWkZxO9vgA+EF3hii9zXQbazHpkX95AWMkIq7i+0h6RL6vacIlyGoximRLYJ8equnUBNF0kqG0p1jfMAfqWjMrJVjzaijHTPejWh+XmDyA8rNztF97LMaIJ6CTHzwvYjQG+SBAkmufeQRrYuarpZHC/Ru4Nn0ngHUkNLMs3D99rUq3W04RkZedblWTRoIZ2XwpI7qVWsJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8PZpg+A+NzDlzinRnSQQCTu61Chm1W37C5Ooix0eok=;
 b=qrCbuITilO+s0Cx78YZMipF3W9I8khV9d5+n+jbotImoYHCtnX8kOvniQXwr+iLgomjuGdup2JuY5waVMewYYpJZrN8thPpzWWvSAvKaYhEU7GnjqjHcq5ms9jwBEjsDrL/Lsx+ip0k+pwkgfwZmjp1OB5g+/v65iqNbbTa0R24pbZ/CzXmBIz6/Wy46IQjqNt2J+qdQ43WBZQH/i6BCaNMvhKP3eps/ya4tYcyVTV1K92FHl+egciXTK6L8dZpmIMr547n4CWt7fe3lT1xEFFrXMvL8XBMfjYUtwdYTzZKSQsrG1TvvXdXyLAtCOFNmFcHF9e4sIlusHBO8xhCtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8PZpg+A+NzDlzinRnSQQCTu61Chm1W37C5Ooix0eok=;
 b=VsLGLevoY+Pbg0ehcRf0Kb03wJz5ITCC6dnAK8j75kilkOV/I/fMyPnrVg+12rfTaotkO6WjjHuTTdg1UpPUSqNdxmYzDNPCScGFCgIAAhCRtx0sGUskSJSR1FcLLbhLXAIAPYOvT1kQFstf+u3FhDgHS3Ji90+lqQF3Bvu3iQo=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB5561.namprd10.prod.outlook.com (2603:10b6:510:f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 05:29:33 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 13 Mar 2025
 05:29:33 +0000
Date: Thu, 13 Mar 2025 05:29:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, broonie@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, pedro.falcato@gmail.com, rdunlap@infradead.org,
        jannh@google.com
Subject: Re: [RFC PATCH v1 2/2] mseal: allow noop mprotect
Message-ID: <79b1b6bf-e916-45d4-b20a-0f9041ca36bf@lucifer.local>
References: <20250312002117.2556240-1-jeffxu@google.com>
 <20250312002117.2556240-3-jeffxu@google.com>
 <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local>
 <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
 <9b3a3ac6-a947-4be2-98b3-c35c195d87ab@lucifer.local>
 <202503120931.3BD7A36445@keescook>
 <CABi2SkUs3bXB2jw+1CUQPtWfZ6-kZDunQweOSSw6j_8JALUfAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUs3bXB2jw+1CUQPtWfZ6-kZDunQweOSSw6j_8JALUfAQ@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: 372dcd07-54b0-4c68-1b7d-08dd61f00975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGpJMHcydHpGbEJSSFptbHd5U2tJRmxBaVFkY2phdmcvamlSWDYyZDluZFRw?=
 =?utf-8?B?UVBlNHVTMURKZ0FvcmM0cEpCVFlQYVJqaWNkZVV3SnFCRm01dWE5WEFsYTZE?=
 =?utf-8?B?TVlFMEp0dFAyODVUbEpXSTN4T0NVSklQeG9vSlRGaFh0cmJpR0JqVlhuTVpC?=
 =?utf-8?B?M21PZ3pDZFdQeHlXSGd3aUh1Ym83WGFPaExrdVg2bFlzVzRlRE9rQjJUWTdh?=
 =?utf-8?B?NTdRMWdlZkl0cjUycks2SG1uUnlUNFVSS1NlUFFCYS96WXdtQ0YwNU4xTEFa?=
 =?utf-8?B?K0t2WmY5NlBLUmNOejdmd2I2VGNXUjZjbFNqQUp0S29GNWN5aEhWR2ptMGww?=
 =?utf-8?B?c3ExdzRpWUx4TThBdTBZbktOYVd5TE9pOFU4U3Z6VGZUZlY1ZVVyNWVXT0RU?=
 =?utf-8?B?OGJKbTNqT3U1RWorUForWXdGY3pJZ0RFSUZpeFlJcmU2QUNSV3J6MVpmcFI3?=
 =?utf-8?B?Mzc5d1RZZ0NmUEZlVGtic1R1T1V6WkpWVlFlY0txVUFDTE9RcGFOVHhwaDI4?=
 =?utf-8?B?R2dyZkViOFJaUXlhemQyaXZTSG1vbkl3M240c2FpTE9pV0ExMEphOTU2VE5L?=
 =?utf-8?B?U092OURKZlFBeXg5SFBmbE8vVHFXbXJZVGZZUU9sYWNnVTFabGE5T3hxOXJi?=
 =?utf-8?B?QXgzNWtpWFFmd1NwMi9tVTlBeisxUXZyT0VFUmtCNDlMMnR1UWFFZTBKZEhE?=
 =?utf-8?B?YVZBNFVJbDQzdVhLbitBUzhXczViMjlKZnliL2dIT1lyR3dOR09SSERzOG1L?=
 =?utf-8?B?anYvNVd1VE5KanVhT0ZGamZQZWdJVU5JK2JqaDc3WFRJbHY5S3pEVlVxcVd5?=
 =?utf-8?B?Yi9DSzBjMmliWlpnazh1Y0JEOThVbXpjV0c5YXFVWHd6N25XVnBHTmtuWG0x?=
 =?utf-8?B?bEVRRTZ4aURscThkeWRoQ1JzZStlRzBKV3FKNUw1dHpxeWlxQ2JIMXVMWi85?=
 =?utf-8?B?Tjl1bnJ1Vy9XZlRvY3QxditPVHdrTUZTcVd3bUFlRTRNdFdwM0lNLzNKSy9Z?=
 =?utf-8?B?TWxvc1hWNDBqZStSSHk2dHYxLzVmc3VpRlhwUXdoWlNHRkpwNmErbk42RmFY?=
 =?utf-8?B?S2xLUHU2OVFLcC94TjJkTFNvam9lV1NGQzlYMDQyYjNKbDBqd3Z6WUhERlNP?=
 =?utf-8?B?ODBHNk1TZHNPTHF5QWNoMUJkdDIxdGZJWjlWMXh2a2lJSjh3SEdoYmk5UnZH?=
 =?utf-8?B?WnBKcTdDMHZKc1FmQmhjelN6UHBsR0E2S2tkc1R4ZjQvWnE4cnFNQXZDcnhm?=
 =?utf-8?B?bGRGRFdFVEpoSWlaMXJrVDE2amNoam1VNVdWb2hnZmxURWl4SWorai9Tb2JE?=
 =?utf-8?B?blFTa3VMVlBjeXY5WGc0cU1OYk1hQnNKL2VBUzN2ajdXa2EwZ1NBR2JTbUV5?=
 =?utf-8?B?ZitpWDRNc0loOERYUkJyTUxDT1ZtRW5DS09CaGY3NndKYXBHaHpQcWE3UUQ2?=
 =?utf-8?B?UTR4YVMzWmtnTXgvUTNlV2hEcnI5bDZRejN0bzhrTi9zVE1ncHV5YXQxVmF1?=
 =?utf-8?B?ZmZDRjY5a2JoYnV0YXNrcllSdnhxUmk3bU5ndXJ5bVY2Q0tFUEVjblVjUGFm?=
 =?utf-8?B?Q2ljQUxmMmVSNXVaL3RZUkdOMTNNd2dnWHBOUkV6TitUdTF0TU0rUmFiODky?=
 =?utf-8?B?QVJVRnJXWFEvTk9FS0pmNjZMUlFGZjR1OE1HMlhqM1Z4NUgvUWtTUkd3VkVn?=
 =?utf-8?B?QWxmM2xHNzgrcmhNTlNlaGJjZDVqUzB5U0phTHlqVUxrUGFFeTZYTXNjam9H?=
 =?utf-8?B?RmZEWUROK3lDZTNpbFdmaitxcEhRZWdCU2RPN3dJNjlPei8xMXJMaWh0dEFX?=
 =?utf-8?B?L25JdGNPVjFTZnQ5b2tSc1c4dGxwckl4bUM1bjB1QjZuYW8reEMzT0ZYQkJr?=
 =?utf-8?Q?II9JX9lgCedmH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3RqWHR0QmpTYXVEZVRkbTExOUUvdFQ2ZWhmb3ZQdmZvUFIwRWEyOTlreW9l?=
 =?utf-8?B?VWliYUxWY1U0ZHVjV2ZyeFptOEMya3NueHd4SW5WbUkvNXM2TFBBeWgvTmM4?=
 =?utf-8?B?VjgrTmhuSjRYLzNmZ1JXNjlBbmJvdk81WFRWY1hmaEpWdmJ1RHU3Z2tVUG9M?=
 =?utf-8?B?N2Z4aU5GQjRKNnpoOHpCbTk1bE9WbGZqVHJzQStPazEzR3VOdmJxelcxZmQy?=
 =?utf-8?B?MXhaSDF4TnI3aHdFNDVGVi9zOVlTL0FoblFZRWozYUIxVmNIdStsVkpDZHZO?=
 =?utf-8?B?c3BhVHNPZ1RvUmgrNm5aVzJldjNYRWx2OTR2RFNzRk9JaklYUS9IanB3cGw4?=
 =?utf-8?B?VDFmR21ESnQ4SUU0eWk1dXozcWg3eU1ycS9Eb1d2bDBYUGxpR1ZiWlY1NVNK?=
 =?utf-8?B?b1hlMmtFUTl2OUF1TndqSmJYSUpKVW5ZenZ6cXltK2FNeHVoekd2TmEzbTZB?=
 =?utf-8?B?dEdHZDdnWEtNSlo5MjAvdDB0K1FXTzY1L253OURIbkhVSnM3dVUrU2pxc0tT?=
 =?utf-8?B?SXRTSWNaVWVqZkdIb25tWWhhbnAwWnVnTWJhUml0QmJxSm9OTXhNeW01dkQz?=
 =?utf-8?B?SUYrT2ZuVm1uR3N1NVAxTTRnb045cmhZc0ZUcGZsZFJSSzdIWGc1eDJvT1JH?=
 =?utf-8?B?cmVBbEdQNVpLUG9aajFkeVZuSG5mTmdwTzUxTWg2clFYR2QrRHhVU0taRTdz?=
 =?utf-8?B?dWlSSU1DNUZ2aXdFMGJleXJQcUpnL3NVQzBlNVEzd0c3YlFPUTFLSmZ3WkFM?=
 =?utf-8?B?VGt4Um9uZ08vU3ZlQm1lQk8xcFkwOWcvNmxDckhTWE9VSlNCblhzTDlteFZF?=
 =?utf-8?B?bURGcFNLaUJ1M0dncVFFcmhDRTFPa25KeTBaNHlJVmR0Ym1oUFJwTncyMkJI?=
 =?utf-8?B?dmxCckN0NlpEK2QrR2ZCWlBWWisxWkV1TVFRRzRiRkgzSmJucVp5eUhseXlo?=
 =?utf-8?B?MldQSFFISVBlSzRjV3dET3ZlcGp0dDJacjF2RXBuMW1ZSFZjZ1FvMGc4WTY2?=
 =?utf-8?B?ZythTUx5c2RSZzY2bm00ZDVCbFJ6MFpHOTI3OWhSQ05NUXlCVUpSSVBqQUto?=
 =?utf-8?B?V0ZHcmRJS1o5dDBhTzIyYVVSdjhxNHVQQkR3UUFVYmlVV2pMbFRJUHRJZkc1?=
 =?utf-8?B?SHhRdTFwSWwzeHBXQWxTMmYvME5vZndjbEtYK0dFL2VIUEpTRjdOS051SWVa?=
 =?utf-8?B?azBOMnp0VUJOQVdVRFRaUlNraTh5OFBJa2ovS2MzWVRwcXB3UFZxTjNTSG1L?=
 =?utf-8?B?T0djYnJqMDJPaTdSOHNZUzYwS3V3VTFTcGI5UFpmMnlibVlQVlBOM05qbVJB?=
 =?utf-8?B?Y2FreExFYVpibC9jUGtFb3U3TGlPNUFMU1pYVFZ6MVZ0QUM5aUJEVlhwdTZO?=
 =?utf-8?B?S1FZTUg2RHBzWHRreWJ0TmtTZWhDaG9tbkdMeHYxUU04VlBmWXlMbkM1Rk1r?=
 =?utf-8?B?ZnpWSlZ1b1RzREwycHdUVytQT01QbzZRM0NTV1UyNGY0N3k2cmJRbFNwc3BJ?=
 =?utf-8?B?Z2VjVFl2RGxrK09xZ1dCMnlXSUNUd2FZN2JQWVRhQVNMOXdXa0ZLWW5pSGxF?=
 =?utf-8?B?eHVoTUk4QXlvdlAzbDIybFp0dmcvbzVRcExiRkZubTJjMVEvSXJnZlpGcmw2?=
 =?utf-8?B?K0U2eVFiUURWTHFaZ3N3S0ttU1BkS1cvdEZMNWlEeG1wc1VSUDBxeGJoZlZj?=
 =?utf-8?B?MXRmUjZEcjJVZnRQSHYwTkg1RjFmcFB5VktyLy83NGdxNktKTXBwZjZFWUo5?=
 =?utf-8?B?VEFIT0o0Z0hUQkxvUFJydWdPeE5hZFhMMmxROGYvWGoxVkkzZnlpQjVQRFIx?=
 =?utf-8?B?MmoyTjd4OUJNY01zb1BCV1pwaEFBanhPVGxHVXEvdkNnUlo2S0hlQmFrUlda?=
 =?utf-8?B?ajNmL0FXdHFOczMyM2l5dzg3cEVZV3FXK3hOYkovNjM3OWkydXFkWFpzRTlN?=
 =?utf-8?B?ejhIaStySFZCRWVieTlDYkNPZW9sSHM0N21SU2tVREFpQ0k3NEE3Q3ZTUENF?=
 =?utf-8?B?aVp2YVhJUU1TbzlPb1p6dmlwQjRJVXpjdUVla0h6bWhqeWdTcC9WVzhFeVpM?=
 =?utf-8?B?d3FDNlVGbWJLdnZVSUxDWXByMm5KRWljU1lGYW5RYThkL1VENGpkdDB6Q2VN?=
 =?utf-8?B?clZWUnhGYjJyVUtuSDVkeENPSEZWS0x0VnpwMjJqdTczMWNjcEh2WmVTZ3lV?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	itvl/bF764BvxyHD0SIaoZPC17/yac54BUy1fVgza5XsuNPfk9VezbfYD1ZzMlsU3g5IHJodaVjvh09EdTxS4hgerHBhmjCfcFAnpoYzvim+bGXAGyfBhturYk7gPCHiHCn+MdUV66c7P/BaxSuMXk4RpSMvncLJxXXIAaKh03FZl/NlLsTFAavfD4DTgavz28AnpulxDrNTwugW6kjDOvXWPeTfKzw9tK9VbkEzenDZ+w1wKGJH+OYxioTH1Eg9E9oz6fUpvMyehOMeuKa1O1ZWAOqaKvpnVf1YGQeTL/IfibIhOvTl7RIg7c29HrQQvPtgNc8P1RObd+81hwdlsqlKMs/I+sMh4clBCb1XrxNys4v1XEACaCwOTXAScq1VrF4ORU+Mv0e+UV15UpOF51b1QMY9F9/+cemcprkAmTJEfEKzUasHJ/VMHjhaz0IyIuh9IgxmzUg8vbfd2lG/QbRXQI4FcLQ9UhdsdkEwFPCSDMqk5qrv8UQDYI0rtTBinlvqlUe4MpJ9o1Afsd9MKc10R3cZ0pUSZVdYCMWwv4RSJ5UN9xqW7YK6Aop5hkclEzGKnAUaqfrZrX8JEQVqG/taDB84ZnjDQnw3cpYdtI0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372dcd07-54b0-4c68-1b7d-08dd61f00975
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 05:29:33.6720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NEhKtlcnWCvyLCeTbKiUDF8NGCZUkOKb6TWCiV7/RGBHfV9kYoSobmt+bwX/xagMr7L5uLY3qik716xJwV65Ioiw01FP1ONkNuC4Ut3I1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130041
X-Proofpoint-GUID: OR1TPvUYmnYNzmYnp4lsC524gowi_Iqv
X-Proofpoint-ORIG-GUID: OR1TPvUYmnYNzmYnp4lsC524gowi_Iqv

On Wed, Mar 12, 2025 at 04:29:50PM -0700, Jeff Xu wrote:
> On Wed, Mar 12, 2025 at 9:45 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Wed, Mar 12, 2025 at 03:50:40PM +0000, Lorenzo Stoakes wrote:
> > > What about madvise() with MADV_DONTNEED on a r/o VMA that's not faulted in?
> > > That's a no-op right? But it's not permitted.
> >
> Madvise's semantics are about behavior, while mprotect is about
> attributes. To me:  madvise is like "make this VMA do that" while
> mprotect is about "update this VMA's attributes to a new value".
>
> It is more difficult to determine if a behavior is no-op, so I don't
> intend to apply the same no-op concept to madvise().
>
> > Hmm, yes, that's a good example. Thank you!
> >
> > > So now we have an inconsistency between the two calls.
> >
> > Yeah, I see your concern now.
> >
> > > I don't know what you mean by 'ergonomic'?
> >
> > I was thinking about idempotent-ness. Like, some library setting up a
> > memory region, it can't call its setup routine twice if the second time
> > through (where no changes are made) it gets rejected. But I think this
> > is likely just a userspace problem: check for the VMAs before blindly
> > trying to do it again. (This is strictly an imagined situation.)
> >
> Yes.
>
>  We also don't have a system call to query the "mprotect" attributes,
> so it is understandable that userspace can rely on idempotents of the
> mprotect.

PROCMAP_QUERY ioctl, /proc/$pid/pagemap :) I mean hey - these are somewhat
diagnostic-y, racey, un-fun interfaces that we'd rather you not use in
anger when mapping stuff - but they do at least exist :)

(an aside, been playing with PROCMAP_QUERY recently and very cool - we plan
to make this useable under RCU lock rather than mmap lock which will make
it _even more_ useful in future... exciting times :)

It's possible, but it seems that it would be relying upon it purely because
in some cases it would be modifying the mapping, right?

It strikes me as very unlikely that an application would be looking to
modify the attributes of a series of VMAs including ones that have a
security feature enabled which says 'until this is unmapped do not modify
the attributes of this VMA'.

Yes it's _theoretically_ possible but that'd be quite silly no?

>
> > > My reply seemed to get truncated at the end here :) So let me ask again -
> > > do you have a practical case in mind for this?
> >
> I noticed there were idempotent mprotects last year while working on
> applying mseal on stack in Android. I assume this might not be the
> only instance since mprotect gets called a lot in general.
>
> Blocking this won't improve security, it could actually hinder the
> adoption of mseal, i.e. force apps to make code change.

Thanks for the explanation it's appreciated!

But I feel the drawbacks I mentioned previously and elucidated upon in my
reply to Kees outweigh this theoretical concern.

If we encounter actual real-world instances of this we can reconsider,
presuming we are ok with the asymmetry vs. other seal-protected calls. We
have this shipped with a uAPI already like this so there's no rush.

>
> -Jeff
>
> > Sorry, I didn't have any reply to that part, so I left it off. If Jeff
> > has a specific case in mind, I'll let him answer that part. :)
> >
> > -Kees
> >
> > --
> > Kees Cook

Cheers, Lorenzo

