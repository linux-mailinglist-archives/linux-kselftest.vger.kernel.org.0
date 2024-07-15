Return-Path: <linux-kselftest+bounces-13719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F59311B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 11:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186641C223ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76ED187573;
	Mon, 15 Jul 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O339lTlC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B22187323;
	Mon, 15 Jul 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037250; cv=none; b=A+v4OUXP9gAaHq5HerNgtNYM0LKwltBZUNyWSLYbKx4FuApZOqrevRnGtA8SKf9FD+0c8QYCtujLZlL0Gd0pud63ul22+jQFEKcH1O8R1BdThWhV4peO2I8pJQNKjY4RiEV1Hxgf9ru+j5sqFgY/6EfmtRAaL9W3dD3YMV1meQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037250; c=relaxed/simple;
	bh=HewV26qzlHlPw6Og4CVNXCxBdYHk50g8fFbOl3STBQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbBXzXwBjOq0K0hEyvvympx5OVDsqbcjVgqc+FkfAa4VtOcK7DPdpisR8Hjzk+Y2vE7Y41A36qdl2CJZp01SaesMlcMsdNPNc1mRC8w+SOKcsVIKxkARQrHVBhKeUhk977tXL/PyrHxJSASF0eNNPpFEMFRjlxk1/x31DH5TCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O339lTlC; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 852F61C000A;
	Mon, 15 Jul 2024 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721037246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaQ6xwQ/n8Nx8g9AyNNBb1csA2zu11wSxiwvFbVYzzY=;
	b=O339lTlCV6noi68/HGr97jnfMN+YlJfz24aLYzZIDAKvYnfzRV1SMIkXb50/14f6V593Rr
	P7lblv4qR0ZMUt5zlhevnAMSWnILz/uanTf/llS+yN2KadEy5E+D73XcCFmr0CYujqGyYA
	HPC8EkiXy1BM1uPJe/x3g0IqYx28XTW6YeuTC8nh8ZaEfUusMubW0swFtU/dKXVLRF/NkM
	0w175823QH/wQribhA9K2Q258fgxkJp965HvTLf33XJeMGH38QfZ79D0zCmJLZLHh4VUnp
	64zjTyoOGjny19jNJ59bnsJ61n0YKOm2Adn2o+0C+DxFi0HdnRXB8xX+Yrf5xw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 15 Jul 2024 11:53:44 +0200
Subject: [PATCH v2 1/2] selftests/bpf: update xdp_redirect_map prog
 sections for libbpf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240715-convert_test_xdp_veth-v2-1-46290b82f6d2@bootlin.com>
References: <20240715-convert_test_xdp_veth-v2-0-46290b82f6d2@bootlin.com>
In-Reply-To: <20240715-convert_test_xdp_veth-v2-0-46290b82f6d2@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

xdp_redirect_map.c is a bpf program used by test_xdp_veth.sh, which is not
handled by the generic test runner (test_progs). To allow converting this
test to test_progs, the corresponding program must be updated to allow
handling it through skeletons generated by bpftool and libbpf.

Update programs section names to allow to manipulate those with libbpf.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/progs/xdp_redirect_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
index d037262c8937..682dda8dabbc 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
@@ -10,19 +10,19 @@ struct {
 	__uint(value_size, sizeof(int));
 } tx_port SEC(".maps");
 
-SEC("redirect_map_0")
+SEC("xdp")
 int xdp_redirect_map_0(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 0, 0);
 }
 
-SEC("redirect_map_1")
+SEC("xdp")
 int xdp_redirect_map_1(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 1, 0);
 }
 
-SEC("redirect_map_2")
+SEC("xdp")
 int xdp_redirect_map_2(struct xdp_md *xdp)
 {
 	return bpf_redirect_map(&tx_port, 2, 0);

-- 
2.45.2


