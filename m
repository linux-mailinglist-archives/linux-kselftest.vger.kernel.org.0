Return-Path: <linux-kselftest+bounces-13670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EC992F89A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 12:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43458281EF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204C14D71D;
	Fri, 12 Jul 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3EhOmRa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C774624;
	Fri, 12 Jul 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778439; cv=none; b=W3cGY7+HbklqkA+p2SDTgd034af79gR/FOFQOKH+0c9YIyu2G4cjPCQpuwpV45BicQ6NEkunN8roYx/lQ5vv2y3Hhq01d9HkYd3qaIxnsbSgL7EhilGhzxZHTgsXgdYl8CwgakdCjAoRxXpeIfqcutl91ojBmOY/efZ7JEt+J6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778439; c=relaxed/simple;
	bh=OjZcO5Y/p3VJkM8yC5RnwUbNTQGbECoPCnl3MYrvQP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=udTjRk3ze7Gxft0HomF0S3nboKj5cdMliTWTsnIoCBv/yNeBZ8xVI35zOs6pf/n8N2nDl9qpA3GpYO4a/OsAZ76LEF3mBLG/rDMYWwW6U/iuxifS17VSysZmcV/ciTUQ8dz/1BXINMo/gyG2vXKBmhyJwAeUoSndVUiLz7iXhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3EhOmRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0644C32786;
	Fri, 12 Jul 2024 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720778439;
	bh=OjZcO5Y/p3VJkM8yC5RnwUbNTQGbECoPCnl3MYrvQP4=;
	h=From:Date:Subject:To:Cc:From;
	b=Y3EhOmRawcToB8Y50dXh3LvRY9xDs8zUPNyNvuxFSd+QIxAJjjZ/Y8B5/qnIBKYvM
	 iH1GMM+xEe021s+FhioMF6mT780Ef2JcAyyPpTTE8zIIR3FR3mrd25OP+P7OqeHmRe
	 DqPEIQQs81OdkqK0RwdW4KVRNkLC6ySq/aK/GDxLmMs2z8jNvpK7bahbmZLDRaPRVh
	 Zt/xYd5Irzt6k8fwRazrKh4xwunJk671+nmHsCiSkGhcWOKbdWoJ3hsF7JsXlNgRFO
	 Nu1YGciVSzWFEybhPEpshSN/iRrHqGrsTIUYCTeoBOpnKTqRW6Bi9KaR/mvZuR4zz7
	 nR+6pkhRc4ouA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Jul 2024 12:00:15 +0200
Subject: [PATCH net-next] selftests: mptcp: lib: fix shellcheck errors
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK7+kGYC/z2NwQrCMBBEf6Xs2YUmaAv+iniocWKCaQzZrRRK/
 90g6GEOjxnebCSoEULnbqOKd5T4yg3MoSMXpvwAx3tjsr099qOxvBTRimnmDG1Zlf+VIHmFqPB
 c1BX2cWUJSMkFuCcP3owYTm5w5kbNXyra4vt9oZ+Nrvv+AYb/eS6VAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OjZcO5Y/p3VJkM8yC5RnwUbNTQGbECoPCnl3MYrvQP4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmkP7EQ2BR/zeb4cBmw6GrnLDEFoqjy7o5IjRyR
 UtuB5lfEpyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpD+xAAKCRD2t4JPQmmg
 c0B/EADj9aUj3KGhZb3TKEu0tg9TQlcryAThbXO+qf93el1zpeiDYHl0ZyaWOwj2oMDV2QGaG/s
 +blKSoMWZZTj3Aju0EwC8vmst5YZIJAfet5+F4yN4Nzlxyz1ZDxfqzLad8Wm/X9ZweG5ZA58OTO
 Pca8Nc9ew+r2rTt/UWdwQ82fTZXHoXxSPVdSp7oBrW58E3kvkrSGrobuIahinr9hA7jzyVSd1Jr
 dQZfNqbcmF+O8uD1youEoU7zW79wCwsAt5HvbESlul0Zso/qo0WNzBLNIH7UGwAUXh0efOzs4KG
 45vUHf5Wnc2Yd56hMi4n2thIOIaT7SAd44EdVrVm888kuelRVk0LLShY0m3KOLdPFq6Qi/Hin8e
 Woe/zPqLgTGfTA+7TNJJYv8Ctv0jqT5tfdIJF1z0+oUzFQfOJwLPIfe/TvkZlTW0uj8OVS4YEow
 hClhNu3LkkRSmfJXkHddWRa3bAmsCCrrNMhmWSQV6dvUqndq8g/NA7+CckZ6kGBk/mvj0m2Tax9
 0T+35EJQt9ra7m0zcUpXPq8XekHar3Wfzyg22RlNk3uD0tKrdWsHWuM1zfHi3V+A7tzaFrAV6Z2
 a5d+FUir/WWaU/WovxBcin4oghOlMTV0yqzB1L+Gp4EW8ckoeLxpEjSgOGBJqd32a+aTQCkcoVX
 H5+6gUuKn6t/+ew==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It looks like we missed these two errors recently:

  - SC2068: Double quote array expansions to avoid re-splitting elements.
  - SC2145: Argument mixes string and array. Use * or separate argument.

Two simple fixes, it is not supposed to change the behaviour as the
variable names should not have any spaces in their names. Still, better
to fix them to easily spot new issues.

Fixes: f265d3119a29 ("selftests: mptcp: lib: use setup/cleanup_ns helpers")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - The mentioned commit is currently only in 'net-next', not in 'net'.
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 194c8fc2e55a..438280e68434 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -428,8 +428,8 @@ mptcp_lib_check_tools() {
 }
 
 mptcp_lib_ns_init() {
-	if ! setup_ns ${@}; then
-		mptcp_lib_pr_fail "Failed to setup namespace ${@}"
+	if ! setup_ns "${@}"; then
+		mptcp_lib_pr_fail "Failed to setup namespaces ${*}"
 		exit ${KSFT_FAIL}
 	fi
 

---
base-commit: 2146b7dd354c2a1384381ca3cd5751bfff6137d6
change-id: 20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-6f17e65c6c1b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


