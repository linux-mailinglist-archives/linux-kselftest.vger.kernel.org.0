Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4337B170C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjI1JUS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 05:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjI1JUP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 05:20:15 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE271A2;
        Thu, 28 Sep 2023 02:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5elrVnX/jrEOEBrPmytpv6+XkJA2o135DjkMHj8gv+3BLEU5F4Sb51SDwidF1xnSyiqwRABFlnQ6i8322DoOTXnwm//dL2TtzF77oCeFR5C3ZseX/GtL67Lj5HyTMQTk857aTuc3MksDo+7pxW6YxARfmWqFDmNAxGIGdfb0oF6CeFxG7PRsRzbyry1SUBvxzSm6fgMm2UgeMRvIbMOxXePaEYrQ+5G8zGUdiSfMrMeiB2tEl982/pW7s/NW9L17VaIoUsVWkKbwBCcgRH57QzoJNDL/XS51pfJcouD0ntQsXW5KMMWMfxjctEUi3SNFl58MxP98QfSBIEym0Vk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVMQuwoQO5/3D87+dmoupZKTye3tTF6lYcDqr6ZiP3Y=;
 b=eXFsFgbewXDlbUH04dzDVIF2kuzhhONxPekC8VVZcz0vMYk3ISnFv7Gs/dKIk6vMq8WArmDen58eA50pZoYpS3gd/P+usqJ4zC3X2FlWW6ashCxus5o8N7sbhMFTy9IYImhU+8xyjTX02Rwwb0YMgg0knMhu2tg332etERhHC5rpwa6L8QaHoq4wXKqJ35iGknewFUtQcM59OlG7fdN/dNKBwPBZ5Mid46Xc7SN928dJnR7riN5xtf6col667H2bak+29fkVCIr+HXLsarXChRiAcH3189/ZFfOrFqJf0+7CMgDjUR9EvWtveGPzUng9/nS9iYGeU+QP2h68rJ9rhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVMQuwoQO5/3D87+dmoupZKTye3tTF6lYcDqr6ZiP3Y=;
 b=D6pj42S66zwiS1VbwvuF4EqSvL08sC2Uny8zXPBcRpxmEqzHyEDewbIl3vd4BdMw9kiTe+BU1xJMyazWw8c4wwtFYGsJB15kckQyMb6ALmL1vD88Lk3dFrc0qIDUBZX7wc2OnK6ptyHMdBGhWzMcgxhkJJUfJZVgDb4vgDD5kCXpsvUshNfTqDCsERrzPXhpBDKGDqKx9DmA8i/blUtLLZQzKZS/pqyoO8zwE/aTd/mKDc3Ksdfvr+9DRoTf9325b0Z5UOBjel5bZj4D9KKaDvsmeoIOfRtDPzrIhyzO/J0Y65KbiMT5LKkhAQ8UaJ2dZGhcr2M2gx/el/zJrA3Wvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 09:20:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 09:20:10 +0000
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
Subject: [PATCH bpf-next 1/2] selftests/bpf: Enable CONFIG_VSOCKETS in config
Date:   Thu, 28 Sep 2023 17:20:55 +0800
Message-Id: <6117dbd702b874abfcac7c1eb39532836382ae21.1695892503.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695892503.git.geliang.tang@suse.com>
References: <cover.1695892503.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7c2377-9286-4419-021b-08dbc0041d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MJ0Q4QG87it+wItjEt0certlFU7LDYLHl2ij89Itn2KEYuZz7a8Hhy3k25go0NjkXs2FzJ33VHOEVVAu23oipu74mDvhiKAFqsScWuxq0B3ENNvIftqWNgzmYE1k36rguaK+OoYeE6yuPsxEIIQ0e0C5ZAcHluUfF0mkz4ke2yon5UcZTEJhfl026VI+8hYCT9Wqwan+7GsQz7LDhSIL2nIUIO1hD9UzvlP9Ao5WGcccXF+NDSfbfVdAamFyjwL96XyOMwf5qsI8b7Yt9lyakCOxGrInPXUe4WKsNdeoabhBM7gaUkMa2zOuzWGhsE+/6Tuh5lSO0xfC/JCuHzopKJRubLEHsPecUZmflSuhzrNt6R69t+sFgXS337kpM/f1naO8ADYPR7Lm8Z0uPi7XtrglpVVta/D4R2ROVYmSO/bUGzfQ9RVhpP2Az/v9MZ8vGv+xC45D/T2OkyO8hhW6ayO6IuNgP0x0kQpsNSZOWVV+DAPJ/xfJVIuVwGUX2xhWOnRTvBkqGIcl6oHBTP+Q5iFbNl62fKTiMducgZQH+KhLxDhspBqYC6LYQIdA8a2ylQCrRhkOtLTVzMM6YaE4OKidAtSxrKYl1PPVKq9sCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(8936002)(4326008)(921005)(26005)(8676002)(110136005)(316002)(66556008)(41300700001)(6486002)(4744005)(2906002)(2616005)(44832011)(66476007)(6512007)(5660300002)(478600001)(6506007)(6666004)(7416002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4x+oKCYIAs0JhZX9pswmqR4qqyepto/g0v3oFEcHgpLvdW64leDDUvkencOB?=
 =?us-ascii?Q?nXOq7pkPwUG9sgIIEC3ajMkrp5KpN78g+6SBQt1HLbgBWBwPuJS47yC6G/kY?=
 =?us-ascii?Q?byl6c66mU0ROOxi0Di4mvSGTrWI7dWKoKqxWFsR1wRJl8lq2wM3FZOrN7kFY?=
 =?us-ascii?Q?l+1G5k1ByR/rkQpw8usc4FW06SW860jeXZAueYvlmSZZLVKyzR7TeHVlVfKx?=
 =?us-ascii?Q?2mOxFCw9oAglQOrQfz+PVuQCCoVM3Ve5uYtwxZyphqKnNeF5M0ieKXSs2CWK?=
 =?us-ascii?Q?BvkMQQ7bawIBK7Vub+KlYsE1/+GNpm0NObXR9TX+PcXwYTt/sTYRBAuWqG+X?=
 =?us-ascii?Q?4rxPwV9VuWGvhWp7KSyTf8kdKrCxPCN0hAaoZRSiXeFH6WcdvrPMCu5NoWXf?=
 =?us-ascii?Q?Y3m11b8TqwFPyzAPWWOv3RcByC6nsjdCmVGDaCwt+HdJkmXuOIEIgPr+P00N?=
 =?us-ascii?Q?l/bX1fMAFy0srsheN+mdh2PGT6N3BP7oXYrEt2NC8OB+CjgHdb8qprONxMee?=
 =?us-ascii?Q?3ptYTZJkrjl0cNbn5jfEjw32poQ0rPIzsccfTcsxVOt4gI7Ywoi5u0ZBkW5n?=
 =?us-ascii?Q?0U6Sg8fPoHvGZyHkxtMaez8WP9AJ1n1BKiYb8LvVAkzHgQuZf+loK66Mse4G?=
 =?us-ascii?Q?YXwTDkJF3dIWm5a9poXnlW7/OhoeUmIlziRBySblkUgYdwke7//tosr6sScq?=
 =?us-ascii?Q?Cmcwm06LbpaBWUjx9a6C7VBHCaYle190PsFtmlah43BoySMuijODqtvq7tJs?=
 =?us-ascii?Q?o1KMiPjxMyvq9FhLpivk/SiKx4d0OR9QikOOffPRFWbQ4P5NVeMeSkzBNu5Z?=
 =?us-ascii?Q?0PSQfi4wONGUIr2tLXAoBsUH0N4ycrh+WOTbld3SDMmUIsqUWL+GkZMKcDak?=
 =?us-ascii?Q?bUANmqwBzA1F66AZIHFNYI0/S5Pkyj2pzT0gl4htpBu4U3n/OJf0+smYCG7U?=
 =?us-ascii?Q?dNi/tVfiRQKN+IIWw3QIhsaJL3023yq0QeLzxthyy5m01k3rHmfUsc8mgAih?=
 =?us-ascii?Q?j0GMoE9IGCSkM6jRPe2uE0rv+f2X7ra7VdAz37AttnDzMCVhOcFdIFRd/6sW?=
 =?us-ascii?Q?m4TnsiJeMfRs3/2kWmi1mVOI2yppUjKp1/kvVWHOs+syrnJ6pGbQKKkQo0QQ?=
 =?us-ascii?Q?MY6q6tCL8AFLrg+ENntVezy2lvvCDxZkxUTrnbh92mrQ2sRcWOOjSl7+gHtc?=
 =?us-ascii?Q?uRJ1wZGuKqCxG51S1cNo0vsi24KdhKTdRsDdUDQfAc2wjnWHQjg1g8+CjVu7?=
 =?us-ascii?Q?li+7kAPEZZWdj40B9HPqltulw40VXdGxpCWC8qRkOOoVVoiZEu2H9CoK5ELH?=
 =?us-ascii?Q?m0vi9J+6W2FEtyWHVvLNyx2BMRT54D6fGuTLB3bHRa/2jSc8WryFzx9lTQZF?=
 =?us-ascii?Q?xpRt2VsQmK/tFk9vDzvwrN6HOupOJbs39ilPAsJJbWg0RHlSnp30nMT7QnKQ?=
 =?us-ascii?Q?OXBN/cQO3MzlV0eQwVx/UEeyKL+HTyuGfHKYg4loiWMkCgfX+1zFn54lTWgT?=
 =?us-ascii?Q?R+2HnulYd8Jhs4xIJclhRuz+8mWPx0lCmz0my252bcESCVlLeBsDjc6vAW1J?=
 =?us-ascii?Q?Xhrp3VjgrXTYZUQ5enzDaJdkq0GuGu5gVz4NcPYq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7c2377-9286-4419-021b-08dbc0041d4e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 09:20:10.8531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aorV01YiAbed8BHux3TAn4IA2G9u85F+ZkdaBFxIHdo7msp7zOxrsLlAHZKDFFPNai5f+xkjFa76MLoFhxltDg==
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

CONFIG_VSOCKETS is required by BPF selftests, otherwise we get errors
like this:

    ./test_progs:socket_loopback_reuseport:386: socket:
		Address family not supported by protocol
    socket_loopback_reuseport:FAIL:386
    ./test_progs:vsock_unix_redir_connectible:1496:
		vsock_socketpair_connectible() failed
    vsock_unix_redir_connectible:FAIL:1496

So this patch enables it in tools/testing/selftests/bpf/config.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index e41eb33b2704..02dd4409200e 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -84,3 +84,4 @@ CONFIG_USERFAULTFD=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
+CONFIG_VSOCKETS=y
-- 
2.35.3

