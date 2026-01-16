Return-Path: <linux-kselftest+bounces-49137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D13D2F03C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 10:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E051300D810
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256A4324707;
	Fri, 16 Jan 2026 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsj2fmDf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143930BB8E;
	Fri, 16 Jan 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556948; cv=none; b=JhYOdzEHd0Qngc4TYK2cZ2llU/7Xu9pCChj0WAduZBT8ewpGAU6SQwjwUmO4V6DGJkuSS7MQt4kiPse9G36pXjSws4Y3Xrx0Zl3QZqLANyIXzVYCb733FTWKKoqs1w5DshSwX51y2j2W7Ntu6wsgrNV7MBoEjrcn5OynhXwYz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556948; c=relaxed/simple;
	bh=NLbTtFH/y1ozIwxkXOHUPwJjVtEvUi7rKolh4lp3SFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BV3h2dEfNLQge8LKEtlKNmM/D1kN5VbeYuqYHidCw3yw/gHZt9YQAKjm8w4cDTYo2I3k9qD0/3ZKFGuinKRKZPf4NClRSOV8agQv+z4YvreENadDynV0eeh6ZJnD6pfPeFDo5h6s0EdZRD/OoCVKoBX/vATKOWT+IU0rkVNgAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsj2fmDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A8EC19425;
	Fri, 16 Jan 2026 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768556947;
	bh=NLbTtFH/y1ozIwxkXOHUPwJjVtEvUi7rKolh4lp3SFw=;
	h=From:To:Cc:Subject:Date:From;
	b=jsj2fmDfl0g3Bb8a+nW16oOpT+K1/cokaJfIYEi6sov5hxX195Fe6eat5quyrzb3a
	 ouCr36T/lA+aiNZKRAQBVZpgCQym+EXgNTfP9i30NMrgDsxW0aESXVVo/ct0KRrq9H
	 ippobTrYJcKzUlDQuQSplPne8h9FPZyICXCPuDSdDEp0XKWkqxuN9fLwuRPAiD8H9b
	 /p+57sEFzM6wr7bkXqoAJi2FgX5fssdMI7qoOEKNZyK5G/ARKz2BrHM4MSii0Pup46
	 XhhgkCaQYEmamB++sCkUoNCixny5Nk/a1C55WcNgkujlFtKDxHvuWJ7r7TQuqe2HMs
	 dRdW/dPTZXcww==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] selftests: net: csum: Fix printk format in recv_get_packet_csum_status()
Date: Fri, 16 Jan 2026 10:48:55 +0100
Message-ID: <8b69b40826553c1dd500d9d25e45883744f3f348.1768556791.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562; i=chleroy@kernel.org; h=from:subject:message-id; bh=NLbTtFH/y1ozIwxkXOHUPwJjVtEvUi7rKolh4lp3SFw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRmcXac4imLllI4KKWystG74YJtXr+R4UclI63Ezc9eX 75rwfKmo5SFQYyLQVZMkeX4f+5dM7q+pOZP3aUPM4eVCWQIAxenAEwk7zsjw8eLF1O2lNlOT5dL VPW8xdi9UYJlaePNqXuervctFpx1fR8jw0HzufkxH/oib/9qCpm68unM1ZwfZm16kHZ2p8nGv2s i/TkB
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Following warning is encountered when building selftests on powerpc/32.

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

cm->cmsg_len has type __kernel_size_t and CMSG() macro has the type
returned by sizeof() which is size_t.

size_t is 'unsigned int' on some platforms and 'unsigned long' on
other ones so use %zu instead of %lu.

This fixes commit 91a7de85600d ("selftests/net: add csum offload test").

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
v2: Removed use %zu instead of %u and removed Fixes tag
---
 tools/testing/selftests/net/lib/csum.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index 27437590eeb53..e28884ce3ab39 100644
--- a/tools/testing/selftests/net/lib/csum.c
+++ b/tools/testing/selftests/net/lib/csum.c
@@ -707,7 +707,7 @@ static uint32_t recv_get_packet_csum_status(struct msghdr *msg)
 			      cm->cmsg_level, cm->cmsg_type);
 
 		if (cm->cmsg_len != CMSG_LEN(sizeof(struct tpacket_auxdata)))
-			error(1, 0, "cmsg: len=%lu expected=%lu",
+			error(1, 0, "cmsg: len=%zu expected=%zu",
 			      cm->cmsg_len, CMSG_LEN(sizeof(struct tpacket_auxdata)));
 
 		aux = (void *)CMSG_DATA(cm);
-- 
2.49.0


