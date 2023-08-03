Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23C076E19A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjHCHf6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjHCHfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:35:16 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0D4684;
        Thu,  3 Aug 2023 00:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5cRq5D+CAPbQtUn1JTTiKTOqmdc3duOxZdEmkGRMkYuFHITT20jXx+I0IpHz37I8f4D9GZ0QAqyzB0WdglHQa2s7iKOJ1QdXlvrQuYX107niUG+e68Y2M+T1eaLKefUBkw2Il9rGIhtdKgaSvQXsGoA+g1StNMBXmj6mA1hX8NVNr10R1RJOTcnDR77FxKtqHqwuQKJFJE5NtqqNY8zpPMmz6fYgmXaDDYNLuycnw4hAAbaAVbxZyQqTc3csNBX9fP8pHcnP2fNm6vywZGakXfzQhHTGuYTc3j/iUSAjB3TjTWWExFsHsj7YH6CL9CBJn7IsMDk+neZAb6mY+TWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=oZLlyHZeQwhV4dSA1vvPz0P3Ny0lqbqI4S32w/Fw8f17wYFdHWPoLt9ITgYq67Y39zTQVXXFnsfH2Y5zKqntWKGzyo4O/m72fiMPjb5Zpx15N6esFvBkt687qNOT0USQnQTHny7N9u6zb3qIJZfpF0+xFKjLlp0DMicmVKbweh6t2BgvzwZcUYjpPGEnh6/3rg1IwNlVRI1iO7dGOq3vduHdK7pOSmFnvGhmPO7C1xLa1Eg30QYc5rHr3GPaH7V5HPa5Ck4e798S23pYiR1AhRjaGivZh36xdlbVVngYveH4JCMQBWfwXbFGzHkxqtbrHBPvPbHVliotf2dLQ2eYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02iyHHjkQUGelZcQ1iDaZ+J0TmCKyxhCWbnucp6bY4w=;
 b=YkfwD3gUFybQbEbtdCXHqomaeIvVkbI6aCMFirkTF6/TNhe27caGV+1pXzCXzU0zQjIF+UQwDiKxRHPAR2cpWqYFPmm52korAIuPw1aAW3kw7T2GoePJrju6sveYjbH76y4f3btd8kWsXlT6UUrtCt3T/7EUPG0sUWJ2i4UCotZaOI4AGTp8mN95YbKclQR/MVvmE9cPo6ACY+bp46mxo9ZmLpBTWZ9xIXb46LJ7PC48ekkqJyLqfaotA4RxDmk/Iv2z6aFf55dKjYJEZqOmeiQiethjFekuvmXl5EWB8xMoeX5flm1LFaEX0NQZ9twHutf6VgNdjH2CS69OKqMXSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 07:31:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 07:31:00 +0000
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
Subject: [PATCH bpf-next v8 2/4] selftests/bpf: Use random netns name for mptcp
Date:   Thu,  3 Aug 2023 15:30:40 +0800
Message-Id: <c1c48d9cae784b0b21ce2c9ae8cc6e3184c8cced.1691047403.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691047403.git.geliang.tang@suse.com>
References: <cover.1691047403.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:404:e2::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: c66755ac-99c2-455b-11a7-08db93f395b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugDKzDAwMAxqprQWu5SU6yb55i8AykT7mpCab+ds6p/FitNsEvBgQsTUNGxHRN4i1a8GSg+EEVLls9UA5cpAgvbRV21zm4dxodLXFAwca8kFAsppYmpopNxzPLmsPxBxs1X5yLLqD8tmQgjLMJznD7QOxgBBHpa4f0XWWwVUg0rWLtEbsGz7/TFAtZma9ycbt+bEOR6g7uRIiNEeM3AmndMmYbMZKwBVtBk6Vrb4uEP9df9Sjo/TQXKC0tPuGIoqqIMzFf+SyD63A1PqDycWi0HLqMUI2Tavxn7u6GsjbUeYuJFSMZFFo19WNEFCbiTrFLLzMyqVHXMc1jvgQ89M48o7DWORu03TM518SarQq3PLYVn4o84Toa46BivAu/+BpnatCi1KhoCv0/EFZBjhhOiQhLW7lAOfE5MtnDze/S4j6uobzkeupi0zjbp14f2lItEcPqvALLRAJRrt/ZbGQFNdgUmSQqV4SttkAiU2eaSFzEPAqyOdLomL55OUiz36xWLbVE0MkQDinatEx/Ac8d795nftc77samMWfXnggn4fSyvBeq5fJ5IE33TyYynBFUBwoZJUz/9aHoTCD+UBq66h0Sy0JQXhbh9BLx4qPwy+QolHgcj6Wtfu9433c2kVbIPE8N+DxofYY8ULV/HgW5FDEOpChZiWgNahJIVqG1aGtmkQoC9eNuzNo+0DX88z2AWJ+m1W0OFNROd7+lCKUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(6666004)(110136005)(6486002)(41300700001)(478600001)(7416002)(5660300002)(8936002)(8676002)(7406005)(186003)(4326008)(6512007)(316002)(66476007)(26005)(6506007)(66556008)(66946007)(2616005)(2906002)(83380400001)(44832011)(36756003)(38100700002)(921005)(86362001)(13296009)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKqzwrrEp/VDRUpNNg0SKHkeqWfMj8SxTg8WlDWUeEv6HDCHilgrJw5nHzyO?=
 =?us-ascii?Q?OVbdK5HGncs9sYiu4mJQAgTeRjLopd/QEOVy+3QTFY9qmkWzVXD71jH5vqXa?=
 =?us-ascii?Q?Wp+Zo7W/K4j0jYLSFViJ9RoMGWT5xelTvEVl38VUOU6mRiNDpb3LzWhwO3Sy?=
 =?us-ascii?Q?ztkxKgb/wWhEyE8qfw1aFfZvwFA6gqRmLQLiIhwLBeghBYO/eSvuTkZi1E4h?=
 =?us-ascii?Q?Cnx3de2zZ4Al+jXdaNIxkA2q9/peREZgVDzktYnA2jj3beFsgggsrM581wO7?=
 =?us-ascii?Q?PV/aq2vbPrhAsd1C/nQpQ8hvXxiedqz5LpZBr1bPft2Me5g+Emyyy2NDFV0v?=
 =?us-ascii?Q?xuwJKmVNULuTgZv3QfH9bC/O59fRs4WqsgLDM13oksxVchAQwtv/bCmKFjoH?=
 =?us-ascii?Q?huctJgEhx8C35wrVQiMd+mPRuKd9PmjmQHBbBBFReUEPUsnFy7B6gP/vTK0P?=
 =?us-ascii?Q?IULtLTGIsWyipH7XDPye+wa5oBT+xN9VkHMXlTQM0GbqoIpJnfXDYcMDM4l7?=
 =?us-ascii?Q?pkRmE8vPL2785gZP4kc2ueRrgMeUrtmbQ/RaPpl6oFCyovOo34DDKqGcVTq4?=
 =?us-ascii?Q?yiUNNZ7q9jmQMx4q2oYTTted1s3XS5+75kFX398y7BXpUVB0ekTIdpl/7z6F?=
 =?us-ascii?Q?j+7npG695r6Dy8AtgeSRs64oYq5MOYU4jkX2HPhXWbQqZpClNqUTe88FyIjB?=
 =?us-ascii?Q?KLLiMFLujTWdggz3GVzuMNCUBZJvwJ+2enBL2/D3yRZq32jlEJbHKJXtej2n?=
 =?us-ascii?Q?7Nlx8UtHtmMdUEgvyplgdjgunpY2BZ7MfF/cdgfU6qkC/Ft4X9rlq9Np6vY2?=
 =?us-ascii?Q?ATlCs8IaDHNkbdGEbs0UaCWBdObVxVCDTAGSR+e8sa8/jevDLKC6OJ4bDc5u?=
 =?us-ascii?Q?lw1nmVtt2pEJ9Q0uzU8pwphQpHkcKZoTrv2+l8bNu3jVrPqX7IqecizoRvp+?=
 =?us-ascii?Q?aUbLFG722idboPjMXtWGWrBGRkTlK+s4HRrpN/N6N/H/+841pa5/KxjTkjPg?=
 =?us-ascii?Q?QMwlnty2JvobS9Lj6ge4GGKTv9uhv9Dy6aN1VLEeZaj6YYn1/jxc7/wuCr7G?=
 =?us-ascii?Q?6INS85MSn3Ep3QYuU/KJPREwPv9EvWvOY+omyIzf4wkK5vQwlh+fYRvr9Bir?=
 =?us-ascii?Q?3tXD+Dsr2BvTUW/RDOtUHsNvTbKNj3QPp9y0xFP4Rq16Lrrz2Qpb51z6vaAe?=
 =?us-ascii?Q?w3Av40h0KGqoXOVTkCed46JraKU5yMzgzaoWk2hlkodow8yyDY9DVR/TdHvG?=
 =?us-ascii?Q?bDKFqOEVNqJLsc1Do+hvwhSP0pHMhc4Cahnz0O07OFO4FwJ8Qjbi64rVyQs0?=
 =?us-ascii?Q?QLRebT6T97yYa4uEL3Oz9cj3A62fw0bONvFQGwJIG3bgATX3Ho6IMcExwizr?=
 =?us-ascii?Q?DMEi1z7WhGedLyON24bWaJy6RIJgQZpnd2oK9Llc5HYhmlIyigKrKcXbz0Fk?=
 =?us-ascii?Q?kVsBKRut7P/Q+NyMIvDZp7aX8HAFaUsAHhDIQelPvwyTAlO56QzGKy24PV0F?=
 =?us-ascii?Q?jcXqT4tQmUXK6QwlLsbzoh6muIYqhVDSa6XI3cLa4DhrDQwTIk3IkJ2vcr8e?=
 =?us-ascii?Q?6fenijOpIFx+GwMrHLg+Ezn/IvA2zEDcmGFCPwcW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66755ac-99c2-455b-11a7-08db93f395b6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:31:00.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq7ZrgMpv4GE/ykGPBn3RJasBrRbC8yB1FL4uSMt9KkwhTCck6AnpHgFHDYY+ypWasrgQDAncVF/3yNsHWWDUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
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

