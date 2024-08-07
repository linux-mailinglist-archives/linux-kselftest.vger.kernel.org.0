Return-Path: <linux-kselftest+bounces-14935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1922494AEF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4984D1C21B57
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2168513BACE;
	Wed,  7 Aug 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln10lR0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D48286A;
	Wed,  7 Aug 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052079; cv=none; b=KUYctiCcf6pXNzZMTJpbr4SAjWckHbny3xQOdfFdZGfcKbeRIkKPIRwyos0oUO6HQzfFqZpLPqOVBfvXNOQ98MMw/QF6F6Ckh8JiTvlISFa2/jXoMUkbI+iuPOa9/97DiXlp5MLIwqJ8ACxiYme96VUppD334a7p6J5kiFb5ZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052079; c=relaxed/simple;
	bh=m+6+3s21JWvrFGmOZKIlinwcjXI9n2iwQDrG59NYnGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWV57Qq/qi81myCIWmebvXGDzr4oWOV0E9/2qJhffx/Hu6+HDFVALu6+CWyCXMoGYnomLmI/c+LA2sg17m1pVfgh2yGCBS5RqbFAM/WPFLKwb/jhUc/kC5m9fAbq7ilcm+y09d9mIZ9txMEgkhDXlINZ8ds4sxbGMZKaVrct9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln10lR0O; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so844835e9.3;
        Wed, 07 Aug 2024 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723052076; x=1723656876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YHqZrgFRcSeikKEA/kzME8bSRklLFuMdC8d2DDD5LPQ=;
        b=ln10lR0OaMAWoKJkc/7ft+dvcx3S/NS6NJI6yrCCwYjsBSZHaV/wNm/0BE5qa/pf+J
         mZ5bMMHppWIJRFjMmOqjWiyoT92lrLq1MChCJOomd7u1aZcJTdRM8N5S4dJpVWz+e0WC
         LI/OCxcuDThD4Lonuv5j+t8MUAGku5TJSpUiQt92WIKzUwYUPnZihHeQ9zWsKa+5A6Gy
         bcCABtzK9rGwAUVj40XWL0xFFYA3h9Wp9ugbgpq1/vtH8hwlTis3oyB67ZSlZR6lvdQz
         bQIRaAGSBD3CHPijHi3MrhGc3Ont8yKCZlExYjQ6ooyUp2vU7jqa+k+Hej13mwNb25+0
         0Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723052076; x=1723656876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHqZrgFRcSeikKEA/kzME8bSRklLFuMdC8d2DDD5LPQ=;
        b=jITz1Gs6MJmJ+YGEuGNskZwztZM+Bfhcjn+R27Pywbk0bLLdDoU/XJSe+j2UxhuYks
         caPMOeOeUZE56XvA+KylMUeHR/rTRM54fRU+ct8fCEETIsaXVNMK89FHdPlX8nS7ZVHd
         kAu+khICa/F/ZQOcbSFGfdZZQuph9sdaOjm9yVr3wXkhbFmrL8l0Z1PMgBPWv1EFdlKs
         d8SAinJtSF/LSFuhKpMNeyRnuUdu04eZtNBjOudktdW1c+mCVpNdIqdanTNKmhq4W2bK
         WriD3cEUfagbaDeoQZQDb+DvKfhEs9a9uzI/tj90rvmHik4nTVnaCAFoz6yrcv+di/rC
         dadQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRB6gvO8WYcnSZkQzE7Ck6JKs1fyrFKvnAY2uYQhzT1iyY6PRq7jSduaF0AQJCt7ywIKDVdZ2a0bOadgRD0HvILFU+Jsff7GSTFAeMaDGa
X-Gm-Message-State: AOJu0YwhLCIw2UcTDIuJPSZn6eY4Zcn0NcbmEiaID75loyTJVh8rUR5x
	NA4aMQYnftaAsmR37m94K7ajiKLetOESiHaEr1MyBzXDjKLa/iQj
X-Google-Smtp-Source: AGHT+IFmS/AEaeni1zhoq5s1dOUNwhEQ2hYSkq/L9eFM/QCKO7k/nvuWUZYrX+Ex/+z2WxcqyNW9kw==
X-Received: by 2002:a05:600c:4513:b0:426:63b4:73b0 with SMTP id 5b1f17b1804b1-428e6b96e50mr128401595e9.34.1723052075476;
        Wed, 07 Aug 2024 10:34:35 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905801f5bsm40335185e9.29.2024.08.07.10.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:34:35 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH 0/2] mseal: Fix is_madv_discard()
Date: Wed,  7 Aug 2024 18:33:34 +0100
Message-ID: <20240807173336.2523757-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series fixes is_madv_discard() and adds a small sanity check
test to selftests/mm/mseal_test. Without this patch, is_madv_discard()
erroneously thinks innocent ops like MADV_RANDOM are discard operations
(which they are not, and are supposed to be allowed, per the overall
design).

Based on Linus's tree and taken from my mseal depessimization series[1].
[1]: https://lore.kernel.org/all/20240806212808.1885309-1-pedro.falcato@gmail.com/

Pedro Falcato (2):
  mseal: Fix is_madv_discard()
  selftests/mm: Add mseal test for no-discard madvise

 mm/mseal.c                              | 14 +++++++---
 tools/testing/selftests/mm/mseal_test.c | 34 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.46.0


