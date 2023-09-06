Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29978794174
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 18:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjIFQ1K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243079AbjIFQ1F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 12:27:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2016.outbound.protection.outlook.com [40.92.89.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D0619A4;
        Wed,  6 Sep 2023 09:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap9xZT8C0wcp8zAzAn8IusW9Jfa7s+Kz0McCl/7ZwQB08/aufAhTD4B0ASVx32JS2G8M69TvTszLBCG3u6TzycdH3He/pEuU7ZBPyi1wg8fWgBduTZIP7U+mPegsWnHWfY2BW8u+64cSSopO3RYifDCFbdGPUgffQhzpZfuO5M4pBGPMrZiQXHn818AUtCvTR+2bKJxT12To84IZ4dTD/RSwDuDJjKV/yEaqlW4XhSJqFSqqVwqc81Ibq7O04y/oHUZVixqfO22O+F/qbeXf5fIRPiGMT0Ouc8m4xcS+X+Q8EHBl3QbZDHLPeK/xHzBKcogRGEJHnFDi8DWaFSmbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQIRpvEvZq96oNilEKRjEap2z/x0mbnKcQboRvYOG0w=;
 b=ChMa7OwKgSvYC0uKDRGxRvpTgib0rRcLWa0xw94Q7ywMP/h1xCVTP5rs/d07oWyBZJb+Ik5mTbr960EwhldAczkhHe9IoS36r+/Lt8wRJ/P75870KNadgWAMgywCSm8suEmQNooD/DQbarumT6WFrlu00J2C3QPRyt/eUs/9sTNOG111Ux45SMCbJMQwHkUVEGyvyKJriHVcYjaemZlHIVz1FM4Fm91VPLStxhXfKo5X5pwoycsqYZixPWRPX0so3dvrYbBQrxPNVA6w7F5Baft1YVe2/eLFi8qMIg8wl8b8SPcb6i7/KkxfKxhzHJZ6O7cnqLdH6aOFSDSIysW2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQIRpvEvZq96oNilEKRjEap2z/x0mbnKcQboRvYOG0w=;
 b=Dgbq8yMT5SihhH7R1/GHV33Cp665T5/V+AHMFOk0h/sW/eYkYvlavVQjbHjdizwn9g9WNU1zVnVvY2C2UhvXBMQyjzy8uo+CkWARjnU0h+P+N0DD9AJTgGgDxTR7mw48lT6b3hzRE5+2SCPpXdb1Hi4HLe4Fae27WKrRcpdiMHGxMvFFXfGCduV4EWyi6MxOaTByw9tqVATGgGDiZRx1TJ+xFy/pMWOp0bVh1FCeGPfVUb79p4Ec4S5h+EcBXUa/P8kYXitMtbjzMAAEoqoEq3kr2b3AF74Bb5nhXNksVPyuuAkD7sJ3Mzh56jk+ajo2dZucHZonFKNh+rkVkg2WuA==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PR3P193MB0863.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:26:52 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3d3c:61f2:146f:b3b4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3d3c:61f2:146f:b3b4%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 16:26:52 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/net: Improve bind_bhash.sh to accommodate predictable network interface names
Date:   Thu,  7 Sep 2023 00:26:03 +0800
Message-ID: <VI1P193MB0752FDA6D89743CF57FB600599EFA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tmtn26axAYFWXmjQPhaFAMbyQyBbR6qw]
X-ClientProxiedBy: AM8P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::30) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20230906162603.10809-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PR3P193MB0863:EE_
X-MS-Office365-Filtering-Correlation-Id: edbd6582-4e21-4b7b-ca39-08dbaef6138d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHBL16qWDGxmpXARnIUoq+HYZOkPzufQ/BxPstTtczMLfUwAbB7DYDTAHKqG591bU3i8zI8fwWwqNNfKyXddzKQgJQtweo2DFM1b5uhxp7Rncw8fBaTiM6J18jrsTJHwAD/YLkWX9H28euQiwXyNTinzkJ6wQF32GwBTQQtb4numbloVZEFb/rY+v4cbzgOTuctarz0SkeDhUwa/8YSLeqzycIV1epfn8JEN4Rl+JUTORocMB7l7mDzIoVDSAK8/HtblaAkUr3pHIOQ6qliRVT3RHTKsoEH4QfXOhX5hgJVTxiQnNvVhFLPdMrabl9h0DcPdWdTjeRn9rquNv6plug3R31lOOFtRvd0r6t1MxEo6fIbOhzw7nkjzWJyT5/3dle7oVJMwVfnZGJL/G/4SsmIT35zEhRM2/VdVWuwjknkOnWffXuC8ttNbEieG8v6cUkBPEolOQFGhrQT0wRyt9d74REDBs/KXG9zJfSVCJ0UYWN9CBOoPaxThBIgyd02EqczRQJw8Hfs5xHQixKQDBn2iTeOZsXrLfJ4dodLePVwYWOLaCKtJ4zPYDdPp49IU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amDBA5k9uY0bD84vgUkvwWEUIoz23BCavkMRfwqpxSo3019pMg2pyzw/yCdF?=
 =?us-ascii?Q?tHatx4wruFAupdaOMojjK0F9980s21CmDC7mKx4ntZdE6ihXJeZxjv6LFiel?=
 =?us-ascii?Q?3rZxwWDV9y5Cic4xbz8jDFkH14ctZIer1KDchKNBQGe7fcJRnWFq0GUEZMXQ?=
 =?us-ascii?Q?TVprFQcWqQuTIJsH6AbYROsGOKCe+C1kj2eXrc6cXLhtwXBVJzBLlHFitKBo?=
 =?us-ascii?Q?8AsRqIEEbJvBiH407Er1v69UmFs1oLPzbmve07cXxuuglDEY2UWjhD9gf6dZ?=
 =?us-ascii?Q?esUMfR91J44B4aMXSfn73roeE7sEtu7eYHC13jCnSM0yVfNoMV/jGTI754jQ?=
 =?us-ascii?Q?9yVKBv1bmKmwl0Dtg56s7a/hUy/FkFk2R8JLrqc2njHHe2pfamv828jcx31R?=
 =?us-ascii?Q?bp7kLp8clJGpxzdd+jXuujo782NSdegKWwTfKsItLFyGVnJEMFudiBOYP4wX?=
 =?us-ascii?Q?a+93MyRqSh/sddTKdqRCo9v1IUqmFzh1RNm3mret2/aL5FjWaO0Zlz0dxORz?=
 =?us-ascii?Q?WgbRHoEJ1+YqrGAI1F89A2i1wRsp+/3BkvT8cX0xmDdVtMI2+bRz8goxhu27?=
 =?us-ascii?Q?DUA1qBL/Y4hdPR6jbp8mdJAKJHpTKovWXYbn+a7DozukNZLfwacSG9aMT7HB?=
 =?us-ascii?Q?ZM38trt2uew23l/PgWegy3xigl0VNO9P3finmjLDl0EkL0cUSoADz0Oi5gLz?=
 =?us-ascii?Q?wmjJ3IzKR4Yy/Dni6bd2fYyBaLO8JvzjLYhyq/5mIZsdqyEscI50LNnts1PZ?=
 =?us-ascii?Q?b+DyL9COkACDg+p9i8iNuwAxZlrcKPSBcGCorkCsMs9CS1n3TBhl/CDPbVbP?=
 =?us-ascii?Q?0kLZMiZDJ+0Sm8rL2Qv43x03Gr2UyqU2dXCaq4tbfjU6mFphZS9yPs/O1VeP?=
 =?us-ascii?Q?cXe5PktvO7swOxCni5t9Z27IFiW97p5sZMDLndj6x63Wt25s8dZUb/RevnKL?=
 =?us-ascii?Q?gekBghQHYLCU65osf/RCv5aRcVewK5T/6GyezVj/YtRAQcVoOZPyRB+WkLnH?=
 =?us-ascii?Q?sqEScsRBAR1LtAvYe7RBn8sNG21yFDS1y9JDcYnz3zfW4jhIO5XWDbNeBAGg?=
 =?us-ascii?Q?DytDjd5bCpjdUzlVf2jEhfWt3wei3rhk0J5qOwWUTlmuqr2NaWsO1Qpz16Fw?=
 =?us-ascii?Q?DHp79ytiWy9Mxt+LRfYbN1EbUxctK+chz2j56+BiLkng+9PIB3bDPVs25tkx?=
 =?us-ascii?Q?rZS9ipCTgrViJml3C5VJC9DoIirpi8cWxzy+HxQaBk9r1s9Kk/LaF/1Xppw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbd6582-4e21-4b7b-ca39-08dbaef6138d
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:26:52.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Starting with v197, systemd uses predictable interface network names,
the traditional interface naming scheme (eth0) is deprecated, therefore
it cannot be assumed that the eth0 interface exists on the host.

This modification makes the bind_bhash test program run in a separate
network namespace and no longer needs to consider the name of the
network interface on the host.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/net/bind_bhash.sh | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/bind_bhash.sh b/tools/testing/selftests/net/bind_bhash.sh
index ca0292d4b441..a28563bdaae0 100755
--- a/tools/testing/selftests/net/bind_bhash.sh
+++ b/tools/testing/selftests/net/bind_bhash.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 NR_FILES=32768
-SAVED_NR_FILES=$(ulimit -n)
+readonly NETNS="ns-$(mktemp -u XXXXXX)"
 
 # default values
 port=443
@@ -36,21 +36,21 @@ while getopts "ha:p:64" opt; do
 done
 
 setup() {
+    ip netns add "${NETNS}"
+    ip -netns "${NETNS}" link add veth0 type veth peer name veth1
+    ip -netns "${NETNS}" link set lo up
+    ip -netns "${NETNS}" link set veth0 up
+    ip -netns "${NETNS}" link set veth1 up
+
     if [[ "$use_v6" == true ]]; then
-	ip addr add $addr_v6 nodad dev eth0
+        ip -netns "${NETNS}" addr add $addr_v6 nodad dev veth0
     else
-	ip addr add $addr_v4 dev lo
+        ip -netns "${NETNS}" addr add $addr_v4 dev lo
     fi
-	ulimit -n $NR_FILES
 }
 
 cleanup() {
-    if [[ "$use_v6" == true ]]; then
-	ip addr del $addr_v6 dev eth0
-    else
-	ip addr del $addr_v4/32 dev lo
-    fi
-    ulimit -n $SAVED_NR_FILES
+    ip netns del "${NETNS}"
 }
 
 if [[ "$addr" != "" ]]; then
@@ -59,8 +59,10 @@ if [[ "$addr" != "" ]]; then
 fi
 setup
 if [[ "$use_v6" == true ]] ; then
-    ./bind_bhash $port "ipv6" $addr_v6
+    ip netns exec "${NETNS}" sh -c \
+        "ulimit -n ${NR_FILES};./bind_bhash ${port} ipv6 ${addr_v6}"
 else
-    ./bind_bhash $port "ipv4" $addr_v4
+    ip netns exec "${NETNS}" sh -c \
+        "ulimit -n ${NR_FILES};./bind_bhash ${port} ipv4 ${addr_v4}"
 fi
 cleanup
-- 
2.39.2

