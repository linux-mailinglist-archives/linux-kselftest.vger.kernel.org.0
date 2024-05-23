Return-Path: <linux-kselftest+bounces-10611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530E08CCC84
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E770AB209EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5F413C906;
	Thu, 23 May 2024 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOBX6h3a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F813C8F8;
	Thu, 23 May 2024 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447069; cv=none; b=U1fOPt6J+GV8SZ9fTO2g0ZyV1XBgtBP0n6FkpTL1kLBRhZc6H3n0k7U+h/QqBP5jYxrJHkErBmiSHOA93yLrrrDXmHJebH3vxzH4R30QDVn9qXX8WHwuqEjwtvsm0JMwVepHt9WaSXhIFTCy0bbqjqPjbQo6QhKOFaR6eJXp1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447069; c=relaxed/simple;
	bh=5wDxYXK13L3RuBy8KDQkEjCCur0RuR4zEdgfgA9ZV3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPNV/O4qx8p1frbcKf3WZw5HcIE6/lVbS0hLF9rgMWwCrvWHdNugbhGh6S0mczd21gdIhuYXPa4oFyTdwariQLlQLxylGlXf77cwBfDs4uWRLljrKnYOWeGCpOlg1ArW62Z1Id5Zh4dqJG/soon0M9WeQCKqp/g5dmFbpWPVEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOBX6h3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F962C32782;
	Thu, 23 May 2024 06:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447069;
	bh=5wDxYXK13L3RuBy8KDQkEjCCur0RuR4zEdgfgA9ZV3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOBX6h3alzW886v/NBWBo/WBdLR1K0pDyyI+lMNvqQ9OaNyjmmm6CGl+VxUWf8c2d
	 jQ+FEQ0GONgss55K4lhVIM9Pq9lAWbKwU+Nw1ig51o9DVRdCmvhAtbhQqU428JZYPS
	 DSk+q/smJOzU/l73KEa88GauGOjqMwhKhsYz5+COTBB9UVANPGGWNMzuz6alHmlaWU
	 1A+F7GrKvTFuiSTljYjZLy8m7RXkF3XJycoECfmvKKXpIURLEIRd7aDfxNprIz+BGA
	 3nXsbG4YRPMghg6/dASBjDtj5Iu/bekiTUIImml9m/teLJKfjGnaGQC4d/STYxOwR5
	 phCK31J3EbfBw==
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
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 8/8] selftests/bpf: Drop duplicate bpf_map_lookup_elem in test_sockmap
Date: Thu, 23 May 2024 14:50:04 +0800
Message-ID: <ea8458462b876ee445173e3effb535fd126137ed.1716446893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_map_lookup_elem is invoked in bpf_prog3() already, no need to invoke
it again. This patch drops it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/test_sockmap_kern.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
index 99d2ea9fb658..2399958991e7 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
@@ -177,9 +177,6 @@ int bpf_prog3(struct __sk_buff *skb)
 		return bpf_sk_redirect_hash(skb, &tls_sock_map, &ret, flags);
 #endif
 	}
-	f = bpf_map_lookup_elem(&sock_skb_opts, &one);
-	if (f && *f)
-		ret = SK_DROP;
 	err = bpf_skb_adjust_room(skb, 4, 0, 0);
 	if (err)
 		return SK_DROP;
-- 
2.43.0


