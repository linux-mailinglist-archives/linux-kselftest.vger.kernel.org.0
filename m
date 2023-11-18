Return-Path: <linux-kselftest+bounces-265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5207F0202
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29ACE1F23074
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D17107A6;
	Sat, 18 Nov 2023 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="N9d0Kafj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2054.outbound.protection.outlook.com [40.92.74.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A6212B;
	Sat, 18 Nov 2023 10:40:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf/ae3Fx5pq6Wntnj3yyFrWsB4v6SEWprgRU6JMwx5LZIriV7++mgc1rFsn1A/Z+PcvWyHEN1s6IaAU1kWQCZPbbiCP83slIB7XBjaQwS6NW9E3LtXsnNsD335srlJ1YoiYlxfX1O2gWrVHpGRKzFAnASQtoPA9WGY/SwnwFCnt0zfy+oqXogexXQoacuBfMJYtitNJqmmLME1BPZuCl7NnTNUCCJb1SIqtgkw4pwIrjl51o6DaXUa8FxHPghtj4rkIVmzF+6fRpwoc4kWjlo3G3PfmKvohqs22AwPMjLTFoIPjVKQf44x7pNBQUzYQOt8d+7hIZcGtf/dN9/sF2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXXkB5DwbtTzv05pOKpopJ6Dn/SI2aqdy+U9c3GdYd0=;
 b=gbXsMSFe53F0Mz1ATlmbrWm0BIZ9hAn8uVfj4DhHfonHA3Zd62M/Y1n8MBs9hjFQDtlgYKoiZX4g0hZjU8Hb6guqHju/ZBFlGWXgYXVaaKLZJ5TsPxipQ2sYBOEKw5r+o5Rw99Pl43+1XBnh3SDHSsR6QxlpsJJh8OlYQFKKNnEQwfr0Sze/hM4OR3W0M6C4lRtFEa5FFXZhXLtsAnax+M2WGQyLB2fUS+0eF/uMkJWUAij5pqkpA+/MKgv60Pr/Ff9JDfONrg8rVh1uxlFMIl3YvBbHnndNJDlWJy6AuCQKgHHLCafUM4U9RqBn2/jpB15GdSem2+CPjTVhoGsqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXXkB5DwbtTzv05pOKpopJ6Dn/SI2aqdy+U9c3GdYd0=;
 b=N9d0KafjjE0bnX5goPcTebBnIl4C0yo11McCbBK67DBmF8T5NeY4Phte8fkg0Dzu9/hkbvPdWxgSETalxI1b+63mUuroy1qMX9czNCOYFbz7SN4ceQtZb1CZNoyXq3UbC9N0Ik7WzcRsvyDyX5iNhcHDLP0O1xWFDqPJ4AEy+7YS7aMMiTw57Hc5baqDwCL8/DFoKnbA12oP8/IvBKQJH4ocQtjE/X1fq8DgzCfs0lKOoRNbFj/Z+KiaYeoO0Qs8f6qbbuM604MwXVwuzt5LYASgN5mqsFXpSLMEBIszGW1lKDDUq8ugo9WE3q/kyuTmhjOzBegvv5a4l4lTlU3UTw==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AM0PR10MB3713.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 18:40:47 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 18:40:47 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	mykolal@fb.com,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: Update multiple prog_tests to use ASSERT_ macros
Date: Sun, 19 Nov 2023 00:10:23 +0530
Message-ID:
 <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [WGTjBdcq9taaETagnSlVTKJ3B2vtz9eL]
X-ClientProxiedBy: JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231118184023.231166-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AM0PR10MB3713:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb15348-1671-4030-db07-08dbe865e127
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EtPHSsHbVbnQVPfgUD953NYwfPhsT97t2sYNuspb1MOEjPbBuqcgGUZeLC6aIAYc5NpDzD1mXdHT4HlHTs6nw+a9B4R3EWh5xM3iCyMpISKgM9O//unPYtZVRsytTp+ZyjFIvO3r/0HmYJVFGVQhkit4P8DgDDRK2TJCuAPmGCCpurNcN954CktoSuuyvyajZoh+lZznf4Ibe7LV+OmbcWk4UdRkVhMVph7i9lFlZxlFTC9JAL7T31NiHsImhNyZafXJ7xL6aOV/JRVXMXy2Uh0qMkPOo96yNV+BzBUe/rVaJSQIvpS2JSo1ZWra/VpEjSGXLZSL+O30UiQx0i9CdKqoFeOOZVueX4YGJLqpyEsitu8v1yLFTcFMi/v+tqv9wi0mg9D3qsUp3mfcQfv2NLB0+io8sF8rwIhyG3pFYtICWOVuLFuoCtF6jtGTb8QP1RWe5nmroRfslag7/NT79ZggCcp+vDTzY8y8/35hjyx6BtpmqQNaDWtkjSOJ0wPJARPRPdVPm1UvCPWh8s1rflCtANqvfmDK4ggtdQ8xG1332xsi95Br8sjPbqqOYhlBISwxuPZH7fRCa6LqXtCCKUFLNkQZsl1WEdQp19WZ2CwF18Ait/Ns/smNYLQ10jnd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/oVrnni1+OPDk6vZZhMYw06+MNeIJdR44mXBTezHqf3Iwthza/bdlW62N1+Z?=
 =?us-ascii?Q?/JlTxzNEcPKHsfneovLwfj/jjZJkTqbPV+NnP+O5LGvC8bJ0bStGBswwgMN5?=
 =?us-ascii?Q?HpHrB0ZIUELXpJh7B6jwsCJ2GuzS8iDn6GjVww9C0Tt/oDqceIyn3bHQUjJn?=
 =?us-ascii?Q?K50/kmhPRELkai9nw+QHIOxr4pC0m1l+TpDD3hH4lVGi+6eqS6icytTRRIvG?=
 =?us-ascii?Q?91PSFu1vzxNMaGg/4RNl3yAo6rSaWAAIZ0UDm7ZfJTGqZO7LVxlmG8iQTlWL?=
 =?us-ascii?Q?Orz7PIq+bLImocS9G7dTYYpaVmETgRyKU2e7R8M4eukP7/eqCjuNXsCuqDn/?=
 =?us-ascii?Q?cBmAr9FM4tG4jU9RjbZbypmVgSQ4mUBHuxpcqMtphiymSp7H9W7LTn4TDdDK?=
 =?us-ascii?Q?AGrJWeEPQ0x/HcgQ+srI8LRlvaJ8ItseTmbA6BSWzWXOvS763TuKDlQpycxQ?=
 =?us-ascii?Q?+fQi3Ba3WIXInhHmJtKt2gWmTfOESGfnoXovwyUsT7UoUIHEOGZZrEqikhGD?=
 =?us-ascii?Q?9SWrReOqTDUCRb675rosFgrY6LKSTysHIC/gxaFEi6EtvjES6XD54KXDKyLv?=
 =?us-ascii?Q?CHMX/0U2pp0CMwOSs4qMgwsn7j46PTej74e5Jx8vNGHklxzVRpsp/9ZNaznb?=
 =?us-ascii?Q?0tsFg9RNm59WTE5oirq2yK06hwZlBquWo4aHkAl3mTtlJCUnMQuxB1mbzhDd?=
 =?us-ascii?Q?cpqhyPuuy86trnh7ikquUC24ByW6yd4pf/fHboyGRz3P8d241KTIzFPXGJs/?=
 =?us-ascii?Q?sCF73iyKR4dUTE4dzjjhSQ8EN8qBrE3os/KP3RTTn+lO7XFTMdVB3hWLpcXR?=
 =?us-ascii?Q?iDGJ81S/9UId+0/R6q3ANjuf9nqfxYNj2fE8g/bedGIdI9Ayy4VtWbxtdA52?=
 =?us-ascii?Q?zeDr+xeBpZmLApAAp4KuX+rIjeLRcJGces+r2bU6HizZXu2PlH7lfaU5qAaC?=
 =?us-ascii?Q?Gj8PGZrSN6oGpYmF7L4XliYhWhgO1srszBdjRU64CTW1DdRqa8oiBICybAsl?=
 =?us-ascii?Q?4poUZk4+FaoTBQbAqChTpcDJhzTa4XdYqSpu7BUAl/OALsVVYpNnsj7ApDuQ?=
 =?us-ascii?Q?46gm5kQ1NhubCzUPy9d+/qW0nzGVbZTGm9xoMpGGA8buStJqnblLVKqnHZwr?=
 =?us-ascii?Q?2kU5mpD8XDdOhabzJbDPLSYEA0Ji66j0QchDFXCCFtjHR4tiyjKK6BiT7H7H?=
 =?us-ascii?Q?e1+xNQrPRNLHVFh1JhL3qUavnMUmatGjsTFJLRwza1H9flToIYUlLE6EMUQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb15348-1671-4030-db07-08dbe865e127
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 18:40:47.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3713

Multiple files/programs in `tools/testing/selftests/bpf/prog_tests/` still
heavily use the `CHECK` macro, even when better `ASSERT_` alternatives are
available.

As it was already pointed out by Yonghong Song [1] in the bpf selftests the use
of the ASSERT_* series of macros is preferred over the CHECK macro.

This patchset replaces the usage of `CHECK(` macros to the equivalent `ASSERT_`
family of macros in the following prog_tests:
- bind_perm.c
- bpf_obj_id.c
- bpf_tcp_ca.c
- vmlinux.c

[1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev

Changes in v2:
- Fixed pthread_join assertion that broke the previous test

Previous version:
v1 - https://lore.kernel.org/lkml/GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM/

Yuran Pereira (4):
  Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
  Replaces the usage of CHECK calls for ASSERTs in bind_perm
  Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
  selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in
    vmlinux

 .../selftests/bpf/prog_tests/bind_perm.c      |   6 +-
 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 204 +++++++-----------
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  50 ++---
 .../selftests/bpf/prog_tests/vmlinux.c        |  16 +-
 4 files changed, 106 insertions(+), 170 deletions(-)

-- 
2.25.1


