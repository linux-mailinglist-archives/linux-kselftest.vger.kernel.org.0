Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBDD77D774
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 03:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbjHPBMT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 21:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbjHPBMK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 21:12:10 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A012117;
        Tue, 15 Aug 2023 18:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZQtMumjOHm+UXx4dlpzP82l7oNpgAXdkQw4/mw6PiwG1O1q0O/jiROMw8qSRjnfFvfbbfZHPY+pM/0mBMkcyaO2C/8UaMr6DZmyFeNMclYgl7U/hlQEmZcO+r6X7FvH29KsZ+oTTRHsar8u8zy/Iz51xb+WlA20I57KE6+zCTowGOsrFePTP4IUB9//2jLyXv5rb07VP5IzslveLffx/3lonrpuzdiSXSDR6XuaI2/nks/9kay6mW9Bqhkt2kJFXcQTETjNSicBzlHET0hdfWRow2m7thC8gC5fm0KAe1Zbst1OQRCqXww65kQs2lqULjJx2BBdGiPk2MKhSUXumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGHSej3ss2wDAQRc9IvguNqyne65KXqEapCB3K8Frws=;
 b=X369/m2Vj47nWgP8wZpoAUvri5pP7tWRDg2bKihxGYd+Qbq3YHEAfqIJpnSNI3insU9SJOF/IZbU1wmYzbit0/RzX4kJdq4Ud8hmPkvJQc8MexRY953nBpjBRejZwGHsDoVMFd3agn+gODOI4OSfWnFF72CMaXn7EjTBXc+x6z/V6ylPsQt45/coS6F+cyCVdOHSHKmgxKXZPMxoLYZYs5ZH3kgkySR9qQbIJiQe5TS7XZoFZBKFyp7YljgNaFAcWBxhIq2PKYlAvtm65l8pOS6UcaU1Y4u1D8nrtEwrDapF621JcjJAB8VTdiY+ntXDcBvd2tw7O47uz9du+vfH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGHSej3ss2wDAQRc9IvguNqyne65KXqEapCB3K8Frws=;
 b=pUy3/yh9UtZ4ChueRiwYNwnxKhNV5q7cD8p8uswY/gF1dWkd/au19B5GKCa/2H5nCKXc4FwRpoLUJd9NNHb6oP07Kx+j0l8h6ddtyrW7PJpbphCTmWDZzutHTLApWxva53W2jM0C74nULvJxLfp7tugd4c1SwOLCOsYuvezn7iGtVXa8TTmdi91Xp1KvQYZMwFGfRG1k5dXzwZ+nL55o+aBRdtWI3/lMdSTkUzhDTKXD8o3c8aXLRlB1WRc3FqtWcFKsRYlBOcxc5YWW1MPotl+3JaEG76BWS6ruZBfEKxZ1JYoPzwQ0bQl1cKLSXSDtdlzL3k3cQogtJywbJc05xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9915.eurprd04.prod.outlook.com (2603:10a6:10:4ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:12:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 01:12:06 +0000
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
Subject: [PATCH bpf-next v14 3/4] selftests/bpf: Fix error checks of mptcp open_and_load
Date:   Wed, 16 Aug 2023 09:11:58 +0800
Message-Id: <db5fcb93293df9ab173edcbaf8252465b80da6f2.1692147782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692147782.git.geliang.tang@suse.com>
References: <cover.1692147782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 8042bbb3-973f-4f51-811d-08db9df5cee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0NIlUodZQmT4iM2b5+6+JhLvW/kOLORXqqJuDGahw2xDg0luivYvgidbB+C4Gv684ZqDLDqKCCIsg3926GZuL0pQ0iEj64Rarn+yX7jRTlca+u5yPvYLuhMVPWsT93fmjsVRPkqJaJjbLbEy8NoEMrS78UQpb/XkPBPvoUynP0UtLF/I3V/VIkatCW6rlSu6JiYRYgED3Lhs7f7/lZgpGD4EeNyiJMk5YWHXzTlcEERJAIngN4PmRQ9gODtoIHfH7rnf5Ie6MC9bJkxOPfex+xwmuyTmstmgNAVG9TmYy6yx0WSkahjJNkhwhU05giUQ45+vhamjCHJNPMiwtPmEmfms4HmZ6EvgP6eUyYxuyb3ZOcoXZa3VMQqI5YsaiVETWrqxuP+hy2IgKxwJpbMqP7ESA/RMXj7SVaXzpVzX+lBtpNYhiMoPkDmbhdWZjedQkh/vx5dKTAj2OmUBym8euu7K7n003wsFM5dwXGIgC51kJKp6zyyEDRUvlNGAvQIkjwrQCud2SPNrhK+YGWeSQPY+RS//iy1gWAfyn9dDqUdj6STwaOC/S32cM7TALzdkWPKVlgaFM0psQtBa0LSF8up9a+v7Jrf35z87JY0qx6Q3LwaibGbRkz583hgxWKT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(186009)(1800799009)(38100700002)(36756003)(86362001)(921005)(6506007)(66476007)(41300700001)(44832011)(26005)(316002)(4326008)(8676002)(66556008)(83380400001)(2616005)(6512007)(6486002)(6666004)(2906002)(478600001)(110136005)(5660300002)(7406005)(66946007)(8936002)(54906003)(7416002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMZGV3I66ztkUju+VRoHMFFzzip5LxO151JK1JQQawkfvinIC106Vezcooe7?=
 =?us-ascii?Q?IDenJrfCc45cEOTaobI1Q5MLG/wYrYtd31f+L3gm7rzXuLmtWpWOWWrraiQH?=
 =?us-ascii?Q?BuQppCJyfMO5FQdHLhkbiCxWQ0AmZk/PZnhZSYqg4ga5YRWi1uClNpw+VdD+?=
 =?us-ascii?Q?J6MsmVkbcAVuDg/JGbgvZnVbeoCOWCeyE38oRHRYqg5/DybRfhujSw75JkaZ?=
 =?us-ascii?Q?kGyghr9l8G3XjRh5D4kOIEQHMBCan53Ip6R4LxVVgosEXHo2p3r0RxDCG1Wo?=
 =?us-ascii?Q?u3Um9WtsI72GIdDjQPGOQdZNEK1yaaEZS+Xz4vprqh4sodwCii1BMeVmITB6?=
 =?us-ascii?Q?6uuNIgwrb+1IuyWbkRuzQTeKhnxDQMrZpW1YFSaEhR9J2tj3aOSfYMKy8ePs?=
 =?us-ascii?Q?O2YFbruRHMt+GV6xEirQQ+5fgC6iSk1A53ZTv6Ry4NhlOEjGt65eXw3ApTAj?=
 =?us-ascii?Q?r+iLY/OJhKCRk0LjaG3RYmzXeBkiVAYZPRZTLciYX2RordUTzVQ6KtdsL3QS?=
 =?us-ascii?Q?1bta1dcJkIQEq3CMBJNyFb174fXxnZI4amw+e0ES/yFYry0gGkOPsyG3xMeO?=
 =?us-ascii?Q?U5bvW+82Jt2w0x3ATyShJ+skc88N5QNu8Ld23C9TT+P6cM/FIeOhWu+VltiA?=
 =?us-ascii?Q?4Kl53K2FAcSG73GLpKhgtmJgr9EKWm4O/L2n6W85Bchr7JxToOkaecHf8AOa?=
 =?us-ascii?Q?zkqPRl8bO0KPfkrQ5UOh0SMMu7Q2TBO0dKam59e2LxNrW//2LS2og7qk/sqx?=
 =?us-ascii?Q?5Cgux7qSWkMBVqOzW6+f16dKCDIQ0wP3agM3LEVp6sJMNlfy0t+RdlNZL0RS?=
 =?us-ascii?Q?bKaE6g6lcKlZ0Uq9PpKBAI2jtmOOppN/6gWYpyBU1RjqjvjwWNlWlAepmzQb?=
 =?us-ascii?Q?oc0rrpoVlk0FYqXDAiWgHnUWmv781s9OohfIugvbTuImmzAQCVCmkDisbs8f?=
 =?us-ascii?Q?VrQDFVP/a7Cc2OzzM4hZeP3/N4TZ9Ik94C08CEhnzuWm5K6YXKvw5YJO0Tc+?=
 =?us-ascii?Q?7tcsvzbOxokrCO6QrqHBC6Q/QaPtvwmokWIv2UFBdF8TQhpuE7352NnLR2s4?=
 =?us-ascii?Q?dhRJgk4hAJSBS+9wLWPZC3fUoFPHnyRME+LUAbO0XPST81lL9cKJsYtvFOK+?=
 =?us-ascii?Q?jydyazOU8Lrg/i25IHQ+W3iI2rqQzIvI4kUmhO4vWVPqPgdgzNxgH13/HQnd?=
 =?us-ascii?Q?pPLt4LOv/Ap4lVqfLvhBvVszXmuGcWswa/LIgl85hY3GwOl8ohiCH2YzliJy?=
 =?us-ascii?Q?t7SNOAt3zsmwnAbmtMfBUgu6S/DO6CvHl56clzT6TZd1B23tS++Hy+2OLHcO?=
 =?us-ascii?Q?3ULN652JQIliUIQIXXxGmisHoTu9r3+H/IN2+zLGzXhafZ8TGvoWtP6BFAIf?=
 =?us-ascii?Q?wIhkpbIXGQI5qWqSHNmVeVyaq4aqqiCGiMvHc8nuvJ6JB8p8uFcL4SIX3DGA?=
 =?us-ascii?Q?1U8wF6HU0mX1cj4zq+HIiX+EXoK4thk15GqdUucglO1WBMlCdEl+UcaONewp?=
 =?us-ascii?Q?pj04JsftLrGoipppiU3Lcgv6XHc7nUMv7oPLoqLNUJU4JUyfwPpSPUTACdk2?=
 =?us-ascii?Q?Wu6mBCRJcaKH3aXWzUYbrU/q7vs9ryegECfwvY86?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8042bbb3-973f-4f51-811d-08db9df5cee0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:12:06.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoBchx/DMiIBRZnD2rT9s2tRTbIg2w+l2FK4QpjVVoAKychjZ+pL6rpaNrPqVE2wgg81g+2rNVNtvPX8WfcIrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9915
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

