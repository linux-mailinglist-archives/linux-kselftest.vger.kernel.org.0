Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1C76F95C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 07:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjHDFKH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 01:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjHDFIB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 01:08:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C42D5F;
        Thu,  3 Aug 2023 22:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3gd2y1usb3YXK7gICPMAlQ7DTsi00yexxbTyNKTKSxH0sqTv6bhsJfUrJe1qo78RIRaKU5cnVkpJkemDwiWqMND3FLK49n12P3/nr+8y9XEQQjf2RrdsNbZiWRkazyJBaopSorhrxevNb0KJmRy1w2va6slRo04WS/wa25LezwIGuRO0EVMphcKE4hbsMTME3nkBOgExvGQ+AGXNwD8caNgoLizkRlMh82t+TlNqPiisjR028cyFTjLiR+deT8oPaw4C2yhyKlNfRMm1F+Z6OyL1FK2Qo5g4DT18q/IW19uPWI1PKMSxBvPh3SZydnGacsx8TeA1ilPuEL5V8+J5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHTWD5WwibfCNfatfe/o1L4JL9TuE7410T4Cf3XxDWM=;
 b=VlIYxWbDawp7wVlfzFNkOnb6FbZVo4RI36w0sqqA7ivS8VQh7P7GFmka3qCQCJjfIngDZPgUcOYSULXKrbr2iKeAt6uIl5Vv652swz15CnqKdaWdtzJn5H3kqix2ic9DJq4Nlz29kafBmYewMoPtAEZa0dleDFjAfZNpmPROm6g1nO3iMUBK15OvDNvz+OodpdfzOOgvYFbHvfygv8URCURYjbMq+jgdwXGiWVU2L3GHFnNuTqMbalNs87A2hcUdfYg4LdHGefDlBCA2Xbe6wDmVodDBLPYejh6OCRjV7yO1Y/EvH+05dWOE9cXBh35HfNIYDMYqIJmESF7pzG13FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHTWD5WwibfCNfatfe/o1L4JL9TuE7410T4Cf3XxDWM=;
 b=4BPVTGACN+f7H+gcmaL8EY71sVKIy8Qj7HJQDJ9jsz1qAG1gjPjDaAuV6RR6GirNxxubXTvNE5yyOGdVHsGjOs4I+IsMtN0KFuoppIoaYMpxqsz7eigv6lG+JnaLUCG5qiQku+o0CUNJEaDtvW+iPKiEstD+gDp6l3fZGGuydc194LMLW7y6OeoJ6Q+rQ91eD6cThbeMcYGTzbkKChUa2ZJT7RAGpakyXKPxsZZnq/rDOYcwprVelVcaSQbT09+qbdfic1xIemqT/tCeSZ86ujETJRglLHP6w5XIhTvRbqExkmqjaxWWbx9ZXjyEM+cBa6K5hOYS9KrPFGIZWivnhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 05:07:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 05:07:46 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v11 2/5] selftests/bpf: Use random netns name for mptcp
Date:   Fri,  4 Aug 2023 13:07:40 +0800
Message-Id: <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691125344.git.geliang.tang@suse.com>
References: <cover.1691125344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 6457fef6-5076-43df-2ca3-08db94a8bd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSbN7Bb/c2CcQBz9mNCGpAzVJOwL/jv8Obp3ue+/xqSaTazURwomoMmYBoMj5XryW/fqyvpqoVzG7cxDJXysr4JScyyXIeLKSYhOWCZMSas5QmSXq7LLOJC6taUCG4oy57+Ewts5HQOmhl1FO/h5v5OoPQkCo9bM8kl3tfqQRkeS2IHdyh4w6+KrO1q0s9OtuULWHC87BiCTS7XK40dqxcNy4D9jpklHzOAf8Zn50rm5HiV4i0j71JLtq8dJz3CrQCiSVChn3HEYdB6QEDBnKc6yZZNm1NCTEGd0YHrsmoUcDd/2MPlHS5SpIaJJzERITGsJGw9Y7cLQ/4CU2Yi3SphGllnUlFteE9alxx44UKH1NK+mJHddM8h1Ji5UWG5Xm4M2KSXbINX8IobQS9WCqjdRubdcf7l8UlsLnDG/lttqqFn3CknpyvfhUpZFB3OWXICFpVu2rBqWcmpzGnqgUWeZzBC3K+b8QCaysgA8sgQLUb7yFEFYgE70lKOZnHfTlld7ivajkGCS5aRmChr7BrkLWKRz/3RfhH9BvdvpQnpBpjwYmB7LkDg/lIJLGyV8U8UJ02HLT86p8opT/k4eBqf0AXATF35GCMSZ7rxtVdoWmjtu5ObfXlM9ReyTSRjPgTsmWtqyR39FOolWfjeH4vB1lVMhMHASjemVUB2mDvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(1800799003)(186006)(451199021)(86362001)(36756003)(54906003)(478600001)(110136005)(38100700002)(921005)(2616005)(83380400001)(6506007)(26005)(6666004)(6486002)(41300700001)(8936002)(8676002)(6512007)(4326008)(66476007)(7406005)(66556008)(44832011)(316002)(7416002)(5660300002)(66946007)(2906002)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HhEUx/lGqelC1GhAyxJBmSdZtfyu5oNyUtqJ2Hkvt0m+LJH0XRBxbiPvQVHN?=
 =?us-ascii?Q?Vwve2vs+2N/u57YZsOh1kUaLUaHA7HdX28Vz85zB8CbRpaIN81IXM0nHeN2E?=
 =?us-ascii?Q?ai0PO6oOXfvTfIBtbKhM2FXNc4kLYgzrEd5IKcXA8iosyRuDRZNkChwxIHxu?=
 =?us-ascii?Q?S1fTI4R3vkAg63pqlDaFBGATrPjpiHRKpJWR6Tvs/hB+tpA4x7/om0hRHBpk?=
 =?us-ascii?Q?FFPoqhBX6n0axA5NINvZTvaj0keua34KdHSrHIKsj2w7TSUOPfTNNqCRMImy?=
 =?us-ascii?Q?o8bzzFahUE1n/SS8OjPuugza4HuZEp3RlTJo4ZU7jJmflEOH1wiBal7AQ5Do?=
 =?us-ascii?Q?KYRrJi2t3gpu7PzCfn2uQVjQLr8faeR45/hzvCPwlei7z7yWiaz8O9Bc9120?=
 =?us-ascii?Q?FgeJ/h+XMPORRI8ankJFN/5svZVI1j+xOqLzSD/WbM/RAMKixhswS5ourwu3?=
 =?us-ascii?Q?nKWiBATRJGs4Z6yNIEVF7W6KbFeH8ctJd/h+2Dvl5U+2CSAf6d6n4o853GSF?=
 =?us-ascii?Q?uwUKdCcw+jMwGEwxu4BwndlCNzwDqBDr0ZLtWsjwxNgZ3QcM+lO6cH6V5QXO?=
 =?us-ascii?Q?c6vdax1YFZay4s/0LdEFk/1Lq7lNhBgq41zFmUUxYH6vn2Ia1GENEd+/RFjE?=
 =?us-ascii?Q?UM39Sg8KmbRnUaawzI3EH8zxE47iBJIJe/d3oIoZLhvdKPPtTrNLfKRVoZEw?=
 =?us-ascii?Q?twuyUa/YlsEDbNpRBi0OV9HBl1z7cVwUUQRz1iZrPmUXAy7oBHQOHWjeM4u0?=
 =?us-ascii?Q?QAgtaXnvJFLycaf1lS0LfWN1jQxwhBt18xc2pqewV5CsmzgpCZ1iH3biyjMW?=
 =?us-ascii?Q?pb65y2HysYNQjzgJafxoxPISTj9QrGeZIf5DY9FxJn2InLg2afmlrT8/UnT2?=
 =?us-ascii?Q?9BrLOFIvc2fBWbRUWzvQENzOEl9i/NJMjt2PjtHuZdVY+7f8hqCo9HWkmwnK?=
 =?us-ascii?Q?XhaLtAK0AuTTs1WRhYBYxqiOWy0kgrR1evNn+OY9k7dNtgsycwTdm1qSCmlE?=
 =?us-ascii?Q?1jlCNNgl8tGJ7lrM2eUzGrwAJIlIzLlIasqx5ecOddvBbISLneWFid4U+wi1?=
 =?us-ascii?Q?FdMN8B/PRVmIs+/0LpxXryf9rgmrOQIu+L2n6Rht8pwwRaYLssd5sPgOTI0n?=
 =?us-ascii?Q?6Bf8eD5Fk5IvQnWNGgqNYz0TvQSMWtePs8kF586RgGE8A3UKfuCHJkigsTMm?=
 =?us-ascii?Q?qt7ZtCFOo7EkDvKY9j/JEqQTJNEE4ImW6KNQD5QVG3NWurdSjAoRVWtLKd2e?=
 =?us-ascii?Q?/dHmYPrLXXIfzZtxbt2EIIVL016fKdL6+5439juCCzM3COeeommYW3Hw3wAo?=
 =?us-ascii?Q?/78r84yyKd5a+qXGXSXc8qTTaVnyMscpuUaQDdPMKYVxjezTcxIUj1ZAsDp5?=
 =?us-ascii?Q?wGBvE48F+S7jT6EZ5jxw/qL4FHneRHkIMyaBNwC9V0XuUDV3qUKsZ8mpMklD?=
 =?us-ascii?Q?nDsxk6m2ruqSxyA6NW0nPmGqvjaf/gF/r9m7gvrPrYMfpKYVeYKM2y8T3FML?=
 =?us-ascii?Q?/crpl7+N+UTdDKWZSIC3BM+4BJ0e7CVtP402R1Ne8gsql9Y1QJSGK377GWd9?=
 =?us-ascii?Q?OzIiiOGjjU/Oi3G7G1vEVPFV4PVBwViViSIQtBXr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6457fef6-5076-43df-2ca3-08db94a8bd85
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:07:45.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmnQABBxMK1bA+PdiJkaP/PpAp90HghE3WaOvZ1NaTROCC18dgzFWo+FQJ8vluo81Jt3ECTmW0BcVJx1lOUlBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use rand() to generate a random netns name instead of using the fixed
name "mptcp_ns" for every test.

By doing that, we can re-launch the test even if there was an issue
removing the previous netns or if by accident, a netns with this generic
name already existed on the system.

Note that using a different name each will also help adding more
subtests in future commits.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..4ccca3d39a8f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,7 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 
-#define NS_TEST "mptcp_ns"
+char NS_TEST[32];
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -147,6 +147,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
-- 
2.35.3

