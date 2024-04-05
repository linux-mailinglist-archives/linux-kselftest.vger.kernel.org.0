Return-Path: <linux-kselftest+bounces-7263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8982899B47
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D9CB22443
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117916C6A6;
	Fri,  5 Apr 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGEifxHA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496116C45E;
	Fri,  5 Apr 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314357; cv=none; b=lObTDz195LKNcYP1nNpUlqPhaSxjBCvSvwBrM1FmeX8XPSScNVIApSlltZGTkOX6mLrdUfRG4JtHqTuZqS3LSLzYph5c/gIs9q1hLamsRGslSY4fC3sZEicN9mM3zDR9sWpnMI4MVuQonmItbGXafNT3w6YGlaLrd6H+YxkfpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314357; c=relaxed/simple;
	bh=Zhj1r18k/1WzNQKbSHVFV4+dDFsQJw97dLrKAuCxQcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kU/vBFGeivSsgXurcH7mFfTFJj7beZsduyKON2Dajqljsy4QLGxE0cPcEoeXxJzxOVHuPSf9Aj2xbjwIKu3kMI+h0nx89frIEc+LyivsfX+Wnuxt5YUJIq0EVWvL3qh6ZiEDQBau6VGM4VUXBRrCxyyak5+kE2RXYkjigvnsee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGEifxHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3BFC433B2;
	Fri,  5 Apr 2024 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314357;
	bh=Zhj1r18k/1WzNQKbSHVFV4+dDFsQJw97dLrKAuCxQcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uGEifxHAYho7zC9y/rSr7+4zoVmHXnX7rUk76uoXWHw6+84TAVe+LnIMK1/IheiLK
	 GqGYPWucYOoWzXrnoq/FTnzntJ3AmPXIDQANolJkWvjOWtqNVDKGqKJd5hiC9VybH+
	 3fma8HSPZccOOFsF8dSzeiqnoRvTSaW6JM5uTQoSQqvvOjVzGyeEkLmbP9r8r6NIMf
	 Rl6JwgSzLaWZzUSeCo8ES80HFEN7DyH7HGHn2+4RL+YK0uJfnbSlBcV3zmYfDCHz0T
	 wIkrMB3vvK1kjZ/COjk1NxrmaCHczex7Qfm6pcVxcvLGxw2Ed2k2xWcl/1ncoiRzno
	 YC/5gOeLnIxGw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:08 +0200
Subject: [PATCH net-next 04/11] selftests: mptcp: netlink: add 'limits'
 helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-4-eabc9b960966@kernel.org>
References: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nUEW5uyiDGyAzCFYUDGHkGAM2g15fOz/0B8Lus/cn9E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9flyRr6mFf4wYKjXoutK7x6Byc1bA7LVkW2l
 ONdB/+Za8+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5QAKCRD2t4JPQmmg
 c+/oD/wNMZPAmNxVpI3SinaFWs8k25NUfxPYtTTpZN8gqnHP78AEDSttskqz0fmtAZKJD8siXRA
 7H4u0dFlr1f3jk20AozTSbcIa6Ju6jz4SNY0e1QPUSrw75GVuEf6PRYCcYnjYB3lRgwS/Kb4vG1
 qGnFIPwW88s/i7hwfjeYmNFA6LcrpBUadOv/DsgMeYnS2XMuBqsQPic05UFTtcUJFvcjdxfWSVH
 mfbJHAVAgFr9tiQ0WDl6BovHLGi6td2nNChzoIak1jkZ5YkhtXVjh9bWvJAREdDos2GmuwB6mwV
 0uLJ66gB37xU05ay+BitKirzI20zQKipaTlt/0iCuYG6U5q5NiKHZugV1LON7KolF/TDYBaAd2I
 oqP2vU2OrB+u0o0IJQj+hxNp0w86xYwOkCXrLtR5LcHJNkcVZnMAmZTqVtT5DxHndTBzUDF+6pH
 tcbDjpHKWwdwWy6oaQCU2PUHpjOMZHQ1bsN5fKORrvtNMf27hBgSY3pbtuXOifCllY9ZtWM2KmA
 /gOvWx/e+3c71Liin9SW/iwxNzDhkPSbz37W9EFVSGWB3D+a3BT+fPH8l7qSEjwOHhqruQjF2dP
 wmPxSyJcTcfmDP1l0NfxmyvqckfA3CaQ4JH/+pl78tUzdQs9ucad9/sgN3pfpAF4kuBs5Xf2gpv
 5S4TgBS6a3si4OA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The output format of 'ip mptcp limits' command is much different from
that of 'pm_nl_ctl limits' command.

This patch adds format_limits() helper to format the outputs of these
two commands to hide the difference. get_limits() has been added to show
the limits.

Use these two helpers in pm_netlink.sh to replace all 'pm_nl_ctl limits'
commands and outputs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 32 +++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 6ab8c5d36340..d672d1e5d470 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -46,6 +46,26 @@ trap cleanup EXIT
 
 mptcp_lib_ns_init ns1
 
+format_limits() {
+	local accept="${1}"
+	local subflows="${2}"
+
+	if mptcp_lib_is_ip_mptcp; then
+		# with a space at the end
+		printf "add_addr_accepted %d subflows %d \n" "${accept}" "${subflows}"
+	else
+		printf "accept %d\nsubflows %d\n" "${accept}" "${subflows}"
+	fi
+}
+
+get_limits() {
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns1}" mptcp limits
+	else
+		ip netns exec "${ns1}" ./pm_nl_ctl limits
+	fi
+}
+
 check()
 {
 	local cmd="$1"
@@ -69,10 +89,9 @@ check()
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 
-default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+default_limits="$(get_limits)"
 if mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "defaults limits"
+	check "get_limits" "$(format_limits 0 2)" "defaults limits"
 fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
@@ -120,14 +139,13 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
+check "get_limits" "${default_limits}" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
+check "get_limits" "${default_limits}" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
-subflows 8" "set limits"
+check "get_limits" "$(format_limits 8 8)" "set limits"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1

-- 
2.43.0


