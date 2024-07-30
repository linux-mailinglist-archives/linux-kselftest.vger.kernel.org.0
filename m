Return-Path: <linux-kselftest+bounces-14417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA15940436
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 04:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1475C1F217CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5C6347B4;
	Tue, 30 Jul 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ+fmXPh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4DA18E1A;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305609; cv=none; b=QnuFoqCnDSSqmXn8CSTgDBm6YiDhLKcmVDkSlzu/oJD8exWVt/MUhsBHZcjo6x6Fi30xOF0JsIwuKpuYCJ3htE04LDZBKoCu6Eei4FzHl8t8QRPL/Rw+3kC/o9ucNLL2UIUtcZhfR2+BK7gW0Dton5wtdhYceuS+QPyMxl0emq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305609; c=relaxed/simple;
	bh=iJZ9zTG4fk0rsgxL8Y6JD8dRvupTDSnrqRBlsUAPKao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nH0DtlIu/xLnJ238QoueW9uhxo1NGfsbpVxBspbqXZAmUbTaSJYbbEbwgyN7e1vCEnUTNifh1XapeGZA705M0koz+C0jpSDkrugpEYrpEmP6sIqauQwi3kwdus0Vgpq86QnCxrK9GHEANEdmepIJ5jh/XcSlguiP3iqreifdoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ+fmXPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E62DC4AF0A;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305609;
	bh=iJZ9zTG4fk0rsgxL8Y6JD8dRvupTDSnrqRBlsUAPKao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bQ+fmXPhU+UU6kZF6wPgg6F1EH77lLE+QnO93x1Aknh3Hd4OtaaX9IeX4aUV73G7f
	 +7YmIMVtdU34hRU21gbgWlXjmvVdR/0wvDj2YFJx3IUVNinZ4wJZwiUFyW9+3P0Lt7
	 N+uSP/OekxWD6r4V5Kii7ooNlPXnfv6mmWhGuauFgL6/WKYodKDz+6eLiO998hj4gT
	 Dz0hzhh5rk5fUCiyswR/uS3GtKRlwHGnh1zrZhokghBzHyhoc3P/8syiy/epDJz7S0
	 edZMCNB8dIX+qkNJJSaHFvSfRNsrPfRcTbhym3UWXTctyZXltZ2PzYcn14XWqHiF+l
	 cLFQ52s5ikDsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DD7C3DA7E;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Tue, 30 Jul 2024 03:12:15 +0100
Subject: [PATCH net-next 1/7] selftests/net: Clean-up double assignment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-tcp-ao-selftests-upd-6-12-v1-1-ffd4bf15d638@gmail.com>
References: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
In-Reply-To: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722305607; l=892;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=hpiQXULByEdkrNOpF87CEOug6A+zEYMb7YuJRtu3j8c=;
 b=o7DjPek6AH76FlAdwTH7t+MzgLlLvEmEaHEGU2rGHBnCOWYuBPljaNXC3/HuS5y66DWhBHCr4
 JbSIl4GWHUDBJyo1HB0En0xKe05WPsB5kzBVd8bD0TuzbAWp4SihVZe
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Yeah, copy'n'paste typo.

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



