Return-Path: <linux-kselftest+bounces-39871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E337FB349B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD743AC1AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7A30AAC5;
	Mon, 25 Aug 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPqSsWs0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EEA3093A7;
	Mon, 25 Aug 2025 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145097; cv=none; b=dA5YtuFlZzmsFYjxmZZZvrzkx4+5Py4SJOymsxJXYRb1AbylWen3qyDTm5yfxwqTWKB5j97AuwKbuvA71YK5xvyp29D06UGIYnNEgU6332yy4hyehGiVsMtOC2GuRjoTGpHWrfyxEonszpQcSqaL7GR9Q2SiXkbmnfeSLcG1I9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145097; c=relaxed/simple;
	bh=i9u//ww7fVdqWn0pCiVoayfm0PHSqzPW1j+eoueIiJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkjpUG/qkaLEaZaBMqVHm9WHZ3rD8JF9JjgRmHKZxsmTyFCWDkrDpPgi2NCo9BeyKnd7ip1FWja9ic/JuV45tA4Tey9SA0yR6oQ4oY3AToAyHMxkGe3TXqpeuvOz5I6ObsnA/ruo8VS8YvUbus5erxPh8cylbFjKxa5UIdLz7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPqSsWs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E01AC19422;
	Mon, 25 Aug 2025 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145097;
	bh=i9u//ww7fVdqWn0pCiVoayfm0PHSqzPW1j+eoueIiJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPqSsWs0y27Y1Q4otkbNEH4PrWnRADjcO9TOigU1pIbt6j8+YjMmNCI1CcO76UT+N
	 T75b9fgB2YDhV/pzsDq+4lBiGnhYnrnIGaYj9qrF1jg8MbXHawsO/qos5u8fwn8dLA
	 UfCMqpOpfLL3tAX644HLn52dKWkjWwkyXAYGR/Z7dQ2GYeqJZR0LyIi25160jqW6J6
	 ZXSyBetGZS+7dZsfnEUDTAp4OkyUubQscou4HyaKcvnUo6TQsojolkh2IerxG5/OvP
	 P0V55+0bV8hP6I9KJXHHW9hEQbBWRmZ1d7XLnnxpR3jhw/rKzWl63bzROzJ1a9t01n
	 1De6qZN+UJoBQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/5] selftests: drv-net: ncdevmem: restore old channel config
Date: Mon, 25 Aug 2025 11:04:45 -0700
Message-ID: <20250825180447.2252977-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825180447.2252977-1-kuba@kernel.org>
References: <20250825180447.2252977-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case changing channel count with provider bound succeeds
unexpectedly - make sure we return to original settings.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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
2.51.0


