Return-Path: <linux-kselftest+bounces-5378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE3E861D73
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D831C24426
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FB714D432;
	Fri, 23 Feb 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxHxISt9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A7149392;
	Fri, 23 Feb 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719571; cv=none; b=W7Uo8X3V6dbRo7O29QOh9Osfm4yrcGP7XixctPHZiZkVe3/+dZdNPhk/krA6iBxYXImxx0oksNLXyGTe7imF4EtjFmqcxGeiyR4A9aVkLDHeN6ydMm7fIU14pF3IwExjCOaFdD1LIQd2kQjd1a07WUueeOX45CgIzLUTUoIEFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719571; c=relaxed/simple;
	bh=FwvYtTGfOF4NuvGGUI168jKEh9/uz8oP6Cgx5tzsEu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jq7K6ZXRavbPEzFlobcZJiGwAN2h4XUft3K8c5lMdh1mti0tg3hi6KAFtGyHoWUnOxDev6f8aUbhVhtazNXce5D5E9bXK+HeSlKPChPdeVu1PHE+14HXb6pF6D5K0gs5nGNDHtRXsSqpekJJQEBM8aFI8uhBg0ixMxiRF5GYvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxHxISt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8B1C43390;
	Fri, 23 Feb 2024 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719567;
	bh=FwvYtTGfOF4NuvGGUI168jKEh9/uz8oP6Cgx5tzsEu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oxHxISt9+nPVcr3U99R+uDYJC90r0TKLIjZsBOWmFM0aJABvqFYO8xMYZ11VYVoA3
	 5jVP2wgbjFB2xnJU5E63UQAu9AGoEq23JEplKoEtM4i7onlmL+1sSHp8rA7hOvisWd
	 9HwissidoxIUwP+qQBGspUPHVQ2VZQTWJO9N+3gTZSvjBxYf5ID+2Sh4mlwgHXD1bX
	 2kMfRSN9jwIO0/stP12obSwx+6EQWDoH1wx4Xv3wRAymY+xDHy1TkA6vLjl+8tF0+t
	 IeBXy7OFhyPxtU/bRG3VA/cgyTRZ6tLKLJJI52iOoqCHYIT3EwenwJ8sUtlJk3Bg8O
	 wXcC15VjPiNmg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 21:18:00 +0100
Subject: [PATCH net-next 8/8] selftests: mptcp: diag: change timeout_poll
 to 30
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-next-20240223-misc-improvements-v1-8-b6c8a10396bd@kernel.org>
References: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
In-Reply-To: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ldlT+YlgwNS1TOVTH5ihpsJJVG5JuNAuK5gNgkDMv/4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2P2q/16gTXBNVCrsIQuAheU23oKyVW2BEFE2+
 m4sUhGHGvGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdj9qgAKCRD2t4JPQmmg
 c1yFD/9zMyKUhNJCjKZH5FziaSaNxSGl/y01VMLaWVTFKs1VoY3Olwfqj9b0oBKWdJRm3C/3V1n
 b1ACvfpLqPw0PyWZcTotGpZqDaM4idaAfH332C3AQ+dso+SpsR1HiJciG0LWcu31R1dbFrYkgZn
 VluB3ntCvST6AUjTYmaOIr3E4Xg4iEhN8cP+DYg68YdP8qWpE945Ou7MBxJBUO/lSU5jNcMkM1Z
 aUtQyCyokMmFLOI3FsDHmsufHEf8w2XI7uQMkI1YJG8avQQU378J9+DgqCmxFJawTv7IZfXd4/+
 ztH7PunSnYn+IMHXcjGGYkk8SaA1U0dyvWK1SJl97YpGlw5mZJgpGcoEBB6cZwC8eD0OwktL9EH
 h5dJ14uCg09MUb7nDx7VgZeKNINJAm1wDNq4+Z+MRF45mmepljAIskoWkCloLAdjEhd9sYMaWa+
 QSYcBcfO0Bt39I1o+X8jqLdw0t1gE/iu70zz9Gdkc4aH7In7GA9gRskrNL1REAcmNwXbj0cEBjY
 nXx48R9Df/HIOgHet9CoTLCnb0cnfI5B/2wWCHSbO2+FZVjTJaq/Lql4lv1riEl9ZIFCE79ClEg
 2Q2jUojOVNKqwL1gTu90F/mabT5MCs4nTUzrqedW1XcLQu+PFPjxp5/QzEcBAlDacfLD+pLfIGG
 XEQ5a5bGzWooQZw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Even if it is set to 100ms from the beginning with commit
df62f2ec3df6 ("selftests/mptcp: add diag interface tests"), there is
no reason not to have it to 30ms like all the other tests. "diag.sh" is
not supposed to be slower than the other ones.

To maintain consistency with other scripts, this patch changes it to 30.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 0a58ebb8b04c..8573326d326a 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -8,7 +8,7 @@ rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
 test_cnt=1
-timeout_poll=100
+timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
 

-- 
2.43.0


