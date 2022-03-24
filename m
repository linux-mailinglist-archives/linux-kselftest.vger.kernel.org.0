Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8974E6160
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 10:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiCXJ5f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Mar 2022 05:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiCXJ5f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Mar 2022 05:57:35 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEB29F6C6
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Mar 2022 02:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1648115761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/71xnBGsTjbSe8fHQiLNuUJ+rpCqttfzQBFMMgHomTE=;
        b=hvRKyb3/IRQPDNEnPy39OQsj3kdzJuNCz+oFgtw9Zm/N9k7YJQEepdHCSOWZG411QJl9TN
        +T2QACRcMfquupAgeamlMyS7rk7Q6zxte82T2HIHGCjW0M0bpRFgRw1V49CQ6vFdursLNO
        n2v0WWz6VeSSU/B1Y6Ky1E/FuXUzbm0=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-CsDV5Lj1PHODUkoQpBOYLw-1; Thu, 24 Mar 2022 10:56:00 +0100
X-MC-Unique: CsDV5Lj1PHODUkoQpBOYLw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asfSUklTwUzwoucpF79eUWifuAmcROUpbk94GtQO5grcUUVaflQQQpD9ZVgllXBSHqnhx8LKprSTk/DHhBllJBSKokUT1q8UKar/DmCNrdSeucWuCLqLr0C4/uhcNdcdcL0m7zT0fjJn/ousqt+7LXBIL5o07CcHVvM0QZCBD3TM5vB4L5KEpgYb3K6QAwPScyescJ6jzdJRvKzIzyjVYLXklGMCukpWIC681qWTqOU6QOZk0/8BP0FpuejrO3BmCV7ZzJoA7Orrqgi6uZhVoGa7wv4j02wA11CyCzIZEDjGtQeS52RcL9Yi8ocQURC3cRc8uw98POH8L7FJBrqlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZBd785/0NlHdy6OKsUJTokoMoAo5K8hxPeVfufxWrE=;
 b=jKbUSx6E1gAHksFMFGsuqKVEV4KbVV56ovmj/rUld2XLzSxyVOADgjwFpEOacsaitM93KRooCZzg3Tq+COrgjo8XiWK9bz0t+uE0fbFx290b87KjFNxOGPSYPVeGMsg2U7730fyYoCqa1QCqd9T2LeZoooaN6Wmdmw29QyTH25obZ6ckCazZjWvHgXDJW2MaAyOj6uWRjV/TOvUZVFBSSD3SyLBcj/wASi/xo3sRgIZ66fXURdU6FRqS0IfzNK8jE1/WXoYJcbeaHoiIIuMdZJYUy49mNccXgVmblvuif5y4nSGLVr0e2koW3Aya5+aBMzD/VGUMwRlxwN70CqFcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6479.eurprd04.prod.outlook.com (2603:10a6:803:11c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 09:55:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 09:55:57 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     Shuah Khan <shuah@kernel.org>
CC:     Geliang Tang <geliang.tang@suse.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: x86: add 32bit build warnings for SUSE
Date:   Thu, 24 Mar 2022 17:55:54 +0800
Message-ID: <5f22f4657cd11e541ab6cdbb7782b55891f63241.1648115583.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe7fcac1-e771-4472-c957-08da0d7c7e79
X-MS-TrafficTypeDiagnostic: VE1PR04MB6479:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB64797EB107A381C9CA09B509F8199@VE1PR04MB6479.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+98qjafLVFbQ3J8sLWNAd+i9+Zq76bUgAp0oRddxy24hFcmzOKonscZA81AjJcWac6FChbr+Y14bkSues3OiH9Qjx73CBFOzZCyDvbnspyifkI10ul9U+VVFYMyW2wIyXNiy+BvRUMA+oQeIp2s/CKJPc289pieVGZD7djrBOm7LNTTt8MfDDm5fyx7AEf1DM1b1+c1k+DhA6NN2CE1dOsB5SHE9KPsb7UFunANNhl4ce3rhZ2Ioe4TWKU4dChAm5YBOFSUssnexNuGhMbIwehrO9cYBhsu+XnYdjNwc2NR7wbksNzE+xqL4VtisAGxCCA9mwYNR7XkOg898hJaiJyTVij1ADYiahTTAaKUlmzER1TuMqkuj2op5x+8b2ubo8njmVf5PMVaux8fdKN4riSXo7mFiWmH0E1sCCsKTlVm/Z/dy/7/wDj9J7OnqXeyxoQYSE7nwuXlyFcsmecopT6LUqk58GjRCUWCB3OxWZce12Dka/Ln7EpD8KfK3DFTulwOIxGhOoRBikp6SBgvHaoM+D6cXVFHJI8wxR2DVDGQpavwIeQ36+9D0AjjHkiTwJOIwxfmSCPQrtBBydle17TYuS/V9Y0BFdFcmDoEASaAJxKuPHI1aGahHj9PJKACt1KzVOYDYWvnVCgbAbwqPko2g1JJxN8Qe+PV9tA9WpsqzGyLPf0l5bTqz2L57hxqAqYiBi0duzMlNBKFqSpdRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(2616005)(6486002)(6512007)(6506007)(6666004)(508600001)(38100700002)(83380400001)(66556008)(44832011)(86362001)(66476007)(66946007)(4744005)(316002)(2906002)(6916009)(8936002)(8676002)(36756003)(5660300002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xaeo7h1/Ws6RExzuXK7w6gkzfOlkkYiR2nyjAJfeqXp1FnlG/Xs8eOPQU26g?=
 =?us-ascii?Q?mdS75SO2yhqw4UCa8rKdUBDjrtnrOAlyUDrnOx16aiBYWFGH/iv+cP1SI/Bj?=
 =?us-ascii?Q?8iE4pNIuj49JL/pjazi/yLG3J/XWoO4wzDswroH4SNbzQ+C+5Davgp/Gh1jh?=
 =?us-ascii?Q?Z9GfaOTAjTf+L2l4H15TQ7pSBMz0nSyj8UpxZH/yajSnDpObP3tjhjKT8GQQ?=
 =?us-ascii?Q?ImKx/NaxwMShl5mVkYRq4gkm/3zeHyQZhwne9nRY85csVnMVBkhzq/xC4Bxg?=
 =?us-ascii?Q?vrb8QcoLbNkbxd1eQgWKIi3461OjcOIUPCoyBJVYQ+nlHb43p925VgU/N2jS?=
 =?us-ascii?Q?PpWr7w/9TvXOBqUo7b1GSLIOiWBpW/USfwxeNhcqeoASa7+2zLxupTA0rKgD?=
 =?us-ascii?Q?IcoClsoT9TNE9nu5xbfAqmxlJxNI+Mx/zV8WR1lPXmwOHpRAUiEfmI+I00Kw?=
 =?us-ascii?Q?jJeVLWyZj9dicMNbALe8cSw/HocKefiv+RYnrbiH64MO+8qsoT9TiY59rJN0?=
 =?us-ascii?Q?sH0P1D31RztqdJCjQVyRJyyjsCCEsxsTgM2cb9b4FG1o/DjKNOUSmloBYt9a?=
 =?us-ascii?Q?V1459vd/qYIkaTD02iUbeoqC5MuP/4BMg9BXoTrwRbNukL0fLTI2w7Atda1D?=
 =?us-ascii?Q?RDHeOdS/bNZLazW4QV684RIhTBQ0pfFiMBGSgJ41jlyoYRjLWp0D4hvu6ZI1?=
 =?us-ascii?Q?c/NruoCsnDmlEsDDGZe00Xih8+ETKlwrp98oN7Ts45OKCn2zrkgEDl6yq75J?=
 =?us-ascii?Q?lkL0cP8plWwzRSmYPyAQU9aPAFy5adXArWtCc7tg/PxmmrpaTGeTef3cY0ny?=
 =?us-ascii?Q?9b6H6msNpi9eIjQdYLuspwDeYQQg901VbuFKXGZk3nW94c+ILQjCgjfEQfR9?=
 =?us-ascii?Q?mHMqRuQEQqm3c+8A7ZyJvFfNfjnWZev7fvZVuKS9VruD9mq/kPtdiD5FodGe?=
 =?us-ascii?Q?iZfMfWwaW4foY3PffzEumlcvQi2mFpBu2jRp0gPaCr13OYPI8ELA5fxYGEdU?=
 =?us-ascii?Q?s78DiTGezxXPT+7wu33iMKiVf0PxvVJnlB8ACdHfIv7UxAL4HpFftI+euh+/?=
 =?us-ascii?Q?4/6FndLgOjxhmTYQK3pk6ZaqE86DNImTodwKRR4o13yEcnBLro/wwp4V5edR?=
 =?us-ascii?Q?fwWYL0GUGx20cUVngjd8XbIcMxZeNUdxm0hlGhJlcGOhBmwIfwChCg+KEbZ+?=
 =?us-ascii?Q?uGn1qVf8lekwpmntWcHJ9195CllrFRSXOtnnwlnvNeadsz06O3HaVUMxl70X?=
 =?us-ascii?Q?X7QZ3yIpAYj+Xf5mU8oy01Ja7/tiwFkD6EuBUJbdOjS7Akv6UWBtfh7EVaq7?=
 =?us-ascii?Q?Ppg50t1uvkYjMwVkhPmRwuIcrubtWkGZgBh7GHVLLxqPYPG3kcfWXW0fXSeO?=
 =?us-ascii?Q?gfUlR07b6eaAzYri/lwejrbbkawyYei/oOw1B6NFz4kHCdku20LWbKhsO4w3?=
 =?us-ascii?Q?D4cSWGNCvDnOeRpgfCjeKASNdje2FslfkACaNRs7F97NCooiJM3eDruQzUIw?=
 =?us-ascii?Q?HqYMW+8FSsd/VfkoGtA5mcpko3pCfUzSiBK70nsSQb0ZxePGe/sZv8y6G2A4?=
 =?us-ascii?Q?WfxTR/304h8GGaBEv+Ztr4y6YgG+16LYRoagtH17jfGnmU7vyQGWiWvyDBK8?=
 =?us-ascii?Q?YAMrOltWxyybuqndloBoMlsIe+WRJF/0RFe/TUAjVx6fcNqesH22jHRDLxEf?=
 =?us-ascii?Q?7Z/9pTHvvjemRuxsuxD9N4yr+K/21GL1K4M90gjT+UKGp08tYT1hVEAdzVLz?=
 =?us-ascii?Q?fxyxdss7CQCjQDL+EWEQufyLwewTePY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7fcac1-e771-4472-c957-08da0d7c7e79
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 09:55:57.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymP5uDzzP6NXseouZI1z5D+s2wkKt4fBtZR6kbP5kXn75q5L0SRevGoiPMY6XFIZg123SDGNhUmWzoS0ueZrtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6479
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to successfully build all these 32bit tests, these 32bit gcc
and glibc packages, named gcc-32bit and glibc-devel-static-32bit on SUSE,
need to be installed.

This patch added this information in warn_32bit_failure.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/x86/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests=
/x86/Makefile
index 8a1f62ab3c8e..ffd7c1fa2c9e 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -92,6 +92,10 @@ warn_32bit_failure:
 	echo "If you are using a Fedora-like distribution, try:";	\
 	echo "";							\
 	echo "  yum install glibc-devel.*i686";				\
+	echo "";							\
+	echo "If you are using a SUSE-like distribution, try:";		\
+	echo "";							\
+	echo "  zypper install gcc-32bit glibc-devel-static-32bit";	\
 	exit 0;
 endif
=20
--=20
2.34.1

