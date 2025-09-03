Return-Path: <linux-kselftest+bounces-40710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC356B42B5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 22:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938104863AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 20:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A12E8B84;
	Wed,  3 Sep 2025 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZdwbNrwL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HhEcRJC3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F3292B44;
	Wed,  3 Sep 2025 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932731; cv=fail; b=I6T0GJ50C1dKWaPq8IHP8q0Qk/DPhYnWlrYxkdqhs7ZpNApQ/KZ36UL8lwXFhQQ/je3G3FppbnQHqBKtV99eK6hQ+JQ15/jRYvt1alunO8fhywJNjnDS2n0nGiBEiBHbQc64kOAWvDK8CA66WJ9SjqtB9A+fBUkOCSUeMwKW3Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932731; c=relaxed/simple;
	bh=HHx+27zhlgVKcba4+1yFdRglxwzxY6HJIolJgb3ZdDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XQT9l40/r+8tpU6JEbjmfMdqsKiP8YfNc02MRmxHwLUqyXpg0u/g5NDpCFz4v2zlEAahReZLQpG85oHIt5VK3BtlCgC0l+r91Q0pSCr5YOEfDlbcbzZpICPSRuR833nNOV2NGfyr5KEZiXZKu263ANra0bI2vP8F2ZFITkYanEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZdwbNrwL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HhEcRJC3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583KnsfS007846;
	Wed, 3 Sep 2025 20:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=plG5/TdW4LkDtsR2B92XLC++CQNfyt2ZwzMROIBkKDk=; b=
	ZdwbNrwLEW1Nbu+O7ut98KjrbenQR+U56MyoQE2TV1NksDBMTWw766VbnC5EawOr
	bHM1ENQGLnltC5oy5nxuOpDVI9m4W1LLus5KGnd4SaGBFoiSMv8ki+JSrV3O6zSO
	crdt4xdRk7z+gpUIYKrbMkvDI8ghhMs/Pkl00C82LAmORmFk0i7x5hjyximjhCoQ
	Mmb9d7Ggq0+jFMHZHfbRN3idR5TEMZk9YhYPy/qeKR8vs000UeQg6F0URQ0BCRa/
	ZXMS6n67O+l+GdaQwAefi2vzdKwYYIMr83amYs1boDEXo4oEVx3U3gx/z1kMvkUJ
	2GIY9hnvcwuYbjGU8JfEmw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xw22r03m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 20:52:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583KjGs7040685;
	Wed, 3 Sep 2025 20:52:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqraj3pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 20:52:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxpABqgeBeE5o8BwpMh048JLXKi54XdXx9FIpe7RXTd60jy2J4WxZJB3GlMx7zh8EMYdvjyM7gvojCAYq47IlHEhba9Nw7bUPgXyLzFTcZb2ASHPsE9gnkLa7ZumenNFda9b+3lmFH3cBoAa5q2J9FsEiDOmm6y6Hkv9FU7g5fp+Ec00BgjsvbJHX/uVCcRi5K09mLIjCY0HUN8+D2e1aiaaKJR7efX9ieK2In5VxBRUeZ236BVK431S/FEMuUtyEXNjzmBBXHIQyZGZ8zCBaIsuHTKLnXGghQ+S9tmbAAwaDxEx6B591KxXuoxeh0psMyX8PhuPGwZyXIv0Se0QXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plG5/TdW4LkDtsR2B92XLC++CQNfyt2ZwzMROIBkKDk=;
 b=Jd9yFc61D5mNinPzy1asG7RDWA1LN6gjIPplR7/elG8QK6xIfrrj4jatgMzZcI88LLDFBOOVoWnpESVIXGd2NAYzt3i8n1dB/lu7NCNaeyjY9/p4sAv3cPnD1MntGNR3lCioy8ZgRtuRtm4ov75aWA0CDUPKeQAtFxMZX9agGGCulmrHE+6z0ERbVTNQQJTpI32B+wxHFFwaPMoLgnRiB/mCmHXDIcLF7/Y0Chh+uLRS9zjeM99fZIPae/jRh9Cp1wDwq4wpQZksg8Lsq0JQuuN4YKO7GfKkDC5uWyiN1H4cR8pYSbqIw1UhWA95UjidvW7kfCrD0x8flWOoo1l/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plG5/TdW4LkDtsR2B92XLC++CQNfyt2ZwzMROIBkKDk=;
 b=HhEcRJC3PBtlDR1H4GKkLrbt9OpV1GHU3OVWkxLKD8AD/i06Gj5E+FaDu00/SDUGySPBUqm3LWrAbC4nwgdU3/YyU4lQ7GLAuiJ7RzQ3iNpGXewkacMp8OBNciQXq5mkJR6mBNQM4GgRwFAW7k032J+Ati/6PXMOeOL6KIMnz7Q=
Received: from SA1PR10MB5509.namprd10.prod.outlook.com (2603:10b6:806:1f5::20)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 20:51:58 +0000
Received: from SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24]) by SA1PR10MB5509.namprd10.prod.outlook.com
 ([fe80::a9aa:1b53:1397:fe24%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 20:51:58 +0000
Message-ID: <42cf76db-6cda-4606-9128-6f433da57d48@oracle.com>
Date: Wed, 3 Sep 2025 14:51:54 -0600
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
Content-Language: en-US
From: Tom Hromatka <tom.hromatka@oracle.com>
In-Reply-To: <CAADnVQLve3KgrqNqSqVrmL-wz6Jj1QUdjAcE5P26Z4wvh9e4HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:930:12::7) To SA1PR10MB5509.namprd10.prod.outlook.com
 (2603:10b6:806:1f5::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5509:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: ec76bc23-547c-4193-3ff9-08ddeb2bb978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXlaMjZkSERyTStYenIrZ2NoS0pFaThudFk1blVpdXJmODB0azloanpINlBl?=
 =?utf-8?B?NHR5WUhhdS9NQTJpSWxLR1ZFc05Wekh4SVhaUTExZktJcU80NWNoeU5BRVdX?=
 =?utf-8?B?QmJ2Qjlod0tBaUtQR3V0UFJXY3RSMkRMRzZrdmNxZHZieXNXMG5ERjFLbHFu?=
 =?utf-8?B?bys1N0Z6OGJONm9vNzhJTVlJdGx6WS9LS25IZkJxZzdiaTE3dzFqd3VVb1pI?=
 =?utf-8?B?eXNlaWFUdENZNStGT09VVk11bkV5YjlBeDN0d3YzVk01RVhDSWdlT3pMNk45?=
 =?utf-8?B?Z1dsdXBRWXhEUlpsTFBGMlJrdlU4endTVXExYmhmcmpkT2hNQU1YZHJDSlpl?=
 =?utf-8?B?UUJNYkVEaDg2aEo4Y2pBYTNuMzg5V0RRTjBCN2h5VFdoTml6UFAxK2ZNSGI5?=
 =?utf-8?B?dnAwL284blNUVUF0QWtXcVZxclNmUTVmd0tnK0ZxbXB2bjJvRm9RcDRncVFH?=
 =?utf-8?B?ZGloNHhtWmRYQS9SWlNjT2pzQTUvOXR5ZUtPK1hXbUFpZEdvRi9YZmRuZHpM?=
 =?utf-8?B?QnNDY2pYeHVPbGwxMmlueVpDME44aGtZSkdsQ2diTXlEdDJnUHNPa2Z2bWNM?=
 =?utf-8?B?MEtmNFE5bWtzSDlBZG0rTTlZb0pBVHVwT0RIUTM0blV6S2N3ajVYQ1ZKdTZv?=
 =?utf-8?B?V3QwK3haL1ZHVGRaY2RSUGRjV29lbCtqeFl5Qkxta05xY3lxakljeEIxSEt1?=
 =?utf-8?B?M0lrR1hzMEl0Q09WUmx2ZlAzMjl1ODZDV2hrQ2s4RHhwRC9pU0QxNG8yaklF?=
 =?utf-8?B?aVFObmRxUWRZTG55aFcvUVZzbXlSSUlyQloxSzlxSTV6M1dETFFWVWhBazJJ?=
 =?utf-8?B?L2RLb0p5T0JQNkpzaEdOUHpLRFVrSnhtQldvb2lVWlBINEJOL2ZoVGkwWmVm?=
 =?utf-8?B?TWRMTnhZVVpxOUVMNHdYb1o0ZllJRUFvVWxwYy9EKzlzRjlwRGZLenljVW53?=
 =?utf-8?B?U2FtUTdOUWxVOG5lYmEyblZNdjI0ZnJjWnJURWhIVUVIM3pEbDdxWnduL3dG?=
 =?utf-8?B?Zk1OTjloeTRqc1JjWUlJT1VhT25rcDcvM1MrN29vc2FscExWUU1lV3pvT2hQ?=
 =?utf-8?B?czFCZStmc1dpVzFGN01pajBvMVBlaUFsdkNaVWtkY2JlYWN3cnMwZ2JPSjg1?=
 =?utf-8?B?bFhGeUFBYUNNbHpwdlhVakFCQjBNdXJjVHhCd201NEs0cXVtVzRvWE1RRXBj?=
 =?utf-8?B?NFhSLy94dGJ1UEUrK21IajdMN05CdStSSEFjVVA3c2FpU09pZlFBNm4vUUVi?=
 =?utf-8?B?M2czWFdYd0l0aFNGWWY4d0ZEbVdlUCszdWltdml3dzI1YVpiRGQwbkEvQzNV?=
 =?utf-8?B?bnN4eHNUaUg4NFFQVktnVGpoVmRjZUxZSVZWdTlJbm45YVdqUmNGZ2RtanNB?=
 =?utf-8?B?VFRoQ1NubXZ0QmpRQUcyMGZubTB3Sys2K0dIM3I5SHQxU2dqemVzQzJDcXlV?=
 =?utf-8?B?MWxkWkNycDYvOGJ0L1ptbzhmRThCY1I5ZWNzV1VVa0JRUEJpa1NBQXA0QlZw?=
 =?utf-8?B?WDFOaDNsUjlIN1NLTVh6Nm1vQ2o4b0tZdmhmbVZ2TFNJNFB6bVlFM0czeXBy?=
 =?utf-8?B?N1k1WEdIUXpkekp0aC9Kb3lYZkpzVW0xT3ZuWDFrODRJdkhCUU40RTd5WFBm?=
 =?utf-8?B?NnRmek4yMnZ1VS9aNU5LVk9IWFN0elZkOUVEdHdRTE5KSEhPaW9acjhwb1Z1?=
 =?utf-8?B?Z214WklVK201OTIrSVh3dC9JeHZudDY3VGcrbllNMVBuTUtjTzd1NUhTZ2NN?=
 =?utf-8?B?WGNObVVkVE1xeS8wbWZpV1ZHNkFtaUU3YStuRXNKdG5IcTNSckcwT2k0ekVC?=
 =?utf-8?B?NVJYRXc1U0M1R1RXbkFoNXNpSjB0Mlc0QUdkS09Gc1lXSVk0dkgwK2xHV0xp?=
 =?utf-8?B?Y3Q5YTFDcER6T3JaVVA1eU9lTUdQbWg3UDVlNnB3amhvM0JwdU5JSTNpeFpD?=
 =?utf-8?Q?kq0rjcd57NM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5509.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0loMlMrTFcwMkxWeitFQ1dNWmZpK0U2VXZrS3hMTjBpK1ZiZGRhSXd4QjZO?=
 =?utf-8?B?bFhZa0JqQnRVOHdGaGRKb2tFZVF5eWl4NTVwT0dxYmpoTnphQ1p1WSt0ZXR0?=
 =?utf-8?B?NWhiV1crQldoeDl1UFV1eUFJQnFpTnllNEFwUTBpNXlXK3FyMFdmNUgvZW9z?=
 =?utf-8?B?eHpMZC93RVFPK1ZMdzJ3eFVGWWxTUjk2TndxN3B2VWpPT29PemY5a3Q0Q01P?=
 =?utf-8?B?cHd2WDdISnhiSjg1VTBHbDJQQk42aEE1RWJJcmVMMmprOHE2MjVZeENhYTJK?=
 =?utf-8?B?Y2pZZkIrVy9nU2REWkFIQW9UQjVSY3lmYzcyajU5UnhKSnVWUkQ2QlRRQ2NT?=
 =?utf-8?B?ZFRTZVJTcktiS3dFaW9WVlZuWkFqRGVHRU10VFIrSEcybmJJbUVRWlFMZ2pi?=
 =?utf-8?B?WnpVa0UyTWlFN2R4QTIzN2FFcEhPREJ1dnlvU1d2TWlvMks3b1ZBaVZ0ellp?=
 =?utf-8?B?clhWZ2kyZXZTcHFrWk5meXNjMlhYVms5YkNNdFJwem10Vkl1MzQ1Q0x0MGEw?=
 =?utf-8?B?WE9BOVp1bkpScDI1M1NlcTAxQVFQUkg4Zlpyd2xMQ0tmeTdjN0d5MWl5SEtv?=
 =?utf-8?B?MFdLWFhicjJHVFJQM3l3VkllZzFmRy8waTdvUk42S2tNU0o0ZU5FN2JuUTdY?=
 =?utf-8?B?RHJ4MWE4ME5zU3RHR1dyb0hnZVdONGFCeEJnU0poNEhsbFRYbFNnOHRyUGlk?=
 =?utf-8?B?VWpRcTdwbkJRNUh1NzNSR3RuRjR5bDlRZzBrU3Bjb0dIc3k3eEZxeTlWb0VK?=
 =?utf-8?B?OW51RW1DVDFTNWo0dFNGQkF5Z0ZxV01sR3VhN3FteStwaXY5T3QxOUE5Qkgv?=
 =?utf-8?B?YlJERi93UlVveW82U1hmZk9hSG5JT1Z3SnVBZE9ROWJTY3pnWllKaUN4ejhw?=
 =?utf-8?B?R0tocEdVL2JhcUNxK2dJR2NObUlPL1RFN1ZjS2JUU3Z5NkQzRjRJU1NEQUJm?=
 =?utf-8?B?Qyt5aWJQS01LTUZtWkxqYWR2OUdtcER5ZWtGUWpMUkhpVWVaZGZLdmIzRUgy?=
 =?utf-8?B?NC9iTE5jSyszbGR0djdubExnbXlYT3FRM2tRRU9hU0ZsK2VHU0loQW8wZEZK?=
 =?utf-8?B?OXVnMW9Yd3ZBSWpzQlRjZExZcTdIWkFoWjg2U3Z0V1M1bXpGOTIvd0F4ZG54?=
 =?utf-8?B?OXpsSDFrenkwZ2Ird0VPNzl1R3FGN1lRQUxFT0gxcHM0bU9MT20zVFl2aE1D?=
 =?utf-8?B?U0cyb3Z6dnFWZXdzblo4Y0grQlk5SUhieW9tOEdjZlZXU21iNjExZXgzUnVE?=
 =?utf-8?B?Q0I0eC9haGJoNENPbUh3L1NWbjdITGhRNkRybTlNcEZacXZsaFdoRXBvWkxS?=
 =?utf-8?B?TnJtZjU3OElUY0thM2ZLRFVPeU1KOTBwcmRMSTFOcWpOWjd1K1pUdG1LSFZZ?=
 =?utf-8?B?cmg5cXczRjZTUkNQVk0rZVhaSXZPSFdXS0x0N0gwM0lEcnFhYnpXdHJ1M0Jo?=
 =?utf-8?B?bjlLS3dZQ3RHbXBxeUxERjJoZVM1TU84R2NVZDVBVEQxamVTdytlRTl5MTRs?=
 =?utf-8?B?d1RRaXZJRC80eEIvcjE3bmh1VVF2ODFmTjJmK05PTzVIUEJvZ0FyY3JhTmYy?=
 =?utf-8?B?SkdkOTZKUDM0MEU1Z3F6UVlpWEU4VEw0NmRITlFSbEhJZGRwbkpsNmFIK1FG?=
 =?utf-8?B?U1U2KzJLQytxMXVXSktML1ZJWUtUc0tpWXpZZFNBdkg3YytBNHNzK2J3V2d3?=
 =?utf-8?B?Tjh5QXFhVml5cjBRaWpKNFpJa1pUUjZqbGMxQU9RcnBsZGMvcXNxcGIzaDZv?=
 =?utf-8?B?Y1FVZVN5bTFTZU1PWDZpV1hJZXlwa08rQ0ZKWDlNU053VzRvNHVtalV6OXNH?=
 =?utf-8?B?RFc5bi9ObExSZHJFdE1iYUpZZWxNd0lnWmgxZ3lXUU5OY1R1OFNidkJBdGRy?=
 =?utf-8?B?RUE5cHE5c2JjcHdsZTg2VGt2SWUra1ZnalRaVDFuMGxFNVhuVkNwWHcvMzM3?=
 =?utf-8?B?Y3J3SzFDYUh6L2NRL24wN1BaWm8zWlU2LzVteG9kZ1FSMWxtSHJnTDFmdTdl?=
 =?utf-8?B?VVlpL0FUV2M2L291eWJHMXFqMzB1am5xd1J3aVdCdHJ4VHVMK0VNSDI2UnM2?=
 =?utf-8?B?eGt3NGtRUU91YVp3YnNLMnB2RmlrWDZOK3BaYU9JckFqYitwSmdUbG0zUXBM?=
 =?utf-8?Q?min1QtJUfCjkv0Ioyth5T1ARZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LFXKj64VsQxAFf7mmE5pa+cneTioujd5zOvtID9oN6Jjqrc1gqtP/pdXcMI2e/itZTtneFLZSIlzAamHxVSJyTLnQxpEq0cGii2GHURkQ8vijlEH/x17J5ZVJwq3eYy4k+ZC/J0EtDKEy1pKmrlH2MPw8gWo5oWhVDPAAVhZG/7TZntplZjvi2LhtL9qf+qR2fbc8bYq5rP/rqFO+sWm+dN1otMC9/FBVK6OqSSFlj9xiH1maE9Ra5PhdX1F6P6OyDaDeCF000TLg3FB+2ud6E9rHKLaHFipxfd/JW072zZSGKAi7TvhhWnxvbqZN/bUCUZQuKDK91ytIB/x4vA2FDNeGT56F7G7wwOvkCObXkOoTUpGnaVpDotGsAPsrdRw8dydZJsffY4e+OVIJmn/BBy4KH8mkkJL4B2QQv1wZumVTjLYmWbYoRccBFMwN9fJAEwFK2vtgXASvl89k96osJG0eowqLD2CSbAhsy7FdPDVJtI53AVMWva14sPoINg9Ks8LHO/BJM0otbR/7H2CrYa9uJakwVN2C64jZTGGTv2OHwoX0dl0efWBexI5Lv5qd8OuUYBhDZ3sXy5wFPSQvUeQF6zSFDsPvWfw8Tah8LI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec76bc23-547c-4193-3ff9-08ddeb2bb978
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5509.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:51:58.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwNhbo5uFOOKpB8QPYSve5z5DxLxiD9mWvGUnNrcSRqiEc2d591WXvsOrEr6IqAIE2WKrrSMQNSqLHSWXpa4Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509030209
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDIwOSBTYWx0ZWRfXzMjKX1gomppH
 0Mzp8wRvC24zX84hTSG8vu5Inhp8deH2LVWPrEXo2IxAXiKZahtQyACIyqgDR37N9+09uXhR2fw
 +y0ZvcmdpT+UfmBw2JRSqCQSV+3YAFc0nrPoMpA6HUj3eDC9rWT5yPGY2elU0pLUzfm2kYdxhnx
 BxLeSkCqSNShOVZ6NUwqDY0J1CrV5tCWnhZX4OTUEwW5ZLK/fhkfAJEhbELkUMhDyD48IRQuPnu
 9XNnzg9GT+m+cEf28C9TL0OX+tCEP5EdjW/uGFDM+ULCTVyo+icNdtyrQ528arNPJxp8QVZLGRj
 9cOnAKLpW8lI7egccdTKbUN2HIrjhkqIyHcl6JRCUdFsupWIyNVydtqqBwcqGjzve6yVU2NHUX9
 f0ar4AHE
X-Authority-Analysis: v=2.4 cv=KtVN2XWN c=1 sm=1 tr=0 ts=68b8aa73 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=H_560qy_kMW8WVTWK3IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w1jXaK_Km6nPDb1mIaMKrX3hIgioVrgi
X-Proofpoint-ORIG-GUID: w1jXaK_Km6nPDb1mIaMKrX3hIgioVrgi

On 9/3/25 2:45 PM, Alexei Starovoitov wrote:
> On Wed, Sep 3, 2025 at 1:38 PM Tom Hromatka <tom.hromatka@oracle.com> wrote:
>>
>> +
>> +       spin_lock_irq(&current->sighand->siglock);
>> +       spin_lock_irq(&task->sighand->siglock);
>> +
>> +       if (atomic_read(&task->seccomp.filter_count) == 0) {
>> +               spin_unlock_irq(&task->sighand->siglock);
>> +               spin_unlock_irq(&current->sighand->siglock);
> 
> did you copy this pattern from somewhere ?
> It's obviously buggy.

I tried to mimic the logic in copy_seccomp() in kernel/fork.c,
but as you point out, I probably messed it up :).

Do you have recommendations for a better design pattern?

Thanks!

Tom

