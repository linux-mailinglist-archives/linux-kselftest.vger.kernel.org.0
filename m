Return-Path: <linux-kselftest+bounces-14828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1CC94884E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 06:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C07E1C22055
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7B015ADA6;
	Tue,  6 Aug 2024 04:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdBaojYI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512164A8F;
	Tue,  6 Aug 2024 04:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722918052; cv=none; b=FpBSO68jPRyLzDELDwcT35fo/tPXVa4lm5bDStuYZY+HmbUdB9HVNcqS0EZrxNKOHbNh1YXiPpMFM7c5APjW0pWUoR86Dm4Lp7cEXtYZ3vcK7Bk+4hT0CNe4PhTQyqMbSVOlsm0T9x/MnY794/ZDWXHRvr8oLXq02vA8/Ks2Hvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722918052; c=relaxed/simple;
	bh=649dI+6k39/ZeqTlqJv33Bt0T5RIfetUkcckWynydNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHJyRZ/ScC1UPZRT5Vyn5QEFwcTQUQE9aR0EFf9RbNiIkLQERdaRRidPVM0kFh4pp33BpFH+5HRKyK7KQc9oMOqg8+H1VXXceJOx7V8Q830Ad142g5uyFgosLBam4dvUBCNibRfJ76xJ4OOty0f0C9wbJQiyhrZ8QF+JfIVUCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdBaojYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62CBC32786;
	Tue,  6 Aug 2024 04:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722918052;
	bh=649dI+6k39/ZeqTlqJv33Bt0T5RIfetUkcckWynydNs=;
	h=From:To:Cc:Subject:Date:From;
	b=hdBaojYIvEIuw96Gl9nbay7xzSuw0+rdpVcIec2yo+PvLM8z01/WQ30zkU348R/mT
	 xD9pudLe5kIwBdpBQyDGLuJK0dULXYLWrwJ1tjGYQz9YGXjGsgrZnWvq0TL73r8D3o
	 nGAzMX6B5uAnlxdRANLw91QuFPcksr3mqQUVBaGdYP8ICv/i8eda+6rQqmFn6Qirje
	 1P5q+E+sleir2oDy12V9ilzvev4dQgxox5Th/8AmQhNspUxvbFHDOIdW4zY4G1W2/O
	 Ff0vNC3bx1HYH5uVD1XAeAUnvNfss/ApOGGCxZ7EbwXh++zHmkcbY5SnC18Vtr4bvg
	 Z6U68CyrYWgtg==
From: Geliang Tang <geliang@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: forwarding: lib.sh: ignore "Address not found"
Date: Tue,  6 Aug 2024 12:20:38 +0800
Message-ID: <764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

So many "Address not found" messages occur at the end of forwarding tests
when using "ip address del" command for an invalid address:

TEST: FDB limits interacting with FDB type local                    [ OK ]
Error: ipv4: Address not found.

... ...
TEST: IGMPv3 S,G port entry automatic add to a *,G port             [ OK ]
Error: ipv4: Address not found.
Error: ipv6: address not found.

... ...
TEST: Isolated port flooding                                        [ OK ]
Error: ipv4: Address not found.
Error: ipv6: address not found.

... ...
TEST: Externally learned FDB entry - ageing & roaming               [ OK ]
Error: ipv4: Address not found.
Error: ipv6: address not found.

This patch gnores these messages and redirects them to /dev/null in
__addr_add_del().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/forwarding/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index ff96bb7535ff..8670b6053cde 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -839,7 +839,7 @@ __addr_add_del()
 	array=("${@}")
 
 	for addrstr in "${array[@]}"; do
-		ip address $add_del $addrstr dev $if_name
+		ip address $add_del $addrstr dev $if_name &> /dev/null
 	done
 }
 
-- 
2.43.0


