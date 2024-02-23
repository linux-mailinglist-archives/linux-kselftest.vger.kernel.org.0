Return-Path: <linux-kselftest+bounces-5371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8A1861D5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602991F24D6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697DD1482F1;
	Fri, 23 Feb 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKIQCYw6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDAD12883B;
	Fri, 23 Feb 2024 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719541; cv=none; b=kn9sfnCGBzXsPuxQivDyxzeaJXIoMbvgL2wAUuo0oOBMQm4bxWBzt9qYUJjzSiFG7//sGr8miu9imTfPvBz9RVzbw4XEpNkNvvE+hEdaNAY3XazlpmGUluBXytXopkqA/c3Dh3/ZfabTWKlZjo9whV3l+cct78u0CUypXThNYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719541; c=relaxed/simple;
	bh=z+O5DtTWdH0ZKK/rzyO8SbI2hdiB5u9quPFzJzLc4tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMerL/rocs7Mt53IZ+B8+cY28Knijz70b7ZKjinMSvRp/evspvCEsoLdS56RCG9x/2vu7351Adv6mNNUtn8RZCxLy6yM46n5JCHNLEZLFTppy1JBiLj9H1e13kEaxqKKjwdtfQQ+LCTFpcZ25zcAG9yuEcomYPRtOUkcbl4WYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKIQCYw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD45C433B1;
	Fri, 23 Feb 2024 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708719540;
	bh=z+O5DtTWdH0ZKK/rzyO8SbI2hdiB5u9quPFzJzLc4tI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gKIQCYw6N2s6DxzUOudonCL7QgrcZqvtqXzOPUFOH+VxLOtrysHPu7XL+NlloZvEc
	 M70+tduBaCIt8No+omhZblUa/Mzl7oYvjMnnAzfu5RD3DDLd9Um3poxca4lj4KTyL3
	 hCNAj5bHlC1/CP32tnejlZN/ZKK6CSKe6uywv6P/S8EzyCX19tDNkk/XSonkjmu2Dx
	 QEgz0zMPsc+/0PHhLXLpTtqiu9x/jGG7slM4aKlk+KZL/iEIFzp84RojCd8X80b5/Y
	 69A8cdQEYiKy6PtW40M4LrEqtRz9cV3LnwunUGH82BBDidB0dkzipTgIvK8vS7ATtX
	 1KSUPM5CQ8zuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 21:17:53 +0100
Subject: [PATCH net-next 1/8] selftests: mptcp: lib: catch duplicated
 subtest entries
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-next-20240223-misc-improvements-v1-1-b6c8a10396bd@kernel.org>
References: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
In-Reply-To: <20240223-upstream-net-next-20240223-misc-improvements-v1-0-b6c8a10396bd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2321; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=z+O5DtTWdH0ZKK/rzyO8SbI2hdiB5u9quPFzJzLc4tI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2P2qSO3J+Sp8+XgiWWduwESPxAdtI98A3QFLW
 tTkm2+0VqWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdj9qgAKCRD2t4JPQmmg
 c4i/D/9+Wl4OazvQpjJdSwVqTdj9zFoIfpK+clG8/d5OEyq56TGiLr/+bIjT5hreS2Z35QP+F3H
 WmOeTKVDA5NKwBuXDUzPnn/BaLSLqS93PsSktND9EI7ME/FNnyPHJOcVyhWnJDA4SmkT1cg2p4l
 YPA7AaYMc26/Qw6fwjCPnK0xYwGwZnYmG/lF6wvRv0gs298uJtAN/A1QTvYDkcBlOSuy8brXliA
 ia+L68IoF8vKIg0RM1OTOHQqDai5/QmcnXUlKN/iylrG4zIUdYWwLlCFxJCpN4jNvQET3g+WsYm
 6QW1CCV/lNFDiR28G/Ce9DI3QUGa0fqVPAZy4D9/uJ4Tou/Yb5k3n9Kn/kLgRDxVWBzqngC+5qh
 cYsEl2j1fedeHR+TNX586VQbU2zeXXRgcUSUJvbhFVtFvYZWBytI3c89IZkmUSk7lhpHqtohVpw
 2Gr+yC/dwG5c2FuNn8H480LryzeCZKvc/d/fot2OYU1yBXQe0MIq4fYWqTcbdDGoTrgENp0pNk4
 OFEgIH7OkxAjXUYeJaMLkyCWWo+NVzC165nAbLs9Qxxp4nqOhm86WMWxDe8ef1NMsS1okqDAmPz
 nT3OmpKRp5vuVxG0onZYh2yUFCj97sZfWV7I77cmMxvMoUBt/cl9o5qKJMsK5dtXMbjRUi3McFG
 UXB0wgxRodV9cvQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated name.

When adding a new subtest entry, an error message is printed in case of
duplicated entries. If there were duplicated entries and if all features
were expected to work, the script exits with an error at the end, after
having printed all subtests in the TAP format. Thanks to that, the MPTCP
CI will catch such issues early.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3a2abae5993e..037cb3e84330 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -9,6 +9,7 @@ readonly KSFT_SKIP=4
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
+MPTCP_LIB_SUBTESTS_DUPLICATED=0
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -146,12 +147,26 @@ mptcp_lib_kversion_ge() {
 	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
 }
 
+__mptcp_lib_result_check_duplicated() {
+	local subtest
+
+	for subtest in "${MPTCP_LIB_SUBTESTS[@]}"; do
+		if [[ "${subtest}" == *" - ${KSFT_TEST}: ${*%% #*}" ]]; then
+			MPTCP_LIB_SUBTESTS_DUPLICATED=1
+			mptcp_lib_print_err "Duplicated entry: ${*}"
+			break
+		fi
+	done
+}
+
 __mptcp_lib_result_add() {
 	local result="${1}"
 	shift
 
 	local id=$((${#MPTCP_LIB_SUBTESTS[@]} + 1))
 
+	__mptcp_lib_result_check_duplicated "${*}"
+
 	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*}")
 }
 
@@ -206,6 +221,12 @@ mptcp_lib_result_print_all_tap() {
 	for subtest in "${MPTCP_LIB_SUBTESTS[@]}"; do
 		printf "%s\n" "${subtest}"
 	done
+
+	if [ "${MPTCP_LIB_SUBTESTS_DUPLICATED}" = 1 ] &&
+	   mptcp_lib_expect_all_features; then
+		mptcp_lib_print_err "Duplicated test entries"
+		exit ${KSFT_FAIL}
+	fi
 }
 
 # get the value of keyword $1 in the line marked by keyword $2

-- 
2.43.0


