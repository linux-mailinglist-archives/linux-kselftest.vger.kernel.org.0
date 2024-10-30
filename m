Return-Path: <linux-kselftest+bounces-21113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8089B65CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06244B20DF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3111F80A0;
	Wed, 30 Oct 2024 14:27:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462F1F7064;
	Wed, 30 Oct 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298453; cv=none; b=EswdcP6ILHrnKizUEj3U710QFPhYi3HbUY3Q7bR8l61+nm56HLN473xFRCMSX0KYLN4d3YBj03apyOgWE6IRJ0ZszPbFRwvjNt8PkyTB1DhfFZ4P3eYraaLN/MCkyHm/nKIG0c6pfPbsx4PftCUs6wev9l13xKS1Y9+Pul/ZtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298453; c=relaxed/simple;
	bh=V/snhxZi+0I3HXsSt+QlACbncN3kHgsS3nE3sHv68wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4IYnCF9oCDN1XTBS/juS0NCwox/bP5Y+NMj7NjSLw9gFzv8WDFoVfS1+xMUUlCTEzLoxwiiEAD/PyoXAmUWdVHVirK+YO30z7dhMRLEOUa1db76CcGI2gXTyH7W5qrETFAxfUpuUT34jgAl7K8i7fAIkwyHKdzDW1gMwK9cH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-288b392b8daso2980989fac.2;
        Wed, 30 Oct 2024 07:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298450; x=1730903250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NajTBikUup8pa87QS9/1kmZjqVP13oIq9vk9Hq0DWdg=;
        b=at89AXpJs6c1n3gKuZND8X3bW7Hqj5FPl0QGCVZ76/i36xZa22KbLjKLM4OJQOf6QG
         BW0jwjM8GUGZ/6VQgLgZlD8mAyKzRr/gFpZuuEjGqCJmpM/z7M20S2Ultz2ADfdFWYhT
         kyCzaCaOZaZkrZImcPPU6KPK7NLJY3yQmtj7XafcRBwZ34Sj1/7BhKTCdy0VebiC94Xe
         nOLISuEdataUkA+ETeGDunAPZWg245HQIFTcxMEDHDAHt3dS2xhNh+XoHWInUBt3r9Tr
         2nuE7RDcq59nZPotTa2VR9axoxhmKEMnxXrGrTLxrVqM6db6BqcfAhRh0NgYJvYHZvHE
         aAFg==
X-Forwarded-Encrypted: i=1; AJvYcCUwsWkFyxjdwbZc8JADpF7Go3KavezKybOnrekA/Jkc/uOhUPo1mrFdm9K5E429xpuND9LV8A7Wi+IRBnEuJzZJ@vger.kernel.org, AJvYcCV8Ie2QxSzxKYFdHC7M03lVqIGoYY6SwiSfpErEeCI1ozstu7w5sUAfaTnryTLoy/G2OVh7bTzjoDKrgqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymdiDrDoqQ+eTFaJff+5Twuyc19+zPAU1cQ1wOonOJRcXljH5h
	srnoIz97NFxcA1f1NtfuoPzs6PgjMbyCIJXLYv95EWa9Xyh9vCBe/h0i+JI=
X-Google-Smtp-Source: AGHT+IEB54j61/HMXCP7CKcR0j3pOBfdeG2E0C8G9eLI3FTeK9A3M6cnzDY172xgmx/rFRC+AfNkgw==
X-Received: by 2002:a05:6870:a11b:b0:278:65c:3c14 with SMTP id 586e51a60fabf-29051ae9defmr14531581fac.5.1730298449031;
        Wed, 30 Oct 2024 07:27:29 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a3d1c6sm9382378a12.81.2024.10.30.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:28 -0700 (PDT)
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
Subject: [PATCH net-next v6 04/12] selftests: ncdevmem: Make client_ip optional
Date: Wed, 30 Oct 2024 07:27:14 -0700
Message-ID: <20241030142722.2901744-5-sdf@fomichev.me>
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

Support 3-tuple filtering by making client_ip optional. When -c is
not passed, don't specify src-ip/src-port in the filter.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index b89b62445158..b94f7c4a53ed 100644
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


