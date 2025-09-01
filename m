Return-Path: <linux-kselftest+bounces-40420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584EB3DEC2
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169563A71B0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0B30EF7D;
	Mon,  1 Sep 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6RgGr8z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FB30EF7E;
	Mon,  1 Sep 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719610; cv=none; b=EkHv/6REXGvl15MTby2aCgCJANmSysf2LYGpJ6WxsO/IHK7R4VoQ93jjF3FO4/h0cFcprMjST1sZPt6FL/t7kqO+tD/3vJx0QZAjh8Y5YmXJYWRjhk7OHN6MufYigV3Ws7RzG1tvS2UiUPiBDhvzsQ375Sv1z3bg7V0Le1n49Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719610; c=relaxed/simple;
	bh=k+CIqM4/nq+cvAampNpahv2V1eFDkAil5XdpuBPEHm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1v0bbyClRZalFh3kEmiZ6CgMRPaAA6gVM1/RgJtjIyaQMhGTG8gHK2eYYdS9FQFVF41kBJdsnnu6flhvBVOaymXxxQT0oBOhMyS2oVcko2X4/l+EfCQOCJB1jUC5RfZdweNMc6Y4y8qmd9HNa6G2j6IEurP0Dxk9dQlQ9rlQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6RgGr8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46117C4CEF4;
	Mon,  1 Sep 2025 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756719610;
	bh=k+CIqM4/nq+cvAampNpahv2V1eFDkAil5XdpuBPEHm4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t6RgGr8zIwVdGJbste4SsJLTdIYI8Dr0BhQtuSfKAmaiyrjmonfKirJX0N8epjZ+W
	 RhT4bCXMzIHj5ClHBP5jRjKyH10RumqZ0WrH7c9TquiMOhR+uNIl/4NcNmYXu1+He1
	 fOgV0TxbFM3vqc2nALeQUb2YeNQtsOLmaimX92i/eg/92X+qPhJadpd5wsw90W7QCb
	 hTW8A9VpI8wRPVqC3RNEHJpB9dYwhRbR1ghQIKu22h+5m9Hme0S0Ukjaz3l0/uovgc
	 4APPWQ5SkHotc3LMW79exIdeYKjLpC8HKr2CnhBt82XPLSCcP0HrtZzQmaJbgTLOWT
	 J7/2wn/KhsVpg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Sep 2025 11:39:12 +0200
Subject: [PATCH net-next 3/6] selftests: mptcp: remove add_addr_timeout
 settings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-net-next-mptcp-misc-feat-6-18-v1-3-80ae80d2b903@kernel.org>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
In-Reply-To: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1nVFFqCHSNVwfmePtrb2XeOe0x0CCB6YRJAQqv0sIyM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2Zr54GtQi9mjSoiVc5+QeWm2105iyfyfrhHr3is9Tr
 /21LXs5taOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiKXkM/wxFZW4Jz/8UoXid
 9UfDvbuJSVO2tK1ir76xcS9nxic72wMM/xMdiwpXHFH9mMoy6URNYk3DavMDajsefvDo+qXj/G7
 tVWYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Now that add_addr_timeout can be dynamically adjusted, there is no need
to set specific timeout values in the mptcp_join.sh tests. This patch
removes the explicit sysctl settings for net.mptcp.add_addr_timeout
from the test scripts.

The change simplifies the test setup and ensures the tests work with
the default or dynamically adjusted timeout values.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 82cae37d9c2026cc55466636d53a76f929a03452..e85bb62046e020dbacbbd44e1f9e110e1d0104c7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -347,8 +347,6 @@ reset_with_add_addr_timeout()
 		tables="${ip6tables}"
 	fi
 
-	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-
 	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
 			-m tcp --tcp-option 30 \
 			-m bpf --bytecode \
@@ -2183,7 +2181,6 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
 
 		# the peer could possibly miss some addr notification, allow retransmission
-		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 

-- 
2.50.1


