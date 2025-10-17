Return-Path: <linux-kselftest+bounces-43398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD908BEAD73
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6D705A6291
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1752BEC3F;
	Fri, 17 Oct 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q/rP581s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5B186284;
	Fri, 17 Oct 2025 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719064; cv=fail; b=Nr9tuhiPUzgGx4iPaP1NfyT0FXfcBLeF+snvI60B4n67KVnZDqTZGRSP+dVQVSnrPKvOE6lUbh1AXtUR8q/EWXuGJTViHl27m37dl5XwSDP/dRwKgSWFKp0CCKFrKc03Uv5uar28l0elpYeJkl0Wv22mePz9y9cjyxIGgPawFBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719064; c=relaxed/simple;
	bh=gqkiUVlqLKf8GpmAuS23c9PjFFXRgdXPa1BFuTRnPPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C9Yx/uvucqyYVHy0yggb2n+DkLowsOaULzw/WJRlTQRwmRvYcVRjCgG8CiPrq+Deuxg34BPbuSy8abhM4rj05lkZNic/nuqkmc6rJMWeYQEV0ggm3dFwfKCsD+oZN2MNByeLKdD7Jx+v//36FXFIKI2S7jFgzKEVJPxj+CvvMQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q/rP581s; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtH2CQDDeDy4CKLxJOOyXCefkUEVXU6NJQeL4zRB7QyF8M0NZASnLbQxk9G/imNjDSAhFI94ACVE23mXRkD1iY9x3MlZnwmCGTvljhGNw6wgCGXOeplmR0J+hT5zPMtUfvwHu5fKatS6A6w1J8X1/EN+o9nqqeaZs9pWAOHee64mV5RVuJyITHyqhIB+G5eRQ8/QFSCqJVu8jX5I3FMflXjEgMyYZZ6klUdWN5dcLy9x0B9nArXY1Afs3BsaRZLhGLNkBo1EIqSWzmtOVjfhF0MeNedQQsxlOM3RheSlXVsO5NSEsRvS9GgwKDhsQ0Bs6ys/LX9qZ+8Klk/b60HJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqkiUVlqLKf8GpmAuS23c9PjFFXRgdXPa1BFuTRnPPM=;
 b=iwYQ6EMHPFSgb2/Z+ga6v4DfPDzU1trIAgBGJd0FDRzXj+AiwoT2jlQzu8x68l4pOCe3ER/8tr1nqapa/RY8e0RQ2B20EsoCGeOqdLxwmHpshfOE6dGkPwaKmxi3MfTpIKTkK+uh8kOeW3ks+Fnjf7LETIpZvtBDFvIUmDv6zutwOt/JYD8V2p8vQylc1YyqMtHr33Gt6FQ//0XCUrLFfKDuCp1u46MnAF+2xYogcNywP1u4QDZABueyC391lD3YzcOmOqozDainFmiD/3ZX3zgIkV7CkReX3fiIObioVOOj92kke75xwSGnAsNmiYxXeHFxJ3N9eXXzVufkQB3f2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqkiUVlqLKf8GpmAuS23c9PjFFXRgdXPa1BFuTRnPPM=;
 b=q/rP581sVqU32B97jUzwGIANjhyuJvIqo8fenwd+p+6RA21bjNkCj9Ykm1GI80sG96/YUXddaV2m8eXelLsvMZuZvDu8oLTP/m2Wk+/LJBChB6FFyXJSexdDfq+DyyHWPaIRRR0Itg+4TMFo4dXjXHbkVej3faj9WjRNmO9rUXq63zfqaZcN6b39nTmekId0mQ4UlTV0aHJyK5rPPSsh/itX7QT+FvfbyG4Vpt7V0hpPaUWG6PgbnuYugsHR4fDHAW1UNw6XE4vrtJ+JVMxucwFaUxUSeJy9HOWCqEcMcuQC0X2aRhXvIn9OpCDOoqmCkGPvZiW2crG/LYMHQSxGLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 16:37:40 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 16:37:40 +0000
Date: Fri, 17 Oct 2025 13:37:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251017163738.GB316284@nvidia.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <009c8e5e-02d3-4017-bb84-e3a8f01b9dc9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009c8e5e-02d3-4017-bb84-e3a8f01b9dc9@kernel.org>
X-ClientProxiedBy: BN9PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:408:f9::18) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 13956187-9d87-478a-bec3-08de0d9b7cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TilOynJSNoApovBdzoqE2M78eAhu5wcBjzksr33G5EVNBoSvQQY55aSsOhwO?=
 =?us-ascii?Q?aFCYJbIgplGa0ZdgeAspqtCsk0jpFzTN5eCF96lN4UtEazIgDVyGGhm0toa2?=
 =?us-ascii?Q?3m4gE+RVHqH9LZo6BPhhWfKOgz+gIRT0guAG66K5gWUd7DJEEQfzkNJ3crsH?=
 =?us-ascii?Q?/ig0OpPLGjtlzu9dL6Nt3Rgzjilts4Wu7z97ZsN8VnAY4fyzWw/JNuel9PE3?=
 =?us-ascii?Q?KNd8Fhl7LKY5Fltbb7yQ7w/BAakPeaCYHeisO5rTQdk9+CRKlfeo47Y4QCxr?=
 =?us-ascii?Q?bFYXTjPXMxcIg7C1p40zZVI1y/u/H3VT4xJVEMU3Kaypk/8onjFnRQIlCzy5?=
 =?us-ascii?Q?BxXCYoKe+4TPJjEluXLC3TcNqkKDYLJku0JFPaw1tqq/ioX+AwC4mkw6B7gB?=
 =?us-ascii?Q?C+PAl5qd8VqgWYJK+w+jyKViQ0WLmxLWKlf/uKx0Jc58ZEYjtUDZeVYR8mVn?=
 =?us-ascii?Q?gZDGYcihBYtPaSsOA+mjVPDKwjsuH93S8F/8TZJ1DbotUBVUboh9ItVrax1F?=
 =?us-ascii?Q?RG+5HZ5gzyBqIXu2y9clYkzXOlu14TL/p+3BOvcuDfEPg+bxi4fuytVSPRnZ?=
 =?us-ascii?Q?rVfT1e+xnBxAMPLOO1dKA/wRfVsKB8MDOuooukNmz6cNQyqYbcIxmkbrGJDK?=
 =?us-ascii?Q?8/i0RAmEoPL0PJqFKBy7P2FTXEkbd8VMCRvx4OJOx1ejE65yaND6Q8mYupSM?=
 =?us-ascii?Q?RGXMxeRaT+gpFmWrxe16sw5jLLhCxR2ZB5kyXDvcgI+M3BlLU/YqvPWZhCrs?=
 =?us-ascii?Q?cOuRRqOW2S7zhbi9+0jbgjGvnuYwbaOBx692C72cX9bEtCNxSkPooyfJ+nop?=
 =?us-ascii?Q?d34Yb00qUX2WPPepvsfrOedMV/2TJkD+OFcGKX44Rw26SeLwsfedLPEhjwNk?=
 =?us-ascii?Q?d9jL7zmZsEeudeWjXmLlE6GBGJn9k5o3XIqjUcpwbsK0yiVs4VshjsF0JC3n?=
 =?us-ascii?Q?el+6P6w67ZjsShq/kMqucZjWXX4RmnhGnjgJ7FpHa+cERsLKo0WHj53NwSQc?=
 =?us-ascii?Q?qVr8R5txO8FQcXqEuBcmdOlfA8lfoloPOS9eqGNYeJJACuwqlY4rEUZs0i5E?=
 =?us-ascii?Q?kNnTyvbOJBCO60j7wUBRMCDmfLLcLJk+C98UCoXd0e+hR/P9zp82+AWMwY+q?=
 =?us-ascii?Q?Ri9Zy92QAhgCB9uqASsmy5SDarOfBdkmo7A14shS78CfCEPEfBErIkkKEXXs?=
 =?us-ascii?Q?UtndR+y0uFn97YyjH4HMiCbkRWUBRuqwdyG1KtY1lrReYTBx2jNlJAACZKKF?=
 =?us-ascii?Q?UBzxWvY10PMz4jM91MvVflV45p+vvul9DK8TQCjMAjka5o+BymGK6EMHceKE?=
 =?us-ascii?Q?PqoFAIOK6IPC3hPY/iY/A+uqdqY7gZh3Tt+LKUBgayTPnD0h79uK8m1flXpc?=
 =?us-ascii?Q?ulO5FviZ9hd084I2K2B0zfbl896s1n1Q8FDmhl6uJ/Z4QMHVccpQ7go1UKk+?=
 =?us-ascii?Q?VNOIqBba7g4V7VVse0pVAWxYshWg1IMV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fGLs+ERyk9dAi3bn4AmDsWNLqN/dXF93HCipZA8moeC9m/mtVEAAil6yoIRM?=
 =?us-ascii?Q?8125MqVJM66Vz/GyHSijiSVnYVnvCa/7XobhoQKo+n5+GcFv9Gjo0RRmJcL3?=
 =?us-ascii?Q?2qMu4hyTiUG+pHLsl5xw4NBBf6JbJX8xLWfvuWSKFizeBvgIZ8VNmQzxtVmD?=
 =?us-ascii?Q?bqJnSgFXyKzmCOq9/mK8RWU9yfF3EuRecP4v4+8yvSUAGm7D2XqDnkb3OVHf?=
 =?us-ascii?Q?rKy3do3XKc4Q9QaR8oMBhuPTXLTuG+1yjHXcgdZjSA83/RUMxPkDq74wr/TO?=
 =?us-ascii?Q?y+nGsIYnpSl0MP9whKsnz0fVMEJiWkMP7f/b5r2cg2P6Rf/wLPjITusIdf9D?=
 =?us-ascii?Q?im7dUlotE6mxi4uB/Yxc0JKBbICVb1CtAd3KjPRJPUz9hVBk6Ms4fVQqnu5K?=
 =?us-ascii?Q?+O1JvRod+aCZhCm9NZ2SgcnG2d/jQBh2yH9PbPgs+ngIIrNOutUJ7d8Ie6W/?=
 =?us-ascii?Q?HTmIL9Qnyx0jkeytiEoqCPmc5jNGXlsQQ0/DPraJlBT4jhUGKGbSOwqVBdYo?=
 =?us-ascii?Q?PW2/q+F95Z5u2xHbmY2D2/8nfjMLz+Y8UrmU+plOSf48KUTlV1C2FhVPwMTJ?=
 =?us-ascii?Q?U2CnBW1g3r/Dmp00PzXV2x6CDnL93G0DTRKdLEKZngQCNI/RhpId4XVJLkHE?=
 =?us-ascii?Q?dXgrIV29UByTB+R9qKN74cKMfkGpDnX5qVzaH/u3qzt/8fQp1uYpoqwJKGv5?=
 =?us-ascii?Q?dxgVcnZRHssbu2gLh1n0e5ZZ30uxxJ4M1CLa8Lz3uKbrtP30ZE8BktTloEC7?=
 =?us-ascii?Q?q9sfKox1qrqKza941yWm0yC6GeLIEnm0knXvEXCzzvG09ZTQrUBfbdWK4LMh?=
 =?us-ascii?Q?mAGbTKRc3RcSeskhdzXvVBkN3/0/9wjUduknCNSr6JJP06fnprzfEYS+yaj8?=
 =?us-ascii?Q?Ef3r6H5zs2KkzSrs+z/nvVeeuIZ93oV9A+hKmNVe2rm3MvGdwZsIgGjx7IZ2?=
 =?us-ascii?Q?QQrZvzdc8sRjZTEs6cxPUNJ3HaEJGgCvD2sHKupWERicCnd9nXNaXvn7EQlb?=
 =?us-ascii?Q?zi27NyFwiatyopVyHrXFrbjQaRZh/cPJQyI+KsnPkQEcBT4gSiQMZZ+Sk8sz?=
 =?us-ascii?Q?R/Q8XBf0Fx08AodjpWXEPGYnuozZKkDBHQesv4/rz+N2lC6pWJFM68yyIHpy?=
 =?us-ascii?Q?p0VZHeWpzxjzjNL0ZdcVnlCf9eGN9G6AOpRWq9ocIMIlStM2KRytmowFk/W6?=
 =?us-ascii?Q?ctuBtpGTvJjA+kIk/EQK8uRTUKlKARTjndg70/uZipZ7EDbZlV+PSKcc4ktZ?=
 =?us-ascii?Q?eAa4mFZd4iPmpWY1If7US2O8m420tGFxLeI7QP716y6VDax0HwiTf++W8qU0?=
 =?us-ascii?Q?mRiASgsRY4xh5NHNuq3jRKbi9Nq577dYG2rm+5lZzQqlviSWpOHExRwmZAPm?=
 =?us-ascii?Q?1VYrC9vwOolmDzVA5cB+kZ7u9f7iksmBLAPE+WtHwg/nhuRBXnDCwipImGlQ?=
 =?us-ascii?Q?YliO7/RdMbCkAGjQRO875J0pqCo+IRdw4IBv6P6rfYrRF4OGiYUUG3Y4MAxM?=
 =?us-ascii?Q?FXKuDkSyRF5U0DDpD/JSPCZ2YoLwAe1cH2WptPf1p0YJi5RtbLAoId6R5GBH?=
 =?us-ascii?Q?WQmuoK3tp42Eb8K2BY8/aPkbTN8LQUDw14mwehWd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13956187-9d87-478a-bec3-08de0d9b7cde
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:37:40.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5eJ9nsj62cVPI3Tj5G6w20hHVaxrvtvL65LO544M8lnli8E5hW/08XTMtUEVIe6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762

On Fri, Oct 17, 2025 at 06:29:10PM +0200, Danilo Krummrich wrote:

> I'm not sure about MISC device though. Unless there's a good reason,
> I think MISC device should be "fenced" instead.

misc is a very small wrapper around raw fops, and raw fops are
optimized for performance. Adding locking that many important things
like normal files don't need to all fops would not be agreed.

The sketch in this series where we have a core helper to provide a
shim fops that adds on the lock is smart and I think could be an
agreeable way to make a synchronous misc and cdev unregister for
everyone to trivially use.

Jason

