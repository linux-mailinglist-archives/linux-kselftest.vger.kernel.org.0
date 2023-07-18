Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D67580C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjGRPVs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjGRPVm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 11:21:42 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F50196;
        Tue, 18 Jul 2023 08:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO0Lk1VjOSE0cIV/ZBjmtXtVaHRSa2IAqx1Y8IwPIXAak2n+d/2XMa57GtuBX/gp7iy13gYqKUcVOkbae8Zxn9mBWlYhlGURqZyZRlSl1ddV3CKdpTl+wAkMWrTNrQy3UQuTwHPosnmtGjHAsXz52jUDs0CHKL8CRG3lJmxwxdo6RODIGouvgA8xqglTAQ+yHn+bLHmMkyA699w6RSKMNe1oGw9Qzoc9ScyJmcCUHvNhlMvTF9QXMZtx4XdkXAP+elRnNf9M0Nfr+jmQ5+mNDCN/pijYk/qCKTRfbIylstmnWDGYv1y/g6Vwpew62m4GO+HcaIEuzSWTnOr+tEwJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gWXRo6Yrh+2hAsapRQxM7Ngkdf1JcqibOByBoULKkI=;
 b=QfRzLFKm+aYu8MfqkUm5+uRr3rkGvio0Yh4B/YKUS5bRLHjwB41taFzmUXARzYAXa2DR6qd5bwoqD8/tOUkRTcw7Tlk+eDjl5aW9o0vQ2cvKg3UKbM5pioUiBi30EVwzBtx9JihEjv8YSD7Y/hIySI4zJdeCtk4dKFPy/Kx7SpEp8ucaV/V05bnVxBtKniNUV1KAzbakgKDkmNFjexwHKGwXbfkIE7/FDgpkDN2KeKOEaqCnn0RSP7g+VrLqMimEWtnfuXzVMDOam/742igq9uAZcHwETuqRcN+QD5mvYp3/5pEyQ4G7BeYqguliHcv8ct0nmALa0esoEXjytIBqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gWXRo6Yrh+2hAsapRQxM7Ngkdf1JcqibOByBoULKkI=;
 b=FQsX1pTwjxpniAmyMRYzv8tDxeXyu2owhAHyklXwYTVtPJURFtL2tskwCHlkahMo+5aSQZMsKGl+z71C/UXM32dk77nHGGwdf5HlJkGcbAqkOICrl9bB3SAait9Ni9xb7QIDxOanKxwYdG2L82xBACZubJvUZqH5CCMoHAzZv3f3CezDFyM+tPn3GT1aNIJl6y05WV7mssQYAZoA3MiTqojmXbi9KcdsDDCEwcMT/Cd/D8i7BWXIHMzOlQfy/JnUB9uy4XABBxRAsC5OsQ82iWNhw2IwD+SKkPHwtylBUYSZtRoQHFi7RHhvWMdn+Tk7bvmcnrD44D5GkbksOxXE/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 15:21:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 15:21:09 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC bpf-next v5] bpf: Force to MPTCP
Date:   Tue, 18 Jul 2023 23:21:02 +0800
Message-Id: <3076188eb88cca9151a2d12b50ba1e870b11ce09.1689693294.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: d1236a3a-168a-4c50-903e-08db87a29cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MESh1vfPVLe/SSp98JYSKa4Cv6L+YZvUPtNHlg0fF02KoEvHCcS2cIcXRHVvghjdvhJcf5DUBydNCHzNEP3BBjhGzJv8s819FtnWoTG/4OQ+/0lRz+etT/Zm6WwuZRT8/XHNZU85FeFau4rH9zUHXC2ZkmbaUZNZSIRsv01cuWq+far5LSkl9DuUDE2djsTNxYaNAr2JMJycHXo1ovo/O2J/TW1v6s7uHpSaAIv9mAFCv2ootmEf2qF3G9al+KvI3uMMCVF8NVoA2lAG5KpXwfz4OjMw+6uNfhGECZLdY54tGLx8vwfvYiYORNsKN9XTfvylxXBFoG0zsC1eKoWEuinQHCMuICyVaUyGMPqxZRBlyrgC7LXeudqKBfx188SAh1fd4uf8aPE2hNt8tPpPmOQ/2lTBCwCuwxNt9FvOwxbhOmYA+ih5py0pmEzblnbIxsz0BmskyfiCT9ps7UYHDP2RV4NvNRW99zj8nPW+/VoUMFCQgq6CIEyHWNIgHhtEq6DskxH1KfPdO+uQD1RMG3YSwC1KNNdEIzOiF4ZgiEW0IzwEUVAvYcXRUjT2aNmaV39OdL2iwfWqEz5XNNCs0/iyP+AcwlQD1Dco9loD6Gk5bW20BKW4g4fMOGgJvDMg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(4326008)(86362001)(36756003)(2906002)(30864003)(44832011)(966005)(6512007)(6506007)(26005)(186003)(6666004)(6486002)(83380400001)(66476007)(66556008)(8936002)(38100700002)(66946007)(2616005)(316002)(5660300002)(6916009)(478600001)(41300700001)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rNIKdcetfVsicjs5xxkHrewM7fm0hahVI18SCImwcu+cvAQoaqd1bys2mPBx?=
 =?us-ascii?Q?yiDAg3gucDVeE8NpdDab62opn5aYKsqKgDGQMbxsBIFLKgVvDsqXQTy+zetV?=
 =?us-ascii?Q?pmM4BBb0fl6L+SK681Scq23ADRMMusim/wz7wqE4h81f+lZ5yQgDwUODIwnH?=
 =?us-ascii?Q?nL9KJRNL6dZWR4HWsr2qLhTm5UYWyogiKresMgWIkNHe2fclWPXQRa72+rYL?=
 =?us-ascii?Q?Z2AAriKcCLiv3wbOCvvz3RBzPSGHX5e+Pkzw9cSd5Uz/I7jYdtID7npR8iP5?=
 =?us-ascii?Q?Uatp6pXCDDEygQTVYAG+HizHbgyInEfQGEPjNElVownXQ5Dfx/ZI0rWtyo6N?=
 =?us-ascii?Q?eeFxgcNv1HEa31ZiOTvnaDrgXMnfFRpwR76b2deWlXdbHJRLAXSjlqMWUSYg?=
 =?us-ascii?Q?ONs3X1u+INZDS/EhNJWXLNF7jOIXYWFK+M1llMFr7SeLSbVahwOhr91K2liW?=
 =?us-ascii?Q?VAkmx7Xztel/C+adRF5F4EBhlf4EVKR9ENZIqUM3Y0mgp/wX0ea6FDVfo6As?=
 =?us-ascii?Q?Ex5gzQTsjwUDR/JWFzEdfP7Jzzl2n3YsNO+GnxsOgUPxdCHHOOghqCv73lDw?=
 =?us-ascii?Q?Ldu7pBrOYOZo9CmYWpysbelV9kZ2Fx35cVDf+hZRKa4/DOWBlyISA/SI6lBd?=
 =?us-ascii?Q?5rYsfI3QcmkfDgW7UbRSk2w0SmZwiVLGECAkBo8awpc7GVUIQGt4eut1SgQ3?=
 =?us-ascii?Q?tLc43w3KISoePTHJvhWg4t9/9Gun3iOp0/oAEZ/n0qEbza3kTasyfJ9AGWqy?=
 =?us-ascii?Q?klHyw9/dVpfjoa93Q0n8Pxy6/GfJflm41PN0Z0ZhJqzyROgNJyyteS6wPPcS?=
 =?us-ascii?Q?3Iz1CFi/jFSgzD/Hmx77a1dPLm7T7mfzjt70SPi1Uu4Op09WiiSXk1nJ7mlC?=
 =?us-ascii?Q?GNkF1j14q3hWs0DjMjK1I6aEuBuMSHOxXLas09zd8U5LaFmupbXydI4wJ/G/?=
 =?us-ascii?Q?Ak9pRPDFqoWSteT12m1gst55f9+QefEcqNrB6wJ2DdOHnfKr5dH+DCk5BgNE?=
 =?us-ascii?Q?cD2a8Jv4Cp7omYSOOoVpGiE+Cz3zfAAqGM0COQKFkRvptTY/V0l9WSPNwbCO?=
 =?us-ascii?Q?+6AkHpUnQ+wZdFQQ486nqIuFlL7v7dayDI5bKGZVDYhk626wMUGrzr82NzfJ?=
 =?us-ascii?Q?jANw/fPWxWFijJrA/DfBqtGO033MCp8zKrjTefLRgChWoaSx2yU+LY0sBAYQ?=
 =?us-ascii?Q?22h90jQouaqzE2ocdh5YxbfUAJpdekwaqAws3m5jQUqr+GXzTe9flQjCWVpi?=
 =?us-ascii?Q?acZvKLpJh+OdndrqL7FfiVdJSB1yNysGlO7npGKaaBph5WBC01tImWVp+Z0s?=
 =?us-ascii?Q?Tuy5n2H7moo0kp4c4HQ8nY1Ty+KCG0Tuczau0Pw7ZpdaLn++mNzxt/3WLtqK?=
 =?us-ascii?Q?TDuRTkFY+lQtjFkjJT3VNquS4oqORNJWo3RKYAkhG62+CvSADkJaEXkhhQgF?=
 =?us-ascii?Q?lxpByoRUE4+RF9DR3smeUqeRPMa3vbZWK6NMoaKCSQGa085f/3/Kiko7MBMj?=
 =?us-ascii?Q?O1ti+2DOpwpB/USpLADz9VvGyitQQJFZ5Ej5YICno2twd4yVZu6uOhUWveov?=
 =?us-ascii?Q?WIt4l18jwB2IodQmyFqmSyeldJies0mXuooJZcY3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1236a3a-168a-4c50-903e-08db87a29cf1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:21:09.6426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+uj+JFAyET4tmdltfe0EOHNd8gAL00gGRJ+gW3xeoB+dsFORBOrFeYUO8/giwwfbdaTHbZ8T+7ms0XTEqIqag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:

"Your app can create sockets with IPPROTO_MPTCP as the proto:
( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
forced to create and use MPTCP sockets instead of TCP ones via the
mptcpize command bundled with the mptcpd daemon."

But the mptcpize (LD_PRELOAD technique) command has some limitations
[2]:

 - it doesn't work if the application is not using libc (e.g. GoLang
apps)
 - in some envs, it might not be easy to set env vars / change the way
apps are launched, e.g. on Android
 - mptcpize needs to be launched with all apps that want MPTCP: we could
have more control from BPF to enable MPTCP only for some apps or all the
ones of a netns or a cgroup, etc.
 - it is not in BPF, we cannot talk about it at netdev conf.

So this patchset attempts to use BPF to implement functions similer to
mptcpize.

The main idea is add a hook in sys_socket() to change the protocol id
from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.

[1]
https://github.com/multipath-tcp/mptcp_net-next/wiki
[2]
https://github.com/multipath-tcp/mptcp_net-next/issues/79

v5:
 - add bpf_mptcpify helper.

v4:
 - use lsm_cgroup/socket_create

v3:
 - patch 8: char cmd[128]; -> char cmd[256];

v2:
 - Fix build selftests errors reported by CI

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h                           |   1 +
 include/linux/lsm_hook_defs.h                 |   2 +-
 include/linux/security.h                      |   6 +-
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/bpf_lsm.c                          |   2 +
 net/mptcp/bpf.c                               |  20 +++
 net/socket.c                                  |   4 +-
 security/apparmor/lsm.c                       |   8 +-
 security/security.c                           |   2 +-
 security/selinux/hooks.c                      |   6 +-
 tools/include/uapi/linux/bpf.h                |   7 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 128 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/mptcpify.c  |  17 +++
 13 files changed, 187 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 360433f14496..77cdbe21e5c1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2913,6 +2913,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_unix_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto;
+extern const struct bpf_func_proto bpf_mptcpify_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_snprintf_proto;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7308a1a7599b..d475e6ab20ca 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -288,7 +288,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
 LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
-LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
+LSM_HOOK(int, 0, socket_create, int *family, int *type, int *protocol, int kern)
 LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
 	 int protocol, int kern)
 LSM_HOOK(int, 0, socket_socketpair, struct socket *socka, struct socket *sockb)
diff --git a/include/linux/security.h b/include/linux/security.h
index 32828502f09e..a683c10d4071 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1416,7 +1416,7 @@ static inline int security_watch_key(struct key *key)
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
 int security_unix_may_send(struct socket *sock,  struct socket *other);
-int security_socket_create(int family, int type, int protocol, int kern);
+int security_socket_create(int *family, int *type, int *protocol, int kern);
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern);
 int security_socket_socketpair(struct socket *socka, struct socket *sockb);
@@ -1481,8 +1481,8 @@ static inline int security_unix_may_send(struct socket *sock,
 	return 0;
 }
 
-static inline int security_socket_create(int family, int type,
-					 int protocol, int kern)
+static inline int security_socket_create(int *family, int *type,
+					 int *protocol, int kern)
 {
 	return 0;
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 600d0caebbd8..265077883f18 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5583,6 +5583,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_mptcpify(int *family, int *type, int *protocol)
+ *	Description
+ *		Dynamically mptcpify a TCP socket as an MPTCP one.
+ *	Return
+ *		0 on success.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5797,6 +5803,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcpify, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index e14c822f8911..8cfa6a44f8f2 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -248,6 +248,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 					prog->aux->attach_btf_id))
 			return &bpf_unlocked_sk_getsockopt_proto;
 		return NULL;
+	case BPF_FUNC_mptcpify:
+		return &bpf_mptcpify_proto;
 #endif
 	default:
 		return tracing_prog_func_proto(func_id, prog);
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 5a0a84ad94af..7207f60dad76 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -19,3 +19,23 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 
 	return NULL;
 }
+
+BPF_CALL_3(bpf_mptcpify, int *, family, int *, type, int *, protocol)
+{
+	if ((*family == AF_INET || *family == AF_INET6) &&
+	    *type == SOCK_STREAM &&
+	    (!*protocol || *protocol == IPPROTO_TCP)) {
+		*protocol = IPPROTO_MPTCP;
+	}
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_mptcpify_proto = {
+	.func		= bpf_mptcpify,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+};
diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..3957e2a865ef 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1328,7 +1328,7 @@ int sock_create_lite(int family, int type, int protocol, struct socket **res)
 	int err;
 	struct socket *sock = NULL;
 
-	err = security_socket_create(family, type, protocol, 1);
+	err = security_socket_create(&family, &type, &protocol, 1);
 	if (err)
 		goto out;
 
@@ -1488,7 +1488,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 		family = PF_PACKET;
 	}
 
-	err = security_socket_create(family, type, protocol, kern);
+	err = security_socket_create(&family, &type, &protocol, kern);
 	if (err)
 		return err;
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c9463bd0307d..ae823b95d304 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -868,7 +868,7 @@ static void apparmor_sk_clone_security(const struct sock *sk,
 /**
  * apparmor_socket_create - check perms before creating a new socket
  */
-static int apparmor_socket_create(int family, int type, int protocol, int kern)
+static int apparmor_socket_create(int *family, int *type, int *protocol, int kern)
 {
 	struct aa_label *label;
 	int error = 0;
@@ -877,10 +877,10 @@ static int apparmor_socket_create(int family, int type, int protocol, int kern)
 
 	label = begin_current_label_crit_section();
 	if (!(kern || unconfined(label)))
-		error = af_select(family,
-				  create_perm(label, family, type, protocol),
+		error = af_select(*family,
+				  create_perm(label, *family, *type, *protocol),
 				  aa_af_perm(label, OP_CREATE, AA_MAY_CREATE,
-					     family, type, protocol));
+					     *family, *type, *protocol));
 	end_current_label_crit_section(label);
 
 	return error;
diff --git a/security/security.c b/security/security.c
index b720424ca37d..bbebcddce420 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4078,7 +4078,7 @@ EXPORT_SYMBOL(security_unix_may_send);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_create(int family, int type, int protocol, int kern)
+int security_socket_create(int *family, int *type, int *protocol, int kern)
 {
 	return call_int_hook(socket_create, 0, family, type, protocol, kern);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..8c2303f052f5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4512,8 +4512,8 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 			    &ad);
 }
 
-static int selinux_socket_create(int family, int type,
-				 int protocol, int kern)
+static int selinux_socket_create(int *family, int *type,
+				 int *protocol, int kern)
 {
 	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	u32 newsid;
@@ -4523,7 +4523,7 @@ static int selinux_socket_create(int family, int type,
 	if (kern)
 		return 0;
 
-	secclass = socket_type_to_security_class(family, type, protocol);
+	secclass = socket_type_to_security_class(*family, *type, *protocol);
 	rc = socket_sockcreate_sid(tsec, secclass, &newsid);
 	if (rc)
 		return rc;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 600d0caebbd8..265077883f18 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5583,6 +5583,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_mptcpify(int *family, int *type, int *protocol)
+ *	Description
+ *		Dynamically mptcpify a TCP socket as an MPTCP one.
+ *	Return
+ *		0 on success.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5797,6 +5803,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcpify, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index cd0c42fff7c0..93767e441e17 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,8 +6,9 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 
-#define NS_TEST "mptcp_ns"
+char NS_TEST[32];
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -22,6 +23,26 @@ struct mptcp_storage {
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
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -147,11 +168,8 @@ static void test_base(void)
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
@@ -174,11 +192,101 @@ static void test_base(void)
 	close(server_fd);
 
 fail:
-	if (nstoken)
-		close_netns(nstoken);
+	cleanup_netns(nstoken);
+
+	close(cgroup_fd);
+}
+
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(void)
+{
+	char cmd[256];
+	int err = 0;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -tOni | grep -q '%s'",
+		 NS_TEST, "tcp-ulp-mptcp");
+	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
+		err++;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
+		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
+		 "NR==1 {next} {print $2}", "1");
+	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
+		err++;
+
+	return err;
+}
+
+static int run_mptcpify(int cgroup_fd)
+{
+	int server_fd, client_fd, prog_fd, err = 0;
+	struct mptcpify *mptcpify_skel;
+
+	mptcpify_skel = mptcpify__open_and_load();
+	if (!ASSERT_OK_PTR(mptcpify_skel, "mptcpify__open_and_load"))
+		return -EIO;
+
+	prog_fd = bpf_program__fd(mptcpify_skel->progs.mptcpify);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
+		err = -EIO;
+		goto out;
+	}
 
-	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
+	if (!ASSERT_OK(err, "attach alloc_prog_fd")) {
+		err = -EIO;
+		goto out;
+	}
 
+	/* without MPTCP */
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server")) {
+		err = -EIO;
+		goto out;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err = -EIO;
+		goto close_server;
+	}
+
+	send_byte(client_fd);
+	err += verify_mptcpify();
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+out:
+	mptcpify__destroy(mptcpify_skel);
+	return err;
+}
+
+static void test_mptcpify(void)
+{
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcpify");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+
+fail:
+	cleanup_netns(nstoken);
 	close(cgroup_fd);
 }
 
@@ -186,4 +294,6 @@ void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("mptcpify"))
+		test_mptcpify();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..58be68c021da
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm_cgroup/socket_create")
+int BPF_PROG(mptcpify, int *family, int *type, int *protocol, int kern)
+{
+	if (!kern)
+		bpf_mptcpify(family, type, protocol);
+
+	return 1;
+}
-- 
2.35.3

