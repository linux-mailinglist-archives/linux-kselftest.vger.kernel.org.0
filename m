Return-Path: <linux-kselftest+bounces-10331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B39C8C80E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 08:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25A1B214EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 06:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06812E74;
	Fri, 17 May 2024 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8eucMoE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B63125AE;
	Fri, 17 May 2024 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715926918; cv=none; b=KOoogYMxyzmGiA8FQ4j/IUdmC4KsetL6JR1dairz1aKlRyCsjCZCID4ZpDr6dezdfLcF+oiqGuzKShwfCdnKFz1jbSc/7UM9wrQhdR5LDqBqrzRzOtsjwh6vVOMDRi3ha4S/W3Kf+sHzcbQmQS+m9eV+kPVIhS0Q3CymUFmS56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715926918; c=relaxed/simple;
	bh=eZ5Tn5QO/SAzrBsOKZlEXYNoZnS/Hm5viyEfUeCIQfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kR0ntd6KmB3a/NrDum4o6393f2iDCFJTIktEJP+dhH3o0SX2rph3cjmBLLNHF+k0cWZ9wzIuHKSsvROdnc5bCw/963ixHYCJ/6RbvtUVKbIpAz7QX01VeFQ+/5dVHI7Qr0EERXV3iJpIMaUE6rqpbA8rjQxxPhO+NQS5HbakbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8eucMoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB57C2BD10;
	Fri, 17 May 2024 06:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715926918;
	bh=eZ5Tn5QO/SAzrBsOKZlEXYNoZnS/Hm5viyEfUeCIQfg=;
	h=From:To:Cc:Subject:Date:From;
	b=o8eucMoEA8vBG2ZWL0nBGF6b/gRnI85TnvlbKNz4Ot0GVP4tQ3eW2Cr+Vnu+B9Jjf
	 Mj5gFPeL6MpiSCyprzen+bTJPmGDQhgmIVvYTufY9qBmXlgOXw+2rFLZlbpRxUcgfw
	 wOGtI+hBMD6oIn+45TtyrjF2/p5nA8DOM+/2vEa2qFs2f1kGfHZyQvHBTZdD0Qj3Xi
	 T1pIXzHYqnCznsWYRfLB4vNeUFXngP7OjiebGI6WF9DPvPs/EZ3+dI+xHmxriUyADQ
	 ZGUDwmgLRH23kwwNFnyonIUsaqm0c6NODA6AAqYXgFWpVsbYvDhvwcS1CrH2dUWnRs
	 Z8mQ7Qs9WNmRg==
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
Subject: [PATCH bpf-next] selftests/bpf: Fix prog numbers in test_sockmap
Date: Fri, 17 May 2024 14:21:46 +0800
Message-ID: <9c10d9f974f07fcb354a43a8eca67acb2fafc587.1715926605.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_prog5 and bpf_prog7 are removed from progs/test_sockmap_kern.h in
commit d79a32129b21 ("bpf: Selftests, remove prints from sockmap tests"),
now there are only 9 progs in it, not 11:

	SEC("sk_skb1")
	int bpf_prog1(struct __sk_buff *skb)
	SEC("sk_skb2")
	int bpf_prog2(struct __sk_buff *skb)
	SEC("sk_skb3")
	int bpf_prog3(struct __sk_buff *skb)
	SEC("sockops")
	int bpf_sockmap(struct bpf_sock_ops *skops)
	SEC("sk_msg1")
	int bpf_prog4(struct sk_msg_md *msg)
	SEC("sk_msg2")
	int bpf_prog6(struct sk_msg_md *msg)
	SEC("sk_msg3")
	int bpf_prog8(struct sk_msg_md *msg)
	SEC("sk_msg4")
	int bpf_prog9(struct sk_msg_md *msg)
	SEC("sk_msg5")
	int bpf_prog10(struct sk_msg_md *msg)

This patch updates the array sizes of prog_fd[], prog_attach_type[] and
prog_type[] from 11 to 9 accordingly.

Fixes: d79a32129b21 ("bpf: Selftests, remove prints from sockmap tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 92752f5eeded..4499b3cfc3a6 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -63,7 +63,7 @@ int passed;
 int failed;
 int map_fd[9];
 struct bpf_map *maps[9];
-int prog_fd[11];
+int prog_fd[9];
 
 int txmsg_pass;
 int txmsg_redir;
@@ -1793,8 +1793,6 @@ int prog_attach_type[] = {
 	BPF_SK_MSG_VERDICT,
 	BPF_SK_MSG_VERDICT,
 	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
 };
 
 int prog_type[] = {
@@ -1807,8 +1805,6 @@ int prog_type[] = {
 	BPF_PROG_TYPE_SK_MSG,
 	BPF_PROG_TYPE_SK_MSG,
 	BPF_PROG_TYPE_SK_MSG,
-	BPF_PROG_TYPE_SK_MSG,
-	BPF_PROG_TYPE_SK_MSG,
 };
 
 static int populate_progs(char *bpf_file)
-- 
2.43.0


