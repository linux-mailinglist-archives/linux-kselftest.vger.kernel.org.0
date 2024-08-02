Return-Path: <linux-kselftest+bounces-14700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A4E945AE0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 11:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A76B1C22D3C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694ED1DB423;
	Fri,  2 Aug 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3OlVK/5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C81DAC69;
	Fri,  2 Aug 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590619; cv=none; b=jCwIPTIMsMt5Pn8xP5sPAeS9sPZlMWcgGLOKTN9B1thkl7gzGjrthzfFVuPqMGQ9bOZBOT/AA2dBPt2nccgpoma2AKpFOduc3uc/8BmNMfGXEn/3u1Kj7GfUyJt/TymYqQe/XIkLYOqc//+ssMvQyngPc5nAFcDaDWfttk7vw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590619; c=relaxed/simple;
	bh=rmEj5ulvtkEJHrxNtdz55Q8b0RsSW2MR3BW5lIW4X60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPTKPkX5yqDkte2A3TlL7z9xAp3F+964IVNWxZ175dN8w5t0JBJJr716ui/ZlyEKhofqoHM+lp85888a7svWee3TxpI6FgaNcrgEW0uGcDlg76lIMRs+ctrrv4Slai8hVniCtSL3F9GUvap7tArYpv8IkO/TxAYvFlXAVZNpMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3OlVK/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB915C4AF0A;
	Fri,  2 Aug 2024 09:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722590618;
	bh=rmEj5ulvtkEJHrxNtdz55Q8b0RsSW2MR3BW5lIW4X60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c3OlVK/5wUNf3+KzLZbiwxPoAz7Yw/1bxN0htJdH8bwqhU2dHXwN15bHTuVtYEBDS
	 dFKDFYyaLdypTsiSGcfP6Iu46/pmxNjGcy1IN/0tRLqO/zkxCphuRsgyrcixhDMSO6
	 m0g8MXN88ITYf5SEnOHEXoXPjltdVNSIuekyFFfnmJyTr1nOg/4/jcP1dbWPb4TlaV
	 CZtT3xtJRXn33/hE652R5LyVaSwlflG3GGi2OyT7nok43FxYeLqt+LeSwiw13gRY54
	 Acw/U9wYS1scanbEurqnlgvr53F0PowinS0mqjQWyjO1vc0O0JDX3QFLXkPs3W4+vo
	 7TFP6jcFtr6cQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E2C3DA7F;
	Fri,  2 Aug 2024 09:23:38 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 02 Aug 2024 10:23:25 +0100
Subject: [PATCH net-next v2 1/7] selftests/net: Clean-up double assignment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-tcp-ao-selftests-upd-6-12-v2-1-370c99358161@gmail.com>
References: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
In-Reply-To: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722590616; l=947;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=CTRIdhA/fNrbMRjaJSddnxfQDObvWmFHJBusF1leQ7c=;
 b=l+z5beHfW4GBJVPRLx8uw4bC1utKuI8Z3TOsBcK2nOmTx98ET5t+Fa3pwezCAA6womaBoEYsT
 pjhEzqZsTKXAiYkh9IbApDIF7dBFD3EKzzSbCwbLF/ksNJtHnQnzrR0
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Correct copy'n'paste typo: the previous line already initialises get_all
to 1.

Reported-by: Nassiri, Mohammad <mnassiri@ciena.com>
Closes: https://lore.kernel.org/all/DM6PR04MB4202BC58A9FD5BDD24A16E8EC56F2@DM6PR04MB4202.namprd04.prod.outlook.com/
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index 15aeb0963058..0ffda966c677 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -379,7 +379,6 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
 
 	key_dump[0].nkeys = nr_keys;
 	key_dump[0].get_all = 1;
-	key_dump[0].get_all = 1;
 	err = getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS,
 			 key_dump, &key_dump_sz);
 	if (err) {

-- 
2.42.2



