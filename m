Return-Path: <linux-kselftest+bounces-41098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DC0B50C09
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3600188B866
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826F4253F39;
	Wed, 10 Sep 2025 02:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru/yB2ho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5992724DD13;
	Wed, 10 Sep 2025 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473112; cv=none; b=nw4MSoR58YaEv+cMG5dMOMtz5c1XGIRzb+KR7iClIJgYeQMA08TO+4ybT6674+4nUUYOGmUkcHkW9surdcRFlvr94uz7nbT7dQjQB9UIuVuMfjd6z6UU6UqDsw5t1nXvViwFJmwq81qRzgXR5Hcgye+pa3SltmhBy3LoxtRdh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473112; c=relaxed/simple;
	bh=Fj1+SPmCrZ5d9OWSnR3KIszRp+ovuWgPD0GRfdFAt1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tTAeKbKZigYRC8Q0LzbVEEM4OkboJYaxkejSFDSsZCnIxTUjfUbyYcBWtVYjdG/lk04Dy9it2yrA25xU6HIgX2q/h9LeLq/lJNe0IjQ7D3XfkaWVtRy/PAfh6tFL47y1OGli/IMVwLMJRacs8RROC9abvKwo64oKZ2fb2KYg1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru/yB2ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97619C4CEF4;
	Wed, 10 Sep 2025 02:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757473111;
	bh=Fj1+SPmCrZ5d9OWSnR3KIszRp+ovuWgPD0GRfdFAt1g=;
	h=From:To:Cc:Subject:Date:From;
	b=ru/yB2ho6cTaJ+a7EiC6ivKbrbp1G4PjYDkZ6v2L3DGqw/TBnaHWuNrZYmQi4YnnO
	 MlhBOMl2WFocgeZGJzqjK++BEBur6Gc/BEV+BbjtfmMvQ98AkEn1AsX65cHQ4viHsb
	 sZgMKgTyhKLXdFVfxG7gjAJiLTXSk/p8yLJbe2xSmilcx3tqBx6YBzyp1jRr3C7kvC
	 7yfVw42ce36nkv1IUHGadoItBkN1jJepm9BWiG1oxtT0GL3snriKuQoaKhYM/gzzI8
	 hL00zLGDh3c697MYtIN9KhOaWOB1L27jegv9LK+UYDWqIpU4YXxw+dGJWsbfSnjF5u
	 eSVR/Q8+OsAyw==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 1/2] selftests: Disable dad for ipv6 in fcnal-test.sh
Date: Tue,  9 Sep 2025 20:58:27 -0600
Message-Id: <20250910025828.38900-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constrained test environment; duplicate address detection is not needed
and causes races so disable it.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/fcnal-test.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 69941520e8e5..068379a79651 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -424,6 +424,8 @@ create_ns()
 	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
 	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.forwarding=1
 	ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.forwarding=1
+	ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.accept_dad=0
+	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.accept_dad=0
 }
 
 # create veth pair to connect namespaces and apply addresses.
-- 
2.43.0


