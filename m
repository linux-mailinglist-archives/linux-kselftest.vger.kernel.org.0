Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35765564D
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Dec 2022 00:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiLWX5I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Dec 2022 18:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiLWX5G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Dec 2022 18:57:06 -0500
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Dec 2022 15:57:04 PST
Received: from smtpout7.r2.mail-out.ovh.net (smtpout7.r2.mail-out.ovh.net [54.36.141.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A115F15
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 15:57:04 -0800 (PST)
Received: from ex4.mail.ovh.net (unknown [10.108.20.222])
        by mo511.mail-out.ovh.net (Postfix) with ESMTPS id E165C26446;
        Fri, 23 Dec 2022 23:48:02 +0000 (UTC)
Received: from dev-fedora-x86-64.naccy.de (37.65.8.229) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 24 Dec 2022 00:48:01 +0100
From:   Quentin Deslandes <qde@naccy.de>
To:     <qde@naccy.de>
CC:     <kernel-team@meta.com>, Dmitrii Banshchikov <me@ubique.spb.ru>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH bpf-next v3 05/16] bpfilter: add runtime context
Date:   Sat, 24 Dec 2022 00:40:13 +0100
Message-ID: <20221223234127.474463-6-qde@naccy.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223234127.474463-1-qde@naccy.de>
References: <20221223234127.474463-1-qde@naccy.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [37.65.8.229]
X-ClientProxiedBy: CAS6.indiv4.local (172.16.1.6) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 4481926058408472183
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -85
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrheefgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogetfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpefsuhgvnhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtthgvrhhnpeduledugfeileetvdelieeujedttedtvedtgfetteevfeejhfffkeeujeetfffgudenucfkphepuddvjedrtddrtddruddpfeejrdeihedrkedrvddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshgufhesghhoohhglhgvrdgtohhmpdgsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhmhihkohhlrghlsehfsgdrtghomhdpphgrsggvnhhisehrvgguhhgrthdrtghomhdpkhhusggrsehkvghrnhgvlhdrohhrghdpvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdpuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
 dpjhholhhsrgeskhgvrhhnvghlrdhorhhgpdhhrgholhhuohesghhoohhglhgvrdgtohhmpdhlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhkphhsihhnghhhsehkvghrnhgvlhdrohhrghdpjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdihhhhssehfsgdrtghomhdpshhonhhgsehkvghrnhgvlhdrohhrghdpmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdgrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdgurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprghstheskhgvrhhnvghlrdhorhhgpdhmvgesuhgsihhquhgvrdhsphgsrdhruhdpkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheduuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create struct context to store bpfilter's runtime context. Eventually,
this structure will contain the maps/tables containing ops structures
for matches, targets, tables...

Co-developed-by: Dmitrii Banshchikov <me@ubique.spb.ru>
Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 net/bpfilter/Makefile  |  1 +
 net/bpfilter/context.c | 18 ++++++++++++++++++
 net/bpfilter/context.h | 16 ++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 net/bpfilter/context.c
 create mode 100644 net/bpfilter/context.h

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 1b0c399c19df..9878f5fd8152 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -5,6 +5,7 @@
 
 userprogs := bpfilter_umh
 bpfilter_umh-objs := main.o logger.o map-common.o
+bpfilter_umh-objs += context.o
 userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi
 
 ifeq ($(CONFIG_BPFILTER_UMH), y)
diff --git a/net/bpfilter/context.c b/net/bpfilter/context.c
new file mode 100644
index 000000000000..fdfd5fe78424
--- /dev/null
+++ b/net/bpfilter/context.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Telegram FZ-LLC
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ */
+
+#define _GNU_SOURCE
+
+#include "context.h"
+
+int create_context(struct context *ctx)
+{
+	return 0;
+}
+
+void free_context(struct context *ctx)
+{
+}
diff --git a/net/bpfilter/context.h b/net/bpfilter/context.h
new file mode 100644
index 000000000000..df41b9707a81
--- /dev/null
+++ b/net/bpfilter/context.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Telegram FZ-LLC
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ */
+
+#ifndef NET_BPFILTER_CONTEXT_H
+#define NET_BPFILTER_CONTEXT_H
+
+struct context {
+};
+
+int create_context(struct context *ctx);
+void free_context(struct context *ctx);
+
+#endif // NET_BPFILTER_CONTEXT_H
-- 
2.38.1

