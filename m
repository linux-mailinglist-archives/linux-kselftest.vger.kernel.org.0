Return-Path: <linux-kselftest+bounces-28810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECACBA5DE59
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944CA1896E8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20BC24A052;
	Wed, 12 Mar 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NJMpWxpI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ebhwm8e2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178823DE;
	Wed, 12 Mar 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787409; cv=fail; b=ed6EFMcGtPySRbyivSIFhYYHQDOKo3wmCdItlgdXdQL/PHbmvHpxQPaXyKsNXjw+kbFECWqB2EURmfk5bMFcFa+hWu7jbe4p3l+eIjz/YMctqEP03o29cmpnGVCozZ11dt04QfGjh4g43J23ln74OoI28E3fqnEHz7bQ3IUzL78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787409; c=relaxed/simple;
	bh=q+qxur5OiqQl2DYh7XJsJFNdaavpfrTJd0agd+QQRu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GqiVGJCMD0t7Mi+XGiOrJX+A7EyLOCCMC9RJSbGR+B2kPRuOY/NxIGfDWAXWSPbP0dCVJnRfei49G+mlG7MJe40NmSlRl7Qaa4t3p9bz+8Y71P/U3ZxFiMb7kEEMv+8YjY6FkPL0xn0fuAyC6JzjveTqlU7vWfB/XtRK17Jjkew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NJMpWxpI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ebhwm8e2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CC6Efh016876;
	Wed, 12 Mar 2025 13:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RTeKHsYlV+lN/dQ2lWr733UECzCAaMLcdxkBzbD6Kro=; b=
	NJMpWxpIK9/GK3Lq4M+fnpf/AtVZOe5PBz1lF5AOvOijfJZVk8myIMdExtpCErT7
	qAdho6TBKOZSzCJNMXsCOO1QKGKs+qmrEgH8m0CJgcfLWbw4z5iQX3YWhPOK3c8h
	GXpYGkHZHk6E0/2mfzn0wA8A5IDBfUBW5iyTzSzxbNBYVuSzkxb48XMA7MG4vt3C
	LvG6gS99Lu5Fwctte7lmxHX53cT3XrGbpJ4vVF2c+/JFzLJBr4B9JOgy6Ymcm5qJ
	2aKDuVcdo3Qp9rZZQcAtlfbBPTZxAt/736m9EILbV70xA+Oa6j5ysY7fnwDFdryX
	8pKwK1fFDZVH3Nj/ZWZezA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dstsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 13:49:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCvGHx009491;
	Wed, 12 Mar 2025 13:49:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn3aaxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 13:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uaa5zGlmhyJcmp+mD4Ay3kFMHzGA4R1iWc5jcpvHietUvO7A3TyYBG5iwzz2mJZIEYecLAX73O3AEEMNQPn9gWYP6OT9qwiaw5phgRJQQoQGo+qEUElIdAbaFFGEgPJXzFoyKEdKmEHwF6fIMZIuWdzBwChctcoMulxpPY02/dmImDaPX1s3nQHikLueEztDC62Qx4WlscvJKQkpOjijSufIFH9Jc/BBiIGPXTegg1mI8wVw4TsvbQlZBqMfKdS4d+v7ilj0Hx2CnRKi2QIY7Jx3DGTXhMbMzFVLQKt1qkuOI1ac6P3/UqIMsk5JYTZJ/LDqhziQlEW3YiIglf8loQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTeKHsYlV+lN/dQ2lWr733UECzCAaMLcdxkBzbD6Kro=;
 b=l80GdQpaNPJMrH34GC+9QLC49TrkcgRL6MfQ4Fwtx3UGMOn7yRSLGQWniYRxOU0Ckvde7NP20C1cy8T9YD+ZmWL88dGon1CPJRpNv5cc/IYRGic6atSGtSrwfMDdYjkf5t2SlzI88CGPdTaREY7Ix6ugSJRUAvENSY+9GDwEOso5z/AD7IXgScVRwSv4dGZ9+DzPzy4tXk0AfWWbp6CMcMvoTBL0NoS7dv+i+31plh+cPMK5Ozs4CCIaIKOmtiQiaGZ63inKVGFEA9B61fD5O1Sk1m+GorSaH3pA4Qit5YazUxQhQsL6XrSqR83iFTtnpGCzpcahgrRaUt7YKr4o9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTeKHsYlV+lN/dQ2lWr733UECzCAaMLcdxkBzbD6Kro=;
 b=Ebhwm8e2Bq/ysD+gHNY1z9zE9MM/tyo93XPTIW2N7EZbdyL9hZ1jLKh8HZfVewuoVdC73fmS2sH/He4G3fZH1Dg/xCtBrZTB3lC6EQeMn8Bj9+wuCKKzM7u4pl/LhChUsYuuHB4FMIE3N8NtySXtIHrhFIdqiGjzZ20Vrq2cBzk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 13:49:42 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 12 Mar 2025
 13:49:41 +0000
Date: Wed, 12 Mar 2025 13:49:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        broonie@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, keescook@chromium.org, pedro.falcato@gmail.com,
        rdunlap@infradead.org, jannh@google.com
Subject: Re: [RFC PATCH v1 2/2] mseal: allow noop mprotect
Message-ID: <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local>
References: <20250312002117.2556240-1-jeffxu@google.com>
 <20250312002117.2556240-3-jeffxu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250312002117.2556240-3-jeffxu@google.com>
X-ClientProxiedBy: LO6P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::7) To DM6PR10MB4106.namprd10.prod.outlook.com
 (2603:10b6:5:17d::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffe967e-829e-4ef7-c98b-08dd616cbcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUk2TE1iNzN2NzVTYXdVZk5qV2kweXBlcEhtQkR2SlhTamJOSmMvNktJaVRE?=
 =?utf-8?B?clJXSmFiczk2YnlBVkxVRmZqNC8zTHRPK09jaW9CM1hzb2ZGUGtSU0NwL0pv?=
 =?utf-8?B?Q3k3WTVzZUYrQkpRVThrcEJrQ0Z0SUZ5ZllYYURtT0RNTjI2czdsRkhPMjJr?=
 =?utf-8?B?ZU9xYlpMVG1FMkVIbnlzdkM1NXY5aGgxcnEyNUQreW9BbXpOYVFWSDZHa0pr?=
 =?utf-8?B?SW5YbXVCVG9xcmp6RWI1aTlITTZrUTBEV2llMGtMRlU2ckFhVVRIMVJlbE1s?=
 =?utf-8?B?RTdlcVJ6K3VyaGV2NnRBUE9tdjBWVFRacGZGK2dhQktNN05uRTRLaXdueTVJ?=
 =?utf-8?B?OXlhTjVGZVZSRWlmRWZnQzFYQ2xXb2FEd0tYTDVDOTRadjM4dnQ2YUR6S2c2?=
 =?utf-8?B?K0JJSjMzVnI5cDBhQ0E0OFBKTlgwc2JwTnBvLzZIOThlbTgwakxlOWQvRzNx?=
 =?utf-8?B?M2xLVktLa1hRQ0ZmZWgzdDlHbFlDclhRYnIrbTgybDZoT0ZWWktRWmN4V2FC?=
 =?utf-8?B?Zm9OSFRISjNKT000UWJsSlQ3eHlIWlRHVWs0VHhGdGdkNG1ZZmdoVHVOcUE2?=
 =?utf-8?B?K1pDZW9nZmhsRGFHUWxveTl2dXBNSGxoRmttWXVNYmZqZzhXV2VDZFB4dzlo?=
 =?utf-8?B?WUUyb1I4VnovelpsellPVFgyV1lYQk81OVB6bjUvWDVOZ1JVUTloY2MzaDVj?=
 =?utf-8?B?aHlmenRJSDBBczB0TnBmSUxVcUIvVGNBVC9VdFlwalRFcEF6MjBCK0F6SFh5?=
 =?utf-8?B?Z1NudTQ0TmVvU1hDL2FmU002OUh6d1pUTVBka3hyWlpHampWQ3VhbHlPNW1w?=
 =?utf-8?B?L1NMY2lJM2M4cS9JVU1mQVpybUozaFh5L1cyZXhBdGdOSGg1VjNENWRXbW1D?=
 =?utf-8?B?eWV4QVpXamhwZ3ZuMjRKQkY0dnlrT1paY0tzNlVheGdFMExwM0Q3alppb1N6?=
 =?utf-8?B?dGZ4SFczV0lHcWlnS0M3ZVk2R01kMFpuZGI3RUVNRmtDU3BCYWFUdzVRR3Nw?=
 =?utf-8?B?L24zUkErdGE5dG92UTBaa0JPdVZPUUlzYjJoVkltTXh0MVY2TEZVRk5SbXpP?=
 =?utf-8?B?NkdvNytvQXYzS1J1YjUxemtMbEpMdmZjd0hJbzRYY0tKRW1LdTBJQkYwdHB5?=
 =?utf-8?B?blNmNkhiSmZEb0oxREVCVFJxSlZOTldYejFSaGVSajQwYU1lZmF5Zy8vcmhw?=
 =?utf-8?B?WGFTYURweDlCYVN5R1FnNE1iaEZMczk5V242UVQvbXlzejJadXk0WTU0QWtI?=
 =?utf-8?B?eHAyVVBoOXEvNXMzUGVQZmU2SVJKRWhVT2N2OWhxRUxpeEJSbWtrZlE3N0Q5?=
 =?utf-8?B?L1k4MVBtS0ZYaVo2WkJhdjN6eDVPdE1LbUVsQVgzanJWbkVNQVNSYVlFeCtz?=
 =?utf-8?B?bkRkMFU5UHNraDlZMCtCUmk1WmJXTzdnTys4dG9ST2ZhQ29hYzFkKzM2TEVK?=
 =?utf-8?B?NEtqU1AwU0E0TjRMRG5Xc2FXTWErb1NEdVBEbzlQNnNSTG5rRkxXQlRZS2k1?=
 =?utf-8?B?SWsrUjhXeC9DTGJqeGhPK21mN250ZU5HZlFRRHltRzdZVlpwd3NUdUhjaTVR?=
 =?utf-8?B?NHUyVlBlU3lVbDNzQXhXSVhDMXA0ZXFOUEM4VWcyWW1xSWNjdlNaQXBjR0F5?=
 =?utf-8?B?b1lrRHJCalBLbkRaMlMzcUdseGNPeW9YcXVuRE5IY05EWThibW9DTmpVMHQ4?=
 =?utf-8?B?OGw1cDZ0SUo1Q2t5aFBQNk5kek8wVEdkMnVjc3I1L1p6QXhUc0xwWXFmNHNt?=
 =?utf-8?B?UkFxTmFmZFRtWmJGb2RQUVE4VHhLdkhhR1lvci90dXg0bEhKSkdjeHh3V09G?=
 =?utf-8?B?dSsxTzRzS2lCaEt5Sjdsa0tkNlNmVjhGbUVpS3Z6NTZzSkdBVEJnVGhITkRM?=
 =?utf-8?Q?Ok9Ley7J0W2wY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXZmMnVOMEJUSGRqMmZ5RjVIZUsrU3VmZUNTeWpZTlZic3hISm8zMGxHc3Bm?=
 =?utf-8?B?RU53blJaLzRZc1VFUzZsd1V4c3I5RDNLWVRxRjI2RFd1dERpMG1ab25HcmVR?=
 =?utf-8?B?UTBtVURzM05FMUYxaHdkVjBuVm9sZHpDSmY4YXI5WUg5QjM3N2Z4aUpvTktU?=
 =?utf-8?B?amk2WDExc0N0M2lXeEpEUThFZWg1eGoxYlgxalAwT1NvMWNMZmYwelpwSFps?=
 =?utf-8?B?VjVWS1FMOGNLZmZZbDBnVUdyNDg0V0JQQVZScmhad1JxcXYvQlN5aEdBdzB4?=
 =?utf-8?B?bWlWUDQ5RW9xM3RJQi9XaURXYVRwUGk3ajhPSHJCNm5ZQVhXMUJlNExDd3Mr?=
 =?utf-8?B?TE4vVVZ4OUZTbmYzdG92bENBeFE5VmRiUUZsYXU2MEV2NUVZYkk4Ukp3M3l0?=
 =?utf-8?B?YzNNckNXb2l4d3BkbmlnemRLeCszVk96ZDlnVGQybXZnaUVITTVMMXFRU0FR?=
 =?utf-8?B?cFo0bmhCYkFnMlhwNlBEV1djNnJvYnduQ0szMWtDdk8xNG1lTVZONEp5ZlhR?=
 =?utf-8?B?OUxVMWV2RzdxYzV6Y3AvVEJyd2NmUlZZMUxEWmdkQkh4aExweHM4dENMTHFO?=
 =?utf-8?B?R2svL3RUOHRHdXZyVmVCNjFDVUdJZFdEaGlGQUhoZU9DSUJCT3hXQVY2dll2?=
 =?utf-8?B?YjVZZ1BBUGsrS2dlQzR5NXdJd2d4U0xMNU9Xc2I3b1lnVEdaVlAwRjlHVmJz?=
 =?utf-8?B?SnZqUG05RXdrcHdzWnlTOHNKbTBYZlROVmJFT05kbkJKMEMrRHhoVWVyT3Zt?=
 =?utf-8?B?bzRvUEN4UUdxeDRxZm9XVTBCSllKNkpGZ1gvdVRac1M1ZjFtaDhPdU5SajBK?=
 =?utf-8?B?Y3VKUmZGNkluS05GQVRjelFFdVhGK1hjM0l6RGlVZ2RoZERnVUlvQU9valVM?=
 =?utf-8?B?OHlNOFdyYnNycG05QXk3OHdQSTNlMStWZmR5cWlKYjZPMUpMMTFSQ0xGMlFQ?=
 =?utf-8?B?UzVnTThVOVNadm1peVNEeFlabmR4ckRXZ0d3aUllM1d3aDJyZnp1clV0Yzgx?=
 =?utf-8?B?RGxxbWROZWFWVHN5elZqd2IvUFhXdWVIUGljL2I0elBvemgvcks5aGYzSU5j?=
 =?utf-8?B?cUJUZlFCTXljVStMOVVBakVteC9BT0g2WGVESk96SElWaVJKejhpdENrb0JC?=
 =?utf-8?B?RFBQT2hlNXAxOEhKd0Q4NjFNV1QvRisvM2lKTzlSMC82cjdEeU1oS1hPdEpl?=
 =?utf-8?B?ako1bjhuVmk1NkVodWZOWEFMNzc0NGlJWk83aTdHell3VTIrbUZVcVYzNWxJ?=
 =?utf-8?B?UGdnYlB6T2ErZ2JVMGlpdVMxbG1Vck5zY3JXb0lBbkdWbzlTbVJkcUJhY2pR?=
 =?utf-8?B?L2UyUFhqRzFtVGRhSjY5d0ZjR1NHV1IxR1lhWE5MdWo3aURCTjJjNWV2b2tw?=
 =?utf-8?B?VjJjdHNNRXJjVkd5bEltNWtRb05PYWliOTlJMFZTdlF3Rnc0b0c3d2J6RnBu?=
 =?utf-8?B?SHdUeXdWcmdTMHM0YXg4dlJwUlVLb3FjS1pma1hoazV4WDV0NDJWdXdNa3FP?=
 =?utf-8?B?UXgydURaU040ZjR5UXFUam9NOEo3ZUxlTDYxN1FaazExeHoyRG9lTFN4dEVN?=
 =?utf-8?B?NE9kUSt6QUtLRHZDbjRmYi91M3liZERoNlBwZ2QwTXhlZkRMcENNYXgyUzE4?=
 =?utf-8?B?c0ZuaTBxSXpFc1ZobHA2aW9zWlJKUnB3b2hWcG4rZWMzQXI1OVcwd1IrUzk2?=
 =?utf-8?B?aHErNG03dXI0d1lVSytIMDVJSGttN0ZmcWI5cXk5MnFnMEtiODRXNVRySnRD?=
 =?utf-8?B?ajBueXdJMHU3N2tnS21nUWxMa2RvWTh6cFlMNTlPRnl0VnVLb2NlakJMOWxW?=
 =?utf-8?B?REt5SU54b1RnSWZ0ZkloU0JUWDhnYTBlcmtuWnZWWHFta0lKN0k5dWp2cVJv?=
 =?utf-8?B?ZHdkdTQzWW1mblpTVXFnVkFRTTRoYTVOUmd4TGVNeDRmRGFIT0NiLzh6Zmdr?=
 =?utf-8?B?MWJlV3VEeWdUQzlJM2pmWkUxSXRic1g4dGs1NXE4VU5uVlc3aEFiZkx0MzFL?=
 =?utf-8?B?TGlZR3p3b1ZobWx4dm1uV2tTdUg5aDQ1UHc0cHgzUnhpOXVVZ2JWQmVPUDRh?=
 =?utf-8?B?K1dDTEZvY2JpUVltUUtTRXlYYU16ODNoRHpGYnROV2hFSGlkZi9YdVFqeEFL?=
 =?utf-8?B?aVltY3N1VHVRMFNBMEhneGo0N2pkMEZaekorS1ZEZ0xDdmdiUnMyUVpxeGZz?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tlll/15HFjrjD3xDQ7rF6BtaL/o0dTZMG8NzGGWiXpoXUW+RufYE1USPnjJ/pIEGHNau8Ostn1xsXi6aYu2Y7G37Kx3KE9T1FvEgOWMg6P9Nx+pdT9Hu5RERZAgIRZrK63gMGRuVUxc5bduBZu7CtE68r7ZU79EaN21F+O1xU/IWcyjefkSzSNpCgNranKkM0h/BpdERE3wxvOftxBXtlWpeMgvT/vvWPg/OHqdI95PnFE5EZd6/rO4hqpl4XfnFfjRLyCTqzVFZRWwNVAjOvIWh1CTmsOFn2bLHPiCUgoMHWhO9LBGPcpkfPzUuKmHpZk1y6Ok+6h5ps7jpDvovbmfD/hdTeYy7TKgJYUlUaPLhMES4yZi/KXK4ISqS84RVFThy0L8/2pFc+yy835EbpNWU5vtaw1kguNY/rZeorzqGq98Xwj95+hXRwWSE5pF41hMFySmTfO8xVrR/jLKUoLo6dnQOGL3eJ/xeovA5D9JBcaFMfu+NQlnJxPEcijEIMrynlNqHRcn5JWrhJw6Opt7dPa16xWGQX+QQ8XmnbNFi3zP/jlDbWJwBJNsb4ylZlGQi6WRVLrVGgBNrduDJjugtgK1oqCvdtBBvPTP+p9A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffe967e-829e-4ef7-c98b-08dd616cbcfb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4106.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 13:49:41.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C1O/vxmnRownTBWDE0zQk8YFQnffKDSzEhknI7NY7ZezG7PQ0bpHkH1R8fMwbS74uTAHMamuSZzNXOx15PhNPNHc5rC7QL+Bs5pLziwykE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=798 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120096
X-Proofpoint-ORIG-GUID: -UIG8NARQSwg731yvfUJfNznjv4rkHE6
X-Proofpoint-GUID: -UIG8NARQSwg731yvfUJfNznjv4rkHE6

On Wed, Mar 12, 2025 at 12:21:17AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> Initially, when mseal was introduced in 6.10, semantically, when a VMA
> within the specified address range is sealed, the mprotect will be rejected,
> leaving all of VMA unmodified. However, adding an extra loop to check the mseal
> flag for every VMA slows things down a bit, therefore in 6.12, this issue was
> solved by removing can_modify_mm and checking each VMA’s mseal flag directly
> without an extra loop [1]. This is a semantic change, i.e. partial update is
> allowed, VMAs can be updated until a sealed VMA is found.
>
> The new semantic also means, we could allow mprotect on a sealed VMA if the new
> attribute of VMA remains the same as the old one. Relaxing this avoids unnecessary
> impacts for applications that want to seal a particular mapping. Doing this also
> has no security impact.
>
> [1] https://lore.kernel.org/all/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/
>
> Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modify_vma")
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  mm/mprotect.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 516b1d847e2c..a24d23967aa5 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -613,14 +613,14 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	unsigned long charged = 0;
>  	int error;
>
> -	if (!can_modify_vma(vma))
> -		return -EPERM;
> -
>  	if (newflags == oldflags) {
>  		*pprev = vma;
>  		return 0;
>  	}
>
> +	if (!can_modify_vma(vma))
> +		return -EPERM;
> +
>  	/*
>  	 * Do PROT_NONE PFN permission checks here when we can still
>  	 * bail out without undoing a lot of state. This is a rather
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>

Hm I'm not so sure about this, to me a seal means 'don't touch', even if
the touch would be a no-op. It's simpler to be totally consistent on this
and makes the code easier everywhere.

Because if we start saying 'apply mseal rules, except if we can determine
this to be a no-op' then that implies we might have some inconsistency in
other operations that do not do that, and sometimes a 'no-op' might be
ill-defined etc.

I think generally I'd rather leave things as they are unless you have a
specific real-life case where this is causing problems?

