Return-Path: <linux-kselftest+bounces-24391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B3A0C036
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A35B1887E7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025C1FDE00;
	Mon, 13 Jan 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me2ER2gp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAB1FCFC5;
	Mon, 13 Jan 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793331; cv=none; b=CjeBlCz5KbQIA2kmOr0gimp7JnceJ4uylGT4tvyERwJdppjIq+5l0ydIJ7soLvmlxrGrvLm7w0AHeukC6Yk/wOJqfzACsjY1agrXVVBA09g1yS3EQh8np/iA6pXj+R7VN+b6Dm7EkmPLltXPJ/kqhtIVZz1fSYpyNl1kq94C6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793331; c=relaxed/simple;
	bh=XAv+jz/bkNvYNMhL/vqbGq2zVw2DJExlfEMn82bOwbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEt0Cj/yQi5HcIAFvoVUvdaVUDj6US2nQURzp95eOM0TEEKOOxuordH6y1dbO17tPuraFEU1TxPyvs8FVkrwI41NgWnAzeKf1qB9O5HEG5LejdfqpYMgGhVDe4TJQfK0xpF2t0obbHFbM1I63gmkv1tyvqSZlwcrYVKZ656Nt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me2ER2gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD73C4CED6;
	Mon, 13 Jan 2025 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793331;
	bh=XAv+jz/bkNvYNMhL/vqbGq2zVw2DJExlfEMn82bOwbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Me2ER2gp8LPCaak9viOU/PB6mmiMyxq6vQvW5dJbTQHEDcDxnCskoj3jJDP+sjJeK
	 FvwxnyZU6/QF+tBq5jwt9UUrRfaz/YqzSZw5MHKI4I5qHpnb6gL9IIHDi7raJS3l8O
	 vp8xISTl7ps3pMuu8GGbUKFJk/ExPA2+Ry76NHAbjWocElyAVyOFZo+tyA0uaO3IGx
	 JjKYdEJnRpShRYlNO+VtYq8szHWBAlYNMJqUmDwH82ZYAuv0+mYaO7yFNvrL6zDzYf
	 XLtLoMb3uAM28Gh0UcV/1SFrdNBx536fg2gTjWrBy/kfys1MiPaHcPJt1hBcISwj9V
	 Fqcg/iQAsXJsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	horms@kernel.org,
	karansanghvi98@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/10] selftests: tc-testing: reduce rshift value
Date: Mon, 13 Jan 2025 13:35:08 -0500
Message-Id: <20250113183511.1783990-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183511.1783990-1-sashal@kernel.org>
References: <20250113183511.1783990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.71
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit e95274dfe86490ec2a5633035c24b2de6722841f ]

After previous change rshift >= 32 is no longer allowed.
Modify the test to use 31, the test doesn't seem to send
any traffic so the exact value shouldn't matter.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250103182458.1213486-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
index 58189327f644..383fbda07245 100644
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
2.39.5


