Return-Path: <linux-kselftest+bounces-10707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A40128D0338
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418DF1F270AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9532B15FCF0;
	Mon, 27 May 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtEmFOjy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00315EFA3;
	Mon, 27 May 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819208; cv=none; b=gU8g6k6y6Z1rHzUZ6tlT2rb/Zg6M1VqfO/nEVxafS61LmJcup/tOYg04N3O7IOPg2oFnOzjUBQ/LU2vfKt8rw/GWF4tJcPgncKbme2JX0cD0se6PlBNvjt7i46G7xnYXrFlKUMcNmSmvkPBWnz05q7InoPwaa41mMXLBQlRF9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819208; c=relaxed/simple;
	bh=EcBCWvFnweJKxtHmfsqqva2IFqtU+n6mRWMhxtPDRsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAJm1YEHwAmDD+1AIedTQfcw9lTzcwWdWSg6Ytava7tuHfK6kdZWK9jdk6VBfWJNXSVC13D/YIPJvOpVyicRdDHATAEybOLvbXGU3OzI5mg8r95alqlDclmgCRx8FiwWGuEMAYuASpH/YXN7lQ70V4BZKACgOq837NKV7QPn7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtEmFOjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D32C32781;
	Mon, 27 May 2024 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819208;
	bh=EcBCWvFnweJKxtHmfsqqva2IFqtU+n6mRWMhxtPDRsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtEmFOjyIVcnjLWwbL1sUgf+GQ5GRtWF7HuZ6N0764egAvVTHxKXWh+IRo56Thoo/
	 EBbgS8MmLFg4gdGInfjODwAd/iKyvLM1MSDvyXxlzfY3tjqs9UeR0oT6auYJV+Osig
	 aM7RJvIC/4cSztyDQ2g4BvF4Xn1CNjxAtHNOHBw9inOIgF4KEAFr3jDjo6YOGdBnWB
	 LYAvVnT1nf5Tu7vKWmzt56R7TNqxH/tIgvrTk3dGUhUd/GIkzkVUzeF4demVj3qh65
	 ceGq8J4J4Wf4T+FGaVB4skDwo+ym96FAsJ1NTSUGftwnZesnHLBgGynoRN25VobuiW
	 OPonBWnbUhIOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
	david.faust@oracle.com,
	cupertino.miranda@oracle.com,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrii@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 32/35] bpf: avoid uninitialized warnings in verifier_global_subprogs.c
Date: Mon, 27 May 2024 10:11:37 -0400
Message-ID: <20240527141214.3844331-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: "Jose E. Marchesi" <jose.marchesi@oracle.com>

[ Upstream commit cd3fc3b9782130a5bc1dc3dfccffbc1657637a93 ]

[Changes from V1:
- The warning to disable is -Wmaybe-uninitialized, not -Wuninitialized.
- This warning is only supported in GCC.]

The BPF selftest verifier_global_subprogs.c contains code that
purposedly performs out of bounds access to memory, to check whether
the kernel verifier is able to catch them.  For example:

  __noinline int global_unsupp(const int *mem)
  {
	if (!mem)
		return 0;
	return mem[100]; /* BOOM */
  }

With -O1 and higher and no inlining, GCC notices this fact and emits a
"maybe uninitialized" warning.  This is by design.  Note that the
emission of these warnings is highly dependent on the precise
optimizations that are performed.

This patch adds a compiler pragma to verifier_global_subprogs.c to
ignore these warnings.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20240507184756.1772-1-jose.marchesi@oracle.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/bpf/progs/verifier_global_subprogs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index baff5ffe94051..a9fc30ed4d732 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -8,6 +8,13 @@
 #include "xdp_metadata.h"
 #include "bpf_kfuncs.h"
 
+/* The compiler may be able to detect the access to uninitialized
+   memory in the routines performing out of bound memory accesses and
+   emit warnings about it.  This is the case of GCC. */
+#if !defined(__clang__)
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
+#endif
+
 int arr[1];
 int unkn_idx;
 const volatile bool call_dead_subprog = false;
-- 
2.43.0


