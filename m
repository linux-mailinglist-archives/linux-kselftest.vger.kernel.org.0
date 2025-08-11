Return-Path: <linux-kselftest+bounces-38727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091DB21903
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E2D461C10
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5AE25C706;
	Mon, 11 Aug 2025 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C90daO90"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B55246BA7;
	Mon, 11 Aug 2025 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954027; cv=none; b=APPZ9VqX/OXcjXnz1vFk/c0APLmgKOqlHjE2GuUvCf+OQ41dNsQq5PClnGWrOgKWdlX/QimD9db5oQ1SRlb+qFf7XNovZ2Z/Ld4I8KbvF8L/f4oX2YHsNo6a5Ro78XkKxwxsfwduVPs4uCpPDT3baeojt/4y14wn1NgP6p646js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954027; c=relaxed/simple;
	bh=uNHAaOXyoXndVesALX9Tee863Rb2PgaN1QbawPUbYlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBDyHua331gezViqTu/5KBWt1OjqX+O1zXu3GP1IpBBGIedp2qUznZqc+r5uoICCkYyQ+A08aYAFFOjJVs1idj+9VSq3DKaentTiSKKOW2Q2XdTTA0r/pXtiJggjfDaGpufGyBbYCbf4VkJshuCPs84TQMumivt4Qxk2J2Pqv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C90daO90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5CDC4CEF8;
	Mon, 11 Aug 2025 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954027;
	bh=uNHAaOXyoXndVesALX9Tee863Rb2PgaN1QbawPUbYlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C90daO90T0R6D0cV8zWqaCu7YdbWyK2W9QtnDLvn6bVolqyoyKQTG1R1nYFAEJ4v/
	 FJ/sI4hQQfgFdRTBBdToS9f2NatFh2RTUfqhJYGjU8eSnmCjFaHSgayVTurq/y6GO2
	 Y5nEOIVOjijqQjcK8jKMkIybby3kWgzAHOQkBy9LiZi3caemomSzCbg+ulJPKmlSb/
	 hh3JvDr6WZZIzc9DusdQBXC+MFSVFkv/NMvNhOB/aZKrjXLsPlNp4onXpH0LCZLdMs
	 h3ekM5Qs2cn8s8/Ngt9zECZ4h740ozmBpgqbkr/TFXaZX2FL0EE+NZg7G3nbeubkI6
	 iVz8GNXrKWCxw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	noren@nvidia.com,
	linux-kselftest@vger.kernel.org,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] selftests: drv-net: devmem: remove sudo from system() calls
Date: Mon, 11 Aug 2025 16:13:31 -0700
Message-ID: <20250811231334.561137-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811231334.561137-1-kuba@kernel.org>
References: <20250811231334.561137-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The general expectations for network HW selftests is that they
will be run as root. sudo doesn't seem to work on NIPA VMs.
While it's probably something solvable in the setup I think we should
remove the sudos. devmem is the only networking test using sudo.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 72f828021f83..be937542b4c0 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -287,10 +287,10 @@ static int reset_flow_steering(void)
 	 * the exit status.
 	 */
 
-	run_command("sudo ethtool -K %s ntuple off >&2", ifname);
-	run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	run_command("ethtool -K %s ntuple off >&2", ifname);
+	run_command("ethtool -K %s ntuple on >&2", ifname);
 	run_command(
-		"sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
+		"ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
 		ifname, ifname);
 	return 0;
 }
@@ -351,12 +351,12 @@ static int configure_headersplit(bool on)
 
 static int configure_rss(void)
 {
-	return run_command("sudo ethtool -X %s equal %d >&2", ifname, start_queue);
+	return run_command("ethtool -X %s equal %d >&2", ifname, start_queue);
 }
 
 static int configure_channels(unsigned int rx, unsigned int tx)
 {
-	return run_command("sudo ethtool -L %s rx %u tx %u", ifname, rx, tx);
+	return run_command("ethtool -L %s rx %u tx %u", ifname, rx, tx);
 }
 
 static int configure_flow_steering(struct sockaddr_in6 *server_sin)
@@ -374,7 +374,7 @@ static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 	}
 
 	/* Try configure 5-tuple */
-	if (run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+	if (run_command("ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
 			   ifname,
 			   type,
 			   client_ip ? "src-ip" : "",
@@ -384,7 +384,7 @@ static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 			   client_ip ? port : "",
 			   port, start_queue))
 		/* If that fails, try configure 3-tuple */
-		if (run_command("sudo ethtool -N %s flow-type %s dst-ip %s dst-port %s queue %d >&2",
+		if (run_command("ethtool -N %s flow-type %s dst-ip %s dst-port %s queue %d >&2",
 				ifname,
 				type,
 				server_addr,
-- 
2.50.1


