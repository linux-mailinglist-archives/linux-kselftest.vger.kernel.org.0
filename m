Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30927BA6EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 18:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjJEQnV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 12:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJEQmC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 12:42:02 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9077A95;
        Thu,  5 Oct 2023 00:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPG5SY3XASrBPfwtjD41Zdn3y8eOUxStBtH+77WYvSi5I16ZtMT405wRjPtpWh5sHub4p7gs5Yale9R2AeyuYq7S3Pp+o44PQogJ/Ey4OkkYT0YO7mBrJQz6zBZ2DKyPezv3l+fEGcptf0Jo3t3owlIKSYGHpmWljm/RRIfe5jdq+tnQyMWu5nemOobfFKpAqjSV5CR+W/wqSiD2clUfhVWHPkz4bqksoG6Vv9j2yvaeM/1jhJbNOoIuTeikewAsAaH4nsdFgiKyHJ8duSF286tdhWnAwlLwWIn0wPfqtae2U6e1FsiKXkj0japtTkqkZznL8WBLXqwcUt9XAmxy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag8SXaXXLMV3JX+8XohuWHEDyt1XMnhY1T8ayPocXmY=;
 b=e/0hnfoxUiSuE3zX5kJ6yV7n9k9JHNmtqv2D77j3AUtU6EiSZlrKtbs649gth62wcqDSny4IPqgOIiSUX19Fep0NhXMDq29KQUNe5Vx3AnOz4o06+Z4yDuINgJeYwZpmcB9VHZyS9XCvjXRlngi66GFpQgXcar4KoOc9XAxHtT6tDxKPW6YwdYoCBaPkcaEXQKMHRIQcdxZP4mdMB45sWbn4JgtX9V2l5k9x/lH05phM4zQUIyqeXRXBMroHjMUxkEsO2b7qpOdEMLIWBqVLz1FolbKW7BZ5ItGO0l5gaIx1rqVMGFU2/eRU+2G6vZR8vUPlxHHD3LkUwQBSQT22RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag8SXaXXLMV3JX+8XohuWHEDyt1XMnhY1T8ayPocXmY=;
 b=kDnK3aqqguor4HTqYMubDDrmZFEovHJ4tkCaEAvEqvmeiM6EjFjgiIWK6g2HfiNuK/INTevefhFASq9vz8XVW372dUSXLvLHTi4Srj+IrV2We29n/4LlNnZjJjGL2M8SM+87OOazYxvOha406bwgbETNz7j9vvsMWX9dcQdNlQjMK0s/rbOsxXTGn6OQdysoRyuiuQuyXeu86EQgc7Hf4ZGAiSlT2vO0PcsvByuT9P5WrICqc6fX1KU7jFFYtYiCHM60QvvLjoO9WM77U2nly3zi5jqqP6iVDw51E37maqwTRH3tSlWU2GCYDzbHQxB5hBwPiPjU1ERXPQYf/kLaXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8999.eurprd04.prod.outlook.com (2603:10a6:10:2e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 07:20:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 07:20:48 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] cleanups for sockmap_listen
Date:   Thu,  5 Oct 2023 15:21:50 +0800
Message-Id: <cover.1696490003.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 741cd28d-6e02-4ee8-060f-08dbc57398b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDKCPKy/CWl5LywlLqZICyRnL7AsVdXsAPsKycM+j6XVJBRzoYDViHdeuCmpISOiH2UKjGoO7JBBD78MCUDTcsRe6swJ7FfZm3lyLHptonhPB+oU1VxW8pdNuFusKbUf1aWOIAqLaMIUkJdBX84rfykY7lw7RctKmvK91eo5+ChB1S+MimsZRYjGw08IlYViveqR4Rt3PG49FS9NJ5Io8SKVZY9L0fjHCGFc/YqP6IFQA4wPhCCEAz5MtDMPvXlKuW7KoDUlkVEPWk+FjkuSmvimIf5JMKa8AqGDmgQ0GX6V+hvEAAZ8bb6skmB+mg8jAYA1c/yT8dnvqBxVn0XnNz0CCXKXUF0rMFnlolBMrxBy/Bi1kSfETZQkmeHNRK1xePGnikWrqlbUaNVMdVrzjSVWC+Kd8cMTgOV+9yUq2ifmTzmU3xjXAoTpyVRZKHVhNszLeO8d5f7qPfxDS6268I6a3/KDwRk90G3wyLquM02KWDEjUKHVxqZBzU1zfUEaTmLvJ34QLj9gH0UdHQrqeU1uQjxto5gG8Hkhkzx7EnAO2gqFDDuDjC54eHbfUt2Kp9xiY4Pz16uxnbr3ZBys2qUk4nbRF8fjc0s8Uav5z8WKP2Eo/urUktVy0ShiUDj0NZ8H2pH6AG7U2gPKDW9tDv4ykgc8lY3HaVDsg51738Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(44832011)(83380400001)(5660300002)(2906002)(7416002)(4744005)(2013699003)(6666004)(38100700002)(6506007)(6512007)(921005)(478600001)(86362001)(6486002)(36756003)(26005)(8676002)(8936002)(4326008)(66476007)(41300700001)(110136005)(66946007)(66556008)(316002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hhmLjcsdw/DyGMRtDf31nnQU2fUzAbjxCEWdNTz2CjM0tCBFtkFp+M3b3Tq?=
 =?us-ascii?Q?6wDLgCCTSJRkW3ny4chQwXnlQowZaVRrB6EAdbcO/oGyp5/iDVe6xQl1mCxz?=
 =?us-ascii?Q?0/PTji0rlhoqlJ8Ua8fIFC1N2nn25mY020d7GcdtSuhDTiNoqRDX+VB/A+Nr?=
 =?us-ascii?Q?OioIKntk2twe6DGJqCgsO4A+JeoaPFz77K1RxRU5bJSG+6jaCNO9NHX4O9f+?=
 =?us-ascii?Q?fiUtWimwErA8vS8NCVEuhn5KxDYLx2imngESYZsuZTNqAEfJ8/hcny8isxKy?=
 =?us-ascii?Q?dwmDuy6NzPOmk60GwEROXT3r+YC3QjIL9nJsUA0pXq+x3fIKqVvbaLMpgSiH?=
 =?us-ascii?Q?nNjKgyiroDVMc6Q1pNrcDQQwLkZ7M6prgIfeCyhMNWnVb1B/SsqQftrbs0uD?=
 =?us-ascii?Q?kd7WqKYwwMx0nt8tjNcQCXPsFl19GKLUYSZf6KNqPTGmVXVU2rGv0wg35VF1?=
 =?us-ascii?Q?zJtczIE6C+bQ3fUbfxWuVQnBShgWEhYFrR8JuKngctxCqZQHgmhRUxOyMUcQ?=
 =?us-ascii?Q?3TmwPxZV07ZYmsAIaXl6/sllAS6eWW2JAKq6TYM8h+452p/GlKIJzSPbvuez?=
 =?us-ascii?Q?Ec+1uF5eaPSsBu/pgoUjRK7HHratbl4quKtA1iIGDjcNEp75TVJ4990qRkqs?=
 =?us-ascii?Q?Km0SyOIdIz+MO5zPezc8pNczrPra6IyAHEkMKSQjoV2xskLvGt0aP9vfzWX/?=
 =?us-ascii?Q?CTngN/HmyOK41pSd+JcjeJ3wOfJ1l95LYgBKFURGXEHBjn4bxhF7QeI9/X92?=
 =?us-ascii?Q?swHjld93HLOcfAYjvam6D+/kDYxlM4XeYAt/d/Oh4Wpm52+sWqZXJ1clJlyC?=
 =?us-ascii?Q?YX0tYml3WrVCm1qvHaQEJF5eABhOClNwq1JDS1QpjDyv/Ci1e2PZmy/AI4TH?=
 =?us-ascii?Q?rO3iP2og/v36tFfhwWkVaxrGaoK+VeH6lU2hLYgqId3OTkGh82fCiwis8MnH?=
 =?us-ascii?Q?FH4rhZjVRUvc1FDUNyPGhtyl2o0p9H76Q5CtTlT0x7nmxPJ7lsKWt9VmzbWg?=
 =?us-ascii?Q?J0uOcnE1Ojw47atcf5ceQFA+JYFFYGjgMzkh/FQuSmcGG/Bie1bXo3lnTOsy?=
 =?us-ascii?Q?rhphY7i8UTLTLhRnJ08qC/rRorqWnHfN4rDit28nufZUHpAY2UHHJXCJn6Xs?=
 =?us-ascii?Q?/NwJmM0sPE/28W05FuKNGqmUS87S4BgdQCWnnnUfQPinNjxfTf9JXu70lTKX?=
 =?us-ascii?Q?EG34Wp1STp5JDkQ1zgJqCpIMMaSeKKCI+sm+F7bAbrQ63xkyHxQnYHzGtWcv?=
 =?us-ascii?Q?Pov1alEY5wn8NxqdnyinO/z0FCxQ8x4mSzUuBEPQBC6+fCZcKyMlfpc94M0a?=
 =?us-ascii?Q?K2sUqGLK9CqMNUlDc4xhu/MtD2GdK8cl3wAbZ5Vs9m5ddmG/6utqCJGNagQ/?=
 =?us-ascii?Q?Rd/flHticC88DHjRC9uY0N9ATQ07ZtfXlpu9A06krvNeJp9DzNtqFFJ8Qv+5?=
 =?us-ascii?Q?0u5lV54VQob/onHqzo+aj/whtEyt6tF1Ddinmz6RWrBfdbKprd6J56UEARZd?=
 =?us-ascii?Q?W8/SN3+cGz2IGQMFF83BXduF6GqK4XW76DgXVg4P74hXHtVsak0M2QREJ5l6?=
 =?us-ascii?Q?A02JWxoVyxaJtTAef6QhM0Ya94JRVZvVNCtPnTcb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741cd28d-6e02-4ee8-060f-08dbc57398b1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 07:20:48.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s07qImfNlXqboM57xcngKHmU4aFXjzLOxMsTo3NAqKrxw73z0dSzUnb19iLn5em0FiwYyKZGioLRmFg0VlnyBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2:
 - rename c0/c1 to cli0/cli1, p0/p1 to peer0/perr1 as Daniel suggested.

Two cleanups for sockmap_listen selftests: enable a kconfig and add a
new helper.

Geliang Tang (2):
  selftests/bpf: Enable CONFIG_VSOCKETS in config
  selftests/bpf: Add pairs_redir_to_connected helper

 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/sockmap_listen.c | 159 ++++--------------
 2 files changed, 36 insertions(+), 124 deletions(-)

-- 
2.35.3

