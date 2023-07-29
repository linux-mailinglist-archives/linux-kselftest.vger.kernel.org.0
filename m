Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2316D767DE2
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjG2J6R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjG2J6R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:58:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9355129;
        Sat, 29 Jul 2023 02:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK5E/NnDzEHI986XwzHzSvvNa3/ZCxnRnDK+24CfFvulKSpjG1Nnss+5Nn7GqgeVKtY+/y621I+Dde5wZnOVBrLhM/Dux12WMmk8Sqpiht1m+W9KdKVjPSXx84lVqTjikbekJ8xWIO74N6mdVGXQD35mxFeyd/gDlFdped9Gjp5YALbS4EARRS9yXx1PWy7G/9w8+UE1VzIuQcot8NfgAdsghiRT+vluQMSIb8NtEUh5JiCR3NKOPX454VYXMwJTRsyvDpbwfhAh7xAx37onYgx9QkcyW/T5ID+XXJbELVHy86FPhJ+I7hrEeYo7h+5RlqeoEkUgejhLHMlpt0v+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNR1Z0O8+imQ4xIF3S+4EWt9/8j7kXiMDTOLw5RsoM0=;
 b=kUkDSxU4jGQen6v9eiMJdJFj4exKUeVfKEbPWXUkREtOM82gTWzvClDMq806S5K9reu94NeKsV6HJKUiSD3MM6yb6GrZT8LICjpG8G33HbOwCplrukaodjBRe6ZPo7PonkNnhC4vSAkVRPX64PHlyC3IOpclVSiUyvEY8yFjwf3MUliJG4DFNBxbKKTg15eXunCS7OyiFunQY6VkqHla1MaoM4YPIuQFi94pOPQgj7BmqPUaWFkKsn5DWDB2LZDyiauRv8SEaagQwYzBEqySwrdk6/jai/r5pOqcVeDhX6c5KfhiCj5bTiVTGe3zkz8Zm7+/j5gNFX616iJwD534dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNR1Z0O8+imQ4xIF3S+4EWt9/8j7kXiMDTOLw5RsoM0=;
 b=M+T/9HmucdQBGrBB7SzhoQTk3BVluLQhR9Z7Kx1ew8laMW87dlNBAfWpP55VS/r+sTvgBwjTXV8Scw3Mde6AylmknFNDHZwBCzVZVFH7Q6dibOPjaW+oYsuPFi0gR8gukEsEqQqHHnetG2BP9b3qeogT7DQ99fyTwB3UiuWaVz3VjBTHfNadiQpjgtlBP7YJDgVkRbgQUkW7+5Wnraofe4opETcwn5gxwaqm838GVukp33UfpnGxFdTHA17G3wUtKZLP2HZZMcSU/au1kp1V6QjAsRJ8yhR6mVrxNhLSF7bikoDZXYanpfUmwwcgApItNJmFl7jKiLb8LpqDV0UZZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8417.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Sat, 29 Jul
 2023 09:58:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 09:58:10 +0000
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
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC bpf-next v7 6/6] selftests/bpf: Add mptcpify selftest
Date:   Sat, 29 Jul 2023 17:57:27 +0800
Message-Id: <27a7ada7aa480301102cbe1f7ea1303bae52d705.1690624340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690624340.git.geliang.tang@suse.com>
References: <cover.1690624340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: a4582274-8b00-4965-3283-08db901a50fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzKuQJspS18Gf5DkJegF9TSMZIM9c3BwqXZyss4vzJoWrDdv2jrKSUhWdhJ7C2np4fTSsr2TJrvvVeFU6uK+KYYIJjZYCPI6/6BCUAHWwXSkZGLRoi09PPQiyKvmJNJyZn61+dAOdjWX+Brp8OlUySUEvUjFV6VuJpGueLF63s1fMSPxe+ModmM4NH/bGNsy9VflVs7ezhwgsKi8uSnMzI6zzU/iDsaTVO4A2Sy73m101T15nvTWu5Zu24CrYiPJV9uc4RqoE62V4Bnj7/MJeTfyGdMf7mhyeA3+QPqHFZuRFw4wcttnCoW+He3beTfsphZYDG2UTi3TAWLI4vymvqomB0z59P7dE9ZzXIcyJQ1cwJtY3T4fcYwiaVgo2LwWRe+05sYwrvTfFtkNYd5gaeY7oqOHa/EaqfsVk+4MmM07UrGiq7Z4OYDXEEr1qYczGPTka8ULR+rV/BHLeWojhF38iLrkSmnkegTnWEr1akvKoLDn38EFLK1MFAnQ5LochhyE/JTMWdpL31X0wz9y1H3alU9i2z1RzuwVHvNC5M23BJHZf2Vc0cbhf73VSk9eKSQ4DHCQFO5qXZlrTYUezDsSc5kCkLFyQfOMbDpmf1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(6512007)(6486002)(36756003)(2616005)(6506007)(26005)(83380400001)(186003)(44832011)(66946007)(66556008)(7406005)(7416002)(921005)(110136005)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fj6n3OSbb4PgC5kxdtyTQI9MN05ivysGKoVqH5mE5yQ7OeDdDoDqdHhxGYoK?=
 =?us-ascii?Q?R3JAnM2hlRVhyMn4HotFx6JRGvGeXcAAsuWE03aM2CDe9T1g+svqPNq1b4MA?=
 =?us-ascii?Q?rq6EWBY2QdC2R7DcIQYLlvPvs6LOsiDk8kepu3r9o7DklzyKbXxfIYQ3FIua?=
 =?us-ascii?Q?5ubUc2LVIc6lOi9CtwbXKXnLL3ZaEmtGySnDqsRWi17kFfcHYFXt/qPK6DM8?=
 =?us-ascii?Q?j8dkNUtVwuqjeLryKEbL10zKcNivotfRHXiR2hmBvBzBjK/zW1J1MDm3Z/Ng?=
 =?us-ascii?Q?PIJoyrGK8tyC4Xggl+H8rvj7q/+dNs2RiQql2WQFk9I6YrqU8RXkQqUuKa6h?=
 =?us-ascii?Q?DX7TbHinUM8YwtTmledhkKU0SvklXlEix8N4RNOW0AbofC+8QoedorJbtLqI?=
 =?us-ascii?Q?VKHIpZYqJ1SnVpJpMGkF6RszW13zs3PGTbhRm5UnVozIY4yjlD9Y75qTQ1vU?=
 =?us-ascii?Q?RMynDi7re3cl3lZCNNBj6ewK3LbF/RfO/o8ARHNtyNbwTi5kZy9QASOZIUA8?=
 =?us-ascii?Q?JkPWQUDoH4DZns3orAo7EU0NuNCjkZOeVuUjbFjtYALs46lBexmtXExSby9e?=
 =?us-ascii?Q?eFjybR6nCuj5HmPGP8j/xIfE6k3gPz5Wr1fbtPyBZvnsXKZeQp8BYEp366Ck?=
 =?us-ascii?Q?3bfOiQ0BDVLVruGy/nnJeBn9LWzA+Qxr81BpR5Q6L5qzUBBMPyDfdsJLXghZ?=
 =?us-ascii?Q?RwehTfoDF2bfb2d2nmHmkyVr3UZ2WN5lEB2g3gKMfvVjsbasu6Qm454oSHOX?=
 =?us-ascii?Q?dAHi1RLIbfEigQqqGf7hVzCGuK1mdE/KRUgds9Nsbl1Z8sFH3TtPBw7I8qSn?=
 =?us-ascii?Q?MgyaO3G0RLWD64quzNVyvr3FbtKVA4fTBWck1hz7TSu9BXa0hK7VumuBvmAy?=
 =?us-ascii?Q?sJItwL03iYMl7FF5vwmwpn0nZPFYktbg0jxKB7wCG0y43E5OfB4I9FS5lV5m?=
 =?us-ascii?Q?y6OwHDppya236KL8GyrB6LeaIMuEQnesegFl2xderWVegGNRPvPUsM7rriJL?=
 =?us-ascii?Q?WiHfVtmISggq+FWnHfKI8SPsmTueQiQcCkFv/us5sQrXjVzAd2vJEFPZoQj/?=
 =?us-ascii?Q?UY+hxNa/L7h7oZToJv/D/JA2hNizyFf73Hb+rR055aDYXCRwyOrtpYna/du4?=
 =?us-ascii?Q?CI1/VADPKXoqubIhmCYC1YYPcUAG+CHlPfYbZKeQijDDs3jqC+zN6cZliOv1?=
 =?us-ascii?Q?IJ98LqPtQC5jb3EOaGqIH7q0ArWxaJizM7wHwizcSSPAAkU7lqxtgeqFJH9c?=
 =?us-ascii?Q?sKr+1pnwv8Iuk1B8sq+mmFa1RiX59YuM2YlpaC5UusNUI5pA0sg+IiGQo+Kq?=
 =?us-ascii?Q?1gVbRgjr2y83PbaxOqAaX+N3XJZyCHT0Boh10bh/PP/ITEOAs0F3aXH24498?=
 =?us-ascii?Q?XodQW+X0ujdGhwfc2OgHtINDyD8FQwn7ntjJkANoZHLOiwW1/O4RjqWqvdMT?=
 =?us-ascii?Q?wWciqV/NZDLFM+xQ2WYRytG5GraiWBo/9fdBGMQ/cNt9JUHlEmrZI8uu/ZDk?=
 =?us-ascii?Q?MyslDylzbtAO4wuOfjfu4LPuUJ//DPiuGNf6oAV51VwtI7W3VuFb1Ev0iKuZ?=
 =?us-ascii?Q?Dj8RVK6CkzwbVQLT7KprnG0ouDdC6jU/NhO9Eqez?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4582274-8b00-4965-3283-08db901a50fe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 09:58:10.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDH64IBJT6Uqxut3kJxsdPzMXlYjjPe6hgCr1ngR6s5ItwZyy8BL+i6l61mHX1oxxfAFUne9PIbcypRx1xYNEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch extends the MPTCP test base, add a selftest test_mptcpify()
for the mptcpify case.

Open and load the mptcpify test prog to mptcpify the TCP sockets
dynamically, then use start_server() and connect_to_fd() to create a
TCP socket, but actually what's created is an MPTCP socket, which can
be verified through the outputs of 'ss' and 'nstat' commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4407bd5c9e9a..caab3aa6a162 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 
 char NS_TEST[32];
 
@@ -195,8 +196,101 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(void)
+{
+	char cmd[256];
+	int err = 0;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -tOni | grep -q '%s'",
+		 NS_TEST, "tcp-ulp-mptcp");
+	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
+		err++;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
+		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
+		 "NR==1 {next} {print $2}", "1");
+	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
+		err++;
+
+	return err;
+}
+
+static int run_mptcpify(int cgroup_fd)
+{
+	int server_fd, client_fd, prog_fd, err = 0;
+	struct mptcpify *mptcpify_skel;
+
+	mptcpify_skel = mptcpify__open_and_load();
+	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
+		return -EIO;
+
+	err = mptcpify__attach(mptcpify_skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	prog_fd = bpf_program__fd(mptcpify_skel->progs.mptcpify);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
+		err = -EIO;
+		goto out;
+	}
+
+	/* without MPTCP */
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server")) {
+		err = -EIO;
+		goto out;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err = -EIO;
+		goto close_server;
+	}
+
+	send_byte(client_fd);
+	err += verify_mptcpify();
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+out:
+	mptcpify__destroy(mptcpify_skel);
+	return err;
+}
+
+static void test_mptcpify(void)
+{
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcpify");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+
+fail:
+	cleanup_netns(nstoken);
+	close(cgroup_fd);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("mptcpify"))
+		test_mptcpify();
 }
-- 
2.35.3

