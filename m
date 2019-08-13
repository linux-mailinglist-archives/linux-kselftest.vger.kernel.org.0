Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6C08AF68
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfHMGLn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:11:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfHMGLm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68q2U039297;
        Tue, 13 Aug 2019 06:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=3I+2e/NCnQWfD8Vz78i6DuiXG2jHYFkQRKPcdrFu7Xc=;
 b=ZCaPbWlKx/J6N0HGU5IRAjsBK9CnXsfwASMXQXU1DR8QC5w2JtNF2CqCRQwAzqt/ExYb
 kTeV3cdG4eks3RYMPpZuWahp0Vrn+zDCuvgsNto1/G0W4jeiDq/OAjd9Qy1c/z7plQLi
 CkVz+EPzukG/gbTIo8e/aF3IRG2H69rGVstTTd4gUFw/Aq+LmnVCQK+veg4aGKuK9BX3
 3WrcKfmir+qW4diDSQR4/Yml/sLHypnchluMY8apCAYef3/VKl08RYXfesXfwuB344X1
 hA8SvSIqC6Q39AZJZxHbhqyrMOwv4irD73o/EwB+qUyLgWUHeqgJ2OizO69xBDS1v65/ tg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=3I+2e/NCnQWfD8Vz78i6DuiXG2jHYFkQRKPcdrFu7Xc=;
 b=DnRVNvIk1/YBqv2nBdtgOVL68mfYb1MEbcdMp6tJxh7qwjZCDKx1EQSXlzN5Kvh0+WZM
 9Rn0YIu+29UYRk8wTzVBaJoYsXvYjjFQqlPzRG7vUPg55qoj4/cI8JIK9HZDsZNdJbXO
 xsy82PtovUatao+dLEfH5VoOMYnnZ6CbSQVMePA0TC/u7Q0X90n1eROVnh2v3+dIr/sF
 Geob03XS07Ydkg2eMqjbyWNbDZ7Eko6kN2FgqHrFJGDFqf44fFAVlkkSVuL6p7Wf1eqs
 mA8iXIGoJVeLZAYEvV20aoapyaigX6VN95BK4aWy3XrWEq5OvvSJXcvr3Ibu5YMYRvF0 Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u9nvp41hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67QrL096452;
        Tue, 13 Aug 2019 06:11:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u9m0aye0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D6BLtr026649;
        Tue, 13 Aug 2019 06:11:21 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:21 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 08/19] ktf: Configurable context support for network info setup
Date:   Tue, 13 Aug 2019 08:09:23 +0200
Message-Id: <ddf9f91c347d1c731b4cceea318783bb293676c3.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

An implementation of configurable contexts for exchanging network
information, to make it easier to run network tests potentially
involving more than one kernel.

ktf_netctx.h:    Configurable context setup for multinode network tests

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/kernel/ktf_netctx.c | 132 +++++++++++++++++-
 tools/testing/selftests/ktf/kernel/ktf_netctx.h |  64 ++++++++-
 2 files changed, 196 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_netctx.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_netctx.h

diff --git a/tools/testing/selftests/ktf/kernel/ktf_netctx.c b/tools/testing/selftests/ktf/kernel/ktf_netctx.c
new file mode 100644
index 0000000..84ef6ac
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_netctx.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_netcfg.h: Configurable context setup for multinode network tests
+ *
+ */
+
+#include "ktf.h"
+#include "ktf_netctx.h"
+#include <linux/in.h>
+
+/* Configuration callback to configure a network context */
+
+int ktf_netctx_cb(struct ktf_context *ctx, const void *data, size_t data_sz)
+{
+	struct ktf_netctx *nc = container_of(ctx, struct ktf_netctx, k);
+	struct ktf_addrinfo *kai = (struct ktf_addrinfo *)data;
+	short n = kai->n;
+	size_t param_sz;
+
+	if (n < 2) {
+		terr("Unsupported number of nodes (%d) - must be at least 2", n);
+		return -EINVAL;
+	}
+
+	param_sz = sizeof(*kai) + sizeof(kai->a) * (n - 2);
+
+	if (n > nc->max_nodes || n < nc->min_nodes) {
+		terr("Unsupported number of nodes (%d) - must be between %d and %d!",
+		     n, nc->min_nodes, nc->max_nodes);
+		return -EINVAL;
+	}
+
+	if (param_sz != data_sz) {
+		terr("Expected %lu bytes of parameter data, received %lu!",
+		     param_sz, data_sz);
+		return -EINVAL;
+	}
+
+	if (nc->a && nc->a_sz != data_sz) {
+		kfree(nc->a);
+		nc->a = NULL;
+	}
+
+	if (!nc->a) {
+		nc->a = kzalloc(data_sz, GFP_KERNEL);
+		if (!nc->a)
+			return -ENOMEM;
+	}
+
+	memcpy(nc->a, kai, data_sz);
+	return 0;
+}
+EXPORT_SYMBOL(ktf_netctx_cb);
+
+void ktf_netctx_cleanup(struct ktf_context *ctx)
+{
+	struct ktf_netctx *nc = container_of(ctx, struct ktf_netctx, k);
+
+	kfree(nc->a);
+}
+EXPORT_SYMBOL(ktf_netctx_cleanup);
+
+/* Make network contexts dynamically allocatable from user mode
+ * Caller must supply desired values for callback functions in @nct.
+ */
+int ktf_netctx_enable(struct ktf_handle *handle, struct ktf_netctx_type *nct,
+		      short min_nodes, short max_nodes)
+{
+	struct ktf_context *lo_ctx;
+	struct ktf_addrinfo ai = {
+		.n = 2,
+		.rank = 0
+	};
+	int ret;
+	int i;
+
+	ret = ktf_handle_add_ctx_type(handle, &nct->t);
+	if (ret)
+		return ret;
+
+	nct->min_nodes = min_nodes;
+	nct->max_nodes = max_nodes;
+	strcpy(nct->t.name, "netctx");
+
+	for (i = 0; i < 2; i++) {
+		struct sockaddr_in *ai_in = (struct sockaddr_in *)&ai.a[i].addr;
+
+		ai.a[i].addr.ss_family = AF_INET;
+		strcpy(ai.a[i].ifname, "lo");
+		ai_in->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	}
+
+	/* create and configure the loopback network context */
+	lo_ctx = ktf_context_add_from(handle, "lo", &nct->t);
+	if (!lo_ctx)
+		return -ENOMEM;
+
+	ret = ktf_context_set_config(lo_ctx, &ai, sizeof(ai));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(ktf_netctx_enable);
+
+struct sockaddr_storage *ktf_netctx_addr(struct ktf_netctx *ctx, short rank)
+{
+	return &ctx->a->a[rank].addr;
+}
+EXPORT_SYMBOL(ktf_netctx_addr);
+
+const char *ktf_netctx_ifname(struct ktf_netctx *ctx, short rank)
+{
+	return ctx->a->a[rank].ifname;
+}
+EXPORT_SYMBOL(ktf_netctx_ifname);
+
+short ktf_netctx_rank(struct ktf_netctx *ctx)
+{
+	return ctx->a->rank;
+}
+EXPORT_SYMBOL(ktf_netctx_rank);
+
+short ktf_netctx_n(struct ktf_netctx *ctx)
+{
+	return ctx->a->n;
+}
+EXPORT_SYMBOL(ktf_netctx_n);
diff --git a/tools/testing/selftests/ktf/kernel/ktf_netctx.h b/tools/testing/selftests/ktf/kernel/ktf_netctx.h
new file mode 100644
index 0000000..414c744
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_netctx.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_netctx.h: Configurable context setup for multinode network tests
+ *
+ * KTF implements handling on the kernel side for this but leaves
+ * user space implementation to construct the corresponding
+ * stuct ktf_addrinfo parameter block
+ */
+
+#ifndef _KTF_NETCTX_H
+#define _KTF_NETCTX_H
+
+/* KTF matches against this type id as a possible discriminator: */
+#define KTF_NETCTX_TYPE_ID 0x2222
+
+#define IFNAMSZ 16
+
+struct ktf_peer_address
+{
+	struct sockaddr_storage addr; /* Address to use for this peer */
+	char ifname[IFNAMSZ];	    /* Local name of the interface with this address at peer */
+};
+
+struct ktf_addrinfo
+{
+	short n;		    /* Number of nodes involved, including the local */
+	short rank;		    /* Index into ktf_peer_address that corresponds to local host */
+	struct ktf_peer_address a[2]; /* KTF expects size n instead of 2 here */
+};
+
+#ifdef __KERNEL__
+
+struct ktf_netctx {
+	struct ktf_context k;
+	struct ktf_addrinfo *a; /* Addr.info dyn.allocated based on incoming data */
+	size_t a_sz;		/* Size of the allocation in a, if any */
+	short min_nodes;	/* Minimum number of nodes for this context */
+	short max_nodes;	/* Maximum number of nodes this context supports */
+};
+
+struct ktf_netctx_type {
+	struct ktf_context_type t;
+	short min_nodes;	/* Minimum number of nodes for the context type */
+	short max_nodes;	/* Maximum number of nodes for the context type */
+};
+
+int ktf_netctx_enable(struct ktf_handle *handle, struct ktf_netctx_type *nct,
+		      short min_nodes, short max_nodes);
+
+int ktf_netctx_cb(struct ktf_context *ctx, const void *data, size_t data_sz);
+void ktf_netctx_cleanup(struct ktf_context *ctx);
+
+struct sockaddr_storage *ktf_netctx_addr(struct ktf_netctx *ctx, short rank);
+const char *ktf_netctx_ifname(struct ktf_netctx *ctx, short rank);
+short ktf_netctx_rank(struct ktf_netctx *ctx);
+short ktf_netctx_n(struct ktf_netctx *ctx);
+
+#endif
+
+#endif
-- 
git-series 0.9.1
