Return-Path: <linux-kselftest+bounces-48885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5FD1AB83
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4F113032708
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1EE392817;
	Tue, 13 Jan 2026 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPC/Phas"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C634EEF9;
	Tue, 13 Jan 2026 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326400; cv=none; b=p2Qye9ykYRQ0eBdeNLG0iSm4qg7Lrt+yHKBDVrKe3eK9BzZDrppPYgR7bgZngc4QiW4PtuLi6DMnQvQKf9asn4Yu6Y4+J+lnsPntDqeZKmt0Vgs1bkyH2nciXeC8h3FThVE0UHJaq6ZyedmQGqq9dKP0wrEtSmMHIlBftvbF6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326400; c=relaxed/simple;
	bh=0DoJQCma/nt+GuLmHQ0hPqIC2uUmE8bIQDPHwrMc9Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hos4HZelcjNTZzwPevaXF1+qQfbil1qKYYYS7qAfb2b2nSZl1BPQXKH7TEAe6+NhCjXW/0K56i+6ok82a0aqkKXbPmbOTnGhPWqKkIaQdXK59vyHPIqKDf07w/IH8IOybKlTbyXR/TAEW5VU9RGp1KdCSwZL3bTBryOsFekckjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPC/Phas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0ADC116C6;
	Tue, 13 Jan 2026 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768326400;
	bh=0DoJQCma/nt+GuLmHQ0hPqIC2uUmE8bIQDPHwrMc9Qs=;
	h=From:To:Cc:Subject:Date:From;
	b=DPC/PhasrZE4MJB1ci1n39baEWkFCqnga9OPr5shTsS7t3KyLb/znWhmnpBj3BEil
	 wqgtBiZuxfFa+Ve/8CUHWJNqy4CHi/YmzKaYDijpqXgRuPKHZUSGC+jnoL6q+G6MaH
	 JkXIJezdLdIwX66dkFvovlnRpdneUifRZmMvNpnkLAIb05VnV1MpII3srtrUFyPnZM
	 TIiYUD0ceYCyTmpxYDIP/RTfNvtYzMYK/z51h/iV8kH/XlIb015sbjtMoo1wMLLv+F
	 +SLlG/0sEJdbDkL5QF80hqDxa9i/2soUTtSITWB/5fdonLtWi25L4Z1nCRWF7ekF+J
	 xkCMOimj/4U5Q==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: csum: Fix printk format in recv_get_packet_csum_status()
Date: Tue, 13 Jan 2026 18:44:19 +0100
Message-ID: <b0e24fd07302aac492d03d0bcd30626a338f976f.1768326133.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=chleroy@kernel.org; h=from:subject:message-id; bh=T9mDX+l55XQ9vC0s5GLbMDjW2QU1NWZkZNG6faVyoMQ=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSmtZS8ncn9wCGdTWhaKPeu5YJ9Rm3HDmWd/a/lsvLQH Vvn4rorHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAiev8YGdZ+eBka0LlSvyXr duR5pfP9D8yFTefczZL3vyH5MD9GJI7hn7Hxpm+zpm7UnvIsZeeEM2sdL6xeVNfEHhK4uXTPJNn 692wA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


  CC       csum
csum.c: In function 'recv_get_packet_csum_status':
csum.c:710:50: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
  710 |                         error(1, 0, "cmsg: len=%lu expected=%lu",
      |                                                ~~^
      |                                                  |
      |                                                  long unsigned int
      |                                                %u
  711 |                               cm->cmsg_len, CMSG_LEN(sizeof(struct tpacket_auxdata)));
      |                               ~~~~~~~~~~~~
      |                                 |
      |                                 size_t {aka unsigned int}
csum.c:710:63: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
  710 |                         error(1, 0, "cmsg: len=%lu expected=%lu",
      |                                                             ~~^
      |                                                               |
      |                                                               long unsigned int
      |                                                             %u

Correct format from %lu to %u for both.

Fixes: 91a7de85600d ("selftests/net: add csum offload test")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 tools/testing/selftests/net/lib/csum.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index 27437590eeb53..9bcd7394b3043 100644
--- a/tools/testing/selftests/net/lib/csum.c
+++ b/tools/testing/selftests/net/lib/csum.c
@@ -707,7 +707,7 @@ static uint32_t recv_get_packet_csum_status(struct msghdr *msg)
 			      cm->cmsg_level, cm->cmsg_type);
 
 		if (cm->cmsg_len != CMSG_LEN(sizeof(struct tpacket_auxdata)))
-			error(1, 0, "cmsg: len=%lu expected=%lu",
+			error(1, 0, "cmsg: len=%u expected=%u",
 			      cm->cmsg_len, CMSG_LEN(sizeof(struct tpacket_auxdata)));
 
 		aux = (void *)CMSG_DATA(cm);
-- 
2.49.0


