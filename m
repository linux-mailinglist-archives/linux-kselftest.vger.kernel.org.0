Return-Path: <linux-kselftest+bounces-4164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F184A99B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 23:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EC3290AC9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B948799;
	Mon,  5 Feb 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2zxHlcm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916791EB49;
	Mon,  5 Feb 2024 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173774; cv=none; b=P+NimLU621nqtjO59P3uB4FsYUjE0TUvWlnTdXRR+iGBETgRg5bgNXsBKc2BUXBWj06W1yqgDRE25oZLAFTlRlFglwJWG40zL7suGtD7nQOav8fJjoYJX57B7qg+Lux3POO0Ia0tG1Rosi32uehNKeHhvZk2tWMwQIGEEbtI1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173774; c=relaxed/simple;
	bh=aTjkVj/ZHoE9XkKc3AYHVjvNxlRZrQwmqbrbwBElTkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUK0h4xQh0kZEK3lag8cz8UBS6ZXH1Ay6v5VjpNrvfdj5ylGNnIeBW/zPA4WKHFAbFhbAXlUzGz6BeuclkZIahIkhiXTg3NFCp9lcahiLi98YQTpaAMtpIZtynmOy7dnV5Aq4aUSTfYRRsKbbncC1MVdbBSF4uDI9y5ZU89u/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2zxHlcm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6869e87c8d8so17947896d6.2;
        Mon, 05 Feb 2024 14:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707173771; x=1707778571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leL/vEiB0VeH8ZIF97IARUVmsuNbNROoZaGIt1HbTGM=;
        b=h2zxHlcmbZ5BSW+x9t5GCDGWtx3UrQQpvPS06+4ycEdvso8t3mDgbGDE7e/m2FQTyP
         eo2GwzY0p3y6IEiGdoqOAp+3IwCcJexboXclaWQgHq3ZYO7oM8wbNmjq1rkmXqU/cFhn
         OqT5zHTQKU5k8uu9De/ew8U6xV6RGvsHtvRKEvllj4imbacsGtE7dvF7v7gMSey088XN
         cyh8bXBvl7vx2Y6G9alfIOerXUsJ9je7wF5qAe0Y/tuYmYA8u6AnFGTQ5SUAP0R1IJEM
         AZJkyk1KtL4TY+fgmHxKnyIcPB20+IaWihPhJRZ7P/z0boIDH2XxO2y+IHyiPPYxMWF+
         F3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173771; x=1707778571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leL/vEiB0VeH8ZIF97IARUVmsuNbNROoZaGIt1HbTGM=;
        b=cAOkEPY/QUimvBKR4Iqf9LEUBPFHR/PM05SAgk+jDJaWO1fw2u0ifXpOQ5gtNePAq4
         srN+5bArHlRKk3l3ED4nsik+IznICY6m2o2p7E8p05QXPjE261sOYZkS4L/KieQhsJbl
         88q6BaQPa0h5y+5k0BksN9bg/SLGghK7GXeQiDhsyKoCfGw/NZ+opO7Yb6iAvPQ4BZ4N
         3h342FK2n3Jo00gIaLKscCm/QNOMFqJCRL5FNeiKkUQLD0R7zJMmcW9nC+PskVMdLxjb
         AnG1dm0wrdk2ZKl/vlS803bJ/lMI0HwGstLIZb59gcOYnflDAMfJPMut7o7JAZEovcwn
         W8lg==
X-Gm-Message-State: AOJu0YzhMnpZwvXRRvQ3sR2IXDD2psQSLYttWapqz7wT3ISPsIX62h5b
	drx4W+ZKuXNwTzmWst8Vx1zK/rile82Fb7221661HAinipa1gs+O
X-Google-Smtp-Source: AGHT+IESv97Kd8go2vQYFQli2hhUNviKbARAN2odGnIcieOptqRe4kVgIWNQc5zdOUprmXtRMEzg3Q==
X-Received: by 2002:a05:6214:19ce:b0:68c:930e:6f49 with SMTP id j14-20020a05621419ce00b0068c930e6f49mr458443qvc.36.1707173771373;
        Mon, 05 Feb 2024 14:56:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUCB274hPBtIag/AKoEk9o51vlokXWUWAxRE5V+Cz4My769VWoTejn2B1RAUCKKHbwcPLGoh+DbFwmU6KsfZgCcgH0wRnXWCOZngGJD7cmcs4vcKLVE9sTY6JFoELRq2eYGkxocLIj2as554uq56BmopBHWg5x8HAhLEaBOFRtdI4IRQDB6ccDlZfNGKLjtJ1eSpUn+JZ62iooCUAeriwm9z+w5PdcnTstjiBFbtcjmH+3giaUqKCAjZ9hOJeJF10XqvdB6jHHxjK2rrhGU+IKj+e7U0gQXMgTYkhNC4/+l8uI4oE9Lb4ZHnfpg3zOjQAfpk70OaOK5z464WgSLo9zW7cGhZBBAH9YCl1DYhGox66WdzafeB10RxjBNMUMi4Rawu+mYI0t6VUsMLM2mRb4=
Received: from localhost (fwdproxy-nao-004.fbsv.net. [2a03:2880:23ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id e15-20020a0cf74f000000b0068c4b445991sm428451qvo.67.2024.02.05.14.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:56:11 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: riel@surriel.com,
	shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/3] selftests: fix the zswap invasive shrink test
Date: Mon,  5 Feb 2024 14:56:07 -0800
Message-Id: <20240205225608.3083251-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205225608.3083251-1-nphamcs@gmail.com>
References: <20240205225608.3083251-1-nphamcs@gmail.com>
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

