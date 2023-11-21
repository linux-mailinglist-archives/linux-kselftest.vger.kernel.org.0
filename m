Return-Path: <linux-kselftest+bounces-349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67797F21EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 01:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6062F2828C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 00:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB71385;
	Tue, 21 Nov 2023 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gLPUfmEy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2076.outbound.protection.outlook.com [40.92.91.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0063497;
	Mon, 20 Nov 2023 16:03:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVO8BJXuaqtKcJstbFz0qIstl4Wb5SAAxTQQe1Ivj6XUD67gpD1wk+HwPMILk6TKpTk/IR3hnWZb735MsfHOuuE9zz1y/Q65dUvAJJ7YH09yzav5yCE0Kz3esVTDg9MEA6mABH3CUQ2XIDgh66yYtr4kNsvjjFEWIZHBFWSqg27hrH6z5+dJPIX/WMVp3HK+gZdLh1uV0mOXXfZuZ08yQfuTsgdGcCqKpEuj+sRdYBlcbwYHZ2s4bX9tbvyzekUrZHJZE33zD13zCJIuSn1rwMST2cJynOg/l5koddrKrpCB0ZcEr/HzXZz6VVWTWNc6Ma0FI4eyOsIWbrO9CtWXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL/wn7ek3J/d0CPs0+AsqMukxl9/vjhVzdFDfQgj/Q0=;
 b=M/onqgvToQpZFQrj6YESqXyOze/2HFs/PWZYX2t2mQ2JIP32LF9FgLQ/HRexbgMWcnTqOUyjaji489InnFn0N0S4uolWHCxT11IRN81WQUJsGNtMQkYruF5r6VXRfPzMjuj0StaKHFFvqNiFYIVa+C3Y6P4KYBclbNF3kw2NSfj5e9FpNu5FvbBtnqTpJ4IV1kKpW7RcHfNooONU43HOezp/+XJCE2W8FyPoL0qL0/IzTgwdIRq0qpRmBTqeg2VZM0jaahIltmq0cZB/OOhN176rSdXOcbtQkfjXlcmGwc888R6eeT0sgdHyc8jqaO3FyBPchfDA0Wl0ofC14wXMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL/wn7ek3J/d0CPs0+AsqMukxl9/vjhVzdFDfQgj/Q0=;
 b=gLPUfmEykYQRbnpb0WnQHXFVS+5IDKxWoLqHNv6fBeWiPdJmPqz47cy1Vv1NckYYv1VdzY9C0ueYunjYmUlrzE32/Oq2gAcUSPsBvTNC4N0rkxbZMiSa1skMdUDsLulAbwdB+hMszq1RGz9ISsZ74hb16MkWldfkRlaKQ0QdkfGx5IAT73/HHgTAonscMUU3+BQObtbdCa7HDCWLl4b9+Fbkm9FcmsTpYUjlbh55yxwk6tuGKCSZrP1vVyuHp0TyGHBF1OyY5lut3twwY+xljRuHmor/lJUNNXO9A6uIx/imnF7CdJMh3Xv9Dj775ytwLVvdjDOQwGe1mlCb56C1Pw==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by PAVPR10MB7444.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 00:03:40 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 00:03:40 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	ast@kernel.org,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	sdf@google.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v3 0/4] selftests/bpf: Update multiple prog_tests to use ASSERT_ macros
Date: Tue, 21 Nov 2023 05:33:14 +0530
Message-ID:
 <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wiZBkUxM0L1MJd/m0WZS0o8LfjZvW86N]
X-ClientProxiedBy: JN2P275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::33)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231121000314.421019-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|PAVPR10MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8aebd3-15c2-4919-07dd-08dbea25513e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hPenmBiySzQvzLdtS+sA3XaakzmfVtbHcieZjgp7UMndmok+un1OJd+seZM76mzneOA1k65+k98ujFGJ8sDQwzEpXIM/+nlsyQ0mGMTGODMNOEg7ycg5EBFeDarvAqrS4jaRTagw+WKZo7b8qJduuNpa6fLBJkqGCI3burDVhY/m4vT+QuFfloTnIQSt3+aGnspTqjVAXrmgnPgqj+wO/6QC6IlVudZe9PxDkq5XBX64F7lRf/26wPg8jOTFxpoZ6mfXutPJVy7Ni/oBpSR2GynE68qgSn1Ng1MsSB//np8I4jc+txjhhlXMor825lzuNHqtWeuntxPHGRFc5T1h9nnvOB3k+a0sI4TW8YjHYY22oT/pOb8ClokhvcOPx1u6jrY5NGk29BPG0tymJUqED7S2Qd+uBWLrysopkL6q65rOOy7XIHjz0xJm0jIKWzYBe5bG1D0Hg6Wh83hPbsoZiye3x6KNIMiw6wnU4qMLZXrANQI76GN8UCzwR1FJVnTPuuAxGG2hnffF4tZOx9faK4JcaYk4Alu4rjjS7Rqc1jUlG4Y/vLsuJpEKP8Vh74TYRG42TEceUKG/cwCjP5PtW8rhuDFwWnUebZmbQdd0ZZrFlk8P3ZMPelogvDVjJJTG2/tp/aq5MiBmfPgqTbhqpW6VyU163Rv7QBm/MBoZvFc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/LMXkg63D0lHD5B1D7DHbmec3IAFUafbLLRfqwJO6fzFXx9UI6Sk9+/xjvN?=
 =?us-ascii?Q?yeKnZKfTxif4oK5wgYCm77kDk7CSYhoB+q2iXWy10o/uhxXBq3oM5CXfCh6x?=
 =?us-ascii?Q?WkPH3RqgXUEW98AbTP4LNCfPTbqAKZ5pRP17+Ws5s8A/u6erTNk93L3dXF0g?=
 =?us-ascii?Q?TBas3YllS6SK8T91IBssgGSrYl2JW+UY6wFpMawVXMvO57/iprABi4Ls8X5E?=
 =?us-ascii?Q?cERdT8uPsjQSEcJ6BA60hsQFSALAMuYvT78iSA9OZ5YHJeC7LzwhISVzn1UK?=
 =?us-ascii?Q?6f2h77laXTP/MVwwuNufqTz1izkhkGdPGAbZf9Y6ERRRFKVNS0dDEsPGNzrh?=
 =?us-ascii?Q?Tx5unOq5qcmBJphAf8CjEmWySqxgeKp17O291L97GisEnL8zs6nnfbW6iATy?=
 =?us-ascii?Q?ipF0UY/KtsLHzJhLEtnveYVr24RGC3+nOTLnD+vqMZHagrLsc1HliMcXbm7j?=
 =?us-ascii?Q?jpi+eW84LsVNKE8Xow3vACLEK7XpPsk8FLGYj04iCQ6pf+Bf/VTlxhKb3a3n?=
 =?us-ascii?Q?wNf7q9ig+MQVy6tlAYiGvl9BcrKjF1WyOD3MmckfdaBqHiin/V3mzfA7po3g?=
 =?us-ascii?Q?iBhAgKcnRDzL0Mp/1Fdj6Fm3DZRSk9f0HC2lq5qyr9l+ajy/qzd2x690L4WR?=
 =?us-ascii?Q?ikpFKGHwPfythJtYaAG8xlnsD2tTeGFR/wA23VA+wBKRb7raIUfEbcwidh24?=
 =?us-ascii?Q?4aMIhH2qadgBxccqUAviDCioT6dFiy8eW1Rh+2uAK3luKHAKPMR72Fwbkj8A?=
 =?us-ascii?Q?VAmlP+46di1Rq/7zxRSCMytxm3S2kfOYbpprbhHzPbFLJhMQi7qBwNABngEh?=
 =?us-ascii?Q?9oLt6Ze3xmuaE4SrplO6FiJYNoUzF/NDbu3oDd3D34pTmyi/bG1WVoOGiWfQ?=
 =?us-ascii?Q?kbZjAMV1vP/GyJ6VYNG1YUiPeHK4goWksf/7fMz52CrsKtepyJadUgOFgCgu?=
 =?us-ascii?Q?t1WQXqxO4O4CBpZ35IdWn7h0m4iLfK8DQLKw7yx7WkiG35tair9lcOraS2Ou?=
 =?us-ascii?Q?pudtO19KejuPVHAfAwm6g3TZ3YmPVek6iQ09jbu3tRibyEcBwxYppUPlAqj2?=
 =?us-ascii?Q?8ALUCHWyQ5BFlLC6KKHSjH6zpVg3idbsJXxGm0nUhmqxKLA+jY9fjdPX+3z1?=
 =?us-ascii?Q?iUYs9d9Faf5I51hmmRO7W/+x3CxMAYGTFr/EervKFNbVMZrta4mNkyQUC/Qh?=
 =?us-ascii?Q?rxz42usHrwLgmoL0PSgLtTg+93dF4Jenj13rH2x+JKRNZkX6wopBC4NPzsg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8aebd3-15c2-4919-07dd-08dbea25513e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 00:03:40.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7444

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

Changes in v3:
- Addressed the following points mentioned by Yonghong Song
- Improved `bpf_map_lookup_elem` assertion in bpf_tcp_ca.
- Replaced assertion introduced in v2 with one that checks `thread_ret`
  instead of `pthread_join`. This ensures that `server`'s return value
  (thread_ret) is the one being checked, as oposed to `pthread_join`'s
  return value, since the latter one is less likely to fail.

Changes in v2:
- Fixed pthread_join assertion that broke the previous test

Previous version:
v2 - https://lore.kernel.org/lkml/GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
v1 - https://lore.kernel.org/lkml/GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM

Yuran Pereira (4):
  Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
  Replaces the usage of CHECK calls for ASSERTs in bind_perm
  Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
  selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in
    vmlinux

 .../selftests/bpf/prog_tests/bind_perm.c      |   6 +-
 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 204 +++++++-----------
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  48 ++---
 .../selftests/bpf/prog_tests/vmlinux.c        |  16 +-
 4 files changed, 105 insertions(+), 169 deletions(-)

-- 
2.25.1


