Return-Path: <linux-kselftest+bounces-3708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E68415EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 23:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3571C23256
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D079524B0;
	Mon, 29 Jan 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvTu1toN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E74F5FB;
	Mon, 29 Jan 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568347; cv=none; b=n/GvigrxkfzOi8GICvwZRDSrrZbR+EFyPKhI7fQ7EN4sfSKmdhwkQgIsKy6AAzx+HQMcs8pMAyR0F3ztM5Z4SM8ugcpOtUc3uEbO8pgsJrL0MNbxE5sgetw5g4H6UJZjqqxlbVhzi+aBfpAQXE60XP8tYldzF0b1b9nmgi+ovl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568347; c=relaxed/simple;
	bh=BLJeECboVnIswmLAF9bTF1fqabzkh5aBsFYlz8apIzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IE9DIMwpZ5jltMuL4QTxugratdi4NkbIzmvACC3qMsUNauoZubgZgkOcsOf//4vl3+GXAkVz/wNY+hUEk/xtMqr9UViq/qcTEsnP97KgnFFJWauRlknUkcm+Shsq0yNVJxinqEcoHJCLgM8vhE0+3fbl/+Ujks6s+r9CnKs9/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvTu1toN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783eb452e01so186888985a.1;
        Mon, 29 Jan 2024 14:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706568344; x=1707173144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC8jdsm04mIqNXpi4c3WwQu2utHfwjKvoXOteQVfINI=;
        b=VvTu1toNciDaS6+KyVUHcjuX5yVJwF3cRbYcqWnGlkf4UT060mqdK1oqzPycj+mUPU
         DnPpy+J6FjiBsWkBejoeIc7AVyBmuI/wSuaQWwELb2EP8ZO+Wg+zydNs0ZVH8kOeget8
         E+GFGbuJ3Dft8v2psA1igP/Jlm8V9OUtKAqjMn4SB9ZnMAYdNtWe2mQ0OIaAaVZ7O0Se
         JwuBPDC1FIsgQUrMo7iX3l1zTjudJwPR5l5t94lywBMT/1ghcrHBqH6Mq4Iv1CSBLiJE
         VGnNKDGQHMc5Jz6IDN08C+po0dGcNW6gx2+okXqHwCI/obdtPSsLnb+hcG/xoQQNiGwP
         wLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568344; x=1707173144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC8jdsm04mIqNXpi4c3WwQu2utHfwjKvoXOteQVfINI=;
        b=Q+xkE57WTd7eLrHsCTQJtzEwKVIdIL3KKnfq9wplXmTFV7wBsoXHRtnvcbuc0fIMjy
         hvVp5ZopF6p+gJW+ZZobyecA/gDnWcDlyQpbluHvhZ0yuZ92aaMVqf7GgB+3TxAIRFPj
         l5zdJ1zN/PQods3mSCqGDUDfYcRN0gd2nwYGOHbEg1NecuqkD8aWVw/uBajbN5H2uxAN
         Swx2TnSxJEm+9w8OMEEckMIR3TZ9Ae9c4nXKdO21LAQbEYSPNFjPZFVW69tcoCGm6drV
         V88aSB1VFa/jr7mi4dG4Rx4RupvjHJi5oh1Og0p08hkuWMw3kXRA4vUzrZyNx4weOZio
         CGig==
X-Gm-Message-State: AOJu0YzJ5ADosZiofTROr4IxdhF8Gtcfn/HnkcLYMDANwy5He+0xOSe1
	/RrpKUNqfbPjgLCh+W5OBZfvBA2o1XtUPRKzOz6Z+39Ks8rzEbll
X-Google-Smtp-Source: AGHT+IFHRDAjwttfHcY6DCVP5F3AhKrbmlzkwgYdhBdCAoj0RflAflHERJSdD2h9gDthZsxod44wkA==
X-Received: by 2002:a05:620a:318c:b0:783:3cef:c885 with SMTP id bi12-20020a05620a318c00b007833cefc885mr9677984qkb.57.1706568344471;
        Mon, 29 Jan 2024 14:45:44 -0800 (PST)
Received: from localhost (fwdproxy-nao-005.fbsv.net. [2a03:2880:23ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a134700b00784087c7f21sm269076qkl.84.2024.01.29.14.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:45:44 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] selftests: fix the zswap invasive shrink test
Date: Mon, 29 Jan 2024 14:45:41 -0800
Message-Id: <20240129224542.162599-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129224542.162599-1-nphamcs@gmail.com>
References: <20240129224542.162599-1-nphamcs@gmail.com>
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


