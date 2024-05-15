Return-Path: <linux-kselftest+bounces-10229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A98C5FF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D911F270AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 04:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8EE3C068;
	Wed, 15 May 2024 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EZ7FF3wn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E/nxZQ6/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF893BBF0;
	Wed, 15 May 2024 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748870; cv=fail; b=q/1ONRT6Hrlw/XF2gkym0Lrdzt6Thx/sNrkp0PROj+er6VrRDP5b5MMjVOR72sP0RHfLM7tBuXE2V+HYVnGZ+Gfy+6JnfW2UY8xfWfPYbSyGC5HqaVK7h1rDp0zG/d2C9quk/HiK2P36jlS1RGtd8euHZojPj1UhMP8Kev1MMnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748870; c=relaxed/simple;
	bh=6ndIeXIkT/QsZ+1D43FCdgCe1UfDiLDIX3PBXSs9x+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BfA7WoryZeMz4X4HqdjcK1sqRtFhE1nBVE9wNreWOzPtWYkBKLRBw0RhMCdQu/QAYkCVPEVJobMNzfpqqd+1tBr1Ogq32eM9NFJugk1dSyeykj0R70D1MRlWwWiOBRzks0Q4eOa2qh3J1mJDRdlcO5M+t6neYp/HiVUPm0RRzsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EZ7FF3wn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E/nxZQ6/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44F4AIHG025516;
	Wed, 15 May 2024 04:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=1xRaQIt07NgBP3CozfRDkM1e4u4ZYAvLAl6zlZMr9sw=;
 b=EZ7FF3wnHwVKToC6dfod4UA+6gZ7zdCK9r0XpIg2qboLUmcRpXyBH7EcyYNvYM3pIz9r
 nG7HR71OUJKmSODNDCMvtdcH1rfVvAsHfC9F5wBrZRotrXf+eEXDM3g5n3ubwfszzquI
 9zO8K3kNDf3w3eMtYcn1UsPM6dtFjiytlLMeyTZyAyZQutVMlhU8BqBG54tGokn3D2I8
 FfC7k9NdQeMrzRWbxTLlJTC+/KaWIbHiUl33XBFIs6X4PGRg2NNnOP6Yiu4P+80RcS72
 coXGEkzkQAPMpY2DxepqTDhjwcdaF/GEfgj4+TiMUYY2BRYMD+u833+/ni6AlBcClT+z GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y4c8r1pwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 04:54:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44F2IpLD001127;
	Wed, 15 May 2024 04:53:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fsrkg16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 04:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3rZsKgySVLxc6erueoWTYn4W3pDrxYalfEaxt3gkdxeccfGOuskLUZuZG3tOpLa3Cd3786fktfxIA0D6n5YcapUamwtt9KWMIJ1ZryWP7kX9mCOyw5NvflgddpOLkjoiY8IqpRs7LiL1dUVyfdYnGmjMr8EyPh6TD4MhiWxKfxS3Ro2mIyYUPxjHpiliFZYjykJsPvop94jJwQGzPo1PyDMkz4usbIq4fibuMazBu9322AV+7vI9iXZk5cb6RzNAiq16sbncCGBwdqLayErIvDwib/ASgkgdITHDtFtEBbR7SSm1CKwucxvqYx9wTm+LuyO+GAbY4kLp6qLH9gNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xRaQIt07NgBP3CozfRDkM1e4u4ZYAvLAl6zlZMr9sw=;
 b=jFmXk9jmpUDwRFHM9L2Wn2bWz01A/mVuAblT0oo7nRFq3jrzUpLOj/HBrTM8ePCfxdfywu0Eju/ODg/2jE4FnRPKMrud/4dYwRLVN45j/Rap5VEZ1l1xV2VnIIMPxzMUSCUagYkjgVj4WwklpRRc1vwZ9tnpedT23C6VG2Pr6Csxiq86vqbVTeao/p57wQGxXAt2WoMDIdyIpmZkQzia4iLVGy8l/BC0Hi0n5t0BNIqWPBKb2L5UNIV02gA2Wvp8HVWfBdCfbtZDQxZsfCq1ukr4PjQjkpf3JNXyRnn+GCh8/rGjBlKtMig1IJbQHuMuAaZZYpv5kIK90Bu7/KEBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xRaQIt07NgBP3CozfRDkM1e4u4ZYAvLAl6zlZMr9sw=;
 b=E/nxZQ6/yN8JkUDDlL6GI3sozzAXCvno5VQ3EVbeGrSqiB+OZr4lhmIsI170xRtVmlC1RehUxsqiE5/CAVjwTiv3r3bdGkEjjRgWReBkgQiZFDcfkVA29oIupGFa7z9pSeP/nENNWFfHRQ6Y4eR4PzeCSmZs4bbmTZjQJMKMz5Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BL3PR10MB6259.namprd10.prod.outlook.com (2603:10b6:208:38e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 04:53:50 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 04:53:50 +0000
Date: Wed, 15 May 2024 00:53:47 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        gregkh@linuxfoundation.org, usama.anjum@collabora.com,
        surenb@google.com, merimus@google.com, rdunlap@infradead.org,
        jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <6wtyezhn7spm4ehpo7jyi6xy3ywznkztjpzlafodpwj6x4wldx@rjia2otxbcxu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Theo de Raadt <deraadt@openbsd.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
References: <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net>
 <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org>
 <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
 <16982.1715734632@cvs.openbsd.org>
 <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
 <84192.1715737666@cvs.openbsd.org>
 <CAHk-=wj=Yb1r_g=geQe8YDGv-TA-UQBQe6-OVhA8FOGjWKnQmA@mail.gmail.com>
 <75628.1715740958@cvs.openbsd.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75628.1715740958@cvs.openbsd.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CYXPR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:930:d3::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BL3PR10MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9417018a-e42d-418a-136e-08dc749b0301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nm5179Lbio2qkx7Upmuw/GlxIf8HPnreqCHUuCrWwFPCf91c0ivo0G81qNC5?=
 =?us-ascii?Q?mjXGd49qfb0yXD1DGRBX+JHKeAi9QNasiXROy+O55gSiazB0cmtVmNaX7rZL?=
 =?us-ascii?Q?CAPMe6IQjcqBFHzsuELX9zZK2vxJZQE6uxstVVHTmbyizLrqkyoECxLgtoY9?=
 =?us-ascii?Q?B6CQn85SBI5RfhjAMFtKwgs0WUwXswPKMuVaKpS/KcB4U9w3+j+HnOzdH/cR?=
 =?us-ascii?Q?4JDfqcQJsq0hkuOzOQClnHKbTQzWkcoAjzy6IU/MqwD6nuxVuFPvmE67Kb0D?=
 =?us-ascii?Q?gGUUwvU0Cls2UMDisZOX6fVHLvPRvkskeVZwlODt1z4XaL+ffLopVW0hN7Pw?=
 =?us-ascii?Q?DiBFrjsOSkID06pQpbOdWW+eAOqbHrs7Ddc85ts5BZpxDO6nUkE3yO3ij6pa?=
 =?us-ascii?Q?t5ztH9DVsDolhOraUHENl9ZKwVjMrghhDJji9xl50jhe4U0HSZPfH1xTNG+p?=
 =?us-ascii?Q?4tA3BQXYXH4/Ynon5HleUuSq/iYx/k5sFkKURM514Khm4rBLCw4qC7VCU0VU?=
 =?us-ascii?Q?47VMyIX06/70ROhubrJBL8hZs0T64ashDtjbQXRibogSVgfWS73A3Xu+5TVF?=
 =?us-ascii?Q?J+4O0Pf3SkDzlhQdnP7UmkbFHbroB7/UxSqQu+Scnz0uu1aTjayxFXSkYr2/?=
 =?us-ascii?Q?oWvwwHSg2N/bMZCf/jplgjopFDV5K7x9GgT5eAVuE3s0n2twVBNlpW4nL5mS?=
 =?us-ascii?Q?eBof6lTeOrBFS93W9ERR+UGozpDVPmNJwOXziHkAeXR59q2hBg1LiJPO4bY5?=
 =?us-ascii?Q?XEH2qEZ4SO3oZcUgvB05DIwX6MEo3yIVc3DNV2H6duy3jBGBH9OeSUIb5bpw?=
 =?us-ascii?Q?aF25HgAxeV3yeDOdCTUcOHIGTIkAALzt0Z6/qPryhtYvDdRFMBIl9FZga8A6?=
 =?us-ascii?Q?AuNBJygSvgBkvB6wqmBDDcO7mItRB0QcVv5r//++Iazhuj3OZIwNk4VueKqt?=
 =?us-ascii?Q?sU+e6pK90AL9ICZb0yZnvcUi3MhuLfk413XfnwP8QgmHAZxhDRjZVVLU0/xM?=
 =?us-ascii?Q?4oAxpsOV33jQg4AZTjlSca19X/tIPARN49HnpEu0cN9jyH2cRlmScP0ci2j0?=
 =?us-ascii?Q?81hFdxfQw1Pj3YIHdhUxppSGLVpvO1zosdiCnpYGI13W9YcSMN6uNF1efRG2?=
 =?us-ascii?Q?yzrQnEdSg99A1eO20cDgxOuTxoJp2Hd1fhhjAp7tAjyTHYVhFOhRu7rdP1hC?=
 =?us-ascii?Q?mesSyqJOL6Pi+QqRJjTZdRF2qa22BMCtOIWyGYUYb2uc0AirAzAGTrTh4eiE?=
 =?us-ascii?Q?DRoxdSMQ/dFcRFjjnpxX9GABl3s5VIrGl0/EY7pjtA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1jlLKpl+GW1uu/1C43LBgYPTRAN/5CCUPbvDftEItC+xRW5vt/SbQdviLQG+?=
 =?us-ascii?Q?9zbSLkbjKML10rsimUHPQm0bf4brFejkhnSp0QLWeY8IQ3735gJN5tJzJiyZ?=
 =?us-ascii?Q?0/bSQ2XUhpMyCGdsBtOXIh1bQML/ME3Sxr+wz8DSz6y4ShcEOITFiqwdDqPW?=
 =?us-ascii?Q?mhBPRjSgQad1KVnmDZm1IT9FYxeJ2avtYKQyed2QS6tUSCjNwHWlHOXsRCh9?=
 =?us-ascii?Q?EwQ2rZbA5PnOc5warj0YVLEXXfdT0MKoRe3ZafoHfBq4ZzeltNi0RpC9eyfg?=
 =?us-ascii?Q?Iq9wHozaSYQWizvarjPVS4ifawMC9W8GZhK+dCKcqa9d44Vp3mXdr0gOSDZq?=
 =?us-ascii?Q?QkJ2MNrG9Uswuec4pXCF8yWHjZ/tdfQxrzzDgUNto6K0eYJtL6oXor+DB66P?=
 =?us-ascii?Q?dPtZIur7QVLYFKymoHkC15Aj08GUcFEoLezKlAQSmpYWgA5lgAyZUb73GC6Z?=
 =?us-ascii?Q?2hZ5/LaAJao79lB0HgQOuQT1iGCACAxcUGM+6JNIouFUBAL76Cty7bp5u22G?=
 =?us-ascii?Q?4zRAy7ZZ9wAVDAu15HKkfJQa2BsZUwSdXh6z6xaysd3Nkx5QQUf7Dn+fGAtl?=
 =?us-ascii?Q?XvH9uqnrsW4lQdm2LqDUGoCmXa4Sl7VfRjzlUw+6RWUaIrgmChA/ld3XOEGF?=
 =?us-ascii?Q?GRyfxrqsqG0YNbRYHU9sitAuHRyC8/VIpMjFJOfGhmNmxakVtkKSXOfJhp8x?=
 =?us-ascii?Q?zWh4A+KNdvEM5hdgOeYMVeq9EkbSJCQGnso/4XeSMqggP5CgPSgmiuZObgtj?=
 =?us-ascii?Q?JCU56aX59/pT8pIwFs7iS2bq9PaCLvJBYdrrQsC8ngtuR0+A0vfPoLAT4eDy?=
 =?us-ascii?Q?2s490paZWxL2lObX/cYYSO1HdS4I0bj0tMJ9QtB1Uz4O1yE3s+1i8c4RFZF1?=
 =?us-ascii?Q?xdO1oHpontfhLeuvhexfG5t55s5hP0BfhgYKTp1MYTIa94rOw6/CblMvrYOL?=
 =?us-ascii?Q?9Nl1T8RAj+CXWp+3k/E772bPr07Gp+uVRlLWKyBS1GzXq606rfwBz4CVUHm1?=
 =?us-ascii?Q?l9cSaGtrazPbBLMxayhtN398EyKZ3IziZnwAv20sLKUcmOZdiOGr+TN39neX?=
 =?us-ascii?Q?Z0eRVaomw76JNUCenmq9E8dVjJSSpv0NFgX9IsarLW7X+oBIkIJodKhtIRUc?=
 =?us-ascii?Q?4ti/mWobE+bES/0A1MDw5cVlv0syU6oKHT1kCz7VKB2H6YDBxr2Qp+5mWnWy?=
 =?us-ascii?Q?1Qg6d0NrEHlaQ3lYCwjisIZhfOKh2S3VJW/czPLaoXp3MQh6TjUGiqzEwrfl?=
 =?us-ascii?Q?p3Saa5XEak/bdpbYMPwbEpO4dK25XrccwZdvg1Caxci9nTVX7SgCVmNMvXMb?=
 =?us-ascii?Q?ySh/acZGzeY8YZ6hIdieM0B2r4d8TMqDKZPkVdAIySPGF7e4WvR0F2UJGmRk?=
 =?us-ascii?Q?ndaHLzqfhqaONfjB8f9QRUIDDYn7sZod+dRFJQR2KBlJPU5Fu4PEdA/2253+?=
 =?us-ascii?Q?djr1YiQzF9iT5MtfasKRACe4gWW5uNimgDXhPxh3BN8b+jTjrhVRfwlqurNP?=
 =?us-ascii?Q?DiT8GMqOaAJj6sxiDv/V82X9+mE268WnFhGwwIjOVNxxvSXV32dQRHUlX1K1?=
 =?us-ascii?Q?5f84I3dKX0u9qQnmq8x8/BLm555+RPHAToh7/Dfi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/rKO52+sMASAPUuUPzXMtfZ57suMbqxFCSF3HKfTRJ9hjk45gAbclXGcmOZC+S0MaM5heh8atOf3hfOxas0qDFtw3y9qRoN2lfD+6MDGtOJl4WS4W28JbfkHGZy/eA4w8VoV9v7FN4QnyFpB+C/Xh4PjJ++oxcddaEVkSMuZV4F18v+zVE410JszlGWwbtNTI2f/R4XfesSX2t2XWVHJsUw/QXk7oDf6kVs76fSgWyT4Map4k3VqrADNbkzSquYyj+8cTWcVT+LbHPkwZ/TEwMqueiauPznIUOdz0p2jkPnVoicMDgAzvAmZSfj2Jd/UM0zsFinZyNxGkZw+tTLLRC2VI439Gt5hrZC/9a0uY+dnCtCR+xsbZhmeabgz+6jK9jQV11PscOOHQ52QY5EXcwgn8KAl80vUqG+T93beuaJrl9/m1Cv/Tz8vABZu2AChrG5HVsJVI/po0RirtibA4D5IN2NRVKGArTBJqFwgo7fmRcv7hxdkEZgbsc/JNCWbDJD3UdfLR3rRCi7hUzPlDOBH2RfPA2GJdj6lf6Z2id7GURnhaqCh/uBXlYYs84xZCPP7+fGVFota5dS7pM7GDMK56nMuZHX03wxLJuq1vqo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9417018a-e42d-418a-136e-08dc749b0301
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 04:53:50.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsjRDvCY4nMnaGE4lvd/Jns/LxhBgS5+Gj90o1gbku77VpLLHM3BJ93EjgIcHd3hTOdNYvohiYrAU0mS0z5EPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_01,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=826
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150033
X-Proofpoint-ORIG-GUID: 5-uaNppjfRwVAA-AvDfzre-02S0sFS99
X-Proofpoint-GUID: 5-uaNppjfRwVAA-AvDfzre-02S0sFS99

* Theo de Raadt <deraadt@openbsd.org> [240514 22:42]:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Tue, 14 May 2024 at 18:47, Theo de Raadt <deraadt@openbsd.org> wrote:
> > >
> > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >
> > > Regarding mprotect(), POSIX also says:
> > >
> > >     An implementation may permit accesses other than those specified by
> > >     prot; however, no implementation shall permit a write to succeed where
> > >     PROT_WRITE has not been set or shall permit any access where PROT_NONE
> > >     alone has been set.
> > 
> > Why do you quote entirely irrelevant issues?
> > 
> > If the mprotect didn't succeed, then clearly the above is irrelevant.
> 
> Imagine the following region:
> 
> 
>     <--------------------------------------------- len
>     [region PROT_READ] [region PROT_READ + sealed] 
> addr ^
> 
> then perform
>     mprotect(addr, len, PROT_WRITE | PROT_READ);
> 
> This will return -1, with EPERM, when it encounters the sealed region.
> 
> I believe in Linux, since it has not checked for errors as a first
> phase, this changes the first region of memory to PROT_READ |
> PROT_WRITE.  Liam, is that correct?

I really don't want to fight about this - I just want to have reliable
code that is maintainable.  I think the correctness argument is always
going to be unclear because we're all going to interpret the
documentation from our point of view - which is probably how we got here
in the first place.  My opinion of the matter of correctness is,
obviously, the least important.

My problem right now is that we're changing it so that we are not
consistent in when we should check.  I'm not sure how doing both fits
into either model, but it increases the next change going to the 'wrong'
side of the argument (whatever side that happens to be from your view).

If there isn't a technical reason to keep the check before, then we
should treat mseal the same as all other checks.

If we are going to have an up-front check, then it makes sense to keep
the checks that we can (reasonably) do at the same time together.
Linus, you said up front checks is a good thing to aim for.

That said, I don't think the example above will allow the madvise to
succeed at all.  mseal checks the entire region up front while most
other checks occur during the loop across vmas.

Thanks,
Liam

