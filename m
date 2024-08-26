Return-Path: <linux-kselftest+bounces-16324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD495F784
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 19:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50C31C219D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F31991BF;
	Mon, 26 Aug 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv7ZUg7e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675F1991B9;
	Mon, 26 Aug 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692295; cv=none; b=Nm1TjzO4xIzJjk9SGggwGKUafx9v9XDFEN3lhkRdxCRwYVPrx4f1uokR0nFfPWxK05YPL56MAdrkSYQPcM2vpFOnZ9JABm+WfwxCtvIsOjOTcHh7m09edZ5hvYFCKKYpjFMZk5KrDIXANdGmLoJuBrAsP/eqSZNnOT20TUkeEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692295; c=relaxed/simple;
	bh=jM9ElsHiORy4UPEWXddjuz+CPs1GjQevojAyK+2aOA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/OrnWMFxyFSAS4t2A4dqigfzM5tOo+KgoN1smNQi0EDrSpTc8ao6IuOzceXaqZHmdAnfbPiQIX6FXFRqNyxH8q8um336EwHIGoICscSjU2E6v1VOpCuASx0MhRoqfDro0/orGBv73LxgswqtVQYkG9x8WKAScVU5lHyjl3KYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv7ZUg7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433D0C5E887;
	Mon, 26 Aug 2024 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692295;
	bh=jM9ElsHiORy4UPEWXddjuz+CPs1GjQevojAyK+2aOA4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lv7ZUg7eh+ag07GQBKxnIJWmAYS9UrukdhCx46AV5z+wVC/1YNNy/ne/yXl8+oOB9
	 DdNoh2jSdUPF0/hrftwsBokHEKefluIcr1NBugV4aWXw+0tf+HkHXxsq3mjILRJWXJ
	 2R2axHTnuzsx2l7F2PRYQsKlhtIMoYNCvwXI8KLyHgNDwgBm/On8vZbP0z2+9UiClp
	 oIEIrSTpUVg8xePFJoU7ALQJVpLSvzOd49GxgtH0iWeSasEMFCWsCNjIxYJg6zMtHx
	 KC7My+WDKcGGnVUkiZWYypuiWFoX8w1ZmnNjgIPaC/eOXC9Fbztv6urguhTauwKLK4
	 pHiFGgv/UW08g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 19:11:19 +0200
Subject: [PATCH net 2/4] selftests: mptcp: join: cannot rm sf if closed
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-close-extra-sf-fin-v1-2-905199fe1172@kernel.org>
References: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
In-Reply-To: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3315; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jM9ElsHiORy4UPEWXddjuz+CPs1GjQevojAyK+2aOA4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzLc9F7awKeAmslyzxTPhiypDGkK58rFVdMVFT
 vwwm3doq6WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsy3PQAKCRD2t4JPQmmg
 c0ypD/9XXjlgmIXuw0Ga5bZiH/QSbPv+s67sBTRXfNEFpZn4XuBHVAmNOHMUQlERDmds7766o9O
 fAdvtbMEvBWVR5TveVGAodEXuvAqAKK8vrsWeC45fA9XcY/Ze7GbZ682EKJd/PfJxcQteUPDJ8A
 vNZ68hKIO5whpdjiriW62iuWCqFOyIockgpqOmSdHnIm0F0Bfh1KlpZT2hP85mhnoPT5p+/X2h/
 wjGCiYkIL++EVqg1ly3/u1VB6pGb7ChejdVIvQy2mANJCicH3faIbCYdPzAMawjKXwS1PktCKlx
 oEuy5Mvx70244ePN2X1+i7GpdpmYRdR2Bamamj+0zGO23+ZMIRNERU9qOdbextsRmhpBhy/NYA5
 yjrMbQrSRLs/JFsgQfQDFz48OkNrgAEXud1mK7pLTGyCuoJGfM2x8Envprqs8BacvgO2o2hmdJ2
 J9ItOIYalwE9/Y7DBmSyBkfT6F2MyHHFi7Venw0Y3CtfYV5RgVZ+dKcCGcJcZU/2OAp3UC2x8Lx
 rmYOx9/YCEl/f6YhjoIEi20TYu5Q8recCpmtJ7GHCchI5KzLPBgyqU3O6Q2KPXzeYYBYZ5COti4
 Gu4RaBoXWTlIvevv6WcoDWEyy1krxmZaHjV5mH/R7c4cOc/u1qcWK6lACR+6OlSyhRReX5d0mzr
 aoDTr6ItvcyYewQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Thanks to the previous commit, the MPTCP subflows are now closed on both
directions even when only the MPTCP path-manager of one peer asks for
their closure.

In the two tests modified here -- "userspace pm add & remove address"
and "userspace pm create destroy subflow" -- one peer is controlled by
the userspace PM, and the other one by the in-kernel PM. When the
userspace PM sends a RM_ADDR notification, the in-kernel PM will
automatically react by closing all subflows using this address. Now,
thanks to the previous commit, the subflows are properly closed on both
directions, the userspace PM can then no longer closes the same
subflows if they are already closed. Before, it was OK to do that,
because the subflows were still half-opened, still OK to send a RM_ADDR.

In other words, thanks to the previous commit closing the subflows, an
error will be returned to the userspace if it tries to close a subflow
that has already been closed. So no need to run this command, which mean
that the linked counters will then not be incremented.

These tests are then no longer sending both a RM_ADDR, then closing the
linked subflow just after. The test with the userspace PM on the server
side is now removing one subflow linked to one address, then sending
a RM_ADDR for another address. The test with the userspace PM on the
client side is now only removing the subflow that was previously
created.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 89e553e0e0c2..264040a760c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3429,14 +3429,12 @@ userspace_tests()
 			"signal"
 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
-		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
-			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
+			"id 20 flags signal 10.0.3.1" "after rm_sf 10"
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_rm_sf $ns1 10.0.3.1 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
-		chk_rm_nr 2 2 invert
+		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
@@ -3460,12 +3458,11 @@ userspace_tests()
 			"id 20 flags subflow 10.0.3.2" \
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
-		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
-			"after rm_addr 20"
-		chk_rm_nr 1 1
+			"after rm_sf 20"
+		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids

-- 
2.45.2


