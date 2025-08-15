Return-Path: <linux-kselftest+bounces-39117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76F5B2851A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 19:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D5AE490D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50106315789;
	Fri, 15 Aug 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoOQbkcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADD315788;
	Fri, 15 Aug 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278951; cv=none; b=nbtnSugAsQyd+kYuVW+lSqZD/R1DLMvVxah19i/w6eFL85qC3nWhvgK5yOUB8UGUrLd6gSNUtiiWPbmAc91f2fOYPq3sTPnWm0SioOhqSNBZa2vZZSK/Vz5qIe0an062KGS2k8oNbh992eM7Tx694GfEM9xGSmQ0tzUnpjGSZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278951; c=relaxed/simple;
	bh=e6SjnKvlM2L9QU1I7NMIYkV0u+TLc37nAIXkPyJli0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DgBh1xeS9nFwv0vr0b2GLDq3YgVkTYm/Nle1wPOav6GkukdrrK3baTf6t8Lq7fEanM0cp2FCjXljwbmRxIrmPn0d154Y4cKvjO2wGaFiOfcYKu8rHFNR7lo8/YtPf+jOu4l+zHT1N0bIPG/1nligrOITuj1kWqSLjIpOLJoNzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoOQbkcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7334C4CEF1;
	Fri, 15 Aug 2025 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278951;
	bh=e6SjnKvlM2L9QU1I7NMIYkV0u+TLc37nAIXkPyJli0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uoOQbkcCLun8AiXIfnmQXHlHAkkSMyjmuyHtabMxXbQNu4aRLBI9PFESb/O3ypMBL
	 T0eV/zfqldcFNvHfJ7PXdBCdXKtcTUij0UhfEkG9Wu0Rx5fjSviC9Vbax2CaYcv9ip
	 TxkdBdZ65kJjyMhPFtVJquLqLY/2zC5AWPZl0UB7SyOMel1lOTAgSeEoOcDNfcg9VO
	 yHxSGhbi3LYQBcw8uSIm9v2GxEY/WSNZNoXINZawCeRm8FXA8baS65vXSQxUVscP7C
	 KDH6PVsEMWm7KKIJCNEmX3VJFRG/6LbwYJPr3b7WGvnXHgRl00VM+Ee2HCVBjF3eAM
	 BB5VyQgxjYEVA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Aug 2025 19:28:25 +0200
Subject: [PATCH net 7/8] selftests: mptcp: connect: fix C23 extension
 warning
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-7-521fe9957892@kernel.org>
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
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=e6SjnKvlM2L9QU1I7NMIYkV0u+TLc37nAIXkPyJli0g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLm53l+Tk741fiN68LPU9tu3j11ije98wX3y2MZ+o6nW
 6w4ldUbO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACby9Scjwwou6QrNOVslvuw6
 /P7k/WRxudcfUhd2txU8KZhZUvJL/ATDf/81bjM+1jI/NzuYtf7bA/bLh7Zvm+xdvvSeCodvxLt
 zP1gA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

GCC was complaining about the new label:

  mptcp_connect.c:187:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    187 |         int err = getaddrinfo(node, service, hints, res);
        |         ^

Simply declare 'err' before the label to avoid this warning.

Fixes: a862771d1aa4 ("selftests: mptcp: use IPPROTO_MPTCP for getaddrinfo")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ac1349c4b9e5404c95935eb38b08a15d774eb1d9..4f07ac9fa207cb08a934582b98d688d0b9512f97 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -183,9 +183,10 @@ static void xgetaddrinfo(const char *node, const char *service,
 			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
-again:
-	int err = getaddrinfo(node, service, hints, res);
+	int err;
 
+again:
+	err = getaddrinfo(node, service, hints, res);
 	if (err) {
 		const char *errstr;
 

-- 
2.50.0


