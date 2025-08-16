Return-Path: <linux-kselftest+bounces-39146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025FEB28D77
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 13:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F246D173696
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2712D7D30;
	Sat, 16 Aug 2025 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jp6/nvEa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3642BEC50;
	Sat, 16 Aug 2025 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755344644; cv=fail; b=rQZ+21hJFY2e5vqwcbgRTYafoqeFZ02NTW2yKn7dAP10GFqnd3KqIjq+CVvKo1YEuc0YHEy5xrHUr9710LX8L5AxxqDe100unx37vAF9qou7+qpdmmpN8hXiaJfhSLn44tiSIp79OqdT5VznH1WsJoXc4LRzqFprH0jyZzJIS38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755344644; c=relaxed/simple;
	bh=FA92BpVl4iWIZ2kIEOkpPtBpBN+aTz+BhK0ZQPMEOWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlfYaTyr+6iCbBRT6cQX64hfbfHRZ+w+BPuKplwmbnelOVkPgNdEMPBm326trpKSGuzWuL0QFnKBcK3Gv8CT0Q0W3HcRPpTSrDqkF2BsW8BT/RzK5xepdgBlQsuTPvIwcSsgTqK2EY9uSvarbhwz3JZnJhLQB9mriq9XPSt9O/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jp6/nvEa; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfw8lNnPrU7yCZ0yanUSsEf0yp52p0OmBAkgecibcI0/OKACHG8wRhTERhf6keF5RQbZGUhfQSVacvdV0XsBhP1FQRgKuKeb6sqWwV8v/BN/lYblQm7x/YAAVgMFVlkdQP/g5jl4CIRNowANarZIqH1Ak8ORwPzgBib+KDORbQMujpZQfysUTkLJbnPOFxxMQK774yUksH8xBdKjvsFwOJJFFZ0dhz3zPaUaT7tcHIVFH1I1UJtpUxw3LAblG9E7yEz7E4ERR8zVtvuSvaNZcCN/R6qz7L72k4tIQtryn/ZuH6g7PHqXzY8Du5Oyj7Z1xXdoc2Dwq8hmq5w9kQPFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x98YlXfSRQLr/qyfQQjrsH14PcSUpA//NoxLajxkamM=;
 b=r2pS8Hr2Z41Zs/XAfSrPONkypNcepncuAuHVXPqxzO5JGLxI6n/QDrux9q+P3OcpnVdVhwb/9wtaPIrnc25OdoOcSISTi6cmUlKWOOh14U+P91aH4Cdei2/8l44q1HRPEkMKAye819RqLo58f9YSeS1/mDKUgC4oC5DMhKgtE07JlY/lOYgqRO9EnoFyZZG8vRUjEE733eSQMFmgzYqQjCpaDYcn3TDrKtEw03pjZbvtiGeJxFww4oTjMSRWD/9k54jzPSPK6nZS7CVcJk4hsTApIzeFL0eYZqwZ1rUlID+2fdtOwNq8ZjPDTo+u1qlpgdw9hpek2Yq8z3EsVmui+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x98YlXfSRQLr/qyfQQjrsH14PcSUpA//NoxLajxkamM=;
 b=Jp6/nvEaDvrLAzbwFRJOE2CDzOXkFbWZbnQcG+ST+2oqEMx//nae0Ax5kb06J7Zp+K/sJftcesshVQzj3SUTHE5OHoObT5cgGTDKfA3Fo/xd8pG1guvir3nyd19jobPwZLQtP7RxuPFBxyVLQZEjNwK8YEu3/T1fEjId231Ow8DUU2j2YPXwdgiaeUXfiJZvpWbaycUZXGAOT3hGiL9t+1+GkQDQv0hzh9J9xgLNm/cLo0Y3P592M4Zpy1zU9d8fFD4FFVQcRA1Vf8JhHa7VnIlZoshHhBQid451BBlL1B+cvjmihq3tE3HLhBQ1FtfC3HdMgMdrtR+nojihYup1Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sat, 16 Aug
 2025 11:43:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 11:43:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/5] selftests/mm: reimplement is_backed_by_thp() with
 more precise check
Date: Sat, 16 Aug 2025 07:43:54 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <C8AA817C-E687-4656-AFB0-1729CB711D66@nvidia.com>
In-Reply-To: <20250816003013.e12ecb8f2dc45e7f934ff281@linux-foundation.org>
References: <20250815023915.1394655-1-ziy@nvidia.com>
 <20250815023915.1394655-4-ziy@nvidia.com>
 <20250816003013.e12ecb8f2dc45e7f934ff281@linux-foundation.org>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:408:f5::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb924cf-c56b-4d0a-cf52-08dddcba2f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hXv5KKU4BbvI9qNI6LEGKzeS0z1W8AhRHH6lYewt3p6NAZ+LnkY6XWGADaRR?=
 =?us-ascii?Q?EfAqaCKkqq68XsCAuSUH97VyxESSBjKzpiktTlAZFD1GSYGpNyT4y36guXel?=
 =?us-ascii?Q?q6gMA3rSaI5JCJq7k+MvBDFbXPEZq0CNjBbkcxIi0g8ctHg8wwu/IZOyj/w4?=
 =?us-ascii?Q?OWbP5gPkmp5pADuS5VbwoVc1271Hlf3r921rrp/Bp0/Tg0Penz6mD2M3Dxml?=
 =?us-ascii?Q?0wJAR1Tcl+Jw8+KSSqHR+/L4MnwTGLTB59N5AHVAZAkHuHN1MOlefwTbQQTf?=
 =?us-ascii?Q?RC5d0wOz42g/gnZ1JHqEE90Nb2IMBxan1q+l7Zs+zruStVW7Kb4UUsIyMTIW?=
 =?us-ascii?Q?gl01Ct47TE6jFIyaGwlFv8GEWMnXLWH1oISU/4xfwxihPLA7LdOqi8EgVXDf?=
 =?us-ascii?Q?tiYRcqDRDHAIowZPU5f6eEYqMXafRJgukX3wqqRJf3xFOO77hlnXi/TPHSoE?=
 =?us-ascii?Q?f3nnz04At3BGOg+P7jFgMKSVLh+kXt1wxdPQhvijLL228SD8ys2GNH/2I0b3?=
 =?us-ascii?Q?t5k07/0rY58QpYApWXyaXtdeZhY6OboggqGLXG09QYDVUAzY7u16GscnWpTN?=
 =?us-ascii?Q?8Plmustiby8lvBEuivTPJEcFHJAdls2l21kRoitLLbdN/kT/k+BMzTBtu1X6?=
 =?us-ascii?Q?OgVVEZkPwptsSi2YCGdyDcLwaGe8kAn8RwINCXKa0CfWRbVdt2l3guQeRJgT?=
 =?us-ascii?Q?+OPy4B9rzMsJHh7AeVAm2tgAg3d82i5qSXCtANwdOp7z11UtQjSfm5uYLUeP?=
 =?us-ascii?Q?S4WjpKXIdJysqEKrfUHXHCqfQqy3wg7aoGBTxP5O/FTZuilDaOhoWZTVY6of?=
 =?us-ascii?Q?e/E9S1YZ+pnjiTWZSj4BRU3mxhC140tvEHVZ5WrybsNHrwweK53thzHHWkOS?=
 =?us-ascii?Q?JGDs5w048cIm+x8NcDDM2D5ra37NWNZYqORCsGMJcAx/cKF8e5MQC0qglbX/?=
 =?us-ascii?Q?Y2L9dFkIHozkzSrdkAV69FToDUOrXOpw814ipcdRoDVkgXA68EMqPHTkfCES?=
 =?us-ascii?Q?Mu4M2G4d73opawTHZr51JxJpcoIv+4UHah5zPwGyU/YJGw4pazCM0psZuuTJ?=
 =?us-ascii?Q?A9j+HM6j8MTAl6MWU+XT2QhKQIoHwR2eV5Km3r8XU+/wLwTWKBuOh6q31cr+?=
 =?us-ascii?Q?0ky0Yg5JG1idvIaHNHMUjxEVbRjqMzZuTKEKPHhzVXgIDOoNxSfHs5pqxWcM?=
 =?us-ascii?Q?6RT1tLVj0QLEPqyPgVNlQV0lixYkw8fvOX3qXyfYDvkQY3v0FkvIsUx9Tb4L?=
 =?us-ascii?Q?6dFM9+un7iSdtTD2C6y2lbe+2T2tjFJ4CNGH7OZZooxAlqsXuAJ811Jgx2ik?=
 =?us-ascii?Q?74nvHUx5Y7D6f41MLyHKZ39q2MYFY0+hQIjqHQuGOWMMdNxqF9sDeSDOuiYA?=
 =?us-ascii?Q?My1BLxXAs1/J2dFmu4Gke7cD7r9eYUKd9rp8qNdxXvQgMFCHpqD+jB5yEe1c?=
 =?us-ascii?Q?q/zNG6jZWK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HCww7jehf+3mTzIO3hpdLmldqbVqVkmm5i0PLYtYs8RFFsbkONFeJkpy4iMS?=
 =?us-ascii?Q?TIW5NJ9NnWVNHgGJ5bMDBwQKaAkXun8tZ/WY+7hH4cJKcKDEOVJ3eZhobbuG?=
 =?us-ascii?Q?2X6tazmVmeXdWkN0ZUFLcRDqAo8zuIe6GVb7KnWQuLppn3h8KtCiouIb/dMg?=
 =?us-ascii?Q?4QqB/6sIOY4O7eHuz4hgvZXAeIk86jV/QkScZ5xUMGX6wT1NBD22Z6REXAt9?=
 =?us-ascii?Q?wfxfcrcn62Vmu1Ps6wcbty/P5arAYnzh1r3mm0/x/1uDCByjaUyQrkmiU8cp?=
 =?us-ascii?Q?Fvdti75eT1RUkwgtJLuClkLLLTbQAMJbU7xvuddSWjKS/fo/bOYgjhfNfOvt?=
 =?us-ascii?Q?uWf5+GRge2IlSqvtxnwUOFUFkUJjgbC473tqPvPI8cHOkhJPh7EwqAZGrjOY?=
 =?us-ascii?Q?y/sEuhb4KpKD23fb4lrzA8MSYuXChwk4Fpwbw876o+hQdCwJMknlou4v3QdX?=
 =?us-ascii?Q?IwWoWwpBdvpCR3XQuyKH20dWxXneMA5zbgGluTCDB1CXZUKro3OY1kIgXxso?=
 =?us-ascii?Q?g+ZnY4YGyzT2M1JlPgoV/tu+Sh7iUZyoXV+OgiG27TYcbNebVoafazy/4g/g?=
 =?us-ascii?Q?GTDrrKsFP4QkscZ37uyH5ze3F5tkyzCYWqavhWf/rDZlC6RirkuFb3VcLxZH?=
 =?us-ascii?Q?kKbIZ21ADjFrN3/UN8tOhgxFZ+75xvuACAXr1WVyEz6C8OpLdCNG96KyYmpj?=
 =?us-ascii?Q?YmgIKHGMBt3s+nyv9kwVlrSpT+EcD+8+2MBUN0VXb678wNv1pZx2dMWo7dUu?=
 =?us-ascii?Q?PEubyvlfp7oYxEq+YMDnj1RXVkTRKyslkVhYrAP5WoYMdnITDsWav3G+fVGz?=
 =?us-ascii?Q?T/ywKBl1g64VwiMGqi5nYfL0xo3p2Kaemt9CfT8pjPGZ8JnWkNa3s1QX8mCi?=
 =?us-ascii?Q?+/TLk4TnQWClz6ZD15iQxxMtAViM4/2SKxX3khnmPmMebZdNs4bDypsPWbji?=
 =?us-ascii?Q?OFyZlolfm4XVXdH/jg5emvuw56+qVHrT9Nb04xu9iO7je0UImRP14q2N6HHu?=
 =?us-ascii?Q?MEeweo34VCUH60dhbZmqMX+18xFz/Yp+eRwqKftwNaD8FhnnxQ1IkOCGKI2y?=
 =?us-ascii?Q?l90DN2bR+vGd5t3rou2X7vghypwtm/sw5So8eDrdHrG5XnVuGfC39EhLRtJJ?=
 =?us-ascii?Q?1YsEwRIeBnjV31sKvSKCKmbK1RVd5EiUT46joVhJPAaQHTn+ryQTIv1WXpMG?=
 =?us-ascii?Q?GGXnKrCgkvdtHCyhBBMs7PHgRz6uKiUCIUsDWSdFfkhKCYE6giCfK2nVCqjD?=
 =?us-ascii?Q?mBy3/1itQ3GrRFYRY3HFZNaaSoHXAc/EoZfwTkO2Yj3DQ7Wzij2BHeFvK6j3?=
 =?us-ascii?Q?ABaLyfQbIe6MgZTirBJYBd2QdDKr+gzCAk3S5Lc2fO1amH26PP8y3CGtJdbY?=
 =?us-ascii?Q?CyvRf0VjVo7guuH0b/wIBDiFqdGhKZfiGVur+PNKwafdKcC01EIfzGhZ63ny?=
 =?us-ascii?Q?0E+QjUQJwnm8iA8BQXr/B3XKu/tLQn+0qCj7+/9wqE+sau0VJnOAgZyo//9c?=
 =?us-ascii?Q?PD7b+d1WyMrrPmvYK0jCnmA9UQ3qah2wD9HHuKvaNy5lh8DnOJaMCVfauJPI?=
 =?us-ascii?Q?F6Tus5IXKpA2g1zmkKXdVQfLPLur+yIz1pty5XzG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb924cf-c56b-4d0a-cf52-08dddcba2f9f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 11:43:57.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCSDlE3NA+spXPoQT4/43CzcTZJCD+z9kkjh0legt6IyN0yypupqiplCH9uYALJX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

On 16 Aug 2025, at 3:30, Andrew Morton wrote:

> I hit a large reject.  Can you please redo against next mm-new?

Sure.

--
Best Regards,
Yan, Zi

