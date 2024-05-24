Return-Path: <linux-kselftest+bounces-10677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A85F8CE8B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 18:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CEE1F21E8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE2F13048B;
	Fri, 24 May 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyHC5U0l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF912C7F8;
	Fri, 24 May 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568273; cv=none; b=tW31iCZeMvPdy41KpjUNpW2pMEBsJ3qdDH9YLshKXXPzpilJPNNw6D6nJWSfjiC9jmicTATwZ3SWPT6zgEKbJEF24/3SFCMAxEuBzJAHhV3XEdIvN+ZnCQc5j6hfJ4Hoqy5igqsJQ/iMA+CVcUVc8pEIi8UENSMS5ZaufiKjdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568273; c=relaxed/simple;
	bh=lmxCtQTHyu0kw+aS06uj4cbDABnxfvXo+bEFeYsiE5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lp/7NzfdBxJ4cNLfZ0B2GKmii0x5naNzS5J6V6qpaQScB2xZ96Y+0pYSHi2hjUqUNV4IjaUewFe7MI/MN+D6qjRHlt+YLjYYI/oVPxY98gD9C9OgBn22D2GSTR2Ffvk7P1qcKISUgjO0Qk9wOu9VpQEudSs/uFv2ZMZfzh4r4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyHC5U0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81E1C32782;
	Fri, 24 May 2024 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716568273;
	bh=lmxCtQTHyu0kw+aS06uj4cbDABnxfvXo+bEFeYsiE5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZyHC5U0lWULT1nZ+KyfNDGb7NCNC2RkpnvXkmv8VwGvJi7FlT4EWc/fznAZ6P4fAU
	 SOoyvu4/mLzfwN19zSvsHKeQtEeA9HOAU6jz41H3RgcUjFq7b9k3zwXiPLEvdKAsba
	 14XibfJmvwFQMlWAZUolXMG21B8a6Gwo+Clw4wd7dyiLO5IJYiyHTilzy4nZg8+K5A
	 DZkPFpaKTNj0vdMEBvJni+KCG2cMupNyFX4YeXvTk/SCwl4Xs1A4+BDcWahO6RgyEp
	 eZ88jWvHrKIYlBxftIpa5tVAUyO8NTkeQqaprXE/GTb2dXWHDlDA1e+NOfhaTwUUj9
	 68ITkw0X4UpGA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 18:30:57 +0200
Subject: [PATCH net 2/4] selftests: mptcp: simult flows: mark 'unbalanced'
 tests as flaky
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-2-a352362f3f8e@kernel.org>
References: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
In-Reply-To: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lmxCtQTHyu0kw+aS06uj4cbDABnxfvXo+bEFeYsiE5o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUMDIGq202cDziEiiivGSTcaxZRm5rmgu8t6TG
 unZguP60HiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlDAyAAKCRD2t4JPQmmg
 c7cEEADkYpxFzx84a5Yut1is7xie+THY2wRF+PZBenv6fscupaep30FLcJj5jFoWD0/CvqYe3lE
 2VjxHCLQUWiiuNm5apn1jYqboO2lGOtVHbDRF7bUYa7jhpBFwWor/pt29etcKQj9cTT4wbQu8H7
 cjo7tIzn+w3m06UU5K27WikXKvJ/Oz/0u4mGyAupSbQzULmfw1gXj7pGyXLtDSgDQXF+uyCyV1k
 idBTjxJehGf87jgKmQTJv+6OUk83I0VBTgiHfCzsQxxIG5BCugj8iltDXgdl8DL3NDxKaIvjBqZ
 Fa2GUSUEKfP2EtTD2TGqaFsUpeK87ASpql2PyEc0ZTrdAQTy38pMKV8cJo+lTRCeFV3N2MDJGdD
 BD13MM+QoDMmHgSLWlKkhqb0+CPwTWK/SIc/gTZmCkWc586D441mT+7p8fMo6+l8dHAf6GUvPYm
 gHrbbFqYC8P/UjVOdRd1O7u6N+mOqR4+z9Yvj5j5PlUBeOcQsfUXF+Dy+YsWdz5ytQviArwnuzq
 LuV/I6rcE9vZSlQJhRe03RbMrNJPHig4YIDUrGjhh6jQxBPDfLWaMklH3iezr9y0lt9RQVeYERr
 FTWqCjrtsLw8XUzSQsXa6786L0q/5CLkEVVDKYQeev5U4FkUsK0uXlJC5m6JYdwoovEn7Ehqddz
 qHTXTGs1rN8Mtvw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are flaky since their introduction. This might be less or
not visible depending on the CI running the tests, especially if it is
also busy doing other tasks in parallel.

A first analysis shown that the transfer can be slowed down when there
are some re-injections at the MPTCP level. Such re-injections can of
course happen, and disturb the transfer, but it looks strange to have
them in this lab. That could be caused by the kernel having access to
less CPU cycles -- e.g. when other activities are executed in parallel
-- or by a misinterpretation on the MPTCP packet scheduler side.

While this is being investigated, the tests are marked as flaky not to
create noises in other CIs.

Fixes: 219d04992b68 ("mptcp: push pending frames when subflow has free space")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/475
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 4b14b4412166..f74e1c3c126d 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -244,7 +244,7 @@ run_test()
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ]; then
+	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -254,7 +254,7 @@ run_test()
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ]; then
+	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -290,7 +290,7 @@ run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 10 3 0 0 "unbalanced bwidth"
+MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"
 run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
 run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 

-- 
2.43.0


