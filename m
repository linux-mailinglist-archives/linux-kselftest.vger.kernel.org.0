Return-Path: <linux-kselftest+bounces-33451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E680ABF2BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341C04E602D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 11:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A8D262FF2;
	Wed, 21 May 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MANRRZKL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A6m2tANV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E02238140;
	Wed, 21 May 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826757; cv=fail; b=GqDmFjZQl9r0e0VYJDQZg7B/vyTFhbpOzPGh1tTSIdmPrgqtNWPS9jKFDc8BfkhYUOvvkndmd6ieOmQHOfcVYHg5dc6zKw/JnKNSbHHxbVz/dHt6U4FlnxTtrd+8h/3LACOOLofc31zCgfua0dxynUC8b63VDpKSIog5yhnwC7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826757; c=relaxed/simple;
	bh=97mhDOJ4YLwCKH+BLNwuzzr3RER/akNHFYburMGXs5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HhxTp/B+PZUuNZPTNYWN7tRI9EXN4S4GqzQDc3cC3dk3UMSLnWqpfx/3dCc95YHH0B0l7p2otxpgqCDQGjQzeA+H/GGvwlBcfB03pFcpE4wswFSdJ6hCiZJM0t4MeRMXlVh4Vry4sssRuJCK/eqkhX2dpxKW2KWe+8a15vq+XPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MANRRZKL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A6m2tANV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LBMfM2000459;
	Wed, 21 May 2025 11:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oBwMfhOcVda9mLzm0lbEq+uwh0S99lCiPpx4BHVZLhM=; b=
	MANRRZKLUhCvcQO2jbZFUTSZZXv4+Wwb6gcduey+4enT61GxYPf5yBx0YKlXs90h
	WcoDjswpXPQAvY9ZlvK9dduao9ehF4bqgksQqNDhfpSvMJImv9303XJfgSx62SbK
	8Kw1BPUSS+DQ8hvTK3txr0zuHZxc2QWu+aaZF5iiE0mZm/USd7plT3iCryUkT2Yv
	edIVTET5qNbd3E11vhK/ZXKxk8/Fyj7daTjPSSMAKuToKGIsd3xAPpNMxMqw1EfO
	q6dKtXn3fHPsInEqNyNQIY5X5GDsZ3ydsxk2WhxIrktOM6Tn1UzrxkoYE5+oxChj
	rwXiHEY6k27gS+MqB9R3gw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sdw0g078-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 11:25:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LAALYR033495;
	Wed, 21 May 2025 11:25:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwen75th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 11:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUycWHRDVnDCBrdVHHVET76ssAV3WqVqcNaVAOlrI4dHfspbk8nxt6CQAs9m4MZt0mhl54HwIfN3DhiOaLILdyiQQz5MXXOo2oK0Mq2vTGUdScTnqUE10ffHWreVqDmAKVClhvoWCJNISvRmLxjJUW8MAvWeaXFrNUJaj1DixIlPR3BtRkRsDgEKfL5rdoI2/yZPGBeLnW4HdGlRXuVuex4ki1nQZI+G0yVR6qNIbLTrY5DXpkJYtURPBw44YiGBl3nTwpidLMSZnxG9QlB25wGlSDe4BPYiJ2hdoHb0XbYQ0bqClLgP7BrOP22yU/HBVsXJwSUUt04MEGuKKX8Ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBwMfhOcVda9mLzm0lbEq+uwh0S99lCiPpx4BHVZLhM=;
 b=ql2JBwo8ba9G5vEKm1VdtYzuMaUyKLRxieNZ4GzqVubOTnREjVce2H350TjBckoXLwR2wJnsktJrIG3c9iYzfmZFKXc5YRo2fiEARehAzG/ACGdaxJcQK9srHaEplFkplGoLD/oFOb/RSX6Y2w6TqM0RksoBeBjRraocMedVtEWCkAG3UAdYUBlHr87mTR3fG7KsbLVHX+Qa0hqhYxoKCx2CMWzHWXNo2GH8pWc++SXDMiGgXB8b0M4y3J6UyPwftNzSl8orJ4AzCR0DLDjw7o6ClF4oKvcOdeIip9iij8xAZrpRMN8jtkC2Avng6tr2mJnLN5DNCvkybJWTRdxHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBwMfhOcVda9mLzm0lbEq+uwh0S99lCiPpx4BHVZLhM=;
 b=A6m2tANVswEusAkp+0KMUBzZogfWhfFSgcU25JzS1RrsYgZALK3imEfe1d1HRc6wOIA1N8V4ZrPsm3cYSaVD/azvcbMrCcal88Yxdp4RMYzWBZ3Mmfv8wiyxXI/HmfKxMwwVoi5ggyukaT19dgxBtnZH1TCIJ6q13+sRypPVA/g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 21 May
 2025 11:24:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 11:24:58 +0000
Date: Wed, 21 May 2025 12:24:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        rientjes@google.com, hannes@cmpxchg.org, rdunlap@infradead.org,
        mhocko@suse.com, Liam.Howlett@oracle.com, zokeefe@google.com,
        surenb@google.com, jglisse@google.com, cl@gentwo.org, jack@suse.cz,
        dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de,
        catalin.marinas@arm.com, anshuman.khandual@arm.com, dev.jain@arm.com,
        raquini@redhat.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, yang@os.amperecomputing.com,
        thomas.hellstrom@linux.intel.com, vishal.moola@gmail.com,
        sunnanyong@huawei.com, usamaarif642@gmail.com,
        wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org,
        peterx@redhat.com, willy@infradead.org, ryan.roberts@arm.com,
        baolin.wang@linux.alibaba.com, baohua@kernel.org, david@redhat.com,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        rostedt@goodmis.org, corbet@lwn.net, akpm@linux-foundation.org
Subject: Re: [PATCH v6 0/4] mm: introduce THP deferred setting
Message-ID: <c027a3db-eb6d-4a3c-98b0-635f3f842ee6@lucifer.local>
References: <20250515033857.132535-1-npache@redhat.com>
 <a8bc6012-578b-412a-8dc9-fa9349feaa8b@lucifer.local>
 <CAA1CXcD8FCdCsBkyW=Ppbr-ZRD8PNmPu-3khipX0fVK3mxs-EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcD8FCdCsBkyW=Ppbr-ZRD8PNmPu-3khipX0fVK3mxs-EQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: bf59cc16-0220-428d-d2ff-08dd985a1e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q05uSTc5SldYYUJtS05pTDlxQmhkSjRQT2VYa0xCa2xkcXBmZXdaZkwxcjdi?=
 =?utf-8?B?d2UyL3NWS25IejQ2T1pFY1ZXcVhpY3JaR1VYNTc4RzRiUlVSbTBJSU04Ylpl?=
 =?utf-8?B?alZwL2FoS0E4bVBxaXVKMDFYSS9oRlBERG55aTdYcW1wcHhUMDJLcHhWM2R5?=
 =?utf-8?B?blBZQ3RXVlRRK1N4YjNtOHFLT0NVdm5MUlhxcE9qc05MK2hsanhFRnBDWmQ1?=
 =?utf-8?B?aHRoQmEwUjhwbDRpek5mWFN6MDBZUXFjekN3MGRCMTdXb1EwdEpUVUJHczli?=
 =?utf-8?B?L0M5Nnp5Vy82TTZkbW9oc2V2dTh2aFBvK2FGWnBTMzJxei8zdi9lSFJpOG1Y?=
 =?utf-8?B?QzVhcjJGdHUwR1ZDaTZWMGdGeURZRDUwOEp3VXVGV2R1UW0zT3Q5KzJuTzZH?=
 =?utf-8?B?Nk1nK2JjSWhPbWlJUkFyTTlydS9BbVJsWEFCK2MveXg2dWtpMEJkZHVlb2kv?=
 =?utf-8?B?ZEFGMExZOGhJaWgvVVhvOUZFUXBCVHBDNDZWZXRmd3JBbmNPT0MrN2dQT0ZO?=
 =?utf-8?B?Wk9JWVpMcUJUUWU0azdGWCtObzJoT3QvTGFVc2NseG9PUUxtelRXZUNSWE02?=
 =?utf-8?B?WGUzMS9EWVNxaWpHK0tVWCtKMTVwaXFuSHkvNHB1UEV2b1ZnWFo2aTRoTXln?=
 =?utf-8?B?dzFZb0RHU05OY3BITkxURmZoSVpsK1RTM3psZEdvNTI1RVdPTFdGK0EyT1ZN?=
 =?utf-8?B?YmpmeER6UG5tRDZIbCtidCtQUEpnbmllMzlOdmx2Mk1KYUFPUjZSbUJNWm1x?=
 =?utf-8?B?bHVSUmNmQ3B6QUJWeFQ3b1RtTGNaRW9JYnRqQ0RYVWRtTmZJeFlWR0U0TTFW?=
 =?utf-8?B?MThoQWc5dGV2T0pqMklrblk1dmxBekJ3RzNDVll0d0JSZm5hN2UyRkxyczVS?=
 =?utf-8?B?N3dQY3h4K0hLekF3OUpCK3lEUnJnTUg3QmtXZzMremdTSUtDWGR5cDl2aWY0?=
 =?utf-8?B?Qk44ZytJazFDSXFyZWFRK2JyNGt5aXlnbForWnN2ZzdNMmRDVDNXR3haZG9D?=
 =?utf-8?B?REFPKzdacU0wVVllN1RNWFRFY3RQMWtxVll1RkNpRUlnNjZrVElnWDNVZ2tM?=
 =?utf-8?B?Vk9ycVNmMHlWOUxEbjJ4RGt1VXhaOC9SSlo1QlFTSzNVNnlyWThiRXVyMU9D?=
 =?utf-8?B?a3BOLzZ5TTlOdnhCbk5RVndOaGZIbFlYU0M1UHkvOG5iWlg3eU9OdW01bnV1?=
 =?utf-8?B?TTJDcEo3S2tTOHkzN3hLQTJNOUxzZC9KRzNwOUhqRitEMVhvTGRKSXJ6V2Ew?=
 =?utf-8?B?TUtvV2tNc3gzZEdlVXhxUVFTbFVOQkQ0WWQ0Rk8zOUJmRVg2bHE0RjE4Mitu?=
 =?utf-8?B?TzB4RDU4c0RObW81dHZIYzB3aUVGNHVRdHdoNURlRit5Tk0waExhcmgvZVR1?=
 =?utf-8?B?NWh3QWdicnd0T1lDem1JcmpjNk1aOXdUMXhhd3NNMXhHcGs1WVdEdUJDeUtP?=
 =?utf-8?B?SE82bE40Y3JocksxaVd6QmwwRklvLzFuQkRnV2F3M2F6MmMyeHltUGJQUEdW?=
 =?utf-8?B?THV1aWV6dWorWnR0dXBFL2R6T0NpMUNsQTR5ZGxnTnZFVUo0cytqeGRjUmNZ?=
 =?utf-8?B?QThHY3FNUHJnWlhmVDVYMnRSZUhScHRWUU5vQTZkeFJ3bDNtRHBQTlVqeGU1?=
 =?utf-8?B?TStEc0pYZlVyd0pxM0pEOUE4YXE1V3FKS3ZBcUMvS1hjMHlyVFZZVHpzMEN6?=
 =?utf-8?B?QXJSZ2thRmFIN0UrNDNYaTJHNm5kU3ZYUjJQWmVBWXFieDRaS2JnOE1jVkRG?=
 =?utf-8?B?WGM2c0ZNbnMwNTdxVVJwbktXQlVXQTZ3SVcxdkpDbE9QeVhhRlMzc1RxQ2xz?=
 =?utf-8?B?ZUlPWlMwVTR3Vkt0eitMTm1aL0xjME5paXpDd3dndDBZaG1BU216VjFhV2k3?=
 =?utf-8?Q?bhiNkyJm4RAuU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akN0ZWZpb0ZVVkQ2QWJYNG9qNFN3NWF2aTUxWnJBWjNJRTc0bEF3YjhjVUdP?=
 =?utf-8?B?ZzNjbUp1MmI3VGFnaTFObEdlMVZxbWRKOXUxNDBBc0paRzZyUWVYS3g4c3Bs?=
 =?utf-8?B?Q1I0UzFhSWdDdHBYVnpZQXJMc3g0enZrWUN2T2FHYXF1ODUzOUZTZUIzY085?=
 =?utf-8?B?ZmhpVkhqejFHMUtoc25BSDVuMmRGZUpwenhVM0M0NmtzM3d3d0dQUCtIVFpp?=
 =?utf-8?B?bkxnVWd0WjFqak9qREVoUW4vdTc1MjVFN2sxQVJFbHdVaC9hVlJ5VmVqZnBv?=
 =?utf-8?B?eWJOT013Ny9XNUpScFphQThtZjhNcWNGNjZVRDUrOUNMeTdWcWg0WVV1ZXF4?=
 =?utf-8?B?LzBBWlBlVXczUktBUnYyekQ3UDg3eE4wR2toY1JNRUFESlA2MGgzK2Z5UFd6?=
 =?utf-8?B?bWZZZFdhRURmUjNZMWxkVk16UUp2YmhUSTkyK2tjZE5jVlRLU3BoQVFpZ0xp?=
 =?utf-8?B?YzYxZTBpOFNMQ3o3SWJ3S3ZmVE9OeGd0Q04xZ2s1L2hRYnNiSVk0Z3lVOTZN?=
 =?utf-8?B?T3d6M3dBRC9mQTB3aDlEeEV4MXV1U05HN1dlcytVbWdqZzEvKzdrTnJCcWlM?=
 =?utf-8?B?MEZ1ZDcyQ0ZBVnRKQ0hTV3lQV0t3ZDRaQzI4ZHdUZU5IcmtFMFhJTFh1VEdn?=
 =?utf-8?B?TFBJdkxTUWZ3T2JLM2ZlNWtVNEg2UGh2TDVpeDZ2WjIwUXF4ZzNqZUo4QWQr?=
 =?utf-8?B?R0tEeDlDbnA4THRsUkNNZDhIOW1rT0p6RjlRekVMSk5TVnZlNU1GaC9vdEFw?=
 =?utf-8?B?WTlPa0M4RUN1cCtxLzN1T1RDODdxa0tNZHBvcGxlU3ZrcHVPcW5vTVE4MkNI?=
 =?utf-8?B?RERzWFoxWHdBYkVudXh2dUxtWjdtbzczMTFFYlErU3d3MUp1Qk52YWw3NnVa?=
 =?utf-8?B?NkdLWWFXb216R1FLUnI1Q3F4UzlpTHZZdkZqMDRhZXdLMEZ6UzNKSWtPUk1a?=
 =?utf-8?B?Tm9mWER2WnNDR3VMclNUaURXNE9MdFg4RnFtQnEvR2c1ZG5nT1NzU1lLV0Ux?=
 =?utf-8?B?ZytZOEQ2cWxWbGUzRUlJQ1VDM2g5L0VyWUpYTXM4ZXovWUNCVjEwNFJQdng0?=
 =?utf-8?B?WjRRWlVTdGthQWpGdGhleXoxdTZFbW9mUnMxeTRETHdobmEvQ0pWMktieEI3?=
 =?utf-8?B?V05uM01VTElidExXTjYySWF2RVJ6ZzVjdkg4TVByMDJKd2oyb2cwMC8wV3R6?=
 =?utf-8?B?MnJMc3prVWxwdkNUOTB2QzV1TDM2THFrZm8xRmRuWld6N2NjRjNTZXdTYitT?=
 =?utf-8?B?WjZWaFhyd2ZzcElrRWZaK1liK2FnWGhqdDBJWFhJQWhjSDh5dVlkcW90UkVG?=
 =?utf-8?B?WHVpUjhCUVRQVTAvYUJMUHlKQ2EvYTVxQjV5SXNxWjRPZmQ3Z0FsZVRUSlFS?=
 =?utf-8?B?di83c3daKy9FT1k4MDR3d1l1Z0VDazBmRWorR2lvUzVEMW1YWXgweXAzZk5X?=
 =?utf-8?B?bW1uOGdaUW9LbStqYTNkR1dnaURvRlJVWlhCalpGekpzZDFpSHFXTDE5cUR1?=
 =?utf-8?B?aGZraXJTSUdvamNtTC9wcWxwTEg3eVpzazdXd1JzMWt3TWVhVDZGTWtVSEhE?=
 =?utf-8?B?ZVRtdFJvQkc0cUlOUGF5UGtWajFtODQvT0t2QngzdUd2OE1ydlNYeDA1b0J1?=
 =?utf-8?B?dWRBODArb2tJalYvQkNXSGxITkd1SUxrUGtHNG5rdlVodGNOSnZjcWlhblQ3?=
 =?utf-8?B?RTFzWHRXRnU5WnFiYkNROUx0UFg2dTJuNzNEZDFxTUJ6ZUJjZDNrQkZ3bWVU?=
 =?utf-8?B?MlhIZFE4M0tkWUlNd1kzTDk4L2RZVlpxcUQyVkpZcWEzZTlnVitFbC9pRjV2?=
 =?utf-8?B?MkpZQVB2S051dzZZQ0thRzNST1NuNVdYbmZXcXRrWjRBVkQxaVMvR0ZDb1Zr?=
 =?utf-8?B?enA3enUzeVR5NnpxZjloYUlYNlNDZ0hvR0NpTDcxUlQvRTgwQXh0b2U3VjJn?=
 =?utf-8?B?TW1ydDNzdUJ6ZTlXT3lHUThra3o1TTk1TUNmN0JXNWtzTGtwN0ExS1Z5eTFI?=
 =?utf-8?B?bjhlZGViQXpzcEJQbFlFeVhtdWY5U3RyNVF0QTZLRFRzQmtTRTJYcnJ0eVNw?=
 =?utf-8?B?OFd4UC9zRmxKaWdZcndrdnRQVnQ2aHZwY0RFNU00UE54Q2IrcFFUdm1QTXQr?=
 =?utf-8?B?L3hkV2lVTlhaKzBCRVJ0U29yaWNiMGVvWGZjYXVmNm9HVkpEV3BoVVdveHE3?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vEmWmJmujEIzYVzT1UblD7/vaRH77AGMVxpta730pjrrawrk7F6HjSmTMglvRG9zSTZWJjM0DMk42+efzxznb5wYrJNBU3H5wU2MafMbTKtNQjqv6GJpQ1cdS98eXkwmyC5a7vchiJUhAnFyGz2/BUcGB7EFc2TmSgfw1Qv43iET2s5qTN2q0YS0Jnd8jetmjCbbEvv/6WZ3rLJ+6U9JjD6dlmaLlSwmOPqvMIFyGD6JeykP8PNP/m4RTjvP+2++VXXSzl4fXYlIxRf+Gf1t2HfbtTquay7RWLdPPJDX8PZ6QQ8BsJgbJGZHlPYcUdbcrWWWolXByZvHN1kvrc4kAuppsyMg/SlZ2vMQkjb+hKBPnqGVqMnvekypXzEU3t/2NchEFwbG+6xrCjwEnmHh5pGxVED/4tSSg4TwRKGG/Qm/9rptvIlqmVgSwsqaDO4CX6XNxT9Bzs6wbG8vRequdhi8UaIhhl0jiyj7fvtYqoaTPuz/eSwH6Ov9w6My9+WfPqYa3GjU51hq5kSu46EHtDx+eyFyYIOHvUvZISTM8QPayxubEWAxtyQYvPQ/TDwNjeVQ2MB4Yh/Ewic+E9EcA6AtWPntNpNlXocdiyRmkds=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf59cc16-0220-428d-d2ff-08dd985a1e98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 11:24:58.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qC325Kzxo3uZc1/ZbPCJ25SKbZSSwSn3+cYvRHwZucQ1HcgQUoIMFi297+TXwgNmoRBYWJI4TQao7bdOahkI7pJuyf24TkKfXFgqpKT09X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210113
X-Authority-Analysis: v=2.4 cv=ebE9f6EH c=1 sm=1 tr=0 ts=682db80f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=p0WdMEafAAAA:8 a=yPCof4ZbAAAA:8 a=DzrRH8dLpRCMUUsPhrUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=nT7k2FPyCkIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDExMiBTYWx0ZWRfXy0HEpKwl3dT3 my9pYFjy3HGExmQGEL8iyPms1hK4e/D29pzpnhqMj0Srlv1nYDP0EVqo+BFGSs15R1oSOweCdnR 3l9c4Yxh0/C5DDTp1zGSFBX7zVMBSUvblGmDxKw3dyqLkGxQHgM21S3eVAYMQuIvylsFytJI8Tc
 3xwkxHOIXFvPjAg0wht2/3wX3AM6E66mYanRrNtc6Z3iYSCuHmxw2T5Hg9vyKz+qvIMyxmSwTFK XIB0CHUgaT/yK4zfExZoGFe1rbE3gQPIVwzNO29EzHfGDg2SfPyt04wzCS924k1JuOyP7S9TCXf u1x85weRkdwPqxcILj6dERB2ecP/xmDuOdC3jEMwg5f2TtJYynmneBrOUxrr0+bYrAgMaetcRsz
 n0Nh9ymZUyioZgACgj1NNZ/Gbi2fXXsVpw0lYlcbxfeE1N5grO+2bQO09ixvMD/zbyk1+1nU
X-Proofpoint-GUID: qVtVjTKyTHBZCHQCVpM7W3bG0hNHkNqv
X-Proofpoint-ORIG-GUID: qVtVjTKyTHBZCHQCVpM7W3bG0hNHkNqv

To start with I do apologise for coming to this at v6, I realise it's
irritating to have push back at this late stage. This is more so my attempt
to understand where this series -sits- so I can properly review it.

So please bear with me here :)

So, I remain very confused. This may just be a _me_ thing here :)

So let me check my understanding:

1. This series introduces this new THP deferred mode.
2. By 'follow-up' really you mean 'inspired by' or 'related to' right?
3. If this series lands before [1], commits 2 - 4 are 'undefined
   behaviour'.

In my view if 3 is true this series should be RFC until [1] merges.

If I've got it wrong and this needs to land first, we should RFC [1].

That way we can un-RFC once the dependency is met.

We have about 5 [m]THP series in flight at the moment, all touching at
least vaguely related stuff, so any help for reviewers would be hugely
appreciated thanks :)

On Wed, May 21, 2025 at 04:41:54AM -0600, Nico Pache wrote:
> On Tue, May 20, 2025 at 3:43 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, May 14, 2025 at 09:38:53PM -0600, Nico Pache wrote:
> > > This series is a follow-up to [1], which adds mTHP support to khugepaged.
> > > mTHP khugepaged support is a "loose" dependency for the sysfs/sysctl
> > > configs to make sense. Without it global="defer" and  mTHP="inherit" case
> > > is "undefined" behavior.
> >
> > How can this be a follow up to an unmerged series? I'm confused by that.
> Hi Lorenzo,
>
> follow up or loose dependency. Not sure the correct terminology.
>

See above. Let's nail this down please.

> Either way, as I was developing this as a potential solution for the
> THP internal fragmentation issue, upstream was working on adding
> mTHPs. By adding a new THP sysctl entry I noticed mTHP would now be
> missing the same entry. Furthermore I was told mTHP support for
> khugepaged was a desire, so I began working on it in conjunction. So
> given the undefined behavior of defer globally while any mix of mTHP
> settings, it became dependent on the khugepaged support. Either way
> patch 1 of this series is the core functionality. The rest is to fill
> the undefined behavior gap.
> >
> > And you're saying that you're introducing 'undefined behaviour' on the
> > assumption that another series which seems to have quite a bit of
> > discussion let to run will be merged?
> This could technically get merged without the mTHP khugepaged changes,
> but then the reviews would probably all be pointing out what I pointed
> out above. Chicken or Egg problem...
> >
> > While I'd understand if this was an RFC just to put the idea out there,
> > you're not proposing it as such?
> Nope we've already discussed this in both the MM alignment and thp
> upstream meetings, no one was opposing it, and a lot of testing was
> done-- by me, RH's CI, and our perf teams. Ive posted several RFCs
> before posting a patchset.
> >
> > Unless there's a really good reason we're doing this way (I may be missing
> > something), can we just have this as an RFC until the series it depends on
> > is settled?
> Hopefully paragraph one clears this up! They were built in
> conjunction, but posting them as one series didn't feel right (and
> IIRC this was also discussed, and this was decided).

'This was also discussed and this was decided' :)

I'm guessing rather you mean discussion was had with other reviewers and of
course our earstwhile THP maintainer David, and you guys decided this made
more sense?

Obviously upstream discussion is what counts, but as annoying as it is, one
does have to address the concerns of reviewers even if late to a series
(again, apologies for this).

So, to be clear - I'm not intending to hold up or block the series, I just
want to understand how things are, this is the purpose here.

Thanks!

> >
> > >
> > > We've seen cases were customers switching from RHEL7 to RHEL8 see a
> > > significant increase in the memory footprint for the same workloads.
> > >
> > > Through our investigations we found that a large contributing factor to
> > > the increase in RSS was an increase in THP usage.
> > >
> > > For workloads like MySQL, or when using allocators like jemalloc, it is
> > > often recommended to set /transparent_hugepages/enabled=never. This is
> > > in part due to performance degradations and increased memory waste.
> > >
> > > This series introduces enabled=defer, this setting acts as a middle
> > > ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
> > > page fault handler will act normally, making a hugepage if possible. If
> > > the allocation is not MADV_HUGEPAGE, then the page fault handler will
> > > default to the base size allocation. The caveat is that khugepaged can
> > > still operate on pages that are not MADV_HUGEPAGE.
> > >
> > > This allows for three things... one, applications specifically designed to
> > > use hugepages will get them, and two, applications that don't use
> > > hugepages can still benefit from them without aggressively inserting
> > > THPs at every possible chance. This curbs the memory waste, and defers
> > > the use of hugepages to khugepaged. Khugepaged can then scan the memory
> > > for eligible collapsing. Lastly there is the added benefit for those who
> > > want THPs but experience higher latency PFs. Now you can get base page
> > > performance at the PF handler and Hugepage performance for those mappings
> > > after they collapse.
> > >
> > > Admins may want to lower max_ptes_none, if not, khugepaged may
> > > aggressively collapse single allocations into hugepages.
> > >
> > > TESTING:
> > > - Built for x86_64, aarch64, ppc64le, and s390x
> > > - selftests mm
> > > - In [1] I provided a script [2] that has multiple access patterns
> > > - lots of general use.
> >
> > OK so this truly is dependent on the unmerged series? Or isn't it?
> >
> > Is your testing based on that?
> Most of the testing was done in conjunction, but independent testing
> was also done on this series (including by a large customer that was
> itching to try the changes, and they were very satisfied with the
> results).

You should make this very clear in the cover letter.

> >
> > Because again... that surely makes this series a no-go until we land the
> > prior (which might be changed, and thus necessitate re-testing).
> >
> > Are you going to provide any of these numbers/data anywhere?
> There is a link to the results in this cover letter
> [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput2/output.html
> >

Ultimately it's not ok in mm to have a link to a website that might go away
any time, these cover letters are 'baked in' to the commit log. Are you
sure this website with 'testoutput2' will exist in 10 years time? :)

You should at the very least add a summary of this data in the cover
letter, perhaps referring back to this link as 'at the time of writing full
results are available at' or something like this.

> > > - redis testing. This test was my original case for the defer mode. What I
> > >    was able to prove was that THP=always leads to increased max_latency
> > >    cases; hence why it is recommended to disable THPs for redis servers.
> > >    However with 'defer' we dont have the max_latency spikes and can still
> > >    get the system to utilize THPs. I further tested this with the mTHP
> > >    defer setting and found that redis (and probably other jmalloc users)
> > >    can utilize THPs via defer (+mTHP defer) without a large latency
> > >    penalty and some potential gains. I uploaded some mmtest results
> > >    here[3] which compares:
> > >        stock+thp=never
> > >        stock+(m)thp=always
> > >        khugepaged-mthp + defer (max_ptes_none=64)
> > >
> > >   The results show that (m)THPs can cause some throughput regression in
> > >   some cases, but also has gains in other cases. The mTHP+defer results
> > >   have more gains and less losses over the (m)THP=always case.
> > >
> > > V6 Changes:
> > > - nits
> > > - rebased dependent series and added review tags
> > >
> > > V5 Changes:
> > > - rebased dependent series
> > > - added reviewed-by tag on 2/4
> > >
> > > V4 Changes:
> > > - Minor Documentation fixes
> > > - rebased the dependent series [1] onto mm-unstable
> > >     commit 0e68b850b1d3 ("vmalloc: use atomic_long_add_return_relaxed()")
> > >
> > > V3 Changes:
> > > - Combined the documentation commits into one, and moved a section to the
> > >   khugepaged mthp patchset
> > >
> > > V2 Changes:
> > > - base changes on mTHP khugepaged support
> > > - Fix selftests parsing issue
> > > - add mTHP defer option
> > > - add mTHP defer Documentation
> > >
> > > [1] - https://lore.kernel.org/all/20250515032226.128900-1-npache@redhat.com/
> > > [2] - https://gitlab.com/npache/khugepaged_mthp_test
> > > [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput2/output.html
> > >
> > > Nico Pache (4):
> > >   mm: defer THP insertion to khugepaged
> > >   mm: document (m)THP defer usage
> > >   khugepaged: add defer option to mTHP options
> > >   selftests: mm: add defer to thp setting parser
> > >
> > >  Documentation/admin-guide/mm/transhuge.rst | 31 +++++++---
> > >  include/linux/huge_mm.h                    | 18 +++++-
> > >  mm/huge_memory.c                           | 69 +++++++++++++++++++---
> > >  mm/khugepaged.c                            |  8 +--
> > >  tools/testing/selftests/mm/thp_settings.c  |  1 +
> > >  tools/testing/selftests/mm/thp_settings.h  |  1 +
> > >  6 files changed, 106 insertions(+), 22 deletions(-)
> > >
> > > --
> > > 2.49.0
> > >
> >
>

Cheers, Lorenzo

