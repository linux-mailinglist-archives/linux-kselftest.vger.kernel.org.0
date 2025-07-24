Return-Path: <linux-kselftest+bounces-37951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5730DB10E6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685643BF918
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AB32EA142;
	Thu, 24 Jul 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDvgmDkW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C122E9EBA
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370131; cv=none; b=IqgqYZrimWMOr2prVjUgNA7Yen9o4TPQUrTeddu7B4xIENWWgvQoEGgIR/tt/J7kPzA+PIXZBNV+/JerK6aZSB3JI/L9mhkSCBnbW03F0ghBhQuDAvlCeJRSsjavNhR0aKzrS8K2Nd1ctPmk+Ty6+ngXbA3rhbTEcBAWtsE5gu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370131; c=relaxed/simple;
	bh=Rp6QB38jGHbwBhBe9EF3FxRJm3xchbnZjDcQFcC5nRg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSIUsgFtxK4lxLJ8jUX3JU/r2dgkSqKYZGLPBEtEnydu0iyJrzvwT1cgwK6uCHeV64KcWEzAr0oYJHcs6Smpg9rTad6ZK1V2erdhWozkTVeIJXN60g+Rc/jISmmNgSBp6Uuenh5JNSIdlYVM35iwq/adMLerCcEmW66+xbrJl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDvgmDkW; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753370126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYH+7OzFGHpSlM/+cXLObejEneebIcCwpxyqa2mfSxA=;
	b=WDvgmDkWbWWZB+va1kleq5YoDlhqFpAyuQOneXTCrd996ZnRls2+16q6oEP5AyohBbMYMF
	N9fa4P/DJ46622uBfltSO9fQgr6LyvbLeoV1dYJrPOgeRr2Gngi71xOItfbevOPCl6rKcq
	+Wj2Tj5r6pe41Lq8jOX4vWGDeawxGu0=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v4 2/4] bpf: Add log for attaching tracing programs to functions in deny list
Date: Thu, 24 Jul 2025 23:14:52 +0800
Message-ID: <20250724151454.499040-3-kafai.wan@linux.dev>
In-Reply-To: <20250724151454.499040-1-kafai.wan@linux.dev>
References: <20250724151454.499040-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Show the rejected function name when attaching tracing programs to
functions in deny list.

With this change, we know why tracing programs can't attach to functions
like __rcu_read_lock() from log.

$ ./fentry
libbpf: prog '__rcu_read_lock': BPF program load failed: -EINVAL
libbpf: prog '__rcu_read_lock': -- BEGIN PROG LOAD LOG --
Attaching tracing programs to function '__rcu_read_lock' is rejected.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 00d287814f12..c24c0d57e595 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23942,6 +23942,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			return ret;
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
+		verbose(env, "Attaching tracing programs to function '%s' is rejected.\n",
+			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
-- 
2.43.0


