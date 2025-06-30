Return-Path: <linux-kselftest+bounces-36089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB9EAED8B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 11:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8841E175964
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA68244683;
	Mon, 30 Jun 2025 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Puj7tEQ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEC24466F;
	Mon, 30 Jun 2025 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275717; cv=none; b=VVxXUjrQ7HYzQhXu/LB7Z6KW16eUVqFyAES/r26lx/r09PvLQhviyN+Cc97xfzvxfZj1Xu+eyo10eGOiBrn6KI7c8DGOpEM+HLe0nEc/wGPL3LQpMfukRDkoIK1UnyhnC4VRiQyVmSCF/siOJQjoVahW71uF/yufYhiFFFMp/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275717; c=relaxed/simple;
	bh=OgoZlIwcqfBYPj566jJ4cwGVajH0pT5u+3ceMYzD10k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGx11B2mabXF/S5Dnh6O3LHgA9cA+6lhBmA2tNZIvcPhqFTolYjz/c+U4uL60pzdzTrGVnaFONK5uqmiqChiJPmV1mFpGzFl1Mb4Ax/V5EaYm6W4O1bwMpw5w4W3c//cJ1/b0j03NFHoecwqZ1uyFOEnOIfEAUfBMxTLvhuh4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Puj7tEQ0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235f9ea8d08so35442405ad.1;
        Mon, 30 Jun 2025 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751275715; x=1751880515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sliEIjUDTTtZyC7qVfsQ3ExQgCiQOs5+a76wwE4ZO3c=;
        b=Puj7tEQ0djJZjUKGCtNoT4xOGPwyiE1yc/3u6cHAoVeZ+SyATr7qzmDr5iLPxmBFIe
         /S2vVButElKRAAFcSpU5Yl449M/rBQ2J4KGCbVGjNXnllTMmX3r+pYz8Tm+ipbgjSv8m
         K1WyzWv4UqKM1OTz548EjuRaLRDHQ3Zk5ndXekcZ8BSLYvbCTvVJ8t13hWuJsyKKlO10
         JAXJmqyiHRVTlYIlMslRj6KE2u/Z+uYZ4jutejaIcQKmB5fb8RGiVIBQp7x2w4Xfb488
         p6ZFEzDS9oNly+wEsqlulQZy3KnSoKd8SU35rQSvH0t4C+9pFFlHEv1hvJV24L7Mv89c
         oeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751275715; x=1751880515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sliEIjUDTTtZyC7qVfsQ3ExQgCiQOs5+a76wwE4ZO3c=;
        b=nxYkOiFyRv07xA4bIZVEGzPj5ik/Tc8iD0taAde7vbrQrxhJhxYIwcUka8rpc0zKKm
         XDfSW82KAgv4lh51bUUi8GBRcYzueBLQOcjKWcMxnRILnCmvBouAudX7A11batFJ04CA
         Np+kQ8ouQfdYY56JTnkrdcs4+iVUcH5NljWmzkMlnhSQDH+cHasn1W3fv9fZRaFe+T/R
         wOEthKBGrNdCQ/ANpXNtzXUwx5nqQYU1y3G7XcLxW+TnXfLEADEYbHcMV6Txm5vywbpX
         ImkvU075gih50lflwDYpW4pOiOL2uvriQas13pmy0528V74baueptTV4d82jZUly9j6g
         mWFg==
X-Forwarded-Encrypted: i=1; AJvYcCVjG5Oe2aAvef3MHViAW6wc9phoIGUcNJs7046ts/F2NsIU5KYFvVR0Fq6EmCWJqcNzY8/YS5thyjyDTF0DB9U=@vger.kernel.org, AJvYcCXsg7aAoxllMD+SREApvRp8wZhC4NfuIxdMMc+vugIp8g1cEcxMAw48xF5EBsdiTAXvZeQUIBBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLk+n/78JK09A05wc9eNVzmXJAa92W3wEPV/wC+xx8Xy5JBHF
	rHqrvGs6rXDlAuk7DL7IVxRotkSfF7W2B5DbGdrcB8JfHyxxgBKxVbLR
X-Gm-Gg: ASbGncv3GqmTjyBGD2DdmWihwxLgMN3H6b+MynkNaCDW7M+BxVMthJe9arHqRcumy4e
	OUSUeWxOPKxo8JPHrR9ZOPLiEXnvuuJCKmhz/b9GPIatWYuOePZhitk78dZ4Rawf7plHLUzhpIJ
	bvxT+qje+BpY/DveNfZTa9VDekZ5dFANcUy3LJ7XZgXOxAf6Ak2YTFUnLERhHX+r3YnPZqj5lLw
	hsrUHmkWb9xVAk3EYkbM6B8dQzKiTGbDdI4qJOwNlah0wB8NqGpmmCRV4jz9MYBcxPwcLXzSGz4
	ymybW/tZoDwLQDphCNoFYIDusANyOxnvTOMhtxyImCLgJSKnxQAWnbuOnT8Vgw==
X-Google-Smtp-Source: AGHT+IHJ9dEJsKboQSPVDTL/XzoJCHvGp4KRbINg9vBL0g23ZHzt/cYfbQlX/mEQD2+7NAgcZmgW4g==
X-Received: by 2002:a17:902:f709:b0:234:c5c1:9b73 with SMTP id d9443c01a7336-23ac465d9cfmr227553895ad.36.1751275714824;
        Mon, 30 Jun 2025 02:28:34 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39f488sm79734795ad.132.2025.06.30.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:28:34 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH net-next] selftests: devmem: configure HDS threshold
Date: Mon, 30 Jun 2025 09:28:18 +0000
Message-Id: <20250630092818.1449599-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devmem TCP requires the hds-thresh value to be 0, but it doesn't
change it automatically.
Therefore, configure_hds_thresh() is added to handle this.

The run_devmem_tests() now tests hds_thresh, but it skips test if the
hds_thresh_max value is 0.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index cc9b40d9c5d5..d78b5e5697d7 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -349,6 +349,72 @@ static int configure_headersplit(bool on)
 	return ret;
 }
 
+static int configure_hds_thresh(int len)
+{
+	struct ethtool_rings_get_req *get_req;
+	struct ethtool_rings_get_rsp *get_rsp;
+	struct ethtool_rings_set_req *req;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ret;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = ethtool_rings_set_req_alloc();
+	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
+	ethtool_rings_set_req_set_hds_thresh(req, len);
+	ret = ethtool_rings_set(ys, req);
+	if (ret < 0)
+		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
+	ethtool_rings_set_req_free(req);
+
+	if (ret == 0) {
+		get_req = ethtool_rings_get_req_alloc();
+		ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
+		get_rsp = ethtool_rings_get(ys, get_req);
+		ethtool_rings_get_req_free(get_req);
+		if (get_rsp)
+			fprintf(stderr, "HDS threshold: %d\n",
+				get_rsp->hds_thresh);
+		ethtool_rings_get_rsp_free(get_rsp);
+	}
+
+	ynl_sock_destroy(ys);
+
+	return ret;
+}
+
+static int get_hds_thresh_max(void)
+{
+	struct ethtool_rings_get_req *get_req;
+	struct ethtool_rings_get_rsp *get_rsp;
+	struct ynl_error yerr;
+	unsigned int ret = 0;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	get_req = ethtool_rings_get_req_alloc();
+	ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
+	get_rsp = ethtool_rings_get(ys, get_req);
+	ethtool_rings_get_req_free(get_req);
+	if (get_rsp)
+		ret = get_rsp->hds_thresh_max;
+	ethtool_rings_get_rsp_free(get_rsp);
+
+	ynl_sock_destroy(ys);
+
+	return ret;
+}
+
 static int configure_rss(void)
 {
 	return run_command("sudo ethtool -X %s equal %d >&2", ifname, start_queue);
@@ -565,6 +631,9 @@ static int do_server(struct memory_buffer *mem)
 	if (configure_headersplit(1))
 		error(1, 0, "Failed to enable TCP header split\n");
 
+	if (configure_hds_thresh(0))
+		error(1, 0, "Failed to set HDS threshold\n");
+
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
 		error(1, 0, "Failed to configure rss\n");
@@ -725,10 +794,14 @@ static int do_server(struct memory_buffer *mem)
 void run_devmem_tests(void)
 {
 	struct memory_buffer *mem;
+	int hds_thresh_max = 0;
 	struct ynl_sock *ys;
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
 
+	hds_thresh_max = get_hds_thresh_max();
+	if (hds_thresh_max < 0)
+		error(1, 0, "Failed to get hds_thresh_max");
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
 		error(1, 0, "rss error\n");
@@ -750,6 +823,19 @@ void run_devmem_tests(void)
 	if (configure_headersplit(1))
 		error(1, 0, "Failed to configure header split\n");
 
+	/* Do not test hds_thresh if hds_thresh_max value is 0 */
+	if (hds_thresh_max) {
+		if (configure_hds_thresh(1))
+			error(1, 0, "Failed to configure HDS threshold\n");
+
+		if (!bind_rx_queue(ifindex, mem->fd, create_queues(),
+				   num_queues, &ys))
+			error(1, 0, "Configure dmabuf with non-zero HDS threshold should have failed\n");
+
+		if (configure_hds_thresh(0))
+			error(1, 0, "Failed to configure HDS threshold\n");
+	}
+
 	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
 		error(1, 0, "Failed to bind\n");
 
-- 
2.34.1


