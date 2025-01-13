Return-Path: <linux-kselftest+bounces-24392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F9A0C056
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC391888244
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968020F089;
	Mon, 13 Jan 2025 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL62NJaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9A20F07B;
	Mon, 13 Jan 2025 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793355; cv=none; b=MrC6mV1NW0Pj0NtNOSWP3Gf4U0UDDAyc7AngE01LNPLo1I+0aG8ZoecK+sQRDrYl+P5YxwrMpPwNeNazkcynRN26bdSNLnSV6uqYcC4MkUutUiDdEb7cI/HZlVVRCJjDQViH/myxspxZbqzMT9UspiaVQsiJIDEekPxJe9Q2RGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793355; c=relaxed/simple;
	bh=XAv+jz/bkNvYNMhL/vqbGq2zVw2DJExlfEMn82bOwbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpbvpnVTr5B+3Oy3iUX9IQsobdw3YeQ5YAuH9qjGAtlHZqkRrFWTCl4AQWwLtAYpSNz/v8rpmaor+GkksGkkHJY7zMqUhJJuGC2xrp/HIquxSgLdblF/7MkVZtoktOIPSbQlP7mWfP8O8wlOXFDXK3Xr45xo7L5Dk+/dENFspiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL62NJaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43D8C4CED6;
	Mon, 13 Jan 2025 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793355;
	bh=XAv+jz/bkNvYNMhL/vqbGq2zVw2DJExlfEMn82bOwbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VL62NJaacxc7y1MuobzGbEzqSGDp1KGlg9BW1WhuB1mBHFkljIZWDKIrnIkoAhg+P
	 9vQnErh093F46z/Rd+Osb70NKZA792+TQiYN+EeWGFRZmIEHRKkmnsoUVi0xDt7wK6
	 KoDyaLEiLN3E5zkJXDFMX+6wL0kaU3U/OKuAWs/+D1XBb52tLpSu2Rw641NfqAIJgr
	 3xAtq7Ew7goKh2KGALGmNuaEL17cCEf7axST4zIOd54199/+OTHskeq7w+5YN60zbd
	 86pzInGooKjn5/Ci4Jg/zuzJjbc2QnPPTKXGd8Dz9DTj4X3EjaDw9IS3c+O22P7wJm
	 HEVTpXB820Emw==
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
Subject: [PATCH AUTOSEL 6.1 07/10] selftests: tc-testing: reduce rshift value
Date: Mon, 13 Jan 2025 13:35:33 -0500
Message-Id: <20250113183537.1784136-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183537.1784136-1-sashal@kernel.org>
References: <20250113183537.1784136-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.124
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


