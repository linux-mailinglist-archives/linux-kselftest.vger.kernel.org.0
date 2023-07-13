Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD7752373
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjGMNV2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjGMNVD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:21:03 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB10E2D7B
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 06:20:49 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-eeR6lKTCPZqZiOPmUMcdSw-1; Thu, 13 Jul 2023 09:20:31 -0400
X-MC-Unique: eeR6lKTCPZqZiOPmUMcdSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AD6F80123E;
        Thu, 13 Jul 2023 13:20:30 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 738A02166B26;
        Thu, 13 Jul 2023 13:20:29 +0000 (UTC)
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     netdev@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>, kuba@kernel.org,
        simon.horman@corigine.com, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 1/2] netdevsim: add dummy macsec offload
Date:   Thu, 13 Jul 2023 15:20:23 +0200
Message-Id: <80d31a79b3bab0b8ce7c55f5eab9a25b9896a795.1689173906.git.sd@queasysnail.net>
In-Reply-To: <cover.1689173906.git.sd@queasysnail.net>
References: <cover.1689173906.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the kernel is compiled with MACsec support, add the
NETIF_F_HW_MACSEC feature to netdevsim devices and implement
macsec_ops.

To allow easy testing of failure from the device, support is limited
to 3 SecY's per netdevsim device, and 1 RXSC per SecY.

v2:
 - nsim_macsec_add_secy, return -ENOSPC if secy_count isn't full but
   we can't find an empty slot (Simon Horman)
 - add sci_to_cpu to make sparse happy (Simon Horman)
 - remove set but not used secy variable (kernel test robot and
   Simon Horman)

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/netdevsim/Makefile    |   4 +
 drivers/net/netdevsim/macsec.c    | 356 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c    |   3 +
 drivers/net/netdevsim/netdevsim.h |  34 +++
 4 files changed, 397 insertions(+)
 create mode 100644 drivers/net/netdevsim/macsec.c

diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
index 5735e5b1a2cb..f8de93bc5f5b 100644
--- a/drivers/net/netdevsim/Makefile
+++ b/drivers/net/netdevsim/Makefile
@@ -17,3 +17,7 @@ endif
 ifneq ($(CONFIG_PSAMPLE),)
 netdevsim-objs += psample.o
 endif
+
+ifneq ($(CONFIG_MACSEC),)
+netdevsim-objs += macsec.o
+endif
diff --git a/drivers/net/netdevsim/macsec.c b/drivers/net/netdevsim/macsec.c
new file mode 100644
index 000000000000..0d5f50430dd3
--- /dev/null
+++ b/drivers/net/netdevsim/macsec.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <net/macsec.h>
+#include "netdevsim.h"
+
+static inline u64 sci_to_cpu(sci_t sci)
+{
+	return be64_to_cpu((__force __be64)sci);
+}
+
+static int nsim_macsec_find_secy(struct netdevsim *ns, sci_t sci)
+{
+	int i;
+
+	for (i = 0; i < NSIM_MACSEC_MAX_SECY_COUNT; i++) {
+		if (ns->macsec.nsim_secy[i].sci == sci)
+			return i;
+	}
+
+	return -1;
+}
+
+static int nsim_macsec_find_rxsc(struct nsim_secy *ns_secy, sci_t sci)
+{
+	int i;
+
+	for (i = 0; i < NSIM_MACSEC_MAX_RXSC_COUNT; i++) {
+		if (ns_secy->nsim_rxsc[i].sci == sci)
+			return i;
+	}
+
+	return -1;
+}
+
+static int nsim_macsec_add_secy(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	int idx;
+
+	if (ns->macsec.nsim_secy_count == NSIM_MACSEC_MAX_SECY_COUNT)
+		return -ENOSPC;
+
+	for (idx = 0; idx < NSIM_MACSEC_MAX_SECY_COUNT; idx++) {
+		if (!ns->macsec.nsim_secy[idx].used)
+			break;
+	}
+
+	if (idx == NSIM_MACSEC_MAX_SECY_COUNT) {
+		netdev_err(ctx->netdev, "%s: nsim_secy_count not full but all SecYs used\n",
+			   __func__);
+		return -ENOSPC;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: adding new secy with sci %08llx at index %d\n",
+		   __func__, sci_to_cpu(ctx->secy->sci), idx);
+	ns->macsec.nsim_secy[idx].used = true;
+	ns->macsec.nsim_secy[idx].nsim_rxsc_count = 0;
+	ns->macsec.nsim_secy[idx].sci = ctx->secy->sci;
+	ns->macsec.nsim_secy_count++;
+
+	return 0;
+}
+
+static int nsim_macsec_upd_secy(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: updating secy with sci %08llx at index %d\n",
+		   __func__, sci_to_cpu(ctx->secy->sci), idx);
+
+	return 0;
+}
+
+static int nsim_macsec_del_secy(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: removing SecY with SCI %08llx at index %d\n",
+		   __func__, sci_to_cpu(ctx->secy->sci), idx);
+
+	ns->macsec.nsim_secy[idx].used = false;
+	memset(&ns->macsec.nsim_secy[idx], 0, sizeof(ns->macsec.nsim_secy[idx]));
+	ns->macsec.nsim_secy_count--;
+
+	return 0;
+}
+
+static int nsim_macsec_add_rxsc(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	struct nsim_secy *secy;
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+	secy = &ns->macsec.nsim_secy[idx];
+
+	if (secy->nsim_rxsc_count == NSIM_MACSEC_MAX_RXSC_COUNT)
+		return -ENOSPC;
+
+	for (idx = 0; idx < NSIM_MACSEC_MAX_RXSC_COUNT; idx++) {
+		if (!secy->nsim_rxsc[idx].used)
+			break;
+	}
+
+	if (idx == NSIM_MACSEC_MAX_RXSC_COUNT)
+		netdev_err(ctx->netdev, "%s: nsim_rxsc_count not full but all RXSCs used\n",
+			   __func__);
+
+	netdev_dbg(ctx->netdev, "%s: adding new rxsc with sci %08llx at index %d\n",
+		   __func__, sci_to_cpu(ctx->rx_sc->sci), idx);
+	secy->nsim_rxsc[idx].used = true;
+	secy->nsim_rxsc[idx].sci = ctx->rx_sc->sci;
+	secy->nsim_rxsc_count++;
+
+	return 0;
+}
+
+static int nsim_macsec_upd_rxsc(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	struct nsim_secy *secy;
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+	secy = &ns->macsec.nsim_secy[idx];
+
+	idx = nsim_macsec_find_rxsc(secy, ctx->rx_sc->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+			   __func__, sci_to_cpu(ctx->rx_sc->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: updating RXSC with sci %08llx at index %d\n",
+		   __func__, sci_to_cpu(ctx->rx_sc->sci), idx);
+
+	return 0;
+}
+
+static int nsim_macsec_del_rxsc(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	struct nsim_secy *secy;
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+	secy = &ns->macsec.nsim_secy[idx];
+
+	idx = nsim_macsec_find_rxsc(secy, ctx->rx_sc->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+			   __func__, sci_to_cpu(ctx->rx_sc->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: removing RXSC with sci %08llx at index %d\n",
+		   __func__, sci_to_cpu(ctx->rx_sc->sci), idx);
+
+	secy->nsim_rxsc[idx].used = false;
+	memset(&secy->nsim_rxsc[idx], 0, sizeof(secy->nsim_rxsc[idx]));
+	secy->nsim_rxsc_count--;
+
+	return 0;
+}
+
+static int nsim_macsec_add_rxsa(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	struct nsim_secy *secy;
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+	secy = &ns->macsec.nsim_secy[idx];
+
+	idx = nsim_macsec_find_rxsc(secy, ctx->sa.rx_sa->sc->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+			   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: RXSC with sci %08llx, AN %u\n",
+		   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci), ctx->sa.assoc_num);
+
+	return 0;
+}
+
+static int nsim_macsec_upd_rxsa(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	struct nsim_secy *secy;
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+	secy = &ns->macsec.nsim_secy[idx];
+
+	idx = nsim_macsec_find_rxsc(secy, ctx->sa.rx_sa->sc->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+			   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: RXSC with sci %08llx, AN %u\n",
+		   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci), ctx->sa.assoc_num);
+
+	return 0;
+}
+
+static int nsim_macsec_del_rxsa(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	struct nsim_secy *secy;
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+	secy = &ns->macsec.nsim_secy[idx];
+
+	idx = nsim_macsec_find_rxsc(secy, ctx->sa.rx_sa->sc->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in RXSC table\n",
+			   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: RXSC with sci %08llx, AN %u\n",
+		   __func__, sci_to_cpu(ctx->sa.rx_sa->sc->sci), ctx->sa.assoc_num);
+
+	return 0;
+}
+
+static int nsim_macsec_add_txsa(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: SECY with sci %08llx, AN %u\n",
+		   __func__, sci_to_cpu(ctx->secy->sci), ctx->sa.assoc_num);
+
+	return 0;
+}
+
+static int nsim_macsec_upd_txsa(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: SECY with sci %08llx, AN %u\n",
+		   __func__, sci_to_cpu(ctx->secy->sci), ctx->sa.assoc_num);
+
+	return 0;
+}
+
+static int nsim_macsec_del_txsa(struct macsec_context *ctx)
+{
+	struct netdevsim *ns = netdev_priv(ctx->netdev);
+	int idx;
+
+	idx = nsim_macsec_find_secy(ns, ctx->secy->sci);
+	if (idx < 0) {
+		netdev_err(ctx->netdev, "%s: sci %08llx not found in secy table\n",
+			   __func__, sci_to_cpu(ctx->secy->sci));
+		return -ENOENT;
+	}
+
+	netdev_dbg(ctx->netdev, "%s: SECY with sci %08llx, AN %u\n",
+		   __func__, sci_to_cpu(ctx->secy->sci), ctx->sa.assoc_num);
+
+	return 0;
+}
+
+static const struct macsec_ops nsim_macsec_ops = {
+	.mdo_add_secy = nsim_macsec_add_secy,
+	.mdo_upd_secy = nsim_macsec_upd_secy,
+	.mdo_del_secy = nsim_macsec_del_secy,
+	.mdo_add_rxsc = nsim_macsec_add_rxsc,
+	.mdo_upd_rxsc = nsim_macsec_upd_rxsc,
+	.mdo_del_rxsc = nsim_macsec_del_rxsc,
+	.mdo_add_rxsa = nsim_macsec_add_rxsa,
+	.mdo_upd_rxsa = nsim_macsec_upd_rxsa,
+	.mdo_del_rxsa = nsim_macsec_del_rxsa,
+	.mdo_add_txsa = nsim_macsec_add_txsa,
+	.mdo_upd_txsa = nsim_macsec_upd_txsa,
+	.mdo_del_txsa = nsim_macsec_del_txsa,
+};
+
+void nsim_macsec_init(struct netdevsim *ns)
+{
+	ns->netdev->macsec_ops = &nsim_macsec_ops;
+	ns->netdev->features |= NETIF_F_HW_MACSEC;
+	memset(&ns->macsec, 0, sizeof(ns->macsec));
+}
+
+void nsim_macsec_teardown(struct netdevsim *ns)
+{
+}
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 35fa1ca98671..0c8daeb0d62b 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -304,6 +304,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	if (err)
 		goto err_utn_destroy;
 
+	nsim_macsec_init(ns);
 	nsim_ipsec_init(ns);
 
 	err = register_netdevice(ns->netdev);
@@ -314,6 +315,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 
 err_ipsec_teardown:
 	nsim_ipsec_teardown(ns);
+	nsim_macsec_teardown(ns);
 	nsim_bpf_uninit(ns);
 err_utn_destroy:
 	rtnl_unlock();
@@ -374,6 +376,7 @@ void nsim_destroy(struct netdevsim *ns)
 	rtnl_lock();
 	unregister_netdevice(dev);
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
+		nsim_macsec_teardown(ns);
 		nsim_ipsec_teardown(ns);
 		nsim_bpf_uninit(ns);
 	}
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 7d8ed8d8df5c..7be98b7dcca9 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -23,6 +23,7 @@
 #include <net/devlink.h>
 #include <net/udp_tunnel.h>
 #include <net/xdp.h>
+#include <net/macsec.h>
 
 #define DRV_NAME	"netdevsim"
 
@@ -52,6 +53,25 @@ struct nsim_ipsec {
 	u32 ok;
 };
 
+#define NSIM_MACSEC_MAX_SECY_COUNT 3
+#define NSIM_MACSEC_MAX_RXSC_COUNT 1
+struct nsim_rxsc {
+	sci_t sci;
+	bool used;
+};
+
+struct nsim_secy {
+	sci_t sci;
+	struct nsim_rxsc nsim_rxsc[NSIM_MACSEC_MAX_RXSC_COUNT];
+	u8 nsim_rxsc_count;
+	bool used;
+};
+
+struct nsim_macsec {
+	struct nsim_secy nsim_secy[NSIM_MACSEC_MAX_SECY_COUNT];
+	u8 nsim_secy_count;
+};
+
 struct nsim_ethtool_pauseparam {
 	bool rx;
 	bool tx;
@@ -93,6 +113,7 @@ struct netdevsim {
 
 	bool bpf_map_accept;
 	struct nsim_ipsec ipsec;
+	struct nsim_macsec macsec;
 	struct {
 		u32 inject_error;
 		u32 sleep;
@@ -366,6 +387,19 @@ static inline bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_MACSEC)
+void nsim_macsec_init(struct netdevsim *ns);
+void nsim_macsec_teardown(struct netdevsim *ns);
+#else
+static inline void nsim_macsec_init(struct netdevsim *ns)
+{
+}
+
+static inline void nsim_macsec_teardown(struct netdevsim *ns)
+{
+}
+#endif
+
 struct nsim_bus_dev {
 	struct device dev;
 	struct list_head list;
-- 
2.40.1

