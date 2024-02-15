Return-Path: <linux-kselftest+bounces-4801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B8856C81
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C473E28A19A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FF813B7BC;
	Thu, 15 Feb 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrKHk5wG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EC413B7A7;
	Thu, 15 Feb 2024 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021561; cv=none; b=jb7vrrEv783LIXQwvv3fNWFm6hZLWtKg/Y5AaEMEBg/+jOLCqP2DbvvLpdRWYPq6p08ntU5efCWb3CBfcP+Tpj04o0nULU257iHwQK37igDfjfenQqwIRAXM4q9WFAMRrMf/v/WdQrjPrwGs5B7PSX3pdJkAuz6zJ4ZVHsKxJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021561; c=relaxed/simple;
	bh=Bd2G68hqKS5Z3hOL7RVjNT3ktLWLRKfWpJwK9WO2ZZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qYTQfCVb+pnCGL/lwBXShECdG7vkMhvhF1sqPcsS6h0ycyTOd8BviASYJO+xfdq4Md/7HQN8D/XDr9k0UJH7VFMp15cOLgeesZH8dve12NiDacShO5EVSlyfCKKh13YVe7laBo9diHAzGx/m1YCWfrJYTZgx/x7QtEBf/gFkAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrKHk5wG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6341C433B2;
	Thu, 15 Feb 2024 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021560;
	bh=Bd2G68hqKS5Z3hOL7RVjNT3ktLWLRKfWpJwK9WO2ZZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DrKHk5wG3+p2ZNKh926Eg3PmQNr1YBtWGcvEyZ4C5er1uZVhGrM2rgByhgETbQrm7
	 BQYnB6PuTyLD0Ndab/b+2yC3okD9/dNVb9oOyQIef9PQF68Ce2SR5TSLhkE48Bp00D
	 8mmNPJMdjngvXnltry1uzjHwCcFt0RxQ6Pt/bB5KahecBb91mNbAccgCtDQiLrMOM6
	 0T7u4FkqUtKZYsYJn7s7iuXgMhttya1dzDUXtO6j1GkZb9rP170k+jLt03bJ2Rk5SY
	 WIZxozBeW+gHSmKpFP1iW12oy2z48RnDrJQM7zhAIu1m6PKNOhWMABqb0B/MQLHLVZ
	 C6WFhawJE35kw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:34 +0100
Subject: [PATCH net 07/13] selftests: mptcp: pm nl: also list skipped tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-7-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Bd2G68hqKS5Z3hOL7RVjNT3ktLWLRKfWpJwK9WO2ZZU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcdltt1zNZUj1lxTpJ+Xy4MXRQYvcDQW8XzH
 GrXkE9RgsuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHQAKCRD2t4JPQmmg
 czImEADH4fD2jn4rT8o8cr3H5ap+mhXSAssT2+gbN49a+XXOHtsbxYazUOjB1CrvRCk8qy51r34
 IAlcd13y43tpHnfgZMHC+N3imLhP9K7jnMD9iikPxxrSwR/RFJRg5UtzQPV/PqrNUeURLXMUWhO
 cxaZvN1Ht8kWK0MaUr+2JUDyYygHmK1jFw1vruj+4W2+0HJeiL98+f+SF+LvcIkgAL4bROQKY3q
 ePYBQJqXiPCv0hddekcxtykeCo0jhN9pdRngG3K5asBYeH3RbIrlbe93hUuSh+BrAbGqDBPh+hA
 CQiOr+6yqL04CGu9vAm6J16TdhynT0nXxRS8h2m5mBigoW3+OJv4wHF33/dedBw34TsZHBMs+Wb
 BxHbuxXN7Oq6xOyrGf7dK2vHofeBNGTe113NV6chZedvf22hv/EbqMpBHMavveporR8zBNaLnva
 eS1YSzGEZyV+u18XZ6W5SHyHUccU6nnhdQZPWWlwl4IbQEwxjdClYRpcmjj4S2p7/OF+LovBUBZ
 H0e/Fpt9tGZrunSr3/oz30p2vl55s7J6CI9NEzBxF00mW3EwvXByajoHGrt2jVe27t/mpJlaTe0
 wndPLN2Gp01EkLSC12YJjytI7nUPY+hIFOdAhBN2y+k7UD4ESLwYf984Js2Iu3SUfrBQ3QsgPD2
 C9ACKtGvooElWAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If the feature is not supported by older kernels, and instead of just
ignoring some tests, we should mark them as skipped, so we can still
track them.

Fixes: d85555ac11f9 ("selftests: mptcp: pm_netlink: format subtests results in TAP")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..79e83a2c95de 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -194,6 +194,12 @@ subflow 10.0.1.1" "          (nofullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
 	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+else
+	for st in fullmesh nofullmesh backup,fullmesh; do
+		st="          (${st})"
+		printf "%-50s%s\n" "${st}" "[SKIP]"
+		mptcp_lib_result_skip "${st}"
+	done
 fi
 
 mptcp_lib_result_print_all_tap

-- 
2.43.0


