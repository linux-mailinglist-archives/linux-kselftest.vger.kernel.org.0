Return-Path: <linux-kselftest+bounces-41413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495FB55552
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 19:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333405C57A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E8E32142F;
	Fri, 12 Sep 2025 17:06:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99808258ED9
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696775; cv=none; b=ePi/iM6l+EMrN/PWH/aaHL/3USxjhadBxWr381ZPoI6zeg5b0Pb9th52kWcJGXuaY5iRQuFVa2yXPIZRKCKX0WRXr+b8cUnX/6oh652P8w1UBcvSIrHV8AuiMQp569pA7SBbtUUQXbL4V12n04P6i7awCmBgijGsj8YTiqcMxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696775; c=relaxed/simple;
	bh=z7ODM4yeGOyCrC47UrkJKlQNImokfG0fkhm+U4ThvNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nulqfX6DOqHGBKniE+x3pLiEHeDRblN6OedpAKjQbKpLEQonbSAyFHBPx28K7NabQ68+jUErTN4oOk0kYpLEgvNTjiU8qpj9RnLTHLuCQdn9xcOQgLCYMju/gzE1OTRseFXbE8myKupeUQGuLqGxfmv+ap8sQ4Aq3V8Qm3Cdu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso1905153a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 10:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757696773; x=1758301573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xdln6TPyaoot6c1arftNTKI7b3e4E+Fw50+XLxdpB00=;
        b=EM84YxzKmsQCTAc3taCTsYSZzs5t4U131OYNLoqQlfM+BnNM8qvFV1Ql8l4BU/6mSZ
         MurA9fwke4X7D2Tg7ycgQqDhcP03wcfOMpXEBnj73MvVv4nyfNTGIKnCAJQE9ozV2ZIv
         ne6r7TL0rVpPQcpkwveEHR36c6L81fTRwHxe1iErl2L0SQLANmoikXJq4L2O2DS84Qd8
         pSnceYkoutMa0Cx8Ph1UfIkTujzbuYbREV0neR7Eod9zMGqO5ntTnjfBaOOQg7jnhj7B
         penG0E6hjXWBotFjY0PrueozbSi/LOwKL8tqMfMTiFBHPtlf4hH4sLDtQHr2vABnPW3r
         DGSw==
X-Forwarded-Encrypted: i=1; AJvYcCW/6p5QTaKAyePmHYkDSPnW1erWwesTOFQDc3pY0LHpStgtQfhYrVFWFEAfwgHpJr0aJ6EIqL1Pv95pt7fbcvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOWEGIMQOXKMC023HFRel2ymBuZAwpWCfp+AgJ84IiVuRu3ox
	czdRFiELjc4VlIbNMTH2Ul98iFVAW1mXF7kh/1j4eU6gDD+1eORgeNo=
X-Gm-Gg: ASbGnctd1NOgHpqHU1al5WEy4wnHKJGnHBc8168vBc39Gkl+zEE+RQde3nEXrV1mjfs
	kPKbKx0TvUmJYUyp9Nbk2QVFgS/GgKjJAQgwswX3M1AUnowdHDATkkZSOEN6PqISXp/bDFO+qil
	yjrnjGg6uDKCE1k/OeO5ZhI7p6X7a5jenp6Ake89S9VN7qhRMevjitzUkJaQ7iWFyLK8XlK/BYu
	D1+tTIKNEG1hn+o+GpIkXodbW2zdLbtCUcf8kr7WSnonf/pBicfxIOArkJNY0cabox+hDqXahmH
	645/FwWv4EMehy2NDuTh9gCXYYh6/5N+yS0ZAii9RrXwy6UlxP1+38oOBvQgjOv64K2ew39w3BO
	gvjkNXAGSS8ae5yD3ESuTwF4D0LkkDv6EeIvgHIkSu8N3fXRHSxzMBrtQh8nYJkXc0EZDRVWksI
	vJcl+MavkNrGRsvoNtn3zcEn1Ef+JzFBckaFOZOi8PsYUq0cveEVbQdu3Ib+Bk4SCFehHoRHjzf
	IG8
X-Google-Smtp-Source: AGHT+IGOdtov7MDgtAPJBxTWxT0eZs+wkblLgU6EWiyMAEUP1MXy6U8WZVCMX7DmcSMX0j7bBG/d6w==
X-Received: by 2002:a05:6a20:734a:b0:246:7032:2c1d with SMTP id adf61e73a8af0-2602a79259dmr4527604637.23.1757696772766;
        Fri, 12 Sep 2025 10:06:12 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a387cc21sm5204677a12.28.2025.09.12.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 10:06:12 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: ncdevmem: remove sleep on rx
Date: Fri, 12 Sep 2025 10:06:11 -0700
Message-ID: <20250912170611.676110-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RX devmem sometimes fails on NIPA:

https://netdev-3.bots.linux.dev/vmksft-fbnic-qemu-dbg/results/294402/7-devmem-py/

Both RSS and flow steering are properly installed, but the wait_port_listen
fails. Try to remove sleep(1) to see if the cause of the failure is
spending too much time during RX setup. I don't see a good reason to
have sleep in the first place. If there needs to be a delay between
installing the rules and receiving the traffic, let's add it to the
callers (devmem.py) instead.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index c0a22938bed2..3288ed04ce08 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -872,8 +872,6 @@ static int do_server(struct memory_buffer *mem)
 		goto err_reset_rss;
 	}
 
-	sleep(1);
-
 	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys)) {
 		pr_err("Failed to bind");
 		goto err_reset_flow_steering;
-- 
2.51.0


