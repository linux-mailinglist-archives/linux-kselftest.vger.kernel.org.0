Return-Path: <linux-kselftest+bounces-43606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3891BF38EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1E5F4F70C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41753337BB6;
	Mon, 20 Oct 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB2royZI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672B337BA7;
	Mon, 20 Oct 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993638; cv=none; b=Zl8n4xHJpwe5gtiwSTDRyOjWaGkMAjLUGgJpDpmic/s5hmLbD38D9XXYdSdITbQ7okojAGSsmz8L9fJA4keJeaBiNtRW5tZHenFVaz9W1DfXh3rhvvHADCS/ZE6sPfT2MbFxg7u/oT2INPZ9Bi8nmvYo2U56zJkQ3KPv3go8mbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993638; c=relaxed/simple;
	bh=Ex6n0S48Ck7Plo4nY6ioRrqLE/WG/09KNPUA0FObYxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/wHf/PEkw72xEZsO3fYRWV2VmEmmXiofUfwaakgDXHFzu3DefgEoT5pQso0aXUqntRXU3gJbBf7V60aoN6TNglc5M4UQI6lAWeJWzRmWVw/kvn0qf/FBiZBBWZUVdzlMsGQo4GgDnX43kiM+U1DOZf1R4QKeB4chy7DVwOv2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB2royZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B6BC2BCF4;
	Mon, 20 Oct 2025 20:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993637;
	bh=Ex6n0S48Ck7Plo4nY6ioRrqLE/WG/09KNPUA0FObYxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CB2royZIFoehWRr9hLbMLoLflvZLDyYrE56lHWw04MEq3RbEAYlKU4UHTPIddfiTQ
	 Na2n2JNLkK3PuE46xQrm6h8zRNApOopwRv4rQvbK8J7bVCSuV0eMKJUbR25lqZiXlR
	 IZ7NIG/GxDsSl448WL1xkgkUJczolhIuqpHMSFcHQtQmM9dF6B9FJ/IZt+VaoXZGIW
	 wGUeNibl7sEcx248zPvgIoLSAWR5N8ftC1b2pr3FMaESC3laZaqL7P1U0UKg0Tdydu
	 Dj+Ua+HBil+41Or4zpS0MbqtsyR8Er3uRKfIVt7n039PuzR0RHDFyFnUSQWFDRcXwu
	 2NsAATYLfmclg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 Oct 2025 22:53:28 +0200
Subject: [PATCH net 3/5] selftests: mptcp: join: mark implicit tests as
 skipped if not supported
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-net-mptcp-c-flag-late-add-addr-v1-3-8207030cb0e8@kernel.org>
References: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
In-Reply-To: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ex6n0S48Ck7Plo4nY6ioRrqLE/WG/09KNPUA0FObYxQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK+LQyTuMTkUjjXyC2h8q/MlaB1usfeu6a83OtjF2i0O
 XmLV7lNRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQinjD8FTCtuetRue+ApqvI
 2UvbfKLD5p45NdFs0/SS3/MSI9pecjEyvEzZp7t+mqiOWK/iymuZVTKrn+zI+bM96//WP27xM2s
 9OQE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: 36c4127ae8dd ("selftests: mptcp: join: skip implicit tests if not supported")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index deba21ca5a97..d98f8f8905b9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3939,7 +3939,7 @@ endpoint_tests()
 	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
 	if reset "implicit EP" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3964,7 +3964,7 @@ endpoint_tests()
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3

-- 
2.51.0


