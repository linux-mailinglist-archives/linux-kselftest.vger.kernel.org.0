Return-Path: <linux-kselftest+bounces-36276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358BDAF0DFC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADCB4870D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6DA239E67;
	Wed,  2 Jul 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P0iW64HQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72BA20408A;
	Wed,  2 Jul 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444903; cv=none; b=lnqptwwQwqCjbQgxf+U194B39wVQXOwd3LcNzDsAXRejH+sAyosEL/Ag4EcoUHK31t6s1SlHoDUJDuvsFDWZpLBOzdy7KxHIkePGPfMQ4xrRFUUUdVy5SImcZFehR21RT9YUs1Oken10J1tDSvxN//xu5qhcFTD6EwaFc/OeLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444903; c=relaxed/simple;
	bh=J8GO0yT61Qc0ZqI8Dt9DrUCMl8bIRDzX8e+GF0FHNmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upIpFdJP32bFnl6NPHfFfUKtLN4jOHOLOhTvh7veX1mZTeYSMEUMj4aGPQcJhBgHkIEP0HfwCqj4LkeOZThsNgqE5RfLxQYkKLutIzisJ/54h4hhEE5hjoqIMvDOrSPMJ2rYfQFmrjP1NpnKJ03TM+Les71lJWRPi7nYrdX7Woo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P0iW64HQ; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A78BB43185;
	Wed,  2 Jul 2025 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751444894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DGbcvy4by3MBfkYs/n6Um3YEhPcZL5yY5OSs/o0DG4=;
	b=P0iW64HQSdurpOByAcqXi5k6JznPNG6AkKsky3ryCBqnJ/ghqllcLdeTHEktvWi+KRkdag
	DD/lnmvKgJ6f6yS4qbj5BdP2IOCtIOVfAivcBad+AAwsDd3n2dRrosIJdKsIUuRdnjdKDT
	ArlSI6JdaAZqJ9Gj//an7fcBIV9DzHRjUrwqGKPHV2OVaRZtAe3cXvP2MIAtf6ce3eNARM
	FATOdYBudS5upwUyvjGs1AFayX1vrbQ2mGq6qecFLX8W0S8GkoyaC+F2kAzLdrbYf9LL2g
	nazbRoOipsuq0YQXkuIksNNW3YC/qJXUbzyUJM7El9W1A/nBs+0XlDQt1qFdmQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/3] selftests: ethtool: Drop the unused old_netdevs variable
Date: Wed,  2 Jul 2025 10:28:04 +0200
Message-ID: <20250702082806.706973-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh

old_netdevs is unused in ethtool-common.sh. Only the UDP tunnels test
uses that variable, but it maintains it locally.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../testing/selftests/drivers/net/netdevsim/ethtool-common.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
index 80160579e0cc..d9c7a3d397a9 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-common.sh
@@ -43,13 +43,11 @@ function check {
 }
 
 function make_netdev {
-    # Make a netdevsim
-    old_netdevs=$(ls /sys/class/net)
-
     if ! $(lsmod | grep -q netdevsim); then
 	modprobe netdevsim
     fi
 
+    # Make a netdevsim
     echo $NSIM_ID $@ > /sys/bus/netdevsim/new_device
     udevadm settle
     # get new device name
-- 
2.49.0


