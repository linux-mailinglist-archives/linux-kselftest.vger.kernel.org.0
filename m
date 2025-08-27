Return-Path: <linux-kselftest+bounces-40058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6960B38560
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A594218958DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0A219A7E;
	Wed, 27 Aug 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjO4lgog"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48B21ADA4;
	Wed, 27 Aug 2025 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306074; cv=none; b=ZdJ2ZjStTkxWu4Bx4d6CFPA2OZpfm+M9L96HSTlEasiGqzWz8bQ7aruCVh6+EXuTha21phv0Gx6JH+gAH74JyAYTq0uj/v/QoGvcy57YaxIoL+uulRfbg0ErFc4Cvd9MzH/rOtZy+RK4qYdSS4x+ayNksD+TgC8o0nqF05gcx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306074; c=relaxed/simple;
	bh=aXfP+OjSljCnWXypruMFC6fEBqMQkKs3mRgq8CQv/qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcP65cWS1PF+/yDGb5jJc6mdLd8ZSBn7BlN7nN8Jc4uL3vo041aaexRQIaUKDtrfS//AOzr3UAltUCBE9B2SSuD020LHooG8u1/SXjGlmyUhSToIJuH2WiSUds47r/iAm6BV7f5vNYg0ZHw5Q34/MiYauKp/GwOi3vlbVasEQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjO4lgog; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-770522b34d1so793551b3a.1;
        Wed, 27 Aug 2025 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756306073; x=1756910873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13dITh5qMhTwgen5+ni1BGm3XxaFP16NS352Fgwalx0=;
        b=OjO4lgogRMnVO+MCnF/+Pg3fbVlfYbPM4lrfXRNxJSy2ca8IeGXUn5X1nLc/0xeYe5
         BB7sbvRFKjpRqYVem5UDPKHMdcACTZFuqWiCIFyFtDgdVrR7iztFFMd1XTiHF0Cd/UmD
         vrmkgDW90YMMZ+dMKvSN3w1n7hzFC+c5S+pAvWIrPYxZRcRhGZstymoVOO/Jb4yFvkit
         HAr6yTUvJxvuP94+MyIZDF8V4hyezuEm1NuEeBsUTzd1BKxOww9s6k9ILU31sKZXAtpm
         5GAjp3r6JfTN5x3obQKF8fs/x0BhEzl2asV+dp27Kp459mk15tAdkueW5nhStyWRMye4
         T0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306073; x=1756910873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13dITh5qMhTwgen5+ni1BGm3XxaFP16NS352Fgwalx0=;
        b=H+CanOM+6/5ahPe0FhzEHZP5oyWNqXAhJ4fPV/upOYut3OxSG0TNmXAkcsbotaG+qA
         Gg1cntpDJ7WIoPCkxWC6ZQFV2GdvPTKYdB8C5V7iZc1kHzfWyvza1HbAunAtQCUfnIy2
         McmGUTmYiQymvlnO9S3ouO6Hp3RIjlJiuRVqp87js58eUB1qXi2PA+l0PQXmYVbjUqY+
         rle/JSyw/T539JnnkYKH5SFeeuKAld1Fq5Y1FjSn+2snB2zKMexx0MHcXgIAaTi757ce
         6HZJqAlS5zK60iibpfI81NVFjIpx4xbmNLJlKgVFXiN2gU++FWdtSjNchmRgGGuzg6ym
         R4dA==
X-Forwarded-Encrypted: i=1; AJvYcCVKApoeLAGhGxGu4SA8DKHnGcEKJqj1BVyuOt+owSCumhKXkWM3Qnc8ge+fmVkwGQ3FOxSanV+sdkqXel0=@vger.kernel.org, AJvYcCWvDGg+Tn9fdI6mh1w8WvqpT0pCCpKefKjol3LWxt/pW048ElVRfF8tOtIr1xCvCGAYNFsMQPvC0BNXG4LsswiBL6s3iR/a@vger.kernel.org, AJvYcCXgV5HrtcXe1t9a386NMgLYi6t0XGANVvUkuT094rzimnAS6Qg7Qje0imUZF58XOeothyQLuhdEwWUHo5QjaSAZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWNhYEANNrTL3Co4+GMW1Vzq5GEeLq/HTfIsN9L/yGlTq70SP
	TsUXbR/UsnhgQKCE/jbkmLlvoGEiYlnhkvNFPzXfs+/cdFM+ZZG5Qqzv
X-Gm-Gg: ASbGncv3GYT1jSg4okkRepZ8ZuV7jAP+SRLUJ9wLZKiSX+cynDCP2JTa/z08eJ4jFQs
	8NNetwPy57DoNJ4XYBBy4IfSUBD2ZbvnGzWOpcoiooIgMEIjfSXqlzbr5WvSSSYYQCAAyYX9yaf
	Fn7HzyoFnWBnyBEaWGqte/4ezaJWk4X0aUi5WnFzy8tWPLCAQjukSZ/y7WyEfFhp59IgbPg4Xs+
	DfjmNFkIL7KRdUP49YwHCemT5IJK6Pj+VAfwX9PI6xITuqPeOEe++VuQAZdSc+pYz5SOXYxRJhY
	6x1ib8vR23+tbUMSKXATu0oFPvGiCY0YXtkQT559TcySbQPYz75yXvNCMZ3W+tNYBz3DRNIYsln
	39VNwOY0hvyGMvGEtzypDS9rsivEH0v0MHuMYwkH2lTJVU+s2hW+xziyGxTLpkBl0FpqH6/hp1q
	RYtC53L1So0Kk+VtftvQ==
X-Google-Smtp-Source: AGHT+IFtL9B/8t5NBH9ou3cP/RbYSbdJ+pfYeXe2gkqlkXerpdfCbiLigXMQwyjmc8h7AygyOx6V5Q==
X-Received: by 2002:a05:6a20:1585:b0:243:78a:82c3 with SMTP id adf61e73a8af0-2438facc6damr7647762637.24.1756306072497;
        Wed, 27 Aug 2025 07:47:52 -0700 (PDT)
Received: from server.. ([103.251.57.213])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7c09fsm11626826a12.26.2025.08.27.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:47:52 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: mic@digikod.net,
	gnoack@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ming.lei@redhat.com,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Subject: [PATCH 1/2] selftests: Centralize include path for kselftest.h and kselftest_harness.h
Date: Wed, 27 Aug 2025 20:17:32 +0530
Message-ID: <20250827144733.82277-2-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
References: <20250827144733.82277-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compile flag in Makefile and export it in lib.mk
Also add CFLAGS in sync/Makefile's rules to fix include path
error for kselftest.h.

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 tools/testing/selftests/Makefile | 4 ++++
 tools/testing/selftests/lib.mk   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 030da61dbff3..7c9db82a81e6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -194,11 +194,15 @@ else
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
+# Include path for kselftest.h
+KSFT_INCLUDES := -I${abs_srctree}/tools/testing/selftests
+
 # Prepare for headers install
 include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
 export BUILD
 export KHDR_INCLUDES
+export KSFT_INCLUDES
 
 # set default goal to all, so make without a target runs all, even when
 # all isn't the first target in the file.
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 530390033929..50289b9a1e1d 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -199,6 +199,8 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 # Build with _GNU_SOURCE by default
 CFLAGS += -D_GNU_SOURCE=
 
+CFLAGS += $(KSFT_INCLUDES)
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.43.0


