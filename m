Return-Path: <linux-kselftest+bounces-9594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073C8BE423
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0665E1F21A0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96C1C6898;
	Tue,  7 May 2024 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDbde6Nw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF01C6893;
	Tue,  7 May 2024 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087999; cv=none; b=paGhE1bEagRqhEXm+URWQ4b526TnzSvWE3h5Zs6ltgknQQuTxhKHT407YGLN7LXCCza+zp+ZdTMEcS+9Spk7SDJQW7wGfxuff+Ur6k2QOujujO4w9mIhrlxzkE7h2Mc897q+u0bUsRmaQP7OgZF/40kmagfLe1siiOsVFrbvHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087999; c=relaxed/simple;
	bh=xAtYvtTO7UEzvYvc5IhP8kn6hurkiD+l2/2akEDg1/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CEbkt1tq88+s86D3wZ/pjXLNX3w/FGk6hUB9DE1u9nnCzyTW04fNtkxS6ou+5e2JqeXpJE/t1NiwX8lUA/FuhoK7Fagsj5XUHtOQxbSFTk8iNiwFGwjStG5s0/2AMBC1TFyRHouGeU/Ql66DISKGgGhlDO5rjbXzo3KPIj6in5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDbde6Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F7C4DDF5;
	Tue,  7 May 2024 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715087999;
	bh=xAtYvtTO7UEzvYvc5IhP8kn6hurkiD+l2/2akEDg1/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BDbde6NwGP6cwSKBiTBhG14oNtmtY/tLjFqFuOtg1YwRGbae/iWzdzhUpJ3O+6mkf
	 KRPU7h/N7GTCV7klV2PEiQDeayIN3YQota8Qr5nTWnW95fFIGyZlx5usw2r7UtG/h0
	 Jg3U738DniL1sQ0lTd69YRg2mF3wqxRMx3fAQw7geWBWGhtoDMohxg1ybeONEtViT+
	 EXBNOFzddIuXHXI6IfkcDrCSYmoQWi1uEDlrGxby9Asi6ym6al6pOhkauewYPPup8G
	 ZY2lbDKSfttBp9AfzRg30uml5wKeHt0/0epG3c+A5e+/J1dlwRuNPsS5QMUWQ+Xriz
	 97Mr0jTjDvJBQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 07 May 2024 15:19:32 +0200
Subject: [PATCH RFC bpf-next 4/8] bpf: typedef a type for the bpf_wq
 callbacks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-bpf_async-v1-4-b4df966096d8@kernel.org>
References: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
In-Reply-To: <20240507-bpf_async-v1-0-b4df966096d8@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715087980; l=1400;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=xAtYvtTO7UEzvYvc5IhP8kn6hurkiD+l2/2akEDg1/4=;
 b=TeUsxmzpFrNCSLyUPysWwfRNWA95zCbqELDbbNLlDh1H/j5v7+vFk44sUYgB3SLnbRPuTncxU
 O9VwlNPUat2AyjpkVaLG35uCtHlezG/8KFROGZusffhwVaPMYH/iSdn
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This allows users to rely on it by using it from the vmlinux.h

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

This is an RFC, and is not meant to be fully reviewed/applied as it is.
I'm posting this to show what I wanted to explain in
https://lore.kernel.org/bpf/mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx/
---
 kernel/bpf/helpers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2a69a9a36c0f..97628bcbd507 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2720,8 +2720,10 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	return 0;
 }
 
+typedef int (*wq_callback_fn_t)(struct bpf_map *map, int *key, struct bpf_wq *wq);
+
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-					 int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+					 wq_callback_fn_t callback_fn__s_async,
 					 unsigned int flags,
 					 void *aux__ign)
 {
@@ -2731,7 +2733,7 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 	if (flags)
 		return -EINVAL;
 
-	return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
+	return __bpf_async_set_callback(async, callback_fn__s_async, aux, flags, BPF_ASYNC_TYPE_WQ);
 }
 
 __bpf_kfunc void bpf_preempt_disable(void)

-- 
2.44.0


