Return-Path: <linux-kselftest+bounces-8149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5238A6DB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18374B23E40
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541F137769;
	Tue, 16 Apr 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouzk7Scm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA161369BB;
	Tue, 16 Apr 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276663; cv=none; b=NmwDtYN4e3ZeiiP3p2DnM7jxJIB7lGxl2fuicrzbkBBEAGviIYkXwjQ6V6YmlWFMsDMrdvWhLARGkx+D20/hdbND0VmbN9/5GsIrlJvAfpfRJqkXBU/epNEWCsObNE5Im/E1PY0M+MqgWhYx7d/eLXwdtWnoYb6npIAGfIL4xvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276663; c=relaxed/simple;
	bh=b3PkzLOIXQdFGv5PNduwNWgXmPt5byfF8ywwFY3Z51s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VM3Zy8YuHAo53wJf+mvIG/W6VjxZ7JQuBnyXeFJhVPBh/ojbgORcPE9zq84TfZrJebMlD7sO7YIgSOTn6OjDuemRHc5g2yRriw4aRYikbcHVd0uKctVIog0Jyd7NNUeV9HsNYD10kRmfBpUkGsjlNA93T3CNV11OqFxLwcXMT9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouzk7Scm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20DC4AF52;
	Tue, 16 Apr 2024 14:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276663;
	bh=b3PkzLOIXQdFGv5PNduwNWgXmPt5byfF8ywwFY3Z51s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ouzk7ScmTGcsbcCyy5C6A0mRikAlG1gXv/S+Xsq0mHh0MtYKHOu4ZemxpiLiFCvIy
	 kI4xi1nHY6wZoG0AHLT0vbgc1VGrmIRxu1powyaANcHKxaCKCXB5HONvS6P9rth+y9
	 4sz27fKJwtWe1x/fVHCU8W3lshmntQJVV65kRLoP1aMpYBpgAibjZJD+L+lcXagHUY
	 vKn+WRpssdQR8FGecUZd/UkhkTKEz3Pn2KzPZs4gLf0xPtpHWIsBRJc0fX0QKx12U6
	 Hh2r/S91jSy1RDh8Z4Q8VRwYQqRqlC4gdjKzTXGSCXAN0H6yRy9Dom4ZFYSJT7J/ug
	 ecaKwVoERRjmA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:30 +0200
Subject: [PATCH bpf-next 17/18] bpf: add bpf_wq_start
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-17-c9e66092f842@kernel.org>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=1510;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=b3PkzLOIXQdFGv5PNduwNWgXmPt5byfF8ywwFY3Z51s=;
 b=qGHq6hqI33hY8ac+spbS1hKIZ4U4mwd4LG/eiNsLMlW8qLnD9HGxeaAp/QtVSNb7XJzNNUNyU
 X7tyfmJ0yrVCsk/g8vMgw6V2UgC8BHDlm3XwQ/ZG/GszfLKv17fsMl5
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

again, copy/paste from bpf_timer_start().

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 kernel/bpf/helpers.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e5c8adc44619..ed5309a37eda 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2728,6 +2728,29 @@ __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *map, unsigned int flags)
 	return __bpf_async_init(async, map, flags, BPF_ASYNC_TYPE_WQ);
 }
 
+__bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
+{
+	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
+	struct bpf_work *w;
+	int ret = 0;
+
+	if (in_nmi())
+		return -EOPNOTSUPP;
+	if (flags)
+		return -EINVAL;
+	__bpf_spin_lock_irqsave(&async->lock);
+	w = async->work;
+	if (!w || !w->cb.prog) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	schedule_work(&w->work);
+out:
+	__bpf_spin_unlock_irqrestore(&async->lock);
+	return ret;
+}
+
 __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 					 int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
 					 unsigned int flags__k,
@@ -2821,6 +2844,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_ID_FLAGS(func, bpf_wq_init)
 BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
+BTF_ID_FLAGS(func, bpf_wq_start)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

-- 
2.44.0


