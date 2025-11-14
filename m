Return-Path: <linux-kselftest+bounces-45667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EA07FC5ED54
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDC363663E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900AF2DAFDE;
	Fri, 14 Nov 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt9+8bYo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C3347BBA;
	Fri, 14 Nov 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143954; cv=none; b=PNtUtGEqPwS0RglTDr37yc4tiq+HPEXgKMf1iEifAN6cV7rRxOijJ+S6arQctgMW5ZhhG96BYXNs3e30dPLNK7LyLdXEBrwYTT8mfEEfvY68rTKUvNC/GE4N/jpCpebZyb6GQAWv7+K2tyyyPLrM/p9oCUFnOP0AgOK7vSvIfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143954; c=relaxed/simple;
	bh=m+kDsxek/MV31g8PwZ4leaY6woK2369gM187AjK76Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jT2nhtQHzHzZz4FolPycdyp0tL8kUA1BcMwC2AXAHVWMXPM4YC8OdSGfU+N4Nd7O5JsCURuJJVMqrOTBEcz+V5bjrgpt8hBADtBskR1QzkwRhrVt2e2TsEnH8dM1SB5Y4oTq64+RUmRVTGzUn6mHgcSn4r6QXN68ulNAUNCu9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt9+8bYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8530C19421;
	Fri, 14 Nov 2025 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143953;
	bh=m+kDsxek/MV31g8PwZ4leaY6woK2369gM187AjK76Vg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zt9+8bYoYMhpZ/WOHHpYLPchJXO4hObiOgZbmZ52wwPSght1nglmTQqDlBDADVjpX
	 KWVG8SwD4zP5h48tFPVmzMOMaktxIbWc+XpBRwbYnKaiJYwy1zSE73UUkvVYVLNhzm
	 ViHxy4D+oU0X34k3zau8EVRitPU1WAiIqVdbPYNZJxE1g5hakC/ZT+ie+gX9nY+sHh
	 vPB9QdHCK4m9kw/z+Tatg/dtKvxZPR8I/r98S1LVRpg5J80BCIb+ZKjnqPBZaqmrwK
	 7ladNJ2hxeM5KcG1XbM/hS9v0SqjmgcT6G2o40a78ANcm8mB1HSAlRII+blQRDJjLx
	 k2rOYjG6vpY6Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Nov 2025 19:12:08 +0100
Subject: [PATCH net-next 4/8] selftests: mptcp: join: dump stats from
 history
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-4-863cb04e1b7b@kernel.org>
References: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
In-Reply-To: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2233; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m+kDsxek/MV31g8PwZ4leaY6woK2369gM187AjK76Vg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLFC/43Jje6hu0t/rE+7qHUPymRxV++Odksuzz/8CfBO
 B0dp2yejlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkoT2dkeDKz9t/7OKugVA3R
 qQ+rVn89Fr1bYO9k3RmdVe/nrCv+MI/hr/RjaY3DC70THhY0J/AmeZrdq5IX77kc6vZ0Lte5Vkc
 LdgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of errors, dump the stats from history instead of using nstat.

There are multiple advantages to that:

- The same filters from pr_err_stats are used, e.g. the unused 'rate'
  column is not displayed.

- The counters are closer to the ones from when the test stopped.

- While at it, the errors can be better presented: error colours, a
  small indentation to distinguish the different parts, extra new lines.

Even if it should only happen in rare cases -- internal errors, or netns
issues -- if no history is available, 'nstat' is used like before, just
in case.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  6 +++++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index aee215d73b7c..54bac074f184 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1146,12 +1146,20 @@ run_tests()
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
 }
 
+_dump_stats()
+{
+	local ns="${1}"
+	local side="${2}"
+
+	mptcp_lib_print_err "${side} ns stats (${ns2})"
+	mptcp_lib_pr_nstat "${ns}"
+	echo
+}
+
 dump_stats()
 {
-	echo Server ns stats
-	ip netns exec $ns1 nstat -as | grep Tcp
-	echo Client ns stats
-	ip netns exec $ns2 nstat -as | grep Tcp
+	_dump_stats "${ns1}" "Server"
+	_dump_stats "${ns2}" "Client"
 }
 
 chk_csum_nr()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index c5571100f797..fa91eebdbc47 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -110,7 +110,11 @@ mptcp_lib_pr_nstat() {
 	local ns="${1}"
 	local hist="/tmp/${ns}.out"
 
-	cat "${hist}"
+	if [ -f "${hist}" ]; then
+		awk '{ print "  "$0 }' "${hist}"
+	else
+		ip netns exec "${ns}" nstat -as | grep Tcp
+	fi
 }
 
 # $1-2: listener/connector ns ; $3 port

-- 
2.51.0


