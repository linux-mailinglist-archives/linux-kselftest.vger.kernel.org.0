Return-Path: <linux-kselftest+bounces-47516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1023FCB96A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 18:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6BCF300CD62
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD32D948F;
	Fri, 12 Dec 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lz38eRs1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAF52D77F5
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559833; cv=none; b=Z22VOd53u8et8WCLsBRQaldsnd+mM6V+KLG8owkgrrasRxlqri8ckMrGgsQg05IRzpHK2ymY7kkQgmyNl8qkX9Wa6nwo9VS/bXRZHiTqNN2aHDxgHsY7bNShKJyLekBmNFeuZLl64oaiMYqppxh3zGbqTtuLknNX7RdEzJ4TLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559833; c=relaxed/simple;
	bh=hMDvcWZRxsHgEupNzfRaoWl4qKW471diyO0Q/xWeRr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpZ0dnjgORloIS6AmzaaxsIzEb5WuYowUDNVf7pLgtglxFRy0f6STI+6uJ1VHIcSG7ERRuFhJhIJpT1Pps3pDao2zXzTK9Goa5JyVT+CRm3HL4uEPI694EIvD7hlt4tPjulbeFT6QpGK2HlAkIBZr8AWEHOWCAJKJRwyEqZdyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lz38eRs1; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7ba92341f07so125400b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vaZfyTagTLiPkyNwQyOOZqa8fNIA0b68wD31umuEqc=;
        b=Lz38eRs1KR93kotP7e4HhjeUYRRUJMQ8C5T0VOG8Z8v2OUg3DYyUK/DOSNpXPsja+9
         Gp5AlKKxs0HKjK/9XiqaNLijDpVuqMvvnPfa1/6SmSwlPIJf0vyy7YeEcHZIZi5ApIVl
         CxcmK9JbOR0mzJ0yHgctBSGntLXUbWTSazjx00waQa3ZdBPQMUB9xhmKn3i+gwuUZ3vq
         eBOQaJOdELxID/0ShJZYoRg84TIIQSSBoy3DF3N9ox+RM9WMpVucBiN97YaRWac3sVC8
         8X0GBMAS9+N/hsts9t58GKWeIsVvasGRYzd7BAjMF73B1+mCMl8SRqMufpowzLY2cRsY
         UAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vaZfyTagTLiPkyNwQyOOZqa8fNIA0b68wD31umuEqc=;
        b=NrA1Gggb52yblj3lvLRpiWikfgnHyBvRzW3IiqRgi6LkjL5WLGgG+JqcCEFh0/4O6p
         fVyR4qmmfRRzrb24dYNM2eW7nhe6ZUBWp9TjYHwJHgOpTEVsUdOYCD/shwV8CA5bR88G
         92QwLVNSZDV4FmiLCElYe0Y2B7Ln+o8+XcQGk/9b+l3OpNhcvHfkAaS7+gMlHpxO2J9a
         lOqBsbKbzPRtBjIq+V5lWOeH69ecNDQusBbhysHFJCr5MGSUHwwEVmWX9L3J82HtlfDx
         QvvBIkUN/PzueKdgjpQwsUC9HOTY9+Ik7gWjuE4gW0kMxov5ubLUQd9f67+zSHuvlKjH
         UH6A==
X-Forwarded-Encrypted: i=1; AJvYcCWTG9sPFFT5j3QBpi6UB43pbN/4cX0kbhhVHehdi6oKCcUcnpqCHpu7cJyqQ/vhua9EqJDAaHBEndCxdyQN4wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nexg5Wrfg4EDBPSaeYNndihizSHWMhERISM2DPZY53uHBeJ6
	8Om0/TJ8oKX2t79ni4V4MnKZ3XGvToUZc7P1NVUv1fH/jZBwB57oLPcmNqWhfIpBoJ5ohoyR+3n
	fg01q14xnnT+4/reFxyXSV/SluvL1UgEFdfER
X-Gm-Gg: AY/fxX6wmUY5O0fWT37N/sF6iPBxtF2X21iUKHtTrUicWxd4QXz91kyvFxIQq4ztbmY
	kyFThFs/VY9qb7EIE1NLeRUoc0oAx5ZqtfFY5gB3DpkbpuVhDr7Cyy1bV9JGK1yObOwMbU+DIEz
	uNyyw+tcgqA+1w2Y3aFiFSH0V55t7sFyiLX1liHSWh/zKNjWYB/v7pTWu5LuIJdwFRDdxaOPtLv
	ohXFo7jl1QolGQ+nuUtoGsMQIgTegM2rVGi9X7adWaU0wbXkrsRiXN8s18pffAF4Wt3cqE5mOdd
	L99yJFIS5zycuJTdLXdQ67Ns4irPAWF9Gedeq1und7Cc49CblS5FAHRNfnlry7S5PgFIr+6pZbC
	KxiyA66HCAxuQJs+JGSHJu+yN9J1Gz0uPwt+Nlv1k6A==
X-Google-Smtp-Source: AGHT+IH96LAecJgAV0OtPDEdr6lLIdVq3cjMdIk0JNIP2zsFKZMrRSd2mV+qKmbyfAADOWtK6riDrjBkekWW
X-Received: by 2002:a05:6a20:72a8:b0:341:29af:3be7 with SMTP id adf61e73a8af0-369b05be897mr2150111637.7.1765559829956;
        Fri, 12 Dec 2025 09:17:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c0c29639704sm672529a12.9.2025.12.12.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6151434079F;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5F518E4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 3/9] selftests: ublk: remove unused ios map in seq_io.bt
Date: Fri, 12 Dec 2025 10:17:01 -0700
Message-ID: <20251212171707.1876250-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ios map populated by seq_io.bt is never read, so remove it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 507a3ca05abf..b2f60a92b118 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -15,11 +15,10 @@ tracepoint:block:block_rq_complete
 			printf("io_out_of_order: exp %llu actual %llu\n",
 				args.sector, $last);
 		}
 		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
 	}
-	@ios = count();
 }
 
 END {
 	clear(@last_rw);
 }
-- 
2.45.2


