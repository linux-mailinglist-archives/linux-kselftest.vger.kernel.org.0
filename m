Return-Path: <linux-kselftest+bounces-2265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A48B81A23B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 16:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F2F1F24E41
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531724645F;
	Wed, 20 Dec 2023 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IjkvImJW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358E40BE8;
	Wed, 20 Dec 2023 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zM1NmbtY8oJ2SJuuMbKTOdrdX9kUdF1iXZ+ZD63XS8E=;
	t=1703085602; x=1704295202; b=IjkvImJW5uCHhPYcg1tby1F+5b9Awn+Tp8wIJ7rPMQEGjPN
	R4R4IIGc9jqKmzihsMWdngD2dtw/fvJrVno9B5yVtzYuoti5aWHvxraFEExRm7XgCqyDoXFOdaX++
	sel4pT6SRgJBg44F/FKLzj7tT0USmgBChpyV6IyxbDOPhKzdD74EM71z860iuWRSleHQb8TeFBlIH
	SiOzmWAEUHkJyiG+S3p6+wMaHK5JJDomQStqM1jFkm/lA1K6QdU/072+ov8MQOR/J/sRoNYlN8mOI
	SW1wI7FwHrHPq3RGPEM8zBpYVrF+9Dc7HKdPoADNf5Lp4S25Y6F0LvSKVO+3ga6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rFyMZ-00000001WFz-45BE;
	Wed, 20 Dec 2023 16:20:00 +0100
From: benjamin@sipsolutions.net
To: linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/6] wifi: mac80211: add kunit tests for public action handling
Date: Wed, 20 Dec 2023 16:19:49 +0100
Message-ID: <20231220151952.415232-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220151952.415232-1-benjamin@sipsolutions.net>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Check the logic in ieee80211_drop_unencrypted_mgmt()
according to a list of test cases derived from the
spec.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
---
 net/mac80211/ieee80211_i.h  |  10 ++
 net/mac80211/rx.c           |   4 +-
 net/mac80211/tests/Makefile |   2 +-
 net/mac80211/tests/mfp.c    | 184 ++++++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+), 2 deletions(-)
 create mode 100644 net/mac80211/tests/mfp.c

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 29312f6638a1..71fafcd6a36e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2610,4 +2610,14 @@ void ieee80211_check_wbrf_support(struct ieee80211_local *local);
 void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
 void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
 
+#if IS_ENABLED(CONFIG_MAC80211_KUNIT_TEST)
+#define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym) EXPORT_SYMBOL_IF_KUNIT(sym)
+#define VISIBLE_IF_MAC80211_KUNIT
+ieee80211_rx_result
+ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx);
+#else
+#define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym)
+#define VISIBLE_IF_MAC80211_KUNIT static
+#endif
+
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index bbfdcb0ade72..d294787feed0 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -19,6 +19,7 @@
 #include <linux/export.h>
 #include <linux/kcov.h>
 #include <linux/bitops.h>
+#include <kunit/visibility.h>
 #include <net/mac80211.h>
 #include <net/ieee80211_radiotap.h>
 #include <asm/unaligned.h>
@@ -2405,7 +2406,7 @@ static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 	return 0;
 }
 
-static ieee80211_rx_result
+VISIBLE_IF_MAC80211_KUNIT ieee80211_rx_result
 ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
@@ -2484,6 +2485,7 @@ ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 
 	return RX_CONTINUE;
 }
+EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_drop_unencrypted_mgmt);
 
 static ieee80211_rx_result
 __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
diff --git a/net/mac80211/tests/Makefile b/net/mac80211/tests/Makefile
index 4814584f8a14..4fdaf3feaca3 100644
--- a/net/mac80211/tests/Makefile
+++ b/net/mac80211/tests/Makefile
@@ -1,3 +1,3 @@
-mac80211-tests-y += module.o elems.o
+mac80211-tests-y += module.o elems.o mfp.o
 
 obj-$(CONFIG_MAC80211_KUNIT_TEST) += mac80211-tests.o
diff --git a/net/mac80211/tests/mfp.c b/net/mac80211/tests/mfp.c
new file mode 100644
index 000000000000..629a5801c08f
--- /dev/null
+++ b/net/mac80211/tests/mfp.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for management frame acceptance
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <kunit/test.h>
+#include <kunit/skbuff.h>
+#include "../ieee80211_i.h"
+#include "../sta_info.h"
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
+static const struct mfp_test_case {
+	const char *desc;
+	bool sta, mfp, decrypted, unicast, protected_dual;
+	ieee80211_rx_result result;
+} accept_public_action_cases[] = {
+	/* regular public action */
+	{
+		.desc = "public action: accept unicast from unknown peer",
+		.unicast = true,
+		.result = RX_CONTINUE,
+	},
+	{
+		.desc = "public action: accept multicast from unknown peer",
+		.unicast = false,
+		.result = RX_CONTINUE,
+	},
+	{
+		.desc = "public action: accept unicast without MFP",
+		.unicast = true,
+		.sta = true,
+		.result = RX_CONTINUE,
+	},
+	{
+		.desc = "public action: accept multicast without MFP",
+		.unicast = false,
+		.sta = true,
+		.result = RX_CONTINUE,
+	},
+	{
+		.desc = "public action: drop unicast with MFP",
+		.unicast = true,
+		.sta = true,
+		.mfp = true,
+		.result = RX_DROP_U_UNPROT_UNICAST_PUB_ACTION,
+	},
+	{
+		.desc = "public action: accept multicast with MFP",
+		.unicast = false,
+		.sta = true,
+		.mfp = true,
+		.result = RX_CONTINUE,
+	},
+	/* protected dual of public action */
+	{
+		.desc = "protected dual: drop unicast from unknown peer",
+		.protected_dual = true,
+		.unicast = true,
+		.result = RX_DROP_U_UNPROT_DUAL,
+	},
+	{
+		.desc = "protected dual: drop multicast from unknown peer",
+		.protected_dual = true,
+		.unicast = false,
+		.result = RX_DROP_U_UNPROT_DUAL,
+	},
+	{
+		.desc = "protected dual: drop unicast without MFP",
+		.protected_dual = true,
+		.unicast = true,
+		.sta = true,
+		.result = RX_DROP_U_UNPROT_DUAL,
+	},
+	{
+		.desc = "protected dual: drop multicast without MFP",
+		.protected_dual = true,
+		.unicast = false,
+		.sta = true,
+		.result = RX_DROP_U_UNPROT_DUAL,
+	},
+	{
+		.desc = "protected dual: drop undecrypted unicast with MFP",
+		.protected_dual = true,
+		.unicast = true,
+		.sta = true,
+		.mfp = true,
+		.result = RX_DROP_U_UNPROT_DUAL,
+	},
+	{
+		.desc = "protected dual: drop undecrypted multicast with MFP",
+		.protected_dual = true,
+		.unicast = false,
+		.sta = true,
+		.mfp = true,
+		.result = RX_DROP_U_UNPROT_DUAL,
+	},
+	{
+		.desc = "protected dual: accept unicast with MFP",
+		.protected_dual = true,
+		.decrypted = true,
+		.unicast = true,
+		.sta = true,
+		.mfp = true,
+		.result = RX_CONTINUE,
+	},
+	{
+		.desc = "protected dual: accept multicast with MFP",
+		.protected_dual = true,
+		.decrypted = true,
+		.unicast = false,
+		.sta = true,
+		.mfp = true,
+		.result = RX_CONTINUE,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(accept_public_action,
+		       accept_public_action_cases,
+		       desc);
+
+static void accept_public_action(struct kunit *test)
+{
+	static struct sta_info sta = {};
+	const struct mfp_test_case *params = test->param_value;
+	struct ieee80211_rx_data rx = {
+		.sta = params->sta ? &sta : NULL,
+	};
+	struct ieee80211_rx_status *status;
+	struct ieee80211_hdr_3addr hdr = {
+		.frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					     IEEE80211_STYPE_ACTION),
+		.addr1 = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
+		.addr2 = { 0x12, 0x22, 0x33, 0x44, 0x55, 0x66 },
+		/* A3/BSSID doesn't matter here */
+	};
+
+	if (!params->sta) {
+		KUNIT_ASSERT_FALSE(test, params->mfp);
+		KUNIT_ASSERT_FALSE(test, params->decrypted);
+	}
+
+	if (params->mfp)
+		set_sta_flag(&sta, WLAN_STA_MFP);
+
+	rx.skb = kunit_zalloc_skb(test, 128, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, rx.skb);
+	status = IEEE80211_SKB_RXCB(rx.skb);
+
+	if (params->decrypted) {
+		status->flag |= RX_FLAG_DECRYPTED;
+		if (params->unicast)
+			hdr.frame_control |=
+				cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+	}
+
+	if (params->unicast)
+		hdr.addr1[0] = 0x02;
+
+	skb_put_data(rx.skb, &hdr, sizeof(hdr));
+
+	if (params->protected_dual)
+		skb_put_u8(rx.skb, WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION);
+	else
+		skb_put_u8(rx.skb, WLAN_CATEGORY_PUBLIC);
+	skb_put_u8(rx.skb, WLAN_PUB_ACTION_DSE_ENABLEMENT);
+
+	KUNIT_EXPECT_EQ(test,
+			ieee80211_drop_unencrypted_mgmt(&rx),
+			params->result);
+}
+
+static struct kunit_case mfp_test_cases[] = {
+	KUNIT_CASE_PARAM(accept_public_action, accept_public_action_gen_params),
+	{}
+};
+
+static struct kunit_suite mfp = {
+	.name = "mac80211-mfp",
+	.test_cases = mfp_test_cases,
+};
+
+kunit_test_suite(mfp);
-- 
2.43.0


