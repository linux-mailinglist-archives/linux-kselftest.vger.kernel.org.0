Return-Path: <linux-kselftest+bounces-20040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA39A2D91
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF671F22C91
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DD3227386;
	Thu, 17 Oct 2024 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FUDV2g1V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a0mE+CS2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9D16C854;
	Thu, 17 Oct 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192592; cv=fail; b=hxCPj+54lJetpxkBqvH+g/18hUDCKnlsqSoFOMLmMfCNk10kNiNnV7CemBaZX65n1CE4F1jHI0DVGtBwYIre1TnG+8HTtpBJiBpsOYx97Os6iHEDMU+2rfN+jFtzNk7EBXfanhM88gR7da4iJNi7qzBb0/tYO971h49B7pr3qHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192592; c=relaxed/simple;
	bh=W/sBnPpdfUw59PvZDfnKYWGZQ1I0Zss33kf+AY49ex0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FU1fMROA9vAoJcxBoAUNqSoQZreaDgU0h5tu4q/IAyiu0N427poU3OQAIJVLuqFjfTFDy823zAqoPEGp/hK0IL4kxTerFiRdyVnACpkoLfGI044KvTuk5mqRgOyv2TVh0/DdHgpe/SpxffzTGsIaFpSxPoPKYNE+uorY7KDMmD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FUDV2g1V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a0mE+CS2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBdOb000312;
	Thu, 17 Oct 2024 19:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W/sBnPpdfUw59PvZDfnKYWGZQ1I0Zss33kf+AY49ex0=; b=
	FUDV2g1VL/tfeW1HZdCIssah8hBLMWJm7+kYYwf9l2iUxmUw1gn5TG4P5cByc3W2
	aL36qhEGNvYTB4C5l3ZYW6nrABa8WyT6urnoFBuoCvv8xPats03KGgYJph+oC7Nd
	baySv70aLXvPoMck7vDKiBBz9kFFVwv9csigWBDiZqYCSfLqEZrLlG/l95Ysc4W5
	r9xy9Q0JPa6zrjEFp/b6A0r+DgSIoiVoundUmb6q8pesS0PTvje5ZAA1Kde8q36s
	mrI7ifMMQ0+Ivnuzwe1RF1RIRRLZ9s8tjYEd40fIZoKVQZj5+2wLpIJfse/8Q227
	NwYc5uF8QvA//7Ws4fyWjg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09pntc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:16:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJ95NY010401;
	Thu, 17 Oct 2024 19:16:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjh1009-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 19:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kObZGjvZF7TzZbDkufHCr2QipwNGyb9kwD2TPKRGX9KrPvPFRjuzYCeKqvKG1mt3PpSyjjxTeV+IgxA9ROhRfJTtcohU35wrXVEDK3L/hZmhNkTLJ+VbCLCQptLOSc4KUEGpMJYgwbynXEDv2a8ZBF0Cg6nUo7wSOYHjgHCczRcmKh1mqRqYduHhtFajD5kl9OBEiC71tjZa962Yx0/MDjbExQFw5Wc5UrBCQrq4uiEFY8P7eXsJrLpvxHp0ndZ2OVN5uAdRWgUv/g7O8S8pWpmkETzHvDvK9iEwoZQsr6V16+92to5mhChkupWJK3ZBvEJUhx/hwOWMMxVZPbGqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/sBnPpdfUw59PvZDfnKYWGZQ1I0Zss33kf+AY49ex0=;
 b=hujo+B7StzsVnA63IhLUwliYvrDARJeXmGdcNUMz36bywOV0rKS0uocBRsOp9Hfd+tckaMb718+Dplx/gFubXaPdYzzynikBKGZCl9omFfCsS4v/CPeShXsXSeBlRwCcpEFqOV6+L91HNwcSO2HGXwWtfPnQSNlVyqpmKyRol4+RN19zU3JkxXFHoogQj3HYFIMhOhs/pyR6k/o/FMl2TRwpbWh7FNx84cEYo7g1tcNyCJd45R9q2OoTKwCz8AH8aj+WLiYZOkucutSv7us2kjD37VJTyxdSCwjYESgrBbfymS10AvI1P6jo2A1qZuMMF/qNzFHMnAbnTvEvD5cVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/sBnPpdfUw59PvZDfnKYWGZQ1I0Zss33kf+AY49ex0=;
 b=a0mE+CS25oAB+AJgmnkDZILh4IDuMnKE8dk3oyPIMdDtXIhrnALsB3d7tmCYERE8VAVhA7fh6i1GW9VM2BJxp8qS1A1bx0unAOUF19XYD683To5ugznFBEkTUi/3ovERLyPsAhiSkS6arb597cU5cx8Kpne62DODxJCadiWehCU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB5754.namprd10.prod.outlook.com (2603:10b6:510:148::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 19:16:09 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:16:09 +0000
Date: Thu, 17 Oct 2024 20:16:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
        keescook@chromium.org, torvalds@linux-foundation.org,
        usama.anjum@collabora.com, corbet@lwn.net, Liam.Howlett@oracle.com,
        jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, sroettger@google.com,
        linux-hardening@vger.kernel.org, willy@infradead.org,
        gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com,
        merimus@google.com, rdunlap@infradead.org
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
Message-ID: <06a5922f-ba94-4387-901b-c4f1fb154950@lucifer.local>
References: <20241017022627.3112811-1-jeffxu@chromium.org>
 <3a1bbbdf-1281-4f44-857d-58cba583e3da@lucifer.local>
 <CABi2SkU2yX_Pbr6=6uEiQnro88O5Mhq3NLwOsy=A=Qa5xeC6Yw@mail.gmail.com>
 <zcizwa4wasrq5si6nsjvougg2lt2dklaujpshdmghwg7oejhlj@zxzqhyff4vba>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zcizwa4wasrq5si6nsjvougg2lt2dklaujpshdmghwg7oejhlj@zxzqhyff4vba>
X-ClientProxiedBy: LO3P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0a5b91-d2f7-43ff-c621-08dceee0283e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2d4R0pMZnJRVXV4aVc0b0s2eXZ3Tjc3WXBsUXZkQm9COUxBN2RrbFFHZFo5?=
 =?utf-8?B?WjlHWGZXSlRMeUJNUWVwZTQ3SW14ek9rUngybkg2SXdjTWZmMGFzUmN1YVlS?=
 =?utf-8?B?V0tUa1l1SHI5MFF1QjUzZ3l2eEduc1VGamdXaWw0MVBNbkwrVG5jaFpJQlUz?=
 =?utf-8?B?RWQxRHkvdXlpOUJaV051enZpS25vTTVFMHI5OUM4d3UwTlRvTGRZTGs0OXpC?=
 =?utf-8?B?WldGblVtblhhZ3NtZTRDSkNtTzN1YW1uRUU3Yk1yMFQySWJUVXFMRVkxWTRl?=
 =?utf-8?B?bGIvbEk2bmFPVEpMZUlaU0IwMFRtZG9ocXhaZnphVWlRdUdWY3pSMCs4YnBC?=
 =?utf-8?B?OWx0NDNtSysydlNzOHVDZ2RsZHZodXZDZVRpdTNHcE9Mc2RRSmZITmEwZWQw?=
 =?utf-8?B?NStmbXJKSVJVL1hoS21PZi90dTVHK0dEVnR1ekttUldYeEJvM2RWNzY3K04v?=
 =?utf-8?B?dXFQaWh2azNaZ3Nnemp1RDFybkk2Y3pjTURZM2xTbWVTY3VRaHBSNHN6anZ3?=
 =?utf-8?B?UmxMSmJGdFVqbmFhVzQ3YmlDMzVCRGxHUUxrV0xyNFdNaTlYVVQwM0dMclFT?=
 =?utf-8?B?ZUpzTjBOTHYxMTBrYk1JSCtGOEoyK2ltUnRmLzJzVi9TSWk1V04xL21MWGZl?=
 =?utf-8?B?OUFtRlJxVDQ3VUVNMU5uUHhYT0hPVjAzaFozcTF0ZFhwZDFyaFdtTEkrK1N4?=
 =?utf-8?B?VzUwdldiN0ZyL1F5WHh2U1lBRWtkM2Z4NThKb0ZjQUIwb3cvckdXVVBYbVlv?=
 =?utf-8?B?QU1SbnJoNngxaEhORWFybFVyZTNqVWZYMUJSZGFzYWdHcVJTYnh3MzBhdnhL?=
 =?utf-8?B?WmpENUc4UUVseVFsek1lVWc4TDMwVG4zVkdrN29vOTh1OGN6VTVKOWJkOWVy?=
 =?utf-8?B?TDZxbkpkMThURkhLR2JMZFhTeU56aDBVZ3NlR25HLzlyZDlJN2JWaXZyOVdV?=
 =?utf-8?B?Y0w0ZFpQRVVKWTAydzV2ZlNhTzFRS2FXQXgwaEFaZGlsQ3pZdGNodmlVUU9s?=
 =?utf-8?B?QlpESHdZNTNPVHhML1hlQzVzRTJFNWJnUmtWOGZpVk55ZHRHWndhdkc3Y3RS?=
 =?utf-8?B?VDdCN08vUGo4TTRvSGloUDJjSUZVZ0VDL2pmaEx1dVQrcmtVTksrQ3U0UFRp?=
 =?utf-8?B?RWppZndCUFpVQSsvNVpzZHlRbXlXbGR2SVVZa3lmUGtDK3FvT01hOUdZTTlp?=
 =?utf-8?B?Z2RucndLYkVwZlcwdDU1VGQzOXBNT3dhb21FVE11UVl4R1hUa3JiK3VqNWs1?=
 =?utf-8?B?clpSQW4rai9RZktSWEkwZktNeUZiZFBiMGZMNkhYTUlVSGcva2Z1a3ExVHZs?=
 =?utf-8?B?UkZGbVlvWmpRS2RuRnlBcmRaNmZ6a3NIc3RhQS9WWGRZdlJGY3pkOXBwcm53?=
 =?utf-8?B?VmQ5U1prdENwTnpVSkRUZDBjcE9qTHBnUXdWeGZ4WGpVTFg1ZWFKdzc2MGsy?=
 =?utf-8?B?eHIwL2tseWtvTFdQQUlBdWkyd2RMWUNIQjJFd01wNGpRKzBXZDVWN0gxVFN3?=
 =?utf-8?B?TXNNK0hrUmVldlFBY3cwWjF3SUxwTjJpL1NFYWtQWDMzMk5haDBMcFNTVFRK?=
 =?utf-8?B?NGxNSk5KcWpLK1d6VTFQSk16UURRYU5zTkVHQWU4MzlhdGZab1lxcG9uVUpE?=
 =?utf-8?B?QWJxdHB4SXlRSEZPYitnSm1KNXhVYVVTM2NYU1g5U2E5WkU3aWdLQVlFb0k2?=
 =?utf-8?B?U1k0Q1U1ZFBwbzUvY2trcFFKSENIZlNjcHlPYkZLL0hNL0xyRWxUQlA0cktT?=
 =?utf-8?Q?cUKwoQ8/qUxeDJrpKO3i33Xayoz8hmhe0VkKm9j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWcvSHE5VVBEaVdiUFhZZGZGWTlVWCtzS1ljbUw5YUg5OHR5QVdPT1R1NzFL?=
 =?utf-8?B?R1hKbi9jamxiQi9CY3lZQzJObzdQZnUwNGh2azJyL2owUko1QkNxaFlkb0RU?=
 =?utf-8?B?OUVmUWlKZE15VnBxcTZxWkZzb2VHMU1FTXZUVWtCZlFMdG9Ka3lUcUwvRzFQ?=
 =?utf-8?B?dS9aUEpvSmZTdXZYTWtjZEh1ZEZwUFczbjJ6MjVUOVNod1FrV3dNT2JybzR4?=
 =?utf-8?B?dkdVbFkwbDdzaTJkMGZZZ2hsYldTT3FKaGw1RlZzZjNiOERjaStSZVI1eEpl?=
 =?utf-8?B?YU1kU2NqbFljUmVRSFNEQ25iYjFySzBkQi9QVVNHNjg5L0Jyc0c3QlpjSXVD?=
 =?utf-8?B?WXozUlJJbHk5WnN2KzRUUkNUV0s0SzA5Sy9xRURqajJPbkFPdTVTclhKczdF?=
 =?utf-8?B?YVNTUHd5YjlYdU1HOU0zWXdEVG1rd1RJT3UxSGx4alcxZHRaWUJBS1NkYXk1?=
 =?utf-8?B?SjlkVEUzNkhSWDVDYklVMlhja0JoOFlzR05ieHdlZlNCdVJVTDNjelFBQ1cx?=
 =?utf-8?B?UjdRM0tJWWdQOEtOS0RWTE1JSlJqbkZFWE1keWlIQ2UrNE9peTBST2tyOXBj?=
 =?utf-8?B?cnBVQkFiUk1ZdE0wdGRvY080ZndxYTdXRTVQd08wa01yaTVOZVRxU3BVelFZ?=
 =?utf-8?B?UEhQbjQ5aXF6R2Y3RGdOTGNxV1NUc3BYaHZFSTVHVFVpbzZaSktVdUh5UHRr?=
 =?utf-8?B?TTR6cys5L0o2Q3Q1Vm53OHd2eW8ybE1iaEFKTDNLdkhTYXVWeEtOZHdHa25G?=
 =?utf-8?B?ZFlEYkV4VG50dGZ6SDJvOG9tSis0WGlTNWZYdXh5R2loR2p1QldqSFFoRjdk?=
 =?utf-8?B?TmZYcjJpMk1EZi83cGEyQkl3OVBrdVo2NGxremMrQ1lGbEVUUVhXamFLR1dW?=
 =?utf-8?B?K3kxUWc5VlNsTmhGcFArQ2xTZEw1Q0ptaWVMV1RwaC9hTmtTYmZBR01jL0NV?=
 =?utf-8?B?VWdHcXdWWEtSQVJoaGZlelBFNXFyQ2lta1JKR3lNK2ZRWkFFUmxYNklma3Fv?=
 =?utf-8?B?c2ZjakxVMTNWRjlsRG5lUjFibXFseE5paCttWW4xTWloYjRiYmtGeXhRTTJp?=
 =?utf-8?B?TlZPUkJRSm1NNTMxNC9MRXV0Q3lPM0ZMeDlRRkEyNTJMcGNZdDk5SlY2WTJP?=
 =?utf-8?B?VU9FbVJBclg1cmRlTzNwYXAzR1ZZSWNNNXpYenZCUnR5QkxNYmR0WStDdjlj?=
 =?utf-8?B?VjArUjVXcGtzTE9PL0szbmRLUEFXNDBvckZpcFN3c1A1U2VGWEM1ME9MaTVI?=
 =?utf-8?B?bVU2Sk9FdjBlL0w2Tjljd1RHWGoxVk5RRWNYMkNvU3ZRdkdiTG1KdFFBMDVS?=
 =?utf-8?B?ZWp4MTZaczAvK2NvcElGSWRwN0QwOUdOSnNBb3BNUk9JT1h1cXk0TDNpcytl?=
 =?utf-8?B?T21WV1pNMTdQQTFzMXlBMVkvcGFpTkFwSGxOUGZGTHZtSHJhSmZXek93dE5R?=
 =?utf-8?B?Y1VjdGRsdUFaMjNvSk83MU5PRGZkOXpWK1QvYTlwMk1vQVFIV0R5dXFHRkVn?=
 =?utf-8?B?djBlNVJ5dnlJeDIwU3dpT3ViRUVvaWpmVVJoNWpZbVYyL2cwTTVwUmhkNmx3?=
 =?utf-8?B?aml5cFVKL3F5WEVkd0s5MEU2WTBDUVdxUkE2MTVZVGNDcHFCRjBZT0syd0JV?=
 =?utf-8?B?aEVFUEJRbVV3cS92QUF3WENHSW5UUGR2dHBWYUZ6ZEE5UlAvZXRXcytxejZp?=
 =?utf-8?B?eGlwbTNmZnlyM2hCR0lYVElUNkEyWTNnZjlNRjBjaTZoN0dkT2JTNE13aGtV?=
 =?utf-8?B?aFZqblZDQUl6UURuNzE4OGVmeVlQT2ZGb3h0Q2RZSnJmWGRmNktLd01VdCth?=
 =?utf-8?B?L3NrY1k5cFpYcnFUL0srL3kvY0lRMThCSlNkNUc2bHFLOG9VYmdrdGRSMkor?=
 =?utf-8?B?OFZ0RTZ4ZEVzVjdwK0kyQS9ORWoyZi93S3VHdVhWQmF6ZmNNeCtrcnJYY1ZQ?=
 =?utf-8?B?bnlPbEcrdlp4dVpiNkRRNU5OalJPdDFtY3JYV29nd0dNVXBLZE5NWmxaYkI3?=
 =?utf-8?B?dkpTWVA4OEs5UG4wL3FrTjh2bzhoUUFob0hZaEI4cE5jM3Q1WmxTdVhNd3Yv?=
 =?utf-8?B?YnpQSEdWcHI0M2MxaXp4aGpGc1JwQ1R1RDBkNERxS3ozQmFCdDFsYjJxZ2VD?=
 =?utf-8?B?aUFraksxMGh6NDkwODZkYytwdXFZVys2TDlLS1JBTFpqN0hDZzJVYUt6K0JJ?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tKztOqgtkIja1usVGk47Wum8+JskUyZ6NhZYr0k8Muc9UUfFQZfblUHEbp5XBPyfDoLQ0jgMhP61lhgXWCMoBVoo2w574kpyTvYz6bV9O/Oe3eP5lVdjW7hVmlOqp763wv2J/a8xkW5/SqfmBtvhu3GCCkA39w+1QX0XW42fkp+BVYsflpocZ2CXhgTHqUrFpQnvU++c/tOn4XjsunB+3sJNKDDPURp713ao6hOTcnlwDhcGWw3S3YuFRuVzrCGO6YCmI45uIPUOF0VOgUiKXJ7OctlabTOk+a2KVqMMgkfLxdqACoEwYR3ximMb/xK+xNSy3AJ4QZaQ/Gl4GqQUgpIIiqIX4uDFzg4oTea5CAj9jtZ9PGdsk3ZQpQrIslmc9waTq6B8W3FV9d22uvZkNDjPvBQkIqERblUAm1plAkBbfsDumScs/wlwAl0CC1/eMnmI44V+6Xqn8Rw/bBaz66vQ+ASperEaYoOgwpkScRMfVvsoKEeLYgN26vCymLcb6NKAM7uFD+d+0ob9PP8wQcwao8OFZN0rW04+90025IFcijMZxewkD6ujHziqfthfW6h6YSMz10JYXqTot2JdEQBbFPe8hy+V6tXSpH7RY5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0a5b91-d2f7-43ff-c621-08dceee0283e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:16:09.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jINQsIdzEmAdDKARSh/gf3aHkWnjE9La/ZqXMunMit9l4C5upaTtlJjPzn11bgvXtwimHnkBVbDPnwfjzvz6GB3461I8J+GJMRAKoYlzaUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_21,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170129
X-Proofpoint-GUID: 6pzJUeZBjV34Wiz4zwty_aI7NNXowfWg
X-Proofpoint-ORIG-GUID: 6pzJUeZBjV34Wiz4zwty_aI7NNXowfWg

On Thu, Oct 17, 2024 at 08:14:11PM +0100, Pedro Falcato wrote:
> On Thu, Oct 17, 2024 at 09:20:20AM -0700, Jeff Xu wrote:
> > On Thu, Oct 17, 2024 at 1:18 AM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > NACK. Greg's bot got to it but...
> > >
> > > As per Greg's bot, no signed-off-by line.
> > >
> > Sorry for confusion, I wasn't meant to send this as a PATCH, but
> > reporting the issue.
> > The diff was just sent as reference to repro the bug, and I forgot to
> > remove PATCH from the title. I apologize for the confusion.
> >
>
> Can you explain what the issue is? I don't get it.
>
> --
> Pedro

I'll let Jeff explain from his perspective, but 99% the issue is as
described in [0], i.e. not a bug.

[0]:https://lore.kernel.org/linux-mm/e359abef-316f-4fca-8d1d-84b69c8bc060@lucifer.local/

