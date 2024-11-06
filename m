Return-Path: <linux-kselftest+bounces-21559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DAC9BF9CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F5B21B19
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6520E326;
	Wed,  6 Nov 2024 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GJpSQszg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VldzK/Xh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED81DDC04;
	Wed,  6 Nov 2024 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934854; cv=none; b=RO0/gnB7W1GjYB3LdzeAiPJIrgPTqopDFZnkWZpOsAQHrs6ytiIREdV89Q4zLbj1BmHcZael9bSQTxtvkWbHF0P8bvGXdMPwC+xowxv63OEBrHoRlwREIgbiyeTXaN3jitJSpmzsAHAejCrXTK7nlhlK9dQCYfPlZsFXzfmssWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934854; c=relaxed/simple;
	bh=+vNOg0UogDcPlrv5oklLZdG0O7l0teZO+9xXyIsP6Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPGuX7lS9zDl9keYWe2+k1+Y54CVcGAAbD/yA+2UdVOecXAP3Ur95Ju7vpm69iQZvlJSZt3OPq2LJThKodQKV5MLzrUVXzZyYfkAySzalNsEXymovfXcf5O+DCt+GVOsurkgqiyUSbkpOSXqHeEaQ3139gOyp7tbMjlN1CKNwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GJpSQszg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VldzK/Xh; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 7DF621D402D4;
	Wed,  6 Nov 2024 18:14:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 06 Nov 2024 18:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730934852; x=
	1730938452; bh=u3HYLUVDjDik9H8updhYO+EySw8B2YuRX/0/IySIImU=; b=G
	JpSQszgd9lQ3ImnfZJ/UAAiVpB7eJP0prs3KcKyreRXuoiwwwiPyuXPDnAt3XrA5
	KiMeHhTErwXEDd+l1U69i58Zs0/wh8pvt3pPviugbp1hOhsZ7p6a8IDLmsxtzX68
	1cTacjrHLKIB0Y8KLNhN1K14HUs6e4q2aqHHHM6ZN1yv8JzNwhJqHo8lMIMQC/Fw
	0wCIy1rYzP1WViBPdsF+/RmFejx0p5pu6V0kn5zrMUZZFeg6pCIN83ItBlJOuSi+
	4izR/BIijr8FDZY2mgwWIeg/gh5UFkhe66hI3tB+qXEQ0C08IgSd0dh7kwL9cl+A
	P04IPoYVvUtBT1j3np2fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730934852; x=1730938452; bh=u
	3HYLUVDjDik9H8updhYO+EySw8B2YuRX/0/IySIImU=; b=VldzK/XhJDK84jQkv
	3RFps3bw6GUatDenqihpo9RCB5/Ktp/1K6eVlyXsq7qqa6Ud8L/ZG7pH2tCItsOy
	7xGlpCnfeowXaIVsLb7gF88/A2SHvajsLkY9PDBA49B2OcThQafQ1XBv8aupKNCK
	DFPefo1Dhu3dCLM/cK1HsDMimyfggTIg5OEUIWBOsOkCTILl4iGxSkrMRr0cnYam
	ZxUkXbf12TJ7p/Qqz4iEi+OUMq+jnavhGDDa28HqrhdnEqUDizAgwGjJdSiHnBWr
	hwG3CLmXs/3uU6Vus7IfDdB1dzNQdAzcmAAiS6oSxMoClbNJ/Ln6MgYLnKrt+23F
	lbctQ==
X-ME-Sender: <xms:RPgrZxMc6q1E5DjDXft_n6xBVi0sNbbgjWRWR4cj5kQzHSU9Myf-cg>
    <xme:RPgrZz8iYQVI6KQg-K4Iw0qPed5UqZL8DTCoA2nRI2sloPdo3F8GpEu1IzRWELC92
    qpPsVYLy5lwke8OWXs>
X-ME-Received: <xmr:RPgrZwSHlLrpmcVzv3hnh-6bD4MFxVqQnhPiYmyfTYyQ_rHpsCE5wCSFCzpf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgr
    ihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgv
    lhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RPgrZ9uAHhcbBQC6tlCpT3hMN0-kfVKBOrmtvKJEqyT9y32FaFMGkA>
    <xmx:RPgrZ5dj6S_s8xUycKLHQXbx7DvhYhdohUaG-tn4NYmhpfZhVHlRhw>
    <xmx:RPgrZ52t81dMae8i9rBGu4CVt4Co6vUB8T-dAdteT2UJUr9Xf3Pr2g>
    <xmx:RPgrZ1-LFQa79KEe0eGDRmxJ_1O0qjxQgPyj8mWgRA3OZ6QkrXVrUA>
    <xmx:RPgrZ6qsjgxpKvERSZpdoRD1yywL6k0x2A8FhXg1i33S9uRBTo9AGqnC>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:14:11 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 8/8] selftests: netdevsim: add ethtool features to macsec offload tests
Date: Thu,  7 Nov 2024 00:13:34 +0100
Message-ID: <ba801bd0a75b02de2dddbfc77f9efceb8b3d8a2e.1730929545.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730929545.git.sd@queasysnail.net>
References: <cover.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test verifies that available features aren't changed by toggling
offload on the device. Creating a device with offload off and then
enabling it later should result in the same features as creating the
device with offload enabled directly.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 .../drivers/net/netdevsim/macsec-offload.sh   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh b/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
index 1f2775846ea0..98033e6667d2 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/macsec-offload.sh
@@ -75,6 +75,39 @@ for dev in ${MACSEC_NETDEV}{,2,3} ; do
 done
 
 
+#
+# test ethtool features when toggling offload
+#
+
+ip link add link $NSIM_NETDEV $MACSEC_NETDEV type macsec offload mac
+TMP_FEATS_ON_1="$(ethtool -k $MACSEC_NETDEV)"
+
+ip link set $MACSEC_NETDEV type macsec offload off
+TMP_FEATS_OFF_1="$(ethtool -k $MACSEC_NETDEV)"
+
+ip link set $MACSEC_NETDEV type macsec offload mac
+TMP_FEATS_ON_2="$(ethtool -k $MACSEC_NETDEV)"
+
+[ "$TMP_FEATS_ON_1" = "$TMP_FEATS_ON_2" ]
+check $?
+
+ip link del $MACSEC_NETDEV
+
+ip link add link $NSIM_NETDEV $MACSEC_NETDEV type macsec
+check $?
+
+TMP_FEATS_OFF_2="$(ethtool -k $MACSEC_NETDEV)"
+[ "$TMP_FEATS_OFF_1" = "$TMP_FEATS_OFF_2" ]
+check $?
+
+ip link set $MACSEC_NETDEV type macsec offload mac
+check $?
+
+TMP_FEATS_ON_3="$(ethtool -k $MACSEC_NETDEV)"
+[ "$TMP_FEATS_ON_1" = "$TMP_FEATS_ON_3" ]
+check $?
+
+
 if [ $num_errors -eq 0 ]; then
     echo "PASSED all $((num_passes)) checks"
     exit 0
-- 
2.47.0


