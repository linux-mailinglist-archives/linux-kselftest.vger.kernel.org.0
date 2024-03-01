Return-Path: <linux-kselftest+bounces-5746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D986E6EA
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7AE1C22A48
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE81119F;
	Fri,  1 Mar 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5o9F9wY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10F1171C;
	Fri,  1 Mar 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313106; cv=none; b=pKyVTcyz4PkbhuMjEJkf6T/CNz9eLsD2AqJlWZMvNSptX0VQJv0HEKjhJ4RRSC1pvJBSyljIFOuPyRfeoLkITjYlpZiAMMQp48DFRY74zQ5CnFm7/MrPBvO+P0m+aKRw3XvPgq2YOIWgaXA1wZ4XYrAGNUVhWN/h+Sdwcfcjx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313106; c=relaxed/simple;
	bh=TYMbucVCGX52xP3B1SjEwNL2B5fZQZEvkiPYO/LBu7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FH0ioAwd4TBXm/Fzb/o58nfOPjIBgfdoL93VRoaIL8jtDyYCptYEfZH+p1NJyUlEyLlbt9hAddNLZRreK+pcLRlmMMGh9z7M3ZZmhdD/7HWOyxj85JMVmn2VyulgUtZrmU0W4Gb01FZuasjwAamkkTE3F9tq4fZRDficr4ukXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5o9F9wY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3596C433C7;
	Fri,  1 Mar 2024 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709313105;
	bh=TYMbucVCGX52xP3B1SjEwNL2B5fZQZEvkiPYO/LBu7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B5o9F9wY5gXIPN70vGN2/n2dnlYQs2R2vV3E8tqYWv20i3CygoDyiJU7P845iA7YY
	 Qz7YiZzJG6inUKnHcY//EFgB/7EG4B4+j8AGvqa2am4adW47H5EvatXVdcuDsSS5iE
	 HzHGuf6OGDK+3w1Lg8bB+XMkWttWMRwRZ7y4YO2IRz9ERbDPGBpQ5IU2dmIIR4MAyv
	 +lTxqEK3uGn+sGgnUh/E165Ox5fMQ4ZLwSXmod+8pzAMhrRdmWw59R7GkLRmy97EKk
	 4QwIc+IyphhziYCInMJt6mVgSPw07dHfbhQzbcL+IzcG3SFmKa4iciQvs0shPREXO9
	 dRfKh30qmfqNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 18:11:23 +0100
Subject: [PATCH net 2/2] selftests: mptcp: diag: avoid extra waiting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-2-07cb2fa15c06@kernel.org>
References: <20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-0-07cb2fa15c06@kernel.org>
In-Reply-To: <20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-0-07cb2fa15c06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TYMbucVCGX52xP3B1SjEwNL2B5fZQZEvkiPYO/LBu7A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4gxHXCjU1Jl6jisj/C6HFQNF9VEy9OpMzve5F
 TK0RwpGdDSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIMRwAKCRD2t4JPQmmg
 c8BoD/9of/bA/QyJ/2rwrFsnFNyRrPjWwFrZQKVct6zYWSd0yExoa5R98j7+C2O7PDv7SE/GZXy
 tPxPeY5q9SoWo5UIE4Mb6bzwYsOHi1d8tSeEcofwOWIgNrNm0KeU+sTrd27Mb5GzkEb/YG6Fh4o
 ZAMEKB2ZyRVQoRMDOKH/YJuDtgUNL112cpKMN9jJNK5qEj1ZcJg2VkvOpbahRzkiYSHj0heU1E7
 VifrYE6AnmBdIcM4DWW3+OVSiQt6vzSg8rzvDDKnhJnbuPSlca/uwG7015Tm1cFaO5oMrkUQBGo
 iss9MCHm8vxhIqQKcc+eySBloubvD/bVK/dP0Oyk65NnDzQTIvMgvRah0fmqM/43ONhlLNv9Mvh
 dsv+41HY52lUmo2x1yaE9LJSy9GZC0jypbFinV3fdU3w7PsIqB0UhEf1wWBFi+4E56S13CHeF8F
 9VPWUIdd1sD6SroL/xYSXRlhRlJnepvgCf3SBZ2g3v1s+Uu2JM3FYOP5Sl8V+paBemehPQG/m86
 6Hh8066Zc5Bc+ZNlLYMOA80WXZcYcKT8bcPmG0vHdyzHweQXs6+0cLpM9E1KgKZ9imkZU1RVBvw
 e2FMpYDFN1ycBlkkduOgBTTr5qlhSVO7Aqm9E5UE5b7Vluw3cmHi/i20p+nDZQwGuU9SkSCb1HO
 ZFW3HlW068ufy+g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When creating a lot of listener sockets, it is enough to wait only for
the last one, like we are doing before in diag.sh for other subtests.

If we do a check for each listener sockets, each time listing all
available sockets, it can take a very long time in very slow
environments, at the point we can reach some timeout.

When using the debug kconfig, the waiting time switches from more than
8 sec to 0.1 sec on my side. In slow/busy environments, and with a poll
timeout set to 30 ms, the waiting time could go up to ~100 sec because
the listener socket would timeout and stop, while the script would still
be checking one by one if all sockets are ready. The result is that
after having waited for everything to be ready, all sockets have been
stopped due to a timeout, and it is too late for the script to check how
many there were.

While at it, also removed ss options we don't need: we only need the
filtering options, to count how many listener sockets have been created.
We don't need to ask ss to display internal TCP information, and the
memory if the output is dropped by the 'wc -l' command anyway.

Fixes: b4b51d36bbaa ("selftests: mptcp: explicitly trigger the listener diag code-path")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/r/20240301063754.2ecefecf@kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - The 'Fixes' commit was will be in the future 6.8-rc6, but not marked
   to be backported. Because of that, the stable ML has not been added
   in Cc.
---
 tools/testing/selftests/net/mptcp/diag.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 18d37d4695c1..75fc95675e2d 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -96,8 +96,8 @@ chk_listener_nr()
 	local expected=$1
 	local msg="$2"
 
-	__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp" 0
-	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
+	__chk_nr "ss -nlHMON $ns | wc -l" "$expected" "$msg - mptcp" 0
+	__chk_nr "ss -nlHtON $ns | wc -l" "$expected" "$msg - subflows"
 }
 
 wait_msk_nr()
@@ -304,10 +304,7 @@ for I in $(seq 1 $NR_SERVERS); do
 	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) \
 		-t ${timeout_poll} -l 0.0.0.0 >/dev/null 2>&1 &
 done
-
-for I in $(seq 1 $NR_SERVERS); do
-	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
-done
+mptcp_lib_wait_local_port_listen $ns $((NR_SERVERS + 20001))
 
 chk_listener_nr $NR_SERVERS "many listener sockets"
 

-- 
2.43.0


