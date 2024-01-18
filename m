Return-Path: <linux-kselftest+bounces-3183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E8831188
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 03:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CD1285871
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 02:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB353B5;
	Thu, 18 Jan 2024 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ib315mbV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638653BE
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546308; cv=none; b=RvslR42aOp9qDXVc6qWsI1V8THG1TjlB4oLXV1zfgoou3Gq0t6FudrWLiT6OIv4XIGJBJJ9CuvajQVKVjyTNkAW3CDzWrPt75jpy7idhEFH59Vgi+incogYapjtN1mAKAM/UmG6X5FQw/dr658Wj7hTQg8CWROnqZ9HNQrYiAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546308; c=relaxed/simple;
	bh=HHNvB7NqaX4iGz7NhjxGduwMzlm/JxAKon+6MvQQ7tQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding; b=p50LOYyH0+XDlOZVbwTiCFjCbakr8TC2p4oqrD0S2yZPlaAO7UfhYYfL7OEXVtw7GT6L43NyAFy6AdWn9ut4q/krMpu+nCpXbFNqD2XntIs6Pzg4vxLHadcjhi+3wGgKrVlrTenUZd9cwo9oOu6TefZSpHz8v/ZrKdJntVUNVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=ib315mbV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e80046246so1417875e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 18:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705546305; x=1706151105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhoYD3VTX6Mw3R+QWgSNnaN7EGj7heKEidij6gCGH3I=;
        b=ib315mbVRv3Bunh0vpyiLCp2/A25bKOgoyaSZhTqUF6S0i6rY8BPMGccT2/EhgBCjJ
         TGlTGea+4/1I4bJuQeq2+NR0F95swbCfDeW6EvAUvy7SRcPRlUd4mzxpNXN304ccjuHk
         umLKark19Czyyt4ctwq2Kt3I6R+Fe58t8RJIyZPRpTCow7PHzt+4g3NVkHKxcMFgPNId
         zBN4iXQqVTMZSruaQakT6P24zXxAqOlunna+yFtNf087gMSca7GDN9pw1glPy9KOOrWN
         wg39fnJzz3adMwncb0S1Mr7Q7b5xdIb/M9zcZLLciugWJJwfdsJ+GlaszVCu3qoLcrOv
         4BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705546305; x=1706151105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhoYD3VTX6Mw3R+QWgSNnaN7EGj7heKEidij6gCGH3I=;
        b=uwuBP0ZyuIMogZZFL4Um5zutUiu+wlXJJRugZYE1uE9LDaYy6sqs94m7pPO7GOHkg0
         n0ERuCMX3kzU4o6PR6hzkAmSX6s5Wc2P6+OIWYD3NohGotvNA99/RU1v62vICAafREnX
         4vTUUJ9sSHwhuyI7jmMqFD65ojUR48pIy4cdoiAH+khRAqiQNKUEvDJoLM9c2/832SPa
         pbaoxBAwxXFlHlzoHyaecGtm5F8sJZm4wUhKA4/HsvV6K1kyUNBsFtgVbIGWr96LpDFY
         7q+oon2PjjgkG0KQeZewnTlwAay2Kh/dvm0795Wt7hO7jJZpsMQjqiPCyVb9WtjlIRrn
         n26Q==
X-Gm-Message-State: AOJu0YzhHR8p4clv2KU+NmHoysSuf2S1hB2luXM0chB1VqFgV9pi8aaa
	5s/4m7FF/3hntV7WMtSVzgDX33iEQUfzcAwmQow1x/X4c85PqNfwdhwnykx3lw==
X-Google-Smtp-Source: AGHT+IEarBwiy9S11+P1dfRevomL/EXd2tiBkN8AThfBc9EBa9ZMEtemzQOwx5lFVlSszCObFRDvsQ==
X-Received: by 2002:a05:600c:1c98:b0:40e:47d7:45fe with SMTP id k24-20020a05600c1c9800b0040e47d745femr1066290wms.12.1705546305046;
        Wed, 17 Jan 2024 18:51:45 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d440f000000b0033664ffaf5dsm2868219wrq.37.2024.01.17.18.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 18:51:44 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] selftests/net: Argument value mismatch when calling verify_counters()
Date: Thu, 18 Jan 2024 02:51:34 +0000
Message-ID: <20240118-tcp-ao-test-key-mgmt-v1-1-3583ca147113@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705546294; l=1291; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=kVnh27dlnNFLZT4j7XCBS7k2UYRkwKA/47jZVeTJqxM=; b=DvIQceG0/yFC+BI053HeWIerRGCMYN+ne8Heal2yoDlufaZ4By8K3WCQrn12pdLnYBQWgmadn ktHF1H3C665BcIpL2kiiQ7Nf1k53nYH27ZIaIz1rxnkRePR3/c12/TT
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

From: Mohammad Nassiri <mnassiri@ciena.com>

The end_server() function only operates in the server thread
and always takes an accept socket instead of a listen socket as
its input argument. To align with this, invert the boolean values
used when calling verify_counters() within the end_server() function.

Fixes: 3c3ead555648 ("selftests/net: Add TCP-AO key-management test")
Signed-off-by: Mohammad Nassiri <mnassiri@ciena.com>
Link: https://lore.kernel.org/all/934627c5-eebb-4626-be23-cfb134c01d1a@arista.com/
[amended 'Fixes' tag and carried-over to lkml]
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/key-management.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
index c48b4970ca17..f6a9395e3cd7 100644
--- a/tools/testing/selftests/net/tcp_ao/key-management.c
+++ b/tools/testing/selftests/net/tcp_ao/key-management.c
@@ -843,7 +843,7 @@ static void end_server(const char *tst_name, int sk,
 	synchronize_threads(); /* 4: verified => closed */
 	close(sk);
 
-	verify_counters(tst_name, true, false, begin, &end);
+	verify_counters(tst_name, false, true, begin, &end);
 	synchronize_threads(); /* 5: counters */
 }
 

-- 
2.43.0


