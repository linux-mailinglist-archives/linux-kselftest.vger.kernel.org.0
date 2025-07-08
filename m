Return-Path: <linux-kselftest+bounces-36773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA60AFDA7F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E350B585C97
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE325393B;
	Tue,  8 Jul 2025 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma9mDGMg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013C253925;
	Tue,  8 Jul 2025 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012409; cv=none; b=MjzHrXYDuSicJP5z0S2qz1WQJRqMdNoo/5/XF9wHQdMK1UukPTAUmWSuARQEGID/SViOBGRuteDGb7VsKHNefIdYaXif1FAO9LeOHj2kunYuLnpyzYUwlAUv5ezPLif6lCnq53zCE+MJqjEsBLxT6Pg5MlXADgpawAw3hleDT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012409; c=relaxed/simple;
	bh=PROTRSPmUjfEVbW+LlABdhCzB5Ft2IckYzCLxX8yhF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBXHDLEo4I4eHRsPZwB0N7yEpGcJ/QW4WxwFkKwgzFqTIWKRiI6Rbqkxz2NRpzo8MppY1CNiGTQbY6g79rBgJVhtG4J+cvsL/CGIj9O9rPmvqZ90UphMKxwqcuWCnNrMeamoyz0Mh9Tm4GkuXbfc5Qg8cRVx52Yy5KZ7iIU0xJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma9mDGMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334E9C4CEF8;
	Tue,  8 Jul 2025 22:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752012408;
	bh=PROTRSPmUjfEVbW+LlABdhCzB5Ft2IckYzCLxX8yhF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ma9mDGMglq6Mxr7J+KQ/Efgm9HAzmBO7thPEYuJRIFlRfZwhYDbuifmjor+YJytKh
	 Ifo8aVXZC+HU2IHNsQzUPtvxu8+0SpbPMrC8gDyPIj4Htu/UrczwgUjTvA95M2nLXk
	 FIpXIEsWnAn+/5bTho2YfxMDsyhC0zeSKTPTvmGeJvtz4OxONUtWDkh4N8gUcgYkbt
	 Wq51O0NpivvUHqPHvXhxzRMbWKyChvw5YpHP9BMpBVdXY1XRmkLgP8ChYrHfbeGnNB
	 V2pKiY8+VZklWGxHDyiyhS/folI/+T8gwDH0WN4VznRRrnJktFxVcLzH9sxh9y/+xC
	 G8HhM9N3lO4Jg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	maxime.chevallier@bootlin.com,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] ethtool: rss: make sure dump takes the rss lock
Date: Tue,  8 Jul 2025 15:06:36 -0700
Message-ID: <20250708220640.2738464-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708220640.2738464-1-kuba@kernel.org>
References: <20250708220640.2738464-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 040cef30b5e6 ("net: ethtool: move get_rxfh callback
under the rss_lock") we're expected to take rss_lock around get.
Switch dump to using the new prep helper and move the locking into it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/rss.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 4e8ca2c38175..37a7b20fcd07 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -64,6 +64,7 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
+	mutex_lock(&dev->ethtool->rss_lock);
 
 	data->indir_size = 0;
 	data->hkey_size = 0;
@@ -77,7 +78,7 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 	rss_config = kzalloc(total_size, GFP_KERNEL);
 	if (!rss_config) {
 		ret = -ENOMEM;
-		goto out_ops;
+		goto out_unlock;
 	}
 
 	if (data->indir_size)
@@ -92,11 +93,12 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 
 	ret = ops->get_rxfh(dev, &rxfh);
 	if (ret)
-		goto out_ops;
+		goto out_unlock;
 
 	data->hfunc = rxfh.hfunc;
 	data->input_xfrm = rxfh.input_xfrm;
-out_ops:
+out_unlock:
+	mutex_unlock(&dev->ethtool->rss_lock);
 	ethnl_ops_complete(dev);
 	return ret;
 }
@@ -108,12 +110,16 @@ rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
 	struct ethtool_rxfh_context *ctx;
 	u32 total_size, indir_bytes;
 	u8 *rss_config;
+	int ret;
 
 	data->no_key_fields = !dev->ethtool_ops->rxfh_per_ctx_key;
 
+	mutex_lock(&dev->ethtool->rss_lock);
 	ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
-	if (!ctx)
-		return -ENOENT;
+	if (!ctx) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
 
 	data->indir_size = ctx->indir_size;
 	data->hkey_size = ctx->key_size;
@@ -123,8 +129,10 @@ rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
 	indir_bytes = data->indir_size * sizeof(u32);
 	total_size = indir_bytes + data->hkey_size;
 	rss_config = kzalloc(total_size, GFP_KERNEL);
-	if (!rss_config)
-		return -ENOMEM;
+	if (!rss_config) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
 
 	data->indir_table = (u32 *)rss_config;
 	memcpy(data->indir_table, ethtool_rxfh_context_indir(ctx), indir_bytes);
@@ -135,7 +143,10 @@ rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
 		       data->hkey_size);
 	}
 
-	return 0;
+	ret = 0;
+out_unlock:
+	mutex_unlock(&dev->ethtool->rss_lock);
+	return ret;
 }
 
 static int
@@ -156,7 +167,6 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 	struct rss_req_info *request = RSS_REQINFO(req_base);
 	struct net_device *dev = reply_base->dev;
 	const struct ethtool_ops *ops;
-	int ret;
 
 	ops = dev->ethtool_ops;
 	if (!ops->get_rxfh)
@@ -166,11 +176,7 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 	if (request->rss_context && !ops->create_rxfh_context)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&dev->ethtool->rss_lock);
-	ret = rss_prepare(request, dev, data, info);
-	mutex_unlock(&dev->ethtool->rss_lock);
-
-	return ret;
+	return rss_prepare(request, dev, data, info);
 }
 
 static int
@@ -294,11 +300,7 @@ rss_dump_one_ctx(struct sk_buff *skb, struct netlink_callback *cb,
 	if (ret < 0)
 		goto err_cancel;
 
-	/* Context 0 is not currently storred or cached in the XArray */
-	if (!rss_context)
-		ret = rss_prepare_get(&req, dev, &data, info);
-	else
-		ret = rss_prepare_ctx(&req, dev, &data, info);
+	ret = rss_prepare(&req, dev, &data, info);
 	if (ret)
 		goto err_cancel;
 
-- 
2.50.0


