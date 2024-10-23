Return-Path: <linux-kselftest+bounces-20479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7F9ACF54
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01321B291EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F51D07B8;
	Wed, 23 Oct 2024 15:44:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD41D0402;
	Wed, 23 Oct 2024 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698257; cv=none; b=n3VxMA8LiOSZQllOEqLANWEMuck/rVo0bCxyJ0az6AS1qQ02V03v/vqhU2fGNXJzvqF1yN6KQvZ7nFRP5+K3y9Ncqmsu2Dh68/RgtJCxBCxOGFTfb6aQcRPmibB6QJfeGgYeu1uSc+9c7McmzQWwUJCQdTFZLO7BWqM8LHgEQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698257; c=relaxed/simple;
	bh=oFNEdZLPtcjUpbqtcRQsl/ELJcA51ONRPBDy5kQu3qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxn7BKgiHF4MwVfd+iepyz6R7s0omCn9Mfjh7iUR1GBZmpZwW7tILl3q/M5BJwaZQduwmqU0ulJG6HbcQWtuhJntHL3QIt8mSP1zhQsJjiJ1TRbH6IrczGAb7aGuquQ5CWpg41hPDs6Z0BcneDIz4mpdaxyDvgp0w9fqVgy9KEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ca1b6a80aso67933725ad.2;
        Wed, 23 Oct 2024 08:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698255; x=1730303055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MebxHJqXK6owyg4bREmStt7nVbsj68A52KHrJWNeIO4=;
        b=JyCzG2JVAIquTora9Oyg26q3YphwXlUCP2LzvpMiWAxRV4HzC4Fgs/bQCaPnwFn6F7
         OXsRmD4rPgSMbRvpfeLDTqrklmox6kG/SFckzCROTnZNcrwkxFNHsLP3MLHZWL5kowJw
         0yh0L/UxwCGyJ7GSXKSiTFoxM3DD2BFXfX9AI1mMFjzruOYYoMgpcsiwuGYUM9IX1bsq
         bNAKew/3oxaAWcWADlrid3in+704GaPf2QChOLjZDdwOyPcPJBG7po1EOvfYqIkBfyKa
         fp8+DOX4T3gguVK4wRTE7D+z8galjSCskxd06M5cTdkduXlgVAO7Zc4v3eoA0Zq3GY9Z
         jjMw==
X-Forwarded-Encrypted: i=1; AJvYcCUs7sfP+CwDOCNl1udQ5ESCvwF8NgFFtE+uJapEiZkVgWbAS07tnUf4V61NVT6yLewMF0enCtoG5cd7HIU=@vger.kernel.org, AJvYcCVdYkAVSrruSRB8r/fRB78SA6pg8Fco0C5gjQla6m22k5kOtdURogUE4onCo1129Q8J/I9HbZqz55oFSMdLfqyB@vger.kernel.org
X-Gm-Message-State: AOJu0YxdBIxsPmmhrcuE5+ohFoBjVs3icOY6qufgUfcLiUSEJLOn4UfE
	Tj1qIrCk9cX1tSQwpKEAbJx4/xuwvZmErPhr3XWJDE1RvyabzRFX+zHB2B4=
X-Google-Smtp-Source: AGHT+IHCJjMRK8HlnNgTrAY8AO6pvtBwrS1bB+mfsFkekaUHQGKiPoBbTlLHknehrC536pJQ7kh26A==
X-Received: by 2002:a17:902:d2cf:b0:20b:61ec:7d3c with SMTP id d9443c01a7336-20fab303739mr33614225ad.49.1729698254814;
        Wed, 23 Oct 2024 08:44:14 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db968sm58648025ad.200.2024.10.23.08.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:14 -0700 (PDT)
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
Subject: [PATCH net-next v5 10/12] selftests: ncdevmem: Run selftest when none of the -s or -c has been provided
Date: Wed, 23 Oct 2024 08:44:00 -0700
Message-ID: <20241023154402.441510-11-sdf@fomichev.me>
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

This will be used as a 'probe' mode in the selftest to check whether
the device supports the devmem or not. Use hard-coded queue layout
(two last queues) and prevent user from passing custom -q and/or -t.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index fe4d81ef1ca5..07a91516103a 100644
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
@@ -718,19 +718,31 @@ int main(int argc, char *argv[])
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
@@ -741,7 +753,17 @@ int main(int argc, char *argv[])
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


