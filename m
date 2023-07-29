Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17BB767DD2
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 11:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjG2J5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjG2J5j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 05:57:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F618B;
        Sat, 29 Jul 2023 02:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOc9p/IPWwRIJhctMl9Ysa+SbFYs3HT6nlXgoDnvp0aSiCFrI0AedZxu7DDVL3tM8vL312hnVfz0yRQEJkVVUg7G1/VPeOlpe+3bsSi5wTMZRRIAVjy2rDvS2mFUOs5dbnLGoXZavNb7GP1ScW2l4UsK9JbSUWYrtUJPTjvgCAJYtPaKRHoI5qkuiJqi9UZvclDiw2VwGFz0Pnikx0Xc5A7XYVIukE5iG73urUXCH4Qc95L7bamZhCuUiNLSK6DXXgqPQvIKJxchD66kckfGDAWLJ95YPGGJnvx8SRsYuuP6aXBtTAEeQqY9H/unPumWXrNrkgSaLLYeNo+167ydIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1Lrfk98p903e1DbZjIZ95x62tbtYnhZSKnZJfsrmVM=;
 b=A2Y183TQDbBzsk3qnfos6BLrMqMy3D2ATLc/1NY6r4sJcIUlZbPn2VzX8LfxWv2a5eyPsn0LjBt2LQ7ZA+7FRqKG/EFSav1c34acaIxny5MQQFn/PkZbAvZtiPA9UXbwPoIfHWLDhSw2GXGD4ZsEXGt6VMC5Ya/WFoqjv8HE9pqcXxcDPwvBRghTQBj71/UUwys/zzDb2fuoaJ+ZWJgeFzKmjXPRmUtfxHLFCUqq6WLMurCcs7ejSJ8cj3Vp9RNwRFGSsCtLqmpDaaeuBwddYM1OHinTxCCExOOGXJJprg1lE8udvwOQ5AkmptJSigDk9xbqOX1YF5fclBtzBTVe9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1Lrfk98p903e1DbZjIZ95x62tbtYnhZSKnZJfsrmVM=;
 b=TeGUefGk886+Ddaqk0+Q+sU42Gxun6ayvLuAB6VVjlXpUqsC0f7M898Pb5dRxDOZv0XhgThZMqqojsokiyBoGwKzrL+wMIb/rDTKC6t1uwEprQXelwtPgAc7INgmKZSIo+lhNCZmT5ubz+FkkdUjuS0XA22XkgLclJG9ZPfUcC6PSHEnK/ebOFvFniV+/7NHLs/NLQ55jePqePgMfHSBDcdrSzmY53GDvuKvpX5dFEhkoCwzjMF4JCnzBMoqdydJ/GnZKUeVZj/sOxlKgnLwbw92TTNwRovKASrGbSYClZXvCKDs7bR4DgMdOO7RyDiGwWuq2DvGWJ6ZREXF3/95gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 09:57:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 09:57:35 +0000
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
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC bpf-next v7 2/6] bpf: Register mptcp modret set
Date:   Sat, 29 Jul 2023 17:57:23 +0800
Message-Id: <2aa38eaa60127fce85cd4a057db523cd200df91b.1690624340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690624340.git.geliang.tang@suse.com>
References: <cover.1690624340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9e0f67-d24c-4d57-0e31-08db901a3be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CA4ch4YIlg8iJt7lcaNMJ3EVSBJRDLbMuFgfCKnYEPxh7rytOZCmorH2vPvEaDoCQClG9EVQrqoywDM9Gw5clS/1DskTEgd+OBFU6D1q6p4TOEHU+fIMh6p3GrXTZoRSY7Gof+NUDk8zxe6p6VMWRAGFyGff+EsJcTKorcAx045alara/eKnnCe5zNJ312+vHPCXUvYwQyfQHLQrVo+sxAudAb8WA06CmN0x7mBysdeWBRR416X8jA02tp6D7+nxvrfZqPIinTe/zKiJghE+4OV0W1N9VVOnHmsfqzRJ1qVIDdKxEQRkJ2NiES3y9mf/pIPET7xk6nSCFspBIriBEMFE+1m63hquoajocXrDaR3nnlKPMWz9sbs+GYJ1m7nxSgey+JH8urLSwWK5+ZgOVMkzClP0ZcG1INUwlai1+A+xH7FRlcjBov4MvwiY08xmw2/D9pSY64aLCOrMR3doUrFms7wcTBuuVlPkJRHWIwSwf5i4ETliNiHTaxl0rOBqVT9Uvk1qqoDzG7XpcywryPgOL7eGwrhTwO1ksoFiQhJtpjdJZzjnHFx+ekqsFWVNWAVk0AukOd1krLzC/oJzoXbltHXbV61xRThMiSdMZwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(316002)(8676002)(110136005)(478600001)(38100700002)(66556008)(921005)(86362001)(5660300002)(4326008)(66946007)(66476007)(6486002)(6512007)(6666004)(186003)(6506007)(26005)(7416002)(7406005)(8936002)(2906002)(41300700001)(44832011)(2616005)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MUvn0ajXH7QuK6BRwvEBncVAQDokMTiDb4I2Mm3pWaWTZdAuqTyKbMtFDDve?=
 =?us-ascii?Q?Fh9e6v3QVEnCnyTlwNgnTdashzP+DPmNX753cGcMYQhFkqorAb6bQutAOkmP?=
 =?us-ascii?Q?XASfIaxlyCGAN5XbujEWzNAtmNvLDBIsi2qbptLy5tQRPCCQdk4v5t2wFWlC?=
 =?us-ascii?Q?SeHIssm0QywhQsMi/KcgZ108XtcmIryQ1FT4n3bI8GHWD82vSBqqEHNc6cf3?=
 =?us-ascii?Q?XngYzRN/szVTD2TxYPEddQ3OIp10n0pqywHoAgNcdb9W30SgfFx15vgdd7kh?=
 =?us-ascii?Q?5VWvzOCmARcnVCpkX46ghBUyyHVcj5Ay582VXUGLMbT61YooA2EhjHvJy4sH?=
 =?us-ascii?Q?0HEwo5rtTxel7rZCZF3RJcPBBo3BKYJZE6pdpcxUbmzs9k9xBK/bWyXeyeyv?=
 =?us-ascii?Q?4jhQpivPBvRUe4uxezr/YogWW8mk9uOKNwb5i2uPFYIPPCvhd3rgGl95P5C/?=
 =?us-ascii?Q?afhIDYK/eEGw9y7SJu6+iRDMuZRBjagWUt14Njxo5xTEXNDTbO85/R/myuI1?=
 =?us-ascii?Q?/rr0RSqD3Drko4JuAj+tQp3EzWLeE6JHwtNQ7Y3PiE/fISOAOxki/syWGnp4?=
 =?us-ascii?Q?drWAwztSa9EtRqDLPjmdonXmezGFY59qHANjX/sKuuAyAbPyAcugrWr8rKEh?=
 =?us-ascii?Q?1m55vlPD2bypFbsTj1SHdLeXY9VaRhe+7TZMvre2PXUWi/gxcV3DsKinvsvx?=
 =?us-ascii?Q?EETGlDrb7fxVSPRWAMFOKUz0pAQYfK5PY13vFFc2U4+6JRAi8zsZsWD3KQuw?=
 =?us-ascii?Q?rtflLWUvx2WfDkG8GJIAcIBPl/2kz5w9JjfmpHqtZOFdFiUkgsDCX6vHAqjD?=
 =?us-ascii?Q?4VXW3YwtIFgjjrRbZTLKU7Z5mxtRqXHqYHlwJSSmMfQtCf02YAFCiq8gdrrx?=
 =?us-ascii?Q?gCU0rVeNbGWt8S3Uohd0N2V7RauqSxRTl1GupYlbl3MLe9y2dWyWnzOrn91C?=
 =?us-ascii?Q?/hQ5TIyYThMNxY4HX4TNKCwFNfhZ16HDTPcQgRAYA27H4tkwGCy+SNfJLvHC?=
 =?us-ascii?Q?+tM0s8/wNQpfQ0xiRf+/h8kSKLnMJ7XeK3znHk3oMJM6ifcxAOQUodCicKss?=
 =?us-ascii?Q?lZN7W7PN3hEGQ1vERWqnrJUk+F07mKNKNutWi9VwlOLxeIVtoe1JosYvvxlY?=
 =?us-ascii?Q?DI96gvMct4JMM4efi86Phh9qW+UtJWVSwUPiBVA4ce17LrGBBtYJWni3Y2u4?=
 =?us-ascii?Q?OPD4M/26bLCPqiQQDsozbhKr2ymRFOa0Q3EfnTJTL24Hi8yq+kWcvaeCCGhI?=
 =?us-ascii?Q?CxrjcRUu5qwBbHK75IRgs9rS+s4Snf7kkHjifYli3uaZ8aek21jGgGdzwowo?=
 =?us-ascii?Q?5iXNlPaF5If/eZnHWzuv0PX8YM0VlO7u7Jcb9PjfNi4oGBSitOl7HCZ1/6T1?=
 =?us-ascii?Q?UAR20AsI5cJdHcRCxvQcI54iFDSHUfZbiwjn8wOSg916RyLObZ1g6FJiSG6u?=
 =?us-ascii?Q?nwgg83cmmGsgiZN0+B48YCwd5Rt1+bE1j6sTjDxsRwCQMGX6QOMyqizPB7Pg?=
 =?us-ascii?Q?jKNdq5dJDi7/HFECyu8ydNHQ2K/zrd8KxSW4qXX2YE/DOA8t2DYNZqCXwwyB?=
 =?us-ascii?Q?peeLyb5YMA5JpzlmOa4xRtUMLtQoxVm2tchUepjB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9e0f67-d24c-4d57-0e31-08db901a3be4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 09:57:35.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/SeF2tILFmz3H2hf8FbMPZkBkv8V5cSjAaiIWEUGfcxPqRn44kaqH+GFeiPEkFHHKTZeNWscQt3NZbt9xQDOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch defines a mod_ret set named bpf_mptcp_fmodret_ids, Add
update_socket_protocol into this set, and register it in
bpf_mptcp_kfunc_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5a0a84ad94af..c43aee31014d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -12,6 +12,23 @@
 #include <linux/bpf.h>
 #include "protocol.h"
 
+#ifdef CONFIG_BPF_JIT
+BTF_SET8_START(bpf_mptcp_fmodret_ids)
+BTF_ID_FLAGS(func, update_socket_protocol)
+BTF_SET8_END(bpf_mptcp_fmodret_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_mptcp_fmodret_ids,
+};
+
+static int __init bpf_mptcp_kfunc_init(void)
+{
+	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+}
+late_initcall(bpf_mptcp_kfunc_init);
+#endif /* CONFIG_BPF_JIT */
+
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
 	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
-- 
2.35.3

