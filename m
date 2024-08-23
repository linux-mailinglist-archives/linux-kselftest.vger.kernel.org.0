Return-Path: <linux-kselftest+bounces-16190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C7E95D8FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 00:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6030EB21103
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73D1C86F6;
	Fri, 23 Aug 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7pVsMrp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56431922F0;
	Fri, 23 Aug 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450719; cv=none; b=tVkUKNr5op6lf+eX54NfjOQTM9L5PBYmiyXnfP12PLWOnwzpWh/27Hr5KH/q8/xsJNsax1Lxy1FNq0gN8VcPMYbacfW3c3HW9E5uq1D2IaZN/QO8nPOTQIShiD6yKJ7RoiQgkLrSGL2mgzEmvg3XxALiwKu3kRVvYhZytoAS9fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450719; c=relaxed/simple;
	bh=rmEj5ulvtkEJHrxNtdz55Q8b0RsSW2MR3BW5lIW4X60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8kx5+eRRZGLvuzdAnfMRiij+zg0gSq8Pl3QQ2mgug8Esx1dfUcTeCWeyALP7cbwg4m8yf99FSGmK0TvyATkPktWVBgHaw4N2yBdJU0GzepOMuiKb4fQR2wtb21ZX4ZwNRv0pf57s77BO000u21jK6xiT4PMf8saw8gwuTPsTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7pVsMrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C122C4AF0C;
	Fri, 23 Aug 2024 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724450718;
	bh=rmEj5ulvtkEJHrxNtdz55Q8b0RsSW2MR3BW5lIW4X60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E7pVsMrpsSZsyXrflZ4tFeQALek6zK8r+iGbHS1RChCDgWmczAvpfiTrGZtr5+Yvr
	 OtukQrTu+/60Ek8CI2ufomi5uI64kaNyAhqBzzFz/s88qWnSbuGb1kE2YlCSsq2vlN
	 Xf9R968fHlA7gqt/DfJRa5Ljax6C9LZB1ZbN3TqiYms2HLMnaIaR3mzYaRjdARR6U6
	 UUOTGujoa4o8IcRqzYOPQR47uOSPNkizFmTin115hKq5az//MApwRXbDxnUfVBIRPv
	 D+oZbIuY3EBdw8kNRjqoOTcGBMwcqmeBucr6bWf03GrxRqy/n8u4pByRxwL33T01ho
	 Df5HVdwBBViAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A93CC5321D;
	Fri, 23 Aug 2024 22:05:18 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 23 Aug 2024 23:04:51 +0100
Subject: [PATCH net-next v4 1/8] selftests/net: Clean-up double assignment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-tcp-ao-selftests-upd-6-12-v4-1-05623636fe8c@gmail.com>
References: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com>
In-Reply-To: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724450716; l=947;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=CTRIdhA/fNrbMRjaJSddnxfQDObvWmFHJBusF1leQ7c=;
 b=qiTQgBS+fVc2fssLpqStyjQOkOOrKu4E8mujH9Mda4q8LlfGqDUwg0i4Zp0facIFK2xao04GY
 GYmR7fMy5HvCOSHSOsbDGLx8GExYSQpp0Z2Asoc9U3BEnl47ACEXo/M
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



