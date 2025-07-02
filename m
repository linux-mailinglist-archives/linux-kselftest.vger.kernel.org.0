Return-Path: <linux-kselftest+bounces-36364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5C0AF6643
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 01:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF8E48683E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 23:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C03093CA;
	Wed,  2 Jul 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e9jD+oAz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA252F0C68;
	Wed,  2 Jul 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499025; cv=fail; b=SI5gpfAWjLF1KkLLCuqXnnGDbvGmgVYfHmBhDjp3ruWksd9I720b+f8oUAtq1oVSr46gUBfLvPCFCZ8zJcs1gkBLXge/SyARIxubakO9vNpUxVmHkogTQWhXhf3DMxZn6p40XKuAYAYmMSmNvmTY6JINAVRg0MceDa0qCAvtS+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499025; c=relaxed/simple;
	bh=Ebev+Z60KYQfu49sWa+QTYaf7qEFeHBbLA8GNlPJ1g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YskYBlTOg5HfNegGtqbljOcHV1DjHytNqIMdUu5S0CqYRk0Dpw58aZ6VaCHFC/BFEtrgO8Yuo21khfN+6QdbkkTJPDkTSYKm7wMfkDO0v1NX/HeuuiotyL4yWXf+PcL62XUChbrqT8dtc+0QNOyABGBIF8RMNDp9cNJY4FW967w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e9jD+oAz; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUm31FZc9XQqdXv8CGeexqrMbUaTt5iOsvo+AUwgqJbuqKqBHlgLPc52ulTGr0jixU5r6334HGltwDlRMExmxwmZ66PlKlkeWN1WJZJ3zPdL3cKH8LMsY/Hn5j8TKT3C6MDiB8DjMntq1VCjGAWOb3O3m8zumhuItTVxQZgkern3JqF973ko8tkFlGAm0MEzWjLme/K1CuHFHTmKJbiBkKiuM+ytZ8DLt9m5/AeHBixot8NtakcC36ZqjB7yw9v1sLwvyhpct4AxKZwGGw5oo4TzmALqkMBxKY/f10qnhRfK6smIHMEl/cDs64U1si1GvcOV/fE3P+MN5cakmj/9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5WUGDKZ/pwPNdpsepCF7GR1khVjxjyfRTqSzHam+eA=;
 b=jlx8TxZybtwT8SJqlkyM6AFEAFHg+CKmKM80D7uuVFWpNEhd69VvKiW4UV+8hfxViWRYCetM/POEEGAP0ARU9T/4eGJ/wVOrfib6XO0QlI/ruhbmgpbRSRBVGACaHUMxETW1Pz52LxsMXS+QawZ1PXESyadT9o2HmeQ1BWHxyEi+rulc8NcZFFDMPXxcEQzFVXo3Yy5h6Y5FYGdgTeWVuCka1kFh8T4i1QZrajlDNfAEP6OCie/YaU68nO5N8ZAYHlBXvVfLErMV2pqGyVUlF3nCKlD8IvmF60xsv/ZIm4N/phkw7loLxYne0kijAheBsBpD4qwO5xDmWokaKuCe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5WUGDKZ/pwPNdpsepCF7GR1khVjxjyfRTqSzHam+eA=;
 b=e9jD+oAzGtiE6C5/qTFcQoG8GkOdK7LoqqgH0hOGazH6SgJ3U43WORShTcu7bH5Zy+LfP6Sfj2EFateWnjWDJpqcxr6loJhWnw4lObEiwDMsTG9WhvJWGjNffio6qMSGV18+92ny86pk0mnlIjfqCsNukGBaK4oWueWJl3t9ozHHCtetYQsrBpIYygd4+b2qOzLDE7nn3w2ZrgC/kmGCDEFi7KRIU4UgOhAZzwiGN6HObWqEKQux1y5zPN134zToDqQCRpZZ0em3hvu4RiGnHd9NauRtoC4hys3WmGVa91+C/0SmdNucxUjx9L0/0/KeZHRVPcNxy6abIyBvdlSv+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 23:30:19 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 23:30:19 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v6 12/14] selftests/sched_ext: Add test for sched_ext dl_server
Date: Wed,  2 Jul 2025 19:29:37 -0400
Message-ID: <20250702232944.3221001-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702232944.3221001-1-joelagnelf@nvidia.com>
References: <20250702232944.3221001-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:c0::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7dfe72-a494-474b-cdd8-08ddb9c068a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AI3E1+B6qmLpiYSZbIQ/kXejybGmJDx0U3ZOEiT0fUTg6YegrbYHywNIpTvA?=
 =?us-ascii?Q?YthSkclNhlKuYgovWJPGqxFGSVlTN3TnuQtCLjFuV/p92YGWHWJKmTCxPoRH?=
 =?us-ascii?Q?03XjiKUbIZ8k0/sPfvG4cZPnxNXR4U9sZTa0PO4/bC7TXoz2F1Sdp74pAZAh?=
 =?us-ascii?Q?QH7jXSNT1q3+4R+SZgsgAh9QgqbB5yC3bEegvBkE8VbNcKoDgV63SHSEwFsr?=
 =?us-ascii?Q?o+2YVEPI7WV9ZiLntXhZhWhmfcMWf3F2Aq5Fhgg5dgrIVwY9cSRmUzrxCxGL?=
 =?us-ascii?Q?jGqF2tS9xsxokP8GSdhN6CBZg4DajNpKy6E1SWHT3HhUAujG0JG+xQYPHgLU?=
 =?us-ascii?Q?yudNUJoAaa1v2huptdy/iRErA+n5g/uFqknaAG9asWRv+2jJOjkLX412Iirc?=
 =?us-ascii?Q?HHF6XGUTfbqDfzyMDIyzc5Xw9Tacce4KpNS1lR3k5v3CRIMKpY6bPNpdzCJL?=
 =?us-ascii?Q?PJ76vfz01rjTpb5DISGtTc+rNVffOkeRdoMBX6qyTT+sMTjrS+vrUQwnlmYA?=
 =?us-ascii?Q?T1eJ6wezzZVgjse91fLlGXzmbUyXkaxioFQ25Ed7mYpYxhi0bPTc3jjuR3iE?=
 =?us-ascii?Q?ZJwvLgNWx3skGB0seiGYYIPAmCd1lV9hkHYWHisHo7V6DVb31+CkycoYERrT?=
 =?us-ascii?Q?hoM6GuqYckMKVHKHR1vWzGy6PmtL3rdNQGaJtspiKZMDPD9l9wncJg+RkA++?=
 =?us-ascii?Q?6I1ng9nd6oKfr7nZOtzFtp54JBoY+dCdHCFvMfI+O8T5AbymSwntb+zjAYte?=
 =?us-ascii?Q?i7uFWfPuuBBMdLD922A+Xp2ea94EzQlNKYVYaRIa808RA00tnKXoig4AloWz?=
 =?us-ascii?Q?ph5/scLiujv5zfv3XRvujMLKtJdZfF9QhdlJaaRbNdQILwWfSU4T3vJcBu3R?=
 =?us-ascii?Q?futWM31pGRQOXbgFSokKtUPiUMIT1yT/WB6PDnCLFAKXqo13XDE9am1S13yV?=
 =?us-ascii?Q?s5QLIkGyAlViID5SW98h5Ky+9waI8ttuqz6/d4fVcukY3c2uPjkn8lXIH3gs?=
 =?us-ascii?Q?jeIRpAk757LNGnE3B02keyeBRYdU499sk5ggqtbNxe5VpdjEcattfKJ6tTL3?=
 =?us-ascii?Q?oLtAwlinnsAK1drQ4+ixpWtylWmxlCrIKDwC1QVCfHgesZVkMZ6Gv1fyirNb?=
 =?us-ascii?Q?TCM3wj5HS3Av014n5AtNuU0XAIFtj5Q0u3AoGeOhqedkErTPS9DoLQACL87V?=
 =?us-ascii?Q?bQHXmA+6h7kWgJVgmFqEAe0DRBM1gX8sxR+qu/1lhJoVEu0Of272uBmzB8Oc?=
 =?us-ascii?Q?iP87jop9WyjHyLWOtA28oUvTUHKWFu3A07c0jWFzBg/oScu8biGmFLg+CjcD?=
 =?us-ascii?Q?DKYbIf8bZkTr4zya2MPOpY3HWceLapK+Qoa/KjFl7cJW/R/RU+0qlGayrULv?=
 =?us-ascii?Q?Ss7Ukq6r8l9vI0rF+5z8JUexeWHH2MDFnlBgrQtCt0DOe1Oeo9uBQNfLNpQq?=
 =?us-ascii?Q?nVQ0TWSewrk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mqj82+qr8t4v+WalzYUlfVF8+w3NArKhjmWPiBymvCwTroEd2PlWmUxIyTV+?=
 =?us-ascii?Q?jnTRMLmH/T5jOEMMDNxCql+F6lCbhJk7tlDqp4kMcbgjcXFEoaSZIaOORcLd?=
 =?us-ascii?Q?me0mYzQHRhLypHJGwTnO+M23EIgIAFdHFFfZPANCChFKIaQ35CiYmYcMD4mf?=
 =?us-ascii?Q?MhukpDzHCl1NxZUlJdW7QUoS3r018B3wx8/LYS4UBhRRw8Tg0r0yfcxX7qHr?=
 =?us-ascii?Q?U49lm6czeLbB2zh6fJ9DgbwgvSODXfuSnHT/eowRsgvws6knlNygWD1lm67/?=
 =?us-ascii?Q?tvEG6NHlfXxQqPXabQN6VDZBbblUXxtcg24wNhcIjco58Hx2wNpt9vjzK56c?=
 =?us-ascii?Q?/J8b/Kqy2ZNr1++mBAcHL3ZqvQTQQ59m8mJxaJazBXjk9zGj8tZoMkf+rBy0?=
 =?us-ascii?Q?EvT+qZMNXdph/v/rN7cTMn2hTmz5yP8pyT7V7zJsCQRCNk9c3bg7qSdkpeFY?=
 =?us-ascii?Q?Dnc7IUOLoQvBXgxP0Hs5K9bQe7Uth+QFSMiGcgQbRv62C2Rf2U4BGVg80bf8?=
 =?us-ascii?Q?I4q8F+tmSy39KBp+Aq1G4xOinVkwPE26G1yJeTTY8lqO4PYIsTp1xS9TXpoe?=
 =?us-ascii?Q?170oD9Ke1WQiIQSYBzoD1shse0cbdQbOOT5oOBNbHWYVih3tpZMdJF3QPxFG?=
 =?us-ascii?Q?DXQ8z6iiTITG0CuLvcZPKITOLCG9QTHwQeTsO7r6lVqS9cw0yB4hsvMyKoEI?=
 =?us-ascii?Q?YbvvNfAo9FlwsPdFbOAkxwkIdp5f7/Ta0cIWiGdjfaMR2UL3tEeZhUijItQH?=
 =?us-ascii?Q?iMVj+gE9v4BSi2yY2KnpB3Jji8T1XzYCPRAiy2jhyRXTxe/tqLhq3VQBKc2j?=
 =?us-ascii?Q?tkEUeZwkc4ioWK2MhtNADxCDp86/I1mHX1j5XxvHNgWgLvqPIiiL5Nh0pa2Q?=
 =?us-ascii?Q?XeDJBXQjYiQJWQDU8chFKPYQXuWQ/6FYpZ1rRGDTN6VaXJmyhfp50s1ekEg5?=
 =?us-ascii?Q?Pr8gP7FWcglltpY9PSDYPBihr2wK4CVLo8BKSbRFZrBgkEVQaXREzuh/dyqh?=
 =?us-ascii?Q?TMV+DivoOfsBm1JHSF1NfJXiUHBjm/2zB3Nshge0Ba5MKxRlU4FIWyaCZl/A?=
 =?us-ascii?Q?owsHLyetVZRb8ti9eC14xCuMu5/dI7gJ8NftbbjRQNn/zm20d89TNxYfLn5f?=
 =?us-ascii?Q?+WIM4/Uv6m2I2HL3NZtO82poVWNVf8DjJZc/nAMoidSxr+l8/2K9hgUd/pHZ?=
 =?us-ascii?Q?zkRBzToCZa/6TVxcPdkTAPaocukfqYj2NrqUBgkXnea71F8lfWp8maq3yjlm?=
 =?us-ascii?Q?bThxxuK28K0bmgp+ZA6FXkIEt0HrB+OyMAyzCHUEDHTBWOlVyBBI1rf6reK+?=
 =?us-ascii?Q?ol3rubB3v69FS+9y7GL0fanUv5ss684teImnlxQ/J8jLykBjU/vv77WQalhx?=
 =?us-ascii?Q?iNCC4G2ObrEEyc7WDbvOA9UBDAAdkv0hwWG5l27Q/a7REDiPCpd19M7tM9Sb?=
 =?us-ascii?Q?bCMv1gbSl5fhdp4Pgm8blBauAMupUWbsyQ556ka2YxVjOXpO+hwV6tFFEjB0?=
 =?us-ascii?Q?fY67a//+7rRVrJsReiLBs/tJduhk217cVKbuvm6H6dGm+LxEHQ+P/fGM/HZQ?=
 =?us-ascii?Q?OTz7qSFT3HPVoLoCgbpJfSAqn+xEXCU4IjBiN2Iu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7dfe72-a494-474b-cdd8-08ddb9c068a4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:30:19.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89BqPTLDezi6bPe8yZ1nwCf85Lt47snHT4Uo+N6oOA8ssd7gYLZLJAzPnXicjEH4dhuWWgCEtCPojgSNWw8HYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

From: Andrea Righi <arighi@nvidia.com>

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

[ Joel: Replaced occurences of CFS in the test with EXT. ]

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 9d9d6b4c38b0..f0a8cba3a99f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -182,6 +182,7 @@ auto-test-targets :=			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	rt_stall			\
 	test_example			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
new file mode 100644
index 000000000000..80086779dd1e
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rt_stall_ops = {
+	.exit			= (void *)rt_stall_exit,
+	.name			= "rt_stall",
+};
diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
new file mode 100644
index 000000000000..d4cb545ebfd8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <linux/sched.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "rt_stall.bpf.skel.h"
+#include "scx_test.h"
+#include "../kselftest.h"
+
+#define CORE_ID		0	/* CPU to pin tasks to */
+#define RUN_TIME        5	/* How long to run the test in seconds */
+
+/* Simple busy-wait function for test tasks */
+static void process_func(void)
+{
+	while (1) {
+		/* Busy wait */
+		for (volatile unsigned long i = 0; i < 10000000UL; i++);
+	}
+}
+
+/* Set CPU affinity to a specific core */
+static void set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Set task scheduling policy and priority */
+static void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority = priority;
+	if (sched_setscheduler(0, policy, &param) != 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Get process runtime from /proc/<pid>/stat */
+static float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file = fopen(path, "r");
+	if (file == NULL) {
+		perror("Failed to open stat file");
+		return -1;
+	}
+
+	/* Skip the first 13 fields and read the 14th and 15th */
+	fields = fscanf(file,
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+			&utime, &stime);
+	fclose(file);
+
+	if (fields != 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1;
+	}
+
+	/* Calculate the total time spent in the process */
+	long total_time = utime + stime;
+	long ticks_per_second = sysconf(_SC_CLK_TCK);
+	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct rt_stall *skel;
+
+	skel = rt_stall__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static bool sched_stress_test(void)
+{
+	float cfs_runtime, rt_runtime;
+	int cfs_pid, rt_pid;
+	float expected_min_ratio = 0.04; /* 4% */
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Create and set up a EXT task */
+	cfs_pid = fork();
+	if (cfs_pid == 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (cfs_pid < 0) {
+		perror("fork for EXT task");
+		ksft_exit_fail();
+	}
+
+	/* Create an RT task */
+	rt_pid = fork();
+	if (rt_pid == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (rt_pid < 0) {
+		perror("fork for RT task");
+		ksft_exit_fail();
+	}
+
+	/* Let the processes run for the specified time */
+	sleep(RUN_TIME);
+
+	/* Get runtime for the EXT task */
+	cfs_runtime = get_process_runtime(cfs_pid);
+	if (cfs_runtime != -1)
+		ksft_print_msg("Runtime of EXT task (PID %d) is %f seconds\n", cfs_pid, cfs_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for EXT task (PID %d)\n", cfs_pid);
+
+	/* Get runtime for the RT task */
+	rt_runtime = get_process_runtime(rt_pid);
+	if (rt_runtime != -1)
+		ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
+
+	/* Kill the processes */
+	kill(cfs_pid, SIGKILL);
+	kill(rt_pid, SIGKILL);
+	waitpid(cfs_pid, NULL, 0);
+	waitpid(rt_pid, NULL, 0);
+
+	/* Verify that the scx task got enough runtime */
+	float actual_ratio = cfs_runtime / (cfs_runtime + rt_runtime);
+	ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_ratio * 100);
+
+	if (actual_ratio >= expected_min_ratio) {
+		ksft_test_result_pass("PASS: EXT task got more than %.2f%% of runtime\n",
+				      expected_min_ratio * 100);
+		return true;
+	} else {
+		ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of runtime\n",
+				      expected_min_ratio * 100);
+		return false;
+	}
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+	struct bpf_link *link;
+	bool res;
+
+	link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	res = sched_stress_test();
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	if (!res)
+		ksft_exit_fail();
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+
+	rt_stall__destroy(skel);
+}
+
+struct scx_test rt_stall = {
+	.name = "rt_stall",
+	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&rt_stall)
-- 
2.34.1


