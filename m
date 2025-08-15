Return-Path: <linux-kselftest+bounces-39116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A47FB28518
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 19:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9167A1C83FDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224C83115BE;
	Fri, 15 Aug 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc3gqioU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476E3115B7;
	Fri, 15 Aug 2025 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278948; cv=none; b=S71jqp5ueG0BbkcRVRlYm1PDJ4625Flp4DDZE65ohTKwcXI3FIBi6Np1NOsrTqdEjn1pWve8jG0Uqh9XJF+mE1GD6TIqX5Wf0+jxivF+5BTd7t4phmdZQfbhR2kVrKTc1lKNjhTbe+Khb5mg6Mv4AMzoqhtU43dTtmD+lU11Ovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278948; c=relaxed/simple;
	bh=SNZJTCa5XDVUd8KDVWlx3dbijbMr9Mux8fViXWyTANs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qkmSgRFAHfDQJ4nl3co4/bhr/rICCD28HIjqN0LmDwydKZyFqmLS57JNNZiV5NFfg9M5BaFnXDAkBg7a3N5ujZqRXfEZoZp0s7PWYnvtqFBg1jie5dEcPde+SmZCGyTco+Aka9LfA8W6UgLK/nAbOFH2FOzoRNgs6YqwezgXLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc3gqioU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07F8C4CEEB;
	Fri, 15 Aug 2025 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278947;
	bh=SNZJTCa5XDVUd8KDVWlx3dbijbMr9Mux8fViXWyTANs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sc3gqioUWdKnm8fmCZvYhxjrQ55L1+nj4s/YURqRHZLunssJBt5wa3MG7WyDPT4cU
	 ebOJWksKop2aKLaR3x4yqldQHLV1fUgKour9LaMJzm/WozDhcef5YAOZrmWpiV5Cgj
	 IBYOfeYIIk53G3FauAGTS6JB4gUbLAjPz7kNJ1lfcOk9FsCWc3Krb8VhaV+7W3t41+
	 L4d1encDZ/56hN7tY2lYkqlwYTSuVtqc9DXFICKggpXPFv0GcG1q1uDKvitnTXgZAe
	 wPhrQX1VmExLpNzN6mnYM9CAx9sMi16awkjTQBreLh4m/K4WfAL9Sog4oY/Jr3vliY
	 rdpL4e1hLLg5g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Aug 2025 19:28:24 +0200
Subject: [PATCH net 6/8] selftests: mptcp: disable add_addr retrans in
 endpoint_tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-6-521fe9957892@kernel.org>
References: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
In-Reply-To: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jianguo Wu <wujianguo@chinatelecom.cn>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, zhenwei pi <pizhenwei@bytedance.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lTOus+pRfZXHIltK845L7Aj+ND+bfeKF5GBsaPtYkzc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLm57kXVuaeSZqvuiHUpWWu1VxpU8vL1/xKNaOXrFF7V
 z5x4wrVjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlsaGf4pxRg8rDut8OWWSoO
 R1gUrz6ouvP7bshJLXceyV8qh9/3cTEyrP96oOLXiQtcNTuXydxcUr+Be8lHVda9km06f56v3Zu
 8lwUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

To prevent test instability in the "delete re-add signal" test caused by
ADD_ADDR retransmissions, disable retransmissions for this test by setting
net.mptcp.add_addr_timeout to 0.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3ada96472347171924ad3a6cf14777..82cae37d9c2026cc55466636d53a76f929a03452 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3842,6 +3842,7 @@ endpoint_tests()
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal

-- 
2.50.0


