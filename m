Return-Path: <linux-kselftest+bounces-41099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE87CB50C0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E651883620
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62EE2566F7;
	Wed, 10 Sep 2025 02:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTaVuPXl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA78255F2D;
	Wed, 10 Sep 2025 02:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473112; cv=none; b=dyldBbc82YSGtPCyOe/ZEiYa5l3fDBI5dQoemBqm/uMDgIH/3OzPSL+CrroTkuwE2nwVk+GtLtGlXSTpPcHybR3w9aWtxK8PRuAD37voqXRyYIsyzVrXf/zmC43D37YqEb5l2DKXORCtMLXHuncflNRribsCrjFRr2wVYiDyVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473112; c=relaxed/simple;
	bh=9v7uZS7gt1myo6go2YeC+ttH+6P1aGxTnX6JN1roOBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htWOS5l2FvQ6Nim46cNJVyczkcKlBuR1bZqn9yVh08I/63Ltt+BBLwAtDlsxSAdyUALO1jpDtF/FDWlQkYiJgPZFSBlowXtft8xb35V7UIdpQVlg6+SIia3v0+VS6JhJfvOS2Osecx3mW2QsaohZDdMGHavSKgdQi6JSRGz4wfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTaVuPXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD35C4CEF5;
	Wed, 10 Sep 2025 02:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757473112;
	bh=9v7uZS7gt1myo6go2YeC+ttH+6P1aGxTnX6JN1roOBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTaVuPXlfede/XqhXPfchxPcrxyYvES4yXLnh52sXC8VhMO1LCJidJ3SQQod0Z2Vn
	 YzFy4BSf8EB96Xig1fYuDor3nUra0e9DfzwBQOlVjS0DAU9SjyiTLHJHwcMppLTN7J
	 3xYleY+65GOgx6W5HNDVG/Ht0J0BMBq+PCCz8VQKHeixbI7rBpadJLvRpRJcLxagGA
	 JQkHrjetktAu/LBZeV2UZOxETz5lEKsQWkxIE9TV3amZCI9kwDcfQ0wFGYLkG1XZZi
	 m++sYgn7Ox5LgpCHNYDIAMjq5FFoSrKIuLSY9rSJUf/l0vDy/IBdbm+gQDVt+uS0Io
	 h7CE9nlhsAliQ==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 2/2] selftests: Replace sleep with slowwait
Date: Tue,  9 Sep 2025 20:58:28 -0600
Message-Id: <20250910025828.38900-2-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250910025828.38900-1-dsahern@kernel.org>
References: <20250910025828.38900-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the sleep in kill_procs with slowwait.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/fcnal-test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 068379a79651..a527e3556763 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -189,7 +189,7 @@ show_hint()
 kill_procs()
 {
 	killall nettest ping ping6 >/dev/null 2>&1
-	sleep 1
+	slowwait 2 sh -c 'test -z "$(pgrep '"'^(nettest|ping|ping6)$'"')"'
 }
 
 set_ping_group()
-- 
2.43.0


