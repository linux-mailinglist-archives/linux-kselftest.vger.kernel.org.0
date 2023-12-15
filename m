Return-Path: <linux-kselftest+bounces-2076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F55814C79
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F2286D7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0903A8D9;
	Fri, 15 Dec 2023 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf6Oc8SN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC343FB0A;
	Fri, 15 Dec 2023 16:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6836C433C7;
	Fri, 15 Dec 2023 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702656296;
	bh=wv16uUjSEMOy9J01JHL3XI8cunmlAlYDGAk/FjvlM4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pf6Oc8SN2HjIoPseWNAwLV1clz8tPavf5dvZwaa7jqMyb4F8lylFQL0tkecv54AqD
	 78qwXtAFg1sNQv05g0igd+OrYjvE+7Qrkg6WhoKVpivnl05Z8SElRb3/4Y9dHKhOCi
	 e5TkipUqUIGx8gBnmkX8XzibHsks908L44I9Wb8YgPaWtBIPv9CuuuqoblDu3RAbfJ
	 w3SvfqHfjgtRv2sq2TFvzXhw5qDf4dwqduxy6C6B8oQHNS2t9Yl/FzZRwyStU41Uu4
	 We9H1ycNjvEN1baWHEOzATXzUn5DHlQ1EQZv5H2zsmK4OtFXpZpgOsvPvipo+UN/Lb
	 Vtcwn8noiqlgQ==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 15 Dec 2023 17:04:26 +0100
Subject: [PATCH net 3/4] mptcp: fill in missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-3-91d20266d525@kernel.org>
References: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-0-91d20266d525@kernel.org>
In-Reply-To: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-0-91d20266d525@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Benjamin Hesmans <benjamin.hesmans@tessares.net>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wv16uUjSEMOy9J01JHL3XI8cunmlAlYDGAk/FjvlM4c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlfHkbJEIM8HM3FBpDE/k2Yrbs2Tu9fv3aUuXcU
 xIXAioazrKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZXx5GwAKCRD2t4JPQmmg
 cwIXEADvVx+1Gy4VOUmvA8g9dXGjSNGzR1izb7UbNpU0CoxKb6DtzPlCKMg/2+bqLgEKQ1a8dKX
 AJGiCc1Z8aWNraN9kjq3rBLssJ7XNF+eTmpHygj4syDVXaNxaM78btPqP8t2+Hd7NFn7q1SSqGB
 mE+pfUtdd3IWFKekpSmX0iCe0clSEKmAZFDCTOadSXdLL+YEnWWD3ekYmJStOne1h9RQAqotblo
 U5dgR2ftDckkDxRb5Mmi839gpO0rCPB41erRvhLArrXpTvaXdcOqdUYua4iNG6HKy2jjzKnW9fq
 mYG5kUeSoyGCHmkF4F+Ss7AAg4/R/xr/X442rdjXdb1MMSDMuIkj26PVTlYLdAjxjTm/tCOQfN0
 0LG3TlhfUixBQcOiYenGaib06SDemqMZJu6MmoTy7ByPGinZ0CUFMuvsSB1N9KKQ5k7Xm6pM6u8
 Kcx0M4zYkhar+XXXRRDMmv2s90tmfLeHFwEjNakfgJrctj1F9C2DqtBk93Yof2U4uYV5/CbHaL4
 crHXzbIL1aIY2hYsWKLtJoRbqJgCEJmOXUc66quFy6I/1AkSeXYMleYGX/F7cTl5xt58DxQbwpk
 kjVVhIoTRdNAvdPx6LLDmf6lnOYpZFGA/ZxpB3A9UpYP3XutdIHoHclbikfcPAcd3Lsmbbrow2I
 QkAKnKp0J8bBArg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

W=1 builds warn on missing MODULE_DESCRIPTION, add them here in MPTCP.

Only two were missing: two modules with different KUnit tests for MPTCP.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/crypto_test.c | 1 +
 net/mptcp/token_test.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/crypto_test.c b/net/mptcp/crypto_test.c
index 017248dea038..220414e5c850 100644
--- a/net/mptcp/crypto_test.c
+++ b/net/mptcp/crypto_test.c
@@ -70,3 +70,4 @@ static struct kunit_suite mptcp_crypto_suite = {
 kunit_test_suite(mptcp_crypto_suite);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for MPTCP Crypto");
diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index 0758865ab658..bfff53e668da 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -143,3 +143,4 @@ static struct kunit_suite mptcp_token_suite = {
 kunit_test_suite(mptcp_token_suite);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for MPTCP Token");

-- 
2.40.1


