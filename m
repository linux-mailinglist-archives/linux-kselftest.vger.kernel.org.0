Return-Path: <linux-kselftest+bounces-11420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DB900A81
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31141B27412
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C781A01AD;
	Fri,  7 Jun 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6rxhvIF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DA19FA96;
	Fri,  7 Jun 2024 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777892; cv=none; b=Kp+DSgwjJBgbs7HYlxRtCeSnjbLGxm2GWP92j5gnyemovnTBPsiw1tnJ9gk3VTziFGbjRTi3s9AIzOu5j2xBxZAgZ9A1NHIG51gUOffSex4x5zxHb38R81TOpmxZTopDgQtZAyJNmkzQTFg947zSRuA2EI5VzFJj8LBAxVuUzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777892; c=relaxed/simple;
	bh=wQfj7qGRvIbdxyBHMllxfwfWwHu6K8la+zAXvBAGPhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfPbIHWSxlkUboUbx/idZeWmOTwAvQNYdilMqggz9GFmFZZ8UczQru4aWp0NEH8A5Ie00xeH67S0q9NAMjhYwXjNukG5sRsgQmdvdGpOc6qhLmSWbUU7DzchbuPQPTjvByJE2zQlhQ+XKZOm8zlXw+iiNTCAryBLhFFw1V31L0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6rxhvIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE4FC2BBFC;
	Fri,  7 Jun 2024 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717777892;
	bh=wQfj7qGRvIbdxyBHMllxfwfWwHu6K8la+zAXvBAGPhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u6rxhvIFAWPwvagwDcc3jbZfhN2UdYverQrMmjDQ2Q51Gmd2QFlaLqdnLrpssza8d
	 CKMG/v6KwfjmjmugdNW2Lb+T6qPMi9kIoKHNtXcTi2FrTNlfn2j1YMUtsamT6xM0+C
	 S6GmSWvm5bsd5nuprq7t/N/KNIyRJ+9E3pNAZz1Hv/FfhWTzCd9kxVi3XkrmPwwLGH
	 26oxhX4SaqDjJEyoLz0XlOeUvvTR9Z0gB+XrUpPI2AngsxyBB98XzlxrP0oMS90sbK
	 b5WAP+awRlCYEhmkvjzziJRGRwtKHFfJq5y6+538n0DTVEMG7XDo8cjwsHL0MHWzI0
	 wJTHVgZmriiaw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 18:31:07 +0200
Subject: [PATCH net-next 6/6] selftests: mptcp: lib: use
 wait_local_port_listen helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-6-e36986faac94@kernel.org>
References: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
In-Reply-To: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hTVnbzEs/VsxAGCcCO2AuB217Q1JKbIP3pRwVKJ7PZs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYzXPBcA4sCxBfarG1xUmQxlXn00WagQs+0cnG
 Bvz5J5yA4aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmM1zwAKCRD2t4JPQmmg
 c9mkEACVy5tLLQfLIZnrOaRPz5yK4BDZvZJWeWO4rxg4yBH/tdAIZSqGzWmefLVbg0x1wJVj4sj
 KiVB+sFZdDX3a/WITR6wU5ze5HveNiRBRDbFjLYe0ALNNxvRna6WL/nfk/1o1wZl/Y0mrHJg13K
 l0d6ZR1IRynKefzs6xAv8dtwDik6KA7h/EWbyefIZd56PHmM3SwHffiQG0tD/mBAhrT/XvQ5V8e
 3kF/ANYpGmnlfJdAcQY+0gpMC6PIc8LkbcJLmQRjGgnaGA7Nk1O8v7diEf5Nz6hVkvoA/CloFGU
 eYcM/SpYR2jtb2Cqa/v9IKOHMaDXX9Vnr/K61G/0rQHjfhiOj0a8vNw1xKtU/eT2aG6Sv3M8uN7
 uTdEE9mPGVC1RHF86ZB80KQ05G9gN9NBlQOx7W1H+hjzrSCPEa7lwpTGcRZWBzD4PC2nbt7MNn8
 LAtkCx+me0kyE17XYT7nlCVNBIX3zdn7HmtzxlvDVM8BdplCDxBqj6zGH3GtPsd8aZlfwwsFx97
 efUL/9qfZ3qn+DUvi6UlWOGEv8q4ildvas/qo6UrNT5VEw5ovZLb1N6klRLVs9uy653HttvAnde
 trzopBm5hHZcgeKjBlAITSmgsF4O4SNL4pC5COQGZlZaum9Oq3TdEol7O0OOJSshDz8Ji5pLNBd
 VcX9eTKX5m1K0nQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes net_helper.sh into mptcp_lib.sh, uses the helper
wait_local_port_listen() defined in it to implement the similar mptcp
helper. This can drop some duplicate code.

It looks like this helper from net_helper.sh was originally coming from
MPTCP, but MPTCP selftests have not been updated to use it from this
shared place.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d9e30516dc72..194c8fc2e55a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(dirname "${0}")/../lib.sh"
+. "$(dirname "${0}")/../net_helper.sh"
 
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
@@ -363,20 +364,7 @@ mptcp_lib_check_transfer() {
 
 # $1: ns, $2: port
 mptcp_lib_wait_local_port_listen() {
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex
-	port_hex="$(printf "%04X" "${port}")"
-
-	local _
-	for _ in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) \
-			     {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
+	wait_local_port_listen "${@}" "tcp"
 }
 
 mptcp_lib_check_output() {

-- 
2.43.0


