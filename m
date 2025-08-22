Return-Path: <linux-kselftest+bounces-39727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BB8B32353
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3051D61B19
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE62D7DEE;
	Fri, 22 Aug 2025 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMIotKCl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7F2D7818;
	Fri, 22 Aug 2025 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892864; cv=none; b=Fr8Pb/ZXeAS/5Dlfr/CIk3AYGVf0yZwwnS9TYPYQMNlcMIDqAZVqMB++J9epyuRhWD7a1HNtjG/iP8mw95hJ0Mlu80Nl8Xcf5fFpDvSh0GcRRiuzuMH4e01v3FzydnqSf736hWe4Ad1scyTOT2iodNOg28MvtTKriYLH/rP7eAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892864; c=relaxed/simple;
	bh=WDt7Pt83T9As4xzpxbE437hPrLEWyy7Ay3wxsq+8j4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU1TQjw57lVl6RucOW0TqUi7swXuf6vp+RhL020Qx6u+D2xLVWxpwUghvi95TW8i9iYTiltxWYrvJf8VoVFLQVSFca8Ld5DZAx55KVtvWXmZM5pJ/zANWOr2SoXLgjE//cbvmMUW1qUZ6/Q0hqyDgeBereGRRDJjCuALQmJvvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMIotKCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD60C19424;
	Fri, 22 Aug 2025 20:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755892863;
	bh=WDt7Pt83T9As4xzpxbE437hPrLEWyy7Ay3wxsq+8j4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMIotKClbScBgQ3Q6N+TnJpX95HnnDYaSnNHqv87P4L/Hsuo2lMDdEfE+VFZnoONW
	 uhlFlsKfX2wbNVs7rxaq+TUHVPUbsm4LqPjCcgtqi3uQ60cBXL8ADN+4R28B5KoBZ6
	 3bR7ONC4VMsuYiwHdyC5T1gYgjw8Z4edrPvH0shhIXD2sIPlP0yWHWFiXR6sWQD4lp
	 E2n8v9Trjq+URruLwn4kAamlrF1RwES+E/01qpgdimg5Hlp1Ayp6fHxLJbILUDVkYS
	 skzCQi9FcDMvrFYbgtuliHahoaALpnYHRM2eD/xjtE6zXvgeqWOk+GT/ADtnCd6Jt8
	 8WRl9aE9KndeA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] selftests: drv-net: ncdevmem: restore old channel config
Date: Fri, 22 Aug 2025 13:00:51 -0700
Message-ID: <20250822200052.1675613-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822200052.1675613-1-kuba@kernel.org>
References: <20250822200052.1675613-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case changing channel count with provider bound succeeds
unexpectedly - make sure we return to original settings.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 34 ++++++++++++-------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 8d9d579834b1..580b4459a840 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -469,7 +469,7 @@ static void reset_rss(void)
 	run_command("ethtool -X %s default >&2", ifname, start_queue);
 }
 
-static int configure_channels(unsigned int rx, unsigned int tx)
+static int check_changing_channels(unsigned int rx, unsigned int tx)
 {
 	struct ethtool_channels_get_req *gchan;
 	struct ethtool_channels_set_req *schan;
@@ -525,20 +525,32 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 			ethtool_channels_set_req_set_tx_count(schan, tx - rx);
 		}
 
-		ret = ethtool_channels_set(ys, schan);
-		if (ret)
-			fprintf(stderr, "YNL set channels: %s\n", ys->err.msg);
 	} else if (chan->_present.rx_count) {
 		ethtool_channels_set_req_set_rx_count(schan, rx);
 		ethtool_channels_set_req_set_tx_count(schan, tx);
-
-		ret = ethtool_channels_set(ys, schan);
-		if (ret)
-			fprintf(stderr, "YNL set channels: %s\n", ys->err.msg);
 	} else {
 		fprintf(stderr, "Error: device has neither combined nor rx channels\n");
 		ret = -1;
+		goto exit_free_schan;
 	}
+
+	ret = ethtool_channels_set(ys, schan);
+	if (ret) {
+		fprintf(stderr, "YNL set channels: %s\n", ys->err.msg);
+	} else {
+		/* We were expecting a failure, go back to previous settings */
+		ethtool_channels_set_req_set_combined_count(schan,
+							    chan->combined_count);
+		ethtool_channels_set_req_set_rx_count(schan, chan->rx_count);
+		ethtool_channels_set_req_set_tx_count(schan, chan->tx_count);
+
+		ret = ethtool_channels_set(ys, schan);
+		if (ret)
+			fprintf(stderr, "YNL un-setting channels: %s\n",
+				ys->err.msg);
+	}
+
+exit_free_schan:
 	ethtool_channels_set_req_free(schan);
 exit_free_chan:
 	ethtool_channels_get_rsp_free(chan);
@@ -1019,16 +1031,14 @@ int run_devmem_tests(void)
 	}
 
 	/* Deactivating a bound queue should not be legal */
-	if (!configure_channels(num_queues, num_queues)) {
+	if (!check_changing_channels(num_queues, num_queues)) {
 		pr_err("Deactivating a bound queue should be illegal");
-		goto err_reset_channels;
+		goto err_unbind;
 	}
 
 	err = 0;
 	goto err_unbind;
 
-err_reset_channels:
-	/* TODO */
 err_unbind:
 	ynl_sock_destroy(ys);
 err_reset_headersplit:
-- 
2.50.1


