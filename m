Return-Path: <linux-kselftest+bounces-750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E86F07FC6DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77577B2425F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B5542A9F;
	Tue, 28 Nov 2023 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWUE5p09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B644366;
	Tue, 28 Nov 2023 21:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3689C433C9;
	Tue, 28 Nov 2023 21:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205608;
	bh=EDCjcGa/9qYw0OmkOOcM9slY4BEMMCgERd1JriivOxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWUE5p09g1r86ue3lc5sNqnhdJmrfrvFBFn+EqfX3WSQSl+WwWdMHcVnykwM0banh
	 ZRG09GJKNo+Kn0OQYM6DnYv5OSfOcbz4TxDDOkyIkrXHDLY1cF5Jb9G+8meDXPHJAB
	 abtd73lMBo6hoNsDrPolST9+NFSXnKFmkPXpoewvebMyywZfz/OhBHpcLamFnmh1kE
	 bY59fgMGOKiUntmAIr55rmLv5tbNiaLoyayzdI2orn4uod7JHoVWonsp1Xuev4Jq+D
	 gEkgYFPoRNtlOfLfNhBnGb+kAzsV+NShP1usMdyWh+2w8TLVrvXLq/knJ+Y2xcpQdF
	 a80guQiGyJcUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/40] selftests/bpf: fix bpf_loop_bench for new callback verification scheme
Date: Tue, 28 Nov 2023 16:05:23 -0500
Message-ID: <20231128210615.875085-17-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit f40bfd1679446b22d321e64a1fa98b7d07d2be08 ]

This is a preparatory change. A follow-up patch "bpf: verify callbacks
as if they are called unknown number of times" changes logic for
callbacks handling. While previously callbacks were verified as a
single function call, new scheme takes into account that callbacks
could be executed unknown number of times.

This has dire implications for bpf_loop_bench:

    SEC("fentry/" SYS_PREFIX "sys_getpgid")
    int benchmark(void *ctx)
    {
            for (int i = 0; i < 1000; i++) {
                    bpf_loop(nr_loops, empty_callback, NULL, 0);
                    __sync_add_and_fetch(&hits, nr_loops);
            }
            return 0;
    }

W/o callbacks change verifier sees it as a 1000 calls to
empty_callback(). However, with callbacks change things become
exponential:
- i=0: state exploring empty_callback is scheduled with i=0 (a);
- i=1: state exploring empty_callback is scheduled with i=1;
  ...
- i=999: state exploring empty_callback is scheduled with i=999;
- state (a) is popped from stack;
- i=1: state exploring empty_callback is scheduled with i=1;
  ...

Avoid this issue by rewriting outer loop as bpf_loop().
Unfortunately, this adds a function call to a loop at runtime, which
negatively affects performance:

            throughput               latency
   before:  149.919 ± 0.168 M ops/s, 6.670 ns/op
   after :  137.040 ± 0.187 M ops/s, 7.297 ns/op

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-4-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_loop_bench.c b/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
index 4ce76eb064c41..d461746fd3c1e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
+++ b/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
@@ -15,13 +15,16 @@ static int empty_callback(__u32 index, void *data)
 	return 0;
 }
 
+static int outer_loop(__u32 index, void *data)
+{
+	bpf_loop(nr_loops, empty_callback, NULL, 0);
+	__sync_add_and_fetch(&hits, nr_loops);
+	return 0;
+}
+
 SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int benchmark(void *ctx)
 {
-	for (int i = 0; i < 1000; i++) {
-		bpf_loop(nr_loops, empty_callback, NULL, 0);
-
-		__sync_add_and_fetch(&hits, nr_loops);
-	}
+	bpf_loop(1000, outer_loop, NULL, 0);
 	return 0;
 }
-- 
2.42.0


