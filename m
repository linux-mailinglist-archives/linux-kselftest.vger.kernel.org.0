Return-Path: <linux-kselftest+bounces-36298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2660AF122B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87474175D00
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222F12580EC;
	Wed,  2 Jul 2025 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8oFkd6g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCCF4C6E;
	Wed,  2 Jul 2025 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452999; cv=none; b=bx8Ip8R8BFxriCByQB+jS+p7MoNVuqWrmNW4RV5QecYLgwOsZXc2Vb0wa0HSSDaEV0YC4+hrEBPzvrk4U8sX6UK/pn30RngkkU2GSlRMUKDi6ZfuO8tR8w3NNBbhypitludwNBc0NkSre+1BXD6rf9/wamFs8YX+wdPIyIwKsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452999; c=relaxed/simple;
	bh=RHLJ9D48DllsGUWCN1uoEd21Mm8wSzcmeliizhoLpy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bhncK0RyPPm74ClZgX75qC1rAF0Euqt67pcKvppeoihQe4T/J0quGgHMPvcG6PyBjD4+CoDrp+uixOobVQgzNpfMhBpR8zhnjLcO83AYKJUVhXSFQP6wp1olStjRYGVouNl/xiJjpjTstHhCdlIczB9IGlRVYPEwqnhvOPHafcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8oFkd6g; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso4044144b3a.3;
        Wed, 02 Jul 2025 03:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751452997; x=1752057797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdPAwwrb4QJU2IWSSlyaWAnqCnTmtH2bZk+NO2oHIiA=;
        b=Q8oFkd6g03X6+RJo05Oae/BwHM4IqRUWtDU9EXA4UEK/Txbv73ZOpzOTf/jH9yLQ29
         QYVgY3VRNI+8QWPbRmE2drNQV9QJhhGwtbDmPrjiUl7yHpTp5JimZEV7nIAsR4t+WHq7
         UAupONbSUc/ErwBawa6cMS3RztwM+ZO53E/S2k0l62JyTOJpatvDIK066VbAhkrS2Y0A
         REmaIQHJmGpddE+JUP1g8WXEE50Z0Yu213Ml1jQiwog3QrpNTiKo3Ci14B/LdjPfWuZ2
         UCoYe+3KuUipUd/RF+wr14K3VeK7OdA+FZ3yKoUypxgF/n7ehuLCgVAgs+gttSSGpWzG
         StxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452997; x=1752057797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdPAwwrb4QJU2IWSSlyaWAnqCnTmtH2bZk+NO2oHIiA=;
        b=OF4/7pT4M1MR6iAboIK58hceMYFV+Ok82G46FVFoTE+hDhyFiOziJUSk9MhXBcPIiW
         wCi7WKJz9z/tAPDMigDz0rqTh/L+NNeYc0hWcZtS/e5DtxOxJIKlGUnq+dxYrtkGuqSP
         Y6o/at6g58zCiC4zmRm5h3GuH6JY8/LxlmGhrHxt1JBkLXjdjdffm0nrDPhxF9p9tgX+
         vLSziH207QD0UN4vi5+xehGb19kGEM1wPey2fg941LS/YX8xRD2kZFJcQY6N5rfQJ2sz
         s1NYGesNSB0upnDhC2XV6ooFAPN5nM63MlH11ZbHAdhlCzgDde5KYdSvLZPxAPlPwRZK
         I+lA==
X-Forwarded-Encrypted: i=1; AJvYcCUKpUShm5E8lgmIIMPNn/tUG6aWvqK2UbugzdPuWppZR3f9rfYyuwIXYtuomichmWNW15M3GvwAxNsN5QCdTQM=@vger.kernel.org, AJvYcCUcSddts3HLE/BDmDXYwnBVbmhVDglQlB61G6RlUoYM5JJjvjSH27HGnWLZ7NXHnpJX0EVYAxHY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5AGIyvPXm2fsK2yNIHI+x/XdzQO2491m/QZcOz7oWMGe7h91l
	U7E+pAPJZVYMHWKw8OX+p/+4okXSGeGtxUkU4Fz1vly6CuHTU8kXbrez
X-Gm-Gg: ASbGncvu04x1jra8JC9al47BsCTelL6b35sxwPreuGx/OFdk1fbbtJ2vdrGPBTRBO01
	h547Y+m+CyHdt83lkORZtXYcZXNVELCt0hm8p5+qFTyEcMDzc7I4fLajUZoTm8Sq6OV3WsNU4r4
	m5S0h2kU6abnlHaZHETXNNsXgeQSRf/Il/TzNY73V4ZL/29SvSA31teiO8hy4aagg5jhzbrc63s
	ftaJaMDHxcZO2Fl5KVgzN0BdM2oF0KrlReA48x4ao8ma7gOcDTq5V0wBJOfz1P2SQkR5XkRUFc0
	d1NHFSShNjd9UDQ6/TYKMrEJMH2/JRudzYQ+LXhkihBUNFZv29g=
X-Google-Smtp-Source: AGHT+IEeiHFvgdgKJjn0wBnclG5KXDNWT8Pp2yzRR3R/ETtmSUop97FYezDUkFO3sL3XSJBZmVb8HA==
X-Received: by 2002:a05:6a20:3ca3:b0:222:1802:2ddb with SMTP id adf61e73a8af0-222d7dc4e64mr5025821637.8.1751452996777;
        Wed, 02 Jul 2025 03:43:16 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af54099besm14064227b3a.9.2025.07.02.03.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:43:16 -0700 (PDT)
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
Subject: [PATCH v2 net-next] selftests: devmem: configure HDS threshold
Date: Wed,  2 Jul 2025 10:42:49 +0000
Message-Id: <20250702104249.1665034-1-ap420073@gmail.com>
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
Therefore, make configure_headersplit() sets hds-thresh value to 0.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Do not implement configure_hds_thresh().
 - Make configure_headersplit() sets hds-thresh to 0.

 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index cc9b40d9c5d5..52b72de11e3b 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -331,6 +331,12 @@ static int configure_headersplit(bool on)
 	ret = ethtool_rings_set(ys, req);
 	if (ret < 0)
 		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
+	if (on) {
+		ethtool_rings_set_req_set_hds_thresh(req, 0);
+		ret = ethtool_rings_set(ys, req);
+		if (ret < 0)
+			fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
+	}
 	ethtool_rings_set_req_free(req);
 
 	if (ret == 0) {
@@ -338,9 +344,12 @@ static int configure_headersplit(bool on)
 		ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
 		get_rsp = ethtool_rings_get(ys, get_req);
 		ethtool_rings_get_req_free(get_req);
-		if (get_rsp)
+		if (get_rsp) {
 			fprintf(stderr, "TCP header split: %s\n",
 				tcp_data_split_str(get_rsp->tcp_data_split));
+			fprintf(stderr, "HDS threshold: %u\n",
+				get_rsp->hds_thresh);
+		}
 		ethtool_rings_get_rsp_free(get_rsp);
 	}
 
-- 
2.34.1


