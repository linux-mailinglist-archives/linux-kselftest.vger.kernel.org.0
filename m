Return-Path: <linux-kselftest+bounces-21002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16179B52AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC7E1C20CE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCCC207205;
	Tue, 29 Oct 2024 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1IoY8A9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B73206979;
	Tue, 29 Oct 2024 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229967; cv=none; b=fnjccD9N8DtBRW90oYCRY0wdrukRdGhcFkSIbxDciENlNVkJ+9IxfzD5givNb3aBdJXoiqDuplA3y8m3WJcsTHKM90TtsUmNTkvAuHa0Cl/6NYrbfnT4rUwAOcqTV2RuYQ47Zi7uHH0WZzyDmYePqbLcKbpoGvNyLwk2WGo8kUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229967; c=relaxed/simple;
	bh=VaTfy9+C9a5BkZ6K1uie8eRF1jHcBxU7DQ97+KQlLFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRKcQUuoEBqB4cmWaC3u64M2wIlugnrPJH/DfxwKtlwZcyZl+dUO1RZ4jXKz7B88eJME3RaWTCQnA3AZLc0F1pRoSuy2UfXdsbc5JFd/K2c9Pla6PexbKoxzVqCHi6mbzxsthF4UNEctZB+dCUUH54ROC+WDUG7SutIt0KMIa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1IoY8A9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72D5C4CECD;
	Tue, 29 Oct 2024 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730229967;
	bh=VaTfy9+C9a5BkZ6K1uie8eRF1jHcBxU7DQ97+KQlLFc=;
	h=From:To:Cc:Subject:Date:From;
	b=P1IoY8A93Jy9Y2bjp7mn/JWT+8IZvX+fWCmYjU1yolnJRCBikT1fSJyY4WgTNU1gC
	 yelqHGdL/ddfbN4zbrK+wFaCsAFl12XD0p8w8WJh8NXHSPu+Mi/StlDp8HzhxB0bJO
	 OR9lklWK3m9DwGznOh+dczWVE2r32FGBuzflaSQBQrOSUgNPMj71X9pfNYnBOF31S0
	 bj+yF7COus4MdksCCKDaLz3GLitmMDwxeLHUZjgJ5WQSB8Tiq0CJdh0Id88Ntagav0
	 /iFd6WftZsRapp4T2QrSqrtyXhoM2Jgh3Vk7X/q8pzje0D5ilcOWg6nU/3znkbKFX9
	 EXbe9A7FG65QQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com
Subject: [PATCH net-next] selftests: netdevsim: add fib_notifications to Makefile
Date: Tue, 29 Oct 2024 12:26:03 -0700
Message-ID: <20241029192603.509295-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 19d36d2971e6 ("selftests: netdevsim: Add fib_notifications test")
added the test but didn't include it in the Makefile.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew+netdev@lunn.ch
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
CC: petrm@nvidia.com
---
 tools/testing/selftests/drivers/net/netdevsim/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index 5bace0b7fb57..cc08b220323f 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS = devlink.sh \
 	ethtool-pause.sh \
 	ethtool-ring.sh \
 	fib.sh \
+	fib_notifications.sh \
 	hw_stats_l3.sh \
 	nexthop.sh \
 	peer.sh \
-- 
2.47.0


