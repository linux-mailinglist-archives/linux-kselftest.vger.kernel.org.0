Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5C779CBB
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 04:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjHLCyK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjHLCyJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 22:54:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A3211B;
        Fri, 11 Aug 2023 19:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTX32DCiZo7iXhvWCqZ8fLz0ZPyOhLI+O2jr2J9uJ//RUxBwTQWX7aO899I/iADj6OLzMR2sN+2M7X/t4xfei1982bGGB4UQ0410uRPl1mNqqIBb9HRj5P9Pqwh0GUsGUBPUzPLwxEFM4GvuiFokyNIw4N/+ivltCInqPcn1WNgTMsNsJfNwUjolTZjXBWkB6lMdVoe5CvKLauru8Mk48aIvPp51NmXk0jBB6aBgkKWb244tP5LMAH+Jh7Hu/VaA8eyH79WACfhCDNwuyqDH774amJjfAf6WhDANkyLKkiKjn4+ImcNX8tJG2lAQ1DfCyNYnNDg6xwB3TdAuvpYWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd/8kfPIc8VH4juBd//fMuAR8mCKogVt2f5lxjDZThw=;
 b=cr/HfnYhoODgohYoCeKKP/Lw17p+CB1o/WmlEEsaRCxMk8VbJxxNRXkXsQNTF3kdRko8kVq2nhGfZXcAYl27qs1jjkQ1snYsVE6zTGSvEdsNVqNwmF9R4VRldo/WGx75aKTpUPHbbVXDuWNjd22MpaoLzwER295sllZsvnaOJFwLFxn1fn3sLbkJgTb9P5cSpEmV1mO5GIPLmrgJIdx2MKyvrQn/XHHGAfEC1efLK8JIum94t+UwOWB3jSrcksHGKquIjnX5ObhaUnDvKtAbnWw7GnUEjZz4o7XMEHX4RK5qcTJIUvGh5qJBZbmdJ68EmXB0ISKqUD4FMEZzm1F+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd/8kfPIc8VH4juBd//fMuAR8mCKogVt2f5lxjDZThw=;
 b=j3V6qTjSK5dJowI9XQkHcnlGNRO06C5HGdwtD/+LNzIUPq+RZUQFx05htCzHeDN5pGcuFI8KIy1MeZMhncuQNUPRnHeKIHNEKzj/TbgQeatIjTRX0G2JT/7jQkwsc/QP+BhvvraY2JqMEPHBvZaPO6jCla5To/xtAaCYFRBB0dCWKfM0HDvb2K6z0xKelwh+qmNJlw4JKRjKEzzfag6jVo0szikQxnkOZed2q6K2RdZp8SJB8GtE0PvRsWGgNT9uMSWpmOmGFnkYKmoiLJ/cnuXGYSFXX+FxLxVUNqUpTGefrNiuwnTd5QvVI76sH3I7GdWSPXr8CryFdhMfKxTvog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Sat, 12 Aug
 2023 02:54:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.022; Sat, 12 Aug 2023
 02:54:05 +0000
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
Subject: [PATCH mptcp-next v13 2/4] selftests/bpf: Add two mptcp netns helpers
Date:   Sat, 12 Aug 2023 10:54:08 +0800
Message-Id: <d0faf14306571347bbf1f36428af954d46b9bf3e.1691808484.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691808484.git.geliang.tang@suse.com>
References: <cover.1691808484.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: a34c7d2c-bca4-4938-1d23-08db9adf63f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQ8F6+ZjlP3OrjPzHYNw2sKfh/QEqXmV0PnQLnf2749HStROweRcaN1W53ZI/o7FHNlDjm8DOiocuP+4ZAO9iQi+dw9dRkKgUulnA3Pd29Scfpv9n4jlkt/0UU69FLV0JzDxxe2R5bX+cBedDQDe+EXoKhD8knkd5vpgKo+A7c2GGE1hw952zXcQBdPFIyuz2nCYRoZfW3uRw0z4ijpbXIeCrgUMFczhdpkwQz5YhgE9veYxi49BcEOnvT6Fhea3Z2ISxq7cxlwcFi4Pm/o+SDjNvXr6bX0naUWY9B2HTWfkSsgRusfkZX/EotF0nkk7lVZVn7eDA+Mmj3a+MKUh6MqcqFDtk+p/Ak7nOxL7UjLMoZkEgGK0YuakiIphUePsh/jVgAS+zKRL78JvVeZzH8ECbfQfzHuAVYoMMPib+Z0zrqbjVBcNgDy2Y7HcjIq0IO3LaSt6Xx7L/+SSRwPBkqnDxm71WJQTyvu+e51n3/5zJ+XdLERtT0CLjbHJaQaDaPkKKOw6iQkR4N711NQEFMt52GDYJnHs6iU6JzcVtvuFLXlePipvBjotbgbitRKo2h6V2xH+Kuz09Kbi2K39/IC14UOHN0Y0P5SXnABowVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(1800799006)(186006)(451199021)(478600001)(2616005)(26005)(6506007)(110136005)(54906003)(38100700002)(921005)(83380400001)(66946007)(66556008)(66476007)(6512007)(6486002)(4326008)(7406005)(316002)(5660300002)(8676002)(7416002)(86362001)(41300700001)(8936002)(2906002)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?snkuNYnhY6YIeJnQt6kV2TYxrzLmx443ej3/QZYshewx9VCD/Xgj0/AUTxmh?=
 =?us-ascii?Q?4TUf5UnnljrGk7Inja5P6/jgC9rKgfelExRpUHFBLkHgqultgXlTWEvlNKqX?=
 =?us-ascii?Q?prtz3+yFVREK09+lSPqM8lSukLdra/ctF/rF86YSlfqlC+Dvb0FZFqRScM3R?=
 =?us-ascii?Q?eJUjqQu4UWv3haICd1TEcnBUAGdun1BddnS0PTJY7qCoKkI2x6CHdAW4QR7i?=
 =?us-ascii?Q?CjNycv1hq7ZLAIOndanUF6KZZ/8LJKx4HFbzeliwf5wUWt+V3QldWoSqEic8?=
 =?us-ascii?Q?92y+iQ45zhYcUUgtKWB5GlVt3dJGDDLjYmqe20ErSg2bKSmPaVlb6nurOI1a?=
 =?us-ascii?Q?sHB3SuDO+CqjQVUK576cYddMsOff+f03R5z8dSJ6ix0JQHqP40nJodvEAehz?=
 =?us-ascii?Q?Xw55TF96keFm3rCpPiqvERDKdS9wcnttsiceRIW/fohcDOD2EQlkR90PGfDl?=
 =?us-ascii?Q?1VQI1nqw9ZsifwsN72RhvQgs+QXs0CowrIClgFYs16jLH1UFtKwJ4YCfr2S8?=
 =?us-ascii?Q?e8O2j5wDvMKvOmONA6vcCK64ekoP/vGgjZC93N4ji4ueff0quGLmIrs9PuWS?=
 =?us-ascii?Q?dsUoEoHdOoSM5NXyvZkBv2OtAHenMIhaTRGpFpjM0GKbHx3Dw7Z5YDNORG7R?=
 =?us-ascii?Q?A/yfD3dJK5nKmK0qKyZT7y+4+YZi5p9iUl4RuKWFC+Le2tWwdyHQuKGYWiSR?=
 =?us-ascii?Q?HAOgke3Yo/jpt2uSE1Rt7dA5Q1ybbnPsR/Co5jfaMvZ3KbDIB/fcidD1lcjq?=
 =?us-ascii?Q?FXkJ973GbMIATRHkpM0AsoBFNrxnzdQ2b0MMajz0ZGRzhbXSbDFHJ8ffj0Wk?=
 =?us-ascii?Q?/gBtfE/v2TDr4c3gvUJ+7DigddE+9wAuNBnw08l1buFSfWzrnABIL1dPrFPC?=
 =?us-ascii?Q?1pyo7gvbtuF8CNJUeqowihtDgADyZOvZcc/cX00+BfN7plEka9ONNp2j+SOp?=
 =?us-ascii?Q?D6IUaEi+tO7zsWip9iVBQufGm/r9OLnBTTCQvhIcc3tfkbi9eeQ6QxkEbQ8C?=
 =?us-ascii?Q?zjh3uUpuGGyXbr0ubIOd9zbF7OuQFE5OYx09WDJIR/UacjhdmZ/A+Z6j1dfN?=
 =?us-ascii?Q?CaEYBd9gU0Q5rAE7U8X88cbJ/Pqjzo5ElX9HHESgSFSYHR1xg4WPT/O3H5GF?=
 =?us-ascii?Q?LDnjvuouh/za18iJdoL5Avx6NbLMxRXec6PIPPikejmaQ2m1/EXsNkBIHafq?=
 =?us-ascii?Q?A6gav1sP2R85wI023m2qek6bJhqZuefBvQ+sxfpDStQC5Y4mbeRolMFTcwK8?=
 =?us-ascii?Q?S5zzg+T5m8tMyZbmzrrNDkyBzXUlhn6AAtM79TfxMwKCfDw8y4DmYDBeoJzy?=
 =?us-ascii?Q?qj1YS9iEs5NAzIzOpmfcxDCvVRYfQq0CH85bWcCnXqr3wz+JVuos1M9TYdMG?=
 =?us-ascii?Q?EGgC9450S3US6JzpVY91UgH8OPMo4Kqlpbhfi8OqMvOFSI5xVpUe1q7Hg/DZ?=
 =?us-ascii?Q?19XiJkhLx651YoRpuqmSrVxO+qr6J2jgAVs+qyWRhtTdrlqZbQaxn16TVNQY?=
 =?us-ascii?Q?zakzyxNPMcMY9kDgaeXK3FZZFfIXQPhR+105gfjwJHLE/Y7BjlszlM96LTEf?=
 =?us-ascii?Q?msap+aFuU8AGHxq31wnAf7sVm3lDSc19MpiNHF6x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34c7d2c-bca4-4938-1d23-08db9adf63f7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 02:54:05.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPMucEqu5L6Sbp7rgOM/+AZV+WkuNgAtbDjB8XXTNx8/VKT1qmOOhpbjLzUhtdWbLBZBQ31zZ+WKk3iQ3Bcf9g==
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

Add two netns helpers for mptcp tests: create_netns() and
cleanup_netns(). Use them in test_base().

These new helpers will be re-used in the following commits
introducing new tests.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 31 +++++++++++++------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..76afb5191772 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -22,6 +22,24 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
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
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -147,11 +165,8 @@ static void test_base(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	nstoken = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
 	/* without MPTCP */
@@ -174,11 +189,7 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
-
+	cleanup_netns(nstoken);
 	close(cgroup_fd);
 }
 
-- 
2.35.3

