Return-Path: <linux-kselftest+bounces-17650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E6697430E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 21:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C3BB270E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 19:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183621AB534;
	Tue, 10 Sep 2024 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6gtvCzG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27C1A7048;
	Tue, 10 Sep 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995230; cv=none; b=AgdoRLFKf3YmdyJ9ZUfBzaNuZdG6j+b5zLBzSgrRD0GCXEzsfjI5DpfIR22cTmU3rqhF0fksHpbCojk8Sjf5xUbG7B4ZG3FWLv9N8Tjmb363VdG0KMELxnJAwZnc0QhsZ2bKfJmhAiTijC+iDsYimMVNRm3X9Rd+vedV6Rzjo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995230; c=relaxed/simple;
	bh=AqPu88ul23g8vqXHRoSXpzTMwp8/lrE6zGfqa11fWfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khVv3ikrcxqjBtKeDtJ5AITHB+ylyzI7njIkW7TFlywXeCAXzCsUfmP+1FgH30WtltxtCZnFxqeaZ6eDK6nNmYt2XSHjr9vOnPzvKsI/Mojlp0a/SbLiLRgQWgDlTWfliirZ3zctv2JhywGtHkzyPTWKH3+jnN4/DVL5+2ReKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6gtvCzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B7FC4CECD;
	Tue, 10 Sep 2024 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725995229;
	bh=AqPu88ul23g8vqXHRoSXpzTMwp8/lrE6zGfqa11fWfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P6gtvCzGxO5Y0e2RnUdHCFSr5LLlSv72Sti7fTWVOcCjiyYu7Z3rE2JkM2BchUWyq
	 ex0GOtesJtDIJgSqihW9VKI+41CA6Sv9vZ78fcujf5VPx4DOs1PxSbDXrW4iXDRhco
	 lpjroNSHpdjyrD1Csw0i2ocNXdJ/x/Q4hSnN5RxdXw7zxSrwWl9nGOnrHwCWDqrhSk
	 zgF6EFpMFIiK747wulc7srIf4RRY6UJIW/LlCt3D+2JWLePWeL/xozEBofhgrVv/tW
	 YbBSMLLH6VHNdpl/fwN18ZH/KqWMDauqXIsIK6eRV4glLTZ4A31MAAZQSUPucXGVV7
	 GTZIrAVi42ciA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 21:06:38 +0200
Subject: [PATCH net 3/3] selftests: mptcp: include net_helper.sh file
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-net-selftests-mptcp-fix-install-v1-3-8f124aa9156d@kernel.org>
References: <20240910-net-selftests-mptcp-fix-install-v1-0-8f124aa9156d@kernel.org>
In-Reply-To: <20240910-net-selftests-mptcp-fix-install-v1-0-8f124aa9156d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AqPu88ul23g8vqXHRoSXpzTMwp8/lrE6zGfqa11fWfg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4JjRLyUOkbW8YPrnCLArXrvqiNJsK74wn5pqZ
 22BnQBxbF6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuCY0QAKCRD2t4JPQmmg
 c5MAEACsaR2u56Kl4zwkCtHtRZoVuBNtTlAkyiz8Kd5q5r5VfGquW9QrY1vNnfWh75be7jiCbti
 zK74NRqcGRsd/Jn4Q13EDMx89iO9vN70/zrwyccUh8EkII8b2DaFSoP2t3fVnaPMrkyuzY6n/cc
 35aOdBLHfLTSH1C9dqDe5ec01TWogsBQhUXVeLzXrOz4KWvlnQl7/AlNaJqxDCfluYzkjRat7Jv
 gGxg3X3BoFIAnis1dmsg22m4KaaCSLyXuxI8mkSkhfkbdTDHXf0/f0bK1NFU2p8ma6FYoztgodG
 bohV9lXpgfadEk/kGY6klDenQg9wNBYDQ80ScknfhZM29PoXtoF6ZO4hszgWyO9+29J7vX7cChY
 0tuGew0vBbKUz4NMAzY3LGnBIH1bKPAzTXpr2BfCy9R9yFBk151Woi5tNUjaHW1sqGzAYkKM8/P
 u3zf6Eod9daIA1CYeJNAYX0SmmtX3xd59VIpEZ3yXjj9h/o7B52SjWQXf+2dHTsB9ruxvzlM6SU
 rMOkY7GDuxUiU7hltsMyg/AK+shRY7QuRW+9sKvoBQMnEfajS9rrn7P68qI21SHZzJjE9+AW6++
 299uVSaZB0NTPUNG+KwLokMHaZxGn+vvqQsflLNC3k0C5VtA228hpYMu+N6u7nyabKyGqSjbvhj
 Hf2SKyDyYpVaBcA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to the previous commit, the net_helper.sh file from the parent
directory is used by the MPTCP selftests and it needs to be present when
running the tests.

This file then needs to be listed in the Makefile to be included when
exporting or installing the tests, e.g. with:

  make -C tools/testing/selftests \
          TARGETS=net/mptcp \
          install INSTALL_PATH=$KSFT_INSTALL_PATH

  cd $KSFT_INSTALL_PATH
  ./run_kselftest.sh -c net/mptcp

Fixes: 1af3bc912eac ("selftests: mptcp: lib: use wait_local_port_listen helper")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 68924053a1e6..5d796622e730 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -11,7 +11,7 @@ TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
 TEST_FILES := mptcp_lib.sh settings
 
-TEST_INCLUDES := ../lib.sh
+TEST_INCLUDES := ../lib.sh ../net_helper.sh
 
 EXTRA_CLEAN := *.pcap
 

-- 
2.45.2


