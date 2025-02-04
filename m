Return-Path: <linux-kselftest+bounces-25646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EE9A26D9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 09:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F283A1F6B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C2207641;
	Tue,  4 Feb 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIPdLAAp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D9206F31;
	Tue,  4 Feb 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658965; cv=none; b=uga3+0CdlgwIHMrjaLu6WWn86EcQeWFQlj57ltnmiyJE/ziE3+WBuudsCfqCDJsKcjr6N+UO/sodCRr4597Vn4nJCCi31IGkMCSYdfU8VipD0ErTVSsLht83j/IDfVDIIVyWBIIaiueQhKvjoQJtyXPrpP+SJUQleYy1EJQmRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658965; c=relaxed/simple;
	bh=6qPxxQkPJXpa+GHucQD5T+scc7Nur0OfNC/iEYnLwaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VL2fg6x/Zq9h86riFyxEMyMqIaSZh9zAGudeoqi2c2raC6RSSqdi5flGxKyKihpT+4RV360gA6UT8KPq3ypA6UxIMCnpftW9BxyzRwh8hHK0WEjjqvDruNMAr1qDA0eCspkiCZwf1sq4Bnn8TfF7lbswGTSSSRmQKKoTwYNl9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIPdLAAp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-438a39e659cso36251445e9.2;
        Tue, 04 Feb 2025 00:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738658961; x=1739263761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKqxMgS7cOJmvu8n7ruvjfJ25x9XTw1HrpboWdsZH4c=;
        b=iIPdLAApgHdH9F4Ys4Go58PDI0fa0KDVi4m2VLs2frLoAg5gi1JnIvmpKJ8+7zzAQK
         P03WahQTLn4vieAcvCPZQjCKbKB8i03YJlsfD/L5vYcCawFFsleKs+JN25Bx3kP/wlYn
         XH3I/fqyIVqHwHFRS3tuTRjYgbbZULihDKtXZoIHBphyc3uwMYkUIqxC+bc7gMcU2t4U
         +drwACCv5CIJf+QVrnNlp2VeC6cpswpQPF3ze7eF1TbOh54qR3Q/sDDCOa8WTeVgTjDN
         6CJPlZ7OL8CQfBa/6KogVKHDBjgOTb1aQyYOPcDgfLehy2qMIjN1dSaqmf051+oDpN0R
         g6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738658961; x=1739263761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKqxMgS7cOJmvu8n7ruvjfJ25x9XTw1HrpboWdsZH4c=;
        b=rTraHLSGp2+Oa8SrnMZoblpWmH5O6G/XCe1VEBnXhejSUQ5ImYphKzlCDW+lK0ge/Z
         dJei81r1V94grVYqzbqwLnH250zWTNm7fz7GkHUrnNcX95YoDsIVYdZ3TF2qRdwjoeqF
         M6CVDbNgTEg9MVs1w9MWKByrD5vKhp4j7EuvdaO1KmDSDEJg+T03y7q8rV8kPL5CdqM0
         FBu5AVNQk3lCUCgpyXzUBQLCyGEM+Ys7EA9+kFl6AfJNM2VtVoWeVNA1QPZybrh4lU1l
         xtfCNO1QGz6KaLEKZw7QNo+wDfLQKjEzVJlOrhAvuv7SQWVCZqw+Boy835uaMSyqUIQE
         bpJw==
X-Forwarded-Encrypted: i=1; AJvYcCVPNDKcECdGgsJ/F0p07YxdJOMCzCnMveEm7sbIkVqBd6mmv6cK+PfEOiV7LFrzMoege0g=@vger.kernel.org, AJvYcCW/qE61gFpmYAtGIsE2CbA/Nz1CZwjUMh8fc7B9X6TBhMVWCHfc1YleGaJqEqeUjloZ4g9FXeVBeUFUd1EPZr71@vger.kernel.org, AJvYcCWO6UYQP8ujvl5VMvcufl1O+9nvcIdilWn+AIj1AUVHYCxPwX8b8lm8lh2HsP9VflSUxTLezIGKqXKcynxR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6wRaSWY/ed7kCPqldf6gsVnUD2YfW/M51F7aLqVhwhbJAIkE
	ANVwjpv14ZGzHAaoGycN/4uqm6Lha3CECq4Yz1+mfJJEXfvAsi5y
X-Gm-Gg: ASbGnculYVSP7gynQi607TmpuvIqfhiWiuoYrELZwWzlkS0w5Xs7fdynbQPwGZd1Ule
	jwhWaEXnL5n0xVu3wLudLM3gjumRWzCCZy82URtd79Smy821Gn1ZVfpjOawKoyjY6usD+L1Q/F6
	TyPKWAiatOP83AT8EkKZLuuPbDYh3FH0AeD4DtIR/9LCiMDAd6fZ0URdL+lrlDm9Sv0jsymJZAX
	KA+Qx+COj0Dz/GOuHUMoI5vOA093/vsk1qWJrw83F0JUy3RR3D1D43iDsTi/dkBW9Qy/wqLqjHd
	aO9ICaeLx/9UqSNs
X-Google-Smtp-Source: AGHT+IE9fXgtGIX8eqCCVnPxl2DOsl3U6eIpAZWwtfegPMHLFSk58xoi288rwAFhcfV7tliJlLvqTw==
X-Received: by 2002:a05:600c:474f:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-438dc3c346fmr192963645e9.9.1738658961261;
        Tue, 04 Feb 2025 00:49:21 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-438e23de016sm185830355e9.9.2025.02.04.00.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 00:49:20 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: selftests: Fix spelling mistake "initally" -> "initially"
Date: Tue,  4 Feb 2025 08:48:55 +0000
Message-ID: <20250204084855.289493-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/s390/cmma_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
index e32dd59703a0..7fbbe8b912b6 100644
--- a/tools/testing/selftests/kvm/s390/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390/cmma_test.c
@@ -651,7 +651,7 @@ struct testdef {
 } testlist[] = {
 	{ "migration mode and dirty tracking", test_migration_mode },
 	{ "GET_CMMA_BITS: basic calls", test_get_cmma_basic },
-	{ "GET_CMMA_BITS: all pages are dirty initally", test_get_inital_dirty },
+	{ "GET_CMMA_BITS: all pages are dirty initially", test_get_inital_dirty },
 	{ "GET_CMMA_BITS: holes are skipped", test_get_skip_holes },
 };
 
-- 
2.47.2


