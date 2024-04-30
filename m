Return-Path: <linux-kselftest+bounces-9122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97578B6E98
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164BA1C20E1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5EF1A0B0C;
	Tue, 30 Apr 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUv5qPYQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029E1A0B06;
	Tue, 30 Apr 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469793; cv=none; b=rs2VOdlKmIw6IHpJXrBwqYvg7/EXlNy57y4AyITq4R3iOYFBkgbk/1xlQZ7e8G7S5bk0SJxftnPcHINMlrW6DMT0U+056EVXAv9hlxIde/wlvrv5LxeMt/EK2vHZ3L650gf/r7/gwMkwCfoOXtGU5IYEKwwg5iusAWAWesDKHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469793; c=relaxed/simple;
	bh=bhzZtbW8vADrbyYDpEyoD631jxsaMcAgBlvgv/dK/J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQDKS4v0R+QsqZ74QxV00VFNDdhdrPrnx/ZOcMl5D6g7QrLT/0kJlmiFqiD4iYJOTAmPslnaw+X6m0lNQBBItHhEZF6nuBcAPx9ppICXyy/7sPHWxozJTGEyFcoQJdu8BwQ/fsKevsrAIJ6FYyWcVZbGo/vm2Jea039cdYEt0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUv5qPYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B165EC4AF19;
	Tue, 30 Apr 2024 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714469793;
	bh=bhzZtbW8vADrbyYDpEyoD631jxsaMcAgBlvgv/dK/J4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KUv5qPYQE65E6OtMiIdMBYO6aBSQUK+DK2gfLswwPV68AlPrJUwVEZRA6+9jw7IDW
	 Y6n0al0Jt38Lu6ww3ijeOEAVwTYPfW1Foawdl4fbt4p6LlyOd1m9dI4VDgU0akIrhp
	 f6pXJGsqBjG/8Wrq5PxbypdLpt6FZHvbTGofuJNo3ryZjgTEYwl+68Wk2UjrDAMHbN
	 zhvIO92nOcOJj79myHtAbvVOXQUZKXGB5fmsfUP0FBezfJsUNBNj8EHTzNH3+8r2yQ
	 306vqNOIqB5rpoZPLmB53SLSO1njcXdlwwMPMHUxLnsJbRV5HC2yr5f//OrvGCP3/A
	 HeFuIgcD3cBeA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 30 Apr 2024 11:36:12 +0200
Subject: [PATCH v2 3/3] selftests/bpf: drop an unused local variable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-bpf-next-v2-3-140aa50f0f19@kernel.org>
References: <20240430-bpf-next-v2-0-140aa50f0f19@kernel.org>
In-Reply-To: <20240430-bpf-next-v2-0-140aa50f0f19@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714469778; l=720;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=bhzZtbW8vADrbyYDpEyoD631jxsaMcAgBlvgv/dK/J4=;
 b=YmoD9kZN4gNX/W8LY6WLJWW3Y5qI5CxWasAbaHC4nBctmuFGROznShnN1hKzrua6UdQI4w0fd
 UdrcC2YzSwhAiWKYSvSKsDodXjLbiBwYwiyL2dQIh5ocnIyvurk4FZz
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Some copy/paste leftover, this is never used

Fixes: e3d9eac99afd ("selftests/bpf: wq: add bpf_wq_init() checks")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index c4bacd3160e1..99e438fe12ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -36,7 +36,5 @@ void serial_test_wq(void)
 
 void serial_test_failures_wq(void)
 {
-	LIBBPF_OPTS(bpf_test_run_opts, topts);
-
 	RUN_TESTS(wq_failures);
 }

-- 
2.44.0


