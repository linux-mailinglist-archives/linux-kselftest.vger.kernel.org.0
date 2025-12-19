Return-Path: <linux-kselftest+bounces-47748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E808CD231E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 00:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B4633014139
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 23:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A5C2ECEBB;
	Fri, 19 Dec 2025 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+Ht3dOV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816442D6621
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 23:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187510; cv=none; b=LvfdjUhUCy3F76WLOKNyuzwDnZ7tzO79t4MIfsx6LdlC/7HYij0ZzqnPs9vFtWHlpTQzAgNMZOUKNWsCH29JRIJdIKg0l+LAzRKH7OB2fww26hwKUicjjfg9CHq+NLxf3WrIMxF3cJiUZhN0Js31J0TWaDwaO1wdhTg1Vx1vlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187510; c=relaxed/simple;
	bh=/+AGKRNSS+uF+0YmBMyl5tXf6XXogWL5c7gic6FqdHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ankP+zPo/Tl2u6oyJptnzCfyFmGZR9Eie+QHChzdcOVZz4Q87UbfMv5oF+OtZwXY1zA3QlJyXTZ3M0WrtEwLkIsykjxyWu7XYE9ilDjZnRu5Fx+d2OmHX+tGSKXnvlf9rEvXbnYSq9jS2v63gnLb2Lo6qWKcBJMOfkdlNfAspaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+Ht3dOV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7dd05696910so3453601b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 15:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766187508; x=1766792308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9QFtmNn1fSYGFAaSlaEhnDrHjK6Ba3UZ+o+JdNc1Kk=;
        b=J+Ht3dOVdle9BUbBneqlfOvUx3tAhOqNLMF5nMCIMQ+tSK1AW3e/pjXkc35hqQWs4l
         gTu1QPYQO3w8+53VaMcRy23pp7M/I2agafm+dImkrocPWsaHXmFMm7qEztj0UvN6CXUb
         rFDJrtkmUCmiJ+9kdsUK0YRatwTxtH8+yOllOiH5lUM4E3XejdJaHp3aqm8QhsrVtkMc
         bKaBHddaFbVKsRQbXLF/jwTWbyGt4Pn6X23WoJD+ixGwKeEhb3GekhxrvHSagL/KcQzc
         cvRyR713J9o4VX0aX+jQ2SlskxxoQFb3nNFzPAkf3SQiAspeoBBcHFjc4T7I0FyBnnuS
         TWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766187508; x=1766792308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9QFtmNn1fSYGFAaSlaEhnDrHjK6Ba3UZ+o+JdNc1Kk=;
        b=cjg0sxnQ4Q+ZIWrlVizAFSmJPmHVYJ5LRih8n10n1c0DO84XYYT1RUtwfAvClgjhdj
         keOTI4J7V9RvoBKmGjCdpOsWl5EOucgMq3xhkzXhanYEo5eoLCVjXJ/gGGkNp6INVSfr
         c/bLmvXRz6X7Y9Td2Qu9yCAVBta6rUnaJ40NUgnwFL3lXUHVnBz3F/jEaIwS+sqS4oS+
         fmnz8ZIF6Tuq3QB7AbdkQZIneifOqYdYlFeb8TLiv2P5msJlI7tZMDatukGnVsq6A/z/
         vupyMf1ehJr8awF5AKTMYvY7rUvBEJZN+2TRjbgY2aThpSEnA/gX64bY2exzGsSRjMe+
         q2vw==
X-Forwarded-Encrypted: i=1; AJvYcCWxGnKChhGJh9o6BlROUB4TVOhGFr6C4rjWeajzV1KdDH+CRJQRzwwSOHDRz3H2D2AuTHXVfjMhznUniBnmgrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNuIn81h058c2OcWe/mqS78d0LDs6zRkPk1aGZZRl/kr5Bd/+
	MR8b8iAwpL0nPJIJooe7WiM6nLEDly5EK1C4jgKs5ogH+wlid8xijtMZ47M8PVhg641udsTUl8n
	E5INA3oW1Lz8fhw==
X-Google-Smtp-Source: AGHT+IED2KQiUi/cz01nSHrPqB0DVKiLe95LbUVmtbI/s/CFr3dErQCP8IrnneW5VYeTPjnU60u3FKnJmJnaZA==
X-Received: from pfj19.prod.google.com ([2002:a05:6a00:a413:b0:7b7:b98e:7a9c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1d27:b0:7e8:450c:61c1 with SMTP id d2e1a72fcca58-7ff66679547mr3739825b3a.49.1766187507834;
 Fri, 19 Dec 2025 15:38:27 -0800 (PST)
Date: Fri, 19 Dec 2025 23:38:17 +0000
In-Reply-To: <20251219233818.1965306-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219233818.1965306-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219233818.1965306-2-dmatlack@google.com>
Subject: [PATCH 1/2] tools include: Add definitions for __aligned_{l,b}e64
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Matlack <dmatlack@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Add definitions for the missing __aligned_le64 and __aligned_be64 to
tools/include/linux/types.h. The former is needed by <linux/iommufd.h>
for builds where tools/include/ is on the include path ahead of
usr/include/.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/include/linux/types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 4928e33d44ac..d41f8a261bce 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -88,6 +88,14 @@ typedef struct {
 # define __aligned_u64 __u64 __attribute__((aligned(8)))
 #endif
 
+#ifndef __aligned_be64
+# define __aligned_be64 __be64 __attribute__((aligned(8)))
+#endif
+
+#ifndef __aligned_le64
+# define __aligned_le64 __le64 __attribute__((aligned(8)))
+#endif
+
 struct list_head {
 	struct list_head *next, *prev;
 };
-- 
2.52.0.322.g1dd061c0dc-goog


