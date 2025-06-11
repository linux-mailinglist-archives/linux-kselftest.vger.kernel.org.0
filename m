Return-Path: <linux-kselftest+bounces-34663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D4AAD4F8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 11:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578957AB7B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE325C6E5;
	Wed, 11 Jun 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YlzETeCI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hPdzU3Xj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4D257427;
	Wed, 11 Jun 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633527; cv=fail; b=WmKZgRxhest0EcxxsHc1vAMKtAhT9sgQkdU5eiSIJMOT5iYEABeX8oRxrvW93RSrCpmvHYvwrLZH1CSHzDpfbkzNHNT4gs73OJtTsA+Rmlquab0ldIk00uwq0VFThmA59RWw7m8tnSql6+0wCkI9KrYaib8Ilaa9E7Mem36T6uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633527; c=relaxed/simple;
	bh=oN34xXms9yvWVSCPgSxDl/9Fd/JlwWq3Yid4Tlto5f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W5Iv8HYEBQMPmRTaFgf6m2bbLY2N2zlzdJvqWH72dzZZ7hCeKHblxPo+sPnc8XyTDBt3UnLRcvQWXxNaX90FPvAFwPnR2t5fIeczC/NZvBoJaUDxxpzQc47NbfRjoPacPAp54FJALgo2V825PRXkJgMyX6hkCryPPk7TfEVYBjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YlzETeCI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hPdzU3Xj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B1Bm7k030393;
	Wed, 11 Jun 2025 09:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1Hco06TqajAEbfkVDK
	bmH2doH+xZBDMFsQXPjPa9KlE=; b=YlzETeCIGgVNPK9PUONPMXH71pWNiYm9RY
	EBHO/CXkozfYL4iVCeF+7642wuhqTEAOFJdX/Pfer0J55WNCAAqLVFV8oXqtp0UU
	9I+z0AaVO+8wvgF4c3env/YpGg+qN9HDArWO0WCa7O7IAxAiDyi6Wz3LRdzJmDVK
	xIkPZvxw7i5uDmyA/gdCif1maXkKPE0RuyvLxfBv1ZLwApm66tJsD4izt1Mm1Z77
	pvPP72Hrseu1xg19PQQ3KR+7S+gKWGJN0kJFTZFZba48JlX9ShcSzW89IZkpc79a
	Msm4TvxXD7ymYn9IWt/78U2ZWSMsBs+f33XhJJvlAuubOTCRRqoA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywwur8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:18:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55B7i2Yb031345;
	Wed, 11 Jun 2025 09:18:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9vvad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isWbVt1GKBw0DVjkaU+gpX/uihBmf6I2GiMoznY9j9H20e7ktneCkMRj3BhpvI2Ub3nMZm2VdxoehKtJf2eGERswRBgESS9Um1xYrlVHbWHJk2a5jNDbQL+AGSXuQGNarHKrCsiCVVzzedHewGIMzwLEPWMyRNUjJHfbBxM9Q+T7NTXYO8gmkggJvqfiswn0GEcHSCwf8pxt1Fq1pKrUGYNgt6gtlHCqksQU4C1QD7XK60Q62C0iQBfIXtpU/b9DPU9aql43wKvL1X6j+Lp8ilgkGJYruMRbha1c/++hrfoKzU+/uK5bWNBp2hKFRw+/7xliyVe/vUGkzhRyiafHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Hco06TqajAEbfkVDKbmH2doH+xZBDMFsQXPjPa9KlE=;
 b=W4H3XVtc92WnmIs1eMkC9huEXh5ZMp473NG9ffAUoQbE05Y1lOORMD7F2Ae+dt4+rLX9XWTe5y0p2cviHQiayuhN24gVMx4CJbPReMRQS39cEi6LVhczt0vFqyslskJhKA71S/SIt71WqFgVx+ESm70oChmVSy3M0j44haRBVIkv0phR5NKTYCzT9ZIvdnK/W+kVwVUAHQJaHbnP8wXzS+ga3xkPg6tfQNfVb5dW+WmkI2gC1aL06xwHqNoRlo6iTGi6Mfvt/jCDucbrkb1mHee2gCh23JY8eJslI/Xuac613MZmDlfPvyUg5brjsfxPL3UWzScdnrnFq7nsktOLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hco06TqajAEbfkVDKbmH2doH+xZBDMFsQXPjPa9KlE=;
 b=hPdzU3Xjio9dXmKQu+J/+HSg5sguKc+RtTbBvpvJMQ6Nv0/ioIMjl1hzxxnakzt4dJx4QHAqxQs/XymorHFgLEquj5aZ1cvS6ftzehfYhnYv11pGd+zv5j2lgdqUH/Ff1CqQYYFpFEmQC3idXeRPDqo5qYdQuVION6WyjTCnG+M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPF079E800A3.namprd10.prod.outlook.com (2603:10b6:518:1::786) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Wed, 11 Jun
 2025 09:18:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 09:18:18 +0000
Date: Wed, 11 Jun 2025 10:18:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pulehui@huawei.com
Subject: Re: [PATCH] selftests/mm: Use generic read_sysfs in thuge-gen test
Message-ID: <caad6357-a4a3-469f-a824-4d7a36a0e629@lucifer.local>
References: <20250611084011.1047132-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611084011.1047132-1-pulehui@huaweicloud.com>
X-ClientProxiedBy: LO4P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPF079E800A3:EE_
X-MS-Office365-Filtering-Correlation-Id: b5453496-7633-40d0-ddb4-08dda8c8e72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uEtj8jN9rwaS80Pn0Y8TI2m2m0pvTFYG1UwZpAjt46zeSG3nDk0BE1ye/piE?=
 =?us-ascii?Q?GTIUFKfzGRb7PWAQZnragMrPCs3z+9+ZaShMlOyWwkJrMIdR0r/2rw51GKUm?=
 =?us-ascii?Q?drEm7u62dnZ2PEm2mo8iPHWEFt1wT6WUwZqed1xbs1zvBzW25YV6a1eM3AzT?=
 =?us-ascii?Q?qxKeB7zlIDi+4eu9GpoISDVUstynCWucU32Pi07AN/U9JXDP1g2/whsFp4ff?=
 =?us-ascii?Q?uePsPizvHSdnFE0a0MLAIx9vkphYaGdW5c6KIWCBNiG7sG9jLTwj3uLDsnOY?=
 =?us-ascii?Q?v+ij3Kv9iK0WKZFyHU+oIkDW/wuTzpd1a4Fhy46twhzFbmtRJZnnXX8TXHA5?=
 =?us-ascii?Q?pfomeE4GTg/q6aelvML1xMDL84AyOJQDOEpYNiK6o6MxBK9Ozkh7AyjARQ7X?=
 =?us-ascii?Q?J7Rcly50K5FdWtlzDQjYSJ7qakFsjjmr7ZhRe1YH0AupWSN6nuoT7pYbdlQU?=
 =?us-ascii?Q?nURgjFxxU3pq7zhnQ6iVpgiBm2tTMWZOBZMweZCpns2A3NWswGLH4ghyKgg8?=
 =?us-ascii?Q?n2+6c8shvy7CWIz6gg5B+7FxOw3kYBPaJY+J3FsZGR4ZRknjdR8oFNPlmkD3?=
 =?us-ascii?Q?jP1rtJWlAcoE2MsudppZpZnjI6go2JAdLDlg1dZpKn80651xBNo3cT4dWkf3?=
 =?us-ascii?Q?D51GOyTh2SQmKeW3g+wMhjzK8W2yEvVPiHIkXfoSfScvf8mhRdAoSFSIhv2u?=
 =?us-ascii?Q?rOzbkaKcCEsBNCiRNBNlBALM+wca3JhzCqWk3E0uIT2FUlmULgjbmJmVFDYx?=
 =?us-ascii?Q?60Rd9ZOLNXjNVBGjhFc0d4ClISys6RH/K54B3qIu1Z7Yp60MRoSgIcUKUgyO?=
 =?us-ascii?Q?vXsFN8q5XdnLnnf3WmE+doKB+aQJFnV7Jprss8s+tsvzf2WOa79BSkT7ktWG?=
 =?us-ascii?Q?zsIn5QZEn297d1oA9pk8eFwzlCKKq/atuaPaTLRcZXmu3PTO+cRFAI3zK7YE?=
 =?us-ascii?Q?CiOlDXYmzgN7I4IKtXRWjR0OOhWHMwi6uGyNkBWZ9f1x8DHNdw717pV7WEdh?=
 =?us-ascii?Q?RkE0kRId4HTPO82esTMs5h8sZ4iuMyn2CC1Eo5x7Ll/YBZEnUeEqB1IQwreW?=
 =?us-ascii?Q?1a/zMs+jdqoRSw6FRekjxEF81Kt2soFi/7ZR/3Dmz2a3fGOYhEWn2WKn/8cQ?=
 =?us-ascii?Q?HGc4u5E0MLw6Yb0oGHmhLv8vDD+kXcN3ntc2HmoGp+SC9Lq/LF1Rc/zwKikg?=
 =?us-ascii?Q?TOPzMBG9j5LrudngDDYECkW1F1wAaczb4YAzKgqAz7gKHbZAHiNADWoAjukQ?=
 =?us-ascii?Q?k9NrXoVOJ0rXD/5A9itpeWYSmZbSZVwif/t6uKyQ9m4JbLFwESOqtOfvYeBO?=
 =?us-ascii?Q?5QEdjUK5PkZmtO4gNh0ay3MbNZ9gzy5TOY2CjFztpkmbufIQ5MBL6qBT/+1W?=
 =?us-ascii?Q?Rlnjqr7MRaoNmmhV+I0NDFYQMtZLE7qIbnBYQ2hUQz0jY3v52HgSMQ8X8QAG?=
 =?us-ascii?Q?ATUdK1vo+mI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KZpRcq8h7YBT5Fb8opHUVQXj5Pa3Sl1U6RxBeVF96lQ8UyChom98RivMgxs/?=
 =?us-ascii?Q?mq5ih3dL1XI24D+VpWE7T5cVVHHooQGzYumcMrLkSi5I/qYvT/GXtlSO2R0B?=
 =?us-ascii?Q?/5cH62+D56EHkIB/RIN3w9q3E/ODX+AGhs1euloimWPE81OXgbINGoVO/1mD?=
 =?us-ascii?Q?qY9OeYBBC053BayiGQwi3CxpHJqakKDafSTes+HNg7E9HA88/TexrJkofpMD?=
 =?us-ascii?Q?scgc0T6xrLWgr/bMh3g3B4Ny9bZmuclyTBRq6uQI5CCg7N81TRj5TXewPLIA?=
 =?us-ascii?Q?W8LJJl5QB2vC1xELlSgrPW4YamPgC3hEEDmSXOqjRSLs2ZSHxQkKLRt1u8P8?=
 =?us-ascii?Q?LIB8gaCDruCKKhUg6Hru6BG01SGoHKqPWPLCEI5vsWxqeGMqRs+jELvGlMkf?=
 =?us-ascii?Q?3xxBOSkyWyzCsGEhRnrTO6gSrkDK5DI8guB1JAUWrVhXdqv3hI0zIljxErad?=
 =?us-ascii?Q?1aD9Uz9FHzkmAETGAZbgrfV8c4ZCo32Hr8zBRkqXlUbCjHagHanKZj+YqaXV?=
 =?us-ascii?Q?Yw6j/24GLWCvkz5ozmkH9lBErPiJBuDA65iPgH5NwyxcDoz0hVquWXvjwTax?=
 =?us-ascii?Q?/ncRmHmnTOxnxx2xciXXdesfj9tLcN+Of7YQRXpEFybpDpSCbYngoBXbmTcu?=
 =?us-ascii?Q?oeBzh+awjdEIQnA1pAuyXOaDdFw8b+9nEmScPRmx8+yZvE8stWFVkp2XRuAu?=
 =?us-ascii?Q?iKH2k2KqPxRSZ1Rj9I2bwBQRlBFfMBhjidLLk6cvj2Jtbr3iY+G4SdD4rEuw?=
 =?us-ascii?Q?CBwqqoJm7rLlMSk+IMMfSjS1xCduLKGi9BdSxwRET5Sny4/ULLddAV0vRwEK?=
 =?us-ascii?Q?cgoask1HQkOBgZKhNOzGroJcgJLjrpQhh7BuFSYeljsOCb+ORBnhNkzsX/rU?=
 =?us-ascii?Q?88Oc246V5+/JICFCINBMXHt6VpIWOPNQFn+Hxj2qxkTanWHof6jVSumWCnas?=
 =?us-ascii?Q?8kaiZFf+L/UsuGIUF3MiszWjAVFI4RdPfTourvkDUq33nQucsmmRcxU4a2MH?=
 =?us-ascii?Q?kgyKI+BUTMqTH7CCDdxSS2hcx8ZNYOmK4iT0MCxN2A/xee9hMa5b3b5R6JNw?=
 =?us-ascii?Q?CRebqxz1qhZSiciNkz2ornMDx8l+0Cv6GaTnrsdF5wlxnlNISWJuQnOj1GSo?=
 =?us-ascii?Q?hIvGw7qK002rI/Yo9GRpuRLahHW3DpQs1ZcV1u+RLE2skt4gb4/sDHn8AYe6?=
 =?us-ascii?Q?qsEkzAbQ6T+mEAuwIa7a4+S/l5SD/og15DhJqS/qP0rZlgiG0tD79he92ATq?=
 =?us-ascii?Q?Ht4VzyxAzl/nDUDxPFRNqvEkkRywFERcAIuxlalaoC1zk89Xi+uc5NyG/dVS?=
 =?us-ascii?Q?rTTDHZBCDcC7jZRX7RlYi7g0Olp6Db+StkH3MFQ3kKoaA6ePBnxl7pBEdgZB?=
 =?us-ascii?Q?0xqFp6tPcIPBf1j2rWkV6TbdXemPt6mEo0CCrXuYAUbcXKq1Bc2ccRuSpR0V?=
 =?us-ascii?Q?eSLxmXWB1wCunztDR/CqazqofTZd2fh5Z9kHH9DsDg/+O5gubwgc008LFv+M?=
 =?us-ascii?Q?3kw1XoXKZogpfpnSJMS1ntCW/EJKmNNzQ6+bKs+NLfeWkUMM6qjGDP80HL32?=
 =?us-ascii?Q?Ttn4A2zDH7uTxIdYMAd7yJu4PATw5ru9IOxzMMCHi2FSWNgp9V8GPOhYpM/o?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DOQWE8jIr9PgV3xWRdFxJFzhCSc5fzWnf9/QJ1fjqfJ46DRO/jT/1ivvTCILQ0T3zyQawB7Rne4yAoL2QBdrY4XHSeNP8n6avmWq/ccEb7z5VmQG50udw+aeDJD20KKva4OQr7fxQ+WzXE9TX8zNRi4RZDPW8Jt5zm5oKEmji8Nw/gDPeGIyM5XAtCUs614oYSmp6ZDYtpGmgGdRTerwioJmSuyP9unjtDuM7fdq7PgdsiFRjeLYcFe1DpjsMpJ9mLiPpLI1kPHpH+jmr16p+UnNyLZpWq6mpyra36cDVMXW2s9qY5w1SFqM7PZ1CufZZpUGHZ+ZuRujYyiMoqAPTLfa5yl/t2zECXdErvS/dEKlomljM5/pygZ6EvIhmNMDdGAvNCbhw9Bap0SOeDt6Em9qHX7BmY43uMvXE+BErvar0Cl3KBBivOSMQht0reeQV4LGmI5wvCouQQXkj3Z5PVtVoIDkDGl2KMbKkVoFv3VqwIi2E6IF06QEr1Df8CoR9JOGiyNxt0+GsZ2fOnNa9DhxiHzhyoQ5sfGUyy2HLUN5b4RiavKeM9sb9VAo472vv/POcP1/R5mtOF1lFNiliRh6Pw6eLeXcPH1wa1hnbIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5453496-7633-40d0-ddb4-08dda8c8e72b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:18:18.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPhsBMiHH41WbvXsGO+Otd/bYli259CHn84KYEejBxLcoHB2omkNvm8yOLT+KeTGuUqeqb41ZP7WJnaosDSm3bTpCD0MneMsFWAjG+XH19c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF079E800A3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110079
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684949de cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=i0EeH86SAAAA:8 a=W4j0X7xJt7ay5w93VlcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: HKQ7LtfPvNTObDvd6shCKWYv4wLJXBdk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX48c9hTOTAbVs XA0csyE7f/R7GbNV5NU3Dk2HLkp4h1WpVTBphQGP22/04GyySuwuoeJT6P9oz3LF/Fu7L8CCm5o qXl6K5RtT0iU8nS3iYnaJn8M6zHA4qsCYDSKWBCtpr2kzMNtu6eltzxv9zgxp79YOMFt+y6FGf1
 Y2t27vo00xlMZrb9IgA/1MuH58S4hEGlD2N8XwE2A6BSy36/ssCSrf/fItxwESag+EPtts9UteU 5LWjrTaIteKl03C59pLMJcTbkhbwl0cbTCgYo+CoVIU5rEpVd2chLG7VdBYvLm/BUABHfQaQzSl ug3irSt3DHanDD7cUEvBFKpdj27HJIw9CGLI/yBuZfVzqCFFHno5uv0PmEkIJZAoukFAfvg2KR6
 D2CnqkK8YNqP4vMHvEkkHOcODobKudUM5b7Af/D8mmLmb5MAQrKMm2qd4gqtAvYtfL8v/Dm5
X-Proofpoint-GUID: HKQ7LtfPvNTObDvd6shCKWYv4wLJXBdk

On Wed, Jun 11, 2025 at 08:40:11AM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> As generic read_sysfs is available in vm_utils, let's
> use is in thuge-gen test.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

It generally looks good, just one point about a warning below to address.

> ---
>  tools/testing/selftests/mm/thuge-gen.c | 37 +++++++-------------------
>  1 file changed, 9 insertions(+), 28 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index 95b6f043a3cb..e11dfbfa661b 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -77,40 +77,19 @@ void show(unsigned long ps)
>  	system(buf);
>  }
>
> -unsigned long thuge_read_sysfs(int warn, char *fmt, ...)
> +unsigned long read_free(unsigned long ps)
>  {
> -	char *line = NULL;
> -	size_t linelen = 0;
> -	char buf[100];
> -	FILE *f;
> -	va_list ap;
>  	unsigned long val = 0;
> +	char buf[100];
>
> -	va_start(ap, fmt);
> -	vsnprintf(buf, sizeof buf, fmt, ap);
> -	va_end(ap);
> +	snprintf(buf, sizeof(buf),
> +		 "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
> +		 ps >> 10);
> +	read_sysfs(buf, &val);

We're losing all of the 'warn' logic here so if we can't find
/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages when ps != getpagesize()
we no longer print a message about it.

Should we reinstate that?

Other than this, we're ignoring errors, which by default means we return 0, but
this is what we were doing anyway. It's only this case I think that matters.

>
> -	f = fopen(buf, "r");
> -	if (!f) {
> -		if (warn)
> -			ksft_print_msg("missing %s\n", buf);
> -		return 0;
> -	}
> -	if (getline(&line, &linelen, f) > 0) {
> -		sscanf(line, "%lu", &val);
> -	}
> -	fclose(f);
> -	free(line);
>  	return val;
>  }
>
> -unsigned long read_free(unsigned long ps)
> -{
> -	return thuge_read_sysfs(ps != getpagesize(),
> -			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
> -			  ps >> 10);
> -}
> -
>  void test_mmap(unsigned long size, unsigned flags)
>  {
>  	char *map;
> @@ -173,6 +152,7 @@ void test_shmget(unsigned long size, unsigned flags)
>  void find_pagesizes(void)
>  {
>  	unsigned long largest = getpagesize();
> +	unsigned long shmmax_val = 0;
>  	int i;
>  	glob_t g;
>
> @@ -195,7 +175,8 @@ void find_pagesizes(void)
>  	}
>  	globfree(&g);
>
> -	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
> +	read_sysfs("/proc/sys/kernel/shmmax", &shmmax_val);
> +	if (shmmax_val < NUM_PAGES * largest)
>  		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
>  				   largest * NUM_PAGES);
>
> --
> 2.34.1
>

