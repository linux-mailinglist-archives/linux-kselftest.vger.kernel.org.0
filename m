Return-Path: <linux-kselftest+bounces-9491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E42848BC46A
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 00:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6BEB20515
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E6E136E2A;
	Sun,  5 May 2024 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OYKXpmN7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F663613D;
	Sun,  5 May 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714947254; cv=fail; b=rPwzmkwO/gcHLzd/pcAy4cOshYz20ANv1drJDhbK5T0GkYdJiBDBHS1uEFDB3BXBwGiOJ1yHQN2uby2661dHigcV/PfGqRJbBKFHeNsDkNdm3/5r6UJ3TtmgF9eK5QN9BNCw+aNqiaYJvM2RnLPdsr/lzgs3uy67mWuII0K4has=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714947254; c=relaxed/simple;
	bh=ojs0LZYusxWXoyDMTnrDIbscb63rEElQry612wWdPew=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fkky0mBHJ4K3i/hMoyevTjtGo69Uf0XXkcRytYgAOI/k5KztyPFUuqvMwMW7X4GSJYerAAMeI4C6atWEBtIvGeu1LjzoR9p9UQkq5M5sU882Dse6tu1Jpw+TMvmKGCWHHXq3VVfYunH1k/NASIREjALconTLXJzV0LyrIBCk3AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OYKXpmN7; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXItVHGEMF/EsOKocCJ6mt+oOt2KVEqz671lK69tRd9Ij92xG3A6+g24AzmCmGEGaTuTxoV20pnOHrP0cUTE7Y5mzeX3LLln7aZ0FQBrOh8ut+KR7WaWK31ioktyZr63MxW+JeQvNV0nAtYaFxFdTM/VKpOm24tznxrHYmurleUe0abP7/RwO0ZgwgqvK4wnptyMxbOcHRVLs8HO+gLQaEDf7pc9d85WLOKJtmJNOtJnUxqHWJght5N4QeaULrrUYJid7h6v4IxMGp0gDHyWdvJ/cgZarzrtj9dYGZW9ks92eT90I9eKfyrR22O8g0Udu/xf0yPgfhJX6WAzGIJXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/3L42+DSn6qkOSzB/6O0dYOFw/ElB5Kje+hUZQtVX8=;
 b=A6ytjS2MDuY3mFYQ3jG2xGOHst3Z09MosYKTOYeeJ+JDG1BGL5C8UgYgqjPHB6GpXY4pelKYFExIOtWLxvNnst1asUO0MfbyK4Nh8ocs0gyh/5oleF3E+R+v2xM1La4SpnIoHxA8FIIBjqq36V2+1U2Qre7YOacPh2awZW1pl0IrZa4kQHWHzDsd8MbsxVWOJxB3VlejY2fkJ4bW5jxKDmVpe09MmFY9f1aCFzVdxyt+j4KD7+996iH/l6Nc2t7pT8X5gYV4sOve83sOgYUATLK1K+XRfXy177n7OB0+9MkFCcNNAvmLF7hD0VVKLxM/vtdRqND/YLg5CcirPFHecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/3L42+DSn6qkOSzB/6O0dYOFw/ElB5Kje+hUZQtVX8=;
 b=OYKXpmN7x/ysROT7Sj2NyqFxcDlcjWJyBiCrjAJGeuVoAvdHZ1woIQoCT+XkNkPzT8oaDvkgSJ0zTdEpr5n9n6L5XcLGl4I895p52zXgE1Q0sOozb+sqcORJIsmePAYMSOY1YSrThfbtJ/gutbDV87p0RUFfxU0Q6+8rn05YPgDXdMDFJtpY14KE/1Vbp2jw4wkAnWs08cHk+olcSTxbnJxuuHcxXK9Bs8cdxdtrNAcGYv5kn0v6VxpabaO17jxbI67BO4XJbW3lfXNh4N7WfZjTAJopA8QnokQoUWfejpR72lLs8NOIsulpG+VW95mbqv/9buvI1csH91FQ5wO91g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 22:14:10 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 22:14:10 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	SeongJae Park <sj@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] selftests/mqueue: fix 5 warnings about signed/unsigned mismatches
Date: Sun,  5 May 2024 15:13:59 -0700
Message-ID: <20240505221359.65258-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d91ae8-7884-45d9-717f-08dc6d50b020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+0v86W9NccfiVjCm3qMga8cjsC3VUfiaqz/tYblDLnhudExPvkDgGdKBw4rz?=
 =?us-ascii?Q?pdAq4EMwPvCpTAjeFZpnbwmVuMBLtqzooMeSvU2gP76j9XnVdox+P3t0J6mG?=
 =?us-ascii?Q?DGZ3LB7DrjRAb2Kyqk3DOCSKiJzzrWuUTmgQE2xB2G3AhdpK0BQQxfPs9BVZ?=
 =?us-ascii?Q?jZI6TmMqK5K7IU32CFwwwSesJCjXWH1C2wy4muxcsUhTRS58JYvoezvGkpAX?=
 =?us-ascii?Q?ByILohsC3wEzxHwA+OOff51r0+dMpZPxU8NRipIQUyvsIHsZmX/BN40Uyo0n?=
 =?us-ascii?Q?GXUSm8W89hhh9CjTnQWjbS3vneQR7byImfuJetlQZU0sYlRTnp5gk/d/FDpE?=
 =?us-ascii?Q?X3lGb14lM3Ayl+lroNsEsoLwA0riCLBoRsFnc/FtYi3QK/bIL9BE7d7824Tu?=
 =?us-ascii?Q?PPLrCRZwH3YaoTQ7gcNHBcLPlROS21QcTwPUf+CMO3vibPJgRxjvQMeEONt8?=
 =?us-ascii?Q?REWtTvHq07XpXBYkQX6WkFXrmpAjZ0F/wfiR/0sC7aISBQqDLHIrDt1pXQiX?=
 =?us-ascii?Q?4ZC+FON8BWrv4FjEzVkMG6mK1nDQGRmEfXq9K7AuBb87JGLU14zvdY037/3P?=
 =?us-ascii?Q?11lqMtV9oXti4Fo3bpkEMR48oPTULPOX43rHzBbDOtulFCcWw9g6g1O3poXd?=
 =?us-ascii?Q?wL44peqKEx22adXw92a1gnFF7+u3HEfS5lc3uBhWbAAJENEXeQW404LB/nR3?=
 =?us-ascii?Q?hpmiIspuPRh9m5Cvnl1wrXskkHvWPKM7ToO0x13U2fx/tPpDqgGY8mTXd/Qo?=
 =?us-ascii?Q?LFCim5p53zluKJ1IE2EB2ph5VO0BBoefHb5taivk18fJoRq/g8wMUwG59Ax2?=
 =?us-ascii?Q?HUrj1IUM8h07BAUXavyfFi1KMPIMqf9tj7zO7LvMlygmP8ZdMl9Zwk9qzEHK?=
 =?us-ascii?Q?kPE8eBVwIvkCMNp9LNjwhMy0mQFpqfk1CCvqVLWIvrUTGNdFwsRLRi0R1zEA?=
 =?us-ascii?Q?AwaplhTFHHA+xZhjoGhIlzyyEwLxkv4Dw77dWpM2gWX4e2q4F7ykwEq5gQ6F?=
 =?us-ascii?Q?v+Xtn5tvaX7bn085VienfzcG64sZbuj9v3QkfvO4B6r2yW0U/OpXag81QKF/?=
 =?us-ascii?Q?mb8gFw6OHfz+cH9tB5buavpkcSZvK10RiXCxnkfcs02Y0eJ4C7A+VfmlLwE1?=
 =?us-ascii?Q?wx8XI+2RdoXHcl0bIdaqhTPNUMzufQErW7vhq9dO1AOBZEdGVpnzwKjRqlts?=
 =?us-ascii?Q?eQV6FTZ1mhdnoA1eusaLbSw3/V+gwrB+kBJv1jR8t2VkxPmkGIr+aq4UYcls?=
 =?us-ascii?Q?+fIR5bnuW8W6v7aEB8/qS5T6zKp1CPDrb52ZouLulQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rmofv0yNDW9G6Tu3hXs85pC9gXW4/izFybgzwPpS+5oqFsyQvXBtEwjQRL7F?=
 =?us-ascii?Q?sKcZHA0a+XRSUyrvQKAv3rsmHtR//GN/4j43bV/1f8AKYzu9dHT2Qh9XjzkG?=
 =?us-ascii?Q?Bwdu4ToZIaKgLRdHQYA1qfArgIw/TEVbgT7nATfhU6ga/4tngdyK5AW26rwZ?=
 =?us-ascii?Q?NlYsGL4aKBCx36Nyzkfb+Byjp8mXFjnj57+P6QMLjqfJ24R3IkbdhjWOqMGU?=
 =?us-ascii?Q?sqDdtcZPSaiU5C7u+nqSM1/ljdNuly3MQXb1nvZMUu2FkAGsfNBkOs0jO5Dq?=
 =?us-ascii?Q?xldAT2KZgj79KRhElSwgjTUti0Y0SKOQ2Fn5x42pB+tiQc+v+RocXbr2LnW8?=
 =?us-ascii?Q?Cva3jv5d+R8OGDj4vQ/AEDt4pNRskkA3hx6Im6nsx4ywzDMxLBk6WKU8PYuI?=
 =?us-ascii?Q?4dzvf2uLV1Ed5D7ukg/rYsafgM+qKI+Ff3KXVPd0fEbIF2Wd/J0CItIM974E?=
 =?us-ascii?Q?8uXga0jmeMTmOILl6xS1k9bdoqdTyFcZnTnCn83rawmmya4CMc8mOGq4JT+I?=
 =?us-ascii?Q?DwKIjBF7IuLNAUDPkNj6uXR3AT0YvdR9LQeHLUTqRT+Q1dzFwVqS2dD+FnBK?=
 =?us-ascii?Q?duLC8FrWt7Tcz5v1GMLQm0G3FAMxlg3yuHTCrnK0zHc4SVWErEq7xOrBfrP5?=
 =?us-ascii?Q?VaUWLaLo388LhkY3yDOFtOQjQgIFjAXaYQnrWlrEc9W5GIvQ0Lf1L/b2+G7f?=
 =?us-ascii?Q?xRJRnD77G7UJmkCjakwM1qR9H9a+DchpH6KrzG8Y5ub+g+BVuX3K5AsFgwa5?=
 =?us-ascii?Q?mcwnAVOn8mqteM95kPAvx4OTk8hgDsrvnb3ojGP370AuL2rhzXvU9V5ivH8n?=
 =?us-ascii?Q?TICiNJPKxkqmdbrlMpxVmHr6cKSEY/ifqWyEUBGS3bhumo+poBDFA8aydF27?=
 =?us-ascii?Q?LKVTdYuQThVH1bgQna658Z3tfJgo+UqFpflOMCvUkDvuqSDCeAscyTyIq1FI?=
 =?us-ascii?Q?opyJ5mrv8ZsRV7ykEa48iRQU+EIohDYBdygbarF7GLKrgXINbjd3RnKKQRYO?=
 =?us-ascii?Q?sWztf9cY/vNlK855GPTZRUTZSU+mqI+Atl5loPp+p+iUVZHXhGwRGQfX0ZBj?=
 =?us-ascii?Q?uLL+ThqeDAPsJKEgEj9Bf7b8OkjbtIzdRwjK3Lht9uizuQioedzSc/iAGawg?=
 =?us-ascii?Q?odBZWcBiNaf4Qv8mfwZdPsRpBJcd9JK5Y0Io1kw6KqKLHrOxmIpXUEthLvjg?=
 =?us-ascii?Q?tLM8+o9is5N+0dtBrlN9R4LzXi17GqzjPSkbnAC82oh5dgxT+/CKmldDVhaS?=
 =?us-ascii?Q?cC1XIaDrf2DtfuBEKHnSDtcDd/BQSpjeV7dEIiFf/1PDsktgLrjghe1RTUkK?=
 =?us-ascii?Q?FhTN688WTG4Ai0hg3dSRRJnOv4VWh6MdENHUZt76DZaxM+9l0QFahELMQ6fT?=
 =?us-ascii?Q?Qv5vt/S4nQ3tc4VjHlQsuxeXwUMlxzD1XXXQB91iMRZtjVYig1wvdfI1xuKD?=
 =?us-ascii?Q?VCQqaQrIPb/5MnBk6CV8QsaNc+B4zLouRvhi9X7PmyKtMqPDsKC62e1DD3LZ?=
 =?us-ascii?Q?wpFaRyrASXRxIXHBiHxmtHTZQ/Yjae11+sd7eO05hL29+HzP9n3t84YEDr3C?=
 =?us-ascii?Q?ZcKLmzk6HD4UdaIRufPk0mQe9avrvzHzlqrJ/e/OhjCBovyNYIXv/pKNhC8J?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d91ae8-7884-45d9-717f-08dc6d50b020
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 22:14:10.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McmdF5QVhdUJPw26J8sYL9ETh+nuCjKLhlbsSGaFjuIWJMSjc7NC0OklkOROr0JU6tzOShZRN63eWd+OkgFNLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about several cases of using a signed integer for the
priority argument to mq_receive(3), which expects an unsigned int.

Fix this by declaring the type as unsigned int in all cases.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mqueue/mq_perf_tests.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index 5c16159d0bcd..fb898850867c 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -323,7 +323,8 @@ void *fake_cont_thread(void *arg)
 void *cont_thread(void *arg)
 {
 	char buff[MSG_SIZE];
-	int i, priority;
+	int i;
+	unsigned int priority;
 
 	for (i = 0; i < num_cpus_to_pin; i++)
 		if (cpu_threads[i] == pthread_self())
@@ -425,7 +426,8 @@ struct test test2[] = {
 void *perf_test_thread(void *arg)
 {
 	char buff[MSG_SIZE];
-	int prio_out, prio_in;
+	int prio_out;
+	unsigned int prio_in;
 	int i;
 	clockid_t clock;
 	pthread_t *t;

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


