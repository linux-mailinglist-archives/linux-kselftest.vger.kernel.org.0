Return-Path: <linux-kselftest+bounces-10678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A648CE8B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E7EB22390
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801F130A48;
	Fri, 24 May 2024 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWwk141V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8E130A42;
	Fri, 24 May 2024 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568276; cv=none; b=sJUNqiY1MBtFvCqTPlweRQxPYvlKOK/jx045Crpt6G9+xGIFpwuD48aLKBSir5/q4DBMHkhFU6FSLf8uj58WkR+dJqkEQPbVuBJaWIiKKK44AdU7fTun4xZ5VDjiUNfS0Ggz3QuYCg9agd4j4gEYWF/w0EgtPKX6NaKmqRjehd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568276; c=relaxed/simple;
	bh=LBOws/Zh/7AplUcMrmYpeecU94L6qJWYzHbTqUIchzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgmXWQUyT9bm7Othu1ncLA1PxBzEHvPRHVUarLZauOfEDyGIB4Ket0CZ2xZ/m0TxJkXZFg7rD5RZC69uKjSqcLh1Yag2dPWBzJGHzLF8N+q0FokyqmMnTVjfi5HHCzIn5lSexfXlhU06h/oojb0wl9ztp0a8r9rVj4qUv1tV+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWwk141V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F20C2BBFC;
	Fri, 24 May 2024 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716568276;
	bh=LBOws/Zh/7AplUcMrmYpeecU94L6qJWYzHbTqUIchzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZWwk141VvoP4mem2p1m5PNaygHVLUojwVLLcFsrdrXrOgC3JaKyRKYQ2Jy18RVSYk
	 +Kc+MGL4mJB5KltwU3wnhFaHNEo87pbLi836KArX8fc+BZy0A/vgls4kUtwfsE0ZAL
	 LyrQ4ooTH8do2Et+QdZMbW2LanAApThC+rjx6tkrRMK4fxWp4HA+JV167vw1/zjGlq
	 OgMX/7LkAV8DfbR6SD55HGKG8zYk7A7IMA3xBekDsIGFjQV6nX2rwVybasXBjuxZnI
	 MVOR9gW+i2Eal0LGU20R6/RONLBPdj28lHcdf01kAta8Ph57tJ3EA+96uF9jYzRm+V
	 64c50GcsTs05Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 18:30:58 +0200
Subject: [PATCH net 3/4] selftests: mptcp: join: mark 'fastclose' tests as
 flaky
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-3-a352362f3f8e@kernel.org>
References: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
In-Reply-To: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LBOws/Zh/7AplUcMrmYpeecU94L6qJWYzHbTqUIchzI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUMDI70nhBvwho5Lq8I0fOfOneqcQCtLhPxk5t
 VYLXdAX0xWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlDAyAAKCRD2t4JPQmmg
 c2ImEADY6EfqvQRqsMbHdFV+ubnAHc+fDGTjNTbDodMoJ/rZfy6RiALAlF6v4/U8ZZ/eIDOpFuq
 xeKFBT2Jkqh0AUo7K1rhINhh/A50gZ7REC0VCEiTORVVJaK9Hf72ZWE9wqUh+jDSxC544SE7tKb
 H9yZKNe5J0rs0NA2ijxAzolYT41aspy27mfvwV+Fa+U7lvFBqfzoXpOro44fTSRHz3PY+6IDl+z
 cEPDcvtfroMwdmC6+/ukEpwsBWfr4/aTMHbY8utKnurO25+jLa2nqYs95jQNV2G9rFO5mQwYL9l
 LI4vU4BenOhWB8LUTpu55K5QyAFJOyLS9tKh6ldHjCimoAxx83mpQBuLxD4UGiOicEJ8Ke+c9uB
 O2WttQmJuOP511urjYXzCYg+S4hwVfxW741Qib9gZU4NjpD+3njwTMI/CUUdK3Enxi1QJOmqYjz
 QStGghQ/HY3IwiP62Chs7+OgOzupOmZ8phSxlCX6z0aKXyxEl0gPIi7elt+2JZJ0EUf60IPpTs3
 WkP0DRrxBxXav9w2w0ViOnnprjwGinPDd4oMVGRsTiHOGEcB8Sr+rmuEUUmCT+e2yb3Sm/83QHz
 b5YBZ/hVVgDogxLLyDS2WxG8TEn7JF2AM7aB+N2Mxf2Gd0n4MA7L3E2rBrzsv0UoaEwV2qyEic7
 jkltEFTiup1anCw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are flaky since their introduction. This might be less or
not visible depending on the CI running the tests, especially if it is
also busy doing other tasks in parallel, and if a debug kernel config is
being used.

It looks like this issue is often present with the NetDev CI. While this
is being investigated, the tests are marked as flaky not to create
noises on such CIs.

Fixes: 01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/324
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fefa9173bdaa..b869b46823d7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -261,6 +261,8 @@ reset()
 
 	TEST_NAME="${1}"
 
+	MPTCP_LIB_SUBTEST_FLAKY=0 # reset if modified
+
 	if skip_test; then
 		MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 		last_test_ignored=1
@@ -448,7 +450,9 @@ reset_with_tcp_filter()
 # $1: err msg
 fail_test()
 {
-	ret=${KSFT_FAIL}
+	if ! mptcp_lib_subtest_is_flaky; then
+		ret=${KSFT_FAIL}
+	fi
 
 	if [ ${#} -gt 0 ]; then
 		print_fail "${@}"
@@ -3069,6 +3073,7 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
@@ -3077,6 +3082,7 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 0 0 0 1

-- 
2.43.0


