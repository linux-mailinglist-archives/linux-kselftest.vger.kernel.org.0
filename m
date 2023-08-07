Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3890771A30
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 08:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjHGGXB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 02:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjHGGW5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 02:22:57 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB41E6A;
        Sun,  6 Aug 2023 23:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtU2Ify5+ud1O7hDdFkJbunTMa6qySmfEmZ255E0ZeoWi8L7sPyx4o8L28UQiZcx0xFCLq4S3dlg0SR+optNVkeE1CQPCk1fUPXap9N05DReNOFW8fmRGHedC50WEaXsDVuFhgobmhrZLx+TMo51raaNjHhzIEgsVvSlsh76rw0kxpdlHARF815fGdqGgWb7U3B8D9zJSsi7NuiFisZEjQL1RCvxttl51mtj/vae7w+6zd9w8Oht8CO64Jx1thnBEsXApQEdTguv0g1mGjfGnS+jLr6kt1oifwY2xluOoxcrQbt7oQgzaw1ri+g1lhCfcHW6dPI82XE06h0DXq+IrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3QLe55sxMKOTG1LihSp1XbvYAXqx23AByNcHSv+SYU=;
 b=GKGg/Hqz2vQfnN19+GHP/Hgt1CS/rU/nc54JWcyRyxUdcFUjy2IX8DYKrS7sPiE+sfI1qrL+XtA6C5ApKnym36/ak4M/Gvcd8qckjgYWo9MTwnKu7HSiNF7nwkFhynubPMeFhcJUX+vj5rhAC/7qTSJQHgjXXtfSQ6s/pggu4xMQFQFNbSQr7gNToYOQMxl9qVhHrB4D6pFChLEcICqysT0WEYE7SBZOm4DDGBObdKRlw0LAewJv2zzi6lu7DUspqk+3lNcatMhDp2vhwdFcWMvm2hf1+MoByy6o8ODWgzAfUN4dwF5y6oILW7aia5ihosnmOLPsdcq62Hs3LwK/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3QLe55sxMKOTG1LihSp1XbvYAXqx23AByNcHSv+SYU=;
 b=aUk1IZ/9tcpcbUno/iz/KrwCh6yqBxbe/IBGX+8AIWqCy58XGHYNC0dnISg1Vx48nQuhv9J4pGZvPC07mcJYU+NhoS+AUfvZHcTEzYArVhEwV2Bp3HXuiHX6KhS+SmDJyHpYc2V5Ibh1TN51lqfjbJ7sP+6nmCtHQr9Jnm7nd8KjiOzRrT/TC6l8VYX9cjHYTG3sJCnxfwr4+DzUIB+JmrFaTxfOA8YAwjcF8MV504IfILZ4nO7dS/17buoWtsOiOrCI/5hjeJEcKIChlFxwksPhiqiPrR5P37r8eWXtjUT/zeBmh9d2d4wIPs/C+BPTP5dlx15Ldm2zDNwSu+mgFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8883.eurprd04.prod.outlook.com (2603:10a6:20b:42e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 06:22:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 06:22:54 +0000
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
Subject: [PATCH mptcp-next v12 3/5] selftests/bpf: Add two mptcp netns helpers
Date:   Mon,  7 Aug 2023 14:22:43 +0800
Message-Id: <0fcd7083ecfbbbcc7a3e83b2b140f332772c0b44.1691388735.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691388735.git.geliang.tang@suse.com>
References: <cover.1691388735.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0512aa-7e3a-47a3-877f-08db970ebbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/dzgunzwPUXDmILyrKM8lcQ8tNA/6Eavlfox4THpQdVVOh2DEx2FeZuFRKrHSthPNNiFshsGUCgla4yrd3EsN7dVWl1xGpVdx34HTn+lLQFHsp1ehkNl8Y0lfhaFUF1stHhDTpd2xeP7q80dQYnNEPlkBFZKqR4iP4DtxA1J6AUYYFs/WjFb07GPRrZTPU/AQJEivi4htXMr0OOzGuDmeKUlWA/m7PCaj5apeaXcEHo/6GU+MDJsFGWQo6VaDQba5bJpHjjcAqWvhdfKZ1zLmmQqOtrycC/ni/p86kCXg92PZnXckObHbCeSnX0XnmAAAiXDR0ULCWWDss5hbSaBizrAE7gu9L/ej+Z8Ol09M50ZfkmSPw19tGWVIrCKXdnoVH6yhXTpDdAsyIO+a4NxzmF7+qKxxHBSiSURb1FkHTVSYzR4SuNIf2wGnBiIUdWj4d4VQNy/kaZC0FTzq6eLchX9n0IP3GyfjtvXsZ+g+8HRH3HC9l9TYdC8pOizKsY8rggTIZpxJlM+8exoGAAjVNawaEEmi9gjt2BeL0TmUm5dY1gf8C8m7VakriazFsHDjC4Qqoo3h2FqQvnEfdh36v/JC3wzOegZmsgw3kjlRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(921005)(54906003)(110136005)(38100700002)(66946007)(6666004)(6486002)(66556008)(66476007)(6506007)(41300700001)(26005)(8676002)(8936002)(2906002)(83380400001)(7416002)(7406005)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqHzfAWDSKQH2zAgn+AuHmLHYMFL09ETCD8XJpEPH6ltxJMXkjyx1p8imvG/?=
 =?us-ascii?Q?V8PmLXhyRG2Iza+CUe4p0stb+SgT8rdywao01IX5+8a29FYBnK0sDKuQDhaA?=
 =?us-ascii?Q?AduleE0t0LK+ziebavmZ1FCLI72ZbcZrCyFhCOmfPh6KPxNnQbual/wUEyud?=
 =?us-ascii?Q?IXihW321ZhQBRvJ3APECXENlhfNDBEGY0N7RvQ0nm/EbTWia3sqs4KYsI1p3?=
 =?us-ascii?Q?4nrRmWtvfrObWufIuEqZU7zKhdzalgwdJ4TMYde2LTpb6qTnM0CZE7QO+LdO?=
 =?us-ascii?Q?0clRiJl/LLd+LsbBsfTrxRI1JjDT4Nyx/HvGHwcXHrjCrq/ar2pMNgj59ZT8?=
 =?us-ascii?Q?QlFwIPLCG23pxIAvKAFRuNrXAfdU4p37y6kem2k82oB4aCDGIQRFDd9hKbPS?=
 =?us-ascii?Q?lYGBbrLFM1ktHfzvRM+g2CAz3MbnYQMeiBTuZ3yendP+fBHWtBGzZq5bfSvb?=
 =?us-ascii?Q?kXXUDUFDHUhuvO34U0RTH/vWdVnWITCLZXOLyKwBlYMCJeavH9+0Y3Y85VJt?=
 =?us-ascii?Q?+twDhDoYHV+y2EQC+OeWLXr4tjdevok7+U5dqlxXflW2YzByucsTqt/L0XJQ?=
 =?us-ascii?Q?fq61Xm3axC8KDzlxlIvf6HK9JVRiJTsWwkHaWk3a7NgaS6XRryimN7IPwoNS?=
 =?us-ascii?Q?x7+UexR0BWNKym0Qsq5NDFMh28Vr32AE9JEU/Cl4yTRltPxDNTfopxYamX4s?=
 =?us-ascii?Q?0amycFQqLmHPS1n8dQ8bU9RwfRNnyrUEixFlQfaHidzOOd4Sbki9eZPTHaQ8?=
 =?us-ascii?Q?doewV3sPpkPNExrHXOGOlYUxelM/eGgwPQM7Wt1XB0xN5uJ0PsIci1hJE2tA?=
 =?us-ascii?Q?suaQbws7n8/zUyIXIAu0tWuRnUXKwq4kd7+Euk2Q3/jy9Cq+mCDVLBXHQVaZ?=
 =?us-ascii?Q?NjrHxvVVvicxsDgO57ScQX3QxYgoQVQOQ7Ag5fpioWeccC0At03H2OFEpQ1E?=
 =?us-ascii?Q?VMAO5EJeUQ5xKOYlJjCHbI31vdGD2g8rdKWRUasB/A+sypOwNw0bGQ+h83mV?=
 =?us-ascii?Q?qMIbLkeFzSPIWDDVmOQZ79uYl3gqBQlJ7gHZ36rcszWFYW/5LOdL90eA6qnL?=
 =?us-ascii?Q?W9i3dEiuC4HRCfm5i3TE5WANoAYLUqhsd2B9wJ0+1yYpcNINMMMF1DHfCyEh?=
 =?us-ascii?Q?zSN6QxJgJCYGXLV5z97DfZoKbWvIRMNgO5In0EoENSYFf01RbHn12qCxfGcw?=
 =?us-ascii?Q?sB0lDIryFuOKEeX9xIacBoPNTp3Qd35SQicVgJ4DPlBMBQJPTOZ17T8W1N8v?=
 =?us-ascii?Q?3cgXJ970p7f5lo/m7VEgbYNd3XC4zRdQJTCnOpZ9x8gd511d4I3Vh01+SeaE?=
 =?us-ascii?Q?+fVZJx5CPyEwh3MWTtM7ddixmPgeVc9LSG+65hAt9Z2pTau0qVwWmuMA/OHI?=
 =?us-ascii?Q?KlFq0pPwaF8hinKfZhcltd018rkOlJirUaRmjC2pBOb16qKeE9sa1ltS9J37?=
 =?us-ascii?Q?ppah2L9kg+wbwpWaSr9YwLYBmJkiRIFr+/Wb+6witEdbnceK7yM8MoFdEuQs?=
 =?us-ascii?Q?aqSyErIBTsVeX1sekjadTskL5pzidhoQO1j2e2UB643RevsKurHgJcShvEXi?=
 =?us-ascii?Q?3C1rPKLTXidYai4FVK4YXQ4nZC+srU3hKokRMRdV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0512aa-7e3a-47a3-877f-08db970ebbc7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 06:22:54.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gT3ici7A1YIyuQk8XO7ZOKSznjQlwX2MeEQhod/Z9TJ7bezt9VD1Tfbm1EOP+mgaBWD9gsZb5nCD/5ss+ddog==
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

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

These new helpers will be re-used in the following commits introducing
new tests.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index b2d41024c6c2..51cbd1e14156 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -22,6 +22,27 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	return open_netns(NS_TEST);
+fail:
+	return NULL;
+}
+
+static void cleanup_netns(struct nstoken *nstoken)
+{
+	if (nstoken)
+		close_netns(nstoken);
+
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+	SYS_NOFAIL("ip netns show %s", NS_TEST);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -147,13 +168,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	srand(time(NULL));
-	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -176,12 +192,7 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
-	SYS_NOFAIL("ip netns show %s", NS_TEST);
-
+	cleanup_netns(nstoken);
 	close(cgroup_fd);
 }
 
-- 
2.35.3

