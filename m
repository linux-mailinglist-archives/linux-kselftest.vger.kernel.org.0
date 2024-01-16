Return-Path: <linux-kselftest+bounces-3101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5863882F5AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050331F25353
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B81D548;
	Tue, 16 Jan 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSMJ+nqw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B91D52B;
	Tue, 16 Jan 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434165; cv=none; b=hoQTBvWMiEoXIMGOGNCPh20zAckDwcpKnEEyvS3EmwJy9ng2eB8AeblDk7iu10veUhAEFeCCc43LngHnogJ7SrrOrVzEs4+1An+OwN5Q4zgsCUQkfLqnhNm4gXGi+C3y6uxn5ScDdZy8Eglb8prROW32PgGQwCFWvoF/zZfWt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434165; c=relaxed/simple;
	bh=QRgPTO3B4Bi6cRdj4geYKsRqhqcksarDGZYds9+ugPE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=jwIDCU5tYTotWmi27igj2OweF+T0mscrbjgoyptUhybj9N3okBfZPBdx8KJ7VDHKLfO3u+I0E06yNm71LZJ/P/RPhMpaKVXlN9uUlZb4Hf0/mVKoYICMJvwr45kMLScE0bwpBD9L1H13Zu4m0mKE/RvU/GGED4GOL8F7w7o/GSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSMJ+nqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE7C433C7;
	Tue, 16 Jan 2024 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434165;
	bh=QRgPTO3B4Bi6cRdj4geYKsRqhqcksarDGZYds9+ugPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSMJ+nqwVZHxxtXi8g8P1wcc5B/gJRuijvV7qG8E/DyX1j2t7SM0BqpeY/B4NixNr
	 gX16AbnFhTHsyWPFV7yxuivCbD4cwfcMYjt6lrHepjy3uMk5Igk8Ba/LLz8XlIrhI1
	 wz4j8Fpm8Oc7biNrY0K1zR6B6ymk2u5syG5dJ1iy+o9tzN2cvTxfFGhxKllF5gE29g
	 qFUmd3/cQI7iW8xsXCrVsp8+XhuJj0UP2VPf3eWiUqyRMhoNZRoKoU/eGFvtNQGTSk
	 iq8JYFwtKaap8u+L2EAB1G6VyrIURwGYCn/jyAUq50cwE6z6FUEnMszkhoM1zrU8jr
	 ApvNgRvdILCrA==
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
Subject: [PATCH AUTOSEL 6.7 003/108] selftests/bpf: fix RELEASE=1 build for tc_opts
Date: Tue, 16 Jan 2024 14:38:29 -0500
Message-ID: <20240116194225.250921-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 51883ccb8020..196abf223465 100644
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


