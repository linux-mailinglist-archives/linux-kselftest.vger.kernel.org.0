Return-Path: <linux-kselftest+bounces-37861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D4DB0E79B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B856F564F86
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBF5680;
	Wed, 23 Jul 2025 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uATPlouB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E89360;
	Wed, 23 Jul 2025 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230649; cv=fail; b=kUQh0W9VAAtGPF+tbcm80zYnXAnoQ84cX9nF541CeqsG9BLMi7XXClbz2IVV6Q9tfV6YBSQIgvWzmX8NzLD1/G0in+chSJMTUFeTkY7v8kK37tKhJfLEzDOKhfhbfXtcv9w8Q9ntFRg5aEl0/eL+0tZKi9oxqu58mIw89OmbJ+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230649; c=relaxed/simple;
	bh=M2mafxd0wILlzOOWHMZB9hSZwKlnFY3v8FdF2LLw9uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ekY+QRUrT9B2rhC0pEQlBM0Ds9a/jVhxjs4VKBvl2In8F87+jIjDsIMpdacs8SyN89h+w+IKqFhbdAihol6RjuZVSkkumA/XloCkRF04dxun/IJFoWwQYy/iQjRe7N6KZj5pYMZO6YbXDMk1kd11RTv3ap4q0rD9klaKHNtzugI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uATPlouB; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKimfDkFjPPPQEBbtA+on9Jkttv1fmxiAJo5O8m6YfQsOwHaDNZEOJ8Ju5NKIoN3A6XGB1fgzDH2LK9rGEV093GHzAfXHjmydRy4nxTzuocfBTMzwjBhhF61cHiM0zYbIJsq+gX8qx/8lH0B/6DQFI9P1hIiCjTP5xSbcU9eUh/uUdPTNVTouG5jdZVzzzyEGk9tBscfX7YiTKcTdY8mOk1nWVWHBrRv0XjVsOvbkydOV6STC8/ll/uh5UO5Uvt1DDZtvM3Tyi5aGwbiRan2q+G5mpvr0p08NbiwL3AiqTS38CawaVJFFf4JXzN8jjDroN/Hk/OLYY1bAUOn/4bOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOIggSqQpp3hkNHaPqEmscY1V2tnkTCHPBOCf0O1sr8=;
 b=WrFay5SW+37tHIXh9TJFRAIHXGPgemLugGmUFRtG0GdJs8vtSXWv55qlRXpGbGhaPw/9w83sORWLxCPa7dpl82N2Ii7Q0FKJ130OquKLP5JtOTPgLlgE6/IcM9Y9/FyJszAQvoc38sDFLHZDePS1gCi1T6rTIWECGzSW7x/G575bjEatkpd84ma402LGyGkVi+G0Y+t9hP8ijmBrh5NVr2LARmbSEPUt4+UdeAOT6yTNjnqcRY/y3y2ypOdc8PDoi5uiC2azc1Boyg5wxe1ZhMDn+PVT3PvK+u2A3DW+y5CYWeo7XnazWUvDaia80t4SgMGoQsYiBHgkL9GfpF1zxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOIggSqQpp3hkNHaPqEmscY1V2tnkTCHPBOCf0O1sr8=;
 b=uATPlouBmZEHj8ziGxjfBQeNf9yqqmCcGqAroatDwf72DqDklgdwpBgJERiZMO2XU3gpAV87s64XAdGi9xrKDlQPZ730Bj/TpNyXZpjEorkefG46a5vf0ZH7MvFFZyMQ6UN+4afFIYHNJfvCvpAcZBfcIA1hqXOgzU8j8S3hff2Prgr1OxoM26O+Ugs/EGEJOSJMGtyZ/NxcFiHg9Q7IZ7yAeDIHtbpE1Q71vAALu1npU6HNFjr3yhMMqP+wmtn/eEi/urT4hT24zEK962kc96QNQ9z1Nkgq97mcoKK6ijNszOK56NFqVIevplAK/2H+PLohfrJCA4iXmAIvRU2egA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PPF170E97DF1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Wed, 23 Jul
 2025 00:30:43 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Wed, 23 Jul 2025
 00:30:43 +0000
From: Zi Yan <ziy@nvidia.com>
To: wang lian <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, broonie@kernel.org, david@redhat.com,
 sj@kernel.org, lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org,
 brauner@kernel.org, jannh@google.com, Liam.Howlett@oracle.com,
 shuah@kernel.org, vbabka@suse.cz, gkwang@linx-info.com, p1ucky0923@gmail.com,
 ryncsn@gmail.com, zijing.zhang@proton.me, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v6] selftests/mm: add process_madvise() tests
Date: Tue, 22 Jul 2025 20:30:39 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <1C468AC6-C55B-41A3-9335-65B03EF65B83@nvidia.com>
In-Reply-To: <20250721114614.40996-1-lianux.mm@gmail.com>
References: <20250721114614.40996-1-lianux.mm@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0a8e65-070f-4d9c-51a6-08ddc98028cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MqFLwy4HYV5aJxHYCDJ9hIAcs3TgAR0sMMdZgzIktLd04nENZutsPowjnFyv?=
 =?us-ascii?Q?yMZb3XqtRfHfaaxhatOIYPQ6IJs2OxJGKqT542dlHRbMVdb+oznEcp19kIou?=
 =?us-ascii?Q?wN5+quziMWSbv8E5SD67yy2/X6oAGX0l70X+AR0I4JN0gDd6dFNk/628KBkO?=
 =?us-ascii?Q?bZKGTG3BScvA19hD2b+Ej3RXshJaoIyYcx1gYTgaffMwUVWq63b7oVthog+T?=
 =?us-ascii?Q?aBzP1FuoYi6qNTKUSelX47mVVJ290Ux/ZNaImxhRlwPkk5iplJBSiWdyop0w?=
 =?us-ascii?Q?cCEJRYkqJptONz4qziWBDp4A1ZVrQChVYDAJ3R7SnIxAYWSBAxVpcxXpYHQn?=
 =?us-ascii?Q?FDvpxGBkkCTXduQoxdd4cGb+ZdhBn1ZNjUHxMZLGVfnNyzI/wh4WEqMLIc/N?=
 =?us-ascii?Q?SWwZ6+Gr65ejx6mpLmvwdGDEUWqpCILfeVs9bCMWds33JXzIcfGwWm9CNRZ/?=
 =?us-ascii?Q?d100LK8HXwUtB5iHKXDHqisilJwibUvQmQMP3L2R9HI59OSd+sc9uWJbHuVR?=
 =?us-ascii?Q?mKt2EO8I59LsnTvqJa9KmUxtEUCQNfXrablx51j8Wb794s/LIuaqHcW1lYYa?=
 =?us-ascii?Q?mOTEIWP6fMbADEY03vJUipNh7QvUuhnPRFTeQliVPGrVy50i1PsAkhL2No/O?=
 =?us-ascii?Q?u03v6q2f9XuTFn9SpXRjooCqHoJcN9VB1hItWtBwcJO4xm2ga2NbaupYK1sQ?=
 =?us-ascii?Q?QdTdedoC8poKoufAFtueClJ4ZmWrs2/IXT4U4+PCVdc2K+6dXEg3gEVGaSeK?=
 =?us-ascii?Q?uFkBJl1tDgWExEMVYZkbTzXAOwfHUw8wJjZG72LCN/1VVR2jzpgJBipf1qq+?=
 =?us-ascii?Q?xPGCJRqsnGHiydjhO6JUQHpflXXQ2kGJjpAbWRjFoRXUYMQ73sEWXOEGmfDk?=
 =?us-ascii?Q?HDswU/lOhVc9KKKgmIi3SaffwKRo4lvBXYh47eV7/6OsOn6BLLpr/wlrWRzY?=
 =?us-ascii?Q?6CaARZCUFXWerwBqWL1GMLYSJ4EIKLcKDy5yPUYWCesInG+MOnjqgKG7lM9I?=
 =?us-ascii?Q?VfniHgY6qIBSk/L7RMfJ4PhMWK8ho7ZZy60/YcEGoz9pfQ4EhAXvKMAXJUgI?=
 =?us-ascii?Q?prqrkkK6/VCzPeUgkzQdIyC1iC7Gbxmjk04NTHGrXQxAJBldv86XAnhfK3Fk?=
 =?us-ascii?Q?WidwyGVoCOVBNe+AI93ZWqUJQ4DVr0lkvvaY93RqsTv5xhGkpS2dAcGJvJ0s?=
 =?us-ascii?Q?JCwQwUS+VOOBi9UuHuhZY2a9bamidduGH1NsN8kEO6cE8xvDXpLxrWkVSEuK?=
 =?us-ascii?Q?s41iBYYqIyO0rGMI9nLhHAi+2PlsHMk5g+CiOwtF+NtfpVBJh661ZIej1Fz6?=
 =?us-ascii?Q?ijQwFynrHaGpMRneOfit/yT5IjTnsD+TeQFeL1GanCgHKtkkhB7IFfjRYwNz?=
 =?us-ascii?Q?81bPt4rYpWjZvU3+z5LCrNyBQpOTzHgxOPhjUzdXRfpRQUpH5Uh91DzS0smp?=
 =?us-ascii?Q?TFdR5x1/JH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ibWGaCk1Ip1kf8gzlUX5YcaixHzYkgsfegd3hq7216IY66W+ybXvaBMKldQl?=
 =?us-ascii?Q?qSmy/I1JS2Pbwt0SD4Hy/qBcoq+JkBSE7gNQiATWrpWTPb2pvF7R3043QptT?=
 =?us-ascii?Q?qf/FYYqFhGsaKcJbTdkYFJkvBMqLYglEzxuE0atsbuGM/3u8BwF+PAIU7pJO?=
 =?us-ascii?Q?7eyk9S4zCrr3AdG1FFXHvWD+GGtItf9neIbFTnT44cHZPydrm2+Kvo6MFFr1?=
 =?us-ascii?Q?EQMDwK91nKtV9G4RgMdszHmmwEuhaUZ8ZuD0lStyliefNxLO9MyFwg/Gi3LQ?=
 =?us-ascii?Q?T1lpFm8BBVi8KPwqTUcyhaViZ/RQah6BUbF7aQrgUDIElUOWFQxIP5GWeJlh?=
 =?us-ascii?Q?FNndwKWGhNN7NErSfjM4VpwcNfPFJw+I520Me1Dxyjq3wq3B0luRBwj8rnTq?=
 =?us-ascii?Q?3qJceBaI5MmOE+HnTsumnAv/7J5D/XUEeBus0AQjYZTWWpCaTw1emxdL2vFs?=
 =?us-ascii?Q?XB58Bcz7CqEjAIjz2yD14l9z5xiqFWJuslLImt86rCU1mEBZL3+PjA55pl4e?=
 =?us-ascii?Q?+Qvv5SQYKk4+u9ir4+hS+kHxEVnK6HIpOvlYNO8e33aqiWnRc/+meBwM6NxX?=
 =?us-ascii?Q?hq0pLSTiyCVPg7Fe2MEs92eKy1T3IbEMCMwtYN9qDUBuhR3j7h0+rT1CHYYI?=
 =?us-ascii?Q?K7m/sB1H7kRBiuQBbM/hEXrehJPMjSd906WzhSxb1oMwvLJzyzDO3y3WS9kB?=
 =?us-ascii?Q?Eh/e4TNQCFEe/bXpkryjUVRlXLK/vkzxpETguai5dXE5kDP9LfEUyX7fkEAA?=
 =?us-ascii?Q?nLPVh/tGn44GwJ1doyA/sW/kpZx/ALw+VB2dGFNeEgJerBpYGvgxPSwbpVGJ?=
 =?us-ascii?Q?9HEQ0JZ7lbX9CBEF42j5sBbbOP0jDJCarIygIuKJr2QrjlR3BtaSkJkQNeJO?=
 =?us-ascii?Q?DjQFrBVDjcj8Q+V1a6VNYffQokpgNSyBQEotLrcMz+WyXR6oAC6HYiSpHNsH?=
 =?us-ascii?Q?fo/iRt7yz9Jz5bwAKwHdC/EoWNvPljsgpeqKyW+laAgk9nCHWhspeJgsXJlt?=
 =?us-ascii?Q?bdvG7DBu8WQt+QmfkdsXHbaMeKDk1047SSmF2umhb9y4sGsAYMtwzCXrGZxQ?=
 =?us-ascii?Q?4oY36EeJ9vSSnHHeYZmpp4rPOV+jXIJKV4cXaIMJglHK1J+1GasDgqfCXGhV?=
 =?us-ascii?Q?VnnfO/0dausKmC6gtDAfv9SRFSMQJhP47sH28BDEgndYFPskFqbgOf5tWEZ+?=
 =?us-ascii?Q?AkCTvx6ys4V1+HY4NvM1WJy+aUb2HXpxQ29xpXjaHQm0VT4ifzD1+uf08HnY?=
 =?us-ascii?Q?evHXxpR25FDhKUeyOE/cvzVeB63TbKSFoSnMbADq4HHdSTKtGgISkX8XdjEk?=
 =?us-ascii?Q?ndsP2TdZKjjZlAHi8fKaaXDPftlCZsDW3/fVBPf+IPC5Eug/hp95UIJBioMW?=
 =?us-ascii?Q?tQkGAhMwHHR/DObWNsVVxOoasmwpI770EmLeIFm30GChWvCGbXdpNYs5nrSO?=
 =?us-ascii?Q?J6YXMlBnAcjkkRTkunOh8vRrLJOPc/rXPIqSABYRUqNwnN67sYMSLjs5lnpV?=
 =?us-ascii?Q?rNWMwwYGOnqs3Lmj5frxeADljTmKc5uq1OXpRPzg8OihoGvyDh8ulSQVOjZ4?=
 =?us-ascii?Q?cOTIi6ZFe5d+47Z77KVrAk4Dh9kccyVTgewszwew?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0a8e65-070f-4d9c-51a6-08ddc98028cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 00:30:43.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2mczLwuzoOqm09lznRJud0MblEC7mm7EWWy552HhtbsxhjLvcRZGloKCW92f9Zl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1

On 21 Jul 2025, at 7:46, wang lian wrote:

> Add tests for process_madvise(), focusing on verifying behavior under
> various conditions including valid usage and error cases.
>
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Acked-by: SeongJae Park <sj@kernel.org>
>
> ---
> Changelog v6:
> - Refactor child process and pidfd management to use the kselftest
>   fixture's setup and teardown mechanism. This ensures that child
>   processes are reliably terminated and file descriptors are closed, ev=
en
>   when a test is aborted by an ASSERT or SKIP macro. This resolves the
>   issue where a failed assertion could lead to a leaked child process.
>
> Changelog v5: https://lore.kernel.org/lkml/20250714122533.3135-1-lianux=
=2Emm@gmail.com/
> - Refactor the remote_collapse test to concentrate on its primary goal
>   confirming the successful remote invocation of process_madvise() on a=
 child process.
> - Split the validation logic for invalid pidfds out of the remote test =
and into two new
>   (`exited_process_pidfd` and `bad_pidfd`).
> - Based mm-new branch, can ensure clean application
>
>
> Changelog v4: https://lore.kernel.org/lkml/20250710112249.58722-1-lianu=
x.mm@gmail.com/
> - Refine resource cleanup logic in test teardown to be more robust.
> - Improve remote_collapse test to correctly handle different THP
>   (Transparent Huge Page) policies ('always', 'madvise', 'never'),
>   including handling race conditions with khugepaged.
> - Resolve build errors
>
> Changelog v3: https://lore.kernel.org/lkml/20250703044326.65061-1-lianu=
x.mm@gmail.com/
> - Rebased onto the latest mm-stable branch to ensure clean application.=

> - Refactor common signal handling logic into vm_util to reduce code dup=
lication.
> - Improve test robustness and diagnostics based on community feedback.
> - Address minor code style and script corrections.
>
> Changelog v2: https://lore.kernel.org/lkml/20250630140957.4000-1-lianux=
=2Emm@gmail.com/
> - Drop MADV_DONTNEED tests based on feedback.
> - Focus solely on process_madvise() syscall.
> - Improve error handling and structure.
> - Add future-proof flag test.
> - Style and comment cleanups.
>
> -V1: https://lore.kernel.org/lkml/20250621133003.4733-1-lianux.mm@gmail=
=2Ecom/
>  tools/testing/selftests/mm/.gitignore     |   1 +
>  tools/testing/selftests/mm/Makefile       |   1 +
>  tools/testing/selftests/mm/process_madv.c | 302 ++++++++++++++++++++++=

>  tools/testing/selftests/mm/run_vmtests.sh |   5 +
>  4 files changed, 309 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/process_madv.c
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/self=
tests/mm/.gitignore
> index f2dafa0b700b..e7b23a8a05fe
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -21,6 +21,7 @@ on-fault-limit
>  transhuge-stress
>  pagemap_ioctl
>  pfnmap
> +process_madv
>  *.tmp*
>  protection_keys
>  protection_keys_32
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> index ae6f994d3add..d13b3cef2a2b 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -85,6 +85,7 @@ TEST_GEN_FILES +=3D mseal_test
>  TEST_GEN_FILES +=3D on-fault-limit
>  TEST_GEN_FILES +=3D pagemap_ioctl
>  TEST_GEN_FILES +=3D pfnmap
> +TEST_GEN_FILES +=3D process_madv
>  TEST_GEN_FILES +=3D thuge-gen
>  TEST_GEN_FILES +=3D transhuge-stress
>  TEST_GEN_FILES +=3D uffd-stress
> diff --git a/tools/testing/selftests/mm/process_madv.c b/tools/testing/=
selftests/mm/process_madv.c
> new file mode 100644
> index 000000000000..8a83eac3bfab
> --- /dev/null
> +++ b/tools/testing/selftests/mm/process_madv.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <errno.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/mman.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include "vm_util.h"
> +
> +#include "../pidfd/pidfd.h"
> +
> +FIXTURE(process_madvise)
> +{
> +	unsigned long page_size;
> +	pid_t child_pid;
> +	int remote_pidfd;
> +	int pidfd;
> +};
> +
> +FIXTURE_SETUP(process_madvise)
> +{
> +	self->page_size =3D (unsigned long)sysconf(_SC_PAGESIZE);
> +	self->pidfd =3D PIDFD_SELF;
> +	self->remote_pidfd =3D -1;
> +	self->child_pid =3D -1;
> +};
> +
> +FIXTURE_TEARDOWN_PARENT(process_madvise)
> +{
> +	/* This teardown is guaranteed to run, even if tests SKIP or ASSERT *=
/
> +	if (self->child_pid > 0) {
> +		kill(self->child_pid, SIGKILL);
> +		waitpid(self->child_pid, NULL, 0);
> +	}
> +
> +	if (self->remote_pidfd >=3D 0)
> +		close(self->remote_pidfd);
> +}
> +
> +static ssize_t sys_process_madvise(int pidfd, const struct iovec *iove=
c,
> +				   size_t vlen, int advice, unsigned int flags)
> +{
> +	return syscall(__NR_process_madvise, pidfd, iovec, vlen, advice, flag=
s);
> +}
> +
> +/*
> + * This test uses PIDFD_SELF to target the current process. The main
> + * goal is to verify the basic behavior of process_madvise() with
> + * a vector of non-contiguous memory ranges, not its cross-process
> + * capabilities.
> + */
> +TEST_F(process_madvise, basic)
> +{
> +	const unsigned long pagesize =3D self->page_size;
> +	const int madvise_pages =3D 4;
> +	struct iovec vec[madvise_pages];
> +	int pidfd =3D self->pidfd;
> +	ssize_t ret;
> +	char *map;
> +
> +	/*
> +	 * Create a single large mapping. We will pick pages from this
> +	 * mapping to advise on. This ensures we test non-contiguous iovecs.
> +	 */
> +	map =3D mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (map =3D=3D MAP_FAILED)
> +		SKIP(return, "mmap failed, not enough memory.\n");
> +
> +	/* Fill the entire region with a known pattern. */
> +	memset(map, 'A', pagesize * 10);
> +
> +	/*
> +	 * Setup the iovec to point to 4 non-contiguous pages
> +	 * within the mapping.
> +	 */
> +	vec[0].iov_base =3D &map[0 * pagesize];
> +	vec[0].iov_len =3D pagesize;
> +	vec[1].iov_base =3D &map[3 * pagesize];
> +	vec[1].iov_len =3D pagesize;
> +	vec[2].iov_base =3D &map[5 * pagesize];
> +	vec[2].iov_len =3D pagesize;
> +	vec[3].iov_base =3D &map[8 * pagesize];
> +	vec[3].iov_len =3D pagesize;
> +
> +	ret =3D sys_process_madvise(pidfd, vec, madvise_pages, MADV_DONTNEED,=
 0);
> +	if (ret =3D=3D -1 && errno =3D=3D EPERM)
> +		SKIP(return,
> +			   "process_madvise() unsupported or permission denied, try running=
 as root.\n");
> +	else if (errno =3D=3D EINVAL)
> +		SKIP(return,
> +			   "process_madvise() unsupported or parameter invalid, please chec=
k arguments.\n");
> +
> +	/* The call should succeed and report the total bytes processed. */
> +	ASSERT_EQ(ret, madvise_pages * pagesize);
> +
> +	/* Check that advised pages are now zero. */
> +	for (int i =3D 0; i < madvise_pages; i++) {
> +		char *advised_page =3D (char *)vec[i].iov_base;
> +
> +		/* Content must be 0, not 'A'. */
> +		ASSERT_EQ(*advised_page, '\0');
> +	}
> +
> +	/* Check that an un-advised page in between is still 'A'. */
> +	char *unadvised_page =3D &map[1 * pagesize];
> +
> +	for (int i =3D 0; i < pagesize; i++)
> +		ASSERT_EQ(unadvised_page[i], 'A');
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(map, pagesize * 10), 0);
> +}
> +
> +/*
> + * This test deterministically validates process_madvise() with MADV_C=
OLLAPSE
> + * on a remote process, other advices are difficult to verify reliably=
=2E
> + *
> + * The test verifies that a memory region in a child process,
> + * focus on process_madv remote result, only check addresses and lengt=
hs.
> + * The correctness of the MADV_COLLAPSE can be found in the relevant t=
est examples in khugepaged.
> + */
> +TEST_F(process_madvise, remote_collapse)
> +{
> +	const unsigned long pagesize =3D self->page_size;
> +	long huge_page_size;
> +	int pipe_info[2];
> +	ssize_t ret;
> +	struct iovec vec;
> +
> +	struct child_info {
> +		pid_t pid;
> +		void *map_addr;
> +	} info;
> +
> +	huge_page_size =3D default_huge_page_size();

You should use read_pmd_pagesize() here, since default_huge_page_size()
is used for hugetlb. See Documentation/admin-guide/mm/hugetlbpage.rst.
MADV_COLLAPSE is for THP. The test passes if HugeTLB size is 2M and
fails otherwise.

> +	if (huge_page_size <=3D 0)
> +		SKIP(return, "Could not determine a valid huge page size.\n");
> +
> +	ASSERT_EQ(pipe(pipe_info), 0);
> +
> +	self->child_pid =3D fork();
> +	ASSERT_NE(self->child_pid, -1);
> +
> +	if (self->child_pid =3D=3D 0) {
> +		char *map;
> +		size_t map_size =3D 2 * huge_page_size;
> +
> +		close(pipe_info[0]);
> +
> +		map =3D mmap(NULL, map_size, PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +		ASSERT_NE(map, MAP_FAILED);
> +
> +		/* Fault in as small pages */
> +		for (size_t i =3D 0; i < map_size; i +=3D pagesize)
> +			map[i] =3D 'A';
> +
> +		/* Send info and pause */
> +		info.pid =3D getpid();
> +		info.map_addr =3D map;
> +		ret =3D write(pipe_info[1], &info, sizeof(info));
> +		ASSERT_EQ(ret, sizeof(info));
> +		close(pipe_info[1]);
> +
> +		pause();
> +		exit(0);
> +	}
> +
> +	close(pipe_info[1]);
> +
> +	/* Receive child info */
> +	ret =3D read(pipe_info[0], &info, sizeof(info));
> +	if (ret <=3D 0) {
> +		waitpid(self->child_pid, NULL, 0);
> +		SKIP(return, "Failed to read child info from pipe.\n");
> +	}
> +	ASSERT_EQ(ret, sizeof(info));
> +	close(pipe_info[0]);
> +	self->child_pid =3D info.pid;
> +
> +	self->remote_pidfd =3D syscall(__NR_pidfd_open, self->child_pid, 0);
> +	ASSERT_GE(self->remote_pidfd, 0);
> +
> +	vec.iov_base =3D info.map_addr;
> +	vec.iov_len =3D huge_page_size;
> +
> +	ret =3D sys_process_madvise(self->remote_pidfd, &vec, 1, MADV_COLLAPS=
E, 0);
> +	if (ret =3D=3D -1) {
> +		if (errno =3D=3D EINVAL)
> +			SKIP(return, "PROCESS_MADV_ADVISE is not supported.\n");
> +		else if (errno =3D=3D EPERM)
> +			SKIP(return,
> +				   "No process_madvise() permissions, try running as root.\n");
> +		return;
> +	}
> +
> +	ASSERT_EQ(ret, huge_page_size);
> +}
> +
> +/*
> + * Test process_madvise() with a pidfd for a process that has already
> + * exited to ensure correct error handling.
> + */
> +TEST_F(process_madvise, exited_process_pidfd)
> +{
> +	struct iovec vec;
> +	ssize_t ret;
> +	int pidfd;
> +
> +	vec.iov_base =3D (void *)0x1234;
> +	vec.iov_len =3D 4096;

Here an invalid address range is provided, since pid is checked before
address ranges are checked.

BTW, the size of iovec array cannot be bigger than IOV_MAX. It might be
worth testing as well, if you want to.

With default_huge_page_size() -> read_pmd_pagesize() fix, feel free to
add:
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Zi Yan <ziy@nvidia.com>

I am able to compile and run the test on arm64. Thanks.


Best Regards,
Yan, Zi

