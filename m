Return-Path: <linux-kselftest+bounces-36274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0163AF0DF7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5C51C252C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A1A2376FF;
	Wed,  2 Jul 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GVU33EfS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128382367C1;
	Wed,  2 Jul 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444902; cv=none; b=e37Q3v/nZ9WmJ+Xj37Qgs2keuhdu+dZnU9rjOK3UAqFUMDzDd4Eu1TXo7iQiGlWiEPxGchrTWQoR8OEnfH8Tf14lb/0TaSKIGKxt8qAAhkr1vQKyCLB2nWXXVKy6+OlCPPm0VHKMuf2/cnNybBTatNLpAVGe388ylyhzdChcIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444902; c=relaxed/simple;
	bh=eeEZERa3/2iJm4u3aSUjIaTaiPNsb3U1UCL3FPhQdo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNX3gwYI+/xOc9sHTiE4+JRV2GnyYdiAEHRZGMxDjpIZ+Gx7VUOq3G0M2PbFkt/npqd/M2Hfd0tJyLY5+qk+Z3lN+lULMbEi8WO7gc505iYZeNEEYeVu0S0ODzPkROsCcIqByEXGUmlWCs+z3PQKH4yUmKJv4BSh49/6745zAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GVU33EfS; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D52E4317D;
	Wed,  2 Jul 2025 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751444892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FNuAoTS6vUPheckEZT9dfbDjOtHVQAipKj77l3wol/A=;
	b=GVU33EfSXjJioXi+ASOAbW5/F1x6ER0S5W3d+CYVZ4u1w22nRhuN40Hh47ZWJdGB+KLGaX
	vj+4gHWVeJkabdBC8ydDk9kD2DlWyvvP4YwNs/dtEHqTUQ9QseTlq6t9OGSdQqG5Nn4IVz
	Atpgbuo2d8kuWIJYwSIAnwhS+LtrYaFxIVO1TvWy+sfzsrv+9GaE8Bt9XkMQCd2SR+UAhD
	F5gQhUXus+y/R7GqX4f6/xW8Ark54VS2ykFvqPlF3+r1w/vctoAHR8TkeG5J0CMb8kF9OH
	ZtW24WG68bIwXuy9j8DBE5sS7JgM72ZEvuuco9RQq2KIt5cLTcnuuIHVn41X/A==
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
Subject: [PATCH net-next 0/3] netdevsim: add support for PHY devices
Date: Wed,  2 Jul 2025 10:28:02 +0200
Message-ID: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdehueefuedtkeduleefvdefgfeiudevteevuefhgfffkeekheeuffeuhefhueenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh

There exist numerous ethtool commands that gets their information from
an interface's PHY. This series allows creating virtual PHY devices
attached to netdevsim, so that we can start testing these commands.

This first series adds a minimal support. The PHY that we add are only
capable of saying if the link is up or down, based on a debugfs file.

When accepted, this interface can be extended to allow testing further
commands, and in greater details.

This series also add some selftests for the "ethtool --show-phys"
command. This is a first step towards having better testability for the
ethtool netlink PHY commands, but this could also potentially be a
stepping stone for some basic phylib tests ?

Thanks,

Maxime

Maxime Chevallier (3):
  net: netdevsim: Add PHY support in netdevsim
  selftests: ethtool: Drop the unused old_netdevs variable
  selftests: ethtool: Introduce ethernet PHY selftests on netdevsim

 drivers/net/netdevsim/Makefile                |   4 +
 drivers/net/netdevsim/dev.c                   |   2 +
 drivers/net/netdevsim/netdev.c                |   3 +
 drivers/net/netdevsim/netdevsim.h             |  14 +
 drivers/net/netdevsim/phy.c                   | 387 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/config    |   1 +
 .../drivers/net/netdevsim/ethtool-common.sh   |  19 +-
 .../drivers/net/netdevsim/ethtool-phy.sh      |  64 +++
 8 files changed, 491 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/netdevsim/phy.c
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-phy.sh

-- 
2.49.0


