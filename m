Return-Path: <linux-kselftest+bounces-20032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E019A2D0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA7F284180
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8474D21BB0A;
	Thu, 17 Oct 2024 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OTa+t+Nn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rDieczOP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F821D2C1;
	Thu, 17 Oct 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191656; cv=fail; b=UdAE1+Yddy9+bjiRwXa4x97esouyUkW9BBIGNzJk/KAh0TPzZrTPgkPXe6P7bHJVpx0rGDRtTVAH3wgEIxNxZ4syuLa3eXenBBGc76Ttt/DNzkjf5qDIL0fmVAPqQXmSFGANsU3vGgGM4cZ1nYfqh0rFR+N+P+U7AaRzEiY4I5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191656; c=relaxed/simple;
	bh=RWICcmLc5zVH6U4EoKpeCM8GDLV/dG4aOFaD3VXx1ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uR0V/pO85mK75VTZoitC5BTNwRx9ZGLFr/3nnAIm7UASk+OF3PefMuKca7RMP9qchhEPN+PvHCTDcJ64EG7eOkPJcaIqurhYLI5S8BnpUSZ2bdJynHSeSm+jcxRklSHInaOZjT3uFB76TCh1c75KuKM9iBNcgKNjzYkbD4fpibM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OTa+t+Nn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rDieczOP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBtq2024412;
	Thu, 17 Oct 2024 19:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uc3cXg9L3CcBr8W5xGIeQcCD+Ui8Base68nMviUhpcQ=; b=
	OTa+t+Nny4oMsp8qXBdDRFVS1sFhybJhEF7Dzd5NTQJOY46d/hX2JdTC/PlswP9V
	FBCyJkkYw4Sax3h8QPdlKmFUp+WilJzwsSsMKt0MR33e8T6dnMDO/ZdlXYsD32pB
	8MqiRHE8YOH5CwRo8gfKeRhwpN4Y8eGN8Xv/IZAI2eUlwdqVMMioEJDeU2e4WVPF
	UtMREFX8giFUc8mJf0ocMMFigVeNZ5fO/yF8WBShFAKJF+BEQuTzbBQEjOOGHTKd
	cixJU443BRJqvsHnNG7TwljnESNq5i+9w3ltTiUdDDTdlOOGUf9Rxhy13ttoBu6S
	SbFqhhEyDIwsPM1bdwmmwA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpsma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:00:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HHj8nh019883;
	Thu, 17 Oct 2024 19:00:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjanjdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:00:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R53sUy+ISn1V92177salkhB1fM9y07UV4E9lq1VTIVKHwOkK5k/agU3em2r3ThEwALnIgNsdGzzY1eS9sV70tv9CiF6VhEzSS6dhLq4FwP1i5yfG33f212o4mTiPFLRCGIMyCbaoWbcy9abWmj2WRUttP4tAe9QleoGA+K7+1GELQAc7GLTkf4bMNRf0Mz20JF7Xp77j/uTuZmfYh1fYtL1u7Oc4atlcI+9jOqm3bOBRKd/PHy3LOX1Dm+7x6rOrtcJwv031c+Y9xqlIruWgx6tTv7rSEBguwUUh6FdcqFSAqh/iC2as5KmCw7Ro4DXhoaf4sso0xrJihNhh83zniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc3cXg9L3CcBr8W5xGIeQcCD+Ui8Base68nMviUhpcQ=;
 b=kBVgXsG73lg2+XQo0p3S5K2pk/z0YlD7jy67wAbilzYSWwjzCDNNtmKJx3hIg6lGF0F/A3PVUj8Jj7018joSlV2Rn4AodbuBtvb4SsCZRjk+alzYKcHQRataraxn+f2jxRSfoc7okPKE36u308Oaw5oy8+kn2KNXF1gxtJK4uOUBqADu7oAbGfoMgfmTToLaoIahc1bAwlTMliWqBytICpgCkyCerOkMQ6nwqp/OwPxbY+27OOITbGzYIYBrCgdOQ2Z4m/aOiY1PEjJBtbS0b3UOssKDgzXfzBsCzUvj98N4+PE8x6RS0/PBRe5b51HpSMZ8HCbgnC3Xf6KMEIWmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc3cXg9L3CcBr8W5xGIeQcCD+Ui8Base68nMviUhpcQ=;
 b=rDieczOP4bupkm4UoLxuNw+EErKWQnabMh80IMdP3L6Pygs85cMRwl+NiQwsJ6LMBQVMB5ogkubw5uftrDJbe77QL6y/OJgNjqYBs4VORdkFfaEMiVsaE0MNxA0icGqeOhaljPERtnL+oxYJJfw8s1LCtVmKrFwXmqHb31t1wEE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH4PR10MB8227.namprd10.prod.outlook.com (2603:10b6:610:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 19:00:13 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:00:13 +0000
Date: Thu, 17 Oct 2024 20:00:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        willy@infradead.org, broonie@kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
 <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
 <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
 <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
X-ClientProxiedBy: LNXP265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::33) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH4PR10MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 109106d6-e400-4f4e-9348-08dceeddee85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEZON3hUVFovbGNOMUp3bGd2c3Rqc25hTEFxNm1qYWUwSHVWTVZDRVJzOW5V?=
 =?utf-8?B?THBjcXdLQWw4S3ZUK0gyN2pzMTF4QjB5azg1KzA2M2ZOTFFvY1dMQVRJOVRs?=
 =?utf-8?B?UWJtbk9mY1RYWWkxSXl5WjBpOUxWVktDYjN6emRmTWJGWkJUalRWVVB2U3JJ?=
 =?utf-8?B?N1J2SzJxanhIcjduYkIrcE1MeDdxNU5pY2wvdm9mWjZydE50aGNQRzIyS2No?=
 =?utf-8?B?Q0JPWVRHbUdzblg1UXFkVGtLNlN6WUlBNnRvY3FnRDQ5OXpCREIwWTU2QUhp?=
 =?utf-8?B?SUhON0hkbGcxeUgvb3BPdzR0anNHbG1HMm9NSmhHUXNzbmJFaGt2WE1xUUEw?=
 =?utf-8?B?SGJoWXliYkV0aUszc3pwbTFFOHRWVHlHbVVpWU1raFlKeEt5TDNUdVQzdGVY?=
 =?utf-8?B?WXc2b2tCNVk4bEtoYzlhaC9jdjRHQmcwaWdYd252a29TRm1xSm11QVN0Y3h3?=
 =?utf-8?B?dllCZ0FQOVQzdVE5MlhNN1pLWFFoYmtYbFJvYjhLRU9DQVduRGFUSWwzUm50?=
 =?utf-8?B?OTB2Tk5sOS9kaFFZU1J4a1lDTzhnZFIyS09oMnU5SCtBeTlOYVlXeldFMTV0?=
 =?utf-8?B?OEpDV2t5VjFrMFRsRy9MVEJqdC92bVpRSzYwRzVSUnhhUjR0V3lHa3Z3cHZH?=
 =?utf-8?B?Um9YTExoMm5icTNGWUZSQzBWbGRoc2hLRis1QlVIenhaUkpGNG9UUk5GMlZ4?=
 =?utf-8?B?WkR6dDNkNUN5OTd0Z2d6a2lhcTBuTDFuZ1hxZENJMVlDa0RHQ1A4UnE4MlNt?=
 =?utf-8?B?V3pGem5ZdGQxQUNzaWF2dmJXb0ZFQmp2Z3pOME5kbXBvcGoxNTN2L2xwZ1Rw?=
 =?utf-8?B?bzBMSDZUd0tJdVdpd094YW5SMHFsemlNQ0RKWHBFNm9ScmhVaGJ6WmNkUms0?=
 =?utf-8?B?cVg0eE4zellYSzhXNTF0cTVreG9iT25CeFAwcU05a2tzU3NITnE3d3ZjbVJn?=
 =?utf-8?B?c1VkSEFSNGVlZWNSL3hSOXRrQWxkb3VCWktVbkdBVWxFNzhYTUF6ZGlhdEN3?=
 =?utf-8?B?YjZjSGFub3BCakl3d1JpbXc1SC92aERoY0hMcVh3VmNhNk8yMTV4bmY3S0ZK?=
 =?utf-8?B?ZnRYTEJpNy9QWUZHSXV4QzRFdDhOTDZBVHUyaFpnRXErZDFGQnJHbWV2WlJH?=
 =?utf-8?B?NmdmWURDaUprUERpamIyZ2diVStaNVFNUllZU2RGd0t5RUgxZUhJbFgzV2h5?=
 =?utf-8?B?bWQ1SHBMajJWUERzVEtWR2xqT2xNOXhhc1cvbEF4VTdLTGV5b0gvVGlJeDRl?=
 =?utf-8?B?WWRpWkszbmpTem9jMnkxS1YrM1RsZHJ6NGtoa0VOUmJJazNTUVduTVkrYU01?=
 =?utf-8?B?MWZ2aE9LRllKL2ZMeWhzNzJhcHZ3OFNZQm5EQ3A0WTVnM3FqYnZPUkFQMlpK?=
 =?utf-8?B?TmxCWUtrWE1FdGw5UE56bEJRbWNzUUk4M3B3b0d0b0xTdFdBSkN2dEY2YkQr?=
 =?utf-8?B?TVRNcDJhUVdkMmZMaER0c3RKaldMaDRRL0czYkh4d3ZYWWNqaVBXT1M2Zjdn?=
 =?utf-8?B?YjlXT2UzdFVUQXlsUCswSnNYOWhodWxMMmg4V3NhMWFzWVpObFJQdnZDY3dr?=
 =?utf-8?B?T21jOU5vcFFBVitKY0lVRUs2OGdMOWs5Z2xVMWdUb3F0WHhpdUR1cG9nRDJB?=
 =?utf-8?B?bjl3OG40VUtFZnp2cWRNamt1cFJZeHM1aWNncmJSUmd0bWNTNXVDVEVuckpK?=
 =?utf-8?B?cEF2dUNFb0tWWDQ5OHlBejFON3BVZ3JIZFhyeDNnT2N5NWx6SG0weG9tb2lP?=
 =?utf-8?Q?iL1/Jqx0Xv7RsRZp+t3CW0O0KxzBUmvs0CH/CNG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2t1V3hpQzZpMXE0RjlFZzVUN3B0YkRnUGY5VTFZRExJSGMrTWNnVmZ3c1VO?=
 =?utf-8?B?dEJIa0piZWtmdldVdXpjUDB5K3JBcnBPS2VWb1NtaWF5M3FnWDVZMWROVnJN?=
 =?utf-8?B?ZDhsVXd2T25TSXh4Q0NLTHRqSlVlYUdhbEhWNEV6dk55Q2FjTVU2N2tiYVdo?=
 =?utf-8?B?VXBTanl0Slg2ZnBTQkE1YzQ1WlZObFZkcG5jQ0FuSS9jWGhVaThJU0N4cmYv?=
 =?utf-8?B?ZEtwSkdhOFJSY2NUWEYzbVQrYlNZTksyL1pmeC8zRkhPZjNoVkxzSFNCRXg5?=
 =?utf-8?B?RDFPa3dGY3E5WUt5bTY4cXZ6MGRYSmhyRU9yNERkaEl0OXgwdFJFVUFuTHRQ?=
 =?utf-8?B?NXNHaVBjZGpHUXp2bnFIaDByV0ZOR3dKeS81T2xmckJHZXZmaHZCYUVFRUU2?=
 =?utf-8?B?SmQwaUdOSTlSSHNJK05sbkxSUWFuMFZaanBXVlM1cGRaR09WNzBGTjFFUitD?=
 =?utf-8?B?bFRhZWNaNU0wWnJ2Ykk5NCtWdnVrd2lrcjV4YWY5ckpPU3NmY2Rja1dkSm8x?=
 =?utf-8?B?WUF1dWRYUm9jNE9mT2t5TFR0aEZNQzJTZTgrUGplZlpybTV2ZEtwTnNiSGpp?=
 =?utf-8?B?ZXBlV1pkaDNxRVJRdSsxZExTczJGY203NXZhck15MStleDJYSjV4NGFEMy9C?=
 =?utf-8?B?U1VnbllPTjhpeUU4enFWakNsVXMyRmlLL1ZOd2F5cVhiM0xadE9tcktzZzV6?=
 =?utf-8?B?WHVKOERVb2xSQ3RMY2xVWVdkUkRqUXFsZnZPWXlkSVJPaEVUVTg4SnZFQXRC?=
 =?utf-8?B?L1VNYmwyWkk5QmdJME1jTFFUWHVaRjNNTVJ6ODNUR1BxT3hxU2xReHJ1bmw4?=
 =?utf-8?B?eEQxSUlKVXAvbzA2dlplR2czelNBVHdCSTg0NUlDNFNDU3VNN0xnQmRaNzlo?=
 =?utf-8?B?dGVKZDBGNVNSWEcyTjJTNG91Mm1qeHJmM3NxN1VlREN0OWdtZDR3Q1VTczdy?=
 =?utf-8?B?akF2ZDdMSGMrM3REeEltc3EvdmxleHhTWWFGUDZUbGtGeG9uUmR5a011YmxY?=
 =?utf-8?B?TSsvdjNucW1uZUVGcWhXZy9mQVlFaHhrKzU2ZnZEY3ExY2ZpSnZFNk8zbHFp?=
 =?utf-8?B?SlFUUzNKM0Y1UHRmMHBFRzM1MUV0T3hsR2pCTHdlYlp2aXFvYURhcVFGS2JC?=
 =?utf-8?B?U3lxTkpiZ2RlZWx4WUVTMGFwWldMcGVkbUUrWS9jS2lra25zS0x6WUg5Z0o2?=
 =?utf-8?B?Q0MyR0pLNW53a25XVWJsK05XdGFiOXF5UzdNWFFtYkY4UkhkVG1ucy9XWjFP?=
 =?utf-8?B?U0E4RmsrY0ZYMzkwVlgvQVFUVzF3bmFUVExqUXJwZ0ZTRmc3aXAwZWJHcG9Q?=
 =?utf-8?B?Z0ptZkkrUS9lTTc1YjVNT1BOcENtaU11bHdjdHJ5YTdqbEdqZVBQdFpMNmNJ?=
 =?utf-8?B?RkJCbmRZZWgzOE5yY0g4U1g0Q0hicFRGZDRYR01CeUFYNnA5VFlSYTFlemlN?=
 =?utf-8?B?WTFrTzlWamtXOWFWd28yVEloak10RUJ2NG56Zjc1dGNhbEZtamxJZzdvNTIy?=
 =?utf-8?B?cnV2QU1uNTlPZEVpT21HbC9CNFYzWDBIZ1BIMy9nWkJDdWkyVzV0NG1KOGcz?=
 =?utf-8?B?NFZHVVdiMWJqM2VZVWVtMlNqbGMxNEVaZWZsSWtNZkdBVU12cXZDZ2hXbTZt?=
 =?utf-8?B?TWN1cHZCQTREdVFIWmZaTWJZUDVBajVLcVJ5RzFHT3NtUUQvZUdtdDlxOUth?=
 =?utf-8?B?MnRQSERueUcrelhXYm11cmx0UndIR3lKcVZIVVl4bjBuSHF5YWJJMno1Ujdm?=
 =?utf-8?B?Q3Rkdis3Y0l0Nm5FbEhoVFR6eVBwM2NiWmdDR0tFdS8rU294cGEwbzhndVdr?=
 =?utf-8?B?bXg1SXN1NU5FK215anlycmpMdU5IZmpNaS9jcXhvSE50MGQzd3RQcStnQ1Fq?=
 =?utf-8?B?TzNQV21jeGduTE81K2FlcnJtQmMrbko5U3dLWkxBVDdmWUdoSVJhTXZaUWZa?=
 =?utf-8?B?d3d4S25UTzFablh5bmtHT1AwS1BTVElsL0JhTnRIbWNla2xMaUpTZHNiOE9V?=
 =?utf-8?B?UHBFSlhFY3hlS3V2MDA4cGNqZjRjaVA1bFYrYzF3UVRndTkzSkZ4bUg1MXBt?=
 =?utf-8?B?SElsU002MHdnMkJIQXVuM2ZsYmR4T1hqbVJaemx1czdPTWNkTXk1b3BRTFBI?=
 =?utf-8?B?eUM3TnRlQTFuamNRK0I3NTJJVjh1UUw3clhIOTM2c1U3dTZrSzVuZ0UybXdG?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iaMA+EnQjrUqXbOADUZL125NZRXwPpNoQAt7/1K5YQ0rUC4HPP4sd6MQ3hmq4rE6vRDR8MZ2M7trHkn5qkfrWgwVuXYGbUCQOZu99geSkdwgVnuxhBASWfj4MJ7mF4v0Ar7sGGnPXwIPCKe3Pg9o28GOfAj3Fr7damrNymqat0+04G1lD1efpkYleFaTgq2W8CNby1wkSmQ3yTEtRLEPtHGKvUobsicyYVq6FXrMGMBZ+vQ7b3ph66uAkCBhxXdFPiF885wdKi/mESH2WdjQ49LIu9x5CqTf6cWBL1a+kztRnYOMUiNG/j3DCzz4R3dU3S60ncpz+dIVlry2PhpjqIiG2N9OEQGXy/C6HzHXzur0LXtnIyY1mkX85FcJ4YVix5WMgw6LPCVXd6Vpmw993PDl7gKyi8o8Ioct2z7jPZKJQHSNQq9Np5UnGUbWcN/Y1Wdiiq/q87PpAmt0L7eF0D0PHpitxEs+nhGElq8jYdj1mt06CWDkCmsvOUQy72uvGMQZm8ElYQPjffGqNpCi5fvIFmRhAp1+8HIpOymhAH95MBKoAdByLQF4j1FeuSNwLL2fzLMIWpSBOkvjgxpiyZZLUmCuWUPPr6nZxxQJQQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109106d6-e400-4f4e-9348-08dceeddee85
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:00:13.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V41aDjloPB2zB15aiPRv2t2+hx5SBIEZV46HEmGjIrqYe4/dG2fHk76HszGrSGRuJtX1eZ6r/txbj0e3R6enBQ/alIxO3u/2SYrzcwkJU0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_21,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170127
X-Proofpoint-GUID: w-MyIQc_qDkz0ScBnrd8J9sUfTS8_gpG
X-Proofpoint-ORIG-GUID: w-MyIQc_qDkz0ScBnrd8J9sUfTS8_gpG

On Thu, Oct 17, 2024 at 11:47:15AM -0700, Jeff Xu wrote:
> On Thu, Oct 17, 2024 at 11:29 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Oct 17, 2024 at 11:14:20AM -0700, Jeff Xu wrote:
> > > Hi Lorenzo and Muhammad
> > >
> > > Reviving this thread since the merging window is closed and we have
> > > more time to review /work on this code in the next few weeks.
> > >
> > > On Fri, Sep 13, 2024 at 3:50 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > > >
> > > > Hi Lorenzo
> > > >
> > > > On Sat, Sep 7, 2024 at 12:28 PM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > >
> > > > > I also suggest we figure out this FAIL_TEST_IF_FALSE() thing at this point
> > > > > too - I may be missing something, but I cannot for the life me understand
> > > > > why we have to assert negations only, and other self tests do not do this.
> > > > >
> > > > My most test-infra related comments comes from Muhammad Usama Anjum
> > > > (added into this email), e.g. assert is not recommended.[1] ,
> > > >
> > > > [1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f336b6@collabora.com/
> > > >
> > > Specifically regarding Lorenzo's comments about FAIL_TEST_IF_FALSE
> > >
> > > Muhammad Usama Anjum doesn't want assert being used in selftest (see
> > > [1] above), and I quote:
> > > "We don't want to terminate the test if one test fails because of assert. We
> > > want the sub-tests to get executed in-dependent of other tests.
> > >
> > > ksft_test_result(condition, fmt, ...);
> > > ksft_test_result_pass(fmt, ...);"
> > >
> > > FAIL_TEST_IF_FALSE is a wrapper for ksft_test_result macro, and
> > > replacement of assert.
> > >
> > > Please let me know if you have questions on this and Muhammad might
> > > also help to clarify the requirement if needed.
> > >
> > > Thanks
> > > -Jeff
> >
> > Right this is about not failing the test i.e. equivalent of an expect
> > rather than an assert, which makes sense.
> >
> > What I'm saying is we should have something more like
> >
> > EXPECT_TRUE()
> > EXPECT_FALSE()
> >
> > etc.
> >
> > Which would avoid these confusing
> >
> >         FAIL_TEST_IF_FALSE(!expr)
>
> FAIL_TEST_IF_FALSE(expr) is the right way to use this macro.

But you don't only test position conditions, you also test negative ones.

'Fail test if false false thing' is really confusing and hard to read.

I struggle to understand your tests as a result.

I understand 'fail test if false' is expressive in a way, but it's really hard
to parse.

Obviously it's also misleading in that you're saying 'fail the test _later_
if false', which I hadn't even realised...

It's well established in basically all normal test suites that:

* assert = fail test _here_ if this fails (actually a valid thing to do if
           you assert something that means the test simply cannot
           reasonably continue if that condition is false).
* expect = the test will now fail, but carry on.

I mean you work for a company that does this :) [0] this is a very well
established precedent.

[0]:https://github.com/google/googletest

>
> It is same syntax as assert(expr), e.g:
>
> man assert(expr)
>        assert - abort the program if assertion is false
>
> FAIL_TEST_IF_FALSE is a replacement for assert,  instead of aborting
> the program, it just reports failure in this test.

So doesn't at all do what assert does, because that _does_ terminate
execution on failure...

We are writing unit tests in a test framework, let's use very well
established industry practices please.

Also note that you don't even need to reinvent the wheel, there is a
fully-featured test harness available in
tools/testing/selftests/kselftest_harness.h with both ASSERT_xxx() and
EXPECT_xxx() helpers.

I've used it extensively myself and it works well.

I'd basically suggest you use that. Though moving existing tests to that
would be some churn.

On the other hand I really can't accept patches which are totally
unreadable to me, so you'll need to fix this one way or another, and the
churn is worth it as a one-time cost to be honest.

>
> Is this still confusing ?
> (The FAIL_TEST_IF_FALSE is already a descriptive name, and the syntax
> of assert is well known.)

It's a super misleading name as it says nothing about _WHEN_ the test
fails. Also the syntax of assert() may be well known but you don't call
this function assert, you don't reference assert anywhere, and you don't do what
assert() does so, you know, That's not a great example.

The semantics of unit test frameworks are very well known, and already
implemented for you, and also do not require you to do unreadable double
negations for no reason, so let's use those please.

>
>
> >
> > Things.
> >
> > Hopefully that's clear? Thanks!

