Return-Path: <linux-kselftest+bounces-23696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748A59F9805
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1150189EC6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D58622ACDC;
	Fri, 20 Dec 2024 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tErzRYkh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C121C9FD;
	Fri, 20 Dec 2024 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714760; cv=none; b=dBhJRfOyTG0LJbUfgO+EOat5Q5ZkSN4sA+u5iLdxTaqRSnWwq7gwbH+eVbcjCCS5CJx0xnefBNHABJnu4gHhL1Ok5OgvbpkHVLmnD5mZX7aCn1YORnQevoNkFv9wetkhvPpCbajgAHvRb7T5Poovh7ZvYnKjnrBURI6/1XmmjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714760; c=relaxed/simple;
	bh=/PFeFh6y0Sc/gSAjY8li4ftQqcEtlJf8W6ZfdfyquI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mq9G21iL/KaexBmozmvKgZ0TsTBZcZ5mhOkUomcY9MBAAvV4X/Q2F4BQiHQFnlxt5mDewf0Q963FgAcGEjydM7ohEJutfdyjE9gkoF9UmWTWJ5r84yTFN1NOaGkOPeehBhSZ/l41r7YqF9/gYdrDtl8H6GpGCSF8uqEDk5zROJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tErzRYkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DFBC4CECD;
	Fri, 20 Dec 2024 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714760;
	bh=/PFeFh6y0Sc/gSAjY8li4ftQqcEtlJf8W6ZfdfyquI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tErzRYkhTKCRYI+mCVWDu9vpMlItDzorNzOXbLyHaSvaQEv3YzckMQqpJhXeKexuU
	 zo4FgWxxo3JfhWo8LHIbCK9iSNY0aVmherjZR534+YlH0Bu5Q7P4zBJs/wkbiAw5B2
	 15f4A4XUpkMEfaYQ96sPO6frU1dOfTKsZD5kH8lew78IuxD269yduzH11ihWQdmvIl
	 ivZL0gbbX7DSCkSDQ51/XXvHw3+YrFD6UfBpYtRoSd4osQnUO33+l9SI1CQELZYIw4
	 hhfsW98oqIGgXkwOeKHt6ENbB4x+geSxrj4MmioO848MiSA0BHWC/XtmZfqyU+alXb
	 lrjVKv0Hoctiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	leon.hwang@linux.dev,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 29/29] bpf: consider that tail calls invalidate packet pointers
Date: Fri, 20 Dec 2024 12:11:30 -0500
Message-Id: <20241220171130.511389-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 1a4607ffba35bf2a630aab299e34dd3f6e658d70 ]

Tail-called programs could execute any of the helpers that invalidate
packet pointers. Hence, conservatively assume that each tail call
invalidates packet pointers.

Making the change in bpf_helper_changes_pkt_data() automatically makes
use of check_cfg() logic that computes 'changes_pkt_data' effect for
global sub-programs, such that the following program could be
rejected:

    int tail_call(struct __sk_buff *sk)
    {
    	bpf_tail_call_static(sk, &jmp_table, 0);
    	return 0;
    }

    SEC("tc")
    int not_safe(struct __sk_buff *sk)
    {
    	int *p = (void *)(long)sk->data;
    	... make p valid ...
    	tail_call(sk);
    	*p = 42; /* this is unsafe */
    	...
    }

The tc_bpf2bpf.c:subprog_tc() needs change: mark it as a function that
can invalidate packet pointers. Otherwise, it can't be freplaced with
tailcall_freplace.c:entry_freplace() that does a tail call.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-8-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c                              | 2 ++
 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 33125317994e..bbd0c08072cb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7934,6 +7934,8 @@ bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
 	case BPF_FUNC_xdp_adjust_head:
 	case BPF_FUNC_xdp_adjust_meta:
 	case BPF_FUNC_xdp_adjust_tail:
+	/* tail-called program could call any of the above */
+	case BPF_FUNC_tail_call:
 		return true;
 	default:
 		return false;
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
index 8a0632c37839..79f5087dade2 100644
--- a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -10,6 +10,8 @@ int subprog(struct __sk_buff *skb)
 	int ret = 1;
 
 	__sink(ret);
+	/* let verifier know that 'subprog_tc' can change pointers to skb->data */
+	bpf_skb_change_proto(skb, 0, 0);
 	return ret;
 }
 
-- 
2.39.5


