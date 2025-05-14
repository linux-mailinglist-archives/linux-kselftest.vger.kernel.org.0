Return-Path: <linux-kselftest+bounces-32964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1386AB766B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B4C866E49
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD98293753;
	Wed, 14 May 2025 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jW4Dck0Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qk7amobr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534728FABC;
	Wed, 14 May 2025 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253325; cv=fail; b=FMsVtMQqYV8yRvi39m18uTRhhqZUri9ArJNGwvYFIvhdAziN/zYpaHaF7+PbFnNlJD/yoWZvXrnme3xB8WEks09nBMllJAIBPIsfKWBHJjcIEuhNy8xyPxtp35RWTd5WdJwTG34Ze5cysP8gkWbvw+uHmBPJJSGU7x2OoU22/kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253325; c=relaxed/simple;
	bh=jGdlb3Bt/6QHZDM4CF9dibCoHQF29aypfusk0snXDUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ed8AKGkXvxkzqFGxVC4/0FOaUbbrQoLtq66uuji4ZVXQtKFz37YhhIXqLc9qq27M9jZoCbsLajCnAnxinCggVB1Tpc4p3hgpdwMmSkuzaoJaeOVBethvq05X08C7XHamGottJ4aiZjd/i//4aKhSW+l9TI2yX5VSvjo+aU8uFJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jW4Dck0Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qk7amobr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJIFmG020601;
	Wed, 14 May 2025 20:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+ar2e0WmyUwdD36FA04WMSVi5C0AK9jbSdpR46ztR2Y=; b=
	jW4Dck0QDczBWuS/0p4H3qnqKdiNDGe4wbNEjIMxNy2+ICNv/cdtnF48Q5L2tqTk
	IevM+cL9HmcxeIZHke4n9GrIeRNu5uAxjNPF4ZfLWYawuVwGI3a/3svYXwB1OZnz
	X4TcQRzbZ480jc/pIczfoozBN4TEtjkUlb93Aa5aOlQKmaBhG9c3w0b+YNpeky7O
	ziMnyMFjBrUC6rpxyucO8o2icK8Gjo7jwk386acYsde59FU+/sU4nYXG18HuXS47
	K+DLZsx09v/QIm/J+Rfe+AS9RPXiUIeA1MdahW4wJqYZKhrpBXm/g32qO5xq1Bfs
	nurlqbmj0D1/TL9H0esAVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcctrjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 20:08:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJPjHa016195;
	Wed, 14 May 2025 20:08:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc33xpr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 20:08:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEmW5jNJYFzP2xcGoNVGG/F6TIHBWRlHI0SE5u5SbyirHz98ayUhwszL4tOo3KcpkjkqKrBvM+q9MGfBU6YRQ1TP7IU0EF+lYWUULFMXBz0Bm7jliRL5MM6U4s5Y4yG4ZGil99EO3R3MOPn3IucqzeRvtqKUrwlePsErKQaQTIntj6KkZ94Rr58Dd+uAtTAvLv3pyGvLS8Ky1tMnD4QH2FkzH9fAuEvaa/00/XUP1lIzplBJNPvCtO4ehrkEHv3VWpJP+Pfv7vy7K1PpVTSWi4Thee7nGQ0QSOQh5TsKN+dbMzlUH7mEEnlniHQAVoUO18peZ+BseSLaEw/rfEZFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ar2e0WmyUwdD36FA04WMSVi5C0AK9jbSdpR46ztR2Y=;
 b=XEsNEP6eHQyhZf87Qrxmx6SSzHJBTqmvTq5fkOXwJKNJCwFeC+35LoIVcivpVCJM229xzmFBjGuWjz2IxMbBtxFeWwG2FxzavXPagwlFCiQyTrpQthbcl0DwTMtHAw+03sxY24hoE9jM/g+XPdLwnLMGuBZgvPR99VG/WIPmOjnUUIvRl/xBx+HMah+j6hc7aMdNB50u0iFdjQDVE/2E9l7dOgUEe45ceu0oHgpDNyPgL9oDfD6QVRECoU1TPDqKnb3osT5i4HRKFfbCy/ohp32aSoHRWFROpNOPEKug59nIlWrj4VelSDlgk8MmEe7EeRYIRui0V0mb/HoR8Id2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ar2e0WmyUwdD36FA04WMSVi5C0AK9jbSdpR46ztR2Y=;
 b=Qk7amobrhEcWm00jrpaFYPxe3LkRzVwu2nFq1Fi8YeMg/bi/yeDHqgkgKDkIUIpoPwpcDPYpWTVLWH9CVS8RqIhkGHiEDvd12vbEkcKJ8j4EE6+aPrebWYZQBB6jo/QkkT++R+onnFADw8EDyAmVdsKrbIbQdeQTSjTUkP6ona4=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 CY8PR10MB6513.namprd10.prod.outlook.com (2603:10b6:930:5f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Wed, 14 May 2025 20:08:12 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 20:08:12 +0000
Message-ID: <2459f14b-4f4e-47b4-8f79-6af784ef6686@oracle.com>
Date: Wed, 14 May 2025 16:08:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] iommupt: Add the basic structure of the iommu
 implementation
To: Jason Gunthorpe <jgg@nvidia.com>, Ankit Soni <Ankit.Soni@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
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
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250514155411.GC382960@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0033.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::8) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|CY8PR10MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 18535e86-fef7-4076-f56f-08dd93230d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW9YYTlZL202NU1aQ09WaEdUNGtzdXREeWlvSk9sTEJTYXdtWFl2a3MzemlQ?=
 =?utf-8?B?VGJZdEMva0hyMlBNSWYyZE02amhLS0toRm8xMTJGSFBtQnFkNVp2VHVocWFi?=
 =?utf-8?B?VnlpRmMxTUd3TnNualp2QWExUmt0TlNQNlhHakFjd3h6TTAwckJxOTJLWjNu?=
 =?utf-8?B?d2RRSk00TVYyVkhKN3NkbEo5OWh1TWozQ0J3ekwyN2t6d1V6Tm85OE5NQkh3?=
 =?utf-8?B?bTd6QmJ0aVZUaEhHK1VTSGM1Vk0vODhWRWZVZGpqd09WSnBDMjFibENBQ1N2?=
 =?utf-8?B?bG1kckFienVxOVpvdnB1YnM3ck5NR1IrNGdtTzlsdkZvbG80UUwybjczdnFD?=
 =?utf-8?B?Ujg0eUdQSVJGS0Z4Q3pwMWVYR0hwL3dScDJ5N0Y3K3RiQ2pQNkhGT1Q5eHVn?=
 =?utf-8?B?dktVbGY5OUliUms1a0l0ZVNCV0wzTmE4MzMySWdyRjUzN09NZE5QYUVhS29m?=
 =?utf-8?B?U0tsdFFkdFY0SDQyZyt5a0hzVGtKOER5NlByRHVzL1lZY0FvejdEbGJJd2lH?=
 =?utf-8?B?cFV1OGlMem1mOXBCRGIzQ0h2VFdmdTM2UWtkcUVpaEgySGdiZnB3MjJ1ejRl?=
 =?utf-8?B?L1hFbW5WZGdwVHh3MG5VN2NGTFZabi9FUTE1S0V6Zzdxa1RBWVZheFlyS21o?=
 =?utf-8?B?bnRaWU5CRCtoTXBFWnhHeGh5ODZHNTZqK3JXM3F5OXUvUnMyUlJBNUU0NUdt?=
 =?utf-8?B?aEtVT2FUMDFvOXVLWEZtZHJHUlBPbi81MExQNzR4RTJXS25XbWVhVUNaMVVQ?=
 =?utf-8?B?STJLYlUxeHVKVU9BcVp1cVZWOVdkajN1UXhTa3Zpa0xtaUF5RFpCODJ6Rjdk?=
 =?utf-8?B?cHdyejhBdnFIdUUyMWxvR1g2VXhsT1MyalNYd3ovOTdobVoyNmFGN2pvSnhS?=
 =?utf-8?B?Qk93MFA5RXphTUFNSiszVWNySW9XekdOY2RFNm02bGhZT2VDdjcrcVM4MSt4?=
 =?utf-8?B?dC8yc0VMb0hxZFJOZ00vSWFtMXVtNmxFNFFQR3I1SHVmSzBjVGFxYWMzWnZo?=
 =?utf-8?B?amNIT2kwR1ZJK2xiMUNMZjgrZlJ3eXpOMjhxSmxtblhPYkFOTTRvb2pYL2Vo?=
 =?utf-8?B?NE1LQ1U3V2psS0NTdnUrTVVIb0VYZDBXUVY0UHhGUUZ5b0JIRGZRN093eW5D?=
 =?utf-8?B?NC9jZENqV21rcG11ZVV1dGo2RVpOeGQ1L0tMY3BmSkxINFd5K1VNTzFnUFZI?=
 =?utf-8?B?TXR6Q1U5a1hvTGQrOGN1ancyWDQ2TGhoREwvTkF6QUtaN25LS0VsOXNaR3Rs?=
 =?utf-8?B?eXRoTUd0S3RRVjN0WHRQd0NnUVNSSVpUbW9jd0FSaGtGYVV3QVlVeFlkMThx?=
 =?utf-8?B?b2Yrcy9aK0s4SElydS9rQjRHYlJqUWlEVnJDTC9nUjhWVDQ3YjlsdUYxbTVB?=
 =?utf-8?B?K3Vyb3IzWTlUMGpKZGVzMjRyREY3MWpHSUVXN250TytqNWFaMzJhNG83dTU4?=
 =?utf-8?B?bjMvZjVhVHNCbFNHY3Yyb3ZPejkzQUJNOVVYTG83R3B3Q0JzTXYzdTA3Mkt1?=
 =?utf-8?B?cEVYVU5sVmE4MU4vNlBTdzRlQVYwUC83ejl2TVE2ajUySCtxN2tzTzFva1Rh?=
 =?utf-8?B?UHYyVHJ5QkRDbkplWUNmMGNhclRSYzNwbmI0ejdPM29HWVNLSkNBam1WekRG?=
 =?utf-8?B?QWl4UnRqWTF3L0RDWlNZbjlEemo5VHpTY1c5NWdyQW0yWVhSRXZtWHdvbmxN?=
 =?utf-8?B?aWt3d1prYTJ0ZStPZDltbGNTeGRtL2pnd0NBU0krM1A0SDBpZk0vd3dSb2J1?=
 =?utf-8?B?N1JmQUhWblVJMk9jdGlvTWZFYi9QUFdwWjZvMmZzRk5VeGowT0VacVhKbmFH?=
 =?utf-8?B?WWdLVzVudHNKNWI0SXdVUnFVZkJGckRiUnRUV25nQzRIQ3VqekdSMkVSamdQ?=
 =?utf-8?B?SUlVOXQyZVlWNHgvbnJFdG1sUktEdWFGRWxHK3ZOME9pT2syajNBU2M1N0tm?=
 =?utf-8?Q?nHhn1rSk3eE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5280.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alpkQ0dnS2tMRFJFMjRiNDNvdXpJUE5RQnJwTXlmUTlWd3hPRFBBYmNkaE1P?=
 =?utf-8?B?OTRRdG9IUDZQdWE5bVhlRjQ3K2hOaS8vSkF6bEM4QTl0NXdQTzl2MTZibGt3?=
 =?utf-8?B?cnVaUGY4THpZVFZpSXc3OThnUlBHUjBsWkM1RXoyUzBqUHVLbHR1Z21lZzZK?=
 =?utf-8?B?ekdocWZBWnBLeUFjZ25Fc25Fcno1V3pqeDhlZS95REFjcU9XdTU3RUlTV3Z0?=
 =?utf-8?B?MDRTa292TlpreFdIQ0VTTmN1UjF1azd2eFdUS1V6TURCMXdpVXRXRFRjd1hl?=
 =?utf-8?B?TXpDZ2czeXBuT1BBaVJMYWNqNW9aK2owR1F0Tm9JY1VvdnVRdXpUbHBndDFQ?=
 =?utf-8?B?OVd1akdUcHVOTXc4ZmRwRGtWTTFjQ1A4R2lRYjhVNS81alZZMG5veElyN3lE?=
 =?utf-8?B?TkxMNnJML3pibXVmK2hlUTZhWGYxWkIyWUw4ZHE0aERpWXdIYytkclQ5VWRS?=
 =?utf-8?B?V1lKYWpqNDlsdnp5enFMaHROOWh0bE5KbzRmQ2VraU82R1lQcVI4dUkwSDBt?=
 =?utf-8?B?NVhHTE1iVXkrQnRZaDlmVXovdzN1aGg1QUN5aEJuQWNNbGQ0M1BBL3cybnp2?=
 =?utf-8?B?KytBdnJVWVJzQXhNbnRwZHZodnQ1c1FhQ2UwdDEvMTcwMUFERVZYc2JnMUs0?=
 =?utf-8?B?TVJPTENWNzVncnp1Vys1NDFTaUs4d05sSnhtaG95NmwwMTZyUUhQQ2V1Y1pp?=
 =?utf-8?B?bjRvYUFhaTRTZTlJZC9MUkZNUFVuZVY2QnAwbTZLUVd0Q1lwbjE2VEViaDRi?=
 =?utf-8?B?cGhibmczOUxxRzl0Z0Z4M2s3ZDkxTUhLb3pNZWhtQnFYMHRmTzc1TlhVaUEw?=
 =?utf-8?B?dE0vQ20vQWtRSHlISC95d1BjdThiam9iY0FydUZQdkw0NU1FWEplV280aHk1?=
 =?utf-8?B?L1paZGdTZTNORDZabGlReXA0OWVCUDJhTjZBUW1WZXJCbWpqc0M3WVRoNjRh?=
 =?utf-8?B?Vk83K2NwQTlIaFhpSklWMENhTDFMbWpGTGJrbkdUVzhKZ1BRNWxkRWs5YWxO?=
 =?utf-8?B?bDNWS1NNZFZRQWJBZ0tOelRGczVIRXJETEorTmQzaGhPaVZwSWhQVmFIU2d1?=
 =?utf-8?B?c1o0b2JiVytNbzZNZk1FdksxU2R6VmlNelJabmlhME1ISmhzdjY0ZGZSMzR0?=
 =?utf-8?B?NmZSNUR0ZXVBTVF5MkZ2Q1hxL0RFQkFuNS9zbkYwK2N1M2NhMW1RRVRjTHYx?=
 =?utf-8?B?d0s0UWROZkZnbEpxS0FvRXpKVlVQMXIzeEVJaWxnRVJ6UnR0cTZTTzJTcG5u?=
 =?utf-8?B?S2lBY29KUXdvc1VlbHZiK01vRGZZNVBJdFd1WWcyZHhMdkZlY3dwRENUV3ZQ?=
 =?utf-8?B?YnMvQmJvd0JxRzQwRHE3MEEyc0pEdXlIcTdvMlRtVTgrQjkwY3A0c1FyM1Np?=
 =?utf-8?B?RXgzcEdNeWZVVUlqK0RHalZLc2theXpkbHJmblNGamdqU3hsa3JXNFFLWG1V?=
 =?utf-8?B?Y2VoZnlLTmxNbmIyTlBtMkpNM21nR3lHdDFXYkYzWFVWZkcrQzZIZ1ZObW5q?=
 =?utf-8?B?Tm5oalNEc1VXQzYzL2l2bU9saFJ4cFFuOTg2VGl4aWpFU01YY3NWVzJPQUJH?=
 =?utf-8?B?a3dMV2pZaGZiK3ZxdWQvbUIyRnpVd1RNM1NXdHZsclVkdW5KMFhWbUJIcmRR?=
 =?utf-8?B?UU1EMkFLRmNxVExPSXdKU29kTnlBaERIakRtTVJEdTRJK3RDV09JTXVVMUdO?=
 =?utf-8?B?b2UwR1IrZjBQNGtIOXlOS0EwZEZ3NlpNa1N3aE5NbkhNUEl6NWw0RmlJU1ZZ?=
 =?utf-8?B?L0cxYXJhMlAxYU0wNmhScG14OS9uL2xhSnFMOGl6WU13SDV3eTdndmRWOWMv?=
 =?utf-8?B?UkU2YmJmdk1tZzNkMHJYa21ycmpiQVgwTlNScU1DZnVNSTZHMGxySXdZcGls?=
 =?utf-8?B?Vm1qOWlvUi8yazlsT2wrSmp6eHlpQm5Ha1Y3QzVrWVlITjR5OTdJU0VpR21V?=
 =?utf-8?B?WjVBNmNpKzFucTF5TkR0VCtGbGozUDhuTUhma2FxWXFGbkFJMUhwaDZjdndj?=
 =?utf-8?B?NWJCL25vOHZqc0JLaVFoUEsxQ0RiUlpteTY0azNMaitFajBzTm51UkxwZGdW?=
 =?utf-8?B?aWovdjhrV3duanFOUXN1Y3V4OHVVcExpQzhCSUN4d3IzV1BON0VmTW5tMXIv?=
 =?utf-8?B?L1lpSld4K0VLVjdVZ3h5MnNjWmNCa3VIWkZiOE5iVDVYdVBmaVpmc1ZZa3pR?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9tltcfSjU0tR5FE0Na6ZS1f04uWWd3Qn4stChZ7LXAvedPamJ+eWOgkrZzyJxctWsHZyjtssu9XqKaxQQEdsebkJ7VEX0EqiPT2FdVI53H8JoT+uAKM37WkTqt+nohmbp+Xo0MWGVZ5A7E+ZlmBCpVKahGrsKPJhhS2y4oRz4stobtK07vLysYP395kYr3O2BEqymnIAyZMLX9cOdv6pMHuj3Df62TBdFsqzQ0YjKJ/XcyQBfYAeMS83m7ZI4cm1rnrR6McHrjtp0GyT/jQDAvVygDskGcEnmEKgiJ+JCPObUEWSsQoAUh9WqVBN0Qzd06EB6Ivh1KvjpoOAatvyqNS/NHLsMvv9W4pHcjE6Vo1tKswacp3n+fY4jrdFEjCkZxgOYrmPItOD1h/0mzyWCqUuVmPOOZiqI8ChOoi5uob4uV6enU9DMeVd8J843knGXpwnwf0M52+K3nJ3pIG9TKjnknwMv1Ksqtr/d3tnxznqVmmYiGfiwOSG+4rUHeJDgMTCGZ9lnxS6GF45GmSvDrVulS/gP19bD+l/LN95tUBODrAn+Av7XScwvC4zoOjB3f2mkPHD1szQ0GxE/qD7T/YRtwU7yBLsJicWSPglCCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18535e86-fef7-4076-f56f-08dd93230d9d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 20:08:12.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4ABzHhuzik7p4NyrYWnSPUL6nkzRnV++d/WbOaIe8+z/3dNDi/XdArpm/rkGeV+az1D6Ze9UNuw0PUkKp8+F6I9E0w5JOd/0aD/zQFxICU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4NSBTYWx0ZWRfX5LHWFrVADXzS ZmKWR7ITdjEAyMtFN6y36NUaT8efdvwnOrerGccLFK/g+yZPli1tCglmOWavYrKtcxFmCLNJYeZ sMbDOPOEhqqoB5MCAh9ABRsqv1QwFmX8UQZfnT15GhVIq4KQKZKjLQDucVFjFrMwigckOFddj7R
 aE2/ZBQSOZrT9DdyrW0VeC4nQu6OcscuE0A/QexKVva7QY68pThOAvCIQTYfm2XjXLyMi1//Gg5 J0tksrwPauklW61NlwUA84o2Kj2ntmQ4mf7DwSd75aM0IUNLYNW8HfTB6AwCKXHl88529sWd98/ U3j6b06ItbjLDXtjmrJNgdeftm7SwMJa2mho/pUqweEjDclnZSbScQ3LVnG3kscO3nEB0aQqHRz
 iy5f5kTTJqfSUAPBlqnbU8SEHAXnKz+i650YR0riB+6iKToISIdNJ8HobnLDXoUjnzTu9vsO
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=6824f835 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=219_X5HTwWxZOwK8FbAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: p6bNFmedHH7obUS5iwGpRFtNVEpmkPgN
X-Proofpoint-ORIG-GUID: p6bNFmedHH7obUS5iwGpRFtNVEpmkPgN



On 5/14/25 11:54 AM, Jason Gunthorpe wrote:
> On Wed, May 14, 2025 at 09:23:49AM +0000, Ankit Soni wrote:
>> I am experiencing a system hang with a 5-level v2 page table mode, on boot.
>> The NVMe boot drive is not initializing.
>> Below are the relevant dmesg logs with some prints i had added:
>>
>> [    6.386439] AMD-Vi v2 domain init
>> [    6.390132] AMD-Vi v2 pt init
>> [    6.390133] AMD-Vi aperture end last va ffffffffffffff
>> ...
>> [   10.315372] AMD-Vi gen pt MAP PAGES iova ffffffffffffe000 paddr 19351b000
>> ...
>> [   72.171930] nvme nvme0: I/O tag 0 (0000) QID 0 timeout, disable controller
>> [   72.179618] nvme nvme1: I/O tag 24 (0018) QID 0 timeout, disable controller
>> [   72.197176] nvme nvme0: Identify Controller failed (-4)
>> [   72.203063] nvme nvme1: Identify Controller failed (-4)
>> [   72.209237] nvme 0000:05:00.0: probe with driver nvme failed with error -5
>> [   72.209336] nvme 0000:44:00.0: probe with driver nvme failed with error -5
>> ...
>> Timed out waiting for the udev queue to be empty.
>>
>> According to the dmesg logs above, the IOVA for the v2 page table appears
>> incorrect and is not aligned with domain->geometry.aperture_end. Which
>> requires domain->geometry.force_aperture = true; to be added at the
>> appropriate location. Proabably here!

Thank you for pointing out this issue and its cause. I originally tested 
on a host with SCSI storage, and after your report I tried but couldn't 
reproduce the hang on a Zen4 host with an nvme boot drive. I wanted to 
see if it was a pattern common to NVME, but I suppose it depends on the 
DMA mask chosen by the specific driver.

Alejandro

> 
> Yes! It got lost, thanks alot!
> 
> Jason


