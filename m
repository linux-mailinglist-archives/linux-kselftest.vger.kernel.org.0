Return-Path: <linux-kselftest+bounces-21115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02DB9B65D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84256283DCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A01F8EEC;
	Wed, 30 Oct 2024 14:27:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DDD1F76B1;
	Wed, 30 Oct 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298455; cv=none; b=F5FISFIj8ZiFJl22SFLbwYuDGlM8thYkAG8n8mASt6mO18fGAZcTdpWuiY2OFAhwbAWcnZxAAuzRxYR7Ni7A8MYVZddSbZKv3OwX2+xe4KW081JJqjtMVgPQLI9V2kq8gRU+6yEAdZJ8ZNLBDKL+kmSZ25vA5B2SkAGn5PWiAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298455; c=relaxed/simple;
	bh=Ie/Ptsq9qO1ESENyDMOnFQ6N1E2e+FpWUSYWB06bdOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tu9o5aPuCU19ednPfSQ1n5nYIZVl5zpzqySbfMQ6T88ZYwQ42BiZUFj/MTHQ7m20cvX0n68qoYuzgldQAVjGaE9eBBlZQxTXBaO3HS1CC1CVJn6dt/TEdAl7W+543/YbsmclD0xYUdFuRDTG4Kj1qjj/wtZ29epPIEwHMDkUwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca1b6a80aso65967425ad.2;
        Wed, 30 Oct 2024 07:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298453; x=1730903253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RMY5HztPWF4NWuW1QBTHPrJP1v43bJinxEr3M4sUnA=;
        b=uuplHFaW2wtdYWLEdTOF8RTkI3s/QZ0nesVvBFPx54M+r1O9uEOB+9cFTpyic0ET/6
         mtltgKUEsJEzRF/nsnduhm3Ti4Jye7agoHJmLnLK+2l65WRl71OeUIU4PoRojbh9+sSC
         D+dXZGV3m7cY+JRQWaP5/mb7My08JDIijAqHo18ADJ5aKEnIr1r/E7P8jDj1ghRZqq96
         b0+M+dmEVqtp83vBD+R8VPnlLLlo5JRYXzpRxJS2aXS6x7nxMTNO6g5b/zPZnG1kf/RR
         wb7wCUaBQISQ8MYFvFzYpdh4/g5xpKcDKx4zMM5bRzqr32boJUQ0w1rX9qA+Xk7QAwDE
         S74A==
X-Forwarded-Encrypted: i=1; AJvYcCUjeqtAiTSnsNioj7WiEeqjFuZWqUQMW/WoeSWZuP40cysyDdcLl2ExepbDbulueWv/Zf4oOOH//muwhyk=@vger.kernel.org, AJvYcCXHncnTVpxhx3uO01xCzRdSqDmMq9/gMigpyR0/OG6EifxEoRjCH8H73XyN7+3XRX644ts3SykX0Hw4cbuvrIt9@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIXBy3vYZmAwy0CeUakv3gCRMUAyUOjSYlPPY/G8aZ/7ozpap
	E0q7ndNNf5muCtsSVm+5vBQu8MmDBGXj+y4jIYYaWMtM/A/34pJPQvYA4Sg=
X-Google-Smtp-Source: AGHT+IF7WpuTgTe7n9pEyhkelv8MdxKn5f3fAEgcGmK2Nv+2M/7Z0RGaPxjCPQJeKEcz4PgKrcWXcg==
X-Received: by 2002:a17:902:e883:b0:20b:7210:5859 with SMTP id d9443c01a7336-210c6c75ad9mr227321995ad.38.1730298452831;
        Wed, 30 Oct 2024 07:27:32 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02edf3sm81512725ad.205.2024.10.30.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:32 -0700 (PDT)
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
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 07/12] selftests: ncdevmem: Properly reset flow steering
Date: Wed, 30 Oct 2024 07:27:17 -0700
Message-ID: <20241030142722.2901744-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
References: <20241030142722.2901744-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntuple off/on might be not enough to do it on all NICs.
Add a bunch of shell crap to explicitly remove the rules.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 8e4a0fe74bb1..697771c1f9fa 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -217,13 +217,18 @@ void validate_buffer(void *line, size_t size)
 
 static int reset_flow_steering(void)
 {
-	int ret = 0;
-
-	ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
-	if (ret)
-		return ret;
-
-	return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	/* Depending on the NIC, toggling ntuple off and on might not
+	 * be allowed. Additionally, attempting to delete existing filters
+	 * will fail if no filters are present. Therefore, do not enforce
+	 * the exit status.
+	 */
+
+	run_command("sudo ethtool -K %s ntuple off >&2", ifname);
+	run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	run_command(
+		"sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
+		ifname, ifname);
+	return 0;
 }
 
 static int configure_headersplit(bool on)
-- 
2.47.0


