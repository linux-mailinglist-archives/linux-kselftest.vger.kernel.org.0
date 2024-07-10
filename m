Return-Path: <linux-kselftest+bounces-13463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 235FA92D25F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D365028210F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829B192474;
	Wed, 10 Jul 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovHiPnh0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117F18FDDB;
	Wed, 10 Jul 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617040; cv=none; b=bmbjBZqi2mIj8LuPMxiOVxUKRPD9WT8It+TtXCqcZwODeIZRJHbAFBLLXhjt3M68YpNASfpgxuoRagijqI7ag75GlyzrrOTCnsyQkj7+pUZdF/tj5tnuk0TOIYE54bAL50ainALy6jd3mbop1oktqaiU5unH9cfndw9+TmyIjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617040; c=relaxed/simple;
	bh=w6ec2huPARUWSaFkMfBkaPiPU+YqLo6r7sO4dLoGjRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP+cqm8zx9IASziDY3Evs1Bc5/Leikq31I4t2EDLQMTnHNjC+ViybnD3IXqVPJgbwAenIwXSDuSOL0uR4tXZjqYQmOyg3cg6fn7BOF/6qR9yu9df6IDg3V1hyRP+Dqik/g14y12f28oWXRjv/61dEXd3dUnkuL6kZ5qzk6clwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovHiPnh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F4EC32782;
	Wed, 10 Jul 2024 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720617040;
	bh=w6ec2huPARUWSaFkMfBkaPiPU+YqLo6r7sO4dLoGjRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovHiPnh08JUZ48gyJV/J3fTz8U1DFpFLo4fDuASrytOj9trNzMb8Ml3WhH/KfJ2yM
	 4eB+quBSVQgkyBNE22kWhxz0JGlOjSumMzMgoKvN6sPB6nE6VPEaTWn8JFyphe1ITB
	 Zv6ojsOVKO6MsTuaaCJheQ/tJ+UEd+AuzHjSUNlCmOzI03OIYjaIufByc4C3pcUhE1
	 K994FyCRjeI4GJWwBOFsOXqb1NXFNV93T10ebBoobmHncq4wochRLqYCb+343pydrZ
	 B0iA7QC1RfLAfF8U3uZC/QDlibmEicYmZZw66YilsAfWaeb0+XGPppzBm2SfnbDETk
	 tkd4e5EowJJSg==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Close obj in error path in xdp_adjust_tail
Date: Wed, 10 Jul 2024 21:10:17 +0800
Message-ID: <f282a1ed2d0e3fb38cceefec8e81cabb69cab260.1720615848.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720615848.git.tanggeliang@kylinos.cn>
References: <cover.1720615848.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

If bpf_object__load() fails in test_xdp_adjust_frags_tail_grow(), "obj"
opened before this should be closed. So use "goto out" to close it instead
of using "return" here.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index f09505f8b038..53d6ad8c2257 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -222,7 +222,7 @@ static void test_xdp_adjust_frags_tail_grow(void)
 
 	prog = bpf_object__next_program(obj, NULL);
 	if (bpf_object__load(obj))
-		return;
+		goto out;
 
 	prog_fd = bpf_program__fd(prog);
 
-- 
2.43.0


