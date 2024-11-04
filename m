Return-Path: <linux-kselftest+bounces-21403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8469BBD22
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561021F23D1F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461C31D2F4E;
	Mon,  4 Nov 2024 18:14:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76BF1D2794;
	Mon,  4 Nov 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744087; cv=none; b=s9y+3HCFCGGIj3DzzJXnCeffGSS1RAnct8j9ig9iUE1X+w4NIVls09kN9VmBqNO90T+0Y5tDrQ+wunNwvTx/x9eEfStgotIHlHKcuMs0QQGS5b22csb5+fb4NBLrl/rZKMyVUB562IeOdcZfca92JISb5ZUcSvB2UuaUAFuReHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744087; c=relaxed/simple;
	bh=72/R5PRQI9Otl/290uawNtrS6k8D/kufkgNBz6vJx4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFDNBu16wD9E1tB4yOSyOXmYmKxQS4xA7ANjRO8zK6cixmmpbzoFTIucpHG84bWA89tNFzJrvRfNJrTEUaFn3Kt4ztEyVfkHJqajU0vA3Cp13Nh/b71UOsUm0SwSIaTk46/Xn7h798nQYMTclmGIEfuF+11+3ybuJr5ojdeF4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso3474127a91.2;
        Mon, 04 Nov 2024 10:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744085; x=1731348885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIs8ZvYHkw439c9Xv7PNSglUccQFPekABSAEtzHkHdY=;
        b=FABmU0sVVgTuNKj93LYQg5IrJgJPxpOorc+iUy2a5Q5f5To54/dTC/nvmmi7iDEJVF
         TKbzUYE/HgHC455LvNeuVZRCrVpxVX3aox6ocCZ3CN/e4LDWy/JfozVQ58Zx5vdEBR4c
         UMrW/CN1O5LmLiKr4EBaOwrS1vJAqueQfgfmuKaFYfIT1vknu0I0or2anX3WybSJB9+h
         H1sdI64ZETQPgJPb3I+dgk14ZEq6soT3C2TEQN/9zeqakR/KqurbYkeLsr+t1Yqjdmyl
         zhPpLkHavay3MkNhk3BmVMC1D7HSxccHEPOsr9irD85lWPNiH60B6pHKoOhY3aeyhQSQ
         jZDw==
X-Forwarded-Encrypted: i=1; AJvYcCWurQQZ+6t5pU42EHlITfFtj/dQI12gXGa0KXRYOESm3QHdTCKAujhdjYM2N6jYavt3f9qLVVCoNJIFrZc=@vger.kernel.org, AJvYcCXBDcZjRostvy/3cL8VjKrOMExXDfjsHchVrGuc3nNm/a+LVxvyxvuf9b+r0dBLYWI0+zcxlaBQ7hYnZAN7H2Zp@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0IIqlhxM9LSZqe+j7vH7to1tNmkilvvtblj/llSaqttQh1Ft
	lztpUt6zKRXDukgMwSmUMSzwPDvKOmQIUaTIKy8atTv2qOpIJsQGZlRE
X-Google-Smtp-Source: AGHT+IEkWoxmsVyVZ/bNCB9eIkdQQXPdol0Opi11VQOloRfjI7YmM5QjNMwMRiIYHYNGKRP2Q1KSgQ==
X-Received: by 2002:a17:90b:2e4d:b0:2e5:e269:1b5a with SMTP id 98e67ed59e1d1-2e94c54a67emr16333096a91.41.1730744084894;
        Mon, 04 Nov 2024 10:14:44 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbdfaeasm10107273a91.38.2024.11.04.10.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:44 -0800 (PST)
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
Subject: [PATCH net-next v7 10/12] selftests: ncdevmem: Run selftest when none of the -s or -c has been provided
Date: Mon,  4 Nov 2024 10:14:28 -0800
Message-ID: <20241104181430.228682-11-sdf@fomichev.me>
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

This will be used as a 'probe' mode in the selftest to check whether
the device supports the devmem or not. Use hard-coded queue layout
(two last queues) and prevent user from passing custom -q and/or -t.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 044198ce02a7..270a77206f65 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -76,7 +76,7 @@ static char *client_ip;
 static char *port;
 static size_t do_validation;
 static int start_queue = -1;
-static int num_queues = 1;
+static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -731,19 +731,31 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!server_ip)
-		error(1, 0, "Missing -s argument\n");
-
-	if (!port)
-		error(1, 0, "Missing -p argument\n");
-
 	if (!ifname)
 		error(1, 0, "Missing -f argument\n");
 
 	ifindex = if_nametoindex(ifname);
 
-	if (start_queue < 0) {
-		start_queue = rxq_num(ifindex) - 1;
+	if (!server_ip && !client_ip) {
+		if (start_queue < 0 && num_queues < 0) {
+			num_queues = rxq_num(ifindex);
+			if (num_queues < 0)
+				error(1, 0, "couldn't detect number of queues\n");
+			/* make sure can bind to multiple queues */
+			start_queue = num_queues / 2;
+			num_queues /= 2;
+		}
+
+		if (start_queue < 0 || num_queues < 0)
+			error(1, 0, "Both -t and -q are required\n");
+
+		run_devmem_tests();
+		return 0;
+	}
+
+	if (start_queue < 0 && num_queues < 0) {
+		num_queues = 1;
+		start_queue = rxq_num(ifindex) - num_queues;
 
 		if (start_queue < 0)
 			error(1, 0, "couldn't detect number of queues\n");
@@ -754,7 +766,17 @@ int main(int argc, char *argv[])
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-	run_devmem_tests();
+	if (start_queue < 0)
+		error(1, 0, "Missing -t argument\n");
+
+	if (num_queues < 0)
+		error(1, 0, "Missing -q argument\n");
+
+	if (!server_ip)
+		error(1, 0, "Missing -s argument\n");
+
+	if (!port)
+		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
 	ret = is_server ? do_server(mem) : 1;
-- 
2.47.0


