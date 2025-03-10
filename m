Return-Path: <linux-kselftest+bounces-28595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A91A59240
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 12:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7366A16B6F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E5226D12;
	Mon, 10 Mar 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEV03034"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D505226D08;
	Mon, 10 Mar 2025 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604915; cv=none; b=NQcyM3RxJg2T4tSJTrcBEriuWW2YmWhbQS1OYZRNWARx+pF2WlXyzI3Y6qEF84Rn9A0Q3uj+JV6dETXe4Wng3c8cULwufIg08/h0mODdi05CXWCXBw7UwPiXHTxUvPSJ/Eo/Y2B4IzL1bW3Zp1prFPHtg6KO5CvN4PqqktjPP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604915; c=relaxed/simple;
	bh=A2ZCjDAI6O3sZex2s/bIzS7B1zXJEc0LS/k3rtBHvOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evw8LYD3tsbR8pAmE/D77lS+A2WQlqtPryyK92VT1jcRlueecov+y+QGY2K97aB3UrQoxaBKunnmHqHerGa3HdLLAwqD9ISswpG8njQ2rZ6MpeId18EVVXk/njPRp5Vrk7mqpRuSAaQJjv4zGV7P7zcRFb5jxtLra3tHkU21YPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEV03034; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36935C4CEE5;
	Mon, 10 Mar 2025 11:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741604913;
	bh=A2ZCjDAI6O3sZex2s/bIzS7B1zXJEc0LS/k3rtBHvOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=WEV03034dfzLu7taFEIyuTV2GZetLjAILlbZc0zggxAi3tFwIwnThR0D11jYc85MF
	 E3Bxp3mKZMwUfamDkiR0GRgDhRDys8ioL/uOcdSim9Kgh+EPdzKqXyKr2gLu6tHjjc
	 1sDCB6dMS6YcwlQg9D/fRJC0uy9gVDKHFO3PM5qCxc8fTcMKzuTiLEEKOtTKjZuwuV
	 ulFZTMdpj1qa7t2NtNuUoZOPiRdbrqAE+uOwaAs892w1t88XAedLgj6HZkCs+ESVkZ
	 9OswdzLFUqVFnA+z8onjU+uEUBjpopjePXL8rieUez/tvSsiTevdBdsVxpnLJqrNUm
	 e/Htdh3KaOM6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	krakauer@google.com,
	willemb@google.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: bump GRO timeout for gro/setup_veth
Date: Mon, 10 Mar 2025 12:08:21 +0100
Message-ID: <20250310110821.385621-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 51bef03e1a71 ("selftests/net: deflake GRO tests") recently
switched to NAPI suspension, and lowered the timeout from 1ms to 100us.
This started causing flakes in netdev-run CI. Let's bump it to 200us.
In a quick test of a debug kernel I see failures with 100us, with 200us
in 5 runs I see 2 completely clean runs and 3 with a single retry
(GRO test will retry up to 5 times).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: krakauer@google.com
CC: willemb@google.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/setup_veth.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/setup_veth.sh
index eb3182066d12..152bf4c65747 100644
--- a/tools/testing/selftests/net/setup_veth.sh
+++ b/tools/testing/selftests/net/setup_veth.sh
@@ -11,7 +11,7 @@ setup_veth_ns() {
 	local -r ns_mac="$4"
 
 	[[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
-	echo 100000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
+	echo 200000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
 	echo 1 > "/sys/class/net/${ns_dev}/napi_defer_hard_irqs"
 	ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
 	ip -netns "${ns_name}" link set dev "${ns_dev}" up
-- 
2.48.1


