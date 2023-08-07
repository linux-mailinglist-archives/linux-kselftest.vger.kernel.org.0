Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23A9771A2D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 08:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjHGGWy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 02:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjHGGWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 02:22:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2089110FD;
        Sun,  6 Aug 2023 23:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeoOf4zIx7b4TrxApMra4it9tvrAPOZx/pZVt4Xa6sRbPSiQlDQ9z1JoB7aJXGju4UBh9Zjk7Q1G3NEMOXuC1Eua1sEbQmmAP+TCx+ajSgk73Ma5bcToDI3v8q9I4mz0uq3rYce1rlbyqL0Nmv85wsViFUSle3hw04M/7rL+X0hIBK9BPsdh6qbZoZGfnadctAnJxP1+JkBbcSbL++JVxsPohkN/QEDN85Rhaq7KE70aJ7FanJeBf+pK+PZ6OZDDIBlNpuEJgwXamAYM1zjoMkXnlLHzA+IfXI4VBgdq4FmfcTvJ0v+ixLQ5BcdmDR6aXvY9C0QMpYj1uH1J640eUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClwnafzNNy3wWv3I3Y7MoT2F6aS/XaHX7aTcGzrpsl8=;
 b=XYLso0LXynokEFtpR+A/riYIMHdiqB2iNZsM9nxLyx9jdK8BvOD02kfU5qs9mmr95OPDOVZ/ia4LAi2ZY2v02HtQqmNCA0uHE6oSnFncQi9LQqtAtt5QT8TprM4VxkiKH2Sm5RRwbLgmREVvrkRS9UiL2kjngYODGAT3mKRfvSw3ceBcMCjgtD40RLPXu/QTrC5lb6+XwfI7odxvNJMZLJfHBRQuhez49421dW79HfeDwzSRowpVbK8hQEsWYTMDpmOxI0VEyKO0+ZfV5lVvwQxYqlvFAYXDIpH120DGrUrqriW32RlP+WwB2erPCz23zXqLCVsAzj9R25//ardZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClwnafzNNy3wWv3I3Y7MoT2F6aS/XaHX7aTcGzrpsl8=;
 b=IARpDRcqId7FjEMle7KAifSiz2gip+1i+WL/UI/j2ZOYfYCEfRkw6yFq7lfnuTH1f8oQWJwRABI5CiZdMM5yYz069r6HkQiFQw9w5+y1JJ56cVEK16FUJS3RjCGMmvGtEtfJLWb/fCLBAphXoLapwA6vlxp0se+g7TfxzTQ+lG4dTW3XQgG5jEnr3XTP3SlJLzW0BEvk8M6SYaken+tOCLkMYF1VKrmx2gpq34Pe7jgprmbzoIy/vx53PqeHFjm3sPwfPeRJVU/9bMeTU6DIkW03XZJGXCO4223r6svwahAsJrhhISDXuZ83FmSTzVQpcGO93Bx2mDdPMLyeRtPavg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8883.eurprd04.prod.outlook.com (2603:10a6:20b:42e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 06:22:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 06:22:47 +0000
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
Subject: [PATCH mptcp-next v12 2/5] selftests/bpf: Use random netns name for mptcp
Date:   Mon,  7 Aug 2023 14:22:42 +0800
Message-Id: <426ed18fcb9adb39bfc96cb444cc56636377c5f8.1691388735.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691388735.git.geliang.tang@suse.com>
References: <cover.1691388735.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f9c0c8-4587-4906-a86f-08db970eb783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qbx6crfozXx14iENjQv/Af5Pdp8wT9ADuCXmeNHWXLPHtw6qmQ7fmIafXTARTwkuVX4dw6ZiiPVxU+z3cHHWzUiXN982XCoLLbenlxIKLQpeErvrqEithTqmOCrydK/FIK8vTJtcLSCX5YbPzE6078zxWcD4shm/lYydbZy/wr2/u4cqPueu8WCDm+YobDptGNLqxJQDbVKJWnZldePeKyI0hK+n5h4FuiIuXvKMYgQ0yG2R/ETRsNO9S//F85pelk00pyl3U9tDawA/2vKsfWsyTDMZxAZds97UGAJ5Rf6+LfE17m2H4pJsSeeBDgeCI1Iok1NGSzeTxgwK3R3JvUsPZVKKqvxLmRlJoWIlzk7pHu/EXLfJ73NGTKee1t1rYZvpdZ7fxT1OSeMDQiZWLC4Mp7d9LE1ZTcD1vclUO7RF7hKEY+3aFLmlOJv5eMIqRvdX1h0ptZwSe8RaVdHfo6ndH/cN1yhLt9xn1+CUXIEm+mDidu0yq7WCgGtXEAXPZJOIPsteZCXdNeg+vs9/bP9+TQNS6f7Q5x9MryYRtssUX+uFqKjdaK9wvDqXKt1ZPECqpwFKYGPx38SrPRwcogeKiDCm6W1aK8Xo+qrVrdHrY3OPfyGHmQfaBcqn6wPz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(921005)(54906003)(110136005)(38100700002)(66946007)(6666004)(6486002)(66556008)(66476007)(6506007)(41300700001)(26005)(8676002)(8936002)(2906002)(83380400001)(7416002)(7406005)(5660300002)(44832011)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5AE/pGc8td7Hsw/hMI7IZUfhsO64GdXxCA9ekDZv6WRUz7239zKpu86XFq4V?=
 =?us-ascii?Q?rScbT7oI6eaOBXTt/m7bjbHVxw8XQYPILNhh+StepVu7wyBLeMWBV5FDcrLo?=
 =?us-ascii?Q?iBqClIv+qh2K34Qk+2vdUEus5s7CNdwiP62SJQUtZwrixCES4/M6U+eYbl4P?=
 =?us-ascii?Q?IVTT5U+qd81cZIsiKhGbAKEa75ZmBNEFH4aCuGNu1Z56s8hzGtR1QxzYD8Np?=
 =?us-ascii?Q?BLNiSYuyw2oxf4Gvgm5X90F1lKYChkL/b4/hgWwKSWa5XCA8Uw0QrNsm/Rd6?=
 =?us-ascii?Q?iZD6key63QrKGf45J7p5UT71/zO7QjzS7LUAgHDGc4TQ/8oy9xZWGvGGUQ88?=
 =?us-ascii?Q?/sKtxti0i9ZzN3Fee2Py+zf0gyxq470osb/2QtKTSyMyXRiOB938oaDItiaG?=
 =?us-ascii?Q?qyc5542Nr87l/Zmmy91Ysfr+N4SKXgLipjr6svdj2RTooGQxpJQg/2oZ9QZ1?=
 =?us-ascii?Q?lfU1e5pA0WEQzpiU4Z+/54TahbUc0GBzogbcBjM8iBWxhM1FpOIjanXpEu84?=
 =?us-ascii?Q?KZmCGU4QVW0Pg8GXFGic/hj5C1spISK5kbnIo4VKAy3oZzqsRAR0JypjpBAh?=
 =?us-ascii?Q?tqKiVnZPosFterr3dpaPgPSG11hFCBdAiNYkLHDfywCz2lmvlQoF03mKTouK?=
 =?us-ascii?Q?WkLOXteGHZhtxuc5gffgTz3NgQD4TVmkHN0NSsG8ItlZF0Tp37dXeuY4s+Mf?=
 =?us-ascii?Q?rF0NAFwxu+/C9elAd7RnYjjE7pGGPDZ4yimZ9jDqRPtyoXSNvbW8IcXOTRPp?=
 =?us-ascii?Q?1CbFnmLewhQD2LXuWsAmG5r9YQRzBtawfHL0FPglqFk0dCGZLIEDACAdpJM0?=
 =?us-ascii?Q?h+gggyuQdSHptM5e+tBQqlAv7RMY1wgm5LxsgkrBvpSKJad4WUJVig/lEGJ6?=
 =?us-ascii?Q?nrYpRGaiYjoueoqT7/r5+gZZjIi2xqwO3zu6fy8bFL2En7kJdAs/bgRZrsxv?=
 =?us-ascii?Q?jeE6FT7CnqTBbyc8i55r/btHtNfBITQtkwdzgJGmJAp95Efh2QV8NRNVaLby?=
 =?us-ascii?Q?aowHnaWyWurEtEBb9uF+LucWK0+wKaKD9qdfuky1vOoDzfgoBIq6kUEW9IA/?=
 =?us-ascii?Q?myIvmtp/f8GCw/7x5e4TDkfgkkvLM+azLVVVVac2ZBhpbtVhEIHqQbmuBS4k?=
 =?us-ascii?Q?cXvIjESnZdKKOJ2RhHVWr8xMoL/rV8efbJT8k+kdye3LVnBV+H3sdE8uWyE0?=
 =?us-ascii?Q?Nn7O2Sd5UlRc0jFkuZrW9Bsgy1GsDKJMy9GIhT1kwk5GTZQrVzKXcgEzT2vI?=
 =?us-ascii?Q?Lo+KkOgXxpv6I+nR/AoMHipwGdaPT8rVjCtYZC1xMKQNL7jCdOAYb6TxXjWC?=
 =?us-ascii?Q?jtNz+QJCrv4zibYqBKqeiQfDdnKZ2Wd4z06VuWR3MkjdevQ9HH6X3B9nTm1Q?=
 =?us-ascii?Q?NGyejzAuNtnKfCPXLVG9KrQETIpaNvxwdZjyBQ8ToFv5uLVEIAS7YqHPkphI?=
 =?us-ascii?Q?0cWgwMbY2l+YDobULXA04K1ip5Hy5WBsEdaOIt95ryzcFGDjwYcm0qCbswMh?=
 =?us-ascii?Q?hu2sF7tVFu2To7coP6UtH28koW94Wl0FabqWcIlCzLGr7iMRyvcczn7biDZO?=
 =?us-ascii?Q?KyMRFa9tfmQW8k3WkRBfiJ0UZCVHKdIWI/m+nAJ1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f9c0c8-4587-4906-a86f-08db970eb783
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 06:22:47.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RrXzD+ajJkcYzcwihSV+jSdwjPmAX7Slh0Yrq4vrZ30w+lG9tdBKiNVYM/GuZRmPiuGXN5oTNk25R3OrPhdjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8883
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running mptcp tests simultaneously, it fails sometimes with
"Cannot create namespace file "/var/run/netns/mptcp_ns": File exists"
errors. So this patch uses rand() to generate a random netns name
instead of using the fixed name "mptcp_ns" for every test.

Add "ip netns show" after "ip netns del" to check if there is a test
did not clean up its netns

By doing that, we can re-launch the test even if there was an issue
removing the previous netns or if by accident, a netns with this
generic name already existed on the system.

Note that using a different name each will also help adding more
subtests in future commits.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..b2d41024c6c2 100644
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
 
@@ -178,6 +180,7 @@ static void test_base(void)
 		close_netns(nstoken);
 
 	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	SYS_NOFAIL("ip netns show %s", NS_TEST);
 
 	close(cgroup_fd);
 }
-- 
2.35.3

