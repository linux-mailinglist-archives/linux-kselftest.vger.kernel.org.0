Return-Path: <linux-kselftest+bounces-1226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C45806568
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 04:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89E41C210A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 03:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06B86D39;
	Wed,  6 Dec 2023 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+jSVlyg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C321B1;
	Tue,  5 Dec 2023 19:06:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so355592b3a.1;
        Tue, 05 Dec 2023 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701831989; x=1702436789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFqdRV1ZW0M8rAbEJjYRvV1V6gKLYdN+AqYOKj6MPJY=;
        b=B+jSVlygPKFmJxhkHsTuAhJggjFSZR8EXHiq9RfrKutTOtU+YMHtej8q4qp9bacaFB
         ZuPrwjPHeTfFU/IZUfg3COrOyKOg61o/8QJviQdy6vxD6Rt/bauYayjx9nxaLVwMFm1/
         ErInjqHzQ0/ldoL80Hwd7fb6UBCPR9wm5MlKmgSS/i4l7uXr3dMUVfoJc5lxxfYOcMUh
         X0W6JU8GUS4q0KeXmFHHZWmUlfTcfnjxcwLM89zOba0ogfLQxcz3KJVJB2mV3ZNd29A3
         5bxumwZiKwXQBTC81fX6SMOYmOrACJFQubTANafy5c1f7EQ0tqU4j0DpUX1HnYnBIZZ8
         P77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701831989; x=1702436789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFqdRV1ZW0M8rAbEJjYRvV1V6gKLYdN+AqYOKj6MPJY=;
        b=MiwVhu2F7qxliOdE3C+kPlleGb+ncDpVSll85pI5vXtbxEvJ3G6XMLI0GvunUdlyee
         T0Hz3t6W2UZ4O6cn5PS9h5hJfWVEyTIbqNztLqxkyoXb7Akqa5KNeCbBT8ERekaZkzQx
         y+Jk8lb0VIVBqW70bHt+RflBcdfNT61fW2sBGquwWc1HJR5/XGWFzOhfcy9ovWj2oYSy
         q7Ul5wZrnfNHTz5p9vgDsKmM6caLyf3bTgjOgMNr/x+FjenAv6Rf+SBL2K5cq13ArJkD
         IqASSzim2SiSx+BxLq5AzgnJM5kBx9MaO5T+7c4NovHcL4c3jjZzVuabFbpWw4FTGsEe
         j/WA==
X-Gm-Message-State: AOJu0Yx8TkGWtFZ8VqOHQzz/l32D9TUTY36/ppimPd73uV3pPOaRitr5
	2Zvao9vcBnEeD8TCxjr3Hes=
X-Google-Smtp-Source: AGHT+IGBoZCkSKCte4hPLC4miUAxM58cI8sZaJqLaThu4IsULouorgHiCn1grFaDbpAaRZRcYh+9yQ==
X-Received: by 2002:a05:6a00:1f05:b0:6ce:63d8:3b61 with SMTP id be5-20020a056a001f0500b006ce63d83b61mr260478pfb.26.1701831988596;
        Tue, 05 Dec 2023 19:06:28 -0800 (PST)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id q11-20020a056a0002ab00b006ce939ebeacsm91779pfs.166.2023.12.05.19.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:06:28 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH v8 3/6] zswap: make shrinking memcg-aware (fix 2)
Date: Tue,  5 Dec 2023 19:06:27 -0800
Message-Id: <20231206030627.4155634-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130194023.4102148-4-nphamcs@gmail.com>
References: <20231130194023.4102148-4-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the pool's reference at the end of the writeback step. Apply on
top of the first fixlet:

https://lore.kernel.org/linux-mm/20231130203522.GC543908@cmpxchg.org/T/#m6ba8efd2205486b1b333a29f5a890563b45c7a7e

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7a84c1454988..56d4a8cc461d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -859,6 +859,7 @@ static void shrink_worker(struct work_struct *w)
 resched:
 		cond_resched();
 	} while (!zswap_can_accept());
+	zswap_pool_put(pool);
 }
 
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
-- 
2.34.1

