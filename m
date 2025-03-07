Return-Path: <linux-kselftest+bounces-28491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF81A56BED
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C293A82C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF421CC68;
	Fri,  7 Mar 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gzTmgANE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C921CA0F;
	Fri,  7 Mar 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361111; cv=fail; b=kkgQZUMxUKU/l1DvFOUkRwbGMpc9UAe023umOorcbqXePbF1e0vi5PNQ9uJWMaSsBl3X7iUMR81l+EDaPsuE8mevCF/kZu9Ce05kl1g8KqyIWevSDiKUqZY3y50bG3NoI6+91DgYBNWcI3wQA6Z0E7MJ6VMrziAQu6hfSZJUFnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361111; c=relaxed/simple;
	bh=u+SsmV0wHESrkJOiFWvt7b+Fa8lpiy2UpsEtV7OdyVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUlBlpo4hod9ypaM6xrpIRuanZz2YhaHTXata43g69Hoh/eWdRtPzIK72P8FEJHVqltB0KdRl9rxHHCxJywHy9rEp7uoOMd6yAcq8SHDWYdM9GXLGBRB8Eh6JOCVpdISy9oRUP5wVWLxaa8rqaHdT2SZfa8njb66sJFjK5YR7GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gzTmgANE; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+mTx0ihFYEZiI5rgFQMzUW1tJx44DIZQsjF9QrkHcVI8w9q9PrJDNOz5sdhn7WEWZKBrrDnwHLeH0yYN9VvGQ4YrE0uOMpNY3RM9l8J2ByIX80SMirHr2PA4SHiWHJpGQNF0XTMUzygKmY6Xwt4oRgChF6UUJwWFbWoaYujTp09FyDZtPQa9n21c/4D7ohnSqPf7Muosx1Yy6outxsxW6eSCu6ysu6q2avBPl/I+ELm+h3MdtDEwoxA7JrageUxOnHbLWZK7BOleWD3sSqhUjwhftSvJBvB0i/XF2Yqkja5WFPjfF0w8R3vGet60i5ztxL86KhALzdMtZTnsLnMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rnStXDmHsWHSbQIFqNEkcAYVcg8vHuZh8C5Sf0/u2M=;
 b=tc5vnRj1FzZPX/+MTPfPQP+zbDhDlG8ujrANa3POgAQ+MkF6WFgH8mrlfSn0cM6It0DbB3ZiZPYkC0I8SFtc/p+Upi3LYHVBGPIo1IZ9JKQuSdwIVEIgYpuDkKeO/k4vkgVVc0+XbAt7eLYTpSOE40cGg3nTF0jwhXsBvPUVqKup9nIXids5hkL83t6o3eSrocXOlCqac4DdH0gM0bUCERLhYJsiJqTVle/AZPjIS75HTsSJD1xBIza5HEOyESdTgnFvjp0d7bUK2uGEE3akVpvX1+9siSpUD8M/oV+vFuVfjFe6FPJwhJrVy2e4qIC9J08KtKGOMHs0LOKKZjDOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rnStXDmHsWHSbQIFqNEkcAYVcg8vHuZh8C5Sf0/u2M=;
 b=gzTmgANE88iY6Iz2n18XcFeEDTQ1ci/ms6BnyHgwbtZNTwYREVxK/HhAti7eXA0iGid9lQCwJslBoPslSzS2g9HuRw8vtu+bxdJHLQ+vklTMc8jB5kJaDr4rzWlzUqgR92ryToArUIaF59X6Tvx+UdikPaQpU/UmZt2QDwfjrl1by8pszozenJUuVd9n8IIXA1bvXdS6AyIIjermhbbQJopieMJUkQ8jLVQYT4Mltsu7dtGn+w8f6cjvC5WUjpThtnh6hVO3MLWn3hoCBHWV8l/WQy+5Bh2o1VnU2Cs7JdQ+RlhAiiOKrALP3XVEBa7nK1cdOuGgPmTJpv9KSoUfKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:25:05 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 15:25:04 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Fri, 07 Mar 2025 10:23:50 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <511231F7-6FBC-4B9E-A63B-7D1E47C9B076@nvidia.com>
In-Reply-To: <D45D4F01-E5A5-47E6-8724-01610CC192CC@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
 <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com>
 <0582f898-bd35-15cc-6b4d-0a3ad9c2a1a4@google.com>
 <2D7DFB2E-DB80-4F6C-A580-DEBC70318364@nvidia.com>
 <176731de-6a3b-270b-6b5d-dfce124c8789@google.com>
 <D45D4F01-E5A5-47E6-8724-01610CC192CC@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcc2736-4589-430e-ba7c-08dd5d8c3c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzB5U0ZaN2pSRzRSem9jcEJkTnJ5NVdjSWUya3lLN0I2bC9zbnh3NEZkMnBh?=
 =?utf-8?B?bzlacWFub284Yk9DckVyOFBxdERRVFBXOG00UHozQ1kyOWRudEZCV2kxLzZH?=
 =?utf-8?B?L2wwL3Zia1RyTko2ODBHUXdNZVdsYkgreWNVQ3pnYWVkaktnRnYwL0lMeHMr?=
 =?utf-8?B?ZnRSUVFQZ1ZaaTVPUGtvc3U1V0d6NjR2MzJJOE5FaTREVWtqaFJOTkZ2alFJ?=
 =?utf-8?B?TlhGR1RrSGs5WEl2RU9IdGFueFpvR0pNcDMxSlo5V21QTUVFV1NrbGI2dlRo?=
 =?utf-8?B?NW5RZU1xTXFMSDhLTG9mQ1J5TkFyQytyeDQrWjQ2UDRkWWJsMmFueUpJZ2ti?=
 =?utf-8?B?dldLZ0htZk9yNU5sTE5XajBPVDh3UFZqVyszclRxYWI3eVppSW1VV3BPQ2tm?=
 =?utf-8?B?a25FUkpGSXR0d3g5Q3VySjlCT0hiTGNpa2QwQmxUYXQ4S1Z1ZUZNaCt2WDha?=
 =?utf-8?B?ZndWb1JWS3VJenMwQ2xOZll6cHllbjVkZHRnZGcvc1JTaXJIZXFaVkNXWUp2?=
 =?utf-8?B?ZTZrQkxyeG5UbkE4THY3dDBHYjZoL3ZKc1M0Nk1EdnBpb1RYK2VhcExEeGE0?=
 =?utf-8?B?TFBLRTlvaTVNQS9QMHFROFZva1I1dXVFcG1PaVlFaVMvcGU1dm1jRkpnZ2Vy?=
 =?utf-8?B?NEhWdkZKRDl4M2dXU2I5MXZaWjgxd0ZwMGJIVG9YY0I0NTV3QmlqdjE2SlRV?=
 =?utf-8?B?VE9RY3ZPbHpTWTE1cTZHdWw5YmlPTXQ3bnRxbFg4TkoycUVNcXRPNzFzV21Y?=
 =?utf-8?B?ZXUxY3FZTmF2TlA2SFEzN3ppYWpzbDAxRDJNb0N4Vm94LzUzWmhlaStmdVZo?=
 =?utf-8?B?bkxLODB2Y0dMQXVydUhZLzFERXgwZHRFV1FENDdZTE1oYno5TW1tRXhEVEZr?=
 =?utf-8?B?Z0QxRkhWRnJhb2tCYWlkbWJxSElZSXUvNUh6Zm5zSWJJTHNoRWpFak0vTlcv?=
 =?utf-8?B?d05Wb3FUanhGeE1meG1zVjZmOUQxdXBvanJOS0NyTTJ2a09oTnRhQjRBZGJn?=
 =?utf-8?B?U2NoWkVPVXQwb0JIb0RpTUQ1bE92czVzb3RZTFBrK2tPWmh2MC83M2YzaDQ0?=
 =?utf-8?B?aFUvVkJORHdnNW8zdG9hNmJNb3krRWlJdjQ3QnROVUZKdXhxQkM5RmV4WC9V?=
 =?utf-8?B?RGd3eEVvTHR6RTNyQUNjOFpPaEtselp2WTk2UjFxbFJwb3NqcDFtWm5qMWtQ?=
 =?utf-8?B?SWZMVFFCcTVpWnlYNS9PdVdyZFhLeDZpRVlUUmpubGpZZ3hzZjdNRXpybG93?=
 =?utf-8?B?R0tYRkJ5WVlVVzVBcklGTmxiZ2JWM0lJRWp3WDV5ZUhaaXZNalRQRG9IcXVS?=
 =?utf-8?B?c2ZtL0JwVFpIRmZsZ1NXKy8zakduY3dJNGV5cE1FOFlvaTRUbmI4aU1LVlIx?=
 =?utf-8?B?QmUyMUV2STYzZFBLUHlscnNMekg0SFB5SzU3WHk3NmJ3YzR4N0dFL1pFUGth?=
 =?utf-8?B?bUt5cUR0bzMvQWVHRHVQVGI2SXFLWHc4L1l6cW04UG80WThKWTB1ZWNqVWdH?=
 =?utf-8?B?cDZJbndzRnN1d3REN3p4WkRWcWZRSFhMclc3MnNFYldYSDU1SlM0RFRvQW13?=
 =?utf-8?B?RnI4WDUvcXdHanlJOXhHM0hZM0dYZjNmdzdTY2EwLzVsRFZOaktFOUorSSta?=
 =?utf-8?B?T3hFWmY0RXhMUVJLVzVKTzVsVzEwdHhOUEk3M2YyQTc4a29RclBvem9JNGhT?=
 =?utf-8?B?Z3kvL3BnUG5lVW92R3VPUU9qdG51MFoycmxFL0JiTU0rMGRDRFdtWEF6YTd0?=
 =?utf-8?B?S3llMG8yc1JFTFZ0Sk9NQXZHNzl3NTZhNDRvOGxqVmRqSmdBaXA0SS9Ec3ox?=
 =?utf-8?B?RUVYcXV4QUZ5Umo1ZktsenBidVdaMm1DM0lKaHdJODRPbUNtd3pLOTBla29X?=
 =?utf-8?Q?WNpDRZxTooJfN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWZLTHpMZHdsbEpMdU5wUXMxeWYzNmMxT2c0Tm1UU1hzYldtSFJ3ZkdKRDZ3?=
 =?utf-8?B?RDBHUERSRzcydmhTaEw2L1p4bXJzKyt4NlVtbDZrdGdDSnd5UXN6eEwvZ0oy?=
 =?utf-8?B?STBvS2Y1aWlXL0JwUm5IVEZoM0RCMmNSYlR1YVlxWWluMWRvekdSODFMdkRy?=
 =?utf-8?B?NXI0YStNY29JN0RZMnZ0M0RGdmpTNmhveGZWM0diTjRtVkRWOU5XcHRyL0M1?=
 =?utf-8?B?eVZNT0pSQ2hRSW5wK29DZlE4U1pPRVhYYkZpaGM3WGQ3RmdHdGIvMWd0SnhN?=
 =?utf-8?B?VDQxdUFiemlCNWEycWtYMWlSbFZCVDJrVk8zSmh6R01Jc2NGSzJOZ3E1NmZo?=
 =?utf-8?B?SVcrWlltbTA0aUZJMzNtQ0NiaFA1MEJpU211WkFUaWZ3ajZpQ0NJbWdSamZ4?=
 =?utf-8?B?U0RiNUdHMjh4SWVGNm04bGpvODRLZExSYXprdnE2ajkzbmdVWDQ4dm1oOEcw?=
 =?utf-8?B?YVlrMmtqYzk2bGtXS084Rm9pVzU0UjFoK3BKQ1Vaejh2YW13YjQ0aG9lRnZn?=
 =?utf-8?B?V3BBUnh6eHZNc01VTExTNDJEOW5xSnpNY2tONTZvNUIraVgwb1pWYnBtTXZD?=
 =?utf-8?B?T0tib0JUeFkySDk2N3FvK2NDVE9lQkVuUkVRVU81czhjN0NMMGtIZjVFTW9Z?=
 =?utf-8?B?TC94ZFNkUFZ1TnFQQUtqZndGS2tjR1BzejM0Tk92RXllREE4bUxydFJzYTUy?=
 =?utf-8?B?LzZBY1pJTUlCcjBYSFhTZFNabE5DYVRoWHFkT3BBcUZOOTFsNlhsRHhXOG5K?=
 =?utf-8?B?Z2N2Rm01VHpVN2wrbXlod2wwRFZySFV5S1pnQ2RvWWJ1RjJYdndabXVuZUkv?=
 =?utf-8?B?VUhyQmRMV2hyNzd6cHEzUm9RazM3NldTWloyM29XTkp0UUpRMTdnODNWbUlX?=
 =?utf-8?B?b0JGUWtXZHVRS2s0TDEwM2pZZVQ5ek1obm9UbnBXczlpSjBvSFRJUkhlTzRi?=
 =?utf-8?B?VmkwOWpkaGgyeFBDVU9KWFRudUEwT2o2WDVjNjB0ZUp1ZkdNTE9zSFA2azA3?=
 =?utf-8?B?YWFub2VRV29vWm5ReU1SMmlJUGRaWVN2d0FvNm81d0hVS2N0V2ZqK09GRitP?=
 =?utf-8?B?WHJsUk50bWpOVzNTcDFMRG1aUUlEOTNCUjFieVlYazA2RnFLOVg0M2k1c3BU?=
 =?utf-8?B?UFRnWXZRcVkxWlFWVVBUU2gvV0hseTFYQkRLaE1KT3lOS3hsR0h4VjJhSmor?=
 =?utf-8?B?aHltQjVUR3ZXRUQzeHNUWVYzNzd0RmhRTm4rVDI3RjJsU3QzYTlnemUrRGlL?=
 =?utf-8?B?c2xsc3Jib2Zla0UxQkM4UFRNTXovWFhJTEF4dWY3Rlp4MW16dHk2cWtxQkE5?=
 =?utf-8?B?NzhGQmlzK1Uxb3l2aDMwS2tlVFVCZFRQa3J5YXNncHdxZ3ZXNmdjd3VsN2FO?=
 =?utf-8?B?YjBzK3hKTXNBVllHdVFPRkNGV010OFVRSlJibkxhYnJWNVpPVXVvcmFCb1NN?=
 =?utf-8?B?MCtDbTJPZ0JXY2tzR0RwTm5VTVpGZ2ltR2hXMEF2NStrWklycmNQTGtaZ3li?=
 =?utf-8?B?U2JqMXc2OUZXYk9MdFFYMENXK2haYkNLa2VGR1pwZ1pHNE5rZDFKcURWVmJQ?=
 =?utf-8?B?RytrYzdoTFc1VkFQZDlPM3RhbDNiZG1oWU02OXR5eXVqNmZ5KzM1dE9naENV?=
 =?utf-8?B?M0NzTXU3Ynd5M1FwRnlVTEVLV1JYNUJZS3Y2TzNsNVN0U0tBWW5kcUJuOFpH?=
 =?utf-8?B?L29EQlJ2TDZCdERCU2MrTkpLYVl3djBsVThPdW9FY3pyeVcxTFhHbWdzRjhX?=
 =?utf-8?B?ZkRTbVA4NDFtaG01MDVvbnVFZmtlOU5Dc2JmbzQ5SFZrWkxSc3k4Y1JZajdM?=
 =?utf-8?B?M3JPd242MnpJTzhrbFBsd0N4QjUzaXBFcG5idUhlMlB6REJFcTZuNGZPNVlX?=
 =?utf-8?B?K3RDT2pCT2RlcWd6dzRybkg3SGY1cm14RzZJVUVka3JuZ1ZHUXpwRWhleGpT?=
 =?utf-8?B?M3lCaU4rYmdCclJsMHlRRERZWjhQL0kzS1R3M1l4S1hsYU9YQUVQSXp3b2JI?=
 =?utf-8?B?eTFZY0ZKVVVWT1VuTCs0MU5KUjhmMWlwZmxMUVhFN2w3OHkwc0d1M2NTeDVT?=
 =?utf-8?B?eVhxVFZWT0p6Z2dRcjNXc3BJQmFGZjdmOHNaQitjNUFBbzRyM2lGSThpWFlG?=
 =?utf-8?Q?cNS002AlW5Y2V1WDDYF/s9iXv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcc2736-4589-430e-ba7c-08dd5d8c3c57
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:25:04.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nS+HI2WIi3lXMvLVuXiTfe5IjDuRqokxSekiF+xCa6GMcIT7+B1HYIoQuxPZY1gm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810

On 6 Mar 2025, at 11:21, Zi Yan wrote:

> On 5 Mar 2025, at 17:38, Hugh Dickins wrote:
>
>> On Wed, 5 Mar 2025, Zi Yan wrote:
>>> On 5 Mar 2025, at 16:03, Hugh Dickins wrote:
>>>>
>>>> Beyond checking that, I didn't have time yesterday to investigate
>>>> further, but I'll try again today (still using last weekend's mm.git).
>>>
>>> I am trying to replicate your runs locally. Can you clarify your steps
>>> of =E2=80=9Ckernel builds on huge tmpfs while swapping to SSD=E2=80=9D?=
 Do you impose
>>> a memory limit so that anonymous memory is swapped to SSD or make tmpfs
>>> swap to SSD?
>>
>> Yeah, my heart sank a bit when I saw Andrew (with good intention) asking
>> you to repeat my testing.
>>
>> We could spend weeks going back and forth on that, and neither of us has
>> weeks to spare.
>>
>> "To fulfil contractual obligations" I'll mail you the tarfile I send
>> out each time I'm asked for this; but I haven't updated that tarfile
>> in four years, whereas I'm frequently tweaking things to match what's
>> needed (most recently and relevantly, I guess enabling 64kB hugepages
>> for anon and shmem in addition to the PMD-sized).
>>
>> Please don't waste much of your time over trying to replicate what
>> I'm doing: just give the scripts a glance, as a source for "oh,
>> I could exercise something like that in my testing too" ideas.
>>
>> Yes, I limit physical memory by booting with mem=3D1G, and also apply
>> lower memcg v1 limits.
>>
>> I made a point of saying "SSD" there because I'm not testing zram or
>> zswap at all, whereas many others are testing those rather than disk.
>>
>> swapoff, and ext4 on loop0 on tmpfs, feature in what I exercise, but are
>> NOT relevant to the corruption I'm seeing here - that can occur before
>> any swapoff, and it's always on the kernel build in tmpfs: the parallel
>> build in ext4 on loop0 on tmpfs completes successfully.
>
> Thanks for the scripts. I kinda replicate your setup as follows:
>
> 1. boot a VM with 1GB memory and 8 cores;
> 2. mount a tmpfs with huge=3Dalways and 200GB;
> 3. clone the mainline kernel and use x86_64 defconfig (my gcc 14 gives
>    errors during the old kernel builds), this takes about 2GB space,
>    so some of tmpfs is already swapped to SSD;
> 4. create a new cgroupv2 and set memory.high to 700MB to induce memory
>    swap during kernel compilation;
> 5. run =E2=80=9Cwhile true; do echo 1 | sudo tee /proc/sys/vm/compact_mem=
ory >/dev/null; done=E2=80=9D to trigger compaction all the time;
> 6. build the kernel with make -j20.
>
> I ran the above on mm-everything-2025-03-05-03-54 plus the xarray fix v3,
> folio_split() with your fixes, and Minimize xa_node allocation during
> xarry split patches. The repo is at: https://github.com/x-y-z/linux-dev/t=
ree/shmem_fix-mm-everything-2025-03-05-03-54.
>
> It has ran over night for 30 kernel builds and no crash happened so far.
> I wonder if you can give my repo a shot.
>
> I just boosted khugepaged like you did and see no immediate crash. But I =
will
> let it run for longer.

I have run this over night and have not seen any crash. I assume it is stab=
le.
I am going to send V10 and resend Minimize xa_node allocation during xarry =
split.


Best Regards,
Yan, Zi

