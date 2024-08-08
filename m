Return-Path: <linux-kselftest+bounces-15008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6294B87A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B617A284160
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA2C189538;
	Thu,  8 Aug 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="sP2joL0F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00E186289;
	Thu,  8 Aug 2024 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104066; cv=none; b=jaWjp6Rsfr0qNu5JotSIenobz2VfkXdpHFMqHGl0n0geAsT+BBbY8dfpuPbuwMg1ku9I/oT8dOlW7X0213d59CkkYrQ1QoUnReOaBam+0surArRAkE1HdUkAkw0EqY6C72VHUuyzD18/gcu6Irfw2A1CfhtNaY3dZiwTwhIIHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104066; c=relaxed/simple;
	bh=RWh44ibT1OVXVkS6LOhCJHv00CcuvNPdegD/w3KXWug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uj1ZditJrX9LhmMYrASNrvWo1UmmqRPY3rxuNqqseukICfeaGxLeNe3CjBErEyWhACDGhMJFXpTZfvP6zPy1n97BUCNPrfORkTAbMR1TjAt6kP0hB+qs39rY1jiw0xsjypOck7zQrlLoVXrbUmzmQvYBvJJGaYDzr0AgqixcQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=sP2joL0F; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1723104058;
	bh=RWh44ibT1OVXVkS6LOhCJHv00CcuvNPdegD/w3KXWug=;
	h=From:To:Cc:Subject:Date:From;
	b=sP2joL0Fq8GhKMyYaxcHb9q2P9pmOFGuvSnf1Xsi41RdprY8zS8U3u927CeScJZDL
	 optsYomQ9stB2MGKdzl0vAbIL/OlMyiBDt13gS9WiOUXRaVMM7e12kUREMP2YxPRqr
	 ae8/FWD2wvv2pJ74NDWiRH5TS4z07wH6dh4ZN5RphIOkM+NhCYeU0lDjld++JOsFzN
	 BTqHdDfiPeYmSAappR+ne5E8TbSWTq1XjWmQGr5PZ41QjlF1BrEjlvcLqf53HP9ONc
	 aI4RmQ9CdxaM7NdvTVhIY+yw9VhMOnsDhC+o9jGGV2T+QyCnOwF153dHhhQOmVXj56
	 IWgjQjLVilGMQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1639C60078;
	Thu,  8 Aug 2024 07:59:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BECD0202330; Thu, 08 Aug 2024 07:59:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: bpf@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Avoid subtraction after htons() in ipip tests
Date: Thu,  8 Aug 2024 07:59:02 +0000
Message-ID: <20240808075906.1849564-1-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On little-endian systems, doing subtraction after htons()
leads to interesting results:

Given:
  MAGIC_BYTES = 123 = 0x007B aka. in big endian: 0x7B00 = 31488
  sizeof(struct iphdr) = 20

Before this patch:
__bpf_constant_htons(MAGIC_BYTES) - sizeof(struct iphdr) = 0x7AEC
0x7AEC = htons(0xEC7A) = htons(60538)

So these were outer IP packets with a total length of 123 bytes,
containing an inner IP packet with a total length of 60538 bytes.

After this patch:
__bpf_constant_htons(MAGIC_BYTES - sizeof(struct iphdr)) = htons(103)

Now these packets are outer IP packets with a total length of 123 bytes,
containing an inner IP packet with a total length of 103 bytes.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
I didn't target bpf and add a Fixes: e853ae776a58 ("selftests/bpf:
support BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP"), since it only breaks
when I change the BPF flow dissector to interact with tot_len.

 .../selftests/bpf/prog_tests/flow_dissector.c        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 9e5f38739104..6b3078dd5645 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -378,8 +378,8 @@ struct test tests[] = {
 			.iph_inner.ihl = 5,
 			.iph_inner.protocol = IPPROTO_TCP,
 			.iph_inner.tot_len =
-				__bpf_constant_htons(MAGIC_BYTES) -
-				sizeof(struct iphdr),
+				__bpf_constant_htons(MAGIC_BYTES -
+				sizeof(struct iphdr)),
 			.tcp.doff = 5,
 			.tcp.source = 80,
 			.tcp.dest = 8080,
@@ -407,8 +407,8 @@ struct test tests[] = {
 			.iph_inner.ihl = 5,
 			.iph_inner.protocol = IPPROTO_TCP,
 			.iph_inner.tot_len =
-				__bpf_constant_htons(MAGIC_BYTES) -
-				sizeof(struct iphdr),
+				__bpf_constant_htons(MAGIC_BYTES -
+				sizeof(struct iphdr)),
 			.tcp.doff = 5,
 			.tcp.source = 80,
 			.tcp.dest = 8080,
@@ -436,8 +436,8 @@ struct test tests[] = {
 			.iph_inner.ihl = 5,
 			.iph_inner.protocol = IPPROTO_TCP,
 			.iph_inner.tot_len =
-				__bpf_constant_htons(MAGIC_BYTES) -
-				sizeof(struct iphdr),
+				__bpf_constant_htons(MAGIC_BYTES -
+				sizeof(struct iphdr)),
 			.tcp.doff = 5,
 			.tcp.source = 99,
 			.tcp.dest = 9090,
-- 
2.45.2


