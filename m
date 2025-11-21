Return-Path: <linux-kselftest+bounces-46178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEC4C77395
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B7784306E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324622E6CA6;
	Fri, 21 Nov 2025 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAlN9qV2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9862E54BD;
	Fri, 21 Nov 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697792; cv=none; b=RIpF/CUelRp/YOQJZBYGesMy6NsF4jUFtJSxflL30kgvWNbd6mQ0Xhqzyt/M/Mkarg3HuNDm35M/nrYA7qm28sudPMVnsMjaKprNaG8SeypMZhhqryStj3Si6Pdd6TKPQ4xwB7lcv0paR++oMJ0HwchGlqqvoQYA8QORnrYCqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697792; c=relaxed/simple;
	bh=DgQu6fda/tRMrRW7O66hMyKgQhsZ86Exet7Y/AgYe+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ert7LWKlnYrtBvoToH8wBk8rJUeXks9BW/GxddcV/ZAqFAQ8qTUfToVFrhcWdXz35uY+TmDz5qtMygKL/BTQ1lg7Fly3kdYUUvodX9nuvMaWLZqW0x1U+ZjMcfk91t9o9PVI5Ij+iBTCLHorwmIrzDdyfRBpX8AehxYYoEB9l7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAlN9qV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E577BC19423;
	Fri, 21 Nov 2025 04:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763697791;
	bh=DgQu6fda/tRMrRW7O66hMyKgQhsZ86Exet7Y/AgYe+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAlN9qV2DFbflu8Om4vkCYGyjlvTw7a05Y80NMvy2hGbh3tLYEyVhNHVpiOYjwpBH
	 fOGAfaSHmLifPcSLFhwl2SAk8QRN7VIwbBXEt1F9bi68zBDoyuE/jOaCuFtpnUi6Dy
	 /Mq9pF5ihUvFfnidvL3EfhnX0AW3YOlhH9lH2kvyTJ7s9gLEmKsK1ReYNZePIdE9Cq
	 e8tmUGrIp5cC54Su0FiKa5Xbayq7E/Omo2swlZueEKgJdUQO0RVLlqi6GgHHj2vgWU
	 eHSSXf+5jwbLvY6u5hv5WHEqvinyqXWdDGq+5eoCRBicACkOZkGQaacIR7PgTam/+5
	 KjZ80pB1IG9QA==
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
Subject: [PATCH net-next 3/5] selftests: hw-net: toeplitz: read the RSS key directly from C
Date: Thu, 20 Nov 2025 20:02:57 -0800
Message-ID: <20251121040259.3647749-4-kuba@kernel.org>
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

Now that we have YNL support for RSS accessing the RSS info from
C is very easy. Instead of passing the RSS key from Python do it
directly in the C code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |  6 ++-
 .../selftests/drivers/net/hw/toeplitz.c       | 41 ++++++++++++++++++-
 .../selftests/drivers/net/hw/toeplitz.py      |  5 ---
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 949aeeeb357d..7c819fdfa107 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,7 +15,6 @@ endif
 
 TEST_GEN_FILES := \
 	$(COND_GEN_FILES) \
-	toeplitz \
 # end of TEST_GEN_FILES
 
 TEST_PROGS = \
@@ -55,7 +54,10 @@ TEST_INCLUDES := \
 	#
 
 # YNL files, must be before "include ..lib.mk"
-YNL_GEN_FILES := ncdevmem
+YNL_GEN_FILES := \
+	ncdevmem \
+	toeplitz \
+# end of YNL_GEN_FILES
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
 
diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
index afc5f910b006..7420a4e201cc 100644
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
@@ -52,6 +52,9 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#include <ynl.h>
+#include "ethtool-user.h"
+
 #include "../../../kselftest.h"
 #include "../../../net/lib/ksft.h"
 
@@ -483,6 +486,42 @@ static void parse_rps_bitmap(const char *arg)
 			rps_silo_to_cpu[cfg_num_rps_cpus++] = i;
 }
 
+static void read_rss_dev_info_ynl(void)
+{
+	struct ethtool_rss_get_req *req;
+	struct ethtool_rss_get_rsp *rsp;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, NULL);
+	if (!ys)
+		error(1, errno, "ynl_sock_create failed");
+
+	req = ethtool_rss_get_req_alloc();
+	if (!req)
+		error(1, errno, "ethtool_rss_get_req_alloc failed");
+
+	ethtool_rss_get_req_set_header_dev_name(req, cfg_ifname);
+
+	rsp = ethtool_rss_get(ys, req);
+	if (!rsp)
+		error(1, ys->err.code, "YNL: %s", ys->err.msg);
+
+	if (!rsp->_len.hkey)
+		error(1, 0, "RSS key not available for %s", cfg_ifname);
+
+	if (rsp->_len.hkey < TOEPLITZ_KEY_MIN_LEN ||
+	    rsp->_len.hkey > TOEPLITZ_KEY_MAX_LEN)
+		error(1, 0, "RSS key length %u out of bounds [%u, %u]",
+		      rsp->_len.hkey, TOEPLITZ_KEY_MIN_LEN,
+		      TOEPLITZ_KEY_MAX_LEN);
+
+	memcpy(toeplitz_key, rsp->hkey, rsp->_len.hkey);
+
+	ethtool_rss_get_rsp_free(rsp);
+	ethtool_rss_get_req_free(req);
+	ynl_sock_destroy(ys);
+}
+
 static void parse_opts(int argc, char **argv)
 {
 	static struct option long_options[] = {
@@ -551,7 +590,7 @@ static void parse_opts(int argc, char **argv)
 	}
 
 	if (!have_toeplitz)
-		error(1, 0, "Must supply rss key ('-k')");
+		read_rss_dev_info_ynl();
 
 	num_cpus = get_nprocs();
 	if (num_cpus > RSS_MAX_CPUS)
diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
index 642a5cc385b6..945c58d23310 100755
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
@@ -156,10 +156,6 @@ ETH_RSS_HASH_TOP = 1
                                   "hfunc": rss.get('hfunc'),
                                   "input-xfrm": rss.get('input-xfrm', {})
                                   })
-        # Refresh in case changing hfunc changes things.
-        rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
-
-    key = ':'.join(f'{b:02x}' for b in rss["hkey"])
 
     port = rand_port(socket.SOCK_DGRAM)
 
@@ -170,7 +166,6 @@ ETH_RSS_HASH_TOP = 1
         proto_flag,
         "-d", str(port),
         "-i", cfg.ifname,
-        "-k", key,
         "-T", "1000",
         "-s",
         "-v"
-- 
2.51.1


