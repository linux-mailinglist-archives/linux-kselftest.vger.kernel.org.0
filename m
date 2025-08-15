Return-Path: <linux-kselftest+bounces-39127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E3B288AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 01:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CECE5C029C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 23:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC32D0C9E;
	Fri, 15 Aug 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtnhH5xv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269C24111D;
	Fri, 15 Aug 2025 23:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299719; cv=none; b=u1RQkTmJwKRJwYB8dft26AX+6TYmN9Ym0KdyfT14azxZTvB3rKWgtf3XmZQ1XAshBKa6phM1zI85n0h9m0UvZXd5PGi8wkRwERuJlDXBOBkGE4LDaK9s09wO2Fzwq0XYy39VfUKuUR3xCFcDHichvXjmFtiqNby+hzKUonjE3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299719; c=relaxed/simple;
	bh=hPX8Rw2XYN37yKZbsN7yXqiMNoy09Tv+WYuJAcD6nII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGpZxAFCemCxlf1hUWKc4NmCFWwIA5PENlyQzYFpuAEflRn2xYnzAkcQFWqUubJvqknplmzmDQK89FkXbHiegjEfbZCjes7qjFoA1KI3kq/LhEkvWjWV8iUtj2Z4gMBq1gNNnyoxufE6J1nphdsydqWfwnX4Xm/3e6GYWMWAkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtnhH5xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2EAC4CEEB;
	Fri, 15 Aug 2025 23:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755299718;
	bh=hPX8Rw2XYN37yKZbsN7yXqiMNoy09Tv+WYuJAcD6nII=;
	h=From:To:Cc:Subject:Date:From;
	b=dtnhH5xvHX8H8IodstPBQ08aVqaAqh0yShDzWQQlxZ9Wlsnqi3c5gP9A3tTIcUnQH
	 8MEAI51T62zjfK4gRiuMtJ60Qw7Dgk+OfPD4ZT+NJ2dsjMray8SB1NbCyiX1432OzX
	 Ayjx+yQ3I3ScKnYKbV9zHwy7uFWfD9FuFzE3Vf81OAmtrrmbUUthdBKzaSxueOdJRp
	 /HGZb1+JqpdTcEkCsyXu1FK4w8DrKc5XsWdEru49qluaIL61w5wDTqL7D66MFCFqxZ
	 QwGYjVtEoICijnEALToEcKRl0Gu4D1OcqPtSd/l7majGYCLeCFY7Gv7IbWldk5r8N0
	 Pu4wj8aWkAEDA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: ncdevmem: make configure_channels() support combined channels
Date: Fri, 15 Aug 2025 16:15:13 -0700
Message-ID: <20250815231513.381652-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ncdevmem tests that the kernel correctly rejects attempts
to deactivate queues with MPs bound.

Make the configure_channels() test support combined channels.
Currently it tries to set the queue counts to rx N tx N-1,
which only makes sense for devices which have IRQs per ring
type. Most modern devices used combined IRQs/channels with
both Rx and Tx queues. Since the math is total Rx == combined+Rx
setting Rx when combined is non-zero will be increasing the total
queue count, not decreasing as the test intends.

Note that the test would previously also try to set the Tx
ring count to Rx - 1, for some reason. Which would be 0
if the device has only 2 queues configured.

With this change (device with 2 queues):
  setting channel count rx:1 tx:1
  YNL set channels: Kernel error: 'requested channel counts are too low for existing memory provider setting (2)'

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: almasrymina@google.com
CC: sdf@fomichev.me
CC: joe@dama.to
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 78 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index be937542b4c0..71961a7688e6 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -356,7 +356,81 @@ static int configure_rss(void)
 
 static int configure_channels(unsigned int rx, unsigned int tx)
 {
-	return run_command("ethtool -L %s rx %u tx %u", ifname, rx, tx);
+	struct ethtool_channels_get_req *gchan;
+	struct ethtool_channels_set_req *schan;
+	struct ethtool_channels_get_rsp *chan;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ret;
+
+	fprintf(stderr, "setting channel count rx:%u tx:%u\n", rx, tx);
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	gchan = ethtool_channels_get_req_alloc();
+	if (!gchan) {
+		ret = -1;
+		goto exit_close_sock;
+	}
+
+	ethtool_channels_get_req_set_header_dev_index(gchan, ifindex);
+	chan = ethtool_channels_get(ys, gchan);
+	ethtool_channels_get_req_free(gchan);
+	if (!chan) {
+		fprintf(stderr, "YNL get channels: %s\n", ys->err.msg);
+		ret = -1;
+		goto exit_close_sock;
+	}
+
+	schan =	ethtool_channels_set_req_alloc();
+	if (!schan) {
+		ret = -1;
+		goto exit_free_chan;
+	}
+
+	ethtool_channels_set_req_set_header_dev_index(schan, ifindex);
+
+	if (chan->_present.combined_count) {
+		if (chan->_present.rx_count || chan->_present.tx_count) {
+			ethtool_channels_set_req_set_rx_count(schan, 0);
+			ethtool_channels_set_req_set_tx_count(schan, 0);
+		}
+
+		if (rx == tx) {
+			ethtool_channels_set_req_set_combined_count(schan, rx);
+		} else if (rx > tx) {
+			ethtool_channels_set_req_set_combined_count(schan, tx);
+			ethtool_channels_set_req_set_rx_count(schan, rx - tx);
+		} else {
+			ethtool_channels_set_req_set_combined_count(schan, rx);
+			ethtool_channels_set_req_set_tx_count(schan, tx - rx);
+		}
+
+		ret = ethtool_channels_set(ys, schan);
+		if (ret)
+			fprintf(stderr, "YNL set channels: %s\n", ys->err.msg);
+	} else if (chan->_present.rx_count) {
+		ethtool_channels_set_req_set_rx_count(schan, rx);
+		ethtool_channels_set_req_set_tx_count(schan, tx);
+
+		ret = ethtool_channels_set(ys, schan);
+		if (ret)
+			fprintf(stderr, "YNL set channels: %s\n", ys->err.msg);
+	} else {
+		fprintf(stderr, "Error: device has neither combined nor rx channels\n");
+		ret = -1;
+	}
+	ethtool_channels_set_req_free(schan);
+exit_free_chan:
+	ethtool_channels_get_rsp_free(chan);
+exit_close_sock:
+	ynl_sock_destroy(ys);
+
+	return ret;
 }
 
 static int configure_flow_steering(struct sockaddr_in6 *server_sin)
@@ -752,7 +826,7 @@ void run_devmem_tests(void)
 		error(1, 0, "Failed to bind\n");
 
 	/* Deactivating a bound queue should not be legal */
-	if (!configure_channels(num_queues, num_queues - 1))
+	if (!configure_channels(num_queues, num_queues))
 		error(1, 0, "Deactivating a bound queue should be illegal.\n");
 
 	/* Closing the netlink socket does an implicit unbind */
-- 
2.50.1


