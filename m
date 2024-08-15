Return-Path: <linux-kselftest+bounces-15457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D573953CAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249F4B24AE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C385154456;
	Thu, 15 Aug 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu5Mr9pG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FBD1514C8;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757570; cv=none; b=TDSWKjfqSgaeDJ+HVvWLbHZAra5pKqelnrUFq3ItqmSCnOxtyjSq+ygqtEEiCotCa6TjbH7+Ukd1ZIidEKfwdwFmdP7udJysiLy9u1f6+VLvIRV9dD0Kx1SIKm51UTpetZhB+ncI86wn2gXVqpYkGYbECjIeB6yfpErgyZoezOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757570; c=relaxed/simple;
	bh=56N8sGkm21/5XN+HI2rbD0qLudKPGcHI1AKwbNBcfEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOn5lX08UAg5Hk+Yd6s6a044vQXL0kCn2gj6SndKNOLFP9RSC2QIaD3dqcQt7UfbBa9fBtxRe4p08yEdVnd+TkPptEqnakJQ0DvLQU0CjbLEdJypI1Jlpi2yVr8Hnv2CeLo+w3aNqiulqP4RQ6wvATWzcXxBA/ZjFLczWi7CqrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu5Mr9pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91B06C4AF16;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723757569;
	bh=56N8sGkm21/5XN+HI2rbD0qLudKPGcHI1AKwbNBcfEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gu5Mr9pGEG3RdLiFq+bZT8b7yq2pxLjKCwqKx12SnT67hjMpPodnjrTNS5xxoAp49
	 ZyWVAR1PqRV+WixlbR2Wcy1B+JavcXAYf1hiiIPboK4Xy9aCua9GhMhwsHOO9pPQGy
	 YY+RQgzdGAO1gYNUZlSTuARPLJxbMAp9sKquaSYDgE80Mr3lGqHRUG3X+ty4CZtXV1
	 atsVQY2pD+Bu+WZL4eOXAmPMMYNNXfI2m9F/+MkhGi+/vrPzuqtYgZlWpkB6+GJ66F
	 oFurKsLdaDaqRULbz8PA7brVB+Em3/VaAlpyjHf1H+rU/xWVu9YXsM5QpQC74+lVMo
	 OY2EE7c4p58Xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF3CC531DF;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 15 Aug 2024 22:32:29 +0100
Subject: [PATCH net-next v3 4/8] selftests/net: Open /proc/thread-self in
 open_netns()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-tcp-ao-selftests-upd-6-12-v3-4-7bd2e22bb81c@gmail.com>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
In-Reply-To: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723757567; l=1616;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=5VWqPUDjhIp9H1w5UjOr5S/0zah4a8/9NW+/5Oa3bag=;
 b=PNecNbQ9DKJVRb9aqAil9a/cpWXD5e9KfEajkTKHB4is0KOH7FiIlEwpipH+FvN7UCFjfc85Q
 v2PdMGbxCqMDZ3JVh5KSy9IsUWOMcaeOQcgDeuroJazZWq71jJ7ehs2
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

It turns to be that open_netns() is called rarely from the child-thread
and more often from parent-thread. Yet, on initialization of kconfig
checks, either of threads may reach kconfig_lock mutex first.
VRF-related checks do create a temprary ksft-check VRF in
an unshare()'d namespace and than setns() back to the original.
As original was opened from "/proc/self/ns/net", it's valid for
thread-leader (parent), but it's invalid for the child, resulting
in the following failure on tests that check has_vrfs() support:
> # ok 54 TCP-AO required on socket + TCP-MD5 key: prefailed as expected: Key was rejected by service
> # not ok 55 # error 381[unsigned-md5.c:24] Failed to add a VRF: -17
> # not ok 56 # error 383[unsigned-md5.c:33] Failed to add a route to VRF: -22: Key was rejected by service
> not ok 1 selftests: net/tcp_ao: unsigned-md5_ipv6 # exit=1

Use "/proc/thread-self/ns/net" which is valid for any thread.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index e408b9243b2c..d5212ffe9489 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -111,7 +111,7 @@ static void sig_int(int signo)
 
 int open_netns(void)
 {
-	const char *netns_path = "/proc/self/ns/net";
+	const char *netns_path = "/proc/thread-self/ns/net";
 	int fd;
 
 	fd = open(netns_path, O_RDONLY);

-- 
2.42.2



