Return-Path: <linux-kselftest+bounces-21397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1B9BBD0D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4951C216F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399D1CFED4;
	Mon,  4 Nov 2024 18:14:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11D1CEAA2;
	Mon,  4 Nov 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744079; cv=none; b=Jfo7VjXUIOETEtbbLyVRpQax/RQb/M6QKnymAUCdQkDY/8UipXGOq0XEWPKNPUZBJ4Va3atJq8R/ql9oxVUCRHs9nRfTF5jdXw931/KelsMbic6PLYNusz8dAvbKkUBO2cc1KSFz3UmwWbijI4HYyUdhwozlJwiMGpgJnshVSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744079; c=relaxed/simple;
	bh=y5Y1WWPur0r7GUqVUucgWo9PNwZ1yB0cWjEIlX6ocu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r53PWyQjLR1QjnJkkmW1PQWGEHIpGytN/RZMmoWx4QHuvu4YgYxTL/u4KlOAsf1mhZ0lFZJXB+3WSl8K8pIhd0CDN3YHfMqDA/+/Fy3ou/V2x9PJFMesqDobd80g/dgDrlc5dHAcKz0b9nGVpvYXub6XbiBekVSU3pnt5JVTFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so3462965a91.2;
        Mon, 04 Nov 2024 10:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744077; x=1731348877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mqBFKOzCX+vYAYq1/XbPV8gP7Inl10PB2v9tAVaqmw=;
        b=B9pDt48azVYL6Ti21vvH/wNeGAocA0ozYxRzPLm0D+AlXNDpiTCptVNHliOnIbTtPE
         yO/mgppYmTpiuctZ4mue+FVAUshI/O6i2SziQYO80zi9Zh6PP1d34r0fbpgFQgAOl6pf
         vK1SBjpNkGhm1gNAD+FxZb/fm6y3Lzu27qwVkf9TV2ioq+V5Vg56Rj/Hf9YnDUTSRo5d
         +cYtUM/g/Q1M+sZ3RoNCEi1L6SHy+C5aHoqSjnM9gjveV0UX9pg4rj/0X6bDyZcW9CYI
         zi2Zo+uaosBsx4C6Or6YHRlwkAoz0xTyojA2B1GFYk5S0kZq+ARwwMWQ0lKKimRBPoRe
         8/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmeIc7mNSbVjVsh8EVBPYvfkGs6Dlg+TFI7b1HqJPfrTpDMbSh9VbEXFulnjB40b8uMBaaJBSKHJFpUafobw7p@vger.kernel.org, AJvYcCXxG3Hv/01OVvnr/qh95LGGlPyYkHeiLo2HA1daNl0NraTWQMoDbHmCZcPVHAuFom7RUW2PAGH9hQT1+EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlFvzC5K6NjHlpFHpBshITtIQzvf7UroAGAxx64G5cyX+kyv1w
	wpItXZFRsiw3qFN1wW0yki8nfsn/C/Tmlf1hmLCyezqhNwiCQc1sdfWA
X-Google-Smtp-Source: AGHT+IEpk5nkugWF502idtRX5Eo3MlRaWyLuyVGEduIL7g2hVEE7g4EM874/N7+3WXOb+JkNBc3K5w==
X-Received: by 2002:a17:90b:180d:b0:2e2:b204:90c5 with SMTP id 98e67ed59e1d1-2e8f11dced0mr38459320a91.33.1730744076703;
        Mon, 04 Nov 2024 10:14:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93da98480sm7985357a91.7.2024.11.04.10.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:36 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v7 04/12] selftests: ncdevmem: Make client_ip optional
Date: Mon,  4 Nov 2024 10:14:22 -0800
Message-ID: <20241104181430.228682-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104181430.228682-1-sdf@fomichev.me>
References: <20241104181430.228682-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support 3-tuple filtering by making client_ip optional. When -c is
not passed, don't specify src-ip/src-port in the filter.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 4733d1a0aab5..faa9dce121c7 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -62,7 +62,7 @@
  */
 
 static char *server_ip = "192.168.1.4";
-static char *client_ip = "192.168.1.2";
+static char *client_ip;
 static char *port = "5201";
 static size_t do_validation;
 static int start_queue = 8;
@@ -236,8 +236,14 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 
 static int configure_flow_steering(void)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d >&2",
-			   ifname, client_ip, server_ip, port, port, start_queue);
+	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+			   ifname,
+			   client_ip ? "src-ip" : "",
+			   client_ip ?: "",
+			   server_ip,
+			   client_ip ? "src-port" : "",
+			   client_ip ? port : "",
+			   port, start_queue);
 }
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
-- 
2.47.0


