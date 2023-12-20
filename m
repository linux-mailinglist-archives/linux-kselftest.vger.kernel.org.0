Return-Path: <linux-kselftest+bounces-2267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F0B81A23E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 16:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1052812B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B140BE8;
	Wed, 20 Dec 2023 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lxKISObk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF740BF5;
	Wed, 20 Dec 2023 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SSI1ONWLgJ6hvWU6D2CqXHftyRnNHc81CNvWwH6Hj0g=;
	t=1703085603; x=1704295203; b=lxKISObkGDKxLJiA8nAoIlHgqUnyMvyxtEP2RjUeD0OrMGt
	3HGiq2R7/+ORoVSSk2ukeylZ2m683Fhhx79uqhSnT5f9UHdAbGhcdI1BoPYbN9MKbSue7p9+Sph1f
	f8JhswVIk9hhXjuwK7Q44KJB2c7yh+h/uQj3yYfr9NPM+E7EZJ3EIQoEZYoUQehfv9UHtB2M0DW4k
	QT+IurrAC4dtR7p5GS5Yo0Z/itciFzuhFC7TJ0B9M6VEvDjGT2PoaoUxLRwTn41JYDAPYArorB2h/
	ttLqp8xuYJ6gEew5K2PUbZHO/XcmPeo1TTMHA0reKVrwFXVf3cOtHbll/yKf5TTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rFyMa-00000001WFz-3MHW;
	Wed, 20 Dec 2023 16:20:01 +0100
From: benjamin@sipsolutions.net
To: linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/6] wifi: mac80211: kunit: generalize public action test
Date: Wed, 20 Dec 2023 16:19:50 +0100
Message-ID: <20231220151952.415232-5-benjamin@sipsolutions.net>
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

Generalize the test to be able to handle arbitrary
action categories and non-action frames, for further
test expansion.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tests/mfp.c | 78 +++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 21 deletions(-)

diff --git a/net/mac80211/tests/mfp.c b/net/mac80211/tests/mfp.c
index 629a5801c08f..6ec31386c0df 100644
--- a/net/mac80211/tests/mfp.c
+++ b/net/mac80211/tests/mfp.c
@@ -13,34 +13,52 @@ MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
 
 static const struct mfp_test_case {
 	const char *desc;
-	bool sta, mfp, decrypted, unicast, protected_dual;
+	bool sta, mfp, decrypted, unicast;
+	u8 category;
+	u8 stype;
+	u8 action;
 	ieee80211_rx_result result;
-} accept_public_action_cases[] = {
+} accept_mfp_cases[] = {
 	/* regular public action */
 	{
 		.desc = "public action: accept unicast from unknown peer",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PUBLIC,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = true,
 		.result = RX_CONTINUE,
 	},
 	{
 		.desc = "public action: accept multicast from unknown peer",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PUBLIC,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = false,
 		.result = RX_CONTINUE,
 	},
 	{
 		.desc = "public action: accept unicast without MFP",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PUBLIC,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = true,
 		.sta = true,
 		.result = RX_CONTINUE,
 	},
 	{
 		.desc = "public action: accept multicast without MFP",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PUBLIC,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = false,
 		.sta = true,
 		.result = RX_CONTINUE,
 	},
 	{
 		.desc = "public action: drop unicast with MFP",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PUBLIC,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = true,
 		.sta = true,
 		.mfp = true,
@@ -48,6 +66,9 @@ static const struct mfp_test_case {
 	},
 	{
 		.desc = "public action: accept multicast with MFP",
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PUBLIC,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = false,
 		.sta = true,
 		.mfp = true,
@@ -56,33 +77,43 @@ static const struct mfp_test_case {
 	/* protected dual of public action */
 	{
 		.desc = "protected dual: drop unicast from unknown peer",
-		.protected_dual = true,
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = true,
 		.result = RX_DROP_U_UNPROT_DUAL,
 	},
 	{
 		.desc = "protected dual: drop multicast from unknown peer",
-		.protected_dual = true,
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = false,
 		.result = RX_DROP_U_UNPROT_DUAL,
 	},
 	{
 		.desc = "protected dual: drop unicast without MFP",
-		.protected_dual = true,
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = true,
 		.sta = true,
 		.result = RX_DROP_U_UNPROT_DUAL,
 	},
 	{
 		.desc = "protected dual: drop multicast without MFP",
-		.protected_dual = true,
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = false,
 		.sta = true,
 		.result = RX_DROP_U_UNPROT_DUAL,
 	},
 	{
 		.desc = "protected dual: drop undecrypted unicast with MFP",
-		.protected_dual = true,
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = true,
 		.sta = true,
 		.mfp = true,
@@ -90,7 +121,9 @@ static const struct mfp_test_case {
 	},
 	{
 		.desc = "protected dual: drop undecrypted multicast with MFP",
-		.protected_dual = true,
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.unicast = false,
 		.sta = true,
 		.mfp = true,
@@ -98,7 +131,9 @@ static const struct mfp_test_case {
 	},
 	{
 		.desc = "protected dual: accept unicast with MFP",
-		.protected_dual = true,
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.decrypted = true,
 		.unicast = true,
 		.sta = true,
@@ -107,7 +142,9 @@ static const struct mfp_test_case {
 	},
 	{
 		.desc = "protected dual: accept multicast with MFP",
-		.protected_dual = true,
+		.stype = IEEE80211_STYPE_ACTION,
+		.category = WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION,
+		.action = WLAN_PUB_ACTION_DSE_ENABLEMENT,
 		.decrypted = true,
 		.unicast = false,
 		.sta = true,
@@ -116,11 +153,9 @@ static const struct mfp_test_case {
 	},
 };
 
-KUNIT_ARRAY_PARAM_DESC(accept_public_action,
-		       accept_public_action_cases,
-		       desc);
+KUNIT_ARRAY_PARAM_DESC(accept_mfp, accept_mfp_cases, desc);
 
-static void accept_public_action(struct kunit *test)
+static void accept_mfp(struct kunit *test)
 {
 	static struct sta_info sta = {};
 	const struct mfp_test_case *params = test->param_value;
@@ -130,7 +165,7 @@ static void accept_public_action(struct kunit *test)
 	struct ieee80211_rx_status *status;
 	struct ieee80211_hdr_3addr hdr = {
 		.frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
-					     IEEE80211_STYPE_ACTION),
+					     params->stype),
 		.addr1 = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
 		.addr2 = { 0x12, 0x22, 0x33, 0x44, 0x55, 0x66 },
 		/* A3/BSSID doesn't matter here */
@@ -160,11 +195,12 @@ static void accept_public_action(struct kunit *test)
 
 	skb_put_data(rx.skb, &hdr, sizeof(hdr));
 
-	if (params->protected_dual)
-		skb_put_u8(rx.skb, WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION);
-	else
-		skb_put_u8(rx.skb, WLAN_CATEGORY_PUBLIC);
-	skb_put_u8(rx.skb, WLAN_PUB_ACTION_DSE_ENABLEMENT);
+	switch (params->stype) {
+	case IEEE80211_STYPE_ACTION:
+		skb_put_u8(rx.skb, params->category);
+		skb_put_u8(rx.skb, params->action);
+		break;
+	}
 
 	KUNIT_EXPECT_EQ(test,
 			ieee80211_drop_unencrypted_mgmt(&rx),
@@ -172,7 +208,7 @@ static void accept_public_action(struct kunit *test)
 }
 
 static struct kunit_case mfp_test_cases[] = {
-	KUNIT_CASE_PARAM(accept_public_action, accept_public_action_gen_params),
+	KUNIT_CASE_PARAM(accept_mfp, accept_mfp_gen_params),
 	{}
 };
 
-- 
2.43.0


