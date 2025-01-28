Return-Path: <linux-kselftest+bounces-25274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05904A20581
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235241886230
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 08:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48351607A4;
	Tue, 28 Jan 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JXaYAoWW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD38462;
	Tue, 28 Jan 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738051456; cv=fail; b=Jw3/KZxdLD0Ysa915TXTH/DKtsaqH8QHjLxfWxuxrWi1UbjAGlZGcO5BTC9c0I3Dkmt3SmBy3Unv7CdOJTG6amK7tCbSYWep+v46XBSvwCwsQEFaBYKD7fcEJE1dsZsFcbuM94gA81fqqc3MmU9VhJHO8iKCCcqTma4zfzC0syg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738051456; c=relaxed/simple;
	bh=8GIXWs4eyS44CBf99ykazeTFW5ZPHJNevD7Z/QdFZGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O7ZKzEqAKzXtskH7f/8hms1PxeTdzlGw2CLrEVlPXKTI3BoGTigeGkIfIHODdn8u2DA5Sbbj4nV5sxle9LKs7t7hBzOYt4wr4onjbNkRWSQHJnQW3rLDJfDhlvCk3fJGkvDm56YzvTs/ZWINc3h2/sFS5q4evdxNXrpfW8r57NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JXaYAoWW; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l77mOZk7AsjwvcpSh017sIfIalZO7RVRJ4h3ZccyEHZApDII7stiAqTOu79WGOILL7Lr0Qv65iYkCcYwM/xkwOqbUEM0tMTNBloHEy1m7yDEfuCxAFMW7JXlVoz+xA+0RL1LZyXbwdfsfHs/qBGLKLDcCFNuYfRnPqOKjfA0LNzrBEBNB1JmeYhjwerY/lpoomia8wX1/foADfv0L/Q8+TAuznxKIsskVbVSle5V3Yfy1TCQSK9jkpy7IDtbH2St2yOZ99eSTySZ6qTLo74rgm02aBksGBHacC9cpkPsDxbnbiCswSgF7FVhR3WeciU7j4zLICxlDtZ6aOOBOSIAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmzuwakcNXPG0dzz7ZhfXAKEEqFLVAYFU4gvukd37yY=;
 b=zI9Kqi3CbfXgV3sI6CA+gAvEg1NEGg0Jke7lR5WXQ2kZSm7p8Y86ejmZXhLMOQsL8RVpjVoXjHcYK/NVaN3fkTS3HHXf/DccyjiDVwFty8azzVi/3B3PGvvJafZKV8H9zoEPI5AckCKqZtzUJtRE7vlTI8zZTax7za3tQ5S4b4n+PUD5hyQx3QiSBPp/+RzJ/mP1fbrPInxQfxRCmkQRVuFf2rb+OnwHOtsEoXGlbfGsrJwvGUIZqe1m+jG7LYXriB6h2EjPYUimFwi/gEqckJNBAFmTVDlBTi4Xu1YSldXf9bL24hFzXaAwW7xGLGc0Ztbcjgfzc+Zquazio5e53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmzuwakcNXPG0dzz7ZhfXAKEEqFLVAYFU4gvukd37yY=;
 b=JXaYAoWWTtBJMY9fzrzA+/b2+vPS95qEMDcxn08MU5h7INN6JrYf16GoB3+NQwMKrqchuQ7NydRpAakCxdJ/7u659b5grARwaeLwW0AZu0bN5dyVyuWIa/+i8PYVAhr2t/cWQbALytVzW8qUYEdavBhEsnDEaPjXvxoI3FFCsMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Tue, 28 Jan
 2025 08:04:11 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%2]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 08:04:11 +0000
Message-ID: <d0926133-d1e3-4007-ab34-6aa2a987b8ec@amd.com>
Date: Tue, 28 Jan 2025 13:34:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] KVM: selftests: Add self IPI HLT test
To: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20250103081828.7060-1-manali.shukla@amd.com>
 <20250103081828.7060-4-manali.shukla@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20250103081828.7060-4-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::21) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bec37fd-b591-4750-558d-08dd3f725938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXpaWkczUko1V1UwUHAvL1poZzVPRUFpT1doQ3FzVHFWVzcwQWxLOHRsNncw?=
 =?utf-8?B?YTR0ZjBtb1o3L2FUby9ZeDZpYmdxNmJ2ZmpaZVlCaHFjdTRjL0tkUEdNYjNX?=
 =?utf-8?B?NEpFa1BubFpCTUd4dTlSQlJrSXlPcWFJcnlhMS91eDc3Y1Y4MGxRK3Fmd1dP?=
 =?utf-8?B?VzdlamIwUXBIVy9WbHFXZ3p6WGtPVWVwUEc2aVZTei9pMHNlcFFlK0kxdmdX?=
 =?utf-8?B?YkNSVVlWS0VSMEtEM1dXRkZnSVJQdkZDN0hUN3VObXlPQXdmdHY1MkhnbnhP?=
 =?utf-8?B?UVJkc2w0dlhzMHBHUUpuc3FUdUg1bWpaQjhlNEhsM1JaTlQza1pqbE5oSWVW?=
 =?utf-8?B?ZmE2bzNQeWl1RmZTdXhqYi84YXh4VkFOMklBYnZhWGhJWXVwcW5uOUZ2Y2Nn?=
 =?utf-8?B?U2RtSDRad05kSWZBdDBSVTh5VU42K21mWVZ5OTBmdmFBVndENy9XRnFxUVBW?=
 =?utf-8?B?Y3FWNDdubE1QT3VXVll5MEU2R2x0TVFqOHI1c0pNSjVXVWpYU1ZnemlzOFhQ?=
 =?utf-8?B?L0FUUDJZZWdLbGxoR3MxU0FEcFUwUkVUVHpDYUdtZ3JFSzQ2UEVTU3dvckEz?=
 =?utf-8?B?RzcvN0txY3A0NWJPQWE3WXAvK2Q4dllkbWVvTGZDc0FQT2xsQ3RHdmxLc1NC?=
 =?utf-8?B?N3I2TmJMK3huWWhtb05GNzZ6dUZTMlNzbC9BVjc0SGFyLzhqblN6QUNlUVZl?=
 =?utf-8?B?NlZaemNEeUxLdHk2R1M0a29TdzNHQllFOXJ4NmFtaEVuWVBkVjMxR05NNkJQ?=
 =?utf-8?B?QXR1RmlKTmlwaEJyeElIRU9nV1dMaXJzVUhXRmo4OVROdkdYNTE1MFhEb3NC?=
 =?utf-8?B?Q2swUktlRW15N3JFVFArNi9zaFR2Zkg0UHlRMlpNVk0vMFg3YlROQXpxT0NS?=
 =?utf-8?B?WllScjM4N2xwcml4MjhRUVNGelVkOUVQeUIzbWhlaGdkM3YyQlE4dEtLTTZW?=
 =?utf-8?B?SmV3NVp1WkQ1TVp3K0xYaFVXRzBsUGpxSVlhZUlGNDJhL2JMR3JaWUd6ekNj?=
 =?utf-8?B?cU9USk43SjVhc3UzakFWVTBUa2p4TmZRL1lmK3lRYko1U0lIMlJVbzltajJE?=
 =?utf-8?B?M0MwUVY3cDJJdlZhN0Jjd05sbGJMY2tHemxTNFdUbkNYT3FWSnV1K01xWVk4?=
 =?utf-8?B?cXJtSng0Ky90MmM5UHhaWFlRZTZ4aDVzdkx2STNPRjZGOHVUU04xWENYUU9V?=
 =?utf-8?B?YjRiSENTaFJiY1A2VWVqT3kzZHJzN2pMMk9YS0FFTXd5cmZDYVo2OER5clZx?=
 =?utf-8?B?ZGNTMVBqREVyNW0wNDJuaFJCakd1dU1OSldrOVZYS3BmTWFKck12VHpwMVNk?=
 =?utf-8?B?NW82U0xUSFpseGNUSGhWMVRnNm4xZ0hvc3lTYlVvblNrKzFNM3RQanRVZUw2?=
 =?utf-8?B?TUV2SU5aRFFyUDVPWGcxdCtab3U0VXZCUzhsbG1KN1R3TzhvZERsTUZaSnp2?=
 =?utf-8?B?Wjc2QnZjU0dXMkNhZFdWTTRubFNZWkd6dXNka1I3UjlLVWxOVjVsN3c5TGNN?=
 =?utf-8?B?ZjdnVUM2eFRWNTU5R05XRlkwRzFRMEFKT0didmJRcFlpWXU3V3BIaHZ5OTg5?=
 =?utf-8?B?YmtrMlVQU05LMDVqeEdOR2NhaC9ZRmNXTzI4aG1BcXp3Zzh5cFpmNDR4TXow?=
 =?utf-8?B?U1VubkllR1NTbHlFV2w3by95enpDQXpJQVpac1hPMnpRM0lHRWZoWWI5SWVO?=
 =?utf-8?B?Rm5JR25JVkFsTXg3L0NOYkRSQ0libmNLVCtmWlV5N3JEN3NlNXFBeGNteFd5?=
 =?utf-8?B?dDEvMkxFU254VUJYeFpLbFRzTjYvbElNaUZFR2NubFgxcThpSG9iTzNib3JI?=
 =?utf-8?B?QllLSnVITWM4YU1SVDArOG95aU5FTzFRa3d4TnpVeU1ZRnRZUjFTdnpjKzgx?=
 =?utf-8?Q?qxEtqSQw1WlIO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm1CZXE4djAxUEdCTHVTakorbUloVGxJbDAxMTR4WnRvZG8vSkFwYVVyTjZx?=
 =?utf-8?B?L3BucTdmQWIxemd2dWFDVUVGYld4aXNHdzk1eS9vYk5Rc3ZhQkhvWlU4eG9H?=
 =?utf-8?B?Z0wrcnNSeDhXNW0reU00MjJhbkhqN3hyNUdnZUtyMjY3VUxadUtFTTJvWVB0?=
 =?utf-8?B?cnV5NmxaRGhZenYvSittbEQ3ejE3RVdkUTlJbHZjK1dSVVZvRTVzNFJlSWFT?=
 =?utf-8?B?T3VIZE9OUHlQVFZrT28zQlVFZVpoT2MwWWJGa3VYSCszUUtEMVFxZmVERWsy?=
 =?utf-8?B?MEFjckFMTDFGNkU4WUtmZXlSL2wrbHh5R0dTaEk5cjZPZzkybVZMMGZEcTEx?=
 =?utf-8?B?aUZRaVJkWVUrbk42OUVHZ1dPYmlleVhyZUZqbW9CbEt2aDNaTFd6V0NxZnlv?=
 =?utf-8?B?SlBYSW9wOWJKQmozOGRmaEo3U3dPWE9iODlGUWh6T0xWNWVIa0tkelBIVSt5?=
 =?utf-8?B?YkVKYjAyNEdBK3VqZVJIa0JIM0hUUEt3RkhJREdVTmZ0RU5hWEl4cjlwZ2M2?=
 =?utf-8?B?N3VsbG5jWnpkc1J0YkZ5OGt4M2hKVHVyNk5JdDBNSldWTVp5aFhsOHpNT2JQ?=
 =?utf-8?B?d2paL3Zxb3lqaTRWWHYxMjRDbm5YWHluNFM3WlBoMGVtdytWMGhNYm9UT2dE?=
 =?utf-8?B?SDZ6L0VQaldEZDZBTEhIQ1RTSEJ5OTgvV1BRamlpTU5VQjhXajd5L09FQWN1?=
 =?utf-8?B?NllmUVllZzJPTGxIWHowWkVSODNwUHJEZWxwcy9lSW4rU0JHQUx2TE5oaC9p?=
 =?utf-8?B?dnI3LzZvNDdrS1dMTE5jWnRTajBjeVlqeGtyVjZ6UW1HV244RFlHTXVLSWRh?=
 =?utf-8?B?UG4reGVVM1BNYWxheHB2NzlaQUs1emFVc2xidWYxd2E2V0tReTJuZFBUQ0tJ?=
 =?utf-8?B?OW5maUY5clF2WUtqbk1hUm9wc08wcGhnQWxHS0JqRGJHWVV5SnZ4UmRNVnpF?=
 =?utf-8?B?L1AxWGc2QlFyZlM0N3ZBZXRoenRyd3JYYngvckRkaG1MSzEwcEhreEJLYi84?=
 =?utf-8?B?Z2liZ3lUbDM5VGpmclFLaGZXemJnYU53OEFQYm90Y3pYcHJPM3pNZndzSytQ?=
 =?utf-8?B?VWdvYTgrUmVWNS9hUXdWR0pubXl3Y1FrdXJacjFaNnhJZEswa0JHeVRjWnVz?=
 =?utf-8?B?OWQwV1pOUzF2TWVJUTJsb0RLWHFZdUR3SVllZDN4eGlySmllV3RNL2kvNTgx?=
 =?utf-8?B?K2xOTit5eGRLN1RENkZyRTY3YWVwZUhVYzU0VjF4VDV6RzJ3dnU3cFFZaW5n?=
 =?utf-8?B?T0xBYzFUYnQrd2dNZzhiSjZaRmx5bGRtQzVPQVlJdHROMS9hSzJ6WSszQ204?=
 =?utf-8?B?K0tIQnpKc1Fzb1hoRXJaQVhIeGI5d1hMWk1yK1JtbjNUZE9ScDRmWmFROEl3?=
 =?utf-8?B?M3RVTTlSSzdodFdpZ0lqR2xRQlllcm1VTG1YSVdFWlEzLzJJdVdIYWt3OXdH?=
 =?utf-8?B?aHdRaXdBOFBnaG9oM1ZNck5OSmZqTkFRMkxhNGNEMVd5SWhIK2wrUVYxUlNV?=
 =?utf-8?B?d3J5VSt0VndMZ1UzL2VJeTFmM3dkTWUyeXlSZHp2dTllTjlZVjhxV005MWpW?=
 =?utf-8?B?VzE3ZFkyYVE4cGxkeHRHR21YY2dxeTN5L3R2ZG5BMHNEQkIvb1o0cE5kQXJQ?=
 =?utf-8?B?djU2ajlNbWRlMVljald2RC9wWVo0UCs2RC9aRGN4R3RVc2VhenN6WExHcjBU?=
 =?utf-8?B?b1V2SHMxM1NmcCtmZTFzbEZ4aTBBY1l6TkM5YS9BM1UyYjA1U2JHK0tqYXhv?=
 =?utf-8?B?TGVJMnpRZVl5K2NhWXpjNUZNd2VFS3lCdjBHei9UYmt1Z0xIT2xUQ0RuMzZr?=
 =?utf-8?B?MmtJQ1lneHgzM2NTbTNyY3IyVVRTcklNeGV6VDl6TDRHUVhveVRXM3hFVkNu?=
 =?utf-8?B?b1VIQUFPZGRlQWh1aHZmOThKNEYvS1p6MVIxUE8zUEdscWJ2ZE94QkJKZlA3?=
 =?utf-8?B?cGVaMjh3UzJjckppSlVFdDZqakZwTHFyY2w1dnhQV1BkY0kvYlFTcEtjWGZD?=
 =?utf-8?B?a1pNbmhKM2FuSnpmQnYzNm5qYWFKTVQwN3liRkhpc2dYZXlYSTI3Z1J3TVRU?=
 =?utf-8?B?N3NYRXQ5MlU4bVVzSk5mcjJLaDYrb2UzMTNhNW0vNWU4QXpFZWVMTTB5YlNZ?=
 =?utf-8?Q?hnt6GxhGWn1ICl3bTUF3xPEUo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bec37fd-b591-4750-558d-08dd3f725938
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 08:04:11.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s80ASvPr/yxDUnYvc/MQzSl7b9GSqEj/8pF6ZSxr7GnPyGrwV5HFNlOW2CAmZ8q3bH+RHRGsXPEReeXl667O9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578



On 1/3/2025 1:48 PM, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
> 
> The IPI HLT test simulates a scenario where a pending event is present
> while the HLT instruction is executed.
> 
> Evaluates the idle HLT intercept feature of the AMD architecture, if

Nit: Start as "The test evaluates idle HLT intercept feature ..." ?

> available. If the feature is not present, this selftest can be extended

If idle halt intercept feature is not present the test exercises
halt-exits/guest-entry for pending interrupts. So, maybe the test in
its current form is still useful if idle halt intercept feature is
not present. Is that understanding wrong? Cross-vCPU IPI or performance
testing of halt exits are future extensions to this test.

> in the future to include cross-vCPU IPI testing.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>  .../selftests/kvm/include/x86/processor.h     |  1 +
>  tools/testing/selftests/kvm/ipi_hlt_test.c    | 83 +++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/ipi_hlt_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 4277b983cace..d6eda8c19fed 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -135,6 +135,7 @@ TEST_GEN_PROGS_x86 += steal_time
>  TEST_GEN_PROGS_x86 += kvm_binary_stats_test
>  TEST_GEN_PROGS_x86 += system_counter_offset_test
>  TEST_GEN_PROGS_x86 += pre_fault_memory_test
> +TEST_GEN_PROGS_x86 += ipi_hlt_test
>  
>  # Compiled outputs used by test targets
>  TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 1f9798ed71f1..23a34a12be48 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -197,6 +197,7 @@ struct kvm_x86_cpu_feature {
>  #define X86_FEATURE_PAUSEFILTER         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
>  #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
>  #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
> +#define X86_FEATURE_IDLE_HLT		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 30)
>  #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
>  #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
>  
> diff --git a/tools/testing/selftests/kvm/ipi_hlt_test.c b/tools/testing/selftests/kvm/ipi_hlt_test.c
> new file mode 100644
> index 000000000000..09ed8011450f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/ipi_hlt_test.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Copyright (C) 2024 Advanced Micro Devices, Inc.
> + *
> + */
> +#include <kvm_util.h>
> +#include <processor.h>
> +#include <test_util.h>
> +#include "apic.h"
> +
> +#define INTR_VECTOR     0x30
> +#define NUM_ITERATIONS   1000
> +
> +static bool irq_received;
> +
> +/*
> + * The guest code instruments the scenario where there is a V_INTR pending
> + * event available while hlt instruction is executed.
> + */
> +
> +static void guest_code(void)
> +{
> +	uint32_t icr_val;

uint64_t ?

> +	int i;
> +
> +	x2apic_enable();
> +
> +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | INTR_VECTOR);
> +
> +	for (i = 0; i < NUM_ITERATIONS; i++) {
> +		cli();
> +		x2apic_write_reg(APIC_ICR, icr_val);
> +		safe_halt();
> +		GUEST_ASSERT(READ_ONCE(irq_received));
> +		WRITE_ONCE(irq_received, false);
> +	}
> +	GUEST_DONE();
> +}
> +
> +static void guest_vintr_handler(struct ex_regs *regs)

s/guest_vintr_handler/guest_intr_handler/ ?


> +{
> +	WRITE_ONCE(irq_received, true);
> +	x2apic_write_reg(APIC_EOI, 0x00);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	struct ucall uc;
> +	uint64_t  halt_exits;

Extra space

> +
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +	vm_install_exception_handler(vm, INTR_VECTOR, guest_vintr_handler);
> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);

virt_pg_map() is not required for x2apic. So, remove?

> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +	halt_exits = vcpu_get_stat(vcpu, halt_exits);
> +
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT(uc);
> +		/* NOT REACHED */
> +	case UCALL_DONE:
> +		break;
> +

Nit: empty line not required?


- Neeraj

> +	default:
> +		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
> +	}
> +
> +	if (kvm_cpu_has(X86_FEATURE_IDLE_HLT))
> +		TEST_ASSERT_EQ(halt_exits, 0);
> +	else
> +		TEST_ASSERT_EQ(halt_exits, NUM_ITERATIONS);
> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}


