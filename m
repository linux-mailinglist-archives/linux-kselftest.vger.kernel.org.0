Return-Path: <linux-kselftest+bounces-28689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA65A5B6D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 03:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9907A8798
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 02:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D201E7C2F;
	Tue, 11 Mar 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JMhGny2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060561E5219
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660673; cv=none; b=rAIoPAPlBAPJHfHbrfc6g7dcSv2f0C9W+qnViYSdI6IKLnchAXWfjO32qAj7jxnFOlcVwEzh71JwgyVfjDuMWrmv23aBV4IO1VyrkbuU6fxuzzzuxNH+dc+Ta84N9wK9GatCzXAww0AbS4zTxsDhZyWhS69RIX9d0MFwrSq4Jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660673; c=relaxed/simple;
	bh=hh7QDsywcXB+6disdfK5pr9T8ubWm1fW4QiNis++4VA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ok+wffP9t7yt5yvvM/2EPtKHje+UodUOMBwaHxz5asXyAz1j4DqmGA42OVMTvijxXY6R3vyLtNMsJ+ojoySPKloZSnEilDfBUz6/4WPEdvc35tDml2xnMu20hEmPGE6nE2n+5A40YQUF7V+lvmTElqaInWDuygzujORBJmxUf4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JMhGny2o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234e4b079cso88530875ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741660670; x=1742265470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EJIiSH26iW36iQ0AY70VtFe7J14wVFHIbN5UzXmWNM=;
        b=JMhGny2ohaL4dT2gQ+rZcQbfAnckNl3h8rXMQpctLvpJmwhA2GT/aWwrfFAh2BUvf5
         7qyUkrPEiin91wP/MrOrL78HqgGvfPH3PMcdE+ynYSc5XXBmi0K8FTGZ7S6rL0m9oV5/
         4F9IARyhLjC6KzQguBRKZ0tSSc7nNff0oX/X3faMMwtan0p+g53A10olLu8tEcOoRasr
         I46J5Y4A/1TR1irDJsmhXws7KZVvhxL9Scf1eY2CQ82N45KJeiul2Fqw4dfV1ujkZpwy
         RNlhZoCZvuGZ17sLdFve3qT07JfAxerTvTjDFuvi2nj7JdiqzJIL/DWqjCwSh7RHZyRq
         khjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741660670; x=1742265470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EJIiSH26iW36iQ0AY70VtFe7J14wVFHIbN5UzXmWNM=;
        b=tuFZciGMtvaS+6WY2a0b6vXnCLT23H+GmI/SpkvnFeyZuVbP2dJkRMCfaso4/7zaWH
         GGgdJWhe0PRUjsEPqEea1jpQD3V0uptnGstxHRycB2h6CplmNFN3Gck2ri58OvqTO/0g
         6fpm7mtA3PFCtOEMhgyXaZ55/s1zSkiF8seG+kSIIZ+PYXFk3z+3/cL4iC11Lu1wPHlC
         8Nmz9PHlrQxOn4bPqKiS6uwJZaALruqYO5ISmMEQ5Co0bOtEXoKp/QQuf0V5iqv9NQA9
         Y/LKUMKoNhD/rH0qiM01t2Jk7tBY98v8ZHpwPSDYizIEmM7i3iGIpxsogXsDpVPRN15n
         vFwA==
X-Forwarded-Encrypted: i=1; AJvYcCUqVwxdbXB9Tad9DvbT8Z4kbO+q/4ZpI3qosufLQfsHmaOs7XxpZF8TFsh7GFkUyjTuhuJ2gjUcVeB4Fjxi1yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDwllJto8g6V+ZqvH4GhEt3SSsGdmWQqDxPqtzXIdW2kBeCllP
	5sL8GR/1kRX7D1ewjmTEJxeot67ufCH9eA/+kMDYuz3Udik5YHgNHbX8rlUghko=
X-Gm-Gg: ASbGncuEpKqPv+jf2vorA0I5W7JdAN3Bl+r73gi9o8J7mJMp/50hwSaszMb8UQjstnd
	zQjKE0vVJ7hSWfnY8JjNWBI1c/Gc+NkfQTq9sLUoHsL0bs0Ki7QvAxMIu/aWBCF5E0L/ww+xuoQ
	Gju8xJPpmTn4USYHpAfPy2EVP9kyqQvpVXsxZeZB3yjPHGQ+jnf4q8cv85JDqRLoJyBF/gTWCcv
	s7PFn20/De0yetAVZaMd/uKAFNAlFRGZzM3jlgOwR5pYiynN6zkwe3s/n2hIBZzU18zGKQY2tMN
	PnQdhyd+iGPoOVjdc52IA5kRWSRFtce/Wy/y1JGpr44niRAb0CluREyTjH28rEFjwYkw9bJ7+Ng
	/cDC7
X-Google-Smtp-Source: AGHT+IGqOQCr1tOk5CkVd1S+i7SxypBwbxwvlNPK+GIp3D5+3dsq4NswgC6lEGNZin82dMDVWEMT1Q==
X-Received: by 2002:a17:902:e88d:b0:21f:768:cced with SMTP id d9443c01a7336-22428886828mr219614335ad.8.1741660670288;
        Mon, 10 Mar 2025 19:37:50 -0700 (PDT)
Received: from cyan-mbp.internal.sifive.com ([136.226.240.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa4a79sm85850615ad.214.2025.03.10.19.37.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Mar 2025 19:37:49 -0700 (PDT)
From: Cyan Yang <cyan.yang@sifive.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cyan Yang <cyan.yang@sifive.com>
Subject: [PATCH] selftests/mm/cow: Fix the incorrect error handling
Date: Tue, 11 Mar 2025 10:37:30 +0800
Message-Id: <20250311023730.56658-1-cyan.yang@sifive.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two error handlings did not check the correct return value.
This patch will fix them.

Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
---
 tools/testing/selftests/mm/cow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 9446673645eb..16fcadc090a4 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -876,13 +876,13 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 		mremap_size = thpsize / 2;
 		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
 				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-		if (mem == MAP_FAILED) {
+		if (mremap_mem == MAP_FAILED) {
 			ksft_test_result_fail("mmap() failed\n");
 			goto munmap;
 		}
 		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
 			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
-		if (tmp != mremap_mem) {
+		if (tmp == MAP_FAILED) {
 			ksft_test_result_fail("mremap() failed\n");
 			goto munmap;
 		}
-- 
2.39.5 (Apple Git-154)


