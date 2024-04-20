Return-Path: <linux-kselftest+bounces-8540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C78ABA82
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9C21C21349
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB13179AB;
	Sat, 20 Apr 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqRJuXeu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8163CF74;
	Sat, 20 Apr 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604190; cv=none; b=YbjoKqbiF31BVdXtda8Z7sXCbumdR3CBbrdOUOZxWqxtpZmX1fcykmyEGdlu801fJm5YoIH5K2IADVPVd9kaU1h/7AeLjPNiX7ySR7HcteWxwhVfKwsYE+IeI0zOFg/oKHr9USpUwozsJDxOq5g3LhSSKzhKbvugkPnCvlwyFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604190; c=relaxed/simple;
	bh=sqBLxwMs8NHUzEqz1nVFEPGoIGPCN7UMcScC2uJ1VVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T941IuA8dOgUT0tR0CqWtISa8lnR6RrA8RWIcQCxqGfjgSjQbQAtorNwsDd5Bta+/ofVF5bSDjj0mfDDNfMdkt6KeZ/kydtDwZvQU3TTVdBwEKQQ5PdxbAS4F/bUsYnGwE1q1KlhuxRHL7KfVDXLQ5JzBCAyc5ovX/7bJSBcM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqRJuXeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82062C32783;
	Sat, 20 Apr 2024 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604189;
	bh=sqBLxwMs8NHUzEqz1nVFEPGoIGPCN7UMcScC2uJ1VVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UqRJuXeulSmosSNdJqhrhtQLaJ0+o5DCYSEupHTu97VMOVrFyv/fxg6L6XkxwCJqq
	 JVCybv6ZJSmEr8avl5CoYXQSOWU8yAC5O7fHStKxRyadnLBfh0z5msIry14uiPDM31
	 UWmPdA9DdSTbijZZhwMrdxwLjvkPRm15r3AHGZtVnDZlnywmV21gACvNLG2scYLtEo
	 cxVy9xCyyrqphk0T2Pc35IRn5agNFGscZLCxl4Pdtagj+opRlkVMRp5Imf5mUJbf78
	 h9DlFgeNOH85SLQSA9qazEG1Ls3FKPO0hNbA5coy2TiN2+e59Cw7i25HK8GkdFl7F9
	 kqlUzYoqnHshQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:07 +0200
Subject: [PATCH bpf-next v2 07/16] bpf: verifier: bail out if the argument
 is not a map
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-7-6c986a5a741f@kernel.org>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=942;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=sqBLxwMs8NHUzEqz1nVFEPGoIGPCN7UMcScC2uJ1VVE=;
 b=zxCBhZfexHvnKwW7ytj7Kj8p2XCvrvWGvnwGLrOkwXY2giKQ7jz3/8B9ywwDBQAi6HKm5ancw
 4BSlCxZb8RzCfdkqxely4D14eAGXdMHVRqhwsJhgTP2x2fWf03UXwlj
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

When a kfunc is declared with a KF_ARG_PTR_TO_MAP, we should have
reg->map_ptr set to a non NULL value, otherwise, that means that the
underlying type is not a map.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index deaf2e1ab690..b95fd63864f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11720,6 +11720,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_NULL:
 			continue;
 		case KF_ARG_PTR_TO_MAP:
+			if (!reg->map_ptr) {
+				verbose(env, "pointer in R%d isn't map pointer\n", regno);
+				return -EINVAL;
+			}
+			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))

-- 
2.44.0


