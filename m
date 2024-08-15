Return-Path: <linux-kselftest+bounces-15454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C115953CA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DFF2846F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00BE15381F;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f93/Aah9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F11537D9;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757569; cv=none; b=CLFrLHgtXW1M1doigMbkmb8lwHjqYnj9JtFgQsZG5fqbzrx42bjJQXqk4eK032Zkkib3jG2uouuzHruA3jHXzT/CpxwSUQBdpb07YJjNX/S1Ki3YSBTOXPpuo9j2scHYGXqwazLaEwmbi/WM96fK9pySTDUJKPP4VWu3acedcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757569; c=relaxed/simple;
	bh=rmEj5ulvtkEJHrxNtdz55Q8b0RsSW2MR3BW5lIW4X60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTpwP8AOMUvxvhnZmKFKzOHf6bjpEpOSemu+E1HQErZurmTPQXnJVdL5tGB0+KIKP8036EH9f4Q+yJyRBBUeHXfOb7OovZ9Cy3VggDDUnjKPMrL5UZv/up+kGU2Yn7uGm8Bcw3Zuw15slzi8paiNgpp9KI296weOePPwIngqb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f93/Aah9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4195EC4AF09;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723757569;
	bh=rmEj5ulvtkEJHrxNtdz55Q8b0RsSW2MR3BW5lIW4X60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f93/Aah9JfjVS53wxU5TpRGuKmiRvgQwaBb3Tow6pKsCod1eBkvdpAjnsLk7oSf8n
	 9OT0OM3zLGW//AjrRAgweDwcoJsHpc0nQNTPjf6m/ng8ivPObE+z3DhSdOsbHPnG12
	 8tYw7x6hoFAohqunI3wg37oAQHLV1NnV9s9YM+juw86VR8ezf0ahIRloTfc3R1sEZv
	 +UDVPwL5NEPlGL5y4x6E5FYMnq2JJ5Xv5h3ahzVOqVm3+4cLKe8HbjMnRLUuqn8buu
	 +zQn7qtoQCiOReaehhWJ60K0C6oVPedfl4OvgUOCEo11tSITWClJlwy724vkktfM76
	 BSGJOTmwohp3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30415C52D7F;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 15 Aug 2024 22:32:26 +0100
Subject: [PATCH net-next v3 1/8] selftests/net: Clean-up double assignment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-tcp-ao-selftests-upd-6-12-v3-1-7bd2e22bb81c@gmail.com>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
In-Reply-To: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723757567; l=947;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=CTRIdhA/fNrbMRjaJSddnxfQDObvWmFHJBusF1leQ7c=;
 b=/LphgbvXc9rQ4yl6c9ErfZY21kxsdsXZlxguxNFsoPX0yekrKWFTUI0J8Tmu8WS/qCQzzkvRc
 bkFb1qeakKXAYAQ7hVJm07Zb5E5h223i+q/Wj+UVmY+4FOLQSTwN+eJ
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



