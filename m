Return-Path: <linux-kselftest+bounces-18020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF5979BD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 09:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215801C22575
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 07:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D18130499;
	Mon, 16 Sep 2024 07:13:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A14174C;
	Mon, 16 Sep 2024 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470803; cv=none; b=JPxA+Z23BV0dbvy1WONG0iUWFBFGtjS8xxmL/pRxon9w7+3TxY6unbDJp04xSMz8tyFSBgtdiYHuEyclFrKa5pg8axFRDv6pHKDgK0nyzoQAfo/Uq+7FXArgOXgTbKFIL9t0jK5O1/kwixjzx+jUtIhIGbfNHA6jvkC5e+MSxxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470803; c=relaxed/simple;
	bh=ZaE3JPjtRaAYCYIkE3022YmPKGJtBMPOLnJUVzEdaQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQiN59nBaEyyXUKvlD8CwCMiG8jFHrXZd/Q3p9k7Z5t4LxD/zKFwXMOxfbXaZtWL+252URF9KztiZO8oSXwt+nLuTgN6i9mx//6A5NXFPKoG7x0+0WEG1N8GH/GBKFa137P1ARv8kfDQcmYtSnenZSkaBd7jX/K5gyGqQOPzw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6bd32w2Wz6L78S;
	Mon, 16 Sep 2024 15:09:27 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id C16E0140516;
	Mon, 16 Sep 2024 15:13:11 +0800 (CST)
Received: from china (10.221.233.88) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 09:13:03 +0200
From: <gur.stavi@huawei.com>
To: <akihiko.odaki@daynix.com>
CC: <andrew@daynix.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <jasowang@redhat.com>, <kuba@kernel.org>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mst@redhat.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <virtualization@lists.linux-foundation.org>,
	<willemdebruijn.kernel@gmail.com>, <xuanzhuo@linux.alibaba.com>,
	<yuri.benditovich@daynix.com>
Subject: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
Date: Mon, 16 Sep 2024 10:12:53 +0300
Message-ID: <20240916071253.462-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240915-rss-v3-2-c630015db082@daynix.com>
References: <20240915-rss-v3-2-c630015db082@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

+
+static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
+				       const __be32 *input, size_t len)

The function calculates a hash value but its name does not make it
clear. Consider adding a 'calc'.

+{
+	u32 key;
+
+	while (len) {
+		state->key++;
+		key = be32_to_cpu(*state->key);

You perform be32_to_cpu to support both CPU endianities.
If you will follow with an unconditional swab32, you could run the
following loop on a more natural 0 to 31 always referring to bit 0
and avoiding !!(key & bit):

key = swab32(be32_to_cpu(*state->key));
for (i = 0; i < 32; i++, key >>= 1) {
	if (be32_to_cpu(*input) & 1)
		state->hash ^= state->key_buffer;
	state->key_buffer = (state->key_buffer << 1) | (key & 1);
}


+
+		for (u32 bit = BIT(31); bit; bit >>= 1) {
+			if (be32_to_cpu(*input) & bit)
+				state->hash ^= state->key_buffer;
+
+			state->key_buffer =
+				(state->key_buffer << 1) | !!(key & bit);
+		}
+
+		input++;
+		len--;
+	}
+}
+
+static inline u32 virtio_net_hash_report(u32 types,
+					 struct flow_dissector_key_basic key)
+{
+	switch (key.n_proto) {
+	case htons(ETH_P_IP):

Other parts of the code use be_to_cpu and cpu_to_be, Why use legacy
htons here?

+		if (key.ip_proto == IPPROTO_TCP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
+			return VIRTIO_NET_HASH_REPORT_TCPv4;
+
+		if (key.ip_proto == IPPROTO_UDP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
+			return VIRTIO_NET_HASH_REPORT_UDPv4;
+
+		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
+			return VIRTIO_NET_HASH_REPORT_IPv4;
+
+		return VIRTIO_NET_HASH_REPORT_NONE;
+
+	case htons(ETH_P_IPV6):
+		if (key.ip_proto == IPPROTO_TCP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
+			return VIRTIO_NET_HASH_REPORT_TCPv6;
+
+		if (key.ip_proto == IPPROTO_UDP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
+			return VIRTIO_NET_HASH_REPORT_UDPv6;
+
+		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
+			return VIRTIO_NET_HASH_REPORT_IPv6;
+
+		return VIRTIO_NET_HASH_REPORT_NONE;
+
+	default:
+		return VIRTIO_NET_HASH_REPORT_NONE;
+	}
+}
 #endif /* _LINUX_VIRTIO_NET_H */

-- 
2.46.0


