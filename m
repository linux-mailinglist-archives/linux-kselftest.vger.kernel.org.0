Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288F17B1705
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjI1JUI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjI1JUH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 05:20:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB052B7;
        Thu, 28 Sep 2023 02:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U94HSz6oArx59qIFEw9gaVeut50z3gEwTDZ6f1l1ILbGSyS3iXG2nI2RS1wuIsOUVd7KlAIWO2btw0Ym+fE2MxIUe+a2ByngTYMJ3WKIFI5aMBZOFKW6g5TJ42IZT9MU/i6pn5+fQmkPZzeiNA9kxm1bGkqzrfD82Ud5PO4tiX1FegyqTDZiRKdY2lr6Mjo6OWKYddTzYzZRqPyze3ilYQwuzaKVh5zUh+GG9oeYjCzNH2t3F1mCH4DXQ9Fkdp+JXtLajYUv+D+dFgIR9Q6Ne4kQZcGYqOPpyPWPVDpTjFUsW2Dt4ofuaOMjXZE8HRWvCHvpE6ZFCYy3dMEqSEuxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BqT+wCpIqCEBsDtePbaDEeDJPRaWasfDYLXJ96nGaI=;
 b=FWNCEcUc4gVoOmc3ZscWUBBqrPl00RV+IY5DNqS4nlg6WHwM7uDclNNJRTqqF2MTuBIxXLLxA3fVmYaHCuxremCSAQ2pQ7JuMwLGm+TSGjbv3aP5yLoLhqB8/xEM0eCPytM9F3A6aJYzxAAa/N6O0zKkhH45YPZl15dwIH/hS82WkDGrNOA7nsUCEg6DpPscgN2kj+G265eukP1nUdNzDj2/NMWw5IbnHhp8KcYuHsVoDukyL8Tcyu/cdrpX2CxEpUejDB0yXsMj5xIebNO7J0bF+DpO4a2vNT1Eeft1seb/x91rO2nj0rwEQvi1KLiIdomrHN9un7Yb0UGTbNUGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BqT+wCpIqCEBsDtePbaDEeDJPRaWasfDYLXJ96nGaI=;
 b=RdNMJAZ69CfpZnZjBODj5TRuJoLflua0O2NgPDBbQA1kC1ZJ4vEu5cbBZDfddjNO/2Oaa0NDO02p20RwdWfr7LltreWG4Z49RwQul4nAu9BGiSazCMl6onYRFWhEhvHnRvTRsHRkUXCoT2qCANwX2GHNjUQ8yTte69W5f2vch2oJEM/1y28kN09YMO1d1YQwbZHfgqRu3kXo3i+8EfuwQNoAL8LokxSFK3QfYvCocxWDQv00CnX6CAuntQqnnLLwl0yxCXTreQfkqDj4cxf8eDzE2DFRnTO//0UShwoWfvR3xjp/+b+M+vh4rdKFErufh9vrmrw5WmOVp3jaKShaeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 09:20:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 09:20:02 +0000
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
Subject: [PATCH bpf-next 0/2] cleanups for sockmap_listen
Date:   Thu, 28 Sep 2023 17:20:54 +0800
Message-Id: <cover.1695892503.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: d181061b-1c98-4e5d-813a-08dbc0041820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1W41PnkurlU7V7jqEzr0oNIPEh3XE9ZbtKxQ3vCWvc1hKHzAEcSriR+3AXulgFZWMLvRayuh3B0kNyoI7meSP3V+mddy47LjOQHDb1R4a0L0PkBwLxy7fhCgvpIVtIKT7fmzXfFbh4QMkHfZY81oIda/xLpJu4asHqXvBb0xjiopdLvqKK165uaoynrVKjd1FfLizF1ecG0MRrUs2sG4ReCrJXYf6QuWSSIngBErrAQUclakvdslbvIwmgRkrNDc+KbToaOIUbFinud+wf8iFNE1Ho4ERGW4HGivzSsWJQDcHd2+WC0wkbMib947Twjgcp0iqqbFatU6glNr2KnuuNFZFNIWBfDrjhDJ8/rxmzLXjFurMwT5MiXAiCEVvqPu9hiz/+LsxStM6pzySCggKX5RE2MhXze8SwVVrE+LKPk1AGzP2lxNpy8vRGR2iEEkKoC71bVFV351Um5AnLjXIZu1TyY+8GpyFMWiMKMEmjA/fFbWrNzGwl12SRLe+wj1yvDKBUbFgjfOQwS/uxUAVJ5o4lU2UaX74ambfMRLzyvnL9z8N2HcxSXQr/EhFg9cjlssRCB2TzIZgucVs4d7YM2sxT+N9AwsbPowrrMay0HLrKs7iY3N3wYd0DbrO7YKY9KRaIHprI0qTX5laaQ0Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(8936002)(4326008)(83380400001)(921005)(26005)(8676002)(110136005)(316002)(66556008)(41300700001)(6486002)(4744005)(2906002)(2616005)(44832011)(66476007)(6512007)(5660300002)(478600001)(6506007)(6666004)(7416002)(36756003)(38100700002)(86362001)(2013699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?stcSrEZczHqWUtyKj8yCr5+sNCZp+PfYupX4spNuZ315ANHjyhxuv/BSRwH5?=
 =?us-ascii?Q?+MR6CWnsgfHJilI9dtmWN3fJjS86ga1LlV8M1/TqAeGyZFVhrSr7/V76n2bt?=
 =?us-ascii?Q?RCJYAkgP4Fvyu30314k4jiV9Pu0+ZX+v1QatFh7uIK/xahxEVLEUiqdb55bv?=
 =?us-ascii?Q?Fj0wptABRtUvCHlNOyMCCfGRvN9ggJ9S1y0iZFRSSgi6FqeoQduZkOOY/WKf?=
 =?us-ascii?Q?tFUfJ8UsxMBs1ba6FBeZeTdqUL8T5MmQhgiajGelYdPkWyRnnOdO88DMARpL?=
 =?us-ascii?Q?dsFraIj+DW5fpSaYsye4fbLZtorHYK4PdUMcsLuI1YYST3oil05WNsgrKVHQ?=
 =?us-ascii?Q?LxgvV6SQ6XDz5QinQhfD8IgWhWZinRtFze5x7liTR8IRaZqBipMjsXMXdTEK?=
 =?us-ascii?Q?kGcUGpm9RDlLVS/RzdBuqClDFOUT72Fstbc4fTrDXbIXHFEkRcmPsDMyKnnW?=
 =?us-ascii?Q?NnEvNrOzrnb0cPS2e+Yg4js7vpkHEPZe/LLu9teMrzTiZjF5c+kdIIMTt7FV?=
 =?us-ascii?Q?P3LUtOrNTsqP3zu27VAGXDVXrKh1YGpXr1li2G3hPXtQIzPxaktzrlyGteEn?=
 =?us-ascii?Q?+4LCDPS7xa+WbIZ42Us/hwCILovQqNLVM/PDpu2KjxtNgFT7EVEEItzJuJQH?=
 =?us-ascii?Q?UhAC/STHG1FcmFMTTkqC83Dy3jpSWoqBHRfMk7klnIYbsD4x0hZq58tDT7nN?=
 =?us-ascii?Q?Pd7cy0+SU2fEd0lZ/T+mYV4Uiwwqt7urd3ukXl9twgRsngFsKotr0z9/5MIj?=
 =?us-ascii?Q?sNTjwGbQUjNssJg/6aeb8fPJDxbhSE6inWZKAc08lxTHlpbwC+KiQIQrNz24?=
 =?us-ascii?Q?K0rGa8U+0UcfNFN2QCGOVUAtrn7OsaJLW0rNMPfh70rBJtvuKtS7m262eDWZ?=
 =?us-ascii?Q?wkh8jnrhnNqY/HkdpvMlC5fwPgCsyRRz1PE2B9J2rWo3V0nMcmz7gNXFKTNZ?=
 =?us-ascii?Q?Zu68nLxAvW3S2By6xNfkQQYUDIBOSVdPE69uM4aXg1m3txxksfE3sfC8fPBU?=
 =?us-ascii?Q?gYAI4eumT3s52N9dIBpcAGXEqjw4xmpppWBbEeJX/DbTl8lXBsxfQfwKY2/g?=
 =?us-ascii?Q?NgxvzP8qslQqxsFQ/vhvmTHFjDBTw27C/3+YMxjlAzbJE7gIfQ0/MEj+Ywb8?=
 =?us-ascii?Q?YJSB6YY7i1naO+srjEJXseJR6H8WgIF+ktgE6DegEkCy0h4AvGA7lq4rbnXy?=
 =?us-ascii?Q?ZGcdTXZn4Qi7dHm/1iJeE6OiD6BsMM1o2xxG1gJAWIExMXAbPgRWlG9A7x1Y?=
 =?us-ascii?Q?elz8lnt4q9N3oBph4IfoDHHVnzYNHHtJO5D4O+At/yBZyH0GspVotkDtOWxD?=
 =?us-ascii?Q?NjknxTBtrPFYaoE+fjQvniIQgxfRK9Gck8nMrTuHeH+RUwlIpOnNssU6rI2S?=
 =?us-ascii?Q?zFigblo2VOehw2mOP8ZFs35zYjwfAZR30PbOhPDyQgbpA5co4jc6ynPrZgvt?=
 =?us-ascii?Q?e0ak6gFWhcyu8HJVj5caY3Be+/aAoVSkXp0WQsticiBN3gw+zhix6eM+jwhI?=
 =?us-ascii?Q?UdcMAT9kOc6nFNT3vd9G2YHj+adZ5dFCrgldAiq4Mv7B4O0wg+etwSkE5JA+?=
 =?us-ascii?Q?w85fcaZSYEercSeTRlKbvI3B6YbUZHCYiK2UxCd0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d181061b-1c98-4e5d-813a-08dbc0041820
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 09:20:02.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuv9FPcPlr4o+Dmfi/3Oi1qVBKXYawwIycx+XDntm4X6mh8DAH7xlAmrpHKQSa7D45N0lVWIrR/n+9wUW/wiHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Two cleanups for sockmap_listen selftests: enable a kconfig and add a
new helper.

Geliang Tang (2):
  selftests/bpf: Enable CONFIG_VSOCKETS in config
  selftests/bpf: Add pair_redir_to_connected helper

 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/sockmap_listen.c | 149 ++++--------------
 2 files changed, 31 insertions(+), 119 deletions(-)

-- 
2.35.3

