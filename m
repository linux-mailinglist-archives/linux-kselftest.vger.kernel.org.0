Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC15D74AC92
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 10:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGGINK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGINJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 04:13:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDADD1FC9;
        Fri,  7 Jul 2023 01:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knjYqbC3ML6B118hRYVBLBHrmGDvUip5vGQmgVClCS2j9SwO/QxidLmDgObrVxU9pfXI51yZt41DhaYxuTdBNzYPBYeonhZGxVPu/Q8CgvTZgCQySlud/BDog/wqveqouIUMFvTggsZ3LtOiaDIzrZG6PeC1qKXuc4TpHpGLeYX4/B2K86KLLNnTa9eQUbRi9UrFV8BQcf2mAuV5dlGbDdIAfqlHGLumHWCu/2f5s/Z7zGPKTvhxVhxLDuUuxKMP6AvtmEL4Om2YEc8Lz20NO7zFzKYApsjjyLO5oGDR4o/HPoPsRg2d3IUXJXOlgAmgpTHi2wLtorxerjDcS06lDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWAfA4UvfFYgPmht3eaKnqhHUz6P8Go547MJGG2sGT0=;
 b=eKXGqB2xX7+lPGVO1rRSfk60j3r0yNBFIbIr+TlQgEsqMi4lQdXDuxLJfDWd/uOQp5ls/ad5zaNVpjPw8P2CXuC7iTpsxDThWN8pPLloWPnNs4+Nt+UCgjHW0XUlwLwwih4prWaVnmpLDDSzWGJRf+4PefLP+DZwL0yUN6qpKII2+r1bzmXd/vANh+r5W0wENkb++5/NL2VhXg17ZQWH/ITe67qpMySouL7uuKFoCnozsHgVqLgr3S06BlOhFxiSk1EHJmRHlHBZofESY4XqBqWJKbY9XloMXW+zt5bc+rKPVCbQsoSdNwwAgT3ZqS3Z+XdVubGswvRnYxStq6V8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWAfA4UvfFYgPmht3eaKnqhHUz6P8Go547MJGG2sGT0=;
 b=Y8NP0QEeZUx11LCDi1hs+3II/Jslj9f5gCDzMrNE6eRUERaXSfFFPBXOEMuKJZ2arBL/QOMOK1vqX1LyLjjVo1oBPu9BeGRfMZta71E+x9e8UCEg4kOA+hNKjucqvVSOnpIhVNDki5EJjOcPuKLw3v6eq1aM0AmDnCSEIS3/BbZNVWKC7K6FNXSGAbt6v8WT6BN/D9ik303ki9ShTIuwoRaV1yzs/8eTAogy2f7JN4PIj4+XH/nTrGQ3zcLEF9iSUlLeH48etBUvkVOt1OqA9076fbDsvyqXtcLxN78pYsHOLvy7ZPv+wq6tBjbKH+5KRluIzg/64qjZdVmJrfpOqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB4480.apcprd06.prod.outlook.com (2603:1096:400:72::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 08:13:03 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 08:13:03 +0000
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
        Shuah Khan <shuah@kernel.org>, Hou Tao <houtao1@huawei.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Anton Protopopov <aspsk@isovalent.com>,
        Wang Yufen <wangyufen@huawei.com>,
        YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2 bpf-next] selftests/bpf: Corrected two typos
Date:   Fri,  7 Jul 2023 16:12:50 +0800
Message-Id: <20230707081253.34638-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::10) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da0761a-ee5b-455b-36ad-08db7ec1fc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBrYmNiIfiJkdaIj/hI1JKQOl+EUMWx5t17hV/rd7UIv6MUYxk+TVRu4EBPyn3TKCTwnUxg5+D0Kx2nbzXkUw3wDi+M3o2NWmJLMJ3m+p2IiU5r8FT3puYRVU75Ki02mAniz4QtPOcf3GK3nZYHlv14k0BeBipvRT6eJwA33g1TeZUzLyPlVwt6hXu3Iq2IArbZeLEEqpByHgRjNQCsp9rdP4gZw1Lv5XHVCYa5B7d6C24W+NybOozbXTWRKnsRPT3QVxoYvzzIPRHdFtY4TXu5pB50HBSPTZ+BZWSPUJtgmZq0EVXEKeg03I8Wi2Px04sZQYrjbOWkoNShD/3VnuEdQCAgLrJ+oNzcGLYe+vrcaLlv5660lum0W3UG9z8nJ1TXN2HRgGtOjh5N3TqS0TSd3G36nMnp5/tuNy1wKm3tsu9TMO41qXcsQCddB2Ak1TVYFogdWp/tXhQoTm2bwPWnpun47nBZjDXgm4joQF5YafBJNq661BajxilMd/uOm+2vqfBGO8gpmLGEQF4YWjqFURLne1TTphYDSkbO/y37QrmIcXjoKKp7wxg3JyOgPcauMOa/Ma/Vd0suHqBxyhMNpRt2W78R7K34IAkqzMHlqj+b+pwKBS4iwKH88YMxztTWbWI6JHuGvx1JNLicveg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(52116002)(478600001)(6666004)(110136005)(6486002)(83380400001)(26005)(36756003)(66946007)(86362001)(2616005)(2906002)(186003)(1076003)(6506007)(6512007)(41300700001)(38350700002)(38100700002)(107886003)(921005)(66556008)(316002)(4326008)(7416002)(66476007)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nFT+FI5eSy7e70Vwhe1oZFzULNaEgJerTspy0Y8ir6czezdI2S1nAVKLrRkK?=
 =?us-ascii?Q?8b2FQcQKnENptI/OOEjW4j/1waA13c03iGJ0zDkz2GcnnfrTdj8Qk1mAefZp?=
 =?us-ascii?Q?FSd1jksq65jrds2HqxliRGxcgiQD0mhqjBXyqMjrTOgtchoDa0LnhPADKqtD?=
 =?us-ascii?Q?r6Mjyljjx5S0a7CGrIsF8y1jAmSKJP2UBaVSUjD7E4oXViOX7dNlAiXn5U4F?=
 =?us-ascii?Q?QoLwAVX6uWfKlndpmd3Zbu6QxSga89k/yFom518cbih8dc8CBYJM6DCd1Wjg?=
 =?us-ascii?Q?D4OpLI+5v71tG01tWvVAAFmt0KAZjuCEWUT3uJ/3so+f5MPeQeRo6wR3wv7G?=
 =?us-ascii?Q?XWcnW4rsKtt+0lXM9B1u+CrqiGRXHJHAiJx7E8NKFC1ZkdahTznGuqedBvkG?=
 =?us-ascii?Q?O4eBnmk6P4Mh65qtZX2B3jWP66KZKzIQ6x0Sp3ingxbnIRUuhz1zsJncA761?=
 =?us-ascii?Q?ZaAmprqgweCi2NtP9QbdqFYF0S3HkNl4B3Oc3rnC6/5jG9W9heilH2V6Tm7+?=
 =?us-ascii?Q?gz7MOhDhv2vYYUwbkP/La/eAwtEnZArtsft6NVIQjlRPiLu+TBdIRPquFdLG?=
 =?us-ascii?Q?2KaSxJ14GFiWgSvWPXKRjUq/j7TpRxsk4MvxZQshCW7f3wFkJ/qdH7y1j0zm?=
 =?us-ascii?Q?dKJXiAxvaAEq+Gjuaa95rhR+ga+kpDgOx8W/8f4E/ziTSxolF+zA/Wuu8ZFm?=
 =?us-ascii?Q?7xTMbzx3lgik8ILgITqz3ngC345q2PVHYv3x4a4DIZGp1hqzS+K3poSLoM6M?=
 =?us-ascii?Q?Saxkc/RVSdEX8qtnjDs+IJjKpUqi3LCzDA7x+TBw+GK8AAvPWBW70n3fd2t2?=
 =?us-ascii?Q?cm+xdbFWqzhLMQlgWmmzYn43jiO2md/8psY9fzzT/RpvSHPxFX8RJYQrAy0R?=
 =?us-ascii?Q?o/8Z15gzLY8kjeDR/KWdFDAmmigB/XTnZH6IzhMBTYGCifzX9YymMdl0JFGj?=
 =?us-ascii?Q?yP3G6QXlIPRPLXO5N5WQRDTEsGNTxhuQH0uYBd+r7P6RLCJ9w3OD8uzgj7vQ?=
 =?us-ascii?Q?Ma62qmSuf7AGjRTCcEAsxiIYioDxY+/rhgfGaLm5owzY9mFQp1wbUaPZ74NR?=
 =?us-ascii?Q?+a5e+RD4pvY0mBxmKv6fwGdC8szkoj+YRkHxkJV2KgDRjy+5o0e6dl6Csw+d?=
 =?us-ascii?Q?9ex9sgNfZuxPgZDMbrsAU5zWVL44M1Na7IXbWLyVlK6DMQwbGdj1tFDmeVOm?=
 =?us-ascii?Q?Dig/nQy6IuT4K1xD0gRLds+fDwxMtPqIzxpaZeGZ+0t9JmM15cFJRoCg3qYL?=
 =?us-ascii?Q?snGA0qdjL/unnL8k8G0D3iBcaZ3hvfzha4TCwL3+hIy92RfadL6ONPr0WVg8?=
 =?us-ascii?Q?HIX/Ybp3w+pC7q+W0erGmttv/50UhtHR50CiR90ZqIionJf+BUid0A8CB92e?=
 =?us-ascii?Q?3v4SKpN4A25/mUzU9ne5Hs+XYQzS+Sqab9anqlUe0ezUbGS6Nn5rQW9k/wvO?=
 =?us-ascii?Q?SVW1+xpi8Nzpot3kTOPiIGwEE72Ef9PsKEh0S3lE5mH99SQ2CIntbzMu6UYb?=
 =?us-ascii?Q?/OPqjqb+4TtAXqg4YU5HBJFcIMIqHZ6pUvDpGz1o7sK/O/Hz85i4biyj4w4A?=
 =?us-ascii?Q?DtyCxbHGoULM2MgFiLz532eUnGUzrJg/PX+wCkkO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da0761a-ee5b-455b-36ad-08db7ec1fc76
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 08:13:03.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jtaPce+TtJgZLuftwuHI0F3Bvmlgka7HRkzMVcqBhjeIARFd9kgxRwFDzIfmEjQ9GiHrkFC+482wRUzvIJL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4480
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When wrapping code, use ';' better than using ',' which is more
in line with the coding habits of most engineers.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
Compared to the previous version, the modifications made are:
1. Modified the subject to make it clearer and more accurate
2. Newly optimized typo in tcp_hdr_options.c

 tools/testing/selftests/bpf/benchs/bench_ringbufs.c      | 2 +-
 tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 13bcaeb028b8..56685fc03c7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -347,7 +347,7 @@ static void syncookie_estab(void)
 	exp_active_estab_in.max_delack_ms = 22;
 
 	exp_passive_hdr_stg.syncookie = true;
-	exp_active_hdr_stg.resend_syn = true,
+	exp_active_hdr_stg.resend_syn = true;
 
 	prepare_out();
 
-- 
2.39.0

