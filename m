Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456B54F96CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiDHNiZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiDHNiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 09:38:24 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF71CABEE
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649424979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/PG4zqCpA/amtV+9YJhw/hETyJ1RbUBArPPMN5WrtBY=;
        b=JWhch1mrZ7r497Uzd/+5aVkmCwT6ZGoTDhWkpkIss31eqIh1rulXtDGn/sDA/FUM1cfqri
        NMj8KgPP/Vu6SzqiE9za2BB3+cEC0mfvz22YcJ7XuslKpUu/gNaCv+dTPyedSuFQp/JCLm
        v2qW3ztbtWgj8F8IsbqkSozzplFKT7I=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-nUnpeTsyPqO6lV3coIengA-1; Fri, 08 Apr 2022 15:36:16 +0200
X-MC-Unique: nUnpeTsyPqO6lV3coIengA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAjWz8e3MQaqfLXwsVdajnoP9I/0PgyZRaays1cupQ0llo87IGPpFwL6aBomGcwOZvQjsQGtl1RTZMZx8A/BkUfbw1S2tSy7Hh47+pbrko6X4cJMP8BQOFfPLocmjfyVVK2Mauk5zt/E1NsVNAX2+ZHPzv2f/qpuhRmy2nymRA5tr94quwe87MXKNgLfuQvcBji9Kdc62/RjU96zR1jHlkzFagCjdySlpQO8ZnlAbTRy27QNEBEs6a6acTy+N3aNVvPxLRiOkWxUC6Y3wRhuIYZL7FGiXdbCUs219dM4wiwZuFUdytqE926GPaXX8rrZVf5pvyYQyo96on2eO51CDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCtl6rGmW1R29uDLXW8j9cdCGUHFu78VTUtwoIeahgw=;
 b=gMSZ+WGYp4caB+P+YWsg1GJFwzBySRXAnWNwTCWWLwDEJqU++9brpKyvEJIb5mu5xiZXlws2Qiotj+tAPiVJDiswhyQ7qBlEkp8VjGYb378YA8uPGLfrLkvJ5PblYkVZpqNmuqAuf5EMvccdeiAzRveHZxuQD4/Dkwk5OCwqyLJ8zrc4BQfB+xSgMukY/1YhOEPV3quFnksLQJaFJm+DXkxgHINCLK8J7c4oMqJimWcY5O3t3GsNJ+Q23T5l1VICrJuysb1d5W8IKgMvwXoU8IfN4Qpxq0J0IKsJ3t0rqVCSeVHYGI4aHDpJkYOQsA3WKx82sH+0cbyj+cr52Sk1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 13:36:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 13:36:15 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
CC:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] drop duplicate max/min definitions
Date:   Fri,  8 Apr 2022 21:36:22 +0800
Message-ID: <cover.1649424565.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 390ccb32-af61-4b2f-f978-08da1964c0e1
X-MS-TrafficTypeDiagnostic: AS8PR04MB7766:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB7766F5200291E2A46A7B4901F8E99@AS8PR04MB7766.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHOki9gZydbIDy9JFqm9JiU6/ozaIsd7l3APRLCweKxbUW+3SCiZMeQ7auTg0Kvl5ztF8cQgScjrNclwkDm751q5Pr7TFJf7MsyW45eZ3M2VYE9nCP0Sjhg2ukGSKidPspNdg+/ozO23LkLdGAzxaCY+kcxn8ov3uryqI7/llIcdk+hgoT/gMzwSYKc0buZVuCPiPkQTdyOev5obJr41zCg+/Vllq+xZRHwfuPio+iqHjhyP3ZxEkH6qDPkEB/JVXABFAXsUwWhX+elw8KqAEZPiCoc3/TpReDAJc7WSm34qq7aogECdPvGfghAYPvcXMWAjOHDVC7TsoQ58u2Gkx/zjoe7Zwp/E/FpIJ1Ge+i1QDIkFU/ivwPlguInxQOFzcAULOTQpFVqssrnqBXwSEE9yIPxCTDv9NMovy7QWCL4psQqN2ECQ2QNXXuVoYZTwYWSfWixOXWXkYo73aD1aenzAfglT59RJqT2trU/z7MnDHg19S4x9p/N+hcWPQMDKDHoN4l0f5rh8x9fXjBZlWMll5c1BJnm4UJhvBaCcT0XJHnXE1hw5wWxkmAPGZm4lxzmemzh7TFhXJuStmMAJvIzLPbMANkkTD0ayo2TuhjJw7uv2/cbODMp2mnKUrwwN3bS04EppO5MEGuGEM0mi+fj5W+yMxflASSmpctPXyntiCYkX5i5EKeJWPsIU1d+t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(4326008)(8676002)(66946007)(66556008)(66476007)(5660300002)(7416002)(26005)(316002)(110136005)(36756003)(508600001)(186003)(6486002)(2616005)(6666004)(6512007)(6506007)(2906002)(8936002)(86362001)(44832011)(83380400001)(4744005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ubCV/X9lGt0aA0L9UtMTkKcI24/eD6fBO6zmm7kPoBZdLCDdFIDtZW+WX90?=
 =?us-ascii?Q?4lgpciACFN1NHp6ZM7Vg2vsu2pvbIM6d6byzwygI2H6QauunNI1S9WpCiSO0?=
 =?us-ascii?Q?1WfgT4vGyv8KYSJm0qibM9xEPXbYjCEwx/U9AXdPhSd26S3JTWt4E0EuqXOV?=
 =?us-ascii?Q?3b5rnhuFlfhYgCRPHbJ9o2PT6GlB7Pv7wrF54nkfPYyFFY4qdHoH+UTvrfYM?=
 =?us-ascii?Q?NfnlR5oB5ZTCuVcXc4pMP5FQd5DWUdkwoXfnK4+/+pPgGPC5Kdz3mmeNPLVA?=
 =?us-ascii?Q?CCG9VI90wEKxgLbTVmtwpUroPudHydIzbiZUsElL0sgcGulrE0g4j2fCLQZz?=
 =?us-ascii?Q?VmKzwpohRrcVuQHF0RmV44t6NjTzMaY96UEaSyZ7jwpfHALapP5gjdhd7pj4?=
 =?us-ascii?Q?ThaK2a09uhgpnWxvtgH6peUy1JeFfa2927CH9wRsejDqbRlT1tXyZ00bzC1r?=
 =?us-ascii?Q?XytUScg5faXXgqyGh13MRPYuiW2B0xt0wFpwDCfVatzQNWXCM0ikT9M8A8tB?=
 =?us-ascii?Q?7+FVUV5cIo5G2LjCK+Vql25z5bf1r94JGjjZjdZzO0Fk4XkAVNPUq5IBRVnC?=
 =?us-ascii?Q?C6TWEACBEoz1R6lIj3HWuXylNYZ80MJrGA8AX6x0/l+AUAMOnwKQAORlVJ87?=
 =?us-ascii?Q?+elTTmVAGL5K2L0vBngACjreRdZVXUNox4akfEZB00Y1QgKzHOz9vGE0VtxU?=
 =?us-ascii?Q?SBxlhvcHa2TI+J9BSPKooKyO8dFybI3ArCoPLTxFu74k1D2N2qpo5l8+v7b6?=
 =?us-ascii?Q?28B/EvzxWETJ+oi26d14ipoXhDWWJWljfM2NUFnFVHGD+FoLUtt8xWL4Ujd/?=
 =?us-ascii?Q?68vKsNRwqdSq46TB5w7O8oUH6vfgWtzeimCFSPFfM5o2pgrgqPWz7ZE+2s5B?=
 =?us-ascii?Q?279hMFGu3k4FbKDr4/zLLN5KnOpafVEXBmV0unjISBxOki5xwhtGhOqBBSu0?=
 =?us-ascii?Q?vQX8lOd+VD/P3WJOvgz7serazDND32nMOK5g+gMkGoZxVp9eSdpzKKSnzn5/?=
 =?us-ascii?Q?w/6gZHni7Y0QmcT3QVVxrQ9Ckmjs75FiFuhMzvHKq4ZQoCRyNdQZ7hN/TRXS?=
 =?us-ascii?Q?eDEreRoAq0yi9dbRCVxnMifHxZgOAv5Eq2VyLW5no+AK1x+rY1QCW+a9C7cT?=
 =?us-ascii?Q?0yBxiKaUOvhT9aPO4WYGj56EgRYKVeZrpm8PZcQoPX0cBBhPqgeuZid07Mcv?=
 =?us-ascii?Q?ItNI+g8qRZ2lKbdRRzVBEhV35W/kGQ3aXn2MEbhvCwYnLkYAKfKnD6p6RiBK?=
 =?us-ascii?Q?abdzMPurpLpSSg1C3zNZngHnnb9s3YjGCRqkVQzoELgcFF2NGYC5z1hgc99L?=
 =?us-ascii?Q?RwmNIAPFx1vpR6ZdO09JV8PRysL1YRQVP3+sYji/CvetVHkmeytaPo6UTGeN?=
 =?us-ascii?Q?qcSZPy16PBV/Sd5G2ax4RHsVI7YL4jNtmwS0BGIM59Q/H+XnmClRQsxzi/9y?=
 =?us-ascii?Q?mE8BBJyAvaRDYYbHnepSPvs12uuwXClCVd9TXPX8AOzKCWKD8IeuIaQPCvge?=
 =?us-ascii?Q?kq2HCblXlIsMTcSdI3KUc/iM4C/fOWar3cv+1JWwfuhBHj3mDJiGECs70ARb?=
 =?us-ascii?Q?MIPwuobwGI9wZmq4brUYdBok3nqncGlE7NRaEayECWQ/dfLQIxP9wj/cvZqh?=
 =?us-ascii?Q?Rnxe7sNYWv4UjL2avcSAtyO7n8krkJd50dqGWVdwlsqj+4WysiKM0vZqjvzE?=
 =?us-ascii?Q?J/sPQ5PBGurBLpJlOnosrfzx7XXgtzRVoTo86mHsAjp1Hl5WEEyLpjiii05f?=
 =?us-ascii?Q?JK1TKua9Uznghm36Houy96lKRZT9bWQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390ccb32-af61-4b2f-f978-08da1964c0e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 13:36:15.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD4Er1B7OP52C49dZIp6sCj6soOZEFduSoAfoe5cRt9UfHETM6iey4GkBw+PBhsse3la+otHpwmKdXTZgkn3yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Two small cleanups for selftests, drop duplicate max/min definitions.

v2:
 - do more cleanups as Daniel suggested.

v1:
 - "selftests: bpf: use MIN for TCP CC tests"

Geliang Tang (2):
  selftests: bpf: drop duplicate max/min definitions
  selftests: mqueue: drop duplicate min definition

 tools/testing/selftests/bpf/prog_tests/bpf_iter.c    | 5 ++---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  | 7 +++----
 tools/testing/selftests/bpf/prog_tests/snprintf.c    | 5 ++---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 2 +-
 tools/testing/selftests/mqueue/mq_perf_tests.c       | 4 ++--
 5 files changed, 10 insertions(+), 13 deletions(-)

--=20
2.34.1

