Return-Path: <linux-kselftest+bounces-36755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BD5AFC9E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 13:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F48A48470D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB92DAFC9;
	Tue,  8 Jul 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fyke5obo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F92D9EF6;
	Tue,  8 Jul 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975743; cv=none; b=VDDEXqQQkXqkAFEx85Dy7XYtEt0i6rft2dCy9BVG6lqTI5FIdP1RB500qfnc0yOFFLesJ/Rl78YwUsOz0cZV9jCe0GxUSmugkFC82ozE5zA8RaLO2GLR5rOnPcgIRjg08dDpX3zVyS/98fo59e8oAhiMtGjv4gVv81aqVSgqk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975743; c=relaxed/simple;
	bh=J8GO0yT61Qc0ZqI8Dt9DrUCMl8bIRDzX8e+GF0FHNmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQZyRLhAWAE0TV+FfEhRwnjF4NdRU/6/CiWWi8CeNAXshudKOMmjGGC67imKJ/aI5ibnIUNmxB9SibnGBinyUvP1kJWS7hvfV1RJvSoBynWyamZfBmi/eNvPDVSb6k70Vmz1a1viPAv1/gifMyg9k4zn7XXi26ZnBCY6BKfnNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fyke5obo; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D513E432A3;
	Tue,  8 Jul 2025 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751975739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DGbcvy4by3MBfkYs/n6Um3YEhPcZL5yY5OSs/o0DG4=;
	b=fyke5oboAcBGUwvHX0eju7pCaPihUvWeSnKe+Os8QtuTJ/Jyil5qfHmPZcf3C7PKo0Sj/5
	Todz5U5iXo/KlAThrV+X6/sZqCCq8r4ozCDZlfwxQKPkpLF2MnKJ+QJWdU21Z34MV4t87M
	8PVq4eXZxvF1PweIe7LlLKnYKOtRQKrHddQp5Ysih7g2fgDf4PZA1+h7HzkoyKT3agK6mK
	I/QCpYsbTnZO/jNMVb7Iv/hbOyfdG0hBEJ0qf/aE5zO8ZQy6m6PXRqwA0+HCHek8R51Xl3
	OYz7uYfF5WwCaArZJyzCL42SGwKAo91ndObjX+UWShmi8xVSVdTmbwbmZDhWsQ==
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
Subject: [PATCH net-next v2 2/3] selftests: ethtool: Drop the unused old_netdevs variable
Date: Tue,  8 Jul 2025 13:55:29 +0200
Message-ID: <20250708115531.111326-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708115531.111326-1-maxime.chevallier@bootlin.com>
References: <20250708115531.111326-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepledtrdejiedriedvrddujedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdejiedriedvrddujedupdhhvghlohepfhgvughorhgrrddrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmr
 ghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
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


