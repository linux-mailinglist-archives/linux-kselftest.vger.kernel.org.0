Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32139779CBF
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 04:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjHLCyQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 22:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjHLCyP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 22:54:15 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1F30ED;
        Fri, 11 Aug 2023 19:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrqSIEIZvEH7ssGfH/wUGbNKkRocpC0iKC5hv3dtGgZ6C/BAPcP1U+gpoL/TXa4VqGh5r4X5OTfz7vLY8cFzR51CoudpwbHq0SK81os8kQKk2IBo6nxElsvXAJ7+Pf5DWZX3JlXBMcirytt+B0S5Kw44g/w/WQ2oWL4Loa2ovOjKj41FH+6G0CLMiNq9VRq9wxfVNMGrK9xDYokJAoeiig29C3JZ711Z34bAZ+y+9x2xnPvZ1s+sGfsq0B0RPFfyiKgXITTC7qiypCMb/F9uC2cDJeQsjugq41nWNBXcStppM24ZekPMwT7tlqU5VsiGsxJCASyji8RtZx84hNFJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGHSej3ss2wDAQRc9IvguNqyne65KXqEapCB3K8Frws=;
 b=Xy5gzaQ+XQKO1Ky/O2m1RloXaoe54hpZOJJ+8cxbs4iG9z6Qr0bn12Ch/4MCOB4MMZPPxHy6ywnCuT4/LqRcbFjK04Y+p9anWiZ2XvsY4Puz0SucgIgfeQJXe/YQ3y/eP9nLQI/YFBG/eLZ4Kt9r/VRnR/Im/0+/zyJqj9vjvRv5QWUE451DQlGO+GLDHWA7DZVqqkLwxg//2rYuTLItwjDik5xJochfaCWz+FO2MD3R6+fagfBEJS5jR5RvMviTQq67HmnB8tImE6zu7vHGrpeozMVGi4pmR+nAMsG5Wz/uRdIsfDiND3t2ON3yTfsGFeByorYk+0k7qC7o61/uVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGHSej3ss2wDAQRc9IvguNqyne65KXqEapCB3K8Frws=;
 b=GBKJ34a/NaykUKqalbZzP6kfLDZ+6li9xmjAJBOJKUm1QCZfSijLiGK2QUEbJBCZnEJHURVhXrnWMsdFll9D8FwVijIccodb8qzYRVgAMOhmTBvBWBg3P9izXnTJoExB8P0bD6Cafbn5fWzzUZvhgSkVRPGqUNCIx/FS+cWL4nMo7LKv75A/QO7VAAl4NFLz9VJBdEkllXAtEPU7cTkuHD9Hon9xpHSTXysMrViCbxKF8r8d+x2odojpakJ+1Jgdx/svPTAWsYRzVVj47fcwnYABJizjYFlpnp29FCQkW2kbAz5clsJrPtnsBEiEfAg8G+0++GA5yncQRIat8jndHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Sat, 12 Aug
 2023 02:54:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.022; Sat, 12 Aug 2023
 02:54:13 +0000
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
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH mptcp-next v13 3/4] selftests/bpf: Fix error checks of mptcp open_and_load
Date:   Sat, 12 Aug 2023 10:54:09 +0800
Message-Id: <05671ff1dffababeab21aeb6a18093dd9ec41c47.1691808484.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691808484.git.geliang.tang@suse.com>
References: <cover.1691808484.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c42c59-3037-4a18-2c7d-08db9adf68d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CT9lnS1aELT/PQqe6oxAMFjo/zeXY65WLWjOf12i7bG6AJWBwvhEtWoFRuV4xkB8a+oMPO0YqLGeg+9sBTRMDvI1iHOy6JHYheEL8fyXnWoEigzuL6ulLuZLGhtpQNaXpsKJh5BG6c65K0xgsHZjzKfyNxleCFwsnRCoi3fRBmXB1NsoJv+AQzMmD6WkK8FDQ5nMeqaLZ9gBOTf1NkD2r/Ipfw261TPv2GEQLXPvSvGeZZEC0cf+R1XtRr+8bLX6hJWiiWGwbjbIyoHPdYJdHYg3+jKpDpqBjdfNeL6M+a6bLF3pp9OVCir4uPiegBevXBralM55hc3x4YuZQOFO+78tl1tM5eQ4SxmAaHuzV1gylkFCnvP+/U5IEgI/dqRy8zyJ37Boij1nkajNOsw5lhdMgsr8T8S7ByNIJYtg6EJSNknna3VRLIX5fOy60pc6fIDVB7Xok6+9/1zbNwYJkX29MVeTepAPBT5IGXFDJakTKggKeN/WG07KXudGWj3ttYt7DO81+vUERpX8i/8hw14Q+wcXOc/eihvCqq6CAJc7B/2HCXx52FRUGt473FfCSIV6HuP7Ao7yChCKdG6MP8lC1HD+gPUGA8iuqDQqLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(1800799006)(186006)(451199021)(478600001)(2616005)(26005)(6506007)(110136005)(54906003)(38100700002)(6666004)(921005)(83380400001)(66946007)(66556008)(66476007)(6512007)(6486002)(4326008)(7406005)(316002)(5660300002)(8676002)(7416002)(86362001)(41300700001)(8936002)(2906002)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VJ/QPGnXhwTgQO3yk61sPvvn4+URC5my+cMLyKf3cs0W17iGHvyGdbZ9xWwZ?=
 =?us-ascii?Q?J0yvFujWr20n66YUEMHPFtuLcXZAeeSp1z3CkmCbGAZF5tjztXFx81MXxjl8?=
 =?us-ascii?Q?YkMOiKmIoxUBH60+rr2IVhKXZF4vucHrwlkL5MlV1WQGvA3n/p/R1tyjfRvy?=
 =?us-ascii?Q?KMYjabFIIHK55n14A8v8Js9mpG6PX6vYj5r/q+QOG/U9tU68e26Xv6e+Sk0h?=
 =?us-ascii?Q?t7B4lHdqOT47+08ZvyuNIH4VLzOXv78f/Ak36hnVCd+IK2quXWKPPWW5aqjq?=
 =?us-ascii?Q?GdFa5dCH7a5p1cwuQ0u7S8z5SeiaMV92eYM6Jgs40ICpOJNdRBAtBv+3rFY+?=
 =?us-ascii?Q?4kOyR6icCXQ4Teo4ezsYhYgODv77Nv+Nma71gvfcqiWv3hEI7L/b6zghWZLF?=
 =?us-ascii?Q?/z+IFH4gMutSYX0rdVcAW2VO2mMuEBEFjNipNhb+cSX3cbgLCc38/Q9PDjrb?=
 =?us-ascii?Q?KJ8g0FnwpZBjYwgQU7WU1ssuKE4HD1qWPbGwqmoQLYRJ6aeMIv77e1/XaXa+?=
 =?us-ascii?Q?wPx3UJEObySTxo/6TDaTlEC26g257oKXob2ALBtK3rkCCU4Fxs81udod2unS?=
 =?us-ascii?Q?ofpinzibYw8XP3grRNaFcsxSO9eUifTovUh2OJDeDWoEXzIHmSQM0hcRV3J+?=
 =?us-ascii?Q?ajlfLQJlFX2edT4dd0i1U0NxMIBovaFJv2JOeeeEGtrOnEXX50EIDvEE4xf3?=
 =?us-ascii?Q?WlFToN/j86oSVDmdONKJl//oqExxJa8Nx+y0kspvVykriIVXnWAWaQ3vUI1h?=
 =?us-ascii?Q?+HLSngGQ/n5ggXWNrQg4kyMA2SjdvsZpT3RtGCJ6kemxUDF+H3wicTXzrrTN?=
 =?us-ascii?Q?Mmd/0n17TPGvZ3JPWnen/Aiyi1bU30CQdsvykTl1ifOec5lcYO7COvWYBdAm?=
 =?us-ascii?Q?Old6UfPH01Ko5fHRGHRPHpHx9+VHVOGiw4gyT4+ePuOPLwE66f5BpE9RD6Iw?=
 =?us-ascii?Q?ceUHHnzo+cuX7mo88P6YytPH6HxGEQ39i65509uqPIJMl8UJr5aqtz5gJrBG?=
 =?us-ascii?Q?136+R3YaYslfQyaKmpfhd0Jc58cwFgl6IkEONj2/GlnFuG0gvQOowx175VOr?=
 =?us-ascii?Q?s9dgYlQ0ZeabEpD6YwwjXRBia9iK6nrpwgsGvnvSpI78MQ7/YMMod5uuW+Sx?=
 =?us-ascii?Q?J5kEOlqBCjQxm39R3z6ut6sjC1eRTWxnmnag+7EY9BezU5KvUrrva6mBxD3C?=
 =?us-ascii?Q?I+l4+ntVrPcU5H+IoplAbR/3oK4zd+zSCWloGNDQSgyurUQ8DP3FemNsXrK/?=
 =?us-ascii?Q?Il3JssjSaMZqOcj+75/AEGeKHKlgZweWq9CGWDjpwkCyGTxO/2eIB7sa4hlM?=
 =?us-ascii?Q?hJXWAGhj0/ibWxx0uAvLRQIsGr8KV4PEtLx7LfqiQy2Iz7rRp55fgObVeA7e?=
 =?us-ascii?Q?6RZS9zs5W2Z+zGbSOyM/STRst0OZxCiVG2RTuYh2xMDj8X7ao3WBfA805+e1?=
 =?us-ascii?Q?tOCZHEKKShEXWu+i2yDGS5HirizX7mxRvGkQnV6P2tI6m17OxKkhZPHuySha?=
 =?us-ascii?Q?ySoszP8a1arL7tb9Zn9eIWxxu1Wf/7XSMc9M8CqGkQp1fGZ/sogv6nXJG64H?=
 =?us-ascii?Q?Wn65sbY9qwK+L4qAwbgc0yEcEJCjNt0xp94L8nms?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c42c59-3037-4a18-2c7d-08db9adf68d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 02:54:13.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /m4UL4+1lxU4NdyLjSurlIXl9Ech3WX7WH2/bB2WxCB33049m3LIscp8vFQTd7acaQFBPyMnEAUIELC9pbMurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
index 76afb5191772..3d3999067e27 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -118,24 +118,14 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 
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

