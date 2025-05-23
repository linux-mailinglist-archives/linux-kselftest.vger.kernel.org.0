Return-Path: <linux-kselftest+bounces-33647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CB3AC23A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 15:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AE71C06136
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B079291171;
	Fri, 23 May 2025 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nBTHqycH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1752291860
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006393; cv=none; b=s4/WcaCpCpmHp4bmPz/UxZXA/3HHD2elZSUrmg4WrN26STcO0uk1ZJSnTMZLqaxdZSsToDQh9shnqmxgexYJD5PrGnYZDhZ0S5WMBgpsa2gBugLXGHqn41XX2KGDHr3UVapr2fzfUkUXIKVrxPj1x/R3PoA6k2duVmU8Rv3orik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006393; c=relaxed/simple;
	bh=nc44uegTtaBLfa/PspnBn79HdTIQhDX0Wc6fqNkOBjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5Rv1Lm/sPHTeIT2aIAHM1mTF3cop5oGhQ+ndmwuRirpqcqvVGpjG0Jn9ECc3mYiSuMW38Mc7JK1QpU2rR9e4kx4o254wWYFBel1i1Ww96e2sDaSR/o7VKiM0z98YR3Wd0up4ITTLmgxa03JRUrpOCZg9LMkPSrX8gN+hX+cW2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nBTHqycH; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748006378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YI9vOyiOj/PuepHUap7YF6scm7WgxYFdNjSyMkhd8EQ=;
	b=nBTHqycH+yvB3uSaBCk/npTNGvfHjK4j58ohsdK1C4HRvIm24xgP1hnNdrBUIbeReeSN3R
	CbhQ9XLaBvWdPcbmJ/tDNYRdHyLK4j7UpJ+WCp7kzN7FbqpnmRNcs5Vp6mycGPDmduPNVe
	QXz9B3PD9l4N96SwtEZ5JNyQSweqYoE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <isolodrai@meta.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 0/2] bpf,ktls: Fix data corruption caused by using bpf_msg_pop_data() in ktls
Date: Fri, 23 May 2025 21:18:57 +0800
Message-ID: <20250523131915.19349-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cong reported an issue where running 'test_sockmap' in the current
bpf-next tree results in an error [1].

The specific test case that triggered the error is a combined test
involving ktls and bpf_msg_pop_data().

Root Cause:
When sending plaintext data, we initially calculated the corresponding
ciphertext length. However, if we later reduced the plaintext data length
via socket policy, we failed to recalculate the ciphertext length.

This results in transmitting buffers containing uninitialized data during
ciphertext transmission.

This causes uninitialized bytes to be appended after a complete
"Application Data" packet, leading to errors on the receiving end when
parsing TLS record.

This issue has existed for a long time but was only exposed after the
following test code was merged.
commit 47eae080410b ("selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap")

Although we already had tests for pop data before this commit, the
pop data length was insufficient (less than 5 bytes). This meant that the
corrupted TLS records with data length <5 bytes were cached without being
parsed, resulting in no error being triggered.

After this fix, all tests pass.

 1/ 6  sockmap::txmsg test passthrough:OK
 2/ 6  sockmap::txmsg test redirect:OK
 3/ 2  sockmap::txmsg test redirect wait send mem:OK
 4/ 6  sockmap::txmsg test drop:OK
 5/ 6  sockmap::txmsg test ingress redirect:OK
 6/ 7  sockmap::txmsg test skb:OK
 7/12  sockmap::txmsg test apply:OK
 8/12  sockmap::txmsg test cork:OK
 9/ 3  sockmap::txmsg test hanging corks:OK
10/11  sockmap::txmsg test push_data:OK
11/17  sockmap::txmsg test pull-data:OK
12/ 9  sockmap::txmsg test pop-data:OK
13/ 6  sockmap::txmsg test push/pop data:OK
14/ 1  sockmap::txmsg test ingress parser:OK
15/ 1  sockmap::txmsg test ingress parser2:OK
16/ 6 sockhash::txmsg test passthrough:OK
17/ 6 sockhash::txmsg test redirect:OK
18/ 2 sockhash::txmsg test redirect wait send mem:OK
19/ 6 sockhash::txmsg test drop:OK
20/ 6 sockhash::txmsg test ingress redirect:OK
21/ 7 sockhash::txmsg test skb:OK
22/12 sockhash::txmsg test apply:OK
23/12 sockhash::txmsg test cork:OK
24/ 3 sockhash::txmsg test hanging corks:OK
25/11 sockhash::txmsg test push_data:OK
26/17 sockhash::txmsg test pull-data:OK
27/ 9 sockhash::txmsg test pop-data:OK
28/ 6 sockhash::txmsg test push/pop data:OK
29/ 1 sockhash::txmsg test ingress parser:OK
30/ 1 sockhash::txmsg test ingress parser2:OK
31/ 6 sockhash:ktls:txmsg test passthrough:OK
32/ 6 sockhash:ktls:txmsg test redirect:OK
33/ 2 sockhash:ktls:txmsg test redirect wait send mem:OK
34/ 6 sockhash:ktls:txmsg test drop:OK
35/ 6 sockhash:ktls:txmsg test ingress redirect:OK
36/ 7 sockhash:ktls:txmsg test skb:OK
37/12 sockhash:ktls:txmsg test apply:OK
38/12 sockhash:ktls:txmsg test cork:OK
39/ 3 sockhash:ktls:txmsg test hanging corks:OK
40/11 sockhash:ktls:txmsg test push_data:OK
41/17 sockhash:ktls:txmsg test pull-data:OK
42/ 9 sockhash:ktls:txmsg test pop-data:OK
43/ 6 sockhash:ktls:txmsg test push/pop data:OK
44/ 1 sockhash:ktls:txmsg test ingress parser:OK
45/ 0 sockhash:ktls:txmsg test ingress parser2:OK
Pass: 45 Fail: 0

[1]: https://lore.kernel.org/bpf/CAM_iQpU7=4xjbefZoxndKoX9gFFMOe7FcWMq5tHBsymbrnMHxQ@mail.gmail.com/

Jiayuan Chen (2):
  bpf,ktls: Fix data corruption when using bpf_msg_pop_data() in ktls
  selftests/bpf: Add test to cover ktls with bpf_msg_pop_data

 net/tls/tls_sw.c                              | 15 +++
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 91 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  4 +
 3 files changed, 110 insertions(+)

-- 
2.47.1


