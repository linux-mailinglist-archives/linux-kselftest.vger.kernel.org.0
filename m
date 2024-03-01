Return-Path: <linux-kselftest+bounces-5765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51986E84D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCAC1C24703
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD270CDC;
	Fri,  1 Mar 2024 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhKTFL77"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32645374DE;
	Fri,  1 Mar 2024 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317158; cv=none; b=QNwSy7AQwxxhfSBNnlSCvL8Dk7QYMpAq05kToTVyL770+2aabMRTidlk9gqqIDfNphRxpvo9/5VRHsUF1f1NmqAdUO6pou2pHqq0Ztko/AvgdPSmKXo1ueLad9e7i7xGw4K206ylHIGyyV/5o6u6+bBX/oe7C9tOEIos4G6OeYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317158; c=relaxed/simple;
	bh=+pDePtaqyPSYmYXRLXh31mTRlvMwA70fqaLVjgNNISs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FhKU35j+aAuUAYfTHmFErUOkOb6SHgV9Pd2fjf3RJFJTTrrhqzo9PyDJ835d9MKLWSaL/I7YriBVJu2sAiLE9zU5TIcEaLhCL7XA9gQuowj2XjcL1azrTL/h6l7qKfcAd/nledeXOOoU3IY9/0Gag+Ex5GCjMZKjHl2dbwsk5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhKTFL77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BECC433C7;
	Fri,  1 Mar 2024 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317157;
	bh=+pDePtaqyPSYmYXRLXh31mTRlvMwA70fqaLVjgNNISs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PhKTFL779Bn7mIEWdDk7sEaRkvo6OREWcxIY63SSo13+70eq/KbXwUTYrAm7d/3bZ
	 wZoAisdFmhBdAh11LbJ8gU9jQ7QQtj/7p3X37FPli9gNewWBl+dUlYqgnFDMD7lz/I
	 yAEF3Fsbwmx12RdKjDaTxyy/8nh4CuAIj/Vi7zOEjgy3a8IS+SdYAtIEAgv4m20327
	 0+69ubs/sPazslCEYQhoU5e3SgAqFz053rxCnFaCc8YflhjGP3pS6n9QT7vPexR3uz
	 RNOnx0JFNeMwF6W38uv9ePg4zgVkUHzBPhzNA9nCuARKvvy4QEtSZAZEQx7/cBGsll
	 gKfBQYq25w5cw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:39 +0100
Subject: [PATCH net-next 15/15] selftests: mptcp: userspace pm get addr
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-15-dc30a420b3a0@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2462; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Uhj+aOKv+ybe2ZbgME5KF3r9u5aVSPj73T6p8b8Xs1A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv19aV6XjWIlYJ/0F0CCJ+Ls1W4mwW7X7/wn
 3yn/7sEK3OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9QAKCRD2t4JPQmmg
 c6mfEADTCCxrJQVDiE19OVgNtcbK8ZWAtF87D0kxuaE4RUDo4GlCx71csx2vxwdr9mAPEHfSXqC
 Z+aVSPLohzdJZHBDVUd7UE/znABjQJTvx/pCy9o6vTmOTQb5Cewx+0xehXHZsISmo6am9PszHNG
 Xbf18CyEGUPvi/s23gF5P+UUkokSAd5bORywT/akRMI26RRNKDRQ++BMBPypJzwE5e/vYvZLLlx
 aqEfihKFIZIH80evCHeE4Df5LEAU1P2Qx5KjB+f6GACFVR9VXnljGOL/UEYCVnjdSeVB4sROiD2
 x5s2Kh9k1IyvniN8ZuUiXjXrAx+wWF8dpPJQvGBuhjnWZc12I3G2XOABuULefrFwIGJMP13lX5u
 jTQCH9Gw6jYH35JrlDpSMlJGuBxFAmEIQAcB/HxLXG4xJpoPveHMghGGrCNQ3v/5icGNsB0x5pA
 gelkkthBgvQJWAzDxcI29rh734dpjemDgm8oE77z4ug5G53iDJr7rVfRVl4kmZ3dxE1qAxJ4ehi
 3JIgoN9RP1kJS9nwldJ8nc9hiB2eOm5Y5bH1pg0PRETkxvdRItvoHUFXYJfC9xWOlr6C3tO/z13
 I75W+WAcjddkSxDHoTt8kglGLgO5whSBNiERmWkAGfAtv+5EnhtUoKm+6b6RNttMTvVfQb75bxp
 XDuyts/BjE9tHQA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_get_addr() in mptcp_join.sh.
In it, parse the token value from the output of 'pm_nl_ctl events', then
pass it to pm_nl_ctl get_addr command. Use this helper in userspace pm
dump tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8b6430642706..955ee651dcd5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3388,6 +3388,18 @@ userspace_pm_dump()
 	ip netns exec $1 ./pm_nl_ctl dump token $tk
 }
 
+# $1: ns ; $2: id
+userspace_pm_get_addr()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
+}
+
 userspace_pm_chk_dump_addr()
 {
 	local ns="${1}"
@@ -3403,6 +3415,21 @@ userspace_pm_chk_dump_addr()
 	fi
 }
 
+userspace_pm_chk_get_addr()
+{
+	local ns="${1}"
+	local id="${2}"
+	local exp="${3}"
+
+	print_check "get id ${id} addr"
+
+	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
+		check_output "userspace_pm_get_addr ${ns} ${id}" "${exp}"
+	else
+		print_skip
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3497,6 +3524,8 @@ userspace_tests()
 		userspace_pm_chk_dump_addr "${ns1}" \
 			$'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' \
 			"signal"
+		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
+		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
@@ -3527,6 +3556,7 @@ userspace_tests()
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"id 20 flags subflow 10.0.3.2" \
 			"subflow"
+		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \

-- 
2.43.0


