Return-Path: <linux-kselftest+bounces-36935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B87AFF9A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503901C4064C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD22874F6;
	Thu, 10 Jul 2025 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fjlWOVOG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAA27FD4A;
	Thu, 10 Jul 2025 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128583; cv=none; b=Eb01In7C+u/8n8YLTxFlCJLH/XViKci6E4vGyJCmVsk8h23wRjjZCoVDHh5YmSD34BTKo+61E7U3u7L+UjedaLoXZhIT5jwYJF8JU+z9K1mv9VgU8c7YCgDi/2WvXviz+DVt4rTJnQPNcFmnmTCC+lRC0RLXobZEV3yPNK/zy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128583; c=relaxed/simple;
	bh=J8GO0yT61Qc0ZqI8Dt9DrUCMl8bIRDzX8e+GF0FHNmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2mNL5NSkxiF6TL3sTchun5zfhZ1W3dpMHE4oV1ELp1gS42mPp70VM85SsO1KL1xqY8ptt9pd22XttbldA6vDlvAd+Z+2mfYaJSAXnFV99R1rVdfCQvXeq8FNXyujGfm7Qsd7peQRfJADQPk2wxKgbCPdUr1Zt3QCwl58A2gzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fjlWOVOG; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6930844367;
	Thu, 10 Jul 2025 06:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752128579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DGbcvy4by3MBfkYs/n6Um3YEhPcZL5yY5OSs/o0DG4=;
	b=fjlWOVOGeApGzYr2ngomNtgxHo3FQSdye8SvFFwAU0BscgWr1N9D6sFHLQNpgm0C6aigfS
	vrP56h0VXrodZ+cs0fxl3UvuFalyQZaLPgb7uHVsHgrukp08+QvWAQx6hpBl57yBiQGNor
	WDH3vRZZtfwHdgr0XmGEHIba8oM2aYLKEh/HlTtlzyuIYI38jgXcylZXDq1ZpD6m+KoucA
	xGWbsmlIjQ6NuRJz5Sy2r7IM26mNPVWm2viXTzX4v+2FuNwlhujtwcr2AKTqaMUmH7od3e
	fzdgtn6AuR6haY8B51N2dipRMrFMgeWjSVl1CXxTn0Sst7cpnsdgZv6aZlQ4Cg==
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
Subject: [PATCH net-next v3 2/3] selftests: ethtool: Drop the unused old_netdevs variable
Date: Thu, 10 Jul 2025 08:22:46 +0200
Message-ID: <20250710062248.378459-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

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


