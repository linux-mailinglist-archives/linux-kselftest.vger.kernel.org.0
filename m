Return-Path: <linux-kselftest+bounces-4163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351B84A998
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 23:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0372C1C25B9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 22:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538E53A1CC;
	Mon,  5 Feb 2024 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj+nMklA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61DBC148;
	Mon,  5 Feb 2024 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173773; cv=none; b=Mi6zBa46B07jCD6SUJyN0gfoHo+Oixk7aT5X5CLJntL/PJaPL03g9yW9p7757pz2hO7tFdEApI3bikWRBMk8Hk5GAVF61vdBPF91vAzf24FbueLVyaXy8lNIxkmfuBYCpj+a2+IJSjDWedNa+dw8tjnRtOCo1I9DgmZfxyk11zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173773; c=relaxed/simple;
	bh=UAPFAa2YoR9r9pULmKsHh3JBLlD3Aq6ViNtLGWwsu4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXuof2HZbJR3kH7CvD/wb+E4/f3YoTLiBbaZ3Kn6mDV9pwa4MamLsBIqv1hwXizVpIW4T+6pEfQbTszc/tZ4pJ+cEEMi4vyrzFW1BFv8ulIF7hrvxPVJPFq/BQsp/bSegP5BcYNyY08UMZqRLKw86FkkYhSeTqswz/5WENWe0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj+nMklA; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-46d2dff740dso355131137.2;
        Mon, 05 Feb 2024 14:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707173770; x=1707778570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dsOQxIuZglfzGL/UkHixra2YxsOVoucMj4slNXKYQ0=;
        b=nj+nMklAtRAissrfk62n4MZpM2Ko9rB5NEP2SSxQu1VlR8ujwjE97EggjNKU/Wg8RD
         cSC99BV0m5qNHFvekvH3iWROae3PXbwQKMcuGpVoXTZ2/2ewfzWQt8pHL9bNSWWqp+7N
         /9giQZn/AfxmQE32Z3xbkqb07fTXg9HvkNBtY7zdnoGoDZwy82PMehnxgILT/LCKTqzB
         ZXQebmqP/+wHhcS5XApFGjvuFIGjrvvRMMkgfuWGUF48ThvXZABt9/4BqCM0LV6Ns96W
         ondR6LBm4wQ34Qvl8LI76d1EuowYWoSDrJCDQa2ktC88qsbP7nBWLGr+UT6uRzZfHmWR
         Mk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173770; x=1707778570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dsOQxIuZglfzGL/UkHixra2YxsOVoucMj4slNXKYQ0=;
        b=G49EihBdrlNvwwK1oc/OgwH7T2gFqcPIdLD91JsmnIi/xAohVvKfyfWT7MoYG94TL6
         pX2zmv+qv6UvM9TRy9xVuxwcKfLf+R+4qIXNx0PUOcm468SN9EOsUCeUyU+ZiCVmOzfH
         wz/fAlizL+UF15nfSKK6a4IwFG/TKTHD/2drH98UfcPIJzqJgj+p9XKK/RZJEyGZy5fT
         UA0kYBa5yfa8cGmPMGdrc/DHFWuQuoghnTzhc9TmFWyVflh7/mnNWdi40J9XxoVOAFi/
         rdDqzeL4wcq/XmabTqofSsKsDDxTR0yNIL3P7ZgaIDvUK7TE8e+tbLr3aHDd/8SCjD+A
         OWqg==
X-Gm-Message-State: AOJu0YwK5TCho9sfSaoiNBMUFwoyS5KUOH85Xbx+bxQzvIPG/Pize8ux
	IW41tww8aWq9a7kSL8oXD4PAcb/wMRxYV//Yb0U/FU7PjSnfJzHf
X-Google-Smtp-Source: AGHT+IFV1B+G9o8CvxcMN6huuwce6++oo07ZBBECnU4NSWU45WI0gVmfqhod2IRB+zTWiuirM2ArzQ==
X-Received: by 2002:a67:f943:0:b0:46d:1a45:fa17 with SMTP id u3-20020a67f943000000b0046d1a45fa17mr297997vsq.7.1707173770466;
        Mon, 05 Feb 2024 14:56:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXv2T5epHhjVpbPo8Hg+vYMCZlBiki07P+Chd3M52zwZTeQd1rAFiYC5lKFN4O8RLtJxJOEJ3QIHY4vvZjUMU4jv3OAOraB6/NpWN+FMzZY3vRcmuacj4pqGleuweIfJvM/dNZcp61u5lSRJd8ruOUgVyVhFmmAaCCovDU8kXn785oiLgAvM/pnvj3wixwysmjfWA2CSL4GCnJTfczW3SID87jJVgA376FhH81Ofsm2lb2GwLownGFbb2iniL9vd9BjVYsiCNj7lL9BX6Lwl5vDbm74cijKrF73E5lL898jM96kPHExYDMMZ3ht5/K3X7wqfYmbAMXkqS+Ak+Vl5kc3QK2EOJ36MzIDu6SC8Zr12yEKKKd/Yo3quldFrKHOnAC7Q/5ACWD7sEubRGXLIIo=
Received: from localhost (fwdproxy-nao-006.fbsv.net. [2a03:2880:23ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id mu9-20020a056214328900b0068cac993878sm424486qvb.115.2024.02.05.14.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:56:10 -0800 (PST)
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
Subject: [PATCH v3 1/3] selftests: zswap: add zswap selftest file to zswap maintainer entry
Date: Mon,  5 Feb 2024 14:56:06 -0800
Message-Id: <20240205225608.3083251-2-nphamcs@gmail.com>
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

Make it easier for contributors to find the zswap maintainers when they
update the zswap tests.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6527850f24d1..126090f0e418 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24398,6 +24398,7 @@ F:	include/linux/zpool.h
 F:	include/linux/zswap.h
 F:	mm/zpool.c
 F:	mm/zswap.c
+F:	tools/testing/selftests/cgroup/test_zswap.c
 
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
-- 
2.39.3

