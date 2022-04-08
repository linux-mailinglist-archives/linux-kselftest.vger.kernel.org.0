Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863114FA057
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Apr 2022 01:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbiDIAAx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 20:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiDIAAu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 20:00:50 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B23174E85
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 16:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649462321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlxIOHtAN/TwcqxBd9NUAqYjDhRKf8AmmPp1TVtAmVo=;
        b=HyKPuY0dqyqUOsYEtIOiyFd6AyJAu+980JONTeb0D97Yczytmr6KlBzbABmXD0960Km4SJ
        nMNEhCGCTAmvpBFjSb8SnNpzQvEmHjiyPG0htL0DH+D7gFEF0LzTeKdQW3+8h7+/KI71KZ
        0za9qSmkroIwhyI4kQn2trbeJBVnGZo=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-XzBgpT_rNhC_789DGB9HBA-1; Sat, 09 Apr 2022 01:58:39 +0200
X-MC-Unique: XzBgpT_rNhC_789DGB9HBA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKXG+I28hzslvpk7LoS4elrWV4O2KNRf64xX5VvQ5VJM3Ziqhu4oHNwiVQRbHpc7fA/g85G4D8Uq+tNfQK+IN9EPeeUD6Sa6vVEQ5MC93Ragz55PNPZNxRvw6zEHOUt+Enr5IABFzejQNdcpJPHXWm++PHbkeIdEw68oFmWjwOANndJiNZ9lNbEtZS9oyxLySHtiAtCqm2AVjcZAs9ABzPCufTT4CidEbOie2P6kWvQgSxAjVkrTc9BbEEihYgNt5RYw4zrFb/rmq0cx7/zjDsOaOGmc7kD3KZhEeApk57BWzrQoUVvdBr6jISmDR4nas7pS1ZPligusVf9dqr5nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9vI8VJ4yC5Z8TvyYDjRUJlglc6DEkr4mOvob4RcWeg=;
 b=btJsP4F6+RHEHDZgnkRUA9yPdZ2i1vXDxunm+iXeC3XdCVj1PUZoQ0cgJMnn7lxIr+jLWj0LVrRcUh9U3aZEpBdf8NGGdr15ppvCmejPMCVTcSOY6bcwgjv6CMtIFeA+4k6bkEwrRkrpqFA6hp4yZgeTFvSEZK2a163wJYgLw1WN7KyLFUHuRM5pX8nQHvkWnCO8Vv7nkYAbE92WS1BKbpQRDKWIh2bsmakE8Ayk62eS5YjSISP/yz4LwUOZMn7HoiUtv8P9OfKwZiiQy9o6muH4v49jTspGBCeaNUBkm74zuBujdP7/vmKdu1YbID9aALG6sOqMyGzjG44IFHjFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4430.eurprd04.prod.outlook.com (2603:10a6:803:65::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 23:58:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 23:58:37 +0000
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
Subject: [PATCH v3 2/2] selftests: mqueue: drop duplicate min definition
Date:   Sat,  9 Apr 2022 07:58:18 +0800
Message-ID: <fb0f7ccbfa77d0719e49c5b816078942a02f3962.1649462033.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649462033.git.geliang.tang@suse.com>
References: <cover.1649462033.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:404:14::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad77c879-f56f-4b69-cbf1-08da19bbb2d1
X-MS-TrafficTypeDiagnostic: VI1PR04MB4430:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB443036A2D8C2451069EB54A7F8E99@VI1PR04MB4430.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnc8AaH6Rckt14aft0au9YWKSQSIaaCIuCKR7v3M7HLg+0vHJb6LD5H+BAF+dDsBI0D0DWesEBhk7oTo0YBHCYsqFlsT8DlGGqXvxpZF3QYljYnSNKohsF/MCL5x3ij5jkYOxxeilxHtvHcLOepyHfozydKpSFwMWv34FqkqV/QMcH/qQ1OPofPd1xche2bY2xJNW4Emmix6kfZPPzwh2q1M4W91QcS6Jt7a1N1AMyRe6i8XUHOo9xSDNk2Fyfm9l6X4ltMn+lAUICfsfYm1L1TxHeR2Iwu/jGBjo+NnDoTjm5lj+R+udROYtxERR/WJlKh1P7uhxCK06wDjIQ2yjyjqlULwiowmT+9rizStYrxh7olY9woZC60RIYsAyLlWhbP96AAZCO/Gw7HDH/hlEs7TtAbWsR1yYQGsoTMrbktzoh95K1ZOfS60nmxOU00snHWuVbCwC4ZXC+4P/QbVLMfn3cJ9MFMb6eMAOYLrhYdP+CQ06x/V+2xJ3BjF62Cn94B6CqH05k3Ho/vXm0secDPl9jPU/000wcAkftZtfNz1KJp4toDYqR9Jr6dl+2MDAefkLR63XvjCt8JFjZEwcALQxqZULHgMjDXW/qDPwGeWGdQZYTCUo2T7fjbwVRE2ZwA0gte5dfIB56BiKfAfNT/LcNNy8C91eOD4Cuf+8RaYeWKbKGSKB2oEhyLZEkTp/X7Qamr3kcntRoD7wSh62A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(83380400001)(36756003)(6512007)(2906002)(2616005)(7416002)(4326008)(6506007)(6666004)(110136005)(66946007)(316002)(44832011)(8676002)(38100700002)(5660300002)(86362001)(66476007)(66556008)(508600001)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ck03i09T1iuKbvSjJIYlLAYhdq7HAFMZgUQlJgQcv7nAGInUvVjdPUPWRM/d?=
 =?us-ascii?Q?cAgqcH4CdcSk0gJUUU3CkeDVrPE3taLyYxJ5/T8eVAtau4hQ/MfErAfsebbi?=
 =?us-ascii?Q?tDoNf1Gqo/BTLKyfL/vSxUj7vpL0wy3rEDWK+1P57s7M84u4brFUcQL3ISWb?=
 =?us-ascii?Q?5qoeF1AKgMi3XgSfvTAy1nHkV67mMx3JZhlmmQxe8lCrTnJUWywsxSNUJ2nt?=
 =?us-ascii?Q?KzH/Vxq0IVJDN74HMBBwK7ksA2B6hdmGx4k5b2nkd/IUIp+8GY9SGwGUHK2M?=
 =?us-ascii?Q?Lo4e81DrXoYaAEGEpAW6KCejIkgNYJdm8pXrjgAqzn6q7oxAUhRUMr5i2m0w?=
 =?us-ascii?Q?6pgG/ePhBxdQ66H9XtXgmVCk12dEzJuKFmBsFOhaiR+eVy/fUNpZHtx0k8GX?=
 =?us-ascii?Q?aYir2NFR878UYo3FI843OCTIE2ubhGRHt6YBkFo4Y5G+sFGlmjhAeUaeZHvz?=
 =?us-ascii?Q?lnuhzh8nv/gbHXETdDKUrNDYFZV7puvoJYRtojquLSS068pMPMA+j0bQiE1X?=
 =?us-ascii?Q?ArsUO2aUBHNTwwfmx/xcgJwta02SfHMAZm/QIh5NQgXPc+mxOzHAAANdbRJS?=
 =?us-ascii?Q?9QQgEvb/1X5y5J3tjzsW2CtHE84n5iG54yU+Ld0O1YijdOrXXh5mIg+THcxO?=
 =?us-ascii?Q?iKcTCh/DaYGr8YVBpLlW2tse5F/xgQ1t/OP+8c3QNRH77/0pwZBxepVvDsNW?=
 =?us-ascii?Q?sHnTh6R2hIxTL8GKfRXPdI+OXRN1H9e8VezgPMK+/Em7bnSakHplZY3Un8Ty?=
 =?us-ascii?Q?kGo9RVvm0tUQWIXZOtgIYwxXaMn1jETuobRV2FN0eY4VfcjpRJjN8wAdygFD?=
 =?us-ascii?Q?KnpXDmEy1mdsC6YGY6eahFeyfqI88abwVk1XgJVrfyciCbKms0pNVAIsalqr?=
 =?us-ascii?Q?T3t8cqARfSnwQPbvhKorr8dkSijOH4QfdIFfIzvrLGQ88Qa22i38OHHj5fZD?=
 =?us-ascii?Q?BfiEsyRjjkWsiHrvNUt8HT3v03lNMg/gdTNKS4ifwqy63gcQInL/d5kjRVDN?=
 =?us-ascii?Q?k7XNa4d6s5pDbpvV0QGTLfBvYEcTijPQLU1gitcD5WcKYSV2HZhXcisPDjNG?=
 =?us-ascii?Q?VQ1cyFTqB5BosWKh/OxYwOrsv0QYdZE4wS2uegjZbSBHcRRJ1KKT8Evtk604?=
 =?us-ascii?Q?0upB1EkCf0bCUk0DnkBlfrzMDJtffxGQ02zaUinpO/ijL4R+e2GtXJxcxYnS?=
 =?us-ascii?Q?jkgR/6mFCagddrgMQemJSB+xxBZYbtFV95Gs3X0gN/GB1GMvUBx3yAnDbLkO?=
 =?us-ascii?Q?ikjUCgTjRMeOdqRRTj9bG7IG6XgexU08+LK/OKx4UsLFnsNcf4eYc9bSG+U9?=
 =?us-ascii?Q?OksxuCNDRwppncQTyBO9XAn03F1mupJPxJevNazkRT7QpuN4Cbvg8B8cSB5g?=
 =?us-ascii?Q?3oJPU0qyEJSEktIJXRYTd3QFJubqPIgHqM6d6Vuu+YE8iQL4g7mPP+OtIgpo?=
 =?us-ascii?Q?uiKMFVPX+BMixpnE5GO0jH5xrSHKPq/TqeIZqiGoEGA6gJwytbHQ90cwwI2+?=
 =?us-ascii?Q?heH0ylHF2aKUQjv0YlJkzSutMV7fKOPoakBsZPwp7uhVSURhd6VFijrLVz9X?=
 =?us-ascii?Q?aVhK3Ive7fRxuNnTKWngm4ui6v++fUjwNISkmDndvi39Y3lMaVJ3b6Ok313e?=
 =?us-ascii?Q?YxEggKVaeljQWln2P1RFWB9iH9wfmd/IUEvoeCsO9n8hA5UYsF5ag8aPwVZr?=
 =?us-ascii?Q?Q4BVOTf5yq3ryUM5AhC4J4YF3c1y0dOhgUfjiDDLQzJr6f4eVXvwPhOKp4dj?=
 =?us-ascii?Q?2UHXKjg7lJSL5iKVGbbbRKOS4lPjOZQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad77c879-f56f-4b69-cbf1-08da19bbb2d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 23:58:37.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EftzXqR29wJOUEnGbb6OYMgSbQ63nsk7Q2WTQ6lhnani4IHQ8D8TWaw2U/0N+vAlttaR5Ka403VTwMf0qoj7DQ==
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

Drop duplicate macro min() definition in mq_perf_tests.c, use MIN() in
sys/param.h instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/mqueue/mq_perf_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing=
/selftests/mqueue/mq_perf_tests.c
index b019e0b8221c..6df1b2a7ec88 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -35,6 +35,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
+#include <sys/param.h>
 #include <mqueue.h>
 #include <popt.h>
 #include <error.h>
@@ -73,7 +74,6 @@ static char *usage =3D
 char *MAX_MSGS =3D "/proc/sys/fs/mqueue/msg_max";
 char *MAX_MSGSIZE =3D "/proc/sys/fs/mqueue/msgsize_max";
=20
-#define min(a, b) ((a) < (b) ? (a) : (b))
 #define MAX_CPUS 64
 char *cpu_option_string;
 int cpus_to_pin[MAX_CPUS];
@@ -551,7 +551,7 @@ int main(int argc, char *argv[])
 		perror("sysconf(_SC_NPROCESSORS_ONLN)");
 		exit(1);
 	}
-	cpus_online =3D min(MAX_CPUS, sysconf(_SC_NPROCESSORS_ONLN));
+	cpus_online =3D MIN(MAX_CPUS, sysconf(_SC_NPROCESSORS_ONLN));
 	cpu_set =3D CPU_ALLOC(cpus_online);
 	if (cpu_set =3D=3D NULL) {
 		perror("CPU_ALLOC()");
--=20
2.34.1

