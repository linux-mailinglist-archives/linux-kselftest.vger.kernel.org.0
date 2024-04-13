Return-Path: <linux-kselftest+bounces-7901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4C68A3A2F
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BEF283C05
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F981DF60;
	Sat, 13 Apr 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8Ht6pt7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA78F7D;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972584; cv=none; b=Leaw6cLf8VSNJGCN4Xat1nC+fQgk1otLBwypEppLRvUMFWwiuwouD2L7c+kSfxkJDrdQ8vI/zGb+nZbS92SdqZ+g8B+VR4A2T99weXwx+j3S0VLb/1y+T7ke4R4j0kzSlUx2FaGgjT96W6+XipDIShBDXl/CIoqFCpEi1dNulkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972584; c=relaxed/simple;
	bh=YiZxq4sQxoAgUnQhcX4+ld7ZHlxolEbw1dlFH014/Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOsa6HUHCLaerENv2yPZ12zeUbuspF8gNzJGH6r+O1RddFZ539vPyOnL2aw2rL8Lp4N8rlBFdRT8JtPB5Z6EFm2mEICID/W3VZwSKZhOhN0gnagt5plTmSR3cttrXiALFItWwm5eCvxpvuAMexwDckGopP0noLdZWRRBnUj9A3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8Ht6pt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C4DDC3277B;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712972584;
	bh=YiZxq4sQxoAgUnQhcX4+ld7ZHlxolEbw1dlFH014/Nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A8Ht6pt7PAkSnGsGENmdlgTrgU33Lvi6yKiGn7khfSKWOKSH7Uftj1HAXKNvAr99N
	 w4dCU6+UFNQfwz5jwAWGB++NpfK50LNKZF/igJYFlbRkpgfuhWJY2cBvlYagEoQQFM
	 4KBCV5GbRGdSOCKIzK4m8mepKDVlA+GC/voqWxqcUA5si5Nf7CR4wz2W2B8jcxtLGK
	 JOVa3Ytmtpl6ZUXV2A+Fwpk60pYGeGuAy/kcc8RscGMzxtkK2GX9ykRrvlcM3lTzRU
	 szkKC8bznagx0yEBN7tbTY+CVEN9i3xpYhC4YEP1dyTGjmGj0Uu34rJm+U2Z6apF77
	 ZoKmHHSR3M6bw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB2C04FFE;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Sat, 13 Apr 2024 02:42:53 +0100
Subject: [PATCH net 2/4] selftests/tcp_ao: Zero-init tcp_ao_info_opt
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240413-tcp-ao-selftests-fixes-v1-2-f9c41c96949d@gmail.com>
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
In-Reply-To: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712972582; l=1034;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=3bRkAaWMpwCvEVUHFASSPFH/W2xMsTy4q2ZYGJH/FcI=;
 b=aZvNsjzortZd28wwafvkCmgyJVPjZQcwxuQ5gPXrPthVSKj60nH6vApYB/+5TgqvtXPLqEBmh5x+
 f7RSvRMsBWHk/b46SuYVSBsFsRX6ns0IW2+2X7YvrhZdaTu9iEUE
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

The structure is on the stack and has to be zero-initialized as
the kernel checks for:
>	if (in.reserved != 0 || in.reserved2 != 0)
>		return -EINVAL;

Fixes: b26660531cf6 ("selftests/net: Add test for TCP-AO add setsockopt() command")
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/setsockopt-closed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
index 452de131fa3a..517930f9721b 100644
--- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -21,7 +21,7 @@ static void make_listen(int sk)
 static void test_vefify_ao_info(int sk, struct tcp_ao_info_opt *info,
 				const char *tst)
 {
-	struct tcp_ao_info_opt tmp;
+	struct tcp_ao_info_opt tmp = {};
 	socklen_t len = sizeof(tmp);
 
 	if (getsockopt(sk, IPPROTO_TCP, TCP_AO_INFO, &tmp, &len))

-- 
2.42.0



