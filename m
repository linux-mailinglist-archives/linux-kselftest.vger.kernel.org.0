Return-Path: <linux-kselftest+bounces-39701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF1EB32122
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EEB640D34
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A44E321F53;
	Fri, 22 Aug 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QmQSjgqy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DBF313554;
	Fri, 22 Aug 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882507; cv=fail; b=Hb/8LjEgg5Ul4haco6s2TK4teVqOUMRV45fHBpOn8zvdpHDjStTgfrLFHglSXX6QwwobetD9EI/HiVfrx1XNkUd/O+MUSdON/FdZ6H+LkJ+hgc/niqweolugLmisP8WglJbcuSrOu9z5CoIT09GpT0elpPkCFolh7GLV5YVNPzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882507; c=relaxed/simple;
	bh=We3wl+hbPUu7UL4p0YbbVYht0YMQkcUE0Z7xcnPpWWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qkmTThBBLhZN/7fy3lB+ifBwq9G+2Ddj/SWDDZXJn1EUUx5KtxBQ/gSiUR1RidS8Fi7cTIK5oLrEYEuAEU44BXgkpQpnV+gBxddsBmuNZmpzgBEubuF6m+lh9A+SpUWz1cMLqniDm3F4ulLVsAZm+N0zByleBTqLAYZX5ba3X3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QmQSjgqy; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCAVH8Gy71FEz06RoR5zFpAOWFKt3tpV+Nnhx0tHFbof0zhtFnpfb8V0A+7vHIDbusMsBPwO7cXNPe6iCdcH+vXVgRx1Tc8kEoyNjRxdn8C4xEwWqYO3csTHt9M4RGqxJE9myRMoUI+zm851FPp0YvxGgFbHFI0cL3UR5KHaIoRBn7Uy97GEl1VQ485OrCwBuaY0xFZyXgVgkAYu+ac6MCa8crsvDzuDFAqgi7GuWG6+sChC35mtDaoU0HtrpAaMS1CanyifGA3NKzxc7uVscIre/k06K6GSeHTeLn99zR565mjBp6mPNmU4kSFtFMQ6Ir1F/ETni2uG5XYXEX7LdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3BsPt/hsUiGGdKLwxrd49/GXmJgFiDf/ZufbMJBYpw=;
 b=fv+weZTJN2kUBqBNBS4nFGRjdhwGD4tKU1bQjFWynFaOZMlLlk2AaCws76U0JYiPEbNSd9Rti9/loiSZ6bSBbHE8o2vFXZwpxQ+44aPsKHNG8py0gImK57ATl6WmBzYLS2wkr41fG9R7uSb0ZFHAjnJDVRMa6Il1bkjLsZ+scXwK+uNOmrXQUnZHZjwbELfgtxJD9bP0Luw7ZMXA/zJNCxGd0j92DphL8XYjEE5QUpZ5PjVRROZu8rf8Rtfss7RN6tBzOFLgr5AFnZRZwoCoTQTMBFZ/ynbL8bxV+nRgBCwJaqFU6ZgWsv5VEmKOZb7T+nHzxJgOeI/TVMG4Myn8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3BsPt/hsUiGGdKLwxrd49/GXmJgFiDf/ZufbMJBYpw=;
 b=QmQSjgqyrsmplRrcdne1ygMX4G0+l0k4qpgJNPrH7scbAxHgIbXvgnq7hoIgiX8qSNQ9ZeMn9HrwxcnkO++dFZJ4brqSYmolF/OAkDwyVqg7/7Pac9AJfJlCBKD6hhjnJk0L4e9ws0KTOhwzG76XnYvT9L8MsoKpc6qpLFKv5GhwWTr/uxOP7C0rDCu29SjXtedFExBpJTOggGu7ajRDhKLjQ+AvhHgMBWtubgUm0Sy1M/8lpV2zTba3hAOD85IQJszB4BhGbYjhzJpRjmQhvvgwW2TNLJU6WV5DPAsPj/x9RO84nAIsCd/Lp9s3oAhF505dcBnCaVmJqs1xPpHfmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 22 Aug
 2025 17:08:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 17:08:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kevin.brodsky@arm.com, kernel@collabora.com,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH v3 1/8] selftests/mm: Add -Wunreachable-code and fix
 warnings
Date: Fri, 22 Aug 2025 13:08:19 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <6670A610-5230-40E1-98A1-7F30A9321B2B@nvidia.com>
In-Reply-To: <20250822082145.4145617-2-usama.anjum@collabora.com>
References: <20250822082145.4145617-1-usama.anjum@collabora.com>
 <20250822082145.4145617-2-usama.anjum@collabora.com>
Content-Type: text/plain
X-ClientProxiedBy: BN8PR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:408:ac::48) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 08705c30-20ee-4777-18ae-08dde19e803c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QOQKrt5wcOXP0adgULxqSfzmm5JYBg0n9YExjk5+8sT5D0FQXiPoB9qSsyL/?=
 =?us-ascii?Q?WZIchi41JgkF2ALKLPOGnfZQMUqJcPLvJXwuVKy/l6EdigJdFiHIy2RSO7ej?=
 =?us-ascii?Q?07+A0//dLVsgJP/sPQIClhVtXqZJEc14QKG/dSzC7ZOM16tm0m2VEnV4eIbm?=
 =?us-ascii?Q?OoSTR2ir5hhU8ZABoxsHW5FIBCEytuwrM2FqPYfECANi7WbAsDlInF9wgR7b?=
 =?us-ascii?Q?TYLYlNiPBl+WOKlpCzrVWMt7rMgh7nfhVPTRe3xbSB3wiqmO23cTFV/L1ogB?=
 =?us-ascii?Q?5WI1DAZOek6tK1DEjp0A0eQ171Ek3qNE7EwO6kaFTySdO3McBb3Uo6KN8K3t?=
 =?us-ascii?Q?nW5i7yfOhBsHKroPuNGQIQBFkaJI2S1LmhH6DvZsHxVotvESML8Wu4OTVNi+?=
 =?us-ascii?Q?J3Wo/lzcIcOtkMuoQpNXpKHdFqNdcqzbFVqOL0QhzbhPal2kkJO9yejJ34A2?=
 =?us-ascii?Q?KutJEpU5mCumMHXiJ4EF/k1+wBsQ//AEX3azhsfWp7L7zeaKRii0ZysG9ZGw?=
 =?us-ascii?Q?4ScujcA1WmQU3q6KSLC6CLjfEbi5/4YsY1isQptCOQyLfMi5lQLaCeWVpSTC?=
 =?us-ascii?Q?IH3J1NqaMsedmPYLSkNNI3NxcDmQQ2kzpGKfUcEMgAxBGoWaafEBbjG+4Uqe?=
 =?us-ascii?Q?KJmiDilBhKEXHUAr6SgZeCWHh2qkveepeIYmqw1HE6nIbRn7fGe1Z9nLTT6E?=
 =?us-ascii?Q?XUwjVyRp8f0d3OTIG/uvYfvr9CfSqF6L7KmohvjEqjBBUN6SgSBTt5JP+Gb9?=
 =?us-ascii?Q?1zHrT7ONaYUOGaKzIL1ZvVPdXiPZ5VBwe74fBLdfvUawrxrbfiOdr/QZnufX?=
 =?us-ascii?Q?Lepq+vjeVASoL/lJt6sBDwVapLYyhhQBLRj/I8QokzydG/S0P0/+pxXlB9bE?=
 =?us-ascii?Q?XJIuO1VLXjDOBeUyFUkTenY6vmqsPBaympVg5TiPbruK4DZYzalBlP8i4okD?=
 =?us-ascii?Q?JtWDsRE80UCvLnkKES/qMMFI2HMzPLt7T70K4gabYs+TV3yHuV/g3F0EgNW6?=
 =?us-ascii?Q?DnM6Hy06Ym+fIdp8SAVVdB56em15B9Yc96T5qyvp9rDALTSDRJ1zV5T2xV+2?=
 =?us-ascii?Q?T6sQA9iY7sAh5Fm/9HqFRQZpK2C537D2cBzm4W5r2DKypuk5VMXvhKx0a8E0?=
 =?us-ascii?Q?eyMEX7x2EWc4/6MM/s+sIJJVmytfBnwk5GmwFvvyhCBTgZBuFozUWi98T8mu?=
 =?us-ascii?Q?vYKshvXBSrfJ+ah9/duj7g2nkQM3CKR7m5JxpMPiHUhpnDArQIpoPSnQc7OR?=
 =?us-ascii?Q?nEVSBc1O7cFcKYpzUjkgVAG5Rr1AyiX9gT8dzlKKqL35t54JhUXlZJvpxGD+?=
 =?us-ascii?Q?4JMBzFQry89Bp0RthxxeQNxY19eCi1aA0gVILhx+a+icNsbwMcayeItFmzP6?=
 =?us-ascii?Q?yLU74X55JNyhnQwapnio/SjUFJE/yZYyCULWfYLrKSYkj1/johGVHN/MGZRb?=
 =?us-ascii?Q?jd9eHYqUG00=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E55Tkv5cR3ddJa9cCZyGNkyw/Tfvr+SlZCYMoM1BkhrD3UT9rAJo2X4PuIyR?=
 =?us-ascii?Q?vGt1rYAYEHUcP00X+/+WQcg44GM1oJouNcL4v2OzgaaGtaqEm2m5YSEdWbk5?=
 =?us-ascii?Q?lw4E1bDflTRHwrfPouxCjqO4SpQyjmPTq/A1gu7L2gbsMCbDC3d0+TlhJR6p?=
 =?us-ascii?Q?AesxdlwWi/h7L//4HrwkPrBQ07GdzkKwlTbiH1+PfOo72AO4pyVH7oiU8mSK?=
 =?us-ascii?Q?DlAhUNvQEnQQQLfK8TCN0iYm+ZesmLpEIREtLjBs2GGMwSqYeqZotawgG+HS?=
 =?us-ascii?Q?pKkNbnulg3iGBZSQYj7ivSEAOaFMRuDTFwwoP+vWyWfTu/AmJub/DHifEqX1?=
 =?us-ascii?Q?bkrudNaeEKwpW84Y7soW98EnvrIVWsPsrAc4+aWivjL2SBWghaO3u8H+uS7T?=
 =?us-ascii?Q?kzYN7NbolvKUL9xfkwhRXRszli132V7++qZf5Iz6zrlKyILwWG4ppozw7Bp/?=
 =?us-ascii?Q?/tn/GJJQ2Zh12J9xlhCdK7x8BDL3cX6H1cVOxeULPkKdV9i8tBWe/++UAk9k?=
 =?us-ascii?Q?naPWczPJQjOrfmd2MClGYtkxshjEYEsswQO+4nJ8EDsfGxOGdBHRDgeyVinu?=
 =?us-ascii?Q?GLr+bZEHwceW6ESjnie5CDO2+k/bEAZOk+RJpL1AxAxKDWraPUgnWHRRk+Fl?=
 =?us-ascii?Q?WREN3WkI4AevAanM4QynCiyg+cJ3jhKdHbGZUoNnrPuJhMZYKWvHzu+71OHl?=
 =?us-ascii?Q?AdgPPxQQQ+eAgZ+MNBgIwuV4czq6eKXtWI1koMgzGfgkAmVyvvPPovVcgNsD?=
 =?us-ascii?Q?wVsJ4CKtiI0KCtDP20GuXS7ripxzPtrZOqMl0BMwbaBf/9s/+Pnb0USzYD7Y?=
 =?us-ascii?Q?srg7EJ12jHeeYBaTgYXwSMtozDQPOzu0NAd4QGX0uvP2juzvktiMB4lUcuhr?=
 =?us-ascii?Q?jNn+IkQ3PvlY9/FssWaAVo10K+yPmKhSJhtCetWIb8fHzu5BeeS1B6P9CO05?=
 =?us-ascii?Q?LV1uf7eWXPRR/jP8bwvB9um82mkpfG/Nn2bsG4BW2H2wkSBaZmR14MpiKogD?=
 =?us-ascii?Q?k6hOqo6lJLyKznX88AvQg5U90Pbjo6OfP9zwkBeIrJvG7vpMey1bN+L8SPvF?=
 =?us-ascii?Q?VqPsJb6BgDGoE60+aqmM79OJ28YRITOCqzziXQmGiKPo9wGo4MhjD1O9ofQu?=
 =?us-ascii?Q?ZqG1d41AGlXgg4LOCtibf9H9pplf68jGV/IEoGzSYkQCvmWVXjNjrTc3t8yY?=
 =?us-ascii?Q?pUB/Uft5TiRUK6Fww7Y1K36koRJtgJymn1QtNXZXIp2BVOZBKM5QqSTw+zb5?=
 =?us-ascii?Q?Op6oSuCe39jHBkyXMYvYltNkbLyffeUuJVHNxyxHx10EtDFPnIJQjleAE1ou?=
 =?us-ascii?Q?w6q6VVCW30gtm/cBdXWR2atlp9VMbMtTMeuWAfRwYHy1o597tO2Z1uRxRcRQ?=
 =?us-ascii?Q?awy2GxAmK5MXtUATvoBO7/RcXwL8F3CerxSL7seqO0KJiKVf12XpzpOqq16r?=
 =?us-ascii?Q?IU42vpy/CJbYfCUjQkrR7kUIejFzNtDHXv2W1Nw3UQ/34wUoa8MNwW3QhNrJ?=
 =?us-ascii?Q?ixMpsxj3WTyfK2JDhbapLwYv4Tu+lahqX1Z7Zguk9XQQrTika9/1rjcQ0VEo?=
 =?us-ascii?Q?A8QU6iF7Hn83lnuVZkESxmcc7O/BFtMApUhWpBer?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08705c30-20ee-4777-18ae-08dde19e803c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 17:08:23.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kwMVjIaEj0KQ7EYc/W3e3ebUB9iTMvbhdzegC+OGlStq90Bja067MqmsA6f6gti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

On 22 Aug 2025, at 4:20, Muhammad Usama Anjum wrote:

> Enable -Wunreachable-code flag to catch dead code and fix them.
>
> 1. Remove the dead code and write a comment instead:
> hmm-tests.c:2033:3: warning: code will never be executed
> [-Wunreachable-code]
>                 perror("Should not reach this\n");
>                 ^~~~~~
>
> 2. ksft_exit_fail_msg() calls exit(). Remove the dead code.
> split_huge_page_test.c:301:3: warning: code will never be executed
> [-Wunreachable-code]
>                 goto cleanup;
>                 ^~~~~~~~~~~~
>
> 3. Remove duplicate inline.
> pkey_sighandler_tests.c:44:15: warning: duplicate 'inline' declaration
> specifier [-Wduplicate-decl-specifier]
> static inline __always_inline
>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v2:
> - In split_huge_page_test.c, print error message and then go to cleanup
>   tag for cleanup instead of just exiting without cleanup
> ---
>  tools/testing/selftests/mm/Makefile                | 1 +
>  tools/testing/selftests/mm/hmm-tests.c             | 5 ++---
>  tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 +-
>  tools/testing/selftests/mm/split_huge_page_test.c  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

