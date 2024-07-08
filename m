Return-Path: <linux-kselftest+bounces-13311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A22929F96
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 11:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFA32834BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7C768EE;
	Mon,  8 Jul 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqvnYt0g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE041C69;
	Mon,  8 Jul 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432392; cv=none; b=lzTlIdl8oVh9Pe08L2BIklTVHiz/C9U7CvtcsjNYm3NhNqvIxnbvS8Gq2Nj+0pcYenr5RvKm1rkoG6HQpUYcg4VRmFjjFzzo3ro3Fd2ml609riBYUk5ec56ozkAtMjkdNj1/RJnTRgFG5F0A9/e64fEVY3QwBbMu9/gXrrvjdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432392; c=relaxed/simple;
	bh=tmlkinceJ217REpu6WVDDhCLWZe8vaBSsNuNDlMyUz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFVRIIeL/Jo3kLTMl826zqrFdcTOtlzkvpQCUNRCVG9smdUJA+I1Z9vvMcbJccOMen6u+7Wv7o1c6KXcvCZvoUl8cGN2I5gA6ogiFROJGAB2T+CT1uq29zHaHpFEFGleeXob6+XEgoh5tIics6DUwBnC/1AX1V/jy4UYyw29uUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqvnYt0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4244C4AF0B;
	Mon,  8 Jul 2024 09:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720432392;
	bh=tmlkinceJ217REpu6WVDDhCLWZe8vaBSsNuNDlMyUz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RqvnYt0gUOflVbMqsbjq/J1QSfkqhutdrFN+GxErg+PHVx0DNmB5X28Rw5q4aUWXW
	 /QS3WACw8PW79vR02pMwxiPUIgkIKL/g0fHonzc5Kfl82TkO+LoNqM+D3PdSj7TJ0a
	 e9xl5GQD+uTTOwxXID7FJvgDrwHAbW/GF/C1vSSsiaQSYS7lJcf13EgNcxbY9BFcRr
	 RCcR1aTTsv5GdmSTKjAgBVdYHtwtD6Z1iSBVBzcXF49ROQy2E3fXL5fKFZ1v+G1zDE
	 K+4zAAmB3WXKOx0zN1a000AFFFnrS+CMGmzzlpWE2dseuUhqmj1yiOMJn5tZ9uR9gg
	 E2GbWGBGXZKIA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 08 Jul 2024 11:52:57 +0200
Subject: [PATCH bpf-next v2 1/2] bpf: helpers: fix bpf_wq_set_callback_impl
 signature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-fix-wq-v2-1-667e5c9fbd99@kernel.org>
References: <20240708-fix-wq-v2-0-667e5c9fbd99@kernel.org>
In-Reply-To: <20240708-fix-wq-v2-0-667e5c9fbd99@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720432384; l=1192;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=tmlkinceJ217REpu6WVDDhCLWZe8vaBSsNuNDlMyUz4=;
 b=8EZU9HCeLG0gJfz3EK7kDGScbSgfQfmWRA40L/PAQO4G7Gx0gyUQ5m4FDoBDsDwXHiXseNti2
 30iBuaJlZ5eCGIcezGJloMEqMRIFTGo6uQUaMDQbSE1Vhr25P3/Zoh+
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

I realized this while having a map containing both a struct bpf_timer and
a struct bpf_wq: the third argument provided to the bpf_wq callback is
not the struct bpf_wq pointer itself, but the pointer to the value in
the map.

Which means that the users need to double cast the provided "value" as
this is not a struct bpf_wq *.

This is a change of API, but there doesn't seem to be much users of bpf_wq
right now, so we should be able to go with this right now.

Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 229396172026..5241ba671c5a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2734,7 +2734,7 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 }
 
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-					 int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+					 int (callback_fn)(void *map, int *key, void *value),
 					 unsigned int flags,
 					 void *aux__ign)
 {

-- 
2.44.0


