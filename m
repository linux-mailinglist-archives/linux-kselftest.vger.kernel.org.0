Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD42771A33
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 08:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjHGGXM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 02:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjHGGXL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 02:23:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A8EE6A;
        Sun,  6 Aug 2023 23:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghnpdobVPqYMkBAUPvuv0XRW8p+qNUSg0x88nYCpjfCxWp43Al3iyBsh5AQZ7VRxfbx44xKjn4RjyWU8EuyaqfKUJsdpyrvktx5scNiijKqeBBnihfpzybCcHTXXe8OCubJlQPJr36JRDn0UfzX3bsrQtHw5QfGdF10PVMM24Q0fwKRqENv3I/tEJcTk8f6QCkTZk4i9YVBrLMugwZxT/jgUQ0IhR3bgcWPTsUkfqIjZR45oeWf5hkrUe3PCXmGi9uD9t96P8wJCUVwO6qPhrotschPINyxFHKkgvuK/Ch/0XDTjokxfjMHW3fB48ZdNuThmcZ1Vqp4hzjmw4gDlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMzMMYli6Tss/9lN983QT/qa8A63KreMsNTPMOxM/6M=;
 b=ibCVEotjH7l/jwXzcBjwmUULLJlPTsDBicB/xgI0gqB/8PwKUh51YaUEgw23Cf/XrrxaUkpi4RzOUmrVMqnzcXRRdCJ/OrxXH26sRrH+FxGYhbBcu0lWhMjndMPvdtX7HAiEpoGRJcfr9L78tbrXLvlgmQxUKSNG+2td8T2qjmk914fS2ca5kxxiiwTQziTmh6tFkiBVNa7v0SAYsNyWqDwwPfINLS37JeorVrD0L+vX1dyCJbj0TifthPPXUuNP0UheXOm/ZpkEgOBQBLsAelkA2QytLXerLMd/Q1Kt0cnZLAIPYLp3Q8ECcMnp+XoDOWs/7RFR09VQTGRpZ2egqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMzMMYli6Tss/9lN983QT/qa8A63KreMsNTPMOxM/6M=;
 b=QXVKINim3g6cpJmXHMKy8eEp0hQ7llGiq23K5bhTOxNDVSlotm4G9SmbYYxr+jVgFAJYvsww88iZgFJy8XHJNc8ARrbbOsbpJ40z7AykeVi/AXoOFv/K/nuGhJQa3cp3P6q65jNa5UtdZzSikT/thrQAqbgmbY+kenQoPt2/8e6RRTPmeIMVKzD1q/slI8RCtvHO7wv9MiO4OFVlcaOZ+tyGCkhVnpKpgbpcB0kyAdMldZldn/hv9iKcfVh7RRrBxqeXGfV+7OwP+fA4288hNmYth/SSbKGJAxH5G60d2DUF3ww9NfVotAQRvIfA4iCx7twRW4y+45Ylx+XOTB/PfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8883.eurprd04.prod.outlook.com (2603:10a6:20b:42e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 06:23:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 06:23:07 +0000
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
Subject: [PATCH mptcp-next v12 4/5] selftests/bpf: Fix error checks of mptcp open_and_load
Date:   Mon,  7 Aug 2023 14:22:44 +0800
Message-Id: <a7a075d2f6fe50d005deea0a1d26a36837645a55.1691388735.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691388735.git.geliang.tang@suse.com>
References: <cover.1691388735.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:1::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9b4bef-847e-4932-fbd6-08db970ec402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRN8dw0MLyPWMVzJZfgyYBI/dYKQuKIFjCfNCwQDbCDMl5OtBMntTjkBN/LazbgZuOSptlYN+BR7n6vTZJqaKps6URNy+AquUq9BFavzJky1pE+O7xe2HiLv5WuUjxwW3XbBxMsyP0iFy8+F3M1O5HG7qa7m3my7ELQH4ufHkHgQ5ydLYhYjP4HE7qGwfsHcMjeTQ/Q9F7yuRrJFY6rCrfz1+g51nSPmzVjJ6HFq36RoBfk0m+ODhGHMxJeMOr/Pv+YdfcQ6f6jTf1ZQLnu0aazXxgti0RNbhCqvoI5o9cnf5MdcslF9L7rmaNrvM9iDG/KZP0wGpT6AgxfF2ahcEbnQGefwwW17hURfCb7SAAZd0di8veFToFY+4qGSWWU4iLLqC9+GWhBCvMKpQgp3XLwikCic0hpsSf7LXHb2X8TRXlt9xzvSsAShG0+/HLrTM4qAT79Cqyl1GugJaksIzHu+iwUV/EIWOhhScM1GjFsmtIYDRjCQzcsfTZY5YYW0U7j3kxh2OjbQSRHdrG+Is6vLy22IcSrAanyOIGlpTXJzyvxgg+PDu5ki9jQmhgkbhcPm5BEkLc7sE/P3RjUKGnGCFYC95TwjJsaldx+0QNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(921005)(54906003)(110136005)(38100700002)(66946007)(6666004)(6486002)(66556008)(66476007)(6506007)(41300700001)(26005)(8676002)(8936002)(2906002)(83380400001)(7416002)(7406005)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hWkcT88wZpVze3M51c1IEla/OGZPmdzgP95vpeUqcaJEAnGYjUmgOvmPEnX6?=
 =?us-ascii?Q?vMKa2PLFqbkLeRy2FFXvWk3rbo359tU9rVUR8cRBSR6+hzo7qDHunORRz0M+?=
 =?us-ascii?Q?EGWFKv+dAXHSxEmk7cYrs4rDhTcPVaDU7w43dIXw1HZsMLEzq2Tr+6rq1yVn?=
 =?us-ascii?Q?NRp/Sa28OWAv8r+PjwEwlg66toxeDR0W0IJ8hWGlHW5y+qSSGf5rgcVIoGVB?=
 =?us-ascii?Q?B1tStFf+i4mZunEDTsBGOSsyNViBOCxMfQnkp7GxZGcntOsJS9TPV1utSnad?=
 =?us-ascii?Q?GwsTq90Ovb3cfA132Dmk8x8CX484hnM8M5lSjt/DvPEOuPwtsOUounskQxQB?=
 =?us-ascii?Q?jdiaaaPjwx0uHbxbPsqqB3husANr8IN8ogBlzojqreFG5ssiVVxtKYCjNesJ?=
 =?us-ascii?Q?o3GyaMmtCCzJA/nIookITNeDg5wPQRkzbJMJzzWkcB1WxdWSLHLU4fWWEI4e?=
 =?us-ascii?Q?QJyRjy6h478lKBv2ZK2h+1gvqs8fNh4fFe2s/aT4OKuB4zVbcB8T+poix0IW?=
 =?us-ascii?Q?O0hTt2xhOUlrbjtgvXv2Bmla0oRMeMPp3bGb6KbIYBg8lVruUJAMD7rQQPY/?=
 =?us-ascii?Q?Zxqe1wdIVZj0oAYG/QQRIjsi1xk3n3X3wGeCKzSpqVcKUTTfuXLv6XgQ5hQk?=
 =?us-ascii?Q?z6NS4OcH6NYsj9H0TPfgGtTOgTto67q4jxp1WHXKueVDRzF4LvmPjJTKawOU?=
 =?us-ascii?Q?9DlCEXLjPryqVasUZRKNFLb053eFxsKzu9BxV4XJ7GHDcUssc8Y0fxi7q5RC?=
 =?us-ascii?Q?QMiKoBwJn+UAmkKyQQ9cx0jgtkx2gIZsSZYxTEdxcw7CBll7uBqGP4053Tcd?=
 =?us-ascii?Q?k4UFP5AdsZvUanpp65Y3kn2F9pZFbSO7jOeluSfSwwC7FMa/dMHXwioffdMN?=
 =?us-ascii?Q?23d898KGYeSHuVqVpkyC1Kb5VyuzH7SaZezdtV0pivrn+j7WC/5ptCMvq7X9?=
 =?us-ascii?Q?1xOQJNjlnguFaT9uBBUXITtbH1QFnVj9VS5J0ZPYN/l8h9RJS66sbv8T0+Pf?=
 =?us-ascii?Q?oRNrlSSn2X4MiTxUqV/nHwbcGiwsnNRijtTpaZBXUpGKJC8pb/Er4rWp5Isk?=
 =?us-ascii?Q?wYaca6DGxdlVJgwqMi8rNn++y4pvaOlEa5d/u5skAguzcvbhJ1Fvge8jLbOm?=
 =?us-ascii?Q?t9/K+Xkbf51sSF0Ae2OCgecdC8b8k2OfWMKfiQmAhQMVeI3ilMk4zo24n2KX?=
 =?us-ascii?Q?UP1N1ECmJxsziBJ8jfwJhz7AdL14L7K7OB5PupceWFJ5CgzhvGxuo/BXiOAq?=
 =?us-ascii?Q?vVz1SgQimvb/DSnVJOfdGieavt8qblYCK4i/Tw74ORsNPjI8lgIhfQBJ/5+t?=
 =?us-ascii?Q?zCxh6dm5zCb15ulHobl1CL/S8hlSrjGzMPrtQ+Hx64z5kjNhz1q7Zs6jaE5x?=
 =?us-ascii?Q?Vsnoat7T99z/ogw6bi1KmUNHUkq0XKPfwX/vzmsLBjMlJMFcrSxdWBy1aGZK?=
 =?us-ascii?Q?BYWPqhuCyDiP06U7WWhnQqfH9R3JDzkzeruro2yyv6NgymG298PPWFKSgL/M?=
 =?us-ascii?Q?I2LJrCMraittqUzA3ESN7AKYBFqQh4bpQj1yAVJfq6Vgs84nSsJcGDTC1whx?=
 =?us-ascii?Q?ahNaqnlKf+gv8udiQR9IuawMftKuqmIZAfNcnvKH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9b4bef-847e-4932-fbd6-08db970ec402
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 06:23:07.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VaGFAMMrYBwgwmXYcesBUeqQXyVHHIVMeaYHsU7npvRSgxSWNYVzfEEgfTPq+2Eqa+oWg1n7uqnwpO6PS1Gwg==
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

Return libbpf_get_error(), instead of -EIO, for the error from
mptcp_sock__open_and_load().

Load success means prog_fd and map_fd are always valid. So drop these
unneeded ASSERT_GE checks for them in mptcp run_test().

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 51cbd1e14156..8cbd72981a01 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -121,24 +121,14 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 
 	sock_skel = mptcp_sock__open_and_load();
 	if (!ASSERT_OK_PTR(sock_skel, "skel_open_load"))
-		return -EIO;
+		return libbpf_get_error(sock_skel);
 
 	err = mptcp_sock__attach(sock_skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
 
 	prog_fd = bpf_program__fd(sock_skel->progs._sockops);
-	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
-		err = -EIO;
-		goto out;
-	}
-
 	map_fd = bpf_map__fd(sock_skel->maps.socket_storage_map);
-	if (!ASSERT_GE(map_fd, 0, "bpf_map__fd")) {
-		err = -EIO;
-		goto out;
-	}
-
 	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
-- 
2.35.3

