Return-Path: <linux-kselftest+bounces-2268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4050381A240
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31991F250F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1207346B9C;
	Wed, 20 Dec 2023 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L+YZvCoQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E246533;
	Wed, 20 Dec 2023 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+yj8VuP41eiiySVWvgWGyveaqTwxGCtRrmJYyT2kki4=;
	t=1703085604; x=1704295204; b=L+YZvCoQGMy9r61lQBSa6B3olE1vo7g9DciL+mgZFgRvKD2
	FwqoJquMKRUh0Ca8kvhthIKfc1gxoNek6GYKi86kCzojPkeI/iJYDBgYhOpaMZj0ybmClRcxO3aJQ
	Ys0BsoLUJUrBQ8ox5V2aYfEOuOyHE8yMqDCbxyDpYZw+oY4ufz8ykeltDfFU+50RfMEsxDtQ/uKzk
	KG4derxx//XjPDxWXUByCd09XGHQDMq1LHZXwt0NfxIagWizPBqNjFqL5LkXUYUIBWL5NFIciXpPt
	jOZuKHIYZpOzj6OJ91E1e3JexO661crEmzZE0FmbxhXxl4zsE8L7/gmtmF0wBjiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rFyMb-00000001WFz-3Yhn;
	Wed, 20 Dec 2023 16:20:02 +0100
From: benjamin@sipsolutions.net
To: linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5/6] wifi: mac80211: kunit: extend MFP tests
Date: Wed, 20 Dec 2023 16:19:51 +0100
Message-ID: <20231220151952.415232-6-benjamin@sipsolutions.net>
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

Extend the MFP tests to handle the case of deauth/disassoc
and robust action frames (that are not protected dual of
public action frames).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tests/mfp.c | 74 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tests/mfp.c b/net/mac80211/tests/mfp.c
index 6ec31386c0df..a8dc1601da60 100644
--- a/net/mac80211/tests/mfp.c
+++ b/net/mac80211/tests/mfp.c
@@ -13,7 +13,7 @@ MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
 
 static const struct mfp_test_case {
 	const char *desc;
-	bool sta, mfp, decrypted, unicast;
+	bool sta, mfp, decrypted, unicast, assoc;
 	u8 category;
 	u8 stype;
 	u8 action;
@@ -151,13 +151,67 @@ static const struct mfp_test_case {
 		.mfp = true,
 		.result = RX_CONTINUE,
 	},
+	/* deauth/disassoc before keys are set */
+	{
+		.desc = "deauth: accept unicast with MFP but w/o key",
+		.stype = IEEE80211_STYPE_DEAUTH,
+		.sta = true,
+		.mfp = true,
+		.unicast = true,
+		.result = RX_CONTINUE,
+	},
+	{
+		.desc = "disassoc: accept unicast with MFP but w/o key",
+		.stype = IEEE80211_STYPE_DEAUTH,
+		.sta = true,
+		.mfp = true,
+		.unicast = true,
+		.result = RX_CONTINUE,
+	},
+	/* non-public robust action frame ... */
+	{
+		.desc = "BA action: drop unicast before assoc",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_BACK,
+		.unicast = true,
+		.sta = true,
+		.result = RX_DROP_U_UNPROT_ROBUST_ACTION,
+	},
+	{
+		.desc = "BA action: drop unprotected after assoc",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_BACK,
+		.unicast = true,
+		.sta = true,
+		.mfp = true,
+		.result = RX_DROP_U_UNPROT_UCAST_MGMT,
+	},
+	{
+		.desc = "BA action: accept unprotected without MFP",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_BACK,
+		.unicast = true,
+		.sta = true,
+		.assoc = true,
+		.mfp = false,
+		.result = RX_CONTINUE,
+	},
+	{
+		.desc = "BA action: drop unprotected with MFP",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_BACK,
+		.unicast = true,
+		.sta = true,
+		.mfp = true,
+		.result = RX_DROP_U_UNPROT_UCAST_MGMT,
+	},
 };
 
 KUNIT_ARRAY_PARAM_DESC(accept_mfp, accept_mfp_cases, desc);
 
 static void accept_mfp(struct kunit *test)
 {
-	static struct sta_info sta = {};
+	static struct sta_info sta;
 	const struct mfp_test_case *params = test->param_value;
 	struct ieee80211_rx_data rx = {
 		.sta = params->sta ? &sta : NULL,
@@ -171,6 +225,8 @@ static void accept_mfp(struct kunit *test)
 		/* A3/BSSID doesn't matter here */
 	};
 
+	memset(&sta, 0, sizeof(sta));
+
 	if (!params->sta) {
 		KUNIT_ASSERT_FALSE(test, params->mfp);
 		KUNIT_ASSERT_FALSE(test, params->decrypted);
@@ -179,6 +235,9 @@ static void accept_mfp(struct kunit *test)
 	if (params->mfp)
 		set_sta_flag(&sta, WLAN_STA_MFP);
 
+	if (params->assoc)
+		set_bit(WLAN_STA_ASSOC, &sta._flags);
+
 	rx.skb = kunit_zalloc_skb(test, 128, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, rx.skb);
 	status = IEEE80211_SKB_RXCB(rx.skb);
@@ -200,11 +259,18 @@ static void accept_mfp(struct kunit *test)
 		skb_put_u8(rx.skb, params->category);
 		skb_put_u8(rx.skb, params->action);
 		break;
+	case IEEE80211_STYPE_DEAUTH:
+	case IEEE80211_STYPE_DISASSOC: {
+		__le16 reason = cpu_to_le16(WLAN_REASON_UNSPECIFIED);
+
+		skb_put_data(rx.skb, &reason, sizeof(reason));
+		}
+		break;
 	}
 
 	KUNIT_EXPECT_EQ(test,
-			ieee80211_drop_unencrypted_mgmt(&rx),
-			params->result);
+			(__force u32)ieee80211_drop_unencrypted_mgmt(&rx),
+			(__force u32)params->result);
 }
 
 static struct kunit_case mfp_test_cases[] = {
-- 
2.43.0


