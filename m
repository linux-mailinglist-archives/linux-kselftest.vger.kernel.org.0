Return-Path: <linux-kselftest+bounces-7270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23568899B5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B744EB20D9F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9092516D9DD;
	Fri,  5 Apr 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbqyZprg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207016D9D5;
	Fri,  5 Apr 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314379; cv=none; b=k5hRbaNmVOR3yIQoiXWoe30vBcyl42KCS8qiScnWHvD0ZhB6YDchJzFKc+CivYpUZXl5NyXoO4jNmbqMlgGc/wXT7KJwO0wigzkPzEfcXKwqmhV/fmgai9F3EIDq6BguQjdFl3cbJiRbo4uleAZvPFODHQFhnl9FAcDKo5wU7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314379; c=relaxed/simple;
	bh=fgoj8mb7L9iIjajmasQSVS1V+GYnanZZ2dC6S1meCAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckJMu/1jNayXCsSHEBvIPR2KUASU5toMxPPFGNfCGiuz29ghjMSoSWqatmEJ8cciCgEw66Oknk9jq8KI0mosRCznK6aJG6KcnWY1IHUYEo6uFzPtkv1CBmGXnQPFErqooyv2on8lSLSIm7//fQz+7yC2NMC9Rh750SRzsi+dGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbqyZprg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444E0C433C7;
	Fri,  5 Apr 2024 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314378;
	bh=fgoj8mb7L9iIjajmasQSVS1V+GYnanZZ2dC6S1meCAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hbqyZprgjdHYpN9ZXwzmxzj3feL/kC5fOzHQc1AfCkwK2OdoGpqe+aHKzwvvPDj3J
	 uLdnXvIglqQoP9UYbKIHgUd+BAg6HfIvaOOPv8QP3ghKIlsbEYTBLgRDP3huiv03ce
	 HgyBEgSkLvJB5QUlMLH66iTSeRFrrLUKjECTxdi+1LmFCn78byLzepphDWeB+Ocqhw
	 9DRuzTbpX/KthsEMHSkZvQdM+3LF7T0yNqVUlNPPYiujhfeqIGPBImtq2rzcUg1as0
	 /Z9+8DN5521lxqrzOsSlTjxTc0dJerUXA4k3g2QqoMmEyhnG4W12El0O/Lwr2LOOBC
	 Ws7A8Kso6KW0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:15 +0200
Subject: [PATCH net-next 11/11] selftests: mptcp: netlink: drop
 disable=SC2086
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-11-eabc9b960966@kernel.org>
References: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xlQkfbCL4ErvHSP5FwwmBIYPnN6FGH51Kb3aZGA8ojk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9fmcHa6BiI0wi6rGAw8wxUcdYt3P3gbi4rnv
 pZoILgfM5eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5gAKCRD2t4JPQmmg
 cwneD/95yyx0OfnYUP9IrQ29KInbqFdl7JhdnjHOfWsBwn9kgblNW3kDztkzOGqNQCqBbMtMg4Q
 Yxh7Slbcq/nA5KvwNcvwtD/sntLL1vczQNK7tpheGwwbju/iAjxDLnUv+fhQtnPOG+oCWtNG4Q5
 noWvfNx9RAQzVgfp9TAOaZkqZSK6fkn5uppPDdet5eM45IAJGZZTWuyQuPcF0XxI9cMObnBlQlj
 4PcsMOGtx46OQz5gm3dmJlMfVxnIdzdotlIZhUx4ojidKwm35ftWaBuxw8n+53tkH13oor5rujG
 peNnt5mLAlulFQLoLTETeagGwkV6Ski5AMzDvhOcaB8mB7ATTJME9pSGDcJ9jrUvkIdV6jZCPbu
 b/Qd9JyvuuqAz0C/2SPqfLBAfOVlCRr/LEcTtDbIXkjcNQoFNE8sWYlnMxNTl4Cb8M1BghCekup
 8/KX0hpQW7vcFxHC4ic+hSMLnw/diUrhr4j6RV7jiTtCSwNYuB9QoPzJGQBAE2vS2ddbNicz6xC
 QlP8jXKkpyCa6VPRegrkdLhPiOpTkOcrMLiJXji1BOB3wctQ4Zq9bZucVXB249NtSyJ9WJLH/c0
 qhsplxn+AXFu4mTR/NuHd2ItS//H420JrDZbgtmiI/krE+ldfDleZPz55sRutUz3cbhF+4YdUdf
 zbNuAHCZSkOxFGQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Now there are only a few of variables are not using double quotes.
Modifying them, then "shellcheck disable=SC2086" can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 4859fa85d9a0..2757378b1b13 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -1,11 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# Double quotes to prevent globbing and word splitting is recommended in new
-# code but we accept it, especially because there were too many before having
-# address all other issues detected by shellcheck.
-#shellcheck disable=SC2086
-
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ret=0
@@ -20,14 +15,14 @@ optstring=hi
 while getopts "$optstring" option;do
 	case "$option" in
 	"h")
-		usage $0
+		usage "$0"
 		exit ${KSFT_PASS}
 		;;
 	"i")
 		mptcp_lib_set_ip_mptcp
 		;;
 	"?")
-		usage $0
+		usage "$0"
 		exit ${KSFT_FAIL}
 		;;
 	esac
@@ -40,7 +35,7 @@ err=$(mktemp)
 #shellcheck disable=SC2317
 cleanup()
 {
-	rm -f $err
+	rm -f "${err}"
 	mptcp_lib_ns_exit "${ns1}"
 }
 

-- 
2.43.0


