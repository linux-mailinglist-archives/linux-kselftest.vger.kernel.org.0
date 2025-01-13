Return-Path: <linux-kselftest+bounces-24390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082EA0C007
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EF61888E32
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238901F8EF2;
	Mon, 13 Jan 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWWppquD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75211F8918;
	Mon, 13 Jan 2025 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793294; cv=none; b=WDJ6P5MGFCsdF61X733YT4LOZ7h8Wlm2vYF6ehQhbgtk3EPAC3ue/Jp7miiKy2N5/+QqtvIHI9sf3arh/VremMTwySfFDis3Uw+iofQ9MMX6QJMjTn9qkbaTPlmXCVvFukHYkO/4qK5VBeFcr56at3kc2GEdRrnr9LSlempUXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793294; c=relaxed/simple;
	bh=XAv+jz/bkNvYNMhL/vqbGq2zVw2DJExlfEMn82bOwbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzbFQecHR+ScA1LmkTiwfvC7bgpY7fDUu8G7+aa84kOl156w8Z3lRHDSCJnWvUxD19sUXiVcqsfsEmg5iuH/yXcLkAgXOik6Qs2fcswQ9UUaAIcxC45HrbNJhU4TWK0BftxMlAwd5xE9b10fV/efG6E56k1PqUHAVL712JrClls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWWppquD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E11AC4CED6;
	Mon, 13 Jan 2025 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793293;
	bh=XAv+jz/bkNvYNMhL/vqbGq2zVw2DJExlfEMn82bOwbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWWppquDDGc6ZxsNit/6BzBxgtU/KTpu9LZWlZAfbyZ3Zna3R2rEawk0Wa1gWt/ep
	 1kppom9/SxuPUxeooDiXMwLV6EDEdrmqoD4Yt70LYxBiNaQBTdPqYO1zmv0TgFxxKK
	 aCc909BgGPyOGJK3EwJG7Xgwl0AJVr79LXq9jQDJTLzhYqCAFlaqMpXU0L114oD3VS
	 MFpiahNGzenY+34qvho4hMUcKablfFW+G5yBni5mRQIhCQDGCAQiNTZZq+I0kxgopo
	 ufyWdXnPXEJnsJ4oTgOF3cQeMftfMyTBJrKdUC66fg1tnCmbxDHpZI5PQYbLPK04Py
	 6w/9ci2G0wl5w==
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
Subject: [PATCH AUTOSEL 6.12 12/20] selftests: tc-testing: reduce rshift value
Date: Mon, 13 Jan 2025 13:34:17 -0500
Message-Id: <20250113183425.1783715-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
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


