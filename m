Return-Path: <linux-kselftest+bounces-23882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6980CA00D98
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A805F18848CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACDC1E9B01;
	Fri,  3 Jan 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF0rd6R7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B3BE4F;
	Fri,  3 Jan 2025 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735928732; cv=none; b=n74MyvkjbbtGeAs2pilpY3z1VFt93aKyfmsjxutwu0s4iBhew5eXYqEWZEz+k6byVUDuDPAnsbJCYnfLu5OkVvudD5LeNTs0tI4HDUwufjUg9xpeo4wErc3cC2m3Gtu0B6qPW3mbUIJ0p7HkgnKCQpYRKPBDr/DHAddcJVQ4CSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735928732; c=relaxed/simple;
	bh=+PHZHw3/c/2u1a+6hdiiQo5uhHfhWbkTZF64FWt5BlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYux+GXxoDHlGpR1Wa8vKSy4iysnoYoMvFzWVRjujeAcVNv2aEwaS/gm6d6Pyg/MS4VUmy3akq+IHE5YHZUn7SUBro5Ozez9z+jdAZSl+mimFjUK2pVhmXXagDI2LRVmd/U/jYKUMKeqHaZHQVozOXX9/leccvobB+FTw+ixXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF0rd6R7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56859C4CECE;
	Fri,  3 Jan 2025 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735928731;
	bh=+PHZHw3/c/2u1a+6hdiiQo5uhHfhWbkTZF64FWt5BlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kF0rd6R7co2V+t+3EJh7+myH3mHG53NqReBCeT6Bt0sQLQ9XllFJ60Z9pPmM51zVT
	 JBasfJdtNaANoVvYOCd40zQ69asiyDMmthgDfyylqSAA64/Lu8fdPHxAGPTHc11NGO
	 5G5Nn+T7jcSH1FyXSt4G0v97JnlzRJBGAb14st55spsVumYuoSyM1xIxvG2GmS3vOr
	 /TNlEbhxmH7lF1Nrdjo1NveHS3rsXJ8HWw82nMGhF0lMoQmdmZ5OWXW+Z/3VS4fjdO
	 AWCtVop+zUkPkcdFxhE1DflzDCN0XBZH287Do1eId+Mrw3gMO1DDfp/W5OjNoVsT4W
	 FU8jl8im28/0g==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	karansanghvi98@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: tc-testing: reduce rshift value
Date: Fri,  3 Jan 2025 10:24:58 -0800
Message-ID: <20250103182458.1213486-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103104546.3714168-1-edumazet@google.com>
References: <20250103104546.3714168-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After previous change rshift >= 32 is no longer allowed.
Modify the test to use 31, the test doesn't seem to send
any traffic so the exact value shouldn't matter.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
CC: shuah@kernel.org
CC: karansanghvi98@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
index 996448afe31b..91d120548bf5 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
@@ -78,10 +78,10 @@
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
-        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 protocol ip flow map key dst rshift 0xff",
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 protocol ip flow map key dst rshift 0x1f",
         "expExitCode": "0",
         "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 protocol ip prio 1 flow",
-        "matchPattern": "filter parent ffff: protocol ip pref 1 flow chain [0-9]+ handle 0x1 map keys dst rshift 255 baseclass",
+        "matchPattern": "filter parent ffff: protocol ip pref 1 flow chain [0-9]+ handle 0x1 map keys dst rshift 31 baseclass",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
-- 
2.47.1


