Return-Path: <linux-kselftest+bounces-6123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428DC876CD2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C478D281268
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D999560EF7;
	Fri,  8 Mar 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8tnEfSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07860EEA;
	Fri,  8 Mar 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935843; cv=none; b=WZekmwdYMDeOxouZFVGEEoAMb07Gec2BYiifRzsC0x4KDXoX/WuLtCnlscrwiT8aWy4bGDyOTUVgKoSHeCoEINjrccgQNslKoAEgT5NDOU7gHhGZiwLKXeg4pgBVLqFhNucAzMq196mK3R8ng5dJp28SzVOCbHTLXgzM/4ZDa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935843; c=relaxed/simple;
	bh=5iHWN71u8FnrK4su6Pxr/Ce0MriuDLNYlOjgzzlB7lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvkFS63HS3tnI4Dc1eJBrDBuwP3GaPHKFsaaejzurxCHxvmuy7xe2nJt4529MydQmpLzvmynGjXdSjXbqzLEZt7aSPZfJVHOhnXG8Lt88Uu+jHZuV+D15HTLq1Rct3gh+SKuZMXxgEVIXD+vZjXISm5JQeEuRb5ovShmvx5HtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8tnEfSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68607C43330;
	Fri,  8 Mar 2024 22:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935843;
	bh=5iHWN71u8FnrK4su6Pxr/Ce0MriuDLNYlOjgzzlB7lY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A8tnEfSBg8Kwq1Y/Bs+IixZI7dw75NMN2yuJMbs1erozPbmNPLm5uY9nDXuAw4k27
	 yEZXINuJrOA+py4fi7c/jH8tFiuR3D91OVB/d3Gvgk/XTBJmtmCqrCjD27MdfvWn4F
	 z7AKInBBFmHliTCo1AFwIHSnje580W7djsUTHTS/8+qokOdUV8rDfjwfwRLP2New63
	 HptGNPcRo05X10BMwr6QkRF0X0xJN8NSzUhK1r2Pxsqvxh7mxWsYaxv1YoMcHmc+qE
	 9jI2HlFxyQEBx4zMdRmnLtBvVBzoY8YNGDtdGuEV9Ynm3c8tWsDCFhThsjWqzr4fk+
	 59/JJogKpf64w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:13 +0100
Subject: [PATCH net-next 06/15] selftests: mptcp: add print_title in
 mptcp_lib
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-6-4f42c347b653@kernel.org>
References: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
In-Reply-To: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3139; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=c/Oh+VCrsNdpQsgZKz9EFklI8GqtmsKHi5z+kv2litY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJD7ExCtlDuWREcVMp9xcn1281k9X5EM/ZN
 RQenMrK32aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 c2YPD/93Ko4cF68+Bg5GbARE8tDdFC9mUXn89IYoFs2ySwe4Id1kAycSKI+pGQMtyizyfFGoA1/
 +FoSD+46RnrFapRBWFduTd6J5TGqmefRfBOaVNSnnjmVGyggBGV7HpTY1m5dOCXYkiDC8oOJFq5
 m6YvZZg1L33n+TfduX+XiI+yCD+B4/AhMMYEUQXT186BLIHWMNkAyl8f68GCQVBJ53DrgoC4tPB
 W1gDwJg/k5D35KIDuisENjmPEKWmVN7eypvaN5UHBG84w52VqkZr26vOPF6jvXgD9X3YkgG/UdB
 7K3g+YDJ7uKEvqcNLRPsBnRV14S73O10gm3J9/wy1Jeigj+vqXXfUPdulilMh9WdePXzDA6Oohw
 hfV29Q4ohPAJDmnUpSdVXQewt6cU7hjIrYY6YmYDyma4kt7gMGpzlgrxWo6oQLyi+fDEG7PC2T1
 rko+K7Z52WXvQjTXryV/Dr0s2ngrgAt1mO8Syx6uecql23x0Cc5r5hdxsfmYQcEzaa8WR6pszJ1
 AiA83X9ebf+axkzNkGw5fDUYgodfvSpKbin3wMj/cFejMyKeKJKxXf37C+1I78VCZ35Rob2oIGd
 KoypXulzQZPv5ZCdrz5z8s9nv1BJGbXisEMQOYd7NQgcnW2FMSkUZwDuIKOpT7sSzp44wNb63WM
 BOpu51YrUEERyOg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new variable MPTCP_LIB_TEST_FORMAT as the test title
printing format. Also add a helper mptcp_lib_print_title() to use this
format to print the test title with test counters. They are used in
mptcp_join.sh first.

Each MPTCP selftest is having subtests, and it helps to give them a
number to quickly identify them. This can be managed by mptcp_lib.sh,
reusing what has been done here. The following commit will use these
new helpers in the other tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 ++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 10 +++++++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4ef0d5ae9dae..2f34e2b9a1c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,6 +48,7 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
+MPTCP_LIB_TEST_FORMAT="%03u %s\n"
 TEST_NAME=""
 nr_blank=6
 
@@ -169,11 +170,6 @@ cleanup()
 	cleanup_partial
 }
 
-print_title()
-{
-	printf "%03u %s\n" "${MPTCP_LIB_TEST_COUNTER}" "${TEST_NAME}"
-}
-
 print_check()
 {
 	printf "%-${nr_blank}s%-36s" " " "${*}"
@@ -232,7 +228,7 @@ skip_test()
 
 	local i
 	for i in "${only_tests_ids[@]}"; do
-		if [ "${MPTCP_LIB_TEST_COUNTER}" -eq "${i}" ]; then
+		if [ "$((MPTCP_LIB_TEST_COUNTER+1))" -eq "${i}" ]; then
 			return 1
 		fi
 	done
@@ -267,14 +263,13 @@ reset()
 
 	TEST_NAME="${1}"
 
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
-
 	if skip_test; then
+		MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 		last_test_ignored=1
 		return 1
 	fi
 
-	print_title
+	mptcp_lib_print_title "${TEST_NAME}"
 
 	if [ "${init}" != "1" ]; then
 		init
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 63abf4431993..eb740a2f7898 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -10,8 +10,8 @@ readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
-# shellcheck disable=SC2034 # unused at this moment
 MPTCP_LIB_TEST_COUNTER=0
+MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -412,3 +412,11 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
 }
+
+mptcp_lib_print_title() {
+	: "${MPTCP_LIB_TEST_COUNTER:?}"
+	: "${MPTCP_LIB_TEST_FORMAT:?}"
+
+	# shellcheck disable=SC2059 # the format is in a variable
+	printf "${MPTCP_LIB_TEST_FORMAT}" "$((++MPTCP_LIB_TEST_COUNTER))" "${*}"
+}

-- 
2.43.0


