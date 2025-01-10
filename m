Return-Path: <linux-kselftest+bounces-24192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7793AA08B7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A684F188D540
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D220ADD8;
	Fri, 10 Jan 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dkF4Qh37"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E74209F47;
	Fri, 10 Jan 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500879; cv=none; b=njJKKxCXU4xZgXD0ggp5HdqQvromgSE4tVTyZasBwsAfY1a7cI7xu/XkfuonwiMWpnKkjGHM2Z7ydu8V8FaEXqc3Tp93eOIaKbEgHlJhf9EMrdzqj+LFZL0G083UnA5Ol9ZmIde1l28CWdyXNL9kQq8AvVHAM4Cgha/r+BQZj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500879; c=relaxed/simple;
	bh=aK3JWnBEOh5FxB0q9WsazXoEE2M2s+Pi71KVwVPBfIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7qoGnYgszHvreB1/L+Ewr1BkdoOLMxKaoDEGe4Y7oS87uCXlUCVZJZ04IiOtZ5lTBw0dJ1rixYqPgYgZRFpaq2AJSVA9osaUCPaXfBaBfj4ZM1xbInOCZijf5fwRLxj/54iD63vEWR4Az+TzN+oIr8J8EwsCQ3mbCcelumE6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dkF4Qh37; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF762FF807;
	Fri, 10 Jan 2025 09:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736500875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8AwyrM67EleebEvO+B4u4H3TFQZbvi+HCh1Hy+fEoQ=;
	b=dkF4Qh37lv1arjIXzKCADwjr2uEVLs7PseNFb6X4Kgl7Ee3KXYGCvxJM1gVskRZCtD77HM
	ppc2dNkXDY4ZSUAeYbWE5KONtxTDAXAV2D0y1qpqgujk95GmFh83Wg9ebp2jF1Gug+yMTs
	SEO8NinQxmxHDx/5X/P/+0b24rorbmkO3uDaQ0Hlbi9GB9xzcVxNP19/Omw1w+LadjDg0a
	4q4mXGxoOfudkJDzghFIsQbU/Lj5ZxqGa9PZ7Ieouz9K+yVgHX061EUX5htdsxQzxJrePy
	Dn98imaGzAZOoFPOhXPKHnt0TJrSq4ZTqrMmRRGyU/ALp4wUGHClOkLqgBB3gQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 10 Jan 2025 10:21:09 +0100
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: test_xdp_redirect: Rename
 BPF sections
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-xdp_redirect-v2-1-b8f3ae53e894@bootlin.com>
References: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
In-Reply-To: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

SEC("redirect_to_111") and SEC("redirect_to_222") can't be loaded by the
__load() helper.

Rename both sections SEC("xdp") so it can be interpreted by the __load()
helper in upcoming patch.
Update the test_xdp_redirect.sh to use the program name instead of the
section name to load the BPF program.

Reviewed-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/progs/test_xdp_redirect.c | 4 ++--
 tools/testing/selftests/bpf/test_xdp_redirect.sh      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_redirect.c b/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
index b778cad454852ed3a1808aca665dd9f9cc2b6c7b..7025aee08a001cfc42e52174a4acce7869dd331b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_redirect.c
@@ -12,12 +12,12 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-SEC("redirect_to_111")
+SEC("xdp")
 int xdp_redirect_to_111(struct xdp_md *xdp)
 {
 	return bpf_redirect(111, 0);
 }
-SEC("redirect_to_222")
+SEC("xdp")
 int xdp_redirect_to_222(struct xdp_md *xdp)
 {
 	return bpf_redirect(222, 0);
diff --git a/tools/testing/selftests/bpf/test_xdp_redirect.sh b/tools/testing/selftests/bpf/test_xdp_redirect.sh
index 0746a4fde9d3181667c081698249a1b6dd1d7663..3c61a1c22b084aa5ca824ec5e8057aa2fee12b71 100755
--- a/tools/testing/selftests/bpf/test_xdp_redirect.sh
+++ b/tools/testing/selftests/bpf/test_xdp_redirect.sh
@@ -56,8 +56,8 @@ test_xdp_redirect()
 
 	ip -n ${NS1} link set veth11 $xdpmode obj xdp_dummy.bpf.o sec xdp &> /dev/null
 	ip -n ${NS2} link set veth22 $xdpmode obj xdp_dummy.bpf.o sec xdp &> /dev/null
-	ip link set dev veth1 $xdpmode obj test_xdp_redirect.bpf.o sec redirect_to_222 &> /dev/null
-	ip link set dev veth2 $xdpmode obj test_xdp_redirect.bpf.o sec redirect_to_111 &> /dev/null
+	ip link set dev veth1 $xdpmode obj test_xdp_redirect.bpf.o program xdp_redirect_to_222 &> /dev/null
+	ip link set dev veth2 $xdpmode obj test_xdp_redirect.bpf.o program xdp_redirect_to_111 &> /dev/null
 
 	if ip netns exec ${NS1} ping -c 1 10.1.1.22 &> /dev/null &&
 	   ip netns exec ${NS2} ping -c 1 10.1.1.11 &> /dev/null; then

-- 
2.47.1


