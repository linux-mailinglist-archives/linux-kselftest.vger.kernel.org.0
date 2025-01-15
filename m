Return-Path: <linux-kselftest+bounces-24608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB006A12F0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 00:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B61885409
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1B1DD863;
	Wed, 15 Jan 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWZRY9Uk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6A24A7CC;
	Wed, 15 Jan 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983295; cv=none; b=ZLnu++vmzwOwvpxwdSHVpSpNKloD7VGgz43gG2uZY7DRrSLOQ9ksKCPncSiOfn5naRL8VV4T+xr72ByNLJhCBZNnQ7W2Ca4Vpdt9PaI4UGHc03bzBW6rIdqni3IsJSYuS1Q6nDQH0ZqYAfQY3MFiCyrtpYjTCjzqh2Z8XLnqRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983295; c=relaxed/simple;
	bh=mPosCnzgcJbE1pjkdLDkGQw+G/s6LoErO422lPW/XII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HICzABxa/7j7m2GS7g9OtnTOc359lxg7x8F6dEphHPaKe88HlocJW1DT8k9u2HBd4dVcXtWmN/SQzhlFEXdOSrdr/BStZuuccFSPyCX2IWQ1YCA+WHNngfy7RYHuMh8pVv2Z3esDdAvms8dCG+9wrmY5XKAmUFfgRcN4JB2S6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWZRY9Uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5B5C4CEE1;
	Wed, 15 Jan 2025 23:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736983295;
	bh=mPosCnzgcJbE1pjkdLDkGQw+G/s6LoErO422lPW/XII=;
	h=From:To:Cc:Subject:Date:From;
	b=BWZRY9UkEVjlxkgk+qRn0xLEFakd/Nqiw/TYpwFN14NUw3x5gDzPTzbYbzWuXUzWU
	 ubdPFC+IXGfXjrA5Skl7MXjYIY3TaEeukJa8+afESZO/wAQj2gbw+PvrOWdkp4rrIV
	 42eGkcz8u+Gk3bByZBHN3pUKZkPu6jj0X22d6Nq3hmMFq7Uy4njqkVP5zyIc5nbIcs
	 74/B+Lnv776gQ5shR20t6rmyh70q6qviNOENqpXbIajdlPBNKseVz3gVpzsNipXFvJ
	 Jh9SZlWdyI5wtt/cnQ/wtSlJzu9JvSIWTB/aVH2LbQq79B2foxC80OcEWsPNzDmypk
	 VPhZli9hGdWVw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	matttbe@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests/net: packetdrill: make tcp buf limited timing tests benign
Date: Wed, 15 Jan 2025 15:21:29 -0800
Message-ID: <20250115232129.845884-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following tests are failing on debug kernels:

  tcp_tcp_info_tcp-info-rwnd-limited.pkt
  tcp_tcp_info_tcp-info-sndbuf-limited.pkt

with reports like:

      assert 19000 <= tcpi_sndbuf_limited <= 21000, tcpi_sndbuf_limited; \
  AssertionError: 18000

and:

      assert 348000 <= tcpi_busy_time <= 360000, tcpi_busy_time
  AssertionError: 362000

Extend commit 912d6f669725 ("selftests/net: packetdrill: report benign
debug flakes as xfail") to cover them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: matttbe@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/packetdrill/ksft_runner.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index ff989c325eef..e15c43b7359b 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -43,6 +43,7 @@ if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
 		"tcp_timestamping.*.pkt"
 		"tcp_user_timeout_user-timeout-probe.pkt"
 		"tcp_zerocopy_epoll_.*.pkt"
+		"tcp_tcp_info_tcp-info-*-limited.pkt"
 	)
 	readonly xfail_regex="^($(printf '%s|' "${xfail_list[@]}"))$"
 	[[ "$script" =~ ${xfail_regex} ]] && failfunc=ktap_test_xfail
-- 
2.48.0


