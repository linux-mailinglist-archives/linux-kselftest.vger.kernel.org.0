Return-Path: <linux-kselftest+bounces-7265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C3D899B4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0585A1C21802
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FB816C86B;
	Fri,  5 Apr 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttm1skQA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B416C865;
	Fri,  5 Apr 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314364; cv=none; b=Ki2NUq/zpvOLYuxGaFTQknYRNKIvuiFppCBTIcMNLOOGmh80BRI5pOPwfsPBUwf/G/dRadJL1wK/Z9gHcafW82eNJgJ1ViNrmDdqNgsRl0of36qKCuBr11yE8S/YErTcFxOJ3M9q/Us6s5fbSnT3pkvSo9iYNB6GoPR++kuRl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314364; c=relaxed/simple;
	bh=WdRiy6HK/oka5IiC6YkmLJw1/RyysTXM95OHJrdHMHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pr6oTlCHsRGS7mwkUsPlv/52oRHtApcqIdyeqVBddchuH9HK6A6tZCeyezRWmowPJjSfXVcPYGPJtwF5JS84jKYNdJT7Cjq4Bnt9exa//bdFUOTWdvVjMo+lxL18pp9TAjXbxu81QNLJx3DfEuIsaYPViXHJtKbPKMFvsffy7tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttm1skQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ABBC43390;
	Fri,  5 Apr 2024 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314363;
	bh=WdRiy6HK/oka5IiC6YkmLJw1/RyysTXM95OHJrdHMHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ttm1skQAhOeN/jOxF3z13kalmZf65wwd8fD23T0kY/2hGIDZdn9RWbW+mlDl8BVB2
	 RDh+16IM5qMRaOqo4kGDvT6fOq55g9Rd+FYOHaYL0yTysoHLytOzzRELcsK/sUkmEN
	 s0suzYg5xru+DAK5W7BUamqBOBdIGO0D11Y8/YqYsdRerBaf//WKUmXjmZkfGeRoVl
	 W/2McxGcJmIDsG2/8uFWPHaWxdwGomNyouwqa+gFVyjUOqdL684h2lRN5OcKY7ZxG8
	 7pwe5LGN/ftOzaJdXkiHO0KZwealT8vO3f3q8WQ7n3FkN2acXY0UUWfudqri9g5Vc/
	 6zb3EaaQ+aIUA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:10 +0200
Subject: [PATCH net-next 06/11] selftests: mptcp: netlink: add
 change_address helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-6-eabc9b960966@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1mO+KsbMEu53NeIIzW9cMyK5QgtJ/nYDKgdCteaDqIc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9flBcijNdTb8U2ePotkbk8EWMG/mdX2wLjCN
 E3MPfzHMp2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5QAKCRD2t4JPQmmg
 c+6QEACHNR6j8Bnqk6AT+Ua14XQ3QHNh+nxNgBPwib5ZUcNUL5e/XPvl2hu7Yl+d9Uh3OlgNpag
 /y9haF+/CG+cna/LD/qYIDlW9kA29VfURIg+2AT2czHx8H8vY/vrNS1qD9KczSN7/hwmZTqZCPI
 Be+5rPFtGl82uiPBTmKN5akOZRTrCIr8sES2Hy6ptcX0Z5PwLIEpYSaDf1Zakgf/O5Bxi5rDPAP
 LH/J9jxO2KN4/TJAfmSPdHsJYofK1jfBSinb/FngvF5spnNbE5b4XEeCMEeVnRyGCppzBaCChCo
 IpQ5dax6rtMuu/n9Z5aty8LOy1qtc0BZbbl+G8gxaUcwyNBoJnnMTM0zFFsc66WL/t7HUc8U31P
 i2WvkkslSqZQfGOcbZvSkGgqoRhy0R3ahdAVFq/tqwIWFTT0fMisJb+XJzbUrf/ArCICg8qY9ih
 A1yb9SFQ6asldYX/w5WICPEG5SRpG82OATkzsOqUFiD5esd0280p0cB4FWDXUIi7Vrs4XQdzzb8
 JYxVhy1RvIkxxRl4/SxQG1YdzWyXptjgMqQG7q8vAW8YsdGUGZDbwy26KNdlw1WkZiLPi2An0cE
 E1kHGWQAu6rFbrF31xwQwiL2lm3g5MWUpAufUT3wQlYjfyKd7BxF7xlzTLeNFUs4B7Y5AgFloKv
 ONxtboAKXPsXe+g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The output formats of 'ip mptcp' commands are much different from that
of 'pm_nl_ctl' commands.

A new 'change_address' helper is added here, to change the flag of an
address. This is a bit similar to mptcp_join.sh's pm_nl_change_endpoint().

Usage:
	Address ID - pm_nl_change_endpoint $ns id $id $flags
	IP address - change_address $ns $addr $flags

Use this new helper in pm_netlink.sh to replace all 'pm_nl_ctl set'
commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 234b88eba0cb..e27a731bd765 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -75,6 +75,17 @@ get_endpoint() {
 	mptcp_lib_pm_nl_get_endpoint "${ns1}" "${@}"
 }
 
+change_address() {
+	local addr=${1}
+	local flags=${2}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns1}" mptcp endpoint change "${addr}" "${flags}"
+	else
+		ip netns exec "${ns1}" ./pm_nl_ctl set "${addr}" flags "${flags}"
+	fi
+}
+
 check()
 {
 	local cmd="$1"
@@ -197,10 +208,10 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
-ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
+change_address 10.0.1.1 backup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow backup")" \
 	"set flags (backup)"
-ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
+change_address 10.0.1.1 nobackup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
 	"          (nobackup)"
 

-- 
2.43.0


