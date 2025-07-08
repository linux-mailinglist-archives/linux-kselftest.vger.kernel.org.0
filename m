Return-Path: <linux-kselftest+bounces-36753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33AAFC9DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 13:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF65C7B1AE4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC02D9EDC;
	Tue,  8 Jul 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KqVsQ1qU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD927147B;
	Tue,  8 Jul 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975740; cv=none; b=dv/Ss5RYUgx0FuyPL7IGZa961yMlpEW3tE8EwAr63CN7uP4mRCaCnWDiDGSGHICrdqAy55dhz72Q3Krr2agKzqdKVdDA3N5tC8rJBQJ7lKC118WlW1F0xj0fNS+xyqubTG+UsN0PWU4ndGhU681A/VV/MZvQpAuYLY71NOxS9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975740; c=relaxed/simple;
	bh=QJ5vapLmTwDjB1j1tUYSGL2MCsgyU6s41APy4atZe0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6UGHkbWbx3JNS2Nfg2MCMBnCmm1UES8OQa8FD/y9N646U3xFY+McNRgeLI81fpgBKQuyEkEUr4hxjrXcWXfxhedChSDeeghMMmkPwKmxQE9sxjYYR/TL6unM7FzW1AC9ulmSd27NzWNFg9eheSOpPQtm05T8N8lxw++izyOwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KqVsQ1qU; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5408844219;
	Tue,  8 Jul 2025 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751975736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9CIrCvXDOpGQGZk6c0me8SMZvWb99NRJpQc6tguJY90=;
	b=KqVsQ1qUrMYYVJTmeZ7qpc07HYXZG9m4Rh5b1gT7PGmHK8YdrnZz/Zu8Wi1lMmXB4pqi8T
	ClpDHw83M4wtEYtOvzavoMuFd56HEBE8V+SYI557T2aOCGHGj04vmupk6HzcUdRDAfPutN
	lmzNEHJBSZQnwWdrpbqLbCyus/gLLWYNGJ+CRrZwq0ktbEM+YclWRDIYaejS3zeJGxwoKS
	linkh/GMQep5KojglxrTRP++Tw7uyozGPx1J+8CpAEHmlip1YWT1r7IMM9t2TKnTAby1Hu
	RZGILRcWIW8YkEvvBNg/VUFeBZqdeklwCTDt+mc+lHXIqcUxV8cng6/LXu3j/A==
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
Subject: [PATCH net-next v2 0/3] netdevsim: add support for PHY devices
Date: Tue,  8 Jul 2025 13:55:27 +0200
Message-ID: <20250708115531.111326-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfelieehgfffiefftdffiedvheefteehkedukefgteffteevffeuueejiedtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrjeeirdeivddrudejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrjeeirdeivddrudejuddphhgvlhhopehfvgguohhrrgdrrddpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvl
 hdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

Here's a V2 for the netdevsim PHY support, including a bugfix for
NETDEVSIM=m as well as a round of shellcheck cleanups for
ethtool-phy.sh.

The idea of this series is to allow attaching virtual PHY devices to
netdevsim, so that we can test PHY-related ethtool commands. This can be
extended in the future for phylib testing as well.

V1: https://lore.kernel.org/netdev/20250702082806.706973-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (3):
  net: netdevsim: Add PHY support in netdevsim
  selftests: ethtool: Drop the unused old_netdevs variable
  selftests: ethtool: Introduce ethernet PHY selftests on netdevsim

 drivers/net/netdevsim/Makefile                |   4 +
 drivers/net/netdevsim/dev.c                   |   2 +
 drivers/net/netdevsim/netdev.c                |   8 +
 drivers/net/netdevsim/netdevsim.h             |  25 ++
 drivers/net/netdevsim/phy.c                   | 398 ++++++++++++++++++
 .../selftests/drivers/net/netdevsim/config    |   1 +
 .../drivers/net/netdevsim/ethtool-common.sh   |  19 +-
 .../drivers/net/netdevsim/ethtool-phy.sh      |  64 +++
 8 files changed, 518 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/netdevsim/phy.c
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-phy.sh

-- 
2.49.0


