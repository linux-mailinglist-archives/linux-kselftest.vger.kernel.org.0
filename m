Return-Path: <linux-kselftest+bounces-28951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D194A5F740
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA991645BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935B26770E;
	Thu, 13 Mar 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cye+1ye3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC3335944;
	Thu, 13 Mar 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874903; cv=fail; b=h/X9eMFb+V3rMtqR20QtL/wLSTOn/zRjdsbNK6+8Jn9sin3IpLEJ4CGZ8Jkl3aIoMZ7wjFS0qrBBX5XSk4sBoYH8tXEOuMGm5doUaVoJ9UhzxLJYYceDJ83mxydfE6dGv6HSBOsuAYETQ+koeXHOqamkpwkwhfaT7RdychuBnDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874903; c=relaxed/simple;
	bh=u6tbt6LtsdBkHpLypp3h1zIEvaE3Do1fx4dz6h0k8S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PLcSJjXFC3iscugrXLOQb7y458dxJAl3gpf3yrAPdiZ3Z9oxsFEiJknD/ngRVH67kaorV1EYPuaz7GpOYx+YiMZkAs0/JdpkxRXe3+VmIUaKtQ8MLkoe9T2HqmogzlwnkGmG5TJ269ID9ioeSx03MnO87X85lcsrjBQ2oS/xwsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cye+1ye3; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCcSrwxmwnD68kElO0kg8ATAPXpbSw5sbRoOAst8/b56jrzbiXDxcBeIhGah61I2GYk8HncC3XeB36GfnSHWMgjodRvHdQHjKZ5/58EAwpTaf+VCe/BUIX/mgdwuG00PlnCLCmFxB8Kg2SYZP/5pmOLgKxfJSJNM21ZlP3tEvkD0BW4gHHfy5WZ6gLakzh3BrhBIMoPxCaGNZmEcpGr8wjCvHrftEuv45fr846w2zlNzF1ZUhnYZrsOKgICN9+C9j0xRTTjL6IEgDLzdZ0Z23V0rlE3q/JPnSFkl5kQUF27K0F01Dx4K/V74Mg4kok2fODXLZRwQPAnPzxRbNd7L7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj0b8aQSNrCdCETOfMLVEnaDw7hniceA4d5vzoCU/pQ=;
 b=ixx2682SX0oAqvpw1Cf+Z1DRzTTFiHyfO4n2EgdyM/D4jqwpD8rkkm8JaYI/+DhybqY3BKIwWNlk/r6Ztme/6NqcE0ewEVGaQvs9Hy8/TqXm0n3tVq8bBEG5AkfzG7043mMmrX4JR3JVz7MSUzCxhUoQIibj9QZiIqS2eb+jd5jXUeChCjrFo9VMffRpXofM9Ipu1L/3U9kH28F79FQDj39G3yiWpTwv2ikk5tOleNnJElurwlo6QCKpivTnz906LWXyYTBcva0KVqjyol5qXmwVI5q7AWcr54dtDxiNbYss+nOkWBog2XPFjsDE3ZvxOCHLBLMutxi9qkr8fxbudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj0b8aQSNrCdCETOfMLVEnaDw7hniceA4d5vzoCU/pQ=;
 b=cye+1ye321MzkRMFf345QJYTdgR88Q7vXITZj8FGnA+vEAIgsomuzGSP8DmI5LNzCGXUKZ1AiQ97EVJoeWfXNbdroLuPxg90UCx8tPvmyoQ8CfLtj6TvdTUE84S7k7I9YXRk98CBawGqiZg/dHucMMJGW7qMWT5ffPukacpGONtOVtjEP/FFGLPUgvTRcldjWRtQZIu6hmd9LSW4tE24l7fbAtMs7mTfGbCgsYIC/5LgLyLK4GJlA+gEtB7+gGnnUIIFbPCa93dXZpjG22Hnkb5RDgrCYEJLy5DEc2o9jmJ3p/4vtCt7tNt/EGJhMS6Ablik9bpLidX3I6KeprJEoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Thu, 13 Mar 2025 14:08:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 14:08:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 Ryan Roberts <ryan.roberts@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v10 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Thu, 13 Mar 2025 10:08:11 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <1E11B9DD-3A87-4C9C-8FB4-E1324FB6A21A@nvidia.com>
In-Reply-To: <0F15DA7F-1977-412F-9A3E-F06B515D4BD2@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
 <20250307174001.242794-3-ziy@nvidia.com>
 <71414652-95AC-40C6-87BB-2B3B2E680C58@nvidia.com>
 <0F15DA7F-1977-412F-9A3E-F06B515D4BD2@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: d218c692-90ae-484e-e5e9-08dd6238801a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1laWExyWmZuVnNEUnlqRkpMNEZ6NXMrUXdDSFQySUpYUWY5Wmw2d1RNWnA2?=
 =?utf-8?B?SHBTVjdpZkI2ckdpaExjUGUrYnhNM2dGTS9BL0hjeklGSDY5QzRUYmNBeEIv?=
 =?utf-8?B?YlZLT0ZTRERrWGsxaDFjU1BUTkNrVUNTWmFvdmFnMExDK1dkZCtobmgwVUR5?=
 =?utf-8?B?Q2RtOVdnUFF0cEExZTZRTmtJNnl5R1JObi8zellWaWxzM0NodFdFd1pQN3k2?=
 =?utf-8?B?U2NhY1FrRnp6NjY2bGw3MHBwRHV0cWRuaXFTL3NxZUlmeFJURGFsM1dmbUxs?=
 =?utf-8?B?YVlFTVJ0VFpXekxpTXBWaUxqSjhnTUw0R3RZL1VFZ1NUWTI5ZEJYWmh3S0xX?=
 =?utf-8?B?Zy9NYjc0UUJaOUpPTGZlZFJWVkhxUHoxL0RXNWtaSjZDUUxZSGpMQ2hVQkV2?=
 =?utf-8?B?UnJRK3Zwc1c4WmVCazE0cGdEMUduaUtZZC8yMnB5M0g4UUI2TGZrc1hlTzc2?=
 =?utf-8?B?cWlGN3ZLNjR6Y245SGRyMmdZYnhMZzd0c0JMbzhlcFRBbkNQMjNETDVZZ09x?=
 =?utf-8?B?Z1lLYzJCZERJd1NNWGZ1WG1vem1PbkhPR2x0ellZR0NBV2tIUmU5aG5wTjl0?=
 =?utf-8?B?RUs3citrR0h6VUZ0Z2JHOHFHTnQ3MFFxbDRITS9aVW40djJ6UFN2ZVJHZzVS?=
 =?utf-8?B?SGFhRkFHOHpuUVN6bURKTnRKWStNQjBJNXptczFPRFd5MGRxcmZnUEkzeUtD?=
 =?utf-8?B?cUYzNXJtOEtCMlhJbFAyeERqMm1rMktnZW5hRVNLekZJQmsxbW5scURXdngy?=
 =?utf-8?B?VHRVMFo0cU5qanh3UGIxU0E2ZG1rQlRLMmJhK3QrU1FGTGIzOE9STU1uNEZl?=
 =?utf-8?B?dnU4RDR4WHA4Vk9ZUkZEM2lJQlRsdUdlUzZtY2VwVzd3Y1l1M1FvNXBpV1VW?=
 =?utf-8?B?QTl2SUhZWGYyTlVXcERtUTZEekxBeTk2TDAvSnFYT0loQjJLck00Qkw5cTJr?=
 =?utf-8?B?d2pPc3RUelBZUUJrQjhsMjNsTkZIWldaV2o5QnQ4VjR2akZ4dHZqSVd0alZT?=
 =?utf-8?B?NDhWT2VlSHFib2VFeHlVQ3laU0RYU2ZicnAxVTI3VUpTWlJnZUNVZGM3dHQr?=
 =?utf-8?B?dTVCSHgwWXZHdzR4bXdYR0l5YnV1cDViMjZOWDdRQ08wQlJ2SVZORkxqOFZu?=
 =?utf-8?B?QkZxR3kvYTFQaGJHK3NVQXZ1NVhQbXBvdk1VWHlLMUtFWkpYTUpCNWU0VVg3?=
 =?utf-8?B?S2JiMjRKNHR4QldKbFloM1VkV2RhakpQYWhXanhyTzB3UkNvTUc4ZmFDenRT?=
 =?utf-8?B?V3ZUVStFa2p6K1k0b1JjRWJwWGVtRmFabFdVTEhMMC9xNTkrMVF5Y3VscXox?=
 =?utf-8?B?UkN5ZXhRbkE5L2RKQ0hBTEpOREdFOW01VkFXdlRsUElEYjRQNHZuT0ZLVFBz?=
 =?utf-8?B?TFpHbFVlclNSaVRHTzBOY2RWZFBZeXNJeDA5ZzNDL0dmakNWTHQ4Z2M4RlBH?=
 =?utf-8?B?OWVlUjlJTy9ZcDJxeXM0ZDdUaWZqN2pES0JET2RmRVQ5WTUwR3VYSldLRmZ2?=
 =?utf-8?B?bFcyZUJKejJqWVpUN2NVSkQyTTh3YlV0bVdMRE9sd2VGcmRuSFBlTUt0L2Fj?=
 =?utf-8?B?Y3p3SXQ5YXUrajFTdFZrZzhweGtYRXRGb0JCZ3JQdnF3Z1dzSkZxMmNjdkhV?=
 =?utf-8?B?dE95bXczd0tyd25QZkZ5NUYwVlRRL3crZlpHdm9uRUZIM0FDM2F3ZGpNM0s2?=
 =?utf-8?B?Q1JGOWFsM1Y3VENYVE5MNkJYODhCdnBkS0FTaWFza3JFVSs2bm5MQUh2K2NQ?=
 =?utf-8?B?WXhVM2t3TS9SemovVXV3MjEvZlFVZkp5YXZlOFowYUkvOENvQ0FUeDA1dWU5?=
 =?utf-8?B?RUszMW53a3BDdkpEL2RkTHpIRURtdXYvbm1XeVlSbk15bjhMeUVJQUplSGFl?=
 =?utf-8?Q?YB1SUCn2Rskj4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWxkdkZpYy9nR0N2Q0RzYkVuOGdFYlk3VWFZaWdYWlBYMUNuOFRRREtzOVhU?=
 =?utf-8?B?c2Z4T2hhRjhWMVFvY3lZYS94MDBwMXc2WkpYQzBOWkJrSTMyTjFIUFBNRzVH?=
 =?utf-8?B?WUx3REgwd3JBZjlwalNNZFVlNW5LKzdGbjVtT3hjTWQ1RmxZOGpPVUVCdlBC?=
 =?utf-8?B?bm1XS2NJY3Q5ZG1sZkNldENZb1c4emVBQjlVVUlTRXlCRzFiRHpleEJJa0dO?=
 =?utf-8?B?WTNNOU51WVJSQ1d3NStvOXYzWW1GTDNCcUM3MWtBMWtENFRUYW45TnFtUlRR?=
 =?utf-8?B?YUJ6eUZ3REJ0bStUcTFLUUhzRlhJcFBSM3Vmc3ZlUVdTWmlrRHBoa0N0RDVB?=
 =?utf-8?B?aUFLenhMQTdOUi94WTlWMXRESTJPemtla00wUEN5Rm51b0J5VEhxVENjcVhh?=
 =?utf-8?B?Q1NnWTJ2eXNMTEN0d0xnQ20xN1YyanVWWG5HalRMWHU0MHFWcTBPbGNuN24v?=
 =?utf-8?B?MkJsaTZ2Mmd3WDRYSTl1Z0ZvZzJoZ0RvN3dhS3RCSHNqQzVoNkpjMjgvRFVJ?=
 =?utf-8?B?WjRNOUorVEhrYVFYaVQrak1qSUg0czZhSmp1MU5LUisxSzE1NkF4UVVEWVl2?=
 =?utf-8?B?M3Z2R1Rkdm5sZzRvblpsNEZSdUxCOGxmS2QzRWsrbHVpcWZoeklZZCtTZWFw?=
 =?utf-8?B?Y2ZPak5XSGFxWXFnN2ZFRzAvSFc3L1ZVVjFkTDFDNWEvaWQ1OUZXNkF4Y2pE?=
 =?utf-8?B?VllqM1VTTGxCSWZTQU8vekM3TFhFZXd3MU9kenNCLzdPS2VXZUhqWGFNZmRo?=
 =?utf-8?B?YkptQ2J0aDE3a3ZOblcybWhjbDh3eGZjaXgrOU9YSGFYMGN0RFNIQW1pTklP?=
 =?utf-8?B?UDVZT1pISTQvWG9vbnVvUmZUcFRRMDdZM0Y1dGlyQUQrMVBKMnJlUHNhTkw0?=
 =?utf-8?B?N1Y3dVJrL2ROS2tmWnNFTzVQZXFYbGtRRHExQUVXaGd3VDJlc09CTTRNVUlR?=
 =?utf-8?B?dFVoNFNUWStiM2NpNWlMSjlBOXdNT3pxTVI3SUM4QTdrdk9RVm01M0JlRkRN?=
 =?utf-8?B?V0kwa3lIRlh1MEljcTVMZTNyWDJZT2U0UU1xSXplck1RamdFUTVkTTBJSkc3?=
 =?utf-8?B?eGVkYnFNL0d4eENQam80NGtWSENZRmI3RWppUjduVGJDS0l0ZnlXVi8vS1Fn?=
 =?utf-8?B?Z3g2cGZjRUl2M25SR09NdHczSzdhVmpNeDAzVm5zaG9rZ1VuQ081WG9uaW1l?=
 =?utf-8?B?QVo0dERZTng2MURuRWVUajl5eW5NZll0UnE5c2FwZ0VSeDRDQjMvdVZWcDlU?=
 =?utf-8?B?cElzQVFJWkZGSm8rdy9jdUx0NUJYQzI2Rk9CVTArZER6SXBJZE81K1FkaU9S?=
 =?utf-8?B?WHdmc3hBZUk5VDNpRzJZV2NmNHEzNytIN29BbThQK3JBK3dmeitxbXhkTnJi?=
 =?utf-8?B?QmRCOE1LYm53K3pQaE5wMXl0R3hCOTllQmhQTlBwU3JYUEQ0UlB5L2RsTC9j?=
 =?utf-8?B?M1pNMCtoNkFjbUxYaFM2LzFuMzdpaVIzeWRTcjJDSUVqOWRQWDVwWW9YUVM4?=
 =?utf-8?B?V0UySU82enczY3RMVVFqZ2s0YlJDTTA2bmJyaEo3elZQbEZIeGZaR0tSa2dq?=
 =?utf-8?B?MHE5dXV0L2hmeVpiVVQzWmpGUGhxWTl3cDZrOEZlU3ZEQllwK0VhWGdMSnR6?=
 =?utf-8?B?cWxpRVJ0cjhyTjhLaG9maGxVY2ZXN21VQjVuTWNlNVFNZGdJYkNlY0NXc09Y?=
 =?utf-8?B?KzNLcEVSSFlZNWFVeit2RzFpbDJ3MTlrSW1PeWVQblFrWms2L045dUdHK25p?=
 =?utf-8?B?amtTYU8vcjl3Q3dMMnJOeTVnN2JJdHY1OERlNENhVU1janlja2xqY1BEaGp6?=
 =?utf-8?B?cEpUWllpbHZzQ0ZMWDI3RzVRZnJHL3E5bHEvYWtFVHg5VE4rNXBYWHVZNTV0?=
 =?utf-8?B?dmdOaTVkREVzUDlYNkloQzY5ekZGUUlON0N1VjJsdE01SGY4TlB0L2tWNDRs?=
 =?utf-8?B?YXVCZWQ4NGlMMXp2Smwva1NVenM3dStIek5LY00vSXJzQ0lBR0gwdDkyZzND?=
 =?utf-8?B?KzFYMjR0ZEQ5bEdQQ2pwRldqcGZabStEQ2JUTXJLcVVIc2phcDlTeUNIaGgz?=
 =?utf-8?B?Vm81N0FsbWV4TFpKNUdZbUFqOTc3MXkzZmYya1NJTnRVT3NEL2YrS0haVHln?=
 =?utf-8?Q?2hfA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d218c692-90ae-484e-e5e9-08dd6238801a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:08:16.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJj5IQi1b2gEQJe8BfrLAflOP2NMBqH+p3fcE8Z/6Op+I284MD/tgSqkJHIhA1/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

On 10 Mar 2025, at 13:32, Zi Yan wrote:

> On 10 Mar 2025, at 12:14, Zi Yan wrote:
>
>> On 7 Mar 2025, at 12:39, Zi Yan wrote:
>>
>>> This is a preparation patch, both added functions are not used yet.
>>>
>>> The added __split_unmapped_folio() is able to split a folio with its
>>> mapping removed in two manners: 1) uniform split (the existing way), an=
d
>>> 2) buddy allocator like (or non-uniform) split.
>>>
>>> The added __split_folio_to_order() can split a folio into any lower ord=
er.
>>> For uniform split, __split_unmapped_folio() calls it once to split the
>>> given folio to the new order. For buddy allocator like (non-uniform)
>>> split, __split_unmapped_folio() calls it (folio_order - new_order) time=
s
>>> and each time splits the folio containing the given page to one lower
>>> order.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Yang Shi <yang@os.amperecomputing.com>
>>> Cc: Yu Zhao <yuzhao@google.com>
>>> Cc: Kairui Song <kasong@tencent.com>
>>> ---
>>>  mm/huge_memory.c | 348 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 347 insertions(+), 1 deletion(-)
>>
>> Hi Andrew,
>>
>> The patch below should fix the issues discovered by Hugh. Please fold
>> it into this patch. Thank you for all the help.
>>
>
> Hi Andrew,
>
> This is the updated version including:
> 1. Hugh=E2=80=99s fix on unfreezing head folio correctly,
> 2. Hugh=E2=80=99s fix on drop the right number of refs on tail folio,
> 3. Matthew=E2=80=99s suggestion on using new_folio instead of new_head an=
d
> using i instead of index.
>

Hi Andrew,

The fixup below should get rid of the sparse warning.

From 83472fe89330a262facba427051426e8cd13e218 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 13 Mar 2025 10:04:20 -0400
Subject: [PATCH] mm/huge_memory: use NULL instead of 0 for folio->private
 assignment.

It makes sparse happy.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503131109.s7iuWfGq-lkp@int=
el.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 14b1963898a7..e3ed8e9523f5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3369,7 +3369,7 @@ static void __split_folio_to_order(struct folio *foli=
o, int old_order,
 		 */
 		if (unlikely(new_folio->private)) {
 			VM_WARN_ON_ONCE_PAGE(true, new_head);
-			new_folio->private =3D 0;
+			new_folio->private =3D NULL;
 		}

 		if (folio_test_swapcache(folio))
--=20
2.47.2



Best Regards,
Yan, Zi

