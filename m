Return-Path: <linux-kselftest+bounces-36934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB6AFF9A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957A31605D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39918284B2E;
	Thu, 10 Jul 2025 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mEIYmXPT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09D1F948;
	Thu, 10 Jul 2025 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128582; cv=none; b=LgblZPowztHOpPk2ozXiwixBZkHQEoJmYvxAlj3A29iRPqkl4V+HOd73RIOYRYw1bEiSaKNvG0yS7XBTKWDadV3S/XTcqyJ/ckeZzZ2Pr36MJuu57+43C+JlIZdUuZ5N9Rom0ivmnTIlbds4HpHM+JyXbFonABGOSuO/D50wP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128582; c=relaxed/simple;
	bh=M8DuLG0HMb8JJA8QF4/LocOVETDgVy/0Q/eMqNzZrrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIz3Iqn7MQ9t3hjIjtYp/F/IQJ+MxXHEgPXr3p5OI0vTuW49h0puDonT+ZJDOO+vuXfwmH9d74mIqf6nS51yoylghYibl4uwE23y2LqIBgX8Ms9OCd49simuq5S/N8vcwd3Gx6ld9F5I/OUyKXtqBpBJ5c9vbSyQ4kEb4g8xLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mEIYmXPT; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23CDB44363;
	Thu, 10 Jul 2025 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752128577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rMYNYEgyyY1uHqv+Hw5rr8kPHp4rKI9o5Ur8Ushc1Iw=;
	b=mEIYmXPTYCnmaPRAOJxI4hF1B2VvJ3eC1WZ91Dy0SaRHkLkRNG6vm1zOzkXC+NLJNMwif5
	nvWnZ+sQH6PPjgDpuaIrgwgIiruHmKnI1fiyHhjnENG4nDycVRK/9N8SkEqbs8z/Jv5yFH
	M5bxyQfhnnZ4P+qhzvUTQxe+A4B1BeT56I7uom6Pyi7pVxDHldRxDekZhqAQPEMCLzAYak
	3txuuhnUyh3Tq/6uKKoc+PJDmqP40bc1TRN4227D0osGcYPK6HRoyfQlm1YZx/jenz3/5a
	IIUDewyv3rLTXLhIz1B4CbqKz8sjlaAp1jBvN/g7DRlDNJEkj4498J1MaXRtDA==
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
Subject: [PATCH net-next v3 0/3] netdevsim: add support for PHY devices
Date: Thu, 10 Jul 2025 08:22:44 +0200
Message-ID: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfelieehgfffiefftdffiedvheefteehkedukefgteffteevffeuueejiedtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

Here's a V3 for the netdevsim PHY support. This V3 includes :
 - A fix for a compiling issue with PHYLIB=n
 - An updated KConfig to only allow PHYLIB=y|n
 - Converted the link setting file to a bool debugfs file, relying on
   link state polling

The idea of this series is to allow attaching virtual PHY devices to
netdevsim, so that we can test PHY-related ethtool commands. This can be
extended in the future for phylib testing as well.

V2: https://lore.kernel.org/netdev/20250708115531.111326-1-maxime.chevallier@bootlin.com/
 - Fix building with PHYLIB=m
 - Use shellcheck on the shell scripts

V1: https://lore.kernel.org/netdev/20250702082806.706973-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (3):
  net: netdevsim: Add PHY support in netdevsim
  selftests: ethtool: Drop the unused old_netdevs variable
  selftests: ethtool: Introduce ethernet PHY selftests on netdevsim

 drivers/net/Kconfig                           |   1 +
 drivers/net/netdevsim/Makefile                |   4 +
 drivers/net/netdevsim/dev.c                   |   2 +
 drivers/net/netdevsim/netdev.c                |   8 +
 drivers/net/netdevsim/netdevsim.h             |  25 ++
 drivers/net/netdevsim/phy.c                   | 375 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/config    |   1 +
 .../drivers/net/netdevsim/ethtool-common.sh   |  19 +-
 .../drivers/net/netdevsim/ethtool-phy.sh      |  64 +++
 9 files changed, 496 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/netdevsim/phy.c
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-phy.sh

-- 
2.49.0


