Return-Path: <linux-kselftest+bounces-22058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E59C94D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C294DB23ECE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 21:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CF31BCA05;
	Thu, 14 Nov 2024 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fuf1Lgpf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D81B85CC;
	Thu, 14 Nov 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621087; cv=none; b=V4JSPVyfvpVg0s87PtypGz36HfAoGbDRJUgA4Gvoo6d90Li43Mz0zVPj6T01P6KS0GjnUuj0s26knWx6RaEtARJrRaaaxhaMQAJ5rLxLZaUXb740+SK7uhtoHRNWqXoSojAKxD2CASs7oL0mbUw/NaV/xx0R3fBLVL6xYommie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621087; c=relaxed/simple;
	bh=YPQiOC9aOJWqicDS7aua9VR5sIV67YW4n5A91CjeZHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CI31JoZ88OszpZQ7rrVp3h2pxMhVC1lPHJoEqLDsfL6bV+tJs49hu2QTbjdh7xmvQ5tFaXmYbM+Vbucv1xMSEH2cotXkg/brWNJw26SRnoSZ9x2s1xqoDmWMoi755SsEoM2uqAfbk1abZ/m7APOqsLg0B2l0rMoW2NU+spdjNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fuf1Lgpf; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABBF420002;
	Thu, 14 Nov 2024 21:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731621084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2EhZZNVRnVzmHpK5fTy5h6wNrHDRoVN7MKX2iSvp9cg=;
	b=fuf1Lgpf/lgKEiI5pUvHzKET08Kf63rdf0qAuvNHNrjVwbomMWWfU2CXn6g6kUGqS3c6GY
	74b7Jg/qIi0itkEH9m45+HtuK32shNwYgTaOEP/BghuSroTnVe3/f0Ns/QxdQlpBlJgNMD
	UIFvosGYY2z1zvN/crPoTt5u+//deN7/XRdabRt5m6x8W7odMStlECI7h5lSolH/yDLpEN
	jf4LdQ7Z2h5NX7FeQf4akjuN9I4Ihny6Q2B3XO/WTTVuUmmU7gMd7D1YHJt4i61ogvW5If
	oX696DPNyx+ueyAn4UV+ugkTY3/sb+neuRjqzWj5b4SvRIkOt4XOip6jSssWmw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 14 Nov 2024 22:50:40 +0100
Subject: [PATCH bpf-next v2 09/13] selftests/bpf: move ip checksum helper
 to network helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241114-flow_dissector-v2-9-ee4a3be3de65@bootlin.com>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
In-Reply-To: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

xdp_metadata test has a small helper computing ipv checksums to allow
manually building packets.

Move this helper to network_helpers to share it with other tests.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- new patch
---
 tools/testing/selftests/bpf/network_helpers.h      | 23 ++++++++++++++++++++++
 .../selftests/bpf/prog_tests/xdp_metadata.c        | 19 +-----------------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index c72c16e1aff825439896b38e59962ffafe92dc71..c9b72960c651ab9fb249f6eb9e153b8416b7a488 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -104,6 +104,29 @@ static __u16 csum_fold(__u32 csum)
 	return (__u16)~csum;
 }
 
+static unsigned long add_csum_hword(const __u16 *start, int num_u16)
+{
+	unsigned long sum = 0;
+	int i;
+
+	for (i = 0; i < num_u16; i++)
+		sum += start[i];
+
+	return sum;
+}
+
+static inline __sum16 build_ip_csum(struct iphdr *iph)
+{
+	__u32 sum = 0;
+	__u16 *p;
+
+	iph->check = 0;
+	p = (void *)iph;
+	sum = add_csum_hword(p, iph->ihl << 1);
+
+	return csum_fold(sum);
+}
+
 static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 					__u32 len, __u8 proto,
 					__wsum csum)
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index c87ee2bf558c1a7fb726cae0aa7b3d3735fb1aac..7f8e161655336127e5bd7a573d1a09db85a92f53 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -133,23 +133,6 @@ static void close_xsk(struct xsk *xsk)
 	munmap(xsk->umem_area, UMEM_SIZE);
 }
 
-static void ip_csum(struct iphdr *iph)
-{
-	__u32 sum = 0;
-	__u16 *p;
-	int i;
-
-	iph->check = 0;
-	p = (void *)iph;
-	for (i = 0; i < sizeof(*iph) / sizeof(*p); i++)
-		sum += p[i];
-
-	while (sum >> 16)
-		sum = (sum & 0xffff) + (sum >> 16);
-
-	iph->check = ~sum;
-}
-
 static int generate_packet(struct xsk *xsk, __u16 dst_port)
 {
 	struct xsk_tx_metadata *meta;
@@ -192,7 +175,7 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	iph->protocol = IPPROTO_UDP;
 	ASSERT_EQ(inet_pton(FAMILY, TX_ADDR, &iph->saddr), 1, "inet_pton(TX_ADDR)");
 	ASSERT_EQ(inet_pton(FAMILY, RX_ADDR, &iph->daddr), 1, "inet_pton(RX_ADDR)");
-	ip_csum(iph);
+	iph->check = build_ip_csum(iph);
 
 	udph->source = htons(UDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);

-- 
2.47.0


