Return-Path: <linux-kselftest+bounces-29019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9B7A60BD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 09:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5247617F2AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586571A3165;
	Fri, 14 Mar 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpscJe9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBD288DA;
	Fri, 14 Mar 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941373; cv=none; b=cqht3RQt+u+q6CEGx5ZMeIySDtai/UWVpWdHV2Klkc1FUyWy/KdweEkoJS1UeeFVGe1PuGOmvqx7hyA0V42vwtV7i2Vu2wY5x4rUzZ6H8NEtd7SznNX6ake5DYcBj6eQWqC+N/7/g9JeilPhDYuIGvC578st5toZ0HqBzpTx9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941373; c=relaxed/simple;
	bh=0XELGK3NlJpfm2jYvbE8iTtmJ7oQJYjOFPHBv93++5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tCS8ZVkq1YKsHRqCK0s4TyAg3gf7QuFgduaZA1dL5y2ibKPv4yhT2SxxnTkV3sAfw92hFNnuhsaXDR+cvLwKdTibUmW8rktJ7HYtNVCxC4U+KQCHrJ7T5EbyTj/ZmZpXRd/wEMKqED2OZjtBbthWa7rn+Sk3bc9jLzIsHcRUCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpscJe9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D2BC4CEE5;
	Fri, 14 Mar 2025 08:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741941372;
	bh=0XELGK3NlJpfm2jYvbE8iTtmJ7oQJYjOFPHBv93++5Y=;
	h=From:Date:Subject:To:Cc:From;
	b=gpscJe9qItz3bc/oGOZyAicdMAFrxZQWc5rBxTOeuv24EKCvjOTOOF+5KD11S/yGV
	 lNdIqbtk4vsfncabF/obhHt2Dj2oz/sCFn3jsjDiZdytDfsVwKBIH2U6EJX0vBTwDM
	 VDvCJ/U62up9CuI6vBH4g8CYqAQpBOSmTBsaqFFIoG89QmwKnzFnEQqH1JF05M0HoD
	 a5sLs2Ugp/2mQvnpdgmmZhXJHVytfGk5f14Ad7rcTml6Wjm2M9QoJPQjcDUkfCJxUU
	 P6DHngkJcwNB/VXX0yr4+Ms9XODY2mCs9405pTfohz/LIIruMQAn0PInANTPEvBb5Y
	 khMV9YlJwIlKQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Mar 2025 09:35:51 +0100
Subject: [PATCH net-next] selftests: drv-net: fix merge conflicts
 resolution
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGbq02cC/zWNSQqAMAxFryJZG7CO4FXEhdqoWVglFSkU724ou
 PiLx58ieBImD30WQehhz6dTMHkGyz65jZCtMpRF2RSVqdHRrQo3WnkSXOw2XDngQaLxudJY262
 WTAu6cgmpmR4G+Mswvu8HA8CvyXsAAAA=
X-Change-ID: 20250314-net-next-drv-net-ping-fix-merge-b303167fde16
To: mptcp@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0XELGK3NlJpfm2jYvbE8iTtmJ7oQJYjOFPHBv93++5Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0+p3gxFMBZfYI6UpmoWmrPP9IfoxmGSO3gC0U
 wLb2Eki1tKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9PqdwAKCRD2t4JPQmmg
 c+CeD/9eFz1NROsTVTXuf1WLbGaRlr+d+pdn2adbNA6sbNnsDjAhv0WEI/cXDqUWN5tqjqESA1X
 dPoEKeUZG1wzs/TKs9k6wNTw9wCwQKlxIxxyAVhzoVuzym3HATtVU8I6E/9VUhyyoo71jCGJUPC
 6A8qXlPAfxIgWwvmGLnCU2jXxRsvWwEpylIUze7SUxV2eF/YEzPJHxx5wjbBGhkELq6sW0Qg6rF
 zt6Z5mBSRlnlYBIzg+FGZNKdTxJKkzRQZjUPWlFvk2eVrq1EKl22N57H/W1EaNc4tpYOWJtnRuh
 B1droVB5X5IlTYqORQ6/DlAbGsPWRKIZXw0+HvoCnnO525ThYLqO8yH9itOthk0xb+HiBBha+uR
 B6IUjiGIafrESoOJRYkr91b3HAdKAyZd05J9Cm+PigDslX063P7xCufgx8c/bI9sqPbpAv4PZ38
 5TN0zCxQbZjkDeUTNXn9ipwANBi6jupRjpgPjGb9UYnRy7+1Rpqo9xYG499C1QBUENQ5cKw00Hk
 w7yMljIidF9cN05CBe01Ur/LWpJHwxt8lFf8eN7RvETYjYN8XkjFaJUMvEFbl/q1uvdGxRFk/iK
 PZfNGUIHizQku81l1rvqLOVgaOLVgN9GsiEpKmIAQvW+QzIXEoR8CDcWjebG02z49y18TIo/ktb
 meKgneP7ZINrsjg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the recent merge between net-next and net, I got some conflicts on
my side because the merge resolution was different from Stephen's one
[1] I applied on my side in the MPTCP tree.

It looks like the code that is now in net-next is using the old way to
retrieve the local and remote addresses. This patch is now using the new
way, like what was in Stephen's email [1].

Also, in get_interface_info(), there were no conflicts in this area,
because that was new code from 'net', but a small adaptation was needed
there as well to get the remote address.

Fixes: 941defcea7e1 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
Link: https://lore.kernel.org/20250311115758.17a1d414@canb.auug.org.au [1]
Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/drivers/net/ping.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 7a1026a073681d159202015fc6945e91368863fe..79f07e0510ecc14d3bc2716e14f49f9381bb919f 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -15,18 +15,18 @@ no_sleep=False
 def _test_v4(cfg) -> None:
     cfg.require_ipver("4")
 
-    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
-    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
-    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v4}")
-    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
+    cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"])
+    cmd("ping -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
+    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["4"])
+    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
 
 def _test_v6(cfg) -> None:
     cfg.require_ipver("6")
 
-    cmd(f"ping -c 1 -W5 {cfg.remote_v6}")
-    cmd(f"ping -c 1 -W5 {cfg.v6}", host=cfg.remote)
-    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v6}")
-    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
+    cmd("ping -c 1 -W5 " + cfg.remote_addr_v["6"])
+    cmd("ping -c 1 -W5 " + cfg.addr_v["6"], host=cfg.remote)
+    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["6"])
+    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["6"], host=cfg.remote)
 
 def _test_tcp(cfg) -> None:
     cfg.require_cmd("socat", remote=True)
@@ -120,7 +120,7 @@ def get_interface_info(cfg) -> None:
     global remote_ifname
     global no_sleep
 
-    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_v4} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
+    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_addr_v['4']} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
     remote_ifname = remote_info.rstrip('\n')
     if remote_ifname == "":
         raise KsftFailEx('Can not get remote interface')

---
base-commit: 941defcea7e11ad7ff8f0d4856716dd637d757dd
change-id: 20250314-net-next-drv-net-ping-fix-merge-b303167fde16

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


