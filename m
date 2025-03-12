Return-Path: <linux-kselftest+bounces-28792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB6A5D525
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 05:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E0E189B8DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 04:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A1A1DDC3B;
	Wed, 12 Mar 2025 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G43A6D3Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D551ADC6C
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 04:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741754827; cv=none; b=Tzz6LxI5UgzGwUOU8DNEFouml1zLtjRo6K+Wjv8ghZCUeFGvqBVADYIBD/OG4Vrn+E0pScTU5VwSH7TtPOsRocCbc6Iyc8W+Pb/gcqxka7YAmF0+5h3RIJq/PElDZvRX8jhdafviss4wT0jFfuYKwfqe38+tZc8paWSw2XfXBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741754827; c=relaxed/simple;
	bh=P5+1ZmkAJH40Ohd12iorBbKIVuHQUB06k/hR10m8oos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fh6WON1drcTVLjE909E0lMdtm95JIL2+UvyKAXMsV1vAX//MyROsPhnbyvwen2IRxB3qYPVxwZ62byzRzFjEu6aYALNfA0VN0ooaA6RI3J9mP55tyukR2ZTtWavgzhExWP7ZgMX8dGpswv0lBO6UPpTefvZYpy8kH4MYk48DHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=G43A6D3Y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22349bb8605so117333705ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 21:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741754824; x=1742359624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwa33pPskkPQ/NBZ1X9elFhYdOgnrg8vQ/GWrL0WjB8=;
        b=G43A6D3YCshWzpMXk337aACPj0Cbqip+j/OW+3HeF3RO3p6/ofHMSmoV7Ssjx26wvu
         lw1E9TLksEhKdMOivWSurT4kKqapkkahM7D1WbMtZ1TP3CUYkte9QHlchHWL7XEM9bDZ
         Dlt5m2Ls66sfa+Ntu5GOhKicXd34gWxN4F/Sb64UgtPFfw0h3mlhiRhiZ5jIAOkzYm6W
         v/8+3PnPtaqYmXyJAkq96aBbFrv5Yr5PqzvGeviV1jlN87qA/8PwYZkD07cqAYpDzXSS
         DM0lfXCm2fV0isSXhEuiRBrgoFg58EEQHzcidzMo40yNabgptdtlIHnCT1TaG8ymRraz
         /ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741754824; x=1742359624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwa33pPskkPQ/NBZ1X9elFhYdOgnrg8vQ/GWrL0WjB8=;
        b=gq7t5Jfwdd/hj4bLqTTQeqlrR0b9dPt5TYRNYj9wmkK45ezHHv8CtsLBPHfOVx1qE7
         MyAHy5naGVtwX09FzKIWErgrgfldBWsFVY6sGNQhRZNKtl7ZXFiQ4rPEQIOHpBnGz60u
         LMeMf2+3uL4HwsOYjqW683wURAIuL3QfwujYMZcH1tlyrplVJQb2IQlzRt+njngWIH4l
         cdDDZrjSrtGaBs5x2r7ONcEL9lUQpayJQVVDurQjHnkJY6H0/c14ga+uolWnS4wujrKt
         w87lUoOBySorreIB0/T61MU+SD3SYfmAHFyyd5Hy+cVDzHZWVIfPh9NBrRD3s7a378uh
         jCug==
X-Forwarded-Encrypted: i=1; AJvYcCV551A+GnhnofpfIHT9MBVFIX9mA6tYF9axk5Fy7hFTGCkPgYEvrZ2elMm7MkqGJBUsPlzHHMHg+QV/g0FQOw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0QoKpvAPIaIUqjBvEel+M14eltibUnQ5p04T/C5LgmUS+HT6
	qnDnmhfOzNgfh+nYvY9+LAhqoWg/d5zr7UKEWUueAuPdw7o+GworcVcrlq88KTgyRG0uzJpzkN3
	U2Uk=
X-Gm-Gg: ASbGncvZPIzjDolCOMTV5n92jcfom0HOa4o3mrTmOkGHYVIbJSeaGGOCP6IUM7p8tys
	CKoNzKSgNBsbe4YZ1hdKUsljCIqK9DzFV/M5O0TQ9u22Kibr7a3p6EmftdwOHf8RU3W4wEwNEOA
	N6KQbPTC7s9x9ynuk2zilcC61i1OgptTfGCSm+6jFHVaE7OBFXjYAzeyQHAGwGjNJWGtH+/WucG
	Chi6D588VBIUSJi3zLNZfX97u3kT+E2cxffIBWXkEGhFOmomR622Qb9dD2fRse/PxBHfE4Q0Thg
	wb5SluCof1miSfByqiNnLLt1jAnS9S8S+nWkyHrVLdCeqt1OzyVA11V3kamG83R5Iqh8WXRBWFw
	mLYpp
X-Google-Smtp-Source: AGHT+IF3ZBeGX2GfMM873P0fcWHOC3RzkGYeWIUjoqHWJC+KJVsYNJNwu8mnTlo5rpp3HjcIEAPL+w==
X-Received: by 2002:a17:903:40cb:b0:224:584:6eef with SMTP id d9443c01a7336-22428c057a6mr340406095ad.41.1741754824241;
        Tue, 11 Mar 2025 21:47:04 -0700 (PDT)
Received: from cyan-mbp.internal.sifive.com ([136.226.240.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f7d6sm106476065ad.107.2025.03.11.21.47.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Mar 2025 21:47:03 -0700 (PDT)
From: Cyan Yang <cyan.yang@sifive.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cyan Yang <cyan.yang@sifive.com>
Subject: [PATCH v2] selftests/mm/cow: Fix the incorrect error handling
Date: Wed, 12 Mar 2025 12:38:40 +0800
Message-Id: <20250312043840.71799-1-cyan.yang@sifive.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an error handling did not check the correct return value.
This patch will fix it.

Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
---
 tools/testing/selftests/mm/cow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 9446673645eb..f0cb14ea8608 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -876,7 +876,7 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		mremap_size = thpsize / 2;
 		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
 				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-		if (mem == MAP_FAILED) {
+		if (mremap_mem == MAP_FAILED) {
 			ksft_test_result_fail("mmap() failed\n");
 			goto munmap;
 		}
-- 
2.39.5 (Apple Git-154)


