Return-Path: <linux-kselftest+bounces-592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B97F7A2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 18:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8966281AF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F2381C2;
	Fri, 24 Nov 2023 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Av2luZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439481701;
	Fri, 24 Nov 2023 09:16:51 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67a18ee7d3bso4219786d6.2;
        Fri, 24 Nov 2023 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700846210; x=1701451010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUWoPAOl1iJX4r4aM7k3dDQXfTGNs77R3n9G2uEeCSg=;
        b=X9Av2luZrM4Z7rlJTElxVMSfCKEnpEl5uuQMfWILYdWS65pSWE2tt+E2QPMXUt11fj
         N8KQb0IEXB7S4oKNgd2CQUNeBvyxWR1QQZ8jodmgb7okxBUzssxwBo+dzYhLgCvQ495p
         yN2sK43H/BAM40ogt35I7+2+LhoazP41YkVKKp9YskB0dmFY4Ovr6l5rT7AX5CFsQtce
         +BgXhjC9wsH9LTWwWp53Ra5753jm/7uXUROOjUKtR3Qc9IS7B5XDVRQ/HX7Xjsz0kX/O
         4UX09NLsstIO6eeCJ9PtmXDcybKsczlw98EcfGwOi9sfeFowld0qKr4GNzvVMNsT/Mf2
         eelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846210; x=1701451010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUWoPAOl1iJX4r4aM7k3dDQXfTGNs77R3n9G2uEeCSg=;
        b=h+oJDSdzDdX679BBa/PgfowFedUWKA4DPH8OYY1WFf0gf3IfckONpcaSTYdYE8tt91
         QDPgp1cuSXvASQFzfdf0xeouWxGNmso6SC8K1FyYmyzB7QiZlEKMgBjsEgWSmzuB/+GE
         4Bfly5fOdJ+5BW/TiawXjqn5dfUH3tovRJW2mMXiKt494BIaKGaFO1B8Jpcxle/5BOcc
         jQRb9Lv60xcogBac8BnzGTaYzTCTEiugxj6+R/M7FKu/s+d9yFfYAeNt6GqhJFa7YZOL
         A0kA6WqwxBz7rGOdM5ts5rWQeJb0GENa7v0OQfcVZ17LR7HP3ljMcrcowMQjQUc7N47U
         OeMA==
X-Gm-Message-State: AOJu0YxIjtoKwfJQl5me+Rk8R5PvIBjiQAWMVTupxQCKcryuh9hArHGN
	th6xcr51FiRSdM4U+BRD8j3BL6tFoso=
X-Google-Smtp-Source: AGHT+IEv5AJRDQ656srmGqdHzN2UVuwAvbeUiL51GPC3+xU/kpFQQzUrQST9y1V7rSWB7ap05L11cQ==
X-Received: by 2002:a05:6214:5c9:b0:67a:1806:5c81 with SMTP id t9-20020a05621405c900b0067a18065c81mr3181506qvz.6.1700846210313;
        Fri, 24 Nov 2023 09:16:50 -0800 (PST)
Received: from willemb.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id mn23-20020a0562145ed700b0067a0a00b24csm1389278qvb.73.2023.11.24.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 09:16:50 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net 1/4] selftests/net: ipsec: fix constant out of range
Date: Fri, 24 Nov 2023 12:15:19 -0500
Message-ID: <20231124171645.1011043-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
References: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Fix a small compiler warning.

nr_process must be a signed long: it is assigned a signed long by
strtol() and is compared against LONG_MIN and LONG_MAX.

ipsec.c:2280:65:
    error: result of comparison of constant -9223372036854775808
    with expression of type 'unsigned int' is always false
    [-Werror,-Wtautological-constant-out-of-range-compare]

  if ((errno == ERANGE && (nr_process == LONG_MAX || nr_process == LONG_MIN))

Fixes: bc2652b7ae1e ("selftest/net/xfrm: Add test for ipsec tunnel")
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/ipsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 9a8229abfa026..be4a30a0d02ae 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -2263,7 +2263,7 @@ static int check_results(void)
 
 int main(int argc, char **argv)
 {
-	unsigned int nr_process = 1;
+	long nr_process = 1;
 	int route_sock = -1, ret = KSFT_SKIP;
 	int test_desc_fd[2];
 	uint32_t route_seq;
@@ -2284,7 +2284,7 @@ int main(int argc, char **argv)
 			exit_usage(argv);
 		}
 
-		if (nr_process > MAX_PROCESSES || !nr_process) {
+		if (nr_process > MAX_PROCESSES || nr_process < 1) {
 			printk("nr_process should be between [1; %u]",
 					MAX_PROCESSES);
 			exit_usage(argv);
-- 
2.43.0.rc1.413.gea7ed67945-goog


