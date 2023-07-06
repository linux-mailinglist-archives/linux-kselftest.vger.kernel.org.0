Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9273F7498C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjGFJx4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 05:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGFJxz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 05:53:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AA6199E;
        Thu,  6 Jul 2023 02:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLBIZmM20nkB5foSi4ApRPB7LOGo0DEdULm+jAgZ1yEAQOd6qGZs+Bbzo12IzJEjs+8y7HjE39C7PId0KjI7Ykb8kcv1B+ZAS98t+yI6EnVfVIScBkH85PYK4Ai5xBHJWGXFEoyuhiUHcPG6G6Y+zC+VExAAI1pr01zQtERALk7gFFMjSoNz+2K1BEzZEsTojgBdydEDU0HVcn8TcTPCw58APtid5Kv5OfIa1ySveiSUBr+FNcCS61Wrghl0pDJVfMCHI7z2mt1WKRTXzKVYwJldso4e1vMU004H/IWSg+dXFHKzMehNZ8aCV6NJvpZlshxDAi6kjCQ6nkybwcPcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrSYVg+DOSF4u8ZqpA2pmr2F2vdzVuOLyy4VG83Sw1s=;
 b=Yh+AC1Lx21VDxhGT089iG6BlCeH5a/aIxc3kS2kW0g15TDiPTn7Y5AI/3Kv3p31y1tbDYA/l05EkIUQfGoKT+b5EId8h1fhB/VHeWycg8KQwPRo6w4nOUsFcpshMKoN3o5lFDdQjAmk7Uzg2ZkblOxaM/WFBQxZIpJtZVQr5PUdpJNoRqzzYILL6kZ2oJXqRb1+aQ00vpLSfd0vBkrXCtcVPnNpKypK3SCJQ2E6KteARoJQ9nbWLsS09vSg3a3ZZZ2IJ5QNRjEUbLqCQTuUdYfTTsWevdNSD0Grse+zKchlSN07VdZIx0H++B00f3shmmRd6+9DVQkpsZjgEZyyKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrSYVg+DOSF4u8ZqpA2pmr2F2vdzVuOLyy4VG83Sw1s=;
 b=KxVryQm9+IufQ2xtzRJF3ET1/9DnTg4OxirCyn1X4t6sGCo4tQeUrjKgUw4yWOOQ73L99d4xNrOVhghh8oSWvvsfZDd3IzikIZu8x4tO4IOADh72Xl7UZ9lU/apf0LO9tY4x1IBH8YvBo8A/1Tidv0FWKzoyFfVWkvf5iSwxfJrqJ6C1vahm7Kgzm+Iu8W/Gj5JOiwttrbCTsviq3tuExj0TXg+TCxQCC4FiGc5adyVf/Qf5ltQrDL8+4RV11Cv9cWL1XaARrL4GRg2drI9wXb2VnqaHBvgqF6xvJJgyPjgLfs3Q3NOqbsgRwtQfN41IB/UGJsF9ZAQmQg4jLXpYfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB5661.apcprd06.prod.outlook.com (2603:1096:400:28e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 09:53:50 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 09:53:50 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Lu Hongfei <luhongfei@vivo.com>,
        Anton Protopopov <aspsk@isovalent.com>,
        Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] tools: testing: Corrected a clerical error
Date:   Thu,  6 Jul 2023 17:53:38 +0800
Message-Id: <20230706095339.4048-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:404:15::23) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 84326aef-6659-4b2d-89ae-08db7e06e66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ye1l1Z7q3O27I+FGlr28qJqVPcf8fKKkj0YQrqqHJDW95u+ApBONlTdm0Z+3xVxxQykcaIJcJjz/PFDi8KCXez28T2EvptTcszc5GLX6N55SayPFnRnWi+XgdFoQ/TRTW1lxRSgA8cS4O4BtPFlQ5k5R9gTj6pBcIh6+tXQoIe7eAOtUknCYd7kK4dpktNBv6XZJj04mKmejNsQbmbXC8+j7UShPK0Zkxyw5swHVc7UXdvTZpyM8RLkFmmz6gnhL/elvdiwgrdHTTvLTRtNgPcC+z0g9uvsBIOzsNui+U8heuqmUVjGiXJRmllQAgYUgq10q4VjB0Vwb+6q1fQrWhYEe1e8UElF3EVL9c291ghwbl17gGuO300veKWX/GbTUuGdPWnwjvfvvZ+knm58JB9+Rq9xT6MPt6qWtTaUWy/cRyptIEF82avy1Cwuz71evk05fvLfwirKM5qeuI4QImWQ7ppYe+4ZPkJ8tJzF+rPyoElY+97Nc9oLB5pzOX5A2owqOMQSkQ09KBkdgRPMtVuRuRUGLgBWQLUasbLCdG2/4hlRDbZYT2pJombz1b1HAeYB3K04YK92bbOvtXroL0KDn4tWsP1sjOW5yzHmELeUXdDRusW+2xEYeFGmNIiuiS44lv4c2fKWbGeaAua6BwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(6486002)(6666004)(478600001)(110136005)(52116002)(38100700002)(83380400001)(86362001)(2616005)(36756003)(4744005)(2906002)(66946007)(6506007)(186003)(1076003)(26005)(6512007)(107886003)(921005)(38350700002)(316002)(41300700001)(4326008)(66556008)(66476007)(8936002)(8676002)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPCMn1UHeEqovu/v7NQVOJYIuHz+wkeeBU6EKGsZyXQ2O5cx9+Zr5gG/POJl?=
 =?us-ascii?Q?uZdx2ENxRuVkvcLV1dPu0fjzGg50XZ4ogl7Pi0hkNoCnSBSd2elKE5r7JERQ?=
 =?us-ascii?Q?ijkSoduw1bmLutocXXdTdGUxLibSy+1fjBdEyFOe7c586oXN3BtYC35h5+3W?=
 =?us-ascii?Q?pcXPZ82vmkZHXBfCJSjOsBfKfvTFh2LML9qHM4Hzf70+GJDy0h2rT6B4Csa2?=
 =?us-ascii?Q?LPxpkXtEvkDbAcYFwVv62iXKUVZV5cbE8RHuVqKCrySGEfydQ3xPnoEGb8In?=
 =?us-ascii?Q?WpRRplN2Q/uOVO3oKV+HOXMIU9SP2xPWkYIHyV5P+R6iWLA+k1WRY3iyta6k?=
 =?us-ascii?Q?IPJraaCUzB71dO0oLJmr+Wl4Oe4EHl1UX9OIetPGHxYHWZtHEsydRrXzQO51?=
 =?us-ascii?Q?WTJguYx0diVd5wgVikW93gDC3f/pTiOZ0uSEHPoTLnO76r5A3iW25TYEOazB?=
 =?us-ascii?Q?K76zHY6MDpZZI2zPfW0KhoOi3EGE4/LAjdPh6eHQl4g595/DoxsW/56PVazE?=
 =?us-ascii?Q?w7YaKPIhVlah/vcUCP4wfQqA5o8wgv2MtrU/M7WaEtOc1Zv0l3ziVTpIB6FM?=
 =?us-ascii?Q?xnvqIzLy1ArKxALgSlYlnsurkKaMPuBYOhdHqAjaEZdW9UHsGK93JRaUmPp9?=
 =?us-ascii?Q?WEF3dslWKTWjtw/wdNV2/yjbjNYc/d3uY/xK7o3jYmvfXlgvJpNYwS7U6Kfp?=
 =?us-ascii?Q?MzS5D/mCb20eYDWfC0A/pYpmquZ8JnW1kZBRRoiFD0yFJURG+ReGc5lcSfuq?=
 =?us-ascii?Q?jIHIUJ7mbxaZ3aUlzTqPuf4hNy0N1lSCCKuxeU4oiiQrQNpyQqPVLNhAJEiP?=
 =?us-ascii?Q?BeTsi8SKDG+HAWDXiA269HT/95mq/0ljXx71J6MEcX1sHw8FeIwcwgswLuos?=
 =?us-ascii?Q?W7X/TpA9xkI8if3hi694FyDMprkPQ8to/Bd11mASkBDLX4XVrnZU1Nfa/pNe?=
 =?us-ascii?Q?YEcPel+g83xh0nvGpqvc99vvwm81Mdg/UrxkZL/LO8OKuJiFKDOWSnS+mtmd?=
 =?us-ascii?Q?py5GAQvxetvvpwHqQPiFDHI3kV5Rr4sUiordUlVMMe1n6p3zHIxQyMVUPldc?=
 =?us-ascii?Q?RtwPH2I7LYL2BLWrYUs/pbTB4YksKni+/c78NppRZYvx55EMtsdQS7RBI71a?=
 =?us-ascii?Q?LXvfO9vxFJJJ1+/W5NKLA+UGfuBckz8Knq0ebTq67yRGouISrgWmT8zAJs0x?=
 =?us-ascii?Q?yZdU2QvhAa9dxqJ2osKgvOlNSqhSXBjVJV0A6gajZY4dlboQMJD8dBpqItSi?=
 =?us-ascii?Q?n9znxScGVhdxkWO2+95uocLvv6N9CykQfWXYQ7KwQx3sgbN29F1jJOHLJ0sY?=
 =?us-ascii?Q?2k4r8x7Q2hDutnmo8kFQoNMYyNeQAcadP59A/NsJSeV6hBMrwf+2zV1U6XCC?=
 =?us-ascii?Q?fF6xnO1gfgiLhkPOQyN9tjkVgqIaygSIgSUOe6qJdlSXD5hTqoBWW2+hVeYq?=
 =?us-ascii?Q?TcthyjcBgBDcTPtDaXkKax5/QkWdaJWNHj5Hgi2PARGpmrcvD7CPWtQvVpk5?=
 =?us-ascii?Q?/iCu5a2tui3FOfNRqMXcMBKor3p5mQ2cPPmUnCSfOBCCjMQ/ZSX85hfqdNzD?=
 =?us-ascii?Q?V75Im6/6uNjTlKCPQNJoQRNhCjxImi9rqp6j9+7G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84326aef-6659-4b2d-89ae-08db7e06e66a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:53:50.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLSSH/M1H9tUfF5Qvnh/a391XZr1lhdYa1VGu69mQ4uTicMGo5+31+LZJ8EHc96KK4bHeoG0gs/rn2cG/TW4LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When wrapping code, use ';' better than using ',' which is more
in line with the coding habits of most engineers.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 tools/testing/selftests/bpf/benchs/bench_ringbufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index 3ca14ad36607..e1ee979e6acc 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -399,7 +399,7 @@ static void perfbuf_libbpf_setup(void)
 	ctx->skel = perfbuf_setup_skeleton();
 
 	memset(&attr, 0, sizeof(attr));
-	attr.config = PERF_COUNT_SW_BPF_OUTPUT,
+	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.sample_type = PERF_SAMPLE_RAW;
 	/* notify only every Nth sample */
-- 
2.39.0

