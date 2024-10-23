Return-Path: <linux-kselftest+bounces-20473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0AA9ACF33
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8FDB27F9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840261CDA14;
	Wed, 23 Oct 2024 15:44:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B401CBEA9;
	Wed, 23 Oct 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698250; cv=none; b=Uema5djTKxQPZtgQN0oLKGGt6UVQITBdKZZVLWEi7bEIIus+DTkUOxeuuj23gSVkhCO515IZZOPHLQ3waeHg5/9TGu/VWhfSvtQhFDP3QXVP4TDYXeBgNlk9U95dYqQpiNeuNQhVMFrv4nwGFUJPM9gYH3X7N1WdtY+0/y0eKXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698250; c=relaxed/simple;
	bh=cLZ/HloOGC0PMG4sMhRkkQxtcn8WnnLKy6YyEv7N6mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTSiHpcRhpf//IKtsBCyXDAOjDOskjREzkYRNSZjrAIqTRExfKe77J5JzEhmSShd3M1qovT5rS5bFYjlzwSH9I/yONhXXP8C5/jjM048Ejl3ieQAzEnGOs+EPM+cEZd+Jh6OF+sbFRvqNhPXFoTFbr0lS0TrJxfWLwKijfh1mI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso4534876a12.3;
        Wed, 23 Oct 2024 08:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698248; x=1730303048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JG/ONzrCW+sST5tBBAYNuLx/AbByhvZTDB5rCiNmSS4=;
        b=N91utPYTvY/UYDivzbA1g2DaNxBVzHtd36ZOdo03CemrtylTSxHyJ3NgbWLY3PgivS
         ALbD9g0zjW8ZIabPM34ginM/1Fcgc2pbSQhgVJynh7QJZh7x2Nlrhs9LjzGhQH2JUv9J
         dVwf1kf/PN7hRDi1eVlwosUOvEKNmK7Ynx03HXaZi2l+Cf5iwiFBmhzWRekD2w0a3xoB
         6f4ttzY78gxg2qwb8lC/D5EzMOw84bFMf699QbolJpM0sDRJOiSWE0x77l5Xq6FClyam
         UcylVFP6ocGGMRtcrIIz5GA3yWE/yfPZtyR5a4TDH7SOBnQuQuBVlmfkiXfl6J/nm5rE
         kYPw==
X-Forwarded-Encrypted: i=1; AJvYcCWqRmDHjmoWXWyGFR8b0PtCWMSqAIJPghhXV5OxYIWMFhHQJF7s1gH6e8A+MCccqXtw91o0merybrBIThQ=@vger.kernel.org, AJvYcCX+mnTC5TUlosCbMb5hn00hmBa4qEzNoMGc94yX0O57N0dk65Ih0b2DZX1Qn6XKsKG5b8j9s8r3V911OSwsY323@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGCfsBAefA5k9MjYllrqF8Cu1YFp7rCy2mLdhfJBTo8Q3US7+
	c62OvpWNFtBWJ75DnCM3s1Xn3/9isq48EDXwK35hDEDWatG7/O/hN0ROcAc=
X-Google-Smtp-Source: AGHT+IEDepy9ucFyZHPrSHloe/rBoO+atm93Zb5yszpwpBIjPGbZKilEeYzqRxKM7Id1rrBOKW/I4w==
X-Received: by 2002:a05:6a20:d528:b0:1d9:28ae:5e72 with SMTP id adf61e73a8af0-1d978b97cabmr3185775637.36.1729698248008;
        Wed, 23 Oct 2024 08:44:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eb0c8sm6493605b3a.182.2024.10.23.08.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:07 -0700 (PDT)
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
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v5 04/12] selftests: ncdevmem: Make client_ip optional
Date: Wed, 23 Oct 2024 08:43:54 -0700
Message-ID: <20241023154402.441510-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023154402.441510-1-sdf@fomichev.me>
References: <20241023154402.441510-1-sdf@fomichev.me>
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
index 07222bfcdb07..051dd8bb0d3c 100644
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


