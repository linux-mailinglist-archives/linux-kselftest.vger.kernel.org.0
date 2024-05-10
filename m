Return-Path: <linux-kselftest+bounces-10022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300C98C299A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E391F243CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15CE1BDCF;
	Fri, 10 May 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EaNKiLhu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A993CF65;
	Fri, 10 May 2024 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363804; cv=fail; b=Dog/YRmn1jjfpYzbhzZt8dda/JXotwM3377AiXS3FFzr1qU+2un7utw/MaboT8eejq3W3sdTNtigtozXUaBFxblhqQZF4mfjmjnrlUaM8rAYgHQyFt5kob54UJJI7CnGhrkF0G3woO93aQqw11467Rq7J5SEXWJzaj06EKWuhQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363804; c=relaxed/simple;
	bh=p1DG1aevE1Stsb87Ks54g83l+M552vJYtc2Kb5u29TM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VMt+HHUTbIMJFzaAaN2kX2v7Sd2Q9sGgxU6Ff/IBRwhFZb+rF5Z3rdldGdG+eF9IhAoP5qScHGvfz2HTGu2udhzLfeuYpebyHQIdNxcw4pKRZWcLRqFFa5hkmPnBxKpfVSOryPBpZ14ksaBPO5jAdANdie+ECsFHtEQDon2PfQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EaNKiLhu; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdyE1jjBSQi8GTitNklmtT25iyxblHU2dNnDXhP/VLBu2rFlyZFr6V+WhohM8UfLjB67eFnRMsPV+RrP3zDbuRXY84XkRY9xhUixNltXs8LNznCEC3LKBByuNWM6OX11hRP+sLIoS/oCoQ6ETPC0NynbXtjo5uhGdrR/IFdlvyOKU5A4vQDUY7i9KxlGmXlq2pYaKSlUI1G/9vyDpXjMRSEVtL+/fNZEGrnizYUVWAoRPI6/ltftuVD3PyaynAFe1iqU8UrR3kOeB/r6Ep6dr/BiR8e+wm+JUceVnz45j24yCa+WoFYvS8EVnEeQe3sWpChGlxsql4fzonQPpNhoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw/fIG9r1cHb9Lciee60dOmbD4b6xlv3xej6IKdgmCU=;
 b=QDswBa7YRPxDNmOMMMOHahwYjrM1SP5aAZdhfIlimFhCCdi62ilXp+XWQBpxsp6fZmLzvuK2yYjg3ns1txGF5vjeFTsRQkiS7EOMMZo0BVHVPWbI23bDBOeLkQaUdPdmB0ySNPMTGWX4URgl+7/Oi9iAy5LRrJ2kR2uMGQ/08j2KLxndAOgx16saaAdHD8VRfy2eEVCPVbcU43o14rRi6psb4CJ+d8cbCe3DyAbyapRrftZldmbDZY9K8P5P2QByqP1Y0c4JSSXWVtJVrXa0YFiXcGTKMhavV/epePrd/PAqWuPD38wi4bh/mLQyKc7M7nT8zwGGPXrij4a+hukTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw/fIG9r1cHb9Lciee60dOmbD4b6xlv3xej6IKdgmCU=;
 b=EaNKiLhuDDvXzW3eq/GmFfmAHeSGEA8sHSW8M3qwj/w8G8PY84tChN2+/xswcL9uHtxYEcw5cDsDxbOC6z+FzFODbsSajF0H9Bu5nMllQOErE82UjKf0N09ucrdiE42LkA9FOh5ElVkBBjwExju47tPavdwbddmUV7WYhSs4xPP7ol9oJdEbEP8ztx+dWClE2aPct6ON2QuwIOoR/jADcZdCrqClQQbdTXbCXohweqlhxPYBN9MVPNunx5cJmnhvHIIP1r5oILPcthE+DnMuwgK6jxJz501ITxYu6euRA8WX7uKX1+9eU6OfuLzXHGok6KmfkbVuS816BVEQkZSrXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.52; Fri, 10 May
 2024 17:56:38 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 17:56:38 +0000
Message-ID: <f715719a-c835-496c-9e99-d249e5607a0b@nvidia.com>
Date: Fri, 10 May 2024 10:56:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
To: Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexey Gladkov <legion@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240504044336.14411-1-jhubbard@nvidia.com>
 <c406383d-e08a-4a12-9e25-1c987b0d678f@arm.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <c406383d-e08a-4a12-9e25-1c987b0d678f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: cac4615a-5834-44a5-52a4-08dc711a89f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3FOcFdwcm9lc1UwVURjc1dqZlZpbzlZeFQwZGJMcDlhREZPS2NlRVY3b1pp?=
 =?utf-8?B?Z1hCeC9hOFRBdFFoYXMxNkhQQjZVL3BIWWpjdWZWTm1yWnhFd3hSdXdFODlQ?=
 =?utf-8?B?OU5wVFF1VUQzNVFkN25DMVVQbEpsUHdRQUZaOURKNmQ3NnpoOXdVNEhNaGtT?=
 =?utf-8?B?R3NLZ09DTWsvNVA4TVBkWGtwSE1HaytBekFVWWFYNk1DSWVlUVpGNlUzbWtF?=
 =?utf-8?B?TkhQMUx1NVF3L2RVQTVDTXI4T29oUmZlSXJhZTFOMjYrVisreXFNNzVsbDc1?=
 =?utf-8?B?djJydDVYdnZNdHNXTW1DRG9qajFmQ1BEanQydkdRYmJkY1NnL01adUR3QXp3?=
 =?utf-8?B?N283akxhWnlWMmJFcy9kdkx2MHBOWTUybjNtaXQ3STNEaXNxcmhOWisyUVNU?=
 =?utf-8?B?OVo5MkZmRFhrRkI3bEllSFRsaW5GeE1rQ0gyQ254T1BwdWdVY0hTREsvb3Nx?=
 =?utf-8?B?QzloMnhqMEVkL3diQVlMS0gxWkR6cDNYN2dSYjVWVnAvbTdCK0FvR29BQVJJ?=
 =?utf-8?B?N3cxUXhBWkhDSFBpZm4zZFJvMjJQZUR1SFhuVEovVUd4ZzA2Mkt5YnF4TjBT?=
 =?utf-8?B?d20wc2ZxU0ZPcWRpNk1rSGhMTWZFMjErYlpWZ1BtZHRjRkg0bHljS1JiQWNR?=
 =?utf-8?B?azVBbmZ5QVhhQXdqZDNlaWpGZEUxUVlRU1o1bi9keVpHUUYvSmRJcEwvTDVU?=
 =?utf-8?B?YThabUpWeGpnM2kwMGlOL3JhdFFMYlVhYWFOeWh5UVBKK1RaUnJUa0pSRjlF?=
 =?utf-8?B?M0tpbVhCeGl1OC9LYnVObVF4SlIrYy8ySFA2T3lObWFoUVVmeThSaXRxY21h?=
 =?utf-8?B?cTJPS2ZFcHYvZXJkamowMXdTaDFCRTMzQVF2OGpFNGJhS2x3aG9aaXo5ckx5?=
 =?utf-8?B?ZlFKZ09kbEtpQ01ycmlZZFVkL05zR2VaTHhCeU40aUJkYU5PMmJKUFRBaTZU?=
 =?utf-8?B?SVNNb21QVUx5bTZ5OUV1dElna05XcS9Jc2QrN1kvUTJTS05TcnRXbnNucE4x?=
 =?utf-8?B?MG9jR3UwYWsvVEo1azkxNDF5NFVyWk04dm1vSzNYdytqS3JWMnZZN0xBVkE2?=
 =?utf-8?B?Z0RvRmcwcGpaRGdUYUhLN2RZbEdtc1BMVlpxS2diN1hLSHg2UUdIMDZwbzZs?=
 =?utf-8?B?Rlg1eTByK2s1YnRubFZkZkR2NGp6aWNIbDd5R1NtTTFtOXU0S0lzOVBzMG10?=
 =?utf-8?B?b1A4SUhQNEFOSnBNN29UWU1TYkZCam5tQlRSQnpVbWlUUjIvTkJLcUJWeUF6?=
 =?utf-8?B?Sk5uUU9zZXR4QllHbHdzM0ovSTlybnlXNmwvSU55aGpLQnp2UktFYVNHZ042?=
 =?utf-8?B?VmNKRGZBekQ1d0JZK1FUeGV6RzJlc0JPbEdtRmtvbEpjWXNIejV5NXZNVmxa?=
 =?utf-8?B?TFZPV01QR00wRVk3MDQ3RWhZOGtCQ3dGekpOdGFaUXB4QThFY2twbXMyWFlU?=
 =?utf-8?B?azdTLzhCU0tWYnpRd0RRK0t2ZFozSW1YTUFOY3VBT20zSDM5N0lXYnNLT1hR?=
 =?utf-8?B?Q3JLb1FsbmloS2J3UjhCUTlKZlJpWmM1YW5lcWxZZW91TW5SNHoyNmpMek02?=
 =?utf-8?B?c0hwcnZxMFg1TjRHVzZYbGNENTl2ZVdLenZ5djlRYmhYQjFwU0FEL3o4bmYz?=
 =?utf-8?B?ajduRVRQOU1weEVhb3AyalFJdjBXN0k3NVdyb1hncG1TajVQWC9SWUExOTE4?=
 =?utf-8?B?L2x1OHc3WlpkWVc0K0tjaE1zTTAvMjFWVllGRWM4enBoYTkvSjBrb3hZWkxZ?=
 =?utf-8?Q?pixukY1zYUiejHyUrk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWpzRXhac0pDZEFMNm9EK1RaS0poOEdjcnNlZ3cxZVAvdVFQK0FyRTJnT0Q5?=
 =?utf-8?B?VU9nd29TcFB1Rlk0QTFveWVEa0lqSEhGZ2R4cC9uMXI1bitJeXZmL3AzYlNZ?=
 =?utf-8?B?UUpVNmJsbURjdkd3T0E3cDlGbWt4MmZ2Wk9YT0ovNXRySHdwWmpqNDB3dEZB?=
 =?utf-8?B?Sml4S01Wb0QzWVBFdG8xZ25DUXVWbzcrVzZSYVpJc2NzdnZRTjdHL1d0cGpL?=
 =?utf-8?B?T25iS2lVV1JOOEMwQkNJUEdUNXNZMTU3VktOUElLMHpNR3Y4c0ZyV2NvUzRk?=
 =?utf-8?B?TkEyU3kwdU1SdlpJMmhCUnFRTllXamtpVzhpZVI5SWhTSE1YT1N4cDFTdnJz?=
 =?utf-8?B?ZWwxUndCeDJCakt6bWJJV2Qvaml1ZzZ4dHEydTlCVjBSNWpxajhKRTJzaHhq?=
 =?utf-8?B?bUdqcEVkMzVzVzlGTWhCbWhTUW1YRC9SL0RLTDdnVWRvS1dVK0R3RmVUQ0FQ?=
 =?utf-8?B?N1d2YlR5WGlDRDFyMHgyRDMwTGpwclJDQTRmYlExRlJGdjZuSlFKV0VpT3JO?=
 =?utf-8?B?dUJKUWFWOVhRREs2MEdzV0tyVUNSbnZlWnlZc0I1ZXdQYy9hemhKaFlNZWdW?=
 =?utf-8?B?dlk1TXFqWjRmcUVtbFhpV1hYRFJnU0c4WXdpOE5QWWUweFROcFJLdGpUeXdT?=
 =?utf-8?B?MDZzM090a0ZjMUFRNEdFNUZFZnl1Tkg2YmFmRUN0eCtXRWVxZklzdUxJY01o?=
 =?utf-8?B?NmpReklNZ09FTXdjTGgwNEgrM0s0TG9RTHRNOVhMaWszZjB5YXA3VUNZektX?=
 =?utf-8?B?dGdpcWF2THdnRG9ZNm0yd2dJalRyNkY5U25odzhuQTRhMGYyVURWK2xMbHU0?=
 =?utf-8?B?YUcvYU1yZXBsdk1TRjd3RGIyV0pBRUg4UTNiTFU1bGZmNlhHNDhjRUR2SUM2?=
 =?utf-8?B?dWNrdG5odTUvRGxpdXJNY0FDbGJkeTNmcTM4OFFFZDI0RStSWVZwaFN4RzUr?=
 =?utf-8?B?RkNNYnNlMnM4ZUYvR0pzdHhyaFBQeTFjSlYzUFZiajl2aFdCNDh4Y1lISGdM?=
 =?utf-8?B?dkMwRERZNEJ1RDhjYUVpNTJnTHlkcTMrNW1RLzR3N3pIUnVpNGpLbjd2b0Vq?=
 =?utf-8?B?SDBNWWt2a0luVklVYnlsRFpCVXBVbjRLYzcxeXE4WU4rOVFJaXk5Z0FiM2lj?=
 =?utf-8?B?aDhGYlhWVEd2RExyVm5IS09wUlNWTU9vNnV1cXFUVE12ZXNldTNMNFFvdXdS?=
 =?utf-8?B?L2FvM0VZSWt4UUZlNnZVUzRiSjc0RGxINWxqSmdxc3NmUXRnTVBiemtINDA4?=
 =?utf-8?B?VmFCN0R3K3lycEVTM28xaWdUZkRIaWtGNForRVV5K0xlcktvOUNUR0c1YUJ1?=
 =?utf-8?B?Uy91V25LY0Jkd0JGR1psbUhlQUFpN3lFNm9GMmpvZXk2ZGM1UlZVUVRoeG9p?=
 =?utf-8?B?N1FOL1l0RjZ6QjFZMm45ZzZEQ3k3dDBOSlhnMnRVR3IxNzV0OU9vcEoraXBM?=
 =?utf-8?B?alZvSVVPRGVlNGNTQU5TRmliZm9FTkcra1hUUTdGaGNMdjlvQlBzcjNtU2lM?=
 =?utf-8?B?WFVuN1JXTk80Q21CTGt6R0hhT0JCM1NIbVZtT3JZaUpNSEQ2RkdCWG83RGNS?=
 =?utf-8?B?RVZ2djJDa0ZibTgzLzFFQTR6enllZG01SDU5Q3VQUlhzNzdYYk5MWUpjTSs1?=
 =?utf-8?B?cktTNk1BQ25lSmFWU0xySnhnVTNyblBSWURvdWVkbG5OSnU5ZkRHUThPNSto?=
 =?utf-8?B?VUV1MDJITmRpaThnUXo2QnNFVFlCMUN1OFcxMzhINUJRTEh2OWE2VzlZcEZt?=
 =?utf-8?B?WitRam1JU1lEaFBudkl5RTM0R2FoekxKcTV5Sm1CdEZxK3FuNlcrWk5PSzJH?=
 =?utf-8?B?blAxdHZYOTRhVkxWZjdVLzRGMC9tU0h4MExaSjcvQVRRMUR6K1QrYXVtYlVn?=
 =?utf-8?B?c0thWkkyUnZBblQ3ZDVZK2hXRmIvYnl5cFNIUGdiTmZvNmVBL0phd2xQK2Fa?=
 =?utf-8?B?ZzdVSnJidm42K1IxbktqS3NwTTlxLzQ3VlQrbmYrM1kwN3BreWJkeGY2NkJu?=
 =?utf-8?B?ajhHQytrYWNRYlNOZWdDTkdrTk9uSEREUlRON2xFNkFEdm9MM2l1YVJndENs?=
 =?utf-8?B?enNYZnlqL01PazdJZ1VObnJQcGo2c3AwTWJudnFuaDFoMDlCOXFGSUJRdS9I?=
 =?utf-8?B?ZXN1T3dWcE91emtDUHlYNzdwT2E1VlBMaFV1ek9BZnROWFcwVVdaVkdpREVi?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac4615a-5834-44a5-52a4-08dc711a89f7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 17:56:37.9003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWiXw3pwLb+8HwZyGiMSdLz+ZT/wxfY11A7WO8jWoqbMzz2u4QGVo2FZOSkPR9mQaX5Dg3oQmNcqhHVsVhl5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968

On 5/10/24 4:52 AM, Ryan Roberts wrote:
> On 04/05/2024 05:43, John Hubbard wrote:
...
> It just occured to me that the bug report I was fixing with my attempt was
> invoking make like this (see [1]):
> 
> # tools/testing/selftests/fchmodat2$ make CC=clang
> # tools/testing/selftests/openat2$ make CC=clang
> 
> So LLVM is not set in this case. Perhaps my approach [2] (suggested by Arnd) of
> using cc-option is more robust? (cc-option is alredy used by other selftests).
> 

Yes, I think that would better handle the two cases: setting LLVM,
and/or setting CC (!).

For that, some nits, but only worth fussing over if the patch hasn't
gone in yet, or if you're changing it for some other reason:

In Make, the arguments to functions include *all* spaces, so it's good
practice to not add spaces in most function calls, unless they are
definitely desired.

Also, you only ever want one of those $(CC) options, so saying so is a
nice touch. Neither of these is a functional issue in [2], but you could
do this on top of the patch (I'm only showing the openat2 case):

diff --git a/tools/testing/selftests/openat2/Makefile 
b/tools/testing/selftests/openat2/Makefile
index 02af9b6ca5eb..c894778874a5 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -3,7 +3,7 @@
  include ../../../build/Build.include

  CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
-CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, 
-static-libsan)
+CFLAGS += $(call cc-option,-static-libasan,$(call 
cc-option,-static-libsan))
  TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test

  include ../lib.mk


> 
> [1] https://lore.kernel.org/all/202404141807.LgsqXPY5-lkp@intel.com/
> [2]
> https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/
> 
> 
>> +
>> +LOCAL_HDRS += helpers.h
>> +
>>   include ../lib.mk
>>   
>> -$(TEST_GEN_PROGS): helpers.c helpers.h
>> +$(TEST_GEN_PROGS): helpers.c
>>
>> base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
>> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
> 

thanks,
-- 
John Hubbard
NVIDIA

