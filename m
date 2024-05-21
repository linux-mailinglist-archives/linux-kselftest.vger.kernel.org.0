Return-Path: <linux-kselftest+bounces-10468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403AB8CAA57
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 10:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A271C20283
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFEC4CDE0;
	Tue, 21 May 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/A7fRtY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA238DC3;
	Tue, 21 May 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281392; cv=none; b=FFuD1wqeKIRKidG0BA//KPEkFw0Hzryxz52Lg/Iwog5DEDOzsKx5XGO8mT0LTw4XtoYodBBbtZblCTC1RmtkBg8/XBGm6SxW+bMGaMahj36Yt2jYu3ZSNTd2r1FTuKkTs8rAvQ/XYpaDvRaRqB0OsXAIqOGjm6BaW3Skk0QCcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281392; c=relaxed/simple;
	bh=SFvM+4CQg9OhmwXJvfL6GQph7spU6XveHyFkL8ajJ4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqWd68DH6lHvb9+YUCRLb0Szx/Ifh3oAI4E7SJSsvi3lqgN4Hp/djF7KElQ+DooX+0Et1QP35mp/cX/FZp+/jSHzuQRj3p1Ny/ffbGRh3+x5uUlUPvbHgAZgjLUe727HBpQQYdfjVhbL0UMUfdEZS8kilDDqg0wnxgGkte9n/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/A7fRtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95187C2BD11;
	Tue, 21 May 2024 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716281391;
	bh=SFvM+4CQg9OhmwXJvfL6GQph7spU6XveHyFkL8ajJ4o=;
	h=From:To:Cc:Subject:Date:From;
	b=i/A7fRtYMOtCaMpoCusvfKBxz5VsHDxuwqfTjgYWkNdy2AfBqNJUxVntD60dRm8fG
	 ySmEAyQMa5Js+1NkqHmasOf6BLrZbsvrnAhS4CEOpKKNdcwl1so8/O4kzf1DiwMA0a
	 rIu+3pmmuFd4WcAVFQvZxtodvFE6mv/Q6IaezmONpUYu/xKLsDsjV5OmWPpxh9SCtt
	 GZEAiB4iC9RJyflQpQn6ur3Fwrbb/4DfoW83oZXMwvkkjgiJ35wJGQR07mwmfz2sqf
	 tspG4Uf6jHGIKOqmYtzlNat027pczO0fLPkqZywKmJp45J/CmTOfHFmA9tl+GTfKYW
	 aiaR+4ULJJlEg==
From: Geliang Tang <geliang@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: hsr: Fix "File exists" errors for hsr_ping
Date: Tue, 21 May 2024 16:49:44 +0800
Message-ID: <db256340b909f8b6f8bb7f9e42dbe71c228993b6.1716280848.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The hsr_ping test reports the following errors:

 INFO: preparing interfaces for HSRv0.
 INFO: Initial validation ping.
 INFO: Longer ping test.
 INFO: Cutting one link.
 INFO: Delay the link and drop a few packages.
 INFO: All good.
 INFO: preparing interfaces for HSRv1.
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 Error: ipv4: Address already assigned.
 Error: ipv6: address already assigned.
 Error: ipv4: Address already assigned.
 Error: ipv6: address already assigned.
 Error: ipv4: Address already assigned.
 Error: ipv6: address already assigned.
 INFO: Initial validation ping.

That is because the cleanup code for the 2nd round test before
"setup_hsr_interfaces 1" is removed incorrectly in commit 680fda4f6714
("test: hsr: Remove script code already implemented in lib.sh").

This patch fixes it by adding a new helper delete_hsr_interfaces() to
delete all interfaces before "setup_hsr_interfaces 1".

Fixes: 680fda4f6714 ("test: hsr: Remove script code already implemented in lib.sh")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/hsr/hsr_ping.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index 790294c8af83..0be1d5f78dab 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -166,6 +166,14 @@ setup_hsr_interfaces()
 	ip -net "$ns3" link set hsr3 up
 }
 
+delete_hsr_interfaces()
+{
+	echo "INFO: delete interfaces."
+	ip -net "$ns1" link del ns1eth1
+	ip -net "$ns1" link del ns1eth2
+	ip -net "$ns3" link del ns3eth2
+}
+
 check_prerequisites
 setup_ns ns1 ns2 ns3
 
@@ -174,6 +182,8 @@ trap cleanup_all_ns EXIT
 setup_hsr_interfaces 0
 do_complete_ping_test
 
+delete_hsr_interfaces
+
 setup_hsr_interfaces 1
 do_complete_ping_test
 
-- 
2.43.0


