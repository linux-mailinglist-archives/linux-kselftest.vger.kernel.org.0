Return-Path: <linux-kselftest+bounces-46179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF50C77398
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 501CC31EAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 04:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8982E7BA0;
	Fri, 21 Nov 2025 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+Sueozl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DA2E7167;
	Fri, 21 Nov 2025 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697792; cv=none; b=hqSeyeHjmtau1ShI5a4ShuKrvifGPpXLuGBIbwEKU2vZy34uQt6Jyy2aSu+MIs1JAa3SicwscAVQZpiwpTmYQOwdZFs7r61mrY4X0kzFPqQ2Idv7gRelU1o0mRiLqwz2Hqgav/Jnx0vEipjBoTquDcQT89KKru/TD3tnde1La30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697792; c=relaxed/simple;
	bh=La8fww2px4d3Lxfdubrxwta7HLe1uoWj6Y6RB67Z/zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+1YmLl1zQewDSk885xBzY7HQblPnWxZmNMnWr8ICPt75lRLgvVA+oh/UzM+HwNiJvvOHTKOfUKLl27LPuGOLwiOSkXkaFMUbuTOPIbNBgtUeCxd6CSzNhaDei3XoB/aW0UdphTGoGLLH1I/J85Kfd5s9+egA5efndsmt5gXyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+Sueozl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E52C4CEF1;
	Fri, 21 Nov 2025 04:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763697792;
	bh=La8fww2px4d3Lxfdubrxwta7HLe1uoWj6Y6RB67Z/zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+SueozlBJNUC1lo8KdHbTUmB91ps+R//eed0vo59ECgh73zPPTe7IkIXoJIOoyHV
	 lRL7/72Y7CMSjvm1gWve2ZZcle6q7WPBJ54eZpYjW6elXtzPbucrWjcVD+vJ6MX7hJ
	 cGLw4+RHx8s+xGqZ5n3Qt4mtqaPwCSh9gyWZv6NVOP8LvjBaBDPE1HWpuBRLYnXuak
	 3X6qXj62RA7iwRW+AFu1RjttAtOAmiHErnTnETyctQrUbAKs40K3xOYoRNfUv2PLnN
	 slJ8px3WJfOlExGQ2M1Mvs/zO75cKLXANU6stdtbjdACKrt3cUBK1BJU8YYG1eHOVt
	 +uhY8NKziTo5A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	dw@davidwei.uk,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] selftests: hw-net: toeplitz: read indirection table from the device
Date: Thu, 20 Nov 2025 20:02:58 -0800
Message-ID: <20251121040259.3647749-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121040259.3647749-1-kuba@kernel.org>
References: <20251121040259.3647749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the simple modulo math with the real indirection table
read from the device. This makes the tests pass for mlx5 and
bnxt NICs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/toeplitz.c       | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
index 7420a4e201cc..a4d04438c313 100644
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
@@ -68,6 +68,7 @@
 #define FOUR_TUPLE_MAX_LEN	((sizeof(struct in6_addr) * 2) + (sizeof(uint16_t) * 2))
 
 #define RSS_MAX_CPUS (1 << 16)	/* real constraint is PACKET_FANOUT_MAX */
+#define RSS_MAX_INDIR	(1 << 16)
 
 #define RPS_MAX_CPUS 16UL	/* must be a power of 2 */
 
@@ -105,6 +106,8 @@ struct ring_state {
 static unsigned int rx_irq_cpus[RSS_MAX_CPUS];	/* map from rxq to cpu */
 static int rps_silo_to_cpu[RPS_MAX_CPUS];
 static unsigned char toeplitz_key[TOEPLITZ_KEY_MAX_LEN];
+static unsigned int rss_indir_tbl[RSS_MAX_INDIR];
+static unsigned int rss_indir_tbl_size;
 static struct ring_state rings[RSS_MAX_CPUS];
 
 static inline uint32_t toeplitz(const unsigned char *four_tuple,
@@ -133,7 +136,12 @@ static inline uint32_t toeplitz(const unsigned char *four_tuple,
 /* Compare computed cpu with arrival cpu from packet_fanout_cpu */
 static void verify_rss(uint32_t rx_hash, int cpu)
 {
-	int queue = rx_hash % cfg_num_queues;
+	int queue;
+
+	if (rss_indir_tbl_size)
+		queue = rss_indir_tbl[rx_hash % rss_indir_tbl_size];
+	else
+		queue = rx_hash % cfg_num_queues;
 
 	log_verbose(" rxq %d (cpu %d)", queue, rx_irq_cpus[queue]);
 	if (rx_irq_cpus[queue] != cpu) {
@@ -517,6 +525,20 @@ static void read_rss_dev_info_ynl(void)
 
 	memcpy(toeplitz_key, rsp->hkey, rsp->_len.hkey);
 
+	if (rsp->_count.indir > RSS_MAX_INDIR)
+		error(1, 0, "RSS indirection table too large (%u > %u)",
+		      rsp->_count.indir, RSS_MAX_INDIR);
+
+	/* If indir table not available we'll fallback to simple modulo math */
+	if (rsp->_count.indir) {
+		memcpy(rss_indir_tbl, rsp->indir,
+		       rsp->_count.indir * sizeof(rss_indir_tbl[0]));
+		rss_indir_tbl_size = rsp->_count.indir;
+
+		log_verbose("RSS indirection table size: %u\n",
+			    rss_indir_tbl_size);
+	}
+
 	ethtool_rss_get_rsp_free(rsp);
 	ethtool_rss_get_req_free(req);
 	ynl_sock_destroy(ys);
-- 
2.51.1


