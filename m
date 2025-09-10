Return-Path: <linux-kselftest+bounces-41195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C316BB51FBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 20:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9F5483F0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D7C33EAF1;
	Wed, 10 Sep 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EwRKvdhg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W4/1cjpu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E123F42D;
	Wed, 10 Sep 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527594; cv=fail; b=dSBkf4g3jvdnWDYBDqYc+MAj/o3RLbc9fqnzM82Sy1rt/He6sl9aCYK/sj4VnTrEmsSnvUSt2x+U2TEZgq4Gcg78TMEZO6aYmCrl6DcW7grNjQig8Py66qeshXcKnYinEsDv5dYRFPxV+61BZDo97wpd/IkvLSRlRiuaazs6rKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527594; c=relaxed/simple;
	bh=ynbxK/eVgOKbrbrlji/NGHxM7aWjUw+l8LJixwiUtGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PcvjCXah86HTTkVG1kftux0DokK+jmmKuw4ZcQMxcdvPuOThgp6j/ExDhgDH+b1/JaLn73Xsuf0vkJVKZl9X97tVq5Ayk0zjC/uL3kTHB75Y50xLiS5HS7xvQ03T1nUYFIkoue9wfn0CuFlkl6+C+GvaEqOaiPPHOhp5wi1xoG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EwRKvdhg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W4/1cjpu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfj87007228;
	Wed, 10 Sep 2025 18:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CUVcyZu8HJDC8DmbZKu8z0dB9lM8TnZ30ldvFHwuZyc=; b=
	EwRKvdhgGrpQQX3Q9t78koWbXWywyFRzf3uNv0WDKF7Htb1DWbohc3Mr4bvdZdpt
	xbtqHh3ReFYAURUrfeWboMIsn9HlCFj4gUfpujD9foJ9Er6twB6+7ce864jMfbNY
	5mUoL7NVWef74kppKCF3kcYqV1N/g6/wFHqNPXbEmDFpu4DEXzKbMOMGkHLYnfu3
	0rU0GXA37mI01aNAzpGCrfP9E0/oIKUH0E+HiHvzeUnr8ITfvyGVYPUoLKFEByvP
	WfR4QCzqJz6DptfVDu1o+dNTprjS28ODk9TODiLJ8l0lscJ0O85EMHZEXHo4zyRn
	7/d+MotMLtNzvPOd+0QYWA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pect65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 18:05:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGvgi9030697;
	Wed, 10 Sep 2025 18:05:51 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbasnn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 18:05:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO35CMwojkMAeKEOWJl9MuR55PuI+iA2VCnl5uzm+cVxuMHHeJNJnSNYsEWVYlEJXLtShUyDboHbi3EV0WADkyJQngUXYdchRJuRzN1RciijKAgyjtMDxEbHzB/lYiaH3UXRexDdy/DUjTdjck/2rV8srUjKkOwnrUBnnkg8dusfxUBSutenyXSDHLQc8VASMD0kW2739MFGjuwaguG464+PCXoyfxJ86dv86FgVV50sTb9xmgbHmgU4w/lSQZ848oVteLSs5iaA+qdU+rLpa8naJXfrwlbsARCExVqZi1NWPiL43ChfTPc2SPUZkhrpFdAZ4MwDXi2doWuZNNQ7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUVcyZu8HJDC8DmbZKu8z0dB9lM8TnZ30ldvFHwuZyc=;
 b=ngtTIGHeHBq6DfuLoPYE+5jRwC8zS/UcYWVOFd/PWuNuNjD+zJ3PxyI59ez73HBEEJrEuxJzv+4r4vpiN6qUIzcDN4Zjjd/v0znx0STfyJolqPqFeZGczTFGnVtvmgI/DFrWtAlK72Auy1Qd1MpGdhsNDJiqFm/rdGLt1OH3W590zMW+Wcvcx7H+zDmAlfNeC8maPFrvByG7Kulg2e8HR5wQYmeOXHAoQSYMbLycvThKvdqmSOYBo3h3NNSXkV6MfLKS+k7nYYEKnfe+4ap8db7dmPsMWhbCcKZUZ2k5tTPGiP1lS6gwZk/Scbfd51PTiC7R41wpQeGfaLF1u3UBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUVcyZu8HJDC8DmbZKu8z0dB9lM8TnZ30ldvFHwuZyc=;
 b=W4/1cjpuqtwA4C8EHKBZqSGFrKNUHtw0DjRYGaqrpSlP85qD4P9zpNpJO2sXwuK+o76CyFMeTROCNX8aW4X3aDt9PP4wnwFnmceK9NA+QrmGVNIoma+w0L2jLT1OTVRl0onbPj08wTxZakLZTnix0yUIJkD3rAgtVx4e/Sr+mpg=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 10 Sep 2025 18:05:47 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 18:05:47 +0000
Message-ID: <c30e8d18-57ec-4bd2-a5f1-29f8d684abf2@oracle.com>
Date: Wed, 10 Sep 2025 11:05:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: Disable soft offline for HugeTLB pages
 by default
To: Kyle Meyer <kyle.meyer@hpe.com>, akpm@linux-foundation.org, corbet@lwn.net,
        david@redhat.com, linmiaohe@huawei.com, shuah@kernel.org,
        tony.luck@intel.com
Cc: Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz,
        jiaqiyan@google.com, joel.granados@kernel.org, laoar.shao@gmail.com,
        lorenzo.stoakes@oracle.com, mclapinski@google.com, mhocko@suse.com,
        nao.horiguchi@gmail.com, osalvador@suse.de, rafael.j.wysocki@intel.com,
        rppt@kernel.org, russ.anderson@hpe.com, shawn.fan@intel.com,
        surenb@google.com, vbabka@suse.cz, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
References: <aMGkAI3zKlVsO0S2@hpe.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <aMGkAI3zKlVsO0S2@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21)
 To DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 07391506-bb34-45f0-6090-08ddf094ab0b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dk5XaE1ianVCdmNsRDU0Q2pDeVgxakx1TDhXVkE1Um1rSVZnQm5zWWd0bW41?=
 =?utf-8?B?aURZaGJPSklCUm0vSEFRc3NuOGRUOWZZdVluVUVCTFZndzZFbnkvbHE2Tmpu?=
 =?utf-8?B?VTRiNWJJK1dUcUZFT3IwZlJZNHNxYzh2dFVhbmgxRWlNRGtwQVorczBjSFdr?=
 =?utf-8?B?THVCWmltNHVmSk9UTUkrYitodGg4eTdGWHV0UlduZjN1Tm14bGRoT3haNXhr?=
 =?utf-8?B?Qm52WlhINWZyN1R0c1hJOFlsRzgvNmlLbUt3ckJjdzBOYXhRMEhCVDhycDI1?=
 =?utf-8?B?SE1uVkJkUk5FcS9lb1JGS1NoeDl5b2dmV0RuM3dXYTdWK0pBWFNKamQzWFRV?=
 =?utf-8?B?dDd6ZS83Qm9TQjZqV0YyWG1WajMxdVdyWlVaOVRmUmswNER5d1ZqOE9hRU83?=
 =?utf-8?B?MXhvZHlvS09UeDB0WVlZOGttaHZwcFRtUGo2YzJrZDEwWVlORmpvMUNhcEsr?=
 =?utf-8?B?OFRlTDNCRU1ZUE9tM1lQV0VDd3JFZnY4Y2c0Smx5Y1YvOUtoc1FVTlpqN3dO?=
 =?utf-8?B?MmdDQ0wrc3FoQUlaTXZJbnhLQUhVbWpIS25rOTV4Q2xUdDBvZ2J2T0FEeGo1?=
 =?utf-8?B?eHhWWUp2QXhGMnZpT2RycVp6eDhMdzJkeVllSEg4QUF3RTFiZVVPNXFIMkVK?=
 =?utf-8?B?bW0zcVJhdmpSUE1reU5IOGorUWMwNjVBTm5od3haZEFPa0pDS1JvZEJWaERm?=
 =?utf-8?B?RnhZTEVhRFVBRm9zLzR3MVdxNkljYThMeTQvU1VzWFVyNmsyYU45YXd4Uktz?=
 =?utf-8?B?am9LWDg5RDh6QitWWTA1OGxNcUUrSFhzNlYwRDhKNmhCU1ZnM3ZsMUYwMEM4?=
 =?utf-8?B?N0svT0dIQkw4WVRpTDkwVExyd0JWUWFlNnhTRENsTFBzMm5IZWJJN1hpNWZC?=
 =?utf-8?B?VUplaWRLcWU5b25yUnBMbHNSUVRzenlpVDRjL0lZRzh5M09GSG5yeisvSStD?=
 =?utf-8?B?OXg4dEpHcHFlWHhIcDRPSTM1eGhmN1NrUWcwSGt3MU8ybklQcU1CRnR5T25M?=
 =?utf-8?B?bDdKRUlvSVlFNTdKaGV6dHlnRFI3am1DMSs5dXpDb3FybUN3T2V1dUxuSTVP?=
 =?utf-8?B?amF5aytUQ1VCSjFUV0JLN3VWdXNhNFdEUTFrZGEvMElRR3ZnS3phT2FuMW12?=
 =?utf-8?B?MWUraDFPUEE0ZGo4eWNEUUFkU3dxNldxMGMxbkdhQTc5TmZXcUkxZ1dvVFNE?=
 =?utf-8?B?Y3k0a3YwWDBIZXF6MGtKOExiRHkvcVpOR1pRNlFNM1FxMGwzQ2EvdElaVTJu?=
 =?utf-8?B?dTdma3BKaUcyM01JMitGckNrZ1J3c0plOHV0UXhoQzdpNzhOSHQvTWYvc0lr?=
 =?utf-8?B?bVhTeHdkVVUrTEFFU1M1ZzBYbzRNQlFTcy9zdTJBcVk3Yzl3N24yYllpL2Q5?=
 =?utf-8?B?VFBFWGJqaXMxVFBJYjFWYVJOK2wvTXJ3WlBYV3VSWlRHUk9iVzhmY1RXWjR2?=
 =?utf-8?B?SXJEbGRoUGF1MWRXNXJ5UlE1S0tzVnBCaFUwKzhOZTc2RUtSMFJSV2NiS0lz?=
 =?utf-8?B?NDkvNWlFUEVaZ0N0UDRBL3BHUnl0alMvUW1tanBiMjdwcno1R1pYMFE4cEdL?=
 =?utf-8?B?azNWWDc3djJYZWgxNlpzUjNtQzNBd2lhWGN0YitYUUtqb1hKbFpPOG1oaUlG?=
 =?utf-8?B?VHE2QTVPLzBpNS9aTnliOWtRaHJhMDU2RW5Mbm4yc01aMWFMVjluR3M2NmZG?=
 =?utf-8?B?ZEkweGFJbHdEMGd4Q0QyUnhXNWFnSis3U2FUSG9Takp1ZXM4VFM1TzBYT1BZ?=
 =?utf-8?B?dXZWNHlIaXFadzA1NEJKb3psV2Y0MVlQWjRlOHFwN1lzRm9uTEhBTWFKV2da?=
 =?utf-8?B?QTVLZ096WEpZMnBDbWFWSHVmU24vT1hEenZzcHMvOUhNamxHMUxrYndWbjI0?=
 =?utf-8?B?bXRaU3AzeVBCYkdYM0tGemk1MnRNRzI3RjliTW0zWnZWY1BHUlhsSFE3YTNt?=
 =?utf-8?Q?R6hvHLfydFg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?blpOVXl2b210d3dtS0FzSk9TQjFjUjd1NEV4TDdTMUxsMTFNOTBJL0JkKzFu?=
 =?utf-8?B?ZGE4VlRLR0xzdWZ4dE9EdTBRRi8weHB3czFONC9FZExMOTl1cGUyY2g2d0Uw?=
 =?utf-8?B?Z2RsZmZuWCtsd0t1bDVLTk5ITkt2REFlVWkwejdpbTAxUWxhVlVqbUgyQ3hr?=
 =?utf-8?B?S1oyc0tNQTA0aHo1UG1QU2ZGVmFlMUJORWFLNGs0SkkxZkhMdXd6Vjh2dlFS?=
 =?utf-8?B?c01raHVNRU90cVhCN2RoR2QxbW5JaklRY3ZDTU9RR1pUOXBxQnJqV1JrSCtU?=
 =?utf-8?B?YkRDc3oyWXJHeEs5a2h5WjdCN2QzTHgxMkx6djRDNVY2MDRJaWUwOXJNbXJj?=
 =?utf-8?B?OU85UVhIbHZhN1h0T0RGVXdDb1ZPUE4yZUdjb1EwNjB5VnNpaDduRjh2RTc4?=
 =?utf-8?B?aENSdmlva0xub1pJb3FGTlE5ZFplOWR2dVRid0M0eXREa1ZiMjFjZUVON3NG?=
 =?utf-8?B?QXhZZ3BKTkhrRUNSclRWUndIY2VjUU1VbXZzaVFvaUR6ZnBzZXNwN3k5Uml0?=
 =?utf-8?B?YUhvVVFKYVBjVGh5eG9TWk5weGwwdzhwMDlKdmZnek01UkpQUTQvRCtiY0xZ?=
 =?utf-8?B?aDVUWlFKNVNMSEViTWN0bmFIRFNvU1NJb0ZmcXBld2ZRSzgvVXd2ME1ORGxN?=
 =?utf-8?B?dUsyaS9tTmJDU3B0ZVFrQmtBT1RSc21Sc0lIS2RmREhwMU1uRkNDcHBocHVP?=
 =?utf-8?B?ZDlVcnh5Ri8vcUVWd0JXT09jWUZQSGFBOVl6SmUrRWZXYzBRZlNuL0RSWktX?=
 =?utf-8?B?TVZnRTdRQm5ValdDSmFKa0I0S1BsazFBOENkczJBSVoxTkVPVW1KazlPeWlQ?=
 =?utf-8?B?UVJEb3l4b1B0WmduZGRwUlR5Q1ZUSkhET21hY1ljc2RaVkhyK1duYk1XeHZD?=
 =?utf-8?B?VDV5Z0NQZCsrekplWHhpVmQwZTlkZXVoeC9TV3B6dFZ2eEJwMnpLMnBZVm9K?=
 =?utf-8?B?aG91TkxlSG5ZcVN0a05vdEdsdy9yVnBXWEJnNm5QMUtBWnZoRHhMRHF3cGlB?=
 =?utf-8?B?NXd4MlhIVmZudlFhQk1WV3FoNW92a0tSRXZlbytSYi8rZEFsT1A0R1dsbHBC?=
 =?utf-8?B?K25yUW4zVEVQTzBXeXhBWjBGOTl1M3BGNkhqOUQ0UHdRQk1NS3pqQ2xkcVVR?=
 =?utf-8?B?Z3hGSWZNL1NMeHpiRU5OWEt3WitpOXZnYloxTk8rYnJRakhVZVlPNlBZOXpW?=
 =?utf-8?B?c1oxV3J2YW1HejVOVEZzekhEMzFkRm5hME8yUTYrSHlFeitxQVpwcFl0QzRB?=
 =?utf-8?B?aUF3Y0hTWlViZktMU1UxOW5JYThLUkQyV1F6ak40alpneHVsVlEzajAxanU5?=
 =?utf-8?B?cENrNUoyY3ZkUzBRSnJKVlBHdExnTXdXTmx0L2d5Z3VHTWswM2dmczYxeFBE?=
 =?utf-8?B?TEFueTBPMDBrNTdFbFZIbVhWMHo3cHlNay81ZHczZ0FVWlAyU1FRSzN2RGtm?=
 =?utf-8?B?bWlVV294b1RTaGp3OE1GbVoyd3hSa1orTDZ3a0o5U2pPWFJVbTEwRm8yMXgz?=
 =?utf-8?B?YWdRRlNHeDg2byttTFJFUURTd2RqRDdXSm9yYXM1SmVjYzNmbE5zQmVyMHZR?=
 =?utf-8?B?T1dUdjNlRnBkVUJXQ1dIMTZaMW94dUMraHRXMHhQWXVoVDBtNjFodlQ4bUZr?=
 =?utf-8?B?Ny9TL2h5S1U1NlQwSlV3R0xBbW54VldHTFJxMGFwejZxeWVVY2xqaTZTT0pi?=
 =?utf-8?B?L2JXVjRJREFPQjVpY3ZxSXk1NWVXVGk0aWx1ekp3V1E1M1BoK1F1YXN2MTVu?=
 =?utf-8?B?b3hMeDZLSXdiNXlXZ1Q3NmhpcHBDRWhzcEZJUG1VZkZiSGFEQis2a2ZQTUFU?=
 =?utf-8?B?VHRrVm1DWDhrbmF6Wnh2c2dQb2FzbGJLcldjbWxwYWxpVDJRK1FFTzVTKzVK?=
 =?utf-8?B?R2ZCbDh4ZkY5NDlhMVpKSjdDUmNCNmNJd05KWGZBR1Z5UHRvVzRYemJRdWF6?=
 =?utf-8?B?RURTTUV0WC94RG9KWDB5QXFYUDFQbjVVZ1R2eVp1bHlWbXltM0d5NTJ5djhY?=
 =?utf-8?B?a200V3l0emtNVjFoS216NWp2cFFTUkFTcFBHWWpKVE0rTldTYkdNem9NQ21R?=
 =?utf-8?B?aG9jZ1MzN3V5Y3Z4V2RDY0QwVXp4aUhNa3hENDlsbWNQSzl1d0NlY2JCd010?=
 =?utf-8?Q?qkXfz9uJEDXeKIFtuqT9gxTA2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I/ed0DmtDQZxfh8djVA8s0pKVWO4PwKZXASMKkoykk2qeP3fE5qbOB7c8E2FpAPEaKKI/INbiMCNqdcC0RTPB4ps0Q68TUayNkuFaXj+7nKwvqY4zW5seq52by6UvVMzFRUQDbBcHmWzMMg38lDmLp48sFGexVkp5KiOApjD2jMYsWMXWLWm2xlXKT6ITnb3huZ7WzBcm4ehhxx4U77EWIdAcB80ruUhYQLCUg0hqDBL48YtVTzhsOcLIZ3LMrCvTUSbM7R0ureKjmV0abyhYUdxPFNY1iSPlrg6gmMwBCsZ2eUnrdji/PUuUJTx6nQLf2W1ygGchzyrDzdFSA8G3acUV+qzEh1BnZ53CSxmJeXk1VM6KdMlsxMpPAJm/XW4FbDnqxCVSqZkW6q/caftSiywkQBBtWO5UCK7Hbx6D8LkKgrMouMXRO4AUv3CLEsFKT7od7vDW95WVX5Sal6Q463j5T57pusuOFn8dLrur24VjqQmCT78il/oUJA92TXPXqUtLMR2EDBCh70foY3/A94VTVzDdZ2SyXdjNNkETMAQquLmNCGUsFfPd61zFIb92BK2nWCxt9y4mXheEAVAqUhovG5NFNJ/dlv0+9SEW6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07391506-bb34-45f0-6090-08ddf094ab0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:05:47.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7IbKysss52UpYKCcDFKTaWXLhiec8pwifuh6p8+Zukxw4xzSqIjd4dKQrmy3TovnpxqERzJuCNC2F3wU5b7Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509100168
X-Proofpoint-GUID: EinwXd6of3c80L0KL8W3VM2yyHsZ8Jng
X-Proofpoint-ORIG-GUID: EinwXd6of3c80L0KL8W3VM2yyHsZ8Jng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfXzmO2ZfHB9plv
 lX24gFlH2IMzYpshfcsjE4YN1waoAPjDZRiM/PIlcYKYW1xfM93+gTvGTxQ3gpPfhM3vWPfr/V3
 0+n+nZt+OFrZuNneF3q180PLdNv/BKvQgwwrlG9kakPX5VmV+1zs1jF2Rrz/WLNZTR/t1GcB9mz
 9HxgdQkTEBDtNrjZwWov04riz4POsWEtPObuoge7T/1z3yyoaIFHmfrEt3M/ebE7bckGww82Nrw
 /EzKbkpEC9GbksjjBQ5SQpbXXBw9y3XncoTLeY38mS5ryQG7da9YxduYVSGXe8kJAjjsDpPj7k5
 P7pytgISR0mzVpIH6gBQ+Fq+TslXvKn2BAH10jhEtVPde3ALdnFHkTA+86Zu5gtdTL5FqDrRlaN
 erbuXPY5
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c1be00 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=MvuuwTCpAAAA:8 a=yPCof4ZbAAAA:8 a=6lUxV4Vzs-SqJoBDBCsA:9 a=QEXdDO2ut3YA:10


On 9/10/2025 9:15 AM, Kyle Meyer wrote:
> Soft offlining a HugeTLB page reduces the available HugeTLB page pool.
> Since HugeTLB pages are preallocated, reducing the available HugeTLB
> page pool can cause allocation failures.
> 
> /proc/sys/vm/enable_soft_offline provides a sysctl interface to
> disable/enable soft offline:
> 
> 0 - Soft offline is disabled.
> 1 - Soft offline is enabled.
> 
> The current sysctl interface does not distinguish between HugeTLB pages
> and other page types.
> 
> Disable soft offline for HugeTLB pages by default (1) and extend the
> sysctl interface to preserve existing behavior (2):
> 
> 0 - Soft offline is disabled.
> 1 - Soft offline is enabled (excluding HugeTLB pages).
> 2 - Soft offline is enabled (including HugeTLB pages).
> 
> Update documentation for the sysctl interface, reference the sysctl
> interface in the sysfs ABI documentation, and update HugeTLB soft
> offline selftests.
> 
> Reported-by: Shawn Fan <shawn.fan@intel.com>
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
> 
> Tony's original patch disabled soft offline for HugeTLB pages when
> a correctable memory error reported via GHES (with "error threshold
> exceeded" set) happened to be on a HugeTLB page:
> 
> https://lore.kernel.org/all/20250904155720.22149-1-tony.luck@intel.com
> 
> This patch disables soft offline for HugeTLB pages by default
> (not just from GHES).
> 
> ---
>   .../ABI/testing/sysfs-memory-page-offline     |  6 ++++
>   Documentation/admin-guide/sysctl/vm.rst       | 18 ++++++++---
>   mm/memory-failure.c                           | 21 ++++++++++--
>   .../selftests/mm/hugetlb-soft-offline.c       | 32 +++++++++++++------
>   4 files changed, 60 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-memory-page-offline b/Documentation/ABI/testing/sysfs-memory-page-offline
> index 00f4e35f916f..befb89ae39ec 100644
> --- a/Documentation/ABI/testing/sysfs-memory-page-offline
> +++ b/Documentation/ABI/testing/sysfs-memory-page-offline
> @@ -20,6 +20,12 @@ Description:
>   		number, or a error when the offlining failed.  Reading
>   		the file is not allowed.
>   
> +		Soft-offline can be disabled/enabled via sysctl:
> +		/proc/sys/vm/enable_soft_offline
> +
> +		For details, see:
> +		Documentation/admin-guide/sysctl/vm.rst
> +
>   What:		/sys/devices/system/memory/hard_offline_page
>   Date:		Sep 2009
>   KernelVersion:	2.6.33
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 4d71211fdad8..ae56372bd604 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -309,19 +309,29 @@ physical memory) vs performance / capacity implications in transparent and
>   HugeTLB cases.
>   
>   For all architectures, enable_soft_offline controls whether to soft offline
> -memory pages.  When set to 1, kernel attempts to soft offline the pages
> -whenever it thinks needed.  When set to 0, kernel returns EOPNOTSUPP to
> -the request to soft offline the pages.  Its default value is 1.
> +memory pages:
> +
> +- 0: Soft offline is disabled.
> +- 1: Soft offline is enabled (excluding HugeTLB pages).
> +- 2: Soft offline is enabled (including HugeTLB pages).
> +
> +The default is 1.
> +
> +If soft offline is disabled for the requested page type, EOPNOTSUPP is returned.
>   
>   It is worth mentioning that after setting enable_soft_offline to 0, the
>   following requests to soft offline pages will not be performed:
>   
> +- Request to soft offline from sysfs (soft_offline_page).
> +
>   - Request to soft offline pages from RAS Correctable Errors Collector.
>   
> -- On ARM, the request to soft offline pages from GHES driver.
> +- On ARM and X86, the request to soft offline pages from GHES driver.
>   
>   - On PARISC, the request to soft offline pages from Page Deallocation Table.
>   
> +Note: Soft offlining a HugeTLB page reduces the HugeTLB page pool.
> +
>   extfrag_threshold
>   =================
>   
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc30ca4804bf..cb59a99b48c5 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -64,11 +64,18 @@
>   #include "internal.h"
>   #include "ras/ras_event.h"
>   
> +enum soft_offline {
> +	SOFT_OFFLINE_DISABLED = 0,
> +	SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
> +	SOFT_OFFLINE_ENABLED
> +};
> +
>   static int sysctl_memory_failure_early_kill __read_mostly;
>   
>   static int sysctl_memory_failure_recovery __read_mostly = 1;
>   
> -static int sysctl_enable_soft_offline __read_mostly = 1;
> +static int sysctl_enable_soft_offline __read_mostly =
> +	SOFT_OFFLINE_ENABLED_SKIP_HUGETLB;
>   
>   atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>   
> @@ -150,7 +157,7 @@ static const struct ctl_table memory_failure_table[] = {
>   		.mode		= 0644,
>   		.proc_handler	= proc_dointvec_minmax,
>   		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_TWO,
>   	}
>   };
>   
> @@ -2799,12 +2806,20 @@ int soft_offline_page(unsigned long pfn, int flags)
>   		return -EIO;
>   	}
>   
> -	if (!sysctl_enable_soft_offline) {
> +	if (sysctl_enable_soft_offline == SOFT_OFFLINE_DISABLED) {
>   		pr_info_once("disabled by /proc/sys/vm/enable_soft_offline\n");
>   		put_ref_page(pfn, flags);
>   		return -EOPNOTSUPP;
>   	}
>   
> +	if (sysctl_enable_soft_offline == SOFT_OFFLINE_ENABLED_SKIP_HUGETLB) {
> +		if (folio_test_hugetlb(pfn_folio(pfn))) {
> +			pr_info_once("disabled for HugeTLB pages by /proc/sys/vm/enable_soft_offline\n");
> +			put_ref_page(pfn, flags);
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>   	mutex_lock(&mf_mutex);
>   
>   	if (PageHWPoison(page)) {
> diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> index f086f0e04756..7e2873cd0a6d 100644
> --- a/tools/testing/selftests/mm/hugetlb-soft-offline.c
> +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> @@ -1,10 +1,15 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Test soft offline behavior for HugeTLB pages:
> - * - if enable_soft_offline = 0, hugepages should stay intact and soft
> - *   offlining failed with EOPNOTSUPP.
> - * - if enable_soft_offline = 1, a hugepage should be dissolved and
> - *   nr_hugepages/free_hugepages should be reduced by 1.
> + *
> + * - if enable_soft_offline = 0 (SOFT_OFFLINE_DISABLED), HugeTLB pages
> + *   should stay intact and soft offlining failed with EOPNOTSUPP.
> + *
> + * - if enable_soft_offline = 1 (SOFT_OFFLINE_ENABLED_SKIP_HUGETLB), HugeTLB pages
> + *   should stay intact and soft offlining failed with EOPNOTSUPP.
> + *
> + * - if enable_soft_offline = 2 (SOFT_OFFLINE_ENABLED), a HugeTLB page should be
> + *   dissolved and nr_hugepages/free_hugepages should be reduced by 1.
>    *
>    * Before running, make sure more than 2 hugepages of default_hugepagesz
>    * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB:
> @@ -32,6 +37,12 @@
>   
>   #define EPREFIX " !!! "
>   
> +enum soft_offline {
> +	SOFT_OFFLINE_DISABLED = 0,
> +	SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
> +	SOFT_OFFLINE_ENABLED
> +};
> +
>   static int do_soft_offline(int fd, size_t len, int expect_errno)
>   {
>   	char *filemap = NULL;
> @@ -83,7 +94,7 @@ static int set_enable_soft_offline(int value)
>   	char cmd[256] = {0};
>   	FILE *cmdfile = NULL;
>   
> -	if (value != 0 && value != 1)
> +	if (value < SOFT_OFFLINE_DISABLED || value > SOFT_OFFLINE_ENABLED)
>   		return -EINVAL;
>   
>   	sprintf(cmd, "echo %d > /proc/sys/vm/enable_soft_offline", value);
> @@ -155,7 +166,7 @@ static int create_hugetlbfs_file(struct statfs *file_stat)
>   static void test_soft_offline_common(int enable_soft_offline)
>   {
>   	int fd;
> -	int expect_errno = enable_soft_offline ? 0 : EOPNOTSUPP;
> +	int expect_errno = (enable_soft_offline == SOFT_OFFLINE_ENABLED) ? 0 : EOPNOTSUPP;
>   	struct statfs file_stat;
>   	unsigned long hugepagesize_kb = 0;
>   	unsigned long nr_hugepages_before = 0;
> @@ -198,7 +209,7 @@ static void test_soft_offline_common(int enable_soft_offline)
>   	// No need for the hugetlbfs file from now on.
>   	close(fd);
>   
> -	if (enable_soft_offline) {
> +	if (enable_soft_offline == SOFT_OFFLINE_ENABLED) {
>   		if (nr_hugepages_before != nr_hugepages_after + 1) {
>   			ksft_test_result_fail("MADV_SOFT_OFFLINE should reduced 1 hugepage\n");
>   			return;
> @@ -219,10 +230,11 @@ static void test_soft_offline_common(int enable_soft_offline)
>   int main(int argc, char **argv)
>   {
>   	ksft_print_header();
> -	ksft_set_plan(2);
> +	ksft_set_plan(3);
>   
> -	test_soft_offline_common(1);
> -	test_soft_offline_common(0);
> +	test_soft_offline_common(SOFT_OFFLINE_ENABLED);
> +	test_soft_offline_common(SOFT_OFFLINE_ENABLED_SKIP_HUGETLB);
> +	test_soft_offline_common(SOFT_OFFLINE_DISABLED);
>   
>   	ksft_finished();
>   }

Looks good to me.
Reviewed-by: Jane Chu <jane.chu@oracle.com>

Thanks!
-jane



