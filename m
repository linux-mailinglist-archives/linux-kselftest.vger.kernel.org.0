Return-Path: <linux-kselftest+bounces-3917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4087844FAC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 04:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D11C24F29
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 03:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872703B2AD;
	Thu,  1 Feb 2024 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJlGVuuQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3993A8E3;
	Thu,  1 Feb 2024 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758043; cv=none; b=Mljlj10a1MQ3IIh8aZKd8yBgLFHGCVGbSLr0chak085wYwiIXC4tMsff6U9MDGIvkVji419G4HI3HAT13HfIryiVlHoWf9LWeU9j94HLoUXyqUmV61rTFpD3jxJBJ4HIZiwv/gxfrej3E6rZ33cZm1UARFAYRJTkLmaK9BElKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758043; c=relaxed/simple;
	bh=aTjkVj/ZHoE9XkKc3AYHVjvNxlRZrQwmqbrbwBElTkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lW8k5VI6/4edqQLx5uxr7cgsJAAMXPMoe+Lkd3txMWa4efzHoxRkWR7FgSCzejq6c00EN2r+kVk35qCwMBIQPPJ9mHwhgaezV3afR192v65nc1aha7KlBC0aO4XvHy6SSxZfzESReT+WWx1sKCjg6cB3F9IyQb8apNHexOAktp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJlGVuuQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a99cbb4bbso12515951cf.0;
        Wed, 31 Jan 2024 19:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706758041; x=1707362841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leL/vEiB0VeH8ZIF97IARUVmsuNbNROoZaGIt1HbTGM=;
        b=NJlGVuuQZIHh+6e6TErOcbsRO6ygggxl9zgmJVSSjicqnq2Y73IN7U4RJOXNeRZFt2
         vA0Vn4PiSdZSqs8ltB2w1R7tR4Dl7cbT2FF83KJ+UNmC+dNUVny1srhN1jRwDTBd5QXo
         dLvEGkvkVV4BlJQZ0XQwAPPJZqxhmO4D0LltyXqKBMscUNyrHvhShe49efmDjiVpzphe
         0zbjl2FzHxI/2kMSxLr4ehJLmsyPo7/J9+bSndl7lRmZ+mRcxue03itcFyIMF09MM5LV
         RkESOx8FNQ+wDMbZ92To081zeA4SXHm9N9oZ4Y9o23Mr89fnBi9Wy4ExG3Y2tRNgxoNI
         ebxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706758041; x=1707362841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leL/vEiB0VeH8ZIF97IARUVmsuNbNROoZaGIt1HbTGM=;
        b=k5zmCCwtk+wfeHbrAi7J2Wh9fk0uQDFitt/ngWDmaj5DvltMRnPQN7RM43G0r0gHgS
         56oOJ3njF5TcFqD0ij86S4wRJromM9dHvKjFuIl2ts8946H/beR1iKMPpnisSJ+hZjum
         /NcJJi2NPXn7WexWVNfBMmomw3BD8qByvw9K96MJlaFYM2FizZoI7Zb9wHsn66gJ7WIn
         kbUm7oPKs30Se5qmRvWQuIDR+6z4JVZAEWAhwVqCfrFdrrMiUOdAcD647VI5oqLpv1WH
         p3oNjBs1FfguGVjn6igDSQITtELXOOTZEvJU/iqt4qQT86WoppvIN3hHLxnW9eQXE8tJ
         8sNg==
X-Gm-Message-State: AOJu0YxTUVqvdM+UiDM7FZPHQPiEQ2ICZZCuLD/xjm9nbJwWuFY//jLl
	pvrEwz+7Wl6/GL6RQjS4vSKRRJ1URkl3DX1vTOzADvgWCINsAuec
X-Google-Smtp-Source: AGHT+IFqcvsUMZYFuYor0H/CUk+pPFiTZOgLITK4N4LX0rCJkB0og9Dc0BMcAnEw/g7377tApIxDQQ==
X-Received: by 2002:ac8:4e91:0:b0:42a:8be3:7bf5 with SMTP id 17-20020ac84e91000000b0042a8be37bf5mr7486386qtp.9.1706758040803;
        Wed, 31 Jan 2024 19:27:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUhQZ1N2tT05OGhr6lKJZ4MS4C5p6jdBy+kND1VAX4ngoMA+XrkdOs3Jg744crNHZzyvCprOvmjiuLtJzz3s8TbHfOILCF+L4ryeOSPQNu1G6rpAVnaTf5EwIk1236AKtJhY9dC5cAKJbkFeqzpU/XIe0SUvDzU7pGsQ6VHK6SWcSVXiGapUjqUPDr1AQ7m5yFVtOrXzWxAU6wW6GJDLOBsozLdNn7sOsPvRXI2WvFx8mYTD+AAqahUTV8tuAj/VA+zy0cKRWOt7vHwyvz+8xgfRQ5ZdbMFJxtZgajN7CPp/hlvE5+iuDy9xqx5rLrNZDIRDVEVi5j+zRX8ITtgcn8lbyXh5vY/HL90aQ3r/1lnDwTOzCt/
Received: from localhost (fwdproxy-nao-008.fbsv.net. [2a03:2880:23ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id ge10-20020a05622a5c8a00b0042998676bc3sm5570137qtb.43.2024.01.31.19.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:27:20 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: riel@surriel.com,
	shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/3] selftests: fix the zswap invasive shrink test
Date: Wed, 31 Jan 2024 19:27:17 -0800
Message-Id: <20240201032718.1968208-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240201032718.1968208-1-nphamcs@gmail.com>
References: <20240201032718.1968208-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zswap no invasive shrink selftest breaks because we rename the zswap
writeback counter (see [1]). Fix the test.

[1]: https://patchwork.kernel.org/project/linux-kselftest/patch/20231205193307.2432803-1-nphamcs@gmail.com/

Fixes: a697dc2be925 ("selftests: cgroup: update per-memcg zswap writeback selftest")
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 47fdaa146443..32ce975b21d1 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -52,7 +52,7 @@ static int get_zswap_stored_pages(size_t *value)
 
 static int get_cg_wb_count(const char *cg)
 {
-	return cg_read_key_long(cg, "memory.stat", "zswp_wb");
+	return cg_read_key_long(cg, "memory.stat", "zswpwb");
 }
 
 static long get_zswpout(const char *cgroup)
-- 
2.39.3

