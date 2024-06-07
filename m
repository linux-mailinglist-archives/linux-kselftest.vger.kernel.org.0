Return-Path: <linux-kselftest+bounces-11419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74495900A7E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D275282F1D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95D819FA75;
	Fri,  7 Jun 2024 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXap2/9+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9319FA6D;
	Fri,  7 Jun 2024 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777889; cv=none; b=kiz+QmExXEO/4jNV9D4H0txG9QbQVHn3QUTpeGrRlSFJmqjQQHHObsnYwhXog2PO+/ntCTAW/WtecjL55AnLAEVA7ERT5jnusbXEG5XaqCeMR3wpXsMdceb0oSRa3kDrZOEdWojgDcqI5JbUFvz/CETyKCN4hqWN49OQzzbUPwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777889; c=relaxed/simple;
	bh=sw4QEfs+KCb/A6DQwxdbwqcDsSwr0+kHnEmigoHWK0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ursgohw5/UFNU4gger3sfymtdfgCkmOpvvX8a8rjnE+l0pO2MmNcYPoqPnCwlPStiE5aO3SI60wRNjMLsXQSa/0mmjnB8RaTAqg29hHAR9QurvovkguXVeGqle8MyCqUaG4QRutlDmBmJoUZDKP6udNOP0hcCoUw7HacDVrbjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXap2/9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A12C3277B;
	Fri,  7 Jun 2024 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717777889;
	bh=sw4QEfs+KCb/A6DQwxdbwqcDsSwr0+kHnEmigoHWK0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XXap2/9+6Mgpz4rsZQiP4U3wn9Ji3aZAbetmDgQHwODsMvA7Y9O21h5mktPaQngyd
	 UdyoHfg5yWkJkOF3lWOPeYvhcF+OqsOpigsoN7mUtWH5TolhHMAEIhGXgdehL+LqZN
	 09te+3ANUEuxvv1OYueodVhHsX4HXBxbB30PQDERyesS7P5LyDTqsm1jjBAQFJUAdp
	 qqzxY4skgM47VijjOL6t6NO9nLRLOT3nDoTHIcDaXwZM0msD/yRCfjyb+9Rfb1i3pF
	 swrIbFbOdZw+UtYZwLABYzUQ/i3jZDiWT7xMCwHp6jK9G5kArRj+eTAywjodhgReKQ
	 wYTS2TSvAGpSA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 18:31:06 +0200
Subject: [PATCH net-next 5/6] selftests: mptcp: lib: use setup/cleanup_ns
 helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-5-e36986faac94@kernel.org>
References: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
In-Reply-To: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NgawBoCahqER20tDcfL15sESUXbmBfp0LJKw9SYNUQU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYzXPcU79zATimLx8e8BE3yaqIrwbD4vU/8c0u
 QxmVuccgmmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmM1zwAKCRD2t4JPQmmg
 c+XhD/44k2j3T/a7mrWv6mIOlgf/w6xvhret4faFIeRyGsODmr2o//NqM1j18Vx2Nq0CtA8tsNu
 +BK4ukFQagb4+X2vZ3/1agDb03/P+L5Qoqv0Zz7Cu9ZREd+/Kl7PoHIQhRF8JnmRZ4tR3WxP9oJ
 QWuZC9WmYqxPEgzKjTNkR7f6qVYOZ/MK2MJzCQIDyZ/KCPBb6xsgGY6zjvs1uTFEzk9pn4dURty
 EYiq6jANo8GhDWnpc7ijg8TLygOTnjg9e7aXM+KNArxmf07Kr4sFtgApqceS9x/hOfF9PDw/TGy
 XfJ8884DaKSt02N7kLy5Y7cwTIRg4QfrHW1o0QBe0BOvVj7ktUAOSHo+ZZ+ms+ikYeRV1ZNLrCW
 5Ys2/ZOsH2SKdSFn4ijcPF0fQAlgo9HFbh0lwUMBEuhVdeM1hyCaDkqb1x2P2FiEDGVjxcADpgD
 Z8agqDzVvrRaKzx7hARrpuZYBhCiorj0l7hu1N/+OlII6TTV6TE421K7hMTcc07lEeY9s79E9GD
 ZxnpkdAdv30k9iW9l06LFR/kAMscyqMTBP0IuXw1i52eo+La1IWRgLX2YGApfzTsDO1nMz0yorW
 s7yPPdr2w5mb2yfAuuQiRl/RpCpW75u1Hy75MIxCXuxiT9WHUJbtiuupVKfsiq1oAn3IHn8MRYw
 FyYbxId/f9bCTgA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes lib.sh into mptcp_lib.sh, uses setup_ns helper
defined in lib.sh to set up namespaces in mptcp_lib_ns_init(), and
uses cleanup_ns to delete namespaces in mptcp_lib_ns_exit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 6ffa9b7a3260..d9e30516dc72 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -1,6 +1,8 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/../lib.sh"
+
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
@@ -438,17 +440,13 @@ mptcp_lib_check_tools() {
 }
 
 mptcp_lib_ns_init() {
-	local sec rndh
-
-	sec=$(date +%s)
-	rndh=$(printf %x "${sec}")-$(mktemp -u XXXXXX)
+	if ! setup_ns ${@}; then
+		mptcp_lib_pr_fail "Failed to setup namespace ${@}"
+		exit ${KSFT_FAIL}
+	fi
 
 	local netns
 	for netns in "${@}"; do
-		eval "${netns}=${netns}-${rndh}"
-
-		ip netns add "${!netns}" || exit ${KSFT_SKIP}
-		ip -net "${!netns}" link set lo up
 		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
 		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
@@ -456,9 +454,10 @@ mptcp_lib_ns_init() {
 }
 
 mptcp_lib_ns_exit() {
+	cleanup_ns "${@}"
+
 	local netns
 	for netns in "${@}"; do
-		ip netns del "${netns}"
 		rm -f /tmp/"${netns}".{nstat,out}
 	done
 }

-- 
2.43.0


