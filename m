Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619594FA051
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Apr 2022 01:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiDIAA2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 20:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiDIAA1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 20:00:27 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F4813CEA
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649462299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=45U86sTVkTlgB5NmFrIH7fnizsit/ARdjb2tsTH/Qc0=;
        b=ThlaeP4FWWixEIN5UOHtztib3Lg8c8Lkn8v+wqrX5gk9sATOfRmRU6Cej9v0go7pUhuYLv
        ooPPN8d2flkXMcuSISJVKWrCHTLks0sbCNzgXkNYF95kCe61aMGNwXzLqUC4dNr4WAvN4l
        ik1dAp8KuGB46RdsIpNb7y+NfJRrFKI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-fgF5yKM0PAiFI4RVTdUVMg-1; Sat, 09 Apr 2022 01:58:18 +0200
X-MC-Unique: fgF5yKM0PAiFI4RVTdUVMg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvegx0pdfVW9tuq3gCpsZC5RVh9bcsxh5bQD84ZJArkMeAGg/mDvV9OBDuoRbyLYCuyIAcBC3IdWW1gx++ejJw/8JeKUEAGG/fo9+v8m/5pQR1MAo4hFfELzVPa4OLGsRck6f9Pc3GdX4qXma+nIH5SK3W5Ug6fW55QaBRbcBTyZDfDrSW6KiDjidmbpAaElXhlkwBAtnfPd2JTmFX3ZGOENfVz06va4+uPoJ6KcvlYoLvX+TqW80oCfGxWTsQFEfGQl1h+onWX3ywjl8wZG8l1zOHEZ5NYeGhSYTODArtjj/LAqkCL/2vCu1629YKfMk+YqZRlWI95x/Is3DEmaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj2TKwkYO+p7RRCRZg3nmv5GLtR5jIBZT9zdETyTC5c=;
 b=dMtMkBv11H549q1a4XvATSdzCjoDwIktrtVZg0P1tlA1yOopzLiOI/Q0pHEQdbNUJdOGY9PXzC9IOB69ayujN0gZwcIsj3NvVq6JLUPhGnOQ8bHaqCa92gdetDgtsnlxPaHNBku8+3E6bKxpJ9hmo7Y2UhQJcQ3dTLCc1R+/dVi+Hs81MW/KJWCP/XVf0hFNcWHHeIG6Zxjelly+AE3+gHmW/Ni1tk2IBo9yR7FPdhYeAgFjQvWcvf5OYxUKQCmqGaa1Co3WTBk+A7kOElAlVhkiFcq4Z3P5gYvalAq3xOZ0eZ63i/0UFbGEN0yKCJ7SGSh8Wf8n6CwQYNdQwnlhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4430.eurprd04.prod.outlook.com (2603:10a6:803:65::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 23:58:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 23:58:16 +0000
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
Subject: [PATCH v3 0/2] drop duplicate max/min definitions
Date:   Sat,  9 Apr 2022 07:58:16 +0800
Message-ID: <cover.1649462033.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f51954-7406-449e-23c8-08da19bba596
X-MS-TrafficTypeDiagnostic: VI1PR04MB4430:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB44303D95EF96D2323B2AB432F8E99@VI1PR04MB4430.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8KqxilPy4HnbSfjzXw0aSjIY30LJCB3oZTqOzLZml7b07SRMdiE460PMmcrqsSAs9sUGxmSnfA8kIuckJoULgeDatc8j+n/1siWmKbyRRbGfVpLqKuClS+y7Y85snoWusg8i6Za+SLCKTR4XLbCy17MYYl4LBqpkPRQx54m0WuUvOh0FWrxgFxStn5xMpVE0+uHPyqZasur8tnSRkK5FXeCd+x4B2TJMKkxHiT2QjEXgm+c5BhQQcU+yqWvjhoweqKtrMTSJQ6jwh1cFqAbehz6SHGRTK0Zvef/qZCk78ArWnOHcKETdKiZ/8KXIXutOCU/ITj6b0kqk4MNESHZdXqx0ZezQ47GAX+WqC+lDWB3hvFbzGN1LFSlkfQN2WO00DfvcrnWtboJEFXO122CqUqJN2K4FQo256tWaUs2097GU9haQvN715wuLze4dooV+F0Dj9Z/yxrz5tfNn4hnr1BnMJ11onsUy403VIdWstMw4JHZGhW06AVXMveg6SXRRO4M2VUmqMr1I2WWEDZ1Xe0prjJJKBmZBNRKU4lrMKQgYVIZF91KRYVfy2yYGQyd4kgYwO+zWOeO4WenhJFzURTfUpbTsg5+nKFT5cAAuwzXR0D9v71sgDXkBun5kFLsNQV5dGY+O7J0sqp5zOt4EfDDNt5JnXQbEWNbieyH/2s0jL5iNiyB1fP+m4T4fxf4EY+87icEpuVuZR9uSzv+2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(83380400001)(36756003)(6512007)(2906002)(2616005)(7416002)(4326008)(6506007)(110136005)(66946007)(316002)(4744005)(44832011)(8676002)(38100700002)(5660300002)(86362001)(66476007)(66556008)(508600001)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1mjKwIa6DQUuLPdm41iSxM335Hvl7a5RbKcdWCu4j2v3cr1H72frykyYC1j/?=
 =?us-ascii?Q?BpymnvRTHjIeSTg8kSIYRB8ta7klB5pgYRrfloI4X4IkaqAD2KH0WhK6qHyG?=
 =?us-ascii?Q?W53HHNmAOxkg2jdnT3/bcPd7YWWVE9ylXpJxRsWDBKVjF1NoMieoQvQ/sYls?=
 =?us-ascii?Q?QIBQDn+tb3OBWZ1Ngoq7tjHK/uqWVBsTbIAk8qpcNmA5Gy1urgXYKY3plhcM?=
 =?us-ascii?Q?DYgYBqSxdKipOinJ7Xa0DIzvvdX672ZEwydpKp1xRMM6tTHeQzahwwnN2BZ5?=
 =?us-ascii?Q?GJyFO56+jOKPEy2LmBP9hPXEq6m+epZH1Wc6/RdFMvLD4pNMvEXuO8lZastf?=
 =?us-ascii?Q?QUK8Ikq5cDT+XdXrJ1SxIYdn+0FPnuGpjpAQ1KquIqVnxMi8gmwKw7v+XLvk?=
 =?us-ascii?Q?w98DxYoqwiYiQYDG0tiMaprAExdDJxS+kvl8YiLdNHEIHayT/Zqvfs8sz8ol?=
 =?us-ascii?Q?8YpGGveJ/08cjDJDXdAPiovkANS7Q5IRx2oxbk9ncCYX8s4pcHt7ujGRr8Gt?=
 =?us-ascii?Q?/bE26UKaZ3pD2jydgMKFNFuUzJEPh71qmG//VZT+pktH3kURe/4Foi5mkuop?=
 =?us-ascii?Q?9baUrIHPLmEWGHScsVlghD2U//55ogH6bdkN+iVhbP2+YiOJWgO+97d/4lCq?=
 =?us-ascii?Q?m4D6xHeIARsae7GU5nwSz0DEZdmxSOmvksO1g1inmw8M5PAJ503x93KZRUyI?=
 =?us-ascii?Q?plZc53jD8kgqUmrCIgV4fwyGwMRaVwZDLGL+u72Yv7xQpiKk6IWplyfpSSN6?=
 =?us-ascii?Q?ouC4P+2nPoR9POMGwweqis6hRcZYMwi+VsKs1cgFw36yAWnFcJyxSui89f52?=
 =?us-ascii?Q?rWT/BqD9IlvOsjemFscwH9t7bo0/0LayPhmQSs/vCZaeCxuxr71dJUNCHcM6?=
 =?us-ascii?Q?n32nVZMbxhrPvInu6HePELeOGhLLV9DmULrpuBCuvP5Uo/TzSqJnbCUqaJfV?=
 =?us-ascii?Q?k9nHQ5GzMqszKROgt0gyTdP7s05fJyt37bVDSs7xInslpEnenfTmvnIjLoeB?=
 =?us-ascii?Q?B3HKieNErXTUhgtXRtROf0bf3dz5y04N2V04wF0GT+RoB/yW22yZGPrqY7dK?=
 =?us-ascii?Q?uoGD7BYIg8BukPbbW9Txx9r7PYnO7Ada0xNlHytTkUI3XtLYoLbcWIeoK/KD?=
 =?us-ascii?Q?HBYjUbID93R+/3wyc1G4E3asMcsle+o217UhlWgNcR//9XE/M0gkeVFePQZs?=
 =?us-ascii?Q?/JzdV9rM2IGeuoOtRlvZNeWnMdw8/CAzOfV+wqwDbve3RPA920qoaSMhJata?=
 =?us-ascii?Q?XmNHBPmrK7bRFPYS+teysGbGPuinwvuuAbaQ5hiuC5sUN4i+g3Be+XIMkz2C?=
 =?us-ascii?Q?Budc+uIQ1KhNNcJh5/tRp1iJpFNYnNt7+M3zlwkr7+5wPGCyiAgXD5s4jeW6?=
 =?us-ascii?Q?IvbESiywOLDI6PIA3XFWnXTsg93+sWbvZIT4YtJxFJKxFMbAILW72ufyswvN?=
 =?us-ascii?Q?UH3mAOGQoaw252mcLVDsP2rzFGZlgjkQ0HsisMjo9AgOOGJpYAKqOpzfutNy?=
 =?us-ascii?Q?HEAcqVmM5rkWx6UWyaQ9JjZAL7wnKash83ZOWtPlwhX6GwrkLpr+IGHiR56a?=
 =?us-ascii?Q?+2jFKFStJ1JG43Bnsjtdh9hUqj67kWUqYRIgX+jqKOMPDU1F67wawMs9cHLG?=
 =?us-ascii?Q?3uFYn5hSQApOecbHTYQ/go1/tq/ACf/tHUBGMfN6FMF8KD/ZxpgrU0VW0ABp?=
 =?us-ascii?Q?KlRQH5OGV2Nxq8mp3+GlG3KTI1ABcQIBwFVRu5mS7TJ/DpVy78AJASutZJSW?=
 =?us-ascii?Q?WT48w8l558trOb+s1hTqKeDbp4JewLc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f51954-7406-449e-23c8-08da19bba596
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 23:58:15.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+gaTEr6VqepQunji5lkuoOYpuw8mtjnAbw69M3DgyUCpJieGZbWojhupyPNhYWxVv7znCD8z2AHq3vt9UxpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4430
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Two small cleanups for selftests, drop duplicate max/min definitions.

v3:
 - move '#include <sys/param.h>' into test_progs.h.

v2:
 - do more cleanups as Daniel suggested.

v1:
 - "selftests: bpf: use MIN for TCP CC tests"

Geliang Tang (2):
  selftests: bpf: drop duplicate max/min definitions
  selftests: mqueue: drop duplicate min definition

 tools/testing/selftests/bpf/prog_tests/bpf_iter.c    | 4 +---
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  | 6 ++----
 tools/testing/selftests/bpf/prog_tests/snprintf.c    | 4 +---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 1 -
 tools/testing/selftests/bpf/test_progs.h             | 1 +
 tools/testing/selftests/mqueue/mq_perf_tests.c       | 4 ++--
 6 files changed, 7 insertions(+), 13 deletions(-)

--=20
2.34.1

