Return-Path: <linux-kselftest+bounces-34749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ABBAD5D27
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DBB17503A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B4621C19D;
	Wed, 11 Jun 2025 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OzvapUSh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD651213224;
	Wed, 11 Jun 2025 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662421; cv=fail; b=CnM8eePcOqS1DSn89Fl8BtM+IByyoULzMXPzlusKeJiM0WWfDUQbZzuFi52UbNxC1gr67niZxoRuOxvI0Oc9cj8Cv0nWv9z4K3HZPVmd5GTcLZwDRIb9lxXmiuwdIuD2ktK8GvvyBr/NzFD0g9+psFbxZLBlP+2f5DiPQJK40Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662421; c=relaxed/simple;
	bh=UU+YNlBMaC4SuBAO4C8J7egprmbseqt8LqjshVviNec=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2/lfNuI1kNuda8yxJGhA2mTwYMsmhiRvZP1UTUZG92EyQgPfHQsoi0+XCIv9q6+nf1jUovpLwZ/HUsHeo7Vo0KV9ryJXvL0DJpIpI1AFXGA509s8nZxeuo21IvN2uCM9O8XiL/Qs8at+KkFacgLvyJpaooDHNsazUdhWdZArqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OzvapUSh reason="signature verification failed"; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZRy2rSpCDFUPZgsgW66bdM/Cu/YIUloE9UuIgsBXBHXFpfKU2vtFbgThpegTjTvGpqWJHvuo66YoO4boVQhIIfx69T5yPdu1kE64VgloP12cJZ+yDkJfzEyollWujFypk3Ndn2K23Uec5j/FkI+45VN3JlMuyaLGUmBPYonnRHvNisaYWHWzfjFBdNT7nmVoHueB55U9ZP0aBr+Y0Vg+llGnh5UN/DdNBMba4bZ/U9OPXtiPxm3ogVPwlUVLiAXT3S2Kurd8cPWn4FIoYHic081gCkSXjjmS8Hf9h0mpMPUs9LW3AlKPBT10UU9voesTDK+8CS0llozUUYAujdT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xyr3u1gzUhMqGOMJn4Am6tYheOBwV5GR8fyo/SpJA7A=;
 b=DyA7XI+MX8sQdd5IlILn1D/zju6w0KOtzeXpJzAY2gknOaqFzGuwrcgS1omGnLkCGHwdAmXy/59zcvqdT199U9d/dgCnas/cQ4kwdfLnAGAWK3vEKpE2ri5hdJ67B/F5p7KzqmkV3VIbae4LQ/T8Z/7AwtGc0Jfkiwj/jX/cOl8s90+rMZwWKFR0wLKSRy3TTAtuJnYcAZywKIBmAdgyX5eGThatULuiql1E3lbByWjP43aRJIeu9xrjZel2WOB0jSR7Cv5DnnsaXs2GNRuXteku+ab+dotqqHi9OJINP/u+iaUBcQ/fXTKgogY1ZMAz8yO5+EevO8ZALRPB4m5Zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyr3u1gzUhMqGOMJn4Am6tYheOBwV5GR8fyo/SpJA7A=;
 b=OzvapUShjg9VRfJp10oJwuGNCpuR8d2Xi77jalY4Fqlg3fEAZNHaHuccXdn8prM0d7vBVRt6jGp/HGK2ZrIgh/uU79cSycXH5M7LLwalDz1sYkJPNzKYMPWjmNgIy2FwGXvDPu6/aea2Xouy8QKI8JriX3mN2iSpqkweNi35ExDmRKkTiamqjUZ6HYjPj72a4y4Yuyd/0MPSv+AIKSX7fFB3QE1mt5nOTWf7g9vwEE2r8jc91xUeUgipG3qNj9GL3RweY3+2vQdykwPr2MJpij0HOdgOtJMUauHFLUfhN49B+prG8uQQaSB7JasjCy7AFbU50LiRSVeiLYGs2/xmQw==
Received: from BN9PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:fb::31)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Wed, 11 Jun
 2025 17:20:11 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::6c) by BN9PR03CA0056.outlook.office365.com
 (2603:10b6:408:fb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 11 Jun 2025 17:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 17:20:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Jun
 2025 10:19:56 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 11 Jun
 2025 10:19:56 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 11 Jun 2025 10:19:53 -0700
Date: Wed, 11 Jun 2025 10:19:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, Thomas
 =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Kees Cook
	<kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
	<wad@chromium.org>, Mark Brown <broonie@kernel.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <aEm6tuzy7WK12sMh@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
 <20250610234657.GO543171@nvidia.com>
 <aEkqtfcOJDrxAAcs@nvidia.com>
 <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6f1cc5-22e2-4398-3f69-08dda90c38c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?JEZpZ5OZHw3fAuthU3ugLbOQ4CKjG8PdK4SYIFCv1kbJpT95MxDKl2sqyU?=
 =?iso-8859-1?Q?nF5tdZH0MZoRCEb73NXBKsaFwBgWndNQaH7uZFDiKE0Vg4QgjcMIj8lgsk?=
 =?iso-8859-1?Q?z7/O/JUbraDCJTSwVUs/WqT+02O5nttYb6pNf6W7i7nobHBphTUJ/RGVdZ?=
 =?iso-8859-1?Q?94g+hpzR+1h6e036N4hIKZwzVaHC1ytlOni3XyJ5JMwZoIfcKu7iMmcRUJ?=
 =?iso-8859-1?Q?KizO6jCb8fOSxvk5mSIk5viUv8eexynSFJFJbknTLz7NwayOhza2yGJOXQ?=
 =?iso-8859-1?Q?sC0ikuBCM0ocGvqGOKhEoyxSnHL9M5Y1lbqPTPLwaLeY5cSzEFCag0qCmx?=
 =?iso-8859-1?Q?/EgdbUzGL6/AMKy4qPQFZAr0i4bbvflqVZkWHhz932lZMDSOeFu+fxWRGr?=
 =?iso-8859-1?Q?AkmFsIs0t0Lihb4bdrG9N4lSdVIqAthOhk8nziOUK6szJJg0i5jba1Ilg+?=
 =?iso-8859-1?Q?DuOt+LaOdMDsTdeD2rVZtuB4ap+co4kkIqQz4hJq1uQ3sJ1XJiPDQ0R/Uf?=
 =?iso-8859-1?Q?NfvO0YLXXdpJcQknlRfZSv6LBPiK9oK42ju2fRXTzD9BeHio1yZtAI+/X7?=
 =?iso-8859-1?Q?ymFN6PYTR+T+CNmJ7Js1c915MSjFh/ea4iN3NKAnmBk19FLaeDbHmBya0B?=
 =?iso-8859-1?Q?01lwpsdrgfkDgSHw4zBnKtFoac7jXc5UxLBoJhA4IUEG9t3CLNXmFIO2ZW?=
 =?iso-8859-1?Q?HldIVxpCFRfT5oeLRqrpamyu9bD0RPzK1RS5cBCgM/Y9aNY833wK8MVE2k?=
 =?iso-8859-1?Q?VXuv4XCHXgP/vIHm+RzQOkKOgKOQcX8PG4YJktF/Sz0CSOzmn0Xp4fLMWX?=
 =?iso-8859-1?Q?gs0bKPQ19HmSlL6yKp7ux3WVjPJsVLqIqh2PbfSmjKiZnHXOH72x+bRMI1?=
 =?iso-8859-1?Q?re/K1Y8+hpgnGCSK6KTtH5BE9C9SFhe5y61wmG1xDio4N9j1ns5voN1vYd?=
 =?iso-8859-1?Q?JMcrFcLDiP1ZDwml3YOqRwro2ShNRZoOEBnK1yHNzkVZhFjuGSCZVP+wvF?=
 =?iso-8859-1?Q?Ztio0tspg2AK7dxLhlt0D2l0pAjye6D6prNOXMJ/FTX59ir4fXTyfBq41C?=
 =?iso-8859-1?Q?eZjBqzwcfG1besfwc1Etz3S81F8oZnaeAcYIWzuczcDqsDHmrCgb6xKulf?=
 =?iso-8859-1?Q?lwMqm+mFOhXb8PIKAK74288MZgtEYe5TfZsQC/1QDMI6gsbYxdT3KSYz+1?=
 =?iso-8859-1?Q?eoXEZgWj/h+JShNvqbsiLBlBoDp9yVyo1evc1pX/mtPJ/T2BSmg/TZgjC5?=
 =?iso-8859-1?Q?J0skwFY491RfdznBB8Vn1VNVLVg59ZttkXDNQB2UbGPQNvJ2P7MTamL3NK?=
 =?iso-8859-1?Q?uZZ2cFgvscds43ubFGFh/n6dojXNHnyoLoJeixvMRWIGq+WKEWsGKih5cn?=
 =?iso-8859-1?Q?KotHQvzomQ8SJP0pmJtbt+aFGtRjBz20ErhWFRTtEm0PeyvbgrRFmszpty?=
 =?iso-8859-1?Q?CfAnkRNz+qcHzrHR15GCqcxDnYdaZ83Y2NjN0x2tj1RGgCZHrXeCW5ikv8?=
 =?iso-8859-1?Q?xF3wt5OA+nkmvnEy6FfXXZ3GZ98kJXxiOt/1SAa55uHPmD6yj2qCTl5Ckm?=
 =?iso-8859-1?Q?Xnz2TtBPf0X/+6sun5/bR8YtbNW8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 17:20:11.1484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6f1cc5-22e2-4398-3f69-08dda90c38c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918

On Wed, Jun 11, 2025 at 10:04:35AM +0200, Thomas Weißschuh wrote:
> On Wed, Jun 11, 2025 at 12:05:25AM -0700, Nicolin Chen wrote:
> > On Tue, Jun 10, 2025 at 08:46:57PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 10, 2025 at 11:48:44AM -0700, Nicolin Chen wrote:
> > > > On Tue, Jun 10, 2025 at 09:09:02AM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Jun 10, 2025 at 01:38:22PM +0200, Thomas Weißschuh wrote:
> > > > > > > ------------------------------------------------------------------
> > > > > > > #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> > > > > > > # enforce_dirty: Test terminated unexpectedly by signal 11
> > > > > 
> > > > > Sig 11 is weird..
> > > > 
> > > > > > On another note, the selftest should use the kselftest_harness' ASSERT_*()
> > > > > > macros instead of plain assert().
> > > > > 
> > > > > IIRC the kselftest stuff explodes if you try to use it's assert
> > > > > functions within a fixture setup/teardown context.
> > > > > 
> > > > > I also wasn't able to reproduce this (x86 ubuntu 24 LTS OS) Maybe
> > > > > it is ARM specific, I think Nicolin is running on ARM..
> > > > 
> > > > Yes. And I was running with 64KB page size. I just quickly retried
> > > > with 4KB page size (matching x86), and all failed tests pass now.
> > > 
> > > That's a weird thing to be sensitive too. Can you get a backtrace from
> > > the crash, what function/line is crashing?
> > 
> > I think I am getting what's going on. Here the harness code has a
> > parent process and a child process:
> > 
> > --------------------------------------------------------------
> > 428-            /* _metadata and potentially self are shared with all forks. */ \
> > 429:            child = fork(); \
> > 430:            if (child == 0) { \
> > 431-                    fixture_name##_setup(_metadata, self, variant->data); \
> > 432-                    /* Let setup failure terminate early. */ \
> > 433-                    if (_metadata->exit_code) \
> > 434-                            _exit(0); \
> > 435-                    *_metadata->no_teardown = false; \
> > 436-                    fixture_name##_##test_name(_metadata, self, variant->data); \
> > 437-                    _metadata->teardown_fn(false, _metadata, self, variant->data); \
> > 438-                    _exit(0); \
> > 439:            } else if (child < 0 || child != waitpid(child, &status, 0)) { \
> > 440-                    ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
> > 441-                    _metadata->exit_code = KSFT_FAIL; \
> > 442-            } \
> > 443-            _metadata->teardown_fn(true, _metadata, self, variant->data); \
> > 444-            munmap(_metadata->no_teardown, sizeof(*_metadata->no_teardown)); \
> > 445-            _metadata->no_teardown = NULL; \
> > 446-            if (self && fixture_name##_teardown_parent) \
> > 447-                    munmap(self, sizeof(*self)); \
> > 448-            if (WIFEXITED(status)) { \
> > 449-                    if (WEXITSTATUS(status)) \
> > 450-                            _metadata->exit_code = WEXITSTATUS(status); \
> > 451-            } else if (WIFSIGNALED(status)) { \
> > 452-                    /* Forward signal to __wait_for_test(). */ \
> > 453-                    kill(getpid(), WTERMSIG(status)); \
> > 454-            } \
> > ....
> > 456-    static void wrapper_##fixture_name##_##test_name##_teardown( \
> > 457-            bool in_parent, struct __test_metadata *_metadata, \
> > 458-            void *self, const void *variant) \
> > 459-    { \
> > 460-            if (fixture_name##_teardown_parent == in_parent && \
> > 461-                            !__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
> > 462-                    fixture_name##_teardown(_metadata, self, variant); \
> > 463-    } \
> > --------------------------------------------------------------
> > 
> > I found there is a race between those two processes, resulting in
> > the teardown() not getting invoked: I added some ksft_print_msg()
> > calls in-between the lines to debug, those tests can pass mostly,
> > as teardown() got invoked.
> > 
> > I think the reason why those huge page cases fail is just because 
> > the huge version of setup() takes longer time..
> 
> Can you try to recreate this issue with changes to
> tools/testing/selftests/kselftest_harness/harness-selftest.c ?

Hmm, I assume all 9 cases should pass? Mine only passes 4 on rc1,
without any change (perhaps we should start from here?):

TAP version 13
1..9
# Starting 9 tests from 4 test cases.
#  RUN           global.standalone_pass ...
# harness-selftest.c:19:standalone_pass:before
# harness-selftest.c:23:standalone_pass:after
#            OK  global.standalone_pass
ok 1 global.standalone_pass
#  RUN           global.standalone_fail ...
# harness-selftest.c:27:standalone_fail:before
# harness-selftest.c:29:standalone_fail:Expected 0 (0) == 1 (1)
# harness-selftest.c:30:standalone_fail:Expected 0 (0) == 1 (1)
# standalone_fail: Test terminated by assertion
#          FAIL  global.standalone_fail
not ok 2 global.standalone_fail
#  RUN           global.signal_pass ...
# harness-selftest.c:35:signal_pass:before
# harness-selftest.c:37:signal_pass:after
#            OK  global.signal_pass
ok 3 global.signal_pass
#  RUN           global.signal_fail ...
# harness-selftest.c:42:signal_fail:before
# harness-selftest.c:43:signal_fail:Expected 0 (0) == 1 (1)
# signal_fail: Test terminated by assertion
#          FAIL  global.signal_fail
not ok 4 global.signal_fail
#  RUN           fixture.pass ...
# harness-selftest.c:53:pass:setup
# harness-selftest.c:62:pass:before
# harness-selftest.c:19:pass:before
# harness-selftest.c:23:pass:after
# harness-selftest.c:66:pass:after
# harness-selftest.c:58:pass:teardown same-process=1
#            OK  fixture.pass
ok 5 fixture.pass
#  RUN           fixture.fail ...
# harness-selftest.c:53:fail:setup
# harness-selftest.c:70:fail:before
# harness-selftest.c:71:fail:Expected 0 (0) == 1 (1)
# harness-selftest.c:58:fail:teardown same-process=1
# fail: Test terminated by assertion
#          FAIL  fixture.fail
not ok 6 fixture.fail
#  RUN           fixture.timeout ...
# harness-selftest.c:53:timeout:setup
# harness-selftest.c:77:timeout:before
# timeout: Test terminated by timeout
#          FAIL  fixture.timeout
not ok 7 fixture.timeout
#  RUN           fixture_parent.pass ...
# harness-selftest.c:87:pass:setup
# harness-selftest.c:96:pass:before
# harness-selftest.c:98:pass:after
# harness-selftest.c:92:pass:teardown same-process=0
#            OK  fixture_parent.pass
ok 8 fixture_parent.pass
#  RUN           fixture_setup_failure.pass ...
# harness-selftest.c:106:pass:setup
# harness-selftest.c:108:pass:Expected 0 (0) == 1 (1)
# pass: Test terminated by assertion
#          FAIL  fixture_setup_failure.pass
not ok 9 fixture_setup_failure.pass
# FAILED: 4 / 9 tests passed.
# Totals: pass:4 fail:5 xfail:0 xpass:0 skip:0 error:0

> > I haven't figured out a proper fix yet, but something smells bad:
> > 1) *no_teardown is set non-atomically, while both processes calls
> >    __atomic_test_and_set()
> 
> Does this make a difference?
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 2925e47db995..89fb37a21d9d 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -410,7 +410,7 @@
>                 /* Makes sure there is only one teardown, even when child forks again. */ \
>                 _metadata->no_teardown = mmap(NULL, sizeof(*_metadata->no_teardown), \
>                         PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
> -               *_metadata->no_teardown = true; \
> +               __atomic_store_n(_metadata->no_teardown, true, __ATOMIC_SEQ_CST); \
>                 if (sizeof(*self) > 0) { \
>                         if (fixture_name##_teardown_parent) { \
>                                 self = mmap(NULL, sizeof(*self), PROT_READ | PROT_WRITE, \
> @@ -429,7 +429,7 @@
>                         /* Let setup failure terminate early. */ \
>                         if (_metadata->exit_code) \
>                                 _exit(0); \
> -                       *_metadata->no_teardown = false; \
> +                       __atomic_store_n(_metadata->no_teardown, false, __ATOMIC_SEQ_CST); \
>                         fixture_name##_##test_name(_metadata, self, variant->data); \
>                         _metadata->teardown_fn(false, _metadata, self, variant->data); \
>                         _exit(0); \
> @@ -455,7 +455,7 @@
>                 void *self, const void *variant) \
>         { \
>                 if (fixture_name##_teardown_parent == in_parent && \
> -                               !__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
> +                               !__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_SEQ_CST)) \
>                         fixture_name##_teardown(_metadata, self, variant); \
>         } \
>         static struct __test_metadata *_##fixture_name##_##test_name##_object; \

Unfortunately, no :(

> 
> > 2) parent doesn't seem to wait for the setup() to complete..
> 
> setup() is called in the child (L431) right before the testcase itself is
> called (L436). The parent waits for the child to exit (L439) before unmapping.
> 
> > 3) when parent runs faster than the child that is still running
> >    setup(), the parent unmaps the no_teardown and set it to NULL,
> >    then UAF in the child, i.e. signal 11?
> 
> That should never happen as the waitpid() will block until the child running
> setup() and the testcase itself have exited.

Ah, maybe I was wrong about these narratives. But the results show
that iommufd_dirty_tracking_teardown() was not called in the failed
cases:

// I added a huge.c file to run only 4 cases on one variant
// And I added two fprintf to its FIXTURE_SETUP/TEARDOWN().

TAP version 13
1..4
# Starting 4 tests from 1 test cases.
#  RUN           iommufd_dirty_tracking.domain_dirty64M_huge.set_dirty_tracking ...
---------iommufd_dirty_tracking_setup
---------iommufd_dirty_tracking_teardown
#            OK  iommufd_dirty_tracking.domain_dirty64M_huge.set_dirty_tracking
ok 1 iommufd_dirty_tracking.domain_dirty64M_huge.set_dirty_tracking
#  RUN           iommufd_dirty_tracking.domain_dirty64M_huge.device_dirty_capability ...
---------iommufd_dirty_tracking_setup
# device_dirty_capability: Test terminated unexpectedly by signal 11
#          FAIL  iommufd_dirty_tracking.domain_dirty64M_huge.device_dirty_capability
not ok 2 iommufd_dirty_tracking.domain_dirty64M_huge.device_dirty_capability
#  RUN           iommufd_dirty_tracking.domain_dirty64M_huge.get_dirty_bitmap ...
---------iommufd_dirty_tracking_setup
# get_dirty_bitmap: Test terminated unexpectedly by signal 11
#          FAIL  iommufd_dirty_tracking.domain_dirty64M_huge.get_dirty_bitmap
not ok 3 iommufd_dirty_tracking.domain_dirty64M_huge.get_dirty_bitmap
#  RUN           iommufd_dirty_tracking.domain_dirty64M_huge.get_dirty_bitmap_no_clear ...
---------iommufd_dirty_tracking_setup
# get_dirty_bitmap_no_clear: Test terminated unexpectedly by signal 11
#          FAIL  iommufd_dirty_tracking.domain_dirty64M_huge.get_dirty_bitmap_no_clear
not ok 4 iommufd_dirty_tracking.domain_dirty64M_huge.get_dirty_bitmap_no_clear
# FAILED: 1 / 4 tests passed.

> 
> Does the issue also happen when you only execute a single testcase?
> $ ./iommufd -r iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty

$ sudo tools/testing/selftests/iommu/iommufd -r iommufd_dirty_tracking.domain_dirty128M.enforce_dirty
TAP version 13
1..1
# Starting 1 tests from 1 test cases.
#  RUN           iommufd_dirty_tracking.domain_dirty128M.enforce_dirty ...
#            OK  iommufd_dirty_tracking.domain_dirty128M.enforce_dirty
ok 1 iommufd_dirty_tracking.domain_dirty128M.enforce_dirty
# PASSED: 1 / 1 tests passed.
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

This one passes. Looks like the first hugepage case would pass but
the following ones would fail if running them sequentially..

Thanks
Nicolin

