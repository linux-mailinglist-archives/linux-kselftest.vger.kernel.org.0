Return-Path: <linux-kselftest+bounces-16399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E878B960C61
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E391FB28EF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F021C0DD0;
	Tue, 27 Aug 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jC6m2NcK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A419D076;
	Tue, 27 Aug 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766031; cv=fail; b=epBiXC/IoHZVw/5Rr4yg8se113IbG1/SG6yz8NTZpS3VbxQXX+oEFqmdVr95PvwAjkqX8gbablcocTp8kQ/t8wt7oqr3BwHGA25gTDTTWbtnpDwTypdkv2j3ir/2eQl6o46b54+2AbS1XOCD23IFtXZ4/B+isDYILC29AF8sPiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766031; c=relaxed/simple;
	bh=BFqWpLOoAw/8Bd699TdfwxHdwjHP6U8HqIZEcjuMvag=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KDuibinRcCwvoN0tcfZOberdamTaC88sA5IA9ItG+CH2wjSz4EVAWHtQx8XHLafz3GwxMouWosLzOO02GyF56nxd79kEPHBy9y3hljFAnzQwqhWCDKob/77Kl8ROrFxVcMqFk2CnTjIIEeteU1OPvdsNBWMdM0srcBxc9pgwvCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jC6m2NcK; arc=fail smtp.client-ip=40.107.215.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6VJF9VdhTygyOYDAUsYM7nzqnWTE+4T4r+q2rfmv0X13qmmmw7XeXjQ0v8AnCvmsqAY2hp7dGSDs0LpI5hUmOFF/24NKQrnnegBxFWe3Uch30GLP35lFeEBkMpUOshtT7UkAhAG1WoWA+G+pITCEtDVxxU3lqL1+C7EuiuQAj3/hbB0jnVy0Q/45HIBa75e/bx9z9IwhLME+Mx9xoDm3oPOXvs5dO2OJguLf6809L549Xopqu81yWszHtMb2VlWyFrodKQf6IbBnD3CJ+ay/te6TM9G+c22ECHD7v8uAZK6paM7hHzQvHn7BBVDWrvLoxd1ogS8b8uJn2i6QGiruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWjx6iKGK+55ymShoGdmBxYbbNWzmGzYX88IH8Zmqt4=;
 b=nLX39ETX3lbQfWTeu02TlqpNaoqQf5ZzvRbzqwLzau7wwI3mzI1umqVFjRJ1L+MMGAIPJY58dY0DYH4nlJHcT5x4s5RSy5MBY5sD8qUzoMvdzwaoySXZIdWSw6rb6QC2DddjxehefsEjB/DMXT6PJqxUYeU5Ft+onFMWc8VWxQ10kDiVQACFSFftDlJ1Va7hnOssYls5GC90izUt1+loqMhXhq2c6gbkPFp1gEXVavO3c7qsZqJ0bgLenU5lGVctI1RD3AR97GOjGuo+lH1xLMaUg33+6FG0BO7jtd7uZgQGgrsUzL7KwKAauAHWTePerXkV2Xi/KxA/ZcVuXO95rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWjx6iKGK+55ymShoGdmBxYbbNWzmGzYX88IH8Zmqt4=;
 b=jC6m2NcKCo96+e1YC7MzduDYGV/2qey2ru5G151oUZtnIU5OF052D0C4mwzEtTRLedqltDZn8wCgW8qzN5CAx0lbs3ydAu/xwmyKrmcNpCQrSBYwevuu050lo+63YJGu9G3+mDtObikczQEJEz2j8u5O9koF4xNoRDQ4CeeT6W18/eN0NCx774Fq7R0noykA4kvIid3rOZNAyNtujcaZSwHNu3w1+nRbGDI7Ls3Sk2B9U0hLrquTqWz8Jo2NYGwBwcDx0Bn28NEgsEdpjcZvwjt89ZRKlW1hzH9+XVomcO/IGsbC3ulaZqWYV7FTnFJ2LDqIHei9FEKQ/bpsVsUTag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by KL1PR06MB6791.apcprd06.prod.outlook.com (2603:1096:820:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 13:40:22 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:40:21 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	yikai.lin@vivo.com
Subject: [PATCH bpf-next v1 0/2] Enable vmtest for cross-compile arm64 on x86_64 host, and fix some related issues.
Date: Tue, 27 Aug 2024 21:39:57 +0800
Message-Id: <20240827133959.1269178-1-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To SEYPR06MB5913.apcprd06.prod.outlook.com
 (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|KL1PR06MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0903ef-ea16-428c-d502-08dcc69dcba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VWMER94a9G6u0FDG47aWquHJTTHYMEy5DPYn/OfK6+feHP/JsKbLWKzOLdie?=
 =?us-ascii?Q?j6zYKRMKw+3GaeAsGSrzunE5IiJ3l3L5Fe4lt7lvwK+PbEFhtInx9xCXF8eY?=
 =?us-ascii?Q?V6bob2+hHmtz1QadqpYzFLjeQAPL5Z0w7nMi93A3dE5LvO+Jqm4P3f1c1yXW?=
 =?us-ascii?Q?qQAE3s9/jzqW2P0NYURWhBFBtb2lXOU/h7kNPNj0ZX32oxIn+BUkxH9zXkln?=
 =?us-ascii?Q?W7gpI/kaazU8dBjvEWdlKlgwWPZfH6x7I7Fa6ysCBc5pDf2fotgevbfEPuHR?=
 =?us-ascii?Q?2u1gjSMcHTf6VKs8XXzfVVOY5TtCcjwWbZ/Yefr0PbHaEgq9yrCr7s4Sy1ua?=
 =?us-ascii?Q?VVRbSC1kn0L5mZRPcZ0fQZrRk9/pLaWVXZ2NB2hkamGZNfhyc8wZk/iL/ui9?=
 =?us-ascii?Q?YsrWVeqFaTtSpyj7zLTQH6sLSinFoGjmM+A9w2agekQo5xAcMVEN4ivwsPol?=
 =?us-ascii?Q?w8sI3/bvqgBVcE2gwC75IEjuSBJ7dNsy9Tl3cr4QdrMsSdJkl5M4Pg28Oqfj?=
 =?us-ascii?Q?Zpz67NrmUrHxvMC1KU69byAHVXGesB1vLnRfv0u2N90tvpiHWMRBNJaSQwSK?=
 =?us-ascii?Q?LqQao4l4CL5bFM9zN20Bw+ltEOaWDlqsIvkfn2eYx/JSI0UUZJI3dUKq95f3?=
 =?us-ascii?Q?ykyGZ8fdVcs6krELYI27Z+emwbn1pNQtRLU4gu56/cGOmpd1f27+HriGF72B?=
 =?us-ascii?Q?lWi5TLSGapJN8lnGbZDnwyiZwl5nlDuum6Mp15s6SoQlAiqtcv6M6DtNVwaT?=
 =?us-ascii?Q?lQrLbxGyjoDJD5HF/cqWA8d95IjiCtBvVQ3gqSSLB7AhVcO7HR1GxG8aSUKa?=
 =?us-ascii?Q?3xgffqeW3aOzFshE70hCy4bDCZBtyzCLZpk6J35oI46Awn3cEL3C7enSynz1?=
 =?us-ascii?Q?ssdI61mtwGqQUE8h3kplRigWxzVD7KbCq3QMV+fqh8qT8ZAPr9DzpKDNpx4R?=
 =?us-ascii?Q?EXo5ZsTHk7gzgoA0dDnu572nT9SeeWE7ybrbVrxKCUz9ypdwF5HoUU9H9Ix0?=
 =?us-ascii?Q?v67ywqrh6uq9i0lVKV+lcU/eGCjM+CKYp84Vl+Q/ema+ipiPNxCl4izyVJj9?=
 =?us-ascii?Q?xFXHGekzBco2XZwlcNJ//vKDn4pup4PxQKUG5eP9y+u8459X6IlH9RJd3k/G?=
 =?us-ascii?Q?HldfiB7vuKVdZWi5/l2akwMBLp2V9zJQGhowiiiWo6vuh0aWKdeLxUAACemY?=
 =?us-ascii?Q?Sl92gmZAFfan4GXuwU3Q0QSYCVBq35r3oU7Za+xvOT85Jgf/hYcxMfJPGmF6?=
 =?us-ascii?Q?vicQBE7IXADumPQfy6OqSuYWKSOrewSVeCrF2O0ZTPpNUrXx097mWYcfqDXX?=
 =?us-ascii?Q?alVqNwmKLmBM7AH77jpmyFGnEDFx4K7eYlem3NtuuAYAddu3k6kLF/vOboQI?=
 =?us-ascii?Q?O1/45tH8RgWuneGv4PLuWDQeULtobxl0+uXGccNf+zP8EuLUkrg/wNuU6Stj?=
 =?us-ascii?Q?et4ikP06A3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DBnDDd/NKJIcH+b0bRc8T1CIX17+skr1I82+QifyqT6jYVCHYbC+s1To8lhp?=
 =?us-ascii?Q?sNbR4LU0ycNTwYOKNCcaLOZV9jGG7CWVbSISu7+JHAiCWjmvsi7/Rqq5o5fB?=
 =?us-ascii?Q?HsBv/V6jAUvcPUOAMVO7u1z3ka+TVb4XwX2s+jCxN5M6t0oqVwLtJjL/KhoR?=
 =?us-ascii?Q?81Nx64LyBaZJRVp1hXOIWQqWnczQ4pZJRQNvMEjxJSS+hhcjJ/7HubWcyihs?=
 =?us-ascii?Q?/9ibXNgsQHwt652BjqlGryv5DYKL/Wc13VNJRDDfCmAM7qBClQY6u2DPKdub?=
 =?us-ascii?Q?UI0l7F3v6jTtQMC9aNoQZGpGG8PxdtjoLOe67B25CK+PX7BTrAMyTomzr6dL?=
 =?us-ascii?Q?EWVpQ/T/3vTrh8igMrvB2NsyMv5p3VLnxhxQ09wiHmoLIUCzMLeL7Rv1pJfK?=
 =?us-ascii?Q?rK08jr0a/L7Kn3Fi7HqxaKjNdgsAlz+NmfUW/rZBzRAGujNYuOKLHV5SoZHG?=
 =?us-ascii?Q?WmlQ9e0T6SRA84rBUm59ETMqKw6GBiLPiCz0w+UIi/LjozuCg9hF1ewJM2ub?=
 =?us-ascii?Q?MXEz2rtirf5DWImJUqR71n2kwsEGzD5n5jYBns8B/jXYKUJbw2aiXeqGIeJc?=
 =?us-ascii?Q?dcgZZqy+q2rYvRdho6W7dINrN0LfqmfBnz2py4yz3wpE07/Nk51wIE3EgnGP?=
 =?us-ascii?Q?Xhk6ES3nV/trMEQVHfGgSB4TBuvxagObmkWv4/qNuilTqYLJEwnu5S7kR+CV?=
 =?us-ascii?Q?1rQHZCJKTnFFjs2hcGdl5Ev0HlMNjfoQ4pSte7jqOetbs4Nq+JYo4sVwJHQ2?=
 =?us-ascii?Q?chxMVYRWNStpO7pw91uS+qa0qUpHHa27bI3jBIAteQ0k0rukkb2sfs78g+oA?=
 =?us-ascii?Q?2SVL78f9lHcClm6N8L03nL25syRWTs8eUGHDbSp3jcj4sC5FiR02MRN44Hij?=
 =?us-ascii?Q?m8d6GVJZLXG9DYSKOf4M84maDlmeeGaE/evGkAZ1VpkHXt/fAhnpRGoBrgWe?=
 =?us-ascii?Q?EjR6t88640nDOeGJtTac3MLSu2ZIQOaVGTIZxGQDZpNVinDif49yX9ewZKEa?=
 =?us-ascii?Q?eTH+PLo+I1Pz9LMb2Kp0PqqWd74ggYQVxY1gF6fsI7tWWXFOaa4vBVvuC738?=
 =?us-ascii?Q?kxrZxWczq1ekypvjkdbrnAmTt1MjteJAwX3b9Cv++3mjxnSGXDrfL/W4A3t0?=
 =?us-ascii?Q?1NJyfWR5mcJU6wuBuDKfOgEWqfbRv14yeWpsM5SYeTJ/m7tGnH43/XrFW7uF?=
 =?us-ascii?Q?RYD/P6ypI6tt4OcO8BxQiavB6x0SDrvZAtTLXQZDthVotN7L+mEdypjQFMUq?=
 =?us-ascii?Q?kH3S4AnECbfkAsjrvxP8BGC5F84JXJBsyU/PClKTWVuIhaFPUJTtTl4Zavns?=
 =?us-ascii?Q?lYefew9+v6wubMIhrw64GBmE7wvNh3sCqcBotxny+xgb9hxP0EDCTul2x8uP?=
 =?us-ascii?Q?a+015ByV+NdZLuDB8M80x/uEn0r8RCknCy6A2nOalf+p0arMoA7+Rzap6QrC?=
 =?us-ascii?Q?llhzQAxGpHEs0UdCNJB4ErdhmhAbL9YBHc4VkY98aTlQNlyvFxPvBKKwurLR?=
 =?us-ascii?Q?8W/rYJBjfYxyvBZZR5C8d0qYngwCb1BA76xvYazH9F1OCdaUt96qdzO6e8/8?=
 =?us-ascii?Q?mStsvHWRj3O8IclqaKC8KD+g3p1qiavhQyRBCaFY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0903ef-ea16-428c-d502-08dcc69dcba9
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:40:21.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxXjN1sP2/eGQ3S7kktBlA58e7TzB6czJe0yQQcrstx3zPSz5uRG4jSRTAMQ5pA3e4n4HW8/lVDeXEoHTeDMMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6791

Enable vmtest for cross-compile arm64 on x86_64 host, and fix some related issues.
I have verified the patch for x86_64 with the target arch of 'x86' or 'arm64'.

v1:
- patch 2:
   - [1/2] Update "vmtest.sh" for cross-compile arm64 on x86_64 host.
   - [2/2] Fix cross-compile issue for some files 
      and a static compile issue for "-lzstd"


Lin Yikai (2):
  selftests/bpf: Update "vmtest.sh" for cross-compile arm64 on x86_64
    host.
  selftests/bpf: Fix cross-compile issue for some files and a static
    compile issue for "-lzstd"

 tools/testing/selftests/bpf/Makefile   | 12 ++++++++-
 tools/testing/selftests/bpf/README.rst | 12 ++++++++-
 tools/testing/selftests/bpf/vmtest.sh  | 37 +++++++++++++++++++++-----
 3 files changed, 53 insertions(+), 8 deletions(-)

-- 
2.34.1


