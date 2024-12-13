Return-Path: <linux-kselftest+bounces-23325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2919F1056
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 16:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F55284396
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB11E3765;
	Fri, 13 Dec 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DzHPTXt+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8601E231F;
	Fri, 13 Dec 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102458; cv=none; b=PtHhjgRWWjAe1P4wOFIoCz3iw4+3o8w8zYxt8auMnV6o91Sf3ns69MK6xrwXFSb3RvCzz0VVSWljIWPBxsNyxZs2wASSt8ndaLzN7uKT4QTxMTsdulEiPnEoEVry/1T8tanqpMPVgwX3xy99WltA7TjDwjj8VWBEhqmuIhVgnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102458; c=relaxed/simple;
	bh=bnEbn3CujnN83vLQm/WOWv+T+v3MHKR7OIRFzBENolM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3GBXhudGt0cRBF1Sdcu6eJlPYhTIZ/8G62OZ3rWLmlfWwJ27YspKI3NiqGC6neQgULTHOUn0bAYNC+98IGGsuO7N/ywbdXOjBktthhiy9HDdPNgJvWVuElOkjmTbBLNzC6dko25AdbyuZ4zd/A8jPy0EOnPX0BS9Dg0Ih8VJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DzHPTXt+; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83C494000B;
	Fri, 13 Dec 2024 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734102448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Or7+rx4R//1Hmn+698riCJsFcFYwFbW8Po0XkdG2iPY=;
	b=DzHPTXt+9PCAnX65IzSFodaBfnP8owv83e6BgKGZJUnUblLdAw68LSnoC8Aqa3k4bQ0p4f
	bjWGCWvKopENCom5h+eU1BXmWwZZtVsedmoBtbnoPvYDug9UcmzvGSqX3JqlKW0PZMzCzh
	oSjhyVpLtY57Ql3VjAlxjsnD0weSPjmj0wfewswo1oo4YyKGeB0wA3Ntn5sPtzNoID6IfL
	+iqQkzXOnK3wPwXRuRt8lzAkI+j+mtSdt+Op+Xe88KMvTReRd+yRTw/0hb/V6aoLabS6+v
	+qvwj0kb57bgoK7jm+N4Arq5TSSPyZIo5P3EvoRD59phEIcl+yERiKygjz9Xfw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Fri, 13 Dec 2024 16:06:20 +0100
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: test_xdp_meta: Rename BPF
 sections
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-xdp_meta-v2-1-634582725b90@bootlin.com>
References: <20241213-xdp_meta-v2-0-634582725b90@bootlin.com>
In-Reply-To: <20241213-xdp_meta-v2-0-634582725b90@bootlin.com>
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
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

SEC("t") and SEC("x") can't be loaded by the __load() helper.

Rename these sections SEC("tc") and SEC("xdp") so they can be
interpreted by the __load() helper in upcoming patch.
Update the test_xdp_meta.sh to fit these new names.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c | 4 ++--
 tools/testing/selftests/bpf/test_xdp_meta.sh      | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index a7c4a7d49fe6b54b5841e36bcbe9ae9c8577df38..fe2d71ae0e717a32bd2b3a891da8e0d6fa3eba2c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -8,7 +8,7 @@
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
 #define ctx_ptr(ctx, mem) (void *)(unsigned long)ctx->mem
 
-SEC("t")
+SEC("tc")
 int ing_cls(struct __sk_buff *ctx)
 {
 	__u8 *data, *data_meta, *data_end;
@@ -28,7 +28,7 @@ int ing_cls(struct __sk_buff *ctx)
 	return diff ? TC_ACT_SHOT : TC_ACT_OK;
 }
 
-SEC("x")
+SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {
 	__u8 *data, *data_meta, *data_end;
diff --git a/tools/testing/selftests/bpf/test_xdp_meta.sh b/tools/testing/selftests/bpf/test_xdp_meta.sh
index 2740322c1878b3687d9cc4295f81a40042dd24c6..6039b92f10949d48cd9d703d6981ae8a9388e8df 100755
--- a/tools/testing/selftests/bpf/test_xdp_meta.sh
+++ b/tools/testing/selftests/bpf/test_xdp_meta.sh
@@ -43,11 +43,11 @@ ip netns exec ${NS2} ip addr add 10.1.1.22/24 dev veth2
 ip netns exec ${NS1} tc qdisc add dev veth1 clsact
 ip netns exec ${NS2} tc qdisc add dev veth2 clsact
 
-ip netns exec ${NS1} tc filter add dev veth1 ingress bpf da obj ${BPF_FILE} sec t
-ip netns exec ${NS2} tc filter add dev veth2 ingress bpf da obj ${BPF_FILE} sec t
+ip netns exec ${NS1} tc filter add dev veth1 ingress bpf da obj ${BPF_FILE} sec tc
+ip netns exec ${NS2} tc filter add dev veth2 ingress bpf da obj ${BPF_FILE} sec tc
 
-ip netns exec ${NS1} ip link set dev veth1 xdp obj ${BPF_FILE} sec x
-ip netns exec ${NS2} ip link set dev veth2 xdp obj ${BPF_FILE} sec x
+ip netns exec ${NS1} ip link set dev veth1 xdp obj ${BPF_FILE} sec xdp
+ip netns exec ${NS2} ip link set dev veth2 xdp obj ${BPF_FILE} sec xdp
 
 ip netns exec ${NS1} ip link set dev veth1 up
 ip netns exec ${NS2} ip link set dev veth2 up

-- 
2.47.0


