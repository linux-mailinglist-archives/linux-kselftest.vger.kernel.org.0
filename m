Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6E4C9C73
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 05:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiCBE1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Mar 2022 23:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiCBE1t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Mar 2022 23:27:49 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F155EBFC
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Mar 2022 20:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646195224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gjvqQZECVFfwm/E15bJJR3yMTnZ+V7y+Jxuhu8YEPx8=;
        b=KPLEOK+mIhuVnNWTZQvtExCAYhuRzlbyMNEUSD+1rTwFuWwLWKzEKHSSEwmEKbvcHPhpuw
        NUyTDQpHQ/K9nW9BrP8x7uUgvMA5UdXTmNiF057iLISobGCzrDlpN9F6TCqgSSXPxGdsL/
        7/7a58LsS6veYiEdFeaY01WbtyMWBj0=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-Z7SUtsMfNYOTnizrNQGiqw-1; Wed, 02 Mar 2022 05:27:02 +0100
X-MC-Unique: Z7SUtsMfNYOTnizrNQGiqw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YprPZoCtRSFNxvQJK/3dftaeleOj8pgsGAe+Xf5kZABtIEtawQpRSXbtc51r8L9jtEhQZzIg8z6+3pnBjBR7npCV0Te5zkC/Iqx2OEgz5fdenMIOkyOlu0OkDvgLwMZVJGUBSwx653UX3EGL0Ghrln6Y5b+iodQKnAaumqb/JAnF7o853hU0z3EPkuHpLRjG8YCCBH8MuvbG1T80GSsQPQxgqayhFtd+AtZ5pHvEIHVNznGysW0hlmdDsUPQZkRpCkgw1SwL04gKM7AsUwH0EDim04iQqPH4x56gx3G3m704WubvHJmqN9ZpLFLEgUaE1V+l2NU23AyaC3dyCar8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVkjeZcceZKEjugExPH9q2L5zJYEzvDoQSV0lbEGhbI=;
 b=Ld/KldDXKBhA8IfiR3ASZsDxVT1kBqAnDxo/VodOie0uLazjslsUMLuwbIVcSD0e3pFcr5vy/xG8hYDjP+DypbeTMF2ePHt3pjPQujUaF5s7SQwdHFgXp64EOMtCPDUR1LNYS7iTorYIF+vYtWz7AQ12asRkEjrtolz6wvc1nts3N1HQjEtPGBlA9JuJcRLLnj84jJFTiYDACksVvO7v0Cja6fIB4poXDuo8Y/Mk2oCwBZj9z92L7gX1QGdArpNH+OOoClHv9OOPeZqw0givekC6v4Wq2TuSl4f1QBGHx77eIIAnndYc+Xd4U63DrXtiVaTpYIy0iCdWIbrPVHyLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7083.eurprd04.prod.outlook.com (2603:10a6:10:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Wed, 2 Mar
 2022 04:26:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 04:26:59 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Shuah Khan <shuah@kernel.org>
CC:     Geliang Tang <geliang.tang@suse.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: netfilter: fix a build error on openSUSE
Date:   Wed,  2 Mar 2022 12:26:42 +0800
Message-ID: <727feddb9fdcbf6e74f68d783986a1bc83a50f54.1646195012.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a282ed0-a4fc-4666-d2ef-08d9fc04e3f4
X-MS-TrafficTypeDiagnostic: DB8PR04MB7083:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB7083994C6A741345AECDF181F8039@DB8PR04MB7083.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mMDuA6kOGu75/80cztAz9s7CbNn7RfGgU2OdbHyUorLS5KTgHVyqW3mS5eyXFt1DYAC4MuCx3YVdGh+nHSmiuF4YaGtNM+stQr8DJIP3Wnd5EQLt9EOmHzrKy4UOpniS4AnUBQDRE3vXTXgAteBC9vfhBb+/fKV2R+CotQWHCC9ll1cjyj+Tv7HB8m/hG2Qrr0CXJ0DC3L9j0EmlP5uyuIQyfUJMGc/JiXu3Rze5dxEWT5B7vy6nGO196n3RIx04QCEOaTuelcT5WeMYK/lXqVOt8265WuJfje02aKfJG7EskklUl7MIh+8X4zxhUQblYdcC8FNn0kocr3WTO+QJI7apDcwnP6tVwtfKqHC+eQpOgg0kHN/PTfS3GgCBk0Y+cTKSQlPc1/WXaFk68ix5MYPV6rRbVAmnJpEyiXQdvcelEAND1yd+k2+/P1JC7IFeBkFVGJ+fn0Au33xIKFXvKjUuQK4GMl1dpcvKCm3Qui0xtFgpGw1CSa4cpoUiNSCS7guh0K5EgcWMv6bJhiA94V11ZOdy+8ZHkLze7JCZPbaRiCI6WspTrfPrxPM4kOvtfquPWojIsHkNQ5AWtiykZGn7WI6y4CPGUYQ+vPsnWNlABsiVFCuvCqOtR4UbOsAE764aMGlhxgcXGnQcqeuCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(8676002)(4326008)(316002)(2616005)(66476007)(66946007)(66556008)(6666004)(8936002)(508600001)(6486002)(6916009)(2906002)(6506007)(5660300002)(38100700002)(6512007)(44832011)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8gjzGdHx+BTHJGIEjjENiRELuFoaDOkasWcYiTPFFZ0ip3/RjPw6iyTrwEz?=
 =?us-ascii?Q?vQhXELF3ZRRkYrJYwVoNT08Ycap+keDHhb+Gsn50QqSjYiyM31fb50bjDhIm?=
 =?us-ascii?Q?g/XOSYSf7sKV2E/oxj9wYjiiT2Kax2U3RotAIWIAkMf8VU4hVx6kEuyibsW7?=
 =?us-ascii?Q?b8Ey07hiNX+/Ou8f/jXxpp4NgM15NkcJfOVpWz8li7KVDQasVodfx71Vn240?=
 =?us-ascii?Q?MUEJjgjjLUVIgYXdMWJImNh07E2l/qcEWTgDJdys9cRxO0Yo14PyIKcbKj5L?=
 =?us-ascii?Q?bwZowdm9ogTltJtx4W6I3d47RWYfYM93jfHDhm2Y0j8LWP+VSq//urLByPcg?=
 =?us-ascii?Q?arOwkg2kNoOr1C6myb+RUyV4X2yguZh9sM2zcqlgYTCH9w+DpwUuD0zmd8sV?=
 =?us-ascii?Q?ccilfKa03TrtESlzIdjZkmbXazPPZvExJ9Gr3fdaWLTqfBAzqftfq9aSqNw1?=
 =?us-ascii?Q?kHUS4WSS3DHmetSL9Q+xeERaOnndUUvdrAreokS3QIvzZ61JREwQQr+Q3npp?=
 =?us-ascii?Q?vhExy9Q31XA+/ccyUYIVUlNow06au1Q55CjskYf2I4xr6dIpLAC+C66m+q5+?=
 =?us-ascii?Q?ox3i8Nnop/9mGXfuTHxTBqvgy68CWS9tOWIvyOvfDX2eTYkQsdvbO5FQKkKt?=
 =?us-ascii?Q?hX4425yVh/SAw0jCLGdA9gfXZS+vr6J8wngQ+8J6bolO0jCvgdTpmYHdCHHV?=
 =?us-ascii?Q?rW0jdZ4fv17lC5LENMef4WsdbLk90SBUlrbO0rEZbCf2Q7g1PBIavMBDbewo?=
 =?us-ascii?Q?jX8TfPt2Df9/SYH5gu+NtrHKsmHgx8REgWvh5ZtkxWm4zWcq/qAnZ6ZIon0u?=
 =?us-ascii?Q?5mMDWZ6H6c5NnLxo2H3mbpcYd6ArN1pYQ+ChBmdOvubvFxCv/cuGpV/dRYaG?=
 =?us-ascii?Q?/5Urvod1a/IT80euy7Zlve0Sa30pX38WF6XyuWg+i1ArxByrREiWeNQ0lN2R?=
 =?us-ascii?Q?O1nkpZpxmJI4faAzBwK/gU8mn6k4XTmx7BlZNK8enItaQ8pPS0j23TBEw+Ov?=
 =?us-ascii?Q?j/h9fJY9bh/jv87LQYrQz+7ToRNGWS3Scu9X1jhYvsblS/exNs6S4RP63SoP?=
 =?us-ascii?Q?Mstr6e2ZWom5Q9BF8/GfXcdbIq19qF077LqCrHXRxrxVhx5t76A8hxK2Cnd9?=
 =?us-ascii?Q?sQFPf6TDRFldXfcxBjEFOh+GZ9l//yf3h38D9tV54Msg52X6QX+h/KXFDXMG?=
 =?us-ascii?Q?ktbjqMzMLfFgD/+znkjKdMGFnVy35gKP7DcMrkexEAUxhov9D4aNxd8tJell?=
 =?us-ascii?Q?T3YW0Dn9iV/RyyeitlUbxzj99x+NfH3+B3O6iG4yV5F7Hc3HFA3ph49mxWdZ?=
 =?us-ascii?Q?R7QeT6aG9ER3aSYcZHDTXpXQkh+HQLfusK0DXXiDvyNuvtE/ng61doukKgnM?=
 =?us-ascii?Q?hV7CXirYkaOww/yxN5GEs3zio1yccoIiWRge3rJZmf2SVQxBVphGA7VNRsgu?=
 =?us-ascii?Q?0RC5e5pY2xQ6WCSerd8pkLC/6tBDSuPVrxtwWIOPhLhgWJeGYWpVGRF4EqPy?=
 =?us-ascii?Q?t2h2shjWtMyLTH0eBHfon0mC+A3gjyRYvAZIfBx5b6mqhLkrNJE/KkOzsugl?=
 =?us-ascii?Q?I+qF26OTPEDgqenLjsZaPCi6/qwjhMe3RNJfexo0k6qyrU8+4h+ZGLfrAdab?=
 =?us-ascii?Q?/PYhZPw0JcWCsJT9TEX49XLAQdXiOs7B6/goSVDXWeL7o2OPdEk1K4lBM63j?=
 =?us-ascii?Q?KRo/fiN7GlPd4+u3Vl4NI4m5bMQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a282ed0-a4fc-4666-d2ef-08d9fc04e3f4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 04:26:58.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccGFssOJmX256GjwwwaCTNbYy4K39CHACvHqh29BT7vBIYNLj3n7zGp2INYwUzM9Vr2L3wplsiR/xi+JUf6rzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7083
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

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/netfilter/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/sel=
ftests/netfilter/Makefile
index e4f845dd942b..12a4bd689418 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS :=3D nft_trans_stress.sh nft_fib.sh nft_nat.sh b=
ridge_brouter.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
 	conntrack_vrf.sh nft_synproxy.sh
=20
+CFLAGS +=3D -I/usr/include/libmnl
 LDLIBS =3D -lmnl
 TEST_GEN_FILES =3D  nf-queue
=20
--=20
2.34.1

