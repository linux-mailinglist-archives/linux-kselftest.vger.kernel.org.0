Return-Path: <linux-kselftest+bounces-20253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FEC9A62CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D0EB24E59
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E281E8831;
	Mon, 21 Oct 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuUI21m5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB51E882A;
	Mon, 21 Oct 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506345; cv=none; b=EoCSTsqGViAt4DchKRAUPNndBbLX88ts2gtZalbgtZwAMlR8E6SDmeFHJ44AdDtWHXKVydZcfhLrtJnqcYpMQY5YviUOHPH19nOzanx9nzwVXci2MuGoP1TJE166C+DyL7TEwzuxTrEA+ReiGajRqKoo3u9yZZRDyE1U3Ij1QNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506345; c=relaxed/simple;
	bh=+ERGzFcGqAZgfpbsL0KQxvrUj31An94qTY+Z0b8vfJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYkuieVHThfpRld6vF58uXgfy13wUNblYMCqd4Qp1Or+/KmM6JLQzYwD5sU7pGs7wMZiRWclveuu2z8ZJJbTT0vUc9T0vTgxYaiLDhavfAdEnqxxB+lBwm0sV2R4n+wS1766faZW41Vdo34o35jJfVeIudTzy4AwFG/5Nw1of2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuUI21m5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E47FC4CEC7;
	Mon, 21 Oct 2024 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729506345;
	bh=+ERGzFcGqAZgfpbsL0KQxvrUj31An94qTY+Z0b8vfJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GuUI21m5a/yWsJac7sD8+kBDPJD+CYdpshVHwDOoQmqMTdhTZcqeTowmsDw31oV/B
	 zYB0qkvfSuxYO0DJN1sbVSU3LxfiaNSD3/58AD6xU/bZArXbP8uBOoqQpybIkwpb45
	 F2ZLicxg14s6sFrlMKX/09gD+JyfDaiyBJskdS4CWxY91IYwBrZMZHh36YI8DoV0Fw
	 SFfo9p0r5x0AY98Rtfy/LPa/T6L0sgxn6WRzjPYHawIF9bJ28FQI68bo9QC4w5FGOw
	 4+rTXidRzu36GcjBo15xIFDeKgECBEI8EIXvbLUOdoKOFOC1a6/K1cPDoxEtH9Z8M6
	 CtM1IX2Sm/S4w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 21 Oct 2024 12:25:28 +0200
Subject: [PATCH net 3/3] selftests: mptcp: list sysctl data
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-net-mptcp-sched-lock-v1-3-637759cf061c@kernel.org>
References: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
In-Reply-To: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+ERGzFcGqAZgfpbsL0KQxvrUj31An94qTY+Z0b8vfJE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnFiwbvNXfL/mAHMg+fJSIDrYNm4eLaGOM+emu6
 lHDnwXbmcyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxYsGwAKCRD2t4JPQmmg
 cwcFEADGP6qT9NnBcsX7XErC6uFJ6mZYSJOf1cgpzwCKy1+pIkPwVv4A/z+/8IoP83XUZj4CzRo
 gOra1Vb70O4crfXA8fd1QvwGQlLahPifZw9WIHUk+Dxs22Hrg+NXIyx2J+ti/TQjcVKd0o6mQMT
 V8AD3V+lS9C7qs9M1lJZeTbXMvEXJC7P/AH30tjkH0EnTbp806TzstqXL5eesKBszIMj+A8M35Y
 ZBIE+YyFTojrzx+gpEIvwKgn+DY6NDa5RxecDqh/NWsuthy9QvOeP3yr//ZFfsovn2Bo2r/X+Ji
 AIyz/lv9XeghxVTObyfyMjikmHZtgF+ZSbuLQxswLifKQBS6PFulx9nqyglBzbz8ePsK7OmL/Gr
 UYEROMVZBya7lLQNnjvQhhcPlDIWFO48CzTH/Rw4JkeM2DZQ+eKLNcgJSDl8/bl0UEgnIn7lzfa
 S1A6CNuYRk91XEGwcCqlpno8B50uSa6uopLTxvSWP0nb1hZ9kawg/Dki4sIY63Y9o0jWQKubv6P
 ye5DB2nZAnja8HrFAcFvwuHjAAvxtvowoBYVR/9OHHp7omS540iN4UdLC552yg9qb6+k3f4DEre
 055G7F9NeT1w2RqaxsYKlWxY0tRJ5tesSv+0raeauOe6qelK+p8DggGqLj+AzyyBR6FVpn/1qjv
 IhOOm5oXpG1jJ7A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Listing all the values linked to the MPTCP sysctl knobs was not
exercised in MPTCP test suite.

Let's do that to avoid any regressions, but also to have a kernel with a
debug kconfig verifying more assumptions. For the moment, we are not
interested by the output, only to avoid crashes and warnings.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 57325d57e4c6e3653019db2de09620d692143683..b48b4e56826a9cfdb3501242b707ae2ebe29b220 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -259,6 +259,15 @@ check_mptcp_disabled()
 	mptcp_lib_ns_init disabled_ns
 
 	print_larger_title "New MPTCP socket can be blocked via sysctl"
+
+	# mainly to cover more code
+	if ! ip netns exec ${disabled_ns} sysctl net.mptcp >/dev/null; then
+		mptcp_lib_pr_fail "not able to list net.mptcp sysctl knobs"
+		mptcp_lib_result_fail "not able to list net.mptcp sysctl knobs"
+		ret=${KSFT_FAIL}
+		return 1
+	fi
+
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
 		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"

-- 
2.45.2


