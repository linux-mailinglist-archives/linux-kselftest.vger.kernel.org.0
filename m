Return-Path: <linux-kselftest+bounces-41200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADE7B522F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 22:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7975871BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 20:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF99F303A3C;
	Wed, 10 Sep 2025 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSUwoiKc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0953019AD;
	Wed, 10 Sep 2025 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537178; cv=none; b=Bk5DOFJuDMMsdsBxvRwViRxUKE0xneaBLidncokGqhhK09fzIO6C8EaAMcW23PpOuPIS7mA/ah+tbX0M3MIHFNMnCZci5+pXZa6tfOckwfS3M6SLn4DPLqC8jvODNsUfoZjPkp9OP9C87umvysd85sgKJoieqaVgHP0qvrH/OGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537178; c=relaxed/simple;
	bh=3jUJ7yRAPvTNEv7G8uUSApRLe1x8V8/iVjdKA8ADmx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbkFKgSuhuZ0f06zLoDafFiVTLZvM4e5k7Ptj9mVL+Xy6xfvJvPgFUXwMHrDsx7JmmAu42umjM7hCd1lD4FVRc4XT/kYgbmE36KwW/KWXXZKHxWw71ZwqMGExBFG+bALEF5DhDSTZG04Z3Y1xzYXeNDp1/7jC1ddH6CV2gUOnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSUwoiKc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-81f9cfa70deso2500385a.1;
        Wed, 10 Sep 2025 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757537176; x=1758141976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdPfGCbmStLnf7OkwFRjoXPyuHAb7oGF5r4POmSHGhY=;
        b=lSUwoiKc/uUIRxj+Kx3bwrZ9VGHjIqMmCXPmEtAAq7ex3wfoknlssVj8RzTGxg5B8i
         peQlD5duBlHDzgZF5LxYPvLXuFy/DgzcXw+YaTrgMjwyAClU28fSGsAPKmBG5z37Gmb9
         JRzNM81K+gZNl2DGBEj2T7hFs6EbqWB6jW62f6XhSED8eK77YkCWpHcDvhWoG1nE7dvM
         zzN4fJdbwmELsrmxWpT7po5SOiOmVchGoVpORL+CY/np0rf0DnJJ1dmm1Pnh1sqrQJOH
         AmKmzlHyW6k3WvJxL89mVRL6zHTw18Dl89ddYB5NhkLwKMUqoDMlPeg/LgWGzEhXRKho
         rQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537176; x=1758141976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdPfGCbmStLnf7OkwFRjoXPyuHAb7oGF5r4POmSHGhY=;
        b=h5yRkUh3go/qaBzUak77e3HxixGMXEjlCbbHWWi3dDmSCVtK3aqes2WwbeL7MgG02p
         AM8d/Q5YqPuWV0bPum77MOGLscL4FFxEZ8889KstRfyMwWSAcxotr7DmV648ApcHqWBK
         YmIAG1PWpMJAlUJ+uL4GprYXs3NDIaTFt5tkldzooBxmalI13nUSxgFBF47gcU75WZMp
         kqFWsUCfc6VDhjh1Gon9hIjDzAA6i/5FrtTYlosORRW15IToyZQWI/F6INbiLMwrUbpc
         pC+iIvUFAmk/+jWss4A5CRrC0gvSqr6CIwle2H/Bfgp+u8lP8QeUIRVHKWUq369W5fhy
         tGXw==
X-Forwarded-Encrypted: i=1; AJvYcCX8iU4pBEmm/GHC/LtWdUILKc/EqdVgWBS/4iLlA6DAm9Vbr3Jw6x4yMY7Zp4KhZ0PqTRiBRzKhxFQ/TW0=@vger.kernel.org, AJvYcCXSR/hb5aLbuy0a9MJvSRtx5OMUviOfVUUOrUNfbeNmTfzQ2eVHbTdzgY2M9NaHJc3xSX5uJiw+cY9sj4kfcZwQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHYNvUWD+JEFCeMVgHmd7mctjdFpyaCGronCGrUv6s0cVdu6h
	5QreJaIDfa0wmISFickXJXZ4/x6FQOhK8eTQw1f5BQJxMPsnbUYfPjDQ
X-Gm-Gg: ASbGncvIhH+h1nAMocdYgBj2tP9dFfUPfLtU1B+pf04gD/iNS5fje4eGQFB5xoAKrzp
	R3bpr33aUzpl76P8nDg2Dg7iAIhzhRVgYy9QHEROyniwVd+xwgiFYVQ73uw+BiQtWj1nRHkNYRB
	m+7QXkl+d2fs9mmlbU5k424Ar18xOT2I85IaZMs6pGTIBB64+xRim2apPJ+fm1LG/nAWAobV7lB
	b387L09L6qC4G3MMUndobrLT4AKXXe9U0jNtGVklI6Jt6P9jp5oSX6JjBibuC2ZppeENQrvqUGl
	xTZtBMs8txLT0L4xx/OU6ZZc/CmuX/7fYjdYQIfDtkwKvcdWCR/yP8bk1FrSlH/afZIXevWNoV5
	o48df6LGc9KP4CIecHXs=
X-Google-Smtp-Source: AGHT+IEyqefIg2aIVeybWhllIAFyMXyMtJhBmm1X475rnhW0Aevfer0/jPOsC0mHTu8niZEnKw8P6Q==
X-Received: by 2002:a05:620a:4624:b0:80e:f187:7fd7 with SMTP id af79cd13be357-81ff74afbe7mr152223085a.36.1757537175991;
        Wed, 10 Sep 2025 13:46:15 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:5::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5e5c0079sm351700385a.43.2025.09.10.13.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:46:15 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests/mm: include linux/mman.h for prctl_thp_disable
Date: Wed, 10 Sep 2025 21:46:09 +0100
Message-ID: <20250910204609.1720498-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MADV_COLLAPSE is part of linux/mman.h and needs to be included
for this selftest for glibc compatibility. It is also included
in other tests that use MADV_COLLAPSE.

Fixes: d9c7ff4dae62 ("selftests: prctl: introduce tests for disabling THPs completely")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/c8249725-e91d-4c51-b9bb-40305e61e20d@sirena.org.uk/
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/mm/prctl_thp_disable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index feb711dca3a1d..84b4a4b345af5 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <sys/prctl.h>
 #include <sys/wait.h>
 
-- 
2.47.3


