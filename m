Return-Path: <linux-kselftest+bounces-46180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA5C7736F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id A5C9628AB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 04:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E182E8DEF;
	Fri, 21 Nov 2025 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8DGPQFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA762E7167;
	Fri, 21 Nov 2025 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697794; cv=none; b=rLvUsRK1q8VK5gSWTRidQV7MAtF+fcZmGTppF5MGl1bjgTXjr9WkVSl5iM6dmJ+9RvTjQ4upPzFIBpqvc4Z+mGQ1t75f967g3Y2dbjrmGxaBgqu8/oXykiVmJQ7fbLezuH+rvTdRixwmt9qm59C3qVbuMns6KISYxnKkUCc3ULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697794; c=relaxed/simple;
	bh=OIfiyBwYUtfJGTSG0QNrPscPDOnlIEUYy4s2kmVs9Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehNgdX+f9RLDSvsiTahcCjiN/dNgF16KaP2hDar2pKkRKmMJVwvqlqX0VKm/YTz6qAKN/vjw/9orGmrBTcAfs3jq7NUh/lhrzab1BXGf+r2qHTSyZZLGk+ogN9txSpR1dEy22eT9C5hzcU4sMjU6OnnmhMsSpeIVqXW9wDNYfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8DGPQFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC7EC19422;
	Fri, 21 Nov 2025 04:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763697792;
	bh=OIfiyBwYUtfJGTSG0QNrPscPDOnlIEUYy4s2kmVs9Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8DGPQFXs8ZE+S2woGZIZyE2a16ySaa+Y4SnLJyCz53JhM8zj4lYpl8GjDtJdCfRq
	 MCQxIFrf1ooWA7b/DiTBE+LKNCj+l5+ULZbyQ+V11UVaJQJx3s75xK3WOBBHo4CJe+
	 1wDU2tKwtlWRT+4CbnVhWvhaT3we0spbdPOv2N3H6xu3KJbUML4M8zOViZVKDu5odU
	 1VnUk5gPtTKZQk+uUqZeGDrY7934Skb28TKCXfnM9HQjsOceVen8vW2Bg7cbZLfW87
	 mtSZ6cJLhhkweTEChpBgE3lVRxr8dIwYm2WOul4A9OE8xnjjVlsN/RUEQJ9xHKPH6Q
	 9+H4SYE07Zorw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	dw@davidwei.uk,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] selftests: hw-net: toeplitz: give the test up to 4 seconds
Date: Thu, 20 Nov 2025 20:02:59 -0800
Message-ID: <20251121040259.3647749-6-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121040259.3647749-1-kuba@kernel.org>
References: <20251121040259.3647749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase the receiver timeout. When running between machines
in different geographic regions the test needs more than
a second to SSH across and send the frames.

The bkg() command that runs the receiver defaults to 5 sec timeout,
so using 4 sec sounds like a reasonable value for the receiver itself.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/toeplitz.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
index 945c58d23310..d2db5ee9e358 100755
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
@@ -166,7 +166,7 @@ ETH_RSS_HASH_TOP = 1
         proto_flag,
         "-d", str(port),
         "-i", cfg.ifname,
-        "-T", "1000",
+        "-T", "4000",
         "-s",
         "-v"
     ]
-- 
2.51.1


