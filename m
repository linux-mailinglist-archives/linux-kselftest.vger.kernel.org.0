Return-Path: <linux-kselftest+bounces-22904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85549E688F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 09:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985C1283324
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1A1DF983;
	Fri,  6 Dec 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EtCsGQm6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33721B532F;
	Fri,  6 Dec 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472769; cv=none; b=SGBqLKe1yqGGnsQNrXHK9sQMZFlyP6FGUESGHN3sx+I3VSZQUljV5T08IgN7l7obqFXGV7OvTYonWEdgo3lx88y3JD4T6hvjGH3hKtoRWcIfdIPi4qSoNnp9LFx7PATVSyYHui94NOUSGoi7x3U0xL3gfwz92CPiRf1ZCTyNicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472769; c=relaxed/simple;
	bh=bnEbn3CujnN83vLQm/WOWv+T+v3MHKR7OIRFzBENolM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bSbAd1OBptsYvx4msMlSxg7LLps/ifnTZO9/LugC0A8EpEIs725tCOiGnxA53Saum7EKGK+7zyHjgyfMMVPC9h53xZRDcepjY1e66lJVKD/18O7aXSj0eVa8iMWkZy+Nto34sO+L31WRdfEMEbDxYR2Nu48qxmcMAbjO1jdJmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EtCsGQm6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDFC940006;
	Fri,  6 Dec 2024 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733472757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Or7+rx4R//1Hmn+698riCJsFcFYwFbW8Po0XkdG2iPY=;
	b=EtCsGQm6o+O79Pzpgt0WzKhQdo8Gru2AMtltjixihlpyF9Te15SR//6fXS8tNDlzKlbNR3
	si2aIgeRKNjbVDPkFNAkd4voXQrTMLS3G+j+p5RpYskgd5pzfix8w785sxkojzmZyKnfNs
	n9VEFSk1j+eri5kuQhcIIWgyvL1lzvxGuqse4fiB5MuAFIcKA75vyIdSwJuP1JF5/RboHy
	TCNBz9VHjE46ulSh55t5GVzCehT5w29Dii6ChFhDs77dFI3bm9dlawra+tRWGbPbYcxw6Z
	5RwcBa89/aWk7soGhkYSmAWGR97Rhg7Wk23Vm8CchpXlL+j+4NUogETN19bvag==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Fri, 06 Dec 2024 09:12:13 +0100
Subject: [PATCH bpf-next 1/2] selftests/bpf: test_xdp_meta: Rename BPF
 sections
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-xdp_meta-v1-1-5c150618f6e9@bootlin.com>
References: <20241206-xdp_meta-v1-0-5c150618f6e9@bootlin.com>
In-Reply-To: <20241206-xdp_meta-v1-0-5c150618f6e9@bootlin.com>
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


