Return-Path: <linux-kselftest+bounces-16695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462B9964A68
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE87B28288D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73B1B3740;
	Thu, 29 Aug 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PkjbVBGx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CyOh1Jnn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D901B373E;
	Thu, 29 Aug 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946281; cv=fail; b=kea7v0VdAzY99FvU6U59CCYzN9jRMUs6+L6UkiozDFc6oL3g1YddU1QX/k/m4WDBnpf9pkb7LvU+CJD0MtmVvGR5IpNw2mom0UAotSRBE75JZXyeHIP45/NdGDzZ1j602r3xHDvEyDrejwzsOcYbxnNJsYbs3COCgYNafaACE20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946281; c=relaxed/simple;
	bh=rOYQdvMI7O2aapgJjHnrhBqKIYBGpRV1IqYHJp49O5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wns/FW6PbbVgOkzs3MfHGUB8fQhNgY65fj1fJNjgUCSW4AXjXsrEP/mSuxNfsG9dFjDZEey0HvHdsm+l/z/4j5EX5jw/IMXHRc/W033ifbQerUcU4pOArI7YLhwlbE+075rXxzBJVPUm/tDh+sB74noIUoJrhG2ldCNQJNQakU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PkjbVBGx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CyOh1Jnn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDsZtv019023;
	Thu, 29 Aug 2024 15:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=rOYQdvMI7O2aapgJjHnrhBqKIYBGpRV1IqYHJp49O5w=; b=
	PkjbVBGxr8cOIC+T465MKlBvjT/pnsgDMKIV8lAlTfxqrdK7kkAFGrW7s/JbIVoE
	srkgBLpcI2bS6qtD5IF9fvEHc6sfrRgUKhEtqKsPK+3DQ9kBQ7iUikWUvFQ3bK7f
	N9GEsV361cGB1+r6G+ttpP5lnMxQvJxVq/fWgmN3ey8YuEWH/hGkv+hMIBsVzlp+
	hKMFzYX4A7HwcES5SZt0Zq73DtR3aum9yD1EDcMVLkGFlEARvG77v6a0GzCgrNlh
	YeK54+rs1aKyzen7/XyU3X2rlRnSJiErrB3+84PVn57i9LuFCTUGmaLpiCvVpV+0
	W2bF1nAsHDQXpFrbEaQ24g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugvk09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:44:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TFMdq3036621;
	Thu, 29 Aug 2024 15:44:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jndjjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnLy1dP8ilHMf93hNSwE4pCieWIUqaIuDjCgfBq39M4zLhAHpT2Kjzcft7O1Vt0CFVYh1tl1/1+uqcGcM/5bs6AA3ltaG+AVSzRS8w8TAYJ28hNuSAXdeIEMgl0AHUwYTv8zUyfIlYWDIJ2pOuQo0zOzV87L33GFJNyDWFypTKpeoIul2XH/kaLzjfKs5qpftFZUr42U7+VjzmiWGCWX+MIBHgjUGKSiLuaJiAZYvahSULfV2CPIrd3jWEdQRB79BQSBAl8fYLSuLHgVZEN0nRvDrPo4+hhGCjnF2fdgT9nnvgucpgCz+YBa7u/Kduh8ND3F63Gehlhguo7B7lrrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOYQdvMI7O2aapgJjHnrhBqKIYBGpRV1IqYHJp49O5w=;
 b=sPfcPF1/l3uw4pozgkoXpjfslzBSvOwQ4MozwSToqfaRhda1grmoat+NvumO1YiaLyaERr3ixD1PbKktKvq1XI4lBFmWqMk1s+gS3OCzgj3shse31tWyMWEcsGFQHuxQNyeL4dtC2gUnDrPptIjxd2aubc7Y2oU+0vINCmdO1o34J+muuvfCD04iQVA+Ge3TfiSjH0Drczr1jjO1zSDRc7WSFwj4Kv9hxyMFGUjp3ufv+pzZkrDhOvtkQRP5otxy9JMY7qfxygAepiF6nkSDub9evXoQioQ8a0Nzii3eSox2ee9COmPWvA+ZHAntOyW1JdODDeEnji2WaZjw9ydo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOYQdvMI7O2aapgJjHnrhBqKIYBGpRV1IqYHJp49O5w=;
 b=CyOh1JnnNpmwM9xmMzD/Qog7I/bu0/+ZMlY0jGx6F2sA0LVLW2NR7/KBUj0YTNVOaoH//db6THHGzNouWPxa5vAvybFQbqmD9NVx+f9UuLzFljs5rUWaP1j85Zz4YL4qnW/24QF0/wEgyHfRtgRVQQgDwnGs9E1ixsc6ZwTpNS0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW4PR10MB6419.namprd10.prod.outlook.com (2603:10b6:303:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Thu, 29 Aug
 2024 15:44:19 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 15:44:19 +0000
Date: Thu, 29 Aug 2024 16:44:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        pedro.falcato@gmail.com, rientjes@google.com, keescook@chromium.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
Message-ID: <5a312d38-4591-47b1-9a6c-4a7242dbe20d@lucifer.local>
References: <20240828225522.684774-1-jeffxu@chromium.org>
 <20240828225522.684774-2-jeffxu@chromium.org>
 <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com>
 <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local>
 <CABi2SkVe6Y4xypBw0n8QbqKJgsfy9YRNJWvBZ3bjTa=-Z5Zn2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVe6Y4xypBw0n8QbqKJgsfy9YRNJWvBZ3bjTa=-Z5Zn2g@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0370.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW4PR10MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: de59a755-12e8-419e-e34d-08dcc84171fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGczZHhVMmxZeFpWcHZES3V3ZGZmNjRrV3F3b1hodDlwNElXRGlEc20xZS9h?=
 =?utf-8?B?aGd1WXVPTWtZZ1hzZmgyUThUYXJuMWJyK0xUWE94T20wSDlMaDdiSHA2N2ZP?=
 =?utf-8?B?cmN4REFoNFdaSHVTOUF2TktHSGJDaHp1ckRKa1dENkpjbHhEdERmUUdCVEhn?=
 =?utf-8?B?akZrdS80Z3VnYm8zR2srRGMwZkx4QnBTN08rbWVhTGlZMURXOEg3QnpvTEww?=
 =?utf-8?B?dFpwRWFyVjJrOVh0aHBpT0ZKSitQdFdFYjJrODM0Sis1MmhHWXhxTWFxemdu?=
 =?utf-8?B?WmNIMHRaaGs4VmZPTXFSMWE5aVVJODFFY3NIZCtrZTk3UXhzdWxTNVMxZkZ5?=
 =?utf-8?B?R09IK2tpS09zSWRHVHlPTXFiR1JpTGMxQWV3bmJCdlFvNEZCK3VVRThIenVW?=
 =?utf-8?B?WGIzWW9XTVhJb0dBVWpUdlRIMHhIdmJuKys0Rk1Bdk1sakJ3aFBFMmF6aHpq?=
 =?utf-8?B?S0VnMkkxMnl5T29tUHNjSU9LTGdGcWJUSnB0QzNmSFo1YnBVRVk3ZzNXckpr?=
 =?utf-8?B?TnBzZmdmY2M5SjFiWjhFU3F2UE9LVjVXRnVjcmpCVEFkV0VIWGNmNVFLQ0JT?=
 =?utf-8?B?b2pyOGlsYS9pYkRKWjE4cUlZK1lXMDRVYnd5cndkRkl0cFViemFPTkJrYTMv?=
 =?utf-8?B?L3ZBM0FZQ1AvUWpGd3oxWHBOSWFQVGplWGdIK1JsZmJBNSs1bkNGM3g1SzZr?=
 =?utf-8?B?RVpUMUdFaGN1S1JMdi9YcWR1MkNRcEMwVGhJMU9yVVRLeE5ncG1hQTE1dVIz?=
 =?utf-8?B?NUJ6cFZWMUovQytvU3daWWRsNkpPRHo1b3hFbEFXMnZ2cG4yeENseWtWUG1E?=
 =?utf-8?B?Rkl5bklUd2UwcEpHdUdBZkVhekxVdTQvcktCZGQrMCtHYlpHZVNMK2RoZ0E4?=
 =?utf-8?B?cEV5cmdUMk5TY3FiTTJkbHVvVTRhWnExSTQ1Unk0NVJUdDVpSGxicGhrSHpp?=
 =?utf-8?B?L0JhQ1Y1Q3EwN3Z3VUsvcFlwMElya2R6bE9xaFM2ck03YzFaZXNIa0tXQllj?=
 =?utf-8?B?QjNZWVlSUEI0WDVCQ0llNGVRYjdXVVNOZ01OUmwxeE1YUkdKU2F2eHhTVEdZ?=
 =?utf-8?B?ajNKZzlPZUxYTkUwR0RJZjR4Q29UelRCVy9qQVMvd0tDaVRJU2hUZ1k5QTRa?=
 =?utf-8?B?OFpldXFLRm5WL2w5Y0RYV2c4QUVRQklieWIzWmlrcmszWTBrcmQyTUp4OW84?=
 =?utf-8?B?K3liU0I5bmowcHk3SlBLZFNxSmVBSHJQa3Z6c3pLZEp4RmF1bm5rVDMrOGps?=
 =?utf-8?B?TzN3V0NzNkZuSjc2b0RyU0VpTzhCNWVzNTY1dGJ4MzQ0Z1NFLzE3VnZUL2NH?=
 =?utf-8?B?cWhLckhKcHhNcWlObm9vK2JHWlRPc0x6dkl2Tzk2T0xWUitzdG83TTRrKzB2?=
 =?utf-8?B?S2ZxdEZqWEJaOUlXZXdrajUvZzBYek5SUDFhOFVyZk9SWGdCR2lZUGVSYXpT?=
 =?utf-8?B?a2tiOWJUa1lMOE9mNjh2RHJyRjZQWG0yMU9oY1BDcnRnQzEycm1qd21rWGFV?=
 =?utf-8?B?WTBjdk9pK05NTWhyc3A1REhJSEF2eVlLZEcvYjVDQnkvZ3FTZzBCUHR3aVlp?=
 =?utf-8?B?QkdYMm9Gcmp0WUFZMENaTFd3dWs5WW90cnJUeHVZRW4wNitTdVFMNkZ0Z3dS?=
 =?utf-8?B?b3hob0JORnY0dmZvM3I4UlFBUmcybFBxdUJHUi9UOWtzbjlNSmhTU2JKTzhX?=
 =?utf-8?B?UTVLL2Y2WXBZMTBxSjUzQVVEZXQwRXlSUU1sWDlFRVl1Nm80bGZRdW1JZmtK?=
 =?utf-8?B?VkNPenIxMVJmKzlXdjMwc0ZJMFNMUURoR29FU2UwT1BVWUc1Q2tjZFdCd0Vo?=
 =?utf-8?B?VTJFRXNQY0dzSE1sbnVUZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjJ4TGMzWWw2ZjMvcnp1YWlpWHlnejJuM3JrMHd0cTFxMEs3Q2dDTW1IU2JD?=
 =?utf-8?B?QWJab0dQK080ejZGZ0d3c0gwNXFWZVJtOE51NE9RRDd0azNwekFqNDQrTTRn?=
 =?utf-8?B?QVU4UWVQa2p1ME4wLzNHeWw5eHpnUTFyY0VWOGk0UmVXejFoQVd2bmVnSTZK?=
 =?utf-8?B?SGQ1SkpBN1JMZ1paWk1URWIxakUrTFY3OFh1ckdyZ09sRHQ5T0xpUFhPdGw4?=
 =?utf-8?B?UkxSR3ZrejNBbXMvbEhWZHJQMU1qbGRMeS91V0FyUzVnYkcxUGpsejQ1MGlP?=
 =?utf-8?B?QlRPMjVUcU13U2VQd3ltMnhOVGZ1N1BUbnFZdEdVSi9pVTRDbkRKUkZUZnB1?=
 =?utf-8?B?RDRaeTdrZFExZEtBS2dCK2hwUU5EMUJxdGdrYWpSNjJXbXVScTZoRXlpeklU?=
 =?utf-8?B?ZkpLdENFTWo2UmwySDlkTnBWTWpZTUlGS1VYV05CbW1CMHZMQ082TXlOYUFL?=
 =?utf-8?B?Kzcxanl3eEpwQlBMWDFBODhKeVovMDk1QzU4dDN4eDgvbVUzdUhPRE9DM2pa?=
 =?utf-8?B?RThFMHN2MFZ6WjE3RmtTbkhUVVFSSHVpSTJ6VGZualRoYnNBUGpuNDREcWVu?=
 =?utf-8?B?TFZmemNlUlAzMFp2LzBQS21NVzBzNEpVUHNqaFJBemR3WWdyUmFHVkZVL29i?=
 =?utf-8?B?dUF3SDAvKzZxTDlRU2ZsSjR3emx5WUtpTUE4TmVCUm9XaDVmNlVkeHBWeGl6?=
 =?utf-8?B?MHNCajFWK0Juc25za1VxTG5taUhkY25RYkt2NW9UYjUxWVV1K094dzA5WDhz?=
 =?utf-8?B?UXNPL3pCN3VteXI0YjNGaWFYbnN4SkZMamFyaEFlcmNGWkpvNmlSYjZFK1VT?=
 =?utf-8?B?emJBa2VtTVJFRjlxS1R4OUtXcW5aTm1QNnFDYktTSjZZZm9OSDIram9qU0Yz?=
 =?utf-8?B?czRubCtaM3hFbkE0UzhwTURoYUxQQVJYekhRV3NuS0ZUdER5UnAxMzNYY29J?=
 =?utf-8?B?amFHMTdzVFBVV3RiNG4yS3lpWjBzUXY1bWZDZjM3TGpwUjQyUkxDVWtZb1RR?=
 =?utf-8?B?SytReEpVWk9tRTFXZXZoZEVrRlRMLzFtd2RQVCtKQlUyeXRQZlk1MjU5d25p?=
 =?utf-8?B?MXJPYXR0SlhkVGZEK2NiR1pReDJ5bVNXaTFGRk1TVnp1aXRta2kySDlBL0lk?=
 =?utf-8?B?TWR4dVo0YzRucmM2L3pIN201QXVqRTJWaU9OUUFETjFQQjdyRjBNekhNYjZQ?=
 =?utf-8?B?Y3pnbFlvU0kyTURTL2dmemNOQVl3b0JJNm5QMkwzcjNYWng3MHJ3QW5RaHE4?=
 =?utf-8?B?S2xvaUcrZDFtMXBnSm5GN2RqVFFhbkFMNjU5dTlONHp2S3RTNlJOQytVM1RW?=
 =?utf-8?B?VHJXd3ZyZDVDM0VBSDM5aHI3aC9QNnRtOWpJWWM3Z1VENXNHQm5pR1dYVXZT?=
 =?utf-8?B?ZmQyT3FrdEtybGJTNUExUUd2Tzd4WWtlbkJVTCtNbGRBSDArc2JIY2cyLzNY?=
 =?utf-8?B?a2hQNm0xOERCak03S2RXTXZBcERIVWROZXB4bTdjSnQ5Ump2K09FT0JNUlZy?=
 =?utf-8?B?Z015NmJTVmhORmEzUUpwdDJKSy9CQVhpaUpTRUxiR3BNU3lpdzBHRGQvdEZG?=
 =?utf-8?B?NGhqN1EyYWZ0bEdXWEJneFpCZTNROUlOeVowWWZaTVpHd0t4ZUxWb3M3VStn?=
 =?utf-8?B?N0hXZ1k0VDdTMTVaZjlzWU1wTytSMlJFd0JFRW5HZkxJc1NJTGVZNldWZ2do?=
 =?utf-8?B?bGFHeWsraVVXOGQzZ0V0MXozRTQ1b2MrMWNNc3hXMitUM1hEb1c2RmdpcWhL?=
 =?utf-8?B?UVVSSGRTR1RKRkZVdkxPMjFldDBydDR1OUpyUlRCclBtNXBOdzl5eCs0Qm5X?=
 =?utf-8?B?NGgrVlpSTlVrUDdJR05KR0VJQVkyYTFFMzdXcGYwb1ZQb2Zha0lrKzRNeHpi?=
 =?utf-8?B?cEhoV24wYUxKOVhNTUhZdElzcUZkd2VIcVZrTWkveitjK1gyRFY4MXE0VVNk?=
 =?utf-8?B?R0VUNllOOU9aNkJyL1hLUE1nb3RsQlhXQ0pEcUJybXE0ZFhoSzF3eDJ4cThQ?=
 =?utf-8?B?WXZzMXdTU1krYm9rUGo0YnFrKy9FZzFleVFvRWxXN2daSTVMOW05MWgzWTZH?=
 =?utf-8?B?RWZpL0ZiVDZwcytnWGwvMGZOSFZpQjZiOUpZZmpOelRUVU5wc1FoZGQyemhJ?=
 =?utf-8?B?RzA3eWgwTXhwRkFYYmtHMWVwOENTcGdPVEprVmZ3eTNoZi9QK3BESitGakNP?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ffuoWNC7qbNQhJbPI/zUOqdGOZqP8yZ5WCODE02/KYZhkMaK2Qf1RpknU2tRzNwcTkDzWe5Nz/ybG7gzimtfaqMwtYANJyxTHuS/dgeMPFCuAgIZuuF82M8zvtcGTbgXF31dtCFglFeo44v7FBVF8gZjCEA3vMmtqnPL7XGuwls4wbT1kBlCsLssmsfvfQra8Y5S93vHvuT4OM5BASl29VBvoy6iNJAoEzPgkuiSJkOcdUKeCB6NDog41Z2LAD0MurYfTuvYXAFKHO95lsx76zggK+oF+fKwuw89kl5/QdZH3PvzLhodZTlOzTNfFtp1V2IN+71AaOFngRMPdLw99gfWufA7btwt7B9pl7+KOv7jvfLDwsZQ+ZLmtBG4rtBXhfA1q7MZpW4+EvG82qG4fzsOSL0GbUWUkftfb5vY96zi6RTNsiJ7iOdxtisf2sJZ5FR/tETsy3OFdG18l20k3+jC9c9etnZPeXhbYDqdQkfrc4Ce3anQX/GdIsqWZnWXhUWmayeZ1zEGYMwb5M00Iirx6dTO0zI2XouatKKth1hck3AJouxBiLloi/TcDkjszeg/VJWSWED+2d2lsQdAuvp8bamFcPz9b3NhYfZgvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de59a755-12e8-419e-e34d-08dcc84171fc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:44:19.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FTpnITIeer798eLCqka4wkmRgXJU7mKC1gM+QICzMESVQonP9V60A+CBp0EVLAgYsUn0txItaalxWwVYNApRo2tgcGsnP6eLMXVjSDIsDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=715 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290110
X-Proofpoint-GUID: 5aCy0niCN7035NcpDTI2xridMgYgoRKi
X-Proofpoint-ORIG-GUID: 5aCy0niCN7035NcpDTI2xridMgYgoRKi

On Thu, Aug 29, 2024 at 08:30:11AM GMT, Jeff Xu wrote:
> Hi Lorenzo
>
> On Thu, Aug 29, 2024 at 8:14 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 07:45:56AM GMT, Jeff Xu wrote:
> > > HI Andrew
> > >
> > > On Wed, Aug 28, 2024 at 3:55 PM <jeffxu@chromium.org> wrote:
> > > >
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > Add more testcases and increase test coverage, e.g. add
> > > > get_vma_size to check VMA size and prot bits.
> >
> > This commit message is ridiculously short for such a massive change, even for
> > test code.
> >
> > > >
> > >
> > > Could you please pull the self-test part of this patch series to mm-unstable ?
> > > It will help to prevent regression.
> >
> > No, please don't.
> >
> > This needs review.
> >
> > These tests establish a precedent as to how mseal should behave, this is
> > something that needs community review, not to just be taken.
> >
> > There's already been a great deal of confusion/contentious discussion
> > around mseal() and its implementation.
> >
> > Pushing in ~800 lines of test code asserting how mseal() should behave
> > without review isn't helping things.
> >
> > Also, this is a really unusual way to send a series - why is this a 2/2 in
> > reply to the 1/2 and no cover letter? Why is this change totally unrelated
> > to the other patch?
> >
> > Can you send this as a separate patch, preferably as an RFC so we can
> > ensure that we all agree on how mseal() should behave?
> >
> > Sorry to be contentious here, but I think we need to find a more
> > constructive, collaborative way forward with mseal() and to act with a
> > little more caution, given the problems that the original series has caused
> > I'd think this is in the best interests of all.
> >
> > Thanks for understanding!
> >
> There have been two bugs I found recently on mseal.
> One during V2 of in-loop change and the other mentioned in 1/2 of this patch.
>

Jeff you've ignored pretty much everything I've said here. This is not
collaboration. And you keep doing this + causing disharmony among other
devleopers. It's getting tiresome, and you need to do better.

If you insist on review for this patch as it stands - NACK.

The commit message is ludicriously short, you've not sent the series
correctly, and you are ignoring feedback.

Resend this with a substantially improved commit message and ideally some
actual comments in your tests rather than a giant lump of code which
constitutes 'how Jeff feels mseal() should work'.

Then when people give feedback - listen.

