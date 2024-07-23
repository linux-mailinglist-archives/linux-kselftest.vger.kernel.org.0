Return-Path: <linux-kselftest+bounces-14118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805F93A957
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2971C225CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0561428E5;
	Tue, 23 Jul 2024 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlWCgZgm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E2288D1;
	Tue, 23 Jul 2024 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773872; cv=none; b=HrBx/bWY8MiWA5oRx6eaFFBtFM96PIMsBl5fi23rDB06AijhFm5hdOLqnxfb7g/mTuz051gexzBJNzz0nxXP+3Jf5ETvPwkcLOY3zN+PnxA0VwupKmPqqKPIa7keZrJBohZc8CL0My1qxOPTJnsYtpgjZsUU+LWoefTGx6Jn1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773872; c=relaxed/simple;
	bh=IxBRar1RxH89c3TNuKgry7Njs57mT04USb7aaNO0aFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GwqhrJkeYswzbcnl7ffLJLuDKKVtH815xjZwXZ3Co2xAYV2SGDroYlQTMZOzYbdxoSxK9sOmIcrK+vzVpX9QGNLqBiTs5QthdpG9AQZK5OgPja0nFybvP0CT9ib5pyZ6ulFJHtzLWwqHaftYc0/IdqvFUj1hOqpUzgpPOpmmV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlWCgZgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F83C4AF09;
	Tue, 23 Jul 2024 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773872;
	bh=IxBRar1RxH89c3TNuKgry7Njs57mT04USb7aaNO0aFM=;
	h=From:To:Cc:Subject:Date:From;
	b=IlWCgZgmE18s7gUIX33ab9+TiYNgSArnBFSsBpEWH9JQoLa4QjkY8tD5HKD2Z/Zzt
	 dSjY13vNr2PIxRd+0ufUbvCK86Rbd9FQCwf7jdbgf9wRQwk+/DnWmBV/HCA5MCofVK
	 sqmyrYsTzSi6HL/4vYTLIkzsKWSnbPuaV2wstEaeJ7gocgSLvkYZ4VKy+qMF4I/vY3
	 fHVZmXRSpNgblqXsZpRn0YA5sI8AkRx/jvwAo1wugyzD0rCzXPeYsRmh9HD+gee3O7
	 q946DsnCvY+0NhVTdWL6XyejDnWlrrzl1W+dDcmDFIApAEs/RmBmQJCoTmLJHUWuGf
	 C0mRQx+mdVthA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	willemdebruijn.kernel@gmail.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	shuah@kernel.org,
	arefev@swemel.ru,
	virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] virtio: fix GSO with frames unaligned to size
Date: Tue, 23 Jul 2024 15:31:09 -0700
Message-ID: <20240723223109.2196886-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit under fixes added a questionable check to
virtio_net_hdr_to_skb(). I'm guessing the check was supposed
to protect from csum offset being outside of a segment
(especially if len is not multiple of segment size).

The condition can't be right, tho, as it breaks previously
working sending of GSO frames with only one segment
(i.e. when gso_size <= len we silently ignore the GSO
request and send a single non-GSO frame).

Fix the logic and move it to the GSO part.

This has been caught by net/tap and net/psock_send.sh tests.

Fixes: e269d79c7d35 ("net: missing check virtio")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: willemdebruijn.kernel@gmail.com
CC: mst@redhat.com
CC: jasowang@redhat.com
CC: xuanzhuo@linux.alibaba.com
CC: eperezma@redhat.com
CC: shuah@kernel.org
CC: arefev@swemel.ru
CC: virtualization@lists.linux.dev
CC: linux-kselftest@vger.kernel.org
---
 include/linux/virtio_net.h        | 27 ++++++++++++++++-----------
 tools/testing/selftests/net/tap.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d1d7825318c3..c54b7aa42921 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -52,11 +52,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 					bool little_endian)
 {
 	unsigned int nh_min_len = sizeof(struct iphdr);
+	unsigned int csum_needed = 0;
 	unsigned int gso_type = 0;
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
 	unsigned int ip_proto;
-	u64 ret, remainder, gso_size;
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -99,16 +99,6 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
 		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
 
-		if (hdr->gso_size) {
-			gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
-			ret = div64_u64_rem(skb->len, gso_size, &remainder);
-			if (!(ret && (hdr->gso_size > needed) &&
-						((remainder > needed) || (remainder == 0)))) {
-				return -EINVAL;
-			}
-			skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
-		}
-
 		if (!pskb_may_pull(skb, needed))
 			return -EINVAL;
 
@@ -119,6 +109,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		p_off = nh_min_len + thlen;
 		if (!pskb_may_pull(skb, p_off))
 			return -EINVAL;
+
+		csum_needed = needed;
 	} else {
 		/* gso packets without NEEDS_CSUM do not set transport_offset.
 		 * probe and drop if does not match one of the above types.
@@ -188,6 +180,19 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (gso_size == GSO_BY_FRAGS)
 			return -EINVAL;
 
+		if (csum_needed) {
+			unsigned int p_rem, p_size;
+
+			p_size = gso_size;
+			p_rem = (skb->len - nh_off) % gso_size;
+			if (p_rem)
+				p_size = p_rem;
+
+			/* Make sure csum still within packet after GSO */
+			if (p_size + nh_off < csum_needed)
+				return -EINVAL;
+		}
+
 		/* Too small packets are not really GSO ones. */
 		if (skb->len - nh_off > gso_size) {
 			shinfo->gso_size = gso_size;
diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..8527d51449cf 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -418,6 +418,36 @@ TEST_F(tap, test_packet_valid_udp_csum)
 	ASSERT_EQ(ret, off);
 }
 
+TEST_F(tap, test_packet_invalid_udp_gso_csum)
+{
+	uint8_t pkt[TEST_PACKET_SZ];
+	uint16_t payload;
+	size_t off;
+	int ret;
+	int i;
+
+	payload = ETH_DATA_LEN - sizeof(struct iphdr) - sizeof(struct udphdr);
+
+	memset(pkt, 0, sizeof(pkt));
+	off = build_test_packet_valid_udp_gso(pkt, payload);
+
+	for (i = -16; i < 16; i++) {
+		ret = write(self->fd, pkt, off + i);
+
+		if (i <= 0 ||
+		    i > __builtin_offsetof(struct udphdr, check) + 1) {
+			EXPECT_EQ(ret, off + i)
+				TH_LOG("mismatch with offset: %d (%zd)",
+				       i, off + i);
+		} else {
+			EXPECT_EQ(ret, -1)
+				TH_LOG("mismatch with offset: %d (%zd)",
+				       i, off + i);
+			EXPECT_EQ(errno, 22);
+		}
+	}
+}
+
 TEST_F(tap, test_packet_crash_tap_invalid_eth_proto)
 {
 	uint8_t pkt[TEST_PACKET_SZ];
-- 
2.45.2


