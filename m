Return-Path: <linux-kselftest+bounces-11415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F86900A6E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9715A1F2117F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBA419B5B0;
	Fri,  7 Jun 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZeJOwBn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB619B5A1;
	Fri,  7 Jun 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777878; cv=none; b=MhgSCXg9aSE3XkiwX+A5mLOu6VSqn0wcijGLC/4RxbpfjFm+Db8h7eL3WKXWylJSIkuAZqvlq77kqM750S0+AdzCTVugAfs0PFkx0wwX9PaKFFyQ04YWj0JHQX1wwYjzKDYgqojvFSjrReKOyg1GVH1XdAnSJ2iJ3XmX2OZTp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777878; c=relaxed/simple;
	bh=fYt4PaaC7RD7kCNYM/oIuTd6c2zrPeCtLWUrgb6Sp+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=guTM443aty7A/jtQz294uWsKG9lR4KBsWrksZgjkkyM9V132p/6yE2DbHglfbBDx8n3vHpqrNqHLGBLnUffe9DqRlIWmWcrbDiNY3/APgyoQMHGPRXMXTkMpMJCJqC0/9MwF5AgWrK7dmUFfxKRpqqdFrFS2pc0ia/UKpLWNZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZeJOwBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECD2C32786;
	Fri,  7 Jun 2024 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717777877;
	bh=fYt4PaaC7RD7kCNYM/oIuTd6c2zrPeCtLWUrgb6Sp+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NZeJOwBnq9zEi4m8mJltGqaxIoLEWvUblXilotDN9VEJfkIpoB6tEzsI3naIeUc+c
	 8MU2pDz6npKH4aMyrb4QIceX0Typm+GUSFYfd4PQ9ziUQAwEGQzr5LTO3wpRt8qgA0
	 KL5P+lJjN7FC4BC1sWkJSmzKaRqdpXf5SQST/wu6Bp70HRbVwd93xYy0fHzCoy1Bf5
	 SQShnaybj1814IwDfOhhuTctAE3oRBflstZBkc2jbepBQbAS5NwGdmtKawdpjFGuv9
	 HWeWSelwsou99pR3PIumQ22qrqTj3A0DP7HyhCfHWV6VGdXQl6nH4pirwm3G18zTD7
	 3ga8FbflmH2MQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 18:31:02 +0200
Subject: [PATCH net-next 1/6] selftests: net: lib: ignore possible errors
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-1-e36986faac94@kernel.org>
References: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
In-Reply-To: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fYt4PaaC7RD7kCNYM/oIuTd6c2zrPeCtLWUrgb6Sp+Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYzXP4whqHAe8UikCsoFniIMddqS3mBG3zRfPh
 Nd796vYCEGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmM1zwAKCRD2t4JPQmmg
 c4XbEACZ/DkVHJ1xmqNVx8QUpeZX8p8Ekv7RWcll48q8DiyMGuCra1qj+grt5urv3UdudUc7OWV
 KIheHt8qEiQBkKY5+ulcObRpKcwVcXsE6OkhmPUNNHz60DrXLW3/XaKqnKCWHv2PZSQgWY8wxEb
 9XmgMby/VfKUIVgsrGiXyH3+opVa8j6il4wA+73EAW9u6RaY0TJHb7oRPvO1AghpZZrcC58qnil
 4inqeX91s9cXYdk0+fVvO++TMXeaD73H/Bj3uEt7Be1yXoi1lCzdL2lMD4UChQtwphe2GesZPd4
 n79JtyQqyBmPWDJP6Frb0sKc0mwldTTw1tNaq/kmY4xnJyLV5FnRHhhSTddWj2rnf1Ps76eJuks
 y+ldr9yJj+a80I1h+2MpNsW7Rn1Cu8ueCcovULccdnldOeyG+RK3jTaUmGvGsMTV87GnV8XMgu6
 5hWcNqgLPh7hbKr69UjcAo+1NqzE0TwccCEvgZpWjwirGchx7Oevg5XUcoGwnFc03WIBEymCGbJ
 K7gj3K0TmxJpAMWQhmlvkrF6GXktTN0KUmWbpjIXvYtP+5b3Q0KUJl0nfsqEd6LwfQC9kJ5r/+1
 2jGZtzaml70V40DtHKgoYMnGLicq7XuwdT2T4uSJ8fnCjXkKcsgbHalx4YNjlyikaatLSmT1k0/
 amfNEKFPa+ZoaXQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to disable errexit temporary, simply ignore the only possible
and not handled error.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 9155c914c064..b2572aff6286 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -128,25 +128,17 @@ slowwait_for_counter()
 cleanup_ns()
 {
 	local ns=""
-	local errexit=0
 	local ret=0
 
-	# disable errexit temporary
-	if [[ $- =~ "e" ]]; then
-		errexit=1
-		set +e
-	fi
-
 	for ns in "$@"; do
 		[ -z "${ns}" ] && continue
-		ip netns delete "${ns}" &> /dev/null
+		ip netns delete "${ns}" &> /dev/null || true
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"
 			ret=1
 		fi
 	done
 
-	[ $errexit -eq 1 ] && set -e
 	return $ret
 }
 

-- 
2.43.0


