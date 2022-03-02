Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582CC4C9D57
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 06:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiCBFaQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 00:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiCBFaO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 00:30:14 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3987213F22
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Mar 2022 21:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646198969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rnGGyrcbWur9DEkxeaZC+YCZaWcDKSt6uRlWbuL1dGw=;
        b=IAJL8rnrRSoAO5n+gW5i+NJteFwY3my+u7yW2olGnUqKCUSxECNZS0bQd+eQpRSE8TpnFH
        0AWwb/mdyy4gxy8BYhGsYl6too9MBM9sMfFOo20+lYvhT+m7Hq6HKLVGEzEEKaHe14s9Nh
        vRPIbfGX6/czxMkOZcxRWoymtr8QDLk=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2052.outbound.protection.outlook.com [104.47.10.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-b8GCzDHeMkSgjO_x5FBxnQ-1; Wed, 02 Mar 2022 06:29:28 +0100
X-MC-Unique: b8GCzDHeMkSgjO_x5FBxnQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjQMoL9r2SfQmFQofvLe43qnSLJB75GBF+n2rNy1xDm3uPIelhXI1zc3/EVo/4ogVfbnwEf3geQ8yH2wYcQdSK3nP2lpZhdIrHtHFG7SmijqUsWkUu0WGhPkdqOeyqC+GQGv1XkCqpZyazGrhlzaefFc13n7IZbbdWAie1AppDpeMHQJMsbTyanZoXcCWDjFJjRlg06ZqKuEty8V2nFGOb9ha2OD+1YNmd8TYWzE9vStRE9HWWPWU6dQG+VyW6NU8m9SZ/Svs91oTLUID3feVvd1E0NYyJQfJtESIZs5Incyx9V3r1+QWbvMerFHyXqx0nAnLGkn0Nxuri186MJj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvqOSIEkTK16oqyFAiU9nVOuw0vxUetNBoFZTUkDJ6k=;
 b=jsgquyezyXB8umumvWlpxhfJHxvi8rWBXPGqOul4K76oTIrCj3LlyiZ83PbAZXWZA0JMrrRh2nKvVrsCfvCVc2Merzj1iUlGI59l5CrE4xbIKSmqDhTzX/i3ittzUmj+tiFEbW4ibghwUdt/4gFg2aJyKb3/VQ10z5rz3XTQoOq4SiYDv0RJ0p9LQ2G3TYbxdslG4fsLv05syA7AhEcxO1q8F/z7/sAPxkOR96HcHyUah/zWG6loem2KGGQ2rlcfQZsSnm6rWnZ5GRBMkENzelih8r8eXOLfUoZw4qzBKhGYUZvrGGtEowUZ/UT4aKUBBRSkscvav6p7HfZRsYnQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3792.eurprd04.prod.outlook.com (2603:10a6:803:20::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 05:29:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 05:29:26 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Shuah Khan <shuah@kernel.org>
CC:     Geliang Tang <geliang.tang@suse.com>,
        linux-kselftest@vger.kernel.org, Kai Liu <kai.liu@suse.com>
Subject: [PATCH v2] selftests: netfilter: fix a build error on openSUSE
Date:   Wed,  2 Mar 2022 13:29:13 +0800
Message-ID: <5ee95e93a11a239df8e09d059da25a4eaa5725ba.1646198836.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3bf3dd-81a8-43ba-43e7-08d9fc0d9dda
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3792:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3792A1D84CD80B0DDB1BCC18F8039@VI1PR0402MB3792.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPq9dFmrVjmHc+JEcSWlB299Maah6mxRwDfmm/XSibMb6gKy6jvdffILXZfnwzxHjNJQzWVXUPK4zhhMuhpsG1227G+10JHP0Rx++zymTaJgwlrxR5LpXqFT+THEPbXSRhgfjAcbru6jbDRFX3Ls8ShMrRZ1X3mAonJzdkKBIonGSYi9u/f6cxLSuAAf9SZgoxoVyBVoC0jd3ic8B4CtnJW5LRXnyWqrvjkYGQ9mrHmQZoHjlzT3fPpYtpMvsoLCm/Ou6ifD6HOFkh86/xM0uSjuCHCbolnz491bP7GbFXRmLqvDMWfGgz7qnfRSfAZVoYq0RwVzMFdVdiAnfvV4cTISdDpftEBVTB/R0wuJL5w659xD+eWiRiPAFjbQ8NBekwuBQKL+98Qt5aT6QmbzoHKhUE42kS1j2VLeMdvKkaYUcs7+WYB4Uhq1JtsH2jef/S3SQDZKnvSLM+KU/3txYcCnLUSGGLu934wwnrHHoLDlR1VzSpaK+w4lUJI6LBGHpUagOIENNrccXrxt75IGyWw6wh3SpCXGkZedF+mNtMh/aYS9mupeaf8Dd7qOf4qph64eGidK82QSLSwgceelFVEk0oeR6wjKFCvvHq15JHQMqcI6jO4p2p9Qv5YjufnPlvbuDzgxh4nUPBSbyvQECw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(186003)(2616005)(508600001)(36756003)(6666004)(6512007)(6506007)(107886003)(8676002)(54906003)(316002)(6916009)(5660300002)(2906002)(66556008)(38100700002)(66946007)(66476007)(4326008)(86362001)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/xatTwumiQ8y3NWaCPYtP45lmXY6c0TDf6HybmOS+qtfHZd11Scz9pX0Pt+?=
 =?us-ascii?Q?5IaY8ah2cxD/ndidwPT2KYIU60BbfVF1KlrFmyPNMqwkG0oqmtRlL0QStUuU?=
 =?us-ascii?Q?eBW9BdPsqzQzqfshLKrA5InNOiuVus15jeYMvpibBpddViJtcn7yFy0YTCS0?=
 =?us-ascii?Q?AjMCjodiwHJA0rznoPU4EJbhSMOlAignp5hIt3w5Z4xq797A6i7blqJfzfK/?=
 =?us-ascii?Q?ZK/+bZGatidLUtoDN/+BLvDQQP4k1A9ladjGKPbTVb9eE9v9J3lMrf4SoGBH?=
 =?us-ascii?Q?KigVn5ULfRW+BqT/l1fpPDNL8KdwJ6CEHzZPM7USoGG4O8wOIzcMqVakAYIG?=
 =?us-ascii?Q?QbHv6wW7cODuDKPbf8Y9CUEDRa6qsuPI+mcmx89iuGU1Eib1OychYikkpgMe?=
 =?us-ascii?Q?azVlkaQhX/Zkq//6O5sUBaish4CZqr/AG6Fmvlktg+iJRb0tgRIDiRVVAMJm?=
 =?us-ascii?Q?ayxZ3ufTM31xpJPsGKrcuci9xNGFj8GJw9VYOLOvQBrDk56C2wXoLCg7ffke?=
 =?us-ascii?Q?Rm+2M3QoHhUYPhaQuUYnxHfTdCt1AthsU8eFjlQF0yzCd4jSir+1fjI6YJAx?=
 =?us-ascii?Q?s/V8jSGN7eI0Qb+i3CNYIltSDpZ383Umf3RuQwDYHF9+Oxxk8l9X0AIia+Yk?=
 =?us-ascii?Q?/wgyiqvvDCIVCxx1QIeErYQyGazpwEBipnKIzCF7crfiCX4K+gJB+6S9KYTw?=
 =?us-ascii?Q?0AVFK+sTVQO1id2ILvEoFUsYatdxaSM+QrqKSp0mQyPd8TDfRtVBvIIrxsOU?=
 =?us-ascii?Q?b0dqgAI2c3XkjSFlOfrn6BRbaoCcxTPTpO/TzEaA0YuAeaFS171bET16h+sZ?=
 =?us-ascii?Q?cNPydf20d+VEt2aq+Ia95a21jSwP/oBKkIq51ZoJSFuWNAXyAMhYe8lneIUR?=
 =?us-ascii?Q?+MP0M6R2Z9sNKGX/8uyQbZ05yfpg+Rgz6nQOnzdWIAruqAYB8XYLa5HAaPCq?=
 =?us-ascii?Q?mQaAD0iOJ+WWPODX6opL4zMH/Pe3zKOAkH28Kd+UnJF0uiidrPIcJvxceG0l?=
 =?us-ascii?Q?PuplmITjktuFC4wuHxtIXQTSsBwZfDNHUIbTLP8Zyz2vP3T3RGecPmTUQMz8?=
 =?us-ascii?Q?qdh+i5us7sgX3Fzb+CgXy/BZ3hA3KHnu5ZyxmUrA7UZopDe/f07/HPMSR1wD?=
 =?us-ascii?Q?6qKLJIzv25tAah7GJ/0qLxX7CrX/dcBMTKBy8NFTr+NliatN2qEYkmmqd6LT?=
 =?us-ascii?Q?DJ+zxu+B6yVIFu1S0zovGF1l73X5ajpOuyvQ85KwUqKXtPeiydJ9ejnjj0XY?=
 =?us-ascii?Q?01BKjiisCE1lfpVEhmpWLEqI2xrJnBbFo6pym2/eg/z+aB1O8brn7i/I76Bn?=
 =?us-ascii?Q?NeQ6xMjgNusDO6IMX6gT8lBzB6lmRcHnzKD0yJyERaINwiYZvFev1Jj2VF/8?=
 =?us-ascii?Q?DD9dMCnEMjQ3pDArtEESlqBG0gD8CjRFsze1Ypcr3RwHVCMU5jp3VqPSS/3D?=
 =?us-ascii?Q?BO6GXnFubHahU/1nycNmGlD1EJu9SaEQ6H16qooODVpE1Ivsl0N3R5HPQ7Wz?=
 =?us-ascii?Q?5dtW/uTVAJ0Q6dfCylSMw/4yvyivdfwQqjZAZC1q3OfXz9zeAfbwIScFmRBD?=
 =?us-ascii?Q?JdjzP9uQlXXQGcIoytHNXomKER+J9NTqm8FvxLOOxbOrgEu703VTCtVpP5kB?=
 =?us-ascii?Q?/75WIkDhhXNpAVUXLgz1HQN3bLKhkn91jqBIANhZOO+8vZb6I1eMj2xm76o1?=
 =?us-ascii?Q?LoeW0h7MjcQOh/y8eeJr8N9Q1n0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3bf3dd-81a8-43ba-43e7-08d9fc0d9dda
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 05:29:26.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI2U+o3wvsxell+tg2HhQstrXKTy8haRkaOk+acIDayd0dwqDmVHYJhN73pg4daDV+u1hQFQv8AAel9tlcbPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3792
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch fixed the following build error on openSUSE Leap 15.3:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 gcc     nf-queue.c -lmnl -o tools/testing/selftests/netfilter/nf-queue
 nf-queue.c:13:10: fatal error: libmnl/libmnl.h: No such file or directory
  #include <libmnl/libmnl.h>
           ^~~~~~~~~~~~~~~~~
 compilation terminated.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

It is because libmnl.h is put in the directory of
"/usr/include/libmnl/libmnl/" on openSUSE, not "/usr/include/libmnl/":

 > rpm -ql libmnl-devel
 /usr/include/libmnl
 /usr/include/libmnl/libmnl
 /usr/include/libmnl/libmnl/libmnl.h
 /usr/lib64/libmnl.so
 /usr/lib64/pkgconfig/libmnl.pc

Suggested-by: Kai Liu <kai.liu@suse.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - use pkg-config
---
 tools/testing/selftests/netfilter/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/sel=
ftests/netfilter/Makefile
index e4f845dd942b..8136c1fab7ab 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS :=3D nft_trans_stress.sh nft_fib.sh nft_nat.sh b=
ridge_brouter.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
 	conntrack_vrf.sh nft_synproxy.sh
=20
+CFLAGS +=3D $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr=
/include/libmnl")
 LDLIBS =3D -lmnl
 TEST_GEN_FILES =3D  nf-queue
=20
--=20
2.34.1

