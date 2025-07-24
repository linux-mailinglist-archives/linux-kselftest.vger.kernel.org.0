Return-Path: <linux-kselftest+bounces-37949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B92B10E68
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 17:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F262356873E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC822EA478;
	Thu, 24 Jul 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A4798Up0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C372E5B2E
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370124; cv=none; b=P5Fvj6z8RRbFjeUHcZpVC0gXAGJUDODzAEgIBeqL2zn33l4lrkFwHJA6tBeEKdDmFWXX9MJito1g5OXbPK27qM8NjomRWl3qUXvuwFlQkZ9GaF0dYvRlFZ9adqr2RG5yfXv972GBOlemIms2O0i8JcZFi1E5Kh3/4TL69ACOExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370124; c=relaxed/simple;
	bh=EOcAPAX1vQ4XIk2/UrVWTxL9MCVWE5oN9MT9W2II56I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhMBJ8+TKzdk4v5wIFVYN+PeNE4hyXs9c6kOJ6Df50+z+ocamGr+se9Qct/XS4qw5DBuW3ug0XZDQcaBE4X4z2YbZ7D5db4JSxtxeBmhuJsS+MrAn3EjCRBKt/oVKEdB6HB5xZyhVwV18Fm1Qu+UJ34WP8vM8WXj5RpLl5UZ4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A4798Up0; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753370118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElR9Dd4bdnPHpZLYz3QLh/uZus9GLW0mgy218VPlreM=;
	b=A4798Up0BsBRUIgT7YPu1ixF9//13jLsBK4Y5pNRMwPKvbMj7qRSx8FNQ+w4Z4G/eb8LqQ
	sigTBLrPYKGJ4/VOkhEl7oJJucqgYPaDuP96d3utXvj1PcnkvrgtrmL2ppaqlkUQIkRBz9
	iZWZNTfmDzOmtOsh60GS7n7OzlPm1OQ=
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
Subject: [PATCH bpf-next v4 1/4] bpf: Show precise rejected function when attaching fexit/fmod_ret to __noreturn functions
Date: Thu, 24 Jul 2025 23:14:51 +0800
Message-ID: <20250724151454.499040-2-kafai.wan@linux.dev>
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

With this change, we know the precise rejected function name when
attaching fexit/fmod_ret to __noreturn functions from log.

$ ./fexit
libbpf: prog 'fexit': BPF program load failed: -EINVAL
libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/progs/fexit_noreturns.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..00d287814f12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23946,7 +23946,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn functions is rejected.\n");
+		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+			tgt_info.tgt_name);
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
index 54654539f550..b1c33d958ae2 100644
--- a/tools/testing/selftests/bpf/progs/fexit_noreturns.c
+++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
@@ -8,7 +8,7 @@
 char _license[] SEC("license") = "GPL";
 
 SEC("fexit/do_exit")
-__failure __msg("Attaching fexit/fmod_ret to __noreturn functions is rejected.")
+__failure __msg("Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.")
 int BPF_PROG(noreturns)
 {
 	return 0;
-- 
2.43.0


