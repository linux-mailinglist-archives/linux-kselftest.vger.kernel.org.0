Return-Path: <linux-kselftest+bounces-23519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4CB9F6BD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7674816D1DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49E1F869D;
	Wed, 18 Dec 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FuCKBR/o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568D1E9B33
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541423; cv=none; b=CJPr8Yiiygy9d6f42efRWsRLS+AXQdzAFMHPtTIPTJ/3gPQuQ0Kck/KGVFAX5frfrwSu8pGjp5pHdTMvFs+sgqZ3JREp6uPk3qOZeyrItvxHrBUy7ZkW17kC0dOba6Igxuv48LRLX9YBE6W59GUUQMofoqQ7n0IxrQrQw0+UReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541423; c=relaxed/simple;
	bh=iO9isvWf752YGak7VS4cPUz+0yRT5dyL5xaBhozN1yQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KRknZlZ2StxMUT0TDWkbqap2lO5g73qRkjv58gRowU9rBepcH1PE4w5VyW5NAq6uWfu6S2oFPKdX3HPPpcpxKSkvnYkEFgazD+rJiNbO2j16TFfsT6s18ttHJ0gcH9c8NIbvIXme9N6EgYkhht5eaNXOqDhOgZpPs5DVRa60Yr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FuCKBR/o; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-436248d1240so37000355e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 09:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734541420; x=1735146220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VfjgK2SOmknIlUUHDKQAA0R+8BaX7+ocU830dMMDKHw=;
        b=FuCKBR/oHhyYJAj5ovZdtiu7G+6Oz2i0J7T6dPawgJsj1V3OB6OYBvXSK3Z2SaV/MD
         3ZZKWcZkf+tAvMW7IuLwQxZUYqL05ipxvP90o8RVdFIi+0w4yu2wi5CFCN13S3Ik2yIK
         WkPIDRwLmRY0UuZHoivghcWEEZPiv5DjRRB1eUAcG3rA5b0/25he5WKSjiRrpwGtnW30
         l58yUO7neGxy9nLR1t+YWj9DwViVufdnaC1O/ErxaQkDYv8PtSNJf9LJbeIuNlcw8Qfm
         Os73a5Y+3dYpKMFnx760JcYYEQUNvd3UIUf8lYwYHArNthf00naMHZRAeEHCIK/lsBH+
         +6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734541420; x=1735146220;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfjgK2SOmknIlUUHDKQAA0R+8BaX7+ocU830dMMDKHw=;
        b=scGVLjcNUqevrNEEPTgCG3rwUxxInpBALihmGuWqG7eYas3G8cI/7Q7R407Tghogwq
         wR8OjEQdaDz9OR37TJr8kbapIb7YGRZCuDnyFncIayySeQunz84PsYnuKtjPUplol565
         8AGvXpzHEBdphZZr3ZoCPHYkai1ShM1A3yWV10gZGF/s9mDFR1+cem9APy2bFkGJ3eEK
         0KoXKwa7HGKkEe4JHw9hy4pPnZZf4VJrHya4U15F6pSEXQDOoDik9HZ2EJGrLXIVdjGB
         gNf5BFFWk4iMYPiXYSiK75Qdv52T7eYXN/txLmnc/GwzF4CYQarbA4gUiAZXMXC/ykTh
         5qCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW229uvef2hyeLi1tIaN0J6xyKO2WIjSE0j597jCEHFhG8dCWmKcHDNo4VJcHhreYjrIEavbWh4g0XOYVHPj6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzUtrASWR6cYIINy3Ii+WGqlensGiBk1CgI+QHbJrbJONBtA/
	ggCZBFrythCrPfKEPc3YZWzLUm5kPfM5Ar0dD8R2Ch7T42/jolWidSoDzRk1F9CBI1A2cc0e+X6
	Cmk/plYMa6w7Obyszpg==
X-Google-Smtp-Source: AGHT+IHam9G7o+Bp47zHT8wI+vFS0i5PkVHHYzHjKDxZPXVx54N8saOP/ifSLAMey8jYcZc34wHD0NmTuZLSmZEr
X-Received: from wmqc10.prod.google.com ([2002:a05:600c:a4a:b0:434:f0d4:cbaf])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3596:b0:434:f739:7ce3 with SMTP id 5b1f17b1804b1-4365535f498mr32760275e9.8.1734541419771;
 Wed, 18 Dec 2024 09:03:39 -0800 (PST)
Date: Wed, 18 Dec 2024 17:03:18 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218170318.2814991-1-vdonnefort@google.com>
Subject: [PATCH] selftests/ring-buffer: Add test for out-of-bound pgoff mapping
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	aha310510@gmail.com, eadavis@qq.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend the ring-buffer mapping test coverage by checking an out-of-bound
pgoff which has proven to be problematic in the past.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index d10a847130fb..a58f520f2f41 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -233,12 +233,18 @@ TEST_F(map, data_mmap)
 	ASSERT_NE(data, MAP_FAILED);
 	munmap(data, data_len);
 
-	/* Overflow the available subbufs by 1 */
+	/* Offset within ring-buffer bounds, mapping size overflow */
 	meta_len += desc->meta->subbuf_size * 2;
 	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
 		    desc->cpu_fd, meta_len);
 	ASSERT_EQ(data, MAP_FAILED);
 
+	/* Offset outside ring-buffer bounds */
+	data_len = desc->meta->subbuf_size * desc->meta->nr_subbufs;
+	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
+		    desc->cpu_fd, data_len + (desc->meta->subbuf_size * 2));
+	ASSERT_EQ(data, MAP_FAILED);
+
 	/* Verify meta-page padding */
 	if (desc->meta->meta_page_size > getpagesize()) {
 		data_len = desc->meta->meta_page_size;

base-commit: 61baee2dc5341c936e7fa7b1ca33c5607868de69
-- 
2.47.1.613.gc27f4b7a9f-goog


