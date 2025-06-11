Return-Path: <linux-kselftest+bounces-34640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF86AD4C48
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DF33A76B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BDF227E90;
	Wed, 11 Jun 2025 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dy5gM1Mv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E639478;
	Wed, 11 Jun 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625547; cv=fail; b=NApocKIgYhu9G6/0qBNpwsTtsqA/YowWUNp1zCPHLOD1R8ty6lO/NzqZGfjbatl9EccmE7lM53RI3IJ/VAT3IHwcfNiuuF7VkU41GSGX7wQbGKJusV+v2aqO9p1vtcGG30Jk9sbzYyASMdNypzY5QMFD8KekbQZQRGckXSMmVnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625547; c=relaxed/simple;
	bh=b1NadHM9VLXCXbzoM6qiXgMs/es3BqaEyEx48/MXzEU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co+nGDJsGSQ0D/yBbJEPmYB/0M1Nvww2LcZTS+8ccJJ5xTZYI73k4lefbtBRezVets1Lux+xkR9PhW3Ucod4LVu3sfH0uFO7BioYlweIvBrwRc57Kui2Pml9etkRTP1i4KwqsOBBHV5SJc66TRPWlXRPqRlSe2MLK2SdwvH2guw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dy5gM1Mv reason="signature verification failed"; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8QZhXeUzcr0vlLEGY/q8x6EAnQ7SLgGaioyMDZcwoZlvTpCDaxjnj9afpxzQDAnrc6GV/tzX3e5WV5xAlbf13rL3EWmRxr9cEV9helR6OuvRv5cDKveeeY+KxvfWI2gg7Ga4+l6RjfjmEP5bBGY1RLbtaL8WrkQ5m38OgJM3+xa4MyUWUH2x33b3U//PgmQfmlAnuiYsGIC5UkJhHY3Gr4bCBhGEqg2HFxFJ1ooVme1uKXp0Tbng4HUkv7R+u4L5nSJ1mQrbFV6xmhU9rhtDS5QTi7tqJY3MBqeVrNKPbVtlzNgPF/drw6XvrSAeB/uxCo0cAjBCFM4/4DabhHzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJDZFPoc2nfiuMRSzpyIhX7hm0LxMpSO2DnHY07pcLI=;
 b=MpXy86obE5zokF1ZYt+Rtr3gNp8Q0xMj5X6DPfZv5nIoBfb6J9fqXnQNmucXnFW37k3M5zSIwMcjtMKVg/3+nt7Pdj8vl/mtAQxfXzlaRJzFDicJYD6t0X7uBZtG8UMYJDORl2on6VRx/P/uUkIh4rLawZfwnKwlzxV1Vxiw+GHI0v9xGP1HMTmnOQgOdgDPm2+IA1kYMZLBNZ+KUXoUjIXBT1JTxFxFTZRLdX1mpTB5R6RTsOGeba/rudxUlKndhe9nqaOVsj+lNPtQMr+3B6yDktZvJaChf8tuNHTGGGN8s/zBRM3TkJPn+4cg5ngFUyjoNScMliwnf9KQ8wY8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJDZFPoc2nfiuMRSzpyIhX7hm0LxMpSO2DnHY07pcLI=;
 b=Dy5gM1Mv682F1pqwW77TvGuX5vTnMA9C/kGjI6Vpj7iY/1VF8XNf6Dqya5mpsh0bVt14CnoA1xdbSDgx0+hfIhRz2a0NUAZ4ESOdAIucSgwprQBcH8KpIZaIUHweWFddaLWykyDLnGYtiCd4FJDLVCVI74sEYeGI26toK4MpCW5yn5/Yt2nx4vRGc0zU0NVKI1SEaYL/7OuNcaEH04fbxA8/btwaIIONKVP8oZqeg9QgB0ZsyHjdIgeTlGed9MVVFiWVbUAOGagbGz3ETEmhjLwR7fbXN+5Z+zx2qfA8KfGsCx4hG7LdR/OyuoQ34ullZgM4lp6USUU9jlsmxTzGZg==
Received: from MW4PR04CA0294.namprd04.prod.outlook.com (2603:10b6:303:89::29)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Wed, 11 Jun
 2025 07:05:41 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::56) by MW4PR04CA0294.outlook.office365.com
 (2603:10b6:303:89::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 07:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 07:05:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Jun
 2025 00:05:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 11 Jun 2025 00:05:29 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 11 Jun 2025 00:05:27 -0700
Date: Wed, 11 Jun 2025 00:05:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<thomas.weissschuh@linutronix.de>
CC: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown
	<broonie@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <aEkqtfcOJDrxAAcs@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
 <20250610234657.GO543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610234657.GO543171@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc325f7-238a-4fa1-0288-08dda8b6604d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?MjmaTQe3juJi5gkETP1PE8TuG58rqRjAd/LG9Mro3NKU5AkPdO4BXFxaOb?=
 =?iso-8859-1?Q?imopL8ZJONJdPZS2qtHmS/4hfXGPTM0XqKQR/eArgfaRthrw6BujcNcJyQ?=
 =?iso-8859-1?Q?bxsMEtUE5ohNV+EZNmd8Jb5atLHkLzifJwG02srCmBRyLq8L9tKXnZk3WG?=
 =?iso-8859-1?Q?1nm/byDaBq30myhWJhApbA5zXr0rDm29v007JdLFeoyf7M2fHW+lBPHiNb?=
 =?iso-8859-1?Q?/67UckCKZw2CgxXFbj6aPyxixg3YV8sL6LWMgZF+ya4inpqQPVg0Gy52dC?=
 =?iso-8859-1?Q?Q4zoX8BLIUT24R4UpD7U101Y4/e/ESZClKSXreU2IagR1OuZa3XwwFLQ3v?=
 =?iso-8859-1?Q?BtTcsMFd9AIXU9WkDNYEIFpveC994US1N8Tx687oOxXenW2FDdFxHCCWJM?=
 =?iso-8859-1?Q?TAYUYIYkphTpSX5UMqiMxJolXjJ3mHf6tHmK8/4hPyd25Zq3tCfxi0Dsru?=
 =?iso-8859-1?Q?uWD0TZ9wJdRutJL7uZCzyuJh908F8RIUHDmbEfbna8yIb5LzIKgd33uefh?=
 =?iso-8859-1?Q?RnU3pCMY6h2RsYrbLmCB1TWMgjVnuj1pUxNM2GV4mUtotNLlJZ2Vq4uUDa?=
 =?iso-8859-1?Q?3HMneWSVt/lq0JIVMcqjFoFtqNCUIzmda2ih+MMldZlqP91BjXqy7lVKdG?=
 =?iso-8859-1?Q?5p+F6Qd2cifuTYjMDP3k8obk9YqLSAUtEvOuNGiQ1pVINr21Au2wFf4Kys?=
 =?iso-8859-1?Q?NXZvoZBN78QGRHT9XJYKmH9hpSgzX/yK0Dw5mI07kZak176VxG/q+YL9ay?=
 =?iso-8859-1?Q?fTGFftntJdjhRCJZ6MEbnavQvJieCDIVwlOEwUIEGve/xSp8o8yqA4vxSR?=
 =?iso-8859-1?Q?nZpARAo/3+sUHLnjyh3Gqyyn6R8ifsz6jL3o9yRi3rAHzQups/+VRSpHuB?=
 =?iso-8859-1?Q?bw6gRwF+QmmSBMobsp8riZzWSKw1HWvTv+LTqws2ig54764RHghfckccQR?=
 =?iso-8859-1?Q?AztK5Af9Y50Q9OXB/fM9wFfQHvBoDvC2IogCwmXoQdCgDCPBlZ4x8VBwl6?=
 =?iso-8859-1?Q?csQbznqyzDtZ23sjPnnA9fVkodvKUEQrjhowGXZcqaPpZKgeqgNqKvEGe6?=
 =?iso-8859-1?Q?JKXzPIo7bs33YAWym+LoiAaTp+xpz+LlYyUwWMGYrPD7dU8Sk+uXOR/Pnb?=
 =?iso-8859-1?Q?Whd0EywU+A0XkbkaDoDuef2FhNY1Jb5OoqY88DumN8upE75Q1fYwzSqBR6?=
 =?iso-8859-1?Q?XDJNGTejfErjcL2te0YPVD1A8qvmuFP7e5GdzVuJ7/g6oEBUEfX75qEPFV?=
 =?iso-8859-1?Q?GB/wTppTxjOkIEoGFr/u/LHai0yM+SQXihSbrODYdmrbM4vRSgaPvkgruu?=
 =?iso-8859-1?Q?lmt0GbjDfcwLlAbgEUb22Cpzv8ClBv9BLzKBzjEnKS+Q9P56qesEaD7MUE?=
 =?iso-8859-1?Q?0fNpPnAGImKCmEkGEkWo68S38Q8fNOjlQCldbpLJ4rROBbS2oORN94da5I?=
 =?iso-8859-1?Q?leJIyKz6U9JjQxj6wNOtC/sJjExnyi/4/ql4kne4/h7lumACHuVQZveGOf?=
 =?iso-8859-1?Q?DJzBFlxpFIxeAi0Lz87hOgIVecs1GKyqLif39GQ+MWEO1AecOyEunuv/cc?=
 =?iso-8859-1?Q?MeFIAwfWFvxOZGPCLM9GUxhiu44i?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:05:40.9546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc325f7-238a-4fa1-0288-08dda8b6604d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269

On Tue, Jun 10, 2025 at 08:46:57PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 10, 2025 at 11:48:44AM -0700, Nicolin Chen wrote:
> > On Tue, Jun 10, 2025 at 09:09:02AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 10, 2025 at 01:38:22PM +0200, Thomas Weißschuh wrote:
> > > > > ------------------------------------------------------------------
> > > > > #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> > > > > # enforce_dirty: Test terminated unexpectedly by signal 11
> > > 
> > > Sig 11 is weird..
> > 
> > > > On another note, the selftest should use the kselftest_harness' ASSERT_*()
> > > > macros instead of plain assert().
> > > 
> > > IIRC the kselftest stuff explodes if you try to use it's assert
> > > functions within a fixture setup/teardown context.
> > > 
> > > I also wasn't able to reproduce this (x86 ubuntu 24 LTS OS) Maybe
> > > it is ARM specific, I think Nicolin is running on ARM..
> > 
> > Yes. And I was running with 64KB page size. I just quickly retried
> > with 4KB page size (matching x86), and all failed tests pass now.
> 
> That's a weird thing to be sensitive too. Can you get a backtrace from
> the crash, what function/line is crashing?

I think I am getting what's going on. Here the harness code has a
parent process and a child process:

--------------------------------------------------------------
428-            /* _metadata and potentially self are shared with all forks. */ \
429:            child = fork(); \
430:            if (child == 0) { \
431-                    fixture_name##_setup(_metadata, self, variant->data); \
432-                    /* Let setup failure terminate early. */ \
433-                    if (_metadata->exit_code) \
434-                            _exit(0); \
435-                    *_metadata->no_teardown = false; \
436-                    fixture_name##_##test_name(_metadata, self, variant->data); \
437-                    _metadata->teardown_fn(false, _metadata, self, variant->data); \
438-                    _exit(0); \
439:            } else if (child < 0 || child != waitpid(child, &status, 0)) { \
440-                    ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
441-                    _metadata->exit_code = KSFT_FAIL; \
442-            } \
443-            _metadata->teardown_fn(true, _metadata, self, variant->data); \
444-            munmap(_metadata->no_teardown, sizeof(*_metadata->no_teardown)); \
445-            _metadata->no_teardown = NULL; \
446-            if (self && fixture_name##_teardown_parent) \
447-                    munmap(self, sizeof(*self)); \
448-            if (WIFEXITED(status)) { \
449-                    if (WEXITSTATUS(status)) \
450-                            _metadata->exit_code = WEXITSTATUS(status); \
451-            } else if (WIFSIGNALED(status)) { \
452-                    /* Forward signal to __wait_for_test(). */ \
453-                    kill(getpid(), WTERMSIG(status)); \
454-            } \
....
456-    static void wrapper_##fixture_name##_##test_name##_teardown( \
457-            bool in_parent, struct __test_metadata *_metadata, \
458-            void *self, const void *variant) \
459-    { \
460-            if (fixture_name##_teardown_parent == in_parent && \
461-                            !__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
462-                    fixture_name##_teardown(_metadata, self, variant); \
463-    } \
--------------------------------------------------------------

I found there is a race between those two processes, resulting in
the teardown() not getting invoked: I added some ksft_print_msg()
calls in-between the lines to debug, those tests can pass mostly,
as teardown() got invoked.

I think the reason why those huge page cases fail is just because 
the huge version of setup() takes longer time..

I haven't figured out a proper fix yet, but something smells bad:
1) *no_teardown is set non-atomically, while both processes calls
   __atomic_test_and_set()
2) parent doesn't seem to wait for the setup() to complete..
3) when parent runs faster than the child that is still running
   setup(), the parent unmaps the no_teardown and set it to NULL,
   then UAF in the child, i.e. signal 11?

I think Thomas should have an idea with these info :)

Thanks
Nicolin

