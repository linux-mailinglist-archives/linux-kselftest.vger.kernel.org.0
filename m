Return-Path: <linux-kselftest+bounces-3109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A682F7A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296641C24B16
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0722F16;
	Tue, 16 Jan 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIlY5kOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243522EFE;
	Tue, 16 Jan 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434565; cv=none; b=AqUdfrd++Tg0tU1S8/aXhUiJcH9wYXWYR5YaJPFg+TZv2isu0WBTVNnqHgPEeBxMKdYsXtQQKrX6+rycNNegkO2sp9C+UZFpreVqyqTk0CZr7jU27y4T4xh4I/Aj+kwEQj0aIr3yV3mICHhWdxNVvqQJIxwzd0vdMAro4XxkV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434565; c=relaxed/simple;
	bh=jpbFjzoYlbB5iDd5tuPkWN7/SfrgoieOgEdVctLrWrs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ZeYQFmSthW6arTI9tZPznkXYj8x+cfWWJ4L/vVNLpYo2cEN0t/PJCoSvYtEwzSMxnVrmmamhz1/WyhChkCbv5VGf3oVswbD5LHvtMiTm9tFkL28RRTXLP8X5NrV1Hx2Y1ROkFyXf6Dr7teEw69zcu4tZlfTZF7jPyhQFHi17dpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIlY5kOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E34C433F1;
	Tue, 16 Jan 2024 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434564;
	bh=jpbFjzoYlbB5iDd5tuPkWN7/SfrgoieOgEdVctLrWrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIlY5kOrVXOGuD5/MDvxNtlVM+olCO3difeqE9q6DiAb9HhCCBtnI4XsrRzC5a86o
	 +htPHYPG040/s5YtdAUfabfLo5RyqbP07ryauIjwFzqyXe+VxtATUpWVVxy/kfV5OG
	 CgCVPZhLcMNkU2dxZRULtiIu+8ftAUU06Oxz8hl0/ZnWSC0OWIByPL1r2BX7z4L9At
	 FFYM83I6lRbJdytJOqpEcvS2WT4e2iEtp6suH2rkelPbHciShHSdsyfnAiD5HR/IPN
	 0xJjc/uB9iEbLIRGXGDR2mo+UzsDJ7ZGPpHQu9x8JGSLLGJjJxDPuERrSxGT3unh1E
	 pTRP0TkfjY/0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	shuah@kernel.org,
	martin.lau@kernel.org,
	alan.maguire@oracle.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 003/104] selftests/bpf: fix RELEASE=1 build for tc_opts
Date: Tue, 16 Jan 2024 14:45:29 -0500
Message-ID: <20240116194908.253437-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 2b62aa59d02ed281fa4fc218df3ca91b773e1e62 ]

Compiler complains about malloc(). We also don't need to dynamically
allocate anything, so make the life easier by using statically sized
buffer.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231102033759.2541186-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/tc_opts.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index ca506d2fcf58..d6fd09c2d6e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -2387,12 +2387,9 @@ static int generate_dummy_prog(void)
 	const size_t prog_insn_cnt = sizeof(prog_insns) / sizeof(struct bpf_insn);
 	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	const size_t log_buf_sz = 256;
-	char *log_buf;
+	char log_buf[log_buf_sz];
 	int fd = -1;
 
-	log_buf = malloc(log_buf_sz);
-	if (!ASSERT_OK_PTR(log_buf, "log_buf_alloc"))
-		return fd;
 	opts.log_buf = log_buf;
 	opts.log_size = log_buf_sz;
 
@@ -2402,7 +2399,6 @@ static int generate_dummy_prog(void)
 			   prog_insns, prog_insn_cnt, &opts);
 	ASSERT_STREQ(log_buf, "", "log_0");
 	ASSERT_GE(fd, 0, "prog_fd");
-	free(log_buf);
 	return fd;
 }
 
-- 
2.43.0


